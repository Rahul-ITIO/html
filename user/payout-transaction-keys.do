<?
###############################################################################
$data['PageName']='Payout Transaction';
$data['PageFile']='payout-transaction-keys';
$data['PageFileName']='payout-transaction-keys';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Payout Transaction - '.$data['domain_name']; 
##########################Check Permission#####################################
if((isset($_SESSION['m_clients_role']) &&$_SESSION['m_clients_role'])?$_SESSION['m_clients_role']:'');
if((isset($_SESSION['m_clients_type']) &&$_SESSION['m_clients_type'])?$_SESSION['m_clients_type']:'');

if(!clients_page_permission('20',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }

if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('20',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }

###############################################################################
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']); echo('ACCESS DENIED.'); exit;
}
$is_admin=false;
if(isset($_SESSION['adm_login'])&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$post['bid'];
	$_SESSION['login']=$uid;
}
$post['is_admin']=$is_admin;
if(is_info_empty($uid)){
	$get_q='';if(isset($_GET)){$get_q="?".http_build_query($_GET);}
	header("Location:{$data['Host']}/user/profile{$data['ex']}{$get_q}");
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
$post=select_info($uid, $post);
if(!isset($post['step']) || !$post['step'])$post['step']=1;
$post['Buttons']=get_files_list($data['SinBtnsPath']);

###############################################################################
if(isset($post['action'])&&$post['action']=='generate_payout_token'){

	if(strlen($uid)==1) $paykey['tid'] ="000".$uid;
	elseif(strlen($uid)==2) $paykey['tid'] ="00".$uid;
	elseif(strlen($uid)==3) $paykey['tid'] ="0".$uid;
	else $paykey['tid'] =$uid;

	$paykey['time'] =time();
	$payout_token_en=encode_f(json_encode($paykey),1);
	
	$payout_token_de=jsondecode($payout_token_en);
	$post['payout_token']=$payout_token_de;
	$payout_token=$payout_token_de['decrypt'];

	db_query("UPDATE `{$data['DbPrefix']}clientid_table`"." SET `payout_token`='{$payout_token}' WHERE `id`='{$uid}'");

	if(isset($_REQUEST['ajax'])&&$_REQUEST['ajax'])
	{
		echo $payout_token;
		exit;
		//$_SESSION['action_success']="Payout Token Generated Successfully!";
	}
	header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']);exit;
}elseif(isset($post['action'])&&$post['action']=='generate_secret_key'){

	$generate_secret_key=generate_secret_key($uid);

	$_SESSION['action_success']="Secret Key Generated Successfully!";
    header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']);exit;
	

}elseif(isset($post['action'])&&$post['action']=='payout_secret_key'){

	$payout_secret_key_en=encode_f($_POST['payout_secret_key'],1);

	db_query("UPDATE `{$data['DbPrefix']}clientid_table`"." SET `payout_secret_key`='{$payout_secret_key_en}' WHERE `id`='{$uid}'");

	$_SESSION['action_success']="Payout Secret Key Generated Successfully!";
	
	header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']);exit;
}

if(isset($post['step'])&&$post['step']==1){
	$result_select=db_rows_2(
		"SELECT * FROM `{$data['DbPrefix']}payout_transaction`".
		" WHERE `sub_client_id`={$uid}".
		(isset($primary)?" AND `primary`='{$primary}'":'').
		(isset($confirmed)?" AND `active`='{$confirmed}'":'').
		" ORDER BY `transaction_date` DESC",0 //AND `active`<> '2'
	);
	$data['TransData'] = $result_select;

	$cntdata=count($data['TransData']);
	if($cntdata==0){}
}

###############################################################################
display('user');
###############################################################################
?>
