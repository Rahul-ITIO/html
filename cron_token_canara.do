<? 
// #!/var/www/html

/*

http://localhost:8080/gw/cron_token_canara.do?pq=1&public_key=MjcyXzE2XzIwMjQwODI0MTUyMTE3

cron_token_canara.do?pq=1&DB_CON=3&db_ad=1

Cront is Host base script for update access token & refresh token as per add in instance time and instance file cron_token_canara_instance.php    

https://cronl1.web1.one/cron_token_canara?pq=1&related_skip=1

*/


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


if(isset($_REQUEST['cron_host_response'])&&$_REQUEST['cron_host_response'])
	$cron_host_response=$_REQUEST['cron_host_response'];
else 
	$cron_host_response='CRON';

if(isset($_GET['cron_host_response'])&&$_GET['cron_host_response'])
	$cron_host_response=$_GET['cron_host_response'];


    
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


$data['HOST_REQUEST']='https://can-webhook.web1.one';

if(isset($data['HOST_REQUEST'])&&trim($data['HOST_REQUEST']))
{
    $host_path=@$data['HOST_REQUEST'];
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

##############################################################################


$acquirer_id='83';

$transID='83'.date('ymdHis');

if(isset($_REQUEST['acquirer_id'])){
	$acquirer_id=$_REQUEST['acquirer_id'];
}

if(isset($_REQUEST['pq'])){
	$data['pq']=$_REQUEST['pq'];
}







##############################################################################
if(isset($_REQUEST['a'])&&@$_REQUEST['a']=='a') 
{
    @$apc_get=[]; $data['cqp']=1;
    
    ################################################################

    //Get Access Token from table of Token 

    if(!isset($apc_get['refresh_token'])) 
    {
            
        $token_table_db=select_tablef(" `acquirer_id`='83' ",'token_table',0,1,"`access_token`,`refresh_token`,`previous_access_token`,`previous_refresh_token`,`code`,`updated_date`");

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
        echo "<br/><hr/><br/><h3>GET TOKEN TABLE DB QUERY=></h3><br/>"; 
        print_r(@$token_table_db);
        }

        if(isset($token_table_db)&&is_array($token_table_db))
        {
            if(isset($data['cqp'])&&$data['cqp']>0)
            echo "<br/><hr/><br/><h4>code=></h4>".@$token_table_db['code'];

            if(isset($token_table_db['code'])) unset($token_table_db['code']);
            @$apc_get=array_merge(@$apc_get,@$token_table_db);
        }

            
        //if token table for authorization bearer 
        if(isset($apc_get['access_token'])&&!empty($apc_get['access_token']))
        @$authorizationBearer=$apc_get['access_token'];

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h4>HOST PATH=></h4>"; print_r(@$host_path);
            echo "<br/><hr/><br/><h4>APC GET=></h4>"; print_r(@$apc_get);
            echo "<br/><hr/><br/><h4>access_token=></h4>"; print_r(@$apc_get['access_token']);
            echo "<br/><hr/><br/><h4>refresh_token=></h4>"; print_r(@$apc_get['refresh_token']);
            echo "<br/><hr/><br/><h4>authorizationBearer=></h4>"; print_r(@$authorizationBearer);
        }
    }
    ################################################################


    exit;
}
##############################################################################



$cronRefresh='cronRefresh=1';

//$hostGet='https://can-webhook.web1.one';
$hostGet=$host_path;

if($data['localhosts']==true){
    $hostGet=$data['Host'];
    $_REQUEST['public_key']='MjcyXzE2XzIwMjQwODI0MTUyMTE3';
}
$script_url=$hostGet.'/checkout?'.$cronRefresh;
$gateway_url=$hostGet.'/directapi?'.$cronRefresh;
//$gateway_url=$hostGet.'/directapi?actionajax=ajaxQrCode&acquirer=83&mop=QRINTENT&dtest=1';
//$gateway_url=$hostGet.'/checkout?actionajax=ajaxQrCode&acquirer=83&mop=QRINTENT&dtest=1';

$dataPost=array();
if(!isset($_REQUEST['public_key'])||empty($_REQUEST['public_key'])) $_REQUEST['public_key']='MjcyXzEwMzhfMjAyNDA4MTMxMTEwMjk';

if(@$data['pq']){
    echo "<br/><hr/><br/>POST REQUEST=><br/>"; print_r($_REQUEST);
}

