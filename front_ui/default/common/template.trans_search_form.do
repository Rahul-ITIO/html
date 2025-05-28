<??>
<!-- Transaction Search Bar -->
<?/*?>
<script src="<?=$data['TEMPATH']?>/common/css/chosen/chosen.jquery.min.js"></script>

<link href="<?=$data['TEMPATH']?>/common/css/chosen/chosen.min.css" rel="stylesheet" />

<?*/?>

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

<style>
	.input-icons .fa-solid.cals {
		position: absolute;
		padding-top: 8px;
		padding-left: 3px;
		font-size: 23px;
		z-index: 1;
	}

	.input-icons {
		/* margin-bottom: 10px;*/
	}

	.input-field_X {
		width: 100%;
		padding: 10px;
		text-align: center;
	}
</style>

<? if(!isset($post['SearchResult'])||empty(($post['SearchResult']))){ 
  if(isset($data['tr_count'])&&$data['tr_count']==0){ $data['result_count']=0; }
  if(isset($_SESSION['query_post_pg']['page'])&&$_SESSION['query_post_pg']['page']==""){$_SESSION['query_post_pg']['page']=1;}
  ?>
<div class="col-sm-12 bg-primary border_X rounded mb-2" id="s_box">

	<div class="widget-cl2 msearch_1 advSdiv mx-3">
		<form>
			<div class="row g-0" style="position:relative;top:4px;">
				<input type="hidden" name="action" value="select" />

				<?//="is_created_date_on=>".isset($_REQUEST['is_created_date_on'])?prntext($_REQUEST['is_created_date_on']):""?>

				<input type="hidden" name="is_created_date_on" id="is_created_date_on" class="hide"
					style="display:none !important;"
					value="<?=isset($_REQUEST['is_created_date_on'])?prntext($_REQUEST['is_created_date_on']):""?>">

				<div class="col-sm-2">
					<div class="input-field w-100">
						<select name="records_per_page" id="records_per_page" title="Select No. Of Records Display"
							class="filter_option form-select form-control form-control-sm bg-primary text-white w-100"
							autocomplete="off">
							<option value="" selected="selected"> <?=$data['MaxRowsByPage'];?> of Page
								<?=$_SESSION['query_post_pg']['page'];?> </option>
							<option value="25">1-25</option>
							<option value="50">1-50</option>
							<option value="100">1-100</option>
							<option value="200">1-200</option>

						</select>
						<label for="records_per_page">No. of Record / Page</label>
					</div>
				</div>

				<div class="col-sm-3">
					<div class="input-field w-100">
						<input type="text" name="searchkey" id="searchkey"
							class="searchkey_adv form-control form-control-sm bg-primary text-white w-100"
							placeholder="Search.." value='<?=@$post['searchkey']?>'>
						<label for="searchkey">Key Value</label>
					</div>
				</div>

				<div class="col-sm-2">
					<div class="input-field w-100">
						<select name="key_name" id="searchkeyname" title="Select key name"
							class="filter_option s_key_name form-control form-control-sm bg-primary text-white w-100"
							autocomplete="off">
							<option value="" selected="selected">Select</option>
							<option value="transID" data-placeholder="TransID" title="TransID">TransID</option>
							<option value="reference" data-placeholder="Reference" title="Reference">Reference
							</option>
							<option value="rrn" data-placeholder="RRN" title="RRN">RRN</option>
							<option value="upa" data-placeholder="UPA" title="UPA">UPA</option>
							<option value="fullname" data-holder="Customer Name" title="Full Name">Full Name
							</option>
							<option value="bill_amt" data-holder="Bill Amount" title="Bill Amount">Bill Amount
							</option>
							<option value="mop" data-holder="MOP" title="MOP">MOP</option>
							<option value="terNO" data-holder="terNO" title="terNO">terNO</option>
							<option value="trans_response" data-holder="Trans Response" title="Trans Response">Trans
								Response</option>
							<option value="trans_status" data-holder="Trans Status" title="Trans Status">Trans
								Status</option>
							<option value="bill_ip" data-holder="Bill IP" title="IP">Bill IP</option>
							<option value="bill_email" data-holder="Bill Email" title="Bill Email">Bill Email
							</option>
							<option value="bill_phone" data-holder="Bill Phone" title="Bill Phone">Bill Phone
							</option>
							<option value="product_name" data-holder="Product Name" title="Product Name">Product
								Name</option>
							<option value="bill_country" data-holder="Bill Country" title="Bill Country">Bill
								Country</option>
							<option value="bill_zip" data-holder="Bill Zip" title="Bill Zip">Bill Zip</option>
							<option value="descriptor" data-holder="Descriptor" title="Descriptor">Descriptor
							</option>
							<option value="created_date" data-holder="Created Date" title="Created Date">Created
								Date</option>
						</select>
						<label for="searchkeyname">Key Name</label>
					</div>
				</div>

				<div class="col-sm-2">
					<div class="input-field w-100">
						<select name="status" id="status_csearch"
							class="form-control form-control-sm bg-primary text-white">
							<option value="-1" selected="selected">All Status</option>
							<? foreach($data['TransactionStatus'] as $key=>$value){ ?>
							<option value="<?=$key;?>">
								<?=$value;?>
							</option>
							<? } ?>
						</select>
						<label for="status_csearch">Trans Status</label>
					</div>
				</div>

				<!-- use common script for date range - start 	-->

				<div class="col-sm-2 mb-1 input-icons " style="position:relative;z-index:999;">
					<div class="input-field w-100">
						<style>
							#payin_transaction_display_divid {z-index:9999;}
							.input-field {position:relative;margin-top:0px;width:100%;padding:0px 3px;}

							.input-field input:focus+label,
							.input-field input:valid+label,
							.input-field select:focus+label,
							.input-field select:valid+label,
							.input-field textarea:focus+label,
							.input-field textarea:valid+label,
							.input-field input:disabled+label,
							.input-field select:disabled+label {
								position: absolute;
								z-index: 999;
								top: -9px;
								left: 6px;
								font-size: 10px;
								padding: 0px 4px;
								background-color: var(--bs-body-bg) !important;
								color: var(--bs-body-color) !important;
								font-weight: 500 !important;
							}

							.input-field label {
								position: absolute;
								top: 5px;
								left: 6px;
								transition: all 0.5s;
								padding: 0px 10px;
							}

							#label_date_range {
								font-size: 10px;
								white-space: nowrap;
								position: relative;
							}
						</style>
						<?php
