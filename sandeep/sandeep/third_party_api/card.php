<?php

$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://bin-ip-checker.p.rapidapi.com/?bin=6070415006217147",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "POST",
	CURLOPT_POSTFIELDS => "{\r\n    \"bin\": \"6070415006217147\"\r\n}",
	CURLOPT_HTTPHEADER => [
		"X-RapidAPI-Host: bin-ip-checker.p.rapidapi.com",
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
//	echo $response;
	
	print_r(json_decode($response,1));
}