$dataPost=@$_REQUEST;


$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$referer=$protocol.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];

//<!--Optional -->
//$dataPost["acquirer_id"]="83";
$dataPost["acquirer"]=@$acquirer_id;

//<!--default (fixed) value * default -->

$dataPost["integration-type"]="s2s";
//$dataPost["unique_reference"]="Y";
if($data['localhosts']) $dataPost["bill_ip"]='122.176.92.114';
else $dataPost["bill_ip"]=($_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);

if(!isset($dataPost["source"]))  $dataPost["source"]="cron_s2s_canara_refresh_token_request";
$dataPost["source_url"]=$referer;

//<!--product bill_amt,bill_currency and product name * by cart total bill_amt -->

if(!isset($dataPost["bill_amt"])) $dataPost["bill_amt"]="13.13";
if(!isset($dataPost["bill_currency"])) $dataPost["bill_currency"]="INR";
if(!isset($dataPost["product_name"])) $dataPost["product_name"]="Refresh Token ".@$cron_host_response;

//<!--billing details of .* customer -->

if(!isset($dataPost["fullname"])) $dataPost["fullname"]="Refresh Token";
if(!isset($dataPost["bill_email"])) $dataPost["bill_email"]="devops@itio.in";

if(!isset($dataPost["bill_address"])) $dataPost["bill_address"]="New Delhi";
if(!isset($dataPost["bill_city"])) $dataPost["bill_city"]="New Delhi";
if(!isset($dataPost["bill_state"])) $dataPost["bill_state"]="DL";
if(!isset($dataPost["bill_country"])) $dataPost["bill_country"]="IN";
if(!isset($dataPost["bill_zip"])) $dataPost["bill_zip"]="447602";
if(!isset($dataPost["bill_phone"])) $dataPost["bill_phone"]="+919999999999";

//$dataPost["reference"]="23120228"; // should be unique by time() or your reference is unique
if(!isset($dataPost["webhook_url"])) $dataPost["webhook_url"]=$hostGet."/responseDataList/?urlaction=webhook_url";
if(!isset($dataPost["return_url"])) $dataPost["return_url"]=$hostGet."/responseDataList/?urlaction=return_url";
if(!isset($dataPost["checkout_url"])) $dataPost["checkout_url"]=@$referer;

if(!isset($dataPost["mop"])) $dataPost["mop"]="CC";
if(!isset($dataPost["ccno"])) $dataPost["ccno"]="5438898014560229";
if(!isset($dataPost["ccvv"])) $dataPost["ccvv"]="123";
if(!isset($dataPost["month"])) $dataPost["month"]="10";
if(!isset($dataPost["year"])) $dataPost["year"]="31";


if(!isset($dataPost["actionajax"])) $dataPost["actionajax"]="ajaxQrCode";
if(!isset($dataPost["mop"])) $dataPost["mop"]="QRINTENT";
if(!isset($dataPost["os"])) $dataPost["os"]="web";

$dataPost["refreshTokenPost"]="1";


$curl_post=http_build_query($dataPost);

//https://can-webhook.web1.one/checkout?actionType=&actionUrl=&integration-type=Checkout&terNO=&public_key=MjcyXzEwMzhfMjAyNDA4MTMxMTEwMjk&return_url=https%3A%2F%2Fcan-webhook.web1.one%2FresponseDataList%2F%3Furlaction%3Dsuccess&webhook_url=https%3A%2F%2Fcan-webhook.web1.one%2FresponseDataList%2F%3Furlaction%3Dnotify&product_name=Refresh+Token&fullname=Refresh+Token&bill_email=test5134%40test.com&bill_address=161+Kallang+Way&bill_city=New+Delhi&bill_state=Delhi&bill_country=IN&bill_zip=110001&bill_phone=919821125134&bill_currency=INR&bill_ip=122.176.92.114&ccno=5438898014560229&ccvv=564&month=10&year=31&country_name=&REMOTE_ADDR=122.176.92.114&http_referer=https%3A%2F%2Fcan-webhook.web1.one%2Fp%2Fp&payment_mode=&bill_fees=&bussiness_url=&status=2&aurl=&source=&actionajax=ajaxQrCode&bill_amt=1.01&acquirer=83&mop=QRINTENT&dtest=1&refreshTokenPost=1

$script_url=@$script_url.'&'.@$curl_post; 

