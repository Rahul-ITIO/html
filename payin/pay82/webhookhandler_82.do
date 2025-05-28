<?

$data['transIDExit']=1;

if(isset($_REQUEST['email'])&&@$_REQUEST['email'])
{
    $data['status_in_email']=1;
    //$data['devEmail']='arun@itio.in';
    $data['devEmail']='arun@itio.in';
    $send_attchment_message5=1;
}

$_REQUEST['actionurl']='notify';
$_REQUEST['action']='webhook';

//echo $data['ok_webhook']="OK";
header('Content-type:application/json;charset=utf-8');
echo '{
    "returnCode": "0",
    "responseMessage": "Successful"
}';


if(isset($_REQUEST['email'])&&@$_REQUEST['email']) 
{
    include('../status_in_email.do');
}

include("status_82.do");


/*

{
    "returnCode": "0",
    "partner": "letspe private limited",
    "CallBackResponse": {
        "TxnStatus": "0",
        "TxnAmt": "1.01",
        "TxnType": "CREDIT",
        "RRN": "451814154170",
        "CBS_Ref_Num": "UC451814154170001PTM",
        "TXN_ID": "PTM75c3bebe227a46d4a437e6f0692bae4b",
        "InitiationMode": "01",
        "CustomerVPA": "sky.deepti@finobank",
        "CustomerName": "deepti tyagi",
        "CustomerIFSC": "FINO0000001",
        "CustomerAccNum": "3218000207",
        "CustomerAccType": "SAVINGS",
        "PayerMobileNumber": "917065491021",
        "PayerVPA": "7065491021@paytm",
        "PayerName": "Mithilesh Kumar Singh",
        "PayerAccType": "SAVINGS",
        "TransactionDateTime": "2024-05-31T13:18:28+05:30",
        "PartnerID": "2052336971245682688",
        "PartnerName": "LETSPE PRIVATE LIMITED",
        "UPIRefID": "FINOUPI82105463880454",
        "MsgId": "3MQnE7g0vFR",
        "TransactionNote": "Test Product"
    },
    "responseMessage": "SUCCESS"
}

*/

?>