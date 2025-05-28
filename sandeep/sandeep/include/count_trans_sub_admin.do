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


$tcount='';
$q ="SELECT COUNT({$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}.id) AS number ";
$q.="FROM ({$data['DbPrefix']}clientid_table INNER JOIN {$data['DbPrefix']}subadmin ON ";
$q.=" {$data['DbPrefix']}clientid_table.sponsor = {$data['DbPrefix']}subadmin.ID) ";
$q.=" INNER JOIN {$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']} ON ";
$q.=" ({$data['DbPrefix']}clientid_table.ID = {$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}.merID) ";
$q.=" or ({$data['DbPrefix']}clientid_table.ID = {$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}.merID) ";
$q.=" WHERE (({$data['DbPrefix']}clientid_table.sponsor=".$post['gid']."))";
//$q.="  AND ({$data['DbPrefix']}clientid_table.active=1)";			
//echo $q.'<br>';
$rs=db_rows($q);
$tcount=$rs[0]['number'];

db_disconnect();

?>
<a href="<?=$data['Admins'];?>/transactions<?=$data['ex']?>?mid=<?=$post['gid']?>&action=select" class="badge rounded-pill transaction-list-h1 bg-dark"><?=$tcount?></a>
       
 