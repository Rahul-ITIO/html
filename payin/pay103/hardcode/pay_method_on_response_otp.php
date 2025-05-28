
<?php
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}

$data['cqp']=1;

$merchant_id='GLADRASHKEN';
$merchant_base_url="https://ap-gateway.mastercard.com/api/rest/version/78/merchant/".$merchant_id;

$apiUsername='merchant.'.$merchant_id;
$PWD='b7e502f1b9955b7135cce1dd985aa501'; // api 
$AuthorizationBasic='Basic bWVyY2hhbnQuR0xBRFJBU0hLRU46YjdlNTAyZjFiOTk1NWI3MTM1Y2NlMWRkOTg1YWE1MDE=';

//echo "<hr/><br/>AuthorizationBasic=>".$AuthorizationBasic;

$AuthorizationBasic='Basic '.base64_encode("merchant.$merchant_id:$PWD");

echo "<hr/><br/>AuthorizationBasic=>".$AuthorizationBasic;
//exit;



$get_session_id='SESSION0002670573015F5381919H66';
$transID='ipg3DRedirect00003';

if(isset($_GET['get_session_id'])&&trim($_GET['get_session_id']))$get_session_id=$_GET['get_session_id'];
if(isset($_GET['transID'])&&trim($_GET['transID']))$transID=$_GET['transID'];


// http://localhost:8080/gw/payin/pay103/hardcode/pay_method_on_response_otpphp

// https://ipg.i15.tech/payin/pay103/hardcode/pay_method_on_response_otp.php?get_session_id=SESSION0002670573015F5381919H66&transID=ipg3DRedirect00003



$postData_5='{
    "apiOperation": "PAY",
    "authentication": {
        "transactionId": "'.$transID.'"
    },
    "session": {
        "id": "'.$get_session_id.'"
    },
    "transaction": {
        "reference": "'.$transID.'"
    }
}';


$url_step_5="https://ap-gateway.mastercard.com/api/rest/version/78/merchant/GLADRASHKEN/order/{$transID}/transaction/{$transID}Tra";

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $url_step_5,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'PUT',
    CURLOPT_HEADER => 0,
    CURLOPT_SSL_VERIFYPEER => 0,
    CURLOPT_SSL_VERIFYHOST => 0,
  CURLOPT_POSTFIELDS =>$postData_5,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: '.$AuthorizationBasic
  ),
));

$response_5 = curl_exec($curl);

curl_close($curl);
//echo $response_5;

$response_5_via_pay=json_decode($response_5,1);

if(isset($response_5_via_pay['authentication']['redirect']['html'])){
    unset($response_5_via_pay['authentication']['redirect']['html']);
}

if($data['cqp']>0) 
{
    echo "<hr/><br/>url_step_5=>".$url_step_5;
    echo "<br/><br/>postData_5=><br/>";
    print_r($postData_5);
    echo "<br/>";
    echo "<br/><br/>response_5_via_pay=><br/>";
    print_r($response_5_via_pay);
    echo "<br/>";
    echo "<br/>session_id=>".$get_session_id."<br/>";
    echo "<br/>transID=>".$transID."<br/>";
}


