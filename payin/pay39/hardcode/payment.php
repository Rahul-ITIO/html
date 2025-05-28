<?php

// http://localhost/gw/payin/pay39/hardcode/payment.php

//if (!defined('BASEPATH'))
    //exit('No direct script access allowed');

$acquirer3DURL="";



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


  
	
	$merNo = '800086558';
	$signKey = '821802da8f12442badffb1ab2d0ccc48';
	$orderNo = '39'.(new DateTime())->format('ymdHisu');
	$orderAmount = '8.50';
	$orderCurrency = 'USD';
	$cardNo = '4047457514066090';
	
	
	$cardExpireYear = '2026';
	$cardExpireMonth = '06';
	$cardSecurityCode = '999';
	
	
	
	$payIP='110.140.129.211';
	$transType='sales';
	$transModel='M';
	$str = 'EncryptionMode=SHA256&CharacterSet=UTF8&merNo='.$merNo.'&orderNo='.$orderNo.'&currencyCode='.$orderCurrency.'&amount='.$orderAmount.'&payIP='.$payIP.'&transType='.$transType.'&transModel='.$transModel.'&'.$signKey;

	$signInfo = hash('sha256',$str);
	$postData = array (
		'merNo'            => $merNo,
		'CharacterSet'     => 'UTF8',
		'transType'        => $transType,
		'transModel'       => $transModel,
		'apiType'          => '1',
		'amount'           => $orderAmount,
		'currencyCode'     => $orderCurrency,
		'orderNo'          => $orderNo,
		'merremark'        => 'test',
		'returnURL'        => 'https://webhook.site/63a5acb6-61f6-4554-87be-4b73c8b9e79a?action=returnURL',
		'merNotifyURL'     => 'https://webhook.site/63a5acb6-61f6-4554-87be-4b73c8b9e79a',
		'merMgrURL'        => 'www.test01.com',
		'webInfo'          => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36',
		'language'         => 'En',
		'cardCountry'      => 'US',
		'cardState'        => 'Massachusetts',
		'cardCity'         => 'North Attleboro',
		'cardAddress'      => '690 High Street',
		'cardZipCode'      => '01001',
		'payIP'            => $payIP,
		'cardFullName'     => 'jodom.tom',
		'cardFullPhone'    => '8855996666',
		'grCountry'        => 'US',
		'grState'          => 'Massachusetts',
		'grCity'           => 'North Attleboro',
		'grAddress'        => '690 High Street',
		'grZipCode'        => '01001',
		'grEmail'          => 'devops+'.date('s').'@itio.in',
		'grphoneNumber'    => '8855996666',
		'grPerName'        => 'jodom.tom',
		'goodsString'      => '{"goodsInfo":[{"goodsName":"bag","quantity":"1","goodsPrice":"1.01"},{"goodsName":"bag","quantity":"1","goodsPrice":"1.01"}]}',
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
	
	
	$returnData  = http_post("https://payment.bestorepay.com/payment/api/payment",$params);   
	$result      = json_decode($returnData,true);
	
	echo "<pre>";
	///print_r($result);

	$acquirer3DURL=@$result['skipTo3DURL'];
   
	   
		//print_r('url:'.$acquirer3DURL);
	$respCode = $result['respCode'];
	$respMsg = $result['respMsg'];
	if('00'==$respCode){
		echo "SUCCESS\n";
		echo "return result: ";
		print_r($result);
		die;
	}else if('01'==$respCode){
		if('pending_async'==$respMsg && !empty($acquirer3DURL)){
			echo "During payment processing, jump to the 3D verification page\n";
			echo "<script LANGUAGE='Javascript'>";
			echo "location.href='".$acquirer3DURL."'";
			echo "</script>";
			die;
		}else{
			print_r("payment failed\n");
			print_r("return result: ");
			print_r($result);
		}
	}else{
		echo "payment failed\n";
		echo "return result: ";
		print_r($result);
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
