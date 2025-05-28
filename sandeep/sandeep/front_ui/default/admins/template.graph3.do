<? if(isset($data['ScriptLoaded'])) { ?>
<? 
	global $post1, $post2;

    //echo  $post['default_currency'];
	if(isset($post['default_currency'])&&$post['default_currency']){
		$default_currency=prntext(get_currency($post['default_currency']));
		$default_full_currency=prntext($post['default_currency']);
	}else{
		$default_full_currency='';
	}
	
	//echo  $default_currency;
	if($data['con_name']=='clk'&&empty($default_full_currency)){
		$default_full_currency='INR';
	}elseif(empty($default_full_currency)){
		$default_full_currency='USD';
	}
	
?>
<style>
.highcharts-title { font-size:14px !important; }
 #container_graph { font-size:14px !important; }
 g text *, g text {font-size: 12px !important; font-weight:normal !important;}

</style>

<script>
////// For Display Advence Search ////////////
	$("#flush-collapseOne").addClass('show');
	$("#search_bar").addClass('show');
	$("#search_bar").removeClass('hide');
</script>
<div class="container border my-1 vkg rounded">



<div class="container vkg">
    <h4 class="my-2"><i class="<?=$data['fwicon']['graphical-statistics'];?>"></i> Graphical Statistics</h4>
  </div>
  <div class="container table-responsive-sm">
      <table class="table table-hover">
        <tbody>
          <tr>
        <td>
<?php
$s_amount_new="[";
if(isset($post['transaction_amount'])&&$post['transaction_amount']){
	foreach ($post['transaction_amount'] as $value) {
		$s_amount_new.=round($value,2).",";
	}
}
$s_amount_new=substr($s_amount_new,0,-1)."]"; 
?>		  
<script type="text/javascript">
	var date_transaction=<?php echo json_encode($post['date_transaction']);?>;
	//var transaction_amount_graphdata=<?php echo json_encode($post['transaction_amount']);?>;
	var transaction_amount_graphdata=<?php echo $s_amount_new;?>;
	var default_full_currency="<?php echo ($default_full_currency);?>";

$(function () {
	
			Highcharts.setOptions({
		chart: {
			backgroundColor: {
				linearGradient: [0, 0, 500, 500],
				stops: [
					[0, '<?=$data['tc']['hd_b_l_9'];?>'], // box background color
					[1, 'rgb(240, 240, 255)']             // box background colo
				]
			},
			borderWidth: 1,
			plotBackgroundColor: '<?=$data['tc']['hd_b_l_9'];?>', // Graph area background color
			plotShadow: true,
			plotBorderWidth: 0
		}
	});
	
        $('#container_graph').highcharts({
			chart: {type: 'column'}, // column  || waterfall ||
			//chart: {renderTo: 'waterfall'}, // smallChart1  ||  waterfall
			colors: [
			"<?=$_SESSION['background_gd3']?>",  // Bar Color
			"<?=$data['tc']['hd_b_l_9']?>"
		],
            title: {
                text: 'Graphical Statistics | No. of Result: <?=$post['count_result'];?> | Total Amount: <?=$post['total_amount'];?> | No. of Trans.: <?=$post['ids'];?>',
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
                    text: 'Amount (in '+default_full_currency+')'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: ' '+default_full_currency
            },
            legend: {
                /*layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0*/
				enabled: false
            },
            series: [{
				//type: 'pie',
				//type: "spline",
                name: 'Amount',
                data: transaction_amount_graphdata
            }],
			 showInLegend: true
        });
		
    });

		</script>
          <script src="<?=$data['Host']?>/js/highcharts.js"></script>
          <div id="container_graph" ></div>
		   </td>
      </tr>
    </tbody>
  </table>
  </div>

</div>
<? }else{?>
SECURITY ALERT: Access Denied
<? } ?>

