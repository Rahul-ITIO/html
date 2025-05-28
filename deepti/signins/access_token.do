<?

$data['PageName']	= 'Access Token Of Transaction';
$data['PageFile']	= 'transaction_reason';

$data['rootNoAssing']=1; 
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

function get_reasontr_details($uid, $action='list', $post=array()){
	global $data;

	$limit = "";
	if(isset($data['MaxRowsByPage'])&&isset($data['startPage']))
	{
		$start = ($data['startPage']-1)*$data['MaxRowsByPage'];
		$limit = " LIMIT $start, ".$data['MaxRowsByPage'];
	}
	
	$qprint=0;
	if(isset($_REQUEST['qp'])) $qprint=1;
	
	if(!empty($uid)) $q = "`category`='{$uid}' AND "; else $q="";

	if($action=='list_all')
	{	
		$q="";
		$sh="status_nm";
		$mo="";
		
		if(isset($post['simple_search'])&&isset($post['key'])&&isset($post['key_name'])&&$post['key']&&$post['key_name']){
			
			$kn=stf($post['key_name']); 
			$key_txt=prntext($post['key']);
			
			
			if (preg_match("/^[1-9][0-9]*$/", $key_txt)) {
				$key=$key_txt;
			}else{
				$key=strtolower($key_txt);
			}
			//$qprint=1;
			$like_qr=0;
			if($kn=='status_nm'){
				if(preg_match("/[a-z]/i", $key)){
					$like_qr=1;
					$kn='status';
				}
			}
			//echo "<br/>kn=>".$kn;
			
			if($kn=='reason' || $kn=='new_reasons' || $like_qr ){
				$where_pre=" ( lower(`{$kn}`) LIKE '%".$key."%' ) ";
			}else{
				$where_pre=" `{$kn}` IN ('{$key}') "; 
			}
			$q = " WHERE " . $where_pre;
			
			//echo "<br/>q=>".$q;
			
		}
		else{
			if(isset($_REQUEST['s'])&&!empty($_REQUEST['s'])){
				//$q = "WHERE 1 ";
				$sh=$_REQUEST['s'];
			}
			
			if(isset($_REQUEST['m'])&&!empty($_REQUEST['m'])&&$_REQUEST['m']==1){
				$mo=' ASC ';
			}
			if(isset($_REQUEST['m'])&&!empty($_REQUEST['m'])&&$_REQUEST['m']==2){
				$mo=' DESC ';
			}
		}
		

		if($limit)
		{
			$countQ=db_rows(
				"SELECT count(id) AS count FROM `{$data['DbPrefix']}reason_table`".
				" $q ORDER BY {$sh} LIMIT 1",$qprint
			);
			$data['total_record'] = $countQ[0]['count'];
		}

		$result=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}reason_table`".
			" $q ORDER BY {$sh} {$mo} ".$limit,$qprint
		);
		return $result;
	}
	elseif($action=='addnew')
	{
		$id=($post['gid']?$post['gid']:$_GET['id']);
		
		if(isset($id)&&$id>0){
			
			$sqlStmt = "UPDATE `{$data['DbPrefix']}reason_table` SET `category` ='{$post['category']}', `status_nm`='{$post['status_nm']}', `reason`='{$post['reason']}', `new_reasons`='{$post['new_reasons']}', `status`='{$data['TransactionStatus'][$post['status_nm']]}' WHERE `id`='{$id}'";
			db_query($sqlStmt,$qprint);
				
			json_log_upd($id,'reason_table'); // for json log history	
			$result = "Successfully record are updated";
			$_SESSION['action_success']="Successfully record are updated";
		}else{
			$result=db_query(
				"INSERT INTO `{$data['DbPrefix']}reason_table`(".
				"`category`,`status_nm`,`reason`,`new_reasons`,`status`".
				")VALUES(".
				"'{$post['category']}','{$post['status_nm']}','{$post['reason']}','{$post['new_reasons']}','{$data['TransactionStatus'][$post['status_nm']]}'".
				")",$qprint
			);
			$newid=newid();
			json_log_upd($newid,'reason_table'); // for json log history
			$result = "Successfully new record inserted";
			$_SESSION['action_success']="Successfully new record inserted";
		}
		
		
	
		return $result;
	
	}
	
	return;
}

if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])||!$post['step']){$post['step']=1; }

###############################################################################

if(isset($_REQUEST['send'])&&($_REQUEST['send']=='add_data')){
	$post['step']=2;
	if(isset($post['gid'])&&$post['gid']&&$post['gid']>0){
		$get_row=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}reason_table`".
			" WHERE `id`='{$post['gid']}' LIMIT 1",0
        );
		$post=array_merge($post,$get_row[0]);
		//print_r($post);
	}	
}

if(isset($post['action'])&&($post['action']=='insert_reasontr')){
//print_r($post);exit;
	if(isset($_POST['status_nm'])){
		$post['status_nm']=$_POST['status_nm'];
	}
	
	if(empty($post['category'])){
		$data['error']="You did not select category.";
	} 
	elseif(!isset($post['status_nm'])){
		$data['error']="You did not select status.";
	}
	
	elseif(empty($post['reason'])){
		$data['error']="You did not entered reason value.";
	} 
	elseif(empty($post['new_reasons'])){
		$data['error']="You did not entered new reasons value.";
	} 
	
	/*elseif(isset($post['source'])&&$post['source']=='admin' && empty($post['merchant_list_id'])){
		$data['error']="You did not select Merchant.";
	}*/
	else
	{
			$result=get_reasontr_details(0, 'addnew', $post);
			
			if($result=='SUCCESS')
			$_SESSION['action_success']="Your data has been addedd successfully";
			else 
				$_SESSION['action_error']=$result;
			header("Location:{$data['Admins']}/transaction_reason".$data['ex']."?step=1");exit;
		}

	
}

elseif($post['action']=='delete_reasontrs'){
	if(isset($post['gid'])&&$post['gid']&&$post['gid']>0)
	{
		
  $dresult=db_rows("SELECT * FROM `{$data['DbPrefix']}reason_table` WHERE `id`='{$post['gid']}'",0);
  $data['JSON_INSERT']=1;
  json_log_upd($post['gid'],'reason_table','Delete',$dresult,'');

		$sqlStmt = "DELETE FROM `{$data['DbPrefix']}reason_table` WHERE  `id`='{$post['gid']}'";
		db_query($sqlStmt,0);
		
		
		if(isset($data['affected_rows'])&&$data['affected_rows']){ $_SESSION['action_success']="Successfully Deleted";}
		header("Location:{$data['Admins']}/transaction_reason".$data['ex']."?step=1&gid=0");exit;
	}
}

if($post['step']==1){
	$data['MaxRowsByPage']=50;

	if(isset($_GET['page'])&&$_GET['page']) $page  = $_GET['page'];
	else $page  = 1;

	$data['startPage']	=$page;
	$post['result_list'] = get_reasontr_details(0, 'list_all',$post);
}

$data['m']=2;// DESC 
if(isset($_REQUEST['m'])&&!empty($_REQUEST['m'])&&$_REQUEST['m']==1){
	$data['m']=2;// DESC 
}
if(isset($_REQUEST['m'])&&!empty($_REQUEST['m'])&&$_REQUEST['m']==2){
	$data['m']=1;// ASC 
}

###############################################################################

display('admins');

###############################################################################

?>