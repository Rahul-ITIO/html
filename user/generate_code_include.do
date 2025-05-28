<?
//Generate Code for Include 

$curlPost["cmnt_1"]="Your {$mywebsiteNm} Public Key";
$curlPost["public_key"]=$post['public_key'];

if(isset($_POST['public_key'])&&$_POST['public_key'])
    $curlPost["public_key"]=$_POST['public_key'];

$curlPost["cmnt_2"]="Your {$mywebsiteNm} Id";
$curlPost["terNO"]=$post['terNO']; 

if(isset($_REQUEST['terNO'])&&$_REQUEST['terNO'])
    $curlPost["terNO"]=$post['terNO']=$_REQUEST['terNO'];

//$curlPost["cmnt_2.1"]="Optional";
//$curlPost["acquirer_id"]=""; 



$curlPost["cmnt_4"]="product bill_amt,bill_currency and product name * by cart total amount";

$curlPost["cmnt_4.1"]="This is the amount to be charged from card";
if(isset($post['bill_amt'])&&$post['bill_amt']){ $p_amt=$post['bill_amt'];}else{ $p_amt="10.00";}
$curlPost["bill_amt"]="$p_amt";

if(isset($_POST['bill_currency'])&&$_POST['bill_currency'])
    $post['default_currency']=$_POST['bill_currency'];

if(isset($post['default_currency'])&&$post['default_currency']){ $p_curr=get_currency($post['default_currency'],1);}else{ $p_curr="USD";}
$curlPost["cmnt_4.2"]="This is the specified currency to charge via customer";
$curlPost["bill_currency"]="$p_curr";
$bill_currency=get_currency($p_curr);


if(isset($product_q['name'])&&$product_q['name']){ $p_prd=$product_q['name'];}else{ $p_prd="Test Product";}
$curlPost["cmnt_4.3"]="This is the specified Product Name to purchased.";
$curlPost["product_name"]="TEST - $p_prd";

if(isset($_POST['product_name'])&&$_POST['product_name'])
    $curlPost["product_name"]=$_POST['product_name'];



$curlPost["cmnt_5"]="billing details of .* customer";
if(isset($post['fname'])&&$post['fname']){ $p_name="TEST - ".$post['fname'].' '.$post['lname'];}else{ $p_name="Test Full Name";}

    $curlPost["cmnt_5.1"]="This is the fullname of the full name or the customer";
    $curlPost["fullname"]="$p_name";
    
    if(isset($_POST['fullname'])&&$_POST['fullname'])
    $curlPost["fullname"]=$_POST['fullname'];


$p_email="test.".date('s')."@test.com";

/*
if(isset($product_q['transaction_notification_email'])&&$product_q['transaction_notification_email']){ $p_email=$product_q['transaction_notification_email'];}
elseif(isset($product_q['customer_service_email'])&&$product_q['customer_service_email']){ $p_email=$product_q['customer_service_email'];}
elseif(isset($post['email'])&&$post['email']){ $p_email=$post['email'];}else{ $p_email="test.".date('is')."@gmail.com";}

$p_email=encrypts_decrypts_emails(trim($p_email),2);
*/

$curlPost["cmnt_5.3"]="This is the bill_email address of the customer.";
$curlPost["bill_email"]="$p_email";

if(isset($_POST['bill_email'])&&$_POST['bill_email'])
    $curlPost["bill_email"]=$_POST['bill_email'];

