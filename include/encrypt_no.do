<?
$data['PageName']	= 'base 64 ccno and account no';
$data['PageFile']	= '';
$data['PageTitle'] 	= 'base 64 ccno and account no '; 

###############################################################################
include('../config.do');
###############################################################################

if(isset($_SESSION['adm_login'])){
	if(isset($_GET['all'])&&!empty($_GET['all'])){//  /include/encrypt_no.do?all=1 
		//$at=encrypt_no();
		//echo "<hr/>0: ".$at;
	}elseif(isset($_GET['bid'])&&!empty($_GET['bid'])){//  /include/encrypt_no.do?bid=521
		$at=encrypt_no('',$_GET['bid']);
		//echo "<hr/>1: ".$at;
	}elseif(isset($_GET['id'])&&!empty($_GET['id'])){//  /include/encrypt_no.do?id=17671 
		$at=encrypt_no($_GET['id'],'');
		//echo "<hr/>2: ".$at;
	}
	print_r($at);
	echo "<hr/>".$ccno=(int)$at['ccno'];
	echo "<hr/>".$encode=(int)$at['decode'];
}
else{
	header("location:{$data['slogin']}/login.do");
	echo('ACCESS DENIED.');
	exit;
}


?>