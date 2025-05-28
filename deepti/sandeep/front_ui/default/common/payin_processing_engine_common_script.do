<??>

<?

$post['bill_amt']=(isset($post['total'])&&$post['total']?$post['total']:(isset($post['bill_amt'])?$post['bill_amt']:''));

$sub_icon_more='<span class="qr_icon_1" style="position:relative;top:4px;margin:0 10px 0 0;"><i class="'.$data['fwicon']['qrcode'].' text-info" title="UPI Payment"></i> <i class="'.$data['fwicon']['qrcode'].' icon-position" title="UPI Payment"></i></span>'."<img src='".$data['bankicon']['google-pay-svg']."' alt='google-pay'>&nbsp;<img src='".$data['bankicon']['phonepe-svg']."' alt='phonepe'>&nbsp;<img src='".$data['bankicon']['paytm-svg']."' alt='paytm'> & More";

$browserOs1=browserOs("1"); $browserOs=json_encode($browserOs1); 
$setBrowserName='safari'; //safari mozilla	chrome

//$_SESSION['re_post']=unset_array($_SESSION['re_post'], ['bid','user']);

?>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 

<div class="hide paymentContainerDiv_load" id="paymentContainerDiv_load" style="display:none !important">
	
</div>
<div class="hide" style="display:none">
	<div class="alert_msg_2" title="No Payment Chanel Available to process this card">No Payment Chanel Available to process this card</div><div class="alert_msg_3" title="Please enter correct CVV">Please enter correct CVV and cannot empty </div>
</div>


<script language="javascript" type="text/javascript"> 
var wn=0; var ajaxBinVar=0; var logs=[];

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



/* screen height calculator as per content 
	heightCalcf('.processall');
	heightCalcf(theHeightVar,preStyleVar);
  */
 var theHeightVar=''; var preStyleVar='';
function heightCalcf(theHeight='.processall',preStyle='max-width:375px;margin:0 auto;width:100% !important;'){
	
	 theHeightVar=theHeight;  preStyleVar=preStyle;
	 
	var contentHeight = parseFloat($(theHeight).height());
	//var screenHeight = parseFloat(window.screen.height);
	var screenHeight = parseFloat($(window).height());
	if(wn)
	{
		alert('contentHeight=>'+contentHeight+', screenHeight=>'+screenHeight);
	}
	if(contentHeight > screenHeight){
		$(theHeight).attr('style',preStyle+'transform : translate(-50%,10px) !important;top:0px !important;');
	}
	else {
		$(theHeight).attr('style',preStyle+'transform : translate(-50%,-50%) !important;top:50% !important;');
	}
}


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

