<?
$data['PageName']	= 'PDF PAYOUT STATEMENTS - Fee Dynamic from Account';
$data['PageFile']	= '';
###############################################################################
include('config.do');
//$data['PageTitle'] = 'PDF Payout Statements - '.$data['domain_name'];
###############################################################################

###############################################################################

if(!$_SESSION['adm_login'] && !$_SESSION['login']){
        header("Location:{$data['USER_FOLDER']}/login.do");
        echo('ACCESS DENIED.');
        exit;
}

$adm_login=false;
$json_access=false;
if($_SESSION['adm_login'] && isset($_GET['bid'])){
	$adm_login=true;
	if(isset($_GET['json'])){
		$json_access=true;
	}
}

$pfdate="";$ptdate="";
if($adm_login==true){
	$uid 	= $_GET['bid'];
	$pfdate	= $_GET['pfdate'];
	$ptdate	= $_GET['ptdate'];
	
}else{
	$ptdate = date("Y-m-d");
}

$qprint=0;
if(isset($_GET['qp'])){
	$qprint=1;
}

//print_r($_GET);
/*
if(isset($_GET['type'])){$account_type=$_GET['type'];}
if(isset($_GET['type']) && $_GET['type']<0 ){$account_type=12;}
//else{$account_type=12;}
*/


//echo "<br/><br/>".$ptdate; echo "<br/><br/>".$uid;



