<?
###############################################################################
$data['PageName']='MASS PAYMENTS';
$data['PageFile']='mass';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Mass Pay - '.$data['domain_name'];
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
$data['PostFile']=false;
###############################################################################
if($post['send']){
	if(!$post['receivers']){
		$data['Error']='Please enter at least one username or e-mail address of the receiver.';
	}elseif(!$post['amount']){
		$data['Error']='Please enter valid amount for transfering.';
	}elseif($post['amount']<$data['PaymentMinSum']){
		$data['Error']="Amount can not be less than".
			" {$data['Currency']}{$data['PaymentMinSum']}.";
	}elseif($post['amount']>$data['Balance']){
		$data['Error']='You do not have enough money in your account.';
	}elseif(get_clients_status($uid)<0&&$post['amount']>$data['PaymentMaxSum']){
		$data['Error']="You cannot send more than".
			" {$data['Currency']}{$data['PaymentMaxSum']} per transaction".
			" because you are UNVERIFIED clients.";
	}else{
		$fees=($post['amount']*$data['PaymentPercent']/100)+$data['PaymentFees'];
		$receivers=explode("\n", $post['receivers']);
		$post['SentUsers']=array();
		$post['UnsentUsers']=array();
		foreach($receivers as $value){
			$value=trim($value);
			if($uid==get_clients_id($value)||!is_clients_active($value))continue;
			$receiver=get_clients_id($value);
			$post['user_count']++;
			transaction(
				$uid,
				$receiver,
				$post['amount'],
				$fees,
				0,
				1,
				$post['comments']
			);
			$post['clientid']= $uid;
			$post['fees']=$fees;
			$post['emailadr']=get_clients_email($uid);
			$post['fullname']=get_clients_name($uid);
			$post['username']=get_clients_name($receiver);
			$post['product']="Internal Transfer";
			$post['email']=get_clients_email($receiver);
			send_email('SEND-MONEY', $post);
		}
		$post['sendername']=get_clients_name($uid);
		$post['fullname']=get_clients_name($receiver);
		$post['emailadr']=get_clients_email($receiver);
		$post['product']="Internal Transfer";
		$post['email']=get_clients_email($uid);

$message_ins = $message_ins . "Amount: $".$post['amount']." - Paid To: ".$post['fullname']." - ".$post['emailadr']."\n";
		$post['message_ins']=$message_ins;
				$data['PostSent']=true;
	}
      send_email('MASSPAY-RECEIPT', $post);
}
###############################################################################
display('user');
###############################################################################
?>
