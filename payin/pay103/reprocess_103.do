<?
error_reporting(0); // reports all errors
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}
include('../../config_root.do');

$merchant_id=@$_SESSION['3ds2_auth']['merchant_id'];
$get_session_id=@$_SESSION['3ds2_auth']['get_session_id'];
$prefix_url='ap';


if(isset($_SESSION['3ds2_auth']['prefix_url'])&&trim($_SESSION['3ds2_auth']['prefix_url']))
$prefix_url=trim($_SESSION['3ds2_auth']['prefix_url']);

if(isset($_REQUEST['prefix_url'])&&trim($_REQUEST['prefix_url']))
$prefix_url=trim($_REQUEST['prefix_url']);


$acquirer_payin='103';
$transID=@$_REQUEST['transID'];
//@$transIDSet='TRANSESSION0000000000'.@$transID;
@$transIDSet=prefix_trans_lenght(@$transID,31,1,'TRANSESSION','O');

$acquirer_wl_domain=$data['Host'];
$status_default_url=$acquirer_wl_domain."/payin/pay{$acquirer_payin}/status_{$acquirer_payin}".$data['ex']."?transID=".$transID;


if(!isset($_SESSION['3ds2_auth']['get_session_id'])) header("Location:".$status_default_url);

if(isset($_SESSION['3ds2_auth']['get_session_id'])) unset($_SESSION['3ds2_auth']['get_session_id']);
//echo "<br/>status_default_url=>".$status_default_url;

?>
<!DOCTYPE html>
<html lang="en">
    <head>
	    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>3DS Redirect via Secure 2 Processing...</title>
    </head>
    <body>
       <?include('../loading_icon.do');?>
    
<div id="threedsChallengeRedirect" xmlns="http://www.w3.org/1999/html" style="height: 100vh">
<script src="https://<?=$prefix_url?>-gateway.mastercard.com/static/threeDS/1.3.0/three-ds.min.js"></script>
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
        //window.top.location.href="https://google.com?action=success";
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
ThreeDS.authenticatePayer("<?=@$transIDSet?>", "<?=@$transIDSet?>", function (data) {
    if (!data.error) {
        //data.response will contain all the response payload from the AUTHENTICATE_PAYER call.
        console.log("REST API response ", data.restApiResponse);
        console.log("HTML redirect code", data.htmlRedirectCode);
        
    }
}, optionalParams);
</script>
    </body>
</html>