<? // this page create for show invoice preview - ; All data fetch for display from $_SESSION['invoice_data']?>
<div class="row d-flex justify-content-center">
	<div class="col-md-8">
		<div class="card">
			<div class="d-flex bd-highlight my-3">
				<div class="me-auto p-2 bd-highlight"><strong> 
					<?=$_SESSION['invoice_data']['company_name'];?>
					</strong><br />
					<? 
					if(isset($_SESSION['invoice_data']['fullname'])&&$_SESSION['invoice_data']['fullname'])
						echo $_SESSION['invoice_data']['fullname'];
					else
					{?>
						<?=$_SESSION['invoice_data']['fname'];?>
						<?=$_SESSION['invoice_data']['lname'];?>
					<?
					}?>
					<br />
					<?=$_SESSION['invoice_data']['business_address'];?>
					<br />
				</div>
				<div class="p-2 bd-highlight fs-3">Invoice</div>
			</div>
			<div class="d-flex bd-highlight mb-3">
				<div class="me-auto p-2 bd-highlight"><strong>Bill To</strong><br />
					<?=$_SESSION['invoice_data']['fullname'];?>
					<br />
					<? if(isset($_SESSION['invoice_data']['json_value']['bill_street_1'])&&$_SESSION['invoice_data']['json_value']['bill_street_1']){?>
					<?=$_SESSION['invoice_data']['json_value']['bill_street_1'];?>,
					<? } ?>
					<?=$_SESSION['invoice_data']['json_value']['bill_street_2'];?>
					<br />
					<?=(isset($_SESSION['invoice_data']['remail'])&&$_SESSION['invoice_data']['remail']?"Email: ".$_SESSION['invoice_data']['remail'].'<br />':'');?>
					<?=(isset($_SESSION['invoice_data']['json_value']['bill_phone'])&&$_SESSION['invoice_data']['json_value']['bill_phone']?"Mobile: ".$_SESSION['invoice_data']['json_value']['bill_phone'].'<br />':'');?>
					<? if(isset($_SESSION['invoice_data']['json_value']['bill_city'])&&$_SESSION['invoice_data']['json_value']['bill_city']){?>
					<?=$_SESSION['invoice_data']['json_value']['bill_city'];?>,
					<? } ?>
					<? if(isset($_SESSION['invoice_data']['json_value']['bill_state'])&&$_SESSION['invoice_data']['json_value']['bill_state']){?>
					<?=$_SESSION['invoice_data']['json_value']['bill_state'];?>,
					<? } ?>
					<? if(isset($_SESSION['invoice_data']['json_value']['bill_country'])&&$_SESSION['invoice_data']['json_value']['bill_country']){?>
					<?=$_SESSION['invoice_data']['json_value']['bill_country'];?>
					<? } ?>
					<? if(isset($_SESSION['invoice_data']['json_value']['bill_country'])&&isset($_SESSION['invoice_data']['json_value']['bill_zip'])&&$_SESSION['invoice_data']['json_value']['bill_country']&&$_SESSION['invoice_data']['json_value']['bill_zip']){?>
					-
					<? } ?>
					<? if(isset($_SESSION['invoice_data']['json_value']['bill_zip'])&&$_SESSION['invoice_data']['json_value']['bill_zip']){?>
					<?=$_SESSION['invoice_data']['json_value']['bill_zip'];?>
					<? } ?>
				</div>
				<div class="p-2 bd-highlight"><strong>Invoice No&nbsp;&nbsp;&nbsp;&nbsp;#</strong>
					<?=prntext(isset($_SESSION['invoice_data']['invoice_no'])?$_SESSION['invoice_data']['invoice_no']:'')?>
					<br />
					<strong>Invoice Date #</strong>
					<?=date("d/m/Y");?>
				</div>
			</div>
			<hr>
			<div class="products p-2 my-2">
				<? 
				$_SESSION['invoice_data']['amount']=number_format((float)$_SESSION['invoice_data']['json_value']['product_amount'], 2, '.', '');
				?>
				<table class="table table-striped">
					<tbody>
						<tr class="add">
							<td class="w-75"><strong>Description</strong></td>
							<td class="w-25"><strong>Amount</strong></td></tr>
						<tr class="content">
							<td><?=$_SESSION['invoice_data']['product_name']?></td>
							<td><?=$_SESSION['invoice_data']['amount']?>
								<?=$_SESSION['invoice_data']['currency']?></td></tr>
					</tbody>
				</table>
				<? 
				if($_SESSION['invoice_data']['json_value']['tax_type']<>""){ 
					
					$taxtitle	="";
					$taxamt		="";
					$totalamt	="";

					if($_SESSION['invoice_data']['json_value']['tax_type']==1){
						$taxamt=$_SESSION['invoice_data']['json_value']['tax_amount'];
						$taxamt=number_format((float)$taxamt, 2, '.', '');
						$taxtitle="";
						$totalamt=$_SESSION['invoice_data']['amount'] + $taxamt;
					}elseif($_SESSION['invoice_data']['json_value']['tax_type']==2){
						$taxamt=($_SESSION['invoice_data']['amount'] *	($_SESSION['invoice_data']['json_value']['tax_amount'] / 100));
						$taxamt=number_format((float)$taxamt, 2, '.', '');
						$taxtitle=$_SESSION['invoice_data']['json_value']['tax_amount']." %";
						$totalamt=$_SESSION['invoice_data']['amount'] + $taxamt;
					}
				}else{
					$totalamt=$_SESSION['invoice_data']['amount'];
				} 
				$totalamt=number_format((float)$totalamt, 2, '.', '');
				?>
				<table class="table float-end w-50 mb-2">
					<tbody>
						<? if($taxamt<>"") { ?>
						<tr class="content">
							<td class="w-50"><strong>Tax <?=$taxtitle;?> :</strong></td>
							<td class="w-50"><?=$taxamt?> <?=$_SESSION['invoice_data']['currency']?></td></tr>
						<? } ?>
						<tr class="content">
							<td class="w-50"><strong>Total :</strong></td>
							<td class="w-50"><?=$totalamt?> <?=$_SESSION['invoice_data']['currency']?></td></tr>
					</tbody>
				</table>
			</div>
			<? // click on Submit if DATA is correct, otherwise click on Edit for any changes?>
			<hr class="clearfix mt-2">
			<div class="text-center my-2 clearfix">
				<div class="btn btn-icon btn-primary me-2"> <a href="<?=$data['USER_FOLDER']?>/invoice<?=$data['ex']?>?action=addrequests&send=Submit&sess=1" class="text-white">Submit</a></div>
				<div class="btn btn-icon btn-primary me-2"> <a href="<?=$data['USER_FOLDER']?>/invoice<?=$data['ex']?>?action=edit" class="text-white">Edit</a></div>
			</div>
			<hr>
			<? if($_SESSION['invoice_data']['json_value']['term_condation']<>""){ ?>
			<div class="d-flex px-2 bd-highlight"><strong>Terms & Condations : </strong></div>
			<div class="d-flex px-2 mb-2 bd-highlight">
				<?=$_SESSION['invoice_data']['json_value']['term_condation'];?>
			</div>
			<? } ?>
			<? if($_SESSION['invoice_data']['json_value']['notes']<>""){ ?>
			<div class="d-flex px-2 bd-highlight"><strong>Notes : </strong></div>
			<div class="d-flex px-2 mb-2 bd-highlight">
				<?=$_SESSION['invoice_data']['json_value']['notes'];?>
			</div>
			<? } ?>
			<div class="text-end m-2"><strong>Powered by</strong> -
				<?=$data['SiteName'];?>
			</div>
			<div class="text-center text-secondary my-2" style="font-size:10px">this is computer generated invoice no signature required</div>
		</div>
	</div>
</div>