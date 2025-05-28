<? if(isset($data['ScriptLoaded'])){ ?>
<style>

.input-field .input-group .form-control {background-color:transparent;} 

.input-field .input-group label {left: 36px;  padding:0px 2px; background-color:var(--bs-body-bg) !important;color:var(--bs-body-color) !important;} 
 
.input-field .input-group input:valid+label {padding: 0px 2px;background-color:var(--bs-body-bg) !important;color:var(--bs-body-color) !important;z-index:9;} 

</style>

<div id="zink_id" class="container border rounded  mt-2 mb-2 bg-primary vkg" >

<?php /*?>js Function for Copy Payment Link <?php */?>
<script>
function myCopyFunction(theId,theLabel) {
  /* Get the text field */
  var copyText = document.getElementById(theId);

  /* Select the text field */
  copyText.select();

  /* Copy the text inside the text field */
  document.execCommand("copy");

  /* Alert the copied text */
  alert("Copied : " + theLabel);
}

<?php /*?> js Function for Show Hide Payment Details section on click of Request ID <?php */?>

$(document).ready(function(){

var sline=$("#email_subject").val();

	/*
    $('.ctc_f1').click(function(e){
		alert('ctc_f======');
	   ctc_f(e);
    });
	*/
	
	
    $('.collapsea').click(function(){
	   var ids = $(this).attr('data-href');
	   var ids2 = ids+"_v";
		if($(this).hasClass('active')){
			$('.collapseitem').removeClass('active');
			$('.collapsea').removeClass('active');
			$('.divhide').css("display", "none");
			
			$('#'+ids).slideUp(200);
			$('.'+ids).slideUp(200);
			$('#'+ids2).slideUp(200);
		} else {
		  $('.collapseitem').removeClass('active');
		  $('.collapsea').removeClass('active');
		  $('.divhide').css("display", "");
		  //$('#'+ids).addClass('active');
		  $(this).addClass('active');
		  
		  $('.collapseitem').slideUp(100);
		  $('#'+ids).slideDown(700);
		  $('#'+ids2).slideDown(700);
		}
        
    });
	
	
	
    $(".email_validate_input").keyup(function(){
		email_validatef(this,".validate_input_firstname","");
	});
	
	var email_subject_var="1";
	$("#storeType").change(function() {
	   var selectedItem = $(this).val();
	   var burl= $('option:selected', this).attr('data-burl');
	   var dba= $('option:selected', this).attr('data-dba');
	   //alert(burl);
	   //alert(dba);
	   
	    //if($("#email_subject").val()===""||$("#email_subject").val()==""||email_subject_var==""){
		//alert(burl+"\r\n"+dba);
		//email_subject_var="";
		var email_subject = "You have got a payment request from";
		if(burl){email_subject += " - "+burl;}
		if(dba){email_subject += " - "+dba;}
		$("#email_subject").val(email_subject);
	   //}
	   
	 
	});
});
</script>
<? $convert_qrcode_from_url=$data['Host']."/@".prntext(@$post['username']).""; ?>
  <div class="row vkg row clearfix_ice">
  
    <div class="py-2" style="width:150px;">
      <h4 class="float-start"><i class="<?=@$data['fwicon']['requestfund'];?>"></i> Request Fund</h4>
    </div>
	
	<div class="py-2" style=" width: calc(100% - 150px);">
	<form method="post" name="data" >
	<div class="ro col-sm-12 row float-end"> <span class="float-end d-none d-sm-block text-end" style="width:calc(100% - 125px);"> <a href="<?=@$convert_qrcode_from_url;?>" target="_blank" title="Direct Checkout (UserId and Amount):" class="btn btn-primary my-rpnsive-btn text-break ">Payments Links: <?=@$convert_qrcode_from_url;?></a></span>
	
      <button title="Copy to Payments Links" type="button" class="btn btn-primary my-rpnsive-btn ms-1" onclick="copytext_f(this,'Payments Links')" data-value='<?=urldecode($convert_qrcode_from_url);?>' style="width:35px;"><i class="<?=@$data['fwicon']['copy'];?>"></i></button>
	  
	  <button title="Your QR code"  data-href="https://quickchart.io/chart?chs=300x300&cht=qr&chl=<?=urlencode(@$convert_qrcode_from_url);?>&choe=UTF-8" data-value='<?=urlencode(@$convert_qrcode_from_url)?>' class="btn btn-primary my-rpnsive-btn modal_from_url_qrcode mx-1" style="width:35px;"><i class="<?=@$data['fwicon']['qrcode'];?>"></i></button>
	  
      <button type="submit" name="send" value="Add New Request Money!" class="btn btn-primary my-rpnsive-btn me-1" style="width:35px;"><i class="<?=@$data['fwicon']['circle-plus'];?>" title="Add A New Request Money" ></i></button>

    </div>
	</form>
	</div>
  </div>
  <form method="post" name="data" >
    <input type="hidden" name="step" value="<?=((isset($post['step']) &&$post['step'])?$post['step']:'')?>">
    <input type="hidden" name="uid" value="<?=((isset($post['uid']) &&$post['uid'])?$post['uid']:'')?>">
    <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      <strong>Error! </strong>
      <?=prntext(@$data['Error'])?>
    </div>
    <? } ?>
    <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      <?php echo $_SESSION['action_success'];?> </div>
    <? $_SESSION['action_success']=null;} ?>
    <? if($post['step']==1){ 
	
	//echo count($data['selectdatas']);
	?>
    
    <div class="my-2 col-sm-12 table-responsive">
      <table class="table table-hover bg-primary text-white">
	  
	    <? if(count($data['selectdatas'])!=0){ ?>
        <thead>
          <tr>
		    <th scope="col">#</th>
		    <th scope="col">Request ID</th>
            <th scope="col">Name</th>
            <th scope="col">Email</th>
            <th scope="col">Amount</th>
            <th scope="col">&nbsp;</th>
          </tr>
        </thead>
		
		<? }else{ ?>
		<tr class="rounded bg-white">
		<td colspan="5"  style="padding-left: unset !important;">
		<div class="my-2 ms-2 fs-5 text-start">Create an request money in minutes</div>
		
		<div class="text-start my-2 ms-2" style="max-width:400px !important;">Send your customers an request money with a link to pay online. Accept card, bank transfers, and more.</div>
		<button type="submit" name="send" value="Add New Request Money!" class="btn btn-primary my-2 ms-2 float-start"><i class="<?=@$data['fwicon']['circle-plus'];?>" title="Add A New Request Money" ></i> Add A New Request Money</button>
		</td>
		</tr>
		<? } ?>
        <? $j=1; foreach($data['selectdatas'] as $ind=>$value) { ?>
        <? $jsr=jsondecode($value['json_value']);?>
        <tr>
		  <td><div class="content"><a data-bs-toggle="modal" data-count="<?=prntext(@$value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=@$data['fwicon']['display'];?> data_display text-link" title="View  details"></i></a></div></td>
          <td><?=substr($value['transactioncode'],0,20)?></td>
          <td><?php if($value['fullname']){echo $value['fullname'];}elseif($value['rlname']){echo $value['rname']." ".$value['rlname'];}else{echo $value['rname'];} ?></td>
          <td><?=@$value['receiver_email']?></td>
          <td><?=@$value['amount']?></td>
          <td><? if($value['status'] !="Pending") { ?><b><?=@$value['status'];?></b><? } else{ ?>
<?
$convert_qrcode_list=urlencode($data['Host']."/payme".$data['ex'].$jsr['noneEditableUrl']);
?>
<span id="apic<?=@$j;?>" class="hide"><?=urldecode($convert_qrcode_list);?></span>            
			
<div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false" title="Action" ><i class="<?=@$data['fwicon']['action'];?> text-link"></i></a>
 <ul class="dropdown-menu dropdown-menu-icon pull-right" >

   <li> <a class="dropdown-item" href="<?=@$data['USER_FOLDER']?>/request_fund<?=@$data['ex']?>?id=<?=@$value['id']?>&action=update" title="Edit"><i class="<?=@$data['fwicon']['edit'];?> text-success float-start"></i> <span class="action_menu">Edit</span></a></li>
				  
   <li> <a class="dropdown-item" href="<?=@$data['USER_FOLDER']?>/request_fund<?=@$data['ex']?>?id=<?=@$value['id']?>&action=delete"  title="Delete" onclick="return confirm('Are you Sure to Delete');"><i class="<?=@$data['fwicon']['delete'];?> text-danger float-start"></i> <span class="action_menu">Delete</span></a></li>
                  
   <li> <a class="dropdown-item modal_from_url_qrcode" title="Your QR code"  data-href="https://quickchart.io/chart?chs=300x300&cht=qr&chl=<?=@$convert_qrcode_list;?>&choe=UTF-8" data-value='<?=$convert_qrcode_list?>' copyid="apic<?=@$j;?>" style="width:40px;"><i class="<?=@$data['fwicon']['qrcode'];?>  float-start text-white"></i> <span class="action_menu">QR code</span></a></li>

 </ul>              
</div>

<? } ?>
  
          </td>
        </tr>
        <tr class="hide">
          <td colspan="6">
		      <div class="next_tr_<?=prntext(@$value['id'])?>  hide">
              <div class="row">
             
                  <? if(isset($value['fullname'])&&$value['fullname']){ ?>
                <div class="col-sm-12  px-2  mboxtitle">Name Of The Receiver :
                  <?=@$value['fullname']?>
                </div>
                <? } elseif(isset($value['rname'])&&$value['rname']){ ?>
                <div class="col-sm-12  px-2  mboxtitle">Name Of The Receiver :
                  <?=@$value['rname']?>
                </div>
                <? } ?>

                <? if(isset($value['receiver_email'])&&$value['receiver_email']){ ?>
                <div class="col-sm-12 px-2 "><strong>Receivers Email Address :</strong>
                  <?=@$value['receiver_email']?>
                </div>
                <? } ?>

                <? if(isset($value['amount'])&&$value['amount']){ ?>
                <div class="col-sm-12  px-2 "><strong>Amount Payable :</strong>
                  <?=@$value['amount']?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_phone'])&&$jsr['bill_phone']){ ?>
                <div class="col-sm-12 px-2 "><strong>Subject :</strong>
                  <?=@$jsr['email_subject'];?>
                </div>
                <? } ?>
                <? if(isset($value['comments'])&&$value['comments']){ ?>
                <div class="col-sm-12  px-2 "><strong>Description (Optional) :</strong>
                  <?=@$value['comments']?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_phone'])&&$jsr['bill_phone']){ ?>
                <div class="col-sm-12 px-2 "><strong>Phone :</strong>
                  <?=@$jsr['bill_phone'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_address'])&&$jsr['bill_address']){ ?>
                <div class="col-sm-12  px-2 "><strong>Address :</strong>
                  <?=@$jsr['bill_address'];?>
                </div>
                <? } ?>
                
                <? if(isset($jsr['bill_city'])&&$jsr['bill_city']){ ?>
                <div class="col-sm-12  px-2 "><strong>City :</strong>
                  <?=@$jsr['bill_city'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_state'])&&$jsr['bill_state']){ ?>
                <div class="col-sm-12 px-2 "><strong>State :</strong>
                  <?=@$jsr['bill_state'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_country'])&&$jsr['bill_country']){ ?>
                <div class="col-sm-12  px-2 "><strong>Country :</strong>
                  <?=@$jsr['bill_country'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_zip'])&&$jsr['bill_zip']){ ?>
                <div class="col-sm-12 px-2 "><strong>Zip :</strong>
                  <?=@$jsr['bill_zip'];?>
                </div>
                <? } ?>
                <div class="col-sm-12  px-2 "><strong>Status :</strong>
                  <?=@$value['status']?>
                  <? if($value['transID']){ ?>
                  | <a href="<?=@$data['USER_FOLDER'];?>/transactions<?=@$data['ex']?>?action=select&searchkey=<?=@$value['transID']?>&keyname=1&type=-1&status=-1"><?=@$value['transID']?></a>
                  <? } ?>
                </div>
                <? if(isset($jsr['noneEditableUrl'])&&$jsr['noneEditableUrl']){ ?>
                <div class="col-sm-12 px-2"><strong>None Editable - Pay URL</strong>
                  <div class="ro" style="float:none;display: inline-block;" onclick="copytext_f(this,'None Editable - Pay URL')" data-value='<?=@$data['Host']?>/payme<?=@$data['ex']?><?=@$jsr['noneEditableUrl']?>'  >
					<i class="<?=@$data['fwicon']['copy'];?>" title="Copy to None Editable - Pay URL"></i>
                  </div>
                </div>
                <a class="col_2 px-2 text-link text-break" id="paymentsLinksId_nonedt_<?=@$j;?>" target="_blank" href="<?=@$data['Host']?>/payme<?=@$data['ex']?><?=@$jsr['noneEditableUrl']?>" ><?=@$data['Host']?>/payme<?=@$data['ex']?><?=@$jsr['noneEditableUrl']?></a>
                <? } ?>
                <? if(isset($jsr['editableUrl'])&&$jsr['editableUrl']){ ?>
                <div class="col-sm-12  px-2"><strong>Editable - Pay URL</strong>
                  <div class="ro" style="float: none;display:inline-block;cursor:pointer;" onclick="copytext_f(this,'Editable - Pay URL..')" data-value='<?=@$data['Host']?>/payme<?=@$data['ex']?><?=@$jsr['editableUrl']?>' >  <i class="<?=@$data['fwicon']['copy'];?>" title="Copy to Editable - Pay URL"></i>
                  </div>
                </div>
                <a class="col_2 px-2 text-link text-break" id="paymentsLinksId_edt_<?=@$j;?>" target="_blank" href="<?=@$data['Host']?>/payme<?=@$data['ex']?><?=@$jsr['editableUrl']?>" ><?=@$data['Host']?>/payme<?=@$data['ex']?><?=@$jsr['editableUrl']?></a>
                <? } ?>
              </div>
            </div>
		  </td>
        </tr>
        <? $j++; } ?>
      </table>
    </div>
    <? }elseif($post['step']==2){ ?>
    <? if(isset($post['gid'])&&$post['gid']){ $na=""; ?>
    <input type="hidden" name="gid" value="<?=@$post['gid']?>">
    <? }else{ $na="NA";
	   
	}
  ?>
    <?
$firstName="";
$lastName="";


if(isset($post['rlname'])&&$post['rlname']){
	$firstName=$post['rname'];
	$lastName=$post['rlname'];
}else{
	if(isset($post['rname'])&&$post['rname']&&strpos($post['rname'],".")!==false){
		$rname=explode(".",$post['rname']);
		$firstName=$rname[0];
		$lastName=$rname[1];
	}else{
		$firstName=@$post['rname'];
		$lastName=@$post['rlname'];
	}
}
?>
    <h4 class="heading glyphicons settings"><?=@$post['add_titileName'];?> Request Fund</h4>
      
      
    <div class="row was-validated px-1">
      <? $k=0; if($data['Store']&&$data['store_size']>1){ ?>
      <div class="col-sm-6 px-1">
	  <div class="input-field select mt-4">
        <select name="type" id="storeType" class="form-control " title="Select your website" data-bs-toggle="tooltip" data-bs-placement="bottom"  required>
          <option value="" disabled>&nbsp;</option>
          <?
				foreach($data['Store'] as $key=>$value){
			?>
          <option data-burl="<?=@$value['bussiness_url'];?>" data-dba="<?=@$value['dba_brand_name'];?>" data-val="<?=@$value['public_key'];?>" value="<?=@$value['public_key'];?>_;<?=@$k;?>">
          <?=@$value['ter_name']?>
          </option>
          <? $k++; } ?>
        </select>
		 <label for="storeType" >Select Business<i class="<?=@$data['fwicon']['star'];?> text-danger"></i></label>
		</div>
        <? if(isset($post['type'])&&$post['type']){ ?>
        <script>
			$('#storeType option[data-val="<?=($post['type'])?>"]').prop("selected", "selected");
			$('#storeType option[data-val="<?=($post['type'])?>"]').attr("selected", "selected");
		</script>
        <? } ?>
      </div>
	  
      <? } ?>
      <div class="col-sm-6 px-1">
	  <div class="input-field mt-4">
        <input type="text" name="json_value[email_subject]" id="email_subject"  class="form-control col-sm-6" value='<?=prntext(@$post['json_value']['email_subject'])?>' title="Enter subject line for email" data-bs-toggle="tooltip" data-bs-placement="bottom" required >
		<label for="email_subject" >Subject line for Email<i class="<?=@$data['fwicon']['star'];?> text-danger"></i></label>
		</div>
      </div>
      <? if(!isset($post['gid']) || !$post['gid']){
		//$post['json_value']=[];
	} ?>
      <div class="col-sm-6 px-1">
	  <div class="input-field mt-4">
        <input type="email" name="receiver_email" id="rf_email"  class="email_validate_input88 form-control" value="<?=(isset($post['receiver_email'])?$post['receiver_email']:'')?>" title="Enter the receivers email address" data-bs-toggle="tooltip" data-bs-placement="bottom" required autocomplete="off"  />
		<label for="rf_email" >Receiver Email Address<i class="<?=@$data['fwicon']['star'];?> text-danger"></i></label>
      </div>
	  </div>

	  <div class="col-sm-6 px-1">
	  <div class="input-field mt-4">
		<div class="input-group ">
		  <span class="input-group-text"><?=(get_currency($post['default_currency']));?></span>
		  <input type="number" step="00.01" name="amount" id="rf_amount"  class="form-control" value="<?=prntext(isset($post['amount'])?$post['amount']:'')?>" title="Enter the full amount ex. 10.00" data-bs-toggle="tooltip" data-bs-placement="bottom" required  />
		  <label for="pr_designation" >Full Amount ex. 10.00 <i class="<?=@$data['fwicon']['star'];?> text-danger"></i></label>
		</div></div>
	</div>
	
   
        
        
      <div class="col-sm-6 px-1">
	  <div class="input-field mt-4">
        <input type='text' name='fullname' id="rf_fullname" class="validate_input_firstname form-control" value="<?=prntext(isset($post['fullname'])?$post['fullname']:'')?>" title="Enter full name of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" required />
		<label for="rf_fullname" >Full Name of the Receiver <i class="<?=@$data['fwicon']['star'];?> text-danger"></i></label>
      </div> 
	  </div>
      <?php

if(!isset($post['json_value']['bill_phone']))		$post['json_value']['bill_phone']	= "";
if(!isset($post['json_value']['bill_address']))	$post['json_value']['bill_address']= "";
if(!isset($post['json_value']['bill_city']))		$post['json_value']['bill_city']	= "";
if(!isset($post['json_value']['bill_state']))		$post['json_value']['bill_state']	= "";
if(!isset($post['json_value']['bill_country']))		$post['json_value']['bill_country']	= "";
if(!isset($post['json_value']['bill_zip']))			$post['json_value']['bill_zip']		= "";
if(!isset($post['json_value']['encryption_types']))	$post['json_value']['encryption_types']= "";

if(!isset($post['user_type']))	$post['user_type']= "";

?>
      <div class="col-sm-6 px-1">
	  <div class="input-field mt-4">
        <input type='text' name='json_value[bill_phone]' id="fr_bill_phone" class="validate_input_firstname form-control" value='<?=prntext(@$post['json_value']['bill_phone'])?>' title="Enter phone of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" required />
		<label for="fr_bill_phone" >Phone Number of the Receiver <i class="<?=@$data['fwicon']['star'];?> text-danger"></i></label>
      </div></div>
<? 

if($data['con_name']=='clk'){
	$style_display='display:none;';
 }
 else{
	 $style_display='';
 }

 //echo "<br/>con_name=>".$data['con_name']."<br/><br/>";
 ?>
      <div class="col-sm-6 px-1 na_clk"  style='<?=@$style_display;?>'>
	  <div class="input-field mt-4">
        <input type='text' name='json_value[bill_address]' id="fr_bill_address" class="validate_input_firstname form-control" value='<?=prntext(@$post['json_value']['bill_address'])?> <?=@$na;?>' style='<?=@$style_display;?>' title="Enter street 1 of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
		<label for="fr_bill_address" >Address of the receiver </label>
      </div></div>
      
      <div class="col-sm-6 px-1 na_clk"  style='<?=@$style_display;?>'>
	  <div class="input-field mt-4">
        <input type='text' name='json_value[bill_city]' id="fr_bill_city" class="validate_input_firstname form-control" value="<?=prntext(@$post['json_value']['bill_city'])?> <?=@$na;?>" style='<?=@$style_display;?>' title="Enter city of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
		<label for="fr_bill_city" >City of the Receiver </label>
      </div></div>
      <div class="col-sm-6 px-1 na_clk"  style='<?=@$style_display;?>'>
	  <div class="input-field mt-4">
        <input type='text' name='json_value[bill_state]' id="fr_bill_state" class="validate_input_firstname form-control" value="<?=prntext(@$post['json_value']['bill_state'])?> <?=@$na;?>" style='<?=@$style_display;?>' title="Enter state of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
		<label for="fr_bill_state" >State of the Receiver </label>
      </div></div>
      <div class="col-sm-6 px-1 na_clk"  style='<?=@$style_display;?>'>
	  <div class="input-field mt-4">
        <input type='text' name='json_value[bill_country]' id="fr_bill_country" class="validate_input_firstname form-control" value="<?=prntext(@$post['json_value']['bill_country'])?> <?=@$na;?>" style='<?=@$style_display;?>' title="Enter country of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
		<label for="fr_bill_country" >Country of the Receiver </label>
      </div></div>
      <div class="col-sm-6 px-1 na_clk"  style='<?=@$style_display;?>'>
	  <div class="input-field mt-4">
        <input type='text' name='json_value[bill_zip]' id="fr_bill_zip" class="validate_input_firstname form-control" value="<?=prntext(@$post['json_value']['bill_zip'])?> <?=@$na;?>" style='<?=@$style_display;?>' title="Enter zip code of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
		<label for="fr_bill_zip" >Zip code of The Receiver </label>
      </div></div>
      <div class="col-sm-12 px-1">
	  <div class="input-field mt-4">
        <textarea id="mustHaveId" class="form-control" name="comments" rows="5"  data-bs-toggle="tooltip" data-bs-placement="bottom"><?=prntext(isset($post['comments'])?$post['comments']:'')?></textarea>
		<label for="mustHaveId" >Message for the Receiver </label>
      </div></div>
      <div class="radios col-sm-12 px-1" style="margin:5px 0 10px 0;">
        <input type="radio" name="json_value[encryption_types]" id="NoneEditable"  value="1" <? if($post['json_value']['encryption_types']==1||$post['json_value']['encryption_types']==''){echo "checked";} ?> />
        <label for="NoneEditable">None Editable</label>
        <input type="radio" name="json_value[encryption_types]" id="Editable"  value="2" <? if(($post['json_value']['encryption_types']==2)||(empty($post['user_type']))){echo "checked";} ?> />
        <label for="Editable">Editable</label>
      </div>
      <div class="col-sm-12 my-2 text-center remove-link-css">
        <button type="submit" name="send" value="CONTINUE" class="btn btn-icon btn-primary mx-1"><i class="<?=@$data['fwicon']['verified'];?>"></i> Submit</button><a href="<?=@$data['USER_FOLDER']?>/<?=@$data['PageFile']?><?=@$data['ex']?>" class="btn btn-icon btn-primary mx-1" ><i class="<?=@$data['fwicon']['back'];?>"></i> Back</a> </div>
      <? } ?>
    </div>
  </form>
</div>

<!--Js for qr code generation-->
<script>
$('.modal_from_url_qrcode').on('click', function(e){
      e.preventDefault();
	  var imghref= $(this).attr('data-href');
	  //var copyid= $(this).attr('copyid');
	  var fnforcopy="ctc_f(this,'Pay via QR-Code')";
	  
	  $('#converturltoQrcode').modal('show');
	  $('#qrimgvid').attr('src', imghref );
	  $('#qr_link_footer').val(imghref);
	  $('#qrcopycode').attr('data-value', imghref );
	  $('#qrcopycode').attr('onclick', fnforcopy );
	  $('#converturltoQrcode .modal-title').html($(this).attr('title'));
	  
    });
</script>
<!--Modal for qr code generation-->
<div class="modal" id="converturltoQrcode">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Heading</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body text-center">
	  <div class="border rounded p-4"><img id="qrimgvid" src="#" title="Payment Link" /></div>
  	  <div class="my-2 btn btn-primary w-500" id="qrcopycode" onclick="ctcf('#apic')"><i class="<?=@$data['fwicon']['copy'];?>" title="Copy Payment Link"></i></div>
	  
	  <a class="my-2 btn btn-primary w-500" data-bs-toggle="collapse" href="#collapseShareDiv" role="button" aria-expanded="false" aria-controls="collapseShareDiv"><i class="<?=@$data['fwicon']['share'];?>" title="Share Payment Link"></i></a>
	  <div class="collapse border rounded p-2 text-vlight" id="collapseShareDiv">
    <form action="<?=@$data['Host']?>/user/request_fund<?=@$data['ex']?>" method="post">
	<input type="hidden" name="qrid" id="qrid_footer" value="<?=@$_SESSION['uid']?>" />
	<input type="hidden" name="qr_link" id="qr_link_footer" />
	<input type="text" name="email" class="form-control float-start" value="" style="width: calc(100% - 70px)" title="Enter email id for share qrcode" data-bs-toggle="tooltip" data-bs-placement="top" required />
	<input type="submit" class="btn btn-primary float-start ms-2" name="share_qr_code" value="share" style="width:60px;" />
	</form>
	  <div class="clearfix"></div>
	  </div>
	  
	  </div>
      </div>

     

    </div>
  </div>
  
<!--</div>-->
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
