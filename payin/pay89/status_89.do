<?
//status 89 WzardPay
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';



$is_curl_on = true;
if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	
if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook') 
    {
        //for callback
       
        
        $str=file_get_contents("php://input");
        $res = json_decode($str,true);
        
        $data['logs']['php_input_0']=$str;
        $data['gateway_push_notify']=$res;  
        
        $trnId=$res['data']['attributes']['reference_id'];
        if(isset($res['data']['attributes']['reference_id'])&&$$res['data']['attributes']['reference_id'])
        {
            //$is_curl_on = false;
            $_REQUEST['transID'] = $res['data']['attributes']['reference_id'];
        }
        elseif(isset($res['data']['attributes']['rrn'])&&$res['data']['attributes']['rrn'])
        {
            //$is_curl_on = false;
            $_REQUEST['transID'] = $res['data']['attributes']['rrn'];
        }

        /*

       {
    "data": {
        "type": "payment-invoices",
        "id": "cpi_zGmR6BYegfcNmFet",
        "attributes": {
            "status": "processed",
            "resolution": "ok",
            "moderation_required": false,
            "amount": 2,
            "payment_amount": 2,
            "currency": "EUR",
            "service_amount": 2,
            "payment_service_amount": 2,
            "exchange_rate": 1,
            "service_currency": "EUR",
            "reference_id": "891197020",
            "test_mode": true,
            "fee": 0,
            "deposit": 2,
            "processed": 1730721038,
            "processed_amount": 2,
            "refunded_amount": null,
            "refunded_fee": null,
            "refunded": null,
            "processed_fee": 0,
            "processed_deposit": 2,
            "failed": null,
            "metadata": {
                "key": "value"
            },
            "flow_data": {
                "action": "https:\/\/checkout.wzrdpay.io\/hpp\/cgi_0yCF8hj3mF9FkVWh",
                "method": "GET",
                "params": [],
                "metadata": {
                    "sid": "cgi_0yCF8hj3mF9FkVWh",
                    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzaWQiOiJjZ2lfMHlDRjhoajNtRjlGa1ZXaCIsImV4cGlyZXMiOm51bGwsImV4cCI6MTczMDcyNDYyMX0.td2V9ragVFmEN0bXlQ7zIPr61mKwbavmIQ63pvEnJbY"
                }
            },
            "flow": "hpp",
            "payment_flow": "charge",
            "created": 1730721021,
            "updated": 1730721038,
            "payload": {
                "token": null,
                "auth_type": "card",
                "client_ip": "223.236.192.243",
                "payment_card": {
                    "last": "0000",
                    "mask": "512381******0000",
                    "type": "CREDIT",
                    "brand": null,
                    "first": "512381",
                    "holder": "Deepti",
                    "card_id": "card_hbhO0Z0NfRMvUYcZ",
                    "network": "MASTERCARD",
                    "expiry_year": "31",
                    "issuer_name": "FIRST DATA CORPORATION",
                    "expiry_month": "10",
                    "verification": [
                        {
                            "type": "3ds",
                            "details": {
                                "eci": "08",
                                "version": "1"
                            }
                        }
                    ],
                    "issuer_country": "US"
                }
            },
            "description": "Invoice Example",
            "descriptor": null,
            "callback_url": "https:\/\/webhook.site\/a836ae47-7645-4e9f-b920-516e3cf0049b",
            "return_url": "https:\/\/aws-cc-uat.web1.one\/trans_processing?transID=891197020&action=status",
            "return_urls": {
                "fail": "https:\/\/aws-cc-uat.web1.one\/payin\/pay89\/fail_url_89?transID=891197020",
                "pending": "https:\/\/aws-cc-uat.web1.one\/trans_processing?transID=891197020&action=status",
                "success": "https:\/\/aws-cc-uat.web1.one\/payin\/pay89\/success_url_89?transID=891197020"
            },
            "original_data": {
                "original_resolution": "ok",
                "original_resolution_message": null
            },
            "rrn": "94302965",
            "arn": "40275700",
            "approval_code": null,
            "reserved_amount": null,
            "reserve_expires": null,
            "unreserved": null,
            "source": "merchant_api",
            "callback_logs": [],
            "charged_back_amount": null,
            "charged_back": null,
            "resolution_message": null,
            "hpp_url": "https:\/\/pay.wzrdpay.io\/redirect\/hpp\/?cpi=cpi_zGmR6BYegfcNmFet",
            "refunds": [],
            "reserves": [],
            "reserve_options": null,
            "processed_unreserve": null,
            "processed_reserve_cancel": null,
            "reserve_cancelled": null
        },
        "relationships": {
            "payment-service": {
                "data": {
                    "type": "payment-services",
                    "id": "payment_card_eur_hpp"
                }
            },
            "payment-method": {
                "data": {
                    "type": "payment-methods",
                    "id": "payment_card"
                }
            },
            "customer": {
                "data": {
                    "type": "customers",
                    "id": "cus_hC9sA9GfY5uwqn9t"
                }
            },
            "active-payment": {
                "data": {
                    "type": "payments",
                    "id": "pay_QKdDOvUMMkPF0hFwAyD4XepF"
                }
            }
        },
        "links": {
            "self": "\/api\/payment-invoices\/cpi_zGmR6BYegfcNmFet"
        }
    },
    "included": [
        {
            "type": "customers",
            "id": "cus_hC9sA9GfY5uwqn9t",
            "attributes": {
                "reference_id": "495901947",
                "email": "test4239@test.com",
                "name": "Deepti",
                "phone": "919804134239",
                "description": null,
                "created": 1730721021,
                "metadata": {
                    "key1": "value1",
                    "key2": "value2"
                },
                "avatar": "https:\/\/www.gravatar.com\/avatar\/25b3a9e4b70ad12a30263534bac1f7a1?s=20&d=mm&r=g",
                "archived": false,
                "processing_options": {
                    "payment_enabled": true,
                    "payout_enabled": true
                },
                "address": {
                    "street": "161",
                    "country": "IN",
                    "region": "Catalonia",
                    "city": "New Delhi",
                    "full_address": "161 Kallang Way,Kallang Way",
                    "post_code": "110001"
                },
                "date_of_birth": "1995-08-09",
                "individual_tax_id": null,
                "passport_number": null,
                "passport_series": null,
                "first_name": null,
                "surname": null,
                "patronymic": null
            },
            "relationships": {
                "commerce-account": {
                    "data": {
                        "type": "commerce-accounts",
                        "id": "coma_6pnkH5vUZw0BlkZY"
                    }
                }
            }
        }
    ]
}

        */

    }
	include($data['Path'].'/payin/status_top'.$data['iex']);
}

