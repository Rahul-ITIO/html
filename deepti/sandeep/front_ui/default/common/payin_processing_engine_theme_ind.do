<??>
<? //start walletlist list----   ?>
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

<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'scanqr') !== false){?>
<div class="scanqr_div ewalist hide">
  <div class="text-start mb-2">PAY WITH QR CODE
    <!--<span class="text-end" onclick="toggle_f('#qr_toggle')"><i class="<?=@$data['fwicon']['qrcode'];?> p-2"></i></span>-->
  </div>
  <div class="row border p-2 mb-2 rounded row upi_qr_row" id="qr_toggle" >
    <!--style="display:none;"-->
    <div class="col-sm-12 upi_qr_border" style="overflowx:hidden;position:relative;z-index:5;height:auto;">
      <div class="px-2 my-3"><img src="<?=@$data['bankicon']['qr-button'];?>" title="QR" class="upi_qr_img"/> </div>
    </div>
    <div class="col-sm-12 upi_qr ps-2 mt-2">
      <div class="px-1 upi_qr_text" style="font-size:10px !important;">Scan the QR using any tha app on your phone.</div>
      <div class="my-2"> 
		<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'tetherCoins') !== false){?>
				<img class="tetherCoins_div ewalist hide" src="<?=$data['Host']?>/bank/TetherCoins_logo.png" title="Tether Coins" style="display:inline-block;" />
		<?}?>
		&nbsp;<?=@$data['fwicon']['qr-code']?>&nbsp;
	  </div>
      <div class="qrTransID text-success-emphasis my-1" style="font-size:12px !important;">
        <? if(isset($_SESSION['bearer_token_id']) && $_SESSION['bearer_token_id'] ) { ?>
        <div class="text-muted fw-bold mx-2 fs10">Bearer Token : <? echo $_SESSION['bearer_token_id']?> </div>
        <? } ?>
      </div>
      <div class="text-secondary-emphasis my-1 QR_Code_is_valid hide" style="font-size:10px !important;">QR Code is valid for <span class="timer text-danger fw-bold">05:00</span> minutes</div>
      <a id="paid_qrcode_link" class="paid_qrcode_link btn btn-outline-success btn-sm mx-2 hide button_refresh fw-bold" style="font-size:10px !important;"><b class="contitxt1 ">I have paid</b></a> </div>
  </div>
  <div class="border p-2 mb-2 rounded bg-body-secondary upi_qr_row_msg hide"></div>
</div>
<? } ?>


