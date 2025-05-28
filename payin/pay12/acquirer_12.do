<?
//12 from 341 advCash 
//12-AdvCash 	: 341 - api/include/acquirer_341.do  | Default Acquier : 12 		
	
//{"sci_name":"website scI adv","sign_key":"2c8dc6bccd04b1ca81fd2ce69898d50d9a42a303bc53021a2466b6e6b51905cc","account_email":"vik.mno@gmail.com"}

if(isset($apc_get['account_email'])&&trim($apc_get['account_email']))
$ac_account_email=$apc_get['account_email']; 
else $ac_account_email="vik.mno@gmail.com";

$params=array();
$params['ac_account_email']=$ac_account_email;
$params['ac_sci_name']=$apc_get['sci_name']; 
$params['ac_amount']=trim($total_payment); 
$params['ac_currency']=$orderCurrency; 
$params['ac_order_id']=$_SESSION['transID']; 
$params['ac_sign']=$apc_get['sign_key'];
$params['ac_success_url']=$status_url_1; //  retrun url via status 
$params['ac_success_url_method']="GET";  // GET	POST
$params['ac_status_url']=$webhookhandler_url; // webhook
$params['ac_status_url_method']="GET";
$params['ac_comments']=$transID;


// Dev Tech : 23-09-16 encode64f data save for otp and pin 

//acquirer_response_stage1
$acquirer_response_stage1['current_url_1']=$bank_url;
$acquirer_response_stage1['pay_url_1']=$bank_url;
$acquirer_response_stage1['paylod_1']=@$params;
db_trf($_SESSION['tr_newid'], 'acquirer_response_stage1', $acquirer_response_stage1);



$tr_upd_order['transID']=$_SESSION['transID'];
$tr_upd_order['bank_process_url_'.$acquirer]=$bank_process_url;

if($params){
	$tr_upd_order['PostParams']=$params;	
}

trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);


/*
// array for post api like digi50
$postApiArray=array();

$source_url_postApi=isset($_SERVER["HTTPS"])?'https://':'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']; 

//$postApiArray["public_key"]=$bank_public_key;
//$postApiArray["terNO"]=$bank_terNO;

if(isset($post['mop'])&&$post['mop']) $postApiArray["mop"] = $post['mop'];

$postApiArray["integration-type"]=$post['integration-type'];
$postApiArray["bill_ip"]=$_SESSION['bill_ip'];
$postApiArray["source_url"]=$source_url_postApi;
	
$postApiArray["bill_amt"]=$post['bill_amt'];
$postApiArray["bill_currency"]=$post['bill_currency'];
	
$postApiArray["trans_amt"]=$total_payment;
$postApiArray["trans_currency"]=$orderCurrency;

$postApiArray["product_name"]=$post['product_name'];

$postApiArray["fullname"]=$post['fullname'];
$postApiArray["bill_email"]=$post['bill_email'];

$postApiArray["bill_address"]=$post['bill_address'];
$postApiArray["bill_city"]=$post['bill_city'];
$postApiArray["bill_state"]=$post['bill_state'];
$postApiArray["bill_country"]=$post['bill_country'];
$postApiArray["bill_zip"]=$post['bill_zip'];


$postApiArray["bill_phone"]=$post['bill_phone'];
$postApiArray["transID"]=$_SESSION['transID'];
//$postApiArray["reference"]=$_SESSION['transID'];
//$postApiArray["unique_reference"]='Y'; 
$postApiArray["webhook_url"]=$webhookhandler_url;
$postApiArray["return_url"]=$status_url_1;


//Send to acquirer_creds_processing via 64 encode method 
$postApi["postApiKey"]=encode64f($apc_get_en);

$postApi["acquirer"]=$acquirer; // current acquirer
$postApi["default_acquirer"]=$acquirer_payin; // default acquirer

*/


//Array merge for digi50
$params=array_merge($postApiArray,$params);

//Send to Post Date via 64 encode method 
$params_en= json_encode($params, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
$postApi["postApiData"]=encode64f($params_en);
$postApi["transID"]=@$transID;


//$_SESSION['3ds2_auth']['post_redirect']=$params;
$_SESSION['3ds2_auth']['post_redirect']=$postApi;
$_SESSION['3ds2_auth']['startSetInterval']='N';

if(!empty($bank_url)){
	$subquery="transID={$transID}";
	if(strpos($bank_url,'?') !== false) {
		$bank_url=$bank_url."&".$subquery;
	}
	else{
		$bank_url=$bank_url."?".$subquery;
	}
}

$tr_upd_order['pay_mode']='3D';
$auth_3ds2_secure=$bank_url;
$auth_3ds2_action='post_redirect';
				

//post_redirect($bank_url, $params);
	
//exit;
	
//12 advCash end 

?>