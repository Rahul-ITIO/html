<? if(isset($data['ScriptLoaded'])){
$mtype=$data['mtype'];
$store_url=($data['MYWEBSITEURL']?$data['MYWEBSITEURL']:'store');
$store_id_nm=$store_url;
$store_name=($data['MYWEBSITE']?$data['MYWEBSITE']:'Store');
if(!isset($ep)) $ep='';
?>
<? ((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>
<? if(isset($_GET['action_success'])&&$_GET['action_success']=2){ $_SESSION['action_success']="Email Deleted";}  ?>    
<script>
function getXMLHttp(){
  var xmlHttp
  try{
    //Firefox, Opera 8.0+, Safari
    xmlHttp = new XMLHttpRequest();
  }
  catch(e){
    //Internet Explorer
    try{
		xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch(e){
      try{
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      catch(e){
        alert("Your browser does not support AJAX!")
        return false;
      }
    }
  }
  return xmlHttp;
}

function MakeRequest(){
  var swcode=document.getElementById('bswift').value;
  if(swcode==''){
  	alert ("Swift Code is empty");
	return false;
	exit;
  }
  
 document.getElementById('swiftmsg').innerHTML="";
 document.getElementById('baddress').value='';
 document.getElementById('bname').value='';
 
 document.getElementById('bcity').value='';
 document.getElementById('bzip').value='';
 document.getElementById('bcountry').value='';
 document.getElementById('swiftmsgbutton').style.display="none";
 document.getElementById('swiftmsgbuttonright').style.display="none";
 document.getElementById('swiftmsgloader').style.display="block";
  
  var xmlHttp = getXMLHttp();
  
  xmlHttp.onreadystatechange = function(){
    if(xmlHttp.readyState == 4){
      HandleResponse(xmlHttp.responseText);
    }
  }

  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?txt="+swcode, true); 
  //xmlHttp.open("GET", "/ztswallet/include/ajax<?=$data['ex']?>?txt="+swcode, true); 
  xmlHttp.send(null);
}

function HandleResponse(response)
{
	//To show the as it is
	//document.getElementById('swiftmsg').style.display="block";	
	//document.getElementById('swiftmsg').innerHTML =	response;
	
	var obj = JSON.parse(response);
	
	if (obj.valid=="true")
	{	
	//assign values to inboxes
	document.getElementById('bname').value = obj.bank;
	
	var badd='';
	
	if (obj.branch!=null){badd=obj.branch;}
	
	if (obj.address!=null){	
		if (badd!=""){badd=badd+", "+obj.address;}else{badd=badd+obj.address;}
	}
	if (obj.city!=null){
		if (badd!=""){badd=badd+", "+obj.city;}else{badd=badd+obj.city;}
	}
	if (obj.postcode!=null){
		if (badd!=""){badd=badd+", "+obj.postcode;}else{badd=badd+obj.postcode;}
	}
	if (obj.country!=null){
		if (badd!=""){badd=badd+", "+obj.country;}else{badd=badd+obj.country;}
	}
	
	badd = badd.replace(", , , ", ", ");
	badd = badd.replace(", , ", ", ");
	 
	document.getElementById('baddress').value =badd;	
	
	document.getElementById('bcity').value = obj.city;
	document.getElementById('bzip').value = obj.postcode;
	document.getElementById('bcountry').value = obj.countrycode;
	document.getElementById('swiftmsgbuttonright').style.display="block";
	document.getElementById('swiftmsgloader').style.display="none";
	}
	else 
	{
  	
	document.getElementById('swiftmsg').style.display="block";	
	document.getElementById('swiftmsgbutton').style.display="block";
	document.getElementById('swiftmsgloader').style.display="none";
	document.getElementById('swiftmsg').innerHTML = obj.message+" - Error Code="+obj.error;
	}

}//end function


function CloseDiv(){
	document.getElementById('swiftmsg').style.display="none";
	document.getElementById('swiftmsgbutton').style.display="none";
	document.getElementById('swiftmsgbuttonright').style.display="none";
}

<!--Intermediate Request -->
function IntMdtMakeRequest(){
  var swcode=document.getElementById('intermediary').value;
  if (swcode==''){
  	alert ("Swift Code is empty");
	return false;
	exit;
  }
  
 document.getElementById('IntMdtswiftmsg').innerHTML="";
 document.getElementById('intermediary_bank_address').value='';
 document.getElementById('intermediary_bank_name').value='';
 
 
 document.getElementById('IntMdtswiftmsgbutton').style.display="none";
 document.getElementById('IntMdtswiftmsgbuttonright').style.display="none";
 document.getElementById('IntMdtswiftmsgloader').style.display="block";
  
  var xmlHttp = getXMLHttp();
  
  xmlHttp.onreadystatechange = function(){
    if(xmlHttp.readyState == 4){
      IntMdtHandleResponse(xmlHttp.responseText);
    }
  }

  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?txt="+swcode, true); 
  //xmlHttp.open("GET", "/ztswallet/include/ajax<?=$data['ex']?>?txt="+swcode, true); 
  xmlHttp.send(null);
}

function IntMdtHandleResponse(response){

	var obj = JSON.parse(response);
	
	if (obj.valid=="true")
	{	
	//assign values to inboxes
	var badd='';
	
	if (obj.branch!=null){badd=obj.branch;}
	
	if (obj.address!=null){	
		if (badd!=""){badd=badd+", "+obj.address;}else{badd=badd+obj.address;}
	}
	if (obj.city!=null){
		if (badd!=""){badd=badd+", "+obj.city;}else{badd=badd+obj.city;}
	}
	if (obj.postcode!=null){
		if (badd!=""){badd=badd+", "+obj.postcode;}else{badd=badd+obj.postcode;}
	}
	if (obj.country!=null){
		if (badd!=""){badd=badd+", "+obj.country;}else{badd=badd+obj.country;}
	}
	
	badd = badd.replace(", , , ", ", ");
	badd = badd.replace(", , ", ", ");
	
	document.getElementById('IntMdtswiftmsgloader').style.display="none";
  //assign values to inboxes
  document.getElementById('intermediary_bank_name').value = obj.bank;
  document.getElementById('intermediary_bank_address').value =badd;
  document.getElementById('IntMdtswiftmsgbuttonright').style.display="block";
  }else{
  	
	document.getElementById('IntMdtswiftmsg').style.display="block";	
	document.getElementById('IntMdtswiftmsgbutton').style.display="block";
	document.getElementById('IntMdtswiftmsgloader').style.display="none";
	document.getElementById('IntMdtswiftmsg').innerHTML = response;
  }

}




function IntMdtCloseDiv(){
	document.getElementById('IntMdtswiftmsg').style.display="none";
	document.getElementById('IntMdtswiftmsgbutton').style.display="none";
	document.getElementById('IntMdtswiftmsgbuttonright').style.display="none";
}
<!-- End Intermediate request -->
function AuthenticationReset(mid){

	var xmlHttp = getXMLHttp();  
	xmlHttp.onreadystatechange = function(){
	  if(xmlHttp.readyState == 4){
	  HandleResponsecodereset(xmlHttp.responseText);
	  }
	}

  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?mid="+mid+"&action=reset", true); 
  xmlHttp.send(null);
}
function HandleResponsecodereset(response){
	document.getElementById('codereset').innerHTML = response;
	document.getElementById('codereset').style.display="block";
}
function Closereset(){
document.getElementById('codereset').style.display="none";
}
</script>
<script>
var wn='';
var box, oldValue='';

function dialog_box2_close() {
	popupclose();
	$('#dialog_box2').hide();
	
	
}

function templatesf2(e,theValue) {

	box=$(e).attr('id');
	oldValue=theValue;
}
function templatesf(theValue,theId,theMid,theSponsor) {
 //alert(theValue+'\r\n'+theId+'\r\n'+theMid);
  
  var thisurls="<?=$data['Admins']?>/merchant<?=$data['ex']?>";
			thisurls=thisurls+"?action=templates_add&gid="+theId+"&mid="+theMid+"&tid="+theValue+"&spo="+theSponsor;
	 // alert(thisurls);
	if(wn){
		window.open(thisurls,'_blank');
		return false;
	}
	
	//alert(oldValue+"\r\n"+theValue+"\r\n"+box);
	
	
	var txt;
	var r = confirm("Are you sure add templates !");
	
	if(r==true) {
	  txt = "You pressed OK!";
	  alert(txt);
			popuploadig();	
			$('.modal_popup_form_popup_body').hide();
			
			$('#dialog_box2').show(1000);
			
			$('#baseRate_submit').click(function() {

				var baseRate_transaction_rate = $('#baseRate_transaction_rate').val();
				var baseRate_txn_fee = $('#baseRate_txn_fee').val();
				var transaction_processing_mode = $('#transaction_processing_mode').val();
				
				
				thisurls=thisurls+"&baseRate_transaction_rate="+baseRate_transaction_rate+"&baseRate_txn_fee="+baseRate_txn_fee+"&transaction_processing_mode="+transaction_processing_mode;
				
				$.ajax({  
					url:thisurls,  
					type: "POST",
					dataType: 'json', // text
					data:{gid:theId, mid:theMid, tid:theValue, spo:theSponsor, baseRate_transaction_rate:baseRate_transaction_rate, baseRate_txn_fee:baseRate_txn_fee, transaction_processing_mode:transaction_processing_mode, action:"templates_add"},
					 success:function(data){  
					 
					  if(data['Error']&&data['Error'] != ''){  
						   alert(data['Error']);
					  }else{
						  //popupclose();
						  dialog_box2_close();
						  //myObj = JSON.parse(this.responseText);
						  alert(JSON.stringify(data));
						  //alert(data);
					  }
					}
				});
			
			});
		
			
	}else{
	  txt = "You pressed Cancel!";
	  
	  $('#'+box+' option[value="'+oldValue+'"]').prop('selected','selected');
   }
   
}
function textAreaAdjust(o) {
	/*
  o.style.height = "1px";
  o.style.height = (10+o.scrollHeight)+"px";
  */
}
function textAreaAdjust1() {
	setTimeout(function(){ 
		$('textarea').on('keyup keypress', function() {
			$(this).height(0);
			$(this).height(this.scrollHeight);
		});
		$('textarea').trigger("keyup");
		
	}, 1500);		
 
}
function textAreaAdjust2(e) {
	var $textAreaAdjust=$(e).next().find('.textAreaAdjust');
	
	$textAreaAdjust.height(0);$textAreaAdjust.height(this.scrollHeight);$textAreaAdjust.trigger("keyup");
}

function callsaltvalue(sltId){
	
		var thisurls="<?=$data['Admins']?>/merchant<?=$data['ex']?>";
		thisurls=thisurls+"?action=get_salt_list&sltid="+sltId;
	//alert(thisurls);		
	$.ajax({  
		 url:thisurls,  
		 type: "POST",
	
		 dataType: 'text', // text
		 data:{sltid:sltId, action:"get_salt_list"},  
		 success:function(data){  
		 
		  if(data['Error']&&data['Error'] != ''){  
			   alert(data['Error']);
		  }else{
			// var data1=stringify(data); 
			 // alert(data); 
			 if($('#datalist_salt_id')){
				 $('#datalist_salt_id').html(data);
				//document.getElementById("datalist_salt_id").innerHTML = data;
			 }
			
		  }
		}
	});
	
}

	$(document).ready(function() {
		
		
		
		


		$('.dialog_box2_close').click(function() {
			dialog_box2_close();
		});
		
	
	
		$('textarea').on('keyup keypress', function() {
			$(this).height(0);
			$(this).height(this.scrollHeight);
		});
		$('textarea').trigger("keyup");
		//$('textarea').height(0);$('textarea').height(this.scrollHeight);$('textarea').trigger("keyup");
		
		

	
	});

function BankDocHandleResponse(response){
	if($('#show_img')&&response){
		document.getElementById('show_img').innerHTML = response;
	}
}// End function

function BankDocHandleResponse_multiple(response,id){

	if($('#show_img_'+id)&&response&&id){
		document.getElementById('show_img_'+id).innerHTML = response;
	}
}// End function

function show_image(){  
 document.getElementById('show_img').innerHTML="";
 var xmlHttp = getXMLHttp();  
  xmlHttp.onreadystatechange = function()
  {
    if(xmlHttp.readyState == 4)
    {
      BankDocHandleResponse(xmlHttp.responseText);
    }
  }
  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?gid=<?=((isset($post['gid']) &&$post['gid'])?$post['gid']:'')?>&type=bankdoc", true); 
  xmlHttp.send(null);
}// End Function
//Show bank image at details page
function show_bank_image(id){  
 //document.getElementById('show_img').innerHTML="";
 
 
 var xmlHttp = getXMLHttp();  
  xmlHttp.onreadystatechange = function()
  {
    if(xmlHttp.readyState == 4)
    {
      BankDocHandleResponse_multiple(xmlHttp.responseText,id);
    }
  }
  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?gid="+id+"&type=bankdoc", true); 
  xmlHttp.send(null);
}// End Function

function show_user_doc(userid,type){  
 //document.getElementById('show_userdoc').innerHTML="";
 var xmlHttp = getXMLHttp(); 
  xmlHttp.onreadystatechange = function()
  {
    if(xmlHttp.readyState == 4)
    {
       HandleResponse_userdoc(xmlHttp.responseText);
    }
  }
  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?img="+userid+"&type=userimage", true); 
  xmlHttp.send(null);
}// End Function



function HandleResponse_userdoc(response){

	document.getElementById('show_userdoc').innerHTML = response;
}// End Function

</script>
<style>
#chosenv .chosen-choices{
height: 34px !important;
/*width: 170px !important;*/

}
/*#chosenv .chosen-container-multi .chosen-choices li.search-field input[type=text] {
color: #000 !important;
height: 30px !important;
}*/
/*.asb3 {position:absolute;z-index:9;top:3px;right:5px;}
.asb4 {position:relative;z-index:99;top:3px;right:5px;background: #fff;}*/
.curling_access_key {/*width:20px;height:20px;*/}
 /*html input[type=checkbox] {width:20px;height:20px;}*/
html .aq_div1.active {
    border: 3px solid var(--color-4);
    border-radius: 12px !important;
    padding: 0;
    overflow: hidden;
    margin: 0 0 10px 0;
	/*background: var(--color-4);*/
}

font[color="green"] { color: #cb5757 !important; font-size:14px!important; font-weight:bold!important;}
span[style="font-size:14px;"] {
 font-size:0px!important;
}


.activeTab {position: unset!important;}
.pre_val{word-break:break-word;float:left;width:97%;height:inherit;white-space:normal;overflow:hidden;padding:2px 10px;position:relative}
.pre_salt {float:left;}
.a_salt_add{position:absolute;z-index:99;bottom:4px;right:20px;color:#fff!important;font-weight:700;padding:2px 10px;border-radius:3px;background:#a2a2a2;clear:both}
.a_salt_edit{position:absolute;z-index:99;top:1px;right:1px;color:#fff!important;font-weight:700;padding:2px 10px;border-radius:3px}
.salt_key .a_salt_edit{background:#006400;}
.store_salt_key .a_salt_edit{background:#bab102;}
.store_salt_key_icon {background-image:url("<?=$data['Host']?>/images/store_salt_key_icon.png")!important;background-size:30px!important;background-repeat:no-repeat!important;background-position:0!important;width:30px;height:30px;display:block;position:absolute;z-index:999;right:-4px;top:0px;text-indent:-999px;overflow:hidden;}
.salt_key_icon {background-image:url("<?=$data['Host']?>/images/salt_key_icon.png")!important;background-size:30px!important;background-repeat:no-repeat!important;background-position:0!important;width:30px;height:30px;display:block;position:absolute;z-index:999;/*right:-4px;*/top:0px;text-indent:-999px;overflow:hidden;}
.json_api_icon {background-image:url("<?=$data['Host']?>/images/json_api_icon.png")!important;background-size:24px!important;background-repeat:no-repeat!important;background-position:0!important;width:30px;height:30px;display:block;position:absolute;z-index:999;/*right:-7px;*/top:0px;text-indent:-999px;overflow:hidden;}
.website_li{max-height:95px;overflow:hidden;}
.crypto_icon  {background-image:url("<?=$data['Host']?>/images/coins_icon_logo.png")!important;background-size:18px!important;background-repeat:no-repeat!important;background-position:10px!important;}
.bank_icon {background-image:url("<?=$data['Host']?>/images/bank_icon_logo.png")!important;background-size:18px!important;background-repeat:no-repeat!important;background-position:10px!important;}

.show_img_img {float:left;height:30px !important;width:100px !important;margin:0px 0 0 7px !important;}
.show_img_img img{height:30px !important;}
.show_img_img a{height:30px !important;width:100px !important;margin:0 !important;}

#ratio_sb .chosen-container {/*width:unset !important;*/min-width:200px;margin:0px 6px 0 0;}

.ratio_ro {width:100%;clear:both;border-bottom:2px dotted #ccc;height:0px;padding:8px 0 0px 0;margin:0 0 8px 0;}

.inactive_act {
	display:none;
}
.userlnk {/*color:#000 !important;*/}


.topnav.pull-right.trs >  li > a {height:20px;color:#666;position:relative;top:0px;line-height:20px;margin:0 0 -7px 0;}.topnav.pull-right.trs ul a {display: inline-block; width: 64%; color: #37a6cd; font-size: 12px;}.topnav.pull-right.trs .dropdown-menu>li>a{padding:0px 18px !important;}.topnav.pull-right.trs .dropdown-menu>li>a:hover {color:#fff !important;}.topnav.pull-right.trs .dropdown-menu li {border-bottom: 1px solid #dddddd;}.topnav.pull-right.trs .open>.dropdown-menu, .topnav.pull-right.trs >  li.open> ul {background:#f5f5f5;border:1px solid #dddddd;border-top:none !important;box-shadow:none;-webkit-box-shadow:none;-moz-box-shadow:none;right:0px;border-radius:0 0 0 0;top:28px;min-width:100px;}.topnav.pull-right.trs .dropdown-menu li:last-child {border-bottom:0px solid #dddddd;}.admb font {color:orange !important}
.w50{padding:7px 2% 0 2%;width:96%;float:left;height:30px;position:relative;z-index:2; margin:3px 0;}
.acc_hide{display:none;}

.lead_title {color:#222222;, sans-serif;text-shadow:none;padding:0;margin:0;margin-top: -10px;height:25px;font-weight:bold;}
.progressbar {width:100%;margin-top:-6px;margin-bottom:35px;position:relative;background-color:#EEEEEE;box-shadow:inset 0px 1px 1px rgba(0,0,0,.1);}.proggress{height:8px;width:10px;background-color:#3498db;}.percentCount{float:right;margin-top:-32px;clear:both;font-weight:bold;}.risk_ratio_div {position:absolute;z-index:3;left:0;top:6px;background:#e2e2e2;width:70%;}.usernm {position:relative;top:9px;}.risk_list {position:absolute;right:-30%;}
.tooltip.fade.in{opacity:1.0 !important;}
.capc.acc_tb {text-align:center;font-weight:bold;}.acounts{widthx:710px;heightx:790px;overflow:hidden;}


.capl.all {text-transform:uppercase}.yellow {color:#ffff00;}label {/*font-size: 12px !important;*/}
.capc {border-bottom:2px solid #ccc;}

/*.content-inner {background:#f2f2f2 !important; }*/
.pull_right{border:none !important;}
.rows{border-top: 1px solid #bcb8b8;border-bottom: 1px solid #bcb8b8;}
.btn:focus{color:#000 !important;}

.bg_div1 input,.business_div input{/*border: 1px solid #000 !important;*/}
.span6{margin-right:7px;}
		
.w75 a .glyphicons.circle_plus i:before {top:7px !important;}
.w75 a .glyphicons.circle_minus i:before {top:7px !important;}
.compdtl{background-color:#edeeef;}
.img-thumbnail { height: 36px !important; margin-left: 10px !important; }

.ok_2 {
    margin-left: 0px !important;
    margin-top: 0px !important;
}

@media (max-width: 650px) {
.profilecss .badge {
    display: inline-table !important;
    padding: 3px 5px !important;
  }
}
@media (max-width: 360px) {
.w100_mob { width:100% !important;}

}
</style>
<script type="text/javascript" >
//.user_type
function user_typef(theValue){
	//alert(theValue);
	$('.business_div').slideUp(200);
	$('#add_partners_divId').slideUp(100);
	$('#user_permission option[value="2"]').prop('selected','selected');
	if(theValue=="2"){
		$('.business_div').slideDown(1500);
		$('#add_partners_divId').slideDown(900);
		$('#user_permission option[value="1"]').prop('selected','selected');
	}
	
	<? if((isset($post['user_permission'])&&$post['user_permission'])||(isset($post['user_permission'])&&$post['user_permission']==0)){ ?>
		$('#user_permission option[value="<?=$post['user_permission']?>"]').prop('selected','selected');
	<? } ?>
	
}
function cfmform() {
    return confirm('Are you Sure to Delete this');
}
function cfmVform(theValue='Certify') {
	if(theValue=='0'){
		theValue='Verify';
	}else if(theValue=='1'){
		theValue='Certify';
	}
	//alert(theValue);
    return confirm('Are you Sure to '+theValue+' this');
}
function verifyurl(e) {
    $('.bussinessurls').append('<div class="burl"><input type"=url" name="verify_bussinessurl[]" class="very" value="' + $(e).parent().find('input').attr('value') + '" required pattern="https?://.+" title="Include http:// or https://" /><a class="removeurl" onclick="removeurl(this)">&times;</a></div>');
    $(e).parent().remove();
}

function removeurl(e) {
    $(e).parent().remove();
}
$(document).ready(function(){
	
    $('.addbusinessurls').click(function() {
        $('.bussinessurls').append('<div class="burl"><input type="url" name="verify_bussinessurl[]" class="" value="" required pattern="https?://.+" title="Include http:// or https://" /><a class="removeurl" onclick="removeurl(this)">&times;</a></div>');
    });
    $('.addunverifybusinessurls').click(function() {
        $('.addunverifybusinessurls_div').append('<div class="burl"><input type="url" name="bussinessurl[]" class="" value="" required pattern="https?://.+" title="Include http:// or https://" /><a class="removeurl" onclick="removeurl(this)">&times;</a></div>');
    });
	
	
	$('.echektran .collapsea, .atablink').click(function(){
	   $('.addremarkform, .comtabdiv').slideUp(100);
	   var ids = $(this).attr('data-href');
	   var tabnames = $(this).attr('data-tabname');
	   var dataurl = $(this).attr('data-url');
	   var dataturl = $(this).attr('data-turl');
	  
	  if(dataturl !== undefined){
		if($('#'+ids).hasClass('turlactive')){
		
		}else{
		  //alert(dataturl+"&action=details");
		  dataturl="<?=$data['Host']?>/transactions_get<?=$data['ex']?>?id="+dataturl+"&action=details";
		  ajaxf(dataturl,'#'+ids+' .content_holder');
		  $('#'+ids).addClass('turlactive');
		}
	   }
	   
	  
		if($(this).hasClass('active')){
			$('.collapseitem').removeClass('active');
			$('.collapsea, .atablink').removeClass('active');
			
			$('#'+ids).slideUp(150);
			$('#'+ids+' .'+tabnames).slideUp(200);
		} else {
		  $('.collapseitem').removeClass('active');
		  $('.collapsea, .atablink').removeClass('active');
		  //$('#'+ids).addClass('active');
		  $(this).addClass('active');
		  
		  $('.collapseitem').slideUp(100);
		  $('#'+ids).slideDown(600);
		  if(tabnames !== undefined){
			$('#'+ids+' .'+tabnames).slideDown(800);
		  }


		}
        
    });
	
	
	$(".curling_access_key").click(function(){
		//var textVal=$(this).parent().next().find('.textAreaAdjust').val();
		var textVal=$(this).parent().parent().parent().find('.textAreaAdjust').val();
		//alert(textVal);
		$("#store_json_value").val(textVal);
		$("#store_json_value").height(0);$("#store_json_value").height(this.scrollHeight);$("#store_json_value").trigger("keyup");
	});
	
	
	$(".user_type").click(function(){
		user_typef($(this).val());
	});
	$(".add_partners").click(function(){
		$('#modalpopup_add_partner').slideDown(900);
	});
	$(".remove_popup").click(function(){
		$('#modalpopup_add_partner').slideUp(100);
	});
	
	$(".document_type").change(function(){
		document_typef(this,$(this).val());
	});
	
	$(".same_business").click(function(){
		$('#business_address_bs').val($('#registered_address_bs').val());
	});
	<? if($post['action']=='insert'){ ?>
		setTimeout(function(){ user_typef("2");}, 100);		
	<? }else{ ?>				
		user_typef("<? if(isset($post['user_type'])) echo $post['user_type']?>");
	<? } ?>
	
	<? if(isset($_GET['tab_name'])&&$_GET['tab_name']){ ?>
		$("#<?=$_GET['tab_name'];?>").trigger("click");
	<? }else{ ?>
		$("#collapsible1").trigger("click");
	<? } ?>
	




	
	var store_status=<?php echo jsonencode($data['store_status']);?>;
	//alert(store_status[3]['icon']);
	
	$('.database_plus2.flagtg').each(function() {
		if($(this).attr('data-mid')&&$(this).attr('data-ihref')){
			var thisStorId=$(this).attr('data-ihref');
			$(this).attr('data-ihref',"<?=$data['USER_FOLDER']?>/<?=($store_url);?><?=$data['ex']?>?admin=1&action=view&mid="+$(this).attr('data-mid')+"&id="+thisStorId);
			
			if(store_status[$(this).attr('data-icon')]['icon']){$(this).addClass(store_status[$(this).attr('data-icon')]['icon']);}
			if(store_status[$(this).attr('data-icon')]['color']){$(this).addClass(store_status[$(this).attr('data-icon')]['color']);}
			
			if(store_status[$(this).attr('data-icon')]['title']){$(this).attr('title',store_status[$(this).attr('data-icon')]['title']);}
		}
    });
	active_f('#collapsible8 a','activeTab','#collapsible8_html');
    
});</script>
<script>
/* js for check username available or not */
function checkAvailability(t) {
var username_old=$('#username_old').val();
var username=$('#username').val();

if (username_old == username){
 $("#user-availability-status").html('');
 return false;
}

	var d='';
	if (t=="registered_email"){d='tbl=clientid_table&registered_email='+$("#registered_email").val();}
	else 
	{
		d='tbl=clientid_table&username='+$("#username").val();

		var username = $('#username').val();

		if (username!=''&&(!(new RegExp(/^[a-z0-9]*$/).test(username)))) {
		//	$("#username").css("border", "1px solid red");
			$("#user-availability-status").html("Username: Only alphabets in lowercase and numbers allowed");
			return false;
		}
	}
	$("#loaderIcon").show();
	jQuery.ajax({
	url: "<?php echo $data['Host'];?>/include/check_availability<?=$data['ex']?>",
	data:d,
	type: "POST",
	success:function(data){
		$("#user-availability-status").html(data);
		$("#loaderIcon").hide();
	},
	error:function (){}
	});
}
</script>
<script>
function CopyToClipboard2(text) {
			text=$(text).html();
			//alert(text);
			var $txt = $('<textarea />');

            $txt.val(text)
                .css({ width: "1px", height: "1px" })
                .appendTo('body');

            $txt.select();

            if (document.execCommand('copy')) {
                $txt.remove();
				alert("Copied");
            }
	}
</script>
<style>
#user-availability-status{width:100%;text-align:center;color:red;font-size:14px;}
.flagtg {
   
    /*color: <?=$_SESSION['background_gd5']?>;
    border-color: <?=$_SESSION['background_gd4']?>;
	margin-bottom: 2px;
	background-color: <?=$_SESSION['background_gl6']?>;*/
	text-align: left;
	color: var(--link-color-template) !important;
}

.flagtg:hover, .flagtg:active {
    color: var(--color-2);
    background-color: var(--color-4);
	width: 100%;
    
    /*border-color: <?=$_SESSION['background_gd4']?>;*/
}
.w50 {padding: 5px 0 0 0 !important; width: 100% !important; }
.card_total_ratio { margin-top:10px !important; }    
/*.card { background: <?=$_SESSION['background_gl5']?> !important;border-radius:8px;}*/

.desc_date { display:none;}
.fa-bling-h { --fa-beat-fade-opacity: 0.1; --fa-beat-fade-scale: 2.00;--fa-animation-duration: 13s;--fa-border-radius:10px;border-radius: 100%;padding: 2px;margin-left: -7px; }
.icon_highlight { font-size: 40px;position: absolute;margin-top: -21px; }
.icon_size{font-size: 14px; color:#FFFFFF !important;}
i#email_toggle.active {color:green;}
.vtitle_success{ margin: 5px;color: #0d7720;font-weight: 600;}
.vtitle_failed{  margin: 5px;color: #a60e25;font-weight: 600;}
.loading_img{ color:var(--color-4) !important;display:inherit!important;}
.hide_on_mobile{ display:block;!important;}
.display_on_mobile{ display:none;!important;}
@media (max-width: 999px) {
.hide_on_mobile{ display:none !important;}
.display_on_mobile{ display:block !important;margin-top: -20px;}
.td_action_width{ padding-left: 4% !important; };
}

@media (max-width: 400px) {
.mobile.text-end { text-align: left!important;}
}
</style>


<div class="container border rounded my-1 vkg">

  <? if(isset($_SESSION['action_success_merchant'])&&$_SESSION['action_success_merchant']){ ?>
  <div class="alert alert-success alert-dismissible fade show my-2" role="alert" did="action_success_merchant"> 
    <?=$_SESSION['action_success_merchant']?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? 
  unset($_SESSION['action_success_merchant']);
  } ?>
  
  
  <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
  <div class="alert alert-success alert-dismissible fade show my-2" role="alert" did="action_success"> 
    <?=$_SESSION['action_success']?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? 
  unset($_SESSION['action_success']);
  } ?>
  
    <div id="codereset" name="codereset" class="codereset alert alert-success alert-dismissible fade show my-2" style="display:none;"></div>

    <? if($_GET['action']=='delemail'){ ?>
    <div class="alert alert-success alert-dismissible fade show my-2" role="alert"> <strong>Success!</strong>
      Email <?=$_GET['email'];?> Deleted Successfull
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? } ?>
	
	<? if($_GET['action']=='setdefault'){ ?>
    <div class="alert alert-success alert-dismissible fade show my-2" role="alert"> <strong>Success!</strong>
      Email <?=$_GET['email'];?> Set as Primary Successfull
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? } ?>
	
	<? if(isset($_SESSION['msgweb'])&&$_SESSION['msgweb']){ ?>
    <div class="alert alert-success alert-dismissible fade show my-2" role="alert"> <strong>Success!</strong>
     <?=$_SESSION['msgweb'];?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? unset($_SESSION['msgweb']); } ?>
    <? if(isset($_GET['HideMenu'])&&$_GET['HideMenu']==1){ $hmenu="&HideMenu=1";} ?>
  
    <? if(($post['action']!='insert') and ($post['action']!='update88') and ($post['action']!='insert_bank55')){ ?>
    <div class="row">
    <div class="col-sm-6 px-0 text-start row" >

    <? if(empty($post['gid'])){ ?>
    <span class="hide" id="merchanttitle">
    <h4 class="my-2">
    <? if(isset($post['type'])&&$post['type']=='found'){ ?> <i class="<?=$data['fwicon']['merchant'];?>"></i> List Of Found
    <? }else if(isset($post['type'])&&$post['type']=='active'){ ?> <i class="<?=$data['fwicon']['merchant'];?>"></i> Active
    <? }elseif(isset($post['type'])&&$post['type']=='suspended'){ ?> <i class="<?=$data['fwicon']['suspended'];?>"></i> Suspended
    <? }elseif(isset($post['type'])&&$post['type']=='closed'){ ?> <i class="<?=$data['fwicon']['circle-cross'];?>"></i> Closed
    <? }elseif(isset($post['type'])&&$post['type']=='online'){ ?> <i class="<?=$data['fwicon']['merchant'];?>"></i> Online
    <? }elseif(isset($post['type'])&&$post['type']=='submerchant'){ ?> <i class="<?=$data['fwicon']['user-double'];?>"></i> Sub
    <? } ?>
    Merchant
    <? if(isset($post['type'])&&$post['type']!='online'){ ?>
    ( <? if(isset($data['result_count'])) echo $data['result_count']?>
	<? if(isset($value['clients_count'])) echo $value['clients_count']?>)
    <? } ?>
 
  </h4>
 </span> 
<? }else{ ?> 
  <h4 class="my-2"><i class="<?=$data['fwicon']['merchant'];?>"></i> <?=$_SESSION['MemberInfo']['company_name'];?></h4>
 <? } ?>  
  </div>
  <?php
  if(empty($post['gid'])){
  if(isset($post['type'])&&$post['type']=='active'){
  ?>
<div class="col-sm-6 my-2 px-0 text-end"><a  href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?action=insert<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" value="Add New Merchant"  class="btn btn-primary" title="Add New Merchant"><i></i><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a></div>
  <?php
  }
  
  }else{
 

  ?>
  
  <div class="col-sm-6 my-2 pe-1 mobile text-end profilecss">
  
  <span class="badge rounded-pill border border-vlink text-white px-2 m-2" id="2fa_status" data-bs-toggle="dropdown" aria-expanded="false"> <? if($_SESSION['MemberInfo']['google_auth_access']==1){ ?>
			  
<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_two_way_authentication'])&&$_SESSION['clients_two_way_authentication']==1)){ ?> href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$_SESSION['MemberInfo']['id']?>&action=detail&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&code=2" <? } ?> title="Active">
<span class='bg-dark fa-bling-h 104'><i class="<?=$data['fwicon']['circle-check'];?> mx-1 fa-beat-fade77 icon_size"></i></span>
</a>
			  
<? }else { ?>
			  
<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_two_way_authentication'])&&$_SESSION['clients_two_way_authentication']==1)){ ?> href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$_SESSION['MemberInfo']['id']?>&action=detail&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&code=1" <? } ?> title="DeActivate"> 
<span class='bg-dark fa-bling-h 101'><i class="<?=$data['fwicon']['circle-cross'];?> mx-1 fa-beat-fade77 icon_size"></i></span>			  
</a>
			   

			  
              <? } ?>2FA&nbsp;</span>

<?
if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
{?>
	<ul class="dropdown-menu" aria-labelledby="2fa_status">
	<? 
	if($_SESSION['MemberInfo']['google_auth_access']!=1){ ?>
		<li class="dropdown-item"><a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_two_way_authentication'])&&$_SESSION['clients_two_way_authentication']==1)){ ?> href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$_SESSION['MemberInfo']['id']?>&action=detail&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&code=1" <? } ?> title="Active"><i class="<?=$data['fwicon']['circle-check'];?> mx-1 "></i> Activate</a></li>
	<? }else { ?>
			<li class="dropdown-item"><a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_two_way_authentication'])&&$_SESSION['clients_two_way_authentication']==1)){ ?> href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$_SESSION['MemberInfo']['id']?>&action=detail&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&code=2" <? } ?> title="DeActivate"><i class="<?=$data['fwicon']['circle-cross'];?> mx-1"></i> De Activate </a></li>
			<li class="dropdown-item"><a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_two_way_authentication'])&&$_SESSION['clients_two_way_authentication']==1)){ ?> href="#" onclick='AuthenticationReset(<?php echo $_SESSION['MemberInfo']['id']?>);' <? } ?> ><i class="<?=$data['fwicon']['reset-password'];?> mx-1" title="Click to Re-set the code"></i> Reset the code</a>
			</li>
		<? } ?>
	</ul>
	<?
	}?>  
   <span class="badge rounded-pill border border-vlink text-white px-2 m-2" id="pro_status" data-bs-toggle="dropdown" aria-expanded="false"> 
			  
<? if($_SESSION['MemberInfo']['edit_permission']==1){ ?> 
<span class="bg-dark fa-bling-h 102"><i class="<?=$data['fwicon']['circle-check'];?> mx-1 icon_size"></i></span>	
<? }else{ ?>
<span class='bg-dark fa-bling-h 103'><i class="<?=$data['fwicon']['circle-cross'];?> mx-1 icon_size"></i></span>	
<? } ?>
Profile Status&nbsp;</span>

<?
if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
{?>
  <ul class="dropdown-menu" aria-labelledby="pro_status">
  
  <? if($_SESSION['MemberInfo']['edit_permission']==1){ ?>

<li class="dropdown-item"><a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$_SESSION['MemberInfo']['id']?>&action=detail&type=profile_status&scode=2"  title="Un Approved"><i class="<?=$data['fwicon']['circle-cross'];?> mx-1 "></i> Un Approved </a></li>		  

 <? }else { ?>
			  
<li class="dropdown-item"><a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$_SESSION['MemberInfo']['id']?>&action=detail&type=profile_status&scode=1" title="Approved"><i class="<?=$data['fwicon']['circle-check'];?> mx-1"></i> Approved </a></li>
			   
<? } ?>
   
  </ul>
  
  
  <?
}
   if($_SESSION['MemberInfo']['status']==2&&$_SESSION['MemberInfo']['active']==1){ $_SESSION['merchant_title_status']="<span class='bg-dark fa-bling-h'><i class='".$data['fwicon']['check-circle']." px-1  fa-beat-fade77 icon_size' title='Active' ></i></span>"; }
     elseif($_SESSION['MemberInfo']['status']==0&&$_SESSION['MemberInfo']['active']==1){ $_SESSION['merchant_title_status']="<span class='bg-dark fa-bling-h'><i class='".$data['fwicon']['circle-cross']." px-1  fa-beat-fade77 icon_size' title='Pending Admin Activation' ></i></span>"; }
  elseif($_SESSION['MemberInfo']['status']==0&&$_SESSION['MemberInfo']['active']==0){ $_SESSION['merchant_title_status']="<span class='bg-dark fa-bling-h'><i class='".$data['fwicon']['suspended']." px-1  fa-beat-fade77 icon_size' title='Suspended'></i></span>"; }
  else{ $_SESSION['merchant_title_status']="<span class='bg-dark fa-bling-h'><i class='".$data['fwicon']['circle-cross']." px-1 fa-beat-fade77 icon_size' title='Close'></i></span>"; }
  ?>
  
  <span class="badge rounded-pill border border-vlink text-white px-2 m-2" id="user_status_id" data-bs-toggle="dropdown" aria-expanded="false" ><?=$_SESSION['merchant_title_status'];?> <span title="User Name - <?=$_SESSION['MemberInfo']['username'];?> [<?=$_SESSION['MemberInfo']['id']?>]"><?=$_SESSION['MemberInfo']['username'];?> [<?=$_SESSION['MemberInfo']['id']?>]</span></span>
  
  <?
if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
{?>
    <ul class="dropdown-menu" aria-labelledby="user_status_id">
	
<? if($post['MemberInfo']['ip_block_clients']=='0'){ $ip_block_clients="RESTART"; }else { $ip_block_clients="TERMINATE"; } ?>
<? 

if($_SESSION['MemberInfo']['active']==1){ ?>
<? if($_SESSION['MemberInfo']['status']==0){ ?>
<li class="dropdown-item"><a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$_SESSION['MemberInfo']['id']?>&action=fullyverify&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to Active this Account');" class="text-success fw-bold"  title="Activate"><i class="<?=$data['fwicon']['circle-check'];?> mx-1"></i> Active</a></li>
<? } ?>
<li class="dropdown-item"><a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$_SESSION['MemberInfo']['id']?>&action=suspend&type=<?=@$post['type']?>" onclick="return confirm('Are you Sure to Suspend/View Only this Merchant')" class=" 106" title="Suspend/View Only"><i class="<?=$data['fwicon']['suspended'];?> mx-1" ></i> Suspend</a></li>

<li class="dropdown-item"><a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$_SESSION['MemberInfo']['id']?>&action=close&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to Close this Merchant')" class="107" title="Close"> <i class="<?=$data['fwicon']['circle-cross'];?> mx-1" ></i> Close</a></li>

<? }else{ ?>
			  
<li class="dropdown-item"><a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$_SESSION['MemberInfo']['id']?>&action=fullyverify&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to Active this Account');" class="109"  title="Activate"><i class="<?=$data['fwicon']['circle-check'];?> mx-1"></i> Active</a></li>
<? } ?>
              
  </ul>
  <?
  }?>
  
  </div>
  
  
  
  <?
  
  }
  ?>
</div>
  <? } ?>
  <? if(isset($post['type'])&&$post['type']=='block'){ ?>
  <div class="row border bg-info my-2 text-start vkg">
    <h4 class="row border my-2 text-start">List of Block Merchant</h4>
    <div class="row col-sm-12 my-2">
      <div class="col-sm-4">IP Address</div>
      <div class="col-sm-4">Date</div>
      <div class="col-sm-4">Action</div>
    </div>
    <? foreach($data['ipaddressList'] as $key=>$value){ ?>
    <div class="row col-sm-12 my-2">
      <div class="col-sm-4">
        <?=$value['IpAddress']?>
      </div>
      <div class="col-sm-4">
        <?=$value['date_last_use']?>
      </div>
      <div class="col-sm-4"><a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$value['id']?>&action=block<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Unblock</a></div>
    </div>
    <? } ?>
  </div>
  <? }elseif($post['action']=='select'){ 
  //echo count($data['clientsList']);
  ?>
  <style>.bdrfull1 table td:before { color:var(--color-1) !important; }</style>
  <script>$('#merchanttitle').show(); </script>
  <div class="bdrfull1 table-responsive-sm" style="min-height: 300px;">
    <table class="table table-hover frame tbl">
        <thead>
          <tr>
          <th scope="col"><a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){ ?> href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?action=select&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" <? } ?> >MID</a></th>
          <th scope="col">Company Name</th>
          <th scope="col">Full Name</th>
	      <? if(!(isset($data['API_VER'])&&$data['API_VER']==2)){ ?>
          <th scope="col">E-Mail</th>
          <? } ?>    
	   
          <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_risk_ratio_bar'])&&$_SESSION['clients_risk_ratio_bar']==1)){ ?>
		  <th scope="col"> Username </th>
		  <? } ?>

		  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_store_view'])&&$_SESSION['clients_store_view']==1)){ ?>
          <th scope="col"> <?=($store_name);?>/s </th>
          <? } ?>
		  
          <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_gp_view_id'])&&$_SESSION['clients_gp_view_id']==1)){ ?>
		  <th scope="col" title="Gateway Partners Id" data-bs-toggle="tooltip" data-bs-placement="top"> GP. ID </th>
		  <? } ?>
		  
          <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_total_transaction'])&&$_SESSION['clients_total_transaction']==1)){ ?>
		  <th scope="col">
		 <div class="btn-group">
              <a type="button" data-bs-toggle="dropdown" aria-expanded="false"> <i class="<?=$data['fwicon']['arrow-right-arrow-left'];?> " title="Total Transactions" data-bs-toggle="tooltip" data-bs-placement="top" ></i></a>
              <ul class="dropdown-menu text-dark" >
                <li><a class="dropdown-item" href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?action=select&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&order=31" style="color:#000000 !important;" title="It will display from lowest to highest number of transaction">&nbsp;<i class="<?=$data['fwicon']['hand'];?>" ></i> Asc</a></li>
                <li><a class="dropdown-item" href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?action=select&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&order=11"  style="color:#000000 !important;" title="It will display from highest to lowest number of transaction">&nbsp;<i class="<?=$data['fwicon']['hand'];?>" ></i> Desc</a></li>
                <li><a class="dropdown-item" href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?action=select&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&order=41"  style="color:#000000 !important;" title="It will display the transactions o values" >&nbsp;<i class="<?=$data['fwicon']['hand'];?>" ></i> Dormant</a></li>
              </ul>
            </div>
		  </th>
		  <? } ?>
          
		  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)||(isset($_SESSION['merchant_action_edit'])&&$_SESSION['merchant_action_edit']==1)){ ?>
		   <th scope="col"> Action</th>
		  <? } ?>
		  
		  
	
         
        </tr>
      </thead>
      <?  
	//print_r($data['clientsList']); USER_FOLDER
	$k=0;
	if($data['clientsList']){foreach($data['clientsList'] as $key=>$value){
		  $k++;
	  //$bgcolor=$k%2?'#EEEEEE':'#E7E7E7'; 
	  //if($value['color']==""){ $value['color']="#b9aeae";}
	// echo  $value['color'];
	
	  $themebgcolor=@$value['header_bg_color'];
	  $themecolor=@$value['header_text_color'];
	  if(isset($themecolor)&&$themecolor==""){ $themebgcolor=$value['color']; }
	  //if($value['header_text_color']==""){ $value['header_text_color']="#000";}
	 // if($value['header_bg_color']==""){ $value['header_bg_color']="#fff";}
	?>
      <tr id="mlist"  class="bdr1" valign="top" style="color:<?=$themecolor?>;background:<?=$themebgcolor?>" >
		
        <td data-label="MID - " >
          <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){ ?>
          <a data-ihref="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$value['id']?>&action=detail&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&admin=1&hideAllMenu=1&m=<?=ucwords(strtolower($value['company_name']))?>" class="merchant_modal99 btn btn-outline-secondary btn-sm pointer" style="color:<?=$themecolor?>;" onclick="iframe_open_modal(this)">
          <?=$value['id']?>

          </a> <!--Change href to data-ihref and add 99 to merchant_modal99-->
          <? } ?>
        </td>
		
        <td data-label="Company Name - "><a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){ ?> href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$value['id']?>&action=detail&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" <? } ?> style="color:<?=$themecolor?>;">
          <?=ucwords(strtolower($value['company_name']))?>
          </a> </td>
		  
        <td data-label="Full Name - " ><?
		if(isset($value['fullname'])&&$value['fullname']) echo $value['fullname'];
		else { echo $value['fname'].' '.$value['lname'];}?>
		
          <? if($post['type']=='online'){ ?>
          (
          <?=$value['last_ip']?>
          )
          <? } ?></td>

        
       <? if(!(isset($data['API_VER'])&&$data['API_VER']==2)){ ?>   
        <td data-label="Email ID - " >
		<a href="mailto:<?=encrypts_decrypts_emails($value['email'],2);?>" style="color:<?=$themecolor?>;"><?=encrypts_decrypts_emails($value['email'],2,true);?></a>
        </td>
       <? } ?>	 
        
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_risk_ratio_bar'])&&$_SESSION['clients_risk_ratio_bar']==1)){ ?>
		<td data-label="User Name - " >
		<a style="color:<?=$themecolor?>;" class="userlnk" <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){ ?> href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$value['id']?>&action=detail&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>"  <? } ?> >
          <?=$value['username']?>
          </a>
		  </td>
		  <? } ?>
        
 
       
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_store_view'])&&$_SESSION['clients_store_view']==1)){ ?>
		<td data-label="Website/s - " title="View Website" data-bs-toggle="tooltip" data-bs-placement="left" >
            <? if($value['store_count']){ ?>
			

			  
			  <div class="dropdown">
  

  <a class="badge rounded-pill bg-vdark" id="website_button" data-bs-toggle="dropdown" aria-expanded="false"   ><?=$value['store_count']?></a>
  <ul class="dropdown-menu" aria-labelledby="website_button">
    <li><?=str_replace("iframe_openf","iframe_open_modal",$value['store_id']);?></li>
  </ul>
</div>
			  
			  
            <?

			} else { //echo "-No {$store_name} yet-.";
			?>
            <a class="badge rounded-pill bg-vdark">0</a>
            <?
			} ?>
		</td>
		<? } ?>		  
		  
        
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_gp_view_id'])&&$_SESSION['clients_gp_view_id']==1)){ ?>
<td data-label="GP ID - " >
		<a href="<?=$data['Admins'];?>/subadmin<?=$data['ex']?>?id=<?=$value['sponsor'];?>&action=update&page=0" ><span class="single fw-bold badge rounded-pill bg-vdark" data-bs-toggle="tooltip" data-bs-placement="left"  data-bs-original-title="Manage Gateway Partners" ><?=$value['sponsor'];?></span></a>
          
          
 </td>
<? } ?>		  
		  
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_total_transaction'])&&$_SESSION['clients_total_transaction']==1)){ ?>
		<td class="in_row_hover" data-label="Transaction - "  >
		<a href="<?=$data['Admins'];?>/transactions<?=$data['ex']?>?bid=<?=$value['id']?>&action=select&status=-1&type=-1" style="color:<?=$themecolor?>;" class="fw-bold" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-original-title="View"><font id="trcoun_<?=$k;?>"><?=$value['transactions']?></font></a>
		
		<a class="restartfa btn btn-icon btn-primary hide now_hover" onClick="ajaxf1(this,'<?=$data['Admins']?>/transactions<?=$data['ex'];?>?bid=<?=$value['id']?>&action=update_tr_count','#trcoun_<?=$k;?>','1','2')" title="Tr. Count" style="font-size:10px !important;padding:2px;" ><i class="<?=$data['fwicon']['retweet'];?>"></i></a>
		

        </td>  
		 <? } ?> 
        
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)||(isset($_SESSION['merchant_action_edit'])&&$_SESSION['merchant_action_edit']==1)){ ?>
		
		<td class="td_action_width" >
		
		<div class="btn-group dropstart ">
            <a data-bs-toggle="dropdown" aria-expanded="false" style="color:<?=$themecolor?>"  title="Action"><i class="<?=$data['fwicon']['circle-down'];?>"></i></a>
            <ul class="dropdown-menu pull-right text-white" >
			<?php /*?>style="color:<?=$themecolor?>;background:<?=$themebgcolor?>"<?php */?>
              <? if($post['type']=='online'){ ?>
              <? }else{ ?>
              <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){ ?>
              <li> <a class="dropdown-item " href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$value['id']?>&action=detail&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['eye'];?> fa-fw"></i> <span>View</span></a></li>
              <? } ?>
              <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_edit'])&&$_SESSION['merchant_action_edit']==1)){ ?>
              <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$value['id']?>&action=update&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['edit'];?> fa-fw"></i> <span>Edit</span></a></li>
              <? } ?>  
			  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_login'])&&$_SESSION['merchant_action_login']==1)){ ?>
<li>
<form method="post" target="_blank" action="<?=$data['Host'];?>/admin-merchant/login<?=$data['ex']?>">
<input type="hidden" name="bid" value="<?=$value['id']?>" />
<button type="submit" class="dropdown-item" name="login" value="login" style="background: none;border: none;cursor: pointer;"/>
<i class="<?=$data['fwicon']['login'];?> fa-fw"></i> Login</button>
</form></li>
              <? } ?>
              <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['block'])&&$_SESSION['block']==1)){ ?>
              <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?block_id=<?=$value['id']?>&action=blockIp&ip_status=<?=$status=($value['ip_block_clients']=='0')?1:0 ?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['lock'];?>  fa-fw"></i> <span>
                <? if($value['ip_block_clients']=='0'){ echo "Restart"; }else {echo "Terminate"; } ?>
                </span></a></li>
              <? } ?>
              <? if($post['type']=='active'){ ?>
              <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['suspended'])&&$_SESSION['suspended']==1)){ ?>
              <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$value['id']?>&action=suspend&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to Suspend this');" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['suspended'];?> fa-fw"></i> <span>Suspend</span></a></li>
              <? } ?>
              <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['closed'])&&$_SESSION['closed']==1)){ ?>
              <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$value['id']?>&action=close&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to Close this Merchant')" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['circle-cross'];?> fa-fw"></i> <span>Close</span></a></li>
              <? } ?>
              <? }else{ ?>
              <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['active'])&&$_SESSION['active']==1)){ ?>
              <li> <a class="dropdown-item" href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$value['id']?>&action=activate&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" onClick="return confirm('Are you Sure to Activate this');" style="color:<?=$themecolor?>;"><i class="<?=$data['fwicon']['eye'];?> fa-fw"></i> <span>Activate</span></a></li>
              <? } ?>
              <? } ?>
              <? } ?>
            </ul>
          </div>
		
		</td>
		   <? } ?> 
		 
      
      </tr>
      <? }} ?>
    </table>
  </div>
  <div class="pagination" style="float:left; width:100%; text-align:center;">
    <?php
		include("../include/pagination_pg".$data['iex']);
		
		if(isset($_GET['page'])){$page=$_GET['page'];unset($_GET['page']);}else{$page=1;}
		$get=http_build_query($_GET);
		$url=$data['Admins']."/merchant{$data['ex']}?".$get;
		
		$total = (int)@$data['clients_count'];
		
		pagination(200,$page,$url,$total);
	?>
  </div>
  <? }
	elseif($post['action']=='detail'){
		//$_SESSION["action_success"]='Your Profile Information Has Been Created';
		
		if(isset($_SESSION['uid_'.$post['gid']])){
			unset($_SESSION['uid_'.$post['gid']]);
		}
		
	?>
	<script>$('#merchanttitle').show(); </script>
	
  <!-- start point-->
  <div class="mywrap-collabsible tog1">
    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){ ?>
    <label id="collapsible1" class="lbl-toggle btn btn-primary  my-2" onClick="ajaxf1(this,'','#collapsible1_html'),closealltab(1)"> <i class="<?=$data['fwicon']['general-information'];?>" title="General Information" data-bs-toggle="tooltip" data-bs-placement="top"></i> </label>
    <label id="collapsible2" class="lbl-toggle btn btn-primary  my-2" onClick="ajaxf1(this,'','#collapsible2_html'),closealltab(2)"> <i class="<?=$data['fwicon']['spoc-information'];?>" title="SPOC Information" data-bs-toggle="tooltip" data-bs-placement="top"></i> </label>
    <label id="collapsible6" class="lbl-toggle btn btn-primary  my-2" onClick="ajaxf1(this,'<?=$data['Host']?>/include/acquirer_admin<?=$data['ex'];?>?gid=<?=$post['gid'];?>&sponsor=<?=$post['MemberInfo']['sponsor'];?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>','#collapsible6_html','1','2'),closealltab(3)"> <i class="<?=$data['fwicon']['acquirer']?>" title="Acquirer" data-bs-toggle="tooltip" data-bs-placement="top"></i> </label>
    <label id="collapsible3" class="lbl-toggle btn btn-primary  my-2" onClick="ajaxf1(this,'<?=$data['Host']?>/include/website_store_admin<?=$data['ex'];?>?gid=<?=$post['gid'];?>&sponsor=<?=$post['MemberInfo']['sponsor'];?><? if(isset($hmenu)) echo $hmenu?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>','#collapsible3_html','1','2'),closealltab(4)"> <i class="<?=$data['fwicon']['website'];?>" title="Available <?=ucwords($store_name);?>/s" data-bs-toggle="tooltip" data-bs-placement="top"></i> </label>
    <label id="collapsible7" class="lbl-toggle btn btn-primary  my-2" onClick="ajaxf1(this,'<?=$data['Host']?>/include/bank_admin<?=$data['ex'];?>?gid=<?=$post['gid'];?>&sponsor=<?=$post['MemberInfo']['sponsor'];?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>','#collapsible7_html'),closealltab(6)"> <i class="<?=$data['fwicon']['bank-account'];?>" title="Bank Account Information" data-bs-toggle="tooltip" data-bs-placement="top"></i> </label>
    <label id="collapsible10" class="lbl-toggle btn btn-primary  my-2" onClick="ajaxf1(this,'<?=$data['Host']?>/include/bank_admin<?=$data['ex'];?>?gid=<?=$post['gid'];?>&sponsor=<?=$post['MemberInfo']['sponsor'];?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&action=delete_list','#collapsible10_html'),closealltab(7)" title="Bank Account Deleted Information " data-bs-toggle="tooltip" data-bs-placement="top"> <i class="<?=$data['fwicon']['bank-account-deleted'];?> text-danger" ></i></label>
    <label id="collapsible8" class="lbl-toggle btna00 " >

    <a onClick="closealltab(5)" href="<?=$data['USER_FOLDER'];?>/withdraw-fund<?=$data['ex']?>?admin=1&bid=<?=$_GET['id'];?>" target="iframe_withdrawal" class="btn btn-primary  " title="Withdrawal" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['withdrawal'];?>"></i></a> 
	
	<a onClick="closealltab(5)" href="<?=$data['USER_FOLDER'];?>/withdraw-frozen-fund<?=$data['ex']?>?admin=1&bid=<?=$_GET['id'];?>" target="iframe_withdrawal" class="btn btn-primary" title="Frozen Balance" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['frozen-balance'];?>"></i></a> 
	
	<a onClick="closealltab(5)" href="<?=$data['USER_FOLDER'];?>/withdraw-frozen-rolling<?=$data['ex']?>?admin=1&bid=<?=$_GET['id'];?>" target="iframe_withdrawal" class="btn btn-primary" title="Frozen Rolling" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['frozen-rolling'];?>"></i></a>

    </label>
    <script>
function closealltab(tno){
//alert(tno);

$("#collapsible1_html").css("display", "none");
$("#collapsible2_html").css("display", "none");
$("#collapsible7_html").css("display", "none");
$("#collapsible10_html").css("display", "none");
$("#collapsible6_html").css("display", "none");
$("#collapsible3_html").css("display", "none");
$("#collapsible8_html").css("display", "none");

if(tno==1){
$("#collapsible1_html").css("display", "");
}
if(tno==2){
$("#collapsible2_html").css("display", "");
}
if(tno==3){
$("#collapsible6_html").css("display", "");
}
if(tno==4){
$("#collapsible3_html").css("display", "");
}
if(tno==5){
$("#collapsible8_html").css("display", "");
}
if(tno==6){
$("#collapsible7_html").css("display", "");
}

if(tno==7){
$("#collapsible10_html").css("display", "");
}

}
</script>

<? if($post['MemberInfo']['qrcode_gateway_request']==1){ ?>
<label class="lbl-toggle btn btn-primary  my-2"> <a href="<?=$data['USER_FOLDER']?>/qr-code<?=$data['ex']?>?id=<?=$_GET['id']?>&admin=1" class="float-end modal_for_iframe text-white" title="QR Code" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['qrcode'];?>" ></i></a></label>
<? } ?>	
	

<div class="float-end">
	<div class="row5 s_section">
	<?
	if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
	{
		if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_total_transaction'])&&$_SESSION['clients_total_transaction']==1)){ ?>
            <a class="btn btn-icon btn-primary" href="<?=$data['Admins'];?>/transactions<?=$data['ex']?>?bid=<?=$post['MemberInfo']['id']?>&action=select&status=-1&type=-1<?=$data['is_admin_link']?>" title="Transaction - <?=$post['MemberInfo']['tr_count']?>" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['table-list'];?>" ></i>
            <?=$post['MemberInfo']['tr_count']?>
            </a>
            <? } ?>
            <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_password_reset'])&&$_SESSION['merchant_action_password_reset']==1)){ ?>
            <a  data-mid="<?=$_GET['id']?>" href="<?=$data['Admins'];?>/passwordreset<?=$data['ex']?>?bid=<?=$_GET['id'];?>" class="sub_logins22 btn btn-icon btn-primary " target="hform" title="Reset Password" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['reset-password'];?>"></i></a> 
			

			
            <? } ?>
            <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_login'])&&$_SESSION['merchant_action_login']==1)){ ?>
            


