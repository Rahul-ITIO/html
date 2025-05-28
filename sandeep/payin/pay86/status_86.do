<?
// Dev Tech : 23-12-26  87 status binopay

$data['NO_SALT']=true;
$is_curl_on = true;

if((isset($_REQUEST['transaction_number']))&&(!empty($_REQUEST['transaction_number']))){
	$_REQUEST['acquirer_ref'] = $_REQUEST['transaction_number'];
	//$is_curl_on = false; $_REQUEST['actionurl']='notify';
}

if((isset($_REQUEST['acquirer_ref']))&&(!empty($_REQUEST['acquirer_ref']))){
	$_REQUEST['acquirer_ref'] = $_REQUEST['acquirer_ref'];
}

//webhook : 
if((isset($_REQUEST['pg_payload']))&&(!empty($_REQUEST['pg_payload']))){
	$pg_payload_req = $_REQUEST['pg_payload'];
	$res_de=base64_decode($pg_payload_req);
	$res=json_decode($res_de,1);
	//echo "<br/><br/>responseParamList=>"; print_r($res);
	
	if(isset($res['resource'])&&is_array($res['resource']))
		@$responseParamList=@$res['resource'];
	
	if(isset($responseParamList['invoice_number'])&&trim($responseParamList['invoice_number'])){
		$is_curl_on = false;
		$_REQUEST['transID']=$responseParamList['invoice_number'];
	}
	
	//echo "<br/>transID=>".$_REQUEST['transID']; echo "<br/><br/>responseParamList=>"; print_r($responseParamList);
}

//exit;


// access status via callback - end

if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	//include($data['Path'].'/payin/res_insert'.$data['iex']);
	include($data['Path'].'/payin/status_top'.$data['iex']);//include status_top if the page execute directly
}

//include($data['Path'].'status_in_email'.$data['iex']);

//print_r($td);
//print_r($json_value);


//check if test mode than assing uat status url 
if(@$acquirer_prod_mode==2) $acquirer_status_url=@$acquirer_uat_url;

if(empty($acquirer_status_url)) $acquirer_status_url="https://api.openacquiring.com/v1/merchants";

$acquirer_status_url	= @$acquirer_status_url."/".@$apc_get['merchant_id']."/payment/".@$acquirer_ref;  	

if(empty($acquirer_ref)) echo "<br/><b>Acquirer Ref not found</b><br/>".$acquirer_ref;

if($qp)
{

	echo "<br/>acquirer_status_url=>".$acquirer_status_url;
	echo "<br/>acquirer_ref=>".$acquirer_ref;
}

