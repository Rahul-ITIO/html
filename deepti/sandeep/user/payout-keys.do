<?
###############################################################################
$data['PageName']='Payout keys';
$data['PageFile']='payout-keys';
$data['PageFileName']='payout-keys';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Payout - '.$data['domain_name']; 
##########################Check Permission#####################################
if((isset($_SESSION['m_clients_role']) &&$_SESSION['m_clients_role'])?$_SESSION['m_clients_role']:'');
if((isset($_SESSION['m_clients_type']) &&$_SESSION['m_clients_type'])?$_SESSION['m_clients_type']:'');

$is_admin=false;

if(isset($_SESSION['adm_login'])&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$_REQUEST['id'];
	$_SESSION['login']=$uid;
	$data['is_admin_link'].="&id=".$uid;
	$data['is_admin_input_hide'].="<input type='hidden' name='id' value='{$uid}'>";
	$_SESSION['dashboard_type']="payout-dashboar";
}
$post['is_admin']=$is_admin;

if($is_admin==false){

	if(!clients_page_permission('22',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }

	if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('22',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }

}

if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']); echo('ACCESS DENIED.'); exit;
}
	
if(is_info_empty($uid)){
	$get_q='';if(isset($_GET)){$get_q="?".http_build_query($_GET);}
	header("Location:{$data['Host']}/user/profile{$data['ex']}{$get_q}");
	echo('ACCESS DENIED.');
	exit;
}

//echo "<br/>login=>".$_SESSION['login'];echo "<br/>uid=>".$uid;echo "<br/>is_admin=>".$is_admin;exit;

###############################################################################
$post=select_info($uid, $post);

//print_r($post);

$ps = clientidf($uid,'payout_setting');
if(isset($ps)&&is_array($ps))
{
	$post=array_merge($post,$ps);
}

if(isset($_REQUEST['dtest']))
{
	print_r($ps);
}

include_once $data['Path'].'/include/payout-request'.$data['iex'];


###############################################################################
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

	db_query("UPDATE `{$data['DbPrefix']}payout_setting`"." SET `payout_token`='{$payout_token}' WHERE `clientid`='{$uid}'",0);

	if(isset($_REQUEST['ajax'])&&$_REQUEST['ajax'])
	{
		echo $payout_token;
		exit;
		//$_SESSION['action_success']="Payout Token Generated Successfully!";
	}
	$_SESSION['action_success']="Payout Token Generated Successfully!";
	header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']."?".$data['is_admin_link']);exit;
}elseif(isset($post['action'])&&$post['action']=='generate_secret_key'){

	$generate_secret_key=generate_private_key($uid);

	$_SESSION['action_success']="Secret Key Generated Successfully!";
    header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']."?".$data['is_admin_link']);exit;
	

}elseif(isset($post['action'])&&$post['action']=='payout_secret_key'){

	$payout_secret_key_en=encode_f($_POST['payout_secret_key'],2);

	db_query("UPDATE `{$data['DbPrefix']}payout_setting`"." SET `payout_secret_key`='{$payout_secret_key_en}' WHERE `clientid`='{$uid}'");

	$_SESSION['action_success']="Payout Secret Key Generated Successfully! You can use all functionality after 24 hours.";
	
	header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']."?".$data['is_admin_link']);exit;
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
