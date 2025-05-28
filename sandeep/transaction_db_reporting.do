<?
//this file will be used for transaction calculation like date calculation,fees calculation,settlement period
$data['PageName']	= 'PDF PAYOUT STATEMENTS - Fee and Payout Transaction Table';
$data['PageFile']	= '';
###############################################################################
include('config.do');
############################################################################### 
//$data['PageTitle'] = 'PDF Payout Card Statements Transaction Tables - '.$data['domain_name'];
###############################################################################

//if authentication is not valid then user will be redirect on login page abd access denied
if((!isset($_SESSION['adm_login'])||!$_SESSION['adm_login']) && !$_SESSION['login']){
        header("Location:{$data['USER_FOLDER']}/login".$data['iex']);
        echo('ACCESS DENIED.');
        exit;
}

$adm_login=false;
$json_access=false;
//if admin login then varriable value can be access
if(isset($_SESSION['adm_login'])&&$_SESSION['adm_login'] && isset($_GET['bid'])){
	$adm_login=true;
	if(isset($_GET['json'])){
		$json_access=true;
	}
}

$pfdate="";$ptdate="";
//if admin login then varriable values will be assigned
if(isset($adm_login) && $adm_login==true){
	$uid 	= $_GET['bid'];
	$pfdate	= $_GET['pfdate'];
	$ptdate	= $_GET['ptdate'];
	
}
//if not then current date will be assigned
else{
	$ptdate = date("Y-m-d");
}

$qprint=0;
if(isset($_GET['qp'])){
	$qprint=1;
}

/*
if(isset($_GET['type'])){$account_type=$_GET['type'];}
if(isset($_GET['type']) && $_GET['type']<0 ){$account_type=12;}
//else{$account_type=12;}
*/


//echo "<br/><br/>".$pdates; echo "<br/><br/>".$uid;



$post=select_info($uid, $post);//this varriable will be used for select information based on user_id
if(!isset($post['step']) || !$post['step'])$post['step']=1;

//print_r($post);

//exit;

###############################################################################

//print_r($post); print_r($uid); echo "=h1=";


$account_type_arr=array();
$nick_name_card="";
$account_type_value="";
$account_type_whr="";
$post['AccountsInfo']=mer_settings($uid);
$nick_name="";$primary_acc="";$virtual_terminal_fee=0;
//the code snippet processes the $post['AccountsInfo'] array, extracts specific information from each element, and performs various concatenations and calculations based on the conditions specified. The purpose of collecting data related to account types, primary accounts, and virtual terminal fees for further use.
if(isset($post['AccountsInfo'])&&$post['AccountsInfo']){
	foreach($post['AccountsInfo'] as $key=>$value){
		if(($value['account_login_url']==1)&&($value['nick_name'])) {
			$account_type_arr[]=$value['nick_name']; // as per last assign
			$nick_name_card .= $value['nick_name'].",";
			$account_type_value.=" `type`={$value['nick_name']} OR ";
			$nick_name .= $data['t'][$value['nick_name']]['name2'].", ";
			if(isset($value['primary'])&&$value['primary']=="1"){
				$primary_acc=$value['nick_name'];
			}
			
			if(isset($value['virtual_fee'])&&$value['virtual_fee']){
				$virtual_terminal_fee=stringToNumber($virtual_terminal_fee)+stringToNumber($value['virtual_fee']);
			}
			
		}
	}
 
  $account_type_whr .= " AND ( ".substr_replace($account_type_value,'', strrpos($account_type_value, 'OR'), 3)." ) ";		
  sort($account_type_arr);
}

$tp	="";
if(isset($_GET['tp'])){$tp=$_GET['tp'];}
$account_type_whr=" AND (`payout_date` <= now()) AND ( id between ".$tp." )";
 
$account_type=$account_type_arr[0];
if(!empty($primary_acc)){ $account_type=$primary_acc;}

// echo "<br/>==4==>".$account_type;exit;

###############################################################################


//$payoutdays="16";$payout_days_name="Wednesday";$settel="10"; // eCheck
$payoutdays="14";$payout_days_name="Monday";$settel="15";	//card

$post['AccountInfo']=mer_settings($uid, 0, true, $account_type);
$settelement_period=$post['AccountInfo'][0]['settelement_period'];
if(empty($settelement_period)){$settelement_period=$settel;}



###############################################################################

//this varriable will use for multiple rows from client_table based on id
$profile=db_rows(
	"SELECT * FROM `{$data['DbPrefix']}clientid_table`".
	" WHERE ( `id`={$uid} ) ".
	" ORDER BY `id` ASC LIMIT 1",0//This part sorts the results in ascending order based on the id column and limits the result set to only one row.
);
//print_r($profile);
$account_cur=$profile[0]['default_currency'];
$account_sys=get_currency($account_cur);

$wmp=withdraw_max_prev($uid,$post['gid'],1);//Fetch the last withdrawal detail of a merchant.


if($qprint){
	echo "<hr/>wmp previous=><br/>";
	print_r($wmp);
	echo "<br/><hr/>";
	
}
//print_r($wmp['transaction_id']);



//select all column from transactiosn table
$wd_tran=db_rows(
	"SELECT * FROM `{$data['DbPrefix']}transactions`".
	" WHERE ( `sender`={$uid} ) AND (`id`={$post['gid']})".//It filters rows where the sender column matches the provided $uid and where the id column matches the value in $post['gid'].
	"  LIMIT 1",0//This part limits the result set to only one row.
);
$wd_status=$wd_tran[0]['status'];
//print_r($wd_tran);
$transaction_amt_wd=$wd_tran[0]['transaction_amt'];


//echo "<hr/>transaction_amt_wd=>".$transaction_amt_wd;

$wd_json_value=json_decode($wd_tran[0]['json_value'],true);
//print_r($wd_json_value);
//print_r($wd_json_value['wd_date_from']);


//if con name clk then will be aplicalbe gst-Fee 
if((isset($data['con_name'])&&$data['con_name']=='clk')||(isset($wd_json_value['gst_fee_applicable'])&&$wd_json_value['gst_fee_applicable'])){
	$is_gst_fee=1;
	$gst_fee=$profile[0]['gst_fee'];
}else{
	$is_gst_fee=0;
	$gst_fee=0;
}


$previous_wd_date_to=date("Ymd",strtotime("0 day",strtotime($wmp['tdate'])));
$today_wd_date_to=date('Ymd');
if(isset($wmp['previous_wd_transaction_id'])&&$wmp['previous_wd_transaction_id']>0&&isset($wmp['tdate'])&&$wmp['tdate']&&$previous_wd_date_to==$today_wd_date_to){
	$is_gst_fee=0;
}


//this condition will be settlement period time
if(isset($wd_json_value['min_settelement_period'])&&$wd_json_value['min_settelement_period']<1){
	$time_from=" H:i:s";
	$time_to=" H:i:s";
}else{
	$time_from=" 00:00:00";
	$time_to=" 23:59:59";
}

$time_from=" 00:00:00";
$time_to=" 23:59:59";

	
$wd_created_date_prev=date("Y-m-d 00:00:00",strtotime("0 day",strtotime($wmp['tdate'])));
$wd_created_date_prev1=date("Y-m-d",strtotime("0 day",strtotime($wmp['tdate'])));



if($wd_json_value['wd_account_curr']!=$wd_json_value['wd_requested_bank_currency']){
	if($wd_json_value['wd_payable_amt_of_txn_from']){
		$transaction_amt_wd=$wd_json_value['wd_payable_amt_of_txn_from'];
	}
}


$wd_transaction_period=(isset($wd_json_value['wd_transaction_period'])?$wd_json_value['wd_transaction_period']:0);
$wd_tran_id=(isset($wd_json_value['wd_tran_id'])?$wd_json_value['wd_tran_id']:0);
$previous_wd_transaction_id=(isset($wd_json_value['previous_wd_transaction_id'])?$wd_json_value['previous_wd_transaction_id']:0);
$remaining_balance=(isset($wd_json_value['remaining_balance'])?$wd_json_value['remaining_balance']:0);
$withdraw_fee=(isset($wd_json_value['withdraw_fee'])?$wd_json_value['withdraw_fee']:0);
$withdrawfee_calc=(isset($wd_json_value['withdrawfee_calc'])?$wd_json_value['withdrawfee_calc']:0);

if((empty($previous_wd_transaction_id))&&(!empty($wmp['previous_wd_transaction_id']))){
	//$previous_wd_transaction_id=$wmp['previous_wd_transaction_id'];
}

