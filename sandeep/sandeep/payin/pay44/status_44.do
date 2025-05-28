<?
//status 44

$data['NO_SALT']=true;

$is_curl_on=true;


//Dev Tech: 23-12-22 Step:1 for acquirer to redirect post method and found the avs_noauth than retrun the response via get method from top url 
if(isset($_REQUEST['tx_ref'])&&$_REQUEST['tx_ref']) 
			$_REQUEST['transID']=$_REQUEST['tx_ref'];
		
		
if(isset($_REQUEST['response'])&&$_REQUEST['response']){
	
	//echo "<br/>response=>".$_REQUEST['response'];
	
	$resp=json_decode($_REQUEST['response'],1);
	
	if(isset($resp)&&is_array($resp)){
		$responseParamList=$resp;
		
		if(isset($resp['txRef'])&&$resp['txRef']) 
			$_REQUEST['transID']=$resp['txRef'];
		
			
		if(isset($resp['status'])&&$resp['status']) {
			$responseParamList['data']['status']=$resp['status'];
			$is_curl_on=false;
		}
		
		if(isset($resp['processor_response'])&&$resp['processor_response'])
			$responseParamList['data']['processor_response']=$resp['processor_response'];
		
	
	}
	
}



//Dev Tech : 23-12-19 fetch response via webhook 

$body_input_get = file_get_contents("php://input");

if(isset($body_input_get)&&$body_input_get){
	
	//remove tab and new line from json encode value 
	$body_input_get = preg_replace('~[\r\n\t]+~', '', $body_input_get);

	$object_input_res = $responseParamList = json_decode($body_input_get, true);
	$data['gateway_push_notify']=$object_input_res;
	if(isset($object_input_res)&&$object_input_res){
		//$object_input_res=array_map('addslashes', $object_input_res);
		
		//$object_input_res=htmlTagsInArray($object_input_res);
		
		if(isset($object_input_res['data'])&&is_array($object_input_res['data']))
		{
			$object_input_res=$responseParamList['data']=$object_input_res['data'];
			
			if(isset($object_input_res['tx_ref'])&&$object_input_res['tx_ref']) 
				$_REQUEST['transID']=$object_input_res['tx_ref'];
				
			if(isset($object_input_res['status'])&&$object_input_res['status']) {
				$responseParamList['data']['status']=$object_input_res['status'];
				$is_curl_on=false;
			}
		}
		
		//$email_message.="<p><b>PHP_INPUT: </b>".json_encode($object_input_res, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
		
	}
}


if(!isset($data['STATUS_ROOT'])){
	include('../../config_db.do');
	include($data['Path'].'/payin/status_top'.$data['iex']);
}

$txn_id			= $td['acquirer_ref'];


//Dev Tech: 23-12-22 Step:2 for acquirer to redirect post method and found the avs_noauth than retrun the response via get method from top url 

if(isset($json_value['avs_noauth'])&&trim($json_value['avs_noauth']))
{
	if(isset($_REQUEST['status'])&&$_REQUEST['status']) {
		$responseParamList['data']['status']=$responseParamList['message']=$_REQUEST['status'];
		$is_curl_on=false;
	}
	if(isset($_REQUEST['transaction_id'])&&$_REQUEST['transaction_id']) {
		$_SESSION['acquirer_transaction_id']=$_REQUEST['transaction_id'];
	}
		
}


