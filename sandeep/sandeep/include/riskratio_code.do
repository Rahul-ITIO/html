<?
//include('../config1.do');
//include('riskratio.do');

$post['vtAccountInfo']=mer_settings($uid);
//print_r($post['vtAccountInfo']);exit;
$_SESSION['m_check21_vt']=false;
$_SESSION['m_moto_vt']=false;
$_SESSION['m_check21_pdfreport']=false;
$_SESSION['m_card_pdfreport']=false;
$_SESSION['account_type_all']="";
$_SESSION['account_type_check']="";
$_SESSION['account_type_card']="";
$_SESSION['encrypt_email']="";
foreach($post['vtAccountInfo'] as $key=>$value){

$value['view_settelement_report']="";

	$_SESSION['account_type_all'].=$value['acquirer_id'].",";
	
	if((strpos($value['checkout_label_web'],'Check') !== false) && ($value['acquirer_processing_mode']!="3") && ($value['moto_status']=="1")){$_SESSION['m_check21_vt']=true;}
	
	if((strpos($value['checkout_label_web'],'Card') !== false) && ($value['acquirer_processing_mode']!="3") && ($value['moto_status']=="1")){$_SESSION['m_moto_vt']=true;}
	
	if((strpos($value['checkout_label_web'],'Check') !== false)&&($value['acquirer_processing_mode']!="3") ){$_SESSION['account_type_check'].=$value['acquirer_id'].",";}
	
	if((strpos($value['checkout_label_web'],'Card') !== false)&&($value['acquirer_processing_mode']!="3") ){$_SESSION['account_type_card'].=$value['acquirer_id'].",";}
	
	
	if((strpos($value['checkout_label_web'],'Check') !== false) && ($value['view_settelement_report']=="1" || empty($value['view_settelement_report']))){$_SESSION['m_check21_pdfreport']=true;}
	
	
	if((strpos($value['checkout_label_web'],'Card') !== false) && ($value['view_settelement_report']=="1" || empty($value['view_settelement_report']))){$_SESSION['m_card_pdfreport']=true;}
	
	if(isset($value['encrypt_email'])&&$value['encrypt_email']){$_SESSION['encrypt_email'].=$value['encrypt_email'].",";}
	
}
if(isset($_SESSION['encrypt_email'])){$_SESSION['encrypt_email']=implode(',',array_unique(explode(',',$_SESSION['encrypt_email'])));}

$post['check_total_ratio']=0;
$post['card_total_ratio']=0;
$post['check_lead_color']='#fff';
$post['card_lead_color']='#fff';

$account_type_get=false;
/*
if(isset($_GET['type']) && $_GET['type']>0){
	$account_type=$_GET['type'];

	unset($_SESSION['account_type_check']);
	unset($_SESSION['account_type_card']);
	//$get_risk=riskratio($uid,$account_type);
	$get_risk=get_riskratio_trans($uid);
	//print_r($get_risk);
	if($get_risk['risk_type']=="Risk Ratio"){
	 $_SESSION['account_type_check']=$account_type;
	}else{
	 $_SESSION['account_type_card']=$account_type;
	}
}*/
if(!empty($_SESSION['account_type_check'])){
	//$post['check_ratio']=get_riskratio_trans($uid,$_SESSION['account_type_check']);
	$post['check_ratio']=get_riskratio_trans($uid,'',false);
	$post['check_total_ratio']=$post['check_ratio']['total_ratio'];
	$post['check_retrun_count']=$post['check_ratio']['retrun_count'];
	$post['check_completed_and_settled']=$post['check_ratio']['completed_and_settled'];
	$post['check_lead_class']=$post['check_ratio']['lead_class'];
	$post['check_lead_color']=$post['check_ratio']['lead_color'];
	$post['check_completed']=$post['check_ratio']['completed_count'];
	$post['check_settled']=$post['check_ratio']['settled_count'];
	$post['check_risk_type']=$post['check_ratio']['risk_type'];
	
}
if(!empty($_SESSION['account_type_card'])){ 
	//$post['card_ratio']=riskratio($uid,$_SESSION['account_type_card']);
	$post['card_ratio']=get_riskratio_trans($uid);
	$post['card_total_ratio']=@$post['card_ratio']['total_ratio'];
	$post['card_total_ratio_bar']=($post['card_ratio']['total_ratio']*5);
	
	$post['card_retrun_count']=@$post['card_ratio']['retrun_count'];
	$post['card_completed_and_settled']=$post['card_ratio']['completed_and_settled'];
	$post['card_lead_class']=$post['card_ratio']['lead_class'];
	$post['card_lead_color']=$post['card_ratio']['lead_color'];
	$post['card_completed']=$post['card_ratio']['completed_count'];
	$post['card_settled']=$post['card_ratio']['settled_count'];
	$post['card_risk_type']=$post['card_ratio']['risk_type'];
}

?>