<?php
include('config.do');
###############################################################################
if((!$_SESSION['adm_login'])||($_SESSION['sub_admin_rolesname']=="Associate")||(isset($_SESSION['sub_admin_id']))){
        header("Location:{$data['Admins']}/logout{$data['ex']}");
        echo('ACCESS DENIED.');
        exit;
}
###############################################################################
if (file_exists('log/apilog'.$extn)){delete_file_linewise('apilog');}


$txtmsg=$msg=$found=false;
if ((!empty($_POST))&&(!isset($_POST['sendsearch']))||(!empty($_GET))){
	$txtmsg=true;
	$file='apilog';
	// Writing Log into readable format for us only
	if (!empty($_GET)){$logs=$_GET;}
	if (!empty($_POST)){$logs=$_POST;}
	$logs=json_encode($logs,true);
	if (strpos($_SERVER['HTTP_REFERER'],'m/index')){$file='apilog';}	
	wh_log($logs,$file);
}// End if post form
	
// Search form
if (isset($_POST['sendsearch'])){ $msg=Search_Logs();}
	
if (strpos($_SERVER['PHP_SELF'],'slog'.$data['ex'])){
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<style>
body {font-family:Arial, Helvetica, sans-serif}
.frm{width:98%; margin:0 auto; border:1px solid gray; height:auto;padding:10px;border-radius: 6px;}
.lab{width:15%; float:left;text-align:right;padding:10px;font-weight:bold;}
.txt{width:25%; float:left;text-align:left;padding:10px;}
.fld {width:90%; padding:10px;}
.sub{clear:both;width:90%; padding:10px; margin:0 auto; float:none; text-align:center;}
.btn{ background-color:#009; color:#FFF; padding:15px; margin:20px; width:25%; font-eight:bold; border:1px solid #000;cursor:pointer;font-size:20px;border-radius:6px;}
.msg{padding:15px;color:#00F;font-size:15px; text-align:center; height:30px; margin:0 auto;}
p {width: 99%;word-wrap: break-word;border-bottom: 1px solid #ede6e6;margin: 0 auto;padding: 10px;font-size: 13px;}
.small{width:auto !important; font-size:15px;margin:0 auto !important; padding:10px !important;float:leftheight:42px;}
.slt{float:left;width:200px;padding:10px;}
xmp{ white-space:pre-wrap; word-wrap:break-word; }
</style>
</head>

<body>

<div class="frm">
  <form name="mysfrm" id="mysfrm" method="post" action="">
  <div class="lab">Search text <span style="color:red;">*</span></div>
  <div class="txt">
  	<input type="text" name="txtsearch" id="txtfname" class="fld" value="<?php echo $_POST['txtsearch'];?>"  />
   </div>
   <div style="padding:10px;">
   <select name="filename" id="filename" required class="slt">
        <option value="apilog" <?php if($_POST['filename']=='apilog'){echo 'selected';}?>>API File</option>
        <option value="acquirerlog" <?php if($_POST['filename']=='acquirerlog'){echo 'selected';}?>>Acquirer Log</option>
        <option value="callbacklog" <?php if($_POST['filename']=='callbacklog'){echo 'selected';}?>>Call Back Log</option>
        <option value="echecklog" <?php if($_POST['filename']=='echecklog'){echo 'selected';}?>>e-Check Log</option>
        <option value="emaillog" <?php if($_POST['filename']=='emaillog'){echo 'selected';}?>>e-Mail Log</option>
        <option value="frmlog" <?php if($_POST['filename']=='frmlog'){echo 'selected';}?>>Form Log</option>
        <option value="profilelog" <?php if($_POST['filename']=='profilelog'){echo 'selected';}?>>Profile Log</option>
        
         <option value="storelog" <?php if($_POST['filename']=='storelog'){echo 'selected';}?>>Store Log</option>
    </select>
    
     </div>
  <div class="sub">
   <input type="submit" name="sendsearch" id="sendsearch" value="Search" class='btn small' />
     <a href="slog<?=$data['ex']?>"><input type="button" value="Reset" class='btn small' /></a>
  </div>
  <div style="clear:both;"></div>
  </form>
  <?php
  if ($msg!=''){echo "<b>Search Result:</b><br />".$msg; $msg=false;}
  ?>
</div>

<?php /*?>
<div class="frm">
<?php if ($txtmsg==true){?><div class="msg">Your Message is sent.</div><? }?>
  <form name="myfrm" id="myfrm" method="post" action="?post">
  <div class="lab">Full Name <span style="color:red;">*</span></div>
  <div class="txt">
  	<input type="text" name="txtfname" id="txtfname" class="fld" required="required" />
  </div>
  <div class="lab">Company Name <span style="color:red;">*</span></div>
  <div class="txt">
  	<input type="text" name="txtcname" id="txtcname" class="fld" required="required" />
  </div>
  <div class="lab">Designation <span style="color:red;">*</span></div>
  <div class="txt">
  	<input type="text" name="txtdesignation" id="txtdesignation" class="fld" required="required"  />
  </div>
  <div class="lab">Address <span style="color:red;">*</span></div>
  <div class="txt">
  	<input type="text" name="txtaddress" id="txtaddress" class="fld" required="required"  />
  </div>
  <div class="lab">e-Mail <span style="color:red;">*</span></div>
  <div class="txt">
  	<input type="text" name="txtemail" id="txtemail" class="fld"  required="required" />
  </div>
  <div class="lab">Phone Number <span style="color:red;">*</span></div>
  <div class="txt">
  	<input type="text" name="txtphone" id="txtphone" class="fld"  required="required" />
  </div>
  <div class="sub">
  <input type="submit" name="sendfrm" id="sendfrm" value="SUBMIT" class='btn' />
  <a href="slog<?=$data['ex']?>"><input type="button" value="Reset" class='btn' /></a>
  
  </div>
  </form>
</div><?php */?>
</body>
</html>
<?php } ?>