$previous_wd_transaction_id=$wmp['previous_wd_transaction_id'];

$remaining_balance_prev=$wmp['remaining_balance_prev'];
//print_r($wmp['remaining_balance_prev']);


$mature_fund=$wd_json_value['mature_fund'];
$order_amount=$wd_tran[0]['amount'];
$remaining_balance_tr=number_formatf2(prnsum2($mature_fund)-str_replace_minus(prnsum2($order_amount)));
if((empty($remaining_balance))&&(!empty($remaining_balance_tr))){
	$remaining_balance=$remaining_balance_tr;
}


//$wd_tran_id.=",16,17,18,19,20";
//echo "<hr/>wd_tran_id=>".$wd_tran_id;
/*
if(isset($wd_json_value['wd_date_to'])&&$wd_json_value['wd_date_to']){
	$wd_created_date=$wd_json_value['wd_date_to'];
}else{
	$wd_created_date=$wd_tran[0]['tdate'];
}
*/
if(isset($is_gst_fee)&&$is_gst_fee==1){
	$wd_created_date=$wd_tran[0]['created_date'];
}else{
	$wd_created_date=$wmp['min_ptdate'];
}

$req_currency=$wd_json_value['wd_requested_bank_currency'];
$wd_created_date=date("Y-m-d 23:59:59",strtotime("0 day",strtotime($wd_created_date)));



if (date('Ymd',strtotime($wd_created_date_prev))<date('Ymd',strtotime($wd_created_date))) {
	//$wd_created_date_prev=$wd_created_date;
}

if (date('Ymd',strtotime($wd_created_date))<date('Ymd',strtotime($wd_created_date_prev))) {
	$wd_created_date=$wd_created_date_prev1." 23:59:59";
}


$tdate=date('Ymd',strtotime($wd_tran[0]['tdate']));


//echo "<hr/>wd_created_date_prev=>".$wd_created_date_prev;
//echo "<hr/>wd_created_date=>".$wd_created_date;


if($pfdate&&$ptdate){
	$wd_created_date_prev=date('Y-m-d 00:00:00',strtotime($pfdate));
	$wd_created_date=date("Y-m-d 23:59:59",strtotime("0 day",strtotime($ptdate)));
	$account_type_whr=" AND (`payout_date` BETWEEN (DATE_FORMAT('{$wd_created_date_prev}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$wd_created_date}', '%Y%m%d%H%i%s')))";
}else{
	//	tdate
	$account_type_whr=" AND (`payout_date` BETWEEN (DATE_FORMAT('{$wd_created_date_prev}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$wd_created_date}', '%Y%m%d%H%i%s')))";
	
	
	//echo "<hr/>account_type_whr=>".$account_type_whr;
}


//echo "<hr/>account_type_whr=>".$account_type_whr;

//$wd_tran_id_qry = "AND ( (`id`=".implode(') OR (`id`=',array_unique(explode(',',$wd_tran_id))).") )"; $account_type_whr=$wd_tran_id_qry ;


//$account_type_whr=" AND ( (DATE_FORMAT(`payout_date`, '%Y%m%d')) <= (DATE_FORMAT({$wd_created_date}, '%Y%m%d')) ) AND ( id between ".$wd_transaction_period." )";

if(isset($_GET['f'])&&($_GET['f']==1)){
	$wd_created_date=date('Ymd',strtotime($wd_json_value['wd_created_date'])); 
	$account_type_whr=" AND (`payout_date` BETWEEN (DATE_FORMAT('{$wd_created_date_prev}', '%Y%m%d')) AND (DATE_FORMAT('{$wd_created_date}', '%Y%m%d')))";
	
	//$account_type_whr=" AND ( `payout_date` <= now() ) AND ( id between ".$wd_transaction_period." )";
}elseif(isset($_GET['f'])&&($_GET['f']==2)){
	$account_type_whr=" AND (`payout_date` BETWEEN (DATE_FORMAT('{$wd_created_date_prev}', '%Y%m%d')) AND (DATE_FORMAT('{$wd_created_date}', '%Y%m%d'))) ".$account_type_whr;
}elseif(isset($_GET['f'])&&($_GET['f']==3)){
	$account_type_whr=" AND ( (DATE_FORMAT(`payout_date`, '%Y%m%d')) <= (DATE_FORMAT(now(), '%Y%m%d')) ) AND ( id between ".$wd_transaction_period." )";
}

//$settelement_wire_fee=$profile[0]['settlement_fixed_fee'];//$wd_json_value['wd_wire_fee'];

$settelement_wire_fee=$wd_json_value['wd_wire_fee'];

//Monthly  Maintenance Fee
//$monthly_maintance_fee=$wd_json_value['wd_total_monthly_fee'];
$monthly_maintance_fee=$wd_json_value['wd_total_month_no']*$profile[0]['monthly_fee'];
$min_settelement_amt=$profile[0]['settlement_min_amt'];  

$store_id=$wd_json_value['wd_store_id'];

//echo "<hr/>store_id=>".$store_id;
//echo "<hr/>monthly_maintance_fee=>".$monthly_maintance_fee;
//exit;

###############################################################################



if(!isset($pdates)) $pdates = "";

$cdate1 = $pdates; //date("Y-m-d"); "2017-06-18"; //date("2017-06-06");

$dateset	= date('d-m-Y',strtotime($cdate1)); 
$sunday 	= date('D', strtotime($dateset));
if($sunday=="Sun")$dateset=date("Y-m-d",strtotime("-1 day",strtotime($dateset)));
if($payout_days_name=="Wednesday"){
	if($sunday=="Mon")$dateset=date("Y-m-d",strtotime("-2 day",strtotime($dateset)));
	elseif($sunday=="Tue")$dateset=date("Y-m-d",strtotime("-3 day",strtotime($dateset)));
}
$newdata = array();
global $newdata;

/*
$newdata['currentdate']=date("Y-m-d", strtotime($cdate1));
$newdata['paydate']=date('Y-m-d', strtotime("$payout_days_name this week $dateset"));
$newdata['from_date']=date("Y-m-d",strtotime("-$payoutdays day",strtotime($newdata['paydate'])));
$newdata['to_date']=date("Y-m-d",strtotime("+6 day",strtotime($newdata['from_date'])));
$newdata['from_date_db']=date("Y-m-d",strtotime("-$payoutdays day",strtotime($newdata['paydate'])));
	$newdata['to_date_db']=date("Y-m-d",strtotime("+7 day",strtotime($newdata['from_date_db'])));
		$newdata['from_date_rtn']=date("Y-m-d",strtotime($newdata['to_date_db']));
$newdata['to_date_rtn']=date("Y-m-d",strtotime("+6 day",strtotime($newdata['from_date_rtn'])));
		$newdata['from_date_rtn_db']=date("Y-m-d",strtotime($newdata['to_date_db']));
$newdata['to_date_rtn_db']=date("Y-m-d",strtotime("+7 day",strtotime($newdata['from_date_rtn_db'])));
$newdata['first_week_payout_date']=date("Y-m-d", strtotime("first $payout_days_name of $dateset"));
$newdata['filename']=$post['company_name']."_payout_".$newdata['from_date']."_to_".$newdata['to_date'].".pdf";
$newdata['settlement_date']=date("Y-m-d",strtotime("+$settelement_period day",strtotime($newdata['to_date'])));

*/

$settlement_link_view="no";
$available_payout_amt=0;
if(isset($newdata['settlement_date'])&&date("Ymd")>=date("Ymd",strtotime($newdata['settlement_date']))){
	$settlement_link_view="OK";
}



###############################################################################



$newdata['paydate']=$wd_tran[0]['tdate'];
$newdata['from_date']=date('Y-m-d',strtotime($wd_created_date_prev));
$newdata['to_date']=date("Ymd",strtotime("0 day",strtotime($wd_created_date)));
$newdata['settlement_date']=$wd_tran[0]['tdate'];

###############################################################################

if($pfdate&&$ptdate){
	$newdata['paydate']=date('Y-m-d');
	$newdata['from_date']=date('Y-m-d',strtotime($pfdate));
	$newdata['to_date']=date('Y-m-d',strtotime($ptdate));
	$newdata['settlement_date']=date('Y-m-d',strtotime($ptdate));
}



