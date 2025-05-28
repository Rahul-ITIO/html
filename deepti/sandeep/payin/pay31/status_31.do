<?
if(isset($data['ROOT'])&&$data['ROOT']) $root=$data['ROOT'];
else $root='../../';

#####	TEMP* for email response as testing	#########
if((isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook'))
{	
	/*
	$data['transIDExit']=1;
	$data['status_in_email']=1;
	$data['devEmail']='dev@bigit.io,arun@bigit.io';
	*/
}

$is_curl_on = true;

if(!isset($data['STATUS_ROOT'])){
	include($root.'config_db.do');
	$str=file_get_contents("php://input");
	$res_arr = json_decode($str, true);
	$object_input=$res_arr;
	
	$res_message='';
	if(isset($res_arr[0]['message'])&&$res_arr[0]['message']) $res_message=$res_arr[0]['message'];
	else { if(isset($res_arr['message'])&&$res_arr['message']) $res_message=$res_arr['message'];}
	
	if(isset($res_message)&&$res_message){
		$is_curl_on = false;
		$_REQUEST['actionurl']='notify';
	
		$default_acquirer_id=78;
		
		$bank_g = select_tablef("`acquirer_id` IN ({$default_acquirer_id})",'acquirer_table',0,1,'`acquirer_processing_creds`, `acquirer_prod_mode`');
		if(isset($bank_g)&&$bank_g)
		{
			$acquirer_prod_mode	=$bank_g['acquirer_prod_mode'];
			$acquirer_processing_creds		=json_decode($bank_g['acquirer_processing_creds'],1);
	
			if($acquirer_prod_mode==1)	$siteid_set	= $acquirer_processing_creds['live'];
			else					$siteid_set	= $acquirer_processing_creds['test'];
			
			$encryption_key = (isset($siteid_set['Encryption_key'])?$siteid_set['Encryption_key']:'');
			
			$cipher = "AES-256-CBC";
	
			$decrypted_data = openssl_decrypt($res_message, $cipher, $encryption_key);
			//echo $decrypted_data;
			$response= substr($decrypted_data,16);
			$res = json_decode($response,true);
			
			$gateway_push_notify=$res;
			
			//$_REQUEST['transID']=substr($res['extTransactionId'],6);
			$_REQUEST['transID']=preg_replace("/[^0-9.]/", "",$res['extTransactionId']);
			$gateway_push_notify['transID']=$_REQUEST['transID'];
			
			$data['gateway_push_notify']=$gateway_push_notify;
		}				
	}

	include($data['Path'].'/payin/status_top'.$data['iex']);
}

#####	TEMP* for Response check as testing	#########
//include($data['Path'].'/payin/res_insert'.$data['iex']);

$mrid			= $td['reference'];
$status			= $td['trans_status'];
$transaction_id	= $td['transID'];
//$acquirer_ref			= $td['acquirer_ref'];



//$siteid_get['acquirer']=(isset($json_value['acquirer'])?$json_value['acquirer']:'');
$siteid_get['source']=(isset($data['apJson']['source'])?$data['apJson']['source']:'');
$siteid_get['Checksum_key']	= (isset($data['apJson']['Checksum_key'])?$data['apJson']['Checksum_key']:'');
$siteid_get['terminalId']	= (isset($data['apJson']['terminalId'])?$data['apJson']['terminalId']:'');
$siteid_get['Encryption_key']	= (isset($data['apJson']['Encryption_key'])?$data['apJson']['Encryption_key']:'');
$siteid_get['key']	= (isset($data['apJson']['key'])?$data['apJson']['key']:'');
$siteid_get['extTransactionId']	= (isset($data['apJson']['extTransactionId'])?$data['apJson']['extTransactionId']:'');

if(!empty($transaction_id))
{
	if($is_curl_on==true)
	{
	//get bank url from bank getway table
			
		if(empty($acquirer_status_url)) $acquirer_status_url='https://merchantuat.timepayonline.com/evok/cm/v2/status';
		
		
		if($qp)
		{
			echo "<br/>acquirer_status_url=>".$acquirer_status_url;
		}
		// request parameters
	
	
	$req = [
			'source' => $siteid_get['source'],
			'channel' => 'api',
			'terminalId' => $siteid_get['terminalId'],
			'extTransactionId' => $siteid_get['extTransactionId'].$transaction_id
			
		];
		
		$checksum='';
		foreach ($req as $val){
			$checksum.=$val;
		}
		$checksum_string=$checksum.$siteid_get['Checksum_key'];
		
		$req['checksum']=hash('sha256',$checksum_string);
		$key= $siteid_get['Encryption_key'];
		$key=substr((hash('sha256',$key,true)),0,16);
		$cipher='AES-128-ECB';
		$encrypted_string=openssl_encrypt(
			json_encode($req),
			$cipher,
			$key
		);
		$curl = curl_init();
		
		curl_setopt_array($curl, array(
			CURLOPT_URL => $acquirer_status_url,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 30,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_HEADER => 0,
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_SSL_VERIFYPEER => 0,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS =>$encrypted_string,
			CURLOPT_HTTPHEADER => array(
			'cid:' .$siteid_get['key'],
			'Content-Type: text/plain'
			),
			));
			$response = curl_exec($curl);
		
			
			curl_close($curl);
			$decrypted_string = openssl_decrypt(
            $response,
            $cipher,
            $key
            );
			
			$res = json_decode($decrypted_string,true);
			
	}
	if($qp)
	{
		echo "<br/>res=>";
		var_dump($res);
		//exit;
	}

	$results = $res;
	//applied condition according to the status response for fail success and pending 
	if (isset($res) && count($res)>0)
	{
		$status = $res['status'];
		
		
	#######	upa, rrn, acquirer_ref update from status get :start 	###############
		
		$upa=$res['data'][0]['upiId'];		
		//up upa : update if empty upa and is upiId 
		if(empty(trim($td['upa']))&&!empty($upa)){
			$tr_upd_status['upa']=trim($upa);
		}
		
		$acquirer_ref=$res['data'][0]['upiTxnId'];
		//up acquirer_ref : update if empty acquirer_ref and is upiTxnId 
		if(empty(trim($td['acquirer_ref']))&&!empty($acquirer_ref)){
			$tr_upd_status['acquirer_ref']=trim($acquirer_ref);
		}
		
		$rrn=$res['data'][0]['custRefNo'];
		//up rrn : update if empty rrn and is custRefNo 
		if(empty(trim($td['rrn']))&&!empty($rrn)){
			$tr_upd_status['rrn']=trim($rrn);
		}
		
		
		if($qp){
			echo "<br/><br/><=upa=>".$upa;
			echo "<br/><br/><=acquirer_ref=>".$acquirer_ref;
			echo "<br/><br/><=rrn=>".$rrn;
			echo "<br/><br/><=tr_upd_status1=>";
				print_r($tr_upd_status);
		}
		
		if(isset($tr_upd_status)){
			if($qp){
				echo "<br/><br/><=tr_upd_status=>";
				print_r($tr_upd_status);
			}
			
			trans_updatesf($td['id'], $tr_upd_status);
		}
		
	#######	upa, rrn, acquirer_ref update from status get :end 	###############


	
		if($qp){
			echo "<br/><br/><=status=>".$status;
		}

		if($res['status']){
			$message	= $res['status'];
		}else{
			$message	= $res['respMessge'];
		}
		$respCode = $res['data'][0]['respCode'];

		if(isset($res['data'][0]['respMessge'])&&$res['data'][0]['respMessge'])
			$message	= $res['data'][0]['respMessge'];

		$_SESSION['acquirer_action']=1;
		$_SESSION['acquirer_response']=$message;
		$_SESSION['curl_values']=$res;

		if(isset($status) && !empty($status))
		{ 
			if(($status=='SUCCESS' && $respCode=='0' && $message=='SUCCESS' && $td['acquirer']==78)||($status=='SUCCESS' && $message=='SUCCESS' && $td['acquirer']==781)){ //success

				$_SESSION['acquirer_response']=$message." - Success";
				$_SESSION['acquirer_status_code']=2;
			}
			elseif($status=='FAILURE' || $status=='FAIL' || $message=='FAILURE' || $message=='FAIL'){	//failed
				$_SESSION['acquirer_response']=$message." - Cancelled";
				$_SESSION['acquirer_status_code']=-1;
			}
			else{ //pending

				$_SESSION['acquirer_response']=$message." - Pending";
				$status_completed=false;
				
				$_SESSION['acquirer_status_code']=1;
				if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
					$_SESSION['hkip_status']=$_REQUEST['actionurl']." Pending or Error";
				}
					
					
				//include('../status_expired'.$data['iex']);
			//	exit;
				/*	
				$data_tdate=date('YmdHis', strtotime($td['tdate']));
				$current_date_1h=date('YmdHis', strtotime("-1 hours"));
				if(($data_tdate<$current_date_1h)&&($data['localhosts']==false)){
					$_SESSION['acquirer_status_code']=-1;
					$_SESSION['acquirer_response']=$message." - Cancelled"; 
				}
				*/
				
			}
		}
	}
	/*
	elseif(!isset($_SESSION['acquirer_status_code']) || empty($_SESSION['acquirer_status_code']))
	{
		$data_tdate=date('YmdHis', strtotime($td['tdate']));
		$current_date_2h=date('YmdHis', strtotime("-2 hours"));
		if(($data_tdate<$current_date_2h)){
			$_SESSION['acquirer_status_code']=-1;
			$_SESSION['acquirer_response']="Expired";
			include($data['Path'].'/payin/status_expired'.$data['iex']); 
		}
	}
	*/
}

#######################################################

if(!isset($data['STATUS_ROOT'])){
	include($data['Path'].'/payin/status_bottom'.$data['iex']);
}

?>