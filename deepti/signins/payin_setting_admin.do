<?

if(isset($_REQUEST['gid'])&&$_REQUEST['gid']>0){
	$data['G_MID']=$_REQUEST['gid'];
}

include('../config.do');


if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
       header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
       echo('ACCESS DENIED.');
       exit;
//}elseif(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']!=3){
}elseif((isset($_SESSION['sub_admin_id']))&&(!isset($_SESSION['edit_trans']))){
      // header("Location:{$data['USER_FOLDER']}/login{$data['ex']}"); echo('ACCESS DENIED.'); exit;
}

$is_admin=false;
if($_SESSION['adm_login']&&isset($_REQUEST['admin'])&&$_REQUEST['admin']){
	$is_admin=true;
	//echo "<hr/>is_admin=>".$is_admin;
}

if(isset($is_admin)&&$is_admin&&isset($uid)&&$uid){
	$data['frontUiName']="";
}
if(isset($_REQUEST['tempui'])){
	$data['frontUiName']=$_REQUEST['tempui'];
}
//echo "<br/>frontUiName=>".$data['frontUiName'];



$post['gid']=$_REQUEST['gid'];
$post['MemberInfo']['sponsor']=$_REQUEST['sponsor'];
$post['MemberInfo']['id']=$post['gid'];

//lptest lptestlb

$_GET['id']=$post['gid'];


	
$id=($post['gid']?$post['gid']:$_GET['id']);

$payin_setting_get=$post['PayinInfo']=select_tablef("`clientid`='{$id}'","payin_setting");
if(isset($payin_setting_get)&&$payin_setting_get) $post=array_merge($post,$payin_setting_get);
if(isset($_POST)&&$_POST) $post=array_merge($post,$_POST);

 
showpage("admins/template.payin_setting_admin".$data['iex']);db_disconnect();exit;
?>
 