<?
#########################################################################
$data['PageName']='Account Manager';
$data['PageFile']='account_manager'; 
$data['rootNoAssing']=1; 
##########################################################################
include('../config.do');
$data['PageTitle'] = 'Account Manager - '.$data['domain_name']; 
###############################################################################
if((!isset($_SESSION['login_adm']))){
	//$_SESSION['adminRedirectUrl']=$data['urlpath'];
	//header("Location:{$data['Admins']}/login".$data['iex']); 
    echo('ACCESS DENIED.'); exit;
}

#########################################################################


if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])||!$post['step']){$post['step']=1; }


if(isset($post['send'])&&$post['send']){

					
        if($post['step']==1){
                $post['step']++;
        }elseif($post['step']==2){
			
			//echo $post['acq']; print_r($post['acq']);exit;
			
			if(!$post['manager_name']){
			  $data['Error']='Please Manager Name '.$post['bg_active'];
			}elseif(!$post['contact_number']){
			  $data['Error']='Please enter Contact Number';
			}else{
				
                if(!isset($post['gid'])){
					
					
					
					db_query(
						"INSERT INTO `{$data['DbPrefix']}account_manager`(".
						"`manager_name`,`contact_number`,`skype_id`,`whatsapp_no`,`telegram_no`,`bcc_name`,`bcc_email`,`email_id`".
						")VALUES(".
						"'{$post['manager_name']}','{$post['contact_number']}','{$post['skype_id']}','{$post['whatsapp_no']}','{$post['telegram_no']}','{$post['email_id']}','{$post['bcc_name']}','{$post['bcc_email']}'".
						")",0
					);
					
					$table_id=newid();
                    json_log_upd($table_id,'account_manager','Insert');
					
							

					$_SESSION['action_success']='<strong>Success!</strong> New Manager Name : '.$post['manager_name'].' and Contact Number  '.$post['contact_number'].'  has been added successfully ';
					
				}
                else { 
	//echo "=====================Update==================================";
					

					db_query(
							"UPDATE `{$data['DbPrefix']}account_manager` SET ".
							"`manager_name`='{$post['manager_name']}',`contact_number`='{$post['contact_number']}',`skype_id`='{$post['skype_id']}',`whatsapp_no`='{$post['whatsapp_no']}',`telegram_no`='{$post['telegram_no']}',`email_id`='{$post['email_id']}',`bcc_name`='{$post['bcc_name']}',`bcc_email`='{$post['bcc_email']}'".
							" WHERE `id`={$post['gid']}",0
					);
					
					$tabid=$post['gid'];		
                    json_log_upd($tabid,'account_manager','update');
					$_SESSION['action_success']='<strong>Success!</strong> Account manager has been updated successfully';
				}
				
				
				$post['step']--;
				
				if($post['hideAllMenu']==1){ $rurl="?hideAllMenu=1"; }
				$data['PostSent']=true;
				header("location:".$data['Admins']."/{$data['PageFile']}{$data['ex']}$rurl");
				exit;
				
				
          }
        }

					
}

elseif($post['action']=='update'){
       
	   global $data;
	    $id = $post['gid'];
		//echo "<div style='margin-top:100px;'></div>"; print_r($id);
		$updateList=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}account_manager`".
                " WHERE `id`={$id} LIMIT 1"
        );
        
		$results=array();
        foreach($updateList as $key=>$value){
                foreach($value as $name=>$v)$results[$key][$name]=$v;
        }
		if($results)foreach($results[0] as $key=>$value)if(!isset($post[$key])||!$post[$key])$post[$key]=$value;
        
		
		
		//$account_manager=account_managerf(); $_SESSION['smDb']=$account_manager;
		
		
		
        $post['actn']='update';
        $post['step']++;
		
		
}elseif($post['action']=='delete'){
	$id = $post['gid'];
	$updateList=db_query("UPDATE `{$data['DbPrefix']}account_manager` SET `manager_status`=2 WHERE `id`={$id}",0);

    if($data['connection_type']=='PSQL'){
		db_query(
			"SELECT setval('{$data['DbPrefix']}account_manager_id_seq', (SELECT MAX(`id`) FROM `{$data['DbPrefix']}account_manager`)+1);",0
		);
	}
	
	json_log_upd($id,'manager_name','delete'); // for json log history
	//$account_manager=account_managerf(); $_SESSION['smDb']=$account_manager;
		
	$_SESSION['action_success']='<strong>Success!</strong> Account manager has been updated successfully';	
	header("Location:{$data['Admins']}/account_manager{$data['ex']}");
	exit;	
}
	if($post['action']=='deletedlist'){
		$status=' AND manager_status=2 ';
	}elseif($post['action']=='all'){
		$status=' ';
	}else{
		$status=' AND manager_status=1 ';
	}
	$select_pt=db_rows(
		"SELECT * FROM {$data['DbPrefix']}account_manager".
		" WHERE `id` IS NOT NULL ".$status.
		" ORDER BY id DESC ",
	);
	
	$post['result_list']=array();
	//print_r($select);
	
	foreach($select_pt as $key=>$value){
		$post['result_list'][$key]=$value;
				
		 
		
		
	}
	
	
	
	

display('admins');
#########################################################################
?>