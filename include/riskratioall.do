<?php
include('../config.do');
$uid=$_GET['uid'];
include('riskratio_code.do');
?>
<script src="<?=$data['Host']?>/theme/scripts/jquery-1.8.2.min.js"></script>
<style>
.w50.grid_led2 {width:45%;float:left;}
.card_total_ratio.grid_led2{float:right;}
.risk_main{background:#fff;float:right;width:85%;height:35px;clear:both;padding:0px 0 0px 0;overflow:hidden;position:relative;top:24px;margin:-20px 0 0 0;}
</style>
<div class="risk_main">
<?php include('risk_ratio_template.do');?>
</div>