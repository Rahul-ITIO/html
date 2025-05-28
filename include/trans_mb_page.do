<? if(isset($post['mbt'])&&$post['mbt']){?>	
<div class="row100 funda row" style="clear:both;padding:3px 0 5px 0;border-top:1px dashed #ccc;margin-top:3px;">
<h6 style="clear:both;">Total Trans. Balance - Batch Calculation <span style="margin: 0;top:-11px;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="(Calculation done at run time. However, it fetches all values from the transaction table at the time of calculation, calculate them and show the result).

These calculations are stored in a table on a daily basis i.e. all records of one date.
"><i></i></span></h6>
		<a href="" class="span3 col-sm-6 my-2" title="Ready to Withdraw Fund - You can request a fund"><i class="far fa-hand-point-right"></i> Mature Fund <b><?=$post['mbt']['count_mature'];?> = <?=$post['mbt']['summ_mature'];?></b></a>
		<a href="" class="span3  col-sm-6 my-2" title="Total Available Balance (Sum of Mature and Immature Fund)"><i class="far fa-hand-point-right"></i> Account Balance <b><?=$post['mbt']['count_total'];?> = <?=$post['mbt']['summ_total'];?></b>
		</a>
		<a href="" class="span3  col-sm-6 my-2" title="This fund will be available to withdraw after the maturity"><i class="far fa-hand-point-right"></i> Immature Fund <b><?=$post['mbt']['count_immature'];?> = <?=$post['mbt']['summ_immature'];?></b></a>
		<span class="span3  col-sm-6 my-2"><a <? if(isset($_SESSION['login_adm'])){?> href="transactions.do?<? if(isset($post['bid'])&&$post['bid']){?>bid=<?=$post['bid']?><? } ?><? if(isset($post['StartPage'])){?>&page=<?=$post['StartPage']?><? } ?>&type=2&status=-1&action=select" title="Sum of All Previous Withdraw" <? } ?> ><i class="far fa-hand-point-right"></i> Total Withdraw Made</a> <b><?=$post['mbt']['count_withdraw'];?> = <a <? if(isset($_SESSION['login_adm'])){?> onclick="iframe_openf(this);"  data-mid="<?=$_GET['bid']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/user/withdraw.do?admin=1" <? } ?>  title="Withdraw Fund" class="glyphicons database_plus" ><?=$post['mbt']['summ_withdraw'];?></a></b></span>
		
		<div style="clear:both;"></div>
	</div>
<div style="clear:both;"></div>	

 <div class="row100 funda row" style="width:100%;padding:0px 0 5px 0; clear:both">
		<a class="span3 col-sm-6 my-2" style="clear:left;width:100%;float:left;">
		<span title="MB (Sum of Mature Balance) = Sum of Total Payable Amount Till Date">
			<i class="far fa-hand-point-right"></i> MB = <?=$post['mbt']['summ_mature_1'];?>
		</span>
		|
		<span title="MF (Sum of Monthly Fee) = Fee applicable by 1st of every month ">
		<i class="far fa-hand-point-right"></i> MF = <?=$post['mbt']['count_monthly_vt_fee'];?> X <?=$post['mbt']['monthly_vt_fee_max'];?> =<?=$post['mbt']['monthly_vt_fee'];?> 
		</span>
		|
		<span title="MF (Mature Fund) = (MB (Sum of Mature Balance) + RF (Sum of Received Fund))  - (SF (Sum of Send Fund) + MF (Sum of Monthly Fee) + WA (Sum of Withdraw Amount) + ABA (Admin  Balance Adjust))  ">
		<? $post['mbt']['mf_ab']=(prnsum($post['mbt']['summ_mature_1'])+prnsum($post['mbt']['summ_received_fund_amt']))-(prnsum($post['mbt']['summ_send_fund_amt'])+prnsum($post['mbt']['monthly_vt_fee'])+prnsum($post['mbt']['summ_withdraw_amt_1'])+prnsum($post['mbt']['manual_adjust_balance']));?>
		
		MF = (<?=$post['mbt']['summ_mature_1'];?> + <?=$post['mbt']['summ_received_fund_amt'];?>) - (<?=$post['mbt']['summ_send_fund_amt'];?> + <?=$post['mbt']['monthly_vt_fee'];?> + <?=$post['mbt']['summ_withdraw_amt_1'];?> + <?=$post['mbt']['manual_adjust_balance'];?>) = <b><?=number_formatf2($post['mbt']['mf_ab']);?></b>
		</span>
		| 
		<span title="AB (Account Balance) = MF (Mature Fund) + IF (Immature Fund)">
		AB = <?=number_formatf2($post['mbt']['mf_ab']);?> + <?=number_formatf2($post['mbt']['summ_immature_amt']);?> = <b><?=number_formatf2(prnsum($post['mbt']['mf_ab'])+prnsum($post['mbt']['summ_immature_amt']));?></b>
		</span>
		 
		</a>
		
	</div>
	
	<div class="row100 funda" style="padding:0px 0 5px 0;">
		<a href="" class="span3" title="Ready to Withdraw Rolling Fund">Mature Rolling Fund <b><?=$post['mbt']['count_mature_roll'];?> = <?=number_formatf2($post['mbt']['summ_mature_roll']);?></b></a>
		<a href="" class="span3" title="Total Available Rolling Balance (Sum of Mature and Immature Rolling)">Rolling Balance <b><?=$post['mbt']['count_total_roll'];?> = <?=number_formatf2($post['mbt']['summ_total_roll']);?></b></a>
		<a href="" class="span3" title="This fund will be available to withdraw after the Rolling Maturity">Immature Rolling Fund <b><?=$post['mbt']['count_immature_roll'];?> = <?=number_formatf2($post['mbt']['summ_immature_roll']);?></b></a>
		<span class="span3"><a <? if(isset($_SESSION['login_adm'])){?> href="transactions.do?<? if(isset($post['bid'])){?>bid=<?=$post['bid']?><? }?><? if(isset($post['StartPage'])){?>&page=<?=$post['StartPage']?><? }?>&type=3&status=-1&action=select" <? }?>  title="Sum of All Previous Rolling Withdraw">Withdraw Rolling Fund</a> <b><?=$post['mbt']['count_withdraw_roll'];?> = <a <? if(isset($_SESSION['login_adm'])){?> onclick="iframe_openf(this);" data-mid="<?=$_GET['bid']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/user/withdraw_rolling.do?admin=1" <? }?> title="Withdraw Fund"  class="glyphicons database_plus" ><?=number_formatf2($post['mbt']['summ_withdraw_roll']);?></a></b></span>
	</div>
<? }?>

