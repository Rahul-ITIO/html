<?
//header('Access-Control-Allow-Origin: *');
//https://api.zerobounce.net/services.asmx/validate?apikey=b09aef1541244c33935c306e8c002858&email=sgnitsolution@gmail.com
$urlpath=$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

function suspiciousemail_zerobounce($email=''){
	$apiKey = 'b09aef1541244c33935c306e8c002858';
	$result="";

	$get_contents = @file_get_contents("https://api.zerobounce.net/services.asmx/validate?apikey=".$apiKey."&email=".$email);
	$json_arr = json_decode($get_contents, true);
	
	$json["status"]=$json_arr['status'];
	$json["firstname"]=$json_arr['firstname'];
	$json["lastname"]=$json_arr['lastname'];
	$json["gender"]=$json_arr['gender'];
	
	//print_r($json_arr);
	return $json;
}

function suspiciousemail_xverify($email=''){
	$apiKey = '1008822-A18D8D73';
	$result=array();
	
	$get_contents = @file_get_contents("http://www.xverify.com/services/emails/verify/?email=".$email."&type=json&apikey=".$apiKey."&domain=google.com");
	$json_arr = json_decode($get_contents, true);

	$json_arr["status2"]=ucfirst($json_arr['email']['status']);
	
	//print_r($json_arr);
	return $json_arr;
}

function suspiciousemail_trumail($email=''){
	$result="";
	$get_contents = @file_get_contents("https://trumail.io/json/".$email);
	$result = json_decode($get_contents, true);
	if(isset($result["deliverable"])&&$result["deliverable"]==1){
		$result['status2']="Valid";
	}else{
		$result['status2']="Invalid";
	}	
	//print_r($result);
	return $result;
}
if(isset($_GET['email'])){
	//$json=suspiciousemail_xverify($_GET['email']);
	//$json=suspiciousemail_zerobounce($_GET['email']);
	if(!isset($_GET['ftype'])){
		$json=suspiciousemail_trumail($_GET['email']);
	}elseif(isset($_GET['ftype'])&&!empty($_GET['ftype'])){
		$ftype=$_GET['ftype'];
		if($ftype=="xverify"){
			$json=suspiciousemail_xverify($_GET['email']);
		}elseif($ftype=="zerobounce"){
			$json=suspiciousemail_zerobounce($_GET['email']);
		}
	}
	header("Content-Type: application/json", true);
	echo json_encode($json);
	
}
?>