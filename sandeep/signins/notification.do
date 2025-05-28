<?
#########################################################################
$data['PageName']='Notification';
$data['PageFile']='notification'; 
##########################################################################
include('../config.do');
$data['PageTitle'] = 'Notification - '.$data['domain_name']; 
###############################################################################


$data['store_url']=($data['MYWEBSITEURL']?$data['MYWEBSITEURL']:'store');
$data['store_id_nm']=(isset($store_url)?$store_url:'');
$data['store_name']=($data['MYWEBSITE']?$data['MYWEBSITE']:'Store');



if(!$_SESSION['adm_login']){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(!$_SESSION['adm_login']&&!$_SESSION['useful_link']){
  echo $data['OppsAdmin'];
  exit;
}

#########################################################################

//$data['payoutMissing']=get_trans_counts("AND (t.status NOT IN (0,9,10))  AND (t.payable_amt_of_txn IS NULL) ");

$data['replyTransactionQuery']=get_trans_reply_counts(0,1);

$data['openMessage']=get_support_tickets_count(0,0);

$data['processMessage']=get_support_tickets_count(1,0);

$data['approvedStore']=terminal_review_counts(0,' `active`=1 ');

$data['underReviewStore']=terminal_review_counts(0,' `active`=4 ');


	

display('admins');
#########################################################################
?>