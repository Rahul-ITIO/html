<?
$data['PageName']='authurl';
$data['PageFile']='authurl';
$data['HideMenu']=true;
$data['NO_SALT']=true;
$data['SponsorDomain']=true;
include('config.do');
function url_f1($url){
	$result=0;
	if(($url)&&((strpos($url,"http:")!==false) || (strpos($url,"https:")!==false))){
		$result=1;
	}
	return $result;
}
$data['PageTitle'] = 'Transaction Authurl - '.$data['domain_name']; 
global $data;

if(isset($_SESSION['login'])) unset($_SESSION['login']);

$where_pred=""; $message='';

foreach($_REQUEST as $key=>$value)$_REQUEST[$key]=replacepost($value,$key);
//echo "<hr/>transID=".$_REQUEST['transID'];



if(isset($_REQUEST['api_token'])&&!empty($_REQUEST['api_token'])){
		
		$decryptres_api = decryptres($post['api_token']);
		$apiToken=explode('_',$decryptres_api);
		//echo "<hr/>apiToken=".$decryptres_api;
				
		$merID=$apiToken[0];
		//$store_id=$apiToken[1];
		$terNO=$apiToken[1];
		
		$where_pred.=" (`t`.`merID`={$merID}) AND (`t`.`terNO`={$terNO}) AND ";
		
}

if(isset($_REQUEST['reference'])&&($_REQUEST['reference'])&&(@$merID)){
	$where_pred.=" (`t`.`reference`='{$_REQUEST['reference']}') AND ";
}
elseif(isset($_REQUEST['id_order'])&&($_REQUEST['id_order'])&&(@$merID)){
	$where_pred.=" (`t`.`reference`='{$_REQUEST['id_order']}') AND ";
}


if(isset($_REQUEST['transID'])&&!empty($_REQUEST['transID'])){
	$where_pred =" (`t`.`transID`={$_REQUEST['transID']}) AND ";
}

$limit_set=" LIMIT 1 ";

$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);

//Select Data from master_trans_additional
$join_additional=join_additional('i');
if(!empty($join_additional)) $mts="`ad`";
else $mts="`t`";

$trans_status_get=db_rows(
	"SELECT `t`.`id`,`t`.`acquirer`,`t`.`trans_status`,`t`.`bill_amt`,`t`.`transID`,`t`.`tdate`,`t`.`bill_currency`,`t`.`merID`,`t`.`mop`,`t`.`reference`,`t`.`terNO`,`t`.`channel_type`,{$mts}.`rrn`,{$mts}.`json_value`,{$mts}.`source_url`,{$mts}.`webhook_url`,{$mts}.`return_url`,{$mts}.`trans_response`,{$mts}.`descriptor`,{$mts}.`authurl`,{$mts}.`authdata` ". 
	" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t`".
	" {$join_additional} WHERE  ".$where_pred.
	" ORDER BY `t`.`id` DESC {$limit_set}",0 //DESC ASC
);

if(!$trans_status_get){
	$json_array['error']='Invalid Parameter';
	json_print($json_array);
	exit;
}

$t_status_size=count($trans_status_get);
//echo "<hr/>t_status_size=".$t_status_size;

################################################

if(!isset($_SESSION["s30_count_1"]) && empty($_SESSION["s30_count_1"])){
	if(isset($data["s30_count_1"])&&$data["s30_count_1"]){
		$_SESSION["s30_count_1"] = (int)$data["s30_count_1"];
		
	}else{

		$_SESSION["s30_count_1"] = 6;
	}
}else{	
	$s30_count_1 = $_SESSION["s30_count_1"];
	$s30_count_1--;
	$_SESSION["s30_count_1"]= $s30_count_1;
}
//echo $_SESSION["s30_count_1"];

################################################


$j=0;

$trans_status=$trans_status_get[0]['trans_status'];
$acquirer=$trans_status_get[0]['acquirer'];

$tr_json_value_str=jsonreplace($trans_status_get[0]['json_value']);
$is_test=jsonvaluef($tr_json_value_str,'is_test');


$jsonarray_all["status_nm"]=$trans_status;
if(!empty($message)){
	$jsonarray_all["message"]=$message;
}


