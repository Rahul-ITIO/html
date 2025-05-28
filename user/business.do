<?
###############################################################################
$data['PageName']='Business';
$data['PageFile']='business';
$data['PageFileName']='business';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'My Business - '.$data['domain_name']; 
##########################Check Permission#####################################
if((isset($_SESSION['m_clients_role']) &&$_SESSION['m_clients_role'])?$_SESSION['m_clients_role']:'');
if((isset($_SESSION['m_clients_type']) &&$_SESSION['m_clients_type'])?$_SESSION['m_clients_type']:'');
/*if(!clients_page_permission('8',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }*/

if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('8',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################
if((strpos($data['urlpath'],$data['MYWEBSITEURL'])!==false)||($data['MYWEBSITEURL'])){
	$data['PageName']=$data['MYWEBSITE'];
	$data['PageFileName']=$data['MYWEBSITEURL'];
	//$data['PageFile']=$data['MYWEBSITEURL'];
	$data['PageTitle'] = 'My '.$data['MYWEBSITE'].' - '.$data['domain_name'];
	$data['FileName']=$data['PageFile'].$data['ex'];
	
}



###############################################################################
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']); echo('ACCESS DENIED.'); exit;
}
$is_admin=false;
if(isset($_SESSION['adm_login'])&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$post['bid'];
	$_SESSION['login']=$uid;
}
$post['is_admin']=$is_admin;
if(is_info_empty($uid)){
	$get_q='';if(isset($_GET)){$get_q="?".http_build_query($_GET);}
	header("Location:{$data['Host']}/user/profile{$data['ex']}{$get_q}");
	echo('ACCESS DENIED.');
	exit;
}

if((strpos($data['urlpath'],"new_store")!== false)){
	$post['New Store']=1;
	$post['step']=2;
	$data['PageTitle'] = "Add New {$data['PageName']} - ".$data['domain_name'];
	$data['PageName']="Add New {$data['PageName']}";
}elseif((strpos($data['urlpath'],"new_".$data['MYWEBSITEURL'])!== false)){
	$post['New Store']=1;
	$post['step']=2;
	$data['PageTitle'] = "Add New {$data['MYWEBSITE']} - ".$data['domain_name'];
	$data['PageName']="Add New {$data['MYWEBSITE']}";
}

if(isset($post['action'])&&$post['action']=='transcount'){
	$psold=select_sold($uid,$_REQUEST['id']);
	$post1['solds']=$psold['sold'];
	$post1['counts']=$psold['count'];
	$post['asold']="<a href='{$data['USER_FOLDER']}/transactions{$data['ex']}?keyname=115&searchkey={$_REQUEST['id']}' target='_blank' >{$post1['counts']} Times<br/><font class=remark>({$post1['solds']})</font></a>";
	echo($post['asold']);
	exit;
}


