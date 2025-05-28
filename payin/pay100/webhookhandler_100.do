<?

$data['transIDExit']=1;

/* 
$data['status_in_email']=1;
$data['devEmail']='arun@itio.in';
//$data['devEmail']='arun@itio.in';
$send_attchment_message5=1;
*/
		
$_REQUEST['actionurl']='notify';
$_REQUEST['action']='webhook';


//$_REQUEST['cron_host_response']='52';
$data['retrun_via_status']="Skip"; 

//echo $data['ok_webhook']="OK";
//echo '{"success":"200"}';

header('Content-type:application/json;charset=utf-8');
echo '{
    "returnCode": "0",
    "responseMessage": "Successful"
}';


//include('../status_in_email.do');

include("status_100.do");

?>