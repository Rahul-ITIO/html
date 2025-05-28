<?

###############################################################################
$data['PageName']='ANALYTIC';
$data['PageFile']='analytic';
//$data['graph']=true;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Analytic Graph - '.$data['domain_name'];
###############################################################################
if(!isset($_SESSION['adm_login'])){
	header("Location:{$data['Admins']}/login".$data['iex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################

if(isset($_SESSION['sub_admin_rolesname'])&&$_SESSION['sub_admin_rolesname']=="Associate"){
	echo "Oops... Something went worng. <a href='index.do'> Click here to GO to Home.</a>";
	exit;
}

if(isset($_REQUEST['action'])&&$_REQUEST['action']=='getaccountid'){
	//echo "<br/>mid=>".$_REQUEST['mid'];
	$post['TerminalId']=getTerminalidf($_REQUEST['mid'],3);
	echo showselect($post['TerminalId'], $post['storeid']);
	exit;
}

//http://localhost/fujitsuwin10/mlogin/graph2.do?q=1&action=getacquirerid&wid=1122,1118,1501,1502
if(isset($_REQUEST['action'])&&$_REQUEST['action']=='getacquirerid'){
	//echo "<br/>wid1=>".$_REQUEST['wid'];
	$post['acquirerids']=getacquireridsf($_REQUEST['wid'],1);
	echo showselect($post['acquirerids'], $post['acquirer_type']);
	exit;
}



if(!isset($post['action'])||!$post['action'])$post['action']='select';
if(!isset($post['type']))$post['type']=-1;
if(!isset($post['status']))$post['status']=-1;
if($post['type']>=0){
	//$data['PageName'].=
		" [".strtoupper($data['t'][$post['type']]['name2'])."]";
}
###############################################################################
$trans_details = array();
$date_transaction = array();
$transaction_amount = array();


$post['sub_admin']=sub_admin_details(2);
/*
echo "<br/><br/>merchant_detail post=>";
print_r(@$post['sub_admin']);
*/

$post['merchant_detail']=merchant_details(2);



/*
echo "<br/><br/>merchant_detail post=>";
print_r(@$post['merchant_detail']);

echo "<br/><br/>merchant_details 1=>";
print_r(@$_REQUEST['merchant_details']);

echo "<br/><br/>merchant_details 2=>";
print_r(@$_SESSION['merchant_details']);

*/

if(isset($_REQUEST['merchant_details'])&&$_REQUEST['merchant_details']){
	$merchant_req=$_REQUEST['merchant_details'];
	$merchant_req_count=count($merchant_req);
	if($merchant_req_count==1){
		$memb=select_tablef("`id`='{$merchant_req[0]}'",'clientid_table',0,1,"`default_currency`");
		$post['default_currency']=$memb['default_currency'];
	}
}

	/*
		$post['merchant_detail1']=[];
		sort($post['merchant_detail']);
		foreach ($post['merchant_detail'] as $key=>$value) { 
			if(!empty($value['username'])){
				$post['merchant_detail1'][$value['id']]="[{$value['id']}] {$value['username']} | {$value['fname']} {$value['lname']}";
			}
		}
	*/
	//print_r($post['merchant_detail1']);



//if(isset($_REQUEST['sortingType'])&&$_REQUEST['sortingType'])
if(isset($_REQUEST['SEARCH'])&&$_REQUEST['SEARCH'])
{
	
	$subAdminId='';
	
	if(isset($_REQUEST['sub_admin'])&&@$_REQUEST['sub_admin']){
		$subAdminId=implodef($_REQUEST['sub_admin']);
		//echo "subAdminId=> "; print_r($subAdminId);
	}
	
	//echo "_REQUEST=> "; print_r($_REQUEST);
	
	// for group for tdate wise 
	$trans_details=get_trans_graph($_REQUEST,1,$subAdminId); // grfType=1 for group by `tdate`
	$post['count_result']=count($trans_details);
   //print_r($trans_details);
	$post['total_amount']=0;
	$post['ids']=0;

	for($i=0;$i<count($trans_details);$i++){
		//$date_transaction[$i]	= date("Y-m-d", strtotime($trans_details[$i]['tdates']));
		$date_transaction[$i]	= $trans_details[$i]['tdates'];
		$transaction_amount[$i]	= (double)$trans_details[$i]['amounts'];
		$post['total_amount']	= $post['total_amount']+(double)$trans_details[$i]['amounts'];
		$post['ids']=$post['ids']+$trans_details[$i]['ids'];
	}
	// print_r($date_transaction);
	$post['date_transaction']=$date_transaction;
	$post['transaction_amount']=$transaction_amount;

	//fetch values Client wise as above query
	//$trans_details1=create_graphQ($_REQUEST);
	$trans_details1=get_trans_graph($_REQUEST,2,$subAdminId); // grfType=2 for group by `merID`
	
	if(isset($data['clientid_count'])&&@$data['clientid_count'])
		$post1['count_result']=$data['clientid_count'];
	else 
		$post1['count_result']=count($trans_details1);
	
	//print_r($trans_details1);
	$post1['total_amount']=0;
	$post1['ids']=0;

	for($i=0;$i<count($trans_details1);$i++){
		$merID_arr[$i]		= $trans_details1[$i]['merID_ct'];
		$transaction_amount1[$i]= (double)$trans_details1[$i]['amounts'];
		$post1['total_amount']	= $post1['total_amount']+(double)$trans_details1[$i]['amounts'];
		$post1['ids']=$post1['ids']+$trans_details1[$i]['ids'];
	}
	$post1['merID_arr']=@$merID_arr;
	$post1['transaction_amount']=@$transaction_amount1;
	

	//fetch values Business wise as above query
	//$trans_details2=create_graphStore($_REQUEST);
	$trans_details2=get_trans_graph($_REQUEST,3,$subAdminId); //grfType=3 for group by `terNO`
	$post2['count_result']=count($trans_details2);
	//print_r($trans_details2);

	$post2['total_amount']=0;
	$post2['ids']=0;

	for($i=0;$i<count($trans_details2);$i++){
		$terNO_id_arr[$i]		= $trans_details2[$i]['terNO_ct'];
		$transaction_amount2[$i]= (double)$trans_details2[$i]['amounts'];
		$post2['total_amount']	= $post2['total_amount']+(double)$trans_details2[$i]['amounts'];
		$post2['ids']=$post2['ids']+$trans_details2[$i]['ids'];
	}
	$post2['terNO_id_arr']=@$terNO_id_arr;
	$post2['transaction_amount']=@$transaction_amount2;
	
//	print_r($post2);exit;
}
	
$post['ViewMode']=$post['action'];
###############################################################################
//$data['SystemBalance']=select_balance(-1);
###############################################################################
display('admins');
###############################################################################
?>