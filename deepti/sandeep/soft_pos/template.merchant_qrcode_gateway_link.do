<? if(isset($post['qrcode_gateway_request'])&&($post['qrcode_gateway_request']==1 || $post['qrcode_gateway_request']==2)){ ?>
<? if(((in_array(55, $grole)) && ($_SESSION['m_clients_type']=='Sub Member')) || ($_SESSION['m_clients_type']=='')){ ?>
	<li><a class="text-white text-decoration-none" href="<?=$data['Host']?>/soft_pos/softpos<?=$data['ex']?>" title="<?=$data['SOFT_POS_LABELS'];?>"><i class="fas fal fa-qrcode"></i><span class="menu_title">&nbsp;<?=$data['SOFT_POS_LABELS'];?></span></a></li>
<? } ?>
<? } ?>