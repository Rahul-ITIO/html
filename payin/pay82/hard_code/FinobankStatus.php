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
  CURLOPT_POSTFIELDS =>'"U2FsdGVkX1/236fhRauTVjomWzByWH4N5oTWuSeGEAZUPJh2FYC23baBzNobRfUl+OC5ZH4ebS8uL4dFOuK0fdPedXTMseaWrPiWWEipjmSTWoBUweqwKj7mMr+J/OIXcsoPfJcthuFIaRYduMVMjRzcTrkypgyBT1VeLtom1+pK/C4hJM3fEytuSrNUKHxQ"',
  CURLOPT_HTTPHEADER => array(
    'Authentication: U2FsdGVkX1+KVeWyrdKnbXawbc8u7Rmj84GdUPG38cSBjf1WZqrJ1fFZ+cnW5xYRMN7Y9J05hwK2QCRAwTqzzgTFgxeokbmj2SAwFt+gZsuVqwgzT70nRrgl2CvmfRio',
    'Content-Type: application/json'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;


?>