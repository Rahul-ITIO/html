<?
//status 112 from 108 for lipad
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';


$is_curl_on = true;
if(!isset($data['STATUS_ROOT'])){
	
	//if((isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='notify')||(isset($_REQUEST['action'])&&$_REQUEST['action']=='notify'))//you can get status on email
	//for checking the callback status used email ID
	{	
		
		$data['ordersetExit']=1;
		$data['status_in_email']=1;
		$data['devEmail']='arun@bigit.io';
		$send_attchment_message5=1;
		
	}


	include($root.'config_db.do');
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
		$_REQUEST['orderset'] = $res['merchant_transaction_id'];
		$_REQUEST['actionurl']= 'notify';//set notify means execute via callback
	}
	elseif(isset($res['external_reference'])&&$res['external_reference'])
	{
		//$is_curl_on = false;
		$_REQUEST['orderset'] = $res['external_reference'];
		$_REQUEST['actionurl']= 'notify';//set notify means execute via callback
	}
	include($data['Path'].'/payin/res_insert'.$data['iex']);
	include($data['Path'].'/payin/status_top'.$data['iex']);
}

$_SESSION['tr_newid']		= $td['id'];
$mrid			= $td['mrid'];
$status			= $td['status'];
$transaction_id	= $td['transaction_id'];
$txn_id			= $td['txn_id'];


$siteid_get['ConsumerKey']	= (isset($json_value['ConsumerKey'])?$json_value['ConsumerKey']:''); //consumer Key provided by lipad
$siteid_get['ConsumerSecret']	= (isset($json_value['ConsumerSecret'])?$json_value['ConsumerSecret']:'');//ConsumerSecrete provided by lipda
$siteid_get['merchant_transaction_id']	= (isset($json_value['merchant_transaction_id'])?$json_value['merchant_transaction_id']:'');//
 //print_r($siteid_get);
 //exit;


  $charge_request_id=jsonvaluef($jsn,'charge_request_id');
 
if(!empty($transaction_id))
{	
	if($is_curl_on==true)
	{
		//get bank url from bank getway table
		if($bank_acquirer_json_arr){
			$bank_status_url=$bank_acquirer_json_arr['bank_status_url'];
			if($bank_status_url) $bank_status_url=$bank_status_url;
			else $bank_status_url='https://checkout-api.lipad.io/payin/v1/checkout/request/status'; 
		}
		

		//tokenUrl
		$tokenUrl = "https://dev.lipad.io/v1/auth";
		 
		$keys='{"consumer_key":"'.$siteid_get['ConsumerKey'].'","consumer_secret":"'.$siteid_get['ConsumerSecret'].'"}';
		
		
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
			
			$urls="https://dev.charge.lipad.io/v1/transaction/{$charge_request_id}/status";
			
			$curl = curl_init();

			curl_setopt_array($curl, array(
			  CURLOPT_URL =>$urls,
			  CURLOPT_RETURNTRANSFER => true,
			  CURLOPT_ENCODING => '',
			  CURLOPT_MAXREDIRS => 10,
			  CURLOPT_TIMEOUT => 30,
			  CURLOPT_FOLLOWLOCATION => true,
			  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			  CURLOPT_CUSTOMREQUEST => 'GET',
			  CURLOPT_HTTPHEADER => array(
				"Content-Type: application/json",
				"x-access-token: $token"
			 ),
			));

			$response = curl_exec($curl);

			curl_close($curl);
			//echo $response;
			$res = json_decode($response,1);

		}
	}



if($qp)
{
	echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
	//echo "res=>"; print_r($res);
	
	
	echo "<br/>tokenUrl=>".$tokenUrl;
	echo "<br/>keys=>".$keys;
	echo "<br/>token=>".($token?$token:$response);
	
	echo "<br/><br/>bank_status_url=>".$urls;
	echo "<br/>acquirer status=> ".@$res['payment_status'];
	echo "<br/>acquirer message=> ".@$res['receiver_narration'];
	echo "<br/>response=> ".@$response;
	
	
	//echo "<br/>acquirer message=> ".@$res['event_history'][0]['payment_status'];
	
	//echo "<br/>response_json=> ".@$response_json;
	//echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
	
	//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
	echo '<br/><br/></div>';
}

  
//transactions_updates($_SESSION['tr_newid'],$tr_upd_order);
//print_r($res);
//exit;

//exit;
	//print_r($res);
	//echo $res['tradeinfo']['queryResult'];
	//exit;

	if($qp)
	{
		echo "<br/>res=>";
		var_dump($res);
		//exit;
	}

	$results = $res;

	//applied condition according to the status response for fail success and pending 
	if (isset($res) && count($res)>0)
	{
	//here is two conditio for status overall payment satus and eventhostory
		   
		   if(isset($res['event_history'][0]['payment_status'])&&$res['event_history'][0]['payment_status'])
		   $status = $res['event_history'][0]['payment_status'];//exact status of payment
		   
		   elseif(isset($res['payment_status'])&&$res['payment_status'])
		   $status= $res['payment_status'];
		   
		   if(isset($res['amount'])&&$res['amount'])
		   $_SESSION['responseAmount']= $res['amount'];
		   
		if($qp){
			echo "<br/><br/><=status=>".$status;
		}

		if($res['receiver_narration']){
			$message	= $res['receiver_narration'];
		}elseif($res['overall_payment_status']){
			$message	= $res['overall_payment_status'];
		}else{
			$message	= $res['overall_payment_description'];
		}
		

		if(isset($res['overall_payment_description'])&&$res['overall_payment_description'])
			 $message	= $res['overall_payment_description'];
			

		$_SESSION['hkip_action']="hkip";
		$_SESSION['hkip_info']=$message;
		$_SESSION['curl_values']=$res;
		
	if($status)
		{
		
			if($status==700){ //apply condition for success

				$_SESSION['hkip_info']="Success";
				$_SESSION['hkip_status']=2;
				$_SESSION['hkip_order_status']=2;
			}
			elseif($status==701){	//Apply condition for failed
				$_SESSION['hkip_info']=$message." - Cancelled";
				$_SESSION['hkip_status']=-1;
				$_SESSION['hkip_order_status']=-1;
			}
			elseif($status==820){//Apply condition for Expired,will get overall payment status
				$_SESSION['hkip_info']=$message." - Expired";
				$_SESSION['hkip_status']=22;
				$_SESSION['hkip_order_status']=22;
			}
			else{ //pending

				$_SESSION['hkip_info']=$message." - Pending";

				$status_completed=false;
				$_SESSION['hkip_order_status']=1;
				if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
					$_SESSION['hkip_status']=$_REQUEST['actionurl']." Pending or Error";
				}

				$data_tdate=date('YmdHis', strtotime($td['tdate']));
				$current_date_2h=date('YmdHis', strtotime("-2 hours"));
				if(($data_tdate<$current_date_1h)&&($data['localhosts']==false)){
					$_SESSION['hkip_order_status']=-1;
					$_SESSION['hkip_info']=$message." - Cancelled"; 
					include('../status_expired'.$data['iex']);
				}
			}
		}
	}
	elseif(!isset($_SESSION['hkip_order_status']) || empty($_SESSION['hkip_order_status']))
	{
		$data_tdate=date('YmdHis', strtotime($td['tdate']));
		$current_date_1h=date('YmdHis', strtotime("-2 hours"));
		if(($data_tdate<$current_date_1h)){
			$_SESSION['hkip_order_status']=-1;
			$_SESSION['hkip_info']=" - Cancelled";
			include($data['Path'].'/payin/status_expired'.$data['iex']); 
		}
	}
}

#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>