function templatesf($pst){
	global $data; $qp=0;
	if(isset($_GET['qp'])){
		$qp=1;
	}

	//print_r($pst);
	
	$pt_slc=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}acquirer_group_template`".
		" WHERE `id`={$pst['tid']} LIMIT 1",0
	);
	
	$tid_get=$pt_slc[0]['tid'];
	$tid=explode(",",$tid_get);
	if($qp){
		echo $tid_get;
	}
	$pre_created=array(); $pre_created_nm=array();  $new_created=array(); $new_created_nm=array(); $un_created=array(); $un_created_nm=array();
	foreach($tid as $valuet){
	    if($valuet==""){$valuet=0; }
		$account_count=db_rows(
			"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}account`".
			" WHERE `nick_name` IN ({$valuet}) AND `clientid`=".$pst['mid'].
			" LIMIT 1",0
		);
		$account_count=$account_count[0]['count'];
		if($account_count>0){
			$pre_created[]=$valuet;
			$pre_created_nm[]=$data['t'][$valuet]['name1'];
			
			//$dat['Error']="All ready assign of ".$valuet;  echo $dat['Error']."<br/>";
			//json_print($dat);exit;
		}else{
			// for new create account
			$post['acq_1']=array();
			$ac['clientid']=$pst['mid'];
			$ac['sponsor']=$pst['spo'];
			$ac['nick_name']=$valuet;
			$ac['mid_name']=$data['t'][$valuet]['name1'];
			
			
			$bgt_slc=db_rows(
				"SELECT * FROM `{$data['DbPrefix']}acquirer_table`".
				" WHERE `acquirer_id`={$valuet} LIMIT 1",0
			);
			$post['acq_1']=jsondecode($bgt_slc[0]['acquirer_json']);
			
			//print_r($post['acq_1']);
			
			if($post['acq_1']){
				$new_created[]=$valuet;
				$new_created_nm[]=$data['t'][$valuet]['name1'];
				
				if(is_array($post['acq_1']) && is_array($ac)) {
					$post['acq_1']['hkip_siteid']=jsonencode($post['acq_1']['hkip_siteid']);
					$post['acq']=array_merge($post['acq_1'],$ac);
				}
				
				$post['acq']['user_type']="1";
				insert_account_info($post['acq'], $ac['clientid']);
					
			}else{
				$un_created[]=$valuet;
				$un_created_nm[]=$data['t'][$valuet]['name1'];
			}
		}
	}
	
	
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
	$acquirer_url=$data['Admins']."/merchant{$data['ex']}?id={$pst['mid']}&action=insert_account&add_template=".$pst['tid'];
	$dat['url']=$acquirer_url;
	*/
	
	$dat['add_template']=$pst['tid'];
	$msg['msg']=jsonencode($dat);
	
	if(isset($_SESSION['sub_admin_id'])){
		$admin_id=$_SESSION['sub_admin_id'];
	}else{
		$admin_id='Admin';
	}
	
	
	$pro_slc=db_rows(
		"SELECT select_templates_log FROM `{$data['DbPrefix']}terminal`".
		" WHERE `id`={$pst['gid']} LIMIT 1",0
	);
	$pLog=$pro_slc[0]['select_templates_log'];
	
	
	$cLog['tm_user']=$admin_id;
	$cLog['tm_date']=date('Y-m-d H:i:s A');
	$cLog['tm_log']=$dat;
	$t_log=json_log($pLog,$cLog);
	//$t_log=jsonencode($cLog);
	if($qp){
		echo $t_log; 
	}
	
	
	db_query("UPDATE `{$data['DbPrefix']}terminal`".
	" SET `active`={$pst['active']}, `acquirerIDs`='{$pst['acquirerIDs']}', `select_templates`={$pst['tid']}, `select_templates_log`='{$t_log}'  WHERE `id`={$pst['gid']}",0);
	
	//exit;
	
	//json_print($msg['msg']);exit;
	//$curlPost=use_curl($acquirer_url,$data_send);
}
	
	
###############################################################################
$post=select_info($uid, $post);
if(!isset($post['step']) || !$post['step'])$post['step']=1;
$post['Buttons']=get_files_list($data['SinBtnsPath']);

if(isset($post['private_key'])&&trim($post['private_key']))$_SESSION['generate_private_'.@$uid]=trim($post['private_key']);

//print_r($post['sponsor']);exit;

