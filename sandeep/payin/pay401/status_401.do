<?php
if(!isset($data['STATUS_ROOT'])){
	include('../../config_db.do');
	include('../status_top'.$data['iex']);
}

include ($data['Path']."/payin/pay401/function_401".$data['iex']);

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
	
	
	if(empty($acquirer_status_url)) $acquirer_status_url="https://gw2.mcpayment.net/api/v5/query/detail";

	$requestPost = array();
	$requestPost['header']['version']		=(string)$apc_get['version'];
	$requestPost['header']['appType']		=(string)$apc_get['appType'];
	$requestPost['header']['appVersion']	=(string)$apc_get['appVersion'];
	//"S2.00.00";
	$requestPost['header']['mcpTerminalId']	=(string)$apc_get['mcpTerminalId'];

	$requestPost['data']['referenceNo']		=(string)$acquirer_ref;
	$requestPost['data']['currency']		=(string)@$json_value['response']['data']['currency'];
	$requestPost['data']['totalAmount']		=(string)(@$json_value['response']['data']['totalAmount']);

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
	if($qp)
	{
		echo '<br/><br/><b>result:</b> '.$result;
		
		echo '<br/><br/><b>responseParamList:</b> ';
		print_r($responseParamList);
		//exit;
	}
	$results = $responseParamList;


	if (isset($responseParamList) && count($responseParamList)>0)
	{
		$message = @$responseParamList['data']['hostResponseCode'];
		$status = "";
		if(isset($responseParamList['data']['transactionState']))
			$status = ($responseParamList['data']['transactionState']);
			
			
		if(isset($responseParamList['data']['totalAmount'])&&$responseParamList['data']['totalAmount']) $_SESSION['responseAmount']=$responseParamList['data']['totalAmount'];
		
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
		$_SESSION['curl_values']=$responseParamList;

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
	include('../status_bottom'.$data['iex']);
}

?>