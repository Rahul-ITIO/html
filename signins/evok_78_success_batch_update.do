<?php

function print_mem()
{
   /* Currently used memory */
   $mem_usage = memory_get_usage();
   
   /* Peak memory usage */
   $mem_peak = memory_get_peak_usage();
   return 'Memory Consumption is: <strong>' . round($mem_usage / 1048576,2) . ' MB</strong> of memory. |  Peak usage: <strong>' . round($mem_peak / 1048576,2) . ' MB</strong> of memory.<br>';
}
$post['print_mem']=print_mem();



#########################################################################
$data['PageName']='Evok CSV successfull transaction';
$data['PageFile']='evok_78_success_batch_update'; 
##########################################################################
include('../config.do');

if(isset($data['domain_server']['as']['useful_link'])&&$data['domain_server']['as']['useful_link']){
	//$data['PageFile']=$data['domain_server']['as']['useful_link']; 
}

$data['PageTitle'] = 'Upload the bath file recevied from NPST - Evok with all successfull transaction  - '.$data['domain_name']; 
###############################################################################
if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['useful_link']))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(!isset($_SESSION['adm_login'])){
       echo('ACCESS DENIED.');
       exit;
}

//echo "<br/>cid1=>".@$data['cid'];

function findStrf1($str, $arr) {  
    foreach ($arr as &$s){
       if(strpos($str, $s) !== false){
			return $s; //return true;break;
	   }
    }
    return false;
}

$qp=0;

if(isset($_REQUEST['qp'])&&$_REQUEST['qp']) $qp=$_REQUEST['qp'];
if(isset($_REQUEST['pq'])&&$_REQUEST['pq']) $qp=$_REQUEST['pq'];

 ########################################################
            
    // login session id 
    $admin_id='';
    if(isset($_SESSION['adm_login'])){
        if(isset($_SESSION['sub_admin_id'])){
            $admin_id=$_SESSION['sub_admin_id'].":".$_SESSION['sub_admin_fullname']."-".$_SESSION['sub_admin_rolesname'];
        }elseif(isset($_SESSION['m_username'])&&(!isset($_SESSION['adm_login']))){
            $admin_id="Merchant:".$_SESSION['uid']."-".$_SESSION['m_username'];
        }else{
            if(isset($_SESSION['admin_id'])&&isset($_SESSION['sub_username'])){
                $admin_id="Admin : ".$_SESSION['admin_id']." - ".$_SESSION['sub_username'];
            }
            else
            {
                $admin_id='Admin...';
            }
        }
        
        if(@$admin_id) $admin_id='_updating_via_'.$admin_id.'';
    }
    
    @$admin_id='csv'.@$admin_id;
    
######################################################################

if(isset($_REQUEST['downloadHtml'])&&$_REQUEST['downloadHtml'])
{
    
    $_REQUEST['downloadHtml']=str_replace(["<br/>","<hr/>"],["\r\n",""],$_REQUEST['downloadHtml']);

    $download_date=(new DateTime())->format('YmdHisu');
    $fileName = $data['SiteName']."_csv_log_{$download_date}.txt";
    //echo '<br/>fileName=>'.$fileName;exit;
    header('Content-Encoding: UTF-8');
    header('Content-Disposition: attachment; filename='.$fileName);
    echo @$_REQUEST['downloadHtml'];
    //print_r($_REQUEST);
    exit;

}


######################################################################

// Swich to more db connection via include/u_78.do?pq=1&DB_CON=2&db_ad=1

    $dbad_link_2='';
    if((isset($data['DB_CON'])&&isset($_REQUEST['DB_CON'])&&$_REQUEST['DB_CON'])&&(!isset($data['IS_DBCON_DEFAULT'])|| $data['IS_DBCON_DEFAULT']!='Y')){

        $DB_CON=@$_REQUEST['DB_CON'];
        $db_ad=@$_REQUEST['db_ad'];
        $db_mt=@$_REQUEST['db_mt'];
    
        $link_db=config_db_more_check_link($DB_CON,$db_ad,$db_mt);
        $dbad_link_2=$link_db['dbad_link_2'];
        //$dbad_link_2 .=$link_db['dbad_link'].$link_db['dbad_link_2'];
    
        
    }

########################################################


$_REQUEST['transID']=@$transID;
$_REQUEST['action']='webhook';
$_REQUEST['cron_tab']='cron_tab';
$_REQUEST['cront_response']=@$admin_id;

