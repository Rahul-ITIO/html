<?php
if(!isset($_SESSION)) {session_start();}
if (!isset($_SESSION['uid']) && !isset($_SESSION['adm_login'])) {       
    echo('ACCESS DENIED.'); exit;
}

//$_POST['code_mfa']=$_GET['code_mfa']; $_POST['loginPassword']=$_GET['loginPassword'];
//echo "<hr/><br/>=>device_confirmations.do";

$uid=$_SESSION['uid'];
//$url=$_SESSION['redirectUrl'];
$_SESSION['googleCode_err']=NULL;
$result_mfa=[];
if(isset($_POST['code_mfa'])||isset($_POST['loginPassword'])){
	include('../config.do');
	
	if(isset($_POST['loginPassword'])){
		if(!$_POST['loginPassword']){
			$result_mfa['Error']='Please enter valid for login password';
			json_print($result_mfa);exit;
		}elseif(!passwordCheck($uid,$_POST['loginPassword'])){
			$result_mfa['Error']='You entered wrong password.';
			json_print($result_mfa);exit;
		} 
	}
	
	if(isset($_POST['code_mfa'])&&$_POST['code_mfa']){ 
		$code_mfa=$_POST['code_mfa'];
		$result_mfa['code_mfa']=$code_mfa;
		$secret=$_SESSION['google_auth_code'];
		require_once '../googleLib/GoogleAuthenticator.do';
		$ga = new GoogleAuthenticator();
		$checkResult = $ga->verifyCode($secret, $code_mfa, 8);    // 2 = 2*30sec clock tolerance
		
		if ($checkResult) {
			$result_mfa['success']=1;
			/*
			$_SESSION['login']=true;
			$_SESSION['merchant']=true;
			$username=$_SESSION['m_username'];
			set_last_access($username);
			save_remote_ip((int)$uid, $_SERVER["REMOTE_ADDR"]);
			user_un_block_time($uid);
			unset ($_SESSION['showcode']);
			if($data['UseTuringNumber'])unset($_SESSION['turing']);			
			if(isset($_SESSION['redirect_url'])&&isset($_SERVER['HTTP_REFERER'])){
			 redirect_post($_SESSION['redirect_url'], $_SESSION['send_data']);
			}else{
				header("Location:$url");
			}
			echo('ACCESS DENIED.');
			exit;
			*/
		}else {
			$result_mfa['Error']="Wrong Code. Try again.";
			/*
			$_SESSION['googleCode_err']="Wrong Code. Try again.";
			$url=$url.'/device_confirmations'.$data['ex'];
			header("Location:$url");
			exit;
			*/
		}
		json_print($result_mfa);exit;
	}
	
}

if(isset($data['user_pass_gmfa'])&&$data['user_pass_gmfa']){
	$autofocus='autofocus';
}else{
	$autofocus='';
}

