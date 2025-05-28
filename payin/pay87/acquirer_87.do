<?
// Dev Tech : 23-12-26  87 - bingopay  Acquirer 
if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2)
{
	$post['ccno']='4242424242424242';
	$post['month']='01';
	$post['year']='26';
	$post['ccvv']='123';
}

   
	$curlPost=array();
	$curlPost["payer_id"]=$apc_get['payer_id'];
	$curlPost["owner"]=$post['fullname'];
	$curlPost['card_number']=$post['ccno'];
	$curlPost['cvv']=$post['ccvv'];
	$curlPost['validity']=$post['month']."/".$post['year'];
	$curlPost["amount"]=$total_payment;
	$curlPost["currency"]=$orderCurrency;
	$curlPost["t_number"]=$transID;
	
	
	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL => $bank_url,
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 0,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POST => 1,
	  CURLOPT_SSL_VERIFYPEER => 0,
	  CURLOPT_SSL_VERIFYHOST=> 0,
	  CURLOPT_POSTFIELDS =>json_encode($curlPost),
	  CURLOPT_HTTPHEADER => array(
		'Authorization: Bearer '.$apc_get['token'],
		'Content-Type: application/json'
	  ),
	));

	$response = curl_exec($curl);
	curl_close($curl);
	
	$results = json_decode($response,true);
	$results=sqInArray($results);
	

	$post_data=$curlPost;
	if(isset($post_data['card_number'])) unset($post_data['card_number']);
	if(isset($post_data['cvv'])) unset($post_data['cvv']);
	if(isset($post_data['validity'])) unset($post_data['validity']);
	
	
	$tr_upd_order1=array();
	if(isset($results["result"]["transaction"])&&$results["result"]["transaction"])  $tr_upd_order1['acquirer_ref']=$results["result"]["transaction"];
	$tr_upd_order1['post_data']=$post_data;
	$tr_upd_order1['responseParamList']=isset($results)&&$results?$results:htmlentitiesf($response);
	$curl_values_arr['browserOsInfo']=$browserOs;
	
	
	//$status_nm = (int)($results["result"]["status"]);
	//$redirect_url = $results["result"]["redirect_url"];
	//$error_description = $results["result"]["error_description"];

	if(isset($results["result"]["error_description"]) && trim($results["result"]["error_description"]))
	{
		$error_description = $results["result"]["error_description"];
		
		$_SESSION['acquirer_response']=$error_description;
		$tr_upd_order1['error']=$error_description;
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
		echo 'Error for '.@$error_description;exit; 
	}

	
	
	//3D Bank url for OTP validate via payaddress from authdata 
	if(isset($results["result"]["redirect_url"]) && $results["result"]["redirect_url"]){ //3D Bank URL
		$tr_upd_order1['pay_mode']='3D';
		
		$auth_3ds2_secure=$results["result"]["redirect_url"];
		$auth_3ds2_action='redirect';
	}
	
	$tr_upd_order_111=$tr_upd_order1;
	//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
?>