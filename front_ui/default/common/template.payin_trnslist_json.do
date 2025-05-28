<?
if(!isset($_SESSION['login'])){
	echo('ACCESS DENIED.'); exit;
}

$data['TEMPATH_2']=$data['TEMPATH'];
$theme_path=$data['TEMPATH'].'/common/css/chosen/chosen.jquery.min.js';
if(!file_exists($theme_path)){
	$data['TEMPATH_2']=$data['Host'].'/front_ui/default';
}
?>
	
<?// Dev Tech : 23-06-10 start - payin transaction list view for client as per assing by admin or default ?>	

<!--Chosen Script for advance search and multi select dropdown-->
<script src="<?=$data['TEMPATH_2']?>/common/css/chosen/chosen.jquery.min.js"></script>
<link href="<?=$data['TEMPATH_2']?>/common/css/chosen/chosen.min.css" rel="stylesheet"/>
<style>
.container {position:relative;}

.bd-blue-100 {color:#000;background-color:#cfe2ff;}

<?php if($data['themeName']!='LeftPanel'){ ?>
#payin_transaction_display_divid {position:absolute;width:84%;float:right;z-index:999;right:2.5%;border-radius:3px;padding:10px;/*top:30px;*/left:0;}
<? } else { ?>
#payin_transaction_display_divid {position:absolute;width:100%;float:right;z-index:999;right:2.5%;border-radius:3px;padding:10px;/*top:30px;*/left:0;}
<? } ?>

#payin_transaction_display_divid .chosen-container {width: 100% !important;min-width: 300px !important;}


</style>
<script>
	
function chosen_more_value_f(theId,arrVal,matchCon='yes'){
	var getArr = [];
	var conArrVal = [];
	var matchAry = [];
	var appendOption = '';

	getArr = $("#"+theId+" option").map((_,e) => e.value).get();
	conArrVal = arrVal;
	//alert(conArrVal);
	for(var i = 0; i < conArrVal.length; i++)
	{
		if(conArrVal[i]){
			//alert(conArrVal[i]);
			if ( $.inArray(conArrVal[i], getArr ) > -1 ) { // match
				matchAry.push(conArrVal[i]);
				//alert(conArrVal[i]); 
			}else{ // not match
				//alert(conArrVal[i]);
				appendOption += '<option value="'+conArrVal[i]+'" selected>'+conArrVal[i]+'</option>';
			}
		}
	}
	if(matchCon=='yes'){
		$("#"+theId).val(matchAry).trigger("change").trigger("chosen:updated");
	}
	$("#"+theId).append(appendOption).trigger("change").trigger("chosen:updated");
	//alert(matchAry);
}	
function chosen_no_resultsf(e,theId){
	var spanVar=$(e).find('span').text();
	//if(theId==='search_key_text'){
	
		//alert(spanVar);
		
		$("#"+theId).append('<option value="'+spanVar+'" selected>'+spanVar+'</option>').trigger("change"); 
		$("#"+theId).trigger("chosen:updated");
		
		if($("#"+theId+"_hdn").hasClass('hide')){
			$("#"+theId+"_hdn").append('<option value="'+spanVar+'" selected>'+spanVar+'</option>').trigger("change"); 
		}
		
	//}
}
function chosen_search_closef(e,theId){
	var spanVar=$(e).prev('span').text();
	spanVar=spanVar.replace(/\s/g, "");
	if($("#"+theId+"_hdn").hasClass('hide')){
		$("#"+theId+"_hdn").find('option:contains('+spanVar+')', this).remove(); 
	}
	//alert(spanVar);
}

</script>


<div class="float-start">
	
		
		<a title="Payin Transaction Display Option" data-bs-toggle="tooltip" data-bs-placement="right" class="btn btn-primary btn-sm" onClick="view_next3(this,'')" style="border:0;margin:-2px 5px;" ><i class="<?=$data['fwicon']['transaction-display-option'];?>"></i></a>
	 
		<? 
			//print_r($post['sort_trans_display_json']);
			if($post['sort_trans_display_json']){
				
				$assign_trans_display_json_de=jsondecode($post['sort_trans_display_json'],1,1);
				
				$post['assign_trans_display_json_arr']=@$assign_trans_display_json_de['payin_transaction_display'];
				
			}
			else if($post['assign_trans_display_json']){
				
				$assign_trans_display_json_de=jsondecode($post['assign_trans_display_json'],1,1);
				
				$post['assign_trans_display_json_arr']=@$assign_trans_display_json_de['payin_transaction_display'];
				
			}
			else
			{
				$post['assign_trans_display_json_arr'] = array_keys($data['default_payin_trnslist_listorder']);

			}
			
			//echo "<br/>assign_trans_display_json_arr=>";print_r($post['assign_trans_display_json_arr']);

			
			$post['payin_transaction_display_val']='"'.implodes('","',($post['assign_trans_display_json_arr'])).'"';
				
			//echo "<br/>payin_transaction_display_val=>";print_r($post['payin_transaction_display_val']);
		?>

<?
#######		Dev Tech : 23-06-12 Fetch from assign of Admin	#########		
if($post['assign_trans_display_json']){
				
	$assign_trans_display_json_de=jsondecode($post['assign_trans_display_json'],1,1);
	
	$post['assign_payin_trnslist_listorder_arr']=@$assign_trans_display_json_de['payin_transaction_display'];
}
else
{
	$post['assign_payin_trnslist_listorder_arr'] = array_keys($data['default_payin_trnslist_listorder']);

}
			
$a1=($post['assign_payin_trnslist_listorder_arr']);
$a2=$post['assign_trans_display_json_arr'];

$other_trnslist_listorder=array_diff($a1,$a2);

//echo "<br/>other_trnslist_listorder=>";print_r($other_trnslist_listorder);

?>
		<div id="payin_transaction_display_divid" class="hide bd-blue-100" style="float:right;right:0;">
		  <select id="payin_transaction_display" data-placeholder="Payin Transaction Display Option" title="Payin Transaction Display Option" multiple class="chosen-select chosen-rtl1 form-select" name="payin_transaction_display[]">
				<? 
				$post['assign_payin_trnslist']=[];
				foreach($post['assign_payin_trnslist_listorder_arr'] as $val){ ?>
					<? 			
					if(in_array($val,$post['assign_trans_display_json_arr']))
					{
						$post['assign_payin_trnslist'][$val]=@$data['payin_trnslist_listorder'][$val];
					?>
					<option value="<?=$val;?>" data-placeholder="<?=$val;?>" title="<?=@$data['payin_trnslist_listorder'][$val];?>"><?=@$data['payin_trnslist_listorder'][$val];?></option>
					<? } ?>
				<? } ?>
				<? foreach($other_trnslist_listorder as $val){ ?>
					<option value="<?=$val;?>" data-placeholder="<?=$val;?>" title="<?=@$data['payin_trnslist_listorder'][$val];?>"><?=@$data['payin_trnslist_listorder'][$val];?></option>
				<? } ?>
		  </select>
		  
		  <?
		  //echo "<br/>payin_transaction_display_val=>";print_r($post['payin_transaction_display_val']);
		  ?>
		  
		  
		  <script>
			
		  </script>
		  
		  <button class="input_s btn btn-primary btn-sm search multch select my-2" type="button" id="display_select_all" name="select_all" value="Select All" title="Select All" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['square-plus'];?>" ></i></button>
		  <button class="input_s btn btn-primary btn-sm search multch deselect my-2" type="button" id="display_deselect_all" name="deselect_all" value="Deselect All" title="Deselect All" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['square-minus'];?>" ></i></button>
		  <button class="btn btn-primary btn-sm search my-2" type="button" id="update_selected_chosen" title="Update" data-bs-toggle="tooltip" data-bs-placement="top"><i class="<?=$data['fwicon']['submit'];?>" ></i></button>
		  
		  <?if(empty(@$post['sort_trans_display_json'])){ /*?>
		   <span class1="text-warning" style="color: var(--background-1) !important;font-weight:bold;font-style:italic;">Is Default Not assign now </span>
		  
		  <?*/ }?>
		  
<script>
$('.multch').each(function(index) {
	//console.log(index);
	$(this).on('click', function(){
		//console.log($(this).parent().find('option').text());
		$(this).parent().find('option').prop('selected', $(this).hasClass('select')).parent().trigger('chosen:updated');
	});
});
</script>
</div>
		
	  </div>
	  

	<!--	front_ui/default/common/template.payin_trnslist_json.do	-->
	
	<script src="<?=$data['TEMPATH_2']?>/common/js/jquery-ui.min.js"></script>
	
	<script>
	jQuery(document).ready(function ($) {
		$(".chosen-select").chosen({
		  no_results_text: "Oops, nothing found!"
		});	
		
		$("#payin_transaction_display").val([<?=@($post['payin_transaction_display_val']);?>]).trigger("change"); 
			$("#payin_transaction_display").trigger("chosen:updated");
			
			
		$('#update_selected_chosen').click(function(){ 
			var arr = []; 
			$("#payin_transaction_display_chosen span").each(function(){
				var str = $(this).text();
				str = ($.trim(str.replace(/[\t\n]+/g, '')));
				arr.push(str); 
			});
			if(arr.length > 0){
			//salert(arr);
			
			if(wn){
				wnf("<?=$data['Host'];?>/include/update_translist_listing_order<?=$data['ex']?>?"+'clientTransList='+arr);
			}
			//var arr=2;
				$.ajax({
					url: "<?=$data['Host'];?>/include/update_translist_listing_order<?=$data['ex']?>",
					data:'clientTransList='+arr,
					success:function(data){
						//alert(data);
						if(data=="done"){
							//alert("redirect");
							setTimeout(function(){ 
							
							location.reload(true);
							},100); 
						}
					},
					error:function (){}
				});
		
			}
			

			
			
		});
		
		$("#payin_transaction_display_chosen .chosen-choices").sortable({
			revert: true,
			/*update: function (event, ui) {
				// Some code to prevent duplicates
			}*/
		});
		$(".draggable").draggable({
			connectToSortable: '#payin_transaction_display_chosen .chosen-choices',
			cursor: 'pointer',
			helper: 'clone',
			revert: 'invalid'
		});
		
		
	});
	
	
	</script>

</div>

<?// Dev Tech : 23-06-10 end - payin transaction list view for client as per assing by admin or default ?>	