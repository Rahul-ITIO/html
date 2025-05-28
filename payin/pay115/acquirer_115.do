<?
//  115 - egera

// {"integration_id":"6f8b8806-b097-4e5e-81be-825653688aa8","password":"cFxwTHcxxGP6re","settle_address":"TGmEwV1RrNiF9f1Dk7By1Xk8F63P5jcbT1","hostname":"colibrix.io"}


//parameter for checksum we are making checksum in code parameter
$amount = @$total_payment;
$fiat = 'pln';
$currency = strtolower(@$orderCurrency).'t'; //usdt
//$currency = 'usdt'; //usdt
$chain = 'trx';
$address = @$apc_get['settle_address'];
$hosted = 'hosted';
$custom_code = $transID;
$passphrase = @$apc_get['password'];

   $code = hash('sha256', $amount . $fiat . $currency . $chain . $address . $hosted . $custom_code . $passphrase);
  
// these are parameter
$postData=[];
$postData['amount']=$total_payment;
$postData['fiat']=$fiat;
$postData['currency']=$currency;
$postData['chain']=$chain;
$postData['address']=$address;
$postData['hosted']=$hosted;
$postData['channel']='blik';
$postData['email']=@$post['bill_email'];
$postData['phone']=@$post['bill_phone'];
$postData['name']=@$post['ccholder'];
$postData['surname']=@$post['ccholder_lname'];
$postData['home-address']=@$post['bill_address'];
$postData['postal']=@$post['bill_zip'];  
$postData['city']=@$post['bill_city'];
$postData['respect_uniqe']='on';
$postData['drapes']='on';
$postData['return_url']=$status_url_1;  
$postData['custom_code']=$custom_code;  
$postData['partnerid']=@$apc_get['integration_id']; 
$postData['code']=@$code;  


$queryString = http_build_query($postData);

//$baseUrl = 'https://sandbox-checkout.egera.com/en/checkout';
$bank_redirect_url = $bank_url . '?' . $queryString;

if(isset($data['cqp'])&&$data['cqp']>0)
{
	echo "<br/><hr/><br/>bank_redirect_url=>"; print_r($bank_redirect_url);
	echo "<br/><hr/><br/>postData=>"; print_r($postData);
  if($data['cqp']==9) exit;
}

$tr_upd_order['bank_url']=$bank_redirect_url;
$auth_3ds2_secure=$bank_redirect_url;
$auth_3ds2_action='redirect';
$auth_data_not_save=1;
$json_arr_set['check_acquirer_status_in_realtime']='NO'; // if webhook s2s update status then no need to check status on checkout page for stop status check 

$tr_upd_order_111=$tr_upd_order;


?>
