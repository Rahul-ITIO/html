<?
$data['PageFile']='merchant_list';
$data['PageFile2']='clients_test';
if(isset($_REQUEST['gid'])&&$_REQUEST['gid']>0){
	$data['G_MID']=$_REQUEST['gid'];
}

include('../config.do');



$store_url=($data['MYWEBSITEURL']?$data['MYWEBSITEURL']:'store');
$store_id_nm=$store_url;
$store_name=($data['MYWEBSITE']?$data['MYWEBSITE']:'Store');


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


$_GET['id']=$post['gid'];



$post['micro_trans']=micro_trans($post['gid'],true);
$data['Products']=select_products($post['gid'], 0);


$select_pt=db_rows(
	"SELECT * FROM {$data['DbPrefix']}acquirer_group_template".
	//" WHERE `id` IS NOT NULL ".$status." ".$sponsor_qr.
	" ORDER BY id DESC ",0
);


		
$data['tmp2']=array();
foreach($select_pt as $key=>$value){
	//$data['tmp2'][$value['tid']]=$value['templates_name'];
	$data['tmp2'][$value['id']]=$value['templates_name'];
}

$post['store_url']=$store_url;
$post['store_name']=$store_name;
$post['is_admin']=$is_admin;
	
       
 
showpage("common/template.website_store_admin".$data['iex']);db_disconnect();exit;
?>
 