if(isset($_GET['test'])&&$_GET['test']=="ok"){
	
	echo "<br>Current Date=>". date('D', strtotime($dateset))." = ". date("Y-m-d", strtotime($dateset));
	
	echo "<br><br>Payout Date=>". date('D', strtotime($newdata['paydate']))." = ". date("Y-m-d", strtotime($newdata['paydate']));
	
	echo "<br><br>Completed and Cancelled Data Range=>". date('D', strtotime($newdata['from_date']))." = ". date("Y-m-d", strtotime($newdata['from_date']))." to ". date("d  / m", strtotime($newdata['to_date']));
	
	echo "<br><br>Chargeback/Return Data Range=>". date('D', strtotime($newdata['from_date_rtn']))." = ". date("Y-m-d", strtotime($newdata['from_date_rtn']))." to ". date("d  / m", strtotime($newdata['to_date_rtn']));
	
	echo "<br><br>Settelement=>".$settelement_period ."days  |  Date: ". date("Y-m-d", strtotime($newdata['settlement_date']));

	echo "<br>Server Current Date=>". date("Y-m-d");
	
	echo "<hr/>settlement link=>". $settlement_link_view;
	
	
	echo "<br><br>";
	foreach($newdata as $key=>$value){
		echo "<br> ".$key." : ".$value;
	}
	exit;
}

