<?
// Dev Tech : 24-03-20  41 - lonapay24 - Lunapay  Acquirer 

if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2)
{
	$post['ccno']='4538977399606732';
	$post['month']='12';
	$post['year4']='2099';
	$post['ccvv']='123';
	
	$post['country_two']='US';

}

if($data['localhosts']==true) 
{
	$webhookhandler_url='https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify';

}

	
	//$post['month']=(int)$post['month']; $post['year4']=(int)$post['year4'];


	############################################################

	$postRequest=[];
	$postRequest['card_printed_name']=@$post['fullname'];
	$postRequest['credit_card_number']=@$post['ccno'];
	$postRequest['expire_year']=@$post['year4'];
	$postRequest['expire_month']=@$post['month'];
	$postRequest['cvv2']=@$post['ccvv'];
	$postRequest['client_orderid']=@$transID;
	$postRequest['order_desc']='Order for '.@$transID;
	$postRequest['first_name']=@$post['ccholder'];
	$postRequest['last_name']=@$post['ccholder_lname'];
		//$postRequest['ssn']='1267';
		//$postRequest['birthday']='19820115';
	$postRequest['address1']=@$post['bill_address'];
	$postRequest['city']=@$post['bill_city'];
	$postRequest['state']=@$post['bill_state'];
	$postRequest['zip_code']=@$post['bill_zip'];
	$postRequest['country']=@$post['country_two'];
	$postRequest['phone']=@$post['bill_phone'];
	$postRequest['cell_phone']=@$post['bill_phone'];
	$postRequest['amount']=@$total_payment;
	$postRequest['email']=@$post['bill_email'];
	$postRequest['currency']=@$orderCurrency;
	$postRequest['ipaddress']=@$_SESSION['bill_ip'];
	//$postRequest['site_url']='www.google.com';
		//$postRequest['purpose']='newpurpose';
	$postRequest['redirect_url']=@$status_default_url;
	$postRequest['server_callback_url']=@$webhookhandler_url;

		//$postRequest['merchant_data']='VIP customer';
		//$postRequest['dapi_imei']='123';


	############################################################
	
	// {"endpoint_group_id":"2545","login_id":"CogentPayments_LP","control_key":"1B962E87-86C5-4863-90B2-FB58D8721717"}
	
	//will send control from here which is the field in request  will generate signature

	$postreq['endpointid'] = @$apc_get['endpoint_group_id']; //"2545";
	$postreq['amount'] = (double)$postRequest['amount'] * 100;
	$postreq['merchant_control']=@$apc_get['control_key']; //"1B962E87-86C5-4863-90B2-FB58D8721717";
	$str = $postreq['endpointid'].''.$postRequest['client_orderid'].''.$postreq['amount'].''.$postRequest['email'].''.$postreq['merchant_control'];
	
	if($data['cqp']>0) echo "<br/>sha1 str=>".$str;
	
	$checksum = sha1($str);

	if($data['cqp']>0) echo "<br/>sha1 checksum=>".$checksum;

	############################################################

	$postRequest['control']=$checksum;

	$postRequestStr=http_build_query($postRequest);

	$curl_bank_url=$bank_url.'/'.$postreq['endpointid'];

	$curl = curl_init();
	curl_setopt_array($curl, array(
		CURLOPT_URL => $curl_bank_url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_HEADER => 0,
		CURLOPT_SSL_VERIFYPEER => 0,
		CURLOPT_SSL_VERIFYHOST => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS => $postRequestStr,
		CURLOPT_HTTPHEADER => array(
			'Content-Type: application/x-www-form-urlencoded'
		),
	));



	$response = curl_exec($curl);

	curl_close($curl);

	$res='https://view?'.$response;

	$res=urldecodef($res);
	
	//remove tab and new line from json encode value 
	//$res = preg_replace('~[\r\n\t]+~', '', $res);
	//$res = str_ireplace(["n&"," &"], '&', $res);

	parse_str(parse_url($res, PHP_URL_QUERY), $results);

	//acquirer response stage1 save via encode encode64f
	db_trf($_SESSION['tr_newid'], 'acquirer_response_stage1', $results);

	//$results = json_decode($response,true);
	//if(isset($results)&&is_array($results)) $results=sqInArray($results);


	if($data['cqp']>0) 
	{
		echo "<br/>curl_bank_url=> ".$curl_bank_url;
		echo "<br/><br/>postRequestStr=> ".$postRequestStr;

		echo  "<br/><br/>response=>".$response;

		//type=async-response &serial-number=00000000-0000-0000-0000-0000043b64ff &merchant-order-id=902B4FF56 &paynet-order-id=1969106 &end-point-id=12246

		echo  "<br/><br/>results=>";

		print_r($results);

		echo "<br/>paynet-order-id=>".$results['paynet-order-id'];
	}


	############################################################
	
	
	

	$post_data=$postRequest;
	//unset card details 
	
	if($data['localhosts']==true) {

	}
	else 
	{
		if(isset($post_data['credit_card_number'])) unset($post_data['credit_card_number']);
		if(isset($post_data['expire_year'])) unset($post_data['expire_year']);
		if(isset($post_data['expire_month'])) unset($post_data['expire_month']);
		if(isset($post_data['cvv2'])) unset($post_data['cvv2']);
	}
	
	
	$tr_upd_order1=array();
	if(isset($results["paynet-order-id"])&&$results["paynet-order-id"])  $tr_upd_order1['acquirer_ref']=$results["paynet-order-id"];
	$tr_upd_order1['bank_url']=$curl_bank_url;
	$tr_upd_order1['post_data']=$post_data;
	$tr_upd_order1['response']=$response;
	$tr_upd_order1['responseParamList']=isset($results)&&$results?$results:htmlentitiesf($response);
	//$curl_values_arr['browserOsInfo']=$browserOs;
	

	if(isset($results['error-message'])){ // error to failed 
		$_SESSION['acquirer_response']=@$results['error-message'];
		$_SESSION['acquirer_status_code']=-1;
		$json_arr_set['realtime_response_url']=$trans_processing;

	}
	else {
		$tr_upd_order1['pay_mode']='3D';
		//$auth_3ds2_secure=@$reprocess_url;
		$auth_3ds2_secure=@$status_default_url;
		$auth_3ds2_action='redirect';
	}
	
	
	// Check error 
	/*
	if(isset($results["errors"][0])) 
			$error_description = implode(' | ', $results["errors"][0]);
	elseif(isset($results["result"]["errors"])) 
			$error_description = implode(' | ', $results["result"]["errors"]);
	elseif(isset($results["result"]["description"]) && trim($results["result"]["description"]) && strpos(strtolower($results["result"]["description"]),'error')!==false) 
			$error_description = $results["result"]["description"];
	elseif(isset($results["state"]) && trim($results["state"]) && in_array($results["state"],["declined"])) 
			$error_description = $results["result"]["code"].' | '.$results["result"]["description"];
	else $error_description = '';
	
	*/
	
	if($data['cqp']==9)
	{
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
		echo "<br/><br/>bank_url=> "; print_r($curl_bank_url);
		echo "<br/><br/>curlPost Encode=> ".json_encode($postRequest);
		echo "<br/><br/>curlPost=> "; print_r($postRequest);
		echo "<br/><br/>results=> "; print_r($results);
		echo "<br/><br/>response=> "; print_r($response);
		echo "<br/><br/>error_description=> "; print_r($error_description);
		exit;
	}
	
		
	if(isset($error_description) && !empty(trim($error_description)))
	{
		$_SESSION['acquirer_response']=$error_description;
		$tr_upd_order1['error']=$error_description;
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		echo 'Error for '.@$error_description;exit; 
	}

	
	$tr_upd_order_111=$tr_upd_order1;
	//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
?>