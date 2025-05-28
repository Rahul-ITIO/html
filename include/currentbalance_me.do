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

if($uid==11225){
	$post['ab']=account_trans_balance_calc_d($uid);
}else{
	//$post['ab']=account_balance($uid);
	
	$trans_detail_array = fetch_balance($uid);

	$_SESSION['uid_'.$uid]['ab']=$post['ab']=account_balance_newac($uid,"","", $trans_detail_array);	

}
$_SESSION['ab']=$post['ab'];
$_SESSION['start_date_date']=$start_date_date=date('YmdHis');

if(isset($_GET['vdata'])&&$_GET['vdata']){
?>
<a href="<?=$data['USER_FOLDER']?>/transactions<?=$data['ex']?>">Current Balance <span><?=$post['ab']['summ_total'];?></span></a>
<? }else{ ?>
<a href="<?=$data['USER_FOLDER']?>/transactions<?=$data['ex']?>" class="btn btn-block btn-default" style="padding:7px;">Current Balance<span style="font-size:28px;"><?=$post['ab']['summ_total'];?></span></a>
<? }?>
       
 