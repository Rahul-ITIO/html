<?
//status for 69, 690 - 699  ICICI :- QR, Intent & UPI Collect

//$qp = 0;
if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp']) $qp=$_SESSION['post']['qp'];
elseif(isset($_REQUEST['qp'])&&$_REQUEST['qp']) $qp=$_REQUEST['qp'];

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

#####	TEMP* for email response as testing	#########
/*

if((isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='notify')||(isset($_REQUEST['action'])&&$_REQUEST['action']=='notify')||(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook'))
{	
	
	$data['transIDExit']=1;
	$data['status_in_email']=1;
	$data['devEmail']='arun@bigit.io';
	
}

*/

$is_curl_on = true;
if(!isset($data['STATUS_ROOT'])){
	include($root.'config.do');
	########## callback section #############
	
	//callback section - fetch callback body
	$str=file_get_contents("php://input");

	//if(!str) $str=$_POST;	//if not received then fetch via $_POST;
	if(isset($_REQUEST['st'])&&$_REQUEST['st']) $str=$_REQUEST['st'];

	if($str)	//if received string then json decode
	{
		$is_curl_on = false;
		$request	= json_decode($str);
		$str_arr 	= json_decode($str,1);
		
		if(isset($str_arr['encryptedKey']))$encryptedKey=$str_arr['encryptedKey'];
		elseif(isset($request->encryptedKey))$encryptedKey=$request->encryptedKey;
	
		if(isset($str_arr['encryptedData']))$encryptedData=$str_arr['encryptedData'];
		elseif(isset($request->encryptedData))$encryptedData=$request->encryptedData;
	
		//open certificate and fetch private key which use to decrypt response
		$fp= fopen($data['Path'].'/payin/pay69/live_privatekey.key',"r");
		$priv_key=fread($fp,8192);
		fclose($fp);
	
		$res = openssl_get_privatekey($priv_key, "");
		openssl_private_decrypt(base64_decode($encryptedKey), $key, $res);
		$encData = base64_decode($encryptedData); 
		$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
		
		$newsource = substr($encData, 16); 
		
		
		
		//create log file
		//$log = "RESPONSE - ".$raw_response."\n\n";
		$log= "RESPONSE DECRYPTED - ".$newsource."\n\n";
		
		if($qp)
		{
			echo "<br/><br/>Path=>".$data['Path'];
			echo "<br/><br/>key=>".@$key;
			echo "<br/><br/>encryptedKey=>".@$encryptedKey;
			echo "<br/><br/>encryptedData=>".@$encryptedData;
			echo "<br/><br/>encData=>".@$encData;
			
			echo "<br/><br/><br/>str_arr=> "; print_r(@$str_arr);
			echo "<br/><br/><br/>log=> "; echo nl2br(@$log);
			echo "<br/><br/><br/>newsource=> "; print_r(@$newsource);
			if($qp==2)exit;
		}

		$responseParamList = json_decode($newsource,1);		//	decode response
		
		
		
		if(isset($data['status_in_email'])&&$data['status_in_email']==1)
		$data['gateway_push_notify']=$responseParamList;
		
		if(isset($responseParamList['merchantTranId'])&&$responseParamList['merchantTranId'])
		{
			$_REQUEST['transID'] = $responseParamList['merchantTranId'];
			$_REQUEST['actionurl']= 'notify';	//set notify means execute via callback
			$_REQUEST['action']= 'webhook';	//set notify means execute via callback
		}
		
		if(isset($responseParamList['TxnStatus'])&&$responseParamList['TxnStatus'])
		{
			$responseParamList['status']=$responseParamList['TxnStatus'];
		}
		####################
	}
	
	if($qp)
	{
		echo "<br/><br/><br/>responseParamList=> "; print_r(@$responseParamList);
		echo "<br/><br/><br/>REQUEST=> "; print_r(@$_REQUEST);
		echo "<br/><br/><br/>log=> "; echo nl2br(@$log);
		if($qp==3) exit;
	}
		
	########## callback section #############
	
	//include($data['Path'].'/payin/status_top'.$data['iex']);
}



