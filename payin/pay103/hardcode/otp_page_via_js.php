
<?php
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}
$merchant_id='GLADRASHKEN';
$get_session_id='SESSION0002979095027E13598503N6';
$transID='ranjit2DRedirect0000006';

if(isset($_GET['get_session_id'])&&trim($_GET['get_session_id']))$get_session_id=$_GET['get_session_id'];
if(isset($_GET['transID'])&&trim($_GET['transID']))$transID=$_GET['transID'];



// http://localhost:8080/gw/payin/pay103/hardcode/otp_page_via_js.php

// https://ipg.i15.tech/payin/pay103/hardcode/otp_page_via_js.php?get_session_id=SESSION0002670573015F5381919H66&transID=ipg3DRedirect00003

?><!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>3DS Challenge Redirect via JS for Secure 2 Processing...</title>
</head>
<body >
<div id="threedsChallengeRedirect" xmlns="http://www.w3.org/1999/html" style="height: 100vh">
<script src="https://ap-gateway.mastercard.com/static/threeDS/1.3.0/three-ds.min.js"></script>
<script>
ThreeDS.configure({
    merchantId: "<?=@$merchant_id?>",
    sessionId: "<?=@$get_session_id?>",
    containerId: "3DSUI",
    callback: function () {
        if (ThreeDS.isConfigured()) {
            console.log("Done with configure");
        } else {
            console.error("3DS not configured");
        }
    },
    configuration: {
        userLanguage: "en-US",
        wsVersion: 78
    }
});
var optionalParams = {
    fullScreenRedirect: true,
    billing: {
        address: {
            city: "London",
            country: "GBR"
        }
    }
};
ThreeDS.authenticatePayer("<?=@$transID?>", "<?=@$transID?>", function (data) {
    if (!data.error) {
        //data.response will contain all the response payload from the AUTHENTICATE_PAYER call.
        console.log("REST API response ", data.restApiResponse);
        console.log("HTML redirect code", data.htmlRedirectCode);
        
    }
}, optionalParams);
</script>
</body>
</html>

