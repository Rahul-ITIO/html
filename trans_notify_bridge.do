<?php
//this file will be used to check if merchant getting callback or not
$data['PageName']='notify_bridge';
$data['PageFile']='notify_bridge';
$data['HideMenu']=true;
$data['NO_SALT']=true;
$data['SponsorDomain']=true;
include('config.do');//include config file
//this condition performs a series of checks to determine the value of the $transID variable. If the value of $data['ROOT_FILE'] is not set, the code retrieves the transaction ID from various sources (query parameter, session variables) and performs additional processing if the ID contains an underscore

//$_GET['dtest']=9;

$notify_condition=1;

if(!isset($data['ROOT_FILE'])){
	
	$transID='';
	if(isset($_REQUEST['transID'])&&$_REQUEST['transID']) $transID=$_REQUEST['transID'];
	elseif(isset($_SESSION['transID'])) $transID=$_SESSION['transID'];
	elseif(isset($_SESSION['SA']['transID'])) $transID=$_SESSION['SA']['transID'];

	if(strpos($transID,'_')!==false){
		$transID=transIDf($transID,0);
	}

	//this function will be used for transaction status on based transaction id
	function t_statusf($transID){
		global $data;
		
		//Select Data from master_trans_additional
		$join_additional=join_additional('i');
		if(!empty($join_additional)) $mts="`ad`";
		else $mts="`t`";
		
		// ,`t`.`terNO`,{$mts}.`rrn`
		
		$t_status_row=db_rows(
			"SELECT `t`.`id`,`t`.`acquirer`,`t`.`trans_status`,`t`.`bill_amt`,`t`.`transID`,`t`.`tdate`,`t`.`bill_currency`,`t`.`merID`,`t`.`mop`,`t`.`reference`,`t`.`terNO`,{$mts}.`rrn`,{$mts}.`json_value`,{$mts}.`source_url`,{$mts}.`webhook_url`,{$mts}.`return_url`,{$mts}.`trans_response`,{$mts}.`descriptor` ". 
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t`".
			" {$join_additional} WHERE  `t`.`transID` IN ({$transID})  ".
			" LIMIT 1 ",0 //DESC ASC
		);
		$t_status=$t_status_row[0];
		return $t_status;
	}

	
	
	$t_status=t_statusf($transID);	

	$tr_id=$t_status['id'];
	$webhook_url=$t_status['webhook_url'];
	$notify_status=jsonvaluef($t_status['json_value'],'NOTIFY_STATUS');
	$notify_failed_source=jsonvaluef($t_status['json_value'],'NOTIFY_FAILED_SOURCE');

	if(isset($_GET['dtest']))
	{
		echo "<br/><hr/><br/>webhook_url=>".$webhook_url;
		echo "<br/><hr/><br/>notify_status=>".$notify_status;
	}

	

	if(isset($notify_status)&&$notify_status=='DONE'&&!isset($data['ROOT_FILE']))
	{
		$webhook_url='';
		$notify_condition=0;
	}
	
	if(isset($_GET['dtest'])) echo "<br/><hr/><br/>webhook_url=>".$webhook_url;

	
	$notify_send_source='notify_bridge';
	$updated_by='';
	
	$_SESSION['SA']['WEBHOOK_BRIDGE']='Y';

	
	
	#########  notify t_status	##################################
			
	$status_array["order_status"]=$t_status['trans_status'];
	if($t_status['trans_status']==8){
		$status_array["status"]="Request Processed";
	}else{
		$status_array["status"]=$data['TransactionStatus'][$t_status['trans_status']];
	}
	
	$status_array["bill_amt"]=$t_status['bill_amt'];
	$status_array["transID"]=$t_status['transID'];
	$status_array["descriptor"]=$t_status['descriptor'];
	//$status_array["tdate"]=date('Y-m-d H:i:s',strtotime($t_status['tdate']));
	$status_array["tdate"]=@$t_status['tdate'];
	$status_array["bill_currency"]=get_currency($t_status['bill_currency'],1);
	$status_array["response"]=$t_status['trans_response'];
	$status_array["reference"]=$t_status['reference'];
	if($t_status['mop']){
		$status_array["mop"]=$t_status['mop'];
	}
	
	
	
}



//if(!isset($_SESSION['notifybridge_url_mer']))
{
	$_SESSION['notifybridge_url_mer']=(isset($t_status['return_url'])&&trim($t_status['return_url'])?$t_status['return_url']:'');

	if(isset($status_array)&&is_array($status_array)&&count($status_array)>0)
	{
		if(strpos($_SESSION['notifybridge_url_mer'],'?')!==false){
			$_SESSION['notifybridge_url_mer']=$_SESSION['notifybridge_url_mer']."&".http_build_query(@$status_array);
		}else{
			$_SESSION['notifybridge_url_mer']=$_SESSION['notifybridge_url_mer']."?".http_build_query(@$status_array);
		}
	}

	
}

$via_web='webhook';
//if $data['ROOT_FILE'] is present
if(isset($data['ROOT_FILE'])){
	$via_web=@$data['ROOT_FILE'];
	//If a session variable named "sub_admin_id" is set, the value of $admin_id is constructed using the format "sub_admin_id:sub_admin_fullname-sub_admin_rolesname".
	if(isset($_SESSION['sub_admin_id'])){
		$admin_id=$_SESSION['sub_admin_id'].":".$_SESSION['sub_admin_fullname']."-".$_SESSION['sub_admin_rolesname'];
	}//If a session variable named "m_username" is set and "adm_login" is not set in the session, the value of $admin_id is constructed using the format "Merchant:uid-m_username".
	elseif(isset($_SESSION['m_username'])&&(!isset($_SESSION['adm_login']))){
		$admin_id="Merchant:".$_SESSION['uid']."-".$_SESSION['m_username'];
	}//If session variables "admin_id" and "sub_username" are set, the value of $admin_id is constructed using the format "Admin : admin_id - sub_username". If $uid is set (likely representing a user ID), the value of $admin_id
	else{
		if(isset($_SESSION['admin_id'])&&isset($_SESSION['sub_username'])){
			$admin_id="Admin : ".$_SESSION['admin_id']." - ".$_SESSION['sub_username'];
		}
		elseif(@$uid)
		{
			$admin_id="Merchant:".$uid."-".get_clients_username($uid);
		}
		else{
			$admin_id='Admin...';
		}
	}
	
	$updated_by='Manually updating via '.$admin_id.' for ';
	
	$notify_send_source=$data['ROOT_FILE'];
}


	
//$_GET['dtest']=1;
######	for notify query		############
//if(!empty($webhook_url)&&$notify_status!='DONE')
if(!empty($webhook_url)&&@$notify_condition==1)
{
	
	$webhook_url=curl_url_replace_f($webhook_url);
	
	$status_array['webhook']="notify";
	// Merchant received for notify_via s2s_base_notify
	$status_array['webhook_via']="s2s_base_{$via_web}_notify_bridge";	
	$chs = curl_init();
		curl_setopt($chs, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
	curl_setopt($chs, CURLOPT_URL, $webhook_url);
	curl_setopt($chs, CURLOPT_HEADER, FALSE); // FALSE || true || 
		curl_setopt($chs, CURLOPT_MAXREDIRS, 10);
	curl_setopt($chs, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($chs, CURLOPT_SSL_VERIFYHOST, 0);
	curl_setopt($chs, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($chs, CURLOPT_POST, true);
	curl_setopt($chs, CURLOPT_POSTFIELDS, http_build_query($status_array));
	curl_setopt($chs, CURLOPT_TIMEOUT, 0);
	$notify_res = curl_exec($chs);
	curl_close($chs);
	
	
	#######	save notificatio response	#############

	//$return_notify_json='{"notify_code":"00","notify_msg":"received"}'; echo ($return_notify_json); exit;
	
	$notify_de = json_decode($notify_res,true);
	if(isset($notify_de)&&is_array($notify_de)){
		//print_r($notify_de);
		if($notify_de['notify_msg']=='received'){
			$tr_upd_notify['NOTIFY_BRIDGE']['MERCHANT_RECEIVE']='NOTIFY_RECEIVE';
		}
	}	
	$tr_upd_notify['NOTIFY_BRIDGE']['NOTIFY_STATUS']='DONE';
	$tr_upd_notify['NOTIFY_BRIDGE']['time']=prndates(date('Y-m-d H:i:s'));
	$tr_upd_notify['NOTIFY_BRIDGE']['NOTIFY_SEND_SOURCE']=$notify_send_source;
	$tr_upd_notify['NOTIFY_BRIDGE']['RES']=$status_array;
	
	$tr_upd_notify['system_note']=$updated_by.'<b>Source - '.$notify_send_source.'</b> | Notify sent as log not found | Current Status : <b>'.$status_array['status'].'</b> status sent on url '.$webhook_url;
	
	//$tr_upd_notify['NOTIFY_BRIDGE']['get_info']=htmlentitiesf($notify_res);
	
	//exit;
	
	
}
//this part of the code handles cases where the webhook URL is missing or present, and it updates the $tr_upd_notify array and system notes accordingly based on these scenarios. It also sets the webhook_via value to indicate the method of notification reception.
elseif((empty($webhook_url))&&($notify_failed_source='')){
	$tr_upd_notify['NOTIFY_FAILED_TIME']=prndates(date('Y-m-d H:i:s'));
	$tr_upd_notify['NOTIFY_FAILED_SOURCE']='notify_bridge';
	$tr_upd_notify['NOTIFY_FAILED']='Missing notify url';
	$tr_upd_notify['system_note']='<b>Source - '.$notify_send_source.'</b> | Notify skipped as log found | Current Status : <b>'.$status_array['status'].'</b> status as <b>notify url missing</b>';
}else {
	$tr_upd_notify['NOTIFY_TIME_'.$notify_send_source]=prndates(date('Y-m-d H:i:s'));
	$tr_upd_notify['system_note']=$updated_by.'<b>Source - '.$notify_send_source.'</b> | Curl Notify skipped as log found | Notify push via Host | Current Status : <b>'.$status_array['status'].'</b> status';
	
	// Merchant received for notify_via host_base_notify
	$status_array['webhook_via']="host_base_notify_bridge";	
}


if(isset($data['ROOT_FILE'])){
	if(($transID>0)&&(isset($transID))){
		trans_updatesf(0,$tr_upd_notify,0,$transID);
	}
	
} else {
	if(($tr_id&&$tr_id>0)&&(isset($tr_upd_notify))){
		trans_updatesf($tr_id, $tr_upd_notify);
	}
}

$_POST=$dataRedirect=$status_array;

// Merchant received for trans_status from dataRedirect  
$dataRedirect['webhook']='OK';
if(isset($dataRedirect['webhook_via'])) unset($dataRedirect['webhook_via']);

if(isset($_GET['dtest'])&&$_GET['dtest']>1)
{
	echo "<br/>transID=>".$transID;
	
	//echo "<br/><br/><br/>_SESSION=>";print_r($_SESSION);
	echo "<br/><br/><hr/><br/><br/>_POST=>";print_r(@$_POST);
	echo "<br/><br/><hr/><br/><br/>dataRedirect=>";print_r(@$dataRedirect);
	
	echo "<br/><br/><hr/><br/><br/>transID=>".@$_SESSION['transID'];
	echo "<br/>webhook_url=>".@$webhook_url;
	echo "<br/>notifybridge_url_mer=>".@$_SESSION['notifybridge_url_mer'];
	echo "<br/>notifybridge_url_nofity=>".@$_SESSION['notifybridge_url_nofity'];
	echo "<br/>notifybridge_res=>";print_r(@$notifybridge_res);
	echo "<br/>tr_upd_notify=>";print_r(@$tr_upd_notify);
	//echo $bankstatus;
}




//The function is particularly useful when you want to avoid exposing the data in the URL itself.
function redirect_post_use_2($url, array $data)
{
    ?>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <script >
            function closethisasap() {
                document.forms["redirectpost"].submit();
            }
        </script>
    </head>
    <body onload="closethisasap();">
    <form name="redirectpost" method="post" target="_top" action="<?php echo $url; ?>">
        <?php
        if ( !is_null($data) ) {
            foreach ($data as $k => $v) {
                echo '<input type="hidden" name="' . $k . '" value="' . $v . '"> ';
            }
        }
        ?>
    </form>
    </body>
    </html>
    <?php
    exit;
}
?>

<!DOCTYPE html>
<html lang="en-US">
<head>
<title>Processing...</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<style>
body{margin:0;padding:0;overflow:hidden;width:100%;height:100%;font-size:14px;color:#5d5c5d; }
</style>


<script >
if (typeof jQuery == 'undefined') {
  document.write('<script  src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"><\/script>');        
  } 
</script>

<script>
/*This function can be useful for scenarios where you want to redirect the user to another page while passing data to that page using a POST request*/
	function redirect_Postf(url, data) {
		console.log("==== trans_notify_bridge || redirect_Postf===="+url);
		var form = document.createElement('form');
		document.body.appendChild(form);
		form.method = 'post';
		form.target = '_top';
		form.action = url;
		for (var name in data) {
			var input = document.createElement('input');
			input.type = 'hidden';
			input.name = name;
			input.value = data[name];
			form.appendChild(input);
		}
		form.submit();
	}
	function updateTimer() {
		timeLeft -= 1000;
		if (timeLeft > 0) {
			timer.text(msToTime(timeLeft));
			//alert('11if');
		} else {
			//window.location.reload(true);
			
		}
	}
    //The function returns the formatted time as a string in the format "minutes:seconds".
	function msToTime(s) {
		  var ms = s % 1000;
		  s = (s - ms) / 1000;
		  var secs = s % 60;
		  s = (s - secs) / 60;
		  var mins = s % 60;
		  var zero = secs <= 9 ? '0' : '';
		  return mins + ':' + zero + secs;
	}
	var timeLeft = 0;
	var timer;
	
	
		
	var redirecturl="<?=@$_SESSION['notifybridge_url_mer']?>";
	var dataPost=<?=json_encode($dataRedirect)?>;
	
	console.log("==== trans_notify_bridge || redirecturl===="+redirecturl);

	function pay_load_postf(){
		console.log("====pay_load_postf===="+redirecturl);
		if(redirecturl){redirect_Postf(redirecturl,dataPost);}
	}
	

</script>


<? if(isset($_GET['dtest'])&&$_GET['dtest']==9)exit; ?>

<?if(!empty($webhook_url)&&@$notify_condition==1&&!isset($data['ROOT_FILE'])){?>
<script >
/*this code sends a GET request to the specified webhook URL while passing certain data (notify_data_var) as part of the request. It then updates the UI to indicate the result of the request and triggers a function (pay_load_postf()) that might handle redirection or some further action. The exact purpose of pay_load_postf() would likely be determined by the rest of the code not included in the provided snippet*/
var webhook_url_var="<?=@$webhook_url?>";
var notify_data_var=<?=json_encode($status_array)?>;
$(document).ready(function(){
    $("#webhook_url_load_content").load(webhook_url_var, notify_data_var, function(responseTxt, statusTxt, jqXHR){
		
		if(statusTxt == "success"){
			//alert("New content loaded successfully!");
			$("#webhook_url_status").html("<h2>Notify Pushed Successfully --\> Redirecting......</h2>");
			pay_load_postf();
		}
		if(statusTxt == "error"){
			$("#webhook_url_status").html("<h2>Notify Pushed Successfully --\> Redirecting......</h2>");
			pay_load_postf();
		}
	});
});
</script>
<?
} 
else{
	#######	for post method		##############
	if(isset($_SESSION['notifybridge_url_mer'])&&trim($_SESSION['notifybridge_url_mer'])){
		//header("Location:".$_SESSION['notifybridge_url_mer']);exit;
		//redirect_post_use_2($_SESSION['notifybridge_url_mer'], $dataRedirect);
	?>
		<script>
			top.window.location.href="<?=@$_SESSION['notifybridge_url_mer']?>";
		</script>
	<?
	}
}
?>
</head>
<body oncontextmenu='return false;'>
	<div id="webhook_url_status" style="float:left;font-size:18px;width:345px;text-align:center;position: absolute;z-index:99;top:50%;left:50%;margin:-10px 0 0 -173px;"></div>
	<div id="webhook_url_load_content" style="display:none;"></div>
</body>
</html>


<?if(empty($_SESSION['notifybridge_url_mer'])){?>
<script >
	window.setTimeout(function(){
		window.close();
	},500);
</script>
<?
} ?>