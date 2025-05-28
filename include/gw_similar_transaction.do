<?
$data['PageName']	= 'Similar Transaction';
$data['PageFile']	= 'create_similar_transaction'; 

###############################################################################
if(isset($_REQUEST['gid'])&&$_REQUEST['gid']>0){
	//$data['G_MID']=$_REQUEST['gid'];
}

include('../config.do');
//include('../config_db.do');
$data['qp']=0;
if(isset($_REQUEST['dtest'])){
	$data['qp']=1;
	echo "<br/>qp1=>".$data['qp'];
	echo "<br/><br/>edit=>".$post['edit'];
	echo "<br/><br/>delete=>".$post['delete'];
	
	echo "<br/><br/>POST";
	print_r($_POST);
	echo "<br/><br/>";
}


$data['PageTitle'] 	= 'Create Similar Transaction '; 
$data['FileName']='similar_transaction'.$data['ex'];
$data['ThisPageLabel'] = 'Similar Transaction';
if(strpos($urlpath,"edit_transaction")!==false){
	$data['PageName']='Edit|Delete|Cancelled Transaction';
	$data['PageFile']='create_similar_transaction';
	$data['PageTitle'] = 'Edit|Delete|Cancelled Transaction ';
	$data['FileName']='edit_transaction'.$data['ex'];
	$data['ThisPageLabel'] = 'Edit Transaction';
}

include('country_state'.$data['iex']);	

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
       header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
       echo('ACCESS DENIED.');
       exit;
//}elseif(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']!=3){
}elseif((isset($_SESSION['sub_admin_id']))&&(!isset($_SESSION['edit_trans']))){
       header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
       echo('ACCESS DENIED.');
       exit;
}

$is_admin=false;
if($_SESSION['adm_login']&&isset($_REQUEST['admin'])&&$_REQUEST['admin']){
	$is_admin=true;
	//echo "<hr/>is_admin=>".$is_admin;
}
$post['is_admin']=$is_admin;
//$post=select_info($uid, $post);

if(isset($is_admin)&&$is_admin&&!isset($uid)&&empty($uid)){
	$data['frontUiName']="";
}
if(isset($_REQUEST['tempui'])&&$_REQUEST['tempui']){
	$data['frontUiName']=$_REQUEST['tempui'];
}

if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']){
	echo "<br/>is_admin=>".$is_admin;
	echo "<br/>uid=>".$uid;
	echo "<br/>frontUiName=>".$data['frontUiName'];
}

if(!isset($post['action'])){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])){$post['step']=1; }

$gid = $post['gid'];

###############################################################################

//print_r($post); print_r($uid); echo "=h1=";

###############################################################################

//echo "<br/>is_admin=>".$is_admin;

