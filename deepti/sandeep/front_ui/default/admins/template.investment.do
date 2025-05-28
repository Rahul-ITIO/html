<? if(isset($data['ScriptLoaded'])){ ?>

<div class="container border bg-white">
<div class=" container vkg">
  <h4 class="my-2"><i class="<?=$data['fwicon']['money-check-dollar'];?>"></i> Invest Money To System Account </h4>
  <div class="vkg-main-border"></div>
  </div>
  
    <? if($data['Error']){ ?>
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    <strong>Error!</strong><?=prntext($data['Error'])?>
  </div>
  <? } ?>
  
 <h6 class="text-danger">You must use this option only if you wish to synchronize your real and virtual money.</h6>
<? if(!$data['PostSent']){ ?>
<form method="post">

    <table class="table">
      <tr>
        <td>Amount to invest, <?=prntext($data['Currency'])?>:</td>
        <td><input type="text" name="amount" class="form-control" value="<?=prnsumm($post['amount'])?>">

<font class=remark>Minimum amount you can transfer is <?=prntext($data['Currency'])?> <?=$data['PaymentMinSum']?> .</font></td>
      </tr>
      <tr>
        <td>Description (optional):</td>
        <td><textarea name="comments" class="form-control"><?=$post['comments']?></textarea>
          <font class=remark>Here you should describe reason for investing.</font></td>
      </tr>

    </table>
	<div class="text-center my-2"><input type="submit" class="submit btn btn-primary" name="send" value="SEND NOW!"></div>

</form>
<? }else{ ?>
<?=prntext($data['Currency'])?>
<?=prnsumm($post['amount'])?>
was invested to your system account.<br>
<hr>
<center>
  <a href="investment.do">INVEST AGAIN</a>&nbsp;|&nbsp;<a href="index.do">HOME</a>
</center>
<? }?>

</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
