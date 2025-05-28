<?
$data['PageFile']='withdraw_id_date_admin';
$data['PageFile2']='clients_test';
if(isset($_REQUEST['gid'])&&$_REQUEST['gid']>0){
	$data['G_MID']=$_REQUEST['gid'];
}

include('../config.do');


###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
       header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
       echo('ACCESS DENIED.');
       exit;
//}elseif(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']!=3){
}elseif((isset($_SESSION['sub_admin_id']))&&(!isset($_SESSION['edit_trans']))){
      // header("Location:{$data['USER_FOLDER']}/login{$data['ex']}"); echo('ACCESS DENIED.'); exit;
}

$is_admin=false;
if($_SESSION['adm_login']&&isset($_REQUEST['admin'])&&$_REQUEST['admin']){
	$is_admin=true;
	//echo "<hr/>is_admin=>".$is_admin;
}

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
    

$merID=$post['bid'];
$select_pt=db_rows(
	"SELECT `id`,`transID`,`tdate`,`created_date`,`payable_amt_of_txn` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
	" WHERE `merID`='{$merID}'  AND ( `acquirer`=2 ) AND ( `trans_status` NOT IN (2) )  ".
	" ORDER BY id DESC ",0
);


	
$data['withdraw_transID']=array();
$data['withdraw_prev_transID']=array();
$i=0;
foreach($select_pt as $key=>$value){
    $i++;
   
    
    $data['withdraw_prev_transID'][$value['tdate']]=$value['transID']." | ".$value['tdate']." | ".$value['payable_amt_of_txn'];
    $data['withdraw_transID'][$value['tdate']]=$value['transID']." | ".$value['tdate']." | ".$value['payable_amt_of_txn'];
    

}


$post['is_admin']=$is_admin;
	
       
###############################################################################

//display('admins');       
 
showpage("admins/template.withdraw_id_date_admin".$data['iex']);db_disconnect();exit;

###############################################################################

?>
 