<? if(isset($data['ScriptLoaded'])){ ?>


<? if(!$data['PostSent']){ ?>
<style>
.fa-star-of-life {font-size: 8px !important;}
.container.mt-2.border.rounded {
    word-wrap: anywhere !important;
}
</style>
<meta charset="UTF-8">
<div class="container mt-2 border rounded bg-primary text-white clearfix_ice" >
  <div class="my-2 vkg" >
    <h4 class=""><i class="<?=@$data['fwicon']['payment-button'];?>" aria-hidden="true"></i> Generate Canara VPA </h4>
  </div>


<? 
if($data['con_name']=='clk'){
	$style_display='display:none;';
 }
 else{
	 $style_display='';
 }
 //echo "<br/>con_name=>".$data['con_name']."<br/><br/>";

 
//if(!isset($post['send'])&&isset($_REQUEST['sqp'])&&$_REQUEST['sqp']==2) 
if(!isset($post['send'])) 
{
    //MjcyXzEwMzhfMjAyNDA4MTMxMTEwMjk
    $post_demo=["public_key"=>"MjcyXzEwMzhfMjAyNDA4MTMxMTEwMjk", "mid"=>"SKYWALK001", "account_number"=>"120029938874", "bank_name"=>"Canara Bank", "mcc"=>"6012", "ifsc_code"=>"CNRB0003896", "company_name"=>"SK PRIVATE LIMITED", "sid"=>"LETSPE0014", "mobile_number"=>"9568315028"];
    $post=array_merge($post, $post_demo);
}


if(isset($post['send']))
{
    $vqp='';
    if(isset($_REQUEST['vqp'])&&$_REQUEST['vqp']>0) $vqp='vqp=1';

    $hostGet='https://can-webhook.web1.one';
    
    if($data['localhosts']==true){
        $hostGet=$data['Host'];
    }
    $script_url=$hostGet.'/checkout?'.$vqp;
    $gateway_url=$hostGet.'/directapi?'.$vqp;
    //$gateway_url=$hostGet.'/directapi?actionajax=ajaxQrCode&acquirer=83&mop=QRINTENT&dtest=1';
    //$gateway_url=$hostGet.'/checkout?actionajax=ajaxQrCode&acquirer=83&mop=QRINTENT&dtest=1';

    $dataPost=array();
    if(!isset($_POST['public_key'])||empty($_POST['public_key'])) $_POST['public_key']='MjcyXzEwMzhfMjAyNDA4MTMxMTEwMjk';

    if(@$vqp){
        echo "<br/><hr/><br/>POST REQUEST=><br/>"; print_r($_POST);
    }

    $dataPost=@$_POST;

	$byusername=" - Admin";
	if(isset($_SESSION['sub_admin_id'])){
		$byusername=" - ".$_SESSION['username'];
	}

    $protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
    $referer=$protocol.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];

    //<!--Optional -->
    //$dataPost["acquirer_id"]="83";
    $dataPost["acquirer"]="83";

    //<!--default (fixed) value * default -->

    $dataPost["integration-type"]="s2s";
    //$dataPost["unique_reference"]="Y";
    if($data['localhosts']) $dataPost["bill_ip"]='122.176.92.114';
    else $dataPost["bill_ip"]=($_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);
    $dataPost["source"]="s2s_canara_vpa_create_request";
    $dataPost["source_url"]=$referer;

    //<!--product bill_amt,bill_currency and product name * by cart total bill_amt -->

    $dataPost["bill_amt"]="11.11";
    $dataPost["bill_currency"]="INR";
    if(isset($_REQUEST['batch_id'])&&trim($_REQUEST['batch_id']))
    {
        $dataPost["product_name"]="Enq. VPA Request ".@$byusername;
        $dataPost["fullname"]="Enq. VPA Request ".@$byusername;
    }
    else 
    {
        $dataPost["product_name"]="Create VPA Request ".@$byusername;
        $dataPost["fullname"]="Create VPA Request".@$byusername;
    }

    //<!--billing details of .* customer -->

    
    $dataPost["bill_email"]="devops@itio.in";
    $dataPost["bill_address"]="New Delhi";
    $dataPost["bill_city"]="New Delhi";
    $dataPost["bill_state"]="DL";
    $dataPost["bill_country"]="IN";
    $dataPost["bill_zip"]="447602";
    $dataPost["bill_phone"]="+919999999999";
    //$dataPost["reference"]="23120228"; // should be unique by time() or your reference is unique
    $dataPost["webhook_url"]=$hostGet."/responseDataList/?urlaction=webhook_url";
    $dataPost["return_url"]=$hostGet."/responseDataList/?urlaction=return_url";
    $dataPost["checkout_url"]=@$referer;

    $dataPost["mop"]="CC";
    $dataPost["ccno"]="5438898014560229";
    $dataPost["ccvv"]="123";
    $dataPost["month"]="10";
    $dataPost["year"]="31";


   // $dataPost["step"]="2";
    //$dataPost["status"]="2";
    $dataPost["actionajax"]="ajaxQrCode";
    $dataPost["mop"]="QRINTENT";
    $dataPost["os"]="web";

    if(isset($_REQUEST['batch_id'])&&trim($_REQUEST['batch_id'])) $dataPost["vpaEnqRequestPost"]="1";
    else $dataPost["vpaRequestPost"]="1";
    

    $curl_post=http_build_query($dataPost);

    
    //$curl_url=$hostGet.'/directapi?actionType=&actionUrl=&integration-type=Checkout&terNO=&return_url=https%3A%2F%2Fcan-webhook.web1.one%2FresponseDataList%2F%3Furlaction%3Dsuccess&webhook_url=https%3A%2F%2Fcan-webhook.web1.one%2FresponseDataList%2F%3Furlaction%3Dnotify&product_name=Test+Product&fullname=Create+VPA+Request&bill_email=test5134%40test.com&bill_address=161+Kallang+Way&bill_city=New+Delhi&bill_state=Delhi&bill_country=IN&bill_zip=110001&bill_phone=919821125134&bill_currency=INR&bill_ip=122.176.92.114&ccno=5438898014560229&ccvv=564&month=10&year=31&country_name=&REMOTE_ADDR=122.176.92.114&http_referer=https%3A%2F%2Fcan-webhook.web1.one%2Fp%2Fp&product=Test%20Product&step=2&fullname=Test%20Full%20Name&bill_email=test5134%40test.com&bill_address=161%20Kallang%20Way&bill_city=New%20Delhi&bill_state=Delhi&bill_country=IN&bill_country_name=&bill_zip=110001&bill_phone=919821125134&payment_mode=&bill_fees=&bussiness_url=&status=2&aurl=&source=&actionajax=ajaxQrCode&bill_amt=11.11&acquirer=83&mop=QRINTENT&dtest=1&';

    $script_url=@$script_url.'&'.@$curl_post; 

    if(@$vqp){
        echo "<br/><br/>curl_url=><br/>".@$script_url; 
        echo "<br/><br/>gateway_url=><br/>"; print_r(@$gateway_url);
    }

    /*
    echo"
        <script>
            window.open('$script_url', '_blank');return false;
        </script>
    ";
    */
    //exit;

    $curl_set=1;
    if($curl_set==1)
    {
        //S2S via curl method 
       

        $curl_cookie="";
        $curl = curl_init(); 
        curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
        curl_setopt($curl, CURLOPT_URL, @$gateway_url);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_ENCODING, '');
        curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
        curl_setopt($curl, CURLOPT_REFERER, $referer);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $dataPost);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 10);
        curl_setopt($curl, CURLOPT_MAXREDIRS, 10);
	    curl_setopt($curl, CURLOPT_TIMEOUT, 60);	

        $response = curl_exec($curl);
        curl_close($curl);

        //$results = json_decode($response,true);

        echo "<br/><hr/><br/>API POST RESPONSE=><br/>"; print_r($response);

    }

    echo "<br/><br/><hr/>";

}

 ?>
 <!-- novalidate  -->
  <form method="post" id="formId" >
    <input type='hidden' name='action' value='canara_vpa'/>
    
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
            <input type="text" name="public_key"
                value="<?=(@$post['public_key']?prntext(@$post['public_key']):'');?>"
                id="public_key" title="<?=$data['SiteName']?> <?=@label_namef('public_key');?> Ex. MjcyXzEwMzhfMjAyNDA4MTMxMTEwMjk"  minlength="2" class="form-control is-invalid" required >
            <label for="public_key"><?=@label_namef('public_key');?> <font class="fst-italic fw-lighter" size="1">Ex. MjcyXzEwMzhfMjAyNDA4MTMxMTEwMjk</font></label>
        </div>

        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="mid"
                value="<?=(@$post['mid']?prntext(@$post['mid']):'');?>"
                id="mid"  title="<?=@label_namef('mid');?> Ex. SKYWALK001" minlength="2" class="form-control is-invalid" required >
            <label for="mid"><?=@label_namef('mid');?> <font class="fst-italic fw-lighter" size="1">Ex. SKYWALK001</font></label>
        </div>
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="account_number"
                value="<?=(@$post['account_number']?prntext(@$post['account_number']):'120029938874');?>"
                id="account_number" title="<?=@label_namef('account_number');?> Ex. 120029938874"  minlength="2" class="form-control is-invalid" required >
            <label for="account_number"><?=@label_namef('account_number');?> <font class="fst-italic fw-lighter" size="1">Ex. 120029938874</font></label>
        </div>

        
        
      

       


        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="bank_name"
                value="<?=(@$post['bank_name']?prntext(@$post['bank_name']):'');?>"
                id="bank_name"  title="<?=@label_namef('bank_name');?> Ex. Canara Bank" minlength="2" class="form-control is-invalid" required >
            <label for="bank_name"><?=@label_namef('bank_name');?> <font class="fst-italic fw-lighter" size="1">Ex. Canara Bank</font></label>
        </div>

        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="mcc"
                value="<?=(@$post['mcc']?prntext(@$post['mcc']):'');?>"
                id="mcc"  title="<?=@label_namef('mcc');?> Ex. 4311978921" minlength="2" class="form-control is-invalid" required >
            <label for="mcc"><?=@label_namef('mcc');?> <font class="fst-italic fw-lighter" size="1">Ex. 4311978921</font></label>
        </div>
        
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="ifsc_code"
                value="<?=(@$post['ifsc_code']?prntext(@$post['ifsc_code']):'');?>"
                id="ifsc_code"  title="<?=@label_namef('ifsc_code');?> Ex. CNRB0003896" minlength="2" class="form-control is-invalid" required >
            <label for="ifsc_code"><?=@label_namef('ifsc_code');?><font class="fst-italic fw-lighter" size="1">Ex. CNRB0003896</font></label>
        </div>

        
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="company_name"
                value="<?=(@$post['company_name']?prntext(@$post['company_name']):'');?>"
                id="company_name"  title="<?=@label_namef('company_name');?> Ex. SK PRIVATE LIMITED" minlength="2" class="form-control is-invalid" required >
            <label for="company_name"><?=@label_namef('company_name');?> <font class="fst-italic fw-lighter" size="1">Ex. SK PRIVATE LIMITED</font></label>
        </div>
      
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="sid"
                value="<?=(@$post['sid']?prntext(@$post['sid']):'LETSPE0014');?>"
                id="sid"  title="<?=@label_namef('sid');?> Ex. LETSPE0014" minlength="2" class="form-control is-invalid" required >
            <label for="sid"><?=@label_namef('sid');?> <font class="fst-italic fw-lighter" size="1">Ex. LETSPE0014</font></label>
        </div>
      

        

        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="mobile_number"
                value="<?=(@$post['mobile_number']?prntext(@$post['mobile_number']):'');?>"
                id="mobile_number" title="<?=@label_namef('mobile_number');?> Ex. 918888855555"  minlength="2" class="form-control is-invalid" required >
            <label for="mobile_number"><?=@label_namef('mobile_number');?> <font class="fst-italic fw-lighter" size="1">Ex. 918888855555</font></label>
        </div>
        
        
        <?if(isset($post['send'])) 
        {
        ?>
        <div class="input-field col-sm-3 my-2 px-1">
            <input type="text" name="batch_id"
                value="<?=(@$post['batch_id']?prntext(@$post['batch_id']):'');?>"
                id="batch_id" title="<?=@label_namef('batch_id');?> Ex. 172482312266806189"  minlength="14" class="form-control is-invalid" >
            <label for="batch_id"><?=@label_namef('batch_id');?> <font class="fst-italic fw-lighter" size="1">Ex. 172482312266806189</font></label>
        </div>
        <?
        }
        ?>
        
        <div class="col-sm-12 text-center my-2">
            
            <button class="btn btn-primary my-1" type="submit" name="send" id="form_generate_code" value="Generate Canara VPA" ><i class="<?=@$data['fwicon']['code'];?>" title="Generate Canara VPA" ></i></button>
            
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
