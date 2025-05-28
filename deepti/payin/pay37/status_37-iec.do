
<?
$is_curl_on = true;
if(!isset($data['STATUS_ROOT'])){
	//include('../../config_db.do');
	include('../../config.do');
	########## callback section #############

	//callback section - fetch callback body
	$str=file_get_contents("php://input");

	//if(!str) $str=$_POST;	//if not received then fetch via $_POST;

	if($str)	//if received string then json decode
	{}

	########## callback section #############
	
	include('../status_top'.$data['iex']);
}

//access td data which retrive in status_top.do page via orderset
$mrid			= $td['mrid'];				//merchant order id
$status			= $td['status'];			//transaction status
$transaction_id	= $td['transaction_id'];	//transaction id
$txn_id 		= $td['txn_id'];			//bank reference number

$qp = 0;
//print_r($td);
//print_r($json_value);

if(isset($_SESSION['post']['qp'])&&$_SESSION['post']['qp']) $qp = 1;

$siteid_get['IBL-Client-Id']	= "";
$siteid_get['IBL-Client-Secret']= "";
$siteid_get['CustomerTenderId']	= "";
$siteid_get['channelId']		= "";
$siteid_get['Account-name']		= "";
$siteid_get['Account-ifsc']		= "";
$siteid_get['Account-number']	= "";
$siteid_get['mode']				= "";
$siteid_get['pgMerchantId']		= "";
$siteid_get['default_mid']		= "";

if(isset($json_value['IBL-Client-Id'])) $siteid_get['IBL-Client-Id'] =$json_value['IBL-Client-Id']; 
if(isset($json_value['IBL-Client-Secret'])) $siteid_get['IBL-Client-Secret']=$json_value['IBL-Client-Secret'];
if(isset($json_value['CustomerTenderId'])) $siteid_get['CustomerTenderId']=$json_value['CustomerTenderId'];
if(isset($json_value['channelId'])) 		$siteid_get['channelId']		=$json_value['channelId'];
if(isset($json_value['Account-name'])) 		$siteid_get['Account-name']		=$json_value['Account-name'];
if(isset($json_value['Account-ifsc'])) 		$siteid_get['Account-ifsc']		=$json_value['Account-ifsc'];
if(isset($json_value['Account-number'])) 	$siteid_get['Account-number']	=$json_value['Account-number'];
if(isset($json_value['mode'])) 				$siteid_get['mode']				=$json_value['mode'];
if(isset($json_value['pgMerchantId'])) 		$siteid_get['pgMerchantId']		=$json_value['pgMerchantId'];
if(isset($json_value['default_mid'])) 		$siteid_get['default_mid']		=$json_value['default_mid'];

//print_r($siteid_get);
if($qp){
	echo "<br/>txn_id=>".$transaction_id."<br />";
}

$bank_status_url=$bank_acquirer_json_arr['bank_status_url'];

if($data['localhosts']==true){	//set webhook as a callback url if execute from localhost
	$bank_status_url="https://indusapiuat.indusind.com/indusapi-np/uat/eph-upi/transactionenquiry/v2";
}


