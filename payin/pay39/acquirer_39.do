<?php
if($data['cqp']>0){
	error_reporting(E_ALL); // check all type of errors
	ini_set('display_errors', 1); // display those errors
	ini_set('log_errors ', 1); // display those errors
	ini_set('error_log ', 1); // display those errors
}

//$acquirer3DURL="";

#############################################################################

    function array2String($arr){
		$str = '';
		$arr_length = count($arr)-1;
		foreach( $arr as $key => $value ){
			$str.=$key.'='.$value.'&';
		}
		return urldecode($str);

	}
	
	function http_post($payUrl, $postData) {
        $webSite = empty ( $_SERVER ['HTTP_REFERER'] ) ? $_SERVER ['HTTP_HOST'] : $_SERVER ['HTTP_REFERER'];
        $options = array (
           'http' => array (
                'method'  => "POST",
                'header'  => "Accept-language:en\r\n"."Content-type:application/x-www-form-urlencoded\r\n".
                             "Content-Length:".strlen($postData)."\r\n"."referer:".$webSite."\r\n",
                'content' => $postData, 
                'timeout' => 90 
            ) 
        ); 
        $context = stream_context_create($options);
        return file_get_contents($payUrl, false, $context);
    }
	
#############################################################################
	
	//{"MerchantID":"800086558","SecurityCode":"821802da8f12442badffb1ab2d0ccc48","merMgrURL":"www.test01.com"}
  
	
	//MerchantID or merNo
	if(isset($apc_get['MerchantID'])&&trim($apc_get['MerchantID'])) $merNo = @$apc_get['MerchantID']; //'800086558';
	elseif(isset($apc_get['merNo'])&&trim($apc_get['merNo'])) $merNo = @$apc_get['merNo']; 
	
	//SecurityCode or hash
	if(isset($apc_get['SecurityCode'])&&trim($apc_get['SecurityCode'])) $signKey = @$apc_get['SecurityCode']; //'821802da8f12442badffb1ab2d0ccc48';
	elseif(isset($apc_get['hash'])&&trim($apc_get['hash'])) $signKey = @$apc_get['hash']; 
	
	//merMgrURL
	if(isset($apc_get['merMgrURL'])&&trim($apc_get['merMgrURL'])) $merMgrURL = @$apc_get['merMgrURL']; //'www.test01.com';
	
	if($apc_get['mode']=='live')
		$merremark='live';
	else $merremark='test';
	
	$fullname=$post['ccholder'].".".$post['ccholder_lname'];
	
		
	$_SESSION['product'] = str_ireplace(array(':','?','/','%','|'),'',$_SESSION['product']);
	$_SESSION['product'] = substr($_SESSION['product'], 0, 45);
	$_SESSION['product'] = preg_replace("/[^A-Za-z0-9 ]/", '', strip_tags($_SESSION['product']));

	$goods='{"goodsInfo":[{"goodsName":"'.$_SESSION['product'].'","goodsPrice":"'.$total_payment.'","quantity":"1"}]}';

	$orderNo = @$transID;
	
	$orderAmount = $total_payment;
	$orderCurrency = @$orderCurrency;
	$cardNo = @$post['ccno'];
	
	
	$cardExpireYear = @$post['year4'];
	$cardExpireMonth = @$post['month'];
	$cardSecurityCode = @$post['ccvv'];
	
	
	
	if($data['localhosts']==true) $payIP='110.140.129.211';
	else $payIP=@$_SESSION['bill_ip'];
	
	$transType='sales';
	$transModel='M';
	$str = 'EncryptionMode=SHA256&CharacterSet=UTF8&merNo='.$merNo.'&orderNo='.$orderNo.'&currencyCode='.$orderCurrency.'&amount='.$orderAmount.'&payIP='.$payIP.'&transType='.$transType.'&transModel='.$transModel.'&'.$signKey;

	$signInfo = hash('sha256',$str);
	$postData = array (
		'merNo'            => @$merNo,
		'CharacterSet'     => 'UTF8',
		'transType'        => @$transType,
		'transModel'       => @$transModel,
		'apiType'          => '1',
		'amount'           => @$orderAmount,
		'currencyCode'     => @$orderCurrency,
		'orderNo'          => @$orderNo,
		'merremark'        => @$merremark,
		'returnURL'        => @$status_url_1,
		'merNotifyURL'     => @$webhookhandler_url,
		'merMgrURL'        => $merMgrURL,
		'webInfo'          => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36',
		'language'         => 'En',
		'cardCountry'      => @$post['country_two'],
		'cardState'        => @$post['bill_state'],
		'cardCity'         => @$post['bill_city'],
		'cardAddress'      => @$post['bill_address'],
		'cardZipCode'      => @$post['bill_zip'],
		'payIP'            => @$payIP,
		'cardFullName'     => @$fullname,
		'cardFullPhone'    => @$post['bill_phone'],
		'grCountry'        => @$post['country_two'],
		'grState'          => @$post['bill_state'],
		'grCity'           => @$post['bill_city'],
		'grAddress'        => @$post['bill_address'],
		'grZipCode'        => @$post['bill_zip'],
		'grEmail'          => @$post['bill_email'],
		'grphoneNumber'    => @$post['bill_phone'],
		'grPerName'        => @$fullname,
		'goodsString'      => @$goods,
		'hashcode'         => $signInfo,
		'cardNO'           => $cardNo,
		'cvv'              => $cardSecurityCode,
		'expMonth'         => $cardExpireMonth,
		'expYear'          => $cardExpireYear
	);
	
	// echo "<pre>";
	// print_r($postData);
	// die;
	$params = array2String($postData);
	//print_r($params);
	
	

	
	if($data['localhosts']==true) $returnData  = '{"transType":"sales","orderNo":"392008723","merNo":"800086558","terNo":null,"currencyCode":"USD","amount":"7.01","tradeNo":"3817104023841993","hashcode":"2e7db0aee2b04d263143fe326d82a9694db81277a51d7b6ecc1976ec41617d34","respCode":"00","respMsg":"TEST SUCCESS","acquirer":"test","settleCurrency":"USD","settleAmount":"7.01","skipTo3DURL":null,"merNotifyURL":null}';

	else $returnData  = http_post($bank_url,$params);	
	
	$result      = json_decode($returnData,true);
	
	
	$postRequest=$postData;
	
	if(isset($postRequest['cardNO'])) unset($postRequest['cardNO']);
	if(isset($postRequest['cvv'])) unset($postRequest['cvv']);
	if(isset($postRequest['expMonth'])) unset($postRequest['expMonth']);
	if(isset($postRequest['expYear'])) unset($postRequest['expYear']);
	
	$tr_upd_order['postRequest']   = $postRequest;
	
	//update response
	$tr_upd_order['response_time']   = (new DateTime())->format('Y-m-d H:i:s.u');
	
	$tr_upd_order['response']  = ((isset($result)&&is_array($result))? htmlTagsInArray($result) : stf($result));

	if(isset($result['tradeNo'])&&@$result['tradeNo'])
	$tr_upd_order['acquirer_ref']   = @$result['tradeNo'];
	
	if(isset($result['acquirer'])&&$result['acquirer'])
		$tr_upd_order['descriptor']=$result['acquirer'];
	
	
	trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
		
	if($data['cqp']>0) 
	{
		echo "<pre>";
		print_r($result);
	}



	$acquirer3DURL=@$result['skipTo3DURL'];
	
	   
	//print_r('url:'.$acquirer3DURL);
	$respCode = @$result['respCode'];
	$respMsg = @$result['respMsg'];
	
	
