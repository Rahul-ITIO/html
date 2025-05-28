<? 
if(!isset($_SESSION['login'])){
	echo('ACCESS DENIED.');
	exit;
}
if($_REQUEST['gid']==""){
	$t1=date('Y-m-d 00:00:00',strtotime('-6 days'));
	$t2=date('Y-m-d 23:59:59');
	header("Location:?gid=range&date_1st=$t1&date_2nd=$t2&label=Last%207%20Days");exit;
}
//echo $_SESSION['dashboard_notice'];
//echo $_SESSION['notice_type'];

if($_SESSION['notice_type']==1){
$notice='<img src="'.$data['TEMPATH'].'/common/images/opal.png" class="img-fluid" alt="ad">';
}elseif($_SESSION['notice_type']==2){
$notice='<p class="my-2 px-2 text-start">'.$_SESSION['dashboard_notice'].'</p>';
}

?>
<!-- CSS only -->
<link rel="stylesheet" type="text/css" href="<?=@$data['TEMPATH']?>/common/css/main.css" />
<script src="<?=@$data['Host']?>/thirdpartyapp/highcharts/highmaps.js"></script>
<script src="<?=@$data['Host']?>/thirdpartyapp/highcharts/data.js"></script>
<script src="<?=@$data['Host']?>/thirdpartyapp/highcharts/exporting.js"></script>
<style>
.row { --bs-gutter-x: 1.5rem !important;}
.border { /*color:#ffa800 !important; border-color:#ffffff !important;*/ }
.text-icon { color:#000000; }
input { background-color:#CCCCCC !important;border-color: #999999 !important;}
g text *, g text {font-size: 12px !important; font-weight:normal !important;}
g .circle-chart__percent {font-size: 8px !important; font-weight:normal !important;}
.card.card1 { 
  box-sizing: border-box;
  overflow: visible;
 } 
 .box-shadow {
  /*box-shadow: 11px 11px 11px 11px rgba(0, 0, 0, 0.25);overflow: visible;*/
 }
.box-width { width: 90%; }
body a { color: #000000; }
.card { border: 0px solid rgba(0,0,0,.125) !important; }
rect[Attributes Style] { stroke: #ffffff !important; }

#content { min-height: 10px !important; }
@media (max-width: 900px) {
.padding-mobile{ margin-top:10px; }
.col-sm-9{ width: 100% !important; }
}
</style>
        <? 
		$default_currency=prntext(get_currency($post['default_currency']));
		$default_full_currency=prntext($post['default_currency']);
		?>
<span id="stroke_success_for_css" class="hide"></span> <span id="stroke_fail_for_css" class="hide"></span> <span id="stroke_warning_for_css" class="hide"></span> <span id="stroke_bg_for_css" class="hide"></span>
<div class="container ps-0">
  <div class="mainBody row">
  
  
  
  <? if((isset($_SESSION['action_success'])&& $_SESSION['action_success'])){ ?>
  <div class="alert alert-success alert-dismissible fade show m-2" role="alert"> Success !
    <?=prntext($_SESSION['action_success'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? unset($_SESSION['action_success']); } ?>

    <div class="col-sm-9" style="height:100vh;">
      
	  <div class="row px-2">
	    <div class="col mb-2 text-center px-0">
          <div class="card card1 rounded-tringle pull-up mx-1 bg-white text-dark">
            <div class="card-body">
              <div class="text-card">
                <h3>Transactions</h3>
                <h6>
                  <?=@$default_currency;?>
                  <?=prnsum2($post['transactionAmount']);?>
                </h6>
              </div>
            </div>
          </div>
        </div>
        <div class="col mb-2 text-center px-0">
          <div class="card card1 rounded-tringle pull-up mx-1 bg-white text-dark">
            <div class="card-body">
              <div class="text-card">
                <h3>Settlements</h3>
                <h6>
                  <?=@$default_currency;?>
                  <?=prnsum2(str_replace_minus($post['settlements']));?>
                </h6>
              </div>
            </div>
          </div>
        </div>
        <div class="col mb-2 text-center px-0">
          <div class="card card1 rounded-tringle pull-up mx-1 bg-white text-dark">
            <div class="card-body">
              <div class="text-card">
                <h3>Refund Amount</h3>
                <h6>
                  <?=@$default_currency;?>
                  <?=prnsum2(str_replace_minus($post['refundAmount']));?>
                </h6>
              </div>
            </div>
          </div>
        </div>
	  </div>
      <div class=" rounded-tringle px-2">
       
		
		<div class="col-sm-12" style="height:calc(100vh - 90px);">
		
		
		<div class="row px-2">
        
        <div class="col-sm-6 my-3 px-0">
          <div class="float-start  px-1" style="width:calc(100% - 35px);">
            <center>
          <ul id="graphSorting"  class="list-group text-center nav nav-tabs mt-2 mysidelist">
			<li  class="list-group-item radius1 hover-for-all"  style="padding: 0px;">
              <input type="text" name='date_range' id="date_1st_range" class="radius1 datepicker2 select_cs_2 cole form-select form-select-sm"  autocomplete="off"   >
              <input type="hidden" name='date_range2' id="date_range_input_id"    >
            </li>
			
			<? if(isset($_REQUEST['label'])&&$_REQUEST['label']&&strpos($_REQUEST['label'],'Custom')!==false){ ?>
				
			<? }else{ ?>
				<li style=""> </li>
			<? } ?>

<link rel="stylesheet" type="text/css" media="all" href="<?=$data['Host']?>/thirdpartyapp/date_ranges/daterangepicker.css" />

<?/*?>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_ranges/jquery.js"></script>
<?*/?>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_ranges/moment.min.js"></script>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_ranges/daterangepicker.js"></script>

<script type="text/javascript">
var moFrom= "<?=date('Y-m-d 00:00:00')?>";
var moTo= "<?=date('Y-m-d 23:59:59')?>";
var labelName = 'Last 7 Days';

var moFromSet= "<?=date('Y-m-d 00:00:00')?>";
var moToSet= "<?=date('Y-m-d 23:59:59', strtotime('-6 days'))?>";

//$(function() {
$(document).ready(function() {
	
	<? if(isset($_REQUEST['date_1st'])){ ?>
		
		 moFromSet = "<?=((isset(($_REQUEST['date_1st']))&&($_REQUEST['date_1st']))?(date('Y-m-d H:i:s',strtotime($_REQUEST['date_1st']))):'')?>";
		 moToSet = "<?=((isset(($_REQUEST['date_2nd']))&&($_REQUEST['date_2nd']))?(date('Y-m-d H:i:s',strtotime($_REQUEST['date_2nd']))):'')?>";
		 labelName = "<?=((isset(($_REQUEST['label']))&&($_REQUEST['label']))?($_REQUEST['label']):'')?>";
		
	<? }else{ ?>
		//$moFromSet	= "<?=date('Y-m-d 00:00:00')?>";
		//$moToSet	= "<?=date('Y-m-d 23:59:59', strtotime('-6 days'))?>";
		
	<? } ?>
	
	//alert('moFromSet: '+moFromSet+', moToSet: '+moToSet+', labelName: '+labelName);
	
	var start = moment(moFromSet);
	var end = moment(moToSet);
	
	
	
	var thisUrl = "<?=@$data['USER_FOLDER']?>/dashboard<?=@$data['ex'];?>?gid=range";
	/*
	var start = moment().startOf('year');
    var end = moment().endOf('year');
    var label = 'This Year';
    
	*/
	
	//var labelName='';
	var startDate;
	var endDate;
    function cb(start, end, label='') {
		labelName=label;
        $('#date_1st_range').val(start.format('M/DD/YY HH:mm') + ' - ' + end.format('M/DD/YY HH:mm'));
        
		$('#date_range_input_id').val(start.format('YYYY-MM-DD HH:mm') + ' - ' + end.format('YYYY-MM-DD HH:mm'));
		
		//alert(label+', start: '+start.format('YYYY-MM-DD')+', end: '+end.format('YYYY-MM-DD'));
		
		 startDate = start.format('YYYY-MM-DD HH:mm'); endDate = end.format('YYYY-MM-DD HH:mm');
		
		//top.window.location.href=thisUrl+"&date_1st="+startDate+"&date_2nd="+endDate+"&label="+label;
		
		//alert(thisUrl+"&date_1st="+startDate+"&date_2nd="+endDate+"&label="+labelName);
		//top.window.location.href=thisUrl+"&date_1st="+startDate+"&date_2nd="+endDate+"&label="+labelName;
    }
	

    $('#date_1st_range').daterangepicker({
		"opens": 'right', // left right
		"showDropdowns": true,
		"timePicker": true,
		"timePicker24Hour": true,
		"autoApply": true,
		"autoUpdateInput": true,
		"alwaysShowCalendars": false,
        "startDate": start.format('MM/DD/YYYY HH:mm:ss'),
        "endDate": end.format('MM/DD/YYYY HH:mm:ss'),
		locale: {
			"cancelLabel": "Clear",
			//"format": "M/DD/YY HH:mm"
			"format": "MM/DD/YYYY HH:mm"
		},
        ranges: {
           'Today': [moment(moFrom), moment(moTo)],
           //'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment(moFrom).subtract(6, 'days'), moment(moTo)],
           'Last 30 Days': [moment(moFrom).subtract(29, 'days'), moment(moTo)],
           // 'This Month': [moment().startOf('month'), moment().endOf('month')],
           //'Last Month': [moment().subtract(1, 'month').startOf('month'),
		   //moment().subtract(1, 'month').endOf('month')],
           //'This Year': [moment().startOf('year'), moment().endOf('year')],
           'Last Year': [moment().subtract(1, 'year').startOf('year'),
		   moment().subtract(1, 'year').endOf('year')]
        }
    }, cb);
	
	<?if(!isset($_REQUEST['date_1st'])){?>
		//cb(start, end, label);
	<?}?>
	
	
	
	$('#date_1st_range').change(function(){
		
		
		//var thisVal=$(this).val();
		var thisVal=$('#date_range_input_id').val();
		//[startDate, endDate] = thisVal.split(' - ');
		
		//alert(thisVal+', startDate: '+startDate+', endDate: '+endDate+', labelName: '+labelName);
		
		//alert("date_1st_range=>\r\n"+thisUrl+"&date_1st="+startDate+"&date_2nd="+endDate+"&label="+labelName);
		top.window.location.href=thisUrl+"&date_1st="+startDate+"&date_2nd="+endDate+"&label="+labelName;
		
			
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
		//$('#date_1st_range').trigger('click');
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
            <li class=""> <a href="<?=@$data['USER_FOLDER'];?>/dashboard<?=@$data['ex'];?>?gid=Daily" data-href="<?=@$data['USER_FOLDER'];?>/dashboard<?=@$data['ex'];?>?gid=Daily" class="list-group-item gSort radius2 hover-for-all" data-toggle1="tab">Daily</a> </li>
            <li ><a href="<?=@$data['USER_FOLDER'];?>/dashboard<?=@$data['ex'];?>?gid=Weekly" data-href="<?=@$data['USER_FOLDER'];?>/dashboard<?=@$data['ex'];?>?gid=Weekly" class="list-group-item gSort radius2 hover-for-all" data-toggle1="tab">Weekly</a> </li>
            <li><a href="<?=@$data['USER_FOLDER'];?>/dashboard<?=@$data['ex'];?>?gid=Monthly" data-href="<?=@$data['USER_FOLDER'];?>/dashboard<?=@$data['ex'];?>?gid=Monthly" class="list-group-item gSort radius2 hover-for-all" data-toggle1="tab">Monthly</a> </li>
            <li id="mylast-item"><a href="<?=@$data['USER_FOLDER'];?>/dashboard<?=@$data['ex'];?>?gid=Yearly" data-href="<?=@$data['USER_FOLDER'];?>/dashboard<?=@$data['ex'];?>?gid=Yearly" class="list-group-item gSort radius3 hover-for-all <?if(!isset($_REQUEST['gid'])){?>active_aa<?}?> " data-toggle1="tab">Yearly</a> </li>
			
			<?*/?>
			
            
          </ul>
        </center>
          </div>
		  
		  
		  <div id="downloadtrans1" class="float-start px-1 hide" style="width:35px;">
		  <a href="<?=@$data['USER_FOLDER']?>/transactions<?=@$data['ex']?>?searchkey=&action=select&key_name=&status=&time_period=&date_1st=<?=date("Y-m-d",strtotime($data['post_form']['date_1st']));?>&date_2nd=<?=date("Y-m-d",strtotime($data['post_form']['date_2nd']));?>&downloadcvs=filterTrCSV" name="downloadcvs" value="filterTrCSV" class="btn btn-icon btn-primary btn-sm mt-2"  title="Download Transaction in CSV Format" autocomplete="off" ><i class="fas fa-download"></i></a>
		  </div>
		  
		  
		  
		  <div id="downloadtrans2" class="float-start px-1" style="width:35px;">
		  <a class="mt-2" title="Download Transaction" autocomplete="off" onclick="change_download('#downloadtrans2','#downloadtrans1')"><i class="fa-solid fa-circle-arrow-right fa-2x text-icon mt-2"></i></a>
		  </div>
        </div>
		
		<div class="col-sm-6"></div>
      </div>
	
	
	  

<div id="mycontainer" class="rounded-tringle-without-shadow my-2" style="min-width: 100%; height: 400px; margin: 0 auto"></div>
  
        <style>
  .list-group-item.radius1, .radius1 {/*border-radius:1rem 1rem 0 0 !important;*/}
  .list-group-item.radius2, .radius2 {border-radius:0 !important;}
  .list-group-item.radius3, .radius3 {border-radius:0 0 1rem 1rem !important;}
  .daterangepicker .ranges {float: left !important;}
  
  <? if(isset($_REQUEST['q'])){ ?>
	#sidebar-wrapper {display:none!important;} 
  <? } ?>
  </style>
  
<script src="<?=@$data['TEMPATH']?>/common/js/highcharts.js"></script>

<?php
$post['gr2_s']['count_result'];
if($post['gr2_s']['count_result'] < 10){
$faction="true";
}else{
$faction="false";
}
?>		 
<?php
$s_amount_new="[";
foreach ($post['gr2_s']['transaction_amount'] as $value) {
$s_amount_new.=round($value,2).",";
}
$s_amount_new=substr($s_amount_new,0,-1)."]"; 
?>	 
<!--==============================================-->	
<? if(isset($_REQUEST['q'])){ ?>
<br/>date_transaction<br/><?php echo json_encode($post['gr2_s']['date_transaction']);?>
<br/><br/>transaction_amount<br/><?php echo json_encode($post['gr2_s']['transaction_amount']);?>
<br/><br/>s_amount<br/><?php echo str_replace(',',', ',json_encode($post['gr2_s']['transaction_amount']));?>

<br/><br/>s_amount array_sum<br/><?=array_sum($post['gr2_s']['transaction_amount']);?>
<br/><br/>transaction_amount array_sum<br/><?php echo array_sum($post['gr2_s']['transaction_amount']);?>
<? } ?>
<script type="text/javascript">




var activeGraph="<?=@$activeGraph?>";
// jquery ready start
$(document).ready(function() {

//   let today = new Date();
// 	document.getElementById("date").innerHTML = today;
var date_transaction=<?php echo json_encode($post['gr2_s']['date_transaction']);?>;
var transaction_amount_graphdata=<?php echo json_encode($post['gr2_s']['transaction_amount']);?>;
//var s_amount=<?php echo str_replace(',',', ',json_encode($post['gr2_s']['transaction_amount']));?>;
var s_amount=<?php echo $s_amount_new;?>;
var default_full_currency="<?php echo ($default_full_currency);?>";

	
$(function() { 


	/*Highcharts.setOptions({
		chart: {
			style: {
				fontFamily: 'Arial, Helvetica, sans-serif',
				fontSize: '2em',
				color: '#f00'
			}
		}
	});*/
	
	
	
	$('#mycontainer').highcharts({
		chart: {type: 'column'}, // column  || waterfall ||
		//chart: {renderTo: 'smallChart1', type: 'bar'}, // smallChart1  ||  waterfall
		
		// Below Color Disable for Multi Color by vikash
		/*colors: [
			"<?=@$data['tc']['hd_b_d_0']?>",
			"<?=@$data['tc']['hd_b_l_9']?>"
		],*/
		title: {
			text: activeGraph,
			style: {
				color: '<?=@$data['tc']['hd_b_d_0']?>'
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
			categories: date_transaction,
  			labels: {
                 enabled: <?=@$faction;?>
             }
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
			name: 'Success Transactions',
            colorByPoint: true,
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
		</div>
		<div class="clearfix">&nbsp;</div>
      </div>
    </div>
    <div class="col-sm-3" align="center">
      <div class="rounded-tringle bg-white py-2 padding-mobile">
      
		<h4>Payment Terminal</h4>
		<form method="post" action="<?=$data['USER_FOLDER']?>/requests<?=$data['ex']?>">
		<input type="hidden" name="action" value="addrequests"/>
		<div id="PayShow" class="p-2 text-start">
		<div  class="float-start px-2" style="width:calc(90% - 50px);">
			  <input type="number" step="any" class="form-control form-control-sm mt-2" name="pay_amount" id="pay_amount" title="Amount to Pay" placeholder="Amount to Pay" required />
		</div>
			<div class="float-start" style="width:50px;"> <i class="fa-solid fa-circle-arrow-right fa-2x  text-icon" id="amount_add" style="margin-top:10px;"></i> </div>
		</div>
		
		<div id="PayHide" class="px-2 row text-start hide">
		<div  class="float-start px-2" style="width:calc(90% - 70px);">
		<input type="text" class="form-control form-control-sm mt-2" name="pay_link" id="pay_link" title="Pay link" placeholder="Pay Link" readonly />
		</div>
		
			<div class="float-start text-center" id="sharelink" style="width:34px;"> <i class="fas fa-share-alt fa-2x text-icon" title="Share Payment Link"  style="margin-top:10px;"></i> </div>
			<div class="float-start text-center" style="width:34px;"> <a data-href="" id="paylink_1"> <i class="fas fa-copy fa-2x text-icon" style="margin-top:10px;" title="Copy Payment Link" onClick="ctcf('#paylink_1','data-href')"></i> </a> </div>
		
		</div>
		
		<div id="PaySend" class="px-2 text-start hide">
		<div  class="float-start px-2" style="width:calc(90% - 50px);">
		<input type="email" class="form-control form-control-sm mt-2" name="pay_email" id="pay_email" title="Payee Email" placeholder="Enter Email ID" required />
		</div>
		<div class="float-start text-center" style="width:50px;">
		<button name="send_link" value="send" class="btn btn-primary btn-sm text-primary my-2">send</button>
		</div>
		
		</div>
		
		 </form> 
		<div class="rounded-start text-start my-3 box-width ms-4 py-2 clearfix" > 
		  <h2><i class="far fa-bell text-icon"></i>&nbsp;&nbsp;Notifications - <a href="<?=@$data['USER_FOLDER']?>/notification<?=@$data['ex']?>">
			<?=@$_SESSION['mNotificationCount'];?>
			</a></h2>
		  <div><i class="fa-solid fa-envelope text-icon"></i>&nbsp;&nbsp;Unread Message : <a href="<?=@$data['USER_FOLDER']?>/message<?=@$data['ex']?>">
			<?=@$_SESSION['message_unread_count'];?>
			</a></div>
		  <div><i class="fa-solid fa-envelope-circle-check text-icon "></i>&nbsp;&nbsp;Read Message : <a href="<?=@$data['USER_FOLDER']?>/message<?=@$data['ex']?>">
			<?=@$_SESSION['message_open_count'];?>
			</a></div>
		  <div><i class="fas fa-bars text-icon"></i>&nbsp;&nbsp;Total Transaction : <a href="statement<?=@$data['ex']?>">
			<?=prntext($post['noOfTransaction']);?>
			</a></div>
		</div>
		
		
        </div>
     
			<div class="rounded-tringle box-shadow bg-white p-1" style="margin-top:20px;">
			<!--<div style="clear:both;"></div>-->
			<!--<h4 class="py-2">FOR AD</h4>-->
			<?=@$notice;?>
			
			</div>
			
	
  </div>
</div>

  <script>



$(".highcharts-credits").empty();
//$(".highcharts-background").empty();

    $(function(){
      // bind change event to select
      $('#dynamic_select').on('change', function () {
          var url = $(this).val(); // get selected value
          if (url) { // require a URL
              window.location = url; // redirect
          }
          return false;
      });
    });
	
$(document).ready(function () {
	//====For Invite Link
	$("#amount_add").click(function(){
	var pay_amount = $("#pay_amount").val();
	
	if(pay_amount==""){ 
	alert ("Enter Amount ex. 10.00"); 
	}else{
			var pay_url="<?=@$data['Host']?>/@<?=prntext($post['username']);?>/"+ pay_amount +"/";
	//alert(pay_url); 
			//var pay_amount = $("#pay_amount").val();
	$("#pay_link").val(pay_url);
	$("#paylink_1").attr("data-href", pay_url);
	$("#PayShow").addClass("hide");
	$("#PayHide").removeClass("hide");
	}
   
    });
	
	//====For Invite Link
	$("#downloadtrans2").click(function(){
	 $("#downloadtrans2").addClass("hide");
	$("#downloadtrans1").removeClass("hide");
	$("#downloadtrans1").addClass("show");
	});
	
	$("#sharelink").click(function(){
	$("#PayHide").addClass("hide");
	$("#PaySend").removeClass("hide");
	$("#PaySend").addClass("show");
	});
	
	$("#paylink_email").click(function(){
	var pay_email = $("#pay_email").val();
	var pay_link = $("#paylink_1").val();
	
	if(pay_email==""){ 
	alert ("Enter Email Id for Sent Payment Link"); 
	}else{
	//alert(pay_email);
	//alert(pay_link);
	}
	
	});
});
</script>




