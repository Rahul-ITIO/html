<? if(isset($data['ScriptLoaded'])){ ?>
<?
// Added For Fetch and update color from db
$domain_server=$_SESSION['domain_server'];

if(isset($domain_server['subadmin']['stats_success_color'])){ 
$stats_success_color=$domain_server['subadmin']['stats_success_color'];
}else{
$stats_success_color="#18cb15";
}
if(isset($domain_server['subadmin']['stats_failed_color'])){ 
$stats_failed_color=$domain_server['subadmin']['stats_failed_color'];
}else{
$stats_failed_color="#ed2b2b";
}
$g_title=((isset($_REQUEST['label']) &&$_REQUEST['label'])?$_REQUEST['label']:'Last 7 Days');
?>
<style>
.trans_period_width { width:160px;}
.daterangepicker .ranges {float: left !important;}
.fa-solid.cals { position: absolute; padding-top: 6px; padding-left: 3px; font-size: 20px;}
.col-sm-6 {width: 100% !important;}  
.cole {width: 100% !important; padding-left:30px;}  
@media (max-width: 500px) {
.trans_period_width { width:120px !important;}
.check-update { height:32px; !important;} 
}
@media (min-width: 420px) {
.col-sm-6 {width: 50% !important;}
.cole { max-width:200px; !important;} 
}


</style>
			
<div id="zink_id" class="container border my-2 bg-primary rounded">

  <h4 class="mt-2"><i class="<?=$data['fwicon']['chart'];?>"></i> Success Ratio</h4>
  
  <? if(isset($_SESSION['display_msg'])){ ?>
	 <div class="alert alert-info alert-dismissible fade show my-2" role="alert"> <strong>Success !</strong>
      <?=$_SESSION['display_msg'];?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
	<? unset($_SESSION['display_msg']);} ?>
	
 <div class="row">
 <div class="input-icons col-sm-6 mt-2" >
        
        
	  
	  <i class="<?=$data['fwicon']['calender'];?> cals field_icon text-link" style="vertical-align:-webkit-baseline-middle;" title="search by date range"></i>
      <input type="text" name='date_range' id="date_1st_range" class="cole form-control" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="Salect date range of transaction">
      
</div>

 <div class="input-icons col-sm-6 text-end mt-2" >		
  <form method="post">
  <input type="hidden" name="action" value="stats_color" />
  <input type="hidden" name="act" value="<?=(isset($_REQUEST['act'])?$_REQUEST['act']:'');?>" />
    <button type="submit" name="sent"  class="btn btn-primary float-end check-update" title="Update Stats Color" data-bs-toggle="tooltip" data-bs-placement="top" >&nbsp;<i class="<?=$data['fwicon']['submit'];?>"></i>&nbsp;</button>
	
    <div class="input-group float-end me-1" style="width: 55px;"> 
     <input type="color" name="stats_failed_color" id="stats_failed_color"  class="form-control form-control-color"  value="<?=$stats_failed_color;?>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Salect color for display failed transaction" required /></div>
	 
    <div class="input-group float-end me-1" style="width: 55px;">  
     <input type="color" name="stats_success_color" id="stats_success_color"  class="form-control form-control-color" value="<?=$stats_success_color;?>" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Salect color for display success transaction" required /></div>
	 

  </form> 
 </div> 
 
 
</div>
  

		  
		  
		  
		  
  <div class="clearfix">&nbsp;</div>
  
 <? if(isset($data['stats']['records'])&&$data['stats']['records']==1) { ?>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/highcharts.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/exporting.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/export-data.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/accessibility.js"></script>

<style>
.highcharts-figure,
.highcharts-data-table table {
    min-width: 320px;
    max-width: 660px;
    margin: 1em auto;
}

.highcharts-data-table table {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #ebebeb;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}

.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}

.highcharts-data-table th {
    font-weight: 600;
    padding: 0.5em;
}

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
    padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}

.highcharts-data-table tr:hover {
    background: #f1f7ff;
}
.highcharts-title { font-size:14px!important; font-family:unset !important; }
</style>
<figure class="highcharts-figure">
    <div id="container"></div>
</figure>
<script>
// Build the chart
Highcharts.chart('container', {
  chart: {
    plotBackgroundColor: null,
    plotBorderWidth: null,
    plotShadow: false,
    type: 'pie'
  },
  colors: ['<?=$stats_success_color;?>','<?=$stats_failed_color;?>'],
  title: {
    text: '<?=$g_title;?> : <?=$data['stats']['total'];?> Transaction',
    align: 'center'
  },
  tooltip: {
    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
  },
  accessibility: {
    point: {
      valueSuffix: '%'
    }
  },
  plotOptions: {
    pie: {
      allowPointSelect: true,
      cursor: 'pointer',
      dataLabels: {
        enabled: true
      },
      showInLegend: true
    }
  },
  series: [{
    name: 'Ratio',
    colorByPoint: true,
    data: [{
      name: 'Success',
      y: <?=$data['stats']['success_ratio'];?>,
      sliced: true,
      selected: true
    }, {
      name: 'Fail',
      y: <?=$data['stats']['fail_ratio'];?>
    }]
  }]
});
</script>

<? }else{ ?>



<div class="alert alert-secondary alert-dismissible fade show mb-5" role="alert">
  <strong>Data not available for the selected period </strong> - <?=$g_title;?>
  
</div>

<? } ?>
  
