<?
###############################################################################
$data['PageName']='IP Settings';
$data['PageFile']='ip_settings';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Settings - '.$data['domain_name'];
###############################################################################
if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
$is_admin=false;
if($_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$_GET['id'];
	$_SESSION['uid']=$uid;
	$_SESSION['login']=$uid;
}
###############################################################################
if(is_info_empty($uid)&&$is_admin==false){
	header("Location:{$data['Host']}/user/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################

$folder_json='../log/'; 
//$folder='log/';
$folder='../';
$arr=[]; $data['arr']=[];
	$file_path_htaccess_json=($folder_json."htaccess.json");
	if(file_exists($file_path_htaccess_json)){		
		$str_data = file_get_contents($file_path_htaccess_json);
		$arr = json_decode($str_data,true);
		if($arr){
			$a_size=sizeof($arr);
			if($a_size){$k=$a_size; }
			
			//echo "<br/><br/>htaccess_json=><br/>"; print_r($arr);
			
			$j=0;
			foreach($arr as $key1=>$val1){
				if($val1['request']['mid']==$uid){
					$j++;
					$post['arr'][]=$val1;
					//echo "<br/><br/>mid=>".$val['mid']."<br/><br/>";
					//echo "<br/><br/>ip=>".$val1['ip']."<br/><br/>";
				}
				/*	
				foreach($val1 as $key=>$val){
					if($val['mid']==$uid){
					if($val['mid']==$uid){
						$j++;
						$post['arr'][]=$val1;
						//echo "<br/><br/>mid=>".$val['mid']."<br/><br/>";
					}
				}
				*/
			}
			
		}
	}
	
	//print_r($post['arr']);
	/*
	$file_path_htaccess=($folder.".htaccess");
	if(file_exists($file_path_htaccess)){		
		$str_data_ht = @file($file_path_htaccess);
		echo "<br/><br/><br/>.htaccess=><br/>";
		//print_r($str_data_ht);
		
		foreach($str_data_ht  as $line ){
			echo $line."<br/>";
		}
		
	}
	
	*/

###############################################################################
if($post['change']) {
	$json_setting=jsonencode($post['setting']);
	
	if(empty($post['setting']['merchant_pays_fee'])){ 
		$data['error']="Can't Blank for Merchant pays fee. ";
	}
	else{
		db_query(
			"UPDATE `{$data['DbPrefix']}clientid_table` SET ".
			"`json_setting`='{$json_setting}'".
			" WHERE `id`={$_SESSION['uid']}",0
		);
	}
/* get the confirmation code from the url (link in email)*/
	if($is_admin==true){
		echo "<script>
		 top.window.location.href='{$data['Admins']}/ip_settings{$data['ex']}id={$_GET['id']}&action=detail';
		</script>";
	}
}
$post=select_info($uid, $post);
$post['json_setting']=jsondecode($post['json_setting']);
###############################################################################
display('user');
###############################################################################
?>