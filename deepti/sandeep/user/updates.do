<?
$data['PageName']='EDIT UPDATES INFORMATION';
$data['PageFile']='updates';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Updates - '.$data['domain_name'];
###############################################################################
if(!isset($_SESSION['login'])){
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################

if($post['action']=='update_limit'){
	
	if($post['change']){
		if(!$post['fname']){

			$data['Error']='Please enter your first name.';

		}elseif(!$post['lname']){

			$data['Error']='Please enter your last name.';

		}else{

			//update_limit($uid,$post);
			header("location:".$data['USER_FOLDER']."/updates{$data['ex']}?#update_limit");

		}

	}
	

}elseif($post['action']=='add_principal'){
		include('../include/add_principal'.$data['iex']);
        //principal_update($uid,$parameterstr);
		principal_update($uid,$encryptres_principal);
		header("location:".$data['USER_FOLDER']."/profile{$data['ex']}?#encoded_contact_person_info");
}


###############################################################################

$post=select_info($uid, $post);



###############################################################################

display('user');

###############################################################################

?>