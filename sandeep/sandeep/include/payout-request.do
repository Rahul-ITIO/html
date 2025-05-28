<?
###############################################################################
// Redirect to dashboard when not assign payout request or Payout Dashboard

if(($post['payout_request']!='1' && $post['payout_request']!='2') || $_SESSION['dashboard_type']=="" || $_SESSION['dashboard_type']=="qrcode-dashboard"){

//if(($post['payout_request']!='1' && $post['payout_request']!='2'&&$is_admin)){
	$_SESSION['dashboard_type']="";
	header("Location:{$data['USER_FOLDER']}/dashboard".$data['ex']);
	exit;
}
###############################################################################
?>
