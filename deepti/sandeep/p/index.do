<?

include('../config.do');

if((!isset($_SESSION['login_adm'])&&($data['localhosts']==false))){
	//echo('ACCESS DENIED.'); exit;
}

$api_url="directapi";
$processall_url="checkout";
	
//$_SESSION['re_post']['failed_reason']='Do Not Honor Payment Failed.';

unset($_SESSION['login_adm']);unset($_SESSION['adm_login']);

//if(!isset($_SESSION['test_merchant1']))
{
	$test_merchant=$_SESSION['test_merchant1']=select_tablef(" `active`='1' AND `status`='2' AND `sub_client_id` IS NULL  ORDER BY `id` ASC  ",'clientid_table',0,1,"`username`,`id`,`default_currency`,`private_key`");
}


$data['test_merchant_id']=$_SESSION['test_merchant1']['id'];
//$data['test_apikey']=$_SESSION['test_merchant1']['apikey'];
$data['test_default_currency']=$_SESSION['test_merchant1']['default_currency'];
$data['username']=$_SESSION['test_merchant1']['username'];
//echo "<br/>test_merchant_user=>".$data['test_merchant_user'];

/*
if(isset($_REQUEST['h'])&&($_REQUEST['h'])){
	$_SERVER["HTTP_HOST"]=$_REQUEST['h'];
	$data['Host']=$_REQUEST['h'];
}
*/

$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$domain_name=$protocol.$_SERVER["HTTP_HOST"];

if($data['localhosts']==true){
	
}else{
	//$data['Host']="";
}

$ctest="";
if(isset($_GET)&&($_GET)){
	unset($_GET['h']);
	$ctest="?".http_build_query($_GET);
}
?>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Order Detail</title>

<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<!--<style>
body{font-size:14px; margin:30px 0px 30px 5%; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; 
	width:90%; line-height: 24px; text-align: center;
	text-shadow: 0 1px 0 #fff;
    border-color: rgba(192, 152, 83, 0.7);
    -webkit-box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1) inset, 0 0 0 1px rgba(255, 255, 255, 0.7) inset, 0 1px 0 rgba(255, 255, 255, 0.9);
    -moz-box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1) inset, 0 0 0 1px rgba(255, 255, 255, 0.7) inset, 0 1px 0 rgba(255, 255, 255, 0.9);
    box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1) inset, 0 0 0 1px rgba(255, 255, 255, 0.7) inset, 0 1px 0 rgba(255, 255, 255, 0.9);
	color: #468847;
    background-color: #dff0d8;
    border-color: #d6e9c6;
}
input,select {width:290px;padding:5px;font-size:16px;}
p{font-size:18px; margin:10px 10px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; float:left; width:100%;width: 100%; line-height: 34px;}	
</style>-->
<style>
.btn-primary {
    color: #ffffff !important;
    border-color: #000000 !important;
    background: #808080 !important;
}
</style>
<?
$theme_path=$data['TEMPATH'].'/common/js/jquery-3.6.0.min.js';
if(!file_exists($theme_path)){
	//$data['TEMPATH']='';
	//echo "</br/>TEMPATH=>".$data['TEMPATH'];
	$data['TEMPATH']=$data['Host'].'/front_ui/default';
	/*
	echo "</br/>Path=>".$data['Path'];
	echo "</br/>TEMPATH=>".$data['TEMPATH'];
	echo "</br/>Host=>".$data['Host'];
	*/
}
?>

<script src="<?=$data['TEMPATH']?>/common/js/jquery-3.6.0.min.js"></script>
<link href="<?=$data['TEMPATH']?>/common/css/bootstrap.min.css" rel="stylesheet">
<link href="<?=$data['TEMPATH']?>/common/css/all.min.lates.icon.css" rel="stylesheet">
<link href="<?=$data['TEMPATH']?>/common/css/template-custom.css" rel="stylesheet">
<script src="<?=$data['TEMPATH']?>/common/js/bootstrap.bundle.min.js"></script>

