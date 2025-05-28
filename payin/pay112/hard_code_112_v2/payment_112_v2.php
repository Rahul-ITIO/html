<?php
//1121 v3

// {"ServiceCode":"COGCHE197","ClientCode":"COGMER-5WXOBTC","ConsumerKey":"9nUfLzIwMCmF0kk4zZCOi8MGSWTFC1","ConsumerSecret":"GZJECZKhfAJ0rWtPpKXndvPXQYg2DW","AccessKey":"lcdr1TG6Njqs8q1rBlEqrIWCrjWHSP","IVKey":"5re4WY3wnpnS4kxtn4MimJJBjO4ZYp","v":"2"}


//Step : 1 - auth #############################################

$curl = curl_init();

curl_setopt_array($curl, array(
	CURLOPT_URL => 'https://api.lipad.io/v1/auth',
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
    "consumer_key":"9nUfLzIwMCmF0kk4zZCOi8MGSWTFC1",
    "consumer_secret":"GZJECZKhfAJ0rWtPpKXndvPXQYg2DW"
}',
	CURLOPT_HTTPHEADER => array(
		'Content-Type: application/json'
	),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRfaWQiOiIyMiIsImRlc2lnbmF0aW9uIjoiQXBpIFVzZXIiLCJhdXRob3JpemVkIjp0cnVlLCJpYXQiOjE3MzY5NDIzNDgsImV4cCI6MTczNjk0ODM0OH0.J3XeYtsC7ARaVMRkgkGbOu5VrAqYbZ9Or7u9DfsGygU",
    "expiresIn": 6000
}

*/


//Step : 2 - Charge Request java #############################################
	

$curl = curl_init();