if($trans_status_get[0]['trans_status']==8){
	$jsonarray_all["status"]="Request Processed";
}else{
	$jsonarray_all["status"]=$data['TransactionStatus'][$trans_status_get[0]['trans_status']];
}
if(isset($_REQUEST['confirm_amount'])){
	$jsonarray_all["bill_amt"]=stf($_REQUEST['confirm_amount']);
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
	$jsonarray_all["reference"]=$_REQUEST['id_order'];
}


	// Dev Tech : 23-02-22 start - if merchant url not found than check from terminal 
	
	if( ($trans_status_get[0]['terNO']>0 ) && ( empty($trans_status_get[0]['return_url']) || empty($trans_status_get[0]['webhook_url']) )  ){
		$terminal_db=db_rows(
			"SELECT `id`,`checkout_theme`,`return_url`,`webhook_url` ". 
			" FROM `{$data['DbPrefix']}terminal`".
			" WHERE `id`='{$trans_status_get[0]['terNO']}' LIMIT 1",0
		);
		$terminal=$terminal_db[0];
		if(empty($trans_status_get[0]['return_url'])&&!empty($terminal['return_url'])) $trans_status_get[0]['return_url']=$terminal['return_url'];
		if(empty($trans_status_get[0]['webhook_url'])&&!empty($terminal['webhook_url'])) $trans_status_get[0]['webhook_url']=$terminal['webhook_url'];
		if(!empty($terminal['checkout_theme'])) $checkout_theme=$_SESSION['checkout_theme']=$data['frontUiName']=$terminal['checkout_theme'];
	}
	
	// Dev Tech : 23-02-22 end - if merchant url not found than check from terminal 
	
	
	#####	redirect to url of merchant :start #####################
	$merchantUrl='';
	if($trans_status_get[0]['trans_status']==1 || $trans_status_get[0]['trans_status']==2){
		$redirectMode='return_url';
		$merchantUrl=$trans_status_get[0]['return_url'];
		$_REQUEST['notify']=1;
	}elseif($trans_status_get[0]['trans_status']==22||$trans_status_get[0]['trans_status']==23){
		$redirectMode='source_url';
		//$merchantUrl=$trans_status_get[0]['source_url'];
		$merchantUrl=$trans_status_get[0]['return_url'];  // Dev Tech : 23-10-12
		$_REQUEST['notify']=1;
	}elseif($trans_status_get[0]['trans_status']==9){
		$_REQUEST['notify']=1;
	}
	#####	redirect to url of merchant :end #####################
	
	
	$tr_id=$trans_status_get[0]['id'];
	$_SESSION['tr_newid']=$tr_id;
	
	#####	notify to url of merchant :start #####################
	if(isset($_REQUEST['notify'])&&!empty($_REQUEST['notify'])){
		$webhook_url=$trans_status_get[0]['webhook_url'];
		if(!empty($webhook_url)){
			$thisNotifyUrl=squrlf($webhook_url,$jsonarray_all);
			$headers = @get_headers($webhook_url);
			if(strpos($headers[0],'404') !== false)
			{
				//$json_array['error']='Invalid Notify URL'; json_print($json_array); exit;
				$jsonarray_all['notify']="404 Page not found!";
				$jsonarray_all['webhook_url']=$webhook_url;
			}
			else{
				$notify_res=use_curl($thisNotifyUrl, $jsonarray_all);
				
				
				
				if($tr_id&&$tr_id>0){
					//$return_notify_json='{"notify_code":"00","notify_msg":"received"}'; echo ($return_notify_json); exit;
					
					$time_1=date('Y.m.d_H.i.s');
					
					$notify_de = json_decode($notify_res,true);
					if(isset($notify_de)&&is_array($notify_de)){
						//print_r($notify_de);
						if($notify_de['notify_msg']=='received'){
							$tr_upd_notify['NOTIFY_AUTHURL_'.$time_1]['MERCHANT_RECEIVE']='NOTIFY_RECEIVE';
						}
					}	
					$tr_upd_notify['NOTIFY_AUTHURL_'.$time_1]['NOTIFY_STATUS']='DONE';
					$tr_upd_notify['NOTIFY_AUTHURL_'.$time_1]['TIME']=prndates(date('Y-m-d H:i:s'));
					$tr_upd_notify['NOTIFY_AUTHURL_'.$time_1]['NOTIFY_SEND_SOURCE']='authurl';
					$tr_upd_notify['NOTIFY_AUTHURL_'.$time_1]['RES']=$jsonarray_all;
										
					$tr_upd_notify['system_note']='<b>Source - authurl</b> | Current Status : <b>'.$jsonarray_all["status"].'</b> trans_status sent on '.$webhook_url;
					//$tr_upd_notify['NOTIFY_AUTHURL_'.$time_1]['get_info']=htmlentitiesf($notify_res);
					trans_updatesf($tr_id, $tr_upd_notify);
					
					if(isset($_REQUEST['dtest'])){
						echo "<br/>webhook_url=>".$webhook_url;
						echo "<br/>notify_de=>";
						print_r($notify_de);
					}
					//exit;
				}
				
				
			}
		}
	} 
	#####	notify to url of merchant :end #####################
	
	
	
	
	if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']==2){
		if(!empty($merchantUrl)){
			$jsonarray_all["redirectMode"]=$redirectMode;
			$jsonarray_all["redirectUrl"]=$merchantUrl;
		}
		//header("Content-Type: application/json", true);
		echo json_encode($jsonarray_all);
	}
	
	
	
	#######	test 3d:start ############################
		
	//if($trans_status_get[0]['trans_status']==9&&$data['t'][(int)$acquirer]['name4']=='3D'){
	if(($trans_status_get[0]['trans_status']==0)&&(isset($is_test)&&$is_test=="9")){
		if($trans_status_get[0]['channel_type']=='2' || $trans_status_get[0]['channel_type']=='3'){
			$redirecturl = $data['Host']."/test3dsecureauthentication".$data['ex']."?transID=".$trans_status_get[0]['transID'];
		}else{
			$redirecturl = $data['Host']."/success".$data['ex']."?transID=".$trans_status_get[0]['transID'];
		}
		header("Location:".$redirecturl);exit;	
	}
	#######	test 3d:end ############################
	
	
	#######	pending trans_status and pay_url redirect :start ##################
	
	if(isset($trans_status_get[0]['json_value'])&&$trans_status_get[0]['json_value']&&$trans_status==0){
		
		$authdata_arr=isJsonDe($trans_status_get[0]['authdata']);
		
		$jsonarray_all["authstatus"]=$data['Host']."/authstatus".$data['ex']."?action=authstatus&transID=".$jsonarray_all["transID"];
		
		
		//Dev Tech : 23-03-30 refresh every 5 seconds via json value for refresh_3ds2_auth
		$json_value_arr=jsondecode($trans_status_get[0]['json_value'],1,1);
		
		
		if(isset($_SESSION['refresh_ReqURL'])) unset($_SESSION['refresh_ReqURL']);
		if(isset($_SESSION['refresh_ReqDATA'])) unset($_SESSION['refresh_ReqDATA']);
		if(isset($_SESSION['refresh_AcqUrl'])) unset($_SESSION['refresh_AcqUrl']);
		if(isset($_SESSION['3ds2_auth_html'])) unset($_SESSION['3ds2_auth_html']);
		if(isset($_SESSION['refresh_3ds2_auth'])) unset($_SESSION['refresh_3ds2_auth']);
		
		if(isset($json_value_arr['refresh_3ds2_auth'])&&$json_value_arr['refresh_3ds2_auth']){
			$_SESSION['refresh_3ds2_auth']=$json_value_arr['refresh_3ds2_auth'];
		}
		
			
		if(isset($_SESSION['r_coins'])) unset($_SESSION['r_coins']);
		
		if(isset($_SESSION['3ds2_auth'])) unset($_SESSION['3ds2_auth']);
		
		$auth_data_get=jsonvaluef($trans_status_get[0]['json_value'],'auth_data');
		
		if(isset($authdata_arr)&&$authdata_arr){
			$_SESSION['3ds2_auth']=($authdata_arr);
		}elseif(isset($json_value_arr['auth_data'])&&$json_value_arr['auth_data']){
			$_SESSION['3ds2_auth']=($json_value_arr['auth_data']);
		}elseif(!empty($auth_data_get)){
			$_SESSION['3ds2_auth']=$auth_data_get;
		}
		
		if(isset($_SESSION['3ds2_auth']['payaddress'])&&$_SESSION['3ds2_auth']['payaddress']){
			//$_SESSION['r_coins']=$_SESSION['3ds2_auth'];
		}
		
		
		if(isset($json_value_arr['pay_url'])&&$json_value_arr['pay_url']){
			$authurl_redirect=$json_value_arr['pay_url'];
		}
		else{
			$authurl_redirect=jsonvaluef($trans_status_get[0]['json_value'],'pay_url');
		}
		$pay_root_get=jsonvaluef($trans_status_get[0]['json_value'],'pay_root');
		
		
		$authurl_get=($trans_status_get[0]['authurl']);
		if(isset($authurl_get)&&trim($authurl_get)){
			$_SESSION['redirect_url']=$authurl_get;
			
			$secure_process=jsonvaluef($trans_status_get[0]['json_value'],'secure_process');
			
			if(isset($secure_process)&&trim($secure_process))
				 $authurl_redirect=$secure_process;
			else $authurl_redirect=$authurl_get;
			
		}
		elseif(!empty($pay_root_get)&&!empty($authurl_redirect)){
			$_SESSION['redirect_url']=$authurl_redirect;
			$authurl_redirect=$data['Host'].'/'.$pay_root_get.$data['ex'];
		}
		
		
		if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']==3){
			
			echo "<br/><br/>authurl_redirect=>".$authurl_redirect;
			
			echo "<br/><br/>authdata_arr=>";
			print_r($authdata_arr);
			
			echo "<br/><br/>3ds2_auth=>";
			print_r($_SESSION['3ds2_auth']);
			
			exit;
		}
		
		
		if(!empty($authurl_redirect)){
			if(url_f1($authurl_redirect)){
				
				$time_2=date('Y.m.d_H.i.s');
				
				$tr_upd_authurl['REDIRECT_AUTHURL_'.$time_2]['TIME']=prndates(date('Y-m-d H:i:s'));
				$tr_upd_authurl['REDIRECT_AUTHURL_'.$time_2]['SOURCE']='authurl';
				$tr_upd_authurl['REDIRECT_AUTHURL_'.$time_2]['URL']=$authurl_redirect;
			
				if(isset($_SERVER['HTTP_REFERER'])&&trim($_SERVER['HTTP_REFERER']))
				$tr_upd_authurl['REDIRECT_AUTHURL_'.$time_2]['HTTP_REFERER']=$_SERVER['HTTP_REFERER'];
									
				$tr_upd_authurl['system_note']='<b>Source - authurl</b> | Auth url redirect | Current Status : <b>'.$jsonarray_all["status"].'</b> trans_status redirect on '.$authurl_redirect;
				
				if(($tr_id&&$tr_id>0)&&(isset($tr_upd_authurl))){
					trans_updatesf($tr_id, $tr_upd_authurl);
				}
				
				header("Location:".$authurl_redirect);exit;
			}
		}else{
			$jsonarray_all["authurl"]='';
		}
		
	}else{
		$jsonarray_all["authurl"]='';
	}
	
	#######	pending trans_status and pay_url redirect :end ##################
	
	
	##### success or failed is trans_status than redirect to merchant url :start #######
	
	if(!empty($merchantUrl)){
		if(strpos($merchantUrl,'?')!==false){
			$merchantUrl=$merchantUrl."&".http_build_query($jsonarray_all);
		}else{
			$merchantUrl=$merchantUrl."?".http_build_query($jsonarray_all);
		}
		if(url_f1($merchantUrl)){
			
			$time_3=date('Y.m.d_H.i.s');
				
			$tr_upd_merchanturl['REDIRECT_MERCHANTURL_'.$time_3]['TIME']=prndates(date('Y-m-d H:i:s'));
			$tr_upd_merchanturl['REDIRECT_MERCHANTURL_'.$time_3]['SOURCE']='authurl';
			$tr_upd_merchanturl['REDIRECT_MERCHANTURL_'.$time_3]['URL']=$merchantUrl;
			if(isset($_SERVER['HTTP_REFERER'])&&trim($_SERVER['HTTP_REFERER']))
			$tr_upd_merchanturl['REDIRECT_MERCHANTURL_'.$time_3]['HTTP_REFERER']=$_SERVER['HTTP_REFERER'];
								
			$tr_upd_merchanturl['system_note']='<b>Source - authurl</b> | Merchant url redirect | Current Status : <b>'.$jsonarray_all["status"].'</b> trans_status redirect on '.$merchantUrl;
			
			if(($tr_id&&$tr_id>0)&&(isset($tr_upd_merchanturl))){
				trans_updatesf($tr_id, $tr_upd_merchanturl);
			}
			
			post_redirect($merchantUrl, $jsonarray_all);
		}
		//header("Location:".$redirecturl);exit;	
	}else{
		if($trans_status_get[0]['trans_status']>0){
			header("Content-Type: application/json", true);
			echo json_encode($jsonarray_all);
		}
	}
	
	##### success or failed is trans_status than redirect to merchant url :end #######
	
if($trans_status_get[0]['trans_status']==0){	
	
	$data['header_msg'] = "<div class=separator></div><br/> <h2 style='font-size:28px;'><i></i> Transaction is in process......{$_SESSION['s30_count_1']}</h2> <h3 style='font-size:22px;'><i></i>We are waiting for final result from the bank</h3><div class=separator></div>";
	$data['footer_msg'] = "<p>Slow connectivity while establishing a connection with bank server. </p><br/><p>The transaction trans_status will notify via email soon. </p><br/><p>Do not attempt a new transaction for next four hours.  </p><br/><br/>";
	
	
	$jsonarray_all["source_url"]=$trans_status_get[0]['source_url'];
	//$jsonarray_all["transID"]=$trans_status_get[0]['transID'];
	$jsonarray_all["acquirer"]=$trans_status_get[0]['acquirer'];
	$data['getresponse']=$jsonarray_all;
	$g_sid=0;$g_merID=(int)$merID; $domain_server=sponsor_themefc($g_sid,$g_merID);
	
	display('user');
}


?>