<?
include('../config.do');

$qp = 0;
//$qp = 1;

$str=file_get_contents("php://input");
$json = json_decode($str, true);
//print_r($json);
$json=$json[0];

if(isset($_REQUEST['pram_encode'])&&$_REQUEST['pram_encode']){

	$pram_encode1=strip_tags($_REQUEST['pram_encode']);
	$post['payout_token'] = substr( $pram_encode1, -86);

	if($data['localhosts']==true){
		//$post['payout_token'] = substr( $pram_encode1, -30 );
	}

	$pram_encode=str_replace($post['payout_token'],'',$pram_encode1);
	if(isset($_REQUEST['pe'])){
		//echo "<br/><br/>payout_token=>".$post['payout_token']; echo "<br/><br/>pram_encode1=>".$pram_encode1;
	}
}

//print_r($post);
$decode_token = decode_f($post['payout_token'],0);
//print_r($decode_token);exit;

$sub_client_id = json_decode($decode_token,1)['tid'];

//$respo['pram_encode1']	= $post['payout_token'];
//$respo['decode_token']	= $decode_token;
//$respo['sub_client_id']		= $sub_client_id;

//print_r($decode_token);
//$de_token = json_decode($decode_token,1);
//$tid=$de_token['tid'];

if(!$sub_client_id)
{
	$respo['status']="0005";
	$respo['reason']="Unauthorized - Invalid payout token or Invalid secret key";
	json_print($respo);
	exit;
}

//$acc_row = select_tablef("`id`='{$sub_client_id}' ",'clientid_table',0,1);
$acc_row = clientidf($sub_client_id,'payout_setting');

$secret_key			= $acc_row['apikey'];
$payoutFee			= $acc_row['payoutFee'];
$payout_request		= $acc_row['payout_request'];
$merchant_email		= encrypts_decrypts_emails($acc_row['email'],2);

$payout_secret_key		= json_decode($acc_row['payout_secret_key'],1)['decrypt'];
$payout_secret_key_gt	= json_decode($acc_row['payout_secret_key'],1)['gt'];	//get payout key generate time - 
$payout_token		= $acc_row['payout_token'];
$payout_account		= $acc_row['payout_account'];

/*
$json_value 		= jsondecode($acc_row['json_value'],1);
$whitelisted_ips	= $json_value['whitelisted_ips'];
*/

$whitelisted_ips	= @$acc_row['whitelisted_ips'];


$ips_array = explode(",",$whitelisted_ips);


$data_decode = data_decode_sha256($pram_encode,$secret_key,$post['payout_token']);

parse_str($data_decode, $output);

$de_submit_secret_key	= encode_f($output['payout_secret_key'],1);
$en_submit_secret_key	= json_decode($de_submit_secret_key,1)['decrypt'];

$is_ip_validation=true;

####	check is our host page	####################
$http_referer_log=0;
if(isset($_SERVER['HTTP_REFERER'])) 
$http_referer_host=$_SERVER['HTTP_REFERER'];
else $http_referer_host='';
if($http_referer_host){
	//echo "<br/>http_referer_host=>".$http_referer_host."<br/>";
	foreach($data['all_host'] as $ke=>$vl){
		//echo "<br/>$ke=>".$vl;
		if(($vl)&&(strpos($http_referer_host,$vl)!==false)){
			//echo "<br/>$ke=>".$vl;
			$http_referer_log=1; 
			break;
		}
	}
}
//echo "<br/>http_referer_log=>".$http_referer_log."<br/>";

if((isset($output['mer_id'])&&$output['mer_id']==$sub_client_id)&&((isset($_SERVER['HTTP_REFERER']))&&($http_referer_log==1))){
	$is_ip_validation=false;
}

//$respo['status']="$de_submit_secret_key";
//$respo['reason']="$en_submit_secret_key";
//json_print($respo);

$serverval	=$_SERVER['HTTP_REFERER'];
$servername	=$_SERVER['SERVER_NAME'];

