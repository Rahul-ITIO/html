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
		<i class="<?=$data['fwicon']['fees'];?>"></i> Softpos Setting : 
	
		  <span class="float-end text-end">
			<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['softpos_setting_edit'])&&$_SESSION['softpos_setting_edit']==1)){ ?>
			<a href="<?=$data['Admins'];?>/<?=$data['my_project']?><?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=update_softpos_setting&type=<?=$post['type']?><?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>" class="btn btn-icon btn-primary" title=" Edit Softpos Setting" ><i class="<?=$data['fwicon']['circle-plus'];?>"></i></a>
			<? } ?>
		  </span>
  </h5>
	<div class="clearfix"></div>
		  
  
	  <? if(@$post['SoftposInfo']){ 
	  
	 
	  ?>
			  
			 
		<div class="row row-cols-2 row-cols-lg-4 g-2 g-lg-3">
			 
			  
			  <? if(@$post['SoftposInfo']['softpos_pa']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"> <strong>PA : </strong>
				<?=@$post['SoftposInfo']['softpos_pa']?>
			  </div>
			  <? }if(@$post['SoftposInfo']['softpos_pn']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"> <strong>PN :</strong>
				<?=@$post['SoftposInfo']['softpos_pn']?>
			  </div>
			  <? }if(@$post['SoftposInfo']['softpos_terNO']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"> <strong>terNO :</strong>
				<?=$post['SoftposInfo']['softpos_terNO']?>
			  </div>
			  <? }if(@$post['SoftposInfo']['softpos_public_key']){ ?>
			  <div class="col-sm-4 my-2 px-2 card"><strong>Public key : </strong>
				<?=@$post['SoftposInfo']['softpos_public_key']?>
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
