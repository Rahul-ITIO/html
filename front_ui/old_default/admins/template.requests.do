<? if(isset($data['ScriptLoaded'])){ ?>
<div id="zink_id" class="container border rounded  mt-2 mb-2 bg-vlight vkg" >

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
	   if($("#email_subject").val()===""||$("#email_subject").val()==""||email_subject_var==""){
		//alert(burl+"\r\n"+dba);
		email_subject_var="";
		var email_subject = "You have got a payment request from";
		if(burl){email_subject += " - "+burl;}
		if(dba){email_subject += " - "+dba;}
		$("#email_subject").val(email_subject);
	   }
	   
	 
	});
});
</script>

  <div class="row vkg row clearfix_ice">
    <div class="col-sm-12 py-2">
      <h4 class="float-start"><i class="<?=$data['fwicon']['requestfund'];?>"></i> Request Fund</h4>
    </div>
  </div>
  <form method="post" name="data" >
    <input type="hidden" name="step" value="<?=((isset($post['step']) &&$post['step'])?$post['step']:'')?>">
    <input type="hidden" name="uid" value="<?=((isset($post['uid']) &&$post['uid'])?$post['uid']:'')?>">
    <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      <strong>Error! </strong>
      <?=prntext($data['Error'])?>
    </div>
    <? } ?>
    <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      <?php echo $_SESSION['action_success'];?> </div>
    <? $_SESSION['action_success']=null;} ?>
    <? if($post['step']==1){ 
	
	$convert_qrcode_from_url=$data['Host']."/payme".prntext($data['ex'])."/".prntext($post['username'])."/50.00/";
	?>
    <div class="ro col-sm-12 row"> <span class="float-end d-none d-sm-block text-end" style="width:calc(100% - 150px);"  > <a href="<?=$convert_qrcode_from_url;?>" target="_blank" title="Direct Checkout (UserId and Amount):" class="btn btn-primary my-rpnsive-btn text-break my-2 "  >
	Payments Links: <?=$convert_qrcode_from_url;?></a></span>
   <span id="apic" class="hide"><?=urldecode($convert_qrcode_from_url);?></span>
      
      <button title="Copy to Payments Links" type="button" class="btn btn-primary my-rpnsive-btn my-2 ms-2 float-end"  onclick="ctcf('#apic')" style="width:40px;"><i class="<?=$data['fwicon']['copy'];?>"></i></button>
	  
	  <a title="Your QR code"  href="https://quickchart.io/chart?chs=300x300&cht=qr&chl=<?=$convert_qrcode_from_url;?>&choe=UTF-8" class="btn btn-primary my-rpnsive-btn my-2 ms-2 float-end modal_from_url_qrcode" copyid="apic" style="width:40px;"><i class="<?=$data['fwicon']['qrcode'];?>"></i></a>
	  
      <button type="submit" name="send" value="Add New Request Money!" class="btn btn-primary my-rpnsive-btn my-2 ms-2 float-end" style="width:40px;"><i class="<?=$data['fwicon']['circle-plus'];?>" title="Add A New Request Money" ></i></button>

    </div>
    <div class="my-2 col-sm-12 table-responsive-sm">
      <table class="table table-hover">
	  
	    <? if(count($data['selectdatas'])!=0){ ?>
        <thead>
          <tr>
		    <th scope="col">#</th>
		    <th scope="col">Request ID</th>
            <th scope="col">Name</th>
            <th scope="col">Email</th>
            <th scope="col">Amount</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
		
		<? }else{ ?>
		<tr class="rounded bg-white">
		<td colspan="5"  style="padding-left: unset !important;">
		<div class="my-2 ms-2 fs-5 text-start">Create an request money in minutes</div>
		
		<div class="text-start my-2 ms-2" style="max-width:400px !important;">Send your customers an request money with a link to pay online. Accept card, bank transfers, and more.</div>
		<button type="submit" name="send" value="Add New Request Money!" class="btn btn-primary my-2 ms-2 float-start"><i class="<?=$data['fwicon']['circle-plus'];?>" title="Add A New Request Money" ></i> Add A New Request Money</button>
		</td>
		</tr>
		<? } ?>
        <? $j=1; foreach($data['selectdatas'] as $ind=>$value) { ?>
        <? $jsr=jsondecode($value['json_value']);?>
        <tr>
		  <td><div class="content"><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> data_display text-dark" title="View  details"></i></a></div></td>
          <td><?=substr($value['transactioncode'],0,20)?></td>
          <td><?php if($value['rlname']){echo $value['rname']." ".$value['rlname'];}else{echo $value['rname'];} ?></td>
          <td><?=$value['remail']?></td>
          <td><?=$value['amount']?></td>
          <td><? if($value['status'] !="Pending") { ?><b><?=$value['status'];?></b><? } else{ ?>
            
            <a href="<?=$data['USER_FOLDER']?>/requests<?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit" class="glyphicons alarm"><i class="<?=$data['fwicon']['edit'];?> text-success"></i></a>&nbsp;&nbsp;<a href="<?=$data['USER_FOLDER']?>/requests<?=$data['ex']?>?id=<?=$value['id']?>&action=delete"  title="Delete" onclick="return confirm('Are you Sure to Delete');"><i class="<?=$data['fwicon']['delete'];?> text-danger"></i></a> 
<?
$convert_qrcode_list=$data['Host']."/payme".$data['ex'].$jsr['noneEditableUrl'].$data['Host']."/payme".$data['ex'].$jsr['noneEditableUrl'];
?>
<span id="apic<?=$j;?>" class="hide"><?=urldecode($convert_qrcode_list);?></span>
			<a title="Your QR code"  href="https://quickchart.io/chart?chs=300x300&cht=qr&chl=<?=$convert_qrcode_list;?>&choe=UTF-8" class=" modal_from_url_qrcode" copyid="apic<?=$j;?>" style="width:40px;"><i class="<?=$data['fwicon']['qrcode'];?>"></i></a>
            <? } ?>
          </td>
        </tr>
        <tr class="hide">
          <td colspan="6">
		      <div class="next_tr_<?=prntext($value['id'])?> bg-dark hide">
              <div class="row">
                <? if(isset($value['rname'])&&$value['rname']){ ?>
                <div class="col-sm-6 px-2 card my-2 mboxtitle">Name Of The Receiver :
                  <?=$value['rname']?>
                </div>
                <? } ?>
                <? if(isset($value['remail'])&&$value['remail']){ ?>
                <div class="col-sm-6 px-2 card my-2">Receivers Email Address :
                  <?=$value['remail']?>
                </div>
                <? } ?>

                <? if(isset($value['amount'])&&$value['amount']){ ?>
                <div class="col-sm-6 px-2 card my-2">Amount Payable :
                  <?=$value['amount']?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_phone'])&&$jsr['bill_phone']){ ?>
                <div class="col-sm-6 px-2 card my-2">Subject :
                  <?=$jsr['email_subject'];?>
                </div>
                <? } ?>
                <? if(isset($value['comments'])&&$value['comments']){ ?>
                <div class="col-sm-6 px-2 card my-2">Description (Optional) :
                  <?=$value['comments']?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_phone'])&&$jsr['bill_phone']){ ?>
                <div class="col-sm-6 px-2 card my-2">Phone :
                  <?=$jsr['bill_phone'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_street_1'])&&$jsr['bill_street_1']){ ?>
                <div class="col-sm-6 px-2 card my-2">Street 1 :
                  <?=$jsr['bill_street_1'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_street_2'])&&$jsr['bill_street_2']){ ?>
                <div class="col-sm-6 px-2 card my-2">Street 2 :
                  <?=$jsr['bill_street_2'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_city'])&&$jsr['bill_city']){ ?>
                <div class="col-sm-6 px-2 card my-2">City :
                  <?=$jsr['bill_city'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_state'])&&$jsr['bill_state']){ ?>
                <div class="col-sm-6 px-2 card my-2">State :
                  <?=$jsr['bill_state'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_country'])&&$jsr['bill_country']){ ?>
                <div class="col-sm-6 px-2 card my-2">Country :
                  <?=$jsr['bill_country'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_zip'])&&$jsr['bill_zip']){ ?>
                <div class="col-sm-6 px-2 card my-2">Zip :
                  <?=$jsr['bill_zip'];?>
                </div>
                <? } ?>
                <div class="col-sm-6 px-2 card my-2">Status :
                  <?=$value['status']?>
                  <? if($value['transaction_id']){ ?>
                  | <a href="<?=$data['USER_FOLDER'];?>/transactions<?=$data['ex']?>?action=select&searchkey=<?=$value['transaction_id']?>&keyname=1&type=-1&status=-1"><?=$value['transaction_id']?></a>
                  <? } ?>
                </div>
                <? if(isset($jsr['noneEditableUrl'])&&$jsr['noneEditableUrl']){ ?>
                <div class="col-sm-12">None Editable - Pay URL
                  <div class="ro" style="float:none;display: inline-block;"> <span id="paymentsLinksId_nedt_<?=$j;?>"  class="hide"><?=$data['Host']?>/payme<?=$data['ex']?><?=$jsr['noneEditableUrl']?></span>
                    <button title="Copy to None Editable - Pay URL" type="button" class="btn  btn-primary btn-sm my-rpnsive-btn glyphicons more_windows my-2" onclick="ctcf('#paymentsLinksId_nedt_<?=$j;?>')"><i class="<?=$data['fwicon']['copy'];?>"></i></button>
                  </div>
                </div>
                <a class="col_2 card px-2 text-link"  target="_blank" href="<?=$data['Host']?>/payme<?=$data['ex']?><?=$jsr['noneEditableUrl']?>" ><?=$data['Host']?>/payme<?=$data['ex']?><?=$jsr['noneEditableUrl']?></a>
                <? } ?>
                <? if(isset($jsr['editableUrl'])&&$jsr['editableUrl']){ ?>
                <div class="col-sm-12">Editable - Pay URL
                  <div class="ro" style="float: none;display: inline-block;"> <span id="paymentsLinksId_edt_<?=$j;?>" class="hide"><?=$data['Host']?>/payme<?=$data['ex']?><?=$jsr['editableUrl']?></span>
                    <button title="Copy to Editable - Pay URL" type="button" class="btn btn-icon btn-primary btn-sm my-rpnsive-btn glyphicons more_windows my-2"  onclick="ctcf('#paymentsLinksId_edt_<?=$j;?>')" ><i class="<?=$data['fwicon']['copy'];?>"></i></button>
                  </div>
                </div>
                <a class="col_2 card px-2 text-link" target="_blank" href="<?=$data['Host']?>/payme<?=$data['ex']?><?=$jsr['editableUrl']?>" ><?=$data['Host']?>/payme<?=$data['ex']?><?=$jsr['editableUrl']?></a>
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
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
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
    <h4 class="heading glyphicons settings"><i></i>
      <?=$post['add_titileName'];?>
      Request Money</h4>
    <div class="row">
      <? $k=0; if($data['Store']&&$data['store_size']>1){ ?>
      <div class="col-sm-6 my-2 px-1">
        <select name="type" id="storeType" class="form-control " title="Select your website" data-bs-toggle="tooltip" data-bs-placement="bottom"  required>
          <option value="" disabled>Select Website</option>
          <?
				foreach($data['Store'] as $key=>$value){
			?>
          <option data-burl="<?=$value['bussiness_url'];?>" data-dba="<?=$value['dba_brand_name'];?>" data-val="<?=$value['api_token'];?>" value="<?=$value['api_token'];?>_;<?=$k;?>">
          <?=$value['name']?>
          </option>
          <? $k++; } ?>
        </select>
        <? if($post['type']){ ?>
        <script>
			$('#storeType option[data-val="<?=($post['type'])?>"]').prop("selected", "selected");
			$('#storeType option[data-val="<?=($post['type'])?>"]').attr("selected", "selected");
		</script>
        <? } ?>
      </div>
      <? } ?>
      <div class="col-sm-6 my-2 px-1">
        <input type="text" name="json_value[email_subject]" id="email_subject"  placeholder="Subject line for Email" class="form-control col-sm-6"  value1="<?="You have got a payment request from ". $post['dmn'] ." - " . $post['drvnum'];?>" value='<?=prntext($post['json_value']['email_subject'])?>' title="Enter subject line for email" data-bs-toggle="tooltip" data-bs-placement="bottom" required >
      </div>
      <? if(!isset($post['gid']) || !$post['gid']){
		//$post['json_value']=[];
	} ?>
      <div class="col-sm-6 my-2 px-1">
        <input type="email" name="remail"  placeholder="Enter the receivers email address" class="email_validate_input88 form-control" value="<?=(isset($post['remail'])?$post['remail']:'')?>" title="Enter the receivers email address" data-bs-toggle="tooltip" data-bs-placement="bottom" required autocomplete="off"  />
      </div>
      <div class="col-sm-6 my-2 px-1">
        <input type="number" step="00.01" name="amount"  placeholder="Enter the full amount ex. 10.00" class="form-control" value="<?=prntext(isset($post['amount'])?$post['amount']:'')?>" style="width:calc(100% - 60px);" title="Enter the full amount ex. 10.00" data-bs-toggle="tooltip" data-bs-placement="bottom" required  />
        <span style="width:60px;">
        <?=(isset($post['primary_currency'])?$post['primary_currency']:'');?>
        </span> </div>
      <div class="col-sm-6 my-2 px-1">
        <input type='text' name='fullname' placeholder="full name of the receiver" class="validate_input_firstname form-control" value="<?=prntext(isset($post['fullname'])?$post['fullname']:'')?>" title="Enter full name of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" required />
      </div>
      <?php

if(!isset($post['json_value']['bill_phone']))		$post['json_value']['bill_phone']	= "";
if(!isset($post['json_value']['bill_street_1']))	$post['json_value']['bill_street_1']= "";
if(!isset($post['json_value']['bill_street_2']))	$post['json_value']['bill_street_2']= "";
if(!isset($post['json_value']['bill_city']))		$post['json_value']['bill_city']	= "";
if(!isset($post['json_value']['bill_state']))		$post['json_value']['bill_state']	= "";
if(!isset($post['json_value']['bill_country']))		$post['json_value']['bill_country']	= "";
if(!isset($post['json_value']['bill_zip']))			$post['json_value']['bill_zip']		= "";
if(!isset($post['json_value']['encryption_types']))	$post['json_value']['encryption_types']= "";

if(!isset($post['user_type']))	$post['user_type']= "";

?>
      <div class="col-sm-6 my-2 px-1">
        <input type='text' name='json_value[bill_phone]' placeholder="Phone of the receiver" class="validate_input_firstname form-control" value='<?=prntext($post['json_value']['bill_phone'])?>' title="Enter phone of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
      </div>
      <? if($data['clkStore']==0){
	 $style_display=''; 
 }
 else{
	$style_display='display:none;';
 }
 ?>
      <div class="col-sm-6 my-2 px-1"  style='<?=$style_display;?>'>
        <input type='text' name='json_value[bill_street_1]' placeholder="Street 1 of the receiver" class="validate_input_firstname form-control" value='<?=prntext($post['json_value']['bill_street_1'])?> <?=$na;?>' style='<?=$style_display;?>' title="Enter street 1 of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
      </div>
      <div class="col-sm-6 my-2 px-1"  style='<?=$style_display;?>'>
        <input type='text' name='json_value[bill_street_2]' placeholder="Street 2 of the receiver" class="validate_input_firstname form-control" value="<?=prntext($post['json_value']['bill_street_2'])?> <?=$na;?>" style='<?=$style_display;?>' title="Enter street 2 of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
      </div>
      <div class="col-sm-6 my-2 px-1"  style='<?=$style_display;?>'>
        <input type='text' name='json_value[bill_city]' placeholder="City of the receiver" class="validate_input_firstname form-control" value="<?=prntext($post['json_value']['bill_city'])?> <?=$na;?>" style='<?=$style_display;?>' title="Enter city of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
      </div>
      <div class="col-sm-6 my-2 px-1"  style='<?=$style_display;?>'>
        <input type='text' name='json_value[bill_state]' placeholder="State of the receiver" class="validate_input_firstname form-control" value="<?=prntext($post['json_value']['bill_state'])?> <?=$na;?>" style='<?=$style_display;?>' title="Enter state of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
      </div>
      <div class="col-sm-6 my-2 px-1"  style='<?=$style_display;?>'>
        <input type='text' name='json_value[bill_country]' placeholder="Country of the receiver" class="validate_input_firstname form-control" value="<?=prntext($post['json_value']['bill_country'])?> <?=$na;?>" style='<?=$style_display;?>' title="Enter country of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
      </div>
      <div class="col-sm-6 my-2 px-1"  style='<?=$style_display;?>'>
        <input type='text' name='json_value[bill_zip]' placeholder="Zip code of The Receiver" class="validate_input_firstname form-control" value="<?=prntext($post['json_value']['bill_zip'])?> <?=$na;?>" style='<?=$style_display;?>' title="Enter zip code of the receiver" data-bs-toggle="tooltip" data-bs-placement="bottom" />
      </div>
      <div class="col-sm-12 my-2 px-1">
        <textarea id="mustHaveId" class="form-control" name="comments" rows="5" placeholder="Enter a message for the receiver." title="Enter a message for the receiver." data-bs-toggle="tooltip" data-bs-placement="bottom"><?=prntext(isset($post['comments'])?$post['comments']:'')?></textarea>
      </div>
      <div class="radios col-sm-12 px-1" style="margin:5px 0 10px 0;">
        <input type="radio" name="json_value[encryption_types]" id="NoneEditable"  value="1" <? if($post['json_value']['encryption_types']==1||$post['json_value']['encryption_types']==''){echo "checked";} ?> />
        <label for="NoneEditable" style="float:none;text-align:left;width:auto;"><b>None Editable</b></label>
        <input type="radio" name="json_value[encryption_types]" id="Editable"  value="2" <? if(($post['json_value']['encryption_types']==2)||(empty($post['user_type']))){echo "checked";} ?> />
        <label for="Editable" style="float:none;text-align:left;width:auto;"><b>Editable</b></label>
      </div>
      <div class="col-sm-12 my-2 text-center">
        <button type="submit" name="send" value="CONTINUE" class="btn btn-icon btn-primary mx-1"><i class="<?=$data['fwicon']['verified'];?>"></i> Submit</button><a href="<?=$data['urlpath']?>" class="btn btn-icon btn-primary mx-1" ><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
      <? } ?>
    </div>
  </form>
</div>
<!--Js for qr code generation-->
<script>
$('.modal_from_url_qrcode').on('click', function(e){
      e.preventDefault();
	  var imghref= $(this).attr('href');
	  var copyid= $(this).attr('copyid');
	  var fnforcopy="ctcf('#" + copyid + "')";
	  
	  $('#converturltoQrcode').modal('show');
	  $('#qrimgvid').attr('src', imghref );
	  $('#qr_link_footer').val(imghref);
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
	  <div class="bg-vlight border rounded p-4"><img id="qrimgvid" src="#" title="Payment Link" /></div>
  	  <div class="my-2 btn btn-primary w-500" id="qrcopycode" onclick="ctcf('#apic')"><i class="<?=$data['fwicon']['copy'];?>" title="Copy Payment Link"></i></div>
	  
	  <a class="my-2 btn btn-primary w-500" data-bs-toggle="collapse" href="#collapseShareDiv" role="button" aria-expanded="false" aria-controls="collapseShareDiv"><i class="<?=$data['fwicon']['share'];?>" title="Share Payment Link"></i></a>
	  <div class="collapse border rounded p-2 text-vlight" id="collapseShareDiv">
    <form action="<?=$data['Host']?>/user/requests<?=$data['ex']?>" method="post">
	<input type="hidden" name="qrid" id="qrid_footer" value="<?=$_SESSION['uid']?>" />
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
