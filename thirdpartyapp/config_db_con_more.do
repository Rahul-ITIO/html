<?php

//Dev Tech : 23-11-107 switch for more db instance 

//define DB - Instance type array for more db instance connection file to switch the admin or merchant for fetch db config details 

$data['DB_CON']=array(
	1=>array(
		'NAME'=>'PSQL 2024-05-01',
			'db_username'=>'postgres',
			'db_password'=>'2024',
			'db_database'=>'ipgdb_1',
		'db_hostname'=>'localhost',
			'DbPort'=>'5432', // 5432
			'connection_type'=>'PSQL',
		'MORE_ADDITIONAL'=>[
			1=>array(
				'NAME'=>'2. Previous PSQL 2024-05-01',
				'DATE_TO'=>'2024-05-01',
				'DATE_FROM'=>'2024-05-31',
						'additional_table'=>'master_trans_additional_4',
						'default_table'=>'master_trans_table_4'
			),
			2=>array(
				'NAME'=>'1. PSQL 2024-06-01',
				'DURATION'=>'Current',
				'DATE_TO'=>date('Y-m-d'),
				'DATE_FROM'=>'2024-06-01',
						'additional_table'=>'master_trans_additional_3',
						'default_table'=>'master_trans_table_3'
			)
		],
	),
	2=>array(
		'NAME'=>'Previous PSQL 2024-04-01',
			'db_username'=>'postgres',
			'db_password'=>'2024',
			'db_database'=>'pgwdb_2',
		'db_hostname'=>'localhost',
			'DbPort'=>'5432', // 5432
			'connection_type'=>'PSQL',
		'MORE_ADDITIONAL'=>[
			1=>array(
				'NAME'=>'3. Previous PSQL 2024-04-01',
				'DATE_TO'=>'2024-04-30',
				'DATE_FROM'=>'2024-04-01',
						'additional_table'=>'master_trans_additional_6',
						'default_table'=>'master_trans_table_6'
			)
		],
	),
	3=>array(
		'NAME'=>'Previous MYSQL Transactions',
			'db_username'=>'root',
			'db_password'=>'2024@123',
			'db_database'=>'gw',
		'db_hostname'=>'localhost',
			'DbPort'=>'3306', // 3306
			'connection_type'=>'MYSQLI',
		'MORE_ADDITIONAL'=>[
			1=>array(
				'NAME'=>'4. Previous MYSQL Transactions',
				'DATE_TO'=>'2024-03-31',
				'DATE_FROM'=>'2024-02-17',
						'additional_table'=>'master_trans_additional_3',
						'default_table'=>'master_trans_table_3'
			)
		],
		'MORE_MASTER'=>[
			1=>array(
				'NAME'=>'5. Master Previous MYSQL Transactions ',
				'DATE_TO'=>'2024-01-17',
				'DATE_FROM'=>'2022-01-17',
					'default_table'=>'master_trans_table'
			)
		],
	)
);

################################################

// Set for default connection 	
if(!isset($_SESSION['DB_CON'])&&(isset($_SESSION['adm_login']) || isset($_SESSION['login'])))
{
 
	$_REQUEST['DB_CON']=1; $_REQUEST['db_ad']=2;
}

//if(!isset($_SESSION['DB_CON'])) { $_REQUEST['DB_CON']=1; $_REQUEST['db_ad']=2; }

#### set default connection value	#################################

$data['PRVIOUS_BALANCE_DB_ENABLE']='Y'; // Y is On for prvious balance cros db

//$data['CONNECTION_TYPE_DEFAULT']='PSQL'; // db_ad
$data['DBCON_DEFAULT']=1; // 4 || 5  DB_CON
$data['dbad_default']=2; // db_ad
//$data['dbmt_default']=''; // db_mt

$data['default_hostname']=$dataDefault['default_hostname']=@$data['DB_CON'][$data['DBCON_DEFAULT']]['db_hostname']; // 
$data['default_database']=$dataDefault['default_database']=@$data['DB_CON'][$data['DBCON_DEFAULT']]['db_database']; // 
$data['default_username']=$dataDefault['default_username']=@$data['DB_CON'][$data['DBCON_DEFAULT']]['db_username']; // 
$data['default_password']=$dataDefault['default_password']=@$data['DB_CON'][$data['DBCON_DEFAULT']]['db_password']; // 
$data['default_DbPort']=$dataDefault['default_DbPort']=@$data['DB_CON'][$data['DBCON_DEFAULT']]['DbPort']; // 
$data['CONNECTION_TYPE_DEFAULT']=@$dataDefault['CONNECTION_TYPE_DEFAULT']=$data['DB_CON'][$data['DBCON_DEFAULT']]['connection_type']; // 


