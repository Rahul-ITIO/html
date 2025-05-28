<?
if(!isset($data['config_root'])){
	$config_root='../config_root.do';
	if(file_exists($config_root)){include($config_root);}
}


if(isset($_SESSION['3ds2_auth']['bank_process_url'])){
  $data['Host']=$_SESSION['3ds2_auth']['bank_process_url'];
}
if(isset($_SESSION['3ds2_auth']['paytitle'])&&$_SESSION['3ds2_auth']['paytitle']){
  $data['payTitle']=$_SESSION['3ds2_auth']['paytitle'];
}
if(isset($_SESSION['3ds2_auth']['appName'])&&$_SESSION['3ds2_auth']['appName']){
  $data['appName']=$_SESSION['3ds2_auth']['appName'];
}

if(isset($_SESSION['3ds2_auth']['payaddress'])&&$_SESSION['3ds2_auth']['payaddress']){
  $data['payaddress']=$_SESSION['3ds2_auth']['payaddress'];
}

if(isset($_SESSION['3ds2_auth']['paycurrency'])&&$_SESSION['3ds2_auth']['paycurrency']){
  $currname=$_SESSION['3ds2_auth']['paycurrency'];
}elseif(isset($_SESSION['3ds2_auth']['currname'])&&$_SESSION['3ds2_auth']['currname']){
  $currname=$_SESSION['3ds2_auth']['currname'];
}else{
  $currname=' ';
}

if(isset($_REQUEST['qp'])) 
{	
	echo "<hr/><h1>3ds2_auth=></h1><br/>";
	print_r($_SESSION['3ds2_auth']);
	
}

if(isset($_REQUEST['qp'])) echo "<hr/>PAYADDRESS=><br/>".$data['payaddress'];



//base64 decode if action is redirect_base64
if(@$_SESSION['3ds2_auth']['action']=='redirect_base64')
  $data['payaddress']=base64_decode($data['payaddress']);
elseif(isset($_SESSION['3ds2_auth']['urltype'])&&$_SESSION['3ds2_auth']['urltype']=='urlencode')
{ 
    //not required urldecode for payaddress
}
elseif(isset($data['payaddress'])&&trim($data['payaddress']))
$data['payaddress']=urldecodef($data['payaddress']);

if(isset($_REQUEST['qp'])) echo "<hr/>payaddress urldecodef=><br/>".$data['payaddress'];


/*
if(isset($data['payaddress'])&&!empty($data['payaddress'])&&trim($data['payaddress']))
  $data['payaddress']=urlencode($data['payaddress']);
 
  if(isset($_REQUEST['qp'])) echo "<hr/>payaddress urlencode=><br/>".$data['payaddress'];
*/

 if(isset($_REQUEST['qp'])) 
{	
	echo "<hr/>payaddress=><br/>".$data['payaddress'];
	if(@$_REQUEST['qp']==1) exit;
}

if(isset($_SESSION['3ds2_auth']['integration-type'])&&$_SESSION['3ds2_auth']['integration-type']=='s2s')
{

}
elseif(!empty($data['payaddress']&&trim($data['payaddress']))) 
{

  header("Location:".$data['payaddress']);exit;
}




if(!isset($data['payTitle'])){
	$data['payTitle']=' Bank OTP Page ';
	//$data['payTitle']='Paytm ';
}
if(!isset($data['appName'])){
	$data['appName']=' Bank OTP Page ';
}

$data['Host2']=$data['Host'];
		
?>

<!DOCTYPE html>
<html lang="en-US">
<head>
<title>Continue the redirect for Secure 2 Processing...</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />

<?/*?>
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *; object-src 'none'" />
<?*/?>

<script src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"></script>

<link href="<?=$data['Host']?>/front_ui/default/common/css/bootstrap.min.css" rel="stylesheet">



