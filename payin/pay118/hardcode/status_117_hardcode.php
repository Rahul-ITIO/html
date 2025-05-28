<?php


// http://localhost:8080/gw/payin/pay116/hardcode/status_116_hardcode.php

<?php

$curl = curl_init();

curl_setopt_array($curl, array(
		CURLOPT_URL => 'https://api.pay.agency/v1/test/get/transaction',
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>'{
    
    "transaction_id": "T251732530750PDMK4"
}',
		CURLOPT_HTTPHEADER => array(
				'Content-Type: application/json',
				'Authorization: Bearer 29a993a8-ab75-426c-985d-eb8a9f886c13',
				'Cookie: AWSALB=Jskx+Ui93xam625FsveUwPh/rYjBJTLB/2/cDEVrNwgGfWzHQviEt5aw/fkkbhRsuKEn6WRAD86ePyu1z58VGBJCQB3sj+faKr/kVk9tWVLqbQENKCyLRtI9crJo; AWSALBCORS=Jskx+Ui93xam625FsveUwPh/rYjBJTLB/2/cDEVrNwgGfWzHQviEt5aw/fkkbhRsuKEn6WRAD86ePyu1z58VGBJCQB3sj+faKr/kVk9tWVLqbQENKCyLRtI9crJo'
		),
));

$response = curl_exec($curl);

curl_close($curl);

echo "<br/><hr/><br/><h3>response</h3><br/>response=><br/>";
print_r($response);



/*


{
    "status": 200,
    "message": "status",
    "transaction": {
        "order_id": null,
        "transaction_id": "T251732530750PDMK4",
        "terminal_id": null,
        "customer": {
            "first_name": "First Name",
            "last_name": "Last Name",
            "email": "test@gmail.com",
            "phone_number": null
        },
        "billing": {
            "zip": "38564",
            "address": "Address",
            "city": "New York",
            "state": "NY",
            "country": "US"
        },
        "payment_details": [],
        "order": {
            "amount": "10.00",
            "currency": "USD"
        },
        "device": {
            "ip_address": "122.176.92.114"
        },
        "result": {
            "status": "redirected",
            "message": "Additional details required."
        },
        "refund": {
            "status": false,
            "refund_reason": null,
            "refunded_on": null
        },
        "chargebacks": {
            "status": false,
            "chargebacked_on": null
        },
        "flagged": {
            "status": false,
            "flagged_on": null
        }
    }
}


*/




?>
