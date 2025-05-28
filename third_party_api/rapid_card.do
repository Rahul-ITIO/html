<?php
function card_binf($ccno)
{
	global $data; 
	$result		=array();
	
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
		$post_data['bin']=$ccno;
		
		$curl = curl_init();
		
		curl_setopt_array($curl, [
			CURLOPT_URL => "https://bin-ip-checker.p.rapidapi.com/?bin=$ccno",
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_ENCODING => "",
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 30,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => "POST",
			CURLOPT_POSTFIELDS => json_encode($post_data),
			CURLOPT_HTTPHEADER => [
				"X-RapidAPI-Host: bin-ip-checker.p.rapidapi.com",
				"X-RapidAPI-Key: aac84d61afmsha9a687286f524cap19ff6bjsn8f6e1bdd1777",
				"content-type: application/json"
			],
		]);
		
		$response = curl_exec($curl);
		$err = curl_error($curl);
		
		curl_close($curl);
		
		$responseParam = json_decode($response,true);
		
		if(isset($responseParam['success'])&&$responseParam['success']=='1'){

			$bank_name = $responseParam['BIN']['issuer']['name'];
			$card_type = $responseParam['BIN']['type'];

			$result['bank_name']	=$bank_name;
			$result['card_type']	=$card_type;
			$result['bin_number']	=$bin;
			$result['josn']			=json_encode($responseParam['BIN']);

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