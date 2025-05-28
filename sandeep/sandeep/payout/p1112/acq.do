<?
$hardcode=true;
if($hardcode==false)
{
	$cf_data = null;
	
	$finalUrl = $baseurl.$urls['auth'];
	$headers = create_header("");
	
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_URL, $finalUrl);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

	if(!is_null($cf_data)) curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($cf_data)); 
	
	$r = curl_exec($ch);
	
	if(curl_errno($ch)){
		print('error in posting');
		print(curl_error($ch));
		die();
	}
	curl_close($ch);
	$rObj = json_decode($r, true);
	
	if($cp)
	{
		echo "<br/><br/>response=><br />";
		print_r($rObj);
	}
	
	$cron_tab_array['authorize_toten']=$rObj;

	if($rObj['subCode'] == 200)
	{
		$auth_res['status']	= $rObj['status'];
		$auth_res['message']= $rObj['message'];
		$auth_res['token']	= $rObj['data']['token'];
		$auth_res['expiry']	= $rObj['data']['expiry'];

		$transfer = array(
			'beneId' => $pramPost['beneficiary_id'],
			'amount' => $fund_arr['payout_amount'],	//received from resp
			'transferId' => $pramPost['transaction_id']
		);

		########### transfer api of cashfree
	
		$cf_data = $transfer;

		$finalUrl	= $baseurl.$urls['requestTransfer'];
		$headers	= create_header($auth_res['token']);

		$ch = curl_init();
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_URL, $finalUrl);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

		if(!is_null($cf_data)) 
			curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($cf_data));

		$r = curl_exec($ch);

		if(curl_errno($ch)){
			print('error in posting');
			print(curl_error($ch));
			die();
		}
		curl_close($ch);
		$rObj1 = json_decode($r, true);

		//cmn
		if($cp){
			echo "<br />Object 1 <br />";
			print_r($rObj1);
		}
		$subCode = $rObj1['subCode'];

		$transfer_res['status']			= $rObj1['status'];
		$transfer_res['message']		= $rObj1['message'];
		$transfer_res['referenceId']	= $rObj1['data']['referenceId'];
		$transfer_res['utr']			= $rObj1['data']['utr'];
		$transfer_res['acknowledged']	= $rObj1['data']['acknowledged'];

		if($transfer_res['status']=='SUCCESS')
		{
			
		}
	}
	#####################################
}
?>