if(!empty($acquirer_ref))
{
	$post_data = array();
	$post_data['acquirer_ref'] = $acquirer_ref;
	
	if($is_curl_on)
	{
		$curl = curl_init();
		curl_setopt_array($curl, array(
		  CURLOPT_URL => $acquirer_status_url, 
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_ENCODING => '',
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 0,
		  CURLOPT_FOLLOWLOCATION => true,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => 'GET',
		  CURLOPT_HTTPHEADER => array(
			'Authorization: Basic '.$apc_get['authorization']
		  ),
		));

		$response = curl_exec($curl);	
		$http_status	= curl_getinfo($curl, CURLINFO_HTTP_CODE);
		$curl_errno		= curl_errno($curl);
		curl_close($curl);
	
		if($qp)
		{
			echo "<br/>acquirer_status_url=>".@$acquirer_status_url;
			echo "<br/>response=>".@$response;
		}
		if($http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404) {	//transaction stay as PENDING if received any one of the above error
			$err_msg = "HTTP Status == {$http_status}.";
			
			if($curl_errno) echo "<br/>Curl Errno returned $curl_errno.<br/>";
			
			$_SESSION['acquirer_response']		=$err_msg." - Pending";
			$_SESSION['acquirer_status_code']=1;
			$status_completed=false;
			
			//exit;
		}
		elseif($curl_errno){
			echo '<br/>Request Error: '.$curl_errno.' - ' . curl_error($handle);
			exit;
		}
	
		$responseParamList = jsondecode($response,1,1);	// covert response from json to array
	}
	$results = @$responseParamList;
	//$_SESSION['results_100']=$results;
	
	/*
	echo "<pre><code>";
	print_r($results);
	echo "</code></pre>";
	exit;
	*/
	
	if($qp)
	{
		echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
		//echo "res=>"; print_r($res);
		
		echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
		echo "<br/>acquirer status ['result']['code']=> ".@$responseParamList['result']['code'];
		echo "<br/>acquirer message ['result']['message']=> ".@$responseParamList['result']['message'];
		
		//echo "<br/>response_json=> ".@$response_json;
		echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
		
		//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
		echo '<br/><br/></div>';
	}
		
	
	/*
	
Possible statuses:
0000	Approved
0001	Approved with Risk
0002	Deferred capture
1001	Refer to card issuer
1002	Refer to card issuer, special condition
1003	Invalid merchant
1004	Pick up card (no fraud)
1005	Do not honor
1006	Error
1010	Partial Approval
1012	Invalid Transaction
1013	Invalid Value/Amount
1014	Invalid Card Number
1019	Re-enter Transaction or Transaction has been expired
1021	No Action Taken
1025	Unable to Locate Record on File
1028	File Update File Locked Out
1030	Format Error
1039	No CREDIT Account
1051	Insufficient Funds
1052	No Cheque Account
1053	No Savings Account
1054	Expired Card
1055	Incorrect PIN
1057	Transaction not permitted to cardholder
1058	Transaction not Permitted to Terminal
1059	Suspected Fraud
1061	Exceeds Withdrawal Value/Amount Limits
1062	Restricted Card
1063	Security Violation
1064	Original Value Incorrect
1065	Exceeds Withdrawal Frequency Limit
1075	Allowable PIN Tries Exceeded
1082	No security model
1084	No PBF
1091	Issuer or Switch is Inoperative
1092	Financial Institution not Found
1093	Transaction Cannot be Completed
1094	Duplicate Transmission/Invoice
1096	System Malfunction
1100	Response Received Too Late / Timeout
1101	Unable to authorise
1102	Ineligible for resubmission
1103	Transaction amount exceeds preauthorized approval amount
1104	Card Authentication failed
1105	Stop Payment Order
1106	Issuer initiated a stop payment ( revocation order) for this Authorization
1107	Issuer initiated a stop payment ( revocation order) for all transactions
1108	Pin Required
1109	Over Daily Limit
1110	Limit exceeded. Enter a lesser value.
1111	PTLF Full
1112	Invalid Transaction Date
1113	Card not supported
1114	CAF Status=0 or 9
1115	Requested Function not Supported
1116	PBF Update Error
1117	ATM Malfunction / Invalid authorisation type
1118	Bad Track Data
1119	Unable to Dispense/process
1120	Administration Error
1150	Unsupported currency
1151	Declined - Updated Cardholder Available
1152	Invalid Property
1153	Authorisation Already Reversed (voided) or Capture is larger than initial Authorised Value
1154	No Account
1155	No Card Record
1156	MAC Error
1157	No Universal Value/Amount
1158	File Update Field Edit Error
1159	File update not successful
1160	Bank not Supported by Switch
1161	Invalid Response
1162	Cut-Off in progress
1163	Request in Progress
1170	Customer Cancellation
1171	Customer Dispute
1172	Suspected Malfunction
1173	Unacceptable Transaction Fee
1174	Duplicate File Update Record
1175	Completed Partially
1176	Allowable PIN Tries Exceeded
1177	No Investment Account
1178	Bank Decline
1179	Card Acceptor Contact Acquirer
1180	Card Acceptor Call Acquirer Security
1181	Reconcile Error
1182	Other / Unidentified responses
1183	Invalid Expiry Date Format
1184	No Account / No Customer (Token incorrect or invalid)
1185	Invalid Merchant/WalletID
1186	Card type/Payment method not supported
1187	Gateway Reject - Invalid Transaction
1188	Gateway Reject - Violation
1189	Billing address is missing
1190	Authorisation completed
1191	Transaction already reversed
1192	Merchant not MasterCard SecureCode enabled.
1193	Invalid Channel or Token is incorrect
1194	Missing/Invalid Lifetime
1195	Invalid Encoding
1196	Invalid API Version
1197	Transaction Pending
1198	Invalid Batch data and/or batch data is missing
1199	Invalid Customer/User
1200	Transaction Limit for Merchant/Terminal exceeded
1201	Card not 3D enabled.
1202	Cardholder failed 3D authentication
1203	Initial 3D transaction not completed within 15 minutes
1204	3D-Secure system malfunction
2000	No Such Issuer
2001	Hard Capture - Pick Up Card at ATM
2002	Pick Up Card (No Fraud)
2003	Pick Up Card, Special Conditions
2004	Expired Card - Pick Up
2005	Suspected Fraud - Pick Up
2006	Contact Acquirer - Pick Up
2007	Restricted Card - Pick Up
2008	Call Acquirer Security - Pick Up
2009	Allowable PIN Tries Exceeded - pick up
2010	Lost Card - Pick Up
2011	Stolen Card - Pick Up
3000	Transaction blocked due to Risk
3001	Country not supported
3002	Gateway Reject - Blacklist
3003	Gateway Reject - CVV is missing or incorrect
3004	Gateway Reject - Post code failed
3005	Gateway Reject - Missing required data
3006	Missing 3DSecure data or data is not correct
3007	AVS not matched
3008	Mismatch - Shipping Country to Billing Country
3009	Mismatch - Shipping Country to BIN Country
3010	Mismatch - Shipping Country to IP Country
3011	Mismatch - Shipping Country to Phone (Country)
3012	Mismatch - Billing Country to BIN Country
3013	Mismatch - Billing Country to IP Country
3014	Mismatch - Billing Country to Phone (Country)
3015	Mismatch - BIN Country to IP Country
3016	Mismatch - BIN Country to Phone (Country)
3017	Threshold Risk
3018	Threshold Risk
3019	Threshold Risk
3020	Threshold Risk
3021	Threshold Risk
3022	Threshold Risk
3023	Threshold Risk
3024	Threshold Risk
3025	Threshold Risk
3026	Card velocity - Daily - Approved only
3027	Card velocity - Daily - All transactions
3028	Card velocity - Weekly - Approved only
3029	Card velocity - Weekly - All transactions
3030	Card velocity - Monthly - Approved only
3031	Card velocity - Monthly - All transactions
3032	Email velocity - Daily - Approved only
3033	Email velocity - Daily - All transactions
3034	Email velocity - Weekly - Approved only
3035	Email velocity - Weekly - All transactions
3036	Email velocity - Monthly - Approved only
3037	Email velocity - Monthly - All transactions
3038	IP velocity - Daily - Approved only
3039	IP velocity - Daily - All transactions
3040	Verified Info - Email
3041	Verified Info - Address
3042	Verified Info - Proxy
3043	Verified Info - IP Country is HighRiskCountry
3044	Verified Info - Shipping Country is HighRiskCountry
3045	Verified Info - Billing Country is HighRiskCountry
3046	Verified Info - BIN Country is HighRiskCountry
3047	Gateway Reject - Card Number Blacklist
3048	Gateway Reject - IP Address Blacklist
3049	Gateway Reject - Email Blacklist
3050	Gateway Reject - Phone Number Blacklist
3051	Gateway Reject - Bin number Blacklist
3052	Bin velocity - Daily - Approved only
3053	Bin velocity - Daily - All transactions
3054	Bin velocity - Weekly - Approved only
3055	Bin velocity - Weekly - All transactions
3056	Bin velocity - Monthly - Approved only
3057	Bin velocity - Monthly - All transactions
3058	Billing Address Line 1 velocity - Daily - Approved only
3059	Billing Address Line 1 velocity - Daily - All transactions
3060	Billing Address Line 1 velocity - Weekly - Approved only
3061	Billing Address Line 1 velocity - Weekly - All transactions
3062	Billing Address Line 1 velocity - Monthly - Approved only
3063	Billing Address Line 1 velocity - Monthly - All transactions
3064	Shipping Address Line 1 velocity - Daily - Approved only
3065	Shipping Address Line 1 velocity - Daily - All transactions
3066	Shipping Address Line 1 velocity - Weekly - Approved only
3067	Shipping Address Line 1 velocity - Weekly - All transactions
3068	Shipping Address Line 1 velocity - Monthly - Approved only
3069	Shipping Address Line 1 velocity - Monthly - All transactions
3070	Cardholder Name velocity - Daily - Approved only
3071	Cardholder Name velocity - Daily - All transactions
3072	Cardholder Name velocity - Weekly - Approved only
3073	Cardholder Name velocity - Weekly - All transactions
3074	Cardholder Name velocity - Monthly - Approved only
3075	Cardholder Name velocity - Monthly - All transactions
3076	UDF1 velocity - Daily - Approved only
3077	UDF1 velocity - Daily - All transactions
3078	UDF1 velocity - Weekly - Approved only
3079	UDF1 velocity - Weekly - All transactions
3080	UDF1 velocity - Monthly - Approved only
3081	UDF1 velocity - Monthly - All transactions
5000	Validation error
5001	Unmapped validation error
5002	Processor network is unavailable
5003	Parameters are empty
5004	Invalid parameter
5010	Invalid payload. Please verify the JSON structure.
5051	Invalid request
5052	Unsupported Grant type by API
5053	Invalid credentials
5070	Invalid authorization scheme
5080	The client access token is invalid
5081	The client access token provided has already expired
5082	The merchant account does not exist or client credentials has been revoked.
5100	Field 'number' is missing in 'credit_card'
5101	Credit card number is invalid
5102	Field 'expire_year' is missing in 'credit_card'
5103	Credit card expiry year is invalid
5104	Field 'expire_month' is missing in 'credit_card'
5105	Credit card expiry month is invalid
5106	Credit card is expired. Use an unexpired credit card.
5107	Invalid credit card cvv2
5108	Invalid length for credit card cvv2
5109	The credit card nonce provided is expired.
5110	The credit card nonce provided is invalid.
5111	The credit card nonce provided has already been used.
5112	Credit card is disabled.
5119	The funding instrument is either invalid or missing.
5120	'country_code' is invalid. Use valid two-character IS0-3166-1 country codes.
5121	Phone number length is invalid
5122	Phone number is invalid
5123	Phone number is required
5124	Phone country code length is invalid
5125	Phone country code is invalid
5126	Payer IP address provided is invalid
5130	The amount is required
5131	The amount is invalid
5132	The currency is required
5133	The currency is invalid
5140	The payer email address is either invalid or empty.
5141	The the payment type is either invalid or empty.
5142	The recipient name is missing.
5145	The statement descriptor text is required.
5146	The statement descriptor text length is invalid
5147	The statement descriptor text is required.
5148	The statement descriptor city length is invalid
5150	The shipping method is invalid is invalid
5151	The invoice number is either invalid or empty.
5152	The invoice number is required.
5160	The intent of the request is required.
5161	The intent of the request is invalid.
5162	Direct call to payment endpoint using full details are not allowed.
5163	Payer was not found
5165	Invalid transaction type
5166	Invalid payment method or currency
5167	Currency not supported
5168	Payment details is invalid
5169	Invalid transaction mode
5170	Processor is not able to process 3DS transactions
5171	Invalid payment method or currency
5173	Previous transaction id is required.
5174	Authorization ID is invalid.
5175	Transaction corresponding to the Authorization ID not found.
5176	Transaction already captured
5177	Transaction Expired.
5178	Transaction has been voided
5179	Amount sent for capture is greater that authorization amount
5180	Amout sent for capture is greater that authorization amount
5181	Transaction has been refunded
5182	Amount is greater than the amount captured
5183	Amount is greater that authorization amount
5184	The business url ID of the request is required.
5185	Invalid Business url
9999	Internal service error
1007	Redirect


	
	*/

	if (isset($responseParamList) && count($responseParamList)>0)
	{
		/*
		//rrn //acquirer_ref
		#######	rrn, acquirer_ref update from status get :start 	###############
			
			//acquirer_ref
			$acquirer_ref_1='';
			if(isset($responseParamList['result']['transaction_number'])) $acquirer_ref_1 = @$responseParamList['result']['transaction_number'];
			//up acquirer_ref : update if empty acquirer_ref_1 and is ['result']['transaction_number']  
			if(empty(trim($td['acquirer_ref']))&&!empty($acquirer_ref_1)){
				$tr_upd_status['acquirer_ref']=trim($acquirer_ref_1);
			}
			
			
			if($qp){
				echo "<br/><br/><=acquirer_ref=>".@$acquirer_ref_1;
				echo "<br/><br/><=tr_upd_status1=>";
					print_r(@$tr_upd_status);
			}
			
			if(isset($tr_upd_status)&&count($tr_upd_status)>0&&is_array($tr_upd_status))
			{
				if($qp){
					echo "<br/><br/><=tr_upd_status=>";
					print_r($tr_upd_status);
				}
				
				trans_updatesf($td['id'], $tr_upd_status);
			}
			
		#######	rrn, acquirer_ref update from status get :end 	###############
		*/
		
		$message= @$responseParamList['result']['message'];
		
		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=@$message;
		$_SESSION['curl_values']=@$responseParamList;
		
		if(isset($responseParamList['reference_id'])&&@$responseParamList['reference_id']) $_SESSION['acquirer_transaction_id']=@$responseParamList['reference_id'];
		
		if(isset($responseParamList['transaction']['amount']['total'])&&$responseParamList['transaction']['amount']['total']) $_SESSION['responseAmount']=$responseParamList['transaction']['amount']['total'];

		$result_code = (int)@$responseParamList['result']['code'];
		
		if($result_code=='0000'){ //success
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." - Success";
			$_SESSION['acquirer_status_code']=2;
			if(isset($json_value['billing_descriptor'])&&trim($json_value['billing_descriptor'])) $_SESSION['acquirer_descriptor']=@$json_value['billing_descriptor'];
		}
		elseif(in_array($result_code,["0002","1001","1002","1003","1004","1005"])){	//failed
			$_SESSION['acquirer_response']=$_SESSION['acquirer_response']." Payment failed - Cancelled";
			$_SESSION['acquirer_status_code']=-1;
		}
		else{
			$_SESSION['acquirer_response']=$message." - Pending";
			$_SESSION['acquirer_status_code']=1;
		}
	}
}

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>