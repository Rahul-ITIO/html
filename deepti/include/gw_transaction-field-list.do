<??>
	<textarea name="csv_q" data-fs="dev" style="display:none !important"><?=(isset($data['tr_counts_q_csv'])?$data['tr_counts_q_csv']:$post['tr_counts_q']);?></textarea>
	<?
	if($data['con_name']=='clk'){
		//$clk_field_list7=(,'gst_amt'=>'GST Fee');
	}else{
		//$clk_field_list7="";
	}
	 
	$field_list7 = array('transID'=>'transID', 'trans_status'=>'Trans Status', 'acquirer'=>'Acquirer','type_not_3'=>'Type Not Withdraw Rolling', 'fullname'=>'Full Name', 'bill_email'=>'Bill email', 'bill_amt'=>'Bill Amount', 'trans_amt'=>'Trans Amt', 'buy_mdr_amt'=>'Buy MDR Amt', 'buy_txnfee_amt'=>'Buy Txnfee Amt', 'rolling_amt'=>'Rolling Amt', 'mdr_cb_amt'=>'MDR CB Amt', 'mdr_cbk1_amt'=>'MDR CBK1 Amt', 'mdr_refundfee_amt'=>'MDR Refundfee Amt', 'payable_amt_of_txn'=>'Payout Amount', 'available_balance'=>'Available Balance', 'settelement_date'=>'Settlement Date', 'rolling_date'=>'Rolling Date', 'merID'=>'MerID', 'bill_address'=>'Bill Address', 'bill_city'=>'Bill City', 'bill_state'=>'Bill State', 'bill_country'=> 'Bill Country', 'bill_zip'=>'Bill Zip', 'bill_phone'=>'Bill Phone','mop'=>'MOP', 'trans_type'=>'Trans Type', 'reference'=>'Reference', 'terNO'=>'TerNO', 'risk_ratio'=>'Risk Ratio', 'bill_currency'=>'Bill Currency', 'acquirer_ref'=>'Acquirer Ref', 'tdate'=>'Tdate', 'table_id'=>'Table ID', 'rrn'=>'RRN', 'created_date'=>'Created Date', 'bill_ip'=>'Bill IP', 'trans_response'=>'Trans Response', 'cardbin'=>'Card Detail');
	
	if($data['con_name']=='clk'){
		$clk_field_list7=['gst_amt'=>'GST Amt','rrn'=>'RRN','upa'=>'UPA'];
		$field_list7 = array_merge($field_list7, $clk_field_list7);
	}
	
	$field_list7_uncheck = array('available_balance', 'rolling_date','merID','bill_address','bill_city','bill_state','bill_zip','bill_phone','trans_type','acquirer_ref','table_id', 'rrn', 'upa','created_date','bill_ip','trans_response','acquirer');
	
	if($data['con_name']=='clk'){
		$clk_field_list7_uncheck=['rrn'];
		$field_list7_uncheck = array_merge($field_list7_uncheck, $clk_field_list7_uncheck);
	}
	
	if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']&&isset($_REQUEST['date_2nd'])&&$_REQUEST['date_2nd'])
	{
		//unset($field_list7_uncheck[2]);
		//unset($field_list7_uncheck[3]);
	}
	
	//, 'af_transID'=>'ar.trans.id', 'af_status'=>'ar.status', 'af_t_id'=>'ar.t.id'
	
	//print_r($field_list);
	?>
	<div class="h4" id="payout_title">Select Fields</div>
	<div class="row">
	<?
	$i = 0;
	foreach ($field_list7 as $key1=>$val1)
	{
		?>
		<div class="rows_f1 col-sm-4"><span class="w21"><input type="checkbox" id="<?=$key1?>" name="<?=$key1?>" value="1" class="form-check-input" <? if(!in_array($key1,$field_list7_uncheck)){?> checked="checked" <? }?> /> <label for="<?=$key1?>"><?=$val1?></label> </span></div>
		<?
		$i++;
	}
	?>
	</div>
	<div style="clear:both"></div>
	<div style="text-align:center; margin:auto">
	
	&nbsp; &nbsp;
	Records : <select name="fetch_limit" id="fetch_limit" style="width:200px;">
		<option value="500">500</option>
		<option value="1000">1000</option>
		<option value="3000">3000</option>
		<option value="5000" selected>5000</option>
		<option value="10000">10000</option>
		<option value="15000">15000</option>
		<option value="20000">20000</option>
		<option value="25000">25000</option>
		<option value="30000">30000</option>
		</select>
		<script>
			$('#fetch_limit option[value="5000"]').prop('selected','selected');
		</script>
	</div>
  <div class="withdraw_subm" style="clear:both; margin-left:20px;">
 <button id="with_pro_submit" type="submit" name="send" value="submit" class="submit btn btn-primary "  onclick="document.getElementById('popup_download_1').style.display='none';"><i></i><b class="contitxt"><i class="fas fa-plus-circle"></i> Submit</b></button></div>


