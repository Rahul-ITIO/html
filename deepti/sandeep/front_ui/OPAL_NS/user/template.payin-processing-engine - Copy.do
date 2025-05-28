<? 
$data['con_name']='clk';
if(isset($_REQUEST['fullname'])){
	$post['fullname']=stf($_REQUEST['fullname']);
}
//echo $SiteName=$_SESSION['domain_server']['as']['SiteName'];
//print_r($_SESSION);
//print_r($post);

$post['bill_amt']=(isset($post['total'])&&$post['total']?$post['total']:(isset($post['bill_amt'])?$post['bill_amt']:''));

$sub_icon_more='<span class="qr_icon_1" style="position:relative;top:4px;margin:0 10px 0 0;"><i class="'.$data['fwicon']['qrcode'].' text-info" title="UPI Payment"></i> <i class="'.$data['fwicon']['qrcode'].' icon-position" title="UPI Payment"></i></span>'."<img src='".$data['bankicon']['google-pay-svg']."' alt='google-pay'>&nbsp;<img src='".$data['bankicon']['phonepe-svg']."' alt='phonepe'>&nbsp;<img src='".$data['bankicon']['paytm-svg']."' alt='paytm'> & More";

?>
<script language="javascript" type="text/javascript"> 
var wn=0; var ajaxBinVar=0; var logs=[];
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 

<div class="hide" style="display:none">
	<div class="alert_msg_2" title="No Payment Chanel Available to process this card">No Payment Chanel Available to process this card</div><div class="alert_msg_3" title="Please enter correct CVV">Please enter correct CVV and cannot empty </div>
</div>


<div class="container clients_pro">
<? if((isset($_SESSION['login']))&&(isset($post['action'])&&$post['action']=="vt")){?>
  <? $c_style="style='float:none;'"; ?>
  <ul class="breadcrumb" style="text-align:left;">
	<li><a href="<?=@$data['USER_FOLDER'].'/index'.$data['ex'];?>" class="glyphicons home"><i></i>
	  <?=prntext(@$data['SiteName'])?>
	  </a></li>
	<li class="divider"></li>
	<li>Moto</li>
  </ul>
  <? } ?>
	
<? 
  $browserOs1=browserOs("1"); $browserOs=json_encode($browserOs1); 
  $setBrowserName='safari'; //safari mozilla	chrome
?> 
<script language="javascript" type="text/javascript"> 
//window.name='nwTrPro';
var BrowserName="<?=@$browserOs1['BrowserName'];?>";
var setBrowserName="<?=@$setBrowserName?>"; //safari mozilla	chrome
//if(BrowserName=='mozilla'){ alert(BrowserName); }

var jsTestCardNumbers =[<?=@$data['jsTestCardNumbers']?>];
var jsLuhnSkip =[<?=@$data['jsLuhnSkip']?>];

function SlideBox(x,cmd) {		
	if ($('#'+x).is(":hidden")) {
		if(cmd){
			$(".error1").html('');
						
			$(".showfp").slideUp(900);			
			$('#'+x).slideDown(1000);	
		}
	}
}

if(window.name=='iframe'){
	$('body').addClass('htmlpopup');
	$('html').addClass('htmlpopup');
}

</script>

