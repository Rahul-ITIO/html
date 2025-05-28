<?php

// http://localhost:8080/gw/payin/pay52/hardcode/payment_52_hardcode.php

$apiKey = '1yXt$PC3X0FLoigs'; // Replace with your actual API key for Bearer in header

$transID='52'.date('YmdHis');

### //Step 1: Initiate a Card Payment #############################################

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://staging.borderlesspaymentng.com/api/charge',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_POSTFIELDS =>'{
    "firstname" : "'.@$post['ccholder'].'",
    "lastname" : "'.@$post['ccholder_lname'].'",
    "phone" : "'.@$bill_phone.'",
    "email" : "'.@$post['bill_email'].'",
    "address" : "'.@$post['bill_address'].'",
    "city" : "'.@$post['bill_city'].'",
    "state" : "'.@$post['state_two'].'",
    "country" : "'.@$post['country_two'].'",
    "zip_code" : "'.@$post['bill_zip'].'",
    "amount" : "'.$total_payment.'",
    "currency" : "'.@$orderCurrency.'",
    "cardName" : "'.@$post['fullname'].'",
    "cardNumber" : "'.@$post['ccno'].'",
    "cardCVV" : "'.@$post['ccvv'].'",
    "expMonth" : "'.@$post['month'].'",
    "expYear" : "'.@$post['year4'].'",
    "reference" : "'.$transID.'",
    "ip_address" : "'.@$_SESSION['bill_ip'].'",
    "webhook_url" : "'.$webhookhandler_url.'",
    "callback_url" : "'.$status_url_1.'"
}',
  CURLOPT_HTTPHEADER => array(
    'Authorization: Bearer 1yXt$PC3X0FLoigs',
    'Content-Type: application/json',
    'Cookie: XSRF-TOKEN=eyJpdiI6IjZIclE0WXB2ZWVIcWhhYjdUQjJYRkE9PSIsInZhbHVlIjoiUzJhRkpDUGVxaDVmNXV3STBUakFXWjQzeUlmTGE1dzN0ZlFGK1dKWm1ycGRqZCsxekFLWEcxcUdrcFdBdEM3ZmNjcG5QcC9yS1ZFSis3TUFQTTlZSllkVlpCS2dQRnMzVWp4ejNzSktETFVOeDR1K3JwdGRzWExTVFdwRkdzRHgiLCJtYWMiOiIyNzdkNjljZDE4OThjMzhiODViYWU0NjNlZThiZWU3ZjExNTk0MDY0ODcwY2MzZTc5MzM5MjE2MTE1YjBiNWU1IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjlkaFB1ejhobk93MFJTc3RGS0xGNEE9PSIsInZhbHVlIjoiUlpqMzVWVFhYUEs5amc3TnQrRFlOckkzWUVKRXdEdmwxeGMxQXVudTRKMTA1ZWtFbDdzMEtBZ2JmTnNxTlNDd0U1ZnMvdHRneStQVUp4cENZblRMUTcyUGJ6ZTRGTmxRS0pQV0dZaGxJQUhQbXNaMldoM3laTUdObFN4ZjduODEiLCJtYWMiOiJkNDg4MDFkZDZlN2RkODJmMzM5NDYyM2I3ZTQ2YTEyYjc5ZmZiMDQ2MjMzNjA3NDg0Njc4NzUxZTM3N2YyZjBlIiwidGFnIjoiIn0%3D'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

echo "<br/><hr/><br/><h3>response=></h3><br/>";
print_r($response);


/*

{
    "status": "success",
    "message": "success",
    "data": {
        "reference": "5220240803051044",
        "orderid": "fa6ffbabe485f970fd4b6393ee3a733f",
        "link": "https:\/\/staging.borderlesspaymentng.com\/api\/checkout\/1136\/eyJ1cmwiOiJodHRwczpcL1wvc3RhZ2luZy5ib3JkZXJsZXNzcGF5bWVudG5nLmNvbVwvYXBpXC8xMTM2XC9jYWxsYmFjayIsInR5cGUiOiIzRCIsImdhdGV3YXlpZCI6IjExMzYiLCJyZWZlcmVuY2UiOiI1MjIwMjQwODAzMDUxMDQ0IiwiYW1vdW50IjoiMC4wMSIsInRyYW5zZGF0ZSI6IjIwMjQtMDgtMDMgMDU6MTA6NDYiLCJpc19wbHVnaW4iOjF9"
    }
}

*/

/*

{
    "status": "success",
    "message": "success",
    "data": {
        "reference": "12300002",
        "orderid": "57d7b701255584761a49c5a4e5342d12",
        "link": "https://staging.borderlesspaymentng.com/api/checkout/1136/eyJ1cmwiOiJodHRwczpcL1wvc3RhZ2luZy5ib3JkZXJsZXNzcGF5bWVudG5nLmNvbVwvYXBpXC8xMTM2XC9jYWxsYmFjayIsInR5cGUiOiIzRCIsImdhdGV3YXlpZCI6IjExMzYiLCJyZWZlcmVuY2UiOiIxMjMwMDAwMiIsImFtb3VudCI6IjAuMDEiLCJ0cmFuc2RhdGUiOiIyMDI0LTA4LTAzIDA1OjAxOjQ1IiwiaXNfcGx1Z2luIjoxfQ=="
    }
}

*/




?>
