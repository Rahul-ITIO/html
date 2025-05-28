<?
###############################################################################
$data['PageName']='Transaction Stats';
$data['PageFile']='stats';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Transaction Stats - '.$data['domain_name'];
##########################Check Permission#####################################
if(!clients_page_permission('17',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
$is_admin=false;
if(isset($_SESSION['adm_login'])&&$_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$_GET['id'];
	$_SESSION['uid']=$uid;
	$_SESSION['login']=$uid;
}
###############################################################################
if(is_info_empty($uid)&&$is_admin==false){
	header("Location:{$data['Host']}/user/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################

$post=select_info($uid, $post);
//print_r($post);
$uid=$post['id'];


function stats_records($succ_trans,$fail_trans){

	$data['stats']['success']=$succ_trans;
	$data['stats']['fail']=$fail_trans;
	$data['stats']['total']=($fail_trans + $succ_trans);

		if($data['stats']['total']==0){
		
		$data['stats']['records']=0;
		return $data['stats'];exit;
		
		}else{
		
		$data['stats']['records']=1;
		$count1 = $succ_trans / $data['stats']['total'];
		$count2 = $count1 * 100;
		$count = number_format($count2, 2);
		$data['stats']['success_ratio']=$count;
		$data['stats']['fail_ratio']=(100 - $data['stats']['success_ratio']);
		return $data['stats'];
		
		}
}

if(isset($_POST['action']) && $_POST['action']=="stats_color"){
$stats_failed_color=$_POST['stats_failed_color'];
$stats_success_color=$_POST['stats_success_color'];
$act=$_POST['act'];
$subadmin_id_merchant=$domain_server['subadmin']['id'];
      $qrs=db_query(
			"UPDATE `{$data['DbPrefix']}subadmin`".
			" SET `stats_success_color`='{$stats_success_color}',`stats_failed_color`='{$stats_failed_color}'".
			" WHERE `id`={$subadmin_id_merchant}",0
		);
		if($qrs){
		json_log_upd($subadmin_id_merchant,'subadmin','Update');
		$_SESSION['display_msg']="Stats Color Update Successfully";
		header("Location:{$data['USER_FOLDER']}/stats".$data['ex']."?act=".$act);exit;
		}else{
		$_SESSION['display_msg']="Stats Color Not Updated";
		header("Location:{$data['USER_FOLDER']}/stats".$data['ex']."?act=".$act);exit;
		}
		
}

//============================Added By Vikash====================================================================
$today=date("Y-m-d");
$before7days=date('Y-m-d', strtotime($today. '-7 day'));

$g_title=((isset($_REQUEST['label']) &&$_REQUEST['label'])?$_REQUEST['label']:'Last 7 Days');
$date_1st=((isset($_REQUEST['date_1st']) &&$_REQUEST['date_1st'])?$_REQUEST['date_1st']:$before7days);
$date_2nd=((isset($_REQUEST['date_2nd']) &&$_REQUEST['date_2nd'])?$_REQUEST['date_2nd']:$today);


if((isset($date_1st)&&$date_1st) && (isset($date_2nd)&&$date_2nd) ){

$whereqrtotal=" `merID` IN ('$uid') AND ( `trans_type` IN (11) ) AND DATE_FORMAT(`tdate`,'%Y-%m-%d') >=  '$date_1st'  AND DATE_FORMAT(`tdate`,'%Y-%m-%d') <=  '$date_2nd'  AND (`trans_status` IN (2)) LIMIT 1 ";

$fail=trans_count_where_pred($whereqrtotal);

$whereqractive=" `merID` IN ('$uid') AND ( `trans_type` IN (11) ) AND DATE_FORMAT(`tdate`,'%Y-%m-%d') >=  '$date_1st'  AND DATE_FORMAT(`tdate`,'%Y-%m-%d') <=  '$date_2nd' AND (`trans_status` IN (1,7)) LIMIT 1 ";

$succ=trans_count_where_pred($whereqractive);  // New Created Function By Vikash
$data['stats']=stats_records($succ,$fail);
}

$post['json_setting']=jsondecode(@$post['json_setting']);
###############################################################################
display('user');
###############################################################################
?>