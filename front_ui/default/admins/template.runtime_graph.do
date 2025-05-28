<? if(isset($data['ScriptLoaded'])) { ?>
<?
	global $post1, $post2;

	//echo $post['default_currency'];
	if(isset($post['default_currency'])&&$post['default_currency']){
		$default_currency=prntext(get_currency($post['default_currency']));
		$default_full_currency=prntext($post['default_currency']);
	}else{
		$default_full_currency='';
	}

	//echo $default_currency;

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


<style>


	.container1 {
		background-color: rgb(192, 192, 192);
		width: 100%;
		border-radius: 5px;
		height:14px;
		min-width:200px;
	}

	.skill {
		background: #157347;  /*var(--background-1);*/
		color: white;
		padding: 0 1px;
		text-align: right;
		font-size: 10px;
		border-radius: 5px;
		height:14px;
	}
	
	.active_div{background:#198754; color:white; width:100%} 
	.nonactive_div{background:#6c757d; color:white; width:100%} 
	.active_div:hover{background:var(--background-1); color:white;} 
	.nonactive_div:hover{background:var(--background-1); color:white;} 
	
	.wid100{
		width: 100%;
		max-width:950px;
		margin:auto;
	}
	.blkqoute{border-left-color: blue; font-variant:small-caps; font-size:16px}
	.no-width{ width:30px;}
	.desc-width{ width: calc(100% - 30px);}
</style>

<script>
////// For Display Advence Search ////////////
	$("#flush-collapseOne").addClass('show');
	$("#search_bar").addClass('show');
	$("#search_bar").removeClass('hide');
</script>
<div class="container border my-1 vkg rounded">

<?php if((isset($data['Error'])) && ($data['Error']!='')){?>
<div class="container mt-3" style="max-width:540px;">
	<div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error</strong>
		<?=prntext($data['Error'])?>
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</div>
</div>
<? } ?>

<div class="container vkg">
    <div class="row">
        <div class="col-sm-8 ">
            <h1 class="my-2"><i class="fas fa-chart-bar"></i> Runtime Graph : <span id="runDateRng" style="font-style:italic;color:#e88000;"> </span> </h1>
        </div>
        
        <div class="my-2 col-sm-4 text-end">
            <span class="form-check form-switch float-end">
                <input type="checkbox" name="autoload" vdata="autoload" id="autoload"  class="form-check-input autoload" <? if(isset($_REQUEST['autoload'])&&$_REQUEST['autoload']==1){ ?> checked="checked" title="Enable" value="1" <? } else { ?> title="Disable" value="0"  <? } ?> /> Autoload </span>

        </div>
	</div>

    
	
	

</div>

<script src="<?=$data['Host']?>/thirdpartyapp/chart/chart.js"></script>


<div class="row">
  
    <div  class="col-sm-4">
        <div id="rowGraph" class="mt-4 ms-2 p-1">

            <?/*?>
                <div class="col-sm-12">
                <div class="float-start no-width">1</div>
                <div class="float-start desc-width"><div class="container1">
                <div class="skill" style="width: 77.02%;"></div>
                <span class="me-2"><a href="transactions?date_range=2024-07-24+00%3A00%3A00+to+2024-07-30+23%3A59%3A59&amp;is_created_date_on=&amp;sortingType=1&amp;key_name=transID&amp;search_key=&amp;date_range2=7%2F24%2F24+00%3A00+-+7%2F30%2F24+23%3A59&amp;date_1st=2024-07-24+00%3A00%3A00&amp;date_2nd=2024-07-30+23%3A59%3A59&amp;date_label=Last+7+Days&amp;h=1&amp;key_name=bill_email&amp;search_key[]=devops@itio.in" target="_blank">devops@itio.in</a></span>382.01 (77.02%)
                </div></div>
                </div>							
                <div class="clearfix">&nbsp;</div>					
            <?*/?>
                    
        </div>
    </div>

    <div class="col-sm-8">
        <div style="max-width:700px;margin:auto;">
            <canvas id="durationChart" width="400" height="200"></canvas>  
            <canvas id="myChart" width="400" height="200"></canvas>
        </div>
    </div>
</div>

<div id="durationChart_divId_1" style="max-width:700px;margin:auto;">
    <?
        $runtime_graph_chart=("../front_ui/default/admins/template.runtime_graph_chart".$data['iex']);
        if(file_exists($runtime_graph_chart)&&isset($_REQUEST['date_2nd'])){
            //include($runtime_graph_chart);
        }
    ?>
</div>


<script>
var wn='';
var clear_Interval='';
var subQry='<?=@http_build_query($_REQUEST)?>';
var theUrl = '<?=@$data['Admins']?>/<?=@$data['PageFile']?><?=@$data['ex'];?>?actionAjax=ajax&'+subQry;
var theUrl2 = '<?=@$data['Admins']?>/<?=@$data['PageFile']?><?=@$data['ex'];?>?actionAjax=ajaxAutoRefresh&'+subQry;

function cli(){
    clearInterval(clear_Interval);
}

<?if(isset($_REQUEST['wn'])){  ?>
    wn='<?=@$_REQUEST['wn'];?>';
<? } ?>

if(wn=='1')
{
    window.open(theUrl+'&pq=1&dtest=2', '_blank');
}
else if(wn=='2')
{
    window.open(theUrl2+'&pq=1&dtest=2', '_blank');
}


$(document).ready(function () {
	
    


	
    <?if(!isset($_REQUEST['date_2nd'])){  ?>
        // alert(theUrl);
        /*
        if(wn)
        {
            window.open(theUrl+'&pq=1&dtest=2', '_blank');return false;
        }
        else {
            //ajaxf1(this,theUrl,'#durationChart_divId','0','4');	
            clear_Interval = setInterval(function (e) { 
                //$('#durationChart_divId').html('');
				//ajaxf1(this,theUrl,'#durationChart_divId','0','4');	
                //alert(theUrl);	
            }, 3000); // after 1 minutes = 60000 
        }
		*/				
	<? } ?>
	
});

</script>



<script>
        let durationChart;
        let data;
        let labels;
        let values;
        

        function createChart(labels, values, counts='') 
        {
            if(wn)
            {
                console.log('======createChart labels===='); console.log(labels);
                console.log('======createChart values===='); console.log(values);
            }

            const ctx = document.getElementById('durationChart').getContext('2d');
            durationChart = new Chart(ctx, {
                type: 'line', // line  || bar
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Transaction Count '+counts,
                        data: values,
                        backgroundColor: [
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(255, 159, 64, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(75, 192, 192, 1)',
                            'rgba(255, 159, 64, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        function dateRangePrnt(date_1st, date_2nd, date_dif) 
        {
            if(wn)
            {
                console.log('======dateRangePrnt===='); console.log(labels);
                console.log('======date_1st : '); console.log(date_1st);
                console.log('======date_2nd : '); console.log(date_2nd);
            }
            var runDateRng = date_1st+' - '+date_2nd+' | '+date_dif;
            $('#runDateRng').html(runDateRng);
           

        }

        function updateChart(labels, values, counts='') 
        {
            if (durationChart) 
            {
           // console.log('======updateChart labels===='); console.log(labels);
           // console.log('======updateChart values===='); console.log(values);

                durationChart.data.counts = counts;
                durationChart.data.labels = labels;
                durationChart.data.datasets[0].data = values;
                durationChart.update();
            }
        }

        function fetchDataAndUpdate() {
            $.ajax({
                url: theUrl2, // The PHP script that returns data
                method: 'GET',
                dataType: 'json', // Ensure the response is parsed as JSON
                success: function(data) {
                   // data = JSON.parse(data);
                   if(wn)
                   {
                    console.log('======ajax data====');
                    console.log(data);
                   }
                   
                    const labels = data['duration_category'];
                    const values = data['transaction_count'];
                    const counts = data['total_count'];

                    dateRangePrnt(data['date_1st'],data['date_2nd'],data['date_dif']);
                    if(wn)
                    {
                        console.log('======labels===='); console.log(labels);
                        console.log('======values===='); console.log(values);
                    }
                    updateChart(labels, values, counts);
                    $('#rowGraph').html(data['rowGraph']);
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching data:", error);
                }
            });
        }

        $(document).ready(function() {
            
            const initialCounts = <?php echo json_encode($post['total_count']); ?>;
            const initialLabels = <?php echo json_encode($post['duration_category']); ?>;
            const initialValues = <?php echo json_encode($post['transaction_count']); ?>;
            


            //console.log('======initialLabels===='); console.log(initialLabels);
            //console.log('======initialValues===='); console.log(initialValues);

            dateRangePrnt('<?=@$post['date_1st']?>','<?=@$post['date_2nd']?>','<?=@$post['date_dif']?>');
            
            createChart(initialLabels, initialValues,initialCounts);

            $('#rowGraph').html("<?=@$post['rowGraph']?>");


            //fetchDataAndUpdate();
            //clear_Interval = setInterval(fetchDataAndUpdate, 10000); // Refresh every 20000=20 seconds

            $("#autoload").click(function() {
                $("input[name='bank']").prop('checked', false);
                
                if($(this).is(':checked')) {
                    //alert('Start Autoload');
                    console.log('======Start Autoload====');
                    clear_Interval = setInterval(fetchDataAndUpdate, 10000); // Refresh every 20000=20 seconds
                }
                else
                {
                    //alert('Stop Autoload');
                    console.log('======Stop Autoload====');
                    cli();
                }
                
            });
        });
    </script>

<?/*?>
<script>
    // Sample data (replace with your data source)
let data = [10, 20, 15, 25, 22, 30];

// Create the chart
const ctx = document.getElementById('myChart').getContext('2d');
const myChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
    datasets: [{
      label: 'My Data',
      data: data,
      borderColor: 'blue',
      borderWidth: 1
    }]
  }
});

// Function to update the chart
function updateChart() {
  // Fetch new data (replace with your data fetching logic)
  data.push(Math.floor(Math.random() * 100));
  data.shift(); // Remove the first element to keep the array length constant

  // Update the chart
  myChart.data.datasets[0].data = data;
  myChart.update();
}

// Set the interval to update the chart every 5 seconds
setInterval(updateChart, 5000);

</script>

<?*/?>

</div>	
<!--==============================-->	

<? }else{?>
	SECURITY ALERT: Access Denied
<? } ?>
