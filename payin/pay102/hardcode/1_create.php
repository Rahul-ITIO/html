<?php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://ap-gateway.mastercard.com/api/rest/version/78/merchant/GLADCORIGKEN/session',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "session": {
        "authenticationLimit": 25
    }
}',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: Basic bWVyY2hhbnQuR0xBRENPUklHS0VOOjRkM2Y4ZTA3YjJjNjI1ZDc3OWI4MWM2NzgwODZjYzFk'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{
    "merchant": "GLADCORIGKEN",
    "result": "SUCCESS",
    "session": {
        "aes256Key": "5IaIO6v13SaebTMhgwUDzxu8nsys05TrGkzc7gHtiWo=",
        "authenticationLimit": 25,
        "id": "SESSION0002794014567H3251842M57",
        "updateStatus": "NO_UPDATE",
        "version": "584857a801"
    }
}

*/


?>