var checkout_url ="<?=@$data['Host']?>/checkout<?=@$data['ex']?>";  




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
//alert("fetch_trnsStatusf=> "+transID);
	
	$.ajax({url: fetch_trnsStatus+"?actionurl=viasystem&transID="+transID, type: "GET", dataType: 'json', success: function(result){
	    //alert(fetch_trnsStatus);
	    //alert(JSON.stringify(result));  
	    //alert(result["order_status"]);
		//result["order_status"]=1;
		
		var success_status = "";
		
		if(result["order_status"] && ( result["order_status"] == 1 || result["order_status"] == 9) )
		{
			success_status = "success";
		}
		else if((result["order_status"] && (result["order_status"] == 2 || result["order_status"] == 22 || result["order_status"] == 23)))
		{
			failed_status = "failed";
		}
		
		if( (statusCheckStart=='1') && ((result["order_status"] && ( result["order_status"] == 1 || result["order_status"] == 9 ) ) || (failed_status && failed_status == "failed")) )
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
						//$('.click-to-redirect').hide();
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
				
				setTimeout(function(){ 
					heightCalcf(theHeightVar,preStyleVar);
				}, 900); 
		
				
				
					
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
			
			var responce_box = '<div class="my-0 text-center rounded"><i class="<?=@$data['fwicon']['circle-info']?>  my-1 fa-4x txt_2"></i></div>';
			
			responce_box += '<div class="' + qr_trans_status_bg + ' roundedx pt-2">';
			
			//responce_box +='<div class="my-1 text-center text-light fs-6">' + qr_trans_status + '</div>';
			
			responce_box +='<div class="bg_2 py-2 mb-1 text-center text-light fw-bold fs-6 font-monospace clrs float-start ps-1 w-100"> We are verifying your payment status... </div>';
			
			responce_box +='<div class="bg-light">';
			
			responce_box +='<div class="my-1 text-center rounded" style="font-size:10px;position:relative;top:8px !important;margin-bottom:14px !important;">Approve Payment Within <i class="fa-solid fa-spinner fa-spin-pulse fa-0x text-loader"></i> <span  class="proccess_timer timerCount" style="display:none1">5:00</span></div>';
			
			responce_box +='<div class="mt-0 fw-bold px-2 text-muted fs-8 text-truncate"> ' + result["response"] + ' </div>';
			responce_box +='<div class="px-2 text-muted">' + result["tdate"] + '</div>';
			
			if(result["reference"] != ""){
				responce_box +='<div class="fw-bold text-muted p-1"><span id="ref_copy" > Reference No ' + result["reference"] + '</span> <i class="fa-solid fa-copy" onclick="ctcf(\'#ref_copy\')" ></i></div>';
			}
			
			responce_box +='<div class="fw-bold text-muted p-1"><span id="tid_copy" > TransID ' + result["transID"] + '</span> <i class="fa-solid fa-copy" onclick="ctcf(\'#tid_copy\')" ></i></div>';
				
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
			
			setTimeout(function(){ 
				heightCalcf(theHeightVar,preStyleVar);
			}, 900); 
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
		}, 1500);
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

/* Dev Tech : 23-08-28 skip the get acquirer status in checkout page as one minute interval timer via check_acquirer_status_in_realtime is f */
var check_acquirer_status_in_realtime = 't';

var order_status = 0;
function webhook_statusf(){
	
	if(typeof(transID) != 'undefined' && transID != null && check_acquirer_status_in_realtime == 't')
	{
		//alert("webhook_statusf=> "+curl_status+"\r\check_acquirer_status_in_realtime=> "+check_acquirer_status_in_realtime);
		
		$.ajax({url: curl_status+"&transID="+transID, type: "GET", dataType: 'json', success: function(result){
			//alert(result);
			//alert("webhook_statusf=> "+result["order_status"]);
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
		//$('.paid_qrcode_link').show();
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
	
	$('.submit_div.text-muted #cardsend_submit').removeAttr('disabled');
	$('.submit_div.text-muted .contitxt').html('Retry');
	clearIntervalf();
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
	var thisData=postQuery+'&'+form.serialize();
	//var url = form.attr('action');
	//var url = window.location.href;
	
	var url=checkout_url+'?'+thisData;
	
	if(wn)
	{
		thisUrl=url+"?"+thisData;
		window.open(thisUrl, '_blank');return false;
	}
	
	$.ajax({
		//type: "POST",
		url: url,
		data: thisData,
		success: function(data) {
			$DONE_AJAX='';
			if (typeof data === 'string') {
				data = ($.trim(data.replace(/[\t\n]+/g, '')));
				if(data.match('googleapis|img|DONE_AJAX')){
					$DONE_AJAX='DONE_AJAX';
				}
			}
			else if (typeof data === 'object' && data !== null) {
				if(stringifyf(data['transID'])) { transID = stringifyf(data['transID']); }
				 if(stringifyf(data['varTransID'])) { varTransID = stringifyf(data['varTransID']); }
				 if(stringifyf(data['varReferenceNo'])) { varReferenceNo = stringifyf(data['varReferenceNo']); }
				 if(stringifyf(data['trans_auto_expired'])) { trans_auto_expired = stringifyf(data['trans_auto_expired']); }
				 
				if(stringifyf(data['DONE_AJAX'])){
					$DONE_AJAX='DONE_AJAX';
				}
			}
			
			logr=data;
			//alert(data);
			
			if($DONE_AJAX=='DONE_AJAX'){
				spinner_show_f();
				$('#modalpopup_form_popup').hide(10);
				$('.upi_qr_border').html(data);
				
				//var qrTransID="TransID : " + transID;
				//var ReferenceNo="Reference No : " + varReferenceNo;
				
				//alert(qrTransID);
				//alert(ReferenceNo);
				if(varReferenceNo != ""){
					var ReferenceNo="Reference No : " + varReferenceNo;
				}else if(transID != ""){
					var ReferenceNo="TransID : " + transID;
				}else{
					var ReferenceNo="Bearer Token : <?=@$_SESSION['bearer_token_id']?>";
				}
				
				
				$('.qrTransID').html(ReferenceNo);
				$('.QR_Code_is_valid').hide();
				
				
				timer_base_statusf();
			   
				//$('.paid_qrcode_link').attr('onclick',"fetch_trnsStatusf('"+transID+"','paidCheck')");
				
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
					//fetch_trnsStatusf(transID,'','failed');
					processing_closef();
				}, timeLeft);
				//setInterval(updateTimer, 1000);
				
				
			 <?/*?>
				
				//  check auto status after each 30 sec.
				const timeID = setInterval(callrepeatedfunction, 30000);

                function callrepeatedfunction() 
				{
					console.log(new Date());
					//alert("status check");
					
					$('.paid_qrcode_link').trigger("click","fetch_trnsStatusf('"+transID+"','paidCheck')");
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
	var thisData=postQuery+'&'+form.serialize();
	//var url = form.attr('action');
	//var url = window.location.href;
	
	var url=checkout_url+'?'+thisData;
	
	if(wn)
	{
		thisUrl=url+"?"+thisData;
		window.open(thisUrl, '_blank');return false;
	}
	
	$.ajax({
		//type: "POST",
		url: url,
		data: thisData,
		dataType: 'json', // text
		success: function(data) {
			//data = ($.trim(data.replace(/[\t\n]+/g, '')));
			//alert(data);
			logs=data;
			//alert(stringifyf(data['DONE_AJAX'])); alert(stringifyf(data['transID']));
			 
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
	/*
	var url = window.location.href;
	
	if(url.match('/payme')){
		url=checkout_url;
	}
	*/
	
	var thisData=postQuery+'&'+form.serialize();
	
	var url=checkout_url+'?'+thisData;
	
	if(wn)
	{
		thisUrl=url+"?"+thisData;
		window.open(thisUrl, '_blank');return false;
	}
	
	$.ajax({
		//type: "POST",
		url: url,
		data: thisData,
		success: function(data) {
			data = ($.trim(data.replace(/[\t\n]+/g, '')));
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
				
				//$('.paid_upiIntent_link').attr('onclick',"fetch_trnsStatusf('"+transID+"','paidCheck');modal_msg_close();");
				
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





function closePayinWindow() {
	payin_win.close();
}

function ajaxFormf(Channel='', mop='', form_id='payment_form_id_ewallets'){
	
	
	$('.actionajax').val('ajaxJsonArray');
	$('.mop_ajax_checkout').val(mop);
	
	
	$('.paid_qrcode_button').html("<i class='<?=@$data['fwicon']['spinner'];?>  fs-1 fa-spin-pulse text-info' style='font-size:12px !important;float:left;padding:3px 0;'></i>");
	spinner_show_f();
	
	transID='';
	varTransID='';
	trans_auto_expired=299892;
	
	logs2={"Channel":Channel,"mop":mop,"form_id":form_id};
	
	//var form = $("#payment_form_id_ewallets");
	var form = $("#"+form_id);
	
	var thisData=postQuery+'&'+form.serialize();
	
	//var url = form.attr('action');
	
	/*
	var url = window.location.href;
	
	if(url.match('/payme')){
		url=checkout_url;
	}
	*/
	
	var url=checkout_url+'?'+thisData;
	
	if(wn)
	{
		thisUrl=url+"?"+thisData;
		window.open(thisUrl, '_blank');return false;
	}
	
	$.ajax({
		//type: "POST",
		url: url,
		data: thisData,
		dataType: 'json', // text
		success: function(data) {
			//data = ($.trim(data.replace(/[\t\n]+/g, '')));
			//alert(data);
			logs=data;
			//alert(stringifyf(data['DONE_AJAX'])); alert(stringifyf(data['transID']));
			 
			 //return false;
			 if(stringifyf(data['transID'])) { transID = stringifyf(data['transID']); }
			 if(stringifyf(data['transID'])) { varTransID = stringifyf(data['transID']); }
			// if(stringifyf(data['varTransID'])) { varTransID = stringifyf(data['varTransID']); }
			 if(stringifyf(data['varReferenceNo'])) { varReferenceNo = stringifyf(data['varReferenceNo']); }
			 if(stringifyf(data['trans_auto_expired'])) { trans_auto_expired = stringifyf(data['trans_auto_expired']); }
			 
			 
			 //for check error validation via server side 
			 if(stringifyf(data['Message'])) { Message = stringifyf(data['Message']); }
			 if(stringifyf(data['Error'])) { Error = stringifyf(data['Error']); }
			 
			 if( typeof(Error) != 'undefined' && Error != null && Error !="" && typeof(Message) != 'undefined' && Message != null && Message !="" ){ 
				alert(Message);
				spinner_hide_f();
				//$('#modalpopup_form_popup').hide(); 
				return false;
			 }
			 
			 
			// done request 
			
			if(stringifyf(data['DONE_AJAX']))
			{
				
				
				var html_data = stringifyf(data['html_data']);
				var auth_3ds2 = stringifyf(data['auth_3ds2']);
				var realtime_response_url = stringifyf(data['realtime_response_url']);
				var UPICOLLECT = stringifyf(data['UPICOLLECT']);
				
				var check_asr = stringifyf(data['check_acquirer_status_in_realtime']);
				if( typeof(check_asr) != 'undefined' && check_asr != null && check_asr !="" ){ 
					check_acquirer_status_in_realtime = check_asr;
				}
			 
			 
				
				if(Channel=='11' && typeof(html_data) != 'undefined' && html_data != null && html_data !="" ){
					$('.IndiaBankTransfer_details').html(html_data);
				}
				else if(typeof(UPICOLLECT) != 'undefined' && UPICOLLECT != null && UPICOLLECT =="Y" ){
					pendingCheckStartf('reStart'); 
				}
				else if(  typeof(auth_3ds2) != 'undefined' && auth_3ds2 != null && auth_3ds2 !="" ){
					var testcardno = stringifyf(data['testcardno']);
					if( typeof(testcardno) != 'undefined' && testcardno != null && testcardno !="" ){ 
						//alert("Channel=> "+Channel+", mop=> "+mop+", card_type=> "+stringifyf(data['card_type'])+", testcardno=> "+stringifyf(data['testcardno'])+", auth_3ds2=> "+stringifyf(data['auth_3ds2'])); 
					} 
					else { 
						pendingCheckStartf('reStart'); 
					} 
					
					var payinScreenWidth = parseFloat($(window).width())-75;
					var payinScreenHeight = parseFloat($(window).height())-10;
	
					//payin_win = window.open(auth_3ds2, '_blank');
					payin_win = window.open(auth_3ds2, 'payin_win','titlebar=no,scrollbars=yes,resizable=yes,top=20,left=20,width='+payinScreenWidth+',height='+payinScreenHeight+'');
					return false;
				}
				else if( typeof(realtime_response_url) != 'undefined' && realtime_response_url != null && realtime_response_url !="" )
				{
					pendingCheckStartf('reStart');
					
					var realtime_response_url = stringifyf(data['realtime_response_url']);
					
					
					/* Dev Tech : 23-08-25 push for real time response for indentify  crossfireresponse_value */
					
					$("#paymentContainerDiv_load").load(realtime_response_url, {"action":"notify","cron_tab":"cron_tab","crossfireresponse_value":"yes"}, function(responseTxt, statusTxt, jqXHR){
						
						if(statusTxt == "success"){
							//pendingCheckStartf();
							//alert("success!");
						}
						else if(statusTxt == "error"){
							//pendingCheckStartf();
							//alert("error!");
						}
					});
					
					//$(".paymentContainerDiv").html('<div class="position-relative py-4 mt-4"><div class="position-absolute bottom-50 end-50"><i class="fa-solid fa-spinner fa-spin-pulse fa-4x text-loader text-center mt-4"></i></div></div>');
				
					
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
			//data = ($.trim(data.replace(/[\t\n]+/g, '')));
			// Some error in ajax call
			//alert("ajaxFormf request");
			logs=data;
			//alert(stringifyf(data)); alert(stringifyf(data['responseText']));
			
			var responseText = stringifyf(data['responseText']);
			
			if( typeof(responseText) != 'undefined' && responseText != null && responseText !="" && responseText.match('error|Error|Scrubbed') ) {
				 ErrorVar=responseText;
				alert(responseText);
			}
			else {
				alert("some Error via request");
			}
			spinner_hide_f();
		}
		
		
	});
}





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


function showPaymentMethod(){
	$('#paymentMethodChange').hide(100);
	$('#otherPaymentMethod').show(100);
	$('.avai_h4').show(1000);
	$('.inputype').removeClass('hide');
	$('.inputype').removeClass('active');
	$('.account_types').removeClass('active');
	$('.pay_div').slideUp(100);
}
	

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
	
	
	
	setTimeout(function(){
		$(".goog-te-combo option:first-child").text('English');
		$('.translateDiv').show(100);
   },2000);


	
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
	
	
	// Intent Auto hit 
	/*
	setTimeout(function(){
		if( $('div').hasClass('intent_push') && $(".account_types").length == 1 && billerEmpaty=='' ){
			//alert('intent_push===');
			$('.intent_push').addClass('active');
			generate_intent_array_urlf();
		}
    },1200);
	*/
	

}); // end document ready




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




	
//////////////////Start for watch display		
		// for header watch time format
function formatAMPM(date) {
	var hours = date.getHours();
	var minutes = date.getMinutes();
	var seconds = date.getSeconds();
	var ampm = hours >= 12 ? 'PM' : 'AM';
	hours = hours % 12;
	hours = hours ? hours : 12; // the hour '0' should be '12'
	hours = hours < 10 ? '0'+hours : hours;
	minutes = minutes < 10 ? '0'+minutes : minutes;
	seconds = seconds < 10 ? '0'+seconds : seconds;
	var strTime = hours + ':' + minutes + ':' + seconds + ' ' + ampm;
	return strTime;
}

function format24(date) {
    var hours = date.getHours();
	var minutes = date.getMinutes();
	var seconds = date.getSeconds();
	var ampm = hours >= 12 ? 'PM' : 'AM';
	hours = hours % 24;
	hours = hours ? hours : 0; // the hour '0' should be '12'
	hours = hours < 10 ? '0'+hours : hours;
	minutes = minutes < 10 ? '0'+minutes : minutes;
	seconds = seconds < 10 ? '0'+seconds : seconds;
	var wicon = "";/*<i class='<?=@$data['fwicon']['clock'];?>' aria-hidden='true'></i> */
	//alert (wicon);
	var strTime = wicon + hours + ' : ' + minutes + ' : ' + seconds + '  ' +  ampm;
	return strTime;
}



setTimeout(function(){ 
	//$('.goog-te-gadget').css("color", "var(--color-4)");
	$('.goog-logo-link').css("display", "none");
},600); 


$('.language-collapse').on('click', function () { 
	
	if($('#google_translate_element').css('display')=="none"){
	$('#google_translate_element').css("display", "");
	//$('.goog-te-combo').attr('size',1);
	
	//var se=$(".goog-te-combo");
	//se.show();
	//se[0].size=10;
	
	}else{
	$('#google_translate_element').css("display", "none");
	}

});
	
	
	
</script>

<style>
#modalpopup_processing_for_pending .position-absolute1 {z-index:999 !important;}

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


</style>

