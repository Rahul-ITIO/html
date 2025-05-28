<?
$config_db=1;
/*
print_r($_GET);
if(isset($_GET['urlaction'])&&((strpos($_GET['urlaction'],'Bingopay_webhook')!==false)||$_GET['urlaction']=='Bingopay_webhook')){
	//echo "<br/>urlaction1<br/>";
	$config_db=0;
	$data['ROOT1']='./';
	include('payin/pay87/webhookhandler_86.do');
	exit;
}
elseif(isset($_GET['urlaction'])&&((strpos($_GET['urlaction'],'Bingopay_returnurl')!==false)||$_GET['urlaction']=='Bingopay_returnurl')){
	//echo "<br/>urlaction2<br/>";
	$config_db=0;
	$data['ROOT1']='./';
	include('payin/pay87/status_86.do');
	exit;
}

*/

if($config_db==1){
//		/responseDataList.do?fname=smith&lname=kr

	include('config_db.do');

	$json_value['post']=array();$json_value['get']=array();
	if(isset($_POST)){$json_value['post']=get_post1($_POST);}
	if(isset($_GET)){$json_value['get']=get_post1($_GET);}
	
	$contentType = (isset($_SERVER["CONTENT_TYPE"]) ? trim($_SERVER["CONTENT_TYPE"]) : '');
	//if(strcasecmp($contentType, 'application/json') != 0)
	{
		$body_input = file_get_contents("php://input");
		$json_value['file_get_contents']= $body_input;
		$object_input = $json_value['object_input']= json_decode($body_input, true);
	}
	
	if(isset($data['PHP_INPUT'])&&$data['PHP_INPUT']){
		$body_input = file_get_contents("php://input");
		$object_input2 = $json_value['object_input2']= json_decode($body_input, true);
	}
	
	
	if((isset($data['con_name'])&&$data['con_name']=='clk')||(isset($ztspaypci)&&$ztspaypci==true)){
		if(isset($_POST)){
			unset($json_value['post']['ccno']);
			unset($json_value['post']['ccvv']);
			unset($json_value['post']['month']);
			unset($json_value['post']['year']);
			
		}
		if(isset($_GET)){
			unset($json_value['get']['ccno']);
			unset($json_value['get']['ccvv']);
			unset($json_value['get']['month']);
			unset($json_value['get']['year']);
		}
	}
	
	$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
	$json_value['REQUEST_URI']=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
	
	if(isset($_SERVER['HTTP_REFERER'])){
		$json_value['HTTP_REFERER']=$_SERVER['HTTP_REFERER'];
	}
	
	if(isset($_SERVER)){
		//$json_value['SERVER']=$_SERVER;
		$json_value['SERVER']=array_map('addslashes', $_SERVER);
	}
	
	$json_value=htmlTagsInArray($json_value);
	
	$json_value_en=(json_encode($json_value, JSON_UNESCAPED_UNICODE));
	//$json_value=preg_replace('~\\\/~', '/', $json_value);
 
	db_query(
		"INSERT INTO `db_test` ".
		" (`date`,`msg`) VALUES(".
		"NOW(),'{$json_value_en}' ".
		" )",0
	);
	
	if((strpos($data['urlpath'],'/bo.payfi.co.in/')!==false)||(strpos($data['urlpath'],'/pg.spay.live/')!==false))
	{
		$data['ROOT']='';
		//echo "<base target='_top'>";
		//include($data['ROOT']."payin/pay78/status_78.do"); exit;
		
	}
	
	
	if(isset($_REQUEST['urlaction']) && $_REQUEST['urlaction']=='notify'){
	
		//$return_notify_json='{"notify_code":"00","notify_msg":"received"}'; echo ($return_notify_json); exit;
		
		$return_notify_json= array(
			'notify_code'=>'00',
			'notify_msg'=>'received',
		);
		echo json_encode($return_notify_json);
		//echo $json_value_en;
		exit;
	}

?>

<!DOCTYPE html>
<html lang="en-US">
<head>
<title>View Post and Get data</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />

<style>
body{margin:0;padding:0;overflow:auto;width:100%;height:100%;
font-size:14px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; 
	 line-height: 24px; text-align: center;
	color: #468847;
    background-color: #dff0d8;
    border-color: #d6e9c6;
}	
p{font-size:18px; margin:10px 10px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; float:left; width:100%;width: 100%; line-height: 34px;}	

.textView{font-size:16px;margin:5% auto;font-family:Arial,Helvetica,sans-serif;color:#5d5c5d;width:70%;line-height:34px;word-break:break-word;padding:10%;background:#fff;float:unset;display:block;border-radius:12px}
</style>
</head>
<body>
<div class="textView"><?=$json_value_en;?></div>
</body>
</html>

<?}?>