<??>	
	<style>
	.input-icons .fa-solid.cals {position: absolute;padding-top: 8px;padding-left: 3px;font-size: 23px;z-index: 0;}
	/*.input-field {width:100%;padding: 10px;text-align: center;}*/
	</style>
<!-- front_ui/default/common/template.cal.do	-->
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
	
/*
function roundToNearest20Seconds(date = new Date()) {
    return new Date(Math.round(date.getTime() / 20000) * 20000);
}

function roundToNearest40Seconds(date = new Date()) {
    return new Date(Math.round(date.getTime() / 40000) * 40000);
}

function roundToNearestMinute(date = new Date()) {
    return new Date(Math.round(date.getTime() / 60000) * 60000);
}

function roundToNearest2Minutes(date = new Date()) {
    return new Date(Math.round(date.getTime() / 120000) * 120000);
}

function roundToNearest5Minutes(date = new Date()) {
    return new Date(Math.round(date.getTime() / 300000) * 300000);
}

function roundToNearest10Minutes(date = new Date()) {
    return new Date(Math.round(date.getTime() / 600000) * 600000);
}

function roundToNearest30Minutes(date = new Date()) {
    return new Date(Math.round(date.getTime() / 1800000) * 1800000);
}

function roundToNearestHour(date = new Date()) {
    return new Date(Math.round(date.getTime() / 3600000) * 3600000);
}

// Example usage:
let now = new Date();
console.log("Current Time: " + now);
console.log("Rounded to nearest 20 seconds: " + roundToNearest20Seconds(now));
console.log("Rounded to nearest 40 seconds: " + roundToNearest40Seconds(now));
console.log("Rounded to nearest minute: " + roundToNearestMinute(now));
console.log("Rounded to nearest 2 minutes: " + roundToNearest2Minutes(now));
console.log("Rounded to nearest 5 minutes: " + roundToNearest5Minutes(now));
console.log("Rounded to nearest 10 minutes: " + roundToNearest10Minutes(now));
console.log("Rounded to nearest 30 minutes: " + roundToNearest30Minutes(now));
console.log("Rounded to nearest hour: " + roundToNearestHour(now));
*/


