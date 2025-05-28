<?
$data['PageName']='PAYOUT API';
$data['PageFile']='payout-api';
$data['HideMenu']=true;
$data['HideAllMenu']=true;
error_reporting(0);
include('config.do');
$data['PageTitle']='PAYOUT API page for Post and Get Method by Curl/S2S/Direct/Redirect/Host in Encrypted and Without Encrypted)'; 
//display('user');
showpage("user/template.payout-api".$data['iex']);exit;

?>