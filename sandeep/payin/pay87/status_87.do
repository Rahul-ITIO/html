<?
// Dev Tech : 23-12-26  87 status binopay
$data['NO_SALT']=true;
$is_curl_on = true;

//print_r($_GET);

if((isset($_REQUEST['transaction_number']))&&(!empty($_REQUEST['transaction_number']))){
	$_REQUEST['acquirer_ref'] = $_REQUEST['transaction_number'];
	//$is_curl_on = false; $_REQUEST['actionurl']='notify';
}

if((isset($_REQUEST['acquirer_ref']))&&(!empty($_REQUEST['acquirer_ref']))){
	$_REQUEST['acquirer_ref'] = $_REQUEST['acquirer_ref'];
}
if((isset($_REQUEST['tNumber']))&&(!empty($_REQUEST['tNumber']))){
	$_REQUEST['transID']=$_REQUEST['tNumber'];
}
if((isset($_REQUEST['t_number']))&&(!empty($_REQUEST['t_number']))){
	$_REQUEST['transID']=$_REQUEST['t_number'];
}



//webhook : 
//Dev Tech : 24-01-04 fetch response via webhook 

// PHP_INPUT: {"transactionNumber":"94331704348375","transactionStatus":2,"t_number":"872123122901"}

$body_input_get = file_get_contents("php://input");
if(isset($body_input_get)&&$body_input_get){
	//remove tab and new line from json encode value 
	$body_input_get = preg_replace('~[\r\n\t]+~', '', $body_input_get);

	$object_input_res = $responseParamList['result'] = json_decode($body_input_get, true);
	$data['gateway_push_notify']=$object_input_res;
	
	//echo "<br/>object_input_res=>"; print_r($object_input_res);
	
	if(isset($object_input_res)&&$object_input_res)
	{
		
		if(isset($object_input_res['t_number'])&&is_array($object_input_res))
		{
			
			if(isset($object_input_res['t_number'])&&$object_input_res['t_number']) $_REQUEST['transID']=$object_input_res['t_number'];
			
			if(isset($object_input_res['transactionNumber'])&&$object_input_res['transactionNumber']) $responseParamList['result']['transaction_number']=$object_input_res['transactionNumber'];
				
			if(isset($object_input_res['transactionStatus'])&&$object_input_res['transactionStatus']) {
				$responseParamList['result']['transaction_status']=$object_input_res['transactionStatus'];
				$is_curl_on=false;
			}
		}
		
		//echo "<br/>transID=>".$_REQUEST['transID']; echo "<br/>responseParamList=>"; print_r($responseParamList);
		
		//$email_message.="<p><b>PHP_INPUT: </b>".json_encode($object_input_res, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)."</p>";
		
	}
}



// access status via callback - end

if(isset($data['ROOT1'])) $root='';
elseif(isset($data['ROOT'])) $root=$data['ROOT'];
else $root='../../';

if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	//include($data['Path'].'/payin/res_insert'.$data['iex']);
	include($data['Path'].'/payin/status_top'.$data['iex']);//include status_top if the page execute directly
}

//include($data['Path'].'status_in_email'.$data['iex']);

//print_r($_GET);
//print_r($td);
//print_r($json_value);



if(empty($acquirer_status_url)) $acquirer_status_url="https://api1.dataprotect.site/api/transaction/v1/transactions";

$acquirer_status_url	= $acquirer_status_url."/".$acquirer_ref."/info";  	

if(empty($acquirer_ref)) echo "<br/><b>Acquirer Ref not found</b><br/>".$acquirer_ref;

if($qp)
{

	echo "<br/>acquirer_status_url=>".$acquirer_status_url;
	echo "<br/>acquirer_ref=>".$acquirer_ref;
}