if(isset($post['step'])&&$post['step']==1){

	if(isset($newdata['first_week_payout_date'])&& isset($newdata['paydate'])&&strtotime($newdata['first_week_payout_date']) == strtotime($newdata['paydate'])){
		$first_week_payout = "true";
	}else{
		$first_week_payout = "false";
	}
			
			
			
			// for card risk ratio
			$ratio_cn=get_riskratio_trans($uid); 
			$post['total_lead']=$ratio_cn['total_ratio'];
			$charge_back_fee=number_formatf($ratio_cn['charge_back_fee']);
			
			
			// for check risk ratio
			$ratio_ch=get_riskratio_trans($uid,0,0);
			$post['total_lead_ch']=$ratio_ch['total_ratio'];
			$return_back_fee=number_formatf($ratio_ch['charge_back_fee']);
			
			//echo "<br/>charge_back_fee=>".$charge_back_fee; echo "<br/>return_back_fee=>".$return_back_fee;
			
			
			
			if($ptdate){
				
			}else{
				$account_type_whr.=" AND ( `trname` IN ('cn','ch','af') ) ";
			}
			
			

			$payout_mature=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}transactions`".
				" WHERE (`owner_id`={$uid})  AND (status NOT IN (0,9,10)) ".$account_type_whr.
				" ORDER BY `id` ASC",$qprint
			);
			
			$total_size=sizeof($payout_mature);
			
			$post['payout_mature']=$payout_mature;
			
			
			
			//-----------------------------
			
			
			
						
			$pdf_download=false;
			
				
			//if $store_id is empty then select distinct store_id from the transaction table and concatenates them into a comma-separated string. 	
			if(empty($store_id)){
				$transactions_dis=db_rows(
					"SELECT GROUP_CONCAT(DISTINCT `store_id`) AS `store_id` FROM `{$data['DbPrefix']}transactions`".
					" WHERE (`owner_id`={$uid} ) ".$account_type_whr.
					"  LIMIT 1",0
				);
				
				 $store_id=$transactions_dis[0]['store_id'];
			}
			 
			 
			$vt=$post['AccountInfo'][0]['vt']; 
			if(empty($vt)){$vt="2";}
			
			
			
			
			if($pfdate&&$ptdate){
				$post['Banks']=select_banks($uid);
				//req_currency
				$required_currency = array();
				foreach($post['Banks'] as $key=>$value){
					//if(!empty($value['required_currency']) && $value['primary']=="1"){
					if(!empty($value['required_currency'])){
						$required_currency[] .=$value['required_currency'];
						$req_currency =$value['required_currency'];
					}
					if(isset($value['primary'])&&$value['primary']=="1"){
						$pdf_download=true;
					}
				}
			}
			
			if(isset($account_cur)&&isset($req_currency)&&$account_cur==$req_currency){
				$pdf_download=true;
			}
			else
			//if($account_cur!=$req_currency)
			{
				//echo "<hr/>account_cur=> ".$account_cur; echo "<hr/>req_currency=> ".$req_currency;
				$currency_rate=true;
				$pdf_download=true;
			}


$exceltitle=$post['company_name'];

$exl_date=date("F d,Y",strtotime($newdata['paydate']));
$exl_date_from=date("F d,Y",strtotime($newdata['from_date']));
$exl_date_to=date("F d,Y",strtotime($newdata['to_date']));

$fields = array('Date', $exl_date, 'From', $exl_date_from, 'To', $exl_date_to); 
$excelData.="\n". implode("\t", array_values($fields)) . "\n";
			
			 
		/* start:pdf */

		
		
		if(isset($adm_login)&&$adm_login==true){
			require('pdf/fpdfa.php');
		}else{
			require('pdf/fpdf.php');
		}


		
//start : class	

	
		class PDF extends FPDF {

			// Load data
			function LoadData($file){
				// Read file lines
				$lines = $file;
				$data = array();
				if($lines){
					foreach($lines as $line)
						$data[] = explode(';',trim($line));
					return $data;
				}
			}
			
			// Page header
			
			public function Header(){
				global $data;
				global $title;
				global $newdata;
				// Logo
				$this->Image('logo.png',10,8,30,0,'',$data['Host']);
				// Courier bold 15
				
				
				
				$this->SetFont('Helvetica','',10);
				$this->SetTextColor(0,0,0);
				$this->Cell(141);
				$this->Cell(200,-2,'Date     :  '.date("F d,Y",strtotime($newdata['paydate'])),0,0,'L');
				$this->Ln(0);
				$this->Cell(141);
				$this->Cell(200,18,'From    :  '.date("F d,Y",strtotime($newdata['from_date'])),0,0,'L');
				$this->Ln(0);
				$this->Cell(141);
				$this->Cell(200,28,'To        :  '.date("F d,Y",strtotime($newdata['to_date'])),0,0,'L');
				$this->Ln(0);
				
				
				
				$this->SetFont('Courier','B',18);
				// Move to the right
				$this->Cell(80);
				// Title
				$this->Cell(30,0,'Beta Merchant Statement',0,0,'C');
				$this->Ln(5);
				
				
				/*
				$this->SetFont('Courier','',10);
				// Move to the right
				$this->Cell(45);
				// Title
				$this->Cell(100,20,$title,0,0,'C');
				*/

				$this->Cell(45);	
					// Courier bold 15
				$this->SetFont('Courier','',10);
				
				// Calculate width of title and position
				$w = $this->GetStringWidth($title)+6;
				$this->SetX((210-$w)/2);
				// Title
				
				$this->Cell($w,9,$title,0,0,'C');
				//$this->SetTopMargin(100);
					
					
				// Line break
				$this->Ln(17);
			}

			// Page footer
			function Footer(){
				date_default_timezone_set("Canada/Saskatchewan");
				$current_date_time = date("d-m-Y h:i A"); 
				// Position at 1.5 cm from bottom
				$this->SetY(-15);
				// Courier italic 8
				$this->SetFont('Courier','I',9);
				$this->SetTextColor(0,0,0);
				// Page number
				
				
				
				$this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');
				$this->SetX(-83);
				$this->Cell(0,10,'Downloaded on '.$current_date_time.'(CST)',0,0,'C');
				$this->SetY(-11);
				$this->SetX(-201);
				$this->Cell(0,0,'Beta Version',0,0,'L');
				
			}


			

			// 7 Col table
			function ImprovedTable($header, $data, $titlename, $titleln=0, $fill=false, $border='T'){
				$this->Ln($titleln);
				if(!empty($titlename)) {
					 // Courier 12
					
					
					
					$this->SetFont('Courier','',15);
					// Background color
					$this->SetFillColor(220,220,220);
					$this->SetTextColor(0,102,204);
					// Title
					//$this->Cell(0,8,$titlename,0,1,'L',true);
					$this->Cell(73,8,$titlename,"",1,'L');
					// Line break
					$this->Ln(4);
				}
				
				// Column widths
				$w = array(45, 47, 20, 20, 20, 20, 20);
				// Header
				
				if($fill){
						$this->SetFont('Helvetica','B',11);
				}else {
					$this->SetFont('Helvetica','B',7);
				}
				$this->SetFillColor(240,240,240);
				$this->SetTextColor(0,0,0);
				for($i=0;$i<count($header);$i++){
					if($i===1 || $i===0){
						$this->Cell($w[$i],9,$header[$i],"B",0,'L',true);
					}else {
						$this->Cell($w[$i],9,$header[$i],"B",0,'C',true);
					}
				}
				$this->Ln();
				
				// Data
				$this->SetFont('Courier','',9);
				$this->SetTextColor(0,0,0);
				if(!empty($data[0])){
					foreach($data as $row){
						$this->Cell($w[0],6,$row[0],0,0,'L',true);
						$this->Cell($w[1],6,$row[1],0);
						$this->Cell($w[2],6,$row[2],0,0,'C',true);
						$this->Cell($w[3],6,$row[3],0,0,'C');
						$this->Cell($w[4],6,$row[4],0,0,'C',true);
						$this->Cell($w[5],6,$row[5],0,0,'C');
						$this->Cell($w[6],6,$row[6],0,0,'C',true);
						$this->Ln();
					}
				}
				// Closing line
				$this->Cell(array_sum($w),0,'',$border);
			}
			
			
			// 3 col table
			function ImprovedThreeColTable($data, $titlename, $titleln=0, $fontname=false, $fontcolor=0, $border='T'){
				$this->Ln($titleln);
				if(!empty($titlename)) {
					 // Courier 12
					
					$this->SetFont('Courier','',15);
					$this->SetTextColor(0,102,204);
					// Background color
					$this->SetFillColor(220,220,220);
					
					// Title
					$this->Cell(30,8,$titlename,"",1,'L');
					// Line break
					$this->Ln(4);
				}
				
				// Column widths
				$w = array(142, 30, 17);
				
				
				
				// Data
				if($fontname){
					$this->SetFont('Helvetica','B',10);
				}else {
					$this->SetFont('Courier','',12);
				}
				
				if($fontcolor==2){
					$this->SetTextColor(0,102,204);
				}elseif($fontcolor==1){
					$this->SetTextColor(225,0,0);
				} else{
					$this->SetTextColor(0,0,0);
				}
				
				if(!empty($data[0])){
					foreach($data as $row){
						$this->Cell($w[0],7,$row[0],0,0);
						$this->Cell($w[1],7,$row[1],0,0,'R');
						$this->Cell($w[2],7,$row[2],0,0,'C');

						$this->Ln();
					}
				}
				// Closing line
				$this->Cell(array_sum($w),0,'',$border);
			}
			
			
			
			// 4 col table
			function ImprovedFourColTable($data, $titlename, $titleln=0, $fill=false){
				$this->Ln($titleln);
				if(!empty($titlename)) {
					 // Courier 12
					
					$this->SetFont('Courier','',15);
					// Background color
					$this->SetFillColor(220,220,220);

					// Title
					$this->Cell(30,8,$titlename,"",1,'L');
					// Line break
					$this->Ln(4);
				}
				
				// Column widths
				$w = array(30, 74, 32, 53);
				
				
				
				// Data
				if($fill){
					$this->SetFont('Helvetica','B',10);
				}else {
					$this->SetFont('Helvetica','',9);
				}
				$this->Cell(array_sum($w),0,'','T');
				$this->Ln(2);
				if(!empty($data[0])){
					foreach($data as $row){
						$this->Cell($w[0],7,$row[0],0,0);
						$this->Cell($w[1],7,$row[1],0,0);
						$this->Cell($w[2],7,$row[2],0,0);
						$this->Cell($w[3],7,$row[3],0,0);

						$this->Ln();
					}
				}
				// Closing line
				$this->Ln(2);
				$this->Cell(array_sum($w),0,'','T');
				
			}
			
		// simple html desing 

			protected $B = 0;
			protected $I = 0;
			protected $U = 0;
			protected $HREF = '';

			function WriteHTML($html){
				// HTML parser
				
				$html = str_replace("\n",' ',$html);
				$a = preg_split('/<(.*)>/U',$html,-1,PREG_SPLIT_DELIM_CAPTURE);
				foreach($a as $i=>$e){
					if($i%2==0)
					{
						// Text
						if($this->HREF)
							$this->PutLink($this->HREF,$e);
						else
							$this->Write(5,$e);
					}
					else
					{
						// Tag
						if($e[0]=='/')
							$this->CloseTag(strtoupper(substr($e,1)));
						else
						{
							// Extract attributes
							$a2 = explode(' ',$e);
							$tag = strtoupper(array_shift($a2));
							$attr = array();
							foreach($a2 as $v)
							{
								if(preg_match('/([^=]*)=["\']?([^"\']*)/',$v,$a3))
									$attr[strtoupper($a3[1])] = $a3[2];
							}
							$this->OpenTag($tag,$attr);
						}
					}
				}
			}

			function OpenTag($tag, $attr){
				
				// Opening tag
				if($tag=='B' || $tag=='I' || $tag=='U')
					$this->SetStyle($tag,true);
				if($tag=='A')
					$this->HREF = $attr['HREF'];
				if($tag=='BR')
					$this->Ln(5);
			}

			function CloseTag($tag){
				// Closing tag
				if($tag=='B' || $tag=='I' || $tag=='U')
					$this->SetStyle($tag,false);
				if($tag=='A')
					$this->HREF = '';
			}

			function SetStyle($tag, $enable){
				// Modify style and select corresponding font
				$this->$tag += ($enable ? 1 : -1);
				$style = '';
				foreach(array('B', 'I', 'U') as $s)
				{
					if($this->$s>0)
						$style .= $s;
				}
				$this->SetFont('',$style);
			}

			function PutLink($URL, $txt){
				// Put a hyperlink
				$this->SetTextColor(0,0,255);
				$this->SetStyle('U',true);
				$this->Write(5,$txt,$URL);
				$this->SetStyle('U',false);
				$this->SetTextColor(0);
			}
			
			
		}


//end: class	
		

		// Instanciation of inherited class
		$pdf = new PDF();
		$title = $post['company_name'];
		$pdf->SetTitle($title);

		$pdf->AliasNbPages();
		$pdf->AddPage();
		$pdf->SetFont('Arial','',10);

		

		$header 		= array('Payment ID', 'Name', 'Amount', 'Discount Rate', 'Tran.Fee', 'H.Reserve', 'Total');
		
        //$excelData.="\n". implode("\t", array_values($header)) . "\n"; // for excel
		$completed_data = array();
		$cancelled_data = array();
		$refunded_data = array();
		$returned_data 	= array();
		$cbk1_data 	= array();
		

		$total_txn_fee 	= 0;
		$total_dis_rate = 0;
		$total_rol_fee	= 0; 
		
		
		$gst_total_fees_amt	= 0;
		$count_success=0;
		$count_withdrawal=0;
		$count_send_fund=0;
		$count_received_fund=0;
		$count_failed=0;
		$count_refunded=0;
		$count_chargeback=0;
		$count_returned=0;
		$count_cbk1=0;

		
		
		$sales_volume	= 0;
		$refund_volume	= 0;
		$returns_volume	= 0;
		$cbk1_volume	= 0;
		
		$total_refund_fee = 0;
		$total_returns_fee = 0;
		$total_cbk1_fee = 0;
		
		$completed_count=0;
		$completed_trid=0;
		
		$total_withdraw=0;
		$total_send_fund=0;
		$total_received_fund=0;
		
		$total_chargeback_fee=0;
		$chargeback_volume=0;
		
		foreach($post['payout_mature'] as $key=>$value){
			//$pdf->Cell(0,10,$value['transaction_id']."       ".$value['transaction_amt'],0,1);
			
			$accounts=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}account`".
				" WHERE `clientid`={$uid} AND `nick_name`='".$value['type']."' ".
				" LIMIT 1"
			);
			
			if($value['status']==1 || $value['status']==14){
				$completed_count=$completed_count+1;
				$completed_trid.=$value['transaction_id'].",";
			}
			
			$trname=strtoupper($value['trname']);
			
			if(($value['status']==1 || $value['status']==4 || $value['status']==7 || $value['status']==8)&&($value['trname']=='cn'||$value['trname']=='ch')){ // completed 
			
				$count_success=$count_success+1;
				
			
				$dis_rate 	= number_formatf((double)$value['mdr_amt']);
				$rol_fee	= number_formatf((double)$value['rolling_amt']);
				$this_total	= number_formatf((double)$value['payable_amt_of_txn']);//($value['transaction_amt'])-($dis_rate+$accounts[0]['txn_fee']+$rol_fee);
				
				if($is_gst_fee&&isset($value['gst_fee'])&&$value['gst_fee']&&$dis_rate){
					$dis_rate 		= number_formatf2($dis_rate,4);
					$this_gst_fee 	= number_formatf2($value['gst_fee'],4);
					
					$gst_total_fees_amt = number_formatf2($gst_total_fees_amt + $this_gst_fee,4);
					
				}else{
					$this_gst_fee 	= 0;
				}
				
				$total_txn_fee = number_formatf((double)$total_txn_fee+(double)$value['mdr_txtfee_amt']);
				
				$total_dis_rate = (double)$total_dis_rate + $dis_rate;
				$total_rol_fee	= (double)$total_rol_fee + $rol_fee;
				
				$sales_volume	= number_formatf2((double)$sales_volume+(double)$value['transaction_amt']);
				
				$completed_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".number_formatf2($dis_rate).";".number_formatf2($value['mdr_txtfee_amt']).";".number_formatf2($rol_fee).";".number_formatf2($this_total)."";
				
				
			}
			if(($value['status']==2)&&($value['trname']=='cn'||$value['trname']=='ch')){ // failed canceled 
				
				$count_failed=$count_failed+1;
				
				$dis_rate 	= "0";
				$rol_fee	= "0";
				$this_total	= number_formatf2($value['mdr_txtfee_amt']);
				
				$total_txn_fee = (double)$total_txn_fee+(double)$value['mdr_txtfee_amt'];
				
				$cancelled_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".$dis_rate.";".$value['mdr_txtfee_amt'].";".$rol_fee.";-".$this_total."";
				
				
			}
			
			
			// withdrawal fund 
			
			if(($value['status']!=2)&&($value['trname']=='wd')){ // canceled
				
				$count_withdrawal=$count_withdrawal+1;
				
				$dis_rate 	= "0";
				$rol_fee	= "0";
				
				$total_withdraw = number_formatf2($total_withdraw - $value['amount']);
				
				$withdraw_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['amount']).";".$dis_rate.";".$value['mdr_txtfee_amt'].";".$rol_fee.";".number_formatf2($value['amount'])."";
				
				
			}
			
			if(($value['status']!=2)&&($value['trname']=='af')&&($value['sender']==$uid)){ // canceled 
				
				$count_send_fund=$count_send_fund+1;
				
				$dis_rate 	= "0";
				$rol_fee	= "0";
				
				if($total_send_fund && $value['amount']) {
					$total_send_fund = number_formatf2($total_send_fund - $value['amount']);
				}
				
				$send_fund_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['amount']).";".$dis_rate.";0;".$rol_fee.";".number_formatf2($value['amount'])."";
				
				
			}
			
			if(($value['status']!=2)&&($value['trname']=='af')&&($value['receiver']==$uid)){ // canceled
				
				$count_received_fund=$count_received_fund+0;
				
				$dis_rate 	= "0";
				$rol_fee	= "0";
				
				$total_received_fund = number_formatf2($total_received_fund - $value['amount']);
				
				$received_fund_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".str_replace_minus(number_formatf2($value['amount'])).";".$dis_rate.";0;".$rol_fee.";".str_replace_minus(number_formatf2($value['amount']))."";
				
				
			}
			
			
			//after reverse 
			
			
			if($value['status']==3 || $value['status']==12){ // Refunded and Partial Refund
				
				$count_refunded=$count_refunded+1;
				
				$refund_fee=str_replace_minus($value['mdr_refundfee_amt']);
				
				$dis_rate 	= "0";
				$rol_fee	= (double)$value['rolling_amt'];
				
				$this_tr_fee= $refund_fee;
				$this_total	= number_formatf2($value['transaction_amt']-($refund_fee-$rol_fee)); // 45
				
				$refund_volume	= number_formatf2($refund_volume-$value['transaction_amt']);
				
				$total_rol_fee	= number_formatf($total_rol_fee - $rol_fee);
				
				$total_refund_fee = number_formatf2($total_refund_fee+$refund_fee+$gst_refund_fee_amt); 
				
				$refunded_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".$dis_rate.";-".number_formatf2($this_tr_fee).";".$rol_fee.";".$this_total."";
				
				
			}
			if($value['status']==11){ // cbk1 
				
				$count_cbk1=$count_cbk1+1;
				
				$cbk1_fee=number_formatf(str_replace_minus($value['mdr_cbk1_amt']));
				
				$dis_rate 	= "0";
				$rol_fee	= number_formatf((double)$value['rolling_amt']);
				$this_tr_fee= $cbk1_fee;
				
				
				$this_total	= number_formatf2($value['transaction_amt']-($cbk1_fee-$rol_fee)); // 45
				
				
				
				$cbk1_volume	= number_formatf2($cbk1_volume-$value['transaction_amt']);
				
				$total_rol_fee	= ($total_rol_fee - $rol_fee);
				
				$total_cbk1_fee = number_formatf2($total_cbk1_fee+$cbk1_fee); 
				
				
				$cbk1_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".$dis_rate.";-".number_formatf2($this_tr_fee).";".$rol_fee.";".$this_total."";
				
				
			}
			if($value['status']==5){ // Chargeback 
				
				$count_chargeback=$count_chargeback+1;
				
				$dis_rate 	= "0";
				$rol_fee	= number_formatf((double)$value['rolling_amt']);
				$this_tr_fee= number_formatf(str_replace_minus($value['mdr_cb_amt']));
				
				
				$this_total	= number_formatf2($value['transaction_amt']-($this_tr_fee-$rol_fee)); // 45
				
				
				
				$chargeback_volume	= number_formatf2($chargeback_volume-$value['transaction_amt']);
				
				$total_rol_fee	= number_formatf($total_rol_fee - $rol_fee);
				
				$total_chargeback_fee = number_formatf($total_chargeback_fee+$this_tr_fee); //3 tire wise risk ratio
				
				
				$chargeback_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".$dis_rate.";-".number_formatf2($this_tr_fee).";".$rol_fee.";".$this_total."";
				
				
			}
			
			if($value['status']==6){ // Returned 
				
				$count_returned=$count_returned+1;
				
				$dis_rate 	= "0";
				$rol_fee	= (double)$value['rolling_amt'];
				$this_tr_fee= str_replace_minus($value['mdr_refundfee_amt']);
				
				
				$this_total	= number_formatf2($value['transaction_amt']-($this_tr_fee-$rol_fee)); // 45
				
				
				
				$returns_volume	= number_formatf2($returns_volume-$value['transaction_amt']);
				
				$total_rol_fee	= number_formatf($total_rol_fee - $rol_fee);
				
				$total_returns_fee = number_formatf2($total_returns_fee+$this_tr_fee); //45  as per risk ratio and account 1 from 3
				
				
				$returned_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".$dis_rate.";-".number_formatf2($this_tr_fee).";".$rol_fee.";".$this_total."";
			}
			
			
		}
		
		
		

