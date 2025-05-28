<?php

//will send control from here which is the field in request  will generate signature
// 1B962E87-86C5-4863-90B2-FB58D8721717 this value provided by integration team
$postreq['endpointid'] = "2545";
$postreq['client_orderid'] = "902B4FF56";
$postreq['amount'] = "1042";
$postreq['email'] = "john.smith@gmail.com";
$postreq['merchant_control']="1B962E87-86C5-4863-90B2-FB58D8721717";
$str = $postreq['endpointid'].''.$postreq['client_orderid'].''.$postreq['amount'].''.$postreq['email'].''.$postreq['merchant_control'];
   //echo $str;
   
  echo  $checksum = sha1($str)


//there will go enpoint group id which provided by untegration team 2545

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://sandbox.lonapay24.com/payment/api/v2/sale/group/2545',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => 'credit_card_number=4538977399606732&card_printed_name=CARD%20HOLDER&expire_month=12&expire_year=2099&cvv2=123&client_orderid=902B4FF56&order_desc=Test%20Order%20Description&first_name=deepti&last_name=tyagi&ssn=1267&birthday=19820115&address1=100%20Main%20st&city=Seattle&state=WA&zip_code=98102&country=US&phone=987655443&cell_phone=987777745&email=john.smith%40gmail.com&currency=EUR&amount=10.42&ipaddress=65.153.12.232&redirect_url=http%3A%2F%2Flocalhost%2Ftest%2Fsuccess.php&server_callback_url=https%3A%2F%2Fwebhook.site%2F67b185e8-317c-4bee-89e3-1d35510c0d56&control=a9d3712323ae08641e19671caa497b8e78c713b3',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded',
    'Authorization: Bearer bOpEE0OQAEjobPfVvyGGVfTICAx6'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
?>