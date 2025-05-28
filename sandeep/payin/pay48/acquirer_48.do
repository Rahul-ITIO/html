<?	$salt = $apc_get['salt'];
	$param['key']= $apc_get['key'];
	$salt =$salt;
	$param['key']= $apc_get['key'];
	$param['txnid']=$transID;
	$param['amount']=$total_payment;
	$param['productinfo']="Request to {$post['product']} via ".$transID;
	$param['firstname']=$_SESSION['info_data']['first_name'];
	$param['phone']=$post['bill_phone'];
	$param['email']=$post['bill_email'];
	$param['surl']=$status_url_1;
	$param['furl']=$status_url_1;
	//Hash Sequence
	$hashSequence = $param['key'] . "|" . $param['txnid']. "|" . $param['amount'] . "|" . $param['productinfo'] . "|" .$param['firstname'] . "|" . $param['email'] ."|" . "|" . "|" . "|"  ."|" . "|" . "|" . "|" . "|" . "|" .  "|" . $salt;
	   $hash = hash('sha512', $hashSequence);
	$param['hash']=$hash;
	$param['request_flow']="SEAMLESS";
	//print_r($param);
	
	$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
	$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
	
	
	$string = http_build_query($param);
	$urlIn = $bank_url."/payment/initiateLink";
	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL =>  $urlIn,
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 30,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS => $string ,
	  CURLOPT_HTTPHEADER => array(
		'Content-Type: application/x-www-form-urlencoded'
	  ),
	));

	$response = curl_exec($curl);

	curl_close($curl);
	$res = json_decode($response,1);
	//print_r($res);
	//exit;
	$access_Key=$res['data'];



	$tr_upd_order['Response_1']  = $response;

	$tr_upd_order['param']=$param;
	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);


