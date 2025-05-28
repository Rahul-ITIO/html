<? 
$data['PageName']='TRANSACTIONS CALCULATION';
$data['PageFile']='trans_list_calc_new';
$data['HideLeftSide']=true;
$data['NO_SALT']=true;
$data['SponsorDomain']=true;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Transactions Calculation - '.$data['domain_name'];
###############################################################################
if(!isset($_SESSION['adm_login'])){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

$where=array();
$orderby=" t.tdate"; // amount

if($post['status']>=0)	$where[]=" (t.status={$post['status']})";
if($post['type']>=0)	$where[]=" (t.type={$post['type']})";

if($post['bid']){
	$uid=$post['bid'];	

	if(isset($_GET['riskRatio'])&&$_GET['riskRatio']){
		//include('../include/riskratio_code'.$data['iex']);
	}
	

	
	// fetch auto system as a after last withdraw 
	if(isset($_SESSION['settlement_optimizer'])&&(strtolower($_SESSION['settlement_optimizer'])=='custom'||strtolower($_SESSION['settlement_optimizer'])=='weekly')&&isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y'&&$post['bid']>0)
	{
		//$post_get=trans_balance_wv3_custom(@$post['bid']); $post=array_merge(@$post,$post_get);
	}
	elseif(isset($data['WITHDRAW_INITIATE_SYSTEM_WV2'])&&$data['WITHDRAW_INITIATE_SYSTEM_WV2']=='Y'&&@$_REQUEST['a']!='v1')
	{
		$trans_detail_array = fetch_trans_balance_wv2($post['bid']);
		$monthly_fee	= payout_trans_newf_wv2($post['bid'],2,@$trans_detail_array);
	}
	else 
	{
		$trans_detail_array = fetch_trans_balance($post['bid']);
		$monthly_fee	= payout_trans_newf($post['bid']);
	}

	$where[]=" (t.sender={$post['bid']} OR t.merID={$post['bid']})";

	if(isset($_GET['ptdate'])&&$_GET['ptdate'])
	{
		$ptdate=date('Y-m-d',strtotime($_GET['ptdate']));

		if(isset($_GET['pfdate'])&&$_GET['pfdate'])
		{
			$ptdate=array();
			$ptdate['date_1st']=date('Y-m-d',strtotime($_GET['pfdate']));
			$ptdate['date_2nd']=date('Y-m-d',strtotime($_GET['ptdate']));
		}
	}
	else {$ptdate = "";}

	if((isset($_SESSION['settlement_optimizer'])&&strtolower($_SESSION['settlement_optimizer'])!='custom'&&strtolower($_SESSION['settlement_optimizer'])!='weekly')&&isset($_GET['compare'])&&$_GET['compare'])
	{
		$post['mbt']	= ms_trans_balance_calc_new($post['bid'], $trans_detail_array, $ptdate);
		$post['mbt_d']	= ms_trans_balance_calc_d_new($post['bid'],$ptdate,0,$trans_detail_array);
	}
	else
	{
		if(isset($_SESSION['settlement_optimizer'])&&(strtolower($_SESSION['settlement_optimizer'])=='custom'||strtolower($_SESSION['settlement_optimizer'])=='weekly')&&isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y'&&$post['bid']>0)
		{
			$post=trans_balance_wv3_custom(@$post['bid']);
		}
		elseif(isset($data['WITHDRAW_INITIATE_SYSTEM_WV2'])&&$data['WITHDRAW_INITIATE_SYSTEM_WV2']=='Y')
		$post['ab']=trans_balance_newac_wv2($post['bid'],"","",$trans_detail_array,@$data['last_withdraw']);
		else $post['ab']	= trans_balance_newac($post['bid'],"",$ptdate, $trans_detail_array);
	}
}
###############################################################################

$sub_quer=http_build_query($_GET);

?>

<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_calculation_details'])&&$_SESSION['t_calculation_details']==1)){

?>
	<div id="direct_account_calculation2" class="mx-2" style="float:left;width:100%;clear:both;margin:0px 0 0px 0;">
	<? if((isset($_SESSION['settlement_optimizer'])&&strtolower($_SESSION['settlement_optimizer'])!='custom'&&strtolower($_SESSION['settlement_optimizer'])!='weekly')&&!isset($_GET['compare'])){?>
	<a class="restartfa" onclick="ajaxf1(this,'<?=$data['Admins'];?>/trans_list_calc_new<?=$data['ex'];?>?<?=$sub_quer;?>&compare=1','#direct_account_calculation2','1','2')">Direct Account Calculation <font class="icons glyphicons restart "><i></i></font></a>
	<? }?>
	</div>
	<div style="float:left;width:100%;clear:both;margin:10px 0 0px 0;">
		<? 
		if(isset($_SESSION['settlement_optimizer'])&&(strtolower($_SESSION['settlement_optimizer'])=='custom'||strtolower($_SESSION['settlement_optimizer'])=='weekly')&&isset($data['CUSTOM_SETTLEMENT_WD_V3'])&&$data['CUSTOM_SETTLEMENT_WD_V3']=='Y') 
		{
			include("../include/trans_balance_ui_withdraw_v3_custom".$data['iex']);
			echo "<br/><br/>";
		}
		else include("../include/trans_mb_page".$data['iex']);

		?>
	</div>
<? }?>

<? db_disconnect();?>