if(@$data['pq'])
{
    echo "<br/><br/>curl_url=><br/>".@$script_url; 
    echo "<br/><br/>gateway_url=><br/>"; print_r(@$gateway_url);
}

$curl_set=1;
if($curl_set==1)
{
    //S2S via curl method 
    if(isset($_REQUEST['cron_host_response'])&&$_REQUEST['cron_host_response']=='cron_token_canara_instance_XX.php')
    {
        
        $header = array();
        $header[] = 'Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5'; 
        $header[] = 'Cache-Control: max-age=0'; 
        $header[] = 'Content-Type: text/html; charset=utf-8'; 
        $header[] = 'Transfer-Encoding: chunked'; 
        $header[] = 'Connection: keep-alive'; 
        $header[] = 'Keep-Alive: 300'; 
        $header[] = 'Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7'; 
        $header[] = 'Accept-Language: en-us,en;q=0.5'; 
        $header[] = 'Pragma:'; 
        
        $userAgent = 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31' ;
        $userAgent = 'Mozilla/5.0 (compatible; Googlebot/2.1; +https://can-webhook.web1.one' ;

        
        // Path to your CA certificate file
        //$certFile = __DIR__ . "/can-webhook_web1_one.crt"; // Use absolute path based on script location
        $certFile = $rootPhp . "/can-webhook_web1_one.crt"; // Use absolute path based on script location


        // Initialize cURL session
        $curl = curl_init(); 

        // Set cURL options
        curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0); // Use HTTP/1.0
        curl_setopt($curl, CURLOPT_URL, @$gateway_url); // URL to make the request to (ensure $gateway_url is set correctly)

        // SSL/TLS options
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, true); // Verify the server's certificate
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2); // Verify the host name
        curl_setopt($curl, CURLOPT_CAINFO, $certFile); // Path to your CA certificate

        // Other options
        curl_setopt($curl, CURLOPT_ENCODING, ''); // Handle all encodings
        curl_setopt($curl, CURLOPT_USERAGENT, $userAgent); // Set your User-Agent here

        //curl_setopt($curl, CURLOPT_HTTPHEADER, $header); 
	    curl_setopt($curl, CURLOPT_REFERER, 'https://can-webhook.web1.one');

        curl_setopt($curl, CURLOPT_REFERER, $referer); // Referrer URL (ensure $referer is set correctly)
        curl_setopt($curl, CURLOPT_POST, 1); // Use POST method
        curl_setopt($curl, CURLOPT_POSTFIELDS, $dataPost); // Data to send in POST request (ensure $dataPost is set correctly)
        curl_setopt($curl, CURLOPT_HEADER, 0); // Don't include header in output
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true); // Return the transfer as a string
        curl_setopt($curl, CURLOPT_MAXREDIRS, 10); // Maximum number of redirects to follow
        curl_setopt($curl, CURLOPT_TIMEOUT, 60); // Maximum number of seconds to allow for the request

        // Execute the request and fetch the response
        $response = curl_exec($curl);

        // Check for cURL errors
        if (curl_errno($curl)) {
            echo 'cURL error: ' . curl_error($curl);
        } else {
            echo 'Response: ' . $response;
        }

        // Close cURL session
        curl_close($curl);
    }
    else
    {
        $curl_cookie="";
        $curl = curl_init(); 
        curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
        curl_setopt($curl, CURLOPT_URL, @$gateway_url);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_ENCODING, '');
        curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
        curl_setopt($curl, CURLOPT_REFERER, $referer);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $dataPost);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 10);
        curl_setopt($curl, CURLOPT_MAXREDIRS, 10);
        curl_setopt($curl, CURLOPT_TIMEOUT, 60);	
        $response = curl_exec($curl);
        curl_close($curl);
    }


    

    if(@$data['pq']){
        echo "<br/><hr/><br/>API POST RESPONSE=><br/>"; print_r(@$response);
    }

    $results = json_decode($response,true);

    if(@$data['pq'])
    {
        echo "<br/><hr/><br/><h3>response=></h3><br/>"; print_r(@$response);
        echo "<br/><hr/><br/><h3>RESULTS=></h3><br/>"; print_r(@$results);
    }


}


