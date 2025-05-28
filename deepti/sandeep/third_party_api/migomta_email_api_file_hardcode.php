<?php


$url = "https://sn4.migomta.one/api/v1/send/message";

$curl = curl_init($url);
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

$headers = array(
   "X-Server-API-Key: T7LlDMSyRMK6q3dtz9gtHQGh",
   "Content-type: application/json",
);
curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);

$dataEmail = <<<DATA
{
    "to": ["dev@bigit.io"],
    "from": "noreply@bo.payfi.co.in",  
    "subject": "No reply11 for Email API Test by DevTech",
    "html_body": "Hello 22 DevTech this email testing for <b>api checking</b>",
    "plain_body": "Hello 22 DevTech this email testing for <b>api checking</b>"
}
DATA;

echo "<br/><br/>dataEmail1=><br/>".($dataEmail);echo "<br/><br/>";
echo "<br/><br/>dataEmail=><br/>";var_dump($dataEmail);echo "<br/><br/>";

curl_setopt($curl, CURLOPT_POSTFIELDS, $dataEmail);

//for debug only!
curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

$resp = curl_exec($curl);
curl_close($curl);
var_dump($resp);

?>