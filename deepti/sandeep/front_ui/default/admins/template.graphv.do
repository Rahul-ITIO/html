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
	<h1 class="my-2"><i class="fas fa-chart-bar"></i> Graphical Statistics</h1>
</div>
<? if(isset($_REQUEST['merchant_details'])&&count($_REQUEST['merchant_details']) > 0) { ?>
<h3 class="px-2">Merchant Details : <? foreach ($_REQUEST['merchant_details'] as $mname) { echo get_clients_username($mname)." , ";} ?> </h3>
<? } ?>
		<?php
//		print_r($post);
//		print_r($post2);
		
		$s_amount_new="[";
		foreach ($post['transaction_amount'] as $value) {
			$s_amount_new.=round($value,2).",";
		}
		$s_amount_new=substr($s_amount_new,0,-1)."]"; 

	//for merchant wise
		$s_amount_new_mer="[";
		foreach ($post1['transaction_amount'] as $value) {
			$s_amount_new_mer.=round($value,2).",";
		}
		$s_amount_new_mer=substr($s_amount_new_mer,0,-1)."]"; 

	//for store wise
		$s_amount_new_store="[";
		foreach ($post2['transaction_amount'] as $value) {
			$s_amount_new_store.=round($value,2).",";
		}
		$s_amount_new_store=substr($s_amount_new_store,0,-1)."]"; 

		?>
		<script type="text/javascript">
		var date_transaction=<?php echo json_encode($post['date_transaction']);?>;
		var transaction_amount_graphdata=<?php echo $s_amount_new;?>;
		var default_full_currency="<?php echo ($default_full_currency);?>";


		//merchant wise
		var merID_arr=<?php echo json_encode($post1['merID_arr']);?>;
		var transaction_amount_graph_mer=<?php echo $s_amount_new_mer;?>;

		//store wise
		var terNO_id_arr=<?php echo json_encode($post2['terNO_id_arr']);?>;
		var transaction_amount_graph_store=<?php echo $s_amount_new_store;?>;

		
		</script>
		

<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/highcharts.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/highcharts-more.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/exporting.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/export-data.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/accessibility.js"></script>
<script src="<?=$data['Host']?>/thirdpartyapp/highcharts/highcharts-3d.js"></script>


<? if(isset($_REQUEST['SEARCH'])&&$_REQUEST['SEARCH']){ ?>

<!--==============================-->
<div class="row mx-1">

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

<div class="col-sm-12 border my-1 pt-2 rounded">



<figure class="highcharts-figure44">
  <div id="container_graph"></div>
<script>


var activeGraph="Graphical Statistics | No. of Result: <?=$post['count_result'];?> | Total Amount: <?=$post['total_amount'];?> | No. of Trans.: <?=$post['ids'];?>";



const chart3 = Highcharts.chart('container_graph', {
  title: {
    text: activeGraph,
    align: 'left'
  },
  subtitle: {
    text: 'Today <?=date("d/m/Y H:i:s");?>',
    align: 'left'
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
  series: [{
    type: 'column',
    name: 'Success',
    colorByPoint: true,
    data: transaction_amount_graphdata,
    showInLegend: false
  }]
});



</script>

</div>



<div class="col-sm-12 border my-1 pt-2 rounded">



<figure class="highcharts-figure44">
  <div id="container"></div>

<?php /*?><!--<div class="text-center my-2">
  <button id="plain" class="btn btn-sm btn-primary">Plain</button>
  <button id="inverted" class="btn btn-sm btn-primary">Inverted</button>
  <button id="polar" class="btn btn-sm btn-primary">Polar</button>
  </div>
</figure>--><?php */?>

<script>

var activeGraph="Graphical Statistics (Merchant wise) | No. of Result: <?=$post1['count_result'];?> | Total Amount: <?=$post1['total_amount'];?> | No. of Trans.: <?=$post1['ids'];?>";



const chart = Highcharts.chart('container', {
  title: {
    text: activeGraph,
    align: 'left'
  },
  subtitle: {
    text: 'Today <?=date("d/m/Y H:i:s");?>',
    align: 'left'
  },
  xAxis: {
    categories: merID_arr
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
  series: [{
    type: 'column',
    name: 'Success',
    colorByPoint: true,
    data: transaction_amount_graph_mer,
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


<div class="col-sm-12 border my-1 pt-2 rounded">



<figure class="highcharts-figure44">
  <div id="container-stores"></div>

</figure>

<script>
var activeGraph="Graphical Statistics (Business wise) | No. of Result: <?=$post2['count_result'];?> | Total Amount: <?=$post2['total_amount'];?> | No. of Trans.: <?=$post2['ids'];?>";




const chart1 = Highcharts.chart('container-stores', { 
  title: {
    text: activeGraph,
    align: 'left'
  },
  subtitle: {
    text: 'Today <?=date("d/m/Y H:i:s");?>',
    align: 'left'
  },
  xAxis: {
    categories: terNO_id_arr
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
  series: [{
    type: 'column',
    name: 'Success',
    colorByPoint: true,
    data: transaction_amount_graph_store,
    showInLegend: false
  }]
});


</script>

</div>



<?
$s_amount_new_mer=str_replace("[","",$s_amount_new_mer);
$s_amount_new_mer=str_replace("]","",$s_amount_new_mer);
$amt_pec = explode(",", $s_amount_new_mer);
$i=0;	
?>
<? 
$storedata="[" ;
foreach ($post1['merID_arr'] as $storeid_g) { 
//[ ['27' , 2 , 10],['111' , 3 , 10] ,['500' , 5 , 50]]
$pec = explode(" (", substr($storeid_g,0,-1));

$storedata.="[ '".get_clients_username($pec[0])." :: Trans Amt [".$amt_pec[$i]."] "."' , ".$pec[1]." ],";

$i++;
} 
$storedata.="]" ;
//echo $storedata;
$storedata=substr($storedata,0,-2).']';
?>

<div class="col-sm-12 my-1 border  p-1 rounded">
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
    text: 'Graphical Statistics (Merchant wise) | Total Merchant: <?=$post1['count_result'];?> | No. of Trans.: <?=$post1['ids'];?>',
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
    data: <?=$storedata;?>
  }]
});
</script>

</div>




</div>	
<!--==============================-->	

<? }else{ ?>
<div class="alert alert-primary" role="alert">
  search to make your search results graph
</div>
<a class="btn btn-primary my-1" href="?SEARCH=SEARCH" title="Click for display all Records">View All</a>
<? } ?>
	
</div>
<? }else{?>
	SECURITY ALERT: Access Denied
<? } ?>
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

function HandleResponse(response){
	document.getElementById('account_ids').innerHTML = response;
}

setTimeout(function(){ 
$('.highcharts-credits').css('display', 'none');
},100); 
</script>