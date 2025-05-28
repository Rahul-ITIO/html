<?
 $Username = $apc_get['AccountID'];
 $Password = $apc_get['APIkey'];

 $credentials = $Username . ':' . $Password;
  $encodedCredentials = base64_encode($credentials);
  
//first process for create Invoice 
$reference_id = mt_rand(100000000, 999999999);
$Create_Invoice_Request='{
      "data":{
          "type":"payment-invoices",
          "attributes":{
            "reference_id":"'.@$transID.'",
           "amount": ' . $total_payment . ',
            "currency":"'.$orderCurrency.'",
            "service":"payment_card_eur_hpp",
            "flow":"charge",
            "test_mode":true,
            "description":"Invoice Example",
            "gateway_options":{
                "cardgate":{
                  "tokenize":false
                }
            },
            "customer": {
                "reference_id": "'.$reference_id.'",
                "name": "'.$post['ccholder'].'",
                "email": "'.$post['bill_email'].'",
                "phone": "'.$post['bill_phone'].'",
                "date_of_birth": "1995-08-09",
                "address": {
                    "full_address": "'.@$post['bill_address'].'",
                    "country": "'.@$post['bill_country'].'",
                    "region": "Catalonia",
                    "city": "'.@$post['bill_city'].'",
                    "street": "'.$post['bill_street_1'].'",
                    "post_code": "'.@$post['bill_zip'].'"
                },
            "metadata": {
                    "key1": "value1",
                    "key2": "value2"
                }
            },
            "metadata":{
                "key":"value"
            },
            "return_url":"'.$return_url.'",
            "return_urls": {
                "success":"'.$success_url_3.'",
                "pending":"'.$trans_processing.'",
                "fail":"'.$fail_url_3.'"
            },
            "callback_url":"'.$webhookhandler.'"
          }
      }
    }';
    
    //echo $Create_Invoice_Request;
    
    $Invoice_Request = json_decode($Create_Invoice_Request,1);
    
    $InvoiceUrl =$bank_url . '/payment-invoices';
    
    $curl = curl_init();

   curl_setopt_array($curl, array(
  CURLOPT_URL =>  $InvoiceUrl,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>$Create_Invoice_Request,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: Basic ' . $encodedCredentials
  ),
));

   $response = curl_exec($curl);


   $Invoice_Response = json_decode($response,1);
 
  // print_r($Invoice_Response);
   
   $id = $Invoice_Response['data']['id'];
 $token = $Invoice_Response['data']['attributes']['flow_data']['metadata']['token'];
 
 $tr_upd_order1['acquirer_ref']=$id;
$tr_upd_order1['Invoice_Request']=$Invoice_Request;
$tr_upd_order1['Invoice_Url']= $InvoiceUrl;
$tr_upd_order1['Invoice_Response']=$Invoice_Response;
trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);
   
   if($data['cqp']>0) 
{
    
    echo "<br/><hr/><br/>Invoice_Url=><br/>"; print_r($InvoiceUrl);
    echo "<br/><br/>Invoice_Request=><br/>"; print_r($Invoice_Request);
    echo "<br/><br/>response=><br/>"; print_r($response);
    echo "<br/><br/>tr_upd_order1=><br/>"; print_r($tr_upd_order1);
}

//we will proceed with token for next APi card send data 
 if($token){
    
   // echo $token;
    
      $CardSaleRequest = '{
     "data": {
     
        "type": "sale-operation",
        
        "attributes": {
          "card_number": "'.@$post['ccno'].'",
          "card_holder": "'.$post['ccholder'].'",
          "cvv":  "'.@$post['ccvv'].'",
          "exp_month": "'.@$post['month'].'",
          "exp_year": "'.@$post['year'].'",
          
              "browser_info": {
                            "browser_color_depth": "24",
                            "browser_ip": "'.$_SESSION['bill_ip'].'",
                            "browser_java_enabled": false,
                            "browser_language": "en-US",
                            "browser_screen_height": "1200",
                            "browser_screen_width": "1920",
                            "browser_tz": "'.$_SERVER['HTTP_USER_AGENT'].'",
                            "window_height": "***",
                            "window_width": "***",
                            "browser_accept_header": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
      }
    }
  }
}';
    

$salecardReq = json_decode($CardSaleRequest, true);


// thisis the Api for 3D response,2D response

     $CardSaleUrl = "https://checkout.wzrdpay.io/payment/sale";
    //print_r($salecardReq);

    $curl = curl_init();

    curl_setopt_array($curl, array(
        CURLOPT_URL => $CardSaleUrl,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => $CardSaleRequest,
        CURLOPT_HTTPHEADER => array(
            'Content-Type: application/json',
            'Authorization: Bearer ' . $token
        ),
    ));

    $response = curl_exec($curl);

    curl_close($curl);

   

    $saleResponse = json_decode($response, true);

   //print_r($saleResponse);
    
    //exit;
    $Auth_mod=$saleResponse['auth_mode'];

$tr_upd_order1['Auth_mod']=$Auth_mod;
$tr_upd_order1['salecardReq']= $salecardReq;
$tr_upd_order1['CardSaleUrl']=  $CardSaleUrl;
$tr_upd_order1['saleResponse']=$saleResponse;
trans_updatesf($_SESSION['tr_newid'], $tr_upd_order1);

//if we use 3D card the response will be like this and execute next API

if($Auth_mod){

 $action =$saleResponse['auth_payload']['action']; 

 $method = $saleResponse['auth_payload']['method'];

 $mD = $saleResponse['auth_payload']['params']['MD'];

 $PaReq = $saleResponse['auth_payload']['params']['PaReq'];

 $TermUrl = $saleResponse['auth_payload']['params']['TermUrl'];
 
 
 $postFields = 'MD=' . urlencode($mD) . 
              '&PaReq=' . urlencode($PaReq) . 
              '&TermUrl=' . urlencode($TermUrl);
              
              
              
              $curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => $action,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => $postFields,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded'
  ),
));

$response = curl_exec($curl);

curl_close($curl);

//echo $response; 
//exit;
$Response3ds = json_decode($response,1);


 if(isset($Response3ds)&&@$Response3ds)
    {
        $htmlScript=@$Response3ds ;
        unset($Response3ds );

        $tr_upd_order['htmlScript']=$auth_3ds2_secure=base64_encode(@$htmlScript);
                    
        $auth_3ds2_base64=1;

    }
}
}




   
?>