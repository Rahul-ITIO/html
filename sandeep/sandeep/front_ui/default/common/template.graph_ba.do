<??>
<style>
#content {padding: 20px;}
#modal14{max-width:100%;margin-left:0;padding:0 23%;margin-top:0}
.modal-card{background-image:linear-gradient(to right,#0019dc,#490dcb,#6201bb,#7100ac,#7a009e);color:#fff;border:none;border-radius:15px}
.bold{font-weight:600}
.card1{background: var(--background-1)!important;;color:#fff;border-radius:15px;border:none}
.card2{background-image:linear-gradient(to right bottom,#374eff,#6847ff,#8b3dff,#aa2cff,#c605ff);color:#fff;border-radius:15px;border:none}
.card3{background-image:linear-gradient(to right bottom,#dd00cd,#bb00bf,#9a01af,#7a009f,#5a008d);color:#fff;border-radius:15px;border:none}
.icon1{padding:10px;background:#fff;border-radius:10px}
.icon11{padding-top:10%;height:70px;width:120px;font-size:30px;text-align:center;border-radius:10px;background:#fff}
.icon2{padding:10px;border-radius:10px;background:#fff;box-shadow:6px 4px 6px #7a7a7a,-10px -12px 20px #fff}
.icon4{height:100%;width:100%;padding-top:20px;padding-bottom:20px;text-align:center;background:#fff;border-radius:10px;color:#000}
.icon4 h3{color:#000}
.text-card{margin-top:10%}
.list-group-item{border:1px solid #5a008d}
.list-group-item:first-child{border-top-left-radius:1rem;border-top-right-radius:1rem}
.list-group-item:last-child{margin-bottom:0;border-bottom-right-radius:1rem;border-bottom-left-radius:1rem}

.websites .dropdown-menu.show {left:-8px !important;top:5px !important;}
.active_aa { background-color:#0071bc;}
</style>
<? 
	$default_currency=prntext(get_currency($post['default_currency']));
	$default_full_currency=prntext($post['default_currency']);

?>



<div class="row text-center my-2" >

  
  <div class="col m-2">
    <div class="card card2">
      <div class="card-body"> <span class="icon1 hover-for-all"> <i class="fas fa-list-ol text-warning"></i> </span> <a  style="color:white;text-decoration:none;">
        <div class="text-card">
          <h3> <?=prntext($post['noOfTransaction']);?></h3>
       
          <p>No of Transactions</p>
        </div>
        </a> </div>
    </div>
  </div>
  <div class="col m-2">
    <div class="card card1">
      <div class="card-body"> <span class="icon1 hover-for-all"> <i class="fas fa-money-bill-alt text-warning"></i> </span> <a  style="color:white;text-decoration:none;">
        <div class="text-card">
          <h3>
            <?=$default_currency;?>
            <?=prnsum2($post['transactionAmount']);?>
            </h3>
          <p>Transaction Amount</p>
        </div>
        </a> </div>
    </div>
  </div>
  <div class="col m-2">
    <div class="card card3">
      <div class="card-body"> <span class="icon1 hover-for-all"> <i class="fas fa-handshake text-warning"></i> </span> <a  style="color:white;text-decoration:none;">
        <div class="text-card">
          <h3> <?=$default_currency;?> <?=prnsum2(str_replace_minus($post['settlements']));?></h3>
          <p>Settlements</p>
        </div>
        </a> </div>
    </div>
  </div>
  <div class="col m-2">
    <div class="card card1">
      <div class="card-body"> <span class="icon1 hover-for-all"> <i class="fas fa-credit-card text-warning"></i> </span> <a  style="color:white;text-decoration:none;">
        <div class="text-card">
          <h3>
             <?=$default_currency;?>
             <?=prnsum2(str_replace_minus($post['refundAmount']));?>
			</h3>
          <p>Refund Amount</p>
        </div>
        </a> </div>
    </div>
  </div>
  <div class="col m-2">
    <div class="card card2">
      <div class="card-body"> <span class="icon1 hover-for-all"> <i class="fas fa-globe-americas text-warning"></i> </span> <a  style="color:white;text-decoration:none;">
        <div class="text-card" style="margin-top: 15px;">
          <h3>
            <div class="dropdown"> <a class="dropdown-toggle55" data-bs-toggle="dropdown" style="cursor:pointer;font-size: 26px;color: #fff;margin: 24px 0 0 0;" title="<?=prntext($post['company_name']);?>" ><?=prntext(substr($post['company_name'],0,23));?></a>
				<div class="dropdown-menu" id="webmenu" aria-labelledby="dropdownMenuButton"> 
					<? if($post['products']){
						foreach($post['products'] as $key=>$value){?>
							<a class="dropdown-item" href="<?=$data['USER_FOLDER'];?>/dashboard<?=$data['ex'];?>?wid=<?=$value['id'];?>"><i class="fas fa-globe-americas"></i>&nbsp;<?=$value['name'];?> </a> 
						<? }
					} ?>
					
					
				 </div>
			  </div>
			</h3>
          <p>Websites</p>
        </div>
        </a> </div>
    </div>
  </div>
  
</div>
<div class="row" style="margin-top: 5%;">
  <div class="col-lg-9">
    <div class="tab-content">
      <div class="tab-pane active" id="firsttab">
        <h4>
			
			<?=$activeGraph=((isset(($_REQUEST['label']))&&($_REQUEST['label']))?($_REQUEST['label']):'Last 30 Days')?>
			<font style="font-size:12px;">
			<? if(isset($data['post_form']['date_1st'])&&isset($data['post_form']['date_2nd'])){
				echo $data['post_form']['date_1st']=(date('m/d/Y g:i:s A',strtotime($data['post_form']['date_1st'])));
				echo " - ".$data['post_form']['date_2nd']=(date('m/d/Y g:i:s A',strtotime($data['post_form']['date_2nd'])));
			} ?>
			</font>
		</h4>
      </div>
      <div class="tab-pane" id="secondtab">
        <h4>Weekly</h4>
      </div>
      <div class="tab-pane" id="thirdtab">
        <h4>Monthly</h4>
      </div>
	  <div class="tab-pane" id="fourthtab">
        <h4>Yearly</h4>
      </div>
    </div>
    <!--<style>-->
    <!--    a{color:white;}-->
    <!--</style>-->
    <p>
<label class="badge rounded-pill bg-warning">Graphical Statistics: No. of Result: <?=$post['gr1']['count_result'];?></label> <label class="badge rounded-pill bg-info">Total Amount: <?=$default_currency;?> <?=$post['gr1']['total_amount'];?></label> 
<label class="badge rounded-pill bg-success">Success Amount: <?=$default_currency;?> <?=(isset($post['gr2_s']['transaction_amount'])?array_sum($post['gr2_s']['transaction_amount']):'');?></label> 
 <label class="badge rounded-pill bg-primary"> No. of Trans.: <?=$post['gr1']['ids'];?></label>
</p>
    <div id="mycontainer" style="min-width: 100%; height: 400px; margin: 0 auto"></div>
  </div>
  <style>
  .list-group-item.radius1, .radius1 {border-radius:1rem 1rem 0 0 !important;}
  .list-group-item.radius2, .radius2 {border-radius:0 !important;}
  .list-group-item.radius3, .radius3 {border-radius:0 0 1rem 1rem !important;}
  .daterangepicker .ranges {float: left !important;}
  
  <? if(isset($_REQUEST['q'])){ ?>
	#sidebar-wrapper {display:none!important;} 
  <? } ?>
  </style>
  <div class="col-lg-3">
    <div class="row">
      <div  class=" col-sm-6 col-xs-6 col-md-6 col-lg-12">
        <center>
          <ul id="graphSorting" style="border-radius: 20px;" class="list-group text-center nav nav-tabs mt-2 mysidelist">
			<li  class="list-group-item radius1 hover-for-all"  style="padding: 0px;">
              <input type="text" name='date_range' id="date_1st_range" style="width:100%;height:42px;padding:0;margin:0;font-size:16px;text-align: center !important;border:none;color:#5a008d;text-align:end;border-bottom-left-radius:14px;border-bottom-right-radius:14px" class="radius1 datepicker2 select_cs_2 cole form-control"  autocomplete="off"   >
			  
            <i id="date_1st_range_icon" style="position:absolute;z-index:99;right:5px;top:12px;    color:#5d008f;" class="fas fa-calendar-alt"></i>
			
            </li>

<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_range/moment.min.js"></script>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_range/daterangepicker.js"></script>
<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/thirdpartyapp/date_range/daterangepicker.css" />


<script type="text/javascript">
$(function() {
	
	<?if(isset($_REQUEST['date_1st'])){?>
		
		var start = "<?=((isset(($_REQUEST['date_1st']))&&($_REQUEST['date_1st']))?(date('m/d/Y',strtotime($_REQUEST['date_1st']))):'')?>";
		var end = "<?=((isset(($_REQUEST['date_2nd']))&&($_REQUEST['date_2nd']))?(date('m/d/Y',strtotime($_REQUEST['date_2nd']))):'')?>";
		var label = "<?=((isset(($_REQUEST['label']))&&($_REQUEST['label']))?($_REQUEST['label']):'')?>";
		
	<?}else{?>
		var start = moment().subtract(29, 'days');
		var end = moment();
		var label = 'Last 30 Days';
		//alert(start); alert(end);
	<?}?>
	
	
	
	
	var thisUrl = "<?=$data['USER_FOLDER']?>/dashboard<?=$data['ex'];?>?gid=range";
	/*
	var start = moment().startOf('year');
    var end = moment().endOf('year');
    var label = 'This Year';
    
	*/
	
	var labelName='';
	var startDate;
	var endDate;
    function cb(start, end, label='') {
		labelName=label;
        $('#date_1st_range span').html(start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD'));
		
		//alert(label+', start: '+start.format('YYYY-MM-DD')+', end: '+end.format('YYYY-MM-DD'));
		
		// startDate = start.format('YYYY-MM-DD'); endDate = end.format('YYYY-MM-DD');
		
		//top.window.location.href=thisUrl+"&date_1st="+startDate+"&date_2nd="+endDate+"&label="+label;
		
    }
	

    $('#date_1st_range').daterangepicker({
        startDate: start,
        endDate: end,
		locale: {
			"format": "MM/DD/YYYY"
		},
        ranges: {
           'Today': [moment(), moment()],
           'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           'This Month': [moment().startOf('month'), moment().endOf('month')],
           'Last Month': [moment().subtract(1, 'month').startOf('month'),
		   moment().subtract(1, 'month').endOf('month')],
           'This Year': [moment().startOf('year'), moment().endOf('year')],
           'Last Year': [moment().subtract(1, 'year').startOf('year'),
		   moment().subtract(1, 'year').endOf('year')]
        }
    }, cb);
	
	<?if(!isset($_REQUEST['date_1st'])){?>
		//cb(start, end, label);
	<?}?>
	
	
	
	$('#date_1st_range').change(function(){
		/*
		var thisVal = $('#date_1st_range').val();
		alert(thisVal+', start: '+start.format('YYYY-MM-DD')+', end: '+end.format('YYYY-MM-DD')+', labelName: '+labelName);
		var startDate = start.format('YYYY-MM-DD');
		var endDate = end.format('YYYY-MM-DD');
		*/
		
		
		var thisVal=$(this).val();
		[startDate, endDate] = thisVal.split(' - ');
		
		//alert(thisVal+', startDate: '+startDate+', endDate: '+endDate+', labelName: '+labelName);
		
		top.window.location.href=thisUrl+"&date_1st="+startDate+"&date_2nd="+endDate+"&label="+labelName;
		
	    /*
		var thisVal=$(this).val();
		[startDate, endDate] = thisVal.split(' - ');
		alert("Start Date: "+ startDate + " End Date: "+ endDate);
		
		$('#graphSorting .gSort').each(function(){
			$(this).attr("href",$(this).attr("data-href")+"&date_1st="+startDate+"&date_2nd="+endDate);
			
		});
		
		*/
		
		//$('#graphSorting .gSort').attr("href");
	});
	
	
	
	
	$('#date_1st_range2').daterangepicker({
		"timePicker": true,
		locale: {
			"format": "MM/DD/YYYY"
		},
		"ranges": {
           'Today': [moment(), moment()],
           'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           'This Month': [moment().startOf('month'), moment().endOf('month')],
           'Last Month': [moment().subtract(1, 'month').startOf('month'),
		   moment().subtract(1, 'month').endOf('month')],
           'This Year': [moment().startOf('year'), moment().endOf('year')],
           'Last Year': [moment().subtract(1, 'year').startOf('year'),
		   moment().subtract(1, 'year').endOf('year')]
        },
		"startDate": "<?=((isset(($_REQUEST['date_1st']))&&($_REQUEST['date_1st']))?(date('m/d/Y',strtotime($_REQUEST['date_1st']))):(date('m/d/Y',strtotime('-30 days'))));?>",
		"endDate": "<?=((isset(($_REQUEST['date_2nd']))&&($_REQUEST['date_2nd']))?(date('m/d/Y',strtotime($_REQUEST['date_2nd']))):(date('m/d/Y')))?>"
	}, function(start, end, label) {
		labelName=label;
	  console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
	});
	
	$('#date_1st_range_demo').daterangepicker({
		"timePicker": true,
		"ranges": {
			"Today": [
				"2022-04-08T10:05:25.496Z",
				"2022-04-08T10:05:25.496Z"
			],
			"Yesterday": [
				"2022-04-07T10:05:25.496Z",
				"2022-04-07T10:05:25.496Z"
			],
			"Last 7 Days": [
				"2022-04-02T10:05:25.496Z",
				"2022-04-08T10:05:25.496Z"
			],
			"Last 30 Days": [
				"2022-03-10T10:05:25.496Z",
				"2022-04-08T10:05:25.496Z"
			],
			"This Month": [
				"2022-03-31T18:30:00.000Z",
				"2022-04-30T18:29:59.999Z"
			],
			"Last Month": [
				"2022-02-28T18:30:00.000Z",
				"2022-03-31T18:29:59.999Z"
			]
		},
		"startDate": "<?=((isset(($_REQUEST['date_1st']))&&($_REQUEST['date_1st']))?(date('m/d/Y',strtotime($_REQUEST['date_1st']))):(date('m/d/Y',strtotime('-30 days'))));?>",
		"endDate": "<?=((isset(($_REQUEST['date_2nd']))&&($_REQUEST['date_2nd']))?(date('m/d/Y',strtotime($_REQUEST['date_2nd']))):(date('m/d/Y')))?>"
	}, function(start, end, label) {
		labelName=label;
	  console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
	});
	
	
	
	<? if(isset($_REQUEST['date_1stx'])&&$_REQUEST['date_2ndx']){ ?>
		$('#date_1st').val("<?=(date('Y-m-d',strtotime($_REQUEST['date_1st'])))?>").trigger("change");
		activeHerf();
	<? } ?>

});
</script>

            <script>
                var dates = [];
$(document).ready(function() {
	
	
	<?if(isset($_REQUEST['label'])&&$_REQUEST['label']&&strpos($_REQUEST['label'],'Custom')!==false){?>
		//$(".drp-calendar").hide();
	<?}else{?>
		$('#date_1st_range').trigger('click');
	<?}?>
	
	/*
  $("#date_1st").daterangepicker();

  $('#date_1st').daterangepicker({
    locale: {
      format: 'YY-MM-DD'
    },
    singleDatePicker: false,
    calender_style: "picker_1",
  }, function(start, end, label) {
    console.log('start: ', start, 'end: ', end, 'label: ', label);
  });
  
  
  $("#date_1st").on('apply.daterangepicker', function(e, picker) {
    e.preventDefault();
    const obj = {
      "key": dates.length + 1,
      "start": picker.startDate.format('MM/DD/YYYY'),
      "end": picker.endDate.format('MM/DD/YYYY')
    }
    dates.push(obj);
    showDates();
  });
  */
  $(".remove").on('click', function() {
    removeDate($(this).attr('key'));
  });
})
function showDates() {
  $("#ranges").html("");
  $.each(dates, function() {
    const el = "<li>" + this.start + "-" + this.end + "<button class='remove' onClick='removeDate(" + this.key + ")'>-</button></li>";
    $("#ranges").append(el);
  })
}
function removeDate(i) {
  dates = dates.filter(function(o) {
    return o.key !== i;
  })
  showDates();
}
            </script>
            
		<?/*?>	
            <li class=""> <a href="<?=$data['USER_FOLDER'];?>/dashboard<?=$data['ex'];?>?gid=Daily" data-href="<?=$data['USER_FOLDER'];?>/dashboard<?=$data['ex'];?>?gid=Daily" class="list-group-item gSort radius2 hover-for-all" data-toggle1="tab">Daily</a> </li>
            <li ><a href="<?=$data['USER_FOLDER'];?>/dashboard<?=$data['ex'];?>?gid=Weekly" data-href="<?=$data['USER_FOLDER'];?>/dashboard<?=$data['ex'];?>?gid=Weekly" class="list-group-item gSort radius2 hover-for-all" data-toggle1="tab">Weekly</a> </li>
            <li><a href="<?=$data['USER_FOLDER'];?>/dashboard<?=$data['ex'];?>?gid=Monthly" data-href="<?=$data['USER_FOLDER'];?>/dashboard<?=$data['ex'];?>?gid=Monthly" class="list-group-item gSort radius2 hover-for-all" data-toggle1="tab">Monthly</a> </li>
            <li id="mylast-item"><a href="<?=$data['USER_FOLDER'];?>/dashboard<?=$data['ex'];?>?gid=Yearly" data-href="<?=$data['USER_FOLDER'];?>/dashboard<?=$data['ex'];?>?gid=Yearly" class="list-group-item gSort radius3 hover-for-all <?if(!isset($_REQUEST['gid'])){?>active_aa<?}?> " data-toggle1="tab">Yearly</a> </li>
			
			<?*/?>
			
            <!--<li class="list-group-item hover-for-all">Monthly</li>-->
            
            <!--<li data-toggle="modal" data-target="#exampleModal" class="list-group-item hover-for-all">Custome</li>-->
          </ul>
        </center>
      </div>
	  <?//Sales Volume?>
      <div  class=" col-sm-6 col-xs-6 col-md-6 col-lg-12 ">
        <center>
          <div class="card card1 mt-2 mysidelist" style="height:auto;">
            <div class="card-body">
              <div class="text-card">
                <h3> Sales Volume</h3>
              </div>
              <div class="icon4">
				<? 
				if(!empty($post['gr2_s']['transaction_amount'])){
					$s_amount_ex=explodes(array_sum($post['gr2_s']['transaction_amount']),'.');
				}else{
				$s_amount_ex['s1']='0';
				$s_amount_ex['s2']='00';
				}
				?>
                <h3> <font><?=$default_currency;?></font><?=$s_amount_ex['s1'];?>.<font><?=substr($s_amount_ex['s2'],0,2);?></font></h3>
              </div>
            </div>
          </div>
        </center>
      </div>
    </div>
  </div>
</div>
<style>
/*
.modal-backdrop.fade{display:none}.calendar-table table thead tr{background-image:#fff!important;background:#fff!important;color:#000!important}.daterangepicker.ltr .calendar.right{margin-left:22px}.daterangepicker.ltr .ranges{float:unset;margin-left:15px}
*/
</style>


<script src="<?=$data['TEMPATH']?>/common/js/highcharts.js"></script>
<script>
/*
const DateRangeFilter = (function () {    
    const $allowtimeselection = $("#AllowTimeSelection");
    const $dateformat = $("#DateFormat");
    const format = $dateformat.length === 1 ? $dateformat.val().toUpperCase() : "";
    const $startDate = $("#StartDate");
    const $endDate = $("#EndDate");
    const $minDate = $("#MinDate");
    const $maxDate = $("#MaxDate");
    const $daterange = $("#daterange");

    function SetDate(start, end) {
        $startDate.val(start.format(format));
        $endDate.val(end.format(format));
        $daterange.val(start.format(format) + ' - ' + end.format(format));
    }

    return {
        Initialize: function () {
          let options = {
                "showDropdowns": true,
                "showWeekNumbers": true,
                "timePicker": false,
                "timePickerIncrement": 1,
                "autoApply": false,
                "opens": "left",
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                "locale": {
                    "format": format,
                    "separator": " - ",
                    "applyLabel": "Select",
                    "cancelLabel": "Cancel",
                    "fromLabel": "From",
                    "toLabel": "To",
                    "customRangeLabel": "Custom"
                },
                "linkedCalendars": false,
                "alwaysShowCalendars": true,
                "startDate": $startDate.val(),
                "endDate": $endDate.val(),
                "minDate": moment($minDate.val(), format).toDate(),
                "maxDate": moment($maxDate.val(), format).toDate()
            };

            $('#daterangepicker').daterangepicker(options, function (start, end, label) {
                //console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
                SetDate(start, end);
            });

            SetDate(moment($startDate.val(), format), moment($endDate.val(), format));
        },
        RemoveDateControlsWithDefaultValues: function () {
            //Remove StartDate if it is not changed
            if ($startDate.val() === $startDate.data("default")) {
                $startDate.remove();
            }

            //Remove EndDate if it is not changed
            if ($endDate.val() === $endDate.data("default")) {
                //Remove EndDate
                $endDate.remove();
            }
        }
    };
})();
DateRangeFilter.Initialize();
*/
</script>
<? if(isset($_REQUEST['q'])){ ?>
<br/>date_transaction<br/><?php echo json_encode($post['gr1']['date_transaction']);?>
<br/><br/>transaction_amount<br/><?php echo json_encode($post['gr1']['transaction_amount']);?>
<br/><br/>s_amount<br/><?php echo str_replace(',',', ',json_encode($post['gr2_s']['transaction_amount']));?>

<br/><br/>s_amount array_sum<br/><?=array_sum($post['gr2_s']['transaction_amount']);?>
<br/><br/>transaction_amount array_sum<br/><?php echo array_sum($post['gr1']['transaction_amount']);?>
<? } ?>
<script type="text/javascript">




var activeGraph="<?=$activeGraph?>";
// jquery ready start
$(document).ready(function() {

//   let today = new Date();
// 	document.getElementById("date").innerHTML = today;
var date_transaction=<?php echo json_encode($post['gr1']['date_transaction']);?>;
var transaction_amount_graphdata=<?php echo json_encode($post['gr1']['transaction_amount']);?>;
var s_amount=<?php echo str_replace(',',', ',json_encode($post['gr2_s']['transaction_amount']));?>;
var default_full_currency="<?php echo ($default_full_currency);?>";

	
$(function() { 


	Highcharts.setOptions({
		chart: {
			style: {
				fontFamily: 'Arial, Helvetica, sans-serif',
				fontSize: '2em',
				color: '#f00'
			}
		}
	});
	$('#mycontainer').highcharts({
		chart: {type: 'column'}, // column  || waterfall ||
		//chart: {renderTo: 'smallChart1', type: 'bar'}, // smallChart1  ||  waterfall
		colors: [
			'#198754',
			'#dc3545'
		],
		title: {
			text: activeGraph,
			style: {
				color: '#555'
			}
		},
		legend: {
			layout: 'horizontal',
			align: 'center',
			verticalAlign: 'bottom',
			borderWidth: 0,
			backgroundColor: '#FFFFFF'
		},
		xAxis: {
			categories: date_transaction
		},
		yAxis: {
// 			labels: {
//                 enabled: false
//             },
            title: {
                text: null
            }
		},
		tooltip: {
			shared: false,
			valueSuffix: ' '+default_full_currency
		},
		credits: {
			enabled: false
		},
		/*plotOptions: {
			areaspline: {
				fillOpacity: 0.8
			},
			series: {
				groupPadding: .30
			}
			
		},*/
		 plotOptions: {
                       column: {
                       borderRadius: 5
                      }
					  
					  
          },
	   
		series: [{
			name: 'Success',
			//type: "spline",
			//type: 'pie',
			data: s_amount   // s_amount | transaction_amount_graphdata
		}]
	});
});
	

	
	

	// $('.input-daterange').datepicker({
	//     todayBtn: true,
	//     autoclose: true
	// });

	// $('.input-daterange input').each(function() {
	//     $(this).datepicker('clearDates');
	// });
	
	
	
});
// jquery end
</script>