################################################

// Set for default connection 	
if(!isset($_SESSION['DB_CON'])&&isset($data['DBCON_DEFAULT'])&&trim($data['DBCON_DEFAULT'])&&isset($data['dbad_default'])&&trim($data['dbad_default'])&&(isset($_SESSION['adm_login']) || isset($_SESSION['login']))){
	$_REQUEST['DB_CON']=@$data['DBCON_DEFAULT']; $_REQUEST['db_ad']=@$data['dbad_default'];
	//$_REQUEST['DB_CON']=1; $_REQUEST['db_ad']=2;
}




################################################
/*
if(isset($_SESSION['login'])&&(strpos($data['urlpath'],'/user/')!==false)){
	if(isset($data['DB_CON']))unset($data['DB_CON']);
	if(isset($_SESSION['DB_CON_NAME']))unset($_SESSION['DB_CON_NAME']);
	if(isset($_SESSION['DB_DURATION_NAME']))unset($_SESSION['DB_DURATION_NAME']);
}
*/

################################################
//Dev Tech : 23-11-30 switch for more db instance via ui as a subquery string in url base
function config_db_con_more($class1='',$class2='px-1 fa-fw')
{ 
	global $data;
	if(isset($data['DB_CON'])) 
	{
		//if(isset($_REQUEST['db_mt'])) unset($_REQUEST['db_mt']); if(isset($_REQUEST['db_ad'])) unset($_REQUEST['db_ad']); 
		
		$_REQUEST=unset_array($_REQUEST, ['DB_CON','db_mt','db_ad','page','a']);
		
		$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';	//Server and execution environment information
		$urlpath=$protocol.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];	//The URI which was 
		
		if(isset($_GET)&&count($_GET)>0) $urlpath="?".http_build_query($_REQUEST);
		
		if(strpos($urlpath,"?")!==false) $switch_location=$urlpath."&db_reset_page=1&DB_CON=";
		else $switch_location=$urlpath."?db_reset_page=1&DB_CON=";
			
		foreach($data['DB_CON'] as $k4 => $v4){ 
		 //print_r($v4);echo "<br/><br/>";
		?>
		<?if(!isset($v4['MORE_ADDITIONAL'])&&!isset($v4['MORE_MASTER'])){?><li> <a class="dropdown-item <?=$class1?>"  href="<?=$switch_location?><?=$k4;?>" ><i class="fa-solid fa-database <?=$class2?>"></i>  <?=$v4['NAME'];?></a></li> <?}?>
			<?if(isset($v4['MORE_ADDITIONAL'])&&(isset($data['MASTER_TRANS_ADDITIONAL']))){?>
				<?foreach($v4['MORE_ADDITIONAL'] as $ak4 => $av4){?>
					<li><a class="dropdown-item <?=$class1?>" href="<?=$switch_location?><?=$k4;?>&db_ad=<?=$ak4;?>"><i class="fa-solid fa-database <?=$class2?>"></i> <?=$av4['NAME'];?></a></li>
				<?}?>
			<?}?>
			<?if(isset($v4['MORE_MASTER'])){?>
				<?foreach($v4['MORE_MASTER'] as $mk4 => $mv4){?>
					<li><a class="dropdown-item <?=$class1?>" href="<?=$switch_location?><?=$k4;?>&db_mt=<?=$mk4;?>"><i class="fa-solid fa-database <?=$class2?>"></i> <?=$mv4['NAME'];?></a></li>
				<?}?>
			<?}?>
			
		<?
		}?>
		<li><hr class="dropdown-divider"></li>
	<?
	}
}
################################################


