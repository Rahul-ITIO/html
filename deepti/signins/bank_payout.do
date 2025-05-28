<?
$data['PageName']	= 'BANK PAYOUT';
$data['PageFile']	= 'bank_payout';

$data['rootNoAssing']=1; 
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Bank Payout - '.$data['domain_name'];
###############################################################################

if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['sub_admin_id']))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['slogin']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

//$post=select_info($uid, $post);

if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])||!$post['step']){$post['step']=1; }

###############################################################################

//print_r($post); print_r($uid); echo "=h1=";

if(isset($_SESSION['post'])){
	$post=$_SESSION['post'];
	$post['payout_id']=$post['payout_id']."99";
	$post['send']=1;
	$post['step']=2;
	$post['gid']=0;
	unset($post['gid']);
	unset($_SESSION['post']);
}

###############################################################################
if(isset($post['send'])&&$post['send']){
//global $data;
//echo "DbPrefix===".$data['DbPrefix']."<br/>"; echo "gid===".$post['gid']."<br/>";
	
  
					
        if($post['step']==1){
                $post['step']++;
        }elseif($post['step']==2){
			
			//echo $post['acq']; print_r($post['acq']);exit;
			
			if(isset($post['payout_status'])&&$post['payout_status']<0){
			  $data['Error']='Please Select Activation '.$post['payout_status'];
			}elseif(!isset($post['payout_id'])||!$post['payout_id']){
			  $data['Error']='Please enter Account No.';
			}else{
				$comments_date = date('Y-m-d H:i:s');
				
				$payout_json=jsonencode($post['acq']);
				
				
				if(!isset($post['payout_processing_currency'])) $post['payout_processing_currency']='';
				if(!isset($post['date'])) $post['date']='0000-00-00';

				if($post['encode_processing_creds']) $encode_processing_creds = encode_f($post['encode_processing_creds']); else $encode_processing_creds = '{}';

                if(!isset($post['gid'])||!$post['gid']){ 
					
					db_query(
						"INSERT INTO `{$data['DbPrefix']}bank_payout_table`(".
						"`payout_status`,`payout_id`,`bank_payment_url`,`bank_merchant_id`,`bank_api_token`,`bank_login_url`,`bank_user_id`,`bank_login_password`,`developer_url`,`bank_status_url`,`bank_process_url`,`payout_processing_currency`,`processing_currency`,`tech_comments`,`payout_type`,`connection_method`,`payout_prod_mode`,`payout_uat_url`,`hash_code_method`,`payout_wl_ip`,`payout_mop`,`encode_processing_creds`,`payout_json`".
						")VALUES(".
						"'{$post['payout_status']}','{$post['payout_id']}','{$post['bank_payment_url']}','{$post['bank_merchant_id']}','{$post['bank_api_token']}','{$post['bank_login_url']}','{$post['bank_user_id']}','{$post['bank_login_password']}','{$post['developer_url']}','{$post['bank_status_url']}','{$post['bank_process_url']}','{$post['payout_processing_currency']}','{$post['processing_currency']}','{$post['tech_comments']}','{$post['payout_type']}','{$post['connection_method']}','{$post['payout_prod_mode']}','{$post['payout_uat_url']}','{$post['hash_code_method']}','{$post['payout_wl_ip']}','{$post['payout_mop']}','{$encode_processing_creds}','{$payout_json}'".
						")"
					);
					$tabid=newid();				
					json_log_upd($tabid,'bank_payout_table','Insert');
					$_SESSION['action_success'] = "Added successfully";

				}
                else { 
					db_query(
							"UPDATE `{$data['DbPrefix']}bank_payout_table` SET ".
							"`payout_status`='{$post['payout_status']}',`payout_id`='{$post['payout_id']}',`bank_payment_url`='{$post['bank_payment_url']}',`bank_login_url`='{$post['bank_login_url']}',`bank_user_id`='{$post['bank_user_id']}',`bank_login_password`='{$post['bank_login_password']}',`developer_url`='{$post['developer_url']}',`bank_status_url`='{$post['bank_status_url']}',`bank_process_url`='{$post['bank_process_url']}',`payout_processing_currency`='{$post['payout_processing_currency']}',`processing_currency`='{$post['processing_currency']}',`tech_comments`='{$post['tech_comments']}',`payout_type`='{$post['payout_type']}',`connection_method`='{$post['connection_method']}',`payout_prod_mode`='{$post['payout_prod_mode']}',`payout_uat_url`='{$post['payout_uat_url']}',`payout_wl_ip`='{$post['payout_wl_ip']}',`encode_processing_creds`='{$encode_processing_creds}',`payout_json`='{$payout_json}'".
							" WHERE `id`='{$post['gid']}'",0
					);
	
					$tabid=$post['gid'];				
					json_log_upd($tabid,'bank_payout_table','Update');
					if($data['affected_rows'])
					{
						$_SESSION['action_success'] = "Updated successfully";
						if(isset($post['payout_id'])&&$post['payout_id']=='1111')
						{
							$bank_json_arr = json_decode($post['encode_processing_creds'],1);
		
							$_SESSION['nodal_bank_1111'] = $bank_json_arr;
						}
					}
					else
						$_SESSION['action_success'] = "No any update";
				    }

				$data['sucess'] ="true";
				
				$post['date']		=$post['date'];
				$post['step']--;
				$post['tech_comments']= ""; $post['tech_comments']--;
				
				
				// Dev Tech : 23-05-29 fetch the data from Bank Payout Table for option of Withdraw
				$result_select_bpt=db_rows(
					" SELECT * FROM {$data['DbPrefix']}bank_payout_table".
					" WHERE payout_status='1' AND payout_type='6'".
					" ORDER BY id DESC"
				);
				$_SESSION['data_bank_payout_table']=$result_select_bpt;
				
				
				//send_email('REQUEST-MONEY', $post);
				$data['PostSent']=true;
				header("location:".$data['Admins']."/bank{$data['ex']}");exit;
				
				
				
		}
	}
}elseif($post['action']=='insert_1'){

	$comments_date = date('Y-m-d H:i:s');
			  
	db_query(
		"INSERT INTO `{$data['DbPrefix']}bank_payout_table`(".
		"`processing_currency`,`tech_comments`".
		")VALUES(".
		"'{$post['processing_currency']}','{$post['tech_comments']}'".
		")"
	);
	
	$post['tech_comments']= ""; 
	$post['step']=1;
	$post['action']='select';
	
	$reurl=$post['aurl'];
	header("Location:$reurl");
	exit;
	
}elseif($post['action']=='addmessage'){
	$message_slct=db_rows(
			"SELECT `reply_comments`,`status` FROM `{$data['DbPrefix']}bank_payout_table` WHERE `id`='{$post['id']}'"
	);
	$message_get 	= $message_slct[0]['reply_comments']; 
	$status_get 	= $message_slct[0]['status']; 
	$processing_currency_get = $message_slct[0]['processing_currency'];
	$rmk_date		= date('d-m-Y h:i:s A');
	
	if(empty($processing_currency_get)){$redate = " ,`processing_currency`='{$rmk_date}' "; }else {$redate = "";}
	
	$message_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$post['tech_comments']."</div></div>".$message_get;
	$status = $post['status'];
	
	if(isset($post['tech_comments'])&&$post['tech_comments']){
		db_query(
			"UPDATE `{$data['DbPrefix']}bank_payout_table`".
			" SET `tech_comments`='{$message_upd}',`processing_currency`='{$status}'".$redate.
			" WHERE `id`='{$post['id']}'"
		);
	}
	$post['tech_comments']= ""; 
	$post['step']=1;
	$post['action']='select';
	
	$reurl=$post['aurl'];
	header("Location:$reurl");
	exit;
	
}elseif(isset($post['action'])&&($post['action']=='update'||$post['action']=='duplicate'||(isset($_REQUEST['action'])&&$_REQUEST['action']=='get_bank_payout_table'))){
       
	global $data;
	$id = $post['gid'];
	$where_app = " `id`='{$id}' ";
		
		if(isset($_GET['gid'])&&($_REQUEST['action']=='get_bank_payout_table')){
			$payout_id = $_GET['gid'];
			//$where_app = "`payout_id`={$payout_id} AND `payout_status`='1'";
			$where_app = "`payout_id`='{$payout_id}' ";
		}
		//echo "<div style='margin-top:100px;'></div>"; print_r($id); exit;
		$updateList=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}bank_payout_table`".
                " WHERE {$where_app} LIMIT 1",0
        );
        /*
		$results=array();
        foreach($updateList as $key=>$value){
                foreach($value as $name=>$v)$results[$key][$name]=$v;
        }
		*/
		if($updateList && isset($updateList[0])){
			foreach($updateList[0] as $key=>$value){
				if(!isset($post[$key])||!$post[$key]){
					$post[$key]=$value; 
					
					if($key=='payout_json'){
						if(isset($post['payout_status'])&&$post['payout_status']==1){ $post['payout_status_nm']='Active'; }
						elseif(isset($post['payout_status'])&&$post['payout_status']==2){ $post['payout_status_nm']='Common'; }
						else{ $post['payout_status_nm']='Inactive'; }
						
						if(isset($post['payout_prod_mode'])&&$post['payout_prod_mode']==1){ $post['payout_prod_mode_nm']='Live'; }else{$post['payout_prod_mode_nm']='Test';}
					
						$aj_get=json_decode($value,true); 
						$post['acq']=$aj_get;
						
						if(isset($post['acq']['account_login_url'])&&$post['acq']['account_login_url']==1){ $post['account_login_url_nm']='Live'; }
						elseif(isset($post['acq']['account_login_url'])&&$post['acq']['account_login_url']==3){ $post['account_login_url_nm']='Inactive'; }
						else{ $post['account_login_url_nm']='Test'; }
						
						
						foreach($aj_get as $key=>$value){
							if(is_array($value)){
								$post['acq'][$key]=json_encode($value);
							}
						}
						//print_r($aj_get);
						
						//echo "<br/>payout_id=>".$post['payout_id'];
				
						$post['acq']['payout_id']=(isset($post['payout_id'])?$post['payout_id']:'');
						$post['acq']['account_nm']=(isset($data['t'][$post['payout_id']]['name1'])?$data['t'][$post['payout_id']]['name1']:'');
						
						if(isset($post['payout_status_nm']) && isset($post['payout_id'])&&isset($data['t'][$post['payout_id']]['name1']))
						{
							$post['acq']['account_label']=$post['payout_status_nm'].' / '.$post['payout_id'].' / '.$data['t'][$post['payout_id']]['name1'].' / '.$post['account_login_url_nm']; 
						}
						if(isset($post['acq']['processing_currency'])&&$post['acq']['processing_currency']){ $post['acq']['processing_currency_nm']=get_currency($post['acq']['processing_currency'],1); }
					
					} // end payout_json
					
					
						
				}
				
				
			}
		}
        
		//$post['acq']=jsondecode($post['payout_json']);
		
		if($_REQUEST['action']=='get_bank_payout_table'){
			$post['acq1']=jsonencode($post['acq']);
			//$post['acq1']=$post['acq'];
			//$post['acq1']=jsondecode($post['acq']);
			echo $post['acq1'];
			exit;
		}
		elseif($post['action']=='duplicate'){
			$_SESSION['post']=$post;
			$_SESSION['action_success']="Duplicate Created Successfully";
			header("Location:{$data['Admins']}/bank".$data['ex']."?send=1&step=1&gid=0");
			exit;
		}
		
		
		
		//echo "acq=>"; echo "processing_currency=>".$post['acq']['processing_currency']; print_r($post['acq']);
		
		//echo "<div style='margin-top:100px;'></div>"; print_r($post);
		
        $post['actn']='update';
        $post['step']++;
		
		
}elseif($post['action']=='delete'){
	$gid = $post['gid'];
	
	
	
  $banktable=db_rows("SELECT * FROM `{$data['DbPrefix']}bank_payout_table` WHERE `id`='{$gid}'",0);
  $data['JSON_INSERT']=1;
  json_log_upd($gid,'bank_payout_table','Delete',$banktable,'');

	
	db_query(
			"DELETE FROM `{$data['DbPrefix']}bank_payout_table`".
			" WHERE `id`='{$gid}'"
	);
		
	$_SESSION['action_success']="Delete Successfully";
	header("Location:{$data['Admins']}/bank".$data['ex']."?send=1&step=1&gid=0");
	exit;	
}

if($post['step']==1){
	global $data;
	  
	$sponsor_qr="";
	if(isset($post['status'])&&($post['status'] || $post['status']=="0")){
		$status = "AND  s.status='{$post['status']}' ";
	}
	
	
	if(isset($_SESSION['sub_admin_id'])){
		//$sponsor_qr="AND  m.sponsor={$_SESSION['sub_admin_id']}   "; //GROUP BY m.id ORDER BY count
	}
	
	if(!empty($sponsor_qr)) { 
		$sponsor_qr=ltrim($sponsor_qr,'AND');
		$sponsor_qr =' WHERE '.$sponsor_qr;
		
	}
		
	$result_select=db_rows(
		" SELECT * FROM {$data['DbPrefix']}bank_payout_table".
		"  ".$sponsor_qr.
		" ORDER BY id DESC"
	);
		
		
	$post['result_list'] = $result_select;
}


###############################################################################

display('admins');

###############################################################################

?>
