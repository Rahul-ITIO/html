<?php
// Get query parameters from the URL
$success = isset($_GET['success']) ? $_GET['success'] : null;
$status = isset($_GET['status']) ? $_GET['status'] : null;
$merchant_ref = isset($_GET['merchant_ref']) ? $_GET['merchant_ref'] : null;
$gateway_reference = isset($_GET['gateway_reference']) ? $_GET['gateway_reference'] : null;
$transaction_id = isset($_GET['transaction_id']) ? $_GET['transaction_id'] : null;
$payment_type = isset($_GET['payment_type']) ? $_GET['payment_type'] : null;
$paymentResponse = isset($_GET['paymentResponse']) ? $_GET['paymentResponse'] : null;
?>
<br />
<br />
<br />

<table width="50%" border="1" cellspacing="4" cellpadding="4" align="center">
  <tr>
    <td width="50%">Status</td>
    <td width="50%"><?=$status;?></td>
  </tr>
  <tr>
    <td>Merchant Ref</td>
    <td><?=$merchant_ref;?></td>
  </tr>
  <tr>
    <td>Gateway Reference</td>
    <td><?=$gateway_reference;?></td>
  </tr>
  <tr>
    <td>Transaction ID</td>
    <td><?=$transaction_id;?></td>
  </tr>
  <tr>
    <td>Payment Type</td>
    <td><?=$payment_type;?></td>
  </tr>
  <tr>
    <td>Payment Response</td>
    <td><?=$paymentResponse;?></td>
  </tr>
  <tr>
    <td>Success</td>
    <td><?=$success;?></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><a href="https://itio.in/transactionjunction/">make another payment</a></td>
  </tr>
</table>
