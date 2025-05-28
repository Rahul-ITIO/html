<?
###############################################################################
$data['PageName']='Canara';
$data['PageFile']='canara_vpa'; 
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Generate Canara VPA - '.$data['domain_name'];
###############################################################################

if(!isset($_SESSION['adm_login'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(!isset($post['step']))$post['step']=1;

############################################################################### 
//if($post['step']==1)$data['Products']=select_terminals($uid, 0);
//print_r($data['Products']);



if(isset($post['send']))
{
	@$qp=0; if(isset($_REQUEST['qp'])) $qp=$_REQUEST['qp'];

	

	if(!isset($post['mobile_number'])||!$post['mobile_number']){
		$data['Error']='Can not empty for Mobile Number';
		$data['ErroFocus']='mobile_number';
	}elseif(!isset($post['company_name'])||!$post['company_name']){
		$data['Error']='Can not empty for Company Name';
		$data['ErroFocus']='company_name';
	}
	else{

		//echo "<hr/>POST=><br/>"; print_r($_POST); exit;

		// http://localhost:8080/gw/payin/pay82/hard_code/VpaRegistered.php

		error_reporting(-1); // reports all errors
		ini_set("display_errors", "1"); // shows all errors
		ini_set("log_errors", 1);
		ini_set("error_log", "php-error.log");

		//$data['sucess']=$_SESSION['decryptedData'][]=$decryptedData;

		if(@$qp) {
			 echo "<br/><br/>\n\n <hr/>";
		}


		###################################################################################
		/*

		*/

		###################################################################################
	}
}


###############################################################################
display('admins');
###############################################################################
?>