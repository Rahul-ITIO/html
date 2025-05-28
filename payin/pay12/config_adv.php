<?php
	//echo "Server IP: ".$_SERVER['SERVER_ADDR'] . "\n"; echo "Client IP: ".$_SERVER['REMOTE_ADDR'] . "\n";
	$apiPass='Vikas@123';
	
	if($_SERVER['SERVER_ADDR']=='68.183.176.74'||$_SERVER['SERVER_ADDR']=='10.130.21.230'){ // appNextGen1 DigitalOcean
		$apiName='MakeTransactions';
	}
	elseif($_SERVER['SERVER_ADDR']=='165.22.96.93'||$_SERVER['SERVER_ADDR']=='10.130.67.76'){ // appNextGen2 DigitalOcean
		$apiName='MakePaymentTransactions';
	}
	elseif($_SERVER['SERVER_ADDR']=='47.241.17.188'||$_SERVER['SERVER_ADDR']=='172.21.7.58'){ // nextGenApp20(Alibaba)
		$apiName='PaymentTransactions';
	}elseif($_SERVER['SERVER_ADDR']=='13.250.56.238'||$_SERVER['SERVER_ADDR']=='172.31.45.162'){ // awsApp1 
		$apiName='MakeNewTransactions';
	}elseif($_SERVER['SERVER_ADDR']=='54.179.85.153'||$_SERVER['SERVER_ADDR']=='172.31.47.62'){ // awsApp2 
		$apiName='MakeOnlineTransactions';
	}elseif($_SERVER['SERVER_ADDR']=='54.169.61.214'||$_SERVER['SERVER_ADDR']=='172.31.40.17'){ // awsApp3 
		$apiName='MakeOnlineTransaction';
	}elseif($_SERVER['SERVER_ADDR']=='128.199.106.36'||$_SERVER['SERVER_ADDR']=='10.130.137.180'){ // firstApp21 DigitalOcean 
		$apiName='Make_Online_Transaction';
	}elseif($_SERVER['SERVER_ADDR']=='128.199.199.39'||$_SERVER['SERVER_ADDR']=='10.130.137.182'){ // secondApp21 DigitalOcean 
		$apiName='Make_Online_Transactions';
	}elseif($_SERVER['SERVER_ADDR']=='13.214.54.35'||$_SERVER['SERVER_ADDR']=='172.31.26.176'){ // APP1_NextGen AWS LB.COGM
		$apiName='WebOne2202A';
		$apiPass='India@123';
	}elseif($_SERVER['SERVER_ADDR']=='13.251.115.95'||$_SERVER['SERVER_ADDR']=='172.31.30.83'){ // APP2_NextGen AWS LB.COGM
		$apiName='WebOne2202B';
		$apiPass='India@123';
	}elseif($_SERVER['SERVER_ADDR']=='13.212.128.34'||$_SERVER['SERVER_ADDR']=='172.31.13.3'){ // APP1 AWS NextGen.2.0 
		$apiName='Make_Online_Transaction';
		$apiPass='India@123';
	}elseif($_SERVER['SERVER_ADDR']=='13.229.142.178'||$_SERVER['SERVER_ADDR']=='172.31.3.166'){ // APP2 AWS NextGen.2.0 
		$apiName='Make_Online_Transactions';
		$apiPass='India@123';
	}elseif($_SERVER['SERVER_ADDR']=='13.233.167.170'||$_SERVER['SERVER_ADDR']=='172.31.38.7' || $_SERVER['SERVER_ADDR']=='13.232.229.139'||$_SERVER['SERVER_ADDR']=='172.31.14.188'){ // IPG APP 1
		$apiName='API_i15gw_2023';
		$apiPass='India@1230';
	}elseif($_SERVER['SERVER_ADDR']=='13.233.167.170'||$_SERVER['SERVER_ADDR']=='172.31.38.7' || $_SERVER['SERVER_ADDR']=='13.232.229.139'||$_SERVER['SERVER_ADDR']=='172.31.14.188'){ // IPG APP 2
		$apiName='SCI_i15gw_2023';
		$apiPass='India@1230';
	}else{
		$apiName='MakeTransactions';
	}
	
	
	//Dev Tech : 23-09-25 Dynamic pass from Acquirer Processing Creds 
	if(isset($apc_get['api_name'])&&trim($apc_get['api_name'])){
		$apiName=$apc_get['api_name'];
	}
	if(isset($apc_get['api_pass'])&&trim($apc_get['api_pass'])){
		$apiPass=$apc_get['api_pass'];
	}
	
	/*
	WebOne2202 - SCI Name
	*/
	$arg0->apiName = $apiName;
	$arg0->accountEmail = "vik.mno@gmail.com";
	$arg0->authenticationToken = $merchantWebService->getAuthenticationToken($apiPass);
	
?>
