<? 
#### Dev Tech : 23-08-11 upa, rrn, txn_id update from status get via admin login and not run the notify and status not update of merchant 

//  crons_status_c.do?pq=1&dtest=2&s=1&&o=d&li=2&day=0&type=69

//  crons_status_c.do?pq=1&dtest=1&o=d&li=2&day=0&type=69
//  crons_status_c.do?pq=1&li=2&t=1494407

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
	$order_by=" ORDER BY `t`.`id` ASC ";  
}elseif((isset($_REQUEST['o']))&&($_REQUEST['o'])&&$_REQUEST['o']=='d'){
	$order_by=" ORDER BY `t`.`id` DESC ";  
}elseif((isset($_REQUEST['o']))&&($_REQUEST['o'])&&$_REQUEST['o']=='o'){
	$order_by="  ";  
}else{
	$order_by=" ORDER BY `t`.`id` DESC ";  
}
	
//echo "<hr/>list rootPhp=>".$rootPhp."<hr/>";	

include($rootPhp.'config.do');

if(!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.'); exit;
} 


//Select Data from master_trans_additional
$join_additional=join_additional('i');
if(!empty($join_additional)) $mts="`ad`";
else $mts="`t`";


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


$data['pq']=1;
$ext="do";


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
		
		$r_type=" ";
		$r_type1=" ";
			
			
		############ QR transaction list #########################
		
		if(isset($_GET['t'])&&$_GET['t']){
			
			#########  QR_4		##############
			
			$transactionId=$_GET['t'];
			
			$r_status=" ( `t`.`transID` IN ({$transactionId}) ) ";
			
			$r_type=" ";
			$r_type1=" AND (`t`.`trans_type` IN (11)) ";
			$r_limit="5";
		}
		else{
			
			#########  QR_5		##############
			
			$notType='';
			if((isset($_GET['notType']))&&($_GET['notType'])){
				$notType=','.$_GET['notType'];
			}
			
			
			$day='1';
			if(isset($_GET['day'])&&$_GET['day']){
				$day=$_GET['day'];
			}
			$date_1st=(date('Y-m-d',strtotime("-{$day} days")));
			$date_2nd=date('Y-m-d');
			
			if(isset($_GET['day2'])&&$_GET['day2']&&$_GET['day2']<=$day)
			{
				$day2=$_GET['day2'];
				$date_2nd=(date('Y-m-d',strtotime("-{$day2} days")));
			}
			
			//$r_status=" ( ( `t`.`tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) )  AND  ({$mts}.`json_value` != ''  AND  {$mts}.`json_value` != '[]'    AND  {$mts}.`json_value` != '{}'  AND  {$mts}.`json_value` IS NOT NULL ) )  ";
			
			$r_status=" ( ( `t`.`tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) )  )  ";
			
			//AND  (  related_transID IS NULL OR related_transID='' OR lower(related_transID) LIKE '%\"recent_failed_tid\":%' OR status NOT IN (2)  )
			
			if((isset($_GET['type']))&&($_GET['type'])){
				$r_type="  AND  ( `t`.`acquirer` IN ({$_REQUEST['type']}) )  ";
			}
			if((isset($_GET['notType']))&&($_GET['notType'])){
				$r_type.=" AND (`t`.`acquirer` NOT IN (0,1,2,3,4,5,6,7,8,9,10,11,12{$notType}) ) ";
			}
			
			
			
			if((isset($_GET['type']))&&($_GET['type'])&&(isset($_GET['li']))&&($_GET['li'])){
				
			}else{
				$r_status.="  AND  ( `t`.`trans_status` IN (0) )  ";
			}
			
			$r_type1=" AND (`t`.`trans_type` IN (11)) ";
			$r_limit="2";
		}
		
		//if((isset($_GET['s']))&&($_GET['s']))
		{
			$r_status.="  AND  ( `t`.`trans_status` IN (0) )  ";
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
			"SELECT `t`.`id`,`t`.`acquirer`,`t`.`trans_status`,`t`.`bill_amt`,`t`.`bank_processing_amount`,`t`.`bill_email`,`t`.`transID`,`t`.`tdate`,`t`.`bill_currency`,`t`.`merID`,`t`.`mop`,`t`.`reference`,{$mts}.`webhook_url`,{$mts}.`trans_response`,{$mts}.`descriptor` ".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t`".
			" {$join_additional} WHERE ".$r_status.
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
			
			/*
			
			$json_value2=jsondecode($value['json_value'],1,1);
			
			if(isset($json_value2['processed_acquirer_type'])&&$json_value2['processed_acquirer_type']){
				
				$value['acquirer']=(int)$json_value2['processed_acquirer_type'];
			}
			
			*/
			
			//$related_plus=$value['related']+1;
			
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
			
			
			
			
			
			#########  start - status check	##################################
			
				//if((isset($json_value2['status_'.$value['acquirer']]))&&(strpos($json_value2['status_'.$value['acquirer']], "status")!==false)&&($cron_time==0))
				
				if($cron_time==0)
				{			
					if($data_tdate<$current_date_30m){
						
						//$surl=$data['Host']."/status{$data['ex']}?transID={$transID}&type={$value['acquirer']}&action=webhook&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
						
						$surl=$data['Host']."/status{$data['ex']}?transID={$transID}&type={$value['acquirer']}&action=webhook&actionurl=admin&admin=1&cron_tab=cron_tab&no_merchant_redirect=stop";
						
						$curlResponse=use_curl($surl,$data_send);
						
						//if($data['pq'])
						{
							
							echo "<hr/><br/>surl=>".$surl;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
						$crontab_url = 0;
					}
				}
				else{
					$crontab_url = 1;
				}
			
			#########  end - status check	##################################
			
			
			if(isset($curlResponse)&&$curlResponse){
			  $curlResponse_de=json_decode($curlResponse,1);
			   if(isset($curlResponse_de)&&$curlResponse_de&&is_array($curlResponse_de)){
					if(isset($curlResponse_de['acquirer_status_code'])&&$curlResponse_de['acquirer_status_code']==2){ //success - Approved
						$_SESSION['approved_tr'][]=$value['transID'];
					}
					elseif(isset($curlResponse_de['acquirer_status_code'])&&$curlResponse_de['acquirer_status_code']==1){ //pending
						$_SESSION['pending_tr'][]=$value['transID'];
					}
					elseif(isset($curlResponse_de['acquirer_status_code'])&&$curlResponse_de['acquirer_status_code']=="-1"){ //failed - Declined
						$_SESSION['declined_tr'][]=$value['transID'];
					}else{ // Expired | Cancelled 
						$_SESSION['expired_tr'][]=$value['transID'];
					}
			   }
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
				var urlset ='{$data['Host']}/crons_status_c{$data['iex']}?pq=1&type={$value['acquirer']}{$related_sub}{$ct_sub}';
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