<? 

if(isset($post['mbt_d']) && $post['mbt_d']){?>	
<div class="row100 funda" style="clear:both;height:45px;padding:3px 0 5px 0;border-top:1px dashed #ccc;margin-top:3px;">
<h6 style="clear:both;">Total Trans. Balance - Fee Dynamic with Batch Calculation <span style="margin: 0;top:-11px;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="(Calculation done at run time. It fetches only the Transaction amount from Transaction table and fetches all respective values from the account setting, calculate related values and show the sum of all values accordingly)"><i></i></span></h6>
		<a href="" class="span3 col-sm-6 my-2" title="Ready to Withdraw Fund - You can request a fund">Mature Fund <b><?=$post['mbt_d']['count_mature'];?> = <?=$post['mbt_d']['summ_mature'];?></b></a>
		<a href="" class="span3 col-sm-6 my-2" title="Total Available Balance (Sum of Mature and Immature Fund)">Account Balance <b><?=$post['mbt_d']['count_total'];?> = <?=$post['mbt_d']['summ_total'];?></b>
		</a>
		<a href="" class="span3 col-sm-6 my-2" title="This fund will be available to withdraw after the maturity">Immature Fund <b><?=$post['mbt_d']['count_immature'];?> = <?=$post['mbt_d']['summ_immature'];?></b></a>
		<span class="span3 col-sm-6 my-2"><a <? if(isset($_SESSION['login_adm'])){?> href="transactions.do?<? if(isset($post['bid'])){?>bid=<?=$post['bid']?><? } ?><? if(isset($post['StartPage'])){?>&page=<?=$post['StartPage']?><? } ?>&type=2&status=-1&action=select" title="Sum of All Previous Withdraw" <? } ?>  >Total Withdraw Made</a> <b><?=$post['mbt_d']['count_withdraw'];?> = <a <? if(isset($_SESSION['login_adm'])){?> onclick="iframe_openf(this);" data-mid="<?=$_GET['bid']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/user/withdraw.do?admin=1" <? } ?> title="Withdraw Fund" class="glyphicons database_plus" ><?=$post['mbt_d']['summ_withdraw'];?></a></b></span>
	</div>
	<div class="row100 funda" style="width:100%;padding:0px 0 5px 0;">
		<a class="span3" style="clear:left;width:100%;float:left;">
		<span title="MB (Sum of Mature Balance) = Sum of Total Payable Amount Till Date">
			MB = <?=$post['mbt_d']['summ_mature_1'];?>
		</span>
		|
		<span title="MF (Sum of Monthly Fee) = Fee applicable by 1st of every month ">
		MF = <?=$post['mbt_d']['count_monthly_vt_fee'];?> X <?=$post['mbt_d']['monthly_vt_fee_max'];?> =<?=$post['mbt_d']['monthly_vt_fee'];?> 
		</span>
		|
		<span title="MF (Mature Fund) = (MB (Sum of Mature Balance) + RF (Sum of Received Fund))  - (SF (Sum of Send Fund) + MF (Sum of Monthly Fee) + WA (Sum of Withdraw Amount) + ABA (Admin  Balance Adjust))  ">
		<? $post['mbt_d']['mf_ab']=(prnsum($post['mbt_d']['summ_mature_1'])+prnsum($post['mbt_d']['summ_received_fund_amt']))-(prnsum($post['mbt_d']['summ_send_fund_amt'])+prnsum($post['mbt_d']['monthly_vt_fee'])+prnsum($post['mbt_d']['summ_withdraw_amt_1'])+prnsum($post['mbt_d']['manual_adjust_balance']));?>
		MF = (<?=$post['mbt_d']['summ_mature_1'];?> + <?=$post['mbt_d']['summ_received_fund_amt'];?>) - (<?=$post['mbt_d']['summ_send_fund_amt'];?> +  <?=$post['mbt_d']['monthly_vt_fee'];?> + <?=$post['mbt_d']['summ_withdraw_amt_1'];?> + <?=$post['mbt_d']['manual_adjust_balance'];?>) = <b><?=number_formatf2($post['mbt_d']['mf_ab']);?></b>
		</span>
		| 
		<span title="AB (Account Balance) = MF (Mature Fund) + IF (Immature Fund)">
		AB = <?=number_formatf2($post['mbt_d']['mf_ab']);?> + <?=number_formatf2($post['mbt_d']['summ_immature_amt']);?> = <b><?=number_formatf2(prnsum($post['mbt_d']['mf_ab'])+prnsum($post['mbt_d']['summ_immature_amt']));?></b>
		</span>
		 
		</a>
		
	</div>
	<div class="row100 funda row" style="padding:0px 0 5px 0;">
		<a href="" class="span3 col-sm-6 my-2" title="Ready to Withdraw Rolling Fund">Mature Rolling Fund <b><?=$post['mbt_d']['count_mature_roll'];?> = <?=number_formatf2($post['mbt_d']['summ_mature_roll']);?></b></a>
		<a href="" class="span3 col-sm-6 my-2" title="Total Available Rolling Balance (Sum of Mature and Immature Rolling)">Rolling Balance <b><?=$post['mbt_d']['count_total_roll'];?> = <?=number_formatf2($post['mbt_d']['summ_total_roll']);?></b></a>
		<a href="" class="span3 col-sm-6 my-2" title="This fund will be available to withdraw after the Rolling Maturity">Immature Rolling Fund <b><?=$post['mbt_d']['count_immature_roll'];?> = <?=number_formatf2($post['mbt_d']['summ_immature_roll']);?></b></a>
		<span class="span3 col-sm-6 my-2"><a <? if(isset($_SESSION['login_adm'])){?> href="transactions.do?<? if(isset($post['bid'])){?>bid=<?=$post['bid']?><? } ?><? if(isset($post['StartPage'])){?>&page=<?=$post['StartPage']?><? } ?>&type=3&status=-1&action=select" <? } ?>  title="Sum of All Previous Rolling Withdraw" >Withdraw Rolling Fund</a> <b><?=$post['mbt_d']['count_withdraw_roll'];?> = <a <? if(isset($_SESSION['login_adm'])){?>  onclick="iframe_openf(this);"  data-mid="<?=$_GET['bid']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/user/withdraw_rolling.do?admin=1" <? } ?> title="Withdraw Fund" class="glyphicons database_plus" ><?=number_formatf2($post['mbt_d']['summ_withdraw_roll']);?></a></b></span>
	</div>
<? }?>




