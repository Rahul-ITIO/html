<?
#########################################################################
$data['PageName']='Salt Management';
$data['PageFile']='salt_management'; 
$data['rootNoAssing']=1; 
##########################################################################
include('../config.do');
$data['PageTitle'] = 'Salt Management - '.$data['domain_name']; 
###############################################################################
if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['salt_management']))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['iex']); echo('ACCESS DENIED.'); exit;
}

#########################################################################

$data_key=[];
$data_key['parentKey']='';
function ucnamef($string) {
	/*
	$string =(preg_replace('/([^A-Z])([A-Z])/', "$1 $2", $string));
    $string =ucwords(strtolower($string));
    foreach (array('-','_',' ', '\'') as $delimiter) {
      if (strpos($string, $delimiter)!==false) {
        $string =implode(' ', array_map('ucfirst', explode($delimiter, $string)));
      }
    }
    return $string;
	*/
	return str_replace(['_','-'],' ',ucwords(strtolower(preg_replace('/([^A-Z])([A-Z])/', "$1 $2", $string)),'|_- '));
}
function check_label_array_keyf($ke, $label=''){
$ke=str_replace("[{$label}]","",$ke);
	$key=$ke;
	//echo "key=>".$key."<br/>";
	if(strpos($ke,"][")!==false){
		$ke=substr($ke, 0, -1); $ke=substr($ke, 1);
		$ke_ex=explode("][",$ke);
		//print_r($ke_ex);
		$ke_ex=(array_unique($ke_ex));
		//print_r($ke_ex);
		$key="[".implode("][",$ke_ex)."]";
	}
	return $key;
}
function is_multi_label_arrayf($array, $json_array_key=array(), $arrayName='', $label=''){
	global $data_key;$result="";
	$i=0;	
	foreach($array as $k => $v) {
		$i++;
		
		if(is_array($v)) {
			if(in_array($k,$json_array_key)){
				
				$data_key['parentKey']="[{$k}]";
				
			}
			
			if($arrayName){
				$key=$data_key['parentKey']."[{$arrayName}][{$k}]";
				$key=str_replace("[{$arrayName}][{$arrayName}]","[{$arrayName}]",$key);
				
			}else{
				$key=$data_key['parentKey'];
			}
			if(strpos($key,$label)!==false){
				$key=str_replace("[{$label}]","",$key);
			}
			$k=ucnamef($k);
			$key=check_label_array_keyf($key,$label);
			
			$result.="<fieldset><legend>{$i}. {$k}</legend><div class='co2' data-val=\"{$key}\">";
			$result.=is_multi_label_arrayf($v, $json_array_key, $k);
			
			
			
		} else { 
			 //ucfirst(strtolower(trim($sentence)));
			if($arrayName){
				$key=$data_key['parentKey']."[{$arrayName}][{$k}]";
				$key=str_replace("[{$arrayName}][{$arrayName}]","[{$arrayName}]",$key);
			}else{
				
				$key="[{$k}]";
			}
			if(strpos($key,$label)!==false){
				//$key=check_label_array_keyf($key,$label);
			}
			
			if(strpos($k,"||")!==false){
				$pieces = explode("||", $k);
				$caption=$pieces[1];
				$kt=$pieces[0];
			}else{
				$caption=ucnamef($k);
				$kt=$k;
			}
			
			
			
			if(isset($_REQUEST['a'])&&$_REQUEST['a']=='p'){
				$k_typ='text';
			}else{
				$k_typ='hidden';
			}
			if(!isset($pieces[0])) $pieces[0] =0;
			$result.="<div class='m_row'><div class='col_key'><spam class='key_title' title='{$kt}'>{$caption}</spam> <input type='{$k_typ}' title='Enter Paramter||Label Name ex.: merchant_id||Merchant Website Id' placeholder='Enter Paramter Name' class='input_key key_focus' value='{$k}'></div> <div class='col_val'><spam class='val_title' title='{$pieces[0]}'>{$v}</spam> <input type='{$k_typ}' name='val{$key}' placeholder='Enter Value' class='input_val' value='{$v}'></div></div>";
			
		}
		if(is_array($v)) {
			
			$result.="</div><div class='addMore_row' style='display:none;'><a class='input_addMore' title='input Add More' data-val=\"{$key}\"  onclick=\"addMore_row_input(this,'{$key}')\">{$key} - Add More</a></div></fieldset>";
		}
	}
	
	return $result;
}

#########################################################################


if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])||!$post['step']){$post['step']=1; }


#########################################################################
//		/mlogin/salt_management.do?id=1122&action=all_clients&qp=1




		