<? if(!isMobileBrowser()) { ?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcodeadd') !== false){?>
<?php /*?><!--<div class="qrcodeadd_div ewalist hide appLogoDiv desImg qrcode" onclick="checkupi('qrcode')"><img src="<?=@$data['Host']?>/images/qr-code-logo.png" alt="QRcode" title="QRCode" style="display:block;width: 100%;"><span class="wallets txNm hide">QRcode</span>--><?php */?>
<div class="qrcodeadd_div ewalist hide">
  <div class="text-start mb-2">PAY WITH UPI QR
    <!--<span class="text-end" onclick="toggle_f('#qr_toggle')"><i class="<?=@$data['fwicon']['qrcode'];?> p-2"></i></span>-->
  </div>
  <div class="row border p-2 mb-2 rounded row upi_qr_row" id="qr_toggle" >
    <!--style="display:none;"-->
    <div class="col-sm-6 upi_qr_border" style="overflow:hidden;">
      <div class="px-2 my-3">
        <?php /*?><div class="btn btn-primary qr_show" style="position: absolute;z-index: 1;margin-top: 45px;margin-left: 20px;">Show QR</div><?php */?>
        <img src="<?=@$data['bankicon']['qr-button'];?>" title="QR" class="upi_qr_img"/> </div>
    </div>
    <div class="col-sm-6 upi_qr ps-2" style="padding-top: 41px;">
      <div class="px-1 upi_qr_text" style="font-size:10px !important;">Scan the QR using any UPI app on your phone.</div>
      <div class="my-2"> <img src='<?=@$data['bankicon']['google-pay-svg']?>' alt='google-pay'>&nbsp;<img src='<?=@$data['bankicon']['phonepe-svg']?>' alt='phone-pe'>&nbsp;<img src='<?=@$data['bankicon']['paytm-svg']?>' alt='paytm'>&nbsp;<img src='<?=@$data['bankicon']['bhim-svg']?>' alt='bhim'> </div>
      <div class="qrTransID text-success-emphasis my-1 hide" style="font-size:12px !important;">
        <? if(isset($_SESSION['bearer_token_id']) && $_SESSION['bearer_token_id'] ) { ?>
        <div class="text-muted fw-bold mx-2 fs10">Bearer Token : <? echo $_SESSION['bearer_token_id']?> </div>
        <? } ?>
      </div>
      <div class="text-secondary-emphasis my-1 QR_Code_is_valid hide" style="font-size:10px !important;">QR Code is valid for <span class="timer text-danger fw-bold">05:00</span> minutes</div>
      <a id="paid_qrcode_link" class="paid_qrcode_link btn btn-outline-success btn-sm mx-2 hide button_refresh fw-bold"  style="font-size:10px !important;display:none!important"><b class="contitxt1 ">I have paid</b></a> </div>
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
    <div class='col-1 text-start img30'> <img class="mt-2" src="<?=@$data['bankicon']['bhim-svg']?>"  /> </div>
    <div class='col ps-2 text-start img20'>
      <div class="">SELECT UPI APP </div>
      <?=@$sub_icon_more?>
    </div>
  </div>
  <div class="row unset intent_select_app" style="position:relative">
    <div class="row blur_layer hide" style=""> </div>
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
    <div class='col-1 text-start img30'> <img class="mt-2" src="<?=@$data['bankicon']['bhim-svg']?>"  /> </div>
    <div class='col ps-2 text-start img20'>
      <div class="">SELECT UPI APP </div>
      <?=@$sub_icon_more?>
    </div>
  </div>
  <div class="row unset intent_select_app" style="position:relative">
    <div class="row blur_layer" style=""> </div>
    <div class="row unset">
      <?
			if(!isMobileBrowser())
			{?>
      <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'qrcode_wl') !== false){?>
      <div class="qrcode_wl_div ewalist hide walletsDiv desImg qrcode" onclick="checkIntentUrl('qrcode')"><img src="<?=@$data['Host']?>/images/qr-code-logo.png" alt="QRcode" title="QRCode" style="display:block;width: 100%;"><span class="wallets txNm hide">QRcode</span></div>
      <?
				}
			}?>
      <a class="walletsDiv desImg paytm url_inte" href="" target="_blank" onclick="checkIntentUrl('paytm')"><img src="<?=@$data['Host']?>/images/paytm_logo.png" alt="PayTm" title="PayTm" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">PayTm</span></a> <a class="walletsDiv desImg phonepe url_inte" href="" target="_blank" onclick="checkIntentUrl('phonepe')"><img src="<?=@$data['Host']?>/images/phonepe.png" alt="PhonePe" title="PhonePe" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">PhonePe</span></a> <a class="walletsDiv desImg google url_inte" href="" target="_blank" onclick="checkIntentUrl('google')"><img src="<?=@$data['Host']?>/images/google_pay.png" alt="Google Pay" title="Google Pay" style="display:block;width: 100%;height:50px "><span class="wallets txNm hide">Google Pay</span></a> <a class="walletsDiv desImg bhim url_inte" href="" target="_blank" onclick="checkIntentUrl('bhim')"><img src="<?=@$data['Host']?>/images/bhim.png" alt="bhim" title="Bhim" style="display:block;width: 100%;"><span class="wallets txNm hide">Bhim</span></a> <a class="walletsDiv desImg whatsapp url_inte" href="" target="_blank" onclick="checkIntentUrl('whatsapp')"><img src="<?=@$data['Host']?>/images/whatsapp-pay.png" alt="Whatsapp Pay" title="Whatsapp Pay" style="display:block;width: 100%;height:50px"><span class="wallets txNm hide">WhatsApp</span></a> <a class="walletsDiv desImg amazon url_inte" href="" target="_blank" onclick="checkIntentUrl('amazon')"><img src="<?=@$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">AmazonPay</span></a>
      <?/*?>
			  <div class="walletsDiv desImg freecharge" onclick="checkIntentUrl('freecharge')"><img src="<?=@$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;"><span class="wallets txNm hide">Freecharge</span></div>
			  <div class="walletsDiv desImg jio" onclick="checkIntentUrl('jio')"><img src="<?=@$data['Host']?>/images/jiomoney-logo-new.png" alt="JioMoney" title="JioMoney" style="display:block;width: 100%;"><span class="wallets txNm hide">JioMoney</span></div>
			  <div class="walletsDiv desImg ola" onclick="checkIntentUrl('ola')"><img src="<?=@$data['Host']?>/images/olamoney-logo-pp.png" alt="OlaMoney" title="OlaMoney" style="display:block;width: 100%;"><span class="wallets txNm hide">OlaMoney</span></div>
			  
			  
			  <div class="walletsDiv desImg airtel" onclick="checkIntentUrl('airtel')"><img src="<?=@$data['Host']?>/images/airtel_payments_bank_logo.png" alt="Airtel" title="Airtel" style="display:block;margin:12px auto !important;max-height:40%;"><span class="wallets txNm hide">Airtel</span></div>
			  <?*/?>
      <?if(fetchDeviceName()!='ios')
		  {?>
      <a class="walletsDiv desImg mobikwik url_inte" href="" target="_blank" onclick="checkIntentUrl('mobikwik')"><img src="<?=@$data['Host']?>/images/mobikwik-logo-new.png" alt="Mobikwik" title="Mobikwik" style="display:block;width: 100%;"><span class="wallets txNm hide">MobiKwik</span></a> <a class="walletsDiv desImg other url_inte" href="" target="_blank" onclick="checkIntentUrl('other')"><img src="<?=@$data['Host']?>/images/other_logo.png" alt="Other" title="Other" style="display:block;width:95%;margin:3px auto; height: 57px;width:100px;"><span class="wallets txNm hide">Other</span></a>
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
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'upiAppListForCollect') !== false){?>
<div class="upiAppListForCollect_div ewalist hide">
  <div class="text-start mb-2 is_not_channel hide"> PAY USING UPI ID </div>
  <div class="row is_channel hide or_1 text-center w-100 mt-3" style="margin-bottom:22px;"> <b> OR </b> </div>
  <div class="row is_channel is_9 hide">
    <div class="row border py-1 px-2 mb-2 rounded" >
      <div class='col-1 text-start img30'> <img class="mt-2" src="<?=@$data['bankicon']['bhim-svg']?>"  /> </div>
      <div class='col ps-2 text-start img20'>
        <div class="">PAY USING UPI ID </div>
        <?=@$sub_icon_more?>
      </div>
    </div>
  </div>
  <div class="row unset payment_option border p-2 rounded">
    <div class="appLogoDiv desImg paytm col-sm-12  px-2 py-1 border my-1 rounded" onclick="checkupi('paytm')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="paytm" id="paytm_radio">
      </div>
      <span class="wallets txNm float-start">Paytm</span> <img src="<?=@$data['bankicon']['paytm']?>" alt="PayTm" title="PayTm"  class="float-end"> </div>
    <div id="paytm_display" class="blank_display"></div>
    <div class="appLogoDiv desImg phonepe col-sm-12  px-2 py-1 border my-1 rounded" onclick="checkupi('phonepe')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="phonepe" id="phonepe_radio">
      </div>
      <span class="wallets txNm float-start">Phonepe</span> <img src="<?=@$data['bankicon']['phonepe']?>" alt="PhonePe" title="PhonePe"  class="float-end"> </div>
    <div id="phonepe_display" class="blank_display"></div>
    <div class="appLogoDiv desImg google  col-sm-12  px-2 py-1 border my-1 rounded" onclick="checkupi('google')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="gpay" id="google_radio">
      </div>
      <span class="wallets txNm float-start">Google pay</span> <img src="<?=@$data['bankicon']['googlepay']?>" alt="Google Pay" title="Google Pay"  class="float-end"> </div>
    <div id="google_display" class="blank_display"></div>
    <div class="appLogoDiv desImg amazon col-sm-12  px-2 py-1 border my-1 rounded" onclick="checkupi('amazon')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="amazon" id="amazon_radio">
      </div>
      <span class="wallets txNm float-start">Amazon pay</span> <img src="<?=@$data['bankicon']['amazonpay']?>" alt="AmazonPay" title="AmazonPay"  class="float-end"> </div>
    <div id="amazon_display" class="blank_display"></div>
    <div class="appLogoDiv desImg bhim col-sm-12  px-2 py-1 border my-1 rounded" onclick="checkupi('bhim')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="bhim" id="bhim_radio">
      </div>
      <span class="wallets txNm float-start">Bhim UPI</span> <img src="<?=@$data['bankicon']['bhim']?>" alt="bhim" title="Bhim" class="float-end"> </div>
    <div id="bhim_display" class="blank_display"></div>
    <div class="appLogoDiv desImg jio  col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('jio')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="jio" id="jio_radio">
      </div>
      <span class="wallets txNm float-start">Jio Money</span> <img src="<?=@$data['bankicon']['jiomoney']?>" alt="JioMoney" title="JioMoney"  class="float-end"> </div>
    <div id="jio_display" class="blank_display"></div>
    <div class="appLogoDiv desImg airtel col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('airtel')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="airtel" id="airtel_radio">
      </div>
      <span class="wallets txNm float-start">Airtel Money</span> <img src="<?=@$data['bankicon']['airtel']?>" alt="Airtel" title="Airtel"  class="float-end"> </div>
    <div id="airtel_display" class="blank_display"></div>
    <div class="appLogoDiv desImg ola col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('ola')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="ola" id="ola_radio">
      </div>
      <span class="wallets txNm float-start">Ola Money</span> <img src="<?=@$data['bankicon']['olamoney']?>" alt="OlaMoney" title="OlaMoney"  class="float-end"> </div>
    <div id="ola_display" class="blank_display"></div>
    <div class="appLogoDiv desImg mobikwik  col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('mobikwik')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="mobikwik" id="mobikwik_radio">
      </div>
      <span class="wallets txNm float-start">MobiKwik</span> <img src="<?=@$data['bankicon']['mobikwik']?>" alt="Mobikwik" title="Mobikwik"  class="float-end"> </div>
    <div id="mobikwik_display" class="blank_display"></div>
    <div class="appLogoDiv desImg freecharge  col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('freecharge')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="freecharge" id="freecharge_radio">
      </div>
      <span class="wallets txNm float-start">Freecharge</span> <img src="<?=@$data['bankicon']['freecharge']?>" alt="FreeCharge" title="FreeCharge"  class="float-end"> </div>
    <div id="freecharge_display" class="blank_display"></div>
    <div class="appLogoDiv desImg whatsapp  col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('whatsapp')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="whatsapp" id="whatsapp_radio">
      </div>
      <span class="wallets txNm float-start">WhatsApp Pay</span> <img src="<?=@$data['bankicon']['whatsapp']?>" alt="Whatsapp Pay" title="Whatsapp Pay" class="float-end"> </div>
    <div id="whatsapp_display" class="blank_display"></div>
    <div class="appLogoDiv desImg other col-sm-12  px-2 py-1 border my-1 rounded view_upi hide" onclick="checkupi('other')">
      <div class="form-check float-start">
        <input class="form-check-input" type="radio" data-rname="appradio" name="wallet_code_app" value="other" id="other_radio">
      </div>
      <span class="wallets txNm float-start">Enter UPI Address</span> <img src="<?=@$data['bankicon']['upi_address']?>" alt="Other" title="Other" class="float-end"> </div>
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
<? //BANK LIST AND LOGO FOR Paytm ?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'PaytmBankLogo')!==false){?>
<div class="PaytmBankLogo_div ewalist hide">
  <div class="row">
    <div class="col-sm-4 border p-2 desImg AXIS AXB">
      <div class="text-center"><img src="<?=@$data['bankicon']['axis'];?>" title="AXIS" class="bank_img"/></div>
      <span class="bankNm txNm">AXIS</span> </div>
    <div class="col-sm-4 border p-2 desImg HDFC HDFCB">
      <div class="text-center"><img src="<?=@$data['bankicon']['hdfc'];?>" title="HDFC" class="bank_img"/></div>
      <span class="bankNm txNm">HDFC</span> </div>
    <div class="col-sm-4 border p-2 desImg ICICI ICICIB">
      <div class="text-center"><img src="<?=@$data['bankicon']['icici'];?>" title="ICICI" class="bank_img"/></div>
      <span class="bankNm txNm">ICICI</span> </div>
    <div class="col-sm-4 border p-2 desImg IDBI IDBIB">
      <div class="text-center"><img src="<?=@$data['bankicon']['idbi'];?>" title="IDBI" class="bank_img"/></div>
      <span class="bankNm txNm">IDBI</span> </div>
    <div class="col-sm-4 border p-2 desImg IDFC IDFCFB">
      <div class="text-center"><img src="<?=@$data['bankicon']['idfc'];?>" title="IDFC" class="bank_img"/></div>
      <span class="bankNm txNm">IDFC</span> </div>
    <div class="col-sm-4 border p-2 desImg YES YESBL">
      <div class="text-center"><img src="<?=@$data['bankicon']['yes'];?>" title="Yes Bank" class="bank_img"/></div>
      <span class="bankNm txNm">YES</span> </div>
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
    <option value="AXIB">AXIS NB</option>
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
    <option value="YESB">YES Bank</option>
  </select>
  <input class="w94" type="text" name="bank_code_text" style="margin:5px 0;display:none;" />
</div>
<? 
					}?>
					
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'EasebuzzBankingList') !== false){?>
  <div class="EasebuzzBankingList_div ewalist hide">
	<div class="input-field select my-3">
        <select class="w94 dropDwn required form-select form-select-lg" name="bankCode" id="bankCode" style="margin:5px 0; width:100%;">
          iii<option value="" selected="selected">Bank Name</option>
          <option value="ALB">Allahabad Bank</option>
          <option value="AUSFB">AU Small Finance Bank</option>
          <option value="AXB">AXIS Bank</option>
          <option value="ACNB">Axis Corporate Net banking</option>
          <option value="BANB">Bandhan Bank</option>
          <option value="BOBCB">Bank of Baroda - Corporate Banking</option>
          <option value="BOBRB">Bank of Baroda - Retail Banking</option>
          <option value="BOIND">Bank of India</option>
          <option value="CANB">Canara Bank</option>
          <option value="SYNB">Canara Bank (Erstwhile Syndicate Bank)</option>
          <option value="CSFB">Capital Small Finance Bank</option>
          <option value="CBOI">Central Bank of India</option>
          <option value="CSB">Catholic Syrian Bank</option>
          <option value="CUB">City Union Bank</option>
          <option value="COSB">Cosmos Bank</option>
          <option value="DBSB">DBS Bank</option>
          <option value="DCBB">DCB Bank</option>
          <option value="DEUTB">Deutsche Bank</option>
          <option value="DCBC">Development Credit Bank - Corporate</option>
          <option value="DHANB">Dhanlakshmi Bank</option>
          <option value="EQSFB">Equitas Small Finance Bank</option>
          <option value="FEDB">Federal Bank</option>
          <option value="FIB">Fincare Bank</option>
          <option value="HDFCB">HDFC Bank</option>
          <option value="HSBC">HSBC Bank</option>
          <option value="ICICIB">ICICI Bank</option>
          <option value="ICICICO">ICICI Corporate</option>
          <option value="IDBIB">IDBI Bank</option>
          <option value="IDFCFB">IDFC First Bank</option>
          <option value="INB">Indian Bank</option>
          <option value="IOB">Indian Overseas Bank</option>
          <option value="IOBC">Indian Overseas Bank - Corporate</option>
          <option value="INDUSB">IndusInd Bank</option>
          <option value="JKB">Jammu & Kashmir Bank</option>
          <option value="JKBC">Jammu & Kashmir Bank - Corporate</option>
          <option value="JSBLP">Janata Sahakari Bank Ltd Pune</option>
          <option value="KBL">Karnataka Bank Ltd</option>
          <option value="KAGB">Karnataka Gramin Bank</option>
          <option value="KVB">Karur Vysya Bank</option>
          <option value="KJSBB">KJSB Bank	</option>
          <option value="KTB">Kotak Bank</option>
          <option value="LVB">Lakshmi Vilas Bank</option>
          <option value="LVBRNB">Laxmi Vilas Bank - Retail Net Banking</option>
          <option value="OBOC">PNB(Erstwhile-Oriental Bank of Commerce)</option>
          <option value="UNBOI">PNB (Erstwhile-United Bank of India)</option>
          <option value="PASB">Punjab & Sind Bank</option>
          <option value="PNBCB">Punjab National Bank - Corporate Banking</option>
          <option value="PNBRB">Punjab National Bank - Retail Banking</option>
          <option value="RBLBL">RBL Bank Limited</option>
          <option value="SARB">Saraswat Bank</option>
          <option value="SVCB">Shamrao Vithal Co-op Bank</option>
          <option value="SIB">South Indian Bank</option>
          <option value="SCB">Standard Chartered Bank</option>
          <option value="SCBC">Standard Chartered Bank - Corporate</option>
          <option value="SBOI">State Bank of India</option>
          <option value="SBOIC">State Bank of India - Corporate Banking</option>
          <option value="TNSCB">Tamil Nadu State Co-operative Bank</option>
          <option value="TMBL">Tamilnad Mercantile Bank Ltd</option>
          <option value="TJSBB">TJSB Bank</option>
          <option value="UCOB">UCO Bank	UCOB</option>
          <option value="UCOBC">UCO Bank Corporate</option>
          <option value="UBOI">Union Bank of India</option>
          <option value="UBOIC">Union Bank of India - Corporate</option>
          <option value="ANB">Union Bank of India (Erstwhile Andhra Bank)</option>
          <option value="ANBC">Union Bank of India (Erstwhile Andhra Bank) - Corporate</option>
          <option value="CORPB">Union Bank of India (Erstwhile Corporation Bank)</option>
          <option value="CORPCB">Union Bank of India (Erstwhile Corporation Bank) - Corporate</option>
          <option value="VIJB">Vijaya Bank</option>
          <option value="YESBL">Yes Bank Ltd</option>
          <option value="AIRTLM">Airtel Payments Bank</option>
          <option value="ATM">Amazon Pay</option>
          <option value="FCW">Freecharge</option>
          <option value="JIOM">Jio Money</option>
          <option value="MOBKWK">Mobikwik</option>
          <option value="OLAM">OLA Money</option>
          <option value="PAYTM">PayTM</option>
          <option value="PHONEPE">PhonePe</option>
        </select>
        <input class="w94" type="text"  name="bankCode_text" style="margin:5px 0;display:none;" />
  </div>
  </div>
<? } ?>
					
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
      <h4> Coinbase</h4>
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
        </span> </div>
      <?/*?>
							<a class='nopopup suButton btn btn-icon btn-primary modal_msg_close3' onclick="modal_msg_close();" style='width:35%'>No</a>
							<?*/?>
      <div class="hide bankStatus" style="display:none;text-align:center;">
        <div class="token_base_time"></div>
        <p style="text-align:center;margin:40px 0 10px 0;">You can always switch back to this tab if transactions is not successful. </p>
        <a class='nopopup suButton btn btn-icon btn-primary'  href="<?=@$data['Host']?>/bank_status<?=@$data['ex']?>" target="_top" >I have paid</a>
        <p style="text-align:center;margin: 30px 0 10px 0;">Try making the payment again with a different payment method.</p>
        <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="authenticatef()"  >YES</a> </div>
    </div>
  </div>
