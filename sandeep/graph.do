<?
###############################################################################
$data['PageName']='SYSTEM ADMINISTRATOR LOGIN';
$data['PageFile']='graph';
$data['HideMenu']=true;
$data['graph']=false;
###############################################################################

 include ('libchart/libchart/classes/libchart.php');
 include('../config.do');
###############################################################################
//$data['depositeData']= get_deposite_info()
 //print_r($data['depositeData']);
 
if($post['action']=='Search')
{
 // if(isset($_POST['transaction_type']) && $_POST['transaction_type']!='' )
     
  //if(isset($_POST['time_period']) && $_POST['time_period']!='' )
   
             $this_var =$_POST['time_period'];
   			//print_r($_POST);
            $transaction_type = $_POST['transaction_type'];
            if ($_POST['time_period']=='1')
            
            {
          $t="00:00:00";
	
             $date = new DateTime('7 days ago');
		 $date2= $date->format('Y-m-d');
              $date2=$date2." ".$t;
             $date1=date('Y-m-d');
                echo $date1=$date1." ".$t;   
        	create_graph($transaction_type,$date1,$date2);
            $data['graph']=true;  }
			else if(isset($_POST['transaction_type']) && $_POST['time_period']=='' )
            {
            echo "Please select type and date.";
            }
}
if($post['send'])
{	
 

if($data['amount']==0){	$data['Error']='No Deposites.';}
	    else {
		if($data['UseTuringNumber'])unset($_SESSION['turing']);
		$_SESSION['adm_login']=true;
		header("Location:{$data['Admins']}/index.do");
		echo('ACCESS DENIED.');
		exit;
		}
}
###############################################################################
if($data['UseTuringNumber'])$_SESSION['turing']=gencode();
###############################################################################
display('admins');
###############################################################################
	
?>
