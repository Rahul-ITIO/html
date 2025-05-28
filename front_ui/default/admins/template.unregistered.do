<? if(isset($data['ScriptLoaded'])){ ?>
<input type="hidden" name="step" value="<?=$post['step']?>">

<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/js/jquery-te-1.4.0.css"/>
<script src="<?=$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>

<div class="container border my-1 rounded vkg">
<div class=" container px-0 vkg">
<h4 class="my-2"><i class="<?=$data['fwicon']['user-minus'];?>"></i> Un Registered Merchants<!-- (<?=sizeof($post['sl_confirms']);?>)--></h4>
</div>
  
  
	




<? if((isset($data['Error'])&& $data['Error'])){ ?>
						
<div class="alert alert-warning alert-danger fade show" role="alert">
  <strong>Error!</strong> <?=prntext($data['Error'])?>
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

<? } ?>


<? if((isset($data['sucess'])&& $data['sucess'])){ ?>

<div class="alert alert-success alert-danger fade show" role="alert">
  <strong>Success!</strong> our request add support ticket <?=prntext($post['subject'])?> (<?=$post['ticketid']?>).
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

<? } ?>
			
<? if($post['step']==1){ ?>			
<? if(sizeof($post['sl_confirms'])!=0){ ?>	 			
<div class="table-responsive-sm">

    <table class="table table-hover">
        <thead>
          <tr>
	<th scope="col">ID</th>
	<th scope="col">User Name</th>
	<th scope="col">Name</th>
    <th scope="col">E-Mail</th>
	<th scope="col">Code</th>
	<th scope="col">Date</th>
	<th scope="col">Action</th>
	
    </tr>
    </thead>
    <? 
	//print_r($post['sl_confirms']);
	$j=1; foreach($post['sl_confirms'] as $ind=>$value) {
		
			$sponsor=array();
			$sponsor=sponsor_id_details($value['sponsor']);
			//$more_details=array();
			$more_details=$sponsor[0]['more_details'];
			//echo $more_details;
			$more_details=json_decode($more_details,true);
			$s_host=((isset($more_details['Host']) &&$more_details['Host'])?$more_details['Host']:'');
			if($s_host){
				$host_s=$s_host;
			}else{
				$host_s=$data['Host'];
			}
			
	?>
	
    <tr>
		<td data-label="ID - " >		
<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_action_view'])&&$_SESSION['merchant_action_view']==1)){ ?>	
<?=$value['id']?>
<? }else{ ?>
<?=$value['id']?>		
<? } ?>	

		</td>
		<td><?=$value['newuser']?></td>
		<td><?=$value['newfullname']?></td>
		<td><?=encrypts_decrypts_emails($value['newmail'],2);?></td>
		<td><?=encryptres($value['confirm']);?></td>
		<td><?=prndatelog($value['created_date']);?></td>
		<td>
		  <a href="<?=$host_s;?>/confirm<?=$data['ex']?>?cid=<?=encryptres($value['confirm']);?>&action=by_admin" title="Confirm"  target='_blank'><i class="<?=$data['fwicon']['check-circle'];?> mx-2"></i></a>
		  <a href="<?=$data['Admins'];?>/unregistered<?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return cfmform()" title="Delete" ><i class="<?=$data['fwicon']['delete'];?> text-danger mx-2"></i></a>
		</td>
	</tr>
    <? $j++; }?>
</table>
</div>
<? }else{ ?>
<div class="alert alert-danger" role="alert"> <center><strong>No Records Found</strong></center> </div>
<? } ?>

<!-- // 5 page:start -->
<div class="pagination" style="float:left; width:100%; text-align:center;">

	<?php
		include("../include/pagination_pg".$data['iex']);
		
		
		if(isset($_GET['page'])){$page=$_GET['page'];unset($_GET['page']);}else{$page=1;}
		$get=http_build_query($_GET);
		$url=$data['Admins']."/unregistered{$data['ex']}?".$get;
		$total = (int)((isset($data['result_total_count'])&&$data['result_total_count'])?$data['result_total_count']:'');
		
		
		pagination(50,$page,$url,$total);
		
    	

	?>
</div>
<!-- // 5 page:end -->

<? }elseif($post['step']==2){ ?>
<? if($post['gid']){ ?>
<input type="hidden" name="gid" value="<?=$post['gid']?>">
<? } ?>




<div class="tab-pane active" id="account-settings">
			<div class="widget widget-2">
				<div class="widget-head">
					<h4 class="heading glyphicons settings"><i></i>Support Ticket</h4>
				</div>
				<div class="widget-body" style="padding-bottom: 0;">
					<div class="row-fluid">
						<div class="span9">
						
							<div class="separator"></div>		
							<input type="text" name="subject" placeholder="Enter The Full Subject" class="span10" value="<?=prntext($post[0]['subject'])?>" style="width:100%!important; height:30px;" />
							
							<div class="separator"></div>
							<textarea id="mustHaveId" class="span12 jqte-test" name="comments" rows="5" placeholder="Enter a Message" style="width:100%; height:80px;"><?=prntext($post[0]['comments'])?></textarea>

							<div class="separator"></div>
							<button type="submit" name="send" value="CONTINUE"  class="btn btn-icon btn-primary glyphicons circle_ok "><i></i>Submit</button>
						</div>


<? } ?>



<script>
	$('.jqte-test').jqte();
	
	// settings of status
	var jqteStatus = true;
	$(".status").click(function()
	{
		jqteStatus = jqteStatus ? false : true;
		$('.jqte-test').jqte({"status" : jqteStatus})
	});
</script>

</div> 
<? }else{ ?>SECURITY ALERT: Access Denied<?}?> 

</div>                                 