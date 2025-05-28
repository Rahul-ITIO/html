<??>	
	<style>
	.input-icons .fa-solid.cals {position: absolute;padding-top: 8px;padding-left: 3px;font-size: 23px;z-index: 0;}
	/*.input-field {width:100%;padding: 10px;text-align: center;}*/
	</style>

	<script>
// date_range2
// front_ui/default/common/template.cal.do
var test111='111999';
function time_periodf(theValue){
	//alert(theValue);
		if(theValue==''){
			//alert("wrong Data");
			$('#date_range, #date_range_top').val('');
			$('#date_1st').val('');
			$('#date_2nd').val('');
			$('.cal_box').hide();
			//$('#date_range').val('');
		}else if(theValue=='1'){ //WEEK for 7 days
		
			var drange1='<?=date("Y-m-d 00:00:00",strtotime('-6 days'))?>';
			var drange2='<?=date("Y-m-d 23:59:59")?>';
			var drange=drange1 + ' to ' + drange2;
			$('#date_range, #date_range_top').val(drange);
			$('#date_1st').val(drange1);
			$('#date_2nd').val(drange2);
			$('.cal_box').hide();
			//$('#date_range').val('');
		}else if(theValue=='2'){ //MONTH
		
			var drange1='<?=date("Y-m-d 00:00:00",strtotime('-29 days'))?>';
			var drange2='<?=date("Y-m-d 23:59:59")?>';
			var drange=drange1 + ' to ' + drange2;
			$('#date_range, #date_range_top').val(drange);
			$('#date_1st').val(drange1);
			$('#date_2nd').val(drange2);
			$('.cal_box').hide();
			//$('#date_range').val('');
		}else if(theValue=='4'){ //TODAY
		
			var drange1='<?=date("Y-m-d 00:00:00")?>';
			var drange2='<?=date("Y-m-d 23:59:59")?>';
			var drange=drange1 + ' to ' + drange2;
			$('#date_range, #date_range_top').val(drange);
			$('#date_1st').val(drange1);
			$('#date_2nd').val(drange2);
			$('.cal_box').hide();
			//$('#date_range').val('');
		
		}else if(theValue=='5'){ //Display Calender
			//$('.cal_box').show();
			$('#date_range').trigger("click");
		}
}

function time_periodf1(theValue){
	if(theValue=='5'){ //Display Calender
		$('#date_range').trigger("click");
		//$('#date_range').trigger("focus");
		
	}else{
		$('#time_period').trigger("change");
		$('body').trigger("click");
	}
}
		</script>

<link rel="stylesheet" type="text/css" media="all" href="<?=$data['Host']?>/thirdpartyapp/date_ranges/daterangepicker.css" />

<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_ranges/jquery.js"></script>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_ranges/moment.min.js"></script>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_ranges/daterangepicker.js"></script>



<?
if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']&&isset($_REQUEST['date_2nd'])&&$_REQUEST['date_2nd'])
{
	$start	= trim(@$_REQUEST['date_1st']);
	$end	= trim(@$_REQUEST['date_2nd']);
}
else
{
	$start	= date('Y-m-d 00:00:00');
	$end	= date('Y-m-d 23:59:59', strtotime("-6 days"));
}
?>
<script>
var date_range2 = "<?=@$_REQUEST['date_range2']?>";
var date_label = "<?=@$_REQUEST['date_label']?>";
var change_label = date_label;

//var start_de = "<?=((isset(($start))&&($start))?(date('m/d/Y H:i',strtotime($start))):'')?>";
//var end_de = "<?=((isset(($end))&&($end))?(date('m/d/Y H:i',strtotime($end))):'')?>";

var start_de = "<?=((isset(($start))&&($start))?(date('m/d/y H:i',strtotime($start))):'')?>";
var end_de = "<?=((isset(($end))&&($end))?(date('m/d/y H:i',strtotime($end))):'')?>";

