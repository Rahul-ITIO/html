<?
$data['PageName']='ORDER DETAILS';
$data['PageFile']='process';
$data['HideMenu']=true;
$data['NO_SALT']=true;
$data['SponsorDomain']=true;
include('config.do');
$tr_id='9999';
if(isset($_REQUEST['b'])){
	$tr_id=$_REQUEST['b'];
}
$bearId=encode_f($tr_id);
echo "bearId=>".$bearId;
?>