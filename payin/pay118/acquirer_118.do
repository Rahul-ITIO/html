<?
// Dev Tech : 25-02-20  118 - transactionjunction -  Visa,Master via redirect

//$data['cqp']=9;


//{"client_id":"rk5cktg38koapig55pckagdd","client_secret":"1r63s9aqf6to4tmeq4j229p8ioeqjnq05mcf5tjt7f5of3arvsbl","merchantID":"f660d8c4-c839-4dac-a05d-7ea2138c5202","profileID":"44525823-af88-427a-98bb-4f8175edc3b7","mcc":"7299","terminalId":"12345678","paymentFacilitatorID":"01234567890","independentSalesOrganizationID":"01234567890","subMerchantID":"012345678901234","billingDescriptor":"string","merchantVerificationValue":"1234567890"}

$url="https://prod-ipgw-oauth.auth.eu-west-1.amazoncognito.com/oauth2/token";
$client_id=@$apc_get['client_id'];//"rk5cktg38koapig55pckagdd";
$client_secret=@$apc_get['client_secret'];//"1r63s9aqf6to4tmeq4j229p8ioeqjnq05mcf5tjt7f5of3arvsbl";
$merchantID=@$apc_get['merchantID'];//"f660d8c4-c839-4dac-a05d-7ea2138c5202";
$profileID=@$apc_get['profileID'];//"44525823-af88-427a-98bb-4f8175edc3b7";

$mcc=@$apc_get['mcc'];//"7299";
$terminalId=@$apc_get['terminalId'];//"12345678";
$paymentFacilitatorID=@$apc_get['paymentFacilitatorID'];//"01234567890";
$independentSalesOrganizationID=@$apc_get['independentSalesOrganizationID'];//"01234567890";
$subMerchantID=@$apc_get['subMerchantID'];//"012345678901234";
$billingDescriptor=@$apc_get['billingDescriptor'];//"string";
$merchantVerificationValue=@$apc_get['merchantVerificationValue'];//"1234567890";




$merchantRef=@$transID; /// Auto Generate


