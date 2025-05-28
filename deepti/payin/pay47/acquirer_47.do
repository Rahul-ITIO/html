<?
//print_r($apc_get);

$total_payment1 = $total_payment - 2; // Rs 2 minus from Total Amount because Rs. 1.00 and Rs. 1.00 use to next invoice 

$total_payment2 = '1.00'; // Rs. 1.00 and Rs. 1.00 use to next invoice 

$invoice['items'] = [
    [
        'name' =>  $_SESSION['dba'],
        'price' => $total_payment1,
        'description'    =>   $_SESSION['product'],
        'qty' => 1
    ],
    [
        'name' =>  $_SESSION['dba'],
        'price' => $total_payment2,
        'description'    =>  $_SESSION['product'],
        'qty' => 1
    ],
    [
        'name' =>  $_SESSION['dba'],
        'price' => $total_payment2,
        'description'    =>  $_SESSION['product'],
        'qty' => 1
    ]
];

//print_r($invoice);
foreach ($invoice['items'] as $item) {
    $invoice['total'] += $item['price'];
}

$invoice['invoice_id'] = $transID; // should be the same invoice id as the one in your store database
$invoice['invoice_description'] = "Order with Invoice ".  $invoice['invoice_id'] ;
$invoice['total'] = $invoice['total'];
$invoice['return_url'] = $status_url_1;
$invoice['cancel_url'] = $status_url_1;
$invoice = json_encode($invoice);
                                
//The payment request for this merchant should look like the example below:

$post = array(
    'merchant_key'=>$apc_get['merchant_key'], 
    'invoice'=> $invoice,
    'currency_code' =>  $orderCurrency
    );

    

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $bank_url );
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $post);

$response = json_decode(curl_exec($ch),true);
curl_close($ch);
//print_r($response);       
$getUrl=$response['link'];
$tr_upd_order['invoicePost']  = $invoice;
$tr_upd_order['Response']  = $response;

$curl_values_arr['responseInfo'] =$tr_upd_order['Response'];
//$_SESSION['acquirer_action']=1;
$_SESSION['curl_values']=$curl_values_arr;
$curl_values_arr['browserOsInfo']=$browserOs;
if(isset($getUrl)&&!empty($getUrl)){
		$tr_upd_order['pay_mode']='3D';
        $auth_3ds2_secure=$getUrl;
        $auth_3ds2_action='redirect';	
}

trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);
?>
