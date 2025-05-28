<?
function currencyConverter($from_Currency='USD',$to_Currency='CAD',$amount=1,$gateway=false,$results=false) {
	
	//free api
	// Login Url: rapidapi_com
	// API key : aac84d61afmsha9a687286f524cap19ff6bjsn8f6e1bdd1777
	// api url : https://currency-converter18.p.rapidapi.com/api/v1/convert?from=USD&to=INR&amount=10
	
	global $data;$qprint=0; $dbf=1;
	
	
	try {
	
		if(isset($_GET['f'])&&$_GET['f']=='c'){
			$qprint=1;
		}
	
	
		$result=array();
		$from_Currency	= urlencode($from_Currency);
		$to_Currency	= urlencode($to_Currency);
		
		$result['from_Currency']=$from_Currency;
		$result['to_Currency']	=$to_Currency;
		$result['amount']		=$amount;
		$result['digit_after_dot']="4";
		
		
		//select db -------------------------------------------- 
		if($dbf){

			$exchange_rate_select_db=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}currency_exchange_table`".
				" WHERE ( `currency_from`='{$from_Currency}' AND `currency_to`='{$to_Currency}' ) ORDER BY `id` DESC LIMIT 1 ",$qprint
			);
			$exchange_rate_size=sizeof($exchange_rate_select_db);
			$exchange_rate_select=$exchange_rate_select_db[0];
			
			$current_date_2h=date('YmdHis', strtotime("-2 hours"));
			$db_timestamp	=date('YmdHis', strtotime($exchange_rate_select['timestamp']));

			$response_json	=$exchange_rate_select['currency_josn'];

			if($qprint){
				
				echo "<br/>$exchange_rate_size=>".$exchange_rate_size; 
				
				echo "<br/>db_timestamp=>".(int)$db_timestamp; 
				echo "<br/>current_date_2h=>".(int)$current_date_2h;
				
				echo "<br/><br/>commentTime=>".date('d-m-Y H:i:s', $exchange_rate_select['comments']);
				echo "<br/>db_timestamp=>".date('d-m-Y H:i:s', strtotime($db_timestamp));

				echo "<br/><br/>(current_date) - 2=> ".date('d-m-Y H:i:s A', strtotime($current_date_2h));
				echo "<br/>(current_date) + 0=>".date('d-m-Y H:i:s A');
				
				$time1 = new DateTime($db_timestamp);
				//$time2 = new DateTime($current_date_2h);
				$time2 = new DateTime(date('Y-m-d H:i:s'));
				$timediff = $time1->diff($time2);
				echo "<br/><br/>diff (db_timestamp - current_date)=>".$timediff->format('%y year %m month %d days %h hour %i minute %s second')."<br/>";
			}
				
			//update db -------------------------------------------- 
			if(($db_timestamp<$current_date_2h)||($exchange_rate_size==0)){
				
				$response_json=get_latest_rapid_currency($from_Currency,$to_Currency,$amount);

				if(false !== $response_api_get){

					$response_api_object = json_decode($response_json,true);

					$amountToConvert=$response_api_object['result']['amountToConvert'];
					$convertedAmount=$response_api_object['result']['convertedAmount'];
	//				$conversion_rate=round(($convertedAmount/$amountToConvert),$result['digit_after_dot']);
					$conversion_rate=($convertedAmount/$amountToConvert);

					$response_api_object['base_code']=$from_Currency;
					$response_api_object['conversion_rates'][$from_Currency]=1;
					$response_api_object['conversion_rates'][$to_Currency]=$conversion_rate;
					
					$response_json = json_encode($response_api_object);
//					print_r($response_api_object);exit;
					if($response_api_object['success']==true) {
						
						$timestamp=date('Y-m-d H:i:s');
						
						$sqlStmt = "INSERT INTO `{$data['DbPrefix']}currency_exchange_table`(".
							"`currency_from`,`currency_to`,`timestamp`,`currency_josn`,`comments`".
							")VALUES(".
							"'{$response_api_object['result']['from']}','{$response_api_object['result']['to']}','{$timestamp}','{$response_json}',''".
							")";
						//echo $sqlStmt;exit;
						db_query($sqlStmt,0);
					}
				} 
			}
			
		} //--------------------------------------
		else{
			$response_json=get_latest_rapid_currency($from_Currency,$to_Currency,$amount);
		}
		// currency calculation ----------------------------
		if(false !== $response_json) {


			if($qprint){ echo '<br/><br/>'.$response_json .'<br/><br/>'; }

			$response_object = json_decode($response_json,true);

			if($qprint){ echo '<br/><br/>response_object=>';print_r($response_object); }

			if(isset($response_object['conversion_rates'][$to_Currency]) && $response_object['success']) {

				$rates=$response_object['conversion_rates'][$to_Currency];
				if($qprint){ echo '<br/><br/>rates_get=>'.$rates .''; }
				if(($dbf)&&$to_Currency==$response_object['base_code']){
					$rates=(1/(double)$response_object['conversion_rates'][$from_Currency]);
					if($qprint){ echo "<br/>rates {$to_Currency}=>".$rates .'<br/><br/>'; }
				}
				
				$per_rates=number_format((double)(1 * $rates), $result['digit_after_dot'], '.', '');
				
				$result['rates_accurate']="1 ".$result['from_Currency']." to ".($per_rates). " ".$to_Currency;
				
				$result['per_rates']=$per_rates;
				
				
				$currency = ($amount * $rates); 
				
				$result['converted_amount_accurate']=$currency;

			}
		}
		
		
		if($gateway){
			$currency_g=(($currency*2.676)/100); // 2.676%
			$currency_f=($currency + $currency_g); // +2.676%
			$result['cal_rate']="+2.676%";
		}else{
			$currency_35=(($currency*1.553)/100); // 3.553%
			$currency_f=($currency - $currency_35); // -3.553%
			$result['cal_rate']="-1.553%";
		}
		
		$currency_f=number_format((double)$currency_f, '2', '.', '');
		
		$per_rates_cal=($currency_f/$amount);
		$result['per_rates_cal']=number_format((double)$per_rates_cal,$result['digit_after_dot'],'.', '');

		$result['rates']="1 ".$result['from_Currency']." to ".($result['per_rates_cal']). " ".$to_Currency;

		$result['converted_amount']=$currency_f;
		
		if($results){
			return $result;
		}else{
			return $currency_f;
		}

	}
	catch(Exception $e) {
		echo '<=currencyConverter=> ' .$e->getMessage();
	}
}

function get_latest_rapid_currency($currFrom, $currTo, $amount)
{
	$api_key = "aac84d61afmsha9a687286f524cap19ff6bjsn8f6e1bdd1777";

	$curl = curl_init();
	
	$post_url = "https://currency-converter18.p.rapidapi.com/api/v1/convert?from=$currFrom&to=$currTo&amount=$amount";
	
	curl_setopt_array($curl, [
		CURLOPT_URL => $post_url,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "GET",
		CURLOPT_HTTPHEADER => [
			"X-RapidAPI-Host: currency-converter18.p.rapidapi.com",
			"X-RapidAPI-Key: $api_key"
		],
	]);

	$response = curl_exec($curl);
	$err = curl_error($curl);

	curl_close($curl);

	if ($err) {
		return "cURL Error #:" . $err;
	} else {
		return $response;
	}
}
?>