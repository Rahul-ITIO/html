<?

// https://prod-gate.i15.me/payin/pay116/webhookhandler_116

$data['transIDExit']=1;

/* 
$data['status_in_email']=1;
$data['devEmail']='arun@itio.in';
//$data['devEmail']='arun@itio.in,deeptit@itio.in';
$send_attchment_message5=1;
*/
		
$_REQUEST['actionurl']='notify';
$_REQUEST['action']='webhook';

//echo $data['ok_webhook']="OK";
//echo '{"success":"200"}';

header('Content-type:application/json;charset=utf-8');
echo '{
    "returnCode": "0",
    "responseMessage": "Successful"
}';


$responseParamList = @$_REQUEST;

//include('../status_in_email.do');

include("status_116.do");

?>