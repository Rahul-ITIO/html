<?
// Dev Tech : 23-12-26  87 status binopay

$data['NO_SALT']=true;
$is_curl_on = true;

if((isset($_REQUEST['transaction_number']))&&(!empty($_REQUEST['transaction_number']))){
	$_REQUEST['acquirer_ref'] = $_REQUEST['transaction_number'];
	//$is_curl_on = false; $_REQUEST['actionurl']='notify';
}

if((isset($_REQUEST['acquirer_ref']))&&(!empty($_REQUEST['acquirer_ref']))){
	$_REQUEST['acquirer_ref'] = $_REQUEST['acquirer_ref'];
}

//webhook : 
if((isset($_REQUEST['action']))&&$_REQUEST['action']=='webhook'&&(!empty($_REQUEST['client_orderid']))){
	
	//echo "<br/><br/>responseParamList=>"; print_r($_GET);
	
	if(isset($_GET['status'])&&count($_GET)>0) {
		@$responseParamList=$_GET;
		$is_curl_on = false;
	}
	
	/*
	if(isset($responseParamList['client_orderid'])&&trim($responseParamList['client_orderid'])){
		$is_curl_on = false;
		$_REQUEST['transID']=$responseParamList['client_orderid'];
	}
	*/
	//echo "<br/>transID=>".$_REQUEST['transID']; echo "<br/><br/>responseParamList=>"; print_r($responseParamList);
}

//exit;


// access status via callback - end

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	//include($data['Path'].'/payin/res_insert'.$data['iex']);
	include($data['Path'].'/payin/status_top'.$data['iex']);//include status_top if the page execute directly
}

//include($data['Path'].'status_in_email'.$data['iex']);

//print_r($td);
//print_r($json_value);




if(empty($acquirer_status_url)) $acquirer_status_url="https://gate.lonapay24.com/payment/api/v2/status/group";

//check if test mode than assing uat status url 
//echo "<br/>mode=>".$apc_get['mode'];
if(@$acquirer_prod_mode==2||@$apc_get['mode']=='test') $acquirer_status_url="https://sandbox.lonapay24.com/payment/api/v2/status/group";

