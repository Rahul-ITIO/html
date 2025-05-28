<?
#########################################################################
$data['PageName']='Mode of Payment';
$data['PageFile']='mop_template'; //mop 
$data['rootNoAssing']=1; 
##########################################################################
include('../config.do');
$data['PageTitle'] = 'Mode of Payment - '.$data['domain_name']; 
###############################################################################
if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['mop_table']))){
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


if(isset($post['send'])&&$post['send']){

					
        if($post['step']==1){
                $post['step']++;
        }elseif($post['step']==2){
			
			//echo $post['acq']; print_r($post['acq']);exit;
			
			if($post['mop_code']<0){
			  $data['Error']='Please Add Category '.$post['bg_active'];
			}elseif(!$post['mop_name']){
			  $data['Error']='Please enter Category Name';
			}else{
				$post['udate'] = date('Y-m-d H:i:s');
				
				$mop_code=[];
				if(isset($post['mop_code'])&&!empty($post['mop_code'])) $mop_code=$post['mop_code'];
				$post['mop_code']=implode(",",$mop_code);
				//echo "<br/>mop_code2=>".$post['mop_code'];exit;
				
                if(!$post['gid']){
					
					$mop_type=uniqid();
					
					db_query(
						"INSERT INTO `{$data['DbPrefix']}mop_table`(".
						"`mop_code`,`mop_name`,`comments`,`udate`,`mop_type`".
						")VALUES(".
						"'{$post['mop_code']}','{$post['mop_name']}','{$post['comments']}','{$post['udate']}','{$post['mop_type']}'".
						")"
					);
					
					$table_id=newid();
                    json_log_upd($table_id,'mop_table','Insert');
					
							

					$_SESSION['action_success']='<strong>Success!</strong> New Mode of Payment '.$post['mop_name'].' with Category ID : '.$post['mop_code'].'  has been added successfully ';
					
				}
                else { 
	//echo "=====================Update==================================";
					

					db_query(
							"UPDATE `{$data['DbPrefix']}mop_table` SET ".
							"`mop_code`='{$post['mop_code']}',`mop_name`='{$post['mop_name']}',`mop_type`='{$post['mop_type']}',`comments`='{$post['comments']}',`udate`='{$post['udate']}'".
							" WHERE `id`={$post['gid']}",0
					);
					
					$tabid=$post['gid'];		
                    json_log_upd($tabid,'mop_table','update');
					$_SESSION['action_success']='<strong>Success!</strong> Mode of Payment has been updated successfully';
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
                "SELECT * FROM `{$data['DbPrefix']}mop_table`".
                " WHERE `id`={$id} LIMIT 1"
        );
        
		$results=array();
        foreach($updateList as $key=>$value){
                foreach($value as $name=>$v)$results[$key][$name]=$v;
        }
		if($results)foreach($results[0] as $key=>$value)if(!isset($post[$key])||!$post[$key])$post[$key]=$value;
        
		
		
		//$mop_table=merchant_categoryf(); $_SESSION['smDb']=$mop_table;
		
		
		
        $post['actn']='update';
        $post['step']++;
		
		
}elseif($post['action']=='delete'){
	$id = $post['gid'];
	$updateList=db_query("UPDATE `{$data['DbPrefix']}mop_table` SET `mop_status`=2 WHERE `id`={$id}",0);
	
	json_log_upd($id,'mop_table','delete'); // for json log history
	//$mop_table=merchant_categoryf(); $_SESSION['smDb']=$mop_table;
		
	$_SESSION['action_success']='<strong>Success!</strong> Mode of Payment has been updated successfully';	
	header("Location:{$data['Admins']}/mop{$data['ex']}");
	exit;	
}
	if($post['action']=='deletedlist'){
		$status=' AND mop_status=2 ';
	}elseif($post['action']=='all'){
		$status=' ';
	}else{
		$status=' AND mop_status=1 ';
	}
	$select_pt=db_rows(
		"SELECT * FROM {$data['DbPrefix']}mop_table".
		" WHERE `id` IS NOT NULL ".$status.
		" ORDER BY id DESC ",
	);
	
	$post['result_list']=array();
	//print_r($select);
	
	foreach($select_pt as $key=>$value){
		$post['result_list'][$key]=$value;
				
		 $mop_code=explode(",",$value['mop_code']);
		 $post['result_list'][$key]['assign_id']='';
		 //$post['result_list'][$key]['assign_id']=array();
		 foreach($mop_code as $valuet){
			 if(strpos($valuet,'fa-')!==false){
				 $symbol="<i title='{$valuet}' class='{$valuet} text-primary' style='font-size:20px;vertical-align:middle;'></i>";
			 }elseif(strpos($valuet,'http')!==false){
				  $symbol="<img title='{$valuet}' src='{$valuet}' class='img-fluid' style='height:18px;vertical-align:middle;' />";
			 }else{
				  $symbol="<img title='{$valuet}' src='{$data['Host']}/bank/{$valuet}' class='img-fluid' style='height:18px;vertical-align:middle;' />";
			 }
			 $post['result_list'][$key]['assign_id'].="{$symbol}  ";
		 }
		
		
	}
	
	
	
	
	$data['mop_code']=array();
	

	
	$data['iconsList'] = glob('../bank/*');

display('admins');
#########################################################################
?>