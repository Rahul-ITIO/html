<?php

// http://localhost:8080/gw/payin/pay52/hardcode/payment_52_hardcode.php

$apiKey = '1yXt$PC3X0FLoigs'; // Replace with your actual API key for Bearer in header


$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://staging.borderlesspaymentng.com/api/charge/validation',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "reference" : "12300002"
}',
  CURLOPT_HTTPHEADER => array(
    'Authorization: Bearer 1yXt$PC3X0FLoigs',
    'Content-Type: application/json',
    'Cookie: XSRF-TOKEN=eyJpdiI6IjdIZGZ4VE44aXFZN1RVa2ZmbkdWV0E9PSIsInZhbHVlIjoiMUIzNFJWWVp2dDNZZjExcVZvNksxbGYrYzROa2NmaHUwek1JNlc2QTAzVjVMZ1J3Vm91Si9zcEM2VitrbDE5S1VPV3c3SVVKYXNxQ3hrYzNGenNDU3pNWEs3Nlo5ZHN6QWJSbFBoTlFXbGMrTFhDQ0pkQmpQRGMzdHpaRmEvYWIiLCJtYWMiOiIxNDdmZWVlMzIyODBjMDE5ZjMzZWVjNzgyMTkxODYwNDU5YTc2YjdmZTQ2YTkyZGE3ZGYyNTA4N2E3N2MwMjQ2IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IllyUi96dElSMmlZd1FzeW5paVJqcGc9PSIsInZhbHVlIjoiMERqMmphSDFxN00rQmg3K1cxQmwzK290bFo1ZFRmdzNCRTdCYXgzZENTRWJWZVlTdWJiTnVUUjFSU3lSSGdjQTRUOW5tbUk5R3Z4SWpJV3UzMTBVbGpVTjcxeWhNN2VmbWRBTGdhVmFtT1YvcTQrNjFaaTJ2UWowWnhUOEFOUlkiLCJtYWMiOiI0MmRiYmNiYmRkM2U2MDYzZjFiNGFkYjliMDY2YzRjNDEzZWQwNjQzMDUyNzAxNTFhZWQzNGVkZjI3MzIwYjQ5IiwidGFnIjoiIn0%3D'
  ),
));

$response = curl_exec($curl);

curl_close($curl);


echo "<br/><hr/><br/><h3>response</h3><br/>=>";
print_r($response);


/*

{
    "data": {
        "trxDetails": {
            "status": "pending",
            "message": "None",
            "trxRef": "12300002",
            "amount": "0.01",
            "currency": "USD",
            "transDate": "2024-08-03 05:01:46"
        },
        "custDetails": {
            "fullName": "First Last",
            "email": "123000@gmail.com",
            "phone": "+15556664444"
        },
        "cardDetails": {
            "cardType": "MASTERCARD",
            "cardNumber": "555555******6666",
            "expiryDate": "10/2031"
        }
    },
    "message": "success",
    "status": "success"
}

*/




?>
