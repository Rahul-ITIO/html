<?php

// http://localhost:8080/gw/payin/pay51/hardcode/delete-webhook.php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api-sandbox.spendjuice.com/DELETE/businesses/webhook',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'PATCH',
  CURLOPT_POSTFIELDS =>'{
    "urls": ["https://aws-cc-uat.web1.one/payin/pay51/webhookhandler_51.do"]
}',
  CURLOPT_HTTPHEADER => array(
    'Authorization: test_Z2F0ZXdheS10ZXN0OmFmZjVhY2M2LTZhZjItNDVhYS04ZTk3LTcxYzA5ODM1NzAyMzpiMzVmODk3NS04NGE2LTRiZjItYjFhMC04NTM3ZTQ0MmI4NTk',
    'content-type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;


/*

{"logo":null,"webhook_urls":["https://webhook.site/fa4869eb-43b9-4e56-a329-f4f26d3c8066","https://webhook.site/4f84156c-7be1-4adf-b8d3-ab407a292098","https://webhook.site/fa4869eb-43b9-4e56-a329-f4f26d3c8066","https://webhook.site/4f84156c-7be1-4adf-b8d3-ab407a292098","https://webhook.site/fa4869eb-43b9-4e56-a329-f4f26d3c8066","https://webhook.site/4f84156c-7be1-4adf-b8d3-ab407a292098","https://webhook.site/c357377d-1468-4562-bfee-d03e8936f23d","https://ipg.i15.tech/payin/pay51/webhookhandler_51.do"],"settlement_rules":null}


*/
