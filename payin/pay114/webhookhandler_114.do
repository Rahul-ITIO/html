<?
/*
$data['ordersetExit']=1;
$data['status_in_email']=1;
$data['devEmail']='arun@bigit.io';
$send_attchment_message5=1;
*/	
$_REQUEST['action']='webhook';

echo '{"success":"200"}'; header('Content-type:application/json;charset=utf-8');

include("status_114.do");

?>