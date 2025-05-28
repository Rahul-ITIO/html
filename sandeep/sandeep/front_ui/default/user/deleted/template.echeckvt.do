<? if(isset($data['ScriptLoaded'])){ ?>
<?
$target="";
if(isset($_GET['actionuse'])){
	//$target="target='hform'";	
	$target="target='_top'";	
}
?>

<div id="wrapper">
<div id="content">
  <form id="submit_echeck_form" method="post" name="data" <?=$target;?>>
    <input type="hidden" name="transaction_id" value="<?=$post['transaction_id']?>">
    <? if($_SESSION['apiprocess']){ ?>
    <input type="hidden" name="id" value="<?=$post['gid']?>">
    <input type="hidden" name="bid" value="<?=$post['bid']?>">
    <? } ?>
    <? if(($post['gid'])&&(!isset($_GET['actionuse']))){?>
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <? }else {
	$post['descriptor']="iCharge Company".$post['descriptor'];
	
}
if($post['type']==10){
	$post['descriptor']="Access 323-744-7716";
}
if($post['type']==9){
	$post['descriptor']="iCharge Company";
}
?>
    <!--<style>
.nomanditory {display:none;}
input[type=text], input[type=email], input[type=number],  select  {font-size: 16px;line-height: 36px;height: 36px; /*width: 48% !important;*/ color: #333 !important;border-radius: 3px;}
/*select {width:83%;}*/
label, .label1{float: left;font-size: 14px !important;width: 30%;text-align: right;padding: 5px 2% 0 0;}
.mand {color:red;}
textarea{border-radius: 3px;}
label.input2.midlable {line-height: 20px !important;width: 100% !important; float: left!important;}
.remark {font-size:10px; color:#333;}
.ecol2{float:left;width:48%;}
form{margin: 0px 0 -55px;}
.separator {margin: -3px 0px !important;display: block;}
.valid {position:relative;top:-3px;}

.Valid {background:url('<?php echo $data['Host']?>/contact/images/valid.png') 99% 8px no-repeat;}
.Invalid {background:url('<?php echo $data['Host']?>/contact/images/invalid.png') 99% 8px no-repeat;}

.flagtag{background:#e6e6e6;border-radius:3px;margin:0 3px;padding:0px 8px;color:#333;display:inline-block;line-height:20px;}

.modalactive .modal-backdrop.fade.in{opacity:0.0 !important;}
.modal.fade {display:none;}
.modalactive .modal.fade {display:none;}

.tooltip1 {position: relative;display: inline-block;border-bottom: 1px dotted black;}
.tooltip1 .tooltip1text {visibility: hidden;width: 145px;background-color:#1aabea;color:#fff;text-align:center;border-radius: 0px;margin-left:0px;position:absolute;z-index: 1;}
.tooltip1:hover .tooltip1text {visibility: visible;}
.bbg{background-color:#f2f2f2;padding-top:8px;padding-left:19px;width:100%;
/*margin-right:-42px;*/margin-left:-18px;border-radius:3px;  clear:both !important;}
.cbg{;padding-bottom:0px;/*margin-right:-32px*/;border-radius: 3px;width:100%;padding-top:0px;}
@media (max-width:910px){
	textarea,input[type=text], input[type=email], input[type=number],  select  {width: 90%;}
.btn{width:80%;}
}
@media (max-width:767px){
.ecol2{width:100%;float:left;}label,label1{text-align:left;}
.widget.widget-2 .widget-head h4{/*display:none !important;*/}
.glyphicons.btn-icon {margin-bottom:30px !important;}
/*textarea,input[type=text], input[type=email], input[type=number],  select  {width: 80% !important;}*/
.btn{width:80%;}
}

</style>-->
    <!-- HTML by Mukul -->
    <!--<style type="text/css">
/*body .btn.submit_echeck_btn{width:80%;}*/
.widget .widget-body{padding-left:0px;padding-top:0px;padding-right:0px;}
textarea,input[type="text"], input[type="email"], input[type="number"], select {
    font-size: 12px!important;
    color: #333 !important;
    border-radius: 3px;
	vertical-align:top;	
	
}


.btn{width:99%;}
textarea{padding-left: 11px;padding-top: 9px;height: 105px;line-height: 15px !important;}

@media (max-width:1200px){
.span11,.form-control{width:97%;}
.btn{width:81%;}
}
@media (max-width:767px){
  .form-control.span12{width:83% !important;}
  .span11{width:83% !important;}
  textarea, input[type="text"], input[type="email"], input[type="number"], select
  {width:98% !important;}
  body .btn.submit_echeck_btn{width:98%;}
}

</style>-->
    <!-- EOF HTML by Mukul -->
    <script>
var error_val="false"; 
var memoVar="";
function accountTypeChange(e){
	$('.nomanditory').css('display','none');
	if( $(e).val()==="9" ) {
	 $('.nomanditory').css('display','block');
	}
	else if( $(e).val()==="10" ) {
		$('#teInput').attr('disabled','disabled');
		$('#teInput').val('Access 323-744-7716');
		$('#purchaser_echecknumber').removeAttr('required');
		$('#purchaser_echecknumber').val('');
	}else if( $(e).val()==="11" ) {
		$('#teInput').removeAttr('disabled');
		$('#teInput').val($('#teInput').attr('data-11'));
		$('#purchaser_echecknumber').attr('required','required');
		$('#purchaser_echecknumber').val('161');
	}
	//alert($(e).val());
}
</script>
    <script>var hostPath="<?php echo $data['Host']?>";</script>
    <script src="<?=$data['Host']?>/js/common_use.js"></script>
    <script>
  
	$(document).ready( function(){
	
		$("#purchaser_routing").keyup(function() {
			if($("#purchaser_routing").val().length===9){
			  doLookup($("#purchaser_routing").val()); 
			}
		});
		$("#purchaser_email").keyup(function(){
			email_validatef(this,".purchaser_firstname",".purchaser_lastname","#eamil_status");
			//email_validatef(this,false,false,"#eamil_status");
			changeThis();chaneThis();hangeThis();cangeThis();chngeThis();
			
		});
		$('input[name="purchaser_phone"],input[name="purchaser_zipcode"]').click(function() {
			changeThis();chaneThis();hangeThis();cangeThis();chngeThis();
		});
		
		//$('#submit_echeck_form').attr('action',top.window.location.href);
		//$('#submit_echeck_form').attr('action');
		<?if($post['type']==10){?>
			$('#teInput').attr('disabled','disabled');
		<?}?>
		
		//$("#accountType").eq(2).trigger("click");
		$('#accountType').trigger('change');
		
	});

	function doLookup(rn)
	{
		$("#result_view").empty().text("Looking up " + rn + "...");
		$("#result_view_chk").empty().html("");
		$.ajax({
			url: "https://www.routingnumbers.info/api/data.json?rn=" + rn,
			dataType: 'jsonp',
			success: onLookupSuccess
		});
	}

	function onLookupSuccess(data){
		//alert(data['message']);
	 if(data['message']=="OK"){
		$("#purchaser_routing").removeClass('error');
		$("#bank_name").val(data['customer_name']);
		//$('#bank_state option value:contains("'+data['state']+'")').attr('selected', 'selected');
		$('#bank_state option[value*="'+data['state']+'"]').prop('selected','selected');
		$("#bank_address").val(data['address']);
		
		$("#bank_city").val(data['city']);
		$("#bank_phone").val(data['telephone']);
		var zipcode=data['zip'].split("-");
		$("#bank_zipcode").val(zipcode[0]);
		
		
		
		//alert(data['customer_name']);alert(data['routing_number']);
		/*
		var table = $("<table>").attr("class", "table table-bordered");
		table.append($("<tr>").append($("<th>").text("Results").attr("colspan", "2")));
		
		for (var member in data)
		{
			coltype = typeof data[member];

			table.append($("<tr>")
					.append($("<td>").text(member))
					.append($("<td>").text(data[member]))
					);
		}
		$("#result_view").empty().append(table);*/
		$("#result_view").empty().text(" Validated!");
		$("#result_view_chk").empty().html("<img class='valid' src='<?=$data['Host'];?>/contact/images/valid.png' /> ");
	  }else{
	    $("#purchaser_routing").addClass('error');
		$("#result_view_chk").empty().html("<img class='valid' src='<?=$data['Host'];?>/contact/images/invalid.png' /> ");
		$("#result_view").empty().text("Invalidated. Please enter correct Bank ABA/Routing No.");
	  }
	}
</script>
    <div  class="container border mb-2 mt-2 bg-white">
    <? if($post['apiprocess']=="true"||isset($_SESSION['apiprocess'])){
 $style_s="style='display:none;'";
 $style_i="style='display:none;'";
 $required_v="";
 ?>
    <!--<style>
.hed{font-size:24px;float:left;margin-top:10px;}
.breadcrumb.bul{height:40px;}
</style>-->
    <?
 
}else {
	$style_s="style='display:block;'";	
	$style_i="style='display:inline-block;'";
	$required_v="required"; ?>
    <? } ?>
    <input type="hidden" name="uid" value="<?=$post['uid']?>">
    <input type="hidden" name="eamil_status" id="eamil_status" value="<?=$post['eamil_status']?>">
    <input type="hidden" name="confirm_status" id="confirm_status" value="">
    <? if($data['Error']){ ?>
    <script>error_val="true"; </script>
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? }else{ ?>
    <script>error_val="false"; </script>
    <? } ?>
    <? if($data['sucess']){ ?>
    <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> Your E-check request has been sucessfully submited !!
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? }else{ ?>
    <? if($data['InfoIsEmpty']){?>
    <div class="my-2"> <font color=#FF0000><b><u>PLEASE NOTE:</u></b>
      <blockquote>Before using our system you need to fill out your profile.</blockquote>
      </font> </div>
    <? } ?>
    <? if($post['apiprocess']=="true"||isset($_SESSION['apiprocess'])){ ?>
    <div class="row">
      <div class="col-sm-6">Merchant Name: <b>
        <?=prntext($post['dmn'])?>
        </b> </div>
      <div class="col-sm-6"><span style="float:right;">Url:<b>
        <?=prntext($post['drvnum'])?>
        </b></span></div>
      <div class="col-sm-6"> Toll Free Number: <b>
        <?=prntext($post['fax'])?>
        </b></div>
      <div class="col-sm-6"><span style="float:right;">Descriptor: <b>
        <?=prntext($post['descriptor'])?>
        </b></span> </div>
    </div>
    <? } ?>
    <div class="widget-head vkg">
      <h4><i class="far fa-check-circle"></i> Please enter the information below </h4>
    </div>
    <div class="row">
      <h4>Customer Details</h4>
      <? if($post['apiprocess']=="true"||isset($_SESSION['apiprocess'])){ ?>
      <input type="hidden" name="type" value=<?=$_SESSION['type']?> />
      <script>
			function changeThis(){
				var formInput = document.getElementById('theInput').value;
				document.getElementById('newText').innerHTML = formInput;
			}
			function chaneThis(){
				var formInput = document.getElementById('thInput').value;
				document.getElementById('neText').innerHTML = formInput;
			}
			function hangeThis(){
				var formInput = document.getElementById('The1Input').value;
				document.getElementById('new2Text').innerHTML = formInput;
			}
			function cangeThis(){
				var formInput = document.getElementById('heInput').value;
				document.getElementById('new1Text').innerHTML = formInput;
			}
			function chngeThis(){
				var formInput = document.getElementById('teInput').value;
				document.getElementById('nText').innerHTML = formInput;
			}
		</script>
      <? }else{?>
      <script>function changeThis(){}function chaneThis(){}function hangeThis(){}function cangeThis(){}function chngeThis(){}</script>
      <div class="col-sm-3  my-2 px-2">
        <select name="type" id="accountType" class="feed_input1 form-select" onChange="accountTypeChange(this)"  required>
          <option value="" disabled>Select Store Name</option>
          <?
	//($value['user_type']=="1") &&
	$k=1;
	if($post['products']){
	foreach($post['products'] as $key=>$value){
		if(($value['curling_access_key'])&&($value['active']!=3)&&($value['api_token'])&&(strpos($data['t'][$value['curling_access_key']]['name2'],'Check') !== false)){
		if($k==1){
	?>
          <option value="<?=$value['api_token']?>" selected="selected">
          <?=$value['name']?>
          </option>
          <?}else{?>
          <option value="<?=$value['api_token']?>">
          <?=$value['name']?>
          </option>
          <? }}$k++;}}?>
        </select>
        <? if($post['type']){ ?>
        <script>
			$('#accountType option[value="<?=prntext($post['type'])?>"]').prop('selected','selected');
		</script>
        <? }?>
        <? }?>
      </div>
      <div class="col-sm-3 my-2 px-2">
        <input type="email" name="purchaser_email" id="purchaser_email"  placeholder="Buyer Email as per the Bank Record" class="form-control" value="<?=prntext($post['purchaser_email'])?>" required  />
      </div>
      <div class="col-sm-3 my-2 px-2">
        <input type="text" name="purchaser_phone"  placeholder="Buyer Phone" class="form-control" value="<?=prntext($post['purchaser_phone'])?>" required  />
      </div>
      <div class="col-sm-3 my-2 px-2">
        <input type="text" name="purchaser_firstname" placeholder="First Name as per the Bank Record" onKeyUp="changeThis()" id="theInput" class="purchaser_firstname form-control" value="<?=prntext($post['purchaser_firstname'])?>" required />
      </div>
      <div class="col-sm-3 my-2 px-2">
        <input type="text" name="purchaser_lastname" placeholder="Middle & Last Name as per the Bank Record" onKeyUp="chaneThis()" id="thInput" class="purchaser_lastname form-control" value="<?=prntext($post['purchaser_lastname'])?>" required />
      </div>
      <div class="col-sm-3 my-2 px-2">
        <input type="text" name="purchaser_city" placeholder="City as per the Bank Record" class="form-control" value="<?=prntext($post['purchaser_city'])?>" required />
      </div>
      <div class="col-sm-3 my-2 px-2">
        <select name="purchaser_state" id="purchaser_state" class="feed_input1 form-select" required>
          <option value="" disabled selected>Select State</option>
          <option value="AL-Alabama">Alabama</option>
          <option value="AK-Alaska">Alaska</option>
          <option value="AZ-Arizona">Arizona</option>
          <option value="AR-Arkansas">Arkansas</option>
          <option value="CA-California">California</option>
          <option value="CO-Colorado">Colorado</option>
          <option value="CT-Connecticut">Connecticut</option>
          <option value="DE-Delaware">Delaware</option>
          <option value="DC-District Of Columbia">District Of Columbia</option>
          <option value="FL-Florida">Florida</option>
          <option value="GA-Georgia">Georgia</option>
          <option value="HI-Hawaii">Hawaii</option>
          <option value="ID-Idaho">Idaho</option>
          <option value="IL-Illinois">Illinois</option>
          <option value="IN-Indiana">Indiana</option>
          <option value="IA-Iowa">Iowa</option>
          <option value="KS-Kansas">Kansas</option>
          <option value="KY-Kentucky">Kentucky</option>
          <option value="LA-Louisiana">Louisiana</option>
          <option value="ME-Maine">Maine</option>
          <option value="MD-Maryland">Maryland</option>
          <option value="MA-Massachusetts">Massachusetts</option>
          <option value="MI-Michigan">Michigan</option>
          <option value="MN-Minnesota">Minnesota</option>
          <option value="MS-Mississippi">Mississippi</option>
          <option value="MO-Missouri">Missouri</option>
          <option value="MT-Montana">Montana</option>
          <option value="NE-Nebraska">Nebraska</option>
          <option value="NV-Nevada">Nevada</option>
          <option value="NH-New Hampshire">New Hampshire</option>
          <option value="NJ-New Jersey">New Jersey</option>
          <option value="NM-New Mexico">New Mexico</option>
          <option value="NY-New York">New York</option>
          <option value="NC-North Carolina">North Carolina</option>
          <option value="ND-North Dakota">North Dakota</option>
          <option value="OH-Ohio">Ohio</option>
          <option value="OK-Oklahoma">Oklahoma</option>
          <option value="OR-Oregon">Oregon</option>
          <option value="PA-Pennsylvania">Pennsylvania</option>
          <option value="RI-Rhode Island">Rhode Island</option>
          <option value="SC-South Carolina">South Carolina</option>
          <option value="SD-South Dakota">South Dakota</option>
          <option value="TN-Tennessee">Tennessee</option>
          <option value="TX-Texas">Texas</option>
          <option value="UT-Utah">Utah</option>
          <option value="VT-Vermont">Vermont</option>
          <option value="VA-Virginia">Virginia</option>
          <option value="WA-Washington">Washington</option>
          <option value="WV-West Virginia">West Virginia</option>
          <option value="WI-Wisconsin">Wisconsin</option>
          <option value="WY-Wyoming">Wyoming</option>
        </select>
        <script>$('#purchaser_state option[value="<?=prntext($post['purchaser_state'])?>"]').prop('selected','selected');</script>
      </div>
      <div class="col-sm-3 my-2 px-2">
        <input type="text" pattern="[0-9]{5}" name="purchaser_zipcode"  placeholder="Zip Code as per the Bank Record" class="form-control" value="<?=prntext($post['purchaser_zipcode'])?>" required  />
      </div>
      <div class="col-sm-12 my-2 px-2">
<textarea name="purchaser_address" placeholder="Address as per the Bank Record" class="form-control"
required><?=prntext($post['purchaser_address'])?></textarea>
      </div>
    </div>
    <div class="row">
      <div class="bbg row">
        <h4><span id='result_view_chk' style='font-size:12px;'></span>Bank Information <span id='result_view' style='font-size:12px;'> </span> </h4>
        <div class="col-sm-3 my-2 px-2">
          <input type="number" step="00.01" name="transaction_amount" placeholder="Transaction Amount $&nbsp;USD" class="form-control" onkeyup="cangeThis()" id="heInput" value="<?=prntext($post['transaction_amount'])?>" required autocomplete="off"  />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <input type="text" name="purchaser_account" id="purchaser_account"  placeholder="Full Account No." class="form-control" value="<?=prntext($post['purchaser_account'])?>" required  />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <input type='text' pattern="[0-9]{9}" name='purchaser_routing' id='purchaser_routing'maxlength="9" placeholder="Bank ABA/Routing No." class="form-control" value="<?=prntext($post['purchaser_routing'])?>" required autocomplete="off" />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <input type="text" name="bank_name"  placeholder="Bank Name" class="form-control" onkeyup="hangeThis()" id="The1Input" value="<?=prntext($post['bank_name'])?>" required  />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <input type="text" name="bank_address" id="bank_address" placeholder="Bank Address" class="form-control" value="<?=prntext($post['bank_address'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <input type="text" name="bank_city" id="bank_city"  placeholder="Bank City " class="form-control" value="<?=prntext($post['bank_city'])?>" required  />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <select name="bank_state" id="bank_state" class="feed_input1 form-select" required>
            <option value="" disabled selected>Select Bank State</option>
            <option value="AL-Alabama">Alabama</option>
            <option value="AK-Alaska">Alaska</option>
            <option value="AZ-Arizona">Arizona</option>
            <option value="AR-Arkansas">Arkansas</option>
            <option value="CA-California">California</option>
            <option value="CO-Colorado">Colorado</option>
            <option value="CT-Connecticut">Connecticut</option>
            <option value="DE-Delaware">Delaware</option>
            <option value="DC-District Of Columbia">District Of Columbia</option>
            <option value="FL-Florida">Florida</option>
            <option value="GA-Georgia">Georgia</option>
            <option value="HI-Hawaii">Hawaii</option>
            <option value="ID-Idaho">Idaho</option>
            <option value="IL-Illinois">Illinois</option>
            <option value="IN-Indiana">Indiana</option>
            <option value="IA-Iowa">Iowa</option>
            <option value="KS-Kansas">Kansas</option>
            <option value="KY-Kentucky">Kentucky</option>
            <option value="LA-Louisiana">Louisiana</option>
            <option value="ME-Maine">Maine</option>
            <option value="MD-Maryland">Maryland</option>
            <option value="MA-Massachusetts">Massachusetts</option>
            <option value="MI-Michigan">Michigan</option>
            <option value="MN-Minnesota">Minnesota</option>
            <option value="MS-Mississippi">Mississippi</option>
            <option value="MO-Missouri">Missouri</option>
            <option value="MT-Montana">Montana</option>
            <option value="NE-Nebraska">Nebraska</option>
            <option value="NV-Nevada">Nevada</option>
            <option value="NH-New Hampshire">New Hampshire</option>
            <option value="NJ-New Jersey">New Jersey</option>
            <option value="NM-New Mexico">New Mexico</option>
            <option value="NY-New York">New York</option>
            <option value="NC-North Carolina">North Carolina</option>
            <option value="ND-North Dakota">North Dakota</option>
            <option value="OH-Ohio">Ohio</option>
            <option value="OK-Oklahoma">Oklahoma</option>
            <option value="OR-Oregon">Oregon</option>
            <option value="PA-Pennsylvania">Pennsylvania</option>
            <option value="RI-Rhode Island">Rhode Island</option>
            <option value="SC-South Carolina">South Carolina</option>
            <option value="SD-South Dakota">South Dakota</option>
            <option value="TN-Tennessee">Tennessee</option>
            <option value="TX-Texas">Texas</option>
            <option value="UT-Utah">Utah</option>
            <option value="VT-Vermont">Vermont</option>
            <option value="VA-Virginia">Virginia</option>
            <option value="WA-Washington">Washington</option>
            <option value="WV-West Virginia">West Virginia</option>
            <option value="WI-Wisconsin">Wisconsin</option>
            <option value="WY-Wyoming">Wyoming</option>
          </select>
          <script>$('#bank_state option[value="<?=prntext($post['bank_state'])?>"]').prop('selected','selected');</script>
        </div>
        <div class="col-sm-3 my-2 px-2">
          <input type="text" name='bank_zipcode' id='bank_zipcode' maxlength="5"  pattern="[0-9]{4,5}" placeholder="Bank Zip" class="form-control" value="<?=prntext($post['bank_zipcode'])?>" required  />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <input type="text" name="purchaser_echecknumber" id="purchaser_echecknumber"  placeholder="Check No." class="form-control" value="<?=prntext($post['purchaser_echecknumber'])?>" required autocomplete="off" />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <div class="hide">
            <input type="text" name="memo"  placeholder="Your Company Name/ 1(800)-000-0000" onKeyUp="chngeThis()" id="teInput" class="form-control" value="<?=prntext($post['descriptor'])?>" data-11="<?=prntext($post['descriptor'])?>"  />
            <span style="margin: -2px;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="Your Company Name / 1(800)-000-0000 customer service number"><i></i></span></div>
        </div>
      </div>
      <div class="col-sm-12 my-2 px-2">
        <textarea name="comments" placeholder="Description/Note" class="form-control"><?=prntext($post['comments'])?>
</textarea>
      </div>
      <div class="nomanditory row" id="nomanditory">
        <div style="display:none;">
          <div class="separator"></div>
          <label for="Address">Address (2):</label>
          <!--<input type=text name=purchaser_address2 placeholder="Suite 2-5040 Valley Cottage," class="form-control" value="<?=prntext($post['purchaser_address2'])?>"  />-->
<textarea name="purchaser_address2" placeholder="Suite 2-5040 Valley Cottage," class="form-control" ><?=prntext($post['purchaser_address2'])?></textarea>
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="company_name">Company Name </label>
          <input type="text" name="company_name"  placeholder="IBM" class="form-control" value="<?=prntext($post['company_name'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="employee_number">Employee No. </label>
          <input type="text" name="employee_number"  placeholder="IBM-380300" class="form-control" value="<?=prntext($post['employee_number'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="client_location">Client Location <span class=mand>*</span></label>
          <input type="text" name="client_location"  placeholder="" class="form-control" value="<?=prntext($post['client_location'])?>"  />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <div <?=$style_s?> >
            <label for="payable_to">Payable To<span class="mand">*</span></label>
            <input type="text" name="payable_to"  placeholder="Company to appear as the receiver of the funds" class="form-control" value="<?=prntext($post['company'])?>"  />
            <span style="margin: 0;" class="btn-action single glyphicons circle_question_mark" data-toggle="tooltip" data-placement="top" data-original-title="Company to appear as the receiver of the funds"><i></i></span> </div>
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="middle_initial">Middle Initial</label>
          <input type="text" name="middle_initial"  placeholder="" class="form-control" value="<?=prntext($post['middle_initial'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="other_phone_number">Bank Ph. No.</label>
          <input type="text" name="bank_phone" id="bank_phone"  placeholder="Bank Phone" class="form-control" value="<?=prntext($post['bank_phone'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="other_phone_number">Other Ph. No.</label>
          <input type="text" name="other_phone_number"  placeholder="" class="form-control" value="<?=prntext($post['other_phone_number'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="bank_fax">Bank Fax</label>
          <input type="text" name="bank_fax"  placeholder="" class="form-control" value="<?=prntext($post['bank_fax'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="nsf">NSF</label>
          <input type="text" name="nsf"  placeholder="" class="form-control" value="<?=prntext($post['nsf'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="tax_id">Tax ID</label>
          <input type="text" name="tax_id"  placeholder="" class="form-control" value="<?=prntext($post['tax_id'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="date_of_birth">Date of Birth</label>
          <input type="text" name="date_of_birth"  placeholder="" class="form-control" value="<?=prntext($post['date_of_birth'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="id_number">ID No.</label>
          <input type="text" name="id_number"  placeholder="" class="form-control" value="<?=prntext($post['id_number'])?>"   />
        </div>
        <div class="col-sm-3 my-2 px-2">
          <label for="id_state">ID State</label>
          <input type="text" name="id_state"  placeholder="" class="form-control" value="<?=prntext($post['id_state'])?>"   />
        </div>
      </div>
      <? if($post['apiprocess']=="true"||isset($_SESSION['apiprocess'])){ ?>
      <div class="inputdiv" style="width:100%!important;">
        <input type="checkbox" id="checkb" value="Authorized" name="checkb" style="float:left; margin:0 20px 0 0;"  required />
        <label for="checkb" style="float:left;width:90%;text-align:left;padding:0;">I <b><span id='newText'></span> <span id='neText'></span> </b>Authorize,<b>
        <?=prntext($post['company'])?>
        </b> to initiate debit/credit a sum of <b>$<span id='new1Text'></span></b> from  my bank <b>(<span id='new2Text'></span>)</b> to process my order. Regarding the subject of this Agreement and the Financial Institution at which my account is held to debit/credit the amount and this agreement will remain in full force and effect until <b>
        <?=prntext($post['company'])?>
        </b> and the Financial Institution have received any written notification from me for its termination.</label>
        <input type="checkbox" id="checkb" value="Authorized" name="checkb" style="float:left; margin:8px 200 6px 0px;"  required />
        <label for="checkb" style="float:left;width:90%;text-align:left;padding:0; margin: -22px 26px 20px 32px;">I understand that I may cancel this authorization by providing written notice to <b>
        <?=prntext($post['company'])?>
        or ZtsPay </b>at least three (3) business days prior to the payment due date. I further understand that canceling my authorization does not relieve me of the responsibility of paying all dues amount. </label>
      </div>
      <br/>
      <? }?>
      <!-- <label for="change"> </label>-->
      <div class="my-2 text-center">
        <button type="submit" id="btn-confirm_"  name="change" value="PLACE ORDER"   class="submit_echeck_btn btn btn-icon btn-primary"><i class="far fa-check-circle"></i> Place Order </button>
      </div>
    </div>
    <!--<style>
.modal.fade.in {top:20%;width:inherit;border:1px solid #000;margin-left:-150px;}
.modal-backdrop, .modal-backdrop.fade.in {z-index:0; opacity:0.6;filter:alpha(opacity=60);}
.logo_du{width:120px;display:block;margin:10px auto;}
.session_exp_img {width:70px;height:99px;background:url('<?php echo $data['Host']?>/contact/images/session_exp.png') no-repeat;display:block;margin:20px auto 20px auto;background-size:100%;}
.hang_b{color:#1aabea;font-size:24px;text-align:center;margin:15px 0px;}
.hang_row {margin-top:12px;font-size:12px;}
.hang_c1 {width:135px;float:left;padding-left:14px;}
.hang_c2{width:147px;float:left;}

.modal_foot {width:312px;font-size:12px;float:left;margin:15px 0 15px 14px;}
.button_11 {color: #fff;background: #1aabea;border: 2px solid #1aabea;width:145px;height:35px;text-align:center;}

</style>-->
    <? if(isset($_GET['actionuse'])){ ?>
    <!--<style>
		.modal.fade.in {top:-17%;}	
	</style>-->
    <? } ?>
    <!--<div class="modalpopup_form_popup_layer" id="modal_dialog_conf" style="display:none"> </div>
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" id="mi-modal" style="z-index:9999999;">
  <div class="modal-dialog modal-sm">
    <div class="modal-content"> <img src="<?php echo $data['Host']?>/contact/images/logo.png" class="logo_du">
      <div class="session_exp_img"> </div>
      <div class="modal-body1" id="modal-body1" style="width:350px;">
          <div class="hang_b">Hang on..</div>
          <div style="font-size:12px;text-align:center;">Have you Verified the below details from the customer as per bank record or  verified from printed check?
          </div>
        <div class="hang_row">
          <div class="hang_c1">Account Holder Name</div>
          <div id="hang_name" class="hang_c2">abc</div>
        </div>
        <div class="hang_row2" >
          <div class="hang_c1">Account Number</div>
          <div id="hang_acc" class="hang_c2">123</div>
        </div>
          <div class="modal_foot">
            <div class="tooltip1" style="width:145px;float:left;">
              <input class="button_11" type="submit" id="btn-confirm2" name="change" value="Yes" style="width:145px;position:relative;z-index: 999;cursor:pointer;" />
              <span class="tooltip1text">I have verified</span></div>
            <div class="tooltip1" style="width:145px;float:right;">
              <input id="modal-btn-no" value="No" class="button_11" style="position:relative;z-index: 999;cursor:pointer;"/>
              <span class="tooltip1text">Let me edit</span></div>
          </div>
      </div>
    </div>
  </div>
</div>-->
    <div class="alert hide" role="alert" id="result" style=""></div>
    <script>
var $form = $('#submit_echeck_form');
var confirm_ok=false;
var confirmVar=false;
var modalConfirm = function(callback){
  
  $("#btn-confirm").on("click", function(e){
		var confirm_msg="Are you sure that below information are correct as per the bank record or (Printed in the bank Check)?<br/><b>Name on Account:</b> "+$(".purchaser_firstname").val()+" "+$(".purchaser_lastname").val()+"<br/><b>Account Number</b> :"+$("#purchaser_account").val()+"<br/>";
	
		//$('#modal-body').html(confirm_msg);
		$('#hang_name').html($(".purchaser_firstname").val()+" "+$(".purchaser_lastname").val());
		$('#hang_acc').html($("#purchaser_account").val());
		
		$('#submit_echeck_form').submit(function(e) {
			//alert("11: "+error_val);
			$('#confirm_status').val();
			if (this.checkValidity() == false){
				 // if form is not valid show native error messages 
				alert("if: "+error_val);
				return false;
			}
			else{
				 $("#mi-modal").modal('show');
				  $('#modal_dialog_conf').show();
				// $('#confirm_status').val('confirm');
				 if($('#confirm_status').val()==="confirm"){
					$("body").addClass('modalactive');
					$("#mi-modal").modal('hide');
					 $("#btn-confirm span,#btn-confirm2 span").html("<img src='<?=$data['Host']?>/images/icons/loading_spin_icon.gif' style='height:18px;' /> Please Wait...");	
					 $('#modalpopup_form_popup').slideDown(900);
					 //return false;
					 return true;
				 }else{
					return false;
				 }
				 
				
			}
			
		});
	});
  
	$("#btn-confirm2").on("click", function(e){
		$('#confirm_status').val('confirm');
		confirm_ok=true;
		callback(true);
		$("#mi-modal").modal('hide');
		
		
	});
	$("#modal-btn-si").on("click", function(){
		confirm_ok=true;
		callback(true);
		$('#confirm_status').val('confirm');
		$("#mi-modal").modal('hide');
	});
	$("#modal-btn-no").on("click", function(){
	confirm_ok=false;
    callback(false);
	$('#modal_dialog_conf').hide();
    $("#mi-modal").modal('hide');
  });
  
  
};


modalConfirm(function(confirm){
  if(confirm){
	$('#confirm_status').val('confirm');
	confirmVar=true;
	$('#teInput').removeAttr('disabled');
	//$('#submit_echeck_form').trigger('submit');
	//$form.get(0).submit();
  }else{
	$('#confirm_status').val('');
	confirmVar=false;
	//$("#result").html("NO CONFIRMADO");
  }
  //alert("1111="+confirm);
  
});
</script>
    <? } ?>
  </form>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
