<?
$data['PageFile']='merchant_list';
$data['PageFile2']='clients_test';

include('../config.do');

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
	header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
	echo('ACCESS DENIED.');
	exit;
//}elseif(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']!=3){
}elseif((isset($_SESSION['sub_admin_id']))&&(!isset($_SESSION['edit_trans']))){
	// header("Location:{$data['USER_FOLDER']}/login{$data['ex']}"); echo('ACCESS DENIED.'); exit;
}

// Function for Search Risk Ratio...
function riskratio_1_date_range($uid,$mob_1_dt1='',$mob_1_dt2='',$where_pred=''){

	
	//$mob_1_dt1	=date("Y-m-01 00:00:00",strtotime("-1 month"));
	//$mob_1_dt2	=date("Y-m-t 23:59:59",strtotime("-1 month"));

	$where_pred_1=" AND ( `tdate` BETWEEN (DATE_FORMAT('{$mob_1_dt1}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$mob_1_dt2}', '%Y%m%d%H%i%s')) )  ".$where_pred;


	$post['card_ratio']=get_riskratio_trans($uid,0,1,$where_pred_1);// change from riskratio_1(
	$post['card_total_ratio']=$post['card_ratio']['total_ratio'];
	$post['card_total_ratio_bar']=($post['card_ratio']['total_ratio']*5);

	$post['card_retrun_count']=(isset($post['card_ratio']['retrun_count'])?$post['card_ratio']['retrun_count']:0);
	$post['card_completed_and_settled']=$post['card_ratio']['completed_and_settled'];
	$post['card_lead_class']=$post['card_ratio']['lead_class'];
	$post['card_lead_color']=$post['card_ratio']['lead_color'];
	$post['card_completed']=$post['card_ratio']['completed_count'];
	$post['card_settled']=$post['card_ratio']['settled_count'];
	$post['card_risk_type']=$post['card_ratio']['risk_type'];
	
	
	$uniqueids=date('YmdHis').substr(number_format(time() * rand(111,999),0,'',''),0,12);
	?>	
	<div class="col-sm-12 w-100 row">
		<div class="ratio_ro ol-sm-12 w-100 my-2"> </div>
		<div class="col-sm-12 lead_div my-2" style="background: #e7e6e6;border-radius:3px;">
			Date : <b><?=date("d-m-Y",strtotime($mob_1_dt1));?></b> - <b><?=date("d-m-Y",strtotime($mob_1_dt2));?></b>
		</div>
		<div class="<?=$uniqueids?> col-sm-12 px-0 lead_div <?=$post['card_lead_class'];?> card_total_ratio" >
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
		</div>
		<script>	
			var widgetclass="grid_led"+$(".<?=$uniqueids?>").length;
			$(".<?=$uniqueids?>").addClass(widgetclass);
		</script>
	<?
}


$is_admin=false;
if(isset($_SESSION['adm_login'])&&$_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	//echo "<hr/>is_admin=>".$is_admin;
}
$post['gid']=$_REQUEST['gid'];
$post['MemberInfo']['sponsor']=$_REQUEST['sponsor'];
$post['MemberInfo']['id']=$post['gid'];

$uid=$post['gid']; 

if(isset($_REQUEST['dtrange'])&&$_REQUEST['dtrange']==2){
	
	//print_r($_REQUEST);
	if(!$_REQUEST['date_1st']) {
		echo $data['Error'] = 'Please select date from';	
	}elseif(!$_REQUEST['date_2nd']) {
		echo $data['Error'] = 'Please select date to';	
	}
	elseif(date('YmdHis',strtotime($_REQUEST['date_1st']))>date('YmdHis',strtotime($_REQUEST['date_2nd']))) {
		echo $data['Error'] = 'Select Date From can not less than '.date('d-m-Y H:i:s',strtotime($_REQUEST['date_2nd']));
	} 
	else{	
		
		if(isset($_REQUEST['ratio_ccard_types'])&&is_array($_REQUEST['ratio_ccard_types'])){
			$_REQUEST['ratio_ccard_types']=('"'.implode('","',$_REQUEST['ratio_ccard_types']).'"');
		}
		
		if(isset($_REQUEST['ratio_ccard_types'])&&$_REQUEST['ratio_ccard_types']){
			$where_pred=" AND ( `cardtype` {$sort}IN ({$_REQUEST['ratio_ccard_types']}) ) ";
		}else{
			$where_pred=" ";
		}

		$mob_1_dt1	= date("Y-m-d H:i:s",strtotime(stf($_REQUEST['date_1st'])));
		$mob_1_dt2	= date("Y-m-d H:i:s",strtotime(stf($_REQUEST['date_2nd'])));
		$mob_1_result=riskratio_1_date_range($uid,$mob_1_dt1,$mob_1_dt2,$where_pred);
	
	}
	exit;
	
}


