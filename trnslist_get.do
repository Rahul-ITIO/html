<?
//this page will show transaction list like currency,trnsaction response,amount,description,status,bankName UPI etc.
$data['PageName']='TRANSACTIONS STATISTIC';
$data['HideLeftSide']=true;
$data['rootNoAssing']=1;


$data['NO_SALT']=true;
$data['SponsorDomain']=true;


###############################################################################
if(isset($_REQUEST['bid'])&&$_REQUEST['bid']>0){
	//$data['G_MID']=$_REQUEST['bid'];
}

include('config.do');
include($data['Path'].'/include/fontawasome_icon'.$data['iex']);

###############################################################################
//if user is not admin then he cant login access will be denied
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
        header("location:{$data['USER_FOLDER']}/login".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}
###############################################################################

$custom_settlement_optimizer_v3=0;

if(isset($_REQUEST['csov3']) && @$_REQUEST['csov3']==1){
	$custom_settlement_optimizer_v3=1;
	
}

//echo "<br/>custom_settlement_optimizer_v3=>".@$custom_settlement_optimizer_v3;

if(isset($post['action']) && $post['action']=='details'){
	if(isset($_SESSION['uid'])) $uid=$_SESSION['uid'];//if condition men then it checks if a session variable named "uid" is set
	if(isset($_SESSION['adm_login'])&&$_SESSION['adm_login']&&isset($_GET['uid'])){
		$uid=$_GET['uid'];//It then checks if another session variable named "adm_login" is set and has a truthy value, and if the GET request variable "uid" is set.
	}
    $post['TransactionDetails']=common_trans_detail($post['gid'], $uid, $custom_settlement_optimizer_v3);//`common_trans_detail` that fetches transaction details based on the provided `$id` and `$uid`
	//$post['md']=select_client_table($post['TransactionDetails']['merID']);
	
	//echo "<hr/>type=".$post['TransactionDetails']['typenum'];
	
	if($post['TransactionDetails']['merID']==$uid&&$post['TransactionDetails']['typenum']==2){
		$wmp=withdraw_max_prevf($uid,$post['gid'],$custom_settlement_optimizer_v3);//Fetch the last withdrawal detail of a merchant.
					
		$created_date_prev=date('Y-m-d',strtotime($wmp['tdate']));
		$created_date=date('Y-m-d',strtotime($wmp['c_tdate']));
		
		$post['wd_payout_date']="&pfdate={$created_date_prev}&ptdate={$created_date}";//for payout date
		
		//echo "<hr/>wd_payout_date=".$wd_payout_date;
		
	}
	
	$typenums=$post['TransactionDetails']['typenum'];
	
	/*
	$name5=(isset($data['t'][$typenums]['name5'])?$data['t'][$typenums]['name5']:'');
	//echo "<hr/>name5=> ".$name5;
	
	
	if(($name5)&&(strpos($name5,'AddressFalse')!==false)){ $address_con=0; }
	else{ $address_con=1; }
	if(($name5)&&(strpos($name5,'CardFalse')!==false)){ $card_con=0; }
	else{ $card_con=1; }
	//echo "<hr/>address_con=> ".$address_con; echo "<hr/>card_con=> ".$card_con;
	*/
	$card_con=1;
	$address_con=1;
	
	
	$rParam1['order_status']=$post['TransactionDetails']['ostatus'];
	$rParam1['status']=$data['TransactionStatus'][$post['TransactionDetails']['ostatus']];
	$rParam1['bill_amt']=$post['TransactionDetails']['oamount'];
	$rParam1['transID']=$post['TransactionDetails']['transID'];
	$rParam1['descriptor']=$post['TransactionDetails']['descriptor'];
	$rParam1['tdate']=date('Y-m-d H:i:s',strtotime($post['TransactionDetails']['tdate']));
	$rParam1['bill_currency']=$post['TransactionDetails']['curr_nam'];
	$rParam1['response']=$post['TransactionDetails']['trans_response'];
	$rParam1['reference']=$post['TransactionDetails']['reference'];
	
	$json_value1=jsonencode1($post['TransactionDetails']['json_value'],'',1);
	
	$json_value1=jsonreplace($json_value1);
	
	$json_value=json_decode($json_value1 ,1);

	

	$bankName		=(isset($json_value['bank_code_text'])?$json_value['bank_code_text']:'');
	$upi_vpa_lable	=(isset($json_value['upi_vpa_lable'])?$json_value['upi_vpa_lable']:'');
	$upi_vpa		=(isset($json_value['upi_vpa'])?$json_value['upi_vpa']:'');
	
	if(isset($json_value['post']['fullname'])&&$json_value['post']['fullname']){
		//$post['TransactionDetails']['fullname']=$json_value['post']['fullname'];
	}
	
	//print_r($rParam1);
	//$created_date=date("Ymd",strtotime("+1 day",strtotime($wmp['c_tdate'])));
	
}
$post['ViewMode']=$post['action'];
$is_admin=false;
if(isset($_SESSION['adm_login'])&&isset($_GET['admin'])&&isset($_GET['admin'])&&$_GET['admin']){
	$trans_href=$_SESSION['trans_href'];
	$is_admin=true;
	
	$trans_datah='onClick="data_href(this)"; '.$_SESSION['trans_datah'];
	$trans_target=$_SESSION['trans_target'];
	$trans_class=$_SESSION['trans_class'];
}else{
	$trans_href="transactions".$data['ex'];
	$trans_datah="";
	$trans_target="";
	$trans_class="";
}

