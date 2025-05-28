<?
$data['PageFile']='merchant_list';
$data['PageFile2']='clients_test';

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
$post['gid']=$_REQUEST['gid'];
$post['MemberInfo']['sponsor']=$_REQUEST['sponsor'];
$post['MemberInfo']['id']=$post['gid'];

//$post['ab']=account_balance($post['gid']); $post['MemberInfo']['balance']=$post['ab']['summ_total'];

$trans_detail_array = fetch_balance($post['gid']); $post['ab']=account_balance_newac($post['gid'],"","", $trans_detail_array); $post['MemberInfo']['balance']=$post['ab']['summ_total'];

db_disconnect();

?>
<span style="font-size:28px;" id="button_css" class="btn btn-icon btn-primary"><?=$post['ab']['summ_total'];?></span>
       
 