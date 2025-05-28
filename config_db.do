<?
$iex='.do';
$data['phpv']=(int)phpversion();		//define php version
$data['all_host']=array();				//define array
$data['ex']=''; $data['css']='';$data['js']='';	//Initialized variables with null or empty
$data['css']='.css';$data['js']='.js';		//define js and css extension
$data['ex']='.do';					//define file extension
$data['iex']=$iex;					//define extension for include files
$data['FrontUI']='front_ui';		//define ui path
$data['Path']=dirname(__FILE__);	//define root directory path

if((int)phpversion()>5){
	$data['connection_type']='MYSQLI'; // MYSQLI MYSQL	PDO
	$data['phpv5']=false;
}else{
	$data['connection_type']='MYSQL'; // MYSQLI MYSQL	PDO
	$data['phpv5']=true;
}
	
if(isset($_GET['dtest'])&&$_GET['dtest']==1){
	error_reporting(-1); // reports all errors
	ini_set("display_errors", "1"); // shows all errors
	ini_set("log_errors", 1);
	ini_set("error_log", "log/php-error.log");
	//set_time_limit(10);
}else{
	if($data['phpv5']){	
		error_reporting(E_ERROR | E_WARNING | E_PARSE);		//Sets which PHP errors are reported
		set_magic_quotes_runtime(0);
		ignore_user_abort(true);		//Set whether a client disconnect should abort script execution
	}else{
		ignore_user_abort(true);		//Set whether a client disconnect should abort script execution
		error_reporting(0);				// Turn off all error reporting
		//error_reporting(E_ERROR | E_WARNING | E_PARSE);
		ini_set("error_log", "log/php-error.log");
	}
}
## ini_set('mysql.connect_timeout', 600);
## ini_set('default_socket_timeout', 600);
ini_set('memory_limit', '-1');



if(!isset($_SESSION)){
	//session_regenerate_id(true);
	session_start();
	//session_regenerate_id(true);
}		//Start new or resume existing session



// session fixation when required going to PCI-DSS compliance
function start_session() {
        if(session_status() == PHP_SESSION_ACTIVE)
        {
                session_regenerate_id();
        }
    //if(!session_id())
        if(!isset($_SESSION))
        {
                session_regenerate_id(true);
                session_start();
                //session_regenerate_id();


        $currentCookieParams = session_get_cookie_params();
        //$sidvalue = session_id().microtime();
        //$sidvalue = session_id();
        $sidvalue = session_id(sha1(uniqid(microtime())));

        setcookie(
            'PHPSESSID',//name
            $sidvalue,//value
            0,//expires at end of session
            $currentCookieParams['path'],//path
            $currentCookieParams['domain'],//domain
            true //secure
        );

                $_SESSION['useragent'] = md5($_SERVER['HTTP_USER_AGENT']);
    }
	if(session_status() == PHP_SESSION_ACTIVE)
	{
			session_regenerate_id(true);
			//session_regenerate_id();
	}
}

//start_session();



##################################################################

function explode1($explode=',',$str='',$no=-1){
	$array=array();
	if($str){	
		$array=explode($explode, $str);	//Split a string by a string (explode)
		if($no!=-1){
			return $array[$no];
		}else{
			return $array;
		}
	}else{
		return $str;
	}
}

##################################################################

/*

$_SESSION['forwarded_ip']=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
if(strpos($_SESSION['forwarded_ip'],',')!==false){
	$c_ip_ex=explode1(',',$_SESSION['forwarded_ip']);
	$_SESSION['forwarded_ip']=$c_ip_ex[0];
}
if(!isset($_SERVER['HTTP_X_FORWARDED_PORT'])){
	$dataDb['db_ip_count']=20;
	$file_create_htaccess_2=($data['Path'].'create_htaccess.do');
	if(file_exists($file_create_htaccess_2)){	
		include($file_create_htaccess_2);exit;
	}
}

*/

##################################################################
//setcookie("hostOnly", "false");
//setcookie("session", "false");
//setcookie("PHPSESSID", "false");

/*
$name1 = 'language';
$value1 = 'english';
$expire1 = time() + 60*60*24*3; // 3 days from now
$path1 = '/';
$domain1 = $_SERVER["HTTP_HOST"];
$secure1 = isset($_SERVER['HTTPS']); // or use true/false
$httponly1 = true;

setcookie($name1, $value1, $expire1, $path1, $domain1, $secure1, $httponly1);

if (isset($_COOKIE['PHPSESSID'])) {
	unset($_COOKIE['PHPSESSID']);
	setcookie('PHPSESSID', '', time() - 3600, '/'); // empty value and old timestamp
}
if(isset($_COOKIE)){
	foreach($_COOKIE as $cook) {
		setcookie($cook, '', time()-1000);
		setcookie($cook, '', time()-1000, '/');
	}
}
*/
################################################################################
$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';	//Server and execution environment information
$urlpath=$protocol.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];	//The URI which was given in order to access this page;
$data['urlpath']=$urlpath;


//Enable Option for Project Wise 

$data['settlement_optimizer_available']='Y'; // Enable for settlement optimizer as paying setting 

$data['JSON_LOG_VIEW_ENABLE']='Y'; // Y is permission for view the json log 
$data['json_log_upd']='N'; // Y is permission for create json log 

$data['loginSingForgotMsg']='';

//Disable the 2FA on Withdraw
/*
$data['2FA_SKIP']='Y'; // Pass Y for Skip button the 2FA on all the project
$data['2FA_ENABLE']='N'; // Pass Y for enable the 2FA on all the project
*/

//ENABLE the 2FA on Withdraw
$data['2FA_SKIP']='N'; // Pass Y for Skip button the 2FA on all the project
$data['2FA_ENABLE']='Y'; // Pass Y for enable the 2FA on all the project

$data['SCRUBBED_TRANS_ENABLE']='Y'; // Pass Y for enable the Scrubbed Trans on all the project

$data['MASTER_TRANS_TABLE']='master_trans_table'; // Assign Table Name for default master trans table 
$data['ASSIGN_MASTER_TRANS_ADDITIONAL']='master_trans_additional'; // Assign Table Name for default master trans additional 

//$data['WITHDRAW_INITIATE_TO_DATE_WISE']='Y'; // if global then remove the comment. It is allready to use for  Y - Withdrawal Date Wise : Not open in same like chrome browser. Open to different private/firefox browsers. via trans_withdraw-fund_datewise.do , trans_withdraw-fund_system_v2.do

$data['WITHDRAW_INITIATE_SYSTEM_WV2']='Y'; //  Y - Withdrawal _wv2 function use via /user/ trnslist.do , settlement.do

$data['REMAINING_BALANCE_WV2']='N'; //  Y - is enable for Withdrawal fund , Withdrawal Rolling , calculation fee  

$data['CHECKOUT_SUBLABEL_NAME']='Y'; // Y is On checkout page for sublable display from define in Acquirer table
$data['CHECKOUT_OPAL_NS_ADDRESS_ENABLE']='Y'; // Y is On checkout page for address is mandatory  

$data['GW_CSV_DATA_FILTER_MORE_CONNECTION_WISE']='Y'; //  Y is On if more db connection 

$data['TIME_TO_COMPLETION_TRANSACTION_SECONDS']='N'; //  Y is On of runtime for second wise save the deffrence between created date and tdate  
$data['RUNTIME_DB_DATE_2ND']='2024-07-01'; //  Y is On for second wise save the deffrence between created date and tdate  

$data['TRANS_EXPIRED_VIA_ADMIN_DASHBOARD']=''; //  acquirer_table_wise is expired all pending transaction as per acquirer table wise OR auto_expired_30_min is expired all pending transaction 30 minute interval OR empty for not expired

//$data['PRVIOUS_BALANCE_DB_ENABLE']='Y'; // Y is On for prvious balance cros db

//$data['reference_unique']='Y'; // If enable Y via config than check unique ref.

//$data['ACQUIRER_STATUS_CHECK_EMAIL_TO_ADMIN']='Y'; // If enable Y via email to admin for if acquirer status url not response or down --------


$data['TRANS_STATUS_NOT_IN']='0,9,10,2,22,23,24'; //  It is global transaction status not in for fetch transaction table. This is use query condition for Marchant Account Balance 

//$data['ACCOUNT_MANAGER_ENABLE']='Y'; // Y is enable for Account manager


//$data['SECURE_CRON_PRIVATE_INSTANCE_IP']=["172.31.47.6","192.168.1.7"];	//Assing Private of Instance for secure cron as a whitelable when using Withdraw V3
//$data['CUSTOM_SETTLEMENT_OPTIMIZER_V3']='custom_settlement_optimizer_v3'; // Table name for Withdraw of version 3
//$data['CUSTOM_SETTLEMENT_WD_V3']='Y'; // Enable Account Balance and Withdraw V3 Custom if is Y and Custom from settlement_optimizer - Payin Setting, Download CSV, Link of header, Search Merchant,Admin 
	//$data['CUSTOM_SETTLEMENT_WD_V3_IN_MER']='Y'; // Enable Custom Withdraw V3 in dashboard of Merchant
//$data['SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM']='Y'; // Y is switch sum_f from psql AS double precision


//$data['ACQUIRER_REF_ENABLE']='Y'; // transID check for or query in acquirer_ref and file name is status_top.do and callback

//$data['ENCRYPTED_TRANSID_ENABLE']='Y'; //  Y is On encrypted transID & public_key via &key= in authurl 

$config_db_con_more_path='';

$data['subfolder']='';
$folder='';
$data['Folder']=$folder;

//For the protocol, you may or may not have $_SERVER['HTTPS'] and it may or may not be empty. For the web root
if(isset($_SERVER["HTTPS"])&&$_SERVER["HTTPS"]=='on')$data['Prot']='https';else $data['Prot']='http'; 


$config_db_1=$data['Path'].'/config_db_1'.$data['iex'];
if(file_exists($config_db_1)){include($config_db_1);}		//include config_db_1 if exist
$config_db_2=$data['Path'].'/config_db_2'.$data['iex'];
if(file_exists($config_db_2)){include($config_db_2);}		//include config_db_2 if exist





$available_currency=$data['Path'].'/available_currency'.$data['iex'];
if(file_exists($available_currency)){include($available_currency);}	//include available_currency if exist

//file use for card bin checker
$default_bin_checker=$data['Path'].'/third_party_api/default_bin_checker'.$data['iex'];
if(file_exists($default_bin_checker)){include($default_bin_checker);}

//file use for currency convertor
$default_currency_converter=$data['Path'].'/third_party_api/default_currency_converter'.$data['iex'];
if(file_exists($default_currency_converter)){include($default_currency_converter);}

//QR code qateway
$qrcode_gateway_file=$data['Path'].'/soft_pos/qrcode_gateway'.$data['iex'];
if(file_exists($qrcode_gateway_file)){include($qrcode_gateway_file);}

//payout gateway
$payout_gateway_file=$data['Path'].'/payout/payout_gateway'.$data['iex'];
if(file_exists($payout_gateway_file)){include($payout_gateway_file);}

//send_email_arr
$send_email_arr_file=$data['Path'].'/include/send_email_arr'.$data['iex'];
if(file_exists($send_email_arr_file)){include($send_email_arr_file);}



//define host name
@$data['HostG']=$data['Prot']."://".@$data['HostN'];

$php_self=$_SERVER['PHP_SELF'];	//The filename of the currently executing script, relative to the document root.

//check validation and execute script according conditions for cron 
if (((strpos ( $php_self, "status_auto_update" ) !== false)||(strpos ( $php_self, "lampp/htdocs" ) !== false)||(strpos ( $php_self, "www/html" ) !== false))&&($data['localhosts']==false)) {
	if(isset($data['HostG'])&&$data['HostG']) $data['Host']=@$data['HostG'];
	if(isset($data['HostN'])&&$data['HostN']){ 
		$_SERVER["HTTP_HOST"]=@$data['HostN'];
		$_SERVER["HTTPS"]='on';
	}
	$urlpath=$php_self;
	$data['urlpath']=$urlpath;
}


//Initialized localhost as false
$localhosts=false;$data['localhosts']=false;

//$_SESSION["http_host_loc"]=1;
//echo "<br/>http_host=>".$_SESSION["http_host_loc"];
if($_SERVER["HTTP_HOST"]=='localhost'||$_SERVER["HTTP_HOST"]=='localhost:8080'||$_SERVER["HTTP_HOST"]=='localhost:83'||$_SERVER["HTTP_HOST"]=='localhost:98'||isset($_SESSION["http_host_loc"])){	//check localhost or not, if yes then define localhost in data and set true
	$localhosts=true; 
	$data['localhosts']=true; 
}

//Initialized variables with relavant values

$data['domain_name']=$_SERVER["HTTP_HOST"];
$data['domain_url']=$protocol.$data['domain_name'];
$data['domain_logo']=$data['domain_url'].'/logo.png';
$data['SiteName']=stripslashes($_SERVER["HTTP_HOST"]);

//enable Business in GW for trnslist || transactions and merlist || merchant
$data['trnslist']='trnslist';$data['my_project']='merlist'; 

if(@$ztspaypci==true){
	if($data['con_name']=='clk'){
		$config_db_host=$data['Path'].'/config_db_clk'.$data['iex'];	//config_db_clk || for clk project
		if(file_exists($config_db_host)){include($config_db_host);}
	}else{
		$config_db_host=$data['Path'].'/config_db_app'.$data['iex'];	//config_db_app || for mobile app
		if(file_exists($config_db_host)){include($config_db_host);}
	}
}
else{
	$config_db_host=$data['Path'].'/config_db_m'.$data['iex'];
	if(file_exists($config_db_host)){include($config_db_host);}
}

if(isset($data['security_f_path'])&&$data['security_f_path']){
	$security_function=$data['Path'].'/include/'.$data['security_f_path'].$data['iex']; // security_f_path || security_function
	//if(file_exists($security_function)){include($security_function);}
}else{
	if((int)phpversion()>7){
		$security_function=$data['Path'].'/include/security_function_256'.$data['iex']; // security_function_256 || security_function for php7 or latest
	}
	else{
		$security_function=$data['Path'].'/include/security_function_m'.$data['iex']; // security_function_m || security_function for till php7
	}
	//if(file_exists($security_function)){include($security_function);}	//include security function
}

if(isset($_REQUEST['s1'])&&$_REQUEST['s1']){	//if s1 pass in request then pring filefullname
	echo "<br/><br/>config_db_host=>".@$config_db_host;
	echo "<br/>security_function=>".@$security_function;
	echo "<br/>security_f_path=>".@$data['security_f_path']."<br/><br/>";
}


if(strpos($data['urlpath'],"/gw1/")!==false){
	$localhosts=1;
}

$data['localhosts']=$localhosts;

if($data['localhosts']==true)	//if you browse in local system then execute following section
{
	$data['ex']="";
	
	$subfolder_ex=explodef($data['urlpath'],'/',3);
	$data['subfolder']='/'.explodef($data['urlpath'],'/',3);	//sub folder name

	if(isset($data['secureCron'])&&$data['subfolder']=='/')
	$data['subfolder']='/gw';
	
	//echo "\n subfolder=>".@$data['subfolder']."\n"; exit;

	$data['TimeZone']='Asia/Kolkata'; // UTC        Asia/Singapore  Asia/Kolkata

	### config_db_1 ######################################
	
	//$data['Prot']='http';
	//define url protocol for localhost 
	$data['HostG']="{$data['Prot']}://localhost".$data['subfolder'];
	$data['HostN']="localhost";
	$data['SERVER_ADDR']=$_SERVER['SERVER_ADDR'];	// The IP address of the server under which the current script is executing. 
	$url_ip=$data['Prot']."://".$data['SERVER_ADDR'];
	$data['SERVER_ADDR_PRA']=$_SERVER['SERVER_ADDR'];	// The IP address of the server under which the current script is executing. 
		
	
	$db_hostname='localhost';	// localhost
	$db_username='root';		// mysql user name for db1   || psql user:  
	$db_password='2024@123';			// mysql db_password for db1 || psql pass: 
	$db_database='gwdb';		// gw | apigateway | 1 database 1 name
	//$db_database='spay';		// gw | apigateway | 1 database 1 name
	$db_tbprefix='zt';			// set prefix for all tables
	//$data['DbPort']='3306';	// if not db port 3306 than assing new db port
	
	//4 psql
	$data['DbPort']='5432';	// psql
	$data['connection_type']='PSQL';
	$db_database='ipg_pgdb31'; //	 ipgdb_1	ipglivepgdb31 
	$db_username='postgres';
	$db_password='2024';	


	
	##########################################################
	
	//psql db 2 for payout 
	
	
	$data['Hostname_2']=$db_hostname_2='localhost';
	$data['Username_2']=$db_username_2='postgres';
	$data['Password_2']=$db_password_2='2024';
	$data['Database_2']=$db_database_2='payoutdbgw'; // payoutdbgw
	$data['DbPrefix_2']=$db_tbprefix_2='zt';
	$data['DbPort_2']='5432';
	$data['connection_type_2']='PSQL';


	
	
	//$db_username='localhost'; $db_password="localhost";

	$ztspaypci=false;
	$data['con_name']='';		// non-clk
	$data['con_name']='clk';	// clk
	
	$data['hdr_logo']='show';
	//$data['security_f_path']='security_function_ntpkey';
	$data['MYWEBSITE']='Website'; $data['MYWEBSITEURL']='Business';
	$data['TimeZone']='Asia/Kolkata'; // UTC || Asia/Singapore || Asia/Kolkata

	date_default_timezone_set(@$data['TimeZone']);

	//$data['PRONAME']='pyth'; // api_label: apiGet | pyth
	$data['DEFAULT_NODAL']=3; // 1:Bank [1 OR 3] , 2:Coins [2 OR 3], 3:Bank and Coins coin_wallet
	
	
	
	// Enable for settlement optimizer as paying setting 
	if(!isset($post['settlement_optimizer']) || empty($post['settlement_optimizer'])) 
	//	$post['settlement_optimizer']='manually';
		
	//$data['settlement_optimizer_available']='N'; // Enable for settlement optimizer as paying setting
	//$data['SUPPORT_ADMIN_LINK_SKIP']='N'; // Diablse for Support link in Admin

	// Y : Skip the available balance and rolling check for update fee
	//$data['SKIP_AVAILABLE_BALANCE_AND_ROLLING']='Y';

	$data['TIME_TO_COMPLETION_TRANSACTION_SECONDS']='Y'; //  Y is On of runtime for second wise save the deffrence between created date and tdate
	

	$data['ROLLING_CALC_QUERY_WV2']='Y'; //Dev Tech : 24-09-20 SUM ROLLING for all transaction query

	$data['REMAINING_BALANCE_WV2']='Y'; //Dev Tech : 24-09-14  Y - is enable PSQL base for Withdrawal fund , Withdrawal Rolling , calculation fee  

	$data['TXN_FEE_FAILED_ENABLE']='Y'; // Y is skip the 2-Declined from TRANS_STATUS_NOT_IN


	$data['PCI_SCAN_DURING_ON']='Y'; // Y is enable durning the PCI scan then disable 

	$data['ACCOUNT_MANAGER_ENABLE']='Y'; // Y is enable for Account manager


	//V3
	//172.31.39.54=>ipg
	//172.31.47.6=>UAT
	//192.168.1.7=>http://localhost:8080/gw
	$data['SECURE_CRON_PRIVATE_INSTANCE_IP']=["172.31.39.54","172.31.47.6","192.168.1.7"];	//Assing Private of Instance for secure cron as a whitelable when using Withdraw V3
	$data['CUSTOM_SETTLEMENT_OPTIMIZER_V3']='custom_settlement_optimizer_v3'; // Table name for Withdraw of version 3
	$data['CUSTOM_SETTLEMENT_WD_V3']='Y'; // Enable Account Balance and Withdraw V3 Custom if is Y and Custom from settlement_optimizer - Payin Setting
	//$data['CUSTOM_SETTLEMENT_WD_V3_IN_MER']='Y'; // Enable Custom Withdraw V3 in dashboard of Merchant
	

	//$data['ENCRYPTED_TRANSID_ENABLE']='Y'; //  Y is On encrypted transID & public_key via &key= in authurl 



	//$data['ACQUIRER_REF_ENABLE']='Y'; // transID check for or query in acquirer_ref and file name is status_top
	 
	// REMAINING_BALANCE_WV2 - Set as per switch for more db instance 	
	if(isset($_SESSION['DB_CON'])&&(isset($_SESSION['adm_login']) || isset($_SESSION['login'])))
	{
		if((in_array($_SESSION['DB_CON'],[1,4])) && $_SESSION['db_ad']>0) $data['REMAINING_BALANCE_WV2']='Y';
		else $data['REMAINING_BALANCE_WV2']='N';
	}

	
	//trans db setting for Additional ----------------------------
	$data['MASTER_TRANS_ADDITIONAL']='Y'; //  Enable for additional date save in  MASTER_TRANS_ADDITIONAL
	$data['ASSIGN_MASTER_TRANS_ADDITIONAL']='master_trans_additional_3'; // Assign Table Name for default master trans additional 
	
	// master_trans_default assing for master trans table  and part of Additional
	$data['MASTER_TRANS_TABLE']='master_trans_table_3'; // Assign Table Name for default master trans table ----------------------------
	
	
	//$data['encrypted_payload_length']='32'; // Public key length 
	
	$config_db_con_more_path='/thirdpartyapp';
	
	$data['AdminFolder']='signins';
	$data['API_VER']=2; // directapi
	$data['PRO_VER']=3; // nextGen3
	//$data['trnslist']='transactions';$data['my_project']='merchant'; 

	//$data['ex']='';

	##########################################################
	
	$data['AdminUsername']='a1';
	$data['AdminPassword']='a1';
	

	##########################################################
	
	
	//$data['Hostname_2']='localhost';	// localhost
	//$data['Username_2']='root';			// mysql user name for db2
	//$data['Password_2']='';				// mysql db_password for db2
	//$data['Database_2']='payoutdbgw';	// database 2 name
	
	##########################################################
	
	//$data['WITHDRAW_INITIATE_SYSTEM_WV2']='N'; //  Y - Withdrawal _wv2 function use via /user/ trnslist.do , settlement.do

	$data['JSON_LOG_VIEW_ENABLE']='Y'; // Y is permission for view the json log 
	$data['json_log_upd']='Y'; // Y is permission for create json log 
	$data['json_log_upd_payin_processing']='Y'; // Y is permission for create json log via payin-processing-engine
	
	//$data['simple_current_date']='Y'; // Y is passing is simple date and time format without micro time
	
	//$data['create_trans_for_backup']='Y'; // Y is permission for create backup in trans master table via backup data base db 
	
	//$data['TRANS_BACKUP_DAYS']='30'; // 30 Days before for create backup from trans master table via backup data base db 
	
	$data['Hostname_3']='localhost';	// localhost
	$data['Username_3']='root';			// mysql user name for db3
	$data['Password_3']='';				// mysql db_password for db3
	//$data['Database_3']='above7daysmastertrans';	// database 3 name
	
	##########################################################
	
	//$data['all_host']['localhost']='localhost';
	//$data['all_host']['localhostPoject']='gw';
	
	//$data['DefaultTemplate']='default1'; // clk || silver || ruby || sifi || default1
	
	//error_reporting(E_ALL ^ (E_DEPRECATED)); //$_GET['dtest']=2;	// reports errors & warning except DEPRECATED
	
	//error_reportingf(1);
	
	//$_GET['cqp']=5; // create trans, create withdraw for enable query  
	//$_GET['dtest']=1;
	//$_GET['dtest']=2;
	//$_GET['dtest1']=1;
	//$data['pq']=1;
	
	//$security_function=$data['Path'].'/thirdpartyapp/lets/security_function_ntpkey_lets.do';
	//$security_function=$data['Path'].'/thirdpartyapp/lets/security_function_m.do';
}
###########################################################################################


//After config db 1 for variable set

//$data['TXN_FEE_FAILED_ENABLE']='Y'; // Y is skip the 2-Declined, 23-Cancelled from TRANS_STATUS_NOT_IN

if(isset($data['TXN_FEE_FAILED_ENABLE'])&&@$data['TXN_FEE_FAILED_ENABLE']=='Y') 
{
	$data['TRANS_STATUS_NOT_IN']='0,9,10,22,24'; //  It is global transaction status not in for fetch transaction table. This is use query condition for Marchant Account Balance 
}

###########################################################################################
// enable query log for in php code if not insert or update 

if(isset($_GET['cqp'])) $_SESSION['cqp']=$_GET['cqp'];
if(isset($_GET['cqp'])&&$_GET['cqp']=='U'&&isset($_SESSION['cqp'])) unset($_SESSION['cqp']);
if(isset($_SESSION['cqp'])&&$_SESSION['cqp']) $_GET['cqp']=$data['cqp']=$_SESSION['cqp'];
else $data['cqp']=0;
	
###########################################################################################

//Dev Tech: 23-12-07 start - Card encrypts & decrypts function include via card value only

function card_encrypts256($ccno) {
	global $security_function;
	global $data_key; global $data_salts; global $kms_salts; 
	global $server_key_lastvalue; global $server_key;
	global $kms_salts_lastvalue; global $kms_salts_lastvalue;
	
	
	if(file_exists($security_function)&&!function_exists('card_encryption_required')) include($security_function);	//include security function
	if(function_exists('card_encryption_required')) return card_encryption_required($ccno); 
	else return $ccno; 
}

function card_decrypts256($ccno) {
	global $security_function;
	global $data_key; global $data_salts; global $kms_salts; 
	global $server_key_lastvalue; global $server_key;
	global $kms_salts_lastvalue; global $kms_salts_lastvalue;
	
	if(file_exists($security_function)&&!function_exists('card_decryption_required')) include($security_function);	//include security function
	if(function_exists('card_decryption_required')) return card_decryption_required($ccno); 
	else return $ccno; 
}

//Dev Tech: 23-12-07 end - Card encrypts & decrypts function include via card value only

###########################################################################################

// Include for more db instance connection file to switch the admin or merchant for fetch db config details and testing for ?a=cm

if(isset($_REQUEST['a'])&&$_REQUEST['a']=='cm'&&isset($_REQUEST['r'])&&$_REQUEST['r']) $_SESSION['con_more']=$_REQUEST['r']; 
elseif(isset($_REQUEST['a'])&&$_REQUEST['a']=='cm') $_SESSION['con_more']='/thirdpartyapp'; 
if(isset($_SESSION['con_more'])&&$_SESSION['con_more']) $config_db_con_more_path=@$_SESSION['con_more'];
$config_db_con_more=$data['Path'].$config_db_con_more_path.'/config_db_con_more'.$data['iex'];
if(file_exists($config_db_con_more)){include($config_db_con_more);}


##############################################################################


//$data['user_agent'] = 'android';
$data['user_agent'] = strtolower(@$_SERVER['HTTP_USER_AGENT']); //get the user agent name for check device - 
$data['OWNER_ID']=1;	//set clientidid for searching instead of merID / sender id
$data['BIN_EX_DATA']=1;	//set bin data, means store card detail in first six and last four digits
$data['NOTIFYBRIDGE']='notify_bridge'; //enable the notify bridge - Dev Tech

//GW
//enable the notify bridge - Dev Tech : 23-02-14
$data['TRANS_NOTIFY_BRIDGE']='trans_notify_bridge'; 



//enable Business in GW for
$data['MYWEBSITE']='Business'; $data['MYWEBSITEURL']='business';
$data['MER']=$data['my_project']; // merlist name for use in merchant services 



if(isset($_REQUEST['s1'])&&$_REQUEST['s1']){
	echo "<br/>user_agent=>".$data['user_agent'];
}

//$data['user_agents'] = strtolower($_SERVER['HTTP_USER_AGENT']);

/*
if(((strpos($data['urlpath'],'/mlogin/')!==false)||(strpos($data['urlpath'],'/signins/')!==false)||(strpos($data['urlpath'],'/user/')!==false)||$data['PageFile']=='login')&&((strpos($data['user_agents'],'chrome')===false)||(strpos($data['user_agents'],'safari')===false))&&($data['localhosts']==false)){ 
 echo "Not allow to access this browser";exit;
}
*/

if(isset($data['PRO_VER'])&&$data['PRO_VER']==3){	//check project version
	$data['UseExtRegFormNew']=1;
}

/*
if(isset($_GET['aDf'])&&$_GET['aDf']){
	$_SESSION['aDf']=1;
}
if(isset($_SESSION['aDf'])&&$_SESSION['aDf']){
	$data['AdminFolder']='signins';
}
*/

$data['ztspaypci']=$ztspaypci;		//ztspaypci
$data['click_name']='Click Zep';	//ztspaypci click name

function error_reportingf($type=0){
	if($type==1||$type==3){
		error_reporting(E_ALL ^ (E_DEPRECATED));	//Sets which PHP errors are reported
		if($type==3&&isset($_POST)&&count($_POST)>0) print_r($_POST);
	}elseif($type==2){
		error_reporting(E_ERROR | E_WARNING | E_PARSE);	//Sets which PHP errors are reported
	}elseif($type==4){
		error_reporting(E_ALL);
		ini_set('display_errors', '1');
		ini_set('max_execution_time', 0);
		//Sets which PHP errors are reported
	}else{
		error_reporting(0);					// Turn off all error reporting
	}
}



if(isset($_REQUEST['ER'])&&$_REQUEST['ER']=='P'&&isset($_SESSION['ER'])){
	echo "<br/>ER=>".$_SESSION['ER'];
}
elseif(isset($_REQUEST['ER'])){
	$_SESSION['ER']=$_REQUEST['ER'];
	echo "<br/>ER=>".$_SESSION['ER'];
}

if(isset($_REQUEST['ER'])&&$_REQUEST['ER']=='U'&&isset($_SESSION['ER'])){
	unset($_SESSION['ER']);
}


if(isset($_SESSION['ER'])&&$_SESSION['ER']==0){
	error_reportingf(0);
}
elseif(isset($_SESSION['ER'])&&$_SESSION['ER']==1){
	error_reportingf(1);
}
elseif(isset($_SESSION['ER'])&&$_SESSION['ER']==2){
	error_reportingf(2);
}elseif(isset($_SESSION['ER'])&&$_SESSION['ER']==3){
	error_reportingf(3);
}elseif(isset($_SESSION['ER'])&&$_SESSION['ER']==4){
	error_reportingf(4);
}

##############################################################################

//Encrypts a string in base of 256-bit encryption technique
function exp_encrypts256($str) {
	//global $data_key; global $server_key; global $kms_salts;
	
	global $security_function;
	global $data_key; global $data_salts; global $kms_salts; 
	global $server_key_lastvalue; global $server_key;
	global $kms_salts_lastvalue; global $kms_salts_lastvalue;
	
	if(file_exists($security_function)&&!function_exists('getKeys256')) include($security_function);	//include security function
	
	

	$publicKey = getKeys256();	//fetch server key
	$privateSaltsKey = getPrivateSaltsKeys();	//kms_salts key
	$encryptedData=encrypts256($str, $publicKey, $privateSaltsKey);	//Encrypts a string
	$str='{"decrypt":"'.urlencode($encryptedData).'","key":"'.$server_key.'","saltsKey":"'.$kms_salts.'","encode":"1"}';
	return $str;
}

//Decrypts a string which Encrypts in base of 256-bit technique
function exp_decrypts256($str) {
	
	//global $data_key; global $server_key; global $kms_salts;
	
	global $security_function;
	global $data_key; global $data_salts; global $kms_salts; 
	global $server_key_lastvalue; global $server_key;
	global $kms_salts_lastvalue; global $kms_salts_lastvalue;
	
	if(file_exists($security_function)&&!function_exists('getKeys256')) include($security_function);	//include security function
	
	
	$not_encrypted=jsonvaluef($str,"not_encrypted");
	if($not_encrypted){
		$str=jsonvaluef($str,"decrypt");
	}else{
		$server_key= jsonvaluef($str,"key");
		$publicKey = getKeys256($server_key);	//fetch server key
		
		$saltsKey=jsonvaluef($str,"saltsKey");
		if((isset($saltsKey))&&(!empty($saltsKey))){
			$server_key=$saltsKey;
		}
		
		$privateSaltsKey = getPrivateSaltsKeys($server_key);	//private key
		
		$encode=$str;
		$str=jsonvaluef($str,"decrypt");
		if(($encode)&&(strpos($encode,"encode")!==false)){
			$str=urldecode($str);
		}
		
		$str=decrypts256($str, $publicKey, $privateSaltsKey);
		//$str=ccnois($str);
	}
	
	return $str;
}

#####################
$data['Hostname']=$db_hostname;		//host name for connection 1
$data['Username']=$db_username;		//DB Username for connection 1
$data['Password']=$db_password;		//DB Password for connection 1
$data['Database']=$db_database;		//Database name for connection 1
$data['DbPrefix']=$db_tbprefix;		//Table prefix for connection 1
###############################################################################

$data['DbPrefix']="{$data['DbPrefix']}_";		//define prefix
##############################################################################

