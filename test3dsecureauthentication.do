<?
$data['PageName']='SAMPLE FOR 3D SECURE PAGE';
$data['PageFile']='test3dsecureauthentication';
$data['HideAllMenu']=true;
$data['NO_SALT']=true;
//$data['SponsorDomain']=1;
include('config.do');
$data['PageTitle']='Sample for 3d Secure Page'; 

if(isset($_GET['success'])||isset($_GET['failed'])){
	
	if(isset($_GET['success'])&&($_GET['success']=='success')){
		header("Location:{$data['Host']}/return_url{$data['ex']}?transID={$_GET['transID']}");
	}elseif(isset($_GET['failed'])&&($_GET['failed']=='failed')){
		header("Location:{$data['Host']}/return_url{$data['ex']}?transID={$_GET['transID']}&actioncheck=failed");
	}
	
	//echo "<hr/>_GET=>"; print_r($_GET);

}
if(isset($_POST['success'])||isset($_POST['failed'])){
	//echo "<hr/>_POST=>"; print_r($_GET);

}


display('user');
?>