// for search with range and double calender
//$cal_search_script=($data['Path']."/front_ui/{$data['frontUiName']}/common/template.cal".$data['iex']);
$cal_search_script_def=($data['Path']."/front_ui/default/common/template.cal".$data['iex']);
if(isset($cal_search_script)&&file_exists($cal_search_script)){
	include($cal_search_script);
}elseif(isset($cal_search_script_def)&&file_exists($cal_search_script_def)){
	include($cal_search_script_def);
}
?>

						<? 
if(isset($_REQUEST['date_range'])){ 
	//$date_range_echo= $_REQUEST['date_range'];
}

?>

						<input type="text" name="date_range2" class="form-control form-control-sm bg-primary text-white"
							id="date_range" placeholder="Custom Date Range"
							value="<? if(isset($_REQUEST['date_range2'])) echo $_REQUEST['date_range2'];?>"
							style="width:127% !important;" required />

						<label for="date_range" style="white-space: nowrap;"><i
								class="<?=$data['fwicon']['calender'];?> cals fs-2x text-link float-start"
								style="font-size: 11px;z-index:0;float: left !important;position: relative;margin: -5px 2px 0 0;"></i>
							<font id="label_date_range_first">
							<?=(isset($_REQUEST['is_created_date_on'])&&trim($_REQUEST['is_created_date_on'])?'Created Timestamp':'Updated Timestamp')?>: </font> <i id="label_date_range"><?=@$_REQUEST['date_label'];?> </i>
						</label>

						<input type="hidden" class="form-control" name="date_1st" id="date_1st" />
						<input type="hidden" class="form-control" name="date_2nd" id="date_2nd" />
						<input type="hidden" class="form-control" name="date_label" id="date_label" />

					</div>
				</div>
				<!-- use common script for date range - end 	-->

				<div class="col-sm-1 pt-0 text-end ">
					<button type="submit" name="csearch" value="filter" class="adv_search btn btn-primary mt-0"
						style="margin-top:-3px !important;"><i class="fas fa-search"></i></button>
				</div>

			</div>
		</form>
	</div>

	<? if(isset($_GET['status'])){?>
	<script>
		$('#status_csearch option[value="<?=$_GET['
			status '];?>"]').prop('selected', 'selected');
	</script>
	<? } ?>
</div>

<!--///////////////////////-->

<div>

	<? 
	
if(isset($data['NameOfFile']) && ((isset($post['settlement_optimizer'])&&trim($post['settlement_optimizer'])&&$post['settlement_optimizer']=='manually')||(isset($_SESSION['settlement_optimizer'])&&(strtolower($_SESSION['settlement_optimizer'])=='custom'||strtolower($_SESSION['settlement_optimizer'])=='weekly')&&isset($data['CUSTOM_SETTLEMENT_WD_V3_IN_MER'])&&$data['CUSTOM_SETTLEMENT_WD_V3_IN_MER']=='Y'))){
	?>
	<? if($data['withdraw_gmfa'])
		 { 
			if(isset($_SESSION['settlement_optimizer'])&&strtolower($_SESSION['settlement_optimizer'])=='custom'&&isset($data['CUSTOM_SETTLEMENT_WD_V3_IN_MER'])&&$data['CUSTOM_SETTLEMENT_WD_V3_IN_MER']=='Y')
			{
              $trans_withdraw_url='trans_withdraw-fund_v3_custom_settlement';
            }
            elseif(isset($data['WITHDRAW_INITIATE_SYSTEM_WV2'])&&$data['WITHDRAW_INITIATE_SYSTEM_WV2']=='Y'&&@$_REQUEST['a']!='o')
            {
              $trans_withdraw_url='trans_withdraw-fund_system_v2';
            }
            else $trans_withdraw_url='trans_withdraw-fund';
            
	?>
	<a href="<?=$data['USER_FOLDER']?>/<?=$data['FileName']?>?balance_check=re_check"
		class="settle_withdraw btn btn-primary my-1 text-white btn-sm float-end ms-2" 
		title="Refresh for Account Balance">Refresh</a>

	<a href="<?=$data['USER_FOLDER']?>/<?=@$trans_withdraw_url?><?=$data['ex']?>"
		onClick="javascript:$('#modalpopup_form_popup').show(200);"
		class="settle_withdraw btn btn-primary my-1 text-white btn-sm float-end" style=""
		title="Withdraw Fund">Withdraw</a>
	<? }else{ ?>
	<a onClick="confirm_2mfa('You are required to Activate 2 Factor Authentication (2FA) to access the withdrawal section. Click on OK button to setup 2 Factor Authontication (2FA) now.','<?=$data['USER_FOLDER']?>/two-factor-authentication<?=$data['ex']?>');"
		class="settle_withdraw2 btn btn-primary btn-sm text-white my-1"
		style="background-color: #00b517 !important;color:#fff!important;float:right;display:inline-block;margin:2px 10px 0 0;"
		title="Withdraw Fund">Withdraw</a>
	<? } ?>
	<? }?>

	<div class="clearfix"></div>
