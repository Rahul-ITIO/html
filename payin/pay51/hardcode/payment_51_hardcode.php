<?php

// http://localhost:8080/gw/payin/pay51/hardcode/payment_51_hardcode.php

$apiKey = 'test_Z2F0ZXdheS10ZXN0OmFmZjVhY2M2LTZhZjItNDVhYS04ZTk3LTcxYzA5ODM1NzAyMzpiMzVmODk3NS04NGE2LTRiZjItYjFhMC04NTM3ZTQ0MmI4NTk'; // Replace with your actual API key


### //Step 1: Initiate a Card Payment #############################################

function initiate_payment($apiKey) {
    $url = 'https://api-sandbox.spendjuice.com/payment-sessions';
    
    $data = [
        "customer" => [
            "first_name" => "Dev",
            "last_name" => "Tech",
            "email" => "devops@itio.in",
            "phone_number" => "+2348118873422",
            "billing_address" => [
                "line1" => "123 Main St",
                "line2" => "",
                "city" => "Springfield",
                "state" => "CA",
                "country" => "US",
                "zip_code" => "12345"
            ]
        ],
        "description" => "Test",
        "currency" => "USD",
        "amount" => 100,
        "direction" => "incoming",
        "payment_method" => [
            "type" => "card"
        ],
        "reference" => "1b09d9b2-11jd9eheveb-9203v0".rand(10,99),
        "settlement_target" => "business",
        "metadata" => [
            "order" => [
                "identifier" => "ORD12344",
                "items" => [
                    [
                        "name" => "Deposit",
                        "type" => "digital"
                    ]
                ]
            ]
        ]
    ];
    
    $options = [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_HTTPHEADER => [
            'Authorization: ' . $apiKey,
            'Content-Type: application/json'
        ],
        CURLOPT_POSTFIELDS => json_encode($data)
    ];
    
    $ch = curl_init();
    curl_setopt_array($ch, $options);
    $response = curl_exec($ch);
    curl_close($ch);
    
    return json_decode($response, true);
}

$paymentResponse = initiate_payment($apiKey);
$paymentId = $paymentResponse['data']['payment']['id'];


echo "<br/><hr/><br/><h3>Step 1: Initiate a Card Payment</h3><br/>paymentResponse=><br/>";
print_r($paymentResponse);

echo "<br/><br/>paymentId=><br/>";
print_r($paymentId);


### //Step 2: Encrypt Card Information #############################################

function encrypt_card($apiKey) {
    $url = 'https://api-sandbox.spendjuice.com/payment-sessions/encryption-keys/test';
    
    $data = [
        "card" => [
            "card_number" => "5123450000000008",
            "name" => "test",
            "cvv" => "100",
            "expiry_month" => 1,
            "expiry_year" => 2039
        ]
    ];
    
    $options = [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_HTTPHEADER => [
            'Authorization: ' . $apiKey,
            'Content-Type: application/json'
        ],
        CURLOPT_POSTFIELDS => json_encode($data)
    ];
    
    $ch = curl_init();
    curl_setopt_array($ch, $options);
    $response = curl_exec($ch);
    curl_close($ch);
    
    return json_decode($response, true)['data']['encryption_key'];
}

$encryptionKey = encrypt_card($apiKey);


echo "<br/><hr/><br/><h3>Step 2: Encrypt Card Information</h3><br/>encryptionKey=><br/>";
print_r($encryptionKey);


### //Step 3: Capture the Payment #############################################

function card_encrypt($payload, $key) {
    $cipher = "aes-256-gcm";
    $iv = openssl_random_pseudo_bytes(16);
    $cipher_text = openssl_encrypt($payload, $cipher, $key, OPENSSL_RAW_DATA, $iv, $tag);
    return implode(':', [bin2hex($iv), bin2hex($cipher_text), bin2hex($tag)]);
}

function capture_payment($apiKey, $paymentId, $cardDetails, $encryptionKey) {
    $url = 'https://api-sandbox.spendjuice.com/payment-sessions/' . $paymentId;

    $encryptedCardNumber = card_encrypt($cardDetails['card_number'], $encryptionKey);
    $encryptedCvv = card_encrypt($cardDetails['cvv'], $encryptionKey);

    $data = [
        "card" => [
            "card_number" => $encryptedCardNumber,
            "name" => $cardDetails['name'],
            "cvv" => $encryptedCvv,
            "expiry_month" => $cardDetails['expiry_month'],
            "expiry_year" => $cardDetails['expiry_year']
        ]
    ];

    $options = [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_HTTPHEADER => [
            'Authorization: ' . $apiKey,
            'Content-Type: application/json'
        ],
        CURLOPT_POSTFIELDS => json_encode($data)
    ];

    $ch = curl_init();
    curl_setopt_array($ch, $options);
    $response = curl_exec($ch);
    curl_close($ch);

    return json_decode($response, true);
}

$cardDetails = [
    'card_number' => '5123450000000008',
    'name' => 'test',
    'cvv' => '100',
    'expiry_month' => 1,
    'expiry_year' => 2039
];

$captureResponse = capture_payment($apiKey, $paymentId, $cardDetails, $encryptionKey);


echo "<br/><hr/><br/><h3>Step 3: Capture the Payment</h3><br/>captureResponse=><br/>";
print_r($captureResponse);





?>
