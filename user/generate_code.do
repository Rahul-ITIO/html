<?
$data['PageName']='HTML CODE FOR BUTTON';
$data['PageFile']='generate_code';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'My Buttons - '.$data['domain_name'];
###############################################################################
if (!isset($_SESSION['adm_login']) && !isset($_SESSION ['login'])) {
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(isset($_REQUEST['downloadHtml'])&&$_REQUEST['downloadHtml']){
	
	$terNO=$_REQUEST['terNO'];
	$fileName = $data['SiteName']."_generate_code_{$terNO}.html";
	//echo '<br/>fileName=>'.$fileName;exit;
	header('Content-Encoding: UTF-8');
	header('Content-Disposition: attachment; filename='.$fileName);
	echo $_REQUEST['downloadHtml'];
	//print_r($_REQUEST);
	exit;

}


$is_admin=false;
if(isset($_SESSION['adm_login'])&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;
	$uid=$post['bid'];
	$_SESSION['login']=$uid;
}

//$minfo = get_clients_info($uid);

$post['is_admin']=$is_admin;

if(is_info_empty($uid)){
	$get_q='';if(isset($_GET)){$get_q="?".http_build_query($_GET);}
	header("Location:{$data['Host']}/user/profile{$data['ex']}{$get_q}");
	echo('ACCESS DENIED.');
	exit;
}

$post=select_info($uid, $post);

$data['InfoIsEmpty']=is_info_empty($uid);
$domain_name=$data['domain_name'];
###############################################################################


$data['processall_url']='checkout';

$data['api_url']="directapi";
$data['processall_url']="checkout";
$API_VER=1;

$target="";
$onclick="";


$post['addressParam']=1;


if(isset($data['con_name'])&&$data['con_name']=='clk'){
	$post['addressParam']=0;
	
	//$data['processall_url']='payment';
	
	$p_add1="A97B North Block"; $p_add2="Connaught Place"; 
	$p_cty="New Delhi";
	$p_stat="Delhi";
	$p_cntr="IND";
	
	$p_zip="110001";
	$p_phone="932211664488";
	
}else {
	$p_add1="25A Alpha"; $p_add2="tagore lane"; 
	$p_cty="Jurong";
	$p_stat="SG";
	$p_cntr="SG";
	
	$p_zip="444444";
	$p_phone="+655555555555";
}

//echo "API_VER=>".$API_VER;

###############################################################################
$paths=array(0=>$data['SinBtns'],1=>$data['SubBtns'],2=>$data['DonBtns']);
if((isset($post['gid'])&&$post['gid'])||(isset($post['send'])&&$post['send'])){

if(isset($post['send'])&&$post['send']){
	$post['gid']=$_REQUEST['terNO'];
}else{
	$post['email']="";
}

//echo "<br/>gid=>".$post['gid'];exit;
//print_r($_POST);
	
	
	$product_result=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}terminal` WHERE `id`={$post['gid']} LIMIT 1",0
	);
	$product_q=$product_result[0];
	
	/*
	print_r($post);
	echo "<br/>email=>".($post['email']);
	echo "<br/>id=>".($product_q['id']);
	echo "<br/>name=>".($product_q['name']);
	echo "<br/><hr/><br/>product_q=>";print_r($product_q);
	*/
	
	$post['bussiness_url']=$product_q['bussiness_url'];
	$dba_brand_name=$product_q['dba_brand_name'];
	if($product_q['return_url']){
		$post['return_url']=$product_q['return_url'];
	}else{
		$post['return_url']="https://google.com?action=return";
	}
	if($product_q['webhook_url']){
		$post['webhook_url']=$product_q['webhook_url'];
	}else{
		$post['webhook_url']="https://google.com?action=webhook";
	}
	
	
	
	$post['acquirerIDs']=$product_q['acquirerIDs'];
	$acquirerIDs=explode(',',$post['acquirerIDs']);
	
	
	
	$post['public_key']=$product_q['public_key'];
	$post['terNO']=$_REQUEST['terNO']=$product_q['id'];
	
	$mywebsiteNm=($data['MYWEBSITE']?''.$data['MYWEBSITE']:'Business');
	
	//Dev Tech : 25-01-30 Generate Code Include wise  
	include("generate_code_include".$data['iex']);

	//$post['phpCurlCode']=htmlspecialchars($post['phpCurlCode'], ENT_QUOTES);
	
	
	
	$post['BackPage']=$post['action'];
}
###############################################################################
display('user');
###############################################################################
?>
