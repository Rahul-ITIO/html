<??>


<style>
html .echektran thead  {position:sticky  !important;top:0;z-index:99;}
html .echektran thead th  {position: sticky !important;top:0;}

table.sar-table th {cursor:move;}
table.resize_drag_col th {position:relative;}
</style>
  <?
//start: Dev Tech : 23-06-12 drag table Columns 

?>
	
	<script src="<?=$data['Host']?>/thirdpartyapp/dragtablecolumn/jquery-ui.min.js"></script>
 
  <link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/thirdpartyapp/dragtablecolumn/dragtable.css" />
  <script src="<?=$data['Host']?>/thirdpartyapp/dragtablecolumn/jquery.dragtable.js"></script>
  
  <script type="text/javascript">
//	Dev Tech : 23-04-17 drag table Columns  
function dragtablef(theUiName,sufixIc='tra_'){
	//$(theUiName).addClass('sar-table');
	$(theUiName).addClass('resize_drag_col');
	$(theUiName+' thead>tr').each(function () {  
        $('th', this).each(function () { 
			var thisThId=$(this).text().trim();
				thisThId=thisThId.replace(/ (\s|&nbsp;)\s+[\s\uFEFF\xA0][` ~!@#$%^&*()_+\-=?:'",.<>\{\}\[\]\\\/](\r||\r)/g,'').trim().toLowerCase();
				thisThId=thisThId.replace(/ /g, '');
				thisThId=thisThId.replace(/\./g, '');
				thisThId=thisThId.replace(new RegExp(/\//g), '');
				thisThId=thisThId.replace(/&nbsp;/g, '');
				thisThId=thisThId.replace(/\n|\r|\W/g, "");
				$(this).attr('id',sufixIc+thisThId);
				
				$(this).attr('data-type','text-long');
				$(this).append('<span class="some-handle"></span>');
				$(this).append('<span class="resize-handle"></span>');
        });  
    }); 
	
	
	$(theUiName).dragtable({
       // dragaccept:'.capc',
		dragHandle:'.some-handle',
		persistState: function(table) {
          if (!window.sessionStorage) return;
          var ss = window.sessionStorage;
          table.el.find('th',this).each(function(i) {
            if(this.id != '') {table.sortOrder[this.id]=i;}
          });
		 // alert(JSON.stringify(table.sortOrder));
		  ss.setItem('tableorder',JSON.stringify(table.sortOrder));
        },
		restoreState: eval('(' + window.sessionStorage.getItem('tableorder') + ')')
    });
	
}
$(document).ready(function() {
	dragtablef('table#content22');	 
});
//window.sessionStorage.setItem('tableorder','{}');
</script>
<?

//end: Dev Tech : 23-06-12 drag table Columns 
?>

	<table id="content22"  class="table table-hover bg-primary text-white" >
  <!--frame22 echektran22-->
  <thead>
    <tr class="bg-dark-subtle">
      <?

// For Display Data By ASC/DESC Order
$listing_order=(isset($_REQUEST['d_order'])&&$_REQUEST['d_order']?$_REQUEST['d_order']:'DESC');
if(isset($_REQUEST['d_order'])&&$_REQUEST['d_order']=="DESC"){$listing_order="ASC";}else{$listing_order="DESC";}


$twice=1;
$h_css="h1";

	foreach($post['assign_trans_display_json_arr'] as $val){ 
		//if((isset($_SESSION["login_adm"]))||(isset($_SESSION["tr_{$val}"])&&$_SESSION["tr_{$val}"]==1))
		
		{

			if(isset($data['NameOfFile']) && $post['assign_payin_trnslist'][$val]=="Action" ){ 
			$twice=1;
			?>
      <th scope="col" valign="top" > <div class="transaction-h1">
          <?=$post['assign_payin_trnslist'][$val];?>
        </div></th>
      <? }elseif($post['assign_payin_trnslist'][$val]=="Available Balance"){ $twice=1; ?>
      <th scope="col" valign="top" > <div class="transaction-h1"> <a class="text-link" title="<?=$post['assign_payin_trnslist'][$val];?>">
          <?=$post['assign_payin_trnslist'][$val];?>
          </a> </div></th>
      <? }else{ if($twice==1){ echo '<th scope="col" valign="top">'; $h_css="h1";  }else{ $h_css="h2";}  ?>
      <div class="transaction-<?=$h_css;?>"> <a href="<?=$data['USER_FOLDER']?>/<?=$data['trnslist'];?><?=$data['ex']?>?<?=(@$post['page']?'&page='.$post['page']:'');?>" class="text-link" title="<?=$post['assign_payin_trnslist'][$val];?>">
        <?=$post['assign_payin_trnslist'][$val];?>
        </a> </div>
      <? $twice++;
			if($twice==3){ echo '</th>'; $twice=1;}
			}

		}
	} 

?>
    </tr>
  </thead>
  <? $idx=0; if($post['Transactions'])
	{
		foreach($post['Transactions'] as $key=>$value)
		{ ?>
  <tr>
    <?
				$twice=1;
				$h_css="h1";
				foreach($post['assign_trans_display_json_arr'] as $val){ 
				//if((isset($_SESSION["login_adm"]))||(isset($_SESSION["tr_{$val}"])&&$_SESSION["tr_{$val}"]==1))
				{
				if($post['assign_payin_trnslist'][$val]=="Action" ){ 
				$twice=1;
			?>
    <? 
	if(isset($data['NameOfFile']))
	{ ?>
    <td><?//=$value['source_url']?>
      <? if(($value['typenum']==2)&&(strpos($value['source_url'],"withdraw-")!==false))
			  { ?>
      <a onClick="filteraction(this)" target="pdfreport_wd_mer" href="<?=$data['Host']?>/trans_pdf_report<?=$data['ex']?>?id=<?=$value['id'];?>"><i class="<?=$data['fwicon']['pdf'];?> text-danger mx-1" title="Download Pdf"></i></a> <a target="pdfreport_wd_mer" href="<?=$data['Host']?>/trans_pdf_report<?=$data['ex']?>?id=<?=$value['id'];?>&format=excel" ><i class="<?=$data['fwicon']['excel'];?> text-success mx-1" title="Download Excel"></i></a> <a target="pdfreport_wd_mer" href="<?=$data['Host']?>/trans_pdf_report<?=$data['ex']?>?id=<?=$value['id'];?>&format=word" ><i class="<?=$data['fwicon']['word'];?> text-info mx-1" title="Download Word"></i></a>
      <? } ?>
    </td>
    <? } ?>
    <? }elseif($post['assign_payin_trnslist'][$val]=="Available Balance"){ $twice=1; ?>
    <td  valign="top"><div class="transaction-list-h1">
        <?=$value['available_balance']?>
      </div></td>
    <? }else{ if($twice==1){ echo '<td valign="top">'; $h_css="h1";  }else{ $h_css="h2";}  ?>
    <? if($post['assign_payin_trnslist'][$val]=="TransID" ){ ?>
    <a class="hrefmodal text-wrap text-link" data-tid="<?=$value['transID']?>" data-href="<?=$data['Host'];?>/trnslist_get<?=$data['ex']?>?id=<?=$value['id']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=details" title="<?=$value['transID'];?>" >
    <? 
			
			if($value['typenum']==2){ echo 'W'; }
			elseif($value['ostatus']=="3" || $value['ostatus']=="5" || $value['ostatus']=="6" || $value['ostatus']=="11" || $value['ostatus']=="12"){ echo 'R'; }?>
    <?=substr($value['transID'],0,14);?>
    </a>
    <? }elseif($post['assign_payin_trnslist'][$val]=="Json Log" ){ ?>
	
		<div class="transaction-list-h1" <?/*?> data-mid="<?=$value['id']?>" data-ihref="<?=$data['Admins']?>/json_log_all<?=$data['ex']?>?tablename=<?=$data['MASTER_TRANS_TABLE']?>&action_name=<?=$value['bearer_token']?>" onClick="iframe_open_modal(this);" <?*/?> style="cursor:pointer;" title="Json Log History" data-bs-toggle="tooltip" data-bs-placement="bottom"><i class="<?=$data['fwicon']['circle-info'];?> text-info"></i></div>
		
    <? }elseif($post['assign_payin_trnslist'][$val]=="Bearer Token" ){ ?>
		<? if(isset($value['bearer_token'])&&$value['bearer_token']){ ?>
			<a onClick="load_popup_jsonf('<?=$data['USER_FOLDER'];?>/json_pretty_print<?=$data['ex']?>','<?=encryptres($value['acquirer_response']);?>','jsonLogHisotry');" class="transaction-list-h2 nomid btn btn-outline-danger btn-sm my-2"  title="<?=$value['bearer_token']?>" id="acqresp" style="padding: 1px 5px;margin:1px !important;">
				<?=$value['bearer_token']?>
			</a>
		<? }else{ ?>
			-
		<? } ?>
    <? }elseif($post['assign_payin_trnslist'][$val]=="MOP" ){ ?>
    <?

	   
	    if($value['mop']=='visa'){ 
		   $fwimg=1; $fwicon=$data['fwicon']['visa'];
		   $img="visacard.png";$txt='Visa Card';
		   $sort="&ccard_type=Visa";
	   }
	   
	   elseif ($value['mop']=='jcb'){
		   $fwimg=1; $fwicon=$data['fwicon']['jcb'];
		   $img="jcb.png";$txt='JCB Card';
		   $sort="&ccard_type=JCB";
	   }
	   elseif ($value['mop']=='mastercard'){
		   $fwimg=1; $fwicon=$data['fwicon']['mastercard'];
		   $img="master.png";$txt='Master Card';
		   $sort="&ccard_type=MasterCard";
	   }
	   elseif ($value['mop']=='discover'){
		   $fwimg=1; $fwicon=$data['fwicon']['discover'];
		   $img="discover.png";$txt='Discover';
		   $sort="&ccard_type=Discover";
	   }
	   elseif ($value['mop']=='rupay'){
		   $img="rupay.jpg";$txt='Rupay';
		   $sort="&ccard_type=rupay";
	   }
	   elseif ($value['mop']=='amex'){
		   $fwimg=1; $fwicon=$data['fwicon']['amex'];
		   $img="amex.png";$txt='Amex';
		   $sort="&ccard_type=amex";
	   }
	   elseif ($value['mop']=='QR'){
		   $fwimg=1; $fwicon=$data['fwicon']['qr-code']; 
		   $sort="&ccard_type=QR";
	   }
	   elseif ($value['mop']=='NB'){
		   $fwimg=1; $fwicon=$data['fwicon']['netbanking'];
		   $sort="&ccard_type=NB";
	   }
	   elseif ($value['mop']=='WA'){
		   $fwimg=1; $fwicon=$data['fwicon']['wallet'];
		   $sort="&ccard_type=WA";
	   }
	   elseif ($value['mop']=='BT'){
		   $fwimg=1; $fwicon=$data['fwicon']['bt'];
		   $sort="&ccard_type=BT";
	   }
	   elseif ($value['mop']=='3D'){
		   $fwimg=1; $fwicon=$data['fwicon']['creditcard'];
		   $sort="&ccard_type=3D";
	   }
	   elseif ($value['mop']=='2D'){
		    $fwimg=1; $fwicon=$data['fwicon']['creditcard'];
		   $sort="&ccard_type=2D";
	   }
	   elseif ($value['mop']=='UPIQR'){
		   $fwimg=1; $fwicon='<img src="'.$data['bankicon']['bhim-svg'].'" class="img-fluid img-hover" style="max-height:18px;">';
		   $sort="&ccard_type=UPIQR";
	   }elseif ($value['mop']=='UPI'){
		   $fwimg=1; $fwicon='<img src="'.$data['bankicon']['upi-icon'].'" class="img-fluid img-hover" style="max-height:18px;">';
		   $sort="&ccard_type=UPI";
	   }
	   
	   elseif (isset($data['channel'][$value['channel_type']]['name1'])&&$data['channel'][$value['channel_type']]['name1']=="wa"){
			$fwimg=1; $fwicon=$data['fwicon']['wallet'];
			$sort="&ccard_type=WA";
	   }
	   elseif (isset($data['channel'][$value['channel_type']]['name1'])&&$data['channel'][$value['channel_type']]['name1']=="AdvCash"){
			$fwimg=1; $fwicon=$data['fwicon']['AdvCash'];
			$sort="&ccard_type=AdvCash";
	   }
	   elseif ($value['mop']=='applepay'){
		    $fwimg=1; $fwicon=$data['fwicon']['applepay'];
		   $sort="&ccard_type=applepay";
	   } 
	   elseif ($value['mop']=='googlepay'){
		    $fwimg=1; $fwicon=$data['fwicon']['googlepay'];
		   $sort="&ccard_type=googlepay";
	   }
	   elseif (empty($value['mop'])){
		   $fwimg=1; $fwicon=$data['fwicon']['nocc'];
		   $img="nocc.png";$txt='No Card Available';$sort="&ccard_type=-1";
	   }else{
		    $fwimg=0;
			$img="nocc.png";$txt='No Card Available';$sort="&ccard_type=-1";$style1="width:30px;height:auto;";
	   }
	  
	 
	  if(isset($img)&&trim($img)&&$img=="nocc.png"&&empty($fwicon)){ $fwimg=1; $fwicon=$data['fwicon']['nocc']; }
	  
	   

	   if($value['mop']=='WD'){
		$img="wd.png";$txt='Withdraw';$sort="&payment_type=wd";
	   }
	   elseif($value['t']=="Deposit"){
		$img="deposit.png";$txt='Deposit';$sort="&payment_type=dp";
	   }
	   elseif($value['t']=="Withdraw Rolling"){
		$img="wr.png";$txt='Withdraw Rolling';$sort="&payment_type=wr";
	   }
	   
	   $sort=$data['USER_FOLDER']."/{$data['trnslist']}".$data['ex']."?action=select".@$data['cmn_action'].(isset($sort)&&trim($sort)?$sort:'');
	   
	  
	   ?>
    <a href="<?=$sort;?>" title="<?=$value['mop']?> <?=(isset($txt)&&trim($txt)?' - '.$txt:'')?>"  class="transaction-list-h1">
    <? if($fwimg==0){ ?>
    <img src="<?=$data['Host']?>/images/<?=$img?>" class="img-fluid img-hover" alt="<?=(isset($txt)&&trim($txt)?$txt:'')?>" style="max-height:18px;">
    <? }else{ echo $fwicon; ?>
    <? } ?>
    </a>
    <? }elseif($post['assign_payin_trnslist'][$val]=="Bill IP" ){ ?>
    <a onClick="iframe_open_modal(this);" class="dotdot nomid" data-ihref='<?=$data['Host'];?>/include/ips<?=$data['ex']?>?remote=<?=$value['bill_ip']?>' title='IP: <?=prntext($value['bill_ip']);?>' >
    <?=prntext(lf($value['bill_ip'],15,1));?>
    </a>
    <? }elseif( ($post['assign_payin_trnslist'][$val]=="Product Name") || ($post['assign_payin_trnslist'][$val]=="Bill Address") || ($post['assign_payin_trnslist'][$val]=="Json Value") || ($post['assign_payin_trnslist'][$val]=="Acquirer Response") || ($post['assign_payin_trnslist'][$val]=="Source Url") || ($post['assign_payin_trnslist'][$val]=="Webhook Url") || ($post['assign_payin_trnslist'][$val]=="Return Url") || ($post['assign_payin_trnslist'][$val]=="Trans Response") ){ ?>
    <div class="transaction-list-<?=$h_css;?>" ><a href='<?=$data['USER_FOLDER'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value[$val]);?>' class="modal_from_url" title="<?=$post['assign_payin_trnslist'][$val];?>" >
      <?=lf($value[$val],20)?>
      </a></div>
    <? }elseif( ($post['assign_payin_trnslist'][$val]=="Support Note") || ($post['assign_payin_trnslist'][$val]=="System Note")){ ?>
    <div class="transaction-list-<?=$h_css;?>" ><a href='<?=$data['USER_FOLDER'];?>/json_pretty_print<?=$data['ex']?>?json=<?=encryptres($value[$val]);?>&vtype=1' class="modal_from_url" target="_blank">
      <? if(isset($value[$val])&&!empty($value[$val])){ echo $post['assign_payin_trnslist'][$val]; }else{ ?>
      <? } ?>
      </a></div>
    <? }else{ ?>
    <? if($post['assign_payin_trnslist'][$val]=="Created Date"){ ?>
    <div class="transaction-list-<?=$h_css;?>">
      <?=prndate($value[$val])?>
    </div>
    <? }else{ ?>
    <div class="transaction-list-<?=$h_css;?>">
      <? if(isset($value[$val])){echo $value[$val];}else{ echo "&nbsp;";} ?>
    </div>
    <? } ?>
    <? } ?>
    <? $twice++;
if($twice==3){ echo '</td>'; $twice=1;}
}
} 
}
?>
  </tr>
  <? 
		$idx++; 
	  } 
	}
	?>
</table>

	
	
	