$data['PORT'] = @$_SERVER['SERVER_PORT'] ? ':'.@$_SERVER['SERVER_PORT'] : '';		//define port
if($_SERVER['SERVER_PORT']==443||$_SERVER['SERVER_PORT']==98||$_SERVER['SERVER_PORT']==80||$_SERVER['SERVER_PORT']==8080){$data['PORT']='';}
if($data['Folder'])$data['Folder']="/{$data['Folder']}";	//define folder
$data['Addr']="{$_SERVER['REMOTE_ADDR']}";			//define bill_ip
$data['Host']="{$data['Prot']}://{$_SERVER['HTTP_HOST']}{$data['PORT']}{$data['subfolder']}{$data['Folder']}";	//define host name including port and folder

if ((strpos($data['urlpath'], "/config" ) !== false)) {
	header("Location:".$data['Host']);	//if config in url path then redirect to host
}

$data['url_ip']=$url_ip;
$data['all_host']['SERVER_NAME']=$_SERVER['SERVER_NAME'];	//define server name
//$data['all_host']['url_ip']=$data['url_ip'];
//$data['all_host']['HostN']=$data['HostN'];
$data['all_host']['serverIP']=$data['SERVER_ADDR'];		//server bill_ip
//$data['all_host']['SERVER_ADDR_PRA']=$data['SERVER_ADDR_PRA'];

$data['testEmail_1']='devops@itio.in';

##############################################################################

/*
echo "\n Prot=>".$data['Prot']."\n"; 
echo "\n HTTP_HOST=>".$_SERVER["HTTP_HOST"]."\n"; 
echo "\n Host=>".$data['Host']."\n"; 
echo "\n HostN=>".$data['HostN']."\n"; 
echo "\n HostG=>".$data['HostG']."\n"; 
echo "\n php_self=>".$_SERVER["php_self"]."\n\n"; 
print_r($_SERVER);
exit;
*/

##############################################################################
//define email type or type of email transactions
$data['EmailType']=array(
	1=>'Transaction Insert',
	2=>'Mass Mail Account Wise',
	3=>'Mass Mail Merchant Wise',
	4=>'Email Send',
	5=>'Check Transaction Insert',
	6=>'Request Money Insert',
	7=>'Admin Reply (Message) ',
	8=>'Email ReSend',
	9=>'Transaction Insert for Customer Email',
	10=>'Transaction Insert for Merchant Email',
	11=>'Check Transaction Insert for Customer Email',
	12=>'Check Transaction Insert for Merchant Email',
	13=>'Merchant Signup Verification',
	14=>'Merchant Signup to Confirmation',
	15=>'Forgot Password',
	16=>'Notify Subadmin Missing Calculation',
	17=>'Hard code testing',
);

##############################################################################
//define Templates
$data['tmp']=array(
	15=>('Templates 1'),
	26=>('Templates 2'),
	27=>('Templates 3'),
	28=>('Templates 4'),
	29=>('Templates 5'),
	30=>('Templates 6'),
	31=>('Templates 7'),
	32=>('Templates 8'),
	33=>('Templates 9'),
);

//define remove template roll
$data['remove_t']=array(0=>0,1=>1,2=>5,3=>6,4=>7,5=>11);


//check connection type
if(isset($data['con_name'])&&$data['con_name']=='clk'&&isset($data['t_clk'])){
	//$data['t']=$data['t_clk'];
}
//define curr
$data['cur']=array(
	1=>'SGD',
);
//define transaction limit
$data['transactionLimit']=array(
	1=>'900',
	2=>'2000',
);

//define connection type for Withdraw request, If CLK then Settlement Request
if($data['con_name']=='clk'){
	$t_13='Settlement Request';
}else{
	$t_13='Withdraw Requested';
}

// tether Transport Protocol from volet
$data['tetherTransportProtocol']=array(
	//"BTC"=>"BTC (Bitcoin)",
	"ETHEREUM"=>"ERC-20 (Ethereum)",
	"TRON"=>"TRC-20 (TRON)",
	"BINANCE_SMART_CHAIN"=>"BEP-20 (Binance Smart Chain)",
	"MATIC"=>"MATIC (Polygon)",
	"SOLANA"=>"SOL (Solana)"
);

//define transaction status array - new version
$data['TransactionStatus']=array(
	0=>'Pending',		//pending or initiate
	1=>'Approved',		// Success || Approved || Completed
	2=>'Declined',		// Failed || Declined || Cancelled
	3=>'Refunded',		// refund completed
	//4=>'Settled', //(both)
	5=>'Chargeback',	//charge back 
	//6=>'Returned', // (check)
	7=>'Reversed', // Reversed || Completed our transaction (1 or 4) by 7=> new transaction with status of ( (both)Refunded 3 or (card) Chargeback 5 or (check) Returned 6 or (card) cbk1 11)
	8=>'Refund Pending', // for Merchant
	9=>'Test',			//FOR TEST MODE
	10=>'Scrubbed',		//Scrubbed trans
	11=>'Predispute', // Predispute CBK1
	12=>'Partial Refund', // 3 Refunded
	13=>'Withdraw Requested', // for Merchant
	14=>'Withdraw Rolling', // for Merchant
	//15=>'Fund',				//fund
	//16=>'Received Fund',	//recevied fund
	//17=>'Send Fund',		//send fund
	//18=>'Received Fund - Cancelled',
	//19=>'Send Fund - Cancelled',
	20=>'Frozen Balance',		//Frozen Balance
	21=>'Frozen Rolling',		//Frozen Rolling
	22=>'Expired',		// expired time for UPI 10min.
	23=>'Cancelled',	// Failed || Declined || Cancelled
	24=>'Failed',		// Failed || Declined || Cancelled
);


//define channel type array
$data['channel']=array(
	1=>array(
		'name1'=>'ch',
		'name2'=>'e-Check Payment'
	),
	2=>array(
		'name1'=>'2d',
		'name2'=>'2D Card Payment'
	),
	3=>array(
		'name1'=>'3d',
		'name2'=>'3D Card Payment'
	),
	4=>array(
		'name1'=>'wa',
		'name2'=>'Wallets Payment'
	),
	5=>array(
		'name1'=>'upi',
		'name2'=>'UPI Collect'
	),
	6=>array(
		'name1'=>'nb',
		'name2'=>'Net Banking Payment'
	),
	7=>array(
		'name1'=>'crypto',
		'name2'=>'Coins Payment'
	),
	9=>array(
		'name1'=>'upiqr',
		'name2'=>'UPI Collect QR & Intent'
	),
	10=>array(
		'name1'=>'qr',
		'name2'=>'UPI QR & Intent'
	),
	11=>array(
		'name1'=>'bt',
		'name2'=>'Bank Transfer'
	),
	90=>array(
		'name1'=>'np',
		'name2'=>'Network Payment'
	),
	99=>array(
		'name1'=>'ot',
		'name2'=>'Other Payment'
	)
);

//define color for ticket status
$data['TicketStatus']=array(
	0=>'<font style=color:#2c84a4>Open</font>',
	1=>'<font style=color:#008000>Process</font>',
	2=>'<font style=color:#333>Close</font>',
	4=>'<font style=color:#008000>Read</font>',
	5=>'<font style=color:#fe00ae>Sent</font>',
	90=>'<font style=color:#008000>Drafts</font>', // for Merchant
	91=>'<font style=color:#e80d11>New Mail</font>',
	92=>'<font style=color:#008000>Drafts</font>', // for Admin
	
);

//define color for ticket TicketFilter
$data['TicketFilter']=array(
	-4181=>'<font style=color:#2c84a4>Draft</font>',
	-1413=>'<font style=color:#008000>Admin</font>',
);

//define message type
$data['MessageType']=array(
	1=>'Payout',
	2=>'Technical Support for Integration',
	4=>'Transaction Issue',
	5=>'Password Security/2MFA Issue',
	6=>'Complaint/Feedback',
	7=>'Low Processing Reminder',
	7=>'High Charge-Back Ratio Reminder',
	21=>'Others',
);

//define access type
$data['gmfa']=array(
	0=>'withdraw',
	1=>'merchantLogin',
	2=>'subAdmin'
);

//define mrindex 
$data['mrindex']=array(
	0=>'',
	1=>'Add/Edit Emails',
	2=>'Summary Account',
	3=>'All Transaction',
	4=>'Block Transaction',
	5=>'Manage User',
	6=>'Message Center',
	7=>'My Bank Accounts',
	8=>'My Business',
	9=>'Profile',
	10=>'Recent Order Accounts',
	11=>'Request Funds',
	12=>'Send Fund',
	13=>'Mer Setting',	
	14=>'Statement',
	15=>'Test Transaction',
	16=>'Withdraw Funds',
	17=>'Success Ratio',
	//31=>'Account Security',
	/*
		18=>'Add Beneficiary',
		19=>'Upload Fund',
		20=>'Payout Transaction',
		21=>'Payout Statement',
		22=>'Payout Keys',
		23=>'Beneficiary List',
	*/
);

//define card numbers for test 
$data['testCardNo']=array(
	'visa'=>'4242424242424242',			//Visa
	'visa2'=>'4444444444444444',		//Visa 2
	'mastercard'=>'5555555555554444',	//MasterCard
	'rupay'=>'6521111111111117',		//RuPay India
	'discover'=>'6011000990139424',		//Discover
	'jcb'=>'3530111333300000',			//JCB
	'diners'=>'30569309025904',			//Diners Club
	'amex'=>'378282246310005',			//American Express
	'amex2'=>'378734493671000',			//American Express Corporate
	'australian'=>'5610591081018250',	//Australian BankCard
	'dankort'=>'5019717010103742',		//Dankort (PBS)
	'maestro'=>'6759649826438453',		//Maestro
	'airplus'=>'122000000000003',		//Airplus
	'laser'=>'122000000000003',			//Laser
	'cartebleue'=>'122000000000003',	//Cartebleue
	'solo'=>'6331101999990016'			//Switch/Solo (Paymentech)
);

//define android app packages for upi intent
$data['sdk_package']=array(
	'airtel'=>'com.myairtelapp',
	'amazon'=>'in.amazon.mShop.android.shopping',
	'freecharge'=>'com.freecharge.android',
	'mobikwik'=>'com.mobikwik_new',
	'OlaMoney'=>'com.olacabs.olamoney',
	'paytm'=>'net.one97.paytm',
	'phonepe'=>'com.phonepe.app',
	'jio'=>'com.jio.myjio',
	'gpay'=>'com.google.android.apps.nbu.paisa.user',
	'bhim'=>'in.org.npci.upiapp',
	//'plysearch'=>'https://play.google.com/store/search?q=',
	//'other'=>'https://play.google.com/store/apps/details?id=' ,
	'whatsapp'=>'com.whatsapp'
);

//define luhn method
$data['luhn_skip']=array(
	'skplh_visa1'=>'440523', //Visa bin
	'skplh_visa2'=>'652166', //Visa bin
	'skplh_visa4'=>'652294', //Visa bin
	//'skplh_visa5'=>'414141', //Visa bin
	'skplh_visa3'=>'411111' //Visa bin
);

//setup Test transactions
$data['jsTestCardNumbers']='"'.implodes('","',$data['testCardNo']).'"';
$data['jsLuhnSkip']='"'.implodes('","',$data['luhn_skip']).'"';

//define color of process status
$data['ProcessStatus']=array(
	0=>'<font style=color:#2c84a4>Pending</font>',
	1=>'<font style=color:#008000>Live</font>',
	2=>'<font style=color:#333>Test</font>',
	3=>'<font style=color:#e80d11>Inactive</font>',
	4=>'<font style=color:#fe00ae>Close</font>'
);

//define payment type
$data['PaymentType']=array(
	0=>'product',
	1=>'subscription',
	2=>'donation',
	3=>'payment'
);

//define color of Email status
$data['MailStatus']=array(
	0=>'<font style=color:#2c84a4>Pending</font>',
	1=>'<font style=color:#008000>Success Email</font>',
	2=>'<font style=color:#333>Failed Email</font>',
	3=>'<font style=color:#e80d11>Process Email</font>',
	4=>'<font style=color:#fe00ae>Resend Email</font>'
);

##############################################################################
//To removes some special keywords and tags.
function prntext($text,$repl=0){
	//global $data;
	if(is_string($text)){
		if($repl>0){
			//$text = urldecode($text);
		}
		//returns a string or an array with all occurrences of search in subject (ignoring case) replaced with the given replace value.
		$text = str_ireplace(array('onmouseover','onclick','onmousedown','onmousemove','onmouseout','onmouseup','onmousewheel','onkeyup','onkeypress','onkeydown','oninvalid','oninput','onfocus','ondblclick','ondrag','ondragend','ondragenter','onchange','ondragleave','ondragover','ondragstart','ondrop','onscroll','onselect','onwheel','onerror','onblur','<','>',"'"), '', $text );
		return trim(strip_tags($text));
	}
}

##############################################################################

//define tags - for skip when strip tags
$strip_tags_skip['strip_tags_skip']	=array("more_details","message","content","custom_css","support_note","system_note","mer_note","comments","EncData","description_history","dashboard_notice");
$strip_get_skip['strip_get_skip']	=array("promptmsg");

//remove html tags
function stf($str){
	$str=strip_tags(trim($str));
	return $str;
}

//curly braces balance if left or right missing as count wise in json string 
function curly_braces_join($str){
	$qp=0; $curly_braces_left_join='';$curly_braces_right_join='';
	if(isset($str)&&is_array($str)) $str=jsonencode($str,1,1);
	$str=jsonreplace($str);
	if(isset($_GET['qp'])) $qp=$_GET['qp'];
	
	$curly_braces_left=explode('{',$str);
	$curly_braces_left_count=count($curly_braces_left);
		if($qp) echo "<br/><hr/>curly_braces_left_count=>".$curly_braces_left_count."<br/><br/>";
	$curly_braces_right=explode('}',$str);
	$curly_braces_right_count=count($curly_braces_right);
		if($qp) echo "<br/><hr/>curly_braces_left_count=>".$curly_braces_right_count."<br/><br/>";
	
	$curly_braces_diff=$curly_braces_left_count - $curly_braces_right_count;
		//$curly_braces_diff=-5;
		if($qp) echo "<br/><hr/>curly_braces_diff=>".$curly_braces_diff."<br/><br/>";
	
	
	
	if(strpos($curly_braces_diff,'-')!==false){
		$curly_braces_diff_left=(int)str_replace('-','',$curly_braces_diff);
		 if($qp) echo "<br/><hr/>curly_braces_left_join=>".$curly_braces_left_join."<br/><br/>";
		if($curly_braces_diff_left>0){
			for($x = 1; $x <= $curly_braces_diff_left; $x++) {
				$curly_braces_left_join.="{";
				if($qp) echo "The number is: $x <br>";
			}
		}
	}
	elseif($curly_braces_diff>0){
		for ($x = 1; $x <= $curly_braces_diff; $x++) {
			$curly_braces_right_join.="}";
			if($qp) echo "The number is: $x <br>";
		}
	}
	
	if($qp) echo "<br/><hr/>curly_braces_right_join=>".$curly_braces_right_join."<br/><br/>";
	if($qp) print_r($str);
	
	return $str=$curly_braces_left_join.$str.$curly_braces_right_join;
}


//limit query - limit return as per mysql and psql 
function query_limit_return($limit=''){
	global $data; 
	
	if(isset($_REQUEST['a'])&&$_REQUEST['a']=='cn'&&isset($_SESSION['login_adm']))
	{
		echo "<br/>connection_type==>".$data['connection_type']."<br/>";
		echo "<br/>Database==>".$data['Database']."<br/>";
		echo "<br/>limit==>".$limit."<br/><hr/>";
	}
	$limit=str_ireplace('LIMIT','',$limit);
	if($data['connection_type']=='PSQL'&&!empty(trim($limit))) 
	{
		if(strpos($limit, ',') !== false)
		{
			$limit_arr=explode(',',$limit);	
			$limit=$limit_arr[1].' OFFSET '.$limit_arr[0];
		}
	}
	//else $result=$limit;
	return ' LIMIT '.$limit;
}

//query - GROUP_CONCAT - group concat return as per mysql and psql 
function group_concat_return($field='',$isDistinct=0){
	global $data; $result='';
	
	// isDistinct=1 : DISTINCT(`terNO`) 
	
	if($data['connection_type']=='PSQL'&&!empty(trim($field))) 
	{
		if($isDistinct==1)
			$result="array_to_string(array_agg(DISTINCT {$field}), ',')";
		else
			$result="array_to_string(array_agg({$field}), ',')";
	}
	else {
		if(!empty(trim($field))){
			if($isDistinct==1)
				$result="GROUP_CONCAT(DISTINCT({$field}))";
			else
				$result="GROUP_CONCAT({$field})";
		}
	}
	return $result;
}

//query - DATE_FORMAT - date format return as per mysql and psql 
function date_format_return($field='',$dateFormat=0){
	global $data; $result='';
	
	// dateFormat=1 : %Y%m%d for check the date only like 2024-02-30   
	// dateFormat=2 : %Y%m%d%H%i%s for check the date only like 2024-02-30 18:30:51   
	// dateFormat=3 : %b-%y for check the date only like Dec-23   
	
	if($data['connection_type']=='PSQL'&&!empty(trim($field))) 
	{
		if($dateFormat==1)
			$result="to_char({$field}, 'YYYY-MM-DD')";
		elseif($dateFormat==2)
			$result="to_char({$field}, 'YYYY-MM-DD HH24:MI:SS')";
		elseif($dateFormat==3)
			$result="to_char({$field}, 'Mon-YY')";
		
	}
	else {
		if(!empty(trim($field))){
			if($dateFormat==1)
				$result="DATE_FORMAT({$field}, '%Y%m%d')";
			elseif($dateFormat==2)
				$result="DATE_FORMAT({$field}, '%Y%m%d%H%i%s')";
			elseif($dateFormat==3)
				$result="DATE_FORMAT({$field}, '%b-%y')";
			
		}
	}
	return $result;
}

//query - date type return as per mysql and psql 
function date_type_return($field='',$dateFormat=0){
	global $data; $result='';
	
	// dateFormat=1 : %Y%m%d for check the date only like 2024-02-30   
	// dateFormat=2 : %Y%m%d%H%i%s for check the date only like 2024-02-30 18:30:51   
	
	if($data['connection_type']=='PSQL'&&!empty(trim($field))) 
	{
		if($dateFormat==1)
			$result="('{$field}', 'YYYY-MM-DD')";
		elseif($dateFormat==2)
			$result="('{$field}', 'YYYY-MM-DD HH24:MI:SS')";
	}
	else {
		if(!empty(trim($field))){
			if($dateFormat==1)
				$result="('{$field}', '%Y%m%d')";
			elseif($dateFormat==2)
				$result="('{$field}', '%Y%m%d%H%i%s')";
		}
	}
	return $result;
}

//remove special characters 
function replacepost_api($str){
	$str = str_replace( array( '\'', '"', ';', '<', '>', "'", "’", '\\' ), '', $str);
	$str = str_replace( array(';'), ' ', $str);
	return $str;
}

//To remove single (') quotes, double (") quotes and blank spaces from string. And also removes HTML tags
function replacepost($str,$key=''){
	global $strip_tags_skip;

	if($key=='email'){
		$str = str_replace(array("'","’",' '),'',$str);	//To remove single (') quotes, double (") quotes and blank spaces from email
	}else{
		$str = str_replace(array("'", "’"), '', $str);	//To remove single (') quotes, double (") quotes from string
	}
	
	//to remove tags skip above defined tags
	if(($str && is_string($str) ) && (!in_array($key, $strip_tags_skip['strip_tags_skip']))){
		$str=strip_tags(trim($str));
	}
	return $str;
}
//To converts and merge all the $_POST values in an array and reset $_POST array
function get_post(){
	global $_POST; global $strip_tags_skip; $result=array(); $result2=array();
	foreach($_POST as $key=>$value){
		if(($value && is_string($value) ) && (in_array($key, $strip_tags_skip['strip_tags_skip']))){
			$result2[$key]=($value);
		}
	}
	if(isset($_POST)){
		$post_en=replacepost(prntext(json_encode($_POST)));
		if($post_en){
			$post_de=json_decode($post_en,1);
			$result	=$post_de;
			$_POST	=$post_de;
			if($result&&$result2){
				$result	= array_merge($result,$result2);
				$_POST	= array_merge($_POST,$result2);
			}
		}
	}
	if(isset($_POST)) reset($_POST);
	return $result;
}

//To converts and merge all the $_GET values in an array.
function get_request1(){
	global $_GET; global $strip_get_skip; $result2=array();
	foreach($_GET as $key=>$value){
		if(($value && is_string($value) ) && (in_array($key, $strip_get_skip['strip_get_skip']))){
			$result2[$key]=($value);
		}
	}
	if(isset($_GET)){
		$get_en=replacepost(prntext(json_encode($_GET)));
		
		if($get_en){
			$_GET=json_decode($get_en,1);
			if($result2){
				$_GET=array_merge($_GET,$result2);
			}
		}
	}
}
if(isset($_GET)){get_request1();}	// call get_request1() to merge json values with $_GET

//remove special chars, but I think no any use of this function
function replacepost1($str){
	$str = str_replace( array( '\'', '"', ',' , ';', '<', '>', "'", "’", '\\' ), '', $str);
	$str = str_replace( array( '/', ';' ), ' ', $str);
	$str = strip_tags(trim($str));
	return $str;
}

//Return array after remove single (') and double (") quotes.
function get_post1($pst){
	$result=array();
	foreach($pst as $key=>$value)$result[$key]=replacepost($value);	//remove quotes via call replacepost()
	return $result;
}

//Return array after remove single (') and double (") quotes.
function get_post2($pst){
	$result=array();
	foreach($pst as $key=>$value)$result[$key]=replacepost_api($value);	//remove quotes via call replacepost()
	return $result;
}


//To sets all the $post values in json array.
function keym_f($post,$json){
	if(isset($post)&&is_array($post)){
		foreach($post as $key=>$value){
			if(isset($json[$key]) && $json[$key]){unset($json[$key]);}	//unset if already store/define

			if(!isset($json[$key]) || !$json[$key])
			{
				$json[$key]=$value;	//store $json array
			}
		}
	}
	return $json;
}
//To defined array keys 
function array_val_f($post,$val=0){
	$result=[];
	foreach($post as $key=>$value){
		if(($value !== NULL && $value !== FALSE && $value !== "" )){
			$result[$key]=$value;
		}
	}
	return $result;
}



##############################################################################

$data['config_mysqli_psql_both']=$data['Path'].'/thirdpartyapp/config_mysqli_psql_both'.$data['iex'];

$multiple_con='';
if(isset($data['config_mysqli_psql_both'])&&file_exists($data['config_mysqli_psql_both'])){
	$multiple_con='_check';
	include($data['config_mysqli_psql_both']);
}


##############################################################################

$data['cid']=null;	//Initialized connection id is null

if(isset($data['skip_connection_type'])){
	
}
else {
	// Include connection file -mysql as connection type defined - for DB 1
	switch ($data['connection_type']) {
		case 'PDO':
			if (!@include ('config_pdo'.$data['iex'])){
				echo '<center><b>Error!</b> Connection File not Found';
				die();
			}
			break;
		case 'MYSQLI':
			if (!@include('config_mysqli'.$multiple_con.$data['iex'])){
				echo '<center><b>Error!</b> Connection File not Found';
				die();
			}
			break;
		case 'PSQL':
			if (!@include('config_psql'.$multiple_con.$data['iex'])){
				echo '<center><b>Error!</b> Connection File not Found';
				die();
			}
			break;
		case 'MYSQL':
			if (!@include('config_mysql'.$data['iex'])){
				echo '<center><b>Error!</b> Connection File not Found';
				die();
			}
			break;
		default:
			echo ('<b>Error:</b> Connectin Type not defined. Define the DB connection Type.');
			die();
	} // End switch
}


// Include connection file -mysql - for DB 2
if(isset($data['Database_2'])&&$data['Database_2']&&isset($data['connection_type_2'])&&$data['connection_type_2']='PSQL'){
	$config_mysqli_2=$data['Path'].'/config_psql_2'.$data['iex'];
	if(file_exists($config_mysqli_2)){include($config_mysqli_2);}
}
elseif(isset($data['Database_2'])&&$data['Database_2']){
	$config_mysqli_2=$data['Path'].'/config_mysqli_2'.$data['iex'];
	if(file_exists($config_mysqli_2)){include($config_mysqli_2);}
}

// Include connection file -mysql - for DB 3
if(isset($data['Database_3'])&&$data['Database_3']){
	$config_mysqli_3=$data['Path'].'/config_mysqli_3'.$data['iex'];
	if(file_exists($config_mysqli_3)){include($config_mysqli_3);}
}

$data['sid']=session_id();	//store session_id()

if($_POST) $post = get_post();	//store all $_POST parameters into $post[]

// connection for function switch as per condition wise

/*
$db_connect="db_connect";
$db_disconnect="db_disconnect";
$db_query="db_query";
$newid="newid";
$db_count="db_count";
$db_rows="db_rows";
*/

if(function_exists('db_connect'))
db_connect();	//make connection for DB1

if(isset($data['Database_2'])&&$data['Database_2']&&function_exists('db_connect_2')){
	db_connect_2();	//make connection for DB2
}
if(isset($data['Database_3'])&&$data['Database_3']&&function_exists('db_connect_3')){
	db_connect_3();	//make connection for DB3
}

##############################################################################


// Dev Tech : 23-02-12 gw new function 
$function_gw_new=$data['Path'].'/function_gw/function_gw_new'.$data['iex'];
if(file_exists($function_gw_new)){include($function_gw_new);}


// Dev Tech : 24-05-13 withdraw v2 function
$function_gw_wv2=$data['Path'].'/function_gw/function_gw_wv2'.$data['iex'];
if(file_exists($function_gw_wv2)){include($function_gw_wv2);}	


// Dev Tech : 25-01-04 withdraw v3 function Custom in Settlement Optimizer
$function_gw_wv3_custom=$data['Path'].'/function_gw/function_gw_wv3_custom'.$data['iex'];
if(file_exists($function_gw_wv3_custom)){include($function_gw_wv3_custom);}	


##############################################################################

//Mask the credit numbers with 'X', display only last four digits. Eg. XXXXXXXXXXXX1234
function ccnois($num,$bin=0){
	
	$num = (string)$num;
	//if (!ctype_digit($num)) {return FALSE;}
	$num1=strlen($num);$num_1=(int)$num1;$num2=strlen($num)-4;$ccn4=substr($num,$num2,$num1);$i=0;$j="X";
	if($num2<0){$ccnf=$num;}
	if($num2>0){while(--$num2){$j.="X";} $ccnf=$j.$ccn4; }

	if($bin>0){ 
		$bino=substr($num,0,6);
		$ccnf=substr_replace($ccnf,$bino,0,6);
	}
	
	return $ccnf;
}

//Map for color theme, logo and mailgun API for Merchant / SubAdmin
function domain_serverf($servername='',$layoutName=''){
	global $data; $result=array();
	$result['STATUS']=false;$result['STYLE']="";
	//$result['LOGO']=$data['Host']."/images/logo.png";
	$result['LOGO']='';
	$server_name=$_SERVER['SERVER_NAME'];	//fetch the name of the server host under which the current script is executing
	if(!empty($servername)){
		$server_name=$servername;	//server name
	}
	
	
	/*
	if($server_name=="localhost"){
	
	}else{
	*/
		//fetch data from subadmin table via domain name
		$subadmin=db_rows(
			"SELECT *".
			" FROM `{$data['DbPrefix']}subadmin`".
			" WHERE `domain_name`='{$server_name}' AND `domain_active`=1 LIMIT 1 ",0
		);
		//if data exist in subadmin table, then execute following section
		if($subadmin){
			$result['STATUS']=true;
			$result['sub_id']=$subadmin[0]['id'];		//subadmin id
			if(!isset($data['sponsor_id'])){
				$data['sponsor_id']=$result['sub_id'];
				$data['sponsor_fr']=$server_name;
			}
			$result['sub_username']=$subadmin[0]['username'];	//username
			if(!empty($subadmin[0]['upload_logo'])){
				$result['LOGO']=$data['Path']."/user_doc/".$subadmin[0]['upload_logo'];	//logo with path
			}
			if(!empty($subadmin[0]['logo_path'])){
				$result['LOGO_ICON']=$data['Path']."/user_doc/".$subadmin[0]['logo_path']; //logo icon
			}
			$result['PageTitle']=$subadmin[0]['domain_name'];	//domain name
			$result['STYLE']=$subadmin[0]['custom_css'];		//define css
			$result['header_bg_color']=$subadmin[0]['header_bg_color'];	//header background color
			$result['header_text_color']=$subadmin[0]['header_text_color'];	//header text color
			$result['bussiness_url']=$subadmin[0]['bussiness_url'];			//business website
			$result['customer_service_no']=$subadmin[0]['customer_service_no'];	//customer service number
			$result['customer_service_email']=encrypts_decrypts_emails($subadmin[0]['customer_service_email'],2);	//service email id
			$result['associate_contact_us_url']=$subadmin[0]['associate_contact_us_url'];	//contact us page url
			
			$ds_pt=$result['PageTitle'];
			$result['du1']=$data['all_host'];		//host name
			$result['du2']=$result['PageTitle'];	//page title
	
			$more_details=$subadmin[0]['more_details'];
			if($more_details){
				$more_details=json_decode($more_details,true);
			//$result['mailgun_from']=$more_details['mailgun_from'];
				$result['as']=$more_details;
				if(@$more_details['SiteName']){
					$data['SiteName']=$more_details['SiteName'];	//sitename
				}
				if(isset($more_details['Host'])&&$more_details['Host']){
					$data['Host']=$more_details['Host'];	//host name
						$data['domain_url']=$more_details['Host'];	//host name as domain url
				}
				/*if(isset($more_details['Host'])&&$more_details['Host']){
					$data['domain_url']=$more_details['Host'];	//domain url
				}*/
				$data['mail_gun_api']=@$more_details['mail_gun_api'];	//email gun api
				$data['mail_host']=((isset($more_details['mail_host'])&&$more_details['mail_host'])?$more_details['mail_host']:''); 
			}
			$result['sub_admin_css']=$subadmin[0]['upload_css'];	//define uploaded css
			$result['frontUiName']=$subadmin[0]['front_ui'];		//define ui
		}
		
	//}
	//print_r($subadmin);
	return $result;
}
//Inserted e-mail details into DB
function insert_email_details($post){
	global $data;$prnt=0;
	if(isset($post['prnt'])&&$post['prnt']){$prnt=1;}
	
	if(isset($post['json_value']['EMAIL_KEY'])&&$post['json_value']['EMAIL_KEY']&&in_array($post['json_value']['EMAIL_KEY'],["2FA-ACTIVATION-RESET-REQUEST","RESTORE-PASSWORD"])&&$data['localhosts']==false){
		//echo $post['json_value']['EMAIL_KEY']; return false;
	}
	else{
	
		$post['email_to']	=encrypts_decrypts_emails($post['email_to'],3);		//encode email
		$post['email_from']	=encrypts_decrypts_emails($post['email_from'],3);	//encode email

		if(isset($post['json_value']['from'])&&$post['json_value']['from']){
			$post['json_value']['from']=encrypts_decrypts_emails($post['json_value']['from'],3);	//encode email
		}
		if(isset($post['json_value']['to'])&&$post['json_value']['to']){
			$post['json_value']['to']=encrypts_decrypts_emails($post['json_value']['to'],3);	//encode email
		}
		if(isset($post['json_value']['h:Reply-To'])&&$post['json_value']['h:Reply-To']){
			$post['json_value']['h:Reply-To']=encrypts_decrypts_emails($post['json_value']['h:Reply-To'],3);	//encode email
		}
		if(isset($post['json_value']['post']['remail'])&&$post['json_value']['post']['remail']){
			$post['json_value']['post']['remail']=encrypts_decrypts_emails($post['json_value']['post']['remail'],3);	//encode email
		}
		if(isset($post['json_value']['email'])&&$post['json_value']['email']){
			$post['json_value']['email']=encrypts_decrypts_emails($post['json_value']['email'],3);	//encode email
		}
		if(isset($post['json_value']['post']['npass'])) unset($post['json_value']['post']['npass']);	//unset new password
		if(isset($post['json_value']['post']['cpass'])) unset($post['json_value']['post']['cpass']);	//unset confirm password
		if(isset($post['json_value']['post']['newmail'])) unset($post['json_value']['post']['newmail']);	//unset new mail
		//print_r($post); exit;

		$json_value=jsonencode($post['json_value']);	//convert array into json

		//insert email detail into DB
		db_query(
			"INSERT INTO `{$data['DbPrefix']}email_details`(".	"`clientid`,`tableid`,`mail_type`,`email_from`,`email_to`,`subject`,`message`,`date`,`response_status`,`response_msg`,`json_value`,`status`".
			")VALUES(".
			"'{$post['clientid']}','{$post['tableid']}','{$post['mail_type']}','{$post['email_from']}','{$post['email_to']}','{$post['subject']}','{$post['message']}','{$post['date']}','{$post['response_status']}','{$post['response_msg']}','{$json_value}','{$post['status']}'".
			")",$prnt
		);	
	}
	//exit;
}

//To check clients is sponsor or not.
function is_sponsor_clients($userId,$refeneceId=0){
	$result=0;
	$sponsor=get_sponsor_id(""," `username`='{$userId}' ");
	if(($sponsor==$refeneceId)){
		$result=1;
	}
	return $result;
}