//Dev Tech : 24-01-13 pagination for more db instance via ui as a subquery string in url base
function config_db_con_more_duration($pg='',$class1='')
{ 
	global $data;
	//echo "ddfdfff";
	
	//unset pagination form start new multi connection via db_reset_page
	if(isset($_REQUEST['db_reset_page'])) 
	{
		if(isset($_SESSION['next_pg'])) unset($_SESSION['next_pg']);
		if(isset($_SESSION['prev_pg'])) unset($_SESSION['prev_pg']);
	}
	
	$icon_bt='';
	$hide_pg='';
	if(!empty($pg)) {
		$hide_pg='hide';
		//if(isset($_SESSION['next_pg'])) unset($_SESSION['next_pg']);
		//if(isset($_SESSION['prev_pg'])) unset($_SESSION['prev_pg']);
		
		if(!isset($_SESSION['next_pg'])) $_REQUEST['next_pg']=1;
			
		if(isset($_REQUEST['next_pg'])&&$_REQUEST['next_pg']>0) {
			$_SESSION['next_pg']=(int)$_REQUEST['next_pg']+1;
			$_SESSION['prev_pg']=(int)$_REQUEST['next_pg']-1;
		}
		
		if(isset($_REQUEST['prev_pg'])&&$_REQUEST['prev_pg']>0) {
			$_SESSION['prev_pg']=(int)$_REQUEST['prev_pg']-1;
			$_SESSION['next_pg']=(int)$_REQUEST['prev_pg']+1;
		}
		
		if($pg=='next_pg') {
			$pg_match=@$_SESSION['next_pg'];
			$icon_bt='<i class="'.$_SESSION['fwicon-caret-right'].'" ></i>';
		}
		if($pg=='prev_pg') {
			$icon_bt='<i class="'.$_SESSION['fwicon-caret-left'].'" ></i>';
			$pg_match=@$_SESSION['prev_pg'];
		}
		
		if(isset($_REQUEST['s'])&&$pg=='next_pg') echo "<br/>next_pg=>".@$_SESSION['next_pg'];
		if(isset($_REQUEST['s'])&&$pg=='prev_pg') echo "<br/>prev_pg=>".@$_SESSION['prev_pg'];
	}
	
	if(isset($_REQUEST['s'])&&$_REQUEST['s']=='show_pg') {
		$hide_pg='';
		$icon_bt='';
	}
	
	
	if(isset($data['DB_CON'])) 
	{
		
		$_REQUEST=unset_array($_REQUEST, ['DB_CON','db_mt','db_ad','page','a','prev_pg','next_pg','db_reset_page']);
		
		$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';	//Server and execution environment information
		$urlpath=$protocol.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];	//The URI which was 
		
		if(isset($_GET)&&count($_GET)>0) $urlpath="?".http_build_query($_REQUEST);
		
		if(strpos($urlpath,"?")!==false) $switch_location=$urlpath."&DB_CON=";
		else $switch_location=$urlpath."?DB_CON=";
		
		$DB_CON=@$_SESSION['DB_CON'];
		$db_ad=@$_SESSION['db_ad'];
		$db_mt=@$_SESSION['db_mt'];
		
		$db_con_arr=$data['DB_CON'];
		
		if(empty($pg)) {
			if($db_ad>0&&isset($db_con_arr[$DB_CON]['MORE_ADDITIONAL'][$db_ad])) unset($db_con_arr[$DB_CON]['MORE_ADDITIONAL'][$db_ad]);
			elseif($db_mt>0&&isset($db_con_arr[$DB_CON]['MORE_MASTER'][$db_mt])) unset($db_con_arr[$DB_CON]['MORE_MASTER'][$db_mt]);
			//elseif($DB_CON>0&&isset($db_con_arr[$DB_CON])) unset($db_con_arr[$DB_CON]);
		}
		
		
		echo '<div class="rowXX"><ul class="pagination" style="display:block;">';
		$i=0;
		foreach($db_con_arr as $k4 => $v4){ 
		// print_r($v4);echo "<br/><br/>";
		 
		?>
			<?if(!isset($v4['MORE_ADDITIONAL'])&&!isset($v4['MORE_MASTER'])){
				 $i++;
				$class1=$class1.' pg_'.$i;
			?>
				<li class="<?=(isset($pg_match)&&$pg_match==$i?"show":$hide_pg)?> <?=$pg;?>" ><a class="<?=$class1?>"  href="<?=$switch_location?><?=$k4;?>&<?=$pg;?>=<?=$i;?>" ><?=($icon_bt?$icon_bt:@$v4['DURATION']);?></a></li>
			<?}?>
			<?if(isset($v4['MORE_ADDITIONAL'])&&(isset($data['MASTER_TRANS_ADDITIONAL']))){ ?>
				<?foreach($v4['MORE_ADDITIONAL'] as $ak4 => $av4){
					$i++;
					$class1=$class1.' pg_'.$i;
				?>
					<li class="<?=(isset($pg_match)&&$pg_match==$i?"show":$hide_pg)?> <?=$pg;?>" ><a class="<?=$class1?>" href="<?=$switch_location?><?=$k4;?>&db_ad=<?=$ak4;?>&<?=$pg;?>=<?=$i;?>"><?=($icon_bt?$icon_bt:@$av4['DURATION']);?></a></li>
				<?}?>
			<?}?>
			<?if(isset($v4['MORE_MASTER'])){?>
				<?foreach($v4['MORE_MASTER'] as $mk4 => $mv4){
					$i++;
					$class1=$class1.' pg_'.$i;
				?>
					<li class="<?=(isset($pg_match)&&$pg_match==$i?"show":$hide_pg)?> <?=$pg;?>" ><a class="<?=$class1?>" href="<?=$switch_location?><?=$k4;?>&db_mt=<?=$mk4;?>&<?=$pg;?>=<?=$i;?>"><?=($icon_bt?$icon_bt:@$mv4['DURATION']);?></a></li>
				<?}?>
			<?}?>
			
		<?
		}?>
		</ul> </div> 
	<?
	}
}



