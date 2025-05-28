<?php 

if(!isset($_SESSION)) {
	session_start();
}

include('../config.do');

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
	
	
	
	// curl parameter get by bank getaway   
	if( (isset($_REQUEST['action']))&&($_REQUEST['action']=='asynNtfyUrl') ){
		$this_action=$_REQUEST['action'];
		$_REQUEST['actionurl']='admin_direct';
		$_REQUEST['admin']=$this_action.'_is_curl_getaway';
		$subQuery.='&actionInfo='.$this_action;
	}
	
	
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
//print_r($td);
// exit;
$td=$td[0];

	$jsn=$td['json_value'];
	$json_value=jsondecode($jsn,true);
	
	//print_r($td);
	//print_r($json_value);
//echo "<hr/>type=>".$td['acquirer'];



//----------------------------------------------------------------

		
		//review 
		if( ((!isset($_SESSION['adm_login']))&&($td['trans_status']>0)) || ((!isset($_SESSION['adm_login']))&&($cardsend=="curl")) ){
			//echo "ACCESS DENY";  exit;
		}
		

	
 

//---------------------------------------------- 
	
		

		$curl_values_arr['responseInfo']=$_REQUEST;
		$curl_values_arr['browserOsInfo']=$browserOs;
		
		
	#######################################################
	
	

	$json_value_de=json_decode($td['json_value'],1);

	if($cp){
		echo "<br/>json_value_de=>";
		print_r($json_value_de);
	}
	
	

	$messageId=lf($td['transID'].'_'.date('dHis'),20);
	
	$hardcode_response=false;
	//cm
	//$hardcode_response=true;
	
	if(!isset($json_value_de['MessageId'])){
		
		echo "Cannot check {$td['transID']} UTR status because not find Message Id";
		
		exit;
	}

	$np_api['apikey']=$json_value_de['nodalPostData']['apikey'];
	$np_api['PaymentUrl']=$json_value_de['nodalPostData']['PaymentUrl'];
	$np_api['MessageId']=$messageId;
	$np_api['MsgSource']=$json_value_de['nodalPostData']['MsgSource'];
	$np_api['ClientCode']=$json_value_de['nodalPostData']['ClientCode'];
	
	if($cp){
		echo "<br/>MsgSource=>".$json_value_de['nodalPostData']['MsgSource'];
		echo "<br/>ClientCode=>".$json_value_de['nodalPostData']['ClientCode'];
		echo "<br/><br/><br/>";
		
	}
	

	// start check status after post transaction 

	$Date_Post=date('Y-m-dTH:i:s').'+05:30';
	
	if($hardcode_response==false){

		$curl_status = curl_init();
		curl_setopt_array($curl_status, array(
		  CURLOPT_URL => $np_api['PaymentUrl'],
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_ENCODING => '',
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 0,
		  CURLOPT_FOLLOWLOCATION => true,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => 'POST',
		  CURLOPT_POSTFIELDS =>'<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope"
		xmlns:ns0="http://www.kotak.com/schemas/CMS_Generic/Reversal_Request.xsd">
		  <soap:Header/>
		  <soap:Body>
			<ns0:Reversal>
			  <ns0:Header>
				<ns0:Req_Id>'.$np_api['MessageId'].'</ns0:Req_Id>
				<ns0:Msg_Src>'.$np_api['MsgSource'].'</ns0:Msg_Src>
				<ns0:Client_Code>'.$np_api['ClientCode'].'</ns0:Client_Code>
				<ns0:Date_Post>'.$Date_Post.'</ns0:Date_Post>
			  </ns0:Header>
			  <ns0:Details>
				<ns0:Msg_Id>'.$json_value_de['MessageId'].'</ns0:Msg_Id>
			  </ns0:Details>
			</ns0:Reversal>
		  </soap:Body>
		</soap:Envelope>
		',
		  CURLOPT_HTTPHEADER => array(
			'Content-Type: application/soap+xml',
			'action: /BusinessServices/StarterProcesses/CMS_Generic_Service.serviceagent/Reversal',
			'apikey: '.$np_api['apikey']
		  ),
		));

		$response_status_xml = curl_exec($curl_status);

		curl_close($curl_status);
		
	}
	else if($hardcode_response==true){
		include('n74753/hardcode_response'.$data['iex']);
	}
	
	
	if($cp){
		echo $response_status_xml;
	}


	$response_status_replace = str_replace(array("\n","\r","ns0:","SOAP-ENV:",":ns0"),"",$response_status_xml);
	
	$response_status_error=strip_tags($response_status_replace);
	$response_status_error=preg_replace('/^\s+|\s+$|\s+(?=\s)/', '',$response_status_error);

	$response_status_replace = preg_replace("/(<\/?)(\w+):([^>]*>)/", "$1$2$3", $response_status_replace);
	$simpleXMLElement_status = new SimpleXMLElement($response_status_replace);
	$after_body_status = $simpleXMLElement_status->xpath('//Body')[0];
	$get_status_json_val = json_encode((array)$after_body_status);
	 
	if($cp){
		print_r($get_status_json_val);
	}

	$result_status_decode = json_decode($get_status_json_val,true);
	$result_status_val = $result_status_decode['Reversal']['Details']['Rev_Detail'];
	
	$results=$result_status_val;

	$json_value_de2['nodalGetStatus']=$result_status_decode;
	if($result_status_val){
		$json_value_de2['Status_Msg_Id']=$result_status_val['Msg_Id'];
		$json_value_de2['Status_Code']=$result_status_val['Status_Code'];
		$json_value_de2['Status_Desc']=$result_status_val['Status_Desc'];
		$json_value_de2['Status_date']=date('Y-m-d H:i:s');
		
		$transaction_update_query.=", `trans_response`='{$result_status_val['Status_Desc']}' ";
	}else{
		$json_value_de2['nodalGetResponse']=$response_status_error;
	}



	if($cp){
		echo "<br/><br/>result=><br/>";
		print_r($result_status_val);

		echo "<br/><br/>Msg_Id=>".$result_status_val['Msg_Id'];
		echo "<br/><br/>Status_Code=>".$result_status_val['Status_Code'];
		echo "<br/><br/>Status_Desc=>".$result_status_val['Status_Desc'];
	}

	

	// update json value 
	
	$json_value_de=array_merge($json_value_de,$json_value_de2);
	
	$clk_arr=array_merge($clk_arr,$json_value_de);
	$json_value_upd=json_encode($json_value_de);
	$transaction_update_query.=", `json_value`='{$json_value_upd}' ";
	


	
	#######################################################
	
	
	
	if((isset($_REQUEST['cron_tab'])&&$_REQUEST['cron_tab']) || (isset($_REQUEST['actionurl'])&&$_REQUEST['actionurl']=='admin_direct')){
		
		$system_notes=$td['system_note'];
		$system_note = $system_notes."<div class=rmk_row><div class=rmk_date>".date('d-m-Y h:i:s A')."</div><div class=rmk_msg>".json_encode($result_status_val)." </div></div>";
		
		if($td['id']){	
			db_query("UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` SET `system_note`='".$system_note."' ".$transaction_update_query." WHERE (`id`={$td['id']}) ",0);
		}
			
		$_GET['promptmsg']='UTRN Status: '.$result_status_val['Status_Desc'];
			
		if($result_status_val['Status_Code']=='U'){
			update_trans_ranges(-1, 1, $td['id']);
		}elseif($result_status_val['Status_Code']=='Error-99'){
			
		}else{
			//update_trans_ranges(-1, 2, $td['id']);
		}
			
		echo json_encode($result_status_val);
		
		exit;
	}
	
	
		

	  if($is_admin){


			
		
		$callbacks_url=str_replace('actionurl=by_admin','actionurl=admin_direct',$data['urlpath']);
		
					
			
		echo "<div class='hk_sts'><div class='rows'>";
		
			echo "<a target='hform' onclick='{$onclick}' href='$callbacks_url' class='upd_status'>Update Status "." [<b>".$result_status_val['Status_Code']." - ".$result_status_val['Status_Desc']."</b>]"."</a>";
		
		
		if(is_array($results)){ 
			foreach($results as $key=>$value){
				if($key!="StateDetails" && $value!="Array" && !empty($value)){
					echo "<div class='dta1 key $key'>".$key."</div><div class='dta1 val'>".isJsonDe($value)."</div>";
				}
				if(is_array($value)){
					echo "<div class='dta1 h1 key $key'>".$key."</div>";
					foreach($value as $key1=>$value1){
						if($key1!="StateDetails" && $value1!="Array" && !empty($value1)){
							echo "<div class='dta1 key $key1'>".$key1."</div><div class='dta1 val'>".isJsonDe($value1)."</div>";
						}
					}
				}
			}
		}
		echo "</div>";
		
		

		//echo "<br/><br/>Info: ".$results['info'];
		//echo "<br/><br/>Status: ".$result_hkip['status'];
		echo "<br/><br/>order_status: ".$_SESSION['hkip_order_status']." [".$_SESSION['hkip_info']."]";
		echo "<br/><br/>pid: ".$_SESSION['hkip_pid'];
		echo "<br/><br/>billing_desc: ".$_SESSION['hkip_billing_desc'];
		echo "<br/><br/>respMsg: ".$_SESSION['hkip_info'];
		echo "<br/><br/>mh_oid: ".$transID;
		echo "<br/><br/>site_id: ".$site_id;



	  }
	
	
	
	
exit;





	

//----------------------------------------------------------------



	

?>
