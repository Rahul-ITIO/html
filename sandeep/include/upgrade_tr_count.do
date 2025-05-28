<?





include('../config.do');

if(!isset($_SESSION['login_adm'])){
       //header("Location:{$data['USER_FOLDER']}/login.do");
       echo('ACCESS DENIED.');
       exit;
}

if(isset($_REQUEST['u'])&&$_REQUEST['u']=='all'){


	$tr_count_all_m=upgrade_tr_count_all_clients();

}elseif(isset($_REQUEST['u'])&&$_REQUEST['u']){


	$tr_count=upgrade_tr_countf($_REQUEST['u']);


}


 exit;
 
 
?>