<form method="post" target="_blank" action="<?=$data['Host'];?>/admin-merchant/login<?=$data['ex']?>" style="padding: 0;margin: 0;display: inline-block;">
<input type="hidden" name="bid" value="<?=$_GET['id']?>" />
<button type="submit" name="login" value="login" class="sub_logins11 btn btn-primary my-2" title="Login" data-bs-toggle="tooltip" data-bs-placement="top" /><i class="<?=$data['fwicon']['login'];?> fa-fw"></i></button>
</form>


            <? } ?>
            <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_m_edit'])&&$_SESSION['merchant_action_m_edit']==1)){ ?>
            <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&action=update&type=active&page=0" class=" btn btn-primary my-2" title="Edit" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['edit'];?>"></i></a>
            <? if(isset($data['frontUiName'])&&in_array($data['frontUiName'],array("bg","ice"))){ ?>
            <a data-mid="<?=$_GET['id']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['USER_FOLDER']?>/profile<?=$data['ex']?>?id=<?=$_GET['id']?>&admin=1" class="titile2 btn btn-icon btn-primary iframe_open" title="M.Edit" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['edit'];?> text-success"></i></a>
            <? } ?>
			

			
			<a  href="<?=$data['USER_FOLDER']?>/payout-keys<?=$data['ex']?>?id=<?=$_GET['id']?>&admin=1" class="btn btn-primary my-2 modal_for_iframe"  title="API Keys" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['key'];?>"></i></a>
			
            <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_current_balance'])&&$_SESSION['clients_current_balance']==1)){ ?>
            <a class="restartfa btn btn-icon btn-primary" onClick="ajaxf1(this,'<?=$data['Host']?>/include/current_balance_admin<?=$data['ex'];?>?gid=<?=$post['gid'];?>&sponsor=<?=$post['MemberInfo']['sponsor'];?>','#total_current_balance','1','2')" title="Balance" data-bs-toggle="tooltip" data-bs-placement="top" ><i class="<?=$data['fwicon']['balance'];?>"></i></a> <a href="<?=$data['Admins'];?>/transactions<?=$data['ex']?>?bid=<?=$post['MemberInfo']['id']?>&action=select" > <span id="total_current_balance">
            <? if(isset($post['ab']['summ_total'])) echo $post['ab']['summ_total'];?>
            </span> </a>

            <? } ?>
            <? } ?>
			
			

			<? } ?>
          </div>
        </div>

    <div class="collapsible-content">
      <div id="collapsible1_html" class="content-inner "  style="padding:0 !important;">
        <!-- MKS-->
        
        <div class="row text-start row text-start rounded" style="clear:both;">
        
  
          <div class="col-sm-12 my-2 link-hover">
		  
		  
            <div class="my-2 btn btn-outline-primary btn-sm text-white float-start mx-1"><strong>Gateway ID :</strong>
              <? if($post['MemberInfo']['sponsor']){ ?>
              <a  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['update_sub_admin_other_profile'])&&$_SESSION['update_sub_admin_other_profile']==1)){ ?> href="<?=$data['Admins'];?>/subadmin<?=$data['ex']?>?id=<?=$post['MemberInfo']['sponsor'];?>&action=update&page=0" <? } ?> >
             
              <?=$post['MemberInfo']['associate_info'];?>
              </a>
              <? } ?>
            </div>
			
          </div>
          <? if($data['SpoMultiple'][0]!='--'){ ?>
          <div class="col-sm-12 link-hover">
            <div class="dta1 key 1"><strong>Multiple G. Partner Id : </strong>
              <? foreach($data['SpoMultiple'] as $key=>$value){
					if($key){
					?>
					  <? if($post['MemberInfo']['sponsor']){ ?>
					  <a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['update_sub_admin_other_profile'])&&$_SESSION['update_sub_admin_other_profile']==1)){ ?> href="<?=$data['Admins'];?>/subadmin<?=$data['ex']?>?id=<?=$key;?>" target="_blank" <? } ?> class="flagtg btn btn-primary"><?=$value;?></a>
              <? }}} ?>
            </div>
          </div>
          <? } ?>
          
		<?
		$m_json_data=(json_decode($post['MemberInfo']['json_value'], 1));
		?>  
	<div class="row row-cols-1 row-cols-md-2 text-center" id="mdt">
      
      <div class="col">
        <div class="card  rounded-3 shadow-sm border-primary">
          <div class="card-header py-3 text-white bg-primary border-primary">
            <h3 class="my-0 fw-2 fs-6 text-white">Business Information</h3>
          </div>
          <div class="card-body">
                 <div class="row">
			
				<div class="col-sm-4 text-start">Name</div>
				<div class="col-sm-8 text-start">: <?=$post['MemberInfo']['company_name']?></div>
				  
				  
				<div class="col-sm-4 text-start">Address</div>
				<div class="col-sm-8 text-start text-truncate" title="<?=$post['MemberInfo']['business_address']?>">: <?=$post['MemberInfo']['business_address']?></div>
				
				<div class="col-sm-4 text-start">Contact</div>
				<div class="col-sm-8 text-start">: <?=$m_json_data['business_contact']?></div>
				
				<div class="col-sm-4 text-start">IM’S </div>
				<div class="col-sm-8 text-start">: <?=$m_json_data['business_ims']?> <?=get_ims_icon($m_json_data['business_ims_type']); ?></div>
				
				<div class="col-sm-4 text-start">Email </div>
				<div class="col-sm-8 text-start">: <?=encrypts_decrypts_emails($post['MemberInfo']['email'],2,true, array(4,$post['MemberInfo']['id']));?><i class="<?=$data['fwicon']['primary'];?> text-success mx-2 fa-lg" title="Primary"></i></div>
				 
				 </div> 
          </div>
        </div>
      </div>
	  
      <div class="col">
        <div class="card rounded-3 shadow-sm border-primary">
          <div class="card-header py-3 text-white bg-primary border-primary">
            <h3 class="my-0 fw-2 fs-6 text-white">SPOC Information</h3>
          </div>
          <div class="card-body">
                 <div class="row">
				 <?
				$fullname = '';
				if(isset($post['MemberInfo']['fullname'])&&$post['MemberInfo']['fullname']){
					$fullname = prntext($post['MemberInfo']['fullname']);
				}
				else
				{
					if(isset($post['MemberInfo']['fname'])) $fullname	= prntext($post['MemberInfo']['fname']);
					if(isset($post['MemberInfo']['lname'])) $fullname.= " ".prntext($post['MemberInfo']['lname']);
					
					$fullname = trim($fullname);
				}
				
				?>
			
				<div class="col-sm-4 text-start">Name</div>
				<div class="col-sm-8 text-start">: <?=$fullname;?></div>
				  
				<div class="col-sm-4 text-start">Designation</div>
				<div class="col-sm-8 text-start">: <?=$m_json_data['designation']?> </div>
				
				<div class="col-sm-4 text-start">Contact</div>
				<div class="col-sm-8 text-start">: <?=$post['MemberInfo']['phone']?></div>
				
				<div class="col-sm-4 text-start">IM’S</div>
				<div class="col-sm-8 text-start">: <?=$m_json_data['merchant_ims']?> <?=get_ims_icon($m_json_data['merchant_ims_type']); ?></div>
				<div class="col-sm-4 text-start">Email </div>
				<div class="col-sm-8 text-start row">
				<div class="col-sm-9">
		 <? if($post['MemberInfo']['emails']){ ?>
		 
          <? $i=1;foreach($post['MemberInfo']['emails'] as $key=>$val){
		  $bgcolor=($key+1)%2?'#EEEEEE':'#E7E7E7';
		  $decrypte_email = encrypts_decrypts_emails($val['email'],2,true, array(5,$val['id']));
		  if($i > 2){ $email_hide="email_hide hide"; }
		  ?>
		  <span class="row <?=$email_hide;?>" id="mdt">
		  
		  <div class="col-sm-8">
		   <? if($val['primary']!=1){ ?>
            <?=$decrypte_email;?>
            <? } ?>
		  </div>
		  
		  <div class="col-sm-4 text-end px-2">
            <? if($val['primary']!=1){ ?>
             <? if((!isset($_SESSION['sub_admin_id']))||($_SESSION['sub_admin_id']&&$_SESSION['access_roles']['merchant_action_status_action']==1)){?>
            <? if($val['active']==1){ ?>
            <a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_add_email'])&&$_SESSION['clients_add_email']==1)){?> href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<?=(isset($post['MemberInfo']['id'])?$post['MemberInfo']['id']:'')?><? if(isset($val['id'])) echo '&bid='.$val['id'];?>&action=setdefault&type=<? if(isset($post['type'])) echo $post['type']?>&page=<? if(isset($post['StartPage'])) echo $post['StartPage'];?>" <? }?>  title="Set To Primary"><i class="<?=$data['fwicon']['primary'];?> text-info"></i></a>
            <? }elseif($val['active']==0){ ?>
            <a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_add_email'])&&$_SESSION['clients_add_email']==1)){ ?> href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<? if(isset($post['MemberInfo']['id'])) echo $post['MemberInfo']['id']?>&bid=<? if(isset($val['id'])) echo $val['id']?>&action=sendemail&type=<? if(isset($post['type'])) echo $post['type']?>&page=<? if(isset($post['StartPage'])) echo $post['StartPage']?>" <? } ?> title="Verify"><i class="<?=$data['fwicon']['primary'];?> text-danger"></i></a>
            <? } ?>
            <a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_add_email'])&&$_SESSION['clients_add_email']==1)){?> href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<? if(isset($post['MemberInfo']['id'])) echo $post['MemberInfo']['id']?>&bid=<? if(isset($val['id'])) echo $val['id']?>&action=delemail&type=<? if(isset($post['type'])) echo $post['type']?>&page=<? if(isset($post['StartPage'])) echo $post['StartPage']?>" onClick="return confirm('Are you Sure to DELETE this')" <? } ?> title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger"></i></a>
			
			<? if(isset($val['json_log_history'])&&$val['json_log_history']){?>
			<i class="<?=$data['fwicon']['circle-info'];?> text-info fa-fw" 
			onclick="popup_openv('<?=$data['Host']?>/include/json_log<?=$data['ex']?>?tableid=<?=$val['id'];?>&tablename=clients_emails')" title="View Json History"></i>
			<? } ?>
			
            <? }else{ ?>
            <? }} ?>
          
		  
		  </div>
           </span>
          <? $i++; } ?>
          <? } ?>
				
			</div>
						<div class="col-sm-3 text-end"> 
							<i class="<?=$data['fwicon']['email'];?>" title="View Email/s" id="email_toggle"></i>
							<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_add_email'])&&$_SESSION['clients_add_email']==1&&(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))){ 
							?>
							<a href="<?=$data['USER_FOLDER']?>/emails<?=$data['ex']?>?id=<?=$_GET['id']?>&admin=1" class="float-end modal_for_iframe" title="Add More Email"><i class="<?=$data['fwicon']['circle-plus'];?> mx-1"></i></a>
							<? }
							?>  
						</div>
					</div>
				</div> 
			</div>
		</div>
	</div>
