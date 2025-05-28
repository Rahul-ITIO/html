<?
// Dev Tech : 23-12-23  100 Acquirer is Default root any our acquirer as per public_key, Trans URL and terNO wise access status via callback - start

$is_curl_on = true;

if((isset($_REQUEST['transID']))&&(!empty($_REQUEST['transID']))){
	$_REQUEST['transID'] = $_REQUEST['transID'];
	//$is_curl_on = false; $_REQUEST['actionurl']='notify';
}

if((isset($_REQUEST['acquirer_ref']))&&(!empty($_REQUEST['acquirer_ref']))){
	//$_REQUEST['transID'] = $_REQUEST['acquirer_ref'];
	//$is_curl_on = false; $_REQUEST['actionurl']='notify';
}

// access status via callback - end

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	//include($data['Path'].'/payin/res_insert'.$data['iex']);
	include($data['Path'].'/payin/status_top'.$data['iex']);//include status_top if the page execute directly
}

//include($data['Path'].'status_in_email'.$data['iex']);

//print_r($td);
//print_r($json_value);

if(isset($apc_get['public_key'])&&$apc_get['public_key']) $public_key=$apc_get['public_key'];
if(isset($apc_get['terNO'])&&$apc_get['terNO']) $terNO=$apc_get['terNO'];

if(empty($acquirer_status_url)) $acquirer_status_url=$data['Host'].'/fetch_trnsStatus'.$data['iex'];
	
if(empty($reference)){
	$acquirer_ref=1;
	$acquirer_status_url	= $acquirer_status_url."?reference=".@$reference."&public_key=".@$public_key; 	//empty is txn_id than id_order and store_id wise get the status 
}else{
	$acquirer_status_url	= $acquirer_status_url."?transID=".$acquirer_ref; 
}
	

if($qp)
{
	echo "<br/>public_key=>".$public_key;
	echo "<br/>terNO=>".$terNO;
	echo "<br/>acquirer_status_url=>".$acquirer_status_url;
	echo "<br/>acquirer_ref=>".$acquirer_ref;
}

if(!empty($acquirer_ref))
{
	$post_data = array();
	$post_data['acquirer_ref'] = $acquirer_ref;
	
	if($is_curl_on)
	{
		$curl = curl_init();
		curl_setopt_array($curl, [
			CURLOPT_URL => $acquirer_status_url,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => "",
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_HEADER => 0,
			CURLOPT_TIMEOUT => 30,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'GET',
			CURLOPT_POSTFIELDS => json_encode($post_data),
		]);
	
		$response = curl_exec($curl);	
		$http_status	= curl_getinfo($curl, CURLINFO_HTTP_CODE);
		$curl_errno		= curl_errno($curl);
		curl_close($curl);
	
		if($qp)
		{
			echo "<br/><br/>post_data=>";
			print_r($post_data);
			echo "<br/>acquirer_status_url=>".$acquirer_status_url;
			echo "<br/>response=>".$response;
		}
		if($http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404) {	//transaction stay as PENDING if received any one of the above error
			$err_msg = "HTTP Status == {$http_status}.";
			
			if($curl_errno) echo "<br/>Curl Errno returned $curl_errno.<br/>";
			
			$_SESSION['acquirer_response']		=$err_msg." - Pending";
			$_SESSION['acquirer_status_code']=1;
			$status_completed=false;
			
			//exit;
		}
		elseif($curl_errno){
			echo '<br/>Request Error: '.$curl_errno.' - ' . curl_error($handle);
			exit;
		}
	
		$responseParamList = jsondecode($response,1,1);	// covert response from json to array
	}
	$results = $responseParamList;
	//$_SESSION['results_100']=$results;
	
	if(isset($_SESSION['adm_login'])||isset($_SESSION['login'])||$is_admin){
		$post_en=replacepost(prntext(json_encode(@$responseParamList)));
		if($post_en){
			$post_de=json_decode($post_en,1);
			$results=$post_de;
		}
		
		if(isset($responseParamList['auth_data'])) unset($responseParamList['auth_data']);		
	}
	
	/*
	echo "<pre><code>";
	print_r($results);
	echo "</code></pre>";
	exit;
	*/
	if($qp)
	{
		echo "<br/>responseParamList=>";
		var_dump($responseParamList);
	}

	if (isset($responseParamList) && count($responseParamList)>0)
	{
		$message= @$responseParamList['response'];
		
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']	=$message;
		$_SESSION['curl_values']=@$responseParamList;
		if(isset($responseParamList['transID'])&&$responseParamList['transID']) $_SESSION['acquirer_transaction_id']=$responseParamList['transID'];

		//$paystatus = strtolower($responseParamList['data']['status']);
		$status_nm = (int)@$responseParamList['order_status'];
		
		if($status_nm==1){ //success

			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Success";
			
			$_SESSION['acquirer_status_code']=2;
			$_SESSION['acquirer_descriptor']=$json_value['billing_descriptor'];
		}
		elseif($status_nm==2||$status_nm==22||$status_nm==23){	//failed
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." Payment failed - Cancelled";
			$_SESSION['acquirer_status_code']=-1;
		}
		else{
			$_SESSION['acquirer_response']=$message." - Pending";
			$_SESSION['acquirer_status_code']=1;
			
		}
	}
}
/*
else {  //Expired

		$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." Pending - ".$_SESSION['acquirer_status_code'];
		$_SESSION['acquirer_status_code']=1;
		
		$data_tdate=date('YmdHis', strtotime($td['tdate']));
		$current_date_1h=date('YmdHis', strtotime("-3 hours"));
		if($data_tdate<$current_date_1h){
			$_SESSION['acquirer_status_code']=-1;
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Expired";
			include($data['Path'].'/payin/status_expired'.$data['iex']); 
		}
		
}
*/
if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>