$sub_client_id = ltrim($sub_client_id, "0");
if($payout_secret_key==$en_submit_secret_key)
{
	$curr_time = time();
	$cooling_period = round(abs($curr_time - $payout_secret_key_gt) / 60,2);	//calculate time from when payout key generated in minutes - 

	if($cooling_period<1440) // if the time is less than 1440 minutes (24 hrs) then not allow transfer fund
	{
		$respo['status']="0011";
		$respo['reason']="Payout Secret Key is in cooling period.";
		json_print($respo);
		exit;
	}

	$bene_list=db_rows_2(
		"SELECT bene_id FROM `{$data['DbPrefix']}payout_beneficiary`".
		" WHERE `clientid`='{$sub_client_id}' AND status='1'",0
	);

	foreach ($bene_list as $key => $val) {
		$bene_listArr[] = $val['bene_id'];
	}

	$sqlStmt = "SELECT SUM(converted_transaction_amount) AS balance FROM `{$data['DbPrefix']}payout_transaction` WHERE sub_client_id='{$sub_client_id}' AND transaction_status NOT IN (2)";
	$check_balance = db_rows_2($sqlStmt);

	if(isset($check_balance[0]['balance'])&&$check_balance[0]['balance'])
		$balance = $check_balance[0]['balance'];
	else
		$balance = 0;

	$payout_token		= $output['payout_token'];
	$client_ip			= $output['client_ip'];
	$action				= $output['action'];
	$source				= $output['source'];
//	$payout_secret_key	= $output['payout_secret_key'];
	$price				= $output['price'];
	$curr				= $output['curr'];

	$product_name		= $output['product_name'];
//	$transaction_id		= $output['transaction_id'];
	$beneficiary_id		= $output['beneficiary_id'];
	$pay_type			= $output['pay_type'];
	$remarks			= $output['remarks'];
	$narration			= $output['narration'];

	if(isset($output['source_url']))	$source_url = $output['source_url'];else $source_url ="";
	if(isset($output['notify_url']))	$notify_url = $output['notify_url'];else $notify_url ="";
	if(isset($output['success_url']))	$success_url= $output['success_url'];else $success_url ="";
	if(isset($output['failed_url']))	$failed_url = $output['failed_url'];else $failed_url ="";
//	if(isset($output['check_status']))	$check_status = $output['check_status'];else $check_status ="";

	if(isset($output['request_id'])&&$output['request_id'])
		$request_id		= $output['request_id'];
	else $request_id	= "";

	//$respo['beneficiary_id'] = $beneficiary_id;

	/*if(isset($output['ac_default_curr'])&&$output['ac_default_curr'])
		$ac_default_curr	= $output['ac_default_curr'];
	else
	{*/

	$bank_master	= select_tablef("`id` = '".$payout_account."'",'bank_payout_table');
	$ac_payout_id	= $bank_master['payout_id'];
	$ac_default_curr= $bank_master['payout_processing_currency'];

	$payout_dir = "p".$ac_payout_id;	// add "P" in directory name
	
	if(file_exists($data['Path'].'/payout/'.$payout_dir.'/acq_'.$ac_payout_id.$data['iex']))
	{
		include_once $data['Path'].'/payout/'.$payout_dir.'/acq_'.$ac_payout_id.$data['iex'];
	
		$check_status = 'payout/'.$payout_dir.'/status_'.$ac_payout_id.$data['ex'];
	}

	/*}*/
	/*
	if($is_ip_validation&&(!in_array($client_ip, $ips_array)))
	{
		$respo['status']="0011";
		$respo['reason']="Access Denied for client ip or IP not whitelisted, Please Contact Support.";
	}
	
	else */
	{
		if(in_array($beneficiary_id, $bene_listArr))
		{
		

			if($curr!=$ac_default_curr)
			{
				//CONVERT CURRENCY - START
				$currencyConverter_2=currencyConverter($curr, $ac_default_curr, $price, 0, 1);
				$json["currencyConverter"]=$currencyConverter_2;
				$transaction_amt=$currencyConverter_2['converted_amount'];
				//CONVERT CURRENCY - END
			}
			else $transaction_amt = $price;


			if($transaction_amt<=$balance)
			{
				//$available_balance=$balance-$transaction_amt;
	
				if($request_id)
				{
					$sqlStmt = "SELECT id FROM `{$data['DbPrefix']}payout_transaction` WHERE sub_client_id='{$sub_client_id}' AND mrid ='{$request_id}'";
					$check_record = db_rows_2($sqlStmt);
					
					if(isset($check_record[0]['id'])&&$check_record[0]['id'])
					{
						$respo['status']="0002";
						$respo['reason']="Duplicate Entry";
						$respo['request_id']	=$request_id;
						//$respo['sqlStmt']=$sqlStmt;
						//json_print($respo);
					}
					else
					{
						//fetch actual last available balance
						$sqlStmt = "SELECT available_balance AS balance FROM `{$data['DbPrefix']}payout_transaction` WHERE `transaction_status` IN (1) AND sub_client_id='{$sub_client_id}' ORDER by transaction_date DESC, id DESC LIMIT 0,1";
						$avlbalance = db_rows_2($sqlStmt,0);
	
						if(isset($avlbalance[0]['balance'])&&$avlbalance[0]['balance'])
							$balance = $avlbalance[0]['balance'];
	
						$request['request'] = $output;
						
						unset($request['request']['payout_secret_key']);
						unset($request['request']['payout_token']);
						unset($request['request']['beneficiary_ac']);
						unset($request['request']['beneficiary_ac_repeat']);

						$txn_value=json_encode($request);

						if($payout_request==2) $transaction_status = 9;
						else $transaction_status = 0;

						$sqlStmt = "INSERT INTO `{$data['DbPrefix']}payout_transaction`(".
							"`mrid`,`sub_client_id`, `pay_type`, `transaction_type`, `transaction_for`, `transaction_currency`, `transaction_amount`, `beneficiary_id`,`transaction_status`,`remarks`,`narration`,`transaction_date`,`created_date`,`client_ip`,`source_url`,`notify_url`,`success_url`,`failed_url`,`host_name`,`txn_value`) VALUES(".
						"'{$request_id}','{$sub_client_id}','{$pay_type}','2', '{$product_name}', '{$curr}', '-{$price}', '{$beneficiary_id}', '{$transaction_status}','{$remarks}','{$narration}','".CURRENT_TIME."','".CURRENT_TIME."', '{$client_ip}', '{$source_url}', '{$notify_url}', '{$success_url}', '{$failed_url}', '".$_SERVER['HTTP_HOST']."','$txn_value')";
		
						db_query_2($sqlStmt,0);
		
						$newId = newid_2();
		
						if($newId)
						{
							json_log_upd_payout($newId,'payout_transaction',$sub_client_id);
							$transaction_id = gen_transID_f($newId,$sub_client_id);

							unset($output['payout_token']);
							unset($output['payout_secret_key']);
			
							$req['request']			=$output;
							$req['transaction_id']	=$transaction_id;

							if(isset($check_status)&&$check_status) $req['check_status'] = $check_status;

							$req['create_date']		=CURRENT_TIME;
							$req['SERVER']['HTTP_X_FORWARDED_FOR']	=@$_SERVER['HTTP_X_FORWARDED_FOR'];
							$req['SERVER']['REMOTE_ADDR']			=@$_SERVER['REMOTE_ADDR'];
							$req['SERVER']['SERVER_ADDR']			=@$_SERVER['SERVER_ADDR'];
							$req['SERVER']['SERVER_PORT']			=@$_SERVER['SERVER_PORT'];
							$req['SERVER']['HTTP_HOST']				=@$_SERVER['HTTP_HOST'];
							$req['SERVER']['REQUEST_TIME']			=@$_SERVER['REQUEST_TIME'];
							$req['SERVER']['REQUEST_TIME_FLOAT']	=@$_SERVER['REQUEST_TIME_FLOAT'];
							$req['SERVER']['HTTP_REFERER']			=@$_SERVER['HTTP_REFERER'];
							$req['SERVER']['REQUEST_URI']			=@$_SERVER['REQUEST_URI'];
			
							$json_log = json_encode($req);
		
							db_query_2(
								"UPDATE `{$data['DbPrefix']}payout_transaction` SET `transaction_id`='$transaction_id',`json_log`='$json_log' WHERE `id`='{$newId}'"
							);

							$scrubbedstatus	=false;
							$scrubbed_msg	="";
							$scrubbed= '';
							$scrubbed=payout_scrubbed($sub_client_id,$ac_payout_id,$transaction_id);
		
							if($scrubbed){
								if($scrubbed['scrubbed_status']==true){
									$scrubbedstatus=true;
									$scrubbed_msg=$scrubbed['scrubbed_msg'];
								}
							}
							if($scrubbedstatus)
							{
								$respo['status']			="0010";
							//	$respo['successId']			=$newId;
								$respo['reason']			=$scrubbed_msg;
								$respo['status_nm']			=10;
							}
							else
							{
								$respo['status']			="0000";
							//	$respo['successId']			=$newId;
								$respo['reason']			="Success";
								$respo['status_nm']			=1;
								
								###############
								//post at payout account
								if($payout_request==1)
								{
									$pramPost = $output;
									$sqlStmt = "SELECT *FROM `{$data['DbPrefix']}payout_beneficiary` WHERE bene_id='$beneficiary_id' LIMIT 0,1";
									$ben_detail = db_rows_2($sqlStmt);
									$pramPost['bank_name']			= $ben_detail[0]['bank_name'];
									$pramPost['bank_code1']			= $ben_detail[0]['bank_code1'];
									$pramPost['bank_code2']			= $ben_detail[0]['bank_code2'];
									$pramPost['bank_code3']			= $ben_detail[0]['bank_code3'];
									$pramPost['account_number']		= $ben_detail[0]['account_number'];
									$pramPost['beneficiary_name']	= $ben_detail[0]['beneficiary_name'];
									$pramPost['beneficiary_nickname']=$ben_detail[0]['beneficiary_nickname'];

									$pramPost['beneficiaryEmailId']	= $ben_detail[0]['beneficiaryEmailId'];
									$pramPost['beneficiaryPhone']	= $ben_detail[0]['beneficiaryPhone'];
									$pramPost['udf1']				= $ben_detail[0]['udf1'];
									$pramPost['udf2']				= $ben_detail[0]['udf2'];
									
									$pramPost['merchant_email']	= $merchant_email;

									$pramPost['transaction_id']	= $transaction_id;

								//	print_r($pramPost);exit;
									$response = send_payout_request($pramPost);	//call online
	
	
									if($qp){
									//	$response['status']='00';	//set '00' for test transaction
										echo "Request to Bank=";print_r($pramPost);
										echo "Response from Bank=";print_r($response);
										exit;
									}

									if(isset($response['status'])&&$response['status'])
									{
										$respo['bankStatus']=$response['status'];
										$respo['message'] 	=$response['message'];

										$json_arr = jsondecode($json_log,1,1);
										$json_arr['response'] = $response;
	
										$json_log = jsonencode($json_arr);
	
										if($response['status']=='00')
										{
											//CONVERT CURRENCY - START
											//$currencyConverter_2		= currencyConverter($pramPost['curr'], $ac_default_curr, $pramPost['price'],0,1);
											//$json["currencyConverter"]	= $currencyConverter_2;
											//$transaction_amt			= $currencyConverter_2['converted_amount'];
											//CONVERT CURRENCY - END
											$transaction_amt = $transaction_amt*(-1);

											$mdr_amt = (($transaction_amt*$payoutFee)/100);
											$payout_amount = prnsum2($transaction_amt-$mdr_amt);
											//$payout_amount = "-".$payout_amount;
											
											$available_balance = prnsum2($balance-abs($transaction_amt));

											if(isset($response['txn_id'])) $txn_id=$response['txn_id'];
											else $txn_id='';

											db_query_2(
											"UPDATE `{$data['DbPrefix']}payout_transaction`".
											"SET `transaction_status`='1', converted_transaction_currency='$ac_default_curr', converted_transaction_amount='$transaction_amt', mdr_percentage='$payoutFee', mdr_amt='$mdr_amt', available_balance='$available_balance', payout_amount='$payout_amount', `reason`='{$response['message']}',`txn_id`='$txn_id', `json_log`='$json_log' WHERE `id`='{$newId}'"
											);
										}
										elseif($response['status']=='01')
										{
											db_query_2(
											"UPDATE `{$data['DbPrefix']}payout_transaction`".
											"SET `reason`='{$response['message']}', `transaction_status`='2', `json_log`='$json_log' WHERE `id`='{$newId}'"
											);
										}else
										{
											db_query_2(
											"UPDATE `{$data['DbPrefix']}payout_transaction`".
											"SET `reason`='{$response['message']}', `transaction_status`='0',`json_log`='$json_log' WHERE `id`='{$newId}'"
											);
										}
									}
								}
								$respo['transaction_id']	=$transaction_id;
								$respo['request_id']		=$request_id;
								$respo['payout_currency']	=$curr;
								$respo['payout_amount']		=$price;
								$respo['available_balance']	=$available_balance;
							}
						}
					}
				}
				else
				{
					$respo['status']	="0008";
					$respo['reason']	="request_id required";
				}
			}
			else
			{
				$respo['status']	="0001";
				$respo['reason']	="Low Balance";
				//$respo['sqlStmt']	=$sqlStmt;
				//json_print($respo);
			}
		}
		else{
			$respo['status']	="0003";
			$respo['bene_id']	=$beneficiary_id;
			$respo['reason']	="Beneficiary not exists.";
			//json_print($respo);
		}
	}
}
else{
	$respo['status']="0004";
	$respo['reason']="Unauthorized";
	//json_print($respo);
}

if($notify_url){
	$notify_url_exist = @get_headers($notify_url);
	if(strpos($notify_url_exist[0],'404') !== false)
	{
		//$json_array['error']='Invalid Notify URL'; json_print($respo); exit;
		$respo['notify']="404 Page not found!";
		$respo['notify_url']=$notify_url;
	}
	else{
		$respo['notify']="OK";
		use_curl($notify_url, $respo);
	}		
}
json_print($respo);

//exit;

?>