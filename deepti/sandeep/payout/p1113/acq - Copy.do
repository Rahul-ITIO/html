<?
$encode_processing_creds = json_decode($bank_master['encode_processing_creds'],true);

if($bank_master['payout_prod_mode']==1) {
	$siteid_set	= $encode_processing_creds['live'];
	$bank_url	= $bank_master['bank_payment_url'];
}
else {
	$siteid_set	= $encode_processing_creds['test'];
	$bank_url	= $bank_master['payout_uat_url'];
}

$bg_active	= $bank_master['bg_active'];


$global_data['merchantId']	=$siteid_set['merchantId'];
$global_data['secretKey']	=$siteid_set['secretKey'];
$global_data['currency']	=$bank_master['payout_processing_currency'];
$global_data['bank_url']	=$bank_url;

function send_payout_request($post)
{
	global $global_data;
	
	$Datetime	= date('Y-m-d h:i:sA');//"2012-05-09 04:09:41AM";

	$req_post = array();
	$req_post['ClientIP']		= $post['client_ip'];

	$req_post['ReturnURI']		= "https://api.gatewayurl.com/api/pay70/status.php";
	$req_post['MerchantCode']	= $global_data['merchantId'];
	$req_post['secretKey']		= $global_data['secretKey'];
	$req_post['CurrencyCode']	= $global_data['currency'];
	
	
	$req_post['TransactionID']		= $post['transaction_id'];
	$req_post['MemberCode']			= $post['beneficiary_id'];
	$req_post['Amount']				= $post['price'];
	$req_post['BankCode']			= $post['ifsc'];//"BBL"
	$req_post['toBankAccountName']	= $post['beneficiary_name'];//"test";
	$req_post['toBankAccountNumber']= $post['baccount'];//"123456";

	$req_post['TransactionDateTime']= $Datetime;

	//$req_post['toProvince']	='test';
	//$req_post['toCity']		='test';

	$dt	= date('YmdHis', strtotime($Datetime));

	$hashkey= md5($req_post['MerchantCode'].$req_post['TransactionID'].$req_post['MemberCode'].$req_post['Amount'].$req_post['CurrencyCode'].$dt.$req_post['toBankAccountNumber'].$req_post['secretKey']);
	
	$url = $global_data['bank_url']."/".$req_post['MerchantCode'];
	?>
	<form method="post" name="f1" id="f1" action="<?=$url?>">
		<?
		foreach($req_post as $key => $val)
		{
			?>
			<input type="hidden" name="<?=$key;?>" value="<?=$val;?>" /><br />
			<?
		}
		?>
		<input type="hidden" name="Key" value="<?=$hashkey;?>" /><br />
		<!--<input type="submit" value="Submit"> -->
	</form>
	<script type="text/javascript">
		document.f1.submit();
	</script>
	<?
	
	//exit;
}
?>