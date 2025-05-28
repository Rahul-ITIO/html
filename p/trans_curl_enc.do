<?
include('../config.do');

if(isset($_REQUEST['j'])&&trim($_REQUEST['j'])){
	$jsp=prntext($_REQUEST['j']);
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
$private_key = $_SESSION['test_merchant1']['private_key'];	// Secret Key 

$website_public_key=trim($_POST['public_key']);			// Website API Token
$terNO=trim($_POST['terNO']);					// Website Id 
		
$gateway_url=trim($_POST['actionUrl']);

#######################################################
//<!--default (fixed) value * default -->
	
$protocol	= isset($_SERVER["HTTPS"])?'https://':'http://';
$referer	= $protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

$postData	= $_POST;

$postData["public_key"]=$website_public_key; 
$postData["terNO"]=$terNO; 

#################################################

$postData["source"]=trim($_POST['actionType']);
$postData["source_url"]=$referer;

echo "<br/><br/>postData=>";
print_r($postData);

$get_string=http_build_query($postData);

echo "<br/><br/>get_string=>".$get_string;

function data_encode($string,$private_key,$website_public_key) {
	$output = false;
	$encrypt_method = "AES-256-CBC";
	$iv = substr( hash( 'sha256', $website_public_key ), 0, 16 );
	$output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $private_key, 0, $iv ) ), '+/', '-_'), '=');
	return $output;
}


if($postData["source"]=='S2S-Curl-Encode' || $postData["source"]=='S2S-Curl-Direct')
{

	if($postData["source"]=='S2S-Curl-Encode')
	{
		$encrypted = data_encode($get_string,$private_key,$website_public_key);
	
		$encrypted_payload=array();
		$encrypted_payload['encrypted_payload']=$encrypted.$website_public_key;
		
	}
	else
	{
		$encrypted_payload=$postData;
	}
	echo "<br/><br/>gateway_url=>".$gateway_url;
	echo "<br/>encrypted_payload=>";
	print_r($encrypted_payload);
	echo "<br/>source=>".$postData["source"];
	//exit;
	
	
	$curl_cookie="";
	$curl = curl_init(); 
	curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
	curl_setopt($curl, CURLOPT_URL, $gateway_url);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
	curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
	curl_setopt($curl, CURLOPT_REFERER, $referer);
	curl_setopt($curl, CURLOPT_POST, 1);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $encrypted_payload);
	curl_setopt($curl, CURLOPT_HEADER, 0);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	$response = curl_exec($curl);
	curl_close($curl);
	
	$results = json_decode($response,true);
	
	echo "<br/>response=>";
	print_r($response);
	
	echo "<br/><br/>encrypted_results=>";
	print_r($results);exit;
	
	
	if((isset($results["Error"]) && ($results["Error"]))||(isset($results["error"]) && ($results["error"]))){
		print_r($results); exit;
	}
	elseif(!isset($results)){
		echo $response;exit;
	}

	
	//0:Pending,1:Approved/Success,9:Test Transaction,2:Declined/Failed, 22:Expired, 23:Cancelled
	$order_status = (isset($results["order_status"])&&$results["order_status"]?(int)($results["order_status"]):'');
	
	$sub_query = http_build_query($results);
	
	//print_r($response);
	
	
	if(!isset($results["authurl"])){ print_r($results);exit; }

	
	
	if(isset($results["authurl"]) && $results["authurl"]){ //3D Bank URL
		$redirecturl = $results["authurl"];
		header("Location:".$redirecturl);exit;
	}elseif($order_status==1 || $order_status==9){ // 1:Approved/Success,9:Test Transaction
		$redirecturl = $curlPost["success_url"];
		if(strpos($redirecturl,'?')!==false){
			$redirecturl = $redirecturl."&".$sub_query;
		}else{
			$redirecturl = $redirecturl."?".$sub_query;
		}
		header("Location:$redirecturl");exit;
	}elseif($order_status==2||$order_status==22||$order_status==23){  // 2:Declined/Failed, 22:Expired, 23:Cancelled
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
elseif($postData["source"]=='S2S-Host-Encode')
{
	if($get_string){	
		$encrypted = data_encode($get_string,$private_key,$website_public_key);
		if($encrypted){
			header("Location:{$gateway_url}?encrypted_payload={$encrypted}{$website_public_key}");exit;
		}
	}
}
exit;
?>