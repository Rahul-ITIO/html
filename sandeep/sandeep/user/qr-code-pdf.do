<?php
//https://github.com/dompdf/dompdf/releases

include('../config.do');
//include('../config_db.do');
/*$uid=$_SESSION['uid'];

$sponserid=get_sponsor_id($uid, $userId='');
$rs=select_tablef("id=$sponserid", "subadmin", 0, 1, "`upload_logo`");

$domain_server=$_SESSION['domain_server']; // for display merchant logo

// For Display Merchant Logo and check Availibility
if(isset($domain_server['LOGO'])&&$domain_server['LOGO']){
	$merchant_logo_url='<div style="max-width:80px !important;float: right;"><img src="'.encode_imgf($domain_server['LOGO']).'" style="height:30px;"> </div>';
}*/

if(isset($_REQUEST["bid"])&&$_REQUEST["bid"]) $bid = base64_decode($_REQUEST["bid"]);
else {
	$data['Error']="Something went wrong";
}
// Fetch Qr code Data from Table
$tbl	="qr_code";
$field	="`id`='$bid' AND `status` IN (1) ";
$qry	= "SELECT * FROM {$data['DbPrefix']}{$tbl} WHERE ".$field;
$arr	= db_rows($qry);
if(isset($arr[0])&& $arr[0])
{
	$arr	= $arr[0];
	
	$vpa = decode_f($arr['vpa']);
	$sub_merchantId = $arr['sub_merchantId'];
	$uid = $arr['merchant_id'];
	
	$json_value	= json_decode($arr['json_value'],1);	
	$merchantId = $json_value['siteid_get']['merchantId'];
	$terminalId = $json_value['siteid_get']['terminalId'];
	
	$curr = $arr['currency'];//"INR"; // Hard coded for Testing
	
	$url="upi://pay?pa=$vpa&pn=$merchantId&tr=mno$sub_merchantId&cu=$curr&mc=$terminalId";
	$url = urlencode($url);

	$upi_icons	= $data['Host']."/images/upi-icons.png";	// Hard coded for Upi image
	$vim_upi	= $data['Host']."/images/vim_upi.png";		// Hard coded for Bhim Upi image
	$p_image	= isset($p_image)&&$p_image?$p_image:'';
	// check profile pic is available or Not
	if(isset($arr['profile_pic'])&&$arr['profile_pic']){
		$p_image='<div style="max-width:75px !important;float: left;"><img src="'.$arr['profile_pic'].'" alt="'.$arr['qr_fullname'].'" style="height:70px !important;width:70px !important;border-radius: 50%;"></div>';
	}



$sponserid=get_sponsor_id($uid);
$domain_server=select_tablef("id=$sponserid", "subadmin", 0, 1, "`upload_logo`");

//$domain_server=$rs['upload_logo']; // for display merchant logo

// For Display Merchant Logo and check Availibility
if(isset($domain_server['upload_logo'])&&$domain_server['upload_logo']){
	$merchant_logo_url='<div style="max-width:80px !important;float: right;"><img src="'.encode_imgf($data['Path'].'/user_doc/'.$domain_server['upload_logo']).'" style="height:30px;"> </div>';
}

	$email_msg='
	<center><div style="width:350px;border: 3px solid; border-radius: 15px; padding:5px; border-color:#CCCCCC;">
		<div style=" display: flex ; margin-top: 1rem ; margin-bottom: 1rem ;">
			<div>
				<div>
					'.$p_image.'
					'.$merchant_logo_url.'
					<div style="float: left;margin-top:20px;margin-left:5px;font-size:18px;">'.$arr['qr_fullname'].'</div>
				</div>
				<div style="clear:both"></div>
				<hr>
				<div><img src="'.$vim_upi.'" style="max-width:350px !important;"></div>
				<div style="text-align: center;"><img src="https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl='.$url.'&choe=UTF-8"></div>
				<div><img src="'.$upi_icons.'" style="max-width:350px !important;"></div>
			</div>
		</div>
	</div></center>
	';
	$html ='<html lang="en">';
	$html.='<head></head>';
	$html.='<body><div>'.$email_msg;
	$html.='</div></body></html>';
	
	echo $html;
}
else {
	$data['Error']="Something went wrong";
}
if(isset($data['Error'])&&$data['Error']) echo $data['Error'];
exit;

include('../dompdf/autoload.inc.php');

// reference the Dompdf namespace
use Dompdf\Dompdf;

// instantiate and use the dompdf class
ob_end_clean();
$dompdf = new Dompdf();

$dompdf->set_option('isRemoteEnabled', TRUE); // For Image Display
//$dompdf->set_option('isHtml5ParserEnabled', true);

$dompdf->loadHtml($html);

// (Optional) Setup the paper size and orientation
$dompdf->setPaper('A4', 'orientation'); // orientation landscape

// Render the HTML as PDF
$dompdf->render();

$filename = "QR_Code_".$_REQUEST['bid']."_".date("dmyHis");

// Output the generated PDF to Browser
//$dompdf->stream($filename); // Download
//$dompdf->stream($filename,array("Attachment"=>1));

$dompdf->stream($filename,array("Attachment"=>1));

?>