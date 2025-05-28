<?
$is_curl_on=true;
$is_webhook_on = false;

$data['HideMenu']=true;
$data['NO_SALT']=true;
$data['SponsorDomain']=true;

if(!isset($data['STATUS_ROOT'])){
    include('../../config_db.do');

    //Webhook 
    if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook')
    {
        $str_file_get=file_get_contents("php://input");
        $res_json_decode = json_decode($str_file_get,true);
        /*
            {
                "status": 1,
                "message": "Successful.",
                "data": {
                    "transactionId": "sk124567890120122",
                    "amount": "10.00",
                    "status": "success",
                    "utr_number": "422726289385",
                    "payer_vpa": "dash.ankitesh@ybl",
                    "payer_name": "ANKITESH DASH"
                }
            }

            ['data']['status']
            ['data']['amount']
            ['data']['utr_number']
            ['data']['payer_vpa']
        */

        //$res = @$res_json_decode['data'];
        
       // $data['logs']['php_input_0']=$str_file_get;
        $data['gateway_push_notify']=$res_json_decode;	
        
        if(isset($res_json_decode['data']['transactionId'])&&$res_json_decode['data']['transactionId'])
        {
            $is_curl_on = false;
            $is_webhook_on = true;
           
            @$responseParamList=@$res_json_decode;
            $_REQUEST['transID']=preg_replace("/[^0-9.]/", "",$res_json_decode['data']['transactionId']);
        }
    }

    include($data['Path'].'/payin/status_top'.$data['iex']);

}



//include($data['Path'].'/payin/status_in_email'.$data['iex']);