curl_setopt_array($curl, array(
	CURLOPT_URL => 'https://api.lipad.io/v1/checkout/api/card',
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
    "access_key": "lcdr1TG6Njqs8q1rBlEqrIWCrjWHSP", 
    "data": "W72plyK6VpIwhXo5J0vMxiUYO+2qDWOc7pU9PEdOVtL3AAeJvqmAeiwAlCqYFkYv7MsjoCOXe947S+LjmEhTMVuNKaeZDJLhVjNY4KNwMuW4JMFK/Gq5cX/F/hBi0lVv2zRR0sAC7zEcXX08c/G8ojyN6zGDczRsDYDwDosX32g7WJ6+rGQAZHXs2Lu3S9QpJuBXQEPmxBCpCBMS7WKRTNAvvEZ4WuqtyETmlXYHkYScaTYjkO/pHokJIuMa2s2UdXi3KayMnZ5QqCSc2ke+6tt1Y/SAeCb+c9KGKkROZFZ8T3Z/BLKqT8JZUreAjHE7an8qh55BnuKky5jRzQuIWs42DWAs12HUaatp1rX2JHbja3hLG+1O57Hg8qCqxqgxZPqy1FPrNz862fepPm9Uo4TA/GmC/KXjER5k4Wrr61kL7mHSS2CyJGhw8jpb7ecSUvDRMRoD5WNQaNtliHYNcZzmif/Z8TJpcNCfXY/Xw2qRxxbKSWh7eKJDaVCQi44RROiwClGCSJg1tQkqS7BK2ueWit+yMErmK6fQHLkkJRtQ9jTt5BxGKPzvnMDLq31HZguL1dize53EUKmfB99zNTJHrLEXgy8+AOD5QxKOoh4WhAxqoidoQaiG67tne5YcvQ/L/kzM4j6maimCUjk8QzqBZTn4a3LMNOuZASyG4v1wl2pUjrHlVrg1rS6tlXqQ6ta1MbjBNeInLi4gknyb+H45JaFpzJGDlvgQZ1Hiu3BIs74wwiNxTygix2Rfqc4i08AM95qlzT9i+/9Xy4HYUK/Ir2G6tOXXQ9nDAhi11TfwE/7bO/pe5JSlmtY6cmU1vCzwvaW01OnEtpXrokh/xUAM8De/uceNQZyhN950y4TurjDz04B+s7fEKlgnGA8oo27mYbz6GfEc/ULB8uSe4YJAOkxQpsKlZiWun2SIMf0UHRnJGi7DE4FbUmlgkwm7DmRu2MDw2JJ2EMqCSffkqfGdJPpbPG66mUuxRr7Yla/NqssGTZeh4IjJeR7NpDwwRDBJQP59wEl+2cOwPdtml5unl4pcYpR2K7vpPwMlykrtHG0hcMcWLTIkAjWzGkBT3iSaV6zLVw9UvPVPyExXKxa1KRJsjjKne+Y+Wn0zo4e0huoPS63ZUI/5uF+BqgWCCYRYGspOxp94LruNaoNBRhtyM14zghfS+iNC1fIo9HlqnwOQp6jTOSCprVK8RRzJ67wHE9YgG79h5FVVJVaqHIiPLY14JoF3fFs5bhHpVYLXbVeUDBPu0tP6WMmj08d89PzV2xRpSyfhGaJElD0LTiT9v4PAPJ0ofW8159aLWCH8LASeVkm7PaOv+7rb1fmNqZR5Opq3LalXJAP2UdcLF0XcXNz82uwwERcgjp+jip8u3ddQlrPVdEjdbES+wjT9sFyCKTXthyiRI2djo4iYemgSaUyyyzWJT75Eg1umIS+uoVKJzHerVIjyeFh6npF06DSqQKvpA4enBLJRdTHnwzPGPDKObp5ZkX8sU4OzNldBF9lJATLZL2LioKcphu0d"
}',
	CURLOPT_HTTPHEADER => array(
		'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRfaWQiOiIyMiIsImRlc2lnbmF0aW9uIjoiQXBpIFVzZXIiLCJhdXRob3JpemVkIjp0cnVlLCJpYXQiOjE3MzY5NDIzNDgsImV4cCI6MTczNjk0ODM0OH0.J3XeYtsC7ARaVMRkgkGbOu5VrAqYbZ9Or7u9DfsGygU',
		'Content-Type: application/json'
	),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{
    "status_code": 176,
    "status_description": "Request to charge customer was successfully placed.",
    "total_amount": "12.75",
    "service_amount": "12.75",
    "transaction_charge": 0,
    "charge_request_id": "22406",
    "external_reference": "1121106195306",
    "auth_available": true,
    "auth_url": "https://pay.cross-switch-pay.com/pwthree/launch?payload=%7B%22timestamp%22%3A1736944384%2C%22merchantAccount%22%3A%22SMARTHOST%22%2C%22mode%22%3A%22PROXY%22%2C%22poId%22%3A29077210%2C%22chargeId%22%3A%22af714349f1624fb8a10d50c84714dd67%22%2C%22customerLocale%22%3A%22en_US%22%7D&signature=a43ce1e69b38c700cf932550726383cd33a8e1c8bc2b28427f85eb5f54e072b9"
}


https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard&params={"success":false,"pending":false,"merchantOrderId":"1c5a2042b7fe4a589c49cf1527ce899f","exitCode":4001,"exitCodeDesc":"Purchase failed for unknown reason"}&signature=699f4c9ce1b3da06f90a1fbd2792c4c732aa68425ff98be1171aede0a6a87d2d


https://aws-cc-uat.web1.one/responseDataList/?urlaction=notify_mastercard&params=%7B%22success%22%3Afalse%2C%22pending%22%3Afalse%2C%22merchantOrderId%22%3A%221c5a2042b7fe4a589c49cf1527ce899f%22%2C%22exitCode%22%3A4001%2C%22exitCodeDesc%22%3A%22Purchase%20failed%20for%20unknown%20reason%22%7D&signature=699f4c9ce1b3da06f90a1fbd2792c4c732aa68425ff98be1171aede0a6a87d2d

*/

 ?>