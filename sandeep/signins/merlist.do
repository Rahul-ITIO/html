<?
//cmn1
if(isset($_POST['registered_email'])){		//if registered_email received by post then store into $data
	$email_val=$_POST['registered_email'];
	$data['email_val']=$email_val;
}

//start page load time
$data['msc_start'] = microtime(true);
$qp=0;
if(isset($_GET['t'])&&$_GET['t']==2){ $qp=1; } 
if($qp){
	$msc01 = microtime(true)-$data['msc_start'];
	echo("<br/>-->1 Start Query took ".($msc01 * 1000)." ms<--<hr/>");
}
	
$data['PageName']	='MERCHANT INFORMATION OVERVIEW';	//define page name or h1 title of a page
$data['PageFile']	='merlist';					//define template name
$data['PageFile2']	='clients_test';					//define second template name

###############################################################################
include('../config.do');


//if($_GET)get_request1();
$data['PageTitle'] = 'Merchant Information Overview - '.$data['domain_name'];	//define page title name

###############################################################################

$store_url	= ($data['MYWEBSITEURL']?$data['MYWEBSITEURL']:'store');	//setup store url
$store_id_nm= $store_url;
$store_name	= ($data['MYWEBSITE']?$data['MYWEBSITE']:'Store');			//setup store name


$clients_active_type=((isset($_SESSION['MemberInfo']['active'])&&trim($_SESSION['MemberInfo']['active']))?$_SESSION['MemberInfo']['active']:'');	//fetch membrer type is active or not
$data['mtype'] = ((isset($clients_active_type)&&trim($clients_active_type))?$data['MEMBER_TYPE'][$clients_active_type]:'');	//store clients type into $data to further use

//if(isset($post['action'])&&$post['action']=='select'||$post['action']=='detail'){ }else{ get_midf($_GET['id']); }

//update Account Processing ode i.e. acquirer_processing_mode 

//print_r($data['smDb']['salt_id']);

//function for setup ProcessingMode like
function ProcessingMode($uid,$code){

	global $data;
	$qry = $field = '';
	if (isset($_GET['ac'])){ $ac=$_GET['ac'];}
	if ($code==301){$code=1;$field="`acquirer_processing_mode`";}
	elseif ($code==302){$code=2;$field="`acquirer_processing_mode`";}
	elseif ($code==303){$code=3;$field="`acquirer_processing_mode`";}
	//elseif ($code==304){$code=0;$field="`setup_fee_status`";}
	//elseif ($code==305){$code=1;$field="`setup_fee_status`";}
	//elseif ($code==306){$code=1;$field="`edit_permission`";}
	//elseif ($code==307){$code=2;$field="`edit_permission`";}

	if(isset($_REQUEST['bid'])&&trim($_REQUEST['bid'])&&!empty($field))
	{
		//update mer_setting query as on process mode
		$qry = "UPDATE `{$data['DbPrefix']}mer_setting`"." SET {$field}='$code' ";
		$qry.= " WHERE `id`='{$_REQUEST['bid']}'";
		$check=db_query($qry,0);
	}
	//exit;
	//update json log
	json_log_upd($_GET['bid'],'mer_setting','Processing Mode');
	
	//close modal window and redirect to respsective tab on same page
	echo"<script>
		var topurl = top.window.location.href.split('#')[0];
		topurl = topurl.split('&tab_name=')[0];
		top.window.location.href=topurl+'&tab_name=collapsible6#ac{$ac}';
	</script>";
}// end function

//functioin for change / update user permission
function EditPermission($uid,$code){
	global $data;
	$qry = $field = '';
	if (isset($_GET['ac'])){ $ac=$_GET['ac'];}
	if ($code==320){$code=2;$field="`user_permission`";}
	elseif ($code==321){$code=1;$field="`user_permission`";}

	if(!empty($field))
	{
		//update clients permission
		$qry = "UPDATE `{$data['DbPrefix']}clientid_table`"." SET {$field}='$code' WHERE `id`='{$uid}'";
		$check=db_query($qry);
	}
}// end function

//function for fetch selected salt list
function showselectlist($fieldid='',$listAll=''){
	global $data;
	$result=array();	
	$fdata='';
	$fdata=option_smf($data['smDb']['d'],$fieldid,"aid");
	/*
	if($listAll){
		$wheredata="1";
	}else{
		$wheredata=" FIND_IN_SET($fieldid,tid) AND `salt_status`=1 ";
	}
	
		
	$result=db_rows($ss="SELECT * FROM `{$data['DbPrefix']}salt_management` WHERE $wheredata");
	foreach($result as $key=>$value) {
		$fdata.="<option value='{$value['id']}'>{$value['id']} | {$value['salt_name']} | {$value['bank_json']}</option>";
	}
		
	*/
	return $fdata;
}

//return lastest desccription
function get_latest_description_data($text){
	global $data;
	//$start_count=strpos($text, 'desc_msg')+40;
	$end_count=strpos($text, '.</div>');
	return substr($text,0,$end_count);
}

//if action is get_salt_list the show list and exit
if(isset($_REQUEST['action'])&&$_REQUEST['action']=='get_salt_list'){
	$sltid=$_REQUEST['sltid'];
	echo showselectlist($sltid);exit;
}

###############################################################################