################################################
//as per switch db via subquery request 
if(isset($data['DB_CON']))
{
	if(isset($_REQUEST['DB_CON'])&&$_REQUEST['DB_CON']){
		$_SESSION['DB_CON']=$_REQUEST['DB_CON'];
		$_SESSION['DB_CON_NAME']=$data['DB_CON'][$_REQUEST['DB_CON']]['NAME'];
		if(isset($data['DB_CON'][$_REQUEST['DB_CON']]['DATE_FROM']))
			$_SESSION['DB_DURATION_NAME']=@$data['DB_CON'][$_REQUEST['DB_CON']]['DATE_FROM']." - " .@$data['DB_CON'][$_REQUEST['DB_CON']]['DATE_TO'];
		else $_SESSION['DB_DURATION_NAME']=@$data['DB_CON'][$_REQUEST['DB_CON']]['DURATION'];
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
		if(isset($data['DB_CON'][$_SESSION['DB_CON']]['MORE_ADDITIONAL'][$_REQUEST['db_ad']]['DATE_FROM']))
			$_SESSION['DB_DURATION_NAME']=@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_ADDITIONAL'][$_REQUEST['db_ad']]['DATE_FROM']." - ".@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_ADDITIONAL'][$_REQUEST['db_ad']]['DATE_TO'];
		else $_SESSION['DB_DURATION_NAME']=@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_ADDITIONAL'][$_REQUEST['db_ad']]['DURATION'];
		//$_SESSION['DB_CON_NAME']=$_SESSION['DB_CON_NAME'].' :: <br/>'.$_SESSION['db_ad_type'];
		$_SESSION['DB_CON_NAME']=$_SESSION['db_ad_type'];
	}
	// MORE_MASTER num array set in $_SESSION['db_mt']
	if(isset($_REQUEST['db_mt'])&&$_REQUEST['db_mt']&&isset($data['DB_CON'][$_SESSION['DB_CON']]['MORE_MASTER'][$_REQUEST['db_mt']]['NAME'])){
		$_SESSION['db_mt']=$_REQUEST['db_mt'];
		$_SESSION['db_ad_type']=@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_MASTER'][$_REQUEST['db_mt']]['NAME'];
		if(isset($data['DB_CON'][$_SESSION['DB_CON']]['MORE_MASTER'][$_REQUEST['db_mt']]['DATE_FROM']))
			$_SESSION['DB_DURATION_NAME']=@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_MASTER'][$_REQUEST['db_mt']]['DATE_FROM']." - ".@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_MASTER'][$_REQUEST['db_mt']]['DATE_TO'];
		else $_SESSION['DB_DURATION_NAME']=@$data['DB_CON'][$_SESSION['DB_CON']]['MORE_MASTER'][$_REQUEST['db_mt']]['DURATION'];
		//$_SESSION['DB_CON_NAME']=$_SESSION['DB_CON_NAME'].' :: <br/>'.$_SESSION['db_ad_type'];
		$_SESSION['DB_CON_NAME']=$_SESSION['db_ad_type'];
	}
	
	
	//For Global config for connection as set default --------
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
			
				if(isset($data['DB_CON'][$_SESSION['DB_CON']]['DbPort'])) 
					$DbPort=$data['DbPort']=@$data['DB_CON'][$_SESSION['DB_CON']]['DbPort'];
				if(isset($data['DB_CON'][$_SESSION['DB_CON']]['connection_type'])) 
					$connection_type=$data['connection_type']=@$data['DB_CON'][$_SESSION['DB_CON']]['connection_type'];
			
		
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

