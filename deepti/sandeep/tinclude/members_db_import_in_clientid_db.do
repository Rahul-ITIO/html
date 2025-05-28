<?
// 		/tinclude/members_db_import_in_clientid_db.do?key='SIGNUP-TO-MEMBER'


include('../config.do');

if(!isset($_SESSION['adm_login'])){
	//header("Location:{$data['Members']}/login.do");
	echo('ACCESS DENIED.');
	exit;
}
$type=0;
$limit=' LIMIT 2 ';
$limit='  ';
$key_query='';
if(isset($_GET['type'])&&$_GET['type']>0){
		$type=$_GET['type'];
}
if(isset($_GET['li'])&&$_GET['li']>0){
		$limit=' LIMIT '.$_GET['li'] .' ';
}

if(isset($_GET['key'])&&$_GET['key']>0){
		$key_ex=explode(",",$_GET['key']);
		$key_im="'".implode("'",$key_ex)."'";
		$key_query="  WHERE  `key`  IN  ({$key_im})  ";
		$limit='  ';
}

$successkeyName=[];
$failedkeyName=[];
$failedkeyNameResult=[];

//$qp=1;

// manual 
{
	
	$slct=db_rows(
		"SELECT * ".
		//" FROM `nextgendb1`.`{$data['DbPrefix']}members`".
		" FROM `{$data['DbPrefix']}members`".
			" ".$key_query.
			" ".$limit.
		" ",1
	);
	

	
	$clientid_start=($slct[0]['id']);
	
	echo "<hr/>count=>".count($slct)."<br/><br/>";
	echo "<hr/>1st ID=>".$clientid_start."<br/><br/>";
	
//exit;

	db_query(
		"TRUNCATE `{$data['DbPrefix']}clientid_table` ",1
	);
	db_query(
		"TRUNCATE `{$data['DbPrefix']}clientid_emails` ",1
	);
	db_query(
		"TRUNCATE `{$data['DbPrefix']}payin_setting` ",1
	);
	db_query(
		"TRUNCATE `{$data['DbPrefix']}payout_setting` ",1
	);
	
	db_query(
		"ALTER TABLE `{$data['DbPrefix']}clientid_table` AUTO_INCREMENT = {$clientid_start}",1
	);
	
//exit;

		$i=0;
		foreach($slct as $key=>$value){
			$i++;
			
				if(empty($value['fullname'])&&!empty($value['fname'])&&!empty($value['lname'])){
					$fullname=$value['fname']." ".$value['lname'];
				}else {
					$fullname=$value['fullname'];
				}

				echo "<br/><br/>clientid_table_2_db=><br/>";
				
				
				echo $i.". ID=>".$value['id']." | username=>".$value['username']."<br/>";
				
				if($value['member_id']) $member_id=$value['member_id'];
				else $member_id=NULL;
				
				$insertSql = "INSERT INTO `{$data['DbPrefix']}clientid_table`(".
					"`sponsor`,`username`,`password`,`registered_email`,`active`,`status`,`edit_permission`,".
					"`fullname`,`company_name`,`json_value`,`country`,`ip_block_client`,`encoded_contact_person_info`,`registered_address`,`private_key`,`daily_password_count`,`deleted_email`,`sub_client_id`,`sub_client_role`,`google_auth_access`,`google_auth_code`,`default_currency`,`previous_passwords`,`password_updated_date`,`last_login_date` ,`created_date` ,`payout_request` ,`qrcode_gateway_request`      ".
					")VALUES(".
					"{$value['sponsor']},'{$value['username']}','{$value['password']}',".
					"'{$value['email']}','{$value['active']}','{$value['status']}','{$value['edit_permission']}','{$fullname}',".
					"'{$value['company']}','{$value['json_value']}','{$value['country']}','{$value['ip_block_member']}','{$value['principal']}','{$value['business_address']}','{$value['apikey']}','{$value['daily_password_count']}','{$value['deleted_email']}','{$member_id}','{$value['member_role']}','{$value['google_auth_access']}','{$value['google_auth_code']}','{$value['default_currency']}','{$value['previous_passwords']}' ,'{$value['password_updated_date']}','{$value['ldate']}','{$value['cdate']}','{$value['payout_request']}','{$value['qrcode_gateway_request']}'     ".
					")";
					
				//echo $insertSql;exit;
				db_query($insertSql,1);
				$clientid=newid();
			
	
				if($clientid>0){
					
					echo "<br/><br/>clientid_emails_db=><br/>";
					
					db_query(
						"INSERT INTO `{$data['DbPrefix']}clientid_emails`(".
						"`clientid`,`email`,`active`,`primary` ".
						")VALUES(".
						"{$clientid},'{$value['email']}','1','1'    )",1
					);
					
					
					echo "<br/><br/>payin_setting_db=><br/>";
						
					db_query(
						"INSERT INTO `{$data['DbPrefix']}payin_setting`(".
						"`clientid`,`payin_status`,`settlement_fixed_fee`,`settlement_min_amt`,`monthly_fee`,`frozen_balance`,`available_balance`,`available_rolling`,`chargeback_ratio_card`".
						")VALUES(".
						"{$clientid},'2','{$value['wire_fee']}','{$value['withdraw_min_amt']}','{$value['monthly_fee']}','{$value['frozen_balance']}','{$value['available_balance']}','{$value['available_rolling']}','{$value['chargeback_ratio_card']}'     )",1
					);
					
				}
			
			
				if($clientid>0&&$value['payout_request']>0){
					
					echo "<br/><br/>payout_setting_db=><br/>";
					
					db_query(
						"INSERT INTO `{$data['DbPrefix']}payout_setting`(".
						"`clientid`,`payout_status`,`payout_rate`,`payout_secret_key`,`payout_token`,`payout_account`".
						")VALUES(".
						"{$clientid},'{$value['payout_request']}','{$value['payoutFee']}','{$value['payout_secret_key']}','{$value['payout_token']}','{$value['payout_account']}'     )",1
					);
					
					
				}
			
				
				
			
		}
	
	
	echo "<br/><br/>sub_client_id =><br/>";
	
	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table` SET `sub_client_id`=NULL WHERE `sub_client_id`=0 ",1
	);
			
	//UPDATE `zt_terminal` SET `merID`=272 WHERE `merID`=5551;  		
	//UPDATE `zt_mer_setting` SET `merID`=272 WHERE `merID`=5551;  		
			
	//UPDATE `zt_terminal` SET `merID`=272 WHERE `merID`=27;		
	//UPDATE `zt_mer_setting` SET `merID`=272 WHERE `merID`=27;		
	//UPDATE `zt_subadmin` SET `id`=341 WHERE `id`=40;	
	//UPDATE `zt_clientid_table` SET `ip_block_client`=1; 	
	
	
	//UPDATE `zt_terminal` AS `t`, `zt_terminal_old` AS `o`   SET `t`.`bussiness_url`=`o`.`bussiness_url` WHERE `t`.`id`=`o`.`id`; 	
	
	// scp -3 -P 210 -r -i /root/sshPemkey zt_terminal.sql ubuntu@172.31.5.122:

		
	//SELECT id,owner,`website_mcc_code` FROM `zt_products` WHERE website_mcc_code !=''
	
	exit;
}

?>