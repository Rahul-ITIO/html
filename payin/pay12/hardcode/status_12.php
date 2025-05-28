<?php
//status 12
error_reporting(0);
//error_reporting(E_ALL);
//error_reporting(E_ERROR | E_WARNING | E_PARSE);

$qp=0;
$is_curl_on=true;

if(isset($_REQUEST['orderId'])){
	 $transID=$_REQUEST['transID']=$_REQUEST['orderId'];
}



ini_set('max_execution_time', 0);
//include("ApiWebService.php");
require_once("ApiWebService.php");
$ApiWebService = new ApiWebService();

//echo "<br>ApiWebService=>"; print_r($ApiWebService);

$arg0 = new authDTO();

//include('config_adv.php');
$transID='24456789889';
$apc_get['sci_name']='digi51_USDT_SCI_B';
$apiPass='2024@2024';
$apiName='digi51_API_A';



if(isset($_REQUEST['transID'])){
	$transID=$_REQUEST['transID']=$_REQUEST['transID'];
}

//echo "<br>transID 2=>".$transID;


$arg0->apiName = $apiName;
$arg0->accountEmail = "onternity@gmail.com";
$arg0->authenticationToken = $ApiWebService->getAuthenticationToken($apiPass);





$arg1 = new paymentOrderRequest();
//$arg1->sciName = "website scI adv";
$arg1->sciName = $apc_get['sci_name'];
$arg1->orderId = $transID;

$findPaymentByOrderId = new findPaymentByOrderId();
$findPaymentByOrderId->arg0 = $arg0;
$findPaymentByOrderId->arg1 = $arg1;


$findPaymentByOrderIdResponse = $ApiWebService->findPaymentByOrderId($findPaymentByOrderId);
$results2=($findPaymentByOrderIdResponse->return);

//echo "<hr><br>results2=>"; print_r($results2);
    
$status=$results2->cryptoCurrencyInvoiceStatus;
$paymentStatus=$results2->paymentStatus;
$transactionStatus=$results2->transactionStatus;
$transactionAmount=$results2->transactionAmount;	
$transactionCurrency=$results2->transactionCurrency;	

$results = $responseParamList =  (array) $results2;

$message = $status;

try {
    
    if($qp)
    {
        echo "<hr/>cryptoCurrencyInvoiceStatus==>".$results2->cryptoCurrencyInvoiceStatus; echo "<hr/>paymentStatus==>".$results2->paymentStatus; echo "<hr/>results2==>".json_encode($results2);
        
            
    }
    
} catch (Exception $e) {
    $message =$e->getMessage();
    $message.=$e->getTraceAsString();
    echo "ERROR MESSAGE => " . $e->getMessage() . "<br/>"; echo $e->getTraceAsString();
}

//if($qp)
{
    echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
    //echo "res=>"; print_r($res);
    
    echo "<br/>acquirer_status_url=> ".@$acquirer_status_url;
    echo "<br/>acquirer status=> ".@$responseParamList['cryptoCurrencyInvoiceStatus'];
    echo "<br/>acquirer message=> ".@$responseParamList['paymentStatus'];
    
    //echo "<br/>response_json=> ".@$response_json;
    echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
    
    //echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
    echo '<br/><br/></div>';
}
		

    

?>