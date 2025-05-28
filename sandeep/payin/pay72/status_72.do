<?
//status 36 from 72 Iserve 

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
	include($root.'config.do');
	//include($root.'config_db.do');
	
	$body_input=file_get_contents("php://input");

	$responseParamList =  json_decode($body_input, true);		//	decode response
	
	if(isset($responseParamList['clientRefId'])&&$responseParamList['clientRefId'])
	{
		$is_curl_on = false;
		$clientRefId	= $responseParamList['clientRefId'];
		$clientRefId	= substr($clientRefId,-12);
		$clientRefId	= ltrim($clientRefId, "0"); 
		$_REQUEST['transID'] 	= $clientRefId;
		$_REQUEST['action']		= 'webhook';	//set notify means execute via callback
		
		if(strtoupper($responseParamList['status'])=='SUCCESS'){
			echo '{ "status": 0, "statusDesc":"Success"}';
		}
		else{
			echo '{ "status": 1, "statusDesc":"Failure"}';
		}
		
		//echo '200 OK'; //set 200 OK to stop repeat callback
	}
	elseif(isset($responseParamList['txnType'])&&$responseParamList['txnType']=="QR_STATIC")
	{
		$is_curl_on = false;
		$_REQUEST['transID'] 	= 36;			//for test set a default instate
		$_REQUEST['action']		= 'webhook';	//set notify means execute via callback
		$QR_STATIC=true;
	}
	
	include($data['Path'].'/payin/status_top'.$data['iex']);
}

#####	TEMP* for Response check as testing	#########
//include($data['Path'].'/payin/res_insert'.$data['iex']);


/*
$reference		= $td['reference'];
$trans_status	= $td['trans_status'];
$transID		= $td['transID'];
$acquirer_ref	= $td['acquirer_ref'];
$tdate			= $td['tdate'];
*/

//Dev Tech : 23-06-19 for fetch from mer_setting table if empty the json client_id

// account db - site_id get ----------------------------
if((!isset($json_value['client_id'])||empty($json_value['client_id']))&&(isset($td['merID'])&&trim($td['merID']))&&(isset($td['acquirer'])&&trim($td['acquirer'])&&$td['acquirer']>5)){
	$ac_ms=mer_settings($td['merID'], 0, true, $td['acquirer']);
	$ac_acquirer_processing_json=$ac_ms[0]['acquirer_processing_json'];

	if(@$ac_acquirer_processing_json){
		$ac_pj_array = jsondecode($ac_acquirer_processing_json,1,1);
		if(isset($json_value)&&is_array($json_value))
			$json_value=array_merge($json_value,$ac_pj_array);
		else
			$json_value=$ac_pj_array;
	}
	
	if(!isset($json_value['requestPost']['clientRefId']) || empty ($json_value['requestPost']['clientRefId']) ){
		
		$clientRefId = "LTP".$td['merID'];	//ref number start with LTP and merchant id

		$transID_gen = "00000000000".$transID;	//add zeros at start in transaction, becauase iserveU required 19 character reference number
		$len=strlen($clientRefId);	//calc length of clientRefId
		$remLen=19-$len;			//get remaining length

		$clientRefId = $clientRefId.substr($transID_gen,-$remLen);	//create ref no. 19 chars
		
		$json_value['requestPost']['clientRefId']=$clientRefId;
	}

	if($qp)
	{
		echo "<br/><br/><br/>json_value=>";
		var_dump($json_value);
		//exit;
	}
	
	
}



$siteid_get['client_id'] = (isset($json_value['client_id'])?$json_value['client_id']:''); //consumer Key provided by lipad
$siteid_get['client_secret'] = (isset($json_value['client_secret'])?$json_value['client_secret']:'');
$siteid_get['requestPost']['clientRefId']	= (isset($json_value['requestPost']['clientRefId'])?$json_value['requestPost']['clientRefId']:'');
//$siteid_get['requestPost']['clientRefId']	= (isset($json_value['requestPost']['clientRefId'])?$json_value['request']['clientRefId']:'');



//fetch acquirer_status_url from transaction json
if(isset($json_value['acquirer_status_url'])) $acquirer_status_url= @$json_value['acquirer_status_url'];
else $acquirer_status_url='https://apiprod.iserveu.tech/production/statuscheck/txnreport';


if($qp)
{
	echo "<br/><br/>acquirer_status_url=>".$acquirer_status_url;
	echo "<br/><br/>siteid_get=>";
	var_dump($siteid_get);
	//exit;
}

