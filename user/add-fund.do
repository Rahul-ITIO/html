<?
$data['PageName']	= 'Add Fund';
$data['PageFile']	= 'add-fund';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'Add Fund - '.$data['domain_name']; 
##########################Check Permission#####################################

if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}


###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['USER_FOLDER']}/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

$post=select_info($uid, $post);
if(!isset($post['step']) || !$post['step'])$post['step']=1;

//$post=select_info($uid, $post);
//print_r($post);

if(!isset($post['step']) || !$post['step'])$post['step']=1;
					
###############################################################################

if(isset($_POST['send'])&&$_POST['send']=='submit_data'){
	if(!isset($post['transaction_amount'])||!$post['transaction_amount']){
		$_SESSION['Error']=' Amount should not be empty.';
	}elseif(!isset($post['sender_name'])||!$post['sender_name']){
		$_SESSION['Error']='Sender name should not be empty.';
	}elseif(!isset($post['remarks'])||!$post['remarks']){
		$_SESSION['Error']='Remarks should not be empty.';
	}elseif(!isset($post['transaction_currency'])||!$post['transaction_currency']){
		$_SESSION['Error']='Currency should not be empty.';
	//}elseif(!isset($post['secret_word'])||!$post['secret_word']){
	//	$data['Error']='Secret Word should not be empty.';
	}else{

		$transaction_id=gen_transID_f();

		$gateway_url	= $data['Host']."/payout/addfund".$data['ex'];
	
		$secret_key		= $post['private_key'];
		$payout_token	= $post['payout_token'];
	
		$protocol	= isset($_SERVER["HTTPS"])?'https://':'http://';
		$referer	= $protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
	
		##########
		$pramPost=array();

		$pramPost["payout_token"]=$payout_token; 

		#################################################

		$pramPost['client_ip']	=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
		$pramPost['action']		='addfund';
		$pramPost['source']		='Payout-Encode';
		$pramPost['source_url']	=$referer;

		$pramPost["payout_secret_key"]	= $post['secret_word'];

		$pramPost['amount']	= $post['transaction_amount'];
		$pramPost['sender_name']	= $post['sender_name'];

		$pramPost['curr']	= $post['transaction_currency'];
		$pramPost['remarks']= $post['remarks'];

		$pramPost['transaction_id']	= create_transaction_id($uid);
//		$pramPost['transaction_id'] = gen_transID_f($newId,$sub_client_id);
		$pramPost['product_name']	= 2;// 2 for ADD FUND

		$get_string=http_build_query($pramPost);

		###########
		if($get_string){
			$encrypted = data_encode_sha256($get_string,$secret_key,$payout_token);
			if($encrypted){
				$send_arr['pram_encode']=$encrypted.$payout_token;
				$fund_json	= use_curl($gateway_url,$send_arr);
				$fund_arr	= json_decode($fund_json,1);

				//print_r($fund_arr);exit;
			
				/*if($fund_arr['status']=='0004'){
					$_SESSION['Error'] = 'ACCESS DENIED!! Secret Word not match';
				}
				*/
				if($fund_arr['status']=='0000'){
					$_SESSION['action_success']=get_currency($pramPost['curr']).number_format($pramPost['amount'])." added successfully!";
				}
				elseif($fund_arr['status']=='0002'){
					$_SESSION['Error'] = 'Fail';
				}
			}
		}
	}

    $_SESSION['action_success']="Fund Added Successfully!";
	if(isset($_REQUEST['pdisplay'])&&$_REQUEST['pdisplay']){
		header("Location:{$data['Host']}/user/fund-sources{$data['ex']}");exit;
	}else{
		header("Location:{$data['Host']}/user/add-fund{$data['ex']}");exit;
	}
}

###############################################################################
if(isset($_REQUEST['pdisplay'])&&$_REQUEST['pdisplay']){
	showpage("user/template.add-fund".$data['iex']);exit;
}else{
	display('user');
}
###############################################################################
?>