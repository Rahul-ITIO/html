<?include('transCallbacks.do');

	//$_SESSION['integration-type']="s2s_cUrl";
	
	if(isset($_POST['transID'])&&$_POST['transID']&&empty($return_response_arr['transID'])){
		$return_response_arr['transID']=$_POST['transID'];
	}
	
	if(isset($scrubbedstatus)&&$scrubbedstatus==true){$return_response_arr['response']=$scrubbed['scrubbed_msg'];}

	
		$json_info_post['info']=array();
			
			if((isset($_GET))&&$_GET){
				$json_info_post['info']=array_merge($json_info_post['info'],$_GET);
			}
			if((isset($_POST))&&$_POST){
				$json_info_post['info']=array_merge($json_info_post['info'],$_POST);
			}
			
		//echo $arrayEncoded3 = json_encode($jsonarray,JSON_FORCE_OBJECT);
		
		if(isset($json_info_post['info'])){
			if(isset($json_info_post['info']['ccno'])) unset($json_info_post['info']['ccno']);
			if(isset($json_info_post['info']['ccvv'])) unset($json_info_post['info']['ccvv']);
			if(isset($json_info_post['info']['clients'])) unset($json_info_post['info']['clients']);
			if(isset($json_info_post['info']['bid'])) unset($json_info_post['info']['bid']);
			if(isset($json_info_post['info']['product'])) unset($json_info_post['info']['product']);
			if(isset($json_info_post['info']['action']))unset($json_info_post['info']['action']);
			//unset($json_info_post['info']['accountid']);
			if(isset($json_info_post['info']['cardsend'])) unset($json_info_post['info']['cardsend']);
			if(isset($json_info_post['info']['integration-type'])) unset($json_info_post['info']['integration-type']);
			if(isset($json_info_post['info']['month'])) unset($json_info_post['info']['month']);
			if(isset($json_info_post['info']['year'])) unset($json_info_post['info']['year']);
			if(isset($json_info_post['info']['encrypted_payload'])) unset($json_info_post['info']['encrypted_payload']);
			if(isset($json_info_post['info']['generated_secret_key'])) unset($json_info_post['info']['generated_secret_key']);
			if(isset($json_info_post['info']['generate_private_key'])) unset($json_info_post['info']['generate_private_key']);
			if(isset($json_info_post['info']['source_url'])) unset($json_info_post['info']['source_url']);
		}

		
		$jsonarray_all=[];
		
		if(isset($return_response_arr)&&$return_response_arr&&is_array($return_response_arr)){
			$jsonarray_all=array_merge($jsonarray_all, $return_response_arr);
		}
		
		if(isset($json_info_post)&&$json_info_post&&is_array($json_info_post)){
			$jsonarray_all=array_merge($jsonarray_all, $json_info_post);
		}
		
				
		
		if(isset($jsonarray_all['authdata']['bank_process_url'])) unset($jsonarray_all['authdata']['bank_process_url']);
		
		if(isset($jsonarray_all['authdata']['payaddress'])&&$jsonarray_all['authdata']['payaddress']){ 
			$jsonarray_all['authdata']['payaddress']=urldecodef($jsonarray_all['authdata']['payaddress'],1);
		}
		
		
		//$jsonarray_all=$jsonarray_all;
		
$arrayEncoded2 = json_encode($jsonarray_all,JSON_UNESCAPED_UNICODE);

$arrayEncoded2=urldecodef($arrayEncoded2);



//Dev Tech: 23-09-113  ['authdata']['payaddress'] for replace space into + and remove the new line and tab
$jsonarray_all = json_decode($arrayEncoded2,1);
if(isset($jsonarray_all['authdata']['payaddress'])&&$jsonarray_all['authdata']['payaddress']){ 
	$jsonarray_all['authdata']['payaddress']=replace_space_tab_br_for_intent_deeplink($jsonarray_all['authdata']['payaddress']);
}
$arrayEncoded2 = json_encode($jsonarray_all,JSON_UNESCAPED_UNICODE);	
	


db_disconnect();
	
	
//remove tab and new line from json encode value 
$arrayEncoded2 = preg_replace('~[\r\n\t]+~', '', $arrayEncoded2);
		
$arrayEncoded2=stripslashes($arrayEncoded2); $arrayEncoded2=str_replace(array('"{','}"'),array('{','}'),$arrayEncoded2);
			
//header("Content-Type: application/json", true);
header('Content-type:application/json;charset=utf-8');
echo $arrayEncoded2;exit;?>