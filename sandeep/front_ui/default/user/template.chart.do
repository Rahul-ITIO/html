<? if(isset($data['ScriptLoaded'])){ ?>

<style>
processall { padding-left:0px; padding-right:0px;}

.translateDiv{display:none;clear:both;position:relative;z-index:99;float:left;margin:0 0 10px 0;background: url("<?php echo $data['Host'];?>/images/lang_4.png") <?=$s_background_g_del;?> no-repeat; background-size:18px; background-position:left;}

#google_translate_element {width: 85px;float:left;display:block;margin:0px 0 0 23px ;clear:both;overflow:hidden;height:40px; border:0 !important; }

#google_translate_element select {content: ''; border:0 !important; -webkit-appearance: menulist;-moz-appearance:menulist;padding: 0px 0px;font-weight:bold;color:#d07c00 !important;background: var(--background-1);color:color: var(--color-1) !important;margin:0 0 0 0px;}
			

#google_translate_element select:focus {outline: unset !important;}
.skiptranslate iframe {display:none !important;}

input[type=password],input[type=text],input[type=tel], input[type=email], input[type=url], select, label.input2 {text-align: left;font-size: 13px;line-height: 36px;height: 36px;width: 98% !important;color: #333 !important;margin: 0;/*padding: 3px 0 3px 2%;*/}
h1 {float:left;width:100%;border-bottom:2px solid #ccc;padding:0 0 20px 0;margin:0 0 20px 0;font-weight:normal;}

.warper_div {
	float:left;display:block;width:100%;padding:0px;margin:10px auto; background-color:#fff;border:4px solid #ccc;border-radius:7px;
}

.red {color:red;}
.qr_code {}
.coins_amt {float:right;text-align:right;}
.bch {font-size:24px;font-weight:bold;color:#000;}
.none_bch {font-size:18px;font-weight:bold;color:#999;}
.address_coins {}
.qr_code_div {}
.warper_master {padding:20px 40px 20px 20px;}
.iHavPaid1 {/*float:left;width:100%;*/}
.iHavPaid{/*float:right;background:#da8f05;padding:10px 30px;font-size:18px;color:#fff;text-decoration:none;border-radius:5px*/}

@media (max-width: 500px) {
processall { padding-left:5px !important; padding-right:5px !important;}
}

</style>

</head>
<body oncontextmenu='return false;'>
<script src="<?=$data['Host2']?>/js/qrcode.min.js"></script>	
<script type="text/javascript">
var processed = "<?php echo $processed;?>";
//alert(processed);
function CopyToClipboard2(text) {
			text=$(text).html();
			var $txt = $('<textarea />');

            $txt.val(text)
                .css({ width: "1px", height: "1px" })
                .appendTo('body');

            $txt.select();

            if (document.execCommand('copy')) {
                $txt.remove();
				alert("copied");
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
	
	

	
	$(document).ready(function() {
		timeLeft = 899678; // 15 min = 59978.53333333333 * 15 ;
		//timeLeft = 9000;
		setTimeout(function(){ 
			//alert(processed); 
			top.window.location.href=processed;
		}, timeLeft);
		
		timer = $('#timer');
		setInterval(updateTimer, 1000);
		var qr = $('#btc-qr');
		/*
		
		var data = 'bitcoin:<?php echo $_SESSION['r_coins']['bitcoinAddress'];?>?amount=<?php echo $_SESSION['r_coins']['bitcoinAmount'];?>';
		
		*/
		var data = "<?php echo $_SESSION['r_coins']['bitcoinAddress'];?>";
		if (qr.length && data != null && data.length > 0) {
			qr.html('');
			var qrcode = new QRCode(
				'btc-qr',
				{
					text : data,
					width : 200,
					height : 200,
					colorDark : "#000000",
					colorLight : "#ffffff",
//					correctLevel : QRCode.CorrectLevel.M
				});
		}
	});
</script>
<div class="processall container  my-2">
    <div class="content_top" style="">
	  
     <div class="border_con">
        <div id="MainDivvkg" class="row slidePaymentDiv">
            <div class="col-sm-6 bg-vlight border border-primary rounded ps-0 mb-2">
		    <div class="row">
            <div class="translateDiv col-sm-12 m-0 bg-primary">
			<i class="<?=$data['fwicon']['globe'];?> text-vdark mx-2" style="margin-top: 12px;"></i>
              <div id="google_translate_element"></div>
              <script language="javascript" type="text/javascript"> 
			function googleTranslateElementInit() {
			  new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
			  }
			</script>
              <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
              <? //setcookie('googtrans', '/en/hi');?>
              <? 
				//if(isset($_SESSION['post']['checkout_language'])){
					//setcookie('googtrans', '/en/'.$_SESSION['post']['checkout_language']);
				//}
			?>
              
            </div>
            
            			
            			</div>
            <div class="col-sm-12 row">
				<div class="address">

                        <div class="">
                            <p class="fw-bold ps-2">Transaction Details</p>
							<div class="inputWithcheck mx-2"> <input class="form-control w-100 border border-2" style="background-color: #ffffff !important;width: 100% !important;" type="text" value="Pay <?php echo $_SESSION['r_coins']['bitcoinAmount'];?> <?=$data['coinName'];?>" readonly="">  </div>
                           
                        </div>
                        <div class="d-flex flex-column dis px-2">
                            <div class="d-flex align-items-center justify-content-between mt-2">
                                <p>Pay To :</p>
                                <p><strong><?=$data['coinTitle'];?></strong></p>
                            </div>
                            
							<div class="hide" id="conveniencDivIp" style="display:none"></div>
							 							
							
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <p>Amount :</p>
                                <p class="fw-bold"><?php echo $_SESSION['r_coins']['amount'];?> <?php echo $_SESSION['r_coins']['currency'];?></p>
                            </div>
							
							<div class="d-flex align-items-center justify-content-between mb-2">
							<p class="fw-bold">Total Amount: </p>
                            <p class="fw-bold text-primary"><span id="totalAmount_txt" style="font-size: 20px !important;"><?php echo $_SESSION['r_coins']['bitcoinAmount'];?> <?=$data['coinName'];?></span></p></div>
                            
                        </div>
                    </div>
               
			   

				
				
                
              
            </div>
            
          </div>
		  
            
			<div class="col-sm-6 rounded bg-primary  mb-2">
<div class="row border rounded 44 bg-vdark m-2 text-start vkg">		 
	<div class="text_place m-2 px-2 text-white" >
		<p>Please transfer the exact amount of <strong><?php echo $_SESSION['r_coins']['bitcoinAmount'];?> <?=$data['coinName'];?></strong> to the <?=$data['coinName'];?> address shown on this page in one transaction.</p>
		<p>The Network protocol type to be used for this transfer should be: <b><?php echo $_SESSION['r_coins']['netWorkType'];?></b> </p>
		<p>The amount must be exactly the same, otherwise refunds and processing issues are possible. The amount must be paid in one transaction only, payments in multiple transactions are not supported.</p>
		
		<p>The funds will be credited to your wallet as soon as we get 6 confirmations from the <?=$data['coinTitle'];?> network.</p>
	  
		<p><b><span class="red">Attention!</span> Once the Payment is sent successfully from your <?=$data['coinName'];?> wallet. Click on I have paid button below.</b></p>
		
		
	</div>	
	<div class="qr_code_div">
		<div class="coins_amt">
			<div class="bch hide"><?php echo $_SESSION['r_coins']['bitcoinAmount'];?> <?=$data['coinName'];?></div>
			<div class="none_bch hide"><?php echo $_SESSION['r_coins']['amount'];?> <?php echo $_SESSION['r_coins']['currency'];?></div>
		</div>
		<div class="text-center mb-3">
		<div id="timer" class="btc-timer text-white badge rounded-pill bg-dark mb-2" style="font-size: 20px !important;
    padding: 5px 20px 5px 20px !important;">15:00</div>
		</div>
		
		<div class="clearfix"></div>
		<center>
		<div id="btc-qr" class="fl qr_code" border="0" title="bitcoin:<?php echo $_SESSION['r_coins']['bitcoinAddress'];?>?amount=<?php echo $_SESSION['r_coins']['bitcoinAmount'];?>"></div></center>
		
		<? /*?>
		<img class="qr_code" src="https://chart.googleapis.com/chart?chs=250x250&chld=L|0&cht=qr&chl=bitcoin:<?php echo $_SESSION['r_coins']['bitcoinAddress'];?>?&amount=<?php echo $_SESSION['r_coins']['bitcoinAmount'];?>" />
		<?*/?>
		
		<div class="text-end clearfix my-2">
		<span class="address_coins my-2 mx-1 text-break text-white" id="qr_code_address" onClick="CopyToClipboard2('#qr_code_address');"><?php echo $_SESSION['r_coins']['bitcoinAddress00'];?>dfgfdgfdgfdsgdfsgsbgdfgsdfgbgbttf</span>
		<a class="my-2 mx-1"  href="javascript:void(0)" onClick="CopyToClipboard2('#qr_code_address');"><i class="<?=$data['fwicon']['copy'];?> fa-fw text-white"></i></a>
		</div>
		
		<div class="mt-2 clearfix text-center">
		<div class="iHavPaid1 float-end w-100 px-2"><a id="iHavPaidLink" class="iHavPaid btn btn-primary px-2" href="<?=$data['processed'];?>"  style="min-width:300px;">I Have Paid</a></div> 
		</div>
	</div>
</div>
     
             </div>
           
         

        </div>
      </div>
	  
	  </div>
	  </div>
   <script>
   setTimeout(function(){
	$(".goog-te-combo option:first-child").text('English');
	$('.translateDiv').show(100);
   },2000);
   
   setTimeout(function(){ 
   $('.goog-te-gadget').css("color", "#fff");
   },2500);
  </script>



<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>
