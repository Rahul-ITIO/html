<?php
	
	$apiName='SCI_i15gw_2023';
	$apiPass='Vikas@123';
	
	//Dev Tech : 23-09-25 Dynamic pass from Acquirer Processing Creds 
	if(isset($apc_get['api_name'])&&trim($apc_get['api_name'])){
		$apiName=$apc_get['api_name'];
	}
	if(isset($apc_get['api_pass'])&&trim($apc_get['api_pass'])){
		$apiPass=$apc_get['api_pass'];
	}
	

	$arg0->apiName = @$apiName;
	$arg0->accountEmail = @$ac_account_email;
	$arg0->authenticationToken = $merchantWebService->getAuthenticationToken($apiPass);
	
?>