/*
    
    $_REQUEST['DB_CON']=2;
    $_REQUEST['db_ad']=1;
    $_REQUEST['dtest']=1;

*/


######################################################################

$t_id=[];
if(!isset($_SESSION['t_id_all']))
$_SESSION['t_id_all']=[];

$_SESSION['pending_tr']=[]; 
$_SESSION['pre_approved_tr']=[]; 
$_SESSION['approved_tr']=[]; 
$_SESSION['declined_tr']=[]; 
$_SESSION['expired_tr']=[]; 

/*
if(!isset($_SESSION['pending_tr'])) $_SESSION['pending_tr']=[]; 
if(!isset($_SESSION['pre_approved_tr'])) $_SESSION['pre_approved_tr']=[]; 
if(!isset($_SESSION['approved_tr'])) $_SESSION['approved_tr']=[]; 
if(!isset($_SESSION['declined_tr'])) $_SESSION['declined_tr']=[]; 
if(!isset($_SESSION['expired_tr'])) $_SESSION['expired_tr']=[]; 
*/
######################################################################

// csv file data fetch 

$post['csv_file_on']=0;



if(isset($_POST['submit']))
{

    if(isset($_FILES['file']) && $_FILES['file']['error'] === UPLOAD_ERR_OK) {

        //==============================Fetch Data From Excel=============================
        $file_ext = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);
        $file = $_FILES['file']['tmp_name'];
        $handle = fopen($file, "r");

        if(strpos($file_ext,'csv') !== false)
        {
            
            //$cars=array("Volvo","BMW","Toyota","Honda","Mercedes","Opel");
            //print_r(array_chunk($cars,2));

            $i=0;
            while(($filesop = fgetcsv($handle, 1000, ",")) !== false)
            {
                if($i==0)
                {
                    
                }
                else
                {

                    if(@$qp) echo "<br/><hr/>";

                    $post['csv_file_on']=1;
                    
                    ########################################################
                
                    // data fetch from csv file 

                    $pramPost=array();

                        $pramPost['date']	= $filesop[0];
                        $pramPost['amount']	= $filesop[1];
                    $pramPost['rrn']=@$rrn=$filesop[2]; // rrn
                    $pramPost['transID']=@$transID=$filesop[3]; //Ext Id is our transID 
                        $pramPost['tr_status']	= $filesop[4];
                        $pramPost['npci_code']	= $filesop[5];
                       // $pramPost['switch_code']	= $filesop[6];
                    $pramPost['switch_msg']=@$status=@$acquirer_response=$filesop[7]; // status code 
                        $pramPost['payee_vpa']	= $filesop[8];
                    $pramPost['payer_vpa']=@$upa=$filesop[9];   // upa as a vpa 
                    $pramPost['txn_id']=@$acquirer_ref=@$acquirer_transaction_id=$filesop[10]; // acquirer ref via txn id
                        $pramPost['mcc']	= $filesop[11];
                        $pramPost['Remarks']=$filesop[12]; 

                    $transID=preg_replace("/[^0-9.]/", "",$transID);

                

                ######################################################################

                    @$_SESSION['t_id_all'][]=@$t_id[]=@$transID;


                ######################################################################

                // trans status get and if not success then update 

                $td_get=db_rows(
                    "SELECT `trans_status` ". 
                    " FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
                    "  WHERE (`transID`={$transID}) ".
                    " LIMIT 1",$qp 
                );

                $td=@$td_get[0];
                $trans_status	= @$td['trans_status'];

                if($trans_status==1)
                { //pre approved 
                    $_SESSION['pre_approved_tr'][]=$transID;
                }
                else 
                { // not success then update transaction for successfull 

                    ######################################################################

                    // subquery url for retrun url 

                        @$subQuery='&destroy=2&acquirer_retrun_json_response=Y&cron_tab=cron_tab&cron_host_response='.@$admin_id.@$dbad_link_2;


                    ########################################################
                    // hard code SUCCESS passing for always SUCCESS from CSV File 
                    $status='SUCCESS';

                    ########################################################

                    // condition define as per success of failed 

                        if(@$status=='SUCCESS')
                        { //success

                            @$acquirer_response=@$acquirer_response." - Success";
                            @$acquirer_status_code=2;
                        }
                        elseif(@$status=='DEEMED' || @$status=='FAILURE' || @$status=='FAIL' || @$message=='FAILURE' || @$message=='FAIL'){	//failed
                            @$acquirer_response=@$acquirer_response." - Cancelled";
                            @$acquirer_status_code=-1;
                        }
                        /*
                        elseif( ($message=='No Data Found') && ( isset($is_expired)&&$is_expired=='N' ) )
                        {	//pending :- not expired and No Data Found 
                            $acquirer_response=$acquirer_response." - Pending";
                            $acquirer_status_code=1;
                        }
                        */
                        


                        ########################################################

                            $data_send=array();
                            $data_send['transID']=@$transID;
                            $data_send['acquirer_action']=1;
                            $data_send['acquirer_response']=@$acquirer_response;
                                $data_send['acquirer_status_code']=@$acquirer_status_code;
                            $data_send['acquirer_transaction_id']=@$acquirer_transaction_id;
                            $data_send['acquirer_descriptor']=@$acquirer_descriptor;
                        // $data_send['acquirer']=@$acquirer;
                        // $data_send['admin']='1';
                            $data_send['cron_host_response']=@$admin_id;
                            $data_send['cron_tab']='cron_tab';
                            $data_send['action']='webhook';
                            $data_send['acquirer_retrun_json_response']='Y';
                            //$data_send['CURLOPT_HEADER']='1';

                            if(isset($rrn)&&trim($rrn)) {
                                $data_send['rrn']=@$rrn;
                                @$subQuery=@$subQuery.'&rrn='.@$rrn;
                            }

                            if(isset($upa)&&trim($upa)) {
                                $data_send['upa']=@$upa;
                                @$subQuery=@$subQuery.'&upa='.@$upa;
                            }


                        // $data_send = $_POST = strip_tags_d($data_send);
                            $data_send = strip_tags_d($data_send);

                            $return_url_include = "return_url{$data['ex']}?transID=$transID&action=webhook".@$subQuery;
                            
                            $return_url = $data['Host']."/".@$return_url_include;

                        // $return_url=str_replace(" ","+",$return_url);

                        
                        ########################################################

                            if(isset($transID)&&trim($transID)){
                                db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `trans_status`='22'  WHERE `transID`={$transID}  ",$qp);
                            }

                        ########################################################

                        //cron_tab=cron_tab&cront_response

                        //cront.do?pq=1&db_reset_page=1&DB_CON=2&db_ad=1&t=



                        $get_string=json_encode($pramPost);


                        //include($data['Path'].'/payin/pay78/status_78_upd'.$data['iex']);

                        //include($data['Path'].'/'.$return_url_include);

                        $curlResponse=use_curl($return_url,$data_send);

                        if(@$qp)
                        {
                            echo "<br/>return_url=>".@$return_url;
                            echo "<br/>pramPost=>";
                            print_r($get_string);
                        }
                        if(isset($data_send['CURLOPT_HEADER'])&&trim($data_send['CURLOPT_HEADER']))
                        {
                            echo "<br/>curlResponse HEADER=>";
                            print_r($curlResponse);
                        }
                        

                    
                        // retrun response after update the status 
                        if(isset($curlResponse)&&$curlResponse)
                        {
                            $curlResponse_de=json_decode($curlResponse,1);
                            if(@$qp)
                            {
                                echo "<br/>curlResponse_de=>"; 
                                print_r($curlResponse_de);
                            }

                            if(isset($curlResponse_de)&&$curlResponse_de&&is_array($curlResponse_de)){
                                
                                    $curlResponse_de['order_status']=(int)@$curlResponse_de['order_status'];

                                    if(isset($curlResponse_de['order_status'])&&$curlResponse_de['order_status']==1){ //success - Approved
                                        $_SESSION['approved_tr'][]=$curlResponse_de['transID'];
                                    }
                                    elseif(isset($curlResponse_de['order_status'])&&$curlResponse_de['order_status']==2){ //failed - Declined
                                        $_SESSION['declined_tr'][]=$curlResponse_de['transID'];
                                    }
                                    elseif(isset($curlResponse_de['order_status'])&&($curlResponse_de['order_status']==22||$curlResponse_de['order_status']==23)){ //failed - Declined
                                        $_SESSION['expired_tr'][]=$curlResponse_de['transID'];
                                    }
                                    elseif(isset($curlResponse_de['order_status'])&&$curlResponse_de['order_status']==0){ //pending
                                        $_SESSION['pending_tr'][]=$curlResponse_de['transID'];
                                    }
                                    
                            }
                        }
                        else {
                            if(@$qp)
                            {
                                echo "<br/>curlResponse=>";
                                print_r($curlResponse);
                            }
                        }
                    }
                    if(@$qp) echo "<br/>";

                    ###########
                    
                }
                $i++;
            }
        }
        else  $_SESSION['Error']=@$data['Error']='File Not supported. Please upload the csv file only.';

        

        
    // header("Location:{$data['Host']}/user/transfers{$data['ex']}");exit;
    //	header("Location:{$data['Host']}/user/payout-transaction{$data['ex']}");exit;
    }else{
        $_SESSION['Error']=@$data['Error']='File Not supported. Please upload the csv file only.';
    }

}
######################################################################

