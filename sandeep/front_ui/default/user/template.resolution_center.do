<??><style type="text/css">
 #resolution {
  border-width: 1px;
border-style: solid;
border-color: #09C;
width: 220px;
height: 233px;
  }
  #re{
	   font-size:15px;
	   color:#69C;
  }
</style>
<style> body{color: #333;
font: 75%/normal Arial, Helvetica, sans-serif;
}
#content {
	width: 900x;
clear: both;
overflow: auto;
margin-top: 0.5em;
padding: 0 5px;
}.layout1, .layout2, .layout2a, .layout2b, .layout2c, .layout2d, .layout3 {
clear: both;
overflow: visible;
}
p {
margin: 1em 0;}
#headline h2 {
color: #C88039;
font-size: 1.33em;}
button.primary, input.button.primary {
border: 1px solid #d5bd98;
border-right-color: #935e0d;
border-bottom-color: #935e0d;
background: #ffa822 url(/en_US/i/pui/core/btn_bg_sprite.gif) left 17.5% repeat-x;}
</style>
<? if(isset($data['ScriptLoaded'])){ ?>
<div class="container-sm mt-2 mb-2 border bg-white rounded vkg" >
<div id="wrapper">
		<div id="content">
		<ul class="breadcrumb">
	<li><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="glyphicons home"><i></i> <?=prntext($data['SiteName'])?></a></li>
	<li class="divider"></li>
	<li>Cards</li>
</ul>
<div class="separator"></div>
<div class="heading-buttons">
	<h3 class=""><i></i>Resolution Center</h3>
	<div class="clearfix" style="clear: both;"></div>
</div>



<div class="separator"></div>


<? if($post['step']==1){ ?>

<div class="well">
<div class="widget widget-gray widget-body-white">
 </div>
   </div> 	
<div id="resolution" style="margin-top: -8px;margin-bottom: 35px;margin-left: 60px;"> 
 <p id="re" style="margin-left:10px;">Report a problem </p>
 <form action="#" method="post">
<ul>
<li>Didn't receive your item?</li>
<li>Received the wrong item?</li>
<li>Don't recognise a payment?</li>
</ul> 
<input  class="btn btn-primary" type="submit"  name="send" value="Dispute a Transaction" style="margin-left: 20px;
margin-top: 25px;"/>
</form>

</div>

<div id="content" style="width: 716px;
margin-left: -5px;
margin-top: -19px;
">
<div class="widget widget-gray widget-body-white">
		<div class="widget-head" style="border:1px solid #D1D2D3"><h4 class="heading">Dispute Transaction</h4></div>
		<div class="widget-body" style="padding: 10px 0; background:none repeat scroll 0 0 #FAFAFA">
  <form method=post name=data><input type=hidden name=step value="<?=$post['step']?>">     
			<table class="table table-bordered table-condensed">
       

<tr><td class=capc>Transaction Id</td><td>Reason</td><td>Amount</td><td>Opend</td><td>Status</td><td>Last Update</td></tr><?$idx=0;$bgcolor=$idx%2?'#EEEEEE':'#FFFFFF'?>
<? foreach($post['DisputDate'] as $key=>$value){ ?>
<tr>
<td align=center valign=top><?=$value['transaction_id']?></td>
<td align=center valign=top><?=$value['note']?></td>

<td align=center valign=top><?=$value['amount']?></td>
<td align=center valign=top><?=date("d-m-Y" ,strtotime($value['dispute_date']))?></td>
<td align=center valign=top><?=$value['status']?></td>
<td align=center valign=top><?=date("d-m-Y" ,strtotime($value['last_update']))?></td>

</tr>
  <? }?></table>
 
</div> 
</div>






<? } ?>
<? if($post['step']==2){ ?>
<form method=post name=data><input type=hidden name=step value="<?=$post['step']?>">
<div class="well">
<div class="widget widget-gray widget-body-white">
<div class="widget-head" style="border:1px solid #D1D2D3"><h4 class="heading">Report a problem</h4></div>
			<table class="table table-bordered table-condensed">
<tr><td class=capc><input type="radio" name="dispute_name" value="Item dispute" checked="checked"/></td><td class=capc>Item dispute: I did not receive an item I purchased or the item I received is significantly not as described.</td></td></tr>
<tr><td class=capc><input type="radio"  name="dispute_name" value="Unauthorised transaction"/></td><td class=capc>Unauthorised transaction: I did not authorise a recent transaction.</td></td></tr>
</div>
</table>
<table class="table table-bordered table-condensed">
<tr><td class=capc><input   class="btn btn-primary" type="submit" value="Continue" name="send" /></td><td class=capc><input  class="btn btn-primary" type="submit" value="Cancel" name="cancel" /></td></tr>
 </table>
 </form>
<? } ?>
<? if($post['step']==3){ ?>
<? if($data['Error']){ ?>

<div class="alert alert-error">
							<button type="button" class="close" data-dismiss="alert">&times;</button>
							<strong>Error!</strong> <?=prntext($data['Error'])?>
						</div>

<? } ?>
<form method=post name=data >
<div id="content" style="margin-left: 42px;"><div id="headline"><h2>Resolution Centre – Open a dispute</h2>
</div><div id="messageBox" class="legacyErrors"></div><div id="main" class="legacyErrors"><div class="layout1"><p>Have a problem with a transaction? We encourage you to contact the seller directly by opening a dispute in the Resolution Centre within 45 calendar days of payment.</p><p><strong>Reasons for opening a dispute:</strong></p><ul><li>You paid for your item, but you haven't received it.</li><li>You received an item that is significantly different from the seller's description.</li></ul><p>Most disputes can be resolved through direct communication. If you're unable to resolve the problem, we can help. You can ask us to investigate the transaction by escalating the dispute to a PayPal claim.</p><h3>Enter transaction ID</h3><input type=hidden name=step value="<?=$post['step']?>"><input type="hidden" id="CONTEXT_CGI_VAR" name="CONTEXT" value="X3-7SZn2ExXucINxlliZ_05NdFsrIIpaV9TcRYNLL_GiOwm9XgEZzWKQeV0"><p class="group help"><label for="trans_id"><span class="labelText"><strong>Transaction ID: </strong></span></label><span class="help"></span><span class="field"><input type="text" id="trans_id" size="20" maxlength="17"  name="trans_id" value="<?=$post['trans_id']?>" style="height:30px;">&nbsp;&nbsp;<input type="button" onclick="open_win()" value="Find transaction ID" class="btn btn-primary"  style="
margin-top: -11px";><br></span></p><input type="hidden" name="trans_id_disabled" value=""><p class="buttons clearleft"><input   class="btn btn-primary" type="submit" value="Continue" name="send"  onclick="javascript:return createSKey();" />
 <input   class="btn btn-primary" type="submit" value="Cancel" name="cancel"  style="margin-left:40px;"/>  </div></div></div>
 
</form> 
 <? } ?>
</center>
<? if($post['step']==4){ ?>
<div class="well">
<div class="widget widget-gray widget-body-white">
 </div>
   </div> 

<div id="content" style="width: 716px;
margin-left: -5px;
margin-top: -64px;
z-index: 999;
">
<div class="widget widget-gray widget-body-white">
		<div class="widget-head" style="border:1px solid #D1D2D3"><h4 class="heading"> Transactions Detail</h4></div>
		<div class="widget-body" style="padding: 10px 0; background:none repeat scroll 0 0 #FAFAFA">
  <form method=post name=data><input type=hidden name=step value="<?=$post['step']?>">     
			
       
<? if($post['Trans_detail']){
     $trans_data=array();   
     $trans_data= $post['Trans_detail']; 
    echo $post['step'];
?>
<table class="table table-bordered table-condensed">
       

<tr><td class=capc>Transaction Id</td><td>Date</td><td>Amount</td><td>Type</td><td>Status</td></tr><?$idx=0;$bgcolor=$idx%2?'#EEEEEE':'#FFFFFF'?>

<tr>
<td align=center valign=top><?= $trans_data['transaction_id']?></td>
<td align=center valign=top><?=$trans_data['tdate']?></td>

<td align=center valign=top><?=$trans_data['amount']?></td>
<td align=center valign=top><?=$trans_data['type']?></td>
<td align=center valign=top><?=$trans_data['status']?></td>

</tr>
<tr><td colspan="6" style="text-align: center;"><input   class="btn btn-primary" type="submit" value="Continue" name="confirm" onclick="myFunction()" /></td></tr>
</table> <? } ?>

 <input type="hidden" name="t_id" value="<?= $trans_data['transaction_id'] ?>"/>
</div>
</div>

<? } ?>
<? if($post['step']==5){ ?>

<div class="widget widget-gray widget-body-white">
<div class="widget-head" style="border:1px solid #D1D2D3"><h4 class="heading">Your Dispute Successfully Submited.We will Notify Soon...</h4></div>
			
 
<? } ?>



<script type="text/javascript">
function createSKey(){
	var check='';
	var a = document.getElementById('trans_id').value;
	 if(a == '')
	 {
		  alert("Please Enter Transaction Id");
		  return false;
		 
	 }
	 
	 if(isNaN(a))
    {
    alert("Please Enter Only Number");

   return false;
   }
	return true; 
}
	 


function myFunction()
{
alert("Are You Sure!");

}


function open_win()
{
window.open("http://propertycarrots.com/epaycustom/user/find_transaction<?=$data['ex']?>") 
}
</script>

</div>

<? }else{ ?>SECURITY ALERT: Access Denied<? } ?>