//new section -- callback for static QR - START
$static_call = false;
if(isset($QR_STATIC)&&$QR_STATIC==true)
{
	$statusDesc		= $responseParamList['statusDesc'];
	$productCode	= $responseParamList['productCode'];
	$txnType		= $responseParamList['txnType'];
	$BankRRN		= $responseParamList['rrn'];
	$merchantTranId	= $responseParamList['txnId'];
	$PayerAmount	= $responseParamList['txnAmount'];
	$TxnStatus		= $responseParamList['status'];
	$PayerVA		= $responseParamList['customeridentIfication'];
	$username		= $responseParamList['username'];
	$param_b		= $responseParamList['param_b'];
	$param_c		= $responseParamList['param_c'];
	$TxncreatedDate	= $responseParamList['createdDate'];
	$TxnupdatedDate	= $responseParamList['updatedDate'];

	if($TxnStatus&&strtoupper($TxnStatus)=="SUCCESS")
	{
		$static_call = true;
		if(!isset($host_path)) $host_path=$data['Host'];
		$post['integration-type']=="s2s";
		
		$qrcode=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}softpos_setting`".
			" WHERE `product_name` LIKE '%$param_b%' LIMIT 1",0
		);
	
		$merID		= $qrcode[0]['clientid'];
		$softpos_terNO	= $qrcode[0]['softpos_terNO'];
		$acquirer	= $qrcode[0]['acquirer'];
		$currency	= $qrcode[0]['currency'];

		if(@$currency) $_SESSION['currname']=@$currency;
		else $_SESSION['currname']="INR";

		$_SESSION['terNO']=$softpos_terNO;
		
		//$_SESSION['trans_orderset']=@$merchantTranId;
		$_SESSION['reference']=@$merchantTranId;
		$_SESSION['request_uri']=" Response Status : <b>".@$TxnStatus."</b>";

		//insert transaction 
		
		/*
		transaction(
			'-10',
			$merID,
			$PayerAmount,
			'0.00',
			$acquirer,
			0,
			$TxnStatus,
			'',
			'NA',
			'',
			'',
			'',
			'',
			'',
			'',
			''
		);
		*/
		
	
		
		create_new_trans(
			$merID,					//merID
			$PayerAmount, 		 	//bill_amt
			$acquirer,			//acquirer
			0,						//trans_status
			(isset($post['fullname'])?$post['fullname']:''),		//fullname
			(isset($post['bill_address'])?$post['bill_address']:''),	//bill_address
			(isset($post['bill_city'])?$post['bill_city']:''),		//bill_city
			(isset($post['bill_state'])?$post['bill_state']:''),	//bill_state
			(isset($post['bill_zip'])?$post['bill_zip']:''),		//bill_zip
			(isset($post['bill_email'])?$post['bill_email']:''),	//bill_email	C
			(isset($post['ccno'])?$post['ccno']:''),
			(isset($post['bill_phone'])?$post['bill_phone']:''),	//bill_phone
			(isset($post['product'])?$post['product']:''),
			(isset($_SESSION['http_referer'])?$_SESSION['http_referer']:(isset($_SERVER['HTTP_REFERER'])?$_SERVER['HTTP_REFERER']:''))
		);
				
		
		if(isset($_SESSION['tr_newid'])&&$_SESSION['tr_newid'])
		{
			
			/*
			
			$where_pred="id='{$_SESSION['tr_newid']}'";;

			$td=db_rows(
				"SELECT * ". 
				" FROM `{$data['DbPrefix']}master_trans_table`".
				" WHERE ".$where_pred.
				" LIMIT 1",$qp //DESC ASC
			);
			
			$td=$td[0];
			
			$transID=$td['transID'];
			*/
			
			$_SESSION['transID']=$transID;

			$tr_upd_order['response']=$responseParamList;

			if(isset($BankRRN)&&$BankRRN) $tr_upd_order['acquirer_ref']=$BankRRN;	//use bank RRN as acquirer_ref
			if(isset($PayerVA)&&$PayerVA) $tr_upd_order['upa']=$PayerVA;	// store payer vpa
			
			
			if(isset($tr_upd_order)&&count($tr_upd_order)>0&&is_array($tr_upd_order))
			trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);		//update json_values
			//calculation_tr_fee($_SESSION['tr_newid']);
		}
	//	echo '200 OK'; //set 200 OK to stop repeat callback
		echo '{ "status": 0, "statusDesc":"Success"}';
	}
}
//exit;
//new section -- callback for static QR - END

if(!empty($transID))
{
	if($is_curl_on==true)	//if check status direct via admin or realtime response
	{
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) 
			$acquirer_status_url='https://apiprod.iserveu.tech/production/statuscheck/txnreport';
		
		if($qp)
		{
			echo "<br/>acquirer_status_url=>".$acquirer_status_url;
		}
	
	
		$ClientRefId	=$siteid_get['requestPost']['clientRefId'];
		$client_id		=$siteid_get['client_id'];
		$client_secret	=$siteid_get['client_secret'];
		$request = '{
			"$1": "Upi_txn_status_api",
			"$4": "'.date('Y-m-d', strtotime($tdate)).'",
			"$5": "'.date('Y-m-d', strtotime($tdate)).'",
			"$6": "'.$ClientRefId.'",
			"$10": "'.$acquirer_ref.'"
		}';
		
		//exit;
		$headers = array(
			'client_id: '.$client_id,
			'client_secret: '.$client_secret,
			'Content-Type: application/json',
		);
		
		$curl = curl_init();
		curl_setopt_array($curl, array(
			CURLOPT_URL => $acquirer_status_url,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 1,
			CURLOPT_TIMEOUT => 60,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS => $request,
			CURLOPT_HTTPHEADER => $headers,
		));
	
		$response = curl_exec($curl);
		$httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		$responseParamList = json_decode($response,1);
	}

	if($qp)
	{
		echo "<br/>res=>";
		var_dump($responseParamList);
		//exit;
	}

	$results = $responseParamList;

	//applied condition according to the status response for fail success and pending 
	if (isset($responseParamList) && count($responseParamList)>0)
	{
		if(isset($responseParamList['results'][0]['txnAmount'])&&$responseParamList['results'][0]['txnAmount'])
			$_SESSION['responseAmount'] = $responseParamList['results'][0]['txnAmount'];
		elseif(isset($responseParamList['results']['txnAmt'])&&$responseParamList['results']['txnAmt'])
			$_SESSION['responseAmount'] = $responseParamList['results']['txnAmt'];
		elseif(isset($responseParamList['txnAmt'])&&$responseParamList['txnAmt'])
			$_SESSION['responseAmount'] = $responseParamList['txnAmt'];
		
		
		
		if(isset($responseParamList['results'][0]['status'])&&$responseParamList['results'][0]['status'])
			$status = $responseParamList['results'][0]['status'];
		elseif(isset($responseParamList['status'])&&$responseParamList['status'])
			$status = $responseParamList['status'];
		
		if(isset($responseParamList['results'][0]['statusDesc'])&&$responseParamList['results'][0]['statusDesc'])
			$message = $responseParamList['results'][0]['statusDesc'];
		elseif(isset($responseParamList['statusDesc'])&&$responseParamList['statusDesc'])
			$message = $responseParamList['statusDesc'];
		else $message = "";
		
		
		
		if(isset($responseParamList['payer_vpa'])&&$responseParamList['payer_vpa'])
			$responseParamList['results'][0]['customeridentIfication']=$responseParamList['payer_vpa'];
		
		if(isset($responseParamList['rrn'])&&$responseParamList['rrn'])
			$responseParamList['results'][0]['rrn']=$responseParamList['rrn'];
		


		if(isset($responseParamList['results'][0]['customeridentIfication'])&&$responseParamList['results'][0]['customeridentIfication']&&(empty($td['upa']) || $td['upa']=='is1.skywalk1@finobank' ))
		{
			// store payer vpa via update json_values
			$tr_upd_order['upa']=$responseParamList['results'][0]['customeridentIfication'];	
		}

		if(isset($responseParamList['results'][0]['rrn'])&&$responseParamList['results'][0]['rrn']&&(empty($td['rrn']) || $td['rrn']!=$responseParamList['results'][0]['rrn'] ))
		{
			// upd rrn
			$tr_upd_order['rrn']=$responseParamList['results'][0]['rrn'];	
		}
		
		if(isset($tr_upd_order)&&count($tr_upd_order)>0&&is_array($tr_upd_order))
		trans_updatesf($td['id'], $tr_upd_order);

		if($qp){
			echo "<br/><br/><=status=>".$status;
		}

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$responseParamList;

		if(isset($status) && !empty($status))
		{
			if(strtoupper($status)=='SUCCESS'){ //apply condition for success
				$_SESSION['acquirer_response']=$message." - Success";
				
				$_SESSION['acquirer_status_code']=2;
			}
			elseif( (strtoupper($status)=='INITIATED') && (isset($is_expired)&&$is_expired=='N') ){	//pending :- not expired and No Data Found
				$_SESSION['acquirer_response']=$message." - Pending";
				$_SESSION['acquirer_status_code']=1;
			}
			elseif(strtoupper($status)=='FAILED'){	//Apply condition for failed
				$_SESSION['acquirer_response']=$message." - Cancelled";
				
				$_SESSION['acquirer_status_code']=-1;
			}
			else{ //pending

				$_SESSION['acquirer_response']=$message." - Pending";

				$status_completed=false;
				$_SESSION['acquirer_status_code']=1;

				if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
					$_SESSION['acquirer_response']=$_REQUEST['actionurl']." Pending or Error";
				}

				/*
				
					$data_tdate=date('YmdHis', strtotime($td['tdate']));
					$current_date_1h=date('YmdHis', strtotime("-2 hours"));
					if(($data_tdate<$current_date_1h)&&($data['localhosts']==false)){
						$_SESSION['acquirer_status_code']=-1;
						$_SESSION['acquirer_response']=$message." - Cancelled"; 
						include('../status_expired'.$data['iex']);
					}
				
				*/
			}
		}
	}
	/*
	elseif(!isset($_SESSION['acquirer_status_code']) || empty($_SESSION['acquirer_status_code']))
	{
		$data_tdate=date('YmdHis', strtotime($td['tdate']));
		$current_date_1h=date('YmdHis', strtotime("-2 hours"));
		if(($data_tdate<$current_date_1h)){
			$_SESSION['acquirer_status_code']=-1;
			$_SESSION['acquirer_response']=" - Cancelled";
			include($data['Path'].'/payin/status_expired'.$data['iex']); 
		}
	}
	*/
}

#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>