$_SESSION['acquirer_action']=1;
$_SESSION['acquirer_response']=@$result['respMsg'];
$_SESSION['acquirer_status_code']=@$result['respCode'];
$_SESSION['acquirer_transaction_id']=@$result['tradeNo'];
$_SESSION['acquirer_descriptor']=@$result['acquirer'];

//$_SESSION['curl_values']=$curl_values_arr;
	
$json_arr_set['check_acquirer_status_in_realtime']='f';
	
	
	if('00'==$respCode){ //success
		$_SESSION['acquirer_status_code']=2;
		//$process_url = $return_url; 
		$json_arr_set['realtime_response_url']=$trans_processing;
		//$json_arr_set['realtime_response_url']=$return_url;
		
		$tr_upd_order_111['response_step']='1.Success'.@$respCode;
		
		if($data['cqp']>0){
			echo "SUCCESS\n";
			echo "return result: ";
			print_r($result);
		}
		
		if($data['cqp']==9) die;
		
	}else if('01'==$respCode){
		if('pending_async'==$respMsg && !empty($acquirer3DURL)){ // 3d url
			$_SESSION['acquirer_status_code']=1;
			$json_arr_set['realtime_response_url']=$trans_processing;
			
			$tr_upd_order['pay_mode']='3D';
			$auth_3ds2_secure=$acquirer3DURL;
			$auth_3ds2_action='redirect';
			
			$tr_upd_order_111['response_step']='2.acquirer3DURL'.@$respCode.@$acquirer3DURL;
			
			
			if($data['cqp']>0){
				$tr_upd_order_111['response_step']='2.1.acquirer3DURL is failed'.@$respCode.@$acquirer3DURL;
					
				echo "During payment processing, jump to the 3D verification page\n";
				echo "<script LANGUAGE='Javascript'>";
				echo "location.href='".$acquirer3DURL."'";
				echo "</script>";
			}
			if($data['cqp']==9) die;
		}else{ //failed
			$_SESSION['acquirer_status_code']=-1;
			$json_arr_set['realtime_response_url']=$trans_processing;
			
			$tr_upd_order_111['response_step']='3 failed'.@$respCode;
			
			if($data['cqp']>0){
				print_r("payment failed\n");
				print_r("return result: ");
				print_r($result);
			}
		}
	}else{ //failed or other
		
		$_SESSION['acquirer_status_code']=-1;
		//$process_url = $return_url; 
		$json_arr_set['realtime_response_url']=$trans_processing;
		
		$tr_upd_order_111['response_step']='4 failed other'.@$respCode;
		
		if($data['cqp']>0){
			echo "payment failed\n";
			echo "return result: ";
			print_r($result);
		}
	}




