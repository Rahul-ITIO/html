<?
function card_binf($ccno)
{
	global $data; 
	$result		=array();

	$apiKey		= "2537209254c3abf2021387fb90027352";
	$secretKey	= "9f2a0fdf4c12f5e8bea711b7ca18342fcd35b6c1";

	$qp=0;
	if(isset($_GET['qp'])){
		$qp=$_GET['qp'];
	}

	$bin	= substr($ccno, 0, 6);

	$card_detail = db_rows(
		"SELECT * FROM `{$data['DbPrefix']}api_card_table`" .
		" WHERE `bin_number`='{$bin}' LIMIT 1"
	);

	if(isset($card_detail[0]['id'])){
		$result=$card_detail[0];
		$result['josn']=json_decode($card_detail[0]['josn'],1);
	}
	else
	{
		$curl = curl_init();
		curl_setopt_array($curl, array(
			CURLOPT_URL => 'https://api.cashfree.com/api/v1/vault/cards/cardbin',
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 0,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS => 'appId='.$apiKey.'&secretKey='.$secretKey.'&cardBin='.$bin,
			CURLOPT_HTTPHEADER => array(
				'content-type: application/x-www-form-urlencoded'
			),
		));
			
		$response = curl_exec($curl);
		curl_close($curl);
		//echo $response;


		$responseParam = json_decode($response,true);
		

		if(isset($responseParam['status'])&&$responseParam['status']=='OK'){

			$bank_name = $responseParam['cards']['bank'];
			$card_type = $responseParam['cards']['type'];

			$result['bank_name']	=$bank_name;
			$result['card_type']	=$card_type;
			$result['bin_number']	=$bin;
			$result['josn']			=json_encode($responseParam['cards']);

			db_query(
				"INSERT INTO `{$data['DbPrefix']}api_card_table`(".
				"`card_type`,`bin_number`,`bank_name`,`josn`".
				")VALUES(".
				"'{$card_type}','{$bin}','{$bank_name}','{$result['josn']}'".
				")",0
			);
		}
	}
	return $result;
}

?>