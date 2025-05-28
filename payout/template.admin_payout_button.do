<?
if((isset($_SESSION['login_adm']))||(isset($_SESSION['payout_gateway_admin'])&&$_SESSION['payout_gateway_admin']==1 )){ ?>

	<li class="dropdown mx-1 mb-1" id="payout_button_admin"><a class="btn btn-primary border header_menu_link px-1" data-bs-toggle="dropdown"> <i class="<?=$payouticon;?> fa-fw" aria-hidden="true" title="<?=ucwords($payouttitle);?>" ></i><span class="text-hide-mobile"> <span class="menu_title" style="font-size:12px;"><?=ucwords($payouttitle);?></span></span></a>

		<ul class="dropdown-display dropdown-menu dropdown_from_top" style="width:190px;">
			<li><a class="dropdown-item" href="<?=$data['Admins']?>/index<?=$data['ex']?>" ><i class="<?=$payouticon2;?> text-white fa-fw"></i> Payment Gateway</a></li>
			<li><a class="dropdown-item" href="<?=$data['Admins']?>/payout-transaction<?=$data['ex']?>"><i class="<?=$payouticon1;?> text-white fa-fw"></i> Payout Gateway</a></li>
		</ul>
	</li>
<? } ?>