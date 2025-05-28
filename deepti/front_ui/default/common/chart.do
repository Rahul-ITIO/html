<??><div class="container mt-2 mb-2 border bg-white">

<div class="row mt-2 mb-2 vkg">
<div class="col-sm-6"><h4><i class="<?=$data['fwicon']['setting'];?>"></i> Account Overview</h4></div>
<div class="col-sm-6 text-end"> <a href="<?=$data['USER_FOLDER']?>/transactions<?=$data['ex']?>" class="btn btn-primary" >Current Balance
<?=$post['ab']['summ_total'];?></a> </div>
</div> 
		
<script src="<?=$data['TEMPATH']?>/common/js/highcharts.js"></script>		
<script type="text/javascript">
var date_transaction=<?php echo json_encode($post['date_transaction']);?>;
var transaction_amount_graphdata=<?php echo json_encode($post['transaction_amount']);?>;
// alert(date_transaction);
  
  //var abc=[30,10];
 //  alert(transaction_amount_graphdata);
$(function () {
	
        $('#container').highcharts({
            title: {
                text: '',
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
				//type: 'pie',
				//type: "spline",
                name: 'Amount',
                data: transaction_amount_graphdata
            }],
			 showInLegend: true
        });
		
    });
</script>


<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</div>