if(isset($post['send'])&&$post['send']){

					
        if($post['step']==1){
                $post['step']++;
        }elseif($post['step']==2){
			
			//echo $post['acq']; print_r($post['acq']);exit;
			
			if($post['tid']<0){
			  $data['Error']='Please Add Salt '.$post['bg_active'];
			}elseif(!$post['salt_name']){
			  $data['Error']='Please enter Salt Name';
			}else{
				$post['udate'] = date('Y-m-d H:i:s');
				$tid=[];
				if(isset($post['tid'])&&!empty($post['tid'])) $tid=$post['tid'];
				$post['tid']=implode(",",$tid);
				//echo "<br/>tid2=>".$post['tid'];exit;
				
                if(!@$post['gid']){
						
					$post['val']=$_POST['val'];
				
					$bank_salt=json_encode($post['val']);
					$bank_json_en=$bank_salt;
					
					$json_en_ex1=explode("||",$bank_json_en);
					//print_r($json_en_ex1);
					$json_label_array=array();
					foreach($json_en_ex1 as $key=>$vl){
						$vl_ex=explode('"',$vl);
						$json_label_array[]='||'.$vl_ex[0];	
						//echo "<br/><br/>vl=>".$vl_ex[0];
					}
					//print_r($json_label_array);
					$bank_json=str_replace($json_label_array,'',$bank_json_en);
					//echo $bank_json; exit;
				
					db_query(
						"INSERT INTO `{$data['DbPrefix']}salt_management`(".
						"`tid`,`salt_name`,`comments`,`udate`,`bank_json`,`bank_salt`".
						")VALUES(".
						"'{$post['tid']}','{$post['salt_name']}','{$post['comments']}','{$post['udate']}','{$bank_json}','{$bank_salt}'".
						")",0
					);
					//exit;
					$tid=newid();
                    json_log_upd($tid,'salt_management','Insert');
					//$salt_key_ar['frid']=rand(100,999);
					//$salt_key_ar['tid']=$tid;
					//$salt_key_ar['lrid']=rand(100,999);
					//json_encode($salt_key_ar);
					//$salt_key=encode64f(json_encode($salt_key_ar),$sKey='MY_SECRET_ANQtkR7ak8RZ');
					//echo decode64f($salt_key,$sKey='MY_SECRET_ANQtkR7ak8RZ');
					$salt_key=uniqid();
					db_query(
							"UPDATE `{$data['DbPrefix']}salt_management` SET ".
							"`salt_key`='{$salt_key}'".
							" WHERE `id`={$tid}",0
					);					

					$_SESSION['action_success']='<strong>Success!</strong> Created Successfully '.$post['salt_name'].' and Salt ID : '.$tid;
					
				}
                else { 
	//echo "=====================Update==================================";
					

					 $bank_json=json_encode($post['val']);
					//echo "<br>===========<br>";	  
					  $json_en_ex1=explode("||",$bank_json);
					//print_r($json_en_ex1);
					$json_label_array=[];
					foreach($json_en_ex1 as $key=>$vl){
						$vl_ex=explode('"',$vl);
						$json_label_array[]='||'.$vl_ex[0];	
						//echo "<br/><br/>vl=>".$vl_ex[0];
					}
					//print_r($json_label_array);
					$json_en_re=str_replace($json_label_array,'',$bank_json);

					//echo "<br/><br/>json_en=>".$json_en;echo "<br/><br/>";
					//echo $json_en_re;

					//echo "<br>=======================================================<br>";
					
					db_query(
							"UPDATE `{$data['DbPrefix']}salt_management` SET ".
							"`tid`='{$post['tid']}',`salt_name`='{$post['salt_name']}',`comments`='{$post['comments']}',`udate`='{$post['udate']}',`bank_json`='{$json_en_re}',`bank_salt`='{$bank_json}'".
							" WHERE `id`={$post['gid']}",0
					);
					
					$tabid=$post['gid'];		
                    json_log_upd($tabid,'salt_management','Update');
					$_SESSION['action_success']='<strong>Success!</strong> Updated Successfully '.$post['salt_name'].' and Salt ID : '.$post['gid'];
				}
				
				
				$post['step']--;
				
				if($post['hideAllMenu']==1){ $rurl="?hideAllMenu=1"; }
				$data['PostSent']=true;
				header("location:".$data['Admins']."/{$data['PageFile']}{$data['ex']}$rurl");
				exit;
				
				
          }
        }

					
}

