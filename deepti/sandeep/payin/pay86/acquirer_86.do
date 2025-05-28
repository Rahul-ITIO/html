<?
// Dev Tech : 23-12-27  86 - openacquiring  Acquirer 

if($_SESSION['b_'.$acquirer]['acquirer_prod_mode']==2){
	$post['ccno']='4111111111111111';
	$post['month']='05';
	$post['year4']='2025';
	$post['ccvv']='000';
	
	$post['country_two']='mu';
}
	
	$post['month']=(int)$post['month'];
	$post['year4']=(int)$post['year4'];
	
	$curlPost=array();
	$curlPost["intent"]='sale';
	//$curlPost["intent"]='auth';
	
	$curlPost["payer"]["payment_type"]='CC';
	$curlPost["payer"]["funding_instrument"]["credit_card"]["number"]=@$post['ccno'];
	$curlPost["payer"]["funding_instrument"]["credit_card"]["expire_month"]=@$post['month'];
	$curlPost["payer"]["funding_instrument"]["credit_card"]["expire_year"]=@$post['year4'];
	$curlPost["payer"]["funding_instrument"]["credit_card"]["cvv2"]=@$post['ccvv'];
	$curlPost["payer"]["funding_instrument"]["credit_card"]["name"]=@$post['fullname'];
	
	$curlPost["payer"]["payer_info"]["email"]=@$post['bill_email'];
	//$curlPost["payer"]["payer_info"]["ip"]="10.12.20.3";
	$curlPost["payer"]["payer_info"]["ip"]=$_SESSION['bill_ip'];
	
	//$curlPost["payer"]["payer_info"]["name"]=@$post['fullname'];
	$curlPost["payer"]["payer_info"]["billing_address"]["line1"]=@$post['bill_street_1'];
	$curlPost["payer"]["payer_info"]["billing_address"]["line2"]=@$post['bill_street_2'];
	$curlPost["payer"]["payer_info"]["billing_address"]["city"]=@$post['bill_city'];
	$curlPost["payer"]["payer_info"]["billing_address"]["country_code"]=strtolower(@$post['country_two']);
	$curlPost["payer"]["payer_info"]["billing_address"]["postal_code"]=@$post['bill_zip'];
	$curlPost["payer"]["payer_info"]["billing_address"]["state"]='';
	$curlPost["payer"]["payer_info"]["billing_address"]["phone"]["country_code"]=@get_country_code($post['country_two'],4);	//isd_code
	$curlPost["payer"]["payer_info"]["billing_address"]["phone"]["number"]=@$post['bill_phone'];
	
	//$curlPost["payer"]["browser_info"]=@$_SERVER['HTTP_USER_AGENT'];
	//$curlPost["payer"]["browser_info"]='{"accept_header":"text/html,application/xhtml+xml,application/xml;q\\u003d0.9,image/avif,image/webp,*/*;q\\u003d0.8","color_depth": 24,"java_enabled":false,"javascript_enabled": true,"language":"en-US","screen_height":"1080","screen_width":"1920","timezone_offset": -240,"user_agent":"Mozilla/5.0 \\u0026 #40;Windows NT 10.0; Win64; x64;rv:103.0\\u0026#41; Gecko/20100101 Firefox/103.0","ip":"12.2.12.0","channel":"Web"}';
	
	$curlPost["payee"]["email"]=@$post['bill_email'];
	$curlPost["payee"]["merchant_id"]=@$apc_get['merchant_id'];
	
	$curlPost["transaction"]["type"]='1';
	$curlPost["transaction"]["amount"]["currency"]=@$orderCurrency;
	$curlPost["transaction"]["amount"]["total"]=@$total_payment;
	$curlPost["transaction"]["invoice_number"]=@$transID;
	$curlPost["transaction"]["return_url"]=@$status_default_url;
	
	/*
	$curlPost["transaction"]["items"][0]["sku"]=@$transID;
	$curlPost["transaction"]["items"][0]["name"]=@$post['fullname'];
	$curlPost["transaction"]["items"][0]["description"]=@$post['product_name'];
	$curlPost["transaction"]["items"][0]["quantity"]='1';
	$curlPost["transaction"]["items"][0]["price"]='1';
	$curlPost["transaction"]["items"][0]["shipping"]='10';
	$curlPost["transaction"]["items"][0]["currency"]=@$orderCurrency;
	$curlPost["transaction"]["items"][0]["url"]='';
	$curlPost["transaction"]["items"][0]["image"]='';
	$curlPost["transaction"]["items"][0]["tangible"]='true';
	
	$curlPost["transaction"]["items"][1]["sku"]=@$transID;
	$curlPost["transaction"]["items"][1]["name"]=@$post['fullname'];
	$curlPost["transaction"]["items"][1]["description"]=@$post['product_name'];
	$curlPost["transaction"]["items"][1]["quantity"]='1';
	$curlPost["transaction"]["items"][1]["price"]=@$total_payment-1;
	$curlPost["transaction"]["items"][1]["shipping"]='10';
	$curlPost["transaction"]["items"][1]["currency"]=@$orderCurrency;
	$curlPost["transaction"]["items"][1]["url"]='';
	$curlPost["transaction"]["items"][1]["image"]='';
	$curlPost["transaction"]["items"][1]["tangible"]='true';
	
	*/
	
	//$curlPost_ac=json_encode($curlPost, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT | JSON_FORCE_OBJECT);
	$curlPost_ac=json_encode($curlPost, JSON_PRETTY_PRINT);
	
	if($data['cqp']==6){
		echo "<br/><br/>curlPost=> ".$curlPost_ac;
		exit;
	}
	
