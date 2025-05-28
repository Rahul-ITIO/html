<? if(isset($data['ScriptLoaded'])){?>

<div class="row vkg">
<h4 class="my-4 ps-4"><i class="fa-solid fa-circle-info text-danger fa-fw"></i> JSON Log History - <?=ucwords(str_replace("_"," ",$_REQUEST['tablename']));?> </h4>
<? foreach($post['result_list'] as $key=>$value) { ?>
<div class="col-sm-12 text-center ps-4"><? echo json_log_popup($value['json_log_history']);?></div>
<? } ?>
</div>



<? }else{?>
	SECURITY ALERT: Access Denied
<? }?>