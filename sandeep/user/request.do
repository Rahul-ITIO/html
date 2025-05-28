<?
###############################################################################
$data['PageName']='REQUEST MONEY';
$data['PageFile']='request';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Generate an invoice - '.$data['domain_name'];
###############################################################################

if(!isset($_SESSION['login'])){
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
if(is_info_empty($uid)){
	header("Location:{$data['Host']}/user/profile.do");
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################
$post=select_info($uid, $post);
$data['Balance']=select_balance($uid);
###############################################################################O
if($post['send']){
	if(!$post['rname']){
		$data['Error']='Please enter receiver full name.';
	}elseif(!$post['remail']){
		$data['Error']='Please enter valid e-mail address.';
	}elseif(!$post['amount']){
		$data['Error']='Please enter valid amount for transfering.';
	}elseif($post['amount']<$data['PaymentMinSum']){
		$data['Error']="Amount can not be less than".
			" {$data['Currency']}{$data['PaymentMinSum']}.";
	}elseif(get_clients_status($uid)<0&&$post['amount']>$data['PaymentMaxSum']){
		$data['Error']="You cannot request more than".
			" {$data['Currency']}{$data['PaymentMaxSum']} per transaction".
			" because you are UNVERIFIED merchant.";
	}else{
		$post['clientid']= $uid;
		$post['fullname']=$post['rname'];
		$post['email']=$post['remail'];
		$post['emailadr']=get_clients_email($uid);
		send_email('REQUEST-MONEY', $post);
		$data['PostSent']=true;
	}
}
###############################################################################
display('user');
###############################################################################
?>
