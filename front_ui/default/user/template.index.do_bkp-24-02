<? if(isset($data['ScriptLoaded'])){ ?>
<script>
$(document).ready(function(){ 
	$(".document_type").change(function(){
		document_typef(this,$(this).val());
	});
});	
</script>
<style>
 .dashboard_box h3 {min-height:19px;}
</style>

<?php /*?>/////////////////////New Dashboard Start  ////////////////<?php */?>



<?php
include('../include/country_state'.$data['iex']);

$uid=@$_SESSION['uid'];

//Select Data from master_trans_additional
$join_additional=join_additional('i');
if(!empty($join_additional)) $mts="`ad`";
else $mts="`t`";

      $result_select=db_rows(
			" SELECT {$mts}.`bill_country`, COUNT(`t`.`id`) AS ct, SUM(`t`.`trans_amt`) AS amount".
			" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`  AS `t`".
			" {$join_additional} WHERE `t`.`merID`='{$_SESSION['uid']}' AND `t`.`trans_status` IN (1,7) AND {$mts}.`bill_country`!=''   GROUP BY {$mts}.`bill_country` HAVING COUNT(`t`.`id`) > 0",0
		);
		
		//AND ( `trname` IN ('cn','ch') )
		
		$data['selectdatas'] = $result_select;
		//$_SESSION['selectcountrydata']=$result_select;
		
		$displaydata="";

		$getdata="[ ";
		
		foreach($data['selectdatas'] as $ind=>$value) {
			
			// Fetch 2 Digit country Code
			$country2=trim($value['bill_country']);
			
			// For 3 Digit country Code
			$country3=get_country_code($country2,3);
			
			
			$ct=trim($value['ct']);
			
			$getdata.="['$country3' , $ct , 10],";
			
	
		} 
		
		$getdata=substr($getdata,0,-1);
	    
		$getdata.="] ";
		
	    //echo $_SESSION['country_graph']=$getdata;



?>
<style>
.icon1{padding:10px;background:#fff;border-radius:10px;box-shadow: 0px 2px 2px 0px rgb(0 0 0 / 50%);}
.websites .dropdown-menu.show {left:-8px !important;top:5px !important;}
.daterangepicker .ranges li.active { background: var(--link-color-template) !important; }
.fa-solid.cals { position: absolute; padding-top: 6px; padding-left: 3px; font-size: 20px;}
/*#sidebar ul li.active>a, a[aria-expanded="true"]  { color:#000033 !important;}*/
.highcharts-title { font-size:12px!important; }
.highcharts-credits{ display:none; }
</style>
<div class="container px-0">
<?php /*?>fetch default currency from db by function<?php */?>
<? 
if(isset($_SESSION['tr_sum_count'])) $post=array_merge($post,$_SESSION['tr_sum_count']);

$default_currency=prntext(get_currency($post['default_currency']));
$default_full_currency=prntext($post['default_currency']);
$total_transactions_d=((isset(($post['noOfTransaction']))&&($post['noOfTransaction']))?($post['noOfTransaction']):'0');
?>
<div class="row text-center my-2 px-2 dashboard_box" >
  <div class="col p-2 cursor-pointer" onClick="ajaxf1(this,'<?=@$data['Host']?>/include/total_trans_merchant_default<?=@$data['ex'];?>?a=v2&actionAjax=sessionTrans&actionUI=trans_amt_with_sales_volume&curr=<?=@$default_currency?>','#noOfTransaction_3','0','4')" title="Click here for view the No of Transactions" data-bs-toggle="tooltip" data-bs-placement="top">
   
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['transaction'];?> text-link"></i> </span> <a style="text-decoration:none;">
        <div class="mt-3 text-white">
          <h3 id="noOfTransaction_3"><?=@$total_transactions_d;?></h3>
          <span class="p-2" title="No of Transactions">Transactions</span>
        </div>
        </a> 
	</div>

  </div>
  <div class="col p-2 cursor-pointer" onClick="ajaxf1(this,'<?=@$data['Host']?>/include/total_trans_merchant_default<?=@$data['ex'];?>?a=v2&actionAjax=sessionTrans&actionUI=trans_amt_with_sales_volume&curr=<?=@$default_currency?>','#trans_amt_3','0','4')" title="Click here for view the Transactions Amount" data-bs-toggle="tooltip" data-bs-placement="top">
    
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['amount'];?> text-link"></i> </span> <a  style="text-decoration:none;">
        <div class="mt-3 text-white">
          <h3 id="trans_amt_3">
            <?=@$post['transactionAmt'];?>
          </h3>
          <span class="py-2" title="Transaction Amount">Transactions Amount</span>
        </div>
        </a> </div>
   
  </div>
  
   <? if(isset($post['settlement_optimizer'])&&trim($post['settlement_optimizer'])&&$post['settlement_optimizer']=='manually'){ ?>
  <div class="col p-2 cursor-pointer" onClick="ajaxf1(this,'<?=@$data['Host']?>/include/total_trans_merchant_default<?=@$data['ex'];?>?a=v2&actionAjax=sessionTrans&actionUI=trans_amt_with_sales_volume&curr=<?=@$default_currency?>','#settlements_amt_3','1','4')" title="Click here for view the Settlements Amount" data-bs-toggle="tooltip" data-bs-placement="top" >
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['settlement'];?> text-link"></i> </span> <a  style="text-decoration:none;">
        <div class="mt-3 text-white">
          <h3 id="settlements_amt_3">
            <?=@$post['settlementsAmt'];?>
          </h3>
          <span class="py-2" title="Settlements">Settlements</span>
        </div>
        </a> </div>
  </div>
   <?}?>
   
  <div class="col p-2 cursor-pointer" onClick="ajaxf1(this,'<?=@$data['Host']?>/include/total_trans_merchant_default<?=@$data['ex'];?>?a=v2&actionAjax=sessionTrans&actionUI=trans_amt_with_sales_volume&curr=<?=@$default_currency?>','#refund_amt_3','1','4')" title="Click here for view the Refund Amount" data-bs-toggle="tooltip" data-bs-placement="top" >
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['refund'];?> text-link"></i> </span> <a  style="text-decoration:none;">
        <div class="mt-3 text-white">
          <h3 id="refund_amt_3">
            <?=str_replace_minus(@$post['refundAmt']);?>
          </h3>
          <span class="py-2" title="Refund Amount">Refund</span>
        </div>
        </a> </div>
  </div>
  
  <div class="col p-2 cursor-pointer" onClick="ajaxf1(this,'<?=@$data['Host']?>/include/trans_current_balance_merchant<?=@$data['ex'];?>?a=v2&actionAjax=sessionTrans&actionUI=trans_amt_with_sales_volume&curr=<?=@$default_currency?>','#total_current_balance_3','1','4')" title="Click here for view the Balance Amount" data-bs-toggle="tooltip" data-bs-placement="top" >
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['sales-volume'];?> text-link"></i> </span> <a  style="text-decoration:none;">
        <div class="mt-3 text-white">
		        
            <h3 id="total_current_balance_3">
              <?if(isset($_SESSION['uid_wv2'.$uid]['summ_total'])&&trim($_SESSION['uid_wv2'.$uid]['summ_total'])){
                echo @$_SESSION['uid_wv2'.$uid]['summ_total'];
              }else{?>
                <i class="<?=@$data['fwicon']['view'];?>"></i>
              <?}?>
            </h3>
          
          <span class="py-2" title="Balance">Balance</span>
        </div>
        </a> </div>
  </div>
  <div class="col p-2">
      <div class="rounded-tringle bg-primary"> <span class="icon1 hover-for-all"> <i class="<?=$data['fwicon']['deshboard-website'];?> text-link"></i> </span> 
        <div class="mt-3 text-white" style="margin-top: 15px;">
          <h3>
            <div class="dropdown"> <a class="dropdown-toggle border border-primary rounded px-2" data-bs-toggle="dropdown" style="cursor:pointer;font-size: 14px;" title="<?=prntext($post['company_name']);?>" >Business</a> 
              <div class="dropdown-menu " id="webmenu" aria-labelledby="dropdownMenuButton" >
                <? if($post['terminals']){
						foreach($post['terminals'] as $key=>$value){?>
                <a class="dropdown-item text-link" onclick="ajaxf1(this,'<?=@$data['Host']?>/include/total_trans_merchant_default<?=@$data['ex'];?>?a=v2&actionAjax=sessionTrans&actionUI=trans_amt_with_sales_volume&curr=<?=@$default_currency?>&wid=<?=$value['id'];?>','#trans_amt_3','0','4');"><i class="<?=$data['fwicon']['hand'];?>"></i>&nbsp;
                <?=$value['ter_name'];?>
                </a>
                <? }
					} ?>
              </div>
            </div>
          </h3>
          <span class="py-2" ><? if($post['company_name']){  echo prntext(substr($post['company_name'],0,15)); }else{ echo "&nbsp;&nbsp;";};?></span>
        </div>
        </div>
  </div>
</div>
<? $activeGraph=((isset(($_REQUEST['label']))&&($_REQUEST['label']))?($_REQUEST['label']):'Last 30 Days');
if(isset($data['post_form']['date_1st'])&&isset($data['post_form']['date_2nd'])){
$activeGraph.=" : ".$data['post_form']['date_1st']=prndatelog($data['post_form']['date_1st']);
$activeGraph.=" - ".$data['post_form']['date_2nd']=prndatelog($data['post_form']['date_2nd']);
} 
?>
			
<div class="row mt-2" >
  <div class="col-lg-12 mx-1">
    <div class="tab-content99">
      <div class="tab-pane active row px-1" id="firsttab">
      <div class="col-sm-9">	
	  <div>
	  <!--<label class="text-link fw-bold my-1 px-2">Graphical Statistics: </label>-->
	  
	  <button type="button" class="btn btn-primary btn-sm mb-1">Result <span class="badge bg-link"><?=$post['gr2_s']['count_result'];?></span></button>
	  <button type="button" class="btn btn-primary btn-sm mb-1">Total Amount <span class="badge bg-link"><?=$default_currency;?> <?=$post['gr2_s']['total_amount'];?></span></button>
	  <button type="button" class="btn btn-primary btn-sm mb-1">Success Amount <span class="badge bg-link"><?=$default_currency;?> <?=(isset($post['gr2_s']['transaction_amount'])?array_sum($post['gr2_s']['transaction_amount']):'');?></span></button>
	  <button type="button" class="btn btn-primary btn-sm mb-1">Transactions <span class="badge bg-link"><?=$post['gr2_s']['ids'];?></span></button>
  

	

    </div>  
	  

		  
		  
</div>		  
      <div class="col-sm-3 input-icons">
	  
	  <i id="date_1st_range_icon99" class="<?=$data['fwicon']['calender'];?> cals field_icon float-start text-link" style="vertical-align:-webkit-baseline-middle;" title="search by date range"></i>
<input type="text" name='date_range' id="date_1st_range" class="cole form-control form-control-sm ps-4 mb-1 float-end bg-primary text-white" >

</div>
      </div>
    </div>


    <!--<div>
	<label class="text-link fw-bold my-1 px-2">Graphical Statistics: </label>
    <label class="text-link fw-bold my-1 px-2">Result: <?=$post['gr2_s']['count_result'];?></label>
    <label class="text-link fw-bold my-1 px-2">Total Amount: <?=$default_currency;?> <?=$post['gr2_s']['total_amount'];?></label>
    <label class="text-link fw-bold my-1 px-2">Success Amount:
      <?=$default_currency;?>
      <?=(isset($post['gr2_s']['transaction_amount'])?array_sum($post['gr2_s']['transaction_amount']):'');?>
      </label>
      <label class="text-link fw-bold my-1 px-2">Transactions: <?=$post['gr2_s']['ids'];?></label>
    </div>-->
    <!--display chart on mycontainer div-->
    
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

  

});

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


