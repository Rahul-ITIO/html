<?
include('../config.do');

if($_REQUEST["ptype"]){
//echo $_REQUEST["ptype"];
    $memid=$_REQUEST["memid"];	
	
	if($_REQUEST["ptype"]=="request_funds"){
		if($_REQUEST["pval"]==1){
		
		$_POST['request_funds']=0;}else{$_POST['request_funds']=$pval=1;}
		// Fetch Last Json Value from Db
		$get_clientid_details_tbl=select_table_details($memid,'clientid_table',0);
	    $profile_json=jsondecode($get_clientid_details_tbl['json_value']);
		
		if(isset($_POST['memid']))unset($_POST['memid']);
		if(isset($_POST['ptype']))unset($_POST['ptype']);
		if(isset($_POST['pval']))unset($_POST['pval']);
	    $json_value=keym_f($_POST,$profile_json);
	    $json_value=jsonencode($json_value);
		$qr=db_query("UPDATE `{$data['DbPrefix']}clientid_table` SET `json_value` = '$json_value' WHERE `id`='{$memid}'");
		if($qr){ echo "<span class='vtitle_success fa-fade'>Request Funds Status - Updated</span>";}else{ echo "<span class='vtitle_failed fa-fade'>Request Funds Status - Not Updated</span>"; }
	    
	    
	}
	
	elseif($_REQUEST["ptype"]=="vt"){
		if($_REQUEST["pval"]==1){
		
		$_POST['vt']=0;}else{$_POST['vt']=$pval=1;}
		// Fetch Last Json Value from Db
		$get_clientid_details_tbl=select_table_details($memid,'clientid_table',0);
	    $profile_json=jsondecode($get_clientid_details_tbl['json_value']);
		
		if(isset($_POST['memid']))unset($_POST['memid']);
		if(isset($_POST['ptype']))unset($_POST['ptype']);
		if(isset($_POST['pval']))unset($_POST['pval']);
	    $json_value=keym_f($_POST,$profile_json);
	    $json_value=jsonencode($json_value);
		$qr=db_query("UPDATE `{$data['DbPrefix']}clientid_table` SET `json_value` = '$json_value' WHERE `id`='{$memid}'");
		if($qr){ echo "<span class='vtitle_success fa-fade'>MOTO Status - Updated</span>";}else{ echo "<span class='vtitle_failed fa-fade'>MOTO Status - Not Updated</span>"; }
	    
	    
	}
	
	elseif($_REQUEST["ptype"]=="payout_request"){
		//$_POST['payout_request'];
		if(isset($_REQUEST["pval"])){$_POST['payout_request']=$_REQUEST["pval"];}
		// Fetch Last Json Value from Db
		$get_clientid_details_tbl=select_table_details($memid,'clientid_table',0);
	    $profile_json=jsondecode($get_clientid_details_tbl['json_value']);
		
		if(isset($_POST['memid']))unset($_POST['memid']);
		if(isset($_POST['ptype']))unset($_POST['ptype']);
		if(isset($_POST['pval']))unset($_POST['pval']);
	    $json_value=keym_f($_POST,$profile_json);
	    $json_value=jsonencode($json_value);
		
		if(isset($memid)&&$memid>0)
		{
			$qr=db_query("UPDATE `{$data['DbPrefix']}clientid_table` SET `json_value` = '$json_value',payout_request='".$_POST['payout_request']."' WHERE `id`='{$memid}'");
			if($qr){ echo "<span class='vtitle_success fa-fade'>Payout Request - Updated</span>";}else{ echo "<span class='vtitle_failed fa-fade'>Payout Request - Not Updated</span>"; }
			
			if(isset($get_clientid_details_tbl['payout_request'])&&$get_clientid_details_tbl['payout_request']>0){
				db_query("UPDATE `{$data['DbPrefix']}payout_setting` SET `payout_status`='{$_POST['payout_request']}' WHERE `clientid`='{$memid}'",0);
			}else{
				db_query("INSERT INTO `{$data['DbPrefix']}payout_setting` 
				(`clientid`, `payout_status`) VALUES
				('{$memid}','{$_POST['payout_request']}')
				",0);
			}
		}
	    
	    
	}
	
	elseif($_REQUEST["ptype"]=="qrcode_gateway_request"){
	
		if(isset($_REQUEST["pval"])){$_POST['qrcode_gateway_request']=$_REQUEST["pval"];}
		// Fetch Last Json Value from Db
		$get_clientid_details_tbl=select_table_details($memid,'clientid_table',0);
	    $profile_json=jsondecode($get_clientid_details_tbl['json_value']);
		
		if(isset($_POST['memid']))unset($_POST['memid']);
		if(isset($_POST['ptype']))unset($_POST['ptype']);
		if(isset($_POST['pval']))unset($_POST['pval']);
	    $json_value=keym_f($_POST,$profile_json);
	    $json_value=jsonencode($json_value);
		
		if(isset($memid)&&$memid>0)
		{	
			//echo "<br/><br/>clients_tbl=>";print_r($get_clientid_details_tbl);
			//echo "<br/><br/>qrcode_gateway_request=>".$get_clientid_details_tbl['qrcode_gateway_request']."<br/><br/>";
			
			
			
			$qr=db_query("UPDATE `{$data['DbPrefix']}clientid_table` SET `json_value` = '$json_value',`qrcode_gateway_request`='".$_POST['qrcode_gateway_request']."' WHERE `id`='{$memid}'");
			if($qr){ echo "<span class='vtitle_success fa-fade'>QR Code Request - Updated</span>";}else{ echo "<span class='vtitle_failed fa-fade'>QR Code Request - Not Updated</span>"; }
			
			if(isset($get_clientid_details_tbl['qrcode_gateway_request'])&&$get_clientid_details_tbl['qrcode_gateway_request']>0){
				db_query("UPDATE `{$data['DbPrefix']}softpos_setting` SET `softpos_status`='{$_POST['qrcode_gateway_request']}' WHERE `clientid`='{$memid}'",0);
			}else{
				db_query("INSERT INTO `{$data['DbPrefix']}softpos_setting` 
				(`clientid`, `softpos_status`) VALUES
				('{$memid}','{$_POST['qrcode_gateway_request']}')
				",0);
			}
			
	    }
	    
	
	}

	
}
?>