if($post['addressParam']){
    
    if(isset($post['address'])&&$post['address']){ $p_add1=$post['address'];}
    elseif(isset($post['bill_address'])&&$post['bill_address']){ $p_add1=$post['bill_address'];}
    $curlPost["cmnt_5.4"]="This is the first address of the customer.";
    $curlPost["bill_address"]="$p_add1";
    
    if(isset($_POST['bill_address'])&&$_POST['bill_address'])
    $curlPost["bill_address"]=$_POST['bill_address'];
    
    /*
    if(isset($post['bill_street_2'])&&$post['bill_street_2']){ $p_add2=$post['bill_street_2'];}
    $curlPost["cmnt_5.5"]="This is the scened address of the customer.";
    $curlPost["bill_street_2"]="$p_add2";
    
    */
    
    if(isset($post['bill_city'])&&$post['bill_city']){ $p_cty=$post['bill_city'];}
    $curlPost["cmnt_5.6"]="This is the city of the customer.";
    $curlPost["bill_city"]="$p_cty";
    
    if(isset($_POST['bill_city'])&&$_POST['bill_city'])
    $curlPost["bill_city"]=$_POST['bill_city'];

    
    if(isset($post['bill_state'])&&$post['bill_state']){ $p_stat=$post['bill_state'];}

    $curlPost["cmnt_5.7"]="This is the state of the customer.";
    $curlPost["bill_state"]="$p_stat";
    
    if(isset($_POST['bill_state'])&&$_POST['bill_state'])
    $curlPost["bill_state"]=$_POST['bill_state'];
    
    
    
    if(isset($post['country'])&&$post['country']){ $p_cntr=$post['country'];}
    elseif(isset($post['bill_country'])&&$post['bill_country']){ $p_cntr=$post['bill_country'];}
    
    $curlPost["cmnt_5.8"]="This is the country of the customer for ISO Alpha-2.";
    $curlPost["bill_country"]="$p_cntr";
    
    if(isset($_POST['bill_country'])&&$_POST['bill_country'])
    $curlPost["bill_country"]=$_POST['bill_country'];
    
    if(isset($post['bill_zip'])&&$post['bill_zip']){ $p_zip=$post['bill_zip'];}
    $curlPost["cmnt_5.9"]="This is the zip code of the customer.";
    $curlPost["bill_zip"]="$p_zip";
    
    if(isset($_POST['bill_zip'])&&$_POST['bill_zip'])
    $curlPost["bill_zip"]=$_POST['bill_zip'];

}

if(isset($product_q['customer_service_no'])&&$product_q['customer_service_no']){ $p_phone=$product_q['customer_service_no'];}
elseif(isset($post['phone'])&&$post['phone']){ $p_phone=$post['phone'];}
elseif(isset($post['bill_phone'])&&$post['bill_phone']){ $p_phone=$post['bill_phone'];}
$curlPost["cmnt_5.10"]="This is the phone number of the customer.";
$curlPost["bill_phone"]="$p_phone";

if(isset($_POST['bill_phone'])&&$_POST['bill_phone'])
    $curlPost["bill_phone"]=$_POST['bill_phone'];



if(isset($post['reference'])&&$post['reference']){ $p_ord=$post['reference'];}else{ $p_ord=date('YmdHis');}
$curlPost["cmnt_6"]="This is the unique reference, unique to the particular transaction being carried out. It is generated by the merchant for every transaction";
$curlPost["reference"]="$p_ord";

if(isset($_POST['reference'])&&$_POST['reference'])
    $curlPost["reference"]=$_POST['reference'];

if(isset($post['webhook_url'])&&$post['webhook_url']){ $p_not=$post['webhook_url'];}else{ $p_not=$post['webhook_url'];}
$curlPost["cmnt_7"]="webhook_url is a url you provide, we send by s2s method to it after the customer process for completes payment and append by curl the response to it as query parameters ex. https://yourdomain.com/notify.php";
$curlPost["webhook_url"]="$p_not";

if(isset($_POST['webhook_url'])&&$_POST['webhook_url'])
    $curlPost["webhook_url"]=$_POST['webhook_url'];

if(isset($post['return_url'])&&$post['return_url']){ $p_succ=$post['return_url'];}else{ $p_succ=$post['return_url'];}
$curlPost["cmnt_8"]="return_url is a url you provide, we redirect to it after the customer completes payment and redirect this url with response to it as query parameters ex. https://yourdomain.com/success.php";
$curlPost["return_url"]="$p_succ";

if(isset($_POST['return_url'])&&$_POST['return_url'])
    $curlPost["return_url"]=$_POST['return_url'];












$PostHtmlCode='';
foreach($curlPost as $key=>$value){
    if(strpos($key,'cmnt_')!==false){
        if(!isset($_GET['hide_comment'])){
            $PostHtmlCode.="\n<!--{$value} -->\n";
        }
    }else{
        $PostHtmlCode.="<input type='hidden' name='{$key}' value='{$value}'/>\n";
    }
}


if((isset($_REQUEST['hide_comment'])&&$_REQUEST['hide_comment']==2)||($is_admin==true)){
    $target="";
    $onclick="";
}else{
    $target="target={$target}";
}

//echo "<br/>Host=>".$data['Host'];exit;

