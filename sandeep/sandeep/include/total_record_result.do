<?
include('../config.do');

###############################################################################
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	echo('ACCESS DENIED.'); exit;
}

$sub_quer	= decryptres($_REQUEST['sub_quer']);

if(isset($_GET['dtest'])){
	echo "<br/>sub_quer=><br/>$sub_quer<br/><br/>";
}

$count=trans_countsf($sub_quer);

if(isset($_GET['dtest'])){
	echo "<br/><br/>$count<br/><br/>";
	//exit;
}

$_SESSION['total_record_result'] = $count;

include("../include/pagination_pg".$data['iex']);

$url = $_SESSION['main_url'];

if(isset($_GET['page'])){$page=$_GET['page'];}else{$page=1;}


if(isset($_SESSION['MaxRowsByPage'])) $perpage = $_SESSION['MaxRowsByPage'];
else $perpage = 50;

pagination($perpage,$page,$url,$count);

db_disconnect();

/*if(isset($_REQUEST['admin']) && $_REQUEST['admin'])
{
	echo "<script>ajaxf1(this,'{$data['Host']}/include/total_record_result_oldpg{$data['ex']}?count=$count&admin=1','#old_paging_system','1','2')</script>";
}
*/
?>
