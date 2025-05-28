<?php
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	//include($data['Path'].'/payin/res_insert'.$data['iex']);
	include($data['Path'].'/payin/status_top'.$data['iex']);//include status_top if the page execute directly
}

include($data['Path']."/payin/pay40/function_40".$data['iex']);

$qp = 0;
//print_r($td);
//print_r($json_value);

if(isset($_REQUEST['qp'])&&$_REQUEST['qp']) $qp = 1;
if(isset($_REQUEST['pq'])&&$_REQUEST['pq']) $qp = 1;



if($qp){
	echo "<br/>apc_get=>"; print_r(@$apc_get);
	echo "<br/><hr/><br/>transID=>".@$transID;
	echo "<br/>acquirer_ref=>".@$acquirer_ref."<br/>";
}

if(!empty($transID))
{	
	
	if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://gw2.mcpayment.net:8443/api/v5/query/detail";

	
	$requestPost = array();
	$requestPost['header']['version']		=(string)$apc_get['version'];
	$requestPost['header']['appType']		=(string)$apc_get['appType'];
		//$requestPost['header']['appType']		='W';
	$requestPost['header']['appVersion']	=(string)$apc_get['appVersion'];
		$requestPost['header']['appVersion']	='S2.00.00';
	
	$requestPost['header']['mcpTerminalId']	=(string)$apc_get['mcpTerminalId'];

	//$requestPost['data']['referenceNo']		=(string)$acquirer_ref;
	$requestPost['data']['referenceNo']		=(string)$transID;

	if(@$td['bank_processing_curr']) $bank_processing_curr=$td['bank_processing_curr'];
		//$requestPost['data']['currency']		=(string)@$json_value['requestPost']['currency'];
		$requestPost['data']['currency']		=(string)@$bank_processing_curr;

	//if(@$td['bank_processing_amount']) $bank_processing_amount=str_replace('.','',$td['bank_processing_amount']);
	if(@$td['bank_processing_amount']) $bank_processing_amount=$td['bank_processing_amount']*100;
		//$requestPost['data']['totalAmount']		=(string)(@$json_value['requestPost']['amount']);
		$requestPost['data']['totalAmount']		=(string)(@$bank_processing_amount);



	if($qp)
	{
		echo 'acquirer_status_url==>'.$acquirer_status_url;
		echo '<br />requestPost==><br/>';
		//print_r($requestPost);
		echo json_encode($requestPost);
		//exit;
	}
	

	$result = sendRequest($acquirer_status_url, $requestPost);

	$responseParamList=json_decode($result,1);
	/*
	if($qp)
	{
		echo '<br/><br/><b>result:</b> '.$result;
		
		echo '<br/><br/><b>responseParamList:</b> ';
		print_r($responseParamList);
		//exit;
	}
	*/
	$results = $responseParamList;


	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="word-wrap:break-word;background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		echo "<br/>mode=>".$apc_get['mode'];
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status ['data']['transactionState']=> ".@$responseParamList['data']['transactionState'];
		echo "<br/>acquirer message ['data']['hostResponseCode']=> ".@$responseParamList['data']['hostResponseCode'];
		echo "<br/>acquirer responseAmount ['data']['totalAmount']=> ".@$responseParamList['data']['totalAmount'];
		echo "<br/>acquirer responseAmount ['data']['totalAmount']*100=> ".@$responseParamList['data']['totalAmount']/100;
		
		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>result=> "; print_r($result);
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
		echo '<br/><br/></div>';
		//echo "<img src='payin/pay40/acquier_status.png' />";
	}

	

	if (isset($responseParamList) && count($responseParamList)>0)
	{
		//$message = @$responseParamList['header']['status']['message'];
		$message = @$responseParamList['data']['hostResponseCode'];
		$status = "";
		if(isset($responseParamList['data']['transactionState']))
			$status = ($responseParamList['data']['transactionState']);
			
			
		if(isset($responseParamList['data']['totalAmount'])&&$responseParamList['data']['totalAmount'])
		{
		 	$_SESSION['responseAmount']=$responseParamList['data']['totalAmount']/100;
		}
		
		
		
		//rrn //acquirer_ref
		#######	rrn, acquirer_ref update from status get :start 	###############
			
			//acquirer_ref
			$acquirer_ref_1='';
			if(isset($responseParamList['data']['transactionId'])) $acquirer_ref_1 = @$responseParamList['data']['transactionId'];
			//up acquirer_ref : update if empty acquirer_ref_1 and is ['data']['transactionId']  
			if(empty(trim($td['acquirer_ref']))&&!empty($acquirer_ref_1)&&$acquirer_ref_1!='{}'&&$acquirer_ref_1!=NULL){
				$tr_upd_status['acquirer_ref']=trim($acquirer_ref_1);
			}
			
			
			if($qp){
				echo "<br/><br/><=acquirer_ref=>".@$acquirer_ref_1;
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
			
		#######	rrn, acquirer_ref update from status get :end 	###############
	
		
		

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		//$_SESSION['curl_values']=$responseParamList;

		if(isset($responseParamList['header']['status']['responseCode']))
		{
			if($status=='Ok' || $status=='2'){ //success

				$message = "Ok";
				$_SESSION['acquirer_response']=$message." - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif($status=='5' || $status=='78'){	//failed
				if($status=='5') $message = "Denied / Failed";
				else  $message = "Order Closed";

				$_SESSION['acquirer_response']=$message." - Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
			else{ //pending
				$message = "User Paying / Pending";
				$_SESSION['acquirer_response']=$message." - Pending";
				$status_completed=false;
				$_SESSION['acquirer_status_code']=1;
				
				
			}
		}
	}
}


if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>