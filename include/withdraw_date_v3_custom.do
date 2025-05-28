<?
$data['PageFile']='withdraw_wv3';
$data['PageFile2']='clients_test';
if(isset($_REQUEST['gid'])&&$_REQUEST['gid']>0){
	$data['G_MID']=$_REQUEST['gid'];
}


include('../config.do');


###############################################################################

if(!isset($data['CUSTOM_SETTLEMENT_OPTIMIZER_V3'])) $data['CUSTOM_SETTLEMENT_OPTIMIZER_V3']='custom_settlement_optimizer_v3';


//Testing for Enable fetch immature fund 
//$data['IMMATURE_FUND_V3_CUSTOM_ENABLE']='Y';
//Testing Enable fetch rolling 
//$data['ROLLING_V3_CUSTOM_ENABLE']='Y';

###############################################################################


//Testing for Enable fetch immature fund 
if(isset($_REQUEST['im'])&&$_REQUEST['im']) $data['IMMATURE_FUND_V3_CUSTOM_ENABLE']='Y';
//Testing Enable fetch rolling 
if(isset($_REQUEST['ro'])&&$_REQUEST['ro']) $data['ROLLING_V3_CUSTOM_ENABLE']='Y';


###############################################################################


// include/withdraw_v3_custom

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
    //header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
    echo('ACCESS DENIED.');
    exit;
//}elseif(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']!=3){
}elseif((isset($_SESSION['sub_admin_id']))&&(!isset($_SESSION['edit_trans']))){
   // header("Location:{$data['USER_FOLDER']}/login{$data['ex']}"); echo('ACCESS DENIED.'); exit;
}

$qp=0;$qp2=0;$qp3=0;
//$qp=2;$qp2=1;$qp3=1;
if(isset($_REQUEST['qp'])&&$_REQUEST['qp']) $qp=@$_REQUEST['qp'];
elseif(isset($data['cqp'])&&$data['cqp']) $qp=@$data['cqp'];
if(isset($_REQUEST['qp3'])&&$_REQUEST['qp3']) $qp3=@$_REQUEST['qp3'];


if(@$qp==2)$qp2=$qp;
if(@$qp>0)$qp3=$qp;

$is_admin=false;
if($_SESSION['adm_login']&&isset($_REQUEST['admin'])&&$_REQUEST['admin']){
 $is_admin=true;
 //echo "<hr/>is_admin=>".$is_admin;
}


$data['is_admin']=$is_admin;

##############################################################################


if(isset($is_admin)&&$is_admin&&isset($uid)&&$uid){
 $data['frontUiName']="";
}
if(isset($_REQUEST['tempui'])){
 $data['frontUiName']=$_REQUEST['tempui'];
}
//echo "<br/>frontUiName=>".$data['frontUiName'];

#######################################################

function count_recursive($array) 
{
 if (!is_array($array)) {
    return 1;
 }

 $count = 0;
 foreach($array as $sub_array) {
     $count += count_recursive($sub_array);
 }

 return $count;
}


// recursive count
/*
if(isset($data['DB_CON'])) 
{ 
 echo "<br/>countNumericKeys f=>".countNumericKeys(@$data['DB_CON']);
 echo "<br/>COUNT_RECURSIVE=>".count(@$data['DB_CON'], COUNT_RECURSIVE);
 echo "<br/>COUNT_RECURSIVE 2 =>".(count($data['DB_CON'],COUNT_RECURSIVE)-count($data['DB_CON'],0));;
 echo "<br/>count=>".count(@$data['DB_CON']);
 echo "<br/>count_recursive f=>".count_recursive(@$data['DB_CON']);
 
// echo "<br/>array_count_values=>"; print_r(array_count_values($data['DB_CON']));
}
*/

