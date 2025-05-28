<? 
$divhide="";
$divcol="3";
if($data['PageFile']=="statements"){ $divhide="hide"; $divcol="5"; } 
?>

<!-- Transaction Search Bar -->

<style>
.input-icons .fa-solid.cals {position: absolute;padding-top: 8px;padding-left: 3px;font-size: 23px;z-index: 1;}
.input-icons {/* margin-bottom: 10px;*/}
.input-field {width:100%;padding: 10px;text-align: center;}
@media (max-width: 768px) {
.search_form_css .col-sm-5 {width: 50% !important;max-width: 50% !important;}
    
}
</style>

  <? if(!isset($post['SearchResult'])||empty(($post['SearchResult']))){ 
  if(isset($data['tr_count'])&&$data['tr_count']==0){ $data['result_count']=0; }
  if(isset($_SESSION['query_post_pg']['page'])&&$_SESSION['query_post_pg']['page']==""){$_SESSION['query_post_pg']['page']=1;}
  ?>
  <div class="border rounded mb-2 px-2" id="s_box">
          
          <div class="widget-cl2 msearch_1 advSdiv mx-1" >
            <form>
              <div class="row search_form_css">
                  <input type="hidden" name="action" value="select" />
				  
<div class="col-sm-1 px-1">  
 <select name="records_per_page" id="records_per_page" title="Select No. Of Records Display" class="form-control form-control-sm my-1 bg-primary text-white" autocomplete="off">
	  <option value="" selected="selected"> <?=$data['MaxRowsByPage'];?> Record </option>
	  <option value="50" <? if($data['MaxRowsByPage']==50){?> selected="selected" <? } ?> >50 Record</option>
	  <option value="100" <? if($data['MaxRowsByPage']==100){?> selected="selected" <? } ?>>100 Record</option>
	  <option value="200" <? if($data['MaxRowsByPage']==200){?> selected="selected" <? } ?>>200 Record</option>
				  
</select> 
 </div>
				  
<div class="col-sm-4 px-1">  
<input type="text" name="searchkey" id="searchkey" class="form-control form-control-sm my-1 bg-primary text-white" placeholder="Search Keywords"></div>
 
<div class="col-sm-2 px-1">  
 <select name="key_name" id="searchkeyname" title="Select key name" class="filter_option form-select form-select-sm my-1 bg-primary text-white" autocomplete="off">
	<option value="" selected="selected">Select Search Type</option>
	<option value="transaction_id" data-placeholder="transaction_id" title="Transaction ID">TransID</option>
	<option value="mrid" data-placeholder="mrid" title="Reference">Reference</option>
    </select>
 </div>    
    
<div class="col-sm-2 px-1 <?=$divhide;?>">
<select name="status" id="status_csearch" class="select_cs_2 cole form-select form-select-sm my-1 text-white">
<option value="" selected="selected">All Status</option>
<? foreach($data['SendFundStatus'] as $key=>$value){ ?>
<option value="<?=$key;?>"><?=$value;?></option><? } ?>
</select>
</div>
				
<div class="col-sm-<?=$divcol;?> px-1 input-icons" >
<input type="text" class="form-control bg-primary text-white" name="date_range" id="date_range" placeholder="Custom Date" value="<? if(isset($_REQUEST['date_range'])) echo $_REQUEST['date_range'];?>" style="width:1px; visibility:hidden; position:absolute;z-index:1;" />
<span class="float-start" style="width:calc(100% - 46px);">
<i class="<?=$data['fwicon']['calender'];?> cals fs-2x text-link" ></i>

  <select id="time_period" name='time_period' title='Date Range' class='filter_option form-select form-select-sm my-1   text-white' onClick="time_periodf1(this.value)" onChange="time_periodf(this.value)" style="padding-left:30px;z-index: 4;position:relative;background:transparent;"  >
    <option selected="" value="">Date</option>
    <option value="4">Today</option>
	<option value="1">Last 7 days</option>
	<option value="2">Last 30 days</option>
	<option value="5">Custom dates</option>
  </select>
  </span>
  <?
	if(isset($_GET['time_period'])&&$_GET['time_period'])
	{
	?>
	<script>
		//$('#time_period option[value="<?=prntext($_GET['time_period'])?>"]').prop('selected','selected');
	</script>
	<?
	}?>


<input type="hidden" class="form-control" name="date_1st" id="date_1st" />
<input type="hidden" class="form-control" id="date_2nd" name="date_2nd" />

<button type="submit" name="csearch" value="filter" class="adv_search btn btn-primary btn-sm my-1  ms-2 float-start" style="width:36px;"><i class="<?=$data['fwicon']['search'];?>"></i></button>
</div>
				 



              
			  </div>
            </form>
          </div>
        
        
		
		<? if(isset($_GET['status'])){?>
        <script>$('#status_csearch option[value="<?=$_GET['status'];?>"]').prop('selected','selected');</script>
		<? } ?>
      </div>
	  
	  

	<!--///////////////////////-->	  
	  
	<div>
    <? 
	if(isset($data['NameOfFile']))
	{ ?>
         <? if($data['withdraw_gmfa'])
		 { ?>
			<a href="<?=$data['USER_FOLDER']?>/trans_withdraw-fund<?=$data['ex']?>" onClick="javascript:$('#modalpopup_form_popup').show(200);"  class="btn btn-primary my-1 text-white btn-sm float-end" style="" title="Withdraw Fund">Withdraw</a>
          <? }else{ ?>
          <a onClick="confirm_2mfa('You are required to Activate 2 Factor Authentication (2FA) to access the withdrawal section. Click on OK button to setup 2 Factor Authontication (2FA) now.','<?=$data['USER_FOLDER']?>/two-factor-authentication<?=$data['ex']?>');" class="btn btn-primary btn-sm text-white my-1" style="background-color: #00b517 !important;color:#fff!important;float:right;display:inline-block;margin:2px 10px 0 0;" title="Withdraw Fund">Withdraw</a>
          <? } ?>
    <? }?>
       
	   
		<div class="clearfix"></div>						  
	</div>
	
	
	<!--///////////////////////-->
	

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
		
		$('.adv_search1').on('click',function(event){
		
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

        $('.adv_search').on('click',function(event){
		
		var v1=$('#searchkey').val();
		var v2=$('#searchkeyname').val();
		
		if((v1=="") && (v2!="")){
		alert("Please Enter Search Keywords and Select Search Type");
		return false
		}else if((v1!="") && (v2=="")){
		alert("Please Enter Search Keywords and Select Search Type");
		return false
		}else{
		
		}
			  
		});
</script>

<? if(isset($_REQUEST['date_range'])&&$_REQUEST['date_range']<>''){ ?>
<script>$('.cal_box').show();</script>
<? } ?>



    <!-- End Transaction Search Bar -->