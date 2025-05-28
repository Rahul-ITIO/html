<?
###############################################################################
$data['PageName']='STATISTIC';
$data['PageFile']='graph';
//$data['graph']=true;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Statistic Graph - '.$data['domain_name'];
###############################################################################
if(!$_SESSION['adm_login']){
		$_SESSION['adminRedirectUrl']=$data['urlpath'];
        header("Location:{$data['Admins']}/login".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}
###############################################################################
if(!$post['action'])$post['action']='select';
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
  $post['merchant_details']= merchant_details();
 //print_r($post); 
if($post['SEARCH']=='Search'){

	if(isset($_POST['transaction_type']) && $_POST['transaction_type']!='SELECT PAYMENT TYPEs' ){  
    	if(isset($_POST['time_period']) && $_POST['time_period']!='SELECT DATE RANGE' ){
             $this_var =$_POST['time_period'];
           	 $transaction_type = $_POST['transaction_type'];
             
           	 if ($_POST['time_period']=='1'){
                $t="00:00:00";
                //$date = new DateTime('7 days ago');
                //$date2= date('Y-m-d', strtotime('monday this week', strtotime('last sunday')));
                $date2= date("Y-m-d", strtotime(date('o-\\WW')));
				$dt2=$date2;
				$date2=$date2." ".$t;
				$date1= date('Y-m-d', strtotime('sunday this week', strtotime('next sunday')));
                $dt1=$date1;
				$date1=$date1." ".$t;
				$date1=date('Y-m-d H:i:s', strtotime($date1 . ' +1 day'));   
                $trans_details=create_graph($transaction_type,$date1,$date2);
                $data['graph']=true;
            }else if ($_POST['time_period']=='2'){
                $t="00:00:00";
				$query_date = date('Y-m-d');
                $date2=date('Y-m-01', strtotime($query_date));
				$dt2=$date2;
                $date2=$date2." ".$t;
				$date1=date('Y-m-t', strtotime($query_date));
				$dt1=$date1;
                $date1=$date1." ".$t;
				$date1=date('Y-m-d H:i:s', strtotime($date1 . ' +1 day'));      
                $trans_details=create_graph($transaction_type,$date1,$date2);
                $data['graph']=true;
			}else if ($_POST['time_period']=='3'){
                $t="00:00:00";
				$year = date('Y'); 
				//echo $year = date('Y')-4;
                $date1=date('Y-12-31', strtotime($year));
				$dt1=$date1;
                $date1=$date1." ".$t;
                $strtotime=strtotime($date1);
                $last_year=strtotime("-1 year",$strtotime);
                $date2=date('Y-1-01', strtotime($year));   
				$dt2=$date2;        
                $date2=$date2." ".$t;
				$date1=date('Y-m-d H:i:s', strtotime($date1 . ' +1 day'));
				$trans_details=	create_graph($transaction_type,$date1,$date2);
                $data['graph']=true; 
			}
		}else{ 
			if($_POST['date_1st']&& $_POST['date_2nd']!=''){                
				$t="00:00:00";
                $date2=$_POST['date_1st'];
                $dt2=$date2;
                $date2=$date2." ".$t;
                $date1=$_POST['date_2nd'];
				$dt1=$date1;
                $date1=$date1." ".$t;
                $date1=date('Y-m-d H:i:s', strtotime($date1 . ' +1 day'));   
				$trans_details=	create_graph($transaction_type,$date1,$date2);
                $data['graph']=true; 
			}else{
				 //$data['Error']='PLEASE SELECT DATE RANGE.';				
				 $trans_details=create_graph($transaction_type,0,0);
			}
		}
	}else{
		 $data['Error']='PLEASE SELECT TRANSACTIONS TYPE.';
	}
   //print_r($trans_details);
    for($i=0;$i<count($trans_details);$i++){
        $date_transaction[$i]	=	date("Y-m-d", strtotime($trans_details[$i]['tdate']));
        $transaction_amount[$i]	=	(double)$trans_details[$i]['amount'];
    }
   // print_r($date_transaction);
   $data['date_transaction']=$date_transaction;
   $data['transaction_amount']=$transaction_amount;
   //print_r($transaction_amount);
   
   
 	//New Column Graph
	$graphdata=array();
	$graphdata=Column_Graph($trans_details);
	
	
	// Date Difference in Years
	if (($dt1!=0) && ($dt2!=0)){
		/*$dt1=date_create($dt1);
		$dt2=date_create($dt2);
		$diff=date_diff($dt2,$dt1);
		$Ydiff= $diff->format("%y");
		$Mdiff= $diff->format("%m");*/
		
		//Yearly Diffrence
		$dt2=date("y", strtotime($date2));
		$dt1=date('Y-m-d H:i:s', strtotime($date1 . ' -1 day'));  
		$dt1=date("y", strtotime($dt1));
		$Ydiff=$dt1-$dt2;
		
		//Monthly Diffrence
		$dt2=date("m", strtotime($date2));
		$dt1=date('Y-m-d H:i:s', strtotime($date1 . ' -1 day'));  
		$dt1=date("m", strtotime($dt1));
		$Mdiff=$dt1-$dt2;
		//echo 'Dates:'.$dt1.'='.$dt2;
		}else {$Ydiff=2;}
	
    }
	$td=$trans_details;
	/*echo '<br>Date1: '.$date1;
	echo '<br>Y-Diff: '.$Ydiff;*/

//Day-wise Graph
if (($Mdiff<1)&&($Ydiff<1)){$daygraph=DailyGraph($td,$date1,$date2);$post['daygraph']=$daygraph;}


//Monthly Graph
if (($Mdiff>0)&&($Mdiff<13)){$monthgraph=MonthlyGraph($td,$date1,$date2);$post['monthgraph']=$monthgraph;}

//Yearly Graph
if ($Ydiff>0){$yeargraph=YearlyGraph($trans_details,$date1,$date2); $post['yeargraph']=$yeargraph;}

$post['dataPoints']=$graphdata[0];
$post['total_amount']=$graphdata[1];
$post['ViewMode']=$post['action'];
###############################################################################
//$data['SystemBalance']=select_balance(-1);
###############################################################################
display('admins');
###############################################################################
?>