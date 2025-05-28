<? if(isset($data['ScriptLoaded'])){ ?>

<div class="container-sm mt-2 mb-2 border bg-white rounded vkg" >


<? if(!$data['PostSent']){ ?>
<style>
.separator {display: none;}
</style>
<form method=post>
  <div id="wrapper">
  <div id="content">
  <ul class="breadcrumb">
    <li><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="glyphicons home"><i></i>
      <?=prntext($data['SiteName'])?>
      </a></li>
    <li class="divider"></li>
    <li>Send Money</li>
  </ul>
  <div class="separator"></div>
  <div class="heading-buttons">
    <h3 class=""><i></i> Send Money</h3>
    <div class="clearfix" style="clear: both;"></div>
  </div>
  <div class="separator"></div>
  <div class="well">
  <? if($data['Error']){ ?>
  <div class="alert alert-error">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Error!</strong>
    <?=prntext($data['Error'])?>
  </div>
  <? } ?>
  <div class="tab-pane active" id="account-settings">
  <div class="widget widget-2">
  <div class="widget-head">
    <h4 class="heading glyphicons">Your Current Balance Is:
      <?=balance($data['Balance'])?>
    </h4>
  </div>
  <div class="widget-body" style="padding-bottom: 0;">
  <div class="row-fluid input_col_1">
  <div class="span12">
    <label for="Receiver">Send Money To</label>
    <input type=text name=receiver placeholder="Enter a Username or Email Address" class="span10" value="<?=prntext($post['receiver'])?>">
    <div class="separator"></div>
    <label for="Amount">Amount To Transfer <span style="margin: 0;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="The Minimum Amount You May Transfer is <?=prntext($data['Currency'])?><?=prnsumm($data['PaymentMinSum'])?>"><i></i></span></label>
    <input type=text name=amount placeholder="Please Enter The Desired Amount To Transfer" class="span10" value="<?=prntext($post['amount'])?>">
    <div class="separator"></div>
    <label for="comments">Description (Optional)</label>
    <textarea id="mustHaveId" class="" name=comments rows="5" placeholder="Enter a Message for the Receiver."  style="height:50px;"><?=prntext($post['comments'])?></textarea>
    <div class="separator"></div>
    <div class="" style="margin: 0; padding-right: 0;">
      <button type=submit name=send value="SEND NOW!"  class="btn btn-icon btn-primary glyphicons circle_ok" style="width:97%;"><i></i>Transfer</button>
    </div>
</form>
<? }else{ ?>
<div id="wrapper">
<?=prntext($data['SiteName'])?>
<div id="content">
<ul class="breadcrumb">
  <li><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="glyphicons home"><i></i> <?=prntext($data['SiteName'])?></a></li>
  <li class="divider"></li>
  <li>Send Money</li>
</ul>
<div class="separator"></div>
<div class="heading-buttons">
  <h3 class=""><i></i> Send Money</h3>
  <div class="clearfix" style="clear: both;"></div>
</div>
<div class="separator"></div>
<div class="well">
<div class="alert alert-success">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Success!</strong>
  <?=prntext($data['Currency'])?>
  <?=prnsumm($post['amount'])?>
  was sent to "
  <?=prntext($post['receiver'])?>
  ". You will receive a notification e-mail confirming this transaction. </div>

<table class=frame width=100% border=0 cellspacing=1 cellpadding=2>
  <tr>
    <td class=capc><a href="<?=$data['USER_FOLDER']?>/send<?=$data['ex']?>">SEND MONEY TO ANOTHER MERCHANT</a>&nbsp;|&nbsp;<a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>">ACCOUNT OVERVIEW</a></td>
  </tr>
</table>
<? } ?>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
