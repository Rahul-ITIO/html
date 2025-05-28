<?php
// http://localhost:8080/testPoject/lonapay24/payment.php

$postRequest=[];
$postRequest['card_printed_name']='John Doe';
$postRequest['credit_card_number']='4538977399606732';
$postRequest['expire_year']='2099';
$postRequest['expire_month']='12';
$postRequest['cvv2']='123';
$postRequest['client_orderid']='902B4FF56';
$postRequest['order_desc']='Test Order Description';
$postRequest['first_name']='John';
$postRequest['last_name']='Smith';
//$postRequest['ssn']='1267';
//$postRequest['birthday']='19820115';
$postRequest['address1']='100 Main st';
$postRequest['city']='Seattle';
$postRequest['state']='WA';
$postRequest['zip_code']='98102';
$postRequest['country']='US';
$postRequest['phone']='12063582043';
$postRequest['cell_phone']='19023384543';
$postRequest['amount']='10.42';
$postRequest['email']='john.smith@gmail.com';
$postRequest['currency']='EUR';
$postRequest['ipaddress']='65.153.12.232';
$postRequest['site_url']='www.google.com';
  //$postRequest['purpose']='newpurpose';
$postRequest['redirect_url']='http://www.example.com/';
$postRequest['server_callback_url']='https://httpstat.us/200';

//$postRequest['merchant_data']='VIP customer';
//$postRequest['dapi_imei']='123';



//will send control from here which is the field in request  will generate signature
// 1B962E87-86C5-4863-90B2-FB58D8721717 this value provided by integration team
$postreq['endpointid'] = "2545";
$postreq['amount'] = (double)$postRequest['amount'] * 100;
$postreq['merchant_control']="1B962E87-86C5-4863-90B2-FB58D8721717";
$str = $postreq['endpointid'].''.$postRequest['client_orderid'].''.$postreq['amount'].''.$postRequest['email'].''.$postreq['merchant_control'];
   
//echo $str;
   
$checksum = sha1($str);

echo "<br/>checksum=>".$checksum."<br/>";


$postRequest['control']=$checksum;

$postRequestStr=http_build_query($postRequest);

$url='https://sandbox.lonapay24.com/payment/api/v2/sale/group/'.$postreq['endpointid'];

$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => $url,
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
  CURLOPT_POSTFIELDS => $postRequestStr,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded'
  ),
));



$response = curl_exec($curl);

curl_close($curl);

echo "<br/>url=> ".$url;
echo "<br/><br/>postRequestStr=> ".$postRequestStr;

echo  "<br/><br/>response=>".$response;



?>