###############################################################################
if(isset($post['send'])&&$post['send']){


	if(isset($post['step'])&&$post['step']==1){
		//$post['step']++;
		$post['step']=2;
	}elseif(isset($post['step'])&&$post['step']==2){
		$validation=false;
		if((isset($_SESSION['store_active']))&&($_SESSION['store_active']==1)){
			$validation=false;
			
		}
		if(!$post['ter_name']){
			$data['Error']="Please enter {$data['PageName']} Name of your choice.";
		}elseif(!$post['bussiness_url'] && !$_SESSION['store_bussiness_url']){
			$data['Error']='Please enter Business URL.';
		}elseif(!$post['transaction_currency']&&$validation!=false){
			$data['Error']=$data['PageName'].' Currency separated by commas i.e. SGD,USD,CNY for Transaction Currency .';
		}elseif(!$post['business_nature']&&$validation!=false){
			$data['Error']='Describe your Business Description in Short';
		}else{
			if(!$post['gid']){
				insert_terminal($uid, $post);
				
				
				// Auto Add Pricing Templates 
				/*
				if(isset($data['con_name'])&&$data['con_name']!='clk'){
					$pst['gid']=$data['c_id'];
					$pst['mid']=$uid;
					$pst['tid']='1118';
					$pst['spo']=$post['sponsor'];
					$pst['acquirerIDs']="34,341";
					$pst['active']=4; // 1:Approved | 4: Under review
					//print_r($pst);
					templatesf($pst);
				}
				*/
				
				$_SESSION['query_status']="Your ".str_replace("Add","",$data['PageName'])." has been added successfully ";
				header('Location:'.$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']);
				exit;
			}else{ 
				if(isset($_SESSION['store_active'])&&$_SESSION['store_active']==1){
					$post['active']=$_SESSION['store_active'];
					
					if(isset($data['API_VER'])&&$data['API_VER']==2){
						$post['bussiness_url']=$_SESSION['store_bussiness_url'];
					}else{
						$post['ter_name']=$_SESSION['store_name'];
						$post['bussiness_url']=$_SESSION['store_bussiness_url'];
						$post['transaction_currency']=$_SESSION['store_transaction_currency'];
						$post['business_nature']=$_SESSION['store_business_nature'];
					}
				}
				
				update_terminal($post['gid'], $post);
				$_SESSION['query_status']="Your {$data['PageName']} Information Has Been Updated.";
				header('location:'.$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']);
				
			}
			$post['step']--;
		}
	}
}elseif(isset($post['action'])&&$post['action']=='re_generate_public_key'){
	$public_key_store=api_public_key($uid,$post['gid']);
	
	if(isset($_REQUEST['ajax'])&&$_REQUEST['ajax']){
		echo $public_key_store;exit;
	}
	header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']);exit;
	
}elseif(isset($post['action'])&&$post['action']=='generate_private_key'){
	$generate_private_key=generate_private_key($uid);
	if(isset($_REQUEST['ajax'])&&$_REQUEST['ajax']){
		echo $generate_private_key;exit;
	}
	header("location:".$data['USER_FOLDER']."/".$data['PageFileName'].$data['ex']);exit;
	
}elseif(isset($post['cancel'])&&$post['cancel'])$post['step']--;
if(isset($post['action'])&&($post['action']=='update'||$post['action']=='view')){
	
	$select_terminals=select_terminals($uid, $post['gid'], true);
	
	$select_terminal=$select_terminals[0];
	
	foreach($select_terminal as $key=>$value)if(!isset($post[$key]) || !$post[$key])$post[$key]=$value;
	$post['active']=$select_terminal['active'];
	
	if(isset($post['select_templates'])&&$post['select_templates']){
		$pt=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}acquirer_group_template`".
			" WHERE `id`={$post['select_templates']} LIMIT 1"
		);
		$post['templates_name']=$pt[0]['templates_name'];
	}
	
	$_SESSION['store_active']=$select_terminal['active'];
	$_SESSION['store_name']=$select_terminal['ter_name'];
	$_SESSION['store_bussiness_url']=$select_terminal['bussiness_url'];
	//$_SESSION['store_transaction_currency']=$select_terminal['transaction_currency'];
	$_SESSION['store_business_nature']=$select_terminal['business_nature'];
	
	if($is_admin&&isset($post['select_mcc'])&&trim($post['select_mcc'])){
		$select_mcc=merchant_categoryf(0,0,$post['select_mcc']);
		if($select_mcc&&$post['select_mcc'])
		$mcc_codes_list=[];
		if(isset($data['mcc_codes_list'])&&!empty($data['mcc_codes_list'])) $mcc_codes_list=$data['mcc_codes_list'];

		$post['select_mcc']=implode(" , ",@$mcc_codes_list);
		//echo "<br/>select_mcc=>".$post['select_mcc'];
	}
	
	$post['actn']='update';
	$post['step']=2;
	if(isset($post['action'])&&$post['action']=='view'){$post['step']=3;}
	
}elseif(isset($post['action'])&&$post['action']=='delete'){
	delete_terminal($post['gid']);
	$_SESSION['query_status']="Your {$data['PageName']} has been deleted successfully.";
}
if(isset($post['step'])&&$post['step']==1){
	$post['Terminals']=select_terminals($uid,0,0,0,' AND (`active` NOT IN (2) ) ');
	$data['result_count']=sizeof($post['Terminals']);
}
//echo $post['step'];
###############################################################################
display('user');
###############################################################################
?>
