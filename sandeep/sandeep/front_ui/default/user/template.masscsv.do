<?if(isset($data['ScriptLoaded'])){?>

<center>
  <form method=post>
    <input type=hidden name=step value="<?=$post['step']?>">
    <input type=hidden name=upfile1 value="<?=$post['upfile1']?>">
    <table class=frame width=340 border=0 cellspacing=1 cellpadding=4>
      <?if($data['Error']){?>
      <tr>
        <td colspan=2 class=error><?=prntext($data['Error'])?></td>
      </tr>
    </table>
    <?}?>
    <?if(($post['step']==1)&&(!$data['Error'])){?>
    <tr>
      <td class=capl colspan=2>Please check the following information:</td>
    </tr>
    <tr>
      <td class=capl colspan=2>Total of:
        <?=$post['real_sum']?>
        to
        <?=$post['user_count']?>
        Merchant</td>
    </tr>
    <tr>
      <td colspan=2><?=prntext($post['message_ins'])?></td>
    </tr>
    <tr>
      <td class=capc colspan=2><input class=submit type=submit name=sendbtn value="CONFIRM"></td>
      </table>
      <?}elseif($post['step']==2){?>
      <table class=frame width=340 border=0 cellspacing=1 cellpadding=4>
        <tr>
          <td class=capl colspan=2>You have successfully performed your payments using the .csv file function!</td>
        </tr>
        <tr>
          <td colspan=2><?=prntext($post['message_ins'])?></td>
        </tr>
        <tr>
          <td class=capc colspan=2><input class=submit type=submit name=sendbtn value="CONTINUE"></td>
      </table>
      <?}?>
  </form>
</center>
<?}else{?>
SECURITY ALERT: Access Denied
<?}?>
