<? @$domain_server=@$_SESSION['domain_server']; ?>
<? if(isset($data['ScriptLoaded'])){ ?>
<style> 
        .row {--bs-gutter-x: 1.5rem;} 
        .col-form-label { font-weight: normal !important;} 
        .text-white a.text-linkf {color: #6e2d9f !important; font-weight:600 !important;}
		<? if(isset($_SESSION['action_sent_success'])&&$_SESSION['action_sent_success']){ ?>
		.hide-title{ display:none;}
		<? } ?>
</style>
<? if($post['step']==1){ ?>
<? if((isset($data['Error'])&& $data['Error'])){ ?>


    <script>
	$(document).ready(function(){
	setTimeout(function(){
    $("#myToast").show();
	$(".toast-body").html("<?=prntext($data['Error'])?>");
	}, 500);
	});
	</script>
	
<? } ?>



<div class="container-sm my-2" style="max-width:500px; margin:0 auto;">
  <div class="row-fluid mt-5">
    <? if((@$data['hdr_logo'])&&(@$domain_server['LOGO'])){ ?>
	<div class="text-start mb-2">
    <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf(@$domain_server['LOGO']);?>" style="height:50px;"></a>
	</div>
    <? } ?>
    <div class="rounded-tringle rounded bg-primary text-white vkg p-2" >
	<div class="both-side-margin">
      
		<? if(@$data['Error']){ ?>
			<div class="container my-2">
			<div class="alert alert-danger alert-dismissible fade show mx-4" role="alert"> <strong>Error !</strong>
			<?=prntext(@$data['Error'])?>
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
			</div>
		<? } ?>
		<div class="my-2 fs-5 hide-title"><?=$data['PageName']?></div>
	    <? if(isset($_SESSION['action_sent_success'])&&$_SESSION['action_sent_success']){ ?>
		    <script>
		    $(document).ready(function(){
			setTimeout(function(){
			$("#myToast").show();
			}, 500);
		    });
			</script>
		<div class="row text-center ">
				<i class="<?=$data['fwicon']['tick-circle'];?> text-success fa-w-12 fa-3x mt-3 "></i>
			</div>
			
		<div class="my-2 fs-5 p-2">An email has been sent to the email <b><i><?=$_SESSION['memail'];?></i></b> address registered with user name: <b><i><?=@$_SESSION['registered_email']?></i></b>. You'll receive instructions on how to set a new password.</div>
		
		<div class="p-2">Check your spam or <a class="text-linkf resend-again pointer">resend</a> <span class="float-end"> <a href="<?=$data['Host'];?>/index<?=$data['ex']?>" title="Move to login" class="text-linkf">Return to sign in</a></span></div>
		
		<div class="p-2 hide">If you haven't received an registered email <?=$_SESSION['memail'];?> in 5 minutes, check your spam or <a class="text-linkf resend-again pointer">resend</a> <span class="float-end"> <a href="<?=$data['Host'];?>/index<?=$data['ex']?>" title="Move to login" class="text-linkf">Return to sign in</a></span></div>


		<? 
			$_SESSION['action_sent_success']=null; unset($_SESSION['action_sent_success']);
		
		} else if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
    <div class="alert alert-success alert-dismissible fade show my-2" role="alert"> <?php echo $_SESSION['action_success'];?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
	<script>
		$(document).ready(function(){
			//setTimeout(function(){ top.window.location.href="<?=$data['Host']?>/index<?=$data['ex']?>"; }, 6000);
		});
	</script>
	
    <? 
		$_SESSION['action_success']=null; unset($_SESSION['action_success']);
	} 
	else
	{ ?>
	<!--<div class="vkg-main-border2"></div>-->
      <p class="fw-light">Please enter the username registered with us. We'll send you a link to reset your password.</p>
      <form method="post">
        <input type="hidden" name="token" value='<?=prntext($_SESSION['token_forgot'],12);?>' />
        <input type="hidden" name="step" value="<?=prntext($post['step'])?>">
        <div class="mb-3 row-fluid">
          
          <div class="col-sm-12 input-field">
            <input type="text" class="form-control cemail" name="registered_email" data-id="input_username" title="Enter username registered with us" value="<?=prntext($post['registered_email'])?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="top" required/>
			<label for="input_username">Enter username</label>
          </div>
        </div>
        <div class="mb-3 row-fluid">
          <div class="col-sm-12">
            <button class="btn btn-primary continue" id="btn-confirm" name="send" value="PLACE ORDER" type="submit" style="width:100%;">Continue</button>
          </div>
        </div>
		</form>
	<? } ?>
        <div class="col text-center my-2 hide-title text-dark"><a href="<?=$data['Host'];?>/login<?=$data['ex']?>" class="
		text-link" >Return to sign in</a>&nbsp;&nbsp;Don't have an account? <a href="<?=$data['Host']?>/signup<?=$data['ex']?>" class="">Sign up</a> </div>
  
	  
    
    
  
	
	</div>
    <!--<div class="col-sm-4"> &nbsp; </div>-->
  </div>
<div class="rounded align-items-center text-message border-0 w-100 mt-3 p-3 toast-box hide" role="alert" aria-live="assertive" aria-atomic="true" id="myToast1">
  <div class="d-flex">
    <div class="toast-body">Password Reset Instruction sent to <?=@$_SESSION['memail'];?></div>
    <button type="button" class="btn-close btn-close-white me-2 m-auto " onclick="toastclose('.toast-box')" data-bs-dismiss="toast" aria-label="Close"></button>
  </div>
</div>
  <?php /*?><div class="text-start my-2 hide-title text-white">Don't have an account? <a href="<?=$data['Host']?>/signup<?=$data['ex']?>" class="text-link">Sign up</a></div><?php */?>
    <? if(@$domain_server['STATUS']==true){ ?>
	<div class="helpline77 my-2 text-end">
	<? if(@$domain_server['customer_service_no']){ ?><a href="tel:<?=@$domain_server['customer_service_no'];?>" class="mx-2 text-white" title="Customer Service No."><i class="<?=$data['fwicon']['headphones'];?>"></i> <?=@$domain_server['customer_service_no'];?></a> <? } ?>
	<? if(@$domain_server['customer_service_email']){ ?><a target='_blank' title="Customer Service Email" href="mailto:<?=@$domain_server['customer_service_email']?>?subject=I need help&body=Dear <?=$data['SiteName'];?>, I need your help about ..." class="mx-2 text-white" ><i class="<?=@$data['fwicon']['registered_email'];?>"></i> <?=@$domain_server['customer_service_email'];?></a><? } ?> 
	</div></div>
	<? } ?>
</div>
<? }elseif($post['step']==5){ ?>
<? if($data['Error']){ ?>
<div class="container my-2">
  <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error !!</strong>
    <?=prntext($data['Error'])?>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</div>
<? } ?>
<div class="container-sm my-2" >
  <div class="row">
    <div class="col-sm-4"> &nbsp; </div>
    <div class="col-sm-4 border vkg">
	   <h2 class="my-2">Forgotten Password (STEP #2)</h2>
	<div class="vkg-main-border2"></div>
      <p>If you forget your password, we will ask your Company Name you submit below. Please, try to find a personal Company Name and Website URL which you know.</p>
      <form method="post">
        <input type="hidden" name="token" value='<?=prntext($_SESSION['token_forgot'],12);?>' />
        <input type="hidden" name="step" value="<?=prntext($post['step'])?>">
        <div class="my-2 row-fluid">
          <label for="staticEmail" class="col-sm-4 col-form-label">Company Name (*):</label>
          <label for="staticEmail" class="col-sm-8 col-form-label"><font color=red><b>
          <?=prntext($post['question'])?>
          </b></font></label>
        </div>
        <div class="my-2 row-fluid">
          <label for="staticEmail" class="col-sm-6 col-form-label">Website URL(*):</label>
          <div class="col-sm-12">
            <input type="text" class="form-control"  name="answer" placeholder="Enter Your User Name"  value="<?=prntext($post['answer'])?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="my-2 row-fluid">
          <div class="col-sm-6">
            <input type="submit" class="btn btn-primary" name="cancel" value="BACK" style="width:100%;">
          </div>
          <div class="col-sm-6">
            <input type="submit" class="btn btn-primary submit" name="send" value="CONTINUE">
          </div>
        </div>
        <div class="col text-center"> <i class="<?=$data['fwicon']['user-lock'];?>"></i> <a href="<?=$data['Host'];?>/login<?=$data['ex']?>" class="my-2">Login?</a>  Not a Merchant? <a href="<?=$data['Host']?>/signup<?=$data['ex']?>">Register</a></div>
      </form>
    </div>
    <div class="col-sm-4"> &nbsp; </div>
  </div>
</div>
</center>
<? }elseif($post['step']==2){ ?>
<div class="container my-2" style="max-width:540px;">
  <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> New password has been sent to registered email ID: <?=$_SESSION['memail'];?>
  </div>
</div>
<div class="col text-center"> <a class="nopopup btn btn-outline-success" href="<?=$data['Host'];?>/login<?=$data['ex']?>">Login Now</a>&nbsp;<a class="nopopup btn btn-outline-secondary" href="<?=$data['Host'];?>/index<?=$data['ex']?>"> Back</a> </div>


<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
</div>

<?/*?>
<script>
$('.resend-again').on('click', function () {
	$("#myToast").show();
	$(".toast-body").html("<i class='<?=$data['fwicon']['spinner'];?> fa-spin-pulse'></i>");
	$.ajax({
	url: "<?=$data['Host'];?>/include/resend_activation_email<?=$data['ex']?>",
	data:'ccode=<?=@$_SESSION['s_ccode'];?>&cemail=<?=@$_SESSION['cemail'];?>&cusername=<?=@$_SESSION['cusername'];?>&cuid=<?=@$_SESSION['cuid'];?>',
	type: "POST",
	success:function(data){
		data = ($.trim(data.replace(/[\t\n]+/g, '')));
	//alert(data);
	  if(data){
	   $(".toast-body").html(data);
	  }
	},
	error:function (){}
	});$_SESSION['cusername']=$info['username'];
	
});
</script>
<?*/?>

<script>
$('.continue').on('click', function () {
  if($('.cemail').val()==""){
    alert("Please Enter Username");
    return;
  }
  $(".continue").html("<i class='<?=$data['fwicon']['spinner'];?> fa-spin-pulse'></i>");
});
</script>
<div>