<script>
window.name='hostPost';
function closeWindowf(){
	alert('closeWindowf');
	//window.close();
}
</script>


<script>
function storetypes(thisScl,theValue,theTitle){
	//alert('ok');
	//alert(theValue+'\r\n'+theTitle+'\r\n'+thisScl.title);
}



function ccnof(theValue){
	document.getElementById("ccvv").value='';
	document.getElementById("month").value='';
	document.getElementById("year").value='';
	document.getElementById("ccno_1").value=theValue;
	if(theValue=="5531886652142950"){
		document.getElementById("ccvv").value='564';
		document.getElementById("month").value='09';
		document.getElementById("year").value='22';
	}else if(theValue=="5438898014560229"){
		document.getElementById("ccvv").value='564';
		document.getElementById("month").value='10';
		document.getElementById("year").value='31';
	}else if(theValue=="4888073468827577" || theValue=="4916200748584399"){
		document.getElementById("ccvv").value='123';
		document.getElementById("month").value='11';
		document.getElementById("year").value='99';
	}else if(theValue=="5453010000095323"){
		document.getElementById("ccvv").value='123';
		document.getElementById("month").value='02';
		document.getElementById("year").value='25';
	}else if(theValue=="6799990100000000019"){
		document.getElementById("ccvv").value='560';
		document.getElementById("month").value='12';
		document.getElementById("year").value='22';
	}else if(theValue=="5061460410121111104"){
		document.getElementById("ccvv").value='560';
		document.getElementById("month").value='12';
		document.getElementById("year").value='22';
	}else if(theValue=="5061460410121111105"){
		document.getElementById("ccvv").value='561';
		document.getElementById("month").value='12';
		document.getElementById("year").value='22';
	}else if(theValue=="5061460410121111106"){
		document.getElementById("ccvv").value='562';
		document.getElementById("month").value='12';
		document.getElementById("year").value='22';
	}else if(theValue=="4242424242424242" || theValue=="4405230005906974"){
		document.getElementById("ccvv").value='812';
		document.getElementById("month").value='01';
		document.getElementById("year").value='26';
	}else if(theValue=="4111111111111111"){
		document.getElementById("ccvv").value='123';
		document.getElementById("month").value='12';
		document.getElementById("year").value='22';
	}else if(theValue=="5500081528083771"){
		document.getElementById("ccvv").value='789';
		document.getElementById("month").value='06';
		document.getElementById("year").value='22';
	}else if(theValue=="5399838383838381"){
		document.getElementById("ccvv").value='470';
		document.getElementById("month").value='10';
		document.getElementById("year").value='22';
	}else if(theValue=="5241810403911860"){
		document.getElementById("ccvv").value='576';
		document.getElementById("month").value='12';
		document.getElementById("year").value='20';
	}else if(theValue=="4166451441202790"){
		document.getElementById("ccvv").value='926';
		document.getElementById("month").value='04';
		document.getElementById("year").value='24';
	}else if(theValue=="4375514708146005"){
		document.getElementById("ccvv").value='';
		document.getElementById("month").value='07';
		document.getElementById("year").value='20';
	}else if(theValue=="4065971254000090"){
		document.getElementById("ccvv").value='';
		document.getElementById("month").value='05';
		document.getElementById("year").value='22';
	}else if(theValue=="4047457514066090"){
		document.getElementById("ccvv").value='152';
		document.getElementById("month").value='06';
		document.getElementById("year").value='22';
	}else if(theValue=="5453010000095323"){
		document.getElementById("ccvv").value='123';
		document.getElementById("month").value='02';
		document.getElementById("year").value='25';
	}else if(theValue=="2222405343248870"
||theValue=="2222990905257050"||theValue=="2223007648726980"||theValue=="2223577120017650"||theValue=="5105105105105100"||theValue=="5111010030175150"||theValue=="5185540810000010"||theValue=="5200828282828210"||theValue=="5204230080000010"||theValue=="5204740009900010"||theValue=="5420923878724330"||theValue=="5455330760000010"||theValue=="5506900490000430"||theValue=="5506900490000440"||theValue=="5506900510000230"||theValue=="5506920809243660"||theValue=="5506922400634930"||theValue=="5506927427317620"||theValue=="5553042241984100"||theValue=="5555553753048190"||theValue=="5555555555554440"||theValue=="4012888888881880"||theValue=="4111111111111110"||theValue=="6011000990139420"||theValue=="6011111111111110"||theValue=="371449635398431"||theValue=="378282246310005"||theValue=="30569309025904"||theValue=="38520000023237"||theValue=="3530111333300000"||theValue=="3566002020360500"
){
		document.getElementById("ccvv").value='111';
		document.getElementById("month").value='06';
		document.getElementById("year").value='22';
	}

}