<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/highcharts.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/highcharts-more.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/exporting.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/export-data.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/accessibility.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/highcharts-3d.js"></script>

<div class="row mx-1">
<div class="col-sm-8 border my-1 pt-2 rounded">

<style>
#container {
  height: 400px;
}

.highcharts-figure,
.highcharts-data-table table {
  min-width: 320px;
  max-width: 800px;
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
</style>

<figure class="highcharts-figure44">
  <div id="container"></div>

<div class="text-center my-2">
  <button id="plain" class="btn btn-sm btn-primary">Plain</button>
  <button id="inverted" class="btn btn-sm btn-primary">Inverted</button>
  <button id="polar" class="btn btn-sm btn-primary">Polar</button>
  </div>
</figure>

<script>
<?php
$s_amount_new="[";
foreach ($post['gr2_s']['transaction_amount'] as $value) {
$s_amount_new.=round($value,2).",";
}
$s_amount_new=substr($s_amount_new,0,-1)."]"; 
?>	
var activeGraph="<?=$activeGraph?>";

//  let today = new Date();
// 	document.getElementById("date").innerHTML = today;
var date_transaction=<?php echo json_encode($post['gr2_s']['date_transaction']);?>;
var transaction_amount_graphdata=<?php echo json_encode($post['gr2_s']['transaction_amount']);?>;
var s_amount=<?php echo $s_amount_new;?>;
var default_full_currency="<?php echo ($default_full_currency);?>";

const chart = Highcharts.chart('container', {
  title: {
    text: activeGraph,
    align: 'left'
  },
  subtitle: {
    text: 'Transaction Report',
    align: 'left'
  },
  xAxis: {
    categories: date_transaction
  },
  series: [{
    type: 'column',
    name: 'Success',
    colorByPoint: true,
    data: s_amount,
    showInLegend: false
  }]
});

document.getElementById('plain').addEventListener('click', () => {
  chart.update({
    chart: {
      inverted: false,
      polar: false
    },
    subtitle: {
      text: ''
    }
  });
});

document.getElementById('inverted').addEventListener('click', () => {
  chart.update({
    chart: {
      inverted: true,
      polar: false
    },
    subtitle: {
      text: ''
    }
  });
});

document.getElementById('polar').addEventListener('click', () => {
  chart.update({
    chart: {
      inverted: false,
      polar: true
    },
    subtitle: {
      text: ''
    }
  });
});
</script>

</div>
<div class="col-sm-4 border my-1 pt-2 rounded">
<figure class="highcharts-figure99">
  <div id="container_pie"></div>
</figure>
<script>
Highcharts.chart('container_pie', {
  chart: {
    type: 'pie',
    options3d: {
      enabled: true,
      alpha: 45
    }
  },
  title: {
    text: 'Transaction By Country',
    align: 'left'
  },
  subtitle: {
    text: '',
    align: 'left'
  },
  plotOptions: {
    pie: {
      innerSize: 100,
      depth: 45
    }
  },
  series: [{
    name: 'No. of Transactions',
    data: <?=$getdata;?>
  }]
});
</script>

</div>

</div>


<?php /*?>/////////////////////New Dashboard End  //////////////////<?php */?>

</div>


<script>
$(document).ready(function() {
	
	
  <?if(!isset($_SESSION['tr_sum_count']['transactionAmount'])){  ?>
		ajaxf1(this,'<?=@$data['Host']?>/include/total_trans_merchant_default<?=@$data['ex'];?>?a=v2&actionAjax=sessionTrans&actionUI=trans_amt_with_sales_volume&curr=<?=@$default_currency?>','#trans_amt_3','0','4');					
	<? } ?>

  <?
  if(!isset($_SESSION['uid_wv2'.$uid]['summ_total']))
  {  ?>
		ajaxf1(this,'<?=@$data['Host']?>/include/trans_current_balance_merchant<?=@$data['ex'];?>?a=v2&actionAjax=sessionTrans&actionUI=trans_amt_with_sales_volume&curr=<?=@$default_currency?>','#total_current_balance_3','1','4');					
	<? } ?>

});

</script>

<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
