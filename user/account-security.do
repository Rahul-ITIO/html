<?
$data['DISPLAY_MULTI']='account-security';
include('../config.do');
##########################Check Permission#####################################
if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('2',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################

include('password.do'); 
$data['UI_MULTI_DISPLAY']=1; 
//include('summary-account.do'); 
include('two-factor-authentication.do'); 
//print_r($data['PageFiles']);
//exit;
display('user');
?>
