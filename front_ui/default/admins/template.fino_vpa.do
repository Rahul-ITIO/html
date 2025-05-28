<? if(isset($data['ScriptLoaded'])){ ?>


<? if(!$data['PostSent']){ ?>
<style>
.fa-star-of-life {font-size: 8px !important;}
</style>
<meta charset="UTF-8">
<div class="container mt-2 border rounded bg-primary text-white clearfix_ice" >
  <div class="my-2 vkg" >
    <h4 class=""><i class="<?=@$data['fwicon']['payment-button'];?>" aria-hidden="true"></i> Generate Fino VPA </h4>
  </div>


<? 
if($data['con_name']=='clk'){
	$style_display='display:none;';
 }
 else{
	 $style_display='';
 }
 //echo "<br/>con_name=>".$data['con_name']."<br/><br/>";

 
if(!isset($post['send'])&&isset($_REQUEST['qp'])&&$_REQUEST['qp']==2) {
    //132072023112178
    $post_demo=["clientTxnId"=>"132072023112178", "serviceId"=>"9001", "mobilenumber"=>"918788693162", "vpasubstring"=>"deepti", "firstname"=>"deepti", "lastname"=>"tyagi", "accountnumber"=>"6411978921", "ifsc"=>"KKBK0000638", "accounttype"=>"SAVINGS", "mcccode"=>"7407", "franchisename"=>"TV Showroom - Kharghar", "brandname"=>"FINO UPI", "Settlement_Account"=>"232132322424212", "Settlement_IFSC"=>"FINO00111123", "Bank_Name"=>"Fino payments Bank", "Bene_Name"=>"Rahul Shetty", "MDR_Per"=>"1", "Minimum_Charge"=>"0.01", "MDR_Type"=>"P"];
    $post=array_merge($post, $post_demo);
}

 ?>
 <!-- novalidate  -->
  <form method="post" id="formId" >
    <input type='hidden' name='action' value='fino_vpa'/>
    
    <div class="row my-2 p-4 rounded table-responsive was-validated">
        <script>
        $(document).ready(function(){ 
            <? if((isset($data['ErroFocus'])&& $data['ErroFocus'])){ ?>
                    $( "input[name=<?=$data['ErroFocus']?>], #<?=$data['ErroFocus']?>" ).focus();
            <? }?>
        });
        </script>
        <? if((isset($data['Error'])&& $data['Error'])){ ?>
            <div class="alert alert-danger alert-dismissible my-2">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <strong>Error!</strong>
                <?=prntext($data['Error'])?>
            </div>
        <? }?>

        <? if((isset($data['sucess'])&& $data['sucess'])){ ?>
            <div class="alert alert-success alert-dismissible my-2">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <strong>Result: </strong>
                <?print_r(@$data['sucess']);?>
            </div>
        <? }?>

        <? if((isset($_SESSION['msgsuccess'])&& $_SESSION['msgsuccess'])){ ?>
            <div class="alert alert-success alert-dismissible my-2">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <strong>Success! </strong>
                <?=$_SESSION['msgsuccess']?>
            </div>
        <? 
        unset($_SESSION['msgsuccess']); 
        }
        ?>
      
        
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="clientTxnId"
                value="<?=(@$post['clientTxnId']?prntext(@$post['clientTxnId']):'');?>"
                id="clientTxnId" title="Client Txn Id Ex. <?='13'.date('ymdHis')?>"  minlength="2" class="form-control is-invalid" required >
            <label for="clientTxnId">Client Txn Id <font class="fst-italic fw-lighter" size="1">Ex. <?='13'.date('ymdHis')?></font></label>
        </div>
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="serviceId"
                value="<?=(@$post['serviceId']?prntext(@$post['serviceId']):'9001');?>"
                id="serviceId" title="Service Id Ex. 9001"  minlength="2" class="form-control is-invalid" required >
            <label for="serviceId">Service Id <font class="fst-italic fw-lighter" size="1">Ex. 9001</font></label>
        </div>

        
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="mobilenumber"
                value="<?=(@$post['mobilenumber']?prntext(@$post['mobilenumber']):'');?>"
                id="mobilenumber" title="Mobile Number Ex. 918888855555"  minlength="2" class="form-control is-invalid" required >
            <label for="mobilenumber">Mobile Number <font class="fst-italic fw-lighter" size="1">Ex. 918888855555</font></label>
        </div>
      

        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="vpasubstring"
                value="<?=(@$post['vpasubstring']?prntext(@$post['vpasubstring']):'');?>"
                id="vpasubstring"  title="VPA Substring Ex. deepti" minlength="2" class="form-control is-invalid" required >
            <label for="vpasubstring">VPA Substring <font class="fst-italic fw-lighter" size="1">Ex. deepti</font></label>
        </div>

        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="firstname"
                value="<?=(@$post['firstname']?prntext(@$post['firstname']):'');?>"
                id="firstname"  title="First Name Ex. Deepti" minlength="2" class="form-control is-invalid" required >
            <label for="firstname">First Name <font class="fst-italic fw-lighter" size="1">Ex. Deepti</font></label>
        </div>

        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="lastname"
                value="<?=(@$post['lastname']?prntext(@$post['lastname']):'');?>"
                id="lastname"  title="Last Name Ex. Tyagi" minlength="2" class="form-control is-invalid" required >
            <label for="lastname">Last Name <font class="fst-italic fw-lighter" size="1">Ex. Tyagi</font></label>
        </div>

        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="accountnumber"
                value="<?=(@$post['accountnumber']?prntext(@$post['accountnumber']):'');?>"
                id="accountnumber"  title="Account Number Ex. 4311978921" minlength="2" class="form-control is-invalid" required >
            <label for="accountnumber">Account Number <font class="fst-italic fw-lighter" size="1">Ex. 4311978921</font></label>
        </div>
        
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="ifsc"
                value="<?=(@$post['ifsc']?prntext(@$post['ifsc']):'');?>"
                id="ifsc"  title="IFSC Code Ex. KKBK0000638" minlength="2" class="form-control is-invalid" required >
            <label for="ifsc">IFSC Code<font class="fst-italic fw-lighter" size="1">Ex. KKBK0000638</font></label>
        </div>
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="accounttype"
                value="<?=(@$post['accounttype']?prntext(@$post['accounttype']):'SAVINGS');?>"
                id="accounttype"  title="Account Type Ex. SAVINGS" minlength="2" class="form-control is-invalid" required >
            <label for="accounttype">Account Type <font class="fst-italic fw-lighter" size="1">Ex. SAVINGS</font></label>
        </div>
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="mcccode"
                value="<?=(@$post['mcccode']?prntext(@$post['mcccode']):'7407');?>"
                id="mcccode" title="MCC Code Ex. 7407"  minlength="2" class="form-control is-invalid" required >
            <label for="mcccode">MCC Code <font class="fst-italic fw-lighter" size="1">Ex. 7407</font></label>
        </div>
      
        <div class="input-field col-sm-3 my-2 px-1 hide">
            <input type="text" name="franchisename"
                value="<?=(@$post['franchisename']?prntext(@$post['franchisename']):'');?>"
                id="franchisename" title="Franchise Name Ex. TV Showroom - Kharghar"  minlength="4" class="form-control is-invalid"  >
            <label for="franchisename">Franchise Name <font class="fst-italic fw-lighter" size="1">Ex. TV Showroom - Kharghar</font></label>
        </div>
      
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="brandname"
                value="<?=(@$post['brandname']?prntext(@$post['brandname']):'FINO UPI');?>"
                id="brandname" title="Brand Name Ex. FINO UPI"  minlength="2" class="form-control is-invalid" required >
            <label for="brandname">Brand Name <font class="fst-italic fw-lighter" size="1">Ex. FINO UPI</font></label>
        </div>

        <div class="input-field col-sm-3 my-2 px-1 hide">
            <input type="text" name="Settlement_Account"
                value="<?=(@$post['Settlement_Account']?prntext(@$post['Settlement_Account']):'');?>"
                id="Settlement_Account" title="Initiation Mode Ex. 6662132322424212"  minlength="2" class="form-control is-invalid"  >
            <label for="Settlement_Account">Settlement Account <font class="fst-italic fw-lighter" size="1">Ex. 6662132322424212</font></label>
        </div>
      
        <div class="input-field col-sm-3 my-2 px-1 hide">
            <input type="text" name="Settlement_IFSC"
                value="<?=(@$post['Settlement_IFSC']?prntext(@$post['Settlement_IFSC']):'FINO00111123');?>"
                id="Settlement_IFSC" title="Settlement_IFSC Ex. FINO00111123"  minlength="2" class="form-control is-invalid" required_XX >
            <label for="Settlement_IFSC">Settlement IFSC <font class="fst-italic fw-lighter" size="1">Ex. FINO00111123</font></label>
        </div>
      
      
        <div class="input-field col-sm-3 my-2 px-1 hide">
            <input type="text" name="Bank_Name"
                value="<?=(@$post['Bank_Name']?prntext(@$post['Bank_Name']):'Fino payments Bank');?>"
                id="Bank_Name" title="Bank Name Ex. Fino payments Bank"  minlength="2" class="form-control is-invalid" required_XX >
            <label for="Bank_Name">Bank Name <font class="fst-italic fw-lighter" size="1">Ex. Fino payments Bank</font></label>
        </div>
        
        <div class="input-field col-sm-3 my-2 px-1 hide">
            <input type="text" name="Bene_Name"
                value="<?=(@$post['Bene_Name']?prntext(@$post['Bene_Name']):'');?>"
                id="Bene_Name" title="Bene Name Ex. Rahul Shetty"  minlength="2" class="form-control is-invalid" required_XX >
            <label for="Bene_Name">Bene Name <font class="fst-italic fw-lighter" size="1">Ex. Rahul Shetty</font></label>
        </div>
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="MDR_Per"
                value="<?=(@$post['MDR_Per']?prntext(@$post['MDR_Per']):'1');?>"
                id="MDR_Per" title="MDR Per Ex. 1"  minlength="2" class="form-control is-invalid" required >
            <label for="MDR_Per">MDR Per <font class="fst-italic fw-lighter" size="1">Ex. 1</font></label>
        </div>
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="Minimum_Charge"
                value="<?=(@$post['Minimum_Charge']?prntext(@$post['Minimum_Charge']):'0.01');?>"
                id="Minimum_Charge" title="Minimum Charge Ex. 0.01"  minlength="2" class="form-control is-invalid" required >
            <label for="Minimum_Charge">Minimum Charge <font class="fst-italic fw-lighter" size="1">Ex. 0.01</font></label>
        </div>
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="MDR_Type"
                value="<?=(@$post['MDR_Type']?prntext(@$post['MDR_Type']):'P');?>"
                id="MDR_Type" title="MDR Type Ex. P"  minlength="2" class="form-control is-invalid" required >
            <label for="MDR_Type">MDR Type <font class="fst-italic fw-lighter" size="1">Ex. P</font></label>
        </div>
    
        
        
        
        <div class="col-sm-12 text-center my-2">
            
            <button class="btn btn-primary my-1" type="submit" name="send" id="form_generate_code" value="Generate Fino VPA" ><i class="<?=@$data['fwicon']['code'];?>" title="Generate Fino VPA" ></i></button>
            
            <?/*?>
            <a class="btn btn-primary my-1"  href="<?=@$data['Host'];?>/developers<?=@$data['ex']?>" name="change" value="Developer_Page" target="_blank" ><i class="<?=@$data['fwicon']['book-reader'];?>" title="Developer Page"></i></a> 
            <?*/?>
            
        </div>
    </div>
  </form></div>
<!--</div>-->
<script>
function storetypes(thisScl,theValue,theTitle){
	//alert('ok');
	//alert(theValue+'\r\n'+theTitle+'\r\n'+thisScl.title);
}

$(document).ready(function(){
	$("#storeType").change(function() {
	   var selectedItem = $(this).val();
	   var titles= $('option:selected', this).attr('data-title');
	   
	   $("#public_key").val(selectedItem);
	   $("#terNO").val(titles);
	   
	   
	  // alert(selectedItem+'\r\n'+titles);
	   
	   //console.log(abc,selectedItem);
	 });
	 //$('#storeType').trigger('change');
	 $("#storeType option:eq(2)").attr('selected','selected').trigger('change');
	 //ccnof('4242424242424242');
	 //ccnof('5531886652142950');
});



</script>
<script>

$('#form_submit_XX').click(function(){
	$('#formId').attr('action', '<?=@$data['Host'];?>/checkout<?=@$data['ex'];?>');
})

$('#form_generate_code_XX').click(function(){
	$('#formId').attr('action', '<?=@$data['Host'];?>/user/generate_code<?=@$data['ex'];?>');
});



</script>
<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
