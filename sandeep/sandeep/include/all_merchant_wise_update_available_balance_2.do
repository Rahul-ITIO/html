<?php


// include/all_merchant_wise_update_available_balance_2.do?sq=1&a=u
//  include/all_merchant_wise_update_available_balance_2.do?sq=1&a=u&link=1



include('../config.do');

if(!isset($_SESSION['login_adm'])){
       //header("Location:{$data['USER_FOLDER']}/login.do");
       echo('ACCESS DENIED.');
       exit;
}


//Update balance upto till date
function all_merchant_wise_update_available_balance_2(){
	global $data;$qprint=1;
	$result=array();
	
	
	$_GET['tr_bal_upd']='submit';
	//$_GET['sq']=1;
	
	//fetch unique merID from transactions table
	$merID_get=db_rows(
		"SELECT ".group_concat_return('`merID`',1)." AS `merID`".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" LIMIT 1 ",$qprint
	);
	
	$merID_all=explode(',',$merID_get[0]['merID']);
	
	echo "<hr/>count=>".count($merID_all)."<hr/>"; 
	
	foreach($merID_all as $key=>$value){

		//fetch first transaction id of every member via merID
		$min_id=db_rows(
			"SELECT MIN(`id`) AS `id`".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" WHERE ( `merID`='".$value."' ) ".
			" LIMIT 1",$qprint
		);
		
		if(isset($_GET['link'])&&$_GET['link']){
			echo $link="<br/><a href='{$data['Admins']}/{$data['trnslist']}{$data['ex']}?action=tran_bal_upd&bid={$value}&id={$min_id[0]['id']}&admin=1' target='_blank'>merID=>".$value.", min id=>".$min_id[0]['id']."</a><br/>";
			
		}else{
			echo "<br/>merID=>".$value.", min id=>".$min_id[0]['id'];
			if($value>0){
				if(isset($_GET['a'])&&$_GET['a']=='u'){
					m_bal_update_trans($value,$min_id[0]['id']);	//update balance
				}
				
					//update balance
			}
		}
	}

	print_r($merID_all);
}


$all_m=all_merchant_wise_update_available_balance_2();


 exit;
 
 
?>