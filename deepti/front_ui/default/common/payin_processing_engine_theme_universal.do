<??>

<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'emailEdit') !== false){?>
	  <div class="emailEdit_div ewalist hide">
		<input type="text" name="bill_email" class="w93p required" placeholder="RFC compliant email address of the account holder" title="RFC compliant email address of the account holder" value="<?=(isset($post['bill_email'])?$post['bill_email']:'');?>"/>
	  </div>
	  <? } ?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'ibanInput') !== false){?>
	  <div class="ibanInput_div ewalist hide">
		<input type="text" name="iban" class="w93p required" placeholder="Enter Valid IBAN" title="Enter Valid IBAN" value="<?=(isset($post['iban'])?$post['iban']:'');?>" data-required="required" />
	  </div>
	  <? } ?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'bicInput') !== false){?>
	  <div class="bicInput_div ewalist hide">
		<input type="text" name="bic" class="w93p" placeholder="Valid BIC (8 or 11 alphanumeric letters) of consumer’s bank" title="Valid BIC (8 or 11 alphanumeric letters) of consumer’s bank" value="<?=(isset($post['bic'])?$post['bic']:'');?>" />
	  </div>
	  <? } ?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'nationalidInput') !== false){?>
	  <div class="nationalidInput_div ewalist hide">
		<input type="text" name="nationalid" class="w93p required" placeholder="Consumer's national id" data-required="required" value="<?=(isset($post['nationalid'])&&$post['nationalid']?$post['nationalid']:"");?>" />
	  </div>
	  <? } ?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'mobilephoneInput') !== false){?>
	  <div class="mobilephoneInput_div ewalist hide">
		<input type="text" name="mobilephone" class="w93p required" placeholder="Valid international Russian mobile phone number identifying the QIWI destination account to pay" title="Valid international Russian mobile phone number identifying the QIWI destination account to pay out to (excluding plus sign or any other international prefixes, including a leading 7 for Russia, 11 digits in total, e.g. 71234567890)" data-required="required" value="<?=(isset($post['mobilephone'])&&$post['mobilephone']?$post['mobilephone']:(isset($post['bill_phone'])?$post['bill_phone']:''));?>" />
	  </div>
	  <? } ?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'siteIdInput') !== false){?>
	  <div class="siteIdInput_div ewalist hide">
		<input type="text" name="siteId_input" class="w93p required" placeholder="Unique site identifier, forwarded to qiwi." title="Unique site identifier, forwarded to qiwi." data-required="required" value="<?=(isset($post['siteId_input'])?$post['siteId_input']:'');?>" />
	  </div>
	  <? } ?>
	  
	  
	
	
		
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'RevPayBankLogo') !== false){?>
	  <div class="RevPayBankLogo_div ewalist hide">
		<div class="banksDiv desImg sprite SCB0216" title="Standard Chartered"><span class="imgs" style="vertical-align:middle;"><img src="<?=@$data['Host']?>/images/standardChartered.png"  /></span><span class="bankNm txNm">Standard Chartered</span></div>
		<div class="banksDiv desImg sprite HSBC0223" title="HSBC Bank Malaysia Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=@$data['Host']?>/images/HSBC.png" /></span><span class="bankNm txNm">HSBC Bank Malaysia Berhad</span></div>
		<div class="banksDiv desImg sprite RHB0218" title="RHB Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=@$data['Host']?>/images/RHB Bank.png" /></span><span class="bankNm txNm">RHB Bank Berhad</span></div>
		<div class="banksDiv desImg sprite ABB0233" title="Affin Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=@$data['Host']?>/images/Affin Bank Berhad.png" /></span><span class="bankNm txNm">Affin Bank Berhad</span></div>
	  </div>
	  <? } ?>
	  
	  
	



	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'RevPayList') !== false){?>
	  <div class="RevPayList_div ewalist hide">
		<select class="w94 dropDwn required" name="bankCode" id="bankCode" style="margin:5px 0;">
		  <option value="" selected="selected">Bank Name</option>
		  <option value="TEST0021">Test Bank</option>
		  <option value="ABB0233">Affin Bank Berhad</option>
		  <option value="ABMB0212">Alliance Bank Malaysia Berhad</option>
		  <option value="AMBB0209">AmBank Malaysia Berhad</option>
		  <option value="BIMB0340">Bank Islam Malaysia Berhad</option>
		  <option value="BKRM0602">Bank Kerjasama Rakyat Malaysia Berhad</option>
		  <option value="BMMB0341">Bank Muamalat Malaysia Berhad</option>
		  <option value="BSN0601">Bank Simpanan Nasional</option>
		  <option value="BCBB0235">CIMB Bank Berhad</option>
		  <option value="HLB0224">Hong Leong Bank Berhad</option>
		  <option value="HSBC0223">HSBC Bank Malaysia Berhad</option>
		  <option value="KFH0346">Kuwait Finance House (Malaysia) Berhad</option>
		  <option value="MB2U0227">Malayan Banking Berhad (M2U)</option>
		  <option value="MBB0228">Malayan Banking Berhad (M2E)</option>
		  <option value="OCBC0229">OCBC Bank Malaysia Berhad</option>
		  <option value="PBB0233">Public Bank Berhad</option>
		  <option value="RHB0218">RHB Bank Berhad</option>
		  <option value="SCB0216">Standard Chartered Bank</option>
		  <option value="UOB0226">United Overseas Bank</option>
		</select>
		<input class="w94" type="text"  name="bankCode_text" style="margin:5px 0;display:none;" />
	  </div>
	  <? } ?>
	<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IsgNetBankingTopBank') !== false){?>
	<div class="IsgNetBankingTopBank_div ewalist hide">
		<div class="banksDiv desImg sprite SCB0216" title="Standard Chartered"><span class="imgs" style="vertical-align:middle;"><img src="<?=@$data['Host']?>/images/standardChartered.png"  /></span><span class="bankNm txNm">Standard Chartered</span></div>
		<div class="banksDiv desImg sprite HSBC0223" title="HSBC Bank Malaysia Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=@$data['Host']?>/images/HSBC.png" /></span><span class="bankNm txNm">HSBC Bank Malaysia Berhad</span></div>
		<div class="banksDiv desImg sprite RHB0218" title="RHB Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=@$data['Host']?>/images/RHB Bank.png" /></span><span class="bankNm txNm">RHB Bank Berhad</span></div>
		<div class="banksDiv desImg sprite ABB0233" title="Affin Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img src="<?=@$data['Host']?>/images/Affin Bank Berhad.png" /></span><span class="bankNm txNm">Affin Bank Berhad</span></div>
	</div>
	<?
	}
	if(isset($post['t_name6'])&&strpos($post['t_name6'],'IsgNetBankingNameList') !== false){?>

		<div class="IsgNetBankingNameList_div ewalist hide">
			<select class="w94 dropDwn required" name="bankCode" id="bankCode" style="margin:5px 0;">
				<option value="" selected="selected">Bank Name</option>
				<option value="TEST0021">Test Bank</option>
				<option value="ABB0233">Affin Bank Berhad</option>
				<option value="ABMB0212">Alliance Bank Malaysia Berhad</option>
				<option value="AMBB0209">AmBank Malaysia Berhad</option>
				<option value="BIMB0340">Bank Islam Malaysia Berhad</option>
				<option value="BKRM0602">Bank Kerjasama Rakyat Malaysia Berhad</option>
				<option value="BMMB0341">Bank Muamalat Malaysia Berhad</option>
				<option value="BSN0601">Bank Simpanan Nasional</option>
				<option value="BCBB0235">CIMB Bank Berhad</option>
				<option value="HLB0224">Hong Leong Bank Berhad</option>
				<option value="HSBC0223">HSBC Bank Malaysia Berhad</option>
				<option value="KFH0346">Kuwait Finance House (Malaysia) Berhad</option>
				<option value="MB2U0227">Malayan Banking Berhad (M2U)</option>
				<option value="MBB0228">Malayan Banking Berhad (M2E)</option>
				<option value="OCBC0229">OCBC Bank Malaysia Berhad</option>
				<option value="PBB0233">Public Bank Berhad</option>
				<option value="RHB0218">RHB Bank Berhad</option>
				<option value="SCB0216">Standard Chartered Bank</option>
				<option value="UOB0226">United Overseas Bank</option>
			</select>
			<input class="w94" type="text" name="bankCode_text" style="margin:5px 0;display:none;"/>
		</div>
	  <?
	  } ?>
	 <?
	 ###### HELP 2 PAY - START
	if(isset($post['t_name6'])&&strpos($post['t_name6'],'help2payBankingList') !== false){

	include_once $data['Path'].'/api/pay70/bank_list_70'.$data['iex'];
		$country_two = $post['country_two'];
		?>

		<div class="help2payBankingList_div ewalist hide">
			<select class="w94 dropDwn required" name="bankCode" id="bankCode" style="margin:5px 0;">
			<option value="" selected="selected">Bank Name</option>
				<option value="TEST0021">Test Bank</option>
			<?
			foreach ($BankListArray as $key => $val) {
				$bcode	= $key;
				$bname	= $val['name'];
				$bctry	= $val['country'];
				

				if(isset($country_two)&&$country_two){
					if($country_two==$bctry)
					{
					$bcurr	= $val['curr'];
					?>
					<option value="<?=@$bcode?>"><?=@$bname?></option>
					<?
					}
				}
				else{
					?>
					<option value="<?=@$bcode?>"><?=@$bname?></option>
					<?
				}
			}
			?>
			</select>
			<input type="hidden" name="bank_curr" value="<?=@$bcurr?>" />
			<input class="w94" type="text" name="bankCode_text" style="margin:5px 0;display:none;"/>
		</div>
	  <?
	  }
	   ###### HELP 2 PAY - END
	  ?>
	
	  
	  
	  

	 
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'BBVAInstr') !== false){?>
	  <div class="BBVAInstr_div ewalist hide">
		<ul>
		  <li>Selecciona la opción <b>"Cuenta y Ahorros"</b> </li>
		  <li>Selecciona <b>"Servicios Públicos" - "SafetyPay" </b> y moneda. </li>
		  <li>Ingrese tu <b>"Código de pago [TransactionID]"</b> </li>
		  <li>Selecciona la Cuenta o Tarjeta de Crédito de cargo, confirma el pago con tu clave SMS y ¡Listo! </li>
		</ul>
	  </div>
	  <? } ?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'TetherCoins_msg') !== false){?>
	  <div class="TetherCoins_msg_div ewalist modalMsg hide" data-style='width:300px;height:270px;' >
		<div class="modalMsgCont" style="display:none !important">
		  <div class="modalMsgContTxt" >
			<h4>
			TetherCoins</h4>
			<p><b>On the next screen you need to scan the QR code to pay by TetherCoins. Click Yes below when you are ready</b></p>
			<span class="submit_div">
			<button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i class="<?=@$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
			</span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')" data-ph="430px" data-ch="270px">No</a>
			<p class='hide noText3'>(If you do not have mobile application to scan QR code, you can still click on Yes above and we will share our BTC address which you can copy from next screen and send the exact payment to our btc address. )</p>
		  </div>
		</div>
	  </div>
	  <? } ?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'BitCoins_msg') !== false){?>
	  <div class="BitCoins_msg_div ewalist modalMsg hide" data-style='width:300px;height:270px;' >
		<div class="modalMsgCont" style="display:none !important">
		  <div class="modalMsgContTxt" >
			<h4>
			BitCoins</h4>
			<p><b>On the next screen you need to scan the QR code to pay by BitCoin. Click Yes below when you are ready</b></p>
			<span class="submit_div">
			<button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i class="<?=@$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
			</span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')" data-ph="430px" data-ch="270px">No</a>
			<p class='hide noText3'>(If you do not have mobile application to scan QR code, you can still click on Yes above and we will share our BTC address which you can copy from next screen and send the exact payment to our btc address. )</p>
		  </div>
		</div>
	  </div>
	  <? } ?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'AdvCash_msg') !== false){?>
	  <div class="AdvCash_msg_div ewalist modalMsg hide" data-style='width:300px;height:auto;' >
		<div class="modalMsgCont" style="display:none !important">
		  <div class="modalMsgContTxt" >
			<h4>
			AdvCash</h4>
			<p><b>Do you already have ADVCASH eWallet Account?</b></p>
			<span class="submit_div">
			<button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:48%' onclick='checkValidity_tr_f();'><i class="<?=@$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
			</span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:48%' onClick="view_tr_next3(this,'.noText3')" data-ph="400px" data-ch="200px">No</a>
			<p class='hide noText3'>(If you do not have ADVCASH eWallet account, You can logon to advcash.com and create an account once your account is <a href='https://wallet.advcash.com/register' target='_blank'>created/verified</a> you can come back to us and complete the payment for your favourite merchant.)</p>
		  </div>
		</div>
	  </div>
	  <? } ?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'cashU_msg') !== false){?>
	  <div class="cashU_msg_div ewalist modalMsg hide" data-style='width:300px;height:270px;' >
		<div class="modalMsgCont" style="display:none !important">
		  <div class="modalMsgContTxt" >
			<h4>
			CASHU</h4>
			<p><b>Do you already have CASHU eWallet Account?</b></p>
			<span class="submit_div">
			<button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i class="<?=@$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
			</span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="view_tr_next3(this,'.noText3')"  data-ph="430px" data-ch="270px">No</a>
			<p class='hide noText3'>(If you do not have CASHU eWallet account, You can logon to cashu.com and create an account once your account is <a href='https://www.cashu.com/CLogin/registersForm?lang=en' target='_blank'>created/verified</a> you can come back to us and complete the payment for your favourite merchant.)</p>
		  </div>
		</div>
	  </div>
	  <? } ?>
	  
	  
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'BNPay_msg') !== false){?>
	  <div class="BNPay_msg_div ewalist modalMsg hide" data-style='width:300px;height:auto;' >
		<div class="modalMsgCont" style="display:none !important">
		  <div class="modalMsgContTxt" >
			<h4>
			BINANCE</h4>
			<p><b>Do you already have BINANCE Wallet?</b></p>
			<span class="submit_div">
			<button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:48%' onclick='checkValidity_tr_f();'><i class="<?=@$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
			</span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:48%' onClick="view_tr_next3(this,'.noText3')" data-ph="400px" data-ch="200px">No</a>
			<p class='hide noText3'>(If you do not have BINANCE Wallet, You can logon to binance.com and create an account once your account is <a href="https://accounts.binance.com/en/login" target="_blank"><strong>created/verified</strong></a> you can come back to us and complete the payment for your favourite merchant.)</p>
		  </div>
		</div>
	  </div>
	  <? }
	  
	 
	  ?>
	  
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'universal_msg_17') !== false){
	  
	//  print_r($data['domain_server']['subadmin']['customer_service_email']);
	  
	  ?>
	  <div class="universal_msg_17_div ewalist modalMsg hide" data-style='width:340px;height:450px;margin:-160px 0px 0px -177px;' >
		<div class="modalMsgCont" style="display:none !important">
		  <div class="modalMsgContTxt" >
			<p><b>Important Message:</b><br />
			You are being redirected to our partner site <b>flashfin (Flash Pay)</b> to authorise this transaction. <br />
			On the next page you will see your order amount in THB (Thai Baht) instead of <?=(isset($post['curr'])&&$post['curr'])?$post['curr']:'USD';?>. <b>Your card will be charged equivalent amount of your <?=(isset($post['curr'])&&$post['curr'])?$post['curr']:'USD';?> order in THB only</b>. You can get back to us via email 
			<?
			if(isset($data['domain_server']['subadmin']['customer_service_email'])&&$data['domain_server']['subadmin']['customer_service_email'])
				echo 'at <b>'.encrypts_decrypts_emails($data['domain_server']['subadmin']['customer_service_email'],2).'</b>';
			?>
			 for any assistance with this order.</b></p>
			<span class="submit_div">
			<button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary glyphicons circle_ok " autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i></i><b class="contitxt">Yes</b></button>
			</span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="document.getElementById('modal_msg').style.display='none';">No</a>
			<p>You can always switch back to this tab if transactions is not successful. </p>
		  </div>
		</div>
	  </div>
	  <? } ?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'n26_msg') !== false){?>
	  <div class="n26_msg_div ewalist modalMsg hide" data-style='width:300px;height:300px;' >
		<div class="modalMsgCont" style="display:none !important">
		  <div class="modalMsgContTxt" >
			<p><b>You will be redirected to our Partner (Picksell) website to create account and complete the payment via Bank Transfer. </b></p>
			<span class="submit_div">
			<button id="cardsend_submit" type="submit" name="send123" value="CHANGE NOW!" class="checkValidityTr nopopup submitbtn btn btn-icon btn-primary" autocomplete="off" style='width:35%' onclick='checkValidity_tr_f();'><i class="<?=@$data['fwicon']['check-circle'];?>"></i> <b class="contitxt">Yes</b></button>
			</span> <a class='nopopup suButton btn btn-icon btn-primary' style='width:35%' onClick="document.getElementById('modal_msg').style.display='none';">No</a>
			<p>You can always switch back to this tab if transactions is not successful. </p>
		  </div>
		</div>
	  </div>
	  <?
	  }
	  ?>
	  
	  
	  
	  
	  
