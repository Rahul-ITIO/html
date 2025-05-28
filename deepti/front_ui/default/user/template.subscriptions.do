<? if(isset($data['ScriptLoaded'])){ ?>

<div class="container border mt-2 mb-2 bg-white" >
<!--<style>
.menu-hidden .navbar.main .btn-navbar {left: 230px;}.menu-hidden .navbar.main .appbrand {display: inline;}
#content .breadcrumb li {
	float:left;
	margin-top:2px;
}

</style>-->

    <h4 class="my-2"><i class="far fa-hand-point-right"></i> Subscriptions :</h4>

  <form method="post">
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <? if($post['step']==1){ ?>
    <table class="table">

      <tr class="bg-rpimary">
        <th>NAME</th>
        <th>PRICE</th>
        <th>PERIOD</th>
        <th>SOLD</th>
        <th width=1%>ACTION</td>
      </tr>
      <? $idx=0;foreach($data['Products'] as $value){$bgcolor=$idx%2?'#EEEEEE':'#E7E7E7'?>
      <tr bgcolor=<?=$bgcolor?> onmouseover="setPointer(this, <?=$idx?>, 'over', '<?=$bgcolor?>', '#CCFFCC', '#FFCC99')" onmouseout="setPointer(this, <?=$idx?>, 'out', '<?=$bgcolor?>', '#CCFFCC', '#FFCC99')" onmousedown="setPointer(this, <?=$idx?>, 'click', '<?=$bgcolor?>', '#CCFFCC', '#FFCC99')">
        <td><?=prntext($value['name'])?></td>
        <td><?=prntext($data['Currency'])?><?=prnsumm($value['price'])?></td>
          
        <td><?=prnintg($value['period'])?> Days</td>
          
        <td><?=($value['sold']?$value['sold']:'0')?>
          Times<br>
          <font class="remark">(
          <?=prntext($data['Currency'])?>
          <?=prnsumm($value['price']*$value['sold'])?>
          )</font></td>
        <td  nowrap><a href="<?=$data['USER_FOLDER']?>/subscriptions<?=$data['ex']?>?id=<?=$value['id']?>&action=update">Edit</a>|<a href="<?=$data['USER_FOLDER']?>/subscriptions<?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return cfmform()">Delete</a><br>
          <a href="<?=$data['USER_FOLDER']?>/generate<?=$data['ex']?>?id=<?=$value['id']?>&action=subscriptions">Generate Code</a><br>
          <a href="<?=$data['USER_FOLDER']?>/generate<?=$data['ex']?>?id=<?=$value['id']?>&action=subscriptions&status=crypt">Encrypt Code</a></td>
      </tr>
      <? $idx++;}?>

    </table>
	<div class="my-2"><input class="submit-signup btn btn-primary" type="submit" name="send" value="Signup Now!"></div>
   
	<h4 class="my-2"><i class="far fa-hand-point-right"></i> Subscribed :</h4>
    <table class="table" >

      <tr class="bg-rpimary">
        <th>MERCHANT</th>
        <th>NAME</th>
        <th>PRICE</th>
        <th>PERIOD</th>
        <th width=1%>ACTION</th>
      </tr>
	  
	  
      <? $idx=0;foreach($data['Subscriptions'] as $value){$bgcolor=$idx%2?'#EEEEEE':'#E7E7E7'?>
      <tr bgcolor="<?=$bgcolor?>" onmouseover="setPointer(this, <?=$idx?>, 'over', '<?=$bgcolor?>', '#CCFFCC', '#FFCC99')" onmouseout="setPointer(this, <?=$idx?>, 'out', '<?=$bgcolor?>', '#CCFFCC', '#FFCC99')" onmousedown="setPointer(this, <?=$idx?>, 'click', '<?=$bgcolor?>', '#CCFFCC', '#FFCC99')">
        <td><?=prntext($value['clientid'])?></td>
        <td><?=prntext($value['name'])?></td>
        <td><?=prntext($data['Currency'])?> <?=prnsumm($value['price'])?></td>
        <td><?=prnintg($value['period'])?>Days</td>
        <td><a href="<?=$data['USER_FOLDER']?>/subscriptions<?=$data['ex']?>?id=<?=$value['id']?>&action=cancel" onclick="return cfmform()">CANCEL</a></td>
      </tr>
      <? $idx++;}?>
    </table>
    <? }elseif($post['step']==2){ ?>
    <? if($post['gid']){ ?>
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <? } ?>
	 <? if($data['Error']){ ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    <strong>Error!</strong> <?=prntext($data['Error'])?>
    </div>
      <? } ?>
	  
	 
	 <div class="input_col_2 row vkg my-2 me-1">
               
                <div class="col-sm-6">
                  <label for="settlement_fixed_fee">Product/Service Name (*):</label>
                  <input type="text" name="name"  class="form-control" value="<?=prntext($post['name'])?>">
                </div>
                <div class="col-sm-6">
                  <label for="Description" class="w-100">Description</label>
                  <textarea name="comments" class="form-control"><?=prntext($post['comments'])?></textarea>
                </div>
                <div class="col-sm-6">
                  <label for="Recurrent Charge">Recurrent Charge, <?=prntext($data['Currency'])?>(*): Enter only a number like 5.00</label>
                  <input type="text" name="price" class="form-control" value="<?=prnsumm($post['price'])?>">
                 
                </div>
                <div class="col-sm-6">
                  <label for="Duration" class="w-100">Duration (*):<small>(In Days)</small></label>
                  <input type="text" name="period"  class="form-control" value="<?=(int)$post['period']?>">
                </div>
				
				
				<div class="col-sm-6">
                  <label for="Tiral Period" class="w-100">Tiral Period (*):<small>(In Days)</small></label>
                  <input type="text" name="trial" class="form-control" value="<?=(int)$post['trial']?>">
                </div>
				<div class="col-sm-6">
                  <label for="Setup Fee" class="w-100">Setup Fee, <?=prntext($data['Currency'])?> : Enter only a number like 5.00</label>
                  <input type="text" name="setup" class="form-control" value="<?=prnsumm($post['setup'])?>">
                </div>
				<div class="col-sm-6">
                  <label for="Tax" class="w-100">Tax, <?=prntext($data['Currency'])?> : Enter only a number like 5.00</label>
                  <input type="text" name="tax" class="form-control" value="<?=prnsumm($post['tax'])?>">
                </div>
				<div class="col-sm-6">
                  <label for="Shipping" class="w-100">Shipping, <?=prntext($data['Currency'])?> : Enter only a number like 5.00</label>
                  <input type="text" name="shipping" class="form-control"value="<?=prnsumm($post['shipping'])?>">
                </div>
				
				
				<div class="col-sm-6">
                  <label for="Shipping" class="w-100">Return URL (*):</label>
                  <input type="text" name=u"return" class="form-control" value="<?=$post['ureturn']?>">
                </div>
				
				<div class="col-sm-6">
                  <label for="Shipping" class="w-100">Notify URL (*):</label>
                  <input type="text" name="unotify" class="form-control" value="<?=$post['unotify']?>">
                </div>
				
				<div class="col-sm-6">
                  <label for="Shipping" class="w-100">Cancel URL:</label>
                  <input type="text" name="ucancel" class="form-control" value="<?=$post['ucancel']?>">
                </div>
				
				<div class="col-sm-12">
                  <label for="Shipping" class="w-100">Please select a button:</label>
                  <? $idx=1;foreach($post['Buttons'] as $key=>$value){$bgcolor=$idx%2?'#EEEEEE':'#E7E7E7'?>
          <label for=button_<?=$idx?>>
          <input class="form-check-input" type="radio" id="button_<?=$idx?>" name="button" value="<?=$value?>"<? if($post['button']==$value){ ?> checked<? } ?>>
          &nbsp;<img src="<?=$data['SubBtns']?>/<?=$value?>" align="absmiddle" onclick="javascript:document.all['button_<?=$idx?>'].checked=true" class="img-thumbnail"  style="height:60px;"></label>

          <? $idx++;}?>
                </div>
				
				
                
                <div class="col-sm-12 my-2 text-center">
                  <input type="submit" class="btn btn-primary" name="send" value="CONTINUE">
                  &nbsp; <input class="btn btn-primary" type="submit" name="cancel" value="BACK"> </div>
                                
      </div>
			   
	
    
    <? } ?>
  </form>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
