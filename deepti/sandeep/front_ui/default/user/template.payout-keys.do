<? if(isset($data['ScriptLoaded'])){ 
	global $uid;
?>
<style> .dropdown-divider{border-top: 1px solid #000000 !important;} </style>
<div id="zink_id" class="container my-2 border bg-primary rounded" >
<div class="container my-2 px-0" >
		<div class="row">
			<div class="col-sm-12 ">
				<div><h4><i class="<?=$data['fwicon']['payout-secret-keys'];?>"></i> API Keys & Secret Keys</h4></div>
			</div>
		</div>
	
	
	


<? 
if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>

	<div class="alert alert-success alert-dismissible fade my-2 show" role="alert" > <?php echo $_SESSION['action_success'];?>
	
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</div>
	<? 
	unset($_SESSION['action_success']);
	
} ?>






<?php if((!isset($_GET['action']) || $_GET['action']!='update') and (!isset($post['step']) || $post['step']!="2")){ ?>




	
	<form method="post" name="data">
	<?=$data['is_admin_input_hide'];?>
	<input type="hidden" name="action" value="payout_secret_key" />
	<div class="px-2 border my-2 py-2 bg-body-secondary rounded">

		<div class="row">
		
			<div class="col my-2 ">
			<h2> Secret Key 
			  <div class="fw-light mt-1" style="font-size:12px;"><? if(isset($post['private_key'])&&$post['private_key']){ echo api_masking($post['private_key']); }else{ ?>Secret Key to be Generate <? }?> </div></h2>
	
			<b id="generate_secret_key2" class="text-break hide" ><?=$post['private_key'];?></b>
			</div>
				<div class="col my-2 ">
				<? if(isset($post['private_key'])&&$post['private_key']){?>  
				<a class="btn btn-icon btn-primary text-end " onclick="CopyToClipboard2('#generate_secret_key2')" title="Copy Secret Key - <?=$post['private_key'];?>"><i class="<?=$data['fwicon']['copy'];?>"></i></a> 
			<? }else{ ?>
			
			<?php /*?>// Generate Secret Key  from action and call function generate_secret_key()<?php */?>
				<a href="<?=$data['USER_FOLDER'];?>/<?=($data['PageFileName']);?><?=$data['ex']?>?action=generate_secret_key<?=$data['is_admin_link']?>" class="btn btn-icon btn-primary text-end " title="Generate Secret Key"><i class="<?=$data['fwicon']['rotate-right'];?>"></i></a>
			<? } ?>
			</div>
			</div>
		
		<hr class="hr hr-blurry" />
		
		<div class="row" >
		   <div class="col my-2 ">
		   <h2>Payout API Token <div class="fw-light mt-1" style="font-size:12px;" id="payouttokenid"><? if(isset($post['payout_token'])&&$post['payout_token']){ echo api_masking($post['payout_token']); } else { ?>Payout Token to be Generate <? } ?></div></h2>
			<b id="generate_payout_token" class="hide" ><?=$post['payout_token'];?></b>
			</div>
			<div class="col my-2 ">
			<a id="ptoken" class="btn btn-icon btn-primary hide " onclick="CopyToClipboard2('#generate_payout_token')" title="Copy Payout Token - <?=$post['payout_token'];?>"><i class="<?=$data['fwicon']['copy'];?>"></i></a>
			<?php /*?>// Generate Payout Token  from call function confirm1() call ajax page<?php */?> 
				<a onclick="return confirm1(this);" class="btn btn-icon btn-primary " title="<? if(isset($post['payout_token'])&&$post['payout_token']){?>Regenerate<? }else{ ?> Generate <? } ?> Payout Token"><i class="<?=$data['fwicon']['rotate-right'];?>"></i>  <!--<span id="ptokenid"><? if(isset($post['payout_token'])&&$post['payout_token']){?>Regenerate<? }else{ ?> Generate <? } ?> Payout Token</span>--></a>
			
			
			</div>
			
			<? if(isset($post['payout_token'])&&$post['payout_token']){?>
			<script> 
			//alert(1);
			 $("#ptoken").removeClass("hide");
			 $("#ptoken").addClass("show");
			 </script>
			<? }else{ ?>
			<script>
			//alert(2);
			 $("#ptoken").removeClass("show");
			 $("#ptoken").addClass("hide");
			</script>
			<? } ?>
			
			
			
			
	</div>
	   
	    <hr class="hr hr-blurry" />
		
			<? 
	
	if(!isset($post['payout_secret_key'])||$post['payout_secret_key']==""){ ?> 
    	<div class="row">
		    <h2>Enter a Secret Word</h2>
			<div class="col"><input type="text" class="form-control  my-2" name="payout_secret_key" title="Enter a word for Generate Payout Secret Key" placeholder="Enter a word for Generate Payout Secret Key" required /></div>
			<div class="col row ">
			<button type="submit" name="send" value="submit_word" class="btn btn-primary my-2 mx-2 w-50" autocomplete="off"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button></div>
		</div>
       
		<? } else{ ?>
		<div class="my-2 row">
		<div class="col">
		<h2>Payout Secret Key Generated<div class="fw-light mt-1" style="font-size:12px;" >**********</div></h2>
		</div>
		<div class="col"><i class="<?=$data['fwicon']['check-circle'];?> text-success fs-2"></i>
		</div>
		</div>
		<? } ?>
	
		  </div> 
		  
	</form> 	
		
  
</div>
<script>
/*js for Generate Payout Token*/
var wn='';

function confirm1(e){

	var retVal= confirm('Are you sure to Generate Payout Token?');
	if (retVal) {
		
		var thisUrl="<?=$data['USER_FOLDER'];?>/<?=($data['PageFileName']);?><?=$data['ex']?>?action=generate_payout_token&ajax1=1<?=$data['is_admin_link']?>";
		
		if(wn==1){
			window.open(thisUrl,'_blank');
		}
		else {
			top.window.location.href=thisUrl;
		}
		

		$('#generate_payout_token').css("display", "none");
		$("#ptoken").removeClass("hide");
		$("#ptoken").addClass("show");
		//$('#tokenmsg').css("display", "");
		$('#ptokenid').html("Regenerate Payout Token");
		//$('#tokenmsg2').css("display", "none");
		
		return true;
	} else {			
		return false;
	}
}


</script>
<? } ?>


</div>
<script>

// Function for copy API Keys & Secret Key

function CopyToClipboard2(text) {
	text=$(text).html();
	//alert(text);
	var $txt = $('<textarea />');

	$txt.val(text)
		.css({ width: "1px", height: "1px" })
		.appendTo('body');

	$txt.select();

	if (document.execCommand('copy')) {
		$txt.remove();
		alert(text+"\n\nCopied.");
	}
}



</script>
<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>
