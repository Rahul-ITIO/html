<? 
//if(!isset($_SESSION)){session_start();} 

// http://localhost/gw/crons_notify.do?pq=1&li=2&day=25&dtest=1
// http://localhost/gw/crons_notify.do?pq=1&li=2&day1=25&t=1494407

//@set_time_limit(0);

/*
ErrorDocument 400 /error-code.php
ErrorDocument 401 /error-code.php
ErrorDocument 403 /error-code.php
ErrorDocument 404 /error-code.php
ErrorDocument 500 /error-code.php
ErrorDocument 502 /error-code.php
ErrorDocument 504 /error-code.php
*/

function ErrorDocumentf(){
	if(isset($_SERVER["REDIRECT_STATUS"])&&$_SERVER["REDIRECT_STATUS"]){
		switch($_SERVER["REDIRECT_STATUS"]){
			case 400:
				$title = "400 Bad Request";
				$description = "The request can not be processed due to bad syntax";
			break;

			case 401:
				$title = "401 Unauthorized";
				$description = "The request has failed authentication";
			break;

			case 403:
				$title = "403 Forbidden";
				$description = "The server refuses to response to the request";
			break;

			case 404:
				$title = "404 Not Found";
				$description = "The resource requested can not be found.";
			break;

			case 500:
				$title = "500 Internal Server Error";
				$description = "There was an error which doesn't fit any other error message";
			break;

			case 502:
				$title = "502 Bad Gateway";
				$description = "The server was acting as a proxy and received a bad request.";
			break;

			case 504:
				$title = "504 Gateway Timeout";
				$description = "The server was acting as a proxy and the request timed out.";
			break;
		}

		echo "<h1 style='text-align: center;'>{$title}</h1>";
		echo "<h5 style='text-align: center;'>{$description}</h5>";
	}
}
ErrorDocumentf();


$data['HideMenu']=true;
$data['NO_SALT']=true;
$data['SponsorDomain']=true;

$topLocation=0;
$php_self=$_SERVER['PHP_SELF'];
if ((strpos ( $php_self, "status_auto_update" ) !== false)||(strpos ( $php_self, "status_2_auto_update" ) !== false)) {
	//$rootPhp="/var/www/html/";
	$topLocation=1;
	
}else{
	$rootPhp="";
}

if(isset($data['rootPath'])){
	$rootPhp=$data['rootPath'];
}

if (strpos ( $php_self, "status_2_auto_update" ) !== false) {
	$cron_time=2; // two minutes 
}else{
	$cron_time=0;
}

if((isset($_REQUEST['type']))&&($_REQUEST['type']==27||$_REQUEST['type']=='27')){
	$cron_time=2; // two minutes for 27 account 
	
}
if((isset($_REQUEST['ct']))&&($_REQUEST['ct'])){
	$cron_time=2; // two minutes 
	$_REQUEST['type']=$_REQUEST['ct'];
} 

if((isset($_REQUEST['related']))&&($_REQUEST['related'])){
	$related=(int)$_REQUEST['related'];  
}else{
	$related=0;
}

if((isset($_REQUEST['o']))&&($_REQUEST['o'])&&$_REQUEST['o']=='A'){
	$order_by=" ORDER BY `id` ASC ";  
}elseif((isset($_REQUEST['o']))&&($_REQUEST['o'])&&$_REQUEST['o']=='d'){
	$order_by=" ORDER BY `id` DESC ";  
}else{
	$order_by='';
}
	
//echo "<hr/>list rootPhp=>".$rootPhp."<hr/>";	

include($rootPhp.'config.do');

//echo $browserOs;exit;

if ((strpos ( $php_self, "status_auto_update" ) !== false)||(strpos ( $php_self, "status_2_auto_update" ) !== false)) {
	
	$data['Host']=$data['HostG'];
	$_SERVER["HTTP_HOST"]=$data['HostN'];
	$_SERVER["HTTPS"]='on';
	$urlpath=$php_self;
	$data['urlpath']=$urlpath;
	
	
	$_SERVER["HTTPS"]='on';
	$host_path=$data['Host'];
}else{
	$host_path=$data['Host'];
}


$data['pq']=0;
$ext="do";

if(isset($_GET['l'])){
	$data['Host']="http://localhost/gw";
	$_SERVER["HTTP_HOST"]="http://localhost/gw";
	$host_path=$data['Host'];
}

//$host_path=$data['Host'];

//echo $data['Host'];exit;



if(isset($_GET['pq'])){
	$data['pq']=$_GET['pq'];
}
if(isset($_REQUEST['pop'])){
	$data['pop']=$_REQUEST['pop'];
}

$actionurl_get="";
$transID=""; $where_pred="";


// ------------------------------------------------

