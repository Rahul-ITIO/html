<? if(isset($data['ScriptLoaded'])){ //echo $data['SiteName']; ?>
<div class="container border mt-2 mb-2 bg-white vkg bg-primary rounded" >

<?php /*?> js function for check Dulicate invoice no <?php */?> 
<script>

function checkAvailability(val) {

if(val==""){ return false; }  // function die  when get  blank value

	var d='tbl=request_trans_table&invoice_no='+val;


	$("#loaderIcon").show();
	jQuery.ajax({
	url: "<?php echo $data['Host'];?>/include/check_availability<?=@$data['ex']?>",
	data:d,
	type: "POST",
	success:function(data){
		$("#invoice-availability-status").html(data);
	//	$("#invoice_no").focus();
	//	$("#invoice_no").select();
		$("#loaderIcon").hide();
	},
	error:function (){}
	});
}



// js function for show / hide listing detail section
$(document).ready(function(){
    $(".email_validate_input").keyup(function(){
		email_validatef(this,".validate_input_firstname","");
	});
	
	var email_subject_var="1";
	$("#businessSettings").change(function() {
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
      <h4 class="float-start"><i class="<?=@$data['fwicon']['report'];?>"></i> Invoice</h4>
    </div>
  </div>
  <form method="post" name="data" >
    <input type="hidden" name="step" value="<?=((isset($post['step'])&&$post['step'])?$post['step']:'')?>">
    <input type="hidden" name="uid" value="<?=((isset($post['uid'])&&$post['uid'])?$post['uid']:'')?>">
    <? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      <strong>Error!</strong>
      <?=prntext($data['Error'])?>
    </div>
    <? } ?>
    <? if(isset($_SESSION['action_success'])&&$_SESSION['action_success']){ ?>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      <?php echo $_SESSION['action_success'];?> </div>
    <? $_SESSION['action_success']=null;} ?>
	
	<? 
	if(isset($_GET['action'])&&$_GET['action']=='edit') $post['step']=2;
	elseif(isset($_GET['action'])&&$_GET['action']=='preview') $post['step']=3; 
	?>
	
    <? if(($post['step']==1) && (@$_GET['invid']=="")){ ?>
	
    <div class="ro col-sm-12 row" id="s_box">
      <div class="col-sm-10">
        <div class="row col-sm-12 me-1">
          <div class="col-sm-6 px-1">
            <input type="text" name="key_name" class="search_textbx form-control my-1 w-100" placeholder="Search.." style="width:100% !important;" value="" onclick="return false;" autocomplete="off">
          </div>
          <div class="col-sm-5 px-1">
            <select name="key_type" id="searchkeyname" title="Select key name" class="filter_option form-select my-1 w-100" autocomplete="off">
              <option value="" selected="selected">Select</option>
              <option value="invoice_no" data-placeholder="Invoice No." title="Invoice No.">Invoice No.</option>
              <option value="receiver_email" data-placeholder="Email" title="Email">Email</option>

            </select>
          </div>
          <div class="col-sm-1 px-1">
            <button type="submit" name="simple_search" value="filter" class="simple_search btn btn-primary my-1"><i class="<?=@$data['fwicon']['search'];?>"></i></button>
          </div>
        </div>
      </div>
      <div class="col-sm-2">
        <div class="ro" >
          <div class="text-end">
            <button type="submit" name="send" value="ADD NEW Invoice!"  class="btn btn-primary my-1"><i class="<?=@$data['fwicon']['circle-plus'];?>" title="Add New Invoice"></i></button>
          </div>
        </div>
      </div>
    </div>
    <div class="my-2  col-sm-12 table-responsive-sm">
      <table class="table table-hover bg-primary text-white">
	  
	    <? if(count($data['selectdatas'])!=0){ ?>
        <thead>
          <tr>
		    <th scope="col">#</th>
            <th scope="col">Invoice No.</th>
            <th scope="col">Date</th>
            <th scope="col">Amount</th>
            <th scope="col" class="hide-768">Name</th>
            <th scope="col" class="hide-768">Email</th>
            <th scope="col" class="hide-768">Customer To</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
		
		<? }else{ ?>
		<tr class="rounded bg-white">
		<td colspan="8"  style="padding-left: unset !important;">
		<div class="my-2 ms-2 fs-5 text-start">Create an invoice in minutes</div>
		
		<div class="text-start my-2 ms-2" style="max-width:400px !important;">Send your customers an invoice with a link to pay online and a pdf. Accept card, bank transfers, upi and more.</div>
		
		
		<button type="submit" name="send" value="ADD NEW Invoice!" class="btn btn-primary my-2 ms-2 float-start"><i class="<?=@$data['fwicon']['circle-plus'];?>" title="Add New Invoice"></i> Add A New Invoice</button>
		
		</td>
		</tr>
		<? } ?>
		
		
        <? $j=1; foreach($data['selectdatas'] as $ind=>$value) {  ?>
        <?
			$jsr=jsondecode($value['json_value']);
			//print_r($jsr);echo"<br/>";
			
		?>
        <tr >
          <td><a data-bs-toggle="modal" data-count="<?=prntext($value['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=@$data['fwicon']['display'];?> text-link" title="View details"></i></a></td>
		  
			<td data-label="&nbsp;Invoice No."><?=@$value['invoice_no'];?></td>
          <td data-label="&nbsp;Invoice Date."><?=date("d/m/Y",strtotime($value['created_date']));?></td>
          <td data-label="&nbsp;Amount"><?=number_format((float)$value['amount'], 2, '.', '');?> <?=@$value['currency']?></td>
          <td data-label="&nbsp;Name" class="hide-768"><?=@$value['fullname']?></td>
          <td data-label="&nbsp;Email" class="hide-768"><?=@$value['receiver_email']?></td>
          <td data-label="&nbsp;Address" class="hide-768"><?=ucwords(strtolower($jsr['bill_city'].", ".$jsr['bill_state'].", ".$jsr['bill_country']));?></td>
          <td data-label="&nbsp;Action"><? if($value['status'] !="Pending") { ?>
            <b>
            <?=@$value['status'];?>
            </b>
            <? } else{ ?>
            <div class="btn-group dropstart short-menu-auto-main"> <a data-bs-toggle="dropdown" aria-expanded="false" title="Action" ><i class="<?=@$data['fwicon']['circle-down'];?> text-link"></i></a>
<ul class="dropdown-menu dropdown-menu-icon pull-right text-center" >

<li> <a class="dropdown-item" href="<?=@$data['USER_FOLDER']?>/invoice<?=@$data['ex']?>?id=<?=@$value['id']?>&action=update" title="Edit Invoice"><i class="<?=@$data['fwicon']['edit'];?> text-success"></i></a> </li>

<li> <a class="dropdown-item" href="<?=@$data['USER_FOLDER']?>/invoice<?=@$data['ex']?>?id=<?=@$value['id']?>&action=delete"  title="Delete Invoice" onclick="return confirm('Are you Sure to Delete');" ><i class="<?=@$data['fwicon']['delete'];?> text-danger"></i></a> </li>

<li> <a class="dropdown-item"  href="<?=@$data['USER_FOLDER']?>/invoice<?=@$data['ex']?>?invid=<?=@$value['id']?>&action=display"   title="View" ><i class="<?=@$data['fwicon']['eye-solid'];?>"></i></a> </li>

<li> <a class="dropdown-item" href="invoice-pdf<?=@$data['ex']?>?bid=<?=@$value['id']?>" target="_blank"  title="Download Invoice" ><i class="<?=@$data['fwicon']['download'];?> "></i></a> </li>

</ul>

</div>
			

			
			
			
            <? } ?>
          </td>
        </tr>
        <tr class="hide">
          <td colspan="8">
	<div class="next_tr_<?=prntext($value['id'])?>  hide row">
	<div class="mboxtitle hide">Invoice Detail : <?=@$value['656565']?></div>
              <div class="row">
                <? if(isset($value['invoice_no'])&&$value['invoice_no']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Invoice No :
                  <?=@$value['invoice_no'];?>
                </div>
                <? } ?>
				
				<? if(isset($value['amount'])&&$value['amount']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Amount Payable :
                  <?=@$value['amount']?>
                  <?=@$value['currency']?>
                </div>
                <? } ?>
				
				<? if(isset($value['product_name'])&&$value['product_name']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Product Name :
                  <?=@$value['product_name'];?>
                </div>
                <? } ?>
				
                <? if(isset($value['fullname'])&&$value['fullname']){ ?>
                <div class="col-sm-6 my-2 px-2 card ">Name Of The Receiver :
                  <?=@$value['fullname']?>
                </div>
                <? } ?>
                <? if(isset($value['receiver_email'])&&$value['receiver_email']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Receivers Email Address :
                  <?=@$value['receiver_email']?>
                </div>
                <? } ?>
                
                <? if(isset($value['comments'])&&$value['comments']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Description (Optional) :
                  <?=@$value['comments']?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_phone'])&&$jsr['bill_phone']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Phone :
                  <?=@$jsr['bill_phone'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_address'])&&$jsr['bill_address']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Street 1 :
                  <?=@$jsr['bill_address'];?>
                </div>
                <? } ?>
               
                <? if(isset($jsr['bill_city'])&&$jsr['bill_city']){ ?>
                <div class="col-sm-6 my-2 px-2 card">City :
                  <?=@$jsr['bill_city'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_state'])&&$jsr['bill_state']){ ?>
                <div class="col-sm-6 my-2 px-2 card">State :
                  <?=@$jsr['bill_state'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_country'])&&$jsr['bill_country']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Country :
                  <?=@$jsr['bill_country'];?>
                </div>
                <? } ?>
                <? if(isset($jsr['bill_zip'])&&$jsr['bill_zip']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Zip :
                  <?=@$jsr['bill_zip'];?>
                </div>
                <? } ?>
				
				<? if(isset($jsr['term_condation'])&&$jsr['term_condation']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Term Condation :
                  <?=@$jsr['term_condation'];?>
                </div>
                <? } ?>
				
				<? if(isset($jsr['notes'])&&$jsr['notes']){ ?>
                <div class="col-sm-6 my-2 px-2 card">Notes :
                  <?=@$jsr['notes'];?>
                </div>
                <? } ?>
				
				
                <div class="col-sm-6 my-2 px-2 card">Status :
                  <?=@$value['status']?>
                  <? if($value['transID']){ ?>
                  | <a href="<?=@$data['USER_FOLDER'];?>/transactions<?=@$data['ex']?>?action=select&searchkey=<?=@$value['transID']?>&keyname=1&type=-1&status=-1">
                  <?=@$value['transID']?>
                  </a>
                  <? } ?>
                </div>
                <? if(isset($jsr['noneEditableUrl'])&&$jsr['noneEditableUrl']){ ?>
                <div lass="col-sm-12">

                  <button title="Copy to Pay URL" type="button" class="btn btn-primary btn-sm float-end"  onclick="copytext_f(this,'Pay URL');" data-value='<?=@$data['Host']?>/payme<?=@$data['ex']?><?=@$jsr['noneEditableUrl']?>' ><i class="<?=@$data['fwicon']['copy'];?>"></i></button>
                  <a target="_blank" class="btn btn-primary btn-sm float-end mx-2" href="<?=@$data['Host']?>/payme<?=@$data['ex']?><?=@$jsr['noneEditableUrl']?>/" ><i class="<?=@$data['fwicon']['amazon-pay'];?>"></i></a></div>
              </div>
              </div>
              <? } ?>
            </div></td>
        </tr>
        <? $j++; } ?>
      </table>
    </div>
		<? }elseif($post['step']==2){ 
		
		?>
    <? if(isset($post['gid'])&&$post['gid']){ ?>
    <input type="hidden" name="gid" value="<?=@$post['gid']?>">
    <? }else{
	   
	}
	if(isset($_SESSION['invoice_data'])) $post=$_SESSION['invoice_data'];
	
	$firstName="";
	$lastName="";


	if($data['con_name']=='clk'){
		$style_display='display:none;';
	 }
	 else{
		 $style_display='';
	 }

	 //echo "<br/>con_name=>".$data['con_name']."<br/><br/>";

?>
    <h4 class="heading glyphicons settings">
      <?=@$post['add_titileName'];?> Invoice</h4>
    <div class="row bg-primary text-white p-1 rounded">

	<p align="center"><img src="<?php echo $data['Host'];?>/images/loader.gif" id="loaderIcon" style="display:none" /></p>

	<div id="invoice-availability-status" class="col-sm-12 my-2 px-1"></div>
	
      <? $k=0; if($data['Store']&&$data['store_size']>0){ ?>
      <div class="col-sm-2 my-2 px-1">
        <select name="type" id="businessSettings" class="form-select" title="Select your business" data-bs-toggle="tooltip" data-bs-placement="top" required>
          <option value="" disabled>Select Business</option>
          <?
				foreach($data['Store'] as $key=>$value){
			?>
          <option data-burl="<?=@$value['bussiness_url'];?>" data-dba="<?=@$value['ter_name'];?>" data-val="<?=@$value['public_key'];?>" value="<?=@$value['public_key'];?>_;<?=@$k;?>">
          <?=@$value['ter_name']?>
          </option>
          <? $k++; } ?>
        </select>
        <? if(@$post['type']){ ?>
        <script>
			$('#businessSettings option[data-val="<?=($post['type'])?>"]').prop("selected", "selected");
			$('#businessSettings option[data-val="<?=($post['type'])?>"]').attr("selected", "selected");
		</script>
        <? } ?>
      </div>
      <? } ?>

      <? if(!isset($post['gid']) || !$post['gid']){ //$post['json_value']=[];
	  }
	 ?>
	  
		
	
      <div class="col-sm-2 my-2 px-1">
        <input type="text" name="invoice_no" id="invoice_no"  placeholder="Invoice no. *" class="form-control" value="<?=prntext(isset($post['invoice_no'])?$post['invoice_no']:'')?>" <? if(isset($post['gid'])&&$post['gid']) echo 'readonly';else{?>onBlur="checkAvailability(this.value)"<? }?> required title="Enter invoice no." data-bs-toggle="tooltip" data-bs-placement="top"  />
      </div>
      <div class="col-sm-2 my-2 px-1">
        <input type="number" step="00.01" name="json_value[product_amount]"   placeholder="Amount ex. 10.00 *" class="form-control" value="<?=prntext(isset($post['json_value']['product_amount'])?$post['json_value']['product_amount']:'')?>" required title="Enter amount ex. 10.00" data-bs-toggle="tooltip" data-bs-placement="top"  />
      </div>
      <div class="col-sm-2 my-2 px-1 ">
        <select name="currency"  class="form-select" id="currency"  title="Select currency" data-bs-toggle="tooltip" data-bs-placement="top" required >
          <option value="" disabled selected>Currency</option>
			<? foreach ($data['AVAILABLE_CURRENCY'] as $k11) { ?>
				<option value="<?=@$k11?>"><?=@$k11?></option>
			<? } ?>
        </select>
        <? 
		if(!isset($post['currency'])||empty($post['currency']))
			$post['currency']=$post['default_currency'];
		
		if(isset($post['currency'])&&trim($post['currency']))
		{?>
        <script>$('#currency option[value="<?=@$post['currency']?>"]').prop('selected','selected');</script>
        <?
		}
		?>
      </div>
      <div class="col-sm-2 my-2 px-1 ">
        <select name="json_value[tax_type]" class="form-select" id="tax_type"  title="Select tax type" data-bs-toggle="tooltip" data-bs-placement="top" >
          <option value="">Tax Type</option>
          <option value="1">Fixed Amount</option>
          <option value="2">Percentage</option>
        </select>
        <? 
		if(isset($post['json_value']['tax_type']))
		{?>
        <script>$('#tax_type option[value="<?=@$post['json_value']['tax_type']?>"]').prop('selected','selected');</script>
        <?
		}?>
      </div>
      <div class="col-sm-2 my-2 px-1">
        <input type="number" step="00.01" name="json_value[tax_amount]"  placeholder="Tax Amount" title="Enter tax amount" class="form-control" value="<?=prntext(isset($post['json_value']['tax_amount'])?$post['json_value']['tax_amount']:'0')?>" data-bs-toggle="tooltip" data-bs-placement="top"  />
      </div>
      <div class="col-sm-6 my-2 px-1">
        <input type="text" name="product_name"  placeholder="Product Name *" title="Enter product name"  class=" form-control" value="<?=(isset($post['product_name'])?$post['product_name']:'')?>"  autocomplete="off" required data-bs-toggle="tooltip" data-bs-placement="top"  />
      </div>
      <div class="col-sm-6 my-2 px-1">
        <input type="email" name="receiver_email"  placeholder="Customer Email *" title="Enter customer email"  class=" form-control" value="<?=(isset($post['receiver_email'])?$post['receiver_email']:'')?>"  autocomplete="off" required data-bs-toggle="tooltip" data-bs-placement="top" />
      </div>
      <div class="col-sm-6 my-2 px-1">
        <input type='text' name='fullname' placeholder="Customer Full Name *" title="Enter customer full name" class="form-control" value="<?=prntext(isset($post['fullname'])?$post['fullname']:'')?>" data-bs-toggle="tooltip" data-bs-placement="top" required />
      </div>
      <?php



if(!isset($post['user_type']))	$post['user_type']= "";
$post['bill_phone']=@$post['json_value']['bill_phone'];
$post['bill_address']=@$post['json_value']['bill_address'];

$post['bill_city']=@$post['json_value']['bill_city'];
$post['bill_state']=@$post['json_value']['bill_state'];
$post['bill_country']=@$post['json_value']['bill_country'];
$post['bill_zip']=@$post['json_value']['bill_zip'];

?>
      <div class="col-sm-6 my-2 px-1">
        <input type='text' name='json_value[bill_phone]' placeholder="Customer Phone / Mobile No. *" title="Enter customer phone / mobile no." class="form-control" value='<?=prntext(isset($post['bill_phone'])?$post['bill_phone']:'')?>' required data-bs-toggle="tooltip" data-bs-placement="top" />
      </div>
      
      <div class="col-sm-6 my-2 px-1" style='<?=@$style_display;?>' >
        <input type='text' name='json_value[bill_address]' placeholder="Customer Address" title="Enter customer Address" class=" form-control" value='<?=prntext(isset($post['bill_address'])?$post['bill_address']:'')?>' data-bs-toggle="tooltip" data-bs-placement="top" />
      </div>
      
      <div class="col-sm-6 my-2 px-1" style='<?=@$style_display;?>' >
        <input type='text' name='json_value[bill_city]' placeholder="Customer City" title="Enter customer city" class=" form-control" value="<?=prntext(isset($post['bill_city'])?$post['bill_city']:'')?>" data-bs-toggle="tooltip" data-bs-placement="top" />
      </div>
      <div class="col-sm-6 my-2 px-1" style='<?=@$style_display;?>' >
        <input type='text' name='json_value[bill_state]' placeholder="Customer State"  title="Enter customer state" class=" form-control" value="<?=prntext(isset($post['bill_state'])?$post['bill_state']:'')?>" data-bs-toggle="tooltip" data-bs-placement="top" />
      </div>
      <div class="col-sm-6 my-2 px-1" style='<?=@$style_display;?>' >
        <input type='text' name='json_value[bill_country]' placeholder="Customer Country"  title="Enter customer country" class=" form-control" value="<?=prntext(isset($post['bill_country'])?$post['bill_country']:'')?>" data-bs-toggle="tooltip" data-bs-placement="top"  />
      </div>
      <div class="col-sm-6 my-2 px-1" style='<?=@$style_display;?>' >
        <input type='text' name='json_value[bill_zip]' placeholder="Customer Zipcode" title="Enter customer zipcode" class=" form-control" value="<?=prntext(isset($post['bill_zip'])?$post['bill_zip']:'')?>" data-bs-toggle="tooltip" data-bs-placement="top" />
      </div>
      <div class="col-sm-6 my-2 px-1">
			<textarea name='json_value[term_condation]' placeholder="Terms & Conditions" title="Enter terms & conditions" class=" form-control" data-bs-toggle="tooltip" data-bs-placement="top"><?=(isset($post['json_value']['term_condation'])&&trim($post['json_value']['term_condation'])?$post['json_value']['term_condation']:'')?></textarea>
      </div>
      <div class="col-sm-6 my-2 px-1">
			<textarea name='json_value[notes]' placeholder="Notes" title="Enter notes" class=" form-control" data-bs-toggle="tooltip" data-bs-placement="top"><?=prntext(isset($post['json_value']['notes'])?$post['json_value']['notes']:'')?></textarea>
      </div>
      <div class="col-sm-12 p-1 ">
        <?php 
		if(@$post['action']=='update')
		{
		?><button type="submit" name="send" value="Submit" class="btn btn-icon btn-primary me-2"><i class="<?=@$data['fwicon']['check-circle'];?>"></i> Submit</button><?php 
		}
		else
			{ //unset($_SESSION['invoice_data']);
			?>
		<button type="submit" name="send" value="CONTINUE" class="btn btn-icon btn-primary me-2"><i class="<?=@$data['fwicon']['check-circle'];?>"></i> Continue</button>
		<?
		}?>
        <a href="<?=@$data['USER_FOLDER']?>/invoice<?=@$data['ex']?>?" id="remove_class" class="btn btn-icon btn-primary " ><i class="<?=@$data['fwicon']['back'];?>"></i> Back</a> </div>
		</div>
      <? } ?>
	  </form>
	<?
	if(isset($_GET['action'])&&($_GET['action']=='preview')){
		include_once $data['Path']."/front_ui/default/user/template.invoice_preview".$data['iex'];
	}
	elseif((@$_GET['action']=='display') && (@$_GET['invid']!="")){ ?>
	 <form method="post" name="data" >
    <input type="hidden" name="uid" value="<?=((isset($post['uid']) &&$post['uid'])?$post['uid']:'')?>">
	
	  <script> $("#linkid").removeAttr("href");</script>
	  <style>.card { background:#fff !important;}</style>
      <div class="container mb-2">
	  <div class="text-info m-2 pt-2 text-end remove-link-css">
   
	<button class="btn btn-icon btn-primary btn-sm" type="submit" name="invoice" value="inv" title="Send Invoice"><i class="<?=@$data['fwicon']['email'];?>"></i></button> 
	<a class="btn btn-primary btn-sm" href="invoice-pdf<?=@$data['ex']?>?bid=<?=@$_GET['invid'];?>" target="_blank"  title="Download Invoice"><i class="<?=@$data['fwicon']['download'];?>"></i></a>
	<a class="btn btn-primary btn-sm" href="?id=<?=@$_GET['invid'];?>&action=update" title="Edit"><i class="<?=@$data['fwicon']['edit'];?>"></i></a>
	<a class="btn btn-primary btn-sm" href="?"  title="Back"><i class="<?=@$data['fwicon']['back'];?>"></i></a> 

        </div>
        <div class="row d-flex justify-content-center">
          <div class="col-md-8">
            <div class="card">
              <div class="d-flex bd-highlight my-3">
                <div class="me-auto p-2 bd-highlight"><strong><?=@$post['company_name'];?></strong><br />
                  <? 
					if(isset($post['fullname'])&&$post['fullname']) echo $post['fullname'];?><br /> 

				<?=@$post['registered_address'];?><br />
                   </div>
                <div class="p-2 bd-highlight fs-3">Invoice</div>
              </div>
              <div class="d-flex bd-highlight mb-3">
			  
                <div class="me-auto p-2 bd-highlight"><strong>Bill To</strong><br />
				  <?=@$post['fullname'];?><br />

				  <?=(isset($post['receiver_email'])&&$post['receiver_email']?"Email: ".$post['receiver_email'].'<br />':'');	?>		
					<?=(isset($post['json_value']['bill_phone'])&&$post['json_value']['bill_phone']?"Mobile: ".$post['json_value']['bill_phone'].'<br />':'');	?>
					
					
					
				   <? if(isset($post['json_value']['bill_address'])&&$post['json_value']['bill_address']){?>
				   <?=@$post['json_value']['bill_address'];?>,
				   <? } ?>
				   <br />
					

					
					
				  <? if(isset($post['json_value']['bill_city'])&&$post['json_value']['bill_city']){?>
                  <?=@$post['json_value']['bill_city']?>,
				  <? } ?>
				  
				  <? if(isset($post['json_value']['bill_state'])&&$post['json_value']['bill_state']){?>
                  <?=@$post['json_value']['bill_state']?>,
				  <? } ?>
				  
				  <? if(isset($post['json_value']['bill_country'])&&$post['json_value']['bill_country']){?>
                  <?=@$post['json_value']['bill_country']?>
				  <? } ?>
				  
				  <? if(isset($post['json_value']['bill_country'])&&isset($post['json_value']['bill_zip'])&&$post['json_value']['bill_country']&&$post['json_value']['bill_zip']){?>
				  -
				  <? } ?>
				  
				  <? if(isset($post['json_value']['bill_zip'])&&$post['json_value']['bill_zip']){?>
                  
                  <?=@$post['json_value']['bill_zip']?>
				  <? } ?>
				  
                </div>
                <div class="p-2 bd-highlight"><strong>Invoice No&nbsp;&nbsp;&nbsp;&nbsp;#</strong>
                  <?=prntext(isset($post['invoice_no'])?$post['invoice_no']:'')?>
                  <br />
                  <strong>Invoice Date #</strong>
                  <?=date("d/m/Y",strtotime($post['created_date']));?>
                </div>
              </div>
              <hr>
              <div class="products p-2 my-2">
			  <? 
				$post['amount']=number_format((float)$post['json_value']['product_amount'], 2, '.', '');
				
				?>
                <table class="table table-striped">
                  <tbody>
                    <tr class="add">
                      <td class="w-75"><strong>Description</strong></td>
                      <td class="w-25"><strong>Amount</strong></td>
                    </tr>
                    <tr class="content">
                      <td><?=@$post['product_name']?></td>
                      <td><?=@$post['amount']?> <?=@$post['currency']?></td>
                    </tr>
                  </tbody>
                </table>
				 <? 
				if($post['json_value']['tax_type']<>""){ 
				
				$taxtitle="";
				$taxamt="";
				$totalamt="";
				
				    if($post['json_value']['tax_type']==1){
						$taxamt=$post['json_value']['tax_amount'];
						$taxamt=number_format((float)$taxamt, 2, '.', '');
						$taxtitle="";
						$totalamt=$post['amount'] + $taxamt;
					}elseif($post['json_value']['tax_type']==2){
						$taxamt=($post['amount'] *  ($post['json_value']['tax_amount'] / 100));
						$taxamt=number_format((float)$taxamt, 2, '.', '');
						$taxtitle=$post['json_value']['tax_amount']." %";
						$totalamt=$post['amount'] + $taxamt;
					}else{
					
					}
					
				   }else{
				   $totalamt=$post['amount'];
				   } 
				   $totalamt=number_format((float)$totalamt, 2, '.', '');
				?>
				
				<table class="table float-end w-50 mb-2">
                  <tbody>
				  <? if(@$taxamt<>"") { ?>
                    <tr class="content">
                      <td class="w-50"><strong>Tax <?=@$taxtitle;?> :</strong></td>
                      <td class="w-50"><?=@$taxamt?> <?=@$post['currency']?></td>
                    </tr>
				  <? } ?>
					<tr class="content">
                      <td class="w-50"><strong>Total :</strong></td>
                      <td class="w-50"><?=@$totalamt?> <?=@$post['currency']?></td>
                    </tr>
                  </tbody>
                </table>
				
				
				
              </div>
              
			  <hr class="clearfix mt-2">
              <div class="text-center my-2 clearfix"> <a href="<?=@$data['Host']?>/payme<?=@$data['ex']?>/<?=@$post['transactioncode']?>/" target="_blank" class="btn rounded-pill p-2 btn-primary w-50">Pay Now</a></div>
              <hr>
              <? if($post['json_value']['term_condation']<>""){ ?>
              <div class="d-flex px-2 bd-highlight"><strong>Terms & Condations : </strong></div>
              <div class="d-flex px-2 mb-2 bd-highlight">
                <?=@$post['json_value']['term_condation'];?>
              </div>
              <? } ?>
              <? if($post['json_value']['notes']<>""){ ?>
              <div class="d-flex px-2 bd-highlight"><strong>Notes : </strong></div>
              <div class="d-flex px-2 mb-2 bd-highlight">
                <?=@$post['json_value']['notes'];?>
              </div>
              <? } ?>
			  <div class="text-end m-2"><strong>Powered by</strong> - <?=@$mailer_sitename=$data['SiteName'];?></div>
              <div class="text-center text-secondary my-2"  style="font-size:10px">this is computer generated invoice no signature required</div>
            </div>
          </div>
        </div>
      </div>
	  <?
	  

	if(isset($post['fullname'])&&$post['fullname']) $fullname= $post['fullname'];

	$address22=@$post['city'].", ".@$post['state'].", ".@$post['country']." - ".@$post['zip'];
	$baddress=@$post['json_value']['bill_address'];
	  
	 if(isset($post['json_value']['bill_city'])&&$post['json_value']['bill_city']){
		$json_value_bill_city=@$post['json_value']['bill_city'].",";	   
	 }
	 if(isset($post['json_value']['bill_state'])&&$post['json_value']['bill_state']){
		$json_value_bill_state=@$post['json_value']['bill_state'].",";	   
	 }
	 if(isset($post['json_value']['bill_country'])&&isset($post['json_value']['bill_zip'])&&$post['json_value']['bill_country']&&$post['json_value']['bill_zip']){
	 $seperators=" - ";
	 }
	  
	 $baddress22=@$json_value_bill_city." ".@$json_value_bill_state." ".@$post['json_value']['bill_country']." ".@$seperators." ".@$post['json_value']['bill_zip'];
	  
	  $inv_val = array("inv_m_company"=>@$post['company_name'], 
	  				   "inv_m_name"=>@$fullname ,
	  				   "inv_m_address"=>@$post['registered_address'],
	  				   "inv_m_address2"=>@$address22,
					   "inv_b_name"=>@$post['fullname'] ,
					   "inv_email"=>@$post['receiver_email'] ,
					   "inv_phone"=>@$post['json_value']['bill_phone'] ,
	  				   "inv_b_address"=>@$baddress,
	  				   "inv_b_address2"=>@$baddress22,
	  				   "inv_created_date"=>@$post['created_date'],
	                   "inv_invoice_no"=>@$post['invoice_no'], 
					   "inv_product_name"=>@$post['product_name'], 
					   "inv_amount"=>@$post['amount'], 
	                   "inv_currency"=>@$post['currency'], 
					   "inv_taxtitle"=>@$taxtitle, 
					   "inv_taxamt"=>@$taxamt, 
					   "inv_totalamt"=>@$totalamt,
	                   "inv_transactioncode"=>@$post['transactioncode'], 
					   "inv_term_condation"=>@$post['json_value']['term_condation'], 
					   "inv_notes"=>@$post['json_value']['notes']
					   );
	  
     			 $inv_data=json_encode($inv_val);
	  ?>
	
	  <input type="hidden" name="inv_data" value='<?=@$inv_data;?>' />
     
	  </form>
      <? } ?>
    </div>
<script>
// js for search validation
$(".simple_search").click(function() {
   var staxtval=$(".search_textbx").val();
   var skeyname=$("#searchkeyname").val();
   if((staxtval=="") || (skeyname=="")){
   alert("Please Enter Black List Search Keyword / Type ");
   return false;
   }
});
</script> 
  
<!--</div>-->
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