</div>
          
		  
		  
		  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_risk_ratio_bar'])&&$_SESSION['clients_risk_ratio_bar']==1)){ ?>
          <div class="col-sm-12 my-2"> 
		  <div class="border border-2 rounded mx-1 row s_section_merchant p-2">
            <div class="col-sm-12 px-0"><a class="restartfa fw-bold" onClick="ajaxf1(this,'<?=$data['Host']?>/include/ratio_admin<?=$data['ex'];?>?gid=<?=$post['gid'];?>&sponsor=<?=$post['MemberInfo']['sponsor'];?>&dtrange=5','#risk_ratio_id_admin')" >Ratio Realtime <i class="<?=$data['fwicon']['arrow-rotate-right'];?>"></i></a> </div>
            <div class="col-sm-12">
              <div>
                <form class="" name="ratio_search_bar" id="ratio_sb" action="<?=$data['Host']?>/include/ratio_admin<?=$data['ex'];?>?gid=<?=$post['gid'];?>&sponsor=<?=$post['MemberInfo']['sponsor'];?>&dtrange=1" target="modal_popup3_frame" method="GET" >
					<?=((isset($data['is_admin_input_hide'])&&$data['is_admin_input_hide'])?$data['is_admin_input_hide']:'');?>
                  <input type="hidden" name="gid" value="<?=$post['gid'];?>" />
                  <input type="hidden" name="sponsor" value="<?=$post['MemberInfo']['sponsor'];?>" />
                  <input type="hidden" name="dtrange" value="2" />
                  <div class="row" id="chosenv">
                    <div class="col-sm-6 my-2  px-1">
                      <select id="ratio_ccard_types_id" data-placeholder="Card Types" title="Card Types" multiple class="chosen-select chosen-select1 form-select" name="ratio_ccard_types[]" style="height:28px;">
                        <option value="visa">Visa</option>
                        <option value="mastercard">MasterCard</option>
                        <option value="discover">Discover</option>
                        <option value="jcb">JCB</option>
                        <option value="amex">AMEX</option>
                        <? if($data['con_name']=='clk'){ ?>
                        <option value="rupay">RuPay</option>
                        <? } ?>
                      </select>
                    </div>
                 
                    <div class="col-sm-6 row my-2 px-1 input-icons ">
                     
						<!-------------------------------------------------->
				<?
				    $ratio_period="15"; 
					$ratio_date_1=date("Y-m-d 00:00:00");
					$ratio_date_2=date("Y-m-d 23:59:59", strtotime(" + $ratio_period day"));
					
					$ratio_time_period = $ratio_date_1.' to '.$ratio_date_2;
				?>
				<i class="<?=$data['fwicon']['calender'];?> cals fs-2x text-link" style="width:30px; z-index:1;" ></i>
				<input type="text" class="form-control" id="ratio_time_period" name="ratio_time_period" placeholder="Inactive Start Time" value="<? if(isset($ratio_time_period)) echo $ratio_time_period;?>" style="padding-left: 30px;
    position: relative;width:calc(100% - 45px);" />	
				<input type="hidden" class="form-control" name="date_1st" id="ratio_date_1st" value="<?=$ratio_date_1;?>" />
                <input type="hidden" class="form-control" name="date_2nd" id="ratio_date_2nd" value="<?=$ratio_date_2;?>" />	
						<!-------------------------------------------------->
				<button class="input_s btn btn-primary ms-1" type="submit" id="ratio_submit" name="ratio_submit" style="width:38px;"><i class="<?=$data['fwicon']['search'];?> text-link" ></i></button>
						
                    </div>
                    
                  </div>
                </form>
                <div class="" id="ratio_search_bar_result" style="position: relative;">
                  <!--float:left;width:inherit; -->
                </div>
               <script>
			ajaxf2_id=$('#ratio_search_bar_result');
			const textInput_ratio_input = document.querySelector('.text_df_ratio_input_1');

			const dateInput_ratio_input = document.querySelector('.df_ratio_input_1');
			dateInput_ratio_input.addEventListener('change', event => {
			  textInput_ratio_input.value = event.target.value+'T00:00:00';
			  //event.target.value = '';
			});
			const textInput2_ratio_input = document.querySelector('.text_dt_ratio_input_2');
			const dateInput2_ratio_input = document.querySelector('.dt_ratio_input_2');
			dateInput2_ratio_input.addEventListener('change', event => {
			  textInput2_ratio_input.value = event.target.value+'T23:59:59';
			  //event.target.value = '';
			});
			
			$("#ratio_ccard_types_id").chosen({
			  no_results_text: "Oops, nothing found!"
			});	
			
		  </script>
                <div class="ratio_ro"> </div>
                <span id="risk_ratio_id_admin"></span> 
				</div>
            </div>
          </div>
		  </div>
          <? } ?>
		  <?
		############### Hide for subadmin if not in roll -- add by  on 31122
		if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
		{
		?>
		<div class="container my-2 row">  
		  <h5 class="my-2"><i class="<?=$data['fwicon']['fees'];?>"></i> Fees : </h5>
		  <div class="clearfix"></div>
         
		  
          <? if($post['MemberInfo']['default_currency']){ ?>
          <div class="col-sm-4 my-2 px-2 card"> <strong>Account Currency : </strong>
            <?=$post['MemberInfo']['default_currency']?>
          </div>
          <? }if($post['MemberInfo']['settlement_fixed_fee']){ ?>
          <div class="col-sm-4 my-2 px-2 card"> <strong>Wire fee :</strong>
            <?=$post['MemberInfo']['settlement_fixed_fee']?>
          </div>
          <? }if($post['MemberInfo']['settlement_min_amt']){ ?>
          <div class="col-sm-4 my-2 px-2 card"> <strong>Withdraw Min. Amt. :</strong>
            <?=$post['MemberInfo']['settlement_min_amt']?>
          </div>
          <? }if($post['MemberInfo']['withdraw_max_amt']){ ?>
          <div class="col-sm-4 my-2 px-2 card"><strong>Withdraw Max. Amt. : </strong>
            <?=$post['MemberInfo']['withdraw_max_amt']?>
          </div>
          <? }if($post['MemberInfo']['monthly_fee']){ ?>
          <div class="col-sm-4 my-2 px-2 card"> <strong> Monthly Fee :</strong>
            <?=$post['MemberInfo']['monthly_fee']?>
          </div>
          <? } ?>
          
          <? if($post['MemberInfo']['frozen_balance']){ ?>
          <div class="col-sm-4 my-2 px-2 card"> <strong>Frozen Balance :</strong>
            <?=$post['MemberInfo']['frozen_balance']?>
            % of Rolling Balance</div>
          <? }?>
		  
		   <? if($post['MemberInfo']['description']){ ?>
          <div class="col-sm-12 my-2 px-2 card"> <strong>Description :</strong>
            <?=$post['MemberInfo']['description']?></div>
          <? }?>
         </div>
		  <div class=" my-2 row">  
			<div id="displresult"></div>
			<? //if($m_json_data['request_funds']==1){?>
				<div class="col"> 
				<div class="px-2 mb-1 btn btn-outline-primary text-white w-100">
				<strong class="float-start">Request Funds :</strong>
				<span class="form-check form-switch float-end">
<input type="checkbox" name="request_funds_main" vdata="request_funds" id="request_funds_main"  class="form-check-input update_merchant_profile" <? if($m_json_data['request_funds']==1){ ?> checked="checked" title="Enable" value="1" <? } else { ?> title="Disable" value="0"  <? } ?> /></span>

			   </div>
			   </div>
			<? //} ?>
			
			<? //if($m_json_data['vt']==1){?>
				<div class="col"> 
				<div class="px-2 mb-1 btn btn-outline-primary text-white w-100">
				<strong class="float-start">MOTO :</strong><span class="form-check form-switch float-end">
<input type="checkbox" name="vt_main" id="vt_main" vdata="vt"  class="form-check-input update_merchant_profile" <? if($m_json_data['vt']==1){ ?> checked="checked" title="Enable" value="1" <? } else{ ?> title="Disable" value="0"  <? } ?> /></span>

				</div>
				</div>
			<? //} ?>
			
			<? 

			
			if((isset($data['QRCODE_GATEWAY_DB'])&&$data['QRCODE_GATEWAY_DB'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['show_qr_request'])&&$_SESSION['show_qr_request']==1)))
			{
			?>
				<div class="col"> 
				<div class="px-2 mb-1 btn btn-outline-primary text-white w-100">
				<strong class="float-start text-start w100_mob"><?=$data['SOFT_POS_LABELS']?> : </strong>
				
				
				<span class="form-check form-switch float-end mx-1">
				Inactive <input type="checkbox" name="qrcode_gateway_request_main" vdata="qrcode_gateway_request"  class="form-check-input update_merchant_profile q_inactive" <? if($post['MemberInfo']['qrcode_gateway_request']!=1){ ?> checked="checked" <? } ?> value="3" title="Inactive" />
				</span>
				<? /*?><span class="form-check form-switch float-end mx-1">
				Test <input type="checkbox" name="qrcode_gateway_request_main" vdata="qrcode_gateway_request" class="form-check-input update_merchant_profile q_test" <? if($post['MemberInfo']['qrcode_gateway_request']==2){ ?> checked="checked"  <? } ?> value="2" title="Test"  />
				</span><? */?>
				<span class="form-check form-switch float-end mx-1">
				Live <input type="checkbox" name="qrcode_gateway_request_main"  vdata="qrcode_gateway_request" class="form-check-input update_merchant_profile q_live" <? if($post['MemberInfo']['qrcode_gateway_request']==1){ ?> checked="checked"    <? } ?>  value="1" title="Live"  />
				</span>

				</div>
				</div>
			<? } ?>
			
			<? 
			if((isset($data['PAYOUT_GATEWAY_DB'])&&$data['PAYOUT_GATEWAY_DB'])&&((isset($_SESSION['login_adm']))||(isset($_SESSION['show_payout_request'])&&$_SESSION['show_payout_request']==1))){
			?>
				<div class="col-4"> 
				<div class="px-2 mb-1 btn btn-outline-primary text-white w-100">
					<strong class="float-start text-start w100_mob"><?=$data['PAYOUT_LABELS']?> : (<span title="Fee"><?=$post['MemberInfo']['payoutFee']?> %</span>)</strong>
				
				
				<span class="form-check form-switch float-end mx-1">
				Inactive <input type="checkbox" name="payout_request_main" vdata="payout_request"  class="form-check-input update_merchant_profile v_inactive" <? if($post['MemberInfo']['payout_request']==3){ ?> checked="checked" <? } ?> value="3" title="Inactive" />
				</span>
				<span class="form-check form-switch float-end mx-1">
				Test <input type="checkbox" name="payout_request_main" vdata="payout_request" class="form-check-input update_merchant_profile v_test" <? if($post['MemberInfo']['payout_request']==2){ ?> checked="checked"  <? } ?> value="2" title="Test"  />
				</span>
				<span class="form-check form-switch float-end mx-1">
				Live <input type="checkbox" name="payout_request_main"  vdata="payout_request" class="form-check-input update_merchant_profile v_live" <? if($post['MemberInfo']['payout_request']==1){ ?> checked="checked"    <? } ?>  value="1" title="Live"  />
				</span>

				</div>
				</div>
			<? } ?>
			
		
			
          </div>
		  
		   <div class="row"  >
		    <?
			$id=$post['MemberInfo']['id'];
			spoc_view($id,true);
			?>
		   </div>
			
		<?
		}
		############### Hide for subadmin if not in roll	
		?>			
		  <div class="row" id="merchantidforcss" >
		  <div class="col-sm-6">
            <? if($post['MemberInfo']['last_ip']){ ?>
			<div class="col-sm-12">
            <div class=" my-2 row">
			  <h5 class="my-2 float-start w-50"><i class="<?=$data['fwicon']['last-access'];?>"></i> Last Access : </h5>
			  <div class="float-end text-end w-50"><? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_ip_history'])&&$_SESSION['clients_ip_history']==1)){ ?>
                  
                  <a href="<?=$data['Admins'];?>/history<?=$data['ex']?>?clients=<?=$post['MemberInfo']['id']?>" class="btn btn-primary btn-sm  modal_from_url" title="IP History"  target="_blank">IP History</a>
                  <? } ?></div>
		      <div class="clearfix"></div>
              <div class="row  my-2 fw-bold">
                <div class="col-sm-12 float-start"> 
				<i class="<?=$data['fwicon']['hand'];?>"></i> 
                  <?=prndate($post['MemberInfo']['ldate'])?>
                  <? if($post['MemberInfo']['last_ip']){ ?>
                  (From IP:
                  <?=$post['MemberInfo']['last_ip']?>
                  )
                  <? } ?>
                </div>
                
              </div>
            </div>
			</div>
            <? } ?>
			</div>
			
			<div class="col-sm-6">
						<? if(((isset($_SESSION['login_adm']))||(isset($_SESSION['deleted_email'])&&$_SESSION['deleted_email']==1))&&($post['MemberInfo']['deleted_email'])){ ?>
		
		
		<div class="container text-end">
		
		<div class="float-end ">
		<button class="btn btn-primary btn-sm my-2  nomid" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample" onClick="ajaxf1(this, '<?=$data['Admins'].'/check-email'.$data['ex'].'?id='.$post['MemberInfo']['id'].'&deletedmail=1';?>', '#alldelete_email', 1,2);" > Deleted Email/(s) </button> 
		
		<div class="float-end mx-2"><a data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=clients_emails&clientid=<?=$post['MemberInfo']['id'];?>" title="View Deleted Email Json Log History" onclick="iframe_open_modal(this);" ><i class="<?=$data['fwicon']['circle-info'];?> text-danger my-2 fa-2x"></i></a></div>
		
		<div class="collapse col-sm-12 border  rounded" id="collapseExample">
              <div class="m-2 text-break text-start font-monospace">
				<div id="alldelete_email"></div>
              </div>
            </div>
		</div>	
	
		</div>
         <? } ?>
			
			</div>
			
			</div>
			 <? if(isset($post['MemberInfo']['json_log_history'])&&$post['MemberInfo']['json_log_history']){?>
			 <div class="row my-2">
              <div style="width:100%;float:left;clear:both; overflow:hidden;"> <? echo json_log_view1($post['MemberInfo']['json_log_history']);?> </div>
			  </div>
            <? } ?>
			



          
        </div>
      </div>
    </div>
    <? } ?>
    <!-- start 2 Point-->
	
    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_principal_profile'])&&$_SESSION['merchant_action_add_principal_profile']==1)){
	
		?>
		<div class="collapsible-content clearfix">
		  <div id="collapsible2_html" class="content-inner99 table-responsive11 hide6">
			<div class="row px-0">
			  <div class="col-sm-12 my-2"> <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=insert_principal&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-primary float-end" title="Add SPOC" ><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a> </div>
			  <div class="col-sm-12 ps-0" >
				<div id="add_partners_html" class="row">
				
				<?
				if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
				{ 
					$id=$post['MemberInfo']['id'];
					spoc_view($id,true);
				}
				else
				{
					include('../oops'.$data['iex']);
				}
				?>
				  <!--// Modal popup open on onclick css verify_input-->
				</div>
			  </div>
			  <!--<div class="col-sm-12 mb-2"> <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=insert_principal&type=<?=@$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-icon btn-primary float-end me-2" ><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add Principal</a> </div>-->
			</div>
		  </div>
		</div>
		<? 
		
	} ?>
	
    <!-- start 8 Point-->
    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['m_withdrawal'])&&$_SESSION['m_withdrawal']==1)){ ?>
    <div class="collapsible-content">
      <div id="collapsible8_html" class="content-inner hide" style="padding:0 1px 0 0;margin:0;">
	  
        <iframe src="../images/loader.gif" name="iframe_withdrawal" id="iframe_withdrawal"frameborder="0" marginwidth="0" marginheight="0" class="iframe_withdrawal" width="100%" height="600"></iframe>
      </div>
    </div>
    <? } ?>
    <!-- start 3 Point-->
    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_store_view'])&&$_SESSION['clients_store_view']==1)){ ?>
    <div class="collapsible-content">
      <div id="collapsible3_html" class="content-inner-for-remove"> </div>
      <!-- end 3 Point-->
    </div>
    <? } ?>
    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_add_account'])&&$_SESSION['merchant_action_add_account']==1)){ ?>
    <div class="collapsible-content">
      <div id="collapsible6_html" class="content-inner99"> </div>
      <!-- end 6 point-->
    </div>
    <? } ?>
    <!-- start 7 point-->
    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_bank_account'])&&$_SESSION['merchant_action_bank_account']==1)){ ?>
    
	
    <div class="collapsible-content">
      <div id="collapsible7_html" class="content-inner99"> </div>
      <!--End 7 Point-->
    </div>
    <? } ?>
    <!-- start 8 point-->
    <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_bank_account_list_delete'])&&$_SESSION['merchant_action_bank_account_list_delete']==1)){ ?>
    <div class="collapsible-content">
      <div id="collapsible10_html" class="content-inner"> </div>
      <!--End 7 Point-->
    </div>
    <? } ?>
  </div>
  <!--MKS-->
  <? }elseif($post['action']=='insert'||$post['action']=='update'){

	if(($post['action']=='insert')&&(isset($_SESSION['login_adm']))){
		//$post['sponsor']=""; $data['Sponsors']=""; $data['SpoMultiple']="";
	}
	
  ?>
  <? if(!$post['PostSent']){ ?>
  <?
if(!$_SESSION['login_adm']&&!$_SESSION['merchant_action_edit']){
	echo('Opps ACCESS DENIED.');
	exit;
}
?>
  <script>
//$('.advSdiv').hide();
</script>
  <div class="table-responsive">
    <h4 class="my-2">
      <? if($post['action']=='insert'){ ?>
      <i class="<?=$data['fwicon']['user-plus'];?>"></i> Create New Merchant
      <? }else{ ?>
      <i class="<?=$data['fwicon']['edit'];?>"></i> Modify Merchant Information
      <? }  ?>
    </h4>
    
   <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? } ?>
	
    <form id="form1" method="post" enctype="multipart/form-data">
	<?=((isset($data['is_admin_input_hide'])&&$data['is_admin_input_hide'])?$data['is_admin_input_hide']:'');?>
      <input type="hidden" name="tab_name" value="collapsible1">
<input type="hidden" name="action" value="<?=(isset($post['action'])?$post['action']:'')?>">
<input type="hidden" name="gid" value="<?=(isset($post['id'])?$post['id']:'')?>">
<input type="hidden" name="type" value="<?=(isset($post['type'])?$post['type']:'')?>">
<input type="hidden" name="StartPage" value="<?=(isset($post['StartPage'])?$post['StartPage']:'')?>">
      <div class="row mx-1">
        <div class="row-fluid ps-0">
          <div class="span12">
            <div class="bg_div1 row mt-1 ps-1">
              <div class="input_col_2 row vkg my-2 ps-0">
                <h6> MID :<?=(isset($post['id'])?$post['id']:'')?></h6>
                
                <? if((isset($_SESSION['adm_login'])&&$_SESSION['adm_login'])){ ?>
                <? if($post['action']=='update'){ ?>
                <div style="float:left;clear:both;width:100%;;">
                  <? foreach($data['SpoMultiple'] as $key=>$value){
						if($key){
						?>
                  <a href="<?=$key;?>" class="flagtg btn btn-primary">
                  <?=$value;?>
                  </a>
                  <? }} ?>
                </div>
                <? } ?>
                <? $styleBlock=''; if($post['action']=='insert'){ $styleBlock='display:block';?>
                <? } ?>
                <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['addNew_GatewayId'])&&$_SESSION['addNew_GatewayId']==1)){ ?>
                <div class="col-sm-6">
                  <label for="sponsors">Gateway Id</label>
                  <input type="text" class="form-control w-100" id="sponsorsNam" list="sponsors" name="sponsor" value="<?php if(isset($post['sponsor'])){ echo $post['sponsor'];}?>">
                </div>
                <datalist id="sponsors">
                  <?=showselect($data['Sponsors'], (isset($post['sponsor'])?$post['sponsor']:0))?>
                </datalist>
                <? if($post['action']=='insert'){ ?>
                <script>
				var sponsorsVar='<?=(isset($post['sponsor'])&&$post['sponsor']?$post['sponsor']:(isset($_SESSION['domain_server']['sub_id'])?$_SESSION['domain_server']['sub_id']:''));?>';
							//alert(sponsorsVar);
							if(sponsorsVar !='' ){
								$("#sponsorsNam").val(sponsorsVar).trigger("chosen:updated");
							}
						  </script>
                <? } ?>
                <? }elseif(($post['action']=='insert')&&(!isset($_SESSION['login_adm']))){ ?>
                <input name="sponsor" class="form-control w-100" type="text" value="<?=($post['sponsor']?$post['sponsor']:$_SESSION['domain_server']['sub_id']);?>" style='display:none;'>
                <? } ?>
                <?
					
					if($data['con_name']=='clk'){
						$settlement_fixed_fee='1';
						$settlement_min_amt='1';
						$monthly_fee='1';
						$withdraw_max_amt='20000';
						$frozen_balance='100';
						$gst_fee='18.00';
					}else{
						$settlement_fixed_fee='100';
						$settlement_min_amt='5000';
						$monthly_fee='350';
						$withdraw_max_amt='20000';
						$frozen_balance='100';
						$gst_fee='0.00';
						
					}
					
					
					
					
					if(isset($data['domain_server']['as']['withdraw_max_amt'])&&$data['domain_server']['as']['withdraw_max_amt']){
						$withdraw_max_amt=$data['domain_server']['as']['withdraw_max_amt'];
					}
					if(isset($data['domain_server']['as']['monthly_fee'])&&$data['domain_server']['as']['monthly_fee']){
						$monthly_fee=$data['domain_server']['as']['monthly_fee'];
					}
					if(isset($data['domain_server']['as']['settlement_fixed_fee'])&&$data['domain_server']['as']['settlement_fixed_fee']){
						$settlement_fixed_fee=$data['domain_server']['as']['settlement_fixed_fee'];
					}
					if(isset($data['domain_server']['as']['settlement_min_amt'])&&$data['domain_server']['as']['settlement_min_amt']){
						$settlement_min_amt=$data['domain_server']['as']['settlement_min_amt'];
					}
					
					if(isset($data['domain_server']['as']['frozen_balance'])&&$data['domain_server']['as']['frozen_balance']){
						$frozen_balance=$data['domain_server']['as']['frozen_balance'];
					}
					if(isset($data['domain_server']['as']['gst_fee'])&&$data['domain_server']['as']['gst_fee']){
						$gst_fee=$data['domain_server']['as']['gst_fee'];
						if($post['action']=='insert'){
							$post['gst_fee']=$gst_fee;
						}
					}
					
					
					?>
                <div class="col-sm-6">
                  <label for="settlement_fixed_fee">Wire fee</label>
                  <input type="text" name="settlement_fixed_fee" id="settlement_fixed_fee" class="form-control w-100" value="<?php if(isset($post['settlement_fixed_fee'])&&$post['settlement_fixed_fee']){echo $post['settlement_fixed_fee'];}else{echo $settlement_fixed_fee;}?>"  />
                </div>
                <div class="col-sm-6">
                  <label for="settlement_min_amt" class="w-100">Withdraw Min. Amt.</label>
                  <input type="text" name="settlement_min_amt" id="settlement_min_amt" class="form-control w-100" value="<?php if(isset($post['settlement_min_amt'])&&$post['settlement_min_amt']){echo $post['settlement_min_amt'];}else{echo $settlement_min_amt;}?>"  />
                </div>
                <div class="col-sm-6">
                  <label for="monthly_fee">Monthly Fee</label>
                  <input type="text" name="monthly_fee" id="monthly_fee" class="form-control w-100" value="<?=(isset($post['monthly_fee'])&&$post['monthly_fee']?$post['monthly_fee']:$monthly_fee);?>"  />
                </div>
                <div class="col-sm-6">
                  <label for="withdraw_max_amt" class="w-100">Withdraw Max. Amt.</label>
                  <input type="text" name="withdraw_max_amt" id="withdraw_max_amt" class="form-control w-100" value="<?php if(isset($post['withdraw_max_amt'])&&$post['withdraw_max_amt']){echo $post['withdraw_max_amt'];}else{echo $withdraw_max_amt;}?>"  />
                </div>
                <div class="col-sm-6">
                  <label for="frozen_balance">Frozen Balance</label>
                  <div class="input-group mb-2">
                    <input type="text" name="frozen_balance" id="frozen_balance" class="form-control " value="<?php if(isset($post['frozen_balance'])&&$post['frozen_balance']){echo $post['frozen_balance'];}else{echo $frozen_balance;}?>"   />
                    <span class="input-group-text" id="basic-addon1">&nbsp;%&nbsp;of&nbsp;Rolling&nbsp;Balance</span>
                      <? 
					if(isset($post['gst_fee']))
						$post['gst_fee']=number_formatf_2(stf($post['gst_fee']));
					else
						$post['gst_fee']='0.00';
					?>
                    </span> </div>
                </div>
				
				
				
				
				
