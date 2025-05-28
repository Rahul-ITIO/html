<?
$data['PageName']	= 'Payout Detail';
$data['PageFile']	= 'payoutdetail';

###############################################################################
include('../config.do');
$data['PageTitle'] = 'Payout Detail / Status - '.$data['domain_name']; 
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
	if(!isset($post['transaction_id'])||!$post['transaction_id']){
		$data['Error']='Transaction Id should not be empty.';
	}elseif(!isset($post['order_number'])||!$post['order_number']){
		$data['Error']='Order Number should not be empty.';
	}elseif(!isset($post['secret_word'])||!$post['secret_word']){
		$data['Error']='Secret Word should not be empty.';
	}else{

		$gateway_url	= $data['Host']."/payout/payoutdetail".$data['ex'];
	
		$secret_key		= $post['apikey'];
		$payout_token	= $post['payout_token'];
	
		$protocol	= isset($_SERVER["HTTPS"])?'https://':'http://';
		$referer	= $protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
	
		##########
		$pramPost=array();

		$pramPost["payout_token"]=$payout_token; 

		#################################################

		$pramPost['client_ip']	=(isset($_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
		$pramPost['action']		='paymentdetail';
		$pramPost['source']		='Payout-Encode';
		$pramPost['source_url']	=$referer;

		$pramPost["payout_secret_key"]	= $post['secret_word'];

		$pramPost['transaction_id']	= $post['transaction_id'];

		$pramPost['order_number']	= $post['order_number'];

		$get_string=http_build_query($pramPost);


		###########
		if($get_string){
			$encrypted = data_encode_sha256($get_string,$secret_key,$payout_token);
			if($encrypted){
				$send_arr['pram_encode']=$encrypted.$payout_token;

				$fund_json	= use_curl($gateway_url,$send_arr);
				$fund_arr	= json_decode($fund_json,1);
				//echo $fund_json;
	//			print_r($fund_arr);exit;
				if($fund_arr['status']=='0000'){
					print_r($fund_arr);exit;
				}
				else{
					$_SESSION['Error'] = $fund_arr['status'].' - '.$fund_arr['reason'];
				}
			}
		}
		header("Location:{$data['Host']}/user/payoutstatus{$data['ex']}");exit;
	}
}

###############################################################################
display('user');
###############################################################################
?>