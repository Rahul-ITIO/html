<?php

$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://ip-geolocation-ipwhois-io.p.rapidapi.com/json/?ip=68.233.228.235",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"X-RapidAPI-Host: ip-geolocation-ipwhois-io.p.rapidapi.com",
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
exit;

$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://find-any-ip-address-or-domain-location-world-wide.p.rapidapi.com/iplocation?apikey=873dbe322aea47f89dcf729dcc8f60e8",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"X-RapidAPI-Host: find-any-ip-address-or-domain-location-world-wide.p.rapidapi.com",
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
	
	print_r(json_decode($response,1));
}