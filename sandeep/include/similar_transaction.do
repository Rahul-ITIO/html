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
	$data['PageTitle'] = 'Edit|Delete|Cancelled Transaction';
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
				$post['owner_id']=$_SESSION['uid'];
				//$post['tdate']=$_SESSION['uid'];
				$post['tdate_time']=date('Y-m-d h:i:s',strtotime('-6 hour',strtotime(date('Y-m-d h:i:s'))));
				$post['tdate']=date('Y-m-d h:i:s',strtotime('-6 hour',strtotime(date('Y-m-d h:i:s'))));
				$post['status']=0;
				$post['type']=$_SESSION['account_id'];
			}
		
		if(!$post['receiver']){
			  $data['Error']='Please Enter MID';
			}elseif(!$post['type']){
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
                
				$transactioncode = $post['type'].date("ymdHis");
				
				
				$ctime = date('H:i:s',strtotime($post['tdate_time']));
				$tdate=date("Y-m-d ".$ctime,strtotime($post['tdate']));
				$related_id ="";
				
				
				$rmk_date=date('d-m-Y h:i:s A');
				
				$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg> Duplicate transaction created from the <a class=viewthistrans>".$post['transaction_id']."</a> - Admin</div></div>";
				
				$system_note=$system_note_upd.$post['system_note'];
				
				$post['bankaccount']=encryptres($post['bankaccount']);
				
				
				
				if(isset($data['con_name'])&&$data['con_name']=='clk'){
					$insert_append1=" ,`gst_fee` ";
					$insert_append2=" ,'{$post['gst_fee']}' ";
				}else{
					$insert_append1="";
					$insert_append2="";
				}
				
				db_query(
					"INSERT INTO `{$data['DbPrefix']}transactions`".
					"(`tdate`,`transaction_id`,`sender`,`receiver`,`owner_id`,`related`,`amount`,`fees`,`type`,".
					"`status`, `names`, `address`, `city`, `state`, `zip`, `email_add`, `phone_no`,".
					"`product_name`,`reply_remark`,`txn_id`,`txn_value`,`sender_fee`,`strice_price`,`source_url`,`cardtype`,`notify_url`,`success_url`,`failed_url`,`country`,`tableid`,`currname`,`transaction_flag`,`system_note`,`bankaccount`,`routing_aba`,`descriptor`,`mdr_amt`,`mdr_txtfee_amt`,`rolling_amt`,`mdr_cb_amt`,`mdr_cbk1_amt`,`mdr_refundfee_amt`,`available_rolling`,`available_balance`,`payable_amt_of_txn`,`fee_update_timestamp`,`transaction_amt`,`remark_status`,`ip`,`comments`,`remark`".$insert_append1.")VALUES(".
					"'{$tdate}','{$transactioncode}','-{$transactioncode}','{$post['receiver']}','{$post['owner_id']}','{$post['related']}','{$post['amount']}','{$post['fees']}','{$post['type']}',".
					"{$post['status']},'{$post['names']}','{$post['address']}','{$post['city']}','{$post['state']}','{$post['zip']}','{$post['email_add']}','{$post['phone_no']}',".
					"'{$post['product_name']}','{$post['reply_remark']}','{$post['txn_id']}','{$post['txn_value']}','{$post['sender_fee']}','{$post['strice_price']}','{$post['source_url']}','{$post['cardtype']}','{$post['notify_url']}','{$post['success_url']}','{$post['failed_url']}','{$post['country']}','".$related_id."','{$post['currname']}','{$post['transaction_flag']}','{$system_note}','{$post['bankaccount']}','{$post['routing_aba']}','{$post['descriptor']}','{$post['mdr_amt']}','{$post['mdr_txtfee_amt']}','{$post['rolling_amt']}','{$post['mdr_cb_amt']}','{$post['mdr_cbk1_amt']}','{$post['mdr_refundfee_amt']}','{$post['available_rolling']}','{$post['available_balance']}','{$post['payable_amt_of_txn']}','{$post['fee_update_timestamp']}','{$post['transaction_amt']}','{$post['remark_status']}','{$post['ip']}','{$post['comments']}','{$post['remark']}'".$insert_append2.
					" )",0
				);
				$transactions_newid=newid();
				$transactioncode = gen_transID_f($transactions_newid,$post['type'],1);
				json_log_upd($transactions_newid,'transactions','Insert');
				echo "</hr>transactioncode=>".$transactioncode." <br/>newid=>".$transactions_newid; 
				
				echo"
				<script>
					window.parent.alert('$transactioncode successful transaction has been created');
				</script>
				";
				
				exit;
				
				$data['sucess']		="true";
				$post['success']	="Account No.: ".$post['account_no'].", Bank Payment Url :".$post['bank_payment_url']." , Bank Merchant ID : ".$post['bank_merchant_id']." and Date is ".date("d-m-Y",strtotime($post['date']));
				$post['date']		=$post['date'];
				$post['step']--;
				$post['comments']= ""; $post['comments']--;
				
				
					
				
				//send_email('REQUEST-MONEY', $post);
				$data['PostSent']=true;
				//header("location:".$data['Admins']."/bank_gateway.htm");
				
				
				
          }
					
}elseif(isset($post['delete']) && $post['delete']){
	//global $data;
	$id = $post['gid'];
	$type = $post['type'];
	
	//echo $type;exit;
	
	/*
	db_query(
		"DELETE FROM `{$data['DbPrefix']}transactions`".
		" WHERE(`id`={$id})"
	);
	*/
	
	if(isset($data['TEST_ADM_ID'])&&$data['TEST_ADM_ID']){
	  $test_adm_id=$data['TEST_ADM_ID'];
	}else{
		$test_adm_id=3333;
	}
	
	if($type==2 || $type==3 || $type==4){
		$set_cond=" `sender`='{$test_adm_id}', `owner_id`='{$test_adm_id}', `receiver`='-2' ";
		$mid=$post['sender'];
	}else {
		$set_cond=" `receiver`='{$test_adm_id}', `owner_id`='{$test_adm_id}' ";
		$mid=$post['receiver'];
	}
	db_query(
		"UPDATE `{$data['DbPrefix']}transactions`".
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
	}elseif(!$post['type']){
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
			$update_append=" ,`gst_fee`='{$post['gst_fee']}' ";
		}else{
			$update_append="";
		}
		
		
		$related=(int)$post['related'];
		@db_query(
                "UPDATE `{$data['DbPrefix']}transactions`".
                " SET `status`='{$post['status']}',`tdate`='{$tdate}',`transaction_id`='{$post['transaction_id']}',`sender`='{$post['sender']}',`owner_id`='{$post['owner_id']}',`receiver`='{$post['receiver']}',`related`='{$related}',`amount`='{$post['amount']}',`fees`='{$post['fees']}',`type`='{$post['type']}',`names`='{$post['names']}',`address`='{$post['address']}',`city`='{$post['city']}',`state`='{$post['state']}',`zip`='{$post['zip']}',`email_add`='{$post['email_add']}',`phone_no`='{$post['phone_no']}',`product_name`='{$post['product_name']}',`reply_remark`='{$post['reply_remark']}',`txn_id`='{$post['txn_id']}',`txn_value`='{$post['txn_value']}',`source_url`='{$post['source_url']}',`cardtype`='{$post['cardtype']}',`notify_url`='{$post['notify_url']}',`success_url`='{$post['success_url']}',`failed_url`='{$post['failed_url']}',`country`='{$post['country']}',`tableid`='{$post['tableid']}',`currname`='{$post['currname']}',`transaction_flag`='{$post['transaction_flag']}',`system_note`='{$post['system_note']}',`bankaccount`='{$post['bankaccount']}',`routing_aba`='{$post['routing_aba']}',`descriptor`='{$post['descriptor']}',`mdr_amt`='{$post['mdr_amt']}',`mdr_txtfee_amt`='{$post['mdr_txtfee_amt']}',`rolling_amt`='{$post['rolling_amt']}',`mdr_cb_amt`='{$post['mdr_cb_amt']}',`mdr_cbk1_amt`='{$post['mdr_cbk1_amt']}',`mdr_refundfee_amt`='{$post['mdr_refundfee_amt']}',`available_rolling`='{$post['available_rolling']}',`available_balance`='{$post['available_balance']}',`payable_amt_of_txn`='{$post['payable_amt_of_txn']}',`fee_update_timestamp`='{$post['fee_update_timestamp']}',`transaction_amt`='{$post['transaction_amt']}',`remark_status`='{$post['remark_status']}',`ip`='{$post['ip']}',`comments`='{$post['comments']}',`remark`='{$post['remark']}',`bank_processing_amount`='{$post['bank_processing_amount']}',`bank_processing_curr`='{$post['bank_processing_curr']}',`json_value`='{$post['json_value']}',`reason`='{$post['reason']}',`active`='{$post['active']}'   ".$update_append.
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
			"SELECT * FROM `{$data['DbPrefix']}transactions`".
			" WHERE `id`={$id} LIMIT 1"
        );
        
		$results=array();
        foreach($updateList as $key=>$value){
                foreach($value as $name=>$v)$results[$key][$name]=$v;
        }
		if($results)foreach($results[0] as $key=>$value)if(!isset($post[$key]))$post[$key]=$value;
        
		//$_SESSION['account_id']=$post['type'];
		
		//$post['bankaccount']=decryptres($post['bankaccount']);
		
		$account_type="card";
		
		
		
		if((isset($post['fee_update_timestamp'])&&$post['fee_update_timestamp']=='0000-00-00 00:00:00')||(empty($post['fee_update_timestamp']))||(!isset($post['fee_update_timestamp']))){
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
		if(isset($post['state'])&&$post['state']){
		$state_iso2=get_state_code($post['state']);
		}

//echo "</hr>now=".now();

showpage("common/template.similar_transaction".$data['iex']);exit;

?>

