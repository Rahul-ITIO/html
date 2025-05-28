<?php

// http://localhost:8080/mastercard/pay_test.php

// https://aws-cc-uat.web1.one/api-test/mastercard/pay_test.php

// https://aws-cc-uat.web1.one/api-test/mastercard/pay.php

// https://test-gateway.mastercard.com/api/documentation/integrationGuidelines/hostedCheckout/integrationModelHostedCheckout.html

$PWD='4d3f8e07b2c625d779b81c678086cc1d';
$redirectUrl='https://aws-cc-uat.web1.one/responseDataList/?urlaction=redirectUrl_mastercard';

$prefix_url='ap';
//$prefix_url='test';

$url = "https://{$prefix_url}-gateway.mastercard.com/api/nvp/version/72";

$data = array(
    "apiOperation" => "INITIATE_CHECKOUT",
    "apiPassword" => $PWD,
    "apiUsername" => "merchant.GLADCORIGKEN",
    "merchant" => "GLADCORIGKEN",
    "interaction.operation" => "AUTHORIZE", // AUTHORIZE || PURCHASE
    "interaction.returnUrl" => $redirectUrl, 
    "interaction.merchant.name" => "UAT KEY",
    //"card.accountNumber" => '4147673003292810',
   // "card.cardHolderName" => 'Arun Dixt',
   // "card.expiryMonth" => '11',
    //"card.expiryYear" => '2028',
    "billing.address.city" => 'St Louis',
    "billing.address.stateProvince" => 'MO',
    "billing.address.country" => 'USA',
    "billing.address.postcodeZip" => '63102',
    "billing.address.street" => '11 N 4th St',
    "billing.address.street2" => 'The Gateway Arch',
    "order.id" => date('ymdHisu'),
    "order.amount" => "2.01",
    "order.currency" => "USD",
    "order.description" => "Testing Api"
);

echo "<br/><br/>POST REQUEST=>";
print_r($data);


$options = array(
    CURLOPT_URL => $url,
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => http_build_query($data),
    CURLOPT_RETURNTRANSFER => true
);

$curl = curl_init();
curl_setopt_array($curl, $options);
$response = curl_exec($curl);
curl_close($curl);

//$res=json_decode($response,1);
echo "<br/><hr/>session=>".$response=urldecode('https://view?'.$response);
parse_str(parse_url($response, PHP_URL_QUERY), $res); 

echo "<br/><br/>";
print_r($res);
echo "<br/>";
$get_session_id=$_SESSION['session_id']=$res['session_id'];

echo "<br/>session_id=>".$get_session_id."<br/>";

?>
<html>
    <head>
	<meta name="viewport" content="width=device-width, initial-scale=1">

        <script src="https://<?=$prefix_url?>-gateway.mastercard.com/static/checkout/checkout.min.js"
                data-error="errorCallback" 
                data-complete="https://aws-cc-uat.web1.one/responseDataList/?urlaction=complete_mastercard"
                data-cancel="https://aws-cc-uat.web1.one/responseDataList?urlaction=cancel_mastercard">
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
        ...
    
        <div id="embed-target"> </div>
        <input type="button" value="Pay with Embedded Page" onclick="Checkout.showEmbeddedPage('#embed-target');" />
        <input type="button" value="Pay with Payment Page" onclick="Checkout.showPaymentPage();" />
    
        ...
    </body>
</html>
<pre>
	<code>


	</code>
</pre>
