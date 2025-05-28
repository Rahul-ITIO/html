<?
// my website id => generate api code for Intigration 
if(isset($data['ScriptLoaded'])){ ?>
<?
if(isset($_REQUEST['hide_comment'])&&$_REQUEST['hide_comment']==2){}else{}

$get_q='';
if(isset($_GET['admin'])&&isset($_GET['bid'])){
	$get_q='&admin='.$_GET['admin'].'&bid='.$_GET['bid'];
}
$curl_opt=0;
if(isset($_GET['c'])&&isset($_GET['c'])){
	$curl_opt=1;
}
?>
<style>
.form-control:disabled, .form-control[readonly] {
    /*background-color: var(--color-2) !important;*/
      opacity: 1;
}
</style>
<script>


function CopyToClipboard2(text) {
			text=$(text).text();
			
			var $txt = $('<textarea />');

            $txt.val(text)
                .css({ width: "1px", height: "1px" })
                .appendTo('body');

            $txt.select();
			

            if (document.execCommand('copy')) {
                $txt.remove();
				alert("Copied");
            }
	}
    

function textAreaAdjust(o) {
  o.style.height = "1px";
  o.style.height = (10+o.scrollHeight)+"px";
}

	$(document).ready(function() {
		
		$(".textAreaAdjust").trigger("keyup");
		
		

	});
	
</script>
<?
if(isset($data['con_name'])&&$data['con_name']=='clk'){
	$developers='docs';
}else {
	$developers='developers';
}
?>
<div class="container border border-light border-3 px-0">
  <div class="row my-2 border border-primary rounded border-1 mx-2 clr-opal">
    <div class="col-sm-6 my-2">
      <p><strong>Copy This Code And Paste Into Your Page:</strong></p>
    </div>
    <div class="col-sm-6 text-end"><? if(!isset($_REQUEST['terNO'])||@$_REQUEST['terNO']==""){ ?> <a href="<?=$data['USER_FOLDER'];?>/generate_code<?=$data['ex']?>?action=store<? if(isset($get_q)) echo $get_q;?><?=(isset($_GET['hide_comment']))?"":"&hide_comment=1";?>&id=<?=@$_GET['id'];?>" class="nopopup btn btn-primary btn-sm my-2">
      <?=(isset($_GET['hide_comment']))?"<i class='".$data['fwicon']['eye-solid']."'></i> Show Comment":"<i class='".$data['fwicon']['eye-slash']."'></i> Remove Comment";?>
      </a> <? } ?><a href="<?=$data['Host'];?>/<?=($developers);?><?=$data['ex']?>" target="_blank" class="nopopup btn btn-primary btn-sm  my-2"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Developer Api</a></div>
  </div>
  <table class="table">
    <tr>
      <td class="capl">
      </td>
    </tr>
    <tr>
		<td class="text-center text-white my-2 ">
	  
			<strong>CODE #1 - Using POST method:</strong> 

			<a class="nopopup btn-sm my-2"  onclick="CopyToClipboard2('#postMethod')"><i class="<?=$data['fwicon']['copy'];?> text-white my-2" title="Copy code"></i></a>
			
			<form method="post" target="_blank" action="<?=$data['USER_FOLDER'];?>/generate_code<?=$data['ex']?>" style="padding: 0;margin: 0;display: inline-block;">
				<input type="hidden" name="download" value="1" />
				<input type="hidden" name="terNO" value="<?=@$_REQUEST['terNO']?>" />
				<textarea class="hide" name="downloadHtml"  rows="10"  readonly ><?=@$post['PostHtmlCode']?></textarea>
				
				<button type="submit" name="send" value="send" class="btn btn-sm btn-primary showbutton ms-2 mb-2 float-endX" title="Download to Generate Code" data-bs-toggle="tooltip" data-bs-placement="top" ><i class="<?=$data['fwicon']['download'];?> fa-fw"></i>Download</button>
			</form>
			
			<?/*?>
			<a href="<?=$data['USER_FOLDER']?>/generate_code<?=$data['iex'];?>?download=1&terNO=<?=@$_REQUEST['terNO']?>&send=1" target="_blank" title="Download backup code" class="btn btn-sm btn-primary showbutton ms-2 mb-2 float-endX"><i class="<?=$data['fwicon']['download'];?> "></i> Download</a>
			<?*/?>
			
			<textarea id="postMethod" class="textAreaAdjust form-control nst bg-primary text-white" onkeyup="textAreaAdjust(this)" rows="10"  readonly><?=@$post['PostHtmlCode']?></textarea>
		</td>
    </tr>
<?
if($post['addressParam'] || @$curl_opt)
{
	
?>
	<tr>
      <td class="text-center text-white  mt-2 mb-2"><strong>CODE #2 - Using PHP Curl:</strong> <a class="nopopup btn btn-sm my-2"  onclick="CopyToClipboard2('#curlPhp')"><i class="<?=$data['fwicon']['copy'];?> text-white" title="Copy code"></i></a>
        <textarea id="curlPhp" class="textAreaAdjust form-control nst bg-primary text-white" onkeyup="textAreaAdjust(this)" rows="10" readonly>
&lt;?php
$gateway_url="<?=$data['Host'];?>/<?=$data['api_url']?><?=$data['ex']?>";

$curlPost=array();

$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$source_url=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI']; 
<?=$post['phpCurlCode'];?>

$curl_cookie="";
$curl = curl_init(); 
curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
curl_setopt($curl, CURLOPT_URL, $gateway_url);
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
curl_setopt($curl, CURLOPT_REFERER, $source_url);
curl_setopt($curl, CURLOPT_POST, 1);
curl_setopt($curl, CURLOPT_POSTFIELDS, $curlPost);
curl_setopt($curl, CURLOPT_TIMEOUT, 200);
curl_setopt($curl, CURLOPT_HEADER, 0);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($curl, CURLOPT_COOKIE,$curl_cookie);
$response = curl_exec($curl);

$results = json_decode($response,true);

if((isset($results["Error"]) && ($results["Error"]))||(isset($results["error"]) && ($results["error"]))){
	print_r($results); exit;
}
elseif(!isset($results)){
	echo $response; exit;
}

$status_nm = (int)($results["status_nm"]);

$sub_query = http_build_query($results);

if(isset($results["authurl"]) && $results["authurl"]){ 
	//3D Bank URL
	
	$redirecturl = $results["authurl"];
	header("Location:".$redirecturl);exit;
}elseif($status_nm==1 || $status_nm==9){ 
	// 1:Approved/Success,9:Test Transaction

	$redirecturl = $curlPost["success_url"];
	if(strpos($redirecturl,'?')!==false){
		$redirecturl = $redirecturl.'&'.$sub_query;
	}else{
		$redirecturl = $redirecturl.'?'.$sub_query;
	}
			
	header("Location:$redirecturl");exit;

}elseif($status_nm==2 || $status_nm==22 || $status_nm==23) {   
	// 2:Declined/Failed, 22:Expired, 23:Cancelled
	
	
	$redirecturl = $curlPost["error_url"];
	if(strpos($redirecturl,'?')!==false){
		$redirecturl = $redirecturl.'&'.$sub_query;
	}else{
		$redirecturl = $redirecturl.'?'.$sub_query;
	}
			
	header("Location:$redirecturl");exit;

}else{ 
	// Pending
	
	$redirecturl = $referer;
	if(strpos($redirecturl,'?')!==false){
		$redirecturl = $redirecturl.'&'.$sub_query;
	}else{
		$redirecturl = $redirecturl.'?'.$sub_query;
	}
			
	header("Location:$redirecturl");exit;
	

}
?&gt;
	</textarea></td>
    </tr>
    <tr>
      <td class="text-center text-white mt-2 mb-2" ><strong>CODE #3 - Using GET method:</strong> <a class="nopopup btn btn-sm my-2" onclick="CopyToClipboard2('#getMethod')"><i class="<?=$data['fwicon']['copy'];?> text-white" title="Copy code"></i></a>
        <textarea id="getMethod" class="textAreaAdjust form-control nst bg-primary text-white" onkeyup="textAreaAdjust(this)" rows="10" readonly>&lt;?php
$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$getSourceUrl=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
define("source_url", $getSourceUrl);
?&gt;

<?=$post['GetHtmlCode']?>
</textarea></td>
    </tr>
<?

}
?>  
<? if(!isset($post['is_admin'])){ ?>
    <tr>
      <td><table class="frame table text-center">
          <tr>
            <td><a class="btn btn-primary" href="javascript:history.back()"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a>&nbsp;<a class="btn btn-primary" href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>"><i class="<?=$data['fwicon']['home'];?>" aria-hidden="true"></i> Account Overview</a></td>
          </tr>
        </table></td>
    </tr>
<? } ?>
  </table>
</div>
<script>
$(document).ready(function(){
	
    $('#paymentForm').click(function(){
	   $('#paymentFormTd input[name="price"]').val('10.00');
	   $('#paymentFormTd input[name="product_name"]').val('iPhone7');
	   $('#paymentFormTd input[name="ccholder"]').val('First Name');
	   $('#paymentFormTd input[name="ccholder_lname"]').val('Last Name');
	   $('#paymentFormTd input[name="email"]').val('email@gmail.com');
	   $('#paymentFormTd input[name="email_re_enter"]').val('email@gmail.com');
	   $('#paymentFormTd input[name="bill_name"]').val('Full Name Last Name');
	   $('#paymentFormTd input[name="bill_street_1"]').val('Address 1');
	   $('#paymentFormTd input[name="bill_street_2"]').val('Address 2');
	   $('#paymentFormTd input[name="bill_city"]').val('City');
	   $('#paymentFormTd input[name="bill_state"]').val('State');
	   $('#paymentFormTd input[name="bill_country"]').val('County');
	   $('#paymentFormTd input[name="bill_zip"]').val('111111');
	   $('#paymentFormTd input[name="bill_phone"]').val('Phone');
	   $('#paymentFormTd input[name="reference"]').val('Reference');
    });
	
    
});
	
</script>

<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
<div class='pro_status'></div>
