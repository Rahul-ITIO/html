<?php
//$data['Prot']='https';
$data['HostN']="ipg.i15.tech";
$data['SERVER_ADDR']="ipg.i15.tech";
$url_ip=$data['Prot']."://".$data['SERVER_ADDR'];
$data['SERVER_ADDR_PRA']="ipg.i15.tech";

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
$data['Database_2']=$db_database_2='repositotypsqldb';
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
	$subfolder_ex=explodef($data['urlpath'],'/',3);
	$data['subfolder']='/'.explodef($data['urlpath'],'/',3);	//sub folder name
	//echo "<br/>Dev=>9991".$data['subfolder'];

?>
