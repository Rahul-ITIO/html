<?php

// include/prvious_balance_db_clk_all_merchant_wise?a=merID
// include/prvious_balance_db_clk_all_merchant_wise?merID=6178,6226,6278,6009,6065,6339,6338,6394
// include/prvious_balance_db_clk_all_merchant_wise?merID=272,5742

// swich previous connection from withdraw and auto select current via default db 

// SELECT * FROM "zt_prvious_balance_db" ORDER BY id ASC

//SELECT * FROM public.zt_prvious_balance_db

// SELECT * FROM public.zt_prvious_balance_db ORDER BY udate DESC;

// pg_dump -h localhost -p 5432 -U pgslquser -t zt_prvious_balance_db -d livepsqldb33  > zt_prvious_balance_db_24_05_03.sql

include('../config.do');

if(!isset($_SESSION['login_adm'])){
       //header("Location:{$data['USER_FOLDER']}/login.do");
       echo('ACCESS DENIED.');
       exit;
}

echo "<br/>IS_DBCON_DEFAULT=>".@$data['IS_DBCON_DEFAULT']."<br/>";

//$data['CONNECTION_TYPE_DEFAULT']='';

if(isset($data['IS_DBCON_DEFAULT'])&&$data['IS_DBCON_DEFAULT']=='Y'){
	
	echo "Not required this action because all ready stay in Latest Connection "; exit;
	
}
//elseif(isset($data['DBCON_DEFAULT'])&&isset($data['default_hostname'])&&isset($data['connection_type'])&&isset($data['CONNECTION_TYPE_DEFAULT'])&&$data['connection_type']!=$data['CONNECTION_TYPE_DEFAULT'])
elseif(isset($data['DBCON_DEFAULT'])&&isset($data['default_hostname'])&&isset($data['default_database'])&&isset($data['default_username'])&&isset($data['default_username'])&&isset($data['CONNECTION_TYPE_DEFAULT'])&&trim($data['CONNECTION_TYPE_DEFAULT']))
{
	echo "<br/>connection dataDefault =>";print_r($dataDefault);
	echo "<br/>connection_type from =>".$data['connection_type'];
	echo "<br/>CONNECTION_TYPE_DEFAULT=>".$data['CONNECTION_TYPE_DEFAULT'];echo "<br/><br/>";
	
	if(@$data['CONNECTION_TYPE_DEFAULT']=='PSQL') db_connect_psql_default(@$data['default_hostname'],@$data['default_database'],@$data['default_username'],@$data['default_password'],@$data['default_DbPort']);
	
	elseif(@$data['CONNECTION_TYPE_DEFAULT']=='MYSQLI') db_connect_mysqli_default(@$data['default_hostname'],@$data['default_database'],@$data['default_username'],@$data['default_password'],@$data['default_DbPort']);
	
}



