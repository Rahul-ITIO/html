<?
$data['G_MID']=$_REQUEST['gid'];
include('../config.do');

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
       header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
       echo('ACCESS DENIED.');
       exit;
//}elseif(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']!=3){
}elseif((isset($_SESSION['sub_admin_id']))&&(!isset($_SESSION['edit_trans']))){
      // header("Location:{$data['USER_FOLDER']}/login{$data['ex']}"); echo('ACCESS DENIED.'); exit;
}

$is_admin=false;
if($_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	//echo "<hr/>is_admin=>".$is_admin;
}

if(isset($is_admin)&&$is_admin&&isset($uid)&&$uid){
	//$data['frontUiName']="";
}
if(isset($_REQUEST['tempui'])){
	$data['frontUiName']=$_REQUEST['tempui'];
}

$post['gid']=$_REQUEST['gid'];

$post['MemberInfo']['sponsor']=$_REQUEST['sponsor'];
$post['MemberInfo']['id']=$post['gid'];

$post['merSettingInfo']=select_mer_setting($post['gid']);
$post['merSettingInfoAssociate']=select_mer_setting($post['MemberInfo']['sponsor']);

showpage("admins/template.merchant_setting".$data['iex']);exit;

?>
