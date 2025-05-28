<?
include('../config.do');
//$_SESSION['display_json']['subadmin_display']="";
//$_SESSION['subadmin_display']="";

if($_REQUEST["titlelist"]){

   //$admin_id=$_REQUEST["admin_id"];	   
 
	$titlelist=trim($_REQUEST["titlelist"]); // Fetch from submit
	$array_values = array_values($data['subadmin_listorder']); // Define on config_db
	$array_keys   = array_keys($data['subadmin_listorder']);
	$titlelist    = str_replace($array_values, $array_keys, $titlelist); // change array value to array key
	$post['subadmin_display']=$titlelist = explode(',', $titlelist);

    $_SESSION['subadmin_display_arr']=$post['subadmin_display'];
	$_SESSION['subadmin_display']=('"'.implodes('","',($post['subadmin_display'])).'"');
	$_SESSION['display_json_subadmin']['subadmin_display']=[implodes('","',($post['subadmin_display']))];
	$display_json=json_encode($_SESSION['display_json_subadmin']);
	
	//exit;
	if(isset($_SESSION['admin_id'])&&$_SESSION['admin_id']){
		$admin_id=@$_SESSION['admin_id'];
	}else{
		$admin_id=@$_SESSION['sub_admin_id'];
	}
	
	if(!$admin_id){
		db_query(
			"UPDATE `{$data['DbPrefix']}subadmin`".
			" SET `display_json_subadmin`='{$display_json}'".
			" WHERE `id`={$admin_id}"
		);
	}else{
		
		$str_w=
			"<?\n".
			"##############################\n".
			"\$display_json='{$display_json}';\n".
			"##############################\n".
			
		"?>"
		;
		$file=@fopen("../log/display_json_subadmin{$data['iex']}", "w");
		if($file){
			@fwrite($file, stripslashes($str_w)); 
			@fclose($file);
		}else{
			$data['Message']='Update configuration parameters failed. Check write permissions for file "display_json'.$data['ex'].'".';
		}
		
	}
	
	echo "done";
	
	
	
	
}
?>