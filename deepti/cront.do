<? 
/*

Cront is Host base script for check the pending status to be updated   


https://pay.letspe.com/cront?pq=1&li=10&ct=781&re=100&im=1
https://pay.letspe.com/cront?pq=1&li=10&day=0&day2=0&ct=781&re=100
https://pay.letspe.com/cront?pq=1&li=10&day=1&day2=1&ct=781&re=100


&ct=781 // acquirer number  
&re=100 // repeated auto run time for micro second 
&im=1 // befor of 1 minute interval time from tdate  
&is=30 // befor of 30 second interval time from tdate  
&li=10 // number of start for per 10 records list 
&pq=1 // print the query in page 
&day=1 // from date to 1 day befor from current date 
&day2=0 // to date to 0 day befor from current date 
&o=d // border by select as per d is Descending or a is Ascending to tdate trans 

Some how break due to Error":"5001","Message":"HTTP Status is 500 and returned 0 so that re again hit to url 

*/

//if(!isset($_SESSION)){session_start();} 

/*

	cront?pq=1&o=d&li=2&day=2&day2=1&type=781&ct=781&re=9000
	cront?pq=1&o=d&li=2&day=2&day2=1&type=781&ct=781&re=100&&im=1

	cront?pq=1&o=d&li=2&day=1&type=781
	cront?pq=1&o=A&li=2&day=1&type=781&ct=781&re=1000
	cront.do?pq=1&o=d&li=2&day=1&type=69&ex=1
	cront.do?pq=1&li=2&day=1&type=48&ct=48&ex=1

http://localhost/gw/cront.do?pq=1&t=532111227654125400,462111177650132637
   
http://localhost/gw/cront.do?pq=1&ct=17&related=1

http://localhost/gw/cron/status_auto_update_42.php?l=1&pq=1

http://localhost/gw/cront.do?pq=1&ex=1
http://localhost/gw/cront.do?pq=1&t=2707984631,74107974556

*/

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

		echo "<h1 style='text-align: center;'>".@$title."</h1>";
		echo "<h5 style='text-align: center;'>".@$description."</h5>";
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

$order_by=" ORDER BY `tdate` DESC ";
if((isset($_REQUEST['o']))&&($_REQUEST['o'])&&$_REQUEST['o']=='a'){
	$order_by=" ORDER BY `tdate` ASC ";  
}elseif((isset($_REQUEST['o']))&&($_REQUEST['o'])&&$_REQUEST['o']=='d'){
	$order_by=" ORDER BY `tdate` DESC ";  
}elseif((isset($_REQUEST['o']))&&($_REQUEST['o'])&&$_REQUEST['o']=='n'){
	$order_by='';
}
	
//echo "<hr/>list rootPhp=>".$rootPhp."<hr/>";	

include($rootPhp.'config_db.do');
include($rootPhp.'include/browser_os_function'.$data['iex']);
$browserOs1=browserOs("1"); $browserOs=json_encode($browserOs1);
//echo $browserOs;exit;

