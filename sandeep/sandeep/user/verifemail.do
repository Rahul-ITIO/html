<?
###############################################################################
$data['PageName']='E-MAIL ACTIVATION';
$data['PageFile']='verifemail';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Verify Your Email Address - '.$data['domain_name']; 
###############################################################################
if (isset($_GET['c'])) {
	$code = $_GET['c'];
	$uid  = $_GET['u'];
	$result = activate_email($uid, $code);
	if ($result=='CONFIRMATION_NOT_FOUND') 
		$data['error']="The confirmation code you entered is not valid.";
} else { header("Location:{$data['Host']}/index".$data['ex']); }
###############################################################################
display("user");
###############################################################################
?>