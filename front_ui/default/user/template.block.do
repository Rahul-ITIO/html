<?  if(isset($data['ScriptLoaded'])){?>

<div id="wrapper">
<div id="content">
<ul class="breadcrumb">
  <li><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="glyphicons home"><i></i> <?=prntext($data['SiteName'])?></a></li>
  <li class="divider"></li>
  <li>Account Overview</li>
</ul>
<div class="separator"></div>
<div class="heading-buttons">
  <h3 class=""><i></i> Account Overview</h3>
  <div class="buttons pull-right"> <a href="<?=$data['USER_FOLDER']?>/transactions<?=$data['ex']?>" class="btn btn-block btn-default" style="padding:7px;">Current Balance
    <?=balance($data['Balance'])?>
    </a> </div>
  <div class="clearfix" style="clear: both;"></div>
</div>
<div class="separator"></div>
<div class="innerLR">
  <div class="row-fluid">
    <div class="span4">
      <div class="widget widget-4">
        <div class="widget-head">
          <h4 class="heading">Last Transaction</h4>
          <a href="<?=$data['USER_FOLDER']?>/transactions<?=$data['ex']?>" class="details pull-right">view all</a> </div>
        <div class="widget-body list">
          <ul>
            <li> <span>Amount</span> <span class="count">
              <?=$post['LastTransaction']['amount']?>
              </span> </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="span8">
      <div class="row-fluid">
        <div class="span4"> <a href="<?=$data['USER_FOLDER']?>/deposit<?=$data['ex']?>" class="widget-stats"> <span class="glyphicons coins"><i></i></span> <span class="txt">Deposit Funds</span>
          <div class="clearfix"></div>
          </a> </div>
        <div class="span4" style="margin-left: 10px;"> <a href="<?=$data['USER_FOLDER']?>/send<?=$data['ex']?>" class="widget-stats"> <span class="send"><i></i></span> <span class="txt" style="padding:0px;">Send Funds</span>
          <div class="clearfix"></div>
          </a> </div>
        <div class="span4"> <a href="<?=$data['USER_FOLDER']?>/request<?=$data['ex']?>" class="widget-stats"> <span class="glyphicons notes_2"><i></i></span> <span class="txt">Request Funds</span>
          <div class="clearfix"></div>
          </a> </div>
        <div class="span4" style="margin-left:0px;margin-top: 12px;"> <a href="<?=$data['USER_FOLDER']?>/withdraw<?=$data['ex']?>" class="widget-stats"> <span class="glyphicons wallet"><i></i></span> <span class="txt">Withdraw Funds</span>
          <div class="clearfix"></div>
          </a> </div>
        <div class="span4" style="margin-left: 10px;margin-top: 12px;"> <a href="<?=$data['USER_FOLDER']?>/affdetails<?=$data['ex']?>" class="widget-stats"> <span class="details"><i></i></span> <span class="txt" style="padding:0px;">Affiliate Details</span>
          <div class="clearfix"></div>
          </a> </div>
        <div class="span4" style="margin-top: 12px;"> <a href="<?=$data['USER_FOLDER']?>/affdownline<?=$data['ex']?>" class="widget-stats"> <span class="downline"><i></i></span> <span class="txt" style="padding:0px;">Affiliate Downline</span>
          <div class="clearfix"></div>
          </a> </div>
      </div>
    </div>
  </div>
</div>
<div class="separator bottom"></div>
<div class="well" style="margin-bottom:0px">
<div class="widget widget-gray widget-body-white">
  <div class="widget-head" style="border:1px solid #D1D2D3">
    <h4 class="heading">You have no access this time .Plese try after some time</h4>
  </div>
</div>
<div class="well"  style="margin-bottom:0px"> </div>
</table>
</center>
<?}else{?>
SECURITY ALERT: Access Denied
<?}?>
