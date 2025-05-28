<?php

$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://currency-converter18.p.rapidapi.com/api/v1/convert?from=USD&to=INR&amount=10",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"X-RapidAPI-Host: currency-converter18.p.rapidapi.com",
		"X-RapidAPI-Key: aac84d61afmsha9a687286f524cap19ff6bjsn8f6e1bdd1777"
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