
<?php
if(!isset($_SESSION)) {
	session_start();
}

$content = file_get_contents("status_hardcode.do"); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:85vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;'>{$content}</code></pre>";

$qp=1;
//error_reporting(0);
error_reporting(E_ALL);
	
// localhost:8080/gw/payin/pay40/hardcode/status_hardcode.do?pq=1
	
	##################################################
	
	// Get transaction details based on transaction id.

	$get_orders_url="https://gw2.mcpayment.net:8443/api/v5/query/detail";
	
	if($qp)
	{
		echo "<br/><hr/><br/><h1>Query Details Get transaction details based on ::</h1> <h3>Request with referenceNo , currency , totalAmount sample: (ONLY applicable when request timeout)</h1><br/>";
		
	}
	
	function sendRequest343st($gateway_url, $data_string){
		global $headers;
		$content = json_encode($data_string);

		$curl = curl_init($gateway_url);
		curl_setopt($curl, CURLOPT_HEADER, 0);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, 24);
		
		curl_setopt($curl, CURLOPT_HTTPHEADER, array("Content-type: application/json"));
		curl_setopt($curl, CURLOPT_POST, true);
		
		curl_setopt($curl, CURLOPT_POSTFIELDS, $content);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);

		$json_response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		if ( $status != 200 ) 
		{
		
			$json_response=("Error: call to URL $gateway_url failed with status $status, response $json_response, curl_error " . curl_error($curl) . ", curl_errno " . curl_errno($curl) . ", request " . $content);
			
			echo "<br/><hr/>json_response=><br/>";print_r(@$json_response);

		}
		curl_close($curl);

		return $json_response;
	}
		
	#############################################

		
	$statusPost1['version']='5';
	$statusPost1['appType']='W';
	$statusPost1['appVersion']='S2.00.00'; 
	$statusPost1['mcpTerminalId']='3122030046';

		$statusPost2['filter']='';
		$statusPost2['receiptNumber']='2024071199401001660206690282';
		$statusPost2['queryType']='';
		$statusPost2['transactionId']='13232540';
		
	$statusPost3['referenceNo']='4015123313'; //    4015123313    40115206228
	$statusPost3['totalAmount']='2757';
	$statusPost3['currency']='SGD';
		
		
		
	$dta['header']=$statusPost1;
	$dta['data']=$statusPost3;
	
	//print_r($dta);
	$response=sendRequest343st($get_orders_url,$dta);
	
	$result = json_decode($response,true);
	//$result = $result1['data'];
	
	if($result){
		echo "<br/><hr/>Gateway Status URL=> ";print_r(@$get_orders_url);
		echo "<br/><hr/>Post Request=><br/>";print_r(@$dta);
		echo "<br/><hr/>response=><br/>";print_r(@$result);
	}
	
	exit;
?>