$downloadHtml='';

//if($data['pq'] || (isset($_REQUEST['log'])&&$_REQUEST['log']))
if(isset($post['csv_file_on'])&&trim($post['csv_file_on']))
{
     $downloadHtml.="<br/><hr/><br/><==All TransID==>".count($t_id)."<br/>".implode(",",$t_id);
    
     $downloadHtml.="<br/><br/><hr/><br/><==Already successful, no action taken==>".count($_SESSION['pre_approved_tr'])."<br/>".implode(",",$_SESSION['pre_approved_tr']);
     $downloadHtml.="<br/><br/><hr/><br/><==APPROVED==>".count($_SESSION['approved_tr'])."<br/>".implode(",",$_SESSION['approved_tr']);
     $downloadHtml.="<br/><br/><hr/><br/><==PENDING==>".count($_SESSION['pending_tr'])."<br/>".implode(",",$_SESSION['pending_tr']);
     $downloadHtml.="<br/><br/><hr/><br/><==DECLINED==>".count($_SESSION['declined_tr'])."<br/>".implode(",",$_SESSION['declined_tr']);
     $downloadHtml.="<br/><br/><hr/><br/><==EXPIRED==>".count($_SESSION['expired_tr'])."<br/>".implode(",",$_SESSION['expired_tr']);
    
    //echo $downloadHtml;

    if(@$qp) 
        echo "<br/><br/><hr/><br/><==All t_id==>".count($_SESSION['t_id_all'])."<br/>".implode(",",$_SESSION['t_id_all']);
    
    echo "<br/><br/><hr/>";


    
}
 
