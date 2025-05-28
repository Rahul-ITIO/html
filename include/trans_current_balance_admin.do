<?
$data['PageFile']='merchant_list';
$data['PageFile2']='clients_test';
$data['NO_SALT']=true;
$data['SponsorDomain']=true;

include('../config.do');

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
       header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
       echo('ACCESS DENIED.');
       exit;
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

if(isset($_SESSION['settlement_optimizer'])&&(strtolower($_SESSION['settlement_optimizer'])=='custom'||strtolower($_SESSION['settlement_optimizer'])=='weekly')&&isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y')
{
      $post=trans_balance_wv3_custom(@$post['gid']);
      $post['MemberInfo']['balance']=$post['ab']['summ_total'];
}
elseif(isset($data['WITHDRAW_INITIATE_SYSTEM_WV2'])&&$data['WITHDRAW_INITIATE_SYSTEM_WV2']=='Y'&&@$_REQUEST['a']!='v1')
{
      $trans_detail_array = fetch_trans_balance_wv2($post['gid']); $post['ab']=trans_balance_newac_wv2($post['gid'],"","", $trans_detail_array,@$data['last_withdraw']); $post['MemberInfo']['balance']=$post['ab']['summ_total'];
}
else 
{
      $trans_detail_array = fetch_trans_balance($post['gid']); $post['ab']=trans_balance_newac($post['gid'],"","", $trans_detail_array); $post['MemberInfo']['balance']=$post['ab']['summ_total'];
}

db_disconnect();

?>
<span style="font-size:28px;" id="button_css" class="btn btn-icon btn-primary"><?=$post['ab']['summ_total'];?></span>
       
 