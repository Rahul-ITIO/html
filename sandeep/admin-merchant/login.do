<? 
ob_start();
session_start();

if(isset($_POST['login']) && $_POST['login']=='login'){
$_SESSION['adm_mer_bid']=$_POST['bid'];
}
$data['adm_mer_bid']=$_SESSION['adm_mer_bid'];
include('../signins/admin-merchant-login.do'); 

// Page create for Admin Merchant Login created on 05-09-2022 by vikash
?>