################################################

// is default - latest or not IN IS_DBCON_DEFAULT
if((isset($_SESSION['DB_CON'])&&isset($data['DBCON_DEFAULT'])&&$_SESSION['DB_CON']==$data['DBCON_DEFAULT'])&&((isset($_SESSION['db_ad'])&&isset($data['dbad_default'])&&$_SESSION['db_ad']==$data['dbad_default'])||(isset($_SESSION['db_mt'])&&isset($data['dbmt_default'])&&$_SESSION['db_mt']==$data['dbmt_default'])))
	$data['IS_DBCON_DEFAULT']='Y';

$data['PRVIOUS_BALANCE_DB_ENABLE']='Y'; // Y is On for prvious balance cros db


################################################
//Dev Tech : 24-01-06 function for switch for more db instance via config_db_more_connection


function config_db_more_connection($DB_CON='',$db_ad='',$db_mt='',$connection=1)
{ 
	global $data,$db_counts,$db_username,$db_password,$db_database,$DbPort,$connection_type;
	//global $db_connect,$db_disconnect,$db_query,$newid,$db_count,$db_rows;
				
				
	$data['DBCON']=@$DB_CON;
	$data['dbad']=@$db_ad;
	$data['dbmt']=@$db_mt;
	$data['skip_connection_type']='Y';
	
	if(isset($_REQUEST['a'])&&($_REQUEST['a']=='cs'||$_REQUEST['a']=='cn1')&&isset($_SESSION['login_adm']))
	{
		echo "<br/><br/>===DB_CON=>".$DB_CON;
		echo "<br/>db_ad=>".$db_ad;
		echo "<br/>db_mt=>".$db_mt,"<br/><br/>";
	}
	
	if(isset($data['DB_CON']))
	{
		
		//For Global config for connection as set default --------
		if(isset($DB_CON)&&$DB_CON) 
		{ 
			if(isset($data['DB_CON'][$DB_CON]['db_hostname'])) 
				$db_hostname=$data['Hostname']=@$data['DB_CON'][$DB_CON]['db_hostname'];
			
			if(isset($data['DB_CON'][$DB_CON]['db_username'])) 
				$db_username=$data['Username']=@$data['DB_CON'][$DB_CON]['db_username'];
			
			if(isset($data['DB_CON'][$DB_CON]['db_password'])) 
				$db_password=$data['Password']=@$data['DB_CON'][$DB_CON]['db_password'];
			
			if(isset($data['DB_CON'][$DB_CON]['db_database'])) 
				$db_database=$data['Database']=@$data['DB_CON'][$DB_CON]['db_database'];
			
				if(isset($data['DB_CON'][$DB_CON]['DbPort'])) 
					$DbPort=$data['DbPort']=@$data['DB_CON'][$DB_CON]['DbPort'];
				if(isset($data['DB_CON'][$DB_CON]['connection_type'])) 
					$connection_type=$data['connection_type']=@$data['DB_CON'][$DB_CON]['connection_type'];
			
			
			//Additional trans table
			if(isset($db_ad)&&$db_ad&&isset($data['DB_CON'][$DB_CON]['MORE_ADDITIONAL'][$db_ad]['additional_table'])){
				// Assign Table Name for default master trans additional 
				$data['ASSIGN_MASTER_TRANS_ADDITIONAL']=@$data['DB_CON'][$DB_CON]['MORE_ADDITIONAL'][$db_ad]['additional_table'];
				$data['MASTER_TRANS_ADDITIONAL']='Y';
			}
			if(isset($db_ad)&&$db_ad&&isset($data['DB_CON'][$DB_CON]['MORE_ADDITIONAL'][$db_ad]['default_table'])){
				// Assign Table Name for default master trans table 
				$data['MASTER_TRANS_TABLE']=@$data['DB_CON'][$DB_CON]['MORE_ADDITIONAL'][$db_ad]['default_table'];
			}
			
			//Master trans table
			if(isset($db_mt)&&$db_mt&&isset($data['DB_CON'][$DB_CON]['MORE_MASTER'][$db_mt]['default_table'])){
				// Assign Table Name for default master trans table 
				$data['MASTER_TRANS_TABLE']=@$data['DB_CON'][$DB_CON]['MORE_MASTER'][$db_mt]['default_table'];
				$data['MASTER_TRANS_ADDITIONAL']='N';
			}
			
		}
		
		//connection start as per loop wise  
		if($connection>0)
		{
			
			if($connection_type=='PSQL')
			{
				if(function_exists('db_connect_psql')) db_connect_psql();
			}
			else
			{
				if(function_exists('db_connect_mysqli')) db_connect_mysqli();
			}
			
			//if(function_exists('db_connect')) db_connect();
			
			if(isset($_REQUEST['a'])&&($_REQUEST['a']=='cs'||$_REQUEST['a']=='cn1')&&isset($_SESSION['login_adm']))
			{
				
				echo "<br/><hr/><br/>connection_type=>".@$connection_type."<br/>";
				echo "<br/>connection_type=>".@$data['connection_type']."<br/>";
				echo "<br/>Hostname=>".@$data['Hostname']."<br/>";
				echo "<br/>Username=>".@$data['Username']."<br/>";
				echo "<br/>Password=>".@$data['Password']."<br/>";
				echo "<br/>Database=>".@$data['Database']."<br/>";
				echo "<br/>MASTER_TRANS_ADDITIONAL=>".@$data['MASTER_TRANS_ADDITIONAL']."<br/>";
				echo "<br/>MASTER_TRANS_TABLE=>".@$data['MASTER_TRANS_TABLE']."<br/>";
				echo "<br/>ASSIGN_MASTER_TRANS_ADDITIONAL=>".@$data['ASSIGN_MASTER_TRANS_ADDITIONAL']."<br/>";
				
				echo "<br/><br/><hr/>";
				
				//exit;
			}

			
		}
		
	}

}