</div>
<!-- intent_submitMsg via app open   -->
<div class="intent_appOpenSubmit_div ewalist submitMsg hide" data-style='width:250px;height:142px;margin:-71px 0 0 -125px;overflow:hidden;' >
  <div class="modalMsgCont" style="display:none !important">
    <div class="modalMsgContTxt" >
      <div class="appOpen p-0">
        <div style="text-align:center;margin:12px 0 0 0;">"<i>
          <?=@$_SESSION['ter_name']?>
          </i>" wants to open. <span class="appOpenName" style="text-align:center;margin:10px 0 0 0;font-weight: bold;font-size: 12px;text-transform:capitalize;">"UPI / APP / Wallet"</span> </div>
        <div class="submit_div1 mx_button_row mt-2 p-0" style=""> <a class='paid_upiIntent_link nopopup suButton btn btn-icon btn-primary modal_msg_close3 mx_button_1' onclick="processing_closef('Pay');modal_msg_close();" style="">Cancel</a> <span class="appOpenUrlLink"><a class='appOpenUrl nopopup suButton btn btn-icon btn-primary' style="">Open</a></span> </div>
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
        </span> </div>
      <?/*?>
							<a class='nopopup suButton btn btn-icon btn-primary modal_msg_close3' onclick="modal_msg_close();" style='width:35%'>No</a>
							<?*/?>
      <div class="hide bankStatus" style="display:none;text-align:center;">
        <div class="token_base_time"></div>
        <p style="text-align:center;margin:40px 0 10px 0;">You can always switch back to this tab if transactions is not successful. </p>
        <a class='nopopup suButton btn btn-icon btn-primary' href="<?=@$data['Host']?>/bank_status<?=@$data['ex']?>" target="_top" >I have paid</a>
        <p style="text-align:center;margin: 30px 0 10px 0;">Try making the payment again with a different payment method.</p>
        <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="authenticatef()"  >Yes</a> </div>
    </div>
  </div>
