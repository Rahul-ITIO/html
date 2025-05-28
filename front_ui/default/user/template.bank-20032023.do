<? if(isset($data['ScriptLoaded'])){
$nodal_acc_bank=0; $nodal_acc_coins=0;
if(isset($data['DEFAULT_NODAL'])&&($data['DEFAULT_NODAL']==1 || $data['DEFAULT_NODAL']==3)){
	$nodal_acc_bank=1;
}

if(isset($data['DEFAULT_NODAL'])&&($data['DEFAULT_NODAL']==2 || $data['DEFAULT_NODAL']==3)){
	$nodal_acc_coins=1;
}
?>

<?php /*?> js Function for check Swift Code Avaibility <?php */?>
<script>
function checkAvailability() {
	$("#loaderIcon").show();
	$.ajax({
	url: "<?=$data['Host'];?>/include/check_availability<?=$data['ex']?>",
	data:'tbl=swift_code&bswift='+$("#bswift").val(),
	type: "POST",
	success:function(data){
	//alert(data);
	var obj = JSON.parse(data);
	//alert(obj.valid);
	//alert(obj.bank);
	//alert(obj.city);
	//alert(obj.branch);
	//alert(obj.country);
	
	
	if(obj.valid==1){
	 //alert("Valid Swift Code");
	 document.getElementById('bname').value = obj.bank;
	 document.getElementById('baddress').value = obj.branch + " "+ obj.city + " , "+ obj.country;
	 $('#swiftmsg').attr('class','col-sm-12 px-1 alert alert-success');
	 //$('#basicidx i').prop('title', 'Valid Swift Code');
	 document.getElementById('swiftmsg').innerHTML=" <i class='ps-3 m-0 <?=$data['fwicon']['check-circle'];?> text-success'></i> SWIFT Code Verified ";
	}else{
	//alert("Inalid Swift Code");
	$('#swiftmsg').attr('class','col-sm-12 px-1 alert alert-danger');
	//$('#basicidx i').prop('title', 'Invalid Swift Code');
	document.getElementById('swiftmsg').innerHTML=" <i class='ps-3 m-0 <?=$data['fwicon']['check-cross'];?> text-danger'></i> We are unable to verify this SWIFT number via our Bank Directory. Click Okay and proceed if your SWIFT details is correct ";
	}
	
		$("#swift_code_status").html(data);
		$("#loaderIcon").hide();
	},
	error:function (){}
	});
}

function getXMLHttp()
{
  var xmlHttp

  try
  {
    //Firefox, Opera 8.0+, Safari
    xmlHttp = new XMLHttpRequest();
  }
  catch(e)
  {
    //Internet Explorer
    try
    {
      xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch(e)
    {
      try
      {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      catch(e)
      {
        alert("Your browser does not support AJAX!")
        return false;
      }
    }
  }
  return xmlHttp;
}

function MakeRequest()
{


	 
  var swcode=document.getElementById('bswift').value;
//alert(swcode);  
  if (swcode=='')
  {
  	alert ("<?=$post['swift_con'];?> Code is empty");
	return false;
	exit;
  }
  
 document.getElementById('swiftmsg').innerHTML="";
 //document.getElementById('baddress').value='';
 //document.getElementById('bname').value='';
 
 //document.getElementById('bcity').value='';
 //document.getElementById('bzip').value='';
 //document.getElementById('bcountry').value='';
 document.getElementById('swiftmsgbutton').style.display="none";
 document.getElementById('swiftmsgbuttonright').style.display="none";
 document.getElementById('swiftmsgloader').style.display="block";
  
  var xmlHttp = getXMLHttp();
  
  xmlHttp.onreadystatechange = function()
  {
    
    if(xmlHttp.readyState == 4)
    {
      HandleResponse(xmlHttp.responseText);
    }
  }
  
  //alert("url");
  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?txt="+swcode, true); 
  //xmlHttp.open("GET", "/ztswallet/include/ajax<?=$data['ex']?>?txt="+swcode, true); 
  xmlHttp.send(null);
}


function HandleResponse(response)
{
	//alert(response);
	var obj = JSON.parse(response);
	
	if (obj.valid=="true")
	{	
	//assign values to inboxes
	document.getElementById('bname').value = obj.bank;
	
	var badd='';
	
	if (obj.branch!=null){badd=obj.branch;}
	
	if (obj.address!=null){	
		if (badd!=""){badd=badd+", "+obj.address;}else{badd=badd+obj.address;}
	}
	badd = badd.replace(", , ", ", ");
	if (obj.city!=null){
		if (badd!=""){badd=badd+", "+obj.city;}else{badd=badd+obj.city;}
	}
	badd = badd.replace(", , ", ", ");
	if (obj.postcode!=null){
		if (badd!=""){badd=badd+", "+obj.postcode;}else{badd=badd+obj.postcode;}
	}
	badd = badd.replace(", , ", ", ");
	if (obj.country!=null){
		if (badd!=""){badd=badd+", "+obj.country;}else{badd=badd+obj.country;}
	}
	
	badd = badd.replace(", , ", ", ");
	 
	document.getElementById('baddress').value =badd;	
	
	document.getElementById('bcity').value = obj.city;
	document.getElementById('bzip').value = obj.postcode;
	document.getElementById('bcountry').value = obj.countrycode;
	document.getElementById('swiftmsgbuttonright').style.display="block";
	document.getElementById('swiftmsgloader').style.display="none";
	}
	else 
	{
  	
	document.getElementById('swiftmsg').style.display="block";	
	document.getElementById('swiftmsgbutton').style.display="block";
	document.getElementById('swiftmsgloader').style.display="none";
	document.getElementById('swiftmsg').innerHTML = obj.message+" - Error Code="+obj.error;
	}

}//end function



function CloseDiv()
{
	document.getElementById('swiftmsg').style.display="none";
	document.getElementById('swiftmsgbutton').style.display="none";
	document.getElementById('swiftmsgbuttonright').style.display="none";
}

<!--Intermediate Request -->
function IntMdtMakeRequest()
{
	 
  var swcode=document.getElementById('intermediary').value;
  
  if (swcode=='')
  {
  	alert ("<?=$post['swift_con'];?> Code is empty");
	return false;
	exit;
  }
  
 document.getElementById('IntMdtswiftmsg').innerHTML="";
 document.getElementById('intermediary_bank_address').value='';
 document.getElementById('intermediary_bank_name').value='';
 
 
 document.getElementById('IntMdtswiftmsgbutton').style.display="none";
 document.getElementById('IntMdtswiftmsgbuttonright').style.display="none";
 document.getElementById('IntMdtswiftmsgloader').style.display="block";
  
  var xmlHttp = getXMLHttp();
  
  xmlHttp.onreadystatechange = function()
  {
    if(xmlHttp.readyState == 4)
    {
      IntMdtHandleResponse(xmlHttp.responseText);
    }
  }

  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?txt="+swcode, true); 
  ///xmlHttp.open("GET", "/ztswallet/include/ajax<?=$data['ex']?>?txt="+swcode, true); 
  xmlHttp.send(null);
}

function IntMdtHandleResponse(response){

	var obj = JSON.parse(response);
	
	if (obj.valid=="true")
	{	
	//assign values to inboxes
	var badd='';
	
	if (obj.branch!=null){badd=obj.branch;}
	
	if (obj.address!=null){	
		if (badd!=""){badd=badd+", "+obj.address;}else{badd=badd+obj.address;}
	}
	badd = badd.replace(", , ", ", ");
	if (obj.city!=null){
		if (badd!=""){badd=badd+", "+obj.city;}else{badd=badd+obj.city;}
	}
	badd = badd.replace(", , ", ", ");
	if (obj.postcode!=null){
		if (badd!=""){badd=badd+", "+obj.postcode;}else{badd=badd+obj.postcode;}
	}
	badd = badd.replace(", , ", ", ");
	if (obj.country!=null){
		if (badd!=""){badd=badd+", "+obj.country;}else{badd=badd+obj.country;}
	}
	
	badd = badd.replace(", , ", ", ");
	
	document.getElementById('IntMdtswiftmsgloader').style.display="none";
  //assign values to inboxes
  document.getElementById('intermediary_bank_name').value = obj.bank;
  document.getElementById('intermediary_bank_address').value =badd;
  document.getElementById('IntMdtswiftmsgbuttonright').style.display="block";
  }else{
  	
	document.getElementById('IntMdtswiftmsg').style.display="block";	
	document.getElementById('IntMdtswiftmsgbutton').style.display="block";
	document.getElementById('IntMdtswiftmsgloader').style.display="none";
	document.getElementById('IntMdtswiftmsg').innerHTML = response;
  }

}

function IntMdtHandleResponse_onhold(response)
{
 
  var c = response.indexOf("branch=");
  if (c>-1)
  {
	//Get Bank name
	var sp = response.indexOf("branch=");
	var bank = response.substr(0, sp); 
	
	//Get branch name
	var bp = response.indexOf("branch=");
	var cp = response.indexOf("address=");
	var bp1=bp+7;
	var bp2=cp-bp-7;
	var branch = response.substr(bp1, bp2); 
	
	
	//Get address name
	bp = response.indexOf("address=");
	cp = response.indexOf("city=");
	bp1=bp+8;
	bp2=cp-bp-8;
	var address = response.substr(bp1, bp2); 
	
	
	//Get city name
	bp = response.indexOf("city=");
	cp = response.indexOf("postcode=");
	bp1=bp+5;
	bp2=cp-bp-5;
	var city = response.substr(bp1, bp2);
	
	//Get postcode name
	bp = response.indexOf("postcode=");
	cp = response.indexOf("country=");
	bp1=bp+9;
	bp2=cp-bp-9;
	var postcode = response.substr(bp1, bp2);
	
	
	//Get country name
	bp = response.indexOf("country=");
	cp = response.indexOf("countrycode=");
	bp1=bp+9;
	bp2=cp-bp-9;
	var country = response.substr(bp1, bp2);
	
	
	//Get countrycode name
	bp = response.indexOf("countrycode=");
	cp = response.indexOf(")*");
	bp1=bp+12;
	bp2=cp-bp-12;
	var countrycode = response.substr(bp1, bp2);
		
		var cadd=branch+', '+address;
		if (city!=''){cadd=cadd+", "+city;}
		if (city!=''){cadd=cadd+", "+city;}
		if (postcode!=''){cadd=cadd+"-"+postcode;}
		if (country!=''){cadd=cadd+", "+country;}
		if (countrycode!=''){cadd=cadd+"("+countrycode+")";}
	
  document.getElementById('IntMdtswiftmsgloader').style.display="none";
  //assign values to inboxes
  document.getElementById('intermediary_bank_name').value = bank;
  document.getElementById('intermediary_bank_address').value =cadd;
  document.getElementById('IntMdtswiftmsgbuttonright').style.display="block";
  }
  else 
  {
  	
	document.getElementById('IntMdtswiftmsg').style.display="block";	
	document.getElementById('IntMdtswiftmsgbutton').style.display="block";
	document.getElementById('IntMdtswiftmsgloader').style.display="none";
	document.getElementById('IntMdtswiftmsg').innerHTML = response;
  }
}


function IntMdtCloseDiv()
{
	document.getElementById('IntMdtswiftmsg').style.display="none";
	document.getElementById('IntMdtswiftmsgbutton').style.display="none";
	document.getElementById('IntMdtswiftmsgbuttonright').style.display="none";
}
<!-- End Intermediate request -->

function BankDocHandleResponse(response){
document.getElementById('show_img').innerHTML = response;
}// End function

function BankDocHandleResponse_multiple(response,id){
document.getElementById('show_img_'+id).innerHTML = response;
}// End function

function show_image(){  
 document.getElementById('show_img').innerHTML="";
 var xmlHttp = getXMLHttp();  
  xmlHttp.onreadystatechange = function()
  {
    if(xmlHttp.readyState == 4)
    {
      BankDocHandleResponse(xmlHttp.responseText);
    }
  }
  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?gid=<?=((isset($post['gid']) &&$post['gid'])?$post['gid']:'')?>&type=bankdoc", true); 
  xmlHttp.send(null);
}// End Function
//Show bank image at details page
function show_bank_image(id){  
 //document.getElementById('show_img').innerHTML="";
 
 
 var xmlHttp = getXMLHttp();  
  xmlHttp.onreadystatechange = function()
  {
    if(xmlHttp.readyState == 4)
    {
      BankDocHandleResponse_multiple(xmlHttp.responseText,id);
    }
  }
  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?gid="+id+"&type=bankdoc", true); 
  xmlHttp.send(null);
}// End Function


function myConfirm(theValue,theUrl) {
  var result = confirm(theValue);
  if (result==true) {
	  window.location.href=theUrl;
   return true;
  } else {
   return false;
  }
}

function verifyAmountFunction(gid) {

  var amount = prompt("Please enter amount", "");
  if (amount != null) {
  	window.location.href='<?="{$data['Members']}/bank".$data['ex'];?>?action=verify_account&gid='+gid+'&amount='+amount;
	}
}


</script>
<script>
 $(document).ready(function(){	
 
	
	$("input[type='radio'].bType").click(function(){
		$("input[name='bank']").prop('checked', false);
		if($(this).is(':checked')) {
			if($(this).val() == 'CryptoCurrency') {
				$("input[value='crypto']").trigger('click');
				$("#bank_caption").html('Add A New Crypto Wallet');
				$('.main_heading_type').hide();
				$('#typeBank').slideUp(500); $('#typeCrypto').slideDown(1000);
			}else{ 
			    $("#bank_caption").html('Add A New Bank Account');
				$('.main_heading_type').hide();
				$('#typeBank').show(1000); $('#typeCrypto').hide(500);
				
			}
		}
	});	
	
// Function for display bank / crypto form from click on  bank type box Click  Added on 16122022 by vikashs
	$(".bTypebox").click(function(){
	var boxval=$(this).attr("boxval");

			if(boxval == 'CryptoCurrency') {
				$("input[value='crypto']").trigger('click');
				$("#bank_caption").html('Add A New Crypto Wallet');
				$('.main_heading_type').hide();
				$('#CryptoCurrency_id').prop( "checked", true );
				$('#typeBank').slideUp(500); $('#typeCrypto').slideDown(1000);
			}else{ 
			    $("#bank_caption").html('Add A New Bank Account');
				$('.main_heading_type').hide();
				$('#bankType_id').prop( "checked", true );
				$('#typeBank').show(1000); $('#typeCrypto').hide(500);
				
			}
		//}
	});
	$(".ChangeBankType").click(function(){
	$('.main_heading_type').show();
	$('#typeBank').hide(500); 
    $('#typeCrypto').hide(500);
	$('#bankType_id').prop( "checked", false );
	$('#CryptoCurrency_id').prop( "checked", false );
	});
	
	<? if(isset($post['action'])&&$post['action']=='addCryptoWallet'){?>
		$("#CryptoCurrency_id").eq(0).trigger("click");
	<? }elseif(isset($post['action'])&&$post['action']=='addNewBank'){?>
		$("#bankType_id").eq(0).trigger("click");
	<? } ?>
	
	<? if($data['con_name']=='clk'){ ?>
		$("#bankType_id").prop('checked', true).trigger('click');
	<? } ?>	
});
 </script>
<div id="zink_id" class="container mt-2 mb-2 rounded border bg-primary">
  <? if(isset($_SESSION["query_insert_status"])&&$_SESSION["query_insert_status"]){ ?>
  <div class="alert alert-success alert-dismissible fade show mt-2" role="alert"> <strong>Success!</strong> Your Banking Information Has Been Added.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <? unset($_SESSION["query_insert_status"]); } 
  
  include_once $data['Path']."/include/message".$data['iex'];
  ?>
  <form id="form1" method="post" name="data" enctype="multipart/form-data">
    <input type="hidden" name="step" value="<?=$post['step']?>">
    <? if($post['step']==1){ ?>
    <? if(isset($_SESSION['query_status'])&&$_SESSION['query_status']){ ?>
    <div class="alert alert-success alert-dismissible fade show mt-2" role="alert"> <strong>Success!</strong> Your Banking Information Has Been Updated.
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? unset($_SESSION["query_status"]); } ?>
    <div class="vkg my-2">
      <h4 class="float-start"><i class="<?=$data['fwicon']['bank'];?>"></i> My Bank Accounts
        <!-- (
        <?=$data['b_result_count'];?>
        )-->
      </h4>
    </div>
    <div class="bank_account text-end my-2">
      <button type="submit" name="send" value="Add New Bank Account!" class="btn btn-sm btn-primary" title="Add A New Bank Account"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> </button>
    </div>
    <div class="table-responsive-sm my-2">
      <table class="table table-hover bg-primary text-white">
  
        <? if((count($data['Banks'])!=0) || (count($data['Crypto'])!=0)) { ?>
        <thead>
          <tr>
		    <th scope="col">#</th>
            <th scope="col"><span title="A/C Holder Name / Wallet Provider" data-bs-toggle="tooltip" data-bs-placement="top">A/C Holder Name..</span></th>
            <th scope="col"><span title="A/C Number / Crypto Address" data-bs-toggle="tooltip" data-bs-placement="top">A/C Number..</span></th>
            <th scope="col">Bank Name</strong></th>
            <th scope="col" class="hide-768">Currency</th>
            <th scope="col" class="hide-768">Document</th>
            <th scope="col">&nbsp;</th>
          </tr>
        </thead>
        <? }else{ ?>
        <thead>
         <tr>
          <th scope="col">
            <div class="my-2 ms-2 fs-5 text-start">Add your bank to receive payments</div>
            <div class="text-start my-2 ms-2" style="max-width:400px !important;"> Transfer of funds to your bank account.</div>
            <button type="submit" name="send" value="Add New Bank Account!" class="btn btn-primary my-2 ms-2 float-start" title="Add A New Bank Account"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add A New Bank Account</button>
          </th>
         </tr>
        </thead>
        <? } ?>
		
		
        <? $idx=1;foreach($data['Banks'] as $value){
		   
			if(isset($value['bname'])&&$value['bname']=='Crypto Wallet'){
			$crypto_wallet=1; $iconAcc='crypto'; $iconcurr="<i class='".$data['fwicon']['bitcoin']." text-warning'></i>";
			}else{$crypto_wallet=0; $iconAcc='bank'; $iconcurr="<i class='".$data['fwicon']['bank']." text-danger'></i>";}	
	
    ?>
        <!--//////// Detail Modal //////-->
		
        <tr valign="top" class="<?=($iconAcc);?>">
		<th scope="row"><div class="content"><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> data_display text-link" title="View bank details"></i></a></div></th>
          <td><div title="<? if($crypto_wallet==1){?> <?=prntext($value['baddress'])?><? }else{?> <?=prntext($value['bnameacc'])?><? }?>" data-bs-toggle="tooltip" data-bs-placement="bottom"  class="short_display_on_mobile"><? if($crypto_wallet==1){?> <?=prntext($value['baddress'])?><? }else{?> <?=prntext($value['bnameacc'])?><? }?></div></td>
          <td><div title="<?=decrypts_string($value['baccount'],1,2,4);?>" data-bs-toggle="tooltip" data-bs-placement="bottom"  class="short_display_on_mobile"><?=decrypts_string($value['baccount'],1,2,4);?></div></td>
                  
          <td data-count="<?=prntext($value['id'])?>" class="bank_details_col" data-label="&nbsp;Bank Name"><div title="<?=prntext($value['bname'])?>" data-bs-toggle="tooltip" data-bs-placement="bottom"  class="short_display_on_mobile"><?=prntext($value['bname'])?></div>
		  </td>
          <td class="hide-768"><?=prntext($value['required_currency'])?></td>
          <td class="hide-768"><? $pro_img=display_docfile("../user_doc/",$value['bank_doc']);?></td>
          
          <td align="center">
              <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action" ><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
                  <? if(isset($value['bank_account_primary'])&&$value['bank_account_primary']){?>
                  <li> <a class="dropdown-item primary alnk" title="Bank Account Primary"><i class="<?=$data['fwicon']['primary'];?> text-success float-start" title="Primary"></i> <span class="action_menu">Primary</span></a></li>
                  <? }else{?>
				 <li> <a class="dropdown-item  primaryto alnk nopopup" title="Set To Bank Account Primary" onclick="myConfirm('Do you want to set this as your primary bank account : <?=prntext($value['bname'])?>','<?=$data['Members']?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=bank_account_primary');" ><i class="<?=$data['fwicon']['primary'];?> text-info float-start" title="Set To Primary"></i> <span class="action_menu">Set To Primary</span></a></li>
				  
				  <? } ?>
				  
                  <? if($value['primary']=="2"){?>
 
                  <li> <a class="dropdown-item verified " href="<?=$data['Members']?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Verified of This Account"><i class="<?=$data['fwicon']['lock'];?> text-success float-start" title="Verified"></i> <span class="action_menu">Verified</span></a></li>
                  <? }else{

            		if(isset($nodal_acc_bank)&&$nodal_acc_bank){
            			
            			if(isset($value['verify_status'])&&$value['verify_status']=='0' && isset($data['total_verify'])&&$data['total_verify']<2){ ?>
                  <li> <a class="dropdown-item " onclick="myConfirm('Are you sure to send account verification request? : <?=decrypts_string($value['baccount'])?>','<?=$data['Members']?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=sent_verification_amt&tname=bank');"  title="Self Verify"><i class="<?=$data['fwicon']['user-cross'];?> text-danger float-start" title="Self Verify"></i> <span class="action_menu">Self Verify</span></a></li>
                  <? } elseif(isset($value['verify_status'])&&$value['verify_status']=='2')
            			echo '<a class="" title="Verify Amount" onclick="verifyAmountFunction('.$value['id'].',\'banks\')"><i class="'.$data['fwicon']['coins'].' text-warning float-start"></i> <span class="action_menu">Verify Amount</span></a>';
            				
            		}
            		?>

                  <li> <a class="dropdown-item " href="<?=$data['Members']?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit"><i class="<?=$data['fwicon']['edit'];?> text-success float-start"></i> <span class="action_menu">Edit</span></a></li>
                  <? }?>
                  <li> <a class="dropdown-item remove" href="<?=$data['Members']?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=delete" onclick="return confirm('Do you want to delete');" title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger float-start float-start"></i> <span class="action_menu">Delete</span></a></li>
                </ul>
              </div>
           </td>
        </tr>
        <tr class="hide">
          <td colspan="6">
		      <div class="next_tr_<?=prntext($value['id'])?> hide">
              <div class="row">
                <? if($value['bname']){ ?>
                <div class="col-sm-12"><strong>Bank Name:</strong> <span class="mboxtitle">
                  <?=prntext($value['bname'])?>
                  </span></div>
                <? }if($value['baddress']){ ?>
                <div class="col-sm-12"><strong>Bank Address:</strong>
                  <?=prntext($value['baddress'])?>
                </div>
                <? }if($value['bcity']){ ?>
                <div class="col-sm-12"><strong>Bank City:</strong>
                  <?=prntext($value['bcity'])?>
                </div>
                <? }if($value['bzip']){ ?>
                <div class="col-sm-12"><strong>Bank ZIP Code:</strong>
                  <?=prntext($value['bzip'])?>
                </div>
                <? }if($value['bcountry']){ ?>
                <div class="col-sm-12"><strong>Bank Country:</strong>
                  <?=prntext($data['Countries'][$value['bcountry']])?>
                </div>
                <? }if($value['bstate']){ ?>
                <div class="col-sm-12"><strong>Bank State:</strong>
                  <?=prntext($value['bstate'])?>
                </div>
                <? }if($value['bphone']){ ?>
                <div class="col-sm-12"><strong>Bank Phone:</strong>
                  <?=prntext($value['bphone'])?>
                </div>
                <? }if($value['bnameacc']){ ?>
                <div class="col-sm-12"><strong>Name:</strong>
                  <?=prntext($value['bnameacc'])?>
                </div>
                <? }if($value['full_address']){ ?>
                <div class="col-sm-12"><strong>Full Address:</strong>
                  <?=prntext($value['full_address'])?>
                </div>
                <? }if($value['baccount']){ ?>
                <div class="col-sm-12"><strong>Account Number:</strong> <span style="font-size:18px;">
                  <?=decrypts_string($value['baccount']);?>
                  </span></div>
                <? }if($value['btype']){ ?>
                <div class="col-sm-12"><strong>Account Type:</strong>
                  <?=prntext($data['BankAccountType'][$value['btype']])?>
                </div>
                <? }if($value['required_currency']){ ?>
                <div class="col-sm-12 input required_currency_bank"><strong>Requested Currency:</strong>
                  <?=prntext($value['required_currency'])?>
                </div>
                <? }if($value['brtgnum']){ ?>
                <div class="col-sm-12"><strong>9 Digits Routing Number:</strong>
                  <?=prntext($value['brtgnum'])?>
                </div>
                <? }if($value['bswift']){ ?>
                <div class="col-sm-12"><strong>S.W.I.F.T. Code:</strong>
                  <?=prntext($value['bswift'])?>
                </div>
                <? } ?>
              </div>
              </div>
		  </td>
        </tr>
		
        <? $idx++;} ?>
        <? foreach($data['Crypto'] as $value){ //START COIN WALLET SECTION
		$crypto_wallet=1; 
		$iconAcc='crypto'; 
        $bgcolor=$idx%2?'#FFFFFF':'#E7E7E7';
		$iconAcc='crypto'; $iconcurr="<i class='".$data['fwicon']['bitcoin']." text-warning'></i>"; 
		?>
        <!--//////// Detail Modal //////-->
        <tr class="<?=($iconAcc);?>">
		<th scope="row"><div class="content66"><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> data_display text-link" title="View crypto details "></i></a></div></th>
          <td data-count="<?=prntext($value['id'])?>" class="text-start"  data-label="&nbsp;Wallet Provider">
            <div title="<?=ucwords(prntext($value['coins_wallet_provider']))?>" data-bs-toggle="tooltip" data-bs-placement="bottom"  class="short_display_on_mobile"><?=ucwords(prntext($value['coins_wallet_provider']))?></div>
          </td>
          <td><div title="<?=decrypts_string($value['coins_address']);?>" data-bs-toggle="tooltip" data-bs-placement="bottom"  class="short_display_on_mobile"><?=decrypts_string($value['coins_address']);?></div></td>
          <td><div title="<?=prntext($value['coins_name']);?>" data-bs-toggle="tooltip" data-bs-placement="bottom"  class="short_display_on_mobile"><?=prntext($value['coins_name']);?></div>
          </td>
          <td class="hide-768"><?=prntext($value['required_currency'])?></td>
          <td class="hide-768"><? $pro_img=display_docfile("../user_doc/",$value['bank_doc']);?></td>
          <td align="center"><div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action" ><i class="<?=$data['fwicon']['action'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
                  <? if($value['bank_account_primary']){?>
                  <li> <a class="dropdown-item green primary alnk"><i class="<?=$data['fwicon']['primary'];?> text-success float-start" title="Primary"></i> <span class="action_menu">Primary</span></a></li>
                  <? } ?>
                  <? 
		    if($value['primary']=="2"){
			if(!$value['bank_account_primary'])
			{
			?>
                  <li> <a class="dropdown-item  glyphicons star red primaryto alnk nopopup" title="Set To wallet Account Primary" onclick="myConfirm('Do you want to set this as your primary wallet account : <?=decrypts_string($value['coins_address'])?>','<?=$data['Members']?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=crypto_wallet_primary');" ><i class="<?=$data['fwicon']['primary'];?> text-info float-start" title="Set To Primary"></i> <span class="action_menu">Set To Primary</span></a></li>
                  <?
			}
			?>
                  <li> <a class="dropdown-item  green verified" href="<?=$data['Members']?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=update&insertType=Crypto Wallet"  title="Verified of This wallet Account"><i class="<?=$data['fwicon']['lock'];?> text-success float-start" title="Verified"></i> <span class="action_menu">Verified</span></a></li>
                  <?  }else{ if(isset($value['verify_status'])&&$value['verify_status']=='0' && isset($data['total_verify'])&&$data['total_verify']<2){
			?>
                  <li> <a class="dropdown-item " onclick="myConfirm('Are you sure to send account verification request? : <?=encode((isset($value['baccount'])&&$value['baccount'])?$value['baccount']:'',4)?>','<?=$data['Members']?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=sent_verification_amt&tname=bank');" title="Verify"><i class="<?=$data['fwicon']['user-cross'];?> text-danger float-start" title="Self Verify"></i> <span class="action_menu">Self Verify</span></a></li>
                  <?
			}
			elseif(isset($value['verify_status'])&&$value['verify_status']=='2')
				echo '<a onclick="verifyAmountFunction('.$value['id'].',\'banks\')"><b>Verify Amount</b></a>';
		?>
                  <?php /*?><li> <span class="dropdown-item "><i class="<?=$data['fwicon']['unlock'];?> text-danger"></i>!</span></li><?php */?>
                  <li> <a class="dropdown-item " href="<?=$data['Members']?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=update&insertType=Crypto Wallet"
		 title="Edit" ><i class="<?=$data['fwicon']['edit'];?> text-success float-start"></i> <span class="action_menu">Edit</span></a></li>
                  <li> <a class="dropdown-item " href="<?=$data['Members']?>/bank<?=$data['ex']?>?id=<?=$value['id']?>&action=deleteCrypto" onclick="return confirm('Do you want to delete');" title="Delete"><i class="<?=$data['fwicon']['delete'];?> text-danger float-start"></i> <span class="action_menu">Delete</span></a></li>
                  <? 
		}?>
                </ul>
              </div></td>
          </tr>
        <tr class="hide">
          <td colspan="6"><div class="next_tr_<?=prntext($value['id'])?> hide">
              
              <div class="hide required_currency_bank" >
                <?=prntext($value['required_currency'])?>
              </div>
              <div class="row">
                <? if($value['coins_name']){ ?>
                <div class="col-sm-12"><strong>Coins:</strong> <b class="mboxtitle">
                  <?=prntext($value['coins_name'])?>
                  </b></div>
                <? }if($value['coins_network']){ ?>
                <div class="col-sm-12"><strong>Network: </strong>
                  <?=prntext($value['coins_network'])?>
                </div>
                <? }if($value['coins_address']){ ?>
                <div class="col-sm-12"><strong>Address:</strong>
                  <?=decrypts_string($value['coins_address']);?>
                </div>
                <? }if($value['coins_wallet_provider']){ ?>
                <div class="col-sm-12"><strong>Wallet Provider:</strong>
                  <?=prntext($value['coins_wallet_provider'])?>
                </div>
                <? }if($value['withdrawFee']){ ?>
                <div class="col-sm-12"><strong>Withdraw Fee:</strong>
                  <? if(isset($value['withdrawFee'])) echo prntext($value['withdrawFee'])?>
                  %
                  <? if(isset($post['ab']['account_curr'])) echo prntext($post['ab']['account_curr'])?>
                </div>
                <? } ?>
              </div>
             
            </div></td>
        </tr>
        <? $idx++;} ?>
      </table>
    </div>
    <? }elseif($post['step']==2){ ?>
    <? $_SESSION['bank_primary']=(isset($post['primary'])&&$post['primary'])?$post['primary']:'';?>
    <? $ep=""; if($_SESSION['bank_primary']=="2"){
	$ep="disabled='disabled'";
?>
    <? } ?>
    <?
$buttonname="Add";
$h4text="Add A New Bank Account";
$change_btn='<i title="Change Bank Type" class="'.$data['fwicon']['edit'].' ChangeBankType" data-bs-toggle="tooltip" data-bs-placement="bottom"></i>';
if($post['bname']=='Crypto Wallet'){
	$cryptoWallet=1;
	$post['coins_name']=$post['bswift'];
	$post['coins_network']=$post['brtgnum'];
	$post['coins_address']=$post['baccount'];
	$post['coins_wallet_provider']=$post['baddress'];
	
}else{$cryptoWallet=0;}	


if(isset($_GET['insertType']))
{
	if($_GET['insertType']=='Crypto Wallet'){$cryptoWallet=1;}else{$cryptoWallet=0;}
}
	
if((isset($post['gid'])&&$post['gid'])){ ?>
    <input <?=$ep;?> type="hidden" name="gid" value="<?=$post['gid']?>">
    <?
$buttonname="Update";
if($cryptoWallet==1){
	$h4text="Update your Crypto Wallet";
}else{
	$h4text="Update your Bank Account";
}
} ?>
    <div class="container px-0">
      <div class="tab-pane active" id="account-settings">
        <div class="vkg">
          <h4 class="my-2"><i class="<?=$data['fwicon']['bank'];?>"></i> <span id="bank_caption">
            <?=$h4text?>
            </span>
            <? if($data['con_name']<>"clk"){ ?>
            <?=$change_btn?>
            <? } ?>
          </h4>
        </div>
        <? if($buttonname=="Add"){ ?>
        <div class="container-sm my-2 mb-5 main_heading_type">
          <div class="row-fluid mt-5">
            <div class="text-start mb-2"> </div>
            <!--<div class="my-2 fs-5 hide-title">Select Your Bank Type</div> style="max-width:800px; margin:0 auto;"-->
            <div class="bTypeDiv" style="display:block;float:none;max-width:600px; margin:0 auto;">
			<div class="text-center">
              <div class="rounded-tringle rounded bg-primary vkg p-2 m-2 float-start bTypebox" boxval="bankType" >
                <div class="both-side-margin text-center"> 
				<div class="text-center my-2"><i class="<?=$data['fwicon']['bank'];?> fa-xl border p-3 rounded-circle text-white"></i></div>
				
				<span class="text-center"><!--form-check form-switch float-start-->
				
 <input type="radio" name="BankType" id="bankType_id" class="bType form-check-input my-2 hide" value="bankType" required/>
                  <label for="bankType_id" class="mb-2 fs-5 text-white">Add a bank account</label>
                  </span> </div>
              </div>
              <? if($data['con_name']=='clk'){ ?>
              <? }else{ ?>
<div class="rounded-tringle rounded  vkg p-2 m-2 bg-primary float-start bTypebox" boxval="CryptoCurrency" >
                <div class="both-side-margin text-center"> 
				<div class="text-center my-2"><i class="<?=$data['fwicon']['bitcoin'];?> fa-xl border p-3 rounded-circle text-white"></i></div>
				<span class="text-center"><!--form-check form-switch float-start-->
                  <input type="radio" name="BankType" id="CryptoCurrency_id" class="bType form-check-input my-2 hide" value="CryptoCurrency" required />
                  <label for="CryptoCurrency_id" class="mb-2 fs-5 text-white">Add a crypto wallet</label>
                  </span> </div>
              </div>
              <? } ?>
			  </div>
              <div class="clearfix"></div>
            </div>
          </div>
          <div class="clearfix"></div>
        </div>
        <!--<div class="container mb-3  border rounded bg-primary text-white d-flex44 justify-content-center ">
          <div class="bTypeDiv" style="display:block;float:none;"> <span class="form-check form-switch float-start mx-2">
            <input type="radio" name="BankType" id="bankType_id" class="bType form-check-input my-2" value="bankType"  required  />
            <label for="bankType_id" class="my-1">Bank Account</label>
            </span>
            <? if($data['con_name']=='clk'){ ?>
            <? }else{ ?>
            <span class="form-check form-switch float-start mx-2">
            <input type="radio" name="BankType" id="CryptoCurrency_id" class="bType form-check-input my-2" value="CryptoCurrency" required />
            <label for="CryptoCurrency_id" class="my-1">Crypto Wallet</label>
            </span>
            <? } ?>
          </div>
		      <div class="clearfix"></div>
        </div>-->
        <? } ?>
        <? /*?>
        <!-- Ajax DIVs -->
        <!--<center>
<div id="swiftmsg" style="color:red;float: left;">=============</div>

<div id="swiftmsgbutton" style="margin-left: 10px;display: none;float: left;"> <span title="Close" onclick="CloseDiv();"  style="margin-top: 7px;margin-left: -9px;;cursor:pointer; color: red;"><i class="far fa-times-circle"></i></span> </div>

<div id="swiftmsgbuttonright" style="margin-left: 10px;display: none;float: left;"> Code Validated. <span title="Close" onclick="CloseDiv();" class="glyphicons ok_2" style="margin-top: 7px;margin-left: -9px;;cursor:pointer; color: green;"><i class="far fa-check-circle"></i></span> </div>


<div id="swiftmsgloader" style="display:none;"> <img src="<?=$data['Host']?>/images/loader.gif" style="height:50px !important; width:50px !important;" /></div>


</center>-->
      <!--</div>-->
	  <? /*/?>
        <div class="row">
          <div id="swiftmsg" class="col-sm-12 px-1"></div>
        </div>
        <? if($buttonname=="Add"||$cryptoWallet==0){ ?>
        <div id="typeBank" class="<? if($buttonname=="Add"||$cryptoWallet==1){ ?> hide <? } ?> input_col_3">
          <div class="row  p-1 rounded mb-2 text-white" id="bank_section">
            <div class="col-sm-6 px-1 mt-1">
              <div > <span class="form-label d-none d-sm-block" id="basic-addon4" title="Name">Account Holder Name </span>
                <input <?=$ep;?> type="text" class="form-control" name="bnameacc" placeholder="Account holder&rsquo;s name" value="<?=prntext($post['bnameacc'])?>" autocomplete="off" required data-bs-toggle="tooltip" data-bs-placement="bottom" title="The bank account holder name should match the legal name of the business. Your account application may be rejected if you fail to provide a bank account matching this criteria."/>
              </div>
            </div>
            <div class="col-sm-6 px-1 mt-1">
              <div > <span class="form-label d-none d-sm-block" id="basic-addon1" title="Address">Address </span>
                <input <?=$ep;?> type="text" class="form-control" name="full_address"  placeholder="Account holder&rsquo;s address" value="<?=prntext(((isset($post['full_address']) &&$post['full_address'])?$post['full_address']:''));?>" autocomplete="off" title="Enter account holder&rsquo;s address - as per in bank records" data-bs-toggle="tooltip" data-bs-placement="bottom"   required />
              </div>
            </div>
            <div class="col-sm-6 px-1 mt-1">
              <div > <span class="form-label d-none d-sm-block" id="basic-addon1" title="Account Number">A/C Number </span>
                <input <?=$ep;?> type="text" class="form-control" name="baccount"  placeholder="Account number<? if($post['ovalidation']){ ?> / iban no<? } ?>" value="<?=decrypts_string($post['baccount'],0)?>" autocomplete="off" title="Enter account number<? if($post['ovalidation']){ ?> / iban no<? } ?>" data-bs-toggle="tooltip" data-bs-placement="bottom"   required/>
              </div>
            </div>
            <? if($post['ovalidation']){ ?>
            <div class="col-sm-6 px-1 mt-1">
              <div > <span class="form-label d-none d-sm-block" id="basic-addon1" title="Bank Short Code">Short Code </span>
                <input <?=$ep;?> type="text" class="form-control" name="brtgnum"  placeholder="Enter your short code" value="<?=prntext($post['brtgnum'])?>" autocomplete="off" title="Enter bank short code (BSB, ABA, IFSC, NSC, NCC, NUBAN etc)" data-bs-toggle="tooltip" data-bs-placement="bottom"   required/>
              </div>
            </div>
            <? } ?>
            <div class="col-sm-6 px-1 mt-1">
              <div > <span class="form-label d-none d-sm-block" id="basicidx" title="<?=$post['swift_con'];?>
          Code">
                <?=$post['swift_con'];?>
                Code </span>
                <input <?=$ep;?> type="text" class="form-control" name="bswift" id="bswift"  placeholder="Enter your <?=$post['swift_con'];?> code" value="<?=prntext($post['bswift'])?>" autocomplete="off" title="Enter your <?=$post['swift_con'];?> code" <? if($post['ovalidation']){ ?>   onBlur="checkAvailability()" <? } ?> data-bs-toggle="tooltip" data-bs-placement="bottom"   required/>
                <!--onfocusout="MakeRequest();"-->
              </div>
            </div>

            <div class="col-sm-6 px-1 mt-1">
              <div > <span class="form-label d-none d-sm-block" title="Bank Name">Bank Name </span>
                <input <?=$ep;?> type="text" class="form-control" name="bname" id="bname"  placeholder="Enter your bank name" value="<?=prntext($post['bname'])?>" autocomplete="off" title="Enter your bank name" data-bs-toggle="tooltip" data-bs-placement="bottom"   required/>
              </div>
            </div>
            <div class="col-sm-6 px-1 mt-1">
              <div > <span class="form-label d-none d-sm-block" title="Bank Address">Bank Address </span>
                <input <?=$ep;?> type="text" class="form-control" name="baddress" id="baddress"  placeholder="Enter your bank address" value="<?=prntext($post['baddress'])?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Enter your bank address" required/>
              </div>
            </div>
            
            <div class="col-sm-6 px-1 mt-1">
              <div > <span class="form-label d-none d-sm-block" title="Additional Information">Additional Info </span>
                <input <?=$ep;?> type="text" class="form-control" name="adiinfo" id="adiinfo"  placeholder="Additional information (remarks)" value="<?=prntext(((isset($post['adiinfo']) &&$post['adiinfo'])?$post['adiinfo']:''));?>" autocomplete="off" title="Enter additional information (remarks)" data-bs-toggle="tooltip" data-bs-placement="bottom" />
              </div>
            </div>
            
            <div class="col-sm-6 px-1 mt-1">
              <div > <span class="form-label d-none d-sm-block" title="Requested Currency">Currency </span>
                <? if(isset($data['con_name'])&&$data['con_name']=='clk'){?>
                <input <?=$ep;?> type="hidden" name="required_currency" id="required_currency" placeholder="Requested currency"  class="form-control" value="<?=prntext(isset($post['required_currency'])&&$post['required_currency']?$post['required_currency']:'INR')?>" style="display:none !important"/>
                <span class="ms-3 mt-2 text-primary">
                <?=prntext(isset($post['required_currency'])&&$post['required_currency']?$post['required_currency']:'INR')?>
                </span>
                <? }else{ ?>
                <select <?=$ep;?> class="form-select" name="required_currency" id="required_currency" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Select requested currency for payout" required >
                  <option value="" disabled selected>Requested Currency For Payout</option>
                  <? foreach ($data['AVAILABLE_CURRENCY'] as $k11) { ?>
                  <option value="<?=$k11?>">
                  <?=$k11?>
                  </option>
                  <? } ?>
                </select>
                <script>
$('#required_currency option[value="<?=prntext($post['required_currency'])?>"]').prop('selected','selected');
</script>
                <? } ?>
              </div>
            </div>
            <div class="col-sm-6 px-1 mt-1">
              <div  >
                <div class="float-start" style="width:calc(100% - 40px);"> <span class="form-label" title="Bank Document">Bank Document</span>
                  <div class="clearfix"></div>
                  <div class="mt-2 float-start" style="width: 90px;">
                    <input <?=$ep;?> type="file" class="file form-control px-2 rounded" name="bankdoc"  data-bs-toggle="tooltip" data-bs-placement="top" title="Select path to upload bank document">
                  </div>
                  <input <?=$ep;?> name="upload_logo" value="<?=prntext(((isset($post['bank_doc']) &&$post['bank_doc'])?$post['bank_doc']:''));?>" type="hidden" class="float-start">
                  <? if(isset($post['bank_doc']) &&$post['bank_doc']){ ?>
                  <? $pro_img=display_docfile("../user_doc/",(isset($post['bank_doc']) &&$post['bank_doc'])?$post['bank_doc']:'');?>
                  <?
				if(isset($post['primary'])&&$post['primary']!=2){
			  	?>
                  <label>Remove document?
                  <input <?=$ep;?> name="remove_logo" value="<?=$post['bank_doc'];?>" type="checkbox">
                  </label>
                  <?
				}
			
			   } ?>
                </div>
                <div class="float-start mt-4 pe-0 text-end" style="width:40px;" title="Click for add Intermediary Bank Details" data-bs-toggle="tooltip" data-bs-placement="left">
                  <? if($post['ovalidation']){ ?>
                  <label class="btn btn-primary btn-sm" for="intermediary_bank_info"> <i class="<?=$data['fwicon']['circle-plus'];?>"></i> </label>
                  <? } ?>
                </div>
              </div>
            </div>
            <div class="row">
              <? if($post['ovalidation']){ ?>
              <div  class="col-sm-12 rounded text-end">
                <div  class="col-sm-12 rounded">
                  <input  <?=$ep;?> <? if(isset($post['intermediary'])&&$post['intermediary']){echo "checked='checked'";} ?> type="checkbox" name='intermediary_bank_info' id='intermediary_bank_info' placeholder="Intermediary bank details" class="hide" value="<?=prntext(((isset($post['intermediary_bank_info']) &&$post['intermediary_bank_info'])?$post['intermediary_bank_info']:''));?>"  />
                  <!-- Ajax DIVs -->
                  <!-- END  Ajax DIVs -->
                  <div class=" intermediary_div my-2 <? if(!isset($post['intermediary']) || empty($post['intermediary'])){echo "hide";} ?>" id="intermediary_div">
                    <div class="row border bg-primary rounded">
                      <div class="col-sm-4 px-2 my-2">
                        <input <?=$ep;?> type="text" class="form-control" name="intermediary" id="intermediary" placeholder="Enter your intermediary <?=$post['swift_con'];?> code" title="Enter your intermediary <?=$post['swift_con'];?> code" value="<?=prntext(((isset($post['intermediary']) &&$post['intermediary'])?$post['intermediary']:''));?>"  onfocusout="IntMdtMakeRequest();" data-bs-toggle="tooltip" data-bs-placement="bottom"  />
                        <!--onfocusout="IntMdtMakeRequest();"-->
                      </div>
                      <div class="col-sm-4 px-2  my-2">
                        <input <?=$ep;?> type="text" class="form-control" name="intermediary_bank_name" id="intermediary_bank_name" placeholder="Enter your intermediary bank name" title="Enter your intermediary bank name" value="<?=prntext(((isset($post['intermediary_bank_name']) &&$post['intermediary_bank_name'])?$post['intermediary_bank_name']:''));?>" data-bs-toggle="tooltip" data-bs-placement="bottom" />
                      </div>
                      <div class="col-sm-4 px-2  my-2">
                        <input <?=$ep;?> type="text" class="form-control" name="intermediary_bank_address" id="intermediary_bank_address" placeholder="Enter your intermediary bank address" title="Enter your intermediary bank address" value="<?=prntext(((isset($post['intermediary_bank_address']) &&$post['intermediary_bank_address'])?$post['intermediary_bank_address']:''));?>" data-bs-toggle="tooltip" data-bs-placement="bottom" />
                      </div>
                    </div>
                  </div>
                  <script>
    $('#intermediary_bank_info').click(function(){
	if ($("#intermediary_bank_info[type='checkbox']:checked").length >0){
		 $('#intermediary_div').slideDown(700);
	}else{
	     $('#intermediary_div').slideUp(700);
	}
});	
</script>
                </div>
              </div>
              <? } ?>
              <div class="row my-2">
                <div class="text-center m_role">
                  <button type="submit" <?=$ep;?> name="send" value="CONTINUE"  class="btn btn-primary btn-sm"><i class="<?=$data['fwicon']['check-circle'];?>"></i>
                  <!--<?=$buttonname?>
                Bank Account-->
                  Submit</button>
                  <a href="<?=$data['Members']?>/bank<?=$data['ex']?>" class="btn btn-primary btn-sm" autocomplete="off"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
              </div>
            </div>
          </div>
          <? } ?>
        </div>
      </div>
    </div>
  </form>
  <? if(($data['con_name']!='clk')&&($buttonname=="Add"||$cryptoWallet==1)){ ?>
  <div class="container px-0 text-white">
    <form id="form2" method="post" name="data" enctype="multipart/form-data">
      <? if((isset($post['gid'])&&$post['gid'])){ ?>
      <input <?=$ep;?> type="hidden" name="gid" value="<?=$post['gid']?>">
      <? } ?>
      <input type="hidden" name="step" value="<?=$post['step']?>">
      <input <?=$ep;?> type="hidden" name="bname" value="Crypto Wallet" />
      <input <?=$ep;?> type="hidden" name="insertType" value="Crypto Wallet">
      <input <?=$ep;?> type="hidden" name="required_currency" id="required_currency" placeholder="Requested Currency"  class="span10" value="<?=prntext($post['default_currency']?$post['default_currency']:'INR')?>" style="display:none !important"  />
      <div id="typeCrypto" class="<? if($buttonname=="Add"||$cryptoWallet==0){ ?>hide<? } ?> input_col_2">
        <div class="row  p-1 rounded mb-2" id="bank_section">
          <div class="col-sm-6 px-1 mt-1"> <span class="form-label d-none d-sm-block" id="basic-addon4" >Coins </span>
            <select <?=$ep;?> name="coins_name" class="form-select" id="coins" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Select requested coins for payout" required >
              <option value="" disabled selected>Requested Coins For Payout</option>
              <option value="BTC">BTC</option>
              <option value="USDT">USDT</option>
              <option value="USDC">USDC</option>
            </select>
            <script>
	$('#coins option[value="<?=prntext($post['coins_name'])?>"]').prop('selected','selected');
	</script>
          </div>
          <div class="col-sm-6 px-1 mt-1"> <span class="form-label d-none d-sm-block" id="basic-addon1">Network </span>
            <select <?=$ep;?> name="coins_network"  class="form-select" id="coins_network" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Select network" required >
              <option value="" selected>Select Network</option>
              <option value="BTC">BTC</option>
              <option value="ERC20">ERC20</option>
              <option value="TRC20">TRC20</option>
              <option value="BEP2">BEP2</option>
              <option value="BEP20">BEP20</option>
              <option value="BSC">BSC</option>
              <option value="Other">Other</option>
            </select>
            <script>
	$('#coins_network option[value="<?=prntext($post['coins_network'])?>"]').prop('selected','selected');
	</script>
          </div>
          <div class="col-sm-6 px-1 mt-1"> <span class="form-label d-none d-sm-block" id="basic-addon4" >Address </span>
            <input <?=$ep;?> type="text" class="form-control" name="coins_address" id="coins_address" placeholder="Enter address" value="<?=((isset($post['coins_address'])&&$post['coins_address'])?decrypts_string($post['coins_address'],0):'');?>" autocomplete="off"  data-bs-toggle="tooltip" data-bs-placement="bottom" title="Enter address" required/>
            <!--id="coins_network"-->
          </div>
          <div class="col-sm-6 px-1 mt-1"> <span class="form-label d-none d-sm-block" id="basic-addon1" title="Wallet Provider">Provider </span>
            <input <?=$ep;?> type="text" class="form-control" name="coins_wallet_provider" id="coins_wallet_provider" placeholder="Wallet Provider" value="<?=((isset($post['coins_wallet_provider']) &&$post['coins_wallet_provider'])?$post['coins_wallet_provider']:'');?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Enter provider" required/>
          </div>
          <div class="col-sm-12 row px-1 mt-1">
            <div class="upload-docimgx"> <span class="form-label text-wrap" id="upload-docimgxtt" title="Upload Screenshot of Wallet Dashboard">Screenshot of Wallet Dashboard </span>
              <div class="clearfix"></div>
              <div class="float-start" style=" width:90px;">
                <input <?=$ep;?> type="file" class="file form-control px-2 rounded" name="bankdoc" data-bs-toggle="tooltip" data-bs-placement="top" title="Select path to upload screenshot of wallet dashboard">
              </div>
              <input <?=$ep;?> name="upload_logo" value="<?=((isset($post['bank_doc'])&&$post['bank_doc'])?$post['bank_doc']:'');?>" type="hidden" class="">
              <? if(isset($post['bank_doc']) &&$post['bank_doc']){ ?>
              <? $pro_img=display_docfile("../user_doc/",((isset($post['bank_doc'])&&$post['bank_doc'])?$post['bank_doc']:''));
			  
			  if(isset($post['primary'])&&$post['primary']!=2){
			  	?>
              <label>Remove document?
              <input <?=$ep;?> name="remove_logo" value="<?=$post['bank_doc'];?>" type="checkbox">
              </label>
              <?
				}
			  } ?>
            </div>
          </div>
          <div class="row my-2">
            <div <?=$ep;?> class="text-center m_role" >
              <button type="submit" <?=$ep;?> name="send" value="CONTINUE"  class="btn btn-primary btn-sm" ><i class="<?=$data['fwicon']['check-circle'];?>"></i>Submit </button>
              <a href="<?=$data['Members']?>/bank<?=$data['ex']?>" class="btn btn-primary btn-sm"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> </div>
          </div>
        </div>
      </div>
    </form>
  </div>
  <? } ?>
  <? } ?>
</div>

<script>
      $(function(){
      $('[data-bs-toggle="tooltip"]').tooltip();
      });
      </script>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