var end_days_diff = moment().diff(end_de, 'days');

var days_diff = moment().diff(start_de, 'days');
var days_diff_add = days_diff + 1;
    //alert("moment " + days_diff + " Days"); alert("Last " + days_diff_add + " Days"); alert("End " + end_days_diff + " Days");

if(date_range2==''){
	days_diff=6;
	days_diff_add=7;
}



var start_dtrang = moment().subtract(days_diff, 'days');
var end_dtrang = moment();
var label_dtrang = "Last "+days_diff_add+" Days";

//Yesterday
if(date_label=='Yesterday'){
	start_dtrang = moment().subtract(1, 'days'); 
	end_dtrang = moment().subtract(1, 'days');
}
else if(date_label=='This Month'){ //This Month
	start_dtrang = moment().startOf('month'); 
	end_dtrang = moment().endOf('month');
}
else if(date_label=='Last Month'){ //Last Month
	start_dtrang = moment().subtract(1, 'month').startOf('month'); 
	end_dtrang = moment().subtract(1, 'month').endOf('month');
}


start_de = start_dtrang; end_de = end_dtrang;

var dateRange = {};
	dateRange[(date_label!='')?date_label:"Last "+days_diff_add+" Days"] = [moment().subtract(days_diff, 'days'), moment()];
	dateRange["Today"] = [moment(), moment()];
	
	//dateRange["Last "+days_diff_add+" Days1"] = ["<?=((isset(($start))&&($start))?(date('Y-m-d H:i:s',strtotime($start))):'')?>", "<?=((isset(($end))&&($end))?(date('Y-m-d H:i:s',strtotime($end))):'')?>"];
	
	
	//if(days_diff_add!=1)
	{
		dateRange["Yesterday"] = [moment().subtract(1, 'days'), moment().subtract(1, 'days')];
	}
	//if(days_diff_add!=7)
	{
		dateRange["Last 7 Days"] = [moment().subtract(6, 'days'), moment()];
	}
	//if(days_diff_add!=30)
	{
		dateRange["Last 30 Days"] = [moment().subtract(29, 'days'), moment()];
	}
	dateRange["This Month"] = [moment().startOf('month'), moment().endOf('month')];
	dateRange["Last Month"] = [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')];
	

	
/*
	dateRange["Year " + (currentYear - 1)] = [moment(currentYearStart.subtract(1, "year")), moment(currentYearEnd.subtract(1, "year"))]; // Year 2017
	dateRange["Year " + (currentYear - 2)] = [moment(currentYearStart.subtract(1, "year")), moment(currentYearEnd.subtract(1, "year"))]; // Year 2016
	dateRange["Year " + (currentYear - 3)] = [moment(currentYearStart.subtract(1, "year")), moment(currentYearEnd.subtract(1, "year"))]; // Year 2015
	dateRange["Year " + (currentYear - 4)] = [moment(currentYearStart.subtract(1, "year")), moment(currentYearEnd.subtract(1, "year"))]; // Year 2014
*/


var start_view='';
var end_view='';
var label_view='';
var thisVal_date_range='';
var custom_range_input_name='';
	
//$(function() {
$(document).ready(function() {
	
	//alert('date_range2=> '+date_range2 + ', date_label=> '+date_label);
	
	if(date_range2 !=''){
		setTimeout(function(){
			$('input[id="date_range"]').val(date_range2);
			
			$('#date_range_top').val("<?=@$_REQUEST['date_1st']?> to <?=@$_REQUEST['date_2nd']?>");
			$('#date_1st').val("<?=@$_REQUEST['date_1st']?>");
			$('#date_2nd').val("<?=@$_REQUEST['date_2nd']?>");
			//$('input[id="date_range"]').keyup();
		}, 400);
	}	
		
		
	function cb(start, end, label='') {
		
		start_view=start;
		end_view=end;
		label_view=label;

		change_label = label;
		
		var predefined=' (predefined range: ' + label + ')';
		//alert(predefined);
	
     
		$('input[id="date_range"]').val(start.format('M/DD/YY 00:00') + ' - ' + end.format('M/DD/YY 23:59'));
	   
       //$('input[id="date_range"]').val(date_range2);
		
		$('#date_range_top').val(start.format('YYYY-MM-DD 00:00:00') + ' to ' + end.format('YYYY-MM-DD 23:59:59'));
		
		$('#date_1st').val(start.format('YYYY-MM-DD 00:00:00'));
		$('#date_2nd').val(end.format('YYYY-MM-DD 23:59:59'));
		
		$('#date_label').val((change_label!='')?change_label:label);
		$('#label_date_range').html((date_label!='')?date_label:label);
		
		//alert(label);
		
    }
	
	
	
		
	$('input[id="date_range"]').daterangepicker({
		"opens": 'right', // left right
		"showDropdowns": true,
		"timePicker": true,
			//"timePickerIncrement": true,
		"timePicker24Hour": true,
		"autoApply": true,
			//"autoUpdateInput": true,
		"autoUpdateInput": false,
		"alwaysShowCalendars": false,
		locale: {
			cancelLabel: 'Clear',
			format: 'M/DD/YY HH:mm'
			//format: 'M/DD/YY 00:00'
		},
		ranges: dateRange,
		"startDate": start_de,
		"endDate": end_de
	}, cb);
	
	cb(start_dtrang, end_dtrang, label_dtrang);
	//cb(start_dtrang, end_dtrang);

	$('input[id="date_range"]').on('apply.daterangepicker', function(ev, picker) {
		
		if(change_label=='Custom Range'){
			//alert('time get => '+change_label);
			
			$(this).val(picker.startDate.format('M/DD/YY HH:mm') + ' - ' + picker.endDate.format('M/DD/YY HH:mm'));
			
			$('#date_range_top').val(picker.startDate.format('YYYY-MM-DD HH:mm:00') + ' to ' + picker.endDate.format('YYYY-MM-DD HH:mm:59'));
			
			$('#date_1st').val(picker.startDate.format('YYYY-MM-DD HH:mm:00'));
			$('#date_2nd').val(picker.endDate.format('YYYY-MM-DD HH:mm:59'));
		
		}
		else {
			//alert("fix time => "+change_label);
			
			$(this).val(picker.startDate.format('M/DD/YY 00:00') + ' - ' + picker.endDate.format('M/DD/YY 23:59'));
		
			$('#date_range_top').val(picker.startDate.format('YYYY-MM-DD 00:00:00') + ' to ' + picker.endDate.format('YYYY-MM-DD 23:59:59'));
			
			
			$('#date_1st').val(picker.startDate.format('YYYY-MM-DD 00:00:00'));
			$('#date_2nd').val(picker.endDate.format('YYYY-MM-DD 23:59:59'));
			
		}
		
		
	});
	
	$('input[id="date_range"]').on('cancel.daterangepicker', function(ev, picker) {
		$(this).val('');
	});
	
	
	$('input[id="date_range"]').on('click', function(e) {
		custom_range_input_name='input[id="date_range"]';
		
		$('.ranges li[data-range-key="Custom Range"]').on('click', function(e) {
			var thisText=$(this).text();
			//alert(thisText);
			 thisVal_date_range=$('input[id="date_range"]').val();
			 
			if(custom_range_input_name){
				$(custom_range_input_name).keyup();
				//alert(thisVal_date_range);
			}
			else{
				$('input[id="date_range"]').keyup();
			}
			
			
			
		});
		
	});
	
	
	
	
});


</script>

<? if(isset($_REQUEST['date_range'])&&$_REQUEST['date_range']<>''){ ?>
<script>$('.cal_box').show();</script>
<? } ?>



    <!-- End Transaction Search Bar -->