$header_total 	= array(' ', 'Total', ' ', number_formatf2($total_dis_rate), number_formatf2($total_txn_fee), number_formatf2($total_rol_fee), '');
		
		
		
$data_profie 	= array();
//if($store_id){
	$data_profie[] 	.= "  Website ID;:  ".$store_id."; Withdrawal ID;:  ".$wd_tran[0]['transaction_id']."";
//}
//$data_profie[] 	.= "  Payment Type;:  ".$nick_name."; ";
$data_profie[] 	.= "  Account Currency;:  ".$account_cur."; Settlement Currency;:  ".$req_currency."";
$data_profie[] 	.= "  Chargeback Ratio;:  ".$post['total_lead']."%; Settlement Date;:  ".date("F d,Y",strtotime($newdata['settlement_date']))."";

//Added for Excel

$exl_Withdrawal_ID=$wd_tran[0]['transaction_id'];
$exl_Chargeback_Ratio=$post['total_lead']."%";
$exl_Settlement_Date=date("F d,Y",strtotime($newdata['settlement_date']));

$fields = array('Website ID', $store_id, 'Withdrawal ID', $exl_Withdrawal_ID); 
$excelData.="\n". implode("\t", array_values($fields)) . "\n";

$fields = array('Account Currency', $account_cur, 'Settlement Currency', $req_currency); 
$excelData.="\n". implode("\t", array_values($fields)) . "\n";

$fields = array('Chargeback Ratio', $exl_Chargeback_Ratio, ' Settlement Date', $exl_Settlement_Date); 
$excelData.="\n". implode("\t", array_values($fields)) . "\n";

$data_pro = $pdf->LoadData($data_profie);
$pdf->ImprovedFourColTable($data_pro,'');

	$datas_seles 	= array("Sales Volume;".number_formatf2($sales_volume).";$account_cur");
	
	$datas_received_f = array();
	if($total_received_fund){
		$datas_received_f[]	= "Received Fund;".number_formatf2($total_received_fund).";$account_cur";
	}
