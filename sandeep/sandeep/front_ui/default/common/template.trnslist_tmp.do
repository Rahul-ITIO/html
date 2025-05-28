<??>

      <table id="content99" class="table table-hover">
        <?php if($cnttot > 0) { ?>
        <thead>
          <tr>
            <th scope="col">TransID</th>
            <? if(!isset($data['NameOfFile'])){ ?>
            <th scope="col">Reference</th>
            <th scope="col"><span class="text-hide-mobile">Full</span>&nbsp;Name</th>
            <? } ?>
            <th scope="col"><span class="text-hide-mobile">Bill</span>&nbsp;Amt</th>
            <th scope="col"><? if(isset($data['NameOfFile'])){ ?> Company <? }else{ ?> Bill Email <? } ?></th>
            <th scope="col">Timestamp</th>
            <th scope="col">Trans Response</th>
            <th scope="col">RRN</th>
            <th scope="col">Trans Status</th>
            <? if(isset($data['NameOfFile'])){ ?>
            <th scope="col" style="min-width:85px;">Action</th>
            <? } ?>
          </tr>
        </thead>
        <?php }else{ ?>
		<div class="alert alert-secondary alert-dismissible fade show" role="alert">
  <strong>No transaction yet - </strong> When you add or receive payments, they will appear here. 
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
		<?php } ?>
        <tbody>
          <? if($post['Transactions']){$idx=1;foreach($post['Transactions'] as $value){?>
          <tr>
            <td><a class="hrefmodal text-link" data-tid="<?=$value['transID']?>" style="white-space:nowrap;" data-href="<?=$data['Host'];?>/<?=$data['trnslist'];?>_get<?=$data['ex']?>?id=<?=$value['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=details">
              <?=$value['transID']?>
              </a> </td>
            <? if(!isset($data['NameOfFile'])){ ?>
            <td ><?=$value['reference']?></td>
            <td ><?=$value['fullname']?></td>
            <? } ?>
            <td class="pricecolor"><?=$value['bill_amt']?></td>
            <? if(isset($data['NameOfFile'])){ ?>
            <td ><?=$post['company_name'];?></td>
            <? }else{ ?>
            <td ><?=$value['bill_email'];?></td>
            <? } ?>
            <td title="Date - <?=prndate($value['tdate'])?>"><?=prndate($value['tdate'])?></td>
            <td title="<?=str_replace("-","",$value['trans_response'])?>"  data-bs-toggle="tooltip" data-bs-placement="bottom"><p class="text-start my-0  text-truncate" style="max-width: 150px;">
                <?=str_replace("-","",$value['trans_response'])?>
              </p></td>
			<td title="RRN - <?=(isset($value['rrn'])&&$value['rrn']?$value['rrn']:'')?>"><?=(isset($value['rrn'])&&$value['rrn']?$value['rrn']:'')?></td>
            <td><?=$value['trans_status']?></td>
            <? if(isset($data['NameOfFile'])){ ?>
            <td><?//=$value['source_url']?>
              <? if(($value['typenum']==2)&&(strpos($value['source_url'],"withdraw-")!==false))
			  { ?>
              <a onclick="filteraction(this)" target="pdfreport_wd_mer" href="<?=$data['Host']?>/trans_pdf_report<?=$data['ex']?>?id=<?=$value['id'];?>"><i class="<?=$data['fwicon']['pdf'];?> text-danger mx-1" title="Download Pdf"></i></a> <a target="pdfreport_wd_mer" href="<?=$data['Host']?>/trans_pdf_report<?=$data['ex']?>?id=<?=$value['id'];?>&format=excel" ><i class="<?=$data['fwicon']['excel'];?> text-success mx-1" title="Download Excel"></i></a> <a target="pdfreport_wd_mer" href="<?=$data['Host']?>/trans_pdf_report<?=$data['ex']?>?id=<?=$value['id'];?>&format=word" ><i class="<?=$data['fwicon']['word'];?> text-info mx-1" title="Download Word"></i></a>
              <? } ?>
            </td>
            <? } ?>
          </tr>
          <? $idx++;}}else{ } ?>
        </tbody>
      </table>
	  
	  