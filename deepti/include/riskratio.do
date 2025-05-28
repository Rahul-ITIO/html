<?
//include('../config1.do');
function riskratio($uid,$account_type='',$accounts_db=false,$acc_name='',$nick_name=''){
	global $data;
	$card=false;
	$results=array();
	$results['uid']=$uid;$results['account_type']=$account_type;$results['accounts_db']=$accounts_db;$results['acc_name']=$acc_name;$results['nick_name']=$nick_name;
	$results['risk_type']="All Accounts";
	$status_retrun=" `status`=6 ";
	$status_completed=" `status`=1 "; $status_settled=" `status`=4 ";
	
	$account_type_check="";
	$account_type_card="";
	
	$charge_back_fee_1="";$charge_back_fee_2="";$charge_back_fee_3="";
	
	
	if((empty($account_type)) && ($accounts_db==true)){
		$select_accounts=mer_settings($uid);
		foreach($select_accounts as $key=>$value){
			if((strpos($data['t'][$value['nick_name']]['name2'],'Check') !== false) ){
				$account_type_check.=$value['nick_name'].",";
			}
			if((strpos($data['t'][$value['nick_name']]['name2'],'Card') !== false) ){
				$account_type_card.=$value['nick_name'].",";
			}
		}
		if($nick_name){
			if(strpos($data['t'][$nick_name]['name2'],'Check') !== false){
				$account_type=$account_type_check;
			}
			elseif(strpos($data['t'][$nick_name]['name2'],'Card') !== false){
				$account_type=$account_type_card;
			}
		}else{
			if(!empty($account_type_check) && ($acc_name=="") ){
				$account_type=$account_type_check;
			}else{
				$account_type=$account_type_card;
			}
		}
	}
	

	
	$account_type_whr="";
	if(!empty($account_type)){
		$account_type=$account_type.",";$account_type=explode(',',$account_type);
		$account_type_value="";
		foreach($account_type as $value){
		  if(!empty($value)){
			if(strpos($data['t'][$value]['name2'],'Check') !== false){
				$card=false;$results['risk_type']="Risk Ratio";
			}
			elseif(strpos($data['t'][$value]['name2'],'Card') !== false){
				$card=true;$results['risk_type']="Chargeback Ratio";
			}
			$account_type_value.=" `type`={$value} OR ";
		  }
		}
		//$account_type_whr .= " AND ( ".rtrim($account_type_value,"OR ")." ) ";		
		$account_type_whr .= " AND ( ".substr_replace($account_type_value,'', strrpos($account_type_value, 'OR'), 3)." ) ";		
	}
	
	
	if($nick_name){
		$accounts_info=mer_settings($uid, 0, true, $nick_name);
		if($accounts_info){
			$charge_back_fee_1=$accounts_info[0]['charge_back_fee_1'];
			$charge_back_fee_2=$accounts_info[0]['charge_back_fee_2'];
			$charge_back_fee_3=$accounts_info[0]['charge_back_fee_3'];
		}
		
		if(strpos($data['t'][$nick_name]['name2'],'Check') !== false){
			$card=false;$results['risk_type']="Risk Ratio";
		}
		elseif(strpos($data['t'][$nick_name]['name2'],'Card') !== false){
			$card=true;$results['risk_type']="Chargeback Ratio";
		}
	}
	
	if($card==true){
		$status_retrun="  `status`=5   ";
	}
	
	//$results['account_type']=$account_type;$results['status_retrun']=$status_retrun; $results['account_type_whr']=$account_type_whr;
	
	$qry_tr_retruns = db_rows("SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}transactions` WHERE (`receiver`={$uid} OR `sender`={$uid}) AND (".$status_retrun.")  ".$account_type_whr." LIMIT 1  ");
	if($qry_tr_retruns){
		$qry_tr_retrun = $qry_tr_retruns[0];
		$results['retrun_count']=$qry_tr_retrun['count'];
	}

	$qry_tr_completeds = db_rows("SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}transactions` WHERE (`receiver`={$uid} OR `sender`={$uid}) AND (".$status_completed.")  ".$account_type_whr." LIMIT 1  ");
	if($qry_tr_completeds){
		$qry_tr_completed = $qry_tr_completeds[0];
		$results['completed_count']=$qry_tr_completed['count'];
	}

	$qry_tr_settleds = db_rows("SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}transactions` WHERE (`receiver`={$uid} OR `sender`={$uid}) AND (".$status_settled.")  ".$account_type_whr." LIMIT 1  ");
	if($qry_tr_settleds){
		$qry_tr_settled = $qry_tr_settleds[0];
		$results['settled_count']=$qry_tr_settled['count'];
	}
	
	$micro_count=0;
	
	if($card==false){
		$post['micro_tran']=micro_trans($uid,false);
		$tolal_micro=$post['micro_tran'][0]['tolal_micro_transactions'];
		if(!empty($tolal_micro)){$micro_count=$tolal_micro;}
	}
	
	$com_setld=($results['completed_count']+$results['settled_count']+$micro_count);
	$total_ratio=0;
	if($com_setld>0 && $results['retrun_count']){
		$total_ratio=(($results['retrun_count']*100)/($com_setld));
	}
	
	$results['completed_and_settled']=$com_setld;
	
	$results['total_ratio']=bcadd(0,$total_ratio,2);
	$results['charge_back_fee']=0;
	
	if($card==true){ // in case of card
		if($results['total_ratio']>0&&$results['total_ratio']<=1){$results['lead_class']="lead_green";$results['lead_color']="#3cd632";$results['charge_back_fee']=$charge_back_fee_1;}
		elseif($results['total_ratio']>1 && $results['total_ratio']<=3){$results['lead_class']="lead_red";$results['lead_color']="#DA4453";$results['charge_back_fee']=$charge_back_fee_2;}
		elseif($results['total_ratio']>3 && $results['total_ratio']<=100){$results['lead_class']="lead_darkred";$results['lead_color']="#ab0c0c";$results['charge_back_fee']=$charge_back_fee_3;}
	}else{ // in case of eCheck
		if($results['total_ratio']<10){$results['lead_class']="lead_green";$results['lead_color']="#3cd632";$results['charge_back_fee']=$charge_back_fee_1;}
		elseif($results['total_ratio']>9 && $results['total_ratio']<20){$results['lead_class']="lead_red";$results['lead_color']="#DA4453";$results['charge_back_fee']=$charge_back_fee_2;}
		elseif($results['total_ratio']>19 && $results['total_ratio']<100){$results['lead_class']="lead_darkred";$results['lead_color']="#ab0c0c";$results['charge_back_fee']=$charge_back_fee_3;}
	}	
	
	//$results['account_type']=$account_type;
	return $results;
}



?>