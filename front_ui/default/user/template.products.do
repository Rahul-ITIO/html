<?if(isset($data['ScriptLoaded'])){?>
<form method=post name=data>
  <div id="wrapper">
  <div id="content">
  <ul class="breadcrumb">
    <li><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="glyphicons home"><i></i>
      <?=prntext($data['SiteName'])?>
      </a></li>
    <li class="divider"></li>
    <li>Products</li>
  </ul>
  <div class="separator"></div>
  <div class="heading-buttons">
    <h3 class=""><i></i> My Products</h3>
    <div class="clearfix" style="clear: both;"></div>
  </div>
  <div class="separator"></div>
  <div class="well">
  <input type=hidden name=step value="<?=$post['step']?>">
  <?if($post['step']==1){?>
  <div class="widget widget-gray widget-body-white">
  <div class="widget-head" style="border:1px solid #D1D2D3">
    <h4 class="heading">Available Products</h4>
  </div>
  <div class="widget-body" style="padding: 10px 0;background:none repeat scroll 0 0 #FAFAFA">
  <table class="table table-bordered table-condensed" style="background:#fff">
    <tr>
      <td>NAME</td>
      <td>PRICE</td>
      <td>TAX</td>
      <td>SHIPPING</td>
      <td>SOLD</td>
      <td width=1%>ACTION</td>
    </tr>
    <?$idx=0;foreach($data['Products'] as $value){$bgcolor=$idx%2?'#EEEEEE':'#FFFFFF'?>
    <tr bgcolor=<?=$bgcolor?> onmouseover="setPointer(this, <?=$idx?>, 'over', '<?=$bgcolor?>', '#CCFFCC', '#FFCC99')" onmouseout="setPointer(this, <?=$idx?>, 'out', '<?=$bgcolor?>', '#CCFFCC', '#FFCC99')" onmousedown="setPointer(this, <?=$idx?>, 'click', '<?=$bgcolor?>', '#CCFFCC', '#FFCC99')">
      <td><?=prntext($value['name'])?></td>
      <td align=right><?=prntext($data['Currency'])?>
        <?=prnsumm($value['price'])?></td>
      <td align=center nowrap><?=prntext($data['Currency'])?>
        <?=prnsumm($value['tax'])?></td>
      <td align=center nowrap><?=prntext($data['Currency'])?>
        <?=prnsumm($value['shipping'])?></td>
      <td align=center nowrap><?=($value['sold']?$value['sold']:'0')?>
        Times<br>
        <font class=remark>(
        <?=prntext($data['Currency'])?>
        <?=prnsumm($value['price']*$value['sold'])?>
        )</font></td>
      <td align=center nowrap><a href="<?=$data['USER_FOLDER']?>/products<?=$data['ex']?>?id=<?=$value['id']?>&action=update">EDIT</a>|<a href="<?=$data['USER_FOLDER']?>/products<?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return cfmform()">DELETE</a><br>
        <a href="<?=$data['USER_FOLDER']?>/generate<?=$data['ex']?>?id=<?=$value['id']?>&action=products">GENERATE CODE</a><br>
        <a href="<?=$data['USER_FOLDER']?>/generate<?=$data['ex']?>?id=<?=$value['id']?>&action=products&status=crypt">ENCRYPT CODE</a></td>
    </tr>
    <?$idx++;}?>
    <tr>
      <td class=capc colspan=6><center>
          <button type=submit name=send value="ADD A NEW PRODUCT"  class="btn btn-icon btn-primary glyphicons circle_plus"><i></i>Add A New Product</button>
          
        </center></td>
    </tr>
  </table>
  <?}elseif($post['step']==2){?>
  <?if($post['gid']){?>
  <input type=hidden name=gid value="<?=$post['gid']?>">
  <?}?>
  <?if($data['Error']){?>
  <div class="alert alert-error">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Error!</strong>
    <?=prntext($data['Error'])?>
  </div>
  <?}?>
  <div class="tab-pane active" id="account-settings">
  <div class="widget widget-2">
  <div class="widget-head">
    <h4 class="heading glyphicons circle_plus"><i></i>Add A New Product</h4>
  </div>
  <div class="widget-body" style="padding-bottom: 0;">
  <div class="row-fluid">
  <div class="span9">
  <label for="pname">Product Name</label>
  <input type=text name=name placeholder="Please enter the Name of your Product" class="span10" value="<?=prntext($post['name'])?>">
  <label for="pname">Price in US $</label>
  <input type=text name=price placeholder="Please enter the Price of your Product" class="span10" value="<?=prnsumm($post['price'])?>">
  <span style="margin: 0;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="Do not enter any Dollar ($) signs, only digits."><i></i></span>
  <div class="separator"></div>
  <label for="tax">Tax in US $</label>
  <input type=text name=tax placeholder="Please enter the Price of your Product" class="span10" value="<?=prnsumm($post['tax'])?>">
  <span style="margin: 0;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="Do not enter any Dollar ($) signs, only digits."><i></i></span>
  <div class="separator"></div>
  <label for="shipping">Shipping Cost in US $</label>
  <input type=text name=shipping placeholder="Please enter the Shipping Cost for your Product" class="span10" value="<?=prnsumm($post['shipping'])?>">
  <span style="margin: 0;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="Do not enter any Dollar ($) signs, only digits."><i></i></span>
  <div class="separator"></div>
  <label for="rurl">Return URL</label>
  <input type=text name=ureturn placeholder="Please enter the Return URL for your Product" class="span10" value="<?=$post['ureturn']?>">
  <div class="separator"></div>
  <label for="unotify">Notify URL</label>
  <input type=text name=unotify placeholder="Please enter the Notify URL for your Product" class="span10" value="<?=$post['unotify']?>">
  <div class="separator"></div>
  <label for="ucancel">Cancellation URL</label>
  <input type=text name=ucancel placeholder="Please enter the Cancellation URL for your Product" class="span10" value="<?=$post['ucancel']?>">
  <div class="separator"></div>
  <label for="description">Description (Optional)</label>
  <textarea name=comments placeholder="Please Describe your Product" class="span11" cols=40 rows=6><?=prntext($post['comments'])?>
</textarea>
  <div class="separator"></div>
  <label for="ucancel">Please Select A Button</label>
  <td class=input><?$idx=1;foreach($post['Buttons'] as $key=>$value){$bgcolor=$idx%2?'#EEEEEE':'#E7E7E7'?>
    <label for=button_<?=$idx?> style="cursor:hand">
    <input class=checkbox type=radio id=button_<?=$idx?> name=button value="<?=$value?>"<?if($post['button']==$value){?> checked<?}?>>
    &nbsp;<img src="<?=$data['SinBtns']?>/<?=$value?>" align=absmiddle onclick="javascript:document.all['button_<?=$idx?>'].checked=true"></label>
    <br>
    <br>
    <?$idx++;}?></td>
  </tr>
  <div class="form-actions" style="margin: 0; padding-right: 0;">
    <button type=submit name=send value="CONTINUE"  class="btn btn-icon btn-primary glyphicons circle_plus pull-right"><i></i>Continue</button>
  </div>
  </table>
  <?}?>
</form>
</center>
<?}else{?>
SECURITY ALERT: Access Denied
<?}?>
