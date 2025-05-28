<?php

$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://rapidprod-sendgrid-v1.p.rapidapi.com/mail/send",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "POST",
	CURLOPT_POSTFIELDS => "{\r\n    \"personalizations\": [\r\n        {\r\n            \"to\": [\r\n                {\r\n                    \"email\": \"rajneshs@bigit.io\"\r\n                }\r\n            ],\r\n            \"subject\": \"Sendgrid API Testing!\"\r\n        }\r\n    ],\r\n    \"from\": {\r\n        \"email\": \"test@example.com\"\r\n    },\r\n    \"content\": [\r\n        {\r\n            \"type\": \"text/plain\",\r\n            \"value\": \"Sendgrid API Testing!\"\r\n        }\r\n    ]\r\n}",
	CURLOPT_HTTPHEADER => [
		"X-RapidAPI-Host: rapidprod-sendgrid-v1.p.rapidapi.com",
		"X-RapidAPI-Key: aac84d61afmsha9a687286f524cap19ff6bjsn8f6e1bdd1777",
		"content-type: application/json"
	],
]);
$response = curl_exec($curl);
$err = curl_error($curl);

curl_close($curl);

if ($err) {
	echo "cURL Error #:" . $err;
} else {
	echo $response;
}