</div>
<? //end msg  list----  ?>

<div class="submit_div text-muted m-button my-2 clearfix">
  <div class="float-start text-center w-50">
    <div class="w-100 fw-bold nPay" style="font-size:13px;">
      <?=@$currency_smbl;?>
      <!--<?=@$post['curr']?$post['curr']:$_SESSION['curr'];?>-->
      <?=(@$post['total']?$post['total']:$post['bill_amt'])?>
    </div>
    <div class="account-pop pointer text-link" style="font-size:10px;" title="View Payment Details">View Details</div>
  </div>
  <button onclick="checkValidity_tr_f('hideCloseButton');" id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!"  class="paybutton submitbtn btn btn-slide next w-50 float-end b555"><i></i><b class="contitxt">Continue</b></button>
  <a id="paid_qrcode_button" class="paid_qrcode_button paid_qrcode_link btn btn-slide w-50 float-end hide"><i></i><b class="contitxt1">I have paid</b></a> </div>
<div class="modal_msg" id="modal_msg">
  <div class="modal_msg_layer"> </div>
  <div class="modal_msg_body"> <a class="modal_msg_close" onClick="document.getElementById('modal_msg').style.display='none';" style="position:relative;top:-6px;right:7px;">×</a>
    <div id="modal_msg_body_div"> </div>
    <a style="display:none;" title="Have you authenticated the transaction" class="modal_msg_close2" onClick="document.getElementById('modal_msg').style.display='none';" href="<?=@$data['Host']?>/bank_status<?=@$data['ex']?>" target="_top">Yes</a> </div>
</div>
