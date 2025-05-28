<?php
function check_notify_response() {
	$order_id = $_GET["order_id"];
	$order = new WC_Order( (int)$order_id);
	$entityBody = file_get_contents('php://input');

	if($entityBody){
		$posback	= json_decode($entityBody);
		$mcptid		= $posback->mcptid;			
		$currency	= $posback->currency;
		$amount		= $posback->amount;
		$referenceNo= $posback->referenceNo;
		$tranId		= $posback->tranId;

		$responseCode = $posback->responseCode;		 

		if( $responseCode == '00') {
			$message = 'Payment completed<br/>Transaction ID: '.$tranId;

			$order->add_order_note( $message );
			$order->update_status( 'completed');
			$order->payment_complete();
		} else {
			$order->update_status('failed',__('Payment failed.'.print_r($posback, true),'woocommerce'));
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

function sendRequest($gateway_url, $data_string)
{

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
		//Debug	die("Error: call to URL $gateway_url failed with status $status, response $json_response, 	curl_error " . curl_error($curl) . ", curl_errno " . curl_errno($curl) . ", request " . $content);
	//
		//return 'error';
	}

	curl_close($curl);

	return $json_response;
}
?>