function formatDate1(date = new Date()) {
    const pad = (num) => num.toString().padStart(2, '0');

    const year = date.getFullYear();
    const month = pad(date.getMonth() + 1);
    const day = pad(date.getDate());
    const hours = pad(date.getHours());
    const minutes = pad(date.getMinutes());
    const seconds = pad(date.getSeconds());

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

// Example usage:
let now = new Date();
console.log("Formatted Date: " + formatDate1(now));


// Dev Tech : 24-07-30 get the before time from current via java script 

function getTimeBefore(filter, format='0', date = new Date()) {
    const subtractTime = (date, interval) => {
        return new Date(date.getTime() - interval);
    };

    let interval;
    switch (filter) {
        case 'Now':
            interval = 0; // 0 seconds
            break;
		case '0s':
            interval = 0; // 0 seconds
            break;
        case '20s':
            interval = 20000; // 20 seconds
            break;
        case '40s':
            interval = 40000; // 40 seconds
            break;
        case '1m':
            interval = 60000; // 1 minute
            break;
        case '2m':
            interval = 120000; // 2 minutes
            break;
        case '5m':
            interval = 300000; // 5 minutes
            break;
        case '10m':
            interval = 600000; // 10 minutes
            break;
        case '20m':
            interval = 1200000; // 20 minutes
            break;
        case '30m':
            interval = 1800000; // 30 minutes
            break;
        case '1h':
            interval = 3600000; // 1 hour
            break;
        
    }

    const newDate = subtractTime(date, interval);

    const pad = (num) => num.toString().padStart(2, '0');

    const year = newDate.getFullYear();

	 //pull the last two digits of the year
	const year2 = year.toString().substr(-2);

    const month = pad(newDate.getMonth() + 1);
    const day = pad(newDate.getDate());
    const hours = pad(newDate.getHours());
    const minutes = pad(newDate.getMinutes());
    const seconds = pad(newDate.getSeconds());

	if(format=='1'){ // mm/dd/YY HH:mm
		if(filter.match('Now')){
			return `${month}/${day}/${year2} ${hours}:${minutes}:60`;
		}
		else if(filter.match('m|h')){
			return `${month}/${day}/${year2} ${hours}:${minutes}:00`;
		}
		else {
			return `${month}/${day}/${year2} ${hours}:${minutes}:${seconds}`;
		}
		
	}
	else if(format=='4'){ // mm/dd/YY HH:mm:ss
		return `${month}/${day}/${year2} ${hours}:${minutes}:${seconds}`;
	}
    else if(format=='2'){ // HH:mm
		return `${hours}:${minutes}`;
	}
    else if(format=='3'){ // HH:mm:ss - 
		if(filter.match('Now')){
			return `${hours}:${minutes}:60`;
		}
		else if(filter.match('m|h')){
			return `${hours}:${minutes}:00`;
		}
		else {
			return `${hours}:${minutes}:${seconds}`;
		}
		
	}
    
    else { // YYYY-mm-dd HH:mm:ss
    	return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
	}
}

/*
// Example usage:
console.log("Now ============  : " + getTimeBefore('Now'));
console.log("20 seconds before : " + getTimeBefore('20s'));
console.log("40 seconds before : " + getTimeBefore('40s'));
console.log("1 minute before   : " + getTimeBefore('1m'));
console.log("2 minutes before  : " + getTimeBefore('2m'));
console.log("5 minutes before  : " + getTimeBefore('5m'));
console.log("10 minutes before : " + getTimeBefore('10m'));
console.log("30 minutes before : " + getTimeBefore('30m'));
console.log("1 hour before     : " + getTimeBefore('1h'));
*/

</script>

<script>
var $se_fa = "<?=@$se_fa?>";
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

	//dateRange["Today"] = [moment(), moment()];
	
	
	if($se_fa=='runtime_graph')
	{
		dateRange["20s"] = [moment(getTimeBefore('20s','1')), moment(getTimeBefore('0s','1'))];
		dateRange["40s"] = [moment(getTimeBefore('40s','1')), moment(getTimeBefore('0s','1'))];
		dateRange["1m"] = [moment(getTimeBefore('1m','4')), moment(getTimeBefore('1m','4'))];
		dateRange["2m"] = [moment(getTimeBefore('2m','4')), moment(getTimeBefore('Now','4'))];
		dateRange["5m"] = [moment(getTimeBefore('5m','4')), moment(getTimeBefore('Now','4'))];

		dateRange["10m"] = [moment(getTimeBefore('10m','4')), moment(getTimeBefore('Now','4'))];
		//dateRange["20m"] = [moment(getTimeBefore('20m','4')), moment(getTimeBefore('Now','4'))];
		dateRange["30m"] = [moment(getTimeBefore('30m','4')), moment(getTimeBefore('Now','4'))];
		dateRange["1 hour"] = [moment(getTimeBefore('1h','4')), moment(getTimeBefore('Now','4'))];
		
		
	}
	
	if($se_fa=='gra')
	{
		dateRange["Now"] = [moment('<?=date('m-d-Y H:i', strtotime("-1 minutes"))?>'), moment('<?=date('m-d-Y H:i')?>')];
	}

	dateRange["Today"] = [moment().subtract(0, 'days'), moment()];

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

console.log('===================dateRange========================');
console.log(dateRange);

var start_hm='';
var end_hm='';

var start_hms='';
var end_hms=getTimeBefore('Now','2')+':00';


//onclik label name for time duration only 
function change_label_f(change_label='',fun=''){

	end_hms=getTimeBefore('Now','2')+':00';
	

	if(change_label==='20s')
	{
		start_hm=getTimeBefore('20s','3'); // HH:mm
		end_hm=getTimeBefore('0s','3');
		
		start_hms=getTimeBefore('20s','3'); // HH:mm:ss
		end_hms=getTimeBefore('0s','3');
		dateRange["20s"] = [moment(getTimeBefore('20s','1')), moment(getTimeBefore('0s','1'))];
	}
	else if(change_label==='40s')
	{

		start_hm=getTimeBefore('40s','3'); // HH:mm
		end_hm=getTimeBefore('0s','3');
		
		start_hms=getTimeBefore('40s','3'); // HH:mm:ss
		end_hms=getTimeBefore('0s','3');
		dateRange["40s"] = [moment(getTimeBefore('40s','1')), moment(getTimeBefore('0s','1'))];

	}
	else if(change_label==='1m')
	{
		start_hm=getTimeBefore('1m','2')+':00'; // HH:mm
		end_hm=getTimeBefore('1m','2')+':60';
		
		start_hms=getTimeBefore('1m','2')+':00'; // HH:mm
		end_hms=getTimeBefore('1m','2')+':60';
	}
	else if(change_label==='2m')
	{
		start_hm=getTimeBefore('2m','2'); // HH:mm
		end_hm=getTimeBefore('Now','2');
		
		start_hms=getTimeBefore('2m','3'); // HH:mm:ss
		//end_hms=getTimeBefore('Now','3');
		//end_hms=getTimeBefore('Now','2')+':00';

	}
	else if(change_label==='5m')
	{
		start_hm=getTimeBefore('5m','2'); // HH:mm
		end_hm=getTimeBefore('Now','2');
		
		start_hms=getTimeBefore('5m','3'); // HH:mm:ss
		//end_hms=getTimeBefore('Now','3');
	}
	else if(change_label==='10m')
	{
		start_hm=getTimeBefore('10m','2'); // HH:mm
		end_hm=getTimeBefore('Now','2');
		
		start_hms=getTimeBefore('10m','3'); // HH:mm:ss
		//end_hms=getTimeBefore('Now','3');
	}
	else if(change_label==='20m')
	{
		start_hm=getTimeBefore('20m','2'); // HH:mm
		end_hm=getTimeBefore('Now','2');
		
		start_hms=getTimeBefore('20m','3'); // HH:mm:ss
		//end_hms=getTimeBefore('Now','3');
	}
	else if(change_label==='30m')
	{
		start_hm=getTimeBefore('30m','2'); // HH:mm
		end_hm=getTimeBefore('Now','2');
		
		start_hms=getTimeBefore('30m','3'); // HH:mm:ss
		//end_hms=getTimeBefore('Now','3');
	}
	else if(change_label==='1 hour')
	{
		start_hm=getTimeBefore('1h','2'); // HH:mm
		end_hm=getTimeBefore('Now','2');
		
		start_hms=getTimeBefore('1h','3'); // HH:mm:ss
		//end_hms=getTimeBefore('Now','3');
	}
	else if(change_label==='Now')
	{
		start_hm="<?=date('H:i', strtotime("-1 minutes"))?>";
		end_hm="<?=date('H:i', strtotime("-1 minutes"))?>";

		start_hms="<?=date('H:i:00', strtotime("-1 minutes"))?>";
		end_hms="<?=date('H:i:60', strtotime("-1 minutes"))?>";

	}
	else {
		start_hm='00:00';
		//end_hm='23:59';
		end_hm='23:59';

		start_hms='00:00:00';
		//end_hms='23:59:59';
		end_hms='23:59:59';
	}

	console.log('=======change_label_f()'+fun+'=======> '+start_hms+' - '+end_hms+' | change_label: '+change_label);

}

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

		//  || change_label==='2m' || change_label==='5m' || change_label==='10m' || change_label==='20m' || change_label==='30m' || change_label==='1 hour'

		change_label_f(change_label,'cb');

		console.log('=======cb=> '+start_hms+' - '+end_hms+' | change_label: '+change_label);

		//alert('cb=> '+start_hms+' - '+end_hms+' | change_label: '+change_label+' | '+'on apply=> '+start_hm+' - '+end_hm);
		
		
		var predefined=' (predefined range: ' + label + ')';
		//alert(predefined);
	
		

		$('input[id="date_range"]').val(start.format('M/DD/YY '+start_hm) + ' - ' + end.format('M/DD/YY '+end_hm));
	   
		$('#date_range_top').val(start.format('YYYY-MM-DD '+start_hms) + ' to ' + end.format('YYYY-MM-DD '+end_hms));
		
		$('#date_1st').val(start.format('YYYY-MM-DD '+start_hms));
		$('#date_2nd').val(end.format('YYYY-MM-DD '+end_hms));
		
		$('#date_label').val((change_label!='')?change_label:label);
		//$('#label_date_range').html(label);
		$('#label_date_range').html((date_label!='')?date_label:label);
		
		//alert(label+'\r\n');
		
    }
	
	
	
		
	$('input[id="date_range"]').daterangepicker({
		"opens": 'right', // left right
		"showDropdowns": true,
		"timePicker": true,
			//"timePickerIncrement": true,
		"timePicker24Hour": true,
			"timePickerSeconds": true,
		"autoApply": true,
			//"autoUpdateInput": true,
		//"autoUpdateInput": false,
		
		locale: {
			cancelLabel: 'Clear',
			format: 'M/DD/YY HH:mm:ss'
			//format: 'M/DD/YY 00:00'
		},
		ranges: dateRange,
		"alwaysShowCalendars": false,
		"linkedCalendars": false,
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
			change_label_f(change_label,'on apply');
			
			console.log('=======on apply=> '+start_hms+' - '+end_hms+' | change_label: '+change_label);
			//alert('on apply=> '+start_hms+' - '+end_hms+' | change_label: '+change_label+' | '+'on apply=> '+start_hm+' - '+end_hm);

			//$(this).val(picker.startDate.format('M/DD/YY 00:00') + ' - ' + picker.endDate.format('M/DD/YY 23:59'));
			$(this).val(picker.startDate.format('M/DD/YY '+start_hm) + ' - ' + picker.endDate.format('M/DD/YY '+end_hm));
		
			$('#date_range_top').val(picker.startDate.format('YYYY-MM-DD '+start_hms) + ' to ' + picker.endDate.format('YYYY-MM-DD '+end_hms));
			
			
			$('#date_1st').val(picker.startDate.format('YYYY-MM-DD '+start_hms));
			$('#date_2nd').val(picker.endDate.format('YYYY-MM-DD '+end_hms));


			
		}
		
		
	});
	
	$('input[id="date_range"]').on('cancel.daterangepicker', function(ev, picker) {
		$(this).val('');
	});
	
	
	$('input[id="date_range"]').on('click', function(e) {
		custom_range_input_name='input[id="date_range"]';
		
		date_label='';
		var label_date_range1=$('#label_date_range').text();
		var thisText2=$(this).text();
			//alert(thisText2+' | date_label: '+label_date_range1);

			


		$('.ranges ul li').removeClass('active');
		if(label_date_range1==='Custom Range'){

		}
		else {
			
		}
		
		$('.ranges ul li[data-range-key="'+label_date_range1+'"]').addClass('active');

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
	
	

	  //on show : Open the modal for date range via popup menue 
	  $('input[id="date_range"]').on('show.daterangepicker', function(ev, picker) {
        //alert('oooo');
        $( '.drp-buttons' ).find('.on_created_date_span').remove();
        $( '.drp-buttons .on_created_date_span' ).remove();
        $( '.drp-buttons .drp-selected' ).before( '<span class="on_created_date_span float-start mt-1"><input type="checkbox" class="checkbox" name="on_created_date" id="on_created_date" onclick="on_created_datef();"  value="1" <?=(isset($_REQUEST['is_created_date_on'])&&trim($_REQUEST['is_created_date_on'])?'checked="checked"':'')?>  > Created Date </span>' );
        // Update the contents of a table to reflect the selected date range.
        

        // Get the start and end dates of the selected range.
        var startDate = picker.startDate;
        var endDate = picker.endDate;

        <?/*?>
        alert('on show :=>startDate=>'+startDate.format('MM/DD/YYYY')+'\r\n endDate=>'+endDate.format('MM/DD/YYYY')+'\r\n created_date=>'+"<?=(isset($_REQUEST['is_created_date_on'])&&trim($_REQUEST['is_created_date_on'])?$_REQUEST['is_created_date_on']:'')?>");
        <?*/?>

        
    });


    //on hide : Close or clear for date range via popup menue
    $('input[id="date_range"]').on('hide.daterangepicker', function (ev, picker) {

        var startDate = picker.startDate;
        var endDate = picker.endDate;  
        //MM/DD/YYYY format
        //$('input[id="date_range"]').val(startDate.format('MM/DD/YYYY') + ' - ' + endDate.format('MM/DD/YYYY'));

        //alert('on hide :=> startDate=>'+startDate.format('MM/DD/YYYY  HH:mm:ss')+'\r\n endDate=>'+endDate.format('MM/DD/YYYY   HH:mm:ss')+'\r\n date_range=>'+"<?=(isset($_REQUEST['date_range'])&&trim($_REQUEST['date_range'])?$_REQUEST['date_range']:'')?>");
        
    });
	
	
});



function on_created_datef(){
    if($("#on_created_date").is(':checked')){
        // Code in the case checkbox is checked.
        //alert('checked=>checked');
        $("#is_created_date_on").val('1');
    } else {
        // Code in the case checkbox is NOT checked.
        //alert('NOTchecked=>NOTchecked');
        $("#is_created_date_on").val('');
    }
}

</script>

<? if(isset($_REQUEST['date_range'])&&$_REQUEST['date_range']<>''){ ?>
<script>$('.cal_box').show();</script>
<? } ?>



    <!-- End Transaction Search Bar -->