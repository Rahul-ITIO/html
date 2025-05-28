<?

//PayU   : 38 from 64 -  UPI Collect, 641 - UPI QR & Intent

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


$res_return = "";
if(isset($_POST['txnid'])&&$_POST['txnid']&&!isset($data['STATUS_ROOT']))
{
    $_REQUEST['transID'] = $_POST['txnid'];
	$res_return = "200 OK";
	$_REQUEST['action']='webhook';
	// echo 'key-'.$_POST['txnid'].'<br /><br />';
	// print_r($_POST);
}

	
if(!isset($data['STATUS_ROOT'])){
	include($root.'config.do');
	include($data['Path'].'/payin/status_top'.$data['iex']);
}

#####	TEMP* for Response check as testing	#########
//include($data['Path'].'/payin/res_insert'.$data['iex']);

//$qp = 1;
//print_r($td);
//print_r($json_value);

$siteid_get['acquirer_status_url']		= "";
$siteid_get['acquirer_ref']		= "";
$siteid_get['merchantKey']	= "";
$siteid_get['saltKey']		= "";


if(isset($json_value['acquirer_ref']))		$siteid_get['acquirer_ref']		= $json_value['acquirer_ref']; 
if(isset($json_value['merchantKey']))	$siteid_get['merchantKey']	= $json_value['merchantKey']; 
if(isset($json_value['saltKey']))		$siteid_get['saltKey']		= $json_value['saltKey'];

if(empty($acquirer_ref) && $siteid_get['acquirer_ref']) $acquirer_ref = $siteid_get['acquirer_ref'];

if(!empty($transID))
{
	//$siteid_get['bank_url']."/merchant/postservice?form=2";
	
	//echo "<br/><br/>acquirer_status_url=>".$acquirer_status_url;
	
	if(empty($acquirer_status_url))
	$acquirer_status_url = "https://info.payu.in/merchant/postservice.php?form=2";
	
	//echo "<br/><br/>acquirer_status_url2=>".$acquirer_status_url;

	$text	= $siteid_get['merchantKey']."|verify_payment|".$transID."|".$siteid_get['saltKey'];
	$output = hash ("sha512", $text);

	$post_data = "key=".$siteid_get['merchantKey']."&command=verify_payment&var1=$transID&hash=".$output;

	$curl = curl_init($acquirer_status_url);
	curl_setopt($curl, CURLOPT_URL, $acquirer_status_url);
	curl_setopt($curl, CURLOPT_POST, true);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	$headers = array( "Content-Type: application/x-www-form-urlencoded", );
	curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);
	$resp = curl_exec($curl);
	curl_close($curl);

	$responseParamList = json_decode($resp,true);

//	print_r($responseParamList);

	$results = $responseParamList;

	if(isset($responseParamList) && count($responseParamList)>0)
	{
		if(isset($responseParamList['status']))
		{
			$transaction_details	= $responseParamList['transaction_details'][$transID];

			$_SESSION['acquirer_transaction_id']=$transaction_details['mihpayid'];
			$status		= $transaction_details['status'];
			$message	= $transaction_details['unmappedstatus'];
			
			if(isset($transaction_details['amt'])&&$transaction_details['amt'])
				$_SESSION['responseAmount']	= $transaction_details['amt'];
			
			

			$_SESSION['acquirer_action']=1;
			$_SESSION['acquirer_response']	=$message;
			$_SESSION['curl_values']=$responseParamList;

			if($status=='success'){ //success
				$_SESSION['acquirer_response']=$message." - Success";
				$_SESSION['acquirer_status_code']=2;

				if(isset($res_return)&&$res_return) echo $res_return;
			}
			elseif($status=='failed' || $status=='failure'){	//failed

				if(isset($transaction_details['error_Message'])&&$transaction_details['error_Message'])
					$message = $transaction_details['error_Message'];

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
}

#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>