#####	TEMP* for Response check as testing	#########
//include($data['Path'].'/payin/res_insert'.$data['iex']);

//cmn
// for testing than comment this condition 
if(isset($_REQUEST['st2'])&&$_REQUEST['st2'])
{
	if($qp){
		$st2=$_REQUEST['st2'];
		echo "<br/><br/><br/>st2=> "; print_r($st2);
	}

	$responseParamList=[];
	$responseParamList = jsondecode($st2,1,1);	
}
		
if($qp){
	echo "<br/><br/><br/>responseParamList=> "; print_r($responseParamList);
}

//print_r($td);
//print_r($json_value);



$siteid_get['apiKey']		= "w7p24MDT0RjvGdwooQhj6BFArTAuKB78";
$siteid_get['merchantId']	= "1013121";
$siteid_get['terminalId']	= "5411";
$siteid_get['subMerchantId']= "1013121";

if(isset($json_value['apiKey'])) 		$siteid_get['apiKey'] 		= $json_value['apiKey']; 
if(isset($json_value['merchantId'])) 	$siteid_get['merchantId']	= $json_value['merchantId'];
if(isset($json_value['terminalId'])) 	$siteid_get['terminalId']	= $json_value['terminalId'];

//$json_value['requestPost']['merchantId']='';
if(isset($json_value['requestPost']['merchantId'])&&trim($json_value['requestPost']['merchantId'])){ 
	$siteid_get['subMerchantId']= $json_value['requestPost']['merchantId'];
}
else 
{
	
	if(isset($td)&&@$td['merID']&&@$td['terNO']){
		$softpos_db=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}softpos_setting`".
				" WHERE `clientid`='{$td['merID']}' AND `softpos_terNO`='{$td['terNO']}' LIMIT 1",0
			);
		
		$siteid_get['subMerchantId']= $softpos_db[0]['sub_merchantId'];
		
		if($qp){
			echo "<br/><br/>merID=>".$td['merID'];
			echo "<br/><br/>terNO=>".$td['terNO'];
			echo "<br/><br/>subMerchantId softpos=>".$siteid_get['subMerchantId'];
		}
	}
	
}


if(isset($responseParamList['merchantTranId'])&&trim($responseParamList['merchantTranId'])){
	$transID_fetch	= select_tablef(" `transID`='{$responseParamList['merchantTranId']}'",'master_trans_table',0,1,'`transID`,`bill_amt`, `trans_status`');
	
	$_REQUEST['transID']=$transID_fetch['transID'];
	
	if(isset($transID_fetch['transID'])&&trim($transID_fetch['transID'])&&$transID_fetch['transID']==$responseParamList['merchantTranId']){
		$transID=$transID_fetch['transID'];
	}
}


//print_r($siteid_get);
if($qp){
	
	
	echo "<br/><br/>transID=>".$transID;
	
	echo "<br/><br/>siteid_get=>";
	print_r($siteid_get);
}

//new section -- callback for static QR - START
$static_call = false;
if(empty($transID)&&(isset($responseParamList) && count($responseParamList)>0)){
	$merchantId		= $responseParamList['merchantId'];
	$subMerchantId	= $responseParamList['subMerchantId'];
	$terminalId		= $responseParamList['terminalId'];
	$BankRRN		= @$responseParamList['BankRRN'];
	$OriginalBankRRN= @$responseParamList['OriginalBankRRN'];
	$merchantTranId	= $responseParamList['merchantTranId'];
	$PayerAmount	= $responseParamList['PayerAmount'];
	$TxnStatus		= $responseParamList['TxnStatus'];
	$PayerVA		= $responseParamList['PayerVA'];
	$PayerName		= $responseParamList['PayerName'];
	$PayerMobile	= $responseParamList['PayerMobile'];
	$TxnInitDate	= $responseParamList['TxnInitDate'];
	$TxnCompletionDate= $responseParamList['TxnCompletionDate'];

	if($subMerchantId&&$TxnStatus&&strtoupper($TxnStatus)=="SUCCESS")
	{
		$static_call = true;
		if(!isset($host_path)) $host_path=$data['Host'];
		$post['integration-type']=="s2s";
	
		$responseParamList['status']=$TxnStatus;

		$qrcode=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}softpos_setting`".
			" WHERE `sub_merchantId`='{$subMerchantId}' LIMIT 1",0
		);
		
		$merID			= $qrcode[0]['clientid'];
		$softpos_terNO	= $qrcode[0]['softpos_terNO'];
		$acquirer		= $qrcode[0]['acquirer'];
		$currency		= $qrcode[0]['currency'];
		
		
		if(isset($softpos_terNO)&&$softpos_terNO>0&&$merID){
			$business_db=db_rows(
				"SELECT `public_key` FROM `{$data['DbPrefix']}terminal`".
				" WHERE `id`='{$softpos_terNO}' AND `merID`='{$merID}' LIMIT 1",0
			);
		}
		
				
		$postData_url=$data['Host']."/directapi".$data['ex'];
			
		$postData=array();

		$postData["public_key"]=@$business_db[0]['public_key'];;
		$postData["terNO"]=@$softpos_terNO;

		$postData["acquirer_id"]=@$acquirer;
		$postData["upi_address"]=@$PayerVA;
		$postData["integration-type"]="s2s";
		$postData["unique_reference"]='Y'; // skips the duplicate validation 
		
		//$postData["source_url"]=$data['urlpath'];
		$postData["source_url"]=(isset($_SESSION['http_referer'])?$_SESSION['http_referer']:(isset($_SERVER['HTTP_REFERER'])?$_SERVER['HTTP_REFERER']:''));

		$postData["bill_amt"]=@$PayerAmount;
		$postData["bill_currency"]=@$currency;
		$postData["product_name"]=@$qrcode[0]['product_name'];

		$postData["fullname"]=@$PayerName;
		$postData["bill_email"]=@$PayerVA.".com";
		$postData["bill_phone"]=@$PayerMobile;
		$postData["reference"]=@$merchantTranId;
		$postData["API_QR_CREATE"]='PENDING';
		
		if($qp){
			echo "<br/><br/>postData_url=>".$postData_url;
			echo "<br/><br/>postData=><br/>";
			print_r($postData);
		}
		$post_response = use_curl($postData_url, $postData);
		
		$results_post =  json_decode($post_response,true);

		if(!isset($results_post)||isset($results_post['Error'])||!is_array($results_post)){
			
			echo "<br/>post_response=>".$post_response; exit;
		}
		else{
			$_REQUEST['transID']=$_SESSION['tr_newid']=$transID=$results_post['transID'];	
			
			if($qp){
				echo "<br/><br/><br/>creare transID=>".$transID;
				echo "<br/><br/><br/>results_post=>";print_r($results_post);
			}
		}
		
		

		/*
		if(@$currency) $_SESSION['currname']=@$currency;
		else $_SESSION['currname']="INR";

		$_SESSION['terNO']=$softpos_terNO;
		
		//$_SESSION['trans_orderset']=@$merchantTranId;
		$_SESSION['reference']=@$merchantTranId;
		$_SESSION['request_uri']=" Response Status : <b>".@$TxnStatus."</b>";
		
		$post['fullname']=@$PayerMobile;

		
		create_new_trans(
			$merID,					//merID
			$PayerAmount, 		 	//bill_amt
			$acquirer,				//acquirer
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
		*/	
			
		
		if(isset($_SESSION['tr_newid'])&&$_SESSION['tr_newid'])
		{
			
			$_SESSION['transID']=$transID;
			
			$tr_upd_order['response']=$responseParamList;

			if(isset($BankRRN)&&$BankRRN) $tr_upd_order['acquirer_ref']=$BankRRN;
			if(isset($OriginalBankRRN)&&$OriginalBankRRN) $tr_upd_order['rrn']=$OriginalBankRRN;
			if(isset($PayerVA)&&$PayerVA) $tr_upd_order['upa']=$PayerVA;
			
			if(isset($tr_upd_order)&&count($tr_upd_order)>0&&is_array($tr_upd_order))
			trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
			//calculation_tr_fee($_SESSION['tr_newid']);
		}
		echo '200 OK'; //set 200 OK to stop repeat callback
		//exit;
	}
}
//new section -- callback for static QR - END


