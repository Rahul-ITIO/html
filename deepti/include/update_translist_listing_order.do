<?
$data['NO_SALT']=true;
$data['SponsorDomain']=true;
include('../config.do');


if(!isset($_SESSION['adm_login'])&&!isset($_SESSION['login'])){
	echo('ACCESS DENIED.'); exit;
}

if(isset($_SESSION['login'])&&isset($_REQUEST["clientTransList"])&&$_REQUEST["clientTransList"]){
	
		

		$clientTransList=trim($_REQUEST["clientTransList"]); // Fetch from submit
		$array_values = array_values($data['payin_trnslist_listorder']); // Define on config_db
		$array_keys   = array_keys($data['payin_trnslist_listorder']);
		$clientTransList    = str_replace($array_values, $array_keys, $clientTransList); // change array value to array key
		$post['payin_transaction_display']=$clientTransList = explode(',', $clientTransList);
		
		/*
		$_SESSION['assign_trans_display_json_arr']=$post['payin_transaction_display'];
		$_SESSION['payin_transaction_display']=('"'.implodes('","',($post['payin_transaction_display'])).'"');
		*/
		$post['assign_trans_display_json']['payin_transaction_display']=[implodes('","',($post['payin_transaction_display']))];
		$assign_trans_display_json=json_encode($post['assign_trans_display_json']);
		
		//remove tab and new line from json encode value 
		$assign_trans_display_json = preg_replace('~[\r\n\t]+~', '', $assign_trans_display_json);
		$assign_trans_display_json=stripslashes($assign_trans_display_json);
		
		
		
		$uid=@$_SESSION["uid"];
		
		if(isset($_REQUEST['pq']))
		{
			echo "<br/>assign_trans_display_json=>".$assign_trans_display_json;
			exit;
		}
		
		if($uid>0){
			db_query(
				"UPDATE `{$data['DbPrefix']}clientid_table`".
				" SET `sort_trans_display_json`='{$assign_trans_display_json}'".
				" WHERE `id`={$uid}"
			);
			
			echo "done";
		}
	
	
}
elseif(isset($_SESSION['adm_login'])){
	
	if(isset($_REQUEST["payinTransList"])&&$_REQUEST["payinTransList"]&&isset($_REQUEST["id"])&&$_REQUEST["id"]&&isset($_REQUEST["is_admin"])&&$_REQUEST["is_admin"]){

		$payinTransList=trim($_REQUEST["payinTransList"]); // Fetch from submit
		$array_values = array_values($data['payin_trnslist_listorder']); // Define on config_db
		$array_keys   = array_keys($data['payin_trnslist_listorder']);
		$payinTransList    = str_replace($array_values, $array_keys, $payinTransList); // change array value to array key
		$post['payin_transaction_display']=$payinTransList = explode(',', $payinTransList);
		
		/*
		$_SESSION['assign_trans_display_json_arr']=$post['payin_transaction_display'];
		$_SESSION['payin_transaction_display']=('"'.implodes('","',($post['payin_transaction_display'])).'"');
		*/
		$post['assign_trans_display_json']['payin_transaction_display']=[implodes('","',($post['payin_transaction_display']))];
		$assign_trans_display_json=json_encode($post['assign_trans_display_json']);
		
		//remove tab and new line from json encode value 
		$assign_trans_display_json = preg_replace('~[\r\n\t]+~', '', $assign_trans_display_json);
		$assign_trans_display_json=stripslashes($assign_trans_display_json);
		
		
		
		$uid=@$_REQUEST["id"];
		
		if(isset($_REQUEST['pq']))
		{
			echo "<br/>assign_trans_display_json=>".$assign_trans_display_json;
			exit;
		}
		
		if($uid>0){
			db_query(
				"UPDATE `{$data['DbPrefix']}clientid_table`".
				" SET `assign_trans_display_json`='{$assign_trans_display_json}'".
				" WHERE `id`={$uid}",$data['cqp']
			);
			
			echo "done";
		}
		
		
				
	}
	elseif(isset($_REQUEST["titlelist"])&&$_REQUEST["titlelist"]){

		//$admin_id=$_REQUEST["titlelist"];	   
	 
		$titlelist=trim($_REQUEST["titlelist"]); // Fetch from submit
		$array_values = array_values($data['trnslist_listorder']); // Define on config_db
		$array_keys   = array_keys($data['trnslist_listorder']);
		$titlelist    = str_replace($array_values, $array_keys, $titlelist); // change array value to array key
		$post['transaction_display']=$titlelist = explode(',', $titlelist);

		$_SESSION['transaction_display_arr']=$post['transaction_display'];
		$_SESSION['transaction_display']=('"'.implodes('","',($post['transaction_display'])).'"');
		$_SESSION['display_json']['transaction_display']=[implodes('","',($post['transaction_display']))];
		$display_json=json_encode($_SESSION['display_json']);
		
		//remove tab and new line from json encode value 
		$display_json = preg_replace('~[\r\n\t]+~', '', $display_json);
		$display_json=stripslashes($display_json);
		
		//exit;
		if(isset($_SESSION['admin_id'])&&$_SESSION['admin_id']){
			$admin_id=@$_SESSION['admin_id'];
		}else{
			$admin_id=@$_SESSION['sub_admin_id'];
		}
		
		if($admin_id>0){
			db_query(
				"UPDATE `{$data['DbPrefix']}subadmin`".
				" SET `display_json`='{$display_json}'".
				" WHERE `id`={$admin_id}",$data['cqp']
			);
		}else{
			
			$str_w=
				"<?\n".
				"##############################\n".
				"\$display_json='{$display_json}';\n".
				"##############################\n".
				
			"?>"
			;
			$file=@fopen("../log/display_json{$data['iex']}", "w");
			//echo $str_w;exit;
			if($file){
				@fwrite($file, stripslashes($str_w)); 
				@fclose($file);
			}else{
				$data['Message']='Update configuration parameters failed. Check write permissions for file "display_json'.$data['ex'].'".';
			}
			
		}
		
		echo "done";exit;
		
				
	}
	
}
?>