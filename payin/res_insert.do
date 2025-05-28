<?

$json_value_ins['post']=array();$json_value_ins['get']=array();
if(isset($_POST)){$json_value_ins['post']=($_POST);}
if(isset($_GET)){$json_value_ins['get']=($_GET);}

$contentType_ins = (isset($_SERVER["CONTENT_TYPE"]) ? trim($_SERVER["CONTENT_TYPE"]) : '');
//if(strcasecmp($contentType_ins, 'application/json') != 0)
{
	$body_input = file_get_contents("php://input");
	if(isset($body_input)&&$body_input)  $object_input = json_decode($body_input, true);

	if(isset($object_input)&&$object_input){
		$json_value_ins['object_input']= $object_input;
	}
	elseif(trim($body_input)){
		$json_value_ins['object_input_none_json']= $body_input;
	}

}

if(isset($data['PHP_INPUT'])&&$data['PHP_INPUT']){
	$body_input = file_get_contents("php://input");
	$object_input2 = $json_value_ins['object_input2']= json_decode($body_input, true);
}

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

if(isset($_SERVER['HTTP_SEC_CH_UA'])) unset($_SERVER['HTTP_SEC_CH_UA']);
if(isset($_SERVER['HTTP_SEC_CH_UA_PLATFORM'])) unset($_SERVER['HTTP_SEC_CH_UA_PLATFORM']);


if(isset($_SERVER['HTTP_REFERER'])){
	$json_value_ins['HTTP_REFERER']=$_SERVER['HTTP_REFERER'];
}

if(isset($_SERVER)){
	//$json_value_ins['SERVER']=$_SERVER;
	//$json_value_ins['SERVER']=array_map('addslashes', $_SERVER);
} 

if(isset($data['gateway_push_notify'])&&$data['gateway_push_notify']&&is_array($data['gateway_push_notify'])){
	$gateway_push_notify=$data['gateway_push_notify'];
	$json_value_ins['gateway_push_notify']=$gateway_push_notify;
}elseif(isset($data['gateway_push_notify'])&&$data['gateway_push_notify']&&is_string($data['gateway_push_notify'])){
	$json_value_ins['gateway_push_notify']=$gateway_push_notify;
}


if(isset($data['logs'])&&$data['logs']&&is_array($data['logs'])){
	foreach($data['logs'] as $ke=>$va){
		$json_value_ins[$ke]=$va;
	}
}

$json_value_ins=htmlTagsInArray($json_value_ins);

$json_value_ins_en=json_encode($json_value_ins, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);



db_query(
	"INSERT INTO `db_test` ".
	" (`date`,`msg`) VALUES(".
	"NOW(),'{$json_value_ins_en}' ".
	" )",0
);


?>
