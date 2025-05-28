<?

###############################################################################
$data['PageName']='RUNTIME GRAPH';
$data['PageFile']='runtime_graph';
//$data['graph']=true;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Runtime Graph - '.$data['domain_name'];
###############################################################################
if(!isset($_SESSION['adm_login'])){
	header("Location:{$data['Admins']}/login".$data['iex']);
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################



if(!isset($post['action'])||!$post['action'])$post['action']='select';
if(!isset($post['type']))$post['type']=-1;
if(!isset($post['status']))$post['status']=-1;
if($post['type']>=0){
	//$data['PageName'].= " [".strtoupper($data['t'][$post['type']]['name2'])."]";
}
###############################################################################
$trans_details = array();
$date_transaction = array();
$transaction_amount = array();

$subAdminId='';
	
if(isset($_REQUEST['sub_admin'])&&@$_REQUEST['sub_admin']){
    $subAdminId=implodef($_REQUEST['sub_admin']);
    //echo "subAdminId=> "; print_r($subAdminId);
}


//if(!isset($_REQUEST['sortingType']))
{
    if(isset($_REQUEST['dtest']))
    {
        echo "<br/><hr/><br/>Default=>";
        print_r(@$_REQUEST);
    }

    $request_set=@$_REQUEST;

    if(!isset($_REQUEST['date_2nd']))
    {
        //$request_set['date_1st']=date("Y-m-d H:i:00",strtotime('-1 hours'));
       // $request_set['date_2nd']=date("Y-m-d H:i:59");
        
        $request_set['date_1st']=date("Y-m-d H:i:s",strtotime('-1 hours'));
        $request_set['date_2nd']=date("Y-m-d H:i:s");
        
    }
    

    $trans_details1=get_trans_graph(@$request_set,4,@$subAdminId); // grfType=4 for runtime graph

    // Prepare data for graph
    $labels = [];
    $values = [];
    $c=0;   
    $rowGraph=[];   
    $post1['total_count']=0;   
    $post1['date_1st']=@$request_set['date_1st']; 
    $post1['date_2nd']=@$request_set['date_2nd'];

    foreach ($trans_details1 as $row) {
        $transaction_count=(int)$row['transaction_count'];

        $labels[] = $row['duration_category'].' ('.$transaction_count.')';
        $values[] = $transaction_count;

        $post1['total_count']	= @$post1['total_count']+$transaction_count;
		
        $c++;

        //$count_per = (($transaction_count*100)/$post1['total_count']);
        $count_per = ($transaction_count/100);
		$count_per = number_format($count_per,2);

        $rowGraph[]="<div class='col-sm-12'>
<div class='float-start no-width'>{$c}</div>
<div class='float-start desc-width'><div class='container1'>
<div class='skill' style='width: {$count_per}%;'></div>
<span class='me-2'>{$row['duration_category']}</span>{$transaction_count} ({$count_per}%)
</div></div>
</div>							
<div class='clearfix'>&nbsp;</div>";

        
        if(isset($_REQUEST['dtest'])) 
        echo "<br/><hr/>".$row['duration_category'].": ".$transaction_count."<br/>";
    }

    $post1['ids']=$c;

    $post1['duration_category']= $post1['labels']=$labels;
	$post1['transaction_count']=$post1['values']=$values;
	$post1['rowGraph']=implode(' ',@$rowGraph);
    $post1['rowGraph']=preg_replace('~[\r\n\t]+~', '', $post1['rowGraph']);
    $post1['date_dif']=humanizef(date_dif(@$request_set['date_1st'], @$request_set['date_2nd'], 'day|hour|minute|second'));


    if(isset($_REQUEST['dtest'])) print_r($post1);

    $post=array_merge($post,$post1);

    if(isset($_REQUEST['actionAjax'])&&$_REQUEST['actionAjax']=='ajaxAutoRefresh'){
        echo json_encode($post1);
        exit;
    }


    elseif(isset($_REQUEST['actionAjax'])&&$_REQUEST['actionAjax']=='ajax')
    {
        /*
        echo "<script>
        if(typeof jQuery == 'undefined') {
         document.write('<script type=\"text/javascript\" src=\"{$data['Host']}/js/jquery-3.6.0.min.js\"><\/script>');        
        } 
        </script>";
        echo "<script src=\"{$data['Host']}/thirdpartyapp/chart/chart.js\"></script>";
        */
        $runtime_graph_chart=("../front_ui/default/admins/template.runtime_graph_chart".$data['iex']);
        if(file_exists($runtime_graph_chart)){
            include($runtime_graph_chart);
        }
        exit;
    }
}

	
//$post['ViewMode']=$post['action'];
###############################################################################
//$data['SystemBalance']=select_balance(-1);
###############################################################################
display('admins');
###############################################################################
?>