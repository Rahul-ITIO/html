<?

$data['transIDExit']=1;

/* */
$data['status_in_email']=1;
$data['devEmail']='arun@itio.in';
//$data['devEmail']='arun@itio.in,deeptit@itio.in';
$send_attchment_message5=1;

		
$_REQUEST['action']='webhook';


header('Content-type:application/json;charset=utf-8');
echo '{
    "returnCode": "0",
    "responseMessage": "Successful"
}';


include('../status_in_email.do');

include("status_118.do");

?>