<script language="javascript" type="text/javascript">  
function reload_f(){
	top.window.location.reload();
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

/******		Acquirer Status update via curl | Check status via notify me via bank as curl base 	*****/

/* Dev Tech : 23-06-05 fetch_trnsStatus for auto fetch_trnsStatus start after 30 second than every 10 second check for bank notify updated than go to success or failed failed */

var transID ="<?=(isset($transID)&&$transID?$transID:'');?>";
	var bank_status ="<?=@$data['Host']?>/bank_status<?=@$data['ex']?>";
	

var fetch_trnsStatus_2 ="<?=@$data['Host']?>/fetch_trnsStatus<?=@$data['ex']?>?";

/******		curl base update for acquirer status 	*****/ 
var curl_status ="<?=@$data['Host']?>/status<?=@$data['ex']?>?action=webhook";  




/***    remodify by Dev Tech: 23-06-05    ****/

var bank_status ="<?=@$data['Host']?>/bank_status<?=@$data['ex']?>";

/******		Check status via webhook me via bank as curl base 	*****/
var fetch_trnsStatus ="<?=@$data['Host']?>/fetch_trnsStatus<?=@$data['ex']?>";

var session_check_transID ="<?=@$data['Host']?>/session_check_transID<?=@$data['ex']?>";
var reloadVar='1';
var pendingCheckStart='1';
var statusCheckStart='1';
var retrycount=<?=(int)((isset($_SESSION['SA']['retrycount'])&&$_SESSION['SA']['retrycount']>0)?$_SESSION['SA']['retrycount']:'3')?>;

/**====	  check status via ajax for display success or failed   	====***/

function fetch_trnsStatusf(transID,paidCheck='',failed_status=''){

//alert(failed_status);
//alert(transID);
	
	$.ajax({url: fetch_trnsStatus+"?actionurl=viasystem&transID="+transID, type: "GET", dataType: 'json', success: function(result){
	    //alert(fetch_trnsStatus);
	    //alert(JSON.stringify(result));  
	    //alert(result["order_status"]);
		//result["order_status"]=1;
		
		var success_status = "";
		
		if(result["order_status"] && result["order_status"] == 1 )
		{
			success_status = "success";
		}
		else if((result["order_status"] && (result["order_status"] == 2 || result["order_status"] == 22 || result["order_status"] == 23)))
		{
			failed_status = "failed";
		}
		
		if( (statusCheckStart=='1') && ((result["order_status"] && result["order_status"] == 1) || (failed_status && failed_status == "failed")) )
		{
			statusCheckStart='';
			$('#modalpopup_processing').hide(10);
			$('#modalpopup_processing_for_pending').hide(10);
			 /*== clear all time Interval ==*/
			clearIntervalf();
			
			if (parent.window && parent.window.document) {
				//parent.window.close();
			}
			if (window.opener && window.opener.document) {
				window.opener.close();
			}
			
			// for Qr Status display and redirect to status page Modify By Dev Tech : 23-06-06
			//if(result["mop"] && result["mop"] == "QR" )
			if(result["mop"])
			{
				
				if(success_status == "success")
				{
					var qr_trans_status="Payment Successfull";
					var qr_trans_status_icon="<?=@$data['fwicon']['circle-check']?>";
					var qr_trans_status_bg="bg-success";
				
				}else {
					var qr_trans_status="Payment "+result["status"];
					var qr_trans_status_icon="<?=@$data['fwicon']['circle-cross']?>";
					var qr_trans_status_bg="bg-danger";
				}
				
			
				//$('.paid_qrcode_button').html('<i class="fa-regular fa-circle-check"></i>');
				//$('.upi_qr_row ').html('<i class="fa-solid fa-spinner fa-spin-pulse"></i>');
				
				
				var responce_box = '<div class="' + qr_trans_status_bg + ' rounded pt-2">';
				
				
				responce_box +='<div class="my-4 text-center rounded"><i class="' + qr_trans_status_icon + ' my-4 fa-5x text-light"></i></div>';
				responce_box +='<div class="my-2 text-center text-light fs-6">' + qr_trans_status + '</div>';
				responce_box +='<div class="mb-4 text-center text-light fs-5"> <?=get_currency($post['curr']?$post['curr']:$_SESSION['curr']);?> ' + result["bill_amt"] + '</div>';
				
				if(failed_status && failed_status == "failed"){
					responce_box +='<a id="retry_payment_link" class="text-center nopopup suButton btn btn-icon btn-primary" style="font-size:12px !important;display:block;text-decoration:none !important;width:fit-content;margin:0 auto 20px auto;line-height:23px;padding:3px 18px;" onclick="reload_f();">Retry Payment</a>';
					
					retrycount--;
				}
				
				responce_box +='<div class="bg-light">';
				responce_box +='<div class="mt-2 fw-bold p-2 text-muted fs-6"> <?=prntext(@$_SESSION['ter_name'])?></div>';
				responce_box +='<div class="px-2 text-muted">' + result["tdate"] + '</div>';
				
				if(result["reference"] != ""){
					responce_box +='<div class="fw-bold p-1"><span id="ref_copy" > Reference No ' + result["reference"] + '</span> <i class="fa-solid fa-copy" onclick="ctcf(\'#ref_copy\')" ></i></div>';
				}
				
				responce_box +='<div class="fw-bold p-1"><span id="tid_copy" > TransID ' + result["transID"] + '</span> <i class="fa-solid fa-copy" onclick="ctcf(\'#tid_copy\')" ></i></div>';
				
				if(success_status == "success"){
					responce_box +='<div class="p-2 bg-body-secondary text-decoration-underline click-to-redirect"><div style="cursor:pointer;"> Redirecting in <span class="lblCount_span"><span id="lblCount"></span>&nbsp;seconds... </span></div></div>';
				}
				else if(failed_status && failed_status == "failed"){
					responce_box +='<div class="row p-2 bg-body-secondary text-decoration-underline click-to-redirect"><div style="cursor:pointer;">Return to Merchant...</div></div>';
				}
				responce_box += '</div>';
				responce_box += '</div>';
				
				
				$('.paymentContainerDiv').addClass('p-2');
				$('.paymentContainerDiv').html(responce_box);
				$('#modalpopup_form_popup').hide();
				
				//$('.payment_option').html(responce_box);
				
				//$('.qrcodeadd_div').hide();
				//$('.cardHolder').hide();
				//$('.upi_qr_row_msg').show();
				//$('.upi_qr_row_msg').html('');
					
				
				 // =======For Timer to quick Redirect on 5 seconds ======= 
				 
				 var seconds = 5;  
				 $("#lblCount").html(seconds); 
				 
				 clear_count_st = setInterval(function () {  
					seconds--;  
					$("#lblCount").html(seconds);  
										 
					if (seconds == 0 ) 
					{
						$('.click-to-redirect').hide();
					}
					
					if ( ( seconds == 0 && success_status == "success" ) || ( failed_status && failed_status == "failed" && result["order_status"] == 2 && retrycount < 1 ) ) 
					 {
						//cmnj
						top.window.location.href=fetch_trnsStatus+"?transID="+transID+'&actionurl=validate'; 
					 } 
					
				 }, 1000); // after 10 seconds 
				 
				//======================
				// click to redirect status page
				
				$('.click-to-redirect').on('click', function () { 
					$("#lblCount").html(0); 
					clearInterval(clear_count_st);
					top.window.location.href=fetch_trnsStatus+"?transID="+result["transID"]+'&actionurl=validate';
				});
					
			}
			else{
				
				//cmnj
				 
				top.window.location.href=fetch_trnsStatus+"?transID="+transID+'&actionurl=validate';
			}
		}
		else if(result["order_status"] && result["order_status"] == 0 && pendingCheckStart=='1' ){
			/* pending */
			pendingCheckStart='';
			var qr_trans_status_bg="bg-info1";
			
			var qr_trans_status="Payment "+result["status"];
			
			var responce_box = '<div class="my-0 text-center rounded"><i class="<?=$data['fwicon']['circle-info']?>  my-1 fa-4x txt_2"></i></div>';
			
			responce_box += '<div class="' + qr_trans_status_bg + ' roundedx pt-2">';
			
			//responce_box +='<div class="my-1 text-center text-light fs-6">' + qr_trans_status + '</div>';
			
			responce_box +='<div class="bg_2 py-2 mb-1 text-center text-light fs-5"> Processing for pending payment... </div>';
			
			responce_box +='<div class="bg-light">';
			
			responce_box +='<div class="my-1 text-center rounded">Approve Payment Within <i class="fa-solid fa-spinner fa-spin-pulse fa-0x text-loader"></i> <span  class="proccess_timer timerCount" style="display:none1">1:52</span></div>';
			
			responce_box +='<div class="mt-0 fw-bold px-2 text-muted fs-8 text-truncate"> ' + result["response"] + ' </div>';
			responce_box +='<div class="px-2 text-muted">' + result["tdate"] + '</div>';
			
			if(result["reference"] != ""){
				responce_box +='<div class="fw-bold p-1"><span id="ref_copy" > Reference No ' + result["reference"] + '</span> <i class="fa-solid fa-copy" onclick="ctcf(\'#ref_copy\')" ></i></div>';
			}
			
			responce_box +='<div class="fw-bold p-1"><span id="tid_copy" > TransID ' + result["transID"] + '</span> <i class="fa-solid fa-copy" onclick="ctcf(\'#tid_copy\')" ></i></div>';
				
			responce_box += '</div>';
			responce_box += '</div>';
			
			$(".toast-box").slideDown(1400);
			
			$('#modalpopup_processing_for_pending_div').html(responce_box);
			$('#modalpopup_processing_for_pending').show(200);
			$('#modalpopup_form_popup').hide();
			
			timer = $('.timerCount');
			timeLeft = trans_auto_expired ; 
			setTimeout(function(){ 
				$('.timerCount').hide();
				processing_closef();
				//clearIntervalf();
			}, timeLeft);
			setInterval(updateTimer, 1000);
			
			
		}
		else if(paidCheck=='paidCheck'){
			if(result["order_status"] && result["order_status"] == 0 ){
			$('.upi_qr_row_msg').show();
			$('.upi_qr_row_msg').fadeOut(500);
	        $('.upi_qr_row_msg').fadeIn(500);
			$('.upi_qr_row_msg').html('<i class="fa-solid fa-spinner fa-spin-pulse"></i>');
			$('.upi_qr_row_msg').html('Now your status is pending please try pay via qr-code scan. If your paid please wait for notify you');
			
				//alert("Now your status is pending please try pay via qr-code scan. If your paid please wait for notify you");
			}
		}
		else {
			if (parent.window && parent.window.document) {
				//parent.window.close();
			}
			if (window.opener && window.opener.document) {
				//cmnj
				//window.opener.close();
			}
			//top.window.location.reload();
			//alert(result["order_status"]);
			//top.window.location.href=fetch_trnsStatus+"?transID="+transID+'&actionurl=validate';
		}
	}});
}


function pendingCheckStartf(reStart='')
{
	pendingCheckStart='1';
		statusCheckStart='1';
	
	//alert("<=pendingCheckStartf=>"+transID);
	
	$('#modalpopup_processing_for_pending').hide();
	
	
	if(reStart=="reStart"){
		transID='';varTransID='';
		//transID=null;varTransID=null;
		$('#modalpopup_form_popup').show(100);
		setTimeout(function(){ 
			if(transID==''){
				//alert("<=pendingCheckStartf_2=>"+transID);
				authenticatef();
				$('#modalpopup_form_popup').hide();
				$('#modalpopup_processing_for_pending').show(2000);
			}
		}, 3000);
	} else {
		authenticatef();
	}
}
	
/**====		If transID not found than use authenticatef for get transID from session and check status  	====***/
function authenticatef(){
	//$('#modalpopup_form_popup').show(500);
	//alert(session_check_transID+"?trn=1"+", transID=> "+transID);
	if(typeof(transID) != 'undefined' && transID != null && transID !='')
	{
		fetch_trnsStatusf(transID);
		timer_base_statusf();
	}
	else {
		setTimeout(function(){ 
		
			$.ajax({url: session_check_transID+"?trn=1", type: "GET", dataType: 'json', success: function(result_1){
				
				logs=result_1;
				
				//alert(stringifyf(result_1)); 
					
				//alert(result_1["transID"]);
				
				if(result_1["transID"] && result_1["transID"] != "" ){
					transID =result_1["transID"];
					
					fetch_trnsStatusf(transID);
					timer_base_statusf();
				}
				else{
					window.location.reload();
				}
				
			}});
		
		}, 2000);
	}
	if(reloadVar){
		//window.location.reload();
	}

	//authenticate.close();
}



var order_status = 0;
function webhook_statusf(){
	//alert(curl_status);
	if(typeof(varTransID) != 'undefined' && varTransID != null)
	{
		$.ajax({url: curl_status+"&transID="+varTransID, type: "GET", dataType: 'json', success: function(result){
			//alert(result);
			//alert(result["order_status"]);
		}});
	}
}

function fetch_trans_statusf(){
	if(typeof(transID) != 'undefined' && transID != null && transID !='')
	{
		fetch_trnsStatusf(transID);
	}
}

var trans_auto_expired = <?=(isset($getresponse['trans_auto_expired'])&&trim($getresponse['trans_auto_expired'])? (59978.53333333333 * (int)$getresponse['trans_auto_expired']):299892)?>; 
/* after 299892 = 59978.53333333333 * 5 minutes ; */



var clear_fetch_trans_statusf = '';
var clear_webhook_statusf = '';
function clearIntervalf() {
  clearInterval(clear_fetch_trans_statusf);
  clearInterval(clear_webhook_statusf);
}

function timer_base_statusf() {
	logs['timer_base_statusf']=transID;
	if(transID){
		logs['timer_base_statusf_'+transID]=transID;
		/*	for fetch_trnsStatus and status check	*/
		setTimeout(function(){ 
			clear_fetch_trans_statusf = setInterval(fetch_trans_statusf, 1000); // every one second for fetch trans status 
			logs['setTimeout_'+'fetch_trans_statusf'+'_'+transID]=transID;
		}, 10000); // starting fetch trans status after 10000 = 1000 * 10 second  
		
		/*	for acquirer status check	*/
		setTimeout(function(){ 
			clear_webhook_statusf = setInterval(webhook_statusf, 10000); // every 10000 = 1000 * 10 second 
			logs['setTimeout_'+'webhook_statusf'+'_'+transID]=transID;
		}, 20000); // webhook starting after 20000 = 1000 * 20 second 
		
		/*	clear every time Interval as default on 5 minutes 	*/
		setTimeout(function(){ 
			clearIntervalf();
			logs['setTimeout_'+'clearIntervalf'+'_'+transID]=transID+'_'+trans_auto_expired;
		}, trans_auto_expired); // expired every time interval after 299892 = 59978.53333333333 * 5 minutes ; 
		
		// after 299892 = 59978.53333333333 * 5 minutes ; 
		// after 419849 = 59978.53333333333 * 7 minutes ; 
		
	}
}



//fetch_trans_statusf();
//webhook_statusf();

</script>


<script language="javascript" type="text/javascript">
/******* Dev Tech : 23-04-17 for dynamic qr-code generate *****************/
var postQuery="<?=(isset($_SESSION['re_post'])?http_build_query($_SESSION['re_post']):'');?>";

function spinner_show_f(){
	$('#modalpopup_form_popup').show(100);
	$('.paybutton').hide();

	$('.paid_qrcode_button').show();
	//$('.upi_qr_row_msg').show();
	
	$('.paid_qrcode_link').hide();
	setTimeout(function(){ 
		$('.paid_qrcode_link').show();
	}, 10000);
		
}
function spinner_hide_f(){
	$('#modalpopup_form_popup').hide(10);
	$('#modalpopup_processing_for_pending').hide(10);
	$('.paybutton').show();
	$('.paid_qrcode_link').hide();
	$('.paid_qrcode_button').hide();
	$('.upi_qr_row_msg').hide();
	$('.contitxt .loader-btn').html('Retry');
}

function generate_qr_codef(){
	$('.upi_qr_row').addClass('active');
	$('.upi_qr_border').addClass('active');
	$('.upi_qr_border').html("<i class='<?=@$data['fwicon']['spinner'];?>  fs-1 fa-spin-pulse mt-5 text-info'></i><br>Generating QR");
	
	transID='';
	varTransID='';
	trans_auto_expired=299892;
	
	$('.timer').hide();
	
	/*
	setTimeout(function(){ 
		$('.upi_qr_border').html('');			
		$('.upi_qr_border').html($('.display_qr_on_upi').html());	
	}, 1000);
	*/
	$('.actionajax').val('ajaxQrCode');
	$('.mop_ajax_checkout').val('QRINTENT');
	
	var form = $("#payment_form_id_ewallets");
	//var url = form.attr('action');
	var url = window.location.href;
	var thisData=postQuery+'&'+form.serialize();
	if(wn)
	{
		thisUrl=url+"?"+thisData;
		window.open(thisUrl, '_blank');return false;
	}
	
	$.ajax({
		type: "POST",
		url: url,
		data: thisData,
		success: function(data) {
			logr=data;
			//alert(data);
			if(data.match('googleapis|img|DONE_AJAX')){
				spinner_show_f();
				$('#modalpopup_form_popup').hide(10);
				$('.upi_qr_border').html(data);
				
				//var qrTransID="TransID : " + varTransID;
				//var ReferenceNo="Reference No : " + varReferenceNo;
				
				//alert(qrTransID);
				//alert(ReferenceNo);
				if(varReferenceNo != ""){
					var ReferenceNo="Reference No : " + varReferenceNo;
				}else if(varTransID != ""){
					var ReferenceNo="TransID : " + varTransID;
				}else{
					var ReferenceNo="Bearer Token : <? echo $_SESSION['bearer_token_id']?>";
				}
				
				
				$('.qrTransID').html(ReferenceNo);
				$('.QR_Code_is_valid').show();
				
				
				timer_base_statusf();
			   
				//$('.paid_qrcode_link').attr('onclick',"fetch_trnsStatusf('"+varTransID+"','paidCheck')");
				
				$('.paid_qrcode_link').attr('onclick',"processing_closef()");
				
				setTimeout(function(){ 
					$('.timer').show(100);
				}, 1000);
				
				//=== For QR Timer for expired Timer to Redirect =========
				timer = $('.timer');
				timeLeft = trans_auto_expired ; 
				//timeLeft = 299892;  // Set timer for 5 minut after 299892 = 59978.53333333333 * 5 minutes ; 
				setTimeout(function(){ 
					//alert("Transaction Failed");
					//fetch_trnsStatusf(varTransID,'','failed');
					processing_closef();
				}, timeLeft);
				setInterval(updateTimer, 1000);
				
				
			 <?/*?>
				
				// Added By Vikash for check auto status after each 30 sec.
				const timeID = setInterval(callrepeatedfunction, 30000);

                function callrepeatedfunction() 
				{
					console.log(new Date());
					//alert("status check");
					
					$('.paid_qrcode_link').trigger("click","fetch_trnsStatusf('"+varTransID+"','paidCheck')");
                }
				
			 <?*/?>
			}
			else if(data.match('error|Error|Scrubbed')){
				alert(data);
			}
			else {
				$('.upi_qr_border').html(data);
			}
			// Ajax call completed successfully
		   // alert("Form Submited Successfully");
		},
		error: function(data) {
			logre=data;
			// Some error in ajax call
			alert("some Error in QR-Code");
			spinner_hide_f();
		}
	});
}	
	


function intent_pushf(e){
	
	if($(e).hasClass('active')){
		
		//alert('ErrorVar');
		
		if(typeof(ErrorVar) != 'undefined' && ErrorVar != null)
		{
			alert(ErrorVar);
		}
	}
	else 
	{
		$(e).addClass('active');
		//$(this).parent().find('.intent_select_app').slideDown(2000);
		//$('.intent_select_app').slideDown(2000);
		
		//$('.blur_layer').hide(200);
		//alert('llll');
		
		generate_intent_array_urlf();
	}
}

function generate_intent_array_urlf(){
	
	$('.actionajax').val('ajaxIntentArrayUrl');
	$('.mop_ajax_checkout').val('QRINTENT');
	
	
	$('.paid_qrcode_button').html("<i class='<?=@$data['fwicon']['spinner'];?>  fs-1 fa-spin-pulse text-info' style='font-size:12px !important;float:left;padding:3px 0;'></i>");
	spinner_show_f();
	
	transID='';
	varTransID='';
	trans_auto_expired=299892;
	
	
	var form = $("#payment_form_id_ewallets");
	//var url = form.attr('action');
	var url = window.location.href;
	var thisData=postQuery+'&'+form.serialize();
	if(wn)
	{
		thisUrl=url+"?"+thisData;
		window.open(thisUrl, '_blank');return false;
	}
	
	$.ajax({
		type: "POST",
		url: url,
		data: thisData,
		dataType: 'json', // text
		success: function(data) {
			//alert(data);
			logs=data;
			//alert(stringifyf(data['DONE_AJAX'])); alert(stringifyf(data['varTransID']));
			 
			 //return false;
			 if(stringifyf(data['transID'])) { transID = stringifyf(data['transID']); }
			 if(stringifyf(data['varTransID'])) { varTransID = stringifyf(data['varTransID']); }
			 if(stringifyf(data['varReferenceNo'])) { varReferenceNo = stringifyf(data['varReferenceNo']); }
			 if(stringifyf(data['trans_auto_expired'])) { trans_auto_expired = stringifyf(data['trans_auto_expired']); }
			 
			if(stringifyf(data['DONE_AJAX']))
			{
				$('.paytm.url_inte').attr('href',stringifyf(data['paytm']));
				$('.phonepe.url_inte').attr('href',stringifyf(data['phonepe']));
				$('.google.url_inte').attr('href',stringifyf(data['gpay']));
				$('.bhim.url_inte').attr('href',stringifyf(data['bhim']));
				$('.whatsapp.url_inte').attr('href',stringifyf(data['whatsapp']));
				$('.amazon.url_inte').attr('href',stringifyf(data['amazon']));
				$('.amazon.url_inte').attr('href',stringifyf(data['amazon']));
				$('.mobikwik.url_inte').attr('href',stringifyf(data['mobikwik']));
				$('.other.url_inte').attr('href',stringifyf(data['otherApps']));
				
				$('.blur_layer').hide(200);
				
				$('#modalpopup_form_popup').hide(10);
				
				/*
				$('.modal_msg_body').attr('style',$('.intent_appOpenSubmit_div').attr('data-style')); 
				$('#modal_msg_body_div').html($('.intent_appOpenSubmit_div .modalMsgContTxt').html()); 
				$('#modal_msg').addClass('active');
				$('.modal_msg.active .modal_msg_close').hide();
				$('#modal_msg').show(100);
				$('.appOpenUrlLink').html(data);
				//timer_base_statusf();
				*/
				
				//$('.paid_upiIntent_link').attr('onclick',"fetch_trnsStatusf('"+varTransID+"','paidCheck');modal_msg_close();");
				
			}
			else if(data.match('error|Error|Scrubbed')){
				alert(data);
			}
			else {
				//$('.upi_qr_border').html(data);
			}
		},
		error: function(data) {
			// Some error in ajax call
			logs=data;
			//alert(stringifyf(data)); alert(stringifyf(data['responseText']));
			
			if(stringifyf(data['responseText']).match('error|Error|Scrubbed')){
				 ErrorVar=stringifyf(data['responseText']);
				alert(stringifyf(data['responseText']));
			}
			else {
				alert("some Error in UPI Intent");
			}
			
			spinner_hide_f();
		}
	});
}

function generate_intent_urlf(){
	
	$('.actionajax').val('ajaxIntentUrl');
	$('.mop_ajax_checkout').val('QRINTENT');
	
	$('.paid_qrcode_button').html("<i class='<?=@$data['fwicon']['spinner'];?>  fs-1 fa-spin-pulse text-info' style='font-size:12px !important;float:left;padding:3px 0;'></i>");
	spinner_show_f();
	
	transID='';
	varTransID='';
	trans_auto_expired=299892;
	
	
	var form = $("#payment_form_id_ewallets");
	//var url = form.attr('action');
	var url = window.location.href;
	var thisData=postQuery+'&'+form.serialize();
	if(wn)
	{
		thisUrl=url+"?"+thisData;
		window.open(thisUrl, '_blank');return false;
	}
	
	$.ajax({
		type: "POST",
		url: url,
		data: thisData,
		success: function(data) {
			//alert(data);
			if(data.match('upi|pay|DONE_AJAX|intent'))
			{
				$('#modalpopup_form_popup').hide(10);
				$('.modal_msg_body').attr('style',$('.intent_appOpenSubmit_div').attr('data-style')); 
				$('#modal_msg_body_div').html($('.intent_appOpenSubmit_div .modalMsgContTxt').html()); 
				$('#modal_msg').addClass('active');
				$('.modal_msg.active .modal_msg_close').hide();
				$('#modal_msg').show(100);
				$('.appOpenUrlLink').html(data);
				//timer_base_statusf();
				
				//$('.paid_upiIntent_link').attr('onclick',"fetch_trnsStatusf('"+varTransID+"','paidCheck');modal_msg_close();");
				
			}
			else if(data.match('error|Error|Scrubbed')){
				alert(data);
			}
			else {
				$('.upi_qr_border').html(data);
			}
		},
		error: function(data) {
			// Some error in ajax call
			alert("some Error in UPI Intent");
			spinner_hide_f();
		}
	});
}	
	
function processingf(){	
	$('#modal_msg').hide(20);
	$('#modalpopup_processing').show(200);
	timer_base_statusf();
}
function processing_closef(labelPay=''){
	$('#modalpopup_processing').hide(10);
	webhook_statusf();
	setTimeout(function(){
		if(transID){
			fetch_trnsStatusf(transID,'paidCheck');
		}
		spinner_hide_f();
		if(labelPay){
			$('.contitxt .loader-btn').html(labelPay);
		}
		clearIntervalf();
	},1200); 
}







function ajaxFormf(Channel='', mop=''){
	
	$('.actionajax').val('ajaxJsonArray');
	
	$('.mop_ajax_checkout').val(mop);
	
	
	$('.paid_qrcode_button').html("<i class='<?=@$data['fwicon']['spinner'];?>  fs-1 fa-spin-pulse text-info' style='font-size:12px !important;float:left;padding:3px 0;'></i>");
	spinner_show_f();
	
	transID='';
	varTransID='';
	trans_auto_expired=299892;
	
	
	
	var form = $("#payment_form_id_ewallets");
	//var url = form.attr('action');
	var url = window.location.href;
	var thisData=postQuery+'&'+form.serialize();
	if(wn)
	{
		thisUrl=url+"?"+thisData;
		window.open(thisUrl, '_blank');return false;
	}
	
	$.ajax({
		type: "POST",
		url: url,
		data: thisData,
		dataType: 'json', // text
		success: function(data) {
			//alert(data);
			logs=data;
			//alert(stringifyf(data['DONE_AJAX'])); alert(stringifyf(data['varTransID']));
			 
			 //return false;
			 if(stringifyf(data['transID'])) { transID = stringifyf(data['transID']); }
			 if(stringifyf(data['varTransID'])) { varTransID = stringifyf(data['varTransID']); }
			 if(stringifyf(data['varReferenceNo'])) { varReferenceNo = stringifyf(data['varReferenceNo']); }
			 if(stringifyf(data['trans_auto_expired'])) { trans_auto_expired = stringifyf(data['trans_auto_expired']); }
			 
			if(stringifyf(data['DONE_AJAX']))
			{
				if(Channel=='11' && stringifyf(data['html_data'])){
					$('.IndiaBankTransfer_details').html(stringifyf(data['html_data']));
				}
				
			}
			else if(data.match('error|Error|Scrubbed')){
				alert(data);
			}
			else {
				//$('.upi_qr_border').html(data);
			}
			$('#modalpopup_form_popup').hide(); 
		},
		error: function(data) {
			// Some error in ajax call
			logs=data;
			//alert(stringifyf(data)); alert(stringifyf(data['responseText']));
			
			if(stringifyf(data['responseText']).match('error|Error|Scrubbed')){
				 ErrorVar=stringifyf(data['responseText']);
				alert(stringifyf(data['responseText']));
			}
			else {
				alert("some Error via request");
			}
			spinner_hide_f();
		}
		
		
	});
}
	
</script>


  
<script language="javascript" type="text/javascript">  
function mytext1(str)
{
	//alert(str);
	document.getElementById("cardsavefinal").value = str;
} 
function validateForm(formObj) {	
	/*
	formObj.send123.disabled = true;  
	formObj.send123.value = 'Please Wait...'; 
	formObj.cardsave.disabled = true;  
	formObj.cardsave.value = 'Please Wait...';  
	return true;  
	*/
}

var merchant_pays="";
var afj="";
var merchant_pays_fee="";
<? if(isset($_SESSION['afj'])&&$_SESSION['afj']&&$_SESSION['merchant_pays_fee']){?>
	merchant_pays="1"; 
	afj=<?=@$_SESSION['afj']?>;
	merchant_pays_fee="<?=@$_SESSION['merchant_pays_fee'];?>";
<? } ?>

var backMerchantWebSiteUrl='';
<? if(isset($_SESSION['re_post']['return_failed_url'])&&$_SESSION['re_post']['return_failed_url']){?>
	backMerchantWebSiteUrl="<?=@$_SESSION['re_post']['return_failed_url'];?>";
<? } ?>

//merchantPage -----------
var merchantReturnVar='merchantReturnWebSiteOK';
function backMerchantWebSite(theValue){
	var retVal ='';
	if(theValue=='timeOut'){
		retVal = theValue;
	}else{
		retVal = confirm("This action will redirect you on the merchant website.");
	}
	//alert(retVal);
	if (retVal) {
		var merchantWebSite = "<?=@$data['Host'];?>/session_check<?=@$data['ex'];?>?merchantWebSite="+merchantReturnVar;
		//alert(merchantWebSite);
		//top.window.location.href=backMerchantWebSiteUrl;
		$('#modalpopup_form_popup').slideDown(900);

		$.ajax({url: merchantWebSite, success: function(result){
			//alert(result);
			top.window.location.href=backMerchantWebSiteUrl;
			$('#modalpopup_form_popup').slideUp(70);
		}});

		return true;
	} else {
		//alert(backMerchantWebSiteUrl);
		return false;
	}
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

function ewalist_f(e,ewalistVar,etypeVar='',onShow='') {
	var onShowCheckVar='true';
	//alert('ewalistVar 1 =>'+ewalistVar+'\r\netypeVar=>'+etypeVar+'\r\onShow=>'+onShow+'\r\onShowCheckVar=>'+onShowCheckVar);
	var ewalistVar_arr = ewalistVar.split(' ');
	for(var i = 0; i < ewalistVar_arr.length; i++)
	{
		if(ewalistVar_arr[i]){
			$('.ewalist.'+ewalistVar_arr[i]+'_div').show();
			$('.ewalist.'+ewalistVar_arr[i]+'_div').addClass('active'); 
			//// Start Added for change pay button lavel to Generate Qr Code
			var box_vid=ewalistVar_arr[i]+'_div';
			//alert(box_vid);
			
			
			if((box_vid=="qrAddress_div")|| (box_vid=="qrcodeadd_div") || (box_vid=="upiaddress_div") || box_vid.match("qracq_|upiqr|submitButtonHide") ){  
				//$('.submit_div .contitxt').html("<span style=''>Generate Qr Code</span>");
				$('.submit_div.m-button').hide();
				//$('.submit_div').show();
			}else{
			    
				$('.submit_div .contitxt').html("<span style='' class='loader-btn'>Pay</span>");
				
			}
			//// End Added for change pay button lavel to Generate Qr Code
			
			if($('.ewalist.'+ewalistVar_arr[i]+'_div').hasClass('modalMsg')){
				onShowCheckVar='false';
				var dataStyle= $('.ewalist.'+ewalistVar_arr[i]+'_div').attr('data-style');
				if(dataStyle !== undefined){
					$('.modal_msg_body').attr('style',dataStyle); 
				}
				 
				$('#modal_msg_body_div').html($('.ewalist.'+ewalistVar_arr[i]+'_div').find('.modalMsgCont').html());

				tv=topInViewport(e);
				//alert('150=>'+tv);
				if(tv){ $('.modal_msg_body').animate({top:tv,'position':'absolute'}, 500); }
				
				$('#modal_msg').show(100); 
				
				$('#payment_form_id_ewallets').attr('target','_blank');
				$('#payment_form_id_ewallets').addClass('nextTabTr');
				
			}

			if(ewalistVar_arr[i]=='ift')
			{
				//alert("dddddd"+ewalistVar_arr[i]+'_div');
			    //	$('.submit_div .contitxt').html("<span style=''>Create Transaction</span>");
				//$("#payment_form_id_ewallets").submit();
				//document.forms['payment_form_id_ewallets'].submit();
				
				//$form.get(0).submit();
	            setTimeout(function(){ 
				$("#cardsend_submit").eq(0).trigger("click");	
				}, 10);
	
	              		
			}
		}
	}
	
	if(etypeVar=='3D'&&onShow=='onSh'&&onShowCheckVar=='true'){
		//alert('ewalistVar 3d=>'+ewalistVar+'\r\netypeVar=>'+etypeVar+'\r\onShow=>'+onShow+'\r\onShowCheckVar=>'+onShowCheckVar);
		var dataStyle= $('.ewalist.universal_msg_div').attr('data-style');
		 if(dataStyle !== undefined){
			$('.modal_msg_body').attr('style',dataStyle); 
		 }
		$('#modal_msg_body_div').html($('.ewalist.universal_msg_div').find('.modalMsgCont').html());
		
		
		tv=topInViewport(e);
		//alert('173=>'+tv);
		if(tv){ $('.modal_msg_body').animate({top:tv,'position':'absolute'}, 500); }
		
		
		$('#modal_msg').show(100); 
				
	}
	
	
}

/* Dev Tech : 23-04-08 host base url and @user */

var paymetAt = "<?=@$data['Host'];?>/session_check<?=@$data['ex'];?>?paymetAt=1";
 
var storeSize="<?=(isset($post['storeSize'])?$post['storeSize']:'');?>";	
var public_key="<?=(isset($post['public_key'])?$post['public_key']:'');?>";

var paymetAtData=<?=(isset($_SESSION['re_post'])?json_encode($_SESSION['re_post']):'');?>;
var curSym="";
<? if(isset($_SESSION['curr_smbl'])&&$_SESSION['curr_smbl']){?>
	curSym="<?=@$_SESSION['curr_smbl'];?>";
<? } ?>
	

var ccn_var;
var card_validation='yes';



function redirect_Postf(url, data) {
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
$(document).ready(function(){ 

	if(storeSize=='1'&&public_key){
		//alert('storeSize:'+storeSize+'\r\napi_token:'+public_key); 
		window.location.href=paymetAt+"&public_key="+public_key;
	}

	$("#storeType").change(function() {
		var selectedItem = $(this).val();
		var titles= $('option:selected', this).attr('data-title');

		var thisUlr = paymetAt+"&public_key="+selectedItem;
		if(wn)
		{
			alert(selectedItem+'\r\n'+titles+'\r\n'+thisUlr);
		}
	   
	   
		var paymetAtData2 = {public_key:selectedItem};
		redirect_Postf(window.location.href, $.extend(true,{},paymetAtData,paymetAtData2));
		
		//console.log(abc,selectedItem);
	});
	
	$('.ewalist input,.ewalist select, input.ewalist,select.ewalist').each(function(){
		$(this).attr("data-name",$(this).attr('name'));
	});
	
	$('.account_types').click(function(){ 
		
		var channelVar= $(this).attr('data-channel');
		
		if((channelVar !== undefined)&&(channelVar==='2' || channelVar==='3')){
			$(".toast-box").slideDown(1400);
		}
		else if((channelVar !== undefined)&&(channelVar==='9')){
			
			$('.submit_div.m-button').hide();
			$('.is_channel').show();
			$('.is_not_channel').hide();
		}
		else{
			$('.is_channel').hide();
			$('.is_not_channel').show();
			
			$('.submit_div').show();
		}
		
		if(transID){
		
		// Hide for stop alert 
			  /*let payChange = "Are your sure change payment option!!!";
			  //if (confirm(payChange) == true) {
			  if (confirm(payChange) == true) {
				//payChange = "You pressed OK!";
				spinner_hide_f();
			  } else {
				//payChange = "You canceled!";
				return false;
			  }*/
		}
		
		/*
		if($('div').hasClass('actionajax')){
			$('.actionajax').val('');
		}
		*/
		
		$('.actionajax').val('');
		$('.mop_ajax_checkout').val('');
	
		$('.submit_div .contitxt').html("<span style='' class='loader-btn'>Pay</span>");
		var ccn_array;
		var name_var = $(this).attr('data-name');
		var value_var = $(this).attr('data-value');
		ccn_var = $(this).attr('data-ccn');

		var ewalistVar= $(this).attr('data-ewlist');
		
		$('#payment_form_id_ewallets').removeClass('nextTabTr');
		//$('#payment_form_id_ewallets').removeAttr('target');
		
		var etypeVar= $(this).attr('data-etype');
		if((etypeVar !== undefined)&&(etypeVar==='3D')){
			//$('#payment_form_id_ewallets').attr('target','payin_win');
			$('#payment_form_id_ewallets').addClass('nextTabTr');
			
			$('#continue3dButton').hide();
			$('#continueValidationButton').show();
			
			
		}
		
		$('.required').each(function(){
			$(this).removeAttr("required");
		});

		$('.cname label').removeClass('active');
		//alert(ccn_var);
		if(ccn_var!=null&&ccn_var!=''){
			ccn_array = ccn_var.split(",");
			if (ccn_var.toLowerCase().indexOf("rupay") >= 0){
				card_validation='';
			}else{
				card_validation='yes';
			}
		}
		$('#credit_cards img').hide();

		if(ccn_array!=null&&ccn_array!=''){
			$.each(ccn_array,function(i){
				//alert(ccn_array[i]);
				$('#credit_cards #'+ccn_array[i]).show();
			});
		}

		$('.account_types').removeClass('active');

		$('.cname label[for="'+value_var+'"]').addClass('active');
		$(this).addClass('active');
		
		$('.checkOutOptions').show();
		
		<? if(isset($data['con_name'])&&$data['con_name']=='clk'){?>
		   //alert("999999999999");
			$('#paymentMethodChange').show();
			$('.chkname').hide();
			$('.next_icon_v').hide();
			$('.paymentMethodh4').html($(this).next().html());
			$('.back_action').hide();
			$('.heading2_ind').hide();
			$('.paymentMethodDiv').addClass("label_active");
		<? } ?>
        //alert(name_var);
		$('.pay_div').slideUp(300); //200
		$('.'+name_var+'_div').slideDown(400); //700
		
		
		$('#payment_form_id input[name="acquirer"]').val(value_var);
	
		/*
		if(ewalistVar !== undefined){
			
			$('.ewalist').hide();
			$('.ewalist').removeClass('active');
			$('.ewalist.'+ewalistVar+'_div').show();
			$('.ewalist.'+ewalistVar+'_div').addClass('active');
			
			var ewalistVar_arr = ewalistVar.split(' ');
			for(var i = 0; i < ewalistVar_arr.length; i++)
			{
				if(ewalistVar_arr[i]){
					$('.ewalist.'+ewalistVar_arr[i]+'_div').show();
					$('.ewalist.'+ewalistVar_arr[i]+'_div').addClass('active');
				}
			}
			
			
			//start input name add
			$('.ewalist input,.ewalist select, input.ewalist,select.ewalist').each(function(){
				$(this).removeAttr("name");
			});
			
			$('.ewalist.active input,.ewalist.active select, input.ewalist.active,select.ewalist.active').each(function(){
				 dataInputName= $(this).attr('data-name');
				if((dataInputName !== undefined)&&(dataInputName)){
					$(this).attr("name",dataInputName);
				}
			});
			//end input name add
			

			$('.ewalist.active .required').each(function(){
				$(this).attr("required","required");
			});
			
		}
		*/
		
		if(ewalistVar !== undefined){
			$('.ewalist').hide();
			$('.ewalist').removeClass('active');
			$('.ewalist.'+ewalistVar+'_div').show();
			$('.ewalist.'+ewalistVar+'_div').addClass('active');
			
			ewalist_f($(this).parent().find('label'),ewalistVar,etypeVar);
			//ewalist_f($('.inputValidation'),ewalistVar,etypeVar);
			
			
			//start input name add
			
			$('.ewalist input,.ewalist select, input.ewalist,select.ewalist').each(function(){
				$(this).removeAttr("name");
			});
			
			$('.ewalist.active input,.ewalist.active select, input.ewalist.active,select.ewalist.active').each(function(){
				 dataInputName= $(this).attr('data-name');
				if((dataInputName !== undefined)&&(dataInputName)){
					$(this).attr("name",dataInputName);
				}
			});
			
			//end input name add
			
			$('.ewalist.active .required').each(function(){
				$(this).attr("required","required");
			});

			$('#payment_form_id_ewallets input[name="acquirer"]').val(value_var);
		}
		
		//644
		
		if(value_var==644){
			$("#cardsend_submit").eq(0).trigger("click");
			//$("#payhide").eq(0).trigger("click");
			$('.paymentMethodDiv').slideDown(50);
			$('.cardHolder').hide(50);
		}
		

		if($(this).attr('data-name')==="ewallets"){
			$('#payment_form_id_ewallets input[name="acquirer"]').val(value_var);
		}
		
		if($(this).attr('data-name')==="ebanking"){
			$('#payment_form_id_ebanking input[name="acquirer"]').val(value_var);
		}
		
		if($(this).attr('data-name')==="bhimupi"){
			$('#payment_form_id_bhimupi input[name="acquirer"]').val(value_var);
		}

		if(curSym==''){
			curSym=$(this).attr('data-currency');
		}

		$('#t_amt').html(curSym);
		$('.bill_amtSys').html(curSym);
		$('.currSymbl').html(curSym);
		
		
		//11 bt
		if((channelVar !== undefined)&&(channelVar==='11')){
			$('.submit_div.m-button').hide();
			if($(this).hasClass('submited')){
				
			} else {
				
				$(this).addClass('submited');
				
				ajaxFormf(channelVar,'bt');
				
				/*
				setTimeout(function(){
					$("#payment_form_id_ewallets").submit(); 
				},300);
				setTimeout(function(){
					$('#modalpopup_form_popup').hide(); 
				},400); 
				*/

			}
			//$(".toast-box").slideDown(1400);
		}
		
	});

	
	
	$('.upisDiv').click(function(){
		$('.upisDiv').removeClass('active');
		$(this).addClass('active');
		
		var thisVal=$(this).find('.upis').text();
		
		$('.upisDropDown').find('option:contains("'+thisVal+'")', this).prop('selected', 'selected');
		$('.upisDropDown').find('option:contains("'+thisVal+'")', this).attr('selected', 'selected');

	});
	
	$('.walletsDiv').click(function(){
		$('.walletsDiv').removeClass('active');
		$(this).addClass('active');
		
		var thisVal=$(this).find('.wallets').text();
		
		$('.wDropDown').find('option:contains("'+thisVal+'")', this).prop('selected', 'selected');
		$('.wDropDown').find('option:contains("'+thisVal+'")', this).attr('selected', 'selected');

	});

	$('#bill_amtChange').click(function(){

			$('#bill_amtInputDiv').removeClass('activeInput');
			$('#bill_amtChange').hide(200);
			$('.nextSt').hide(200);
			$('.sIn').show(800);
			
			$('.paymentMethodDiv').hide(50);
			$('.chkname').hide();
			$('#paymentMethodChange').hide(50);
			$('.checkOutOptions').hide();
			$('.contInfoBar').hide();
			
			$('.paymentMethodh4').html('CARDS, UPI & MORE');
			$('.account_types').removeClass('active');
			$('.cname label').removeClass('active');
	});

	$('#contSubmit').click(function(){
		var fullName = $('.contInputDiv input[name="fullname"]').val(); 
		var phone = $('.contInputDiv input[name="bill_phone"]').val();
		var email = $('.contInputDiv input[name="bill_email"]').val();

		if(fullName == '') {
			alert("Full Name can not Blank! Please enter the Full Name.");
			$('.contInputDiv input[name="fullname"]').focus();
			return false;
		}else if(phone == '') {
			alert("Phone Number not Blank! Please enter the Phone Number.");
			$('.contInputDiv input[name="bill_phone"]').focus();
			return false;
		}else if(email == '') {
			alert("Email ID not Blank! Please enter the Email ID");
			$('.contInputDiv input[name="bill_email"]').focus();
			return false;
		}else if(!isEmailAddr(email)) {
			alert("Please enter a complete email address in the form: yourname@yourdomain.com");
			$('.contInputDiv input[name="bill_email"]').focus();
			return false;
		}else {
			$('.errorDivId').hide(200);
			$('.contInputDiv').hide(200);
			$('.paymentMethodDiv').show(800);
			$('.chkname').show(800);
			$('.checkOutOptions').hide(100);
			$('.contInfoBar').show(100);
			$('.fullNmBar').html('<i class="<?=@$data['fwicon']['profile'];?> px-2 py-1"></i> ' + $('.contInputDiv input[name="fullname"]').val());
			$('.mobileBar').html('<i class="<?=@$data['fwicon']['mobile'];?> px-2 py-1 "></i> ' + $('.contInputDiv input[name="bill_phone"]').val());
			$('.emailBar').html('<i class="<?=@$data['fwicon']['email'];?> px-2 py-1 "></i> ' + $('.contInputDiv input[name="bill_email"]').val());
			$('.card-holder div').html($('.contInputDiv input[name="fullname"]').val());
			
			$('.checkOutOptions input[name="fullname"]').val($('.contInputDiv input[name="fullname"]').val());		
			
			$('.checkOutOptions input[name="bill_phone"]').val($('.contInputDiv input[name="bill_phone"]').val());
			
			$('.checkOutOptions input[name="bill_email"]').val($('.contInputDiv input[name="bill_email"]').val());
			
			$('.checkOutOptions input[name="product"]').val($('.bill_amtInputDiv input[name="product"]').val());
			
			$('.checkOutOptions input[name="bill_amt"]').val($('.bill_amtInputDiv input[name="bill_amt"]').val());
			
			if($(".account_types").length == 1){
				setTimeout(function(){ 
					$(".account_types").eq(0).trigger("click");
				}, 10); 
			}
		}
	});

	$('#paymentMethodChange').click(function(){
	        //alert("11111111");
			$('.contInputDiv').hide(200);
			$('.paymentMethodDiv').show(800);
			$('.chkname').show(200);
			$('.checkOutOptions').hide(100);
			
			$('.paymentMethodh4').html('CARDS, UPI & MORE');
			$('#paymentMethodChange').hide(50);
			$('.back_action').show();
			$('.heading2_ind').show();
			$('.paymentMethodDiv').removeClass("label_active");

			//$('.account_types').removeClass('active');
			//$('.cname label').removeClass('active');
			
			$('#modalpopup_processing').hide(10);
			$('#modalpopup_processing_for_pending').hide(10);
			 /*== clear all time Interval ==*/
			//clearIntervalf();
			
	});

	//1
	$('#bill_amtSubmit').click(function(){
		
		var inputPurpose = $('.inputPurpose').val(); 
		var pric = $('.bill_amt90').val();	
		
		if(inputPurpose == '') {
			alert("Purpose of Payment can not Blank! Please enter the Purpose");
			$('.inputPurpose').focus();
			return false;
		}else if(pric == '') {
			alert("Amount can not Blank! Please enter the Amount");
			$('.bill_amt90').focus();
			return false;
		}else {
		
			if($('#bill_amtInputDiv').hasClass('activeInput')){
				$('#bill_amtInputDiv').removeClass('activeInput');
				$('#bill_amtChange').hide(200);
				
				$('.nextSt').hide(200);
				$('.sIn').show(800);
			} else {
					var amt_g=$('.bill_amt90').val();
					var amt_l='';

					if (amt_g.indexOf('.') <= 0) {
						amt_g=amt_g+".00";
					}
					
					if (amt_g.indexOf('.') >= 0) {
						var amtg=amt_g.split(".");
						amt_l=amtg[1];
						amt_g=amtg[0];
					}

					var crNm='₹';
					
					if(curSym){
						crNm=curSym;
					}
		
					var crn=$('.bill_amt #t_amt').html();
					if(crn){
						crNm=crn;
					}
				
				$('.checkOutOptions input[name="bill_amt"]').val(pric);
				
				$('#bill_amtInputDiv').addClass('activeInput');
				$('#bill_amtChange').show(700);
				
				$('.txtPurpose').html($('.inputPurpose').val());
				$('.txtAmount').html('<span class="currSymbl">'+crNm+'</span> <span class="nPayb">'+amt_g+'</span>.'+amt_l);
				$('.nPay').html('<span class="currSymbl">'+crNm+'</span> <span class="nPayb">'+amt_g+'</span>.'+amt_l);
				$('.submit_div .contitxt').html("<span style='' class='loader-btn 11'>Pay </span> "+' <span class="currSymbl">'+crNm+'</span> <span class="nPayb">'+amt_g+'</span>.'+amt_l);

				$('.sIn').hide(); 
				$('.nextSt').show();
				var fullName = $('.contInputDiv input[name="fullname"]').val(); 
		        var phone = $('.contInputDiv input[name="bill_phone"]').val();
		        var email = $('.contInputDiv input[name="bill_email"]').val();
				
				
				
				if((fullName=="")||(phone=="")||(email=="") ){ 
				
				}else{ 
				$('#contSubmit').trigger("click");
				}
				
				
			

				
				
			}
		}
	});
	
	var billerEmpaty='';
	
	if(billerEmpaty==''){
		$('#bill_amtSubmit').trigger("click");
	}

	<? if(empty($post['fullname']) || empty($post['bill_phone']) || empty($post['bill_email']) ){?>
			billerEmpaty='ok';	
	<? } ?>
	
	
	<? if($data['con_name']!='clk'){?>
		//$(".account_types").eq(0).trigger("click");
	<? } ?>
	
	if($(".account_types").length == 1 && billerEmpaty==''){
		//$(".account_types").length;
		setTimeout(function(){ 
			$(".account_types").eq(0).trigger("click");
		}, 100); 
		
		//alert($(".account_types").length);
	}
	
	
				
		<? if(!isset($post['pricManual'])){?> 
			//$('#bill_amtSubmit').trigger("click");
			//$('#contSubmit').trigger("click");
			
			var amt_g="<?=@$post['bill_amt'];?>";
			var amt_l='';
			if (amt_g.indexOf('.') <= 0) {
				amt_g="<?=@$post['bill_amt'];?>"+".00";
			}
			
			//if($('.author-info:contains("/")'){
			if (amt_g.indexOf('.') >= 0) {
				var amtg=amt_g.split(".");
				amt_l=amtg[1];
				amt_g=amtg[0];
			}

			var crNm='₹'; 
			if(curSym){
				crNm=curSym;
			}
			var crn=$('.bill_amtSys #t_amt').html();
			if(crn){
				crNm=crn;
			}

			$('.nPay').html('<span class="currSymbl">'+crNm+'</span> <span class="nPayb">'+amt_g+'</span>.'+amt_l);
		 	$('.txtAmount').html('<span class="currSymbl">'+crNm+'</span> <span class="nPayb">'+amt_g+'</span>.'+amt_l);
			$('.submit_div .contitxt').html("<span style='' class='loader-btn'>Pay </span>");

			$('.errorDivId').hide(200);
			$('.nextSt').show(100);
			
			if(billerEmpaty=='ok'){
				$('.contInputDiv').show(200);
				$('.paymentMethodDiv').hide(200);
			}else{	
				$('.contInputDiv').hide(200);
				$('.paymentMethodDiv').show(800);
			}
			
			$('.chkname').show(800);
			$('.checkOutOptions').hide(100);
			$('.contInfoBar').show(100);
			
		<? } ?>		

	//desImg
	//txNm
	//dropDwn
	//data-showc="customerPhone" data-hidec="upi_vpa"

	$('.desImg').click(function(){
		$('.desImg').removeClass('active');
		$(this).addClass('active');
		var thisVal=$(this).find('.txNm').text();
		$('.dropDwn').find('option:contains("'+thisVal+'")', this).prop('selected', 'selected');
		//$('.dropDwn').find('option:contains("'+thisVal+'")', this).attr('selected', 'selected');
		
		var thisName=$('.dropDwn').find('option:contains("'+thisVal+'")', this).parent().attr('name');
		var thisText=$('.dropDwn').find('option:contains("'+thisVal+'")', this).text();
		//alert('thisName: '+thisName+'\r\nthisText: '+thisText);
		if($('input[name='+thisName+'_text]')){ $('input[name='+thisName+'_text]').val(thisText); }
		var showcVar= $(this).attr('data-showc');
		var hidecVar= $(this).attr('data-hidec'); 
		if(showcVar !== undefined){showcVar_f(showcVar); }
		if(hidecVar !== undefined){hidecVar_f(hidecVar); }
	});
	$('.dropDwn').change(function(){
		var thisName=$(this).attr('name');
		var thisText=$(this).find('option:selected').text();
		//alert('thisName: '+thisName+'\r\nthisText: '+thisText); 
		if($('input[name='+thisName+'_text]')){ $('input[name='+thisName+'_text]').val(thisText); }
		var thisVal=$(this).find('option:selected').val();
		
		var desImg_1=$(this).parent().parent().find('.desImg');
		var desImg_2=$(this).parent().parent().find('.desImg.'+thisVal);
		
		if($(this).parent().parent().parent().find('.desImg.'+thisVal).length==1){
			desImg_1=$(this).parent().parent().parent().find('.desImg');
			desImg_2=$(this).parent().parent().parent().find('.desImg.'+thisVal);
			if(wn){
				alert("SSTEP_2=> "+$(this).parent().parent().parent().find('.desImg.'+thisVal).length);
			}
		}
		else if($(this).parent().parent().parent().parent().find('.desImg.'+thisVal).length==1){
			desImg_1=$(this).parent().parent().parent().parent().find('.desImg');
			desImg_2=$(this).parent().parent().parent().parent().find('.desImg.'+thisVal);
			if(wn){
				alert("SSTEP_3=> "+$(this).parent().parent().parent().parent().find('.desImg.'+thisVal).length);
			}
		}
		
		desImg_1.removeClass('active');
		desImg_2.addClass('active');
		
		var showcVar= desImg_2.attr('data-showc');
		var hidecVar= desImg_2.attr('data-hidec');
		
		if(showcVar !== undefined){showcVar_f(showcVar); }
		if(hidecVar !== undefined){hidecVar_f(hidecVar); }		
	});
	
	//------------------------------
	
	<? if(isset($_SESSION['re_post']['failed_type'])&&$_SESSION['re_post']['failed_type']){?>
		
		$('.cname label').removeClass('active');
		$('.cname label[for="<?=@$_SESSION['re_post']['failed_type'];?>"]').addClass('active');
		
		$('body').addClass('oops2');
		
		timer = $('.timer');
		//timer.text('07:00');
		//timeLeft = 899678; // 15 minutes = 59978.53333333333 * 15 ; 
		timeLeft = 299890;
		
		setTimeout(function(){ 
			merchantReturnVar='TimeOut:merchantReturnWebSiteOK';
			//top.window.location.href=processed;
			backMerchantWebSite('timeOut');
			//alert(merchantReturnVar); 
		}, timeLeft);

		setInterval(updateTimer, 1000);

	<? } ?>

	$('.merchantPage').click(function(){
		backMerchantWebSite('merchantClick');
	});
	
	$('.tryAgain').click(function(){
		$('.alertPaymentDiv').hide(50);
		$('#nextOptionDivId').show(1000);
		//$('body').addClass('oops3');
		//$('body').removeClass('oops2');
	});
	
	
	
	$('.processing_close').click(function(){
		processing_closef('Retry Payment');
	});

	
	$('.intent_push').click(function(){
		intent_pushf(this);
	});


	setTimeout(function(){
		$(".goog-te-combo option:first-child").text('English');
		$('.translateDiv').show(1000);
	},2000); 
	
	//-------------------------------------------
});


function showcVar_f(showcVar){
	if(showcVar){
		var showcVar_arr = showcVar.split(' ');
		for(var i = 0; i < showcVar_arr.length; i++)
		{
			if(showcVar_arr[i]){
				$('.'+showcVar_arr[i]+'').show();
				if($('.'+showcVar_arr[i]+'').hasClass('required')){
					$('.'+showcVar_arr[i]+'').attr("required","required");
				}
			}
		}
	 } 
}

function hidecVar_f(hidecVar){
	if(hidecVar){
		var hidecVar_arr = hidecVar.split(' ');
		for(var i = 0; i < hidecVar_arr.length; i++)
		{
			if(hidecVar_arr[i]){
				$('.'+hidecVar_arr[i]+'').hide();
				$('.'+hidecVar_arr[i]+'').removeAttr("required","required");
			}
		}
	 }
}
</script>

  <? if(isset($post['acquirer_id_check'])&&!empty($post['acquirer_id_check'])){?>
  <script language="javascript" type="text/javascript"> 
	$(document).ready( function(){
		$("#purchaser_routing").keyup(function() {
			if($("#purchaser_routing").val().length===9){
				doLookup($("#purchaser_routing").val()); 
			}
		});
		//$("#example-form").submit(function() { return false; });
		//$("#tryit").click(function() { $('#purchaser_routing').val('122242597'); $('#purchaser_routing').click() });
	});

	function doLookup(rn)
	{
		$("#result_view").empty().text("Looking up " + rn + "...");
		$("#result_view_chk").empty().html("");
		$.ajax({
			url: "https://www.routingnumbers.info/api/data.json?rn=" + rn,
			dataType: 'jsonp',
			success: onLookupSuccess
		});
	}

	function onLookupSuccess(data){
		//alert(data['message']);
	if(data['message']=="OK"){
		$("#purchaser_routing").removeClass('error');
		$("#bank_name").val(data['customer_name']);
		//$('#bank_state option value:contains("'+data['state']+'")').attr('selected', 'selected');
		$('#bank_state option[value*="'+data['state']+'"]').prop('selected','selected');
		$("#bank_address").val(data['address']);
		
		$("#bank_city").val(data['city']);
		$("#bank_phone").val(data['telephone']);
		var zipcode=data['zip'].split("-");
		$("#bank_zipcode").val(zipcode[0]);
		
		//alert(data['customer_name']);alert(data['routing_number']);
		/*
		var table = $("<table>").attr("class", "table table-bordered");
		table.append($("<tr>").append($("<th>").text("Results").attr("colspan", "2")));
		
		for (var clients in data)
		{
			coltype = typeof data[clients];

			table.append($("<tr>")
					.append($("<td>").text(clients))
					.append($("<td>").text(data[clients]))
					);
		}
		$("#result_view").empty().append(table);*/
		$("#result_view").empty().text("Bank Information Validated!");
		$("#result_view_chk").empty().html("<img class='valid' src='<?=@$data['Host'];?>/contact/images/valid.png' /> ");
	}else{
		$("#purchaser_routing").addClass('error');
		$("#result_view_chk").empty().html("<img class='valid' src='<?=@$data['Host'];?>/contact/images/invalid.png' /> ");
		$("#result_view").empty().text("Bank Information Invalidated. Please enter correct Bank ABA/Routing No.");
	}
}
</script>
<? } ?>

<script language="javascript" type="text/javascript"> 
var keyInput = $('.key_input');

	function conc(){
		/*var str = "";
		$('.key_input').each(function(){
			str += $(this).val();
		});
		str = str.replace(/\s/g, '');
		$("#number").val(str);*/
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
		
		if(getId==='int16' && document.getElementById(getId).value.length>0){
			document.getElementById('expMonth').focus();
		}
		else if( (getId!='int16' ) && ( document.getElementById(nextId).value !='' )  && ( document.getElementById(getId).value.length > 0 ) ){
			conc();
			document.getElementById('expMonth').focus();
		}
		conc();
	}
	
	function keypressf(element, getId, nextId) {
		//limit(element, 1, getId, nextId);
		if(getId=='int16'){
			//alert(document.getElementById(getId).value);
			//document.getElementById('expMonth').focus();
		}else if(document.getElementById(getId).value.length==0 && document.getElementById(getId).value!=' ' && document.getElementById(nextId).value==''){
			document.getElementById(nextId).focus();
			conc();
			return true;
		}
	}


	$(document).ready(function(){  
		$('.key_input2').on('paste', function(e) {
		alert($(this).val());
		alert(document.execCommand("copy"));	
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
		if(text.length==16){
			$('#int1').val(text[0]);
			$('#int2').val(text[1]);
			$('#int3').val(text[2]);
			$('#int4').val(text[3]);
			$('#int5').val(text[4]);
			$('#int6').val(text[5]);
			$('#int7').val(text[6]);
			$('#int8').val(text[7]);
			$('#int9').val(text[8]);
			$('#int10').val(text[9]);
			$('#int11').val(text[10]);
			$('#int12').val(text[11]);
			$('#int13').val(text[12]);
			$('#int14').val(text[13]);
			$('#int15').val(text[14]);
			$('#int16').val(text[15]);
		}
	});
	
	var key_input_val='';
	
	$('.key_input').on('click focus', function(e) {
		key_input_val=$(this).val();
		$(this).val('');
		$(this).attr('placeholder',key_input_val+'');
		
	});
	$('.key_input').on('focusout', function() {
		if($(this).val()===''||$(this).val()==''){
			$(this).val(key_input_val);
		}
	}); 
	
	var key_input_val2='';
	$('.key_input').on('mouseenter', function(e) {
		key_input_val2=$(this).val();
		$(this).val('');
		$(this).attr('placeholder',key_input_val2+'');
	});
	
	$('.key_input').on('mouseleave', function() {
		if(($(this).val()===''||$(this).val()=='')&&(key_input_val2)){
			$(this).val(key_input_val2);
			key_input_val2='';
		}
	}); 
	

	$("#cardsend_submit").click(function() {
		if(BrowserName==setBrowserName){ 
		
		}else{
			//conc();
		}
	});

	$('.key_input').keyup(function(e){
		if(e.keyCode == 8){
			key_input_val2='';
			$(this).attr('placeholder','');
			var cId = 0;
			cId = parseInt(($(this).attr('id')).replace('int',''));
			key_input_val='';
			$(this).val('');
			var pId=(cId-1);
			if(pId>0){
				document.getElementById('int'+(pId)).focus();
			}
		}
	}); 
	
	if($("#number").val()!=''){
		$("#number").trigger('keyup');
	}
	
	<? if(isset($post['acquirer'])&&trim($post['acquirer'])&&$post['acquirer']>0){?>
		$(".account_types[value='<?=@$post['acquirer']?>']").trigger("click"); 
	<? } ?>
	
});	

</script>

<style>
.img5 img{max-height:5px;}
.img10 img{max-height:10px;}
.img15 img{max-height:15px;}
.img20 img{max-height:20px;}
.img30 img{max-height:30px;}
.img35 img{max-height:35px;}
.blur_layer {position:absolute; z-index:99; width:100%;height:100%;backdrop-filter: blur(1px);}
				
.or_1 {height:3px;background:#020024;background:linear-gradient(90deg,rgba(2,0,36,1) 0%,rgba(218,0,203,1) 0%,rgba(204,204,204,1) 0%,rgba(255,255,255,1) 0%,rgba(255,255,255,1) 25%,rgba(197,196,198,1) 50%,rgba(255,255,255,1) 75%,rgba(255,255,255,1) 100%);}

.modalpopup_processing .modalpopup_form_popup_layer {background:var(--background-1)!important;display:block;position:fixed;z-index:9;width:100%;min-height:250px;opacity:0.4!important;top:-250px;left:0;margin:0;float:left;}

.modalpopup_processing  .modalpopup_form_popup_body{display:block;position:absolute;z-index:9999999;left:0;top:-200px;min-width:375px;height:400px;margin:0 auto;opacity:1;border-radius:5px;color:#333;text-align:center;    overflow:unset;}

.mx_button_row {margin:0 -3px;}
.mx_button_1{border: 0;border-top: 1px solid var(--color-4);border-right: 1px solid var(--color-4);width:49%;border-radius:0;padding:10px 0;font-size:16px !important;}		
.mx_button_2{border: 0;border-top: 1px solid var(--color-4);width:49%;border-radius:0;margin:0;margin-left:-3px;padding:10px 0;font-size:16px !important;}	

.walletsDiv.desImg ,.appLogoDiv2.desImg {height:36px;cursor:pointer !important;}
.walletsDiv img, .appLogoDiv img{height:30px!important;width:auto!important;display:block!important;margin:7px auto!important;line-height:50px;vertical-align:middle}

.banksDiv.active, .walletsDiv.active , .appLogoDiv2.active {background:#1c511c;color:#fff;}
.banksDiv, .walletsDiv, .appLogoDiv2, .upisDiv {display:table-cell;vertical-align:middle; text-align:center;width:48%;height:36px;line-height:50px;border:1px solid #ccc;border-radius:3px;float:left;margin:2px;cursor:pointer;}
	
.banksDiv:nth-child(2n), .walletsDiv:nth-child(2n), .appLogoDiv2:nth-child(2n), .upisDiv:nth-child(2n) {
   margin: 2px 4px 2px 0px; 
}
	
.banksDiv:nth-child(1n), .walletsDiv:nth-child(1n), .appLogoDiv2:nth-child(1n), .upisDiv:nth-child(1n) {
  margin: 2px 0px 2px 4px;
}


/*html .upi_qr_row.active .upi_qr_text {margin-top:1rem!important;}*/

 body { background:#ffffff !important; }
.row {--bs-gutter-x: 0rem !important; }
    
 p { margin-top: 2px !important; margin-bottom: 2px !important; }
.logo-img { max-height: 55px; vertical-align:middle;}
.icon-position {position: absolute;margin-top: 0px;margin-left: -5px;}
.back_action { width:20px;margin-top: 5px; margin-left: 5px; }
.heading2_ind {font-size: 10px;font-weight: 400;}
.toast:not(.showing):not(.show) { opacity: unset !important;}
.toast {width: 100%;}
.b-example-divider {height: 2rem !important; background-color: #2a82d7 !important;color: #ffffff !important;border-width:unset !important;}
.bank_img { height: 24px; margin-bottom: 3px;margin-top: 10px;}
.qr_img { filter: blur(5px); margin: 15px;}
.upi_qr_img { /*filter: blur(2px);*/ height:125px;}
.upi_qr_border {

  background:
    linear-gradient(to right, #2a82d7 2px, transparent 2px) 0 0,
    linear-gradient(to right, #2a82d7 2px, transparent 2px) 0 100%,
    linear-gradient(to left, #2a82d7 2px, transparent 2px) 100% 0,
    linear-gradient(to left, #2a82d7 2px, transparent 2px) 100% 100%,
    linear-gradient(to bottom, #2a82d7 2px, transparent 2px) 0 0,
    linear-gradient(to bottom, #2a82d7 2px, transparent 2px) 100% 0,
    linear-gradient(to top, #2a82d7 2px, transparent 2px) 0 100%,
    linear-gradient(to top, #2a82d7 2px, transparent 2px) 100% 100%;

  background-repeat: no-repeat;
  background-size: 20px 20px;
  height:150px;
  
  }

.wallet_img { height: 30px;}
.desImg{ height: 86px; cursor:pointer !important; }
.unset .desImg{ height: unset !important;}
.desImg.active{background-color: #c7d7e7 !important; border-bottom: 2px solid #2a82d7 !important;} 

.walletLogo_div .desImg.active{background-color: #eeea82 !important; border-bottom: 2px solid #2a82d7 !important;}

.input-field.select label{top:-10px !important;font-size: 10px!important;} 
.input-field select:focus+label, .input-field select:valid+label { position: absolute;top: -10px;left: 6px;font-size: 10px;padding: 0px 2px;/*background-color: var(--bs-body-bg) !important;color: var(--bs-body-color) !important;*/ }
.fa-xl { line-height: unset !important; vertical-align:unset !important;margin-top: -3px }
.icon-toggle::after { font-family: "Font Awesome 6 Free"; font-weight: 900; content: "\f0d7"; padding: 2px;}
.modal_msg_close { position: unset; 
     z-index: unset;  
     right: unset;
     top: unset;
     width: unset;
     height: unset;
     color: #000000 !important;
     background: unset;
     text-align: unset;
     border-radius: unset; 
     overflow: unset;
     cursor: unset;
	}
	
.modal_msg_body {width: 300px;height: auto !important;/*margin: -100px 0 0 -150px !important;*/}

div.image_text_center {
    position: relative }
div.image_text_center p {
    margin: 0;
    position: absolute;
    top: 45%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%) }

/*////For change header and button color//////////*/
<? if(strtolower($_SESSION['root_background_color'])=="#ffffff"){ $btn_clrs="#2a82d7"; ?>

.btn-primary { color: #ffffff !important; background:#2a82d7 !important; border-color:var(--color-4)!important;}
.payment-header, .bg_2 { color: #ffffff; background-color: #2a82d7;}
.txt_2 {color: #2a82d7;}

.modalpopup_processing .modalpopup_form_popup_layer {background:#2a82d7!important;}


<? } else{ $btn_clrs=$_SESSION['background_gd3']; ?>
.payment-header, .bg_2 { color: <?=@$_SESSION['root_text_color'];?>; background: var(--background-1)!important;}
.txt_2 {color: var(--background-1)!important;}

.label_active { /*background: <?=@$_SESSION['background_gl7'];?>;*//*padding: 8px 0px 2px 0px; margin: 2px 2px 2px 2px;*/}
.text-muted.clrs { color: unset !important; }
.b-example-divider { background: var(--background-1)!important; }
<? } ?>
/*.btn-primary:hover { color: #2a82d7 !important; background:#ffffff !important; border-color:var(--color-4)!important; }*/

	.btn-slide {
    color: #fff;
    border: 3px solid <?=@$btn_clrs?>;
    background-image: linear-gradient(30deg, <?=@$btn_clrs?> 50%, transparent 50%);
    background-size: 350px;
    background-repeat: no-repeat;
    background-position: 0%;
    -webkit-transition: background 300ms ease-in-out;
    transition: background 300ms ease-in-out;
    }
    .btn-slide:hover {
    background-position: 100%;
    color: <?=@$btn_clrs?>;
	}

/*////For change header and button color//////////*/

.inputWithIcon { position: relative; }
.inputWithIcon i { position: absolute;right: 5px;top: 4px;color: #aaa;transition: 0.3s;font-size: 26px;}
.iconrupay{background:#fff url(images/rupaycard.jpg) 99% 3px no-repeat;background-size:8%; float:left; }  
.form-label { font-weight: unset !important;} 
.form-check { min-height:unset !important;}
.accordion-button { background-color: #ffffff !important; color: #000000 !important;padding: 0px 10px !important; font-size:unset !important;}
.accordion-body{ padding: 0px 10px !important;}
.accordion-button:not(.collapsed) { background-color: #ffffff !important;color: #000000 !important; }
    

.payment-form .form-row{display:inline-block;width:100%}
.gpay-main .static-menu input.menu-input-onesuffix{border:none;background:none;font-size:15px;padding-top:5.5px}
.static-menu .upi-inp{width:50%}
.static-menu{border:1px #ccc solid;-webkit-border-radius:4px;-moz-border-radius:4px;border-radius:4px;background:#fff;height:36px;padding:6px 10px;position:relative;transition:all 400ms ease-in-out;width:100%;font-family:'Avenir-Book'}
.gpay-main .static-menu input.menu-input{border:none;background:none;font-size:14px;padding-top:4px}
*{outline:0}
#upi2IdRow .sbm-option ul{list-style:none}
.static-menu .sbm-option{position:absolute;top:36px;left:-1px;width:100%;border-top:none;border-bottom:none;z-index:1;background:#fff;border:1px #ccc solid;-webkit-border-bottom-right-radius:4px;-webkit-border-bottom-left-radius:4px;-moz-border-radius-bottomright:4px;-moz-border-radius-bottomleft:4px;border-bottom-right-radius:4px;border-bottom-left-radius:4px;box-sizing:content-box}
#upi2IdRow .static-menu input.menu-input{border:none;background:none;font-size:14px;padding-top:4px}
#upi2IdRow ul li{font-size:16px;font-family:'Avenir-Medium';line-height:normal;vertical-align:top;margin:0;padding:10px 13px;border:none;border-bottom:solid 1px #ccc;font-size:14px;transition:none}
#upi2IdRow ol,ul{padding-left:0!important}
#upi-data-list input{border:0;background:none!important}
#upi2IdRow ul li input:hover{background:var(--background-1)!important}
dl,ol,ul{margin-bottom:0!important}
#upi2IdRow INPUT{width:50%!important;min-width:50%!important;max-width:50%!important;border:unset!important}

#credit_cards img {height:30px;}

.modalMsgContTxt {padding:10px 20px; text-align:center;}
.processall .modalMsgContTxt h4{margin: 10px 0px;}
.universalWisePay {display:block;}
.universalWisePay.hide1 {display:none;}
#cardsend_submit i, .suButton i {display:none;}
#cardsend_submit .fa-spin-pulse {display:block !important;}	
body{top:0!important}


/*.oops2{margin:0;padding:0;overflow:auto;width:100%;height:100%;
	background: url("<?php echo $data['Host'];?>/images/criss-cross.png");
	border-color: #d6e9c6;
}*/



.clients.processall #credit_cards img {width:12.6%;}
.credit-card-box .strip {background:linear-gradient(135deg, #404040, #1a1a1a);position:absolute;width:100%;height:50px;top:30px;left:0;}
.credit-card-box .number {position:absolute;margin:0 auto;top:82px;left:19px;font-size:38px;}
.credit-card-box .card-holder,
.credit-card-box .card-expiration-date {position:absolute;margin:0 auto;top:164px;left:13px;font-size:16px;text-transform:capitalize;}
.the-most {position:fixed;z-index:1;bottom:0;left:0;width:50vw;max-width:200px;padding:10px;}
.the-most img {max-width:100%;}
.merchant_logo {position: relative;top:-42px;margin-bottom:-25px;text-align: center;}
.merchant_logo img {height: 70px;}
.submit_div {border-radius: 0.25rem!important;border: 1px solid #dee2e6!important;}
    
    

body, .container-fluid.fixed {border:0px solid #dddddd;}
.totalHolder {position:relative;display:table-cell;width: 240px;background: <?=@$_SESSION['background_g']?>;color:<?=@$_SESSION['color_g'];?>;text-align: left;margin: 0 10px 0 0;line-height:250%;}
.title_2 {color:#fff !important;}
.totalHolder .b {text-align: left;color: <?=@$_SESSION['background_gl7'];?>;margin: 10px 0 0 0;}
.totalHolder .txts {font-size: 20px;padding: 0 0 8px 0;margin: 0 0 7px 0;}
.totalHolder .txts.pro {max-height:100px;overflow:hidden;}
.dark1 {position:absolute;bottom:0;background: <?=@$_SESSION['background_gd7'];?>;color: #fff;text-align: right;float: left;width: 100%;height: inherit;line-height: 230%;}
.amount_total {/*font-size: 40px !important;*/}
.pad10 {padding:10px;}
.fs10 {font-size:10px !important;}
.ti, .capl {font-weight: normal !important;color: #023b80 !important;font-size: 24px;}

.result_view {font-family: Verdana,Tahoma,Trebuchet MS,Arial;font-size: 11px;}

.processall TD.field {padding: 8px;color: #444444;background-color: #F2F4F7;text-align: right;vertical-align: top;font-weight: bolder;}
.processall TD.input {line-height: 22px;background-color: #F2F4F7;vertical-align: top;padding: 4px;}
.processall TD.capl {background: url(<?=@$data['Host'];?>/css/customisation/images/bg-headers.png) repeat scroll -50px center transparent;padding: 9px 0px;color: #fff;font-weight: normal;-webkit-border-top-left-radius: 3px;-webkit-border-top-right-radius: 3px;-moz-border-radius-topleft: 3px;-moz-border-radius-topright: 3px;border-top-left-radius: 3px;border-top-right-radius: 3px;font-size: 14px !important;}

/*.showfp{display:none;}*/
.err_tr {padding:0 !important;margin:0 !important;}
.hide{display:none;}
.ctittle {float: left;padding-right: 10px;}
.cname label {font-size:12px;width:100%;white-space:nowrap;display:inline-block;padding:5px;}
.account_types.active {color:orange !important;}
input.account_types {padding: 0;margin:0 5px 0 0;float:left;position:relative;height:18px;line-height:30px;min-width:30px;;background:transparent !important;border: 0px solid #CECECE;-moz-box-shadow: 0 0px 0px #E5E5E5 inset;-webkit-box-shadow: 0 0px 0px #E5E5E5 inset;box-shadow: 0 0 0px 0px #E5E5E5 inset;padding: 0;}
.clients_pro input.account_types{top:2px;background:transparent;} 
.payment_option img {height: 15px !important;margin-top: 3px !important;}
.upi_qr img {height: 25px !important;}
.echeck_div, .pay_div {display:none;clear:both;float:left;width:100%;background:#fff;}
.pay_div .separator {margin: 0px 0 !important;float: left;width: 100%;height: 6px;}
#form-input-errors {display:none; float:left; width:100%; text-align:center; color:red; font-size:12px; margin:10px 0 0 0;}
.transparent {opacity: 0.2;}
.has-error {background:#ff0000;border:1px solid #ff0000;}
.maindiv{  display:block; margin:auto; background:#eeeeee;min-height:250px;}
.leftdiv{width:46%;float:left;  height:100%; margin-left:5px;}
.rightdiv{width:46%;float:left;  height:100%}

.p{padding-left: 20px; color:black;}
#credit_cards #jcb1{height:80px;position:relative;top:-17px;margin:0 0 -32px 0;}
.align{ margin-top:132px;}
.p0 {padding: 0;}
.ecol4{width:44%;float:left;padding-left:9px;padding-top:5px;padding-bottom:5px;padding-right:10px; }


#expMonth option[disabled] {color: #ffffff;background-color: #2a82d7;}
#expYear option[disabled] {color: #ffffff;background-color: #2a82d7;}
	    



<? if(isset($data['re_post'])&&$data['re_post']){?>
.merchant_logo {position: relative;top:-10px;margin-bottom:-5px;text-align: center;}
<? } ?>

.translateDiv{display:none;clear:both;width:105px;position:absolute;	z-index:99;float:right;margin:0 0px 10px 210px;background: url("<?php echo $data['Host'];?>/images/lang_4.png") <?=@$_SESSION['background_g']?> no-repeat; background-size:18px; background-position:left;}

#google_translate_element {
    width: 18px;
    overflow: hidden;
    margin-top: -16px;
    margin-left: 2px;
    height: 11px;
}
    
.goog-te-gadget-icon {
    /*background-image: url("<?php echo $data['Host'];?>/images/language-translator-ind.png")!important;*/
    /*background-position: 0px 0px;*/
    height: 0px!important;
    /*width: 32px!important;*/
    margin-right: 8px!important;
    //     OR
    display: none;
}

.goog-te-gadget-simple  {
  background-color: rgba(255,255,255,0.20)!important;
  border: 1px solid rgba(255,255,255,0.50) !important;
  /*padding: 8px!important;
  border-radius: 4px!important;
  font-size: 1rem!important;
  line-height:2rem!important;
  display: inline-block;
  cursor: pointer;
  zoom: 1;*/
}

#google_translate_element select {content: ''; border:0 !important; -webkit-appearance: menulist;-moz-appearance:menulist;padding: 0px 0px;font-weight:bold;color:#d07c00 !important;background: <?=@$_SESSION['background_g']?>;color:<?=@$_SESSION['color_g'];?> !important;margin:0 0 0 0px;}
#google_translate_element select:focus {outline: unset !important;}
.skiptranslate iframe {display:none !important;}
.skiptranslate iframe { background:#CC0000 !important;}
.input_key_div{display:block;width:100%;clear:both;padding:7px 0}
.credit-card-box .number{left:5px;top:78px}
.number .key_input{width:17px !important;min-width:17px;height:38px;outline:none !important;padding:0 0px;text-align:center;font-size:24px;letter-spacing:normal;font-weight:bold;border-radius:5px !important;border:1px solid #9d9d9d;display:inline-block;float:left;position:relative;z-index:9999;margin:0px 0px}
.number .key_input.bri{background:#dddddd;}
.number .key_input.lgt {margin:0 0px 0 0 !important;}
.number .key_input.rgt {margin:0 0 0 8px !important;}

.language-adj{width:20px !important;}
@media (max-width:1049px){
	.ctittle {width:60px;white-space:nowrap;padding-right: 0px;}
	 div.processall {width:100% !important;float:none;margin:-10px auto 30px auto;}
	.totalHolder {display:block;width:100%;margin:0 10px 0 0;height:inherit;}
	.totalHolder .txts.pro {max-height:inherit;}
	.dark1 {position:relative;}
	.clients.processall #credit_cards img { width: 23.6% !important; }
	.merchant_logo{position:relative;top:21px;margin-bottom:14px;text-align:center;}
	.totalHolder .b {margin: 0;width:auto;float:left;}
	.totalHolder .txts {font-size: 20px;padding: 0 0 0px 0;margin: 0;}
	.title_2 {display:none;}
	.totalHolder .txts{text-align: left;}
	.totalHolder .b {text-align: right;width: 32%;padding: 0 10px 0 0;}
	.bAdd {float:left;font-size:12px !important;font-weight:bold !important;} 
	.translateDiv{top:0;margin:20px 0 0 0;}
}

@media (max-width:500px){ 
	.language-adj{ margin-top:2px !important; }
	.mt2px{ margin-top:5px !important; }
}

@media (max-width:450px){ 
	.ecol4{width:100%;padding:0;}
}
@media (min-width: 200px){
    .col-sm-4 {
    flex: 0 0 auto !important;
    width: 33.33333333% !important;
	}
	.col-sm-6 {
    flex: 0 0 auto !important;
    width: 50% !important;
    }
}
</style>
<style>
	.merchantLogo {position: relative;text-align: center;}
	.merchantLogo img {height: 70px;}
	.company_name {font-weight:bold;font-size:26px;text-align: center;color:<?=@$_SESSION['color_g'];?>;float:left;height:inherit;width:100%;line-height:30px;padding:5px 0 10px 0;}

	.payingTo {font-size:14px;font-weight:normal;position:absolute;color:#959595;text-transform:uppercase;margin:5px;}
	
	.step_1 label {display:none;}
	.capc {background: transparent !important;}
	
	

	<? if(isset($data['con_name'])&&$data['con_name']=='clk'){?>
		.checkOutOptions {display:none;}
		
	<? } ?>
	
	
/*.cname .inputgroup {float:left;width:100%;}*/
.inputgroup .inputype:hover, .appLogoDiv:hover{ background:#f2f4f9;}
.paymentMethodDiv input.account_types {display:none;}
.payOpt{float:left;width:94%;}
	
.contInputDiv .la12 {margin:6px 0 3px 6px; display:none;}
.activeInput .labelAmount {margin:20px 0 0 0;}
.txIn {float:left;width:94%;font-size:18px;font-weight:bold;text-align:left;padding:0 0 0 2%;}
.la12 {float:left;width:100%;text-align:left;font-size:15px;margin:16px 0 3px 6px;cursor:none;}
.amount_total.bill_amt {/*float:left;width:12%;background:#dedfe0;height:36px;overflow:hidden;border-radius:3px 0 0 3px;font-size:28px !important;*/}

.amount_total.bill_amt #t_amt {/*position:relative;top:-1px;*/}

.upisDiv img {height:30px;display:inline-block;line-height:50px;vertical-align:middle;width:auto;margin:11px auto 0 auto;}
.upisDiv.active {background:#fff;color:#000; border:1px solid <?=@$_SESSION['background_gd5'];?>; }
.banksDiv.active, .appLogoDiv.active {background:<?=@$_SESSION['background_gd5'];?>;color:#fff;}
.appLogoDiv.active .form-check-input {
									   appearance: none;
                                       -webkit-appearance: none;
                                       border-radius: 50%;
                                       background: var(--link-color-template);
                                       border: 3px solid #FFF;
                                       box-shadow: 0 0 0 1px var(--link-color-template);
	                                  }
	
	
	
.banks_bank_1, .banks_sprite {background-image:url(<?=@$data['Host']?>/images/banks-sprite.png);width:32px;display:inline-block;line-height:50px;position:relative;top:-2px;}
.banks_bank_1 {background-position:0 -42px;height:31px;}
.banks_bank_2 {background-position:-32px 0;height:38px;}
.banks_bank_3 {background-position:-64px 0;height:33px;}
.banks_bank_4 {background-position:-96px -29px;height:29px;}
.banks_bank_5 {background-position:0 -73px;height:28px;}
.banks_bank_6 {background-position:-64px -42px;height:31px;}
.banks_bank_7 {background-image:url(<?=@$data['Host']?>/images/idfc_bank_logo.png);background-position:0;height:29px;background-size:30px;background-repeat:no-repeat;}

</style>


  <div class="processall border rounded rounded-tringle my-3" style=" max-width:375px; margin:0 auto;">
	<div class="content_top " >
		<? if(isset($_SESSION['re_post']['failed_reason'])){
		$c_style2='style="display:none;"'; 
		//$_SESSION['re_post']['failed_reason']='Do Not Honor Payment Failed.';
	?>
		<div class="col-sm-12 text-center py-2 alertPaymentDiv"> 
		  <div class="show my-2 fs-5" role="alert">Payment Failed</div>
           
		   
		  <div class="col-sm-12 text-center px-2 my-3"> 
		  <i class="<?=@$data['fwicon']['circle-info'];?> fa-6x text-danger"></i>
          </div> 
          <div class="timerText text-center my-3" >Payment Complete before the end of minutes  <br />
<span id="timer1" class="timer text-center" style="">05:00</span></div>
          <a class="nopopup tryAgain btn btn-primary my-2" ><i class="<?=@$data['fwicon']['check-circle'];?>"></i> Try Again</a> 
		  <a title="<? if(isset($_SESSION['http_referer'])) echo $_SESSION['http_referer'];?>" class="nopopup merchantPage btn btn-primary my-2" ><i class="<?=@$data['fwicon']['back'];?>"></i> Go Back </a> 
		  
		  </div>
		<? } ?>
		
		<div id="nextOptionDivId" class="border_con" <?=isset($c_style2)?$c_style2:'';?> >
		
		<?
			if(isset($_SESSION['action'])&&$_SESSION['action']=="vt"){
				$heading_1="Virtual Terminal";
			}else{
				$heading_1="Billing Information";
			}

		if((isset($post['step'])&&$post['step']==2)||(isset($data['con_name'])&&$data['con_name']=='clk')){
		
		?>
		<? if(isset($data['con_name'])&&$data['con_name']=='clk'){
		?>
		
		<div class="slidePaymentDiv99 row border rounded payment-header" >
		<div class="row">
		
		<? if(isset($_SESSION['merchant_logo_url'])&&$_SESSION['merchant_logo_url']){ ?>
			<div class="col rounded image_text_center" style="max-width:85px;" >
			<p class="p-1"><img src="<?=(@$_SESSION['merchant_logo_url']);?>" class="img-thumbnail " alt="Logo"/></p>
			</div>
        <? }else if(isset($_SESSION['dba_brand_name'])&&@$_SESSION['dba_brand_name']){ ?>
		    <div class="col border border-2 m-2 rounded image_text_center fw-bold" style="max-width:55px;" >
			<p><?=prntext(substr(@$_SESSION['dba_brand_name'],0,1))?></p>
			</div>
		<? }else{ ?>
		    <div class="col border border-2 m-2 rounded image_text_center  fw-bold" style="max-width:55px;" >
			<p><?=prntext(substr(@$_SESSION['ter_name'],0,1))?></p>
			</div>
		<? }?>
		
		
		
		
		
		<div class="col p-1">
		<div>
		<div class="fw-bold fs-6 font-monospace clrs float-start ps-1" style=" width: calc(100% - 26px);">Paying to <?=prntext(@$_SESSION['ter_name'])?>
		</div>
		<div class="float-start text-end language-adj"><i class="<?=@$data['fwicon']['language'];?> language-collapse" title=" language" style="font-size:15px;" ></i><div id="google_translate_element"></div>
		
	<?php /*?>Supporting Files for Language Translator	<?php */?>
	<script language="javascript" type="text/javascript"> 
	function googleTranslateElementInit() {
	new google.translate.TranslateElement({pageLanguage: 'en', includedLanguages: 'en,bn,gu,hi,kn,mr,ta,te,', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
	/*bho,mai,ml,or,pa,sa,ur*/
	}
	</script>
	<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
	<?php /*?>End Supporting Files for Language Translator	<?php */?>	
		</div>
		</div>
		<div class="fw-bold fs-6 font-monospace ps-1 clearfix"><span class="w-50"><?=get_currency($post['curr']?$post['curr']:$_SESSION['curr']);?><?=(@$post['total']?$post['total']:$post['bill_amt'])?></span> <span class="w-50 float-end text-end"><? if(isset($_SESSION['re_post']['return_failed_url'])&&$_SESSION['re_post']['return_failed_url']){?>
			<div class="timerText2 text-end" ><span id="timer2" class="timer" style="222">05:00</span></div>
			<? } ?></span></div>
		</div>
		</div>
		
			<div class="payingMdiv99 ">
			<? if(isset($_SESSION['mem']['user_type'])&&$_SESSION['mem']['user_type']==1){
			   $_SESSION['info_data']['company_name']=$_SESSION['mem']['fname'].' '.$_SESSION['mem']['lname'];	
			} ?>
		
			</div>
		</div>
		<? if(isset($post['chooseStore'])&&$post['chooseStore']){?>
		<div class="ecol2 m-2 input-field select my-3" style="min-height: 200px;">
		 	
			<select name="storeType" id="storeType" class="form-select form-select-lg" >
			<option value="" selected="selected">Choose Business Type</option>
			<? foreach($post['allStore'] as $key=>$val){ ?>
			<option data-title="<?=@$val['id']?>" value="<?=@$val['public_key']?>" >
			<?=@$val['bussiness_url']?>
			<? if(isset($data['localhosts'])&&$data['localhosts']==true){?>
			|
			<?=@$val['name']?>
			:
			<?=@$val['public_key']?>
			<? } ?>
			</option>
			<? } ?>
			</select>
			<label for="storeType">Select a website type</label>
			
		
		<? }
	else{?>
		<div class="ecol2 bill_amtInputDiv px-2">
		<?
			if(isset($data['Error'])&&$data['Error']){
				$display_style="style='display:block;'";
			}else {
				$display_style="style='display:none;'";
			}
			
	
			if(isset($_POST['product'])){
				$post['product']=$_POST['product'];
			}
		?>
		<div class="hide error errorDivId" id="form-input-errors" <?=@$display_style;?>>
			<?//=prntext(@$data['Error'])?>
		</div>
		
		  <? if(isset($post['pricManual'])&&$post['pricManual']){?>
		  <div class="sIn">
			<input type="text" name="product" placeholder='Purpose of Payment!' class="inputPurpose form-control my-2" value="<?=(@$_SESSION['product']?$_SESSION['product']:'Payment For')?>">
		  </div>
		  
		  <? } ?>
		  
		  
		  <? if(isset($post['pricManual'])&&$post['pricManual']){?>
		  <div class="sIn">
			<?php /*?><div class="amount_total bill_amt"><font id="t_amt">₹</font></div>
			<input class="bill_amt90 form-control " type="text" name="bill_amt" placeholder='Bill Amount' value="<?=(@$post['bill_amt']=='0.00'?'1.00':$post['bill_amt']);?>" required/><?php */?>
			
			<div class="input-group mb-3">
  <span class="input-group-text" id="basic-addon1"><font id="t_amt">₹</font></span>
  <input type="text" class="bill_amt90 form-control" name="bill_amt" placeholder='Bill Amount' value="<?=(@$post['bill_amt']=='0.00'?'1.00':$post['bill_amt']);?>" required aria-label="Username" aria-describedby="basic-addon1">
</div>
		  </div>
		  <? } ?>
		  
		  <div class="bill_amtSys" style="display:none;"><font id="t_amt"></font></div>
		  <? if(isset($post['pricManual'])&&$post['pricManual']){?>
		  <button id="bill_amtSubmit" type="button" value="CHANGE NOW!"  class="submitbtn btn btn-primary w-100 mb-2  next sIn"><i></i><b class="contitxt loader-btn">Pay</b></button>
		  <? } ?>
		  
			 
		</div>
		<div class="nextSt contInputDiv mx-2 hide was-validated">
		  <!--<div class="brec">Your Details > Payment</div>-->
		  <? if((isset($post['pricManual'])&&$post['pricManual'])||(empty($post['fullname']) || empty($post['bill_phone']) || empty($post['bill_email']) )){?>
		
		 <!-- <div class="separator" style="clear:both"></div>-->
		 

                  <div class="input-field my-3">
					<input type="text" name="fullname" value="<?=(@$post['fullname']?prntext(@$post['fullname']):prntext(@$_SESSION['re_post']['fullname']));?>" id="input_fullname" title="Full Name" minlength="3" class="form-control is-invalid" required >
                    <label for="input_fullname">Full Name</label>
                  </div>
<script> if(($('#input_fullname').val())!=""){ $("#input_fullname").removeClass('is-invalid').addClass('is-valid'); } </script>
		  

          
        
          
          <div class="input-field my-3">
  <input type="text" name="bill_phone" value="<?=(@$post['bill_phone']?prntext(@$post['bill_phone']):prntext(@$_SESSION['re_post']['bill_phone']));?>" id="input_mobile" title="Mobile Number" minlength="10" class="form-control is-invalid" required>
  <label for="input_mobile">Mobile Number</label>
</div>
<script> if(($('#input_mobile').val())!=""){ $("#input_mobile").removeClass('is-invalid').addClass('is-valid'); } </script>          

          
          <div class="input-field my-3">
  <input type="email" name="bill_email" size="30" maxlength="128" value="<?=(isset($post['bill_email'])&&$post['bill_email']?prntext(@$post['bill_email']):prntext(@$_SESSION['re_post']['bill_email']));?>" id="input_mail" title="Email Address" class="form-control is-invalid my-1" required>
  <label for="input_mail">Email Address</label>
</div>
<script> if(($('#input_mail').val())!=""){ $("#input_mail").removeClass('is-invalid').addClass('is-valid'); } </script>

		  <? } ?>
		  
		  <button id="contSubmit" type="button" value="CHANGE NOW!" class="submitbtn btn btn-primary w-100 mb-2 next"><i></i><b class="contitxt">Next</b></button>
		</div>
		<div class="paymentContainerDiv">
		<div class="paymentMethodDiv hide">
		  <div class="payment_option m-2">
			<? 
			//print_r($_POST);
			if(isset($_SESSION['curr'])) $currency_smbl=get_currency($_SESSION['curr']);
			else $currency_smbl='';
			?>
			<h4 class=""><span class="paymentMethodh4">CARDS, UPI & MORE</span> <span id='result_view_chk' class='result_view'></span> <span id='result_view' class='result_view'> </span> <a class="change hide float-start me-3" id="paymentMethodChange" ><i class="<?=@$data['fwicon']['return'];?> fa-xl fa-fw" title="Change Payment Method"></i></a></h4>
			<div class="chkname" >
			
			  
			  <? if(isset($post['acquirer_id_card'])&&!empty($post['acquirer_id_card'])){?>
                  <div class="cname cardDiv">
                    <div class="inputgroup">
		<?
		
		$outputArray_1 = array();
		
		
		foreach($_SESSION['AccountInfo'] as $key=>$value){if((isset($value['acquirer_id'])&&$value['acquirer_id']) && isset($_SESSION['b_'.$value['acquirer_id']]['channel_type']) && (in_array($value['acquirer_id'],$post['acquirer_id_card_arr'])) && ($value['acquirer_processing_mode']!="3") && ($_SESSION['b_'.$value['acquirer_id']]['acquirer_status']>0)  && (!in_array($value['acquirer_id'],$outputArray_1)) ) {
		  
			$outputArray_1[] = $value['acquirer_id'];

			
		   //if($_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$pcrcy;}
		   if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
					?>
				  <div class="inputype the_icon <?=countryCodeMatch2($post['country_two'],(isset($_SESSION["b_".$value['acquirer_id']]['countries'])?$_SESSION["b_".$value['acquirer_id']]['countries']:''),(isset($_SESSION["b_".$value['acquirer_id']]['processing_countries'])?$_SESSION["b_".$value['acquirer_id']]['processing_countries']:''),isset($_SESSION["b_".$value['acquirer_id']]['block_countries'])?$_SESSION["b_".$value['acquirer_id']]['block_countries']:'')?> border rounded my-1 mb-1 w-100">
				  
					<input type="radio" value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" id="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" data-name="ecard" data-ccn="<?=(isset($_SESSION['b_'.$value['acquirer_id']]['mop'])?@$_SESSION['b_'.$value['acquirer_id']]['mop']:'')?>" data-currency="<?=@$pcrcy;?>" data-ewlist="<?=acquirer_popup_msg_f($value['acquirer_id'])?>"  data-etype="2D"  data-channel='<?=(isset($_SESSION["b_".$value['acquirer_id']]['channel_type'])?$_SESSION["b_".$value['acquirer_id']]['channel_type']:'');?>'   data-count='<? if(isset($_SESSION["b_".$value['acquirer_id']]['deCon'])) echo $_SESSION["b_".$value['acquirer_id']]['deCon'];?>' data-dnmc='<? if(isset($_SESSION["b_".$value['acquirer_id']]['block_countries'])) echo $_SESSION["b_".$value['acquirer_id']]['block_countries'];?>'  style="display:none;" />
					<label for="<?=@$value['acquirer_id']?>" class="pointer">
						<strong class="text-muted ">
						<span class="back_action float-start me-3" style=""><i class="<?=@$data['fwicon']['credit-card'];?> text-info"></i><i class="<?=@$data['fwicon']['credit-card'];?> icon-position "></i></span>
                        <? if(acquirer_label_f(@$value['checkout_label_web'],@$value['checkout_label_mobile'],$value['acquirer_id'])){echo acquirer_label_f(@$value['checkout_label_web'],@$value['checkout_label_mobile'],$value['acquirer_id']);
						 echo "<div class='heading2_ind'>Visa, MasterCard, RuPay & More</div>";}else{?>
                        Pay by Card [
                        <?=(isset($_SESSION['curr_transaction_amount'])?$_SESSION['curr_transaction_amount']:'');?>
                        ]
                        <? } ?> 
								
								</strong>
						
                        </label>
				  </div>
				  <? }} ?>
				</div>
			  </div>
			  <? } ?>
			  <? if(isset($post['nick_name_net_banking'])&&!empty($post['nick_name_net_banking'])){?>
			  <div class="cname netBankCont">
				<div class="inputgroup">
				  <? foreach($_SESSION['AccountInfo'] as $key=>$value){
				  if(isset($value['acquirer_id'])&&(@$value['acquirer_id']) && (strpos(@$_SESSION['b_'.$value['acquirer_id']]['channel_type'],'Banking') !== false) && (in_array(@$value['acquirer_id'],@$post['nick_name_net_banking_arr'])) && (@$value['account_login_url']!="3")  ){
					  
						if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
					  
						
						if(isset($value['account_login_url'])&&$value['account_login_url']=="1"){$dataname="ewallets"; }
						elseif(isset($value['account_login_url'])&&$value['account_login_url']=="2"){$dataname="evoilatecard"; }
					?>
				  <div class="inputype <?=(isset($data['t'][$value['acquirer_id']]['logo'])?"the_icon":"")?> <?=countryCodeMatch2($post['country_two'],(isset($_SESSION["b_".$value['acquirer_id']]['countries'])?$_SESSION["b_".$value['acquirer_id']]['countries']:''),(isset($_SESSION["b_".$value['acquirer_id']]['countryCode'])?$_SESSION["b_".$value['acquirer_id']]['countryCode']:''))?> border rounded my-1 w-100" >
					<input type="radio" value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" id="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" data-name="<?=@$dataname;?>" data-currency="<?=@$pcrcy;?>" data-submitmsg="intent_submitMsg<?=(isset($data['t'][$value['acquirer_id']]['submitMsg']))?$data['t'][$value['acquirer_id']]['submitMsg']:'';?>" data-ewlist="<?=(isset($data['t'][$value['acquirer_id']]['name6']))?$data['t'][$value['acquirer_id']]['name6']:'';?>" data-etype="<?=(isset($data['t'][$value['acquirer_id']]['name4']))?$data['t'][$value['acquirer_id']]['name4']:'';?>" data-channel='<?=(isset($_SESSION["b_".$value['acquirer_id']]['channel_type'])?$_SESSION["b_".$value['acquirer_id']]['channel_type']:'');?>'    style="display:none;" />
					<label for="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" class="pointer">
                        
                        
                        <strong class="text-muted">
						<span class="back_action float-start icon_the_pay me-3">
						<? if($value['checkout_level_name']=="UPI Wallets"){ 
						echo '<i class="'.$data['fwicon']['wallet_code'].' text-dark" title="UPI Wallets !!!"></i>';
						}elseif(strstr($value['checkout_level_name'],"Net Banking") || strstr($value['checkout_level_name'],"NB")){ 
						echo '<i class="'.$data['fwicon']['net_banking'].' text-info" title="Net Banking !!!"></i>
						<i class="'.$data['fwicon']['net_banking'].' icon-position" title="Net Banking !!!"></i>';
						}else{ 
						
						?>
						<img src="<?=@$data['Host']?>/images/<?=@$data['t'][$value['acquirer_id']]['logo'];?>_logo.png" title="<?=@$value['checkout_level_name'];?>"  />
						<? } ?>
						</span>
						
						<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name']; echo "<div class='heading2_ind'>All indian banks</div>";}else{?>
                        Pay with eWallets [ <?=(isset($_SESSION['curr_transaction_amount'])?$_SESSION['curr_transaction_amount']:'');?> ]
                        
                        <? } ?>
						
						        
								
								</strong>
                        </label>
				  </div>
				  <? }} ?>
				</div>
			  </div>
			  <? } ?>
			  
			  
			  
			  
			  
			  <? if((isset($post['acquirer_id_ewallets'])&&!empty($post['acquirer_id_ewallets']))||(isset($post['acquirer_id_net_banking'])&&!empty($post['acquirer_id_net_banking']))||(isset($post['acquirer_id_upi'])&&!empty($post['acquirer_id_upi']))){?>
				<div class="cname netBankEdiv">
					<div class="inputgroup">
					<? 
					//wallet & net banking 
					$acq_cnt=0;
					$acq_typ="";
					$outputArray_2 = array();
					//echo count($_SESSION['AccountInfo'])."444444";
					foreach($_SESSION['AccountInfo'] as $key=>$value){
					
						if((isset($value['acquirer_id'])&&$value['acquirer_id']) && ( (isset($post['acquirer_id_ewallets_arr'])&&in_array($value['acquirer_id'],@$post['acquirer_id_ewallets_arr']) ) || (isset($post['acquirer_id_net_banking_arr'])&&in_array($value['acquirer_id'],@$post['acquirer_id_net_banking_arr'])) || (isset($post['acquirer_id_upi_arr'])&&in_array($value['acquirer_id'],@$post['acquirer_id_upi_arr'])) ) && ($value['acquirer_processing_mode']!="3") && (isset($_SESSION['b_'.$value['acquirer_id']]['acquirer_status'])&&$_SESSION['b_'.$value['acquirer_id']]['acquirer_status']>0) && (!in_array($value['acquirer_id'],$outputArray_2)) ) {
					  
						$outputArray_2[] = $value['acquirer_id'];

						if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}
					  
					   
						if(isset($value['acquirer_processing_mode'])&&$value['acquirer_processing_mode']==1){
							$dataname="ewallets"; 
							$data_ccn=''; 
						}
						elseif(isset($value['acquirer_processing_mode'])&&$value['acquirer_processing_mode']==2){
							$dataname="evoilatecard"; 
							$data_ccn='data-ccn="visa"';
						}
						
						
				
					
					?>
				  <div class="inputype the_icon  <?=countryCodeMatch2($post['country_two'],isset($_SESSION["b_".$value['acquirer_id']]['countries'])?$_SESSION["b_".$value['acquirer_id']]['countries']:'',isset($_SESSION["b_".$value['acquirer_id']]['processing_countries'])?$_SESSION["b_".$value['acquirer_id']]['processing_countries']:'',isset($_SESSION["b_".$value['acquirer_id']]['block_countries'])?$_SESSION["b_".$value['acquirer_id']]['block_countries']:'')?> border rounded my-1 mb-1 w-100">
					<input type="radio" value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" id="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" data-name="<?=(isset($dataname)?$dataname:'');?>" data-currency="<?=@$pcrcy;?>" data-submitmsg="intent_submitMsg" data-ewlist="<?=acquirer_popup_msg_f($value['acquirer_id'])?>" data-etype="3D" data-channel='<?=(isset($_SESSION["b_".$value['acquirer_id']]['channel_type'])?$_SESSION["b_".$value['acquirer_id']]['channel_type']:'');?>'  data-count='<?=(isset($_SESSION["b_".$value['acquirer_id']]['deCon'])?$_SESSION["b_".$value['acquirer_id']]['deCon']:'');?>' data-dnmc='<? if(isset($_SESSION["b_".$value['acquirer_id']]['block_countries'])) echo $_SESSION["b_".$value['acquirer_id']]['block_countries'];?>' style="display:none;" <?=(isset($data_ccn)?$data_ccn:'');?> />
					<label for="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" class="pointer">
                        
                        
                        <strong class="text-muted">
						<span class="back_action float-start icon_the_pay me-3">
						<? 
                        $pmt_type=$data['channel'][$_SESSION['b_'.$value['acquirer_id']]['channel_type']]['name1'];
						//echo $pmt_type;
						//if(acquirer_logo_f($value['acquirer_id'])){ 
						
						?>
							<!--<img src="<?=@$data['Host']?>/images/<?=acquirer_logo_f($value['acquirer_id']);?>_logo.png" title="<?=@$value['checkout_label_web'];?>" class="img-hover33"  />-->
						<? 
						//}
                       
					   if($pmt_type=="wa"){ 
							$sub_title="PhonePe Paytm Amazon & More";
							echo '<i class="'.$data['fwicon']['wallet_code'].' text-info" title="UPI Wallets"></i> <i class="'.$data['fwicon']['wallet_code'].' text-dark icon-position" title="UPI Wallets"></i>';
						}elseif($pmt_type=="nb"){ 
							$sub_title="All Indian Bank";
							echo '<i class="'.$data['fwicon']['net_banking'].' text-info" title="Net Banking"></i> <i class="'.$data['fwicon']['net_banking'].' icon-position" title="Net Banking "></i>';
						}elseif($pmt_type=="bt"){ 
							$sub_title='<span style="position:relative;top:4px;margin:0 5px 0 0;"><i class="'.$data['fwicon']['net_banking'].' icon-position" title="Bank Transfer "></i></span> Bank Transfer';
							echo $data['fwicon']['bt'];
						}elseif($pmt_type=="qr"){ 
							$sub_title="<img src='".$data['bankicon']['google-pay-svg']."' alt='google-pay'>&nbsp;<img src='".$data['bankicon']['phonepe-svg']."' alt='phonepe'>&nbsp;<img src='".$data['bankicon']['paytm-svg']."' alt='paytm'> & More";
							echo '<i class="'.$data['fwicon']['qrcode'].' text-info" title="QR"></i> <i class="'.$data['fwicon']['qrcode'].' icon-position" title="QR"></i>';
						}elseif($pmt_type=="upiqr"){ 
							$sub_title_0='<span style="position:relative;top:4px;margin:0 5px 0 0;"><i class="'.$data['fwicon']['qrcode'].' text-info" title="UPI Payment"></i> <i class="'.$data['fwicon']['qrcode'].' icon-position" title="UPI Payment"></i></span>';
							$sub_title=$sub_title_0."<img src='".$data['bankicon']['google-pay-svg']."' alt='google-pay'>&nbsp;<img src='".$data['bankicon']['phonepe-svg']."' alt='phonepe'>&nbsp;<img src='".$data['bankicon']['paytm-svg']."' alt='paytm'> & More"; ?>
							
								<img src="<?=@$data['bankicon']['upi-icon']?>" title="<?=@$value['checkout_label_web'];?>"  />
							
						<?
						}elseif($pmt_type=="upi"){ 
						 $sub_title="<img src='".$data['bankicon']['google-pay-svg']."' alt='google-pay'>&nbsp;<img src='".$data['bankicon']['phonepe-svg']."' alt='phonepe'>&nbsp;<img src='".$data['bankicon']['paytm-svg']."' alt='paytm'> & More"; ?>
							
								<img src="<?=@$data['bankicon']['upi-icon']?>" title="<?=@$value['checkout_label_web'];?>"  />
							
						<?
						}
						
						//echo $sub_title;
						?>
							
						</span>
						
<? if(acquirer_label_f(@$value['checkout_label_web'],@$value['checkout_label_mobile'],$value['acquirer_id'])){echo acquirer_label_f(@$value['checkout_label_web'],@$value['checkout_label_mobile'],$value['acquirer_id']); echo "<div class='heading2_ind'>".@$sub_title."</div>";}else{?>
                        
Pay with eWallets [ <?=(isset($_SESSION['curr_transaction_amount'])?$_SESSION['curr_transaction_amount']:'');?> ]
                        
<? } ?>
						
						
						</strong>
                        </label>
                      </div>
                      <? $acq_cnt ++; }  ?>
					  
					  <? } ?>
					  <?
					    // Check payment mode qr and single acquirer than redirect to Qr Pages
					    //echo $acq_cnt; echo $pmt_type;
					   if((isset($acq_cnt)&&$acq_cnt==1)&&(isset($pmt_type)&&$pmt_type=="qr")){
					   ?>
					   <!--<script>
					   
					   setTimeout(
						function() 
						{
						$(".account_types").trigger( "click" );
						}, 500);
                      </script>-->
					   <?
					   }
					  ?>
                    </div>
                  </div>
                  <? } ?>
			  
			  <? if(isset($post['nick_name_upi'])&&!empty($post['nick_name_upi'])){?>
			  <div class="cname upiCont">
				<div class="inputgroup">
				  <? foreach($_SESSION['AccountInfo'] as $key=>$value){if((@$value['acquirer_id']) &&  (strpos(@$_SESSION['b_'.$value['acquirer_id']]['channel_type'],'UPI') !== false) && (in_array(@$value['acquirer_id'],@$post['nick_name_upi_arr'])) && (@$value['account_login_url']!="3")){
						if(isset($_SESSION['curr'])&&$_SESSION['curr']){$pcrcy=$currency_smbl;}else{$pcrcy=$_SESSION['curr_tr_sys'];}

						if(isset($value['account_login_url'])&&$value['account_login_url']==1){
							
							$dataname="ewallets"; 
							$data_ccn=''; 
						}
						elseif(isset($value['account_login_url'])&&$value['account_login_url']==2){
							$dataname="evoilatecard"; 
							$data_ccn='data-ccn="visa"';
						}
					?>
				  <div class="inputype <?=(isset($data['t'][$value['acquirer_id']]['logo'])?"the_icon":"")?> <?=countryCodeMatch2($post['country_two'],(isset($_SESSION["b_".$value['acquirer_id']]['countries'])?$_SESSION["b_".$value['acquirer_id']]['countries']:''),(isset($_SESSION["b_".$value['acquirer_id']]['countryCode'])?$_SESSION["b_".$value['acquirer_id']]['countryCode']:''))?> border rounded p-2 my-1 w-100">
					<input type="radio" value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" id="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" required name="account_types" class="account_types" data-value="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" data-name="<?=(isset($dataname)?$dataname:'');?>" data-currency="<?=@$pcrcy;?>" data-submitmsg="intent_submitMsg" data-ewlist="<?=acquirer_popup_msg_f($value['acquirer_id'])?>" data-etype="3D" data-channel='<?=(isset($_SESSION["b_".$value['acquirer_id']]['channel_type'])?$_SESSION["b_".$value['acquirer_id']]['channel_type']:'');?>'   data-count='<?=(isset($_SESSION["b_".$value['acquirer_id']]['deCon'])?$_SESSION["b_".$value['acquirer_id']]['deCon']:'');?>' data-dnmc='<? if(isset($_SESSION["b_".$value['acquirer_id']]['block_countries'])) echo $_SESSION["b_".$value['acquirer_id']]['block_countries'];?>' style="display:none;" <?=(isset($data_ccn)?$data_ccn:'');?> />
					<label for="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>" class="pointer">
					
					<label for="<?=(isset($value['acquirer_id'])?$value['acquirer_id']:'');?>">
					<? if(isset($data['t'][$value['acquirer_id']]['logo'])){?>
					<div class="icon_the_pay"> <img src="<?=@$data['Host']?>/images/<?=@$data['t'][$value['acquirer_id']]['logo'];?>_logo.png"  /> </div>
					<? } ?>
					<? if(isset($value['checkout_level_name'])&&$value['checkout_level_name']){echo $value['checkout_level_name'];}else{?>
					Pay with eWallets [
					<?=@$_SESSION['curr_transaction_amount'];?>
					]
					<? } ?>
					</label>
				  </div>
				  <? }} ?>
				</div>
			  </div>
			  <? } ?>
			</div>
		  </div>
		</div>
		<? } ?>
		<div class="cardHolder" <? if(isset($c_style)) echo $c_style;?>>
		<table class="frame" width="100%" border="0" cellspacing="1" cellpadding="4">
		  <tr><td colspan="2" style="background:<?=@$_SESSION['background_gl7'];?>;margin:0;padding:0;position: relative;"><div class="checkOutOptions">
				
	<?
	if(isset($data['con_name'])&&$data['con_name']=='clk'){
		$post['step']=2;
		$common_input="
		<div style='display:none'>
		<input type='hidden' name='product' value='".@$post['product']."'>
		<input type='hidden' name='bill_amt' value='".@$post['bill_amt']."'>
		</div>";
	}
	if(!isset($post['bill_country_name'])) $post['bill_country_name'] = '';
	if(!isset($post['payment'])) $post['payment'] = '';
	if(!isset($post['bill_fees'])) $post['bill_fees'] = '';
	if(!isset($post['bussiness_url'])) $post['bussiness_url'] = '';
	if(!isset($post['aurl'])) $post['aurl'] = '';
	if(!isset($post['source'])) $post['source'] = '';
	if(!isset($post['status_mem'])) $post['status_mem'] = '';

	$common_input .="
	<div style=display:none>
	<input type='hidden' name='step' value='".@$post['step']."'>
	<input type='hidden' name='fullname' value='".@$post['fullname']."'>
	<input type='hidden' name='bill_email' value='".@$post['bill_email']."'>
	<input type='hidden' name='bill_address' value='".@$post['bill_address']."'>
	<input type='hidden' name='bill_city' value='".@$post['bill_city']."'>
	<input type='hidden' name='bill_state' value='".@$post['bill_state']."'>
	<input type='hidden' name='bill_country' value='".@$post['bill_country']."'>
	<input type='hidden' name='bill_country_name' id=bill_country_name value='".@$post['bill_country_name']."'>
	<input type='hidden' name='bill_zip' value='".@$post['bill_zip']."'>
	<input type='hidden' name='bill_phone' value='".@$post['bill_phone']."'>
	<input type='hidden' name='payment_mode' value='".@$post['payment']."'>
	<input type='hidden' name='bill_fees' value='".@$post['bill_fees']."'>
	<input type='hidden' name='bussiness_url' value='".@$post['bussiness_url']."'>
	<input type='hidden' name='status' value='".(@$post['status_mem']?@$post['status_mem']:@$post['status'])."'>
	<input type='hidden' name='aurl' value='".@$post['aurl']."'>
	<input type='hidden' name='source' value='".@$post['source']."'>
	<input type='hidden' name='actionajax' class='actionajax' value='".((isset($post['actionajax'])&&trim($post['actionajax']))?$post['actionajax']:'')."'>
	<input type='hidden' name='mop' class='mop_ajax_checkout' value='".((isset($post['mop'])&&trim($post['mop']))?$post['mop']:'')."'>
	</div>"; 
	
	if(isset($post['t_name6'])&&strpos($post['t_name6'],'ajaxBin') !== false){
		$common_input .="
		<div style='display:none'>
			<input type='hidden' name='payment_method' id='payment_method' value='".@$post['payment_method']."'>
		</div>"; 
	}
	
	if(isset($data['Error'])&&$data['Error']&&isset($post['submit'])){
		$display_style="style='display:block;'";
	}else {
		$display_style="style='display:none;'";
	}
	?>
	<? if((isset($post['acquirer_id_card'])&&!empty($post['acquirer_id_card'])) || ((@$post['acquirer_id']) && ($_SESSION['post']['ewallets_test_card']==true)  )){?>
				<div class="cover_pay_div" style="position:relative;">
				  <div class="ecard_div evoilatecard_div pay_div p-2">
					<form id="payment_form_id" method="post"  onsubmit="return validateForm(this);" target="payin_win" >
					  <div style="display:none">
						<?=@$common_input;?>
						<input type="hidden" name="acquirer" value=''>
						<input type="hidden" name="cardtype" id="cardtype" value="<?=(isset($post['cardtype'])?$post['cardtype']:'')?>">
					  </div>
					  <div class="credit-card-box label_active rounded pb-1">
                      <div class="flip">
                        <div class="front">
                         
							
                          <!--<div class="number">-->
                            
                            <div class="form-group my-4 " id="card-number-field">
							
<div class="input-field inputWithIcon">
<i id="input-card-icon" class="<?=@$data['fwicon']['credit-card'];?> display-inner"></i>
					<input type="tel" name="ccno" value="<?=(isset($post['ccno'])&&$post['ccno'])?$post['ccno']:"";?>" id="number" class="iconvisa form-control text-muted " pattern=".{16,21}" required  >
                    <label for="number">Card Number</label>
                  </div>
							</div>
							
                          <div class="clearfix my-2">
						  
						    <div class="float-start input-field" style="width:80px;">
							
                           <select id="expMonth" name="month" class="form-select text-muted" required title="Select Month of Card Expiry" >
								<option value="" disabled="disabled" selected="selected">&nbsp;&nbsp;</option>
								<option value="01" title="Jan.">01</option>
								<option value="02" title="Feb.">02</option>
								<option value="03" title="Mar.">03</option>
								<option value="04" title="Apr.">04</option>
								<option value="05" title="May.">05</option>
								<option value="06" title="Jun.">06</option>
								<option value="07" title="Jul.">07</option>
								<option value="08" title="Aug.">08</option>
								<option value="09" title="Sept.">09</option>
								<option value="10" title="Oct.">10</option>
								<option value="11" title="Nov.">11</option>
								<option value="12" title="Dec.">12</option>
                            </select>
							<label for="expMonth">MM</label>
							<?
							if(isset($post['month'])&&$post['month'])
							{?>
							<script>
							$('#expMonth option[value="<?=@$post['month']?>"]').prop('selected','selected');
							</script>
							<?
							}
							?>
							</div>
							<div class="float-start input-field mx-2" style="width:80px;">
							
                            <select id="expYear" name="year" class="form-select text-muted" required title="Select Year of Card Expiry">
                          <option value="" disabled="disabled"  selected="selected" >&nbsp;&nbsp;</option>
							<?
							for($yy = date('y');$yy<100;$yy++)
							{
							?><option value="<?=@$yy?>"><?=@$yy?></option><? } ?>
                            </select>
							<label for="expYear">YY</label>
							<?
							if(isset($post['year'])&&$post['year'])
							{?>
							<script>
							$('#expYear option[value="<?=@$post['year']?>"]').prop('selected','selected');
							</script>
							<?
							}?>
							
							</div>


                            <div class="CVV input-field " style="width:70px;float: right;">
							
                              <input id="cvc" type="password" name="ccvv" maxlength="4"   value="<?=(isset($post['ccvv'])&&$post['ccvv'])?$post['ccvv']:"";?>"  class="form-control text-muted" required  title="It's a 3 digit code printed on the back of your card." >
                            <label for="cvc">CVV</label>
							</div>
                          </div>
                        </div>
                      </div>
                    </div>
					  
					
					<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'cardEMI') !== false){ ?>
					
					<div class="cardEMI_div ewalist hide">
						<div class="ecol2" style="width: 96%;padding: 0;margin: 0 0 0 10px;">
							<input type="text" name="card_bank_name" class="w94" placeholder="Bank Name" style="margin: 5px 0;" value="<? if(isset($post['card_bank_name'])) echo prntext(@$post['card_bank_name']);?>">
							
						<select class="w94 wDropDown dropDwn required" name="emi_tenure" id="emi_tenure" style="margin:5px 0;">
								<option value="">--Select Tenure--</option>
								<option value="3">3</option>
								<option value="6">6</option>
								<option value="9">9</option>
								<option value="12">12</option>
								<option value="18">18</option>
								<option value="24">24</option>
							</select>
						</div>
					</div>
					<?
					} ?>
					<div class="hide error" id="form-input-errors" <?=@$display_style;?>><?=prntext(@$data['Error'])?></div>
					  
					  <div class="submit_div text-muted m-button clearfix my-4">
					  
						<div class="float-start text-center w-50"><div class="w-100 fw-bold" style="font-size:13px;"><?=@$currency_smbl;?> <?=(@$post['total']?$post['total']:$post['bill_amt'])?></div><div class="account-pop pointer text-link" style="font-size:10px;" title="View Payment Details">View Details</div> </div><button id="cardsend_submit" type="submit" name="send123" value="Change Now"  class="submitbtn btn btn-slide w-50 float-end next"><b class="contitxt">Complete Payment</b></button>
					<? 
					if(isset($_SESSION['action'])&&($_SESSION['action']=="vt" || $_SESSION['action']=="requestmoney")){
						/*
						?>
					<style>
						.submitbck, .submitbtn {width:100% !important;margin:5px 0 !important;}
					</style>
					<button type=button value="BACK" onClick="javascript:goback();" class="submitbck back_button btn btn-primary  left_arrow next"><i></i><b class="contitxt">Back to Merchant Store</b></button>
					<?
					*/
					} else {?>
						<style> 
						#cardsend_submit{/*width:96%;margin: 0 auto;float: none;*/}
						</style>
					<? } ?>
						<script language="javascript" type="text/javascript"> 
							function goback(){	
							// Simulate a mouse click:
							window.location.href = "<?=@$data['Host'];?>/processall<?=@$data['ex']?>?action=vt";
							}
						</script>
					  </div>
					</form>
				  </div>
				  <? } ?>
				  
				  
				  <? if(isset($post['acquirer_id_ewallets'])&&(!empty($post['acquirer_id_ewallets']))||(isset($post['acquirer_id_net_banking'])&&!empty($post['acquirer_id_net_banking']))||(isset($post['acquirer_id_upi'])&&!empty($post['acquirer_id_upi']))){?>
				  <div class="ewallets_div pay_div">
					<form id="payment_form_id_ewallets" name="payment_form_id_ewallets" method="post" onSubmit="return validateForm(this);" target="payin_win">
					  <div class="ecol2" style="width:100%">
						<div style="display:none">
						  <?=@$common_input;?>
						  <input type="hidden" name="acquirer" value="14">
						</div>
						
<div class="text-center m-2">
<? //start walletlist list----  ?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'walletLogo') !== false){?>
<div class="walletLogo_div ewalist hide">
  <div class="row unset">
    <div class="col-sm-6 desImg 4002 mobikwik">
      <div class="text-center border p-2 me-1 mb-2 rounded"><img src="<?=@$data['bankicon']['mobikwik']?>" alt="Mobikwik" title="Mobikwik" class="wallet_img"></div>
      <span class="wallets txNm hide">MobiKwik</span></div>
    <div class="col-sm-6 desImg 4001 FREC">
      <div class="text-center border p-2 ms-1 mb-2 rounded"><img src="<?=@$data['bankicon']['freecharge']?>" alt="FreeCharge" title="FreeCharge" class="wallet_img" ></div>
      <span class="wallets txNm hide">FreeCharge</span> </div>
    <div class="col-sm-6 desImg 4004 JIOM">
      <div class="text-center border p-2 me-1 mb-2 rounded"><img src="<?=@$data['bankicon']['jiomoney']?>" alt="JioMoney" title="JioMoney" class="wallet_img"></div>
      <span class="wallets txNm hide">JioMoney</span> </div>
    <div class="col-sm-6 desImg 4003 OLAM">
      <div class="text-center border p-2 ms-1 mb-2 rounded"><img src="<?=@$data['bankicon']['olamoney']?>" alt="OlaMoney" title="OlaMoney" class="wallet_img"></div>
      <span class="wallets txNm hide">OlaMoney</span> </div>
    <div class="col-sm-6 desImg 4008">
      <div class="text-center border p-2 me-1 rounded"><img src="<?=@$data['bankicon']['amazonpay']?>" alt="AmazonPay" title="AmazonPay" class="wallet_img"></div>
      <span class="wallets txNm hide">AmazonPay</span> </div>
    <div class="col-sm-6 desImg 4009 PHONEPE">
      <div class="text-center border p-2 ms-1 rounded"><img src="<?=@$data['bankicon']['phonepe']?>" alt="PhonePe" title="PhonePe" class="wallet_img"></div>
      <span class="wallets txNm hide">PhonePe</span> </div>
  </div>
</div>

<? } ?>

<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'payUwalletList') !== false){?>
						<div class="payUwalletList_div ewalist hide">
							<select class="w94 wDropDown dropDwn required form-select from-select-sm" name="wallet_code" id="wallet_code" style="margin:5px 0;">
								<?php /*?><option value="AMZPAY">AmazonPay</option><?php */?>
								<option value="FREC">FreeCharge</option>
								<option value="PAYTM">PayTM</option>
								
								<option value="JIOM">JioMoney</option>
								<option value="AMON">Airtel Money</option>
								<option value="OXYCASH">Oxigen</option>
								<option value="ITZC">ItzCash</option>
								<option value="PAYZ">HDFC PayZapp</option>
								<option value="OLAM">OlaMoney</option>
								<option value="YESW">Yes Bank</option>
								<option value="PHONEPE">PhonePe</option>
								<option value="mobikwik">MobiKwik</option>
								</select>
						</div>
						<? }?>
						
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'walletList') !== false){?>
						  <div class="walletList_div ewalist hide ">
						  <div class="row mt-2">
						    <div class="col-sm-12 input-field select">
							<select class="wDropDown dropDwn required form-select" name="wallet_code" id="wallet_code"  >
							  <option value="4006">AirtelMoney</option>
							  <option value="4008">AmazonPay</option>
							  <option value="4001">FreeCharge</option>
							  <option value="4002">MobiKwik</option>
							  <option value="4003">OlaMoney</option>
							  <option value="4007">Paytm</option>
							  <option value="4009">PhonePe</option>
							  <option value="4004">JioMoney</option>
							</select>
							<label for="wallet_code">Select a different wallet</label>
						    </div>
						    <?php /*?><div class="col-sm-6">
							<input class="form-control" type="text" name="wallet_code_text" style="display:none;" />
							<input class="form-control" type="text" name="wallet_address" placeholder="mobile@upi" />
							</div><?php */?>
						  </div>
						  </div>
						  <? } ?>
				
<? ######## Fetch Transactions - Start ########?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'ift') !== false){?>
						<div class="ift_div ewalist hide">
							<div class="row mt-2">
								<div class="col-sm-12 input-field was-validated">
									<?php /*?><div class="input-field my-3">
										<input placeholder="Beneficiary Name" type="text" name="ben_name" value="" id="ben_name" minlength="3" class="form-control is-invalid"  autocomplete="off">
				            	        <label for="ben_name">Beneficiary Name</label>
										<script> if(($('#ben_name').val())!=""){ $("#ben_name").removeClass('is-invalid').addClass('is-valid'); } </script>
									</div>

									<div class="input-field my-3">
										<input placeholder="Account Number" type="text" name="acc_number" value="" id="acc_number" minlength="2"  maxlength="12" class="form-control is-invalid"  autocomplete="off">
										<label for="acc_number">Account Number</label>
										<script> if(($('#acc_number').val())!=""){ $("#acc_number").removeClass('is-invalid').addClass('is-valid'); } </script>
									</div>

									<div class="input-field my-3">
										<input placeholder="IFSC Code" type="text" name="ifsc_code" value="" id="ifsc_code" minlength="11"  maxlength="11" class="form-control is-invalid"  autocomplete="off">
										<label for="ifsc_code">IFSC Code</label>
										<script> if(($('#ifsc_code').val())!=""){ $("#ifsc_code").removeClass('is-invalid').addClass('is-valid'); } </script>
									</div><?php */?>
								</div>
							</div>
						</div>
					<? } ?>						
<? ######## Fetch Transactions - END ########?>
				

						
						
						
						
<div class="text-center my-2">

						  
<? if(!isMobileBrowser()) { ?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcodeadd') !== false){?>
<?php /*?><!--<div class="qrcodeadd_div ewalist hide appLogoDiv desImg qrcode" onclick="checkupi('qrcode')"><img src="<?=@$data['Host']?>/images/qr-code-logo.png" alt="QRcode" title="QRCode" style="display:block;width: 100%;"><span class="wallets txNm hide">QRcode</span>--><?php */?>


<div class="qrcodeadd_div ewalist hide">
  <div class="text-start mb-2">PAY WITH UPI QR <!--<span class="text-end" onclick="toggle_f('#qr_toggle')"><i class="<?=@$data['fwicon']['qrcode'];?> p-2"></i></span>--></div>
  <div class="row border p-2 mb-2 rounded row upi_qr_row" id="qr_toggle" ><!--style="display:none;"-->
    <div class="col-sm-6 upi_qr_border" style="overflow:hidden;">
      <div class="px-2 my-3">
        <?php /*?><div class="btn btn-primary qr_show" style="position: absolute;z-index: 1;margin-top: 45px;margin-left: 20px;">Show QR</div><?php */?>
        <img src="<?=@$data['bankicon']['qr-button'];?>" title="QR" class="upi_qr_img"/> </div>
    </div>
    <div class="col-sm-6 upi_qr ps-2">
      <div class="px-1 upi_qr_text" style="font-size:10px !important;">Scan the QR using any UPI app on your phone.</div>
      <div class="my-2"> <img src='<?=@$data['bankicon']['google-pay-svg']?>' alt='google-pay'>&nbsp;<img src='<?=@$data['bankicon']['phonepe-svg']?>' alt='phone-pe'>&nbsp;<img src='<?=@$data['bankicon']['paytm-svg']?>' alt='paytm'>&nbsp;<img src='<?=@$data['bankicon']['bhim-svg']?>' alt='bhim'> </div>
	  
<div class="qrTransID text-success-emphasis my-1" style="font-size:12px !important;"><? if(isset($_SESSION['bearer_token_id']) && $_SESSION['bearer_token_id'] ) { ?> 
	  <div class="text-muted fw-bold mx-2 fs10">Bearer Token :  <? echo $_SESSION['bearer_token_id']?> </div><? } ?></div>
<div class="text-secondary-emphasis my-1 QR_Code_is_valid hide" style="font-size:10px !important;">QR Code is valid for <span class="timer text-danger fw-bold">05:00</span> minutes</div>
<a id="paid_qrcode_link" class="paid_qrcode_link btn btn-outline-success btn-sm mx-2 hide button_refresh fw-bold" style="font-size:10px !important;"><b class="contitxt1 ">I have paid</b></a>


    </div>
  </div>
   <div class="border p-2 mb-2 rounded bg-body-secondary upi_qr_row_msg hide"></div>
</div>
<? }
 }  ?>
 
 
<? 
// Added new section for UPI INTENT - DIRECT (When user select particular app then direct re-direct to on that APP) 
if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiAppListForIntent') !== false){?>
	<div class="upiAppListForIntent_div ewalist hide">
	
	<div class="row border py-1 px-2 mb-2 rounded intent_push" style="cursor:pointer;">
		<div class='col-1 text-start img30'>
			<img class="mt-2" src="<?=@$data['bankicon']['bhim-svg']?>"  />
		</div>
		<div class='col ps-2 text-start img20'>
			<div class="">SELECT UPI APP </div>
			<?=@$sub_icon_more?>
		</div>
	</div>

		
	<div class="row unset intent_select_app" style="position:relative">
	 
		<div class="row blur_layer hide" style="">
		
		</div>
		
		<div class="row unset">
			
		  <?
			if(!isMobileBrowser())
			{?>
		  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcode_wl') !== false){?>
		  <div class="qrcode_wl_div ewalist hide walletsDiv desImg qrcode" onclick="checkupiapp('qrcode')"><img src="<?=@$data['Host']?>/images/qr-code-logo.png" alt="QRcode" title="QRCode" style="display:block;width: 100%;"><span class="wallets txNm hide">QRcode</span></div>
		  <?
				}
			}?>
			
		  <div class="walletsDiv desImg paytm" onclick="checkupiapp('paytm')"><img src="<?=@$data['Host']?>/images/paytm_logo.png" alt="PayTm" title="PayTm" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">PayTm</span></div>
		  
		  <div class="walletsDiv desImg phonepe" onclick="checkupiapp('phonepe')"><img src="<?=@$data['Host']?>/images/phonepe.png" alt="PhonePe" title="PhonePe" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">PhonePe</span></div>
		  
		  <div class="walletsDiv desImg google" onclick="checkupiapp('google')"><img src="<?=@$data['Host']?>/images/google_pay.png" alt="Google Pay" title="Google Pay" style="display:block;width: 100%;height:50px "><span class="wallets txNm hide">Google Pay</span></div>
		  
		  <div class="walletsDiv desImg bhim" onclick="checkupiapp('bhim')"><img src="<?=@$data['Host']?>/images/bhim.png" alt="bhim" title="Bhim" style="display:block;width: 100%;"><span class="wallets txNm hide">Bhim</span></div>
		  
		  <div class="walletsDiv desImg whatsapp" onclick="checkupiapp('whatsapp')"><img src="<?=@$data['Host']?>/images/whatsapp-pay.png" alt="Whatsapp Pay" title="Whatsapp Pay" style="display:block;width: 100%;height:50px"><span class="wallets txNm hide">WhatsApp</span></div>
		  
		  <div class="walletsDiv desImg amazon" onclick="checkupiapp('amazon')"><img src="<?=@$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">AmazonPay</span></div>
		  
		  
		  <?/*?>
			  <div class="walletsDiv desImg freecharge" onclick="checkupiapp('freecharge')"><img src="<?=@$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;"><span class="wallets txNm hide">Freecharge</span></div>
			  <div class="walletsDiv desImg jio" onclick="checkupiapp('jio')"><img src="<?=@$data['Host']?>/images/jiomoney-logo-new.png" alt="JioMoney" title="JioMoney" style="display:block;width: 100%;"><span class="wallets txNm hide">JioMoney</span></div>
			  <div class="walletsDiv desImg ola" onclick="checkupiapp('ola')"><img src="<?=@$data['Host']?>/images/olamoney-logo-pp.png" alt="OlaMoney" title="OlaMoney" style="display:block;width: 100%;"><span class="wallets txNm hide">OlaMoney</span></div>
			  
			  
			  <div class="walletsDiv desImg airtel" onclick="checkupiapp('airtel')"><img src="<?=@$data['Host']?>/images/airtel_payments_bank_logo.png" alt="Airtel" title="Airtel" style="display:block;margin:12px auto !important;max-height:40%;"><span class="wallets txNm hide">Airtel</span></div>
			  <?*/?>
			  
			  
		<?if(fetchDeviceName()!='ios')
		  {?>
			  <div class="walletsDiv desImg mobikwik" onclick="checkupiapp('mobikwik')"><img src="<?=@$data['Host']?>/images/mobikwik-logo-new.png" alt="Mobikwik" title="Mobikwik" style="display:block;width: 100%;"><span class="wallets txNm hide">MobiKwik</span></div>
			  
			  <div class="walletsDiv desImg other" onclick="checkupiapp('other')"><img src="<?=@$data['Host']?>/images/other_logo.png" alt="Other" title="Other" style="display:block;width:95%;margin:3px auto; height: 57px;width:100px;"><span class="wallets txNm hide">Other</span></div>
		  
		<?}?>
		
		</div>
	
		
			<div class="row unset">
			  <select class="w94 wDropDown dropDwn wallet_code_app form-select form-select-sm" name="wallet_code_app" id="wallet_code_app" style="margin:5px 0;" onChange="checkupiapp(this.value)" >
				<option value="" selected="selected">Choose</option>
				<option value="paytm">PayTm</option>
				<option value="phonepe">PhonePe</option>
				<option value="gpay">Google Pay</option>
				<option value="bhim">Bhim</option>
				<option value="whatsapp">WhatsApp</option>
				<option value="amazon">AmazonPay</option>
				
				<?/*?>
				<option value="ola">OlaMoney</option>
				<option value="airtel">Airtel</option>
				<option value="freecharge">Freecharge</option>
				<option value="jio">JioMoney</option>
				<?*/?>
				
				<?if(fetchDeviceName()!='ios')
			  {?>
				<option value="mobikwik">MobiKwik</option>
				<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcodOption') !== false){?>
				<option value="qrcode" class="qrcodOption_div ewalist hide">QRcode</option>
				<? } ?>
				<option value="other">Other</option>
				<? } ?>
			  </select>
			  <input type="text" class="w94 required" id="bill_phone" name="bill_phone" style="margin:5px 0;display:none;" placeholder="mobile" value="<?=isMobileValid($post['bill_phone'])?>" />
			  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcodOption') !== false){?>
			  <input type="text" class="qrcodOption_div ewalist hide w94" id="upi_address" name="upi_address" style="margin:5px 0;display:none;" placeholder="Enter UPI Address" value="" />
			  <? } ?>
			</div>
		</div>
		<div class="row intent_div_submit"> </div>
	</div>
	
<? } ?>

<? 
// Added new section for at time All UPI INTENT - DIRECT (When user select particular app then direct re-direct to on that APP) 
if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiAppListForIntentArray') !== false){?>
	<div class="upiAppListForIntentArray_div ewalist hide">
	
	<div class="row border py-1 px-2 mb-2 rounded intent_push" style="cursor:pointer;">
		<div class='col-1 text-start img30'>
			<img class="mt-2" src="<?=@$data['bankicon']['bhim-svg']?>"  />
		</div>
		<div class='col ps-2 text-start img20'>
			<div class="">SELECT UPI APP </div>
			<?=@$sub_icon_more?>
		</div>
	</div>

		
	<div class="row unset intent_select_app" style="position:relative">
	 
		<div class="row blur_layer" style="">
		
		</div>
		
		<div class="row unset">
			
		  <?
			if(!isMobileBrowser())
			{?>
		  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcode_wl') !== false){?>
		  <div class="qrcode_wl_div ewalist hide walletsDiv desImg qrcode" onclick="checkIntentUrl('qrcode')"><img src="<?=@$data['Host']?>/images/qr-code-logo.png" alt="QRcode" title="QRCode" style="display:block;width: 100%;"><span class="wallets txNm hide">QRcode</span></div>
		  <?
				}
			}?>
			
		  <a class="walletsDiv desImg paytm url_inte" href="" target="_blank" onclick="checkIntentUrl('paytm')"><img src="<?=@$data['Host']?>/images/paytm_logo.png" alt="PayTm" title="PayTm" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">PayTm</span></a>
		  
		  <a class="walletsDiv desImg phonepe url_inte" href="" target="_blank" onclick="checkIntentUrl('phonepe')"><img src="<?=@$data['Host']?>/images/phonepe.png" alt="PhonePe" title="PhonePe" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">PhonePe</span></a>
		  
		  <a class="walletsDiv desImg google url_inte" href="" target="_blank" onclick="checkIntentUrl('google')"><img src="<?=@$data['Host']?>/images/google_pay.png" alt="Google Pay" title="Google Pay" style="display:block;width: 100%;height:50px "><span class="wallets txNm hide">Google Pay</span></a>
		  
		  <a class="walletsDiv desImg bhim url_inte" href="" target="_blank" onclick="checkIntentUrl('bhim')"><img src="<?=@$data['Host']?>/images/bhim.png" alt="bhim" title="Bhim" style="display:block;width: 100%;"><span class="wallets txNm hide">Bhim</span></a>
		  
		  <a class="walletsDiv desImg whatsapp url_inte" href="" target="_blank" onclick="checkIntentUrl('whatsapp')"><img src="<?=@$data['Host']?>/images/whatsapp-pay.png" alt="Whatsapp Pay" title="Whatsapp Pay" style="display:block;width: 100%;height:50px"><span class="wallets txNm hide">WhatsApp</span></a>
		  
		  <a class="walletsDiv desImg amazon url_inte" href="" target="_blank" onclick="checkIntentUrl('amazon')"><img src="<?=@$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">AmazonPay</span></a>
		  
		  
		  <?/*?>
			  <div class="walletsDiv desImg freecharge" onclick="checkIntentUrl('freecharge')"><img src="<?=@$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;"><span class="wallets txNm hide">Freecharge</span></div>
			  <div class="walletsDiv desImg jio" onclick="checkIntentUrl('jio')"><img src="<?=@$data['Host']?>/images/jiomoney-logo-new.png" alt="JioMoney" title="JioMoney" style="display:block;width: 100%;"><span class="wallets txNm hide">JioMoney</span></div>
			  <div class="walletsDiv desImg ola" onclick="checkIntentUrl('ola')"><img src="<?=@$data['Host']?>/images/olamoney-logo-pp.png" alt="OlaMoney" title="OlaMoney" style="display:block;width: 100%;"><span class="wallets txNm hide">OlaMoney</span></div>
			  
			  
			  <div class="walletsDiv desImg airtel" onclick="checkIntentUrl('airtel')"><img src="<?=@$data['Host']?>/images/airtel_payments_bank_logo.png" alt="Airtel" title="Airtel" style="display:block;margin:12px auto !important;max-height:40%;"><span class="wallets txNm hide">Airtel</span></div>
			  <?*/?>
			  
			  
		<?if(fetchDeviceName()!='ios')
		  {?>
			  <a class="walletsDiv desImg mobikwik url_inte" href="" target="_blank" onclick="checkIntentUrl('mobikwik')"><img src="<?=@$data['Host']?>/images/mobikwik-logo-new.png" alt="Mobikwik" title="Mobikwik" style="display:block;width: 100%;"><span class="wallets txNm hide">MobiKwik</span></a>
			  
			  <a class="walletsDiv desImg other url_inte" href="" target="_blank" onclick="checkIntentUrl('other')"><img src="<?=@$data['Host']?>/images/other_logo.png" alt="Other" title="Other" style="display:block;width:95%;margin:3px auto; height: 57px;width:100px;"><span class="wallets txNm hide">Other</span></a>
		  
		<?}?>
		
		</div>
	
		
			<div class="row unset">
			  <select class="w94 wDropDown dropDwn wallet_code_app form-select form-select-sm hide" name="wallet_code_app" id="wallet_code_app" style="margin:5px 0;" onChange="checkIntentUrl(this.value)" >
				<option value="" selected="selected">Choose</option>
				<option value="paytm">PayTm</option>
				<option value="phonepe">PhonePe</option>
				<option value="gpay">Google Pay</option>
				<option value="bhim">Bhim</option>
				<option value="whatsapp">WhatsApp</option>
				<option value="amazon">AmazonPay</option>
				
				<?/*?>
				<option value="ola">OlaMoney</option>
				<option value="airtel">Airtel</option>
				<option value="freecharge">Freecharge</option>
				<option value="jio">JioMoney</option>
				<?*/?>
				
				<?if(fetchDeviceName()!='ios')
			  {?>
				<option value="mobikwik">MobiKwik</option>
				<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcodOption') !== false){?>
				<option value="qrcode" class="qrcodOption_div ewalist hide">QRcode</option>
				<? } ?>
				<option value="other">Other</option>
				<? } ?>
			  </select>
			 
			</div>
		</div>
		
	</div>
	
<? } ?>

<!--// UPI values fetch from google play store - 
// eg. https://play.google.com/store/apps/details?id=com.phonepe.app-->
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiIntentInputList') !== false){?>
							<div class="upiIntentInputList_div ewalist hide">
							<div class="clearfix"></div>
							<div  class="input-field select mt-3">
								<select class="w94 wDropDown dropDwn required form-select form-select-lg" name="upi_code_intent" id="upi_code_intent" style="margin:5px 0;">
								<option value="com.myairtelapp">AirtelMoney</option>
								<option value="in.amazon.mShop.android.shopping">AmazonPay</option>
								<option value="com.freecharge.android">FreeCharge</option>
								<option value="com.mobikwik_new">MobiKwik</option>
								<option value="com.olacabs.olamoney">OlaMoney</option>
								<option value="net.one97.paytm">Paytm</option>
								<option value="com.phonepe.app">PhonePe</option>
								<option value="com.jio.myjio">JioMoney</option>
								<option value="com.google.android.apps.nbu.paisa.user">Google Pay</option>
								</select>
								<label for="upi_code_intent">Select a different</label>
								</div>
							</div>
							<? } ?>
</div>
						
						
<div class="text-center my-2">
						

	<?	//sabpaisa - wallet - start?>
	<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiWalletIndiaList') !== false){?>
		<div class="upiWalletIndiaList_div ewalist hide">
		  <div class="row unset">
			<div class="row unset">
			  <div class="col-sm-6 desImg 4007">
				<div class="text-center border p-2 me-1 mb-2 rounded"><img src="<?=@$data['bankicon']['paytm']?>" alt="Paytm" title="Paytm" class="wallet_img"></div>
				<span class="wallets txNm hide">Paytm</span></div>
			  <div class="col-sm-6 desImg 4002">
				<div class="text-center border p-2 me-1 mb-2 rounded"><img src="<?=@$data['bankicon']['mobikwik']?>" alt="Mobikwik" title="Mobikwik" class="wallet_img"></div>
				<span class="wallets txNm hide">MobiKwik</span></div>
			  <div class="col-sm-6 desImg 4001">
				<div class="text-center border p-2 ms-1 mb-2 rounded"><img src="<?=@$data['bankicon']['freecharge']?>" alt="FreeCharge" title="FreeCharge" class="wallet_img" ></div>
				<span class="wallets txNm hide">FreeCharge</span> </div>
			  <div class="col-sm-6 desImg 4004">
				<div class="text-center border p-2 me-1 mb-2 rounded"><img src="<?=@$data['bankicon']['jiomoney']?>" alt="JioMoney" title="JioMoney" class="wallet_img"></div>
				<span class="wallets txNm hide">JioMoney</span> </div>
			  <div class="col-sm-6 desImg 4003">
				<div class="text-center border p-2 ms-1 mb-2 rounded"><img src="<?=@$data['bankicon']['olamoney']?>" alt="OlaMoney" title="OlaMoney" class="wallet_img"></div>
				<span class="wallets txNm hide">OlaMoney</span> </div>
			   <div class="col-sm-6 desImg 4006">
				<div class="text-center border p-2 ms-1 mb-2 rounded"><img src="<?=@$data['bankicon']['airtel']?>" alt="AirtelMoney" title="AirtelMoney" class="wallet_img"></div>
				<span class="wallets txNm hide">AirtelMoney</span> </div>
			  <?/*?>
			  <div class="col-sm-6 desImg 4008">
				<div class="text-center border p-2 me-1 rounded"><img src="<?=@$data['bankicon']['amazonpay']?>" alt="AmazonPay" title="AmazonPay" class="wallet_img"></div>
				<span class="wallets txNm hide">AmazonPay</span> </div>
			  <div class="col-sm-6 desImg 4009">
				<div class="text-center border p-2 ms-1 rounded"><img src="<?=@$data['bankicon']['phonepe']?>" alt="PhonePe" title="PhonePe" class="wallet_img"></div>
				<span class="wallets txNm hide">PhonePe</span> </div>
			  <?*/?>
			</div>
		  </div>
			<div class="row mt-2">
			  <div class="col-sm-12 input-field select">
				<select class="wDropDown dropDwn required form-select" name="wallet_code" id="wallet_code"  >
				  <option value="4007">Paytm</option>
				  <option value="4002">MobiKwik</option>
				  <option value="4001">FreeCharge</option>
				  <option value="4004">JioMoney</option>
				  <option value="4003">OlaMoney</option>
				  <option value="4006">AirtelMoney</option>
				  
				  <option value="4008">AmazonPay</option>
				  <option value="4009">PhonePe</option>
				  
				</select>
				<label for="wallet_code">Select a different wallet</label>
			  </div>
			</div>
		</div>
	<? }?>
</div>
						
<div class="text-center my-2">

<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiAppListForCollect') !== false){?>
						<div class="upiAppListForCollect_div ewalist hide">


<div class="text-start mb-2 is_not_channel hide">
	PAY USING UPI ID
</div>	



<div class="row is_channel hide or_1 text-center w-100" style="margin-bottom:22px;">
	<b> OR </b>
</div>
	
<div class="row is_channel is_9 hide">
	<div class="row border py-1 px-2 mb-2 rounded" >
		<div class='col-1 text-start img30'>
			<img class="mt-2" src="<?=@$data['bankicon']['bhim-svg']?>"  />
		</div>
		<div class='col ps-2 text-start img20'>
			<div class="">PAY USING UPI ID </div>
			<?=@$sub_icon_more?>
		</div>
	</div>
</div>
	
<div class="row unset payment_option border p-2 rounded">

<div class="appLogoDiv desImg paytm col-sm-12  px-2 py-1 border my-1 rounded" onclick="checkupi('paytm')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="paytm" id="paytm_radio"></div>
<span class="wallets txNm float-start">Paytm</span>
<img src="<?=@$data['bankicon']['paytm']?>" alt="PayTm" title="PayTm"  class="float-end">
</div>
<div id="paytm_display" class="blank_display"></div>

<div class="appLogoDiv desImg phonepe col-sm-12  px-2 py-1 border my-1 rounded" onclick="checkupi('phonepe')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="phonepe" id="phonepe_radio"></div>
<span class="wallets txNm float-start">Phonepe</span>
<img src="<?=@$data['bankicon']['phonepe']?>" alt="PhonePe" title="PhonePe"  class="float-end">
</div>
<div id="phonepe_display" class="blank_display"></div>

<div class="appLogoDiv desImg google  col-sm-12  px-2 py-1 border my-1 rounded" onclick="checkupi('google')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="gpay" id="google_radio"></div>
<span class="wallets txNm float-start">Google pay</span>
<img src="<?=@$data['bankicon']['googlepay']?>" alt="Google Pay" title="Google Pay"  class="float-end">
</div>
<div id="google_display" class="blank_display"></div>

<div class="appLogoDiv desImg amazon col-sm-12  px-2 py-1 border my-1 rounded" onclick="checkupi('amazon')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="amazon" id="amazon_radio"></div>
<span class="wallets txNm float-start">Amazon pay</span>
<img src="<?=@$data['bankicon']['amazonpay']?>" alt="AmazonPay" title="AmazonPay"  class="float-end">
</div>
<div id="amazon_display" class="blank_display"></div>
						
<div class="appLogoDiv desImg bhim col-sm-12  px-2 py-1 border my-1 rounded" onclick="checkupi('bhim')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="bhim" id="bhim_radio"></div>
<span class="wallets txNm float-start">Bhim UPI</span>
<img src="<?=@$data['bankicon']['bhim']?>" alt="bhim" title="Bhim" class="float-end">
</div>
<div id="bhim_display" class="blank_display"></div>

<div class="appLogoDiv desImg jio  col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('jio')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="jio" id="jio_radio"></div>
<span class="wallets txNm float-start">Jio Money</span>
<img src="<?=@$data['bankicon']['jiomoney']?>" alt="JioMoney" title="JioMoney"  class="float-end">
</div>
<div id="jio_display" class="blank_display"></div>

<div class="appLogoDiv desImg airtel col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('airtel')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="airtel" id="airtel_radio"></div>
<span class="wallets txNm float-start">Airtel Money</span>
<img src="<?=@$data['bankicon']['airtel']?>" alt="Airtel" title="Airtel"  class="float-end">
</div>
<div id="airtel_display" class="blank_display"></div>

<div class="appLogoDiv desImg ola col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('ola')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="ola" id="ola_radio"></div>
<span class="wallets txNm float-start">Ola Money</span>
<img src="<?=@$data['bankicon']['olamoney']?>" alt="OlaMoney" title="OlaMoney"  class="float-end">
</div>
<div id="ola_display" class="blank_display"></div>

<div class="appLogoDiv desImg mobikwik  col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('mobikwik')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="mobikwik" id="mobikwik_radio"></div>
<span class="wallets txNm float-start">MobiKwik</span>
<img src="<?=@$data['bankicon']['mobikwik']?>" alt="Mobikwik" title="Mobikwik"  class="float-end">
</div>
<div id="mobikwik_display" class="blank_display"></div>

<div class="appLogoDiv desImg freecharge  col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('freecharge')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="freecharge" id="freecharge_radio"></div>
<span class="wallets txNm float-start">Freecharge</span>
<img src="<?=@$data['bankicon']['freecharge']?>" alt="FreeCharge" title="FreeCharge"  class="float-end">
</div>

<div id="freecharge_display" class="blank_display"></div>


<div class="appLogoDiv desImg whatsapp  col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('whatsapp')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="whatsapp" id="whatsapp_radio"></div>
<span class="wallets txNm float-start">WhatsApp Pay</span>
<img src="<?=@$data['bankicon']['whatsapp']?>" alt="Whatsapp Pay" title="Whatsapp Pay" class="float-end">
</div>
<div id="whatsapp_display" class="blank_display"></div>

<div class="appLogoDiv desImg other col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('other')">
<div class="form-check float-start"><input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="other" id="other_radio"></div>
<span class="wallets txNm float-start">Enter UPI Address</span>
<img src="<?=@$data['bankicon']['upi_address']?>" alt="Other" title="Other" class="float-end">
</div>


<div id="other_display" class="blank_display"></div>

<div class="col-sm-12 text-end pointer text-link view_all_upi px-2" style="font-size:12px;" title="view all upi provider">View All</div>
							
						    </div>
						  </div>
						  <? } ?>



<?php /*?>new qr code -- start <?php */?>
				
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrAddress') !== false){?>
				<div class="qrAddress_div ewalist hide">
				<? if(!isMobileBrowser()){ ?>
				<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcodeadd') !== false){?>
				<div class="text-start fw-bold px-2">Scan this QR Code</div>
				<div class="fw-bold px-2 my-3"><img src="<?=@$data['bankicon']['qr'];?>" title="QR" class="qr_img"/></div>
				<div class="fw-bold px-2 text-muted" style="font-size:10px;">Scan or QR Code Pay or Spot code to connect </div>
				<? } } ?>
				</div>
<? } ?>

<?php /*?>nb - Bank Transfer -- IndiaBankTransfer <?php */?>
				
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankTransfer') !== false){?>
	<div class="IndiaBankTransfer_div ewalist hide">
		<div class="m-2 text-start">Use our given virtual account no. as the payee / beneficiary in your banking app. Once you transfer funds to this account.</div>
		
		<div id="IndiaBankTransfer_details" class="IndiaBankTransfer_details text-start row my-4"> </div>
		
		<div class="text-start fw-bold px-2 hide">Scan this QR Code</div>
		<div class="fw-bold px-2 text-muted hide" style="font-size:10px;">Scan or QR Code Pay or Spot code to connect </div>
	
	</div>
<? } ?>

<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiaddress') !== false){?>
						  
							<!--//////////////-->
							<?php /*?><div id="upi_display" class="hide">
							<div class="upiaddress_div ewalist hide common-payment-container">
							  <div class="payment-form gpay-main">
								<div id="upi2IdRow" class="form-row form-row-space my-2">
								  <div class="static-menu upiaddress_div">
									<input type="text"  name="upi_address" class="upiaddress_div ewalist required upi-inp float-start" id="upi_address" placeholder="Enter UPI ID" maxlength="200" onfocusout="upiaddress_validf(this.value,'.wallet_code_app')" value="">
									<span id="upi-suffix" class="gpay-adrate float-end "></span>
									<input type="hidden" name="upi_address_suffix" id="upi-suffix-hidden" value="" />
								  </div>
								  <div class="sbm-option">
										<ul id="upi-data-list" class="upi-data-list">
									</ul>
								  </div>
								  
								  <button  type="submit" name="send123" value="CHANGE NOW!"  class="submitbtn btn btn-primary next w-100 float-end my-2"><i></i><b class="contitxt">Continue</b></button>
								  
								</div>
							  </div>
							</div>
							</div><?php */?>

<? } ?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiAddressBoth') !== false){?>
					
					<!--//////////////-->
					<div class="upiAddressBoth_div ewalist hide common-payment-container">
					  <div class="payment-form gpay-main">
						<div id="upi2IdRow" class="form-row form-row-space my-2">
						  <div class="static-menu upiAddressBoth_div">
							<input type="text"  name="upi_address" class="upiAddressBoth_div ewalist upi-inp float-start" id="upi_address" placeholder="Enter UPI ID" maxlength="200" value="">
							<span id="upi-suffix" class="gpay-adrate float-end "></span>
							<input type="hidden" name="upi_address_suffix" id="upi-suffix-hidden" value="" />
						  </div>
						  <div class="sbm-option">
								<ul id="upi-data-list" class="upi-data-list">
							</ul>
						  </div>
						</div>
					  </div>
					</div>

				<? } ?>
				
							
                 <? //end walletlist list----  ?>

<? //start netbanking list----  ?>

<? //BANK LIST AND LOGO FOR Paytm - ADDED ON 25052023 BY Vikash?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'PaytmBankLogo')!==false){?>
						<div class="PaytmBankLogo_div ewalist hide">
							<div class="row">
							
					<div class="col-sm-4 border p-2 desImg AXIS">
					<div class="text-center"><img src="<?=@$data['bankicon']['axis'];?>" title="AXIS" class="bank_img"/></div>
					<span class="bankNm txNm">AXIS</span>
					</div>
							
					<div class="col-sm-4 border p-2 desImg HDFC">
					<div class="text-center"><img src="<?=@$data['bankicon']['hdfc'];?>" title="HDFC" class="bank_img"/></div>
					<span class="bankNm txNm">HDFC</span>
					</div>
					
					<div class="col-sm-4 border p-2 desImg ICICI">
					<div class="text-center"><img src="<?=@$data['bankicon']['icici'];?>" title="ICICI" class="bank_img"/></div>
					<span class="bankNm txNm">ICICI</span>
					</div>
					
					<div class="col-sm-4 border p-2 desImg IDBI">
					<div class="text-center"><img src="<?=@$data['bankicon']['idbi'];?>" title="IDBI" class="bank_img"/></div>
					<span class="bankNm txNm">IDBI</span>
					</div>

					
					<div class="col-sm-4 border p-2 desImg IDFC">
					<div class="text-center"><img src="<?=@$data['bankicon']['idfc'];?>" title="IDFC" class="bank_img"/></div>
					<span class="bankNm txNm">IDFC</span>
					</div>
					
					<div class="col-sm-4 border p-2 desImg YES">
					<div class="text-center"><img src="<?=@$data['bankicon']['yes'];?>" title="Yes Bank" class="bank_img"/></div>
					<span class="bankNm txNm">YES</span>
					</div>
					

					
				
		
							
							
							</div>
						</div>
					<? }?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'PaytmBankList') !== false){?>
						<div class="PaytmBankList_div ewalist hide">
						<div class="input-field select my-3">
<select class="w94 dropDwn required form-select form-select-lg" name="bankCode" id="bankCode" style="margin:5px 0;">
<option value="AIRP">AIRTEL PAYMENTS BANK</option>
<option value="ALH">ALLAHABAD BANK</option>
<option value="AXIS">AXIS BANK</option>
<option value="ANDB">ANDHRA BANK</option>
<option value="AUBL">AU SMALL FINANCE BANK</option>
<option value="BBL">BANDHAN BANK LTD</option>
<option value="BOI">BANK OF INDIA</option>
<option value="BHARAT">BHARAT BANK</option>
<option value="BBK">BANK OF BAHRAIN AND KUWAIT</option>
<option value="BOB">BANK OF BARODA</option>
<option value="BOM">BANK OF MAHARASHTRA</option>
<option value="CBI">CENTRAL BANK OF INDIA</option>
<option value="CSB">CATHOLIC SYRIAN BANK</option>
<option value="CANARA">CANARA BANK</option>
<option value="CITIUB">CITY UNION BANK</option>
<option value="CORP">CORPORATION BANK</option>
<option value="COSMOS">COSMOS BANK</option>
<option value="DCB">DCB BANK LIMITED</option>
<option value="DHAN">DHANLAXMI BANK</option>
<option value="DENA">DENA BANK</option>
<option value="DEUTS">DEUTSCHE BANK</option>
<option value="ESFB">EQUITAS BANK</option>
<option value="FDEB">FEDERAL BANK</option>
<option value="GPPB">GOPINATH PATIL PARSIK JANATA SAHAKARI BANK LTD</option>
<option value="HDFC">HDFC BANK</option>
<option value="ICICI">ICICI BANK</option>
<option value="IDBI">IDBI BANK</option>
<option value="IDFC">IDFC BANK</option>
<option value="INDS">INDUSIND BANK</option>
<option value="INDB">INDIAN BANK</option>
<option value="IOB">INDIAN OVERSEAS BANK</option>
<option value="JSB">JANATA SAHAKARI BANK LTD PUNE</option>
<option value="JKB">JAMMU AND KASHMIR BANK</option>
<option value="KTKB">KARNATAKA BANK</option>
<option value="KVB">KARUR VYSYA BANK</option>
<option value="NKMB">KOTAK BANK</option>
<option value="LVB">LAKSHMI VILAS BANK</option>
<option value="NKGS">NKGSB BANK</option>
<option value="PSB">PUNJAB AND SIND BANK</option>
<option value="PYTM">PAYTM PAYMENTS BANK LTD</option>
<option value="PNB">PUNJAB NATIONAL BANK</option>
<option value="RATN">RBL BANK</option>
<option value="RBS">ROYAL BANK OF SCOTLAND</option>
<option value="SCB">STANDARD CHARTERED BANK</option>
<option value="SVC">SVC COOPERATIVE BANK LTD</option>
<option value="STB">SARASWAT CO-OPERATIVE BANK LTD</option>
<option value="SIB">SOUTH INDIAN BANK</option>
<option value="SBI">STATE BANK OF INDIA</option>
<option value="SSFB">SURYODAY SMALL FINANCE BANK</option>
<option value="TNMB">TAMILNAD MERCANTILE BANK</option>
<option value="UCO">UCO BANK</option>
<option value="USFB">UJJIVAN SMALL FINANCE BANK</option>
<option value="UNI">UNION BANK OF INDIA RETAIL</option>
<option value="UBI">UNITED BANK OF INDIA</option>
<option value="VJYA">VIJAYA BANK</option>
<option value="YES">YES BANK</option>
</select>
<label for="bankCode">Select a different bank</label>
<input class="w94" type="text"  name="bankCode_text" style="margin:5px 0;display:none;" />
</div>
					<? }?>
<? //BANK LIST AND LOGO FOR Paytm - END ?>


<? //BANK LIST FOR PayU - Start ?>

<?
if(isset($post['t_name6'])&&strpos($post['t_name6'],'allPayPayuBankingList') !== false){?>
					<div class="allPayPayuBankingList_div ewalist hide">
						<select class="w94 dropDwn required form-select from-select-sm" name="bank_code_payu" id="bank_code_payu" style="margin:5px 0;" data-required="required">
							<option value="AIRNB">Airtel Payments Bank</option>
							<option value="AXIB">Axis NB</option>
							<option value="BOIB">Bank Of India</option>
							<option value="BOMB">Bank Of Maharashtra</option>
							<option value="BHNB">Bharat Co-Op Bank</option>
							<option value="CABB">Canara Bank</option>
							<option value="CSBN">Catholic Syrian Bank</option>
							<option value="CBIB">Central Bank of India</option>
							<option value="CUBB">City Union Bank</option>
							<option value="CRBP">Corporation Bank</option>
							<option value="CSMSNB">Cosmos Bank</option>
							<option value="DENN">Dena Bank</option>
							<option value="DSHB">Deutsche Bank</option>
							<option value="DCBB">Development Credit Bank</option>
							<option value="DLSB">Dhanlaxmi Bank</option>
							<option value="HDFB">HDFC Bank</option>
							<option value="ICIB">ICICI</option>
							<option value="IDFCNB">IDFC</option>
							<option value="INDB">Indian Bank</option>
							<option value="INOB">Indian Overseas Bank</option>
							<option value="INIB">IndusInd Bank</option>
							<option value="IDBB">Industrial Development Bank of India (IDBI)</option>
							<option value="JAKB">Jammu and Kashmir Bank</option>
							<option value="JSBNB">Janata Sahakari Bank Pune</option>
							<option value="KRKB">Karnataka Bank</option>
							<option value="KRVBC">Karur Vysya - Corporate Netbanking</option>
							<option value="162B">Kotak Mahindra Bank</option>
							<option value="LVCB">Lakshmi Vilas Bank - Corporate Netbanking</option>
							<option value="LVRB">Lakshmi Vilas Bank - Retail Netbanking</option>
							<option value="TBON">Nainital Bank</option>
							<option value="OBCB">Oriental Bank of Commerce</option>
							<option value="PMNB">Punjab And Maharashtra Co-operative Bank Limited</option>
							<option value="PSBNB">Punjab And Sind Bank</option>
							<option value="CPNB">Punjab National Bank - Corporate Banking</option>
							<option value="PNBB">Punjab National Bank - Retail Banking</option>
							<option value="SRSWT">Saraswat bank</option>
							<option value="SBIB">SBI Netbanking</option>
							<option value="SVCNB">Shamrao Vithal Co-operative Bank Ltd</option>
							<option value="SYNDB">Syndicate Bank</option>
							<option value="TMBB">Tamilnad Mercantile Bank</option>
							<option value="FEDB">The Federal Bank</option>
							<option value="KRVB">The Karur Vysya Bank</option>
							<option value="SOIB">The South Indian Bank</option>
							<option value="UCOB">UCO Bank</option>
							<option value="UBIBC">Union Bank - Corporate Netbanking</option>
							<option value="UBIB">Union Bank Of India</option>
							<option value="VJYB">Vijaya Bank</option>
						</select>
					<input class="w94" type="text" name="bank_code_text" style="margin:5px 0;display:none;" />
					</div>
					<? 
					}?>
					
<? //BANK LIST FOR PayU - END ?>
						
					
<? //end netbanking list----  ?>

<? //start upi  list----  ?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiIndiaLogo') !== false){?>
						  <div class="upiIndiaLogo_div ewalist hide">
							<div class="upisDiv desImg  BHIM" data-showc="upi_vpa" data-hidec="customerPhone"><img src="<?=@$data['Host']?>/images/bhim.png" alt="BHIM" title="BHIM"><span class="upis txNm hide">BHIM</span></div>
							<div class="upisDiv desImg PhonePe" data-showc="upi_vpa" data-hidec="customerPhone"><img src="<?=@$data['Host']?>/images/phonepe.png" alt="PhonePe" title="PhonePe"><span class="upis txNm hide">PhonePe</span></div>
							<div class="upisDiv desImg GooglePayTez" data-showc="customerPhone" data-hidec="upi_vpa"><img src="<?=@$data['Host']?>/images/tez.png" alt="GooglePayTez" title="GooglePayTez"><span class="upis txNm hide">GooglePayTez</span></div>
							<div class="upisDiv desImg PayTm" data-showc="upi_vpa" data-hidec="customerPhone"><img src="<?=@$data['Host']?>/images/paytm.png" alt="PayTm" title="PayTm"><span class="upis txNm hide">PayTm</span></div>
						  </div>
						  <? } ?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiIndiaList') !== false){?>
						  <div class="upiIndiaList_div ewalist hide">
							<input class="w94 upi_vpa required" type="text" placeholder="Enter Your UPI VPA" title="Enter Your UPI VPA" name="upi_vpa" id="upi_vpa" style="margin:5px 0;" />
							<input class="w94 customerPhone required hide" type="text" placeholder="Enter your Google Pay 10 digit mobile number" title="Enter your Google Pay 10 digit mobile number" name="customerPhone" id="customerPhone" value="<?=(isset($post['customerPhone'])&&$post['customerPhone']?$post['customerPhone']:$post['bill_phone']);?>" style="margin:5px 0;display:none;" />
							<select class="w94 dropDwn required" name="upi_vpa_lable" id="upi_vpa_lable" style="margin:5px 0; display:none;">
							  <option value="BHIM">BHIM</option>
							  <option value="PhonePe">PhonePe</option>
							  <option value="GooglePayTez">GooglePayTez</option>
							  <option value="PayTm">PayTm</option>
							</select>
						  </div>
						  <? } ?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiaddressInput') !== false){?>
							<input type="text" class="upiaddressInput_div ewalist hide w95 form-control form-control w-100 float-start clearfix" id="upi_address_input" name="upi_address" style="margin:0px 0;display:none;width:100%!important" placeholder="Enter full UPI Address" value="<?=(isset($post['upi_address'])?$post['upi_address']:$post['upi_address']);?>" />
						<? } ?>
<? //end upi  list----  ?>	

	
<? //start msg  list----  ?>		
					
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'Coinbase_msg') !== false){?>
                      <div class="Coinbase_msg_div ewalist modalMsg hide" data-style='width:300px;height:220px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >
                            <h4>
                            Coinbase</h4>
                            <p><b>Do you already have Coinbase Wallet?</b></p>
                            <span class="submit_div">
                            <button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-primary " autocomplete="off"  onclick='checkValidity_tr_f();'><i class="far fa-check-circle"></i> <b class="contitxt">Yes</b></button>
                            </span> <a class="nopopup suButton btn btn-primary" onClick="view_tr_next3(this,'.noText3')" data-ph="400px" data-ch="200px">No</a>
                            <p class='hide noText3'>(If you do not have Coinbase Wallet, You can logon to coinbase.com and create an account once your account is <a href="https://www.coinbase.com/signup" target="_blank"><strong>created/verified</strong></a> you can come back to us and complete the payment for your favourite merchant.)</p>
                          </div>
                        </div>
                      </div>
                      <? } ?>

<div class="universal_msg_div ewalist modalMsg hide" data-style='width:300px;height:370px;margin:-185px 0 0 -132px;' >
                        <div class="modalMsgCont" style="display:none !important">
                           <div class="modalMsgContTxt" >
						  
						    <div class="redirectBankPage universal">
								<p style="text-align:center;margin:80px 0 60px 0;">We are about to redirect you to bank page to authenticate this transactions in the next tab.</p>
								<span class="submit_div upiadd">
								<button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary redirect_upiadd" autocomplete="off" style='width:92%' onclick="checkValidity_tr_f('hideCloseButton');"><i class="far fa-check-circle"></i> <b class="contitxt">Yes</b></button>
								</span> 
							</div>
							
							<?/*?>
							<a class='nopopup suButton btn btn-icon btn-primary modal_msg_close3' onclick="modal_msg_close();" style='width:35%'>No</a>
							<?*/?>
							<div class="hide bankStatus" style="display:none;text-align:center;">
							
								<div class="token_base_time"></div> 
							
								<p style="text-align:center;margin:40px 0 10px 0;">You can always switch back to this tab if transactions is not successful. </p>
								
								<a class='nopopup suButton btn btn-icon btn-primary'  href="<?=@$data['Host']?>/bank_status<?=@$data['ex']?>" target="_top" >I have paid</a>
								
								
								
								<p style="text-align:center;margin: 30px 0 10px 0;">Try making the payment again with a different payment method.</p>
								
								<a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="authenticatef()"  >YES</a>
								
							</div>
							
                          </div>
                        
                        </div>
                      </div>
					  
<!-- intent_submitMsg via app open   --> 
					  
		<div class="intent_appOpenSubmit_div ewalist submitMsg hide" data-style='width:250px;height:142px;margin:-71px 0 0 -125px;overflow:hidden;' >
			<div class="modalMsgCont" style="display:none !important">
			  <div class="modalMsgContTxt" >
				  <div class="appOpen p-0">
					<div style="text-align:center;margin:12px 0 0 0;">"<i><?=@$_SESSION['ter_name']?></i>" wants to open.
					<span class="appOpenName" style="text-align:center;margin:10px 0 0 0;font-weight: bold;font-size: 12px;text-transform:capitalize;">"UPI / APP / Wallet"</span>
				 </div>
				
				
					<div class="submit_div1 mx_button_row mt-2 p-0" style="">
					
						<a class='paid_upiIntent_link nopopup suButton btn btn-icon btn-primary modal_msg_close3 mx_button_1' onclick="processing_closef('Pay');modal_msg_close();" style="">Cancel</a>
						
						<span class="appOpenUrlLink"><a class='appOpenUrl nopopup suButton btn btn-icon btn-primary' style="">Open</a></span>
						
					</div> 
					
					<p class="hide">Initiating Payment...</p>
				</div>
				
			  </div>
			</div>
		</div>
					  
<!-- intent_submitMsg --> 
<div class="intent_submitMsg_div ewalist submitMsg hide" data-style='width:320px;height:400px;margin:-200px 0 0 -160px;' >
                        <div class="modalMsgCont" style="display:none !important">
                          <div class="modalMsgContTxt" >

						    <div class="redirectBankPage intent">
								<p style="text-align:center;margin:80px 0 60px 0;">We are about to redirect you to bank page to authenticate this transactions in the next tab.</p>
								<span class="submit_div">
								<button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:92%' onclick="checkValidity_tr_f('hideCloseButton');"><i class="far fa-check-circle"></i> <b class="contitxt">Yes</b></button>
								</span> 
							</div>
							
							<?/*?>
							<a class='nopopup suButton btn btn-icon btn-primary modal_msg_close3' onclick="modal_msg_close();" style='width:35%'>No</a>
							<?*/?>
							<div class="hide bankStatus" style="display:none;text-align:center;">
							
								<div class="token_base_time"></div> 
							
								<p style="text-align:center;margin:40px 0 10px 0;">You can always switch back to this tab if transactions is not successful. </p>
								
								<a class='nopopup suButton btn btn-icon btn-primary' href="<?=@$data['Host']?>/bank_status<?=@$data['ex']?>" target="_top" >I have paid</a>
								
								
								
								<p style="text-align:center;margin: 30px 0 10px 0;">Try making the payment again with a different payment method.</p>
								
								<a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="authenticatef()"  >Yes</a>
								
							</div>
							
                          </div>
                        </div>
                      </div>
					  
					  
<? //end msg  list----  ?>					

							
</div>

<div class="submit_div text-muted m-button my-2 clearfix">
						  <div class="float-start text-center w-50">
  <div class="w-100 fw-bold" style="font-size:13px;">
    <?=@$currency_smbl;?>
    <!--<?=@$post['curr']?$post['curr']:$_SESSION['curr'];?>-->
    <?=(@$post['total']?$post['total']:$post['bill_amt'])?>
  </div>
  <div class="account-pop pointer text-link" style="font-size:10px;" title="View Payment Details">View Details</div>
</div>
						  <button onclick="checkValidity_tr_f('hideCloseButton');" id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!"  class="paybutton submitbtn btn btn-slide next w-50 float-end b555"><i></i><b class="contitxt">Continue</b></button>
						  
						  
						  <a id="paid_qrcode_button" class="paid_qrcode_button paid_qrcode_link btn btn-slide w-50 float-end hide"><i></i><b class="contitxt1">I have paid</b></a>
						</div>
						
<div class="modal_msg" id="modal_msg">
                        <div class="modal_msg_layer"> </div>
                        <div class="modal_msg_body"> 
						<a class="modal_msg_close" onClick="document.getElementById('modal_msg').style.display='none';" style="position:relative;top:-6px;right:7px;">×</a>
                          <div id="modal_msg_body_div"> </div>

                          <a style="display:none;" title="Have you authenticated the transaction" class="modal_msg_close2" onClick="document.getElementById('modal_msg').style.display='none';" href="<?=@$data['Host']?>/bank_status<?=@$data['ex']?>" target="_top">Yes</a>
						</div>
                      </div>
						
						
						
						
					  </div>
					</form>
				  </div>
				  <? } ?>
				  
				  </div>
				<? } ?>
			  </div></td></tr>
		</table>
	  </div>
	
	  </div>
	    <? }elseif(isset($post['step'])&&$post['step']==4){?>
	  This email address belong to active merchant, You can not send a payment by using this email address. Please change the email address and try again with the payment method.<br/>
	  <br/>
	  <b><font style="color:red;">Please note:</font> Your card has been not charged for this payment.</b>
	  <? if(isset($_SESSION['sendConfirm'])&&$_SESSION['sendConfirm']) { ?>
	  Your account has been created successfully. <br />
	  A verification link has been sent to your account. <br />
	  Please check your mail and verify your account.
	  <? unset($_SESSION['sendConfirm']); } ?>
	  <? if(isset($_SESSION['sendConfirmemail'])&&$_SESSION['sendConfirmemail']) { ?>
	  Your account has been created successfully. <br />
	  A verification link has been sent to your account. <br />
	  Please check your mail and verify your account.
	  <? unset($_SESSION['sendConfirmemail']); } ?>
	  <? }elseif(isset($post['step'])&&$post['step']==3){?>
	  Your card details are incorrect. Please try again.
	  <? }elseif(isset($post['step'])&&$post['step']==6){?>
	  Due to some merchant issue this transaction is not proceed.
	  <? }elseif(isset($post['step'])&&$post['step']==7){?>
	  Due to some issue this transaction is not proceed.
	  <? } ?>
	  <? if(isset($post['step'])&&$post['step']==5){ ?>
	  <div id="card" class="showfp">
		<input type="hidden" name="cc_payment_mode" value="CC Payment" />
		<input type="hidden" name="payment"  value="creditcard"  />
		<table class="frame" width="100%" border="0" cellspacing="1" cellpadding="4" >
		  <tr><td class="capl" colspan="2"><? if(!isset($post['action'])||$post['action']!='donation'){?>
			  PURCHASE ITEM
			  <? }else{?>
			  MAKE A DONATION
			  <? } ?></td></tr>
		  <tr><td class="field" width="340" nowrap><? if(!isset($post['action'])||$post['action']!='donation'){?>
			  Pay
			  <? }else{?>
			  Donate
			  <? } ?>
			  To:</td>
			<td class="input"><?=prntext(@$post['clients'])?></td></tr>
		  <tr><td class="field" nowrap>Status:</td>
			<td class="input"><font color=#FF0000><b>
			  <? if(!isset($post['status_mem'])||$post['status_mem']==0){?>
			  UNVERIFIED
			  <? }elseif(isset($post['status_mem'])&&$post['status_mem']==1){?>
			  VERIFIED
			  <? }else{?>
			  CERTIFIED
			  <? } ?>
			  </b></font></td></tr>
		  <tr><td class="field" nowrap><? if(!isset($post['action'])||$post['action']!='donation'){?>
			  Product/Service
			  <? }else{?>
			  Donate Towards
			  <? } ?>
			  :</td>
			<td class="input"><?=prntext(@$post['product'])?></td></tr>
		  <tr><td class="field"><? if(!isset($post['action'])||$post['action']!='donation'){?>
			  Bill Amount:
			  <? }else{?>
			  Amount,
			  <?=prntext(@$data['Currency'])?>
			  <? } ?></td>
			<td class="input"><? if(!isset($post['action'])||$post['action']!='donation'){?>
			  <?=prntext(@$data['Currency'])?>
			  <?=prnsumm($post['bill_amt'])?>
			  <? }else{?>
			  <input type="text" name="bill_amt" size="10" maxlength="8" value="<?=prnsumm($post['bill_amt'])?>">
			  <? } ?></td></tr>
		  <? if(!isset($post['action'])||$post['action']!='donation'){?>
		  <? if(isset($post['quantity'])&&$post['quantity']>0){?>
		  <tr><td class="field">Quantity:</td>
			<td class="input"><?=prnintg($post['quantity'])?></td></tr>
		  <? } ?>
		  <? if(isset($post['setup'])&&$post['setup']>0){?>
		  <tr><td class="field">Setup Fee:</td>
			<td class="input"><?=prntext(@$data['Currency'])?>
			  <?=prnsumm($post['setup'])?></td></tr>
		  <? } ?>
		  <? if(isset($post['tax'])&&$post['tax']>0){?>
		  <tr><td class="field">Tax:</td>
			<td class="input"><?=prntext(@$data['Currency'])?>
			  <?=prnsumm($post['tax'])?></td></tr>
		  <? } ?>
		  <? if(isset($post['shipping'])&&$post['shipping']>0){?>
		  <tr><td class="field">Shipping/Handling:</td>
			<td class="input"><?=prntext(@$data['Currency'])?>
			  <?=prnsumm($post['shipping'])?></td></tr>
		  <? } ?>
		  <? if(isset($post['period'])&&$post['period']>0){?>
		  <tr><td class="field">Duration:</td>
			<td class="input"><?=prnintg($post['period'])?>
			  day(s)</td></tr>
		  <? } ?>
		  <? if(isset($post['trial'])&&$post['trial']>0){?>
		  <tr><td class="field">Trial Period:</td>
			<td class="input"><?=prnintg($post['trial'])?>
			  day(s)</td></tr>
		  <? } ?>
		  <? if(isset($post['comments'])&&$post['comments']){?>
		  <tr><td class="field">Description:</td>
			<td class="input"><?=prntext(@$post['comments'])?></td></tr>
		  <? } ?>
		  <? } ?>
		  <tr><td class="field">Transection Fee:</td>
			<td class="capc" style="text-align:left"><?=prntext(@$data['Currency'])?>
			  <?php echo ($post['total']/100)*1;?></td></tr>
		  <tr><td class="field">Total Product Bill Amount:</td>
			<td class="capc" style="text-align:left"><?=prntext(@$data['Currency'])?>
			  <?=prnsumm($post['total'])?></td></tr>
		  <tr><td class="field">Total Paid:</td>
			<td class="capc" style="text-align:left"><?=prntext(@$data['Currency'])?>
			  <?php echo $post['total']+(($post['total']/100)*$data['PaymentPercent']); ?></td></tr>
		  <tr><td class="capr" colspan="2"></td></tr>
		  <tr><td class="capl" colspan="2">Credit Card Information</td></tr>
		  <? if(isset($data['Error'])&&$data['Error']){?>
		  <tr><td colspan=2 class="error"><?=prntext(@$data['Error'])?></td></tr>
		  <? } ?>
		  <tr><td class="field" style="width:330px;">Credit Card Holder Name.:</td>
			<td class="input"><input type="text" name="fullname" size="30" maxlength="128" value="<? if(isset($post['fullname'])) echo $post['fullname']?>">
			</td></tr>
		  <tr><td class="field" style="width:330px;">Credit Card No.:</td>
			<td class="input"><input type="text" name="ccno" maxlength="24" size="30" value="<? if(isset($post['cnumber'])) echo $post['cnumber']?>">
			</td></tr>
		  <tr><td class="field">CVC:</td>
			<td class="input"><input type="password" name="ccvv" maxlength="4" size="30" value="<? if(isset($post['ccvv'])) echo $post['ccvv']?>"></td></tr>
		  <tr><td class="field">Exp Date:</td>
			<td class="input"><select name="month" id="exMonth" style="min-width:100px;">
					<option value="01">January</option>
					<option value="02">February</option>
					<option value="03">March</option>
					<option value="04">April</option>
					<option value="05">May</option>
					<option value="06">June</option>
					<option value="07">July</option>
					<option value="08">August</option>
					<option value="09">September</option>
					<option value="10">October</option>
					<option value="11">November</option>
					<option value="12">December</option>
				</select>
				<?
				if(isset($post['month'])&&$post['month'])
				{?>
				<script>
				$('#exMonth option[value="<?=@$post['month']?>"]').prop('selected','selected');
				</script>
				<?
				}
				?>
				<select name="year" id="exYear" style="min-width:100px;">
				<?
				for($yy = date('y');$yy<(date('y')+20);$yy++)
				{
				?>
					<option value="<?=@$yy?>"><?=@$yy?></option>
				<?
				} ?>
				</select>
				<?
				if(isset($post['year'])&&$post['year'])
				{?>
				<script>
				$('#exYear option[value="<?=@$post['year']?>"]').prop('selected','selected');
				</script>
				<?
				} ?>
			</td></tr>
		  <tr><td class="field">Email ID:</td>
			<td class="input"><input type="text" name="email" size="30" maxlength="128" value="<? if(isset($post['bill_email'])) echo $post['bill_email']?>"></td></tr>
		  <tr><td class="field">Re-enter Email ID:</td>
			<td class="input"><input type="text" name="email_re_enter" size="30" maxlength="128" value="<? if(isset($post['email_re_enter'])) echo $post['email_re_enter']?>"></td></tr>
		  <tr><td class="capl" colspan="2">Billing Information</td></tr>
		  <tr><td class="field">Name:</td>
			<td class="input"><input type="text" name="bill_name" size="30" maxlength="128" value="<? if(isset($post['bill_name'])) echo $post['bill_name']?>"></td></tr>
		  <tr><td class="field">Bill address:</td>
			<td class="input"><input type="text" name="bill_address" size="30" maxlength="128" value="<? if(isset($post['bill_address'])) echo $post['bill_address']?>"></td></tr>
		<?/*?>  
		  <tr><td class="field">Street 2:</td>
			<td class="input"><input type="text" name="bill_street_2" size="30" maxlength="128" value="<? if(isset($post['bill_street_2'])) echo $post['bill_street_2']?>"></td></tr>
		<?*/?>
		  <tr><td class="field">City:</td>
			<td class="input"><input type="text" name="bill_city" size="30" maxlength="128" value="<? if(isset($post['bill_city'])) echo $post['bill_city']?>"></td></tr>
		  <tr><td class="field">State:</td>
			<td class="input"><!--<input type="text" name="bill_state" size="30" maxlength="128" value="<//?=$post['bill_state']?>">-->
			  <select name="bill_state" style="width:100px;"></select>
			  
			</td></tr>
		  <tr><td class="field">Zip:</td>
			<td class="input"><input type="text" name="bill_zip" size="30" maxlength="128" value="<? if(isset($post['bill_zip'])) echo $post['bill_zip']?>"></td></tr>
		  <tr><td class="field">Phone:</td>
			<td class="input"><input type="text" name="bill_phone" size="30" maxlength="128" value="<? if(isset($post['bill_phone'])) echo $post['bill_phone']?>"></td></tr>
		  <tr><td class="capc" colspan=2><? if(isset($post['step'])&&$post['step']==1){?>
			  <input class="submit" type="button" value="BACK" onClick="document.location.href='<? if(isset($post['ucancel'])) echo $post['ucancel']?>'">
			  &nbsp;
			  <? } ?>
			  <input class="submit" type="submit" name="integration-type" value="CONTINUE">
			</td></tr>
		</table>
	  </div>
	  <? } ?>
	  
<?php /*?>=======For Generate default Qr Code for display in UPI =========<?php */?>
<? 
/*
$qr_pa="7065491021@paytm";
$qr_pn="1111";
$qr_tr="1111";
$qr_cu=@$post['curr']?$post['curr']:@$_SESSION['curr'];
$qr_am=@$post['total']?$post['total']:@$post['bill_amt'];

$url_qr = "upi://pay?pa=$qr_pa&pn=$qr_pn&tr=$qr_tr&cu=$qr_cu&am=$qr_am"; // Hardcoading Dummy Data
$url_qr = urlencode($url_qr);
*/
?>
<div class="display_qr_on_upi hide"><img src="https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=<?=@$url_qr;?>&choe=UTF-8"></div>
<?php /*?>===================================<?php */?>
	  
	<?  
	if(isset($_POST['payment'])&&$_POST['payment']=='creditcard'){	
	?>
	<script type="text/javascript" >
		SlideBox('card',false);
	</script>
<?
}elseif(isset($_POST['payment'])&&$_POST['payment']=='epayaccount'){ ?>
	<script type="text/javascript" >
		SlideBox('epay',false);
	</script>
<? } ?>
<script src="<?=@$data['Host'].'/js/jquery.payform.min.js'?>" charset="utf-8"></script>


<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'ajaxBin') !== false){?>
<script language="javascript" type="text/javascript"> 
ajaxBinVar=1;
//alert("ajaxBin=>ok");
function ajaxBinCf(theBinNo)
{
	var url_bin="<?=@$data['Host']?>/api/pay74/apibin.php?cb="+theBinNo;
	if(wn){
		nw(url_bin);
	}
	
	$.ajax({
		url: url_bin,
		type: 'POST',
		dataType: 'json', 
		data:{action:"ajaxBin", cb:theBinNo},
		success: function(data){
			//myObj = JSON.parse(data);
			//alert(JSON.stringify(data));
			if(data["cards"]["type"]){
				//alert("cards type => "+data["cards"]["type"]);
				if($('#payment_method')){
					$('#payment_method').val(data["cards"]["type"]);
				}
			}else{
				$('#payment_method').val('');
				//alert("Opps: "+JSON.stringify(data)+" , BinNo.=> "+theBinNo);
			}
			
		}
	});

}	
</script>
<? } ?>

<script language="javascript" type="text/javascript"> 
//alert("ok");
var cardNumber = $('#number');
var cardNumber2 = $('.key_input,#number');
var cardNumberField = $('#card-number-field');
var CVV = $("#cvc");
var mastercard = $("#mastercard");
var confirmButton = $('#cardsend_submit');
var visa = $("#visa");
var amex = $("#amex");
var jcb = $("#jcb");
var cardtype = $("#cardtype"); 
var cardLength=19;
var setCardLength_allcard=19;
var setCardLength_amex=18;
var cardLengthInput=0;

if(BrowserName==setBrowserName){ 
	cardLength=19;
	setCardLength_allcard=19;
	setCardLength_amex=18;
	//alert('BrowserName=>'+BrowserName+',cardLength=>'+cardLength+',setCardLength_amex=>'+setCardLength_amex+',setCardLength_allcard=>'+setCardLength_allcard); 
}

var $form = $('#payment_form_id');

var expMonth = $('#expMonth');
var expYear = $('#expYear');

function myTrim(x) {
  return x.replace(/^\s+|\s+$/gm,'');
}
function isBlank(str){
	return (!str || /^\s*$/.test(str));
}


function cardvalidorf(){
	cardNumber.payform('formatCardNumber');
	CVV.payform('formatCardCVC');
	
	
	expMonth.change(function(){
		expYear.focus();
	});
	expYear.change(function(){
		CVV.focus();
	});
	
	cardNumber2.on('keyup keypress change', function(e){
	//alert("keypress");return;
		var code = e.keyCode || e.which;

		cardtype.val($.payform.parseCardType(cardNumber.val()));
		
		if(cardtype.val() === "amex"){
			cardLength=setCardLength_amex;
			$('#int16').removeAttr('required');
			$('#int16').hide();
		} else {
			cardLength=setCardLength_allcard;
			$('#int16').attr('required','required');
			$('#int16').show();
		}
		
		
		if ( ( $.payform.validateCardNumber(cardNumber.val()) == false ) && ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) > -1 )  ) {
            //cardNumberField.addClass('has-error');
			
			if(cardNumber.val().length<cardLength){
				//alert('BrowserName=>'+BrowserName+',cardLength=>'+cardLength+',setCardLength_amex=>'+setCardLength_amex+',setCardLength_allcard=>'+setCardLength_allcard+',cardNumber val=>'+cardNumber.val()+',cardNumber length =>'+cardNumber.val().length); 
				
				$form.find('#form-input-errors').css('display','block');
				$form.find('#form-input-errors').text("Wrong card number. Please enter correct!");
			}else{
				$('#form-input-errors').text("");
				$('#form-input-errors').css('display','none');
			}
			
			cardNumber.removeAttr('class');
			cardNumber.attr('class','iconnocard');
        } else {
            //cardNumberField.removeClass('has-error');
			$form.find('#form-input-errors').text("");
			$form.find('#form-input-errors').css('display','none');
			$("#cardsend_submit").prop('disabled', false);
			
            //cardNumberField.addClass('has-success');
			
			if(cardNumber.val().length === cardLength || cardNumber.val().length == cardLength) {
				 var val = $.payform.parseCardType(cardNumber.val());
				 var ccn_match = '';
				 if(val){
				   ccn_match = ccn_var.match(new RegExp(val, 'i'));
				 }
				 if(ccn_match){
					//alert('ccn_match'+"\r\n"+ccn_var);
				 }else{					//alert(cardNumber.val().length+"\r\n"+$.payform.parseCardType(cardNumber.val()));
				  //alert('No Payment Chanel Available to process this card.');
				  alert($('.alert_msg_2').text());
				}
			}
			var g_card_name=$.payform.parseCardType(cardNumber.val());
			cardNumber.attr('class','form-control');
			$('#input-card-icon').attr('class','');
			//alert(g_card_name);
			
			if(g_card_name=="mastercard"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['mastercard_code'];?> text-danger');
			
			}else if(g_card_name=="visa"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['visa_code'];?> text-info');
			
			}else if(g_card_name=="amex"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['amex_code'];?> text-info');
			
			}else if(g_card_name=="rupay"){ 
			$('#input-card-icon').attr('class','');
			cardNumber.attr('class','form-control icon'+$.payform.parseCardType(cardNumber.val()));
			
			}else if(g_card_name=="discover"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['discover_code'];?>');
			
			}else if(g_card_name=="jcb"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['jcb_code'];?> text-success');
			
			}else if(g_card_name=="dinersclub"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['diners_code'];?> text-danger');
			
			}else{
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['credit-card'];?>');
			}
			
			//cardNumber.attr('class','11 form-control icon'+$.payform.parseCardType(cardNumber.val()));
			// block card details by vikash on 24012023
			
        }
		
		cardLengthInput=cardNumber.val().length; 
		
		if($(this).hasClass('key_input')){
			if($(this).val().length === 1){
				if($(this).next().hasClass('key_input') && $(this).next().val().length == ''){
					$(this).next().focus();
				}
			}
			conc();
		}
		
		   var card_trim=cardNumber.val();
			 card_trim = card_trim.replaceAll(" ", "");
			 
		if(card_trim.length === cardLength || card_trim.length == cardLength) {
			//$('#form-input-errors').text("");
			//$('#form-input-errors').css('display','none');	
			//alert(99999999999999999999999999);
			expMonth.focus();
		}else if(card_trim.length < 13 ) {
		
		$('#number').focus();
		}
		

		
		$('#credit_cards img').addClass('transparent');

		$('#credit_cards span').addClass('transparent');
		$('#credit_cards #'+$.payform.parseCardType(cardNumber.val())).removeClass('transparent');
		
		
		
		
		//e.preventDefault();
    });
	
	expMonth.focus(function(){
		$('#form-input-errors').css('display','none');	
	});
}

	$('#payment_form_id').submit(function(e) {
	try {
		var $form = $('#payment_form_id');
		var cardNumber = $('#number');

		var isCardValid = $.payform.validateCardNumber(cardNumber.val());
		var isCvvValid = $.payform.validateCardCVC(CVV.val());

		if ( card_validation == 'yes' ) {

			if( (cardNumber.val().length === cardLength) && ( ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) === -1) && ($.inArray(cardNumber.val().replace(/\s+/g, '').substring(0, 6), jsLuhnSkip ) === -1)  ) ){
					 var val = $.payform.parseCardType(cardNumber.val());
					 var ccn_match = ccn_var.match(new RegExp(val, 'i'));
					 if(ccn_match){
						//alert('ccn_match'+"\r\n"+ccn_var);
					 }else{					
				  //alert('No Payment Chanel Available to process this card');
				  alert($('.alert_msg_2').text());
					  cardNumber.focus();
					  return false;
					}
			}

			
			 if ( ( !isCardValid ) && ($.inArray(cardNumber.val().replace(/\s+/g, ''), jsTestCardNumbers ) > -1 )  ) {
			//alert('11BrowserName=>'+BrowserName+',cardLength=>'+cardLength+',setCardLength_amex=>'+setCardLength_amex+',setCardLength_allcard=>'+setCardLength_allcard+',cardNumber val=>'+cardNumber.val()+',cardNumber length =>'+cardNumber.val().length); 
				
				alert("Wrong card number."); return false;
				
			}else if (!isCvvValid) {
            //alert("Wrong CVV");
			alert($('.alert_msg_3').text());
			} else {
			
                //alert("submit0000");

				$("#cardsend_submit .contitxt").html("<i class='<?=@$data['fwicon']['spinner'];?> fa-spin-pulse'></i> ");
				$("#cardsend_submit").prop('disabled', true);
				
				

				//top.window.openFullscreen_2();

				$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');

				//$('#modalpopup_form_popup').slideDown(900);
				//alert("Other Acc.="+$('#payment_form_id input[name="acquirer"]').val());
				
				
				pendingCheckStartf('reStart');
				//$('#payment_form_id').attr('target','payin_win');
				
				$form.get(0).submit();
			}
		} else {
			//$("#cardsend_submit .contitxt").text('Please wait ...');
			$("#cardsend_submit .contitxt").html("<i class='<?=@$data['fwicon']['spinner'];?> fa-spin-pulse'></i> ");
			$("#cardsend_submit").prop('disabled', true);
             $('#modalpopup_form_popup').slideDown(900);

			//top.window.openFullscreen_2();
			
			$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');
				//$('#modalpopup_form_popup').slideDown(900);
				
				
			//alert("Other Acc.="+$('#payment_form_id input[name="acquirer"]').val());
			
			
			pendingCheckStartf('reStart');
			$form.get(0).submit();	
		}
		e.preventDefault();
		}
		catch(err) {
		  alert('cardPayment=>'+err.message);
		  //document.getElementById("demo").innerHTML = err.message;
		}
	});
	
	function checkValidity_tr_f(thaCond=''){
	 try {
		 //alert('11111111');
		 var hasInput=false;
		 
		 if(thaCond=='hideCloseButton'){
			 $('.modal_msg.active .modal_msg_close').hide();
			 $('.modal_msg.active .modal_msg_close2').hide();
		 }
		 
		  $('.ewalist.active .required').each(function () {
				if($(this).val()  == ""){
					hasInput=true;
				}
		  }); 
		  if(hasInput==true){
				$('#modal_msg').hide(1000);
				alert("need input");
		  }else{
				//alert("good input");
				if($('.modalMsgContTxt div').hasClass('bankStatus')){
					setTimeout(function(){ 
						$('.bankStatus').show(1000);
						$('.redirectBankPage').hide(500);
					}, 10000); // after
				}
				
		  } 
		}
		catch(err) {
		  alert('checkValidity=>'+err.message);
		}
	} 
	
$('#payment_form_id_ewallets').submit(function(e) { 
	try {
		var $form = $('#payment_form_id_ewallets');
		$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />'); 
		
		
		var ewlistVar= $('.account_types.active').attr('data-ewlist');
		
		/***== popup position control for center wise	==*/
		var submitmsgVar= $('.account_types.active').attr('data-submitmsg');
		var dataStyle=$('.'+submitmsgVar+'_div').attr('data-style');
		$('.modal_msg_body').attr('style','');
		if(dataStyle !== undefined){
			$('.modal_msg_body').attr('style',dataStyle); 
		}
		
		//alert(ewlistVar);
		
		/*if( ($('.account_types').hasClass('active')) && (ewlistVar !== undefined) && (ewlistVar) && (ewlistVar.match('qrcodeadd|qracq_')) ){ 
			generate_qr_codef();
			return false;
		}
		else */
		if( ($('.account_types').hasClass('active')) && (ewlistVar !== undefined) && (ewlistVar) && (ewlistVar.match('appIntent_submitMsg|appIntent_')) && ( $('.mop_ajax_checkout').val()==='QRINTENT') ){
			if( $('.actionajax').val()==='ajaxIntentArrayUrl') {
				generate_intent_array_urlf();
			}
			else {
				generate_intent_urlf();
			}
			return false;
		}
		else if(($('.account_types').hasClass('active')) && (submitmsgVar !== undefined) && (submitmsgVar) && (submitmsgVar == 'intent_submitMsg') && ( $('.submitMsg').hasClass(submitmsgVar+'_div') )  ){
			//alert(submitmsgVar);
			
			/*
			$('#payment_form_id_ewallets').attr('target','payin_win');
			
			$('#modal_msg_body_div').html($('.'+submitmsgVar+'_div .modalMsgCont').html()); 
			$('#modal_msg').show(100);
			
			
			if($('#modal_msg').hasClass('active')){
				//return true;
			}else{ 
				//cmn
				
				$('#modal_msg').addClass('active');
				return false;
			}
			*/
		}
		else if($('#payment_form_id_ewallets').hasClass('nextTabTr')){
			if($('div').hasClass('modal_msg_body')){
			  $('#modal_msg_body_div').html($('.msgNextTabTrDiv').html()); 
			  $('.modal_msg_body').attr('style','');
			}
		} else {
			$('#modalpopup_form_popup').slideDown(900);
		}
		
		/*
		if( ($('.account_types').hasClass('active')) && (submitmsgVar !== undefined) && (submitmsgVar) && (submitmsgVar == 'intent_submitMsgOffPopuMsgInMobile')  ){
			$('#payment_form_id_ewallets').attr('target','_top');
		}
		*/
		
		//transID='';varTransID='';
		//$('#payment_form_id_ewallets').attr('target','payin_win');
		pendingCheckStartf('reStart');

		$form.get(0).submit();
		e.preventDefault(); 
	}
	catch(err) {
	  alert('ewallets=>'+err.message);
	}
});
	
	
	
	$('#payment_form_id_ngBankTransfer').submit(function(e) {
		var $form = $('#payment_form_id_ngBankTransfer');
		$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');
		$('#modalpopup_form_popup').slideDown(900);
		$form.get(0).submit();
		e.preventDefault();
	});
	
	$('#payment_form_id_ebanking').submit(function(e) {
		var $form = $('#payment_form_id_ebanking');
		$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');
		$('#modalpopup_form_popup').slideDown(900);
		$form.get(0).submit();
		e.preventDefault();
	});
	
	$('#payment_form_id_bhimupi').submit(function(e) {
		var $form = $('#payment_form_id_bhimupi');
		$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');
		$('#modalpopup_form_popup').slideDown(900);
		$form.get(0).submit();
		e.preventDefault();
	});

$(document).ready(function(){ 
	cardvalidorf();

	if($('#number').val()!=''){	
		/*
		var rep_ccno = $( "#number" ).val();
			str_ccno = rep_ccno.replace(/(\d{4}(?!\s))/g, "$1 ");				
		$("#number").val(str_ccno.trim()); 
		$('#number').focus().val($('#number').val());
		$('#number').trigger("keyup");
		$('#number').trigger("keypress");
		*/
		
		
		//expMonth.trigger("change");
		$('#expMonth').focus();
		$('#expMonth').trigger("focus");
		
		
		
		if(ajaxBinVar){
			ajaxBinCf(cardNumber.val().replace(/\s+/g, '').substring(0, 6));
		}
		
		//alert(cardNumber.val().replace(/\s+/g, '').substring(0, 6));
				
	}
	
	$('.modal_msg_close , .modal_msg_close3 , .modal_msg_close2').click(function(){
		modal_msg_close();
	});
	//modal_msg_close
	
	$('.upi_qr_border').click(function(){
		if(!$(this).hasClass('active')){
			generate_qr_codef();
		}
    });
	
	$('.paid_qrcode_link').click(function(){
		//alert('transID=>'+transID+', varTransID:=>'+varTransID);
		//fetch_trnsStatusf(varTransID,'paidCheck');
		$('.paid_qrcode_link').attr('onclick',"fetch_trnsStatusf('"+varTransID+"','paidCheck')");
    });	
	
	$('.paid_upiIntent_link').click(function(){
		//alert('transID=>'+transID+', varTransID:=>'+varTransID);
		//$('.paid_upiIntent_link').attr('onclick',"fetch_trnsStatusf('"+varTransID+"','paidCheck');modal_msg_close();");
    });

});
//$(".account_types").eq(0).trigger("click"); //send

function modal_msg_close(){
	$('#modal_msg').hide();
	$('#modal_msg').removeClass('active');
	$('.modal_msg_body').removeAttr('style');
	spinner_hide_f();
	//alert('666666');
}

$(document).keydown(function(e) {
	// ESCAPE key pressed
	if (e.keyCode == 27) {
		return false;
	}
	if(e.which === 122) {
		e.preventDefault();
		 return false;
	}

	if(e.ctrlKey && e.keyCode == 'E'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.shiftKey && e.keyCode == 'I'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.shiftKey && e.keyCode == 'J'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.keyCode == 'U'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.keyCode == 'S'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.keyCode == 'H'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.keyCode == 'A'.charCodeAt(0)){
		return false;
	}
	if(e.ctrlKey && e.keyCode == 'E'.charCodeAt(0)){
		return false;
	}
	
	if (e.keyCode == 123) {
		return false;
	}
	else if ((e.ctrlKey && e.shiftKey && e.keyCode == 73) || (e.ctrlKey && e.shiftKey && e.keyCode == 74)) {
		return false;
	}
	
});

</script>



<? if(isset($post['send'])&&$post['send']=="curl"){ ?>
<script language="javascript" type="text/javascript"> 
//$(".account_types").eq(2).trigger("click");
$('#payment_form_id input[name="ccno"]').trigger('keyup');
//$('#payment_form_id input[name=ccno]').keyup();
//cardvalidorf();
var $form = $('#payment_form_id');
$('#modalpopup_form_popup').slideDown(900);
$form.append('<input type="text" name="integration-type" style="display:none"  value="CHECKOUT" />');
$("#cardsend_submit .contitxt").text('Please wait ...');
//$form.get(0).submit();
</script>

<? } ?>

<script language="javascript" type="text/javascript"> 
		
	$(document).on('keyup', "input#number",function () {
	  var crdnumber = $(this).val().split(" ").join(""); // remove hyphens
	  if (crdnumber.length > 0) { crdnumber = crdnumber.match(new RegExp('.{1,4}', 'g')).join(" "); }
	  $(this).val(crdnumber);
	  //alert($('#number').val());
	  
	  
	   var g_card_name=$.payform.parseCardType(crdnumber);
	       if(g_card_name=="mastercard"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['mastercard_code'];?> text-danger');
			
			}else if(g_card_name=="visa"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['visa_code'];?> text-info');
			
			}else if(g_card_name=="amex"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['amex_code'];?> text-info');
			
			}else if(g_card_name=="rupay"){ 
			$('#input-card-icon').attr('class','');
			cardNumber.attr('class','form-control icon'+$.payform.parseCardType(cardNumber.val()));
			
			}else if(g_card_name=="discover"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['discover_code'];?>');
			
			}else if(g_card_name=="jcb"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['jcb_code'];?> text-success');
			
			}else if(g_card_name=="dinersclub"){
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['diners_code'];?> text-danger');
			
			}else{
			$('#input-card-icon').attr('class','<?=@$data['fwicon']['credit-card'];?>');
			}
			// End For display default card on card number box added by vikash on 200223
			
	});
	
	
	/*** Modify by Dev Tech : 23_06_28		****/
	
	function PosEnd(end) {
		var len = end.value.length;
		 // alert(len);
		// Mostly for Web Browsers
		if (end.setSelectionRange) {
			end.focus();
			end.setSelectionRange(len, len);
		} else if (end.createTextRange) {
			var t = end.createTextRange();
			t.collapse(true);
			t.moveEnd('character', len);
			t.moveStart('character', len);
			t.select();
		}
	}
		
	var upiAppName='';
	function checkIntentUrl(val)
	{
		//alert(val);
		if($('div,span,font').hasClass('appOpenName')){
			$('.appOpenName').html('"'+val+'"');
		}
			  
		pendingCheckStartf();	  
	}
	
	
	function checkupiapp(val)
	{
		//alert(val);
		if($('div,span,font').hasClass('appOpenName')){
			$('.appOpenName').html('"'+val+'"');
		}
		
		$('.mop_ajax_checkout').val('QRINTENT');
		
		upiAppName=val;
		
		$('.blank_display').html('');
		$('.intent_div_submit').html('');
		
		$('.intent_div_submit').hide(50);
		
		$('.intent_div_submit').html('<button type="submit" name="send123" value="CHANGE NOW!"  class="submitbtn btn btn-primary next w-100 float-end my-2 "><i></i><b class="contitxt loader-btn">Pay</b></button>');
		
		$('.intent_div_submit').show(1000);
		
		$('.upiAddressText').on("input", function(e) {
			var dInput = this.value;
			dInput = dInput.trim();
			//dInput = dInput.replace(/^\s+|\s+$/gm,'');
			///console.log(dInput);
			if(dInput && dInput.length > 2 )
			{
				$(this).parent().parent().parent().find('.submitbtn').show(1000);
			}else{
				$(this).parent().parent().parent().find('.submitbtn').hide(400);
			}
		   
		});
				  
	}
	
	function checkupi(val)
	{
		//alert(val);
		if($('div,span,font').hasClass('appOpenName')){
			$('.appOpenName').html('"'+val+'"');
		}
		
		$('.mop_ajax_checkout').val('UPICOLLECT');
		
		upiAppName=val;
		
		$('.blank_display').html('');
		$('.intent_div_submit').html('');
		
		var div_id_var ='#'+val+'_display';
		var radio_id_var ='#'+val+'_radio';
		$(radio_id_var).attr('checked', true);
		//$(div_id_var).html($("#upi_display").html());
		
		$(div_id_var).html('<div class="upiaddress_div ewalist common-payment-container"><div class="payment-form gpay-main"><div id="upi2IdRow" class="form-row form-row-space my-2"><div class="static-menu upiaddress_div"><input type="text" id="upiAddressText"  name="upi_address" class="upiaddress_div upiAddressText ewalist required upi-inp float-start" id="upi_address" placeholder="Enter UPI ID" maxlength="200" onfocusout="upiaddress_validf(this.value,\'.wallet_code_app\')"  value=""><span id="upi-suffix" class="gpay-adrate float-end " onclick="selectupi()"></span><input type="hidden" name="upi_address_suffix" id="upi-suffix-hidden" value="" /></div><div class="sbm-option"><ul id="upi-data-list" class="upi-data-list"></ul></div><button type="submit" name="send123" value="CHANGE NOW!"  class="submitbtn btn btn-primary next w-100 float-end my-2 hide"><i></i><b class="contitxt loader-btn">Pay</b></button></div></div></div>');
		
		
		
		
		//$('#upi_address_suffix').show(800);
		$('#upi_address, .upi_address').attr('placeholder','Enter UPI Address');
		$('#upi_address, .upi_address').attr('value','');
		$('.upi-li-list').remove();
		$('#upi-suffix, .upi-suffix').show(); 
		$('#upi-suffix, .upi-suffix').removeClass('icon-toggle'); 
		
		if(val=='qrcode')
		{
			$('#upi_address, .upi_address').hide();
			$('#upi_address, .upi_address').removeAttr('required');
			$('#upi_address, .upi_address').val('');
		}
		else 
		{
			$('#upi_address, .upi_address').show(800);
			//$('#upi_address[name="upi_address"], .upi_address[name="upi_address"]').attr('required','required');
			/*if(val) {
				$('#upi_address').val('@'+val);
			}
			*/
			//alert(val);
			//document.getElementById("upi_address_suffix").options.length = 0;
			if(val=='phonepe')
			{ 
				$('#upi-suffix, .upi-suffix').html('@ybl');
				$('#upi-suffix-hidden, .upi-suffix-hidden').val('@ybl');
				$('#upi-suffix, .upi-suffix').addClass('icon-toggle'); 
				
			}else if(val=='mobikwik')
			{
				$('#upi-suffix, .upi-suffix').html('@ikwik');
				$('#upi-suffix-hidden, .upi-suffix-hidden').val('@ikwik');
			}else if(val=='amazon')
			{
				$('#upi-suffix, .upi-suffix').html('@apl');	
				$('#upi-suffix-hidden, .upi-suffix-hidden').val('@apl');	
			}
			else if(val=='google')
			{
				
				$('#upi-suffix, .upi-suffix').html('@okicici');
				$('#upi-suffix-hidden, .upi-suffix-hidden').val('@okicici');
				$('#upi-suffix, upi-suffix').addClass('icon-toggle'); 
			}
			else if(val=='bhim')
			{
				$('#upi-suffix, .upi-suffix').html('@upi');
				$('#upi-suffix-hidden, .upi-suffix-hidden').val('@upi');
				
			}
			else if(val=='whatsapp')
			{
				$('#upi-suffix, .upi-suffix').html('@icici');
				$('#upi-suffix-hidden, .upi-suffix-hidden').val('@icici');
				$('#upi-suffix, .upi-suffix').addClass('icon-toggle'); 
			}else 
			{
				$('#upi-suffix, .upi-suffix').html('@'+val);
				$('#upi-suffix-hidden, .upi-suffix-hidden').val('@'+val);
				if((val=='paytm') || (val=='jio') || (val=='freecharge'))
				{
					$('#upi_address, .upi_address').attr('placeholder','Enter your mobile number');
					<? 
					if(isset($post['bill_phone'])&&$post['bill_phone']) 
					{
					?>
					$('#upi_address, .upi_address').attr('value','<?=isMobileValid($post['bill_phone']);?>');
					<?
					}
					?>
				}
			}
		}
		if(val=='other'){
			$('#upi_address, .upi_address').attr('placeholder','Enter UPI Address');
			$('#upi_address, .upi_address').val('');
			$('#upi-suffix, .upi-suffix').hide();
			$('#upi-suffix-hidden, .upi-suffix-hidden').val('');
		}
		
		$('.upiAddressText').on("input", function(e) {
			var dInput = this.value;
			dInput = dInput.trim();
			//dInput = dInput.replace(/^\s+|\s+$/gm,'');
			///console.log(dInput);
			if(dInput && dInput.length > 2 )
			{
				$(this).parent().parent().parent().find('.submitbtn').show(1000);
			}else{
				$(this).parent().parent().parent().find('.submitbtn').hide(400);
			}
		   
		});
		
		//$('.upiAddressText').focus();
				
		// ✅ Move focus to END of input field
		PosEnd(upiAddressText);
		
		  
		 
		  
	}
	
	

		

	function selectupi()
	{
	    
	    var upival = $("#upi-suffix").html();
		var otherVar='';
		if(upival=="@ybl" || upival=="@ibl" || upival=="@axl" ){
			var listdata='<li class="upi-li-list" onclick="livalclick1(\'@ybl\')"><span class="gpay-adrate float-end upi-select">@ybl</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@ibl\')"><span class="gpay-adrate float-end upi-select" >@ibl</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@axl\')"><span class="gpay-adrate float-end upi-select">@axl</span><input readonly="" class="text menu-input upi-inp" value=""></li>'+otherVar;
			$('#upi-data-list, .upi-data-list').html(listdata);
		} 
		else if(upival=="@okicici" || upival=="@okhdfcbank" || upival=="@oksbi" || upival=="@okaxis"){
			var listdata='<li class="upi-li-list" onclick="livalclick1(\'@okicici\')"><span class="gpay-adrate float-end upi-select" >@okicici</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@okhdfcbank\')"><span class="gpay-adrate float-end upi-select">@okhdfcbank</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@oksbi\')"><span class="gpay-adrate float-end upi-select" >@oksbi</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@okaxis\')"><span class="gpay-adrate float-end upi-select">@okaxis</span><input readonly=""  class="text menu-input upi-inp" value=""></li>'+otherVar;
			$('#upi-data-list, .upi-data-list').html(listdata);

		} 
		else if(upival=="@icici" || upival=="@waaxis" || upival=="@wahdfcbank" || upival=="@wasbi"){
			  
			var listdata='<li class="upi-li-list" onclick="livalclick1(\'@icici\')"><span class="gpay-adrate float-end upi-select">@icici</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@waaxis\')"><span class="gpay-adrate float-end upi-select">@waaxis</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@wahdfcbank\')"><span class="gpay-adrate float-end upi-select" >@wahdfcbank</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@wasbi\')"><span class="gpay-adrate float-end upi-select">@wasbi</span><input readonly=""  class="text menu-input upi-inp" value=""></li>'+otherVar;
			$('#upi-data-list, .upi-data-list').html(listdata);
		 }
		 else{
			 
		 } 
	}
		

$(document).ready(function(){
	
	/*** Modify by DevTech:22-12-19		****/
	$("#upi-suffix, .upi-suffix").click(function(){
	
		//var upival = $("#upi-suffix").html();
		var upival = $(this).text();
		//alert(upival);
		var otherVar='';
		//var otherVar='<li class="upi-li-list" onclick="livalclick1(\'other\')"><span class="gpay-adrate float-end upi-select">other</span><input readonly=""  class="text menu-input upi-inp" value=""></li>';
		
		//alert(upival);
		if(upival=="@ybl" || upival=="@ibl" || upival=="@axl" ){
			var listdata='<li class="upi-li-list" onclick="livalclick1(\'@ybl\')"><span class="gpay-adrate float-end upi-select">@ybl</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@ibl\')"><span class="gpay-adrate float-end upi-select" >@ibl</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@axl\')"><span class="gpay-adrate float-end upi-select">@axl</span><input readonly="" class="text menu-input upi-inp" value=""></li>'+otherVar;
			$('#upi-data-list, .upi-data-list').html(listdata);
		} 
		else if(upival=="@okicici" || upival=="@okhdfcbank" || upival=="@oksbi" || upival=="@okaxis"){
			var listdata='<li class="upi-li-list" onclick="livalclick1(\'@okicici\')"><span class="gpay-adrate float-end upi-select" >@okicici</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@okhdfcbank\')"><span class="gpay-adrate float-end upi-select">@okhdfcbank</span><input readonly="" class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@oksbi\')"><span class="gpay-adrate float-end upi-select" >@oksbi</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@okaxis\')"><span class="gpay-adrate float-end upi-select">@okaxis</span><input readonly=""  class="text menu-input upi-inp" value=""></li>'+otherVar;
			$('#upi-data-list, .upi-data-list').html(listdata);

		} 
		else if(upival=="@icici" || upival=="@waaxis" || upival=="@wahdfcbank" || upival=="@wasbi"){
			  
			var listdata='<li class="upi-li-list" onclick="livalclick1(\'@icici\')"><span class="gpay-adrate float-end upi-select">@icici</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@waaxis\')"><span class="gpay-adrate float-end upi-select">@waaxis</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@wahdfcbank\')"><span class="gpay-adrate float-end upi-select" >@wahdfcbank</span><input readonly=""  class="text menu-input upi-inp" value=""></li><li class="upi-li-list" onclick="livalclick1(\'@wasbi\')"><span class="gpay-adrate float-end upi-select">@wasbi</span><input readonly=""  class="text menu-input upi-inp" value=""></li>'+otherVar;
			$('#upi-data-list, .upi-data-list').html(listdata);
		 }
		 else{
			 
		 } 
	});	
	
});	

function livalclick1(val){
	//alert(val);
	if(val=="other"){
			  
		var listdata='<span class="upi-li-list-other" style="position:absolute;right:0px;" >@<input onkeypress="livalOtherf(this.value)" onfocusout="livalOtherf(this.value)" placeholder="Enter other value" class="text menu-input upi-inp" value="" style="min-width:60% !important;"></span>';
		$("#upi-suffix, .upi-suffix").html(listdata);
		$('#upi-suffix-hidden, .upi-suffix-hidden').val('');
		$('.upi-li-list').remove();
	 }
	 else{
		$("#upi-suffix, .upi-suffix").html(val); 
		$('#upi-suffix-hidden, .upi-suffix-hidden').val(val);
		$('.upi-li-list').remove();
	}
}		

function livalOtherf(val){
	$('#upi-suffix-hidden, .upi-suffix-hidden').val('@'+val);
}
$('#upi_address, .upi_address').on("input", function() {
  var dInput = this.value;
  console.log(dInput);
  //alert(dInput);
  $('.upi-inp').val(dInput);
});			
//////////New Added :///////////


function upiaddress_validf(val,theOption){
	var theOptionVar = $(theOption+' option:selected').val();
	if( ( theOptionVar == "other" || $('.appLogoDiv.other').hasClass('active') ) &&  (!val.match(/@/g)) ){
		alert('@ is missing this value');
		//$(this).focus();
		return false;
	} else if( (theOptionVar != "other" && !$('.appLogoDiv.other').hasClass('active') ) && (val.match(/@/g)) ){
		alert('Can not enter for @ in this value');
		//$(this).focus();
		return false;
	}
}


	
function isEmailAddr(email)
{
	var result = false
	var theStr = new String(email)
	var index = theStr.indexOf("@");
	if (index > 0)
	{
	var pindex = theStr.indexOf(".",index);
	if ((pindex > index+1) && (theStr.length > pindex+1))
	result = true;
	}
	return result;
}

//for Div show /Hide
function toggle_f(tiggleid){
	$(tiggleid).toggle();
}


			</script>
		</div>
	
	</div> <!-- payEEED paymentContainerDiv -->
	


			
<div class="toast toast-box hide" role="alert" aria-live="assertive" aria-atomic="true">
  <div class="toast-header"> <strong class="me-auto">View Details</strong>
    <button type="button" class="btn-close toast_button" data-bs-dismiss=".toast-box" aria-label="Close"></button>
  </div>
  <div class="toast-body">
    <? if(isset($_SESSION['bearer_token_id']) && $_SESSION['bearer_token_id'] ) { ?>
    <div class="text-muted fw-bold mx-2 fs10">Bearer Token : <? echo $_SESSION['bearer_token_id']?> </div>
    <? } ?>
    <div class="fullNmBar">
      <? if(isset($post['fullname']) && $post['fullname'] ) { ?>
      <i class="<?=@$data['fwicon']['profile'];?> px-2 py-1 fa-fw"></i>&nbsp;&nbsp;<? echo $post['fullname']?>
      <? } ?>
    </div>
    <div class="emailBar">
      <? if(isset($post['bill_email']) && $post['bill_email'] ) { ?>
      <i class="<?=@$data['fwicon']['email'];?> px-2 py-1 fa-fw"></i>&nbsp;&nbsp;<? echo $post['bill_email']?>
      <? } ?>
    </div>
    <div class="mobileBar">
      <? if(isset($post['bill_phone']) && $post['bill_phone'] ) { ?>
      <i class="<?=@$data['fwicon']['mobile'];?> px-2 py-1 fa-fw"></i>&nbsp;&nbsp;<? echo $post['bill_phone']?>
      <? } ?>
    </div>
    <? if(isset($post['bill_address']) && $post['bill_address'] ) { ?>
    <div class="text-muted fw-bold mx-2 fs10">Address : <? echo @$post['bill_address']?> <? echo @$post['bill_city']?> <? echo @$post['bill_state']?> <? echo @$post['bill_country']?> </div>
    <? } ?>
    <?php /*?> <? if(isset($post['product_name'])&&$post['product_name']){ ?>			
<div class="my-2 text-center"><span class="text-muted fw-bold">Payment for <?=@$post['product_name'];?></span></div>
<? } ?><?php */?>
  </div>
</div>
<div class="toast bill_amt-toast-box hide" role="alert" aria-live="assertive" aria-atomic="true">
  <div class="toast-header"> <strong class="me-auto">Order Summary</strong>
    <button type="button" class="btn-close toast_button" data-bs-dismiss=".bill_amt-toast-box" aria-label="Close"></button>
  </div>
  <div class="toast-body">
    <table class="table">
      <tbody>
        <tr class="fw-lighter">
          <td>Bill Amount</td>
          <td class="text-end px-2"><?=@$post['curr']?$post['curr']:$_SESSION['curr'];?>
            <?=(@$post['total']?$post['total']:$post['bill_amt'])?></td>
        </tr>
        <tr>
          <td>Total Amount</td>
          <td class="text-end px-2"><?=@$post['curr']?$post['curr']:$_SESSION['curr'];?>
            <?=(@$post['total']?$post['total']:$post['bill_amt'])?></td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
<footer class="footer mt-auto">
  <div class="container-flex">
    <div class="b-example-divider align-middle p-2 rounded-bottom" style="height:auto !important;float:left;width:100%;">
      <div class="float-start account-pop pointer py-2 mt2px" title="View Details">View Details <i class="<?=@$data['fwicon']['angle-up'];?> align-middle mx-1"></i></div>
      <div class="float-end py-2 mt2px">Powered by &nbsp;
	  <? 
	$poweredby="";
	
	// $_SESSION['domain_server']['subadmin']['domain_name'] use for display domain 
	if(isset($_SESSION['domain_server']['as']['SiteName'])&& $_SESSION['domain_server']['as']['SiteName']){
	$poweredby.='<span class="font-monospace fw-bold">'.prntext(@$_SESSION['domain_server']['as']['SiteName']).'<span>';
	}
	
	
	if(isset($_SESSION['domain_server']['subadmin']['upload_logo'])&& $_SESSION['domain_server']['subadmin']['upload_logo']){ 
	$poweredby.='<img src="'.encode_imgf($_SESSION['domain_server']['LOGO']).'" class="logo-img rounded" alt="Logo" style="max-height: 20px;"/>';
	}
	
	?>
	<?=@$poweredby;?>
      </div>
    </div>
  </div>
</footer>

<script>
$(document).ready(function(){ 

    // For Show account tost box by Vikash
	$('.account-pop').on('click', function () { 
		$(".toast-box").toggle();
    });
	
	// For Show bill_amt tost box by Vikash
	$('.bill_amt-pop').on('click', function () { 
		$(".bill_amt-toast-box").toggle();
    });
	
	$('.toast_button').click(function(){
		var fdata = $(this).attr("data-bs-dismiss");
		$(fdata).hide();
    });
	
	$(".view_all_upi").click(function(){
		$(".view_all_upi").hide();
		$(".view_upi").toggle();
    });
	
	// For i have paid button refresh
	
	$(".button_refresh").click(function(){
		
		    $('.button_refresh').html('<i class="fa-solid fa-spinner fa-spin-pulse text-success"></i>');
			
			setTimeout(
            function() 
            {
            $('.button_refresh').html('I have paid');
            }, 1000);
    });

	
    // For Hide language translator loader by Vikash
   setTimeout(function(){
	   $(".skiptranslate").next().css( "display", "none" );
	   let head = $(".skiptranslate").contents().find("head");
	   let css = '<style> .indicator{ padding-right: 5px !important;} </style>';
	   $(head).append(css);
   },2000); 
   
   $("#field").keypress(function(e) {
    if (!valid)
        e.preventDefault();
   });
   
});  
   



</script>

	
	</div>
	
	

	
	
</div>



<?//Dev Tech : 23-07-07 Popup for pending message  ?>
<div class="modalpopup_processing hide" id="modalpopup_processing_for_pending">
	<div class="position-absolute1 buttom-50 start-50 translate-middle" style="min-width: 375px;max-width: 400px;margin:0 auto;position: fixed;bottom: 0;">
	  <div class="modalpopup_form_popup_layer"> </div>
	  
	  <div class="modalpopup_form_popup_body row bg-light" style="top:-240px;">
	  
	  <a class="close_popup modal_popup_close processing_close" onClick="document.getElementById('modalpopup_processing_for_pending').style.display='none';" style="color:#000!important;background:#fff;right: 10px;top:0px;position:absolute;z-index:999999;border:0px solid #ff0000;">×</a>
	  
		<div id="modalpopup_processing_for_pending_div" class="row p-0" >
		 
		    
		    <div class="sploop hide1">
			  <div class="row1 center">
				<i class="fa-solid fa-spinner fa-spin-pulse fa-2x text-loader"></i>
			  </div>
			  <div class="row">
				<p class="hide"  style="font-size:16px;font-weight:bold;color:#3f3f3f;float: left;width:100%;clear:both;line-height:30px;padding:0px 0 0 0;">Processing for pending payment...</p>
				<p class="pen_bod1 bg-light" style="font-size:12px;font-weight: normal;color:#3f3f3f;float:left;width:100%;clear:both;line-height: 14px;">This will take a few seconds</p>
				<p class="pen_bod"> </p>
				
			  </div>
			</div>
			
			
			
			
		</div>
		
	  </div>
  </div>
</div>



<?//Dev Tech : 23-07-07 Popup for processing message  ?>
<div class="modalpopup_processing hide" id="modalpopup_processing">
	<div class="position-absolute1 buttom-50 start-50 translate-middle" style="min-width: 375px;max-width: 400px;margin:0 auto;position: fixed;bottom: 0;">
	  <div class="modalpopup_form_popup_layer"> </div>
	  
	  <div class="modalpopup_form_popup_body row">
	  
	  <a class="close_popup modal_popup_close processing_close" onClick="document.getElementById('modalpopup_processing').style.display='none';" style="color:#000!important;background:#fff;left: 10px;top:-40px;position:absolute;z-index:999999;right:unset;">×</a>
	  
		<div id="modalpopup_processing_div" class="row p-0" >
		  <div class="row1 center">
			<i class="fa-solid fa-spinner fa-spin-pulse fa-5x text-loader"></i>
		  </div>
		  <div class="row">
			<p style="font-size:16px;font-weight:bold;color:#3f3f3f;float: left;width:100%;clear:both;line-height:30px;padding:12px 0 0 0;">Processing payment...</p>
			<p style="font-size:12px;font-weight: normal;color:#3f3f3f;float:left;width:100%;clear:both;line-height: 14px;">This will take a few seconds</p>
		  </div>
		</div>
		
	  </div>
  </div>
</div>


