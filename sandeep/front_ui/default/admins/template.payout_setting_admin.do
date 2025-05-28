<?
include('../include/fontawasome_icon'.$data['iex']); // for display fw icon on ajax call page
$clients_active_type = $_SESSION['MemberInfo']['active'];
$mtype = $data['MEMBER_TYPE'][$clients_active_type];

$is_admin=isset($post['is_admin'])&&$post['is_admin']?$post['is_admin']:'';
$post['type']=isset($post['type'])&&$post['type']?$post['type']:'';
?>

<div class="mt-2 table-responsive-sm">
<?
if((isset($_SESSION['login_adm']))||(isset($_SESSION[$mtype])&&$_SESSION[$mtype]==1))
{
?>
<div class="container border rounded my-1">  
  <div class="row">
	<h5 class="my-2">
		<i class="<?=$data['fwicon']['fees'];?>"></i> Payout Setting : 
	
	  <span class="float-end text-end">
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['payout_setting_edit'])&&$_SESSION['payout_setting_edit']==1)){ ?>
		<a href="<?=$data['Admins'];?>/<?=$data['my_project']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=update_payout_setting&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-icon btn-primary" title=" Edit Payout Setting" ><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a>
		<? } ?>
	  </span>
  </h5>
  
  <div class="clearfix"></div>
  
	  <? if(@$post['PayoutInfo'])
	  { 
	  ?>
			  
			 
		<div class="row row-cols-2 row-cols-lg-4 g-2 g-lg-3">
			 
			  
			  <? if(@$post['PayoutInfo']['payout_status']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"> <strong>Payout Status : </strong>
				<?=@$post['PayoutInfo']['payout_status']?>
			  </div>
			  <? }if(@$post['PayoutInfo']['payout_fixed_fee']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"> <strong>Payout Fixed fee :</strong>
				<?=@$post['PayoutInfo']['payout_fixed_fee']?>
			  </div>
			  <? }if(@$post['PayoutInfo']['payout_account']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"> <strong>Payout A/c :</strong>
				<?=$post['PayoutInfo']['payout_account']?>
			  </div>
			  <? }if(@$post['PayoutInfo']['scrubbed_period']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"><strong>Scrubbed Period : </strong>
				<?=@$post['PayoutInfo']['scrubbed_period']?>
			  </div>
			  <? }if(@$post['PayoutInfo']['min_limit']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"><strong>Min Trxn Limit : </strong>
				<?=@$post['PayoutInfo']['min_limit']?>
			  </div>
			  <? }if(@$post['PayoutInfo']['tr_scrub_success_count']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"><strong>Min Success Count : </strong>
				<?=@$post['PayoutInfo']['tr_scrub_success_count']?>
			  </div>
			   <? }if(@$post['PayoutInfo']['tr_scrub_failed_count']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"><strong>Min. Failed Count : </strong>
				<?=@$post['PayoutInfo']['tr_scrub_failed_count']?>
			  </div>
			   <? }if(@$post['PayoutInfo']['whitelisted_ips']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"><strong>Whitelisted IPs : </strong>
				<?=@$post['PayoutInfo']['whitelisted_ips']?>
			  </div>
			  
			  <? } ?>
			  
			  
			  
			 
		</div>
	  

			 
	<?
	}
	?>
</div>
</div>
</div>
<? 
}else
{
	include('../oops'.$data['iex']);
}
?>
<script>
//====================modal_iframe=============
	
	$('.modal_for_website').on('click', function(e){
      e.preventDefault();
	  //alert('show');
     // $('#myModal_web').modal('show').find('.modal-body').load($(this).attr('href'));
	  //$('#myModal_web .modal-dialog').css({"max-width":"80%"});
	  $('.modal-body iframe').attr('src',$(this).attr('href'));
      $('#myModal_web').modal('show');
	  $('#myModal_web .modal-dialog').css({"max-width":"95%"});
	  //$('.modal-title').html('View Website List');
    });
	

</script>
<!--  /////////// Start Modal Trans /////////////////-->
<div class="modal" id="myModal_web" style="display:none;">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><!--Heading--></h4>
        <button type="button" class="btn-close myModal_web_close"  data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <iframe src="" width="100%" height="600"></iframe>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger myModal_web_close"  data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<!--  /////////// END Modal Trans /////////////////-->
