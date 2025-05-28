<?php
$data['transIDExit']=1;


$data['status_in_email']=1;
$data['devEmail']='arun@itio.in';
$send_attchment_message5=1;

		
$_REQUEST['actionurl']='notify';
$_REQUEST['action']='webhook';

//header('Content-type:application/json;charset=utf-8');
echo $data['success_200']='{"success":"200"}';

include("status_34.do");

?>