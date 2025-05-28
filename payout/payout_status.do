<?
$data['HideMenu']=true;
$data['HideAllMenu']=1;
$data['NO_SALT']=1;
$data['STATUS_ROOT']=1;

$data['PageName']='PAYOUT STATUS';
$data['PageFile']='payouttatus';
//$data['notRootCss']=true;
$data['PageTitle']='Payout Status Processing...'; 

//include('config.do');
include('../config_db.do');
include('status_top'.$data['iex']);

if(isset($json_value['default_mid'])&&$json_value['default_mid']) $default_mid=$json_value['default_mid'];

if(!isset($default_mid) || empty($default_mid)) $default_mid = $td['pay_type'];

if(isset($json_value['status_path'])&&$json_value['status_path']){ $payout_dir=$json_value['status_path'];}
else{$payout_dir='p'.$default_mid; }

$filePath=$data['Path'].'/payout/'.$payout_dir."/status_".$default_mid.$data['iex'];

if($qp){
	echo "<hr>filePath=><br />";
	echo $filePath;
}

if(file_exists($filePath)){
	include($filePath);
}


include('status_bottom'.$data['iex']);

//display('user');
//showpage("user/template.bank3dstep2".$data['iex']);exit;
?>