//To retrive / fetch sponser id of a clients
function get_sponsor_id($uid,$userId=''){
	global $data;
	$where_pred=" `id`='{$uid}' ";
	if($userId){
		$where_pred=$userId;
	}
	//fetch sponsor from clients table
	$result=db_rows(
		"SELECT `sponsor` FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE ".$where_pred." LIMIT 1"
	);
	if(isset($result[0]['sponsor'])) return $result[0]['sponsor'];
	
	return;
}

//To retrive / fetch all the details of a sub-admin
function sponsor_details($uid=0,$adminId=''){
	global $data;
	if($adminId){	//To fetch data via username
		$subadmin=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}subadmin`".
			" WHERE `username`='{$adminId}' LIMIT 1"
		); 
	}else{
		$sponsor=get_sponsor_id($uid);	//To retrive / fetch sponser id
		$subadmin=db_rows(	//To fetch data via id
			"SELECT * FROM `{$data['DbPrefix']}subadmin`".
			" WHERE `id`='{$sponsor}' LIMIT 1"
		); 
	}
	$result=array();
	foreach($subadmin as $key=>$value){
		foreach($value as $name=>$v)$result[$key][$name]=$v;	//store values with key in $result array
	}
	return $result;	//return result
}

//To retrive / fetch all the details of a sub-admin from json.
function sponsor_json($uid){
	global $data; $result=array();
	if($uid){
		$subadmin=sponsor_details($uid);	//To retrive / fetch all the details of a sub-admin
		if(isset($subadmin[0]))
		{
			$data['sponsor_id']=$subadmin[0]['id'];				//subadmin id
			$data['sponsor_fr']=$subadmin[0]['username'];		//subadmin username
			$data['domain_name']=$subadmin[0]['domain_name'];	//subadmin domain name
			$more_details=$subadmin[0]['more_details'];			//subadmin other details
		
			if(@$more_details){
				$more_details=json_decode($more_details,true);	//decode json string
				$result=$more_details;
				//$result=array("mailgun_from"=>$more_details['mailgun_from'],"mail_gun_api"=>$more_details['mail_gun_api'],"mail_api_host"=>$more_details['mail_api_host']);
				if(@$more_details['SiteName']){
					$data['SiteName']=$more_details['SiteName'];	//sitename
				}
				if(isset($more_details['Host'])&&$more_details['Host']){
					$data['Host']=$more_details['Host'];			//host name
					$data['domain_url']=$more_details['Host'];		//host name as domain url
				}
				$data['mail_gun_api']=@$more_details['mail_gun_api'];	//mail gun api
				if(isset($more_details['mail_host']) && $more_details['mail_host']){
					$data['mail_host']=$more_details['mail_host'];	//email host
				}
			}
			
			if(isset($data['customer_service_email_subAdmin'])&&trim($data['customer_service_email_subAdmin'])) $data['subAdmin_customer_service_email']=encrypts_decrypts_emails($subadmin[0]['customer_service_email'],2);	//encrypts customer service email
		}
	}
	return $result;
}
//To retrive / fetch all the details of a sub-admin
function sponsor_id_details($id){
	global $data;
	//To fetch data via id
	$subadmin=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}subadmin`".
		" WHERE `id`='{$id}' LIMIT 1"
	);
	$result=array();
	foreach($subadmin as $key=>$value){
		foreach($value as $name=>$v){
			$result[$key][$name]=$v;
			//$result[$key]['more_details']=json_decode($v['more_details'],true);
		}
	}
	return $result;		//return subamin detail 
} 

//To set css color, bgcolor and theme. 
function sponsor_theme($id=0){
	global $data; $result=array();
	if($id>0){
		$asco=sponsor_id_details($id);		//To retrive / fetch all the details of a sub-admin
		$csscolor=@$asco[0]['upload_css'];	//css filename
		
	// For theme color option Added By Vikash
		$header_bg_color	=@$asco[0]['header_bg_color'];		//header back ground color
		$header_text_color	=@$asco[0]['header_text_color'];	//header text color
		$body_bg_color		=@$asco[0]['body_bg_color'];		//bodt back ground color
		$body_text_color	=@$asco[0]['body_text_color'];		//body text color
		$heading_bg_color	=@$asco[0]['heading_bg_color'];		//heading back ground color
		$heading_text_color	=@$asco[0]['heading_text_color'];	//heading text color

		$colors	=clients_css_color($csscolor,'#fff');			// call color theme for clients section
		$bgcolor=$colors[1];		//background color
		$color	=$colors[0];		//text color
		
		$more_details=json_decode(@$asco[0]['more_details'],true);			//more sponsor detail
		$s_host=(isset($more_details['Host'])?$more_details['Host']:'');	//host name
		
		if($data['localhosts']){
			$domain_name=$data['Host'];			//localhost
		}else{
			if($s_host){
				$domain_name=$s_host;
			}elseif($asco[0]['domain_name']){
				$domain_name='https://'.$asco[0]['domain_name'];	//domain name
			}else{
				$domain_name=$data['Host'];
			}
		}
		
	}
	else {
		$color='#726767 !important;color:#fff !important;border:1px solid #726767 !important;';
		$domain_name=$data['Host'];
	}
	
	//Stores all above values in $result array
	$result['color']=(isset($color)?$color:'');
	$result['domainName']=(isset($domain_name)?$domain_name:'');
	// For theme color option Added By Vikash
	$result['header_bg_color']=(isset($header_bg_color)?$header_bg_color:'');
	$result['header_text_color']=(isset($header_text_color)?$header_text_color:'');
	$result['body_bg_color']=(isset($body_bg_color)?$body_bg_color:'');
	$result['body_text_color']=(isset($body_text_color)?$body_text_color:'');
	$result['heading_bg_color']=(isset($heading_bg_color)?$heading_bg_color:'');
	$result['heading_text_color']=(isset($heading_text_color)?$heading_text_color:'');
		
	return $result;	//return
}

//dynamic color apply. To set css color, bgcolor. Default color is WHITE.
function find_css_color($csscolor,$default='#fff'){
	switch ($csscolor) {
		case "green":	//for green theme
			$color='#91ed92 !important;color:#000 !important;';
			$bgcolor='#37a238';
			break;
		case "clk":		//for clk theme
			$color='#91ed92 !important;color:#000 !important;';
			$bgcolor='#37a238';
			break;
		case "sifi":	//for sifi theme
			$color='#91ed92 !important;color:#000 !important;';
			$bgcolor='#37a238';
			break;
		case "yellow":	//for yellow theme
			$color='#f2e480 !important;color:#000 !important;';
			$bgcolor='';
			break;
		case "blue":	//for blue theme
			$color='#ACACDE !important;color:#000 !important;';
			$bgcolor='#5555AE';
			break;
		case "bigo":	//for bigo theme
			$color='#ACACDE !important;color:#000 !important;';
			$bgcolor='#5555AE';
			break;
		case "blueLeftPanel":	//for blueLeftPanel theme
			$color='#ACACDE !important;color:#000 !important;';
			$bgcolor='#3F51B5';
			break;
		case "sys":		//for sys theme
			$color='#ACACDE !important;color:#000 !important;';
			$bgcolor='#3F51B5';
			break;
		case "darkgreen":	//for darkgreen theme
			$color='#8fa895 !important;color:#fff !important;';
			$bgcolor='';
			break;
		case "magenta":	//for magenta theme
			$color='#DAB2C1 !important;color:#000 !important;';
			$bgcolor='#900C3F !important';
			break;
		case "orange":	//for orange theme
			$color='#e6b688 !important;color:#000 !important;';
			$bgcolor='';
			break;
		case "darknavyblue":	//for darknavyblue theme
			$color='#192b33 !important;color:#fff !important;';
			$bgcolor='';
			break;
		case "white":	//for white theme
			$color='#fff !important;color:#999393 !important;';
			$bgcolor='';
			break;
		default:	//default theme
			$color=$default.' !important;';
			$bgcolor='';
	}
	return array($color,$bgcolor);		//return
}// End function

//To set css color, bgcolor and bootstrap theme. Default color is WHITE via bootstrap.
function find_css_color_bootstrap($csscolor,$default='#fff'){
	switch ($csscolor) {
		case "green":	//for green theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#1ec000";
			$root_border_color="#198e03";
			break;
		case "clk":		//for clk theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#91ed92";
			$root_border_color="#3b77b6";
			break;
		case "sifi":	//for sifi theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#91ed92";
			$root_border_color="#3b77b6";
			break;
		case "yellow":	//for yellow theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#ffeb3b";
			$root_border_color="#ffeb3b";
			break;
		case "blue":	//for blue theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#0d6efd";
			$root_border_color="#3b77b6";
			break;
		case "bigo":	//for bigo theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#0d6efd";
			$root_border_color="#3b77b6";
			break;
		case "blueLeftPanel":	//for blue theme - left panel
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#0d6efd";
			$root_border_color="#3b77b6";
			break;
		case "sys":		//for root_text_color theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#0d6efd";
			$root_border_color="#3b77b6";
			break;
		case "darkgreen":	//for dark green theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#8fa895";
			$root_border_color="#3b77b6";
			break;
		case "magenta":	//for magenta theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#DAB2C1";
			$root_border_color="#DAB2C1";
			break;
		case "orange":	//for orange theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#ff9800";
			$root_border_color="#ff5722";
			break;
		case "darknavyblue":	//for dark navy blue theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#192b33";
			$root_border_color="#192b33";
			break;
		case "white":	//for white theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#fff";
			$root_border_color="#fff";
			break;
		default:	//for default theme
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#0d6efd";
			$root_border_color="#3b77b6";
	}
	return array($root_text_color,$root_bg_color,$root_background_color,$root_border_color);
}// End function

//To set css color, bgcolor and theme for clients section. Default color is WHITE.
function clients_css_color($csscolor,$default='#fff'){
	switch ($csscolor) {
		case "green":	//for green theme
			$color='#37a238 !important;color:#fff !important;border:1px solid #37a238 !important;';
			$bgcolor='';
			break;
		case "clk":		//for clk theme
			$color='#37a238 !important;color:#fff !important;border:1px solid #37a238 !important;';
			$bgcolor='';
			break;
		case "sifi":	//for sifi theme
			$color='#37a238 !important;color:#fff !important;border:1px solid #37a238 !important;';
			$bgcolor='';
			break;
		case "yellow":	//for yellow theme
			$color='#e0c606 !important;color:#000 !important;border:1px solid #e0c606 !important;text-shadow:none;';
			$bgcolor='';
			break;
		case "blue":	//for blue theme
			$color='#5555AE !important;color:#fff !important;border:1px solid #5555AE !important;';
			$bgcolor='';
			break;
		case "bigo":	//for bigo theme
			$color='#5555AE !important;color:#fff !important;border:1px solid #5555AE !important;';
			$bgcolor='';
			break;
		case "blueLeftPanel":	//for blue theme - left panel
			$color='#3F51B5 !important;color:#fff !important;border:1px solid #3F51B5 !important;';
			$bgcolor='';
			break;
		case "sys":		//for sys theme
			$color='#3F51B5 !important;color:#fff !important;border:1px solid #3F51B5 !important;';
			$bgcolor='';
			break;
		case "darkgreen":	//for dark green theme
			$color='#577d60 !important;color:#fff !important;border:1px solid #577d60 !important;';
			$bgcolor='';
			break;
		case "magenta":	//for magenta theme
			$color='#900C3F !important;color:#fff !important;border:1px solid #900C3F !important;';
			$bgcolor='#900C3F !important';
			break;
		case "orange":	//for orange theme
			//$color='#e6b688 !important;color:#000 !important;';
			//$bgcolor='';
			break;
		case "darknavyblue":	//for dark navy blue theme
			$color='#192b33 !important;color:#fff !important;border:1px solid #192b33 !important;';
			$bgcolor='#192b33 !important';
			break;
		default:	//for default theme
			$color='#726767 !important;color:#fff !important;border:1px solid #726767 !important;"';
			$bgcolor='#000';
	}
	return array($color,$bgcolor);
}// End function

//To set sponser theme layout. Including frontUi, css style etc.
function sponsor_themef($sid=0,$mid=0,$dataVar=0){
	global $data; $result=array();

	//Initialized variables with null or empty
	$result['LOGO']	=""; 
	$result['STYLE']="";
	$result['STATUS']=false; 

	if($mid>0){
		$get_clientid_details = select_client_table($mid,'clientid_table');		//fetch detail from clients table
		if($get_clientid_details)
		{
			$sid=$get_clientid_details['sponsor'];
			$result['clients']=$get_clientid_details;
		}
	}	
	
	//print_r($get_clientid_details);
	//print_r($get_clientid_details['payin_theme']);
	
	if($sid>0){ 
		$subadmin=select_client_table($sid,'subadmin',0);		//fetch detail from subadmin table
		$result['owner_from']="sponsor_id";
	}
	elseif($sid==0&&$mid==0){	//if clients id and subadmin id is null then fetch active domain data
		$subadmin=db_rows("SELECT * FROM `{$data['DbPrefix']}subadmin` WHERE `domain_name`='{$_SERVER['SERVER_NAME']}' AND `domain_active`=1 LIMIT 1 ",0);
		$result['owner_from']="domain";
		
		if($subadmin) $subadmin=$subadmin[0];
	}
	
	
	if(isset($subadmin)&&$subadmin){	//if subadmin data availabe the define store in $data Array
		if($subadmin['json_log_history'])unset($subadmin['json_log_history']);
		$result['subadmin']=$subadmin;

		if($dataVar){
			$data['sponsor_id']=$subadmin['id'];			//sponsor id
			$data['sponsor_fr']=$subadmin['username'];		//username
			
			$data['domain_name']=$subadmin['domain_name'];	//domain name
			
			if($subadmin['front_ui']){
				$data['frontUiName']=$subadmin['front_ui'];	//UI name
			}
		}
			
		$result['STATUS']=true;
		$result['sub_id']=$subadmin['id'];
		$result['sub_username']=$subadmin['username'];		//username
		$result['sub_admin_css']=$subadmin['upload_css'];	//mapped css
		
		if(isset($get_clientid_details['payin_theme'])&&trim($get_clientid_details['payin_theme']))
		$result['frontUiName']=$subadmin['front_ui']=$get_clientid_details['payin_theme'];
		else 
		$result['frontUiName']=$subadmin['front_ui'];		//UI name
			$data['frontUiName']=$result['frontUiName'];	//UI name
		
		$result['PageTitle']=$subadmin['domain_name'];		//domain name
		$result['STYLE']=$subadmin['custom_css'];			//mapped custom css
		$result['bussiness_url']=$subadmin['bussiness_url'];//business url
		$result['customer_service_no']=$subadmin['customer_service_no'];	//customer service number
		$result['customer_service_email']=encrypts_decrypts_emails($subadmin['customer_service_email'],2);	//email id
		$result['associate_contact_us_url']=$subadmin['associate_contact_us_url'];	//contact us page url
		$result['du1']=$data['all_host'];		//host name
		$result['du2']=$result['PageTitle'];	//page title
		
		//if color code not empty then split colors as theme - hexacode
		if(isset($subadmin['color_code']) && $subadmin['color_code']){
			$color_code=$subadmin['color_code'];
			$result['color_code']=$color_code;
			$result['c']['g']=$color_code;
			$result['c']['gl1']=adc($color_code, 0.1);
			$result['c']['gl2']=adc($color_code, 0.2);
			$result['c']['gl3']=adc($color_code, 0.3);
			$result['c']['gl4']=adc($color_code, 0.4);
			$result['c']['gl5']=adc($color_code, 0.5);
			$result['c']['gl6']=adc($color_code, 0.6);
			$result['c']['gl7']=adc($color_code, 0.7);
			$result['c']['gl8']=adc($color_code, 0.8);
			$result['c']['gl9']=adc($color_code, 0.9);
			$result['c']['gd1']=adc($color_code, -0.1);
			$result['c']['gd2']=adc($color_code, -0.2);
			$result['c']['gd3']=adc($color_code, -0.3);
			$result['c']['gd4']=adc($color_code, -0.4);
			$result['c']['gd5']=adc($color_code, -0.5);
			$result['c']['gd6']=adc($color_code, -0.6);
			$result['c']['gd7']=adc($color_code, -0.7);
			$result['c']['gd8']=adc($color_code, -0.8);
			$result['c']['gd9']=adc($color_code, -0.9);
		}
		
		if(!empty($subadmin['upload_logo'])){
			$result['LOGO']=$data['Path']."/user_doc/".$subadmin['upload_logo'];	//logo
			$data['ADMIN_LOGO']=$result['LOGO'];
		}elseif(!empty($subadmin['logo_path'])){
			$result['LOGO']=$subadmin['logo_path'];	//logo path
		}
		if(!empty($subadmin['logo_path'])){
			//$result['LOGO_ICON']=$data['Host']."/user_doc/".$subadmin['logo_path'];
			$result['LOGO_ICON']=$data['Path']."/user_doc/".$subadmin['logo_path'];	//logo path
			$data['LOGO_ICON']=$result['LOGO_ICON'];	//logo icon
		}
		
		
		$more_details=json_decode($subadmin['more_details'],true);	//other details of subadmin
		$result['as']=$more_details;
	
		if(($more_details) && (($sid==0&&$mid==0) || ($dataVar))){
			if(@$more_details['SiteName']){
				$data['SiteName']=$more_details['SiteName'];	//sitename
			}
			if(isset($more_details['Host'])&&$more_details['Host']){
				$data['Host']		=$more_details['Host'];		//host name
				$data['domain_url']	=$more_details['Host'];		//host name as domain url
			}
			/*if(isset($more_details['Host'])&&$more_details['Host']){
				$data['domain_url']=$more_details['Host'];
			}*/
			

			$data['mail_gun_api']=@$more_details['mail_gun_api'];	//mail gun api
			$data['mail_host']=((isset($more_details['mail_host'])&&$more_details['mail_host'])?$more_details['mail_host']:''); 
			
			if(isset($_REQUEST['e'])){
				echo "<br/><br/><br/>dataVar=>".$dataVar;
				echo "<br/>sid=>".$sid;
				echo "<br/>mid=>".$mid;
				echo "<br/><br/>mail_gun_api=>".$data['mail_gun_api'];
				echo "<br/>mail_host=>".$data['mail_host'];
				echo "<br/><br/>";
			}
		}
		
		if($more_details){
			if((isset($more_details['mailgun_from']))&&($more_details['mailgun_from'])){
				$result['mailgun_from']=$more_details['mailgun_from'];	//from email
			}
			if((isset($more_details['mail_gun_api']))&&($more_details['mail_gun_api'])){
				$result['mail_gun_api']=$more_details['mail_gun_api'];	//mail gun api
			}
			if((isset($more_details['mail_api_host']))&&($more_details['mail_api_host'])){
				$result['mail_api_host']=$more_details['mail_api_host'];	//email host name
			}
			if((isset($more_details['reply_to']))&&($more_details['reply_to'])){
				$result['reply_to']=$more_details['reply_to'];	//reply to email id
				
				$reply_to_name=$more_details['reply_to'];
				if(strpos($more_details['reply_to'],'>')!==false){
					$reply_to_name_ex=explode('<',$more_details['reply_to']);
					$reply_to_name	=$reply_to_name_ex[1];
					$reply_to_email	=explode('>',$reply_to_name);$reply_to_email=$reply_to_email[0];
					$result['reply_to_email']=$reply_to_email;
				}
				if(isset($reply_to_name_ex[0])){
					$result['reply_to_name']=str_replace(['<','>'],'',$reply_to_name_ex[0]);
				}
			}
			if((isset($more_details['SiteName']))&&($more_details['SiteName'])){
				$result['SiteName']=$more_details['SiteName'];	//sitename
			}
		}
		
		
		$s_host=isset($more_details['Host'])?$more_details['Host']:'';	//define hostname
		
		if(isset($_GET['h2'])&&$_GET['h2']==0){$data['localhosts']=0;}
		if($data['localhosts']){
			$domain_name=$data['Host'];		//host name
		}else{
			if($s_host){
				$domain_name=$s_host;
			}elseif($subadmin['domain_name']){
				$domain_name=$data['Prot']."://".$subadmin['domain_name'];	//domain name
			}else{
				$domain_name=$data['Host'];	//host name
			}
		}
		
	}
	else {
		//default color and host name
		$color='#726767 !important;color:#fff !important;border:1px solid #726767 !important;';
		$domain_name=$data['Host'];
	}
	
	if(isset($_GET['h2'])&&$_GET['h2']==1){$domain_name=$data['Host'];}
	
	//$result['color']=$color;
	$result['domainName']=$domain_name;	//domain name

	return $result;	//return
}

//Dev Tech : 23-01-09 compare with modify
//To send an email with attachement
function send_attchment_message($email_to,$email_to_name,$email_subject,$email_message,?array $post = null,$email_from='',$email_reply='')
{
	global $data; 

	//Initialized variables with null or empty
	$owner_from=""; 
	$SiteName="";
	$qp=0;
	if(isset($_GET['qp'])){
		$qp=1;
	}
	
	$email_from_name=$email_from;
	$email_from_value="";
	$email_reply_value="";
	
	$mail_gun_api=""; $mail_migomta_api=""; $mail_juvlon_api="";
	$mail_host="";
		
	//echo "<hr/>mail_host=>".$mail_host;	echo "<hr/>mail_gun_api=>".$mail_gun_api;
	
	
	//define from name and email id
	if(strpos($email_from,'>')!==false){
		$email_from_name=explode('<',$email_from);$email_from_name=$email_from_name[1];
		$email_from_value=explode('>',$email_from_name);$email_from_value=$email_from_value[0];
		//echo "<hr/>email_from_value:".$email_from_value;
	}
	
	//define reply name and email id
	$email_reply_name=$email_reply;
	if(strpos($email_reply,'>')!==false){
		$email_reply_name=explode('<',$email_reply);$email_reply_name=$email_reply_name[1];
		$email_reply_value=explode('>',$email_reply_name);$email_reply_value=$email_reply_value[0];
		//echo "<hr/>email_reply_value:".$email_reply_value;
	}
	
	//define to name and email id
	$email_to_value="$email_to_name <$email_to>";

	// from subadmin table
	/*$result=array("mailgun_from"=>$more_details['mailgun_from'],"mail_gun_api"=>$more_details['mail_gun_api'],"mail_api_host"=>$more_details['mail_api_host']);*/

	// by clients id
		
	
		
	$email_details=sponsor_json(((isset($post['clientid'])&&$post['clientid'])?$post['clientid']:''));	//email details
	//print_r($email_details);

	if((isset($email_details['mailgun_from']))&&($email_details['mailgun_from'])){
		$email_from=$email_details['mailgun_from'];	//from email
		
		if((isset($email_details['mail_gun_api']))&&($email_details['mail_gun_api'])){
			$mail_gun_api=$email_details['mail_gun_api'];	//mail gun api
		}
		if((isset($email_details['mail_migomta_api']))&&($email_details['mail_migomta_api'])){
			$mail_migomta_api=$email_details['mail_migomta_api']; // mail migomta api
		}
		if((isset($email_details['mail_juvlon_api']))&&($email_details['mail_juvlon_api'])){
			$mail_juvlon_api=$email_details['mail_juvlon_api']; // mail migomta api
		}
		if((isset($email_details['mail_api_host']))&&($email_details['mail_api_host'])){
			$mail_host=$email_details['mail_api_host'];		//email host name
		}
		if((isset($email_details['reply_to']))&&($email_details['reply_to'])){
			$email_reply=$email_details['reply_to'];		//email for reply back
		}
		if((isset($email_details['SiteName']))&&($email_details['SiteName'])){
			$SiteName=$email_details['SiteName'];			//Sitename
		}
		$owner_from="sponsor_id";
	}
	else{
		// get domain wise 
	
		$domain_server=domain_serverf("","admin");
		//$domain_server=domain_serverf("checkdebit.net","admin");

		if((isset($domain_server['as'])&&isset($domain_server['STATUS']))&&($domain_server['STATUS']==true)){
			
			if((isset($domain_server['as']['mailgun_from']))&&($domain_server['as']['mailgun_from'])){
				$email_from=$domain_server['as']['mailgun_from'];	//from email
			}

			if((isset($domain_server['as']['mail_gun_api']))&&($domain_server['as']['mail_gun_api'])){
				$mail_gun_api=$domain_server['as']['mail_gun_api'];	//mail gun api
			}
			if((isset($domain_server['as']['mail_migomta_api']))&&($domain_server['as']['mail_migomta_api'])){
				$mail_migomta_api=$domain_server['as']['mail_migomta_api'];  // mail migomta api
			}
			if((isset($domain_server['as']['mail_juvlon_api']))&&($domain_server['as']['mail_juvlon_api'])){
				$mail_juvlon_api=$domain_server['as']['mail_juvlon_api'];  // mail migomta api
			}
			if((isset($domain_server['as']['mail_api_host']))&&($domain_server['as']['mail_api_host'])){
				$mail_host=$domain_server['as']['mail_api_host'];	//email host name
			}
			
			if((isset($domain_server['as']['reply_to']))&&($domain_server['as']['reply_to'])){
				$email_reply=$domain_server['as']['reply_to'];		//email for reply back
			}
			
			if((isset($domain_server['as']['SiteName']))&&($domain_server['as']['SiteName'])){
				$SiteName=$domain_server['as']['SiteName'];			//Sitename
			}
			$owner_from="domain";
		}
	
	}

	
		
	
	
	$email_from=trim($email_from);			//remove blank spaces from email
	$email_to_value=trim($email_to_value);	//remove blank spaces from email
	
	//store values into array for further use
	
	$postArray=array();
	$postArray['from']=$email_from;
	$postArray['to']=$email_to_value;
	if($email_reply){
		$postArray['h:Reply-To']=$email_reply;
	}
	$postArray['subject']=$email_subject;
	$postArray['html']=$email_message;
	
	
	$post['json_value']['from']=$postArray['from'];
	$post['json_value']['to']=$postArray['to'];
	$post['json_value']['h:Reply-To']=$email_reply;
	if(isset($mail_gun_api)&&trim($mail_gun_api)) $post['json_value']['mail_gun_api']=$mail_gun_api;
	if(isset($mail_migomta_api)&&trim($mail_migomta_api)) $post['json_value']['mail_migomta_api']=$mail_migomta_api;
	if(isset($mail_juvlon_api)&&trim($mail_juvlon_api)) $post['json_value']['mail_juvlon_api']=$mail_juvlon_api;
	if(isset($post['EMAIL_KEY'])){
		$post['json_value']['EMAIL_KEY']=$post['EMAIL_KEY'];
	}
	$post['json_value']['mail_host']=$mail_host;
	$post['json_value']['SiteName']=$SiteName;
	$post['json_value']['Host']=$data['Host'];
	$post['json_value']['owner_from']=$owner_from;
	$post['json_value']['sponsor_id']=(isset($data['sponsor_id'])?$data['sponsor_id']:'');
	$post['json_value']['sponsor_fr']=(isset($data['sponsor_fr'])?$data['sponsor_fr']:'');
	if(isset($_SERVER['HTTP_REFERER'])){
		$post['json_value']['referer_'.date('Y-m-d H:i:s')]=$_SERVER['HTTP_REFERER'];
	}
	if(isset($_SERVER['PHP_SELF'])){
		$post['json_value']['self_'.date('Y-m-d H:i:s')]=$_SERVER['PHP_SELF'];
	}
	if($data['urlpath']){
		$post['json_value']['urlpath_'.date('Y-m-d H:i:s')]=$data['urlpath'];
	}
	
	//unset card information before json update
	if(isset($_GET)){
		$unsetPramGet=$_GET;
		unset($unsetPramGet['ccno']);
		unset($unsetPramGet['month']);
		unset($unsetPramGet['year']);
		unset($unsetPramGet['ccvv']);
		
		$post['json_value']['get_'.date('Y-m-d H:i:s')]=$unsetPramGet;
	}
	
	
	

	
	
	if(isset($_GET['qp'])){
		echo "<hr/>email_to_value=>".$email_to_value." ".$email_to; echo "<hr/>email_from=>".$email_from." ".$email_from_value; echo "<hr/>mail_gun_api=>".$mail_gun_api; echo "<hr/>mail_api_host=>".$mail_host; echo "<hr/>email_reply=>".$email_reply; 
		echo "<hr/>post=>";print_r($post);
		//exit;
	}
	//$postArray['attachment']=curl_file_create('FULL_PATH_TO_ATTACHMENT');
	if(isset($_GET['qp'])){
		print_r($postArray);
	}
	
	
	$mgun=1; $mgun_db=1;
	if(isset($_GET['m'])){ $mgun=0; }
	//cm
	//$mgun=0;
	
	if(strpos($postArray['subject'],'[customer_name] - [transaction_id]')!==false){
		$mgun=0;$mgun_db=0;
	}
	
	// default_mail_send
	
	//Dev Tech : 23-01-06 for multiple email api files - send email by curl
	
	if($mgun)
	{
		//file use for email api like: mailgun, migomta
		
		if(isset($mail_juvlon_api)&&trim($mail_juvlon_api)){
			$juvlon_email_api_file=$data['Path'].'/third_party_api/juvlon_email_api_file'.$data['iex'];
			if(file_exists($juvlon_email_api_file)) include($juvlon_email_api_file);
			else { echo "Not found : ".$juvlon_email_api_file; exit; }
		}
		elseif(isset($mail_migomta_api)&&trim($mail_migomta_api)){
			$migomta_email_api_file=$data['Path'].'/third_party_api/migomta_email_api_file'.$data['iex'];
			if(file_exists($migomta_email_api_file)) include($migomta_email_api_file);
			else { echo "Not found : ".$migomta_email_api_file; exit; }
		}
		elseif(isset($mail_gun_api)&&trim($mail_gun_api)){
			$mailgun_email_api_file=$data['Path'].'/third_party_api/mailgun_email_api_file'.$data['iex'];
			if(file_exists($mailgun_email_api_file)) include($mailgun_email_api_file);
			else { echo "Not found : ".$mailgun_email_api_file; exit; }
		}
		else{
			'Incomplete json format via '.$owner_from.' in partner gateways -  '.(isset($data['sponsor_id'])?$data['sponsor_id']:'');
			exit;
		}
		
		/*		$default_mail_send=$data['Path'].'/third_party_api/default_mail_send'.$data['iex'];
		if(file_exists($default_mail_send)){ include($default_mail_send); }
		*/
	}
	
	if(isset($_POST)){
		$unsetPramPost=$_POST;
		$unsetPramPost['time']=date('Y-m-d H:i:s');
		unset($unsetPramPost['ccno']);
		unset($unsetPramPost['month']);
		unset($unsetPramPost['year']);
		unset($unsetPramPost['ccvv']);
		$post['json_value']['post']=$unsetPramPost;
	}
	
	//store values in $post array
	
	if(!isset($post['clientid'])){$post['clientid']=-10;}
	if(!isset($post['tableid'])){$post['tableid']=-11;}
	if(!isset($post['mail_type'])){$post['mail_type']="10";}
	
	
	
	$post['email_from']=$email_from;
	$post['email_to']=$email_to_value;
	$post['subject']=replacepost($email_subject);
	//$post['message']="email_message";//$email_message
	$post['message']=replacepost($email_message,'message');
	$post['date']=date('Y-m-d H:i:s');
	//$post['date']=date('Y-m-d H:i:').(date('s')+fmod(microtime(true), 1));
	
	//cmn	//$post['response_status']=(isset($json_decode['message'])?$json_decode['message']:'');
	

	$post['response_msg']=$result;
	if(@$post['response_status']=="Queued. Thank you."){
		//echo "<hr/>successfully send email<hr/>";
		$post['status']=1;
	}else{
		$post['status']=2;
	}
	
	
	if($qp){
		echo "<hr/>send_attchment_message=>";
		print_r($post);
	}
   
   if($mgun_db){
		insert_email_details($post);
   }
   
	return $result;		//return
}



