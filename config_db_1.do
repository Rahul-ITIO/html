<?php
$data['Prot']='https';
$data['HostN']="aws-cc-uat.web1.one";
$data['SERVER_ADDR']="43.204.146.241";
$url_ip=$data['Prot']."://".$data['SERVER_ADDR'];
$data['SERVER_ADDR_PRA']="172.31.47.6";

$_SERVER["HTTPS"]='on';

/*

//msyql

$db_hostname='172.31.32.160'; //         3306   localhost
$db_username='nextdbuser32';
$db_password='zqG2JZML9TRQnma%samtDpFbyzKtk';//
$db_database='nextgendb32';
$db_tbprefix='zt';

*/

//psql 

$db_hostname='localhost';
$db_username='repousr';
$db_password='yzDzqG2JZML9TRpFbtKta%skQnmam';
$db_database='repositotypsqldb';
$db_tbprefix='zt';
$data['DbPort']='5432';
$data['connection_type']='PSQL';



//psql db 2 for payout 

$data['Hostname_2']=$db_hostname_2='localhost';
$data['Username_2']=$db_username_2='repousr';
$data['Password_2']=$db_password_2='yzDzqG2JZML9TRpFbtKta%skQnmam';
$data['Database_2']=$db_database_2='payoutdb31';
$data['DbPrefix_2']=$db_tbprefix_2='zt';
$data['DbPort_2']='5432';
$data['connection_type_2']='PSQL';


$ztspaypci=true;

$data['ex']='';

$data['con_name']='clk';
$data['hdr_logo']='show';

//$data['security_f_path']='security_function_ntpkey';
//$data['security_f_path']='security_function_m';
$data['security_f_path']='security_function_256';

$data['MYWEBSITE']='Website'; $data['MYWEBSITEURL']='website';

$data['TimeZone']='Asia/Kolkata'; // UTC  |  Europe/London  |  Asia/Singapore  |  Asia/Kolkata

$data['PRONAME']='pgi';

$data['AdminFolder']='signins';
$data['API_VER']=2; // directapi
$data['PRO_VER']=3; // nextGen3


if($_SERVER["HTTP_HOST"]=='gw.paywb.co'){
        $data['SiteName']="web1One";
        $admin_email="Paywb <Paywb <noreply@paywb.co>";
		$data['con_name']='';
}


/*
//backup db connection three 

//$data['create_trans_for_backup']='Y'; // Y is permission for create backup in trans master table via backup data base db 
	
//$data['TRANS_BACKUP_DAYS']='30'; // 30 Days before for create backup from trans master table via backup data base db 
	
$data['Hostname_3']='172.31.10.183'; // localhost
$data['Username_3']='nextdbuser32';	 // mysql user name for db3
$data['Password_3']='zqG2JZML9TRQnma%samtDpFbyzKtk'; // mysql db_password for db3
//$data['Database_3']='dbtranstablebackup';	// database 3 name

*/


//trans db setting for Additional ----------------------------
$data['MASTER_TRANS_ADDITIONAL']='Y'; //  Enable for additional date save in  MASTER_TRANS_ADDITIONAL
$data['ASSIGN_MASTER_TRANS_ADDITIONAL']='master_trans_additional_3'; // Assign Table Name for default master trans additional 

// master_trans_default assing for master trans table and part of Additional
$data['MASTER_TRANS_TABLE']='master_trans_table_3'; // Assign Table Name for default master trans table  ----------------------------

// OR master_trans_default assing for master trans table ONLY 
//$data['MASTER_TRANS_TABLE']='master_trans_table'; // Assign Table Name for default master trans table only ----------------------------

$data['TIME_TO_COMPLETION_TRANSACTION_SECONDS']='Y'; //  Y is On of runtime for second wise save the deffrence between created date and tdate

//Disable the 2FA on Withdraw
$data['2FA_SKIP']='Y'; // Pass Y for Skip button the 2FA on all the project
$data['2FA_ENABLE']='N'; // Pass Y for enable the 2FA on all the project

$data['ACCOUNT_MANAGER_ENABLE']='Y'; // Y is enable for Account manager



//V3
//172.31.47.6=>uat.web1
//192.168.1.7=>localhost:8080/gw
$data['SECURE_CRON_PRIVATE_INSTANCE_IP']=["172.31.47.6","192.168.1.7"];	//Assing Private of Instance for secure cron as a whitelable when using Withdraw V3
$data['CUSTOM_SETTLEMENT_OPTIMIZER_V3']='custom_settlement_optimizer_v3'; // Table name for Withdraw of version 3
$data['CUSTOM_SETTLEMENT_WD_V3']='Y'; // Enable Account Balance and Withdraw V3 Custom if is Y and Custom from settlement_optimizer - Payin Setting
//$data['CUSTOM_SETTLEMENT_WD_V3_IN_MER']='Y'; // Enable Custom Withdraw V3 in dashboard of Merchant



//$data['ACQUIRER_REF_ENABLE']='Y'; // transID check for or query in acquirer_ref and file name is status_top

?>
