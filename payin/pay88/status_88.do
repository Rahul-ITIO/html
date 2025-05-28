<?
$is_curl_on=1;
$qr=0;

if(isset($_REQUEST['qr'])){
    $qr=$_REQUEST['qr'];
}
if(isset($_REQUEST['pq'])){
    $pq=$qr=$_REQUEST['pq'];
}


if(!isset($data['STATUS_ROOT'])){
    include('../../config_db.do');

    //Webhook 
    if(isset($_REQUEST['action'])&&$_REQUEST['action']=='webhook')
    {
        $str_file_get=file_get_contents("php://input");
        $res_json_decode = json_decode($str_file_get,true);

        /*
        {
            "data": {
                "status": "failed",
                "settlementStatus": "pending",
                "_id": "6714d64483d3af56fcbd5347",
                "userContactNumber": "1234567890",
                "merchantTransactionId": "8814433100",
                "amount": 1.11,
                "merchantId": "670fdc8ab069f78d27adadf1",
                "createdAt": "2024-10-20T10:07:00.746Z",
                "rrn": ""
            },
            "code": 200,
            "message": "Transaction Details."
        }
        */


        ##############################################################################

        //Webhook res
        if(isset($res_json_decode)&&isset($res_json_decode['data'])&&$res_json_decode['data']) @$res = @$res_json_decode['data'];
        else @$res = @$res_json_decode;

       
        
       // $data['logs']['php_input_0']=$str_file_get;
        $data['gateway_push_notify']=@$res;	
        
        if(isset($res['transaction_id'])&&$res['transaction_id'])
        {
            $is_curl_on = false;
            @$responseParamList=@$res;

            $_REQUEST['acquirer_ref']=@$res['transaction_id'];

            
        }

        if(isset($data['cqp'])&&$data['cqp']>0 || isset($qr)&&$qr )
        {
            echo "<br/><hr/><br/><h3>TRANSID VIA WEBHOOK</h3><br/>"; 
            //echo "<br/><hr/><br/>transID _REQUEST:<br/>"; print_r(@$_REQUEST['transID']);
            echo "<br/><hr/><br/>acquirer_ref:<br/>"; print_r(@$_REQUEST['acquirer_ref']);
            echo "<br/><hr/><br/>responseParamList:<br/>"; print_r(@$responseParamList);
            echo "<br/><hr/><br/>res:<br/>"; print_r(@$res);
           
            echo "<br/><hr/><br/>";

            if($qr==3) exit;

        }

    }

    include($data['Path'].'/payin/status_top'.$data['iex']);
}


//include($data['Path'].'/payin/status_in_email'.$data['iex']);


