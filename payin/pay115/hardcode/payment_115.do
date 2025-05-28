<?php

//parameter for checksum we are making checksum in code parameter
$amount = '250';
$fiat = 'pln';
$currency = 'usdt';
$chain = 'trx';
$address = 'TGmEwV1RrNiF9f1Dk7By1Xk8F63P5jcbT1';
$hosted = 'hosted';
$custom_code = 'xyz-1ks-x9z';
$passphrase = 'cFxwTHcxxGP6re';

   $code = hash('sha256', $amount . $fiat . $currency . $chain . $address . $hosted . $custom_code . $passphrase);
  
// these are parameter
$params = [
    'amount' => '250',
    'fiat' => 'pln',
    'currency' => 'usdt',
    'chain' => 'trx',
    'address' => 'TGmEwV1RrNiF9f1Dk7By1Xk8F63P5jcbT1',
    'hosted' => 'hosted',
    'channel' => 'blik',
    'email' => 'jan@email.pl',
    'phone' => '48123456789',
    'name' => 'Jan',
    'surname' => 'Nowak',
    'home-address' => 'ul. Bliska 12C/109',
    'postal' => '60-123',
    'city' => 'Gniezno',
    'respect_uniqe' => 'on',
    'drapes' => 'on',
    'return_url' => 'http://localhost/test/success.php',
    'custom_code' => 'xyz-1ks-x9z',
    'partnerid' => '6f8b8806-b097-4e5e-81be-825653688aa8',
	'code' => $code,
];



 $queryString = http_build_query($params);

$baseUrl = 'https://sandbox-checkout.egera.com/en/checkout';


echo $fullUrl = $baseUrl . '?' . $queryString;





?>