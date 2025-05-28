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
$params['ac_success_url_method']="POST"; 
$params['ac_status_url']=$webhookhandler_url; // webhook
$params['ac_status_url_method']="POST";
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


$_SESSION['3ds2_auth']['post_redirect']=$params;
$tr_upd_order['pay_mode']='3D';
$auth_3ds2_secure=$bank_url;
$auth_3ds2_action='post_redirect';
				

//post_redirect($bank_url, $params);
	
//exit;
	
//12 advCash end 

?>