if(!empty($transID))
{

    $mopType=@$json_value['post']['mop'];
    if(empty(@$mopType)){
        $mopType=@$json_value['get']['mop'];
    }


    //if(isset($_SESSION['adm_login'])) $is_curl_on=1;

    if(@$is_curl_on)
    {

        
        if(isset($_REQUEST['qp'])&&$_REQUEST['qp']>0) $data['cqp']=1;
        elseif(isset($_REQUEST['pq'])&&$_REQUEST['pq']>0) $data['cqp']=1;
        elseif(isset($_REQUEST['dtest'])&&$_REQUEST['dtest']>0) $data['cqp']=1;
        

        ##########################################################

        if(empty($acquirer_status_url)||strtolower($acquirer_status_url)=='NA') $acquirer_status_url="https://apis.paytme.com/v1/merchant/payin";

       
            
        //https://apis.paytme.com/v1/merchant/payin/6714d64483d3af56fcbd5347    

        //if(@$mopType=='QRINTENT') 
        
        if((empty(trim($td['acquirer_ref']))||$td['acquirer_ref']=='{}')&&isset($json_value['response_qr_intent']['data']['transaction_id'])&&@$json_value['response_qr_intent']['data']['transaction_id'])
        $acquirer_ref=@$json_value['response_qr_intent']['data']['transaction_id'];

        $acquirer_status_url=$acquirer_status_url."/".@$acquirer_ref;


        
        $_httpheader=array(
            'x-api-key: '.@$apc_get['apikey']
        );

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h3>STATUS</h3><br/>"; 

            echo "<br/><hr/><br/>acquirer_ref:<br/>"; print_r($acquirer_ref);

            echo "<br/><hr/><br/>acquirer_status_url:<br/>"; print_r($acquirer_status_url);
            echo "<br/><hr/><br/>qr_httpheader:<br/>"; print_r($_httpheader);
            echo "<br/><hr/><br/>";
        }


        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => $acquirer_status_url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'GET',
                CURLOPT_HEADER => 0,
                CURLOPT_SSL_VERIFYHOST => 0,
                CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_HTTPHEADER => $_httpheader,
        ));

        $response = curl_exec($curl);
        curl_close($curl);
        $response_dec = json_decode($response,1);

    
       

        if(isset($data['cqp'])&&$data['cqp']>0)
        {
            echo "<br/><hr/><br/><h3>RESPONSE OF STATUS.</h3><br/>"; 
            echo "<br/><hr/><br/>response:<br/>"; print_r(@$response);
            echo "<br/><hr/><br/>response_dec:<br/>"; print_r(@$response_dec);
            echo "<br/><hr/><br/>";
        }

        if(isset($response_dec['data'])&&@$response_dec['data']) @$responseParamList=@$response_dec['data'];
        else @$responseParamList=@$response_dec;


      
        
        if($http_status==503 || $http_status==500 || $http_status==403 || $http_status==400 || $http_status==404) {	//transaction stay as PENDING if received any one of the above error
            $err_msg = "Paytme Bank :- HTTP Status == {$http_status}.";
            
            if($curl_errno) echo "<br/>Curl Errno returned $curl_errno.<br/>";
            
            $_SESSION['acquirer_response']		=$err_msg." - Pending";
            $_SESSION['acquirer_status_code']=1;
            $status_completed=false;
            
            //exit;
        }
        elseif($curl_errno){
            echo '<br/>Canara Bank :- Request Error: '.$curl_errno.' - ' . curl_error($handle);
            exit;
        }

        
                
        // response result 
        if(@$qp)
		{
			echo '<div type="button" class="btn btn-success my-2" style="background:#198754;color:#fff;padding:5px 10px;border-radius:10px;margin:10px auto;width:fit-content;display:block;max-width:94%;word-wrap:anywhere;">';
			//echo "res=>"; print_r($res);
			
			echo "<br/>acquirer_status_url=> ".$acquirer_status_url;
			echo "<br/>acquirer status ['status']=> ".@$responseParamList['status'];
			echo "<br/>acquirer message ['settlementStatus']=> ".@$responseParamList['settlementStatus'];

			echo "<br/><br/>acquirer amount ['amount']=> ".@$responseParamList['amount'];
			echo "<br/>acquirer UPA ['merchantId']=> ".@$responseParamList['merchantId'];
			echo "<br/>acquirer RRN ['rrn']=> ".@$responseParamList['rrn'];
			echo "<br/>acquirer VPA ['_id']=> ".@$responseParamList['_id'];

			
			//echo "<br/>response_json=> ".@$response_json;
			echo "<br/><br/>responseParamList=> "; print_r($responseParamList);

            echo "<br/><hr/><br/>statusDataDecode:<br/>"; print_r(@$url);
			
			//echo "<br/><br/>res=> ".htmlentitiesf(@$responseParamList);
			echo '<br/><br/></div>';
		}

    }

    $results = @$responseParamList;

    if(isset($responseParamList)&&count($responseParamList)>0)
    {


        //upa //rrn //acquirer_ref
        #######	upa, rrn, acquirer_ref update from status get :start 	###############
            
            //acquirer_ref_2	
            /*
            $acquirer_ref_2='';
            if(@$responseParamList['txnId']) $acquirer_ref_2= @$responseParamList['txnId'];
            //up acquirer_ref_2 : update if empty acquirer_ref and is txnId 
            if((empty(trim($td['acquirer_ref']))||$td['acquirer_ref']=='{}')&&!empty($acquirer_ref_2)){
                $tr_upd_status['acquirer_ref']=trim($acquirer_ref_2);
            }
            */
           
            //upa =>merchantId,merchantId
            $upa='';
            if(isset($responseParamList['merchantId'])&&@$responseParamList['merchantId']) $upa= @$responseParamList['merchantId'];	
            	
            //up upa : update if empty upa and is merchantId 
            if(empty(trim($td['upa']))&&!empty($upa)){
                $tr_upd_status['upa']=trim($upa);
            }
                    
            
            //rrn 
            $rrn='';
            if(isset($responseParamList['rrn'])&&@$responseParamList['rrn']) $rrn= @$responseParamList['rrn'];		
            
            //up rrn : update if empty rrn and is RRN 
            if(empty(trim($td['rrn']))&&!empty($rrn)){
                $tr_upd_status['rrn']=trim($rrn);
            }
            
            
            if($qp){
                echo "<br/><br/><=upa=>".$upa;
                echo "<br/><br/><=acquirer_ref=>".$acquirer_ref;
                echo "<br/><br/><=rrn=>".$rrn;
                echo "<br/><br/><=tr_upd_status1=>";
                    print_r($tr_upd_status);
            }
            
            if(isset($tr_upd_status)&&count($tr_upd_status)>0&&is_array($tr_upd_status))
            {
                if($qp){
                    echo "<br/><br/><=tr_upd_status=>";
                    print_r($tr_upd_status);
                }
                
                trans_updatesf($td['id'], $tr_upd_status);
            }
            
        #######	upa, rrn, acquirer_ref update from status get :end 	###############



        $responseCode=$message='';

	    if(isset($responseParamList['amount'])) 
            $_SESSION['responseAmount']=$transactionAmount=$responseParamList['amount'];

	    if(isset($responseParamList['status'])) 
		    $responseCode=$responseParamList['status'];

	    elseif(isset($responseParamList['status'])) 
		    $responseCode=$responseParamList['status'];

	    

	   // elseif(isset($responseParamList['ResponseCode']))  $responseCode=$responseParamList['ResponseCode'];

	    if(isset($responseParamList['settlementStatus'])&&trim($responseParamList['settlementStatus'])) 
		$message=$responseParamList['settlementStatus'];

        $_SESSION['acquirer_action']=1;
		//$_SESSION['acquirer_transaction_id']=$results2->transactionId;
		//$_SESSION['acquirer_descriptor']=@$acquirer_descriptor;
		
        /*
        echo "<br/>responseCode=>".$responseCode;
        echo "<br/><br/>responseParamList=>";
        print_r($responseParamList);
        exit;
        */

		if($responseCode=="success"||$responseCode=="1"||$responseCode=="approved"||$responseCode=="paid")
		{ // success
			$_SESSION['acquirer_response']="Success";
			$_SESSION['acquirer_status_code']=2;
			
		}
        elseif($responseCode=="failed"||$responseCode=="2")
        {	//failed 
			$_SESSION['acquirer_response']="Cancelled";
			$_SESSION['acquirer_status_code']=-1;
           
		}
       /*
		//elseif( ($responseCode=="FAILURE") && (isset($is_expired)&&$is_expired=='N') )
        {	//failed 
			//$_SESSION['acquirer_response']=$message." - Cancelled";
			//$_SESSION['acquirer_status_code']=-1;
            $_SESSION['acquirer_response']=$message." - Expired";
			$_SESSION['acquirer_status_code']=22;
		}
         
		else{ //pending
			$_SESSION['acquirer_response']=$message." - Pending";
			$status_completed=false;
			$_SESSION['acquirer_status_code']=1;
		}
        */
    }


}

if(!isset($data['STATUS_ROOT'])){
    include($data['Path'].'/payin/status_bottom'.$data['iex']);
}


?>