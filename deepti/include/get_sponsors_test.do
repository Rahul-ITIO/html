<?

include('../config.do');

if(!isset($_SESSION['login_adm'])){
       //header("Location:{$data['USER_FOLDER']}/login.do");
      // echo('ACCESS DENIED.'); exit;
}	
$m='';
if(isset($_REQUEST['m'])){
	$m=$_REQUEST['m'];
}
if($m){
	$slist=get_sponsors('',$m,1);
	
	echo "<br/><br/>get_mid s=>".$_SESSION['get_mid']."<br/>"; 
	echo "<br/><br/>get_mid slist=>".$slist['get_mid']."<br/>"; 
	
	echo "<br/><br/>slist=>";
	print_r($slist);
	
}
?>