/*


SUCCESS
return result: Array
(
    [transType] => sales
    [orderNo] => 39240314102249385685
    [merNo] => 800086558
    [terNo] => 
    [currencyCode] => USD
    [amount] => 7.50
    [tradeNo] => 8717103919695101
    [hashcode] => 35f9bcb3e5825fa64124ee6d8f26117ef3162f114a91a840c26e985ca612b380
    [respCode] => 00
    [respMsg] => TEST SUCCESS
    [acquirer] => test
    [settleCurrency] => USD
    [settleAmount] => 7.50
    [skipTo3DURL] => 
    [merNotifyURL] => 
)
 
 ------------------------------------------------------
 
 payment failed
return result: Array
(
    [transType] => sales
    [orderNo] => 1710390875
    [merNo] => 800086558
    [terNo] => 
    [currencyCode] => USD
    [amount] => 6.50
    [tradeNo] => 1517103908753732
    [hashcode] => 37b10b240e60980825ad76831a6b1975b71637ac491b7694a94cacbbdb6b39f0
    [respCode] => 01
    [respMsg] => TEST FAILED
    [acquirer] => test
    [settleCurrency] => USD
    [settleAmount] => 6.50
    [skipTo3DURL] => 
    [merNotifyURL] => 
)




*/

?>