//check login with admin or not, if not login with admin then re-direct to login page
if(!isset($_SESSION['adm_login'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(isset($post['gid'])&&$post['gid']) //If we have merchant edit/view page - assign _SESSION['MemberInfo']
{
	$post['MemberInfo']		=get_clients_info($post['gid']);
	$_SESSION['MemberInfo']	=$post['MemberInfo'];
}
//check connect name, if clk then use IFSC as bank code else use SWIFT as bank code
if(isset($data['con_name'])&&$data['con_name']=='clk'){
	$post['swift_con']='IFSC';
	$ovalidation=false;
}else{
	$post['swift_con']='SWIFT';
	$ovalidation=true;
}

$post['ovalidation']=$ovalidation;	//setup validation type

//if action is transcout then fetch the total amount of success trans and number of success transactions
if(isset($post['action'])&&$post['action']=='transcount'){
	$psold=select_sold($_REQUEST['mid'],$_REQUEST['id']);
	$post1['solds']	=$psold['sold'];
	$post1['counts']=$psold['count'];
	$post['asold']="<a href='{$data['Admins']}/transactions{$data['ex']}?keyname=115&searchkey={$_REQUEST['id']}' target='_blank' >{$post1['counts']} Times<br/><font class=remark>({$post1['solds']})</font></a>";
	echo($post['asold']);
	exit;
}

//function for set pricing templates
function templatesf($pst){

	global $data; $qp=0;
	if(isset($_GET['qp'])&&$_GET['qp']){
		$qp=1;
	}

	//select data from pricing_template table
	$pt_slc=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}acquirer_group_template`".
		" WHERE `id`='".$pst['tid']."' LIMIT 1",0
	);
	
	$tid_get=$pt_slc[0]['tid'];	//fetch tid (mid / account)
	$tid=explode(",",$tid_get);	//explode account via comma (,)
	if($qp){
		echo $tid_get;
	}
	//define array
	$pre_created	=array(); 
	$pre_created_nm	=array();
	$new_created	=array();
	$new_created_nm	=array(); 
	$un_created		=array(); 
	$un_created_nm	=array();
	
	//mer_setting
	
	foreach($tid as $valuet){
		//fetch data from mer_setting table for all mer_setting
		$account_count=db_rows(
			"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}mer_setting`".
			" WHERE `acquirer_id` IN ({$valuet}) AND `merID`='".$pst['mid']."'".
			" LIMIT 1",0
		);
		$account_count=$account_count[0]['count'];
		if($account_count>0){
			$pre_created[]=$valuet;
			$pre_created_nm[]=$data['acquirer_name'][$valuet];
			
			//$dat['Error']="All ready assign of ".$valuet; echo $dat['Error']."<br/>";
			//json_print($dat);exit;
		}else{
			// for new create account
			$post['acq_1']=array();
			$ac['merID']=$pst['mid'];
			$ac['sponsor']=$pst['spo'];
			$ac['acquirer_id']=$valuet;
			//$ac['acquirer_name']=$data['acquirer_name'][$valuet];
			$ac['acquirer_name']=$valuet;
			
			$ac['acquirer_processing_mode']=$pst['transaction_processing_mode'];	//transaction processing mode

			//fetch data from bank_gateway
			$bgt_slc=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}acquirer_table`".
				" WHERE `acquirer_id`={$valuet} LIMIT 1",0
			);
			$post['acq_1']=jsondecode($bgt_slc[0]['mer_setting_json']); // fetch json values from acquirer
			$aLj=jsondecode($bgt_slc[0]['acquirer_label_json']); // fetch json values from acquirer_label_json
			
			//print_r($post['acq_1']);
			
			if($post['acq_1']){
				$new_created[]=$valuet;
				$new_created_nm[]=$data['acquirer_name'][$valuet];
				
				
				
				if(is_array($post['acq_1']) && is_array($ac)) {
					$post['acq_1']['acquirer_processing_json']=jsonencode($post['acq_1']['acquirer_processing_json']);
					$post['acq']=array_merge($post['acq_1'],$ac); //if both array exits acq1 and ac then merge
				}
				
				$post['acq']['checkout_label_web']=$aLj['checkout_label_web'];
				$post['acq']['checkout_label_mobile']=$aLj['checkout_label_mobile'];
				$post['acq']['virtual_fee']='0.00';
				$post['acq']['salt_id']='';
				$post['acq']['moto_status']='';
				$post['acq']['mdr_visa_rate']='';
				$post['acq']['mdr_mc_rate']='';
				$post['acq']['mdr_jcb_rate']='';
				$post['acq']['mdr_amex_rate']='';
				$post['acq']['mdr_range_rate']='';
				$post['acq']['mdr_range_type']='';
				$post['acq']['mdr_range_amount']='';
				
				//transaction rates
				if(isset($post['acq']['mdr_rate'])&&$post['acq']['mdr_rate']){
					$post['acq']['mdr_rate']=(double)$post['acq']['mdr_rate']+(double)$pst['baseRate_mdr_rate'];
				}
				
				//transaction fee
				if(isset($post['acq']['txn_fee_success'])&&$post['acq']['txn_fee_success']){
					$post['acq']['txn_fee_success']=(double)$post['acq']['txn_fee_success']+(double)$pst['baseRate_txn_fee'];
				}
				$post['acq']['assignee_type']="1";
				
				create_mer_setting($post['acq'], $ac['merID']);
					
			}else{
				$un_created[]=$valuet;
				$un_created_nm[]=$data['acquirer_name'][$valuet];
			}
		}
	}
	
	
	//store data to $dat[] arary to returned from function
	$pre_created=implode(",",$pre_created);
	$dat['pre_created']=$pre_created;
	$pre_created_nm=implode(",",$pre_created_nm);
	$dat['pre_created_nm']=$pre_created_nm;
	
	$new_created=implode(",",$new_created);
	$dat['new_created']=$new_created;
	$new_created_nm=implode(",",$new_created_nm);
	$dat['new_created_nm']=$new_created_nm;
	
	$un_created=implode(",",$un_created);
	$dat['un_created']=$un_created;
	$un_created_nm=implode(",",$un_created_nm);
	$dat['un_created_nm']=$un_created_nm;
	
	if($qp){
		//$dat['Error']="gid:".$pst['gid'].",mid:".$pst['mid'].",tid:".$pst['tid'].",spo:".$pst['spo']; json_print($dat);exit;
	}
	
	/*
	$data_send['add_template']=$pst['tid'];
	$acquirer_url=$data['Admins']."/{$data['my_project']}{$data['ex']}?id={$pst['mid']}&action=insert_mer_setting&add_template=".$pst['tid'];
	$dat['url']=$acquirer_url;
	*/
	
	//fetch log data from terminal
	$pro_slc=db_rows(
		"SELECT `select_templates_log`,`acquirerIDs` FROM `{$data['DbPrefix']}terminal`".
		" WHERE `id`={$pst['gid']} LIMIT 1",0
	);
	$pLog=$pro_slc[0]['select_templates_log'];
	
	$acquirerIDs=$pro_slc[0]['acquirerIDs'].",".$dat['new_created'];
	$acquirerIDs=implode(',',array_unique(explode(',', $acquirerIDs)));
	
	
	$dat['add_template']=$pst['tid'];
	//$dat['total_acquirerIDs']=$acquirerIDs;
	$msg['msg']=jsonencode($dat);
	
	if(isset($_SESSION['sub_admin_id'])){
		$admin_id=$_SESSION['sub_admin_id'];
	}else{
		$admin_id='Admin';
	}
	

	$cLog['tm_user']=$admin_id;
	$cLog['tm_date']=date('Y-m-d H:i:s A');
	$cLog['tm_log']=$dat;
	$t_log=json_log($pLog,$cLog);
	//$t_log=jsonencode($cLog);
	if($qp){
		echo $t_log; 
	}
	
	db_query("UPDATE `{$data['DbPrefix']}terminal`".
	" SET `acquirerIDs`='{$acquirerIDs}', `select_templates`='".$pst['tid']."', `select_templates_log`='{$t_log}' ".
	" WHERE `id`='".$pst['gid']."'",0);
	
	
//	print json values and exit
	json_print($msg['msg']);exit;
	//$curlPost=use_curl($acquirer_url,$data_send);
}
		
###############################################################################
if(!isset($post['action'])||!$post['action']) $post['action']='select';


###############################################################################

if((isset($_GET['type'])) && $_GET['type']=="profile_status" && (isset($_GET['scode'])) && (!empty($_GET['scode']))){
	$id=$_GET['id'];
	$scode=$_GET['scode'];
	$_POST['edit_permission']=$_GET['scode'];
	
	$get_clientid_details_tbl=select_table_details($id,'clientid_table',0);
	$profile_json=jsondecode($get_clientid_details_tbl['json_value']);
	
	$json_value=keym_f($_POST,$profile_json);
	$json_value=jsonencode($json_value);

	db_query("UPDATE `{$data['DbPrefix']}clientid_table` set `edit_permission`='$scode',`json_value` = '$json_value' WHERE `id`='$id'",0);
	
	if($_GET['scode']==1){ $status="Approved"; }else{ $status="Un Approved"; }
	$_SESSION['MemberInfo']['edit_permission']=$scode;
	json_log_upd($id,'clientid_table','Profile Status'); // for json log history
	$post['action']='detail';$_SESSION['action_success_merchant']="Profile Status $status Successfully";
}

if ((isset($_GET['code'])) && (!empty($_GET['code']))){
	$code=$_GET['code'];
	$ajax=false;
	if ($code==1){codereset($post['gid'],'clientid_table',$ajax); $_SESSION['action_success_merchant']="Two Way Authentication Activated"; }
	if ($code==2){codedisable($post['gid'],'clientid_table'); $_SESSION['action_success_merchant']="Two Way Authentication Deactivated"; }
	//if (($code==301)||($code==302)||($code==303)||($code==304)||($code==305)||($code==306)||($code==307)){ProcessingMode($post['gid'],$code);}
	if (($code>=301)&& ($code<=307)){ProcessingMode($post['gid'],$code);}
	if (($code==321)||($code==320)){EditPermission($post['gid'],$code);}
}

if(isset($post['action'])&&($post['action']=='activate')){
	set_clients_status($post['gid'],$post['action']=='activate'?true:false);		//activate merchant
	$post['action']='select';
	header("location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=detail&id=".$post['gid']);exit;
}elseif(isset($post['action'])&&($post['action']=='remove_payout_key')){
	$sqlStmt = "UPDATE `{$data['DbPrefix']}clientid_table` SET `payout_secret_key`='' WHERE `id`='{$post['gid']}'";		//unset or remove payout key
	db_query($sqlStmt);
	$_SESSION['action_success']='Payout Secret Key Removed Successfully!';

//	exit;
	header("location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=update&type=active&id=".$post['gid']);exit;
}elseif(isset($post['action'])&&($post['action']=='activate')){
	set_clients_status($post['gid'],$post['action']=='activate'?true:false);
	$post['action']='select';
	header("location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=detail&id=".$post['gid']);exit;
}elseif(isset($post['action'])&&$post['action']=='templates_add'){
	
	$pst['gid']=$_REQUEST['gid'];
	$pst['mid']=$_REQUEST['mid'];
	$pst['tid']=$_REQUEST['tid'];
	$pst['spo']=$_REQUEST['spo'];
	
	$pst['baseRate_mdr_rate']=$_REQUEST['baseRate_mdr_rate'];
	$pst['baseRate_txn_fee']=$_REQUEST['baseRate_txn_fee'];
	$pst['transaction_processing_mode']=$_REQUEST['transaction_processing_mode'];
	
	//print_r($pst);
	
	templatesf($pst);
	
	exit;
	
	$post['action']='select';
	header("location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=detail&id=".$post['mid']);exit;
}elseif(isset($post['action'])&&($post['action']=='approved'||$post['action']=='unapproved')){
	set_clients_approve($post['gid'],$post['action']=='approved'?1:2);	//unapproved merchant
	$post['action']='select';
	header("location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=detail&id=".$post['gid']);exit;
}elseif(isset($post['action'])&&$post['action']=='terminate'){	//terminate merchant
	set_clients_status($post['gid'],$post['action']=='activate'?true:false);
	$post['action']='select';
	header("location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=detail&id=".$post['gid']);exit;
}elseif(isset($post['action'])&&$post['action']=='delete'){
	if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	delete_clients($post['gid']);	//delete clients records
	$post['action']='select';
}elseif(isset($post['action'])&&$post['action']=='blockIp'){
	set_ip_block_clients($_GET['block_id'],$_GET['ip_status']);	//blocked IP
	$post['action']='select';
	$post['type']='active';
	
	header("location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=detail&id=".$_GET['block_id']);exit;
	//header("location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=select&type=closed");exit;

}elseif(isset($post['action'])&&$post['action']=='block'){
	block_clients($post['gid']);		//block clients
	$post['action']='select';
	header("location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=detail&id=".$post['gid']);exit;
}elseif(isset($post['action'])&&$post['action']=='delemail'){
	//if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	delete_email_info($post['gid'],$post['bid']);	//delete an email
	$post['action']='detail';
}elseif(isset($post['action'])&&$post['action']=='setdefault'){
	$registered_email='';
	if(isset($post['registered_email'])&&$post['registered_email'])
		$registered_email=$post['registered_email'];
	if(isset($post['email'])&&$post['email'])
		$registered_email=$post['email'];
	
	$return_action = make_email_prim($post['gid'],$registered_email, $post['bid']);	//set default registered_email
	json_log_upd($post['bid'],'clientid_emails');
	//$_SESSION['action_success']=$return_action;
	$post['action']='detail';
}elseif(isset($post['action'])&&$post['action']=='sendemail'){
	send_email_request($post['gid'],$post['email'], $post['bid']);	//send email
	$post['action']='detail';
	$_SESSION['action_success_merchant']="Email Approve Successfully";
}elseif(isset($post['action'])&&$post['action']=='send_kyc'){
	$post['merID']=$_GET['bid'];
	$post['current_date']=date('Y-m-d');
	$post['fullname']=$_GET['fullname'];
	$post['email']=$_GET['email'];

	//update kyc
	db_query(
		"UPDATE `{$data['DbPrefix']}verification_table` SET ".
		"`post_status`='send_kyc' ".
		" WHERE `id`='".$_GET['lid']."'",0
	);
	
	send_email("SEND-KYC(IDENTITY-VERIFICATION-REQUEST)", $post);	//send kyc email
	$post['action']='detail';
	exit;
}elseif(isset($post['action'])&&$post['action']=='delete_card'){
	//if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	delete_card($post['bid']);	//delete info from cards table
	$post['action']='detail';
	$_SESSION['action_success_merchant']="Card Delete Successfully";
}elseif(isset($post['action'])&&$post['action']=='delete_bank'){
	//if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	delete_bank($post['bid']);	//delete bank
	$post['action']='detail';
	//$_SESSION['action_success_merchant']="Bank Account Delete Successfully";
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&id=".$post['gid']."#collapsible7");exit;
}elseif(isset($post['action'])&&$post['action']=='delete_crpto'){
	//if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	delete_crpto($post['bid']);	//delete crypto account
	$post['action']='detail';
	//$_SESSION['action_success_merchant']="Crypto Wallet Delete Successfully";
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&id=".$post['gid']."#collapsible7");exit;
}elseif(isset($post['action'])&&$post['action']=='delete_mer_setting'){
	//if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	delete_mer_setting($post['bid']);	//delete account
	$post['action']='detail';
	$_SESSION['action_success_merchant']="Acquirer / Gateway Partner Delete Successfully";
	$id=($post['gid']?$post['gid']:$_GET['id']);
	if($id>0)header("location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible6&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible6");exit;
}elseif(isset($post['action'])&&$post['action']=='delete_terminals'){
	//if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	delete_terminal($post['bid']);	//delete terminal
	//$id=($_REQUEST['id']?$_REQUEST['id']:0);
	$id=($post['gid']?$post['gid']:$_GET['id']);
	$_SESSION['action_success_merchant']="Terminal Delete Successfully";
	if($id>0)header("location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible3&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible3");exit;
	$post['action']='detail';
}elseif(isset($post['action'])&&$post['action']=='unapproved_store'){
	//if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	update_status_terminal($post['bid'], "`active`=3");	//update status to unapproved terminal
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible3&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible3");exit;
	$post['action']='detail';
}elseif(isset($post['action'])&&$post['action']=='approved_store'){
	//if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	update_status_terminal($post['bid'], "`active`=1");	//update status to approved store/website
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible3&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible3");exit;
	$post['action']='detail';
}elseif(isset($post['action'])&&$post['action']=='bank_primary_disable'){
	//if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }
	update_status_bank($post['bid'], "`primary`=1");	//update bank status, set disable primary
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible7");exit;
	$post['action']='detail';
}elseif(isset($post['action'])&&$post['action']=='bank_primary_enable'){

	update_status_bank($post['bid'], "`primary`=2");	//update bank status, enable primary
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible7");exit;
	$post['action']='detail';
}elseif(isset($post['action'])&&$post['action']=='bank_account_primary'){	//set all bank as non primary before set primary
	db_query(
		"UPDATE `{$data['DbPrefix']}banks` SET ".
		"`bank_account_primary`=0 ".
		" WHERE `clientid`='".$_GET['id']."'",0
	);
	update_status_bank($post['bid'], "`bank_account_primary`=1");	//update bank status, set primary
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible7");exit;
	$post['action']='detail';
}elseif(isset($post['action'])&&$post['action']=='crypto_primary_disable'){
	update_status_bank($post['bid'], "`primary`=1", "coin_wallet");	//update crypto status, disable primary
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible7");exit;
	$post['action']='detail';
}elseif(isset($post['action'])&&$post['action']=='crypto_primary_enable'){	//update crypto status, enabled primary
	update_status_bank($post['bid'], "`primary`=2", "coin_wallet");
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible7");exit;
	$post['action']='detail';
}elseif(isset($post['action'])&&$post['action']=='crypto_wallet_primary'){	//set all crypto account as non primary before set primary
	db_query(
		"UPDATE `{$data['DbPrefix']}coin_wallet` SET ".
		"`bank_account_primary`=0 ".
		" WHERE `clientid`='".$_GET['id']."'",0
	);
	update_status_bank($post['bid'], "`bank_account_primary`=1", "coin_wallet");	//update crypto status, set primary
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible7");exit;
	$post['action']='detail';
}elseif((isset($post['action'])&&$post['action']=='sent_verification_amt')&&(!isset($data['Error'])||empty($data['Error']))){

	//send verification amount if self verification enabled
	if(isset($post['tname'])) $tname = trim($post['tname']); $tname ='';

	$actionurl = urlencode($data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&page=0&id={$_GET['id']}#collapsible7");

	//$actionurl = urlencode($data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&page=0#collapsible7");

	//self verification for coin wallet 
	if($tname=='coin_wallet'){
		header("Location:{$data['Host']}/nodal/binance_status".$data['ex']."?admin_verify=1&uid={$_GET['id']}&tid={$_GET['bid']}&actionurl=".$actionurl);
	}
	else{	//self verification for nodal account
		header("Location:{$data['Host']}/nodal/cashfree".$data['ex']."?admin_verify=1&uid={$_GET['id']}&tid={$_GET['bid']}&actionurl=".$actionurl);
	}	
	exit;

}elseif((isset($post['action'])&&$post['action']=='verify_account')&&(!isset($data['Error'])||empty($data['Error']))){

//after send verification amt, verify to account
	$gid	= (isset($_REQUEST['gid'])?$_REQUEST['gid']:0);
	if(isset($post['amount']))	$amount	= trim($post['amount']);else $amount=0;
	if(isset($post['tname']))	$tname	= trim($post['tname']); $tname ='';

	if($tname=='coin_wallet')
		$amtData = select_coin_wallet($_GET['id'],$gid);	//fetch data from coin wallet 
	else
		$amtData = select_banks($_GET['id'],$gid);			//fetch data from banks

	$verify_amount = $amtData[0]['verify_amount'];	

	if($verify_amount==$amount)	//if your your amount and verify amount are same the verification success
	{
		update_status_bank($gid, "`primary`=2, verify_status=1", $tname);
		$_SESSION['action_success']="Verification successfully";
	}
	else
	{
		$_SESSION['action_error']="Invalid amount";
	}

	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&page=0&id=".$_GET['id']."#collapsible7");exit;

}
elseif(isset($post['action'])&&($post['action']=='insert'||$post['action']=='update')){ //inser/update clients info

	if(isset($data['email_val'])&&$data['email_val']){	//registered_email value
		$post['registered_email']=$data['email_val'];
	}

	//SETUP gateway partner id
	$gatewayPartnerId1='';
	if(isset($post['gid'])) $gatewayPartnerId=$post['gid']; else $gatewayPartnerId=0;
	
	if($post['action']=='insert'&&!isset($_SESSION['login_adm'])&&!isset($_SESSION['addNew_GatewayId'])){
		$gatewayPartnerId1	= $_SESSION['sub_admin_id'];
		$gatewayPartnerId	= $_SESSION['sub_admin_id'];
	}

	if(isset($post['bussinessurl'])&&$post['bussinessurl']){$post['bussinessurls']=(implode(',',$post['bussinessurl']));}	//business url
	if(isset($post['verify_bussinessurl'])&&$post['verify_bussinessurl']){$post['verify_bussinessurls']=(implode(',',$post['verify_bussinessurl']));}	//verified business url
	if(isset($post['accesskey'])&&$post['accesskey']){$post['accesskeys']=(implode(',',$post['accesskey']));}	//access key or secret key
	
	$post['PostSent']=false;	//set postSent initially false
	$data['Sponsors']=get_sponsors($gatewayPartnerId1,'');//15	//fetch sponsor details
	
	$data['SpoMultiple']=get_sponsors($gatewayPartnerId,'');	//fetch sponsor details

	if(isset($post['gid'])) $post['MemberInfo']=get_clients_info($post['gid']);	//fetch clients information

	if(isset($post['MemberInfo']['sponsor'])&&$post['MemberInfo']['sponsor']){$sponsor=$post['MemberInfo']['sponsor'];}else{$sponsor="0";}	//setup clients sponsor info
	
	#######################################
	
	//cmn dev: 11-06-2022
	/*	
	if(((isset($_SESSION['sub_admin_id']))&&(!isset($_SESSION['login_adm'])))&&isset($post['action'])&&($post['action']=='insert')){
		$post['sponsor']=$_SESSION['sub_admin_id'];
	}
	*/
	
	//Dev Tech : 23-01-03 remodify 
	//fetch information from subadmin table
	$mail_gun_sitename=0;
	if(isset($post['sponsor'])&&$post['action']=='insert'&&$post['sponsor']>0){
		$subadmin_get=select_tablef("`id`='{$post['sponsor']}'","subadmin",0,1,"`more_details`,`domain_name`");
		$jmd=jsondecode($subadmin_get['more_details'],1,1);
		if(((!isset($jmd))&&(!($jmd['SiteName'])) ) || ((!isset($jmd['mail_migomta_api']))&&(!isset($jmd['mail_gun_api']))&&(!isset($jmd['mail_api_host'])))){
			$mail_gun_sitename=1;
		}
	}
	
	if(isset($_REQUEST['dtest1']))
	{
		echo "<br/>sponsor=>".$post['sponsor'];
		echo "<br/>mail_gun_sitename=>".$mail_gun_sitename;
		echo "<br/>jmd=>";print_r($jmd);
		echo "<br/>subadmin_get=>";print_r($subadmin_get);
		exit;
	}
		
	//cmn
	//echo "<br/>mail_gun_sitename=>".$mail_gun_sitename; echo "<br/>jmd=>";print_r($jmd);exit;
	
	##########################################


	//action is update then execute following section
	if(isset($post['action'])&&$post['action']=='update'){

		//	echo html_entity_decode($_POST['description_history']);
		$post=select_info($post['gid'], $post); 	//fetch clients information

		//exit;
		
		$post['description_for_append']=$post['description'];	//add new description
	
		if(isset($post['profile_json']['action'])){
			unset($post['profile_json']['action']);	//unset profile exist json['action']
		}
		if(isset($post['profile_json']['send'])){
			unset($post['profile_json']['send']);	//unset profile exist json['send']
		}
		if(isset($post['profile_json'])&&$post['profile_json']){
			$post=array_merge($post,$post['profile_json']);		//merge new and old json array 
			if(!isset($_POST['send'])){
				unset($post['send']);
				//unset($post['action']);
			}
		}
	}

	//if send is true then execute following section
	if(isset($post['send'])&&$post['send']){
		
		
		//check document if document exits and retrive exention of a file
		$file_name=(isset($_FILES['updatelogo'])&&$_FILES['updatelogo']?$_FILES['updatelogo']['name']:'');
		$ext = substr($file_name, strpos($file_name,'.'), strlen($file_name)-1);
	
		//check field validation
		if(($post['action']=='insert')&&(!is_user_available($post['username']))){
			$data['Error']='Sorry but this username already taken.';
		}elseif(($post['action']=='insert')&&($mail_gun_sitename)){
			$data['Error']='Incomplete json format in partner gateway - '.$post['sponsor'];
		}elseif(!$post['username']){
			$data['Error']='Please enter clients username.';
		}elseif(!$_POST['registered_email']){
			$data['Error']='Please enter your registered email address.';
		/*}elseif(!$post['user_type']){
			$data['Error']='Please choose the User Type Radio Button like Individual or Business.';*/
		}elseif(!$post['fullname']){
			$data['Error']='Please enter your full name.';
		}elseif(!$post['company_name']){
			$data['Error']='Please enter your company name.';
		}elseif(($file_name)&&($_FILES["updatelogo"]["size"]>6000000)){ //1000000*6=6000000 (6MB)
			$data['Error']="File size should be less than 6MB";	
		}elseif(($file_name)&&(!preg_match("/\.(jpg|jpeg|bmp|gif|png|docx|xlsx|pdf|CSV)$/", $file_name))){
			$data['Error']="Unsupported file type ".$ext;	//file must be above format
		}else{ 
		
			
			if(isset($post['action'])&&$post['action']=='insert'){
				$post['password']=generate_password(10);		//generate random password

				$post['id']=create_client_info($post,true);	//insert clients data into table
				$uid=$post['id'];
				$_SESSION['action_success_merchant']="Your Profile Information Has Been Created";
				
				// Dev Tech : 23-01-06 showing new merchant for create by subamdin 
				if(isset($_SESSION['sub_admin_id'])){
					$_SESSION['get_mid_array'][]=$post['id'];
					$_SESSION['get_mid']=implode(",",$_SESSION['get_mid_array']);
				}
				
				include('../include/add_principal'.$data['iex']);	//include external file
				//principal_update($uid,$parameterstr);
				principal_update($post['id'],$encryptres_principal);	//update encoded_contact_person_info

				//$_SESSION["action_success"]='Your Profile Information Has Been Created';
			}else{
				//update_private_info($post, $post['gid']);
				$uid=$post['gid'];
				
				$maxId=$uid."_".$post['fullname']."_".@$post['document_type']."_".time().mt_rand(0,9999999);

				//$updatelogo		= $post['updatelogo']; 
				$upload_logo	= @$post['upload_logo']; 
				$uploaddir 		= '../user_doc/';

				$fileName	= $maxId.'_'.@$_FILES['updatelogo']['name'];
				$updatelogo_file = $uploaddir . basename($fileName); 
				
				
				//if(isset($_FILES['updatelogo']['tmp_name'])&&$upload_logo)unlink($uploaddir . basename($upload_logo));
				
				if (move_uploaded_file(@$_FILES['updatelogo']['tmp_name'], $updatelogo_file)) { 
					if($upload_logo){unlink($uploaddir . basename($upload_logo));}
				} else {
					$fileName = $upload_logo;
				}
				
				$post['upload_logo']=$fileName;
				if($post['upload_logo']){$_POST['upload_logo']=$post['upload_logo'];}
				
				
				if(isset($post['multiple_subadmin_ids'])&&$post['multiple_subadmin_ids']){
					
					$post['multiple_subadmin_ids']=','.implode(',',$post['multiple_subadmin_ids']).',';								
				}
				

				//echo $post['description-old']=$post['description'];
				if(isset($post['description']))unset($post['description']);

				//for update user name in both field on db first attampt 23/03/2023
				if(isset($_POST['username'])&&$_POST['username']){$post['username']=$_POST['username'];}

				update_client_info($post, $post['gid'], false,true);	//update clients information
				
				$exist_email= "";
				$exist_data	= get_clients_info($post['gid']);	//fetch clients info
				$exist_email= encrypts_decrypts_emails($exist_data['registered_email'],2);	//decrypts registered_email id 
				$_POST['registered_email']=prntext($_POST['registered_email']);

				if(strstr($_POST['registered_email'],'*')){ $_POST['registered_email']=$exist_email; }
				$qemail = "";
				if($exist_email!=$_POST['registered_email'])	//compare old email with new update email id, if new email is different old email then then encrypt new email and update 
				{
					$post['exist_email']=$exist_email;
					$qemail = ", `registered_email`='".encrypts_decrypts_emails($_POST['registered_email'],1)."' ";
				}
				
					$description='';
				
				
				
					if(isset($_SESSION['sub_admin_id'])){
						$byusername=$_SESSION['sub_admin_id'].":".$_SESSION['sub_admin_fullname']."-".$_SESSION['sub_admin_rolesname'];
					}elseif(isset($_SESSION['m_username'])&&(!isset($_SESSION['adm_login']))){
						$byusername="Merchant:".$_SESSION['uid']."-".$_SESSION['m_username'];
					}else{
					if(isset($_SESSION['admin_id'])&&isset($_SESSION['sub_username'])){
						$byusername="Admin : ".$_SESSION['admin_id']." - ".$_SESSION['sub_username'];
					}else{
						$byusername='Admin';
					}
				}

				//echo "<br/><br/><br/>description_str=>";
				
				if($_POST['description']<>""){
					$post['description'];
					$desc_date=prndate(date("Y-m-d H:i:s"));
					//$byusername=" - ".$_SESSION['username'];
					$description_str = '<div class=desc_row><div class=desc_date>'.$desc_date.'</div><div class=desc_msg title="'.$desc_date.'">'.$byusername.' : '.$_POST['description'].' .</div></div>'.$_POST['description_history'];
					if($data['connection_type']=='PSQL')
						$description_str=pg_escape_string($data['cid'],$description_str);
					else $description_str=mysqli_real_escape_string($data['cid'],$description_str);
					$description= ", `description`='{$description_str}' ";
				}else{
					$description_str = $_POST['description_history'];
					if($data['connection_type']=='PSQL')
						$description_str=pg_escape_string($data['cid'],$description_str);
					else $description_str=mysqli_real_escape_string($data['cid'],$description_str);
					$description= ", `description`='{$description_str}' ";
				}
				
				
				//echo $description_str; echo "<br/><br/><br/>description_str2=>";
				//exit;
				
				//update clients information
				db_query(
					"UPDATE `{$data['DbPrefix']}clientid_table` SET ".
					"`username`='".$post['username']."'".
					$qemail.$description.
					" WHERE `id`='".$post['gid']."'",0
				);
				if($qemail)
				{
					db_query(
						"UPDATE `{$data['DbPrefix']}clientid_emails` SET ".
						"`email`='".encrypts_decrypts_emails($_POST['registered_email'],1)."' WHERE `clientid`='".$post['gid']."' AND `active`=1 AND `primary`=1",0
					);
				
				}
				
				
				//exit;
			
				
				//print_r($post);exit();
				$_SESSION["action_success_merchant"]='Your Profile Information Has Been Updated';
				}
				if($uid&&isset($_POST['google_auth_access'])&&$_POST['google_auth_access']){
					$twoGmfa=twoGmfa(0,$uid,$_POST['google_auth_access']);
				}
				//update_card_info($post, $post['gid'], false);
				//update_bank_info($post, $post['gid'], false);
				$id = "";if($post['id']){$id = "&id=".$post['id'];}
				$type = "";if($post['type']){$type = "&type=".$post['type'];}
				$page = "";if(isset($post['page'])&&$post['page']){$page = "&page=".$post['page'];}
				header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible1$id$type$page");
				$post['PostSent']=true;exit;
				
		}
	}elseif(isset($post['cancel'])&&$post['cancel']){
			$post['action']='select';
	}
}elseif(isset($post['action'])&&($post['action']=='insert_card'||$post['action']=='update_card')){	//update card information of a clients
	$post['PostSent']=false;
	if($post['action']=='update_card'){
		$card=select_cards($post['gid'], false, $post['bid'], true);	//fetch card information
		if($card)foreach($card[0] as $key=>$value)if(!isset($post[$key])||!$post[$key])$post[$key]=$value;
	}
	//check field validation
	if(isset($post['send'])&&$post['send']){
		if(!$post['ctype']){
			$data['Error']='Please choose your credit card type.';
		}elseif(!$post['cname']){
			$data['Error']='Please enter your full name from credit card.';
		}elseif(!$post['cnumber']||!is_number($post['cnumber'])){
			$data['Error']='Please enter your valid credit card number.';
		}elseif(!$post['ccvv']||!is_number($post['ccvv'])){
			$data['Error']='Please enter your valid credit card CVV number.';
		}elseif(!$post['cmonth']){
			$data['Error']='Please choose month for expired date.';
		}elseif(!$post['cyear']){
			$data['Error']='Please choose year for expired date.';
		}else{
			if($post['action']=='insert_card'){
				$post['bid']=insert_card_info($post, $post['gid']);		//insert new card info
			}else{
				update_card_info($post, $post['bid'], $post['gid']);	//update card info
			}
			$post['PostSent']=true;
		}
	}elseif(isset($post['cancel'])&&$post['cancel']){
		$post['action']='detail';
	}
}elseif(isset($post['action'])&&($post['action']=='insert_bank'||$post['action']=='update_bank')){	//insert or update bank / crypto info
	$post['PostSent']=false;
	$post['MemberInfo']=get_clients_info($post['gid']);	//fetch clients info
	
	$cryptoWalle=false;
	if((isset($_GET['insertType']) && $_GET['insertType']=='Crypto Wallet')|| (isset($post['insertType']) && $post['insertType']=='Crypto Wallet')){
		$cryptoWalle=true;
	}
	
	if($post['action']=='update_bank'){
		if($cryptoWalle){
			$bank=select_coin_wallet($post['gid'], $post['bid'], true);	//fetch information from crypto
		}else{
			$bank=select_banks($post['gid'], $post['bid'], true);		//fetch information from bank
		}
		if($bank)foreach($bank[0] as $key=>$value)if(!isset($post[$key])||!$post[$key])$post[$key]=$value;
	}
	if(isset($post['send'])&&$post['send']){
		$file_name=$_FILES['bankdoc']['name'];
		//echo $_POST['withdrawFee'];
		if(isset($_POST['withdrawFee'])){
			$post['withdrawFee']=$_POST['withdrawFee'];
		}
		
		$validation=false;
		if($cryptoWalle){	//field validation for crypto wallet
			if(!$post['coins_name']){
					$data['Error']='Please select name of coins.';
			}elseif(!$post['coins_network']){
					$data['Error']='Please select Network.';
			}elseif(!$post['coins_address']){
					$data['Error']='Please enter coin address.';
			}elseif(!$post['coins_wallet_provider']){
					$data['Error']='Please enter Wallet Provider.';
			}
			else $validation=true;
		}else		//field validation for bank account
			//if($post['insertType']=='Bank Account' || (isset($_GET['insertType']) && $_GET['insertType']=='Bank Account'))
			{
			if(!$post['bname']){
					$data['Error']='Please enter name of your bank.';
			}elseif(!$post['baddress']){
					$data['Error']='Please enter address of your bank.';
			}/*elseif(!$post['bcity']){
					$data['Error']='Please enter city of your bank.';
			}elseif(!$post['bzip']){
					$data['Error']='Please enter postal code of your bank.';
					}elseif(!$post['bcountry']){
					$data['Error']='Please choose country of your bank.';
			}elseif(!$post['bphone']){
					$data['Error']='Please enter telephone number of your bank.';
			}elseif(!$post['bnameacc']){
					$data['Error']='Please enter account name.';
				}*/
			elseif(!$post['baccount']){
				$data['Error']='Please enter account number.';
			}
			else $validation=true;
		}
		
		if($validation==true)	//if field validation is true then execute following section
		{
			if(($file_name)&&($_FILES["bankdoc"]["size"]>6000000)){ //1000000*6=6000000 (6MB)
				$data['Error']="File size should be less than 6MB";	
			}elseif(($file_name)&&(!preg_match("/\.(jpg|jpeg|bmp|gif|png|pdf)$/", $file_name))){
				$data['Error']="Unsupported file type ".$ext;
			}else{
				
				if($cryptoWalle){
					$maxId=$uid."_".$post['coins_name']."_".time().mt_rand(0,9999999);
				}else{
					$maxId=$uid."_".$post['bnameacc']."_".$post['bswift']."_".time().mt_rand(0,9999999);	
				}
					
				$updatelogo		= @$post['bankdoc']; 
				$upload_logo	= @$post['upload_logo']; 
				$uploaddir 		= '../user_doc/';

				$fileName	= $maxId.'_'.$_FILES['bankdoc']['name'];
				$updatelogo_file = $uploaddir . basename($fileName); 
				
				//if(isset($_FILES['updatelogo']['tmp_name'])&&$upload_logo)unlink($uploaddir . basename($upload_logo));
				
				if (move_uploaded_file($_FILES['bankdoc']['tmp_name'], $updatelogo_file)) { 
					if($upload_logo){unlink($uploaddir . basename($upload_logo));}
				} else {
					$fileName = $upload_logo;
				}
				
				$post['upload_logo']=$fileName;
			}
			
			if($post['action']=='insert_bank'){
									
				if($cryptoWalle){
					$post['bid']=insert_coin_wallet_info($post, $post['gid'],false,true);	//insert data into coin_wallet table
					if($data['cwnewid']){
						$tabid=$data['cwnewid'];	// id of new inserted coin wallet row
						//json_log_upd($tabid,'coin_wallet');
					}
					
					$_SESSION['action_success_merchant']="Crypto Wallet Added Successfully";
				}else{
					$post['bid']=insert_bank_info($post, $post['gid'],false,true);	//insert data into bank table
					if($data['bnknewid']){
						$tabid=$data['bnknewid'];		// id of new inserted bank row
						//json_log_upd($tabid,'banks');
					}
					$_SESSION['action_success_merchant']="Bank Account Added Successfully";
				}
				
			}else{ // update bank and Crypto Wallet
				if($cryptoWalle){
					update_coin_wallet_info($post, $post['bid'], $post['gid'],false,true);	//update coin wallet info
					$tabid=$post['bid'];		
					json_log_upd($tabid,'coin_wallet');	//update json log
					//$_SESSION['action_success_merchant']="Crypto Wallet Update Successfully";
				}else{
					update_bank_info($post, $post['bid'], $post['gid'],false,true);	//update bank info
					$tabid=$post['bid'];		
					//json_log_upd($tabid,'banks');
					//$_SESSION['action_success_merchant']="Bank Account Update Successfully";
				}
			}
			$id=($post['gid']?$post['gid']:$_GET['id']);
			header("location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible7&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible7");
			$post['PostSent']=true;exit;
		}
	}elseif(isset($post['cancel'])&&$post['cancel']){
		$post['action']='detail';
	}
}elseif(isset($post['action'])&&$post['action']=='cancel'){
	$post['action']='select';	//if action is cancel then return home page
}elseif(isset($post['action'])&&($post['action']=='insert_mer_setting'||$post['action']=='update_mer_setting' || $post['action']=='insert_mer_setting_associate'||$post['action']=='update_mer_setting_associate')){
	//INSERT OR UPDATE account_associate data

		//if($_SESSION['sub_admin_rolesname']=="Associate"){ echo "ACCESS DENIED"; exit; }
		
		$post['PostSent']=false;
		
		$post['MemberInfoSponsorId']=get_clients_info($post['gid']);	//fetch clients info

		if(isset($post['MemberInfoSponsorId']['sponsor'])&&$post['MemberInfoSponsorId']['sponsor']){$sponsor=$post['MemberInfoSponsorId']['sponsor'];}else{$sponsor="0";}
		//echo "<br/>11acquirer_id=>".$post['acquirer_id'];
		if($post['action']=='update_mer_setting' || $post['action']=='update_mer_setting_associate'){
			$gid=$post['gid'];
			if($post['action']=='update_mer_setting_associate'){$gid=$sponsor;}
			$ms_get=select_mer_setting($gid, $post['bid'], true);	//fetch _mer_setting info
			
			$post=array_merge($post,$ms_get[0],$_POST);
			
			//if($ms_get)foreach($ms_get[0] as $key=>$value)if(!isset($post[$key])||!$post[$key])$post[$key]=$value;
			
			
		}
		if(isset($post['send'])&&$post['send']){
				
			if(isset($_SESSION['acquirer_display_order_ar'])&&is_array($_SESSION['acquirer_display_order_ar'])){
				$acquirer_display_order_acc=array_search((int)$post['acquirer_display_order'],$_SESSION['acquirer_display_order_ar']);	//fetch key value of $post['acquirer_display_order'] from $_SESSION['acquirer_display_order_ar'] array 
			}else{
				$acquirer_display_order_acc='';
			}


			//check field validation
			if(!$post['acquirer_id']){
					$data['Error']='Please Select of Acquirer Id';
			}elseif(!$post['txn_fee_success']&&$data['con_name']!='clk'){
					$data['Error']='Please enter in txn. fee success.';
			}elseif(($post['acquirer_display_order'])&&(($_SESSION['acquirer_display_order_ar'])&&(in_array((int)$post['acquirer_display_order'], $_SESSION['acquirer_display_order_ar'], false)))&&($post['acquirer_id']!=$acquirer_display_order_acc)){
					$data['Error']='Please select another value. Allready '.$post['acquirer_display_order'].' added in '.$acquirer_display_order_acc.' Acquirer';
			}elseif(!$post['mdr_rate']){
					$data['Error']='Please enter in TRANSACTIONS PERCENT.';
			}else{ 
				if(isset($_POST['salt_id'])){
					$post['salt_id']=$_POST['salt_id'];
				}
				
				//check action type insert_mer_setting or update_mer_setting
				if($post['action']=='insert_mer_setting'){
				
					$post['assignee_type']="1"; // Merchant
					$post['sponsor']=$sponsor;
					if(count_mer_setting($post['gid'],$post['acquirer_id'])==true){	//check mid exist or not
						$_SESSION['action_success_merchant']="Duplicate - Acquirer Already Added";
					}else{
						$post['bid']=create_mer_setting($post, $post['gid']);	//insert Acquirer info
						$_SESSION['action_success_merchant']="Acquirer Added Successfully";
					}
					
				}elseif($post['action']=='update_mer_setting'){
					//$post['acc_title']="Merchant";
					update_mer_setting($post, $post['bid'], $post['gid']);	//update Acquirer info
					$_SESSION['action_success_merchant']="Acquirer Update Successfully";
				}elseif($post['action']=='insert_mer_setting_associate'){
					$post['assignee_type']="2"; // Associate
					$post['sponsor']=$post['gid'];
					//$post['acc_title']="Associate";
					$_SESSION['action_success_merchant']="Gateway Partner Added Successfully";
					$post['bid']=create_mer_setting($post, $sponsor);	//insert account_associate info
				}elseif($post['action']=='update_mer_setting_associate'){
					//$post['acc_title']="Associate";
					update_mer_setting($post, $post['bid'], $post['gid']);	//update account_associate info
					$_SESSION['action_success_merchant']="Gateway Partner Update Successfully";
				}
					
				if(isset($_GET['add_template'])&&$_GET['add_template']){
					
					exit;
				}else{
					$id=($post['gid']?$post['gid']:$_GET['id']);
					header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible6&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible6");exit;
				}
				exit;
				$post['PostSent']=true;
			}
		}elseif(isset($post['cancel'])&&$post['cancel']){
			$post['action']='detail';
		}
}elseif(isset($post['action'])&&($post['action']=='insert_micro_trans'||$post['action']=='update_micro_trans')){	//insert and update micro transaction
	$post['PostSent']=false;

	if(isset($post['send'])&&$post['send']){
		//check form validation
		if(!$post['no_micro_transaction']){
				$data['Error']='Please enter No. of Micro Trans.';
		}elseif(!$post['total_amount']){
				$data['Error']='Please enter in Total Amount.';
		}else{
			if($post['action']=='insert_micro_trans'){
					$post['bid']=insert_micro_trans_info($post, $post['gid']);	//insert transactions
			}elseif($post['action']=='update_micro_trans'){
					//update_micro_trans_info($post, $post['bid'], $post['gid']);
			}
			$id=($post['gid']?$post['gid']:$_GET['id']);
			header("location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible5&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible5");
			$post['PostSent']=true;exit;
		}
	}elseif(isset($post['cancel'])&&$post['cancel']){
		$post['action']='detail';
	}
}elseif((isset($post['action'])&&($post['action']=='insert_terminals'||$post['action']=='update_terminals'))||(isset($post['action_edit'])&&$post['action_edit']=='update_terminals_admin')){	//insert or/and update store/website info
	$post['PostSent']=false;
	
	$post['AccountInfo']=mer_settings($post['gid']);	//fetch account info
	
	$_SESSION['MemberInfo']=$post['MemberInfo']=get_clients_info($post['gid']);	//fetch clients info

	if((isset($post['action'])&&$post['action']=='update_terminals')&&(@$post['action_edit']!='update_terminals_admin')){
		$terminal=select_terminals($post['gid'], $post['bid'], true);	//fetch store detail
		
		if (count ($terminal)>0) {
			foreach($terminal[0] as $key=>$value){
				if(!isset($post[$key])||!$post[$key]){
					$post[$key]=$value;
				}
			}
		}
		else {$data['Error']="No Record Found";}
		
		if(isset($data['PRO_VER'])&&$data['PRO_VER']==3){
			merchant_categoryf();	//fetch the list of all merchant category
			/*
			$nick_name_ar = array_map(function ($ar) {return $ar['acquirer_id'];}, $post['AccountInfo']);
			$acquirer_id=implodef($nick_name_ar);
			
			$data['mcc_codes_list']=mcc_code_listf($acquirer_id);
			*/
			//print_r($data['mcc_codes_list']);
		}
		
	}
	//$post['Buttons']=get_files_list($data['SinBtnsPath']);
	
	

	if(isset($post['send'])&&$post['send']){
		//to check form / field validation
		if(!@$post['acquirerIDs']&&@$post['active']==1){
			$data['Error']='Please select at list one Acquirer Account Id.';
		}/*elseif(!$post['curling_access_key']&&$post['active']==1){
			$data['Error']='Please Radio button of Select Acquirer Account for Curling API/eCheck Process.';
		}*/elseif(!@$post['ter_name']){
			$data['Error']="Please enter {$store_name} Name of your choice.";
		}elseif(!$post['bussiness_url']){
			$data['Error']='Please enter Business URL.';
		}else{

			if((isset($post['a'])&&$post['a'])||(isset($post['terNO_json_value'])&&$post['terNO_json_value'])){
				$terNO_json=array();
				if($post['a']){
					foreach($post['acquirerIDs'] as $key => $mid)
					{
						//print_r($post['a'][$mid]);
						$terNO_json['terNO_json'][$mid]=$post['a'][$mid];	//store json of a acquirer
					}

					//$terNO_json['terNO_json']=($post['a']);
					//print_r($post['a']);
				}
				
				if($post['terNO_json_value']){
					$terNO_json['terNO_json_curl']=($post['terNO_json_value']); //store json values
					
					//echo "<hr/>terNO_json_curl=><br/>".$post['terNO_json_value'];
				}
				
				//stripslashes
				$post['terNO_json_value']=(jsonencode($terNO_json));	//encode json

				//print_r($post['terNO_json_value']);exit;
			}

			if(!$post['active']){
				$post['active']=0;
			}
			
			if($post['action']=='insert_terminals'){
				$post['bid']=insert_terminal($post['gid'], $post,true);	//insert new Business
				$_SESSION['action_success_merchant']="Business Added Successfully";
			}elseif($post['action_edit']=='update_terminals_admin'){
				update_terminal($post['bid'],$post,true);
				$_SESSION['action_success_merchant']="Business Update Successfully";	//update Business info
			}
			
			$id=($post['gid']?$post['gid']:$_GET['id']);
			
			//echo "<br/>is_admin_link=>".$data['is_admin_link'];exit;
			
			header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible3&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible3");
			
			$post['PostSent']=true;exit;
		}
	}elseif(isset($post['cancel'])&&$post['cancel']){
		$post['action']='detail';
	}
}elseif(isset($post['action'])&&$post['action']=='re_generate_public_key'){	//api public key generate again
	$public_key_store=api_public_key($post['gid'],$post['bid']);
	if(isset($_REQUEST['ajax'])&&$_REQUEST['ajax']){
		echo $public_key_store;exit;
	}
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible3&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible3");
	$post['PostSent']=true;exit;
	
}elseif(isset($post['action'])&&$post['action']=='generate_private_key'){	//generate kecret key
	$generate_private_key=generate_private_key($post['gid']);	//generate kecret key
	if(isset($_REQUEST['ajax'])&&$_REQUEST['ajax']){
		echo $generate_private_key;exit;
	}
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible3&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible3");
			$post['PostSent']=true;exit;
	
}
elseif(isset($post['action'])&&($post['action']=='insert_principal'||$post['action']=='update_principal')){	//insert or update encoded_contact_person_info data
	$post['PostSent']=false;
	
	
	if($post['action']!='insert_principal'){
		$decryptres=select_principal($post['gid'],$post['bid'],true);
		
			$exp_1=explode('","',$decryptres);
			foreach($exp_1 as $value){
				if($value){
					$exp_2=explode('":"',$value);
					//echo "<hr/>".$exp_2[0]."=".$exp_2[1];
					if(!isset($post[$exp_2[0]]))$post[$exp_2[0]]=(isset($exp_2[1])?$exp_2[1]:'');
				}
			}
		//print_r($decryptres);
		
	}

	if(isset($post['send'])&&$post['send']){
		if(!isset($post['fullname'])||!$post['fullname']){
			$data['Error']='Please enter the name';
		}elseif(!isset($post['designation'])||!$post['designation']){
			$data['Error']='Please enter the designation';
		}else{
			$uid=$post['gid'];
			include('../include/add_principal'.$data['iex']);
			
			if($post['action']=='insert_principal'){
				$post['bid']=principal_update($uid,$encryptres_principal);
				$_SESSION['action_success_merchant']="Spoc Added Successfully";
			}elseif($post['action']=='update_principal'){
				$post['bid']=principal_update($uid,$encryptres_principal,$post['bid']);
				$_SESSION['action_success_merchant']="Spoc Updated Successfully";
			}
			$id=($post['gid']?$post['gid']:$_GET['id']);
			header("location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&tab_name=collapsible2&type=active&page=0&id=".$id.$data['is_admin_link']."#collapsible2");
			$post['PostSent']=true;exit;
		}
	}elseif(isset($post['cancel'])&&$post['cancel']){
		$post['action']='detail';
	}
	
	$_SESSION['phone_verify_no']=mt_rand(0,9999);
	$_SESSION['email_verify_no']=mt_rand(0,9999);
	
	if(isset($post['phone_verify'])&&$post['phone_verify']!="Verified"){
		verify_email_phone($post['gid'],$post,'1',$_SESSION['phone_verify_no'],true);
	}
	if(isset($post['email_verify'])&&$post['email_verify']!="Verified"){
		verify_email_phone($post['gid'],$post,'2',$_SESSION['email_verify_no'],true);
	}
}elseif(isset($post['action'])&&$post['action']=='update_delete'){
	$uid=$post['gid'];
	$post['bid']=principal_update($uid,'',$post['bid'],'delete');
	$id=($post['gid']?$post['gid']:$_GET['id']);
	$_SESSION['action_success_merchant']="Spoc Delete Successfully";
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&type=active&page=0".$data['is_admin_link']."&id=".$id."#encoded_contact_person_info");exit;
}

elseif(isset($post['action'])&&$post['action']=='purchaseorder'){
	/*
	$tolal_micro=0;$tolal_micro_get=0;
	$post['micro_tran']=micro_trans($uid,false);
	if(!empty($post['micro_tran'])){
		$tolal_micro_get=$post['micro_tran'][0]['tolal_micro_transactions'];
	}
	$post['micro_tran_current']=micro_trans($uid,false,$post['bid']);
	$micro_tran_current=$post['micro_tran_current'][0]['no_micro_transaction'];

	$tolal_micro=(int)$tolal_micro_get+(int)$micro_tran_current;
	
	db_query(
		"UPDATE `{$data['DbPrefix']}micro_transaction_table`".
		" SET `status`=1, `tolal_micro_transactions`='".$tolal_micro."',`date_of_micro_trans`=NOW()".
		" WHERE `id`='".$post['bid']."' AND `receiver_id`='$uid' "
	);
	$id=($post['gid']?$post['gid']:$_GET['id']);
	header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&type=active&page=0&id=".$id."#micro_trans");
	$post['PostSent']=true;exit;
	
	*/
}
elseif(isset($post['action'])&&$post['action']=='update_payin_setting'){
	
	$id=($post['gid']?$post['gid']:$_GET['id']);
	
	$payin_setting_get=select_tablef("`clientid`='{$id}'","payin_setting");
	if(isset($payin_setting_get)&&$payin_setting_get) $post=array_merge($post,$payin_setting_get);
	if(isset($_POST)&&$_POST) $post=array_merge($post,$_POST);
	
	if(isset($post['send'])&&$post['send']){
		if(!isset($post['settlement_fixed_fee'])||!$post['settlement_fixed_fee']){
			$data['Error']='Please enter the Settlement fixed fee';
		}elseif(!isset($post['settlement_min_amt'])||!$post['settlement_min_amt']){
			$data['Error']='Please enter the Settlement Min. Amt.';
		}elseif(!isset($post['monthly_fee'])||!$post['monthly_fee']){
			$data['Error']='Please enter the Monthly Fee';
		}elseif(!isset($post['frozen_balance'])||!$post['frozen_balance']){
			$data['Error']='Please enter the Frozen Balance';
		
		}else{
			
			
			db_query(
				"UPDATE `{$data['DbPrefix']}payin_setting`".
				" SET `settlement_optimizer`='{$post['settlement_optimizer']}',`payin_theme`='{$post['payin_theme']}',`settlement_fixed_fee`='{$post['settlement_fixed_fee']}', `settlement_min_amt`='{$post['settlement_min_amt']}', `monthly_fee`='{$post['monthly_fee']}', `frozen_balance`='{$post['frozen_balance']}'  ".
				" WHERE `clientid`='".$id."'  ",0
			);
			
			/*
			if(isset($post['payin_status'])){
				db_query(
					"UPDATE `{$data['DbPrefix']}clientid_table`".
					" SET `status`='{$post['payin_status']}'  ".
					" WHERE `id`='".$id."'  ",0
				);
			}
			*/
			header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&type=active&id=".$id."&tab_name=collapsible11");
			$post['PostSent']=true;exit;
			
			
		}
	}
}
elseif(isset($post['action'])&&$post['action']=='update_softpos_setting'){
	
	$id=($post['gid']?$post['gid']:$_GET['id']);
	
	$softpos_setting_get=select_tablef("`clientid`='{$id}'","softpos_setting");
	if(isset($softpos_setting_get)&&$softpos_setting_get) $post=array_merge($post,$softpos_setting_get);
	if(isset($_POST)&&$_POST) $post=array_merge($post,$_POST);
	
	if(isset($post['send'])&&$post['send']){
		if(!isset($post['softpos_pa'])||!$post['softpos_pa']){
			$data['Error']='Please enter the PA';
		}elseif(!isset($post['softpos_pn'])||!$post['softpos_pn']){
			$data['Error']='Please enter the PN';
		}elseif(!isset($post['softpos_terNO'])||!$post['softpos_terNO']){
			$data['Error']='Please enter the terNO';
		}elseif(!isset($post['softpos_public_key'])||!$post['softpos_public_key']){
			$data['Error']='Please enter the Public Key';
		
		}else{
			
			
			db_query(
				"UPDATE `{$data['DbPrefix']}softpos_setting`".
				" SET `softpos_pa`='{$post['softpos_pa']}', `softpos_pn`='{$post['softpos_pn']}', `softpos_terNO`='{$post['softpos_terNO']}', `softpos_public_key`='{$post['softpos_public_key']}'  ".
				" WHERE `clientid`='".$id."'  ",0
			);
			
			
			if(isset($post['softpos_status'])){
				db_query(
					"UPDATE `{$data['DbPrefix']}clientid_table`".
					" SET `qrcode_gateway_request`='{$post['softpos_status']}'  ".
					" WHERE `id`='".$id."'  ",0
				);
			}
			
			header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&type=active&id=".$id."&tab_name=collapsible12");
			$post['PostSent']=true;exit;
			
			
		}
	}
}
elseif(isset($post['action'])&&$post['action']=='update_payout_setting'){
	
	$id=($post['gid']?$post['gid']:$_GET['id']);
	
	$payout_setting_get=select_tablef("`clientid`='{$id}'","payout_setting");
	if(isset($payout_setting_get)&&$payout_setting_get) $post=array_merge($post,$payout_setting_get);
	if(isset($_POST)&&$_POST) $post=array_merge($post,$_POST);
	
	if(isset($post['send'])&&$post['send']){
		if(!isset($post['payout_fixed_fee'])||!$post['payout_fixed_fee']){
			$data['Error']='Please enter the Payout Fixed fee';
		}elseif(!isset($post['payout_account'])||!$post['payout_account']){
			$data['Error']='Please enter the Payout A/c.';
		}elseif(!isset($post['payout_status'])||!$post['payout_status']){
			$data['Error']='Please enter the Payout Status';
		}elseif(!isset($post['scrubbed_period'])||!$post['scrubbed_period']){
			$data['Error']='Please enter the Scrubbed Period';
		}elseif(!isset($post['min_limit'])||!$post['min_limit']){
			$data['Error']='Please enter the Min Trxn Limit';
		}elseif(!isset($post['max_limit'])||!$post['max_limit']){
			$data['Error']='Please enter the Max Trxn Limit';
		}elseif(!isset($post['tr_scrub_success_count'])||!$post['tr_scrub_success_count']){
			$data['Error']='Please enter the Min Success Count';
		}elseif(!isset($post['tr_scrub_failed_count'])||!$post['tr_scrub_failed_count']){
			$data['Error']='Please enter the Min. Failed Count';
		
		}else{
			
			
			
			db_query(
				"UPDATE `{$data['DbPrefix']}payout_setting`".
				" SET `payout_fixed_fee`='{$post['payout_fixed_fee']}',`payout_account`='{$post['payout_account']}',`payout_status`='{$post['payout_status']}', `scrubbed_period`='{$post['scrubbed_period']}', `min_limit`='{$post['min_limit']}', `max_limit`='{$post['max_limit']}', `tr_scrub_success_count`='{$post['tr_scrub_success_count']}', `tr_scrub_failed_count`='{$post['tr_scrub_failed_count']}', `whitelisted_ips`='{$post['whitelisted_ips']}'  ".
				" WHERE `clientid`='".$id."'  ",0
			);
			
			if(isset($post['payout_status'])){
				db_query(
					"UPDATE `{$data['DbPrefix']}clientid_table`".
					" SET `payout_request`='{$post['payout_status']}'  ".
					" WHERE `id`='".$id."'  ",0
				);
			}
			
			header("Location:".$data['Admins']."/{$data['my_project']}{$data['ex']}?action=detail&type=active&id=".$id."&tab_name=collapsible13");
			$post['PostSent']=true;exit;
			
			
		}
	}
}

elseif(isset($post['action'])&&$post['action']=='cancel'){
	$post['action']='select';
}elseif(isset($_GET['action'])&&$_GET['action']=='verify'){
	$gid=(isset($_GET['id'])?$_GET['id']:0);
	db_query("UPDATE `{$data['DbPrefix']}clientid_table` set `status`=1,`ip_block_client`='1' WHERE `id`='$gid'");
	$post['action']='detail';$_SESSION['action_success_merchant']="Account Verified";

}elseif(isset($_GET['action'])&&$_GET['action']=='certify'){
	$gid=(isset($_GET['id'])?$_GET['id']:0);
	db_query("UPDATE `{$data['DbPrefix']}clientid_table` set `status`=2, `edit_permission`='1' WHERE `id`='$gid'");
	$post['action']='detail';$_SESSION['action_success_merchant']="Account certified";
	
}elseif(isset($_GET['action'])&&$_GET['action']=='fullyverify'){
	$gid=(isset($_GET['id'])?$_GET['id']:0);
	db_query("UPDATE `{$data['DbPrefix']}clientid_table` set `active`=1, `status`=2, `edit_permission`='1' WHERE `id`='$gid'");
	$post['action']='detail';
	json_log_upd($gid,'clientid_table','Full Verified'); // for json log history
	$_SESSION['action_success_merchant']="Profile has been Activated.";
	///////////New Added for Redirect By Vikash 23-07-2022/////////
	header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=$gid&action=detail");
	exit;
	///////////End Redirect By/////////
	
}elseif(isset($_GET['action'])&&$_GET['action']=='unverify'){
	$gid=$_GET['id'];
	db_query("UPDATE `{$data['DbPrefix']}clientid_table` set `status`=0 WHERE `id`='$gid'",0);
	json_log_upd($gid,'clientid_table','Un Verified'); // for json log history

	$post['action']='detail';$_SESSION['action_success_merchant']="Account Unverified";
	//exit;
}
elseif(isset($_GET['action'])&&isset($_GET['id'])&&$_GET['action']=='insert_blkdata'){

	if(isset($post['gid'])&&$post['gid'])
	{
		$result=get_blacklist_details($post['gid'], 'addnew', $post);
	
		if($result=='SUCCESS')
			$_SESSION['action_success']="Your data has been addedd successfully";
		else 
			$_SESSION['action_error']=$result;
	}
	header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=".$post['gid']."&action=detail&tab_name=collapsible11#collapsible11");exit;
 
}elseif(isset($post['action'])&&$post['action']=='delete_blkdatas'){
	$bid=$_GET['bid'];
	$id	=$_GET['id'];
	if(isset($bid)&&$bid>0)
	{
		$del_post['choice'][]=$bid;
		get_blacklist_details($id, 'delete', $del_post);
		$_SESSION['action_success']="Successfully Deleted";
		header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=".$id."&action=detail&tab_name=collapsible11#collapsible11");exit;
	}
}
###############################################################################
elseif(isset($_GET['action'])&&isset($_GET['id'])&&$_GET['action']=='close'){
	$gid=$_GET['id'];
	if(isset($gid)&&$gid>0){
		db_query("UPDATE `{$data['DbPrefix']}clientid_table` set `active`=2,`status`=0 WHERE `id`='$gid'");
		$post['action']='detail';
		json_log_upd($gid,'clientid_table','close'); // for json log history
		$_SESSION['action_success_merchant']='Profile has been closed.';
		header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=$gid&action=detail");
		exit;
	}
}elseif(isset($_GET['action'])&&isset($_GET['id'])&&$_GET['action']=='suspend'){
	$gid=$_GET['id'];
	if(isset($gid)&&$gid>0){
		db_query("UPDATE `{$data['DbPrefix']}clientid_table` set `active`=0,`status`=0 WHERE `id`='$gid'");
		json_log_upd($gid,'clientid_table','suspend'); // for json log history
		$_SESSION['action_success_merchant']='Profile has been suspended.';
		header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=$gid&action=detail");
		exit;
	}
}

/*
$_SESSION['get_mid_array'][]=368;
$_SESSION['get_mid']=implode(",",$_SESSION['get_mid_array']);
echo "<br/>get_mid_array=>";
print_r($_SESSION['get_mid_array']);
*/

if(isset($post['action'])&&$post['action']=='detail')
{

	if(((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All'))){
		if(!in_array($post['gid'],$_SESSION['get_mid_array'])){
			echo('ACCESS DENIED..');
			exit;
		}
	}
	
	$post['MemberInfo']=get_clients_info($post['gid']);
	$_SESSION['MemberInfo']=$post['MemberInfo'];
	
	$_SESSION['generate_private_'.$post['MemberInfo']['id']]=$post['MemberInfo']['private_key'];
	
	
	$data['SpoMultiple']=get_sponsors($post['gid'],'');
	
	
	//$post['MemberInfo']['email']=prnclientsemails($post['gid']);
	if(isset($post['MemberInfo']['sponsor'])&&$post['MemberInfo']['sponsor']){
		$associate=get_sponsors('',$post['MemberInfo']['sponsor']);
		$post['MemberInfo']['associate_info']=$associate[$post['MemberInfo']['sponsor']];
	}else $post['MemberInfo']['semail']='N/A';
	
	
	$id=($post['gid']?$post['gid']:$_GET['id']);
	
	##### for payin setting get ###################
	$payin_setting_get=$post['PayinInfo']=select_tablef("`clientid`='{$id}'","payin_setting");
	/*
	if(isset($payin_setting_get)&&$payin_setting_get) $post=array_merge($post,$payin_setting_get);
	if(isset($_POST)&&$_POST) $post=array_merge($post,$_POST);
	*/
	
	##### for softpos setting get ###################
	$softpos_setting_get=$post['SoftposInfo']=select_tablef("`clientid`='{$id}'","softpos_setting");
	
	
	##### for payout setting get ###################
	$post['PayoutInfo']=select_tablef("`clientid`='{$id}'","payout_setting");
	
	
		
	//check risk ----------------------------
	$post['account_type_check']=(isset($post['check_ratio'])?$post['check_ratio']:0);
	$post['check_total_ratio']=(isset($post['check_ratio']['total_ratio'])?$post['check_ratio']['total_ratio']:0);
	$post['check_retrun_count']=(isset($post['check_ratio']['retrun_count'])?$post['check_ratio']['retrun_count']:0);
	$post['check_completed_and_settled']=(isset($post['check_ratio']['completed_and_settled'])?$post['check_ratio']['completed_and_settled']:0);
	$post['check_lead_class']=(isset($post['check_ratio']['lead_class'])?$post['check_ratio']['lead_class']:'');
	$post['check_lead_color']=(isset($post['check_ratio']['lead_color'])?$post['check_ratio']['lead_color']:'');
	$post['check_completed']=(isset($post['check_ratio']['completed_count'])?$post['check_ratio']['completed_count']:0);
	$post['check_settled']=(isset($post['check_ratio']['settled_count'])?$post['check_ratio']['settled_count']:0);
	$post['check_risk_type']=(isset($post['check_ratio']['risk_type'])?$post['check_ratio']['risk_type']:0);
			
			
			
	//card risk ----------------------------
	$post['account_type_card']=(isset($post['card_ratio'])?$post['card_ratio']:0);
	//print_r($post['card_ratio']);
	
	$post['card_total_ratio']=(isset($post['card_ratio']['total_ratio'])?$post['card_ratio']['total_ratio']:0);
	$post['card_total_ratio_bar']=(isset($post['card_ratio']['total_ratio'])?($post['card_ratio']['total_ratio']*5):0);
	
	$post['card_retrun_count']=(isset($post['card_ratio']['retrun_count'])?$post['card_ratio']['retrun_count']:0);
	$post['card_completed_and_settled']=(isset($post['card_ratio']['completed_and_settled'])?$post['card_ratio']['completed_and_settled']:0);
	$post['card_lead_class']=(isset($post['card_ratio']['lead_class'])?$post['card_ratio']['lead_class']:'');
	$post['card_lead_color']=(isset($post['card_ratio']['lead_color'])?$post['card_ratio']['lead_color']:'');
	$post['card_completed']=(isset($post['card_ratio']['completed_count'])?$post['card_ratio']['completed_count']:0);
	$post['card_settled']=(isset($post['card_ratio']['settled_count'])?$post['card_ratio']['settled_count']:0);
	$post['card_risk_type']=(isset($post['card_ratio']['risk_type'])?$post['card_ratio']['risk_type']:0);

		
	//$post['kycSclt']=sel_verifi($post['gid'],1,'clientid_table');
	//$post['kycList']=sel_verifi($post['gid'],0,'clientid_table');

}
###############################################################################
if(isset($post['action'])&&$post['action']=='select'){
		$data['MaxRowsByPage']=50;
		$status=(isset($post['type'])&&$post['type']=='active'?1:0);
		if(isset($post['type'])&&$post['type']=='closed'){ $status=2;}
		if(isset($post['type'])&&$post['type']=='submerchant'){ $status=5;}
		if(isset($_GET['keyword'])&&$_GET['keyword']<>''){ $status=6;}
		//condation for Payout Merchant Added By Vikash 08-09-2022
		if(isset($post['type'])&&$post['type']=='live'){ $status=7;}
		if(isset($post['type'])&&$post['type']=='test'){ $status=8;}
		if(isset($post['type'])&&$post['type']=='inactive'){ $status=9;}
		//if(!$post['order']){$post['order']=1;}
		
		//echo "==========";exit;
			
	if (isset($_GET['keyword'])){
		$post['keyword']=$_GET['keyword'];
	}
	if (isset($_GET['sfield'])){
		$post['sfield']=$_GET['sfield'];
	}
	if (isset($post['keyword']) && !empty($post['keyword']) && isset($post['sfield']) && !empty($post['sfield'])) {
		$fieldname = "`fullname`";
		switch ($post['sfield']) {
			case "un":
			$fieldname = "`username`";
			break;
			case "em":
			$fieldname = "`registered_email`";
			break;
			case "vid":
			$fieldname = "`id`";
			break;
			case "fn":
			$fieldname = "`fullname`";
			break;
			case "ln":
			$fieldname = "`lname`";
			break;
			case "cn":
			$fieldname = "`company_name`";
			break;
			case "we":
			$fieldname = "`drvnum`";
			break;
		}
		
		if(@$post['sfield']=='em'&&@$post['keyword']) 
			$post['keyword']=encrypts_decrypts_emails($post['keyword'],1);
			
	}
///=========================================
		
		
		
		
		// Create Array for CN and CH 
		$cn=$ch=$data['acquirer_id'];
		
		
		$join=$where='';

		
		if((isset($_GET['ac']))&&($_GET['ac']==1)){
			$join = " right join `{$data['DbPrefix']}mer_setting` on ";
			$join.= " `{$data['DbPrefix']}mer_setting`.`merID`=`{$data['DbPrefix']}clientid_table`.`id` ";
			$where	= " AND (m.`id`=`{$data['DbPrefix']}mer_setting`.`merID`) AND ";
			$where .= " (merID in ( select merID from `{$data['DbPrefix']}mer_setting` as t1 WHERE t1.`acquirer_id` ";
			$where .= " IN ($cn)) AND merID NOT IN (select merID from `{$data['DbPrefix']}mer_setting` as t1 ";
			$where .= " WHERE t1.acquirer_id IN ($ch) ))";
		}// end if -Filter Card USER_FOLDER
		
		// Filter Check USER_FOLDER
		if((isset($_GET['ac']))&&($_GET['ac']==0)){
			$join = " right join `{$data['DbPrefix']}mer_setting` on ";
			$join.= " `{$data['DbPrefix']}mer_setting`.`merID`=`{$data['DbPrefix']}clientid_table`.`id` ";
			$where	= " AND (m.`id`=`{$data['DbPrefix']}mer_setting`.`merID`) AND ";
			$where .= " (merID NOT IN ( select merID from `{$data['DbPrefix']}mer_setting` as t1 WHERE t1.`acquirer_id` ";
			$where .= " IN ($cn)) AND merID IN ( select merID from `{$data['DbPrefix']}mer_setting` as t1 ";
			$where .= " WHERE t1.acquirer_id IN ($ch) ))";
		}// end if -Filter Check USER_FOLDER
		
		
		// Filter Common USER_FOLDER only
		if((isset($_GET['ac']))&&($_GET['ac']==2)){
			$join = " right join `{$data['DbPrefix']}mer_setting` on ";
			$join.= " `{$data['DbPrefix']}mer_setting`.`merID`=`{$data['DbPrefix']}clientid_table`.`id` ";
			$where	=" AND (`{$data['DbPrefix']}clientid_table`.`id`=`{$data['DbPrefix']}mer_setting`.`merID`)";
			$where .= "AND (merID in ( select merID from `{$data['DbPrefix']}mer_setting` as t1 WHERE ";
			$where .= " t1.`acquirer_id` IN ($cn) ) AND merID in ( select merID ";
			$where .= " from `{$data['DbPrefix']}mer_setting` as t1 WHERE t1.acquirer_id IN ($ch) )) ";			
		}// End If -Filter both (Card & Check) USER_FOLDER
	
		//Declare HEADING String for header file, but I think no any use of data string 
		$data['string']='';
		if((isset($_GET['ac']))&&($_GET['ac']==0)){$data['string']="'ONLY CARD' ";}
		if((isset($_GET['ac']))&&($_GET['ac']==1)){$data['string']="'ONLY E-CHECK'";}
		if((isset($_GET['ac']))&&($_GET['ac']==2)){$data['string']="'ONLY COMMON (E-CHECK & CARD)' ";}
		
		
		// Replace TABLE name with string m for Member list query
		$where=str_replace("`{$data['DbPrefix']}clientid_table`.","m.",$where);
		$join=str_replace("`{$data['DbPrefix']}clientid_table`.","m.",$join);
	
		if(isset($_GET['order'])&&($_GET['order']>0)){
			$data['USER_FOLDERCount']=get_clients_count($status,$_GET['order'],$join,$where);
		}elseif(isset($_GET['store_active'])&&$_GET['store_active']){
			$data['USER_FOLDERCount']=get_clients_count($status,@$_GET['order'],$join,$where,$_GET['store_active']);
		}else{
			//echo $status." || ".$join." || ".$where;
			// echo $post['type'];
			if(isset($post['type'])&&$post['type']=='submerchant'){
				$data['USER_FOLDERCount']=get_clients_count($status,0,$join,$where=' AND sub_client_id is NOT NULL ');	//Pass AND sub_client_id is NULL By Vikash
			}else{
				$data['USER_FOLDERCount']=get_clients_count($status,0,$join,$where=' AND sub_client_id is NULL ');	//Pass AND sub_client_id is NULL By Vikash
			}
		}

		$data['clients_count']=$data['USER_FOLDERCount'];
		for($i=0; $i<$data['USER_FOLDERCount']; $i+=$data['MaxRowsByPage'])$data['Pages'][]=$i;
		if(isset($post['order'])&&$post['type']=='online'){
			$data['clientsList']=get_clients_listf(1, $post['StartPage'], $data['MaxRowsByPage'], true, $post['order']);
		}elseif(isset($post['type'])&&$post['type']=='online'){
			$data['clientsList']=get_clients_listf(1, $post['StartPage'], $data['MaxRowsByPage'], true);
		}elseif(isset($_GET['store_active'])&&$_GET['store_active']){
			$data['clientsList']=get_clients_listf($status, $post['StartPage'], $data['MaxRowsByPage'],0,0,$join,$where,$_GET['store_active']);
		}elseif(isset($post['type'])&&$post['type']=='closed'){
			$data['clientsList']=get_clients_listf(2, $post['StartPage'], $data['MaxRowsByPage']);
		}elseif(isset($post['order'])&&!empty($post['order'])){
			$data['clientsList']=get_clients_listf($status, $post['StartPage'],$data['MaxRowsByPage'], false, $post['order']);
		}else{
			if(isset($post['keyword'])&&trim($post['keyword']) && trim($fieldname)){
				$pkeyword=trim($post['keyword']);
				$fieldname;
				$where.=" AND CONVERT(`m`.{$fieldname} USING utf8) LIKE '%{$pkeyword}%' ";
				$status=6; 
			}
			$data['clientsList']=get_clients_listf
			($status, $post['StartPage'], $data['MaxRowsByPage'],0,0,$join,$where);
			//($active=0, $start=0, $count=0, $online=false, $order=0,$join='',$where='')
		}
	/*
	
	$data['ind_Count']=get_clients_count_where_pred(" `user_type`=1 OR `user_type`=0 ");
	$data['bus_Count']=get_clients_count_where_pred(" `user_type`=2");
	$data['app_Count']=get_clients_count_where_pred(" `user_permission`=1");
	$data['unap_Count']=get_clients_count_where_pred(" `user_permission`=2");
	
	*/
		
}

/*if($post['type']=='block')
{
	 $data['ipaddressList']=get_ipaddress_list( );
}
*/
###############################################################################
else if(isset($post['action'])&&$post['action']=='search'){
	$data['PageFile']='search';
	$data['PageName']='MERCHANT SEARCH';
	
	if (isset($_GET['keyword'])){
		$post['keyword']=$_GET['keyword'];
	}
	if (isset($_GET['sfield'])){
		$post['sfield']=$_GET['sfield'];
	}
	if (isset($post['keyword']) && !empty($post['keyword']) && isset($post['sfield']) && !empty($post['sfield'])) {
		$fieldname = "lname";
		switch ($post['sfield']) {
		case "un":
			$fieldname = "username";
			break;
		case "em":
			$fieldname = "email";
			break;
		case "uid":
			$fieldname = "id";
			break;
		case "fn":
			$fieldname = "fname";
			break;
		case "ln":
			$fieldname = "lname";
			break;
		case "cn":
			$fieldname = "company_name";
			break;
		case "we":
			$fieldname = "drvnum";
			break;
		}
		$post['action'] = 'select';
		$post['type'] = 'found';
		$select=$join=$where='';
		//$data['PageFile']='clients';
		//$data['PageFile']='clients_test';
		$data['PageFile']='merchant_list';
		if($post['sfield']=="uid"){
			$where_pred = " `id`={$post['keyword']} ";
		}elseif($post['sfield']=="ind"){
			$where_pred = " `user_type`=1 OR `user_type`=0 ";
		}elseif($post['sfield']=="bus"){
			$where_pred = " `user_type`=2 ";
		}elseif($post['sfield']=="app"){
			$where_pred = " `user_permission`=1 ";
		}elseif($post['sfield']=="unapp"){
			$where_pred = " `user_permission`=2 ";
		}else{
			$where_pred = " UPPER(`$fieldname`) LIKE UPPER('%{$post['keyword']}%') ";
		}
	
		if(isset($_GET['sfield'])){$keyname=$_GET['sfield'];}
		//if(isset($_GET['searchkey'])){$searchkey=trim($_GET['searchkey']);$searchkey=strtolower($searchkey);}
		if(isset($post['keyword'])){$searchkey=trim($post['keyword']);$searchkey=strtolower($searchkey);}
	
		if($keyname==312||$keyname=='tTerNO'){ // terminal Id
			$query="select `merID` from `{$data['DbPrefix']}terminal` WHERE `id`='".$searchkey."' LIMIT 1";
			$queryrs=db_rows($query,0);
			$merID=$queryrs[0]['merID'];
			header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?bid=".$searchkey."&id=".$merID."&action=update_terminals&search_key={$searchkey}&key_name=m_{$keyname}");exit;
		}
		elseif($keyname=='merID'){ // admin merchant 
			if(!isset($_SESSION['test_merchant']))
			{
				$test_merchant=$_SESSION['test_merchant']=select_tablef(" `active`='1' AND `status`='2' AND `sub_client_id` IS NULL  ORDER BY `id` ASC  ",'clientid_table',0,1,"`username`,`id`,`default_currency`,`private_key`");
			}
			//print_r($_SESSION['test_merchant']);exit;
			header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?id=".$_SESSION['test_merchant']['id']."&action=detail&type=active&search_key={$searchkey}&key_name=m_{$keyname}");exit;
		}
		elseif($keyname==313||$keyname=='tbu'){ // Terminal Business URL
			$query="select `id`,`merID` from `{$data['DbPrefix']}terminal` WHERE ( lower(`bussiness_url`) LIKE '%".$searchkey."%' ) LIMIT 1";
			$queryrs=db_rows($query,0);
			$merID=$queryrs[0]['merID'];
			header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?bid=".$queryrs[0]['id']."&id=".$merID."&action=detail&tab_name=collapsible3&search_key={$searchkey}&key_name=m_{$keyname}");
			exit;
		}
		elseif($keyname==314||$keyname=='tdba'){ // DBA/Brand Name
			$query="select `id`,`merID` from `{$data['DbPrefix']}terminal` WHERE ( lower(`dba_brand_name`) LIKE '%".$searchkey."%' ) LIMIT 1";
			$queryrs=db_rows($query);
			$merID=$queryrs[0]['merID'];
			header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?bid=".$queryrs[0]['id']."&id=".$merID."&action=update_terminals&search_key={$searchkey}&key_name=m_{$keyname}");exit;
		}
		elseif($keyname==315||$keyname=='tnem'){ // Transaction Notification/Customer Service Email
			
			$searchkey_2 = encode_f(@$searchkey);
			 
			$query="SELECT `id`,`merID` from `{$data['DbPrefix']}terminal` WHERE ( lower(`mer_trans_alert_email`) LIKE '%".$searchkey_2."%' ) OR ( lower(`customer_service_email`) LIKE '%".$searchkey_2."%' ) LIMIT 1";
			$queryrs=db_rows($query,0);
			$merID=$queryrs[0]['merID'];
			header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?bid=".$queryrs[0]['id']."&id=".$merID."&action=update_terminals&search_key={$searchkey}&key_name=m_{$keyname}");
			exit;
		}
		elseif($keyname==311){
			$searchkey_enc = encode_f($searchkey);
			$select="SELECT `{$data['DbPrefix']}clientid_table`.`id` FROM `{$data['DbPrefix']}clientid_table`";
			$join=" left join `{$data['DbPrefix']}clientid_emails` on ";
			$join .=" (`{$data['DbPrefix']}clientid_table`.`id`=`{$data['DbPrefix']}clientid_emails`.`clientid`) ";
			$where =" WHERE ( ( `{$data['DbPrefix']}clientid_emails`.`email` LIKE '%{$searchkey_enc}%' ) OR ";
			$where .=" ( `{$data['DbPrefix']}clientid_table`.`registered_email` LIKE '%{$searchkey_enc}%' ) ) ";
			$where .=" group by `{$data['DbPrefix']}clientid_table`.`id`";
			$query=$select.$join.$where;
			
			$clientsid=db_rows($query);
			$clientsid=$clientsid[0]['id'];
			
			header("Location: {$data['Admins']}/{$data['my_project']}{$data['ex']}?id=".$clientsid."&action=detail&type=active&page=0");
		//header("Location:{$data['Admins']}/{$data['my_project']}{$data['ex']}?action=search&keyword=".$searchkey."&sfield=em&searchkey=".$searchkey);
		
			exit;
		}
	
		if (($fieldname == "email")&($post['sfield']=='em')){
			$searchkey_enc = encode_f($searchkey);
			$join=" left join `{$data['DbPrefix']}clientid_emails` on ";
			$join .=" (`{$data['DbPrefix']}clientid_table`.`id`=`{$data['DbPrefix']}clientid_emails`.`clientid`) ";
			$where =" ( (`{$data['DbPrefix']}clientid_emails`.`email` LIKE '%{$searchkey_enc}%' ) OR ";
			$where .=" (`{$data['DbPrefix']}clientid_table`.`registered_email` LIKE '%{$searchkey_enc}%' ) ) ";
			$where .=" group by `{$data['DbPrefix']}clientid_table`.`id`";
			$where_pred=$where;
		}		
		//$data['USER_FOLDERCount']=get_clients_count_where_pred($where_pred, $join);
		//for($i=0; $i<$data['USER_FOLDERCount']; $i+=$data['MaxRowsByPage'])$data['Pages'][]=$i;

		//$data['clientsList']=get_clients_list_where_pred($post['StartPage'], $data['MaxRowsByPage'], $where_pred, $join);
		$data['result_count']=$data['clients_count'];
		$data['USER_FOLDERCount']=$data['clients_count'];
	}
}
############################################################################### 
/*
$data['ind_Count']=get_clients_count_where_pred(" `user_type`=1 OR `user_type`=0 ");
$data['bus_Count']=get_clients_count_where_pred(" `user_type`=2");
$data['app_Count']=get_clients_count_where_pred(" `user_permission`=1");
$data['unap_Count']=get_clients_count_where_pred(" `user_permission`=2");

*/

//$data['SystemBalance']=select_balance(-1);
###############################################################################

//showselect($data['Sponsors'], $post['multiple_subadmin_ids'],1);exit;

if($qp){	
	$data['msc2'] = microtime(true)-$data['msc_start'];
	echo("-->2 php mySql Query took ".(microtime(true) * 1000)." ms | ".(format_periodf($data['msc2']))."<--<hr/>");
}

display('admins');

if($qp){
	$data['msc3'] = microtime(true)-$data['msc_start'];
	echo("<hr/>-->3 HTML UI took ".($data['msc3'] * 1000)." ms | ".(format_periodf($data['msc3']))."<--<hr/>");
}
###############################################################################
?>