<style>
body{margin:0;padding:0;overflow:auto;width:100%;height:100%;
font-size:14px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; 
	 line-height: 24px; text-align: center;
	color: #468847;
	background: url("<?php echo $data['Host'];?>/images/criss-cross.png");
	border-color: #d6e9c6;
}
h1 {float:left;font-size:18px;width:100%;border-bottom:2px solid #ccc;padding:0 0 20px 0;margin:0 0 20px 0;font-weight:normal;line-height:150%;}
.warper {
	display:block;width:310px;margin:10px auto; 
}
.warper_div1 {
	float:left;display:block;width:100%;padding:0px;margin:10px auto; background-color:#fff;border:4px solid #ccc;border-radius:7px;
}
.warper_div {
    float: left;
    display: block;
    width: 440px;
    padding: 0px;
    
    background-color: #fff;
    border: 4px solid #ccc;
    border-radius: 7px;
    position: absolute;
    top: 50%;
    left: 50%;
}

.text_place{font-size:16px; margin:10px 10px; font-family: Arial, Helvetica, sans-serif; color: #5d5c5d; float:left; width:100%; line-height: 22px; text-align:justify;}
.red {color:red;}
.green {color:green;}
.qr_code {float:left;}

.coins_amt {float:right;text-align:right;}
.bch {font-size:24px;font-weight:bold;color:#000;}
.none_bch {font-size:18px;font-weight:bold;color:#999;}
.address_coins {float:right;text-align:right;font-size:18px;font-weight:normal;color:#000;margin: 168px 25px 0 0;}
.authenticated_div {float:left;width:100%;border-bottom:0px solid #ccc;padding:0 0 10px 0;margin:0 0 20px 0;font-weight:normal;display:none;}
.warper_master {padding:20px 40px 20px 20px;}
.payToNextDiv {float:left;width:100%;text-align:center;margin:10px 0 20px 0px;}
.payToNext{float:none;display:inline-block;background:#da8f05;padding:10px 30px;font-size:18px;color:#fff;text-decoration:none;border-radius:5px}

.iHavPaid1 {float:left;width:100%;}
.iHavPaid{float:right;background:#da8f05;padding:10px 30px;font-size:18px;color:#fff;text-decoration:none;border-radius:5px}

.hr {float:left;width:100%;clear:both;height:6px;margin:20px 0;border-bottom:2px solid #ccc;}


@media (max-width: 439px) {
	.warper {width:85%;margin:0 auto;}
	.warper_div {width:96%;margin:0 auto;}
	
}

</style>

<?
$data['startSetInterval']='Y';
//file use for  payin_auto_status_common_script 
$payin_auto_status_common_script=$data['Path'].'/payin/payin_auto_status_common_script'.$data['iex'];
if(file_exists($payin_auto_status_common_script)){include($payin_auto_status_common_script);}
?>
<?
if(isset($_SESSION['3ds2_auth']['integration-type'])&&$_SESSION['3ds2_auth']['integration-type']=='s2sX')
{
?>
  <script>
  $(document).ready(function() {
    
    setTimeout(function(){ 
      //$('.redirectLink').trigger('click');
      if ($('.redirectLink').hasClass("active")) {
        
      }

      if(redirectLinkAtive=='') {
        $('.redirectLink')[0].click();
      }
    }, 200);
    
  });

  </script>
<?
}
?>
</head>
<body oncontextmenu1='return false;'>
<div class="warper">
  <div class="warper_div position-absolute top-50 start-50 translate-middle">
    <div class="warper_master">
      <div class="text_place" >

          <div class="m-2 text-center">
            <img src="<?=$data['Host']?>/images/external-link-square_3.png" style="border-radius:100px;width:70px;" />
          </div>

          <div class="main-col-sm p-2" style="background:#f7f7f7; margin:0 auto;border-radius: 8px;">
          <div class="row">
            <div class="my-2 fs-4 text-center" style="line-height:normal;"><?=@$data['payTitle'];?></div>	 
          </div>
          <hr class="bg-danger border-2 border-top border-danger">
          <div class="row">
            
            
            <div class="col-sm-12" id="column2">
              <div class="my-2 py-2 badge rounded-pill w-100" style="background-color:#d07c00;" >TRANSACTION DETAILS</div>
                <div class="my-2 text-start">
                  <span class="text-muted fst-italic">TransID:&nbsp;</span>
                  <span class="text-body "><? echo @$transID;?></span>
                </div>

              <? if(isset($_SESSION['3ds2_auth']['paytitle'])){
              ?> 
                <div class="my-2 text-start">
                  <span class="text-muted fst-italic">Pay To:&nbsp;</span>
                  <span class="text-body "><? echo ($_SESSION['3ds2_auth']['paytitle']);?></span>
                </div>
              <?
              }?>
              
              <?if(isset($_SESSION['3ds2_auth']['product_name'])&&trim($_SESSION['3ds2_auth']['product_name'])){?>
                <div class="my-2 text-start">
                    <span class="text-muted fst-italic">Product/Service:&nbsp;</span>
                    <span class="text-dark"><? if(isset($_SESSION['3ds2_auth']['product_name'])) echo $_SESSION['3ds2_auth']['product_name'];?></span>
                </div>
              <?
              }?>
            
              <div class="my-2 text-start">
                <span class="text-muted fst-italic">Total Amount:&nbsp;</span>
                <span class="text-dark"><?php echo $_SESSION['3ds2_auth']['bill_amt'];?> <?php echo $_SESSION['3ds2_auth']['bill_currency'];?> 
                  <?if(@$_SESSION['3ds2_auth']['bill_currency']!=@$currname){?>
                    ( <strong><?php echo $_SESSION['3ds2_auth']['payamt'];?> <?=$currname;?></strong> )
                  <?  }?>
                </span>
              </div>
            </div>

              
              <div class="text-start text12 mt-2 text-dark">
                This <?=@$data['appName']?> will be invalid after <span id="timer" class="col-sm-2 fs-6 text-dark">15:00</span> minutes. 
              </div>

              <?/*?>
               <div class="iHavPaid1 text-end"><hr class="bg-danger border-2 my-2 border-top border-danger" >
              <a id="iHavPaidLink" class="btn text-dark"style="background-color:#d07c00;" onClick="clearIntervalf();" href="<?=$processed;?>">I HAVE PAID</a></div>
              <?*/?>
        </div>






              
        <div class="payToNextDiv mt-4" id="redirected">
          <h1 class="mt-4" >You will be redirected to <b>
            <?=$data['appName'];?>
            </b> for authentication. </h1>
          <p> </p>
          <a class="payToNext redirectLink" <?=((!empty($data['payaddress'])&&trim($data['payaddress']))?'href=\''.@$data['payaddress'].'\' target="_blank" onClick="intentf()" ':'');?> >OK</a> 
		      <a class="payToNext" onClick="clearIntervalf();" href="<?=$data['Host']?>/bank_status<?=$data['ex']?><?=$data['transID']?>" target="_top">Cancel</a> 
        </div>
        <div class="authenticated_div mt-4" >
          <p class="mt-4">Have you authenticated the transaction at <span class="green"><b>
            <?=$data['appName'];?>
            </span>?</p>
          <div class="payToNextDiv"><a class="payToNext iHavPaidLink" onClick="clearIntervalf();" href="<?=$data['Host']?>/bank_status<?=$data['ex']?><?=$data['transID']?>" target="_top">Yes</a></div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
<?
if(isset($_SESSION['3ds2_auth'])){
	//unset($_SESSION['3ds2_auth']);
}
?>
</html>
