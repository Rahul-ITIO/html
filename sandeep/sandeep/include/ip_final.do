<?
$file_path="country_state.do";
if(file_exists($file_path)){include($file_path);}
function getLocationInfoByIp2($ipAddress='',$cityName='',$regionName='',$zipCode='',$countryName=''){
	$ip = $ipAddress;
	if(empty($ipAddress)){$ip = $_SERVER["REMOTE_ADDR"];}
	$result="";
	$ip_data_get = @file_get_contents("http://api.ipinfodb.com/v3/ip-city/?format=json&key=70086838bc895a777771af798f46975eb86c6a175e60412e6057ebba85b44823&ip=".$ip);
	$ip_data = json_decode($ip_data_get, true);
	if($cityName){$result=$ip_data["cityName"];}
	elseif($regionName){$result=$ip_data["regionName"];}
	elseif($zipCode){$result=$ip_data["zipCode"];}
	elseif($countryName){$result=$ip_data["countryCode"];}
	if(empty($cityName)&&empty($regionName)&&empty($zipCode)&&empty($countryName)){
		return $ip_data;
	}else{
		return $result;
	}
}
function suspiciousemailj($email=''){
	$result="";
	$get_contents = @file_get_contents("https://trumail.io/json/".$email);
	$result = json_decode($get_contents, true);
	if(isset($result["deliverable"])&&$result["deliverable"]==1){
		$result['email_status']="Valid";
	}else{
		$result['email_status']="Invalid";
	}	
	//print_r($result);
	return $result;
}

//Flag Reason: Suspicious IP - Region,city & zipcode

function suspiciousip($ipAddress='',$cityName='',$regionName='',$zipCode='',$type='',$email=''){
	$result=array();
	$status=false;
	$flag=false;
	$suspiciousip_status ="";
	$ipLocation=getLocationInfoByIp2($ipAddress);
	$state_iso=get_state_code($ipLocation['regionName']);
	$email_result=suspiciousemailj($email);
	
	$rmk_date=date('d-m-Y h:i:s A');
	
	if((!empty($cityName))&&($ipLocation['cityName']!=$cityName)){
		$suspiciousip_status.="<a class=flagtag>City: ".$ipLocation['cityName']." </a> "; 
		$status=true;
		//echo "<hr/>1: ".$ipLocation['cityName']."-".$cityName;
	}
	if((strlen($regionName)==2)&&(!empty($regionName))&&($state_iso!=$regionName)){
		$suspiciousip_status.="<a class=flagtag>State: ".$state_iso." </a> "; 
		$status=true;
		$flag=true;
		//echo "<hr/>2: ".$regionName."-".$state_iso;
	}elseif((strlen($regionName)>2)&&(!empty($regionName))&&($ipLocation['regionName']!=$regionName)){
		$suspiciousip_status.="<a class=flagtag>State: ".$ipLocation['regionName']." </a> "; 
		$status=true;
		$flag=true;
		//echo "<hr/>3: ".$ipLocation['regionName']."-".$regionName;
	}
	if((!empty($zipCode))&&($ipLocation['zipCode']!=$zipCode)){
		$suspiciousip_status.="<a class=flagtag>Zip: ".$ipLocation['zipCode']." </a> ";
		$status=true;
		//echo "<hr/>4: ".$ipLocation['zipCode']."-".$zipCode;
	}
	
	if((!empty($cityName))&&(strtolower($ipLocation['cityName'])==strtolower($cityName))){
		$status=false;
		$flag=false;
	}
	
	if((!empty($regionName))&&(strtolower($ipLocation['regionName'])==strtolower($regionName))){
		$status=false;
		$flag=false;
	}
	
	$system_note = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg> <b>Flag Reason: Suspicious IP - </b> ".$suspiciousip_status." </div></div>";
	
	if(isset($email_result["email_status"])&&$email_result["email_status"]=="Invalid"){
		$status=true;
		$flag=true;
		$system_note .= "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg> <b>Flag Reason: Suspicious Email - </b> <a class=flagtag>".$email.": Invalid </a></div></div>";
	}
	if(isset($email_result["email_status"])){$result['email_status']=$email_result["email_status"];}
	
	$result['status']=$status;
	$result['flag']=$flag;
	$result['system_note']=$system_note;
	
	return $result;
} 


// include/ip_final.do?ip=107.77.222.123&city=Manvel&state=TX&zip=77578&type=17&format=json

$ipAddress=""; $cityName=""; $regionName=""; $zipCode="";$type="";$email="";
if(isset($_GET['ip'])&&!empty($_GET['ip'])){$ipAddress=$_GET["ip"];}
if(isset($_GET['city'])&&!empty($_GET['city'])){$cityName=$_GET["city"];}
if(isset($_GET['state'])&&!empty($_GET['state'])){$regionName=$_GET["state"];}
if(isset($_GET['zip'])&&!empty($_GET['zip'])){$zipCode=$_GET["zip"];}
if(isset($_GET['type'])&&!empty($_GET['type'])){$type=$_GET["type"];}
if(isset($_GET['email'])&&!empty($_GET['email'])){$email=$_GET["email"];}


//$suspicious_ip=suspiciousemail($email);
$suspicious_ip=suspiciousip($ipAddress,$cityName,$regionName,$zipCode,$type,$email);

if(isset($_GET['format'])&&!empty($_GET['format'])&&($_GET['format']=="json")){
	header("Content-Type: application/json", true);
	echo json_encode($suspicious_ip);
}else{

	if(isset($suspicious_ip['status'])){
		echo "<hr/>suspicious_ip:";
		print_r($suspicious_ip);
		echo "<hr/>";
	}

	$iploc=getLocationInfoByIp2($ipAddress);print_r($iploc);
	//echo "<hr/>implode: ".implode(',',$iploc);
}


?>