$post=select_info($uid, $post);
if(!$post['step'])$post['step']=1;

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
if($post['AccountsInfo']){
	foreach($post['AccountsInfo'] as $key=>$value){
		if(($value['account_login_url']==1)&&($value['nick_name'])) {
			$account_type_arr[]=$value['nick_name']; // as per last assign
			$nick_name_card .= $value['nick_name'].",";
			$account_type_value.=" `type`={$value['nick_name']} OR ";
			$nick_name .= $data['t'][$value['nick_name']]['name2'].", ";
			if($value['primary']=="1"){
				$primary_acc=$value['nick_name'];
			}
			
			
			if($value['virtual_fee']){
				$virtual_terminal_fee=$virtual_terminal_fee+$value['virtual_fee'];
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

$profile=db_rows(
	"SELECT * FROM `{$data['DbPrefix']}clientid_table`".
	" WHERE ( `id`={$uid} ) ".
	" ORDER BY `id` ASC LIMIT 1",0
);
//print_r($profile);
$account_cur=$profile[0]['default_currency'];
$account_sys=get_currency($account_cur);


$wmp=withdraw_max_prev($uid,$post['gid']);
$wd_created_date_prev=date('Ymd',strtotime($wmp['tdate']));


$wd_tran=db_rows(
	"SELECT * FROM `{$data['DbPrefix']}transactions`".
	" WHERE ( `sender`={$uid} ) AND (`id`={$post['gid']})".
	" ORDER BY `id` ASC LIMIT 1",0
);
$wd_status=$wd_tran[0]['status'];
$transaction_amt_wd=$wd_tran[0]['transaction_amt'];
//print_r($wd_tran);

$wd_json_value=json_decode($wd_tran[0]['json_value'],true);
//print_r($wd_json_value);

if($wd_json_value['wd_account_curr']!=$wd_json_value['wd_requested_bank_currency']){
	if($wd_json_value['wd_payable_amt_of_txn_from']){
		$transaction_amt_wd=$wd_json_value['wd_payable_amt_of_txn_from'];
	}
}

$wd_transaction_period=$wd_json_value['wd_transaction_period'];
$wd_tran_id=$wd_json_value['wd_tran_id'];
//$wd_tran_id.=",16,17,18,19,20";
//echo "<hr/>wd_tran_id=>".$wd_tran_id;

if(isset($wd_json_value['wd_created_date'])&&$wd_json_value['wd_created_date']){
	$wd_created_date=$wd_json_value['wd_created_date'];
}else{
	$wd_created_date=$wd_tran[0]['tdate'];
}




$req_currency=$wd_json_value['wd_requested_bank_currency'];
//$wd_created_date=date('Ymd',strtotime($wd_created_date)); 
$wd_created_date=date("Ymd",strtotime("+1 day",strtotime($wd_created_date)));

$tdate=date('Ymd',strtotime($wd_tran[0]['tdate']));


if($pfdate&&$ptdate){
	$wd_created_date_prev=date('Ymd',strtotime($pfdate));
	$wd_created_date=date("Ymd",strtotime("+1 day",strtotime($ptdate)));
	$account_type_whr=" AND (`payout_date` BETWEEN (DATE_FORMAT('{$wd_created_date_prev}', '%Y%m%d')) AND (DATE_FORMAT('{$wd_created_date}', '%Y%m%d')))";
}else{
	//	tdate
	$account_type_whr=" AND (`payout_date` BETWEEN (DATE_FORMAT('{$wd_created_date_prev}', '%Y%m%d')) AND (DATE_FORMAT('{$wd_created_date}', '%Y%m%d')))";
}

//$wd_tran_id_qry = "AND ( (`id`=".implode(') OR (`id`=',array_unique(explode(',',$wd_tran_id))).") )"; $account_type_whr=$wd_tran_id_qry ;


//$account_type_whr=" AND ( (DATE_FORMAT(`payout_date`, '%Y%m%d')) <= (DATE_FORMAT({$wd_created_date}, '%Y%m%d')) ) AND ( id between ".$wd_transaction_period." )";

if(isset($_GET['f'])&&($_GET['f']==1)){
	
	$wd_created_date=date('Ymd',strtotime($wd_json_value['wd_created_date'])); 
	$account_type_whr=" AND (`payout_date` BETWEEN (DATE_FORMAT('{$wd_created_date_prev}', '%Y%m%d')) AND (DATE_FORMAT('{$wd_created_date}', '%Y%m%d')))";
	
	//$account_type_whr=" AND ( `payout_date` <= now() ) AND ( id between ".$wd_transaction_period." )";
}elseif(isset($_GET['f'])&&($_GET['f']==2)){
	$account_type_whr=" AND ( (DATE_FORMAT(`payout_date`, '%Y%m%d')) <= (DATE_FORMAT({$tdate}, '%Y%m%d')) ) AND ( id between ".$wd_transaction_period." )";
}elseif(isset($_GET['f'])&&($_GET['f']==3)){
	$account_type_whr=" AND ( (DATE_FORMAT(`payout_date`, '%Y%m%d')) <= (DATE_FORMAT(now(), '%Y%m%d')) ) AND ( id between ".$wd_transaction_period." )";
}




$settelement_wire_fee=$profile[0]['settlement_fixed_fee'];//$wd_json_value['wd_wire_fee'];

//Monthly  Maintance Fee
//$monthly_maintance_fee=$wd_json_value['wd_total_monthly_fee'];
$monthly_maintance_fee=$wd_json_value['wd_total_month_no']*$profile[0]['monthly_fee'];
$min_settelement_amt=$profile[0]['settlement_min_amt'];  

$store_id=$wd_json_value['wd_store_id'];

//echo "<hr/>monthly_maintance_fee=>".$monthly_maintance_fee;
//exit;

###############################################################################






$cdate1 = $ptdate; //date("Y-m-d"); "2017-06-18"; //date("2017-06-06");

$dateset = date('d-m-Y',strtotime($cdate1)); 
$sunday = date('D', strtotime($dateset));
if($sunday=="Sun")$dateset=date("Y-m-d",strtotime("-1 day",strtotime($dateset)));
if($payout_days_name=="Wednesday"){
	if($sunday=="Mon")$dateset=date("Y-m-d",strtotime("-2 day",strtotime($dateset)));
	elseif($sunday=="Tue")$dateset=date("Y-m-d",strtotime("-3 day",strtotime($dateset)));
}
$newdata = array();
global $newdata;
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
$settlement_link_view="no";
$available_payout_amt=0;
if(date("Ymd")>=date("Ymd",strtotime($newdata['settlement_date']))){
	$settlement_link_view="OK";
}




###############################################################################


$newdata['paydate']=$wd_tran[0]['tdate'];
$newdata['from_date']=date('Y-m-d',strtotime($wd_created_date_prev));
$newdata['to_date']=date("Ymd",strtotime("-1 day",strtotime($wd_created_date)));
$newdata['settlement_date']=$wd_tran[0]['tdate'];

###############################################################################


if($pfdate&&$ptdate){
	$newdata['paydate']=date('Y-m-d');
	$newdata['from_date']=date('Y-m-d',strtotime($pfdate));
	$newdata['to_date']=date('Y-m-d',strtotime($ptdate));
	$newdata['settlement_date']=date('Y-m-d',strtotime($ptdate));
}


if($_GET['test']=="ok"){
	
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

if($post['step']==1){
				
			if( strtotime($newdata['first_week_payout_date']) == strtotime($newdata['paydate'])){
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
				$account_type_whr.=" AND (`trname`='cn' OR `trname`='ch' OR `trname`='af') ";
			}


			$payout_mature=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}transactions`".
				" WHERE (`receiver`={$uid} OR `sender`={$uid} ) AND ((status NOT IN (0)) AND (status NOT IN (9)) AND (status NOT IN (10))) ".$account_type_whr.
				" ORDER BY `id` ASC",$qprint
			);
			
			$total_size=sizeof($payout_mature);
			
			$post['payout_mature']=$payout_mature;
			
			
			
			//-----------------------------
			
			
						
			$pdf_download=false;
			
						
			$transactions_dis=db_rows(
				"SELECT GROUP_CONCAT(DISTINCT `store_id`) AS `store_id` FROM `{$data['DbPrefix']}transactions`".
				" WHERE (`receiver`={$uid} OR `sender`={$uid} ) ".$account_type_whr.
				" ORDER BY `id` ASC LIMIT 1",0
			);
			
			
			 $store_id=$transactions_dis[0]['store_id'];
			 
			 
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
					if($value['primary']=="1"){
						$pdf_download=true;
					}
				}
			}
			
			if($account_cur==$req_currency){
				$pdf_download=true;
			}
			
			if($account_cur!=$req_currency){
				//echo "<hr/>account_cur=> ".$account_cur; echo "<hr/>req_currency=> ".$req_currency;
				
				$currency_rate=true;
				$pdf_download=true;
			}
		
			
			
			 
		/* start:pdf */

		
		
		if($adm_login==true){
			require('pdf/fpdfa.php');
		}else{
			require('pdf/fpdf.php');
		}
		//require('pdf/fpdf.php');

		
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
				$this->Cell(30,0,'Merchant Statement',0,0,'C');
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
				
				
			}


			

			// 7 Col table
			function ImprovedTable($header, $data, $titlename, $titleln=0, $fill=false){
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
				$w = array(40, 45, 20, 20, 25, 22, 20);
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
						$this->Cell($w[0],6,$row[0],0,0);
						$this->Cell($w[1],6,$row[1],0);
						$this->Cell($w[2],6,$row[2],0,0,'C');
						$this->Cell($w[3],6,$row[3],0,0,'C');
						$this->Cell($w[4],6,$row[4],0,0,'C');
						$this->Cell($w[5],6,$row[5],0,0,'C');
						$this->Cell($w[6],6,$row[6],0,0,'C');
						$this->Ln();
					}
				}
				// Closing line
				$this->Cell(array_sum($w),0,'','T');
			}
			
			
			// 3 col table
			function ImprovedThreeColTable($data, $titlename, $titleln=0, $fontname=false, $fontcolor=0){
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
				
				if($fontcolor==1){
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
				$this->Cell(array_sum($w),0,'','T');
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



		$header 		= array('Payment ID', 'Name', 'Amount', 'Discount Rate', 'Fee', 'Holdback Reserve', 'Total');
		$completed_data = array();
		$cancelled_data = array();
		$refunded_data = array();
		$returned_data 	= array();
		$cbk1_data 	= array();
		

		$total_txn_fee 	= 0;
		$total_dis_rate = 0;
		$total_rol_fee	= 0;
		
		$sales_volume	= 0;
		$refund_volume	= 0;
		$returns_volume	= 0;
		$cbk1_volume	= 0;
		
		$total_refund_fee = 0;
		$total_returns_fee = 0;
		$total_cbk1_fee = 0;
		
		$completed_count=0;
		$completed_trid="";
		
		$total_withdraw="";
		$total_send_fund="";
		$total_received_fund="";
		
		$total_chargeback_fee="";
		$chargeback_volume="";
			
		
		foreach($post['payout_mature'] as $key=>$value){
			//$pdf->Cell(0,10,$value['transaction_id']."       ".$value['transaction_amt'],0,1);
			/*
			$accounts_gt=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}account`".
				" WHERE `clientid`={$uid} AND `nick_name`='".$value['type']."' ".
				" LIMIT 1"
			);
			$accounts=$accounts_gt[0];
			*/
			
			if(!$value['acquirer_json']){
				$value['transaction_id']=$value['transaction_id'].".";
			}
			
			$accounts=jsondecode($value['acquirer_json']);
			
			
			$trname=strtoupper($value['trname']);
			
			if($value['status']==1 || $value['status']==14){
				$completed_count=$completed_count+1;
				$completed_trid.=$value['transaction_id'].",";
			}
			
			
			if(($value['status']==1 || $value['status']==4 || $value['status']==7 || $value['status']==8)&&($value['trname']=='cn'||$value['trname']=='ch')){ // completed
				$dis_rate 	= number_formatf(($value['transaction_amt']/100)*$accounts['transaction_rate']);
				$rol_fee	= number_formatf(($value['transaction_amt']/100)*$accounts['rolling_fee']);
				$this_total	= number_formatf2(($value['transaction_amt'])-($dis_rate+$accounts['txn_fee']+$rol_fee));
				
				$total_txn_fee = $total_txn_fee+$accounts['txn_fee'];
				
				$total_dis_rate = $total_dis_rate + $dis_rate;
				$total_rol_fee	= $total_rol_fee + $rol_fee;
				
				$sales_volume	= number_formatf2($sales_volume+$value['transaction_amt']);
				
				$completed_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".number_formatf2($dis_rate).";".number_formatf2($accounts['txn_fee']).";".number_formatf2($rol_fee).";".number_formatf2($this_total)."";
			}
			if(($value['status']==2)&&($value['trname']=='cn'||$value['trname']=='ch')){ // canceled
				$dis_rate 	= "0";
				$rol_fee	= "0";
				//$this_total	= number_formatf($accounts['txn_fee']);
				
				if($accounts['txn_fee_failed']){
					$this_total=($accounts['txn_fee_failed']);
				}else{
					$this_total=($accounts['txn_fee']);
				}
				
				$total_txn_fee = number_formatf($total_txn_fee+$accounts['txn_fee']);
				
				$cancelled_data[] .= $value['transaction_id'].";".$value['names'].";".number_formatf2($value['transaction_amt']).";".$dis_rate.";".$this_total.";".$rol_fee.";-".number_formatf($this_total)."";
				
				
			}
			
			
			
			// withdrawal fund 
		
			if(($value['status']!=2)&&($value['trname']=='wd')){ // canceled
				$dis_rate 	= "0";
				$rol_fee	= "0";
				
				$total_withdraw = number_formatf2($total_withdraw - $value['amount']);
				
				$withdraw_data[] .= $value['transaction_id'].";".$value['names'].";".number_formatf2($value['amount']).";".$dis_rate.";".$value['mdr_txtfee_amt'].";".$rol_fee.";".number_formatf2($value['amount'])."";
				
				
			}
			
			if(($value['status']!=2)&&($value['trname']=='af')&&($value['sender']==$uid)){ // canceled
				$dis_rate 	= "0";
				$rol_fee	= "0";
				
				
				if($total_send_fund && $value['amount']) {
					$total_send_fund = number_formatf2($total_send_fund - $value['amount']);
				}
				
				$send_fund_data[] .= $value['transaction_id'].";".$value['names'].";".number_formatf2($value['amount']).";".$dis_rate.";0;".$rol_fee.";".number_formatf2($value['amount'])."";
				
				
			}
			
			if(($value['status']!=2)&&($value['trname']=='af')&&($value['receiver']==$uid)){ // canceled
				$dis_rate 	= "0";
				$rol_fee	= "0";
				
				$total_received_fund = number_formatf2($total_received_fund - $value['amount']);
				
				$received_fund_data[] .= $value['transaction_id'].";".$value['names'].";".str_replace_minus(number_formatf2($value['amount'])).";".$dis_rate.";0;".$rol_fee.";".str_replace_minus(number_formatf2($value['amount']))."";
				
				
			}
			
			
			//after reverse 
			
			
			if($value['status']==3 || $value['status']==12){ // Refunded and Partial Refund
				
				$refund_fee=number_formatf($accounts['refund_fee']);
				
				$dis_rate 	= "0";
				$rol_fee	= number_formatf(($value['transaction_amt']/100)*$accounts['rolling_fee']);
				$this_tr_fee= $refund_fee;
				
				
				$this_total	= number_formatf2($value['transaction_amt']-($refund_fee-$rol_fee)); // 45
				
				
				$refund_volume	= number_formatf2($refund_volume-$value['transaction_amt']);
				
				$total_rol_fee	= ($total_rol_fee - $rol_fee);
				
				$total_refund_fee = number_formatf2($total_refund_fee+$refund_fee); 
				
				
				$refunded_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".$dis_rate.";-".number_formatf2($this_tr_fee).";".$rol_fee.";".$this_total."";
				
			}
			if($value['status']==11){ // cbk1 
				
				$cbk1_fee=number_formatf($accounts['cbk1']);
				
				$dis_rate 	= "0";
				$rol_fee	= number_formatf(($value['transaction_amt']/100)*$accounts['rolling_fee']);
				$this_tr_fee= $cbk1_fee;
				
				
				$this_total	= number_formatf2($value['transaction_amt']-($cbk1_fee-$rol_fee)); // 45
				
				
				
				$cbk1_volume	= number_formatf2($cbk1_volume-$value['transaction_amt']);
				
				$total_rol_fee	= number_formatf($total_rol_fee - $rol_fee);
				
				$total_cbk1_fee = number_formatf($total_cbk1_fee+$cbk1_fee); 
				
				
				$cbk1_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".$dis_rate.";-".number_formatf2($this_tr_fee).";".$rol_fee.";".$this_total."";
				
				
			}
			if($value['status']==5){ // Chargeback 
				
				$dis_rate 	= "0";
				$rol_fee	= number_formatf(($value['transaction_amt']/100)*$accounts['rolling_fee']);
				$this_tr_fee= $charge_back_fee;
				
				
				$this_total	= number_formatf2($value['transaction_amt']-($charge_back_fee-$rol_fee)); // 45
				
				
				
				$chargeback_volume	= number_formatf2($chargeback_volume-$value['transaction_amt']);
				
				$total_rol_fee	= number_formatf($total_rol_fee - $rol_fee);
				
				$total_chargeback_fee = number_formatf2($total_chargeback_fee+$charge_back_fee); //3 tire wise risk ratio
				
				
				$chargeback_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".$dis_rate.";-".number_formatf2($this_tr_fee).";".$rol_fee.";".$this_total."";
				
				
			}
			
			if($value['status']==6){ // Returned 
			
				$dis_rate 	= "0";
				$rol_fee	= number_formatf(($value['transaction_amt']/100)*$accounts['rolling_fee']);
				$this_tr_fee= $return_back_fee;
				
				
				$this_total	= number_formatf2($value['transaction_amt']-($return_back_fee-$rol_fee)); // 45
				
				
				
				$returns_volume	= number_formatf2($returns_volume-$value['transaction_amt']);
				
				$total_rol_fee	= number_formatf($total_rol_fee - $rol_fee);
				
				$total_returns_fee = number_formatf($total_returns_fee+$return_back_fee); //45  as per risk ratio and account 1 from 3
				
				
				$returned_data[] .= $value['transaction_id']."/".$trname.";".$value['names'].";".number_formatf2($value['transaction_amt']).";".$dis_rate.";-".number_formatf2($this_tr_fee).";".$rol_fee.";".$this_total."";
			}
			
			
			
			
		}
		
		
		
		
		
		
		

$header_total 	= array(' ', 'Total', ' ', number_formatf2($total_dis_rate), number_formatf2($total_txn_fee), number_formatf2($total_rol_fee), '');
		
		
		
$data_profie 	= array();
$data_profie[] 	.= "  Store ID;:  ".$store_id."; Account Currency;:  ".$account_cur;
$data_profie[] 	.= "  Payment Type;:  ".$nick_name."; Settlement Currency;:  ".$req_currency."";
$data_profie[] 	.= "  Chargeback Ratio;:  ".$post['total_lead']."%; Settlement Date;:  ".date("F d,Y",strtotime($newdata['settlement_date']))."";



$data_pro = $pdf->LoadData($data_profie);
$pdf->ImprovedFourColTable($data_pro,'');

	$datas_seles 	= array("Sales Volume;".number_formatf2($sales_volume).";$account_cur");
	if($total_received_fund){
		$datas_received_f[]	= "Received Fund;".number_formatf2($total_received_fund).";$account_cur";
	}

$datas_over 	= array();
	if($total_withdraw){
	$datas_over[] 	.= "Withdraw;".number_formatf2($total_withdraw).";$account_cur";
	}
	if($total_send_fund){
	$datas_over[] 	.= "Send Fund;".number_formatf2($total_send_fund).";$account_cur";
	}
	
	$datas_over[] 	.= "Discount Rate;".number_formatf2($total_dis_rate).";$account_cur";
	$datas_over[] 	.= "Transaction Fee;".number_formatf2($total_txn_fee).";$account_cur";
	
	if($refund_volume){
		$datas_over[] 	.= "Refund;".number_formatf2($refund_volume).";$account_cur";
		$datas_over[] 	.= "Refund Fee;".number_formatf2($total_refund_fee ).";$account_cur";
	}
	
	if($chargeback_volume){
		$datas_over[] 	.= "Chargeback;".number_formatf2($chargeback_volume).";$account_cur";
		$datas_over[] 	.= "Chargeback Fee;".number_formatf2($total_chargeback_fee).";$account_cur"; 
	}
	if($returns_volume){
		$datas_over[] 	.= "Return;".number_formatf2($returns_volume).";$account_cur";
		$datas_over[] 	.= "Return Fee;".number_formatf2($total_returns_fee).";$account_cur"; 
	}
	
	if($cbk1_volume){
		if($cbk1_volume>0){$datas_over[] 	.= "CBK1;".number_formatf2($cbk1_volume).";$account_cur"; } // by Transaction List
		
		if($total_cbk1_fee>0){$datas_over[] 	.= "CBK1 Fee;".number_formatf2($total_cbk1_fee ).";$account_cur"; } // get by Account ex 45
			//$datas_over[] 	.= "Other Fees;0.00;$account_cur";
	}

	
	//if($total_returns_fee>0){}
	
	
	$datas_over[] 	.= "Holdback Reserve;".number_formatf2($total_rol_fee).";$account_cur";
if($monthly_maintance_fee){
	$datas_over[] 	.= "Monthly Maintance Fee @{$profile[0]['monthly_fee']}x{$wd_json_value['wd_total_month_no']} ;$monthly_maintance_fee;$account_cur"; // Fist Week of Month only 
	if($vt=="1"){$datas_over[] 	.= "Monthly Vitual Terminal Fee;$virtual_terminal_fee;$account_cur"; } // Fist Week of Month only 
	$mmf = $monthly_maintance_fee;
	if($vt=="1"){$mvtf = $virtual_terminal_fee;}
}else{
	$mmf = 0;
	$mvtf = 0;
}
//$datas_over[] .= "Settlement Wire Fee;75;$account_cur"; //fixed every week as per report genenrat

$reverse 		= number_formatf2(number_formatf2($refund_volume)+number_formatf2($returns_volume)+number_formatf2($total_withdraw)+number_formatf2($total_send_fund)-number_formatf2($total_received_fund)+number_formatf2($total_dis_rate)+number_formatf2($total_txn_fee)+number_formatf2($total_refund_fee)+number_formatf2($chargeback_volume)+number_formatf2($total_chargeback_fee)+number_formatf2($total_returns_fee)+number_formatf2($total_rol_fee)+$mmf+$mvtf)+number_formatf2($total_cbk1_fee)+number_formatf2($cbk1_volume);
$sales_volume	= number_formatf2($sales_volume);
$tpa			= $sales_volume-$reverse;



if($tpa<$min_settelement_amt){ 
	//$swf=0;
	$available_payout =$tpa;
	$nextselt="(Will be added to next Settlement)";
} else {
	
}

$swf=$settelement_wire_fee;
	$available_payout =$tpa-$settelement_wire_fee;
	$nextselt="";

	
	

$data = $pdf->LoadData($datas_seles);
$pdf->ImprovedThreeColTable($data,'OVERVIEW',7,false);

$data_rr = $pdf->LoadData($datas_received_f);
$pdf->ImprovedThreeColTable($data_rr,'',0,false);

$data_o = $pdf->LoadData($datas_over);
$pdf->ImprovedThreeColTable($data_o,'',0,false,1);

$datat = array("Gross Payout Amount ;".number_formatf2($tpa).";$account_cur");
$data = $pdf->LoadData($datat);
$pdf->ImprovedThreeColTable($data,'',0,true);
$data = $pdf->LoadData(array("Settlement Wire Fee;".number_formatf2($swf).";$account_cur"));
$pdf->ImprovedThreeColTable($data,'',0,false,1);
if(!empty($currency_rate) && ($available_payout>0)){
	//$pdf_download=true;
	/*
	$available_payout=number_formatf2($available_payout);
	$currency_conversion=(($available_payout*3)/100);
	$currency_conversion=number_formatf2($currency_conversion);
	
	$data = $pdf->LoadData(array("Currency Conversion $account_cur to $req_currency (3%);".$currency_conversion.";$account_cur"));
	$pdf->ImprovedThreeColTable($data,'',0,false,1);
	
	$available_payout=($available_payout-$currency_conversion);
	$available_payout=number_formatf2($available_payout);
	*/
}



//-------------------------
/*
echo "<hr/>transaction_amt=>".$transaction_amt_wd."<hr/>";
echo "<hr/>available_payout=>".$available_payout."<hr/>";
echo "<hr/>other_fee_temp=>".$other_fee_temp=$available_payout+$transaction_amt_wd."<hr/>";
echo "<hr/>available_payout=>".$available_payout=$available_payout-$other_fee_temp;
*/

if($transaction_amt_wd){
	//$other_fee_temp=$available_payout+$transaction_amt_wd; $available_payout=$available_payout-$other_fee_temp;
	
	$other_fee_temp=$available_payout-str_replace('-','',$transaction_amt_wd); $available_payout=$available_payout-$other_fee_temp;
	
}else{
	$other_fee_temp=0;
}

if($other_fee_temp){
	$data = $pdf->LoadData(array("Other Fee;".number_formatf2($other_fee_temp).";$account_cur"));
	$pdf->ImprovedThreeColTable($data,'',0,false,1);
}
//-------------------------


$available_payout_amt=$account_sys."<b>".$available_payout."</b>";
$data = $pdf->LoadData(array("Available Payout ".$nextselt." ;".number_formatf2($available_payout).";$account_cur")); //
$pdf->ImprovedThreeColTable($data,'',0,true);



if(!empty($currency_rate) && (str_replace_minus($available_payout)>0)){
	//$available_payout_exchange=($available_payout*$currency_rate);
	
	if($pfdate&&$ptdate){
		$available_payout_exchange=currencyConverter($account_cur,$req_currency,$available_payout,1);
	}else{
		$available_payout_exchange=str_replace('-','',$wd_tran[0]['transaction_amt']);
	}
	
	$available_payout_exchange=number_formatf2($available_payout_exchange);
	$available_payout_amt="<b>".$available_payout_exchange."</b> ".$req_currency;
	
	if($transaction_amt_wd){
		$data = $pdf->LoadData(array("Net Final Available Payout ".$nextselt." ;".$transaction_amt_wd.";$account_cur")); //
		$pdf->ImprovedThreeColTable($data,'',0,true);
	}
	
	$data = $pdf->LoadData(array("Net Final Available Payout ".$nextselt." ;".$available_payout_exchange.";$req_currency")); //
	$pdf->ImprovedThreeColTable($data,'',0,true);
}



	$pdf->AddPage();
	$pdf->SetFont('Helvetica','B',16);
	$pdf->ln(-8);
	$pdf->Cell(40,10,'Over All Summary ('.$total_size.')');

		$data = $pdf->LoadData($completed_data);
		if(!empty($data)){
			$pdf->ImprovedTable($header,$data,'COMPLETE TRANSACTION',10);
		}
		$data_withdraw = $pdf->LoadData($withdraw_data);
		if(!empty($dataw)){
			$pdf->ImprovedTable($header,$data_withdraw,'WITHDRAW TRANSACTION',10);
		}
		$data_send_fund = $pdf->LoadData($send_fund_data);
		if(!empty($data_send_fund)){
			$pdf->ImprovedTable($header,$data_send_fund,'SEND FUND TRANSACTION',10);
		}
		$data_received_fund= $pdf->LoadData($received_fund_data);
		if(!empty($data_received_fund)){
			$pdf->ImprovedTable($header,$data_received_fund,'RECEIVED FUND TRANSACTION',10);
		}
		$datac = $pdf->LoadData($cancelled_data);
		if(!empty($datac)){
			$pdf->ImprovedTable($header,$datac,'CANCELED TRANSACTION',10);
		}
		$datarf = $pdf->LoadData($refunded_data);
		if(!empty($datarf)){
			$pdf->ImprovedTable($header,$datarf,'REFUNDED TRANSACTION',10);
		}
		$data_chargeback = $pdf->LoadData($chargeback_data);
		if(!empty($data_chargeback)){
			$pdf->ImprovedTable($header,$data_chargeback,'CHARGEBACK TRANSACTION ',10);
		}
		$datar = $pdf->LoadData($returned_data);
		if(!empty($datar)){
			$pdf->ImprovedTable($header,$datar,'RETURNED TRANSACTION ',10);
		}
		$datacbk1 = $pdf->LoadData($cbk1_data);
		if(!empty($datacbk1)){
			$pdf->ImprovedTable($header,$datacbk1,'CBK1 TRANSACTION',10);
		}
		if(!empty($data) || !empty($datac) || !empty($datar) || !empty($datacbk1) || !empty($datarf)){
			$pdf->ImprovedTable($header_total,$data_total = array(''),'',0,true);
		}


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
		}else{ //echo"<script>alert('Fail to download the report please email support@{$data['SiteName']} for assistance.');</script>";
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



###############################################################################

//display('clients');

###############################################################################

?>