<!---- GREZPAY-->
		<div class="text-center ms-1">
		  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'grezpaywalletLogo') !== false){?>
		  <div class="grezpaywalletLogo_div ewalist hide">
			<div class="walletsDiv desImg 113"><img src="<?=@$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;"><span class="wallets txNm hide">FreeCharge</span></div>
			<div class="walletsDiv desImg 124"><img src="<?=@$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">AmazonPay</span></div>
			<div class="walletsDiv desImg 101"><img src="<?=@$data['Host']?>/images/paytm.png" alt="PayTM" title="PayTM" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">PayTM</span></div>
		  </div>
		  <? }?>
		  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'grezpaywalletList') !== false){?>
		  <div class="grezpaywalletList_div ewalist hide">
			<select class="w94 wDropDown dropDwn required" name="wallet_code" id="wallet_code" style="margin:5px 0;">
			  <option value="124">AmazonPay</option>
			  <option value="113">FreeCharge</option>
			  <option value="101">PayTM</option>
			   <option value="115">Phonepe</option>
				<option value="106">JioMoney</option>
			  <?
			  /*
			  //Payment Methods are not Live yet
			  <option value="102">Mobikwik</option>
			  <option value="103">AirtelMoney</option>
			  <option value="104">Vodafone Mpesa</option>
			  <option value="106">JioMoney</option>
			  <option value="107">OlaMoney</option>
			  <option value="115">PhonePe</option>
			  <option value="116">Oxigen</option>
			  <option value="123">SBI Buddy</option>
			  */?>
			</select>
		  </div>
		  <? }?>
		</div>
		<!---- GREZPAY-->
		
		
		
		<!---- PAYUMONEY-->
		
		
		
		<div class="text-center ms-1">
		<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'payUwalletLogo') !== false){?>
		<div class="payUwalletLogo_div ewalist hide">
			<div class="walletsDiv desImg FREC"><img src="<?=@$data['Host']?>/images/freecharge-logo-new.png" alt="FreeCharge" title="FreeCharge" style="display:block;width: 100%;"><span class="wallets txNm hide">FreeCharge</span></div>
			<!--<div class="walletsDiv desImg AMZPAY"><img src="<?=@$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">AmazonPay</span></div> -->
			<div class="walletsDiv desImg PAYTM"><img src="<?=@$data['Host']?>/images/paytm.png" alt="PayTM" title="PayTM" style="display:block;width:95%;margin:3px auto;max-height: 90%;"><span class="wallets txNm hide">PayTM</span></div>
		</div>
		<? }?>
		<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'payUwalletList') !== false){?>
		<div class="payUwalletList_div ewalist hide">
			<select class="w94 wDropDown dropDwn required" name="wallet_code" id="wallet_code" style="margin:5px 0;">
				<? /*<option value="AMZPAY">AmazonPay</option>*/?>
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
		</div>
		<!---- PAYUMONEY-->
		
		
		
		<?	//sabpaisa - wallet - start?>
	<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'SabPaisawalletLogo') !== false){?>
		<div class="SabPaisawalletLogo_div ewalist hide">
			<div class="walletsDiv desImg 503"><img src="<?=@$data['Host']?>/images/amazonpay_logo.png" alt="AmazonPay" title="AmazonPay" style="display:block;width:95%;margin:3px auto;"><span class="wallets txNm hide">AmazonPay</span></div>
			
		</div>
		<? }?>
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'SabPaisawalletList') !== false){?>
		<div class="SabPaisawalletList_div ewalist hide">
			<select class="w94 wDropDown dropDwn required form-select from-select-sm" name="wallet_code" id="wallet_code" style="margin:5px 0;">
				<option value="503">AmazonPay</option>

				<?php /*?><option value="FREC">FreeCharge</option>
				<option value="PAYTM">PayTM</option>
				
				<option value="JIOM">JioMoney</option>
				<option value="AMON">Airtel Money</option>
				<option value="OXYCASH">Oxigen</option>
				<option value="ITZC">ItzCash</option>
				<option value="PAYZ">HDFC PayZapp</option>
				<option value="OLAM">OlaMoney</option>
				<option value="YESW">Yes Bank</option>
				<option value="PHONEPE">PhonePe</option>
				<option value="mobikwik">MobiKwik</option><?php */?>
				</select>
		</div>
		<? }?>
		<? //sabpaisa wallet - end?>
		
		
		
		 <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankingCashLogo') !== false){?>
		  <div class="IndiaBankingCashLogo_div ewalist hide">
			<div class="banksDiv desImg 3044"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">SBI</span></div>
			<div class="banksDiv desImg 3022"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm">ICICI</span></div>
			<div class="banksDiv desImg 3021"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm">HDFC</span></div>
			<div class="banksDiv desImg 3003"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm">Axis</span></div>
			<div class="banksDiv desImg 3032"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm">Kotak</span></div>
			<div class="banksDiv desImg 3065"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm">PNB</span></div>
		  </div>
		  <?}?>
		  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'cashIndiaBankingList') !== false){?>
		  <div class="cashIndiaBankingList_div ewalist hide">
			<select class="w94 dropDwn hide required" name="bank_code" id="bank_code" style="margin:5px 0;">
				<option value="" disabled="">Choose Bank</option>
				<option value="3087">AU Small Finance</option>
				<option value="3071">Axis Bank Corporate</option>
				<option value="3003">Axis Bank</option>
				<option value="3079">Bandhan Bank- Corporate banking</option>
				<option value="3088">Bandhan Bank - Retail Net Banking</option>
				<option value="3060">Bank of Baroda - Corporate</option>
				<option value="3005">Bank of Baroda - Retail Banking</option>
				<option value="3006">Bank of India</option>
				<option value="3061">Bank of India - Corporate</option>
				<option value="3007">Bank of Maharashtra</option>
				<option value="3080">Barclays Corporate- Corporate Banking - Corporate</option>
				<option value="3009">Canara Bank</option>
				<option value="3010">Catholic Syrian Bank</option>
				<option value="3011">Central Bank of India</option>
				<option value="3012">City Union Bank</option>
				<option value="3083">City Union Bank of Corporate</option>
				<option value="3017">DBS Bank Ltd</option>
				<option value="3062">DCB Bank - Corporate</option>	
				<option value="3018">DCB Bank - Personal</option>	
				<option value="3016">Deutsche Bank</option>
				<option value="3019">Dhanlakshmi Bank</option>
				<option value="3072">Dhanlaxmi Bank Corporate</option>
				<option value="3076">Equitas Small Finance Bank</option>
				<option value="3020">Federal Bank</option>
				<option value="3091">Gujarat State Co-operative Bank Limited</option>
				<option value="3084">HDFC Corporate</option>
				<option value="3021">HDFC Bank</option>
				<option value="3092">HSBC Retail Netbanking</option>
				<option value="3073">ICICI Corporate Netbanking</option>
				<option value="3022">ICICI Bank</option>
				<option value="3023">IDBI Bank</option>
				<option value="3024">IDFC Bank</option>
				<option value="3026">Indian Bank</option>
				<option value="3027">Indian Overseas Bank</option>
				<option value="3081">Indian Overseas Bank Corporate</option>
				<option value="3028">IndusInd Bank</option>
				<option value="3029">Jammu and Kashmir Bank</option>
				<option value="3030">Karnataka Bank Ltd</option>
				<option value="3031">Karur Vysya Bank</option>
				<option value="3032">Kotak Mahindra Bank</option>
				<option value="3064">Lakshmi Vilas Bank - Corporate</option>
				<option value="3033">Lakshmi Vilas Bank - Retail Net Banking</option>
				<option value="3082">PNB (Erstwhile Oriental Bank of Commerce) - Corporate</option>
				<option value="3037">Punjab & Sind Bank</option>
				<option value="3065">Punjab National Bank - Corporate</option>
				<option value="3038">Punjab National Bank - Retail Banking</option>
				<option value="3074">Ratnakar Corporate Banking</option>
				<option value="3039">RBL Bank</option>
				<option value="3040">Saraswat Bank</option>
				<option value="3075">Shamrao Vithal Bank Corporate</option>
				<option value="3041">Shamrao Vitthal Co-operative Bank</option>
				<option value="3086">Shivalik Bank</option>
				<option value="3042">South Indian Bank</option>
				<option value="3043">Standard Chartered Bank</option>
				<option value="3044">SBI - State Bank Of India</option>
				<option value="3066">State Bank of India - Corporate</option>
				<option value="3051">Tamil Nadu State Co-operative Bank</option>
				<option value="3052">Tamilnad Mercantile Bank Ltd</option>
				<option value="3090">The Surat People’s Co-operative Bank Limited</option>
				<option value="3054">UCO Bank</option>
				<option value="3055">Union Bank of India</option>
				<option value="3067">Union Bank of India - Corporate</option>
				<option value="3089">Utkarsh Small Finance Bank</option>
				<option value="3077">Yes Bank Corporate</option>
				<option value="3058">Yes Bank Ltd</option>
				<option value="3333">TEST Bank</option>
			</select>
			<input class="w94" type="text"  name="bank_code_text" style="margin:5px 0;display:none;" />
		  </div>
		  <?}?>
		  
		  
		<? 
		// for NIMBBLE
		if(isset($post['t_name6'])&&strpos($post['t_name6'],'nimbblBankingLogo') !== false){?>
		  <div class="nimbblBankingLogo_div ewalist hide">
			<div class="banksDiv desImg State Bank of India"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">SBI</span></div>
			<div class="banksDiv desImg ICICI Bank"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm">ICICI</span></div>
			<div class="banksDiv desImg HDFC Bank"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm">HDFC</span></div>
			<div class="banksDiv desImg Axis Bank"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm">Axis</span></div>
			<div class="banksDiv desImg Kotak Mahindra Bank"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm">Kotak</span></div>
			<div class="banksDiv desImg Punjab National Bank - Retail Banking"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm">PNB</span></div>
		  </div>
		  <?}?>
		  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'nimbblBankingList') !== false){?>
		  <div class="nimbblBankingList_div ewalist hide">
			<select class="w94 dropDwn hide required" name="bank_code" id="bank_code" style="margin:5px 0;">
				<option value="Airtel Payments Bank">Airtel Payments Bank</option>
				<option value="Allahabad Bank">Allahabad Bank</option>
				<option value="Andhra Bank">Andhra Bank</option>
				<option value="Axis Bank">Axis Bank</option>
				<option value="Bank of Bahrain and Kuwait">Bank of Bahrain and Kuwait</option>
				<option value="Bank of Baroda">Bank of Baroda</option>
				<option value="Bank Of India">Bank Of India</option>
				<option value="Bank Of Maharashtra">Bank Of Maharashtra</option>
				<option value="Bharat Co-Op Bank">Bharat Co-Op Bank</option>
				<option value="Canara Bank">Canara Bank</option>
				<option value="Catholic Syrian Bank">Catholic Syrian Bank</option>
				<option value="Central Bank of India">Central Bank of India</option>
				<option value="Citibank Netbanking">Citibank Netbanking</option>
				<option value="Citibank Netbanking">Citibank Netbanking</option>
				<option value="City Union Bank">City Union Bank</option>
				<option value="Corporation Bank">Corporation Bank</option>
				<option value="Cosmos Co-operative Bank">Cosmos Co-operative Bank</option>
				<option value="DCB Bank">DCB Bank</option>
				<option value="DCB Bank - Corporate Netbanking">DCB Bank - Corporate Netbanking</option>
				<option value="Dena Bank">Dena Bank</option>
				<option value="Deutsche Bank">Deutsche Bank</option>
				<option value="Development Bank of Singapore">Development Bank of Singapore</option>
				<option value="Dhanlaxmi Bank">Dhanlaxmi Bank</option>
				<option value="Equitas Small Finance Bank">Equitas Small Finance Bank</option>
				<option value="Federal Bank">Federal Bank</option>
				<option value="Fincare Small Finance Bank">Fincare Small Finance Bank</option>
				<option value="HDFC Bank">HDFC Bank</option>
				<option value="ICICI Bank">ICICI Bank</option>
				<option value="ICICI Corp. Netbanking">ICICI Corp. Netbanking</option>
				<option value="IDBI">IDBI</option>
				<option value="IDFC Bank">IDFC Bank</option>
				<option value="Indian Bank">Indian Bank</option>
				<option value="Indian Overseas Bank">Indian Overseas Bank</option>
				<option value="IndusInd Bank">IndusInd Bank</option>
				<option value="Jammu and Kashmir Bank">Jammu and Kashmir Bank</option>
				<option value="Jana Small Finance Bank">Jana Small Finance Bank</option>
				<option value="Janata Sahakari Bank Pune">Janata Sahakari Bank Pune</option>
				<option value="Karnataka Bank">Karnataka Bank</option>
				<option value="Karur Vysya Bank">Karur Vysya Bank</option>
				<option value="Kotak Mahindra Bank">Kotak Mahindra Bank</option>
				<option value="Lakshmi Vilas Bank - Corporate Banking">Lakshmi Vilas Bank - Corporate Banking</option>
				<option value="Lakshmi Vilas Bank - Retail Banking">Lakshmi Vilas Bank - Retail Banking</option>
				<option value="NKGSB Co-operative Bank">NKGSB Co-operative Bank</option>
				<option value="Oriental Bank Of Commerce">Oriental Bank Of Commerce</option>
				<option value="Punjab And Maharashtra Co-operative Bank limited">Punjab And Maharashtra Co-operative Bank limited</option>
				<option value="Punjab And Sind Bank">Punjab And Sind Bank</option>
				<option value="Punjab National Bank - Corporate Banking">Punjab National Bank - Corporate Banking</option>
				<option value="Punjab National Bank - Retail Banking">PNB - Punjab National Bank - Retail Banking</option>
				<option value="RBL Bank">RBL Bank</option>
				<option value="Saraswat Co-operative Bank">Saraswat Co-operative Bank</option>
				<option value="SBI NB">SBI NB</option>
				<option value="Shamrao Vithal Co-operative Bank">Shamrao Vithal Co-operative Bank</option>
				<option value="South Indian Bank">South Indian Bank</option>
				<option value="Standard Chartered Bank">Standard Chartered Bank</option>
				<option value="State Bank of Bikaner and Jaipur">State Bank of Bikaner and Jaipur</option>
				<option value="State Bank of Hyderabad">State Bank of Hyderabad</option>
				<option value="State Bank of India">SBI - State Bank of India</option>
				<option value="State Bank of Mysore">State Bank of Mysore</option>
				<option value="State Bank of Patiala">State Bank of Patiala</option>
				<option value="State Bank of Travancore">State Bank of Travancore</option>
				<option value="Syndicate Bank">Syndicate Bank</option>
				<option value="Tamilnadu Mercantile Bank">Tamilnadu Mercantile Bank</option>
				<option value="Tamilnadu State Apex Co-operative Bank">Tamilnadu State Apex Co-operative Bank</option>
				<option value="UCO Bank">UCO Bank</option>
				<option value="Union Bank - Corporate Netbanking">Union Bank - Corporate Netbanking</option>
				<option value="Union Bank of India">Union Bank of India</option>
				<option value="United Bank of India">United Bank of India</option>
				<option value="Vijaya Bank">Vijaya Bank</option>
				<option value="Yes Bank">Yes Bank</option>
			</select>
			<input class="w94" type="text"  name="bank_code_text" style="margin:5px 0;display:none;" />
		  </div>
		  <? }?>
		  
		  
		  
		   <?
		  ###############
		   if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankingLogo') !== false){?>
	  <div class="IndiaBankingLogo_div ewalist hide">
		<div class="banksDiv desImg SBIN"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm" >SBI</span></div>
		<div class="banksDiv desImg ICIC"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI</span></div>
		<div class="banksDiv desImg HDFC"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm" >HDFC</span></div>
		<div class="banksDiv desImg UTIB"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm" >Axis</span></div>
		<div class="banksDiv desImg KKBK"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
		<div class="banksDiv desImg PUNB_R"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
	  </div>
	  <?}?>
	  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'allPayIndiaBankingList') !== false){?>
	  <div class="allPayIndiaBankingList_div ewalist hide">
		<select class="w94 dropDwn required my-2" name="bank_code" id="bank_code" style="margin:5px 0;" data-required="required">
		  <option value="" selected="selected">Bank Name</option>
		  <option value="ABPB">Aditya Birla Idea Payments Bank</option>
		  <option value="AIRP">Airtel Payments Bank</option>
		  <option value="ALLA">Allahabad Bank</option>
		  <option value="ANDB">Andhra Bank</option>
		  <option value="BARB_R">Bank of Baroda - Retail Banking</option>
		  <option value="BBKM">Bank of Bahrein and Kuwait</option>
		  <option value="BKDN">Dena Bank</option>
		  <option value="BKID">Bank of India</option>
		  <option value="CBIN">Central Bank of India</option>
		  <option value="CIUB">City Union Bank</option>
		  <option value="CNRB">Canara Bank</option>
		  <option value="CORP">Corporation Bank</option>
		  <option value="COSB">Cosmos Co-operative Bank</option>
		  <option value="CSBK">Catholic Syrian Bank</option>
		  <option value="DBSS">Development Bank of Singapore</option>
		  <option value="DCBL">DCB Bank</option>
		  <option value="DEUT">Deutsche Bank</option>
		  <option value="DLXB">Dhanlaxmi Bank</option>
		  <option value="ESFB">Equitas Small Finance Bank</option>
		  <option value="FDRL">Federal Bank</option>
		  <option value="HDFC">HDFC Bank</option>
		  <option value="IBKL">IDBI</option>
		  <option value="ICIC">ICICI Bank</option>
		  <option value="IDFB">IDFC FIRST Bank</option>
		  <option value="IDIB">Indian Bank</option>
		  <option value="INDB">Indusind Bank</option>
		  <option value="IOBA">Indian Overseas Bank</option>
		  <option value="JAKA">Jammu and Kashmir Bank</option>
		  <option value="JSBP">Janata Sahakari Bank (Pune)</option>
		  <option value="KARB">Karnataka Bank</option>
		  <option value="KKBK">Kotak Mahindra Bank</option>
		  <option value="KVBL">Karur Vysya Bank</option>
		  <option value="LAVB_C">Lakshmi Vilas Bank - Corporate Banking</option>
		  <option value="LAVB_R">Lakshmi Vilas Bank - Retail Banking</option>
		  <option value="MAHB">Bank of Maharashtra</option>
		  <option value="NKGS">NKGSB Co-operative Bank</option>
		  <option value="ORBC">Oriental Bank of Commerce</option>
		  <option value="PMCB">Punjab & Maharashtra Co-operative Bank</option>
		  <option value="PSIB">Punjab & Sind Bank</option>
		  <option value="PUNB_R">PNB - Punjab National Bank - Retail Banking</option>
		  <option value="RATN">RBL Bank</option>
		  <option value="SBBJ">State Bank of Bikaner and Jaipur</option>
		  <option value="SBHY">State Bank of Hyderabad</option>
		  <option value="SBIN">SBI - State Bank of India</option>
		  <option value="SBMY">State Bank of Mysore</option>
		  <option value="SBTR">State Bank of Travancore</option>
		  <option value="SCBL">Standard Chartered Bank</option>

		  <option value="SIBL">South Indian Bank</option>
		  <option value="SRCB">Saraswat Co-operative Bank</option>
		  <option value="STBP">State Bank of Patiala</option>
		  <option value="SVCB">Shamrao Vithal Co-operative Bank</option>
		  <option value="SYNB">Syndicate Bank</option>
		  <option value="TMBL">Tamilnadu Mercantile Bank</option>
		  <option value="TNSC">Tamilnadu State Apex Co-operative Bank</option>
		  <option value="UBIN">Union Bank of India</option>
		  <option value="UCBA">UCO Bank</option>
		  <option value="UTBI">United Bank of India</option>
		  <option value="UTIB">Axis Bank</option>
		  <option value="VIJB">Vijaya Bank</option>
		  <option value="YESB">Yes Bank</option>
		</select>
		<input class="w94" type="text" name="bank_code_text" style="margin:5px 0;display:none;" />
	  </div>
	  <? 
	  }?>
	  
	  
	  <? //BANK LIST AND LOGO FOR SABPAISA - ADDED ON 2-12 BY ?>
	<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'sabPaisaBankLogo')!==false){?>
		<div class="sabPaisaBankLogo_div ewalist hide">
			
			
			<div class="banksDiv desImg 17"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI</span></div>
			<div class="banksDiv desImg 26"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
			<div class="banksDiv desImg 30"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
			<div class="banksDiv desImg 8006"><span class="banks_sprite banks_bank_7" style="vertical-align:middle;"></span><span class="bankNm txNm">IDFC</span></div>
		</div>
	<? }?>
	
	<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'sabPaisaBankList') !== false){?>
		<div class="sabPaisaBankList_div ewalist hide">
			<select class="w94 dropDwn required form-select from-select-sm" name="bankCode" id="bankCode" style="margin:5px 0;">
				<option value="40">Bank of India</option>
				<option value="5">Bank of Maharashtra</option>
				<option value="8">Catholic Syrian Bank</option>
				<option value="9">Central Bank of India</option>
				<option value="6">City Union Bank</option>
				<option value="12">Deutsche Bank</option>
				<option value="13">Dhanlaxmi Bank</option>
				<option value="14">Equitas Bank</option>
				<option value="17">ICICI Bank</option>
				<option value="18">IDBI Bank</option>
				<option value="8006">IDFC FIRST Bank Limited</option>
				<option value="20">Indian Overseas Bank</option>
				<option value="21">Indusind Bank</option>
				<option value="8005">Janata Sahakari Bank LTD Pune</option>
				<option value="22">Jammu and Kashmir Bank</option>
				<option value="23">Karnataka Bank</option>
				<option value="24">Karur Vysya Bank</option>
				<option value="26">Kotak Mahindra Bank</option>
				<option value="25">Lakshmi Vilas Bank NetBanking</option>
				<option value="28">Punjab & Sind Bank</option>
				<option value="30">PNB -Punjab National Bank Retail</option>
				<option value="31">RBL Bank</option>
				<option value="36">Tamilnad Mercantile Bank</option>
				<option value="37">UCO Bank</option>
				<option value="38">Union Bank of India - Retail</option>
				<option value="41">Yes Bank</option>
			</select>
		<input class="w94" type="text"  name="bankCode_text" style="margin:5px 0;display:none;" />
		</div>
	<? }?>
	<? //BANK LIST AND LOGO FOR SABPAISA - END?>
	
	
	<?	############

	######### LIST FOR PAY U MONEY ######
	if(isset($post['t_name6'])&&strpos($post['t_name6'],'payuBankingLogo') !== false){?>
	<div class="payuBankingLogo_div ewalist hide">
		<div class="banksDiv desImg SBIB"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm" >SBI</span></div>
		<div class="banksDiv desImg ICIB"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm" >ICICI</span></div>
		<div class="banksDiv desImg HDFB"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm" >HDFC</span></div>
		<div class="banksDiv desImg AXIB"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm" >Axis</span></div>
		<div class="banksDiv desImg 162B"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm" >Kotak</span></div>
		<div class="banksDiv desImg PNBB"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
	</div>
	<?
	}
	
	######### LIST FOR PAY U MONEY ######

	######### LIST FOR Grezpay ######
	if(isset($post['t_name6'])&&strpos($post['t_name6'],'grezpayBankingLogo') !== false){?>
	<div class="grezpayBankingLogo_div ewalist hide">
		<div class="banksDiv desImg 1030"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">SBI</span></div>
		<div class="banksDiv desImg 1013"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm">ICICI</span></div>
		<div class="banksDiv desImg 1004"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm">HDFC</span></div>
		<div class="banksDiv desImg 1005"><span class="banks_sprite banks_bank_4" style="vertical-align:middle;"></span><span class="bankNm txNm">AXIS</span></div>
		<div class="banksDiv desImg 1012"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm">KOTAK</span></div>
		<!--<div class="banksDiv desImg 1091"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">ANDHRA</span></div>-->
	</div>
	<?
	}
	if(isset($post['t_name6'])&&strpos($post['t_name6'],'allPaygrezpayBankingList') !== false){?>
	<div class="allPaygrezpayBankingList_div ewalist hide">
		<select class="w94 dropDwn required" name="bank_code" id="bank_code" style="margin:5px 0;" data-required="required">
			<option value="1000">Allahabad Bank</option>
			<option value="1091">Andhra Bank</option>
			<option value="1135">AU Small Finance Bank</option>
			<option value="1005">AXIS Bank</option>
			<option value="1093">Bank of Baroda Retail Accounts</option>
			<option value="1009">Bank of India</option>
			<option value="1064">Bank of Maharashtra</option>
			<option value="1025">Canara Bank</option>
			<option value="1094">Catholic Syrian Bank</option>
			<option value="1063">Central Bank of India</option>
			<option value="1043">City Union Bank</option>
			<option value="1034">Corporation Bank</option>
			<option value="1104">COSMOS Bank</option>
			<option value="1026">Deutsche Bank</option>
			<option value="1040">Development Credit Bank</option>
			<option value="1107">Dhanalaxmi Bank</option>
			<option value="1027">Federal Bank</option>
			<option value="1004">HDFC Bank</option>
			<option value="1013">ICICI Bank</option>
			<option value="1120">IDFC Bank</option>
			<option value="1069">Indian Bank</option>
			<option value="1049">Indian Overseas Bank</option>
			<option value="1054">Indusind Bank</option>
			<option value="1003">Industrial Development Bank of India</option>
			<option value="1041">Jammu and Kashmir Bank</option>
			<option value="1032">Karnataka Bank Ltd</option>
			<option value="1048">Karur vysya Bank</option>
			<option value="1012">Kotak Bank</option>
			<option value="1095">Lakshmi Vilas Bank</option>
			<option value="1042">Oriental Bank of Commerce</option>
			<option value="1129">Punjab National Bank</option>
			<option value="1053">Ratnakar Bank</option>
			<option value="1113">Shamrao Vithal Co-operative Bank</option>
			<option value="1045">South Indian Bank</option>
			<option value="1050">State Bank of Bikaner and Jaipur</option>
			<option value="1030">SBI - State Bank of India</option>
			<option value="1065">Tamilnad Mercantile Bank</option>
			<option value="1038">Union Bank of India</option>
			<option value="1046">United Bank of India</option>
			<option value="1044">Vijaya Bank</option>
			<option value="1001">Yes Bank</option>
			<option value="1103">UCO Bank</option>
		</select>
	<input class="w94" type="text" name="bank_code_text" style="margin:5px 0;display:none;" />
	</div>
	<? 
	}
	######### LIST FOR Grezpay ######

	######### BANK LIST FOR SAFEX PAY ######
	if(isset($post['t_name6'])&&strpos($post['t_name6'],'safexBankingLogo') !== false){?>
	<div class="safexBankingLogo_div ewalist hide">
		<div class="banksDiv desImg 1186"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm" >Andhra</span></div>
		<div class="banksDiv desImg 1210"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm" >PNB</span></div>
	</div>
	<?
	}
	if(isset($post['t_name6'])&&strpos($post['t_name6'],'safexBankingList') !== false){?>
	<div class="safexBankingList_div ewalist hide">
		<select class="w94 dropDwn required" name="bank_code" id="bank_code" style="margin:5px 0;" data-required="required">
			<option value="1186">Andhra Bank</option>
			<option value="1220">Bank of India</option>
			<option value="1187">Bank Of Maharashtra</option>
			<option value="1189">Canara Bank</option>
			<option value="1190">Central Bank of India</option>
			<option value="1191">City Union Bank</option>
			<option value="1001">Cosmos Bank</option>
			<option value="1193">Dena Bank</option>
			<option value="1194">Deutsche Bank</option>
			<option value="1195">Development Credit Bank</option>
			<option value="1196">Dhanlaxmi Bank</option>
			<option value="1003">Equitas Small Finance Bank</option>
			<option value="1179">IDFC FIRST Bank</option>
			<option value="1197">Indian Bank</option>
			<option value="1198">Indian Overseas Bank</option>
			<option value="1199">IndusInd Bank</option>
			<option value="1200">Industrial Development Bank of India</option>
			<option value="48">Jammu and Kashmir Bank</option>
			<option value="1201">Janata Sahakari Bank Pune</option>
			<option value="1202">Karnataka Bank</option>
			<option value="1203">Karur Vysya - Corporate Netbanking</option>
			<option value="45">Kotak Bank</option>
			<option value="1204">Lakshmi Vilas Bank - Corporate Netbanking</option>
			<option value="1205">Lakshmi Vilas Bank - Retail Netbanking</option>
			<option value="1206">Nainital Bank</option>
			<option value="1309">PayTM Bank</option>
			<option value="1207">Punjab And Maharashtra Co-operative Bank Limited</option>
			<option value="1208">Punjab And Sind Bank</option>
			<option value="1209">Punjab National Bank - Corporate Banking</option>
			<option value="1210">PNB-Punjab National Bank - Retail Banking</option>
			<option value="1211">Saraswat bank</option>
			<option value="1212">Shamrao Vithal Co-operative Bank Ltd</option>
			<option value="601">South Indian Bank</option>
			<option value="1213">Syndicate Bank</option>
			<option value="1214">Tamilnad Mercantile Bank</option>
			<option value="1215">The Karur Vysya Bank</option>
			<option value="1217">UCO Bank</option>
			<option value="1218">Union Bank - Corporate Netbanking</option>
			<option value="1183">Union Bank Of India</option>
			<option value="2142">UNION BANK OF INDIA RETAIL</option>
			<option value="1219">United Bank of India</option>
			<option value="47">Yes Bank</option>
		</select>
	<input class="w94" type="text" name="bank_code_text" style="margin:5px 0;display:none;" />
	</div>
	<? 
	}
	######### BANK LIST FOR SAFEX PAY ######


		if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankingAtomLogo') !== false){?>
		  <div class="IndiaBankingAtomLogo_div ewalist hide">
			<div class="banksDiv desImg 1014"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">SBI</span></div>
			<div class="banksDiv desImg 1002"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm">ICICI</span></div>
			<div class="banksDiv desImg 1006"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm">HDFC</span></div>
			<div class="banksDiv desImg 1073"><span class="banks_sprite banks_bank_7" style="vertical-align:middle;"></span><span class="bankNm txNm">IDFC</span></div>
			<div class="banksDiv desImg 1013"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm">Kotak</span></div>
			<div class="banksDiv desImg 1049"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm">PNB</span></div>
		  </div>
		  <?}?>
		  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'atomIndiaBankingList') !== false){?>
		  <div class="atomIndiaBankingList_div ewalist hide">
			<select class="w94 dropDwn hide " name="bank_code_at" id="bank_code" style="margin:5px 0;">
			  <option value="" disabled="">Choose Bank</option>
			  <option value="1075">Bank of Baroda Net Banking Corporate</option>
				<option value="1076">Bank of Baroda Net Banking Retail</option>
				<option value="1012">Bank of India</option>
				<option value="1033">Bank of Maharashtra</option>
				<option value="1030">Canara Bank NetBanking</option>
				<option value="1028">Central Bank of India</option>
				<option value="1031">CSB Bank</option>
				<option value="1027">DCB Bank</option>
				<option value="1024">Deutsche Bank</option>
				<option value="1038">Dhanlaxmi Bank</option>
				<option value="1063">Equitas Bank</option>
				<option value="1019">Federal Bank</option>
				<option value="1006">HDFC Bank</option>
				<option value="1002">ICICI Bank</option>
				<option value="1007">IDBI Bank</option>
				<option value="1073">IDFC FIRST Bank Limited</option>
				<option value="1026">Indian Bank</option>
				<option value="1029">Indian Overseas Bank</option>
				<option value="1015">Indusind Bank</option>
				<option value="1001">Jammu and Kashmir Bank</option>
				<option value="1072">Janata Sahakari Bank LTD Pune</option>
				<option value="1008">Karnataka Bank</option>
				<option value="1018">Karur Vysya Bank</option>
				<option value="1013">Kotak Mahindra Bank</option>
				<option value="1009">Lakshmi Vilas Bank NetBanking</option>
				<option value="1055">Punjab & Sind Bank</option>
				<option value="1077">Punjab National Bank - Corporate</option>
				<option value="1049">PNB - Punjab National Bank [Retail]</option>
				<option value="1066">RBL Bank</option>
				<option value="1051">Standard Chartered Bank</option>
				<option value="1014">SBI - State Bank of India</option>
				<option value="1044">Tamilnad Mercantile Bank</option>
				<option value="1057">UCO Bank</option>
				<option value="1016">Union Bank of India - Retail</option>
				<option value="1005">Yes Bank</option>
			</select>
			<input class="w94" type="text"  name="bank_code_text" style="margin:5px 0;display:none;" />
		  </div>
		  <?}?>

		  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IndiaBankingIsgLogo') !== false){?>
		  <div class="IndiaBankingIsgLogo_div ewalist hide">
			<div class="banksDiv desImg 1014"><span class="banks_sprite banks_bank_1" style="vertical-align:middle;"></span><span class="bankNm txNm">SBI</span></div>
			<div class="banksDiv desImg 1002"><span class="banks_sprite banks_bank_2" style="vertical-align:middle;"></span><span class="bankNm txNm">ICICI</span></div>
			<div class="banksDiv desImg 1006"><span class="banks_sprite banks_bank_3" style="vertical-align:middle;"></span><span class="bankNm txNm">HDFC</span></div>
			<div class="banksDiv desImg 1073"><span class="banks_sprite banks_bank_7" style="vertical-align:middle;"></span><span class="bankNm txNm">IDFC</span></div>
			<div class="banksDiv desImg 1013"><span class="banks_sprite banks_bank_5" style="vertical-align:middle;"></span><span class="bankNm txNm">Kotak</span></div>
			<div class="banksDiv desImg 1049"><span class="banks_sprite banks_bank_6" style="vertical-align:middle;"></span><span class="bankNm txNm">PNB</span></div>
		  </div>
		  <?}?>
		  <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'IsgIndiaBankingList') !== false){?>
		  <div class="IsgIndiaBankingList_div ewalist hide">
			<select class="w94 dropDwn hide " name="bank_code_at" id="bank_code" style="margin:5px 0;">
			  <option value="" disabled="">Choose Bank</option>
			  <option value="2001">Demo</option>
			  <option value="1075">Bank of Baroda Net Banking Corporate</option>
				<option value="1076">Bank of Baroda Net Banking Retail</option>
				<option value="1012">Bank of India</option>
				<option value="1033">Bank of Maharashtra</option>
				<option value="1030">Canara Bank NetBanking</option>
				<option value="1028">Central Bank of India</option>
				<option value="1031">CSB Bank</option>
				<option value="1027">DCB Bank</option>
				<option value="1024">Deutsche Bank</option>
				<option value="1038">Dhanlaxmi Bank</option>
				<option value="1063">Equitas Bank</option>
				<option value="1019">Federal Bank</option>
				<option value="1006">HDFC Bank</option>
				<option value="1002">ICICI Bank</option>
				<option value="1007">IDBI Bank</option>
				<option value="1073">IDFC FIRST Bank Limited</option>
				<option value="1026">Indian Bank</option>
				<option value="1029">Indian Overseas Bank</option>
				<option value="1015">Indusind Bank</option>
				<option value="1001">Jammu and Kashmir Bank</option>
				<option value="1072">Janata Sahakari Bank LTD Pune</option>
				<option value="1008">Karnataka Bank</option>
				<option value="1018">Karur Vysya Bank</option>
				<option value="1013">Kotak Mahindra Bank</option>
				<option value="1009">Lakshmi Vilas Bank NetBanking</option>
				<option value="1055">Punjab & Sind Bank</option>
				<option value="1077">Punjab National Bank - Corporate</option>
				<option value="1049">PNB - Punjab National Bank [Retail]</option>
				<option value="1066">RBL Bank</option>
				<option value="1051">Standard Chartered Bank</option>
				<option value="1014">SBI - State Bank of India</option>
				<option value="1044">Tamilnad Mercantile Bank</option>
				<option value="1057">UCO Bank</option>
				<option value="1016">Union Bank of India - Retail</option>
				<option value="1005">Yes Bank</option>
			</select>
			<input class="w94" type="text"  name="bank_code_text" style="margin:5px 0;display:none;" />
		  </div>
		  <?}?>
		  
		  