$(document).ready(function(){
	$("#BusinessType option").change(function() {
		
	   var selectedItem = $(this).val();
	   var titles= $(this).attr('data-title');
	   //var titles= $('#BusinessType option:selected', this).attr('data-title');
	  // var titles= $(this).data('title');
	  // alert(selectedItem); alert(titles);
	   $("#BusinessType1").val(selectedItem);
	   $("#terNO").val(titles);
	   
	   
	  // alert(selectedItem+'\r\n'+titles);
	   
	   //console.log(abc,selectedItem);
	 });
	 //$('#BusinessType').trigger('change');
	 //$("#BusinessType option:eq(2)").attr('selected','selected').prop('selected', 'selected').trigger('change');
	 
	 
	 //$("#BusinessType option:last").attr('selected','selected').prop('selected', 'selected').trigger('change');
	 //ccnof('4242424242424242');
	 ccnof('5438898014560229');
});

</script>

</head>
<body>
<?

if(isset($_REQUEST['j'])&&$_REQUEST['j']){
	
	$j=$j_de=json_decode($_REQUEST['j'],1);
	if(isset($j['terNO'])&&empty($j['terNO']))unset($j['terNO']);
	if(isset($j['country_name']))unset($j['country_name']);
	if(@$j['post']) $j=@$j['post'];
	$j2=http_build_query($j);
	
	$directapi='directapi'.$data['ex'];
	
	echo '<div class="bg-primary text-wrap" style="width: 90vw;line-height: 155%;word-break:break-word;max-width: 90%;display:block !important;text-align: center;margin:10px auto;">';
	
	echo "<br/><br/>".$j2."<br/><hr/>";
	if(@$j_de['actionUrl']) print_r($j_de['actionUrl'].'/'.$directapi.'?'.$j2);
	if(@$j_de['hostUrl']) print_r($j_de['hostUrl'].'/'.$directapi.'?'.$j2);
	
	
		echo '</div>';
	//exit;
}

?>

<?	

	
	$merID=$data['test_merchant_id'];
	$terNO="";
	$curr=$data['test_default_currency'];
	$bill_amt='2.00';
	
	
	

	
?>
<div class="entry-content container-flex p-3 bd-gray-100  text-center">
<div class="col-sm-6 border bd-blue-100 p-2 rounded" style="max-width:400px; margin:0 auto;">

<a href="<?=$data['Host'];?>/@<?=$data['username'];?>/1.05/" target="_blank"><?=$data['Host'];?>/@<?=$data['username'];?>/1.05/</a>

<form id="formId" target="_blank" method="post" action="<?=$data['Host'];?>/<?=$processall_url;?><?=$data['ex'];?><?=$ctest;?>">


<input type="hidden" id="actionType" name="actionType" value="">
<input type="hidden" id="actionUrl" name="actionUrl" value="">

<input type="hidden" id="integration-type" name="integration-type" value="Checkout">


<input type="text" class="form-control form-control-sm my-1" name="terNO" id="terNO" title="terNO" value="<?=$terNO;?>" style="width:60px;"> <!-- terNO from Business Settings   -->
<?/*?>
<input type="text" class="form-control form-control-sm my-1" name="terNO" id="terNO" title="terNO" value="<?=$terNO;?>" style="width:70%"><!-- terNO from Business Settings  -->
<?*/?>
<?
$terminals=select_terminals($merID,0,0,1);	


