<?
function card_binf($ccno)
{
	global $data; 
	$result=array();
	$apikey	= "b6001e47093c91fc4351c58c2a0cd113";
	$format = "json"; $qp=0;
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
		$url ="https://api.bincodes.com/bin/?format=$format&api_key=$apikey&bin=$bin";

		$curl = curl_init();

		curl_setopt_array($curl, array(
			CURLOPT_URL => $url,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 0,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'GET',
		));

		$josn = curl_exec($curl);
		curl_close($curl);

		$responseParam = json_decode($josn,true);
		$result['josn']=$responseParam;

		if(isset($responseParam['bank'])){
			$bank_name = $responseParam['bank'];
			$card_type = $responseParam['type'];

			$result['bank_name']=$bank_name;
			$result['card_type']=$card_type;
			$result['bin_number']=$bin;

			db_query(
				"INSERT INTO `{$data['DbPrefix']}api_card_table`(".
				"`card_type`,`bin_number`,`bank_name`,`josn`".
				")VALUES(".
				"'{$card_type}','{$bin}','{$bank_name}','{$josn}'".
				")"
			);
		}
	}
	return $result;
}

?>