if(!empty($transID))
{

	//$acquirer_status_url = "https://api.flutterwave.com/v3/transactions";
	//$acquirer_status_url = "https://api.ravepay.co/v3/transactions";
	
	if(empty($acquirer_status_url))
		//$acquirer_status_url = "https://api.ravepay.co/v3/transactions";
		$acquirer_status_url = "https://api.flutterwave.com/v3/transactions";

	if(isset($json_value['avs_noauth'])&&trim($json_value['avs_noauth']))
		$acquirer_status_url = $acquirer_status_url."/verify_by_reference?tx_ref=".$transID;
	else $acquirer_status_url = $acquirer_status_url."/{$txn_id}/verify/";
	
	if($is_curl_on==true)	//if check status direct via admin or realtime response
	{
			
		$curl = curl_init();

		curl_setopt_array($curl, array(
			CURLOPT_URL => $acquirer_status_url,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => "",
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 0,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => "GET",
			CURLOPT_HTTPHEADER => array(
				"Content-Type: application/json",
				"Authorization: Bearer ".$apc_get['SecretKey'],
			),
		));

		$response = curl_exec($curl);
		
		curl_close($curl);

		$responseParamList = json_decode($response, true);
		
	}
	
	
	if($qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
			//echo "res=>"; print_r($res);
			
			echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<br/>acquirer status=> ".@$responseParamList['status'];
			echo "<br/>acquirer message=> ".@$responseParamList['message'];
			
			//echo "<br/>response_json=> ".@$response_json;
			echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
			
			//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
			echo '<br/><br/></div>';
		}
		

	if($qp)
	{
		//exit;
	}
	
	

	$results = $responseParamList;

	if (@$responseParamList['status']=='error') {
		//var_dump($responseParamList);
	}
	//else 
	{
		if (isset($responseParamList) && count($responseParamList)>0)
		{
		
			
		//rrn //acquirer_ref
		#######	rrn, acquirer_ref update from status get :start 	###############
			
			//acquirer_ref
			$acquirer_ref='';
			if(isset($responseParamList['data']['tx_ref'])) $acquirer_ref = @$responseParamList['data']['tx_ref'];
			//up acquirer_ref : update if empty acquirer_ref and is ['data']['tx_ref']  
			if(empty(trim($td['acquirer_ref']))&&!empty($acquirer_ref)){
				$tr_upd_status['acquirer_ref']=trim($acquirer_ref);
			}
			
			
			//mop
			$mop_get='';
			if(isset($responseParamList['data']['payment_type'])&&in_array($responseParamList['data']['payment_type'],["googlepay","applepay"])) $mop_get = @$responseParamList['data']['payment_type'];
			//up mop : update if empty mop and is ['data']['payment_type']  
			if(!in_array($td['mop'],["googlepay","applepay"])&&!empty($mop_get)){
				$tr_upd_status['mop']=trim($mop_get);
			}
				
			
			//rrn 
			$rrn='';
			if(isset($responseParamList['data']['flw_ref'])) $rrn = @$responseParamList['data']['flw_ref'];
			//up rrn : update if empty rrn and is ['data']['flw_ref'] 
			if(empty(trim($td['rrn']))&&!empty($rrn)){
				$tr_upd_status['rrn']=trim($rrn);
			}
			
			
			if($qp){
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
			
		#######	rrn, acquirer_ref update from status get :end 	###############

			
			//$status = 0;
			if(isset($responseParamList['data']['amount'])) $_SESSION['responseAmount'] = @$responseParamList['data']['amount'];
			
			if(isset($responseParamList['data']['status'])) $status = @$responseParamList['data']['status'];
			elseif(isset($responseParamList['status'])) $status = @$responseParamList['status'];

			if(@$responseParamList['message']){
				$message	= @$responseParamList['message'];
			}else{
				$message	= @$responseParamList['message'];
			}
			
			$_SESSION['acquirer_action']=1;
			$_SESSION['acquirer_response']=@$message;
			$_SESSION['curl_values']=@$responseParamList;

			if(isset($status) && !empty($status))
			{
				if(@$responseParamList['data']['status']=='successful'){ //success
					$_SESSION['acquirer_response']=$responseParamList['data']['processor_response']." - Success";
					$_SESSION['acquirer_status_code']=2;
				}
				elseif(@$responseParamList['status']=='error' && @$is_expired=='Y' ){	//failed
					$msg = '';
					if(isset($responseParamList['data']['processor_response']) && @$responseParamList['data']['processor_response'])
						$msg = $responseParamList['data']['processor_response'];
					elseif(isset($responseParamList['message'])&&$responseParamList['message'])
						$msg = $responseParamList['message'];
					 
					$_SESSION['acquirer_response']=$msg." - Cancelled";
					$_SESSION['acquirer_status_code']=23;
				}
				elseif( (@$responseParamList['data']['status']=='failed' || @$responseParamList['status']=='error') && ( @$is_expired=='Y' )){	//failed
					$msg = '';
					if(isset($responseParamList['data']['processor_response']) && @$responseParamList['data']['processor_response'])
						$msg = $responseParamList['data']['processor_response'];
					elseif(isset($responseParamList['message'])&&$responseParamList['message'])
						$msg = $responseParamList['message'];
					 
					$_SESSION['acquirer_response']=$msg." - failed";
					$_SESSION['acquirer_status_code']=-1;
				}
				else{ //pending

					$_SESSION['acquirer_response']=@$responseParamList['data']['processor_response']." - Pending";

					$status_completed=false;
					$_SESSION['acquirer_status_code']=1;
					
				}
			}
		}
	}
}
if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>