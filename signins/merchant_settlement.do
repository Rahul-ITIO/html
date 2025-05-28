<?
// http://localhost:8080/gw/signins/merchant_settlement?action=merchant_settlement&uid=11432&dtest=2&exit=2

#########################################################################
$data['PageName']='MERCHANT SETTLEMENT';
$data['PageFile']='merchant_settlement'; 
$data['rootNoAssing']=1;


##########################################################################

include('../config.do');
$data['PageTitle'] = 'Merchant Settlement '; 

##########################################################################


// Assing Private of Instance for secure cron as a whitelable 

//172.31.47.6=>https://aws-cc-uat.web1.one
//192.168.1.7=>http://localhost:8080/gw
//$secureCron_arr=["172.31.47.6","192.168.1.7"];
$secureCron_arr=$data['SECURE_CRON_PRIVATE_INSTANCE_IP'];

/*
$instancePrivateIP = gethostbyname(gethostname());
if(isset($instancePrivateIP)&&trim($instancePrivateIP)&&in_array($instancePrivateIP,$secureCron_arr))
$secureCron=1;
else $secureCron=0;

*/


###############################################################################

if(!isset($_SESSION['login_adm'])&&!isset($data['secureCron'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}


#########################################################################


if(!isset($post['action'])){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])){$post['step']=1; }


#########################################################################


