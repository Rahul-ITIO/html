<?
#########################################################################
$data['PageName']='PRICING TEMPLATE';
$data['PageFile']='acquirer_template'; 
##########################################################################
include('../config.do');
$data['PageTitle'] = 'Pricing Template - '.$data['domain_name']; 
###############################################################################
if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['pricing_templates']))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['iex']);
	echo('ACCESS DENIED.');
	exit;
}
#########################################################################


if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])||!$post['step']){$post['step']=1; }



#########################################################################
//		/mlogin/pricing_template.do?id=1122&action=all_clients&qp=1

function templatesf($pst){
	global $data; $qp=0;
	if($_GET['qp']){
		$qp=1;
	}
	
	if($qp){
		print_r($pst);
	}
	
	$pt_slc=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}acquirer_group_template`".
		" WHERE `id`='{$pst['tid']}' LIMIT 1",0
	);
	
	$tid_get=$pt_slc[0]['tid'];
	$tid=explode1(",",$tid_get);
	if($qp){
		echo $tid_get;
	}
	
	
	
	$mem=db_rows(
		"SELECT  *  FROM `{$data['DbPrefix']}clientid_table`".
		" WHERE ( `active`=1 )  AND  ( `status`=2 ) ORDER BY id DESC  ",0 //LIMIT 3 
	);
	//$mem=$mem[0]['id']; $mem=explode1(",",$mem);
	if($qp){
		echo "<hr/>mem size=>".count($mem)."<br/>";
		//echo "<hr/>mem2=>".print_r($mem);exit;
	}
	$mem_list=array();$accountId=array();$store_list=array();
	foreach($mem as $ke=>$val){
	
			$pre_created=array(); $pre_created_nm=array();  $new_created=array(); $new_created_nm=array(); $un_created=array(); $un_created_nm=array();
		
			$mem_list[]=$val['id'];
			$pst['mid']=$val['id'];
			$pst['spo']=$val['sponsor'];
			
			if($qp){
				echo "<hr/>mid=>".$pst['mid']."<br/>";
			}
		
			
			//mer_setting
			foreach($tid as $valuet){
				//$pst['gid']=$valuet;
				
				$account_count=db_rows(
					"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}mer_setting`".
					" WHERE `acquirer_id` IN ({$valuet}) AND `merID`=".$pst['mid'].
					" LIMIT 1",0
				);
				$account_count=$account_count[0]['count'];
				if($account_count>0){
					$pre_created[]=$valuet;
					$pre_created_nm[]=$data['acquirer_name'][$valuet];
					
					//$dat['Error']="All ready assign of ".$valuet;  echo $dat['Error']."<br/>";
					//json_print($dat);exit;
				}else{
					// for new create mer_setting
					$post['acq_1']=array();
					$ac['merID']=$pst['mid'];
					$ac['sponsor']=$pst['spo'];
					$ac['acquirer_id']=$valuet;
					//$ac['acquirer_name']=$data['acquirer_name'][$valuet];
					$ac['acquirer_name']=$valuet;
					
					
					$bgt_slc=db_rows(
						"SELECT * FROM `{$data['DbPrefix']}acquirer_table`".
						" WHERE `acquirer_id`='{$valuet}' LIMIT 1",0
					);
					$post['acq_1']=jsondecode($bgt_slc[0]['mer_setting_json']);
					
					//print_r($post['acq_1']);
					
					if($post['acq_1']){
						$new_created[]=$valuet;
						
						$new_created_nm[]=$data['acquirer_name'][$valuet];
						
						
						if(is_array($post['acq_1']) && is_array($ac)) {
							$post['acq_1']['acquirer_processing_json']=jsonencode($post['acq_1']['acquirer_processing_json'],1,1);
							$post['acq']=array_merge($post['acq_1'],$ac);
						}
						
						//$post['acq']['acquirer_name']=$post['acq_1']['acquirer_id'];
						
						if($post['acq']['mdr_rate']){
							$post['acq']['mdr_rate']=(double)$post['acq']['mdr_rate']+(double)$pst['baseRate_mdr_rate'];
						}
						if($post['acq']['txn_fee_success']){
							$post['acq']['txn_fee_success']=(double)$post['acq']['txn_fee_success']+(double)$pst['baseRate_txn_fee'];
						}
						
						$post['acq']['assignee_type']="1";
						$account_Id=create_mer_setting($post['acq'], $ac['merID']);
						$accountId[]=$account_Id;
							
					}else{
						$un_created[]=$valuet;
						$un_created_nm[]=$data['acquirer_name'][$valuet];
					}
				}
			}
			
			
			$pre_created=implodes(",",$pre_created);
			$dat['pre_created']=$pre_created;
			$pre_created_nm=implodes(",",$pre_created_nm);
			$dat['pre_created_nm']=$pre_created_nm;
			
			$new_created=implodes(",",$new_created);
			$dat['new_created']=$new_created;
			$new_created_nm=implodes(",",$new_created_nm);
			$dat['new_created_nm']=$new_created_nm;
			
			$un_created=implodes(",",$un_created);
			$dat['un_created']=$un_created;
			$un_created_nm=implodes(",",$un_created_nm);
			$dat['un_created_nm']=$un_created_nm;
			
			if($qp){
				//$dat['Error']="gid:".$pst['gid'].",mid:".$pst['mid'].",tid:".$pst['tid'].",spo:".$pst['spo']; json_print($dat);exit;
			}
			
			
			//store
			$pro_slc=db_rows(
				"SELECT `select_templates_log`,`acquirerIDs`,`id` FROM `{$data['DbPrefix']}terminal`".
				" WHERE `merID`='{$val['id']}' ",0
			);
			
			if($qp){
				echo "<hr/>pro_slc size=>".count($pro_slc)."<br/>";
			}
			
			foreach($pro_slc as $key3=>$value3){
				$pst['gid']=$value3['id'];
				
				
				$pLog=$value3['templates_log'];
				
				$acquirerIDs=$value3['acquirerIDs'].",".$dat['new_created'];
				$acquirerIDs=implodes(',',array_unique(explode1(',', $acquirerIDs)));
				
				
				$dat['add_template']=$pst['tid'];
				//$dat['total_acquirerIDs']=$acquirerIDs;
				$dat1=$dat;
				
				
				if(isset($_SESSION['sub_admin_id'])){
					$admin_id=$_SESSION['sub_admin_id'];
				}else{
					$admin_id='Admin';
				}
				
				
				
				
				
				$cLog['tm_user']=$admin_id;
				$cLog['tm_date']=date('Y-m-d H:i:s A');
				$cLog['tm_log']=$dat;
				$t_log=json_log($pLog,$cLog);
				//$t_log=jsonencode($cLog);
				if($qp){
					echo $t_log; 
				}
				
				
				
				db_query("UPDATE `{$data['DbPrefix']}products`".
				" SET `acquirerIDs`='{$acquirerIDs}'  WHERE  `id`='{$pst['gid']}'",0);
				
				db_query("UPDATE `{$data['DbPrefix']}products`".
				" SET `templates`='{$pst['tid']}', `templates_log`='{$t_log}'  WHERE `id`='{$pst['gid']}'",0);
				
				$store_list[]=$pst['gid'];
			}
		
	}
	
	
	//echo "<hr/>mem_list=>".jsonencode($mem_list)."<br/>";
	
	$dat1['mem_list']=jsonencode($mem_list);
	$dat1['accountId']=jsonencode($accountId);
	$dat1['store_list']=jsonencode($store_list);
	$msg['msg']=jsonencode($dat1);
	json_print($msg['msg']);exit;
	//$curlPost=use_curl($acquirer_url,$data_send);
}
		


