<?
###############################################################################
include('../config.do');
$data['PageTitle'] = 'History - '.$data['domain_name'];
###############################################################################
$post['Member']=get_clients_info($post['clients']);

###############################################################################
$data['utype']=2;
if(strstr($_SERVER['HTTP_REFERER'],"user/") || strstr($_SERVER['HTTP_REFERER'],"/profile")){
$data['utype']=1;
$data['utitle']=get_clients_username($post['clients']);
}elseif($_REQUEST['t']=='sadm'){
$data['utype']=3;
$g_result=select_tablef('id='.$post['clients'],$tbl='subadmin',$prnt=0,$limit='',$select='username');
$data['utitle']=$g_result[0]['username'];
}else{
$data['utitle']=get_clients_username($post['clients']);
}

$post['History']=get_ip_history($post['clients'], (isset($post['order'])?$post['order']:0), $data['utype'],100);

showpage("admins/template.history".$data['iex']);
###############################################################################
?>
