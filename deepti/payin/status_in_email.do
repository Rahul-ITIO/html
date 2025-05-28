<?
// /payin/status_in_email.do?dtest=3&name=dev&em=devops@itio.in&c=1
// /payin/status_in_email.do?dtest=3&name=dev&em=arun@itio.in&c=1

$data['testEmail_1']='devops@itio.in';
if((isset($_GET['em']))&&($_GET['em'])){
	$data['testEmail_1']=$_GET['em'];
}

if(!function_exists('htmlTagsInArray')){
	function htmlTagsInArray(array $input, $throwByFoundObject=true)
	{
		$output = $input;
		if(isset($output)&&$output&&is_array($output)){
			foreach ($output as $key => $value) {
				if (is_string($value)) {
					//$output[$key] = trim(strip_tags($value));
					if (strcmp($value, strip_tags($value)) == 0){
						// no tags found
						
						//returns a string or an array with all occurrences of search in subject (ignoring case) replaced with the given replace value.
						$text = str_ireplace(array('onmouseover','onclick','onmousedown','onmousemove','onmouseout','onmouseup','onmousewheel','onkeyup','onkeypress','onkeydown','oninvalid','oninput','onfocus','ondblclick','ondrag','ondragend','ondragenter','onchange','ondragleave','ondragover','ondragstart','ondrop','onscroll','onselect','onwheel','onblur',"'"), '', $value );
						$output[$key] = trim(htmlentities($text));
					}
					else
					{
						// tags found
						$output[$key] = htmlentities($value);
					}
				} elseif (is_array($value)) {
					$output[$key] = htmlTagsInArray($value);
				} elseif (is_object($value) && $throwByFoundObject) {
					throw new Exception('Object found in Array by key ' . $key);
				}
			}
		}
		return $output;
	}
}

function send_attchment_message5($email_to,$email_to_name,$email_subject,$email_message,$email_from='Dev Tech <devops@itio.in>',$email_reply='Dev Tech  <devops@itio.in>',$pst=0){
	global $data;
	
	$email_from_name=$email_from;
	$email_from_value="devops@itio.in";
	
	
	if(strpos($email_from,'>')!==false){
		$email_from_name=explode('<',$email_from);$email_from_name=$email_from_name[1];
		$email_from_value=explode('>',$email_from_name);$email_from_value=$email_from_value[0];
		//echo "<hr/>email_from_value:".$email_from_value;
	}
	
	$email_reply_name=$email_reply;
	$email_reply_value="devops@itio.in";
	if(strpos($email_reply,'>')!==false){
		$email_reply_name=explode('<',$email_reply);$email_reply_name=$email_reply_name[1];
		$email_reply_value=explode('>',$email_reply_name);$email_reply_value=$email_reply_value[0];
		//echo "<hr/>email_reply_value:".$email_reply_value;
	}
	
	$email_to_value="$email_to_name <$email_to>";
	//$email_to_value="devops@itio.in";
	
	
	//$email_message=stripslashes($email_message);
	//$email_message=addslashes($email_message);
	//$email_message=htmlentities($email_message);
	
	$postArray=array();
	$postArray['from']=$email_from;
	$postArray['to']=$email_to_value;
	if($email_reply){
		$postArray['h:Reply-To']=$email_reply;
	}
	$postArray['subject']=$email_subject;
	//$postArray['text']=$email_message;
	$postArray['html']=$email_message;
	
	if(isset($_GET['dtest'])&&$_GET['dtest']==3){
		echo "<br/> postArray=><pre><code>".json_encode($postArray); echo "</code></pre><br/>";
	}
	

  $ch = curl_init();
  curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
  curl_setopt($ch, CURLOPT_HEADER, 0);
 
		//curl_setopt($ch, CURLOPT_USERPWD, 'api:bc73b879c7d3a32621334c4913981fb5-0e6e8cad-6a6fec66');
		//curl_setopt($ch, CURLOPT_URL, 'https://api.mailgun.net/v3/noreply.e1pay.com/messages');
	 
		// "mail_gun_api":"api:07f8d9de2aa060dd312fad26b0decfb5-ef80054a-2ffd6975","mail_api_host":"mg.letspe.com",

		curl_setopt($ch, CURLOPT_USERPWD, 'api:07f8d9de2aa060dd312fad26b0decfb5-ef80054a-2ffd6975');
		curl_setopt($ch, CURLOPT_URL, 'https://api.mailgun.net/v3/mg.letspe.com/messages');
	 
	curl_setopt($ch, CURLOPT_POSTFIELDS, $postArray);

	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0); curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
		
	$result = curl_exec($ch);
	
	if(isset($_GET['dtest'])&&$_GET['dtest']==3)
	{
		echo "<br/> result=>".$result."<br/>";
	}

	$http_status	= curl_getinfo($ch, CURLINFO_HTTP_CODE);
	$curl_errno		= curl_errno($ch);
	curl_close($ch);
	
	
	if ($http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404) {
		$err_5001=[];
		$err_5001['Error']="5001";
		$err_5001['Message']="mail_gun_api - HTTP Status is {$http_status} and  returned ".$curl_errno;
		print_r($err_5001);
	}
	elseif($curl_errno){
		$err_5002=[];
		$err_5002['Error']="5002";
		$err_5002['Message']="mail_gun_api - HTTP Status is {$http_status} and Request Error ".curl_error($ch);
		print_r($err_5002);
	}

  return $result;
}


