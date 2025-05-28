<link href="css/dp.css" rel="stylesheet" type="text/css" />
<script src="src/jquery.js" type="text/javascript"></script>
<script src="src/Plugins/datepicker_lang_US.js" type="text/javascript"></script>
<script src="src/Plugins/jquery.datepicker.js" type="text/javascript"></script>
<script type="text/javascript">
        $(document).ready(function() {           
           
            $(".temptime").datepicker({ picker: "<img class='picker' align='middle' src='sample-css/cal.gif' alt=''/>" });
       
        });
    </script>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive.css" rel="stylesheet">
<? if(isset($data['ScriptLoaded'])){ ?>
<div class="container border mt-2 mb-2 bg-white vkg" >


  <? if($post['step']==1){?>
    <h4 class="my-2"><i class="<?=$data['fwicon']['bar'];?>"></i> Resolution Center</h4>
    <form method="post" name="data">
      <input type="hidden" name="step" value="<?=$post['step']?>">
	  <div class="row">
	  
	      <div class="col-sm-6">
	  <div class="input-group mb-3"> <span class="input-group-text col-sm-3" id="basic-addon1">Select From Date :</span>
            <input type="date" class="form-control temptime" name="date1" id="date1" placeholder="From Date" value="" autocomplete="off" required="">
          </div></div>
		  
		  <div class="col-sm-6">
		  <div class="input-group mb-3"> <span class="input-group-text col-sm-3" id="basic-addon1">Select To Date :</span>
            <input type="date" class="form-control temptime" name="date2" id="date2" placeholder="Wallet Provider" value="" autocomplete="off" required="">
          </div></div>
		  
		  <div class="col-sm-6 my-2">
            <input type="submit" value="submit"  name="send" class="btn btn-primary"/>
          </div>
		  
      </div>
    </form>
  
  <? } ?>
  <? if($post['step']==2){ ?>
  
    <h4 class="my-2"><i class="<?=$data['fwicon']['role-list'];?>"></i> Transaction Detail</h4>
  
  <form method="post" name="data">
  <input type="hidden" name="step" value="<?=$post['step']?>">
  <div class="mt-2 table-responsive">
    <table class="table">
      <tr class="bg-primary">
        <th>Transaction Id</th>
        <th>Date</th>
        <th>Amount</th>
      </tr>
      <? $idx=0;$bgcolor=$idx%2?'#EEEEEE':'#FFFFFF'?>
      <? foreach($post['transBetween'] as $key=>$value){ ?>
      <tr>
        <td data-label="Transaction Id"><?=$value['transaction_id']?></td>
        <td data-label="Date"><?=date("d-m-Y" ,strtotime($value['tdate']))?></td>
        <td data-label="Amount"><?=$value['amount']?></td>
      </tr>
      <? }?>
    </table>
  </div>
    <h4 class="my-2"><i class="<?=$data['fwicon']['role-list'];?>"></i> Transaction Detail  (UnRegistor Merchant)</h4>
  <form method="post" name="data">
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <div class="mt-2 table-responsive">
      <table class="table">
        <tr class="bg-primary">
          <th>Transaction Id</th>
          <th>Date</th>
          <th>Amount</th>
        </tr>
        <? $idx=0;$bgcolor=$idx%2?'#EEEEEE':'#FFFFFF'?>
        <? foreach($post['transBetweenUnreg'] as $key=>$value){ ?>
        <tr>
          <td data-label="Transaction Id"><?=$value['transaction_id']?></td>
          <td data-label="Date"><?=date("d-m-Y" ,strtotime($value['tdate']))?></td>
          <td data-label="Amount"><?=$value['amount']?></td>
        </tr>
        <? }?>
      </table>
    </div>
<div class="my-2">
<input type="submit" value="Back"  name="back" class="btn btn-primary my-2"/>
</div>
    
</form>

<? } ?>
</div>

<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
