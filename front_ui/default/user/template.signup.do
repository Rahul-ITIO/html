<? $domain_server=$_SESSION['domain_server']; ?>
<? if($data['con_name']=='clk'){ ?>
<script>
$(document).ready(function(){  
	$('input').on('click focusout', function() {
		if($(this).prev().hasClass('clicked')){
			if($(this).val()==''){
			  $(this).prev().removeClass('clicked');
			}
		}else{
			$(this).prev().addClass('clicked');
		}
	});
	
	$('input').on('click', function() {
		$('label').removeClass('l_focus');
		$(this).prev().addClass('l_focus');
	});
	$('input').on('focusout', function() {
		$('label').removeClass('l_focus');
	});
	
 
	
	<? if($data['Error']){ ?>
		$('input').trigger('click');
	<? } ?>
	
});
</script>
<? } ?>
<style>

 .col-form-label {
  font-weight: normal !important;
 } 
 
 @media (max-width: 768px) {
 .hideonmobile{ display:none; }
 .col-sm-5.vkg{ width: 100.00%!important; }
 }
</style>
<? if(isset($data['ScriptLoaded'])){ ?>

<? if(!$data['PostSent']){ ?>

<div class="container border9 bg-primary rounded mb-2 mt-5" >
<? if((isset($data['Error'])&& $data['Error'])){ ?>
      <div class="toast toast-error align-items-center text-message border-0 w-100 my-2 fade show" role="alert" aria-live="assertive" aria-atomic="true" style="max-width:500px; margin:0 auto;" >
  <div class="d-flex">
    <div class="toast-body"><?=prntext($data['Error'])?>
         </div>
    <button type="button" class="btn-close btn-close-white me-2 m-auto close_toast"  onclick="toastclose('.toast-error')" data-bs-dismiss="toast" aria-label="Close"></button>
  </div>
</div>
<? } ?>

	  
  <div class="row my-2">
  <div class="col-sm-7 hideonmobile">
  <div class="container w-75 py-3">
  
    <? if(($data['hdr_logo'])&&($domain_server['LOGO'])){ ?>
	<div class="text-start mt-3">
    <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:50px;"></a>
	</div>
    <? } ?>
	
	
	<h1 class="fs-4 my-2">Accept credit cards and other popular payment methods</h1>
	<h4 class="mt-3 text-white"><i class="<?=$data['fwicon']['tick-circle'];?> text-success"></i> Get Started Easily</h4>
	<div class="ps-3">Takes just a few minutes to register. Please keep the following details handy like Company Name, Legal name, Legal address to register.</div>
	<h4 class="mt-3 text-white"><i class="<?=$data['fwicon']['tick-circle'];?> text-success"></i> Supportive to All Business Models</h4>
	<div class="ps-3">Satisfied customers with best success rates on Mobile, UPI and Payment Gateway. Access on advanced features of Payment Gateway.</div>
	<h4 class="mt-3 text-white"><i class="<?=$data['fwicon']['tick-circle'];?> text-success"></i> Partners with Millions of Businesses</h4>
	<div class="ps-3">Trusted by ambitious startups and every scale enterprises.</div>
	
	</div>
  </div>
  <div class="col-sm-5 vkg">
    <div class="rounded-tringle bg-primary rounded p-2">
      <div class="both-side-margin">
      <form method="post">
        <input type="hidden" name="token" id="token" value='<?=prntext($_SESSION['token_forgot'],0);?>' />
        <input type="hidden" name="token_sign" id="token_sign" value='<?=prntext($_SESSION['token_sign'],0);?>' />
		 <div class="my-2 fs-5">Create free account</div>
        <div class="well input_col_1" >
          <div class="uniformjs row">
			
			<div class="my-2 px-1 row-fluid">
			
			<div class="col-sm-12 input-field">
                <input type="text" class="form-control fullname" id="fullname" name="fullname" value="<?=((isset($post['newfullname']))?prntext($post['newfullname']):(isset($post['fullname'])?prntext($post['fullname']):''));?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-original-title="Enter the name exactly as it on your legal document" required />
				<label for="fullname" >Enter Full name</label>
             </div>
          </div>
		  
			
            <? if($data['con_name']=='clk'){ ?>
            <div class="my-2 px-1 row-fluid">
              
              <div class="col-sm-12 input-field">
                <input type="text" class="form-control" name="newuser" id="input_mobile"  value="<?php if(isset($post['newuser'])){ echo prntext($post['newuser']);} ?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-original-title="Enter Mobile Number as Username it is permanent; cannot be changed later" required/>
				<label for="input_mobile" >Enter Mobile Number</label>
              </div>
            </div>
            <div class="my-2 px-1 row-fluid">
              
              <div class="col-sm-12 input-field">
                <input type="email" class="form-control"  name="newmail" id="input_newmail"   value="<?php  if(isset($post['newmail'])){ echo prntext($post['newmail']);} ?>" autocomplete="off"   data-bs-toggle="tooltip" data-bs-placement="right" data-bs-original-title="Enter Email address to receive all updates related to account" required/>
				<label for="input_newmail">Enter Email address</label>
              </div>
            </div>
            <? }else{ ?>
            <div class="my-2 px-1 row-fluid">
              
              <div class="col-sm-12 input-field">
                <input type="text" class="form-control newuser" name="newuser" id="input_newuser" value="<?=prntext(((isset($post['newuser']) &&$post['newuser'])?$post['newuser']:''));?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-original-title="Username should be unique and it is permanent; cannot be changed later" required/>
				<label for="input_newuser">Enter Username</label>
              </div>
            </div>
            <div class="my-2 px-1 row-fluid">
              
              <div class="col-sm-12 input-field">
			  
                <input type="email" class="form-control newmail"  name="newmail" id="input_newmail"    value="<?=prntext(((isset($post['newmail']) &&$post['newmail'])?$post['newmail']:''));?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-original-title="Enter Email address to receive all updates related to account" required/>
				<label for="input_newmail">Enter Email address</label>
              </div>
            </div>
            <? } ?>
          </div>
        </div>
        <? if($data['UseExtRegForm']){ ?>
        <h5> Your Profile Information - Your name and address should match the info registered with your Credit Card and/or your Checking Account.</h5>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">Full Name</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newfullname" title="Full Name" placeholder="Enter Full Name" value="<?=prntext(((isset($post['newfullname']) &&$post['newfullname'])?$post['newfullname']:''));?>" autocomplete="off" required/>
          </div>
        </div>
        <?php /*?><div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">Last Name</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newlname" title="Last Name" placeholder="Enter UserName" value="<?=prntext(((isset($post['newlname']) &&$post['newlname'])?$post['newlname']:''));?>" autocomplete="off" required/>
          </div>
        </div><?php */?>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">Company Name</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newcompany" title="Company Name" placeholder="Enter UserName" value="<?=prntext(((isset($post['newcompany']) &&$post['newcompany'])?$post['newcompany']:''));?>" autocomplete="off" />
          </div>
        </div>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">Company Registration No.</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newregnum"  title="Company Registration No." placeholder="Company Registration No." value="<?=prntext(((isset($post['newregnum']) &&$post['newregnum'])?$post['newregnum']:''));?>" autocomplete="off" />
          </div>
        </div>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">Drivers License No:</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newdrvnum" title="Drivers License No:" placeholder="Drivers License No:" value="<?=prntext(((isset($post['newdrvnum']) &&$post['newdrvnum'])?$post['newdrvnum']:''));?>" autocomplete="off" />
          </div>
        </div>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">Address</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newaddress" title="Address" placeholder="Enter Address" value="<?=prntext(((isset($post['newaddress']) &&$post['newaddress'])?$post['newaddress']:''));?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">City</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newcity" title="City" placeholder="Enter City" value="<?=prntext(((isset($post['newcity']) &&$post['newcity'])?$post['newcity']:''));?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">Country</label>
          <div class="col-sm-12">
            <select name="newcountry" class="form-control" title="Country" required>
              <?=showselect($data['Countries'], $post['newcountry'])?>
            </select>
          </div>
        </div>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">State</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newstate" title="State" placeholder="Enter State" value="<?=prntext(((isset($post['newstate']) &&$post['newstate'])?$post['newstate']:''));?>" autocomplete="off"/>
          </div>
        </div>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">Postal Code</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newzip" title="Postal Code" placeholder="Enter Postal Code" value="<?=prntext(((isset($post['newzip']) &&$post['newzip'])?$post['newzip']:''));?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">Phone</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newphone"  title="Phone" placeholder="Enter Phone" value="<?=prntext(((isset($post['newphone']) &&$post['newphone'])?$post['newphone']:''));?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="my-2 px-1 row-fluid">
          <label for="staticEmail" class="col-sm-12 col-form-label">Fax</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newfax" placeholder="Enter Fax" value="<?=prntext($post['newfax'])?>" autocomplete="off" />
          </div>
        </div>
        <? } ?>
        <div class="my-2 px-1 row-fluid" style="display:none;">
          <div class="col-sm-2">
            <input type="checkbox" id="terms" name="terms" <? if(isset($post['terms'])&&$post['terms']=='on'){ ?> checked <? } ?> >
          </div>
          <label for="staticEmail" class="col-sm-8 col-form-label">I have read and agree to the <a class="nopopup" href="javascript:view('<?=$data['Host']?>/terms<?=$data['ex']?>',400,500)">Terms and Conditions</a></label>
        </div>
        <div class="my-2 px-1 row">
          <div class="col-sm-12 px-0">
            <button class="btn btn-primary w-100 create_account" type="submit" name="send" value="SIGN UP NOW!" >Create account</button>
          </div>
		  
		  <div class="col-sm-12 my-2 text-center">
		Already have an account? <a href="<?=$data['Host'];?>/login<?=$data['ex']?>" class="my-2 text-link"> Sign in</a>
		</div>
        </div>

      </form>
	  </div>
    </div>
	<? $domain_server=$_SESSION['domain_server']; ?>
    <? if($domain_server['STATUS']==true){ ?>
	<div class="helpline55 my-2 text-end">
	<? if($domain_server['customer_service_no']){ ?><a href="tel:<?=$domain_server['customer_service_no'];?>" class="mx-2 text-white" title="Customer Service No."><i class="<?=$data['fwicon']['headphones'];?>"></i> <?=$domain_server['customer_service_no'];?></a> <? } ?>
	<? if($domain_server['customer_service_email']){ ?><a target='_blank' title="Customer Service Email" href="mailto:<?=$domain_server['customer_service_email']?>?subject=I need help&body=Dear <?=$data['SiteName'];?>, I need your help about ..." class="mx-2 text-white" ><i class="<?=$data['fwicon']['email'];?>"></i> <?=$domain_server['customer_service_email'];?></a><? } ?> 
	</div>
	<? } ?>
  </div>
  </div>



</div>
<? }else{ ?>

<? if((isset($data['Error'])&& $data['Error'])){ ?>

  <div class="alert alert-danger alert-dismissible fade show" role="alert"> 
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
   <strong>Error!</strong><?=prntext($data['Error'])?>
  </div>
  
  <? } ?>
<div class="container-sm my-2" style="max-width:500px; margin:0 auto;">
  
  <div class="row-fluid mt-5">
  <? if(($data['hdr_logo'])&&($domain_server['LOGO'])){ ?>
	<div class="text-start mb-2">
    <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:50px;"></a>
	</div>
    <? } ?>
  <div class="rounded-tringle rounded bg-primary vkg p-2">
    <div class="my-2 fs-5 px-2">Verify your email</div>
	<div class="px-2 my-2"> 
    <span>Before you can active your account, </span>
    <p>Please check <?=$post['newmail'];?> for a link to verify your account.</p>
    <div class="text-center"><a class="btn btn-primary mx-1 Resend_email" title="Resend email">Resend email</a><a href="<?=$data['Host'];?>/login<?=$data['ex']?>" class="btn btn-primary mx-1" title="Resend email">Continue</a>
  </div>
  <?php /*?><div class="col text-center my-2"> <!--<a class="nopopup btn btn-outline-success" href="<?=$data['USER_FOLDER']?>/confirm<?=$data['ex']?>">Enter Confirm Code</a>&nbsp;--><a class="nopopup text-white" href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>">Back home</a> </div><?php */?>
</div>
</div>


  <div class="toast align-items-center text-message border-0 w-100 mt-3 toast-box show" role="alert" aria-live="assertive" aria-atomic="true" id="myToast">
  <div class="d-flex">
    <div class="toast-body">Email sent to <?=$post['newmail'];?></div>
    <button type="button" class="btn-close btn-close-white me-2 m-auto" onclick="toastclose('.toast')" data-bs-dismiss="toast" aria-label="Close"></button>
  </div>
</div>

</div>
<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
<script>
//$("#myToast").toast("show");
//alert("ooops");
//$('input,p,div,select,textarea').on("select mousedown mouseup dblclick mouseover etc", false);

$(document).ready(function(){
	$('.username').focusout(function(){
	//var reM = '#my&*^*&%*&$^%&$%^$ #name656565__: ^*&**&^%%$^&__# is Mithilesh###__';
	var reM = $( ".username" ).val();

	/*you can use given comment for slice the string sentence*/
	//str = reM.replace(/[0-9`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/\s]/gi,'').slice( 0,4 );

	str = reM.replace(/[` ~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi,'');
	$( ".username" ).val(str);
	});
});

  $('.Resend_email').on('click', function () {
	//alert(11);
	$(".toast-box").show();
	$(".toast-body").html("<i class='<?=$data['fwicon']['spinner']?> fa-spin-pulse'></i>");
	$.ajax({
	url: "<?=$data['Host'];?>/include/resend_activation_email<?=$data['ex']?>",
	data:'tid=<?=$post['cnf_newid'];?>',
	type: "POST",
	success:function(data){
	//alert(data);
	  if(data){
	   
	   $(".toast-body").html(data);
	  }
	},
	error:function (){}
	});
	
});


/*$('.close_button').on('click', function () {
$(".toast-box").hide();
});*/

$('.create_account').on('click', function () {

if(($('.fullname').val()=="") || ($('.newmail').val()=="") || ($('.newuser').val()=="")){
alert("Please enter Full Name, Username and Email address");
return;
}

$(".create_account").html("<i class='<?=$data['fwicon']['spinner'];?> fa-spin-pulse'></i>");
});

</script>
<div>