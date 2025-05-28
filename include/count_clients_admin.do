<?

include('../config.do');

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
       header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
       echo('ACCESS DENIED.');
       exit;
}

$is_admin=false;
if($_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	//echo "<hr/>is_admin=>".$is_admin;
}

$q ="SELECT COUNT(id) AS number FROM {$data['DbPrefix']}clientid_table";
$q.=" WHERE  sponsor={$post['gid']}  AND active=1 ";
$rs=db_rows($q);
$get_clientid_details=$rs[0]['number'];
db_disconnect();
?>
<a href="<?=$data['Admins'];?>/<?=$data['my_project'];?><?=$data['ex']?>?action=select&type=active&mid=<?=$post['gid'];?>" class="badge rounded-pill transaction-list-h1 bg-dark"><?=$get_clientid_details?></a>
       
 