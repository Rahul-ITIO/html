<?php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'http://103.1.112.205:8018/UPIUINonFinService/UPIUINonFinService.svc/UPIUINonFinRequest',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'"U2FsdGVkX1/8flkkYYCGwMPPViyU6tZ0euyUVV+xR24zC/aDq9DpjytXGLBVlZ00tsGEQDeEAthlKFrjjgrnu7HVQXj5Nuf3OzirNW8lDbRPhXCCd38Pu6EZYMDmSM43yQZO7Nt4oJa0sCK3BU0lqw0E1/dlVdt2WhEnzqUAVxHSnA8wZoCYY9IBIpNwVPexFY/8K/o/Xsmr6p+HLFlRDji1tpdtBXoCob/JhdIMB/gOUQRTyHQMpHq6nBl2Ua6VexvvdlJxocqB7sy5KCStWOo1cY2T4GLbXJOR7B8bj654eZlgyAo85NBBkPf1V8Bi79yK+k9b0VUt+Qm9vZJG/A=="',
  CURLOPT_HTTPHEADER => array(
    'Authentication: U2FsdGVkX1+55qfi04xU9Qv0q6yx1D2xMzvVjb7LtkwXtz00zjAUD55NwpAGkDRDE2VawysBbOHML2mM46s3HbpYpW1N1evMoJdalrtfkBgBC0hfNFu9pikm/U0BBjd9',
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
?>