$acquirer_status_url	= @$acquirer_status_url."/".@$apc_get['endpoint_group_id'];  	

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

	//control will send from here for status this is same process like payment
	$postreq['login'] = @$apc_get['login_id'];
	$postreq['client_orderid']=@$transID;
	$postreq['orderid']=@$acquirer_ref;

	$merchant_control=@$apc_get['control_key'];

	$str = $postreq['login'].''.$postreq['client_orderid'].''.$postreq['orderid'].''.$merchant_control;
	
	if($data['cqp']>0) echo "<br/>sha1 str=>".$str;
	
	$checksum = sha1($str);

	if($data['cqp']>0) echo "<br/>sha1 checksum=>".$checksum;

	############################################################

	$postreq['control']=$checksum;

	$postreqStr=http_build_query($postreq);
	
	if($data['cqp']>0) echo "<br/>postreqStr=>".$postreqStr;

	if($is_curl_on)
	{
		$curl = curl_init();
		
		curl_setopt_array($curl, array(
			CURLOPT_URL => $acquirer_status_url,
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
			CURLOPT_POSTFIELDS => $postreqStr,
			CURLOPT_HTTPHEADER => array(
			  'Content-Type: application/x-www-form-urlencoded'
			),
		  ));

		$response = curl_exec($curl);	
		$http_status	= curl_getinfo($curl, CURLINFO_HTTP_CODE);
		$curl_errno		= curl_errno($curl);
		curl_close($curl);

		$res='https://view?'.$response;

		$res=urldecodef($res);
	
		//remove tab and new line from json encode value 
		//$res = preg_replace('~[\r\n\t]+~', '', $res);
		//$res = str_ireplace(["n&"," &"], '&', $res);
	
		parse_str(parse_url($res, PHP_URL_QUERY), $responseParamList);

		

		//unset($responseParamList['redirect-to']);

		if(isset($responseParamList['redirect-to'])&&trim($responseParamList['redirect-to'])&&(!isset($_SESSION['adm_login'])))
		{
			
			//acquirer response stage2 save via encode encode64f
			if(empty(trim($td['acquirer_response_stage2']))&&isset($responseParamList))
			db_trf($td['id'], 'acquirer_response_stage2', $responseParamList);

			//echo "<br/>redirect-to=>".$responseParamList['redirect-to'];

			header("Location:".@$responseParamList['redirect-to']);exit;
		}
		elseif(isset($responseParamList['status'])&&(!in_array($responseParamList['status'],["approved","declined"]))&&(!isset($_SESSION['adm_login']))&&(!isset($responseParamList['redirect-to'])||empty($responseParamList['redirect-to'])))
		{
			

			if(!isset($_SESSION["reloadCount"]) && empty($_SESSION["reloadCount"])){
				if(isset($data["reloadCount"])&&$data["reloadCount"]){
					$_SESSION["reloadCount"] = (int)$data["reloadCount"];
					
				}else{
			
					$_SESSION["reloadCount"] = 10;//to check transaction status 10 times if pending 
				}
			}else{	
				$reloadCount = $_SESSION["reloadCount"];
				$reloadCount--;
				$_SESSION["reloadCount"]= $reloadCount;
			}
			//echo $_SESSION["reloadCount"];

			$reloadCount=@$_SESSION["reloadCount"];

			include($data['Path'].'/payin/loading_icon'.$data['iex']);

			echo "<script>
				var reloadCount = $reloadCount;
				//alert(reloadCount);
				setTimeout( function(){ 
					if(reloadCount > 0){
						top.document.location.href=top.document.location.href;
					}
				}, 10000 ); //10000
			</script>";
			exit;
		}
		
		elseif(isset($responseParamList['html'])&&trim($responseParamList['html'])&&(!isset($_SESSION['adm_login'])))
		{
			//echo "<br/>html=>".$responseParamList['html'];

			echo $responseParamList['html'];exit;
		}
		
	//exit;
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
	
		//$responseParamList = jsondecode($response,1,1);	// covert response from json to array
	}
	$results = @$responseParamList;
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
		echo "<br/>mode=>".$apc_get['mode'];
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer ['type']=> ".@$responseParamList['type'];
		echo "<br/>acquirer status ['status']=> ".@$responseParamList['status'];
		echo "<br/>acquirer ['descriptor']=> ".@$responseParamList['descriptor'];
		echo "<br/>acquirer message ['result']['message']=> ".@$responseParamList['result']['message'];
		echo "<br/>acquirer via ['amount']=> ".@$responseParamList['amount'];
		
		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
		echo '<br/><br/></div>';
	}
		
	
	/*
	
Possible statuses:
0000	Approved
0001	Approved with Risk
0002	Deferred capture


	
	*/

	if (isset($responseParamList) && count($responseParamList)>0)
	{
		
		//rrn //acquirer_ref
		#######	rrn, acquirer_ref update from status get :start 	###############
			
		/*
			//acquirer_ref
			$acquirer_ref_1='';
			if(isset($responseParamList['result']['transaction_number'])) $acquirer_ref_1 = @$responseParamList['result']['transaction_number'];
			//up acquirer_ref : update if empty acquirer_ref_1 and is ['result']['transaction_number']  
			if(empty(trim($td['acquirer_ref']))&&!empty($acquirer_ref_1)){
				$tr_upd_status['acquirer_ref']=trim($acquirer_ref_1);
			}
			
			*/

			//rrn 
			$rrn='';
			if(isset($responseParamList['processor-rrn'])) $rrn = @$responseParamList['processor-rrn'];
			//up rrn : update if empty rrn and is custRefNo 
			if(empty(trim($td['rrn']))&&!empty($rrn)){
				$tr_upd_status['rrn']=trim($rrn);
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
		
		
		$message= '';
		if(isset($responseParamList['error-message'])) $message= @$responseParamList['error-message'];
		
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=@$message;

		$curl_values=@$responseParamList;

		if(isset($curl_values['html'])) unset($curl_values['html']);

		$_SESSION['curl_values']=@$curl_values;
		
		if(isset($responseParamList['reference_id'])&&@$responseParamList['reference_id']) $_SESSION['acquirer_transaction_id']=@$responseParamList['reference_id'];
		
		if(isset($responseParamList['descriptor'])&&@$responseParamList['descriptor']) $_SESSION['acquirer_descriptor']=@$responseParamList['descriptor'];
		
		if(isset($responseParamList['amount'])&&$responseParamList['amount']) $_SESSION['responseAmount']=$responseParamList['amount'];

		$result_code = strtolower(@$responseParamList['status']);
		
		// "approved","declined"

		if($result_code=='approved'){ //success
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Success";
			$_SESSION['acquirer_status_code']=2;
			if(isset($json_value['billing_descriptor'])&&trim($json_value['billing_descriptor'])) $_SESSION['acquirer_descriptor']=@$json_value['billing_descriptor'];
		}
		elseif($result_code=='declined'){	//failed
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