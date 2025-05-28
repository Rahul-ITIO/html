<??>
<style>
.icon1{padding:10px;background:#fff;border-radius:10px;box-shadow: 0px 2px 2px 0px rgb(0 0 0 / 50%);}
.websites .dropdown-menu.show {left:-8px !important;top:5px !important;}
.daterangepicker .ranges li.active { background: var(--link-color-template) !important; }
.fa-solid.cals { position: absolute; padding-top: 6px; padding-left: 3px; font-size: 20px;}
#sidebar ul li.active>a, a[aria-expanded="true"]  { color:#000033 !important;}
</style>
<?php /*?>fetch default currency from db by function<?php */?>
<? 
$default_currency=prntext(get_currency($post['default_currency']));
$default_full_currency=prntext($post['default_currency']);
?>
<div class="row text-center my-2 dashboard_box" >
  <div class="col-sm-2 p-2">
   
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['transaction'];?> text-link"></i> </span> <a style="text-decoration:none;">
        <div class="mt-3 text-white">
          <h3><?=prntext($post['noOfTransaction']);?></h3>
          <span class="py-2" title="No of Transactions">Transactions</span>
        </div>
        </a> 
	</div>

  </div>
  <div class="col-sm-2 p-2">
    
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['amount'];?> text-link"></i> </span> <a  style="text-decoration:none;">
        <div class="mt-3 text-white">
          <h3>
            <?=$default_currency;?>
            <?=prnsum2($post['transactionAmount']);?>
          </h3>
          <span class="py-2" title="Transaction Amount">Amount</span>
        </div>
        </a> </div>
   
  </div>
  <div class="col-sm-2 p-2">
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['settlement'];?> text-link"></i> </span> <a  style="text-decoration:none;">
        <div class="mt-3 text-white">
          <h3>
            <?=$default_currency;?>
            <?=prnsum2(str_replace_minus($post['settlements']));?>
          </h3>
          <span class="py-2" title="Settlements">Settlements</span>
        </div>
        </a> </div>
  </div>
  <div class="col-sm-2 p-2">
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['refund'];?> text-link"></i> </span> <a  style="text-decoration:none;">
        <div class="mt-3 text-white">
          <h3>
            <?=$default_currency;?>
            <?=prnsum2(str_replace_minus($post['refundAmount']));?>
          </h3>
          <span class="py-2" title="Refund Amount">Refund</span>
        </div>
        </a> </div>
  </div>
  
  <div class="col-sm-2 p-2">
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['sales-volume'];?> text-link"></i> </span> <a  style="text-decoration:none;">
        <div class="mt-3 text-white">
		        <?php
		        if(!empty($post['gr2_s']['transaction_amount'])){
				$s_amount_ex=explodes(array_sum($post['gr2_s']['transaction_amount']),'.');
				}else{
				$s_amount_ex['s1']='0';
				$s_amount_ex['s2']='00';
				}
				
				if(empty($s_amount_ex['s2'])){ $s_amount_ex['s2']="00"; }
				?>
                <h3> <?=$default_currency;?> <?=$s_amount_ex['s1'];?>.<?=substr($s_amount_ex['s2'],0,2);?></h3>
          
          <span class="py-2" title="Sales Volume">Sales Volume</span>
        </div>
        </a> </div>
  </div>
  <div class="col-sm-2 p-2">
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['deshboard-website'];?> text-link"></i> </span> <a  style="text-decoration:none;">
        <div class="mt-3 text-white" style="margin-top: 15px;">
          <h3>
            <div class="dropdown"> <a class="dropdown-toggle88" data-bs-toggle="dropdown" style="cursor:pointer;font-size: 14px;" title="<?=prntext($post['company_name']);?>" >
              <h3>
                <? if($post['company_name']){  echo prntext(substr($post['company_name'],0,15)); }else{ echo "&nbsp;&nbsp;";};?>
				<!--<i class="<?=$data['fwicon']['circle-down'];?> text-link"></i>-->
              </h3>
              </a>
              <div class="dropdown-menu ms-2" id="webmenu" aria-labelledby="dropdownMenuButton" >
                <? if($post['terminals']){
						foreach($post['terminals'] as $key=>$value){?>
                <a class="dropdown-item text-link" href="<?=$data['USER_FOLDER'];?>/dashboard<?=$data['ex'];?>?wid=<?=$value['id'];?>"><i class="<?=$data['fwicon']['hand'];?>"></i>&nbsp;
                <?=$value['ter_name'];?>
                </a>
                <? }
					} ?>
              </div>
            </div>
          </h3>
          <span class="py-2" >Business</span>
        </div>
        </a> </div>
  </div>
</div>
<div class="row mt-2" >
  <div class="col-lg-12">
    <div class="tab-content99">
      <div class="tab-pane active row" id="firsttab">
      <div class="col-sm-9">	  
	  
        <h4 class="mx-2 ">
          <?=$activeGraph=((isset(($_REQUEST['label']))&&($_REQUEST['label']))?($_REQUEST['label']):'Last 30 Days')?>
          : <font class="graph_fs bg-primary text-muted">
          <? if(isset($data['post_form']['date_1st'])&&isset($data['post_form']['date_2nd'])){
				echo $data['post_form']['date_1st']=prndatelog($data['post_form']['date_1st']);
				echo " - ".$data['post_form']['date_2nd']=prndatelog($data['post_form']['date_2nd']);
			} ?>
          </font> </h4>
</div>		  
      <div class="col-sm-3 pe-2 input-icons">
	  
	  <i id="date_1st_range_icon99" class="<?=$data['fwicon']['calender'];?> cals field_icon float-start text-link" style="vertical-align:-webkit-baseline-middle;" title="search by date range"></i>
<input type="text" name='date_range' id="date_1st_range" class="cole form-control form-control-sm ps-4 float-end bg-primary text-white" >

</div>
      </div>
    </div>


    <p>
	<label class="text-link fw-bold my-1 px-2">Graphical Statistics: </label>
    <label class="text-link fw-bold my-1 px-2">Result: <?=$post['gr2_s']['count_result'];?></label>
    <label class="text-link fw-bold my-1 px-2">Total Amount: <?=$default_currency;?> <?=$post['gr2_s']['total_amount'];?></label>
    <label class="text-link fw-bold my-1 px-2">Success Amount:
      <?=$default_currency;?>
      <?=(isset($post['gr2_s']['transaction_amount'])?array_sum($post['gr2_s']['transaction_amount']):'');?>
      </label>
      <label class="text-link fw-bold my-1 px-2">Transactions: <?=$post['gr2_s']['ids'];?></label>
    </p>
    <!--display chart on mycontainer div-->
    <div id="mycontainer" style="min-width: 100%; height: 400px; margin: 0 auto"></div>
  </div>
  <style>
  .daterangepicker .ranges {float: left !important;}
  
  <? if(isset($_REQUEST['q'])){ ?>
	#sidebar-wrapper {display:none!important;} 
  <? } ?>
  </style>
  
</div>
            <script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_range/moment.min.js" ></script>
            <script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_range/daterangepicker.js"></script>
            <link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/thirdpartyapp/date_range/daterangepicker.css" />
            <script type="text/javascript">
$(function() {
	
	<? if(isset($_REQUEST['date_1st'])){ ?>
		
		var start = "<?=((isset(($_REQUEST['date_1st']))&&($_REQUEST['date_1st']))?(date('m/d/Y',strtotime($_REQUEST['date_1st']))):'')?>";
		var end = "<?=((isset(($_REQUEST['date_2nd']))&&($_REQUEST['date_2nd']))?(date('m/d/Y',strtotime($_REQUEST['date_2nd']))):'')?>";
		var label = "<?=((isset(($_REQUEST['label']))&&($_REQUEST['label']))?($_REQUEST['label']):'')?>";
		
	<? }else{ ?>
		var start = moment().subtract(29, 'days');
		var end = moment();
		var label = 'Last 30 Days';
		//alert(start); alert(end);
	<? } ?>
	
	
	
	
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
        //$('#date_1st_range span').html(start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD'));
		
		//alert(label+', start: '+start.format('YYYY-MM-DD')+', end: '+end.format('YYYY-MM-DD'));
		
		 startDate = start.format('YYYY-MM-DD'); endDate = end.format('YYYY-MM-DD');
		
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
           //'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           //'This Month': [moment().startOf('month'), moment().endOf('month')],
           //'Last Month': [moment().subtract(1, 'month').startOf('month'),
		   //moment().subtract(1, 'month').endOf('month')],
           //'This Year': [moment().startOf('year'), moment().endOf('year')],
           // 'Last Year': [moment().subtract(1, 'year').startOf('year'),
		   // moment().subtract(1, 'year').endOf('year')]
        }
    }, cb);
	
	<? if(!isset($_REQUEST['date_1st'])){ ?>
		//cb(start, end, label);
	<? } ?>
	
	
	
	$('#date_1st_range').change(function(){
		/*
		var thisVal = $('#date_1st_range').val();
		alert(thisVal+', start: '+start.format('YYYY-MM-DD')+', end: '+end.format('YYYY-MM-DD')+', labelName: '+labelName);
		var startDate = start.format('YYYY-MM-DD');
		var endDate = end.format('YYYY-MM-DD');
		*/
		
		
		var thisVal=$(this).val();
		//[startDate, endDate] = thisVal.split(' - ');
		
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
           //'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           //'This Month': [moment().startOf('month'), moment().endOf('month')],
           //'Last Month': [moment().subtract(1, 'month').startOf('month'),
		  // moment().subtract(1, 'month').endOf('month')],
          // 'This Year': [moment().startOf('year'), moment().endOf('year')],
          // 'Last Year': [moment().subtract(1, 'year').startOf('year'),
		  // moment().subtract(1, 'year').endOf('year')]
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
	
	
	<? if(isset($_REQUEST['label'])&&$_REQUEST['label']&&strpos($_REQUEST['label'],'Custom')!==false){ ?>
		//$(".drp-calendar").hide();
	<? }else{ ?>
		//$('#date_1st_range').trigger('click');
	<? } ?>
	

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
<script src="<?=$data['TEMPATH']?>/common/js/highcharts.js"></script>

<? if(isset($_REQUEST['q'])){ ?>
<br/>
date_transaction<br/>
<?php echo json_encode($post['gr2_s']['date_transaction']);?> <br/>
<br/>
transaction_amount<br/>
<?php echo json_encode($post['gr2_s']['transaction_amount']);?> <br/>
<br/>
s_amount<br/>
<?php echo str_replace(',',', ',json_encode($post['gr2_s']['transaction_amount']));?> <br/>
<br/>
s_amount array_sum<br/>
<?=array_sum($post['gr2_s']['transaction_amount']);?>
<br/>
<br/>
transaction_amount array_sum<br/>
<?php echo array_sum($post['gr2_s']['transaction_amount']);?>
<? } ?>
<script type="text/javascript">



<?php
$s_amount_new="[";
foreach ($post['gr2_s']['transaction_amount'] as $value) {
$s_amount_new.=round($value,2).",";
}
$s_amount_new=substr($s_amount_new,0,-1)."]"; 
?>	
var activeGraph="<?=$activeGraph?>";
// jquery ready start
$(document).ready(function() {

//   let today = new Date();
// 	document.getElementById("date").innerHTML = today;
var date_transaction=<?php echo json_encode($post['gr2_s']['date_transaction']);?>;
var transaction_amount_graphdata=<?php echo json_encode($post['gr2_s']['transaction_amount']);?>;
var s_amount=<?php echo $s_amount_new;?>;
var default_full_currency="<?php echo ($default_full_currency);?>";

	
$(function() { 


	Highcharts.setOptions({
		chart: {
			backgroundColor: {
				linearGradient: [0, 0, 500, 500],
				stops: [
					[0, '<?=$data['tc']['hd_b_l_9'];?>'],
					[1, 'rgb(240, 240, 255)']
				]
			},
			borderWidth: 1,
			plotBackgroundColor: '<?=$data['tc']['hd_b_l_9'];?>',
			plotShadow: true,
			plotBorderWidth: 0
		}
	});
	
	$('#mycontainer').highcharts({
		chart: {type: 'areaspline'}, // column  || waterfall ||
		//chart: {renderTo: 'smallChart1', type: 'bar'}, // smallChart1  ||  waterfall
		colors: [
			"<?=$_SESSION['background_gd3']?>",
			"<?=$data['tc']['hd_b_l_9']?>"
		],
		title: {
			text: activeGraph,
			style: {
				color: '<?=$_SESSION['background_gd3']?>'
			}
		},
		legend: {
			layout: 'vertical',
			align: 'left',
			verticalAlign: 'top',
			x: 150,
			y: 100,
			floating: true,
			borderWidth: 1,
			
			
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



		
		  // $(".rounded.change_color").click(function(){
             //setTimeout(function(){ 
			   //location.reload();
	        //}, 100);
            //});
		
		    
		    let backGroundColor = sessionStorage.getItem("jqr_background");
			if(backGroundColor == null){
			
			$('rect[fill="#ffffff"]').attr("fill", "#ffffff");
			}else{
			setTimeout(function(){ 
			$('rect[fill="#ffffff"]').attr("fill", backGroundColor);
			$('rect[fill="url(#highcharts-1)"]').attr("fill", backGroundColor);
	        }, 50);
			
			}
	
	
	
});


// jquery end
</script>