$excelData.="\n OVERVIEW \n";	
$fields = array('Sales Volume', number_formatf2($sales_volume).' '.$account_cur); 
$excelData.="\n". implode("\t", array_values($fields)) . "\n";

$total_gst_fee=0;

if($is_gst_fee){
	//$total_gst_fee=(($total_dis_rate*$gst_fee)/100);
}else{
	//$total_gst_fee=0;
}

$datas_sendfunds = array();

	if($total_send_fund>0){
		$datas_sendfunds[] 	.= "Send Fund;".number_formatf2($total_send_fund).";$account_cur";
	}
	if($total_withdraw>0){
		$datas_sendfunds[] 	.= "Withdraw;".number_formatf2($total_withdraw).";$account_cur";
	}
	
	
	
$datas_over 	= array();
	
	if($refund_volume>0){
		$datas_over[] 	.= "Refund;".number_formatf2($refund_volume).";$account_cur";
	}
	if($chargeback_volume>0){
		$datas_over[] 	.= "Chargeback;".number_formatf2($chargeback_volume).";$account_cur";
	}
	if($returns_volume>0){
		$datas_over[] 	.= "Return;".number_formatf2($returns_volume).";$account_cur";		
	}
	
	if($cbk1_volume>0){
		$datas_over[] 	.= "CBK1;".number_formatf2($cbk1_volume).";$account_cur";  // by Transaction List
	}
	
	if($total_rol_fee>0){
		$datas_over[] 	.= "Holdback Reserve;".number_formatf2($total_rol_fee).";$account_cur";
	}
	
$excelData.="\n Charges \n";	

	
	//fee charges
	if($total_dis_rate>0){
		$data_row_fee[] 	.= "Discount Rate;".number_formatf2($total_dis_rate).";$account_cur";
		
		$fields = array('Discount Rate', number_formatf2($total_dis_rate).' '.$account_cur); 
        $excelData.="\n". implode("\t", array_values($fields));

	}
	//for transaction fee calculation
	if($total_txn_fee>0){
		$data_row_fee[] 	.= "Transaction Fee;".number_formatf2($total_txn_fee).";$account_cur";
		$fields = array('Transaction Fee', number_formatf2($total_txn_fee).' '.$account_cur); 
        $excelData.="\n". implode("\t", array_values($fields));
	}
	//for refund fee
	if($total_refund_fee>0){
		$data_row_fee[] 	.= "Refund Fee;".number_formatf2($total_refund_fee ).";$account_cur";
		$fields = array('Refund Fee', number_formatf2($total_refund_fee).' '.$account_cur); 
        $excelData.="\n". implode("\t", array_values($fields));
	}
	//for chargeback
	if($total_chargeback_fee>0){
		$data_row_fee[] 	.= "Chargeback Fee;".number_formatf2($total_chargeback_fee).";$account_cur"; 
		$fields = array('Chargeback Fee', number_formatf2($total_chargeback_fee).' '.$account_cur); 
        $excelData.="\n". implode("\t", array_values($fields));
	}
	if($total_returns_fee>0){
		$data_row_fee[] 	.= "Return Fee;".number_formatf2($total_returns_fee).";$account_cur";
		$fields = array('Return Fee', number_formatf2($total_returns_fee).' '.$account_cur); 
        $excelData.="\n". implode("\t", array_values($fields));
	}
	if($total_cbk1_fee>0){
		$data_row_fee[] 	.= "CBK1 Fee;".number_formatf2($total_cbk1_fee ).";$account_cur"; 
		$fields = array('CBK1 Fee', number_formatf2($total_cbk1_fee).' '.$account_cur); 
        $excelData.="\n". implode("\t", array_values($fields));
	} // get by Account ex 45
	
//  settlement wire fees and formatting them for inclusion in an Excel sheet. number_formatf2(), which appears to be responsible for formatting numbers. 
	if($settelement_wire_fee>0){
		$data_row_fee[] 	.= "Settlement Wire Fee;".number_formatf2($settelement_wire_fee).";$account_cur";
		$fields = array('Settlement Wire Fee', number_formatf2($settelement_wire_fee).' '.$account_cur); 
        $excelData.="\n". implode("\t", array_values($fields)) ;
	}


			
// This condition is for processing monthly maintenance fees, virtual terminal fees, and generating Excel data. 			
if($monthly_maintance_fee){
	$data_row_fee[] 	.= "Monthly Maintenance Fee @{$profile[0]['monthly_fee']}x{$wd_json_value['wd_total_month_no']} ;$monthly_maintance_fee;$account_cur"; // Fist Week of Month only 
	    $fields = array('Monthly Maintenance Fee '.$profile[0]['monthly_fee'].'x'.$wd_json_value['wd_total_month_no'], $monthly_maintance_fee.' '.$account_cur); 
        $excelData.="\n". implode("\t", array_values($fields));
	if($virtual_terminal_fee>0){
		if($vt=="1"){$data_row_fee[] 	.= "Monthly Vitual Terminal Fee;$virtual_terminal_fee;$account_cur"; } // Fist Week of Month only 
		$fields = array('Monthly Vitual Terminal Fee', $virtual_terminal_fee.' '.$account_cur); 
        $excelData.="\n". implode("\t", array_values($fields));
	}
	$mmf = $monthly_maintance_fee;
	if($vt=="1"){$mvtf = $virtual_terminal_fee;}
}else{
	$mmf = 0;
	$mvtf = 0;
}
	
	

//calculation of total fee
	$total_fees	= number_formatf2(prnsum2($total_dis_rate)+prnsum2($total_txn_fee)+prnsum2($total_refund_fee)+prnsum2($total_chargeback_fee)+prnsum2($total_returns_fee)+prnsum2($total_cbk1_fee)+prnsum2($monthly_maintance_fee)+prnsum2($virtual_terminal_fee)+prnsum2($settelement_wire_fee));
/*	
if($is_gst_fee){
	$gst_total_fees_amt=number_formatf2((($total_fees*$gst_fee)/100),4);
}
*/
//for other deduction
$sum_other_deductions=number_formatf2(prnsum2($refund_volume)+prnsum2($chargeback_volume)+prnsum2($returns_volume)+prnsum2($cbk1_volume)+prnsum2($total_rol_fee));

//for reverse
$reverse 		= number_formatf2(number_formatf2($refund_volume)+number_formatf2($returns_volume)+number_formatf2( $total_withdraw )+number_formatf2( $total_send_fund )-number_formatf2( $total_received_fund )+number_formatf2($total_dis_rate)+number_formatf2($total_gst_fee)+number_formatf2($total_txn_fee)+number_formatf2($total_refund_fee)+number_formatf2($chargeback_volume)+number_formatf2($total_chargeback_fee)+number_formatf2($total_returns_fee)+number_formatf2($total_rol_fee)+$mmf+$mvtf)+number_formatf2($total_cbk1_fee)+number_formatf2($cbk1_volume);
$sales_volume	= number_formatf2($sales_volume);
//$tpa			= $sales_volume-$reverse;
$tpa			= ($sales_volume+$remaining_balance_prev)-($total_fees+$gst_total_fees_amt+$sum_other_deductions);


$available_payout =($tpa+$total_received_fund)-($total_send_fund+$total_withdraw);
$nextselt="";
	



if($transaction_amt_wd){
	//$other_fee_temp=$available_payout+$transaction_amt_wd; $available_payout=$available_payout-$other_fee_temp;
	
	$other_fee_temp=$available_payout-(str_replace('-','',$transaction_amt_wd)); 
	$available_payout=$available_payout-$other_fee_temp;
	
}else{
	$other_fee_temp=0;
}


if((str_replace_minus($available_payout)>0)){
	//$available_payout_exchange=($available_payout*$currency_rate);
	
	if($pfdate&&$ptdate){
		$available_payout_exchange=currencyConverter($account_cur,$req_currency,$available_payout,1);
	}else{
		
		$available_payout_exchange=str_replace('-','',$wd_tran[0]['transaction_amt']);
	}
	
	$available_payout_exchange=number_formatf2($available_payout_exchange);
	$available_payout_amt="<b>".$available_payout_exchange."</b> ".$req_currency;
	$available_payout_amt_only=$available_payout_exchange;
	
}else{
	
	$available_payout_amt=$account_sys."<b>".$available_payout."</b>";
	$available_payout_amt_only=$available_payout;
	
}

###################################################

$data1 = $pdf->LoadData(array(" ; ; "));
$pdf->ImprovedThreeColTable($data1,'OVERVIEW',7,false,1);
	
if($sales_volume>0){
	$data = $pdf->LoadData($datas_seles);
	$pdf->ImprovedThreeColTable($data,'',0,false,0);
}

