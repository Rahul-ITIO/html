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
	
	$('.show_password').on('click', function() {
		if($(this).hasClass('active')){
			$(this).parent().find('.password_input').prop('type','password');
			$(this).removeClass('active');
			$(this).text('Show');
		}else{
			$(this).addClass('active');
			$(this).text('Hide');
			$(this).parent().find('.password_input').prop('type','text');
		}
		
	});
	
	<? if($data['Error']){ ?>
		$('input').trigger('click');
	<? } ?>
	
});
</script>
<? } ?>
<style>
body { background: var(--background-1) !important;
  width: auto; 
  height: auto; 
  font-weight: 400;
  font-style: normal;
  font-family: "Alike Angular", serif !important;
}


.main_box{
    box-sizing: border-box;
    background-color: #fff;
    overflow: visible;
	/*border-radius: 30px 0px 0px 30px;*/
	border-radius: 0px 30px 30px 30px;
	box-shadow: 0px 5px 10px 0px rgba(0, 0, 0, 0.5);
    border-color: <?=$_SESSION['background_gl5'];?>;
    border-style: solid;
    border-top-width: 20px;
    border-bottom-width: 1px;
	margin-top: 80px;
}
.box_text {
 
  font-size: 30px;
  letter-spacing: 0px;
  line-height: 1.2;
}
.h4, h4 {
    font-size: 20px  !important;
}
h1.text-primary, h1.text-white  {
    font-size: 25px  !important;
}
.form-control, .input-group-text, .form-select {
    background: var(--color-3) !important;
}
.h5, h5 {
    font-size: 12px  !important;
}
</style>
<? if(isset($data['ScriptLoaded'])){ ?>
<? if(!$data['PostSent']){ ?>
<? if((isset($data['Error'])&& $data['Error'])){ ?>
      <div class="container my-2" ><!--style="max-width:540px;"-->
        <div class="alert alert-danger alert-dismissible fade show" role="alert"> 
		<strong>Error ! </strong>
          <?=prntext($data['Error'])?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      </div>
      <? } ?>
<div class="container my-2" >
  <div class="row my-2">
  <div class="col-sm-7">
  <div class="container w-75">
  
    <? if($domain_server['LOGO']){ ?>
	<div class="text-start mt-3">
    <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:50px;"></a>
	</div>
    <? } ?>
	
	<div class="my-2 box_text">
	<h1 class="text-white">Apply your Merchant Account<br/>
	Accept card payments now
	</h1>
	<h4 class="my-2 text-white">It takes few minutes to register. Please keep the following details handy.</h4>
	</div>
	
	<div class="my-3 text-white"><i class="fas fa-check"></i> Legal name</div>
	<div class="my-3 text-white"><i class="fas fa-check"></i> Legal address</div>
	<div class="my-3 text-white"><i class="fas fa-check"></i> Company Name</div>
	
	</div>
  </div>
  <div class="col-sm-5 ">
    <div class="main_box pull-up p-2">
      
      <form method="post">
        <input type="hidden" name="token" id="token" value='<?=prntext($_SESSION['token_forgot'],0);?>' />
        <input type="hidden" name="token_sign" id="token_sign" value='<?=prntext($_SESSION['token_sign'],0);?>' />
		 <h2 class="my-2 text-center fs-5">Sign Up For A New Account</h2>
		  <div class="col-sm-12 my-2 text-center">
<a href="<?=$data['Host'];?>/login<?=$data['ex']?>" class="my-2">Already have an account? Sign in</a>
		</div>
        <div class="well input_col_1" style="margin-bottom:0px">
          <div class="uniformjs mx-3 row">
		  <div class="row-fluid">
              <label for="staticEmail" class="col-form-label"><strong>Name</strong></label>
              <div class="col-sm-12">
                <input type="text" class="form-control" name="fullname" title="Name" placeholder="Enter Full Name" value="<?php  if(isset($post['newfullname'])){ echo prntext($post['newfullname']);} ?>" autocomplete="off" required/>
              </div>
            </div>
			
            <? if($data['con_name']=='clk'){ ?>
            <div class="row-fluid">
              <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Mobile Number</strong></label>
              <div class="col-sm-12">
                <input type="text" class="form-control" name="newuser" title="Mobile Number" placeholder="Enter Mobile Number" value="<?php  if(isset($post['newuser'])){ echo prntext($post['newuser']);} ?>" autocomplete="off" required/>
              </div>
            </div>
            <div class="row-fluid">
              <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Email Address</strong></label>
              <div class="col-sm-12">
                <input type="email" class="form-control"  name="newmail" title="Email Address" placeholder="Enter Email Address"  value="<?php  if(isset($post['newmail'])){ echo prntext($post['newmail']);} ?>" autocomplete="off" required/>
              </div>
            </div>
            <? }else{ ?>
            <div class="row-fluid">
              <label for="staticEmail" class="col-sm-6 col-form-label"><strong>User Name</strong></label>
              <div class="col-sm-12">
                <input type="text" class="form-control" name="newuser" title="User Name" placeholder="Enter User Name" value="<?=prntext(((isset($post['newuser']) &&$post['newuser'])?$post['newuser']:''));?>" autocomplete="off" required/>
              </div>
            </div>
            <div class="row-fluid">
              <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Email Address</strong></label>
              <div class="col-sm-12">
                <input type="email" class="form-control"  name="newmail"  title="Email Address" placeholder="Enter Email Address"  value="<?=prntext(((isset($post['newmail']) &&$post['newmail'])?$post['newmail']:''));?>" autocomplete="off" required/>
              </div>
            </div>
            <? } ?>
          </div>
        </div>
        <? if($data['UseExtRegForm']){ ?>
        <h5 class="mx-3"> Your Profile Information - Your name and address should match the info registered with your Credit Card and/or your Checking Account.</h5>
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Full Name</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newfullname" title="Full Name" placeholder="Enter Full Name" value="<?=prntext(((isset($post['newfullname']) &&$post['newfullname'])?$post['newfullname']:''));?>" autocomplete="off" required/>
          </div>
        </div>
        
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Company Name</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newcompany" title="Company Name" placeholder="Enter UserName" value="<?=prntext(((isset($post['newcompany']) &&$post['newcompany'])?$post['newcompany']:''));?>" autocomplete="off" />
          </div>
        </div>
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Company Registration No.</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newregnum"  title="Company Registration No." placeholder="Company Registration No." value="<?=prntext(((isset($post['newregnum']) &&$post['newregnum'])?$post['newregnum']:''));?>" autocomplete="off" />
          </div>
        </div>
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Drivers License No:</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newdrvnum" title="Drivers License No:" placeholder="Drivers License No:" value="<?=prntext(((isset($post['newdrvnum']) &&$post['newdrvnum'])?$post['newdrvnum']:''));?>" autocomplete="off" />
          </div>
        </div>
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Address</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newaddress" title="Address" placeholder="Enter Address" value="<?=prntext(((isset($post['newaddress']) &&$post['newaddress'])?$post['newaddress']:''));?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>City</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newcity" title="City" placeholder="Enter City" value="<?=prntext(((isset($post['newcity']) &&$post['newcity'])?$post['newcity']:''));?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Country</strong></label>
          <div class="col-sm-12">
            <select name="newcountry" class="form-control" title="Country" required>
              <?=showselect($data['Countries'], $post['newcountry'])?>
            </select>
          </div>
        </div>
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>State</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newstate" title="State" placeholder="Enter State" value="<?=prntext(((isset($post['newstate']) &&$post['newstate'])?$post['newstate']:''));?>" autocomplete="off"/>
          </div>
        </div>
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Postal Code</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newzip" title="Postal Code" placeholder="Enter Postal Code" value="<?=prntext(((isset($post['newzip']) &&$post['newzip'])?$post['newzip']:''));?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Phone</strong></label>
          <div class="col-sm-12">
            <input type="text" class="form-control" name="newphone"  title="Phone" placeholder="Enter Phone" value="<?=prntext(((isset($post['newphone']) &&$post['newphone'])?$post['newphone']:''));?>" autocomplete="off" required/>
          </div>
        </div>
        <div class="row-fluid mx-3">
          <label for="staticEmail" class="col-sm-6 col-form-label"><strong>Fax</strong></label>
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
          <div class="col-sm-12 text-center">
            <button class="btn btn-primary w-75" type="submit" name="send" value="SIGN UP NOW!" >Sign Up</button>
          </div>
		  
		 
        </div>

      </form>
    </div>
	<? $domain_server=$_SESSION['domain_server']; ?>
	
  <?php /*?>  <? if($domain_server['STATUS']==true){ ?>
	<div class="helpline my-2 ">
	<? if($domain_server['customer_service_no']){ ?><a href="tel:<?=$domain_server['customer_service_no'];?>" class="mx-2" title="Customer Service No."><i class="fas fa-headphones"></i> <?=$domain_server['customer_service_no'];?></a> <? } ?>
	<? if($domain_server['customer_service_email']){ ?><a target="_blank" title="Customer Service Email" href="mailto:<?=$domain_server['customer_service_email']?>?subject=I need help&body=Dear <?=$data['SiteName'];?>, I need your help about ..." class="mx-2" ><i class="fas fa-envelope"></i> <?=$domain_server['customer_service_email'];?></a><? } ?> 
	</div>
	<? } ?><?php */?>
	
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
<div class="container-sm my-2" style="max-width:400px; margin:0 auto;">
  
  <div class="row-fluid">
  <div class="main_box p-2">
   <h2 class="my-2 text-center fs-5">Sign Up For A Free Account </h2>
  <div class="alert bg-vlight alert-dismissible fade show" role="alert"> <strong>Please Check Your Email </strong>
    <p>A message has been sent to the specified e-mail address. </p>
    <p>Please navigate to the link contained in the e-mail to continue the signup process.</p>
    <p>This Activation url will work only 48 hours.<br>
	<div class="col text-center my-2"><a class="nopopup btn btn-primary" href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>">Back Home</a> </div>
  </div>
  
</div>
</div>
</div>
<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
<script>
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
</script>
