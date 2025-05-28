<?php
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}
// http://localhost:8080/gw/payin/pay102/hardcode/js3d.php
// https://ipg.i15.tech/payin/pay102/hardcode/js3d.php
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
    merchantId: "GLADRASHKEN",
    sessionId: "SESSION0002404553563L76033492H7",
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
ThreeDS.authenticatePayer('devJS3D23', 'devJS3D23', function (data) {
    if (!data.error) {
        //data.response will contain all the response payload from the AUTHENTICATE_PAYER call.
        console.log("REST API response ", data.restApiResponse);
        console.log("HTML redirect code", data.htmlRedirectCode);
        
    }
}, optionalParams);
</script>
</body>
</html>