include('riskratio_code'.$data['iex']);

//echo "<hr/><br/>check_ratio=>"; print_r($post['check_ratio']); echo "<hr/><br/>card_ratio=>"; print_r($post['card_ratio']);

function update_ratio_info($uid, $card_ratio1, $check_ratio1 ){
	global $data;
	$upd=[];

	if(is_array($card_ratio1)){$card_ratio=json_encode($card_ratio1);}else $card_ratio=$card_ratio1;
	if(is_array($check_ratio1)){$check_ratio=json_encode($check_ratio1);}else $check_ratio=$check_ratio1;

	if($card_ratio)	{$upd['card_ratio']= " `card_ratio_json`='{$card_ratio}' " ;}
	if($check_ratio){$upd['check_ratio']= " `check_ratio_json`='{$check_ratio}' " ;}
	$upd_str=implode(',',$upd);

	db_query(
		"UPDATE `{$data['DbPrefix']}clientid_table` SET ". $upd_str. " WHERE `id`='{$uid}'",0
	);
}
if(!isset($post['card_ratio']))	$post['card_ratio']	= '';
if(!isset($post['check_ratio']))$post['check_ratio']= '';


update_ratio_info($uid, $post['card_ratio'], $post['check_ratio']);

?>
<? include('risk_ratio_template'.$data['iex']);?>

<?

if(isset($_REQUEST['dtrange'])&&$_REQUEST['dtrange']==1){

	//MonthOfBefore
	$mob_1_dt1	=date("Y-m-01 00:00:00",strtotime("-1 month"));
	$mob_1_dt2	=date("Y-m-t 23:59:59",strtotime("-1 month"));
	$mob_1_result=riskratio_1_date_range($uid,$mob_1_dt1,$mob_1_dt2);

	//twoOfBefore
	$mob_2_dt1	=date("Y-m-01 00:00:00",strtotime("-2 months"));
	$mob_2_dt2	=date("Y-m-t 23:59:59",strtotime("-2 months"));
	$mob_2_result=riskratio_1_date_range($uid,$mob_2_dt1,$mob_2_dt2);


	//threeOfBefore
	$mob_3_dt1	=date("Y-m-01 00:00:00",strtotime("-3 months"));
	$mob_3_dt2	=date("Y-m-t 23:59:59",strtotime("-3 months"));
	$mob_3_result=riskratio_1_date_range($uid,$mob_3_dt1,$mob_3_dt2);

	//4OfBefore
	$mob_4_dt1	=date("Y-m-01 00:00:00",strtotime("-4 months"));
	$mob_4_dt2	=date("Y-m-t 23:59:59",strtotime("-4 months"));
	$mob_4_result=riskratio_1_date_range($uid,$mob_4_dt1,$mob_4_dt2);

	//5OfBefore
	$mob_5_dt1	=date("Y-m-01 00:00:00",strtotime("-5 months"));
	$mob_5_dt2	=date("Y-m-t 23:59:59",strtotime("-5 months"));
	$mob_5_result=riskratio_1_date_range($uid,$mob_5_dt1,$mob_5_dt2);

	//6OfBefore
	$mob_6_dt1	=date("Y-m-01 00:00:00",strtotime("-6 months"));
	$mob_6_dt2	=date("Y-m-t 23:59:59",strtotime("-6 months"));
	$mob_6_result=riskratio_1_date_range($uid,$mob_6_dt1,$mob_6_dt2);

	//7OfBefore
	$mob_7_dt1	=date("Y-m-01 00:00:00",strtotime("-7 months"));
	$mob_7_dt2	=date("Y-m-t 23:59:59",strtotime("-7 months"));
	$mob_7_result=riskratio_1_date_range($uid,$mob_7_dt1,$mob_7_dt2);

	//8OfBefore
	$mob_8_dt1	=date("Y-m-01 00:00:00",strtotime("-8 months"));
	$mob_8_dt2	=date("Y-m-t 23:59:59",strtotime("-8 months"));
	$mob_8_result=riskratio_1_date_range($uid,$mob_8_dt1,$mob_8_dt2);

	//9OfBefore
	$mob_9_dt1	=date("Y-m-01 00:00:00",strtotime("-9 months"));
	$mob_9_dt2	=date("Y-m-t 23:59:59",strtotime("-9 months"));
	$mob_9_result=riskratio_1_date_range($uid,$mob_9_dt1,$mob_9_dt2);
}

db_disconnect();
?>