$data_blank = $pdf->LoadData(array(" ; ; "));
$pdf->ImprovedThreeColTable($data_blank,'',3,false,0,'');


	
	$data_row_fee = $pdf->LoadData($data_row_fee);
	$pdf->ImprovedThreeColTable($data_row_fee,'Charges',0,false,1,'T');

	$data = $pdf->LoadData(array("Total; {$total_fees}; {$account_cur}"));
	$pdf->ImprovedThreeColTable($data,'',0,false,0);
	
	    $fields = array('Total', $total_fees.' '.$account_cur); 
        $excelData.="\n". implode("\t", array_values($fields)) ;

	$data_blank = $pdf->LoadData(array(" ; ; "));
	$pdf->ImprovedThreeColTable($data_blank,'',0,false,0,'');
	
if($is_gst_fee){
	$data_gst = $pdf->LoadData(array("GST Fee {$total_fees}@{$gst_fee}%;".number_formatf2($gst_total_fees_amt,4).";$account_cur"));
	
	$fields = array('GST Fee '.$total_fees.'@'.$gst_fee.'%', number_formatf2($gst_total_fees_amt,4).' '.$account_cur); 
    $excelData.="\n". implode("\t", array_values($fields)) ;
		
		
	$pdf->ImprovedThreeColTable($data_gst,'',0,false,2);
	
	$data_blank = $pdf->LoadData(array(" ; ; "));
	$pdf->ImprovedThreeColTable($data_blank,'',0,false,0,'');

}



if($sum_other_deductions>0){
	$data_o = $pdf->LoadData($datas_over);
	$pdf->ImprovedThreeColTable($data_o,'Other Deductions',0,false,1);
	
	$excelData.="\n Other Deductions \n";	
    $fields = $datas_over; 
    $excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields))) . "\n";

	$data = $pdf->LoadData(array("Total; {$sum_other_deductions}; {$account_cur}"));
	$pdf->ImprovedThreeColTable($data,'',0,false,0);
	
	$fields = array('Total', $sum_other_deductions.' '.$account_cur);
    $excelData.="\n". implode("\t", array_values($fields)) . "\n";
}

$data_blank = $pdf->LoadData(array(" ; ; "));
$pdf->ImprovedThreeColTable($data_blank,'',0,false,0,'');
	
$datat = array("Gross Settlement Amount ;".number_formatf2($tpa).";$account_cur");
$data = $pdf->LoadData($datat);
$pdf->ImprovedThreeColTable($data,'',0,true);

$data_rr = $pdf->LoadData($datas_received_f);
$pdf->ImprovedThreeColTable($data_rr,'',0,false);

$data_sf = $pdf->LoadData($datas_sendfunds);
$pdf->ImprovedThreeColTable($data_sf,'',0,false);


    $fields = array('Gross Settlement Amount', number_formatf2($tpa).' '.$account_cur); 
    $excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
	
	$pieces=$datas_sendfunds[0];
	$pieces = explode(";", $pieces);
	
	$fields = array($pieces[0], $pieces[1].' '.$pieces[2]); 
    $excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
	
	
//-------------------------

if($previous_wd_transaction_id){
	
	$data = $pdf->LoadData(array("Due from Withdrawal ID  ".$previous_wd_transaction_id." ;".$remaining_balance_prev.";$account_cur")); 
	$fields = array('Due from Withdrawal ID'.$previous_wd_transaction_id, ' '.$remaining_balance_prev.' '.$account_cur); 
    $excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
	$pdf->ImprovedThreeColTable($data,'',0,true);
	
	/*
	$data = $pdf->LoadData(array("Due from Previous Withdrawal ID  ".$previous_wd_transaction_id." ;".
number_formatf2(str_replace_minus($other_fee_temp)).";$account_cur")); 
	if(strpos($other_fee_temp,'-')!==false){
		$pdf->ImprovedThreeColTable($data,'',0,true);
	}
	else{
		$pdf->ImprovedThreeColTable($data,'',0,false,1);
	}
	*/
}

if($withdrawfee_calc>0){
$data = $pdf->LoadData(array("Withdraw Fee {$withdraw_fee};".number_formatf2($withdrawfee_calc).";$account_cur"));
$pdf->ImprovedThreeColTable($data,'',0,false,1);

$fields = array('Withdraw Fee '.$withdraw_fee, number_formatf2($withdrawfee_calc).' '.$account_cur); 
$excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
}

if((str_replace_minus($available_payout)>0)&&$available_payout_exchange){
	$data = $pdf->LoadData(array("Withdrawal ID ".$wd_tran[0]['transaction_id'].$nextselt." ;".$available_payout_exchange.";$req_currency")); 
	
	$fields = array('Withdrawal ID '.$wd_tran[0]['transaction_id'].$nextselt, $available_payout_exchange.' '.$account_cur); 
$excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));

	$pdf->ImprovedThreeColTable($data,'',0,true);
}else{
	$data_available_payout = $pdf->LoadData(array("Withdrawal ID ".$wd_tran[0]['transaction_id'].$nextselt." ;".number_formatf2($available_payout).";$account_cur")); //
	
	$fields = array('Withdrawal ID'.$wd_tran[0]['transaction_id'].$nextselt, ' '.number_formatf2($available_payout).' '.$account_cur); 
    $excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
	
	$pdf->ImprovedThreeColTable($data_available_payout,'',0,true);
}

if($remaining_balance>0){
	$data = $pdf->LoadData(array("Remaining Balance;".number_formatf2($remaining_balance).";$account_cur"));
	$fields = array('Remaining Balance', number_formatf2($remaining_balance).' '.$account_cur); 
    $excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)))."\n";
	
	$pdf->ImprovedThreeColTable($data,'',0,false,1);
}
elseif(($other_fee_temp)&&(empty($previous_wd_transaction_id))){
//if(($other_fee_temp) ){
	$data = $pdf->LoadData(array("Remaining Balance;".number_formatf2($other_fee_temp).";$account_cur"));
	
	$fields = array('Remaining Balance', number_formatf2($other_fee_temp).' '.$account_cur); 
    $excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)))."\n";
	
	$pdf->ImprovedThreeColTable($data,'',0,false,1);
}


//$data_blank = $pdf->LoadData(array("Error of the system generated statement should be reported by the merchant asap. MSP hold the right to adjust the difference manually.; ; ")); $pdf->ImprovedThreeColTable($data_blank,'',10,false,0,'');

//

/*
$datas_text 		= array();
$datas_text[] 		.= "The error of system generated report should be reported by the merchant;";
$datas_text[] 		.= "asap. MSP hold the right to adjust the difference manually.;";
	
$data_txt = $pdf->LoadData($datas_text); 
$pdf->ImprovedThreeColTable($data_txt,'',0,false);*/



if($is_gst_fee){
	$ln1=58;
}else{
	$ln1=10;
}
if(!empty($currency_rate)){ 
	$ln1=$ln1-10;
}

$pdf->Ln($ln1);

$pdf->SetLeftMargin(10);
$html = '<p>Error of the system generated statement should be reported by the merchant asap. MSP hold the right to adjust the difference manually.</p>';

		$pdf->Ln(4);

		//$pdf->Image('logo.png',10,50,30,0,'',' ');
		//$pdf->SetLeftMargin(45);
		$pdf->SetFontSize(7);
		$pdf->WriteHTML($html);