#######################################################

 
 //unset array value after create the withdraw for v1

 if(isset($_SESSION['uid_'.$uid]['trans_detail_array'])) unset($_SESSION['uid_'.$uid]['trans_detail_array']);
 if(isset($_SESSION['uid_'.$uid]['ab'])) unset($_SESSION['uid_'.$uid]['ab']);
 if(isset($_SESSION['uid_'.$uid]['payout'])) unset($_SESSION['uid_'.$uid]['payout']);
 if(isset($_SESSION['uid_'.$uid]['deduction_array_ajax'])) unset($_SESSION['uid_'.$uid]['deduction_array_ajax']);
 if(isset($_SESSION['uid_'.$uid]['payout_array_ajax'])) unset($_SESSION['uid_'.$uid]['payout_array_ajax']);

 
 if(isset($_SESSION['uid_'.$uid])){
     unset($_SESSION['uid_'.$uid]);
 }


 //unset array value after create the withdraw for v2

 if(isset($_SESSION['uid_wv2'.$uid]['trans_detail_array'])) unset($_SESSION['uid_wv2'.$uid]['trans_detail_array']);
 if(isset($_SESSION['uid_wv2'.$uid]['ab'])) unset($_SESSION['uid_wv2'.$uid]['ab']);
 if(isset($_SESSION['uid_wv2'.$uid]['payout'])) unset($_SESSION['uid_wv2'.$uid]['payout']);
 if(isset($_SESSION['uid_wv2'.$uid]['deduction_array_ajax'])) unset($_SESSION['uid_wv2'.$uid]['deduction_array_ajax']);
 if(isset($_SESSION['uid_wv2'.$uid]['payout_array_ajax'])) unset($_SESSION['uid_wv2'.$uid]['payout_array_ajax']);

 
 if(isset($_SESSION['uid_wv2'.$uid])){
     unset($_SESSION['uid_wv2'.$uid]);
 }
 
 if(isset($_SESSION['last_withdraw_micro_current_date_'.$uid]))
     unset($_SESSION['last_withdraw_micro_current_date_'.$uid]);
 



#######################################################
 
if($is_admin)
$merID=@$post['bid'];
else 
$merID=$_SESSION['uid'];

if(@$qp) echo "<br/><hr/><h1>merID=>{$merID}</h1>";

if(@$qp&&isset($_POST)) 
{
  echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>_POST</h4>";
  print_r($_POST);
}



############  FUND start   ###########################################



$post=trans_balance_wv3_custom($merID);

$default_db_connect=@$post['default_db_connect'];
$db_from=@$post['db_from'];

if(@$qp)
 echo "<br/><b style='color:#0933b0;'>default_db_connect=>".@$default_db_connect."</b><br/>";


############    LAST WITHDRAW   ###########################################


//last withdraw

if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>LAST WITHDRAW</h4>";

$last_withdraw_qr=db_rows_df(
 "SELECT `id`,`transID`,`tdate`,`created_date`,`payable_amt_of_txn` FROM `{$data['DbPrefix']}{$data['CUSTOM_SETTLEMENT_OPTIMIZER_V3']}`".
 " WHERE `merID` IN ({$merID}) AND ( `trans_status` NOT IN (2) ) AND ( `acquirer`=2 )  AND (`db_from` IN ('{$db_from}') ) ".
 " ORDER BY id DESC ",@$qp2,$default_db_connect
);


 
$data['withdraw_transID']=array();
$data['withdraw_prev_transID']=array();
$i=0;
foreach($last_withdraw_qr as $key=>$value){
 $i++;

 
 $data['withdraw_prev_transID'][$value['tdate']]=$value['transID']." | ".$value['tdate']." | ".$value['payable_amt_of_txn'];
 $data['withdraw_transID'][$value['tdate']]=$value['transID']." | ".$value['tdate']." | ".$value['payable_amt_of_txn'];
 

}

if(@$qp) echo "<br/><b style='color:#0933b0;'>last_withdraw_transID=>".@$last_withdraw_qr[0]['transID']."</b><br/>";

$post['is_admin']=$is_admin;
 

if(@$qp) echo "<br/><br/><hr/><br/><br/>";

###############################################################################
//display('admins');    
//include($data['Paths']."/include/template.withdraw_wv3".$data['iex']);   
showpage("common/template.withdraw_date_v3_custom".$data['iex']);
db_disconnect();exit;

###############################################################################

?>
