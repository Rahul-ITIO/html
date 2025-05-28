<? if(isset($data['ScriptLoaded'])){ ?>
<?
// Added For Fetch and update color from db
$domain_server=$_SESSION['domain_server'];

if(isset($domain_server['subadmin']['stats_success_color'])){ 
$stats_success_color=$domain_server['subadmin']['stats_success_color'];
}else{
$stats_success_color=$_SESSION['background_gd3'];
}
if(isset($domain_server['subadmin']['stats_failed_color'])){ 
$stats_failed_color=$domain_server['subadmin']['stats_failed_color'];
}else{
$stats_failed_color=$_SESSION['background_gl5'];
}
$getact=((isset($_REQUEST['act']) &&$_REQUEST['act'])?$_REQUEST['act']:'1');

if($getact==2){
$g_title="Last 30 Days";
}elseif($getact==3){
$g_title="Last 365 Days";
}elseif($getact==4){
$g_title="Overall Transaction";
}else{
$g_title="Last 7 Days";
}
?>

			
<div id="zink_id" class="container border my-2 bg-primary rounded">

  <h4 class="mt-2"><i class="<?=$data['fwicon']['chart'];?>"></i> Success Ratio</h4>
  
  <? if(isset($_SESSION['display_msg'])){ ?>
	 <div class="alert alert-info alert-dismissible fade show my-2" role="alert"> <strong>Success !</strong>
      <?=$_SESSION['display_msg'];?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
	<? unset($_SESSION['display_msg']);} ?>

			
  <form method="post">
  <input type="hidden" name="action" value="stats_color" />
  <input type="hidden" name="act" value="<?=(isset($_REQUEST['act'])?$_REQUEST['act']:'');?>" />
    <button type="submit" name="sent"  class="btn btn-primary float-end" title="Change Stats Color" >&nbsp;<i class="<?=$data['fwicon']['edit'];?>"></i>&nbsp;</button>
	
    <div class="input-group float-end me-1 border-mobile" style="width: 55px;"> 
     <input type="color" name="stats_failed_color" id="stats_failed_color" title="Failed Color" class="form-control form-control-color bg-primary"  value="<?=$stats_failed_color;?>" required /></div>
	 
    <div class="input-group float-end me-1 border-mobile" style="width: 55px;">  
     <input type="color" name="stats_success_color" id="stats_success_color" title="Success Color" class="form-control form-control-color bg-primary" value="<?=$stats_success_color;?>" required /></div>
	 

  </form> 
  <select name="trans_period" id="trans_period" class="form-select float-end mx-1"  data-bs-toggle="tooltip" data-bs-placement="left" title="Select Period" onchange="if (this.value) window.location.href=this.value" style="width: 150px;">
              <option value="?act=1" data-value="1">Last 7 Days</option>
              <option value="?act=2" data-value="2">Last 30 Days</option>
              <option value="?act=3" data-value="3">Last 365 Days</option>
              <option value="?act=4" data-value="4">Overall Transaction</option>
            </select>  
         <?php if(isset($getact)&&$getact){ ?>
          <script>$('#trans_period option[data-value="<?=prntext($getact)?>"]').prop('selected','selected');</script>
		  <? }?>
  <div class="clearfix">&nbsp;</div>
  
  
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
    text: '<?=$g_title;?>',
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
        enabled: false
      },
      showInLegend: true
    }
  },
  series: [{
    name: 'Ratio',
    colorByPoint: true,
    data: [{
      name: 'Success',
      y: 74.77,
      sliced: true,
      selected: true
    }, {
      name: 'Fail',
      y: 12.82
    }]
  }]
});
</script>
  
</div>

<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