// To send an email with complete detail.
function send_email($key, $post, $sponsorJsn=0){
	global $data; $pst=array();
	
	if(isset($post['prnt'])){$pst['prnt']=$post['prnt'];}
	
	if(((!isset($post['clientid'])) || (empty($post['clientid'])))&&(isset($post['uid'])&&$post['uid'])){ $post['clientid']= $post['uid'];}
	
	if(isset($post['clientid'])&&$sponsorJsn==0){
		$email_details=sponsor_json($post['clientid']);
		if((isset($email_details['mailgun_from']))&&($email_details['mailgun_from'])){
			$email_from=$email_details['mailgun_from'];		//from email
		}
	
		if((isset($email_details['mail_gun_api']))&&($email_details['mail_gun_api'])){
			$mail_gun_api=$email_details['mail_gun_api'];	//mail gun api
		}
		if((isset($email_details['mail_migomta_api']))&&($email_details['mail_migomta_api'])){
			$mail_migomta_api=$email_details['mail_migomta_api'];
		} // mail migomta api
		if((isset($email_details['mail_api_host']))&&($email_details['mail_api_host'])){
			$mail_host=$email_details['mail_api_host'];		//email host name
		}
	}
	
	//fetch email template from emails table via $key
	$template=db_rows(
		"SELECT `name`,`value` FROM `{$data['DbPrefix']}emails_templates`".
		" WHERE `key`='{$key}'"
	);
	$text	=@$template[0]['value'];
	$subject=@$template[0]['name'];

	if(empty($subject)){	//If no any template available then print following error and break
		$err_5010=[];
		$err_5010['Error']="5010";
		$err_5010['Message']="Email {$key} template does not exist.";
		json_print($err_5010);
	}
	
	

	//In the following section replace dynamic values in body and subject in place of define words in [], in Email template
	

	// Dev Tech : 25-02-25 SEND_EMAIL_ARR is dynamic fetch from $post and value is empty or null then remove  
	if (isset($data['SEND_EMAIL_ARR']) && !empty($data['SEND_EMAIL_ARR'])) 
	{
		foreach ($data['SEND_EMAIL_ARR'] as $v9) {
			// Check if the value exists in $post and is not empty after trimming
			if (isset($post[$v9]) && trim($post[$v9]) !== '') {
				// Replace placeholders in text and subject with the value from $post
				if (strpos($text, "[$v9]") !== false) {
					$text = str_replace("[$v9]", $post[$v9], $text);
				}
				if (strpos($subject, "[$v9]") !== false) {
					$subject = str_replace("[$v9]", $post[$v9], $subject);
				}
			} else {
				// If the value is empty or null, remove the placeholder by replacing it with an empty string
				if (strpos($text, "[$v9]") !== false) {
					$text = str_replace("[$v9]", '', $text);
				}
				if (strpos($subject, "[$v9]") !== false) {
					$subject = str_replace("[$v9]", '', $subject);
				}
			}
		}
	}

	// Replace &nbsp; with a regular space in both text and subject
	$text = str_replace('&nbsp;', ' ', $text);
	$subject = str_replace('&nbsp;', ' ', $subject);

	
	if(isset($post['username'])&&$post['username']){	//username
		$text=str_replace("[usersite]", "{$data['Host']}/?rid={$post['username']}", $text);
	}	
	if(isset($post['username_rec']) && $post['username_rec']){	//username link
		$text=str_replace("[usersite]", "{$data['Host']}/?rid={$post['username']}", $text);
	}
	
	if(isset($post['ccode']) && $post['ccode'])$text=str_replace("[confcode]", $post['ccode'], $text);	//ccode
	if(isset($post['chash']) && $post['chash'])$text=str_replace("[confhash]", $post['chash'], $text); //hash
	
	
	
	$text=str_replace("[ex]", "{$data['ex']}", $text);	//extension
	$text=str_replace("[emailpage]", "{$data['USER_FOLDER']}/verifemail{$data['ex']}", $text);	//verify link
		//email id
	$text=str_replace("[sitename]", $data['SiteName'], $text);	//site name in body
	$subject=str_replace("[sitename]", $data['SiteName'], $subject);	//sitename in subject
	$text=str_replace("[hostname]", $data['Host'], $text);	//host name in body
	$subject=str_replace("[hostname]", $data['Host'], $subject);	//host name in subject
	$text=str_replace("[adminemail]", (isset($data['AdminEmail'])?$data['AdminEmail']:''), $text);	//admin email id in body
	$subject=str_replace("[adminemail]", (isset($data['AdminEmail'])?$data['AdminEmail']:''), $subject);	//admin email id in subject
	$text=str_replace("[singpage]", "{$data['Host']}/signup{$data['ex']}", $text);	//sign page
	$text=str_replace("[resetpasswordurl]", "{$data['Host']}/reset_password{$data['ex']}", $text);	//reset password link / url
	$text=str_replace("[confpage]", "{$data['USER_FOLDER']}/confirm{$data['ex']}", $text);	//confirm page url
	$text=str_replace("[lognpage]", "{$data['Host']}/login{$data['ex']}", $text);	//login page url

	//pay request link
	$text=str_replace("[payrequest]", "<a href='{$data['Host']}/checkout{$data['ex']}?bid=".(isset($post['transactioncode'])?$post['transactioncode']:'')."' style='display:block;background:#d74a38;width:200px;font-size:24px;color:#fff;line-height:40px;text-decoration:none;text-align:center;border-radius:3px;margin:10px;margin-left:0;'>Pay Now!</a>", $text);
	
	//add new line 
	if(isset($post['payUrl'])&&$post['payUrl']) {
		$subject=str_replace("[payrequest]", $post['payrequest'], $subject);// subject
	}
	
	
	$text=str_replace("[subadminlognpage]", "{$data['Admins']}/login{$data['ex']}", $text);	//admin / subadmin login url
	
	$text=str_replace("[subadminlognpage]", "{$data['slogin']}/login{$data['ex']}", $text);//subadmin login url
	
	//transaction fee
	$text=str_replace("[fees_tr]", (isset($post['fees_tr'])?$data['Currency'].$post['fees_tr']:''),$text);

	//product amount per unit
	if(isset($post['product_amount']) && $post['product_amount'])$text=str_replace("[product_amount]", $data['Currency'].($post['product_amount']), $text);
	
	//total amount
	if(isset($post['amount']) && $post['amount'])$text=str_replace("[amount]", $data['Currency'].($post['amount']), $text);
	
	//create email header
	$header	= "MIME-Version: 1.0\r\n";
	$header.= "Content-type: text/html; charset=utf-8\r\n";
	if(isset($data['AdminEmail']))
		$header .= "From: {$data['AdminEmail']}\r\n";
	
	if(isset($post['email_header'])){
		
	}else{
		$text = nl2br($text);
	}
	
	if(isset($post['email_br'])){
		$text = nl2br($text);
	}
	
	$htmlheader = '';
	
	$htmlfooter = '';
	
	
	if(isset($post['email_he_on'])){
		/*
		if(isset($data['domain_server']['LOGO'])&&trim($data['domain_server']['LOGO'])){
			$logo_src=encode_imgf($data['domain_server']['LOGO']);
			$logo="<img style=\"height:70px;display:block;margin:0 auto;\" src={$logo_src} />";
		} else{ 
			$logo=$data['SiteName'];
		}
		
		$htmlheader = "<div style=\"background-color:#d9d9d9;width:96%;height:90px;padding:15px;padding-left:2%;padding-right:2%;\"><a href=\"{$data['Host']}\" style=\"text-align:center;line-height:70px;font-size:20px;\">{$logo}</a></div><table align=\"center\" style=\"width:100%;padding:20px;font-size:14px;\"><tr><td>";
		
		$htmlfooter = '</td></tr></table><table align="center" style="background-color:#d9d9d9;color:red;width:100%;padding:20px;"><tr><td><p style="text-align:center;padding-top:10px;font-size:12px;">Disclaimer : This is an automated email. Please do not reply to it. <br></p></td></tr></table>';
		*/
	
	}
	
	$messages = $text;
	
	if(isset($post['email_he_on'])){
		$messages = $htmlheader.$text.$htmlfooter;
	}
	
	if(isset($_GET['test'])){
		echo"<hr/>transaction_id=>".$post['transaction_id'];
		echo"<hr/>email=>".$post['email'].
		"<hr/>subject=>".$subject.
		"<hr/>header=>".$header.
		"<hr/>messages=>".$messages;
		
		//exit;
	}
	
	$pst['EMAIL_KEY']=$key;
	
	if(isset($post['clientid'])){$pst['clientid']=$post['clientid'];}
	if(isset($post['tableid'])){$pst['tableid']=$post['tableid'];}
	if(isset($post['mail_type'])){$pst['mail_type']=$post['mail_type'];}else{$pst['mail_type']="4";}
	
	
	//@mail('mithilesh@eskaydesksolutions.com', stripslashes($subject), $messages, $header);
	//return @mail($post['email'], $subject, $messages, $header);
	
	if(isset($post['registered_email'])&&trim($post['registered_email'])&&(!isset($post['email']) || empty($post['email']))) 
			$post['email']=$post['registered_email'];
	
	
	if(isset($post['email'])&&trim($post['email'])) 
		send_attchment_message($post['email'],$post['email'],$subject,stripslashes($messages),$pst);
	
	if(isset($data['subAdmin_customer_service_email'])&&trim($data['subAdmin_customer_service_email'])){
		$post['email']=$data['subAdmin_customer_service_email'];
		send_attchment_message($post['email'],$post['email'],$subject,stripslashes($messages),$pst);
	}
	if(isset($data['testEmail_1_developer'])&&trim($data['testEmail_1_developer'])){
		$post['email']=$data['testEmail_1'];
		send_attchment_message($post['email'],$post['email'],$subject,stripslashes($messages),$pst);
	}
}
//Complete the pairs in json values. (Fixed json values if any type of error in json.)
function jsonvaluef($theArray,$keyName,$array2=''){

	//$theArray1=str_replace(array('{"','"}','": "','", "'),array('','","','":"','","'),$theArray);

	if (!is_null($theArray)) {
		$theArray1 = str_replace(array('{"','"}','": "','", "'), array('','","','":"','","'), $theArray);
	} else {
		// Handle the case when $theArray is null, depending on your needs
		$theArray1 = ''; // or [] if you expect an array
	}

	
	if((!empty($theArray1))&&(strpos($theArray,$keyName)!==false)){
		if(!empty($array2)){
			$theArray1=explode($array2, $theArray1); 
			$theArray1=$theArray1[1];
		}
		$keyName1=explode($keyName.'":"', $theArray1);
		if(!empty($keyName1[1])){
			$keyName2=explode('","', $keyName1[1]);
			return $keyName2[0];
		}
	}
}

##############################################################################

//Return the output in json format when use curl
function json_print($json_array,$json=true){
	header("Content-Type: application/json", true);	
	echo $arrayEncoded2 = jsonencode($json_array);
	exit;
}

//retrive transaction from micro_transaction_table, but currently not in use
function micro_trans($uid=0,$all=false,$tableid=0){
	global $data;$result=array();$where =" ";$limit="LIMIT 1";
	if($uid>0){$where =" AND (`merID_id`='{$uid}') ";}
	if($all==true){$limit="";}else{if($tableid==0){$where .=" AND (`status`=1) ";}}
	if($tableid>0){$where .=" AND (`id`='{$tableid}') "; }
	$result=db_rows(
		"SELECT * ".
		" FROM `{$data['DbPrefix']}micro_transaction_table` WHERE (`id`!='') ".$where.
		" ORDER BY `date_of_micro_trans` DESC ".$limit." "//,true
	);
	return $result;
}

//currently not in use
function riskratio_mer($total_ratio,$charge_back_fee=0,$card=true){
	
	$results['total_ratio']=$total_ratio;
	/*
	if($card==true){ // in case of card
		if($results['total_ratio']>=0&&$results['total_ratio']<=1){$results['lead_class']="lead_green";$results['lead_color']="#3cd632";$results['charge_back_fee']=$charge_back_fee_1;}
		elseif($results['total_ratio']>1 && $results['total_ratio']<=3){$results['lead_class']="lead_red";$results['lead_color']="#DA4453";$results['charge_back_fee']=$charge_back_fee_2;}
		elseif($results['total_ratio']>3 && $results['total_ratio']<=100){$results['lead_class']="lead_darkred";$results['lead_color']="#ab0c0c";$results['charge_back_fee']=$charge_back_fee_3;}
		
		$results['risk_type']="Chargeback Ratio";
		
	}else{ // in case of eCheck
		if($results['total_ratio']>=0&&$results['total_ratio']<=10){$results['lead_class']="lead_green";$results['lead_color']="#3cd632";$results['charge_back_fee']=$charge_back_fee_1;}
		elseif($results['total_ratio']>10 && $results['total_ratio']<=20){$results['lead_class']="lead_red";$results['lead_color']="#DA4453";$results['charge_back_fee']=$charge_back_fee_2;}
		elseif($results['total_ratio']>20 && $results['total_ratio']<=100){$results['lead_class']="lead_darkred";$results['lead_color']="#ab0c0c";$results['charge_back_fee']=$charge_back_fee_3;} 
		
		$results['risk_type']="Risk Ratio";
	}
	*/
	$results['charge_back_fee']=$charge_back_fee;
	return $results;
	
}


##############################################################################

//define customize number format
function number_formatf($amount){
	$amount1=str_replace(",","",(double)$amount);
	if(strpos((double)$amount,".")!==false){
		return $amount;
	}else{
		return number_format((double)$amount1, '2', '.', '');
	}
}

//define customize number format
function number_formatf2_ba($amount=0,$frmt=2){
	$amount = trim($amount);
	if(empty($amount) || $amount==NULL) $amount = 0;
	$amount=preg_replace("/[^0-9\.-]/", '', $amount);
	if (is_numeric($amount)) return number_format($amount, $frmt, '.', '');
	return 0;
}

// Define customize number format with comma separate 
function number_formatf2($amount = 0, $frmt = 2) {
    // Ensure $amount is a string before trimming
    $amount = is_string($amount) ? trim($amount) : (string)$amount;

    // If the amount is empty or null, set it to 0
    if (empty($amount)) {
        $amount = 0;
    }

    // Remove any non-numeric characters except for decimal point and negative sign
    $amount = preg_replace("/[^0-9\.-]/", '', $amount);

    // Check if the amount is numeric and format it
    if (is_numeric($amount)) {
        return number_format($amount, $frmt, '.', '');
    }

    return 0;
}


// Define customize number format
function number_formatf_2($amount) {
    // Ensure $amount is a string or set it to an empty string if null
    $amount = is_string($amount) ? $amount : (string)$amount;

    // Remove commas from the amount
    $amount = str_replace(",", "", $amount);

    // Format the number and return it
    return number_format((double)$amount, 2, '.', '');
}

// Define customize number format with comma separate 
function number_format_comma($amount = 0, $frmt = 2) {
    // Ensure $amount is a string before trimming
    $amount = is_string($amount) ? trim($amount) : (string)$amount;

    // If the amount is empty or null, set it to 0
    if (empty($amount)) {
        $amount = 0;
    }

    // Remove any non-numeric characters except for decimal point and negative sign
    $amount = preg_replace("/[^0-9\.-]/", '', $amount);

    // Check if the amount is numeric and format it
    if (is_numeric($amount)) {
        return number_format($amount, $frmt, '.', ',');
    }

    return 0;
}


// The function number_formatf_3() returns value in RED color if value is negative, return in GREEN, comma separate 
function number_formatf_3($summ, $splus = true) {
    global $data;
    $color = ($summ < 0) ? 'red' : 'green';
    return "<font color='{$color}'>" . number_format_comma($summ) . '</font>';
}

// The function number_formatf_3() returns value in RED color if value is negative, return in GREEN, comma separate 
function number_formatf_4($summ, $curr_sys = '') {
    global $data;
    $color = ($summ < 0) ? 'red' : 'green';

	$summ_get=number_format_comma($summ);
	$summ_get=$curr_sys.@$summ_get;
	if(trim($curr_sys)) $summ_get=str_replace($curr_sys."-","-".$curr_sys,$summ_get);

    return "<font color='{$color}'>" . @$summ_get . '</font>';
}

//Fetch all the details via clientid for like table of payin_setting, payout_setting, softpos_setting
function clientidf($uid,$tbl='payin_setting',$unsetID=1,$prnt=0){
	global $data;
	if($uid){
		$result=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}{$tbl}`".
			" WHERE `clientid`='{$uid}' LIMIT 1",$prnt
		);
		if($unsetID) unset($result[0]['id']);
		if(isset($result[0])) return $result[0];	//return a row
	}
	return ;
}

//Fetch all the details of a client via id. Use of this function we can also fetch data from any table via using primary key (id)
function select_client_table($uid,$tbl='clientid_table',$prnt=0){
	global $data;
	if($uid){
		//fetch data from table
		$result=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}{$tbl}`".
			" WHERE `id`='{$uid}' LIMIT 1",$prnt
		);
		
		$result=@$result[0];
		
		if($tbl=='clientid_table'){
			$payin_setting_get=clientidf($uid);
			if(isset($payin_setting_get)&&is_array($payin_setting_get)&&isset($result)&&is_array($result))
				$result=array_merge($result,$payin_setting_get);
		}
		
		if(isset($result)) return $result;	//return a row
	}
	return ;
}

//Use of this function we can fetch data from table of master_trans_table and if master_trans_additional via using primary key (id) or transID
function trans_db($id,$transID=0,$where_pred="",$prnt=0){
	global $data; 
	
	if(empty($where_pred)){
		if($id>0){$where_pred =" (`id`='{$id}') ";}
		elseif($transID>0){$where_pred =" (`transID`='{$transID}') ";}
	}
	
	if(!empty($where_pred)){
		
		//Select Data from master_trans_additional
		$join_additional=join_additional();
		
		$result=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" {$join_additional}  WHERE {$where_pred} LIMIT 1",$prnt
		);
		
		return $result[0];	//return a row
		
	}else{
		return "Not Available Table Id and Table Name";
	}
}

//Dev Tech : 23-11-30 switch for more db instance for find the function config_db_con_more from if include name of config_db_con_more 
function more_db_conf($class1='',$class2='px-1 fa-fw')
{
	if(function_exists('config_db_con_more')){
		 config_db_con_more($class1,$class2);
	}
}

//Dev Tech : 24-01-13 pagination for more db instance for find the function config_db_con_more_duration from if include name of config_db_con_more_duration 
function more_db_conf_pages($class1='')
{
	if(function_exists('config_db_con_more_duration')){
		 config_db_con_more_duration($class1);
	}
}