$pdf->SetLeftMargin(10);
// end of 1st page

	
	if($total_size>0){
		$pdf->AddPage();
		$pdf->SetFont('Helvetica','B',16);
		$pdf->ln(-8);
		
		$pdf->Cell(40,10,'Over All Summary ('.$total_size.')');
		
	$fields = array('Over All Summary', $total_size); 
    $excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)))."\n";
	
	}else{
		//$data_blank = $pdf->LoadData(array("No Transaction Found; ; ")); $pdf->ImprovedThreeColTable($data_blank,'',10,false,1,'');
	}

		$data_c = $pdf->LoadData($completed_data);
		if(!empty($data_c)){
			$pdf->ImprovedTable($header,$data_c,"SUCCESS TRANSACTION ({$count_success})",10);
			
			//============excel===================	
			$excelData.="\n \n SUCCESS TRANSACTION ({$count_success}) \n";
			$fields = array('Payment ID', 'Name', 'Amount', 'Discount Rate', 'Tran.Fee', 'H.Reserve', 'Total'); 
			$excelData.="\n". implode("\t", array_values($fields)) . "\n";
			foreach ($completed_data as $fields) {
			$strans = explode(";", $fields);
			$fields = array($strans[0],$strans[1],$strans[2],$strans[3],$strans[4],$strans[5],$strans[6]);
			$excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
			}
			//=======================================
	
		}
		$data_withdraw = $pdf->LoadData($withdraw_data);
		if(!empty($dataw)){
			$pdf->ImprovedTable($header,$data_withdraw,"WITHDRAW TRANSACTION ({$count_withdrawal}) ",10);
			//============excel===================	
			$excelData.="\n \n WITHDRAW TRANSACTION ({$count_withdrawal}) \n";
			$fields = array('Payment ID', 'Name', 'Amount', 'Discount Rate', 'Tran.Fee', 'H.Reserve', 'Total'); 
			$excelData.="\n". implode("\t", array_values($fields)) . "\n";
			foreach ($withdraw_data as $fields) {
			$strans = explode(";", $fields);
			$fields = array($strans[0],$strans[1],$strans[2],$strans[3],$strans[4],$strans[5],$strans[6]);
			$excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
			}
			//=======================================
		}
		$data_send_fund = $pdf->LoadData($send_fund_data);
		if(!empty($data_send_fund)){
			$pdf->ImprovedTable($header,$data_send_fund,"SEND FUND TRANSACTION ({$count_send_fund}) ",10);
			//============excel===================	
			$excelData.="\n \n SEND FUND TRANSACTION ({$count_send_fund}) \n";
			$fields = array('Payment ID', 'Name', 'Amount', 'Discount Rate', 'Tran.Fee', 'H.Reserve', 'Total'); 
			$excelData.="\n". implode("\t", array_values($fields)) . "\n";
			foreach ($send_fund_data as $fields) {
			$strans = explode(";", $fields);
			$fields = array($strans[0],$strans[1],$strans[2],$strans[3],$strans[4],$strans[5],$strans[6]);
			$excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
			}
			//=======================================
		}
		$data_received_fund= $pdf->LoadData($received_fund_data);
		if(!empty($data_received_fund)){
			$pdf->ImprovedTable($header,$data_received_fund,"RECEIVED FUND TRANSACTION ({$count_received_fund}) ",10);
			 			//============excel===================	
			$excelData.="\n \n RECEIVED FUND TRANSACTION ({$count_received_fund}) \n";
			$fields = array('Payment ID', 'Name', 'Amount', 'Discount Rate', 'Tran.Fee', 'H.Reserve', 'Total'); 
			$excelData.="\n". implode("\t", array_values($fields)) . "\n";
			foreach ($received_fund_data as $fields) {
			$strans = explode(";", $fields);
			$fields = array($strans[0],$strans[1],$strans[2],$strans[3],$strans[4],$strans[5],$strans[6]);
			$excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
			}
			//=======================================

		}
		$datac = $pdf->LoadData($cancelled_data);
		if(!empty($datac)){
			$pdf->ImprovedTable($header,$datac,"FAILED TRANSACTION ({$count_failed}) ",10);
			
			//============excel===================		
			$excelData.="\n \n FAILED TRANSACTION ({$count_failed}) \n";
			
			$fields = array('Payment ID', 'Name', 'Amount', 'Discount Rate', 'Tran.Fee', 'H.Reserve', 'Total'); 
			$excelData.="\n". implode("\t", array_values($fields)) . "\n";
			
			foreach ($cancelled_data as $fields) {
			$strans = explode(";", $fields);
			$fields = array($strans[0],$strans[1],$strans[2],$strans[3],$strans[4],$strans[5],$strans[6]);
			$excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
			}
			//============excel===================	
	
		}
		$datarf = $pdf->LoadData($refunded_data);
		if(!empty($datarf)){
			$pdf->ImprovedTable($header,$datarf,"REFUNDED TRANSACTION ({$count_refunded}) ",10);
			//============excel===================		
			$excelData.="\n \n REFUNDED TRANSACTION ({$count_refunded}) \n";
			
			$fields = array('Payment ID', 'Name', 'Amount', 'Discount Rate', 'Tran.Fee', 'H.Reserve', 'Total'); 
			$excelData.="\n". implode("\t", array_values($fields)) . "\n";
			
			foreach ($refunded_data as $fields) {
			$strans = explode(";", $fields);
			$fields = array($strans[0],$strans[1],$strans[2],$strans[3],$strans[4],$strans[5],$strans[6]);
			$excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
			}
			//============excel===================
		}
		$data_chargeback = $pdf->LoadData($chargeback_data);
		if(!empty($data_chargeback)){
			$pdf->ImprovedTable($header,$data_chargeback,"CHARGEBACK TRANSACTION ({$count_chargeback}) ",10);
			//============excel===================	
			$excelData.="\n \n CHARGEBACK TRANSACTION ({$count_chargeback}) \n";
			$fields = array('Payment ID', 'Name', 'Amount', 'Discount Rate', 'Tran.Fee', 'H.Reserve', 'Total'); 
			$excelData.="\n". implode("\t", array_values($fields)) . "\n";
			foreach ($chargeback_data as $fields) {
			$strans = explode(";", $fields);
			$fields = array($strans[0],$strans[1],$strans[2],$strans[3],$strans[4],$strans[5],$strans[6]);
			$excelData.="\n". str_replace(";"," ",implode("\t", array_values($fields)));
			}
			//=======================================
		}
		$datar = $pdf->LoadData($returned_data);
		if(!empty($datar)){
			$pdf->ImprovedTable($header,$datar,"RETURNED TRANSACTION ({$count_returned}) ",10);
		}
		$datacbk1 = $pdf->LoadData($cbk1_data);
		if(!empty($datacbk1)){
			$pdf->ImprovedTable($header,$datacbk1,"CBK1 TRANSACTION ({$count_cbk1}) ",10);
		}
		
		if($sales_volume>0){
			if(!empty($data) || !empty($datac) || !empty($datar) || !empty($datacbk1) || !empty($datarf)){
				$pdf->ImprovedTable($header_total,$data_total = array(''),'',0,true);
			}
		}

	/*
		$html = 'Error of the system generated reported should be reported by the merchant asap. MSP hold the right to adjust the difference manually.';

		$pdf->Ln(4);

		//$pdf->Image('logo.png',10,50,30,0,'','');
		//$pdf->SetLeftMargin(45);
		$pdf->SetFontSize(7);
		$pdf->WriteHTML($html);
		*/


		$newdata['filename']=$post['company_name']."_payout_".$newdata['from_date']."_to_".$newdata['to_date'].".pdf";
		$filename=$newdata['filename']; 

if(empty($ptdate)){
	if($wd_status==2){
		$data['Error']="This Withdrawal has been Cancelled";
	}elseif($wd_tran[0]['trname']!="wd"){
		$data['Error']="Withdrawal type is missing";
	}elseif(empty($account_cur)){
		$data['Error']="Account Currency is missing";
	}elseif(empty($req_currency)){
		$data['Error']="Requested Bank Currency is missing";
	}
}




//$format="excel";
if($_REQUEST['format']=="excel"){
$fileName = $post['company_name']."_payout_".$newdata['from_date']."_to_".$newdata['to_date'].".xls";
header('Content-Type: application/xls');
header('Content-Disposition: attachment; filename='.$fileName);
header('Expires: 0');
header("Pragma: public");
header('Cache-Control: no-cache');
echo $exceltitle."\n".$excelData;
exit;
}

if($_REQUEST['format']=="word"){
$fileName = $post['company_name']."_payout_".$newdata['from_date']."_to_".$newdata['to_date'].".doc";
header('Content-Encoding: UTF-8');
header("Content-type: application/x-ms-download"); //#-- build header to download the word file 
header('Content-Disposition: attachment; filename='.$fileName);
echo $exceltitle."\n".$excelData;
exit;
}

	
if($data['Error']){
	json_print($data['Error']);
}
	
	if($json_access==false){
		if($pdf_download==true){
			if($adm_login==true){
				$pdf->Output();
			}else{
				$pdf->Output('D',$filename,true);
			}
		}else{ /*echo"<script>alert('Fail to download the report please email support@duspay.com for assistance.');</script>";*/
		}
		//$pdf->Output();
	}else{
		$json["available_payout"]=$available_payout_amt;
		$json["completed_count"]=$completed_count;
		$json["completed_trid"]=$completed_trid;
		$json["settlement_link_view"]=$settlement_link_view;
		
		header("Content-Type: application/json", true);
		echo json_encode($json);

	}	
		
			

	
	
}



?>