if ((strpos ( $php_self, "status_auto_update" ) !== false)||(strpos ( $php_self, "status_2_auto_update" ) !== false)) {
	
	//$data['Host']="https://test.test.com"; $_SERVER["HTTP_HOST"]="test.test.com";
	
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
	$r_type1=" ";
	$r_type=" ";
	$r_status="  (`trans_status`=0 )  ";
	$r_limit="100"; 

		// transaction list ---------------------------------
		
		if($cron_time==2){
			$r_status=" ( `trans_status`=0 ) ";
			$r_type="  AND  ( `acquirer` IN ({$_REQUEST['type']}) )  ";
			$r_limit="1"; 
			if($related==0){
				$related=1;
			}
		}
		elseif((isset($_GET['type']))&&($_GET['type'])){
			$r_status=" ( `trans_status`=0 ) ";
			$r_type1=" AND ( `trans_type` IN (11) ) ";
			$r_type="  AND  ( `acquirer` IN ({$_REQUEST['type']}) )  ";
			$r_limit="100";
		}
		elseif(isset($data['cron_account_type'])&&$data['cron_account_type']=='42'){
		
			$r_status=" ( `trans_status`=0 ) ";
			$r_type="  AND  ( `acquirer` IN (42) )  ";
			$r_limit="100";
		
		}
		elseif(isset($_GET['t'])&&$_GET['t']){
			
			$transactionId=$_GET['t'];
			
			$r_status=" ( `transID` IN ({$transactionId}) ) ";
			
			$r_type=" ";
			$r_type1=" ";
			$r_limit=" 300 ";
		}
		
		$notType='';
		if((isset($_GET['notType']))&&($_GET['notType'])){
			$notType=','.$_GET['notType'];
			
			$r_status=" (`trans_status`=0 ) ";
			$r_type1 =" AND ( `trans_type` IN (11) ) ";
			$r_type .=" AND (`acquirer` NOT IN (0,1,2,3,4,5{$notType}) ) ";
			$r_limit="100";
		}
			
		
		
		$day='1';
		if(isset($_GET['day'])){
			$day=$_GET['day'];
		}	
		
		$date_1st=(date('Y-m-d',strtotime("-{$day} days")));
		$date_2nd=date('Y-m-d');
		
		if(isset($_GET['day2'])&&$_GET['day2']&&$_GET['day2']<=$day)
		{
			$day2=$_GET['day2'];
			$date_2nd=(date('Y-m-d',strtotime("-{$day2} days")));
		}
		
		if(isset($_GET['is'])&&$_GET['is']>0){
			
			$up1=(int)$_GET['is'];
			if($data['connection_type']=='PSQL')
				$qr_interval= "'{$up1} second' ";
			else $qr_interval= "{$up1} second";
			
			$r_status.="  AND  ( `tdate` < now() - interval {$qr_interval}  )  ";
			
		}
		elseif(isset($_GET['im'])&&$_GET['im']>0){
			$up1=(int)$_GET['im'];
			if($data['connection_type']=='PSQL')
				$qr_interval= "'{$up1} minute' ";
			else $qr_interval= "{$up1} minute";
			
			$r_status.="  AND  ( `tdate` <= now() - interval {$qr_interval}  )  ";
		}
		elseif(isset($_GET['im'])&&$_GET['im']==2){
			$r_status.="  AND  ( `tdate` <= now() - interval 2 minute )  ";
		}elseif(isset($_GET['im'])&&$_GET['im']==5){
			$r_status.="  AND  ( `tdate` <= now() - interval 5 minute )  ";
		}
		else {
			if(!isset($_GET['t']))  
			//$r_status.=" AND ( `tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) )  ";
			//$r_status.=" AND ( `tdate` BETWEEN (".date_format_return("'".$date_1st." 00:00:00'",2).") AND (".date_format_return("'".$date_2nd." 23:59:59'",2).") )  ";
			$r_status.=" AND ( `tdate` BETWEEN '{$date_1st} 00:00:00' AND '{$date_2nd} 23:59:59' )  ";
		}
		
		/*
		if(isset($_GET['j'])&&$_GET['j']){
			$r_status.=" AND (`json_value` != ''  AND  `json_value` != '[]'    AND  `json_value` != '{}'  AND  `json_value` IS NOT NULL )  ";
		}
		*/
		
		
		if(isset($_GET['li'])&&$_GET['li']){
			$r_limit=$_GET['li'];
		}
		
		if($related){
			$related=$related-1;
			if($related>0)
			$r_type.=" AND  ( `transaction_flag`={$related} ) ";
			else $r_type.=" AND  ( `transaction_flag` IS NULL ) ";
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
			"SELECT `id`, `transID`, `tdate`, `acquirer`, `trans_status`, `merID`,`bill_amt`,`bank_processing_amount`,`bill_email`,`transaction_flag`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE ".$r_status.
			" ".$r_type1.$r_type.$order_by.
			//" ORDER BY tdate DESC". //	ASC	DESC
			" LIMIT ".$r_limit.
			" ",$data['pq']
		);
		
	//	exit;
			
		$tra_count_get=count($tra);
		echo "<hr/>count=>".$tra_count_get."<hr/>";
		$tra_count=(int)$tra_count_get;
		
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
			
			$related_plus=$value['transaction_flag']+1;
			
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
			$data_send['cron_host_response']='response';
				$data_send['tr_id']=$value['id'];
				$data_send['tdateSkip']='tdateSkip';
			
			$t_id[]=$value['transID'];
			
			
			if($data['pq']){
				echo "<br/><br/><br/>{$j}. data_send=>";print_r($data_send);echo "<br/>";
			}
			
			$current_date_10m=date('YmdHis', strtotime("-10 minutes"));
			$current_date_30m=date('YmdHis', strtotime("-30 minutes"));
			$current_3days_back =date('YmdHis', strtotime("-3 days"));
			//$current_3days_back =date('YmdHis', strtotime("-5 hours"));
			$current_date_2h=date('YmdHis', strtotime("-2 hours"));
			$current_date_6h=date('YmdHis', strtotime("-6 hours"));
			$data_tdate=date('YmdHis', strtotime($value['tdate']));
			
		
		
			if( ($value['transaction_flag']==$related) || ($cron_time==2) || (isset($_SESSION['t_id_all'])&&in_array($value['transID'],$_SESSION['t_id_all'])) ){
				
				db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `transaction_flag`={$related_plus}  WHERE `id`={$value['id']}  ",$data['pq']);
				
			}
			
			
			$_SESSION['t_id_all'][]=$value['transID'];
			
			// if test transaction is pending for update by status of 9
			/*
			$tr_json_value_str=@$value['json_value'];
			$tr_json_value_str=jsonreplace($tr_json_value_str);
			$is_test=jsonvaluef($tr_json_value_str,'is_test');
			if(isset($is_test)&&$is_test=="9"&&$data_tdate<$current_date_30m){
				db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `trans_status`='9'  WHERE `id`={$value['id']}  ",$data['pq']);
			}
			*/
			
			// 404 : Mark them expired without changing the date if the transaction is 3 days or more
			if(!isset($_GET['ct'])&&in_array($value['acquirer'],["404"])&&$data_tdate<$current_3days_back){
				$use_curl_updt = 0;
				db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `trans_status`='22'  WHERE `id`={$value['id']}  ",$data['pq']);
			}
			
			
			
			if($data['pq']){
				echo "<br/>data_tdate=>".(int)$data_tdate; 
				echo "<br/>current_date_2h=>".(int)$current_date_2h;
				
				echo "<br/><br/>data_tdate=>".date('d-m-Y H:i:s', strtotime($value['tdate']));
				echo "<br/>current_date_2h=>".date('d-m-Y H:i:s A', strtotime($current_date_2h));
				echo "<br/>current_date=>".date('d-m-Y H:i:s A');
				echo "<br/>related_plus=>".$related_plus;
			} 
		
		
		//if((isset($json_value2['status_'.$value['acquirer']]))&&(strpos($json_value2['status_'.$value['acquirer']], "status")!==false)&&($cron_time==0)&&($use_curl_updt))
		
		if(($cron_time==0)&&($use_curl_updt))
		{			
			if($data_tdate<$current_date_30m){
				
				$surl=$data['Host']."/status{$data['ex']}?transID={$transID}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&&cron_tab=cron_tab&cron_host_response=res&tr_id={$value['id']}&tdateSkip=tdateSkip&action=webhook";
				
				$curlResponse=use_curl($surl,$data_send);
										
				//if($data['pq'])
				{
					echo "<hr/><br/>{$j}. surl=>".$surl;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
				$crontab_url = 0;
			}
		}
		else{
			$crontab_url = 1;
		}
		if($crontab_url&&$use_curl_updt){
			
			if($cron_time==2){
			   //echo "<br/>ooo=>";
				if($data_tdate<$current_date_10m){
					if(($value['acquirer']==27)||((isset($_REQUEST['ct']))&&($_REQUEST['ct']))){
						//processed_acquirer_type
					
						$surl_27=$data['Host']."/status{$data['ex']}?transID={$transID}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res&tr_id={$value['id']}&tdateSkip=tdateSkip&action=webhook";
						$curlResponse=use_curl($surl_27,$data_send);
				
						//echo "<br/>transID_id=>".$transID_id;
						
						//if($data['pq'])
						{
							echo "<hr/><br/>{$j}. surl=>".$surl_27;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
					}
				}
			}
			else{
			  //echo "<br/>3333=>";
				
				if($data_tdate<$current_date_30m){
						
					if($value['acquirer']==15){
						//$surl_15=$data['Host']."/hkip_status{$data['ex']}?mh_oid={$transID}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
						
						$surl_15=$data['Host']."/status{$data['ex']}?transID={$transID}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res&tr_id={$value['id']}&tdateSkip=tdateSkip";
						
						$curlResponse=use_curl($surl_15,$data_send);
						
						//if($data['pq'])
						{
							echo "<hr/><br/>{$j}. surl=>".$surl_15;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
					}
					
				}
				
				if($data_tdate<$current_date_30m){
						
					if($value['acquirer']==16){
						$surl_16=$data['Host']."/hkip_status{$data['ex']}?mh_oid={$transID}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res&tdateSkip=tdateSkip";
						$curlResponse=use_curl($surl_16,$data_send);
						
						//if($data['pq'])
						{
							echo "<hr/><br/>surl=>".$surl_16;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
					}
					
					if($value['acquirer']==18){
						$surl_18=$data['Host']."/payin/pay18/processed{$data['ex']}?transID={$transID}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res&tdateSkip=tdateSkip";
						$curlResponse=use_curl($surl_18,$data_send);
						
						//if($data['pq'])
						{
							echo "<hr/><br/>surl=>".$surl_18;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
					}
					
					if($value['acquirer']==19){
						$surl_19=$data['Host']."/payin/pay19/processed{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res&tdateSkip=tdateSkip";
						$curlResponse=use_curl($surl_19,$data_send);
						
						//if($data['pq'])
						{
							echo "<hr/><br/>surl=>".$surl_19;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
					}
					
					if($value['acquirer']==31){
						
						$surl_31=$data['Host']."/status{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res&tr_id={$value['id']}&tdateSkip=tdateSkip";
						$curlResponse=use_curl($surl_31,$data_send);
						
						//if($data['pq'])
						{
							echo "<hr/><br/>surl=>".$surl_31;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
						
					}
					
					
					
					
					if($value['acquirer']==22){
						$surl_22=$data['Host']."/update_status{$data['ex']}?mh_oid={$transID_id}&transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
						$curlResponse=use_curl($surl_22,$data_send);
						
						//if($data['pq'])
						{
							echo "<hr/><br/>surl=>".$surl_22;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
					} 
					
					
					
					//34 AdvCasBitCoins  341 AdvCasWalet
					if($value['acquirer']==34 || $value['acquirer']==341 || $value['acquirer']==342){
						$surl_advcash=$data['Host']."/payin/34/processed_url{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
						$curlResponse=use_curl($surl_advcash,$data_send);
						
						//if($data['pq'])
						{
							echo "<hr/><br/>surl=>".$surl_advcash;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
					}
					
					//35:351-381 allPayX
					if(($value['acquirer']==35) || ($value['acquirer'] > 350 && $value['acquirer'] < 381)){
						$surl_allpayx=$data['Host']."/payin/pay35/processed{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
						$curlResponse=use_curl($surl_allpayx,$data_send);
						
						//if($data['pq'])
						{
							echo "<hr/><br/>surl=>".$surl_allpayx;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
					} 
					/*
					//38:380-410 payop
					if(($value['acquirer']==38) || ($value['acquirer'] > 380 && $value['acquirer'] < 410)){
						$surl_payop=$data['Host']."/payin/proc38/processed{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
						$curlResponse=use_curl($surl_payop,$data_send);
						
						if($data['pq']){
							echo "<br/>curlResponse=>".$curlResponse; echo "<br/>surl_payop=>".$surl_payop;echo "<br/>";
						}
					}
					*/

					//30 merchant.gate.express
					if(($value['acquirer']==30)){
						$surl_30=$data['Host']."/payin/pay30/processed{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
						$curlResponse=use_curl($surl_30,$data_send);
						
						//if($data['pq'])
						{
							echo "<hr/><br/>surl=>".$surl_30;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
					}

					//37 cashu
					if(($value['acquirer']==37)){
						$surl_37=$data['Host']."/payin/pro37/processed{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
						$curlResponse=use_curl($surl_37,$data_send);
						
						//if($data['pq'])
						{
							echo "<hr/><br/>surl=>".$surl_37;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
						}
					}



					
				} 
				
				
			
			}
			
			//48 Budpay
			if(($value['acquirer']==48)&&($cron_time==0)){
				
				$surl_48=$data['Host']."/payin/pay48/status_48{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_48,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_48;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
				
			} 
			
			
			//345 mcPayment card payment
			if(($value['acquirer']==345 || $value['acquirer']==346 || $value['acquirer']==347)){
				
				$surl_34=$data['Host']."/payin/pay34/status_34{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_34,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_34;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
				
			} 
			
			
			//48 Budpay
			if(($value['acquirer']==46)){
				
				$surl_46=$data['Host']."/payin/pay46/status46{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_46,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_46;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
				
			}
			
			//NEW MCP //40 and 401 to 409
			if(($value['acquirer']==40)||($value['acquirer']>400&&$value['acquirer']<410)){
				
				$surl_mcp=$data['Host']."/payin/pay40/status_40{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_mcp,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_mcp;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
				
			}
			
			//52:521-590 cashfree
			if(($value['acquirer']==52) || ($value['acquirer'] > 520 && $value['acquirer'] < 530)){
				$surl_cashfree=$data['Host']."/payin/3d52/processed{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_cashfree,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_cashfree;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
			}
			
			if(($value['acquirer']==53) || ($value['acquirer'] > 530 && $value['acquirer'] < 540)){
				$surl_cashfree_53=$data['Host']."/payin/pay53/qrcode53{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				
				$curlResponse=use_curl($surl_cashfree_53,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_cashfree_53;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
			}
			
			//60:paytm
			if($value['acquirer']==60){
				$surl_60=$data['Host']."/payin/pay60/status{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_60,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_60;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
			}
			
			//60:paytm by raj
			if($value['acquirer']==601||$value['acquirer']==602||$value['acquirer']==603||$value['acquirer']==604){
				$surl_601=$data['Host']."/payin/pay60/status601{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_601,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_601;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
			}
			
			
			//61:661-689 atom
			if(($value['acquirer']==61) || ($value['acquirer'] > 610 && $value['acquirer'] < 620)){
				$surl_atom=$data['Host']."/payin/pay61/status{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_atom,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_atom;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
			}
			
			
			if($value['acquirer']==343){
				$surl_343=$data['Host']."/payin/pro343/processed{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_343,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_343;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
			}
			
			if($value['acquirer']==171){
				$surl_17=$data['Host']."/payin/cont17/processed{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_17,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_17;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
			}
			//24:Dixonpay
			if($value['acquirer']==24){
				$surl_24=$data['Host']."/update_status24{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
				$curlResponse=use_curl($surl_24,$data_send);
				
				//if($data['pq'])
				{
					echo "<hr/><br/>surl=>".$surl_24;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
				}
			}
			
			if($data_tdate<$current_date_30m){
			//if((int)$data_tdate<(int)$current_date_2h){
				
				if($value['acquirer']==42){
					$surl_42=$data['Host']."/payin/pay42/processed{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
					$curlResponse=use_curl($surl_42,$data_send);
					
					//if($data['pq'])
					{
						echo "<hr/><br/>surl=>".$surl_42;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
					}
				} 
				
				if($value['acquirer']==43 || $value['acquirer']==431){ // Gumball by raj
					$surl_43=$data['Host']."/payin/pay43/status{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
					$curlResponse=use_curl($surl_43,$data_send);
					
					//if($data['pq'])
					{
						echo "<hr/><br/>surl=>".$surl_43;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
					}
				}
				
				if($value['acquirer']==44){ //new Opay by raj
					$surl_44=$data['Host']."/payin/pay44/status{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
					$curlResponse=use_curl($surl_44,$data_send);
					
					//if($data['pq'])
					{
						echo "<hr/><br/>surl=>".$surl_44;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
					}
				}
				
				if($value['acquirer']==45 || $value['acquirer']==451){ //picsell by raj
					$surl_45=$data['Host']."/payin/pay45/status{$data['ex']}?transID={$transID_id}&type={$value['acquirer']}&actionurl=admin_direct&admin=1&cron_tab=cron_tab&cron_host_response=res";
					$curlResponse=use_curl($surl_45,$data_send);
					
					//if($data['pq'])
					{
						echo "<hr/><br/>surl=>".$surl_45;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
					}
				}
				
			}
			
			
//echo $j.". receiver=>".$value['receiver'].", sender=>".$value['sender'].", type=>".$value['acquirer'].", id=>".$value['id'].", tdate=>".$value['tdate'].", transID=>".$value['transID']."<br/>";
			
		  }
		  
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
		
		
				
		//exit;
		
		if(isset($tra_count)&&$tra_count==0)
		{
			
		}
		elseif(isset($_REQUEST['ct'])&&trim($_REQUEST['ct'])){
			
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
						top.document.location.href=top.document.location.href;
					}
				}, timeOut ); //120000
			</script>";
			
		}
		
		
	
exit;
//--------------------------------------------

		
		
	
		
	

?>