//Use of this function we can fetch data from any table via using primary key (id)
function select_table_details($uid,$tbl='',$prnt=0){
	global $data;
	if($tbl){
		//fetch data from table
		$result=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}{$tbl}`".
			" WHERE `id`='{$uid}' LIMIT 1",$prnt
		);
		return $result[0];	//return a row
	}else{
		return "Not Available Table Id and Table Name";
	}
}

//Fetch all details or one or more fields from any table via using customized conditions
function select_tablef($where_pred='',$tbl='',$prnt=0,$limit=1,$select='*',$default_db_connect=0){
	global $data;
	if($tbl){
		//fetch data from table
		$q="SELECT {$select} FROM `{$data['DbPrefix']}{$tbl}`".
			" WHERE {$where_pred} ".($limit?" LIMIT 1 ":"")." ";
			
		$result=db_rows_df($q,$prnt,$default_db_connect);
	
		if($limit && isset($result[0])){
			return $result[0];	//return a row
		}else{
			return $result;		//return rows
		}
	}else{
		return "Not Data Available";		//return empty
	}
}

//Fetch all details or one or more fields from any table via using customized conditions from payout DB
function select_tablep($where_pred='',$tbl='',$prnt=0,$limit=1,$select='*'){
	global $data;
	if($tbl){
		$result=db_rows_2(
			"SELECT {$select} FROM `{$data['DbPrefix']}{$tbl}`".
			" WHERE {$where_pred} ".($limit?" LIMIT 1 ":"")." ",$prnt
		);
		if($limit && isset($result[0])){
			return $result[0];	//return a row
		}else{
			return $result;		//return rows
		}
	}else{
		return "Not Data Available";	//return empty
	}
}
//To remove minus (-) symbol
function str_replace_minus($str){
	return str_replace("-","",$str);
}
//explode transID and get only one required value
function ordersetf($transID,$no=0){
	$result='';
	if(!empty($transID)){
		$id_orders = explode('_',$transID);	//explode transID via hyphen (_)
		if(isset($id_orders)&&$id_orders&&isset($id_orders[$no])){	//check specific array key exists or not
			$result=$id_orders[$no];	//store value specific array value into $result
		}
	}
	return $result;	//return order number
}

//explode transID and get only one required value
function transIDf($transID,$no=0){
	$result='';
	if(!empty($transID)){
		$transID_exp = explode('_',$transID);	//explode transID via hyphen (_)
		if(isset($transID_exp)&&$transID_exp&&isset($transID_exp[$no])){	//check specific array key exists or not
			$result=$transID_exp[$no];	//store value specific array value into $result
		}
	}
	$result=preg_replace("/[^0-9.]/", "",@$result);
	return $result;	//return order number
}

//========= For Writing / reading/ deleting logs //====================
$extn=$data['iex'];
$data['log_directory'] = $_SERVER['DOCUMENT_ROOT'].$data['subfolder']."/log/";	//set path for log file
// function to update/re-write log file
function wh_log($logs,$filename='apilog',$append=0){
	
	global $extn,$data,$ztspaypci; 
	
	if($ztspaypci==false||$append==true){
		
		//date_default_timezone_set("Asia/Kolkata");
		$t=time();
		$dt=date("d-M-Y | h:i:sa",$t);
		$log_directory = $data['log_directory'];
		
		if (!file_exists($log_directory))
		{
			// create directory/folder uploads.
			mkdir($log_directory, 0777, true);
		}
		$log_msg="\n\nLog Date: ".$dt.":<xmp>".$logs."</xmp>\n";
		$log_file_path = $log_directory.'/'.$filename.$extn;
		
		//write log file
		if (!file_put_contents($log_file_path, $log_msg, FILE_APPEND)){echo 'could not save log';exit;}
	}
}// end function
// function to delete older log
function delete_file_linewise($files='apilog'){
	
	global $extn,$data,$ztspaypci; 
	
	if($ztspaypci==false){	//if ztspaypci is false then remove rows from apilog
	
		$file	= $data['log_directory'].$files.$extn;	//filename with full path
		$line_no= $lno = 0;
		$fname	= $file;
		$out	= $first = '';
		$lines	= file($fname);

		foreach($lines as $line) {
			$lno++;
			if($lno<=25) {$first .= $line;}		//retrive first 25 lines which is not remove
		}
		for ($i=0;$i<=8;$i++){
			$lno =0;
			$dt=date('d-M-Y', strtotime('-'.$i.' days'));

			foreach($lines as $line) {
				$lno++;
				if((strstr($line, $dt) )&& ($lno>25)) {$out .= $line."\n\n";}	//retrive above line number 25 if log not more than 8 days old, which is not remove 
			} // End for each
		}// end if
		
		$f = fopen($fname, "w");	//open log file in write modee
		fwrite($f, $first.$out);	//re-write log file again
		fclose($f);
	}
}// End Function Delete

// Function to Search contents from a log file (logs)
function Search_Logs(){
	global $extn;
	global $data;
	
	$file=$data['log_directory'].$_POST['filename'].$extn;	//filename with full path
	$msg ='';
	if (!file_exists($file)){$msg="Log file (".$_POST['filename'].") not found";}
	else {

		$search	= $_POST['txtsearch'];		//search text
		$lines	= file($file);				//reads a file into an array (line by line).
		$lines	= array_reverse($lines);	//reverse the array
		$count	= (count($lines))-25;

		if($count<1){$msg='No match found';return $msg;} //if file is empty then return 'No match found'

		// Store true when the text is found
		$found = false;
		$i=0;
		$lno=0;
		foreach($lines as $line)
		{
			if ($search==''){
				// show result if search was blank
				if(($lno<$count)&&($line!="\n")&&($line!="")){
					$found = true;
					$i++;
					$msg .='<p><b>#'.$i."</b>) ".$line.'</p>';
					if ($i>200){return $msg;}
				}// end if
			}
			else {
				// show result if search string 
				if((strpos(strtolower($line), strtolower($search)) !== false)&&($lno<$count)){
					$found = true;
					$i++;
					$msg .='<p><b>#'.$i."</b>) ".$line.'</p>';
				}// end if
			}// end if
			$lno++;
		}//End for each
		// Alert of Empty search
		if(!$found){$msg='No match found';}	
	}// End If
	return $msg;
}//End Function

//The parseStringf() function is used to remove unpair symbols from a json. eg. \, ", ' etc. 
function parseStringf($string) {
	$string = str_replace("\\", "", $string);
	$string = str_replace('"{', "{", $string);
	$string = str_replace('}"', "}", $string);
	return '"'.$string.'"';
}

//The jsonen() function is used to encode a array into JSON format or fetch via ajax
function jsonen($arrRes){
	$resArray = json_encode($arrRes,JSON_UNESCAPED_UNICODE);
	$resArray=urldecodef($resArray);
	//remove tab and new line from json encode value 
	$resArray = preg_replace('~[\r\n\t]+~', '', $resArray);		
	$resArray=stripslashes($resArray); 
	//$resArray=str_replace(array('"{','}"','"[',']"'),array('{','}','[',']'),$resArray);
	$resArray=str_replace(array('"{','}"'),array('{','}'),$resArray);
	
	//$_SESSION['resArray']=$resArray;
	
	header('Content-type:application/json;charset=utf-8');
	echo $resArray;exit;
}
	
//The jsonencode1() function is used to encode a array into JSON format.
function jsonencode1($str,$str2='',$formCount=0){
	
	if(!empty($str2)){
		$str=$str2;
	}
	
	if (is_array($str)){ 
		$str=json_encode($str, JSON_UNESCAPED_UNICODE);		//array to json
	}else{
		//$str=$str;
		$str=str_replace(array('"{','}"',':{","'),array('{','}',':{"'),$str);	//fixed json error
		if($formCount){
			$count1=count(explode('{',$str));	//explode via '{'
			$count2=count(explode('}',$str));	//explode via '}'
			if($count1!=$count2){
				$str=$str.'}';		//pair {} if unpair
			}
		}
	}	
	return $str;	//return json
}

//The jsonencode1() function is used to encode a array into JSON format.
function jsonencode($str,$theTrue='', $skip=0){
	
	if (is_array($str)){ 
		$str=json_encode($str, JSON_UNESCAPED_UNICODE);	//array to json
	}else{
		$str=str_replace(array('{,{'),'{{',$str);	//fixed json error
	}
	if($skip==0 || empty($skip))
	{
		$str=parseStringf($str);	//remove unpair brackes
		$str=stripslashes($str);
	}
	$str=ltrim($str,'"');	//remove double quote (") from start if available
	$str=rtrim($str,'"');	//remove double quote (") at end if available
	return $str;	//return json
}

// to decode or convert a JSON object to a PHP object or array.
function jsondecode($str,$theTrue='', $skip=1){

	if(is_array($str)){		//check string is already an array or not
		
	}else{
		$str=jsonreplace(@$str);		//remove html keywords from string
		if($skip==0 || empty($skip))
		{
			$str=str_replace(array('"{','}"','"[',']"'),array('{','}','[',']'),@$str);	//fixed json error
		}
		if(@$str) $str=json_decode(@$str,true);	//convert a JSON object to a PHP array.
	}
	return $str;	//return array
}

//to remove some unwanted words and unpair symbols from a JSON.
function jsonreplace($str)
{	
	if(is_string($str)){
	
		//returns a string or an array with all occurrences of search in subject (ignoring case) replaced with the given replace value.
		$str = str_ireplace(array('onmouseover','onclick','onmousedown','onmousemove','onmouseout','onmouseup','onmousewheel','onkeyup','onkeypress','onkeydown','oninvalid','oninput','onfocus','ondblclick','ondrag','ondragend','ondragenter','onchange','ondragleave','ondragover','ondragstart','ondrop','onscroll','onselect','onwheel','onblur',"'"), '', $str );
		$str=str_replace(array('[productName],'),'",',$str);
		$str=str_replace(array('[productName]},"'),'"},"',$str);
		$str=str_replace(array('],"data"'),']","data"',$str);
		$str=str_replace(array('”', '“'),'"',$str);
		$str=str_replace(array('":{","'),'":{"',$str);
		$str=str_replace(array('{order_token},'),array('{order_token}",'),$str);
		$str=str_replace(array('}rn"}'),array('}}'),$str);
		//$str = str_replace(array('[{','}]'), array('{','}'), $str );
	}
	return $str;
}

//The json_log() function is used to merge two JSON object.
function json_log($pLog='',$cLog='',$compare=0){
	$size=1;
	$mLog=[];
	$pLog=jsondecode($pLog);// convert a JSON object to a PHP array.

	if($pLog){
		$pLog_count=count($pLog);
		if($pLog_count){
			$size=($pLog_count+$size);
		}
	}
	//$mLog[$size]=jsondecode($cLog);
	//$cLog_en=jsonencode($cLog);
	
	$mLog[]=jsondecode($cLog);
	//$mLog[$size]=jsondecode($cLog_en);

	if(is_array($pLog)&&is_array($mLog)){ 
		$mLog=array_merge($pLog,$mLog);		//merge log array
	}
	//print_r($mLog);exit;
	$mLog=jsonencode($mLog);// convert a PHP array to a JSON object
	//$mLog=str_replace(array('"{','}"','"[',']"',"'"),array('{','}','[',']',"\'"),$mLog);	//fixed error
	$mLog=str_replace(array('"{','}"',"'"),array('{','}',"\'"),$mLog);	//fixed error
	return $mLog;	//return json
}

// The json log upd used to update logs in JSON format
function json_log_upd($tableId=0,$tableName='json_log',$action_name='Update',array $log=[],$clientid=null,$bearer='',$transID=null,$reference='',$bill_amt=null,$bill_email=''){
	
	global $data;$qp=0;
	
	if(isset($data['json_log_upd'])&&$data['json_log_upd']=='Y')
	{
	
		if(isset($_GET['qp'])){
			$qp=1;
		}
		if($action_name=='action'){
			if(isset($_GET['action'])&&$_GET['action']){
				$action_name=$_GET['action'];	//action name from url
			}
		}
		
		//fetch login detail from $_SESSION
		if(isset($_SESSION['sub_admin_id'])){
			$admin_id=$_SESSION['sub_admin_id'].":".$_SESSION['sub_admin_fullname']."-".$_SESSION['sub_admin_rolesname'];
		}elseif(isset($_SESSION['m_username'])&&(!isset($_SESSION['adm_login']))){
			$admin_id="Merchant:".$_SESSION['uid']."-".$_SESSION['m_username'];
		}elseif(isset($_SESSION['manual_log_creds'])&&(!isset($_SESSION['adm_login']))){
			$admin_id=$_SESSION['manual_log_creds'];
		}else{
			if(isset($_SESSION['admin_id'])&&isset($_SESSION['sub_username'])){
				$admin_id="Admin : ".$_SESSION['admin_id']." - ".$_SESSION['sub_username'];
			}else{
				$admin_id='Admin...';
			}
		}
		
		//echo $admin_id;exit;
		$pLog=[];
		$dat=[];
		
		$id_primary='`id`';
		if($tableName==$data['ASSIGN_MASTER_TRANS_ADDITIONAL']) $id_primary='`id_ad`';
		
		if($tableId>0){
			//fetch previous store json log history
			$log_slc=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}{$tableName}`".
				" WHERE {$id_primary}='{$tableId}' LIMIT 1",$qp
			);
			$pLog=(isset($log_slc[0]['json_log_history'])?$log_slc[0]['json_log_history']:'');
			if(isset($_REQUEST['viewaction'])){
				$dat['view_log_name']=$_REQUEST['viewaction'];	//log name
				
			}else{
				$dat=(isset($log_slc[0])?$log_slc[0]:''); // current log
			}
			
			//unset following keys value of $dat array
			if($tableName=='json_log'&&isset($dat['json_log_history'])&&is_array($dat['json_log_history'])) {
				if(isset($dat['tableName'])) unset($dat['tableName']);
				if(isset($dat['action_name '])) unset($dat['action_name ']);
				
				$dat=array_merge($dat,$dat['json_log_history']);
				
				
			}
			if(isset($dat['json_log_history'])) unset($dat['json_log_history']);
			if(isset($dat['templates_log'])) unset($dat['templates_log']);
			if(isset($dat['previous_passwords'])) unset($dat['previous_passwords']);
			if(isset($dat['manual_adjust_balance_json'])) unset($dat['manual_adjust_balance_json']); 
			if(isset($dat['more_details'])) unset($dat['more_details']);
			
			$dat1=[];
			$dat1['ip_address']=((isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);			//access IP
			$dat1['devinm']=encode_f(php_uname('n'),0);					//fetch Host name
			$dat1['miscellaneous']=encode_f(php_uname().' '.PHP_OS,0);	//fetch operating system PHP is running on
			if(isset($_SERVER['HTTP_REFERER'])&&$_SERVER['HTTP_REFERER']){
				$dat1['HTTP_REFERER']=$_SERVER['HTTP_REFERER'];			//referer url
			}
			if(isset($dat)&&is_array($dat))
			{
				foreach($dat as $ke=>$va){
					if((json_decode($va) == null)&&(preg_match('/^[\[\{]\"/', $va))){
						//echo "<br/>json missing: ".$ke."=>".$dat[$ke];
						unset($dat[$ke]);
						unset($dat1[$ke]);
					}else{
						$dat1[$ke]=isJsonEn($va);	//encode array to json
						//echo "<br/>".$ke."=>".$dat[$ke];
					}
				}
			}
			if(isset($dat1)&&is_array($dat1)&&isset($dat)&&is_array($dat))
			{
				$dat=array_merge($dat1,$dat);
			}
			//exit;
			
			if($tableName=='master_trans_table'||$tableName==$data['MASTER_TRANS_TABLE']){
				unset($dat['mer_setting_json']);	//unset acquirer json
				unset($dat['system_note']);		//unset system note
				unset($dat['support_note']);	//unset reply mer_note
				//unset($dat['acquirer_response']);
				
				if(isset($dat['json_value'])){
					//$dat['json_value']=jsondecode($dat['json_value']);
				}
				if(isset($dat['ccno'])){
					//$dat['ccno']=jsondecode($dat['ccno']);
				}
			}
			
			if(isset($dat['acquirer_processing_json'])){
				//$dat['acquirer_processing_json']=jsondecode($dat['acquirer_processing_json']);
				//$dat=array_merge($dat,$dat['acquirer_processing_json']);
			}
		}
		
		if(isset($dat)&&isset($log)&&is_array($dat)&&is_array($log))
		{
			$dat=array_merge($dat,$log);
		}
		
		//$diff_count="";
		$diff_count=0;
		
		if($pLog){
			//echo $pLog;
			$pLog_re=str_replace(array('<diff>','</diff>'),'',$pLog);
			//echo "<hr/>pLog_re=>".$pLog_re;
			
			$pLog_de=jsondecode($pLog_re,1,1);	//json decode - json to array
			//echo "<hr/>print_r pLog_de =>"; print_r($pLog_de);echo "<br/><hr/>";
			//$pLog_count=sizeof($pLog_de);

			if(isset($pLog_de)){
				error_reportingf(0);				// Turn off all error reporting

				$diff_ar=[];
				$datde_ar=$dat;
				$pLog_de_end1=end($pLog_de);
				$pLog_de_end_log_log=$pLog_de_end1['log_log'];
				
				if(isset($pLog_de_end_log_log)&&$pLog_de_end_log_log&&isset($datde_ar)&&$datde_ar) $diff_ar = array_diff($datde_ar,$pLog_de_end_log_log);
				//$diff_ar = array_diff($dat,$pLog_de[$pLog_count-1]['log_log']);
				//echo "<hr/>print_r datde_ar =><br/>";print_r($datde_ar['log_log']);
				//$diff_count=sizeof($diff_ar);
				//echo "diff_ar=>"; print_r($diff_ar);

				$dat_1=[];
				if($diff_ar){
					foreach($diff_ar as $key=>$value){
						$dat_1[$key]="<diff>".$value."</diff>";
						//echo "<hr/>diff=>".$dat[$key];
						$diff_count++;
					}
					$dat=array_merge($dat,$dat_1);
				}
			}
		}
		
		
		if(isset($dat)&&is_array($dat))
		{
			$dat['url_get']=((isset($data['urlpath'])&&is_string($data['urlpath']))?$data['urlpath']:'');
		}
		 
		
		
		$cLog['log_user']=$admin_id;
		$cLog['log_date']=date('Y-m-d H:i:s A');
		$cLog['log_action']=$action_name;
		$cLog['log_url']=$data['urlpath'];
		$cLog['log_count']=$diff_count;
		$cLog['log_log']=($dat);
		$t_log=json_log($pLog,$cLog);
		
		//echo "<hr/>t_log1=>".$t_log1=jsonencode($cLog);
		
		//exit;
		
		if($qp){
			echo $t_log; 
		}
		
		if(isset($data['JSON_INSERT'])&&$data['JSON_INSERT']){
			$tableId=0;	
		}
		
		if($tableId>0)
		{
			//update json log history in defined table
			db_query("UPDATE `{$data['DbPrefix']}{$tableName}`".
			" SET `json_log_history`='{$t_log}' WHERE {$id_primary}='{$tableId}'",@$qp);
			//exit;
		}else{
			if($clientid==""){
				if(isset($_SESSION['admin_id'])&&$_SESSION['admin_id']){$clientid=$_SESSION['admin_id'];}
				elseif(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']){$clientid=$_SESSION['sub_admin_id'];}
				else{$clientid="0001";} 
			}
			//$bearer
			if($bearer){
				$json_log_max_id=db_rows(
					"SELECT MAX(`id`) AS `max_id` FROM `{$data['DbPrefix']}json_log`".
					" LIMIT 1",$qp
				);
				$json_log_newid=$_SESSION['json_log_newid']=$json_log_max_id[0]['max_id']+1;
				$action_name=$data['bearer_token_id']=$bearer.$json_log_newid.date('s');
			}
			
			//insert data into json log if table not defined
			db_query(
				"INSERT INTO `{$data['DbPrefix']}json_log`(".
				"`action_name`,`json_log_history`,`clientid`,`tableName`,`transID`,`reference`,`bill_amt`,`bill_email`".
				")VALUES(".
				"'{$action_name}','{$t_log}',{$clientid},'{$tableName}',{$transID},'{$reference}',{$bill_amt},'{$bill_email}'".
				")",@$qp
			);
			
			$_SESSION['json_log_cr_newid']=newid();
		}
	}
}
//function for update json log in payout DB section
function json_log_upd_payout($tableId,$tableName,$uid=0,$action_name='Update',?array $log = null)
{
	
	global $data;$qp=0;
	
	if(isset($_GET['qp'])){
		$qp=1;
	}
	if($action_name=='action'){
		if(isset($_GET['action'])&&$_GET['action']){
			$action_name=$_GET['action'];		//fetch action name/type from URL
		}
	}
	
	//fetch login detail from $_SESSION
	if(isset($_SESSION['sub_admin_id'])){
		$admin_id=$_SESSION['sub_admin_id'].":".$_SESSION['sub_admin_fullname']."-".$_SESSION['sub_admin_rolesname'];
	}elseif(isset($_SESSION['m_username'])&&(!isset($_SESSION['adm_login']))){
		$admin_id="Merchant:".$_SESSION['uid']."-".$_SESSION['m_username'];
	}else{
		if(isset($_SESSION['admin_id'])&&isset($_SESSION['sub_username'])){
			$admin_id="Admin : ".$_SESSION['admin_id']." - ".$_SESSION['sub_username'];
		}
		elseif($uid)
		{
			$admin_id="Merchant:".$uid."-".get_clients_username($uid);
		}
		else{
			$admin_id='Admin...';
		}
	}

	$pLog=[];
	$dat=[];
	
	if($tableId>0){
		//fetch data from DB 2 (payout DB) 
		$log_slc=db_rows_2(
			"SELECT * FROM `{$data['DbPrefix']}{$tableName}`".
			" WHERE `id`='{$tableId}' LIMIT 1",$qp
		);
		$pLog=$log_slc[0]['json_log_history'];
		if(isset($_REQUEST['viewaction'])){
			$dat['view_log_name']=$_REQUEST['viewaction'];
			
		}else{
			$dat=$log_slc[0]; // current log
		}
		//unset previous log data
		if(isset($dat['json_log_history'])) unset($dat['json_log_history']);
		if(isset($dat['templates_log'])) unset($dat['templates_log']);
		if(isset($dat['previous_passwords'])) unset($dat['previous_passwords']);
		if(isset($dat['manual_adjust_balance_json'])) unset($dat['manual_adjust_balance_json']); 
		if(isset($dat['more_details'])) unset($dat['more_details']);
		
		$dat1=[];
		$dat1['ip_address']=((isset($_SERVER['HTTP_X_FORWARDED_FOR'])&&$_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
		$dat1['devinm']=encode_f(php_uname('n'),0);
		$dat1['miscellaneous']=encode_f(php_uname().' '.PHP_OS,0);
		if(isset($_SERVER['HTTP_REFERER'])&&$_SERVER['HTTP_REFERER']){
			$dat1['HTTP_REFERER']=$_SERVER['HTTP_REFERER'];
		}
		
		foreach($dat as $ke=>$va){
			if((json_decode($va) == null)&&(preg_match('/^[\[\{]\"/', $va))){
				unset($dat[$ke]);
				unset($dat1[$ke]);
			}else{
				$dat1[$ke]=isJsonEn($va);	//encode json to array
			}
		}
		$dat=$dat1;
	}else{
		$pLog=""; // string json
		$dat=$log; // array 
	}
	
	$diff_count=0;
	
	if($pLog){
		$pLog_re=str_replace(array('<diff>','</diff>'),'',$pLog);
		
		$pLog_de=jsondecode($pLog_re,1,1);

		if(isset($pLog_de)){
			error_reportingf(0);

			$diff_ar=[];
			$datde_ar=$dat;
			$pLog_de_end1=end($pLog_de);
			$pLog_de_end_log_log=$pLog_de_end1['log_log'];
			
			if(isset($pLog_de_end_log_log)&&$pLog_de_end_log_log&&isset($datde_ar)&&$datde_ar) $diff_ar = array_diff($datde_ar,$pLog_de_end_log_log);

			$dat_1=[];
			if($diff_ar){
				foreach($diff_ar as $key=>$value){
					$dat_1[$key]="<diff>".$value."</diff>";
					$diff_count++;
				}
				$dat=array_merge($dat,$dat_1);
			}
		}
	}
	
	
	
	$dat['url_get']=$data['urlpath'];
	
	//store data into an array
	$cLog['log_user']=$admin_id;				//login id
	$cLog['log_date']=date('Y-m-d H:i:s A');	//current time
	$cLog['log_action']=$action_name;			//action name

	$cLog['log_url']=$data['urlpath'];			//update file or path
	$cLog['log_count']=$diff_count;				//update field counter
	$cLog['log_log']=($dat);

	$t_log=json_log($pLog,$cLog);				//merge previous and update log

	
	if($qp){
		echo $t_log; 
	}
	
	//update json_log_history of defined table
	if($tableId>0){
		db_query_2("UPDATE `{$data['DbPrefix']}{$tableName}`".
			" SET `json_log_history`='{$t_log}' WHERE `id`='{$tableId}'",$qp);	
	}
}

//this function used to display complete json log
function json_log_popup($log='', $action_name='View Json Log', $tableId=0,$tableName='json_log',$clientid='')
{
	global $data;$qp=0;

	if(isset($data['JSON_LOG_VIEW_ENABLE'])&&$data['JSON_LOG_VIEW_ENABLE']=='Y')
	{
		//check login type
		if((isset($_SESSION['login_adm']))||(isset($_SESSION['json_log_view'])&&$_SESSION['json_log_view']==1)){
			if(isset($_GET['qp'])){
				$qp=1;
			}
			
			if($tableId>0){
				//fetch json log history from a table
				$log_slc=db_rows(
					"SELECT `json_log_history` FROM `{$data['DbPrefix']}{$tableName}`".
					" WHERE `id`='{$tableId}' LIMIT 1",$qp
				);
				if($log_slc[0]['json_log_history']){
					$log=$log_slc[0]['json_log_history'];
				}
			}
			
			if($log){	//if log exists then print log	
			?>
			<div class="row json_log_view1_row">
				<div class="col_2" style="padding:0;float:left;">
					<div class="hhh" style="width:0;overflow:hidden;"><? $all_log2=jsondecode($log); //decode json to php array object?></div>
					<? //Change width:95vw; to 100% 0n 201022 by vikash ?>
					<div class="tbl_exl tbl_exlHeightAuto" style="width:98%;overflow:auto">
						<table class="compare" style="margin-top: -2px;width:3000%;">
						<tbody>
						<? if(is_array($all_log2)){foreach($all_log2 as $key6=>$value6){ 
						?>
						<tr><td title="<?=$key6;?>" style="width: 200px;">
							<div><a><?=$value6['log_user'];?><?=($value6['log_count']>0)?'<span class="diff_log" data-no=0 onclick="diff_log(this,\''.$value6['log_count'].'\')">'.$value6['log_count'].'</span>':'';?></a></div>
							<div style="clear:both;"><?=prndatelog($value6['log_date']);?>&nbsp;<i class="fas fa-info text-danger" title="<?=$value6['log_action'];?>"></i></div></td>

							<td nowrap title="<?=$key6;?>" style="width: 100%;">
								<div style="width:100%;">
								<?
								if(is_array($value6)){
									$value6_0=jsondecode($value6['log_log']);

									if(isset($_SESSION['login_adm'])&&isset($_REQUEST['de'])){
										if(isset($value6_0['devinm'])&&$value6_0['devinm'])$value6_0['devinm']=decode_f($value6_0['devinm'],0);
										if(isset($value6_0['miscellaneous'])&&$value6_0['miscellaneous'])$value6_0['miscellaneous']=decode_f($value6_0['miscellaneous'],0);
									}else{
										if(isset($value6_0['devinm'])&&$value6_0['devinm']) unset($value6_0['devinm']);
										if(isset($value6_0['miscellaneous'])&&$value6_0['miscellaneous']) unset($value6_0['miscellaneous']);
									}
	
									foreach($value6_0 as $key6_1=>$value6_1){
									?>
										<div class="dtd" title="<?=jsonencode($key6_1)?>" >
											<?=jsonencode($key6_1)?> : <b><?=jsonencode($value6_1);?></b>
										</div>
									<? 
									} 
								} ?>
								</div>
								</td></tr>
							<? } } ?>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		<? } ?>
		<?
		}
	}
}
//The use of this function to view json log history.
function json_log_view1($log='',$action_name='View Json Log',$tableId=0,$tableName='json_log',$clientid='')
{
	
	global $data;$qp=0;

	if(isset($data['JSON_LOG_VIEW_ENABLE'])&&$data['JSON_LOG_VIEW_ENABLE']=='Y')
	{
		// for call dynamic fw icon
		if(empty($data['fwicon']['general-information'])){$data['fwicon']['general-information']="fas fa-info";}

		//check login type
		if((isset($_SESSION['login_adm']))||(isset($_SESSION['json_log_view'])&&$_SESSION['json_log_view']==1)){
			if(isset($_GET['qp'])){
				$qp=1;
			}
			
			if($tableId>0){
				//fetch json log from a table
				$log_slc=db_rows(
					"SELECT `json_log_history` FROM `{$data['DbPrefix']}{$tableName}`".
					" WHERE `id`='{$tableId}' LIMIT 1",$qp
				);
				if($log_slc[0]['json_log_history']){
					$log=$log_slc[0]['json_log_history'];
					//$log=array_merge($log,@$log_db);
				}
			}
			if(@$log)
			{	//if json log exists then display 

				//$log=str_replace(["<diff>","</diff>"],'',@$log);
				//$log=html_entity_decodef(@$log);
				
			?>
			<a class="btn btn-primary view_json json_log_view1" onClick="view_next3(this,'')" style="padding:1px 6px 1px 8px;"><?=$action_name;?></a>
			<div class="row hide json_log_view1_row">
				<div class="col_2" style="width:76vw;padding:0;float:left;">
					<div class="hhh" style="width:0;display:none;overflow:hidden;"> <? $all_log2=jsondecode($log);	//decode json to php array object?></div>
						<div class="tbl_exl tbl_exlHeightAuto" style="width:98vw;overflow:auto">
						<table class="compare" style="margin-top: -2px;width:3000%;">
						<tbody>
							<? if(is_array($all_log2)){foreach($all_log2 as $key6=>$value6){ 
							
							?>
							<tr><td title="<?=$key6;?>" style="width: 200px;">
								<div><a><?=$value6['log_user'];?><?=($value6['log_count']>0)?'<span class="diff_log" data-no=0 onclick="diff_log(this,\''.$value6['log_count'].'\')">'.$value6['log_count'].'</span>':'';?></a></div>
								<div style="clear:both;"><?=prndatelog($value6['log_date']);?>&nbsp;<i class="<?=$data['fwicon']['general-information'];?> text-danger" title="<?=$value6['log_action'];?>"></i></div>
							</td>
							<!--<td title="<?=$key6;?>">
								<div title="<?=$value6['log_action'];?>"><i class="fas fa-info text-danger"></i></div>
							</td>-->
							<td nowrap title="<?=$key6;?>" style="width: 100%;" >
								<div style="width:100%;">
								<?
								if(is_array($value6)){
									$value6_0=jsondecode($value6['log_log']);
									
									if(isset($_SESSION['login_adm'])&&isset($_REQUEST['de'])){
										if(isset($value6_0['devinm'])&&$value6_0['devinm'])$value6_0['devinm']=decode_f($value6_0['devinm'],0);
										if(isset($value6_0['miscellaneous'])&&$value6_0['miscellaneous'])$value6_0['miscellaneous']=decode_f($value6_0['miscellaneous'],0);
									}else{
										if(isset($value6_0['devinm'])&&$value6_0['devinm']) unset($value6_0['devinm']);
										if(isset($value6_0['miscellaneous'])&&$value6_0['miscellaneous']) unset($value6_0['miscellaneous']);
									}
								
									foreach($value6_0 as $key6_1=>$value6_1){
									?>
										<div class="dtd" title="<?=jsonencode($key6_1)?>" >
											<?=jsonencode($key6_1)?> : <b><?=jsonencode($value6_1);?></b>
										</div>
									<?}}?>
								</div>
							</td></tr>
						<?}}?>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<? }?>
		<?
		}
	}
}
function json_log_view($log='', $action_name='View Json Log', $tableId=0,$tableName='json_log',$clientid='',$width='90vw')
{

	global $data;$qp=0;

	if(@$qp)
	{
		echo "<br/><hr/>DEV LOG=><br/>";
		echo "$log='', $action_name='View Json Log', $tableId=0,$tableName='json_log',$clientid='',$width='90vw' ";
	}

	if(isset($data['JSON_LOG_VIEW_ENABLE'])&&$data['JSON_LOG_VIEW_ENABLE']=='Y')
	{
		if(isset($data['logWidth'])&&$data['logWidth']){
			$width=$data['logWidth'];
		}
		
		if((isset($_SESSION['login_adm']))||(isset($_SESSION['json_log_view'])&&$_SESSION['json_log_view']==1))
		{
			if(isset($_GET['qp'])){
				$qp=1;
			}
			
			if($tableId>0){
				//fetch json log from a table id or id_ad
				$log_slc=db_rows(
					"SELECT `json_log_history` FROM `{$data['DbPrefix']}{$tableName}`".
					" WHERE `id`={$tableId} LIMIT 1",@$qp
				);
				if($log_slc[0]['json_log_history']){
					$log=$log_slc[0]['json_log_history'];
				}
			}
			if(@$log)
			{	//if json log exists then display 

				if(is_string($log))
				{
					//$log=str_replace(['<diff>{"','"}<\/diff>'],['<diff>','</diff>'],@$log);
					

					$log=str_replace(["<diff>","</diff>"],'',@$log);
					//$log=html_entity_decodef(@$log);
				}

				//echo "<br/><hr/>LOG_1=><br/>".$log;
			?>
			<a class="log_top1 btn btn-primary btn-sm view_json float-start json_log_view" onClick="view_next3(this,'')"><i class="far fa-eye"></i> <?=$action_name;?></a>
			<div class="row hide json_log_view_row">
				<div class="col_2" style="padding:0;float:left; width:<?=$width;?>;"><!--width:90vw;-->
					<div class="hhh" style="width:0;display:none;overflow:hidden;"> <? $all_log2=jsondecode($log,'','0');	//decode json to php array object?></div>
					<div class="tbl_exl tbl_exlHeightAuto" style="overflow:auto;width:<?=$width;?>;"><!--width:90vw;-->
						<table class="compare" style="margin-top: -2px;width:100%;">
							<tbody>
							<? if(is_array($all_log2))
							{
								foreach(@$all_log2 as $key6=>$value6){?>
							<tr><td title="<?=$key6;?>" style="width: 110px;">
								<div class="dotdot" title="<?=@$value6['log_user'];?>"><?=@$value6['log_user'];?><?=(isset($value6['log_count'])&&$value6['log_count']>0)?'<span class="diff_log" data-no=0 onclick="diff_log(this,\''.$value6['log_count'].'\')">'.$value6['log_count'].'</span>':'';?></div>
								<div class="dotdot clearfix" title="<?=prndatelog(@$value6['log_date']);?>"><?=@$value6['log_date'];?></div>
								</td><td title="<?=@$key6;?>" style="width:2px;">
									<div title="<?=@$value6['log_action'];?>"><i class="fas fa-info text-danger"></i></div></td>
							<td nowrap title="<?=@$key6;?>" style="width: 100%;" >
								<div style="width:100%;">
								<?
								if(is_array(@$value6)){
									$value6_0=jsondecode(@$value6['log_log']);

									if(isset($_SESSION['login_adm'])&&isset($_REQUEST['de'])){
										if(isset($value6_0['devinm'])&&$value6_0['devinm'])$value6_0['devinm']=decode_f($value6_0['devinm'],0);
										if(isset($value6_0['miscellaneous'])&&$value6_0['miscellaneous'])$value6_0['miscellaneous']=decode_f($value6_0['miscellaneous'],0);
									}else{
										if(isset($value6_0['devinm'])&&$value6_0['devinm'])unset($value6_0['devinm']);
										if(isset($value6_0['miscellaneous'])&&$value6_0['miscellaneous'])unset($value6_0['miscellaneous']);
									}

									if(isset($value6_0)&&is_array($value6_0)){ foreach($value6_0 as $key6_1=>$value6_1){?>
										<div class="dtd" title="<?=jsonencode($key6_1)?>" >
											<?=jsonencode($key6_1)?> : <b><?=jsonencode($value6_1);?></b>
										</div>
									<? }}} ?>
								</div>
							</td></tr>
							<? }
							} 
							elseif(is_string($log)){

							?>
								<tr>
									<td>
										<div style="word-wrap:break-word;background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px 0;width:100%;display:block;max-width:94%;text-align:left;"><?=(@$log);?></div>
									</td>
								</tr>
							<? } ?>
						</tbody>
					</table>
				</div>
			</div>	
		</div>
		<? }
		}
	}
}
//$data['store_status'][1]['title'];

//Define data array for store status - icon, title and color
$data['store_status']=array(
	0=>array(
		'icon'=>'vector_path_square fa-solid fa-vector-square',
		'title'=>'Blank ',
		'color'=>'red text-danger',
	),
	1=>array(
		'icon'=>'ok_2 fa-regular fa-circle-check',
		'title'=>'Approved ',
		'color'=>'green text-success',
	),
	2=>array(
		'icon'=>'remove_2 fa-regular fa-circle-xmark',
		'title'=>'Business id does not exist',
		'color'=>'red text-danger',
	),
	3=>array(
		'icon'=>'remove_2 fa-regular fa-circle-xmark',
		'title'=>'Rejected ',
		'color'=>'red text-danger',
	),
	4=>array(
		'icon'=>'clock fa-solid fa-eye',
		'title'=>'Under review ',
		'color'=>'text-warning',
	),
	5=>array(
		'icon'=>'clock fa-solid fa-eye',
		'title'=>'Awaiting Terminal ',
		'color'=>'green text-success',
	),
	6=>array(
		'icon'=>'ban fa-regular fa-circle-xmark',
		'title'=>'Terminated ',
		'color'=>'red text-danger',
	),
);

###############################################################################
$data['key_no']=1;
$data['sec_key']=array(1=>'u2R5KQzHGAgbTHgOljT5oiC0kIxkrE62',2=>'18hlapax9alku0p4Yl92QXbNUDnWieHb');
$data['pub_key']=array(1=>'ogHVlE6Go1VEl4RWH3dkEEwC1xse8Lam',2=>'xzicriZsWREIDoPTg2WfnzTsNOKicWkq');
###############################################################################

//To check and replace space via + in curl url 

function curl_url_replace_f($url)
{
	$url=str_replace(" ","+",$url);
	return $url;
}


//To send request and access any page/url via curl.
function use_curl($url, $post=null){
	$protocol= isset($_SERVER["HTTPS"])?'https://':'http://'; //Server and execution environment info
	$referer = $protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];	//The URI which was given in order to 
	
	//$url=str_replace(" ","+",$url);
	$url=curl_url_replace_f($url);

	if(isset($_GET['qp']))
	{
		echo '<br/><br/><=use_curl=><br/><br/>url=>'.$url;
		echo '<br/><br/><=use_curl post=><br/><br/>post=>';print_r($post);
	}
	
	$handle=curl_init();	//Initializes a new session and return a cURL handle.
	
	curl_setopt($handle, CURLOPT_URL, $url);	//The string pointed to in the CURLOPT_URL argument is expected to be a sequence of characters using an ASCII compatible encoding.
	
	if(isset($post['json_encode'])&&$post['json_encode']){
		unset($post['json_encode']);	//unset json encode from $post array
		
		$post=json_encode($post);	//array to json
		curl_setopt($handle, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));	//Pass a pointer to a linked list of HTTP headers to pass to the server and/or proxy in your HTTP request. 
		
	}
	
	if(@$post){
		curl_setopt($handle, CURLOPT_POST, 1);	//true to do a regular HTTP POST. CURLOPT_POST to 0, libcurl resets the request type to the default to disable the POST
		curl_setopt($handle, CURLOPT_POSTFIELDS, $post);	// Set the full data to post in a HTTP "POST" operation.
	}
	curl_setopt($handle, CURLOPT_REFERER, $referer);	// The contents of the "Referer: " header to be used in a HTTP request. 
	if(isset($post['CURLOPT_HEADER'])&&$post['CURLOPT_HEADER']==1) $curlopt_header=1;
	else $curlopt_header=0;
	curl_setopt($handle, CURLOPT_HEADER, $curlopt_header);			// true to include the header in the output. 
	curl_setopt($handle, CURLOPT_SSL_VERIFYPEER, 0);	//Curl verifies whether the certificate is authentic. false to stop cURL from verifying the peer's certificate. 
	curl_setopt($handle, CURLOPT_SSL_VERIFYHOST, 0);	// Subject Alternate Name field in the SSL peer certificate matches the provided hostname. 0 to not check the fullname

	//curl_setopt($handle, CURLOPT_COOKIESESSION, 1);
	
	curl_setopt($handle, CURLOPT_RETURNTRANSFER, 1);	// true to return the transfer as a string of the return value of curl_exec() instead of outputting it directly. 

	curl_setopt($handle, CURLOPT_TIMEOUT, 10);	// The maximum number of seconds to allow cURL functions to execute. 
		
	$result=curl_exec($handle);	//Execute the curl request. 

	$http_status	= curl_getinfo($handle, CURLINFO_HTTP_CODE);	//received curl response in code
	$curl_errno		= curl_errno($handle);	//received curl error in code
	curl_close($handle);	//close curl execution

	//check status with code
	if(isset($post)&&is_array($post)&&(@$post['action']=='admin_direct'||@$post['actionurl']=='admin_direct'||@$post['cron_tab']=='cron_tab'||@$post['error_skip']=='error_skip'||(isset($_REQUEST['cron_tab'])&&@$_REQUEST['cron_tab']=='cron_tab'))){

		//echo '<br/><br/><=cron_tab=>'.@$_REQUEST['cron_tab'];
		//echo '<br/><br/><=result=>'.@$result;
		
	}elseif ( ( $http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404 ) && (!isset($data_send['cron_tab']) ) ) {
		$err_5001=[];
		$err_5001['Error']="5001";
		$err_5001['Message']="HTTP Status is {$http_status} and returned ".$curl_errno;
		json_print($err_5001);
	}
	elseif($curl_errno){	//check and print error with code
		$err_5002=[];
		$err_5002['Error']="5002";
		$err_5002['Message']="HTTP Status is {$http_status} and Request Error ".curl_error($handle);
		json_print($err_5002);
	}
	
	return $result;
}


//The post_redirect() used to send request direct via form submission.
function post_redirect($url, array $data)
{
	?>
	<!DOCTYPE html>
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
		<?php
		if(isset($data['target_'])) { 
			$target=' target="'.$data['target_'].'" ';
			unset($data['target_']);
		}
		else $target='';

		if(isset($data['method_'])) { 
			$method=' method="'.$data['method_'].'" ';
			unset($data['method_']);
		}
		else $method=' method="post" ';

		//echo "<hr/>target=>".$target;

		if(isset($data['b_submit'])){?>
			<script type="text/javascript">
				function closethisasap() {
					
				}
			</script>
		<?php } else {?>
			<script type="text/javascript">
				function closethisasap() {
					document.forms["redirectpost"].submit();
				}
			</script>
		<?php } ?>
	</head>
	<body onLoad="closethisasap();">
	<form name="redirectpost"  <?php echo $method; ?>  <?php echo $target; ?> action="<?php echo $url; ?>">
	<?php
	if ( !is_null($data) ) {
		foreach ($data as $k => $v) {
			if(isset($data['b_submit'])){
				echo $k.' : <input type="text" name="'.$k.'" value="'.$v.'" style="display:none1;width:90%;"><br/> ';
			}else{
				echo '<input type="hidden" name="'.$k.'" value="'.$v.'" style="display:none;">';
			}
		}
	}
	?>
	<?php if(isset($data['b_submit'])){?>
		<input type="submit" name="sendfrm" id="sendfrm" value="SUBMIT" class='btn' />
	<?php }?>
	</form>
	</body>
	</html>
	<?php
	exit;
}

//The post_redirectf() used to send request via form submission. Submit information through popup.
function post_redirectf($url, array $data)
{
	?>
	<form name="redirectpost" method="post" action="<?php echo $url; ?>" <?=(isset($data['btn_value'])?"target='hform'":"");?>>
		<?php
		if ( !is_null($data) ) {
			foreach ($data as $k => $v) {
				if(isset($data['b_submit'])){
					echo $k.' : <input type="text" name="'.$k.'" value="'.$v.'" style="display:none1;width:90%;"><br/> ';
				}else{
					echo '<input type="hidden" name="'.$k.'" value="'.$v.'" style="display:none;">';
				}
			}
		}
		?>
		<?php if(isset($data['b_submit'])||isset($data['btn_submit'])){?>
			<input type="submit" name="sendfrm" id="sendfrm" value="<?=(isset($data['btn_value'])?$data['btn_value']:"SUBMIT");?>" class='btn btn-icon btn-primary <?=(isset($data['btn_submit'])?$data['btn_submit']:$data['b_submit']);?>' <?=(isset($_SESSION['adm_login'])?" onclick='javascript:top.popuploadig();popupclose2();' ":"");?>/>
		<?php }?>
	</form>
	<?php
}

//This function currently not using
function post_iframe_script($url)
{	
	?>
	<script>
		function crossDomainPost(url){
			var iframe = document.createElement('iframe');
			iframe.setAttribute('src', url);
			iframe.setAttribute('sandbox', "allow-top-navigation allow-scripts allow-forms");
			iframe.setAttribute('width', 0);
			iframe.setAttribute('height', 0);
			iframe.setAttribute('style', 'border: none;display:none !important;overflow:hidden !important;');
			//document.write(iframe);
			var p = document.getElementsByTagName('html'); p[0].appendChild(iframe);
			//alert(url);
		}
		crossDomainPost("<?php echo $url;?>");
		//window.open("<?php echo $url;?>", '_blank');
	</script>
	<?php
	//sleep(10);
}
//The encryptres() used to encode the string with KEY via encode_base64. Default key is ztcBase64Encode.
function encryptres($sData, $sKey='ztcBase64Encode'){ 
	$sResult = ''; 
	for($i=0;$i<32;$i++){ 
		$sChar		= substr($sData, $i, 1); 
		$sKeyChar	= substr($sKey, ($i % strlen($sKey)) - 1, 1); 
		$sChar		= chr(ord($sChar) + ord($sKeyChar)); 
		$sResult .= $sChar; 
	} 
	return encode_base64($sData);	//encode string/data
}

//The decryptres() used to decode the string with KEY via encode_base64. Default key is ztcBase64Encode.
function decryptres($sData, $sKey='ztcBase64Encode'){ 
	$sResult= ''; 
	$sData	= decode_base64($sData);	//decode encoded string
	for($i=0;$i<32;$i++){ 
		$sChar		= substr($sData, $i, 1); 
		$sKeyChar	= substr($sKey, ($i % strlen($sKey)) - 1, 1); 
		$sChar		= chr(ord($sChar) - ord($sKeyChar)); 
		$sResult .= $sChar; 
	} 
	return $sData; 
}
//The encrypt_res() used to encode the string with KEY via encode_base64. Default key is pctAsia.
//This function is currently not using
function encrypt_res($sData, $sKey='pctAsia'){ 
	$sResult = ''; 
	for($i=0;$i<32;$i++){ 
		$sChar		= substr($sData, $i, 1); 
		$sKeyChar	= substr($sKey, ($i % strlen($sKey)) - 1, 1); 
		$sChar		= chr(ord($sChar) + ord($sKeyChar)); 
		$sResult .= $sChar; 
	} 
	return encode_base64($sResult); 
}
//The decrypt_res() used to decode the string with KEY via encode_base64. Default key is pctAsia.
function decrypt_res($sData, $sKey='pctAsia'){ 
	$sResult= ''; 
	$sData	= decode_base64($sData); 
	for($i=0;$i<32;$i++){ 
		$sChar		= substr($sData, $i, 1); 
		$sKeyChar	= substr($sKey, ($i % strlen($sKey)) - 1, 1); 
		$sChar		= chr(ord($sChar) - ord($sKeyChar)); 
		$sResult .= $sChar; 
	}
	return $sResult; 
} 
//The base64-decoding function is a homomorphism between modulo 4 and modulo 3-length segmented strings
function decode_base64($sData){ 
	$sBase64 = strtr($sData, '-_', '+/'); 
	return base64_decode($sBase64); 
}

//Encode data by calling the encode_base64() function.
function encode_base64($sData){ 
	return rtrim( strtr( base64_encode( $sData ), '+/', '-_'), '=');
}

//Encode data by calling the encode_base64() function. 
function encode64f($sData,$sKey='MY_SECRET_ANQtkR7ak8RZ'){ 
	return rtrim( strtr( base64_encode( $sData . $sKey ), '+/', '-_'), '=');
}

//The base64-decoding function is a homomorphism between modulo 4 and modulo 3-length segmented strings
function decode64f($sData,$sKey='MY_SECRET_ANQtkR7ak8RZ'){ 
	$sData = strtr($sData, '-_', '+/'); 
	return preg_replace(sprintf('/%s/', $sKey), '', base64_decode($sData));
}