################################################
//Dev Tech : 24-02-23 switch for connection as check to_date via search in csv download file 
function config_db_con_more_to_date($date='')
{ 
	global $data;
	
	$date_fe=$date;
	$date=fetchFormattedDate_f($date);
	//$date_today=date('Ymd');
	$qp=0;
	if(isset($_REQUEST['a'])&&($_REQUEST['a']=='csv')) $qp=1;
	
	
	if(isset($data['DB_CON'])) 
	{
		foreach($data['DB_CON'] as $k4 => $v4)
		{ 
		 //print_r($v4);echo "<br/><br/>";
			if(isset($v4['MORE_ADDITIONAL'])&&(isset($data['MASTER_TRANS_ADDITIONAL']))){
				
				
				foreach($v4['MORE_ADDITIONAL'] as $ak4 => $av4)
				{
					if($qp) echo "<br/>MORE_ADDITIONAL=> date: ".@$date_fe."   |   DB_CON:$k4   |   db_ad:$ak4   |   DATE_FROM:".fetchFormattedDate_f(@$av4['DATE_FROM'])."   |   DATE_TO:".fetchFormattedDate_f(@$av4['DATE_TO']).(isset($av4['CURRENT_DATE_FROM'])?"   |   CURRENT_DATE_FROM:".fetchFormattedDate_f(@$av4['CURRENT_DATE_FROM']):'').(isset($data['IS_DBCON_DEFAULT'])?"   |   IS_DBCON_DEFAULT:".$data['IS_DBCON_DEFAULT']:'');
					
					if(isset($av4['DATE_TO'])&&trim($av4['DATE_TO'])&&$date>=fetchFormattedDate_f(@$av4['DATE_FROM'])&&$date<=fetchFormattedDate_f(@$av4['DATE_TO']))
					{
						if($qp) echo "<br/>1 CON:=> DATE_FROM => DB_CON:$k4, db_ad:$ak4";
						config_db_more_connection(@$k4,@$ak4,''); 
						break; return false;
					}
					
					
					
				}
				
				
			}
			
			
			if(isset($v4['MORE_MASTER'])){
				foreach($v4['MORE_MASTER'] as $mk4 => $mv4){
					
					if($qp) echo "<br/>MORE_MASTER => date: ".@$date_fe."   |   DB_CON:$k4   |   db_ad:$ak4   |   DATE_FROM:".fetchFormattedDate_f(@$mv4['DATE_FROM'])."   |   DATE_TO:".fetchFormattedDate_f(@$mv4['DATE_TO']).(isset($mv4['CURRENT_DATE_FROM'])?"   |   CURRENT_DATE_FROM:".fetchFormattedDate_f(@$mv4['CURRENT_DATE_FROM']):'').(isset($data['IS_DBCON_DEFAULT'])?"   |   IS_DBCON_DEFAULT:".$data['IS_DBCON_DEFAULT']:'');

					if(isset($mv4['DATE_TO'])&&trim($mv4['DATE_TO'])&&$date>=fetchFormattedDate_f(@$mv4['DATE_FROM'])&&$date<=fetchFormattedDate_f(@$mv4['DATE_TO']))
					{
						if($qp) echo "<br/>3 CON:=> DATE_FROM => DB_CON:$k4, db_mt:$mk4";
						config_db_more_connection(@$k4,'',@$mk4); 
						break; return false;
					}
					
					
				}
			}
		}
	}
	
	if($qp) echo "<br/>=================================<br/>";
}
################################################


