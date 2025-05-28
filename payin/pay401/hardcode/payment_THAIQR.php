<?php

function check_notify_response() {
		$order_id = $_GET["order_id"];
		$order = new WC_Order( (int)$order_id );	    
		
		$entityBody = file_get_contents('php://input');
		if($entityBody != ''){
			$posback = json_decode($entityBody);
			$mcptid = $posback->mcptid;			
			$currency = $posback->currency;
			$amount = $posback->amount;
			$referenceNo =$posback->referenceNo;
			$tranId = $posback->tranId;
			
			$responseCode = $posback->responseCode;		 
			
			if( $responseCode == '00') {
				$message = 'Payment completed<br/>Transaction ID: '.$tranId;

				$order->add_order_note( $message );
				$order->update_status( 'completed');
				$order->payment_complete();
			} else {
				$order->update_status( 'failed', __( 'Payment failed.' . print_r($posback, true), 'woocommerce' ) );
			}
		}  
		
		exit;
	}
	
	function getGatewayUrl(){
		if($this->enviroment == 'test')
			$gateway_url = $this->test_gateway_url;
		else
			$gateway_url = $this->live_gateway_url;
			
		return $gateway_url;
	}
	
	function sendRequest($gateway_url, $data_string){
			$content = json_encode($data_string);

			$curl = curl_init($gateway_url);
			curl_setopt($curl, CURLOPT_HEADER, 0);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
				curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
				curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
			curl_setopt($curl, CURLOPT_HTTPHEADER,
					array("Content-type: application/json"));
			curl_setopt($curl, CURLOPT_POST, true);
			curl_setopt($curl, CURLOPT_POSTFIELDS, $content);

			$json_response = curl_exec($curl);

			$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		
			if ( $status != 200 ) {
			//Debug	die("Error: call to URL $gateway_url failed with status $status, response $json_response, curl_error " . curl_error($curl) . ", curl_errno " . curl_errno($curl) . ", request " . $content);
			//
				//return 'error';
			}

			curl_close($curl);

			return $json_response;
	}
	
$request['header']['version']="5";
$request['header']['appType']="APP";
$request['header']['appVersion']="1.2.3";
$request['header']['mcpTerminalId']="3122010035";

$request['data']['mcptid']="3122010035";
$request['data']['currency']="THB";
$request['data']['totalAmount']="100";
$request['data']['eType']="77777";
$request['data']['description']="test";
$request['data']['amountSettled']="100";
$request['data']['referenceNo']="esta1".date('is');

/*	
	//if(isset($_POST)){
$request = array("mcptid"=>"3122010035",
"currency"=>"THB",
"totalAmount"=>"100",
"eType"=>"77777",
"amountSettled"=>"2000",
"referenceNo"=>"esta1",
);
*/
		
//echo "<br/><hr/>request";
//print_r($request);
		
		
//echo $result = sendRequest('https://gw2.sandbox.mcpayment.net:8443/api/v6/payment', $request);
//$result = sendRequest('https://gw2.mcpayment.net:8443/api/v6/payment', $request);
$result = sendRequest('https://gw2.mcpayment.net/api/v5/ewallet/unifiedOrder', $request);
		
	
		echo "<br/><hr/>result=><br/>".$result;
		$result1=json_decode($result,1);
		print_r($result1);


		$qrdata = $result1['data']['qrUrl'];

?>
		<img src="https://quickchart.io/chart?chs=300x300&cht=qr&chl=<?=$qrdata;?>&choe=UTF-8" title="" />
<?
		
		//header("Location:$result");
		
		//$result=json_decode($result,1);
		
		//print_r($result);
	//}
	
	


?>