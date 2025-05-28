<?php

$data['transIDExit']=1;

/* */
$data['status_in_email']=1;
//$data['devEmail']='arun@itio.in';
$data['devEmail']='arun@itio.in,deeptit@itio.in';
$send_attchment_message5=1;


$_REQUEST['actionurl']='notify';
$_REQUEST['action']='webhook';

$arrayAllMethod=[];
$arrayAllMethod['string']='vusUF9K4bOZVWBMDtg/Lkk6Z7ZetX3I9JpCXYVZX0mE=';

$body_input = file_get_contents("php://input");
$object_input = json_decode($body_input, true);
if(isset($object_input)&&$object_input){
        $arrayAllMethod['INPUT_JSON_METHOD']=@$object_input;
}
elseif(trim($body_input)){
        $arrayAllMethod['INPUT_NONE_JSON_METHOD']=@$body_input;
}

if(isset($_POST)&&count($_POST)>0){
        $arrayAllMethod['POST_METHOD']=@$_POST;
}


if(isset($_GET)&&count($_GET)>0){
        $arrayAllMethod['GET_METHOD']=@$_GET;
}


if(isset($arrayAllMethod)&&count($arrayAllMethod)>0){
        $arrayAllMethod['returnCode']="0";
        $arrayAllMethod['responseMessage']="Success";

}else {
        $arrayAllMethod['returnCode']="2";
        $arrayAllMethod['responseMessage']="Unsuccessfull";
}

$arrayAllMethod_encode=json_encode(@$arrayAllMethod, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);


//echo $data['ok_webhook']="OK";
 //header('SUCCESS: lqLDs0X/TDnB4Zje9iNoOIXPHKfe/hFaPvOdC29FfpaWF1u1+jFAlB/6D1MLAIEf');
 //header('Content-type:application/json;charset=utf-8');
 //echo $arrayAllMethod_encode;
 echo "H+dUu5aZWcTcjHeHGGnLUjoKvSCA1Wm1oCmoyd43QXxA0W7Wn+WMhXD4Yo1Mm+S8Cq1ZQ3/Pe4VLMh4+PlLcmjvV/tFgqvYTw0O58B+egMEVvYE7DHfzgL/hlMz/QU6zqztboU2H/u9olhyUQBVVbytX3xIB/XZaoaKWY0CZ/ME4f3HlFNYTjeHnRNmrNtpG3055idaPRkgCPzEh3D+BCOXFIAXtMyMkY1ffGP24BIRHacNVRBYHCIzgr19cLmJcuCEwKHw7Z7IWtlQiAU/uKkH8zcRmnaI2ji0xmUppdeQ2YOvQ7dttZ03BjNX2JMIK";
 
/*
echo '{
    "returnCode": "0",
    "responseMessage": "Success"
}';
*/

include('../status_in_email.do');exit;

//include("status_82.do");

?>