//Update balance upto till date
function save_prvious_balance_db_f(){
	global $data;$qprint=1;
	//$qprint=$data['cqp'];
	$result=array();
	
	
	//$_GET['tr_bal_upd']='submit';
	//$_GET['all_merchant_wise_update']='Admin';
	
	//fetch unique merID from transactions table
	if(isset($_GET['a'])&&trim($_GET['a'])&&$_GET['a']=='merID') 
	{
		
		$merID_get=db_rows(
			"SELECT ".group_concat_return('`merID`',1)." AS `merID`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" LIMIT 1 ",$qprint
		);
		
		$merID_all=explode(',',$merID_get[0]['merID']);
		
		echo "<hr/>Al count=>".count($merID_all)."<hr/>"; 
		echo "<hr/>merID_all=>"; print_r($merID_all); 
		
	}

	
	
	if(isset($_GET['merID'])&&trim($_GET['merID'])) {
		$merID_all=explode(',',$_GET['merID']);
	}
	
		
	
	//$merID_all=["27","5940"];
	//$merID_all=["11311","11359"];
	//$merID_all=["272"];
	
	echo "<hr/>count=>".count($merID_all)."<hr/>"; 
	echo "<hr/>merID_all=>"; print_r($merID_all); 
	
	//exit;
	
	
	$prvious_balance_db='prvious_balance_db';
	
	$DB_CON=(isset($_SESSION['DB_CON'])?@$_SESSION['DB_CON']:'');
	$db_ad=(isset($_SESSION['db_ad'])?@$_SESSION['db_ad']:'');
	$db_mt=(isset($_SESSION['db_mt'])?@$_SESSION['db_mt']:'');
	
	$db_from_arr=[];
	$db_from_arr['DB_CON']=$DB_CON;
	$db_from_arr['db_ad']=$db_ad;
	$db_from_arr['db_mt']=$db_mt;
	$db_from_arr['connection_type']=$data['connection_type'];
	$db_from_arr['db_database']=$data['Database'];
	$db_from_arr['db_username']=$data['Username'];
	$db_from_arr['db_hostname']=@$data['Hostname'];
	
	$db_from=jsonencode($db_from_arr,1,1);
	
	foreach($merID_all as $key=>$value){
		
		$clientid=$value;
		$project_type='IND';
		$udate=micro_current_date();
		
		
		
		//fetch IND CLK Balance : start -------------------------
		
		$trans_detail_array = fetch_trans_balance($clientid);	//FETCH all the transaction from zt_transactions table via membrer id 
		
		$deduction_array = ms_trans_balance_calc_d_new($clientid,'',0,$trans_detail_array);	//Fetch the transaction / calculation - Only deduction amount fetch of a clients 
				
		//Dev Tech : 23-09-29 Real Time calculation fetch as a dynamic from 
		$post['ab']=$deduction_array;
		

		$total_mdr 				= stringToNumber($deduction_array['total_mdr']);	//Total MDR
		$total_txn_fee 			= stringToNumber($deduction_array['total_txn_fee']);	//Total Transction Fee
		$total_txn_fee_failed	= stringToNumber($deduction_array['total_txn_fee_failed']);	//Total Transaction fee on failed transaction
		$total_amt_chargeback	= stringToNumber($deduction_array['total_amt_chargeback']);	//Total charge back amount
		$total_chargeback_fee	= stringToNumber($deduction_array['total_chargeback_fee']);	//total charge back fee
		$total_gst_fee			= stringToNumber(@$deduction_array['total_gst_fee']);	//total GST  fee
		$total_amt_refunded		= stringToNumber($deduction_array['total_amt_refunded']);	//Total refunded amount
		$total_amt_cbk1			= stringToNumber($deduction_array['total_amt_cbk1']);	//Total CBK1 amount

		$total_deductions = $total_mdr+$total_txn_fee+$total_txn_fee_failed+$total_amt_chargeback+$total_chargeback_fee+$total_amt_refunded+$total_amt_cbk1+$total_gst_fee;	//sum of deduction
		
		
		//fetch IND CLK Balance : end -------------------------
		
		$total_current_balance_amt= getNumericValue($post['ab']['summ_total']);
		$total_settlement_processed_amt= getNumericValue($post['ab']['summ_withdraw']);
		$total_deductions_amt= $total_deductions;
		$total_mdr_amt= $total_mdr;
		$total_gst_amt= $total_gst_fee;
		$total_refund_amt= $total_amt_refunded;
		
		echo "<br/>total_current_balance_amt=>".$total_current_balance_amt;

		//fetch id of from prvious_balance_db via merID
		$select_prvious_balance_qr="SELECT * ".
			" FROM `{$data['DbPrefix']}{$prvious_balance_db}`".
			" WHERE ( `clientid`='".$value."' ) AND (`project_type` IN ('IND') ) AND (`db_from` IN ('{$db_from}') )  ".
			" ORDER BY `id` ASC LIMIT 1";
			
		if($data['CONNECTION_TYPE_DEFAULT']=='PSQL')
			$pbd_id_fetch=db_rows_psql_default($select_prvious_balance_qr,$qprint);
		else $pbd_id_fetch=db_rows($select_prvious_balance_qr,$qprint);	
		$pbd_id=(int)@$pbd_id_fetch[0]['id'];
		
		//json log set 
		$json_log_get=@$pbd_id_fetch[0]['json_log'];
		$json_log_arr=[];
		if(isset($json_log_get)&&trim($json_log_get)){
			$json_log_arr=jsondecode($json_log_get,1,1);
		}
		
		/*
		if(isset($pbd_id_fetch[0]))
		{
			$pbd_data=$pbd_id_fetch[0];
			if(isset($pbd_data['json_log'])) unset($pbd_data['json_log']);
			
			$json_log_arr['time_log_'.(new DateTime())->format('Y-m-d H:i:s.u')]=$pbd_data;
			
			echo "json_log_arr=>"; print_r($json_log_arr);
				
			$json_log=jsonencode($json_log_arr,1,1);
		}
		else 
			*/
			$json_log='';
		
		if(isset($pbd_id)&&$pbd_id>0){
			
			$qry_update_prvious_balance_db="UPDATE  `{$data['DbPrefix']}{$prvious_balance_db}` SET ".
				" `total_current_balance_amt` ={$total_current_balance_amt}, ".
				" `total_settlement_processed_amt` ={$total_settlement_processed_amt}, ".
				" `total_deductions_amt` ={$total_deductions_amt}, ".
				" `total_mdr_amt` ={$total_mdr_amt}, ".
				" `total_gst_amt` ={$total_gst_amt}, ".
				" `total_refund_amt` ={$total_refund_amt}, ".
				" `project_type` ='{$project_type}', ".
				" `udate` ='{$udate}', ".
				" `db_from` ='{$db_from}', ".
				" `json_log` ='{$json_log}' ".
				"WHERE `id`='{$pbd_id}' ";
								
			//if($pq) 
			//echo "<br/><hr/><br/>qry_update_prvious_balance_db=><br/>".$qry_update_prvious_balance_db."<br/>";
			
			if($data['CONNECTION_TYPE_DEFAULT']=='PSQL')
				db_query_psql_default($qry_update_prvious_balance_db,$qprint);
			elseif($data['CONNECTION_TYPE_DEFAULT']=='MYSQLI')
				db_query_mysqli_default($qry_update_prvious_balance_db,$qprint);
			else db_query($qry_update_prvious_balance_db,$qprint);
			
			
		}else{
			
			
			$qry_insert_prvious_balance_db="INSERT INTO `{$data['DbPrefix']}{$prvious_balance_db}`".
				"(`udate`,`clientid`,`total_current_balance_amt`,`total_settlement_processed_amt`,`total_deductions_amt`,`total_mdr_amt`,`total_gst_amt`,`total_refund_amt`,`project_type`,`json_log`,`db_from`)VALUES(".
				"'{$udate}','{$clientid}','{$total_current_balance_amt}','{$total_settlement_processed_amt}','{$total_deductions_amt}','{$total_mdr_amt}',".
				"'{$total_gst_amt}','{$total_refund_amt}','{$project_type}','{$json_log}','{$db_from}'".
				" )";
			
			//echo "<br/><hr/><br/>qry_insert_prvious_balance_db=><br/>".$qry_insert_prvious_balance_db."<br/>";
			
			if($data['CONNECTION_TYPE_DEFAULT']=='PSQL')
				db_query_psql_default($qry_insert_prvious_balance_db,$qprint);
			elseif($data['CONNECTION_TYPE_DEFAULT']=='MYSQLI')
				db_query_mysqli_default($qry_insert_prvious_balance_db,$qprint);
			else db_query($qry_insert_prvious_balance_db,$qprint);
			
			//db_query($qry_insert_prvious_balance_db,$qprint);
			//$pbd_newid=newid();
			
			
				
		}
	}

	print_r($merID_all);
}

$all_m=save_prvious_balance_db_f();

db_disconnect();
//db_disconnect_psql_default();
//db_disconnect_mysqli_default();

exit;
 
?>