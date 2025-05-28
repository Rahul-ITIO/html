<? 
ob_start();
session_start();

if(isset($_SESSION['adm_login'])&&trim($_SESSION['adm_login'])){
	
	if(isset($_SESSION['adminRedirectUrl'])&&(!empty($_SESSION['adminRedirectUrl']))&&(!preg_match('/login/', $_SESSION['adminRedirectUrl']))){
		$redirectUrl=$_SESSION['adminRedirectUrl'];
	}else{
		$redirectUrl="index.do"; 	
	}
	
	//$redirectUrl="index.do"; 
	
	header("Location:".$redirectUrl);
	exit;
			
}
			
include('login_code.do'); 
?>