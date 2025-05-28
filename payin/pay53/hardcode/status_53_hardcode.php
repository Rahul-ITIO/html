<?php

// http://localhost:8080/gw/payin/pay53/hardcode/status_53_hardcode.php


//{"auth_ApiKey":"a62fe2fc139471ed8cb97fed3cf73424af66d5f1","header_ApiKey":"a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127"}


$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://pr-web-payment-gateway-k8.dev.prophius-api.com/api/v1/report/get-transaction-detail/TESTUBAPROPHNG/f4ac2201-3d8b-4d01-a0a7-eb5a7a4ed252',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
  CURLOPT_HTTPHEADER => array(
    'ApiKey: a98a7967053c85aa413ffe3bab0a0e3dd11541b775acfee8e958f3f44cd947263d13f2a4f69d6807d58e3a2317f1093b5ed1e5082bbbe01240cb3127',
    'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlNlFqTDNLWHU0TkZfbWtlN2JKNFZjZnFSTUxFdHl5RlcwSlMwSVc3Wk9vIn0.eyJleHAiOjE3MjMwMDY4MDAsImlhdCI6MTcyMjkyMDQwMCwianRpIjoiZmQ3NGQ5NTAtNDQwNC00NDkyLWIzM2EtOWRjZDA3NWYxNDY2IiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay5kZXYucHJvcGhpdXMtYXBpLmNvbS9hdXRoL3JlYWxtcy90YXAtdG8tcGhvbmUiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMWU1Y2M0YjktZWQyZS00ZmFlLTgwYzMtZGJmNmVjZWUyNDM5IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoicHJvcGhpdXMtdGVzdCIsInNlc3Npb25fc3RhdGUiOiJkZDU0MmI1Yy0xZGU5LTQ0NjEtOWI2OS03OWYzNmUwNWQ0YzAiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwib3JnYW5pemF0aW9uLWFkbWluIiwidW1hX2F1dGhvcml6YXRpb24iLCJkZWZhdWx0LXJvbGVzLXRhcC10by1waG9uZSJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InByb3BoaXVzLXRlc3QiOnsicm9sZXMiOlsiZ2V0LW91dGxldC1hc3NpZ25lZC11c2VyLWxpc3QiLCJsaXN0LXBlcm1pc3Npb25zIiwicmVwb3J0cyIsImRpc2FibGUtYWNjb3VudCIsInZpZXctb3V0bGV0LXRyYW5zYWN0aW9uLWRldGFpbCIsIm1lcmNoYW50LWJ1bGstZmlsZS10ZW1wbGF0ZS1kb3dubG9hZCIsIm1lcmNoYW50LWJ1bGstZmlsZS1oaXN0b3J5LWRldGFpbCIsImxpc3Qtcm9sZXMiLCJvdXRsZXQtYnVsay1maWxlLWhpc3RvcnktZGV0YWlsIiwidmlydHVhbC1hY2NvdW50LXNlbmQtcmVwb3J0LW1haWwiLCJ0ZXJtaW5hbC1idWxrLWZpbGUtdXBsb2FkIiwiY3JlYXRlLWJhbmstdXNlciIsImxpc3QtYXBwcm92YWxzIiwiZ2V0LW1lcmNoYW50LXRyYW5zYWN0aW9uLWRldGFpbCIsImxpc3Qtb3V0bGV0LXVwbG9hZC1oaXN0b3J5IiwibGlzdC10ZXJtaW5hbC1idWxrLWNyZWF0aW9uLWZhaWxlZC1pdGVtcyIsIm1lcmNoYW50LWJ1bGstZmlsZS1hcHByb3ZlIiwibGlzdC1hcGstZGVmcyIsImdldC1iYW5rLXN0YWZmLWF1ZGl0LWxvZ3MiLCJnZXQtcGVyc29uYWwtbWVyY2hhbnQtYXVkaXQtbG9ncyIsInVwZGF0ZS1hdmF0YXIiLCJsaXN0LW1lcmNoYW50LXN0YWZmLXVzZXJzIiwiY3JlYXRlLW1lcmNoYW50LXN0YWZmLXVzZXIiLCJhZGQta3ljLWRvY3VtZW50IiwiYXBwcm92YWxzIiwiZ2V0LWRldmljZS1saXN0IiwidmlydHVhbC1hY2NvdW50LWdldC1saW5rZWQtYWNjb3VudC1kZXRhaWxzIiwibGlzdC1zZGstdmVyc2lvbi1kZWZzIiwib3V0bGV0IiwibGlzdC1tZXJjaGFudC1idWxrLWNyZWF0aW9uLWZhaWxlZC1pdGVtcyIsInVwZGF0ZS1tZXJjaGFudCIsImVuYWJsZS1vdXRsZXQiLCJnZXQtcGVyc29uYWwtYmFuay1zdGFmZi1hdWRpdC1sb2dzIiwiZGFzaGJvYXJkIiwibGlzdC1tZXJjaGFudC11cGxvYWQtaGlzdG9yeSIsImFzc2lnbi1vdXRsZXQtdG8tdXNlciIsInRlcm1pbmFsLWJ1bGstZmlsZS1yZWplY3QiLCJzZXR0aW5ncyIsImRpc2FibGUtb3V0bGV0IiwibWVyY2hhbnQtYnVsay1maWxlLXVwbG9hZCIsInVwZGF0ZS1tZXJjaGFudC1hY3F1aXJlciIsImdldC1yaXNrLWxldmVsLWRldGFpbCIsInRyYW5zYWN0aW9ucyIsInRlcm1pbmFsLWJ1bGstZmlsZS1kb3dubG9hZCIsInVzZXJzIiwibGlzdC1vdXRsZXRzIiwic2VsZi1yZWdpc3RyYXRpb24tYXBwcm92ZWQiLCJ1cGRhdGUtb3V0bGV0IiwibGlzdC10ZXJtaW5hbC11cGxvYWQtaGlzdG9yeSIsImdldC1yb2xlLWRldGFpbCIsImxpc3Qtcmlzay1jYXRlZ29yaWVzIiwibWVyY2hhbnQtYnVsay1maWxlLXJlamVjdCIsImRlbGV0ZS1hY2NvdW50IiwiZGV2aWNlIiwibGlzdC1yaXNrLWxldmVsIiwiZ2V0LW1lcmNoYW50LWRldGFpbCIsImdldC1tZXJjaGFudC1kZXZpY2UtbGlzdCIsImxpc3QtbWVyY2hhbnQtbWFuYWdlci11c2VycyIsImxpc3QtbWVyY2hhbnRzIiwiY3JlYXRlLW91dGxldCIsImxpc3Qta3ljLWRvY3VtZW50cyIsImRlZmF1bHQtb3JnYW5pemF0aW9uIiwibGlzdC1tZXJjaGFudC10cmFuc2FjdGlvbnMiLCJnZXQtYXBwcm92YWwtZGV0YWlscyIsIm91dGxldC1idWxrLWZpbGUtbGlzdC1wZW5kaW5nIiwibGlzdC1hcGktbGV2ZWxzIiwibGlzdC1tZXJjaGFudC1kZXZpY2VzIiwiZ2V0LXByb2ZpbGUtZGV0YWlsIiwidmlldy1vdXRsZXQtdHJhbnNhY3Rpb24taGlzdG9yeSIsIm1lcmNoYW50LWJ1bGstZmlsZS1saXN0LXBlbmRpbmciLCJsaXN0LWt5Yy1sZXZlbHMiLCJvdXRsZXQtYnVsay1maWxlLXRlbXBsYXRlLWRvd25sb2FkIiwiZWRpdC1wcm9maWxlIiwiY3JlYXRlLW1lcmNoYW50IiwidXBkYXRlLWFwcHJvdmFsLXN0YXR1cyIsInRlcm1pbmFsLWJ1bGstZmlsZS10ZW1wbGF0ZS1kb3dubG9hZCIsImxpc3Qtb3V0bGV0LWJ1bGstY3JlYXRpb24tZmFpbGVkLWl0ZW1zIiwidXBkYXRlLXJpc2stbGV2ZWwiLCJnZXQtbWVyY2hhbnQtYXVkaXQtbG9ncyIsImxpc3QtcGVybWlzc2lvbnMtYnktb3duZXItdHlwZSIsInRlcm1pbmFsLWJ1bGstZmlsZS1hcHByb3ZlIiwiZ2V0LW91dGxldC11c2VyLWRldGFpbCIsInJlY29uY2lsaWF0aW9uIiwibGlzdC1zZWN1cml0eS1wYXRjaHMiLCJsaXN0LXJpc2stcmVzdHJpY3Rpb25zIiwib3V0bGV0LWJ1bGstZmlsZS1kb3dubG9hZCIsIm1lcmNoYW50LWJ1bGstZmlsZS1kb3dubG9hZCIsImNyZWF0ZS1yb2xlIiwib3V0bGV0LWJ1bGstZmlsZS11cGxvYWQiLCJ0ZXJtaW5hbC1idWxrLWZpbGUtbGlzdC1wZW5kaW5nIiwibGlzdC1iYW5rLXN0YWZmcyIsIm1lcmNoYW50cyIsImF1ZGl0LWxvZ3MiLCJTeXN0ZW0gQWRtaW4gIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJzaWQiOiJkZDU0MmI1Yy0xZGU5LTQ0NjEtOWI2OS03OWYzNmUwNWQ0YzAiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm9yZ2FuaXphdGlvbiI6MjY0LCJuYW1lIjoidGVzdC1IdW1iZXJ0bzM1IEUtY29tbWVyY2UiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJhNjJmZTJmYzEzOTQ3MWVkOGNiOTdmZWQzY2Y3MzQyNGFmNjZkNWYxIiwiZ2l2ZW5fbmFtZSI6InRlc3QtSHVtYmVydG8zNSIsImZhbWlseV9uYW1lIjoiRS1jb21tZXJjZSIsImVtYWlsIjoiYTYyZmUyZmMxMzk0NzFlZDhjYjk3ZmVkM2NmNzM0MjRhZjY2ZDVmMUBwcm9waGl1cy5jb20ifQ.H-VcKqn2VVfDv6UGVtKKmmWSea5qDu_y0spmxYfpcx-DcbNXnEHpo1xm8WDRjYwnSpjcfUjERwQl39cXpGNjVSZT7L7h-HkRNSiBjcC8-cN_sjue1u-7k_dR4JzC3tbXpagS77oTrHlmMuGB5fYn5UuTfHUoeTvN4lbl7Whn45vXJneXBqtp74lQWISYBp32kOHYJfRFQVzK2ZJl2maznIQH4B3_DtV8zge6qV0fzbzMbgGUdYpik20WZNPJENKy8FWO1JZHAJRj8XCXq2rHrLzw-_rD5VjN7hVZc5howojAI5sCOd4L38dTLoc0UHfkA7WXXnyWROEAwwNSQKNx2w'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;


/*

{
    "transactionId": 130998,
    "merchantCode": "TESTUB****PHNG",
    "paymentChannel": "WEB GATEWAY",
    "paymentType": "ECOM_PAYMENT",
    "transactionRef": "84770574",
    "referenceNumber": "f4ac22**************************d252",
    "status": "SUCCESS",
    "merchantName": "ECOM A***TEST",
    "companyType": "Other",
    "address": "4028 W**********Road",
    "location": "4028 W**********Road",
    "amount": "110.00",
    "transactionCurrency": "USD",
    "billingAmount": "110.00",
    "billingCurrency": "USD",
    "dateTime": "2024-08-06T05:05:25.443+00:00",
    "responseCode": "00",
    "responseDetail": "APPROVED",
    "transactionDescription": null,
    "authCode": "332739",
    "cardNo": "512345******0008",
    "rrn": "421905**2739",
    "stan": "332739",
    "reversalReason": null,
    "cardSchema": null
}

*/




?>