elseif($post['action']=='update'){
       
	   global $data;
	    $id = $post['gid'];
		//echo "<div style='margin-top:100px;'></div>"; print_r($id);
		$updateList=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}salt_management`".
                " WHERE `id`={$id} LIMIT 1"
        );
        
		$results=array();
        foreach($updateList as $key=>$value){
                foreach($value as $name=>$v)$results[$key][$name]=$v;
        }
		if($results)foreach($results[0] as $key=>$value)if(!isset($post[$key])||!$post[$key])$post[$key]=$value;
        
		//$post['tid']=explode(",",$post['tid']);
		
		//echo "acq=>"; echo "processing_currency=>".$post['acq']['processing_currency']; print_r($post['acq']);
		
		//echo "<div style='margin-top:100px;'></div>"; print_r($post);
		
		$salt_management=salt_managementf();
		$_SESSION['smDb']=$salt_management;
		
		
		
        $post['actn']='update';
        $post['step']++;
		
		
}elseif($post['action']=='delete'){
	$id = $post['gid'];
	$updateList=db_query("UPDATE `{$data['DbPrefix']}salt_management` SET `salt_status`=2 WHERE `id`={$id}",0);
	
	json_log_upd($id,'salt_management','Delete'); 
	$salt_management=salt_managementf();
	$_SESSION['smDb']=$salt_management;
		
	$_SESSION['action_success']='<strong>Success!</strong> successfully Deleted  Salt ID : '.$post['gid'];	
	header("Location:{$data['Admins']}/salt_management{$data['ex']}");
	exit;	
}
	if($post['action']=='deletedlist'){
		$status=" AND `salt_status`=2 ";
	}elseif($post['action']=='all'){
		$status=' ';
	}else{
		$status=" AND `salt_status`=1 ";
	}
	
	if(isset($_SESSION['acquirer_ids'])&&$_SESSION['acquirer_ids']){
		$acquirer_ids_ex=explode(",",$_SESSION['acquirer_ids']);
		$acquirer_ids_im="'".implode("','",$acquirer_ids_ex)."'";
		$status.=" AND `tid` IN ({$acquirer_ids_im}) ";
		
		if($acquirer_ids_ex){
			foreach($acquirer_ids_ex as $va){
			 $status.=" OR FIND_IN_SET($va,`tid`) ";
			}
		}
		
	}
	
	$select_pt=db_rows(
		"SELECT * FROM {$data['DbPrefix']}salt_management".
		" WHERE `id` IS NOT NULL ".$status.
		" ORDER BY id DESC ",0
	);
	
	$post['result_list']=array();
	//print_r($select);
	
	foreach($select_pt as $key=>$value){
		$post['result_list'][$key]=$value;
				
		 $tid=explode(",",$value['tid']);
		 $post['result_list'][$key]['assign_id']='';
		 //$post['result_list'][$key]['assign_id']=array();
		 foreach($tid as $valuet){
			 $sl_ban_gat=db_rows(
				"SELECT * FROM {$data['DbPrefix']}acquirer_table".
				" WHERE `acquirer_id` IN ({$valuet}) ".
				" ORDER BY id DESC LIMIT 1",0
			 );
			
			if(isset($sl_ban_gat[0]['acquirer_name'])&&$sl_ban_gat[0]['acquirer_name']){
				$acquirer_status=$sl_ban_gat[0]['acquirer_status'];
				$mode=$sl_ban_gat[0]['acquirer_prod_mode'];
				$post['result_list'][$key]['assign_id'].="<a class=flagtags> {$valuet} | ".($mode==1?"Live":"Test")." | ".($acquirer_status?"Active":"Inactive")." | {$sl_ban_gat[0]['acquirer_name']} </a>";
			}
			
		 }
		
		
	}
	
	
	$select_acquirer_table=db_rows(
		"SELECT * FROM {$data['DbPrefix']}acquirer_table".
		" WHERE `acquirer_status` IN (1,2)".
		" ORDER BY id DESC ",0
	);
	
	//echo sizeof($select_acquirer_table);
	
	$data['tid']=array();
	
	foreach($select_acquirer_table as $key=>$value){ 
		if(isset($value['acquirer_name'])&&$value['acquirer_name']){
			$data['tid'][$value['acquirer_id']]="{$value['acquirer_id']} | ".($value['acquirer_prod_mode']==1?"Live":"Test")." | ".($value['acquirer_status']?"Active":"Inactive")." | {$value['acquirer_name']}";
			
			//echo $account_name=$data['t'][$value['account_no']]['name1'];
		}
	}
	//print_r($data['tid']);
	
	

display('admins');
#########################################################################
?>