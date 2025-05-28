<?
	
// include/csv_data_clk.do?id=24



$id = "";


if((isset($_GET['id']))&&($_GET['id'])){
	$id=$_GET['id'];
}

$filename = "transaction_Download_{$id}_".date("Ymd").".csv";

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

include('../config_db.do');
//include('../config.do');
//error_reporting(0);


if(!isset($_SESSION['login_adm'])){
       echo('ACCESS DENIED.');
       exit;
}

function vlc($fileds){
	$result="  ";
	if($fileds){
		$result=$fileds;
	}else{
		$result="NA";
	}
	
	return $result;
}

		$pr_slc=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}auto_settlement_request`".
			" WHERE `id`={$id} ",$qprint
        );

		$sizeof=count($pr_slc);
		
		if($qprint){
			echo '<br/>';
			print_r($pr_slc);
		}
	
		if(isset($output)&&$output)
		fputcsv($output, array("Sl.", 'transID', 'Bank Reference No.', 'Bank Status', 'MDR Amt.', 'Transaction Fee', 'Wire Fee', 'Monthly Fee', 'Virtual Fee', 'GST Fee', 'mid', 'username', 'CompanyName', 'settlement Amt', 'settlement Currency', 'BankName', 'IfscCode', 'AccountNumber', 'Nodal Bank Status'));
	
		$i=1;
		
		$csv_json=jsondecode($pr_slc[0]['csv_json'],1,1);
		foreach($csv_json as $key=>$value){
			if(empty($value['Error'])){
				$csv=$value;
				
				$dataset = array();
				
				$dataset[] .= $i;
				$dataset[] .= vlc("'".@$csv['transID']);
				$dataset[] .= vlc("'".@$csv['MessageId']);
				$dataset[] .= vlc(@$csv['StatusCd']=='000'?"Success":@$csv['StatusCd']);
				$dataset[] .= vlc(@$csv['total_mdr_amt']);
				$dataset[] .= vlc(@$csv['total_mdr_txtfee_amt']);
				$dataset[] .= vlc(@$csv['settlement_fixed_fee']);
				$dataset[] .= vlc(@$csv['monthly_fee']);
				$dataset[] .= vlc(@$csv['virtual_fee']);
				$dataset[] .= vlc(@$csv['total_gst_fee']);
				$dataset[] .= vlc(@$csv['bid']);
				$dataset[] .= vlc(@$csv['username']);
				$dataset[] .= vlc(@$csv['company_name']);
				$dataset[] .= vlc(@$csv['settlementAmt']);
				$dataset[] .= vlc(@$csv['settlementCurrency']);
				$dataset[] .= vlc(@$csv['bname']);
				$dataset[] .= vlc(@$csv['bswift']);
				$dataset[] .= vlc("'".@$csv['baccount']);
				$dataset[] .= vlc(@$csv['StatusRem']);
				
				if($qprint){
					echo '<br/>';
					print_r($dataset);
				}
				
				$i++;
				
				if(isset($output)&&$output)
					fputcsv($output, $dataset);
			}
		}


?>