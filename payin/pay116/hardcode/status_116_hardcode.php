<?php


// http://localhost:8080/gw/payin/pay116/hardcode/status_116_hardcode.php


$curl = curl_init();

curl_setopt_array($curl, array(
	CURLOPT_URL => 'https://api.paysaddle.com/api/transactions/requery/MID635fcda6321d5/NP24112509325212117',
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

echo "<br/><hr/><br/><h3>Step 3: Capture the Payment</h3><br/>response=><br/>";
print_r($response);



/*

{
    "currency_code": "NGN",
    "customerName": "Customer/INSTANT",
    "maskedPan": "5129********0468",
    "email": "temidoswag@gmail.com",
    "narration": "N/A",
    "orderId": "NPT6YZARVB1399366045637551",
    "message": null,
    "transId": "NP24112509325212117",
    "result": "Transaction failed",
    "amount": 1,
    "status": "Failed",
    "code": "90"
}
*/




?>
