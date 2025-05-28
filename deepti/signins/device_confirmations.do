<?
$data['PageName']='Device Confirmations';
$data['PageFile']='device_confirmations';
$data['HideMenu']=true;
$data['HideAllMenu']=true;

###############################################################################
include('../config.do');
$data['PageTitle'] = '2-Step Verification using Google Authenticator - '.$data['domain_name']; 
##########################Check Permission#####################################

if(!$_SESSION['admin_id']){header("Location:{$data['Admins']}/login{$data['ex']}");}
$browserOs1=browserOs("1"); $browserOs=json_encode($browserOs1); 
$setBrowserName='safari'; //safari mozilla	chrome
  
//print_r($browserOs1);

$_SESSION['showcode']=0; unset($_SESSION['showcode']);

display('admins');exit;
?>
