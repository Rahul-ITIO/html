<?php
	//echo "Server IP: ".$_SERVER['SERVER_ADDR'] . "\n"; echo "Client IP: ".$_SERVER['REMOTE_ADDR'] . "\n";
	$apiPass='Vikas@123';
	
	
	/*
	WebOne2202 - SCI Name
	*/
	$arg0->apiName = $apiName;
	$arg0->accountEmail = "vik.mno@gmail.com";
	$arg0->authenticationToken = $merchantWebService->getAuthenticationToken($apiPass);
	
?>
