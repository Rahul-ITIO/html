<?if(isset($data['ScriptLoaded'])){?>
  <center>
    <form method=post>
      <table class=frame width=500 border=0 cellspacing=1 cellpadding=4>
        <tr><td class=capl colspan="2">PLEASE SELECT HTML TEMPLATE:</td></tr>
        <tr><td class=input><select name=template style="width:50%">
          <?=showselect($post['Templates'], $post['template'])?></select>
        </td>
        <td class=input>
          <select name=lang style="width:50%">
            <? showselectlangs(); ?>
          </select>
        </td></tr>
        <tr><td class=capc colspan="2"><input class=submit type=submit name=read value="OPEN NOW!"></td></tr>
      </table>
      <?if($post['template']){?>
      <br>
      <table class=frame width=100% border=0 cellspacing=1 cellpadding=4>
        <tr><td class=capl colspan=2>CURRENT TEMPLATE IS: <?=$post['template']?></td></tr>
        <tr>
          <td class=input colspan=2>
            <textarea name=content rows=20 style="font-family:Courier New;font-size:12px;width:100%">
              <?=stripslashes($post['content'])?>
            </textarea></td></tr><tr><td class=capc>
            <input class=submit type=submit name=send value="CHANGE NOW!">
          </td>
          <td class=capc width=1%>
            <input type=button class=submit 
                   onclick="window.open('<?=$data['Admins']?>/htmleditor/editor.do',
                                        'Editor',
                                        'top=100px,left=100px,
                                                   width=768px,height=420px,location=no,resizable=no,directories=no,
                                                   menubar=no,scrollbars=no,status=no,titlebar=no,toolbar=no')" 
                   value="WYSYWING EDITOR">
          </td>
        </tr>
      </table>
      <?}?>
    </form>
  </center>
<?}else{?>SECURITY ALERT: Access Denied<?}?>