<?php
$config_root='../config_root.do';
if(file_exists($config_root)){include($config_root);}
error_reporting(0);	

$txtmsg=$msg=$found=false;
if ((isset($_POST['transCheck']))&&(!empty($_POST))){
	$txtmsg=true;
	$url_e=$_POST['u'];
	$transID_e=explode(',',$_POST['e']);
	$msg="Total Request of TransID : <b>".count($transID_e)."</b>";
	
	if(isset($_REQUEST['qr'])&&$_REQUEST['qr'])
	echo "<br/><br/>URL=>".$url_e; 
	//echo "<br/><br/>transID_e=>"; print_r($transID_e);
	
	if(count($transID_e)>0){
		foreach($transID_e as $val){
			
			$url_set=$url_e."&transID=".$val;
			
			if(isset($_REQUEST['qr'])&&$_REQUEST['qr'])
			echo "<br/>url_set=>".$url_set; 
			
			$post_data['action']='webhook';
			$post_data['transID']=$val;
			$use_curl_e=use_curl_e($url_set,$post_data);
			
			if(isset($_REQUEST['qr'])&&$_REQUEST['qr']) print_r($use_curl_e);
			
		}
		
	}
	
	
}// End if post form
	
//To send request and access any page/url via curl.
function use_curl_e($url, $post=null){
	$protocol= isset($_SERVER["HTTPS"])?'https://':'http://'; //Server and execution environment info
	$referer = $protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];	//The URI which was given in order to 
	
	if(isset($_GET['qp']))
	{
		echo '<br/><br/><=use_curl=><br/><br/>url=>'.$url;
		echo '<br/><br/><=use_curl post=><br/><br/>post=>';print_r($post);
	}
	
	$handle=curl_init();	//Initializes a new session and return a cURL handle.
	
	curl_setopt($handle, CURLOPT_URL, $url);	//The string pointed to in the CURLOPT_URL argument is expected to be a sequence of characters using an ASCII compatible encoding.
	
	if(isset($post['json_encode'])&&$post['json_encode']){
		$post=json_encode($post);	//array to json
		curl_setopt($handle, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));	//Pass a pointer to a linked list of HTTP headers to pass to the server and/or proxy in your HTTP request. 
		unset($post['json_encode']);	//unset json encode from $post array
	}
	
	if($post){
		curl_setopt($handle, CURLOPT_POST, 1);	//true to do a regular HTTP POST. CURLOPT_POST to 0, libcurl resets the request type to the default to disable the POST
		curl_setopt($handle, CURLOPT_POSTFIELDS, $post);	// Set the full data to post in a HTTP "POST" operation.
	}
	curl_setopt($handle, CURLOPT_REFERER, $referer);	// The contents of the "Referer: " header to be used in a HTTP request. 
	if(isset($post['CURLOPT_HEADER'])&&$post['CURLOPT_HEADER']==1) $curlopt_header=1;
	else $curlopt_header=0;
	curl_setopt($handle, CURLOPT_HEADER, $curlopt_header);			// true to include the header in the output. 
	curl_setopt($handle, CURLOPT_SSL_VERIFYPEER, 0);	//Curl verifies whether the certificate is authentic. false to stop cURL from verifying the peer's certificate. 
	curl_setopt($handle, CURLOPT_SSL_VERIFYHOST, 0);	// Subject Alternate Name field in the SSL peer certificate matches the provided hostname. 0 to not check the fullname

	//curl_setopt($handle, CURLOPT_COOKIESESSION, 1);
	
	curl_setopt($handle, CURLOPT_RETURNTRANSFER, 1);	// true to return the transfer as a string of the return value of curl_exec() instead of outputting it directly. 

	curl_setopt($handle, CURLOPT_TIMEOUT, 60);	// The maximum number of seconds to allow cURL functions to execute. 
		
	$result=curl_exec($handle);	//Execute the curl request. 

	$http_status	= curl_getinfo($handle, CURLINFO_HTTP_CODE);	//received curl response in code
	$curl_errno		= curl_errno($handle);	//received curl error in code
	curl_close($handle);	//close curl execution

	//check status with code
	if ( ( $http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404 ) && (!isset($data_send['cron_tab']) ) ) {
		$err_5001=[];
		$err_5001['Error']="5001";
		$err_5001['Message']="HTTP Status is {$http_status} and returned ".$curl_errno;
		json_print($err_5001);
	}
	elseif($curl_errno){	//check and print error with code
		$err_5002=[];
		$err_5002['Error']="5002";
		$err_5002['Message']="HTTP Status is {$http_status} and Request Error ".curl_error($handle);
		json_print($err_5002);
	}
	
	return $result;
}

	
//if (strpos($_SERVER['PHP_SELF'],'slog'.$data['ex']))
{
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Trans Status Update for Processing...</title>
<style>
body {width:100%;height:100%;margin:0;padding:0;font-family:Arial, Helvetica, sans-serif;font-size:14px;line-height:normal;}
.frm{width:98%; margin:0 auto; border:1px solid gray; height:auto;padding:10px;border-radius: 6px;}
.lab{width:15%; float:left;text-align:right;padding:10px;font-weight:bold;}
.txt{width:25%; float:left;text-align:left;padding:10px;}
.fld {width:90%; padding:10px;}
.sub{clear:both;width:90%; padding:10px; margin:0 auto; float:none; text-align:center;}
.btn{ background-color:#009; color:#FFF; padding:15px; margin:20px; width:25%; font-eight:bold; border:1px solid #000;cursor:pointer;font-size:20px;border-radius:6px;}
.msg{padding:15px;color:#00F;font-size:15px; text-align:center; height:30px; margin:0 auto;}
textarea {width: 99%; height:400px; word-wrap: break-word;border-bottom: 1px solid #ede6e6;margin: 0 auto;padding: 10px;font-size: 13px;}
p {width: 99%;word-wrap: break-word;border-bottom: 1px solid #ede6e6;margin: 0 auto;padding: 10px;font-size: 13px;}
.small{width:auto !important; font-size:15px;margin:0 auto !important; padding:10px !important;float:leftheight:42px;}
.slt{float:left;width:200px;padding:10px;}
xmp{ white-space:pre-wrap; word-wrap:break-word; }
</style>
</head>

<body>

<div class="frm">
  <form name="mysfrm" id="mysfrm" method="post" action="">
	 <?php
		if ($msg!=''){echo "<b>Search Result:</b><br/><br/>".$msg."<br/><br/>"; $msg=false;}
	?>
	<?/*?>
	<textarea name="u" class="form-control" required placeholder="Enter Url" style="height:20px;margin:0 0 20px 0;line-height:20px;"><?=$data['Host']?>/status<?=$data['ex']?>?action=webhook</textarea>
	<?*/?>
	
	<?
	if(isset($_POST['u'])&&$_POST['u'])
		$u_val=$_POST['u'];
	else $u_val=$data['Host']."/status".$data['ex']."?action=webhook";
	?>
	
	<input type="text" name="u" placeholder="Enter Url here"  style="padding:5px 20px;line-height:40px;width:99.5%;margin:0 0 20px 0;padding-left:5px;padding-right:5px;" value="<?=$u_val?>"  />
	
	<textarea name="e" class="form-control" required placeholder="Enter TransID as comman seprate"><?=@$_POST['e']?></textarea>
  
   
   
  <div class="sub">
   <input type="submit" name="transCheck" id="transCheck" value="Submit" class='btn small' />
    
  </div>
  <div style="clear:both;"></div>
  </form>
  <?php
  if ($msg!=''){echo "<b>Result:</b><br />".$msg; $msg=false;}
  ?>
</div>

</body>
</html>
<?php } ?>