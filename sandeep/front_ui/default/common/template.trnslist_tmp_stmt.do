<??>

     <table class="table table-hover bg-primary text-white">
	   <? if(count($post['Transactions'])!=0){ ?>
        <thead>
          <tr>
            <th scope="col">TransID</th>
            <th scope="col">Reference</th>
            <th scope="col">Full&nbsp;Name</th>
            <th scope="col">Bill&nbsp;Amt</th>
            <th scope="col">Trans&nbsp;Amt</th>
            <th scope="col">Timestamp</th>
            <th scope="col">Trans Status</th>
            <th scope="col">Action</th>
			<? if($data['con_name']=='clk'){ ?>
			<th scope="col">MDR</th>
			<th scope="col">GST</th>
			<th scope="col">UPA</th>
			<? $cspan=12; }else{ $cspan=8;} ?>
			<th scope="col">RRN</th>
            <th scope="col">CCNo</th>
          </tr>
        </thead>
		<? }else{ ?>
<div class="alert alert-secondary alert-dismissible fade show" role="alert">
  <strong>No statement - </strong> When you add or receive payments, they will appear here. 
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
		<? } ?>
        <tbody>
          <? if($post['Transactions']){$idx=1;foreach($post['Transactions'] as $value){ ?>
          <tr>
            <td><a class="hrefmodal text-wrap text-link" data-tid="<?=$value['transID']?>" data-href="<?=$data['Host'];?>/trnslist_get<?=$data['ex']?>?id=<?=$value['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=details" style="white-space:nowrap;">
              <?=$value['transID']?>
              </a></td>
            <td  ><?=$value['reference']?></td>
            <td ><?=$value['fullname']?></td>
            <td class="pricecolor"><?=$value['bill_amt']?></td>
            <td  class="pricecolor"><?php echo $value['trans_amt'];?></td>
            <?/*?><td nowrap ><?=$value['available_balance']?></td> <?*/?>
            <td ><?=prndate($value['tdate'])?></td>
            
            <td ><?=$value['trans_status']?></td>
            <td >
			  
			  <?php /*?><a class="hrefmodal" data-href="<?=$data['Host'];?>/trnslist_get<?=$data['ex']?>?id=<?=$value['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=details" data-tid="<?=$value['transID']?>"  title="view"  ><i class="<?=$data['fwicon']['eye-solid'];?>"></i></a><?php */?>
			  
              <?  if($value['trans_type']=="ch"){ ?>
              <a onclick="iframe_openfvkg(this);" class="glyphicons" data-mid="<?=$value['merID']?>" data-href="<?=$idx;?>_toggle" data-tabname="" data-url="" data-ihref="<?=$data['USER_FOLDER'];?>/echeckvt<?=$data['ex']?>?actionuse=1&hideAllMenu=1&id=<?=$value['tableid']?>&action=update"  title="Duplicate Transaction"><i class="<?=$data['fwicon']['clone'];?>"></i></a>
              <? if($value['ostatus']==0){ ?>
              <a data-reason="Cancel Reason" onclick="return confirm('Are you Sure to CANCEL this')" href="<?=$data['USER_FOLDER']?>/<?=($data['FileName']);?>?id=<?=$value['id']?><? if($post['StartPage']){ ?>&page=<?=$post['StartPage']?><? } ?>&type=<?=$value['typenum'];?>&action=cancel" class="ajxstatus" title="Cancel"><i class="<?=$data['fwicon']['clone'];?>"></i><!--<span class='itxv'>Cancel</span>--></a>
              <? } ?>
              <? } ?>
              <? if((isset($data['t'][$value['typenum']]['refund'])&&$data['t'][$value['typenum']]['refund'])&&($value['ostatus']==1 || $value['ostatus']==4  || $value['ostatus']==6 || $value['ostatus']==8)){ ?>
              <a data-amount="<?=$value['oamount']?>" data-reason="Refund Request" data-href="<?=$data['USER_FOLDER']?>/<?=($data['FileName']);?>?id=<?=$value['id']?><? if($post['StartPage']){ ?>&page=<?=$post['StartPage']?><? } ?><? if($post['type']){ ?>&type=<?=$post['type']?><? } ?>&action=refund" class="dialog_refunded" title="Refund"><i class="<?=$data['fwicon']['rotate-right'];?> mx-1"></i></a>
              <? } ?>
			  
			  <? if((isset($value['json_value_de']['status_'.$value['typenum']]))&&($value['json_value_de']['status_'.$value['typenum']]) && ($value['ostatus']==0)){ ?>
					<a href="<?=($data['Host']);?>/<?=($value['json_value_de']['status_'.$value['typenum']]);?>&actionurl=admin_direct&admin=1&type=<?=($value['typenum']);?>&redirecturl=<?php echo $data['USER_FOLDER'];?>/<?=($data['FileName']);?>" target='hform' class="hkip_status_id" title="Update"><i class="<?=$data['fwicon']['retweet'];?>"></i></a>
			  <? } ?>
				 
				
              
              <? 
			  if(isset($value['canrefund'])&&$value['canrefund'])
			  { ?>
              <a href="<?=$data['USER_FOLDER']?>/<?=($data['FileName']);?>?id=<?=$value['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=refund" onClick="return cfmform()" title="Refund"></a>
              <? } ?>            </td>
			<? if($data['con_name']=='clk'){ ?>
			<td nowrap title="MDR"><?=$value['buy_mdr_amt']?></td>
			<td nowrap title="GST"><?=$value['gst_amt']?></td>
			<td nowrap title="UPA"><?=$value['upa']?></td>
			<? } ?>

			<td nowrap title="RRN"><?=(isset($value['rrn'])&&$value['rrn']?$value['rrn']:'')?></td>
			<td nowrap title="Card Number"><?=bclf($value['ccno'],$value['bin_no']);?></td>
          </tr>
          <? $idx++;}}else{ ?>
          <tr>
            <td class="error" colspan="<?=$cspan;?>" align="center" style="padding:0;"><img title="NO TRANSACTIONS FOUND" src="<?=$data['Host']?>/images/not_transaction_found.png" style="width:100%;padding:0;" /> </td>
          </tr>
          <? } ?>
      </table>
      