#####	TEMP* for Response check as testing	#########
//include($data['Path'].'/payin/res_insert'.$data['iex']);

//exit;

   $UserName = @$apc_get['AccountID'];
   $Password = @$apc_get['APIkey'];

   $credentials = $UserName . ':' . $Password;
   $encodedCredentials = base64_encode($credentials);
   $acquirer_ref = $td['acquirer_ref'];

if(!empty($transID))
{
	if($is_curl_on==true)
	{
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) $acquirer_status_url="https://pay.wzrdpay.io/payment-invoices/" . $acquirer_ref;
		$acquirer_status_url="https://pay.wzrdpay.io/payment-invoices/" . $acquirer_ref;
		if($qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background:#ac7d26;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;word-break:break-all;">';
			
			echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<br/>acquirer_ref=> ".$acquirer_ref;
			echo "<br/>encodedCredentials=> ". $encodedCredentials;
			echo '<br/><br/></div>';
		}
		######################################

	
	

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
   CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: Basic ' . $encodedCredentials
  ),
));

$response = curl_exec($curl);

curl_close($curl);
$responseParamList = json_decode($response,1);
//print_r($responseParamList);
//exit;
 $Status=$responseParamList['data']['attributes']['status'];
  $message = $responseParamList['data']['attributes']['resolution'];
	}

					
#######################################
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status => ".@$responseParamList['data']['attributes']['status'];
		echo "<br/>acquirer message => ".@$responseParamList['data']['attributes']['resolution'];
		echo "<br/>acquirer amount  => ".@$responseParamList['data']['attributes']['amount'];
		echo "<br/>acquirer transactionID => ".@$responseParamList['data']['attributes']['reference_id'];
		
		//echo "<br/>response_json=> ".@$response;
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		
		echo '<br/><br/></div>';
		
	}
	
	$results = $responseParamList;
	  
 
	//applied condition according to the status response for fail success and pending 
	if(isset($results)&&count($results)>0)
	{
		
		$status = strtoupper($responseParamList['data']['attributes']['status']);
		$message = $responseParamList['data']['attributes']['resolution'];
		
		if($qp){
			echo "<br/><br/><=status=>".$status;
		}

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$results;
		
		
		if(isset($responseParamList['data']['attributes']['amount'])&&$responseParamList['data']['attributes']['amount'])
				$_SESSION['responseAmount']	= $responseParamList['data']['attributes']['amount'];

		
		if(isset($status) && !empty($status))
		{
			// $status=='SUCCESS' || 
			if( $status=='processed'){ //success
				$_SESSION['acquirer_response']=$message." - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif($status=='PROCESS_FAILED'||$status=='PROCESS_PENDING'){	//failed
				$_SESSION['acquirer_response']=$message." - Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
			else{ //pending
				$_SESSION['acquirer_response']=$message." - Pending";
				$_SESSION['acquirer_status_code']=1;
				$status_completed=false;
				
				
					
				}
		}
	}
	
}


#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>