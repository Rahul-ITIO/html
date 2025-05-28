<?php
include("MerchantWebService.php");

$soapClient = new SoapClient('http://api.volet.com/');

$params = array(
    'arg0' => array(
        'apiName' => 'digi51_API_A',
        'authenticationToken' => 'token',
        'accountEmail' => 'onternity@gmail.com'
    ),
    'arg1' => '5d2dc530-06e3-4a68-8a89-67941ff5f26d"'
);
$response = $soapClient->findTransaction($params);

echo "<br/>response=>";
print_r($response);

?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsm="http://api.volet.com/">
    <soapenv:Header />
    <soapenv:Body>
        <wsm:findTransaction>
            <arg0>
                <apiName>api_name</apiName>
                <authenticationToken>token</authenticationToken>
                <accountEmail>name@example.com</accountEmail>
            </arg0>
            <arg1>e5383553-f66c-4073-b81d-86e7c3756cdb</arg1>
        </wsm:findTransaction>
    </soapenv:Body>
</soapenv:Envelope>