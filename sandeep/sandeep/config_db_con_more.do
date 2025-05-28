<?php
/*
//Dev Tech : 23-11-107 switch for more db instance 

//define DB - Instance type array for more db instance connection file to switch the admin or merchant for fetch db config details 

$data['DB_CON']=array(
	1=>array(
		'NAME'=>'Latest Transactions',
			'db_username'=>'nextdbuser32',
			'db_password'=>'zqG2JZML9TRQnma%samtDpFbyzKtk',
			'db_database'=>'nextgendb32',
		'db_hostname'=>'172.31.10.183',
		'MORE_ADDITIONAL'=>[
			1=>array(
				'NAME'=>'Latest Transactions with Additional',
					'additional_table'=>'master_trans_additional_3',
					'default_table'=>'master_trans_table_3'
			)
			2=>array(
				'NAME'=>'Latest Transactions with Additional 2',
					'additional_table'=>'master_trans_additional_2',
					'default_table'=>'master_trans_table_2'
			)
		],
		'MORE_MASTER'=>[
			1=>array(
				'NAME'=>'Previous Transactions - Master',
					'default_table'=>'master_trans_table'
			)
		],
	)
);


################################################
//Dev Tech : 23-11-30 switch for more db instance 
function config_db_con_more($class1='',$class2='px-1 fa-fw'){ 
	global $data;
	if(isset($data['DB_CON'])) 
	{
		//if(isset($_REQUEST['db_mt'])) unset($_REQUEST['db_mt']); if(isset($_REQUEST['db_ad'])) unset($_REQUEST['db_ad']); 
		
		$_REQUEST=unset_array($_REQUEST, ['DB_CON','db_mt','db_ad','page','a']);
		
		$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';	//Server and execution environment information
		$urlpath=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];	//The URI which was 
		
		if(isset($_GET)&&count($_GET)>0) $urlpath="?".http_build_query($_REQUEST);
		
		if(strpos($urlpath,"?")!==false) $switch_location=$urlpath."&DB_CON=";
		else $switch_location=$urlpath."?DB_CON=";
			
		foreach($data['DB_CON'] as $k4 => $v4){ 
		 //print_r($v4);echo "<br/><br/>";
		?>
		<li><a class="dropdown-item <?=$class1?>" <?if(!isset($v4['MORE_ADDITIONAL'])&&!isset($v4['MORE_MASTER'])){?> href="<?=$switch_location?><?=$k4;?>"<?}?> ><i class="fa-solid fa-database <?=$class2?>"></i>  <?=$v4['NAME'];?></a></li>
			<?if(isset($v4['MORE_ADDITIONAL'])&&(isset($data['MASTER_TRANS_ADDITIONAL']))){?>
				<?foreach($v4['MORE_ADDITIONAL'] as $ak4 => $av4){?>
					<li><a class="dropdown-item <?=$class1?>" href="<?=$switch_location?><?=$k4;?>&db_ad=<?=$ak4;?>">-<?=$av4['NAME'];?></a></li>
				<?}?>
			<?}?>
			<?if(isset($v4['MORE_MASTER'])){?>
				<?foreach($v4['MORE_MASTER'] as $mk4 => $mv4){?>
					<li><a class="dropdown-item <?=$class1?>" href="<?=$switch_location?><?=$k4;?>&db_mt=<?=$mk4;?>">-<?=$mv4['NAME'];?></a></li>
				<?}?>
			<?}?>
			
		<?
		}?>
		<li><hr class="dropdown-divider"></li>
	<?
	}
}
################################################

if(isset($data['DB_CON']))
{
	if(isset($_REQUEST['DB_CON'])&&$_REQUEST['DB_CON']){
		$_SESSION['DB_CON']=$_REQUEST['DB_CON'];
		$_SESSION['DB_CON_NAME']=$data['DB_CON'][$_REQUEST['DB_CON']]['NAME'];
		//echo "<br/>DB_CON=>".$_SESSION['DB_CON'] . " " . $_SESSION['DB_CON_NAME'];
	}
	
	if(isset($_REQUEST['DB_CON'])&&$_REQUEST['DB_CON'])
	{
		if(isset($_SESSION['db_mt'])) unset($_SESSION['db_mt']); 
		if(isset($_SESSION['db_ad'])) unset($_SESSION['db_ad']);
	}
	
	// MORE_ADDITIONAL num array set in $_SESSION['db_ad']
	if(isset($_REQUEST['db_ad'])&&$_REQUEST['db_ad']&&isset($data['DB_CON'][$_SESSION['DB_CON']]['MORE_ADDITIONAL'][$_REQUEST['db_ad']]['NAME'])){
		$_SESSION['db_ad']=$_REQUEST['db_ad'];
		$_SESSION['db_ad_type']=@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_ADDITIONAL'][$_REQUEST['db_ad']]['NAME'];
		$_SESSION['DB_CON_NAME']=$_SESSION['DB_CON_NAME'].' :: <br/>'.$_SESSION['db_ad_type'];
	}
	// MORE_MASTER num array set in $_SESSION['db_mt']
	if(isset($_REQUEST['db_mt'])&&$_REQUEST['db_mt']&&isset($data['DB_CON'][$_SESSION['DB_CON']]['MORE_MASTER'][$_REQUEST['db_mt']]['NAME'])){
		$_SESSION['db_mt']=$_REQUEST['db_mt'];
		$_SESSION['db_ad_type']=@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_MASTER'][$_REQUEST['db_mt']]['NAME'];
		$_SESSION['DB_CON_NAME']=$_SESSION['DB_CON_NAME'].' :: <br/>'.$_SESSION['db_ad_type'];
	}
	
	
	
	if(isset($_SESSION['DB_CON'])&&$_SESSION['DB_CON']) 
	{ 
		if(isset($data['DB_CON'][$_SESSION['DB_CON']]['db_hostname'])) 
			$db_hostname=@$data['DB_CON'][$_SESSION['DB_CON']]['db_hostname'];
		
		if(isset($data['DB_CON'][$_SESSION['DB_CON']]['db_username'])) 
			$db_username=@$data['DB_CON'][$_SESSION['DB_CON']]['db_username'];
		
		if(isset($data['DB_CON'][$_SESSION['DB_CON']]['db_password'])) 
			$db_password=@$data['DB_CON'][$_SESSION['DB_CON']]['db_password'];
		
		if(isset($data['DB_CON'][$_SESSION['DB_CON']]['db_database'])) 
			$db_database=@$data['DB_CON'][$_SESSION['DB_CON']]['db_database'];
		
		
		//Additional trans table
		if(isset($_SESSION['db_ad'])&&$_SESSION['db_ad']&&isset($data['DB_CON'][$_SESSION['DB_CON']]['MORE_ADDITIONAL'][$_SESSION['db_ad']]['additional_table'])){
			// Assign Table Name for default master trans additional 
			$data['ASSIGN_MASTER_TRANS_ADDITIONAL']=@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_ADDITIONAL'][$_SESSION['db_ad']]['additional_table'];
		}
		if(isset($_SESSION['db_ad'])&&$_SESSION['db_ad']&&isset($data['DB_CON'][$_SESSION['DB_CON']]['MORE_ADDITIONAL'][$_SESSION['db_ad']]['default_table'])){
			// Assign Table Name for default master trans table 
			$data['MASTER_TRANS_TABLE']=@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_ADDITIONAL'][$_SESSION['db_ad']]['default_table'];
		}
		
		//Master trans table
		if(isset($_SESSION['db_mt'])&&$_SESSION['db_mt']&&isset($data['DB_CON'][$_SESSION['DB_CON']]['MORE_MASTER'][$_SESSION['db_mt']]['default_table'])){
			// Assign Table Name for default master trans table 
			$data['MASTER_TRANS_TABLE']=@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_MASTER'][$_SESSION['db_mt']]['default_table'];
			$data['MASTER_TRANS_ADDITIONAL']='N';
		}
		
		
	}
}
if(isset($_REQUEST['a'])&&$_REQUEST['a']=='cs'&&isset($_SESSION['login_adm'])){
	
	echo "<br/><hr/><br/>_SESSION DB_CON_NAME=>".@$_SESSION['DB_CON_NAME']."<br/>";
	echo "<br/>_SESSION DB_CON=>".@$_SESSION['DB_CON']."<br/>";
	echo "<br/>_SESSION db_ad=>".@$_SESSION['db_ad']."<br/>";
	echo "<br/>_SESSION db_mt=>".@$_SESSION['db_mt']."<br/>";
	echo "<br/>MASTER_TRANS_ADDITIONAL=>".@$data['MASTER_TRANS_ADDITIONAL']."<br/>";
	echo "<br/>ASSIGN_MASTER_TRANS_ADDITIONAL=>".@$data['ASSIGN_MASTER_TRANS_ADDITIONAL']."<br/>";
	echo "<br/>MASTER_TRANS_TABLE=>".@$data['MASTER_TRANS_TABLE']."<br/>";
	echo "<br/>DB_CON ".@$_SESSION['DB_CON']."=><br/>";
	
	print_r($data['DB_CON'][@$_SESSION['DB_CON']]);
	echo "<br/><br/><hr/>";
	
	//exit;
}
*/
?>