if(isset($post['send']) && $post['send'] && $is_admin){
//global $data;
//echo "DbPrefix===".$data['DbPrefix']."<br/>"; echo "gid===".$post['gid']."<br/>";
			if($is_admin==false){
				$post['receiver']=$_SESSION['uid'];
				$post['merID']=$_SESSION['uid'];
				//$post['tdate']=$_SESSION['uid'];
				$post['tdate_time']=date('Y-m-d h:i:s',strtotime('-6 hour',strtotime(date('Y-m-d h:i:s'))));
				$post['tdate']=date('Y-m-d h:i:s',strtotime('-6 hour',strtotime(date('Y-m-d h:i:s'))));
				$post['status']=0;
				$post['acquirer']=$_SESSION['account_id'];
			}
		
		if(!$post['receiver']){
			  $data['Error']='Please Enter MID';
			}elseif(!$post['acquirer']){
			  $data['Error']='Please Select Account ID.';
			}elseif(!isset($post['amount']) || empty($post['amount'])){
			  $data['Error']='Please enter Amount!';
			}else{
			
				
			
				if($post['tableid']){
					$account_type="check";
				}else{
					$account_type="card";
				}
				
				$comments_date = date('Y-m-d H:i:s');
                
				$transactioncode = $post['acquirer'].date("ymdHis");
				
				
				$ctime = date('H:i:s',strtotime($post['tdate_time']));
				$tdate=date("Y-m-d ".$ctime,strtotime($post['tdate']));
				$related_transID ="";
				
				
				$rmk_date=date('d-m-Y h:i:s A');
				
				$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg> Duplicate transaction created from the <a class=viewthistrans>".$post['transID']."</a> - Admin</div></div>";
				
				$system_note=$system_note_upd.$post['system_note'];
				
				$post['bankaccount']=encryptres($post['bankaccount']);
				
				/*
				
				if($account_type=="check"){
					db_query(
						"INSERT INTO `{$data['DbPrefix']}echeck`(".
						"`clientid`,".
						"`fname`,`lname`,".
						"`bill_address`,`address2`,`bill_city`,`bill_state`,`bill_zip`,`phone`,`email`,`bankaccount`,`routing`,`tamount`,`echecknumber`,".
						"`bank_name`,`bank_city`,`bank_state`,`nsf`,`payable_to`,".
						"`memo`,`middle_initial`,`company_name`,`other_phone_number`,`employee_number`,`client_location`,".
						"`bank_address`,`bank_zipcode`,`bank_phone`,`bank_fax`,`tax_id`,`date_of_birth`,`id_number`,`id_state`,`unique_id`,`sequence_number`,`tdate`,`acquirer`".
						")VALUES(".
						"'{$post['receiver']}',".
						"'{$post['fname']}','{$post['lname']}',".
						"'{$post['bill_address']}','{$post['address2']}','{$post['bill_city']}',".
						"'{$post['bill_state']}','{$post['bill_zip']}','{$post['bill_phone']}',".
						"'{$post['bill_email']}','{$post['bankaccount']}','{$post['routing']}','{$post['amount']}','{$post['echecknumber']}',".
						"'{$post['bank_name']}','{$post['bank_city']}','{$post['bank_state']}','{$post['nsf']}','{$post['payable_to']}',".
						"'{$post['memo']}','{$post['middle_initial']}','{$post['company_name']}','{$post['other_phone_number']}','{$post['employee_number']}','{$post['client_location']}',".
						"'{$post['bank_address']}','{$post['bank_zipcode']}','{$post['bank_phone']}','{$post['bank_fax']}','{$post['tax_id']}','{$post['date_of_birth']}','{$post['id_number']}','{$post['id_state']}','{$transactioncode}','{$post['sequence_number']}','{$tdate}','{$post['acquirer']}'".
						")"
					);
					$related_transID=newid();
					
					$post['fullname']="{$post['fname']} {$post['lname']}";
				}
				
				*/
				
				if(isset($data['con_name'])&&$data['con_name']=='clk'){
					$insert_append1=" ,`gst_amt` ";
					$insert_append2=" ,'{$post['gst_amt']}' ";
				}else{
					$insert_append1="";
					$insert_append2="";
				}
				
				db_query(
					"INSERT INTO `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
					"(`tdate`,`transID`,`merID`,`related`,`amount`,`fees`,`acquirer`,".
					"`status`, `fullname`, `bill_address`, `bill_city`, `bill_state`, `bill_zip`, `bill_email`, `bill_phone`,".
					"`product_name`,`support_note`,`acquirer_ref`,`acquirer_response`,`source_url`,`mop`,`webhook_url`,`return_url`,`failed_url`,`country`,`tableid`,`bill_currency`,`transaction_flag`,`system_note`,`bankaccount`,`routing_aba`,`descriptor`,`buy_mdr_amt`,`buy_txnfee_amt`,`rolling_amt`,`mdr_cb_amt`,`mdr_cbk1_amt`,`mdr_refundfee_amt`,`available_rolling`,`available_balance`,`payable_amt_of_txn`,`fee_update_timestamp`,`trans_amt`,`remark_status`,`bill_ip`,`comments`,`mer_note`".$insert_append1.")VALUES(".
					"'{$tdate}','{$transactioncode}','{$post['merID']}','{$post['related']}','{$post['amount']}','{$post['fees']}','{$post['acquirer']}',".
					"{$post['status']},'{$post['fullname']}','{$post['bill_address']}','{$post['bill_city']}','{$post['bill_state']}','{$post['bill_zip']}','{$post['bill_email']}','{$post['bill_phone']}',".
					"'{$post['product_name']}','{$post['support_note']}','{$post['acquirer_ref']}','{$post['acquirer_response']}','{$post['source_url']}','{$post['mop']}','{$post['webhook_url']}','{$post['return_url']}','{$post['failed_url']}','{$post['country']}','".$related_transID."','{$post['bill_currency']}','{$post['transaction_flag']}','{$system_note}','{$post['bankaccount']}','{$post['routing_aba']}','{$post['descriptor']}','{$post['buy_mdr_amt']}','{$post['buy_txnfee_amt']}','{$post['rolling_amt']}','{$post['mdr_cb_amt']}','{$post['mdr_cbk1_amt']}','{$post['mdr_refundfee_amt']}','{$post['available_rolling']}','{$post['available_balance']}','{$post['payable_amt_of_txn']}','{$post['fee_update_timestamp']}','{$post['trans_amt']}','{$post['remark_status']}','{$post['bill_ip']}','{$post['comments']}','{$post['mer_note']}'".$insert_append2.
					" )",0
				);
				$transactions_newid=newid();
				$transactioncode = gen_transID_f($transactions_newid,$post['acquirer'],1);
				json_log_upd($transactions_newid,'transactions','Insert');
				echo "</hr>transactioncode=>".$transactioncode." <br/>newid=>".$transactions_newid; 
				
				echo"
				<script>
					window.parent.alert('$transactioncode successful transaction has been created');
				</script>
				";
				
				exit;
				
				
          }
					
}elseif(isset($post['delete']) && $post['delete']){
	//global $data;
	$id = $post['gid'];
	$type = $post['acquirer'];
	
	//echo $type;exit;
	
	/*
	db_query(
		"DELETE FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" WHERE(`id`={$id})"
	);
	*/
	
	if(isset($data['TEST_ADM_ID'])&&$data['TEST_ADM_ID']){
	  $test_adm_id=$data['TEST_ADM_ID'];
	}else{
		$test_adm_id=3333;
	}
	
	if($type==2 || $type==3 || $type==4){
		$set_cond=" `sender`='{$test_adm_id}', `merID`='{$test_adm_id}', `receiver`=-2,`orderset`='{$post['sender']}' ";
		$mid=$post['sender'];
	}else {
		$set_cond=" `receiver`='{$test_adm_id}', `merID`='{$test_adm_id}' ";
		$mid=$post['receiver'];
	}
	db_query(
		"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" SET ".$set_cond.
		" WHERE `id`={$id}",0
	);
	
	/*
	$post['ab']=account_balance($mid);
	$available_balance=$post['ab']['summ_total_amt'];
	
	db_query("UPDATE `{$data['DbPrefix']}clientid_table`"." SET `available_balance`={$available_balance} WHERE `id`={$mid}");
	
	*/
	
	exit;
}elseif(isset($post['edit']) && $post['edit']){
	//global $data;
	$id = $post['gid'];
	if(isset($data['qp'])&&!empty($data['qp'])){
		echo "<br/>id=>".$id;
		echo "<br/><br/>";
		print_r($_POST);
	}
	/*
	if(!$post['receiver']){
	  $data['Error']='Please Enter MID';
	}elseif(!$post['acquirer']){
	  $data['Error']='Please Select Account ID.';
	}elseif(!$post['amount']){
	  $data['Error']='Please enter Amount!';
	}else
	*/
	//
	//{	
		//if($post['tableid']){$account_type="check";}else{$account_type="card";}
		
		$account_type="card";
		
		
		$tdate=date("Y-m-d H:i:s",strtotime($post['tdate']));
		
		if(isset($data['con_name'])&&$data['con_name']=='clk'){
			$update_append=" ,`gst_amt`='{$post['gst_amt']}' ";
		}else{
			$update_append="";
		}
		
		
	
		@db_query(
                "UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
                " SET `status`='{$post['status']}',`tdate`='{$tdate}',`transID`='{$post['transID']}',`merID`='{$post['merID']}',`amount`='{$post['amount']}',`fees`='{$post['fees']}',`acquirer`='{$post['acquirer']}',`fullname`='{$post['fullname']}',`bill_address`='{$post['bill_address']}',`bill_city`='{$post['bill_city']}',`bill_state`='{$post['bill_state']}',`bill_zip`='{$post['bill_zip']}',`bill_email`='{$post['bill_email']}',`bill_phone`='{$post['bill_phone']}',`product_name`='{$post['product_name']}',`support_note`='{$post['support_note']}',`acquirer_ref`='{$post['acquirer_ref']}',`acquirer_response`='{$post['acquirer_response']}',`source_url`='{$post['source_url']}',`mop`='{$post['mop']}',`webhook_url`='{$post['webhook_url']}',`return_url`='{$post['return_url']}',`failed_url`='{$post['failed_url']}',`country`='{$post['country']}',`tableid`='{$post['tableid']}',`bill_currency`='{$post['bill_currency']}',`transaction_flag`='{$post['transaction_flag']}',`system_note`='{$post['system_note']}',`bankaccount`='{$post['bankaccount']}',`routing_aba`='{$post['routing_aba']}',`descriptor`='{$post['descriptor']}',`buy_mdr_amt`='{$post['buy_mdr_amt']}',`buy_txnfee_amt`='{$post['buy_txnfee_amt']}',`rolling_amt`='{$post['rolling_amt']}',`mdr_cb_amt`='{$post['mdr_cb_amt']}',`mdr_cbk1_amt`='{$post['mdr_cbk1_amt']}',`mdr_refundfee_amt`='{$post['mdr_refundfee_amt']}',`available_rolling`='{$post['available_rolling']}',`available_balance`='{$post['available_balance']}',`payable_amt_of_txn`='{$post['payable_amt_of_txn']}',`fee_update_timestamp`='{$post['fee_update_timestamp']}',`trans_amt`='{$post['trans_amt']}',`remark_status`='{$post['remark_status']}',`bill_ip`='{$post['bill_ip']}',`comments`='{$post['comments']}',`mer_note`='{$post['mer_note']}',`bank_processing_amount`='{$post['bank_processing_amount']}',`bank_processing_curr`='{$post['bank_processing_curr']}',`json_value`='{$post['json_value']}',`trans_response`='{$post['trans_response']}',`active`='{$post['active']}'   ".$update_append.
                " WHERE `id`='{$id}'",$data['qp']
        );
		if(isset($data['qp'])&&!empty($data['qp'])){
			
			exit;
		}
		json_log_upd($id,'transactions','Update');
		
		 echo "<h2>Transaction Update Successfully</h2>";
	 exit;
	//}
	
}else{

		global $data;
	    $id = $post['gid'];
		//echo "<div style='margin-top:100px;'></div>"; print_r($id);
		$updateList=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
                " WHERE `id`={$id} LIMIT 1"
        );
        
		$results=array();
        foreach($updateList as $key=>$value){
                foreach($value as $name=>$v)$results[$key][$name]=$v;
        }
		if($results)foreach($results[0] as $key=>$value)if(!isset($post[$key]))$post[$key]=$value;
        
		$_SESSION['account_id']=$post['acquirer'];
		
		$post['bankaccount']=decryptres($post['bankaccount']);
		
		
		if($post['tableid']){
			$account_type="check";
		}else{
			$account_type="card";
		}
		
		if($account_type=="check"){
			
			
			$echeck_where="";
			if($post['tableid']){
				$echeck_where= "`id`={$post['tableid']}";
			}elseif($post['transID']){
				$echeck_where= "`unique_id`='{$post['transID']}' AND `clientid`={$post['receiver']}";
			}
			
			
			$updateList=db_rows(
					"SELECT * FROM `{$data['DbPrefix']}echeck`".
					" WHERE {$echeck_where} LIMIT 1",0
			);
			
			$results=array();
			foreach($updateList as $key=>$value){
					foreach($value as $name=>$v)$results[$key][$name]=$v;
			}
			if($results)foreach($results[0] as $key=>$value)if(!$post[$key])$post[$key]=$value;
			
			
			if(!$post['tableid']){
				$post['tableid']=$updateList[0]['id'];
			}
			
			if(!$post['fullname']){
				if(isset($updateList[0]['fullname'])&&$updateList[0]['fullname'])
					$post['fullname']=$value['fullname'];	//if fullname exist then use fullname
				else	//if fullname not exists then concat fname and lname
				$post['fullname']=$updateList[0]['fname']." ".$updateList[0]['lname'];
			}
			
		}
		
		
		
		if(($post['fee_update_timestamp']=='0000-00-00 00:00:00')||(empty($post['fee_update_timestamp']))||(!$post['fee_update_timestamp'])){
			$post['fee_update_timestamp']=date('Y-m-d');
		}
		
        $post['actn']='update';
        $post['step']++;

}
/*
$post['AccountInfo']=mer_settings($post['receiver']);
		
		if($post['tableid']){
			$account_type="check";
		}else{
			$account_type="card";
		}
*/		
		$account_type="card";
		if(isset($post['bill_state'])&&$post['bill_state']){
		$state_iso2=get_state_code($post['bill_state']);
		}

//echo "</hr>now=".now();

showpage("common/template.similar_trans".$data['iex']);exit;

?>

