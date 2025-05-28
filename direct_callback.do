<?
if(!isset($_SESSION)) { session_start(); }

if(!isset($_SESSION['adm_login'])) {  echo('ACCESS DENIED.'); exit; }

$data['ROOT_FILE']='direct_callback';

if(isset($_REQUEST['mcb_body'])){
	$status_array=json_decode($_REQUEST['mcb_body'],true);
}

if(isset($_REQUEST['mcb_redirect_url'])){
	$_SESSION['notifybridge_url_mer']=trim($_REQUEST['mcb_redirect_url']);
}

if(isset($status_array['transID'])){
	$_REQUEST['transID']=$transID=$status_array['transID'];
}
elseif(isset($status_array['transaction_id'])){
	$_REQUEST['transID']=$transID=$status_array['transaction_id'];
}

if(isset($_REQUEST['mcb_notify_url'])){
	$notify_url=$webhook_url=trim($_REQUEST['mcb_notify_url']);	
}
$notify_status='';
$notify_failed_source='';

if(isset($_GET['dtest'])&&$_GET['dtest']==2)
{
	echo "<br/>notify_url=>".@$notify_url;
	echo "<br/>notifybridge_url_mer=>".@$_SESSION['notifybridge_url_mer'];
	echo "<br/>status_array=>";print_r(@$status_array);
	exit;
}

include('trans_notify_bridge.do');

exit;

?>