$post['PostHtmlCode']=
    "<!-- {$data['SiteName']} PAYMENT FORM -->\n".
    "<form id='paymentForm' method='post' action='{$data['Host']}/{$data['processall_url']}{$data['ex']}' {$target}>\n".
        $PostHtmlCode.
    "<button class=paynow_link id=paymentsubmit type=submit  {$onclick}>".($API_VER?"PAY NOW":"<div class=pay_l><span class=pay_txt>Total Paid:<span><span class=pay_t2>{$bill_currency}{$curlPost['bill_amt']}<span></div><span class=paynow>Continue to Pay Now</span>".($dba_brand_name?"<div class=pay_r><span class=pay_txt>Pay To:<span><span class=pay_t2>{$dba_brand_name}<span></div>":""))."</button>\n".
    "</form>\n".
    ($API_VER?"":"<style>body{min-height:1200px;}.pay_l{text-align:left;color:#999;}.pay_r{text-align:right;color:#999;}.pay_t2{font-size:36px;color:#505050;}.paynow_link{display:block;width:356px;margin:0 auto;text-decoration:none;font-family:'Open Sans', sans-serif !important;text-align:center; border-radius: 3px;background:#dddddd;border:1px solid #ccc;padding:10px;}.paynow{display:block;background:#012282;border-radius:3px;padding:5px 10px;color:#fff;text-decoration:none;font-size:25px;}.modalpopup_form_popup{display:none;z-index:999999;top:0;left:0;}.modalpopup_form_popup_layer{display:block;position:fixed;z-index:999999;width:100%;height:100%;background:#000;opacity:0.5;top:0;left:0;}.modalpopup_form_popup_body{display:block;position:absolute;z-index:9999999;width:356px;height:1000px;background:#fff;opacity:1;border-radius:5px;left:50%;top:50%;margin:-200px 0 0 -178px;}.modalpopup_form_popup_close{position:absolute;z-index:99;float:right;right:-20px;top:-20px;width:40px;height:40px;font:800 40px/40px 'Open Sans';color:#fff !important;background:#f30606;text-align:center;border-radius:110%;overflow:hidden;cursor:pointer;}</style><div class=modalpopup_form_popup id=modalpopup_form_popup> <div class=modalpopup_form_popup_layer> </div> <div class=modalpopup_form_popup_body> <a class=modalpopup_form_popup_close onclick=document.getElementById('modalpopup_form_popup').style.display='none';>&times;</a><iframe src=about:blank name=modalpopup_form_iframe id=modalpopup_form_iframe frameborder=0 marginwidth=0 marginheight=0 class=modalpopup_form_iframe width=100% height=1000></iframe></div></div>").
    "<!-- {$data['SiteName']} PAYMENT FORM -->"
;
if($post['status']=='crypt'){
  $post['PostHtmlCode']=
     "<!-- {$data['SiteName']} PAYMENT FORM -->\n".
     encrypt($post['PostHtmlCode']).
     "\n<!-- {$data['SiteName']} PAYMENT FORM -->"
  ;
}





$post['OrgPostHtml']=$post['PostHtmlCode'];
$post['PostHtmlCode']=htmlspecialchars($post['PostHtmlCode'], ENT_QUOTES);



$curlPost["cmnt_3.1"]="bill_ip - Internet Protocol. This represents the current IP address of the customer carrying out the transaction";
$curlPost["bill_ip"]=$_SERVER['REMOTE_ADDR']; 

if(isset($_POST['bill_ip'])&&$_POST['bill_ip'])
    $curlPost["bill_ip"]=$_POST['bill_ip'];


$curlPost["cmnt_3.2"]="source_url - Url of Product Page";
$curlPost["source_url"]="https://your_source_url.com";

if(isset($_POST['source_url'])&&$_POST['source_url'])
    $curlPost["source_url"]=$_POST['source_url'];

$curlPost["cmnt_20"]="default value for source and integration-type ";
$curlPost["integration-type"]="GenerateCode_Checkout"; 

if(isset($_POST['integration-type'])&&$_POST['integration-type'])
    $curlPost["integration-type"]=$_POST['integration-type'];

$curlPost["source"]="Get-Method-Host-Redirect-Card-Payment";

if(isset($_POST['source'])&&$_POST['source'])
    $curlPost["source"]=$_POST['source'];

$GetHtmlCode=array();
foreach($curlPost as $key=>$value){
    if(strpos($key,'cmnt_')!==false){
        //$GetHtmlCode.="//<!--{$value} -->\n";
    }else{
        $GetHtmlCode[$key]=$value;
    }
}
$GetHtmlCode=http_build_query($GetHtmlCode);



