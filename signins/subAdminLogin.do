<? 
ob_start();
session_start();
/*
if(isset($_POST['login']) && $_POST['login']=='login'){
$_SESSION['adm_mer_bid']=$_POST['bid'];
}
*/
include('login_code.do'); 
?>