<?
error_reporting(0);
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Notify - '.$data['domain_name'];
###############################################################################

if(!isset($_SESSION['login'])){
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################
$fees=$_SESSION['fees'];unset($_SESSION['fees']);
$total = $_SESSION['amount'] + $_SESSION['fees'];
$dtype=$_SESSION['dtype'];unset($_SESSION['dtype']);
$amount=$_SESSION['amount'];unset($_SESSION['amount']);
$remote=parse_url($_SERVER["HTTP_REFERER"]);$remote=$remote['host'];
###############################################################################
$systems=array(
	'paypal.com', 'stormpay.com', 'netpay.tv', 'e-gold.com', 'moneybookers.com',
	'intgold.com', 'e-bullion.com', 'pecunix.com', 'epaydirect.net', 'evocash.com',
	'qchex.com', 'goldmoney.com', 'virtualgold.net', 'emocorp.com', '2checkout.com'
);
###############################################################################
$success=false;
if(in_array($remote, $systems))
	{
		$success=true;
		
	}
/*
foreach($systems as $value){
 	if(eregi($value, $remote))
	{
		$success=true;
		break;
	}
}
*/

###############################################################################
if(($_REQUEST['payment_status']=="Pending") || ($_REQUEST['payment_status']== 'Completed') || ($_REQUEST['st']=="Pending") || ($_REQUEST['st']== 'Completed')){
$comments='Paypal Transaction Id: '.$_REQUEST['tx'];
transaction(
		-1,
		$uid,
		$total,
		$fees,
		1,
		1,
		$_POST['txn_id'],
		"{$data['DepositMethod']['paypal']['name']} Depositing"
	);
}else{
	 $data['Error']='Payment Transaction Failed.';
}

###############################################################################
header("Location:{$data['USER_FOLDER']}/index.do");
echo('ACCESS DENIED.');
exit;
###############################################################################
?>