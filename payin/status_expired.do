<?

if(isset($td)&&isset($td['transID'])&&trim($td['transID'])){
	
	
		
	if(@$is_expired=='Y')
	{
		
		
		$expired_condition=1;
		if(isset($_SESSION['adm_login'])&&isset($_REQUEST['action'])&&$_REQUEST['action']=='expired'){
			$expired_condition=1;
		}elseif(isset($_SESSION['adm_login'])&&(!empty($_SESSION['adm_login']))){
			$expired_condition=0; 
			//$subQuery=$subQuery."&action=expired";
		} 
		
		
		
		if((isset($expired_times_count)&&$expired_times_count>0)&&($td['trans_status']==0)&&($expired_condition>0))
		{ 
			
			$_SESSION['acquirer_status_code']=22;
			$_SESSION['acquirer_response']=(isset($message)&&trim($message)?$message.' - ':'')."Expired";
				
			$subQuery=$subQuery."&tdateSkip=tdateSkip";

			
			/*
			if(isset($_SESSION['SA']['retrycount'])&&$_SESSION['SA']['retrycount']>0)
				$_SESSION['SA']['retrycount']--;
			*/
			
			$rmk_date=date('d-m-Y h:i:s A');
			
			$remark_upd = $td['support_note']."<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>This transaction has been Expired</div></div>"; 
			
			$system_note_upd = $td['system_note']."<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$_SESSION['acquirer_response']."</div></div>"; 


			//Dev Tech : 24-09-27 bug fix 

			// query update for master_trans_additional
			$additional_update=$master_update=", `support_note`='".$remark_upd."', `system_note`='".$system_note_upd."', `trans_response`='Expired' ";

			if(isset($data['MASTER_TRANS_ADDITIONAL'])&&$data['MASTER_TRANS_ADDITIONAL']=='Y'){
				$master_update='';
				$additional_update=ltrim($additional_update,',');
				db_query("UPDATE `{$data['DbPrefix']}{$data['ASSIGN_MASTER_TRANS_ADDITIONAL']}` SET ".$additional_update." WHERE `id_ad`='".$td['id']."' ",@$qp); 
			}
			
			db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `trans_status`='22' ".$master_update." WHERE `id`='".$td['id']."' ",@$qp);
			
			$fetch_trnsStatus_url=$host_path."/fetch_trnsStatus".$data['ex'];
			$valid_data=array();
			$valid_data['transID']=$td['transID'];
			
			if(isset($json_value['post']['public_key'])&&$json_value['post']['public_key']) $valid_data['public_key']=$json_value['post']['public_key'];
			elseif(isset($json_value['get']['public_key'])&&$json_value['get']['public_key']) $valid_data['public_key']=$json_value['get']['public_key'];
			if($td['reference']) $valid_data['reference']=$td['reference'];
			$valid_data['actionurl']='validate';
			
			if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
				$use_curl=use_curl($fetch_trnsStatus_url,$valid_data);
				exit;
			}else{
				
				if($json_value['post']['integration-type']=='s2s'){
					$use_curl=use_curl($fetch_trnsStatus_url,$valid_data);
					//print_r($use_curl);
				}else{
					post_redirect($fetch_trnsStatus_url, $valid_data);
				}
				exit;
			}
			
		}
		
	}

}

?>