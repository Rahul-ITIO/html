<?

//status 35 Pythru
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';


#####	TEMP* for email response as testing	#########
if((isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='notify')||(isset($_REQUEST['action'])&&$_REQUEST['action']=='notify')||(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook'))
{	
	/*
	$data['transIDExit']=1;
	$data['status_in_email']=1;
	$data['devEmail']='arun@bigit.io';
	*/
}


$is_curl_on = true;
if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	/*$str='{
	  "amount": "2.0",
	  "utr": "315211024304",
	  "orderId": "RAI5949295692288245",
	  "name": "Deepti  Tyagi",
	  "txnId": "1113689154819981312",
	  "upi": "9568315028@paytm",
	  "status": "SUCCESS"
	}';*/
	$str = file_get_contents("php://input");
	$res = json_decode($str,true);
	//print_r($res);
	 $utr=$res['utr'];
	 $orderId=$res['orderId'];
	//exit;
	if(isset($orderId)&&$orderId){
		
		$txn_detail=db_rows(
			"SELECT * ". 
			" FROM `{$data['DbPrefix']}master_trans_table`".
			" WHERE `acquirer_ref` = '{$orderId}'".
			" LIMIT 1",$qp //DESC ASC
		);
		$txn_detail=$txn_detail[0];
		$tid = $txn_detail['id'];
		$_REQUEST['transID'] = $txn_detail['transID'];
		
		//$json_value=json_decode($txn_detail['json_value'],1);
		$tr_upd_order['rrn']=$utr;
		
		trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);
	}

	include($data['Path'].'/payin/status_top'.$data['iex']);
}

#####	TEMP* for Response check as testing	#########
//include($data['Path'].'/payin/res_insert'.$data['iex']);

//exit;


$apJson['username']=(isset($json_value['username'])?$json_value['username']:'');
$apJson['password']	= (isset($json_value['password'])?$json_value['password']:'');


$date = $td['tdate'];
$date_arr= explode(" ", $date);
$dateT= $date_arr[0];
$time= $date_arr[1];
  $reference = $td['reference'];
  $id = $td['acquirer_ref'];
 

if(!empty($transID))
{
	if($is_curl_on==true)
	{
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) $acquirer_status_url='http://103.205.64.251:8080/clickncashpayin/rest/auth/transaction/checkStatus';
		
		
		
		if($qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background:#ac7d26;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
			
			echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<br/>MerchantId=> ".$apJson['MerchantId'];
			echo "<br/>subMerchantId=> ".$apJson['subMerchantId'];
			echo "<br/>terminalId=> ".$apJson['terminalId'];
			echo "<br/>merchantTranId=> ".$transID;
			//echo "<br/>bank_mid=>".$bank_mid;

			echo '<br/><br/></div>';
		}
		######################################
		//1st step is for token generate
		$req = '{ 
		  "username": "'.$apJson['username'].'",
		  "password": "'.$apJson['password'].'"
		}';

		$tokenUrl=$acquirer_status_url.'/'."generateToken";//login url through this end point we will get token for further process 
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
		  CURLOPT_POSTFIELDS =>$req,
		  CURLOPT_HTTPHEADER => array(
			'Content-Type: application/json'
		  ),
		));

		$response = curl_exec($curl);

		curl_close($curl);
		//echo $response;
		$resToken = json_decode($response,1);

		$token=$resToken['payload']['token'];
			
		#######################################

	//2nd step for status response
	  $request='{
		"orderId": "'.$id.'",
		"txnType" : "PAYIN",
		"txnStartDate" : "'.$dateT.'",
		"txnEndDate" : "'.$dateT.'",
		"txnId" :  "'.$reference.'"
		}';
		//exit;
		 $urlS=$acquirer_status_url.'/'."transaction/checkStatus";

		$curl = curl_init();

		curl_setopt_array($curl, array(
		  CURLOPT_URL => $urlS,
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
		  CURLOPT_POSTFIELDS =>$request,
		  CURLOPT_HTTPHEADER => array(
		   "Authorization: Bearer ".$token."",
			'Content-Type: application/json'
		  ),
		));

		$response = curl_exec($curl);

		curl_close($curl);
		//echo "<br/><br/><==response==>".$response;

		$res = json_decode($response,1);
		//print_r($res);
		
	}
	//exit;	
	
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status=> ".$res['body']['status'];
		echo "<br/>acquirer message=> ".$res['body']['message'];
		
		
		echo "<br/><br/>res=> ".htmlentitiesf($res);
		echo '<br/><br/></div>';
	}
	

	$results = $res;
	  
  //exit;
	//applied condition according to the status response for fail success and pending 
	if (isset($res) && count($res)>0)
	{
		$status = $res['status'];
		
		
		if($qp){
			echo "<br/><br/><=status=>".$status;
		}

		
		
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$res;

		if(isset($status) && !empty($status))
		{
			if($status=='SUCCESS'){ //success
			$_SESSION['acquirer_response']=$message." - Success";
			$_SESSION['acquirer_status_code']=2;
		}
			elseif($status=='FAILED'){	//failed
			$_SESSION['acquirer_response']=$message." - Cancelled";
			$_SESSION['acquirer_status_code']=-1;
		}
			else{ //pending
			$_SESSION['acquirer_response']=$message." - Pending";
			$_SESSION['acquirer_status_code']=1;
			$status_completed=false;

			if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
				$_SESSION['acquirer_response']=$_REQUEST['actionurl']." Pending or Error";
			}
					
					
				include($data['Path'].'/payin/status_expired'.$data['iex']);
			//	exit;
					
				$data_tdate=date('YmdHis', strtotime($td['tdate']));
				$current_date_1h=date('YmdHis', strtotime("-1 hours"));
				if(($data_tdate<$current_date_1h)&&($data['localhosts']==false)){
					$_SESSION['acquirer_status_code']=-1;
					$_SESSION['acquirer_response']=$message." - Cancelled"; 
				}
			}
		}
	}
	elseif(!isset($_SESSION['acquirer_status_code']) || empty($_SESSION['acquirer_status_code']))
	{
		$data_tdate=date('YmdHis', strtotime($td['tdate']));
		$current_date_2h=date('YmdHis', strtotime("-2 hours"));
		if(($data_tdate<$current_date_2h)){
			$_SESSION['acquirer_status_code']=-1;
			$_SESSION['acquirer_response']=" - Cancelled";
			include($data['Path'].'/payin/status_expired'.$data['iex']); 
		}
	}
}


#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>