//The encode_f() used to encode the string / email with KEY via using "AES-256-CBC" has sha256 method base on openssl_decrypt and base64_decode.
function encode_f($string,$json=1) {
	global $data;	//call globally

	$key=$data['key_no'];	//key number
	$secret_key=$data['sec_key'][$key];	//secret key
	$public_key=$data['pub_key'][$key];	//public key
	$output = false;
	$encrypt_method = "AES-256-CBC";		//encryption method
	$iv = substr( hash( 'sha256', $public_key ), 0, 16 );
	$output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $secret_key, 0, $iv ) ), '+/', '-_'), '=');
	if($json==1){
		$output='{"decrypt":"'.($output).'","key":"'.$key.'"}';
	}elseif($json==2){
		$output='{"decrypt":"'.($output).'","key":"'.$key.'","gt":"'.time().'"}';	//add key generate time -  - 26-09-2022
	}
	return $output;	//return encrypt string
}

//The decode_f() used to decode the string / email with KEY via using "AES-256-CBC" has sha256 method base on openssl_decrypt and base64_decode.
function decode_f($string,$json=1) {
	global $data;			//call globally
	$key=$data['key_no'];	//key number
	$output = false;

	if($json&&(strpos($string,'decrypt')!==false)){
		$string_json=json_decode($string,1);	//json to array
		$string=@$string_json['decrypt'];		//decrypted value
		$key=(int)@$string_json['key'];
	}

	$secret_key		= @$data['sec_key'][$key];	//secret key
	$public_key		= @$data['pub_key'][$key];	//public key
	$encrypt_method = "AES-256-CBC";			//encryption method type
	$iv = substr( hash( 'sha256', $public_key ), 0, 16 );
	$output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $secret_key, 0, $iv );

	return $output;	//return decrypt string
}


//The encrypts_string() used to decode the string via using "AES-256-CBC" has sha256 method base on openssl_decrypt and base64_decode.
function encrypts_string($string)
{
	if(strpos($string,'decrypt')!==false){	//check is already encrypted 

	}else{
		$string = encode_f($string);	//encrypt string
	}
	return $string;	//return encrypted string
}

// The decrypts_string() used to decode the string via using "AES-256-CBC" has sha256 method base on openssl_decrypt and base64_decode and returned in mask format.
function decrypts_string($string, $mask=true,$first=4,$end=4)
{
	if(strpos($string,'decrypt')!==false){	//check is encrypted then decrypt
		$string = decode_f($string);
	}
	if($mask) $string = mask($string, $first, $end);	///mask the string before return
	return $string;	//return decrypted string
}


//The reuse_param_set() used to merge $_SESSION and $post array into a new array which used to cross domain.
function reuse_param_set($post,$type=0,$cross_domain=''){
	global $data;
	
	//from _SESSION
	$reuse_param['tr_newid']	= $_SESSION['tr_newid'];		//new transaction inserted id
	$reuse_param['client_ip']	= $_SESSION['client_ip'];		//client IP
	$reuse_param['transID']	= $_SESSION['transID'];		//transID
	$reuse_param['tr_transID']	= $_SESSION['tr_transID'];		//transID
	$reuse_param['mop']	= $_SESSION['info_data']['mop'];	//card type - vc, mc, jcb etc
	$reuse_param['product']		= $_SESSION['product'];			//product name
	
	//from post array
	$reuse_param['curr']		= $post['curr'];				//currency
	if(isset($post['total_payment'])&&$post['total_payment']){
		$reuse_param['total_payment']=trim($post['total_payment']);	//total amount
	}else{
		$reuse_param['total_payment']=trim($_SESSION['price']);		//total amount
	}
	$reuse_param['ccholder']		=$post['ccholder'];				//card holder name
	$reuse_param['ccholder_lname']	=$post['ccholder_lname'];		//card holder last name
	$reuse_param['ccno']			=$post['ccno'];					//card number
	$reuse_param['month']			=$post['month'];				//card expiry month
	$reuse_param['year']			=$post['year'];					//card expiry year in two digit
	$reuse_param['ccvv']			=$post['ccvv'];					//card cvc number
	$reuse_param['email']			=trim($post['email']);			//cust emailid
	$reuse_param['bill_phone']		=trim($post['bill_phone']);		//cust phone/mobile
	$reuse_param['bill_address']	=trim($post['bill_address']);	//cust address
	$reuse_param['bill_city']		=trim($post['bill_city']);		//cust city
	$reuse_param['bill_state']		=trim($post['bill_state']);		//cust state
	$reuse_param['bill_zip']		=trim($post['bill_zip']);		//cust zip/pin code
	$reuse_param['bill_country']	=trim($post['bill_country']);	//cust billing country
	
	if($post['country_iso3']){
		$reuse_param['country_iso3']=trim($post['country_iso3']);	//country code in 3 chars
	}
	if($post['country_two']){
		$reuse_param['country_two']	=trim($post['country_two']);	//country code in 2 chars
	}
	
	$reuse_param = json_encode($reuse_param);	//array to json
	$reuse_param = encryptres($reuse_param);	//encrypt json
	
	if($cross_domain){	//check $cross_domain is true then execute following section
		
		// use on payin/reuse_param
		$host_url=$data["Host"]."/payin/reuse_param{$data['ex']}?type=".$type;
		$_SESSION['reuse_param']=($reuse_param);
		$_SESSION['reuse_param_'.$type]=($reuse_param);
		$_SESSION['reuse_param_array']['type']=$type;
		$_SESSION['reuse_param_array']['cross_host'.$type]=$cross_domain;
	
		// use on secure/process
		$_SESSION['reuse_param_host']=$host_url;
		$_SESSION['cross_domain']=$host_url."&curl=".urlencode($cross_domain);
		//$_SESSION['cross_domain2']=$host_url."&curl=".urlencode('https://my.e1pay.com');

		$curl_post['reuse_param']=($reuse_param);
		$curl_post['type']=$type;
		
		//post_iframe_script($host_url.urlencode($cross_domain)); post_iframe_script($host_url.urlencode('https://my.e1pay.com'));
		
		//use_curl($host_url.urlencode($cross_domain),$curl_post); use_curl($host_url.urlencode('https://my.e1pay.com'),$curl_post);
		
		//post_redirect($cross_domain, $curl_post);
		
		
		if(isset($_GET['qp'])){
			echo "<br/>reuse_param_=>".$_SESSION['reuse_param_'.$type]."<br/>";
			
			echo "<br/>cross_domain=>".$cross_domain."<br/>";
			print_r($curl_post);
		}
	}
	
	return $reuse_param;	//return encrypted format
}

//reuse_param_get2() used to decrypt and decode the values from json and set into _SESSION and $post array
function reuse_param_get2($value,$type=0,$id=0){
	//global $data;
	//call global variables
	global $transID,$total_payment,$mop,$orderCurrency,$country_two,$country_three;

	$decr = decryptres($value);		//decrypt the values
	$decr = str_replace(array('"{"','"}"'),array('{"','"}'),$decr);	//fixed json error, if any
	$decr = json_decode($decr,true);	//array to json object
	
	//_SES
	$_SESSION['tr_newid']	=$decr['tr_newid'];		//new inserted transaction id
	$_SESSION['client_ip']	=$decr['client_ip'];	//client IP
	if($decr['transID']){
		$transID=$decr['transID'];				//transID
		$_SESSION['transID']=$transID;
	}
	$_SESSION['tr_transID']=$decr['tr_transID'];	//order set
	
	if($decr['curr']){			//order currency
		$orderCurrency=trim($decr['curr']);
		$_SESSION['curr']=$orderCurrency;
		$_SESSION["currency".$type]=$orderCurrency;
	}
	if($decr['total_payment']){	//order amount
		$total_payment=trim($decr['total_payment']);
		$_SESSION['total_payment']=$total_payment;
	}elseif(isset($_SESSION['price'])){
		//$total_payment=$_SESSION['price']; $_SESSION['total_payment']=$total_payment;
	}
	
	if($decr['mop']){	//card type
		$mop=trim($decr['mop']);
		$_SESSION['info_data']['mop']=$mop;
	}
	if($decr['product']){	//product name
		$_SESSION['product']=trim($decr['product']);
	}
	
	
	//post
	$post['ccholder']=$decr['ccholder'];			//card holder name
	$post['ccholder_lname']=$decr['ccholder_lname'];//card holder last name
	$post['ccno']=$decr['ccno'];					//credit card number
	$post['month']=$decr['month'];					//card expiry month
	$post['year']=$decr['year'];					//card expiry year in two digit
	$post['ccvv']=$decr['ccvv'];					//card cvv number
	$post['bill_email']=trim($decr['email']);			//cust email
	$post['bill_phone']=trim($decr['bill_phone']);	//cust phone
	$post['bill_address']=$decr['bill_address'];	//cust address
	$post['bill_city']=$decr['bill_city'];			//cust city
	$post['bill_state']=$decr['bill_state'];		//cust state
	$post['bill_zip']=$decr['bill_zip'];			//cust zip/pin code
	$post['bill_country']=$decr['bill_country'];	//cust country
	
	if($decr['country_iso3']){
		$country_three=trim($decr['country_iso3']);
		$post['country_iso3']=trim($decr['country_iso3']);		//cust country code in 3 chars
	}
	if($decr['country_two']){
		$country_two=trim($decr['country_two']);		//cust country code in 2 chars
		$post['country_two']=$country_two;
	}
	
	return $post;	//return complete array
}

//this function same as reuse_param_get2(), but currently not using
function reuse_param_get($trans,$type,$id=0){
	//global $data;
	
	$_SESSION['tr_newid']=$trans['id'];
	
	$post['bill_address']=$trans['address'];
	$post['bill_city']=$trans['city'];
	$post['bill_state']=$trans['state'];
	$post['bill_zip']=$trans['zip'];
	$post['bill_country']=$trans['country'];

	$jsn=$trans['json_value'];
	$jsn=str_replace(array('"{"','"}"'),array('{"','"}'),$jsn);
	$json_value=json_decode($jsn,true);

	$decr = decryptres($json_value['reuse_param_'.$type]);
	$decr=str_replace(array('"{"','"}"'),array('{"','"}'),$decr);
	$decr=json_decode($decr,true);
	
	//_SES
	$_SESSION['client_ip']=$decr['client_ip'];
	$_SESSION['tr_transID']=$decr['tr_transID']; 
	$_SESSION['curr']=$decr['curr']; 
	$_SESSION['total_payment']=trim($decr['total_payment']);

	//post
	$post['ccholder']=$decr['ccholder'];
	$post['ccholder_lname']=$decr['ccholder_lname'];
	$post['ccno']=$decr['ccno'];
	$post['month']=$decr['month'];
	$post['year']=$decr['year'];
	$post['ccvv']=$decr['ccvv'];
	$post['email']=trim($decr['email']);
	$post['bill_phone']=trim($decr['bill_phone']);
	if($decr['country_iso3']){
		$post['country_iso3']=trim($decr['country_iso3']);
	}
	
	return $post;
}

//The approved_url() used to check URL is approved or not
function approved_url($http_referer='', $approved_url=''){
	global $data; $all_host=[];
	
	if(isset($data['all_host'])&&$data['all_host']){
		$all_host=$data['all_host'];
	}

	if(empty($http_referer)){
		if(!empty($_SESSION['http_referer'])){
			$http_referer=$_SESSION['http_referer'];	//referer from _SESSION
		}else{
			$http_referer=$_SERVER['HTTP_REFERER'];		//referer from _SERVER
		}
	}
	
	if(empty($approved_url)){
		foreach($all_host as $key=>$value){
			if(strpos($http_referer,$value)!==false){
				$approved_url=$data['HostG'];
			}
		}
		if(isset($_GET['qp'])){
			echo "<hr/>empty approved_url =>".$data['HostG'];
		}
	}
	
	$approved_url=str_replace(array('http://','https://','www.'),'',$approved_url);	//remove http, https and www from url
	
	if(isset($_GET['qp'])){
		echo "<hr/>http_referer=>".$http_referer;
		echo "<hr/>approved_url=>".$approved_url;
		echo "<hr/>all_host=>";
		print_r($data['all_host']);
	}
	if($approved_url){
		foreach($all_host as $key=>$value){
			if(strpos($http_referer,$value)!==false){
				$http_referer=str_replace($value,$approved_url,$http_referer);
			}else{
				$http_referer=approved_referer($http_referer,$approved_url);
			}
		}
	}
	if(isset($_GET['qp'])){
		echo "<hr/>http_referer final=>".$http_referer;
	}
	return $http_referer;	//return referer url
}

//The squrlf() used to convert $post array into a subquery string and concate with url.
function squrlf($url,array $post){ // sub query url 
	if(($url)&&((strpos($url,"http:")!==false) || (strpos($url,"https:")!==false))){
		$get=http_build_query($post);
		if(strpos($url,'?')!==false){
			$url=$url."&".$get;
		}else{
			$url=$url."?".$get;
		}
		return $url;
	}else{
		return "";
	}
}

//The approved_referer() used to check referer URL is valid and approved or not.
function approved_referer($http_referer='',$approved_url=''){
	
	$approved_url	= str_replace(array('http://','https://','www.'),'',$approved_url);
	$referer_host	= str_replace(array('http://','https://','www.'),'',$http_referer);
	$referer_host	= str_replace(array('?'),'/',$referer_host);

	$referer_host_ex= explode("/",$referer_host);

	if($referer_host_ex[0]){
		$referer_host=$referer_host_ex[0];
	}else{
		$referer_host=$referer_host;
	}
	
	if(isset($_GET['qp'])){
		echo "<hr/>http_referer=>".$http_referer;
		echo "<hr/>referer_host=>".$referer_host;
		echo "<hr/>approved_url=>".$approved_url;
	}
	
	if(strpos($http_referer,$approved_url)===false){
		$http_referer=str_replace($referer_host,$approved_url,$http_referer);
	}
	
	if(isset($_GET['qp'])){
		echo "<hr/>http_referer final=>".$http_referer;
	}
	return $http_referer;
}
/**
 * Increases or decreases the brightness of a color by a percentage of the current brightness.
 *
 * @param	string	$hexCode		Supported formats: `#FFF`, `#FFFFFF`, `FFF`, `FFFFFF`
 * @param	float	$adjustPercent	A number between -1 and 1. E.g. 0.3 = 30% lighter; -0.4 = 40% darker.
 *
 * @return	string
 */
function adc($hexCode, $adjustPercent) {
	$hexCode = ltrim($hexCode, '#');
	
	if (strlen($hexCode) == 3) {
		$hexCode = $hexCode[0] . $hexCode[0] . $hexCode[1] . $hexCode[1] . $hexCode[2] . $hexCode[2];
	}
	
	$hexCode = array_map('hexdec', str_split($hexCode, 2));
	
	foreach ($hexCode as & $color) {
		$adjustableLimit = $adjustPercent < 0 ? $color : 255 - $color;
		$adjustAmount = ceil($adjustableLimit * $adjustPercent);
	
		$color = str_pad(dechex($color + $adjustAmount), 2, '0', STR_PAD_LEFT);
	}
	
	return '#' . implode($hexCode);
}
//this function is currently not using
function time_zonelist(){
	$return = array();
	$timezone_identifiers_list = timezone_identifiers_list();
	foreach($timezone_identifiers_list as $timezone_identifier){
		$date_time_zone = new DateTimeZone($timezone_identifier);
		$date_time = new DateTime('now', $date_time_zone);
		$hours = floor($date_time_zone->getOffset($date_time) / 3600);
		$mins = floor(($date_time_zone->getOffset($date_time) - ($hours*3600)) / 60);
		$hours = 'GMT' . ($hours < 0 ? $hours : '+'.$hours);
		$mins = ($mins > 0 ? $mins : '0'.$mins);
		$text = str_replace("_"," ",$timezone_identifier);
		$return[$timezone_identifier] = $text.' ('.$hours.':'.$mins.')';
	}
	return $return;
}
//This function is used to check kyc document uploaded or not - self verification
function sel_verifi($uid,$limit=0,$table_name=''){
	global $data;
	/*
	//fetch data from verification_table
	$result=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}verification_table`".
		" WHERE `clientid`='{$uid}' ".
		($table_name?" AND `table_name`='{$table_name}' ":"").
		" ORDER BY `id` DESC ".
		($limit?" LIMIT 1 ":"").
		" ",0
	);
	if(isset($result[0])&&$limit){return $result[0];}
	else{return $result;}
	*/
}

//This function is used to insert data verification_table - I think currently not using
function insert_verifi($post='',$uid=0,$table_name='',$reference='',$post_status='',$response_status=''){
	global $data;
	/*
		if (is_array($post)){ 
			$post=jsonencode($post);
		}
		//insert data into verification_table
		db_query(
			"INSERT INTO `{$data['DbPrefix']}verification_table`(".
			"`clientid`,`table_name`,`reference`,`post_status`,`response_status`,`json_value`".
			")VALUES(".
			"{$uid},'{$table_name}','{$reference}','{$post_status}','{$response_status}','{$post}')",0
		);
		$newid=newid();	//fetch newly added table id
		
		return $newid;	//return newly added table id
	*/
}

//The use of encode_img() is to encrypt image name.
function encode_img($file){
	$result=array();
	if(!empty($file) && file_exists($file))
	{
		$img_1	= pathinfo($file, PATHINFO_FILENAME);
		$ext_1	= pathinfo($file, PATHINFO_EXTENSION);

		$path_img		= $file;
		$file_get_img	= file_get_contents($path_img); 
		$base64_img		= base64_encode($file_get_img); 

		$result['name']	= $img_1;
		$result['ext']	= $ext_1;
		$result['img']	= $base64_img;
	}
	return $result;
}

//The use of countryCodeMatch2() is - fetch the country list base on two universal country codes.
function countryCodeMatch2($country_two,$countries='',$countryCode='',$donotmatchcountries=''){
	$country_two=strtolower($country_two);
	$countries=strtolower($countries);
	$countryCode=strtolower($countryCode);
	$donotmatchcountries=strtolower($donotmatchcountries);
	
	$result=" universalWisePay hide1";
	//$result=" universalWisePay hide1 fin 1_$country_two 2_$countries 3_$countryCode 4_$donotmatchcountries";
	
	if((!empty($donotmatchcountries))&&(strpos($donotmatchcountries,$country_two)!==false)){ 
		$result=" hide1 hide dnmc ".$country_two;
	}
	elseif((empty($countries))&&(empty($countryCode))){ 
		$result=" countryWisePay universal";
	}
	elseif((!empty($countries))&&(strpos($countries,$country_two)!==false)){ 
		$result=" countryWisePay ".$country_two;
	}
	elseif((!empty($countryCode))&&(strpos($countryCode,$country_two)!==false)){ 
		$result=" countryWisePay ".$country_two;
	}
	//else{ $result=""; }
	

	return $result; 
}
//An automatically generated string that can be used in place of real string/text.
function mask($str, $first=0, $last=4) {
	$len = strlen($str);
	$toShow = $first + $last;
	return substr($str, 0, $len <= $toShow ? 0 : $first).str_repeat("*", $len - ($len <= $toShow ? 0 : $toShow)).substr($str, $len - $last, $len <= $toShow ? 0 : $last);
}

//An automatically generated email that can be used in place of real email address.
function mask_email($email) {
	$mail_parts = explode("@", $email);
	$domain_parts = explode('.', @$mail_parts[1]);
	
	$mail_parts[0] = mask($mail_parts[0], 2, 1); // show first 2 letters and last 1 letter
	$domain_parts[0] = mask($domain_parts[0], 2, 1); // same here
	$mail_parts[1] = implodes('.', $domain_parts);
	
	return implodes("@", $mail_parts);
}
//No any use
function remove_keyf($array, $key){
	foreach($array as $k => $v) {
		if(is_array($v) && $k != $key) {
			$array[$k] = remove_keyf($v, $key);
		} elseif($k == $key) {
			if(isset($array[$k])){unset($array[$k]);}
		}
	}
	return $array;
}
//No any use
function remove_key_arf($array, $keyArray){
	foreach($keyArray as $key) {
		$array=remove_keyf($array, $key);
	}
	return $array;
}
//No any use
function unsetf($unsetPram){
	if(isset($unsetPram)){unset($unsetPram);}
}

//The unset_f1() used to unset _POST, _GET and _SESSION parameters
function unset_f1($unsetPram){
	if(is_array($unsetPram)){
		foreach($unsetPram['un_m'] as $m){
			foreach($unsetPram['un_p'] as $p){
				foreach($unsetPram['un_v'] as $v){
					if($m=='_SESSION'){unset($_SESSION[$p][$v]);}	//unset _SESSION parameters
					if($m=='_POST'){unset($_POST[$p][$v]);}			//unset _POST parameters
					if($m=='_GET'){unset($_GET[$p][$v]);}			//unset _GET parameters
				}
			}
		}
	}
} 

//The unset_sessionf() used to unset _SESSION parameters
function unset_sessionf($unsetPram){

	if(is_array($unsetPram)){
		foreach($unsetPram as $k=>$v){
			if(isset($_SESSION[$v])){unset($_SESSION[$v]);}
		}
	}
}

//The unset_array used to unset array parameters - ex: unset_array($post, ['name', 'email','address','telephone','country']);
function unset_array($array, $keys){
    foreach($keys as $key){
        if(isset($array[$key])) unset($array[$key]);
    }
	return $array;
}

//The insert_api_data_table() used to insert bank information in JSON format.
function insert_api_data_table($use_for='', $pram_value='', $json=''){
	global $data; 
	$qprint=0; 
	if(isset($_GET['qp'])){$qprint=1;}

	if(is_array($json)){$json=json_encode($json);}

	$result=array();
	$result['use_for']		= $use_for;
	$result['pram_value']	= $pram_value;
	$result['josn']			= $json;
	$result['j']			= json_decode($json,true);
	
	//query for insert data
	db_query(
		"INSERT INTO `{$data['DbPrefix']}api_data_table`(".
		"`use_for`,`pram_value`,`josn`".
		")VALUES(".
		"'{$use_for}','{$pram_value}','{$json}'".
		")",$qprint
	);
	
	return $result;	//return data in array
}