<?
	if(isset($data['QRCODE_GATEWAY_DB'])&&$data['QRCODE_GATEWAY_DB'])
	{
		$qrcode_gateway_input=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.qrcode_gateway_mer_profile_admin".$data['iex']);
		if(file_exists($qrcode_gateway_input)){
			include($qrcode_gateway_input);
		}else{
			$qrcode_gateway_input=($data['Path']."/{$data['SOFT_POS_PATH']}/template.qrcode_gateway_mer_profile_admin".$data['iex']);
			if(file_exists($qrcode_gateway_input)){
				include($qrcode_gateway_input);
			}
		}
	}
?>
				
				<div class="col">
				
				 <label for="request_funds">Request Funds</label>
				
             <select name="request_funds" id="request_funds" required="required" class="form-select w-100">
                    <option value="1">Enable</option>
                    <option value="0" selected="selected">Disable</option>
                  </select>
                 <?
				if(isset($post['request_funds']))
				{
				?>
                <script>$('#request_funds option[value="<?=$post['request_funds']?>"]').prop('selected','selected');</script>
				<?
				}?> 
				</div>
				<div class="col">
				<label for="vtid">MOTO</label>
                <select name="vt" id="vt" required="required" class="form-select w-100">
                    <option value="1">Enable</option>
                    <option value="0" selected="selected">Disable</option>
                  </select>
                 <?
				if(isset($post['vt']))
				{
				?>
                <script>$('#vt option[value="<?=$post['vt']?>"]').prop('selected','selected');</script>
				<?
				}?> 
				</div>
				<?/*?>
				<div class="col-sm-4">
                  <label for="gst_fee" style="clear:left;">GST Fee</label>
				  <div class="input-group mb-2">
                  <input type="text" name="gst_fee" id="gst_fee" class="form-control"  value="<?php if(isset($post['gst_fee'])&&$post['gst_fee']){echo number_formatf_2(stf($post['gst_fee']));}else{echo number_formatf_2(stf($gst_fee));}?>"   />
                  <span class="input-group-text" id="basic-addon1">&nbsp;%&nbsp;</span> 
				  
				  </div>
				</div>
				<?*/?>
				
				
			
<?
if(isset($data['PAYOUT_GATEWAY_DB'])&&$data['PAYOUT_GATEWAY_DB'])
{
	$payout_link=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.mer_profile_admin".$data['iex']);
	if(file_exists($payout_link)){
		include($payout_link);
	}else{
		$payout_link=($data['Path']."/payout/template.mer_profile_admin".$data['iex']);
		if(file_exists($payout_link)){
			include($payout_link);
		}
	}
}
?>

                <? if($post['action']=='update'){ ?>
                <div class="radios hide">
                  <label for="withdraw_option">Withdraw Option</label>
                  <input required="required" type="radio" name="withdraw_option" id="realTimeWithdraw" class="withdraw_option" value="1" <? if(isset($post['withdraw_option'])&&$post['withdraw_option']==1){echo "checked";}?>  />
                  <label for="realTimeWithdraw" style="float:left;margin:12px 30px 0 0;width:auto;">Real Time Withdraw</label>
                  <input required="required" type="radio" name="withdraw_option" id="payoutDateWiseWithdraw" class="withdraw_option " value="2" <? if(($post['withdraw_option']==2)){echo "checked";}?> />
                  <label for="payoutDateWiseWithdraw" style="float:left;margin:12px 30px 0 0;width:auto;">Payout Date Wise Withdraw</label>
                </div>
                <? } ?>
                <div class="hide row">
                  <div class="col-sm-6">
                    <label for="settled_amt" >Min Sattelment Amt.</label>
                    <input type="text" name="settled_amt" id="settled_amt" class="form-control w-100" value="<?php if(isset($post['settled_amt'])&&$post['settled_amt']){echo $post['settled_amt'];}else{echo "0";}?>"  />
                  </div>
                  <div class="col-sm-6">
                    <label for="withdraw_period">Rolling Withdraw Period after </label>
                    <div class="input-group mb-2">
                      <select  name="withdraw_period" id="withdraw_period" title="Withdraw Period" class="form-select w-100" >
                        <option value="180" selected>180</option>
                        <option value="90">90</option>
                        <option value="120">120</option>
                        <option value="210">210</option>
                        <option value="270">270</option>
                        <option value="360">360</option>
                      </select>
                      <span class="input-group-text" id="basic-addon1">Days</span>
                     <?
					if(isset($post['withdraw_period']))
					{
					?>
                    <script>$('#withdraw_period option[value="<?=$post['withdraw_period']?>"]').prop('selected','selected');</script>
					<?
					}
					?>
                    </div>
                    <? } ?>
                  </div>
                </div>
              </div>
            </div>

            <div class="bg_div1 row">
              <p align="center"><img src="<?php echo $data['Host'];?>/images/loader.gif" id="loaderIcon" style="display:none" /></p>
              <div class="input_col_2 row ps-1">
			  <div class="col-sm-12">
			  <div id="user-availability-status"></div>
			  </div>
                <div class="col-sm-6">
                  <label for="username">Username: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i> <span data-bs-toggle="tooltip" title="" data-bs-original-title="Username should be unique and can not change"><i class="<?=$data['fwicon']['circle-info'];?>" style="font-size:8px;"></i></span></label>
				  
<input type="hidden" name="username_old" id="username_old" value="<?=(isset($post['username'])?$post['username']:'');?>" />

<input type="text" name="username" id="username" class="form-control w-100 usrnam" value="<?=(isset($post['username'])?$post['username']:'');?>" required="required"  onBlur="checkAvailability('user')" pattern="[a-z0-9]+" maxlength="10" autocomplete="off" />
				
                </div>
                <div class="col-sm-6">
                  <label for="email" class="w-100">Primary Email Address: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
                  <input type="text" name="email" id="email" class="form-control w-100" value="<?
				  if(isset($post['action'])&&$post['action']=='insert') echo $post['email'];
				  else echo (isset($post['email'])?encrypts_decrypts_emails($post['email'],2,1):'');?>"  required="required" />
                </div>

                <div class="col-sm-6">
                  <label for="edit_permission">Profile Status: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i> <span data-bs-toggle="tooltip" title="" data-bs-original-title="Disable: Merchant can not edit profile"><i class="<?=$data['fwicon']['circle-info'];?>" style="font-size:8px;"></i></span> </label>
                  <select name="edit_permission" id="edit_permission" required="required" class="form-select w-100">
                    <option value="2">Un-approved</option>
                    <option value="1">Approved</option>
                  </select>
                <?
				if(isset($post['edit_permission'])) 
				{
				?>
                <script>$('#edit_permission option[value="<?=$post['edit_permission']?>"]').prop('selected','selected');</script>
                <?
				}?>                </div>
                <div class="col-sm-6">
                  <label for="default_currency" class="w-100">Account Currency: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
                  <select name="default_currency" id="default_currency" placeholder="Account Currency" required="required" class="form-select w-100">
					<?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
						<option value="<?=$k11?>"><?=$k11?></option>
					<?}?>
                  </select>
                </div>
                <? if(isset($data['domain_server']['as']['default_currency'])&&($data['domain_server']['as']['default_currency']&&$post['action']=='insert')){ ?>
                <script>$('#default_currency option[value="<?=($data['domain_server']['as']['default_currency']);?>"]').prop('selected','selected');</script>
                <? }elseif((!isset($post['default_currency'])||!$post['default_currency'])&&isset($data['con_name'])&&$data['con_name']=='clk'&&isset($post['action'])&&$post['action']=='insert'){?>
                <script>$('#default_currency option[value="INR"]').prop('selected','selected');</script>
                <? }elseif((!isset($post['default_currency'])||!$post['default_currency'])&&$post['action']=='insert'){?>
                <script>$('#default_currency option[value="USD"]').prop('selected','selected');</script>
                <? }else{ ?>
                <script>$('#default_currency option[value="<?=prntext($post['default_currency'])?>"]').prop('selected','selected');</script>
                <? } ?>
                <div class="col-sm-6">
                  <label for="FirstName">Merchant’s Name: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
				  
				  <?
				$fullname = '';
				if(isset($post['fullname'])&&$post['fullname']) $fullname = prntext($post['fullname']);
				else
				{
					if(isset($post['fname'])) $fullname	= prntext($post['fname']);
					if(isset($post['lname'])) $fullname.= " ".prntext($post['lname']);
					
					$fullname = trim($fullname);
				}
				?>
                  <input type="text" name="fullname" class="form-control w-100" value="<?=$fullname?>" required="required" />
                 
                </div>
				<div class="col-sm-6">
                  <label for="FirstName">Designation: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
                  <input type="text" name="designation" class="form-control w-100" value="<? if(isset($post['designation'])) echo prntext($post['designation'])?>" required="required" />
                </div>
				

				

                <div class="col-sm-6">
                  <label for="Phone">Merchant’s Contact: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
                  <input type="text" name="phone" class="form-control w-100" value="<? if(isset($post['phone'])) echo prntext($post['phone'])?>"  required="required" />
                </div>
                <div class="col-sm-6 row px-0">
                  <label for="Phone">Merchant IM’S: </label>
				  <div class="col-sm-4"> 
						<select name="merchant_ims_type" id="merchant_ims_type" class="form-select" autocomplete="off">
						<option value="">Select IM’S Type</option>
						<option value="Skype">Skype</option>
						<option value="Telegram">Telegram</option>
						<option value="WhatsApp">WhatsApp</option>
						</select>
		   <? if(isset($post['merchant_ims_type'])){?>
           <script>
			$('#merchant_ims_type option[value="<?=prntext($post['merchant_ims_type'])?>"]').prop('selected','selected');
		   </script>
		   <? } ?>
						</div>
						
					   <div class="col-sm-8">
                  <input type="text" name="merchant_ims" class="form-control w-100" value="<? if(isset($post['merchant_ims'])) echo prntext($post['merchant_ims'])?>" style="background-position: 99% 50%;" />
                </div></div>
				

				
                <? if(isset($post['action'])&&$post['action']=="insertxxx"){?>
                <div class="col-sm-6">
                  <label title="2 Way Auth. Access" class="w-100">2 Way Auth. Access: </label>
                  <select name="google_auth_access" id="google_auth_access" data-rel="chosen" class="form-select w-100" >
                    <option value="">- 2 Way Auth. Yes/No -</option>
                    <option value="2">De-activate</option>
                    <option value="1">Activate</option>
                  </select>
                </div>
                <?
				if(isset($post['google_auth_access'])) 
				{
				?>
                <script>
                    $('#google_auth_access option[value="<?=prntext($post['google_auth_access'])?>"]').prop('selected','selected');
                </script>
                <?
				}
				 } ?>

                    <div class="col-sm-6">
                      <label for="CompanyName" class="w-100">Business Name: <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
<input type="text" name="company_name" class="form-control w-100" value="<? if(isset($post['company_name'])) echo prntext($post['company_name'])?>" required  />
                    </div>
					

					
                    <div class="col-sm-6">
                      
                        <label for="business_address" class="w-100">Business Address : <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
                        <input type="text" name="business_address" id="business_address_bs" class="form-control w-100 sml"  value="<?=(isset($post['business_address'])?$post['business_address']:'');?>"required />
                     
                      
                    </div>
					
					<div class="col-sm-6">
                      
                        <label for="business_address" class="w-100">Business Contact : <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></label>
                        <input type="text" name="business_contact" id="business_contact" class="form-control w-100 sml"  value="<?=(isset($post['business_contact'])?$post['business_contact']:'');?>" required/>
                     
                      
                    </div>
					
					<div class="col-sm-6 row px-0">
                      
                        <label for="business_address" class="w-100">Business IM’S :</label>
						
                        <div class="col-sm-4"> 
						<select name="business_ims_type" id="business_ims_type" class="form-select" autocomplete="off">
						<option value="">Select IM’S Type</option>
						<option value="Skype">Skype</option>
						<option value="Telegram">Telegram</option>
						<option value="WhatsApp">WhatsApp</option>
						</select>
		   <? if(isset($post['business_ims_type'])){?>
           <script>
			$('#business_ims_type option[value="<?=prntext($post['business_ims_type'])?>"]').prop('selected','selected');
		   </script>
		   <? } ?>
						</div>
						
					   <div class="col-sm-8"> <input type="text" name="business_ims" id="business_ims" class="form-control w-100 sml"  value="<?=(isset($post['business_ims'])?$post['business_ims']:'');?>" /></div>
                     
                      
                    </div>
					
                <div class="col-sm-12">
                  <label for="regnum">Add New Description: </label>
                  <textarea class="widget-body form-control w-100" name="description"></textarea>
				  <input type="hidden" name="description_history" value='<? if(isset($post['description'])) echo $post['description'];?>' />
				 <h2 class="my-2"><?=get_latest_description_data($post['description']);?></h2>
                </div>
                <div class="col-sm-12 my-2 text-center">
				  <button class="submit btn btn-primary" type="submit" name="send" value="Save Changes" ><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
				  
				  
                  &nbsp; <a href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?<? if(isset($_GET['id'])) echo 'id='.$_GET['id'].'&';?>&action=detail<?=($data['is_admin_link']);?>&tab_name=collapsible1" class="btn btn-primary"> <i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>
  <script>
function SameAddress(){
    if (document.getElementById('Same_Registered_Address').checked)
  { document.getElementById('business_address_bs').value=document.getElementById('registered_address_bs').value;}
}

function SameRegisteredAddress(){
    if (document.getElementById('Same_Registered_Address').checked){
	  document.getElementById('business_address_bs').value=document.getElementById('registered_address_bs').value;}
}

function UnCheckBox(){
	document.getElementById('Same_Registered_Address').checked=false;
}
  if ((document.getElementById('business_address_bs') != null) && (document.getElementById('registered_address_bs') != null) && ((document.getElementById('business_address_bs').value)==(document.getElementById('registered_address_bs').value)))
  {document.getElementById('Same_Registered_Address').checked=true;}
  else {document.getElementById('Same_Registered_Address').checked=false;}
