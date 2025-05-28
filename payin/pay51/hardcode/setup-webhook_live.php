<?php
// http://localhost:8080/gw/payin/pay51/hardcode/setup-webhook_live.php
// http://localhost:8080/gw/payin/pay51/setup-webhook_live.php

$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.spendjuice.com/businesses/webhook',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'PATCH',
  CURLOPT_POSTFIELDS =>'{
    "urls": ["https://prod-gate.i15.me/payin/pay51/webhookhandler_51"]
}',
  CURLOPT_HTTPHEADER => array(
    'Authorization: live_Z2F0ZXdheS1saXZlOjkxNjgxNzVlLTVhOTYtNGU3YS04ZmM0LWJiY2Y4ZWU2ZTdjMTo3NzRkZWEzMC1kNGRhLTQwY2UtYmYxNi0zMzk4Nzc3N2VmMWE',
    'content-type: application/json'
  ),
));
$response = curl_exec($curl);
curl_close($curl);
echo $response;


/*

{"logo":null,"webhook_urls":["https://webhook.site/fa4869eb-43b9-4e56-a329-f4f26d3c8066","https://webhook.site/4f84156c-7be1-4adf-b8d3-ab407a292098","https://webhook.site/fa4869eb-43b9-4e56-a329-f4f26d3c8066","https://webhook.site/4f84156c-7be1-4adf-b8d3-ab407a292098","https://webhook.site/fa4869eb-43b9-4e56-a329-f4f26d3c8066","https://webhook.site/4f84156c-7be1-4adf-b8d3-ab407a292098","https://webhook.site/c357377d-1468-4562-bfee-d03e8936f23d","https://ipg.i15.tech/payin/pay51/webhookhandler_51.do"],"settlement_rules":null}


*/