/*

{
    "authentication": {
        "3ds": {
            "acsEci": "05",
            "authenticationToken": "AAIBAlOIYgAAAAABhAF4dYdilzc=",
            "transactionId": "51cacbc3-40b4-410c-82f9-21cfa950fe8c"
        },
        "3ds2": {
            "acsReference": "3DS_LOA_ACS_FSSP_020200_00440",
            "acsTransactionId": "f5a28646-b0eb-4aaa-9a09-8e2c9ccf47bf",
            "authenticationScheme": "VISA",
            "dsReference": "VISA.V 17 0003",
            "dsTransactionId": "51cacbc3-40b4-410c-82f9-21cfa950fe8c",
            "protocolVersion": "2.2.0",
            "transactionStatus": "Y"
        },
        "amount": 0.01,
        "time": "2024-06-26T09:22:40.875Z",
        "transactionId": "ipg3DRedirect00003",
        "version": "3DS2"
    },
    "authorizationResponse": {
        "cardLevelIndicator": "C ",
        "cardSecurityCodeError": "M",
        "commercialCard": "!01",
        "commercialCardIndicator": "0",
        "date": "0626",
        "posData": "1025100006600",
        "posEntryMode": "812",
        "processingCode": "000000",
        "responseCode": "61",
        "returnAci": "N",
        "stan": "152341",
        "time": "092824",
        "transactionIdentifier": "404178341058792",
        "validationCode": "NA  ",
        "vpasResponse": "2"
    },
    "device": {
        "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:128.0) Gecko/20100101 Firefox/128.0",
        "ipAddress": "122.176.92.114"
    },
    "gatewayEntryPoint": "WEB_SERVICES_API",
    "merchant": "GLADRASHKEN",
    "order": {
        "amount": 0.01,
        "authenticationStatus": "AUTHENTICATION_SUCCESSFUL",
        "chargeback": {
            "amount": 0,
            "currency": "USD"
        },
        "creationTime": "2024-06-26T09:22:40.870Z",
        "currency": "USD",
        "id": "ipg3DRedirect00003",
        "lastUpdatedTime": "2024-06-26T09:28:25.472Z",
        "merchantAmount": 0.01,
        "merchantCategoryCode": "5734",
        "merchantCurrency": "USD",
        "reference": "ipg3DRedirect00003",
        "status": "FAILED",
        "totalAuthorizedAmount": 0.00,
        "totalCapturedAmount": 0.00,
        "totalDisbursedAmount": 0.00,
        "totalRefundedAmount": 0.00
    },
    "response": {
        "acquirerCode": "61",
        "acquirerMessage": "Exceeds withdrawal amount limits",
        "cardSecurityCode": {
            "acquirerCode": "M",
            "gatewayCode": "MATCH"
        },
        "gatewayCode": "DECLINED",
        "gatewayRecommendation": "RESUBMIT_WITH_ALTERNATIVE_PAYMENT_DETAILS"
    },
    "result": "FAILURE",
    "risk": {
        "response": {
            "gatewayCode": "ACCEPTED",
            "provider": "Brighterion",
            "review": {
                "decision": "NOT_REQUIRED"
            },
            "rule": [
                {
                    "data": "NO_RULES",
                    "name": "MSO_3D_SECURE",
                    "recommendation": "NO_ACTION",
                    "type": "MSO_RULE"
                },
                {
                    "data": "428102",
                    "name": "MSO_BIN_RANGE",
                    "recommendation": "NO_ACTION",
                    "type": "MSO_RULE"
                },
                {
                    "data": "122.176.92.114",
                    "name": "MSO_IP_ADDRESS_RANGE",
                    "recommendation": "NO_ACTION",
                    "type": "MSO_RULE"
                },
                {
                    "data": "IND",
                    "name": "MSO_IP_COUNTRY",
                    "recommendation": "NO_ACTION",
                    "type": "MSO_RULE"
                }
            ],
            "totalScore": 5
        }
    },
    "sourceOfFunds": {
        "provided": {
            "card": {
                "brand": "VISA",
                "expiry": {
                    "month": "3",
                    "year": "28"
                },
                "fundingMethod": "CREDIT",
                "number": "428102xxxxxx8691",
                "scheme": "VISA",
                "storedOnFile": "NOT_STORED"
            }
        },
        "type": "CARD"
    },
    "timeOfLastUpdate": "2024-06-26T09:28:25.472Z",
    "timeOfRecord": "2024-06-26T09:28:24.564Z",
    "transaction": {
        "acquirer": {
            "batch": 20240626,
            "date": "0626",
            "id": "UBAKEN_S2I",
            "merchantId": "GLADRASHKEN033",
            "settlementDate": "2024-06-26",
            "timeZone": "+0300",
            "transactionId": "404178341058792"
        },
        "amount": 0.01,
        "authenticationStatus": "AUTHENTICATION_SUCCESSFUL",
        "currency": "USD",
        "id": "ipg3DRedirect00003A",
        "receipt": "417809152341",
        "reference": "ipg3DRedirect00003",
        "source": "INTERNET",
        "stan": "152341",
        "terminal": "UBAS3I01",
        "type": "PAYMENT"
    },
    "version": "78"
}

*/


?>

