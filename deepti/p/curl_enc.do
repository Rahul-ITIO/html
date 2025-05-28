<?
include('../config.do');

if(isset($_REQUEST['j'])&&trim($_REQUEST['j'])){
	$jsp=$_REQUEST['j'];
	$hostUrl=jsonvaluef($jsp,'hostUrl');
	$process_file=jsonvaluef($jsp,'process_file');
	$hostUrlRedirect=$hostUrl."/".$process_file.$data['ex'];
	
	$jsp_de=jsondecode($jsp,1,1);
	if(isset($jsp_de)&&isset($jsp_de['post'])){
		$jsp_post=$jsp_de['post'];
		if(isset($jsp_post['step']))unset($jsp_post['step']);
		if(isset($jsp_post['status']))unset($jsp_post['status']);
		//if(isset($jsp_post['midcard']))unset($jsp_post['midcard']);
		
		post_redirect($hostUrlRedirect, $jsp_post);
	}
	
	//if(isset($_REQUEST['dtest']))
	{
		echo "<br/>hostUrl=>".$hostUrl;
		echo "<br/>process_file=>".$process_file;
		echo "<br/>hostUrlRedirect=>".$hostUrlRedirect;
		echo "<br/>jsp=>".$jsp;
		echo "<br/><br/>jsp_de=>";print_r($jsp_de);
		echo "<br/><br/>jsp_post=>";print_r($jsp_post);
	}
	exit;
}

// you may change these values to your own
$secret_key = $_SESSION['test_merchant1']['private_key'];	// Secret Key 

$website_api_token=trim($_POST['api_token']);			// Website API Token
$website_id=trim($_POST['store_id']);					// Website Id 
		
$gateway_url=trim($_POST['actionUrl']);

#######################################################
//<!--default (fixed) value * default -->
	
$protocol	= isset($_SERVER["HTTPS"])?'https://':'http://';
$referer	= $protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

$pramPost	= $_POST;

$pramPost["api_token"]=$website_api_token; 
$pramPost["website_id"]=$website_id; 

#################################################

$pramPost["source"]=trim($_POST['actionType']);
$pramPost["source_url"]=$referer;


$get_string=http_build_query($pramPost);

function data_encode($string,$secret_key,$website_api_token) {
	$output = false;
	$encrypt_method = "AES-256-CBC";
	$iv = substr( hash( 'sha256', $website_api_token ), 0, 16 );
	$output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $secret_key, 0, $iv ) ), '+/', '-_'), '=');
	return $output;
}

if($pramPost["source"]=='S2S-Curl-Encode' || $pramPost["source"]=='S2S-Curl-Direct')
{

	if($pramPost["source"]=='S2S-Curl-Encode')
	{
		$encrypted = data_encode($get_string,$secret_key,$website_api_token);
	
		$pram_encode=array();
		$pram_encode['pram_encode']=$encrypted.$website_api_token;
	}
	else
	{
		$pram_encode=$pramPost;
	}
	$curl_cookie="";
	$curl = curl_init(); 
	curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
	curl_setopt($curl, CURLOPT_URL, $gateway_url);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
	curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
	curl_setopt($curl, CURLOPT_REFERER, $referer);
	curl_setopt($curl, CURLOPT_POST, 1);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $pram_encode);
	curl_setopt($curl, CURLOPT_HEADER, 0);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	$response = curl_exec($curl);
	curl_close($curl);
	
	$results = json_decode($response,true);
	
	if((isset($results["Error"]) && ($results["Error"]))||(isset($results["error"]) && ($results["error"]))){
		print_r($results); exit;
	}
	elseif(!isset($results)){
		echo $response;exit;
	}

	
	$status = strtolower($results["status"]);
	$status_nm = (int)($results["status_nm"]);
	
	$sub_query = http_build_query($results);
	
	//print_r($response);
	print_r($results);exit;
	
	if(!isset($results["authurl"])){ print_r($results);exit; }

	
	
	if(isset($results["authurl"]) && $results["authurl"]){ //3D Bank URL
		$redirecturl = $results["authurl"];
		header("Location:".$redirecturl);exit;
	}elseif($status_nm==1 || $status_nm==9){ // 1:Approved/Success,9:Test Transaction
		$redirecturl = $curlPost["success_url"];
		if(strpos($redirecturl,'?')!==false){
			$redirecturl = $redirecturl."&".$sub_query;
		}else{
			$redirecturl = $redirecturl."?".$sub_query;
		}
		header("Location:$redirecturl");exit;
	}elseif($status_nm==2||$status_nm==22||$status_nm==23){  // 2:Declined/Failed, 22:Expired, 23:Cancelled
		$redirecturl = $curlPost["error_url"];
		if(strpos($redirecturl,'?')!==false){
			$redirecturl = $redirecturl."&".$sub_query;
		}else{
			$redirecturl = $redirecturl."?".$sub_query;
		}
		header("Location:$redirecturl");exit;
	}else{ // Pending
		$redirecturl = $referer;
		if(strpos($redirecturl,'?')!==false){
			$redirecturl = $redirecturl."&".$sub_query;
		}else{
			$redirecturl = $redirecturl."?".$sub_query;
		}
		header("Location:$redirecturl");exit;
	}



}
elseif($pramPost["source"]=='S2S-Host-Encode')
{
	if($get_string){	
		$encrypted = data_encode($get_string,$secret_key,$website_api_token);
		if($encrypted){
			header("Location:{$gateway_url}?pram_encode={$encrypted}{$website_api_token}");exit;
		}
	}
}
exit;
?>