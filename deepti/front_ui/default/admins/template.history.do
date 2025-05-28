<? if(isset($data['ScriptLoaded'])){ 

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>IP History For Merchant</title>
</head>
<body>
<div class="container my-2 bg-primary text-white border rounded">
<h5 class="my-2">IP History - <?=$data['utitle'];?></h5>
<style>
@media (min-width: 650px)
.modal-dialog {
    max-width: 600px !important;
}
</style>
<!--Time Stamp, Login IP, Merchant User name, Admin User name, Source Destination-->

<table class="table bg-primary text-white">
<tr>
    <td>Timestamp</td>
    <td>Login IP</td>
	<td title="Merchant User name">Merchant</td>
	<? if($data['utype']!=1){ ?>
    <td title="Admin User name">Admin</td>
	<td>Source URL</td>
	<? } ?>
  </tr>
  <? foreach($post['History'] as $key=>$value){
  $bgcolor=$key%2?'#EEEEEE':'#E7E7E7';
  if($value['subadmin_id']!=1){
  $g_result=select_tablef('id='.$value['subadmin_id'],$tbl='subadmin',$prnt=0,$limit='',$select='username');
  $subadmin_uname=$g_result[0]['username']; 
  }else{
  $subadmin_uname="Admin"; 
  }
  ?>
  <tr>
    <td><?=prndate($value['date'])?></td>
    <td><?=$value['address']?></td>
	<td><span title="<?=$value['clients']?>">
	<?=$data['utitle']?>
	</span></td>
	<? if($data['utype']!=1){ ?>
    <td><span title="<?=$value['subadmin_id']?>"><?=$subadmin_uname;?></span></td>
	<td><span class="d-inline-block text-truncate" style="max-width: 150px;" title="<?=$value['source_url']?>" data-bs-toggle="tooltip" data-bs-placement="top"><?=$value['source_url']?></span></td>
	<? } ?>
  </tr>
  <? } ?>
</table>


</div>
</body>
</html>
<script>
//$('#myModal .modal-dialog').css("max-width", "800px !important");
//$('.modal-dialog').css({"max-width":"90% !important"});
</script>
<? } else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
