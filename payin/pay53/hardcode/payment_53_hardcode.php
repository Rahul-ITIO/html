<?php

// http://localhost:8080/gw/payin/pay53/hardcode/payment_53_hardcode.php

//{"auth_ApiKey":"a62fe2fc139471ed8cb97fed3cf73424af66d5f1","header_ApiKey":"a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127"}

$transID='53'.date('YmdHis');

### function for card data encode & decode  #############################################


function hexToStr($hex) {
  $string = '';
  for ($i = 0; $i < strlen($hex) - 1; $i += 2) {
      $string .= chr(hexdec($hex[$i] . $hex[$i + 1]));
  }
  return $string;
}

function strToHex($string) {
  $hex = '';
  for ($i = 0; $i < strlen($string); $i++) {
      $hex .= dechex(ord($string[$i]));
  }
  return $hex;
}

function encryptCardData($cards=[]) {
  $zek = "a62fe2fc139471ed8cb97fed3cf73424af66d5f1";
  $publicApiKey = "a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127";

  $cardNo=$cards['ccno'];
  //$expiryDate=$cards['month'].$cards['year'];
  $expiryDate='20'.$cards['year'];
  $securityCode=$cards['ccvv'];

  $cardData = "{\"cardNo\": \"{$cardNo}\",\"expiryDate\": \"{$expiryDate}\",\"securityCode\":{$securityCode}}";

  echo "<br/><hr/><br/>cardData=>".$cardData;

  $zekSecretKeySpec = hexToStr($zek);
  $secretKey = decrypt($publicApiKey, $zekSecretKeySpec);

  $cardDataHex = strToHex($cardData);
  $secretKeySpec = hexToStr($secretKey);

  $encryptedDataHex = encrypt($cardDataHex, $secretKeySpec);
  return $encryptedDataHex;
}

function encrypt($dataHexString, $secretKey) {
  $iv = random_bytes(12);
  $cipher = 'aes-256-gcm';
  $data = hexToStr($dataHexString);
  $tag = null;

  $encryptedData = openssl_encrypt($data, $cipher, $secretKey, OPENSSL_RAW_DATA, $iv, $tag);

  if ($encryptedData === false) {
      throw new RuntimeException("Error during encryption");
  }

  $ivText = strToHex($iv);
  $encryptedText = strToHex($encryptedData . $tag);

  return $ivText . $encryptedText;
}

function decrypt($encryptedHexString, $secretKey) {
  $ivPlusEncryptedBytes = hexToStr($encryptedHexString);
  $iv = substr($ivPlusEncryptedBytes, 0, 12);
  $encryptedBytes = substr($ivPlusEncryptedBytes, 12, -16);
  $tag = substr($ivPlusEncryptedBytes, -16);

  $cipher = 'aes-256-gcm';

  $decryptedData = openssl_decrypt($encryptedBytes, $cipher, $secretKey, OPENSSL_RAW_DATA, $iv, $tag);

  if ($decryptedData === false) {
      throw new RuntimeException("Error during decryption");
  }

  return strToHex($decryptedData);
}


### //Step 1: Authentication #############################################


$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://pr-web-api-gateway-k8.dev.prophius-api.com/api/v1/gateway/auth?apiKey=a62fe2fc139471ed8cb97fed3cf73424af66d5f1',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;


