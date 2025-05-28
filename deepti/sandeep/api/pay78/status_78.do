<?
//if((isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='notify')||(isset($_REQUEST['action'])&&$_REQUEST['action']=='notify')||(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook'))
{	
	
	$data['transIDExit']=1;
	$data['status_in_email']=1;
	$data['devEmail']='arun@itio.in,mithileshk@itio.in';
	
}

$_REQUEST['action']='webhook';
$_REQUEST['action_api']='webhook';

include("../../payin/pay78/status_78.do");

?>