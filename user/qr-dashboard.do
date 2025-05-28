<?
$data['PageName']	= 'QR Dashboard';
$data['PageFile']	= 'qr_dashboard';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'QR Dashboard - '.$data['domain_name']; 
##########################Check Permission#####################################
// Page for Payout Merchant dashboard 
###############################################################################

if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);
	echo('ACCESS DENIED..');
	exit;
}

// For store session before loading header
if(($data['PageFile']=='qr_dashboard') && (isset($_REQUEST['act'])&&$_REQUEST['act']=="1")){
	$_SESSION['dashboard_type']="qrcode-dashboard";
}


$post=select_info($uid, $post);

// For Check Page view Permission
include_once $data['Path'].'/include/qr-code-request'.$data['iex'];

###############################################################################

if(!isset($post['step']) || !$post['step'])$post['step']=1;
$post['Buttons']=get_files_list($data['SinBtnsPath']);

//$post=select_info($uid, $post);
//print_r($post);

//if(!isset($post['step']) || !$post['step'])$post['step']=1;


##############################################################################
// For Display Website List on Box



	$ac_nos=getQrAcquirerList();	//fetch list of account mapped with 10-QR India	
	$post['products']=select_terminals($uid,0,0,1);
	
	$acc_array=explode(',',$ac_nos);
//	print_r($acc_array);exit;
	
	$post['products1']=array();
	$exist_store=array();
	$i=0;
	foreach($acc_array as $acc_val) 
	{
		foreach($post['products'] as $key=>$value){
			
			$midcard=$value['acquirerIDs'];
			$temp_array =explode(',',$midcard);
			if(in_array($acc_val,$temp_array))
			{
				if(!in_array($value['id'],$exist_store))
				{
					$post['products1'][$i]['id']	=$value['id'];
					$post['products1'][$i]['name']	=$value['ter_name'];
					
					$exist_store[]=$value['id'];
					$i++;
				}
			}
		}
	}
	unset($i);


##############################################################################	


$sql_query="";
if($ac_nos) $sql_query =" AND `acquirer` in ({$ac_nos}) ";

if(isset($_REQUEST['wid'])&&$_REQUEST['wid']) $sql_query .=" AND `terNO` = '{$_REQUEST['wid']}'";

$sqlStmt	= "SELECT COUNT(`id`) as `ct` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE 1 $sql_query";
$result_ct	= db_rows($sqlStmt,0);
$data['total_record']= $result_ct[0]['ct'];

$sqlStmt	= "SELECT COUNT(`id`) as `ct` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE 1 $sql_query AND ( `trans_status` IN (1,7) )";
$result_ct	= db_rows($sqlStmt,0);
$data['total_success']= $result_ct[0]['ct'];


###############################################################################
if($data['2FA_ENABLE']=='Y')
{
	if($post['google_auth_code']=='') {
		header("Location:{$data['USER_FOLDER']}/two-factor-authentication{$data['ex']}");exit;
	}
	elseif(($post['google_auth_access']==1||$post['google_auth_access']==3)&&($post['google_auth_code'])) {
		$data['withdraw_gmfa']=1;
		$_SESSION['google_auth_code']=$google_auth_code=$post['google_auth_code'];
		$google_auth_access=$post['google_auth_access'];
		$authenticat_msg='and successfully authenticated';
	}
}
################
display('user');
################
?>