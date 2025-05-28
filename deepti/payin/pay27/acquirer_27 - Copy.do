<?

echo "========>111";exit;
// 27=26,27,271,17

$merNO=(int)(isset($apc_get['merNO'])&&trim($apc_get['merNO']))?$apc_get['merNO']:0);
$terNO=(int)(isset($apc_get['terNO'])&&trim($apc_get['terNO']))?$apc_get['terNO']:0);
$hash=$_SESSION['b_'.$acquirer]['hash_code'];
if(strpos($_SESSION['apJson'.$acquirer],"merNO")!==false){
	$merNO=(int)jsonvaluef($_SESSION['apJson'.$acquirer],"merNO");
}
$merMgrURL="localhost";
	
	
$b_br_failed='';
if((isset($_SESSION['b_'.$acquirer]['ajs']['br_failed']))&&($_SESSION['b_'.$acquirer]['ajs']['br_failed'])){
	$b_br_failed=$_SESSION['b_'.$acquirer]['ajs']['br_failed'];
}

	
if(isset($_GET['qp1']))
{
	echo "<br/>bg_active=>".$_SESSION['b_'.$acquirer]['bg_active'];
	echo "<br/>siteid_json=>".$_SESSION['siteid'.$acquirer];
}

######################################################################
//{"visa":{"merNO":"88856","terNO":"503376113301","hash":"76db14333dfc4be68c70ab4be509ab3b","merMgrURL":"digitalchillmart.com"},"mastercard":{"merNO":"88856","terNO":"503376113301","hash":"76db14333dfc4be68c70ab4be509ab3b","merMgrURL":"digitalchillmart.com"},"jcb":{"merNO":"88856","terNO":"503376113301","hash":"76db14333dfc4be68c70ab4be509ab3b","merMgrURL":"digitalchillmart.com"},"amex":{"merNO":"88856","terNO":"503376113301","hash":"76db14333dfc4be68c70ab4be509ab3b","merMgrURL":"digitalchillmart.com"}}


if(isset($apc_get)&&is_array($apc_get)&&$_SESSION['info_data']['mop']&&((strpos($_SESSION['apJson'.$acquirer],"visa")!==false)||(strpos($_SESSION['apJson'.$acquirer],"mastercard")!==false)||(strpos($_SESSION['apJson'.$acquirer],"jcb")!==false)||(strpos($_SESSION['apJson'.$acquirer],"amex")!==false))&&(isset($_SESSION['info_data']['mop'])&&$_SESSION['info_data']['mop'])){
	$apc_get=$apc_get[$_SESSION['info_data']['mop']];
}


if(isset($_GET['qp1']))
{
	echo "<br/>siteid_json=>".$_SESSION['siteid'.$acquirer];
	echo "<br/>apc_get=>";
	print_r($apc_get);
}

######################################################################

// old key by semicolon
if(!is_array($apc_get)&&isset($apc_get)&&(strpos($apc_get,";")!==false)){
	$this_siteid_exp=explode(';',$apc_get);
	
	if(isset($this_siteid_exp[0])&&$this_siteid_exp[0])$terNO=(int)$this_siteid_exp[0];
	if(isset($this_siteid_exp[2])&&$this_siteid_exp[2])$hash=$this_siteid_exp[2];
	if(isset($this_siteid_exp[3])&&$this_siteid_exp[3])$merMgrURL=$this_siteid_exp[3];
}


######################################################################

if(is_array($apc_get)&&isset($apc_get['merNO'])&&$apc_get['merNO']){
	$merNO=(int)$apc_get['merNO'];
}
if(is_array($apc_get)&&isset($apc_get['terNO'])&&$apc_get['terNO']){
	$terNO=(int)$apc_get['terNO'];
}
if(is_array($apc_get)&&isset($apc_get['hash'])&&$apc_get['hash']){
	$hash=$apc_get['hash'];
}
if(is_array($apc_get)&&isset($apc_get['merMgrURL'])&&$apc_get['merMgrURL']){
	$merMgrURL=$apc_get['merMgrURL'];
}

######################################################################


if($post['acquirer']==17 || $post['acquirer']=='17'){ 
	$post['ccno']='4343720275530054';
	$post['year']='2024';
	$post['month']='10';
	$post['ccvv']='323';
}
	

