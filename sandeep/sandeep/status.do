<?
$data['HideMenu']=true;
$data['HideAllMenu']=1;
$data['NO_SALT']=1;
$data['STATUS_ROOT']=1;

$data['PageName']='BANK STATUS';
$data['PageFile']='status';
//$data['notRootCss']=true;
$data['PageTitle']='Bank Status Processing...'; 

//include('config.do');
include('config_db.do');
include('payin/status_top'.$data['iex']);

if(isset($json_value['default_mid'])&&$json_value['default_mid']) $default_mid=$json_value['default_mid'];

if(!isset($default_mid) || empty($default_mid)) $default_mid = @$td['acquirer'];
/*
if(@$td['acquirer']==15 || @$td['acquirer']==16){
	//$default_mid=15;
}
*/
if(isset($json_value['status_path'])&&$json_value['status_path']){ $status_path=$json_value['status_path'];}
else{$status_path='payin/pay'.$default_mid; }

$filePath=$status_path."/status_".$default_mid.$data['iex'];

if($qp){
	echo "<hr>filePath=><br />";
	echo $filePath;
}

if(file_exists($filePath)){
	include($filePath);
}


include($data['Path'].'/payin/status_bottom'.$data['iex']);

//display('user');
//showpage("user/template.bank3dstep2".$data['iex']);exit;
?>