<? if(!isset($_GET['compare'])){?>
	
  <div class="row100 funda row" style="clear:both;padding:3px 0 5px 0;border-top:1px dashed #ccc;margin-top:3px;">
	<h6 style="clear:both;">Total Trans. Balance - Payout Transaction <span style="margin: 0;top:-11px;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="(Calculation done at the time of transaction and all values stored in the respective fields in Transaction Table)

Task done
1) All calculation done
2) Status update
"><i></i></span></h6>
		<a href="" class="span3 col-sm-6 my-2" title="Ready to Withdraw Fund - You can request a fund">Mature Fund <b><?=$post['ab']['count_mature'];?> = <?=$post['ab']['summ_mature'];?></b></a>
		<span class="span3 col-sm-6 my-2">
			<a <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['update_clients_balance'])&&$_SESSION['update_clients_balance']==1)){?>  href="<?=$data['Admins'];?>/transactions.do?bid=<?=$post['bid']?>&balance=<?=$post['ab']['summ_total_amt'];?>&rolling_bal=<?=$post['ab']['summ_total_roll'];?>&action=update_clients_balance" target="hform" <? }?> title="Total Available Balance (Sum of Mature and Immature Fund)">Account Balance <b><?=$post['ab']['count_total'];?> = <?=$post['ab']['summ_total'];?></b>
			<span class="hide"><br/>(<?=$post['ab']['count_immature'];?>+<?=$post['ab']['count_mature'];?>-<?=$post['ab']['count_refunded_amt'];?>-<?=$post['ab']['count_failed_txtfee_amt'];?>)=(<?=$post['ab']['summ_immature'];?>+<?=$post['ab']['summ_mature'];?>+<?=$post['ab']['summ_refunded_amt'];?>-<?=$post['ab']['summ_failed_txtfee_amt'];?>)</span>
			</a>
		</span>
		
		<a href="" class="span3 col-sm-6 my-2" title="This fund will be available to withdraw after the maturity">Immature Fund <b><?=$post['ab']['count_immature'];?> = <?=$post['ab']['summ_immature'];?></b></a>
		<span class="span3 col-sm-6 my-2"><a <? if(isset($_SESSION['login_adm'])){?>  href="transactions.do?<? if(isset($post['bid'])){?>bid=<?=$post['bid']?><? } ?><? if(isset($post['StartPage'])){?>&page=<?=$post['StartPage']?><? } ?>&type=2&status=-1&action=select" <? } ?> title="Sum of All Previous Withdraw" >Total Withdraw Made</a> <b><?=$post['ab']['count_withdraw'];?> = <a onclick="iframe_openf(this);" class="glyphicons database_plus" data-mid="<?=$_GET['bid']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/user/withdraw.do?admin=1" title="Withdraw Fund" ><?=$post['ab']['summ_withdraw'];?></a></b></span>
	</div>
	
	<div class="row100 funda row" style="width:100%;padding:0px 0 5px 0;">
		<a class="span3 col-sm-6 my-2" style="clear:left;width:100%;float:left;">
		<span title="MB (Sum of Mature Balance) = Sum of Total Payable Amount Till Date">
			MB = <?=$post['ab']['summ_mature_1'];?>
		</span>
		|
		<span title="MF (Sum of Monthly Fee) = Fee applicable by 1st of every month ">
		MF = <?=$post['ab']['count_monthly_vt_fee'];?> X <?=$post['ab']['monthly_vt_fee_max'];?> =<?=number_formatf2($post['ab']['monthly_vt_fee']);?> 
		</span>
		|
		<span title="MF (Mature Fund) = (MB (Sum of Mature Balance) + RF (Sum of Received Fund))  - (SF (Sum of Send Fund) + MF (Sum of Monthly Fee) + WA (Sum of Withdraw Amount) + ABA (Admin  Balance Adjust))  ">
		<? $post['ab']['mf_ab']=(prnsum($post['ab']['summ_mature_1'])+prnsum($post['ab']['summ_received_fund_amt']))-(prnsum($post['ab']['summ_send_fund_amt'])+prnsum($post['ab']['monthly_vt_fee'])+prnsum($post['ab']['summ_withdraw_amt_1'])+prnsum($post['ab']['manual_adjust_balance']));?>
		MF = (<?=$post['ab']['summ_mature_1'];?> + <?=$post['ab']['summ_received_fund_amt'];?>) - (<?=$post['ab']['summ_send_fund_amt'];?> + <?=$post['ab']['monthly_vt_fee'];?> + <?=$post['ab']['summ_withdraw_amt_1'];?> + <?=$post['ab']['manual_adjust_balance'];?>) = <b><?=number_formatf2(prnsum($post['ab']['mf_ab']));?></b>
		</span>
		| 
		<span title="AB (Account Balance) = MF (Mature Fund) + IF (Immature Fund)    ">
		AB = <?=number_formatf2($post['ab']['mf_ab']);?> + <?=number_formatf2($post['ab']['summ_immature_amt']);?> = <b><?=$post['ab']['sum_ab']=number_formatf2(prnsum($post['ab']['mf_ab'])+prnsum($post['ab']['summ_immature_amt']));?></b>
		</span>
		 | 
		 <span title="DB (Data Balance) = MF (Mature Fund) + IF (Immature Fund)    ">
		DB = <b><?=number_formatf2($post['ab']['sum_payable_amt_of_txn']);?></b>
		</span>
		
		| 
		 <span title="Difference Between Account Balance and  DB Balance">
		Dif. = <b><?=number_formatf2(prnsum($post['ab']['summ_total_amt'])-prnsum($post['ab']['sum_payable_amt_of_txn']));?></b>
		</span>
		 
		</a>
		
	</div>
	
	<div class="row100 funda row" style="padding:0px 0 5px 0;">
		<a href="" class="span3 col-sm-6 my-2" title="Ready to Withdraw Rolling Fund">Mature Rolling Fund <b><?=$post['ab']['count_mature_roll'];?> = <?=number_formatf2($post['ab']['summ_mature_roll']);?></b></a>
		<a href="" class="span3 col-sm-6 my-2" title="Total Available Rolling Balance (Sum of Mature and Immature Rolling)">Rolling Balance <b><?=$post['ab']['count_total_roll'];?> = <?=number_formatf2($post['ab']['summ_total_roll']);?></b></a>
		<a href="" class="span3 col-sm-6 my-2 col-sm-6 my-2" title="This fund will be available to withdraw after the Rolling Maturity">Immature Rolling Fund <b><?=$post['ab']['count_immature_roll'];?> = <?=number_formatf2($post['ab']['summ_immature_roll']);?></b></a>
		<span class="span3 col-sm-6 my-2"><a <? if(isset($_SESSION['login_adm'])){?>  href="transactions.do?<? if(isset($post['bid'])){?>bid=<?=$post['bid']?><? } ?><? if(isset($post['StartPage'])){?>&page=<?=$post['StartPage']?><? } ?>&type=3&status=-1&action=select" <? } ?> title="Sum of All Previous Rolling Withdraw">Withdraw Rolling Fund</a> <b><?=$post['ab']['count_withdraw_roll'];?> = <a onclick="iframe_openf(this);" class="glyphicons database_plus" data-mid="<?=$_GET['bid']?>" data-href="" data-tabname="" data-url="" data-ihref="<?=$data['Host'];?>/user/withdraw_rolling.do?admin=1" title="Withdraw Fund" ><?=number_formatf2($post['ab']['summ_withdraw_roll']);?></a></b></span>
	</div>
	
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['balance_adjust'])&&$_SESSION['balance_adjust']==1)){?>	
	<? if(($post['bid']>0)){?>
	<div class="row100 funda row" style="clear:both;height: 0px;padding: 0;border-top:1px dashed #ccc;margin: 3px 0 9px;"> </div>	
	<form method="post" action="<?=$data['Admins'];?>/transactions.do"  style="margin: 0 0 5px;"> 
		<script>
			//document.write('<input type="hidden" name="aurl" value="'+top.window.location.href+'">');
		</script>
		<input type="hidden" name="aurl" value="<?=$data['Admins'];?>/transactions.do">
		<input type="hidden" name="bid" value="<?=$post['bid'];?>">
		<input type="hidden" name="action" value="manual_adjust_balance">
		<input type="text" name="balance_amount" placeholder="Enter Amount by Admin Balance Adjust" class="span10 col-sm-4 form-control my-2" value="" style="float:left;margin:5px;" />
		<textarea name="balance_note" placeholder="Enter Note"  class="col-sm-4 form-control my-2"  style="float:left;margin:5px;min-height: 38px;"></textarea>
		<button id="adjust_balance_id" type="submit" name="adjust_balance" value="Submit" class="payoutdaterange2 btn btn-icon btn-primary glyphicons circle_arrow_down col-sm-4 my-2"  style="float:left; margin:5px;"><i></i>Submit</button>
	</form>
	<div class="hide">
	<?
	$mab_size="1";
			$clients=select_client_table($post['bid']);
			$mab_json_get=$clients['manual_adjust_balance_json'];
			$mab_json_get=json_decode($mab_json_get,true);
			echo "count=>".$mab_json_get_count=sizeof($mab_json_get)." :  ";
			print_r($mab_json_get);		
	?>
	</div>
	<? 
	}
}?>


	
	
	
	<div class="row100 funda row" style="clear:both;height: 0px;padding: 0;border-top:1px dashed #ccc;margin-top: 3px;"> </div>
	
<?}?>