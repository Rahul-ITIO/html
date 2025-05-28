<?
$data['PageName']='ORDER DETAILS';
$data['PageFile']='process';
$data['HideMenu']=true;
$data['NO_SALT']=true;
$data['SponsorDomain']=true;
include('config.do');
if(isset($_SESSION['redirectrans_status_get'])) unset($_SESSION['redirectrans_status_get']);

if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y') $mts="`ad`"; else $mts="`t`";

function url_f1($url){
	$result=0;
	if(($url)&&((strpos($url,"http:")!==false) || (strpos($url,"https:")!==false))){
		$result=1;
	}
	return $result;
}
$data['PageTitle'] = 'Order Details - '.$data['domain_name']; 
function trans_status_getf($where_pred,$limit_set=' LIMIT 1 '){
	global $data;
	
	//Select Data from master_trans_additional
	$join_additional=join_additional('i');
	if(!empty($join_additional)) $mts="`ad`";
	else $mts="`t`";
	
	// ,{$mts}.`json_value`,{$mts}.`source_url`
	
	$trans_status_get=db_rows(
		"SELECT `t`.`id`,`t`.`acquirer`,`t`.`trans_status`,`t`.`bill_amt`,`t`.`transID`,`t`.`tdate`,`t`.`bill_currency`,`t`.`merID`,`t`.`mop`,`t`.`reference`,`t`.`terNO`,{$mts}.`rrn`,{$mts}.`webhook_url`,{$mts}.`return_url`,{$mts}.`trans_response`,{$mts}.`descriptor` ". 
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t`".
		" {$join_additional} WHERE ".$where_pred.
		" ORDER BY `t`.`id` DESC {$limit_set}",$data['cqp'] //DESC ASC
	);
	return $trans_status_get;
}

if(isset($_SESSION['login'])) unset($_SESSION['login']);

$where_pred=""; $message='';

foreach($_REQUEST as $key=>$value)$_REQUEST[$key]=replacepost($value,$key);

if(isset($_REQUEST['transID'])&&!empty($_REQUEST['transID'])){
	$where_pred.=" (`t`.`transID`={$_REQUEST['transID']}) AND ";
}

//refund 
if(strpos($urlpath,"refund")!== false){
	$bill_amt='';
	if(!isset($_REQUEST['public_key'])||empty($_REQUEST['public_key'])){
		$err=[];
		$err['Error']="1501";
		$err['Message']="Public Key required via public_key ";
		json_print($err);
	}elseif(!isset($_REQUEST['bill_amt'])||empty($_REQUEST['bill_amt'])){
		$err=[];
		$err['Error']="1502";
		$err['Message']="Bill Amount required via bill_amt ";
		json_print($err);
	}
	
	if(isset($_REQUEST['bill_amt'])&&!empty($_REQUEST['bill_amt'])){
		$bill_amt=$_REQUEST['bill_amt'];
	}
	
	
	
	if(isset($_REQUEST['public_key'])&&!empty($_REQUEST['public_key'])){
		
		$decryptres_api = decryptres($_REQUEST['public_key']);
		$public_key_ex=explode('_',$decryptres_api);
		//echo "<hr/>public_key_ex=".$decryptres_api;
		
				
		$merID=$public_key_ex[0];
		$terNO=$public_key_ex[1];
		
		$where_pred_refund=" (`t`.`transID`={$_REQUEST['transID']}) AND (`t`.`merID`={$merID}) AND (`t`.`terNO`={$terNO}) AND (`t`.`bill_amt`>={$bill_amt}) ";
		
		$tr_get=trans_status_getf($where_pred_refund);		
		$tr=$tr_get[0];
		
		$err["transID"]=$tr['transID'];
		$err["bill_amt"]=$tr['bill_amt'];
		
		$arL=acquirer_refund_list();
		$arL_get=$arL[$tr['acquirer']];
		
		
		//print_r($arL[$tr['acquirer']]);
		
			
		if($tr['trans_status']==0){
			$err['Error']="1500";
			$err['Message']="Pending status for refund is not supported";
			json_print($err);
		}
		elseif($arL_get=='No Refund supported'){
			$err['Error']="1503";
			$err['Message']="Refund is not supported by acquirer";
			json_print($err);
		}
		
		
		$err["order_status"]=$tr['trans_status'];
		$err["status"]=$data['TransactionStatus'][$tr['trans_status']];
		
		if(isset($tr)&&$tr&&$tr['trans_status']==1){
			
			$tr_id=$tr['id'];
			
			$df='Ymd';
			//$df='Y-m-d H:i:s'; 
			$ct=date($df); 
			$tdate=date($df,strtotime($tr['tdate']));
			$date_45=date($df,strtotime('+45 days',strtotime($tdate)));
			
			if(isset($_REQUEST['qp'])){
				print_r($tr);
				echo "<hr/>done";
				echo "<hr/>tdate=>".$tdate;
				echo "<hr/>date_45>".$date_45;
				echo "<hr/>ct=>".$ct;
			}
			
			if($ct<=$date_45&&$tr['trans_status']==1){
				$_REQUEST['bid']=$tr_id;
				$_REQUEST['confirm_bill_amt']=$bill_amt;
				update_trans_ranges($merID, 8, $tr_id, '', true, false);
				
				$message="Request Processed";				
			}else{
				$err['Error']="1505";
				$err['Message']='You are not allowed to refund this transactions as this transaction is 45 days is old.';
				json_print($err);
			}
		}
		
	}
	
}
$limit_set=" LIMIT 1 ";
if(isset($_REQUEST['public_key'])&&!empty($_REQUEST['public_key'])){
		$decryptres_api = decryptres($_REQUEST['public_key']);
		$public_key_ex=explode('_',$decryptres_api);
		//echo "<hr/>public_key_ex=".$decryptres_api;
				
		$merID=$public_key_ex[0];
		$terNO=$public_key_ex[1];
	
		$where_pred.=" (`merID`={$merID}) AND (`terNO`={$terNO}) AND "; //merID
		
}
if(isset($_REQUEST['bid'])&&!empty($_REQUEST['bid'])){
	$where_pred.=" (`t`.`id`={$_REQUEST['bid']}) AND ";
	
}
if(isset($_REQUEST['merID'])&&!empty($_REQUEST['merID'])){
	$where_pred.=" (`t`.`merID`={$_REQUEST['merID']}) AND ";
}
if(isset($_REQUEST['reference'])&&($_REQUEST['reference'])&&($merID)){
	$limit_set="";
	$where_pred.=" (`t`.`reference`='{$_REQUEST['reference']}') AND ";
}
if(isset($_REQUEST['reference'])&&($_REQUEST['reference'])&&isset($_REQUEST['terNO'])&&($_REQUEST['terNO']) ){
	$where_pred.=" (`t`.`reference`='{$_REQUEST['reference']}')  AND (`t`.`terNO`='{$_REQUEST['terNO']}') AND  ";
}
if(isset($_REQUEST['bill_email'])&&($_REQUEST['bill_email'])&&($merID)){
	$limit_set="";
	$where_pred .= " ( lower(`t`.`bill_email`) LIKE '%".$_REQUEST['bill_email']."%' ) AND ";
}
if(isset($_REQUEST['bill_phone'])&&($_REQUEST['bill_phone'])&&($merID)){
	$limit_set="";
	$where_pred .= " ( lower({$mts}.`bill_phone`) LIKE '%".$_REQUEST['bill_phone']."%' ) AND ";
}

if($where_pred&&$limit_set==""){
	$where_pred .= " (  `t`.`related_transID` IS NULL OR `t`.`related_transID`='' OR lower(`t`.`related_transID`) LIKE '%\"recent_failed_tid\":%' OR `t`.`trans_status` NOT IN (2)  ) AND ";
}

$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);
$trans_status_get=trans_status_getf($where_pred,$limit_set);
if(!$trans_status_get){
	$json_array['error']='Invalid Parameter';
	json_print($json_array);
	exit;
}
$trans_status_get_size=count($trans_status_get);

if(isset($_REQUEST['webhook_id'])&&trim($_REQUEST['webhook_id']))
	$webhook_id=" | <b>Webhook ID - {$_REQUEST['webhook_id']}</b> ";
else $webhook_id='';


#### after 7:Reversed of 3:Refunded, 5:Chargeback, 6:Returned, 11:Predispute  :start	####################
if($trans_status_get_size==1){
	if(in_array($trans_status_get[0]['trans_status'],["3","5","6","7","11"])){
		$merID=$trans_status_get[0]['merID'];
		$transID=$trans_status_get[0]['transID'];
		$where_pred=" ( `t`.`merID` = '{$merID}') AND ( lower({$mts}.`reply_remark`) LIKE '%{$transID}%' OR lower(`t`.`transID`) LIKE '%{$transID}%' )  ";
		$limit_set=" LIMIT 2 ";
		
		$trans_status_get=trans_status_getf($where_pred,$limit_set);
		$trans_status_get_size=count($trans_status_get);
	}
}
#### after 7:Reversed of 3:Refunded, 5:Chargeback, 6:Returned, 11:Predispute  :end	####################
$j=0;
if($trans_status_get&&$trans_status_get_size>1){
	foreach($trans_status_get as $key=>$value){
		
		$jsonarray_all[$j]["order_status"]=$value['trans_status'];
		if(!empty($message)){
			$jsonarray_all[$j]["message"]=$message;
		}
		if($value['trans_status']==8){
			$trans_status="Request Processed";
			$jsonarray_all[$j]["status"]="Request Processed";
		}else{
			$jsonarray_all[$j]["status"]=$data['TransactionStatus'][$value['trans_status']];
		}
		$jsonarray_all[$j]["bill_amt"]=$value['bill_amt'];
		$jsonarray_all[$j]["transID"]=$value['transID'];
		$jsonarray_all[$j]["descriptor"]=$value['descriptor'];
		$jsonarray_all[$j]["tdate"]=date('Y-m-d H:i:s',strtotime($value['tdate']));
		$jsonarray_all[$j]["bill_currency"]=get_currency($value['bill_currency'],1);
		$jsonarray_all[$j]["response"]=$value['trans_response'];
		$jsonarray_all[$j]["reference"]=$value['reference'];
		if($value['mop']){
			$jsonarray_all[$j]["mop"]=$value['mop'];
		}
	   $j++;
	}
}
else{
	$jsonarray_all["order_status"]=$trans_status_get[0]['trans_status'];
	if($trans_status_get[0]['trans_status']==0){
		$jsonarray_all["authurl"]=$data['Host']."/authurl".$data['ex']."?transID=".$trans_status_get[0]['transID'];
	}else{
		$jsonarray_all["authurl"]='';
	}
	if(!empty($message)){
		$jsonarray_all["message"]=$message;
	}
	if($trans_status_get[0]['trans_status']==8){
		$jsonarray_all["status"]="Request Processed";
	}else{
		$jsonarray_all["status"]=$data['TransactionStatus'][$trans_status_get[0]['trans_status']];
	}
	if(isset($_REQUEST['confirm_bill_amt'])){
		$jsonarray_all["bill_amt"]=stf($_REQUEST['confirm_bill_amt']);
	}else{
		$jsonarray_all["bill_amt"]=$trans_status_get[0]['bill_amt'];
	}
	
	if(isset($trans_status_get[0]['rrn'])&&trim($trans_status_get[0]['rrn'])) $jsonarray_all['rrn']=$trans_status_get[0]['rrn'];
	
	$jsonarray_all["transID"]=$trans_status_get[0]['transID'];
	$jsonarray_all["descriptor"]=$trans_status_get[0]['descriptor'];
	$jsonarray_all["tdate"]=date('Y-m-d H:i:s',strtotime($trans_status_get[0]['tdate']));
	$jsonarray_all["bill_currency"]=get_currency($trans_status_get[0]['bill_currency'],1);
	$jsonarray_all["response"]=$trans_status_get[0]['trans_response'];
	$jsonarray_all["reference"]=$trans_status_get[0]['reference'];
	if($trans_status_get[0]['mop']){
		$jsonarray_all["mop"]=$trans_status_get[0]['mop'];
	}
	if(isset($_REQUEST['merID'])&&!empty($_REQUEST['merID'])){
		$jsonarray_all["merID"]=$merID;
	}
	if(isset($_REQUEST['reference'])&&!empty($_REQUEST['reference'])){
		$jsonarray_all["reference"]=$_REQUEST['reference'];
	}
}

$tr_id=$trans_status_get[0]['id'];
	
if((isset($_REQUEST['actionurl']))&&($_REQUEST['actionurl']=='validate'||$_REQUEST['actionurl']=='fetch_trnsStatus')){
	$_REQUEST['notify']='notify';
	
	// Dev Tech : 23-01-21 modify for if merchant url not found than check from store 
	
	// Dev Tech : 23-02-14 modify for db of terminal wise
	
	if( ($trans_status_get[0]['terNO']>0 ) && ( empty($trans_status_get[0]['return_url']) || empty($trans_status_get[0]['webhook_url']) )  ){
		$terminal_db=db_rows(
			"SELECT `id`,`checkout_theme`,`return_url`,`webhook_url` ". 
			" FROM `{$data['DbPrefix']}terminal`".
			" WHERE `id`='{$trans_status_get[0]['terNO']}' LIMIT 1",$data['cqp']
		);
		$terminal=$terminal_db[0];
		if(empty($trans_status_get[0]['return_url'])&&!empty($terminal['return_url'])) $trans_status_get[0]['return_url']=$terminal['return_url'];
		if(empty($trans_status_get[0]['webhook_url'])&&!empty($terminal['webhook_url'])) $trans_status_get[0]['webhook_url']=$terminal['webhook_url'];
		if(!empty($terminal['checkout_theme'])) $checkout_theme=$_SESSION['checkout_theme']=$data['frontUiName']=$terminal['checkout_theme'];
	}
	//print_r($terminal); exit;
	
}else{
	// Dev Tech : 23-11-29 no need below code so that comment 
	/*
	$time_1=date('Y.m.d_H.i.s');
				
	$tr_upd_validate['VALIDATE_STATUS_'.$time_1]['TIME']=prndates(date('Y-m-d H:i:s'));
	$tr_upd_validate['VALIDATE_STATUS_'.$time_1]['SOURCE']='validate';
	$tr_upd_validate['VALIDATE_STATUS_'.$time_1]['RES']=$jsonarray_all;
	
	if(isset($_SERVER['HTTP_REFERER'])&&trim($_SERVER['HTTP_REFERER']))
	$tr_upd_validate['VALIDATE_STATUS_'.$time_1]['HTTP_REFERER']=$_SERVER['HTTP_REFERER'];
						
	$tr_upd_validate['system_note']='<b>Source - validate</b>'.$webhook_id.' | Status validate by Merchant | Current Status : <b>'.$jsonarray_all["status"].'</b> trans_status';
	
	//Dev Tech : 23-03-30 if via system is validate than skip the update log 
	if(isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='viasystem'){
		$tr_id=0; unset($tr_upd_validate);
	}
	
	if(($tr_id&&$tr_id>0)&&(isset($tr_upd_validate))){
		trans_updatesf($tr_id, $tr_upd_validate);
	}
	*/
	
	jsonen($jsonarray_all);
	
	/*
	$arrayEncoded2 = json_encode($jsonarray_all,JSON_UNESCAPED_UNICODE);
	$arrayEncoded2=urldecodef($arrayEncoded2);
	//remove tab and new line from json encode value 
	$arrayEncoded2 = preg_replace('~[\r\n\t]+~', '', $arrayEncoded2);		
	$arrayEncoded2=stripslashes($arrayEncoded2); $arrayEncoded2=str_replace(array('"{','}"','"[',']"'),array('{','}','[',']'),$arrayEncoded2);
	header('Content-type:application/json;charset=utf-8');
	echo $arrayEncoded2;
	exit;
	*/

}

if(isset($_REQUEST['notify'])&&!empty($_REQUEST['notify'])){
	$webhook_url=$trans_status_get[0]['webhook_url'];
	
	//Dev Tech : 23-03-30 if via system is validate than skip the update log 
	if(isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='viasystem'&&$trans_status_get[0]['trans_status']==0){
		$tr_id=0; 
	}
	
	if(!empty($webhook_url)){
		if(strpos($webhook_url,'?')!==false){
			$webhook_url=$webhook_url."&".http_build_query($jsonarray_all);
		}else{
			$webhook_url=$webhook_url."?".http_build_query($jsonarray_all);
		}
		
		
		if($tr_id&&$tr_id>0){
			
			$chs = curl_init();
			curl_setopt($chs, CURLOPT_URL, $webhook_url);
			curl_setopt($chs, CURLOPT_HEADER, FALSE); 
			curl_setopt($chs, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($chs, CURLOPT_SSL_VERIFYPEER, FALSE);
			curl_setopt($chs, CURLOPT_SSL_VERIFYHOST, FALSE);
			curl_setopt($chs, CURLOPT_POST, true);
			curl_setopt($chs, CURLOPT_POSTFIELDS, http_build_query($jsonarray_all));
			$notify_res = curl_exec($chs);
			curl_close($chs);
			
			
		
			//$return_notify_json='{"notify_code":"00","notify_msg":"received"}'; echo ($return_notify_json); exit;
			$time_2=date('Y.m.d_H.i.s');
			
			$notify_de = json_decode($notify_res,true);
			if(isset($notify_de)&&is_array($notify_de)){
				//print_r($notify_de);
				if($notify_de['notify_msg']=='received'){
					$tr_upd_notify['NOTIFY_VALIDATE_'.$time_2]['MERCHANT_RECEIVE']='NOTIFY_RECEIVE';
				}
			}	
			$tr_upd_notify['NOTIFY_VALIDATE_'.$time_2]['NOTIFY_STATUS']='DONE';
			$tr_upd_notify['NOTIFY_VALIDATE_'.$time_2]['time']=prndates(date('Y-m-d H:i:s'));
			$tr_upd_notify['NOTIFY_VALIDATE_'.$time_2]['NOTIFY_SEND_SOURCE']='validate';
			$tr_upd_notify['NOTIFY_VALIDATE_'.$time_2]['RES']=$jsonarray_all;
			
			$tr_upd_notify['system_note']='<b>Source - Webhook - validate</b> | Current Status : <b>'.$jsonarray_all["status"].'</b> trans_status sent on '.$webhook_url;
			//$tr_upd_notify['NOTIFY_VALIDATE_'.$time_2]['get_info']=htmlentitiesf($notify_res);
			trans_updatesf($tr_id, $tr_upd_notify);
			
			if(isset($_REQUEST['dtest'])){
				echo "<br/>webhook_url=>".$webhook_url;
				echo "<br/>notify_de=>";
				print_r($notify_de);
			}
			//exit;
		}
		
		//$results = json_decode($validates,true); print_r($results);
		
		//echo $webhook_url;print_r($jsonarray_all);
		
	}
} 



$merchantUrl='';
if((isset($_REQUEST['actionurl']))&&($_REQUEST['actionurl']=='validate'||$_REQUEST['actionurl']=='fetch_trnsStatus')){
	$merchantUrl=$trans_status_get[0]['return_url'];
	$redirect_validate_status_url=$data['Host'].'/return_url'.$data['ex'];
	
	if(!empty($merchantUrl)){
		if(strpos($merchantUrl,'?')!==false){
			$merchantUrl=$merchantUrl."&".http_build_query($jsonarray_all);
		}else{
			$merchantUrl=$merchantUrl."?".http_build_query($jsonarray_all);
		}
		if(url_f1($merchantUrl)){
			
			$time_3=date('Y.m.d_H.i.s');
				
			$tr_upd_merchanturl['VALIDATE_MERCHANTURL'][$time_3]['TIME']=prndates(date('Y-m-d H:i:s'));
			$tr_upd_merchanturl['VALIDATE_MERCHANTURL'][$time_3]['SOURCE']='validate';
			$tr_upd_merchanturl['VALIDATE_MERCHANTURL'][$time_3]['STATUS']=$jsonarray_all["status"];
			$tr_upd_merchanturl['VALIDATE_MERCHANTURL'][$time_3]['URL']=$merchantUrl;
			if(isset($_SERVER['HTTP_REFERER'])&&trim($_SERVER['HTTP_REFERER']))
			$tr_upd_merchanturl['VALIDATE_MERCHANTURL'][$time_3]['HTTP_REFERER']=$_SERVER['HTTP_REFERER'];
								
			$tr_upd_merchanturl['system_note']='<b>Source - validate</b>'.$webhook_id.' | Merchant url redirect | Current Status : <b>'.$jsonarray_all["status"].'</b> trans_status as redirect on '.$merchantUrl;
			
			if(($tr_id&&$tr_id>0)&&(isset($tr_upd_merchanturl))){
				trans_updatesf($tr_id, $tr_upd_merchanturl);
			}
			
			
			db_disconnect();
			//post_redirect($merchantUrl, $jsonarray_all);
			if($data['cqp']==9){
				echo "<br/>merchantUrl=> ".$merchantUrl;exit;	
			}
			header("Location:".$merchantUrl);exit;	
		}
	} 
	elseif(isset($redirect_validate_status_url)&&trim($redirect_validate_status_url))
	{
		
		// Dev Tech : 23-01-21 modify for if merchant url not found for success or failed in transaction 
		
		
		$time_3=date('Y.m.d_H.i.s');
				
		$tr_upd_merchanturl['REDIRECT_VALIDATE'][$time_3]['TIME']=prndates(date('Y-m-d H:i:s'));
		$tr_upd_merchanturl['REDIRECT_VALIDATE'][$time_3]['SOURCE']='validate';
		$tr_upd_merchanturl['REDIRECT_VALIDATE'][$time_3]['STATUS']=$jsonarray_all["status"];
		$tr_upd_merchanturl['REDIRECT_VALIDATE'][$time_3]['URL']=$merchantUrl;
		if(isset($_SERVER['HTTP_REFERER'])&&trim($_SERVER['HTTP_REFERER']))
		$tr_upd_merchanturl['REDIRECT_VALIDATE'][$time_3]['HTTP_REFERER']=$_SERVER['HTTP_REFERER'];
							
		$tr_upd_merchanturl['system_note']='<b>Source - validate</b>'.$webhook_id.' | Merchant url not found | Current Status : <b>'.$jsonarray_all["status"].'</b> trans_status as redirect on '.$redirect_validate_status_url;
		
		if(($tr_id&&$tr_id>0)&&(isset($tr_upd_merchanturl))){
			trans_updatesf($tr_id, $tr_upd_merchanturl);
		}
		
		if(isset($terminal)&&isset($checkout_theme)&&trim($checkout_theme)) $jsonarray_all['checkout_theme']=$checkout_theme;
		
		$redirect_validate_status_url=$redirect_validate_status_url."?".http_build_query($jsonarray_all);
		
		$jsonarray_all['redirectrans_status_get']='validate';
		$jsonarray_all['merID']=$trans_status_get[0]['merID'];
		db_disconnect();
		$_SESSION['redirectrans_status_get']=$jsonarray_all;
		
		//post_redirect($redirect_validate_status_url, $jsonarray_all);
		if($data['cqp']==9){
				echo "<br/>redirect_validate_status_url=> ".$redirect_validate_status_url;exit;	
			}
		header("Location:".$redirect_validate_status_url);exit;	
			
	}
	else {		
		db_disconnect();
		
		jsonen($jsonarray_all);
		
		/*
		$arrayEncoded3 = json_encode($jsonarray_all,JSON_UNESCAPED_UNICODE);
		$arrayEncoded3=urldecodef($arrayEncoded3);
		//remove tab and new line from json encode value 
		$arrayEncoded3 = preg_replace('~[\r\n\t]+~', '', $arrayEncoded3);		
		$arrayEncoded3=stripslashes($arrayEncoded3); $arrayEncoded3=str_replace(array('"{','}"','"[',']"'),array('{','}','[',']'),$arrayEncoded3);
		header('Content-type:application/json;charset=utf-8');
		echo $arrayEncoded3;exit;
		*/
	}
}else {
	db_disconnect();
}
?>