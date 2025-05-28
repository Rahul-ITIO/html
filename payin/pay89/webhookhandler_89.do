<?
$data['transIDExit']=1;

if(isset($_REQUEST['email'])&&@$_REQUEST['email'])
{
    $data['status_in_email']=1;
    //$data['devEmail']='arun@itio.in';
    $data['devEmail']='arun@itio.in';
    $send_attchment_message5=1;
}


$_REQUEST['actionurl']='notify';
$_REQUEST['action']='webhook';

//echo $data['ok_webhook']="OK";
header('Content-type:application/json;charset=utf-8');
echo '{
    "Statuscode": "200",
    "Response": "200-OK"
}';

if(isset($_REQUEST['email'])&&@$_REQUEST['email'])
{
    include('../status_in_email.do');
}

include("status_89.do");




?>
