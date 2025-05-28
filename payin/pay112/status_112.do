<?
//status 112 from 108 for lipad
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

if(isset($_REQUEST['merchant_transaction_id'])){
    $_REQUEST['transID']=preg_replace("/[^0-9.]/", "",@$_REQUEST['merchant_transaction_id']);
}


$is_curl_on = true;

if(!isset($data['STATUS_ROOT'])){
    
	include($root.'config_db.do');

	//Webhook 
    if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook') 
	{
		//for callback
		// https://dev.charge.lipad.io/v1/cards/undefined?external_reference=11220708&charge_request_id=1751&payment_status=703 
		
		$str=file_get_contents("php://input");
		$res = json_decode($str,true);
		
		$data['logs']['php_input_0']=$str;
		$data['gateway_push_notify']=$res;	
		
		$trnId=$res['merchant_transaction_id'];
		if(isset($res['merchant_transaction_id'])&&$res['merchant_transaction_id'])
		{
			//$is_curl_on = false;
			$_REQUEST['transID'] = $res['merchant_transaction_id'];
		}
		elseif(isset($res['external_reference'])&&$res['external_reference'])
		{
			//$is_curl_on = false;
			$_REQUEST['transID'] = $res['external_reference'];
		}

		/*

		{
			"event": "unpaid",
			"checkout_request_id": "14103",
			"merchant_transaction_id": "11216086010",
			"request_amount": "12.02",
			"amount_paid": "0",
			"outstanding_amount": 12.02,
			"currency_code": "USD",
			"country_code": "KEN",
			"service_code": "CHECKOUT",
			"account_number": "N/A",
			"invoice_number": null,
			"overall_payment_status": 803,
			"overall_payment_description": "unpaid",
			"request_description": "Test Product",
			"event_history": [
				{
					"event": "failed_payment",
					"amount": "12.02",
					"extra_data": {
						"payload": "CHECKOUT"
					},
					"client_code": "COGMER-5WXOBTC",
					"country_code": "KEN",
					"payer_msisdn": "9804143014",
					"payment_date": "2024-09-04T09:05:47.411Z",
					"service_code": "COGCHE189",
					"currency_code": "USD",
					"account_number": "N/A",
					"payment_status": 701,
					"transaction_id": "2244142",
					"payer_narration": "9804143014",
					"charge_request_id": "12220",
					"external_reference": "11216086010",
					"receiver_narration": "Card charge declined",
					"payment_method_code": "CARD",
					"payer_transaction_id": "11062153734000640",
					"payment_account_reference": "CK81YKBHO"
				}
			],
			"event_record": {
				"event": "failed_payment",
				"client_code": "COGMER-5WXOBTC",
				"service_code": "COGCHE189",
				"external_reference": "11216086010",
				"transaction_id": "2244142",
				"charge_request_id": "12220",
				"payment_method_code": "CARD",
				"payer_transaction_id": "11062153734000640",
				"payment_status": 701,
				"country_code": "KEN",
				"currency_code": "USD",
				"receiver_narration": "Card charge declined",
				"payer_msisdn": "9804143014",
				"account_number": "N/A",
				"payment_account_reference": "CK81YKBHO",
				"amount": "12.02",
				"payer_narration": "9804143014",
				"extra_data": {
					"payload": "CHECKOUT"
				},
				"payment_date": "2024-09-04T09:05:47.411Z"
			}
		}

		*/

	}

	//include($data['Path'].'/payin/res_insert'.$data['iex']);
	include($data['Path'].'/payin/status_top'.$data['iex']);
}


//include($data['Path'].'/payin/status_in_email'.$data['iex']);



$siteid_get['ConsumerKey']	= (isset($json_value['ConsumerKey'])?$json_value['ConsumerKey']:''); //consumer Key provided by lipad
$siteid_get['ConsumerSecret']	= (isset($json_value['ConsumerSecret'])?$json_value['ConsumerSecret']:'');//ConsumerSecrete provided by lipda
$siteid_get['merchant_transaction_id']	= (isset($json_value['merchant_transaction_id'])?$json_value['merchant_transaction_id']:'');//
 //print_r($siteid_get);
 //exit;


  $charge_request_id=jsonvaluef($jsn,'charge_request_id');
 
