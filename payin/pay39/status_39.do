<?
//$_REQUEST['pq']=1;

//status 39 
$data['NO_SALT']=true;

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

$orderNo=@$_REQUEST['transID'];

if((isset($_REQUEST['orderNo'])&&$_REQUEST['orderNo']))
{	
	$orderNo=$_REQUEST['transID']=$_REQUEST['orderNo'];
	
}


#####	TEMP* for email response as testing	#########
if((isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='notify')||(isset($_REQUEST['action'])&&$_REQUEST['action']=='notify'))
{	
	/*
	$data['ordersetExit']=1;
	$data['status_in_email']=1;
	$data['devEmail']='arun@bigit.io';
	*/
	
}


$is_curl_on = true;


if((isset($_REQUEST['respCode']))&&(!empty($_REQUEST['respCode']))){
	$_REQUEST['action']='webhook';
	$is_curl_on = false;
	$response_decode=$_REQUEST;
	
	/*
	$data['ordersetExit']=1;
	$data['status_in_email']=1;
	$data['devEmail']='arun@bigit.io';
	*/
	
}
	
	
if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	include($data['Path'].'/payin/status_top'.$data['iex']);
}

$data['pq']=@$qp;

#####	TEMP* for Response check as testing	#########
if(!isset($_SESSION['adm_login']))
{
	//include($data['Path'].'/payin/res_insert'.$data['iex']);
}


$apiInfo=@$json_value['response'];
if($qp){
	echo "<hr>response=><br />";
	print_r($apiInfo);
}

$merNo=$apc_set['merNo']=@$apc_get['MerchantID'];
$orderNo=$apc_set['orderNo']=@$apiInfo['orderNo'];
$tradeNo=$apc_set['tradeNo']=@$apiInfo['tradeNo'];
$amount=$apc_set['amount']=@$apiInfo['amount'];
$currency=$apc_set['currency']=@$apiInfo['currencyCode'];
$hashcode=$apc_set['hashcode']=@$apc_get['SecurityCode'];

//$orderNo=$json_value['data_'.$td['acquirer']]['orderNo'];



/*
$amount=$td['bill_amt'];
$currency=$td['bill_currency'];

if($td['bank_processing_curr']){
	$currency=$td['bank_processing_curr'];
}
if($td['bank_processing_amount']){
	$amount=$td['bank_processing_amount'];
}
*/


############################################

