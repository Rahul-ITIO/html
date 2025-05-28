<? if(isset($data['ScriptLoaded'])){ ?>

<style>
/*class used for change clolr comes from db*/ 
.pricecolor font[color="green"]{color:#FFCC00 !important;} /*Change Order Amt. default green color added class comes from db*/
.pricecolor font[color="red"]{color: #CC0000 !important;}   /*Change Status default red color added class comes from db*/
</style>

<script>
var NameOfFile ="";	
	<? if(isset($data['NameOfFile'])){ ?>
		NameOfFile ="<?=$data['NameOfFile'];?>";		
	<? } ?>
$(document).ready(function(){
	<? if(isset($_GET['csearch'])&&!empty($_GET['csearch'])){ ?>
		$('.acc3.advLdiv').trigger('click');
	<? } ?>
});
</script>
<?
$title_icon=$data['fwicon']['transaction'];
if($data['PageName']=="Block Transaction"){
$title_icon=$data['fwicon']['blocktransaction'];
}else if($data['PageName']=="Test Transaction"){
$title_icon=$data['fwicon']['testtransaction'];
}else if($data['PageName']=="Recent Order"){
$title_icon=$data['fwicon']['recentorder'];
}else if($data['PageName']=="Withdraw Fund"){
$title_icon=$data['fwicon']['settlement'];
}

?>
<div class="container border rounded my-2 vkg my-2 clearfix_ice">
<div class="heading-buttons vkg my-2 ">
  <h4 class="float-start"><i class="<?=$title_icon;?>" > </i>
    <? if($data['PageName']=='Transactions'){ echo "All Transaction";}else{ echo prntext($data['PageName']);}?>
  </h4>
  <?
		//include file for payin tras list as per json 
		$payin_trnslist_json_file_from_theme=("../front_ui/{$data['frontUiName']}/common/template.payin_trnslist_json".$data['iex']);
		
		$payin_trnslist_json_file_from_default=("../front_ui/default/common/template.payin_trnslist_json".$data['iex']);
		if(file_exists($payin_trnslist_json_file_from_theme)){
			include($payin_trnslist_json_file_from_theme);
		}elseif(file_exists($payin_trnslist_json_file_from_default)){
			include($payin_trnslist_json_file_from_default);
		}
	?>
	
  <div class="clearfix" style="clear: both;"></div>
</div>
<div class="widget widget-gray widget-body-white" >
  <? if($post['action']=='select'){ ?>
  <!-- Transaction Search Bar -->
  <?
  //include search form comes from template/common folder
  $search_form=("../front_ui/{$data['frontUiName']}/common/template.trans_search_form".$data['iex']);
	if(file_exists($search_form)){
		include($search_form);
	}
	else{
		$search_form=("../front_ui/default/common/template.trans_search_form".$data['iex']);
		if(file_exists($search_form)){
			include($search_form);
		}
	}
  ?>
  <!-- End Transaction Search Bar -->
  <? if(isset($data['NameOfFile']) && (isset($post['settlement_optimizer'])&&trim($post['settlement_optimizer'])&&$post['settlement_optimizer']=='manually')){ ?>
  <div class="breadcrumb" id="withdraw_fund_for_css" style="height:inherit;<?=((isset($data ['HideAllMenu'])&&$data ['HideAllMenu'])?"display:block !important;":"")?>">
    <? include("../include/trans_balance_ui".$data['iex']);?>
    <div class="row w-100">
      <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a class="fund_3 text-decoration-none">Wire Fee : <b>
        <?=$post['ab']['account_curr_sys'];?>
        <?=$post['settlement_fixed_fee'];?>
        </b></a> </div>
      <? if(isset($data['ThisPageLabel'])&&$data['ThisPageLabel'] != 'Rolling'){ ?>
      <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a class="fund_3 text-decoration-none">
        <?=((isset($data['ThisPageLabel'])&&$data['ThisPageLabel'])?$data['ThisPageLabel']:'');?>
        Minimum: <b>
        <?=$post['ab']['account_curr_sys'];?>
        <?=$post['settlement_min_amt'];?>
        </b> </a></div>
      <? } ?>
      <? if($data['con_name']=='clk'&&isset($_SESSION['adm_login'])&&isset($_REQUEST['admin'])){ ?>
      <? if($post['total_mdr_amt']){ ?>
      <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a class="fund_3 text-decoration-none">Total MDR Amt. : <b>
        <?=$post['ab']['account_curr_sys'];?>
        <?=$post['total_mdr_amt'];?>
        </b></a></div>
      <? } ?>
      <? if($post['total_mdr_txtfee_amt']){ ?>
      <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a  class="fund_3">Transaction Fee : <b>
        <?=$post['ab']['account_curr_sys'];?>
        <?=$post['total_mdr_txtfee_amt'];?>
        </b></a></div>
      <? } ?>
      <? if($post['total_gst_fee']){ ?>
      <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a  class="fund_3"></i> Total GST Fee @
        <?=$post['gst_fee'];?>
        : <b>
        <?=$post['ab']['account_curr_sys'];?>
        <?=$post['total_gst_fee'];?>
        </b></a></div>
      <? } ?>
      <? } ?>
    </div>
  </div>
  <? } ?>
  <div style="clear:both;"></div>
  <div class="widget-body">
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
  <? }?>
  

</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