if(isset($_SESSION['step']))unset($_SESSION['step']);			
if(isset($_SESSION['acquirer_action']))unset($_SESSION['acquirer_action']); 
if(isset($_SESSION['acquirer_response']))unset($_SESSION['acquirer_response']);
if(isset($_SESSION['acquirer_status_code']))unset($_SESSION['acquirer_status_code']);
if(isset($_SESSION['acquirer_transaction_id'])) unset($_SESSION['acquirer_transaction_id']);
if(isset($_SESSION['acquirer_descriptor'])) unset($_SESSION['acquirer_descriptor']);
if(isset($_SESSION['curl_values'])) unset($_SESSION['curl_values']);
if(isset($_SESSION['s30_count'])) unset($_SESSION['s30_count']); 

		
	$i=0;

		############ QR transaction list #########################
		
		if(isset($_GET['t'])&&$_GET['t']){
			
			#########  QR_4		##############
			
			$transID=$_GET['t'];
			
			$r_status=" ( `transID` IN ({$transID}) ) ";
			
			$r_type=" ";
			$r_type1=" AND (`trans_type` IN (11)) ";
			$r_limit="5";
		}
		else{
			
			#########  QR_5		##############
			
			$notType='';
			if((isset($_GET['notType']))&&($_GET['notType'])){
				$notType=','.$_GET['notType'];
			}
			
			//$notify='NOTIFY';
			$notify='DONE';
			
			//$r_status=" ( (JSON_UNQUOTE(JSON_EXTRACT(`json_value`, '$.NOTIFY'))  LIKE ('%{$notify}%') ) ) AND (JSON_VALID(`json_value`) = 1 )  AND ( `trans_status` IN (1,2,9) ) ";
			
			
			$day='1';
			if(isset($_GET['day'])&&$_GET['day']){
				$day=$_GET['day'];
			}
			$date_1st=(date('Y-m-d',strtotime("-{$day} days")));
			$date_2nd=date('Y-m-d');
			
			$r_status=" ( ( CONVERT(`json_value` USING utf8) NOT LIKE ('%\"NOTIFY_STATUS\":\"DONE\"%') )   AND  (JSON_VALID(`json_value`) = 1 ) ) AND  ( `trans_status` IN (1,2,9) )  AND  ( `tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) )  AND  (  related_transID IS NULL OR related_transID='' OR lower(related_transID) LIKE '%\"recent_failed_tid\":%' OR `trans_status` NOT IN (2)  )  AND  (`webhook_url` != '')  ";
			
			if((isset($_GET['type']))&&($_GET['type'])){
				$r_type="  AND  ( `acquirer` IN ({$_REQUEST['type']}) )  ";
			}
			
			if((isset($_GET['notType']))&&($_GET['notType'])){
				$r_type.=" AND (`acquirer` NOT IN (0,1,2,3,4,5,6,7,8,9,10,11,12{$notType}) ) ";
			}
			
			$r_type1=" AND (`trans_type` IN (11)) ";
			$r_limit="100";
		}
		
		
		
		if(isset($_GET['li'])&&$_GET['li']){
			$r_limit=$_GET['li'];
		}
		
		if($related){
			$related=$related-1;
			//$r_type.=" AND  ( `related`={$related} ) ";
		}
		
		$crontab_url=1; $use_curl_updt = 1;
		
		$t_id=[];
		if(!isset($_SESSION['t_id_all']))
		$_SESSION['t_id_all']=[];
	
		if(!isset($_SESSION['pending_tr'])) $_SESSION['pending_tr']=[]; 
		if(!isset($_SESSION['approved_tr'])) $_SESSION['approved_tr']=[]; 
		if(!isset($_SESSION['declined_tr'])) $_SESSION['declined_tr']=[]; 
		if(!isset($_SESSION['expired_tr'])) $_SESSION['expired_tr']=[]; 
	
		$tra=db_rows(
			"SELECT `id`, `transID`, `tdate`, `acquirer`, `trans_status`, `merID`, `json_value`,`system_note`,`bill_amt`,`bank_processing_amount`,`bill_email`,`descriptor`,`bill_currency`,`webhook_url`,`trans_response`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE ".$r_status.
			" ".$r_type1.$r_type.$order_by.
			//" ORDER BY tdate DESC". //	ASC	DESC
			" LIMIT ".$r_limit.
			" ",$data['pq']
		);
		

			
		if(!$data['pq']&&!$data['pop']){
			echo "<hr/>size=>".count($tra)."<hr/>";
		}
		
		if(isset($_GET['ex'])&&$_GET['ex']==1){
			exit;
		}
		//exit;
		$j=1;
		foreach($tra as $key=>$value){
			
			$json_value2=jsondecode($value['json_value'],1,1);
			
			if(isset($json_value2['processed_acquirer_type'])&&$json_value2['processed_acquirer_type']){
				
				$value['acquirer']=(int)$json_value2['processed_acquirer_type'];
			}
			
			// $related_plus=$value['related']+1;
			
			$transID_id=$value['transID']."_".$value['id'];
			$transID=$value['transID'];
			
			$data_send=array();
			$data_send['transID']=$transID_id;
			$data_send['acquirer']=$value['acquirer'];
			$data_send['tdate']=$value['tdate'];
			$data_send['bank_processing_amount']=$value['bank_processing_amount'];
			$data_send['bill_amt']=$value['bill_amt'];
			$data_send['bill_email']=$value['bill_email'];
			$data_send['actionurl']='admin_direct';
			$data_send['admin']='1';
			$data_send['cron_tab']='cron_tab';
			
			$t_id[]=$value['transID'];
			$_SESSION['t_id_all'][]=$value['transID'];
			
			
			$current_date_10m=date('YmdHis', strtotime("-10 minutes"));
			$current_date_30m=date('YmdHis', strtotime("-30 minutes"));
			$current_3days_back =date('YmdHis', strtotime("-3 days"));
			//$current_3days_back =date('YmdHis', strtotime("-5 hours"));
			$current_date_2h=date('YmdHis', strtotime("-2 hours"));
			$current_date_6h=date('YmdHis', strtotime("-6 hours"));
			$data_tdate=date('YmdHis', strtotime($value['tdate']));
			
			
			
			
			
			#########  notify value	##################################
			
			$jsonarray_all["order_status"]=$value['order_status'];
			if($value['order_status']==8){
				$jsonarray_all["status"]="Request Processed";
			}else{
				$jsonarray_all["status"]=$data['TransactionStatus'][$value['order_status']];
			}
			
			$jsonarray_all["bill_amt"]=$value['bill_amt'];
			$jsonarray_all["transID"]=$value['transID'];
			$jsonarray_all["descriptor"]=$value['descriptor'];
			$jsonarray_all["tdate"]=$value['tdate'];
			$jsonarray_all["bill_currency"]=get_currency($value['bill_currency'],1);
			$jsonarray_all["response"]=$value['trans_response'];
			$jsonarray_all["reference"]=$value['reference'];
			if($value['mop']){
				$jsonarray_all["mop"]=$value['mop'];
			}
			
			
			$webhook_url=$value['webhook_url'];
			if(!empty($webhook_url)){
				/*
				if(strpos($webhook_url,'?')!==false){
					$webhook_url=$webhook_url."&".http_build_query($jsonarray_all);
				}else{
					$webhook_url=$webhook_url."?".http_build_query($jsonarray_all);
				}
				*/
				$jsonarray_all['webhook']="webhook_by_s2s";		
				$chs = curl_init();
					curl_setopt($chs, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
				curl_setopt($chs, CURLOPT_URL, $webhook_url);
				curl_setopt($chs, CURLOPT_HEADER, FALSE); // FALSE || true || 
					curl_setopt($chs, CURLOPT_MAXREDIRS, 10);
				curl_setopt($chs, CURLOPT_RETURNTRANSFER, 1);
				curl_setopt($chs, CURLOPT_SSL_VERIFYHOST, 0);
				curl_setopt($chs, CURLOPT_SSL_VERIFYPEER, 0);
				curl_setopt($chs, CURLOPT_POST, true);
				curl_setopt($chs, CURLOPT_POSTFIELDS, http_build_query($jsonarray_all));
				curl_setopt($chs, CURLOPT_TIMEOUT, 10);
				$notify_res = curl_exec($chs);
				curl_close($chs);
				
				#######	save notificatio response	#############
				if($value['id']&&$value['id']>0){
					//$return_notify_json='{"notify_code":"00","notify_msg":"received"}'; echo ($return_notify_json); exit;
			
					$notify_de = json_decode($notify_res,true);
					if(isset($notify_de)&&is_array($notify_de)){
						//print_r($notify_de);
						if($notify_de['notify_msg']=='received'){
							$tr_upd_notify['CRONS_BRIDGE']['MERCHANT_RECEIVE']='NOTIFY_RECEIVE';
						}
					}	
					$tr_upd_notify['CRONS_BRIDGE']['NOTIFY_STATUS']='DONE';
					$tr_upd_notify['CRONS_BRIDGE']['time']=prndates(date('Y-m-d H:i:s'));
					$tr_upd_notify['CRONS_BRIDGE']['NOTIFY_SEND_SOURCE']='crons_notify';
					$tr_upd_notify['CRONS_BRIDGE']['RES']=$jsonarray_all;
					
					$tr_upd_notify['system_note']='<b>Source - crons_notify</b> | Current Status : <b>'.$jsonarray_all["status"].'</b> status sent on '.$webhook_url;
					//$tr_upd_notify['CRONS_BRIDGE']['get_info']=htmlentitiesf($notify_res);
					
					
					//exit;
				
				
					echo "<br/><hr/><br/>{$j}. transID=> ".$value['transID'];
					echo "<br/><br/>webhook_url=> ".$webhook_url;
					echo "<br/><br/>jsonarray_all=> "; print_r($jsonarray_all);
					echo "<br/><br/>tr_upd_notify=> "; print_r($tr_upd_notify);
					
					echo "<br/><br/>";
				
				}
				
			}else{
				
				$tr_upd_notify['NOTIFY_FAILED_TIME']=prndate(date('Y-m-d H:i:s'));
				$tr_upd_notify['NOTIFY_FAILED_SOURCE']='crons_notify';
				$tr_upd_notify['NOTIFY_FAILED']='Missing notify url';
				$tr_upd_notify['system_note']='<b>Source - crons_notify</b>  | Notify skipped as log found | Current Status : <b>'.$jsonarray_all["status"].'</b> status as <b>notify url missing</b>';
				
				echo "<br/><hr/><br/>{$j}. NOT FOUND webhook_url => ".$value['transID'];
			}
			
			
			
			trans_updatesf($value['id'], $tr_upd_notify);
		
			
			
			#### Dev Tech : 23-03-22 how many success, failed, pending & expired
			
			if($value['trans_status']==0){ //pending
				$_SESSION['pending_tr'][]=$value['transID'];
			}
			if($value['trans_status']==1){ //success - Approved
				$_SESSION['approved_tr'][]=$value['transID'];
			}
			if($value['trans_status']==2){ //failed - Declined
				$_SESSION['declined_tr'][]=$value['transID'];
			}else{ // Expired | Cancelled 
				$_SESSION['expired_tr'][]=$value['transID'];
			}
			
			
			$j++;
		}
			
		//db_disconnect();
		
		//--------------------------------------------
		
		echo "<br/><hr/><br/><==t_id==><br/>".implode(",",$t_id);
		
		echo "<br/><br/><hr/><br/><==APPROVED==>".count($_SESSION['approved_tr'])."<br/>".implode(",",$_SESSION['approved_tr']);
		echo "<br/><br/><hr/><br/><==PENDING==>".count($_SESSION['pending_tr'])."<br/>".implode(",",$_SESSION['pending_tr']);
		echo "<br/><br/><hr/><br/><==DECLINED==>".count($_SESSION['declined_tr'])."<br/>".implode(",",$_SESSION['declined_tr']);
		echo "<br/><br/><hr/><br/><==EXPIRED==>".count($_SESSION['expired_tr'])."<br/>".implode(",",$_SESSION['expired_tr']);
		
		echo "<br/><br/><hr/><br/><==All t_id==>".count($_SESSION['t_id_all'])."<br/>".implode(",",$_SESSION['t_id_all']);
		echo "<br/><br/><hr/>";
		
		//echo "<script>if(window.opener){window.opener.document.getElementById('modal_popup_form_popup').style.display='none';window.close();}</script>";
		
		//exit;
		
		if(((isset($_REQUEST['type']))&&($_REQUEST['type']==27||$_REQUEST['type']=='27'))||((isset($_REQUEST['ct']))&&($_REQUEST['ct']))){
			
			if((isset($_REQUEST['related']))&&($_REQUEST['related'])){
				$related_sub="&related=".$_REQUEST['related'];
			}else{
				$related_sub="";
			}
			if((isset($_REQUEST['ct']))&&($_REQUEST['ct'])){
				$ct_sub="&ct=".$value['acquirer'];
			}else{
				$ct_sub="";
			}
			
			if((isset($_REQUEST['re']))&&($_REQUEST['re'])){
				$timeOut=(int)$_REQUEST['re'];
				$ct_sub="&ct=".$value['acquirer']."&re=".$_REQUEST['re'];
			}else{
				$timeOut=100;
			}
			echo "<br/>timeOut=>".$timeOut;
			
			echo "<script>
				var timeOut = $timeOut;
				//alert(timeOut);
				var urlset ='{$data['Host']}/crons{$data['iex']}?pq=1&type={$value['acquirer']}{$related_sub}{$ct_sub}';
				setTimeout( function(){ 
					if(urlset){
						top.document.location.href=urlset;
					}
				}, timeOut ); //120000
			</script>";
			
		}
		
		
		
		/*
		if($topLocation==0){
			echo "<script>
				if (!top.window.location.href.match(/\processed_list/)) {
				  var topurl = top.window.location.href;
				  top.window.location.href=topurl;
				}
			</script>";
		}
		
		*/
	
exit;
//--------------------------------------------

		
		
	
		
	

?>
