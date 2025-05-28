<? 
$data['PageName']='TRANSACTIONS CALCULATION';
$data['PageFile']='transactions_list_cal';
$data['HideLeftSide']=true;
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
	if($post['status']>=0)$where[]=" (t.status={$post['status']})";
	if($post['type']>=0)$where[]=" (t.type={$post['type']})";

	if($post['bid']){
		$uid=$post['bid'];	
		
		if(isset($_GET['riskRatio'])&&$_GET['riskRatio']){
			include('../include/riskratio_code'.$data['iex']);
		}
		
		
		$where[]=" (t.sender={$post['bid']} OR t.receiver={$post['bid']})";
		if(isset($_GET['ptdate'])&&$_GET['ptdate']){
			
			$ptdate=date('Y-m-d',strtotime($_GET['ptdate']));
			
			
			if(isset($_GET['pfdate'])&&$_GET['pfdate']){
				$ptdate=array();
				$ptdate['date_1st']=date('Y-m-d',strtotime($_GET['pfdate']));
				$ptdate['date_2nd']=date('Y-m-d',strtotime($_GET['ptdate']));
			}
			
			
				$post['ab']=account_balance($post['bid'],"",$ptdate);
				//$post['mb']=merchant_balance($post['bid'],$ptdate);
				$post['mbt']=account_trans_balance_calc($post['bid'],$ptdate);
				$post['mbt_d']=account_trans_balance_calc_d($post['bid'],$ptdate);
			
			//$post['mbt_dt']=account_trans_balance_calc_dt($post['bid'],$ptdate);
		}else{
			
				
				
				if(isset($_GET['compare'])&&$_GET['compare']){
					//$post['mb']=merchant_balance($post['bid']);
					$post['mbt']=account_trans_balance_calc($post['bid']);
					$post['mbt_d']=account_trans_balance_calc_d($post['bid']);
				}
				else{
					
					$post['ab']=account_balance($post['bid']);
					
					$monthly_fee=payout_trans($post['bid']);
					$post['mfee']=$monthly_fee['total_monthly_fee'];
					$post['monthly_vt_fee_max']=$monthly_fee['per_monthly_fee'];
					$post['count_monthly_vt_fee']=$monthly_fee['total_month_no'];
			
				}
		}
		//print_r($post['mbt_d']);exit;
	}
###############################################################################
?>
<?if(isset($_GET['riskRatio'])&&$_GET['riskRatio']){?>
<div class="row100">
  <div class="w50" style="width:100% !important">
	
		  <? if((isset($_SESSION['login_adm']))||(isset($_SESSION['clients_risk_ratio_bar'])&&$_SESSION['clients_risk_ratio_bar']==1)){?>
				<? include("../include/risk_ratio_template".$data['iex']);?>
		  <?}?>
	
  </div>
</div>
<?}?>
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['t_calculation_details'])&&$_SESSION['t_calculation_details']==1)){

?>
	<div id="direct_account_calculation" class="" style="float:left;width:100%;clear:both;margin:0px 0 0px 0;">
	<?if(!isset($_GET['compare'])){?>
	<a class="restartfa" onclick="ajaxf1(this,'http://localhost/gw/mlogin/transaction_list_calc.do?bid=11195&action=select&status=-1&type=-1&compare=1','#direct_account_calculation','1','2')">Direct Account Calculation <font class="icons glyphicons restart "><i></i></font></a>
	<?}?>
	</div>
	<div style="float:left;width:100%;clear:both;margin:10px 0 0px 0;">
		<? include("../include/mb_page".$data['iex']);?>
	</div>
  <? }?>
  
<?db_disconnect();?>