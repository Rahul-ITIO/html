<? if(isset($data['ScriptLoaded'])){ ?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive_999.css" rel="stylesheet">
<style>
.settle_withdraw , .settle_withdraw2 {display:none !important;}

.pricecolor font[color="green"]{color:#FFCC00;  !important;}
.pricecolor font[color="red"]{color: #CC0000; !important;}
html .s_section select.form-select{-webkit-appearance:none !important;-moz-appearance:none !important;}

[type="date"] {background: #fff url(<?=$data['Host']?>/images/calendar_2.png) 94% 50% no-repeat;background-color: rgb(255, 255, 255);background-color: rgb(255, 255, 255);background-size:18px;}
[type="date"]::-webkit-inner-spin-button {display: none;  width:0px;}
[type="date"]::-webkit-calendar-picker-indicator {opacity: 0; width:30px !important; min-width:30px !important;} 

.datepicker-toggle{float:left;display:inline-block;position:relative;width:18px;height:19px}.datepicker-toggle-button{position:absolute;left:0;top:0;width:100%;height:100%;background:#fff url(<?=$data['Host']?>/images/calendar_2.png);background-size:100%}.datepicker-input{position:absolute;left:0;top:0;width:100%;height:100%;opacity:0;cursor:pointer;box-sizing:border-box}.datepicker-input::-webkit-calendar-picker-indicator{position:absolute;left:0;top:0;width:100%;height:100%;margin:0;padding:0;cursor:pointer}

.rounded-tringle {height:100px !important;}

</style>
<script>
var NameOfFile ="";	
	<? if(isset($data['NameOfFile'])){ ?>
		NameOfFile ="<?=$data['NameOfFile'];?>";		
	<? } ?>
$(document).ready(function(){
	<?if(isset($_GET['csearch'])&&!empty($_GET['csearch'])){?>
		$('.acc3.advLdiv').trigger('click');
	<?}?>
});
</script>


<div class="container border rounded my-2 row pe-0 me-0">

<div class="heading-buttons vkg1 my-2 "><h4 class="px-2">
<? if($data['PageName']=="My Settlement"){?>
<i class="fa-solid fa-handshake"></i>
<? }else{ ?>
<i class="fas fa-clipboard-list"></i>
<? } ?>
 
<? if($data['PageName']=='statement'){ echo "All Transaction";}else{ echo prntext($data['PageName']);}?></h4>
    

</div>

    <div class="row pe-0" >
	     
      <? if($post['action']=='select'){ ?>
	     <!-- End Transaction Search Bar -->
	
 
   
	  
	  <!-- Transaction Search Bar -->
	 
  <?
  //search form
  $search_form=("../front_ui/{$data['frontUiName']}/common/template.search_form".$data['iex']);
	if(file_exists($search_form)){
		include($search_form);
	}
	else{
		$search_form=("../front_ui/default/common/template.search_form".$data['iex']);
		if(file_exists($search_form)){
			include($search_form);
		}
	}
  ?>
  
  
 
  <div style="clear:both;"></div>
  
  <div class="widget-bodyx row">
 
	
    <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <?=$_SESSION['action_success'];?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? $_SESSION['action_success']=0; } 
	  $cnttot=count($post['Transactions']);
	  ?>
	  
	  
    <div class="table-responsive">
	
	
	
	
	  <?
		//include file for payin tras list as per json 
		$payin_trnslist_from_theme=("../front_ui/{$data['frontUiName']}/common/template.trnslist_dynamic".$data['iex']);
		
		$payin_trnslist_from_default=("../front_ui/default/common/template.trnslist_dynamic".$data['iex']);
		if(file_exists($payin_trnslist_from_theme)){
			include($payin_trnslist_from_theme);
		}elseif(file_exists($payin_trnslist_from_default)){
			include($payin_trnslist_from_default);
		}
	?>
	
	
	
	  
	  
      <?php if($cnttot == 0) { ?>
      <div><img title="No Transaction Found" src="<?=$data['Host']?>/images/not_transaction_found.png" style="width:100%;padding:0;" class="img-fluid" /></div>
      <? } ?>
      
      <div class="pagination" style="float:left; width:100%; text-align:center;" id="total_record_result">
        <?php
			//if(!isset($_SESSION['total_record_result']))
			if(!isset($_GET['tscount']))
			{
				include("../include/pagination_new".$data['iex']);
				
				if(isset($_GET['page'])){$page=$_GET['page'];unset($_GET['page']);}else{$page=1;}
				$get=http_build_query($_GET);
				$url=$data['USER_FOLDER']."/{$data['FileName']}?".$get;
				$total = (int)$data['tr_count'];
				short_pagination($data['MaxRowsByPage'],$page,$url,$data['last_record']);
			}
			else
			{
				include("../include/pagination_pg".$data['iex']);
				
				
				if(isset($_REQUEST['cl'])){unset($_REQUEST['cl']);}
				
				if(isset($_REQUEST['page'])){$page=$_REQUEST['page'];unset($_REQUEST['page']);}else{$page=1;}
				if(isset($_REQUEST['tscount'])){$tscount=$_REQUEST['tscount'];unset($_REQUEST['tscount']);}else {$tscount=0;}
			
				$get=http_build_query($_REQUEST);
			
                // $url="transactions".$data['ex']."?".$get;

				$url=$data['USER_FOLDER']."/{$data['FileName']}?".$get;

				if(isset($post['bid'])){$url.="&bid=".$post['bid'];}
				if(isset($post['type'])){$url.="&type=".$post['type'];}
				if(isset($post['status'])){$url.="&status=".$post['status'];}
				if(isset($post['action'])){$url.="&action=select";}
				if(isset($post['order'])){$url.="&order=".$post['order'];}
				if(isset($post['searchkey'])){$url.="&searchkey=".$post['searchkey'];}
				
				if(isset($_GET['page'])){$page=$_GET['page'];}else{$page=1;}
				
				pagination($data['MaxRowsByPage'],$post['StartPage'],$url,$tscount);
			}
			?>

      </div>
    </div>
  </div>
  <? if(isset($data['NameOfFile'])){ ?>
  <div style="float:left;clear:both;width:100%;text-align:center;">
    <script> 
	function confirm_2mfa(theTitle,theUrl){
	let is2mfa = confirm(theTitle);
	if(is2mfa){
	window.location.href=theUrl;
	}
	}
</script>
  </div>
  <? } ?>
  
	
      <? }elseif($post['action']=='details'){ ?>
      <div class="table-responsive">
        <table>
          <tr>
            <td class="capl" colspan="2"><B>Transaction Details</B></td>
          </tr>
          <tr>
            <td class="capl" colspan="2"><HR></td>
          </tr>
          <tr>
            <td class="field" width="50%" nowrap>Date of Trade:</td>
            <td class="input" width="50%" nowrap><?=prndate($post['Transaction']['tdate'])?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Username,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class="input" nowrap><? if($post['Transaction']['userid']>0){ ?>
              <a href="userinfo<?=$data['ex']?>?id=<?=$post['Transaction']['userid']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=view">
              <?=$post['Transaction']['username']?>
              </a>
              <? }else{ ?>
              <?=prntext($post['Transaction']['username'])?>
              <? } ?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Amount,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class="input" nowrap><?=$post['Transaction']['amount']?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Fee,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class="input" nowrap><?=prnfees($post['Transaction']['fees'])?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Paid,
              <?=prntext($data['Currency'])?>
              :</td>
            <td class="input" nowrap><?=$post['Transaction']['nets']?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Type:</td>
            <td class="input" nowrap><?=$post['Transaction']['type']?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Status:</td>
            <td class="input" nowrap><?=$post['Transaction']['status']?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Description:</td>
            <td class="input"><?=prntext($post['Transaction']['comments'])?></td>
          </tr>
          <? if($post['Transaction']['ecomments']){ ?>
          <tr>
            <td class="capl" colspan="2" nowrap>ADDITIONAL INFORMATION</td>
          </tr>
          <tr>
            <td class="input" colspan="2"><br>
              <pre class=info><?=prntext($post['Transaction']['ecomments'])?>
</pre></td>
          </tr>
          <? } ?>
          <tr>
            <td class="capl" colspan="2"><B>BUYER'S DETAIL</B></td>
          </tr>
          <tr>
            <td class="capl" colspan="2"><HR></td>
          </tr>
          <tr>
            <td class="field" nowrap>Customer Name:</td>
            <td class="input" nowrap><? if($post['Transaction']['userid']>0){ ?>
              <a href="userinfo<?=$data['ex']?>?id=<?=$post['Transaction']['userid']?><? if(isset($post['StartPage'])){ ?>&page=<?=$post['StartPage']?><? } ?>&action=view">
              <?=$post['Transaction']['names']?>
              </a>
              <? }else{ ?>
              <?=prntext($post['Transaction']['names'])?>
              <? } ?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Customer Address:</td>
            <td class="input" nowrap><?php if($post['Transaction']['address']){ ?>
              <?=$post['Transaction']['address']?>
              -
              <?=$post['Transaction']['city']?>
              (
              <?=$post['Transaction']['state']?>
              )
              <?=$post['Transaction']['zip']?>
              <?php } ?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Last four digits of card used:</td>
            <td class="input" nowrap><?php if($post['Transaction']['card']){ ?>
              <?php 
					$ccno = $post['Transaction']['card'];
					$string_ccno = substr($ccno,12,16);
					echo "XXXXXXXXXXXX".$string_ccno; ?>
              <?php } ?>
            </td>
          </tr>
          <tr>
            <td class="field" nowrap>Phone number:</td>
            <td class="input" nowrap><?=$post['Transaction']['phone_no']?></td>
          </tr>
          <tr>
            <td class="field" nowrap>Email address:</td>
            <td class="input" nowrap><?=$post['Transaction']['email_add']?></td>
          </tr>
          <tr>
            <td class="capc" colspan="8"><? if($post['Transaction']['canrefund']){ ?>
              <a href="<?=$data['USER_FOLDER']?>/<?=$data['FileName']?>?id=<?=$post['Transaction']['id']?><? if($post['StartPage']){ ?>&page=<?=$post['StartPage']?><? } ?>&action=refund" onclick="return cfmform()">REFUND</a>&nbsp;|&nbsp;
              <? } ?>
              <a href="javascript:history.back()">BACK</a></td>
          </tr>
        </table>
      </div>
      <? }else if($post['action']=='search'){ ?>
      <form method="post">
        <input type="hidden" name="action" value="<?=$post['action']?>">
        <input type="hidden" name="page" value="<?=$post['StartPage']?>">
        <div class="table-responsive">
          <table>
            <tr>
              <td class="capc" colspan="2">SEARCH OPTIONS</td>
            </tr>
            <tr>
              <td class="field" nowrap><label for=field1>Search by the username
                <input type="radio" class="checkbox" id="field1" name="field" value="username" checked onclick="username.disabled=false;day.disabled=true;month.disabled=true;year.disabled=true">
                </label></td>
              <td class="input"><input type="text" name="username" size="40" maxlength="255"></td>
            </tr>
            <tr>
              <td class="field" nowrap><label for=field2>Search by the date
                <input type="radio" class="checkbox" id="field2" name="field" value="tdate" onclick="username.disabled=true;day.disabled=false;month.disabled=false;year.disabled=false">
                </label></td>
              <td class="input"><select name="day" class="form-select" disabled>
                  <?=showselect($data['StatDays'], $post['day'])?>
                </select>
                &nbsp;
                <select name="month" class="form-select" disabled>
                  <?=showselect($data['StatMonth'], $post['month'])?>
                </select>
                &nbsp;
                <select name="year" class="form-select" disabled>
                  <?=showselect($data['StatYear'], $post['year'])?>
                </select></td>
            </tr>
            <tr>
              <td class="capc" colspan="2"><input type="submit" class="submit" name="cancel" value="BACK">
                &nbsp;
                <input type="submit" class="submit" name="search" value="SEARCH NOW!"></td>
            </tr>
          </table>
        </div>
      </form>
      <? } ?>
     
   </div> 



<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
