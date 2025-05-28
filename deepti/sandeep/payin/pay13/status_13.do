<?php
//status of coinbase
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

//testing for email response 
//$data['status_in_email']=1;
if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	include($data['Path'].'/payin/status_top'.$data['iex']);
}



//$apJson['apikey']=(isset($data['apJson']['apikey'])?$data['apJson']['apikey']:'');//value from backend


 //$apJson['apikey']=(isset($data['apikey']['apikey'])?$data['apikey']['apikey']:'');
 //$apJson['secretkey']=(isset($data['secretkey']['secretkey'])?$data['secretkey']['secretkey']:'');
//print_r($apJson);
//echo "abcd";

if(!empty($transID))
{
	
		//if not found acquirer_status_url
		if(empty($acquirer_status_url)) $acquirer_status_url="https://api.commerce.coinbase.com/charges/$acquirer_ref";
		
		
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#ac7d26;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>apikey=> ".$apc_get['apikey'];
		//echo "<br/>bank_mid=>".$bank_mid;

		echo '<br/><br/></div>';
	}
	
	$bank_url= $acquirer_status_url."/$acquirer_ref";
	

	$curl = curl_init();
	curl_setopt_array($curl, [
		CURLOPT_URL => $bank_url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'GET',
		CURLOPT_HTTPHEADER => [
			"X-CC-Api-Key: ".$apc_get['apikey'],
			"X-CC-Version: 2018-03-22",
			"Content-Type: application/json"
		],
	]);
	
	 $response = curl_exec($curl);
	curl_close($curl);
	
	$res = json_decode($response, true);
	//print_r($res);
 
  //exit;

//print_r($res);



	
	
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status=> ".$res['status'];
		//echo "<br/>acquirer code=> ".$res['code'];
	}
	

	$results = $res;
  

	//applied condition according to the status response for fail success and pending 
	if (isset($res) && count($res)>0)
	{
			@$statusArr	= @$res['data']['timeline'];
			@$count		= count((array)$statusArr);
			@$status		= @$statusArr[@$count-1]['status'];
		
		if($qp){
			echo "<br/><br/><=status=>".@$status;
		}

		
		
		if(isset($statusArr[$count-1]['context'])) $res_msg = $statusArr[$count-1]['context'];
			$res_msg = '';

			
			$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$res_msg;
		$_SESSION['curl_values']=$res;


		if($status=='SUCCESS' || $status=='COMPLETED'){ //success
				$_SESSION['acquirer_response']=$res_msg." ".$status." - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif($status=='CANCELED' || $status=='EXPIRED'){	//failed
				$_SESSION['acquirer_response']=$res_msg." ".$status." - Cancelled";
				$_SESSION['acquirer_status_code']=-1;
				
			}
			else{ //pending
				$_SESSION['acquirer_response']=$res_msg." - Pending";
				$status_completed=false;
				$_SESSION['acquirer_status_code']=1;
				if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
					$_SESSION['acquirer_response']=$_REQUEST['actionurl']." Pending or Error";
				}
					
				
			//	exit;
					
				$data_tdate=date('YmdHis', strtotime($td['tdate']));
				$current_date_1h=date('YmdHis', strtotime("-1 hours"));
				if(($data_tdate<$current_date_1h)&&($data['localhosts']==false)){
					$_SESSION['acquirer_status_code']=-1;
					$_SESSION['acquirer_response']=$message." - Cancelled"; 
					include($data['Path'].'/payin/status_expired'.$data['iex']);
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
//}


//Get from Acquirer Status
$_SESSION['bank_processing_amount_equal_to_acquirer_response_amount']=0;	// For default Value
$_SESSION['bank_processing_amount']=$td['bank_processing_amount']; // Bank Processing Amount from DB
$_SESSION['responseAmount']=$td['trans_amt']; // for Test amount fetch from status 
//$_SESSION['responseAmount']= responce amount fetch frm status


// condation for Check Bank Processing Amount and Trans Amt are same or not
if(isset($_SESSION['bank_processing_amount'])&&$_SESSION['bank_processing_amount']&&isset($_SESSION['responseAmount'])&&$_SESSION['responseAmount']&&$_SESSION['bank_processing_amount']<>""){

	if($_SESSION['bank_processing_amount'] <> $_SESSION['responseAmount']){
		$_SESSION['bank_processing_amount_equal_to_acquirer_response_amount']=1;
	}

}

#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}


?>

