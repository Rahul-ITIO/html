<?php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://checkout.wzrdpay.io/acs/auth',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => 'MD=cGF5X0FiYm85WThERXd3NjdiMVdGdzNoTjROel9LSF91bQ&PaReq=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjb2RlM2RzIjoiNTc5OTQ2IiwicGF5bWVudF9pZCI6InBheV9BYmJvOVk4REV3dzY3YjFXRnczaE40TnpfS0hfdW0iLCJjYXJkX251bWJlciI6IjUxMjM4MTcyMzQwNjAwMDAiLCJleHBfZGF0ZSI6IjA0MzAiLCJleHAiOjE3Mjk2Nzc0NzB9._rbJjPorfBXJg4FkOP-qaiHcDfAZdtAFSLLOBpJJk8A&TermUrl=https%3A%2F%2Fcheckout.wzrdpay.io%2Fcomplete-auth%3Fpid%3Dpay_Abbo9Y8DEww67b1WFw3hN4Nz_KH_um',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
?>