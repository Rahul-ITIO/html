<?php
// http://localhost:8080/gw/api-test/egera/payment_api.php

// Define parameters
$amount = '100';
$fiat = 'pln';
$currency = 'usdt';
$chain = 'trx';
$address = 'TGmEwV1RrNiF9f1Dk7By1Xk8F63P5jcbT1'; // Settle address
$hosted = 'hosted';
$channel = 'blik';
$email = 'jan@email.pl';
$phone = '48123456789';
$name = 'Jan';
$surname = 'Nowak';
$home_address = 'ul. Bliska 12C/109';
$postal = '60-123';
$city = 'Gniezno';
$respect_unique = 'on';
$drapes = 'off';
$return_url = 'https://prod-gate.i15.me/payin/pay116/webhookhandler_116';
$custom_code = 'xyz-1ks-x9z';
$passphrase = 'cFxwTHcxxGP6re'; // Updated password
$partnerid = '6f8b8806-b097-4e5e-81be-825653688aa8'; // Integration ID

// Generate checksum
$code = hash('sha256', $amount . $fiat . $currency . $chain . $address . $hosted . $custom_code . $passphrase);

// Generate payment link
$payment_link = "https://sandbox-checkout.egera.com/en/checkout?language=pl&amount=$amount&fiat=$fiat&currency=$currency&chain=$chain&address=$address&hosted=$hosted&channel=$channel&phone=$phone&email=$email&name=$name&surname=$surname&home-address=$home_address&postal=$postal&city=$city&respect_unique=$respect_unique&drapes=$drapes&custom_code=$custom_code&passphrase=$passphrase&partnerid=$partnerid&code=$code";

echo "Payment Link: $payment_link\n";

// Validate webhook checksum
$webhook_body = '{ 
  "version":"v2",
  "trigger":"order.cancel",
  "custom_code":"xyz-1ks-x9z",
  "tx_uuid":"b7a21d77-6f94-4c5a-9ad2-e45f7439b25f",
  "checksum":"'.$code.'"
}';

$decoded_body = json_decode($webhook_body);
$received_checksum = $decoded_body->checksum;
unset($decoded_body->checksum);
$generated_checksum = hash('sha256', json_encode($decoded_body) . $passphrase);

if ($received_checksum === $generated_checksum) {
    echo "Checksum is correct, webhook sent from Egera";
} else {
    echo "Checksum validation failed.";
}


?>