/*

{
    "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlNlFqTDNLWHU0TkZfbWtlN2JKNFZjZnFSTUxFdHl5RlcwSlMwSVc3Wk9vIn0.eyJleHAiOjE3MjMwMDY4MDAsImlhdCI6MTcyMjkyMDQwMCwianRpIjoiZmQ3NGQ5NTAtNDQwNC00NDkyLWIzM2EtOWRjZDA3NWYxNDY2IiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay5kZXYucHJvcGhpdXMtYXBpLmNvbS9hdXRoL3JlYWxtcy90YXAtdG8tcGhvbmUiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMWU1Y2M0YjktZWQyZS00ZmFlLTgwYzMtZGJmNmVjZWUyNDM5IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoicHJvcGhpdXMtdGVzdCIsInNlc3Npb25fc3RhdGUiOiJkZDU0MmI1Yy0xZGU5LTQ0NjEtOWI2OS03OWYzNmUwNWQ0YzAiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwib3JnYW5pemF0aW9uLWFkbWluIiwidW1hX2F1dGhvcml6YXRpb24iLCJkZWZhdWx0LXJvbGVzLXRhcC10by1waG9uZSJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InByb3BoaXVzLXRlc3QiOnsicm9sZXMiOlsiZ2V0LW91dGxldC1hc3NpZ25lZC11c2VyLWxpc3QiLCJsaXN0LXBlcm1pc3Npb25zIiwicmVwb3J0cyIsImRpc2FibGUtYWNjb3VudCIsInZpZXctb3V0bGV0LXRyYW5zYWN0aW9uLWRldGFpbCIsIm1lcmNoYW50LWJ1bGstZmlsZS10ZW1wbGF0ZS1kb3dubG9hZCIsIm1lcmNoYW50LWJ1bGstZmlsZS1oaXN0b3J5LWRldGFpbCIsImxpc3Qtcm9sZXMiLCJvdXRsZXQtYnVsay1maWxlLWhpc3RvcnktZGV0YWlsIiwidmlydHVhbC1hY2NvdW50LXNlbmQtcmVwb3J0LW1haWwiLCJ0ZXJtaW5hbC1idWxrLWZpbGUtdXBsb2FkIiwiY3JlYXRlLWJhbmstdXNlciIsImxpc3QtYXBwcm92YWxzIiwiZ2V0LW1lcmNoYW50LXRyYW5zYWN0aW9uLWRldGFpbCIsImxpc3Qtb3V0bGV0LXVwbG9hZC1oaXN0b3J5IiwibGlzdC10ZXJtaW5hbC1idWxrLWNyZWF0aW9uLWZhaWxlZC1pdGVtcyIsIm1lcmNoYW50LWJ1bGstZmlsZS1hcHByb3ZlIiwibGlzdC1hcGstZGVmcyIsImdldC1iYW5rLXN0YWZmLWF1ZGl0LWxvZ3MiLCJnZXQtcGVyc29uYWwtbWVyY2hhbnQtYXVkaXQtbG9ncyIsInVwZGF0ZS1hdmF0YXIiLCJsaXN0LW1lcmNoYW50LXN0YWZmLXVzZXJzIiwiY3JlYXRlLW1lcmNoYW50LXN0YWZmLXVzZXIiLCJhZGQta3ljLWRvY3VtZW50IiwiYXBwcm92YWxzIiwiZ2V0LWRldmljZS1saXN0IiwidmlydHVhbC1hY2NvdW50LWdldC1saW5rZWQtYWNjb3VudC1kZXRhaWxzIiwibGlzdC1zZGstdmVyc2lvbi1kZWZzIiwib3V0bGV0IiwibGlzdC1tZXJjaGFudC1idWxrLWNyZWF0aW9uLWZhaWxlZC1pdGVtcyIsInVwZGF0ZS1tZXJjaGFudCIsImVuYWJsZS1vdXRsZXQiLCJnZXQtcGVyc29uYWwtYmFuay1zdGFmZi1hdWRpdC1sb2dzIiwiZGFzaGJvYXJkIiwibGlzdC1tZXJjaGFudC11cGxvYWQtaGlzdG9yeSIsImFzc2lnbi1vdXRsZXQtdG8tdXNlciIsInRlcm1pbmFsLWJ1bGstZmlsZS1yZWplY3QiLCJzZXR0aW5ncyIsImRpc2FibGUtb3V0bGV0IiwibWVyY2hhbnQtYnVsay1maWxlLXVwbG9hZCIsInVwZGF0ZS1tZXJjaGFudC1hY3F1aXJlciIsImdldC1yaXNrLWxldmVsLWRldGFpbCIsInRyYW5zYWN0aW9ucyIsInRlcm1pbmFsLWJ1bGstZmlsZS1kb3dubG9hZCIsInVzZXJzIiwibGlzdC1vdXRsZXRzIiwic2VsZi1yZWdpc3RyYXRpb24tYXBwcm92ZWQiLCJ1cGRhdGUtb3V0bGV0IiwibGlzdC10ZXJtaW5hbC11cGxvYWQtaGlzdG9yeSIsImdldC1yb2xlLWRldGFpbCIsImxpc3Qtcmlzay1jYXRlZ29yaWVzIiwibWVyY2hhbnQtYnVsay1maWxlLXJlamVjdCIsImRlbGV0ZS1hY2NvdW50IiwiZGV2aWNlIiwibGlzdC1yaXNrLWxldmVsIiwiZ2V0LW1lcmNoYW50LWRldGFpbCIsImdldC1tZXJjaGFudC1kZXZpY2UtbGlzdCIsImxpc3QtbWVyY2hhbnQtbWFuYWdlci11c2VycyIsImxpc3QtbWVyY2hhbnRzIiwiY3JlYXRlLW91dGxldCIsImxpc3Qta3ljLWRvY3VtZW50cyIsImRlZmF1bHQtb3JnYW5pemF0aW9uIiwibGlzdC1tZXJjaGFudC10cmFuc2FjdGlvbnMiLCJnZXQtYXBwcm92YWwtZGV0YWlscyIsIm91dGxldC1idWxrLWZpbGUtbGlzdC1wZW5kaW5nIiwibGlzdC1hcGktbGV2ZWxzIiwibGlzdC1tZXJjaGFudC1kZXZpY2VzIiwiZ2V0LXByb2ZpbGUtZGV0YWlsIiwidmlldy1vdXRsZXQtdHJhbnNhY3Rpb24taGlzdG9yeSIsIm1lcmNoYW50LWJ1bGstZmlsZS1saXN0LXBlbmRpbmciLCJsaXN0LWt5Yy1sZXZlbHMiLCJvdXRsZXQtYnVsay1maWxlLXRlbXBsYXRlLWRvd25sb2FkIiwiZWRpdC1wcm9maWxlIiwiY3JlYXRlLW1lcmNoYW50IiwidXBkYXRlLWFwcHJvdmFsLXN0YXR1cyIsInRlcm1pbmFsLWJ1bGstZmlsZS10ZW1wbGF0ZS1kb3dubG9hZCIsImxpc3Qtb3V0bGV0LWJ1bGstY3JlYXRpb24tZmFpbGVkLWl0ZW1zIiwidXBkYXRlLXJpc2stbGV2ZWwiLCJnZXQtbWVyY2hhbnQtYXVkaXQtbG9ncyIsImxpc3QtcGVybWlzc2lvbnMtYnktb3duZXItdHlwZSIsInRlcm1pbmFsLWJ1bGstZmlsZS1hcHByb3ZlIiwiZ2V0LW91dGxldC11c2VyLWRldGFpbCIsInJlY29uY2lsaWF0aW9uIiwibGlzdC1zZWN1cml0eS1wYXRjaHMiLCJsaXN0LXJpc2stcmVzdHJpY3Rpb25zIiwib3V0bGV0LWJ1bGstZmlsZS1kb3dubG9hZCIsIm1lcmNoYW50LWJ1bGstZmlsZS1kb3dubG9hZCIsImNyZWF0ZS1yb2xlIiwib3V0bGV0LWJ1bGstZmlsZS11cGxvYWQiLCJ0ZXJtaW5hbC1idWxrLWZpbGUtbGlzdC1wZW5kaW5nIiwibGlzdC1iYW5rLXN0YWZmcyIsIm1lcmNoYW50cyIsImF1ZGl0LWxvZ3MiLCJTeXN0ZW0gQWRtaW4gIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJzaWQiOiJkZDU0MmI1Yy0xZGU5LTQ0NjEtOWI2OS03OWYzNmUwNWQ0YzAiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm9yZ2FuaXphdGlvbiI6MjY0LCJuYW1lIjoidGVzdC1IdW1iZXJ0bzM1IEUtY29tbWVyY2UiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJhNjJmZTJmYzEzOTQ3MWVkOGNiOTdmZWQzY2Y3MzQyNGFmNjZkNWYxIiwiZ2l2ZW5fbmFtZSI6InRlc3QtSHVtYmVydG8zNSIsImZhbWlseV9uYW1lIjoiRS1jb21tZXJjZSIsImVtYWlsIjoiYTYyZmUyZmMxMzk0NzFlZDhjYjk3ZmVkM2NmNzM0MjRhZjY2ZDVmMUBwcm9waGl1cy5jb20ifQ.H-VcKqn2VVfDv6UGVtKKmmWSea5qDu_y0spmxYfpcx-DcbNXnEHpo1xm8WDRjYwnSpjcfUjERwQl39cXpGNjVSZT7L7h-HkRNSiBjcC8-cN_sjue1u-7k_dR4JzC3tbXpagS77oTrHlmMuGB5fYn5UuTfHUoeTvN4lbl7Whn45vXJneXBqtp74lQWISYBp32kOHYJfRFQVzK2ZJl2maznIQH4B3_DtV8zge6qV0fzbzMbgGUdYpik20WZNPJENKy8FWO1JZHAJRj8XCXq2rHrLzw-_rD5VjN7hVZc5howojAI5sCOd4L38dTLoc0UHfkA7WXXnyWROEAwwNSQKNx2w",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI3MzQ2MmIxYi0xMWEzLTQ0YTktYmU0YS1mYjRjNTgyMTdmOWMifQ.eyJleHAiOjE3MjI5MjIyMDAsImlhdCI6MTcyMjkyMDQwMCwianRpIjoiOWEyODQxZDYtZDQ1MC00NTk3LTk5OTQtNWRjODdiZDhhYmEyIiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay5kZXYucHJvcGhpdXMtYXBpLmNvbS9hdXRoL3JlYWxtcy90YXAtdG8tcGhvbmUiLCJhdWQiOiJodHRwczovL2tleWNsb2FrLmRldi5wcm9waGl1cy1hcGkuY29tL2F1dGgvcmVhbG1zL3RhcC10by1waG9uZSIsInN1YiI6IjFlNWNjNGI5LWVkMmUtNGZhZS04MGMzLWRiZjZlY2VlMjQzOSIsInR5cCI6IlJlZnJlc2giLCJhenAiOiJwcm9waGl1cy10ZXN0Iiwic2Vzc2lvbl9zdGF0ZSI6ImRkNTQyYjVjLTFkZTktNDQ2MS05YjY5LTc5ZjM2ZTA1ZDRjMCIsInNjb3BlIjoicHJvZmlsZSBlbWFpbCIsInNpZCI6ImRkNTQyYjVjLTFkZTktNDQ2MS05YjY5LTc5ZjM2ZTA1ZDRjMCJ9.w61KgzfZyM5LhkQ8sb_ynLNPBExelvH4N6yF6Vsj5OI"
}

*/



