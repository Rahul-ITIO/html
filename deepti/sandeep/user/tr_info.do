<?
$data['PageName']='Merchant Transaction Info';
$data['PageFile']='tr_info';

###############################################################################
include('../config.do');

$data['PageTitle'] = 'Merchant Transaction Info ' . $data['domain_name'];


###############################################################################
if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
if(is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(isset($_GET['close'])){
	$_SESSION['trInfo']=1;
	exit;
}

###############################################################################
function hasDuplicate($array) {
            $defarray = array();
        $filterarray = array();
        foreach($array as $val){
            if (isset($defarray[$val])) {
                $filterarray[] = $val;
            }
            $defarray[$val] = $val;
        }
        return $filterarray;
}

function success_rate($uid,$time_period=0){
	global $data; $result=array();
	$date_1st="";$date_2nd="";$day="";
	$data["Heading"]="Overall";
	if($time_period==1){
		$date_1st=date('Y-m-d');
		$date_2nd=date("Y-m-d",strtotime("+1 day"));
		//$day=" today";
		$data["Heading"]="Today";
	}elseif($time_period==2){
		$date_1st=date("Y-m-d",strtotime("-7 day"));
		$date_2nd=date("Y-m-d",strtotime("+1 day"));
		//$day=" week";
		$data["Heading"]="Weekly";
	}elseif($time_period==3){
		$date_1st=date("Y-m-d",strtotime("-30 day"));
		$date_2nd=date("Y-m-d",strtotime("+1 day"));
		//$day=" month";
		$data["Heading"]="Monthly";
	}
	
	if($date_1st){
		$reportdate =" AND ( tdate BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd}', '%Y%m%d')) )  ";
	}
/*
0=>'Pending',
		1=>'Success',  // Success || Approved || Completed
	2=>'Failed',		// Failed || Declined || Cancelled
	3=>'Refunded',
		//4=>'Settled', //(both)
    5=>'Chargeback',
	6=>'Returned', // (check)
		7=>'Reversed', //  Reversed || Completed    our transaction  (1 or 4) by 7=> new transaction with status of ( (both)Refunded 3 or (card) Chargeback 5 or (check) Returned 6 or (card) cbk1 11  )
	8=>'Refund Pending', // for Merchant
	9=>'Test',
	10=>'Scrubbed',
	11=>'Predispute', // Predispute CBK1
	12=>'Partial Refund', // 3 Refunded
	13=>'Withdraw Requested', // for Merchant
	14=>'Withdraw Rolling', // for Merchant
	15=>'Fund',
	16=>'Received Fund',
	17=>'Send Fund',
	18=>'Received Fund - Cancelled',
	19=>'Send Fund - Cancelled',*/
		
	$sRate=@db_rows(
		"SELECT amount,email_add,`{$data['DbPrefix']}transactions`.status,reply_remark FROM `{$data['DbPrefix']}transactions`".
		" WHERE ( `receiver`={$uid} ) AND ".
		"( `status`=1 OR `status`=2 OR `status`=7 ) ".
		/*" (`status`=1 OR `status`=2 OR `status`=3 OR `status`=5 OR `status`=6 OR `status`=7 OR ".
		" `status`=8 OR `status`=11 OR `status`=12 OR `status`=13 OR `status`=14 OR `status`=15 OR ".
		" `status`=16 OR `status`=17 OR `status`=18 OR `status`=19 )".*/
		$reportdate.
		//" group by `email_add`,`amount`".
		" ORDER BY `id` ASC",0
	);
	$s=$s0=0;$s2=0;$s1=0;$s2=0;$sc=0; $s_amt=0;
	$e1=array();$e2=array();$cancelled_ti=array();
	foreach($sRate as $key=>$value){
		if($value['status']==1||$value['status']==7){
			$e1[]=$value['amount']." ".$value['email_add'];
			//$e1[]=$value['email_add'];
			$s1++;
		}
		
		
		if($value['status']==2){
			$cancelled_ti[]=$value['amount']." ".$value['email_add'];
			//$cancelled_ti[]=$value['email_add'];
			$s2++;
		}

		
		$s0++;
	}

	$tt=0;$c=0;$cm=0;$competed_e1=implode(',',$e1);//echo $competed_e1;
	foreach($sRate as $key=>$value){
		if(($value['status']<>1)&&($value['status']<>7)){
			$tt++;
			if((strpos($competed_e1,$value['amount']." ".$value['email_add'])==true)){
			
				$cm++;
			}else{
				if((strpos($value['reply_remark'],"Do not honour")==true)||(strpos($value['reply_remark'],"[05]Declined")==true)){
					$e2[]=$value['amount']." ".$value['email_add'];
					//$e2[]=$value['email_add'];
					$c++;
				}
			}
		}
	}
	
	
	$cancelled_ti_dup=hasDuplicate($cancelled_ti);
	$repeat_transaction=count($cancelled_ti_dup);
	//$counts=$s1+$c;
	
	//$s1=50;
	//$s0=100;
	//$repeat_transaction=25;
	$total=($s0-$repeat_transaction);
	$cancel=($s0-$s1-$repeat_transaction);
	/*echo 'completed:'.$s1;
	echo '<br>total:'.$total;
	echo '<br>cancel:'.$cancel;
	echo '<br>repeat:'.$repeat_transaction;
	
	echo '<br>fail:'.($s1-$repeat_transaction);*/
	$counts=@($s+$tt);
	if($s1){ 
		$result["Completed rate$day"]=number_format(((100*$s1)/$total), '2', '.', '')."%";
	}
	$result["Transaction count$day"]=$s0.' Count';
	$result["Completed transaction count$day"]=$s1.' Count';
	$result["Cancelled transaction count$day"]=($s2-$repeat_transaction).' Count';
	
	
	if($c){
	//$result["Cancelled rate$day"]=number_format(((100*$c)/$counts), '2', '.', '')."%";
	}
	
	//Repeat transaction count
	$result["Repeat transaction count$day"]=$repeat_transaction.' Count';
	
	
	return $result;
}

//$data['HideAllMenu']=1;

display('user');

?>