$current_transaction = "";
if(isset($_REQUEST['action'])&&$_REQUEST['action']=='fetch')
{
	require_once 'post.do';	//to fetch all transactions

	/*$response_json='{"response": {"header": {"requestUUID": 1677136627,"channelId": "INT"},"body": {"fetchIECDataRes": {"responseCode": "R000","responseDescription": "Success","responseIECData": {"transaction": [{"request_ID": "21808","challanCode": "LASI1","challan_no": "7181122327","clientAccountNo": "200999186871","clientName": "258600443270","amount": "1.00","remitterName": "MGLUM","remitterAccountNo": "020901510585","remitterIFSC": "INDB0000015","remitterBank": "SBI","remitterBranch": "Kottayam","remitterUTR": "UTR000000021808","payMethod": "NEFT","creditAccountNo": "121212","inwardRefNum": "test","creditTime": "31-01-2023 16:01:18","reserve1": "","reserve2": "","reserve3": "","reserve4": ""}, {"request_ID": "21810","challanCode": "LASI1","challan_no": "7181112505","clientAccountNo": "200999186871","clientName": "258600443270","amount": "1.00","remitterName": "MGLUM","remitterAccountNo": "020901510585","remitterIFSC": "INDB0000015","remitterBank": "SBI","remitterBranch": "Kottayam","remitterUTR": "UTR000000021810","payMethod": "NEFT","creditAccountNo": "121212","inwardRefNum": "test1","creditTime": "15-02-2023 10:16:47","reserve1": "","reserve2": "","reserve3": "","reserve4": ""}, {"request_ID": "21811","challanCode": "LASI1","challan_no": "21811","clientAccountNo": "200999186871","clientName": "258600443270","amount": "1.00","remitterName": "MGLUM","remitterAccountNo": "020901510585","remitterIFSC": "INDB0000012","remitterBank": "HDFC","remitterBranch": "Kottayam","remitterUTR": "test2","payMethod": "IMPS","creditAccountNo": "121111","inwardRefNum": "test2","creditTime": "15-02-2023 10:17:39","reserve1": "","reserve2": "","reserve3": "","reserve4": ""}, {"request_ID": "21812","challanCode": "LASI1","challan_no": "21812","clientAccountNo": "200999186871","clientName": "258600443270","amount": "1.00","remitterName": "MGLUM","remitterAccountNo": "020901510585","remitterIFSC": "INDB0000019","remitterBank": "sbi","remitterBranch": "Kottayam","remitterUTR": "UTR000000021812","payMethod": "RTGS","creditAccountNo": "1212","inwardRefNum": "test5","creditTime": "15-02-2023 10:18:42","reserve1": "","reserve2": "","reserve3": "","reserve4": ""}, {"request_ID": "21813","challanCode": "LASI1","challan_no": "7181134055","clientAccountNo": "200999186871","clientName": "258600443270","amount": "1.00","remitterName": "MGLUM","remitterAccountNo": "020901510585","remitterIFSC": "INDB0000015","remitterBank": "INDUSIND BANK","remitterBranch": "Kottayam","remitterUTR": "UTR000000021813","payMethod": "IEFT","creditAccountNo": "12","inwardRefNum": "test7","creditTime": "15-02-2023 10:19:33","reserve1": "","reserve2": "","reserve3": "","reserve4": ""}]}}}}}';

	$response_json = str_replace("21811",$transaction_id, $response_json);*/
	if($response_json)
	{
		$fetch_trans = json_decode($response_json,1);
		
		if(isset($fetch_trans['response']['body']['fetchIECDataRes']['responseCode'])&&$fetch_trans['response']['body']['fetchIECDataRes']['responseCode']=='R000')
		{
			$responseIECData = $fetch_trans['response']['body']['fetchIECDataRes']['responseIECData'];
	
			$tr_range='';
			if(is_array($responseIECData)){
				if(isset($responseIECData['transaction']))
				{
					foreach ($responseIECData['transaction'] as $key => $val) {
						//echo $val['challan_no'].' and '.$val['creditAccountNo'].'<br />';
						
						$transId='';

						if(isset($val['challan_no'])&&$val['challan_no'])
							$transId=$val['challan_no'];
						elseif(isset($val['creditAccountNo'])&&$val['creditAccountNo'])
							$transId=str_replace('ZAMPLE','',$val['creditAccountNo']);

						if($transId)
						{
							//echo "$transId<br />";
							$trQ=select_tablef(" `transaction_id` = '$transId'",'transactions',0,1,'`id`');
							
							$trId = $trQ['id'];
							if($trId)
							{
								if(!empty($tr_range)) $tr_range.=',';
								$tr_range.=$trId;

								$tr_upd_order['response']=$val;
								if(isset($val['remitterUTR'])&&$val['remitterUTR']) $tr_upd_order['txn_id']=$val['remitterUTR'];
								transactions_updates($trId, $tr_upd_order);

							}
							if($transaction_id==$transId)
							{
								$current_transaction=$val;
								$current_transaction['responseCode']=$fetch_trans['response']['body']['fetchIECDataRes']['responseCode'];
								$current_transaction['responseDescription']=$fetch_trans['response']['body']['fetchIECDataRes']['responseDescription'];
							}
						}
					}
					//echo $tr_range;
					update_transaction_ranges(-1, 1, $tr_range);
				}
			}
		}
	}
}


if(!empty($transaction_id))
{

	if($current_transaction){
		$responseParamList= $current_transaction;
		if (isset($responseParamList) && count($responseParamList)>0)
		{
			$message= "";
			$status	= "";
	
			if(isset($responseParamList['responseCode']))
				$status = $responseParamList['responseCode'];

			if(isset($responseParamList['responseDescription']))
				$message= $responseParamList['responseDescription'];
	
			$_SESSION['hkip_action']="hkip";
			$_SESSION['hkip_info']=$message;
			$_SESSION['curl_values']=$responseParamList;
	
			if($status=='R000'){ //success
				$_SESSION['hkip_info']=$message." - Success";
				$_SESSION['hkip_status']=2;
				$_SESSION['hkip_order_status']=2;
			}
			else{ //pending
	
				$_SESSION['hkip_info']=$message." - Pending";
				$status_completed=false;
				$_SESSION['hkip_order_status']=1;
				if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
					$_SESSION['hkip_status']=$_REQUEST['actionurl']." Pending or Error";
				}
	
				$data_tdate=date('YmdHis', strtotime($td['tdate']));
				$current_date_1h=date('YmdHis', strtotime("-1 hours"));
	
				if(($data_tdate<$current_date_1h)&&($data['localhosts']==false)){
					$_SESSION['hkip_order_status']=-1;
					$_SESSION['hkip_info']=$message." - Cancelled"; 
				}
			}
		}
	}
	else
	{
		//echo 'check status';
		include_once "status.do";
		$responseParamList=json_decode($response_json,1);
		
		if(isset($responseParamList[0])) $responseParamList=$responseParamList[0];
		//print_r($responseParamList);exit;
		if (isset($responseParamList) && count($responseParamList)>0)
		{

			$_SESSION['hkip_action']="hkip";
			$_SESSION['hkip_info']	=@$responseParamList['statusDesc'];
			$_SESSION['curl_values']=$responseParamList;

			if(isset($responseParamList['status'])&&strtoupper($responseParamList['status'])=='SUCCESS')	//for success
			{		
				$_SESSION['hkip_status']=2;
				$_SESSION['hkip_order_status']=2;	
				$_SESSION['hkip_info'].=" - Success";
			}
			elseif(isset($responseParamList['status'])&&strtoupper($responseParamList['status'])=='FAILURE')	//failed
			{
				$_SESSION['hkip_status']=-1;
				$_SESSION['hkip_order_status']=-1;
				$_SESSION['hkip_info'].=" - Cancelled";
			}
			else
			{
				$_SESSION['hkip_status']=1;
				$_SESSION['hkip_order_status']=1;
				$_SESSION['hkip_info'].=" - Pending";
				$status_completed=false;
				
			}
		}
	}
	$results = $responseParamList;
}

if(!isset($data['STATUS_ROOT'])){
	include('../status_bottom'.$data['iex']);
}

?>