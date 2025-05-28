<?
$config_root='../config.do';
if(file_exists($config_root)){require_once($config_root);}
$data['PageName']='Scan of QR Code ...';
$data['PageFile']='chart';
$data['HideMenu']=true;
$data['HideAllMenu']=true;
$data['SponsorDomain']=1;



// hardcoaded for delete
$_SESSION['3ds2_auth']['payaddress']="upi://pay?pa=skywalkletspe.lp@icici&pn=1013121&tr=mno2218627&cu=INR&mc=5411";
$_SESSION['3ds2_auth']['payamt']="2.01";
$_SESSION['3ds2_auth']['amount']="2";
$_SESSION['3ds2_auth']['currency']="USD";
//======================


$data['Host2']=$data['Host'];
	/*
	if(isset($_SESSION['3ds2_auth']['bank_process_url']))
	{
		$data['Host']=$_SESSION['3ds2_auth']['bank_process_url'];
	}else{
		//$data['Host'];
	}
	*/
	if(isset($_SESSION['3ds2_auth']['processed'])&&$_SESSION['3ds2_auth']['processed'])
		$data['processed']=$_SESSION['3ds2_auth']['processed'];
	else
		$data['processed']=$data['Host']."/payin/34/processed_url.do?transID={$_GET['transID']}&orderId={$_GET['orderId']}&action=processed";
	
	if(isset($_SESSION['3ds2_auth']['paytitle'])&&$_SESSION['3ds2_auth']['paytitle']){
		$data['paytitle']=$_SESSION['3ds2_auth']['paytitle'];
	}else{
		$data['paytitle']='Bitcoin';
	}
	
	if(isset($_SESSION['3ds2_auth']['currname'])&&$_SESSION['3ds2_auth']['currname']){
		$data['currname']=$_SESSION['3ds2_auth']['currname'];
	}else{
		$data['currname']='BTC';
	}
	


display('user');exit;	
?>