if(isset($_GET['qp1']))
{
	echo "<br/>merNO=>".$merNO;
	echo "<br/>terNO=>".$terNO;
	echo "<br/>hash=>".$hash;
	echo "<br/>merMgrURL=>".$merMgrURL."<br/>";
	print_r($apc_get);
	exit;
}

$post['year']=((strlen($post['year'])==4)?$post['year']:"20".$post['year']);
$post['month']=((strlen($post['month'])==2)?$post['month']:"0".$post['month']);


$post['ccholder']=trim(str_replace($post['ccholder_lname'], '', $post['ccholder']));
if(empty($post['ccholder'])&&!empty($post['ccholder_lname'])){
$post['ccholder']=$post['ccholder_lname'];
}
$fullname=$post['ccholder'].".".$post['ccholder_lname'];	

$payIP=$_SESSION['bill_ip'];
$cardCountry=$country_two;

$_SESSION['product'] = str_ireplace(array(':','?','/','%','|'),'',$_SESSION['product']);
$_SESSION['product'] = substr($_SESSION['product'], 0, 45);
$_SESSION['product'] = preg_replace("/[^A-Za-z0-9 ]/", '', strip_tags($_SESSION['product']));



$goods='{"goodsInfo":[{"goodsName":"'.$_SESSION['product'].'","goodsPrice":"'.$total_payment.'","quantity":"1"}]}';


$this_details="&CharacterSet=UTF8&merNo=".$merNO."&terNo=".$terNO."&orderNo=".$_SESSION['transID']."&currencyCode=".$orderCurrency."&amount=".$total_payment."&payIP=".$payIP."&transType=sales&transModel=M"; 
$hash_code=hash("sha256","EncryptionMode=SHA256".$this_details."&".$hash);



$payment_details="&cardCountry=".$cardCountry."&cardCity=".$post['bill_city']."&cardAddress=".$post['bill_address']."&cardZipCode=".$post['bill_zip'].
			 "&grCountry=".$cardCountry."&grCity=".$post['bill_city']."&grAddress=".$post['bill_address']."&grZipCode=".$post['bill_zip'].
			 "&grEmail=".$post['bill_email']."&grphoneNumber=".$post['bill_phone']."&grPerName=".$fullname."&goodsString=".$goods.
			 "&cardNO=".$post['ccno']."&expYear=".$post['year']."&expMonth=".$post['month']."&cvv=".$post['ccvv']."&cardFullName=".$fullname."&cardFullPhone=".$post['bill_phone']."&merMgrURL=".$merMgrURL."&segment1=".$post['ccno']."&cardState=".$post['bill_state']."&grState=".$post['bill_state']."";
$thispay_data="apiType=4&merremark=".$merMgrURL."&returnURL={$acquirer_wl_domain}/payin/pay27/returnurl{$data['ex']}?orderset=".$_SESSION['tr_orderset']."&action=notify&merNotifyURL={$acquirer_wl_domain}/payin/pay27/processed{$data['ex']}?orderset=".$orderset."&action=merNotifyURL&webInfo=Mozilla/5.0 (Windows NT 6.1; WOW64; rv:51.0) Gecko/20100101 Firefox/51.0&language=zh-CN".$payment_details.$this_details."&hashcode=".$hash_code."&";
$thispay_url=$bank_url;


$_SESSION['data_'.$acquirer]=$thispay_data;
parse_str($_SESSION['data_'.$acquirer], $data_2);
unset($data_2['cardNO']); unset($data_2['expYear']); unset($data_2['expMonth']); unset($data_2['cvv']);


$apiInfo['merNO']=$merNO;
$apiInfo['terNO']=$terNO;
$apiInfo['hash']=$hash;
$apiInfo['merMgrURL']=$merMgrURL;


$post_g['apiInfo']=$apiInfo;
//$post_g['host_'.$acquirer]=$data['Host'];
$post_g['transaction_id']=$_SESSION['transID'];
$post_g['currency']=$orderCurrency;	
$post_g['data_'.$acquirer]=$data_2;	
$post_g['sig_details_'.$acquirer]=$this_details;	
$post_g['orderset']=$orderset;	
$post_g['merNotifyURL']="{$acquirer_wl_domain}/payin/pay27/processed{$data['ex']}?orderset=".$orderset."&action=merNotifyURL";
$post_g['returnURL']="{$acquirer_wl_domain}/payin/pay27/returnurl{$data['ex']}?orderset=".$orderset."&action=returnURL";
$post_g['thispay_url']=$thispay_url;
//$post_g['b_br_failed']=$b_br_failed;
trans_updatesf($_SESSION['tr_newid'], $post_g);
		
	
	

