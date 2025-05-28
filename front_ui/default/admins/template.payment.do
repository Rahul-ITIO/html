<? if(isset($data['ScriptLoaded'])){ ?>

<div class="container border bg-white">
<div class=" container vkg">
  <h4 class="my-2"><i class="<?=$data['fwicon']['money-check-dollar'];?>"></i> Send Money </h4>
  <div class="vkg-main-border"></div>
  </div>
  
  
    <? if($data['Error']){ ?>
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    <strong>Error!</strong><?=prntext($data['Error'])?>
  </div>
  <? } ?>
  
  
<? if(!$data['PostSent']){ ?>
<form method="post">

    <table class="table">

      <tr>
        <td>Send money To:</td>
       <td><input type="text" name="receiver" class="form-control" value="<?=prntext($post['receiver'])?>">
          <font class=remark>Please use username or e-mail.</font></td>
      </tr>
      <tr>
        <td>Amount to transfer,<?=prntext($data['Currency'])?> :</td>
        <td><input type="text" name="amount" class="form-control" value="<?=prnsumm($post['amount'])?>">
         
<font class="remark">Minimum amount you can transfer is <?=prntext($data['Currency'])?> <?=$data['PaymentMinSum']?>.</font></td>
      </tr>
      <tr>
        <td>Description (optional):</td>
        <td><textarea name="comments" class="form-control"><?=$post['comments']?></textarea></td>
      </tr>

    </table>
<div class="text-center my-2 text-start"><input type="submit" class="submit btn btn-primary" name="send" value="SEND NOW!"></div>
</form>
<? }else{ ?>
<?=prntext($data['Currency'])?>
<?=prnsumm($post['amount'])?>
was sent to merchant "
<?=$post['receiver']?>
".<br>
<br>
You should get notification e-mail about this transaction.<br>
<hr>
<center>
  <a href="payment.do">SEND MONEY TO OTHER MERCHANT</a>&nbsp;|&nbsp;<a href="index.do">HOME</a>
</center>
<? }?>


</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
