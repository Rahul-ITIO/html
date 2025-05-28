<?
//status 112 from 108 for lipad
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

/*
if(isset($_REQUEST['merchant_transaction_id'])){
    $_REQUEST['transID']=preg_replace("/[^0-9.]/", "",@$_REQUEST['merchant_transaction_id']);
}
*/

$is_curl_on = true;

if(!isset($data['STATUS_ROOT'])){
    
	include($root.'config_db.do');

	//Webhook 
    if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook') 
	{
		//for callback
		// https://dev.charge.lipad.io/v1/cards/undefined?external_reference=11220708&charge_request_id=1751&payment_status=703 
		
		$str=file_get_contents("php://input");
		$responseParamList = json_decode($str,true);
		
		//$data['logs']['php_input_0']=$str;
		$data['gateway_push_notify']=$responseParamList;	
		
		if(isset($responseParamList['external_reference'])&&$responseParamList['external_reference'])
		{
			$_REQUEST['transID'] = $responseParamList['external_reference'];
            if(isset($responseParamList['payment_status'])&&$responseParamList['payment_status'])
            $is_curl_on = false;
		}
        
		/*

		{
            "event": "pending_payment",
            "client_code": "COGMER-5WXOBTC",
            "service_code": "COGCHE197",
                "external_reference": "112118405054",
            "transaction_id": "2804993",
            "charge_request_id": "22535",
            "payment_method_code": "CARD",
            "payer_transaction_id": "12589297185869824",
            "payment_status": 703,
            "country_code": "KEN",
            "currency_code": "USD",
            "receiver_narration": null,
            "payer_msisdn": "9815061456",
            "account_number": "N/A",
            "payment_account_reference": "9d885529c4384dceb8660942c2f1eff9",
            "amount": "2.00",
            "payer_narration": "Payment by 9815061456",
            "extra_data": {
                "failed_redirect_url": "https://prod-gate.i15.me/payin/pay112/status_112_v2?transID=112118405054",
                "success_redirect_url": "https://prod-gate.i15.me/payin/pay112/status_112_v2?transID=112118405054"
            },
            "payment_date": "2025-01-17T05:50:17.752Z"
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


 // $charge_request_id=jsonvaluef($jsn,'charge_request_id');
 
if(!empty($transID))
{	
	if($is_curl_on==true&&isset($acquirer_ref)&&trim($acquirer_ref))
	{
		//get bank url from bank getway table
		if(@$bank_acquirer_json_arr){
			$bank_status_url=@$bank_acquirer_json_arr['bank_status_url'];
			if(@$bank_status_url) $bank_status_url=$bank_status_url;
			else $bank_status_url='https://checkout-api.lipad.io/payin/v1/checkout/request/status'; 
		}
		
		if(@$qp)echo "<br/><hr/><br/>bank_status_url=>".@$bank_status_url;
		
		
		
		##################################################################################

		if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://api.lipad.io/v1/auth";

		##################################################################################


		//tokenUrl
        //https://api.lipad.io/v1/auth
		$tokenUrl = $acquirer_status_url.'/auth';
		 
		$consumerKey  	=@$apc_get['ConsumerKey'];

		//Hard code passing the previous consumer key for token only via access token
		//$consumerKey  	='9nUfLzIwMCmF0kk4zZCOi8MGSWTFC1'; 
		
		$consumerSecret	=@$apc_get['ConsumerSecret'];

		//for v2 s2s status
		if(empty($consumerSecret)&&isset($apc_get['ConsumerSecret'])){
			$consumerSecret	=@$apc_get['ConsumerSecret'];
		}

		$keys='{"consumer_key":"'.$consumerKey.'","consumer_secret": "'.$consumerSecret.'"}';


        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => $tokenUrl,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
                CURLOPT_HEADER => 0,
                CURLOPT_SSL_VERIFYPEER => 0,
                CURLOPT_SSL_VERIFYHOST => 0,
            CURLOPT_POSTFIELDS => @$keys,
            CURLOPT_HTTPHEADER => array(
                'Content-Type: application/json'
            ),
        ));

        $response = curl_exec($curl);

		$resToken = json_decode($response,1);
		//print_r($resToken);
		//exit;
		$token=$resToken['access_token'];
		 


		if($token){//if you got token proceed for next step
			
			
            //https://api.lipad.io/v1/transaction/22406/status
			$acquirer_status_url=$acquirer_status_url.'/transaction/'.@$acquirer_ref.'/status';
			

                        
            $curl = curl_init();

            curl_setopt_array($curl, array(
                CURLOPT_URL => $acquirer_status_url,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => '',
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => 'GET',
                    CURLOPT_HEADER => 0,
                    CURLOPT_SSL_VERIFYPEER => 0,
                    CURLOPT_SSL_VERIFYHOST => 0,
                CURLOPT_HTTPHEADER => array(
                    'x-access-token: '.@$token
                ),
            ));

            $response = curl_exec($curl);


			//echo $response;
			$responseParamList = json_decode($response,1);

            /*

                {
                    "event": "payment_status",
                    "client_code": "COGMER-5WXOBTC",
                    "service_code": "COGCHE197",
                        "external_reference": "1121106195306", //transID
                    "transaction_id": "2798495",
                        "charge_request_id": "22406", //ar = acquirer_ref
                    "payment_method_code": "CARD",
                        "payer_transaction_id": "12569959787679744", // vpa
                            "payment_status": 701, // status
                    "country_code": "KEN",
                    "currency_code": "USD",
                    "receiver_narration": "Secure 3D information is invalid.",
                    "payer_msisdn": "9815105821",
                    "account_number": "N/A",
                    "amount": "12.75",
                    "payer_narration": "Payment by 9815105821",
                    "extra_data": {
                        "failed_redirect_url": "https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard",
                        "success_redirect_url": "https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard"
                    },
                    "payment_date": "2025-01-15T12:33:43.460Z"
                }

            */


		}
	}



	if(@$qp)
	{ // status - Green
		echo '<div type="button" class="btn btn-success my-2" style="word-wrap:break-word;background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		echo "<hr/><h3>STATUS RESPONSE :: {$transID}</h3>";
		
		echo "<br/><b>tokenUrl</b>=>".$tokenUrl;
		echo "<br/>keys=>".$keys;
		echo "<br/>token=>".($token?$token:$response);
		
		echo "<br/><br/><hr/><br/><b>acquirer_status_url</b>=>".$acquirer_status_url;
		echo "<br/>acquirer status ['payment_status']=> ".@$responseParamList['payment_status'];
		if(isset($responseParamList['event_history'])&&@$responseParamList['event_history']) echo "<br/>event_history count=> ".count(@$responseParamList['event_history']);
		echo "<br/>acquirer message ['receiver_narration']=> ".@$responseParamList['receiver_narration'];

        echo "<br/><br/>acquirer ref ['charge_request_id']=> ".@$responseParamList['charge_request_id'];
        echo "<br/>rrn ['transaction_id']=> ".@$responseParamList['transaction_id'];
        echo "<br/>vpa ['payer_transaction_id']=> ".@$responseParamList['payer_transaction_id'];

		echo "<br/><br/>response=> ".@$response;
		
		echo '<br/><br/></div>';
	}

  


	$results = $responseParamList;

	//applied condition according to the status response for fail success and pending 
	if (isset($responseParamList) && count($responseParamList)>0)
	{

		//here is two conditio for status overall payment satus and eventhostory

		$status=0;
		$count_loop=0;
		$count_msg=0; $message='';

		if(isset($responseParamList['event_history'])&&$responseParamList['event_history']){
			$count_loop=$count_msg=count(@$responseParamList['event_history']);
		}

		

		if(@$qp)
		{
			echo "<br/>count_loop=> ".@$count_loop;
		}


		

        if(isset($responseParamList['payment_status'])&&$responseParamList['payment_status'])
            $status= @$responseParamList['payment_status'];

        if(isset($responseParamList['receiver_narration'])&&$responseParamList['receiver_narration'])
			$message	= @$responseParamList['receiver_narration'];

        
        if(isset($responseParamList['amount'])&&$responseParamList['amount'])
            $_SESSION['responseAmount']= $responseParamList['amount'];
        
        elseif(isset($responseParamList['request_amount'])&&$responseParamList['request_amount'])
         $_SESSION['responseAmount']= @$responseParamList['request_amount'];
        
        
		/*
		//multiple response in array 
		$eventHistory = @$responseParamList;

		if (isset($eventHistory) && is_array($eventHistory) && isset($eventHistory['event_history']) && is_array($eventHistory['event_history'])) 
		{
			$lastEvent = end($eventHistory['event_history']);
			
			$status=@$lastEvent['payment_status'];
			$message=@$lastEvent['receiver_narration'];
			$_SESSION['responseAmount']=@$lastEvent['amount'];
		}

        */

		if($qp){
			echo "<br/><br/><=status=>".@$status;
			echo "<br/><br/><=message=>".@$message;
			echo "<br/><br/><=responseAmount=>".@$_SESSION['responseAmount'];
		}



		
        //upa //rrn //acquirer_ref
        #######	upa, rrn, acquirer_ref update from status get :start 	###############
            
            //acquirer_ref_2	
           
            $acquirer_ref_2='';
            if(@$responseParamList['charge_request_id']) $acquirer_ref_2= @$responseParamList['charge_request_id'];
            //up acquirer_ref_2 : update if empty acquirer_ref and is txnId 
            if((empty(trim($td['acquirer_ref']))||$td['acquirer_ref']=='{}')&&!empty($acquirer_ref_2)){
                $tr_upd_status['acquirer_ref']=trim($acquirer_ref_2);
            }
           
          
            //upa =>merchantId,merchantId
            $upa='';
            if(isset($responseParamList['payer_transaction_id'])&&@$responseParamList['payer_transaction_id']) $upa= @$responseParamList['payer_transaction_id'];	
            	
            //up upa : update if empty upa and is merchantId 
            if(empty(trim($td['upa']))&&!empty($upa)){
                $tr_upd_status['upa']=trim($upa);
            }
                 
            
            //rrn 
            $rrn='';
            if(isset($responseParamList['transaction_id'])&&@$responseParamList['transaction_id']) $rrn= @$responseParamList['transaction_id'];		
            
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



		$_SESSION['acquirer_action']="lipadv2";
		$_SESSION['acquirer_response']=@$message;
		
	if($status)
		{
		
			if($status==700){ //apply condition for success

				$_SESSION['acquirer_response']="Success";
				$_SESSION['acquirer_status_code']=2;
			}
            /*
			elseif($status==701){	//Apply condition for failed
				$_SESSION['acquirer_response']=@$message." - Cancelled";
				//$_SESSION['acquirer_status_code']=-1;
				$_SESSION['acquirer_status_code']=23;
			}
            */
			elseif($status==701){	//Apply condition for failed
				$_SESSION['acquirer_response']=@$message." - Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
            
			elseif($status==820){//Apply condition for Expired,will get overall payment status
				$_SESSION['acquirer_response']=@$message." - Expired";
				$_SESSION['acquirer_status_code']=22;
			}
			else{ //pending

				$_SESSION['acquirer_response']=@$message." - Pending";
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