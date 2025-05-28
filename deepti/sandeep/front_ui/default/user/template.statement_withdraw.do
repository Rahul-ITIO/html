<?if(isset($data['ScriptLoaded'])){?>
<style>
	
.input_col_1 input.checkbox {width:24px;position:relative;top:-9px;}
.input_col_1 .radios label {width: auto;}
.separator {margin:0px 0;display:block;clear:both;}
.remarkcoment {
    width: 100% !important;
	min-height:60px !important;
}

label{font-weight:bold;color:#000;}



@media (max-width:760px){ 
	 #receiver_user_id {width:98% !important;}
	 .input_col_1 label {width: 55%;margin-top:0;margin-bottom:0;}
	 #amount_id {width:97% !important; margin:0 auto;margin-bottom:10px;float:left;}
	 .glyphicons.btn-action i::before{top:0 !important;left:55% !important;}
	 label[for="settlement_fixed_fee"]{width:75% !important;}
	 label[for="requested_currency_id"]{margin-top:20px !important;}
	 label[for="amount_cnvrt"]{width:60% !important;}
	 #requested_currency_id{width:98% !important; margin:0 auto !important;}
	 label[for="amount_id"]{width:98%;}
}
@media (max-width:675px){ 
	
	  #amount_id {width:95% !important; margin:0 auto;margin-bottom:10px;float:left;}
}
@media (max-width:600px){ 
	 .input_col_1 label {width: 98%;margin-top:0;margin-bottom:0;}
	  #amount_id {width:95% !important; margin:0 auto;margin-bottom:10px;float:left;}
}
@media (max-width:460px){ 
	
	  #amount_id {width:94% !important; margin:0 auto;margin-bottom:10px;float:left;}
}
</style>
<script>
</script>
<div id="wrapper">
<div id="content">
<form method="post" id="myFormReq" >
  <input type=hidden name=step value="<?=$post['step']?>">
  <?if($post['step']==1){?>
  <?if(!$data ['HideAllMenu']){?>
  <ul class="breadcrumb">
    <li><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="glyphicons home"><i></i>
      <?=prntext($data['SiteName'])?>
      </a></li>
    <li class="divider"></li>
    <li>
      <?=$data['ThisTitle'];?>
    </li>
  </ul>
  <div class="separator"></div>
  <div class="heading-buttons">
    <h3 class="" style="float:left;"><i></i>
      <?=$data['ThisTitle'];?>
    </h3>
    <?if(($post['withdraw_option']==2)&&(isset($_SESSION['login_adm']))){?>
    <?
if(!empty($_GET['ptdate'])){
	$tpdate  = date('Y-m-d',strtotime($_GET['ptdate']));
}elseif(!empty($_GET['pdate'])){
	$pdate  = date('Y-m-d',strtotime($_GET['pdate']));
	$fpdate = date("Y-m-d",strtotime("-$payoutdays day",strtotime($pdate)));
	$tpdate = date("Y-m-d",strtotime("+6 day",strtotime($fpdate)));		
}else{ 
  $pfdate = date("Y-m-d",strtotime("-36 day",strtotime(date("Y-m-01",strtotime("now") ) )));
  $tpdate = date('Y-m-d',strtotime("+18 day",strtotime("now")));
  
}
if(!empty($_GET['pfdate'])){
	$pfdate  = date('Y-m-d',strtotime($_GET['pfdate']));
}else{ 
	 $pfdate = date("Y-m-d",strtotime("-36 day",strtotime(date("Y-m-01",strtotime("now") ) )));
}
?>
    <div>
      <div class="daterangeform" style="margin:14px 0 0 0; float:left;">
        <input id="pfdate" name="pfdate" type="date" placeHolder="From dd-mm-yyyy" value="<?=$pfdate;?>" max="<?=date('Y-m-d');?>"   style="background-position:99%;height: 30px;line-height: 30px;" />
        <input id="ptdate" name="ptdate" type="date" placeHolder="To dd-mm-yyyy" value="<?=$tpdate;?>"  style="background-position:99%;height: 30px;line-height: 30px;" />
        <button id="payoutdaterange2" type="submit" name="payoutdaterange2" value="Payout"
				 class="payoutdaterange2 btn btn-icon btn-primary glyphicons circle_arrow_down"
				 style="display:inline-block;width:125;font-size:11px;text-transform:capitalize;margin:-11px 0 0 0;"><i></i>Payout Date</button>
      </div>
      <div id="daterangediv2">
        <ul class="topnav pull-right trs inline" style="margin:14px;float:left;">
          <li class="dropdown"> <a data-toggle="dropdown" class="glyphicons hand_down payoutpdf0" onClick="filteraction0(this)" style="width:auto;margin-left:-3px;">Payout
            <?
							if(isset($_GET['ptdate'])&&$_GET['ptdate']){
								echo ": ".date('d-m-Y',strtotime($_GET['ptdate']));
							}
					?>
            </a>
            <ul class="dropdown-menu pull-right">
              <li><a onClick="filteraction(this)" target="selltedview" href="<?=$trans_href;?>?action=select<?if(isset($type)){?>&type=<?=$type?><?}?>&status=-1&keyname=223&searchkey=<?=$post['TransactionDetails']['transaction_period']?>&bid=<?=$post['TransactionDetails']['receiver']?>" class="payoutpdf viewedcl glyphicons eye_open"><i></i><span>VIEW </span></a></li>
              <?if($paydLink){?>
              <li><a onClick="filteraction(this)" target="selltedview" data-action="selltedall" data-label="Settled List" data-reason="Settled by SWIFT Reference" data-href="<?=$data['Admins']?>/transactions/?bid=<?=$post['TransactionDetails']['receiver']?>&tp=<?=$post['TransactionDetails']['transaction_period']?>&id=<?=$post['TransactionDetails']['id']?><?php echo $common_get; ?>&action=payoutsellted&querytype=sellted" class="payoutpdf settledcl glyphicons ok"><i></i><span>SETTLED</span></a></li>
              <?}?>
              <li title="Acquirer Table: Calculations"><a onClick="filteraction(this)" target="pdfreport" href="<?=$data['Host']?>/payout_report_fee_dynamic_ac_db<?=$data['ex']?>?bid=<?=$post['bid']?>&pfdate=<?=$_GET['pfdate'];?>&ptdate=<?=$_GET['ptdate'];?>" class="payoutpdf pdfreportcl glyphicons file"><i></i><span>PDF REPORT-A/c.</span></a></li>
              <li title="Acquirer Transaction Flied: Calculations"><a onClick="filteraction(this)" target="pdfreport_dy" href="<?=$data['Host']?>/payout_report_fee_dynamic_tr_db<?=$data['ex']?>?bid=<?=$post['bid']?>&pfdate=<?=$_GET['pfdate'];?>&ptdate=<?=$_GET['ptdate'];?>" class="payoutpdf pdfreportcl_tr glyphicons file"><i></i><span>PDF REPORT-D.Tr.</span></a></li>
              <li title="Payout Transaction Flied: Calculations"><a onClick="filteraction(this)" target="pdfreport_1" href="<?=$data['Host']?>/payout_report_transaction_db<?=$data['ex']?>?bid=<?=$post['bid']?>&pfdate=<?=$_GET['pfdate'];?>&ptdate=<?=$_GET['ptdate'];?>" class="payoutpdf pdfreportcl_1 glyphicons file"><i></i><span>PDF REPORT-TR.</span></a></li>
              <li title="Multiple Report Not Match than Update "><a onClick="filteraction(this);popuploadig();" target="hform" href="<?=$data['Host']?>/transaction_fee_calculation<?=$data['ex']?>?bid=<?=$post['TransactionDetails']['receiver']?>&id=<?=$post['TransactionDetails']['id']?>&tp=<?=$post['TransactionDetails']['transaction_period']?><?php echo $common_get; ?>&action=select&querytype=tfcupdate" class="payoutpdf tfcupdate glyphicons cogwheel"><i></i><span>UPDATE </span></a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
    <?}?>
    <div class="clearfix" style="clear: both;"></div>
  </div>
  <?}?>
  <div class="separator"></div>
  <div class="well">
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
    <h4 class="heading glyphicons coins"><i></i>Options of
      <?=$data['ThisTitle'];?>
    </h4>
  </div>
  <div class="breadcrumb" style="height:inherit;<?=(($data ['HideAllMenu'])?"display:block !important;":"")?>">
    <?include("../include/summery_balance_link".$data['iex']);?>
    <div class="row100 funda px-2"> <a  class="fund_3"><i class="far fa-hand-point-right"></i>  Wire Fee : <b>
      <?=$post['ab']['account_curr_sys'];?>
      <?=$post['settlement_fixed_fee'];?>
      </b></a>
      <?if($data ['ThisPageLabel'] != 'Rolling'){?>
      <a  class="fund_3"><i class="far fa-hand-point-right"></i> 
      <?=$data['ThisPageLabel'];?>
      Minimum: <b>
      <?=$post['ab']['account_curr_sys'];?>
      <?=$post['settlement_min_amt'];?>
      </b> </a>
      <?}?>
      
    </div>
  </div>
  <div class="widget-body input_col_1" style="padding-bottom: 0;">
  <div class="row-fluid">
  <div class="span12">
  
  dddd
  
  
  <?}?>
</form>
<?}else{?>
SECURITY ALERT: Access Denied
<?}?>
