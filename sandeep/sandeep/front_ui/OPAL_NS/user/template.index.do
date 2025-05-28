<? if(isset($data['ScriptLoaded'])){ ?>
<style>
.fa-check.dashboard {
    margin-left: 0px !important;
 }
</style>
<script>
$(document).ready(function(){ 
	$(".document_type").change(function(){
		document_typef(this,$(this).val());
	});
});	
</script>
<? if(strpos($data['themeName'],'LeftPanel')!==false){

//if($data['frontUiName']=="") { $data['frontUiName']="quertz"; }

$status_button=("../front_ui/{$data['frontUiName']}/common/template.graph".$data['iex']);
if(file_exists($status_button)){
	include($status_button);
}else{
	$status_button=("../front_ui/default/common/template.graph".$data['iex']);
	if(file_exists($status_button)){
		include($status_button);
	}
}
?>
<? } else{ ?>
<? } ?>



<div class="m-2" id="content">
<? if(strpos($data['themeName'],'LeftPanel')!==false){







} else{ ?>


<? } ?>

</div>


<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
