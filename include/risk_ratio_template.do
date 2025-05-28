<??>
<script>window.jQuery || document.write('<script src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"><\/script>')</script>

<script src="<?=$data['Host']?>/js/jquery.lineProgressbar.js"></script>
<? $uniqueids=date('YmdHis').substr(number_format(time() * rand(111,999),0,'',''),0,12); ?>


<style>
.w50.grid_led2 {width:45%;}
.w50.grid_led3 {width:28.6%;}
.w50.grid_led1 {width:96%;}
.w50.grid_led4 {width:17%;}
.w50.grid_led4:first-child{width:28.6%;}
.percentCount {display:none;}
.percentage_ratio {position:absolute;z-index:9;bottom:7px;right:22px;font-size:15px;font-weight:bold;}

.admins .percentage_ratio {font-size:12px;font-weight:normal;top:18px;right:37px;}
.admins .w50.grid_led3 {width:28%;}

.admins.clients_test .percentage_ratio {top:23px;right:11px;}
.progressbar{overflow:hidden !important;}
@media (max-width: 767px){
.clients .w50 {width:96% !important;}
}
</style>

<? if(((!empty($_SESSION['account_type_check']))||(isset($post['account_type_check'])&&$post['account_type_check']))&&($post['check_total_ratio'])){?>
	<div class="<?=$uniqueids?> w50 lead_div <?=$post['check_lead_class'];?> check_total_ratio col-sm-6">
		<div class="lead_title" title="Risk Ratio">R.R. <?=$post['check_retrun_count'];?>/<?=($post['check_completed_and_settled']);?> </div>
		<div id="check_lead_show<?=$uniqueids?>"> </div>
		<div class="percentage_ratio"><?=$post['check_total_ratio'];?>%</div>
		<script>
		$('#check_lead_show<?=$uniqueids?>').LineProgressbar({
			percentage:<?=$post['check_total_ratio'];?>,
			radius: '1px',
			height: '5px',
			fillBackgroundColor: '<?=$post['check_lead_color'];?>'
		});
		</script>
	</div>
	
<? } if((!empty($_SESSION['account_type_card']))||($post['account_type_card'])){?>
	<div class="<?=$uniqueids?> w50 lead_div <?=$post['card_lead_class'];?> card_total_ratio col-sm-6">
		<div class="lead_title" title="Chargeback Ratio">C.R. <?=$post['card_retrun_count'];?>/<?=($post['card_completed_and_settled']);?> </div>
		<div id="card_lead_show<?=$uniqueids?>">	 </div>
		<div class="percentage_ratio"><?=$post['card_total_ratio'];?>%</div>
		<script>			
		$('#card_lead_show<?=$uniqueids?>').LineProgressbar({
			percentage:<?=$post['card_total_ratio_bar'];?>,
			radius: '1px',
			height: '5px',
			fillBackgroundColor: '<?=$post['card_lead_color'];?>'
		});
		</script>
	</div>
	
<? }?>
<? if((isset($data['PageFile'])&&($data['PageFile']=="index"))||(isset($_GET['bid']))){?>
<script>	
if($('div').hasClass('w50')){
	var widgetclass="grid_led"+$(".w50").length;
	$(".w50").addClass(widgetclass);
}
</script>
<?}else{?>
<script>	
var widgetclass="grid_led"+$(".<?=$uniqueids?>").length;
$(".<?=$uniqueids?>").addClass(widgetclass);
</script>
<?}?>
<? /*?>
<div style="position:relative;z-index:9999;top:10px;">
<?print_r($post['card_ratio']);?>	
</div>
<? */?>