$email_from="Dev <{$data['testEmail_1']}>";
$email_to=$data['testEmail_1'];
$email_to_name="Dev Tech";


if(isset($data['email_subject'])&&trim($data['email_subject'])) 
	$email_subject=@$data['email_subject'];

else 
	$email_subject=((isset($td))?@$td['transID']." - Acquirer: ".@$td['acquirer']." - Bill Amt.: ".@$td['bill_amt']." ".@$td['bill_currency']:'')." - Mailgun Successfully Email has been received from  {$_SERVER["HTTP_HOST"]}";


$email_message="<html><h1>Hello, {$_SERVER["HTTP_HOST"]}</h1><p>Mailgun Successfully Email has been received</p>";


$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';	//Server and execution environment information
$urlpath=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];	//The URI which was given in order to access this page;

$email_message.="<p><b>urlpath: </b>".((isset($data['urlpath']))?$data['urlpath']:$urlpath)."</p>";


$contentType = (isset($_SERVER["CONTENT_TYPE"]) ? trim($_SERVER["CONTENT_TYPE"]) : '');

//if(strcasecmp($contentType, 'application/json') != 0)
{
	$body_input = file_get_contents("php://input");
	$object_input = json_decode($body_input, true);
	if(isset($object_input)&&$object_input){
		//$object_input=array_map('addslashes', $object_input);
		$object_input=htmlTagsInArray($object_input);
		$email_message.="<p><b>PHP_INPUT: </b>".json_encode($object_input, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
	}
	elseif(trim($body_input)){
		$email_message.="<p><b>METHOD_INPUT_NONE_JSON: </b>".$body_input."</p>";
	}
}

if(isset($data['gateway_push_notify'])&&$data['gateway_push_notify']&&is_array($data['gateway_push_notify'])){
	$gateway_push_notify=$data['gateway_push_notify'];
	//print_r($gateway_push_notify);
	$gateway_push_notify=htmlTagsInArray($gateway_push_notify);
	//$gateway_push_notify=array_map('addslashes', $gateway_push_notify);
	$email_message.="<p><b>gateway_push_notify: </b>".json_encode($gateway_push_notify, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
}elseif(isset($data['gateway_push_notify'])&&$data['gateway_push_notify']&&is_string($data['gateway_push_notify'])){
	$email_message.="<p><b>gateway_push_notify: </b>".$data['gateway_push_notify']."</p>";
}


if(isset($data['logs'])&&$data['logs']&&is_array($data['logs'])){
	foreach($data['logs'] as $ke=>$va){
		if(is_array($va)){
			$va_Arr=htmlTagsInArray($va);
			$email_message.="<p><b>{$ke}: </b>".json_encode($va_Arr, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
		}else {
			$email_message.="<p><b>{$ke}: </b>".$va."</p>";
		}
	}
}

if(isset($is_admin)&&$is_admin){
	$email_message.="<p><b>is_admin: </b>".$is_admin."</p>";
}
if(isset($callbacks_url)&&$callbacks_url){
	$email_message.="<p><b>callbacks_url: </b>".$callbacks_url."</p>";
}

if(isset($_SERVER['HTTP_SEC_CH_UA'])) unset($_SERVER['HTTP_SEC_CH_UA']);
if(isset($_SERVER['HTTP_SEC_CH_UA_PLATFORM'])) unset($_SERVER['HTTP_SEC_CH_UA_PLATFORM']);
	
	
if(isset($_SERVER['HTTP_REFERER'])){
	$email_message.="<p><b>HTTP_REFERER: </b>".$_SERVER['HTTP_REFERER']."</p>";
}
if(isset($_POST)){
	$email_message.="<p><b>_POST: </b>".json_encode($_POST, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
}
if(isset($_GET)){
	$email_message.="<p><b>_GET: </b>".json_encode($_GET, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
}
if(isset($_REQUEST)){
	$email_message.="<p><b>_REQUEST: </b>".json_encode($_REQUEST, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
}
if(isset($_SESSION)){
	//$email_message.="<p><b>_SESSION: </b>".json_encode($_SESSION)."</p>";
}
if(isset($browserOs)&&$browserOs){
	$email_message.="<p><b>browserOs</b>".json_encode($browserOs, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
} 

if(isset($data_send)&&$data_send){
	$email_message.="<p><b>data_send: </b>".json_encode($data_send, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
}

if(isset($_SERVER)){
	//$email_message.="<p><b>_SERVER</b>".json_encode($_SERVER, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
} 
if(isset($td)&&$td){
	$email_message.="<p><b>transDetails</b>".json_encode($td, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
}

$email_message.="</html>";

$sam['HostL']=1;


//echo "<br/>email_message=>".$email_message."<br/>";


//$response_mail=json_decode($response_mail,true); echo "<br/>response_mail=>";print_r($response_mail);
$email_message=stripslashes($email_message);
//$email_message=addslashes($email_message);

if(!isset($is_admin)||($is_admin==false&&!isset($_SESSION['adm_login'])) || (isset($send_attchment_message5)&&$send_attchment_message5==1)){
	if(isset($qp)&&$qp){
		echo "<br/>email_to=>".$email_to."<br/>";
		echo "<br/>email_to_name=>".$email_to_name."<br/>";
		echo "<br/>email_subject=>".$email_subject."<br/>";
	}


	$response_mail=send_attchment_message5($email_to,$email_to_name,$email_subject,$email_message,$email_from);	
	
	if((isset($data['devEmail']))&&($data['devEmail'])){
		$devEmail=explode(',',$data['devEmail']);
		foreach($devEmail as $key=>$val){
			if($val) $response_mail=send_attchment_message5($val,$val,$email_subject,$email_message,$email_from);	
		}
	}
		
	if(isset($_GET['dtest'])&&$_GET['dtest']==3){
		echo "<br/>email_to=>".$email_to."<br/>";
		echo "<br/>email_to_name=>".$email_to_name."<br/>";
		echo "<br/>email_subject=>".$email_subject."<br/>";
		//echo "<br/>email_message=>".$email_message."<br/>";
		
		$response_mail=json_decode($response_mail,true); echo "<br/>response_mail=><br/>"; print_r($response_mail);  exit;
	}
	
}
	

?>