$redirectSuccessUrl=$status_default_url."&actionurl=success";
$redirectFailedUrl=$status_default_url."&actionurl=failed";
$redirectCancelUrl=$status_default_url."&actionurl=cancel";


	///////////////////////Step-1 :: access_token////////////////////////////
	
	$curl = curl_init();

	curl_setopt_array($curl, [
	CURLOPT_URL => $url,
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "POST",
        CURLOPT_HEADER => 0,
        CURLOPT_SSL_VERIFYPEER => 0,
        CURLOPT_SSL_VERIFYHOST => 0,
	CURLOPT_POSTFIELDS => "grant_type=client_credentials&client_id=$client_id&client_secret=$client_secret",
	CURLOPT_HTTPHEADER => [
		"Accept: application/json",
		"Content-Type: application/x-www-form-urlencoded"
	],
	]);

	$response = curl_exec($curl);
	$err = curl_error($curl);

	curl_close($curl);

	if ($err) {
	    echo "cURL Error #:" . $err;
	} else {
	// echo $response;
	}

	$res = json_decode($response,1);
	

    //Start after Access Token 
	if(isset($res["access_token"])&&$res["access_token"])
	{
		$access_token=$res["access_token"];
		//$token_type=$res["token_type"];
		//$expires_in=$res["expires_in"];
		$tr_upd_order1['step_1']="ACCESS_TOKEN_DONE";
		//$tr_upd_order1['access_token']=@$access_token;

		////////////////STEP-2 :: Generate payment Intent Id///////////////////

        $requestPost_2_arr=[
			"paymentIntentId" => "",
			"merchantId" => "$merchantID",
			"profileId" => "$profileID",
			"merchantRef" => "$merchantRef"
		];

        //"https://pg-api.transactionjunction.com/prod/ipgw/gateway/v1/payment-intents"

		$curl = curl_init();

		curl_setopt_array($curl, [
		CURLOPT_URL => $bank_url."/payment-intents",
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_HEADER => 0,
            CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_SSL_VERIFYHOST => 0,
		CURLOPT_POSTFIELDS => json_encode(@$requestPost_2_arr),
		CURLOPT_HTTPHEADER => [
			"Accept: application/json",
			"Authorization: Bearer $access_token",
			"Content-Type: application/json"
		],
		]);
		
		$response = curl_exec($curl);
		$err = curl_error($curl);
		
		curl_close($curl);
		
		if ($err) {
		echo "cURL Error 2 #:" . $err;
		} 
		
		
		$resintent = json_decode($response,1);
		if(isset($resintent['paymentIntentId'])&&$resintent['paymentIntentId']){
		$paymentIntentId=$resintent['paymentIntentId'];
		$merchantRef=$resintent['merchantRef'];

        $tr_upd_order1['step_2_url']=$bank_url."/payment-intents";
		$tr_upd_order1['requestPost_2']=@$requestPost_2_arr;
        $tr_upd_order1['response_2']=(isset($resintent)&&is_array($resintent)?htmlTagsInArray($resintent):stf($response));



		////////////////STEP-3 :: Generate payment Intent Id///////////////////

        $requestPost_3_arr='{
            "redirectSuccessUrl": "'.$redirectSuccessUrl.'",
            "redirectFailedUrl": "'.$redirectFailedUrl.'",
            "redirectCancelUrl": "'.$redirectCancelUrl.'",
            "transaction": {
                "paymentIntentId": "'.$paymentIntentId.'",
                "amount": '.$total_payment.',
                "currency": "'.@$orderCurrency.'",
                "cartItems": [
                    {
                        "quantity": 1,
                        "ref": "Order Request - '.@$transID.'",
                        "description": "'.$_SESSION['product'].'",
                        "amount": '.$total_payment.'
                    }
                ],
                "merchantId": "'.$merchantID.'",
                "profileId": "'.$profileID.'",
                "merchantRef": "'.$merchantRef.'"
            }
        }';
        

        /*
        $requestPost_4_arr=[
			'redirectSuccessUrl' => $redirectSuccessUrl,
			'redirectFailedUrl' => $redirectFailedUrl,
			'redirectCancelUrl' => $redirectCancelUrl,
			'paymentMethod' => 'ALL',
			'metaData' => [
				'key' => 'value',
				'key2' => 'value2'
			],
			'transaction' => [
				'paymentMethods' => [
					'ALL'
				],
				'paymentIntentId' => $paymentIntentId,
				'amount' => @$total_payment,
				'customerProfileId' => '',
				'shippingAddress' => [
					'addressLine1' => @$post['bill_address'],
					'addressLine2' => @$post['bill_address'],
					'city' => @$post['bill_city'],
					'province' => @$post['state_two'],
					'postalCode' => @$post['bill_zip'],
					'country' => @$post['country_two']
				],
				'billingAddress' => [
					'addressLine1' => @$post['bill_address'],
					'addressLine2' => @$post['bill_address'],
					'city' => @$post['bill_city'],
					'province' => @$post['state_two'],
					'postalCode' => @$post['bill_zip'],
					'country' => @$post['country_two']
				],
				'cartItems' => [
					[
						'quantity' => 1,
						'ref' => 'Order Request - '.@$transID,
						'description' => $_SESSION['product'],
						'amount' => @$total_payment
					]
				],
				'aggregator' => [
					[
                        'paymentFacilitatorID' => @$paymentFacilitatorID,
                        'independentSalesOrganizationID' => @$independentSalesOrganizationID,
                        'subMerchantID' => @$subMerchantID,
                        'billingDescriptor' => @$billingDescriptor,
                        'merchantVerificationValue' => @$merchantVerificationValue
                    ]
				],
				'storeDetails' => [
					[
						'name' => @$dba,
						'city' => @$post['bill_city'],
						'region' => @$post['state_two'],
						'country' => @$post['country_two'],
						'postalCode' => @$post['bill_zip'],
						'streetAddress' => @$post['bill_address'],
						'customerServicePhoneNumber' => @$post['bill_phone']
					]
				],
                
				'flightDetails' => [
					'hasAirlineDetails' => null,
					'passengerName' => 'John',
					'primaryTicketNumber' => 'string',
					'firstDepartureLocationCode' => 'string',
					'firstArrivalLocationCode' => 'string',
					'pnrNumber' => 'string',
					'officeIataNumber' => 'string',
					'orderNumber' => 'string',
					'placeOfIssue' => 'string',
					'departureDate' => 'string',
					'departureTime' => 'string',
					'completeRoute' => 'string',
					'journeyType' => 'string'
				],
				'merchantId' => $merchantID,
				'profileId' => $profileID,
				'merchantRef' => $merchantRef,
				'mcc' => $mcc,
				'terminalId' => @$terminalId,
				'incrementalAuth' => null,
				'motoFlag' => 1
			]
		];
        */


        // "https://pg-api.transactionjunction.com/prod/ipgw/gateway/v1/sessions" 

		$curl = curl_init();
	
		curl_setopt_array($curl, [
		CURLOPT_URL => $bank_url."/sessions",
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_HEADER => 0,
            CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_SSL_VERIFYHOST => 0,
            
		CURLOPT_POSTFIELDS => @$requestPost_3_arr,
			CURLOPT_HTTPHEADER => [
			"Accept: application/json",
			"Authorization: Bearer $access_token",
			"Content-Type: application/json"
			],
		]);
		
		$response = curl_exec($curl);
		$err = curl_error($curl);
		
		curl_close($curl);
		
		if ($err) {
			echo "cURL Error 3 #:" . $err;
		} else {
			//echo $response;
		}
		
		
		$datas = json_decode($response,1);


        

        $tr_upd_order1['step_3_url']=$bank_url."/sessions";
		$tr_upd_order1['requestPost_3']=json_decode(@$requestPost_3_arr,1);
        $tr_upd_order1['response_3']=(isset($datas)&&is_array($datas)?htmlTagsInArray($datas):stf($response));


		$redirectUrl=$datas['redirectUrl'];

        
		
            if(isset($redirectUrl)&&$redirectUrl)
            {

                $_SESSION['3ds2_auth']['paytitle']=@$dba;
                $_SESSION['3ds2_auth']['payamt']=@$total_payment;
                $_SESSION['3ds2_auth']['paycurrency']=@$orderCurrency;
                $_SESSION['3ds2_auth']['urltype']='urlencode';
                if(isset($post['bill_amt'])&&trim($post['bill_amt'])) $_SESSION['3ds2_auth']['bill_amt']=@$post['bill_amt'];
                if(isset($post['bill_currency'])&&trim($post['bill_currency'])) $_SESSION['3ds2_auth']['bill_currency']=@$post['bill_currency'];
                if(isset($post['product_name'])&&trim($post['product_name'])) $_SESSION['3ds2_auth']['product_name']=@$post['product_name'];
                if(isset($post['integration-type'])&&trim($post['integration-type'])) $_SESSION['3ds2_auth']['integration-type']=@$post['integration-type'];
                

                //echo "<script>top.window.location.href='{$redirectUrl}';</script>";
                
                $auth_3ds2_secure=@$_SESSION['3ds2_auth']['payaddress']=$payment_url=curl_url_replace_f($redirectUrl); // Retrieve the redirect URL
                $auth_3ds2_action='redirect'; //  redirect  post_redirect  
                $auth_3ds2=$secure_process_3d; 
            
                $tr_upd_order1['auth_3ds2_secure']=@$auth_3ds2_secure;
                $tr_upd_order1['auth_3ds2_action']=@$auth_3ds2_action;
        
            } 
            else{
                
                //failed from end
                $_SESSION['acquirer_action']=1;
                //$_SESSION['acquirer_status_code']=-1;
                $_SESSION['acquirer_status_code']=23;
            
                if(isset($_SESSION['acquirer_response'])&&!empty($_SESSION['acquirer_response']))
                db_trf($_SESSION['tr_newid'], 'trans_response', @$_SESSION['acquirer_response']);
            
                $tr_upd_order1['FAILED']=@$_SESSION['acquirer_response'];
                $process_url = $status_url_1; 
                //$json_arr_set['check_acquirer_status_in_realtime']='f';
                //$json_arr_set['realtime_response_url']=$status_url_1;
                
                $json_arr_set['realtime_response_url']=$trans_processing;
        
            }
        
            $tr_upd_order1=(isset($tr_upd_order1)&&is_array($tr_upd_order1)?htmlTagsInArray($tr_upd_order1):stf($tr_upd_order1));
        
            db_trf($_SESSION['tr_newid'], 'acquirer_response_stage1', $tr_upd_order1);
        
            //trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
        
            if($data['cqp']==9) 
            {
                echo "<br/><hr/><br/>curl_bank_url_3=><br/>"; print_r(@$curl_bank_url_3);
                echo "<br/><br/>auth_3ds2_secure=> "; print_r(@$auth_3ds2_secure);
                echo "<br/><br/>response_3=><br/>"; print_r(@$response);
        
                echo "<br/><br/>tr_upd_order1=><br/>"; print_r(@$tr_upd_order1);
                exit;
            }

		}
	}


    $tr_upd_order1=(isset($tr_upd_order1)&&is_array($tr_upd_order1)?htmlTagsInArray($tr_upd_order1):stf($tr_upd_order1));
	$tr_upd_order_111=$tr_upd_order1;


?>