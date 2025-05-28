<?
include('../../config_db.do');
include($data['Path'].'/payin/status_top'.$data['iex']);
//$data['cqp']=9;
if($data['cqp']==9)
{
	echo "<br/><hr/>acquirer_response_stage1_arr=>";print_r($acquirer_response_stage1_arr);
}

if(isset($acquirer_response_stage1_arr)&&is_array($acquirer_response_stage1_arr))
{
	
	
	$postdata		= @$acquirer_response_stage1_arr['paylod_1'];
	
	$response_1		= @$acquirer_response_stage1_arr['response_1'];
	
	if(isset($response_1['meta']['authorization']['mode']) && ($response_1['meta']['authorization']['mode']=='avs_noauth') )
	{
		if(!isset($postdata['authorization']['state']) || $postdata['authorization']['state']=='')
		{
			$postdata['authorization']['state']=$postdata['authorization']['city'];
		
		}
		
		include('function_44.do');
		 
		$dataReq = json_encode($postdata);
		
		if($data['cqp']>0) { echo "<br/><br/>dataReq=>"; print_r($dataReq);}
	
		$post_enc = encrypt3Des($dataReq, getKey($apc_get['SecretKey']));
	
		$postdata = array(
			'public_key' => $apc_get['PublicKey'],
			'client' => $post_enc,
			'alg' => '3DES-24'
		);
		
		if($data['cqp']>0) 
		{ 
			echo "<br/><br/>postdata=>"; print_r($postdata); 
		}
	}
	else {
		$flw_ref		= @$acquirer_response_stage1_arr['flw_ref_1'];
		
		$otp			= @$_REQUEST['otp'];
		$postdata = array(
			"otp"=> $otp,
			"flw_ref"=> $flw_ref,
			"type"=> "card",
		);
	}
	
	
	$url			= $acquirer_response_stage1_arr['pay_url_1'];
	$SecretKey 		= $acquirer_response_stage1_arr['secretkey_1'];

	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL =>$url,
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 30,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS =>json_encode($postdata),
	  CURLOPT_HTTPHEADER => array(
		"Accept: application/json",
		"Authorization: Bearer ".$SecretKey,
		"Content-Type: application/json"
	  ),
	));

	$response = curl_exec($curl);

	curl_close($curl);

	$response_step2 = json_decode($response,1);
	
	$tr_upd_order['response_step_2']=(isset($response_step2)&&is_array($response_step2)?$response_step2:$response);
	
	trans_updatesf($td['id'], $tr_upd_order);
	
	if($data['cqp']>0) 
		print_r(@$tr_upd_order['response_step_2']);
	if($data['cqp']==19)exit;
	
	
	if (isset($response_step2) && count($response_step2)>0)
		{
			// return_url to be use for success or failed pages 
			$return_url = $data['Host']."/return_url{$data['ex']}?transID=".$transID."&action=redirect";

			// return_url to be use for success or failed pages 
			$trans_processing = $data['Host']."/trans_processing{$data['ex']}?transID=".$transID."&action=status";

			
			$message = '';
			if(isset($response_step2['data']['processor_response'])&&$response_step2['data']['processor_response'])
				$message = $response_step2['data']['processor_response'];
			elseif(isset($response_step2['message'])&&$response_step2['message'])
				$message = $response_step2['message'];

			$status = $response_step2['status'];
			
			if(isset($status) && !empty($status))
			{
				
				$json_arr_set['realtime_response_url']=$trans_processing;
				
				$_SESSION['acquirer_action']=1;
				$_SESSION['acquirer_response']=$message;
				$_SESSION['curl_values']=$response_step2;
				
				if(@$response_step2['data']['status']=='successful'){ //success
					$_SESSION['acquirer_response']=$message." - Success";
					$_SESSION['acquirer_status_code']=2;
					$process_url = $return_url; 
				}
				elseif(@$response_step2['data']['status']=='failed' || $response_step2['status']=='error'){	//failed
					$_SESSION['acquirer_response']=$message." - Cancelled";
					$_SESSION['acquirer_status_code']=-1;
					$process_url = $return_url; 
				}
				else{ //pending
					$_SESSION['acquirer_response']=$message." - Pending";
					$_SESSION['acquirer_status_code']=1;
					$process_url = $trans_processing;
				}
				if($process_url){
					
					if($data['cqp']>0)
					{
						echo "<br/><br/>return_url=>".$return_url; 
						echo "<br/><br/>acquirer_response=>"; print_r($_SESSION['acquirer_response']);exit;
					}
					
					if(isset($_SESSION['authURL'])) unset($_SESSION['authURL']);
					header("Location:$process_url");
					exit;
				}
			}
		}
		
	
	
}
else {
	$data['Error']=7004;
	$data['type']=44;
	echo $data['Message']="Could not established secure connection ...";
}
	
	
?>