<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'SingporeBankLogo') !== false){?>
<div class="SingporeBankLogo_div ewalist hide universl">
	<div class="row">
		<div class="col-sm-4 border p-2 desImg sprite SC" title="Standard Chartered"><span class="imgs" style="vertical-align:middle;"><img class="bank_img" src="<?=@$data['Host']?>/images/standardChartered.png"  /></span><span class="bankNm txNm">STANDARD CHARTERED</span></div>
		<div class="col-sm-4 border p-2 desImg sprite HSBC0223" title="HSBC Bank Malaysia Berhad"><span class="imgs" style="vertical-align:middle;"><img class="bank_img" src="<?=@$data['Host']?>/images/HSBC.png" /></span><span class="bankNm txNm">HSBC Bank Malaysia Berhad</span></div>
		<div class="col-sm-4 border p-2 desImg sprite RHB0218" title="RHB Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img class="bank_img" src="<?=@$data['Host']?>/images/RHB Bank.png" /></span><span class="bankNm txNm">RHB Bank Berhad</span></div>
		<div class="col-sm-4 border p-2 desImg sprite ABB0233" title="Affin Bank Berhad"><span class="imgs" style="vertical-align:middle;"><img class="bank_img" src="<?=@$data['Host']?>/images/Affin Bank Berhad.png" /></span><span class="bankNm txNm">Affin Bank Berhad</span></div>
	</div>
</div>
<? } ?>
 <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'SingaporeList') !== false){?>
  <div class="SingaporeList_div ewalist hide">
	<select class="w94 dropDwn required" name="bankCode" id="bankCode" style="margin:5px 0;">
	  <option value="" selected="selected">Bank Name</option>
	  <option value="DBS">DBS BANK LIMITED</option>
	  <option value="MBB">MAYBANK</option>
	  <option value="MBBE">MAYBANK</option>
	  <option value="OCBC">OCBC BANK</option>
	  <option value="SC">STANDARD CHARTERED</option>
	  <option value="UOB">UNITED OVERSEAS BANK LIMITED</option>
	</select>
	<input class="w94" type="text"  name="bankCode_text" style="margin:5px 0;display:none;" />
  </div>
<? } ?>
	  
 <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'MalaysianList') !== false){?>
  <div class="MalaysianList_div ewalist hide">
        <select class="w94 dropDwn required" name="bankCode" id="bankCode" style="margin:5px 0;">
          <option value="" selected="selected">Bank Name</option>
          <option value="AMBANK">AMBANK</option>
          <option value="BIMB">BANK ISLAM BERHAD</option>
          <option value="BKRM">BANK RAKYAT MALAYSIA</option>
          <option value="BSN">BANK SIMPANAN NASIONAL</option>
          <option value="CIMB">CIMB</option>
          <option value="HLB">HONG LEONG</option>
          <option value="MAYBANK">MAYBANK</option>
          <option value="PBE">PUBLIC BANK BERHAD</option>
          <option value="RHB">RHB BANK</option>
        </select>
        <input class="w94" type="text"  name="bankCode_text" style="margin:5px 0;display:none;" />
  </div>
<? } ?>

 
 <? if(isset($post['t_name6'])&&strpos($post['t_name6'],'VietnameseList') !== false){?>
  <div class="VietnameseList_div ewalist hide">
        <select class="w94 dropDwn required" name="bankCode" id="bankCode" style="margin:5px 0;">
          <option value="" selected="selected">Bank Name</option>
          <option value="ABB">AN BINH</option>
          <option value="ACB">ACB</option>
          <option value="AGB">AGRIBANK</option>
          <option value="BAB">BAC A BANK</option>
<option value="BIDV">BIDV</option>
          <option value="BII">BANK INTERNASIONAL INDONESIA</option>
          <option value="BVB">BAO VIET BANK</option>
          <option value="CTB">CITIBANK</option>
          <option value="DAB">DONGA BANK</option>
          <option value="EXB">EXIMBANK</option>
          <option value="GAB">DAI A</option>
          <option value="GPB">GPBANK</option>
          <option value="HDB">HDBANK</option>
          <option value="HSBC">HSBC</option>
          <option value="ICB">VIETINBANK</option>
          <option value="KLB">KIEN LONG</option>
          <option value="LPB">BUU DIEN LIEN VIET</option>
<option value="MBB">MB</option>
          <option value="MSB">MARITIMEBANK</option>
          <option value="NAB">NAMABANK</option>
          <option value="NCB">NATIONAL CITIZEN BANK</option>
          <option value="NVB">NATIONAL CITIZEN BANK</option>
          <option value="OCB">ORIENT COMMERCIAL JOINT STOCK BANK</option>
          <option value="OJB">OCEANBANK</option>
          <option value="PGB">PGBANK</option>
          <option value="PVC">VIETNAM PUBLIC JOINT-STOCK COMMERCIAL BANK</option>
          <option value="SCB">SAI GON JOINT STOCK COMMERCIAL BANK</option>
          <option value="SEAB">TMCP DONG NAM A SEABANK</option>
          <option value="SGB">SAIGON BANK</option>
          <option value="SHB">SHB</option>
          <option value="SHNB">SHINHAN</option>
          <option value="STB">SACOMBANK</option>
          <option value="TCB">TECHCOMBANK</option>
          <option value="TPB">TIENPHONGBANK</option>
          <option value="VAB">VIETA BANK</option>
          <option value="VAB">VIETA BANK</option>
          <option value="VCB">VIETCOMBANK</option>
          <option value="VIB">VIB</option>
          <option value="VPB">VPBANK</option>
        </select>
        <input class="w94" type="text"  name="bankCode_text" style="margin:5px 0;display:none;" />
  </div>
<? } ?>


		
<? if(isset($post['t_name6'])&&strpos($post['t_name6'],'ThaiList') !== false){?>
  <div class="ThaiList_div ewalist hide">
        <select class="w94 dropDwn required" name="bankCode" id="bankCode" style="margin:5px 0;">
          <option value="" selected="selected">Bank Name</option>
          <option value="BAY">BANK OF AYUDHYA (KRUNGSRI)</option>
          <option value="BBL">BANGKOK BANK</option>
          <option value="CIMB">CIMB THAI</option>
          <option value="GSB">GOVERNMENT SAVINGS BANK</option>
          <option value="KBANK">KASIKORN BANK</option>
          <option value="KKB">KIATNAKIN BANK</option>
          <option value="KTB">KRUNGTHAI BANK</option>
          <option value="SCB">SIAM COMMERCIAL BANK</option>
          <option value="TISC">TISCO BANK</option>
          <option value="TMB">TMB BANK</option>
          <option value="TTB">THANACHART BANK</option>
          <option value="UOB">UNITED OVERSEAS BANK</option>
        </select>
        <input class="w94" type="text"  name="bankCode_text" style="margin:5px 0;display:none;" />
  </div>
<? } ?>
