<?if(isset($data['ScriptLoaded'])){?>
<?if(!$post['send']){?>

<form method=post>
  <table class=frame width=100% border=0 cellspacing=1 cellpadding=2>
    <tr>
      <td class=input align=center><br>
        <font color=red><b>PLEASE CONFIRM THAT YOU WANT TO CLOSE YOUR ACCOUNT</b></font><br>
        <br>
        <font class=remark>If you select "Close My Account" below, you will no longer have access to your account information.</font><br>
        <br></td>
    </tr>
  </table>
  <br>
  <table class=frame width=100% border=0 cellspacing=1 cellpadding=2>
    <tr>
      <td class=capc><input type=submit class=submit name=send value="CLOSE MY ACCOUNT">
        &nbsp;
        <input type=submit class=submit name=cancel value="CANCEL"></td>
    </tr>
  </table>
</form>
<?}else{?>
<table class=frame width=100% border=0 cellspacing=1 cellpadding=2>
  <tr>
    <td class=input align=center><br>
      <font color=red><b>Your
      <?=prntext($data['SiteName'])?>
      account has been closed.<br>
      <br>
      Thank you for using our service.<br>
      <br>
      <hr>
      <a href="<?=$data['Host']?>">
      <?=prntext($data['SiteName'])?>
      HOME PAGE</a></td>
  </tr>
</table>
<?}?>
<?}else{?>
SECURITY ALERT: Access Denied
<?}?>