$post['downloadHtml_2']=@$downloadHtml;

######################################################################



/*

$queryArray1=["UPDATE","DELETE","INSERT","ALTER"];

$p='';
if((isset($_GET['qr'])&&($_GET['qr']))||(isset($_POST['qr'])&&($_POST['qr']))){
	$q=$_REQUEST['qr'];
	$p=$q;
	$q_str = str_ireplace(array('update','delete','insert','alter'), array('UPDATE','DELETE','INSERT','ALTER'), $q );
	$isNotQuery=findStrf1($q_str, $queryArray1);
	//echo "<br/><br/>q_str=>".$q_str."<br/><br/>"; echo "<br/><br/>isNotQuery=>".$isNotQuery."<br/><br/>";
	if(@$isNotQuery){
		echo "Not Allow this Query";
	}
	else
	{
		$db_query=db_query($q,1); echo "<hr/>Result=>"; print_r($db_query);
	}
	
	
}elseif((isset($_GET['s'])&&($_GET['s']))||(isset($_POST['s'])&&($_POST['s']))){
	$s=$_REQUEST['s'];
	$p=$s;
	
	$q_str = str_ireplace(array('update','delete','insert','alter'), array('UPDATE','DELETE','INSERT','ALTER'), $s );
	$isNotQuery=findStrf1($q_str, $queryArray1);
	
	if($isNotQuery){
		echo "Not Allow this Query";
	}else{
		$db_rows1=db_rows($s,1);
	}
	
	
	
	if((isset($_GET['p'])&&($_GET['p']))||(isset($_POST['p'])&&($_POST['p']))){
		echo "<hr/>Result=>";
		print_r($db_rows1);
	}
	
}

*/

/*
echo "<br/>connection_type=>". $data['connection_type'];
if($data['connection_type']=='PSQL'){
	//$cid=pg_fetch_all_columns($data['cid']);
	echo ", cid=>";print_r(@$cid);
}
else echo ", cid=>"; print_r($data['cid']);
*/

//db_disconnect();	//disconnect DB connection
//ob_end_flush();		//Deletes the topmost output buffer and outputs all of its contents.
	
//@mysqli_close($data['cid']);
//db_disconnect();

display('admins');

?>


