<?
###############################################################################
// Redirect to dashboard when not assign QR request or QR Dashboard
//echo $post['qrcode_gateway_request'];
//echo $_SESSION['dashboard_type'];
//echo "==============";exit;
/*if(($post['qrcode_gateway_request']!='1' && $post['qrcode_gateway_request']!='2') || $_SESSION['dashboard_type']=="payout-dashboar"){

	$_SESSION['dashboard_type']="";
	header("Location:{$data['USER_FOLDER']}/dashboard".$data['ex']);
	exit;
}*/
###############################################################################
?>

<?
###############################################################################

//Redirect to dashboard when not assign QR request or QR Dashboard
//echo $post['qrcode_gateway_request'];
//echo $_SESSION['dashboard_type'];
//echo "==============";exit;

if($data['frontUiName']=="OPAL_IND"){ 

	if(($post['qrcode_gateway_request']!='1' && $post['qrcode_gateway_request']!='2')  || $_SESSION['dashboard_type']=="payout-dashboar"){
	
		$_SESSION['dashboard_type']="";
		header("Location:{$data['USER_FOLDER']}/dashboard".$data['ex']);
		exit;
	}

}else{
	if(($post['qrcode_gateway_request']!='1' && $post['qrcode_gateway_request']!='2')  || $_SESSION['dashboard_type']=="payout-dashboar" || $_SESSION['dashboard_type']==""){
	
		$_SESSION['dashboard_type']="";
		header("Location:{$data['USER_FOLDER']}/dashboard".$data['ex']);
		exit;
	}
}
###############################################################################
?>