<?php

$Username = "coma_6pnkH5vUZw0BlkZY";
 $Password = "W5sM1KBQQsBRIqc16oPurms-Uj5EsfGjJRON6f05ALM";
  $credentials = $Username . ':' . $Password;
  $encodedCredentials = base64_encode($credentials);
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://pay.wzrdpay.io/payment-invoices',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
      "data":{
          "type":"payment-invoices",
          "attributes":{
            "reference_id":"test45689",
            "amount":33,
            "currency":"EUR",
            "service":"payment_card_eur_hpp",
            "flow":"charge",
            "test_mode":true,
            "description":"Invoice Example",
            "gateway_options":{
                "cardgate":{
                  "tokenize":false
                }
            },
            "customer": {
                "reference_id": "1203515683",
                "name": "John Snow",
                "email": "somename@domain.com",
                "phone": "+380987654321",
                "date_of_birth": "2005-06-05",
                "address": {
                    "full_address": "via diagonal 25",
                    "country": "ES",
                    "region": "Catalonia",
                    "city": "Barcelona",
                    "street": "via diagonal 25",
                    "post_code": "37536"
                },
            "metadata": {
                    "key1": "value1",
                    "key2": "value2"
                }
            },
            "metadata":{
                "key":"value"
            },
            "return_url":"https://example.com",
            "return_urls": {
                "success":"https://example.com/1",
                "pending":"https://example.com/2",
                "fail":"https://example.com/3"
            },
            "callback_url":"https://example.com"
          }
      }
    }',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: Basic ' . $encodedCredentials
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

 
 ?>
