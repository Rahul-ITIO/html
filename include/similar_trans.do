<?
$data['PageName']	= 'Similar Trans';
$data['PageFile']	= 'create_similar_trans'; 

###############################################################################
if(isset($_REQUEST['gid'])&&$_REQUEST['gid']>0){
	//$data['G_MID']=$_REQUEST['gid'];
}

include('../config.do');
//include('../config_db.do');
$get_clr=domain_serverf("","admin");
$data['bg_clrs'] 	=$get_clr['header_bg_color'];
$data['bg_txtclrs'] =$get_clr['header_text_color'];
//print_r($dd);
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
if(strpos($urlpath,"edit_trans")!==false){
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

//as per request connection if multiple 
	if(isset($data['DB_CON'])&&isset($_REQUEST['DBCON'])&&trim($_REQUEST['DBCON'])&&function_exists('config_db_more_connection'))
	{
		$DBCON=(isset($_REQUEST['DBCON'])?$_REQUEST['DBCON']:"");
		$dbad=(isset($_REQUEST['dbad'])?$_REQUEST['dbad']:"");
		$dbmt=(isset($_REQUEST['dbmt'])?$_REQUEST['dbmt']:"");
		config_db_more_connection($DBCON,$dbad,$dbmt);
		
	}


###############################################################################
//Select Data from master_trans_additional
$join_additional=join_additional();


$custom_settlement_optimizer_v3=0;

if(isset($_REQUEST['csov3']) && @$_REQUEST['csov3']==1){
	$custom_settlement_optimizer_v3=1;
	
}

$post['cso3']=@$custom_settlement_optimizer_v3;

// Table Withdraw of custom settlement optimizer v3
if($custom_settlement_optimizer_v3==1){
	$master_trans_table_set=$data['CUSTOM_SETTLEMENT_OPTIMIZER_V3'];
	$join_additional='';
	$mts="`t`";
}
// Trans Master Table & Additional Table
else {
	$master_trans_table_set=$data['MASTER_TRANS_TABLE'];
}


###############################################################################

//echo "<br/>is_admin=>".$is_admin;

if(isset($post['send']) && $post['send'] && $is_admin){


			if($is_admin==false){
				$post['receiver']=@$_SESSION['uid'];
				$post['merID']=@$_SESSION['uid'];
				//$post['tdate']=$_SESSION['uid'];
				$post['tdate_time']=date('Y-m-d h:i:s',strtotime('-6 hour',strtotime(date('Y-m-d h:i:s'))));
				$post['tdate']=date('Y-m-d h:i:s',strtotime('-6 hour',strtotime(date('Y-m-d h:i:s'))));
				$post['trans_status']=0;
				$post['acquirer']=@$_SESSION['account_id'];
			}
		
		if(!isset($post['merID'])){
			  $data['Error']='Please Enter MerID';
			}elseif(!$post['acquirer']){
			  $data['Error']='Please Select Acquirer';
			}elseif(!isset($post['bill_amt']) || empty($post['bill_amt'])){
			  $data['Error']='Please enter bill_amt!';
			}else{
			
				
			
				$account_type="card";
				
				$comments_date = date('Y-m-d H:i:s');
                
				$transID = $post['acquirer'].date("ymdHis");
				
				
				$ctime = date('H:i:s',strtotime($post['tdate_time']));
				$tdate=micro_current_date();
				$related_id ="";
				
				
				$rmk_date=date('d-m-Y h:i:s A');
				
				$system_note_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg> Duplicate transaction created from the <a class=viewthistrans>".$post['transID']."</a> - Admin</div></div>";
				
				$system_note=$system_note_upd.$post['system_note'];
				
							
				
				if(isset($data['con_name'])&&$data['con_name']=='clk'){
					$insert_append1=" ,`gst_amt` ";
					$insert_append2=" ,'{$post['gst_amt']}' ";
				}else{
					$insert_append1="";
					$insert_append2="";
				}
				
					

				if(empty(trim($post['bill_amt']))) $post['bill_amt']='0.00';
				if(empty(trim($post['buy_mdr_amt']))) $post['buy_mdr_amt']='0.00';
				if(empty(trim($post['buy_txnfee_amt']))) $post['buy_txnfee_amt']='0.00';
				if(empty(trim($post['rolling_amt']))) $post['rolling_amt']='0.00';
				if(empty(trim($post['mdr_cb_amt']))) $post['mdr_cb_amt']='0.00';
				if(empty(trim($post['mdr_cbk1_amt']))) $post['mdr_cbk1_amt']='0.00';
				if(empty(trim($post['mdr_refundfee_amt']))) $post['mdr_refundfee_amt']='0.00';
				if(empty(trim($post['available_rolling']))) $post['available_rolling']='0.00';
				if(empty(trim($post['available_balance']))) $post['available_balance']='0.00';
				if(empty(trim($post['payable_amt_of_txn']))) $post['payable_amt_of_txn']='0.00';
				if(empty(trim($post['trans_amt']))) $post['trans_amt']='0.00';
				if(empty(trim($post['bank_processing_amount']))) $post['bank_processing_amount']='0.00';

				
			$additional_fld=$master_fld=", `bill_address`, `bill_city`, `bill_state`, `bill_zip`, `bill_phone`,`product_name`,`support_note`,`acquirer_ref`,`acquirer_response`,`json_value`,`source_url`,`webhook_url`,`return_url`,`bill_country`,`system_note`,`descriptor`,`trans_response`,`mer_note`   " ;
			
			$additional_data=$master_data=", '{$post['bill_address']}','{$post['bill_city']}','{$post['bill_state']}','{$post['bill_zip']}','{$post['bill_phone']}','{$post['product_name']}','{$post['support_note']}','{$post['acquirer_ref']}','{$post['acquirer_response']}','{$post['json_value']}','{$post['source_url']}', '{$post['webhook_url']}','{$post['return_url']}','{$post['bill_country']}','{$system_note}','{$post['descriptor']}','{$post['trans_response']}','{$post['mer_note']}' " ;
			
			if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
				$master_fld=''; $master_data='';}
				
				
				db_query(
					"INSERT INTO `{$data['DbPrefix']}{$master_trans_table_set}`".
					"(`tdate`,`transID`,`merID`,`bill_amt`,`acquirer`,".
					"`trans_status`, `fullname`, `bill_email`  ,`mop`,`bill_currency`,`buy_mdr_amt`,`buy_txnfee_amt`,`rolling_amt`,`mdr_cb_amt`,`mdr_cbk1_amt`,`mdr_refundfee_amt`,`available_rolling`,`available_balance`,`payable_amt_of_txn`,`fee_update_timestamp`,`trans_amt`,`remark_status`,`bill_ip`,`terNO`".$insert_append1.$master_fld.")VALUES(".
					"'{$tdate}','{$transID}','{$post['merID']}','{$post['bill_amt']}','{$post['acquirer']}',".
					"'{$post['trans_status']}','{$post['fullname']}','{$post['bill_email']}','{$post['mop']}','{$post['bill_currency']}'  ,'{$post['buy_mdr_amt']}','{$post['buy_txnfee_amt']}','{$post['rolling_amt']}','{$post['mdr_cb_amt']}','{$post['mdr_cbk1_amt']}','{$post['mdr_refundfee_amt']}','{$post['available_rolling']}','{$post['available_balance']}','{$post['payable_amt_of_txn']}','{$post['fee_update_timestamp']}','{$post['trans_amt']}','{$post['remark_status']}','{$post['bill_ip']}','{$post['terNO']}'".$insert_append2.$master_data.
					" )",$data['cqp']
				);
				$transactions_newid=newid();
				$transID = gen_transID_f($transactions_newid,$post['acquirer'],1);
				
				$tableName=$master_trans_table_set;
				
				//insert data to new table for master_trans_additional and this value is Y  
				if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
					db_query("INSERT INTO `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` (`id_ad`,`transID_ad` ".$additional_fld.")VALUES".
					"('{$transactions_newid}','{$transID}' ".$additional_data.")",$data['cqp']);
					$tableName=$data['ASSIGN_MASTER_TRANS_ADDITIONAL'];
				}
				
				if($data['cqp']==9) 
				{ 
					exit;
				}
				
				json_log_upd($transactions_newid,$tableName,'Insert');
				echo "</hr>transID=>".$transID." <br/>newid=>".$transactions_newid; 
				
				echo"
				<script>
					window.parent.alert('$transID successful transaction has been created');
				</script>
				";
				
				exit;
				
				
					
				
				//send_email('REQUEST-MONEY', $post);
				$data['PostSent']=true;
				//header("location:".$data['Admins']."/bank_gateway.htm");
				
				
				
          }
					
}elseif(isset($post['delete']) && $post['delete']){
	//global $data;
	$id = $post['gid'];
	$type = $post['acquirer'];
	
	
	if(isset($data['TEST_ADM_ID'])&&$data['TEST_ADM_ID']){
	  $test_adm_id=$data['TEST_ADM_ID'];
	}else{
		$test_adm_id=3333;
	}
	
	if($type==2 || $type==3 || $type==4){
		$set_cond=" `merID`='{$test_adm_id}' ";
		$mid=$post['merID'];
	}else {
		$set_cond=" `merID`='{$test_adm_id}' ";
		$mid=$post['merID'];
	}
	db_query(
		"UPDATE `{$data['DbPrefix']}{$master_trans_table_set}`".
		" SET ".$set_cond.
		" WHERE `id`={$id}",0
	);
	
	
	
	exit;
}elseif(isset($post['edit']) && $post['edit']){
	//global $data;
	$id = $post['gid'];
	if(@$data['cqp']>0)$data['qp']=$data['cqp'];
	if(isset($data['qp'])&&!empty($data['qp'])&&$data['qp']==6){
		echo "<br/>id=>".$id;
		echo "<br/><br/>";
		print_r($_POST);
	}
	
		
		
		
		$account_type="card";
		$post['terNO']=(int)@$post['terNO'];
		
		
		$tdate=date("Y-m-d H:i:s",strtotime($post['tdate']));
		
		
		if(isset($data['con_name'])&&$data['con_name']=='clk'){
			if(empty(trim($post['gst_amt']))) $post['gst_amt']='0.00';
			$update_append=" ,`gst_amt`='{$post['gst_amt']}' ";
		}else{
			$update_append="";
		}
		
		
		// query update for master_trans_additional
		$additional_update=$master_update=",`bill_address`='{$post['bill_address']}',`bill_city`='{$post['bill_city']}',`bill_state`='{$post['bill_state']}',`bill_zip`='{$post['bill_zip']}',`bill_phone`='{$post['bill_phone']}',`product_name`='{$post['product_name']}',`support_note`='{$post['support_note']}',`acquirer_ref`='{$post['acquirer_ref']}',`acquirer_response`='{$post['acquirer_response']}',`source_url`='{$post['source_url']}',`webhook_url`='{$post['webhook_url']}',`return_url`='{$post['return_url']}',`bill_country`='{$post['bill_country']}',`system_note`='{$post['system_note']}',`descriptor`='{$post['descriptor']}',`mer_note`='{$post['mer_note']}',`json_value`='{$post['json_value']}',`trans_response`='{$post['trans_response']}' " ;	
		
		$tableName=$master_trans_table_set;

		if(@$data['qp'])
		{
			echo "<br/><hr/>tableName=>".$tableName;
		}

		if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'&&$custom_settlement_optimizer_v3==0){
			$master_update='';
			//$additional_update=ltrim($additional_update,',');
			db_query("UPDATE `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` SET `transID_ad`='{$post['transID']}' ".$additional_update." WHERE `id_ad`='".$id."' ",$data['qp']); 
			$tableName=$data['ASSIGN_MASTER_TRANS_ADDITIONAL'];
		}
		
		
		if(empty(trim($post['bill_amt']))) $post['bill_amt']='0.00';
		if(empty(trim($post['buy_mdr_amt']))) $post['buy_mdr_amt']='0.00';
		if(empty(trim($post['buy_txnfee_amt']))) $post['buy_txnfee_amt']='0.00';
		if(empty(trim($post['rolling_amt']))) $post['rolling_amt']='0.00';
		if(empty(trim($post['mdr_cb_amt']))) $post['mdr_cb_amt']='0.00';
		if(empty(trim($post['mdr_cbk1_amt']))) $post['mdr_cbk1_amt']='0.00';
		if(empty(trim($post['mdr_refundfee_amt']))) $post['mdr_refundfee_amt']='0.00';
		if(empty(trim($post['available_rolling']))) $post['available_rolling']='0.00';
		if(empty(trim($post['available_balance']))) $post['available_balance']='0.00';
		if(empty(trim($post['payable_amt_of_txn']))) $post['payable_amt_of_txn']='0.00';
		if(empty(trim($post['trans_amt']))) $post['trans_amt']='0.00';
		if(empty(trim($post['bank_processing_amount']))) $post['bank_processing_amount']='0.00';

		//wv3
		if(@$custom_settlement_optimizer_v3==1)
			$master_update=",`support_note`='{$post['support_note']}',`acquirer_ref`='{$post['acquirer_ref']}',`acquirer_response`='{$post['acquirer_response']}',`source_url`='{$post['source_url']}',`webhook_url`='{$post['webhook_url']}',`system_note`='{$post['system_note']}',`json_value`='{$post['json_value']}',`trans_response`='{$post['trans_response']}' " ;

		else $master_update.=",`bill_email`='{$post['bill_email']}',`transaction_flag`='{$post['transaction_flag']}',`mdr_refundfee_amt`='{$post['mdr_refundfee_amt']}',`mdr_cbk1_amt`='{$post['mdr_cbk1_amt']}',`terNO`='{$post['terNO']}'";
		
		// query update for master_trans_table 
		@db_query(
                "UPDATE `{$data['DbPrefix']}{$master_trans_table_set}`".
                " SET `trans_status`={$post['trans_status']},`tdate`='{$tdate}',`transID`='{$post['transID']}',`merID`='{$post['merID']}',`bill_amt`='{$post['bill_amt']}',`acquirer`='{$post['acquirer']}',`fullname`='{$post['fullname']}',`mop`='{$post['mop']}',`bill_currency`='{$post['bill_currency']}',`buy_mdr_amt`='{$post['buy_mdr_amt']}',`buy_txnfee_amt`='{$post['buy_txnfee_amt']}',`rolling_amt`='{$post['rolling_amt']}',`mdr_cb_amt`='{$post['mdr_cb_amt']}',`available_rolling`='{$post['available_rolling']}',`available_balance`='{$post['available_balance']}',`payable_amt_of_txn`='{$post['payable_amt_of_txn']}',`fee_update_timestamp`='{$post['fee_update_timestamp']}',`trans_amt`='{$post['trans_amt']}',`remark_status`='{$post['remark_status']}',`bill_ip`='{$post['bill_ip']}',`bank_processing_amount`='{$post['bank_processing_amount']}',`bank_processing_curr`='{$post['bank_processing_curr']}'  ".$update_append.$master_update.
                " WHERE `id`='{$id}'",$data['qp']
        );
		
		
		
		if(isset($data['qp'])&&!empty($data['qp'])){
			exit;
		}
		json_log_upd($id,$tableName,'Update');
		
		 echo "<h2>Transaction Update Successfully</h2>";
	 exit;
	//}
	
}else{

		
		
				
		
	    $id = $post['gid'];
		//echo "<div style='margin-top:100px;'>ffffffffffff</div>"; print_r($id);
		$updateList=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}{$master_trans_table_set}`".
			" {$join_additional} WHERE `id`={$id} LIMIT 1",0
        );
        
		$results=array();
        foreach($updateList as $key=>$value){
                foreach($value as $name=>$v)$results[$key][$name]=$v;
        }
		if($results)foreach($results[0] as $key=>$value)if(!isset($post[$key]))$post[$key]=$value;
        
		
		
		
		$account_type="card";
		
		
		
		if((isset($post['fee_update_timestamp'])&&$post['fee_update_timestamp']=='0000-00-00 00:00:00')||(empty($post['fee_update_timestamp']))||(!isset($post['fee_update_timestamp']))){
			$post['fee_update_timestamp']=date('Y-m-d');
		}
		
        $post['actn']='update';
        $post['step']++;

}

	
		$account_type="card";
		if(isset($post['bill_state'])&&$post['bill_state']){
			$post['state_iso2']=get_state_code($post['bill_state']);
		}

//echo "</hr>now=".now();

showpage("common/template.similar_trans".$data['iex']);exit;

?>

