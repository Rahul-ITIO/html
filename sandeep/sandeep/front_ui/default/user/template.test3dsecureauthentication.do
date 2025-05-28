<? if(isset($data['ScriptLoaded'])){ ?>
<?
$template_header=($data['FrontUI']."/".$data['frontUiName']."/user/template.header".$data['iex']);
if(!file_exists($template_header)){
?>
<style>
body{color:#72869d!important;background-color:#e2e2e2;border-color:#e2e2e2}
</style>
<? } ?>

<style>
.proccess_timer{font-size:14px;color:#5c5c5c;text-align:center;float:left;width:100%;margin:3px 0}

.proccess_timer_border{display:block;float:unset;width:110px;height:2px;text-align:center;clear:both;position:relative;margin:0 auto 10px;background:#020024;background:linear-gradient(90deg,rgba(2,0,36,1) 0%,rgba(218,0,203,1) 0%,rgba(204,204,204,1) 0%,rgba(255,255,255,1) 0%,rgba(255,255,255,1) 25%,rgba(197,196,198,1) 50%,rgba(255,255,255,1) 75%,rgba(255,255,255,1) 100%)}


.container-fluid.fixed {background: transparent;}
.containerMain{position:relative;display:flex;flex-direction:column;min-width:0;word-wrap:break-word;background-color:#fff;background-clip:border-box;border:1px solid rgba(0,0,0,0.1);width:320px;margin:5% auto 0;border-radius:20px;padding:0 50px 50px;float:unset}


	
h4{margin:0;padding:0;text-align:center;font-size:18px;color:#4c4c4c}
.info-text{text-align:center;font-size:14px}
span{color:#435fbd;text-decoration:underline;text-decoration-color:black;font-size:12px}
#int_7{width:100%;outline:none;padding:5px 26px;font-size:25px;letter-spacing:33px;font-weight:bold}
button{padding:10px;background-color:#001cb7;border:2px solid #0e2cd4;border-radius:6px;width:100px;font-size:18px;color:#fff}
button:focus{background-color:#4CAF50;border:2px solid #61e066;border-radius:6px}
button:active{}
	
	

.button_sub{padding:10px;background-color:#001cb7;border:2px solid #0e2cd4;border-radius:6px;width:160px;font-size:22px;color:#fff;height:50px;margin:7px 0 0 0;text-transform:uppercase}
.button_sub:focus{background-color:#4CAF50;border:2px solid #61e066;border-radius:6px}
.button_sub:active{}
.input_key_div{display:block;width:100%;clear:both;padding:7px 0}

html .key_input{width:40px!important;height:40px;min-width:40px;line-height:44px;outline:none!important;padding:0;text-align:center;font-size:24px;letter-spacing:normal;font-weight:700;border-radius:5px!important;border:2px solid #9d9d9d;display:inline-block;float:left;position:relative;z-index:9999;margin:5px 3px 10px}

p{font-size:12px;margin:0 0 5px;line-height:normal;float:left;width:100%}

.input_key_div{display:block;width:324px;clear:both;padding:7px 0;margin:0 auto;}

@media(max-width:999px){
	html .containerMain{width:calc(100% - 50px);margin:5% auto 0!important;padding:20px;display:flex;float:unset;left:0;min-height:470px;text-align:center}
}
@media(max-width:450px){
	.input_key_div {width: 264px;}
	html .key_input {width:30px!important;height:40px;min-width:30px;line-height:44px;}
}
</style>

<div class="container processing bg-white border border-success my-2 rounded" style="max-width:400px; margin:0 auto;">
<div class="col-sm-12 text-center my-2" >	
	<form id="form" method="get" onsubmit='return submitf();'>
	<img src="<?=$data['Host'];?>/images/3d_otp_icon.jpg"  class="img-thumbnail" />
	<div class="proccess_timer_border" >&nbsp;</div>
		
        <input type="hidden" name="transID" value="<?=(isset($_REQUEST['transID'])?$_REQUEST['transID']:"");?>" />
		<h4>This is a sample 3d Secure Page.</h4>
        <p class="info-text">
			 <br/>
			You are require to enter OTP which is <b>123456</b> to test 3D secure authentication process.<br/><br/> 
             No real OTP was sent to your mobile device. 
        </p>
        <p>
        
		<input type="tel" class="test_css"  maxlength="6"  id="code_id" name="number" style="display:none;"  />

        </p>
		
		 <div class="input_key_div">
		  <input type="tel" class="test_css key_input"  maxlength="1" required="required" autofocus />
		  <input type="tel" class="test_css key_input"  maxlength="1" required="required" />
		  <input type="tel" class="test_css key_input"  maxlength="1" style="margin:5px 13px 10px 3px;" required="required" />
		  
		  <input type="tel" class="test_css key_input"  maxlength="1" style="margin:5px 3px 10px 13px;" required="required" />
		  <input type="tel" class="test_css key_input"  maxlength="1" required="required" />
		  <input type="tel" class="test_css key_input key_last"  maxlength="1" required="required" />
			  
		  </div>

        <div class="col-sm-12 my-2" >
			<button name='success' id="int7" value="success">Pay</button>
			<button name='failed' id="otp_failed" value="failed">Cancel</button>
        </div>
		
		<p id="log"></p>
    </form>
	
	<script>
	function submitf() {
		if(document.getElementById('code_id').value==''){
			alert('Please enter 123456');
			document.getElementById('code_id').focus();
			return false;
		}else if(document.getElementById('code_id').value!='123456'){
			alert('Please enter 123456');
			document.getElementById('code_id').focus();
			return false;
		}else{
			
			if (window.opener && window.opener.document) { opener.pendingCheckStartf();}
		}
	}
	
	
	function conc(){
	  var str = "";
	  $('.key_input').each(function(){
		str += $(this).val();
	  });
	  str = str.replace(/\s/g, '');
	  $("#code_id").val(str);
	}

	function stringHasTheWhiteSpaceOrNot(value){
	   return value.indexOf(' ') >= 0;
	}
	
		
	var key_input_val='';
	$(document).ready(function(){  
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
			
			if($('#code_id').val().length === valLength && $('#code_id').val()!='123456' ) {
				alert('Please enter 123456');
				document.getElementById('code_id').focus();
				return false; 
			}else if($('#code_id').val().length === valLength && $('#code_id').val()=='123456' ) {
				 conc();
				 $('#int7').trigger("click");
				//$('#mfa_submit').focus(); 
				//$('#mfa_submit').trigger("click");
			}
			
		});

	});	
	</script>


</div>
</div>

<?
	//exit;
}
?>



