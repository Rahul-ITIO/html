<? if(isset($data['ScriptLoaded'])) { ?>
<?
if((!isset($_SESSION['login_adm']))&&((!isset($_SESSION['transaction_staticstics']))||(isset($_SESSION['transaction_staticstics'])&&$_SESSION['transaction_staticstics']==0))){
	//$_SESSION['redirectUrl']=$data['urlpath'];
	//header("Location:{$data['Admins']}/login".$data['iex']);
?>
<div class="alert alert-danger alert-dismissible fade show m-2 text-center" role="alert">
  <strong>Access Denied</strong> 
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<?
	exit;
}

?>
<script>
////// For Display Advence Search ////////////
	$("#flush-collapseOne").addClass('show');
</script>
<style>
.ng_input_button_table input {margin:0px;outline:none;min-width:264px;}

.ng_cal_cal_frame_table{width:51px;}
.ng_cal_cal_frame_table select {min-width: 120px;}
input[type="submit"]{background: #ffffff; /* Old browsers */
background: -moz-linear-gradient(top, #ffffff 0%, #e5e5e5 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#ffffff), color-stop(100%,#e5e5e5)); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(top, #ffffff 0%,#e5e5e5 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(top, #ffffff 0%,#e5e5e5 100%); /* Opera 11.10+ */
background: -ms-linear-gradient(top, #ffffff 0%,#e5e5e5 100%); /* IE10+ */
background: linear-gradient(to bottom, #ffffff 0%,#e5e5e5 100%); /* W3C */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#e5e5e5',GradientType=0 ); /* IE6-9 */
}
.datepicker2 ,.datepicker1 {padding:5px;}
.admins.graph.bnav input[type="submit"]{vertical-align:top;margin-top:0px;}
#storeid{float:left;margin-left:10px;margin-right:20px;width:215px;color: #000;font-size: 15px;}
</style>
<div class="container border  my-1 vkg rounded">

<div class="container vkg">
    <h4 class="my-2"><i class="<?=$data['fwicon']['transaction-statistics'];?>"></i> Transaction Statistics</h4>
  </div>


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
<?
if(isset($data['TransactionsList'])&&$data['TransactionsList'])
{
	$top_limit = 10;
	
	if(isset($_GET['top_rec'])&&$_GET['top_rec']) $top_limit = $_GET['top_rec'];
	
	$emailAMT = $emailCNT = $binAMT = $binCNT = $countryAMT = $countryCNT = $ipAMT = $ipCNT = array();	
	$total_AMT = $tot_count = 0;

	$largestAMT = array();
	for($i=0;$i<count($data['TransactionsList']);$i++)
	{
		$transactions_detail = $data['TransactionsList'][$i];
	
		if(isset($transactions_detail['status'])&&($transactions_detail['status']==1 || $transactions_detail['status']==7))
			$amount = $transactions_detail['transaction_amt'];
		else
		$amount = $transactions_detail['oamount']; //change from amount to oamount
			
	
		$amount = stringToNumber($amount);	//fetch only values -- remove currency symbol and special char

		$tot_count++;	//get total records exists
		$total_AMT = $total_AMT+($amount);	//get total trasaction amount
	
		$bill_email	= $transactions_detail['bill_email']; // change from $transactions_detail['bill_email'];
		$country	= $transactions_detail['bill_country']; //changed
		$ip			= $transactions_detail['bill_ip'];
		$bin_no		= $transactions_detail['bin_no'];
		$trname		= $transactions_detail['trans_type'];
		$transaction_id= $transactions_detail['transID'];

		if($trname!='wd'&&$trname!='wr') $largestAMT[$transaction_id]=$amount;

		//group by bill_email
		if($bill_email)
		{
			if(isset($emailAMT[$bill_email])){ 
				$emailAMT[$bill_email] = $emailAMT[$bill_email]+($amount);
				$emailCNT[$bill_email]++;
			}
			else{ 
				$emailAMT[$bill_email] = ($amount);
				$emailCNT[$bill_email] =1;
			}
		}
		//group by bin_no
		if($bin_no)
		{
			if(isset($binAMT[$bin_no])){ 
				$binAMT[$bin_no] = $binAMT[$bin_no]+($amount);
				$binCNT[$bin_no]++;
			}
			else{ 
				$binAMT[$bin_no] = ($amount);
				$binCNT[$bin_no] =1;
			}
		}
		
		//group by country
		if($country)
		{
			if(isset($countryAMT[$country])){ 
				$countryAMT[$country] = $countryAMT[$country]+($amount);
				$countryCNT[$country]++;
			}
			else{ 
				$countryAMT[$country] = ($amount);
				$countryCNT[$country] =1;
			}
		}
		//group by IP
		if($ip)
		{
			if(isset($ipAMT[$ip])){ 
				$ipAMT[$ip] = $ipAMT[$ip]+($amount);
				$ipCNT[$ip]++;
			}
			else{ 
				$ipAMT[$ip] = ($amount);
				$ipCNT[$ip] =1;
			}
		}
	}
	        if(isset($_REQUEST['top_rec'])) unset($_REQUEST['top_rec']);
			$get=http_build_query($_REQUEST);
			$url="transactiongraph".$data['ex']."?".$get;
			$tr_url="transactions".$data['ex']."?".$get;
	?>
	<div class="row mx-2">
	<div class="col" style="max-width:110px;">
	        <div onclick="hide_graph_tr('by_amount')" id="amt" class="btn active_div">Amount <br />
(<?=number_format($total_AMT,2);?>)</div>
	</div>
	<div class="col" style="max-width:110px;">		
			<div onclick="hide_graph_tr('by_count')" id="cnt" class="btn nonactive_div">Count <br />
(<?=number_format($tot_count);?>)</div>
	</div>
	<div class="col" style="max-width:100px;"> 

	<div class="col-auto">
<select name="top_rec" id="top_rec" class="form-select form-select-sm" onchange="javascript:location.href='<?=$url?>&top_rec='+this.value" >
					<option value="10">10</option>
					<option value="25">25</option>
					<option value="50">50</option>
					<option value="100">100</option>
					<option value="500">500</option>
					<option value="1000">1000</option>
				    </select> </div>
					No. of Records
	
	
	</div>
				<?
				if(isset($top_limit)&&$top_limit)
				{
				?>
				<script>
					$('#top_rec option[value="<?=$top_limit?>"]').prop('selected','selected');
				</script>
				<?
				}
				?></div>

	
	
	
	
<div class="row mx-2" id='by_amount'>

<div class="col-sm-6  border px-2 rounded my-2">
<h2 class="my-2">Email</h2>
<div class="row">
<?
				arsort($emailAMT);

				$tot_per = 0;
				$tot_amt = 0;
				$ct = 1;
				foreach($emailAMT as $x => $x_value) {
					$email_name = $x;
					$trans_amt = $x_value;

					$amt_per = (($trans_amt*100)/$total_AMT);
					$amt_per = number_format($amt_per,2);
					$tot_per = $tot_per+$amt_per;

					$tot_amt = $tot_amt+$trans_amt;
					
					$email_name = '<a href="'.$tr_url.'&key_name=bill_email&search_key[]='.$email_name.'" target="_blank">'.$email_name.'</a>';
					?>
					
<div class="col-sm-12">
<div class="float-start no-width"><?=($ct++);?></div>
<div class="float-start desc-width"><div class="container1">
<div class="skill" style="width: <?=$amt_per?>%;"></div>
<span class="me-2"><?=$email_name;?></span><?=number_format($x_value,2);?> (<?=$amt_per?>%)
</div></div>
</div>							
<div class="clearfix">&nbsp;</div>					


<?
					if($ct>$top_limit) break;
				}
				$other_per = number_format((100-$tot_per),2);
				$other_amt = number_format(($total_AMT-$tot_amt),2);

				if($other_amt>'0.00')
				{
				?>

<div class="col-sm-12">
<div class="float-start no-width">&nbsp;</div>
<div class="float-start desc-width"><div class="container1"><div class="skill" style="width: <?=$other_per?>%;"></div>
<span class="me-2">Other</span><?=$other_amt;?> (<?=$amt_per?>%)
</div></div>
</div>
<div class="clearfix">&nbsp;</div>

	<? } ?>


</div>
</div>

<div class="col-sm-6  border px-2 rounded  my-2">
<h2 class="my-2">Card BIN</h2>
<div class="row">
<?
			
				arsort($binAMT);

				$tot_per = 0;
				$tot_amt = 0;
				$ct = 1;
				foreach($binAMT as $x => $x_value) {
					$bin_name = $x;
					$trans_amt = $x_value;

					$amt_per = (($trans_amt*100)/$total_AMT);
					$amt_per = number_format($amt_per,2);
					$tot_per = $tot_per+$amt_per;

					$tot_amt = $tot_amt+$trans_amt;
					
					$bin_name = '<a href="'.$tr_url.'&key_name=bin_no&search_key[]='.$bin_name.'" target="_blank">'.$bin_name.'</a>';
					?>
					
					
<div class="col-sm-12">					
<div class="float-start no-width"><?=($ct++);?></div>
<div class="float-start desc-width"><div class="container1">
<div class="skill" style="width: <?=$amt_per?>%;"></div>
<span class="me-2"><?=$bin_name;?></span><?=number_format($x_value,2);?> (<?=$amt_per?>%)
</div></div>
</div>						
<div class="clearfix">&nbsp;</div>						

                <?
				if($ct>$top_limit) break;
				}
				$other_per = number_format((100-$tot_per),2);
				$other_amt = number_format(($total_AMT-$tot_amt),2);
				if($other_amt>'0.00')
				{
				?>
				
<div class="col-sm-12">
<div class="float-start no-width">&nbsp;</div>
<div class="float-start desc-width"><div class="container1"><div class="skill" style="width: <?=$other_per?>%;"></div>
<span class="me-2">Other</span> <?=$other_amt;?> (<?=$other_per?>%)
</div></div>
</div>
<div class="clearfix">&nbsp;</div>
				

	<? } ?>

</div>

</div>

<div class="col-sm-6  border px-2 rounded  my-2">
<h2 class="my-2">Country</h2>
<div class="row">
                <?
				arsort($countryAMT);
				$tot_per = 0;
				$tot_amt = 0;
				$ct = 1;
				foreach($countryAMT as $x => $x_value) {
					$country_name = $x;
					$trans_amt = $x_value;
					$amt_per = (($trans_amt*100)/$total_AMT);
					$amt_per = number_format($amt_per,2);
					$tot_per = $tot_per+$amt_per;
					$tot_amt = $tot_amt+$trans_amt;
					if($amt_per >100){$amt_per=100;}
					$country_name = '<a href="'.$tr_url.'&key_name=country&search_key[]='.$country_name.'" target="_blank">'.$country_name.'</a>';
					?>
					
<div class="col-sm-12">					
<div class="float-start no-width"><?=($ct++);?></div>
<div class="float-start desc-width"><div class="container1">
<div class="skill" style="width: <?=$amt_per?>%;"></div>
<span class="me-2"><?=$country_name;?></span><?=number_format($x_value,2);?> (<?=$amt_per?>%)
</div></div>
</div>						
<div class="clearfix">&nbsp;</div>						
					

                <?
				if($ct > $top_limit) break;
				}
				$other_per = number_format((100-$tot_per),2);
				$other_amt = number_format(($total_AMT-$tot_amt),2);
				if($other_amt > '0.00')
				{
				
				?>
	
<div class="col-sm-12">
<div class="float-start no-width">&nbsp;</div>
<div class="float-start desc-width"><div class="container1"><div class="skill" style="width: <?=$other_per?>%;"></div>
<span class="me-2">Other</span> <?=$other_amt;?> (<?=$other_per?>%)
</div></div>
</div>
<div class="clearfix">&nbsp;</div>	
	
	<? } ?>

</div>

</div>

<div class="col-sm-6  border px-2 rounded  my-2">
<h2 class="my-2">IP</h2>
<div class="row">
<?
				arsort($ipAMT);

				$tot_per = 0;
				$tot_amt = 0;
				$ct = 1;
				foreach($ipAMT as $x => $x_value) {
					$ip_name = $x;
					$trans_amt = $x_value;

					$amt_per = (($trans_amt*100)/$total_AMT);
					$amt_per = number_format($amt_per,2);
					$tot_per = $tot_per+$amt_per;

					$tot_amt = $tot_amt+$trans_amt;
					
					$ip_name = '<a href="'.$tr_url.'&key_name=ip&search_key[]='.$ip_name.'" target="_blank">'.$ip_name.'</a>';
					?>

<div class="col-sm-12">					
<div class="float-start no-width"><?=($ct++);?></div>
<div class="float-start desc-width"><div class="container1">
<div class="skill" style="width: <?=$amt_per?>%;"></div>
<span class="me-2"><?=$ip_name;?></span><?=number_format($x_value,2);?> (<?=$amt_per?>%)
</div></div>
</div>						
<div class="clearfix">&nbsp;</div>	

	            <?
					if($ct>$top_limit) break;
				}
				$other_per = number_format((100-$tot_per),2);
				$other_amt = number_format(($total_AMT-$tot_amt),2);
				if($other_amt>'0.00')
				{
				?>

<div class="col-sm-12">
<div class="float-start no-width">&nbsp;</div>
<div class="float-start desc-width"><div class="container1"><div class="skill" style="width: <?=$other_per?>%;"></div>
<span class="me-2">Other</span> <?=$other_amt;?> (<?=$other_per?>%)
</div></div>
</div>
<div class="clearfix">&nbsp;</div>	

	<? } ?>

</div>

</div>


<div class="col-sm-6  border px-2 rounded  my-2">
<h2 class="my-2">Biggest Amount</h2>
<div class="row">
<?
				arsort($largestAMT);

				$tot_per = 0;
				$tot_amt = 0;
				$ct = 1;
				foreach($largestAMT as $x => $x_value) {
					$transaction_id = $x;
					$trans_amt = $x_value;

					$amt_per = (($trans_amt*100)/$total_AMT);
					$amt_per = number_format($amt_per,2);
					$tot_per = $tot_per+$amt_per;

					$tot_amt = $tot_amt+$trans_amt;

					$country_name = '<a href="'.$tr_url.'&key_name=country&search_key[]='.$country_name.'" target="_blank">'.$country_name.'</a>';
					?>


<div class="col-sm-12">					
<div class="float-start no-width"><?=($ct++);?></div>
<div class="float-start desc-width"><div class="container1">
<div class="skill" style="width: <?=$amt_per?>%;"></div>
<span class="me-2"><?=$transaction_id;?></span><?=number_format($x_value,2);?> (<?=$amt_per?>%)
</div></div>
</div>						
<div class="clearfix">&nbsp;</div>	            	
					
					
				<?
				if($ct>$top_limit) break;
				}
				$other_per = number_format((100-$tot_per),2);
				$other_amt = number_format(($total_AMT-$tot_amt),2);
				if($other_amt>'0.00')
				{
				?>

<div class="col-sm-12">
<div class="float-start no-width">&nbsp;</div>
<div class="float-start desc-width"><div class="container1"><div class="skill" style="width: <?=$other_per?>%;"></div>
<span class="me-2">Other</span> <?=$other_amt;?> (<?=$other_per?>%)
</div></div>
</div>
<div class="clearfix">&nbsp;</div>

	<? } ?>

</div>

</div>




</div>

<div class="row mx-2" id='by_count' style="display:none;">

<div class="col-sm-6 border px-3 rounded  my-2">
<h2 class="my-2">Email</h2>
<div class="row">
<?
				arsort($emailCNT);

				$tot_per = 0;
				$tot_amt = 0;
				$ct = 1;
				foreach($emailCNT as $x => $x_value) {
					$email_name = $x;
					$trans_amt = $x_value;

					$amt_per = (($trans_amt*100)/$tot_count);
					$amt_per = number_format($amt_per,2);
					$tot_per = $tot_per+$amt_per;

					$tot_amt = $tot_amt+$trans_amt;

					$email_name = '<a href="'.$tr_url.'&key_name=bill_email&search_key[]='.$email_name.'" target="_blank">'.$email_name.'</a>';
					?>

<div class="col-sm-12">
<div class="float-start no-width"><?=($ct++);?></div>
<div class="float-start desc-width"><div class="container1">
<div class="skill" style="width: <?=$amt_per?>%;"></div>
<span class="me-2"><?=$email_name;?></span><?=number_format($x_value,2);?> (<?=$amt_per?>%)
</div></div>
</div>							
<div class="clearfix">&nbsp;</div>

<?
					if($ct>$top_limit) break;
				}
				$other_per = number_format((100-$tot_per),2);
				$other_amt = $tot_count-$tot_amt;
				?>


<div class="col-sm-12">
<div class="float-start no-width">&nbsp;</div>
<div class="float-start desc-width"><div class="container1"><div class="skill" style="width: <?=$other_per?>%;"></div>
<span class="me-2">Other</span><?=$other_amt;?> (<?=$other_per?>%)
</div></div>
</div>
<div class="clearfix">&nbsp;</div>

	

</div>

</div>

<div class="col-sm-6 border px-3 rounded  my-2">
<h2 class="my-2">Card BIN</h2>
<div class="row">
<?
				arsort($binCNT);

				$tot_per = 0;
				$tot_amt = 0;
				$ct = 1;
				foreach($binCNT as $x => $x_value) {
					$bin_name = $x;
					$trans_amt = $x_value;
					$amt_per = (($trans_amt*100)/$tot_count);
					$amt_per = number_format($amt_per,2);
					$tot_per = $tot_per+$amt_per;

					$tot_amt = $tot_amt+$trans_amt;
					$bin_name = '<a href="'.$tr_url.'&key_name=bin_no&search_key[]='.$bin_name.'" target="_blank">'.$bin_name.'</a>';
					?>

<div class="col-sm-12">
<div class="float-start no-width"><?=($ct++);?></div>
<div class="float-start desc-width"><div class="container1">
<div class="skill" style="width: <?=$amt_per?>%;"></div>
<span class="me-2"><?=$bin_name;?></span><?=number_format($x_value,2);?> (<?=$amt_per?>%)
</div></div>
</div>							
<div class="clearfix">&nbsp;</div>


<?
					if($ct>$top_limit) break;
				}
				$other_per = number_format((100-$tot_per),2);
				$other_amt = $tot_count-$tot_amt;
				?>

<div class="col-sm-12">
<div class="float-start no-width">&nbsp;</div>
<div class="float-start desc-width"><div class="container1"><div class="skill" style="width: <?=$other_per?>%;"></div>
<span class="me-2">Other</span><?=$other_amt;?> (<?=$other_per?>%)
</div></div>
</div>
<div class="clearfix">&nbsp;</div>

</div>

</div>

<div class="col-sm-6 border px-3 rounded  my-2">
<h2 class="my-2">Country</h2>
<div class="row">
<?
				arsort($countryCNT);

				$tot_per = 0;
				$tot_amt = 0;
				$ct = 1;
				foreach($countryCNT as $x => $x_value) {
					$country_name = $x;
					$trans_amt = $x_value;

					$amt_per = (($trans_amt*100)/$tot_count);
					$amt_per = number_format($amt_per,2);
					$tot_per = $tot_per+$amt_per;

					$tot_amt = $tot_amt+$trans_amt;

					$country_name = '<a href="'.$tr_url.'&key_name=country&search_key[]='.$country_name.'" target="_blank">'.$country_name.'</a>';
					?>

<div class="col-sm-12">
<div class="float-start no-width"><?=($ct++);?></div>
<div class="float-start desc-width"><div class="container1">
<div class="skill" style="width: <?=$amt_per?>%;"></div>
<span class="me-2"><?=$country_name;?></span><?=number_format($x_value,2);?> (<?=$amt_per?>%)
</div></div>
</div>							
<div class="clearfix">&nbsp;</div>

<?
					if($ct>$top_limit) break;
				}
				$other_per = number_format((100-$tot_per),2);
				$other_amt = $tot_count-$tot_amt;
				?>

<div class="col-sm-12">
<div class="float-start no-width">&nbsp;</div>
<div class="float-start desc-width"><div class="container1"><div class="skill" style="width: <?=$other_per?>%;"></div>
<span class="me-2">Other</span><?=$other_amt;?> (<?=$other_per?>%)
</div></div>
</div>
<div class="clearfix">&nbsp;</div>

</div>

</div>

<div class="col-sm-6 border px-3 rounded  my-2">
<h2 class="my-2">IP</h2>
<div class="row">
<?
				arsort($ipCNT);

				$tot_per = 0;
				$tot_amt = 0;
				$ct = 1;
				foreach($ipCNT as $x => $x_value) {
					$ip_name = $x;
					$trans_amt = $x_value;

					$amt_per = (($trans_amt*100)/$tot_count);
					$amt_per = number_format($amt_per,2);
					$tot_per = $tot_per+$amt_per;

					$tot_amt = $tot_amt+$trans_amt;

					$ip_name = '<a href="'.$tr_url.'&key_name=ip&search_key[]='.$ip_name.'" target="_blank">'.$ip_name.'</a>';

					?>

<div class="col-sm-12">
<div class="float-start no-width"><?=($ct++);?></div>
<div class="float-start desc-width"><div class="container1">
<div class="skill" style="width: <?=$amt_per?>%;"></div>
<span class="me-2"><?=$ip_name;?></span><?=number_format($x_value,2);?> (<?=$amt_per?>%)
</div></div>
</div>							
<div class="clearfix">&nbsp;</div>

                <?
				if($ct>$top_limit) break;
				}
				$other_per = number_format((100-$tot_per),2);
				$other_amt = $tot_count-$tot_amt;
				?>


<div class="col-sm-12">
<div class="float-start no-width">&nbsp;</div>
<div class="float-start desc-width"><div class="container1"><div class="skill" style="width: <?=$other_per?>%;"></div>
<span class="me-2">Other</span><?=$other_amt;?> (<?=$other_per?>%)
</div></div>
</div>
<div class="clearfix">&nbsp;</div>

</div>

</div>

</div>

</div>

<? 
} 

?>
</div></div>
<?
}else{?>
	SECURITY ALERT: Access Denied
<?
}

?>
<script>
function hide_graph_tr(theValue)
{
	//alert(theValue);
	if(theValue=='by_amount')
	{
		document.getElementById('by_amount').style.display = '';	// Show
		document.getElementById('by_count').style.display = 'none';		// Hide
		document.getElementById('amt').className = 'btn active_div';
		document.getElementById('cnt').className = 'btn nonactive_div';
	}
	else if(theValue=='by_count')
	{
		document.getElementById('by_count').style.display = '';	// Show
		document.getElementById('by_amount').style.display = 'none';	// Hide
		document.getElementById('amt').className = 'btn nonactive_div';
		document.getElementById('cnt').className = 'btn active_div';
	}
}
</script>
