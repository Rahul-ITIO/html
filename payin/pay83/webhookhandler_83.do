<?

$data['transIDExit']=1;

if(isset($_REQUEST['email'])&&@$_REQUEST['email'])
{
    $data['status_in_email']=1;
    //$data['devEmail']='arun@itio.in';
    $data['devEmail']='arun@itio.in,deeptit@itio.in';
    $send_attchment_message5=1;
}


$_REQUEST['actionurl']='notify';
$_REQUEST['action']='webhook';

//echo $data['ok_webhook']="OK";
header('Content-type:application/json;charset=utf-8');
echo '{
    "Statuscode": "200",
    "Response": "200-OK"
}';

if(isset($_REQUEST['code'])&&@$_REQUEST['code'])
{
    include('../status_in_email.do');
}

include("status_83.do");


/*
================================================================================================

urlpath: https://can-webhook.web1.one/payin/pay83/webhookhandler_83

PHP_INPUT: {"Request":{"body":{"encryptData":"eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiQTI1NktXIn0.ctEIOxLIHB4cyhIAgzgAwsLiT36Mw_Ua4fR5d9i37HLDnOVofBDuMA.KtQuL8szvY5PMtbOv-ckjA.EeOdMLA5SJXAZAA4OAvSD28Q_MFynofKnD3R4IGjMHaHnkmalNsgc54q-uDFlg0amFBhkwBJq6gHSy_BtpEWXJ5DgxCP8bIsLxhPoP7zZ7zw3mR_Jsc9wuIGq-1Xox8RGUOpqMfcAsT9S5pYD9rH8Ndon0Vpws4T1PdCUMz6nRYqXOsIspRXRLQIgipsOZ8pujfRNRO5rqnEYSDXaS97En7nF8CbvgmK1mdC_71vfT_JnjYh9x8YKzQx0-qiYScGj_Psdv8AuciPopuj-wP3e2Ia8EGbade0VYxvxAn45R58RYHlpjImVoQBfvxa7ppgsI6dX7bB450cHyxvhjkHd4O5fTpHO-fQ3VQxN6X7o4UE3AEmpT_Qca3aZ_EP02uvRmdnNT8TdTGg0DSlSguR98fXgdPTMv9e_Dx6E_qlN6Fg6RfoDiV4c3x_cclhrlM6eVg3b6djQksiUo8pbNeVFXx8rl0k_kw0eWeT1MGg9iOQHRWfCkxNUoBFFrnyKSDs.nGRLJi1tXUIliMAsr_jxNg"}}}

================================================================================================


http://15.207.116.247:8080/api/QR/decrypt?encryptedData=eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiQTI1NktXIn0.ctEIOxLIHB4cyhIAgzgAwsLiT36Mw_Ua4fR5d9i37HLDnOVofBDuMA.KtQuL8szvY5PMtbOv-ckjA.EeOdMLA5SJXAZAA4OAvSD28Q_MFynofKnD3R4IGjMHaHnkmalNsgc54q-uDFlg0amFBhkwBJq6gHSy_BtpEWXJ5DgxCP8bIsLxhPoP7zZ7zw3mR_Jsc9wuIGq-1Xox8RGUOpqMfcAsT9S5pYD9rH8Ndon0Vpws4T1PdCUMz6nRYqXOsIspRXRLQIgipsOZ8pujfRNRO5rqnEYSDXaS97En7nF8CbvgmK1mdC_71vfT_JnjYh9x8YKzQx0-qiYScGj_Psdv8AuciPopuj-wP3e2Ia8EGbade0VYxvxAn45R58RYHlpjImVoQBfvxa7ppgsI6dX7bB450cHyxvhjkHd4O5fTpHO-fQ3VQxN6X7o4UE3AEmpT_Qca3aZ_EP02uvRmdnNT8TdTGg0DSlSguR98fXgdPTMv9e_Dx6E_qlN6Fg6RfoDiV4c3x_cclhrlM6eVg3b6djQksiUo8pbNeVFXx8rl0k_kw0eWeT1MGg9iOQHRWfCkxNUoBFFrnyKSDs.nGRLJi1tXUIliMAsr_jxNg

Decrypted Data: {"extTransactionId":"NPSTPAY225516776987","checksum":"","status":"SUCCESS","errCode":"","customer_vpa":"7065491021@ptyes","merchant_vpa":"skp.skywalk001.letspe0014@cnrb","rrn":"423615606794","txnId":"PTMe419edcf455f48e1b0f77c9387169592","amount":"2.00","responseTime":"Fri Aug 23 10:47:36 IST 2024","customerName":"Mithilesh Kumar Singh","remark":"QR SIT testing","channel":"API"}


{
    "extTransactionId": "NPSTPAY225516776987",
    "checksum": "",
    "status": "SUCCESS",
    "errCode": "",
    "customer_vpa": "7065491021@ptyes",
    "merchant_vpa": "skp.skywalk001.letspe0014@cnrb",
    "rrn": "423615606794",
    "txnId": "PTMe419edcf455f48e1b0f77c9387169592",
    "amount": "2.00",
    "responseTime": "Fri Aug 23 10:47:36 IST 2024",
    "customerName": "Mithilesh Kumar Singh",
    "remark": "QR SIT testing",
    "channel": "API"
}

*/

?>