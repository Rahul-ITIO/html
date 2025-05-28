<?
$data['PageName']='FAILED';
$data['PageFile']='failed';
include('callbacks.do');
$data['PageTitle']='Processing...'; 

if(!isset($data['hder_fail'])||!$data['hder_fail']){
	$data['hder_fail']="<h3><i></i> Payment Failed</h3>";
}
if(!isset($data['msg_fail'])||!$data['msg_fail']){
	$data['msg_fail']="Sorry, your card issuer declined the transaction.";
}
if(!isset($data['ftr_fail'])||!$data['ftr_fail']){
	$data['ftr_fail']="Please call the number on the back of your card for more info about the transaction failure, or try using another card.";
}
		
display('user');
?>

