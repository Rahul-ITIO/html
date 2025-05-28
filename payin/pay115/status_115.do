<?
//status 114 - paymentsolo -  payment solo
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';



$is_curl_on = false;
if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	
	//webhook : 
	if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook')
	{

			$body_input = file_get_contents("php://input");
			$response = @$body_input;

			$response = (html_entity_decode($response)); $response = str_replace(["&gt; ","&gt;"],"",$response);
			
			$responseParamList = $data['gateway_push_notify'] = json_decode($response, true);
			//$data['gateway_push_notify'] = $responseParamList['trigger'];

			/*
				{
					"version":"v2",
					"trigger":"order.paid",
					"custom_code":"test-123",
					"tx_uuid":"b7a21d77-6f94-4c5a-9ad2-e45f7439b25f",
					"checksum":"3dd609c6e0a694ccddd90ce3401f32ae65554d538a790e428f"
				}

			*/
		
			if(isset($responseParamList['custom_code'])&&isset($responseParamList['trigger'])&&@$responseParamList['trigger']) 
			{

				$transID_via_reference=rawurldecode($responseParamList['custom_code']);
				
				if(@$qp)
				{
					echo "<br/><hr/><br/>responseParamList=><br/>";
					print_r($responseParamList);

					echo "<br/><br/>transID_via_reference=>".$transID_via_reference;
					echo "<br/><br/>status=>".$responseParamList['trigger'];
				}

				$transID_via_reference=preg_replace("/[^0-9.]/", "",@$transID_via_reference);

				$_REQUEST['transID']= rawurldecode($transID_via_reference);
				$is_curl_on = false; $_REQUEST['action']='webhook';

				if(@$qp)
				{
					echo "<br/><br/>transID 1=>".@$transID_via_reference;
					echo "<br/><br/>transID _REQUEST=>".@$_REQUEST['transID'];
				}

			}
	}
	
	include($data['Path'].'/payin/status_top'.$data['iex']);
}

#####	TEMP* for Response check as testing	#########
//include($data['Path'].'/payin/res_insert'.$data['iex']);

//exit;

$apJson['ShopId']=(isset($data['apJson']['ShopId'])?@$data['apJson']['ShopId']:'');
$apJson['Pass']=(isset($data['apJson']['Pass'])?@$data['apJson']['Pass']:'');
$apJson['AccountId']=(isset($data['apJson']['AccountId'])?@$data['apJson']['AccountId']:'');
$apJson['Key']=(isset($data['apJson']['Key'])?@$data['apJson']['Key']:'');
$Conf = @$json_value['ConfirmationNumber'];

if(!empty($transID))
{
	if($is_curl_on==true)
	{
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) $acquirer_status_url='https://www.payit123.com/clients';


		$user_via_base_url=(isset($apc_get['user'])&&trim($apc_get['user'])?$apc_get['user']:'paymentsolo'); 

		$acquirer_status_url=$acquirer_status_url."/{$user_via_base_url}/get_order_status.php";
	
		
		$token=(isset($apc_get['token'])&&trim($apc_get['token'])?$apc_get['token']:'5e12cef38728dc61c68bfdf0cf1ed11d'); 
		$authorization=(isset($apc_get['authorization'])&&trim($apc_get['authorization'])?$apc_get['authorization']:'8e1fbd6f20ff0cfce4f40671a3bb2396'); 
		
		if($qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background:#ac7d26;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;word-break:break-all;">';
			
			echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<br/>acquirer_ref=> ".$acquirer_ref;
			echo "<br/>token=> ".$token;
			echo "<br/>authorization=> ".$authorization;
			echo '<br/><br/></div>';
		}
		######################################

		if(empty($acquirer_ref)||$acquirer_ref=='{}'){
			$acquirer_ref=$transID;
		}


		$curl = curl_init();

		  curl_setopt_array($curl, array(
		  CURLOPT_URL =>$acquirer_status_url,
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_FOLLOWLOCATION  => false,  
		  CURLOPT_ENCODING => "",
		  CURLOPT_MAXREDIRS => 10,
		  	CURLOPT_TIMEOUT => 0,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'GET',
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_POSTFIELDS => '{
				"invoiceNumber": "'.$acquirer_ref.'"
			}',
		  CURLOPT_HTTPHEADER => array(
			"accept: application/json",
			'Authorization: Bearer '.$authorization,
			'Content-Type: application/json'
		  ),
		));

		$response = curl_exec($curl);
		$err = curl_error($curl);  
		curl_close($curl);

		//Convert json to Array
		$responseParamList = json_decode($response,true);

	}

					
#######################################
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status => ".@$responseParamList['trigger'];
		//echo "<br/>acquirer message => ".@$responseParamList['message'];
		//echo "<br/>acquirer amount  => ".@$responseParamList['amount'];
		//echo "<br/>acquirer transactionID => ".@$responseParamList['transactionID'];
		
		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		//echo "<br/><br/>responseParamList=> ".htmlentitiesf(@$responseParamList);
		echo '<br/><br/></div>';
		
	}
	
	$results = $responseParamList;
	  
  //exit;
	//applied condition according to the status response for fail success and pending 
	if(isset($results)&&count($results)>0)
	{
		
		$status = strtoupper($responseParamList['trigger']);
		$status=str_ireplace("ORDER.","",$status);
		$message = $responseParamList['message'];
		
		if($qp){
			echo "<br/><br/><=status=>".$status;
		}

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$results;
		
		
		if(isset($responseParamList['amount'])&&$responseParamList['amount'])
				$_SESSION['responseAmount']	= $responseParamList['amount'];

		
		if(isset($status) && !empty($status))
		{
			// $status=='SUCCESS' || 
			if( $status=='PAID' || $status=='APPROVED' || $status=='Approved' || $status=='SUCCESS' || $status=='success'  ){ //success
				$_SESSION['acquirer_response']="Approved";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif($status=='DECLINED' || $status=='CANCEL' || $status=='declined'){	//failed
				$_SESSION['acquirer_response']="Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
			else{ //pending
				$_SESSION['acquirer_response']="Pending";
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