### //Step 2: Initiate Payment #############################################



$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://pr-web-payment-gateway-k8.dev.prophius-api.com/api/v1/transaction/initiate',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "merchantCode": "TESTUBAPROPHNG",
    "transactionRef": "06948007",
    "amount": 110,
    "currency": "840",
    "paymentType": "PAYMENT"
}',
  CURLOPT_HTTPHEADER => array(
    'ApiKey: a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127',
    'Content-Type: application/json',
    'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlNlFqTDNLWHU0TkZfbWtlN2JKNFZjZnFSTUxFdHl5RlcwSlMwSVc3Wk9vIn0.eyJleHAiOjE3MjMwMDY4MDAsImlhdCI6MTcyMjkyMDQwMCwianRpIjoiZmQ3NGQ5NTAtNDQwNC00NDkyLWIzM2EtOWRjZDA3NWYxNDY2IiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay5kZXYucHJvcGhpdXMtYXBpLmNvbS9hdXRoL3JlYWxtcy90YXAtdG8tcGhvbmUiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMWU1Y2M0YjktZWQyZS00ZmFlLTgwYzMtZGJmNmVjZWUyNDM5IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoicHJvcGhpdXMtdGVzdCIsInNlc3Npb25fc3RhdGUiOiJkZDU0MmI1Yy0xZGU5LTQ0NjEtOWI2OS03OWYzNmUwNWQ0YzAiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwib3JnYW5pemF0aW9uLWFkbWluIiwidW1hX2F1dGhvcml6YXRpb24iLCJkZWZhdWx0LXJvbGVzLXRhcC10by1waG9uZSJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InByb3BoaXVzLXRlc3QiOnsicm9sZXMiOlsiZ2V0LW91dGxldC1hc3NpZ25lZC11c2VyLWxpc3QiLCJsaXN0LXBlcm1pc3Npb25zIiwicmVwb3J0cyIsImRpc2FibGUtYWNjb3VudCIsInZpZXctb3V0bGV0LXRyYW5zYWN0aW9uLWRldGFpbCIsIm1lcmNoYW50LWJ1bGstZmlsZS10ZW1wbGF0ZS1kb3dubG9hZCIsIm1lcmNoYW50LWJ1bGstZmlsZS1oaXN0b3J5LWRldGFpbCIsImxpc3Qtcm9sZXMiLCJvdXRsZXQtYnVsay1maWxlLWhpc3RvcnktZGV0YWlsIiwidmlydHVhbC1hY2NvdW50LXNlbmQtcmVwb3J0LW1haWwiLCJ0ZXJtaW5hbC1idWxrLWZpbGUtdXBsb2FkIiwiY3JlYXRlLWJhbmstdXNlciIsImxpc3QtYXBwcm92YWxzIiwiZ2V0LW1lcmNoYW50LXRyYW5zYWN0aW9uLWRldGFpbCIsImxpc3Qtb3V0bGV0LXVwbG9hZC1oaXN0b3J5IiwibGlzdC10ZXJtaW5hbC1idWxrLWNyZWF0aW9uLWZhaWxlZC1pdGVtcyIsIm1lcmNoYW50LWJ1bGstZmlsZS1hcHByb3ZlIiwibGlzdC1hcGstZGVmcyIsImdldC1iYW5rLXN0YWZmLWF1ZGl0LWxvZ3MiLCJnZXQtcGVyc29uYWwtbWVyY2hhbnQtYXVkaXQtbG9ncyIsInVwZGF0ZS1hdmF0YXIiLCJsaXN0LW1lcmNoYW50LXN0YWZmLXVzZXJzIiwiY3JlYXRlLW1lcmNoYW50LXN0YWZmLXVzZXIiLCJhZGQta3ljLWRvY3VtZW50IiwiYXBwcm92YWxzIiwiZ2V0LWRldmljZS1saXN0IiwidmlydHVhbC1hY2NvdW50LWdldC1saW5rZWQtYWNjb3VudC1kZXRhaWxzIiwibGlzdC1zZGstdmVyc2lvbi1kZWZzIiwib3V0bGV0IiwibGlzdC1tZXJjaGFudC1idWxrLWNyZWF0aW9uLWZhaWxlZC1pdGVtcyIsInVwZGF0ZS1tZXJjaGFudCIsImVuYWJsZS1vdXRsZXQiLCJnZXQtcGVyc29uYWwtYmFuay1zdGFmZi1hdWRpdC1sb2dzIiwiZGFzaGJvYXJkIiwibGlzdC1tZXJjaGFudC11cGxvYWQtaGlzdG9yeSIsImFzc2lnbi1vdXRsZXQtdG8tdXNlciIsInRlcm1pbmFsLWJ1bGstZmlsZS1yZWplY3QiLCJzZXR0aW5ncyIsImRpc2FibGUtb3V0bGV0IiwibWVyY2hhbnQtYnVsay1maWxlLXVwbG9hZCIsInVwZGF0ZS1tZXJjaGFudC1hY3F1aXJlciIsImdldC1yaXNrLWxldmVsLWRldGFpbCIsInRyYW5zYWN0aW9ucyIsInRlcm1pbmFsLWJ1bGstZmlsZS1kb3dubG9hZCIsInVzZXJzIiwibGlzdC1vdXRsZXRzIiwic2VsZi1yZWdpc3RyYXRpb24tYXBwcm92ZWQiLCJ1cGRhdGUtb3V0bGV0IiwibGlzdC10ZXJtaW5hbC11cGxvYWQtaGlzdG9yeSIsImdldC1yb2xlLWRldGFpbCIsImxpc3Qtcmlzay1jYXRlZ29yaWVzIiwibWVyY2hhbnQtYnVsay1maWxlLXJlamVjdCIsImRlbGV0ZS1hY2NvdW50IiwiZGV2aWNlIiwibGlzdC1yaXNrLWxldmVsIiwiZ2V0LW1lcmNoYW50LWRldGFpbCIsImdldC1tZXJjaGFudC1kZXZpY2UtbGlzdCIsImxpc3QtbWVyY2hhbnQtbWFuYWdlci11c2VycyIsImxpc3QtbWVyY2hhbnRzIiwiY3JlYXRlLW91dGxldCIsImxpc3Qta3ljLWRvY3VtZW50cyIsImRlZmF1bHQtb3JnYW5pemF0aW9uIiwibGlzdC1tZXJjaGFudC10cmFuc2FjdGlvbnMiLCJnZXQtYXBwcm92YWwtZGV0YWlscyIsIm91dGxldC1idWxrLWZpbGUtbGlzdC1wZW5kaW5nIiwibGlzdC1hcGktbGV2ZWxzIiwibGlzdC1tZXJjaGFudC1kZXZpY2VzIiwiZ2V0LXByb2ZpbGUtZGV0YWlsIiwidmlldy1vdXRsZXQtdHJhbnNhY3Rpb24taGlzdG9yeSIsIm1lcmNoYW50LWJ1bGstZmlsZS1saXN0LXBlbmRpbmciLCJsaXN0LWt5Yy1sZXZlbHMiLCJvdXRsZXQtYnVsay1maWxlLXRlbXBsYXRlLWRvd25sb2FkIiwiZWRpdC1wcm9maWxlIiwiY3JlYXRlLW1lcmNoYW50IiwidXBkYXRlLWFwcHJvdmFsLXN0YXR1cyIsInRlcm1pbmFsLWJ1bGstZmlsZS10ZW1wbGF0ZS1kb3dubG9hZCIsImxpc3Qtb3V0bGV0LWJ1bGstY3JlYXRpb24tZmFpbGVkLWl0ZW1zIiwidXBkYXRlLXJpc2stbGV2ZWwiLCJnZXQtbWVyY2hhbnQtYXVkaXQtbG9ncyIsImxpc3QtcGVybWlzc2lvbnMtYnktb3duZXItdHlwZSIsInRlcm1pbmFsLWJ1bGstZmlsZS1hcHByb3ZlIiwiZ2V0LW91dGxldC11c2VyLWRldGFpbCIsInJlY29uY2lsaWF0aW9uIiwibGlzdC1zZWN1cml0eS1wYXRjaHMiLCJsaXN0LXJpc2stcmVzdHJpY3Rpb25zIiwib3V0bGV0LWJ1bGstZmlsZS1kb3dubG9hZCIsIm1lcmNoYW50LWJ1bGstZmlsZS1kb3dubG9hZCIsImNyZWF0ZS1yb2xlIiwib3V0bGV0LWJ1bGstZmlsZS11cGxvYWQiLCJ0ZXJtaW5hbC1idWxrLWZpbGUtbGlzdC1wZW5kaW5nIiwibGlzdC1iYW5rLXN0YWZmcyIsIm1lcmNoYW50cyIsImF1ZGl0LWxvZ3MiLCJTeXN0ZW0gQWRtaW4gIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJzaWQiOiJkZDU0MmI1Yy0xZGU5LTQ0NjEtOWI2OS03OWYzNmUwNWQ0YzAiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm9yZ2FuaXphdGlvbiI6MjY0LCJuYW1lIjoidGVzdC1IdW1iZXJ0bzM1IEUtY29tbWVyY2UiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJhNjJmZTJmYzEzOTQ3MWVkOGNiOTdmZWQzY2Y3MzQyNGFmNjZkNWYxIiwiZ2l2ZW5fbmFtZSI6InRlc3QtSHVtYmVydG8zNSIsImZhbWlseV9uYW1lIjoiRS1jb21tZXJjZSIsImVtYWlsIjoiYTYyZmUyZmMxMzk0NzFlZDhjYjk3ZmVkM2NmNzM0MjRhZjY2ZDVmMUBwcm9waGl1cy5jb20ifQ.H-VcKqn2VVfDv6UGVtKKmmWSea5qDu_y0spmxYfpcx-DcbNXnEHpo1xm8WDRjYwnSpjcfUjERwQl39cXpGNjVSZT7L7h-HkRNSiBjcC8-cN_sjue1u-7k_dR4JzC3tbXpagS77oTrHlmMuGB5fYn5UuTfHUoeTvN4lbl7Whn45vXJneXBqtp74lQWISYBp32kOHYJfRFQVzK2ZJl2maznIQH4B3_DtV8zge6qV0fzbzMbgGUdYpik20WZNPJENKy8FWO1JZHAJRj8XCXq2rHrLzw-_rD5VjN7hVZc5howojAI5sCOd4L38dTLoc0UHfkA7WXXnyWROEAwwNSQKNx2w'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

/*

{
    "referenceNumber": "f4ac2201-3d8b-4d01-a0a7-eb5a7a4ed252",
    "transactionRef": "84770574"
}

*/




### //Step 3: Make Payment #############################################



$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://pr-web-payment-gateway-k8.dev.prophius-api.com/api/v1/transaction/make-payment',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "referenceNumber": "f4ac2201-3d8b-4d01-a0a7-eb5a7a4ed252",
    "cardData": "0000000000000000000000008bd22dd9300f6a4d59f8633ae1782df1b4b00802a4034972a86e4b158c519981a6ba0121704b611ce4cbd5c31a1fe7a9cadb81f09a999006d3dd986c0b51ad2dcf15fdef8099009fe04ed502a829279f50cc25f5c6b7",
    "merchantCode": "TESTUBAPROPHNG"
}',
  CURLOPT_HTTPHEADER => array(
    'ApiKey: a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127',
    'Content-Type: application/json',
    'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlNlFqTDNLWHU0TkZfbWtlN2JKNFZjZnFSTUxFdHl5RlcwSlMwSVc3Wk9vIn0.eyJleHAiOjE3MjMwMDY4MDAsImlhdCI6MTcyMjkyMDQwMCwianRpIjoiZmQ3NGQ5NTAtNDQwNC00NDkyLWIzM2EtOWRjZDA3NWYxNDY2IiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay5kZXYucHJvcGhpdXMtYXBpLmNvbS9hdXRoL3JlYWxtcy90YXAtdG8tcGhvbmUiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMWU1Y2M0YjktZWQyZS00ZmFlLTgwYzMtZGJmNmVjZWUyNDM5IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoicHJvcGhpdXMtdGVzdCIsInNlc3Npb25fc3RhdGUiOiJkZDU0MmI1Yy0xZGU5LTQ0NjEtOWI2OS03OWYzNmUwNWQ0YzAiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwib3JnYW5pemF0aW9uLWFkbWluIiwidW1hX2F1dGhvcml6YXRpb24iLCJkZWZhdWx0LXJvbGVzLXRhcC10by1waG9uZSJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InByb3BoaXVzLXRlc3QiOnsicm9sZXMiOlsiZ2V0LW91dGxldC1hc3NpZ25lZC11c2VyLWxpc3QiLCJsaXN0LXBlcm1pc3Npb25zIiwicmVwb3J0cyIsImRpc2FibGUtYWNjb3VudCIsInZpZXctb3V0bGV0LXRyYW5zYWN0aW9uLWRldGFpbCIsIm1lcmNoYW50LWJ1bGstZmlsZS10ZW1wbGF0ZS1kb3dubG9hZCIsIm1lcmNoYW50LWJ1bGstZmlsZS1oaXN0b3J5LWRldGFpbCIsImxpc3Qtcm9sZXMiLCJvdXRsZXQtYnVsay1maWxlLWhpc3RvcnktZGV0YWlsIiwidmlydHVhbC1hY2NvdW50LXNlbmQtcmVwb3J0LW1haWwiLCJ0ZXJtaW5hbC1idWxrLWZpbGUtdXBsb2FkIiwiY3JlYXRlLWJhbmstdXNlciIsImxpc3QtYXBwcm92YWxzIiwiZ2V0LW1lcmNoYW50LXRyYW5zYWN0aW9uLWRldGFpbCIsImxpc3Qtb3V0bGV0LXVwbG9hZC1oaXN0b3J5IiwibGlzdC10ZXJtaW5hbC1idWxrLWNyZWF0aW9uLWZhaWxlZC1pdGVtcyIsIm1lcmNoYW50LWJ1bGstZmlsZS1hcHByb3ZlIiwibGlzdC1hcGstZGVmcyIsImdldC1iYW5rLXN0YWZmLWF1ZGl0LWxvZ3MiLCJnZXQtcGVyc29uYWwtbWVyY2hhbnQtYXVkaXQtbG9ncyIsInVwZGF0ZS1hdmF0YXIiLCJsaXN0LW1lcmNoYW50LXN0YWZmLXVzZXJzIiwiY3JlYXRlLW1lcmNoYW50LXN0YWZmLXVzZXIiLCJhZGQta3ljLWRvY3VtZW50IiwiYXBwcm92YWxzIiwiZ2V0LWRldmljZS1saXN0IiwidmlydHVhbC1hY2NvdW50LWdldC1saW5rZWQtYWNjb3VudC1kZXRhaWxzIiwibGlzdC1zZGstdmVyc2lvbi1kZWZzIiwib3V0bGV0IiwibGlzdC1tZXJjaGFudC1idWxrLWNyZWF0aW9uLWZhaWxlZC1pdGVtcyIsInVwZGF0ZS1tZXJjaGFudCIsImVuYWJsZS1vdXRsZXQiLCJnZXQtcGVyc29uYWwtYmFuay1zdGFmZi1hdWRpdC1sb2dzIiwiZGFzaGJvYXJkIiwibGlzdC1tZXJjaGFudC11cGxvYWQtaGlzdG9yeSIsImFzc2lnbi1vdXRsZXQtdG8tdXNlciIsInRlcm1pbmFsLWJ1bGstZmlsZS1yZWplY3QiLCJzZXR0aW5ncyIsImRpc2FibGUtb3V0bGV0IiwibWVyY2hhbnQtYnVsay1maWxlLXVwbG9hZCIsInVwZGF0ZS1tZXJjaGFudC1hY3F1aXJlciIsImdldC1yaXNrLWxldmVsLWRldGFpbCIsInRyYW5zYWN0aW9ucyIsInRlcm1pbmFsLWJ1bGstZmlsZS1kb3dubG9hZCIsInVzZXJzIiwibGlzdC1vdXRsZXRzIiwic2VsZi1yZWdpc3RyYXRpb24tYXBwcm92ZWQiLCJ1cGRhdGUtb3V0bGV0IiwibGlzdC10ZXJtaW5hbC11cGxvYWQtaGlzdG9yeSIsImdldC1yb2xlLWRldGFpbCIsImxpc3Qtcmlzay1jYXRlZ29yaWVzIiwibWVyY2hhbnQtYnVsay1maWxlLXJlamVjdCIsImRlbGV0ZS1hY2NvdW50IiwiZGV2aWNlIiwibGlzdC1yaXNrLWxldmVsIiwiZ2V0LW1lcmNoYW50LWRldGFpbCIsImdldC1tZXJjaGFudC1kZXZpY2UtbGlzdCIsImxpc3QtbWVyY2hhbnQtbWFuYWdlci11c2VycyIsImxpc3QtbWVyY2hhbnRzIiwiY3JlYXRlLW91dGxldCIsImxpc3Qta3ljLWRvY3VtZW50cyIsImRlZmF1bHQtb3JnYW5pemF0aW9uIiwibGlzdC1tZXJjaGFudC10cmFuc2FjdGlvbnMiLCJnZXQtYXBwcm92YWwtZGV0YWlscyIsIm91dGxldC1idWxrLWZpbGUtbGlzdC1wZW5kaW5nIiwibGlzdC1hcGktbGV2ZWxzIiwibGlzdC1tZXJjaGFudC1kZXZpY2VzIiwiZ2V0LXByb2ZpbGUtZGV0YWlsIiwidmlldy1vdXRsZXQtdHJhbnNhY3Rpb24taGlzdG9yeSIsIm1lcmNoYW50LWJ1bGstZmlsZS1saXN0LXBlbmRpbmciLCJsaXN0LWt5Yy1sZXZlbHMiLCJvdXRsZXQtYnVsay1maWxlLXRlbXBsYXRlLWRvd25sb2FkIiwiZWRpdC1wcm9maWxlIiwiY3JlYXRlLW1lcmNoYW50IiwidXBkYXRlLWFwcHJvdmFsLXN0YXR1cyIsInRlcm1pbmFsLWJ1bGstZmlsZS10ZW1wbGF0ZS1kb3dubG9hZCIsImxpc3Qtb3V0bGV0LWJ1bGstY3JlYXRpb24tZmFpbGVkLWl0ZW1zIiwidXBkYXRlLXJpc2stbGV2ZWwiLCJnZXQtbWVyY2hhbnQtYXVkaXQtbG9ncyIsImxpc3QtcGVybWlzc2lvbnMtYnktb3duZXItdHlwZSIsInRlcm1pbmFsLWJ1bGstZmlsZS1hcHByb3ZlIiwiZ2V0LW91dGxldC11c2VyLWRldGFpbCIsInJlY29uY2lsaWF0aW9uIiwibGlzdC1zZWN1cml0eS1wYXRjaHMiLCJsaXN0LXJpc2stcmVzdHJpY3Rpb25zIiwib3V0bGV0LWJ1bGstZmlsZS1kb3dubG9hZCIsIm1lcmNoYW50LWJ1bGstZmlsZS1kb3dubG9hZCIsImNyZWF0ZS1yb2xlIiwib3V0bGV0LWJ1bGstZmlsZS11cGxvYWQiLCJ0ZXJtaW5hbC1idWxrLWZpbGUtbGlzdC1wZW5kaW5nIiwibGlzdC1iYW5rLXN0YWZmcyIsIm1lcmNoYW50cyIsImF1ZGl0LWxvZ3MiLCJTeXN0ZW0gQWRtaW4gIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJzaWQiOiJkZDU0MmI1Yy0xZGU5LTQ0NjEtOWI2OS03OWYzNmUwNWQ0YzAiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm9yZ2FuaXphdGlvbiI6MjY0LCJuYW1lIjoidGVzdC1IdW1iZXJ0bzM1IEUtY29tbWVyY2UiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJhNjJmZTJmYzEzOTQ3MWVkOGNiOTdmZWQzY2Y3MzQyNGFmNjZkNWYxIiwiZ2l2ZW5fbmFtZSI6InRlc3QtSHVtYmVydG8zNSIsImZhbWlseV9uYW1lIjoiRS1jb21tZXJjZSIsImVtYWlsIjoiYTYyZmUyZmMxMzk0NzFlZDhjYjk3ZmVkM2NmNzM0MjRhZjY2ZDVmMUBwcm9waGl1cy5jb20ifQ.H-VcKqn2VVfDv6UGVtKKmmWSea5qDu_y0spmxYfpcx-DcbNXnEHpo1xm8WDRjYwnSpjcfUjERwQl39cXpGNjVSZT7L7h-HkRNSiBjcC8-cN_sjue1u-7k_dR4JzC3tbXpagS77oTrHlmMuGB5fYn5UuTfHUoeTvN4lbl7Whn45vXJneXBqtp74lQWISYBp32kOHYJfRFQVzK2ZJl2maznIQH4B3_DtV8zge6qV0fzbzMbgGUdYpik20WZNPJENKy8FWO1JZHAJRj8XCXq2rHrLzw-_rD5VjN7hVZc5howojAI5sCOd4L38dTLoc0UHfkA7WXXnyWROEAwwNSQKNx2w'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;


/*

{
    "cardNumber": "512345xxxxxx0008",
    "amount": "110.00",
    "rrn": "421905332739",
    "stan": "332739",
    "cardBrand": "MASTERCARD",
    "status": "N",
    "transactionCurrency": "USD",
    "authCode": "332739",
    "respCode": "00",
    "respDesc": "APPROVED",
    "approved": true,
    "merchantCode": "TESTUBAPROPHNG"
}

*/




### //Step 3: Initiate Payment #############################################


/*


*/


?>
