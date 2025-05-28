<?
//this file will be used for processing after trnasaction for final response from bank
$data['PageName']='TRANSACTION PROCESSING';
$data['PageFile']='trans_processing';
//$data['notRootCss']=true;
include('transCallbacks.do');


//Dev Tech: 24-02-06 for disconnect the db 
db_disconnect();	

//session_start();
$data['PageTitle']='Processing...'; 


if(!isset($_SESSION["s30_count"]) && empty($_SESSION["s30_count"])){
	if(isset($data["s30_count"])&&$data["s30_count"]){
		$_SESSION["s30_count"] = (int)$data["s30_count"];
		
	}else{

		$_SESSION["s30_count"] = 10;//to check transaction status 10 times if pending 
	}
}else{	
	$s30_count = $_SESSION["s30_count"];
	$s30_count--;
	$_SESSION["s30_count"]= $s30_count;
}
//echo $_SESSION["s30_count"];

if(!isset($data['header_msg'])||!$data['header_msg']){
	$data['header_msg'] = "<div class=separator></div><br/> <h2 style='font-size:28px;'><i></i> Transaction is in process......</h2> <h3 style='font-size:22px;'><i></i>We are waiting for final result from the bank</h3><div class=separator></div>";
}
if(!isset($data['footer_msg'])||!$data['footer_msg']){
	$data['footer_msg'] = "<p>Slow connectivity while establishing a connection with bank server. </p><br/><p>The transaction status will notify via email soon. </p><br/><p>Do not attempt a new transaction for next four hours.  </p><br/><br/>";
}
display('user');

if((!isset($_SESSION['SA']['intent_acitve']))&&(isset($_SESSION['SA']['intent_paymentUrl']))&&($_SESSION['SA']['intent_paymentUrl'])){
	$_SESSION['SA']['intent_acitve']=1;
	$intent_paymentUrl=$_SESSION['SA']['intent_paymentUrl'];
	//echo "<br/>intent_paymentUrl2=>".$_SESSION['SA']['intent_paymentUrl'];
	header("Location:$intent_paymentUrl");
	//exit;
}

/*
if((isset($_SESSION['SA']['intent_paymentUrl']))&&($_SESSION['SA']['intent_paymentUrl'])){
	$_SESSION['SA']['intent_acitve']=1;
	$intent_paymentUrl=$_SESSION['SA']['intent_paymentUrl'];
	echo "<br/>intent_paymentUrl2=>".$_SESSION['SA']['intent_paymentUrl'];
	header("Location:".$intent_paymentUrl);exit;
}
*/
?>




