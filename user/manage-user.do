<?
$data['PageName']	= 'MANAGE SUB MERCHANT';
$data['PageFile']	= 'manage-user';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'MANAGE SUB MERCHANT - '.$data['domain_name']; 
##########################Check Permission#####################################
/*if(!clients_page_permission('5',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }*/

if(isset($_SESSION['m_clients_role'])&&isset($_SESSION['m_clients_type'])&&!clients_page_permission('5',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################
$post['add_titileName']='Add ';
if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

$post=select_info($uid, $post);
//print_r($post);

if(!isset($post['step']) || !$post['step'])$post['step']=1;
					
###############################################################################

//print_r($post); print_r($uid); echo "=h1=";

###############################################################################
if(isset($post['send'])||(isset($post['action'])&&$post['action']=='managemember')){
		$parameters=array();
		
        if(isset($post['step'])&&$post['step']==1){
                $post['step']++;
        }elseif(isset($post['step'])&&$post['step']==2){
            if(!isset($post['fullname'])||!$post['fullname']){
				$data['Error']='Please enter name.';
			}elseif(!isset($post['registered_email'])||!$post['registered_email']){
				$data['Error']='Please enter Email address.';
			}elseif(!isset($post['uname'])||!$post['uname']){
				$data['Error']='Please enter User name.';
			}
			/*elseif(!$post['pass'] && !$post['gid']){
				$data['Error']='Please enter Password.';
			}*/
			elseif(!isset($post['role'])||!$post['role']){
				$data['Error']='Please enter Role';
			}
			elseif(get_clients_id_byusername($post['uname']) && (@$post['gid']=='')){
				$data['Error']=$post['uname'].' Username Already Exist Try Another';
			}elseif((get_clients_id_byusername($post['uname'])) && ($post['gid']) && (get_clients_username($post['gid'])<>$post['uname'])){
				$data['Error']=$post['uname'].' Username Already Exist Try Another';
			}
			else{

				$last_merchent=select_client_table($uid,'clientid_table');
				$sponsor=$last_merchent['sponsor'];

//				$preg = preg_split('#\s+#', $post['fullname'], 2);
//				$post['fname'] = $preg[0];
//				$post['lname'] = $preg[1];
				
				$post_email = encrypts_decrypts_emails($post['registered_email'],1);	//encrypt registered_email id before update 
				
                if(!isset($post['gid'])||!$post['gid']){
					
                    $role=implode(",",$post['role']); 
					$generate_newpass=generate_password(10);
					$pass=hash_f($generate_newpass);
					//$pass=hash_f($post['pass']);
					
					db_query(
						"INSERT INTO `{$data['DbPrefix']}clientid_table`(".
						"`sub_client_id`,`fullname`,`username`,`password`,`sub_client_role`,`active`,`ip_block_client`,`sponsor`,`registered_email`".
						")VALUES(".
						"'$uid','{$post['fullname']}','{$post['uname']}','{$pass}','{$role}','1','1','{$sponsor}','{$post_email}'".
						")" // exit;
					);
					
					$related_id=newid();
		            json_log_upd($related_id,'clientid_table','Insert'); // For Add Json Log History 
					$pst['tableid']=$related_id;
					
				}
                else { 
					$role=implode(",",$post['role']);
					$pst['tableid']=$post['gid'];
					db_query(
							 "UPDATE `{$data['DbPrefix']}clientid_table` SET ".
							"`fullname`='{$post['fullname']}',`username`='{$post['uname']}',`sub_client_role`='{$role}',`registered_email`='{$post_email}'".
							" WHERE `id`='{$post['gid']}'"
					);
				}
				
				if(isset($post['gid'])&&$post['gid']>0)
				json_log_upd($post['gid'],'clientid_table','Update'); // For Add Json Log History 
			
				$data['sucess']	="true";
				$post['step']--;
				
				$data['PostSent']=true;
				$_SESSION['action_success']='<strong>Success!</strong> Your request is completed.'.($generate_newpass?" {$post['uname']} Password : ".$generate_newpass:'');
				
				
				header("location:{$data['USER_FOLDER']}/manage-user".$data['ex']);exit;
          }
        }
}

if(isset($post['action'])&&$post['action']=='update'){
	    $id = $post['gid'];
		$post['add_titileName']='Update ';
		$post['field_disable']='none';
		$requestmoney=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}clientid_table`".
			" WHERE `sub_client_id`={$uid}  AND `id`={$id} LIMIT 1",0
        );
		
        $results=array();
        foreach($requestmoney as $key=>$value){
                foreach($value as $name=>$v)$results[$key][$name]=$v;
        }
		if($results)foreach($results[0] as $key=>$value)if(!isset($post[$key])||!$post[$key])$post[$key]=$value;

		//print_r($requestmoney);
		
		$post['subclientsusername']=$requestmoney[0]['username'];
		$post['subclientsuseremail']=$requestmoney[0]['registered_email'];
		
		if(isset($requestmoney[0]['fullname'])&&$requestmoney[0]['fullname'])
			$post['subclientsuserfullname']=$requestmoney[0]['fullname'];
		
		//exit;
		if(isset($results[0]['json_value']))
		{
			$post['json_value']=jsondecode($results[0]['json_value']);
		}
		$post['fullname']=(isset($results[0]['rname'])?$results[0]['rname']:'');
		
		if(!isset($post['type'])||!$post['type']){
			$post['type']=(isset($post['json_value']['api_token'])?$post['json_value']['api_token']:'');
		}

		//print_r($post['json_value']);

        $post['actn']='update';
        $post['step']++;
		
}elseif(isset($post['action'])&&$post['action']=='delete'){
		$gid = $post['gid'];

		db_query(
                "UPDATE `{$data['DbPrefix']}clientid_table`".
                "SET active=2 WHERE `id`={$gid}"
        );
		
		json_log_upd($gid,'clientid_table','Update'); // For Add on Json Log History 
		$_SESSION['action_success']='<strong>Success!</strong> User has been successfully deleted!!!';
		header("location:{$data['USER_FOLDER']}/manage-user".$data['ex']);exit;
		
}elseif(isset($post['action'])&&$post['action']=='suspend'){
		$gid = $post['gid'];

		db_query(
                 "UPDATE `{$data['DbPrefix']}clientid_table`".
                 "SET active=0 WHERE `id`={$gid}"
        );
		
		json_log_upd($gid,'clientid_table','action');
		$_SESSION['action_success']='<strong>Success!</strong> User has been suspended successfully !!';
		header("location:{$data['USER_FOLDER']}/manage-user".$data['ex']);exit;
}elseif(isset($post['action'])&&$post['action']=='active'){
		$gid = $post['gid'];

		db_query(
                 "UPDATE `{$data['DbPrefix']}clientid_table`".
                 "SET active=1 WHERE `id`='{$gid}'"
        );
		
		json_log_upd($gid,'clientid_table','Update'); // For Add on Json Log History 
		$_SESSION['action_success']='<strong>Success!</strong> User has been activated successfully !!';
		header("location:{$data['USER_FOLDER']}/manage-user".$data['ex']);exit;
}

if(isset($post['step'])&&$post['step']==1){
		
///added by vikash			
	$result_select=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE `sub_client_id`={$uid}".
		(isset($primary)?" AND `primary`='{$primary}'":'').
		(isset($confirmed)?" AND `active`='{$confirmed}'":'').
		" AND `active`<> '2' ORDER BY `id` DESC"
	);
	$data['selectdatas'] = $result_select;

	 $cntdata=count($data['selectdatas']);
	 if($cntdata==0){
		 $post['step']=2;
	 }
}

###############################################################################

display('user');

###############################################################################

?>