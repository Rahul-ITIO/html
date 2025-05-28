<?
include_once "../config.do";

$api_key='aac84d61afmsha9a687286f524cap19ff6bjsn8f6e1bdd1777';

if(isset($_SESSION['domain_server']['as']['rapid_api'])&&$_SESSION['domain_server']['as']['rapid_api'])
	$api_key = $_SESSION['domain_server']['as']['rapid_api'];


if($api_key)
{
	$remote_addr=$_REQUEST['remote'];
	
	$curl = curl_init();
	
	curl_setopt_array($curl, [
		CURLOPT_URL => "https://ip-geolocation-ipwhois-io.p.rapidapi.com/json/?ip=$remote_addr",
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "GET",
		CURLOPT_HTTPHEADER => [
			"X-RapidAPI-Host: ip-geolocation-ipwhois-io.p.rapidapi.com",
			"X-RapidAPI-Key: $api_key"
		],
	]);
	
	$response = curl_exec($curl);
	$err = curl_error($curl);
	
	curl_close($curl);
	
	if ($err) {
		echo "cURL Error #:" . $err;
	} else {
		//echo $response;
		$locations = json_decode($response,1);
	//	print_r($locations);
	
		if (!empty($locations) && is_array($locations)) {
			echo "<p>\n";
			echo "<strong>$remote_addr result</strong><br />\n";
			foreach ($locations as $field => $val) {
				echo $field . ' : ' . $val . "<br />\n";
			}
			echo "</p>\n";
		}
	}
}
exit;

?>