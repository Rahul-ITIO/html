<? if(isset($data['ScriptLoaded'])){ 
$_SESSION['SiteName']=@$_SESSION['domain_server']['as']['SiteName'];
$sess_secret=isset($_SESSION['secret'])&&$_SESSION['secret']?$_SESSION['secret']:'';
$sess_qrcodeurl=isset($_SESSION['qrCodeUrl'])&&$_SESSION['qrCodeUrl']?$_SESSION['qrCodeUrl']:'';
if(($post['google_auth_access']==2) || ($post['google_auth_access']==0)){ 
$qstatus="De-activate";
?>
<script>
$(document).ready(function () {
$(".loader-icon").html("<i class='<?=$data['fwicon']['check-cross'];?> text-danger'></i>");
 $(".toast-box").addClass("hide")
 $(".toast-box").hide();
});
</script>
<? }else{ $qstatus="Activated"; ?>
<script>
$(document).ready(function () {
 $(".toast-box").addClass("hide")
 $(".toast-box").hide();
  });
</script>
<? } ?>



<? if(!$data['PostSent']){ ?>
<style>
.mwidth2fa{max-width:500px;}
@media (max-width: 576px){
   .col-sm-4 {
    flex-shrink: 0;
    width: 100% !important;
    max-width: 100% !important;
	}
   .mwidth2fa{max-width:96% !important;}
}

	.modal-dialog {
     max-width: 360px !important;
     height:600px !important;
     }
	 
	 <? if($post['google_auth_access']==1){ ?>
	 .display_active { display:block;}
	 .display_deactive { display:none;}
	 
	 <? }else{ ?>
	 .display_active { display:none;}
	 .display_deactive { display:block;}
	 <? } ?>
	 .message_deactive { display:none;}
	 #message-error{ color:#CC0000; font-size:14px; }
	 .vkg.dropdown-toggle::after { position: absolute;top: 50%;right: 20px; }    
	 .vkg.dropdown-menu { min-width: 100% !important; }
     .toast:not(.showing):not(.show) { opacity: unset !important;}
    
</style>
<? if(isset($_SESSION['qrCodeActiveMessage'])&&$_SESSION['qrCodeActiveMessage']){
$qstatus="Activated"; //unset($_SESSION['qrCodeActiveMessage']); 
?>
<script>
$(document).ready(function () {
$(".loader-icon").html("<i class='<?=$data['fwicon']['check-circle'];?> text-success'></i>");
 $(".toast-box").addClass("show")
 $(".toast-box").show();
});
</script>
<? unset($_SESSION['qrCodeActiveMessage']); } ?>
<? if(isset($_SESSION['qrCodeMessage'])&&$_SESSION['qrCodeMessage']){ 

if($_SESSION['qrCodeMessage']==2){ 
$qstatus="De-activate";
?>
<script>
$(document).ready(function () {
$(".loader-icon").html("<i class='<?=$data['fwicon']['check-cross'];?> text-danger'></i>");
 $(".toast-box").addClass("show")
 $(".toast-box").show();
});
</script>
<? }elseif($_SESSION['qrCodeMessage']==1 || $_SESSION['qrCodeMessage']==3){ 
$qstatus="De-activate";
?>
<script>
$(document).ready(function () {
$(".loader-icon").html("<i class='<?=$data['fwicon']['check-cross'];?> text-danger'></i>");
$(".toast-box").addClass("hide")
$(".toast-box").hide();
$('#googleModalToggle').modal('show');
});
</script>
<? }else{ ?>
<script>
$(document).ready(function () {

 $(".toast-box").addClass("hide")
 $(".toast-box").hide();
  });
</script>
<? } ?>
<? } ?>
<div id="zink_id1" class="container mt-2 mb-2 border bg-primary text-white rounded">
  <div class="row mt-2 vkg" >
    <h4><i class="<?=$data['fwicon']['twofa'];?>" aria-hidden="true"></i> Two-step authentication</h4>
	<p>Requires two-step authentication in order to keep your account secure. By using either your phone or an authenticator app in addition to your password, you ensure that no one else can log in to your account.<br />

We encourage you to enable multiple forms of two-step authentication as a backup in case you lose your mobile device or lose service.</p>
<? if(isset($post['google_auth_code'])&&$post['google_auth_code']){ ?>
<div>If you lose your mobile device or security key, you can <a href="<?=$data['Host']?>/user/backup_code_two_step_authentication<?=$data['iex'];?>?key=<?=$post['google_auth_code'];?>" class="text-link" target="_blank" title="Download backup code" data-bs-toggle="tooltip" data-bs-placement="top">generate a backup code</a> to sign in to your account.</div>
<? } ?>
</br>
<!--=========== Working Area ============-->
</br>
<div class="border rounded p-2 my-2 dropdown mwidth2fa" style="max-width:500px; margin:0 auto;">

  <div class="vkg dropdown-toggle" style="width:calc(100% - 70px);" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false"><span class="loader-icon"><i class="<?=$data['fwicon']['check-circle'];?> text-success"></i></span>&nbsp;Authenticator app - <?=$qstatus;?> </div>

  <ul class="vkg dropdown-menu" aria-labelledby="dropdownMenuLink">
    <li><a class="dropdown-item two-fa-action" data-value="2">De-activate</a></li>
    <li><a class="dropdown-item two-fa-action" data-value="1">Activate</a></li>
    <li><a class="dropdown-item two-fa-action" data-value="3">QR-Code Reset</a></li>
  </ul>
</div>
<div class="clearfix"></div>
<div class="toast align-items-center text-white bg-primary-subtle border-0 w-100 mt-1 mb-4 toast-box" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true" style="max-width:500px; margin:0 auto;">
  <div class="d-flex">
    <div class="toast-body"><?=$qstatus;?></div>
    <button type="button" class="btn-close btn-close-white me-2 m-auto close_button text-dark" data-bs-dismiss="toast" aria-label="Close"></button>
  </div>
</div>


<div>&nbsp;</div>


</div>

</div>
  
<!--Added for 2FA Activation Modal-->

<div class="modal fade" id="googleModalToggle" aria-hidden="true" aria-labelledby="googleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="googleModalToggleLabel">Use an Authenticator app</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
	  
	  <span>
        <p>Download the free <a href="https://support.google.com/accounts/answer/1066447?hl=en" title="Move to Google Authenticator" target="_blank" class="fw-bold text-link">Google Authenticator</a> app, add a new account than scan this barcode to setup your account</p>
		<div class="text-center my-2"><img src="<?=$sess_qrcodeurl;?>" /></div>
		<div class="text-center my-2"><a title="Enter Code Manually" data-bs-target="#googleModalToggle2" data-bs-toggle="modal" data-bs-dismiss="modal" class="fw-bold text-link pointer">Enter Code Manually</a></div>
	   </span>
	   
	   
	   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button> <button class="btn btn-secondary" data-bs-target="#googleModalToggle3" data-bs-toggle="modal" data-bs-dismiss="modal">Continue</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="googleModalToggle2" aria-hidden="true" aria-labelledby="googleModalToggleLabel2" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="googleModalToggleLabel2">Use an Authenticator app</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>Download the free <a href="https://support.google.com/accounts/answer/1066447?hl=en" title="Move to Google Authenticator" target="_blank">Google Authenticator</a> app, add a new account than enter this code to setup your account</p>
		<div class="text-center my-2 fs-3"><?=$sess_secret;?></div>
		
		<div class="text-center my-2"><a href="#" title="Enter Code Manually" data-bs-target="#googleModalToggle" data-bs-toggle="modal" data-bs-dismiss="modal" class="fw-bold text-link">Scan barcode instead</a></div>
      </div>
    <div class="modal-footer">
         <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button> <button class="btn btn-secondary" data-bs-target="#googleModalToggle3" data-bs-toggle="modal" data-bs-dismiss="modal">Continue</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="googleModalToggle3" aria-hidden="true" aria-labelledby="googleModalToggleLabel3" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="googleModalToggleLabel3">Save your backup code</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>Save this emergency backup code and store it somewhere safe. if you loss your mobile device. you can use this code to bypass two-step-authentication and sign in </p>
		<div class="text-center">
		
		<input type="text" class="form-control form-control-sm w-75 px-2 float-start" value="<?=$sess_secret;?>" id="myInput"><i class="<?=$data['fwicon']['copy'];?> pointer w-25 float-start text-start p-2" title="Copy Backup Code" onclick="CopyValTestbox('Backup Code')"></i></div>
		<div class="clearfix"></div>
		<div class="my-2 text-start "><a href="<?=$data['Host']?>/user/backup_code_two_step_authentication<?=$data['iex'];?>?key=<?=$sess_secret;?>" target="_blank" title="Download backup code" class="btn btn-sm btn-primary showbutton"><i class="<?=$data['fwicon']['download'];?> "></i> Download</a></div>
      
    <div class="modal-footer">
          <button class="btn btn-primary hidebutton hide" data-bs-target="#googleModalToggle4" data-bs-toggle="modal" data-bs-dismiss="modal">I have saved my backup code</button>
      </div>
    </div>
  </div>
</div>
</div>

<div class="modal fade" id="googleModalToggle4" aria-hidden="true" aria-labelledby="googleModalToggleLabel4" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="googleModalToggleLabel4">Update an Authenticator app</h5>
        <button type="button" class="btn-close closebtn" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
	  <span class="message_active">
        <p>Please enter your 6-digit authentication code from the <a href="https://support.google.com/accounts/answer/1066447?hl=en" title="Move to Google Authenticator" target="_blank">Google Authenticator</a> app. </p>
		
<div class="text-center my-2">
<span id="message-error"></span>
<input type="number" maxlength="6" class="form-control form-control-sm text-center px-2" name="code" id="code" title="Enter your 6 Digit Authentication Code" required >
</div>
      
        <div class="modal-footer"><button class="btn btn-primary" title="back" data-bs-target="#googleModalToggle3" data-bs-toggle="modal" data-bs-dismiss="modal">Back</button>
          <button class="btn btn-secondary match-2fa" >Confirm update</button>
      </div>
	  </span>
	  <span class="message_deactive">
	  <p>From now on, whenever you sign in to your account, you'll need to enter both your password and also an authentication code generated by Google Authenticator. </p>
	  <div class="modal-footer"><button type="button" class="btn btn-secondary closebtn" data-bs-dismiss="modal">Done</button>
      </div>
          
      <!--</div>-->
	  </span>
    </div>
  </div>
</div>
</div>

<script>
	

  


// For Match 2fa
$('.match-2fa').on('click', function () {

       var code=$('#code').val();

        if(code==''){
			alert('Please enter 123456');
			return false;
		}else if($.trim(code).length != 6){
		    alert('Please enter 6 digit number');
			return false;
		}else if(!$.isNumeric(code)){
		    alert('Please enter Numeric Value');
			return false;
		}
		
		

	$.ajax({
	url: "<?=$data['Host'];?>/include/two-step-authentication<?=$data['ex']?>",
	data:'secret=<?=$sess_secret;?>&code='+$("#code").val(),
	type: "POST",
	success:function(data){
	//alert(data);
	  if(data=="done"){
	  $(".message_active").hide();
	  $(".message_deactive").show();
	  }else{
	    if(data==""){ var data="Enter your 6 Digit Authentication Code";}
	  $("#message-error").html(data);
	  }
	},
	error:function (){}
	});
	
});


$('.two-fa-action').on('click', function () {
var datavals=$(this).attr('data-value');
//alert(datavals);
$(".loader-icon").html("<i class='<?=$data['fwicon']['spinner'];?> fa-spin-pulse'></i>");

 $.ajax({
	url: "<?=$data['Host'];?>/include/two-step-authentication<?=$data['ex']?>",
	data:'vid=<?=$post['id'];?>&google_auth_access='+datavals,
	type: "POST",
	success:function(data){
	//alert(data);
	  if(data=="done"){
	  location.reload(true);
	  }
	},
	error:function (){}
	});

});


$('.close_button').on('click', function () {
$(".toast-box").hide();
});


$('.closebtn').on('click', function () {
location.reload(true);
});

$('.showbutton').on('click', function () {
$(".hidebutton").show();
});
///////////////////////////////


	// js for copy data
	function CopyValTestbox(theLabel) {
   
	var range = document.createRange();
	range.selectNode(document.getElementById("myInput"));
	window.getSelection().removeAllRanges(); // clear current selection
	window.getSelection().addRange(range); // to select text
	
	
	        if (document.execCommand('copy')) {
                window.getSelection().removeAllRanges();// to deselect
				alert("Copied : " + theLabel);
            }
	}
		
	

</script>

<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