$webhook=$data['Host']."/responseDataList".$data['ex'];

//print_r($terminals);
?>

<input type="text" class="form-control form-control-sm my-1" name="public_key" id="BusinessType1" list="BusinessType" value="" >

<datalist id="BusinessType" title="BusinessType: Store Type." class="select_cs_2" data-bs-toggle="tooltip" data-bs-placement="right">
	<option value="">Business Terminal Id</option>
	<? foreach($terminals as $key=>$val){ ?>
		<option data-title="<?=$val['id']?>" value="<?=$val['public_key']?>" ><?=$val['checkout_theme']?> - <?=$val['ter_name']?> : <?=$val['id']?> : <?=$val['acquirerIDs']?></option>
	<? } ?>
</datalist>


<!-- end : Gateway merchant deails which are Input field -->
<!-- start : redirect url of success, notify, error as per your domain wise   -->
<input type="text" class="form-control form-control-sm my-1" name="return_url" title="return_url" data-bs-toggle="tooltip" data-bs-placement="right"  value="<?=$webhook;?>/?urlaction=success">
<input type="text" class="form-control form-control-sm my-1" name="webhook_url" title="webhook_url" data-bs-toggle="tooltip" data-bs-placement="right" value="<?=$webhook;?>/?urlaction=notify">
<!-- end : redirect url of success, notify, error as per your domain wise   -->



<!-- start : this is mandatory for customer billing details from   -->
<input type="text" class="form-control form-control-sm my-1" name="product_name" title="product_name" value="Test Product" data-bs-toggle="tooltip" data-bs-placement="right">
<input type="text" class="form-control form-control-sm my-1" name="fullname" title="fullname: Full Name" data-bs-toggle="tooltip" data-bs-placement="right" value="Test Full Name" />
<input type="text" class="form-control form-control-sm my-1" name="bill_email" value="test<?=date('is');?>@test.com" title="Bill Email" data-bs-toggle="tooltip" data-bs-placement="right">
<input type="text" class="form-control form-control-sm my-1" name="bill_address" title="bill_address: Address " data-bs-toggle="tooltip" data-bs-placement="right" value="161 Kallang Way">
<input type="text" class="form-control form-control-sm my-1" name="bill_city" title="bill_city: City" data-bs-toggle="tooltip" data-bs-placement="right" value="New Delhi">
<input type="text" class="form-control form-control-sm my-1" name="bill_state" title="bill_state: State" data-bs-toggle="tooltip" data-bs-placement="right" value="Delhi">
<input type="text" class="form-control form-control-sm my-1" name="bill_country" title="bill_country: Country Code 2 Digit" data-bs-toggle="tooltip" data-bs-placement="right" value="IN">
<input type="text" class="form-control form-control-sm my-1" name="bill_zip" title="bill_zip: Zip Code" data-bs-toggle="tooltip" data-bs-placement="right" value="110001">
<input type="text" class="form-control form-control-sm my-1" name="bill_phone" title="bill_phone: Phone/Mobile No." data-bs-toggle="tooltip" data-bs-placement="right" value="9198<?=date('dHis');?>">
<input type="text" class="form-control form-control-sm my-1" name="reference" title="reference: Merchant  Transaction Id" data-bs-toggle="tooltip" data-bs-placement="right" value="<?=date('YmdHis');?>"><!-- unique order id   -->
<!-- end : this is mandatory for customer billing details from  -->

<select name="bill_currency" id="curr" title="bill_currency: Process Currency" data-bs-toggle="tooltip" data-bs-placement="right" class="select_cs_2 form-select my-1">
	<option value="<?=$curr;?>" selected="selected" ><?=$curr;?></option>
	
	<?foreach ($data['AVAILABLE_CURRENCY'] as $k11) {?>
		<option value="<?=$k11?>"><?=$k11?></option>
	<?}?>
	
</select>

