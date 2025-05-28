<?
$data['PageFile']='withdraw_wv3';
$data['PageFile2']='clients_test';
if(isset($_REQUEST['gid'])&&$_REQUEST['gid']>0){
	$data['G_MID']=$_REQUEST['gid'];
}

include('../config.do');

// include/withdraw_wv3
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

//total withdraw

//to calculate payout settlement balance and from_date and to_date
function payout_trans_newf_wv3($merID=0,$type=2, $trans_detail_array=[])
{
	global $data;//, $trans_detail_array;


    if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>TOTAL WITHDRAW</h4>";

    //SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS total_withdraw FROM "zt_master_trans_table_3" WHERE ( "merID" IN (11479)) AND   ("trans_status" IN (1,13) ) AND ( "acquirer" IN (2) ) LIMIT 1;

    $total_withdraw_qr=db_rows(
        " SELECT SUM(CAST(`payable_amt_of_txn` AS double precision)) AS `total_withdraw`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` IN (1,13) )  AND ( `acquirer` IN (2) ) ".
        " LIMIT 1 ",@$qp2
    );

    $total_withdraw=@$total_withdraw_qr[0]['total_withdraw'];
        $post['ab']['summ_withdraw']=number_formatf_3($total_withdraw);

    if(@$qp3) echo "<br/><b style='color:#e60000;'>&#10149; TOTAL WITHDRAW : ".@$total_withdraw."</b><br/>";
    //if(@$qp) echo "<br/><b style='color:#0933b0;'>&#8680; &#10153; &#10149; Total Withdraw=>".@$total_withdraw."</b><br/>";



    //mature fund :: payable_amt_of_txn, settelement_date, merID, trans_status
    // now date is below or equal from settelement_date and deduct withdraw amount 

    if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>MATURE FUND</h4>";

    //SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS mature_fund FROM `zt_master_trans_table_3` WHERE ( `merID` IN (11479)) AND (`trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) ) AND ( `acquirer` NOT IN (2,3) ) AND ( `settelement_date` <= NOW() ) LIMIT 1;

    if(isset($_REQUEST['withdraw_from_date'])&&trim($_REQUEST['withdraw_from_date'])&&isset($_REQUEST['withdraw_from_date'])&&trim($_REQUEST['withdraw_to_date'])) 
    {
        $withdraw_from_date=$_REQUEST['withdraw_from_date'];
        $withdraw_to_date=$_REQUEST['withdraw_to_date'];
        $mature_settelement_date=" AND ( `settelement_date` BETWEEN '{$withdraw_from_date}' AND '{$withdraw_to_date}' ) ";
    }
    else $mature_settelement_date=" AND ( `settelement_date` <= NOW() ) ";

    $mature_fund_qr=db_rows(
        " SELECT SUM(CAST(`payable_amt_of_txn` AS double precision)) AS `mature_fund`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )  AND ( `acquirer` NOT IN (2,3) )  ".
        $mature_settelement_date .
        " LIMIT 1 ",@$qp2
    );

    $mature_fund=@$mature_fund_qr[0]['mature_fund'];
    if(isset($withdraw_to_date)&&trim($withdraw_to_date)) // skip deduct withdraw amount if date duration 
    $total_mature_fund=@$mature_fund; // deduct withdraw amount from mature fund 
    else $total_mature_fund=(@$mature_fund + @$total_withdraw); // deduct withdraw amount from mature fund 
        $total_mature_fund_amt=$post['ab']['summ_mature']=number_formatf_3(@$total_mature_fund); // deduct withdraw amount from mature fund 

    if(@$qp){
        echo "<br/><b style='color:#0933b0;' title='{$mature_fund}'>Mature Fund=>".number_formatf2(@$mature_fund)."</b><br/>";
        echo '<br/><b style="color:#40443e;">Mature Fund - Withdraw=>'.@$total_mature_fund.'</b><br/>';
        

    }
    if(@$qp3) echo '<br/><b style="color:#366a19;">&#10149; TOTAL MATURE FUND AMT : '.@$total_mature_fund_amt.'</b><br/>';





    //immature fund :: payable_amt_of_txn, settelement_date, merID, trans_status
    // now date is greater than from settelement_date 

    if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>IMMATURE FUND</h4>";

    //SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS immature_fund FROM `zt_master_trans_table_3` WHERE ( `merID` IN (11479)) AND (`trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) ) AND ( `acquirer` NOT IN (2,3) ) AND ( `settelement_date` > NOW() ) LIMIT 1;



    if(isset($withdraw_to_date)&&trim($withdraw_to_date)) 
    {
        $imimmature_settelement_date=$mature_settelement_date;
    }
    else $imimmature_settelement_date=" AND ( `settelement_date` > NOW() ) ";


    $immature_fund_qr=db_rows(
        " SELECT SUM(CAST(`payable_amt_of_txn` AS double precision)) AS `immature_fund`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )  AND ( `acquirer` NOT IN (2,3) )  ".
        $imimmature_settelement_date .
        " LIMIT 1 ",@$qp2
    );

    $immature_fund=@$immature_fund_qr[0]['immature_fund'];
    $post['ab']['summ_immature']=number_formatf_3(@$immature_fund_qr[0]['immature_fund']);
    $accountBalance=(@$immature_fund + @$total_mature_fund); // deduct withdraw amount from immature fund 
        $accountBalance_amt=$post['ab']['summ_total']=number_formatf_3(@$accountBalance); // deduct withdraw amount from immature fund 

    if(@$qp3)  echo "<br/><b style='color:#0933b0;' title='{$immature_fund}'>&#10149; IMMATURE FUND=>".number_formatf2(@$immature_fund)."</b><br/>";

    if(@$qp){
        
        echo '<br/><b style="color:#40443e;">Immature Fund + Total Mature Fund=>'.@$accountBalance.'</b><br/>';

    }

    if(@$qp3) echo '<br/><b style="color:#b36200;">&#10149; ACCOUNT BALANCE AMT : '.@$accountBalance_amt.'</b><br/>';



    ############  FUND end   ###########################################



    //---------------------------------


    ############    ROLLING start   ###########################################

    //total withdraw rolling

    if(@$qp) echo "<br/><br/><br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>TOTAL WITHDRAW ROLLING</h4>";

    //SELECT SUM(CAST(rolling_amt AS double precision)) AS total_withdraw_rolling FROM "zt_master_trans_table_3" WHERE ( "merID" IN (11479)) AND   ("trans_status" IN (1,13) ) AND ( "acquirer" IN (2) ) LIMIT 1;

    $total_withdraw_rolling_qr=db_rows(
        " SELECT SUM(CAST(`rolling_amt` AS double precision)) AS `total_withdraw_rolling`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` IN (1,13) )  AND ( `acquirer` IN (3) ) ".
        " LIMIT 1 ",@$qp2
    );

    $total_withdraw_rolling=@$total_withdraw_rolling_qr[0]['total_withdraw_rolling'];
    $post['ab']['summ_withdraw_roll']=number_formatf_3($total_withdraw_rolling);
    //$post['ab']['summ_withdraw']=$total_withdraw_rolling;

    if(@$qp3) echo "<br/><hr/><br/><b style='color:#e60000;'>&#10149; TOTAL WITHDRAW ROLLING : ".@$total_withdraw_rolling."</b><br/>";



    //mature rolling :: rolling_amt, rolling_date, merID, trans_status
    // now date is below or equal from rolling_date and deduct withdraw amount 

    if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>MATURE rolling</h4>";

    //SELECT SUM(CAST(rolling_amt AS double precision)) AS mature_rolling FROM `zt_master_trans_table_3` WHERE ( `merID` IN (11479)) AND (`trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) ) AND ( `acquirer` NOT IN (2,3) ) AND ( `rolling_date` <= NOW() ) LIMIT 1;

    if(isset($withdraw_from_date)&&trim($withdraw_from_date)&&isset($withdraw_to_date)&&trim($withdraw_to_date)) 
    {
        $mature_rolling_date=" AND ( `rolling_date` BETWEEN '{$withdraw_from_date}' AND '{$withdraw_to_date}' ) ";
    }
    else $mature_rolling_date=" AND ( `rolling_date` <= NOW() ) ";



    $mature_rolling_qr=db_rows(
        " SELECT SUM(CAST(`rolling_amt` AS double precision)) AS `mature_rolling`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )  AND ( `acquirer` NOT IN (2,3) )  ".
        $mature_rolling_date .
        " LIMIT 1 ",@$qp2
    );

    $mature_rolling=@$mature_rolling_qr[0]['mature_rolling'];
    if(isset($withdraw_to_date)&&trim($withdraw_to_date)) // skip deduct withdraw amount if date duration 
    $total_mature_rolling=@$mature_rolling;  
    else $total_mature_rolling=(@$mature_rolling + @$total_withdraw_rolling); // deduct withdraw amount from mature rolling 
        $post['ab']['summ_mature_roll']=number_formatf_3(@$total_mature_rolling); // deduct withdraw amount from mature rolling 
        $total_mature_rolling_amt=$post['ab']['summ_total_roll']=number_formatf_3(@$total_mature_rolling); // deduct withdraw amount from mature rolling 

    if(@$qp){
        echo "<br/><b style='color:#0933b0;' title='{$mature_rolling}'>Mature Rolling=>".number_formatf2(@$mature_rolling)."</b><br/>";
        echo '<br/><b style="color:#40443e;">Mature Rolling - Withdraw Rolling=>'.@$total_mature_rolling.'</b><br/>';
        

    }
    if(@$qp3) echo '<br/><b style="color:#366a19;">&#10149; TOTAL MATURE ROLLING AMT : '.@$total_mature_rolling_amt.'</b><br/>';





    //immature rolling :: rolling_amt, rolling_date, merID, trans_status
    // now date is greater than from rolling_date 

    if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>IMMATURE rolling</h4>";

    //SELECT SUM(CAST(rolling_amt AS double precision)) AS immature_rolling FROM `zt_master_trans_table_3` WHERE ( `merID` IN (11479)) AND (`trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) ) AND ( `acquirer` NOT IN (2,3) ) AND ( `rolling_date` > NOW() ) LIMIT 1;

    if(isset($withdraw_from_date)&&trim($withdraw_from_date)&&isset($withdraw_to_date)&&trim($withdraw_to_date)) 
    {
        $imimmature_rolling_date=@$mature_rolling_date;
    }
    else $imimmature_rolling_date=" AND ( `rolling_date` > NOW() ) ";

    $immature_rolling_qr=db_rows(
        " SELECT SUM(CAST(`rolling_amt` AS double precision)) AS `immature_rolling`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )  AND ( `acquirer` NOT IN (2,3) )  ".
        $imimmature_rolling_date .
        " LIMIT 1 ",@$qp2
    );

    $immature_rolling=@$immature_rolling_qr[0]['immature_rolling'];
        $post['ab']['summ_immature_roll']=number_formatf_3(@$immature_rolling);
    $rollingBalance=(@$immature_rolling + @$total_mature_rolling); // deduct withdraw amount from immature rolling 
        $rollingBalance_amt=$post['ab']['summ_total_roll']=number_formatf_3(@$rollingBalance); // deduct withdraw amount from immature rolling 

    if(@$qp3) echo "<br/><b style='color:#0933b0;' title='{$immature_rolling}'>&#10149; IMMATURE ROLLING=>".number_formatf_3(@$immature_rolling)."</b><br/>";

    if(@$qp){
        echo '<br/><b style="color:#40443e;">Immature Rolling + Total Mature Rolling=>'.@$rollingBalance.'</b><br/>';
    }

    if(@$qp3) echo '<br/><b style="color:#b36200;">&#10149; ROLLING BALANCE AMT : '.@$rollingBalance_amt.'</b><br/>';






    ############    ROLLING end   ###########################################

    return $post;
}

$post=payout_trans_newf_wv3($merID);




############    LAST WITHDRAW   ###########################################


//last withdraw

if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>LAST WITHDRAW</h4>";

$last_withdraw_qr=db_rows(
	"SELECT `id`,`transID`,`tdate`,`created_date`,`payable_amt_of_txn` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
	" WHERE `merID` IN ({$merID}) AND ( `trans_status` NOT IN (2) ) AND ( `acquirer`=2 ) ".
	" ORDER BY id DESC ",@$qp2
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
showpage("common/template.withdraw_wv3".$data['iex']);
db_disconnect();exit;

###############################################################################

?>
 