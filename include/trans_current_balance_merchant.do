<?
$data['PageFile']='merchant_list';
$data['PageFile2']='clients_test';
$data['NO_SALT']=true;
$data['SponsorDomain']=true;

include('../config.do');

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['uid'])){
       header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
       echo('ACCESS DENIED.');
       exit;
}elseif((isset($_SESSION['sub_admin_id']))&&(!isset($_SESSION['edit_trans']))){
      // header("Location:{$data['USER_FOLDER']}/login{$data['ex']}"); echo('ACCESS DENIED.'); exit;
}

$uid=@$_SESSION['uid'];

if(isset($_SESSION['m_settlement_optimizer'])&&(strtolower($_SESSION['m_settlement_optimizer'])=='custom'||strtolower($_SESSION['m_settlement_optimizer'])=='weekly')&&isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y') {
      $post=trans_balance_wv3_custom(@$uid);
      $post['MemberInfo']['balance']=$post['ab']['summ_total'];
      
}
elseif(isset($data['WITHDRAW_INITIATE_SYSTEM_WV2'])&&$data['WITHDRAW_INITIATE_SYSTEM_WV2']=='Y'&&@$_REQUEST['a']!='v1')
{
      $trans_detail_array = fetch_trans_balance_wv2($uid); $post['ab']=trans_balance_newac_wv2($uid,"","", $trans_detail_array,@$data['last_withdraw']); $post['MemberInfo']['balance']=$post['ab']['summ_total'];
}
else 
{
      $trans_detail_array = fetch_trans_balance($uid); $post['ab']=trans_balance_newac($uid,"","", $trans_detail_array); $post['MemberInfo']['balance']=$post['ab']['summ_total'];
}

db_disconnect();

?>
<?=$_SESSION['uid_wv2'.$uid]['summ_total']=@$post['ab']['summ_total'];?>
       
 