<? 
// #!/var/www/html

/*

cron_host.do?pq=1&DB_CON=3&db_ad=1&t=1021770455

Cront is Host base script for check the pending status to be updated   

https://cronl1.web1.one/cron_host?pq=1&li=2&ex=1&related_skip=1&ts=1

https://cronl1.web1.one/cron_host_05_to_20_second
https://cronl1.web1.one/cron_host_20_to_30_second
https://cronl1.web1.one/cron_host_30_to_45_second
https://cronl1.web1.one/cron_host_45_to_90_second


gw/cron_host?pq=1&li=2&is=30&ex=1&related_skip=1

/cron_host?pq=1&li=10&ct=781&re=100&is=30
/cron_host?pq=1&li=10&ct=781&re=100&im=1
/cron_host?pq=1&li=10&day=0&day2=0&ct=781&re=100
/cron_host?pq=1&li=10&day=1&day2=1&ct=781&re=100


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

	cron_host?pq=1&o=d&li=2&day=2&day2=1&type=781&ct=781&re=9000
	cron_host?pq=1&o=d&li=2&day=2&day2=1&type=781&ct=781&re=100&&im=1

	cron_host?pq=1&o=d&li=2&day=1&type=781
	cron_host?pq=1&o=A&li=2&day=1&type=781&ct=781&re=1000
	cront.do?pq=1&o=d&li=2&day=1&type=69&ex=1
	cront.do?pq=1&li=2&day=1&type=48&ct=48&ex=1

http://localhost/gw/cron_host.do?pq=1&t=532111227654125400,462111177650132637
   
http://localhost/gw/cron_host.do?pq=1&ct=17&related=1

http://localhost/gw/cron/status_auto_update_42.php?l=1&pq=1

http://localhost/gw/cron_host.do?pq=1&ex=1
http://localhost/gw/cron_host.do?pq=1&t=2707984631,74107974556

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

if((isset($_SERVER["HTTP_HOST"]))&&($_SERVER["HTTP_HOST"]=='localhost'||$_SERVER["HTTP_HOST"]=='localhost:8080'||$_SERVER["HTTP_HOST"]=='localhost:98'||isset($_SESSION["http_host_loc"]))){	
	//check localhost or not, if yes then define localhost in data and set true
	$localhosts=true; 
	$data['localhosts']=true; 
}
else
$_SERVER["HTTPS"]='on';

$php_self1=$_SERVER['PHP_SELF'];

//echo "<br/>php_self1=>".$php_self1; print_r($_SERVER);

if ((strpos ( $php_self1, "lampp/htdocs" ) !== false)||(strpos ( $php_self1, "www/html" ) !== false)) {
	$rootPhp="/var/www/html/";
	
	//$rootPhp="/var/www/html/";
	$topLocation=1;
	
}else{
	$rootPhp="";
}

if(isset($data['rootPath'])){
	$rootPhp=$data['rootPath'];
}

if (strpos ( $php_self1, "status_2_auto_update" ) !== false) {
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
	$related=1;
	//$related=0;
}

if(isset($_REQUEST['related_qr_skip']))
	$related=0;
	


if(isset($_REQUEST['cron_host_response'])&&$_REQUEST['cron_host_response'])
	$cron_host_response=$_REQUEST['cron_host_response'];
else 
	$cron_host_response='RES';

if(isset($_GET['cron_host_response'])&&$_GET['cron_host_response'])
	$cron_host_response=$_GET['cron_host_response'];


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


if ((strpos ( $php_self1, "status_auto_update" ) !== false)||(strpos ( $php_self1, "cron_host_status_auto_update" ) !== false)) {
	
	//$data['Host']="https://test.test.com"; $_SERVER["HTTP_HOST"]="test.test.com";
	
	$data['Host']=$data['HostG'];
	$_SERVER["HTTP_HOST"]=$data['HostN'];
	$_SERVER["HTTPS"]='on';
	$urlpath=$php_self;
	$data['urlpath']=$urlpath;
	
	
	//$_SERVER["HTTPS"]='on';
	$host_path=$data['Host'];
}else{
	$host_path=$data['Host'];
}

//echo "<br/>IS_DBCON_DEFAULT=>".@$data['IS_DBCON_DEFAULT']."<br/>";

//$data['CONNECTION_TYPE_DEFAULT']='';

if((isset($data['DB_CON'])&&isset($_REQUEST['DB_CON'])&&$_REQUEST['DB_CON'])&&(!isset($data['IS_DBCON_DEFAULT'])|| $data['IS_DBCON_DEFAULT']!='Y')){
	
	$DB_CON=@$_REQUEST['DB_CON'];
	$db_ad=@$_REQUEST['db_ad'];
	$db_mt=@$_REQUEST['db_mt'];

	$link_db=config_db_more_check_link($DB_CON,$db_ad,$db_mt);
	$dbad_link_2=$link_db['dbad_link'].$link_db['dbad_link_2'];

	echo "<hr/><br/>Is not Default Connection & dbad_link_2=>".$dbad_link_2;
	print_r($link_db);
	
}


$data['pq']=0;
$ext="do";

if(isset($_REQUEST['l'])){
	$data['Host']="http://localhost/gw";
	$_SERVER["HTTP_HOST"]="http://localhost/gw";
	$host_path=$data['Host'];
}

//$host_path=$data['Host'];

//echo $data['Host'];exit;



if(isset($_REQUEST['pq'])){
	$data['pq']=$_REQUEST['pq'];
}
if(isset($_REQUEST['pop'])){
	$data['pop']=$_REQUEST['pop'];
}


//$data['pq']=0;

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
		elseif((isset($_REQUEST['type']))&&($_REQUEST['type'])){
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
		
		
		$notType='';
		if((isset($_REQUEST['notType']))&&($_REQUEST['notType'])){
			$notType=','.$_REQUEST['notType'];
			
			$r_status=" (`trans_status`=0 ) ";
			$r_type1 =" AND ( `trans_type` IN (11) ) ";
			$r_type .=" AND (`acquirer` NOT IN (0,1,2,3,4,5{$notType}) ) ";
			$r_limit="100";
		}
			
		
		
		$day='1';
		if(isset($_REQUEST['day'])){
			$day=$_REQUEST['day'];
		}	
		
		$date_1st=(date('Y-m-d',strtotime("-{$day} days")));
		$date_2nd=date('Y-m-d');
		
		if(isset($_REQUEST['day2'])&&$_REQUEST['day2']&&$_REQUEST['day2']<=$day)
		{
			$day2=$_REQUEST['day2'];
			$date_2nd=(date('Y-m-d',strtotime("-{$day2} days")));
		}
		
		
		
		//is greater than second or minute from tdate
		
		if(isset($_REQUEST['is2'])&&$_REQUEST['is2']>0){
			
			$up1=(int)$_REQUEST['is2'];
			if($data['connection_type']=='PSQL')
				$qr_interval= "'{$up1} second' ";
			else $qr_interval= "{$up1} second";
			
			$r_status.="  AND  ( `tdate` > now() - interval {$qr_interval}  )  ";
			
		}
		elseif(isset($_REQUEST['im2'])&&$_REQUEST['im2']>0){
			$up1=(int)$_REQUEST['im2'];
			if($data['connection_type']=='PSQL')
				$qr_interval= "'{$up1} minute' ";
			else $qr_interval= "{$up1} minute";
			
			$r_status.="  AND  ( `tdate` >= now() - interval {$qr_interval}  )  ";
		}
		
		//is less than second or minute from tdate
		if(isset($_REQUEST['is'])&&$_REQUEST['is']>0){
			
			$up1=(int)$_REQUEST['is'];
			if($data['connection_type']=='PSQL')
				$qr_interval= "'{$up1} second' ";
			else $qr_interval= "{$up1} second";
			
			$r_status.="  AND  ( `tdate` < now() - interval {$qr_interval}  )  ";
			
		}
		elseif(isset($_REQUEST['im'])&&$_REQUEST['im']>0){
			$up1=(int)$_REQUEST['im'];
			if($data['connection_type']=='PSQL')
				$qr_interval= "'{$up1} minute' ";
			else $qr_interval= "{$up1} minute";
			
			$r_status.="  AND  ( `tdate` <= now() - interval {$qr_interval}  )  ";
			
		}
		elseif(isset($_REQUEST['im'])&&$_REQUEST['im']==2){
			$r_status.="  AND  ( `tdate` <= now() - interval 2 minute )  ";
		}elseif(isset($_REQUEST['im'])&&$_REQUEST['im']==5){
			$r_status.="  AND  ( `tdate` <= now() - interval 5 minute )  ";
		}
		elseif(isset($_REQUEST['mfrom'])&&isset($_REQUEST['mto'])&&$_REQUEST['mfrom']>0&&$_REQUEST['mto']>0&&$_REQUEST['mfrom']>=$_REQUEST['mto'])
		{ // minutes duration in tdate
			
			// if ( 1-5: $_REQUEST['mfrom']=5; $_REQUEST['mto']=1; ) 

			$mfrom=@$_REQUEST['mfrom'];
			$mto=@$_REQUEST['mto'];
			
			$date_1st=(date('Y-m-d H:i:s',strtotime("-{$mfrom} minutes")));
			$date_2nd=(date('Y-m-d H:i:s',strtotime("-{$mto} minutes")));
			
			
			$r_status.=" AND ( `tdate` BETWEEN '{$date_1st}' AND '{$date_2nd}' )  ";

		}
		elseif(isset($_REQUEST['sfrom'])&&isset($_REQUEST['sto'])&&$_REQUEST['sfrom']>0&&$_REQUEST['sto']>0&&$_REQUEST['sfrom']>=$_REQUEST['sto'])
		{ // second duration in tdate
			
			// if ( 20-27: $_REQUEST['sfrom']=27; $_REQUEST['sto']=20; ) 

			$sfrom=@$_REQUEST['sfrom'];
			$sto=@$_REQUEST['sto'];
			
			$date_1st=(date('Y-m-d H:i:s',strtotime("-{$sfrom} seconds")));
			$date_2nd=(date('Y-m-d H:i:s',strtotime("-{$sto} seconds")));
			
			
			$r_status.=" AND ( `tdate` BETWEEN '{$date_1st}' AND '{$date_2nd}' )  ";

		}
		elseif(isset($_REQUEST['ts'])&&$_REQUEST['ts']>0)
		{
			
			// if &ts=1 for 20sec to 30sec,  &ts=2 for 30sec to 45sec and  &ts=3 for 45sec to 90sec from tdate

			
			if(isset($_REQUEST['ts'])&&$_REQUEST['ts']==1) {
				$date_1st=(date('Y-m-d H:i:s',strtotime("-30 seconds")));
				$date_2nd=(date('Y-m-d H:i:s',strtotime("-20 seconds")));
			}
			elseif(isset($_REQUEST['ts'])&&$_REQUEST['ts']==2) {
				$date_1st=(date('Y-m-d H:i:s',strtotime("-45 seconds")));
				$date_2nd=(date('Y-m-d H:i:s',strtotime("-30 seconds")));
			}
			elseif(isset($_REQUEST['ts'])&&$_REQUEST['ts']==3) {
				$date_1st=(date('Y-m-d H:i:s',strtotime("-90 seconds")));
				$date_2nd=(date('Y-m-d H:i:s',strtotime("-45 seconds")));
			}
			elseif(isset($_REQUEST['ts'])&&$_REQUEST['ts']==11) {
				$date_1st=(date('Y-m-d H:i:s',strtotime("-20 seconds")));
				$date_2nd=(date('Y-m-d H:i:s',strtotime("-05 seconds")));
			}
			else {
				$date_1st=(date('Y-m-d H:i:s',strtotime("-300 seconds")));
				$date_2nd=(date('Y-m-d H:i:s',strtotime("-90 seconds")));
			}
			
			$r_status.=" AND ( `tdate` BETWEEN '{$date_1st}' AND '{$date_2nd}' )  ";
		}
		else 
		{
			if(!isset($_REQUEST['t']))  
			//$r_status.=" AND ( `tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) )  ";
			//$r_status.=" AND ( `tdate` BETWEEN (".date_format_return("'".$date_1st." 00:00:00'",2).") AND (".date_format_return("'".$date_2nd." 23:59:59'",2).") )  ";
			$r_status.=" AND ( `tdate` BETWEEN '{$date_1st} 00:00:00' AND '{$date_2nd} 23:59:59' )  ";
		}
		
		/*
		if(isset($_REQUEST['j'])&&$_REQUEST['j']){
			$r_status.=" AND (`json_value` != ''  AND  `json_value` != '[]'    AND  `json_value` != '{}'  AND  `json_value` IS NOT NULL )  ";
		}
		*/
		
		//page set 
		if(isset($_REQUEST['li'])&&$_REQUEST['li']){
			$r_limit=$_REQUEST['li'];
		}
		
		if(isset($_REQUEST['page'])&&$_REQUEST['page']>0&&$r_limit>0){
			$page=(int)$r_limit * (int)$_REQUEST['page'];
			$r_limit=$page.','.$r_limit;
		}
		
		if(!empty($r_limit)){
			$r_limit='LIMIT '.$r_limit;
			
			if(isset($_REQUEST['pg'])) echo "<br/>r_limit=>".@$r_limit;
			
			$r_limit=query_limit_return($r_limit);
		}
		
		if(isset($_REQUEST['pg'])) {
			echo "<br/>r_limit=>".@$r_limit;
			echo "<br/>page=>".@$page."<br/><br/>";
		}
		
		echo "<br/><br/>NOW=>".@(new DateTime())->format('Y-m-d H:i:s.u')."<br/><br/>";
		
		if($related){
			$related=$related-1;
			if($related>0)
			$r_type.=" AND  ( `transaction_flag`='{$related}' ) ";
			else $r_type.=" AND  ( `transaction_flag` IS NULL ) ";
		}

		if(isset($_REQUEST['t'])&&$_REQUEST['t']){
			
			$transactionId=$_REQUEST['t'];
			
			$r_status=" ( `transID` IN ({$transactionId}) ) ";
			
			$r_type=" ";
			$r_type1=" ";
			$r_limit=" ";

			$_REQUEST['related_skip']=1;

			echo "<hr/><br/>transID=>".$transactionId;
			echo "<br/><br/><hr/>";
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
			" ".$r_limit.
			" ",$data['pq']
		);
		
	//	exit;
			
		$tra_count_get=count($tra);
		echo "<hr/>count=>".$tra_count_get."<hr/>";
		$tra_count=(int)$tra_count_get;
		
		if(isset($_REQUEST['ex'])&&$_REQUEST['ex']==1)
		{
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
			
			$related_plus=(int)$value['transaction_flag']+1;
			
			$transID_id=$value['transID']."_".$value['id'];
			$transID=$value['transID'];
			
			$data_send=array();
			$data_send['transID']=$transID_id;
			$data_send['acquirer']=$value['acquirer'];
			$data_send['tdate']=$value['tdate'];
			$data_send['bank_processing_amount']=$value['bank_processing_amount'];
			$data_send['bill_amt']=$value['bill_amt'];
			$data_send['bill_email']=$value['bill_email'];
			//$data_send['actionurl']='admin_direct';
			//$data_send['admin']='1';
			$data_send['check_auth']='cron_tab';
			$data_send['cron_tab']='cron_tab';
			$data_send['cron_host_response']=$cron_host_response;
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
			
		
		
			if(isset($_REQUEST['t'])&&$_REQUEST['t']&&($value['trans_status']!=0))
			{
				db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `trans_status`='0'  WHERE `id`={$value['id']}  ",$data['pq']);
			}
			elseif( ($value['transaction_flag']==$related) || ($cron_time==2) || (isset($_SESSION['t_id_all'])&&in_array($value['transID'],$_SESSION['t_id_all'])) ){
				if(isset($_REQUEST['related_skip'])&&@$_REQUEST['related_skip']) {
					//echo "<br/>related_skip=>".@$_REQUEST['related_skip'];
				} else 
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
			if(!isset($_REQUEST['ct'])&&in_array($value['acquirer'],["404"])&&$data_tdate<$current_3days_back){
				$use_curl_updt = 0;
				db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`"." SET `trans_status`='22'  WHERE `id`={$value['id']}  ",$data['pq']);
			}
			
			
			
			if($data['pq']){
				
				
				echo "<br/><br/>data_tdate=>".date('d-m-Y H:i:s', strtotime($value['tdate']));
				echo "<br/>current_date=>".date('d-m-Y H:i:s A');
				echo "<br/>related_plus=>".$related_plus;
			} 
		
		
		//if((isset($json_value2['status_'.$value['acquirer']]))&&(strpos($json_value2['status_'.$value['acquirer']], "status")!==false)&&($cron_time==0)&&($use_curl_updt))
			
		
		//$qp_pr='&qp=1';
		$qp_pr='';

		$surl=$data['Host']."/status{$data['ex']}?transID={$transID}&type={$value['acquirer']}&check_auth=cron_tab&cron_tab=cron_tab&cron_host_response={$cron_host_response}&tr_id={$value['id']}&tdateSkip=tdateSkip&action=webhook".(isset($dbad_link_2)&&trim($dbad_link_2)?$dbad_link_2:'').@$qp_pr;
				
		$curlResponse=use_curl($surl,$data_send);
				
		if($data['pq'])
		{
			echo "<hr/><br/>{$j}. surl=>".$surl;echo "<br/><br/>curlResponse=>".$curlResponse; echo "<br/><br/>";
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
	
		//if($data['pq'] || (isset($_REQUEST['log'])&&$_REQUEST['log']))
		if(isset($_REQUEST['logf'])&&$_REQUEST['logf'])
		{
			echo "<br/><hr/><br/><==t_id==><br/>".implode(",",$t_id);
			
			echo "<br/><br/><hr/><br/><==APPROVED==>".count($_SESSION['approved_tr'])."<br/>".implode(",",$_SESSION['approved_tr']);
			echo "<br/><br/><hr/><br/><==PENDING==>".count($_SESSION['pending_tr'])."<br/>".implode(",",$_SESSION['pending_tr']);
			echo "<br/><br/><hr/><br/><==DECLINED==>".count($_SESSION['declined_tr'])."<br/>".implode(",",$_SESSION['declined_tr']);
			echo "<br/><br/><hr/><br/><==EXPIRED==>".count($_SESSION['expired_tr'])."<br/>".implode(",",$_SESSION['expired_tr']);
			
			if($data['pq']) 
				echo "<br/><br/><hr/><br/><==All t_id==>".count($_SESSION['t_id_all'])."<br/>".implode(",",$_SESSION['t_id_all']);
			
			echo "<br/><br/><hr/>";
		}
		
				
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

