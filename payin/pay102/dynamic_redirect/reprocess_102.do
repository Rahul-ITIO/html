<?
error_reporting(0); // reports all errors
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}
include('../../config_root.do');

$get_session_id=@$_SESSION['3ds2_auth']['get_session_id'];
$prefix_url='ap';

$acquirer_payin='102';
$transID=@$_REQUEST['transID'];
$acquirer_wl_domain=$data['Host'];
$status_default_url=$acquirer_wl_domain."/payin/pay{$acquirer_payin}/status_{$acquirer_payin}".$data['ex']."?transID=".$transID;


if(!isset($_SESSION['3ds2_auth']['get_session_id'])) header("Location:".$status_default_url);

if(isset($_SESSION['3ds2_auth']['get_session_id'])) unset($_SESSION['3ds2_auth']['get_session_id']);
//echo "<br/>status_default_url=>".$status_default_url;

?>
<!DOCTYPE html>
<html lang="en">
    <head>
	<meta name="viewport" content="width=device-width, initial-scale=1">

        <script src="https://<?=$prefix_url?>-gateway.mastercard.com/static/checkout/checkout.min.js"
                data-error="errorCallback" 
                data-complete="<?=@$status_default_url?>&urlaction=complete_mastercard"
                data-cancel="<?=@$status_default_url?>&urlaction=cancel_mastercard">
        </script>
    
        <script type="text/javascript">
            function errorCallback(error) {
                  alert(JSON.stringify(error));
                  console.log(JSON.stringify(error));
            }
            function cancelCallback() {
                confirm('Are you sure you want to cancel?');
                console.log('Payment cancelled');
            }
        
            Checkout.configure({
                session: {
                    id:  '<?=@$get_session_id?>'
                }
            });
            
        </script>
    </head>
    <body>
       <?include('../loading_icon.do');?>
    
        <div id="embed-target"> </div>
        <input style="display:none" type="button" value="Pay with Embedded Page" onclick="Checkout.showEmbeddedPage('#embed-target');" />
        <input style="display:none" type="button" value="Pay with Payment Page" onclick="Checkout.showPaymentPage();" />
    
      
        <script type="text/javascript">
          Checkout.showPaymentPage();
        </script>
    </body>
</html>