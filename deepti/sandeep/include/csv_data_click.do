<?
	
//http://localhost/ztswallet/include/csv_data.do?bid=24

//http://localhost/ztswallet/include/csv_data.do?bid=All



$mid="";$uid="";
if(isset($_GET['bid'])&&$_GET['bid']){
	$mid="[".$_GET['bid']."]";
	$uid=$_GET['bid'];
}

$filename = "transaction_Download_{$mid}_".date("Ymd").".csv";

$qprint=0;
if(isset($_GET['a'])&&$_GET['a']==1){
//if(isset($_GET['ptdate'])){
	$qprint=1;
	
}else{
	// output headers so that the file is downloaded rather than displayed
	header("Pragma: public");
	header('Pragma: no-cache');
	header("Expires: 0"); 
	header("Cache-Control: must-revalidate, post-check=0, pre-check=0");

	header('Content-Type: text/csv; charset=utf-8');
	header("Content-Disposition: attachment; filename=".$filename."");




	// force download  
	header("Content-Type: application/force-download");
	header("Content-Type: application/octet-stream");
	header("Content-Type: application/download");


	// create a file pointer connected to the output stream
	$output = fopen('php://output', 'w');

}

//include('../config_db.do');
include('../config.do');
//error_reporting(0);

	

function replaces_amt($fileds){
	//$fileds = str_replace(array(",","-","."),array(" ","",""),$fileds);
	//return number_formatf($fileds);
	return number_format((double)$fileds, '2', '.', '');
}

function replacesph($fileds){
	$filed = str_replace(array(",","-","."),array(" ","",""),$fileds);
	return $filed;
}
function replaces($fileds){
	$fileds = str_replace(array(",","-",".","'","’","<",">"),array(" "," ","","","","",""),$fileds);
	$fileds = preg_replace( '@^(<br\\b[^>]*/?>)+@i', '', $fileds );
	return $fileds;
}
function replaces2($fileds){
	$filed = str_replace(',',' ',$fileds);
	return $filed;
}
function replaces3($fileds){
	$filed = str_replace(',',' ',$fileds);
	return $filed;
}
function datef($date){
	if($date){
		$dates = date('m/d/Y');
		$dates = str_replace('-','/',$dates);
	}else {
		$dates = " ";
	}
	return $dates;
}




if(!isset($_SESSION['login_adm'])){
       //header("Location:{$data['USER_FOLDER']}/login.do");
       echo('ACCESS DENIED.');
       exit;
}

$id = "";

if((isset($_GET['id']))&&($_GET['id'])&&(!isset($_GET['pay_type']))){
	$id_ex = explode(',', $_GET['id']);
	foreach($id_ex as $value){
		//$id .= " `id`='".$value."' OR ";
		$id .= " `unique_id`='".$value."' OR ";
	}
	
	$id = substr_replace($id,'', strrpos($id, 'OR'), 3);
}elseif((isset($_GET['bid']))&&($_GET['bid'])){
	//$id=" ( `receiver`={$_GET['bid']} OR `sender`={$_GET['bid']} ) ";
}else {
	//$id = " `id`='1' OR `id`='2' ";
}

if(isset($_GET['bid'])&&$_GET['bid']=="All"){
	
	$where="  "; $id="  ";
}else {
	$where=" WHERE ";
}

