<?php

// http://localhost:8080/gw/payin/pay84/hard_code/payment_84_hardcode.php

$data['cqp']=3;
$acquirer=841;

$curl = curl_init();

$transID='abc1245678901'.date('is');

curl_setopt_array($curl, array(
		CURLOPT_URL => 'https://api.nsbetawah.com/generate-token',
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>'{
    "email":"ankitesh@letspe.com",
    "password":"Lets@1001"
}',
		CURLOPT_HTTPHEADER => array(
				'Content-Type: application/json'
		),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;

$response_token_array=json_decode(@$response,1);

$token=$response_token_array['token'];

if(@$data['cqp']>0){
    echo "<br/><hr/><br/>response=><br/>";
    print_r(@$response);

    echo "<br/><hr/><br/>response_token_array=><br/>";
    print_r(@$response_token_array);

    echo "<br/><hr/><br/>token=><br/>";
    print_r(@$token);
    
}

/*

{
    "status": 1,
    "message": "The Token is generated successfully.",
    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzkwOWY1MWYzMWExNmEyYzI3ZDgzYzlmNjg2ZjQ0NjQ5ZWI4ZWVhNmRkNmE5MDU3YTFhMzBiNTcyMzBmMzE3NThkYjgzMjNmZDEzYWM3MWEiLCJpYXQiOjE3MjM1NTQ0OTMuNTE4OTE1LCJuYmYiOjE3MjM1NTQ0OTMuNTE4OTE4LCJleHAiOjE3NTUwOTA0OTMuNTE3MTYsInN1YiI6IjE4Iiwic2NvcGVzIjpbXX0.nygQ7_hR9hRW3eRHn3Jo9jNPOL7B3eODBfpNm_xzvwFA2c1jJsKxWpbqY66R8x4aKo5LA84kckPiWZYGt2xvOmz0cC16933bE3W4KiNbu0ISQUZGy3cngw0go6ZT3xmym3q0OzjpDRVAbIngKIv6E1Hr2XreFzYsDrnrdtNIr6iqxtgfL7huzRZtsXcohGYC3XFsZES6UeEivDBMG8Mmzh-rPCQaHKyNh19i3KAMRgAzyEL_xvlZ5OMotEykNnSu4Ot_qS8zfqKU4kYhdzKvsqjfJGUQtjiPpqGESEmUKwtI5IRbtsTjnPhzF9cpJzjWwaNFUUI11cs-k0jPiRYz_cfTcKqN2iOg9RwqNa69LavaLQIipwMXfIfM4obk9yAO1wsyjKl0e5mVSmH0fU8Sq2zbHyQx69JMOMn23rxLG7cCBvQ6PvVgrEfTJ0k_Hn8MP49sw61OAuZM61cs7HBE04hXDtxaIrEyJc6A9P1Qc9d2SHsPoNpy1J8-deGt-6isIoCi1mNroMjtH6n9CwJ6TBNIQZHee2R-vigp9bststk6NWEDfjzSToNSiVb13iudEIoEZYFpT12dclMwxr5gGEE2LVFhtLvz-4Z6NOkyXtUV30J74wadFyiC2OfBrV63WOipC27jhSCwQjxdNmhtacb1210hBDX-C3oQ2-GtpYQ"
}

*/




//intent for QR dynamic code QR & if device is mobile then push the INTENT via hard code key

if( ($acquirer==84) || (isset($post['mop'])&&$post['mop']=='QRINTENT') )
{ //for QR dynamic code QR & INTENT


    $curl = curl_init();

    curl_setopt_array($curl, array(
            CURLOPT_URL => 'https://api.nsbetawah.com/payin/intent/1',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS =>'{
    "transactionId": "'.@$transID.'",
    "amount": "10",
    "remark": "iphone"
    }',
            CURLOPT_HTTPHEADER => array(
                    'Content-Type: application/json',
                    'Authorization: Bearer '.$token
            ),
    ));

    $response = curl_exec($curl);

    curl_close($curl);
   // echo $response;

    $response_intent_array=json_decode(@$response,1);
    $qrString=@$response_token_array['data']['qrString'];

    if(@$data['cqp']>0){
        echo "<br/><hr/><br/>response=><br/>";
        print_r(@$response);

        echo "<br/><hr/><br/>response_intent_array=><br/>";
        print_r(@$response_intent_array);

        echo "<br/><hr/><br/>qrString=><br/>";
        print_r(@$qrString);
        
    }

    /*


    $intent_process_include=1;
    $qr_intent_address=replace_space_tab_br_for_intent_deeplink($qrString,1);
    $requestIntentQr=json_decode($IntentRequest,1);
        
    $tr_upd_order['IntentRequest'] = $requestIntentQr;
    $tr_upd_order['qrString'] =$qrString;
    trans_updatesf($_SESSION['tr_newid'],$tr_upd_order);


    */

    /*

    {
        "status": 1,
        "message": "Successful.",
        "data": {
            "transactionId": "abc124567890161",
            "amount": "20",
            "qrString": "upi://pay?ver=01&mode=15&am=20.00&cu=INR&pa=sbe.sbemid0001.poutube039@cnrb&pn=2Skywalk Technologies Private Limited&mc=6012&tr=abc124567890161&tn=iphone&mid=SBEMID0001&msid=POUTUBE039&mtid="
        }
    }

    */

}

// collect
elseif( ($acquirer==841) || (isset($post['mop'])&&$post['mop']=='UPICOLLECT') ){

    //"upiId": "itio@paytm"
    //"upiId": "7065491021@paytm"
    //"upiId": "9315980939@paytm"

    $collect_payload='{
        "transactionId": "'.@$transID.'",
        "amount": "15.00",
        "remark": "testing payin for iphone",
        "upiId": "itio@paytm",
        "customerName": "Arun Dixit"
    }';

    $curl = curl_init();

    curl_setopt_array($curl, array(
            CURLOPT_URL => 'https://api.nsbetawah.com/payin/collect/1',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS =>$collect_payload,
            CURLOPT_HTTPHEADER => array(
                    'Content-Type: application/json',
                    'Authorization: Bearer '.$token
            ),
    ));

    $response = curl_exec($curl);

    curl_close($curl);
   // echo $response;


    $collect_payload_array=json_decode(@$collect_payload,1);
    $response_collect_array=json_decode(@$response,1);
    $respMessge=@$response_collect_array['data']['response'][0]['respMessge'];
    $upiTxnId=@$response_collect_array['data']['response'][0]['upiTxnId'];


    if(@$data['cqp']>0){
        echo "<br/><hr/><br/>collect_payload_array=><br/>";
        print_r(@$collect_payload_array);

        echo "<br/><hr/><br/>response=><br/>";
        print_r(@$response);

        echo "<br/><hr/><br/>response_collect_array=><br/>";
        print_r(@$response_collect_array);

        echo "<br/><hr/><br/>respMessge=><br/>";
        print_r(@$respMessge);
        
        echo "<br/><hr/><br/>upiTxnId=><br/>";
        print_r(@$upiTxnId);
        
    }


    /*

    {
        "status": 1,
        "message": "Successful.",
        "data": {
            "transactionId": "abc124567890163",
            "amount": "10",
            "response": [
                {
                    "respCode": "0",
                    "respMessge": "Collect request initiated successfully",
                    "upiTxnId": "CAN41A6B77C4E064CC7854494F1991AC00E",
                    "txnTime": "Tue Aug 13 18:40:53 IST 2024"
                }
            ]
        }
    }

    */

}