if(isset($post['send'])){

					
        if($post['step']==1){
                $post['step']++;
        }elseif($post['step']==2){
			
			//echo $post['acq']; print_r($post['acq']);exit;
			
			if(!$post['comments']){
			  $data['Error']='Please enter comments';
			}else{
				$post['udate'] = date('Y-m-d H:i:s');
				
				$csv_json=[];
				if(isset($post['csv_json'])&&$post['csv_json']) $csv_json=$post['csv_json'];

				$post['csv_json']=implode(",",$csv_json);
				//echo "<br/>csv_json2=>".$post['csv_json'];exit;
				
                if(!$post['gid']){
					
					db_query(
						"INSERT INTO `{$data['DbPrefix']}auto_settlement_request`(".
						"`csv_json`,`csv_log`,`comments`,`udate`".
						")VALUES(".
						"'{$post['csv_json']}','{$post['csv_log']}','{$post['comments']}','{$post['udate']}'".
						")"
					);
					
					$csv_json=newid();
					
					$_SESSION['action_success']='<strong>Success!</strong> Created Successfully '.$post['csv_log'].' and Template ID : '.$csv_json;
				}
                else { 
				
				//`csv_json`='{$post['csv_json']}',`csv_log`='{$post['csv_log']}',
				
					db_query(
							"UPDATE `{$data['DbPrefix']}auto_settlement_request` SET ".
							"`comments`='{$post['comments']}',`udate`='{$post['udate']}'".
							" WHERE `id`={$post['gid']}",0
					);
					
					$_SESSION['action_success']='<strong>Success!</strong> Updated Successfully of ID : '.$post['gid'];
				}
				
				
				$post['step']--;
				
				$data['PostSent']=true;
				header("location:".$data['Admins']."/{$data['PageFile']}{$data['ex']}");
				exit;
				
				
          }
        }

					
}
elseif( (isset($post['action'])&&@$post['action']=='merchant_settlement' )||(isset($data['secureCron'])&&isset($secureCron_arr)&&is_array($secureCron_arr)&&in_array(@$data['secureCron'],@$secureCron_arr))  ){

	//echo "\nsecureCron2=>".@$data['secureCron']."\n";exit;

	//Via Admin session or secure cron for private ip assing in secureCron_arr of instnace 
	
	//&& $data['con_name']=='clk'

	// /signins/merchant_settlement?action=merchant_settlement&uid=27
	// http://localhost:8080/gw/signins/merchant_settlement?action=merchant_settlement&uid=11432&dtest=2&exit=2

	//		/signins/merchant_settlement?action=merchant_settlement&uid=253
	//		/signins/merchant_settlement?action=merchant_settlement&&uid=4457
	//		  signins/merchant_settlement?pfdate=2023-01-01&ptdate=2023-12-31&action=merchant_settlement&a=1
	// /signins/merchant_settlement?ptdate=2018-07-06&ptdate=2019-01-06&action=merchant_settlement&a=1
	
	//		/signins/merchant_settlement?ptdate=2020-06-09&action=merchant_settlement&a=1
	//$_GET['a']=1;
	$qprint=0;
	if(isset($_GET['a'])&&$_GET['a']){$qprint=@$_GET['a'];}
	if(isset($_GET['exit'])&&$_GET['exit']){$qprint=@$_GET['exit'];}
	
	$ctdate=date("Ymd");
	$date_2nd=date("Ymd",strtotime("+1 day",strtotime($ctdate)));
	
	//-----------------------------------------------------------
	
	
	//$ctdate_2="'$ctdate'";

	if($data['connection_type']=='PSQL') $qr_1= " ( TO_CHAR(`cdate`, 'YYYYMMDD') = '{$ctdate}' ) ";
	else $qr_1= " ( (DATE_FORMAT(`cdate`, '%Y%m%d')) = (DATE_FORMAT('{$ctdate}', '%Y%m%d')) ) ";

	$pr_get=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}auto_settlement_request`".
		"  WHERE  $qr_1  ORDER  BY  `id`  DESC  LIMIT  1",$qprint
	);
	if($qprint){
		print_r($pr_get);
	}
	
	
	if($pr_get)
	{ 
		//cmn
		echo "<br/><br/>Can process because already created on this date: ".date('d-m-Y H:i:s A',strtotime($pr_get[0]['cdate']))." and ID : ".$pr_get[0]['id'] ." <br/><br/> <a href='{$data['Admins']}/{$data['PageFile']}{$data['ex']}'><b>Go to Back</b></a><br/><br/>";
		//exit;
	}
	
	
	
	if(!isset($_GET['pfdate'])){
		$pr_get_2=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}auto_settlement_request`".
			" ORDER  BY  `id`  DESC  LIMIT  1",$qprint
		);
		if($pr_get_2){
			$_GET['pfdate']=date('Ymd',strtotime($pr_get_2[0]['cdate']));
		}
	}
	
	//echo date('Ymd',strtotime($_GET['pfdate'])); exit;
	
	//-----------------------------------------------------------
	
	
	if(isset($_GET['ptdate'])&&$_GET['ptdate']){
		$date_2nd=date("Ymd",strtotime("+1 day",strtotime($_GET['ptdate'])));
		
		$ctdate=date("Ymd",strtotime($_GET['ptdate']));
	}
				
	if(isset($_GET['pfdate'])&&$_GET['pfdate']){
		$date_1st=date("Ymd",strtotime("+0 day",strtotime($_GET['pfdate'])));
	}else{
		//$date_1st=$date_2nd;
		$date_1st=date("Ymd",strtotime("+0 day",strtotime($ctdate)));
	}
	
	$where =" WHERE ";
	//$id =" ( (`settelement_date` BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')))  AND  ( `trans_status` IN (1,7) ) AND ( `acquirer` NOT IN(2,3) ) AND ( `trans_type` IN (11)  )   )  ";

	if($data['connection_type']=='PSQL') $id= " ( `settelement_date` BETWEEN TO_DATE('{$date_1st}', 'YYYYMMDD') AND TO_DATE('{$date_2nd}', 'YYYYMMDD')  AND  `trans_status` IN (1,7)  AND  `acquirer` NOT IN(2,3)  AND  `trans_type` IN (11) ) "; 
	else $id= " ( (`settelement_date` BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')))  AND  ( `trans_status` IN (1,7) ) AND ( `acquirer` NOT IN(2,3) ) AND ( `trans_type` IN (11)  )   ) ORDER BY `tdate` DESC  ";
	
	/*

	$merID = db_rows("SELECT ".group_concat_return('`merID`',1)." AS `merID` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE ".$id."   ".
	" LIMIT 1 ".
	"",$qprint); 


	*/




	###########################################################################

	// SELECT array_to_string(array_agg(DISTINCT "clientid"), ',') AS "merID" FROM "zt_payin_setting" WHERE "settlement_optimizer"='weekly' LIMIT 1 

	$merID=db_rows(
		"SELECT ".group_concat_return('`clientid`',1)." AS `merID` FROM `{$data['DbPrefix']}payin_setting`".
		" WHERE `settlement_optimizer`='weekly' ".
		" LIMIT 1 ",$qprint
	);

	/*		
	$merID=db_rows(
		"SELECT GROUP_CONCAT(DISTINCT(`id`)) as `merID` FROM `{$data['DbPrefix']}clientid_table`".
		" LIMIT 1 ",$qprint
	);
	*/		
			
	$sizeof=count($merID);
	echo '<br/><br/>count=> '. $sizeof.'<br/><br/>';
	
	$receiver_id=$merID[0]['merID'];

	
	echo '<hr/><b style="color:#e60000;"> receiver_id from payin_setting==> '.@$receiver_id.'</b><br/>';
	
	//cmn
	//$receiver_id=4457;$qprint=1;
	if($_SESSION['login_adm']&&isset($_REQUEST['uid'])&&$_REQUEST['uid']){
		$receiver_id=$_REQUEST['uid'];
		//$qprint=1;
	}
	 
	if($qprint){
		//echo 'receiver_id=><br/>'. $receiver_id;
	}
	
	echo '<hr/><b style="color:#366a19;"> receiver_id from uid==> '.@$receiver_id.'</b><br/>';
	//exit;

	if(isset($_GET['exit'])&&$_GET['exit']==1) exit;
	
	$receiver_arr=[];
	if($receiver_id){
		$receiver_arr=explode(',',$receiver_id.",");
	}
	
	
		$i=1; $csv_json=array();$csv_log_arr=array();
		// loop over the rows, outputting them
		foreach($receiver_arr as $value){
			if($value){
				$da_se=array();$wp=array();$da_se2=array();$np=array();
				
				$uid=$value;
				if($qprint){echo '<br/>uid=>'.$uid.'<br/>';}
				$da_se['send']=$uid;
				$da_se['bid']=$uid;
				$da_se['curl']="byCurl";
				$da_se['admin']="1";

				if(isset($data['secureCron'])){
					$da_se['secureCron']=$data['secureCron'];
					$w_url_cron='trans_withdraw-fund_v3_custom_settlement_private_ip_allow.php';
				}
				else $w_url_cron="trans_withdraw-fund_v3_custom_settlement".$data['ex'];
				
				//cmn
				//$da_se['amount']=3.00;
				
				
				
				$w_url=$data['USER_FOLDER']."/{$w_url_cron}?curl=1&admin=1&bid=".$uid.((isset($_GET['exit'])&&$_GET['exit'])?'&exit='.$_GET['exit']:'');

				
				if(isset($data['secureCron'])) echo "\n w_url=>".@$w_url."\n";
				
				//$w_url.="&cp=1";
				//$w_url=$data['USER_FOLDER']."/withdraw-frozen-fund{$data['ex']}?curl=1&admin=1&bid=".$uid;
				
				$da_se['ThisTitle']='PAYOUT_POST';
				
				//cmn
				//$da_se['CURLOPT_HEADER']='1';
				
				$wp_get=use_curl($w_url,$da_se);
				
				
				
				$wp=jsondecode($wp_get);
				
				if($qprint)
				{
					
					echo '<br/>w_url=>'.@$w_url; 
					
					echo '<br/><hr/><br/>wp_get=><br/>'; print_r(@$wp_get);
					
					echo "<br/><hr/><br/>wp_response=><br/>";
					print_r(@$wp);
					
					echo "<br/><br/>wd_id=><br/>".@$wp['clk']['wd_id'];
					echo "<br/><br/>transID=><br/>".@$wp['clk']['transID'];
					//exit;
					
					//cmn
					//$nodal_cashfree_url=$data['Host']."/nodal/cashfree.do?transID=2576453103_457645&actionurl=by_admin&acquirer=2&admin=1&cron_tab=PAYOUT_NODAL_WD1";
				}
				
				

				if(@$wp['clk']['wd_id']){
					
					$nodal_cashfree_url=$data['Host']."/nodal/cashfree{$data['ex']}?transID={$wp['clk']['transID']}_{$wp['clk']['wd_id']}&actionurl=by_admin&acquirer=2&admin=1&cron_tab=PAYOUT_NODAL_WD";
				
					$da_se2['curl']='byCurl';
					$da_se2['cron_tab']='PAYOUT_NODAL_WD';
					$nodal_get=use_curl($nodal_cashfree_url,$da_se2);
					
					$np=jsondecode($nodal_get);
					
				}
				
				if($qprint){
					echo "<br/><br/>nodal_cashfree_url=><br/>".@$nodal_cashfree_url;
					echo "<br/><br/>nodal_get=><br/>";
					print_r(@$nodal_get);
					echo "<br/><br/>np=><br/>";
					print_r(@$np);
				}
				
				
				if($wp){
					if($np){
						$csv_json[] = array_merge($da_se,$wp['clk'],$np);
						$csv_log_arr[]  = array_merge($da_se,$wp,$np);
					}else{
						$csv_json[] = array_merge($da_se,$wp['clk']);
						$csv_log_arr[]  = array_merge($da_se,$wp);
					}
					
				}
				
				
				if($qprint){
					
					echo '<br/>w_url=>'.$w_url; 
					echo '<br/>wp=>'; 
					print_r($wp); 
				
					//exit;
				}
				
			
			
				$i++;
				
			}
			
		}
		
		
		//-----------------------------------------------------------
		
		$comments='';
		$csv_log=jsonencode($csv_log_arr);
		$csv_json=jsonencode($csv_json);
		
		//-----------------------------------------------------------
		
		if(isset($_SESSION['sub_admin_id'])){
			$admin_id=$_SESSION['sub_admin_id'];
		}else{
			$admin_id='Admin';
		}
		$pLog=@$pr_get[0]['all_log'];
		$cLog['tm_user']=$admin_id;
		$cLog['tm_date']=date('Y-m-d H:i:s A');
		$cLog['tm_log']=$csv_log_arr;
		$all_log=json_log($pLog,$cLog);
		//$t_log=jsonencode($cLog);
		if($qprint){
			echo "<hr/>all_log=>". $all_log; 
		}
		
	
		//-----------------------------------------------------------
		
		$csv_log=trim(@$csv_log,'[]');
		$csv_json=trim(@$csv_json,'[]');
		$all_log=trim(@$all_log,'[]');

		
		$csv_log=ltsr(@$csv_log);
		$csv_json=ltsr(@$csv_json);
		$all_log=ltsr(@$all_log);

		

		if($qprint){

				echo '<br/><hr/><br/><b style="color:#e60000;">csv_log=></b><br/>'; 
				print_r(@$csv_log);

			echo "<hr/>csv_json=>".$csv_json;
			echo "<hr/>";
		}

		if(isset($_GET['exit'])&&$_GET['exit']==2) exit;

		/*
		if($pr_get){
			db_query(
					"UPDATE `{$data['DbPrefix']}auto_settlement_request` SET ".
					"`csv_json`='{$csv_json}',`csv_log`='{$csv_log}',`all_log`='{$all_log}',`udate`='".date("Y-m-d H:i:s")."'".
					" WHERE `id`={$pr_get[0]['id']}",$qprint
			);
		}else
		
		{
			
			db_query(
				"INSERT INTO `{$data['DbPrefix']}auto_settlement_request`(".
				"`csv_json`,`csv_log`,`all_log`,`comments`,`udate`".
				")VALUES(".
				"'{$csv_json}','{$csv_log}','{$all_log}','{$comments}','".date("Y-m-d H:i:s")."'".
				")",$qprint
			);
			
		}
		*/

		db_query(
			"INSERT INTO `{$data['DbPrefix']}auto_settlement_request`(".
			"`csv_json`,`csv_log`,`all_log`,`udate`".
			")VALUES(".
			"'{$csv_json}','{$csv_log}','{$all_log}','".date("Y-m-d H:i:s")."'".
			")",$qprint
		);
		
		$csv_json_id=newid();
	
		echo "\n csv_json_id=>".@$csv_json_id."\n";

	//echo "<hr/>merchant_settlement=>";
	if(isset($_REQUEST['actionType'])&&$_REQUEST['actionType']=='web')
		header("Location:".@$data['Admins'].'/'.@$data['PageFile'].@$data['ex']);
	else exit;
}
elseif($post['action']=='update'){
       
	   global $data;
	    $id = $post['gid'];
		//echo "<div style='margin-top:100px;'></div>"; print_r($id);
		$updateList=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}auto_settlement_request`".
                " WHERE `id`={$id} LIMIT 1"
        );
        
		$results=array();
        foreach($updateList as $key=>$value){
                foreach($value as $name=>$v)$results[$key][$name]=$v;
        }
		if($results)foreach($results[0] as $key=>$value)if(!$post[$key])$post[$key]=$value;
        
		//$post['csv_json']=explode(",",$post['csv_json']);
		
		//echo "acq=>"; echo "processing_currency=>".$post['acq']['processing_currency']; print_r($post['acq']);
		
		//echo "<div style='margin-top:100px;'></div>"; print_r($post);
		
        $post['actn']='update';
        $post['step']++;
		
		
}
	

	$select_pt=db_rows(
		"SELECT * FROM {$data['DbPrefix']}auto_settlement_request".
		//" WHERE `id` IS NOT NULL ".$status." ".$sponsor_qr.
		" ORDER BY id DESC ",0
	);
	
	$post['result_list']=array();
	//print_r($select);
	
	foreach($select_pt as $key=>$value){
		//$post['result_list'][$key]=json_decode_is($value);
		$post['result_list'][$key]=@$value;
	}
	
	/*
	$select_acquirer_table=db_rows(
		"SELECT * FROM {$data['DbPrefix']}acquirer_table".
		//" WHERE `id` IS NOT NULL ".$status." ".$sponsor_qr.
		" ORDER BY id DESC ",0
	);
	
	//echo sizeof($select_acquirer_table);
	
	$data['csv_json']=array();
	
	foreach($select_acquirer_table as $key=>$value){
		$data['csv_json'][$value['acquirer_id']]="{$value['acquirer_id']} | ".($value['acquirer_prod_mode']==1?"Live":"Test")." | ".($value['acquirer_status']?"Active":"Inactive")." | {$value['acquirer_name']}";
	}
	//print_r($data['csv_json']);
	
	*/

display('admins');
#########################################################################
?>