if($acquirer==48)
{ // UPI Collect 
		
		
	if(isset($post['bill_phone']) && !empty($post['bill_phone']) && (empty($post['upi_address'])) )
	{
		$post['upi_address']=$post['bill_phone'];
	}
		
	if(isset($post['upi_address_suffix'])&&$post['upi_address_suffix'] && (strpos($post['upi_address'],'@')===false) ) 
	{ 
		$post['upi_address']=$post['upi_address'].$post['upi_address_suffix'];
		
	}
	
	$tr_upd_order['upa']=$post['upi_address'];

	$postData['access_key']=$access_Key;
	$postData['payment_mode']="UPI";
	$postData['upi_va']= $post['upi_address'];
	$postData['request_mode']="SUVA";
	$StringUPI = http_build_query($postData);

	
	$gateway_url = $bank_url."/initiate_seamless_payment/";
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, 'https://pay.easebuzz.in/initiate_seamless_payment/');
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	$response_2 = curl_exec($ch);
	curl_close($ch);

	// Extract CSRF token from response
	preg_match('/<input type="hidden" name="csrf_token" value="(.*)"\/>/', $response_2, $matches);
	$csrfToken = $matches[1];

	$curl = curl_init();
	//curl_setopt($curl, CURLOPT_REFERER, $referer);
	curl_setopt_array($curl, array(
	  CURLOPT_URL =>  $gateway_url,
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_SSL_VERIFYPEER => 0,
	  CURLOPT_SSL_VERIFYHOST => 0,
	  CURLOPT_USERAGENT=> $_SERVER['HTTP_USER_AGENT'],
	  CURLOPT_REFERER => $referer,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 30,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS => $StringUPI ,
	   CURLOPT_HEADER=> 0,
	  CURLOPT_HTTPHEADER => array(
		'Content-Type: application/x-www-form-urlencoded',
			'X-CSRFToken: ' . $csrfToken,
	  ),
	));

	$response = curl_exec($curl);

	curl_close($curl);
	$resUpi = json_decode($response,1);
	
	$tr_upd_order['Intent_Response_1']=$response=base64_encode($response);
	
	//print_r($resUpi);
	$json_arr_set['UPICOLLECT']='Y';
	$tr_upd_order['access_Key']= $access_Key;
	$tr_upd_order['request']= $param;
	$tr_upd_order['request_post']= $postData;
	$tr_upd_order['response_intent']  = $resUpi;
	$tr_upd_order['hash']   = $hash;
	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
	$curl_values_arr['responseInfo'] =$tr_upd_order['response_intent'];
	//$_SESSION['acquirer_action']=1;
	//$_SESSION['curl_values']=$curl_values_arr;
	//$curl_values_arr['browserOsInfo']=$browserOs;
}
elseif($acquirer==481){ // Net Banking Payment 

		//$salt ="DGOWXA1QBO";
		//$post['key']="QOD594EXO8";
		//$post['txnid']=rand();
		//$post['amount']="50.0";
		//$post['productinfo']="test";
		//$post['firstname']="deepti";
		//$post['phone']="+9977997799";
		//$post['email']="deepti@gmail.com";
		//$post['surl']="http://localhost/test/success.php";
		//$post['furl']="http://localhost/test/cancel.php";

		  //$hashSequence = $post['key'] . "|" . $post['txnid']. "|" . $post['amount'] . "|" . $post['productinfo'] . "|" .$post['firstname'] . "|" . $post['email'] ."|" . "|" . "|" . "|"  ."|" . "|" . "|" . "|" . "|" . "|" .  "|" . $salt;
		   //$hash = hash('sha512', $hashSequence);
		  //$post['hash']=$hash;
		  //$post['show_payment_mode']="NB";
		  //$post['request_flow']="SEAMLESS";
		  //print_r($post);
		  //exit;
		  //$string = http_build_query($post);
		  //$curl = curl_init();

		//curl_setopt_array($curl, array(
		  //CURLOPT_URL => 'https://pay.easebuzz.in/payment/initiateLink',
		  //CURLOPT_RETURNTRANSFER => true,
		  //CURLOPT_ENCODING => '',
		  //CURLOPT_MAXREDIRS => 10,
		  //CURLOPT_TIMEOUT => 30,
		  //CURLOPT_FOLLOWLOCATION => true,
		  //CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  //CURLOPT_CUSTOMREQUEST => 'POST',
		  //CURLOPT_POSTFIELDS => $string ,
		  //CURLOPT_HTTPHEADER => array(
		   // 'Content-Type: application/x-www-form-urlencoded'
		 // ),
		//));

		//$response = curl_exec($curl);

		//curl_close($curl);
		//$res = json_decode($response,1);*/

		$access_Key=$res['data'];
		$postData['access_key']=$access_Key;
		$postData['payment_mode']="NB";
		$postData['bank_code']=$post['bankCode'];
		$StringUPI = http_build_query($postData);
		$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
		$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
		$gateway_url = "https://pay.easebuzz.in/initiate_seamless_payment/";


		// Fetch CSRF token
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, 'https://pay.easebuzz.in/initiate_seamless_payment/');
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		$response_2 = curl_exec($ch);
		curl_close($ch);

		// Extract CSRF token from response
		preg_match('/<input type="hidden" name="csrf_token" value="(.*)"\/>/', $response_2, $matches);
		$csrfToken = $matches[1];

		$curl = curl_init();
		//curl_setopt($curl, CURLOPT_REFERER, $referer);
		curl_setopt_array($curl, array(
		  CURLOPT_URL => 'https://pay.easebuzz.in/initiate_seamless_payment/',
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_SSL_VERIFYPEER => 0,
		  CURLOPT_SSL_VERIFYHOST => 0,
		  CURLOPT_USERAGENT=> $_SERVER['HTTP_USER_AGENT'],
		  CURLOPT_REFERER => $referer,
		  CURLOPT_ENCODING => '',
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 30,
		  CURLOPT_FOLLOWLOCATION => true,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => 'POST',
		  CURLOPT_POSTFIELDS => $StringUPI ,
		   CURLOPT_HEADER=> 0,
		  CURLOPT_HTTPHEADER => array(
			'Content-Type: application/x-www-form-urlencoded',
				'X-CSRFToken: ' . $csrfToken,
		  ),
		));

		$response = curl_exec($curl);
		curl_close($curl);
		
		//echo $response;
		
		$tr_upd_order['NB_Response_1']=$response=base64_encode($response);
			
		$auth_3ds2_secure = $response;
		$auth_3ds2_base64=1;
		//$auth_3ds2_action='echo';
		
		$tr_upd_order['NB_Response_1']=$auth_3ds2_secure;
		$tr_upd_order['NB_postData']=$postData;
		
		//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

}
elseif($acquirer==482){ // UPI QR & Intent

	$postQr['access_key']=$access_Key;
	$postQr['payment_mode']="UPI";
	$postQr['upi_qr']= "true";
	$postQr['request_mode']="SUVA";
	$StringQr = http_build_query($postQr);
	
	 $gateway_url = $bank_url."/initiate_seamless_payment/";
	preg_match('/<input type="hidden" name="csrf_token" value="(.*)"\/>/', $response, $matches);
	$csrfToken = $matches[1];
	$curl = curl_init();
	//curl_setopt($curl, CURLOPT_REFERER, $referer);
	curl_setopt_array($curl, array(
	  CURLOPT_URL =>  $gateway_url,
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_SSL_VERIFYPEER => 0,
	  CURLOPT_SSL_VERIFYHOST => 0,
	  CURLOPT_USERAGENT=> $_SERVER['HTTP_USER_AGENT'],
	  CURLOPT_REFERER => $referer,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 30,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS => $StringQr ,
	   CURLOPT_HEADER=> 0,
	  CURLOPT_HTTPHEADER => array(
		'Content-Type: application/x-www-form-urlencoded',
			'X-CSRFToken: ' . $csrfToken,
	  ),
	));

	$response = curl_exec($curl);
	curl_close($curl);
	//echo $response;
	$resQr = json_decode($response,1);
	//print_r($resQr);
	$QrUrl=$resQr['qr_link'];
	$urlEn=urlencode($QrUrl);
	$qr_intent_address=$urlEn; // return upi address for auto run for check via mobile or web 
	$intent_process_redirect=1;


}
elseif($acquirer==483 || $acquirer==484){  // 483 -  Debit - 3D Card Payment & 484 -  Credit - 3D Card Payment
	
	if($acquirer==483) $postCard['payment_mode']="CC";
	elseif($acquirer==484) $postCard['payment_mode']="DC";
		
	if($postCard['payment_mode']=="CC")
	{

			  $access_Key=$res['data'];
			  $method = "aes-256-cbc";
			   $key = substr(hash('sha256',$apc_get['key']), 0, 32);
			   $iv = substr(hash('sha256', $salt), 0, 16);
			  $card=$post['ccno'];
			  $encrypted_card_number = openssl_encrypt($card, $method, $key, 0, $iv);
			  $name = $post['fullname'];
			  $encrypted_card_holder_name = openssl_encrypt($name, $method, $key, 0, $iv);
			   $cvv=$post['ccvv'];
			  $encrypted_card_cvv = openssl_encrypt($cvv, $method, $key, 0, $iv);
			   $date=$post['month'].'/'.$post['year4'];
			   $encrypted_card_expiry_date = openssl_encrypt($date, $method, $key, 0, $iv);
			   $postCard['access_key']= $access_Key;
				$postCard['payment_mode']= "CC";
				$postCard['card_number']= $encrypted_card_number;
				$postCard['card_holder_name']= $encrypted_card_holder_name;
				$postCard['card_cvv']= $encrypted_card_cvv;
				$postCard['card_expiry_date']= $encrypted_card_expiry_date;
				$StringUPI = http_build_query($postCard);
				$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
			$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
			$gateway_url = "https://pay.easebuzz.in/initiate_seamless_payment/";



			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, 'https://pay.easebuzz.in/initiate_seamless_payment/');
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			$response = curl_exec($ch);
			curl_close($ch);

			// Extract CSRF token from response
			preg_match('/<input type="hidden" name="csrf_token" value="(.*)"\/>/', $response, $matches);
			$csrfToken = $matches[1];

			$curl = curl_init();
			//curl_setopt($curl, CURLOPT_REFERER, $referer);
			curl_setopt_array($curl, array(
			  CURLOPT_URL => 'https://pay.easebuzz.in/initiate_seamless_payment/',
			  CURLOPT_RETURNTRANSFER => true,
			  CURLOPT_SSL_VERIFYPEER => 0,
			  CURLOPT_SSL_VERIFYHOST => 0,
			  CURLOPT_USERAGENT=> $_SERVER['HTTP_USER_AGENT'],
			  CURLOPT_REFERER => $referer,
			  CURLOPT_ENCODING => '',
			  CURLOPT_MAXREDIRS => 10,
			  CURLOPT_TIMEOUT => 30,
			  CURLOPT_FOLLOWLOCATION => true,
			  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			  CURLOPT_CUSTOMREQUEST => 'POST',
			  CURLOPT_POSTFIELDS => $StringUPI ,
			   CURLOPT_HEADER=> 0,
			  CURLOPT_HTTPHEADER => array(
				'Content-Type: application/x-www-form-urlencoded',
					'X-CSRFToken: ' . $csrfToken,
			  ),
			));

			$response = curl_exec($curl);

			curl_close($curl);
			echo $response;
		
	}
	elseif($postCard['payment_mode']=="DC")
	{
		$access_Key=$res['data'];
		  $method = "aes-256-cbc";
		   $key = substr(hash('sha256',$apc_get['key']), 0, 32);
		   $iv = substr(hash('sha256', $salt), 0, 16);
		  $card=$post['ccno'];
		  $encrypted_card_number = openssl_encrypt($card, $method, $key, 0, $iv);
		  $name = $post['fullname'];
		  $encrypted_card_holder_name = openssl_encrypt($name, $method, $key, 0, $iv);
		   $cvv=$post['ccvv'];
		  $encrypted_card_cvv = openssl_encrypt($cvv, $method, $key, 0, $iv);
		   $date=$post['month'].'/'.$post['year4'];
		   $encrypted_card_expiry_date = openssl_encrypt($date, $method, $key, 0, $iv);
		   $postCard['access_key']= $access_Key;
			$postCard['payment_mode']= "DC";
			$postCard['card_number']= $encrypted_card_number;
			$postCard['card_holder_name']= $encrypted_card_holder_name;
			$postCard['card_cvv']= $encrypted_card_cvv;
			$postCard['card_expiry_date']= $encrypted_card_expiry_date;
			$StringUPI = http_build_query($postCard);
			$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
		$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
		$gateway_url = "https://pay.easebuzz.in/initiate_seamless_payment/";



		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, 'https://pay.easebuzz.in/initiate_seamless_payment/');
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($ch);
		curl_close($ch);

		// Extract CSRF token from response
		preg_match('/<input type="hidden" name="csrf_token" value="(.*)"\/>/', $response, $matches);
		$csrfToken = $matches[1];
		$curl = curl_init();
		//curl_setopt($curl, CURLOPT_REFERER, $referer);
		curl_setopt_array($curl, array(
		  CURLOPT_URL => 'https://pay.easebuzz.in/initiate_seamless_payment/',
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_SSL_VERIFYPEER => 0,
		 CURLOPT_SSL_VERIFYHOST => 0,
		  CURLOPT_USERAGENT=> $_SERVER['HTTP_USER_AGENT'],
		  CURLOPT_REFERER => $referer,
		  CURLOPT_ENCODING => '',
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 30,
		  CURLOPT_FOLLOWLOCATION => true,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => 'POST',
		  CURLOPT_POSTFIELDS => $StringUPI ,
		   CURLOPT_HEADER=> 0,
		  CURLOPT_HTTPHEADER => array(
			'Content-Type: application/x-www-form-urlencoded',
				'X-CSRFToken: ' . $csrfToken,
		  ),
		));

		$response = curl_exec($curl);

		curl_close($curl);
		echo $response;

	}
	  




}


$tr_upd_order['Response']  = $response;

$tr_upd_order['postData']=$postData;
trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

?>
 
