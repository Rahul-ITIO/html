<? 	if((isset($_SESSION['login_adm']))||(isset($_SESSION['show_qr_request'])&&$_SESSION['show_qr_request']==1))
	{?>
<div class="col m-col">
    <label for="vtid"><?=$data['SOFT_POS_LABELS']?></label>
    <select name="qrcode_gateway_request" id="qrcode_gateway_request" class="form-select w-100">
    <option value=""><?=$data['SOFT_POS_LABELS']?></option>
	<option value="1" <? if(isset($post['MemberInfo']['qrcode_gateway_request'])&&$post['MemberInfo']['qrcode_gateway_request']==1){ ?> selected="selected" <? } ?>>Live</option>
	<option value="3" <? if(isset($post['MemberInfo']['qrcode_gateway_request'])&&$post['MemberInfo']['qrcode_gateway_request']!=1){ ?> selected="selected" <? } ?> >Inactive</option>
    </select>
  </div>
<?}?>

