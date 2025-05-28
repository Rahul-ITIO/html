<?
$data['PageName']	= 'Beneficiary List';
$data['PageFile']	= 'beneficiary_list';

###############################################################################
include('../config.do');
$data['PageTitle'] = $data['PageName'].' - '.$data['domain_name'];
###############################################################################

if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['sub_admin_id']))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['slogin']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
//check payout folder exists or not - 
$payout_button=($data['Path']."/payout/template.admin_payout_button".$data['iex']);
if(!file_exists($payout_button)){	//If payout not exist then showing Admin' index page
	header("Location:{$data['slogin']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}


if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])||!$post['step']){$post['step']=1; }

###############################################################################
if(isset($post['action'])&&($post['action']=='approved')){
	if(isset($post['bid'])&&$post['bid']){
		$gid = $post['bid'];
		$mid = @$post['mid'];
		
		if(isset($_GET['mid'])) $mid = $_GET['mid'];

		if($gid){
		
			$sqlStmt = "UPDATE `{$data['DbPrefix']}payout_beneficiary` SET `status`='1' WHERE `id`='{$gid}' AND `clientid`='{$mid}'";
	
			//echo $sqlStmt;exit;
	
			db_query_2($sqlStmt);
		}
		$_SESSION['action_success']='Beneficiary permtted successfully !!';
		header("location:{$data['Admins']}/beneficiary_list".$data['ex']);exit;
	}
}
elseif(isset($post['action'])&&($post['action']=='fail')){
	if(isset($post['bid'])&&$post['bid']){
		$gid = $post['bid'];
		$mid = $post['mid'];
		
		if(isset($_GET['mid'])) $mid = $_GET['mid'];

		db_query_2(
			"UPDATE `{$data['DbPrefix']}payout_beneficiary`".
			"SET status=2 WHERE `id`='{$gid}' AND `clientid`='{$mid}'",0);

		$_SESSION['Error']='Beneficiary rejected!!';
		header("location:{$data['Admins']}/beneficiary_list".$data['ex']);exit;
	}
}

if($post['step']==1){

	$data['MaxRowsByPage']=50;
	
	if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}

	$data['startPage'] = $page;
	$start	= ($page-1)*$data['MaxRowsByPage'];
	$end	= $data['MaxRowsByPage'];
	
	$limit	= " LIMIT $start, $end";

	if($data['connection_type']=='PSQL'&&!empty(trim($limit))) 
	{
		$limit= ' LIMIT '.$end.' OFFSET '.$start;
	}
	
	$sql_query		="";

	$whereClause=array();
	if(isset($_GET['bene_id'])&&$_GET['bene_id'])
	{
		$data['bene_id'] = $_GET['bene_id'];
		$whereClause[] = "bene_id='{$data['bene_id']}'";
	}
	if(isset($_GET['beneficiary_name'])&&$_GET['beneficiary_name'])
	{
		$data['beneficiary_name'] = $_GET['beneficiary_name'];
		$whereClause[] = "beneficiary_name LIKE '%{$data['beneficiary_name']}%'";
	}
	if(isset($_GET['account_number'])&&$_GET['account_number'])
	{
		$data['account_number'] = $_GET['account_number'];
		$whereClause[] = "account_number='{$data['account_number']}'";
	}
	if(isset($_GET['bank_name'])&&$_GET['bank_name'])
	{
		$data['bank_name'] = $_GET['bank_name'];
		$whereClause[] = "bank_name LIKE '%{$data['bank_name']}%'";
	}
	if(isset($_GET['bank_code'])&&$_GET['bank_code'])
	{
		$data['bank_code'] = $_GET['bank_code'];
		$whereClause[] = "(bank_code1 LIKE '%{$data['bank_code']}%' OR bank_code2 LIKE '%{$data['bank_code']}%' OR bank_code3 LIKE '%{$data['bank_code']}%')";
	}
	
	if(count($whereClause))
	{
		$sql_query = implode(" AND ", $whereClause);
		$sql_query = ' WHERE '.$sql_query;
	}
	$sqlStmt	= "SELECT count(id) as ct FROM `{$data['DbPrefix']}payout_beneficiary` $sql_query";
	$result_ct	= db_rows_2($sqlStmt,0);
	$data['total_record']= $result_ct[0]['ct'];

	$sqlStmt = "SELECT * FROM `{$data['DbPrefix']}payout_beneficiary` $sql_query ORDER BY `beneficiary_name` $limit";
	$result_select= db_rows_2($sqlStmt,0);
	$post['bene_list'] = $result_select;

	$data['cntdata']=count($post['bene_list']);
	
	$data['rec_start']	=$start+1;
	$data['rec_end']	=(($data['cntdata']<$data['MaxRowsByPage'])?($start+$data['cntdata']):($start+$data['MaxRowsByPage']));
}
###############################################################################

display('admins');

###############################################################################

?>