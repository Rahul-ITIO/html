<?
###############################################################################
$data['PageName']='STATISTIC';
$data['PageFile']='graph3';
//$data['graph']=true;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Statistic Graph - '.$data['domain_name'];
###############################################################################
if(!$_SESSION['adm_login']){
	header("Location:{$data['Admins']}/login".$data['iex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################

if(isset($_SESSION['sub_admin_rolesname'])&&$_SESSION['sub_admin_rolesname']=="Associate"){
	echo "Oops... Something went worng. <a href='index.do'> Click here to GO to Home.</a>";
	exit;
}

if(isset($_REQUEST['action'])&&$_REQUEST['action']=='getaccountid'){
	//echo "<br/>mid=>".$_REQUEST['mid'];
	$post['TerminalId']=getTerminalidf($_REQUEST['mid'],3);
	echo showselect($post['TerminalId'], $post['storeid']);
	exit;
}

// mlogin/graph2.do?q=1&action=getacquirerid&wid=1122,1118,1501,1502

if(isset($_REQUEST['action'])&&$_REQUEST['action']=='getacquirerid'){
	//echo "<br/>wid1=>".$_REQUEST['wid'];
	$post['acquirerids']=getacquireridsf($_REQUEST['wid'],1);
	echo showselect($post['acquirerids'], $post['acquirer']);
	exit;
}


if(!isset($post['action'])||!$post['action'])$post['action']='select';
if(!isset($post['type']))$post['type']=-1;
if(!isset($post['status']))$post['status']=-1;
if($post['type']>=0){
	$data['PageName'].=
		" [".strtoupper($data['t'][$post['type']]['name2'])."]";
}
###############################################################################
$trans_details = array();
$date_transaction = array();
$transaction_amount = array();
$post['merchant_detail']=merchant_details(2);

if(isset($_REQUEST['merchant_details'])&&$_REQUEST['merchant_details']){
	$merchant_req=$_REQUEST['merchant_details'];
	$merchant_req_count=sizeof($merchant_req);
	if($merchant_req_count==1){
		$memb=select_tablef("`id`='{$merchant_req[0]}'",'clientid_table',0,1,"`default_currency`");
		$post['default_currency']=$memb['default_currency'];
	}
}
  
	/*
		$post['merchant_detail1']=[];
		sort($post['merchant_detail']);
		foreach ($post['merchant_detail'] as $key=>$value) { 
			if(!empty($value['username'])){
				$post['merchant_detail1'][$value['id']]="[{$value['id']}] {$value['username']} | {$value['fname']}  {$value['lname']}";
			}
		}
	*/
  //print_r($post['merchant_detail1']);
  
if(isset($_REQUEST['SEARCH'])&&$_REQUEST['SEARCH']=='SEARCH'){
	  /*
    	if(isset($_POST['time_period']) && $_POST['time_period']!='SELECT DATE RANGE' ){
             $this_var =$_POST['time_period'];
           	 $transaction_type = $_POST['transaction_type'];
			 //$transaction_type = "";
             
           	 if ($_POST['time_period']=='1'){
                $t="00:00:00";
                //$date = new DateTime('7 days ago');
                $date2= date('Y-m-d', strtotime('monday this week', strtotime('last sunday')));
                $date2=$date2." ".$t;
                $date1= date('Y-m-d', strtotime('sunday this week', strtotime('next sunday')));
                $date1=$date1." ".$t;   
                $trans_details=create_graph($transaction_type,$date1,$date2);
                $data['graph']=true; 
            }else if ($_POST['time_period']=='2'){
                $t="00:00:00";
				$query_date = date('Y-m-d');
                $date2=date('Y-m-01', strtotime($query_date));
                $date2=$date2." ".$t;
                $date1=date('Y-m-t', strtotime($query_date));
                $date1=$date1." ".$t;   
                $trans_details=create_graph($transaction_type,$date1,$date2);
                $data['graph']=true; 
			}else if ($_POST['time_period']=='3'){
                $t="00:00:00";
				$year = date('Y'); 
				//echo $year = date('Y')-4;
                $date1=date('Y-12-31', strtotime($year));
                $date1=$date1." ".$t;
                $strtotime=strtotime($date1);
                $last_year=strtotime("-1 year",$strtotime);
                $date2=date('Y-1-01', strtotime($year));           
                $date2=$date2." ".$t;
                $trans_details=	create_graph($transaction_type,$date1,$date2);
                $data['graph']=true; 
			}
		}else{ 
			if($_POST['date_1st']&& $_POST['date_2nd']!=''){                
				$t="00:00:00";
                $date2=$_POST['date_1st'];
                $date2=$date2." ".$t;
                $date1=$_POST['date_2nd'];
                $date1=$date1." ".$t;
                $trans_details=	create_graph($transaction_type,$date1,$date2);
                $data['graph']=true; 
			}else{
				 $data['Error']='PLEASE SELECT DATE RANGE.';				
			}
		}
	*/
	$trans_details=get_trans_graph($_REQUEST);
	$post['count_result']=sizeof($trans_details);
   //print_r($trans_details);
	$post['total_amount']=0;
	$post['ids']=0;

	for($i=0;$i<count($trans_details);$i++){
		//$date_transaction[$i]	=	date("Y-m-d", strtotime($trans_details[$i]['tdates']));
		$date_transaction[$i]	=	$trans_details[$i]['tdates'];
		$transaction_amount[$i]	=	(double)$trans_details[$i]['amounts'];
		$post['total_amount']=$post['total_amount']+(double)$trans_details[$i]['amounts'];
		$post['ids']=$post['ids']+$trans_details[$i]['ids'];
	}
	// print_r($date_transaction);
	$post['date_transaction']=$date_transaction;
	$post['transaction_amount']=$transaction_amount;
	//print_r($transaction_amount);
}
	
$post['ViewMode']=$post['action'];
###############################################################################
//$data['SystemBalance']=select_balance(-1);
###############################################################################
display('admins');
###############################################################################
?>