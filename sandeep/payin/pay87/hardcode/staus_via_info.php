<?php

//http://localhost/gw/api-test/binopay/staus_via_acquirer_transaction_number.php?transID=

$transaction_number='92051703583825'; // transaction
$transaction_number='30401703583974'; // transaction
//$transaction_number='8723122601'; // transaction

if(isset($_REQUEST['transID'])&&trim($_REQUEST['transID'])) $transaction_number=$_REQUEST['transID'];

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => "https://api1.dataprotect.site/api/transaction/v1/transactions/{$transaction_number}/info",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;


/*

{
    "status": 200,
    "result": {
        "transaction_number": "30401703583974",
        "transaction_status": 5,
        "transaction_amount": 12.3,
        "net_amount": 11.81,
        "commission": 4.0,
        "transaction_date_time": "2023-12-26 09:46:14 UTC",
        "is_live_transaction": false,
        "card_owner_name": "Name Name",
        "card_number": "4242",
        "currency": "USD"
    }
	
	Possible statuses:
  STATUS_IN_PROCESS = 1;
  STATUS_APPROVED = 2;
  STATUS_DENIED = 3;
  STATUS_REFUND = 4;;
  STATUS_WAITING_ CONFIRMATION = 5;
}


*/

?>