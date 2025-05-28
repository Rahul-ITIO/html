<?php
//include('../config_db.do');

// include/all_merchant_calc_check.do?sq=1
//  include/all_merchant_calc_check.do?sq=1&link=1



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
	$_GET['tr_bal_upd']=1;
	$_GET['sq']=1;
	
	//fetch unique merID from transactions table
	$merID_all=db_rows(
		"SELECT ".group_concat_return('`merID`',0)." AS `merID`".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" LIMIT 1 ",$qprint
	);
	echo "<hr/>count=>".count($merID_all)."<hr/>";
	
	$merID_all_ex=explode(',',$merID_all);
	
	exit;

	foreach($merID_all_ex as $value){

		//fetch first transaction id of every member via merID
		
		echo "<br/>merID=>".$value;
		if($value>0){
			m_bal_update_trans($value, 0,'update_available_balance');		//update balance
		}
		
	}
	echo "<br/><hr/><br/>merID_all_ex=><br/>";
	print_r($merID_all_ex);
}

//Update balance upto tilldate
function m_bal_update_all(){
	global $data;$qprint=1;
	$result=array();
	$_GET['tr_bal_upd']=1;
	$_GET['sq']=1;
	
	//fetch unique merID from transactions table
	$merID_all=db_rows(
		"SELECT DISTINCT(`merID`) AS `merID`".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" ",$qprint
	);
	echo "<hr/>count=>".count($merID_all)."<hr/>"; 
	exit;

	foreach($merID_all as $key=>$value){

		//fetch first transaction id of every member via merID
		$min_id=db_rows(
			"SELECT MIN(`id`) AS `id`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE ( `merID`='".$value['merID']."' ) ".
			" LIMIT 1",$qprint
		);
		
		if(isset($_GET['link'])&&$_GET['link']){
			echo $link="<br/><a href='{$data['Admins']}/transactions{$data['ex']}?action=tran_bal_upd&bid={$value['merID']}&id={$min_id[0]['id']}&admin=1&sq=1' target='_blank'>merID=>".$value['merID'].", min id=>".$min_id[0]['id']."</a>";
			
		}else{
			echo "<br/>merID=>".$value['merID'].", min id=>".$min_id[0]['id'];
			if($value['merID']>0){
				m_bal_update_trans($value['merID'],$min_id[0]['id']);	//update balance
				
					//update balance
			}
		}
	}

	print_r($merID_all);
}


$all_m=all_merchant_wise_update_available_balance();
//$all_m=m_bal_update_all();


 exit;
 
 
?>