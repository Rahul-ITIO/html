<?
/*
$data['PageName']='SUCCESS';
$data['PageFile']='success';
*/
$data['PageName']='RETURN URL';
$data['PageFile']='return_url';

// Dev Tech : 23-01-21 modify for if merchant url not found for success
// Dev Tech : 23-02-14 modify for return_url.do for success or failed pages 
 
//if(isset($_SERVER['HTTP_REFERER'])&&trim($_SERVER['HTTP_REFERER'])&&isset($_POST['redirect_status'])&&(strpos($_SERVER['HTTP_REFERER'],'/fetch_trnsStatus')!==false) )
	
//error_reporting(0); // reports all errors
if(!isset($_SESSION)) {session_start();}

if( isset($_SESSION['redirect_status']) &&  isset($_POST['redirect_status']) && (trim($_POST['redirect_status'])) )
{ 
	$_POST=$_SESSION['redirect_status'];
	$data['HideAllMenu']=true;
	if(isset($_POST['checkout_theme'])&&trim($_POST['checkout_theme'])){
		$checkout_theme=$_POST['checkout_theme'];
		$merID_tr=$_POST['merID'];
		$data['SponsorDomain']=1;
		unset($_POST['checkout_theme']);
	}
	elseif(isset($_POST['merID'])&&trim($_POST['merID'])){
		$data['G_MID']=$_POST['merID'];
	}
	if(isset($_POST['merID'])&&trim($_POST['merID'])){
		unset($_POST['merID']);
	}
	if(isset($_POST['redirect_status'])&&trim($_POST['redirect_status'])){
		unset($_POST['redirect_status']);
	}
	
	include('config.do');
	
	// if available in Checkout Theme assing from website 
	if(isset($merID_tr)&&trim($merID_tr)&&trim($checkout_theme)){
		$g_sid=0;$g_mid=(int)$merID_tr;
		$domain_server=sponsor_themefc($g_sid,$g_mid,$checkout_theme); //fetch sponsor theme
	}

	
	if(isset($_POST)){
		$data['getresponse']=$_POST;
		$data['return_response_arr']=$_POST;
	}
	
	if(isset($_REQUEST['dtest']))
	{
		echo "<br/><br/>_POST=><br/>".$_SERVER['HTTP_REFERER'];
		echo "<br/><br/>getresponse=><br/>";
		print_r($data['getresponse']);
	}
	
}
else {
	include('transCallbacks2.do');
}
//$data['HideMenu']=true;
$data['NO_SALT']=true;
$data['PageTitle']='Processing...'; 

if(isset($data['getresponse']['bill_amt'])&&trim($data['getresponse']['bill_amt'])) $data['getresponse']['amt']=$data['getresponse']['bill_amt'];

//Success 
if(isset($data['getresponse']['order_status'])&&$data['getresponse']['order_status']==1){
	if(!isset($data['header_msg'])||!$data['header_msg']){
		$data['header_msg'] = "<div class=separator></div><br><h3><i></i> Payment Successful</h3><div class=separator></div>";
	}
	if(!isset($data['footer_msg'])||$data['footer_msg']){
		$data['footer_msg'] = "<p>Thank you. Your payment has been successfully received.</p><br/><br/><br/><br/>";
	}
}


//Failed 
elseif(isset($data['getresponse']['order_status'])&&$data['getresponse']['order_status']>1){		
	//$data['PageFile']='failed';
	if(!isset($data['header_msg'])||!$data['header_msg']){
		$data['header_msg']="<h3><i></i> Payment Failed</h3>";
	}
	if(!isset($data['msg_fail'])||!$data['msg_fail']){
		$data['msg_fail']="Sorry, your payment issuer declined the transaction.";
	}
	if(!isset($data['footer_msg'])||!$data['footer_msg']){
		$data['footer_msg']="Please call the number on the back of your payment for more info about the transaction failure, or try using another payment.";
	}

}

if(isset($_SESSION['SA']['retrycount'])&&$_SESSION['SA']['retrycount']<1)
unset($_SESSION['SA']['retrycount']);

if(isset($_GET['pr4'])&&$_GET['pr4']==4){
	echo "<br/><br/>getresponse=><br/>"; print_r($data['getresponse']);	
}
	
display('user');
?>



