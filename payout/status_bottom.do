<?

// start : include_status_bottom

//start: cron step: 1 -----------------------------------------

	if(isset($_SESSION['hkip_info'])){
	$_SESSION['hkip_info']=str_replace('N/A - ','',$_SESSION['hkip_info']);
	}

	$data_send=array();
	$data_send['mh_oid']			=$orderset;
	$data_send['orderset']			=$orderset;
	$data_send['hkip_action']		=(isset($_SESSION['hkip_action'])?$_SESSION['hkip_action']:'');
	$data_send['hkip_info']			=(isset($_SESSION['hkip_info'])?$_SESSION['hkip_info']:'');
	$data_send['hkip_status']		=(isset($_SESSION['hkip_status'])?$_SESSION['hkip_status']:'');
	$data_send['hkip_order_status']	=(isset($_SESSION['hkip_order_status'])?$_SESSION['hkip_order_status']:'1');
	$data_send['hkip_pid']			=(isset($_SESSION['hkip_pid'])?$_SESSION['hkip_pid']:'');
	$data_send['hkip_billing_desc']	=(isset($_SESSION['hkip_billing_desc'])?$_SESSION['hkip_billing_desc']:'');
	$data_send['type']				=$td['type'];
//	$data_send['actionurl']			='admin_direct';
	$data_send['admin']				='1';

	if($td['type']!=43&&isset($_SESSION['curl_values']))$data_send['curl_values']=$_SESSION['curl_values'];
//end: cron step: 1 -----------------------------------------

	db_disconnect();

	if($data_send['hkip_order_status']==2){ //success
		$callbacks_url = $host_path."/payout/success{$data['ex']}?orderset=$orderset&action=hkip".$subQuery;
	}
	elseif($data_send['hkip_order_status']==1){ //pending
		if(isset($_SESSION['adm_login'])){
			$callbacks_url = 'javascript:alert("'.$data_send['hkip_info'].'");';
		}elseif($cardsend=="CHECKOUT"){
			$callbacks_url = $host_path."/payout/transaction_processing{$data['ex']}?orderset=$orderset&action=hkip".$subQuery;
		}
		//$onclick='javascript:top.popupclose();';
	}
	else{ //failed
		$callbacks_url = $host_path."/payout/failed{$data['ex']}?orderset=$orderset&action=hkip".$subQuery;
	}
	
	if(((strpos($td['type'],'52')!==false)||(strpos($td['type'],'53')!==false))&&($_REQUEST['actionurl']=='notify')){
		//include('status_in_email'.$data['iex']);
	}
	
	if($qp){
		echo "<hr/>is_admin=>".$is_admin;
		echo "<hr/>actionurl=>".$_REQUEST['actionurl'];
	
		echo "<hr/>order_status=>".$data_send['hkip_order_status'];
		echo "<hr/>info=>".$data_send['hkip_info'];
		echo "<hr/>callbacks_url=>".$callbacks_url;
		echo "<hr/>results=>";print_r($results);
		exit;
	}
	if(isset($_GET['check_auth'])&&$_GET['check_auth'])
	{
		$is_admin = false;
	}
	if($is_admin==false){
		if(isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='notify'){
			$use_curl=use_curl($callbacks_url,$data_send);
			exit;
		}else{
			post_redirect($callbacks_url, $data_send);
		}
	}

	// admin status

	//json
	if((isset($_REQUEST['json']))&&(!empty($_REQUEST['json']))){
		$json["hkip_order_status"]=$data_send['hkip_order_status'];
		$json["callbacks_url"]=$callbacks_url;

		header("Content-Type: application/json", true);
		echo json_encode($json);
		exit;
	}
	
	
	
	if($is_admin){
		if((isset($_REQUEST['actionurl']))&&($_REQUEST['actionurl']=="hkipme"||$_REQUEST['actionurl']=="customer"||$_REQUEST['actionurl']=="admin_direct")){
			//echo $callbacks_url;
			if($data_send['hkip_order_status']==1){
				exit;
			}else{
				//start: cron step: 2 --------------------
				if($_REQUEST['actionurl']=="admin_direct"){
					$use_curl=use_curl($callbacks_url,$data_send);
					exit;
				} //end: cron step: 2 --------------------
				else{
					post_redirect($callbacks_url, $data_send);

					//header("location:$callbacks_url");
				}
			}
		}

		if ((strpos ( $callbacks_url, $_SERVER['SERVER_NAME'] ) !== false) ){

		}else{
			$callbacks_url=str_replace('actionurl=by_admin','actionurl=admin_direct',$data['urlpath']);
		}

		echo "<div class='hk_sts'><div class='rows'>";

		if(isset($data_send['hkip_order_status'])){
			echo "<a target='hform' onclick='{$onclick}' href='$callbacks_url' class='upd_status'>Update Status "." [<b>".$data_send['hkip_info']."</b>]"."</a>";
		}else{
			if(isset($bank_status_limit)&&$bank_status_limit){
				echo "<a class='upd_status'>transaction not found <b style='color:red!important;'>please recheck after 1 minutes</b>"."</a>";
			}else{
				echo "<a target='hform' onclick='{$onclick}' href='$callbacks_url' class='upd_status'>transaction not found [<b>Proceed to Cancelled </b>]"."</a>";
			}
			
		}

		if(isset($results)) display_nested_array($results);
							
		echo "</div>";

		//echo "<br/><br/>Info: ".$results['info'];
		//echo "<br/><br/>Status: ".$result_hkip['status'];
		echo "<br/><br/><strong>order_status:</strong> ".$data_send['hkip_order_status']." [".$data_send['hkip_info']."]";
		echo "<br/><br/><b>pid:</b> ".$data_send['hkip_pid'];
		echo "<br/><br/><b>billing_desc:</b> ".$data_send['hkip_billing_desc'];
		echo "<br/><br/><b>respMsg:</b> ".$data_send['hkip_info'];
		echo "<br/><br/><b>mh_oid:</b> ".$orderset;

		if(isset($site_id))
			echo "<br/><br/><b>site_id:</b> ".$site_id;

		echo "</div>";
	}
exit;

// end : include_status_bottom


?>