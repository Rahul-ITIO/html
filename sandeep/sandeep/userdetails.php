<?php

$curl = curl_init();

  curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.sandbox.stylopay.com/caas/api/v2/user/n1qdfqo4m1q-eo89n83p2o-eq0n4dlp0do4c3aafd8',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_USERAGENT => 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.1.4322)', //for 
  CURLOPT_CUSTOMREQUEST => 'GET',
  CURLOPT_HTTPHEADER => array(
    'x-api-key: uc8Zz8w9TM1UNlKNb7DKh976FkQ9nLWm7de1dEbW',
    'x-client-id: cebd2dfb-b010-48ef-b2f2-ac7e640e3a68',
    'x-program-id: EPMAAS0',
    'x-client-name: {businessname}',
    'x-request-id: UUID'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
?>
