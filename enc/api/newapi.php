<?php
$key="pub_188900860dda2ea10be8b6e88f020ac920d10";

$url="https://newsdata.io/api/1/news?apikey=$key&language=en";
$url="https://newsdata.io/api/1/news?country=in&apikey=pub_188900860dda2ea10be8b6e88f020ac920d10";
             $curl = curl_init();
		    curl_setopt_array($curl, [
			CURLOPT_URL => $url,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => "",
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 30,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'GET',
		]);
	
		$response = curl_exec($curl);	
		curl_close($curl);
		//echo $response;
		
		$obj2 = json_decode($response, 1);
		
		echo $obj2;
		print_r($obj2);
	
		
?>
