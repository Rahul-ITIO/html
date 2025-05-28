<? if(isset($data['ScriptLoaded'])){
		
	if((!isset($_SESSION['login_adm']))&&(!$_SESSION['graphical_staticstics'])){
	  echo $data['OppsAdmin'];
	  exit;
	
	}
?>
<style>
a.copy{margin-top:15px;}
.canvasjs-chart-canvas{
box-shadow:0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12), 0 3px 5px -1px rgba(0, 0, 0, 0.2);
padding-top:30px;}
.canvas-header {
    height: 30px;
	width: 96.5%;
	margin: 0 auto;
	background-color: #37474F;
    border-radius: 0 !important;
    color: white;
    margin-bottom: 0;
    padding: 1rem;
	
}
.canvas-header h4{
font-weight: 400;
color:#fff;
}
.tag{display: inline-block;
padding: .25em .4em;
font-size: 75%;
font-weight: 700;
line-height: 1;
color: #fff;
text-align: center;
white-space: nowrap;
vertical-align: baseline;
border-radius: .25rem;background-color: #5cb85c;
}
.canvasjs-chart-credit{display:none;}


.ng_cal_cal_frame_table{
width:51px;
}
.ng-input-button-table {margin-right:10px;}
.ng_cal_cal_frame_table select {min-width: 120px;}
input[type="submit"]{background: #ffffff; /* Old browsers */
background: -moz-linear-gradient(top,  #ffffff 0%, #e5e5e5 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#ffffff), color-stop(100%,#e5e5e5)); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(top,  #ffffff 0%,#e5e5e5 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(top,  #ffffff 0%,#e5e5e5 100%); /* Opera 11.10+ */
background: -ms-linear-gradient(top,  #ffffff 0%,#e5e5e5 100%); /* IE10+ */
background: linear-gradient(to bottom,  #ffffff 0%,#e5e5e5 100%); /* W3C */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#e5e5e5',GradientType=0 ); /* IE6-9 */
}
.datepicker2 ,.datepicker1 {padding:5px;}
.admins.graph.bnav input[type="submit"]{vertical-align:top;margin-top:0px;}
#storeid{float:left;margin-left:5px;margin-right:5px;width:150px;color: #000;font-size: 12px;}
#store_id{width:150px; font-size:12px;}
</style>
 <? if(isset($data['ScriptLoaded'])) { ?>
   <!--  <script type="text/javascript" src="ng_all.js"></script>
   <script type="text/javascript" src="calender.js"></script>-->
 <style type="text/css">
 .ng-input-button-table .ng-button {display:none}
 ng-comp-hidden{width:50px;}
 </style>
<script>
function show_date_field()
{
var t=document.getElementById("time_period").value;
//alert (t);
    if ( t == "SELECT DATE RANGE") {
		document.getElementsByClassName('datepicker1')[0].id = 'date1';
		document.getElementById("date1").disabled=0;
		document.getElementsByClassName('datepicker2')[0].id = 'date2';
		document.getElementById("date2").disabled=0;
		} else {
		document.getElementsByClassName('datepicker1')[0].value='';
		document.getElementsByClassName('datepicker2')[0].value='';
		
		document.getElementsByClassName('datepicker1')[0].id = 'removedate1';
		document.getElementById("removedate1").disabled=1;
		document.getElementsByClassName('datepicker2')[0].id = 'removedate2';
		document.getElementById("removedate2").disabled=1;
		document.getElementById("date2").value='';
		document.getElementById("date1").value='';
    }
}


	ng.ready( function() {
		var my_cal = new ng.Calendar({
		date_format:'Y-m-d',
		input: 'date1', // the input field id
		start_date: 'last year', // the start date (default is today)
		end_date: 'year + 5', // the end date (related to start_date, 4 years from today)
		display_date: new Date(), // the display date (default is start_date)
  	 	}); 
   		var my_cal1 = new ng.Calendar({
		date_format:'Y-m-d',
		input: 'date2', // the input field id
		start_date: 'last year', // the start date (default is today)
		end_date: 'year + 5', // the end date (related to start_date, 4 years from today)
		display_date: new Date(), // the display date (default is start_date)
  		});
   });
</script>

<?php 
//Normal Graph
$dataPoints=$post['dataPoints'];
$total_amount=$post['total_amount'];

// year based Graph
  $ybgraph=$post['yeargraph'];
  $pdata=$ybgraph[0];
  $sdata=$ybgraph[1];
  $fdata=$ybgraph[2];
  $refdata=$ybgraph[3];
  $setldata=$ybgraph[4];
  $returnedata=$ybgraph[5];
  $reversedata=$ybgraph[6];
  $refundata=$ybgraph[7];
  $testdata=$ybgraph[8];
  $scrubdata=$ybgraph[9];
  $predsdata=$ybgraph[10];
  $partrefdata=$ybgraph[11];
  $wdrdata=$ybgraph[12];
  $wdrrdata=$ybgraph[13];
  
  
  // month based Graph
  $mbgraph=$post['monthgraph'];
  $mbpmdata=$mbgraph[0];
  $mbsmdata=$mbgraph[1];
  $mbfmdata=$mbgraph[2];
  $mbrefmdata=$mbgraph[3];
  $mbsetlmdata=$mbgraph[4];
  $mbreturnemdata=$mbgraph[5];
  $mbreversemdata=$mbgraph[6];
  $mbrefunmdata=$mbgraph[7];
  $mbtestmdata=$mbgraph[8];
  $mbscrubmdata=$mbgraph[9];
  $mbpredsmdata=$mbgraph[10];
  $mbpartrefmdata=$mbgraph[11];
  $mbwdrmdata=$mbgraph[12];
  $mbwdrrmdata=$mbgraph[13];
 // print_r($wdrrmdata);
 
 // daily based Graph
  $dbgraph=$post['daygraph'];
  $dbpmdata=$dbgraph[0];
  $dbsmdata=$dbgraph[1];
  $dbfmdata=$dbgraph[2];
  $dbrefmdata=$dbgraph[3];
  $dbsetlmdata=$dbgraph[4];
  $dbreturnemdata=$dbgraph[5];
  $dbreversemdata=$dbgraph[6];
  $dbrefunmdata=$dbgraph[7];
  $dbtestmdata=$dbgraph[8];
  $dbscrubmdata=$dbgraph[9];
  $dbpredsmdata=$dbgraph[10];
  $dbpartrefmdata=$dbgraph[11];
  $dbwdrmdata=$dbgraph[12];
  $dbwdrrmdata=$dbgraph[13];
 // print_r($wdrrmdata);
?>
<table class=frame width=100% border=0 cellspacing=1 cellpadding=2 >
<tr><td class=capl colspan=4>GRAPHICAL STATISTICS</td></tr></table>
<form  method='post' name='search_bar' id='search_bar' >

	<div class="graph_div">
	<!-- For Merchant ID -->
	
		
		<!-- Select by typing -->
		<script src="<?=$data['Host']?>/theme/css/chosen/chosen.jquery.min.js"></script>

		<link href="<?=$data['Host']?>/theme/css/chosen/chosen.min.css" rel="stylesheet"/>
		<div class="graph_1">	
		
		
		<select id="merchant_details" data-placeholder="Merchant name- Type or select"  class="chosen-select" name="merchant_details" style="clear:right;width:99%;" onchange='GetStoreID();'>
		<option value="">Select Merchant</option>
<?php
			$result=$post['merchant_details'];
			sort($result);
			 foreach ($result as $value) { 
				if ($value['id']!=''){
					if ($_POST['merchant_details']== $value['id']){$selected="selected";}else {$selected='';}
					if(isset($value['fullname'])&&$value['fullname'])
					$fullname = $value['fullname'];
				else 
					$fullname = $value['fname']." ".$value['lname'];
			 ?>
					<option value="<?php echo $value['id'];?>" <?=$selected;?>>[<?php echo $value['id']."] ".$value['username']." |".$fullname;?></option>
			 <?php
					}
			}
			?>
</select>
<script>
  $(".chosen-select").chosen({
  no_results_text: "Oops, nothing found!"
  });
</script>

</div>
		<!-- END Select by typing -->
		<!-- END For Merchant ID -->
		
		<!-- For STORE ID -->
		<div name="storeid" id="storeid">
			
			<?php getstoreid($_POST['merchant_details'],$ajax=''); ?>
			
		</div>
		<!-- END For STORE ID -->
		
		<!-- For Payment Type ID -->
		<select  name='transaction_type' class="transaction_type">
		<option selected value='SELECT PAYMENT TYPE'>-Payment Type-</option>
	 
	   <option  value='cn' <?php if(isset($_POST["transaction_type"])&&$_POST["transaction_type"]==cn) echo ' selected="selected"'; ?>>Card Payment</option> 
	  
	  <option  value='ch' <?php if(isset($_POST["transaction_type"])&&$_POST["transaction_type"]==ch) echo ' selected="selected"'; ?>>Check Payment</option> 
	   <option  value='af' <?php if(isset($_POST["transaction_type"])&&$_POST["transaction_type"]==af) echo ' selected="selected"'; ?>>Fund</option> 
	  
	  
	  <option  value='re' <?php if(isset($_POST["transaction_type"])&&$_POST["transaction_type"]==re) echo ' selected="selected"'; ?>>Refund</option>  
	
	  <option  value='mp' <?php if(isset($_POST["transaction_type"])&&$_POST["transaction_type"]==mp) echo ' selected="selected"'; ?>>Money Payment</option>  
	    
	  <option  value='wl' <?php if(isset($_POST["transaction_type"])&&$_POST["transaction_type"]==wl) echo ' selected="selected"'; ?>>Wallets Payment</option>
	  <option  value='wd' <?php if(isset($_POST["transaction_type"])&&$_POST["transaction_type"]==wd) echo ' selected="selected"'; ?>>Withdraw</option>  
	  <option  value='wr' <?php if(isset($_POST["transaction_type"])&&$_POST["transaction_type"]==wr) echo ' selected="selected"'; ?>>Withdraw Rolling</option> 
	
	</select>
		<!-- END For Payment Type ID -->
		
		<!-- For Payment Status -->
			<select id="payment_status" name='payment_status'
		 style=" width: 135px; font-size: 11px;" >
			<option  selected value='-1' >-Payment Status-</option>
<?php
$result=$data['TransactionStatus'];
  foreach ($result as  $key => $value) {
	if ((!empty($_POST['payment_status']))&& ($_POST['payment_status']>-1) &&($key==$_POST['payment_status'])){
	  $selected="selected";}else {$selected='';} ?>
	  		<option value="<?php echo $key;?>" <?=$selected;?>><?php echo $value;?></option>
<?php
 } ?>		</select>
		<!-- END Payment Status -->
		<div class="time_div">
		<!-- For Time Frame ID -->
			<select id="time_period" name='time_period' onChange="show_date_field();">
			<option  selected value='SELECT DATE RANGE' >-Time Frame-</option>
			<option  value='1' <?php if(isset($_POST["time_period"])&&$_POST["time_period"]==1) echo ' selected="selected"'; ?> >This Week</option>
			<option  value='2' <?php if(isset($_POST["time_period"])&&$_POST["time_period"]==2) echo ' selected="selected"'; ?> >This Month</option></option>
			<option  value='3' <?php if(isset($_POST["time_period"])&&$_POST["time_period"]==3) echo ' selected="selected"'; ?> >This Year</option>
		
		</select>
		<!-- END Time Frame ID -->
	<!--</div>
		
	<div style="width:30%; float:left; margin-top:10px; v-align:top;">-->
	<span class="time_span">-OR-</span>
		<!-- For Calender - 1-->
		<input style="height:30px !important" type="date" size="8" id="date1" class="datepicker1"   name='date_1st'  placeholder='Start Date' value='<?php echo $_POST["date_1st"] ?>' autocomplete="off">
		<!-- END For Calender - 1-->
		
		<!-- For Calender - 2-->
				<input type="date" size="8" id="date2"  class="datepicker2"  name='date_2nd' 
				 placeholder='End Date'
				  value='<?php echo ($_POST["date_2nd"]);?>' 
				  <?php // if($_POST["date_2nd"]) echo 'selected="selected"'; ?>
				   autocomplete="off" style="height:30px !important"/>
		<!-- END For Calender - 2-->
		
	
	
	
	<input type="submit" id ="SEARCH" name="SEARCH" value="Search">
	</div>		
	</div>
<table dir='ltr'  width='100%' >
<tbody>
<?if($data['Error']){?><tr><td colspan=4 class=error ><?=$data['Error']?></td></tr><?}?>
<tr><td colspan="9"><br>

<?php
  if ($dataPoints==false){echo "<center><h1>No Data to Display...</h1></center>" ;}else { ?>
  
	
	<div class="canvas-header">
		<h4>Total Amount <span class="tag tag-success" id="revenue-tag">$<?php echo $post['total_amount'];?>
		 (USD)</span></h4>
	</div>
	<div id="chartContainer" style="height: 470px; width: 99%;margin:0 auto;">
	
	
	</div>
	<?php } ?>
  
<?php if ($ybgraph!=false) { ?>
  <br><br><br><br>
  <div class="canvas-header">
		<h4>Yearly Calculation <span class="tag tag-success" id="revenue-tag">$<?php echo $post['total_amount'];?>
		 (USD)</span></h4>
	</div>
  <div id="chartContainer_Y" style="height: 470px; width: 99%;margin:0 auto;"></div><br><br>
  <?php }?>
<?php if ($mbgraph!=false){ ?>  
 <br><br><br><br>
  <div class="canvas-header">
		<h4>Monthly Calculation <span class="tag tag-success" id="revenue-tag">$<?php echo $post['total_amount'];?>
		 (USD)</span></h4>
	</div>
  <div id="chartContainer_M" style="height: 470px; width: 99%;margin:0 auto;"></div><br><br> 
<?php } ?>	
<?php if ($dbgraph!=false) { ?>
<br><br><br><br>
  <div class="canvas-header">
		<h4>Day-Wise Calculation <span class="tag tag-success" id="revenue-tag">$<?php echo $post['total_amount'];?>
		 (USD)</span></h4>
	</div>
  <div id="chartContainer_D" style="height: 470px; width: 99%;margin:0 auto;"></div><br><br> 
 <? } ?>
  <script src="<?=$data['Host']?>/js/jquery-3.1.0.min.js"></script>
  <script src="<?=$data['Host']?>/js/canvasjs.min.js"></script>
	
</td></tr>
<?php
/*<tr>
<td colspan="9">
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script type="text/javascript">
	
	
	
	var date_transaction=<?php echo json_encode($data['date_transaction']);?>;
	var transaction_amount_graphdata=<?php echo json_encode($data['transaction_amount']);?>;
// alert(date_transaction);
  
  //var abc=[30,10];
 //  alert(transaction_amount_graphdata);
$(function () {
	
        $('#container').highcharts({
            title: {
                text: 'Graphical Statistics',
                x: -20 //center
            },
            subtitle: {
                text: '',
                x: -20
            },
            xAxis: {
                categories: date_transaction
            },
            yAxis: {
                title: {
                    text: 'Amount (in $)'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: '$'
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            series: [{
                name: 'Amounts',
                data: transaction_amount_graphdata
            }]
        });
    });

    

		</script>
	
<script src="highcharts.js"></script>
<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</td>
</tr>*/?>

</tbody>

</table>
</form>
<? 

if($_POST['Search']){
	// print_r($data['date_transaction']);
   //echo "<pre>";print_r($data['transaction_amount']); echo "</pre>";
 }
 
}else{?>SECURITY ALERT: Access Denied<?}?>


  
  <script>
function getXMLHttp(){
  var xmlHttp
  try{
    //Firefox, Opera 8.0+, Safari
    xmlHttp = new XMLHttpRequest();
  }
  catch(e){
    //Internet Explorer
    try{
      xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch(e){
      try{
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      catch(e){
        alert("Your browser does not support AJAX!")
        return false;
      }
    }
  }

  return xmlHttp;
}
function GetStoreID(){
	
	 var mid=document.getElementById('merchant_details').value;
	 
 var xmlHttp = getXMLHttp();
  
  xmlHttp.onreadystatechange = function(){
    if(xmlHttp.readyState == 4){
      HandleResponse(xmlHttp.responseText);
    }
  }

  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?mid="+mid+"&action=storeid", true);
  xmlHttp.send(null);
}

function HandleResponse(response){
	document.getElementById('storeid').innerHTML = response;
}

</script>

  
 <script>
  
	
	window.onload = function () {
    var chart = new CanvasJS.Chart("chartContainer_Y", {
    	title: {
    		/*text: "Yearly Calculations"*/
    	},
    	theme: "light2",
    	animationEnabled: true,
    	toolTip:{
    		shared: true,
    		reversed: true
    	},
    	axisY: {
    		title: "Amount (USD)",
			prefix: "$",
			suffix:  "(USD)",
    		includeZero: false
    	},
    	legend: {
    		cursor: "pointer",
    		itemclick: toggleDataSeries
    	},
    	data: [
    		{
    			type: "stackedColumn",
    			name: "Pending",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($pdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Success",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($sdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Failed",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($fdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Refunded",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($refdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Settled",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($setldata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Returned",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($returnedata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Reversed",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($reversedata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Refund",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($refundata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Test",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($testdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Scrubbed",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($scrubdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Pre Dispute",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($predsdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Partial Refund",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($partrefdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Withdraw Requested",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($wdrdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Withdraw Rolling",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($wdrrdata, JSON_NUMERIC_CHECK); ?>
    		}
			
    	]
     });
     
    chart.render();
     
    function toggleDataSeries(e) {
    	if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
    		e.dataSeries.visible = false;
    	} else {
    		e.dataSeries.visible = true;
    	}
    	e.chart.render();
    }
     
    }
   
    
 $(function () {
    var TotalData = new CanvasJS.Chart("chartContainer", {
    	animationEnabled: true,
    	theme: "light1", // "light1", "light2", "dark1", "dark2"
    	title: {
    		//text: "Merchant Payment Status"
    	},
    	axisY: {
    		title: "Amount (USD)",
			prefix: "$",
			suffix:  "(USD)",
    		includeZero: false
    	},
    	data: [{
    		type: "column",
			
    		dataPoints: <?php echo json_encode($dataPoints, JSON_NUMERIC_CHECK); ?>
    	}]
    });
    TotalData.render();
     
    });
 </script>
 <script>
 // window.onload = function () {
  $(function () {
    var Mchart = new CanvasJS.Chart("chartContainer_M", {
    	title: {
    		/*text: "Monthly Calculations"*/
    	},
    	theme: "light2",
    	animationEnabled: true,
    	toolTip:{
    		shared: true,
    		reversed: true
    	},
    	axisY: {
    		title: "Amount (USD)",
			prefix: "$",
			suffix:  "(USD)",
    		includeZero: false
    	},
    	legend: {
    		cursor: "pointer",
    		itemclick: MtoggleDataSeries
    	},
    	data: [
    		{
    			type: "stackedColumn",
    			name: "Pending",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbpmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Success",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbsmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Failed",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbfmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Refunded",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbrefmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Settled",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbsetlmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Returned",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbreturnemdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Reversed",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbreversemdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Refund",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbrefunmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Test",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbtestmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Scrubbed",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbscrubmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Pre Dispute",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbpredsmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Partial Refund",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbpartrefmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Withdraw Requested",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbwdrmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Withdraw Rolling",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($mbwdrrmdata, JSON_NUMERIC_CHECK); ?>
    		}
			
    	]
     });
     
    Mchart.render();
	 function MtoggleDataSeries(e) {
    	if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
    		e.dataSeries.visible = false;
    	} else {
    		e.dataSeries.visible = true;
    	}
    	e.chart.render();
    }
	//}
	 });
	</script>
    
     <script>
 // window.onload = function () {
  $(function () {
    var Dchart = new CanvasJS.Chart("chartContainer_D", {
    	title: {
    		/*text: "Monthly Calculations"*/
    	},
    	theme: "light2",
    	animationEnabled: true,
    	toolTip:{
    		shared: true,
    		reversed: true
    	},
    	axisY: {
    		title: "Amount (USD)",
			prefix: "$",
			suffix:  "(USD)",
    		includeZero: false
    	},
    	legend: {
    		cursor: "pointer",
    		itemclick: MtoggleDataSeries
    	},
    	data: [
    		{
    			type: "stackedColumn",
    			name: "Pending",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbpmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Success",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbsmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Failed",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbfmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Refunded",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbrefmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Settled",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbsetlmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Returned",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbreturnemdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Reversed",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbreversemdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Refund",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbrefunmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Test",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbtestmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Scrubbed",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbscrubmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Pre Dispute",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbpredsmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Partial Refund",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbpartrefmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Withdraw Requested",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbwdrmdata, JSON_NUMERIC_CHECK); ?>
    		},{
    			type: "stackedColumn",
    			name: "Withdraw Rolling",
    			showInLegend: true,
    			yValueFormatNumeric: "#.## USD",
    			dataPoints: <?php echo json_encode($dbwdrrmdata, JSON_NUMERIC_CHECK); ?>
    		}
			
    	]
     });
     
    Dchart.render();
	 function MtoggleDataSeries(e) {
    	if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
    		e.dataSeries.visible = false;
    	} else {
    		e.dataSeries.visible = true;
    	}
    	e.chart.render();
    }
	//}
	 });

</script>


<?}else{?>SECURITY ALERT: Access Denied<?}?>