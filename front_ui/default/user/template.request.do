<? if(isset($data['ScriptLoaded'])){ ?>
<div class="container border mt-2 mb-2 bg-white" >
<? if(!$data['PostSent']){ ?>


<h4 class="my-2"><i class="<?=$data['fwicon']['home'];?>"></i> Request Money</h4>

  <? if($data['Error']){ ?>
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
  <strong>Error!</strong> <?=prntext($data['Error'])?>
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? }?>

    <h4 class="heading glyphicons cargo"><i></i>Request A Payment</h4>

<form method=post>
    <label for="Receiver">Request Money From</label>
    <input type="text" name="rname" placeholder="Enter The Full Name Of The Receiver" class="span10" value="<?=prntext($post['rname'])?>">
    <div class="separator"></div>
    <label for="Receiver">Receivers Email Address</label>
    <input type="text" name="remail" placeholder="Enter The Receivers Email Address" class="span10" value="<?=prntext($post['remail'])?>">
    <div class="separator"></div>
    <label for="Receiver">Amount Payable</label>
    <input type="text" name="amount" placeholder="Enter The Full Amount" class="span10" value="<?=prnsumm($post['amount'])?>">
    <div class="separator"></div>
    <label for="comments">Description (Optional)</label>
    <textarea id="mustHaveId" class="form-control" name="comments" rows="5" placeholder="Enter a Message for the Receiver.">
<?=prntext($post['comments'])?>
</textarea>
  
    <div class="form-actions" style="margin: 0; padding-right: 0;">
      <button type="submit" name="send" value="SEND NOW!"  class="btn btn-icon btn-primary glyphicons circle_ok pull-right"><i></i>Request Money</button>
    </div>
</form>
<? }else{ ?>
<div id="wrapper">
<div id="menu" class="hidden-phone">
  <div id="menuInner">
    <ul>
      <li class="heading"><span>Navigation</span></li>
      <li class="glyphicons home"><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>"><i></i><span>Dashboard</span></a></li>
      <li class="hasSubmenu"> <a data-toggle="collapse" class="glyphicons user" href="#menu_profile"><i></i><span>My Account</span></a>
        <ul class="collapse" id="menu_profile">
          <li class=""><a href="<?=$data['USER_FOLDER']?>/profile<?=$data['ex']?>"><span>Edit My Account</span></a></li>
          <li class=""><a href="<?=$data['USER_FOLDER']?>/emails<?=$data['ex']?>"><span>Add/Edit Emails</span></a></li>
          <li class=""><a href="<?=$data['USER_FOLDER']?>/password<?=$data['ex']?>"><span>Account Security</span></a></li>
        </ul>
      </li>
      <li class="glyphicons credit_card"><a href="<?=$data['USER_FOLDER']?>/card<?=$data['ex']?>"><i></i><span>My Credit Cards</span></a></li>
      <li class="glyphicons bank"><a href="<?=$data['USER_FOLDER']?>/bank<?=$data['ex']?>"><i></i><span>My Bank Accounts</span></a></li>
    </ul>
    <ul>
      <li class="heading"><span>Merchants</span></li>
      <li class="glyphicons cargo"><a href="products<?=$data['ex']?>"><i></i><span>Products</span></a></li>
      <li class="glyphicons coffe_cup"><a href="donations<?=$data['ex']?>"><i></i><span>Donations</span></a></li>
      <li class="glyphicons restart"><a href="subscriptions<?=$data['ex']?>"><i></i><span>Subscriptions</span></a></li>
      <li class="glyphicons shopping_cart"><a href="shopcart<?=$data['ex']?>"><i></i><span>Shopping Cart</span></a></li>
      <li class="glyphicons magic"><a href="payment<?=$data['ex']?>"><i></i><span>Simple Payments</span></a></li>
      </li>
    </ul>
  </div>
</div>

<ul class="breadcrumb">
  <li><a href="index<?=$data['ex']?>" class="glyphicons home"><i></i>
    <?=prntext($data['SiteName'])?>
    </a></li>
  <li class="divider"></li>
  <li>Request Money</li>
</ul>
<div class="heading-buttons">
  <h3 class=""><i></i> Request Money</h3>
  <div class="clearfix" style="clear: both;"></div>
</div>

<div class="alert alert-success">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Success!</strong> Your request with the Invoice URL was sent to
  <?=prntext($post['rname'])?>( <?=prntext($post['remail'])?> ).<br>
  <br>
  You will be notified via e-mail once the payment is completed. </div>

<table class=frame width=100% border=0 cellspacing=1 cellpadding=2>
  <tr>
    <td class=capc><a href="<?=$data['USER_FOLDER']?>/request<?=$data['ex']?>">SEND NEW REQUEST</a>&nbsp;|&nbsp;<a href="index<?=$data['ex']?>">ACCOUNT OVERVIEW</a></td>
  </tr>
</table>
</div>
<? }?>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
