<? 
if((isset($_SESSION['login_adm']) && $_SESSION['admin_dashboard_type']=="payout-dashboar")||(isset($_SESSION['payout_transaction'])&&$_SESSION['payout_transaction']==1 ))
{ ?>	
	<li><a class="nav-link text-white " href="<?=$data['Admins']?>/payout-transaction<?=$data['ex']?>" title="Transaction"><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> <span class="menu_title">Transaction</span></a></li>
<? 
}
if((isset($_SESSION['login_adm']) && $_SESSION['admin_dashboard_type']=="payout-dashboar")||(isset($_SESSION['payout_statement'])&&$_SESSION['payout_statement']==1 )){ 
?>
	<li><a class="nav-link text-white " href="<?=$data['Admins']?>/payout-statement<?=$data['ex']?>" title="Statements"><i class="<?=$data['fwicon']['mystatement'];?> fa-fw"></i> <span class="menu_title">Statements</span></a></li>
<? 
}
if((isset($_SESSION['login_adm']) && $_SESSION['admin_dashboard_type']=="payout-dashboar")||(isset($_SESSION['beneficiary_list'])&&$_SESSION['beneficiary_list']==1 )){ 
?>
	<li><a class="nav-link text-white " href="<?=$data['Admins']?>/beneficiary_list<?=$data['ex']?>" title="Beneficiaries"><i class="<?=$data['fwicon']['user-double'];?> fa-fw"></i> <span class="menu_title">Beneficiaries</span></a></li>
<? 
}

$sub_admin_menu = 0;
if((isset($_SESSION['login_adm']))||(isset($_SESSION['live_merchant'])&&$_SESSION['live_merchant']==1))
	$sub_admin_menu = 1;
if((isset($_SESSION['login_adm']))||(isset($_SESSION['test_merchant'])&&$_SESSION['test_merchant']==1))
	$sub_admin_menu = 1;
if((isset($_SESSION['login_adm']))||(isset($_SESSION['inactive_merchant'])&&$_SESSION['inactive_merchant']==1))
	$sub_admin_menu = 1;

if((isset($_SESSION['login_adm']))||$sub_admin_menu){ ?>
	<li class="nav-item dropdown"> <a class="nav-link text-white dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" title="Merchant"> <i class="<?=$data['fwicon']['merchant'];?> fa-fw"></i> <span class="menu_title">Merchant</span> </a>
	  
	  <ul class="dropdown-menu pull-right clients ms-1" style="min-width: 134px !important;">

		<?
		if((isset($_SESSION['login_adm']))||(isset($_SESSION['live_merchant'])&&$_SESSION['live_merchant']==1)){?>
		<li> <a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['MER']?><?=$data['ex']?>?action=select&type=live"><i class="<?=$data['fwicon']['user-live'];?> text-success px-1"></i> Live</a></li>
		<?
		}if((isset($_SESSION['login_adm']))||(isset($_SESSION['test_merchant'])&&$_SESSION['test_merchant']==1)){?>
		<li> <a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['MER']?><?=$data['ex']?>?action=select&type=test" ><i class="<?=$data['fwicon']['user-test'];?> text-warning px-1"></i> Test</a></li>
		<?
		}if((isset($_SESSION['login_adm']))||(isset($_SESSION['inactive_merchant'])&&$_SESSION['inactive_merchant']==1)){?>
		<li><a class="dropdown-item" href="<?=$data['Admins']?>/<?=$data['MER']?><?=$data['ex']?>?action=select&type=inactive" ><i class="<?=$data['fwicon']['user-inactive'];?> text-danger px-1"></i> Inactive</a></li>
		<?
		}?>
	  </ul>
	</li>
	<? 
}  
if((isset($_SESSION['login_adm']))||(isset($_SESSION['bank_payout_table'])&&$_SESSION['bank_payout_table']==1)){?>
	<li><a class="nav-link text-white" href="<?=$data['Admins']?>/bank<?=$data['ex']?>"><i class="<?=$data['fwicon']['bank'];?> fa-fw"></i><span class="menu_title"> Bank Table</span></a></li>
<? } ?>
<li><a class="nav-link text-white" href="<?=$data['Host']?>/payout/payoutapi.pdf" target="_blank" title="Api Keys"><i class="<?=$data['fwicon']['pdf'];?>"></i> <span class="menu_title"> Developer API</span></a></li>