if(!empty($acquirer_ref))
{
	$post_data = array();
	$post_data['acquirer_ref'] = $acquirer_ref;
	
	if($is_curl_on)
	{
		$curl = curl_init();
		curl_setopt_array($curl, array(
		  CURLOPT_URL => $acquirer_status_url, 
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_ENCODING => '',
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 0,
		  CURLOPT_FOLLOWLOCATION => true,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => 'GET',
		));

		$response = curl_exec($curl);	
		$http_status	= curl_getinfo($curl, CURLINFO_HTTP_CODE);
		$curl_errno		= curl_errno($curl);
		curl_close($curl);
	
		if($qp)
		{
			echo "<br/>acquirer_status_url=>".@$acquirer_status_url;
			echo "<br/>response=>".@$response;
		}
		if($http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404) {	//transaction stay as PENDING if received any one of the above error
			$err_msg = "HTTP Status == {$http_status}.";
			
			if($curl_errno) echo "<br/>Curl Errno returned $curl_errno.<br/>";
			
			$_SESSION['acquirer_response']		=$err_msg." - Pending";
			$_SESSION['acquirer_status_code']=1;
			$status_completed=false;
			
			//exit;
		}
		elseif($curl_errno){
			echo '<br/>Request Error: '.$curl_errno.' - ' . curl_error($handle);
			exit;
		}
	
		$responseParamList = jsondecode($response,1,1);	// covert response from json to array
	}
	$results = $responseParamList;
	//$_SESSION['results_100']=$results;
	
	/*
	echo "<pre><code>";
	print_r($results);
	echo "</code></pre>";
	exit;
	*/
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status ['result']['transaction_status']=> ".@$responseParamList['result']['transaction_status'];
		echo "<br/>acquirer message ['result']['decline_reason']=> ".@$responseParamList['result']['decline_reason'];
		
		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
		echo '<br/><br/></div>';
	}
		
	
	/*
	
	Possible statuses:
	  STATUS_IN_PROCESS = 1;
	  STATUS_APPROVED = 2;
	  STATUS_DENIED = 3;
	  STATUS_REFUND = 4;
	  STATUS_WAITING_ CONFIRMATION = 5;
	
	*/

	if (isset($responseParamList) && count($responseParamList)>0)
	{
		
		//rrn //acquirer_ref
		#######	rrn, acquirer_ref update from status get :start 	###############
			
			//acquirer_ref
			$acquirer_ref_1='';
			if(isset($responseParamList['result']['transaction_number'])) $acquirer_ref_1 = @$responseParamList['result']['transaction_number'];
			//up acquirer_ref : update if empty acquirer_ref_1 and is ['result']['transaction_number']  
			if(empty(trim($td['acquirer_ref']))&&!empty($acquirer_ref_1)){
				$tr_upd_status['acquirer_ref']=trim($acquirer_ref_1);
			}
			
			
			if($qp){
				echo "<br/><br/><=acquirer_ref=>".@$acquirer_ref_1;
				echo "<br/><br/><=tr_upd_status1=>";
					print_r(@$tr_upd_status);
			}
			
			if(isset($tr_upd_status)&&count($tr_upd_status)>0&&is_array($tr_upd_status))
			{
				if($qp){
					echo "<br/><br/><=tr_upd_status=>";
					print_r($tr_upd_status);
				}
				
				trans_updatesf($td['id'], $tr_upd_status);
			}
			
		#######	rrn, acquirer_ref update from status get :end 	###############
		
		
		$message= @$responseParamList['result']['decline_reason'];
		
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=@$message;
		$_SESSION['curl_values']=@$responseParamList;
		
		if(isset($responseParamList['result']['transaction_number'])&&$responseParamList['result']['transaction_number']) $_SESSION['acquirer_transaction_id']=$responseParamList['result']['transaction_number'];
		
		if(isset($responseParamList['result']['transaction_amount'])&&$responseParamList['result']['transaction_amount']) $_SESSION['responseAmount']=$responseParamList['result']['transaction_amount'];

		$status_nm = (int)@$responseParamList['result']['transaction_status'];
		
		if($status_nm==2){ //success
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Success";
			$_SESSION['acquirer_status_code']=2;
			if(isset($json_value['billing_descriptor'])&&trim($json_value['billing_descriptor'])) $_SESSION['acquirer_descriptor']=@$json_value['billing_descriptor'];
		}
		elseif($status_nm==3){	//failed
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." Payment failed - Cancelled";
			$_SESSION['acquirer_status_code']=-1;
		}
		else{
			$_SESSION['acquirer_response']=$message." - Pending";
			$_SESSION['acquirer_status_code']=1;
		}
	}
}

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>