if(isset($is_admin)&&$is_admin&&isset($uid)&&$uid){
	$data['frontUiName']="";
}
if(isset($_REQUEST['tempui'])&&$_REQUEST['tempui']){
	$data['frontUiName']=$_REQUEST['tempui'];
}
if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']){
	echo "<br/>is_admin=>".$is_admin;
	echo "<br/>uid=>".$uid;
	echo "<br/>frontUiName=>".$data['frontUiName'];
}
$full_address=[]; $full_address_arr=[];
if($post['TransactionDetails']['bill_address']&&$post['TransactionDetails']['bill_address']!='NA')
$full_address[]=$full_address_arr[]=$post['TransactionDetails']['bill_address'];
if($post['TransactionDetails']['bill_city']&&$post['TransactionDetails']['bill_city']!='NA')
$full_address[]=$full_address_arr[]=$post['TransactionDetails']['bill_city'];
if($post['TransactionDetails']['bill_state']&&$post['TransactionDetails']['bill_state']!='NA')
$full_address[]=$full_address_arr[]=$post['TransactionDetails']['bill_state'];
if($post['TransactionDetails']['bill_country']&&$post['TransactionDetails']['bill_country']!='NA')
$full_address[]=$post['TransactionDetails']['bill_country'];
if($post['TransactionDetails']['bill_zip']&&$post['TransactionDetails']['bill_zip']!='NA')
$full_address[]=$full_address_arr[]='-'.$post['TransactionDetails']['bill_zip'];

if($full_address_arr){
	$post['full_address']=implode(', ',$full_address);
	$post['full_address']=str_replace(['NA,','NA, ',', NA',',NA',', -'],['','','','',' - '],$post['full_address']);
}else $post['full_address']='';


$post['address_con']=$address_con;
$post['card_con']=$card_con;
$post['is_admin']=$is_admin;
$post['rParam1']=$rParam1;
$post['json_value']=$json_value;
$post['json_value1']=$json_value1;
$post['bankName']=$bankName;
$post['upi_vpa_lable']=$upi_vpa_lable;
$post['upi_vpa']=$upi_vpa;

$post['trans_href']=$trans_href;
$post['trans_datah']=$trans_datah;
$post['trans_target']=$trans_target;
$post['trans_class']=$trans_class;


showpage("common/template.trnslist_get".$data['iex']);exit;

?>
