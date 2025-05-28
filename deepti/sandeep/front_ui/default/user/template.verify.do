              <? if(isset($data['ScriptLoaded'])){ ?>
			  
<div class="container-sm mt-2 mb-2 border bg-white rounded vkg" >			  
<? if($post['action']=='verify'){ ?>

<div id="wrapper">	
		<div id="content">
			<ul class="breadcrumb">
				<li><a href="<?=$data['Host'];?>/index<?=$data['ex']?>" class="glyphicons home"><i></i> <?=prntext($data['SiteName'])?></a></li>
				<li class="divider"></li>
				<li>Verify</li>
			</ul>
			<div class="separator"></div>
			<div class="heading-buttons">
				<div class="clearfix" style="clear: both;"></div>
			</div>
			<div class="separator"></div>
			<div class="well">
				<div class="widget widget-gray widget-body-white" style="background:none repeat scroll 0 0 #FAFAFA;">
						Information what documents merchant should send to site administrator to verify their account...
			    </div>
			</div>
		</div>
</div>



<? }elseif($post['action']=='certify'){ ?>

Information what documents merchant should send to site administrator to certify their account...

<? }else{ ?>

<div id="wrapper">	
			<div id="menu" class="hidden-phone">
			<div id="menuInner">
				
				<ul>
					<li class="heading"><span>Navigation</span></li>
					<li class="glyphicons home"><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>"><i></i><span>Dashboard</span></a></li>
					<li class="hasSubmenu">
						<a data-toggle="collapse" class="glyphicons user" href="#menu_profile"><i></i><span>My Account</span></a>
						<ul class="collapse" id="menu_profile">
							<li class=""><a href="<?=$data['USER_FOLDER']?>/profile<?=$data['ex']?>"><span>Edit My Account</span></a></li>
							<li class=""><a href="<?=$data['USER_FOLDER']?>/emails<?=$data['ex']?>"><span>Add/Edit Emails</span></a></li>
							<li class=""><a href="<?=$data['USER_FOLDER']?>/password<?=$data['ex']?>"><span>Account Security</span></a></li>
						
						</ul>
					</li>
					<li class="glyphicons credit_card"><a href="<?=$data['USER_FOLDER']?>/card<?=$data['ex']?>"><i></i><span>My Credit Cards</span></a></li>
					<li class="glyphicons bank"><a href="<?=$data['USER_FOLDER']?>/bank<?=$data['ex']?>"><i></i><span>My Bank Accounts</span></a></li>
						
			
				</ul>
				<ul>
					<li class="heading"><span>Merchants</span></li>
					
					   <li class="glyphicons cargo"><a href="<?=$data['USER_FOLDER']?>/products<?=$data['ex']?>"><i></i><span>Products</span></a></li>

<li class="glyphicons coffe_cup"><a href="<?=$data['USER_FOLDER']?>/donations<?=$data['ex']?>"><i></i><span>Donations</span></a></li>
<li class="glyphicons restart"><a href="<?=$data['USER_FOLDER']?>/subscriptions<?=$data['ex']?>"><i></i><span>Subscriptions</span></a></li>
<li class="glyphicons shopping_cart"><a href="<?=$data['USER_FOLDER']?>/shopcart<?=$data['ex']?>"><i></i><span>Shopping Cart</span></a></li>
<li class="glyphicons magic"><a href="<?=$data['USER_FOLDER']?>/payment<?=$data['ex']?>"><i></i><span>Simple Payments</span></a></li>
							
					
					</li>
				
				</ul>
			</div>
		</div>
		<div id="content">
			<ul class="breadcrumb">
				<li><a href="index<?=$data['ex']?>" class="glyphicons home"><i></i> <?=prntext($data['SiteName'])?></a></li>
				<li class="divider"></li>
				<li>Verify</li>
			</ul>
			<div class="separator"></div>
			<div class="heading-buttons">
				<div class="clearfix" style="clear: both;"></div>
			</div>
			<div class="separator"></div>
			<div class="well">
				<div class="widget widget-gray widget-body-white" style="background:none repeat scroll 0 0 #FAFAFA;">
						Your account status can be viewed on the <a href="<?=$data['Host']?>/ndex<?=$data['ex']?>">Overview</a> page from within your account. When making purchases, the status of the vendor is available on the online form to submit payment. These account statuses are available for your protection. Please use the status to help make a decision concerning your purchase or receipt of funds. To obtain the status of a sender of funds, log into your accounts history and view the transaction details. The status of the sender or receiver is available there.<br><br>
						<table width=100% class=frame cellspacing=1 cellpadding=4>
						<tr><td class=capl>YOUR ACCOUNT CAN HAVE SEVERAL DIFFERENT STATUS LEVELS AS DEFINED BELOW</td></tr>
						<tr><td class=input style="text-align:justify">
						<font color=#FF0000><u><b>UNVERIFIED MERCHANT</b></u></font>
						<blockquote style="margin:10px 10px 10px 10px">
						<b><i>UNVERIFIED</i></b> status means that your account has not been verified. Accounts with <b><i>UNVERIFIED</i></b> status may experience delays in receiving withdrawals and completion of spends to vendors. Accounts with <b><i>UNVERIFIED</i></b> status will have some <u>restrictions</u> on the amount that can be used for transactions, deposits, withdrawals and escrows. See restrictions for <b><i>UNVERIFIED</i></b> status below.
						</blockquote>
						</td></tr>
						<tr><td class=input style="text-align:justify">
						<font color=#FF0000><u><b>VERIFIED MERCHANT</b></u></font>
						<blockquote style="margin:10px 10px 10px 10px">
						<b><i>VERIFIED</i></b> status means that your account has been verified. Accounts with <b><i>VERIFIED</i></b> status will not have any delays in receiving withdrawals and completion of spends to vendors. Accounts with <b><i>VERIFIED</i></b> status will not have any <u>restrictions</u> on the amount that can be used for the transaction. See benefits for <b><i>VERIFIED</i></b> status below.
						</blockquote>
						</td></tr>
						<tr><td class=input style="text-align:justify">
						<font color=#FF0000><u><b>CERTIFIED MERCHANT</b></u></font>
						<blockquote style="margin:10px 10px 10px 10px">
						<b><i>CERTIFIED</i></b> users have been phone verified, and have faxed or mailed a copy of their <u>Government</u> issued identification and a copy of a recent utility bill verifying (certifying) the address match to the account profile. <b><i>CERTIFIED</i></b> status is requested and will greatly increase processing time for all accounts receiving payments and wishing to withdraw funds. <b><i>CERTIFIED</i></b> status does not have any restrictions for transactions. Use our <a href="<?=$data['Host']?>/contact<?=$data['ex']?>">Contact Us</a> page to get e-mail address and phone/fax numbers. See benefits for <b><i>CERTIFIED</i></b> status below.
						</blockquote>
						</td></tr>
						</table>
						<br>
						<table width=100% class=frame cellspacing=1 cellpadding=4>
						<tr><td class=capl>RESTRICTIONS FOR DIFFERENT STATUS LEVELS IS DEFINED BELOW</td></tr>
						<tr><td class=input>
						<font color=#FF0000><u><b>RESTRICTIONS FOR UNVERIFIED MERCHANT</b></u></font>
						<ol>
						 <li>Maximal <i>deposit</i> in the system cannot be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['DepositMaxSum'])?></b> per month;</li>
						 <li>Maximal <i>withdraw</i> from the system cannot be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['WithdrawMaxSum'])?></b> per month;</li>
						 <li>Maximal <i>transfer</i> inside the system cannot be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction;</li>
						 <li>Maximal <i>escrow</i> inside the system cannot be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction;</li>
						 <li>Maximal <i>price for your products</i> cannot be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction;</li>
						 <li>Maximal <i>price for your subscriptions</i> cannot be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction;</li>
						 <li>Maximal <i>price for your donations</i> cannot be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction;</li>
						 <li>Maximal <i>price for your simple payments</i> cannot be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction.</li>
						</ol>
						</td></tr>
						<tr><td class=input>
						<font color=#FF0000><u><b>BENEFITS FOR VERIFIED MERCHANT</b></u></font>
						<ol>
						 <li>Maximal <i>deposit</i> in the system can be more than <b>$50,0000</b> per month;</li>
						 <li>Maximal <i>withdraw</i> from the system can be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['WithdrawMaxSum'])?></b> per month;</li>
						 <li>Maximal <i>transfer</i> inside the system can be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction;</li>
						 <li>Maximal <i>escrow</i> inside the system can be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction;</li>
						 <li>Maximal <i>price for your products</i> can be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction;</li>
						 <li>Maximal <i>price for your subscriptions</i> can be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction;</li>
						 <li>Maximal <i>price for your donations</i> can be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction;</li>
						 <li>Maximal <i>price for your simple payments</i> can be more than <b><?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMaxSum'])?></b> per transaction.</li>
						</ol>
						</td></tr>
						<tr><td class=input>
						<font color=#FF0000><u><b>BENEFITS FOR CERTIFIED MERCHANT</b></u></font>
						<ol>
						 <li>Includes all benefits for verified merchant;</li>
						 <li>Increases your online reputation, helping you attract more buyers and increase sales.</li>
						</ol>
						</td></tr>
						</table><br>
						<font color=red><b>VERIFIED/CERTIFIED STATUS DOES NOT GUARANTEE IN ANY WAY THE LEGITIMACY OF THE ACCOUNT HOLDER OR THE PRODUCT/SERVICES BEING PURCHASED/SOLD. PLEASE ALWAYS USE YOUR BEST JUDGMENT WHEN MAKING PURCHASES ON THE INTERNET AS PER OUR USER AGREEMENT. ANY ACCOUNT THAT IS NOT AT "CERTIFIED" STATUS, WILL HAVE A 5 DAY WAIT PERIOD TO WITHDRAW FUNDS FROM THEIR ACCOUNT. THE SYSTEM WILL NOT ALLOW YOU TO WITHDRAW FUNDS THAT WERE RECEIVED LESS THAN 5 DAYS PRIOR.</b></font>
			    </div>
			</div>
		</div>
</div>

<? } ?>

</div>
<? }else{ ?>SECURITY ALERT: Access Denied<? } ?>            