//The select_api_data_table() used to fetch bank information from the table and convert from JSON format to array.
function select_api_data_table($use_for='banks', $pram_value='', $id=0, $single=true){
	global $data;
	$qprint=0; 
	if(isset($_GET['qp'])){$qprint=1;}

	//fetch data fron api_data_table
	$apitable=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}api_data_table`".
		" WHERE `use_for`='{$use_for}'".
		($pram_value?" AND `pram_value`='{$pram_value}'":'').
		($id?" AND `id`='{$id}'":'').($single?" LIMIT 1 ":''),$qprint
	);
	$result=array();
	if($single){	//if single is true then return single row (LIMIT 1)
		$result=$apitable[0];
		$result['j']=json_decode($result['josn'],true);
	}else{
		//make recursively array 
		foreach($apitable as $key=>$value){
			foreach($value as $name=>$v){
				$result[$key][$name]=$v;
				if($name=='josn'){ 
					$result[$key]['j']=json_decode($v['josn'],true);
				}
			}
		}
	}
	return $result;	//return data in array
} 

//The c_table() used to create table css dynamically.
function c_table($array, $width='',$t_style='width="700px" align="center" border="0" cellpadding="4" cellspacing="0" bordercolor="#999999" style="width:700px;background-color:#fff;border-collapse:collapse;font:12px/14px Verdana,Tahoma,Trebuchet MS,Arial;color: #555555;"',$colStyle='style="background-color:#fff;font-size:16px;line-height:20px;"'){

	if(trim($width)){$t_style=str_replace('700px',$width,$t_style);}

	$html = '<table '.$t_style.'>';
	$i=0;$j=0;
	foreach( $array as $key=>$value){
		if(!empty($value['v'])&&is_string($value['v'])){$value['v']=trim($value['v']);}
		if(!empty($value['c'])&&trim($value['c'])){
			$html .= '<tr '.$colStyle.'>';
			$html .= '<td colspan="3" style="padding:28px 4px 12px 4px;"><b>'.($value['c']).'</b></td>';
			$html .= '</tr>';	
		}elseif(!empty($value['v'])){
			$html .= '<tr style="background-color:#fff;">';
			foreach($value as $key2=>$value2){
				$html .= ($j%2?'<td width="2%"> : </td>':'');
				$html .= '<td '.($j%2?'width="70%"':'width="28%"').'>' . ((is_array($value2))?json_encode($value2):$value2) . '</td>';
				$j++;
			}
			$html .= '</tr>';
			$i++;
		}
	}
	$html .= '</table>';
	return $html;
}

//$array[]=["n"=>"Name","v"=>"Mit Sin"]; $array[]=["c"=>"<a href='https://google.com' style='text-decoration:none;color:#0047af;'>Merchant Contact Details</a>"]; echo c_table($array,'400px');


// retrun url encode base via replace space into + and remove the new line and tab 
function replace_space_tab_br_for_intent_deeplink($theUrl,$theCondtion=0){
	
	//Remove new line and tab 
	$theUrl = preg_replace('~[\r\n\t]+~', '', $theUrl);

	if( ($theCondtion==1) && (!preg_match("@^[a-zA-Z0-9%+-_]*$@", $theUrl)) )
	{
		// not encoded, need to encode it
		$theUrl = urlencode($theUrl);
	}
	
	$theUrl = preg_replace('~[\r\n\t]+~', '', $theUrl);
	
	//replace space via + 
	$theUrl = str_ireplace([' ',' ',' '], '+', $theUrl);
	return $theUrl;
	
}

//make sure for not encoded, need to encode with remove tab & new line
function urlencodef($urlEncode){
	if(!preg_match("@^[a-zA-Z0-9%+-_]*$@", $urlEncode))
	{
		// not encoded, need to encode it
		$urlEncode = urlencode($urlEncode);
	}
	$urlEncode = preg_replace('~[\r\n\t]+~', '', $urlEncode);
	return $urlEncode;
}

//make sure for decoded, need to multiple time decoded with remove tab & new line
function urldecodef($urlDeCode,$replaceSpace=0){
	$urlDeCode = preg_replace('~[\r\n\t]+~', '', $urlDeCode);
	$urlDeCode = urldecode($urlDeCode);
	$urlDeCode = urldecode($urlDeCode);
	$urlDeCode = urldecode($urlDeCode);
	$urlDeCode = urldecode($urlDeCode);
	$urlDeCode = urldecode($urlDeCode);
	$urlDeCode = urldecode($urlDeCode);
	$urlDeCode = urldecode($urlDeCode);
	$urlDeCode = urldecode($urlDeCode);
	$urlDeCode = urldecode($urlDeCode);
	$urlDeCode = (html_entity_decode($urlDeCode));
	if($replaceSpace==1) {
		//replace space via + 
		$urlDeCode = str_ireplace([' ',' ',' '], '+', $urlDeCode);
	}
	return $urlDeCode;
}

//The json_decode_is() used to returns the value encoded in json in appropriate PHP type. Values true , false and null are returned as true, false and null respectively. null is returned if the json cannot be decoded or if the encoded data is deeper than the nesting limit.
function json_decode_is($string,$cond=0) {
	if(is_array($string)) return $string;
	return (json_decode($string) == null) ? $string : json_decode($string,true) ;
}


//The isJsonDe() used to returns the value encoded in json in appropriate PHP type. Values true , false and null are returned as true, false and null respectively. null is returned if the json cannot be decoded or if the encoded data is deeper than the nesting limit.
function isJsonDe($string, $cond = 0) {
    // Ensure $string is a string, defaulting to an empty string if null
    $string = $string ?? '';

    // Decode the JSON and check if it's null
    return (json_decode($string) === null) ? $string : json_decode($string, true);
}
//The isJsonEn() used to returns a string containing the JSON representation of the supplied array.
function isJsonEn($string) {
	if(is_array($string)){
		
	}elseif (preg_match('/^[\[\{]\"/', $string)) {
		$string=isJsonDe($string);		//json to array
		$string=jsondecode($string);	//json to array
	}
	return $string;
}

//The createJsonf() used to returns a string containing the JSON representation of the supplied value.
function createJsonf($jParam,$jData){
	$result=array();
	$jDataArray=isJsonEn($jData);	//array to json
	//$jDataArray=isJsonDe($jData);
	if(is_array($jDataArray)){
		$result=$jDataArray;
	}else{
		$result[$jParam]=$jData;
	}
	return json_encode($result);	//return json string
}

//no any use
function formatPeriodf($endtime=0,$starttime=0){
	if($starttime==0){ $starttime=microtime(true); }
	$duration = $endtime - $starttime;
	$hours = (int) ($duration / 60 / 60);
	$minutes = (int) ($duration / 60) - $hours * 60;
	$seconds = (int) $duration - $hours * 60 * 60 - $minutes * 60;
	return ($hours == 0 ? "00":$hours) . ":" . ($minutes == 0 ? "00":($minutes < 10? "0".$minutes:$minutes)) . ":" . ($seconds == 0 ? "00":($seconds < 10? "0".$seconds:$seconds));
}

//The format_periodf() used to returns the duration in micro seconds.
function format_periodf($seconds_input){
	$hours = (int)($minutes = (int)($seconds = (int)($milliseconds = (int)($seconds_input * 1000)) / 1000) / 60) / 60;
	return $hours.':'.($minutes%60).':'.($seconds%60).(($milliseconds===0)?'':'.'.rtrim($milliseconds%1000, '0'));
}


//The passwordCheck() used for check login password is correct or not.
function passwordCheck($uid,$passParam,$tbl='clientid_table'){
	global $data;
	$result=0;
	//fetch store password from defined table (default clients)
	$qry_result=db_rows("SELECT `password` FROM `{$data['DbPrefix']}{$tbl}` WHERE id='{$uid}' LIMIT 1");
	$pass=$qry_result[0]['password'];	//encoded password

	if($pass!=hash_f($passParam)){	//compare DB password with login password (after encode with hash)
		$result=0;
	}else{
		$result=1;
	}
	return (bool)$result;	//return true/false
}

//The getCharf() used to returns a character from a string at specified position.
function getCharf($str,$len=0){
	$result='';
	if($str){
		$result=$str[$len];
	}
	return $result;
}

//The impf() function returns a string from the elements of an array or string. Default implode via comma (,).
function impf($array,$quote=0,$implode=","){
	if(is_string($array)){
		$array=str_ireplace(['"',"'"],'',$array);
		$array=explode($implode,$array);	//make array via delimiter 
	}
	
	if(is_array($array)){
		if($quote==1)
			$array='"'.implodes('","',$array).'"';	//make double quote from string as query if($quote==1)
		elseif($quote==2)
			$array="'".implodes("','",$array)."'";	//make singal quote from string as query for search
		else
			$array=implode($implode,$array);	//make string
	}
	
	return $array;
}

//The implodef() function returns a string from the elements of an array. Default implode via comma (,).
function implodef($array,$implode=","){
	if(is_array($array)){
		$array=implode($implode,$array);	//make string
	}
	return $array;
}

//The implodes() function returns a string from the elements of an array
function implodes($implod,$array){
	if(is_array($array)){
		$array=implode($implod,$array);		//make string
	}
	return $array;
}

//The explodef() function breaks a string into an array. Default explode via dot (.).
function explodef($str,$explode='.',$no=-1){
	if(strpos($str,$explode)!==false){
		$array=explode($explode, $str);
		if($no!=-1){
			return $array[$no];		//return define array element
		}else{
			return $array;	//return full array
		}
	}else{
		return $str;
	}
}

//The explodes() function breaks a string into two parts of an array from dot (.). If dot not exists in string then return string as first array.
function explodes($str,$explode='.'){
	$result=array();
	if(strpos($str,$explode)!==false){
		$array=explode($explode, $str);
		$result['s1']=$array[0];	//return first element in s1
		$result['s2']=$array[1];	//return second element in s2
	}else{
		$result['s1']=$str;
		$result['s2']="";
	}
	return $result;	//return
}

//The queryArrayf() function used for create an exact query from mulitiple conditions and operator.
function queryArrayf($bucketsearch,$bucketname,$operator='LIKE',$implode='OR',$explode=';',$exactmatch=1){

	$result='';
	if(strpos($bucketsearch,',')!==false){
		$searchTerms = explode(',', $bucketsearch);		//breaks a string into an array via comma (,)
	}else{
		$searchTerms = explode($explode, $bucketsearch);//breaks a string into an array via defined symbol
	}
	$size=count($searchTerms);		//fetch size of array
	if($size>1 || $exactmatch!=1){
		$searchTermBits = array();
		foreach ($searchTerms as $term) {
			$term = trim($term);
			if (!empty($term)) {
				if($operator=='LIKE'||$operator=='1'){
					//$searchTermBits[] = " ( lower({$bucketname}) LIKE '%$term%' ) ";
					
					$searchTermBits[] = " ( CONVERT(`{$bucketname}` USING utf8) LIKE '%$term%' ) ";
				}
				elseif($operator=='NOT LIKE'||$operator=='2'){
					//$searchTermBits[] = " ( lower({$bucketname}) NOT LIKE '%$term%' ) ";
					$searchTermBits[] = " ( CONVERT(`{$bucketname}` USING utf8) NOT LIKE '%$term%' ) ";
				}
			}
		}
		$implode=" {$implode} ";
		return implodes($implode, $searchTermBits);	//array to string implode with $implode (default OR)
	}else{
		if($operator=='LIKE'||$operator=='1'){
			$que=" ( `{$bucketname}` IN ('{$bucketsearch}') )";
		}elseif($operator=='NOT LIKE'||$operator=='2'){
			$que=" ( `{$bucketname}` NOT IN ('{$bucketsearch}') )";
		}
		return $que;
	}
}

//The use of lf() function is - terminate the long string in fixed number of characters. Default value is 10.
function lf($str,$ch=10,$dot=0){ // length 
	if($dot>0){
		return $out = strlen($str) > $ch ? substr($str,0,$ch)."..." : $str;	//return with ...
	}else{
		return substr($str,0,$ch);	//return short string
	}
}

//The scrubbed_status_details() used to fetch details of scrubbed types
function scrubbed_status_details($scrubbed_data){
	global $data; 
	
	//Initialized result array element / variables with null or empty
	$result=array();
	$result['scrubbed_status']=0;
	$result['scrubbed_msg']='';
	$result['sp']='';
	$result['sc']=''; 
	$msg=''; 
	$sc=''; 
	$trn_success_count='';

	$trans_merID			=$scrubbed_data['trans_merID'];			//merID
	$trans_type				=$scrubbed_data['trans_type'];				//transaction type
	$trans_bill_email		=$scrubbed_data['trans_bill_email'];			//email id
	$trans_ip				=$scrubbed_data['trans_ip'];				//browsing IP address
	$trans_amount			=$scrubbed_data['trans_amount'];			//transaction amount
	$scrubbed_period		=$scrubbed_data['scrubbed_period'];			//scrubbed period
	$min_limit				=$scrubbed_data['min_limit'];				//minimum transaction limit
	$max_limit				=$scrubbed_data['max_limit'];				//maximum transaction limit
	$tr_scrub_success_count	=$scrubbed_data['tr_scrub_success_count'];	//total success transaction
	$tr_scrub_failed_count	=$scrubbed_data['tr_scrub_failed_count'];	//total fail transaction
	$pro_curre				=get_currency($scrubbed_data['bill_currency'])."";//transaction currency
	
	$today=date("Y-m-d");

	if($scrubbed_period==1){	//if transaction period is one day then create following query
		$dbqr=" AND (`merID`='{$trans_merID}') AND (`type`='{$trans_type}') AND (( `bill_email`='{$trans_bill_email}') OR (`bill_ip`='{$trans_ip}')) AND DATE_FORMAT(`tdate`,'%Y-%m-%d')='$today' ";
	}else{
		$beforedays=date('Y-m-d', strtotime($today. "-$scrubbed_period day"));
		
		//create query according scrubbed period
		$dbqr=" AND (`merID`='{$trans_merID}') AND ( `type`='{$trans_type}' ) AND (( `bill_email`='{$trans_bill_email}' ) OR ( `bill_ip`='{$trans_ip}' )) AND DATE_FORMAT(`tdate`,'%Y-%m-%d') >= '$beforedays' AND DATE_FORMAT(`tdate`,'%Y-%m-%d') <= '$today' ";
	}

	// Total Received Amount
	$sc_succ_trans_amount=scrubbed_sql($dbqr,'1','sum','amount');
	$sc_total_trans=scrubbed_sql($dbqr,'1,2','COUNT','id');
	$sc_success_trans=scrubbed_sql($dbqr,'1','COUNT','id');
	$sc_fail_trans=$sc_total_trans - $sc_success_trans;

	//echo "Success Amount :: $sc_succ_trans_amount ,Total Count :: $sc_total_trans , Success Count:: $sc_success_trans ,Fail Count:: $sc_fail_trans<br />";

	
	//echo "$sc_succ_trans_amount > $max_limit ";exit;

	//check maximum limit
	if($sc_succ_trans_amount > $max_limit ){ $msg.=", Max. transaction amount allowed ".$pro_curre.$max_limit." on your MID "; $sc.=' 1. max_limit';}

	//check minimum limit
	if($trans_amount < $min_limit ){ $msg.=", Min. transaction amount allowed ".$pro_curre.$min_limit." on your MID "; $sc.=' 2. min_limit'; }
	
	//check maximum limit
	if($trans_amount > $max_limit ){ $msg.=", Max. transaction amount allowed ".$pro_curre.$max_limit." on your MID. "; $sc.=' 3. max_limit'; }

	//check total success transaction
	if($sc_success_trans > $tr_scrub_success_count ){ $msg.=", Max. Success transactions allowed within ({$scrubbed_period} days) : {$sc_success_trans} from {$trn_success_count} on your MID";$sc.=' 4. success_count';}

	//check total fail transaction
	if($sc_fail_trans > $tr_scrub_failed_count ){ $msg.=", Max. Declined transactions allowed within ({$scrubbed_period} days) : {$sc_fail_trans} from {$tr_scrub_failed_count} on your MID";$sc.=' 5. failed_count';}

	if(isset($msg)&&$msg){	//if msg not empty the define following scrubbed parameters
		$result['scrubbed_status']=1;
		$result['scrubbed_msg']=ltrim($msg,", ");
		$result['sp']=$scrubbed_period;
		$result['sc']=$sc;

		$qr=array();
		$qr['SuccessAmount']=$sc_succ_trans_amount;		//total success amount
		$qr['TotalCount']=$sc_total_trans;				//total transaction
		$qr['SuccessCount']=$sc_success_trans;			//success count
		$qr['FailCount']=$sc_fail_trans;				//fail count
		$result['qr']=$qr;
		
		$sd=array();
		$sd['scrubbed_period']=$scrubbed_period.' days';	//scrubbed period
		$sd['min_limit']=$min_limit;						//minimum limit
		$sd['max_limit']=$max_limit;						//maximum limit
		$sd['SuccessCount']=$tr_scrub_success_count;		//success count
		$sd['tr_scrub_failed_count']=$sc_fail_trans;		//fail count
		$result['sd']=$sd;
	}
	return $result;	//return scrubbed result
}

//The salt_managementf() function is used to fetch salt management json.
function salt_managementf(){
	global $data; $result=array();

	//fetch data from salt_management table
	$select_pt=db_rows(
		"SELECT * FROM {$data['DbPrefix']}salt_management".
		" WHERE `salt_status` IN (1) ",0
	);
	
	//execute all rows
	foreach($select_pt as $key=>$value){
		$result['salt_id'][]=$value['id'];
		
		$value['bank_json_en']=jsonencode($value['bank_json'],1);	//array to json
		$tid=explode(",",$value['tid']);	//explode tid via comma (,)
		$value['aid']=$tid;

		$result['d'][$key]=$value;
		$result[$value['id']]=$value;
		
		foreach($tid as $val){
			$result['a_id'][]=$val;
		}
	}
	if(isset($result['a_id']) && $result['a_id']) {
//		sort(array_unique($result['a_id']));
		array_unique($result['a_id']);
		sort($result['a_id']);
	}
	return $result;	//return
}

$data['smDb']=[];
$data['smDb']['a_id']=[];

//check NO_SALT set or not
if(!isset($data['NO_SALT'])){
	if(!isset($_SESSION['smDb'])){
		$salt_management=salt_managementf();
		$_SESSION['smDb']=$salt_management;
	}
	$data['smDb']=$_SESSION['smDb'];
	//print_r($data['smDb']['a_id']);
}

//The merchant_categoryf() use for fetch the mcc_code from merchant_category table
function merchant_categoryf($id=0,$mcc=0,$mcc_code=''){
	global $data; $result=array();

	if(trim($mcc_code)) $mcc_code=impf($mcc_code,2);
	
	//fetch the mcc_code, category_name, category_key from merchant_category table
	$select_pt=db_rows(
		"SELECT `id`,`mcc_code`,`category_name`,`category_key` FROM {$data['DbPrefix']}mcc_code".
		" WHERE `category_status` IN (1) ".($id?" AND `id` IN ({$id}) ":"").($mcc_code?" AND `mcc_code` IN ({$mcc_code}) ":""),0
	);
	$data['mcc_codes_list']=[];
	foreach($select_pt as $key=>$value){
		if($mcc){
			$data['mcc_codes_list'][]=$value['mcc_code'];
		}elseif($id){
			$data['mcc_codes_list'][$value['mcc_code']]="(".$value['category_name']." | ".$value['mcc_code'].")";
		}else{
			$result['ga_id'][]		=$value['id'];
			$result['d'][$key]		=$value;
			$result[$value['id']]	=$value;

			$data['mcc_codes_list'][$value['mcc_code']]=$value['category_name']." | ".$value['mcc_code'];
		}
	}
	if($mcc){
		return implode(",",$data['mcc_codes_list']);
	}elseif($id){
		return implode(" / ",$data['mcc_codes_list']);
	}
	else{
		return $result;
	}
}

//The option_smf() used to fetch the list of salt as option/list.
function option_smf($post,$theId=null,$keyName='',$currentId=''){
	$result=''; 
	foreach($post as $key=>$value){
		if($value&&in_array($theId,$value[$keyName])){
			if($value['id']==$currentId){
				$selected='selected';
			}else{
				$selected='';
			}
			$result.="<option value='{$value['id']}' {$selected} >{$value['id']} | <b>{$value['salt_name']}</b> | {$value['acquirer_processing_creds_en']}</option>";
		}
	}
	return $result;
}

// array key count as a numeric value in key of array 
function countNumericKeys($array)
{
    $count = 0;
    foreach ($array as $key => $value)
    {
        if (is_numeric($key))
        {
            $count ++;
        }
        if (is_array($value))
        {
            $count += countNumericKeys($value);
        }
    }
    return $count;
}

//No any use
function findStrf($str, $arr) {
	foreach ($arr as &$s){
		if(strpos($str, $s) !== false){
			return $s; //return true;break;
		}
	}
	return false;
}

//The use of metaSecurityPolicy() funtion is setup Content-Security-Policy meta tags in header. Currently no any use of this func
function metaSecurityPolicy(){?>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" >
<meta http-equiv="Content-Security-Policy" content="default-src 'self' https: ; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *; object-src 'none'" >
<?
}

//to check the IP address is valid or not.
function checkIPAddressf($bill_ip) 
{
	//ipv4
	if(preg_match('#^(\d{1,3}\.){3}\d{1,3}$#', trim($bill_ip))){
		return true;
	}
	//ipv6
	if(preg_match('#^(((?=(?>.*?(::))(?!.+\3)))\3?|([\dA-F]{1,4}(\3|:(?!$)|$)|\2))(?4){5}((?4){2}|((2[0-4]|1\d|[1-9])?\d|25[0-5])(\.(?7)){3})$#i', trim($bill_ip))){
		return true;
	}
	return false;
}

//The tr_reasonf() function is used for fetch the reason from reason_table via id.
function tr_reasonf($reason) 
{
	global $data;
	$reason_table = select_tablef(" `reason`='{$reason}' ",'reason_table',0,1);	//reason list
	if(isset($reason_table['new_reasons'])&&$reason_table['new_reasons']){
		return $reason_table['new_reasons'];
	}else{
		return $reason;
	}
}

//The bclf() used to replace first six characters win bin of a card.
function bclf($ccno,$bin='') {
	if($ccno&&$bin){
		$ccno=substr_replace($ccno,$bin,0,6);	//first six characters of a card
	}
	return $ccno;
}

//The emtagf() function is used to print the name and/or email on the image or PDF.
function emtagf($email,$opt=1){
	$result=[];
	if(strpos($email,'>')!==false||strpos($email,'<')!==false){
		$email_ex=explode('<',$email);
		$name=$email_ex[0];
		$email_value=$email_ex[1];
		if($opt==1){
			return prntext($email_value);
		}elseif($opt==2){
			return prntext($name);
		}else{
			$result['name']=prntext($name);
			$result['email']=prntext($email_value);
		}

	}else{
		return $email;
	}
	return $result;
}

//this function to use to make intent url from UPI, for ios & android device
function intent_payment_url_f($intent_paymentUrl,$wallet_code_app,$allPara=0){
	global $data; $result=array();
	$data['appName']=ucfirst($wallet_code_app);	
	$intent_paymentUrl = urldecodef($intent_paymentUrl);
	if(isset($intent_paymentUrl) && !empty($intent_paymentUrl)) 
	{
		parse_str(parse_url($intent_paymentUrl, PHP_URL_QUERY), $intent_arr); 
		
		$deviceName=fetchDeviceName();
		
		
		if(isset($intent_arr) && $intent_arr &&$deviceName=='android') 
		{  // android 
			$data['os_device']='device_android';
			$data['intent_paymentUrl']=$intent_paymentUrl= "upi://pay?pa={$intent_arr['pa']}&pn={$intent_arr['pn']}&tr={$intent_arr['tr']}&tid={$intent_arr['tr']}&am={$intent_arr['am']}&cu=".@$intent_arr['cu']."&tn={$intent_arr['tn']}";
		
			$pay="pa={$intent_arr['pa']}&pn={$intent_arr['pn']}&tr={$intent_arr['tr']}&tid={$intent_arr['tr']}&am={$intent_arr['am']}&cu=".@$intent_arr['cu']."&tn={$intent_arr['tn']}";
			
			if($allPara)$pay=http_build_query($intent_arr);
			
			$sdk_package=@$data['sdk_package'][$wallet_code_app];
			
			if($sdk_package) $data['intent_paymentUrl']=$intent_paymentUrl='intent://pay?'.$pay.'#Intent;scheme=upi;package='.$sdk_package.';S.browser_fallback_url=https://play.google.com/store/apps/details?id='.$sdk_package.';end';
			
		}
		elseif(isset($intent_arr) && $intent_arr &&$deviceName=='ios') 
		{ // ios - iPhone
			$data['os_device']='device_ios';
			$intentData = $data['intent_paymentUrl']= ($intent_paymentUrl);
			$wallet_code_app=strtolower($wallet_code_app);
			if($wallet_code_app=='gpay') $iso_intent=str_replace('upi:/', 'gpay://upi', $intentData);
			elseif(!empty($wallet_code_app))
			$iso_intent=str_replace('upi:',$wallet_code_app.':',$intentData);
			
			if(isset($iso_intent)&&$iso_intent) $data['intent_paymentUrl']=$intent_paymentUrl=$iso_intent;
			
		}
	}
	//$_SESSION['SA']['intent_paymentUrl'] = $intent_paymentUrl;
	return $intent_paymentUrl;
}


//this function to use to make intent array url from UPI, for ios & android device
function intent_payment_array_url_f($intent_paymentUrl,$wallet_code_app,$allPara=0){
	global $data; $result=array();
	$data['appName']=ucfirst(@$wallet_code_app);	
	$intent_paymentUrl = $intetUrl_android['otherApps']= $intetUrl_ios['otherApps']= urldecodef($intent_paymentUrl);
	if(isset($intent_paymentUrl) && !empty($intent_paymentUrl)) 
	{
		parse_str(parse_url($intent_paymentUrl, PHP_URL_QUERY), $intent_arr); 
		
		$deviceName=fetchDeviceName();
		
		
		if(isset($intent_arr) && $intent_arr &&$deviceName=='android') 
		{  // android 
			$data['os_device']='device_android';
			$data['intent_paymentUrl']=$intent_paymentUrl= "upi://pay?pa={$intent_arr['pa']}&pn={$intent_arr['pn']}&tr={$intent_arr['tr']}&tid={$intent_arr['tr']}&am={$intent_arr['am']}&cu=".@$intent_arr['cu']."&tn={$intent_arr['tn']}";
		
			$pay="pa={$intent_arr['pa']}&pn={$intent_arr['pn']}&tr={$intent_arr['tr']}&tid={$intent_arr['tr']}&am={$intent_arr['am']}&cu=".@$intent_arr['cu']."&tn={$intent_arr['tn']}";
			
			if($allPara)$pay=http_build_query($intent_arr);
			
			$sdk_package=@$data['sdk_package'][$wallet_code_app];
			
			foreach($data['sdk_package'] as $ke=>$val){
				$intetUrl_android[$ke]='intent://pay?'.$pay.'#Intent;scheme=upi;package='.$val.';S.browser_fallback_url=https://play.google.com/store/apps/details?id='.$sdk_package.';end';
			}
			$intent_paymentUrl=$intetUrl_android;
			return $intetUrl_android;
			
			//if($sdk_package) $data['intent_paymentUrl']=$intent_paymentUrl='intent://pay?'.$pay.'#Intent;scheme=upi;package='.$sdk_package.';S.browser_fallback_url=https://play.google.com/store/apps/details?id='.$sdk_package.';end';
			
		}
		elseif(isset($intent_arr) && $intent_arr &&$deviceName=='ios') 
		{ // ios - iPhone
			$data['os_device']='device_ios';
			$intentData = $data['intent_paymentUrl']= ($intent_paymentUrl);
			
			if(isset($intentData)&&$intentData)
			{
				$intetUrl_ios['paytm']=str_replace('upi:', 'paytm:', $intentData);
				$intetUrl_ios['phonepe']=str_replace('upi:', 'phonepe:', $intentData);
				$intetUrl_ios['gpay']=str_replace('upi:/', 'gpay://upi', $intentData);
				$intetUrl_ios['zestmoney']=str_replace('upi:', 'zestmoney:', $intentData);
				$intetUrl_ios['bhim']=str_replace('upi:', 'bhim:', $intentData);
				$intetUrl_ios['jio']=str_replace('upi:', 'myjio:', $intentData);
				$intetUrl_ios['freecharge']=str_replace('upi:', 'freecharge:', $intentData);
				$intetUrl_ios['mobikwik']=str_replace('upi:', 'mobikwik:', $intentData);
				$intetUrl_ios['amazon']=str_replace('upi:', 'amazon:', $intentData);

				$intent_paymentUrl=$intetUrl_ios;
				return $intetUrl_ios;
			}
			/*
			else {
			
					$wallet_code_app=strtolower($wallet_code_app);
					if($wallet_code_app=='gpay') $iso_intent=str_replace('upi:/', 'gpay://upi', $intentData);
					elseif(!empty($wallet_code_app))
					$iso_intent=str_replace('upi:',$wallet_code_app.':',$intentData);
					
					if(isset($iso_intent)&&$iso_intent) $data['intent_paymentUrl']=$intent_paymentUrl=$iso_intent;
			}
			*/
		}
	}
	//$_SESSION['SA']['intent_paymentUrl'] = $intent_paymentUrl;
	return $intent_paymentUrl;
}

//it converts HTML entities in the string to their corresponding characters.
function html_entity_decodef($str){
	if(is_string($str))
	{
		$str = (html_entity_decode($str));
	}
	return $str;
}

//The htmlentitiesf() function converts characters to HTML entities
function htmlentitiesf($str){
	if(is_string($str))
	{
		$str = (htmlentities($str));
	}
	return $str;
}

//return string after remove tags and converts characters to HTML entities
function prntxt($str,$key=''){
	global $strip_tags_skip; 
	$strip_tags_skip['strip_tags_skip']=array_merge($strip_tags_skip['strip_tags_skip'],["json_log_history"]);
	if(is_string($str)){
		$str = jsonreplace($str);
		//$str = jsonencode($str);
		if( (preg_match('/^[\[\{]\"/', $str)) || (!empty($key)&&in_array($key, $strip_tags_skip['strip_tags_skip'])) ) {
			// check if json value 
			$str = trim($str);
		}else{
			$str = trim(htmlentities($str));
		}		
	}
	return $str;
}

//remove html tags
function strip_tags_d($a)
{
	return is_array($a) ? array_map('strip_tags_d', $a) : prntxt($a);
}

//fixed json array and return after decode from JSON to an array
function sqInArray(array $input, $jsonDe=0)
{
	//single quote, html and json in Array
	$output = $input; global $strip_tags_skip;
	if(isset($output)&&$output&&is_array($output)){
		foreach ($output as $key => $value) {
			if (is_string($value)) {
				$str = prntxt($value,$key);
				if( ($jsonDe) && (preg_match('/^[\[\{]\"/', $str)) ){
					$output[$key] = isJsonDe($str);
				}else{
					$output[$key] = $str;
				}
			} elseif (is_array($value)) {
				$output[$key] = sqInArray($value,$jsonDe);
			} elseif (is_object($value) && $jsonDe) {
				throw new Exception('Object found in Array by key ' . $key);
			}
		}
	}
	return $output;	//return
}

if(!function_exists('htmlTagsInArray')){
	//To removes some special keywords and tags.
	function htmlTagsInArray(array $input, $throwByFoundObject=true)
	{
		$output = $input;
		if(isset($output)&&$output&&is_array($output)){
			foreach ($output as $key => $value) {
				if (is_string($value)) {
					//$output[$key] = trim(strip_tags($value));
					if (strcmp($value, strip_tags($value)) == 0){
						// no tags found
						
						//returns a string or an array with all occurrences of search in subject (ignoring case) replaced with the given replace value.
						$text = str_ireplace(array('onmouseover','onclick','onmousedown','onmousemove','onmouseout','onmouseup','onmousewheel','onkeyup','onkeypress','onkeydown','oninvalid','oninput','onfocus','ondblclick','ondrag','ondragend','ondragenter','onchange','ondragleave','ondragover','ondragstart','ondrop','onscroll','onselect','onwheel','onblur',"'"), '', $value );
						$output[$key] = trim(htmlentities($text));
					}
					else
					{
						// tags found
						$output[$key] = htmlentities($value);
					}
				} elseif (is_array($value)) {
					$output[$key] = htmlTagsInArray($value);
				} elseif (is_object($value) && $throwByFoundObject) {
					throw new Exception('Object found in Array by key ' . $key);
				}
			}
		}
		return $output;
	}
}

//Dev Tech: 24-01-17 modify - fetch last available balance , available_rolling
function last_available_balance_and_rolling($id,$tdate,$uid,$qp=0,$tableId=0){
	global $data; $result=array();
			
	//$tdate_current_tr=date('Y-m-d H:i:s',strtotime($tdate));	//transaction date
	$tdate_current_tr=micro_current_date();	//transaction date
	
	//fetch last available balance , available_rolling and fetch required data from transactions table till transaction date which define above current trans
	
	if($data['connection_type']=='PSQL'){
		$qr_4="";
		$qr_5="";
	}
	else { 
		$qr_4="  AND ((STR_TO_DATE(`tdate`, '%Y-%m-%d %H:%i:%s.%f')) < (STR_TO_DATE('{$tdate_current_tr}', '%Y-%m-%d %H:%i:%s.%f')))  ";
		$qr_5=" AND `available_balance` != '' ";
	}
	
	if($tableId==1) $tableId_qr=" AND ( `id` < {$id} ) ";
	else $tableId_qr='';
	
	$pre_tra=db_rows(
		"SELECT (`id`) AS `id`, (`transID`) AS `transID`, (`tdate`) AS `tdate` , `available_balance` , `available_rolling`".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" WHERE ( `merID`='{$uid}' )".
		" AND ( `id` NOT IN ({$id}) ) ". $tableId_qr .
		" AND ( `trans_status` NOT IN (0,9,10) ) ".
		" AND (`available_balance` IS NOT NULL AND `available_balance` != '0.00' {$qr_5} ) ".$qr_4.
		" AND ( DATE(`tdate`) <= DATE('{$tdate_current_tr}') ) ".
		" ORDER BY tdate DESC LIMIT 1",$qp
	);


	$last_available_balance=number_formatf2(@$pre_tra[0]['available_balance']);	// available balance
	$last_available_rolling=number_formatf2(@$pre_tra[0]['available_rolling']);	// available rolling 
		
	$result['last_id']=@$pre_tra[0]['id'];
	$result['last_transID']=@$pre_tra[0]['transID'];
	$result['last_available_balance']=$last_available_balance;
	$result['last_available_rolling']=$last_available_rolling;
	
	return $result;
	
}

//Dev Tech : 23-10-04 start - fetch current available balance , available_rolling
function available_balance_and_rolling($id,$tdate,$uid,$qp=0){
	
	global $data; $result=array();
	
	// Y : Skip the available balance and rolling check for update fee
	if(isset($data['SKIP_AVAILABLE_BALANCE_AND_ROLLING'])&&$data['SKIP_AVAILABLE_BALANCE_AND_ROLLING']=='Y'){
		$result['current_available_balance']=0.00;
		$result['current_available_rolling']=0.00; 
	}
	else{
		//fetch last available balance , available_rolling and fetch required data from transactions table till transaction date which define above current trans
		
		if($data['connection_type']=='PSQL') { 
			$use_index="";
			$qr_5="";
		}
		else {
			$use_index="USE INDEX(tdate_desc)";
			$qr_5=" AND `available_balance` != '' ";
		}
		
		$current_tra=db_rows(
			"SELECT (`id`) AS `id`, (`transID`) AS `transID`, (`tdate`) AS `tdate` , `available_balance` , `available_rolling`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" {$use_index} WHERE ( `merID`='{$uid}' )".
			" AND ( `id` NOT IN ({$id}) ) ".
			" AND ( `trans_status` NOT IN (0,9,10) ) ".
			" AND (`available_balance` IS NOT NULL AND `available_balance` != '0.00' {$qr_5} ) ".
			" ORDER BY tdate DESC LIMIT 1",$qp
		);


		$current_available_balance=number_formatf2(@$current_tra[0]['available_balance']);	// available balance
		$current_available_rolling=number_formatf2(@$current_tra[0]['available_rolling']);	// available rolling 
			
		$result['current_id']=@$current_tra[0]['id'];
		$result['current_transID']=@$current_tra[0]['transID'];
		$result['current_available_balance']=$current_available_balance;
		$result['current_available_rolling']=$current_available_rolling;
	}
	return $result;
	
}

//Dev Tech : 23-10-04 Return to micro current date 
function micro_current_date(){
	global $data;
	if(isset($data['simple_current_date'])&&$data['simple_current_date']=='Y')
	return (new DateTime())->format('Y-m-d H:i:s');
	else
	return (new DateTime())->format('Y-m-d H:i:s.u');
}



//Dev Tech : 23-10-19 create transaction for backup  
### -11##########
function create_trans_for_backup($queryString='',$limit='')
{
	
	global $data; $pq=0;
	
	if(isset($_GET['pq'])&&$_GET['pq']) $pq=@$_GET['pq'];
	if(isset($_GET['qp'])&&$_GET['qp']) $pq=@$_GET['qp'];
	
	$backup_transIDs=[];
	if(!isset($_SESSION['backup_transIDs']))
		$_SESSION['backup_transIDs']=[];
	
	$notMatch_transIDs=[];
	if(!isset($_SESSION['notMatch_transIDs']))
		$_SESSION['notMatch_transIDs']=[];
	
	try {
		
		if(isset($data['Database_3'])&&$data['Database_3']&&function_exists('db_connect_3'))
		{
			
			// Fetch value like 30  for days of back from current date 
			if(isset($data['TRANS_BACKUP_DAYS'])&&!empty($data['TRANS_BACKUP_DAYS']))
				$day=@$data['TRANS_BACKUP_DAYS'];
			
			else $day='30'; // Set default 30 day back from current date 
			
			$day_1st = (int)$day+30; // duration of 30 days from assing backup days 
			//$day_1st = $day;
			$date_1st = date('Y-m-d',strtotime("-{$day_1st} days"));
			$date_2nd = date('Y-m-d',strtotime("-{$day} days"));
			
			

			if(empty($queryString))
				$queryString = "  AND  ( `tdate` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) )   ";
			
			$find_counts=db_rows(
				"SELECT  COUNT(`id`) AS `count`,  ".group_concat_return('`id`',0)." AS `id`,  ".group_concat_return('`transID`',0)." AS `transID` ".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
				" WHERE ".
					"`trans_status` IN (1,2,9,10,22,23,24) AND `acquirer` NOT IN (0,1,2,3,4,5) ".$queryString.
					"  LIMIT 1 ",$pq
			);
			
			$find_count=@$find_counts[0]['count'];
			$find_id=@$find_counts[0]['id'];
			$find_transID=@$find_counts[0]['transID'];
			
			if($pq) {
				
				echo "<br/><br/><hr/><br/><b>FIND COUNTS</b>=>".$find_count."<br/>";
				echo "<br/><b>FIND ID</b>=><br/>".$find_id."<br/>";
				echo "<br/><b>FIND transID</b>=><br/>".$find_transID."<br/><br/><hr/><br/>";
			}
			
			if($pq==3) 
			exit;

			if($find_count>0){
				
				$slct=db_rows(
					"SELECT  * ".
					" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
					" WHERE ".
						"`trans_status` IN (1,2,9,10,22,23,24) AND `acquirer` NOT IN (0,1,2,3,4,5)   ".$queryString.
						" ORDER BY `id` ASC ".$limit.
						//" ORDER BY `id` DESC ". // cmn
						//" LIMIT 5". // cmn
					" ",$pq
				);

				if($pq)	echo "<hr/>count=>".count($slct)."<br/><br/>";

					$j=0;
					
					foreach($slct as $key=>$value){
						$j++;
						
						if($pq)	
						echo $j.". transID=>".$value['transID'].", merID=>".$value['merID'].",  acquirer=>".$value['acquirer'].", id=>".$value['id'].", tdate=>".$value['tdate'].", trans_amt=>".$value['trans_amt'].", bill_amt=>".$value['bill_amt'].", trans_status=>".$value['trans_status']."<br/><hr/><br/>";
							
						
						$array_keys = array_keys($value);
						$insert_para = "`".implode("`, `",$array_keys)."`";
						$insert_valu = "'".implode("','",$value)."'";
						
						/*
						if($pq) echo "<br/><hr/><br/>insert_para=><br/>".$insert_para;
						if($pq) echo "<br/><hr/><br/>insert_valu=><br/>".$insert_valu;
						exit;
						*/
						
								
						$qry_insert="INSERT INTO `{$data['Database_3']}`.`{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
						"(".$insert_para.")VALUES".
						"(".$insert_valu." )";
							
						//if($pq) echo "<br/><hr/><br/>qry_insert=><br/>".$qry_insert."<br/>";
						
							
						$insert_id=db_query_3($qry_insert,$pq);
						
						//end - make sure the query for backup 
						
						
						
						//start - make sure the delete query after backup 
						
						if(@$insert_id==@$value['id'])
						{
							db_query(
								 "DELETE FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
								 " WHERE `id`='".$value['id']."'"
							);

							if($data['connection_type']=='PSQL'){
								db_query(
									"SELECT setval('{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}_id_seq', (SELECT MAX(`id`) FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`)+1);",0
								);
							}
							
							$backup_transIDs[]=$value['transID'];
							$_SESSION['backup_transIDs'][]=$value['transID'];
						} //end - make sure the delete query after backup 
						else
						{
							$notMatch_transIDs[]=$value['transID'];
							$_SESSION['notMatch_transIDs'][]=$value['transID'];
						}
						
					}
					
					
					
					// after backup data as per 7 days or previous day 
					
					// Delete the json log of 7 days before from current date  
					db_query("DELETE FROM `{$data['DbPrefix']}json_log` WHERE ( `tableName`='{$data['MASTER_TRANS_TABLE']}' )  AND  ( `created_date` BETWEEN (DATE_FORMAT('{$date_1st} 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$date_2nd} 23:59:59', '%Y%m%d%H%i%s')) ) ");
					
					
					if($data['connection_type']=='PSQL'){
						db_query(
							"SELECT setval('{$data['DbPrefix']}json_log_id_seq', (SELECT MAX(`id`) FROM `{$data['DbPrefix']}json_log`)+1);",0
						);
					}
					
					//  json log update 
					$action_name='backup_master_trans_table';
					$tableName='json_log';
					$json_log_arr=[];
					$json_log_arr['queryString']=$queryString;
					$json_log_arr['date_1st']=$date_1st;
					$json_log_arr['date_2nd']=$date_2nd;
					$json_log_arr['created_date']=(new DateTime())->format('Y-m-d H:i:s.u');
					$json_log_arr['transIDs_count']=count(@$backup_transIDs);
					$json_log_arr['transIDs']=implode(",",$backup_transIDs);
					$json_log_arr['not_match_transIDs_count']=count(@$notMatch_transIDs);
					$json_log_arr['not_match_transIDs']=implode(",",$notMatch_transIDs);
					
					if(!isset($transID)||empty($transID)) 
					{
						$tr_newtableid='';$merID='';$terNO='';$transID='';$reference='';$bill_amt='';$bill_email='';
					}
				
					//if(!is_array($json_log_arr)&&isset($_POST)) $json_log_arr=$_POST;
					
					//echo "<br/><hr/><br/>json_log_upd=> $tr_newtableid,$tableName,$action_name,$json_log_arr,$merID,$terNO,transID=>$transID,$reference,$bill_amt,$bill_email"; //exit;
				
					json_log_upd($tr_newtableid,$tableName,$action_name,$json_log_arr,$merID,$terNO,$transID,$reference,$bill_amt,$bill_email);
				
			}
			
			if($pq)
			{
				echo "<br/><hr/><br/>transID=> ".count(@$backup_transIDs)."<br/>".implode(",",$backup_transIDs)."<br/><br/>";

				echo "<br/><br/><hr/><br/><==Backup TransIDs==> ".count(@$_SESSION['backup_transIDs'])."<br/>".implode(",",@$_SESSION['backup_transIDs']);
				echo "<br/><br/><hr/>";

				echo "<br/><hr/><br/>Not Match transID=> ".count(@$notMatch_transIDs)."<br/>".implode(",",$notMatch_transIDs)."<br/><br/>";

				echo "<br/><br/><hr/><br/><==Not Match TransIDs==> ".count(@$_SESSION['notMatch_transIDs'])."<br/>".implode(",",@$_SESSION['notMatch_transIDs']);
				echo "<br/><br/><hr/>";
			}
		}
	}
	catch(Exception $e) {
		echo '<=create_trans_for_backup=> ' .$e->getMessage();
	}
}



