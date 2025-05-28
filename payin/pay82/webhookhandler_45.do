<?

$data['transIDExit']=1;

/* */
$data['status_in_email']=1;
//$data['devEmail']='arun@itio.in';
$data['devEmail']='arun@itio.in,deeptit@itio.in';
$send_attchment_message5=1;

		
$_REQUEST['actionurl']='notify';
$_REQUEST['action']='webhook';

//echo $data['ok_webhook']="OK";
echo '{"success":"200"}';


include('../status_in_email.do');

//include("status_82.do");

?>
