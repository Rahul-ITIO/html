<?
//if(isset($post['ab']['ab']))$post['ab']=$post['ab']['ab'];
//print_r($post['ab']);
//$data['IMMATURE_FUND_V3_CUSTOM_ENABLE']='Y';
?><div id="sumbal" class="row100 funda" style="">

<div class="row">
        <?
        if(isset($data['IMMATURE_FUND_V3_CUSTOM_ENABLE'])&&$data['IMMATURE_FUND_V3_CUSTOM_ENABLE']=='Y')
        {?>
            
            <a title="Ready to Withdraw Fund - You can request a fund" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> Mature Fund :  <b><? if(isset($post['ab']['summ_mature'])) echo $post['ab']['summ_mature'];?></b></a>
            
            <a  title="Total Available Balance (Sum of Mature and Immature Fund)" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> Account Balance : <b><? if(isset($post['ab']['summ_total'])) echo $post['ab']['summ_total'];?></b>
            </a>
            
            <a  title="This fund will be available to withdraw after the maturity" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> Immature Fund : <b><? if(isset($post['ab']['summ_immature'])) echo $post['ab']['summ_immature'];?></b></a>

        <?}
        else {
        ?>

            <!--  MF:<?=@$post['ab']['summ_mature'];?> :: AB:<?=@$post['ab']['summ_total'];?>      -->

            <a  title="Total Available Balance " class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> Account Balance : <b><? if(isset($post['ab']['summ_total'])) echo $post['ab']['summ_total'];?></b></a>


        <?}?>
		
		<a  title="Sum of All Previous Withdraw" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> Total Withdraw Made :  <b><? if(isset($post['ab']['summ_withdraw'])) echo $post['ab']['summ_withdraw'];?></b></a>
		
	</div>
	</div>
	<? if(isset($post['ab']['summ_total_roll'])&&$post['ab']['summ_total_roll']>0){ ?>
	<div id="sumbal" class="row100 funda">
	<div class="row">
	
		<a href="<?=@$data['USER_FOLDER']?>/withdraw_rolling_wv3_custom<?=@$data['ex']?><?=((isset($data['is_admin'])&&$data['is_admin'])?"?admin=1".((isset($_GET['bid'])&&$_GET['bid'])?"&bid=".$_GET['bid']:""):"");?>" title="Ready to Withdraw Rolling Fund" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> Mature Rolling Fund :  <b><? if(isset($post['ab']['summ_mature_roll'])) echo $post['ab']['summ_mature_roll_sys'];?></b></a>
		<a title="Total Available Rolling Balance (Sum of Mature and Immature Rolling)" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> Rolling Balance : <b><? if(isset($post['ab']['summ_total_roll'])) echo $post['ab']['summ_total_roll_sys'];?></b>
		</a>
		<a title="This fund will be available to withdraw after the Rolling Maturity" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> Immature Rolling Fund : <b><? if(isset($post['ab']['summ_immature_roll'])) echo $post['ab']['summ_immature_roll_sys'];?></b></a>
		<a title="Sum of All Previous Rolling Withdraw" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> Withdraw Rolling Fund : <b><? if(isset($post['ab']['summ_withdraw_roll'])) echo $post['ab']['summ_withdraw_roll_sys'];?></b></a>
		
	</div>	
	</div>
	<?}?>

	<?if(isset($post['ab']['show_fee_only'])&&$post['ab']['show_fee_only']){ ?>
	<div class="row100 funda">
	<div class="row">
		<?if(isset($post['ab']['total_gst_fee'])&&$post['ab']['total_gst_fee']>0){ ?>
			<a title="GST FEE" data-f="total_gst_fee" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> GST FEE : <b><?=@$post['ab']['total_gst_fee_sys'];?></b>
			</a>
		<?}?>

		<?if(isset($post['ab']['total_mdr_txtfee_amt'])&&$post['ab']['total_mdr_txtfee_amt']>0){ ?>
			<a title="Transaction Fee" data-f="total_mdr_txtfee_amt" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> Transaction Fee : <b><?=@$post['ab']['total_mdr_txtfee_amt_sys'];?></b>
			</a>
		<?}?>

		<?if(isset($post['ab']['total_mdr_amt'])&&$post['ab']['total_mdr_amt']>0){ ?>
			<a title="MDR AMT. || Discount Rate" data-f="total_mdr_amt" class="fund_3 col-sm-3"><i class="<?=@$data['fwicon']['hand'];?>"></i> MDR AMT. : <b><?=@$post['ab']['total_mdr_amt_sys'];?></b>
			</a>
		<?}?>

		
		
	</div>	
	</div>
	<?}?>
	