//Generate for Prefix Trans Lenght wise : Add Prefix & Suffix Values To Each String with Lenght wise via prefix_trans_lenght('10314927651',19,2,'SE','O');  10314927651OOOOOOSE || prefix_trans_lenght('10314927651',31,1,'TRANSESSION','O');   TRANSESSIONOOOOOOOOO10314927651
function prefix_trans_lenght($transID,$length=31,$suffix=2,$addText='SESSION',$repeatText='9')
{
	$lenth = 0; $qp=0; if(isset($_REQUEST['qp'])) $qp=$_REQUEST['qp'];
	if(@$qp){ echo "<br/>transID lenth=>".strlen($transID).'<br/><br/>'; echo "<br/>length=>".$length.'<br/><br/>';}

	if( $length > strlen($transID) )
		$lenth = $length - strlen($transID.$addText);

	if(@$qp){ echo "<br/>addText=>".strlen($addText).'<br/><br/>'; echo "<br/>lenth=>".$lenth.'<br/><br/>';}

	if($lenth<0) { 
		$lenth = $length - strlen($transID);
		$addText='';
	}
	if($length <= strlen($transID)) $addText='';
	
	//$lenth = (int)$lenth; 

	if(@$qp) echo "<br/>lenth=>".$lenth.'<br/><br/>';

	$txt=''; 
	if($lenth>0 && $length > strlen($transID) ) for($i=1; $i<=$lenth; $i++) $txt.=$repeatText; 
	
	if($suffix==2) $result=$transID.$txt.$addText;
	else $result=$addText.$txt.$transID;
	if(@$qp) echo "<br/>txt=>".$txt.'<br/><br/>';


	$result = substr(@$result, 0, $length);

	return @$result;

}

//Fetch the capital first letter and spilt via space from string 
function ucname_f($string) {
	return str_replace(['_','-'],' ',ucwords(strtolower(preg_replace('/([^A-Z])([A-Z])/', "$1 $2", $string)),'|_- '));
}

//fetch the define comments with php function 
function getCommentsFuntion($pathOfFile,$headerRow) {
	
      
    // get all function from config_db
    $content = file_get_contents($pathOfFile);

	if(is_string($content)) $content = htmlentities($content);

    //preg_match_all("/(function )(\S*\(\S*\))/", $content, $matches); // org without comment 

    // with comment and not define the comment for functionn 
    preg_match_all("/\/\/(.*.)\r\nfunction (\S*\(\S*\))|\r\nfunction (\S*)/", $content, $matches);



    //print_r($matches);exit;
  

    // with comment
    //preg_match_all("/\r\n\/\/(.*.)\r\nfunction (\S*\(\S*\))/i", $content, $matches);

    // with comment and not define the comment for functionn 
    //preg_match_all("/\/\/(.*.)\r\nfunction (\S*\(\S*\))|\r\nfunction (\S*)/", $content, $matches);

    //print_r($matches);exit;

	global $data;
	

	@$headerRowId=str_replace(" ","_",@$headerRow);
	@$headerRowId=strtolower(@$headerRowId);

	$subLink="<a href='#{$headerRowId}' class='btn btn-light me-2'>".ucname_f($headerRow)."</a> ";
	$data['subLink'].=$subLink;


    $i=0;
    foreach($matches[2] as $match) {
        //$function[] = "// " . trim($match) . "<br />\n";

        //$function[] = '<tr><td class="fw-bold-11" colspan="2">' . trim($match) . '</td><td>' . ucname_f($match) . ' | <b>'.@$headerRow.'</b></td></tr>';

        if(!empty($match)&&trim($match)) $functionName =trim($match) ;
        elseif(!empty($matches[3][$i])&&trim($matches[3][$i])) $functionName =trim($matches[3][$i]) ;

        $function[] = '<tr><td class="fw-bold-11" >' . @$functionName  . '</td><td ><b>' . $matches[1][$i] . '</b> | <i>' . ucname_f(@$functionName) . '</i> | <b>'.@$headerRow.'</b></td></tr>';

        $i++;
    }
    natcasesort($function);
    $resultList='<tr class="hr"><td colspan="2"><h4><strong><a id="'.@$headerRowId.'"> </a>' . ucname_f($headerRow) . ' </strong>| Filename: <b>'.@$headerRow.'</b> </h4></td></tr>';
    return $resultList.implode('', @$function);
  
}

// display the code or print the variable with comments 
function codeDisplayPageWise($pathOfFile,$headerRow,$codeDisplay=0) {
	global $data;
	// get all function from config_db
	$content = file_get_contents($pathOfFile);
  
	if(is_string($content)) $content = htmlentities($content);

	@$headerRowId=str_replace(" ","_",@$headerRow);
	@$headerRowId=strtolower(@$headerRowId);

	$subLink="<a href='#{$headerRowId}' class='btn btn-light me-2'>".ucname_f($headerRow)."</a> ";
	$data['subLink'].=$subLink;

	if($codeDisplay){
  
	  $resultList='<tr class="hr"><td colspan="2"><h4><strong><a id="'.@$headerRowId.'"> </a>' . ucname_f($headerRow) . ' </strong>| Filename: <b>'.@$headerRow.'</b> </h4></td></tr>';
  
	  $resultList.="<tr><td colspan='2'><pre style='color:#f8f8f2;background-color:#272822;width:85vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;'>{$content}</code></pre></td></tr>";
	  
	  return @$resultList;
	}
	else 
	{
  
	  // $content=stf($content);
  
		// with comment and not define the comment for functionn 
		preg_match_all("/\/\/(.*.)\r\nif|else(\S*\(\S*\))|\r\nif|else(\S*)/", $content, $matches);
  
  
		//print_r($matches);exit;
  
		$i=0;
		foreach($matches[2] as $match) {
			//$function[] = "// " . trim($match) . "<br />\n";
  
			if(!empty($match)&&trim($match)) $functionName =trim($match) ;
			elseif(!empty($matches[3][$i])&&trim($matches[3][$i])) $functionName =trim($matches[3][$i]) ;
			elseif(!empty($matches[1][$i])&&!empty($matches[1][$i])) $functionName =trim($matches[1][$i]) ;
			
  
			if(!empty(@$functionName)&&@$functionName!='{'){
			  $function[] = '<tr><td >' . @$functionName  . '</td><td ><b>' . ucname_f($matches[0][$i]) . '</b> | <i>' . ucname_f(@$functionName) . '</i> | <b>'.@$headerRow.'</b></td></tr>';
			}
			$i++;
		}
		natcasesort($function);
		$resultList='<tr class="hr"><td colspan="2"><h4><strong><a id="'.@$headerRowId.'"> </a>' . ucname_f($headerRow) . ' </strong>| Filename: <b>'.@$headerRow.'</b> </h4></td></tr>';
		return $resultList.implode('', @$function);
	}
  
}

// hard code : display the code or print the hardcode 
function hardCodePrint($fileName='') {
	if($fileName=='')$fileName=basename(@$_SERVER['SCRIPT_NAME']);
	$content = file_get_contents(@$fileName); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";
}

//get the deffer start date from two timestamp ex. humanizef(date_dif('2024-07-24 10:10:10', '2024-07-24 10:10:30', 'second')); 20 seconds
function date_dif($since, $until, $keys = 'year|month|week|day|hour|minute|second')
{
    $date = array_map('strtotime', array($since, $until));

    if ((count($date = array_filter($date, 'is_int')) == 2) && (sort($date) === true))
    {
        $result = array_fill_keys(explode('|', $keys), 0);

        foreach (preg_grep('~^(?:year|month)~i', $result) as $key => $value)
        {
            while ($date[1] >= strtotime(sprintf('+%u %s', $value + 1, $key), $date[0]))
            {
                ++$value;
            }

            $date[0] = strtotime(sprintf('+%u %s', $result[$key] = $value, $key), $date[0]);
        }

        foreach (preg_grep('~^(?:year|month)~i', $result, PREG_GREP_INVERT) as $key => $value)
        {
            if (($value = intval(abs($date[0] - $date[1]) / strtotime(sprintf('%u %s', 1, $key), 0))) > 0)
            {
                $date[0] = strtotime(sprintf('+%u %s', $result[$key] = $value, $key), $date[0]);
            }
        }

        return $result;
    }

    return false;
}

// join the string with comman from array 
function humanizef($array)
{
    $result = array();

    foreach ($array as $key => $value)
    {
        $result[$key] = $value . ' ' . $key;

        if ($value != 1)
        {
            $result[$key] .= 's';
        }
    }

    return implode(', ', $result);
}

// Function to remove single quotes from strings in an array and set empty values to "0.00"
function removeSingleQuotes(&$array) {
    foreach ($array as $key => &$value) {
        if (is_array($value)) {
            // Recursively call the function for nested arrays
            removeSingleQuotes($value);
        } elseif (is_string($value)) {
            // Remove single quotes from the string
            $value = str_replace("'", "", $value);
        }

        // Set empty or null string values to "0.00"
        //if (is_null($value) || $value === '') { $value = "0.00"; }
    }
}

// Remove new lines, tabs, and single quotes 
function ltsr($value) {
    // Remove new lines, tabs, and single quotes
    $value = preg_replace("~[\r\n\t\']+~", "", $value); // Replace with a space
    return $value;
}

//sum from array of result query
function sum_f($trans_array=[],$sum='sum')
{
    //global $data; 
	$qp=0;
	if(isset($_REQUEST['qp'])&&$_REQUEST['qp']) $qp=@$_REQUEST['qp'];
	$total_sum=0;
	foreach ($trans_array as $key => $val) {

		if($qp) echo "<br/>total_sum=>".@$total_sum.'+'.getNumericValue($val[$sum]);
		//fetch only numeric values of the following fields for sum
		$total_sum	= $total_sum+getNumericValue($val[$sum]);
		

	}
	return $total_sum;
}


//Dev Tech: 25-01-20 Ensure the default database connection is restored after switching to another database connection, especially when managing multiple database connections.
function default_db_connect_f($qp=0)
{
    global $data; 
	if(isset($_REQUEST['qp'])&&$_REQUEST['qp']) $qp=@$_REQUEST['qp'];
	
	$default_db_connect=0;
	//More connection db

	if(isset($data['DB_CON'])&&isset($_SESSION['DB_CON']))
	{
		if($qp) echo "<br/>IS_DBCON_DEFAULT=>".@$data['IS_DBCON_DEFAULT']."<br/>";

		//$data['CONNECTION_TYPE_DEFAULT']='';
		// This is default db con
		if(isset($data['IS_DBCON_DEFAULT'])&&$data['IS_DBCON_DEFAULT']=='Y'){
			
			if($qp)
			{	
				echo "Not required this action because all ready stay in Latest Connection!!";
				echo "<br/>CONNECTION_TYPE_DEFAULT=>".$data['CONNECTION_TYPE_DEFAULT'];echo "<br/><br/>";
			}
			
		}
		elseif(isset($data['DBCON_DEFAULT'])&&isset($data['default_hostname'])&&isset($data['default_database'])&&isset($data['default_username'])&&isset($data['default_username'])&&isset($data['CONNECTION_TYPE_DEFAULT'])&&trim($data['CONNECTION_TYPE_DEFAULT']))
		{
			if($qp)
			{
				echo "<br/>connection dataDefault =>";print_r($dataDefault);
				echo "<br/>connection_type from =>".$data['connection_type'];
				echo "<br/>CONNECTION_TYPE_DEFAULT=>".$data['CONNECTION_TYPE_DEFAULT'];echo "<br/><br/>";
			}
			
			if(@$data['CONNECTION_TYPE_DEFAULT']=='PSQL') db_connect_psql_default(@$data['default_hostname'],@$data['default_database'],@$data['default_username'],@$data['default_password'],@$data['default_DbPort']);
			
			elseif(@$data['CONNECTION_TYPE_DEFAULT']=='MYSQLI') db_connect_mysqli_default(@$data['default_hostname'],@$data['default_database'],@$data['default_username'],@$data['default_password'],@$data['default_DbPort']);

			$default_db_connect=1; //Is default db connect ok
			
		}

	}
	return $default_db_connect;
}

//Using a INSERT INTO,UPDATE query based on the default database connection, ensuring accurate results when working with multiple database connections.
function db_rows_df($qu,$prnt=0,$default_db_connect=0)
{
    global $data; 
	if(isset($_REQUEST['qrp'])&&$_REQUEST['qrp']) $prnt=@$_REQUEST['qrp'];

	if(@$default_db_connect==1&&isset($data['CONNECTION_TYPE_DEFAULT'])&&@$data['CONNECTION_TYPE_DEFAULT']=='PSQL')
			$result=db_rows_psql_default($qu,$prnt);
	elseif(@$default_db_connect==1&&isset($data['CONNECTION_TYPE_DEFAULT'])&&@$data['CONNECTION_TYPE_DEFAULT']=='MYSQLI') 
			$result=db_rows_mysqli_default($qu,$prnt);
	else 	$result=db_rows($qu,$prnt);
	return $result;
}

//Fetch data using a SELECT query based on the default database connection, ensuring accurate results when working with multiple database connections.
function db_query_df($qu,$prnt=0,$default_db_connect=0,$default_db_connect_mysqli=0)
{
    global $data; 
	if(isset($_REQUEST['qrp'])&&$_REQUEST['qrp']) $prnt=@$_REQUEST['qrp'];

	if(@$default_db_connect==1&&isset($data['CONNECTION_TYPE_DEFAULT'])&&@$data['CONNECTION_TYPE_DEFAULT']=='PSQL')
			$result=db_query_psql_default($qu,$prnt);
	elseif(@$default_db_connect==1&&@$default_db_connect_mysqli==1&&isset($data['CONNECTION_TYPE_DEFAULT'])&&@$data['CONNECTION_TYPE_DEFAULT']=='MYSQLI') 
			$result=db_query_mysqli_default($qu,$prnt);
	else 	$result=db_query($qu,$prnt);

	return $result;
}

//Auto Find NEW ID after query based on the default database connection
function newid_df($default_db_connect=0,$default_db_connect_mysqli=0)
{
    global $data; 
	if(isset($_REQUEST['qrp'])&&$_REQUEST['qrp']) @$prnt=@$_REQUEST['qrp'];

	if(@$default_db_connect==1&&isset($data['CONNECTION_TYPE_DEFAULT'])&&@$data['CONNECTION_TYPE_DEFAULT']=='PSQL')
			$result=newid_psql_default();
	elseif(@$default_db_connect==1&&@$default_db_connect_mysqli==1&&isset($data['CONNECTION_TYPE_DEFAULT'])&&@$data['CONNECTION_TYPE_DEFAULT']=='MYSQLI') 
			$result=newid_mysqli_default();
	else 	$result=newid();

	return $result;
}

// Use JSON to store and manage values for multiple database connections, ensuring each connection's details are organized and accessible
function db_from_f($qp=0)
{
    global $data; 
	
	if(isset($_REQUEST['qp'])&&$_REQUEST['qp']) $qp=@$_REQUEST['qp'];

	$DB_CON=(isset($_SESSION['DB_CON'])?@$_SESSION['DB_CON']:'');
	$db_ad=(isset($_SESSION['db_ad'])?@$_SESSION['db_ad']:'');
	$db_mt=(isset($_SESSION['db_mt'])?@$_SESSION['db_mt']:'');
	
	$db_from_arr=[];
	$db_from_arr['DB_CON']=$DB_CON;
	$db_from_arr['db_ad']=$db_ad;
	$db_from_arr['db_mt']=$db_mt;
	$db_from_arr['connection_type']=$data['connection_type'];
	$db_from_arr['db_database']=$data['Database'];
	$db_from_arr['db_username']=$data['Username'];
	$db_from_arr['db_hostname']=@$data['Hostname'];
	
	$db_from=jsonencode($db_from_arr,1,1);

	if($qp) echo "<br/><hr/><br/>db_from=>".@$db_from."<br/>";
	
	return $db_from;
}



//Mature - delay date for weekly 
function weekly_mature_date_f($dayName='Monday',$weeklyDelay='14',$date='')
{
	$result=[];
	// Get the current date
	if(!empty($date)&&trim($date))
		$currentDate = date('Y-m-d',strtotime($date));
	else $currentDate = date('Y-m-d');

	// Calculate 14 days ago
	$daysAgo = date('Y-m-d', strtotime('-'.$weeklyDelay.' days', strtotime($currentDate)));

	// Find the coming Wednesday of 14 days ago
	$comingDelayday = date('Y-m-d', strtotime('next '.$dayName, strtotime($daysAgo)));
	$result['currentDate']=@$currentDate;
	$result['daysAgo']=@$daysAgo;
	$result['weeklyDelay']=@$weeklyDelay;
	$result['mature_day']=@$comingDelayday;
	if(isset($_REQUEST['qp']))
	{
		// Output the result
		echo "Current Date: $currentDate <br/>";
		echo "<b>$weeklyDelay Days Ago: $daysAgo </b><br/>";
		echo "Coming $dayName: <b style='color:#c005c6;'>$comingDelayday </b><br/><hr/><br/>";
	}

	return $result;

}

//$comingDelayday=weekly_mature_date_f('Monday','21','2025-01-22');

function safe_redirect($url) {
    // Validate that the URL starts with http:// or https://
    if (!filter_var($url, FILTER_VALIDATE_URL) || !(stripos($url, "http://") === 0 || stripos($url, "https://") === 0)) {
        die("... Invalid URL provided for redirection via ".$url);
    }

    // Parse the URL to extract the domain
    $parsed_url = parse_url($url);
    if (!isset($parsed_url['host']) || !filter_var(gethostbyname($parsed_url['host']), FILTER_VALIDATE_IP)) {
        die("... Invalid domain in the URL provided for redirection via ".$url);
    }

    // Attempt to redirect using PHP header
    if (!headers_sent()) {
        header("Location: " . $url);
        exit;
    } else {
        // Fallback to JavaScript-based redirection
        echo "<script type='text/javascript'>top.window.location.href = '" . htmlspecialchars($url, ENT_QUOTES, 'UTF-8') . "';</script>";
        echo "<noscript><meta http-equiv='refresh' content='0;url=" . htmlspecialchars($url, ENT_QUOTES, 'UTF-8') . "'></noscript>";
        exit;
    }
}


##################################################################

//Mature - delay range of date for weekly 
function weekly_date_range($dayName='Monday',$weeklyDelay='14',$startDate='2024-06-01',$endDate='2025-01-21')
{
	
	// Find the first Monday on or after the start date
	$firstWednesday = date('Y-m-d', strtotime('next '.$dayName, strtotime($startDate)));
	//$firstWednesday = date('Y-m-d', strtotime('next Monday', strtotime($startDate)));

	// Initialize an array to store valid Monday
	$validWednesdays = [];

	// Set the current date to the first valid Monday
	$currentDate = $firstWednesday;

	// Loop through each Monday, adding 14 days until exceeding the end date
	while (strtotime($currentDate) <= strtotime($endDate)) {
		$validWednesdays[] = $currentDate; // Add the current date to the array
		$currentDate = date('Y-m-d', strtotime('+'.@$weeklyDelay.' days', strtotime($currentDate))); // Increment by 14 days
	}

	// Output the results
	if (!empty($validWednesdays)) {
		echo "<br/><hr/><br/>All $dayName every $weeklyDelay days within $startDate to $endDate:<br/>";
		echo implode("<br/>", $validWednesdays);
	} else {
		echo "<br/><hr/><br/>No $dayName found within the specified range.<br/>";
	}

	return @$validWednesdays;
}

//weekly_date_range('Wednesday','14','2024-06-01','2025-01-21');


/*
$domain_server=domain_serverf("","merchant"); 
$data['frontUiName']=$domain_server['frontUiName'];

$_SESSION['domain_server']=$domain_server;
if($domain_server['STATUS']==true){
	if(!empty($domain_server['sub_admin_css'])){
		$theme_color=$_SESSION['theme_color']=$data['theme_color']=$domain_server['sub_admin_css'];
		$data['themeName']=$theme_color;
	}
	//else{$_SESSION['theme_color']="orange";}
}else{
	//$_SESSION['theme_color']="orange";
}
if(isset($_SESSION['theme_color'])){
	$_SESSION['themeName']=$_SESSION['theme_color'];
}

*/

#######	auto get theme : start #######################################################
if(isset($data['AdminFolder'])&&$data['AdminFolder']){
	$adm_upth="/{$data['AdminFolder']}/";
}else{
	$adm_upth="/mlogin/";
}
$g_sid=0;$g_mid=0;
if((isset($data['G_MID']))&&$data['G_MID']){
	$g_mid=$data['G_MID'];
}elseif((isset($data['G_SID']))&&$data['G_SID']){
	$g_sid=$data['G_SID'];
}elseif((strpos($data['urlpath'],$adm_upth)!==false)){
	
	if(isset($_REQUEST['bid']) && ($_REQUEST['bid'])){$g_mid=(int)$_REQUEST['bid'];}
	
	if(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']){
		$g_sid=(int)$_SESSION['sub_admin_id'];
	} 
	if(isset($data['rootNoAssing'])&&$data['rootNoAssing']){}
	elseif((strpos($data['urlpath'],'/subadmin')!==false || strpos($data['urlpath'],'/password')!==false )&&isset($_REQUEST['id'])&&($_REQUEST['id'])){$g_sid=(int)$_REQUEST['id'];}
	elseif(((strpos($data['urlpath'],'/bank_gateway')!==false)||(strpos($data['urlpath'],'/requests')!==false))&& isset($_REQUEST['id'])&&($_REQUEST['id'])){$g_mid=0;}
	elseif(((strpos($data['urlpath'],'/trnslist')!==false)||(strpos($data['urlpath'],'/transactions')!==false)||(strpos($data['urlpath'],'/edit_transaction')!==false))&& isset($_REQUEST['bid']) && ($_REQUEST['bid'])){$g_mid=(int)$_REQUEST['bid'];}
	elseif(strpos($data['urlpath'],'/pricing_template')!==false){$g_mid=0;}
	elseif(strpos($data['urlpath'],'/acquirer_template')!==false){$g_mid=0;}
	elseif(isset($_REQUEST['id'])&&($_REQUEST['id'])){$g_mid=(int)$_REQUEST['id'];}
	
}elseif(((strpos($data['urlpath'],'/edit_trans')!==false))&&(isset($_REQUEST['bid']))){$g_mid=(int)$_REQUEST['bid'];
}elseif(isset($data['PageFile'])&&$data['PageFile']=='processall'){
	//$data['SponsorDomain']=1;
}elseif(isset($data['PageFile'])&&$data['PageFile']=='test3dsecureauthentication'){
	//$g_mid=(int)transIDf($_REQUEST['transID'],2);
}elseif(isset($_SESSION['uid'])&&$_SESSION['uid']){
	$g_mid=(int)$_SESSION['uid'];
}else{ }

//echo "<br/>g_sid=>".$g_sid;echo "<br/>g_mid=>".$g_mid;

if(!isset($data['SponsorDomain'])){

	$domain_server=$_SESSION['domain_server']=$data['domain_server']=sponsor_themef($g_sid,$g_mid);
	if(isset($domain_server['frontUiName'])) $data['frontUiName']=$domain_server['frontUiName'];
	//if($domain_server['STATUS']==true){
		if(!empty($domain_server['sub_admin_css'])){$_SESSION['themeName']=$_SESSION['theme_color']=$data['theme_color']=$domain_server['sub_admin_css'];}
	//}

}

#######	auto get theme : end #######################################################

//The use of sponsor_themefc() function is select the sponsor theme.
function sponsor_themefc($g_sid=0,$g_mid=0,$checkout_theme=''){
	global $data;
		
	$domain_server=$_SESSION['domain_server']=$data['domain_server']=sponsor_themef($g_sid,$g_mid,0);
	if(isset($data['domain_server']['as']['project'])&&$data['domain_server']['as']['project']&&$data['domain_server']['as']['project']=='clk'){
		$data['con_name']=$data['domain_server']['as']['project'];
		if($data['t_clk']){
			$data['t']=$data['t_clk'];
		}
		$data['clkStore']=0;		
	}

	if($checkout_theme){
		$data['frontUiName']=$checkout_theme;
	}else{
		$data['frontUiName']=$domain_server['frontUiName'];
	}
	if(!empty($domain_server['sub_admin_css'])){$_SESSION['themeName']=$_SESSION['theme_color']=$data['theme_color']=$domain_server['sub_admin_css'];}
	$data['TEMPATH']=$data['Host']."/".$data['FrontUI']."/".($data['frontUiName']?$data['frontUiName']:'default');
	return $domain_server;
}

if(isset($data['domain_server']['as']['project'])&&$data['domain_server']['as']['project']&&$data['domain_server']['as']['project']=='clk'){
	$data['con_name']=$data['domain_server']['as']['project'];
}
//echo "<br/>con_name1=>".$data['con_name'];print_r($data['domain_server']);

//echo "<br/>frontUiName=>"; print_r($data['frontUiName']);

// Assign for IND as per select the Front UI via SubAdmin list
if(isset($data['frontUiName'])&&in_array($data['frontUiName'],array("clk","sifi","IND","DFLT_IND","OPAL_IND_UX"))){
	$data['con_name']='clk';
	$data['clkStore']=0;
}else{
	$data['con_name']='';
	$data['clkStore']=0;	
}

//Dev Tech : 25-01-23 Force enable the project if it is IND, even without an IND theme, as required by Yoqo.
if(isset($data['domain_server']['as']['project'])&&$data['domain_server']['as']['project']&&$data['domain_server']['as']['project']=='IND'){
	$data['con_name']='clk';
	$data['clkStore']=0;
}

if(isset($data['frontUiName']) && $data['frontUiName']=='sys'){
	$data['leftPanelBody']=1;
}
if(isset($data['domain_server']['as']['clk'])&&$data['domain_server']['as']['clk']&&$data['domain_server']['as']['clk']=='BOTH'){
	if(isset($data['t_clk'])&&$data['t_clk']&&$data['t']){
		//$data['t']=keym_f($data['t_clk'],$data['t']);
	}
}

//echo "<br/><br/>frontUiName=>".$data['frontUiName']; echo "<br/><br/>con_name5=>".$data['con_name'];


//print_r($data['domain_server']);
//print_r($data['domain_server']['as']['gst_amt']);
//print_r($data['domain_server']['subadmin']['front_ui_panel']);
$data['is_admin_input_hide']='';
$data['is_admin_link']='';
if(isset($_REQUEST['admin'])&&($_REQUEST['admin'])&&(isset($_SESSION['adm_login']))){
	$data['is_admin_input_hide']='<input type="hidden" name="admin" value="1"><input type="hidden" name="hideAllMenu" value="1">';
	$data['is_admin_link']='&admin=1&hideAllMenu=1';
	if(isset($_REQUEST['tempui'])&&$_REQUEST['tempui']){
		$data['is_admin_link'].='&'.$_REQUEST['tempui'];
	}
}


// For Subadmin List Order
$data['subadmin_listorder']=array(
	'check_box'=>'Check Box',
	'username'=>'Username',
	'fullname'=>'Full Name',
	'rolesname'=>'Role',
	'domain_name'=>'Domain',
	'front_ui'=>'Front UI',
	'upload_css'=>'Color',
	'count_merchant'=>'Count Merchant',
	'count_transaction'=>'Count Transaction',
	'2fa'=>'2FA',	
	//'account_manager_id'=>'Account Manager',	
	'action'=>'Action'
);

// For Admin Transaction List Order 
$data['trnslist_listorder']=array(
	'transID'=>'TransID',
	'reference'=>'Reference',
	'action'=>'Action',
	'bearer_token'=>'Bearer Token',
	'fullname'=>'FullName',
	'bill_amt'=>'Bill Amt',
	'trans_amt'=>'Trans Amt',
	'available_balance'=>'Available Balance',
	'tdate'=>'Timestamp',
	'mop'=>'MOP',
	'trans_response'=>'Trans Response',
	'trans_status'=>'Trans Status',
	'merID'=>'Username',
	'acquirer_response'=>'Acquirer Response',
	'json_value'=>'Json Value',
	'json_log'=>'Json Log',
	'bill_currency'=>'Bill Currency',
	'mer_note'=>'Note Merchant',
	'support_note'=>'Support Note',
	'ccno'=>'CCNo',
	'source_url'=>'Source Url',
	'webhook_url'=>'Webhook Url',
	'return_url'=>'Return Url',
	'system_note'=>'System Note',
	'buy_mdr_amt'=>'Buy MDR Amt',
	'sell_mdr_amt'=>'Sell MDR Amt',
	'buy_txnfee_amt'=>'Buy TxnFee Amt',
	'rolling_amt'=>'Rolling Fee',
	'mdr_cb_amt'=>'MDR cb Amt',
	'mdr_cbk1_amt'=>'MDR cbk1 Amt',
	'mdr_refundfee_amt'=>'MDR RefundFee Amt',
	'payable_amt_of_txn'=>'Payable Amt of Txn',
	'settelement_date'=>'Settelement Date',
	'risk_ratio'=>'Risk Ratio',
	'transaction_period'=>'Transaction Period',
	'bank_processing_amount'=>'Bank Processing Amount',
	'bank_processing_curr'=>'Bank Processing Currency',
	'created_date'=>'Created Date',
	'acquirer_ref'=>'Acquirer Ref',
	'acquirer'=>'Acquirer',
	'trans_type'=>'Trans Type',
	'bill_email'=>'Bill Email',
	'bill_phone'=>'Bill Phone',
	'terNO'=>'TerNO',
	'product_name'=>'Product Name',
	'bill_address'=>'Bill Address',
	'bill_city'=>'Bill City',
	'bill_state'=>'Bill State',
	'bill_country'=>'Bill Country',
	'bill_zip'=>'Bill Zip',
	'descriptor'=>'Descriptor',
	'bill_ip'=>'Bill IP',
	'upa'=>'UPA',
	'rrn'=>'RRN',
	'gst_amt'=>'GST Amt',
	'multiple_check_box'=>'Multiple Check Box',
	'runtime'=>'Runtime'
);

// For Payin Transaction List Order
$data['payin_trnslist_listorder']=array(
	'transID'=>'TransID',
	'reference'=>'Reference',
	'action'=>'Action',
	'bearer_token'=>'Bearer Token',
	'fullname'=>'FullName',
	'bill_amt'=>'Bill Amt',
	'trans_amt'=>'Trans Amt',
	//'available_balance'=>'Available Balance',
	'tdate'=>'Timestamp',
	'mop'=>'MOP',
	'trans_response'=>'Trans Response',
	'trans_status'=>'Trans Status',
	//'merID'=>'Username',
	'acquirer_response'=>'Acquirer Response',
	'json_value'=>'Json Value',
	'json_log'=>'Json Log',
	'bill_currency'=>'Bill Currency',
	'mer_note'=>'Note Merchant',
	'support_note'=>'Support Note',
	'ccno'=>'CCNo',
	'source_url'=>'Source Url',
	'webhook_url'=>'Webhook Url',
	'return_url'=>'Return Url',
	'system_note'=>'System Note',
	'buy_txnfee_amt'=>'Buy TxnFee Amt',
	'rolling_amt'=>'Rolling Fee',
	'mdr_cb_amt'=>'MDR cb Amt',
	'mdr_cbk1_amt'=>'MDR cbk1 Amt',
	'mdr_refundfee_amt'=>'MDR RefundFee Amt',
	'payable_amt_of_txn'=>'Payable Amt of Txn',
	'settelement_date'=>'Settelement Date',
	'risk_ratio'=>'Risk Ratio',
	'transaction_period'=>'Transaction Period',
	'bank_processing_amount'=>'Bank Processing Amount',
	'bank_processing_curr'=>'Bank Processing Currency',
	'created_date'=>'Created Date',
	'acquirer_ref'=>'Acquirer Ref',
	'acquirer'=>'Acquirer',
	'trans_type'=>'Trans Type',
	'bill_email'=>'Bill Email',
	'bill_phone'=>'Bill Phone',
	'terNO'=>'TerNO',
	'product_name'=>'Product Name',
	'bill_address'=>'Bill Address',
	'bill_city'=>'Bill City',
	'bill_state'=>'Bill State',
	'bill_country'=>'Bill Country',
	'bill_zip'=>'Bill Zip',
	'descriptor'=>'Descriptor',
	'bill_ip'=>'Bill IP',
	'upa'=>'UPA',
	'rrn'=>'RRN',
	'gst_amt'=>'GST Amt',
	'runtime'=>'Runtime'
);


// For Default Payin Transaction List Order
$data['default_payin_trnslist_listorder']=array(
	'transID'=>'TransID',
	'reference'=>'Reference',
	'bill_amt'=>'Bill Amt',
	'trans_amt'=>'Trans Amt',
	'fullname'=>'FullName',
	'bill_email'=>'Bill Email',
	'upa'=>'UPA',
	'ccno'=>'CCNo',
	'mop'=>'MOP',
	'trans_status'=>'Trans Status',
	'trans_response'=>'Trans Response',
	'tdate'=>'Timestamp',
	'rrn'=>'RRN',
	'action'=>'Action',
	'created_date'=>'Created Date',
	'runtime'=>'Runtime'
);

?>