</div>

<!--///////////////////////-->

</div>
<script>
	function time_periodf(theValue) {
		if (theValue == '') {
			//alert("wrong Data");
		} else if (theValue == '1') { //WEEK
			var drange1 = '<?=date("Y-m-d 00:00:00",strtotime(' - 6 days '))?>';
			var drange2 = '<?=date("Y-m-d 23:59:59")?>';
			var drange = drange1 + ' to ' + drange2;
			$('#date_range').val(drange);
			$('#date_1st').val(drange1);
			$('#date_2nd').val(drange2);
			$('.cal_box').hide();
			$('#date_range').val('');
		} else if (theValue == '2') { //MONTH
			var drange1 = '<?=date("Y-m-d 00:00:00",strtotime(' - 29 days '))?>';
			var drange2 = '<?=date("Y-m-d 23:59:59")?>';
			var drange = drange1 + ' to ' + drange2;
			$('#date_range').val(drange);
			$('#date_1st').val(drange1);
			$('#date_2nd').val(drange2);
			$('.cal_box').hide();
			$('#date_range').val('');
		} else if (theValue == '4') { //TODAY
			var drange1 = '<?=date("Y-m-d 00:00:00")?>';
			var drange2 = '<?=date("Y-m-d 23:59:59")?>';
			var drange = drange1 + ' to ' + drange2;
			$('#date_range').val(drange);
			$('#date_1st').val(drange1);
			$('#date_2nd').val(drange2);
			$('.cal_box').hide();
			$('#date_range').val('');
		} else if (theValue == '5') { //Display Calender
			//$('.cal_box').show();
			$('#date_range').trigger("click");
		}
	}

	function time_periodf1(theValue) {
		if (theValue == '5') { //Display Calender
			$('#date_range').trigger("click");
		} else {
			$('#time_period').trigger("change");
			$('body').trigger("click");
		}
	}
</script>
<script>
	function qsearchf() {
		var subparameter4 = "";
		if ($.trim($('.search_textbx').val()) == "") {
			alert('The value of the search cannot be Null !');
			$('.search_textbx')[0].focus();
			return false;
		} else if ($.trim($('#searchkeyname').val()) == "") {
			alert('Kindly select');
			$('#searchkeyname')[0].focus();
			return false;
		} else {
			top.window.location.href = "<?=$data['USER_FOLDER']?>/<?=$data['FileName']?>?" + "action=select&key_name=" + $
				.trim($('#searchkeyname').val()) + "&searchkey=" + $.trim($('.search_textbx').val()) +
				subparameter4; // +"&type=-1&status=-1";
		}
	}
	$('.search_textbx,#searchkeyname').on('keyup', function(event) {
		if (event.keyCode == 13) {
			qsearchf();
		}
	});
	$('.simple_search').on('click', function(event) {
		qsearchf();
	});
	$('.adv_search').on('click', function(event) {
		if ($.trim($('.searchkey_adv').val()) != "") {
			if ($.trim($('.s_key_name').val()) == "") {
				alert('Kindly select Type');
				$('.s_key_name')[0].focus();
				return false;
			}
		}
	});
	$('#searchkeyname option[value="<?=isset($_REQUEST['
		key_name '])?prntext($_REQUEST['
		key_name '],0):""?>"]').prop('selected', 'selected');
</script>
<? } ?>

<!-- End Transaction Search Bar -->


<?
if(isset($_REQUEST['key_name'])) 
{
?>
<script>
$('#searchkeyname option[value="<?=@$_REQUEST['key_name']?>"]').prop('selected','selected');</script>
<?
}?>  

<?
if(isset($_REQUEST['status'])) 
{
?>
<script>
$('#status_csearch option[value="<?=@$_REQUEST['status']?>"]').prop('selected','selected');</script>
<?
}?>  