$b_br_failed='';

	if($is_curl_on==true)	//if check status direct via admin or realtime response
	{
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) 
			$acquirer_status_url="https://payment.bestorpay.com/payment/external/query";
		
		if($qp)
		{
			echo "<br/>acquirer_status_url=>".$acquirer_status_url;
		}
		
		

	// for gateway
		if($td['acquirer_ref']){
			//$tradeNo=$td['acquirer_ref'];
		}
		
		//sha256(merNo+orderNo+amount+currency+4e3870716b3e4e939dcc254bce0ce34)

		$hash_code=hash("sha256",$merNo.$orderNo.$amount.$currency.$hashcode);
		
		$signature_data="merNo=".$merNo."&orderNo=".$orderNo."&tradeNo=".$tradeNo."&amount=".$amount."&currency=".$currency."&signature=".$hash_code;
		
		
		
		if($qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background: #fff2d4;color:#2c2c2c;padding:5px 10px;border-radius:2px;margin:10px auto;width:fit-content;display:block;max-width:99%;">';
			
			echo "<hr/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<hr/>hash_code=> ".$hash_code;
			echo "<hr/>signature_data=> ";
			print_r(@$signature_data);
			echo "<hr/>apc_set=> ";print_r($apc_set);
			
			echo '<br/><br/></div>';
		}
		


		if(isset($apc_set['hashcode']))
			unset($apc_set['hashcode']);

		$apc_set['signature']=$hash_code;
		$signature_data=@$apc_set;

		$signature_data=http_build_query($signature_data);

		
		function http_post($payUrl, $postData) {
			$webSite = empty ( $_SERVER ['HTTP_REFERER'] ) ? $_SERVER ['HTTP_HOST'] : $_SERVER ['HTTP_REFERER'];
			$options = array (
			   'http' => array (
					'method'  => "POST",
					'header'  => "Accept-language:en\r\n"."Content-type:application/x-www-form-urlencoded\r\n".
								 "Content-Length:".strlen($postData)."\r\n",
					'content' => $postData, 
					'timeout' => 90 
				) 
			); 
			$context = stream_context_create($options);
			return file_get_contents($payUrl, false, $context);
		}
		
	//	$response  = http_post($acquirer_status_url,$signature_data);
		
		
		
		$ch = curl_init();
		curl_setopt($ch,CURLOPT_URL, $acquirer_status_url);
		curl_setopt($ch,CURLOPT_HEADER, 0);
		curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);

			curl_setopt($ch,CURLOPT_CUSTOMREQUEST,'POST');
			curl_setopt($ch,CURLOPT_FOLLOWLOCATION,1);
			curl_setopt($ch,CURLOPT_ENCODING,'');
			curl_setopt($ch,CURLOPT_MAXREDIRS,10);
		
		//curl_setopt($ch,CURLOPT_POST,1);
		curl_setopt($ch,CURLOPT_POSTFIELDS,$signature_data);

		curl_setopt($ch,CURLOPT_SSL_VERIFYPEER, false); 
		curl_setopt($ch,CURLOPT_SSL_VERIFYHOST, false);
		//curl_setopt($ch,CURLOPT_HTTPHEADER, ['Content-Type: application/x-www-form-urlencoded']); 
		$response = curl_exec($ch);

		$http_status	= curl_getinfo($ch, CURLINFO_HTTP_CODE);	//received curl response in code
		$curl_errno		= curl_errno($ch);	//received curl error in code


		if ( ( $http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404 ) && (!isset($data_send['cron_tab']) ) ) {
			$err_5001=[];
			$err_5001['Error']="5001";
			$err_5001['Message']="HTTP Status is {$http_status} and returned ".$curl_errno;
			//json_print($err_5001);
			echo "<br/><hr/><b>err_5001=></b><br/>";print_r($err_5001 );
		}
		elseif($curl_errno){	//check and print error with code
			$err_5002=[];
			$err_5002['Error']="5002";
			$err_5002['Message']="HTTP Status is {$http_status} and Request Error ".curl_error($ch);
			//json_print($err_5002);

			echo "<br/><hr/><b>err_5002=></b><br/>";print_r($err_5002 );
		}
		
		curl_close($ch);
		
	
		
		//process $response
		$response_decode = json_decode($response,true);
		
	
	}
	
	
		if(is_array($response_decode))
		$results= $response_decode;
			
		else{
			$_SESSION['acquirer_response']="Pending";
			$results['Error']="Request too often! Try again later.";
		}	
		
		if($data['pq'])
		{
			echo "<hr/>response=>".$response;
			echo "<hr/>response_decode=>";print_r($response_decode );
			echo "<hr/>signature_data post=>";print_r($signature_data );
			//exit;
		}

		

		
	if(isset($response_decode))
	{

		$respCode=jsonvaluef($response,'respCode');
		if($data['pq']&&$respCode)
		{
			$response_decode['respCode']=$respCode;
			$response_decode['respMsg']=jsonvaluef($response,'respMsg');
			$response_decode['tradeNo']=jsonvaluef($response,'tradeNo');
		}
	
	
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$response_decode['respMsg'];
		$_SESSION['acquirer_status_code']=$response_decode['respCode'];
		$_SESSION['acquirer_transaction_id']=$response_decode['tradeNo'];
		$_SESSION['acquirer_descriptor']=$response_decode['acquirer'];
		//$_SESSION['acquirer_descriptor']="Webtransact";
		$_SESSION['curl_values']=$response;
		
		$errorCode=@$response_decode['errorCode'];
		
		if(isset($response_decode['amount'])&&$response_decode['amount'])
				$_SESSION['responseAmount']	= $response_decode['amount'];
			
			
			
			$data_status= array(
				'merNotifyStatus'=>'1',
			);
			
			
		$line_step="";	
		
		//echo "<hr/>order_status=>".$_SESSION['acquirer_status_code'];
		if($_SESSION['acquirer_status_code']=="00"){ //success
			$_SESSION['acquirer_status_code']=2;
			$status_completed=true;
			$_SESSION['acquirer_response']="Success";

			//$line_step="1_success";	
			
			if(!isset($_SESSION['adm_login'])) echo json_encode($data_status);
		}
		
		elseif( (($_SESSION['acquirer_status_code']=="01"||$response_decode['respCode']=='1500'|| ( preg_match("/(Do not honour|card type unsupported|Excess single payment)/i", $response_decode['respMsg']) )  )&&(strtolower($response_decode['respMsg'])!="pending")) || (($b_br_failed)&&(strpos($b_br_failed,$response_decode['respMsg'])!==false)) || (@$errorCode=='0001') ){ //failed or other
			
			
						$line_step="2_failed";	

			if( (isset($response_decode['respMsg'])) && ( (strpos($response_decode['respMsg'],'Order Timeout')!==false) || (in_array($response_decode['respMsg'],["pending_async"])) )){
				$_SESSION['acquirer_response']=$response_decode['respMsg']." - Pending";
				$status_completed=false;
				$_SESSION['acquirer_status_code']=1;
						$line_step="3_failed_pending_async"; 
			}else{
				$_SESSION['acquirer_response']=$response_decode['respMsg']."Cancelled";
				$_SESSION['acquirer_status_code']=-1;
				$line_step="4_failed_Cancelled";
			}
			
			
			if($data['pq']){
				echo "<hr/>br_failed=>".$b_br_failed."<br/><br/>";
				echo "<hr/>respCode=>".$response_decode['respCode']."<br/><br/>";
			}
		}
		
		else{ //pending
			$_SESSION['acquirer_response']="Pending";
			$status_completed=false;
			$_SESSION['acquirer_status_code']=1;
			if((isset($_GET['actionurl']))&&(!empty($_GET['actionurl']))){
				$_SESSION['acquirer_response']=$_GET['actionurl']." Pending or Error";
			}
			
			$line_step="5_Pending";

			/*
			if( !isset($_SESSION['adm_login']) && !isset($_REQUEST['cron_tab']) ) {
		
				exit;
			} 
			*/
			
			if((isset($_REQUEST['cron_tab']))&&($_REQUEST['cron_tab']=='cron_tab')){
				$data_tdate=date('YmdHis', strtotime($td['tdate']));
				$current_date_1h=date('YmdHis', strtotime("-1 hours"));
				if($data_tdate<$current_date_1h){
					$_SESSION['acquirer_status_code']=-1;
					$_SESSION['acquirer_response']=$response_decode['respMsg']." - Cancelled"; 
					$line_step="6_Pending_-1_hours";
				}
			}
			
		}
		
	}
	

	// Hanging the script for 2 seconds to allow the browser to load the page && @$_REQUEST['action']!='webhook'
	if( !isset($_SESSION['adm_login']) && !isset($_REQUEST['cron_tab'])  ) 
	{
		include($data['Path'].'/payin/redirecting_ui'.$data['iex']);
		exit;
	}

	//cmn
	//exit;
	//echo "Info_1:-".$line_step;

	if((!isset($_SESSION['acquirer_status_code'])||empty($_SESSION['acquirer_status_code']))&&(!isset($respCode))){
		$bank_status_limit=1;
		echo "transaction not found  please recheck after 1 minutes";
		if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
			echo "transaction not found  please recheck after 1 minutes";
			exit;
		}
	}
	//echo "<br/>Info_2:-".$line_step;	

#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>