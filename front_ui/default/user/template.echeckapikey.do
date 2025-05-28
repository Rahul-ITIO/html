<? if(isset($data['ScriptLoaded'])){?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive.css" rel="stylesheet">
<div class="container border mt-2 mb-2 bg-white" >

<form method="post" name="data">
<input type="hidden" name="step" value="<?=$post['step']?>">

<script>
function accountTypeChange(e){
	$('.nomanditory').css('display','none');
	if( $(e).val()==="9" ) {
	 $('.nomanditory').css('display','block');
	}
	
}

function addremarks(e){
	if($(e).hasClass('active')){
		$('.addremarklink').removeClass('active');
		$('.addremarkform').removeClass('active');
		
		$(e).parent().parent().parent().find('.addremarkform').slideUp(200);
	} else {
	  $('.addremarklink').removeClass('active');
	  $('.addremarkform').removeClass('active');
	  
	  $(e).parent().parent().parent().find('.addremarkform').addClass('active');
	  $(e).addClass('active');
	  
	  $('.addremarkform').slideUp(100);
	  $(e).parent().parent().parent().find('.addremarkform').slideDown(700);
	}
}
$(document).ready(function(){ 
    $('.echektran .collapsea').click(function(){
		$('.addremarkform').slideUp(100);
	   var ids = $(this).attr('data-href');
		if($(this).hasClass('active')){
			$('.collapseitem').removeClass('active');
			$('.collapsea').removeClass('active');
			
			$('#'+ids).slideUp(200);
		} else {
		  $('.collapseitem').removeClass('active');
		  $('.collapsea').removeClass('active');
		  //$('#'+ids).addClass('active');
		  $(this).addClass('active');
		  
		  $('.collapseitem').slideUp(100);
		  $('#'+ids).slideDown(700);
		}
        
    });
    
});
</script>

	<h4 class="my-2"> Check  API Key</h4>


<? if($data['Error']){?>

<div class="alert alert-danger alert-dismissible fade show" role="alert">
	<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	<strong>Error!</strong> <?=prntext($data['Error'])?>
</div>


<? } ?>
			
			
<? if($post['step']==1){?>	
	



   
		
<div class="table-responsive my-2" >
		
     <table class="echektran">
    <tr class="text-primary">
	<th title="ACCOUNT ID">Account Id</th>
    <th title="TRANSACTIONS RATE PERCENT">Discount Rate</th>
	<th title="TXN FEE $ (Fixed Cost)">Txn Fee $ (Per Item Fee)</th>
	<th title="ROLLING PERCENT">Rolling Reserve</th>
	<th>Check 21 API Code</th>
    </tr>

<? 

	$j=1; 

	if($post['AccountInfo']) { foreach($post['AccountInfo'] as $key=>$value) { if(($value['nick_name']) && ( (strpos($data['t'][$value['nick_name']]['name2'],'Check') !== false) )){
	

?>
    <tr>
	<td class="input" align="center" nowrap>
		<?=$data['t'][$value['nick_name']]['name2']?>
    </td>
    <td class="input" align="center" nowrap>
		<?=$value['transaction_rate']?>
	</td>
	<td class="input" align="center" nowrap>
		<?=$value['txn_fee']?>
	</td>
	<td class="input" align="center" nowrap>
		<?=$value['rolling_fee']?>	
	</td>
    <td class="input" align="center" nowrap>
			<a class="collapsea" data-href="<?=$j;?>_toggle">Generate Code</a> 
				
			
	</td>
    
	</tr>
	<tr class="padding0" >
	 <td class="padding0" colspan="5" style="text-align:left !important;" >
	 <div class="collapseitem" id="<?=$j;?>_toggle">
			
			<div class=commentrow>
				<div class=title2 style="padding:0px 1% 6px 1%;margin: 15px 0 15px 0;width:98.1%;font-size: 16px !important;color: #9c9b9b;">	
				COPY THIS CODE AND PASTE INTO YOUR PAGE:
				</div>
				<div class=title2 style="padding:0px 1% 6px 1%;margin:0 0 10px 0;width:98.1%;">	
						<B>CODE #1 - Using GET method:</B>
				</div>
				<div class=col_22 style="padding:0px 1% 6px 1%;margin:0 0 10px 0;width:98.1%;">
					<?
					 $GetHtmlCode = 
					 "<!-- DusPay ECHECK21 URL GET METHOD  -->\n".
					 "<a href={$data['Host']}/echeckprocess{$data['ex']}?id={$post['id']}&bid=".$post['apikey']."&type=".$value['nick_name']." style=\"display:block;border:solid 1px #0066CC;background:#0066CC;color:#fff;padding:5px 20px;font-size:18px;border-radius:3px;text-decoration:none;width:200px;text-align:center;\">Pay Now!! </a>\n".
					 "<!-- DusPay ECHECK21 URL GET METHOD  -->\n";
					 encrypt($GetHtmlCode);
					?>
					<textarea rows=10 style="width:100%;font-family:Courier New" readonly><?=$GetHtmlCode?></textarea>
				</div>
				
				<div class=title2 style="padding:0px 1% 6px 1%;margin:0 0 10px 0;width:98.1%;">	
						<B>CODE #2 - Using POST method:</B>
				</div>
				<div class=col_22 style="padding:0px 1% 6px 1%;margin:0 0 10px 0;width:98.1%;">
					<?
					 $PostHtmlCode = 
					 "<!-- DusPay ECHECK21 FORM POST METHOD -->\n".
					 "<form method=post action={$data['Host']}/echeckprocess{$data['ex']}>\n".
					 "<input type=hidden name=id value={$post['id']}>\n".
					 "<input type=hidden name=bid value=".$post['apikey'].">\n".
					 "<input type=hidden name=type value=".$value['nick_name'].">\n".
					 "<input type=submit value=SUBMIT style=\"border:solid 1px #0066CC;background:#0066CC;color:#fff;padding:5px 20px;font-size:18px;border-radius:3px;\">\n".
					 "</form>\n".
					 "<!-- DusPay ECHECK21 FORM POST METHOD -->\n";
					 encrypt($PostHtmlCode);
					?>
					
					<textarea rows=10 style="width:100%;font-family:Courier New" readonly><?=$PostHtmlCode?></textarea>
				</div>
				
				
			</div>
	 
</div>	 
	 </td>
	</tr>
    <? $j++; }} } else{ ?>
	<tr><td class=capc colspan=5><center><div class="alert alert-error" style="text-align:center">NO ECHECK 21 ACCOUNT FOUND</div></center></td></tr>
	<? }?>
	

	</table>
</div>



<? }elseif($post['step']==2){ ?>
<? if($post['gid']){?>
<input type="hidden" name="gid" value="<?=$post['gid']?>">
<? } ?>
<input type="hidden" name="unique_id" value="<?=prntext($post[0]['unique_id'])?>">



<h4 class="my-2"><i class="<?=$data['fwicon']['bar'];?>"></i> Please enter the information below </h4>
						


						
<label for="type">Account ID <span class=mand>*</span></label>
<select name="type" id="accountType" class="feed_input1 form-select" onchange="accountTypeChange(this)" required>
<option value=0>--Account ID-- </option>
<? foreach($post['AccountInfo'] as $key=>$value){if(($value['nick_name']) && ( (strpos($data['t'][$value['nick_name']]['name2'],'Check') !== false) )){?>
<option value="<?=$value['nick_name']?>"><?=$data['t'][$value['nick_name']]['name2']?></option>	
<? }} ?>
</select>

<script>
$('#accountType option[value="<?=prntext($post[0]['type'])?>"]').prop('selected','selected');
accountTypeChange("<?=prntext($post[0]['type'])?>");
</script>

					
<label for="send"> </label>
<button type=submit name=send value="CONTINUE"  class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Resubmit</button>


<? } ?>

</form>
</div>
<? }else{ ?>SECURITY ALERT: Access Denied<? } ?> 

                              