<?php

if(!isset($_SESSION)) 
{
	session_start(); 
}

if(!isset($_SESSION['response_114'])) 
{
  $curl = curl_init();

  curl_setopt_array($curl, array(
    CURLOPT_URL => 'https://www.payit123.com/clients/epay/process_payment.php',
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => '',
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 0,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_POSTFIELDS => array('fullName' => 'PANTELAKIS PANTELI','street1' => 'AbbeySide view Street','invoiceNumber' => 'LIV11','country' => 'CY','state' => 'Nicosia','city' => 'Limasol','email' => 'testuser@gmail.com','phone' => '9659012284','amount' => '1','currency' => 'USD','token' => '5e12cef38728dc61c68bfdf0cf1ed11d','postal_code' => '626189','return_url' => 'https://www.payit123.com/clients/paymentsolo/','status_url' => 'https://www.payit123.com/clients/paymentsolo/status.php'),
    CURLOPT_HTTPHEADER => array(
      'Authorization: Bearer 8e1fbd6f20ff0cfce4f40671a3bb2396'
    ),
  ));

  $response = curl_exec($curl);

  curl_close($curl);
  $_SESSION['response_114']=$response;
}


$response=trim($_SESSION['response_114']);


if(strpos($response,"script")!==false){
  $response_script=strip_tags(trim($_SESSION['response_114']));
  $response_script=str_replace('location.href="','',$response_script);
  $response_script=explode('";parent',$response_script)[0];

  echo "<hr/>response_script=><br/>";
  print_r($response_script);

}

$response_114=strip_tags(trim($_SESSION['response_114']));
echo "<hr/>var_dump response_114=><br/>";
var_dump($response_114);


/*

<script>
    location.href="https://www.payit123.com/clients/epay/3ds_validation.php?hash=Nm5PQ2xuYjBuSGxvMDluMU1tRnAyMWxzRUpBUmFZeCs4QU9RTElrMU5KT3E1ZjJJRVVUNUl5bkRkd0hTb2JGaDd2UzgwbitwOSt5OWdrWW1zd2hLOWdjS2xBNzNzZTlGQlRlU0hZcVdWWFk9";
</script>
<script>
    parent.location.href="https://www.payit123.com/clients/paymentsolo/"
</script>
*/



?>