</script>
  <? }else{ ?>
  All changes was stored in the database.
  <? if($post['action']=='insert'){ ?>
  <br>
  <br>
  Just created merchant has SUSPENDED status therefore you should change merchant status manually.
  <? } ?>
  <br>
  <br>
  <hr>
  <br>
  <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['id']?>&action=update&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">BACK</a> | <a href="<?=$data['Admins'];?>/index<?=$data['ex']?>">HOME</a>
  <? } ?>
  <? }elseif($post['action']=='insert_card'||$post['action']=='update_card'){	 if(!isset($_SESSION['login_adm'])){ echo $data['OppsAdmin']; exit; }	?>
  <? if(!$post['PostSent']){ ?>
  <div class="table-responsive">
    <form method="post">
	<?=((isset($data['is_admin_input_hide'])&&$data['is_admin_input_hide'])?$data['is_admin_input_hide']:'');?>
      <input type="hidden" name="action" value="<?=$post['action']?>">
      <input type="hidden" name="gid" value="<?=$post['gid']?>">
      <input type="hidden" name="bid" value="<?=$post['bid']?>">
      <input type="hidden" name="type" value="<?=$post['type']?>">
      <input type="hidden" name="StartPage" value="<?=$post['StartPage']?>">
      <div class="row bg-light">
        <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
          <?=prntext($data['Error'])?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <h5>
          <? if($post['action']=='insert'){ ?>
          Create New Card For Merchant
          <? }else{ ?>
          Modify Merchant Card
          <? } ?>
        </h5>
        <div class="col-sm-6">
          <label for="regnum">Card Type:</label>
          <select name="ctype" class="form-select w-100">
            <?=showselect($data['CreditCardType'], $post['ctype'])?>
          </select>
        </div>
        <div class="col-sm-6">
          <label for="regnum">Name Of Card:</label>
          <input type="text" name="cname" class="form-control w-100" value="<?=$post['cname']?>">
        </div>
        <div class="col-sm-6">
          <label for="regnum">Card Number:</label>
          <input type="text" name="cnumber" class="form-control w-100" value="<?=$post['cnumber']?>">
        </div>
        <div class="col-sm-6">
          <label for="regnum">AVS or CVV Code:</label>
          <input type="text" name=ccvv size=10 value="<?=$post['ccvv']?>">
        </div>
        <div class="col-sm-6">
          <label for="regnum">Expire Date MM/YYYY:</label>
          <select name="cmonth"  class="form-select w-100">
            <?=showselect($data['Months'], $post['cmonth'])?>
          </select>
          /
          <select name="cyear" style="min-width:35% !important; width:35% !important">
            <?=showselect($data['Years'], $post['cyear'])?>
          </select>
        </div>
        <div class="col-sm-12 my-2 text-center">
          <input  type="submit" name="cancel" class="btn btn-primary" value="Back">
          &nbsp;
          <input  type="submit" name="send" class="btn btn-primary" value="Save Changes">
        </div>
      </div>
    </form>
    <? }else{ ?>
    All changes was stored in the database.<br>
    <br>
    <hr>
    <br>
    <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&bid=<?=$post['bid']?>&action=update_card&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Back</a> | <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&action=detail&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Detail</a>
    <? } ?>
    <? }elseif($post['action']=='insert_bank'||$post['action']=='update_bank'){ 
  
		if(isset($_SESSION['uid_'.$post['gid']])){
			unset($_SESSION['uid_'.$post['gid']]);
		}
	  
		if(!$_SESSION['login_adm']&&!$_SESSION['merchant_action_bank_account']){
			echo $data['OppsAdmin'];
			exit;
		} 
		
		$buttonname="Add";
		$h4text="Add A New Bank Account";
		if(isset($post['bname'])&&$post['bname']=='Crypto Wallet'){
			$cryptoWallet=1;
			$post['coins_name']=$post['bswift'];
			$post['coins_network']=$post['brtgnum'];
			$post['coins_address']=$post['baccount'];
			$post['coins_wallet_provider']=$post['baddress'];
			
			//$post['bid']='';
			//unset($post['bid']);
			//$_GET['insertType']='Crypto Wallet';
		}
		else{$cryptoWallet=0;}
		
		if(isset($_GET['insertType']))
		{
			if($_GET['insertType']=='Crypto Wallet'||$post['bname']=='Crypto Wallet'){$cryptoWallet=1;}else{$cryptoWallet=0;}
		}
							
		if($post['action']=='update_bank'){
			$buttonname="Update";
			if($cryptoWallet==1){
				$h4text="Update your Crypto Wallet";
			}else{
				$h4text="Update your Bank Account";
			}
		}
		
  ?>
    <? if(!$post['PostSent']){ ?>
    <style>
	.glyphicons.single i::before{color:#000 !important;}
  </style>
    <script>
 $(document).ready(function(){
	$("input[type='radio'].bType").click(function(){
		$("input[name='bank']").prop('checked', false);
		if($(this).is(':checked')) {
			if($(this).val() == 'CryptoCurrency') {
				$("input[value='crypto']").trigger('click');
				$('#edit_bank_primary').attr("form","CryptoForm2"); 
				$('#typeBank').slideUp(500); $('#typeCrypto').slideDown(1000);
			}else{ 
				$('#edit_bank_primary').attr("form","bankForm1"); 
				$('#typeBank').show(1000); $('#typeCrypto').hide(500);
				
			}
		}
	});
	
	$("form").submit(function(){
		 $("#send").hide();
		 $("#back").hide();
	});
	
	<? if($data['con_name']=='clk'){ ?>
		$("#bankType_id").prop('checked', true).trigger('click');
	<? } ?>	
			
});
 </script>
        <div >
        <? if((isset($data['Error'])&& $data['Error'])){ ?>
        <div class="alert alert-danger alert-dismissible">
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        <strong>Error!</strong>
        <?=prntext($data['Error'])?>
        </div>
        <? }?>
	  
	  <div class="row">
	  <div class="col-sm-6 "><h4 class="my-2"><i class="<?=$data['fwicon']['bank'];?>"></i> <?=$h4text;?></h4></div>
	  <div class="col-sm-6 ">
	  
          <div class="my-2 float-end" style="width:40px;">
            <label for="edit_bank_primary" ><span data-bs-toggle="tooltip" title="" data-bs-original-title="Merchant is not allowed to Update Bank Information in Disable Mode"><i class="<?=$data['fwicon']['circle-info'];?> text-warning m-2 "></i></span></label>
          </div>
          <div class="my-2 y-2 float-end" style="width:calc(100% - 40px);max-width: 200px;">
            <select name="primary" class="form-select form-select-sm" id="edit_bank_primary" title="Select Permission" <?=((isset($buttonname)&&$buttonname=="Update"&&$cryptoWallet==1)?"form='CryptoForm2'":"form='bankForm1'")?> required >
              <option value="" selected="">Edit Permission</option>
              <option value="1">Un-Approved (Unlock the Data)</option>
              <option value="2">Approved (Lock the Data)</option>
            </select>
          
        </div>
		
		</div>
	  </div>
          
        
      <div class=" bg-primary text-white my-2 rounded " id="merchantaddbankforcss">
        
       
          <? if($buttonname=="Add"){ ?>
          <div class="bTypeDiv text-center my-1 d-flex justify-content-center" >
		  <span class="form-check form-switch float-start mx-2">
            <input type="radio" name="BankType" class="bType form-check-input" id="bankType_id"  value="bankType"  required  />
            <label for="bankType_id" class="form-check-label">Bank Account</label>
			</span>
            <? if($data['con_name']=='clk'){ ?>
            <? }else{ ?>
			<span class="form-check form-switch float-start mx-2">
            <input type="radio" name="BankType" class="bType form-check-input" id="CryptoCurrency_id"  value="CryptoCurrency"  required />
            <label for="CryptoCurrency_id" class="form-check-label">Crypto Wallet</label>
			</span>
            <? } ?>
          </div>
          <? } ?>
		  <? if(isset($post['primary'])){?>
          <script>
			$('#edit_bank_primary option[value="<?=prntext($post['primary'])?>"]').prop('selected','selected');
		   </script>
		   <? } ?>
        </div>
        

    </div>
	<div class="row me-1"><div id="swiftmsg" class="col-sm-12 px-1"></div></div>
<? if((isset($buttonname)&&$buttonname=="Add")||$cryptoWallet==0){?>
<form id="bankForm1" method="post" enctype="multipart/form-data">
<?=((isset($data['is_admin_input_hide'])&&$data['is_admin_input_hide'])?$data['is_admin_input_hide']:'');?>
<? if(isset($data['con_name'])&&$data['con_name']=='clk'&&(!isset($post['bcountry'])||$post['bcountry']=='')){
	$post['bcountry']='IN';
}?>

<?php
//print_r($post);
?>

<input type="hidden" name="action" value="<?=(isset($post['action'])?$post['action']:'')?>">
<input type="hidden" name="gid" value="<?=(isset($post['gid'])?$post['gid']:'');?>">
<input type="hidden" name="bid" value="<?=(isset($post['bid'])?$post['bid']:'');?>">
<input type="hidden" name="type" value="<?=(isset($post['type'])?$post['type']:'')?>">
<input type="hidden" name="StartPage" value="<?=(isset($post['StartPage'])?$post['StartPage']:'')?>">
      <div id="typeBank" class="<? if($buttonname=="Add"||$cryptoWallet==1){ ?>hide<? } ?> table-responsive">
        <div class="widget-body input_col_3" style="padding-bottom: 0;">
          <!-- Hidden Values -->
<input type="hidden" name="1primary" id="1edit_bank_primary" value="<?=(isset($post['primary'])?$post['primary']:'')?>">
<input type="hidden" name="bcity" id="bcity" value="<?=(isset($post['bcity'])?$post['bcity']:'');?>">
<input type="hidden" name="bzip" id="bzip" value="<?=(isset($post['bzip'])?$post['bzip']:'');?>">
<input type="hidden" name="bcountry" id="bcountry" value="<?=(isset($post['bcountry'])?$post['bcountry']:'');?>">
<input type="hidden" name="bstate" value="<?=(isset($post['bcountry'])?$post['bstate']:'');?>">
<input type="hidden" name="bphone" value="<?=(isset($post['bphone'])?$post['bphone']:'');?>">
<input type="hidden" name="btype" value="<?=(isset($post['btype'])?$post['btype']:'');?>">
          <!-- Ajax DIVs -->
          <div class="container text-center">
            <div id="swiftmsg" class="alert alert-danger" style="display: none;"></div>
            <div id="swiftmsgbutton" class="alert alert-danger" style="display: none;"> <span title="Close" onclick="CloseDiv();"  style="margin-top: 7px;
margin-left: -9px;;cursor:pointer; color: red;"><i class="<?=$data['fwicon']['delete'];?>"></i></span> </div>
            <div id="swiftmsgbuttonright" style="margin-left: 10px;display: none;float: left;"> Code Validated. <span title="Close" onclick="CloseDiv();" style="margin-top: 7px;
margin-left: -9px;;cursor:pointer; color: green;"><i class="<?=$data['fwicon']['check-circle'];?>"></i></span> </div>
            <div id="swiftmsgloader" class="alert alert-info" style="display: none;"> <img src="<?=$data['Host']?>/images/loader.gif" style="height:50px !important; width:50px !important;" /></div>
          </div>
          <div class="row bg-vlight p-1 rounded">
            <div class="col-sm-6  ps-0 mb-2">
              
			  <span class="form-label d-none d-sm-block" id="basic-addon4" title="Name"> Name </span>
              <input name="bnameacc" class="form-control" placeholder="Account Holder&rsquo;s Name" title="Account Holder&rsquo;s Name As per in Bank Records" type="text" value="<? if(isset($post['bnameacc'])) echo $post['bnameacc']?>" required>
            </div>
            <div class="col-sm-6  ps-0 mb-2">
			  <span class="form-label d-none d-sm-block" id="basic-addon4" title="Address">Address </span>
              <input name="full_address" class="form-control" placeholder="Account Holder&rsquo;s Address" title="Account holder's address  As per in Bank Records" type="text" value="<? if(isset($post['full_address'])) echo $post['full_address']?>" required>
            </div>
            <div class="col-sm-6  ps-0 mb-2">
              
             <span class="form-label d-none d-sm-block" id="basic-addon4" title="Account Number <? if($post['ovalidation']){ ?> / IBAN No <? } ?>">Account Number </span>
              <input name="baccount" class="form-control"  placeholder="Account Number <? if($post['ovalidation']){ ?> / IBAN No<? } ?>" title="Account Number<? if($post['ovalidation']){ ?> / IBAN No<? } ?>" type="text" value="<? if(isset($post['baccount'])) echo decrypts_string($post['baccount'],0)?>" required>
            </div>
            <? if($post['ovalidation']){ ?>
            <div class="col-sm-6  ps-0 mb-2">
               <span class="form-label d-none d-sm-block" id="basic-addon4" title="Routing Number">Routing Number </span>
              <input name="brtgnum" class="form-control"  placeholder="Routing Number" type="text" value="<? if(isset($post['brtgnum'])) echo $post['brtgnum']?>" >
            </div>
            <? } ?>
            <div class="col-sm-6  ps-0 mb-2">
              <!--<label for="formFile" class="w-100"><strong>
              <?=$post['swift_con'];?>
              Code : </strong></label>-->
			  <span class="form-label d-none d-sm-block" id="basic-addon4" title="<?=$post['swift_con'];?> Code"><?=$post['swift_con'];?> Code </span>
              <input name="bswift" class="form-control" id="bswift" placeholder="<?=$post['swift_con'];?> Code" type="text" title="<?=$post['swift_con'];?> Code" value="<? if(isset($post['bswift'])) echo $post['bswift']?>" onBlur="checkAvailability_swift()"  required>
            </div>

            <div class="col-sm-6  ps-0 mb-2">
             <span class="form-label d-none d-sm-block" id="basic-addon4" title="Bank Name">Bank Name </span>
              <input name="bname" id="bname" class="form-control" placeholder="Bank Name" title="Bank Name" type="text" value="<? if(isset($post['bname'])) echo $post['bname']?>" required>
              <?php
	$bankaddress='';
	if (isset($post['baddress'])&&$post['baddress']!='')
	{
		$bankaddress=$post['baddress'];
	}
	?>
            </div>
            <div class="col-sm-6 ps-0 mb-2">
             <span class="form-label d-none d-sm-block" id="basic-addon4" title="Bank Address">Bank Address </span>
              <input type="text" class="form-control" name="baddress" id="baddress" placeholder="Bank Address" title="Bank Address" value="<?=$bankaddress?>" required>
              <input type="hidden" name="bankaddress" value="<? if(isset($post['baddress'])) echo $post['baddress']?>">
            </div>
            <div class="col-sm-6 ps-0 mb-2">
              <span class="form-label d-none d-sm-block" id="basic-addon4" title="Requested Currency">Requested Currency </span>
              <? if($data['con_name']=='clk'){ $withdraw_fee='0.00'; ?>
              <input type="text" class="form-control" name="required_currency" id="required_currency" placeholder="Requested Currency"   value="<?=prntext($post['required_currency']?$post['required_currency']:'INR')?>" style="display:none !important"  />
			  <span class="ms-3 mt-2 "><?=prntext($post['required_currency']?$post['required_currency']:'INR')?></span>
              <? }else{
		    $withdraw_fee='2';
	        ?>
              <select name="required_currency" class="form-select" id="required_currency" placeholder="Requested Currency For Payout" required>
                <option value="" selected>Requested Currency For Payout</option>
				<?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
						 <option value="<?=$k11?>"><?=$k11?></option>
				<?}?>
              </select>
 <? if(isset($post['required_currency'])) {?>		  
 <script>$('#required_currency option[value="<?=prntext($post['required_currency'])?>"]').prop('selected','selected');</script> 
 <? } ?>
              <? } ?>
            </div>
            <div class="col-sm-6  ps-0 mb-2">
            
			  <span class="form-label d-none d-sm-block  w-100" id="basic-addon4" title="Withdraw Fee">Withdraw Fee </span>
              <div>
                <input name="withdrawFee" class="form-control float-start " id="withdrawFee" placeholder="Withdraw Fee" title="Withdraw Fee" type="number" value="<?=(isset($post['withdrawFee'])&&$post['withdrawFee']?$post['withdrawFee']:$withdraw_fee)?>" style="width:calc(100% - 20px);" onchange="setTwoNumberDecimal" min="0"  step="0.01"  required >
				
				
                <span class="float-start p-2" style="width:20px;">%</span> </div>
            </div>
            <div class="col-sm-6  ps-0 mb-2">
              <span class="form-label d-none d-sm-block" id="basic-addon4" title="Additional Information">Additional Information </span>
              <input type="text" class="form-control" name="adiinfo" placeholder="Additional Information (Remarks)" title="Additional Information (Remarks)"  value="<? if(isset($post['adiinfo'])) echo $post['adiinfo']?>" />
            </div>
			
            <div class="col-sm-6  ps-0 mb-2">
              
			  <div class="my-1"><span class="form-label w-100" id="basic-addon4" title="Bank Document">Bank Document</span>
			  <div class="clearfix"></div>
              <input <?=$ep;?> type="file" class="file form-control float-start w-75" name="bankdoc" >
              <input <?=$ep;?> name="upload_logo" value="<? if(isset($post['bank_doc'])) echo $post['bank_doc']?>" type="hidden" class="">
              <div class="show_img_img w-25 float-start" id="show_img_<? if(isset($post['bid'])) echo $post['bid']?>" > 
<? if($post['bank_doc']){  ?>
<? display_docfile("../user_doc/", $post['bank_doc']); ?>
<? }else{ ?>			  
<a onclick="uploadfile_viewf(this)" > <img src="<?=$data['Host']?>/images/No_image_available.svg" style="height:36px !important;" class="img-thumbnail" /></a> 
<? } ?>
			  </div>
            </div> </div>
			
			
            <div class="col-sm-6 text-end"><? if($post['ovalidation']){ ?>
			 <label class="btn btn-primary mt-4" for="intermediary_bank_info">
                <i class="<?=$data['fwicon']['square-plus'];?>" title="Add Intermediary Bank Details"></i>
             </label>
			<? } ?>	
				</div>
           <!-- <div class="separator"></div>-->
          </div>
        </div>
		<? if(isset($post['bid'])){?>
		<? //display_docfile("../user_doc/", $post['bank_doc']); ?>
		<? } ?>
        <? if($post['ovalidation']){ ?>
        <div class="widget-body input_col_3" style="padding-bottom: 0;">
          <!--<div class="span12">-->
          <div class="row bg-light my-2">
           

            <div class="col-sm-12">

              <input <? if(isset($post['intermediary'])){echo "checked='checked'";} ?> type="checkbox" name='intermediary_bank_info' id='intermediary_bank_info' placeholder="Intermediary bank details" class="form-control hide w-100" 
value="<? if(isset($post['intermediary_bank_info'])) echo $post['intermediary_bank_info']?>"  />
            </div>
            <div class="intermediary_div <? if(!isset($post['intermediary']) || empty($post['intermediary'])){echo "hide";} ?> " id="intermediary_div">
              <div class="row" >
                <div class="col-sm-4 ps-0">
                  <input type="text" name="intermediary" id="intermediary" placeholder="Enter your intermediary <?=$post['swift_con'];?> code" class="form-control w-100 my-2" value="<? if(isset($post['intermediary'])) echo $post['intermediary']?>"  onfocusout="IntMdtMakeRequest();" />
                </div>
                <div class="col-sm-4 ps-0">
                  <input type="text" name="intermediary_bank_name" id="intermediary_bank_name" placeholder="Enter your intermediary bank name" class="form-control w-100 my-2" value="<? if(isset($post['intermediary_bank_name'])) echo $post['intermediary_bank_name']?>" />
                </div>
                <div class="col-sm-4 ps-0">
                  <input type="text" name="intermediary_bank_address" id="intermediary_bank_address" placeholder="Enter your intermediary bank address" class="form-control w-100 my-2" value="<? if(isset($post['intermediary_bank_address'])) echo $post['intermediary_bank_address']?>" />
                </div>
              </div>
            </div>
          </div>
          <script>
		  $('#intermediary_bank_info').click(function(){
		  if ($("#intermediary_bank_info[type='checkbox']:checked").length >0)
		  {$('#intermediary_div').slideDown(700);}else{$('#intermediary_div').slideUp(700);}});
		  </script>
        </div>
        <? } ?>
        <div class="text-center my-2">
		
          <button type="submit" name="send" id="send" value="<?=$buttonname?> Bank Account" class="submit btn btn-primary" style="float:none;"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit </button><? /*?> <?=$buttonname?> Bank Account<? */ ?>
          
            <a href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<?=$_GET['id']?>&action=detail<?=($data['is_admin_link']);?>&tab_name=collapsible7" id="back" class="btn btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
      </div>
    </form>
    <? } ?>
  <? if(($data['con_name']!='clk')&&($buttonname=="Add"||$cryptoWallet==1)){?>
<form id="CryptoForm2" method="post" enctype="multipart/form-data">
<?=((isset($data['is_admin_input_hide'])&&$data['is_admin_input_hide'])?$data['is_admin_input_hide']:'');?>
<input type="hidden" name="action" value="<?=(isset($post['action'])?$post['action']:'');?>">
<input type="hidden" name="bname" value="Crypto Wallet">
<input type="hidden" name="gid" value="<?=(isset($post['gid'])?$post['gid']:'');?>">
<input type="hidden" name="bid" value="<?=(isset($post['bid'])?$post['bid']:'');?>">
<input type="hidden" name="type" value="<?=(isset($post['type'])?$post['type']:'')?>">
<input type="hidden" name="StartPage" value="<?=(isset($post['StartPage'])?$post['StartPage']:'')?>">
<input type="hidden" name="insertType" value="Crypto Wallet">
      <div id="typeCrypto" class="<? if($buttonname=="Add"||$cryptoWallet==0){ ?>hide<? } ?> ">
        <div class="row bg-vlight p-1 rounded">
          <div class="col-sm-6  ps-0 mb-2">
			<span class="form-label d-none d-sm-block" id="basic-addon4" title="Requested Coins "> Requested Coins  </span>
            <input <?=$ep;?> type="hidden" name="bname" value="Crypto Wallet" />
            <input <?=$ep;?> type="hidden" name="required_currency" id="required_currency" placeholder="Requested Currency"  class="span10" value="<?=prntext($post['MemberInfo']['default_currency']?$post['MemberInfo']['default_currency']:'INR')?>" style="display:none !important"  />
            <select <?=$ep;?> name="coins_name" id="coins" class="form-select" required >
              <option value="" disabled selected>Requested Coins For Payout</option>
              <option value="BTC">BTC</option>
              <option value="USDT">USDT</option>
			  <option value="USDC">USDC</option>
            </select>
    <?
	if(isset($post['coins_name']))
	{
	?>
	<script>
		$('#coins option[value="<?=prntext($post['coins_name'])?>"]').prop('selected','selected');
	</script>
	<?
	}?>
          </div>
          <div class="col-sm-6  ps-0 mb-2">
			<span class="form-label d-none d-sm-block" id="basic-addon4" title="Network"> Network  </span>
            <select <?=$ep;?> name="coins_network" id="coins_network"  class="form-select" required >
              <option value="" selected>Select Network</option>
              <option value="BTC">BTC</option>
              <option value="ERC20">ERC20</option>
              <option value="TRC20">TRC20</option>
              <option value="BEP2">BEP2</option>
              <option value="BEP20">BEP20</option>
              <option value="BSC">BSC</option>
              <option value="Other">Other</option>
            </select>
  <?
	if(isset($post['coins_network']))
	{
	?>
	<script>
		$('#coins_network option[value="<?=prntext($post['coins_network'])?>"]').prop('selected','selected');
	</script>
	<?
	}?>
          </div>
          <div class="col-sm-6  ps-0 mb-2">
		<span class="form-label d-none d-sm-block" id="basic-addon4" title="Address"> Address  </span>	
		<input name="coins_address" id="coins_address" class="form-control" placeholder="Address" title="Address" type="text" value="<? if(isset($post['coins_address'])&&$post['coins_address']) echo decrypts_string($post['coins_address'],0);?>" required >
          </div>
		  
          <div class="col-sm-6  ps-0 mb-2">
			<span class="form-label d-none d-sm-block" id="basic-addon4" title="Wallet Provider"> Wallet Provider  </span>
            <input name="coins_wallet_provider" id="coins_wallet_provider" class="form-control"  placeholder="Wallet Provider" title="Wallet Provider" type="text" value="<?=(isset($post['coins_wallet_provider'])?$post['coins_wallet_provider']:'');?>">
          </div>
          <div class="col-sm-6  ps-0 mb-2">
		<span class="form-label d-none d-sm-block" id="basic-addon4" title="Withdraw Fee"> Withdraw Fee  </span>	
            <input name="withdrawFee" class="form-control float-start" id="withdrawFee" placeholder="Withdraw Fee" title="Withdraw Fee"  type="number" value="<?=(isset($post['withdrawFee'])&&$post['withdrawFee']?$post['withdrawFee']:'5')?>" onchange="setTwoNumberDecimal" min="0"  step="0.01" style="width:calc(100% - 20px);"  required  >
            <span class="float-start text-center p-2" style="width:20px;"> % </span></div>
			
			
          <div class="col-sm-6 ps-0 mb-2">
			<div > <span class="form-label" id="basic-addon4" title="Upload Screenshot of Wallet Dashboard"> Upload Screenshot</span>
            <div>
              <input <?=$ep;?> type="file" class="file form-control w-75 float-start my-2" name="bankdoc" >
              <input <?=$ep;?> name="upload_logo" value="<?=(isset($post['bank_doc'])?$post['bank_doc']:'');?>" type="hidden" class="" >
<div style="height: 36px;" class="px-2 py-2"><? if($post['action']=='update_bank') $pro_img=display_docfile("../user_doc/",$post['bank_doc']); ?></div>
            </div></div>
          </div>
          <div class="col-sm-12 my-2 text-center">
<button <?=$ep;?> type="submit" name="send" id="send" value="CONTINUE" class="btn btn-primary" ><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
<? /* ?><?=$buttonname?>Crypto Wallet<? /*/ ?>
            
            <a href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<?=$_GET['id']?>&action=detail<?=($data['is_admin_link']);?>&tab_name=collapsible7" id="back" class="backButton nopopup btn  btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a></div>
        </div>
      </div>
    </form>
    <? } ?>
    <? }else{ ?>
    All changes was stored in the database.<br>
    <hr>
    <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&bid=<?=$post['bid']?>&action=update_bank&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Back</a> | <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&action=detail&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Detail</a>
    <? } ?>
  </div>
  <? }elseif($post['action']=='insert_micro_trans'||$post['action']=='update_micro_trans'){   ?>
  <?

	if(!$_SESSION['login_adm']&&!$_SESSION['merchant_action_add_micro_transactions']){
		echo $data['OppsAdmin'];
		exit;
	}
?>
  <? if(!$post['PostSent']){ ?>
  <form method="post">
  <?=((isset($data['is_admin_input_hide'])&&$data['is_admin_input_hide'])?$data['is_admin_input_hide']:'');?>
    <input type="hidden" name="action" value="<?=$post['action']?>">
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <input type="hidden" name="bid" value="<?=$post['bid']?>">
    <input type="hidden" name="type" value="<?=$post['type']?>">
    <input type="hidden" name="StartPage" value="<?=$post['StartPage']?>">
    <!--<table class=frame width=100% border=0 cellspacing=1 cellpadding=2>
    <tr>
      <td class="capl bg2" colspan=2><? if($post['action']=='insert_micro_trans'){ ?>
        CREATE NEW MICRO TRANSACTIONS FOR MERCHANT
        <? }else{ ?>
        MODIFY MERCHANT MICRO TRANSACTIONS
        <? } ?></td>
    </tr>


    <tr>
      <td colspan=2 valign=top align=left width=100%><div class="widget-body input_col_3" style="padding-bottom: 0;">
          <div class="row-fluid">
            <div class="span12">
              <div class="separator"></div>
              <label title="No. of Micro Trans.">No. of Micro Trans.:</label>
              <input type="text" name=no_micro_transaction size=40 value="<?=$post['no_micro_transaction']?>">
              <div class="separator"></div>
              <label title="Total Amount">Total Amount:</label>
              <input type="text" name=total_amount size=40 value="<?=$post['total_amount']?>">
              <div class="separator"></div>
              <label title="Remark">Remark:</label>
              <textarea rows=5 style=" height:80px;" name=micro_transaction_remark ><?=$post['micro_transaction_remark']?>
</textarea>
            </div>
            <div style="clear:both; border-bottom:1px solid #CCC;"></div>
          </div>
        </div>

      </td>
    </tr>

    <tr>
      <td  colspan=2><input class=submit type=submit name=send value="Save Changes">
        &nbsp; <a href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<?=$_GET['id']?>&action=detail<?=($data['is_admin_link']);?>&tab_name=collapsible5" class="btn btn-icon btn-primary">BACK</a> </td>
    </tr>
  </table>-->
  </form>
  <? }else{ ?>
  All changes was stored in the database.<br>
  <br>
  <hr>
  <br>
  <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&bid=<?=$post['bid']?>&action=update_micro_trans&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Back</a> | <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&action=detail&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Detail</a>
  <? } ?>
  <? }elseif($post['action']=='insert_stores'||$post['action']=='update_stores'){  ?>
  <?
	if((!isset($_SESSION['login_adm']))||(!isset($_SESSION['templates_add_store']))){
		//echo $data['OppsAdmin']; exit;
	}
	
	opps_midf($_GET['id']);
	
	if(isset($post['store_json_value'])) $post['store_json_value']=str_replace(array('"{"','"}"'),array('{"','"}'),$post['store_json_value']);				
	if(isset($post['store_json_value'])) $sj=jsondecode($post['store_json_value']);
	
	if(isset($_GET['sj'])&&$_GET['sj']){
		echo "<hr/>store_json_value decode=><br/>";
		print_r($sj);
		
		echo "<hr/>store_json=><br/>";
		print_r($sj['store_json']);
		
		//echo "<hr/>store_json27 =>".$sj['store_json'][27];
		
		echo "<hr/>store_json_curl=><br/>";
		print_r($sj['store_json_curl']);
	
	}
	
	
	if(isset($sj['store_json_curl'])) $sj_curl=jsonencode1($sj['store_json_curl']);

	if(isset($sj))
	{
		if(((!isset($sj['store_json'])||!$sj['store_json']))&&((!isset($sj['store_json_curl'])||!$sj['store_json_curl']))){
			$sj_curl=jsonencode1($sj);
		}
	}	
	
?>
  <? if(!$post['PostSent']){ ?>
  <form method="post">
  <?=((isset($data['is_admin_input_hide'])&&$data['is_admin_input_hide'])?$data['is_admin_input_hide']:'');?>
    <input type="hidden" name="action_edit" value="update_stores_admin">
<input type="hidden" name="gid" value="<?=(isset($post['gid'])?$post['gid']:'');?>">
<input type="hidden" name="bid" value="<?=(isset($post['bid'])?$post['bid']:'');?>">
<input type="hidden" name="type" value="<?=(isset($post['type'])?$post['type']:'');?>">
<input type="hidden" name="StartPage" value="<?=(isset($post['StartPage'])?$post['StartPage']:'');?>">

    <div class="row-fluid input_col_2">
      <div class="row my-2 bg-light text-start vkg" style="#f7f7f7;overflow:hidden;">
        <? if((isset($data['Error'])&& $data['Error'])){ ?>
        <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Alert !</strong>
          <?=$data['Error']?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <? if ($post['id']==''&&!$post['action']){exit;} 
} ?>
        <h4> <i class="<?=$data['fwicon']['website'];?>"></i>
          <? if($post['action']=='insert_stores'){ ?>
          Create New
          <?=ucfirst(strtolower($store_name));?>/s For Merchant
          
          <? }else{ ?>
          Modify Merchant
          <?=ucfirst(strtolower($store_name));?>/s  - <b  class="text-primary88"> <?=$post['bid'];?></b><? } ?>
        </h4>
        <div class="p-0">
          <div class="row my-2 me-2">
		  <div class="col-sm-12 my-1"><? echo json_log_view1($post['json_log_history']);?></div>
            <div class="col-sm-2 my-1">

              <select name="active" class="form-select form-select-sm" id="active_processing_mode">
                <option value="" disabled="" selected="">
					<?=($store_name);?> Status</option>
                <option value="1">Approved </option>
                <option value="3">Rejected</option>
                <option value="4">Under review</option>
                <option value="5">Awaiting Terminal</option>
                <option value="6">Terminated</option>
              </select>
<?
			if(isset($post['active']))
			{
			?>
            <script>
			  	$('#active_processing_mode option[value="<?=$post['active']?>"]').prop('selected','selected');
			</script>
			<?
			}
			?>            </div>
			
            <div class="col-sm-10 my-1" >
			
			<!--//============For Secret Key ===========-->
              <b id="generate_secret_key2" class="hide" ><?=$_SESSION['generate_secret_'.$post['gid']];?></b>
             
              <a onclick="return confirm2(this);" class="btn btn-icon btn-primary btn-sm" title="Re-generate Secret Key"><i class="<?=$data['fwicon']['rotate'];?>"></i></a> 
			  <? if($_SESSION['generate_secret_'.$post['gid']]<>""){?>
			  
			  <a class="btn btn-icon btn-primary btn-sm" title="Copy Secret Key - <?=$_SESSION['generate_secret_'.$post['gid']];?>" onclick="CopyToClipboard2('#generate_secret_key2')">
			  <i class="<?=$data['fwicon']['copy'];?>" ></i> 
			  </a>
			  
			  <!--//============For Api Token===========-->
			  <b id="generate_api_token" class="hide"><?=(isset($post['api_token'])?$post['api_token']:'');?></b>
              
              <a onclick="return confirm1(this);" class="btn btn-icon btn-primary btn-sm" title="Re-generate API Token"><i class="<?=$data['fwicon']['rotate'];?>"></i></a> 
			  <? if($post['api_token']<>""){?>
			  <a class="btn btn-icon btn-primary btn-sm" title="Copy API Token - <?=(isset($post['api_token'])?$post['api_token']:'');?>" onclick="CopyToClipboard2('#generate_api_token')">
			  <i class="<?=$data['fwicon']['copy'];?>"></i>
			  </a>
			  <? } ?>
			  
			  <? } ?>
			  
			  </div>
			  
            <div class="col-sm-4  my-1"></div>
           
		   
		   
		   
		    <script>
			function confirm1(e){
				var retVal= confirm('Are you sure to Generate Secret Key!');
				if (retVal) {
				//alert();
					ajaxf1(e,'<?=$data['Admins'];?>/merchant<?=$data['ex']?>?bid=<?=(isset($post['bid'])?$post['bid']:'');?>&id=<?=(isset($post['gid'])?$post['gid']:'');?>&action=re_generate_api_token&ajax=1','#generate_api_token');
					alert();
					$('#generate_api_token').css("display", "none");
					return true;
					//e.preventDefault();
					
				} else {			
					return false;
				}
			}
			function confirm2(e){
				var retVal= confirm('Are you sure Re-generate API Token!');
				if (retVal) {
				
					ajaxf1(e,'<?=$data['Admins'];?>/merchant<?=$data['ex']?>?bid=<?=(isset($post['bid'])?$post['bid']:'');?>&id=<?=(isset($post['gid'])?$post['gid']:'');?>&action=generate_secret_key&ajax=1','#generate_secret_key2');
					$('#generate_secret_key2').css("display", "none");
					return true;
					//e.preventDefault();
					
				} else {			
					return false;
				}
			}
			function editStoreSalt(e,theVal){
				//var textArea=$(e).parent().parent().next();
				if(theVal=="edit"){
					var textArea=$(e).parent().parent().next().next();
				}else{
					var textArea=$(e).next();
				}
				textArea.slideDown(100);
				
				//setTimeout(function(){ textArea.css({height:"30px"}); }, 500);

			}
			function salt_store(e,theVal){
				var textArea=$(e).parent().next();
				var textDataVal=$(e).parent().next().attr('data-val');
				var thisVal=$(e).val();
				if(thisVal){
					if($(e).parent().parent().parent().find('.pre_val')){
						var optionSelected=$(e).parent().parent().find("datalist option[value="+thisVal+"]").html();
						$(e).parent().parent().parent().find('.pre_val').html(optionSelected);
					}
					textArea.val('||sm_'+thisVal);
					textArea.css("background", "#f2fff0");
					//$textArea.height(0);$textArea.height(this.scrollHeight);$thisTextArea.trigger("keyup");
				}else{
					textArea.val('');
					textArea.css("background", "#fff");
					$(e).focusout(function(e){
						var thisTextArea=$(this).parent().next();
						var textDataV=thisTextArea.attr('data-val');
						if(textDataV&&thisTextArea.val()==''){
							thisTextArea.val(textDataV);
							thisTextArea.css("background", "#fffcea");
							thisTextArea.slideDown(100);
							setTimeout(function(){ thisTextArea.css({"min-height":"50px"}); }, 500);
							$thisTextArea.height(0);$thisTextArea.height(this.scrollHeight);$thisTextArea.trigger("keyup");
						}
					});
				}
				
			}
		</script>
          </div>
          <!--=====================================================	-->
          <div class="row my-2 me-2">
          
			
            <div class="container bg-info" style="background:<?=$data['tc']['hd_b_l_9'];?> !important">
              <div class="col-sm-12 my-2 ">
                <label class="w-100"><strong>Acquirer Id </strong><br />
                <? 
				if($post['AccountInfo']){ ?>
                <a onclick="viewAll(this,'.salt_div');textAreaAdjust1();"  class="btn btn-primary btn-sm"> + EXPAND </a>
                <? } ?>
                </label>
              </div>
              <? 	
			  if(isset($post['midcard'])){
		      if(is_array($post['midcard'])){$midcard=implode(",",$post['midcard']);}else{$midcard=$post['midcard'];}
		      $midcard2=explode(",",$midcard.',');
	          }
	          ?>
             <? 
	if(isset($post['curling_access_key']))
	{
	if(is_array($post['curling_access_key'])){$curling_access_key=implode(",",$post['curling_access_key']);}else{$curling_access_key=$post['curling_access_key'];}
	}
	?>
              <div class="row mx-2" id="mer_website_css">
                <? $c=0;if($post['AccountInfo']){foreach($post['AccountInfo'] as $key=>$value_ac){$c++;if($value_ac['nick_name']&&$value_ac['account_login_url']!='3'){if($value_ac['processing_currency']&&strpos($value_ac['processing_currency'],' ')!==false){$curr_ex=explode(' ',$value_ac['processing_currency']);$curr=$curr_ex[0];}else{$curr="$";}
				 
				 if(!isset($sj['store_json'][$value_ac['nick_name']])) 
				  	$sj['store_json'][$value_ac['nick_name']] = '';
					 
				$store_values_en=jsonencode1($value_ac['hkip_siteid'],$sj['store_json'][$value_ac['nick_name']]);
				/*
				if(isset($value_ac['mcc_code'])){
					$acquirer_mcc_code_list=
				}
				*/
						  
			 if(strpos($store_values_en,'||sm_')!==false){
				    $id_sm=(int)str_replace('||sm_','',$store_values_en);
					$sm=$data['smDb'][$id_sm];
					if($sm['encode_processing_creds']){
						$ac_title=$sm['id'].' | <b>'.$sm['salt_name'].'</b> | '.$sm['bank_json_en'];
						$ac_class='store_salt_key';
						$ac_class2='store_salt_key2';
						$pre_bg1='#fffeea';
					}
			   }elseif(isset($data['smDb']['salt_id'])&&isset($value_ac['salt_id'])&&$value_ac['salt_id']&&in_array((int)$value_ac['salt_id'],$data['smDb']['salt_id'])){
				   $sm=$data['smDb'][$value_ac['salt_id']];
					if($sm['encode_processing_creds']){
						$ac_title=$sm['id'].' | <b>'.$sm['salt_name'].'</b> | '.$sm['bank_json_en'];
						$ac_class='salt_key';
						$ac_class2='salt_key2';
						$pre_bg1='#f2fff0';
					}
			   }else{
				   $sm['encode_processing_creds']='';//unset($sm['encode_processing_creds']);
				   $pre_bg1='#fff';
				   $ac_class2='api_key2';
			   }
			   
				if(isset($sm['encode_processing_creds'])&&$sm['encode_processing_creds']){
			
				}else{
				   $ac_title=$value_ac['hkip_siteid'];
				   $ac_class='json_api';
			    }
			  
		   ?>
                <div class="checkbox_div_15 <?=(isset($ac_class)?$ac_class:'');?> col-sm-4 row  p-1" style="position:relative;height:fit-content;">
                  <div class="row">
                  <div class="col-sm-1 float-start me-1">
				  <span class="form-check form-switch" >
                    <input type="checkbox" class="form-check-input"  id="midcard_<?=$key?>" name="midcard[]" value="<?=$value_ac['nick_name']?>" <? if(isset($midcard2)&&$midcard2&&in_array($value_ac['nick_name'], $midcard2, true)){?> checked='checked' <? } ?> >
					</span>
                  </div>
                  <div class="col-sm-8"  >
                    <label class="midlable w-100" for='midcard_<?=$key?>'  <? if(isset($_SESSION['login_adm'])){ ?>title='Rate: <?=$value_ac['transaction_rate'];?>%,  
Txn Fee: <?=$curr;?> <?=$value_ac['txn_fee'];?> , 
Rolling: <?=$value_ac['rolling_fee'];?>%'
					<? } ?>  >
                    <? if(isset($_SESSION['login_adm'])){ ?>
						<?=$value_ac['nick_name']?> -
                    <? } ?>
                     <?=$data['t'][$value_ac['nick_name']]['name4']?> - <?=$data['t'][$value_ac['nick_name']]['name1']?>
                     </label>
                  </div>
                  <div  class="col-sm-1  form-check" >
                    <input type="radio" class="curling_access_key float-start" style="position:relative; top:4px; margin-bottom:-4px;"  id="midcard_radio_<?=$key?>" name="curling_access_key" value="<?=$value_ac['nick_name']?>"<? if((!empty($curling_access_key))&&(strpos($curling_access_key,$value_ac['nick_name']) !==false)){ ?> checked<? } ?> title="Curling Access Key <? if(isset($_SESSION['login_adm'])){ ?>: <?=$value_ac['nick_name']?><? } ?>" >
					</div>
					<div  class="col-sm-1  form-check" >
					<a onclick="slide_next1(this,'.salt_div','3');textAreaAdjustf();" >
						<? if($ac_class=="json_api"){ ?>
							<i class="<?=$data['fwicon']['eye-solid'];?> text-success"></i>
						<? } else { ?>
							<i class="<?=$data['fwicon']['eye-solid'];?> text-danger"></i>
						<? } ?>
                    </a>
					</div>
                  </div>
                  
                  <div  class="col-sm-12 float-start text-start asb3" >
                    <div class="salt_div hide asb4" >
                      <? if(isset($sm['encode_processing_creds'])&&$sm['encode_processing_creds']){
							$display_salt="display:none;"; 
							$store_values='||sm_'.$sm['id'];
							$smId=str_replace('||sm_','',$sm['id']);
						?>
                      <div class="salt_div_data" style="clear:both;position:relative;background:<?=$pre_bg1?>;">
                        <pre class="pre_salt" style="clear:both;background:<?=$pre_bg1?>;text-align:left;"><span class="pre_val"><?=$ac_title;?></span> <a class="a_salt_edit" onclick="editStoreSalt(this,'edit')">Edit</a></pre>
                      </div>
                      <? }else{
						  $display_salt="display:block;";
						  
						  $store_values=$store_values_en;
						  if(strpos($store_values_en,'||sm_')!==false){
							$smId=str_replace('||sm_','',$store_values);
						  }else{
							$smId="";
						  }
					  } ?>
                      <?
					  if($value_ac['nick_name']&&in_array((int)$value_ac['nick_name'],$data['smDb']['a_id'])){ ?>
                      <a class="a_salt_add"  onclick="editStoreSalt(this,'add')" style="<?=$display_salt;?>">Add Salt</a>
                      <div class="hide">
                        <input id="salt_list_<?=$c;?>" list="datalist_salt_id_<?=$c;?>" name="salt_list_<?=$c;?>" value="<?=$smId;?>"  onchange="salt_store(this)" class="w-100" />
                        <datalist id="datalist_salt_id_<?=$c;?>">
                          <?=option_smf($data['smDb']['d'],$value_ac['nick_name'],"aid");?>
                        </datalist>
                      </div>
                      <? } ?>
                      <textarea 44 data-val='<?=$store_values;?>' class="textAreaAdjust w-100 form-control" name="a[<?=$value_ac['nick_name']?>]" id="a" style="<?=$display_salt;?>; height:30px !important;"><?=$store_values;?>
</textarea>
                    </div>
                  </div>
                </div>
                <? }}} ?>
              </div>
            </div>
            <div class="col-sm-4 my-2 bg-info " style="background:<?=$data['tc']['hd_b_l_9'];?> !important">
              <div class="radios col_3">
                <label class="label_2"><strong> Additional Value if Required : </strong></label>
                <div class="input_2">
<textarea class="textAreaAdjust form-control my-2" onkeyup="textAreaAdjust(this)" name="store_json_value" id="store_json_value" ><? if(isset($sj_curl)) echo $sj_curl?></textarea>
                </div>
              </div>
            </div>
			<div class="col-sm-4 my-2 bg-info " style="background:<?=$data['tc']['hd_b_l_9'];?> !important">
				
			<?
				if(isset($post['website_mcc_code'])&&$post['website_mcc_code']){
					$mcc_code_ex=explode(",",$post['website_mcc_code']);
				}

			?>
				<label for="mcc_code_no_add" class="form-label">MCC Code :</label> 
				  <select id="mcc_code_no_add" data-placeholder="Start typing the MCC Codes " multiple class="chosen-select form-control" name="website_mcc_code[]" style="clear:right;width:83%;" >
					<?=showselect($data['mcc_codes_list'], 0,1)?>
				  </select>
						  
				<script>
				$(".chosen-select").chosen({
				no_results_text: "Oops, nothing found!"
				});
				<?if(isset($mcc_code_ex)&&$mcc_code_ex){?>
					chosen_more_value_f("mcc_code_no_add",[<?=('"'.implodes('", "',$mcc_code_ex).'"');?>]);
				<?}?>
				
				$("#mcc_code_no_add_chosen").css("width", "100%");
				$("#mcc_code_no_add_chosen").addClass("form-control");
				</script>

		</div>
            <div class="col-sm-4 my-2 bg-info" style="background:<?=$data['tc']['hd_b_l_9'];?> !important">
              <div class="radios col_3" >
                <label class="label_2" for="checkout_theme"><strong>Checkout Theme : </strong></label>
                <div class="input_2">
                  <select name="checkout_theme" id="checkout_theme" data-rel="chosen"  class="form-select my-2" style="height: 47px;" >
                    <option value="">None</option>
                    <option value="default">Default</option>
                    <?
							$uiList = glob('../front_ui/*');
							foreach($uiList as $uiName){
								$uiName=str_replace('../front_ui/','',$uiName);
								if(!in_array($uiName,[1=>"index.html",2=>"default"])){
									echo "<option value='{$uiName}'>".ucfirst($uiName)."</option>"; 
								}
							}
							?>
                  </select>
                  	<?
					if(isset($post['checkout_theme']))
					{
					?>
					<script>
						$('#checkout_theme option[value="<?=prntext($post['checkout_theme'])?>"]').prop('selected','selected');
					</script>
					<?
					}?>
                </div>
              </div>
            </div>
            <!--======================================================-->
            <div class="col-sm-6 my-2 ">
              <label for="pname"> <strong><?=($store_name);?> Name : <font class="text-danger">*</font></strong> </label>
              
              
<input type="text" name="name" placeholder=" <?=($store_name);?> Name of your choice" class="form-control" value="<? if(isset($post['name'])) echo $post['name']?>" required>
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="bussiness_url"><strong>Business URL : <font class="text-danger">*</font></strong></label>
              <input type="text" name="bussiness_url" placeholder="*Business URL" class="form-control" value="<? if(isset($post['bussiness_url'])) echo $post['bussiness_url']?>" required>
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="transaction_currency"><strong>Transaction Currency : </strong> </label>
              <input type="text" name="transaction_currency" placeholder="<?=($store_name);?> Currency separated by commas i.e. SGD,USD,CNY" class="form-control" value="<? if(isset($post['bussiness_url'])) echo $post['transaction_currency']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="business_nature"><strong>Business Nature : </strong></label>
              <input type="text" name="business_nature" placeholder="Describe your Business Nature in Short" class="form-control" value="<? if(isset($post['business_nature'])) echo $post['business_nature']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="min_ticket"><strong>Min Ticket : </strong></label>
              <input type="text" name="min_ticket" placeholder="Min Ticket for your <?=($store_name);?>" class="form-control" value="<? if(isset($post['min_ticket'])) echo $post['min_ticket']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="max_ticket"><strong>Max Ticket : </strong></label>
              <input type="text" name="max_ticket" placeholder="Max Ticket for your <?=($store_name);?>" class="form-control" value="<? if(isset($post['max_ticket'])) echo $post['max_ticket']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="monthly_volume"><strong>Monthly Volume :</strong> </label>
              <input type="text" name="monthly_volume" placeholder="Estimated Monthly Volume for this <?=($store_name);?> (Please be specific)" class="form-control" value="<? if(isset($post['monthly_volume'])) echo $post['monthly_volume']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="processing_mode"><strong>Processing Mode : </strong></label>
              <input type="text" name="processing_mode" placeholder="Requested Processing Mode i.e. MOTO/API" class="form-control" value="<? if(isset($post['processing_mode'])) echo $post['processing_mode']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="sales_region"><strong>Sales Region : </strong></label>
              <input type="text" name="sales_region" placeholder="Estimated Sales Region i.e. Singapore,USA,EU... etc.  " class="form-control" value="<? if(isset($post['sales_region'])) echo $post['sales_region']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="transaction_notification_email"><strong>Transaction Notification Email : </strong></label>
              <input type="text" name="transaction_notification_email" placeholder="Email where we can send the Transaction Notification" class="form-control" value="<?=(isset($post['transaction_notification_email'])?encrypts_decrypts_emails($post['transaction_notification_email'],2):'');?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="dba_brand_name"><strong>DBA/Brand Name : </strong></label>
              <input type="text" name="dba_brand_name" placeholder="DBA/Brand Name - This will be shown to your customers as your company_name name " class="form-control" value="<? if(isset($post['dba_brand_name'])) echo $post['dba_brand_name']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="customer_service_no"><strong>Customer Service No. : </strong></label>
              <input type="text" name="customer_service_no" placeholder="Customer Service No. (Toll Free) - This will be display to your customer to contact you" class="form-control" value="<? if(isset($post['customer_service_no'])) echo $post['customer_service_no']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="customer_service_email"><strong>Customer Service Email : </strong></label>
              <input type="text" name="customer_service_email" placeholder="Customer Service Email - This will be display to your customer to contact you" class="form-control" value="<?=(isset($post['customer_service_email'])?encrypts_decrypts_emails($post['customer_service_email'],2):'');?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="merchant_term_condition_url"><strong>T & C : </strong></label>
              <input type="text" name="merchant_term_condition_url" placeholder="Your web URL for T&C" class="form-control" value="<? if(isset($post['merchant_term_condition_url'])) echo $post['merchant_term_condition_url']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="merchant_refund_policy_url"><strong>URL of Refund Policy : </strong></label>
              <input type="text" name="merchant_refund_policy_url" placeholder="Your Web URL for Refund Policy" class="form-control" value="<? if(isset($post['merchant_refund_policy_url'])) echo $post['merchant_refund_policy_url']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="merchant_privacy_policy_url"><strong>URL of Privacy Policy : </strong></label>
              <input type="text" name="merchant_privacy_policy_url" placeholder="Your Web URL for Privacy Policy" class="form-control" value="<? if(isset($post['merchant_privacy_policy_url'])) echo $post['merchant_privacy_policy_url']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="merchant_contact_us_url"><strong>URL of Contact us : </strong></label>
              <input type="text" name="merchant_contact_us_url" placeholder="Your Web URL for Contact us" class="form-control" value="<? if(isset($post['merchant_contact_us_url'])) echo $post['merchant_contact_us_url']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="merchant_logo"><strong>URL of Logo : </strong></label>
              <input type="text" name="merchant_logo" placeholder="Your Web URL for Logo" class="form-control" value="<? if(isset($post['merchant_logo'])) echo $post['merchant_logo']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="ureturn"><strong>Success URL : </strong></label>
              <input type="text" name="ureturn" id=ureturn placeholder="Success URL (Additional field for custom programming)" class="form-control" value="<? if(isset($post['ureturn'])) echo $post['ureturn']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="unotify"><strong>Notify URL : </strong></label>
              <input type="text" name="unotify" placeholder="Notify URL (Additional field for custom programming)" class="form-control" value="<? if(isset($post['unotify'])) echo $post['unotify']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="ucancel"><strong>Cancellation URL : </strong></label>
              <input type="text" name="ucancel" placeholder="Cancellation URL (Additional field for custom programming)" class="form-control" value="<? if(isset($post['ucancel'])) echo $post['ucancel']?>">
            </div>
            <div class="col-sm-6 my-2 ">
              <label for="description"><strong>Description : </strong></label>
              <textarea name="tech_comments" placeholder="Describe your Business in Details" class="form-control" ><? if(isset($post['tech_comments'])) echo $post['tech_comments']?></textarea>
            </div>
            <div class="col-sm-6 my-2 hide">
              <label for="business_description">Business Description</label>
<textarea name="business_description" placeholder="Please Business Describe your <?=($store_name);?>" class="form-control" ><? if(isset($post['business_description'])) echo $post['business_description']?></textarea>
            </div>
            <div class="radios row my-2">
              <div class='col-sm-3'>
                <label data-bs-toggle="tooltip" title="" data-bs-original-title="You can decide about the email notification sent by us"><strong>Notification Alert <i class="<?=$data['fwicon']['circle-question'];?> text-template"></i></strong></a></label>
              </div>

			  <? if(isset($post['notification_to'])&&is_array($post['notification_to'])){$notification_to=implode(",",$post['notification_to']);}else{$notification_to=((isset($post['notification_to']) &&$post['notification_to'])?$post['notification_to']:'');}?>
			<div class='row col-sm-9'>  
              <!--<div class="input_2">-->
              <div class='checkbox_div col-sm-2' title="To Merchant on Approved">
			  <span class="form-check form-switch  float-start">
                <input type="checkbox" name='notification_to[]' id='notification_to1' class='checkbox_d form-check-input' value='001' <?php if($notification_to&&strpos($notification_to,"001")!==false){echo "checked='checked'";} ?>>
				</span>
                <label class="form-check-label" for="notification_to1"><strong>Approved</strong></label>
              </div>
			  
              <div class='checkbox_div col-sm-2' title="To Merchant on Declined">
			  <span class="form-check form-switch  float-start">
                <input type="checkbox" name='notification_to[]' id='notification_to4' class='checkbox_d form-check-input' value='004' <?php if($notification_to&&strpos($notification_to,"004")!==false){echo "checked='checked'";} ?>>
				</span>
                <label class="form-check-label" for="notification_to4"><strong>Declined</strong></label>
              </div>
              
			  
			  <div class='checkbox_div col-sm-2' title="To Merchant on Withdraw">
			  <span class="form-check form-switch  float-start">
                <input type="checkbox" name='notification_to[]' id='notification_to_011' class='checkbox_d form-check-input' value='011' <?php if($notification_to&&strpos($notification_to,"011")!==false){echo "checked='checked'";} ?>>
				</span>
                <label class="form-check-label"  for="notification_to_011"><strong>Withdraw</strong></label>
              </div>
			  
			  <div class='checkbox_div col-sm-2' title="To Merchant on Chargeback">
			  <span class="form-check form-switch  float-start">
                <input type="checkbox" name='notification_to[]' id='notification_to_012' class='checkbox_d form-check-input' value='012' <?php if($notification_to&&strpos($notification_to,"012")!==false){echo "checked='checked'";} ?>>
				</span>
                <label class="form-check-label"  for="notification_to_012"><strong>Chargeback</strong></label>
              </div>
			  
			  <div class='checkbox_div col-sm-2' title="To Merchant on Refund">
			  <span class="form-check form-switch  float-start">
                <input type="checkbox" name='notification_to[]' id='notification_to_013' class='checkbox_d form-check-input' value='013' <?php if($notification_to&&strpos($notification_to,"013")!==false){echo "checked='checked'";} ?>>
				</span>
                <label class="form-check-label"  for="notification_to_013"><strong>Refund</strong></label>
              </div>
			  
			  <div class='checkbox_div col-sm-2' title="Notification to customer for success and decline.">
			  <span class="form-check form-switch  float-start">
                <input type="checkbox" name='notification_to[]' id='notification_to2' class='checkbox_d form-check-input' value='002' <?php if($notification_to&&strpos($notification_to,"002")!==false){echo "checked='checked'";} ?>>
				</span>
                <label class="form-check-label"  for="notification_to2"><strong>Customer</strong></label>
              </div>
			  </div>
              <!--</div>-->
            </div>
          </div>
        </div>
        <div class="col-sm-12 my-2 text-center">
          <!--<input class="submit btn btn-primary" type="submit" name="send" value="Save Changes">-->
<button class="submit btn btn-primary" type="submit" name="send" value="Save Changes" ><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
          <a href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<?=$_GET['id']?>&action=detail<?=($data['is_admin_link']);?>&tab_name=collapsible3" class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a></div>
      </div>
    </div>
  </form>
  <? }else{ ?>
  All changes was stored in the database.<br>
  <br>
  <hr>
  <br>
  <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&bid=<?=$post['bid']?>&action=update_stores&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Back</a> | <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&action=detail&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Detail</a>
  <? } ?>
  <? }elseif($post['action']=='insert_principal'||$post['action']=='update_principal'){   ?>
  <?
	if(!$_SESSION['login_adm']&&!$_SESSION['merchant_action_add_principal_profile']){
		echo $data['OppsAdmin'];
		exit;
	}
?>
  <? if(!$post['PostSent']){ ?>
  <form method="post" enctype="multipart/form-data">
	<?=((isset($data['is_admin_input_hide'])&&$data['is_admin_input_hide'])?$data['is_admin_input_hide']:'');?>
    <input type="hidden" name="action" value="<?=$post['action']?>">
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <input type="hidden" name="bid" value="<?=$post['bid']?>">
    <input type="hidden" name="type" value="<?=$post['type']?>">
    <input type="hidden" name="StartPage" value="<?=$post['StartPage']?>">
    <div class="row my-2 text-start vkg border rounded">
      <h4 class="my-2 text-start">
        <? if($post['action']=='insert_principal'){ ?>
        <i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add New SPOC 
        <? }else{ ?>
        <i class="<?=$data['fwicon']['edit'];?> text-success"></i> Modify SPOC Information/Details
       </b>
        <? } ?>
      </h4>
      <div class="row col-sm-6 my-2">
        <div class="col-sm-4"><strong>Name : <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></strong> </div>
        <div class="col-sm-8">
          <input type="text" name="fullname" placeHolder="Full Name" class="form-control" value="<?=(isset($post['fullname'])&&$post['fullname']?$post['fullname']:$post['fname']);?>" title="Full Name" required  />
		  <?php /*?><input type="hidden" name="lname" value="<?=$post['lname']?>" /><?php */?>
        </div>
      </div>
      
      <div class="row col-sm-6 my-2">
        <div class="col-sm-4"><strong>Designation : <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></strong> </font></div>
        <div class="col-sm-8">
          <input type="text" name="designation" class="form-control" value="<?=$post['designation']?>" placeHolder="Designation" title="Designation" required/>
        </div>
      </div>
      <div class="row col-sm-6 my-2">
        <div class="col-sm-4"><strong>Contact : <i class="<?=$data['fwicon']['star'];?>  text-danger"></i></strong> </font></div>
        <div class="col-sm-8">
          <div class="input">
            <input type="text" name="phone" class="form-control" value="<?=$post['phone']?>"  placeHolder="Contact" title="Contact"  required/>
          </div>
        </div>
      </div>
      <div class="row col-sm-6 my-2">
        <div class="col-sm-4"><strong>IM’S :</strong> </font></div>
        <div class="col-sm-8">
          <div class="input row">
		  <div class="col-sm-4">
			            <select name="ims_type" id="ims_type" class="form-select" autocomplete="off">
						<option value="">Select IM’S Type</option>
						<option value="Skype">Skype</option>
						<option value="Telegram">Telegram</option>
						<option value="WhatsApp">WhatsApp</option>
						</select>
		   <? if(isset($post['ims_type'])){?>
           <script>
			$('#ims_type option[value="<?=prntext($post['ims_type'])?>"]').prop('selected','selected');
		   </script>
		   <? } ?>
			</div>
			
			<div class="col-sm-8">
			<input type="text" name="email" value="<?=$post['email']?>" title="IM’S"  class="form-control"/>
          </div></div>
        </div>
      </div>
      
      <div class="my-2 text-center">
		<button class="btn btn-primary" type="submit" name="send" value="Save Changes" ><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button> <a href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<?=$_GET['id']?>&action=detail<?=($data['is_admin_link']);?>&tab_name=collapsible2" class="btn btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a>
      </div>
      
    </div>
  </form>
  <!--</div>-->
  <!--</div>-->
  <? }else{ ?>
  All changes was stored in the database.<br>
  <br>
  <hr>
  <br>
  <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&bid=<?=$post['bid']?>&action=update_principal&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Back</a> | <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&action=detail&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Detail</a>
  <? } ?>
  <? }elseif($post['action']=='insert_account'||$post['action']=='update_account' || $post['action']=='insert_account_associate'||$post['action']=='update_account_associate'){
	  

	  
	if(!$_SESSION['login_adm']&&!$_SESSION['merchant_action_add_account']&&!$_SESSION['merchant_action_add_associate_account']){
		echo $data['OppsAdmin'];
		exit;
	}
	
	//opps_midf($_GET['id']);
	
		
		$crbk_1="Charge Back Fee 1%";$crbk_2="Charge Back Fee 1%<3%";$crbk_3="Charge Back Fee 3%<";
		if(isset($post['nick_name'])&&strpos($data['t'][$post['nick_name']]['name2'],"Check")!==false){
			$crbk_1="Return Fee <10%";$crbk_2="Return Fee 10%<=15%";$crbk_3="Return Fee 15%<=20%";
		}
		
	  
	  $acc_arr= array();
	  if(strpos($post['action'],"_associate")!==false){	
		$acc_arr[1]="Commission";	$acc_arr[2]="Gateway Partner";	$acc_arr[3]="GATEWAY PARTNER";	$acc_arr[4]="_associate";	
		$data['traTypes']=$_SESSION['gPartnerAcq_'.$post['gid']];
	  }else{	
		$acc_arr[1]="Discount";	$acc_arr[2]="Acquirer";	$acc_arr[3]="ACQUIRER";	$acc_arr[4]="";
	  }	
	  $pro_cur1=explode(' ',(isset($post['processing_currency'])?$post['processing_currency']:''));
	  if(isset($pro_cur1[1])) $pro_cur=$pro_cur1[1]; 
	  
	  ?>
  <script>function procurrency(e) {
    $('.acct_curr').html($(e).val().split(" ")[1]);
    if ($(e).val() === '<?=(isset($data['t'][9]['name1'])?$data['t'][9]['name1']:'');?>') {}
}
function stringifyf(theValue){
	var theVal='';
	if (typeof theValue == 'object') { 
		theVal=JSON.stringify(theValue);
	}else{
		theVal=(theValue);
	}
	
	return theVal;
}
function input_add_scrubbed(e,theVal) {
	
	$('.scrubbed_period_mlt').attr('name','scrubbed_json[sp_'+theVal+'][scrubbed_period]');
	$('.min_limit_mlt').attr('name','scrubbed_json[sp_'+theVal+'][min_limit]');
	$('.max_limit_mlt').attr('name','scrubbed_json[sp_'+theVal+'][max_limit]');
	$('.tr_scrub_success_count_mlt').attr('name','scrubbed_json[sp_'+theVal+'][tr_scrub_success_count]');
	$('.tr_scrub_failed_count_mlt').attr('name','scrubbed_json[sp_'+theVal+'][tr_scrub_failed_count]');
	
}

function midnamechange1(e) {
	
	//var thisAccountId=$(e).find('option:selected').attr('title');
	var thisAccountId=$(e).val();
	//alert(thisAccountId);
	var thisurls="<?=$data['Admins']?>/bank_gateway<?=$data['ex']?>";
		thisurls=thisurls+"?action=get_bank_payout_table&gid="+thisAccountId;
	//alert(thisurls);	 	
	$.ajax({  
		 url:thisurls,  
		 type: "POST",
	
		 dataType: 'json', // text
		 data:{gid:thisAccountId, action:"get_bank_payout_table"},  
		 success:function(data){  
		 
		  if(data['Error']&&data['Error'] != ''){  
			   alert(data['Error']);
		  }else{
			  //var data1=JSON.stringify(data); alert(data1); 
			  //var data=$.parseJSON(data1);
			  //myObj = JSON.parse(this.responseText);
			  
			  //alert(data2.max_limit); alert(data2.hkip_siteid);
			  //alert(stringifyf(data['max_limit'])); alert(stringifyf(data['hkip_siteid']));
			  
			$('#nick_name').val(stringifyf(data['payout_id']));
			$('#nick_name_text').html(stringifyf(data['account_label']));
			
			
			$('#account_login_url option[value="'+stringifyf(data['account_login_url'])+'"]').prop('selected', 'selected'); //Processing Mode
			 
			$('#processing_currency').find('option:contains("'+stringifyf(data['processing_currency_nm'])+'")', this).prop('selected', 'selected').trigger('change'); //Default Currency 
			
			
			if(stringifyf(data['gst_fee'])){
				$('#gst_fee').val(stringifyf(data['gst_fee'])); //GST Fee(%)
			}
			
			
			
			$('#transaction_rate').val(stringifyf(data['transaction_rate'])); //Acquirer Discount Rate(%)
			$('#txn_fee').val(stringifyf(data['txn_fee'])); //Acquirer Txn. Fee (Success)
			$('#txn_fee_failed').val(stringifyf(data['txn_fee_failed'])); //Acquirer Txn. Fee (Failed)
			// Shorting to runtime 
			$('#rolling_fee').val(stringifyf(data['rolling_fee']));
			$('#shorting option[value="'+stringifyf(data['shorting'])+'"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve
			$('#rolling_period option[value="'+stringifyf(data['rolling_period'])+'"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


			$('#scrubbed_period option[value="'+stringifyf(data['scrubbed_period'])+'"]').prop('selected', 'selected'); //Scrubbed Period
			
			
			$('#min_limit').val(stringifyf(data['min_limit'])); //Min. Transaction Limit
			$('#max_limit').val(stringifyf(data['max_limit'])); //Max. Transaction Limit
			$('#tr_scrub_success_count').val(stringifyf(data['tr_scrub_success_count'])); //Min. Success Count
			$('#tr_scrub_failed_count').val(stringifyf(data['tr_scrub_failed_count'])); //Min. Failed Count		
			
			
			input_add_scrubbed(e,stringifyf(data['scrubbed_period']));
			
		
			$('.min_limit_mlt').val(stringifyf(data['min_limit']));
			$('.max_limit_mlt').val(stringifyf(data['max_limit']));
			$('.tr_scrub_success_count_mlt').val(stringifyf(data['tr_scrub_success_count']));
			$('.tr_scrub_failed_count_mlt').val(stringifyf(data['tr_scrub_failed_count']));
			
			
			
			$('#transaction_count').val(stringifyf(data['transaction_count']));	//Transaction Count
			$('#setup_fee').val(stringifyf(data['setup_fee'])); //Setup Fee
			$('#setup_fee_status option[value="'+stringifyf(data['setup_fee_status'])+'"]').prop('selected', 'selected'); //Setup Fee Collected


			$('#monthly_fee').val(stringifyf(data['monthly_fee'])); //Monthly Maintenance Fee
			$('#cbfee1').html('Charge Back Fee 1%:');
			$('#cbfee2').html('Charge Back Fee 1%<3%:');
			$('#cbfee3').html('Charge Back Fee 3%<:');
			$('#charge_back_fee_1').val(stringifyf(data['charge_back_fee_1'])); //CB Fee Tier 1 : 55
			$('#charge_back_fee_2').val(stringifyf(data['charge_back_fee_2'])); //CB Fee Tier 2 : 70
			$('#charge_back_fee_3').val(stringifyf(data['charge_back_fee_3'])); //CB Fee Tier 3 : 100
			$('#cbk1').val(stringifyf(data['cbk1'])); //CBK1 : 45
			$('#refund_fee').val(stringifyf(data['refund_fee'])); // Refund Fee : 15
			
			$('#settelement_period option[value="'+stringifyf(data['settelement_period'])+'"]').prop('selected','selected'); // Settlement Period : 15
			$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
			$('#virtual_fee').val(stringifyf(data['virtual_fee'])); //Virtual Terminal Fee
			$('#vt option[value="'+stringifyf(data['vt'])+'"]').prop('selected', 'selected'); // VT : 2
			
			$('#notification_to1').prop('checked', 'checked');
			$('#notification_to2').prop('checked', 'checked');
			
			$('#hkip_siteid').val(stringifyf(data['hkip_siteid']));
			
			if(data['hkip_siteid']){
				$('#hkip_siteid').attr('placeholder',stringifyf(data['hkip_siteid']));
			}else{
				$('#hkip_siteid').attr('placeholder',' ');
			}
			
			$('#checkout_level_name').val(stringifyf(data['checkout_level_name']));
			
			
		  }
		}
	});
	if($('#datalist_salt_id')){
		callsaltvalue(thisAccountId);
	}
}



function midnamechange(e) {
	
	$('#hkip_siteid').val('');
	$('#notification_to1').prop('checked', 'checked');
	$('#notification_to2').prop('checked', 'checked');
	$('#primary option[value="2"]').prop('selected', 'selected');	
	
	
	// fee common  
	
	 $('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
	 $('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
	 $('#transaction_rate').val('13'); //Acquirer Discount Rate(%)
	 $('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
	 $('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
	 // Shorting to runtime 
	 $('#rolling_fee').val('10');
	 $('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve
	 
	 
	 $('#min_limit').val('1'); //Min. Transaction Limit
	 $('#max_limit').val('500'); //Max. Transaction Limit
	 $('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
	$('#transaction_count').val('7');	//Transaction Count
	$('#tr_scrub_success_count').val('2'); //Min. Success Count
	$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
	$('#setup_fee').val(''); //Setup Fee
	$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected
	
	
	$('#monthly_fee').val('199'); //Monthly Maintenance Fee
	$('#cbfee1').html('Charge Back Fee 1%:');
	$('#cbfee2').html('Charge Back Fee 1%<3%:');
	$('#cbfee3').html('Charge Back Fee 3%<:');
	$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
	$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
	$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
	$('#cbk1').val('45'); //CBK1
	$('#refund_fee').val('15'); // Refund Fee
	$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
	$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
	$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
	$('#vt option[value="2"]').prop('selected', 'selected'); // VT
	
	$('#notification_to1').prop('checked', 'checked');
	$('#notification_to2').prop('checked', 'checked');
	$('#hkip_siteid').val('');
	$('#hkip_siteid').attr('placeholder','');
	$('#checkout_level_name').val('');
	 
       
     if ($(e).val() === '<?=(isset($data['t'][9]['name1'])?$data['t'][9]['name1']:'');?>' || $(e).val() === '9') {
        $('#nick_name').val('9');
        $('#nick_name_text').html('9=<?=(isset($data['t'][9]['name1'])?$data['t'][9]['name1']:'');?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('13'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Return Fee <10%:');
		$('#cbfee2').html('Return Fee 10%<=15%:');
		$('#cbfee3').html('Return Fee 15%<=20%:');
		$('#charge_back_fee_1').val('45'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#checkout_level_name').val('Pay By eCheck');
		
		
    	
    } else if ($(e).val() === '<?=(isset($data['t'][10]['name1'])?$data['t'][10]['name1']:'');?>' || $(e).val() === '10') {
        $('#nick_name').val('10');
        $('#nick_name_text').html('10=<?=(isset($data['t'][10]['name1'])?$data['t'][10]['name1']:'');?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('13'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Return Fee <10%:');
		$('#cbfee2').html('Return Fee 10%<=15%:');
		$('#cbfee3').html('Return Fee 15%<=20%:');
		$('#charge_back_fee_1').val('45'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#checkout_level_name').val('Pay By eCheck');
		
    } else if ($(e).val() === '<?=(isset($data['t'][11]['name1'])?$data['t'][11]['name1']:'');?>' || $(e).val() === '11') {
        $('#nick_name').val('11');
        $('#nick_name_text').html('11=<?=(isset($data['t'][11]['name1'])?$data['t'][11]['name1']:'');?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('13'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Return Fee <10%:');
		$('#cbfee2').html('Return Fee 10%<=15%:');
		$('#cbfee3').html('Return Fee 15%<=20%:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#checkout_level_name').val('Pay By eCheck');
		
    } else if ($(e).val() === '<?=(isset($data['t'][12]['name1'])?$data['t'][12]['name1']:'');?>' || $(e).val() === '12') {
        $('#nick_name').val('12');
        $('#nick_name_text').html('12=<?=(isset($data['t'][12]['name1'])?$data['t'][12]['name1']:'');?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('10'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#hkip_siteid').val('90');
		
		$('#checkout_level_name').val('Pay By Card');
		
    } else if ($(e).val() === '<?=$data['t'][14]['name1'];?>') {
        $('#nick_name').val('14');
        $('#nick_name_text').html('14=<?=$data['t'][14]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('10'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#hkip_siteid').val('{"siteid":"1467","approved_url":"mbsmedia.store"}');
		$('#hkip_siteid').attr('placeholder','{"siteid":"1467","approved_url":"mbsmedia.store"}');
		
		$('#checkout_level_name').val('Pay By Non 3D Secure Visa, MasterCard, JCB and Amex');
    }else if ($(e).val() === '<?=$data['t'][15]['name1'];?>') {
        $('#nick_name').val('15');
        $('#nick_name_text').html('15=<?=$data['t'][15]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		
		$('#hkip_siteid').val('{"siteid":"___","approved_url":"host name of approved merchant url"}');
		$('#hkip_siteid').attr('placeholder','{"siteid":"1405","approved_url":"k2share.cc"}');
		

		$('#checkout_level_name').val('Pay By 3D Secure Visa, MasterCard & Amex ');
		
    }else if ($(e).val() === '<?=$data['t'][16]['name1'];?>') {
        $('#nick_name').val('16');
        $('#nick_name_text').html('16=<?=$data['t'][16]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('10'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#hkip_siteid').val('{"siteid":"___","approved_url":"host name of approved merchant url"}');
		$('#hkip_siteid').attr('placeholder','{"siteid":"359","approved_url":"helixhosting.ninja"}');
		
		$('#checkout_level_name').val('Pay By Non 3D Secure  MasterCard, JCB and Amex ');
    }else if ($(e).val() === '<?=$data['t'][17]['name1'];?>') {
        $('#nick_name').val('17');
        $('#nick_name_text').html('17=<?=$data['t'][17]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#hkip_siteid').val('88816;503376113301;fa2214c63a414a159cfe74638c182525;softpointzone.com');
		$('#hkip_siteid').attr('placeholder','Terminal number;Receipt account;Security code;URL');
		$('#checkout_level_name').val('Pay By Non 3D Secure  MasterCard and JCB ');
		
    }else if ($(e).val() === '<?=$data['t'][18]['name1'];?>') {
        $('#nick_name').val('18');
        $('#nick_name_text').html('18=<?=$data['t'][18]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#checkout_level_name').val('Pay By Card ');
		
    }else if ($(e).val() === '<?=$data['t'][19]['name1'];?>') {
        $('#nick_name').val('19');
        $('#nick_name_text').html('19=<?=$data['t'][19]['name1'];?>');
       
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('10'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		
		$('#checkout_level_name').val('Pay By Non 3D Secure  Visa/MasterCard/JCB/AMEX/Discover/Diners Club');
		
		$('#hkip_siteid').val('{"approved_url":"","visa":{"mid":"1002101","apikey":"H0v2W0Y"},"mastercard":{"mid":"1002102","apikey":"x1l53Y1"},"jcb":{"mid":"1002104","apikey":"Ch0kXgB"},"amex":{"mid":"1002103","apikey":"wWs97Ze"},"discover":{"mid":"1002105","apikey":"GFDF5Q3"},"diners":{"mid":"1002105","apikey":"GFDF5Q3"}}');
		$('#hkip_siteid').attr('placeholder','{"approved_url":"","visa":{"mid":"1002101","apikey":"H0v2W0Y"},"mastercard":{"mid":"1002102","apikey":"x1l53Y1"},"jcb":{"mid":"1002104","apikey":"Ch0kXgB"},"amex":{"mid":"1002103","apikey":"wWs97Ze"},"discover":{"mid":"1002105","apikey":"GFDF5Q3"},"diners":{"mid":"1002105","apikey":"GFDF5Q3"}}');
		
		
    }else if ($(e).val() === '<?=$data['t'][20]['name1'];?>') {
        $('#nick_name').val('20');
        $('#nick_name_text').html('20=<?=$data['t'][20]['name1'];?>');
       
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('10'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		
		$('#checkout_level_name').val('Pay By 3D Secure Card ');
		
    }else if ($(e).val() === '<?=(isset($data['t'][21]['name1'])?$data['t'][21]['name1']:'');?>' || $(e).val() === '21') {
        $('#nick_name').val('21');
        $('#nick_name_text').html('21=<?=(isset($data['t'][21]['name1'])?$data['t'][21]['name1']:'');?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		
		$('#checkout_level_name').val('Pay By 3D Secure MasterCard,Visa,Amex,Bankcard (Australian Domestic) & Diners');
		
    }else if ($(e).val() === '<?=$data['t'][22]['name1'];?>') {
        $('#nick_name').val('22');
        $('#nick_name_text').html('22=<?=$data['t'][22]['name1'];?>');
       
	   		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#checkout_level_name').val('Pay By 3D Secure MasterCard,Visa');
		
    }if ($(e).val() === '<?=$data['t'][24]['name1'];?>') {
         $('#nick_name').val('24');
        $('#nick_name_text').html('24=<?=$data['t'][24]['name1'];?>');
 

		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
 
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
				
		
		$('#hkip_siteid').val('{"visa":{"bank_merchant_id":"79627","siteid":"79627001","bank_api_token":"R648822j"},"mastercard":{"bank_merchant_id":"79627","siteid":"79627001","bank_api_token":"R648822j"},"jcb":{"bank_merchant_id":"79627","siteid":"79627001","bank_api_token":"R648822j"}}');
		$('#hkip_siteid').attr('placeholder','{"visa":{"bank_merchant_id":"79627","siteid":"79627001","bank_api_token":"R648822j"},"mastercard":{"bank_merchant_id":"79627","siteid":"79627001","bank_api_token":"R648822j"},"jcb":{"bank_merchant_id":"79627","siteid":"79627001","bank_api_token":"R648822j"}}');
		$('#checkout_level_name').val('Pay By 2D Secure MasterCard and Visa');
		
    }else if ($(e).val() === '<?=(isset($data['t'][13]['name1'])?$data['t'][13]['name1']:'');?>' || $(e).val() === '13') {
        $('#nick_name').val('13');
        $('#nick_name_text').html('13=<?=(isset($data['t'][13]['name1'])?$data['t'][13]['name1']:'');?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
    } else if ($(e).val() === '<?=$data['t'][14]['name1'];?>') {
        $('#nick_name').val('14');
        $('#nick_name_text').html('14=<?=$data['t'][14]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#checkout_level_name').val('');
		
    }else if ($(e).val() === '<?=$data['t'][26]['name1'];?>') {
        $('#nick_name').val('26');
        $('#nick_name_text').html('26=<?=$data['t'][26]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		
		$('#hkip_siteid').val('88816;503376113301;D3777e65d1cb44a489bc44c46976ea63;24onlineshoplllc.com');
		$('#hkip_siteid').attr('placeholder','Terminal number;Receipt account;Security code;URL');
		$('#checkout_level_name').val('Pay By Non 3D Secure MasterCard and Visa');
		
    }else if ($(e).val() === '<?=$data['t'][27]['name1'];?>') {
        $('#nick_name').val('27');
        $('#nick_name_text').html('27=<?=$data['t'][27]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#hkip_siteid').val('88816;503376113301;fa2214c63a414a159cfe74638c182525;softpointzone.com');
		$('#hkip_siteid').attr('placeholder','Terminal number;Receipt account;Security code;URL');
		$('#checkout_level_name').val('Pay By Non 3D Secure MasterCard and JCB');
		
    }else if ($(e).val() === '<?=$data['t'][28]['name1'];?>') {
        $('#nick_name').val('28');
        $('#nick_name_text').html('28=<?=$data['t'][28]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		
		$('#hkip_siteid').val('88816;503376113301;fa2214c63a414a159cfe74638c182525;softpointzone.com');
		$('#hkip_siteid').attr('placeholder','Terminal number;Receipt account;Security code;URL');
		
		$('#checkout_level_name').val('Pay By Non 3D Secure MasterCard and JCB');
		
    }else if ($(e).val() === '<?=$data['t'][29]['name1'];?>') {
        $('#nick_name').val('29');
        $('#nick_name_text').html('29=<?=$data['t'][29]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('7.95'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.80'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('299'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');		
		
		$('#hkip_siteid').val('{"api_key":"SGdb-_DU3Ad9dMSJb_FMRqrosxsVjvk0qiQ2","api_secret":"Z2zs09_AmMTUOv9HqLFg9WMgca4ikHx9o9bq","terminal_id":"57"}');
		$('#hkip_siteid').attr('placeholder','{"api_key":"SGdb-_DU3Ad9dMSJb_FMRqrosxsVjvk0qiQ2","api_secret":"Z2zs09_AmMTUOv9HqLFg9WMgca4ikHx9o9bq","terminal_id":"57"}');
		
		$('#checkout_level_name').val('MasterCard and Visa (3D Secure)');
		
    }else if ($(e).val() === '<?=$data['t'][30]['name1'];?>') {
         $('#nick_name').val('30');
        $('#nick_name_text').html('30=<?=$data['t'][30]['name1'];?>');
 

		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
 
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
				
		
		$('#hkip_siteid').val('88816;503376113301;fa2214c63a414a159cfe74638c182525;softpointzone.com');
		$('#hkip_siteid').attr('placeholder','Terminal number;Receipt account;Security code;URL');
		$('#checkout_level_name').val('Pay By 3D Secure MasterCard and Visa');
		
    }else if ($(e).val() === '<?=$data['t'][31]['name1'];?>') {
        $('#nick_name').val('31');
        $('#nick_name_text').html('31=<?=$data['t'][31]['name1'];?>');
        
		
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#hkip_siteid').val('{"PublicKey":"FLWPUBK-278651e249c5e4efeacefa258b48135c-X","SecretKey":"FLWSECK-abeef04d7c327b0850b700880e5804a0-X","EncryptionKey":"abeef04d7c328f6f6c96134c"}');
		$('#hkip_siteid').attr('placeholder','{"PublicKey":"FLWPUBK-278651e249c5e4efeacefa258b48135c-X","SecretKey":"FLWSECK-abeef04d7c327b0850b700880e5804a0-X","EncryptionKey":"abeef04d7c328f6f6c96134c"}');
		$('#checkout_level_name').val('Pay By 3D Secure MasterCard and Visa');
		
    }
	else if ($(e).val() === '<?=$data['t'][32]['name1'];?>') {
        $('#nick_name').val('32');
        $('#nick_name_text').html('32=<?=$data['t'][32]['name1'];?>');
        
		
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#hkip_siteid').val('{"PublicKey":"FLWPUBK-f7d7322f7a60acfd10a440fcd4bb1cd8-X","SecretKey":"FLWSECK-152542f1667e0f447bcd5885faba2cb5-X","EncryptionKey":"152542f1667ecc2f661c7c1b","PublicKey_test":"FLWPUBK_TEST-bd62ff4faa21b7335ba1f5f59958ed1e-X","SecretKey_test":"FLWSECK_TEST-d81863a6c7bef918e1e2ca3477552522-X","EncryptionKey_test":"FLWSECK_TESTf387ba254903"}');
		$('#hkip_siteid').attr('placeholder','{"PublicKey":"FLWPUBK-f7d7322f7a60acfd10a440fcd4bb1cd8-X","SecretKey":"FLWSECK-152542f1667e0f447bcd5885faba2cb5-X","EncryptionKey":"152542f1667ecc2f661c7c1b","PublicKey_test":"FLWPUBK_TEST-bd62ff4faa21b7335ba1f5f59958ed1e-X","SecretKey_test":"FLWSECK_TEST-d81863a6c7bef918e1e2ca3477552522-X","EncryptionKey_test":"FLWSECK_TESTf387ba254903"}');
		
		$('#checkout_level_name').val('Pay By 3D Secure MasterCard and Visa');
		
    }
else if ($(e).val() === '<?=$data['t'][33]['name1'];?>') {
        $('#nick_name').val('33');
        $('#nick_name_text').html('33=<?=$data['t'][33]['name1'];?>');
        
		
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#hkip_siteid').val('{"api_key":"PUBK-1192940fdbb1ff86bfb93907da020f83","secret-key":"SECK-119ab1f51067d8f09210839a304eef82"}');
		$('#hkip_siteid').attr('placeholder','{"api_key":"PUBK-1192940fdbb1ff86bfb93907da020f83","secret-key":"SECK-119ab1f51067d8f09210839a304eef82"}');
		
		$('#checkout_level_name').val('Pay By 3D Secure MasterCard and Visa');
		
    } 
else if ($(e).val() === '<?=$data['t'][51]['name1'];?>') {
        $('#nick_name').val('51');
        $('#nick_name_text').html('51=<?=$data['t'][51]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#hkip_siteid').val('{"merchantId":"201611281000001","key":"ucThY3VRKetLELDQvfUYld3YNniJxqxwcUPUGP5bjmU=","iv":"0123456789abcdef"}');
		$('#hkip_siteid').attr('placeholder','{"merchantId":"201611281000001","key":"ucThY3VRKetLELDQvfUYld3YNniJxqxwcUPUGP5bjmU=","iv":"0123456789abcdef"}');
		
		$('#checkout_level_name').val('Pay By 3D Secure : (Credit Card, Debit Card, Direct Debit, PayPal, Net Banking, UPI, WALLET, EMI');
		
    }
	else if ($(e).val() === '<?=$data['t'][34]['name1'];?>') {
        $('#nick_name').val('34');
        $('#nick_name_text').html('34=<?=$data['t'][34]['name1'];?>');
        
		$('#account_login_url option[value="2"]').prop('selected', 'selected'); //Processing Mode
		$('#processing_currency option[value="$ USD"]').prop('selected', 'selected').trigger('change'); //Default Currency
$('#transaction_rate').val('15'); //Acquirer Discount Rate(%)
		$('#txn_fee').val('0.70'); //Acquirer Txn. Fee (Success)
		$('#txn_fee_failed').val('0.00'); //Acquirer Txn. Fee (Failed)
		// Shorting to runtime 
		$('#rolling_fee').val('10');
		$('#rolling_period option[value="180"]').prop('selected', 'selected').trigger('change'); // Rolling Reserve


		$('#min_limit').val('1'); //Min. Transaction Limit
		$('#max_limit').val('500'); //Max. Transaction Limit
		$('#scrubbed_period option[value="7"]').prop('selected', 'selected'); //Scrubbed Period
		$('#transaction_count').val('7');	//Transaction Count
		$('#tr_scrub_success_count').val('2'); //Min. Success Count
		$('#tr_scrub_failed_count').val('5'); //Min. Failed Count		
		$('#setup_fee').val(''); //Setup Fee
		$('#setup_fee_status option[value="0"]').prop('selected', 'selected'); //Setup Fee Collected


		$('#monthly_fee').val('199'); //Monthly Maintenance Fee
		$('#cbfee1').html('Charge Back Fee 1%:');
		$('#cbfee2').html('Charge Back Fee 1%<3%:');
		$('#cbfee3').html('Charge Back Fee 3%<:');
		$('#charge_back_fee_1').val('55'); //CB Fee Tier 1
		$('#charge_back_fee_2').val('70'); //CB Fee Tier 2
		$('#charge_back_fee_3').val('100'); //CB Fee Tier 3
		$('#cbk1').val('45'); //CBK1
		$('#refund_fee').val('15'); // Refund Fee
		$('#settelement_period option[value="15"]').prop('selected','selected'); // Settlement Period
		$('#view_settelement_report option[value="1"]').prop('selected','selected'); // Settlement Report View
		$('#virtual_fee').val('0.00'); //Virtual Terminal Fee
		$('#vt option[value="2"]').prop('selected', 'selected'); // VT
		
		$('#notification_to1').prop('checked', 'checked');
		$('#notification_to2').prop('checked', 'checked');
		
		$('#hkip_siteid').val('');
		$('#hkip_siteid').attr('placeholder','');
		
		$('#checkout_level_name').val('Pay with BitCoins eWallets');
		
    }
	
	else if ($(e).val() === "Other") {
        $('#nick_name').val('');
        $('#nick_name_text').html('');
        $('#transaction_rate').val('');
        $('#txn_fee').val('');
        $('#rolling_fee').val('');
        $('#mid_name_div').html('<input type="text" name=mid_name id=mid_name size=20 value=>');
    }
	textAreaAdjust1();
}
</script>
<? if(!isset($post['PostSent'])||!$post['PostSent']){?>
<form method="post">
<?=((isset($data['is_admin_input_hide'])&&$data['is_admin_input_hide'])?$data['is_admin_input_hide']:'');?>
<input type="hidden" name="action" value="<?=(isset($post['action'])?$post['action']:'');?>">
<input type="hidden" name="gid" value="<?=(isset($post['gid'])?$post['gid']:'');?>">
<input type="hidden" name="bid" value="<?=(isset($post['bid'])?$post['bid']:'');?>">
<input type="hidden" name="type" value="<?=(isset($post['type'])?$post['type']:'');?>">
<input type="hidden" name="StartPage" value="<?=(isset($post['StartPage'])?$post['StartPage']:'');?>">

    <div class="my-2">
      <div class="row m-1 text-start vkg border rounded bg-vlight" >
        <? if((isset($data['Error'])&& $data['Error'])){ ?>
        <div class="alert alert-danger alert-dismissible">
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          <strong>Error!</strong>
          <?=prntext($data['Error'])?>
        </div>
        <? }?>
        <h4 class="my-2 text-start">
          <? if($post['action']=='insert_account' || $post['action']=='insert_account_associate'){ ?>
          <i class="<?=$data['fwicon']['circle-plus'];?>"></i> Create New <span  class="text-primary88">
          <?=$acc_arr[2];?>
          </span>
          <? }else{ ?>
          <i class="<?=$data['fwicon']['edit'];?>"></i> Modify <span class="text-primary88">
          <?=$acc_arr[2];?>
          </span> Information
          <? } ?>
        </h4>
        <div class="row col-sm-6 my-2">
			<div class="col-sm-4">Acquirer Id : </div>
          
          <div class="col-sm-8">
			
			
			<input id="mid_name" list="acquirers" name="mid_name" value="<?php if(isset($post['mid_name'])&&$post['mid_name']){ echo $post['mid_name'];}?>" class="form-control" onChange="midnamechange1(this)" required>
				  
			<datalist id="acquirers">
             
                <option value="" disabled="disabled">Select Acquirer Name</option>
                <?
				foreach($data['traTypes'] as $key=>$value){ 
					if((int)$value>6){
				?>
                <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['acquirer_ids'])&&(in_array((int)$value, $_SESSION['acquirer_id'], true)))){?>
                <option value="<?=$value;?>" data-lable="<?=(isset($data['t'][$value]['name1'])?$data['t'][$value]['name1']:'');?>" data-nickname="<?=(isset($value)?$value:'');?>" title="<?=$value;?>" >
               <?=$value;?> | <?=(isset($data['t'][$value]['name1'])?$data['t'][$value]['name1']:'');?>
                </option>
                <?}?>
			<?}}?>
			 </datalist>
			
			  <?
			  if(isset($post['mid_name']))
			  {?>
              <script>$('#mid_name option[value="<?=$post['mid_name']?>"]').prop('selected','selected');</script>
              <?
			  }?>
			  
          </div>
        </div>
        <div class="row col-sm-6 my-2">
          <div class="col-sm-4">Acquirer Name: </div>
          <div class="col-sm-8">
            <input type="hidden" name="nick_name" id="nick_name" value="<?=(isset($post['nick_name'])?$post['nick_name']:'');?>" style="display:none;">
            <div class="nick_nm input3_div float-start" id="nick_name_text">
              <?=(isset($post['nick_name'])?$post['nick_name']:'');?>
                =
                <?=(isset($post['nick_name'])?$data['t'][$post['nick_name']]['name1']:'');?>
            </div>
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">Primary: </div>
          <div class="col-sm-8">
            <select name="primary" id="primary" class="form-select">
              <option value="" disabled="" selected="">Primary</option>
              <option value="1">Yes</option>
              <option value="2">No</option>
            </select>
			
             <?php if(isset($post['primary'])){ ?>
              <script>$('#primary option[value="<?=$post['primary']?>"]').prop('selected','selected');</script>
              <? } ?>
			  
          </div>
        </div>
        <div class="row col-sm-6 my-2">
          <div class="col-sm-4">Processing Mode:
		  <?php if(isset($post['mid_name'])){ ?>
            <script>$('#mid_name option[value="<?=$post['mid_name']?>"]').prop('selected','selected');</script>
			 <? } ?>
          </div>
          <div class="col-sm-8">
            <select name="account_login_url" id="account_login_url" class="form-select">
              <option value="" disabled="" >Processing Mode</option>
              <option value="1">Live</option>
              <option value="2" selected="">Test</option>
              <option value="3">Inactive</option>
            </select>
			<?php if(isset($post['account_login_url'])){ ?>
            <script>$('#account_login_url option[value="<?=$post['account_login_url']?>"]').prop('selected','selected');</script>
			 <? } ?>
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4"><strong>Edit Permission:</strong><span style="margin-top:-16px !important" class="btn-action single " data-toggle="tooltip" data-placement="top" data-original-title="Merchant is not to allowed to Update Account Information in Disable Mode"><i class="<?=$data['fwicon']['circle-question'];?>"></i></span> </div>
          <div class="col-sm-8">
            <select name="edit_permission" id="edit_permission" class="hide">
              <option value="" disabled="" selected="">Edit Permission</option>
              <option value="1">Enable</option>
              <option value="2">Disable</option>
            </select>
			<?php if(isset($post['edit_permission'])){ ?>
            <script>$('#edit_permission option[value="<?=$post['edit_permission']?>"]').prop('selected','selected');</script>
			 <? } ?>
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide1">
          <div class="col-sm-4">Default Currency :</div>
          <div class="col-sm-8">
            <select name="processing_currency" class="form-select" id="processing_currency" onChange="procurrency(this)">
              <option value="" disabled="" selected="">Processing Currency</option>
                <?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
					<option value="<?=get_currency($k11)?> <?=$k11?>"><?=get_currency($k11)?> <?=$k11?></option>
				<?}?>
            </select>
			<?php if(isset($post['processing_currency'])){ ?>
            <script>$('#processing_currency option[value="<?=$post['processing_currency']?>"]').prop('selected','selected');</script>
			<? } ?>
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide1">
          <div class="col-sm-4">
            <?=$acc_arr[2];?>
            Discount Rate(%):</div>
          <div class="col-sm-8">
            <input type="text" name="transaction_rate" id="transaction_rate"  class="form-control" placeholder="5.5%" value="<?=(isset($post['transaction_rate'])?$post['transaction_rate']:'');?>">
          </div>
        </div>
		<?if($data['con_name']=='clk'){?>
		<div class="row col-sm-6 my-2 hide1">
          <div class="col-sm-4">
            <?=$acc_arr[2];?>
            GST Fee(%):</div>
          <div class="col-sm-8">
            <input type="text" name="gst_fee" id="gst_fee"  class="form-control" placeholder="Ex. 28" value="<?=(isset($post['gst_fee'])?$post['gst_fee']:'');?>">
          </div>
        </div>
		<?}?>
        <div class="row col-sm-6 my-2">
          <div class="col-sm-4"><?=$acc_arr[2];?> Txn. Fee (Success):</div>
            
            
          <div class="col-sm-8">
            <input type="text" class="form-control" name="txn_fee" id="txn_fee" size="20" placeholder="0.8" value="<?=(isset($post['txn_fee'])?$post['txn_fee']:'');?>" required>
          </div>
        </div>
        <div class="row col-sm-6 my-2">
          <div class="col-sm-4"> <?=$acc_arr[2];?> Txn. Fee (Failed):</div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="txn_fee_failed" id="txn_fee_failed" size="20" placeholder="" value="<?=(isset($post['txn_fee_failed'])?$post['txn_fee_failed']:'');?>" required>
          </div>
        </div>
        <style>
body .slc_color option[disabled] {
background: #e38d00 !important;color:#fff;
}
body .slc_color option[selected], body .slc_color option[selected]:hover, body .slc_color option[selected]:active, body .slc_color option[selected]:focus, body .slc_color option[selected]:focus-within{
background: #189302 !important;color:#fff;
}
</style>
        <div class="row col-sm-6 my-2">
          <div class="col-sm-4">Display Order:</div>
          <div class="col-sm-8">
            <select class='slc_color form-select' name="shorting" id="shorting" title="Rolling Period" >
              <option title="" value="">Select Display Order</option>
              <?
			$sum = 0;
			for($f = 1; $f <= 290; $f++){ 
				//unset($data['subadmin'][$f]['id']);$sum = $sum + $f;
				if(($_SESSION['shorting_ar'])&&(in_array((int)$f, $_SESSION['shorting_ar'], false))){
			?>
               <option title="<?=(isset($post['shorting'])&&$post['shorting']==$f?"Current":"Added")?> in <?=array_search($f,$_SESSION['shorting_ar']);?> Acquirer" value="<?=$f;?>" <?=(isset($post['shorting'])&&$post['shorting']==$f?"":" disabled='disabled'")?> >
                <?=$f;?>
                :
                <?=(isset($post['shorting'])&&$post['shorting']==$f?"Current":"Added")?>
                in
                <?=array_search($f,$_SESSION['shorting_ar']);?>
                Acquirer </option>
                <? }
				else{ ?>
                <option title="Empty: Addable" value="<?=$f;?>"  >
                <?=$f;?>
                </option>
              <? }
			}
			?>
            </select>
			 <? if(isset($post['shorting'])){ ?>
			  
			  
            <script>$('#shorting option[value="<?=$post['shorting']?>"]').prop('selected','selected');$('#shorting option[value="<?=$post['shorting']?>"]').attr('selected','selected');</script>
			<? } ?>
			
          </div>
        </div>
        <? if((!isset($post['user_type'])||$post['user_type']!="2") && $acc_arr[2]!="Gateway Partner" ) {?>
        <div class="row col-sm-6 my-2">
          <div class="col-sm-4">Rolling Reserve :</div>
          <div class="col-sm-8"><span style="display:inline-flex;">
            <input type="text" name="rolling_fee" class="form-control" id="rolling_fee" size="20" placeholder="10%" 
         value="<?=(isset($post['rolling_fee'])?$post['rolling_fee']:'')?>" style="width:20%;" >
           <a class="m-2">% for</a>
            <select name="rolling_period" id="rolling_period"  class="form-select" title="Rolling Period" style="width:35%;">
              <option value="180" selected>180</option>
              <option value="90">90</option>
              <option value="120">120</option>
              <option value="210">210</option>
              <option value="270">270</option>
              <option value="360">360</option>
            </select>
            <a class="m-2"> Days</a></span>
			<? if(isset($post['rolling_period'])){ ?>
            <script>$('#rolling_period option[value="<?=$post['rolling_period']?>"]').prop('selected','selected');</script>
			<? } ?>
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4"><strong>Min. Settlement Amt.:</strong></div>
          <div class="col-sm-8">
            <input type="text"  style="display:none;" name="settled_amt" id="settled_amt" size="20" value="<?=(isset($post['settled_amt'])?$post['settled_amt']:0);?>">
          </div>
        </div>
        <? } ?>
      </div>
    </div>
    <!--</div>
</div>-->
<div class="my-2">
<div class="row m-1 text-start vkg border rounded bg-warning" >
<div class="row col-sm-6 my-2" >
<div class="col-sm-4"><label title="Scrubbed Period">Scrubbed Period:</label></div>
 <div class="col-sm-8">
              <select name="scrubbed_period" id="scrubbed_period"  class="form-select">
                <option value="" >Scrubbed Period</option>
                <option value="1">1 Day</option>
                <option value="7">7 Days</option>
                <option value="15">15 Days</option>
                <option value="30">30 Days</option>
                <option value="90">90 Days</option>
              </select>
			  <?
			  if(isset($post['scrubbed_period']))
			  {
			  ?>
              <script>$('#scrubbed_period option[value="<?=$post['scrubbed_period']?>"]').prop('selected','selected');</script>
			  <?
			  }?>
			  </div>
</div>
			  
<div class="row col-sm-6 my-2" >
<div class="col-sm-4"><label title="Min. Transaction Limit:">Min. Transaction Limit:<font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label></div>
<div class="col-sm-8"><input type="text" name="min_limit" id="min_limit" class="form-control"  value="<?=(isset($post['min_limit'])?$post['min_limit']:'');?>"></div>
</div>

<div class="row col-sm-6 my-2" >
<div class="col-sm-4">
<label title="Max. Transaction Limit">Max. Transaction Limit: <font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label>
</div>
<div class="col-sm-8">
<input type="text" name="max_limit" id="max_limit" class="form-control" value="<?=(isset($post['max_limit'])?$post['max_limit']:'');?>">
</div>
</div>


<div class="row col-sm-6 my-2" >
<div class="col-sm-4">
<label title="Transaction Count">Transaction Count:</label>
</div>
<div class="col-sm-8">
<input type="text" name="transaction_count" id="transaction_count" class="form-control"  value="<?=(isset($post['transaction_count'])?$post['transaction_count']:'')?>">
</div>
</div>

<div class="row col-sm-6 my-2" >
<div class="col-sm-4">
<label title="Min. Success Count">Min. Success Count:</label>
</div>
<div class="col-sm-8">
<input type="text" name="tr_scrub_success_count" id="tr_scrub_success_count" class="form-control"  value="<?=(isset($post['tr_scrub_success_count'])&&$post['tr_scrub_success_count'])?$post['tr_scrub_success_count']:'2'?>">
</div>
</div>

<div class="row col-sm-6 my-2" >
<div class="col-sm-4">
<label title="Min. Failed Count">Min. Failed Count:</label>
</div>
<div class="col-sm-8">
<input type="text" name="tr_scrub_failed_count" id="tr_scrub_failed_count" class="form-control"  value="<?=(isset($post['tr_scrub_failed_count'])&&$post['tr_scrub_failed_count'])?$post['tr_scrub_failed_count']:'5'?>">
</div>
</div>

<div class="row col-sm-6 my-2 hide" >
<div class="col-sm-4">
<label title="Account Setup Fee (USD)">Setup Fee (USD):</label>
</div>
<div class="col-sm-8">
<input type="text" name="setup_fee" id="setup_fee" class="form-control" value="<?=(isset($post['setup_fee'])?$post['setup_fee']:'');?>">
</div>
</div>

<div class="row col-sm-6 my-2 hide" >
<div class="col-sm-4">
<label title="Account Setup Fee Status">Setup Fee  Collected:</label>
</div>
<div class="col-sm-8">
 <select name="setup_fee_status" id="setup_fee_status"  class="form-select">
                <option value="0" selected>Not Yet</option>
                <option value="1">Yes</option>
              </select>
			  <?
			  if(isset($post['setup_fee_status']))
			  {?>
              <script>$('#setup_fee_status option[value="<?=$post['setup_fee_status']?>"]').prop('selected','selected');</script>
			  <?
			  }?>
</div>
</div>
             
			  <? /* ?> <? if(isset($post['action'])&&($post['action']!='insert_account')) { ?>
              <div align="right" style="padding:0 10px 10px 0;clear:both;"> <a class="glyphicons2 iframe_open" data-mid="<?=(isset($_GET['bid'])?$_GET['bid']:'');?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Admins'];?>/scrubbed<?=$data['ex']?>?hideAllMenu=1&type=active&curr=<?=(isset($pro_cur)?$pro_cur:'');?>" style="background-color:#37a238!important;color:#fff!important;border:1px solid #37a238 !important;display:block;width:120px;text-align:center;padding:5px 0;margin:6px 0 0 0;border-radius:3px;margin-right: 40px;"> ADD SCRUBBED</a> </div>
			  <? } ?><? */ ?>
             

</div></div>
    
	<? if((!isset($post['user_type'])||$post['user_type']!="2") && $acc_arr[2]!="Gateway Partner" ) {?>
    <!--<div class="widget-body input_col_3" style="padding-bottom: 0;background: transparent !important;">
          <div class="row-fluid">-->
    <div class="my-2" >
      <div class="row m-1 text-start vkg border rounded bg-success text-white" >
	 
	 <? if(isset($post['action'])&&($post['action']=='insert_account')) { ?>
   
			<div class="row col-sm-6 my-2" >
		
          <div class="col-sm-4">
            <label title="Scrubbed Period">Scrubbed Period<span class="mand">*</span> :</label>
          </div>
          <div class="col-sm-8">
            <select name="scrubbed_json[sp_1][scrubbed_period]" id="scrubbed_period" onchange="input_add_scrubbed(this,this.value);"  class="form-select scrubbed_period_mlt" style="height: 40px;">
              <option value="" disabled="" selected="">Scrubbed Period</option>
              <option value="1">1 Day</option>
              <option value="7">7 Days</option>
              <option value="15">15 Days</option>
              <option value="30">30 Days</option>
              <option value="90">90 Days</option>
            </select>
            <?
			  if(isset($post['scrubbed_period']))
			  {
			  ?>
              <script>$('#scrubbed_period option[value="<?=$post['scrubbed_period']?>"]').prop('selected','selected');</script>
			  <?
			  }?>
          </div>
        </div>
		
		 <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Min. Transaction Limit:">Min. Transaction Limit<span class="mand">*</span>:<font class="acct_curr text-primary88 ms-1">
            <?=(isset($pro_cur)?$pro_cur:'');?>
            </font></label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="scrubbed_json[sp_1][min_limit]" value="1" id="min_limit"  placeholder="Enter Min. Transaction Limit" class="form-control min_limit_mlt" >
          </div>
        </div>
		
		<div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Max. Transaction Limit">Max. Transaction Limit<span class="mand">*</span>: <font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="scrubbed_json[sp_1][max_limit]" value="500" id="max_limit" placeholder="Enter Max. Transaction Limit" class="form-control max_limit_mlt" >
          </div>
        </div>
		
		<div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="">Min. Success Count<span class="mand">*</span>:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="scrubbed_json[sp_1][tr_scrub_success_count]" id="tr_scrub_success_count" class="form-control tr_scrub_success_count_mlt" value="3" placeholder="Enter Min. Success Count" >
          </div>
        </div>
		
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="">Min. Failed Count<span class="mand">*</span>:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="scrubbed_json[sp_1][tr_scrub_failed_count]" value="7" id="tr_scrub_failed_count" class="form-control tr_scrub_failed_count_mlt" placeholder="Enter Min. Failed Count" >
          </div>
        </div>
		
		
		   <?/*?>
		  <a class="remove_row" title="Remove" onclick="remove_data(&quot;mydiv1&quot;,&quot;Scrubbed Period :: 30 Day/S&quot;)"><strong>X</strong></a>
		  
		  <?*/?>
            
	<? } ?>  
	

     
        <? if(isset($_GET['bid'])&&$_GET['bid']<>""){?>
        <div  class="text-end"> <a class="btn btn-primary btn-sm iframe_open99 m-2" data-mid="<?=$_GET['bid']?>" data-href="" data-tabname="" data-url="" onclick="iframe_open_modal(this)" data-ihref="<?=$data['Admins'];?>/scrubbed<?=$data['ex']?>?hideAllMenu=1&type=active&curr=(<?=(isset($pro_cur)?$pro_cur:'');?>)&id=<?=$_GET['id']?>&mid=<?=$_GET['bid']?>" > Add Scrubbed</a> </div>
        <? } ?>
      </div>
    </div>
    <!-- </div>
        </div>-->
    <!--=========Multi Scrubbed==   -->
	<? if(isset($post['scrubbed_json'])) { ?>
    <div class="my-2" style="background: #e4f2ea;">
      <h4 class="mx-2 text-start">Multiple Scrubbed </h4>
      <?php
		$datascrubbed =  json_decode($post['scrubbed_json'],1);
		$j=1;
		foreach($datascrubbed as $k => $v){
		$sp_kay=$k;
		$i=0;
		
		  if(is_array($v)){
		  echo '<div id="mydiv'.$j.'">';
		  echo "<h2>&nbsp;&nbsp;&nbsp;Scrubbed Period :: ".str_replace('sp_','',$sp_kay)." Day/S </h2>";
		   $cap="Scrubbed Period :: ".str_replace('sp_','',$sp_kay)." Day/S";
		 ?>
      <!--=====================-->
      <div class="row m-1 text-start vkg border rounded" >
        <div class="col-sm-12 my-2 px-3  text-end"> <a class='remove_row' title='Remove' onclick='remove_data("mydiv<?=$j;?>","<?=$cap;?>")'><i class="<?=$data['fwicon']['circle-cross'];?> text-danger"></i></a> </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Min. Transaction Limit:">Min. Transaction Limit: <font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label>
          </div>
          <div class="col-sm-8">
            <input type="hidden" name="scrubbed_json[<?=$k?>][scrubbed_period]" value="<?=$v['scrubbed_period']?>" />
            <input type="text" class="form-control" name="scrubbed_json[<?=$k?>][min_limit]" value="<?=$v['min_limit']?>" placeHolder="Enter Min. Transaction Limit" required />
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Max. Transaction Limit">Max. Transaction Limit:<font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font> </label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="scrubbed_json[<?=$k?>][max_limit]" value="<?=$v['max_limit']?>" placeHolder="Enter Max. Transaction Limit" required />
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="">Min. Success Count:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="scrubbed_json[<?=$k?>][tr_scrub_success_count]" value="<?=$v['tr_scrub_success_count']?>" placeHolder="Enter Min. Success Count" required />
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="">Min. Failed Count:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="scrubbed_json[<?=$k?>][tr_scrub_failed_count]" value="<?=$v['tr_scrub_failed_count']?>" placeHolder="Enter Min. Failed Count" required />
          </div>
        </div>
      </div>
      <!--==========================   -->
      <?


		  }
		$j++;
		echo "</div>";
		}
		
		?>
    </div>
	<?}?>
    <!--=========================   -->
    <!--<div class="widget-body input_col_3" style="padding-bottom: 0;background: transparent !important;">
          <div class="row-fluid">-->
    <div class="my-2" >
      <div class="row m-1 text-start vkg border rounded" style="background: #d1d1d1;">
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="Monthly Maintenance Fee">Monthly Maintenance Fee: <font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="monthly_fee" id="monthly_fee" value="<? if(isset($post['monthly_fee'])) echo $post['monthly_fee']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="<?=$crbk_1;?>">CB Fee Tier 1: <font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="charge_back_fee_1" id="charge_back_fee_1" class="form-control" value="<? if(isset($post['charge_back_fee_1'])) echo $post['charge_back_fee_1']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="<?=$crbk_2;?>">CB Fee Tier 2: <font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="charge_back_fee_2" id="charge_back_fee_2" class="form-control" value="<? if(isset($post['charge_back_fee_2'])) echo $post['charge_back_fee_2']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="<?=$crbk_3;?>">CB Fee Tier 3: <font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="charge_back_fee_3" id="charge_back_fee_3" class="form-control" value="<? if(isset($post['charge_back_fee_3'])) echo $post['charge_back_fee_3']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="CBK1">CBK1:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="cbk1" id="cbk1" class="form-control" value="<? if(isset($post['cbk1'])) echo $post['cbk1']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="">Refund Fee: <font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="refund_fee" id="refund_fee" class="form-control" value="<? if(isset($post['refund_fee'])) echo $post['refund_fee']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="" class="hide">Settlement Wire Fee: <font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label>
          </div>
          <div class="col-sm-8">
            <input type="text" style="display:none;" name=r"eturn_wire_fee" id="return_wire_fee" class="form-control" value="<? if(isset($post['return_wire_fee'])) echo $post['return_wire_fee']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="">Settlement Period:</label>
          </div>
          <div class="col-sm-8">
            <select name="settelement_period" class="form-select" id="settelement_period">
              <option value="" disabled="" selected="">Settlement Period</option>
              <option value="0.00">Instant (0) Day</option>
              <option value="1">1 Day</option>
              <option value="2">2 Days</option>
              <option value="3">3 Days</option>
              <option value="4">4 Days</option>
              <option value="5">5 Days</option>
              <option value="6">6 Days</option>
              <option value="7">7 Days</option>
              <option value="8">8 Days</option>
              <option value="9">9 Days</option>
              <option value="10">10 Days</option>
              <option value="11">11 Days</option>
              <option value="12">12 Days</option>
              <option value="13">13 Days</option>
              <option value="14">14 Days</option>
              <option value="15">15 Days</option>
              <option value="16">16 Days</option>
              <option value="17">17 Days</option>
              <option value="18">18 Days</option>
              <option value="19">19 Days</option>
              <option value="20">20 Days</option>
              <option value="21">21 Days</option>
              <option value="22">22 Days</option>
              <option value="23">23 Days</option>
              <option value="24">24 Days</option>
              <option value="25">25 Days</option>
              <option value="26">26 Days</option>
              <option value="27">27 Days</option>
              <option value="28">28 Days</option>
              <option value="29">29 Days</option>
              <option value="30">30 Days</option>
            </select>
			<? if(isset($post['settelement_period'])){ ?>
            <script>$('#settelement_period option[value="<?=$post['settelement_period']?>"]').prop('selected','selected');</script>
			<? } ?>
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Settlement Report View">Settlement Report View:</label>
          </div>
          <div class="col-sm-8">
            <select name="view_settelement_report" class="form-select" id="view_settelement_report">
              <option value="" disabled="" >Download Report</option>
              <option value="1">Allowed</option>
              <option value="2">Not Allowed</option>
            </select>
            <script>$('#view_settelement_report option[value="<?=$post['view_settelement_report']?>"]').prop('selected','selected');</script>
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="Virtual Terminal Fee">Virtual Terminal Fee: <font class="acct_curr text-primary88 ms-1"><?=(isset($pro_cur)?$pro_cur:'');?></font></label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="virtual_fee" id="virtual_fee" class="form-control" value="<? if(isset($post['return_wire_fee'])) echo $post['virtual_fee']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="Virtual Terminal Fee">MOTO:</label>
          </div>
          <div class="col-sm-8">
            <select name="vt" id="vt" class="form-select">
              <option value="" disabled="" selected="">MOTO</option>
              <option value="1">Allowed</option>
              <option value="2">Not Allowed</option>
            </select>
            <script>$('#vt option[value="<?=$post['vt']?>"]').prop('selected','selected');</script>
          </div>
        </div>
      </div>
    </div>
    <!--</div>
        </div>-->
    <!--    <div class="widget-body input_col_3">
		
          <div class="row-fluid">-->
    <div class="my-2" >
      <div class="row m-1 text-start vkg border rounded" style="background: #c1d5ac;">
        <div class="row col-sm-12 my-2 ">
          <div class="col-sm-2">
            <label title="Bank Siteid">Bank Siteid:</label>
          </div>
          <div class="col-sm-10">
<textarea class="textAreaAdjust form-control" onkeyup="textAreaAdjust(this)" rows="1" name="hkip_siteid" id="hkip_siteid" ><? if(isset($post['hkip_siteid'])) echo $post['hkip_siteid']?></textarea>
          </div>
        </div>
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['add_listed_salt_in_acquirer'])&&$_SESSION['add_listed_salt_in_acquirer']==1)){ ?>
        <script>
		function salt_edit_url(e){
			var thisVal=$(e).val();
			if($('#salt_edit_id')){
				$('#salt_edit_id').attr('data-ihref',"<?=$data['Admins'];?>/salt_management<?=$data['ex']?>?id="+thisVal+"&action=update&hideAllMenu=1&type=active");
			}
		}
	</script>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Bank Siteid" style="clear:left;">Bank Salt ID:</label>
          </div>
          <div class="col-sm-8">
            <input id="salt_id" list="datalist_salt_id" name="salt_id" value="<? if(isset($post['salt_id'])) echo $post['salt_id']?>" onchange="salt_edit_url(this)" class="form-control" />
            <datalist id="datalist_salt_id">
              <?=($post['nick_name']?showselectlist($post['nick_name']):"");?>
            </datalist>
          </div>
        </div>
        <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['edit_salt'])&&$_SESSION['edit_salt']==1)){ ?>
        <div class="col-sm-6 my-2 "> <a class="saltpop22 datahref1 hrefmodal1 nopopup btn btn-primary" id="salt_edit_id" onclick="iframe_open_modal(this);" data-ihref="<?=$data['Admins'];?>/salt_management<?=$data['ex']?>?id=<? if(isset($post['salt_id'])) echo $post['salt_id']?>&action=update&hideAllMenu=1&type=active" >Edit Salt</a></div>
        <? } ?>
        <? } ?>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Checkout Level Name">Checkout Level Name:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="checkout_level_name" id="checkout_level_name"  
	value="<? if(isset($post['checkout_level_name'])) echo $post['checkout_level_name']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Descriptor">Descriptor :</label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="descriptor" id="descriptor"  value="<? if(isset($post['descriptor'])) echo $post['descriptor']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Merchant Preferences">Merchant Preferences:</label>
          </div>
          <div class="col-sm-8">
            <div class="input_col_2 checkbox2 float-start">
              <input type="checkbox" name='notification_to[]' id='notification_to5' class='checkbox_d form-check-input' size="100" value='005' <?php if(isset($post['notification_to'])&&strpos($post['notification_to'],"005")!==false){echo "checked='checked'";} ?>>
              <label for="notification_to5" class="my-1">Encrypt Customer Email</label>
            </div>
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="" class="hide">Transaction Notification Email:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" style="display:none;" class="form-control" name="transaction_notification_email" id="transaction_notification_email"  value="<?=(isset($post['transaction_notification_email'])?encrypts_decrypts_emails($post['transaction_notification_email'],2):'');?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="DBA/Brand Name" class="hide">DBA/Brand Name:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="dba_brand_name" class="form-control" style="display:none;" id="dba_brand_name" value="<? if(isset($post['dba_brand_name'])) echo $post['dba_brand_name']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="" class="hide"><strong>Card Type:</strong></label>
          </div>
          <div class="col-sm-8">
            <div class='checkbox_div float-start hide'>
              <input type=checkbox name='card_type[]' id='card_type_001' class='checkbox_d' size="100" value='001' <?php if(strpos($post['card_type'],"001")!==false){echo "checked='checked'";} ?>>
              <label for="card_type_001" >Visa Card</label>
            </div>
            <div class='checkbox_div float-start hide'>
              <input type=checkbox name='card_type[]' id='card_type_002' class='checkbox_d' size="100" value='002' <?php if(strpos($post['card_type'],"002")!==false){echo "checked='checked'";} ?>>
              <label for="card_type_002">Master Card</label>
            </div>
            <div class='checkbox_div float-start hide'>
              <input type=checkbox name='card_type[]' id='card_type_003' class='checkbox_d' size="100" value='003' <?php if(strpos($post['card_type'],"003")!==false){echo "checked='checked'";} ?>>
              <label for="card_type_003">Amex Card</label>
            </div>
            <div class='checkbox_div float-start hide'>
              <input type=checkbox name='card_type[]' id='card_type_004' class='checkbox_d' size="100" value='004' <?php if(strpos($post['card_type'],"004")!==false){echo "checked='checked'";} ?>>
              <label for="card_type_004">JCB Card</label>
            </div>
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="Bussiness URL" class="hide"><strong>Bussiness URL:</strong></label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="bussiness_url" style="display:none;" class="form-control" id="bussiness_url"  
			  value="<?=$post['bussiness_url']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="Customer Service No." class="hide"><strong>Customer Service No.:</strong></label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="customer_service_no" class="form-control" style="display:none;" id="customer_service_no" 
			  value="<?=$post['customer_service_no']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="Customer Service Email" class="hide"><strong>Customer Service Email:</strong></label>
          </div>
          <div class="col-sm-8">
            <input type="text" name="customer_service_email" class="form-control" style="display:none;" id="customer_service_email" 
			  value="<?=(isset($post['customer_service_email'])?encrypts_decrypts_emails($post['customer_service_email'],2):'');?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="T&amp;C" class="hide"><strong>T&amp;C:</strong></label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" style="display:none;" name="merchant_term_condition_url" 
			  id="merchant_term_condition_url" value="<?=$post['merchant_term_condition_url']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="Refund Policy" class="hide"><strong>Refund Policy:</strong></label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" style="display:none;" name="merchant_refund_policy_url" 
			  id="merchant_refund_policy_url" value="<?=$post['merchant_refund_policy_url']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="Privacy Policy" class="hide"><strong>Privacy Policy:</strong></label>
          </div>
          <div class="col-sm-8">
            <input type="text" style="display:none;" class="form-control" name="merchant_privacy_policy_url" 
			  id="merchant_privacy_policy_url" value="<?=$post['merchant_privacy_policy_url']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="" class="hide"><strong>Contact US:</strong></label>
          </div>
          <div class="col-sm-8">
            <input style="display:none;" class="form-control" type="text" name="merchant_contact_us_url" id="merchant_contact_us_url" 
			  value="<?=$post['merchant_contact_us_url']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 hide">
          <div class="col-sm-4">
            <label title="Logo" class="hide"><strong>Logo:</strong></label>
          </div>
          <div class="col-sm-8">
            <input style="display:none;" class="form-control" type="text" name="merchant_logo" id="merchant_logo" 
			  value="<?=$post['merchant_logo']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Visa Rate" style="clear:left;">Visa Rate:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="mdr_visa_rate" id="mdr_visa_rate" value="<? if(isset($post['mdr_visa_rate'])) echo $post['mdr_visa_rate']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Master Rate">Master Rate:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="mdr_mc_rate" id="mdr_mc_rate" value="<? if(isset($post['mdr_mc_rate'])) echo $post['mdr_mc_rate']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="JCB Rate">JCB Rate:</label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="mdr_jcb_rate" id="mdr_jcb_rate" value="<? if(isset($post['mdr_jcb_rate'])) echo $post['mdr_jcb_rate']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Amex Rate">Amex Rate: </label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="mdr_amex_rate" id="mdr_amex_rate" value="<? if(isset($post['mdr_amex_rate'])) echo $post['mdr_amex_rate']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label class="hide" title="Account Custom field 14"><strong>Account Custom field 14:</strong></label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" style="display:none;" name="account_custom_field_14" id="account_custom_field_14" 
			  value="<? if(isset($post['account_custom_field_14'])) echo $post['account_custom_field_14']?>">
          </div>
        </div>
        <div class="row col-sm-6 my-2 ">
          <div class="col-sm-4">
            <label title="Login Required" class="hide"><strong>Login Required:</strong></label>
          </div>
          <div class="col-sm-8">
            <select class="hide form-select" name="login_required" id="login_required">
              <option value="" selected="">Login Required</option>
              <option value="1">Allowed</option>
              <option value="2">Not Allowed</option>
            </select>
            <script>$('#login_required option[value="<?=$post['login_required']?>"]').prop('selected','selected');</script>
          </div>
        </div>
		
<div class="row col-sm-12 my-2 ">
<a class="btn btn-primary ms-1" data-bs-toggle="collapse" data-bs-target="#relatedrate" aria-expanded="false" aria-controls="relatedrate" style="width:50px;" >
<i class="<?=$data['fwicon']['square-plus'];?>" title="Add Intermediary Bank Details"></i>
</a>
  
<div class="collapse" id="relatedrate">
<div class="row border border-info bg-light rounded">
<div class="col-sm-4 px-2 my-2">
<input type="text" class="form-control" name="intermediary" id="intermediary" placeholder="code" title="Enter your intermediary <?=$post['swift_con'];?> code" value=""/>
</div>

<div class="col-sm-4 px-2  my-2">
                      
<input <?=$ep;?> type="text" class="form-control" name="intermediary_bank_name" id="intermediary_bank_name" placeholder="Bank Name" title="Enter your intermediary bank name" value="<?=prntext(((isset($post['intermediary_bank_name']) &&$post['intermediary_bank_name'])?$post['intermediary_bank_name']:''));?>" />
                      
</div>

<div class="col-sm-4 px-2  my-2">
                      
                        <input <?=$ep;?> type="text" class="form-control" name="intermediary_bank_address" id="intermediary_bank_address" placeholder="Bank Address" title="Enter your Intermediary Bank Address" value="<?=prntext(((isset($post['intermediary_bank_address']) &&$post['intermediary_bank_address'])?$post['intermediary_bank_address']:''));?>" />
                      
                    </div>
                 


</div>
</div>

		</div>
      </div>
    </div>
    <!--  </div>
        </div>-->
    <!--</div>-->
    <? } ?>
    <div class="my-2 text-center row p-0"	>
      <div class="col-md-12 my-2 ps-0 text-center">
        <button class="btn btn-icon btn-primary " type="submit" name="send" id="send" value="Save Changes"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Submit</button>
       <a href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?id=<?=$_GET['id']?>&action=detail<?=($data['is_admin_link']);?>&tab_name=collapsible6" class="btn btn-primary " id="back"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
    </div>
    </table>
  </form>
  <script>
  
	
	
   $("form").submit(function(){
		 $("#send").hide();
		  $("#back").hide();
	});
	
	<? if($post['action']=='insert_account'&&isset($_GET['add_template'])){ ?>
		
		
		$("#mid_name option[title='<?=$_GET['add_template'];?>']").prop('selected','selected').trigger("change");
		$('#account_login_url option[value="1"]').prop('selected','selected');
		$("#send").trigger("click");
		//$("#mid_name").trigger("change");
		//$("form").submit();
	<? } ?>
  </script>
  <? }else{ ?>
  All changes was stored in the database.<br>
  <br>
  <hr>
  <br>
  <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&bid=<?=$post['bid']?>&action=update_account&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>">Back</a> | <a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['gid']?>&action=detail&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>#midaccount">Detail</a>
  <? } ?>
  <? } ?>
</div>
<script type="text/javascript">
			  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
})
			  </script>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
<?php if(isset($post['bank_doc'])&&$post['bank_doc']){ ?>
<script>show_image();</script>
<? } ?>
<? if(isset($post['MemberInfo']['upload_logo'])&&$post['MemberInfo']['upload_logo']){ ?>
<? } ?>
<style>
.prompt_dialog {display:none;position:fixed;z-index:9999999;width:300px;    height:220px;margin:-95px 0 0 -150px;background:#fff;opacity:1;border-radius:5px;left:50%;top:50%;border:2px #d2d2d2 solid;font-size:14px;}
.title_bar {/*background:#37a6cd;color:#fff;height:24px;line-height:24px;*/}
.title3 {/*padding:0 0 0 10px;*/}
</style>
<div id="dialog_box2" class="hide prompt_dialog" >
  <div class="bg-vdark text-vlight m-1 title_bar rounded"><span id="ui_id_1" class="title3 p-2">Modify with Base Rate</span><a class="dialog_box2_close" role="button" style="float:right;"><span class="ui-icon ui-icon-closethick mx-2 text-vlight">X</span></a></div>
  <div style="padding:10px;">
   <select name="transaction_processing_mode" id="transaction_processing_mode" class="form-select my-2" title="Processing Mode">
		<option value="" disabled="">Processing Mode</option>
		<option value="1" selected>Live</option>
		<option value="2">Test</option>
		<option value="3">Inactive</option>
	</select>
    <input type="text" id="baseRate_transaction_rate" name="baseRate_transaction_rate" value="" class="form-control my-2" placeholder="MDR Rate(%)" />
    
<input type="text" value="" name="baseRate_txn_fee" id="baseRate_txn_fee"  class="form-control my-2" placeholder="Txn. Fee (Success)" />
    
    <div class="ui-dialog-buttonset text-center my-2">
      <button id="baseRate_submit" type="submit" name="cardsend" value="CHECKOUT" class="submit btn btn-icon btn-primary btn-sm"><i class="<?=$data['fwicon']['check-circle'];?>"></i><b class="contitxt"> Submit</b></button>
      <button type="submit" name="cardsend" value="CHECKOUT" class="dialog_box2_close btn btn-icon btn-primary btn-sm"><i class="<?=$data['fwicon']['check-cross'];?>"></i><b class="contitxt"> Cancel</b></button>
    </div>
  </div>
</div>
<script>

$(document).ready(function(){
	$('.saltpop').click(function(){	
		//var subqry=$.trim($(this).text());
		//var sltId = document.getElementById('salt_id').value;
		var sltId = $("#salt_id").val(); 
	
		var mid = $(this).attr('data-mid');
		if(mid !== undefined){subqry=$.trim(mid);}
		$('.saltpop').removeClass('mactive');
		$(this).addClass('mactive');
		
		
		
		var urls="<?=$data['Admins']?>/salt_management<?=$data['ex']?>?action=update&hideAllMenu=1&type=active&id="+sltId;
		$("#modal_popup_iframe_div").html("<div class='loading'>Now loading url is : "+urls+".<br/><br/><img src='<?php echo $data['Host']?>/images/icons/loading_spin_icon.gif' style='width:270px;position:relative;top:-180px;'> <div class='waitxt plea1'>Please wait...</div></div>");
		var saltpopdata='<iframe name="modal_popupframe" id="modal_popupframe" src='+urls+' width="100%" height="520" scrolling="auto" frameborder="0" marginwidth="0" marginheight="0" style="width:100%!important;height:520px!important;display:block;margin:20px auto;" ></iframe>';
		
		//alert(urls);
		
		$("#modal_popup_iframe_div").html(saltpopdata);
		
		/*
		$.ajax({url:urls, success: function(result){
			$("#modal_popup_iframe_div").html(saltpopdata);
		}});
		*/
		
		$('#modal_popup_popup').slideDown(900);
    });
	
   
});
</script>
<script type="text/javascript">
function remove_data(divName,thisVal) {
var myobj = document.getElementById(divName);
var result = confirm('Want to remove '+thisVal+'?');
		if (result) {
			myobj.remove();
		}

	}
</script>
<script>
function checkAvailability_swift() {
	$("#loaderIcon").show();
	$.ajax({
	url: "<?=$data['Host'];?>/include/check_availability<?=$data['ex']?>",
	data:'tbl=swift_code&bswift='+$("#bswift").val(),
	type: "POST",
	success:function(data){
	//alert(data);
	var obj = JSON.parse(data);
	//alert(obj.valid);
	//alert(obj.bank);
	//alert(obj.city);
	//alert(obj.branch);
	//alert(obj.country);
	
	
	if(obj.valid==1){
	 //alert("Valid Swift Code");
	 document.getElementById('bname').value = obj.bank;
	 document.getElementById('baddress').value = obj.branch + " "+ obj.city + " , "+ obj.country;
	 $('#swiftmsg').attr('class','col-sm-12 px-1 alert alert-success');
	 //$('#basicidx i').prop('title', 'Valid Swift Code');
	 document.getElementById('swiftmsg').innerHTML=" <i class='ps-3 m-0 <?=$data['fwicon']['check-circle'];?> text-success'></i> SWIFT Code Verified ";
	}else{
	//alert("Inalid Swift Code");
	$('#swiftmsg').attr('class','col-sm-12 px-1 alert alert-danger');
	//$('#basicidx i').prop('title', 'Invalid Swift Code');
	document.getElementById('swiftmsg').innerHTML=" <i class='ps-3 m-0 <?=$data['fwicon']['circle-cross'];?> text-danger'></i> We are unable to verify this SWIFT number via our Bank Directory. Click Okay and proceed if your SWIFT details is correct ";
	}
	
		$("#swift_code_status").html(data);
		$("#loaderIcon").hide();
	},
	error:function (){}
	});
}
</script>

<script>
$(document).ready(function(){
   $("#email_toggle").click(function(){
      if($(this).hasClass('active')){
			$(this).removeClass('active');
			$(".email_hide").hide();
		}else{
			$(this).addClass('active');
			$(".email_hide").css({"display":"flex"});
		}
  });
  /* Function for switch QR Request and Payout Request Enable / Disable */
  $(".update_merchant_profile").click(function(){
 
  var pval=$(this).val(); //alert(pval);
  var ptype=$(this).attr("vdata"); //alert(ptype);
  //alert(ptype);
  //alert(pval);
   
   if(ptype=="payout_request"){
   		if(pval==1){
		//alert('Live');
		$(".v_test").prop("checked",false);
		$(".v_inactive").prop("checked",false);
		$(".v_live").prop("checked",true);
		}else if(pval==2){
		//alert('Test');
		$(".v_live").prop("checked",false);
		$(".v_inactive").prop("checked",false);
		$(".v_test").prop("checked",true);
		}else if(pval==3){
		//alert('Inactive');
		$(".v_test").prop("checked",false);
		$(".v_live").prop("checked",false);
		$(".v_inactive").prop("checked",true);
		}else{
		//alert('wwww');
		}
   }else if(ptype=="qrcode_gateway_request"){
   		if(pval==1){
		$(".q_test").prop("checked",false);
		$(".q_inactive").prop("checked",false);
		$(".q_live").prop("checked",true);
		}else if(pval==2){
		$(".q_live").prop("checked",false);
		$(".q_inactive").prop("checked",false);
		$(".q_test").prop("checked",true);
		}else if(pval==3){
		$(".q_test").prop("checked",false);
		$(".q_live").prop("checked",false);
		$(".q_inactive").prop("checked",true);
		}else{
		//alert('wwww');
		}
   }
   
       <? if(isset($post['gid'])&&$post['gid']){ ?>
 	
		//comment by  on 11-01, because returned an error at the time of add new merchant
		$.ajax({
			type: "POST",
			url: "../include/update_merchant_profile<?=$data['ex'];?>",
			data: { memid: <?=$post['gid']?>, ptype : ptype , pval : pval} 
		}).done(function(data){
			//alert(data);
			$("#displresult").html(data);
			
		});
		
		<? } ?>
		
  
   });

  



});


  
   $('#business_ims_type').on('change', function() {
	   var bims = $('#business_ims_type').val();
	});
	
	function confirm_remove(e, id=null){
	var retVal= confirm('Are you sure remove Payout Secret Key?');
	if (retVal) {
		location.href="<?=$data['Admins']?>/merchant<?=$data['ex'];?>?action=remove_payout_key&id=<?=$post['gid'];?>";
		return true;
	} else {			
		return false;
	}
}
  
		$('.usrnam').keyup(function(){
		//alert("999");
		this.value = this.value.toLowerCase();
		});

//$('#myModal .modal-dialog').css("max-width", "800px !important");
$('#myModal .modal-dialog').css({"max-width":"90% !important"});
$('#loading_css').find('.loading_img').addClass('6677');
$('#username').keyup(function(){
	this.value = this.value.toLowerCase();
});
</script>

<?php /*?>////////////Start Ratio Realtime Double Calender Script Added By Vikash on 12012023////////<?php */?>

<?
$start_ratio	= date('Y-m-d H:i:s');
$end_ratio	= date('Y-m-d H:i:s', strtotime("+ $ratio_period days"));
?>

<script>

var start_ratio = "<?=((isset(($start_ratio))&&($start_ratio))?(date('m/d/Y H:i',strtotime($start_ratio))):'')?>";
var end_ratio = "<?=((isset(($end_ratio))&&($end_ratio))?(date('m/d/Y H:i',strtotime($end_ratio))):'')?>";


$(function() {

	$('input[name="ratio_time_period"]').daterangepicker({
		autoUpdateInput: false,
		timePicker: true,
		timePicker24Hour: true,
		
		startDate: start_ratio,
		endDate: end_ratio,
		locale: {
			cancelLabel: 'Clear',
			format: 'M/DD HH:mm'
		}
	});

	$('input[name="ratio_time_period"]').on('apply.daterangepicker', function(ev, picker) {
		$(this).val(picker.startDate.format('YYYY-MM-DD 00:00:00') + ' to ' + picker.endDate.format('YYYY-MM-DD 23:59:59'));
		
		$("#ratio_date_1st").val(picker.startDate.format('YYYY-MM-DD 00:00:00'));
		$("#ratio_date_2nd").val(picker.endDate.format('YYYY-MM-DD 23:59:59'));
	});
	
	$('input[name="ratio_time_period"]').on('cancel.daterangepicker', function(ev, picker) {
		$(this).val('<? if(isset($ratio_time_period)) echo $ratio_time_period;?>');
	});
	
});
</script>
<?php /*?>///////////////////End Ratio Realtime Double Calender Script ////////////////////<?php */?>