<input type="text" class="form-control form-control-sm my-1" name="bill_amt" title="bill_amt" data-bs-toggle="tooltip" data-bs-placement="right"  value="<?=$bill_amt;?>">
<?
$bill_ip = ((isset($_SERVER['HTTP_X_FORWARDED_FOR']) && $_SERVER['HTTP_X_FORWARDED_FOR'])?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR']);

if($data['localhosts']==true){$bill_ip=rand(1,254).'.'.rand(1,254).'.'.rand(1,254).'.'.rand(1,254);}
?>
<input type="text" class="form-control form-control-sm my-1" name="bill_ip" title="bill_ip" data-bs-toggle="tooltip" data-bs-placement="right" value="<?=$bill_ip?>"/>
<input type="text" class="form-control form-control-sm my-1" name="acquirer_id" title="acquirer_id" data-bs-toggle="tooltip" data-bs-placement="right" value="" placeholder="acquirer_id" />

<input type="text" class="form-control form-control-sm my-1" name="ccno" id="ccno_1" value="" placeholder="Copy of ccno_1: Card No." title="Copy of ccno_1: Card No." data-bs-toggle="tooltip" data-bs-placement="right" />
<div class="divider py-1 bg-success"></div>

<select  id="ccno" title="ccno: Card No." class="select_cs_2 form-select my-1"  onChange="ccnof(this.value)"  data-bs-toggle="tooltip" data-bs-placement="right">
	<option value="" >ccno</option>
	<option value="4405230005906974">4405230005906974 Luhn Bin 440523</option>
	<optgroup label="Test Card" style="background:#268300;color:#fff;"></optgroup>
		<?
		foreach($data['testCardNo'] as $k=>$v){ ?>
			<option value='<?=$v?>'><?=$v?> <?=$k?></option>
		<? } ?>
	
	<optgroup label="Test Card of Gateway" style="background:#004da1;color:#fff;" >
		<option value="5531886652142950">5531886652142950 2D</option>
		<option style="background:#004da1;color:#fff;" value="5438898014560229" selected="selected">5438898014560229 3D</option>
		<option style="background:#004da1;color:#fff;" value="4916200748584399">4916200748584399 2D Epiq</option>
		<option style="background:#004da1;color:#fff;" value="4888073468827577">4888073468827577 3D Epiq</option>
		<option style="background:#004da1;color:#fff;" value="5453010000095323">5453010000095323 IGS Test</option>
		<option style="background:#004da1;color:#fff;" value="4111111111111111">4111111111111111 Test</option>
		<option style="background:#004da1;color:#fff;" value="4242424242424242">4242424242424242 Test</option>
		<option style="background:#004da1;color:#fff;" value="5399838383838381">5399838383838381 Rave Test</option>
		<option style="background:#004da1;color:#fff;" value="5061460410121111104">5061460410121111104 Opay PIN</option>
		<option style="background:#004da1;color:#fff;" value="5061460410121111105">5061460410121111105 Opay PIN+OTP</option>
		<option style="background:#004da1;color:#fff;" value="5061460410121111106">5061460410121111106 Opay OTP+3D</option>
		<option style="background:#004da1;color:#fff;" value="5500081528083771">5500081528083771 Gate.Exp. Test</option>
		<option style="background:#004da1;color:#fff;" value="5241810403911860">5241810403911860 Block</option>
		<option style="background:#004da1;color:#fff;" value="4166451441202790">4166451441202790 Block</option>
		<option style="background:#004da1;color:#fff;" value="4375514708146005">4375514708146005 Block</option>
		<option style="background:#004da1;color:#fff;" value="4065971254000090">4065971254000090</option>
		<option style="background:#004da1;color:#fff;" value="4047457514066090">4047457514066090 Block Test</option>
		<option style="background:#004da1;color:#fff;" value="5453010000095323">5453010000095323</option>
		<option style="background:#004da1;color:#fff;" value='2222405343248870'>2222405343248870 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='2222990905257050'>2222990905257050 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='2223007648726980'>2223007648726980 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='2223577120017650'>2223577120017650 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5105105105105100'>5105105105105100 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5111010030175150'>5111010030175150 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5185540810000010'>5185540810000010 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5200828282828210'>5200828282828210 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5204230080000010'>5204230080000010 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5204740009900010'>5204740009900010 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5420923878724330'>5420923878724330 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5455330760000010'>5455330760000010 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5506900490000430'>5506900490000430 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5506900490000440'>5506900490000440 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5506900510000230'>5506900510000230 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5506920809243660'>5506920809243660 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5506922400634930'>5506922400634930 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5506927427317620'>5506927427317620 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5553042241984100'>5553042241984100 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5555553753048190'>5555553753048190 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='5555555555554440'>5555555555554440 MasterCardTest</option>
		<option style="background:#004da1;color:#fff;" value='4012888888881880'>4012888888881880 VisaTest</option>
		<option style="background:#004da1;color:#fff;" value='4111111111111110'>4111111111111110 VisaTest</option>
		<option style="background:#004da1;color:#fff;" value='6011000990139420'>6011000990139420 DiscoverTest</option>
		<option style="background:#004da1;color:#fff;" value='6011111111111110'>6011111111111110 DiscoverTest</option>
		<option style="background:#004da1;color:#fff;" value='371449635398431'>371449635398431 American ExpressTest</option>
		<option style="background:#004da1;color:#fff;" value='378282246310005'>378282246310005 American ExpressTest</option>
		<option style="background:#004da1;color:#fff;" value='30569309025904'>30569309025904 DinersTest</option>
		<option style="background:#004da1;color:#fff;" value='38520000023237'>38520000023237 DinersTest</option>
		<option style="background:#004da1;color:#fff;" value='3530111333300000'>3530111333300000 JCBTest</option>
		<option style="background:#004da1;color:#fff;" value='3566002020360500'>3566002020360500 JCBTest</option>
</optgroup>
</select> 
<input type="password" class="form-control form-control-sm my-1" name="ccvv" id="ccvv" title="ccvv: CVV 3 Digit No."  data-bs-toggle="tooltip" data-bs-placement="right" value="">
<input type="text" class="form-control form-control-sm my-1" name="month" id="month" title="month: Month 2 Digit" data-bs-toggle="tooltip" data-bs-placement="right"  value="">
<input type="text" class="form-control form-control-sm my-1" name="year" id="year" title="year: Year 2 Digit" data-bs-toggle="tooltip" data-bs-placement="right"  value="">


<select name="country_name" id="country_name" title="country_name: Country Name" class="select_cs_2 form-select my-1"  onChange="country_namef(this.value)"  data-bs-toggle="tooltip" data-bs-placement="right">
	<option value="" selected="selected">Country Name</option>
	<option value="Austria">Austria</option>
<option value="Belgium">Belgium</option>
<option value="Britain">Britain</option>
<option value="Bulgaria">Bulgaria</option>
<option value="Cyprus">Cyprus</option>
<option value="Croatia">Croatia</option>
<option value="Czech Republic">Czech Republic</option>
<option value="Denmark">Denmark</option>
<option value="Estonia">Estonia</option>
<option value="Finland">Finland</option>
<option value="France">France</option>
<option value="Germany">Germany</option>
<option value="Greece">Greece</option>
<option value="Hungary">Hungary</option>
<option value="Republic of Ireland">Republic of Ireland</option>
<option value="Italy">Italy</option>
<option value="Latvia">Latvia</option>
<option value="Lithuania">Lithuania</option>
<option value="Luxembourg">Luxembourg</option>
<option value="Malta">Malta</option>
<option value="Netherlands">Netherlands</option>
<option value="Poland">Poland</option>
<option value="Portugal">Portugal</option>
<option value="Romania">Romania</option>
<option value="Slovenia">Slovenia</option>
<option value="India">India</option>
</select>
<div class="divider py-1 bg-success"></div>	

<input type="text" class="form-control form-control-sm my-1" id="activemid" placeholder="activemid is yes for skip the common Acquirer" title="Manual URL like: api or processall"  data-bs-toggle="tooltip" data-bs-placement="right"  value="">

<input type="text" class="form-control form-control-sm my-1" id="manualURL" placeholder="Manual URL like: api or processall" title="Manual URL like: api or processall"  data-bs-toggle="tooltip" data-bs-placement="right" value="">

<div class="divider py-1 bg-success"></div>

<?/*?>
<input type="checkbox" id="dynamicPost" title="Dynamic Post" data-bs-toggle="tooltip" data-bs-placement="right" value="1" checked style="width:auto;" />Dynamic Post<br/><br/>	
<?*/?>

<input id="form_submit" type="submit" class="btn btn-primary btn-sm w-100 my-1" value="CONTINUE TO REDIRECT-HOST">
<input id="form_submit_curl" type="submit" class="btn btn-primary btn-sm w-100 my-1" value="CONTINUE TO S2S-Curl-Direct">
<input id="form_submit_hostEnc" type="submit" class="btn btn-primary btn-sm w-100 my-1" value="CONTINUE TO S2S-Host-Encode">
<input id="form_submit_curlEnc" type="submit" class="btn btn-primary btn-sm w-100 my-1" value="CONTINUE TO S2S-Curl-Encode">
</form>

<form id="formId" target="_blank" method="post" action="<?=$data['Host'];?>/p/curl_enc<?=$data['ex'];?><?=$ctest;?>">
<textarea name="j"  class="form-control"></textarea>
<input id="p_json_post_submit" name="p_json_post_submit" class="btn btn-primary btn-sm w-100 my-1" type="submit" value="CONTINUE TO JOSN POST" >
</form>
</div>
</div>

</body>

<script>


//if($('#dynamicPost').is(':checked')){
	
$('#form_submit').click(function(){
	$('#integration-type').attr('value', 'Checkout');
	
	if($('#manualURL').val()!=''){
		$('#formId').attr('action', '<?=$data['Host'];?>/'+$('#manualURL').val()+'<?=$data['ex'];?><?=$ctest;?>');
		//alert("manualURL"+$('#formId').attr('action'));
	}else{
		$('#formId').attr('action', '<?=$data['Host'];?>/<?=$processall_url;?><?=$data['ex'];?><?=$ctest;?>');
	}
})

$('#form_submit_curl').click(function(){
	$('#formId').attr('action', '<?=$data['Host'];?>/p/trans_curl_enc<?=$data['ex'];?><?=$ctest;?>');
	
	$('#actionType').attr('value', 'S2S-Curl-Direct');
	$('#integration-type').attr('value', 's2s');
	
	if($('#manualURL').val()!=''){
		$('#actionUrl').attr('value', '<?=$data['Host'];?>/'+$('#manualURL').val()+'<?=$data['ex'];?>');
	}else{
		$('#actionUrl').attr('value', '<?=$data['Host'];?>/<?=$api_url;?><?=$data['ex'];?>');
	}
	
});

$('#form_submit_hostEnc').click(function(){
	$('#formId').attr('action', '<?=$data['Host'];?>/p/trans_curl_enc<?=$data['ex'];?><?=$ctest;?>');
	$('#actionUrl').attr('value', '<?=$data['Host'];?>/<?=$processall_url;?><?=$data['ex'];?>');
	$('#actionType').attr('value', 'S2S-Host-Encode');
	$('#integration-type').attr('value', 'Encode-Checkout');
});

$('#form_submit_curlEnc').click(function(){
	$('#formId').attr('action', '<?=$data['Host'];?>/p/trans_curl_enc<?=$data['ex'];?><?=$ctest;?>');
	$('#actionUrl').attr('value', '<?=$data['Host'];?>/<?=$api_url;?><?=$data['ex'];?>');
	$('#actionType').attr('value', 'S2S-Curl-Encode');
	$('#integration-type').attr('value', 's2s');
	
});

</script>
<script>
/*for display tooltip message*/
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
});


</script>