if(!empty($transID)&&$is_webhook_on==true)
{
    if($is_curl_on)
    {

      /*

       // if(@$acquirer==821) $serviceId='9061';
        

        $dataRequest = '';


        

       
        $encryptedStatus = '';//vpa encrypted request


        $curl = curl_init();

        curl_setopt_array($curl, array(
        CURLOPT_URL => trim($acquirer_status_url),
        
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS =>'"'. $encryptedStatus.'"',
        CURLOPT_HTTPHEADER => array(
            'Authentication: '.$encryptedDataHeader,
            'Content-Type: application/json'
        ),
        ));

        $response = curl_exec($curl);
            $http_status	= curl_getinfo($curl, CURLINFO_HTTP_CODE);
            $curl_errno		= curl_errno($curl);
        curl_close($curl);
        // echo $response;

        if(@$qp)
        {
            
        }

        if(@$qp)
        {
            echo '<div type="button" class="btn btn-success my-2" style="background:#dddfff;color:#2c2c2c;padding:5px 10px;border-radius:2px;margin:10px auto;width:fit-content;display:block;max-width:99%;">';

            
            echo "<br/>acquirer_status_url=>".@$acquirer_status_url;
            echo "<br/><br/>dataRequest=>". @$dataRequest;
            echo "<br/><br/>encryptedStatus=>\"". @$encryptedStatus.'"';

            echo "<br/><br/>headeRequest=>".@$headeRequest; 
            echo "<br/><br/>encryptedDataHeader=>". @$encryptedDataHeader;
            
            echo "<br/><br/>response=>".$response;
            
            echo '<br/><br/></div>';
        }

        
        if($http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404) {	//transaction stay as PENDING if received any one of the above error
            $err_msg = "Fino Bank :- HTTP Status == {$http_status}.";
            
            if($curl_errno) echo "<br/>Curl Errno returned $curl_errno.<br/>";
            
            $_SESSION['acquirer_response']		=$err_msg." - Pending";
            $_SESSION['acquirer_status_code']=1;
            $status_completed=false;
            
            //exit;
        }
        elseif($curl_errno){
            echo '<br/>Fino Bank :- Request Error: '.$curl_errno.' - ' . curl_error($handle);
            exit;
        }

        $responseParamList = jsondecode($response,1,1);	// covert response from json to array
      
        // covert ResponseData from json to array
        $responseData_array = json_decode_is($responseParamList,1);	

        if(isset($responseData_array))
        {
            $responseParamList=array_merge($responseParamList,$responseData_array);
        }

        //if(isset($responseParamList['ResponseData'])) unset($responseParamList['ResponseData']);
                
        // response result 
        if(@$qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;">';
			//echo "res=>"; print_r($res);
			
			echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<br/>acquirer status ['data']['status']=> ".@$responseParamList['data']['status'];
			echo "<br/>acquirer message ['ResponseMessage']=> ".@$responseParamList['ResponseMessage'];

			echo "<br/><br/>acquirer amount ['data']['amount']=> ".@$responseParamList['data']['amount'];
			echo "<br/>acquirer VPA ['data']['payer_vpa']=> ".@$responseParamList['data']['payer_vpa'];
			echo "<br/>acquirer RRN ['data']['utr_number']=> ".@$responseParamList['data']['utr_number'];

			echo "<br/><br/>acquirer status ['ResponseData']=> ".@$decryptedResponseData;
			
			//echo "<br/>response_json=> ".@$response_json;
			echo "<br/><br/>responseParamList=> "; print_r($responseParamList);
			
			//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
			echo '<br/><br/></div>';
		}
      */
    }

    $results = @$responseParamList;

    if(isset($responseParamList)&&count($responseParamList)>0)
    {

         
            //upa //rrn //acquirer_ref
            #######	upa, rrn, acquirer_ref update from status get :start 	###############
                
           
            //upa =>upiId,customer_vpa
            $upa='';
            if(isset($responseParamList['data']['payer_vpa'])&&@$responseParamList['data']['payer_vpa']) $upa= @$responseParamList['data']['payer_vpa'];		
            //up upa : update if empty upa and is upiId 
            if(empty(trim($td['upa']))&&!empty($upa)){
                $tr_upd_status['upa']=trim($upa);
            }
                    
            
            //rrn 
            $rrn='';
            if(isset($responseParamList['data']['utr_number'])&&@$responseParamList['data']['utr_number']) $rrn= @$responseParamList['data']['utr_number'];		
            
            //up rrn : update if empty rrn and is RRN 
            if(empty(trim($td['rrn']))&&!empty($rrn)){
                $tr_upd_status['rrn']=trim($rrn);
            }
            
            
            if($qp){
                echo "<br/><br/><=upa=>".@$upa;
                echo "<br/><br/><=acquirer_ref=>".@$acquirer_ref;
                echo "<br/><br/><=rrn=>".@$rrn;
                echo "<br/><br/><=tr_upd_status1=>";
                    print_r(@$tr_upd_status);
            }
            
            if(isset($tr_upd_status)&&count($tr_upd_status)>0&&is_array($tr_upd_status))
            {
                if($qp){
                    echo "<br/><br/><=tr_upd_status=>";
                    print_r(@$tr_upd_status);
                }
                
                trans_updatesf($td['id'], $tr_upd_status);
            }
            
        #######	upa, rrn, acquirer_ref update from status get :end 	###############

        

     

        /*
            ['data']['status']
            ['data']['amount']
            ['data']['utr_number']
            ['data']['payer_vpa']

        */


        $responseCode=$message='';

	    if(isset($responseParamList['data']['amount'])) 
            $_SESSION['responseAmount']=$transactionAmount=$responseParamList['data']['amount'];

	    if(isset($responseParamList['data']['status'])) 
		    $responseCode=$responseParamList['data']['status'];

	   

	    if(isset($responseParamList['ResponseMessage'])&&trim($responseParamList['ResponseMessage'])) 
		$message=$responseParamList['ResponseMessage'];

        $_SESSION['acquirer_action']=1;
		//$_SESSION['acquirer_transaction_id']=$results2->transactionId;
		//$_SESSION['acquirer_descriptor']=@$acquirer_descriptor;
		
        /*
        echo "<br/><br/><=transID=>".@$_REQUEST['transID'];
        echo "<br/>responseCode=>".$responseCode;
        echo "<br/><br/>responseParamList=>";
        print_r($responseParamList);
        exit;
       */
        

		if($responseCode=="success")
		{ // //success
			$_SESSION['acquirer_response']="Success";
			$_SESSION['acquirer_status_code']=2;
			
		}
       
		//elseif( ($responseCode=="failed") && (isset($is_expired)&&$is_expired=='N') )
		elseif($responseCode=="failed")
        {	//failed 
			$_SESSION['acquirer_response']="Cancelled";
			$_SESSION['acquirer_status_code']=-1;
            //$_SESSION['acquirer_response']="Expired";
			//$_SESSION['acquirer_status_code']=22;
		}
         /*
		else{ //pending
			$_SESSION['acquirer_response']=$message." - Pending";
			$_SESSION['acquirer_status_code']=1;
		}*/
    }

    /*
    echo "<br/><br/><=transID=>".@$_REQUEST['transID'];
    echo "<br/>responseCode=>".$responseCode;
    echo "<br/><br/>_SESSION=>";
    print_r(@$_SESSION);
    */

    if(!isset($data['STATUS_ROOT'])){
        include($data['Path'].'/payin/status_bottom'.$data['iex']);
    }
}
elseif(!empty($transID)) 
{

    db_disconnect();
    $return_json_response_arr["transID"]=@$td['transID'];
    $return_json_response_arr["order_status"]=@$td['order_status'];
    $return_json_response_arr["status"]=$data['TransactionStatus'][$td['trans_status']];
    $return_json_response_arr["bill_amt"]=@$td['bill_amt'];
    $return_json_response_arr["descriptor"]=@$td['descriptor'];
    $return_json_response_arr["tdate"]=@$td['tdate'];
    $return_json_response_arr["bill_currency"]=@$td['bill_currency'];
    $return_json_response_arr["response"]=@$td['response'];
    $return_json_response_arr["reference"]=@$td['reference'];
    $return_json_response_arr["mop"]=@$td['mop'];
    $return_json_response_arr['rrn']=@$td['rrn'];
    $return_json_response_arr['upa']=@$td['upa'];
    jsonen($return_json_response_arr);
    exit;
}




?>