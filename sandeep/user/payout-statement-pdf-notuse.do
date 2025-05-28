<?php
include('../config.do');

$bid = $_REQUEST["bid"];

$result_select=db_rows_2(
	"SELECT * FROM `{$data['DbPrefix']}payout_beneficiary`".
	" WHERE `clientid`='{$bid}' AND status='1'".
	" ORDER BY id",0
);

foreach ($result_select as $key => $val) {
	$bene_list[$val['bene_id']] = $val;
}
$tbl="payout_transaction";
$field=" `transaction_status` = 1 AND `sub_client_id`='$bid' ";

$qry = "SELECT * FROM {$data['DbPrefix']}{$tbl} WHERE ".$field." ORDER BY 	transaction_date DESC";
$data['selectamount']=db_rows_2($qry);
$nor=count($data['selectamount']);

$title="Account Statement of ".$_REQUEST['bid']."<br>Total Records : ".$nor;
$html='<html lang="en"><style>html { margin: 0px}</style>';
$html.='<head><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" /></head>';
$html.='<body style="background-color: #fff;"><div class="container my-2 p-2" >';
$html.='<div class="my-2 fs-5">'.$title.'</div>';
$html.='<table class="table table-nowrap">
	<thead class="bg-primary text-white">
	<tr><th scope="col" align="left">Trans ID</th>
		<th scope="col" align="left">Date</th>
		<th scope="col">Order Amt</th>
		<th scope="col">Trans Amt</th>
		<th scope="col">Trans Fee</th>
		<th scope="col">Balance</th>
		<th scope="col" align="left">Beneficiary Name</th>
		<th scope="col" align="left">Account Number</th></tr>
	</thead>';

	foreach($data['selectamount'] as $ind=>$rs) {

		$beneficiary_name=$account_number="";
		if(isset($rs['beneficiary_id'])&&$rs['beneficiary_id'])
		{
			$beneficiary_name	=$bene_list[$rs['beneficiary_id']]['beneficiary_name'];	
			$account_number		=mask($bene_list[$rs['beneficiary_id']]['account_number'],0,4);	
		}
		
		$html.="<tr><td>".$rs['transaction_id']."</td><td>".prndate($rs['transaction_date'])."</td><td>".fetch_amtwithcurr($rs['transaction_amount'],$rs['transaction_currency'],true,1)."</td><td>".fetch_amtwithcurr($rs['converted_transaction_amount'],$rs['converted_transaction_currency'],true,1)."</td><td>".fetch_amtwithcurr($rs['mdr_amt'],$rs['converted_transaction_currency'],true,1)."</td></td><td>".fetch_amtwithcurr($rs['available_balance'],$rs['converted_transaction_currency'],true,1)."</td><td>".$beneficiary_name."</td><td>".$account_number."</td></tr>";

}


$html.='</table></div></body></html>';

//echo $html;exit;


$filename = "Account_Statement_of_".$_REQUEST['bid']."_Total_Records_".$nor."_".date("dmyHis");

// include autoloader
include('../dompdf/autoload.inc.php');

// reference the Dompdf namespace
use Dompdf\Dompdf;

// instantiate and use the dompdf class
ob_end_clean();
$dompdf = new Dompdf();

//$html = utf8_encode($html);

$dompdf->loadHtml($html);

$dompdf->set_option('isRemoteEnabled', TRUE);
$dompdf->set_option('isHtml5ParserEnabled', true);

// (Optional) Setup the paper size and orientation
$dompdf->setPaper('A4', 'orientation');

// Render the HTML as PDF
$dompdf->render();

// Output the generated PDF to Browser
//$dompdf->stream($filename); // Download
$dompdf->stream($filename,array("Attachment"=>1));


