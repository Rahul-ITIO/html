<?php
//http://localhost/gw/payin/pay87/hardcode/payment.php


$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api1.dataprotect.site/api/transaction/creates/payments',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{ 
   "payer_id": "100215", 
   "owner": "Dev Tech Ops",
		"id": "8723122601", 
		"transaction_id": "8723122601", 
		"transactions": "8723122601", 
   "card_number": "4242424242424242", 
   "cvv": "123", 
   "validity": "01/26", 
   "amount": "12.3", 
   "currency": "USD", 
   "t_number": "872123122901" 
}',
  CURLOPT_HTTPHEADER => array(
    'Authorization: Bearer M1FHUGF1NnYxUXZkeDlacmM4WXE5Zz09',
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{
    "status": 200,
    "result": {
        "transaction": "93191703831414",
        "status": 5,
        "redirect_url": "https://api1.dataprotect.site/transaction/3d_security/93191703831414",
        "t_number": "872123122901"
    }
}

https://api1.dataprotect.site/payments/3d_security/complete?payment_intent=pi_3OSZaECefCnfIckU1aHZdOHX&payment_intent_client_secret=pi_3OSZaECefCnfIckU1aHZdOHX_secret_UwHHQKq54XUhbHhJx8Pf1yZ8y&source_redirect_slug=test_YWNjdF8xTTBSMWdDZWZDbmZJY2tVLF9QSDdwQlVsV2JIUVZRTXdZaHF4bUd5Q3NUdXF0SXdP0100kcluyAuU


*/

?>