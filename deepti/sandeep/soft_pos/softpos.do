<?
$data['PageName']	= 'SOFT POS FOR TRANSACTIONS';
include('../config.do');
$data['PageTitle'] = 'Soft Pos for Transactions - '.$data['domain_name'];
$data['PageFile']	= 'softpos';

if(!isset($_SESSION['m_clients_role'])) $_SESSION['m_clients_role'] = '';
if(!isset($_SESSION['m_clients_type'])) $_SESSION['m_clients_type'] = '';

if(!clients_page_permission('55',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################
if(!$_SESSION['login']){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['Host']}/clients/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(@$data['invoice_condation']){ $where_pred=""; }else {
	$where_pred=" AND (`notification_to` LIKE '%007%') ";
	}
	
	$where_pred=" AND (`active` IN (1) ) ";
	$data['Store']=select_terminals($uid, 0, false, 0,$where_pred);
	$data['store_size']=(count($data['Store']));
	//echo $data['store_size'];
	//print_r($data['Store']);
$post=select_info($uid, $post);
$softpos_get1=clientidf($uid,'softpos_setting');
if(isset($softpos_get1)&&is_array($softpos_get1))
	$post=array_merge($post,$softpos_get1);

if(!isset($post['step']) || !$post['step']) $post['step']=1;

###############################################################################
//print_r($_POST);

if(isset($_GET['send'])&&$_GET['send'])
	$post['send']=$_GET['send'];	

if((isset($post['send']) && $post['send'])||(isset($post['action']) && $post['action']=='addrequests')){

	if($post['send']=='CONTINUE') { $post['step']=2; }
	
	if(isset($post['step']) && $post['step']==1){
			$post['step']++;
	}elseif(isset($post['step']) && $post['step']==2){
		if(!isset($post['softpos_pa']) || !$post['softpos_pa']){
			$data['Error']='Please enter PA: Enter The Payment Address.';
		}elseif(!isset($post['softpos_pn']) || !$post['softpos_pn']){
			$data['Error']='Please enter PN: Enter The Payment Name.';
		}elseif(isset($data['store_size']) && $data['store_size']<1){
			$data['Error']='Request Funds missing in Acquirer. Please contact to support.';
		}elseif(isset($data['store_size']) && $data['store_size']<1&&!$post['softpos_websiteid']){
			$data['Error']='Please select to Store Type';
		}elseif(get_clients_status($uid)<0){
			$data['Error']="because you are UNVERIFIED merchant.";
		}else{
			
			db_query(
					"UPDATE `{$data['DbPrefix']}clientid_table` SET ".
					"`softpos_websiteid`='{$post['softpos_websiteid']}',`softpos_pa`='{$post['softpos_pa']}',`softpos_pn`='{$post['softpos_pn']}' WHERE `id`='{$uid}'"
			);
			
			$data['sucess']	="true";
			$post['step']--;
			
		if($post['action']=="update"){
			$_SESSION['action_success']="<strong>Success!</strong> Your {$data['SOFT_POS_LABELS']} Updated successfully";
			header("location:{$data['Host']}/soft_pos/{$data['PageFile']}".$data['ex']);exit;
		}else{
		
			$_SESSION['action_success']="<strong>Success!</strong> Your {$data['SOFT_POS_LABELS']} Created successfully";
			header("location:{$data['Host']}/soft_pos/{$data['PageFile']}".$data['ex']."?invid=".$related_id."&action=display");exit;

		}
			
			
	  }
	}
}
elseif((!isset($post['softpos_pa'])||empty($post['softpos_pa'])) || (!isset($post['softpos_pa'])||empty($post['softpos_pa']))){
	$post['step']=2;
}


###############################################################################

display('user');

###############################################################################

?>