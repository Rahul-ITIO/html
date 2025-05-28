<?php
//https://docs.newscatcherapi.com/api-docs/endpoints/latest-headlines
$topic="sport"; 
//news,sport,tech, world, finance,politics,business,economics,entertainment,beauty,travel,music,food,science,gaming,energy
$countries="IN";  //au,fr,gb,in,ru,us   ISO 3166-1 country
$api="OWYKIR0_TIuzEOZqc3gh-njgis2qv0bt7ma8-4IVWO4";
//$url="https://api.newscatcherapi.com/v2/latest_headlines?countries=$countries&topic=$topic&page=100&page_size=100";
$url="https://api.newscatcherapi.com/v2/latest_headlines?countries=$countries&topic=$topic&page=100&page_size=100";
            
			$curl = curl_init();
		    curl_setopt_array($curl, [
			CURLOPT_URL => $url,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => "",
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 30,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'GET',
			CURLOPT_HTTPHEADER => array(
            "x-api-key: $api"
            ),
		]);
	
		$response = curl_exec($curl);	
		curl_close($curl);
		//echo $response;
		$obj2 = json_decode($response, 1);
		print_r($obj2);
	
		
?>
