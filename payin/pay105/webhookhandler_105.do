<?

$data['transIDExit']=1;

/* */
$data['status_in_email']=1;
$data['devEmail']='arun@itio.in';
//$data['devEmail']='arun@itio.in,deeptit@itio.in';
$send_attchment_message5=1;

		
$_REQUEST['actionurl']='notify';
$_REQUEST['action']='webhook';
$_REQUEST['webhook_start_time']=(new DateTime())->format('Y-m-d H:i:s.u');


header('Content-type:application/json;charset=utf-8');
echo '{
    "returnCode": "0",
    "responseMessage": "Successful"
}';


include('../status_in_email.do');

include("status_105.do");

?>