if(!empty($transID))
{	
	if($is_curl_on==true)
	{
		//get bank url from bank getway table
		if(@$bank_acquirer_json_arr){
			$bank_status_url=@$bank_acquirer_json_arr['bank_status_url'];
			if(@$bank_status_url) $bank_status_url=$bank_status_url;
			else $bank_status_url='https://checkout-api.lipad.io/payin/v1/checkout/request/status'; 
		}
		
		if(@$qp)echo "<br/><hr/><br/>bank_status_url=>".@$bank_status_url;
		
		
		
		##################################################################################

		if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://checkout.api.lipad.io/api/v1/checkout/request/status";

		##################################################################################


		//tokenUrl
		$tokenUrl = "https://checkout.api.lipad.io/api/v1/api-auth/access-token";
		 
		$consumerKey  	=@$apc_get['ClientCode'];

		//Hard code passing the previous consumer key for token only via access token
		$consumerKey  	='9nUfLzIwMCmF0kk4zZCOi8MGSWTFC1'; 
		
		$consumerSecret	=@$apc_get['SecretKey'];

		//for v2 s2s status
		if(empty($consumerSecret)&&isset($apc_get['ConsumerSecret'])){
			$consumerSecret	=@$apc_get['ConsumerSecret'];
		}

		$keys='{"consumerKey":"'.$consumerKey.'","consumerSecret": "'.$consumerSecret.'"}';

		$curl = curl_init();

		curl_setopt_array($curl, array(
		  CURLOPT_URL => $tokenUrl,
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_ENCODING => '',
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 30,
		  CURLOPT_FOLLOWLOCATION => true,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => 'POST',
		  CURLOPT_POSTFIELDS => $keys,
		  CURLOPT_HTTPHEADER => array(
			'Content-Type: application/json'
		  ),
		));

		$response = curl_exec($curl);

		curl_close($curl);
		//echo $response;
		//exit;
		$resToken = json_decode($response,1);
		//print_r($resToken);
		//exit;
		$token=$resToken['access_token'];
		 


		if($token){//if you got token proceed for next step
			
			//https://checkout.api.lipad.io/api/v1/checkout/request/status?merchant_transaction_id=11216086010 
			//$acquirer_status_url="https://checkout.api.lipad.io/api/v1/checkout/request/status?merchant_transaction_id=".$transID;

			$acquirer_status_url=$acquirer_status_url.'?merchant_transaction_id='.$transID;
			
			$curl = curl_init();

			curl_setopt_array($curl, array(
			  CURLOPT_URL =>$acquirer_status_url,
			  CURLOPT_RETURNTRANSFER => true,
			  CURLOPT_ENCODING => '',
			  CURLOPT_MAXREDIRS => 10,
			  CURLOPT_TIMEOUT => 30,
			  CURLOPT_FOLLOWLOCATION => true,
			  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			  CURLOPT_CUSTOMREQUEST => 'GET',
			  CURLOPT_HTTPHEADER => array(
				"Authorization: Bearer ".@$token
			 ),
			));

			$response = curl_exec($curl);

			curl_close($curl);
			//echo $response;
			$res = json_decode($response,1);

		}
	}



	if(@$qp)
	{ // status - Green
		echo '<div type="button" class="btn btn-success my-2" style="word-wrap:break-word;background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		echo "<hr/><h3>STATUS RESPONSE</h3>";
		
		echo "<br/>tokenUrl=>".$tokenUrl;
		echo "<br/>keys=>".$keys;
		echo "<br/>token=>".($token?$token:$response);
		
		echo "<br/><br/>acquirer_status_url=>".$acquirer_status_url;
		echo "<br/>acquirer status ['event_history'][0]['payment_status']=> ".@$res['event_history'][0]['payment_status'];
		echo "<br/>else acquirer status=> ".@$res['payment_status'];
		if(isset($res['event_history'])&&@$res['event_history']) echo "<br/>event_history count=> ".count(@$res['event_history']);
		echo "<br/>acquirer message ['event_history'][0]['receiver_narration']=> ".@$res['event_history'][0]['receiver_narration'];
		echo "<br/>response=> ".@$response;
		
		echo '<br/><br/></div>';
	}

  


	$results = $res;

	//applied condition according to the status response for fail success and pending 
	if (isset($res) && count($res)>0)
	{

		//here is two conditio for status overall payment satus and eventhostory

		$status=0;
		$count_loop=0;
		$count_msg=0; $message='';

		if(isset($res['event_history'])&&$res['event_history']){
			$count_loop=$count_msg=count(@$res['event_history']);
		}

		

		if(@$qp)
		{
			echo "<br/>count_loop=> ".@$count_loop;
		}


		
		/*
		   if(isset($res['event_history'][$count_loop]['payment_status'])&&$res['event_history'][$count_loop]['payment_status'])
		   $status = $res['event_history'][$count_loop]['payment_status'];//exact status of payment

		
		   elseif(isset($res['event_history'][1]['payment_status'])&&$res['event_history'][1]['payment_status'])
		   $status = $res['event_history'][1]['payment_status'];//exact status of payment
		   elseif(isset($res['event_history'][0]['payment_status'])&&$res['event_history'][0]['payment_status'])
		   $status = $res['event_history'][0]['payment_status'];//exact status of payment
		   
		   elseif(isset($res['payment_status'])&&$res['payment_status'])
		   $status= $res['payment_status'];
		
		  */

		/*

		   if(isset($res['event_history'][$count_loop]['amount'])&&$res['event_history'][$count_loop]['amount'])
		   	$_SESSION['responseAmount']= $res['event_history'][$count_loop]['amount'];
		   
		   elseif(isset($res['request_amount'])&&$res['request_amount'])
		   	$_SESSION['responseAmount']= @$res['request_amount'];
		   
		*/
			  


		

		/*
		if(isset($res['event_history'][$count_msg]['receiver_narration'])&&$res['event_history'][$count_msg]['receiver_narration']){
			$message	= @$res['event_history'][$count_msg]['receiver_narration'];
		}
		
		elseif(isset($res['event_history'][0]['receiver_narration'])&&$res['event_history'][0]['receiver_narration']){
			$message	= @$res['event_history'][0]['receiver_narration'];
		}
			
		elseif(@$res['receiver_narration']){
			$message	= @$res['receiver_narration'];
		}elseif(isset($res['overall_payment_description'])&&$res['overall_payment_description']) {
			$message	= $res['overall_payment_description'];
		}
		*/

		
		//Dev Tech : 24-10-22 End of array value for payment_status, receiver_narration and amount 
		$eventHistory = @$res;

		if (isset($eventHistory) && is_array($eventHistory) && isset($eventHistory['event_history']) && is_array($eventHistory['event_history'])) 
		{
			$lastEvent = end($eventHistory['event_history']);
			
			$status=@$lastEvent['payment_status'];
			$message=@$lastEvent['receiver_narration'];
			$_SESSION['responseAmount']=@$lastEvent['amount'];
		}

		if($qp){
			echo "<br/><br/><=status=>".@$status;
			echo "<br/><br/><=message=>".@$message;
			echo "<br/><br/><=responseAmount=>".@$_SESSION['responseAmount'];
		}



		
        //upa //rrn //acquirer_ref
        #######	upa, rrn, acquirer_ref update from status get :start 	###############
            
            //acquirer_ref_2	
           
            $acquirer_ref_2='';
            if(@$lastEvent['transaction_id']) $acquirer_ref_2= @$lastEvent['transaction_id'];
            //up acquirer_ref_2 : update if empty acquirer_ref and is txnId 
            if((empty(trim($td['acquirer_ref']))||$td['acquirer_ref']=='{}')&&!empty($acquirer_ref_2)){
                $tr_upd_status['acquirer_ref']=trim($acquirer_ref_2);
            }
           
           /*
            //upa =>merchantId,merchantId
            $upa='';
            if(isset($responseParamList['merchantId'])&&@$responseParamList['merchantId']) $upa= @$responseParamList['merchantId'];	
            	
            //up upa : update if empty upa and is merchantId 
            if(empty(trim($td['upa']))&&!empty($upa)){
                $tr_upd_status['upa']=trim($upa);
            }
              */      
            
            //rrn 
            $rrn='';
            if(isset($lastEvent['payer_msisdn'])&&@$lastEvent['payer_msisdn']) $rrn= @$lastEvent['payer_msisdn'];		
            
            //up rrn : update if empty rrn and is RRN 
            if(empty(trim($td['rrn']))&&!empty($rrn)){
                $tr_upd_status['rrn']=trim($rrn);
            }
            
            
            if(@$qp){
                echo "<br/><br/><=upa=>".@$upa;
                echo "<br/><br/><=acquirer_ref=>".@$acquirer_ref;
                echo "<br/><br/><=rrn=>".@$rrn;
                echo "<br/><br/><=tr_upd_status1=>";
                    print_r(@$tr_upd_status);
            }
            
            if(isset($tr_upd_status)&&count($tr_upd_status)>0&&is_array($tr_upd_status))
            {
                if($qp){
                    echo "<br/><br/><=tr_upd_status=>";
                    print_r($tr_upd_status);
                }
                
                trans_updatesf($td['id'], $tr_upd_status);
            }
            
        #######	upa, rrn, acquirer_ref update from status get :end 	###############









		$_SESSION['acquirer_action']="lipad";
		$_SESSION['acquirer_response']=@$message;
		
	if($status)
		{
		
			if($status==700){ //apply condition for success

				$_SESSION['acquirer_response']="Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif($status==701){	//Apply condition for failed
				$_SESSION['acquirer_response']=@$message." - Cancelled";
				//$_SESSION['acquirer_status_code']=-1;
				$_SESSION['acquirer_status_code']=23;
			}
			elseif($status==820){//Apply condition for Expired,will get overall payment status
				$_SESSION['acquirer_response']=@$message." - Expired";
				$_SESSION['acquirer_status_code']=22;
			}
			else{ //pending

				$_SESSION['acquirer_response']=@$message." - Pending";
				$status_completed=false;
				$_SESSION['acquirer_status_code']=1;
			}
		}
	}
	
}

#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>