################################################
//Dev Tech : 24-02-17 function for set link if trans than switch for refund and chargeback via config_db_more_check_link


function config_db_more_check_link($DB_CON='',$db_ad='',$db_mt='')
{ 
	//global $data;
	$result=[];
	//echo "<br/>DB_CON=>".$DB_CON;
	if($DB_CON!=''){
		$result['dbad_link'] = (isset($DB_CON)?"&DBCON=".$DB_CON:"").(isset($db_ad)?"&dbad=".$db_ad:"").(isset($db_mt)?"&dbmt=".$db_mt:"");
		$result['dbad_link_2'] = (isset($DB_CON)?"&DB_CON=".$DB_CON:"").(isset($db_ad)?"&db_ad=".$db_ad:"").(isset($db_mt)?"&db_mt=".$db_mt:"");
	}
	/*
	elseif(isset($_SESSION['DB_CON'])){
		$result['dbad_link'] = (isset($_SESSION['DB_CON'])?"&DBCON=".$_SESSION['DB_CON']:"").(isset($_SESSION['db_ad'])?"&dbad=".$_SESSION['db_ad']:"").(isset($_SESSION['db_mt'])?"&dbmt=".$_SESSION['db_mt']:"");
		$result['dbad_link_2'] = (isset($_SESSION['DB_CON'])?"&DB_CON=".$_SESSION['DB_CON']:"").(isset($_SESSION['db_ad'])?"&db_ad=".$_SESSION['db_ad']:"").(isset($_SESSION['db_mt'])?"&db_mt=".$_SESSION['db_mt']:"");
	}
	*/
	return $result;
}

################################################

//as per request connection if multiple 
/*
if(isset($data['DB_CON'])&&isset($_REQUEST['DBCON'])&&trim($_REQUEST['DBCON'])&&function_exists('config_db_more_connection'))
{
	$DBCON=(isset($_REQUEST['DBCON'])?$_REQUEST['DBCON']:"");
	$dbad=(isset($_REQUEST['dbad'])?$_REQUEST['dbad']:"");
	$dbmt=(isset($_REQUEST['dbmt'])?$_REQUEST['dbmt']:"");
	config_db_more_connection($DBCON,$dbad,$dbmt);
	
}
*/


################################################
/*

if(isset($_REQUEST['DB_CON'])&&trim($_REQUEST['DB_CON'])&&isset($_REQUEST['db_ad'])&&trim($_REQUEST['db_ad']))
	config_db_more_connection($_REQUEST['DB_CON'],$_REQUEST['db_ad']);
elseif(isset($_REQUEST['DB_CON'])&&trim($_REQUEST['DB_CON'])&&isset($_REQUEST['db_mt'])&&trim($_REQUEST['db_mt']))
	config_db_more_connection($_REQUEST['DB_CON'],'',$_REQUEST['db_mt']);
elseif(isset($data['DB_CON'])&&isset($_SESSION['DB_CON'])) config_db_more_connection($_SESSION['DB_CON']);

*/

################################################

if(isset($_REQUEST['a'])&&$_REQUEST['a']=='cs'&&isset($_SESSION['login_adm']))
{
	
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
?>