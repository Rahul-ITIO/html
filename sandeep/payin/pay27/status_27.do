<?
//$_REQUEST['pq']=1;

//status 27 
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
	$result_hkip=$_REQUEST;
	
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

#####	TEMP* for Response check as testing	#########
if(!isset($_SESSION['adm_login']))
{
	//include($data['Path'].'/payin/res_insert'.$data['iex']);
}


$apiInfo=@$json_value['apiInfo'];
if($qp){
	echo "<hr>apiInfo=><br />";
	print_r($apiInfo);
}

$merNO=@$apiInfo['merNO'];
$terNO=@$apiInfo['terNO'];
$hash=@$apiInfo['hash'];
$merMgrURL=@$apiInfo['merMgrURL'];

//$orderNo=$json_value['data_'.$td['acquirer']]['orderNo'];


$amount=$td['bill_amt'];
$currency=$td['bill_currency'];

if($td['bank_processing_curr']){
	$currency=$td['bank_processing_curr'];
}
if($td['bank_processing_amount']){
	$amount=$td['bank_processing_amount'];
}

############################################

$b_br_failed='';

	if($is_curl_on==true)	//if check status direct via admin or realtime response
	{
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) 
			$acquirer_status_url="https://payment.gantenpay.com/payment/external/query";
		
		if($qp)
		{
			echo "<br/>acquirer_status_url=>".$acquirer_status_url;
		}
		
		

		if($td['acquirer']==28){
			$acquirer_status_url="https://payment.gantenpay.com/payment/associator/external/query";
		}

	// for gateway
		if($td['acquirer_ref']){
			$tradeNo=$td['acquirer_ref'];
		}
		
		$hash_code=hash("sha256",$merNO.$terNO.$orderNo.$amount.$currency.$hash);
		
		$fhtpay_data="merNo=".$merNO."&terNo=".$terNO."&orderNo=".$orderNo."&tradeNo=".$tradeNo."&amount=".$amount."&currency=".$currency."&signature=".$hash_code."&";
		
		//$fhtpay_data="merNo=".$merNO."&terNo=".$terNO."&orderNo=".$orderNo."&amount=".$amount."&currency=".$currency."&signature=".$hash_code."&";
		
		if($data['pq']){
			echo "<hr/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<hr/>hash_code=> ".$hash_code;
			echo "<hr/>fhtpay_data=> ".$fhtpay_data;
			//exit;
		}
		


		$ch = curl_init();
		curl_setopt($ch,CURLOPT_URL, $acquirer_status_url);
		curl_setopt($ch,CURLOPT_HEADER, $data['pq']);
		curl_setopt($ch,CURLOPT_POST,0);
		curl_setopt($ch,CURLOPT_POSTFIELDS,$fhtpay_data);
		curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
		curl_setopt($ch,CURLOPT_SSL_VERIFYPEER, false); 
		curl_setopt($ch,CURLOPT_SSL_VERIFYHOST, false);
		//curl_setopt($ch,CURLOPT_HTTPHEADER, ['Content-Type: application/json']); 
		$response = curl_exec($ch);
		curl_close($ch);
		
		//process $response
		$result_hkip = json_decode($response,true);
		
	
	}
	
	
		if(is_array($result_hkip))
		$results= $result_hkip;
			
		else{
			$_SESSION['acquirer_response']="Pending";
			$results['Error']="Request too often! Try again later.";
		}	
		
		if($data['pq'])
		{
			echo "<hr/>uid=>".$uid;
			echo "<hr/>response=>".$response;
			echo "<hr/>result_hkip=>";print_r($result_hkip );
			//exit;
		}
		
	if(isset($result_hkip))
	{

		$respCode=jsonvaluef($response,'respCode');
		if($data['pq']&&$respCode)
		{
			$result_hkip['respCode']=$respCode;
			$result_hkip['respMsg']=jsonvaluef($response,'respMsg');
			$result_hkip['tradeNo']=jsonvaluef($response,'tradeNo');
		}
	
	
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$result_hkip['respMsg'];
		$_SESSION['acquirer_status_code']=$result_hkip['respCode'];
		$_SESSION['acquirer_transaction_id']=$result_hkip['tradeNo'];
		$_SESSION['acquirer_descriptor']=$result_hkip['acquirer'];
		//$_SESSION['acquirer_descriptor']="Webtransact";
		$_SESSION['curl_values']=$response;
		
		$errorCode=@$result_hkip['errorCode'];
		
		if(isset($result_hkip['amount'])&&$result_hkip['amount'])
				$_SESSION['responseAmount']	= $result_hkip['amount'];
			
			
			
			$data_status= array(
				'merNotifyStatus'=>'1',
			);
			
			
			
		
		//echo "<hr/>order_status=>".$_SESSION['acquirer_status_code'];
		if($_SESSION['acquirer_status_code']=="00"){ //success
			$_SESSION['acquirer_status_code']=2;
			$status_completed=true;
			$_SESSION['acquirer_response']="Success";
			
			if(!isset($_SESSION['adm_login'])) echo json_encode($data_status);
		}
		elseif( (($_SESSION['acquirer_status_code']=="01"||$result_hkip['respCode']=='1500'|| ( preg_match("/(Do not honour|card type unsupported|Excess single payment)/i", $result_hkip['respMsg']) )  )&&(strtolower($result_hkip['respMsg'])!="pending")) || (($b_br_failed)&&(strpos($b_br_failed,$result_hkip['respMsg'])!==false)) || (@$errorCode=='0001') ){ //failed or other
			
			/*
				if($_SESSION['acquirer_status_code']=="01"){ //failed
					$_SESSION['acquirer_response']="Cancelled";
				}
				$_SESSION['acquirer_status_code']=-1;
				$status_completed=false; 
			*/
			
			//if(!isset($_SESSION['adm_login'])) echo json_encode($data_status);
			
			if( (isset($result_hkip['respMsg'])) && ( (strpos($result_hkip['respMsg'],'Order Timeout')!==false) || (in_array($result_hkip['respMsg'],["pending_async"])) )){
				$_SESSION['acquirer_response']=$result_hkip['respMsg']." - Pending";
				$status_completed=false;
				$_SESSION['acquirer_status_code']=1;
				
			}else{
				$_SESSION['acquirer_response']=$result_hkip['respMsg']."Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
			
			
			if($data['pq']){
				echo "<hr/>br_failed=>".$b_br_failed."<br/><br/>";
				echo "<hr/>respCode=>".$result_hkip['respCode']."<br/><br/>";
			}
		}
		else{ //pending
			$_SESSION['acquirer_response']="Pending";
			$status_completed=false;
			$_SESSION['acquirer_status_code']=1;
			if((isset($_GET['actionurl']))&&(!empty($_GET['actionurl']))){
				$_SESSION['acquirer_response']=$_GET['actionurl']." Pending or Error";
			}
			
			if( !isset($_SESSION['adm_login']) && !isset($_REQUEST['cron_tab']) ) {
		
				exit;
			} 
			
			
			if((isset($_REQUEST['cron_tab']))&&($_REQUEST['cron_tab']=='cron_tab')){
				$data_tdate=date('YmdHis', strtotime($td['tdate']));
				$current_date_1h=date('YmdHis', strtotime("-1 hours"));
				if($data_tdate<$current_date_1h){
					$_SESSION['acquirer_status_code']=-1;
					$_SESSION['acquirer_response']=$result_hkip['respMsg']." - Cancelled"; 
				}
			}
			
		}
		
	}
	
	if((!isset($_SESSION['acquirer_status_code'])||empty($_SESSION['acquirer_status_code']))&&(!isset($respCode))){
		$bank_status_limit=1;
		echo "transaction not found  please recheck after 1 minutes";
		if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
			echo "transaction not found  please recheck after 1 minutes";
			exit;
		}
	}
		

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}
	

?>

