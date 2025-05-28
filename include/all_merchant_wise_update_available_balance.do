<?php
//include('../config_db.do');

// include/all_merchant_wise_update_available_balance.do?a=e
// include/all_merchant_wise_update_available_balance.do?a=u
//  include/all_merchant_wise_update_available_balance.do?sq=1&link=1



include('../config.do');

if(!isset($_SESSION['login_adm'])){
       //header("Location:{$data['USER_FOLDER']}/login.do");
       echo('ACCESS DENIED.');
       exit;
}

//Update balance upto tilldate
function all_merchant_wise_update_available_balance(){
	global $data;$qprint=1;
	$result=array();

	$_GET['tr_bal_upd']='submit';
	$_GET['all_merchant_wise_update']='Admin';
	//$_GET['sq']=1;
	
	//fetch unique merID from transactions table
	$merID_all=db_rows(
		"SELECT ".group_concat_return('`merID`',1)." AS `merID`".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" LIMIT 1 ",$qprint
	);
	echo "<hr/>count=>".count($merID_all)."<hr/>";
	
	$merID_all_ex=explode(',',$merID_all[0]['merID']);
	
	echo "<br/><hr/><br/>merID_all_ex=><br/>";
	print_r($merID_all_ex);
	
	if(isset($_GET['a'])&&$_GET['a']=='e'){
		echo "<hr/>count=>".$_GET['a'];
		exit;
	}
	
	exit;

	foreach($merID_all_ex as $value){

		//fetch first transaction id of every member via merID
		
		echo "<br/><br/>merID=>".$value."  | ";
		
		if($value>0){
			if(isset($_GET['a'])&&$_GET['a']=='u'){
				m_bal_update_trans($value, 0,'update_available_balance');		//update balance
			}
		}
		
	}
	echo "<br/><hr/><br/>merID_all_ex=><br/>"; print_r($merID_all_ex);
}


$all_m=all_merchant_wise_update_available_balance();



exit;
 
 
?>