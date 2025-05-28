<?php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://www.payit123.com/clients/paymentsolo/process_payment.php',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => array('fullName' => 'PANTELAKIS PANTELI','street1' => 'AbbeySide view Street','invoiceNumber' => 'TEST4789781','country' => 'CY','state' => 'Nicosia','city' => 'Limasol','email' => 'testuser@gmail.com','phone' => '9659012284','amount' => '1','currency' => 'USD','token' => '5e12cef38728dc61c68bfdf0cf1ed11d','postal_code' => '626189','return_url' => 'https://www.payit123.com/clients/paymentsolo/','status_url' => 'https://www.payit123.com/clients/paymentsolo/status.php'),
  CURLOPT_HTTPHEADER => array(
    'Authorization: Bearer 8e1fbd6f20ff0cfce4f40671a3bb2396'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{"code":"1","status":"Pending","currency":"USD","amount":"1","invoiceNumber":"PS_TEST4789781","message":"Client did not
complete
3d","3DSUrl":"https:\/\/www.payit123.com\/clients\/paymentsolo\/3ds_validation.php?hash=Nm5PQ2xuYjBuSGxvMDluMU1tRnAyNmpKaEExRlYzKzlwUWxac2hKbDlFUUdjZnkxV2c2cXQ1clJ1amtJdTJ0d3QyWUtXVzRDcTFHRzNNcDlSTGk3SmJEbTdoOGtOVjI4Z0pUbjFxWHdXTG89"}


*/



?>