$post['GetHtmlCode']=
    "<!-- {$data['SiteName']} PAYMENT GET METHOD -->\n".
    "<a class=paynow_link href={$data['Host']}/{$data['processall_url']}{$data['ex']}?{$GetHtmlCode} {$target} {$onclick}>".($API_VER?"PAY NOW":"<div class=pay_l><span class=pay_txt>Total Paid:<span><span class=pay_t2>{$bill_currency}{$curlPost['bill_amt']}<span></div><span class=paynow>Continue to Pay Now</span>".($dba_brand_name?"<div class=pay_r><span class=pay_txt>Pay To:<span><span class=pay_t2>{$dba_brand_name}<span></div>":""))."</a>".
    ($API_VER?"":"<style>body{min-height:1200px;}.pay_l{text-align:left;color:#999;}.pay_r{text-align:right;color:#999;}.pay_t2{font-size:36px;color:#505050;}.paynow_link{display:block;width:300px;margin:0 auto;text-decoration:none;font-family:'Open Sans', sans-serif !important;text-align:center; border-radius: 3px;background:#dddddd;border:1px solid #ccc;padding:10px;}.paynow{display:block;background:#012282;border-radius:3px;padding:5px 10px;color:#fff;text-decoration:none;font-size:25px;}.modalpopup_form_popup{display:none;z-index:999999;top:0;left:0;}.modalpopup_form_popup_layer{display:block;position:fixed;z-index:999999;width:100%;height:100%;background:#000;opacity:0.5;top:0;left:0;}.modalpopup_form_popup_body{display:block;position:absolute;z-index:9999999;width:300px;height:1000px;background:#fff;opacity:1;border-radius:5px;left:50%;top:50%;margin:-200px 0 0 -150px;}.modalpopup_form_popup_close{position:absolute;z-index:99;float:right;right:-20px;top:-20px;width:40px;height:40px;font:800 40px/40px 'Open Sans';color:#fff !important;background:#f30606;text-align:center;border-radius:110%;overflow:hidden;cursor:pointer;}</style><div class=modalpopup_form_popup id=modalpopup_form_popup> <div class=modalpopup_form_popup_layer> </div> <div class=modalpopup_form_popup_body> <a class=modalpopup_form_popup_close onclick=document.getElementById('modalpopup_form_popup').style.display='none';>&times;</a><iframe src=about:blank name=modalpopup_form_iframe id=modalpopup_form_iframe frameborder=0 marginwidth=0 marginheight=0 class=modalpopup_form_iframe width=100% height=1000></iframe></div></div>").
    "\n<!-- {$data['SiteName']} PAYMENT GET METHOD -->"
;
$post['OrgGetHtml']=$post['GetHtmlCode'];
if($post['status']=='crypt'){
  $post['GetHtmlCode']=
     "<!-- {$data['SiteName']} PAYMENT FORM -->\n".
     encrypt($post['GetHtmlCode']).
     "\n<!-- {$data['SiteName']} PAYMENT FORM -->"
  ;
}
$post['GetHtmlCode']=htmlspecialchars($post['GetHtmlCode'], ENT_QUOTES);


    
$curlPost["cmnt_10"]="card details of .* customer";

$curlPost["cmnt_10.1"]="This is the card number on the Debit/Credit card";
$curlPost["ccno"]="4242424242424242";

if(isset($_POST['ccno'])&&$_POST['ccno'])
    $curlPost["ccno"]=$_POST['ccno'];

$curlPost["cmnt_10.2"]="Card security code. This is 3/4 digit code at the back of the customers card, used for web payments.";
$curlPost["ccvv"]="123";

if(isset($_POST['ccvv'])&&$_POST['ccvv'])
    $curlPost["ccvv"]=$_POST['ccvv'];

$curlPost["cmnt_10.3"]="Two-digit number representing the card's expiration month.";
$curlPost["month"]="01";
if(isset($_POST['month'])&&$_POST['month'])
    $curlPost["month"]=$_POST['month'];

$curlPost["cmnt_10.4"]="Two- digit number representing the card's expiration year.";
$curlPost["year"]="30";
if(isset($_POST['year'])&&$_POST['year'])
    $curlPost["year"]=$_POST['year'];


$curlPost["cmnt_20"]="default value for source and integration-type ";
$curlPost["integration-type"]="s2s"; $curlPost["source"]="Curl-Direct-Card-Payment";

//$phpCurlCode="<?&#36;php\n";
$phpCurlCode="";
foreach($curlPost as $key=>$value){
    if(strpos($key,'cmnt_')!==false){
        if(!isset($_GET['hide_comment'])){
            $phpCurlCode.="\n//<!--{$value} -->\n";
        }
    }elseif(strpos($key,'bill_ip')!==false){
        $phpCurlCode.="&#36;curlPost['{$key}']=&#36;_SERVER['REMOTE_ADDR'];\n";
    }elseif(strpos($key,'source_url')!==false){
        $phpCurlCode.="&#36;curlPost['{$key}']=&#36;source_url;\n";
    }else{
        $phpCurlCode.="&#36;curlPost['{$key}']='{$value}';\n";
    }
}

$post['phpCurlCode']=$phpCurlCode;

?>