if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_top'.$data['iex']);
}



if(!empty($transID))
{
	if($bank_acquirer_json_arr&&$is_curl_on){
		
		if(empty($acquirer_status_url)&&$acquirer==69) 
			$acquirer_status_url='https://apibankingone.icicibank.com/api/MerchantAPI/UPI/v0/TransactionStatus3';
		elseif(empty($acquirer_status_url)&&$acquirer==691) 
			$acquirer_status_url='https://apibankingone.icicibank.com/api/MerchantAPI/UPI/v0/TransactionStatus3';
		

		$requestPost = array();
		$requestPost['merchantId']		=isset($siteid_get['subMerchantId'])&&$siteid_get['subMerchantId']?$siteid_get['subMerchantId']:$siteid_get['merchantId'];
		$requestPost['subMerchantId']	=$siteid_get['subMerchantId'];
		$requestPost['terminalId']		=$siteid_get['terminalId'];
		$requestPost['merchantTranId']	=$transID;

		###################
		//open certificate and fetch public key which use to encrypt requestPost
		$fp = fopen($data['Path'].'/payin/pay69/PubliccerEazypayservices.crt', 'r');
		
		$pub_key= fread($fp, 8192);
		fclose($fp);
		
		$RANDOMNO1 = "1221331212344838";
		$RANDOMNO2 = '1234562278901456';
		
		openssl_get_publickey($pub_key);
		
		openssl_public_encrypt($RANDOMNO1, $encrypted_key, $pub_key);
		$encrypted_data = openssl_encrypt(json_encode($requestPost), 'AES-128-CBC', $RANDOMNO1, OPENSSL_RAW_DATA, $RANDOMNO2);
		
		$postbody= [
			"requestId" => $transID,
			"service" => "",
			"encryptedKey" => base64_encode($encrypted_key),
			"oaepHashingAlgorithm" => "NONE",
			"iv" => base64_encode($RANDOMNO2),
			"encryptedData" => base64_encode($encrypted_data),
			"clientInfo" => "",
			"optionalParam" => ""
		];
		
		$headers = array(
			"content-type: application/json", 
			"apikey:".$siteid_get['apiKey']
		);
		
		$file = 'composite_log.txt';
		
		//echo "<br/><br/>subMerchantId 3=>".$siteid_get['subMerchantId'];
			
		$url = $acquirer_status_url.'/'.$siteid_get['merchantId'];
		//$url = $acquirer_status_url.'/'.$siteid_get['subMerchantId'];
		
		$log = "\n\nGUID - ".$transID."===============================\n";
		$log.= 'URL - '.$url."\n\n";
		$log.= 'HEADER - '.json_encode($headers)."\n\n";
		$log.= 'REQUEST - '.json_encode($requestPost)."\n\n";
		$log.= 'REQUEST ENCRYPTED - '.json_encode($postbody)."\n\n";
		
		//file_put_contents($file, $log, FILE_APPEND | LOCK_EX);
		
		$curl = curl_init($url);
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($postbody));
		
		$raw_response = curl_exec($curl);
		$httpcode	= curl_getinfo($curl, CURLINFO_HTTP_CODE);
		$err		= curl_error($curl);
		curl_close($curl);
		
		$request = json_decode($raw_response);
	
		//open certificate and fetch private key which use to decrypt response
		$fp= fopen($data['Path'].'/payin/pay69/live_privatekey.key',"r");
		$priv_key=fread($fp,8192);
		fclose($fp);
	
		$res = openssl_get_privatekey($priv_key, "");
		openssl_private_decrypt(base64_decode($request->encryptedKey), $key, $res);
		$encData = base64_decode($request->encryptedData); 
		$encData = openssl_decrypt($encData,"aes-128-cbc",$key,OPENSSL_PKCS1_PADDING);
		
		$newsource = substr($encData, 16); 
		
		$log.= "\n\nGUID - ".$transID."================================\n";
		$log.= "RESPONSE - ".$raw_response."\n\n";
		$log.= "RESPONSE DECRYPTED - ".$newsource."\n\n";
		
		if($qp)
		{
			echo nl2br($log);
			exit;
		}
		$responseParamList = json_decode($newsource,1);
		####################
	}
	$results = $responseParamList;

	if (isset($responseParamList) && count($responseParamList)>0)
	{
		
		
		
		$OriginalBankRRN=@$responseParamList['OriginalBankRRN'];
		$BankRRN=@$responseParamList['BankRRN'];
		
		
		
		if(isset($responseParamList['BankRRN'])&&$responseParamList['BankRRN'])
			$OriginalBankRRN=$responseParamList['BankRRN'];
		
		if(isset($responseParamList['PayerVA'])&&$responseParamList['PayerVA'])
			$PayerVA=$responseParamList['PayerVA'];
		
		
		
		if(isset($BankRRN)&&$BankRRN&&(empty($td['acquirer_ref']) || $td['acquirer_ref']!=$BankRRN )) 
			$tr_upd_order['acquirer_ref']=$BankRRN;
		
		if(isset($OriginalBankRRN)&&$OriginalBankRRN&&(empty($td['rrn']) || $td['rrn']!=$OriginalBankRRN )) 
			$tr_upd_order['rrn']=$OriginalBankRRN;
		
		if(isset($PayerVA)&&$PayerVA&&(empty($td['upa']) || $td['upa']!=$PayerVA )) 
			$tr_upd_order['upa']=$PayerVA;
		
		if(isset($tr_upd_order)&&count($tr_upd_order)>0&&is_array($tr_upd_order))
		trans_updatesf($td['id'], $tr_upd_order);
		
		
		
		$message= "";
		$status	= "";
		if(isset($responseParamList['success']))	$success= $responseParamList['success'];
		if(isset($responseParamList['status']))		$status = $responseParamList['status'];
		if(isset($responseParamList['message']))	$message= $responseParamList['message'];
		
		if(isset($responseParamList['Amount']))	$_SESSION['responseAmount'] = $responseParamList['Amount'];
		elseif(isset($responseParamList['PayerAmount']))	$_SESSION['responseAmount'] = $responseParamList['PayerAmount'];

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$responseParamList;

		if(strtoupper($status)=='SUCCESS'){ //success
			$_SESSION['acquirer_response']=$message." - Success";
			$_SESSION['acquirer_status_code']=2;
		}
		elseif(strtoupper($status)=='FAILURE'||strtoupper($status)=='FAIL'){	//failed
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

			$data_tdate=date('YmdHis', strtotime($td['tdate']));
			$current_date_1h=date('YmdHis', strtotime("-1 hours"));
			if(($data_tdate<$current_date_1h)&&($data['localhosts']==false)){
				$_SESSION['acquirer_status_code']=-1;
				$_SESSION['acquirer_response']=$message." - Cancelled"; 
			}
		}
	}
}

if($qp){
	echo "<br/><br/><br/>responseParamList=> "; print_r($responseParamList);
	echo "<br/><br/><br/>td=> "; print_r($td);
}

//exit;

#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>