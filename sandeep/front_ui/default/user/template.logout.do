<? $domain_server=$_SESSION['domain_server']; ?>
<? if(isset($data['ScriptLoaded'])){  
//print_r($domain_server);
$signin_time=@$domain_server['clients']['last_login_date'];
$signout_time=date("Y-m-d H:i:s");

if(isset($signin_time)&&$signin_time){ 
	setcookie("signin_time", $signin_time, time() + (86400 * 900), "/"); // 86400*30 = 1 day
	setcookie("signout_time", date("Y-m-d H:i:s"), time() + (86400 * 900), "/"); // 86400*30 = 1 day
}else{
	$signin_time=@$_COOKIE["signin_time"];
	$signout_time=@$_COOKIE["signout_time"];
}


$signin_time=date("d M Y, H:i a",strtotime($signin_time));
$signout_time=date("d M Y, H:i a",strtotime($signout_time));


?>
<style> 
.row {--bs-gutter-x: 1.5rem;} 
.col-form-label { font-weight: normal !important;} 
 
</style>

<div class="container-sm my-2" style="max-width:500px; margin:0 auto;">
  <div class="row-fluid mt-5">
    <? if(($data['hdr_logo'])&&($domain_server['LOGO'])){ ?>
	<div class="text-start mb-2">
    <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:50px;"></a>
	</div>
    <? } ?>
    <div class="rounded-tringle rounded bg-primary text-white vkg p-2" >
	<div class="both-side-margin">
	<? if(isset($_REQUEST['p'])&& $_REQUEST['p']){ ?>
	
     <div class="my-2 fs-5 hide-title">Password Update Successfully</div>
	  
	 <div class="row"> 
	 <i class="<?=$data['fwicon']['check-circle'];?> text-success  mt-1 fa-2x col-sm-2"></i>
     <p class="fw-light fs-6 fw-normal col-sm-10">You have been safely update your Password</p>
     </div>
	 
	 
								   
	<? } else { ?>
	
	 <div class="my-2 fs-5 hide-title"><?=$data['PageName']?></div>
	  
	 <div class="row"> 
	 <i class="<?=$data['fwicon']['bye-bye'];?> fa-shake mt-1 fa-3x col-sm-2"></i>
     <p class="fw-light fs-5 fw-normal col-sm-10">You have signed out properly.<br /> Goodbye, Hope to see you soon! </p>
     </div>
	 
	 <p>           Last Sign In : <?=$signin_time;?> <br />
                                   Last Sign Out : <?=$signout_time;?> </p>
	
	<? } ?>

        <div class="col text-center my-2 text-primary hide-title"><a href="<?=$data['Host'];?>/login<?=$data['ex']?>" class="
		btn btn-primary" >Sign in again</a> </div>
	</div>
  </div>
    
	</div></div>
	
<? 

unset($_SESSION);
unset($_SESSION['login']);
unset($_SESSION['uid']);
unset($_SESSION['merchant']);
session_destroy();

}else{ ?>
SECURITY ALERT: Access Denied
<? } ?>



