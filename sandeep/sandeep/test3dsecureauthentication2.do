<?
$config_root='config_root.do';
if(file_exists($config_root)){include($config_root);}
//echo "<br/>Host1=>".$data['Host']; echo "<br/>urlpath1=>".$urlpath;

$redirect_url="";$redirect_url2="";

if(isset($_GET['success'])||isset($_GET['failed'])){
	
	if(isset($_GET['success'])&&($_GET['success']=='success')){
		header("Location:{$data['Host']}/success{$data['ex']}?transID={$_GET['transID']}");
	}elseif(isset($_GET['failed'])&&($_GET['failed']=='failed')){
		header("Location:{$data['Host']}/failed{$data['ex']}?transID={$_GET['transID']}");
	}
	
	echo "<hr/>_GET=>"; print_r($_GET);

}
if(isset($_POST['success'])||isset($_POST['failed'])){
	//echo "<hr/>_POST=>"; print_r($_GET);

}
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
    <title>Sample for 3d Secure Page</title>
    <link rel="stylesheet" type="text/css" href="theme/css/custom.css" charset="utf-8" />
	<script src="<?=$data['Host']?>/js/jquery-3.1.0.min.js"></script>
	
    <style type="text/css">
    body{padding-top:45px}
	
    </style>
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
		}
	}
	
var keyInput = $('.key_input');

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
	
	function limit(element, max, getId, nextId) {
		var thisValue = (element.value);
		
		var max_chars = max;
		if(thisValue.length > max_chars) {
			element.value = thisValue.substr(0, max_chars);
			//document.getElementById(nextId).focus();
		} 
		/*
		if(getId==='int6' && document.getElementById(getId).value.length>0){
			$('#int7').trigger("click");
			//document.getElementById('int7').focus();
			//document.forms["postform"].submit();
		}
		else if( (getId!='int6' ) && ( document.getElementById(nextId).value !='' )  && ( document.getElementById(getId).value.length > 0 ) ){
			conc();
			document.getElementById('int7').focus();
		}
		*/
		conc();
	}
	
	function keypressf(element, getId, nextId) {
		//limit(element, 1, getId, nextId);	
		limit(element,1,getId,nextId);
		if(getId=='int6'){
			//alert(document.getElementById(getId).value);
			//document.getElementById('int7').focus();
			$('#int7').trigger("click");
		}else if(document.getElementById(getId).value.length==0 && document.getElementById(getId).value!=' ' && document.getElementById(nextId).value==''){
			document.getElementById(nextId).focus();
			conc();
			return true;
		}
		
	}
	
var key_input_val='';
$(document).ready(function(){  
	
	$('#int6').on('keyup', function(e) {
		$('#int7').trigger("click");
	});
	
	
	
	$('.key_input').on('click focus', function(e) {
		key_input_val=$(this).val();
		$(this).val('');
	});
	$('.key_input').on('focusout', function() {
		if($(this).val()===''||$(this).val()==''){
			 $(this).val(key_input_val);
		}
	}); 
	
		
	$("#int7").click(function() {
	  conc();
	});
	
	/*
	$('.key_input').keyup(function(e){
		 if(e.keyCode == 8){
			 var cId = 0;
			 cId = parseInt(($(this).attr('id')).replace('int',''));
			 key_input_val='';
			 $(this).val();
			 var pId=(cId-1);
			 if(pId>0){
				document.getElementById('int'+(pId)).focus();
			 }
		 }
		else {
			var cId = 0; cId = parseInt(($(this).attr('id')).replace('int',''));
			var getId = 'int'+cId;
			var nextId = 'int'+(cId+1);
			keypressf(this, getId, nextId);
		}
	});  
	
	$('.key_input').on('keypress', function(e) {
		var cId = 0; cId = parseInt(($(this).attr('id')).replace('int',''));
		var getId = 'int'+cId;
		var nextId = 'int'+(cId+1);
		keypressf(this, getId, nextId);
	}); 
	
	*/
	
	
	var valLength = 6;
	
	$('.key_input').on('keyup keypress change', function(e){
		
		if($(this).hasClass('key_input')){
			if($(this).val().length === 1){
				if($(this).next().hasClass('key_input') && $(this).next().val().length == ''){
					$(this).next().focus();
				}
			}
			conc();
		}
		
		if($('#code_id').val().length === valLength || $('#code_id').val().length == valLength) {
			$('#int7').trigger("click");
		}
		
		
    });
	

});	
</script>

</head>
<body>
    <form id="form" method="get" onsubmit='return submitf();'>
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
		  <input type="tel" class="test_css key_input"  maxlength="1" id="int1" name="number1"  required="required" autofocus />
		  <input type="tel" class="test_css key_input"  maxlength="1" id="int2" name="number2" required="required" />
		  <input type="tel" class="test_css key_input"  maxlength="1" id="int3" name="number3" style="margin:5px 13px 10px 3px;" required="required" />
		  
		  <input type="tel" class="test_css key_input"  maxlength="1" id="int4" name="number3" style="margin:5px 3px 10px 13px;" required="required" />
		  <input type="tel" class="test_css key_input"  maxlength="1" id="int5" name="number5" required="required" />
		  <input type="tel" class="test_css key_input key_last"  maxlength="1" id="int6" name="number6"  required="required" />
			  
		  </div>

        <p style="text-align:center" />
        <button name='success' id="int7" value="success">Pay</button>
		<button name='failed' id="otp_failed" value="failed">Cancel</button>
        </p>
		<p id="log"></p>
    </form>
</body>
</html>



    