if(isset($_GET['qp']))
{
	echo "<br/>orderCurrency=>".$orderCurrency;
	echo "<br/>this_details=>".$this_details;
	echo "<br/>hash=>".$hash;
	echo "<br/>thispay_url=>".$thispay_url;
	echo "<br/>payment_details=>".$payment_details;
	echo "<br/>thispay_data=>".$thispay_data;
	echo "<br/>data_2=>";print_r($data_2);
	exit;
} 
	
if(isset($_GET['e'])&&$_GET['e']==1){exit;}

$http_host="https://".$merMgrURL;

$curl_cookie="";
$curl = curl_init(); 
curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
curl_setopt($curl, CURLOPT_URL, $thispay_url);
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
curl_setopt($curl, CURLOPT_REFERER, $http_host);
curl_setopt($curl, CURLOPT_POST, 1);
curl_setopt($curl, CURLOPT_POSTFIELDS, $thispay_data);
curl_setopt($curl, CURLOPT_TIMEOUT, 300);
curl_setopt($curl, CURLOPT_HEADER, 0);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($curl, CURLOPT_COOKIE,$curl_cookie);
$responseInfo = curl_exec($curl);
//if (curl_errno($curl)) {print_r( curl_error($curl) );exit;}
curl_close($curl);

//process $response
$result_hkip = json_decode($responseInfo,true);	



if($result_hkip){
	$result_g=$result_hkip;
}else{
	$result_g=$responseInfo;
}


if(isset($result_hkip['skipTo3DURL'])&&!empty($result_hkip['skipTo3DURL'])){
	$tr_upd_order['pay_mode']='3D';
	$redirect_url=$result_hkip['skipTo3DURL'];
	
	$tr_upd_order['pay_url']=$redirect_url;
	
	$_SESSION['pay_url']=$redirect_url;
	
}else{
	$redirect_url="";
}

//txn_id mmm
$tr_upd_order['acquirer_ref']=$result_hkip['tradeNo'];
$tr_upd_order['q_order_'.$post['acquirer']]['g']=$result_g;		
$tr_upd_order['q_order_'.$post['acquirer']]['cr_dt']=date('Y-m-d H:i:s');

if(isset($result_hkip['acquirer'])&&$result_hkip['acquirer'])
	$tr_upd_order['descriptor']=$result_hkip['acquirer'];

trans_updatesf($_SESSION['tr_newid'], $tr_upd_order);

if(isset($_GET['qp'])){
	echo "<br/>result=>";
	print_r($result_hkip);
}
if(isset($_GET['e'])&&$_GET['e']==2){exit;}

$curl_values_arr['responseInfo']=$result_g;
$curl_values_arr['browserOsInfo']=$browserOs;
$curl_values_arr['apiInfo']=$apiInfo;

$_SESSION['acquirer_action']=1;
$_SESSION['acquirer_response']=$result_hkip['respMsg'];
$_SESSION['acquirer_status_code']=$result_hkip['order_status'];
$_SESSION['acquirer_transaction_id']=$result_hkip['tradeNo'];
$_SESSION['acquirer_descriptor']=$result_hkip['acquirer'];

$_SESSION['curl_values']=$curl_values_arr;

if(isset($redirect_url) && !empty($redirect_url))
{	
	$_SESSION['acquirer_status_code']=1;
	$process_url = $redirect_url; 
	
}elseif($result_hkip['respCode']=="00"){ //success
	$_SESSION['acquirer_status_code']=2;
	$status_completed=true;
	$process_url = $return_url; 
	//header("location:$process_url"); exit;
}elseif((($result_hkip['respCode']=="01"||$result_hkip['respMsg']=="Do not honour"||$result_hkip['respMsg']=="card type unsupported")&&($result_hkip['respMsg']!="Pending"))||(($b_br_failed)&&(strpos($b_br_failed,$result_hkip['respMsg'])!==false))){	//failed or other
	$status_completed=false;
	$_SESSION['acquirer_status_code']=-1;
	$process_url = $return_url; 
	//header("location:$process_url"); exit; 
}
else{ //pending
	$_SESSION['acquirer_status_code']=1;
	$process_url = $trans_processing;
}	
?>