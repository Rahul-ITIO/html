<?

?><div id="sumbal" class="row100 funda" style="">

<div class="row">

		<a title="Ready to Withdraw Fund - You can request a fund" class="fund_3 col-sm-3 dev44"><i class="<?=$data['fwicon']['hand'];?>"></i> Mature Fund :  <b><? if(isset($post['ab']['summ_mature'])) echo $post['ab']['summ_mature'];?></b></a>
		
		<a  title="Total Available Balance (Sum of Mature and Immature Fund)" class="fund_3 col-sm-3"><i class="<?=$data['fwicon']['hand'];?>"></i> Account Balance : <b><? if(isset($post['ab']['summ_total'])) echo $post['ab']['summ_total'];?></b>
		</a>
		
		<a  title="This fund will be available to withdraw after the maturity" class="fund_3 col-sm-3"><i class="<?=$data['fwicon']['hand'];?>"></i> Immature Fund : <b><? if(isset($post['ab']['summ_immature'])) echo $post['ab']['summ_immature'];?></b></a>
		
		<a  title="Sum of All Previous Withdraw" class="fund_3 col-sm-3"><i class="<?=$data['fwicon']['hand'];?>"></i> Total Withdraw Made :  <b><? if(isset($post['ab']['summ_withdraw'])) echo $post['ab']['summ_withdraw'];?></b></a>
		
	</div>
	</div>
	<? if($post['ab']['summ_total_roll']>0){ ?>
	<div id="sumbal" class="row100 funda">
	<div class="row">
	
		<a href="<?=$data['USER_FOLDER']?>/trans_withdraw-fund_system_v2<?=$data['ex']?><?=((isset($data['is_admin'])&&$data['is_admin'])?"?admin=1".((isset($_GET['bid'])&&$_GET['bid'])?"&bid=".$_GET['bid']:""):"");?>" title="Ready to Withdraw Rolling Fund" class="fund_3 col-sm-3"><i class="<?=$data['fwicon']['hand'];?>"></i> Mature Rolling Fund :  <b><? if(isset($post['ab']['summ_mature_roll'])) echo $post['ab']['summ_mature_roll'];?></b></a>
		<a title="Total Available Rolling Balance (Sum of Mature and Immature Rolling)" class="fund_3 col-sm-3"><i class="<?=$data['fwicon']['hand'];?>"></i> Rolling Balance : <b><? if(isset($post['ab']['summ_total_roll'])) echo $post['ab']['summ_total_roll'];?></b>
		</a>
		<a title="This fund will be available to withdraw after the Rolling Maturity" class="fund_3 col-sm-3"><i class="<?=$data['fwicon']['hand'];?>"></i> Immature Rolling Fund : <b><? if(isset($post['ab']['summ_immature_roll'])) echo $post['ab']['summ_immature_roll'];?></b></a>
		<a title="Sum of All Previous Rolling Withdraw" class="fund_3 col-sm-3"><i class="<?=$data['fwicon']['hand'];?>"></i> Withdraw Rolling Fund : <b><? if(isset($post['ab']['summ_withdraw_roll'])) echo $post['ab']['summ_withdraw_roll'];?></b></a>
		
	</div>	
	</div>
	<?}?>