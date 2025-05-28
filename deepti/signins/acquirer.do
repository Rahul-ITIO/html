<?
$data['PageName']	= 'ACQUIRER';
$data['PageFile']	= 'acquirer';
$data['rootNoAssing']=1;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Acquirer - '.$data['domain_name'];
###############################################################################
if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['sub_admin_id']))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['slogin']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

$qp=0; if(isset($_GET['cqp'])&&$_GET['cqp']==5) $qp=$_GET['cqp'];

if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])||!$post['step']){$post['step']=1; }

###############################################################################

//print_r($post); print_r($uid); echo "=h1=";

if(isset($_SESSION['post'])){
	$post=$_SESSION['post'];
	$post['acquirer_id']=$post['acquirer_id']."99";
	$post['send']=1;
	$post['step']=2;
	$post['gid']=0;
	unset($post['gid']);
	unset($_SESSION['post']);
}

merchant_categoryf();
$post['mop_option']=mop_option_list_f(1);

//print_r($data['mcc_codes_list']);
	
	
###############################################################################
if(isset($post['send'])&&$post['send']){
	//global $data;
	//echo "DbPrefix===".$data['DbPrefix']."<br/>"; echo "gid===".$post['gid']."<br/>";
			
        if($post['step']==1){
                $post['step']++;
        }elseif($post['step']==2){
			
			
			
			// print_r($_POST);echo "<br/>=>POST<br/><br/><br/>";
			//echo $post['acq']; print_r($post['acq']);exit;
			
			if($post['acquirer_status']<0){
				$data['Error']='Please Select Activation '.$post['acquirer_status'];
			}elseif(!isset($post['acquirer_id'])||!$post['acquirer_id']){
				$data['Error']='Please enter Account No.';
				$data['ErroFocus']='acquirer_id';
			}elseif(!isset($post['channel_type'])||!$post['channel_type']){
				$data['Error']='Must be channel select';
				$data['ErroFocus']='channel_type';
			}elseif(!isset($post['default_acquirer'])||!$post['default_acquirer']){
				$data['Error']='Can not empty for Default Acquirer';
				$data['ErroFocus']='default_acquirer';
			}elseif(!isset($post['acquirer_prod_url'])||!$post['acquirer_prod_url']){
				$data['Error']='Can not empty for Acquirer Payment Live/Prod. URL';
				$data['ErroFocus']='acquirer_prod_url';
			}elseif(!isset($post['acquirer_status_url'])||!$post['acquirer_status_url']){
				$data['Error']='Can not empty for Acquirer Status URL';
				$data['ErroFocus']='acquirer_status_url';
			}elseif(!isset($post['acquirer_refund_policy'])||!$post['acquirer_refund_policy']){
				$data['Error']='Can not empty for Acquirer Refund Policy';
				$data['ErroFocus']='acquirer_refund_policy';
			}elseif(!isset($post['acquirer_processing_currency'])||!$post['acquirer_processing_currency']){
				$data['Error']='Must be select for Acquirer Processing Currency';
				$data['ErroFocus']='acquirer_processing_currency';
			}elseif(!isset($post['acquirer_processing_creds'])||!$post['acquirer_processing_creds']){
				$data['Error']='Can not empty for Acquirer Processing Creds.';
				$data['ErroFocus']='acquirer_processing_creds';
			}elseif(!isset($post['acquirer_label_json']['acquirer_name'])||!$post['acquirer_label_json']['acquirer_name']){
				$data['Error']='Can not empty for Acquirer Name';
				$data['ErroFocus']='acquirer_name';
			}/*elseif(!isset($post['acquirer_label_json']['payment_option_web'])||!$post['acquirer_label_json']['payment_option_web']){
				$data['Error']='Can not empty for Checkout Page define [web]';
				$data['ErroFocus']='payment_option_web';
			}elseif(!isset($post['acquirer_label_json']['logo_web'])||!$post['acquirer_label_json']['logo_web']){
				$data['Error']='Can not empty for Logo [web]';
				$data['ErroFocus']='logo_web';
			}*/elseif(!isset($post['acquirer_label_json']['checkout_label_web'])||!$post['acquirer_label_json']['checkout_label_web']){
				$data['Error']='Can not empty for Checkout Label Name [web]';
				$data['ErroFocus']='checkout_label_web';
			}elseif(!isset($post['acq']['min_limit'])||!$post['acq']['min_limit']){
				$data['Error']='Can not empty for Min Trxn Limit';
				$data['ErroFocus']='min_limit';
			}elseif(!isset($post['acq']['max_limit'])||!$post['acq']['max_limit']){
				$data['Error']='Can not empty for Max Trxn Limit';
				$data['ErroFocus']='max_limit';
			}elseif(!isset($post['acq']['scrubbed_period'])||!$post['acq']['scrubbed_period']){
				$data['Error']='Can not empty for Scrubbed Period';
				$data['ErroFocus']='scrubbed_period';
			}elseif(!isset($post['acq']['trans_count'])||!$post['acq']['trans_count']){
				$data['Error']='Can not empty for Trxn Count';
				$data['ErroFocus']='trans_count';
			}elseif(!isset($post['acq']['tr_scrub_success_count'])||!$post['acq']['tr_scrub_success_count']){
				$data['Error']='Can not empty for Min. Success Count';
				$data['ErroFocus']='tr_scrub_success_count';
			}elseif(!isset($post['acq']['tr_scrub_failed_count'])||!$post['acq']['tr_scrub_failed_count']){
				$data['Error']='Can not empty for Min. Failed Count';
				$data['ErroFocus']='tr_scrub_failed_count';
			}elseif(!isset($post['acq']['acquirer_processing_mode'])||!$post['acq']['acquirer_processing_mode']){
				$data['Error']='Can not empty for Processing Mode';
				$data['ErroFocus']='acquirer_processing_mode';
			}elseif(!isset($post['acq']['acquirer_processing_currency'])||!$post['acq']['acquirer_processing_currency']){
				$data['Error']='Can not empty for Default Currency';
				$data['ErroFocus']='acquirer_processing_currency2';
			}elseif(!isset($post['acq']['mdr_rate'])||!$post['acq']['mdr_rate']){
				$data['Error']='Can not empty for Discount Rate';
				$data['ErroFocus']='mdr_rate';
			}elseif(isset($post['acq']['gst_rate'])&&!$post['acq']['gst_rate']){
				$data['Error']='Can not empty for GST Rate';
				$data['ErroFocus']='gst_rate';
			}elseif(!isset($post['acq']['settelement_delay'])||!$post['acq']['settelement_delay']){
				$data['Error']='Can not empty for Settlement Period';
				$data['ErroFocus']='settelement_delay';
			}elseif(!isset($post['acq']['txn_fee_success'])||!$post['acq']['txn_fee_success']){
				$data['Error']='Can not empty for Txn. Fee (Success)';
				$data['ErroFocus']='txn_fee_success';
			}elseif(!isset($post['acq']['txn_fee_failed'])||!$post['acq']['txn_fee_failed']){
				$data['Error']='Can not empty for Txn. Fee (Failed)';
				$data['ErroFocus']='txn_fee_failed';
			}elseif(!isset($post['acq']['acquirer_display_order'])||!$post['acq']['acquirer_display_order']){
				$data['Error']='Can not empty for Acquirer Display Order';
				$data['ErroFocus']='acquirer_display_order';
			}elseif(!isset($post['acq']['reserve_rate'])||!$post['acq']['reserve_rate']){
				$data['Error']='Can not empty for Rolling Reserve Rate';
				$data['ErroFocus']='reserve_rate';
			}elseif(!isset($post['acq']['reserve_delay'])||!$post['acq']['reserve_delay']){
				$data['Error']='Can not empty for Rolling Reserve Days';
				$data['ErroFocus']='reserve_delay';
			}elseif(!isset($post['acq']['charge_back_fee_1'])||!$post['acq']['charge_back_fee_1']){
				$data['Error']='Can not empty for CB Fee Tier 1';
				$data['ErroFocus']='charge_back_fee_1';
			}elseif(!isset($post['acq']['charge_back_fee_2'])||!$post['acq']['charge_back_fee_2']){
				$data['Error']='Can not empty for CB Fee Tier 2';
				$data['ErroFocus']='charge_back_fee_2';
			}elseif(!isset($post['acq']['charge_back_fee_3'])||!$post['acq']['charge_back_fee_3']){
				$data['Error']='Can not empty for CB Fee Tier 3';
				$data['ErroFocus']='charge_back_fee_3';
			}elseif(!isset($post['acq']['cbk1'])||!$post['acq']['cbk1']){
				$data['Error']='Can not empty for CBK1';
				$data['ErroFocus']='cbk1';
			}elseif(!isset($post['acq']['refund_fee'])||!$post['acq']['refund_fee']){
				$data['Error']='Can not empty for Refund Fee';
				$data['ErroFocus']='refund_fee';
			}else{
				$comments_date = date('Y-m-d H:i:s');

				$mer_setting_json=jsonencode($post['acq']);
				//$select_mcc=jsonencode($post['select_mcc']);
				
				
				if(isset($post['select_mcc'])&&$post['action']!='duplicate')
					$select_mcc=implode(",",$post['select_mcc']);
				else $select_mcc=''; 
				
				if(isset($post['mop'])&&$post['action']!='duplicate')
					$mop=implode(",",$post['mop']);
				else $mop=''; 
				
				if(isset($post['mop_mobile'])&&$post['action']!='duplicate')
					$mop_mobile=implode(",",$post['mop_mobile']);
				else $mop_mobile=''; 
				
				
				
			
				if(!@$post['connection_method'])
					$post['connection_method']=3;
				
				
				if(isset($post['popup_msg_web'])) $post['acquirer_label_json']['popup_msg_web']=implode(' ',$post['popup_msg_web']);
				
				if(isset($post['popup_msg_mobile'])) $post['acquirer_label_json']['popup_msg_mobile']=implode(' ',$post['popup_msg_mobile']);
				
				
				
				$acquirer_label_json=jsonencode($post['acquirer_label_json']);
				
				$post['acquirer_name']=$post['acquirer_label_json']['acquirer_name'];
				
				if(isset($post['inactive_time_period'])&&$post['inactive_time_period'])
				{
					$periodArr = explode('to', $post['inactive_time_period']);
					$post['inactive_start_time']= "'".trim($periodArr[0])."'";
					$post['inactive_end_time']	= "'".trim($periodArr[1])."'";
				}
				else
				{
					$post['inactive_start_time'] = $post['inactive_end_time'] = NULL;
				}
				
				if(!@$post['inactive_start_time'])
					$post['inactive_start_time']='NULL';
				if(!@$post['inactive_end_time'])
					$post['inactive_end_time']='NULL';
				
				if(isset($post['inactive_failed_count'])) $post['inactive_failed_count']=(int)$post['inactive_failed_count'];
				else $post['inactive_failed_count']='0';
				
				if(isset($post['trans_auto_expired'])) $post['trans_auto_expired']=(int)$post['trans_auto_expired'];
				else $post['trans_auto_expired']='0';
				
				if(isset($post['trans_auto_refund'])) $post['trans_auto_refund']=(int)$post['trans_auto_refund'];
				else $post['trans_auto_refund']='0';
				
				/*
				echo "<br/>inactive_start_time=>".$post['inactive_start_time'];
				echo "<br/>inactive_end_time=>".$post['inactive_end_time'];
				echo "<br/>";
				*/
				
                if(!isset($post['gid'])||!$post['gid']){
					
					db_query(
						"INSERT INTO `{$data['DbPrefix']}acquirer_table`(".
						"`select_mcc`,`acquirer_status`,`acquirer_id`,`acquirer_name`,`default_acquirer`,`acquirer_prod_url`,`acquirer_login_creds`,`acquirer_refund_url`,`acquirer_refund_policy`,`acquirer_dev_url`,`acquirer_status_url`,`acquirer_wl_domain`,`acquirer_processing_currency`,`processing_currency_markup`,`tech_comments`,`channel_type`,`connection_method`,`acquirer_prod_mode`,`acquirer_uat_url`,`acquirer_descriptor`,`acquirer_wl_ip`,`mop`,`mop_mobile`,`acquirer_label_json`,`acquirer_processing_creds`,`mer_setting_json`,`inactive_failed_count`,`notification_email`,`inactive_start_time`,`inactive_end_time`,`processing_countries`,`block_countries`,`trans_auto_expired`,`trans_auto_refund`".
						")VALUES(".
						"'{$select_mcc}','{$post['acquirer_status']}','{$post['acquirer_id']}','{$post['acquirer_name']}','{$post['default_acquirer']}','{$post['acquirer_prod_url']}','{$post['acquirer_login_creds']}','{$post['acquirer_refund_url']}','{$post['acquirer_refund_policy']}','{$post['acquirer_dev_url']}','{$post['acquirer_status_url']}','{$post['acquirer_wl_domain']}','{$post['acquirer_processing_currency']}','{$post['processing_currency_markup']}','{$post['tech_comments']}','{$post['channel_type']}','{$post['connection_method']}','{$post['acquirer_prod_mode']}','{$post['acquirer_uat_url']}','{$post['acquirer_descriptor']}','{$post['acquirer_wl_ip']}','{$mop}','{$mop_mobile}','{$acquirer_label_json}','{$post['acquirer_processing_creds']}','{$mer_setting_json}','{$post['inactive_failed_count']}','{$post['notification_email']}',{$post['inactive_start_time']},{$post['inactive_end_time']},'{$post['processing_countries']}','{$post['block_countries']}','{$post['trans_auto_expired']}','{$post['trans_auto_refund']}'".
						")",$qp
					);

					$tabid=newid();				
					json_log_upd($tabid,'acquirer_table','Insert');
					$_SESSION['msgsuccess']="Added Successfully";

					
				}
                else { 
					db_query(
							"UPDATE `{$data['DbPrefix']}acquirer_table` SET ".
							"`select_mcc`='{$select_mcc}',`acquirer_status`='{$post['acquirer_status']}',`acquirer_id`='{$post['acquirer_id']}',`acquirer_name`='{$post['acquirer_name']}',`default_acquirer`='{$post['default_acquirer']}',`acquirer_prod_url`='{$post['acquirer_prod_url']}',`acquirer_login_creds`='{$post['acquirer_login_creds']}',`acquirer_refund_url`='{$post['acquirer_refund_url']}',`acquirer_refund_policy`='{$post['acquirer_refund_policy']}',`acquirer_dev_url`='{$post['acquirer_dev_url']}',`acquirer_status_url`='{$post['acquirer_status_url']}',`acquirer_wl_domain`='{$post['acquirer_wl_domain']}',`acquirer_processing_currency`='{$post['acquirer_processing_currency']}',`processing_currency_markup`='{$post['processing_currency_markup']}',`tech_comments`='{$post['tech_comments']}',`channel_type`='{$post['channel_type']}',`connection_method`='{$post['connection_method']}',`acquirer_prod_mode`='{$post['acquirer_prod_mode']}',`acquirer_uat_url`='{$post['acquirer_uat_url']}',`acquirer_descriptor`='{$post['acquirer_descriptor']}',`acquirer_wl_ip`='{$post['acquirer_wl_ip']}',`mop`='{$mop}',`mop_mobile`='{$mop_mobile}',`acquirer_label_json`='{$acquirer_label_json}',`acquirer_processing_creds`='{$post['acquirer_processing_creds']}',`mer_setting_json`='{$mer_setting_json}',`inactive_failed_count`='{$post['inactive_failed_count']}',`notification_email`='{$post['notification_email']}',`inactive_start_time`={$post['inactive_start_time']},`inactive_end_time`={$post['inactive_end_time']},`processing_countries`='{$post['processing_countries']}',`block_countries`='{$post['block_countries']}',`trans_auto_expired`='{$post['trans_auto_expired']}',`trans_auto_refund`='{$post['trans_auto_refund']}'".
							" WHERE `id`={$post['gid']}",$qp
					);
					//exit;
					if(isset($data['affected_rows'])&&$data['affected_rows']) {
						$_SESSION['msgsuccess']="Update Successfully for ".$post['acquirer_id'];
					}
					
					$tabid=$post['gid'];				
					json_log_upd($tabid,'acquirer_table','Update');
					
				}
				
				if($qp==5) exit;
				
				#### start - fetch acquirer list wise of acquirer id  ########
				
				$actDb_acq=acquirer_tablef();
				$_SESSION['actDb_acq']=$actDb_acq['acquirer_id'];
				
				$actDb_list=acquirer_tablef(1);
				$_SESSION['actDb_list']=$actDb_list['acquirer_list'];
				
				$actDb_name=acquirer_tablef(2);
				$_SESSION['actDb_name']=$actDb_name['acquirer_name'];
				
				$actDb_channel=acquirer_tablef(3);
				$_SESSION['actDb_channel']=$actDb_channel['acquirer_channel'];
				
				$actDb_channel_name=acquirer_tablef(4);
				$_SESSION['actDb_channel_name']=$actDb_channel_name['acquirer_channel_name'];
				
				$actDb_refund=acquirer_tablef(7);
				$_SESSION['actDb_refund']=$actDb_refund['acquirer_refund'];
				
				$actDb_default_acquirer=@acquirer_tablef(9);
				$_SESSION['actDb_default_acquirer']=$actDb_default_acquirer['default_acquirer'];
				
	
				#### end - fetch acquirer list wise of acquirer id  ########
			
				$data['PostSent']=true;
				//$_SESSION['action_success']="Update Successfully";
				header("location:".$data['Admins']."/acquirer{$data['ex']}");exit;
				
				
				
          }
        }

					
}
elseif($post['action']=='addmessage'){
	$message_slct=db_rows(
			"SELECT `reply_comments`,`status` FROM `{$data['DbPrefix']}acquirer_table` WHERE `id`={$post['id']}"
	);
	$message_get 	= $message_slct[0]['reply_comments']; 
	$status_get 	= $message_slct[0]['status']; 
	$processing_currency_markup_get = $message_slct[0]['processing_currency_markup'];
	$rmk_date		= date('d-m-Y h:i:s A');
	
	if(empty($processing_currency_markup_get)){$redate = " ,`processing_currency_markup`='{$rmk_date}' "; }else {$redate = "";}
	
	$message_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$post['comments']."</div></div>".$message_get;
	$status = $post['status'];
	
	if($post['comments']){
		db_query(
			"UPDATE `{$data['DbPrefix']}acquirer_table`".
			" SET `comments`='{$message_upd}',`processing_currency_markup`='{$status}'".$redate.
			" WHERE `id`={$post['id']}"
		);
	}
	
	$post['step']=1;
	$post['action']='select';
	
	$reurl=$post['aurl'];
	header("Location:$reurl");
	exit;
	
}elseif(isset($post['action'])&&($post['action']=='update'||$post['action']=='duplicate'||(isset($_REQUEST['action'])&&$_REQUEST['action']=='get_acquirer_table'))){

		global $data;
		$id = $post['gid'];
		$where_app = " `id`={$id} ";
	   
		if(isset($_GET['gid'])&&($_REQUEST['action']=='get_acquirer_table')){
			$acquirer_id = $_GET['gid'];
			$where_app = "`acquirer_id`={$acquirer_id} ";
		}
		
		
		$updateList=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}acquirer_table`".
                " WHERE {$where_app} LIMIT 1",0
        );
        
		
		if($updateList){
			foreach($updateList[0] as $key=>$value){
				if(!isset($post[$key])||!$post[$key]){
					$post[$key]=$value; 
					
					
					
					if($key=='mer_setting_json'){
						if($post['acquirer_status']==1){ $post['acquirer_status_nm']='Active'; }
						elseif($post['acquirer_status']==2){ $post['acquirer_status_nm']='Common'; }
						else{ $post['acquirer_status_nm']='Inactive'; }
						
						if(isset($post['acquirer_prod_mode'])&&$post['acquirer_prod_mode']==1){ $post['acquirer_prod_mode_nm']='Live'; }else{$post['acquirer_prod_mode_nm']='Test';}
					
						$aj_get=json_decode($value,true); 
						$post['acq']=$aj_get;
						
						if(isset($post['acq']['acquirer_processing_mode'])&&$post['acq']['acquirer_processing_mode']==1){ $post['acquirer_processing_mode_nm']='Live'; }
						elseif(isset($post['acq']['acquirer_processing_mode'])&&$post['acq']['acquirer_processing_mode']==3){ $post['acquirer_processing_mode_nm']='Inactive'; }
						else{ $post['acquirer_processing_mode_nm']='Test'; }
						
						
						foreach(@$aj_get as $key=>$value){
							if(is_array($value)){
								$post['acq'][$key]=json_encode($value);
							}
						}
						//print_r($aj_get);
						
						//echo "<br/>acquirer_id=>".$post['acquirer_id'];
				
						$post['acq']['acquirer_id']=(isset($post['acquirer_id'])?$post['acquirer_id']:0);
						$post['acq']['account_nm']=(isset($data['t'][$post['acquirer_id']]['name1'])?$data['t'][$post['acquirer_id']]['name1']:'');
						$post['acq']['account_label']=$post['acquirer_status_nm'].' | '.$post['acquirer_id'].' | '.$post['acquirer_name'].' | '.(isset($data['channel'][$post['channel_type']]['name1'])?strtoupper($data['channel'][$post['channel_type']]['name1']):'').' | '.$post['acquirer_processing_mode_nm']; 
						
						if(isset($post['acq']['acquirer_processing_currency'])&&$post['acq']['acquirer_processing_currency']){ $post['acq']['processing_currency_nm']=get_currency($post['acq']['acquirer_processing_currency'],1); }
					
					} // end mer_setting_json
					
					if($key=='acquirer_label_json'){
						
						$acquirer_label_json=json_decode($value,true); 
						$post['acquirer_label_json']=$acquirer_label_json;
						
						$post['acq']['aLj']=$post['acquirer_label_json'];
					}
						
				}
				
				
			}
		}
        
		if(isset($data['PRO_VER'])&&$data['PRO_VER']==3){
			//merchant_categoryf();
		}
		//echo "<br/><br/>mcc_codes_list=>";	print_r($data['mcc_codes_list']);
		
		
		if($_REQUEST['action']=='get_acquirer_table'){
			$post['acq1']=jsonencode($post['acq'],1,1);
			
			echo $post['acq1'];
			exit;
		}
		elseif($post['action']=='duplicate'){
			$_SESSION['post']=$post;
			$_SESSION['msgsuccess']="Duplicate Created Successfully";
			header("Location:{$data['Admins']}/acquirer".$data['ex']."?send=1&step=1&gid=0");exit;
			
		}
		
		
		
		
        $post['actn']='update';
        $post['step']++;
		
		
}elseif($post['action']=='delete'){
	$gid = $post['gid'];
	
  $banktable=db_rows("SELECT * FROM `{$data['DbPrefix']}acquirer_table` WHERE `id`='{$gid}'",0);
  $data['JSON_INSERT']=1;
  json_log_upd($gid,'acquirer_table','Delete',$banktable,'');
	db_query(
			"DELETE FROM `{$data['DbPrefix']}acquirer_table`".
			" WHERE `id`='{$gid}'"
	);
	
	        $_SESSION['msgsuccess']="Delete Successfully";
			header("Location:{$data['Admins']}/acquirer".$data['ex']."?send=1&step=1&gid=0");exit;	
}



if($post['step']==1){
      global $data;
	  
	
	$sponsor_qr="";
	if(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']){
		//$sponsor_qr="AND  m.sponsor={$_SESSION['sub_admin_id']}   "; //GROUP BY m.id ORDER BY count
	}
	
	if(isset($_GET['active_filter']) && $_GET['active_filter']=="ac"&& isset($_GET['se']) && !empty($_GET['se'])){
		$sponsor_qr .= "AND ( `acquirer_id` IN ( {$_GET['se']} ) ) ";
	}elseif(isset($_GET['active_filter']) && $_GET['active_filter']=="mcc_code"&& isset($_GET['se']) && !empty($_GET['se'])){
		$sponsor_qr .= "AND ( (JSON_UNQUOTE(JSON_EXTRACT(`mer_setting_json`, '$.mcc_code')) LIKE ('%{$_GET['se']}%') ) ) AND (JSON_VALID(`mer_setting_json`) = 1 ) ";
	}elseif(isset($_GET['active_filter']) && $_GET['active_filter']=="mcc_code"){
		$sponsor_qr .= "AND ( CONVERT(`mer_setting_json` USING utf8) LIKE '%{$_GET['active_filter']}%' ) ";
	}elseif(isset($_GET['active_filter']) && $_GET['active_filter']!="ALL"){
		$sponsor_qr .= "AND ( `acquirer_status` IN ( {$_GET['active_filter']} ) ) ";
	}
	
	if(!empty($sponsor_qr)) { 
		$sponsor_qr=ltrim($sponsor_qr,'AND');
		$sponsor_qr =' WHERE '.$sponsor_qr;
		
	}
		
	$result_select=db_rows(
		" SELECT * FROM `{$data['DbPrefix']}acquirer_table`".
		" ".$sponsor_qr.
		" ORDER BY `id` DESC"
	);
		
		
	$data['db_count'] = count($result_select);
	$post['result_list'] = $result_select;
}


if($post['step']==2){
	
	
}

// Array for display the Acquirer Redirect Popup Msg
$acquirer_redirect_popup_msg=$data['Path'].'/payin/acquirer_redirect_popup_msg'.$data['iex'];
if(file_exists($acquirer_redirect_popup_msg)){include($acquirer_redirect_popup_msg);}
		
###############################################################################

display('admins');

###############################################################################

?>