if((isset($_GET['id']))&&($_GET['id'])&&(isset($_GET['pay_type']))){
	// in withdraw wise
	
	$wmp=withdraw_max_prev($_GET['bid'],$_GET['id']);
	
	
	//print_r($wmp);
	//exit;
	
	
	$created_date_prev=date('Ymd',strtotime($wmp['tdate']));
	//$created_date=date('Ymd',strtotime($wmp['c_tdate']));
	$created_date=date("Ymd",strtotime("+1 day",strtotime($wmp['c_tdate'])));
	//$created_date=date("Ymd",strtotime("+1 day",strtotime($wmp['c_tdate'])));
				
	$id .= " AND (payout_date BETWEEN (DATE_FORMAT('{$created_date_prev}', '%Y%m%d')) AND (DATE_FORMAT('{$created_date}', '%Y%m%d'))) AND ((status NOT IN (0)) AND (status NOT IN (9)) AND (status NOT IN (10))) ";
				
}
elseif(isset($_GET['ptdate'])&&$_GET['ptdate']){
	
	$date_2nd=date("Ymd",strtotime("+1 day",strtotime($_GET['ptdate'])));
				
	if(isset($_GET['pfdate'])&&$_GET['pfdate']){
		$date_1st=date("Ymd",strtotime("+0 day",strtotime($_GET['pfdate'])));
	}else{
		//$date_1st=$date_2nd;
		$date_1st=date("Ymd",strtotime("+0 day",strtotime($_GET['ptdate'])));
	}
	
	$id .=" ( (payout_date BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')))  AND  ( status NOT IN (0,9,10) )    )  ";
	
	if(isset($_GET['ma'])&&$_GET['ma']){
		//$id .=" AND ((payout_date BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')))  AND  ( (status NOT IN (0)) AND (status NOT IN (9)) AND (status NOT IN (10)) ))  ";
	}else{
	//$id .=" AND ( ((payout_date BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')))  AND  ( (status NOT IN (0)) AND (status NOT IN (9)) AND (status NOT IN (10)) ))   OR   ((payout_date NOT BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')))  AND  ( (status NOT IN (0)) AND (status NOT IN (9)) AND (status NOT IN (10)) ))  ) ";
	}
	
	if(isset($_GET['ma'])&&$_GET['ma']){
		
	}
	
	
}

		
		$receiver = db_rows("SELECT GROUP_CONCAT(DISTINCT(`receiver`)) as `receiver` FROM `{$data['DbPrefix']}transactions` {$where} ".$id."  ORDER BY  `tdate` ".
			" DESC LIMIT 1 ".
			"",$qprint); 
		
			
		//$rows = db_rows("SELECT * FROM `{$data['DbPrefix']}transactions` {$where} ".$id."  ORDER BY  `tdate`  ",$qprint);
		
		$sizeof=sizeof($receiver);
		
		if($qprint){
			echo '<br/>'. $receiver_id=$receiver[0]['receiver'];
		}
		$receiver_arr=[];
		if($receiver_id){
			$receiver_arr=explode(',',$receiver_id);
		}
		
		
//	'amount Order Amount', 'transaction_amt Transaction Amount', 	
// 'mdr_amt Discount Rate', 'mdr_txtfee_amt Transaction Fee', 'rolling_amt Rolling Fee', 'payable_amt_of_txn Payout Amount ', 'available_balance Balance', 'payout_date Mature Date', 'future_field7', 'future_field8', 'future_field9',

		// output the column headings
fputcsv($output, array("Sl.", 'transaction_id', 'mid', 'username', 'CompanyName', 'PayoutAmount', 'BankName', 'IfscCode', 'AccountNumber'));

//fputcsv($output, $dataset);
	
		
		$i=1;
		// loop over the rows, outputting them
		foreach($receiver_arr as $value){
			$da_se = array();$wp = array();
			
			$uid=$value;
			if($qprint){echo '<br/>'.$uid;}
			$da_se['bid']=$uid;
			$da_se['curl']="1";
			$da_se['admin']="1";
			//$da_se['curl']="1";
			
			
			
			
			
			$w_url=$data['USER_FOLDER']."/withdraw.do?curl=1&admin=1&bid=".$uid;
			$wp=use_curl($w_url,$da_se);
			$wp=jsondecode($wp);
			
			
			
			

			$dataset = array();
			
			$dataset[] .= $i;
			
			$dataset[] .= date('YmdHis');
			$dataset[] .= $uid;
			$dataset[] .= $wp['username'];
			$dataset[] .= $wp['company_name'];
			$dataset[] .= ($wp['payout_amount']);//number_formatf2
			$dataset[] .= $wp['bname'];
			$dataset[] .= $wp['bswift'];
			$dataset[] .= $wp['baccount'];
			
			
			if($qprint){
				echo '<br/>ab=>'; 
				print_r($dataset); 
				
				echo '<br/>wp=>'; 
				print_r($wp); 
			
				//exit;
			}
			
			
			
			$i++;
			
			fputcsv($output, $dataset);
			
		}





?>