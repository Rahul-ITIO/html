<??><!-- Transaction Search Bar -->
<?/*?>
<script src="<?=$data['TEMPATH']?>/common/css/chosen/chosen.jquery.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/chosen/chosen.min.css" rel="stylesheet"/>
<?*/?>
<style>
.displ_json .btn.btn-primary.btn-sm {border:0;margin:0;top:5px;position:relative;padding:7px 12px;float:right}
.displ_json #payin_transaction_display_divid {margin-top:43px}
.input-icons i {position:absolute;padding-top:8px;padding-left:1px;font-size:26px;color:#06F!important}
.input-field {width:100%;padding:10px;text-align:center}
    </style>
  <? if(!$post['SearchResult']){ 
  if($data['tr_count']==0){ $data['result_count']=0; }
  if(@$_SESSION['query_post_pg']['page']==""){$_SESSION['query_post_pg']['page']=1;}
  ?>
  <div class="col-sm-12 bg-light border rounded" id="s_box">
	  <div class="row s_section">
        
        <div class="col-sm-10">
          
          <div class="widget-cl2 msearch_1 advSdiv" >
            <form>
              <div class="row">
                  <input type="hidden" name="action" value="select" />
				  
<div class="col-sm-2 px-1 ">  
 <select name="records_per_page" id="records_per_page" title="Select No. Of Records Display" class="form-select my-1 w-100" autocomplete="off">
                  <option value="" selected="selected"> <?=$data['MaxRowsByPage'];?> of Page <?=$_SESSION['query_post_pg']['page'];?> </option>
                  <option value="25">1-25</option>
                  <option value="50">1-50</option>
                  <option value="100">1-100</option>
				  <option value="200">1-200</option>
				  
</select> 
 </div>
				  
<div class="col-sm-3 px-1">  
 <input type="text" name="searchkey" class="searchkey_adv form-control my-1 w-100" placeholder="Search.." value='<?=@$post['searchkey']?>' > 
 </div>
 
 <?/*?>
 <div class="col-sm-2 my-1 px-1">
                <select name="acquirer_type[]" id="acquirer_type_id" data-placeholder="Acquirer" title="Acquirer" multiple class="chosen-select filter_option form-select s_key_name "   >
				  <? 
					 foreach($_SESSION['acquirer_type'] as $key=>$value){ ?>
					 <option value="<?=$value;?>" title="<?=$value;?>">
						[<?=$value;?>] <?=(isset($data['t'][$value]['name1'])?$data['t'][$value]['name1']:'');?>
					  </option>
				  <? } ?>
				 
				</select>
</div>

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

$(".chosen-select").chosen({
	no_results_text: "Opps, nothing found - "
});

			  
	<? if(isset($_REQUEST['acquirer_type'])){ ?>
		setTimeout(function(){ 
								
			chosen_more_value_f("acquirer_type_id",[<?=('"'.implodes('", "',$_REQUEST['acquirer_type']).'"');?>]);
					
		}, 500);
	<? } ?>
</script>
<?*/?>
<div class="col-sm-2 px-1">  
 <select name="key_name" id="searchkeyname" title="Select key name" class="filter_option s_key_name form-select my-1 w-100" autocomplete="off">
                  <option value="" selected="selected">Select</option>
                  <option value="transID" data-placeholder="TransID" title="TransID">TransID</option>
	<option value="reference" data-placeholder="Reference" title="Reference">Reference</option>
	<option value="rrn" data-placeholder="RRN" title="RRN">RRN</option>
	<option value="upa" data-placeholder="UPA" title="UPA">UPA</option>
	<option value="fullname" data-holder="Customer Name" title="Full Name">Full Name</option>
	<option value="bill_amt" data-holder="Bill Amount" title="Bill Amount">Bill Amount</option>
	<option value="mop" data-holder="MOP" title="MOP">MOP</option>
	<option value="trans_response" data-holder="Trans Response" title="Trans Response">Trans Response</option>
	<option value="trans_status" data-holder="Trans Status" title="Trans Status">Trans Status</option>
	<option value="bill_ip" data-holder="Bill IP" title="IP">Bill IP</option>
	<option value="bill_email" data-holder="Bill Email" title="Bill Email">Bill Email</option>
	<option value="bill_phone" data-holder="Bill Phone" title="Bill Phone">Bill Phone</option>
	<option value="product_name" data-holder="Product Name" title="Product Name">Product Name</option>
	<option value="bill_country" data-holder="Bill Country" title="Bill Country">Bill Country</option>
	<option value="bill_zip" data-holder="Bill Zip" title="Bill Zip">Bill Zip</option>
	<option value="descriptor" data-holder="Descriptor" title="Descriptor">Descriptor</option>
                </select>
 </div>    
    
<div class="col-sm-2 px-1">
                  <select name="status" id="status_csearch" class="select_cs_2 cole form-select my-1">
                    <option value="-1" selected="selected">All Status</option>
                    <? foreach($data['TransactionStatus'] as $key=>$value){ ?>
                    <option value="<?=$key;?>">
                    <?=$value;?>
                    </option>
                    <? } ?>
                  </select>
                </div>
				
<div class="col-sm-2 px-1 input-icons" >
<input type="text" class="form-control" name="date_range" id="date_range" placeholder="Custom Date" value="<? if(isset($_REQUEST['date_range'])) echo $_REQUEST['date_range'];?>" style="width:1px; visibility:hidden; position:absolute;z-index:1;" />
<i class="fa-regular fa-calendar-days fs-2x text-info" style="z-index 0;"></i>

  <select id="time_period" name='time_period' title='Date Range' class='filter_option form-select my-1' onClick="time_periodf1(this.value)" onChange="time_periodf(this.value)" style="padding-left:30px;position:relative;background:transparent;z-index:2;" >
    <option selected="" value="">Date</option>
    <option value="4">Today</option>
	<option value="1">Last 7 days</option>
	<option value="2">Last 30 days</option>
	<option value="5">Custom dates</option>
  </select>
  <?
	if(isset($_GET['time_period'])&&$_GET['time_period'])
	{
	?>
	<script>
		$('#time_period option[value="<?=prntext($_GET['time_period'])?>"]').prop('selected','selected');
	</script>
	<?
	}?>


<input type="hidden" class="form-control" name="date_1st" id="date_1st" />
<input type="hidden" class="form-control" id="date_2nd" name="date_2nd" />
</div>
				 
<?php /*?><div class="col-sm-3 cal_box my-1 px-1 hide">				 
<input type="text" class="form-control" name="date_range" id="date_range" placeholder="Custom Date" value="<? if(isset($_REQUEST['date_range'])) echo $_REQUEST['date_range'];?>" />

<input type="hidden" class="form-control" name="date_1st" id="date_1st" />
<input type="hidden" class="form-control" id="date_2nd" name="date_2nd" />
 
</div> <?php */?>

<div class="col-sm-1 px-1">
                  <button type="submit" name="csearch" value="filter" class="adv_search btn btn-primary my-1" style="margin-top:0px;"><i class="fas fa-search"></i></button>
                </div>
              
			  </div>
            </form>
          </div>
        </div>
        <div class="col-sm-1">
          <? if(isset($data['NameOfFile'])){ ?>
          <?php /*?><? if($data['withdraw_gmfa']){ ?>
          <a href="<?=$data['USER_FOLDER']?>/withdraw-fund<?=$data['ex']?>" 
						onClick="javascript:$('#modalpopup_form_popup').show(200);"  class="btn btn-primary my-1 text-white" style="" title="Withdraw Fund">Withdraw</a>
          <? }else{ ?>
          <a onClick="confirm_2mfa('You are required to Activate 2 Factor Authentication (2FA) to access the withdrawal section. Click on OK button to setup 2 Factor Authontication (2FA) now.','<?=$data['USER_FOLDER']?>/two-factor-authentication<?=$data['ex']?>');" class="btn btn-primary  text-white my-1" style="background-color: #00b517 !important;color:#fff!important;float:right;display:inline-block;margin:2px 10px 0 0;" title="Withdraw Fund">Withdraw</a>
          <? } ?><?php */?>
          <? }else{ ?>
          <!--<div class='searchLinkdiv text-end mx-2' style="float:right;"> <a class='acc3 advLdiv btn btn-primary text-white my-1' data-hidec='quickSdiv advLdiv' data-showc='advSdiv quickLdiv' title='Advanced Search' ><i class="fas fa-plus-circle"></i> <span class='deskV'></span></a> <a class='acc3 quickLdiv mobV btn btn-primary text-white  my-1' data-hidec='advSdiv  quickLdiv' data-showc='quickSdiv advLdiv' style='display:none;' title='Simple Search' ><i class="fas fa-plus-circle"></i> <span class='deskV'></span></a> </div>-->
          <? } ?>
       
	   
	   
	   
		<? 
		if(isset($data['con_name'])&&$data['con_name']=='clk')
		{ ?>
			<form target="_blank" style="float:right;margin:5px 0 0 0;" >
			 
<input type="hidden" name="searchkey" class="hide"  style="display:none !important;"  value="<?=isset($_REQUEST['searchkey'])?prntext($_REQUEST['searchkey']):""?>" >
<input type="hidden" name="action" class="hide"  style="display:none !important;"  value="select" >
<input type="hidden" name="key_name" class="hide"  style="display:none !important;"  value="<?=isset($_REQUEST['key_name'])?prntext($_REQUEST['key_name']):""?>" >
<input type="hidden" name="status" class="hide"  style="display:none !important;"  value="<?=isset($_REQUEST['status'])?prntext($_REQUEST['status']):""?>" >
<input type="hidden" name="time_period" class="hide"  style="display:none !important;"  value="<?=isset($_REQUEST['time_period'])?prntext($_REQUEST['time_period']):""?>" >
<input type="hidden" name="date_1st" class="hide"  style="display:none !important;"  value="<?=isset($_REQUEST['date_1st'])?prntext($_REQUEST['date_1st']):""?>" >
<input type="hidden" name="date_2nd" class="hide"  style="display:none !important;"  value="<?=isset($_REQUEST['date_2nd'])?prntext($_REQUEST['date_2nd']):""?>" >

			  <button type="submit"  data-bs-toggle="modal" data-bs-target="#myModa30" name="downloadcvs" value="filterTrCSV" class="btn btn-icon btn-primary btn  mx-1 " style="" title="Download Transaction in CSV Format"><i class="fas fa-download"></i></button>
			  
			  
			  
			</form>
		<? } ?>	
		</div> 
		<div class="col-sm-1 displ_json">	
			 <?
			//include file for payin tras list as per json 
			$payin_trnslist_json_file_from_theme=("../front_ui/{$data['frontUiName']}/common/template.payin_trnslist_json".$data['iex']);
			
			$payin_trnslist_json_file_from_default=("../front_ui/default/common/template.payin_trnslist_json".$data['iex']);
			if(file_exists($payin_trnslist_json_file_from_theme)){
				include($payin_trnslist_json_file_from_theme);
			}elseif(file_exists($payin_trnslist_json_file_from_default)){
				include($payin_trnslist_json_file_from_default);
			}
		?>
		
		</div>
	
	
		
		<? if(isset($_GET['status'])){?>
        <script>$('#status_csearch option[value="<?=$_GET['status'];?>"]').prop('selected','selected');</script>
		<? } ?>
      </div></div>
    </div>
	<script>

function time_periodf(theValue){

		if(theValue==''){
		//alert("wrong Data");
		}else if(theValue=='1'){ //WEEK
		
		var drange1='<?=date("Y-m-d 00:00:00",strtotime('-6 days'))?>';
		var drange2='<?=date("Y-m-d 23:59:59")?>';
		var drange=drange1 + ' to ' + drange2;
		$('#date_range').val(drange);
		$('#date_1st').val(drange1);
		$('#date_2nd').val(drange2);
		$('.cal_box').hide();
		$('#date_range').val('');
		}else if(theValue=='2'){ //MONTH
		
		var drange1='<?=date("Y-m-d 00:00:00",strtotime('-29 days'))?>';
		var drange2='<?=date("Y-m-d 23:59:59")?>';
		var drange=drange1 + ' to ' + drange2;
		$('#date_range').val(drange);
		$('#date_1st').val(drange1);
		$('#date_2nd').val(drange2);
		$('.cal_box').hide();
		$('#date_range').val('');
		}else if(theValue=='4'){ //TODAY
		
		var drange1='<?=date("Y-m-d 00:00:00")?>';
		var drange2='<?=date("Y-m-d 23:59:59")?>';
		var drange=drange1 + ' to ' + drange2;
		$('#date_range').val(drange);
		$('#date_1st').val(drange1);
		$('#date_2nd').val(drange2);
		$('.cal_box').hide();
		$('#date_range').val('');
		
		}else if(theValue=='5'){ //Display Calender
		//$('.cal_box').show();
		$('#date_range').trigger("click");
		}
}

function time_periodf1(theValue){
	if(theValue=='5'){ //Display Calender
		$('#date_range').trigger("click");
		
	}else{
		$('#time_period').trigger("change");
		$('body').trigger("click");
	}
}
		</script>
    <script>
	  function qsearchf(){
		   var subparameter4 = "";
		 
			if($.trim($('.search_textbx').val()) == "") {
				alert('The value of the search cannot be Null !');
				$('.search_textbx')[0].focus();
				return false;
			}else if($.trim($('#searchkeyname').val()) == "") {
				alert('Kindly select');
				$('#searchkeyname')[0].focus();
				return false;
			}else{
				top.window.location.href="<?=$data['USER_FOLDER']?>/<?=$data['FileName']?>?"+"action=select&key_name="+$.trim($('#searchkeyname').val())+"&searchkey="+ $.trim($('.search_textbx').val())+subparameter4; // +"&type=-1&status=-1";
			}
	  }
		$('.search_textbx,#searchkeyname').on('keyup',function(event){
			 if(event.keyCode == 13){
				qsearchf();
			 }
		});
		$('.simple_search').on('click',function(event){
		  qsearchf();
		});
		
		$('.adv_search').on('click',function(event){
		
			  if($.trim($('.searchkey_adv').val()) != "") {
			  
				if($.trim($('.s_key_name').val()) == "") {
				alert('Kindly select Type');
				$('.s_key_name')[0].focus();
				return false;
				}
				
				
			  }
		});
		
		$('#searchkeyname option[value="<?=isset($_REQUEST['key_name'])?prntext($_REQUEST['key_name'],0):""?>"]').prop('selected','selected');
		
		</script>
    <? } ?>
	
	<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_range/moment.min.js"></script>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_range/daterangepicker.js"></script>
<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/thirdpartyapp/date_range/daterangepicker.css" />

<?
if(isset($post['date_range'])&&$post['date_range'])
{
	$periodArr = explode('to', $post['date_range']);
	$start	= trim($periodArr[0]);
	$end	= trim($periodArr[1]);
}
else
{
	$start	= date('Y-m-d H:i:s');
	$end	= date('Y-m-d H:i:s', strtotime("+1 days"));
}
?>
<script>

var start = "<?=((isset(($start))&&($start))?(date('m/d/Y H:i',strtotime($start))):'')?>";
var end = "<?=((isset(($end))&&($end))?(date('m/d/Y H:i',strtotime($end))):'')?>";

//alert(start);
//alert(end);


$(function() {

	$('input[id="date_range"]').daterangepicker({
		autoUpdateInput: false,
		timePicker: true,
		timePicker24Hour: true,
		
		startDate: start,
		endDate: end,
		locale: {
			cancelLabel: 'Clear',
			format: 'M/DD HH:mm'
		}
	});

	$('input[id="date_range"]').on('apply.daterangepicker', function(ev, picker) {
	
	
		/*$(this).val(picker.startDate.format('YYYY-MM-DD HH:mm:ss') + ' to ' + picker.endDate.format('YYYY-MM-DD HH:mm:ss'));*/
		
		$(this).val(picker.startDate.format('YYYY-MM-DD 00:00:00') + ' to ' + picker.endDate.format('YYYY-MM-DD 23:59:59'));
		
		//$('#date_1st').val(picker.startDate.format('YYYY-MM-DD 00:00:00'));
		//$('#date_2nd').val(picker.endDate.format('YYYY-MM-DD 23:59:59'));
		
		$('#date_1st').val(picker.startDate.format('YYYY-MM-DD HH:mm'));
		$('#date_2nd').val(picker.endDate.format('YYYY-MM-DD HH:mm'));
		
	});
	
	$('input[id="date_range"]').on('cancel.daterangepicker', function(ev, picker) {
		$(this).val('');
	});
});


</script>

<? if(isset($_REQUEST['date_range'])&&$_REQUEST['date_range']<>''){ ?>
<script>$('.cal_box').show();</script>
<? } ?>



    <!-- End Transaction Search Bar -->