<?php 
//if(!isset($_SESSION)) { session_start(); }
$data['includePathName']='sendtobank';

include('../config_db.do');

if(!isset($_SESSION['adm_login'])){
		$_SESSION['redirectUrl']=$data['urlpath'];
        header("Location:{$data['Admins']}/login".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}

error_reporting(0);
//-----------------------------------------------------------



	$data['pq']=0;$cp=0;
	if((isset($_REQUEST['pq']))&&(!empty($_REQUEST['pq']))){
		$data['pq']=$_REQUEST['pq'];
		$cp=1;
	}

	$host_path=$data['Host'];

	$status="";

	$actionurl_get="";
	$transID="";$transID=""; $where_pred=""; $message="";

	//-----------------------------------------------------------
	
	$onclick='javascript:top.popuploadig();popupclose2();';
	$actionurl="";$callbacks_url="";
		
	$is_admin=false; $subQuery="";
	
	
	
	
	if((isset($_REQUEST['actionurl']))&&(!empty($_REQUEST['actionurl']))){
		$actionurl=$_REQUEST['actionurl'];
	}
	
	

	if((isset($_REQUEST['redirecturl']))&&(!empty($_REQUEST['actionurl']))){
		$actionurl.="&redirecturl=".urlencode($_REQUEST['redirecturl']);
	}
	
	
	
	if(isset($_REQUEST['admin'])&&$_REQUEST['admin']){
		$is_admin=true;
		$subQuery.="&destroy=2&actionurl=$actionurl";
		
		//$host_path=$data['HostG'];
	}
	
	if(isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']){
		$subQuery.='&cron_tab='.$_REQUEST['cron_tab'];
	}
	
	// $subQuery="&destroy=2&actionurl=$actionurl&cron_tab=ok_backURL";
		
//-----------------------------------------------------------



if(isset($_REQUEST['transID'])&&!empty($_REQUEST['transID'])){
	$transID=$_REQUEST['transID'];
	
	//$where_pred.=" (`transID`={$transID}) AND";
}
if(isset($_REQUEST['actionurl'])&&!empty($_REQUEST['actionurl'])){
	$actionurl_get=$_REQUEST['actionurl'];
}



if((isset($_REQUEST['transID'])&&!empty($_REQUEST['transID']))){
	if(!empty($_REQUEST['transID'])){
		$transID=$_REQUEST['transID'];
	}
}	
	
	//cmn
	//$transID="260805212_6080";


	if(!empty($transID)){
		$transactionId=transIDf($transID,0); // transID
		//$tr_id=transIDf($transID,1); // table id
		
		$where_pred.=" (`transID`={$transactionId}) AND ";
		if(!empty($tr_id)){
			$where_pred.=" (`id`={$tr_id}) AND";
		}
	}



// transactions get ----------------------------

$where_pred=substr_replace($where_pred,'', strrpos($where_pred, 'AND'), 3);


//echo "<hr/>where_pred=>".$where_pred; echo "<hr/>transID=>".$transID;


$td=db_rows(
	"SELECT * ". 
	" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
	" WHERE ".$where_pred.
	" ORDER BY `id` DESC LIMIT 1",0 //DESC ASC
);
//print_r($td); exit;
$td=$td[0];

	$jsn=$td['json_value'];
	$json_value=jsondecode($jsn,true);
	
	//print_r($td);
	//print_r($json_value);
//echo "<hr/>type=>".$td['acquirer'];


		
	#######################################################
	
	

	$acquirer_response_de=json_decode($td['acquirer_response'],1);
	$json_value_de=json_decode($td['json_value'],1);

	if($cp){
		echo "<br/>json_value_de=>";
		print_r($json_value_de);
	}

	$names=lf($td['names'],40);
	$transactioncode=lf($td['transID'],20);
	$payable_amt_of_txn=$json_value_de['wd_payable_amt_of_txn_to'];
	
	$bswift=$acquirer_response_de[0]['bswift'];
	$baccount=$acquirer_response_de[0]['baccount'];
	$bnameacc=$acquirer_response_de[0]['bnameacc'];
		

	
	
	if($cp){
		echo "<br/>bswift=>".$acquirer_response_de[0]['bswift'];
		echo "<br/>baccount=>".$acquirer_response_de[0]['baccount'];
		echo "<br/>wd_payable_amt_of_txn_to=>".$payable_amt_of_txn;
		echo "<br/>MessageId=>".$json_value_de['MessageId'];
		echo "<br/>MsgSource=>".$json_value_de['nodalPostData']['MsgSource'];
		echo "<br/>ClientCode=>".$json_value_de['nodalPostData']['ClientCode'];
		echo "<br/><br/><br/>";
		
	}
	
	
	
	
	
	
	if(isset($json_value_de['MessageId'])&&$json_value_de['MessageId']){
		
		echo "Send to Bank already MessageId : ".$json_value_de['MessageId'];
		
		exit;
	}

	// start check status after post transaction 
	
	if($td['acquirer']==2&&$td['trans_status']==13){

		include('n74753/nodel_account_74753_post.do');
		

		// update json value 
		/*
		$json_value_de=array_merge($json_value_de,$json_value_de2);
		
		$clk_arr=array_merge($clk_arr,$json_value_de);
		$json_value_upd=json_encode($json_value_de);
		$transaction_update_query.=", `json_value`='{$json_value_upd}' ";
		*/
		
		#######################################################
		
		$system_notes=$td['system_note'];
		$system_note = $system_notes."<div class=rmk_row><div class=rmk_date>".date('d-m-Y h:i:s A')."</div><div class=rmk_msg>".json_encode($result_val)." </div></div>";
		
		if($td['id']){	
			db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `system_note`='".$system_note."' ".$transaction_update_query." WHERE (`id`={$td['id']}) ",0);
		}	
		
		echo json_encode($result_val);
	}
		
	exit;

?>