?>
<style>
.error{margin: 0 auto !important;
text-align:center; color:#fff;background-color:red;padding:5px;}

.step2{margin-top:50px;border-top:1px solid;border-bottom:1px solid;width:100%;padding-top: 10px;
padding-bottom: 10px;}


.deviceDiv{font-family: 'Raleway', sans-serif;}

.label_11{float:left;font-weight:bold;width:100%;margin:10px 0 6px 0;color:#8597f6}
.button_sub{padding:10px;background-color:#001cb7;border:2px solid #0e2cd4;border-radius:6px;width:160px;font-size:22px;color:#fff;height:50px;margin:7px 0 0 0;text-transform:uppercase}
.button_sub:focus{background-color:#4CAF50;border:2px solid #61e066;border-radius:6px}
.button_sub:active{}

.key_input1{width:14px;outline:none;padding:5px 16px;font-size:25px;letter-spacing:33px;font-weight:bold;border-radius:5px;border:2px solid #9d9d9d;display:inline-block}

html .key_input{width:40px!important;height:44px!important;min-width:40px;line-height:44px;outline:none!important;text-align:center;font-size:24px;letter-spacing:normal;font-weight:700;border-radius:5px!important;border:2px solid #9d9d9d;display:inline-block;float:left!important;position:relative;z-index:9999;margin:5px 3px 10px!important;padding:0px !important;}


.submit_mfa_div{padding:0px 0px;height:auto;text-align:center;width:100%;float:left}
html .submit_mfa_next{margin:0!important;float:none!important;padding:11px 0;font-size:24px;height:40px!important;width:240px!important;border:0 !important;}
	
.modal_mfa_msg{display:block;position:fixed;z-index:999999;top:0;left:0}

.modal_mfa_msg_layer{display:block;position:fixed;z-index:999999;width:100%;height:100%;background:#000;opacity:.5;top:0;left:0}

.modal_mfa_msg_body{display:block;position:fixed;z-index:9999999;width:315px;margin:-165px 0 0 -130px;opacity:1;border-radius:5px;left:50%;top:50%;}







</style>
   
<div class="deviceDiv">

  <?php
    if ((isset($_SESSION['googleCode_err']))&&($_SESSION['googleCode_err']!=NULL)){
		?>
  <div class="error">
    <?php
        echo $_SESSION['googleCode_err'];
		?>
  </div>
  <?
		$_SESSION['googleCode_err']=NULL;
	}
	?>
 
  <div id='device' class='device'>
    <?php
		if(!isset($_SESSION['hideAuthenticatorCode'])){
		  ?>
		  
<div class="modal_mfa_msg" id="modal_mfa" <? if(isset($data['FUND_STEP'])&&$data['FUND_STEP']){ ?> style="display:block;" <? } ?> >
<div class="modal_mfa_msg_layer"> </div>
<div class="modal_mfa_msg_body bg-body-secondary py-2"> 
<a class="float-end pointer px-2 fw-bold" onclick="document.getElementById('modal_mfa').style.display='none';"> X </a>
  <div id="modal_mfa_msg_body_div">
	<div class="m-2">
	<h4 class="fs-5">Security Verification </h4>
	<p>	<? if($data['withdraw_gmfa']){ ?>
			<div id="modal_with_div1" style="display:none"> </div>
			<div class="mfa_payoutAmt"> </div>
			<div class="mfa_totalAmt"> </div>
			
			<div class="mfa_selectedBank"> </div>
		<? } ?>
		<? if(isset($data['user_pass_gmfa'])&&$data['user_pass_gmfa']){?>
		<input type="password" class="test_css form-control"  maxlength="150" name="password" id="loginPassword"  placeHolder="Enter your login Password" <?=$autofocus;?>  autocomplete="off" />
		<?}?>
		<div class="text-info fw-bold my-2">Enter Google Authenticator Code</div>
			
			
		
        <input type="text" name="code_mfa" id="code_id" style="display:none;" />
        <div class="input_key_div">
          <input type="tel" class="test_css key_input number1 form-control"  maxlength="1" name="number1"  required1="required" style="margin-left:0;" <?=$autofocus;?> />
          <input type="tel" class="test_css key_input number2 form-control"  maxlength="1" name="number2" required1="required" />
          <input type="tel" class="test_css key_input number3 form-control"  maxlength="1" name="number3" style="margin:5px 14px 10px 3px!important" required1="required" />
          <input type="tel" class="test_css key_input number4 form-control"  maxlength="1" name="number4" style="margin:5px 3px 10px 14px!important;" required1="required" />
          <input type="tel" class="test_css key_input number5 form-control"  maxlength="1" name="number5" required1="required" />
          <input type="tel" class="test_css key_input number6 form-control"  maxlength="1" name="number6"  required1="required" style="margin-right:0;" />
        </div>
        
	</p>
	<a class="mdf_clear btn btn-primary btn-sm" style="float:right;">Clear</a>
	<span class="submit_mfa_div" style="display:none;">
		<button id="mfa_submit" type="button" name="submit" value="submit" class="nopopup btn btn-icon btn-primary submit_mfa_next" autocomplete="off"><b class="contitxt">SUBMIT</b></button>
	</span> 
	</div>
   </div>
   <?php /*?><div class="text-center"><a class="btn btn-primary" onclick="document.getElementById('modal_mfa').style.display='none';">Close</a></div><?php */?>
   
   
  </div>
</div>

    
    <?php
		  }
		  ?>
  </div>
  


<script>
var wn1='';
var mfaSubmit="true";
function codeMfa(){
	var url_name="<?=$data['Host']?>/include/device_confirmations<?=$data['ex'];?>?action=mfa";
		if(wn1){
			//window.open(url_name,'_blank'); alert(url_name);
		}
		//alert(url_name+"\r\n code_id: "+$('#code_id').val());
		
		
		$.ajax({
			url: url_name,
			type: "POST",
			dataType: 'json', 
			<? if($data['user_pass_gmfa']){ ?>
				data:{action:"mfa", code_mfa:$('#code_id').val(), loginPassword:$('#loginPassword').val(), json:"1"},
			<? }else{ ?>
				data:{action:"mfa", code_mfa:$('#code_id').val(), json:"1"},
			<? } ?>
			success: function(data){
				
				//alert(JSON.stringify(data));
				
				if(!data["success"]){
					alert("Opps : "+data['Error']);
				}else{
					if(mfaSubmit=="true"){
						mfaSubmit="false";
						$('#backFormReq').html('');
						$('#backFormReq').remove();
						setTimeout(function(){
							$('#modal_msg').hide(200);
							$('#modal_mfa').hide(200);
							$('#modalpopup_form_popup').show(200);
							$("#b_submit").attr("name","send");
							<? if($data['type_submit']){ ?>
								$("#b_submit").attr("type","submit");
							<? } ?>
							$('#b_submit').addClass('active');
							$('#b_submit').trigger("click");
							
							
						}, 10);
					}
				}
				
			} 
		});
} 
<? if($data['user_pass_gmfa']){ ?>
	$('#loginPassword').on('focusout', function() {
		//codeMfa();
	}); 
<? } ?>

function conc(){
  var str = "";
  $('.key_input').each(function(){
	str += $(this).val();
  });
  str = str.replace(/\s/g, '');
  $("#code_id").val(str);
}

	
	
var key_input_val='';


$('.key_input').on('click focus', function(e) {
	key_input_val=$(this).val();
	$(this).val('');
});
$('.key_input').on('focusout', function() {
	if($(this).val()===''||$(this).val()==''){
		 $(this).val(key_input_val);
	}
}); 

	
$("#mfa_submit").click(function(){
  conc(); 
 // codeMfa();
});


var valLength = 6;

$('.key_input').on('keyup keypress', function(e){
	
	if($(this).hasClass('key_input')){ 
		if(e.keyCode == 8){
			key_input_val='';
			$(this).val('');
			$(this).prev().focus();
		}else{
			if($(this).val().length === 1){
					if($(this).next().hasClass('key_input') && $(this).next().val().length == ''){
						$(this).next().focus();
					
				}
			}
		}
		conc();
	}
	
	if($('#code_id').val().length === valLength ) {
		//console.log("code: "+$('#code_id').val());
		 codeMfa();
		//$('#mfa_submit').focus(); 
		//$('#mfa_submit').trigger("click");
	}
	
});

	
$('.key_input').on('paste', function (e) {
	e.preventDefault();
	var text;
	var clp = (e.originalEvent || e).clipboardData;
	if (clp === undefined || clp === null) {
		text = window.clipboardData.getData("text") || "";
		if (text !== "") {
			text = text.replace(/<[^>]*>/g, "");
			///alert("2=>"+text);
			if (window.getSelection) {
				var newNode = document.createElement("span");
				newNode.innerHTML = text;
				window.getSelection().getRangeAt(0).insertNode(newNode);
			} else {
				document.selection.createRange().pasteHTML(text);
			}
			///alert("3=>"+text);
		}
	} else {
		text = clp.getData('text/plain') || "";
		if (text !== "") {
			text = text.replace(/<[^>]*>/g, "");
			//alert("4=>"+text);
			document.execCommand('insertText', false, text);
		}
	}
	//alert("5=>"+text+'\r\n1=>'+text[0]);
	text=text.replace(/ /g,"");
	if(text.length==6){
		$('.number1').val(text[0]);
		$('.number2').val(text[1]);
		$('.number3').val(text[2]);
		$('.number4').val(text[3]);
		$('.number5').val(text[4]);
		$('.number6').val(text[5]);
	}
});

$('.mdf_clear').on('click', function() {
	$('.key_input').val('');
}); 
</script>


</div>