/*


http://docs.openacquiring.com/ developer docs


Merchant Id : vynh3bui63qbx604			| merchant_id
Client Id : yci092bkrcd2kfrb
Client Secret : 8idvbu778b8u0yhz

https://www.base64encode.org/  for generate of Authorization: Basic

yci092bkrcd2kfrb:8idvbu778b8u0yhz => eWNpMDkyYmtyY2Qya2ZyYjo4aWR2YnU3NzhiOHUweWh6

OmanNet Cards
Card Number	Expiry Date	CVV	OTP
4644260581661836	04/25	400	111111
4644260584555977	04/25	941	111111
4644260582940700	03/24	343	111111

#Credit Cards
Card Number	Expiry Date	CVV
4005520201264821	12/24	123
4543474002249996	06/25	956




*/	
	
	$bank_url=$bank_url.'/'.@$apc_get['merchant_id'].'/payment';
	
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
	  CURLOPT_POSTFIELDS =>$curlPost_ac,
	  CURLOPT_HTTPHEADER => array(
		'Authorization: Basic '.$apc_get['authorization'],
		'Content-Type: application/json'
	  ),
	));

	$response = curl_exec($curl);
	curl_close($curl);
	
	$results = json_decode($response,true);
	if(isset($results)&&is_array($results)) $results=sqInArray($results);
	

	$post_data=$curlPost;
	//unset card details 
	
	if(isset($post_data["payer"]["funding_instrument"])) unset($post_data["payer"]["funding_instrument"]);
	
	
	$tr_upd_order1=array();
	if(isset($results["reference_id"])&&$results["reference_id"])  $tr_upd_order1['acquirer_ref']=$results["reference_id"];
	$tr_upd_order1['bank_url']=$bank_url;
	$tr_upd_order1['post_data']=$post_data;
	$tr_upd_order1['responseParamList']=isset($results)&&$results?$results:htmlentitiesf($response);
	$curl_values_arr['browserOsInfo']=$browserOs;
	
	

	
	
	
	
	
	// Check error 
	if(isset($results["errors"][0])) 
			$error_description = implode(' | ', $results["errors"][0]);
	elseif(isset($results["result"]["errors"])) 
			$error_description = implode(' | ', $results["result"]["errors"]);
	elseif(isset($results["result"]["description"]) && trim($results["result"]["description"]) && strpos(strtolower($results["result"]["description"]),'error')!==false) 
			$error_description = $results["result"]["description"];
	elseif(isset($results["state"]) && trim($results["state"]) && in_array($results["state"],["declined"])) 
			$error_description = $results["result"]["code"].' | '.$results["result"]["description"];
	else $error_description = '';
	
	
	if($data['cqp']==9)
	{
		trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
		echo "<br/><br/>bank_url=> "; print_r($bank_url);
		echo "<br/><br/>curlPost Encode=> ".json_encode($curlPost);
		echo "<br/><br/>curlPost=> "; print_r($curlPost);
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

	if(isset($results)&&is_array($results))
	{
		$message = @$results["result"]["description"];
		$result_code = @$results["result"]["code"];
		//$redirect_url = $results["result"]["redirect_url"];
		//$error_description = $results["result"]["description"];
		
		//3D Bank url for OTP validate via payaddress from authdata 
		if(isset($results["result"]["redirect_url"]) && $results["result"]["redirect_url"]){ //3D Bank URL
			$tr_upd_order1['pay_mode']='3D';
			
			$auth_3ds2_secure=$results["result"]["redirect_url"];
			$auth_3ds2_action='redirect';
		}
		
		if($result_code=='0000'){ // Approved - "code": "0000","description": "Approved"

			$_SESSION['acquirer_action']=$message." - Success";
			$_SESSION['acquirer_status_code']=2;
			$json_arr_set['realtime_response_url']=$trans_processing;

		}elseif($result_code=='1005'){ // Declined/Failed - "code": "1005","description": "Do not honor"
			
			$_SESSION['acquirer_action']=$message." - Cancelled";
			$_SESSION['acquirer_status_code']=-1;
			$json_arr_set['realtime_response_url']=$trans_processing;

		}
	}
	
	$tr_upd_order_111=$tr_upd_order1;
	//trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
		
?>