<? if(isset($data['ScriptLoaded'])){ ?>



<div  class="container border my-2 rounded">
<div class="heading-buttons vkg my-2">
  <!--<h3 class=""><i></i><?=prntext($data['PageName'])?></h3>-->
  <h4><i class="<?=$data['fwicon']['transaction'];?>"></i>  
  <? if($data['frontUiName']=="OPAL_IND"){ echo "Transactions";}else{ echo prntext($data['PageName']);}?></h4>
    
  
  <div class="clearfix" style="clear: both;"></div>
</div>
<div class="widget widget-gray widget-body-white">
  <?
  //include file for search form
  $search_form=("../front_ui/{$data['frontUiName']}/common/template.trans_search_form".$data['iex']);
	if(file_exists($search_form)){
		include($search_form);
	}
  ?>
  
  <div class="alert alert-light fw-bold" role="alert">
  Result show: </span><?=$data['rec_start'];?> - <?=$data['rec_end'];?> of <?=$data['total_record']?> :: 
<? 
$seperator=" <i class='".$data['fwicon']['hand']."'></i>";
if(isset($_REQUEST['key_name'])&&$_REQUEST['key_name']=="transID"){ echo $seperator." TransID : ".$_REQUEST['searchkey']; }
if(isset($_REQUEST['key_name'])&&$_REQUEST['key_name']=="reference"){ echo $seperator." Reference : ".$_REQUEST['searchkey']; }
if(isset($_REQUEST['date_1st'])&&$_REQUEST['date_1st']){ echo $seperator." Date Range : ".$_REQUEST['date_1st']." To ".$_REQUEST['date_2nd']; }
if(isset($_REQUEST['status'])&&$_REQUEST['status']<>""&&$_REQUEST['status']<>"-1"){ echo $seperator." Status : ".$data['TransactionStatus'][$_REQUEST['status']]; }

if(isset($_REQUEST['records_per_page'])&&$_REQUEST['records_per_page']){ echo $seperator." Record Per Page : ".$_REQUEST['records_per_page']; }
  
?>
</div>


	<div class="table-responsive my-1 p-list">
	<?php if($data['total_record'] > 0) { ?>
	<table class="table table-striped">
		
			<thead>
			<tr class="bg-dark-subtle">
            <th valign="top"><div class="transaction-h1">TransID</div><div class="transaction-h2">Reference</div></th>
            <? if(!isset($data['NameOfFile'])){ ?>
           
            <th valign="top"><div class="transaction-h1">Full Name</div>
			<div class="transaction-h2"><? if(isset($data['NameOfFile'])){ ?>Company<? }else{ ?>Bill Email<? } ?></div>
			</th>
            <? } ?>
            <th valign="top"><div class="transaction-h1">Bill Amt</div><div class="transaction-h2">Trans.&nbsp;Amount</div></th>
           
            <th valign="top"><div class="transaction-h1">Timestamp</div><div class="transaction-h2">Created&nbsp;Date</div></th>
            <th valign="top"><div class="transaction-h1">Trans. Response</div></th>
            <th valign="top"><div class="transaction-h1">Trans Status</div></th>
            <? if(isset($data['NameOfFile'])){ ?>
            <th valign="top">Action</th>
            <? } ?>
          </tr>
        </thead>
        <tbody>
          <? if($data['TransData']){
		     foreach($data['TransData'] as $value){ ?>
          <tr>
            <td valign="top">
			<a class="hrefmodal mt-2 text-link transaction-list-h1" data-tid="<?=$value['transID']?>" style="white-space:nowrap;" data-href="<?=$data['Host'];?>/<?=$data['trnslist']?>_get<?=$data['ex']?>?id=<?=$value['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=details"><?=$value['transID']?></a>
              
			  <div title="<?=$value['reference'];?>" data-bs-toggle="tooltip" data-bs-placement="top" style="width:90px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" class="mx-0 transaction-list-h2"><?=$value['reference'];?></div>
			  
			  </td>
            <? if(!isset($data['NameOfFile'])){ ?>
            
            <td valign="top"><div class="transaction-list-h1"><?=$value['fullname']?></div>
			    <div class="transaction-list-h2"><? if(isset($data['NameOfFile'])){ echo $post['company_name']; }else{  echo $value['bill_email'];} ?></div>
			</td>
            <? } ?>
            <td valign="top"><div class="transaction-list-h1"><?=$value['bill_amt']?></div>
			    <div class="transaction-list-h2"><?=$value['trans_amt']?></div></td>
           
            <td valign="top"><div class="transaction-list-h1"><?=prndate($value['tdate'])?></div>
				<div class="transaction-list-h2"><?=prndate($value['created_date'])?></div></td>
            <td valign="top"><div class="transaction-list-h1"><?=str_replace("-","",$value['trans_response'])?></div>
             </td>
            <td valign="top"><div class="transaction-list-h1"><?=$data['TransactionStatus'][$value['trans_status']]?></div></td>
            <? if(isset($data['NameOfFile'])){ ?>
            <td valign="top">
              <? if(($value['typenum']==2)&&(strpos($value['source_url'],"withdraw-fund")!==false)){ ?>
              <a onclick="filteraction(this)" target="pdfreport_wd_mer" href="<?=$data['Host']?>/pdf_report<?=$data['ex']?>?id=<?=$value['id'];?>"><i class="fa-solid fa-file-pdf text-danger mx-1" title="Download Pdf"></i></a> <a target="pdfreport_wd_mer" href="<?=$data['Host']?>/pdf_report<?=$data['ex']?>?id=<?=$value['id'];?>&format=excel" ><i class="fa-solid fa-file-excel text-success mx-1" title="Download Excel"></i></a> <a target="pdfreport_wd_mer" href="<?=$data['Host']?>/pdf_report<?=$data['ex']?>?id=<?=$value['id'];?>&format=word" ><i class="fa-solid fa-file-word text-info mx-1" title="Download Word"></i></a>
              <? } ?>
            </td>
            <? } ?>
          </tr>
          <? } ?>
        </tbody>
      </table>
     <? }}else{ ?> 
      <div><img title="No Transaction Found" src="<?=$data['Host']?>/images/not_transaction_found.png" style="width:100%;padding:0;" class="img-fluid" /></div>
      <? } ?>
      
  
		<div class="pagination" style="float:left; width:100%; text-align:center;" id="total_record_result">
		  <?php
			
			include $data['Path']."/include/pagination_new".$data['iex'];
	
			$get=http_build_query($_REQUEST);
	
			$url=$_SERVER['PHP_SELF']."?".$get;
	
			if(isset($data['total_record'])&&$data['total_record']) $total = $data['total_record'];
			else $total = 0;
			
			pagination_new($data['MaxRowsByPage'],$data['startPage'],$url,$total);
			
			//if(isset($_GET['last_page']))	$page = $post['StartPage'];
			//short_pagination($data['MaxRowsByPage'],$data['startPage'],$url,$data['total_record'],1);
			?>
			</div>
		
     
      
  
      </center>
    </div>
  </div>
</div>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