</div>

<script>   
		$(document).ready(function(){
		
		var theme_mode  =   $('.theme_mode').attr('data-bs-theme');
		if(theme_mode=='dark'){ 
		
			setTimeout(function(){  
			
			$('.highcharts-background').attr("fill", "#212529");
			
			}, 50);
		
		}
		
		  $(".change_color").click(function(){
			var dcode = $(this).attr('data-bs-theme-value');
			
				if(dcode == 'dark'){
					$('.highcharts-background').attr("fill", "#212529");
				}else{
					$('.highcharts-background').attr("fill", "#ffffff");
				}
             
            });
		
		    $(".check-update").click(function(){
			var stats_failed_color=$('#stats_failed_color').val();
			var stats_success_color=$('#stats_success_color').val();
			var stats_failed_color_old="<?=$stats_failed_color;?>";
			var stats_success_color_old="<?=$stats_success_color;?>";
			
			if((stats_failed_color == stats_failed_color_old) && (stats_success_color == stats_success_color_old)){
			alert("For Update select color from color box");
			return false;
			}
            });
			
			//setTimeout(function(){  
			$('.highcharts-title').css('fill','#6e2d9f');
			//}, 500);
		
		    
		
		});
		</script>
<!--=============================================-->
<?php /*?>Below script for calender search Added By Vikash on 17042023<?php */?>
  
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_range/moment.min.js" ></script>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_range/daterangepicker.js"></script>
<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/thirdpartyapp/date_range/daterangepicker.css" />
            
			
			
<script>
$(function() {
	
	<? if(isset($_REQUEST['date_1st'])){ ?>
		
		var start = "<?=((isset(($_REQUEST['date_1st']))&&($_REQUEST['date_1st']))?(date('m/d/Y',strtotime($_REQUEST['date_1st']))):'')?>";
		var end = "<?=((isset(($_REQUEST['date_2nd']))&&($_REQUEST['date_2nd']))?(date('m/d/Y',strtotime($_REQUEST['date_2nd']))):'')?>";
		var label = "<?=((isset(($_REQUEST['label']))&&($_REQUEST['label']))?($_REQUEST['label']):'')?>";
		
	<? }else{ ?>
		var start = moment().subtract(6, 'days');
		var end = moment();
		var label = 'Last 7 Days';
		//alert(start); alert(end);
	<? } ?>
	
	
	var thisUrl = "<?=$data['USER_FOLDER']?>/stats<?=$data['ex'];?>?";
	var labelName='';
	var startDate;
	var endDate;
    function cb(start, end, label='') {
		 labelName=label;
		 startDate = start.format('YYYY-MM-DD'); endDate = end.format('YYYY-MM-DD');
    }
	

    $('#date_1st_range').daterangepicker({
        startDate: start,
        endDate: end,
		locale: {
			"format": "MM/DD/YYYY"
		},
        ranges: {
           'Today': [moment(), moment()],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],

        }
    }, cb);
	
	<? if(!isset($_REQUEST['date_1st'])){ ?>
		cb(start, end, label);
	<? } ?>
	
	
	
	$('#date_1st_range').change(function(){
		var thisVal=$(this).val();
		top.window.location.href=thisUrl+"date_1st="+startDate+"&date_2nd="+endDate+"&label="+labelName;
	});
	
	
	
	
	$('#date_1st_range2').daterangepicker({
		"timePicker": true,
		locale: {
			"format": "MM/DD/YYYY"
		},
		"ranges": {
           'Today': [moment(), moment()],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
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


  $(".field_icon").on('click', function() {
    $('#date_1st_range').trigger('click');
  });
  
</script>
<?php /*?>End script for calender search Added By Vikash on 17042023<?php */?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