if(isset($post['send'])&&$post['send']){

					
        if($post['step']==1){
                $post['step']++;
        }elseif($post['step']==2){
			
			//echo $post['acq']; print_r($post['acq']);exit;
			
			if(isset($post['tid'])&&$post['tid']<0){
			  $data['Error']='Please Add Templates '.$post['bg_active'];
			}elseif(!isset($post['templates_name'])||!$post['templates_name']){
			  $data['Error']='Please enter Templates Name';
			}else{
				$post['udate'] = date('Y-m-d H:i:s');
				
				$post['tid']=implodes(",",$post['tid']);
				//echo "<br/>tid2=>".$post['tid'];exit;
				
                if(!isset($post['gid'])||!$post['gid']){
					
					db_query(
						"INSERT INTO `{$data['DbPrefix']}acquirer_group_template`(".
						"`tid`,`templates_name`,`comments`,`udate`".
						")VALUES(".
						"'{$post['tid']}','{$post['templates_name']}','{$post['comments']}','{$post['udate']}'".
						")"
					);
					
					$tid=newid();
					
					json_log_upd($tid,'acquirer_group_template'); 
					$_SESSION['action_success']='Updated Successfully '.$post['templates_name'].' and Template ID : '.$tid;
				}
                else { 
					db_query(
							"UPDATE `{$data['DbPrefix']}acquirer_group_template` SET ".
							"`tid`='{$post['tid']}',`templates_name`='{$post['templates_name']}',`comments`='{$post['comments']}',`udate`='{$post['udate']}'".
							" WHERE `id`='{$post['gid']}'",0
					);
					
					json_log_upd($post['gid'],'acquirer_group_template'); 
					$_SESSION['action_success']=' Updated Successfully '.$post['templates_name'].' and Template ID : '.$post['gid'];
				}
				
				
				$post['step']--;
				
				$data['PostSent']=true;
				header("location:".$data['Admins']."/{$data['PageFile']}{$data['ex']}");
				exit;
				
				
          }
        }

					
}
elseif($post['action']=='all_clients'){
	$pst=array();
	$pst['tid']=$_GET['gid'];
	templatesf($pst);
	exit;
}
elseif($post['action']=='update'){
       
	   global $data;
	    $id = $post['gid'];
		//echo "<div style='margin-top:100px;'></div>"; print_r($id);
		$updateList=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}acquirer_group_template`".
                " WHERE `id`='{$id}' LIMIT 1"
        );
        
		$results=array();
        foreach($updateList as $key=>$value){
                foreach($value as $name=>$v)$results[$key][$name]=$v;
        }
		if($results)foreach($results[0] as $key=>$value)if(!isset($post['key'])||!$post[$key])$post[$key]=$value;
        
		//$post['tid']=explode1(",",$post['tid']);
		
		//echo "acq=>"; echo "processing_currency=>".$post['acq']['processing_currency']; print_r($post['acq']);
		
		//echo "<div style='margin-top:100px;'></div>"; print_r($post);
		
        $post['actn']='update';
        $post['step']++;
		
		
}elseif($post['action']=='delete'){
	$gid = $post['gid'];
	
	db_query(
			"DELETE FROM `{$data['DbPrefix']}acquirer_group_template`".
			" WHERE `id`='{$gid}'"
	);
	
	//json_log_upd($gid,'acquirer_group_template');
	header("Location:{$data['Admins']}/pricing_template".$data['ex']."");
	exit; 
		
}
	

	$select_pt=db_rows(
		"SELECT * FROM {$data['DbPrefix']}acquirer_group_template".
		//" WHERE `id` IS NOT NULL ".$status." ".$sponsor_qr.
		" ORDER BY id DESC ",0
	);
	
	$post['result_list']=array();
	//print_r($select);

	foreach($select_pt as $key=>$value){
		$post['result_list'][$key]=$value; $tid=array();
				
		 $tid=explode1(",",$value['tid']);
		 $post['result_list'][$key]['assign_id'] = ' ';
		 //$post['result_list'][$key]['assign_id']=array();
		 if(!empty($tid)){
		 foreach($tid as $valuet){
			 
			 $post['result_list'][$key]['assign_id'].="<br/><a class=flagtags> ".(isset($data['acquirer_list'][$valuet])?$data['acquirer_list'][$valuet]:'') ." </a>";
			 
		 }
	
	   }
	}
	

	$data['tid']=$data['acquirer_list'];
	
	//print_r($data['tid']);
	


display('admins');
#########################################################################
?>