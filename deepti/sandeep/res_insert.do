<?
	//		/res_insert.do?fname=smith&lname=kr

	if(!isset($data['Username'])&&!isset($data['Password'])){
		include('config_db.do');
	}

	$json_value_ins['post']=array();$json_value_ins['get']=array();
	if(isset($_POST)){$json_value_ins['post']=get_post1($_POST);}
	if(isset($_GET)){$json_value_ins['get']=get_post1($_GET);}
	
	if((isset($data['con_name'])&&$data['con_name']=='clk')||(isset($ztspaypci)&&$ztspaypci==true)){
		if(isset($_POST)){
			unset($json_value_ins['post']['ccno']);
			unset($json_value_ins['post']['ccvv']);
			unset($json_value_ins['post']['month']);
			unset($json_value_ins['post']['year']);
			
		}
		if(isset($_GET)){
			unset($json_value_ins['get']['ccno']);
			unset($json_value_ins['get']['ccvv']);
			unset($json_value_ins['get']['month']);
			unset($json_value_ins['get']['year']);
		}
	}
	
	$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
	$json_value_ins['REQUEST_URI']=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
	
	if(isset($_SERVER['HTTP_REFERER'])){
		$json_value_ins['HTTP_REFERER']=$_SERVER['HTTP_REFERER'];
	}
	
	if(isset($_SERVER)){
		$json_value_ins['SERVER']=$_SERVER;
	} 
	
	$json_value_ins=json_encode($json_value_ins);
 
 
	db_query(
		"INSERT INTO `db_test` ".
		" (`date`,`msg`) VALUES(".
		"NOW(),'{$json_value_ins}' ".
		" )",0
	);
	

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
<div class="textView"><?=$json_value_ins;?></div>
</body>
</html>