##############################################################################
/*
$results = array(
    "tokenRefreshUrl" => "https://apibanking.canarabank.in/v1/oauth2/refresh-token",
    "RtokenString" => "refresh_token=g0DckWUF8aZyBx9cuKt0dgbfIj9FNL63&grant_type=refresh_token",
    "RtokenResponse" => array(
        "access_token" => "J6Vzt8K3GjAaA3AZWJCdjisDxNMPHkHb",
        "refresh_token" => "GOKnWLlS29uAIdhe2kFoGq6nuY8gLdtF",
        "expires_in" => 86399,
        "scope" => "upi",
        "refresh_token_expires_in" => 604799
    ),
    "previousTokenRes" => array(
        "scope" => "jQAPqK2gVcZGA4AwGahhiFnPXjrOvJoK",
        "access_token" => "a2Ei3v56ujpOULRJwwgR4T6BCyaGclwG",
        "refresh_token" => "g0DckWUF8aZyBx9cuKt0dgbfIj9FNL63"
    ),
    "transID" => "83131070504601",
    "order_status" => 0,
    "status" => "Pending",
    "bill_amt" => 13.13,
    "descriptor" => "",
    "tdate" => "2024-08-30 16:43:01",
    "bill_currency" => "INR",
    "response" => "",
    "reference" => "",
    "mop" => "UPI",
    "rrn" => "",
    "upa" => "",
    "authstatus" => "https://can-webhook.web1.one/authstatus?action=authstatus&transID=83131070504601",
    "authurl" => "https://can-webhook.web1.one/authurl?transID=83131070504601",
    "webhook" => "OK",
    "info" => array(
        "cronRefresh" => 1,
        "public_key" => "MjcyXzEwMzhfMjAyNDA4MTMxMTEwMjk",
        "acquirer" => 83,
        "bill_ip" => "122.176.92.114",
        "source" => "cron_s2s_canara_refresh_token_request",
        "bill_currency" => "INR",
        "product_name" => "Refresh Token CRON",
        "fullname" => "Refresh Token",
        "bill_email" => "devops@itio.in",
        "bill_address" => "New Delhi",
        "bill_city" => "New Delhi",
        "bill_state" => "DL",
        "bill_country" => "IN",
        "bill_zip" => "447602",
        "bill_phone" => "919999999999",
        "webhook_url" => "https://can-webhook.web1.one/responseDataList/?urlaction=webhook_url",
        "return_url" => "https://can-webhook.web1.one/responseDataList/?urlaction=return_url",
        "checkout_url" => "https://can-webhook.web1.one/cron_token_canara",
        "mop" => "CC",
        "actionajax" => "ajaxQrCode",
        "os" => "web",
        "refreshTokenPost" => 1,
        "REMOTE_ADDR" => "52.66.153.180"
    )
);

$response = json_encode($results, JSON_PRETTY_PRINT);

*/
##############################################################################



echo "<br/><hr/><br/><h3>response=></h3><br/>"; print_r(@$response);


{
    
    echo "<br/><hr/><br/><h3>RESULTS=></h3><br/>"; print_r(@$results);
}



$transID=@$results['transID'];

$rTokenString=@$results['RtokenResponse'];

$access_token=@$rTokenString['access_token'];
$refresh_token=@$rTokenString['refresh_token'];


$previousTokenRes=@$results['previousTokenRes'];

$code=@$previousTokenRes['code'];
$previous_access_token=@$previousTokenRes['access_token'];
$previous_refresh_token=@$previousTokenRes['refresh_token'];

$updated_date=@micro_current_date();

##############################################################################

$token_table_update="`access_token`='{$access_token}', `refresh_token`='{$refresh_token}', `transID`='{$transID}', `code`='{$code}', `previous_access_token`='{$previous_access_token}', `previous_refresh_token`='{$previous_refresh_token}', `updated_date`='{$updated_date}'";


echo "<br/><hr/><br/><h3>TOKEN TABLE UPDATE QUERY=></h3><br/>"; print_r($token_table_update);

if(@$data['pq']){

    echo "<br/><br/><hr/>";
}


##############################################################################

$data['token_table']='token_table';

if(!empty($access_token)&&trim($access_token)&&!empty($refresh_token)&&trim($refresh_token))
{
    db_query(
        "UPDATE `{$data['DbPrefix']}{$data['token_table']}`".
        " SET ".$token_table_update.
        " WHERE `acquirer_id`='{$acquirer_id}'",$data['pq']
    );
}


//print_r(@$_REQUEST);
	
db_disconnect();

exit;

?>

