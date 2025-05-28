<?
###############################################################################

function graphf_for($trans_details){
	$result=array();
	$result['total_amount']=0;
	$result['ids']=0;
	for($i=0;$i<count($trans_details);$i++){
		//$result['date_transaction'][$i]	=	date("Y-m-d", strtotime($trans_details[$i]['tdates']));
		$result['date_transaction'][$i]		=	$trans_details[$i]['tdates'];
		$result['transaction_amount'][$i]	=	(double)number_formatf((double)$trans_details[$i]['amounts']);
		$result['total_amount']				=	(double)number_formatf($result['total_amount']+(double)$trans_details[$i]['amounts']);
		$result['ids']						=	$result['ids']+$trans_details[$i]['ids'];
	}
	return $result;
}

//$_REQUEST['q']=1;
$post_form=array();
$post_form['merchant_details']=$uid;
//$post_form['payment_status']=["1","7","2"];
$post_form['payment_status']=["1","7"];


##########################################################################

if((isset($data['frontUiName'])&&!in_array($data['frontUiName'],array("ice","sys")))){

	if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']){
		$post_form['date_1st']=(date('Y-m-d 00:00:00',strtotime($_REQUEST['date_1st'])));
	}else{
		$post_form['date_1st']=(date('Y-m-d 00:00:00',strtotime('-29 days')));
	}

	if(isset($_REQUEST['date_2nd'])&&$_REQUEST['date_2nd']){
		$post_form['date_2nd']=(date('Y-m-d 23:59:59',strtotime($_REQUEST['date_2nd'])));
	}else{
		$post_form['date_2nd']=(date('Y-m-d 23:59:59'));
	}

	if(isset($_REQUEST['label'])&&$_REQUEST['label']&&strpos($_REQUEST['label'],'Year')!==false){
		$post_form['time_period']=2;
	}else{
		if(isset($_REQUEST['date_1st'])&&isset($_REQUEST['date_2nd'])){
			$diff=date_diff(date_create($_REQUEST['date_1st']),date_create($_REQUEST['date_2nd']));
			$dcount=$diff->format("%a");
		}
		if(isset($dcount)&&$dcount >= 30){
			$post_form['time_period']=2;
		}else{
			$post_form['time_period']=4;
		}
	}
	
	if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']){
		echo "<br/>post_form=> ";
		print_r($post_form);
	}
}




##########################################################################

if(isset($_REQUEST['dtest'])){
	echo "<br/>_SESSION gid=>".@$_SESSION['gid']; echo "<br/>_REQUEST gid=>".@$_REQUEST['gid'];
}

if((isset($_SESSION['gid']))&&(!isset($_REQUEST['gid']))){
	if(!isset($_SESSION['gid'])) $_SESSION['gid']=0;unset($_SESSION['gid']);
	if(!isset($_SESSION['create_graph'])) $_SESSION['create_graph']=0;unset($_SESSION['create_graph']);
}
	

if(isset($_REQUEST['gid'])&&$_REQUEST['gid']){
	
	
	if((!isset($_SESSION['gid']))||($_SESSION['gid']!=$_REQUEST['gid']) || ($_REQUEST['gid']=="range") ){
		$_SESSION['gid']=$_REQUEST['gid'];
		if(!isset($_SESSION['create_graph'])) $_SESSION['create_graph']=0;unset($_SESSION['create_graph']);
	}
	
	
	
	//$post_form['date_2nd']=(date('Y-m-d 23:59:59'));
	
	
	
	
	if($_REQUEST['gid']=="Daily"){
		if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']){
			$post_form['date_1st']=(date('Y-m-d 00:00:00',strtotime($_REQUEST['date_1st'])));
		}else{
			$post_form['date_1st']=(date('Y-m-d 00:00:00'));
		}
		$post_form['time_period']=4;
	}elseif($_REQUEST['gid']=="Weekly"){
		if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']){
			$post_form['date_1st']=(date('Y-m-d 00:00:00',strtotime($_REQUEST['date_1st'])));
		}else{
			$post_form['date_1st']=(date('Y-m-d 00:00:00',strtotime("-1 weeks")));
		}
		$post_form['time_period']=1;
	}elseif($_REQUEST['gid']=="Monthly"){
		if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']){
			$post_form['date_1st']=(date('Y-m-d 00:00:00',strtotime($_REQUEST['date_1st'])));
		}else{
			$post_form['date_1st']=(date('Y-m-d 00:00:00',strtotime("-1 month")));
		}
		$post_form['time_period']=2;
	}elseif($_REQUEST['gid']=="Yearly"){
		if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']){
			$post_form['date_1st']=(date('Y-m-d 00:00:00',strtotime($_REQUEST['date_1st'])));
		}else{
			$post_form['date_1st']=(date('Y-m-d 00:00:00',strtotime("-1 years")));
		}
		$post_form['time_period']=3;
	}
	
}
$data['post_form']=$post_form;

if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']){
	echo "<br/>create_graph=> ";
	print_r(@$_SESSION['create_graph']);
	echo "<br/><br/>post_form2=> ";
	print_r(@$post_form);
}
	
//$_GET['dtest']=2;
//if(!isset($_SESSION['create_graph']))
{
	/*
	
	//step 1 
	$gr1=get_trans_graph($post_form,1);
	$_SESSION['create_graph']['gr1']=$post['gr1']=graphf_for($gr1);
	$_SESSION['create_graph']['gr1']['count_result']=$post['gr1']['count_result']=sizeof($gr1);
	//print_r($post['gr1']);
	
	*/
	
	//step 2 for success 
	$post_form['payment_status']=["1","7"];
	
	$gr2_s=get_trans_graph($post_form,1);

	if(!$gr2_s){
		$gr2_s[0]['tdates']='';
		$gr2_s[0]['amounts']='0';
		$gr2_s[0]['ids']='0';
		$_SESSION['create_graph']['gr2_s']['count_result']='0';
		//echo "<br/><br/>gr2_s=><br/>"; print_r($gr2_s);
	}
	
	$_SESSION['create_graph']['gr2_s']=$post['gr2_s']=graphf_for($gr2_s);
	$_SESSION['create_graph']['gr2_s']['count_result']=$post['gr2_s']['count_result']=count($gr2_s);
	
	
	
	//echo "<br/><br/>create_graph=><br/>"; print_r($_SESSION['create_graph']['gr2_s']);
	
	if(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']){
		echo "<br/>create_graph result=> ";
		print_r($_SESSION['create_graph']);
	}
	
	/*
	//step 3 for failed 
	$post_form['payment_status']=["2"];
	$gr3_f=get_trans_graph($post_form,1);
	$_SESSION['create_graph']['gr3_f']=$post['gr3_f']=graphf_for($gr3_f);
	$_SESSION['create_graph']['gr3_f']['count_result']=$post['gr3_f']['count_result']=sizeof($gr3_f);
	//echo "<br/><br/>gr3_f=><br/>"; print_r($post['gr3_f']);
	
	*/

}

if(isset($_SESSION['create_graph']))
{
	$post=array_merge($post,$_SESSION['create_graph']);
}
	
	
###############################################################################

?>
