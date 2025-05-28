<? if(isset($data['ScriptLoaded'])){ 
//$domain_server=$_SESSION['domain_server'];
//include($data['Path'].'/include/header_color'.$data['iex']); 

?>
<?
$data['domain_url']=$data['Host'];

$store_url=($data['MYWEBSITEURL']?$data['MYWEBSITEURL']:'store');
$store_id_nm=$store_url;
$store_name="Payout";

if(isset($data['API_VER'])&&$data['MYWEBSITEURL']){
	$processall_url='charge';
}else{
	$processall_url='processall';
}


if(isset($data['PRO_VER'])&&$data['PRO_VER']==3){
    $api_url="directapi";
	$processall_url="checkout";
}else{
	$api_url="api";
	//$processall_url="charge";
}

$payput_page_title="Payout Transaction";
$payput_api_title="API Keys & Sectet Keys";
$payput_page="payout-transaction";

$Secret_Key="Secret Key is a string value. You can find it by following <br>
<a href='{$data['domain_url']}/user/payout-keys{$data['ex']}' target='_blank'><abbr title='Click for Go to {$payput_api_title}'> Payout → Payout Keys → Generate / Copy Secret Key </abbr></span></a>";

$payout_token="Payout Token is a string value. You can find it by following <br>
<a href='{$data['domain_url']}/user/payout-keys{$data['ex']}' target='_blank'><abbr title='Click for Go to {$payput_api_title}'> Payout → Payout Keys → Generate / Copy Secret Key </abbr></span></a>";

$payout_secret_key="Payout Secret Key is a string value. You can find it by following <br>
<a href='{$data['domain_url']}/user/payout-keys{$data['ex']}' target='_blank'><abbr title='Click for Go to {$payput_api_title}'> Payout → Payout Keys → Generate / Copy Secret Key </abbr></span></a>";


?>
<style>
  .highlight table td {padding: 5px;}.highlight table pre {margin: 0;}.highlight, .highlight .w {color: #f8f8f2;background-color: #272822;}.highlight .err {color: #151515;background-color: #ac4142;}.highlight .c, .highlight .cd, .highlight .cm, .highlight .c1, .highlight .cs {color: #505050;}.highlight .cp {color: #f4bf75;}.highlight .nt {color: #f4bf75;}.highlight .o, .highlight .ow {color: #d0d0d0;}.highlight .p, .highlight .pi {color: #d0d0d0;}.highlight .gi {color: #90a959;}.highlight .gd {color: #ac4142;}.highlight .gh {color: #6a9fb5;background-color: #151515;font-weight: bold;}.highlight .k, .highlight .kn, .highlight .kp, .highlight .kr, .highlight .kv {color: #aa759f;}.highlight .kc {color: #d28445;}.highlight .kt {color: #d28445;}.highlight .kd {color: #d28445;}.highlight .s, .highlight .sb, .highlight .sc, .highlight .sd, .highlight .s2, .highlight .sh, .highlight .sx, .highlight .s1 {color: #90a959;}.highlight .sr {color: #75b5aa;}.highlight .si {color: #8f5536;}.highlight .se {color: #8f5536;}.highlight .nn {color: #f4bf75;}.highlight .nc {color: #f4bf75;}.highlight .no {color: #f4bf75;}.highlight .na {color: #6a9fb5;}.highlight .m, .highlight .mf, .highlight .mh, .highlight .mi, .highlight .il, .highlight .mo, .highlight .mb, .highlight .mx {color: #90a959;}.highlight .ss {color: #90a959;}
 
/*scroll bar*/ 
html{scrollbar-color:#cfcfcf #2467af; --scrollbarbg:#cfcfcf; --thumbbg:#2467af;}
body::-webkit-scrollbar{width:5px;}
body{scrollbar-width:thin;scrollbar-color:var(--thumbBG) var(--scrollbarBG)}
body::-webkit-scrollbar-track{background:var(--scrollbarBG);}
body::-webkit-scrollbar-thumb{background-color:var(--thumbBG);border-radius:6px;border:1px solid var(--scrollbarBG);}

 
.tbl_exl2,pre{overflow-y:auto;scrollbar-color:#2467af #cfcfcf;scrollbar-width:thin;border-radius:6px}
::-webkit-scrollbar{width:6px;height:6px;}
::-webkit-scrollbar-track{-webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.3);-webkit-border-radius:10px;border-radius:10px;}
::-webkit-scrollbar-thumb{-webkit-border-radius:10px;border-radius:10px;background:#2467af;-webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.5);}
::-webkit-scrollbar-thumb:window-inactive{background:#2467af;}


tbody th, .sticky-wrap th {
     background-color: unset !important;
}
.tocify a, .tocify a:active, .tocify a:visited a:hover, .tocify a:focus {
    color: #fff !important;
}
.search-results a, .search-results a:active, .search-results a:visited a:hover, .search-results a:focus {
    color: #fff !important;
}

.fullscreen {cursor: pointer;} 
.coppy {cursor: pointer;}
</style>
<link rel="shortcut icon" href="<?=$data['domain_url']?>/favicon.ico" type="image/ico">
<!--<link href="<?=$data['Host']?>/developer/images/screen.css" rel="stylesheet" media="screen">
<link href="<?=$data['Host']?>/developer/images/print.css" rel="stylesheet" media="print">-->
<link href="<?=$data['Host']?>/developer/images/custom.css" rel="stylesheet" media="screen">
<!--<script src="<?=$data['Host']?>/developer/images/all.js.download"></script>-->
<style>
	.content pre.highlight1x  {background-color:#4f4f4f;}
	.content pre.highlight1 span {background-color: #046903;}
	.collapse:not(.show) {
   /* display: ; */
}
</style>
<!DOCTYPE html>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<title>
<?=$data['SiteName'];?> API Documentation</title>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!--     Fonts and icons     -->
<!--<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />-->
<!-- Nucleo Icons -->
<!--<link href="developer/assets/css/nucleo-icons.css" rel="stylesheet" />
<link href="developer/assets/css/nucleo-svg.css" rel="stylesheet" />-->
<!-- Font Awesome Icons -->
<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
<!-- Material Icons -->
<!--<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">-->
<!-- CSS Files -->
<link id="pagestyle" href="developer/assets/css/material-dashboard.css?v=3.0.0" rel="stylesheet" />
</head>
<body class="g-sidenav-show  bg-gray-200">
<aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3 bg-gradient-dark" id="sidenav-main">
  <div class="sidenav-header text-white active bg-gradient-info"> <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i> <a class="navbar-brand m-0 text-center" target="_blank"><span class="ms-1 font-weight-bold text-white">Payout API</span></a> </div>
  <hr class="horizontal light mt-0 mb-2">
  <div class="collapse navbar-collapse  w-auto  max-height-vh-100" id="sidenav-collapse-main menu-center" style="height: auto !important;" >
    <ul class="navbar-nav" >
	
      <li class="nav-item"  data-unique="document_illustration"> <a class="nav-link px-0 align-middle text-white" href="#document_illustration"> <span class="nav-link-text ms-1"> <i class="fas fa-angle-double-right"></i> Document Illustration</span></a> </li>
      <li class="nav-item"  data-unique="preparation"> <a class="nav-link px-0 align-middle text-white" href="#preparation"> <span class="nav-link-text ms-1"> <i class="fas fa-angle-double-right"></i> Preparation</span></a> </li>
      <li class="nav-item"  data-unique="beneficiary_via_curl"> <a class="nav-link px-0 align-middle text-white" href="#beneficiary_via_curl"> <span class="nav-link-text ms-1"> <i class="fas fa-angle-double-right"></i> Add beneficiary via curl</span></a> </li>
      <li class="nav-item"  data-unique="add_fund"> <a class="nav-link px-0 align-middle text-white" href="#add_fund"> <span class="nav-link-text ms-1">  <i class="fas fa-angle-double-right"></i> Add fund via curl</span></a> </li>
      <li class="nav-item"  data-unique="Send_fund_via_curl"> <a class="nav-link px-0 align-middle text-white" href="#Send_fund_via_curl"> <span class="nav-link-text ms-1"> <i class="fas fa-angle-double-right"></i> Send fund via curl</span></a> </li>
      <li class="nav-item"  data-unique="check_payment_status"> <a class="nav-link px-0 align-middle text-white" href="#check_payment_status"> <span class="nav-link-text ms-1">  <i class="fas fa-angle-double-right"></i> Check payment status</span></a> </li>
      <li class="nav-item"  data-unique="card_payment_gateway_redirect_sdk"> <a class="nav-link px-0 align-middle text-white" href="#response_status"> <span class="nav-link-text ms-1">  <i class="fas fa-angle-double-right"></i> Response Status</span></a> </li>
	  <li class="nav-item"  data-unique="encrypted_payout_payment_curl_direct"> <a class="nav-link px-0 align-middle text-white" href="#payment_status"> <span class="nav-link-text ms-1"> <i class="fas fa-angle-double-right"></i> Payment Status</span></a> </li>
      <li class="nav-item"  data-unique="notify_callbacks"> <a class="nav-link px-0 align-middle text-white" href="#beneficiary_status"> <span class="nav-link-text ms-1"> <i class="fas fa-angle-double-right"></i> Beneficiary Status</span></a> </li>
      <li class="nav-item"  data-unique="currency_support"> <a class="nav-link px-0 align-middle text-white" href="#currency_support"> <span class="nav-link-text ms-1"> <i class="fas fa-angle-double-right"></i> Currency Support</span></a> </li>

    </ul>
  </div>
</aside>
<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
  <!-- Navbar -->
  <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur" navbar-scroll="true">
    <div class="container-fluid py-1 px-3">
      <nav aria-label="breadcrumb">
        <h6 class="font-weight-bolder mb-0">Payout API</h6>
      </nav>
      <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
        <!--<div class="ms-md-auto pe-md-3 d-flex align-items-center">
            <div class="input-group input-group-outline">
              <label class="form-label">Type here...</label>
              <input type="text" class="form-control">
            </div>
          </div>-->
        <ul class="navbar-nav  justify-content-end">
          <li class="nav-item d-xl-none ps-3 d-flex align-items-center"> <a href="javascript:;" class="nav-link text-body p-0" id="iconNavbarSidenav">
            <div class="sidenav-toggler-inner"> <i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i> </div>
            </a> </li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- End Navbar -->
  <div class="container-fluid">
    <!--============1===========-->
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-body pt-4 p-3">
            <div name="document_illustration" data-unique="document_illustration"></div>
            <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
              <h6 class="text-white text-capitalize ps-3" id="document_illustration">Document Illustration</h6>
            </div>
            <pre class="highlight php"><code></code></pre>
            <p>The documents provider is
              <?=$data['SiteName'];?>
              , we focus on providing our merchants a standard API integration rules. We have the right of final explanation on the document and have reserved right to update it any time.</p>
            <ol>
              <li>After using the document, you can achieve the following functions: 'Accept credit payment online', 'Query order information', 'Refund the order' and so on.</li>
              <li>The documents reader is merchants' administrator, maintainer and developer.</li>
              <li>Except defined, platform mentioned in this document means
                <?=$data['SiteName'];?>
                .</li>
            </ol>
          </div>
        </div>
      </div>
    </div>
    <!--============2===========-->
    <div class="row">
      <div class="col-md-7 mt-4">
        <div class="card">
          <div class="card-body pt-4 p-3">
            <div >
              <div name="preparation" data-unique="preparation"></div>
              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3" id="preparation">Preparation</h6>
              </div>
              <ol>
                <li>Read all the API document carefully.</li>
                <li>Obtain 3 very important parameters, they are <strong>"secret_key" , "payout_token" , "payout_secret_key"</strong>.</li>
              </ol>
              <aside class="notice">Replace of 3 very important parameters. You may find it at <a href="<?=$data['domain_url']?>/user/payout-keys<?=$data['ex']?>" target="_blank"><abbr title="Click for Go to My <?=($store_name);?>"><?=($store_name);?>
                </abbr></span></a> : <br/>
                <div style="margin:10px 0px 10px 20px;"> 
				  1. <code>secret_key</code><br/>
                  2. <code>payout_token</code><br/>
                  3. <code>payout_secret_key</code> </div>
              </aside>
              <div class="table-responsive p-0 ">
                <table class="table align-items-center mb-0">
                  <thead class="bg-info text-white">
                    <tr>
                      <th >Parameter</th>
                      <th>Description</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td class="text-wrap"><strong>secret_key</strong>
                        <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="secret key (e.g. QZfMTEyMF8yMDE4MDcyNzEyMjgyNMj) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td class="text-wrap"><?=$Secret_Key;?></td>
                    </tr>
                    <tr>
                      <td ><strong>payout_token</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Payout Token (e.g. QZfMTEyMF8yMDE4MDcyNzEyMjgyNMj) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$payout_token;?></td>
                    </tr>
					
					<tr>
                      <td ><strong>payout_secret_key</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Payout Secret Key (e.g. Test ) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$payout_secret_key;?></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-5 mt-4 bg-gradient-dark card">
        <div class="card h-100 mb-4 bg-gradient-dark">
          <div class="card-body pt-4 p-3">
            <blockquote>Example of API code to user for Integration:</blockquote>
<pre class="highlight php">
<code><span class="k">$baseurl="</span><span class="nf"><?=$data['domain_url']?></span><span class="k">"</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">Replace of 3 very important parameters </span><span class="nf">* your  Secret Key and  Payout Token</span> <span class="cp">--&gt;</span>
<span class="k">$secret_key="</span><span class="nf">42fe13d41b5870c23df05e9ed5f55e249340eb3412feac5446d29b4c436897c8</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$payout_token="</span><span class="nf">d1g1NVdrMkJDb0JyY05hTG4rZnRtY09ORnhnUkxFRFl5Z0ZkQWU0MmRkdjJGUTNKMkluWmhNcVpLejZid01qRw</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$payout_secret_key="</span><span class="nf">Test</span><span class="k">"</span><span class="cp">;</span>

	</code></pre>
          </div>
        </div>
      </div>
    </div>
    <!--============3===========-->
    <div class="row" id="beneficiary_via_curl">
      <div class="col-md-7 mt-4">
        <div id="code_3_text" class="card">
          <div class="card-body pt-4 p-3">
            <div >
              <div name="errors" data-unique="beneficiary_via_curl" ></div>
              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3" >Add Beneficiary Via CURL
				
				<a class="blue_r fullscreen" onClick="toggle_fullscreen(this,'#code_3_text');"><i class="fas fa-desktop"></i> <span>Full Screen</span></a>
				
				</h6>
              </div>
              <p> Registered merchants can use the parameters by using POST method [
                <?=$data['SiteName'];?>
                Merchant] to make sure the values won’t be changed.</p>
              <p>Rules to generate an API Keys & Secret Keys:</p>
              <ol>
                <li><strong>Merchant Login -</strong>To login the dashboard, Merchant requires <strong><u>username &amp; password.</u></strong></li>
                <li><strong>Secret Key - </strong>
                  <strong class="text-info"><?=$Secret_Key;?></strong></li>
                <li><strong>Payout Token </strong>
                  <strong class="text-info"><?=$payout_token;?></strong></li>
                <li><strong>Payout Secret Key : </strong>

<strong class="text-info"><?=$payout_secret_key;?></strong></li>
                This code is required when you proceed for Payment Integration.</li>
              </ol>
              <div class="table-responsive p-0 ">
                <table class="table table-striped align-items-center mb-0">
                  <tbody>
                    <tr>
                      <td ><strong>Gateway URL</strong> </td>
                      <td><?=$data['domain_url']?>/payout/addbeneficiary<?=$data['ex']?></td>
                        
                        
                    </tr>
                    <tr>
                      <td><strong>Method</strong> </td>
                      <td>POST</td>
                    </tr>
                    <tr>
                      <td ><strong>Function</strong> </td>
                      <td>Add Beneficiary List for Transfer Amount</td>
                    </tr>
                    <tr>
                      <td ><strong>Remark</strong> </td>
                      <td>mandatory parameters, the others are all optional</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="table-responsive p-0 ">
                <table class="table table-striped align-items-center mb-0">
                  <thead class="bg-info text-white ">
                    <tr>
                      <th>Parameter</th>
                      <th>Description</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td ><strong>secret_key</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Secret Key (e.g. QZfMTEyMF8yMDE4MDcyNzEyMjgyNMj) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$Secret_Key;?></td>
                    </tr>
                    <tr>
                      <td><strong>payout_token</strong>
                        <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="Payout Token ((e.g. QZfMTEyMF8yMDE4MDcyNzEyMjgyNMj) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$payout_token;?></td>
                    </tr>
                    <tr>
                      <td><strong>payout_secret_key</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Payout Secret Key (e.g. Test) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$payout_secret_key;?></td>
                    </tr>
                    <tr>
                      <td><strong>client_ip</strong>
                        <div class="method-details"><span class="blue_r">php</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><div class="word-wrap" style="white-space: normal!important; font-size:8px;">Client IP a php code dynamic get IP value <strong>($_SERVER['HTTP_X_FORWARDED_FOR']? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['SERVER_ADDR'])</strong>.</div></td>
                    </tr>
                    <tr>
                      <td><strong>action</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>action, a string for default (fixed) value <strong>product</strong>.</td>
                    </tr>
                    <tr>
                      <td><strong>source</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>source, a string for default (fixed) value <strong>Encode-Curl-API</strong>.</td>
                    </tr>
                    <tr>
                      <td><strong>source_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>source_url, Product or Service url of source_url as per your domain
                        -<div class="word-wrap" style="white-space: normal!important; font-size:8px;"> a string for default (fixed) value <strong>isset($_SERVER["HTTPS"]) ? 'https://':'http://' . $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI']</strong>.</div></td>
                    </tr>
                    <tr>
                      <td><strong>beneficiary_nickname</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Beneficiary Nickname From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Beneficiary Nickname</td>
                    </tr>
                    <tr>
                      <td><strong>beneficiary_name</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Beneficiary Name From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Beneficiary Name</td>
                    </tr>
                    <tr>
                      <td><strong>account_number</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Bank Account Number From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Bank Account Number</td>
                    </tr>
                    <tr>
                      <td><strong>beneficiary_ac_repeat</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Repeated Bank Account Number From Merchant">C</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Bank Account Number Repeat</td>
                    </tr>
                    <tr>
                      <td><strong>beneficiary_bank_name</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Beneficiary Bank Name From Merchant">C</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Beneficiary Bank Name</td>
                    </tr>
                    <tr>
                      <td><strong>bank_code1</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Bank Code From Merchant">C</abbr></span></div>
                        <div class="method-badge">optional</div></td>
                      <td>Bank Code</td>
                    </tr>
                    <tr>
                      <td><strong>bank_code2</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Bank IFSC Code From Merchant">C</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Bank IFSC Code</td>
                    </tr>
                    <tr>
                      <td><strong>bank_code3</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Swift Code From Merchant">C</abbr></span></div>
                        <div class="method-badge">optional</div></td>
                      <td>Swift Code</td>
                    </tr>

                    <tr>
                      <td><strong>notify_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="notification URL From Merchant">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Synchronous notification URL, you can find it in the response data.</td>
                    </tr>
                    <tr>
                      <td><strong>success_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Success URL From Merchant">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Redirect url of success as per your domain</td>
                    </tr>
                    <tr>
                      <td><strong>error_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Error URL From Merchant">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Redirect url of error as per your domain</td>
                    </tr>
					<tr>
                      <td ><strong>checkout_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Checkout URL From Merchant">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Checkout url as per your domain</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="code_3" class="col-md-5 mt-4 bg-gradient-dark card">
        <div class="card h-100 mb-4 bg-gradient-dark">
          <div class="card-body  p-3">
		  
<blockquote> Example of Add Beneficiary Via CURL: 
				<a class="blue_r fullscreen" onClick="toggle_fullscreen(this,'#code_3');"><i class="fas fa-desktop"></i> <span>Full Screen</span></a>
				<a class="blue_r coppy" onClick="ctcf('#code_3_pre');"><i class="fas fa-copy"></i> Coppy</a>
			</blockquote>
			
<pre id="code_3_pre" class="highlight highlight1 php">
<code><span class="k">$baseurl="</span><span class="nf"><?=$data['domain_url']?></span><span class="k">"</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">Replace of 3 very important parameters </span><span class="nf">* your  Secret Key and  Payout Token</span> <span class="cp">--&gt;</span>
<span class="k">$secret_key="</span><span class="nf">42fe13d41b5870c23df05e9ed5f55e249340eb3412feac5446d29b4c436897c8</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$payout_token="</span><span class="nf">d1g1NVdrMkJDb0JyY05hTG4rZnRtY09ORnhnUkxFRFl5Z0ZkQWU0MmRkdjJGUTNKMkluWmhNcVpLejZid01qRw</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$payout_secret_key="</span><span class="nf">Test</span><span class="k">"</span><span class="cp">;</span>

<span class="k">$gateway_url="</span><span class="nf"><?=$data['domain_url']?>/payout/addbeneficiary<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>

<span class="k1">$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';</span>
<span class="k1">$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];</span>
<span class="k">$pramPost</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>

<span class="k">$pramPost["</span><span class="s1">payout_token</span><span class="k">"]=</span><span class="nf">$payout_token</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">payout_secret_key</span><span class="k">"]=</span><span class="nf">$payout_secret_key</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">default (fixed) value </span><span class="nf">* default</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">checkout</span><span class="k">"]</span><span class="k">="</span><span class="nf">CURL</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">client_ip</span><span class="k">"]</span><span class="k">=</span><span class="nf">($_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['SERVER_ADDR'])</span><span class="k"></span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">action</span><span class="k">"]</span><span class="k">="</span><span class="nf">product</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source</span><span class="k">"]</span><span class="k">="</span><span class="nf">Encode-Curl-API</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source_url</span><span class="k">"]</span><span class="k">=</span><span class="nf">$referer</span><span class="k"></span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">beneficiary detail </span><span class="nf">*</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">beneficiary_nickname</span><span class="k">"]</span><span class="k">="</span><span class="nf">nickname</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">beneficiary_name</span><span class="k">"]</span><span class="k">="</span><span class="nf">Beneficiary Name</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">account_number</span><span class="k">"]</span><span class="k">="</span><span class="nf">1000122211</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">beneficiary_ac_repeat</span><span class="k">"]</span><span class="k">="</span><span class="nf">1000122211</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">beneficiary_bank_name</span><span class="k">"]</span><span class="k">="</span><span class="nf">Test Bank</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bank_code1</span><span class="k">"]</span><span class="k">="</span><span class="nf">BankCode</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bank_code2</span><span class="k">"]</span><span class="k">="</span><span class="nf">IFSC</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bank_code3</span><span class="k">"]</span><span class="k">="</span><span class="nf">Swiftcode</span><span class="k">"</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">Return urls </span><span class="nf">.*</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">notify_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/notify<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">success_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/success<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">error_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/failed<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">checkout_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/checkout_url<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>

<span class="k">$get_string</span><span class="k">=</span><span class="nf"><span class="s1">http_build_query</span>($pramPost)</span><span class="cp">;</span>
<span class="k">$encrypted</span><span class="k">=</span><span class="nf"><span class="s1">data_encode_sha256</span>($get_string,$secret_key,$pramPost['payout_token'])</span><span class="cp">;</span>
<span class="k">$pram_encode</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>
<span class="k">$pram_encode['</span><span class="s1">pram_encode</span><span class="k">']</span><span class="k">=</span><span class="nf">$encrypted.$pramPost["payout_token"]</span><span class="cp">;</span>


 
<span class="k1">$curl_cookie="";</span>
<span class="k1">$curl = curl_init();</span> 
<span class="k1">curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_URL, <span class="k">$gateway_url</span>);</span>
<span class="k1">curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);</span>
<span class="k1">curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);</span>
<span class="k1">curl_setopt($curl, CURLOPT_REFERER, $referer);</span>
<span class="k1">curl_setopt($curl, CURLOPT_POST, 1);</span>
<span class="k1">curl_setopt($curl, CURLOPT_POSTFIELDS, <span class="k">$pram_encode</span>);</span>
<span class="k1">curl_setopt($curl, CURLOPT_HEADER, 0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);</span>
<span class="k1"><span class="k">$response</span> = curl_exec($curl);</span>
<span class="k1">curl_close(<span class="k">$curl</span>);</span>

<span class="k">$results </span><span class="nf">= json_decode</span><span class="nf">(<span class="k">$response</span>,<span class="nf">true</span>)</span><span class="cp">;</span>
<span class="k">$status </span><span class="nf">= strtolower</span><span class="nf">(<span class="k">$results["status"]</span>)</span><span class="cp">;</span>
<span class="k">$sub_query </span><span class="nf">= http_build_query</span><span class="nf">(<span class="k">$results</span>)</span><span class="cp">;</span>


<span class="nt">if(isset(</span><span class="k">$results["</span><span class="s1">authurl</span><span class="k">"]</span><span class="nt">)</span> && <span class="k">$results["</span><span class="s1">authurl</span><span class="k">"]</span><span class="cp">){</span>
<span class="k1">$redirecturl = $results["authurl"];</span>
<span class="k1">header("Location:$redirecturl");exit;</span>
<span class="nt">}elseif(</span><span class="nf">$status==<span class="k">"completed"</span> || </span><span class="nf">$status==<span class="k">"0000"</span> || </span><span class="nf">$status==<span class="k">"success"</span> || </span><span class="nf">$status==<span class="k">"test"</span> || </span><span class="nf">$status==<span class="k">"test transaction"</span></span><span class="cp">){</span>

	$redirecturl = <span class="k">$pramPost["</span><span class="s1">success_url</span><span class="k">"]</span><span class="cp">;</span>
	<span class="cp">if(strpos</span>($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query<span class="cp">;</span>
	<span class="cp">}else{</span>
		$redirecturl = $redirecturl."?".$sub_query<span class="cp">;</span> 
	}
<span class="s1">header("Location:$redirecturl")</span><span class="cp">;</span>exit<span class="cp">;</span>
<span class="cp">}elseif</span>($status==<span class="k">"pending"</span>){
	$redirecturl = <span class="s1">$referer</span><span class="cp">;</span>
	<span class="cp">if(strpos</span>($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query<span class="cp">;</span>
	<span class="cp">}else{</span>
		$redirecturl = $redirecturl."?".$sub_query<span class="cp">;</span>
	}
<span class="s1">header("Location:$redirecturl")</span><span class="cp">;</span>exit<span class="cp">;</span>
<span class="cp">}else{</span>
	$redirecturl = $pramPost["error_url"]<span class="cp">;</span>

	<span class="cp">if(strpos</span>($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query<span class="cp">;</span>
	<span class="cp">}else{</span>
		$redirecturl = $redirecturl."?".$sub_query<span class="cp">;</span>
	}
<span class="s1">header("Location:$redirecturl")</span><span class="cp">;</span>exit<span class="cp">;</span>
}
<span class="k1">
<span class="k">function</span> data_encode_sha256($string,$secret_key,$payout_token) {
	$output = <span class="s1">false;</span>
	$encrypt_method = "AES-256-CBC";
	$iv = substr(hash('sha256', $payout_token), 0, 16);
	$output=rtrim(strtr(base64_encode(openssl_encrypt($string,$encrypt_method,$secret_key,0,$iv)),'+/','-_'),'=');
	<span class="s1">return</span> $output;
}
</span>

</code></pre>
<blockquote><p id="example-response">After posting the data you will get below response:</p>
            </blockquote>
<pre class="highlight plaintext"><code><span class="p">{</span><span class="w">
    </span><span class="nt">"status"</span><span class="p">:</span><span class="s2">"0000"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"bene_id"</span><span class="p">:</span><span class="s2">"123123123"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"reason"</span><span class="p">:</span><span class="s2">"Success"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"remark"</span><span class="p">:</span><span class="s2">"Beneficiary successfully added"</span><span class="p">,</span>
<span class="w"></span><span class="p">}</span>
    
</code></pre>
          </div>
        </div>
      </div>
    </div>
    <!--============4===========-->
    <div class="row" id="add_fund">
      <div class="col-md-7 mt-4">
        <div id="code_4_text" class="card">
          <div class="card-body pt-4 p-3">
            <div >
              <div name="errors" data-unique="add_fund"></div>
              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3" >Add fund via curl
				<a class="blue_r fullscreen" onClick="toggle_fullscreen(this,'#code_4_text');"><i class="fas fa-desktop"></i> <span>Full Screen</span></a>
				</h6>
              </div>
              <p> Registered merchants can use the parameters by using POST method [
                <?=$data['SiteName'];?>
                Merchant] to make sure the values won’t be changed.</p>
              <p>Rules to generate an API Keys & Secret Keys:</p>
              <ol>
                <li><strong>Merchant Login -</strong>To login the dashboard, Merchant requires <strong><u>username &amp; password.</u></strong></li>
                <li><strong>Secret Key - </strong>
                  <strong class="text-info"><?=$Secret_Key;?></strong></li>
                <li><strong>Payout Token </strong>
                  <strong class="text-info"><?=$payout_token;?></strong></li>
                <li><strong>Payout Secret Key : </strong>

<strong class="text-info"><?=$payout_secret_key;?></strong></li>
                This code is required when you proceed for Payment Integration.</li>
              </ol>
              <div class="table-responsive p-0 ">
                <table class="table table-striped align-items-center mb-0">
                  <tbody>
                    <tr>
                      <td ><strong>Gateway URL</strong> </td>
                      <td><?=$data['domain_url']?>/payout/addfund<?=$data['ex']?></td>
                        
                        
                    </tr>
                    <tr>
                      <td><strong>Method</strong> </td>
                      <td>POST</td>
                    </tr>
                    <tr>
                      <td ><strong>Function</strong> </td>
                      <td>Add Fund</td>
                    </tr>
                    <tr>
                      <td ><strong>Remark</strong> </td>
                      <td>mandatory parameters, the others are all optional</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="table-responsive p-0 ">
                <table class="table table-striped align-items-center mb-0">
                  <thead class="bg-info text-white ">
                    <tr>
                      <th>Parameter</th>
                      <th>Description</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td ><strong>secret_key</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Secret Key (e.g. QZfMTEyMF8yMDE4MDcyNzEyMjgyNMj) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$Secret_Key;?></td>
                    </tr>
                    <tr>
                      <td><strong>payout_token</strong>
                        <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="Payout Token ((e.g. QZfMTEyMF8yMDE4MDcyNzEyMjgyNMj) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$payout_token;?></td>
                    </tr>
                    <tr>
                      <td><strong>payout_secret_key</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Payout Secret Key (e.g. Test) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$payout_secret_key;?></td>
                    </tr>
                    <tr>
                      <td><strong>client_ip</strong>
                        <div class="method-details"><span class="blue_r">php</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><div class="word-wrap" style="white-space: normal!important; font-size:8px;">Client IP a php code dynamic get IP value <strong>($_SERVER['HTTP_X_FORWARDED_FOR']? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['SERVER_ADDR'])</strong>.</div></td>
                    </tr>
                    <tr>
                      <td><strong>action</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>action, a string for default (fixed) value <strong>product</strong>.</td>
                    </tr>
                    <tr>
                      <td><strong>source</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>source, a string for default (fixed) value <strong>Payout-Encode</strong>.</td>
                    </tr>
                    <tr>
                      <td><strong>source_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>source_url, Product or Service url of source_url as per your domain
                        -<div class="word-wrap" style="white-space: normal!important; font-size:8px;"> a string for default (fixed) value <strong>isset($_SERVER["HTTPS"]) ? 'https://':'http://' . $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI']</strong>.</div></td>
                    </tr>
                    <tr>
                      <td><strong>amount</strong>
                        <div class="method-details"><span class="blue_r">dec(10.00)</span> <span class="blue_r"><abbr title="price (e.g. 1,500.00) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Amount format in decimal(10.00)</td>
                    </tr>
                    <tr>
                      <td><strong>curr</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Currency From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>INR</td>
                    </tr>
                    <tr>

                      <td><strong>remarks</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Remark From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Remarks</td>
                    </tr>
                    <tr>
                      <td><strong>request_id</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Request ID">C</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Request ID </td>
                    </tr>
                    <tr>
                      <td><strong>product_name</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Product Name">C</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Product Name - 2 (ADD FUND)</td>
                    </tr>
                    <tr>
                      <td><strong>notify_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Notification URL from Merchant">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Synchronous notification URL, you can find it in the response data.</td>
                    </tr>
                    <tr>
                      <td><strong>success_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Success URL from Merchant">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Redirect url of success as per your domain</td>
                    </tr>
                    <tr>
                      <td><strong>error_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Error URL from Merchant">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Redirect url of error as per your domain</td>
                    </tr>
					<tr>
                      <td ><strong>checkout_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Checkout URL from Merchant">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Checkout url as per your domain</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-5 mt-4 bg-gradient-dark card">
        <div id="code_4" class="card h-100 mb-4 bg-gradient-dark">
          <div class="card-body pt-4 p-3">
            <blockquote  > Example of Add Fund Via Curl: 
				<a class="blue_r fullscreen" onClick="toggle_fullscreen(this,'#code_4');"><i class="fas fa-desktop"></i> <span>Full Screen</span></a>
				<a class="blue_r coppy" onClick="ctcf('#code_4_pre');"><i class="fas fa-copy"></i> Coppy</a>
			</blockquote>
            
			
<pre id="code_4_pre" class="highlight php">
<code><span class="k">$baseurl="</span><span class="nf"><?=$data['domain_url']?></span><span class="k">"</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">Replace of 3 very important parameters </span><span class="nf">* your  Secret Key and  Payout Token</span> <span class="cp">--&gt;</span>
<span class="k">$secret_key="</span><span class="nf">42fe13d41b5870c23df05e9ed5f55e249340eb3412feac5446d29b4c436897c8</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$payout_token="</span><span class="nf">d1g1NVdrMkJDb0JyY05hTG4rZnRtY09ORnhnUkxFRFl5Z0ZkQWU0MmRkdjJGUTNKMkluWmhNcVpLejZid01qRw</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$payout_secret_key="</span><span class="nf">Test</span><span class="k">"</span><span class="cp">;</span>

<span class="k">$gateway_url="</span><span class="nf"><?=$data['domain_url']?>/payout/addfund<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>

<span class="k1">$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';</span>
<span class="k1">$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];</span>
<span class="k">$pramPost</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>

<span class="k">$pramPost["</span><span class="s1">payout_token</span><span class="k">"]=</span><span class="nf">$payout_token</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">payout_secret_key</span><span class="k">"]=</span><span class="nf">$payout_secret_key</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">default (fixed) value </span><span class="nf">* default</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">checkout</span><span class="k">"]</span><span class="k">="</span><span class="nf">CURL</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">client_ip</span><span class="k">"]</span><span class="k">=</span><span class="nf">($_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['SERVER_ADDR'])</span><span class="k"></span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">action</span><span class="k">"]</span><span class="k">="</span><span class="nf">addfund</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source</span><span class="k">"]</span><span class="k">="</span><span class="nf">Payout-Encode</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source_url</span><span class="k">"]</span><span class="k">=</span><span class="nf">$referer</span><span class="k"></span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">Transaction detail </span><span class="nf">*</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">amount</span><span class="k">"]</span><span class="k">="</span><span class="nf">11.00</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">curr</span><span class="k">"]</span><span class="k">="</span><span class="nf">INR</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">remarks</span><span class="k">"]</span><span class="k">="</span><span class="nf">Add fund</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">transaction_id</span><span class="k">"]</span><span class="k">=</span><span class="nf">time()</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">product_name</span><span class="k">"]</span><span class="k">=</span><span class="nf">2</span><span class="cp">;</span>


<span class="cp">//&lt;!--</span><span class="k">Return urls </span><span class="nf">.*</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">notify_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/notify<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">success_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/success<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">error_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/failed<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">checkout_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/checkout_url<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>

<span class="k">$get_string</span><span class="k">=</span><span class="nf"><span class="s1">http_build_query</span>($pramPost)</span><span class="cp">;</span>
<span class="k">$encrypted</span><span class="k">=</span><span class="nf"><span class="s1">data_encode_sha256</span>($get_string,$secret_key,$pramPost['payout_token'])</span><span class="cp">;</span>
<span class="k">$pram_encode</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>
<span class="k">$pram_encode['</span><span class="s1">pram_encode</span><span class="k">']</span><span class="k">=</span><span class="nf">$encrypted.$pramPost["payout_token"]</span><span class="cp">;</span>


 
<span class="k1">$curl_cookie="";</span>
<span class="k1">$curl = curl_init();</span> 
<span class="k1">curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_URL, <span class="k">$gateway_url</span>);</span>
<span class="k1">curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);</span>
<span class="k1">curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);</span>
<span class="k1">curl_setopt($curl, CURLOPT_REFERER, $referer);</span>
<span class="k1">curl_setopt($curl, CURLOPT_POST, 1);</span>
<span class="k1">curl_setopt($curl, CURLOPT_POSTFIELDS, <span class="k">$pram_encode</span>);</span>
<span class="k1">curl_setopt($curl, CURLOPT_HEADER, 0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);</span>
<span class="k1"><span class="k">$response</span> = curl_exec($curl);</span>
<span class="k1">curl_close(<span class="k">$curl</span>);</span>

<span class="k">$results </span><span class="nf">= json_decode</span><span class="nf">(<span class="k">$response</span>,<span class="nf">true</span>)</span><span class="cp">;</span>
<span class="k">$status </span><span class="nf">= strtolower</span><span class="nf">(<span class="k">$results["status"]</span>)</span><span class="cp">;</span>
<span class="k">$sub_query </span><span class="nf">= http_build_query</span><span class="nf">(<span class="k">$results</span>)</span><span class="cp">;</span>


<span class="nt">if(isset(</span><span class="k">$results["</span><span class="s1">authurl</span><span class="k">"]</span><span class="nt">)</span> && <span class="k">$results["</span><span class="s1">authurl</span><span class="k">"]</span><span class="cp">){</span>
<span class="k1">$redirecturl = $results["authurl"];</span>
<span class="k1">header("Location:$redirecturl");exit;</span>
<span class="nt">}elseif(</span><span class="nf">$status==<span class="k">"completed"</span> || </span><span class="nf">$status==<span class="k">"0000"</span> || </span><span class="nf">$status==<span class="k">"success"</span> || </span><span class="nf">$status==<span class="k">"test"</span> || </span><span class="nf">$status==<span class="k">"test transaction"</span></span><span class="cp">){</span>

	$redirecturl = <span class="k">$pramPost["</span><span class="s1">success_url</span><span class="k">"]</span><span class="cp">;</span>
	<span class="cp">if(strpos</span>($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query<span class="cp">;</span>
	<span class="cp">}else{</span>
		$redirecturl = $redirecturl."?".$sub_query<span class="cp">;</span> 
	}
<span class="s1">header("Location:$redirecturl")</span><span class="cp">;</span>exit<span class="cp">;</span>
<span class="cp">}elseif</span>($status==<span class="k">"pending"</span>){
	$redirecturl = <span class="s1">$referer</span><span class="cp">;</span>
	<span class="cp">if(strpos</span>($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query<span class="cp">;</span>
	<span class="cp">}else{</span>
		$redirecturl = $redirecturl."?".$sub_query<span class="cp">;</span>
	}
<span class="s1">header("Location:$redirecturl")</span><span class="cp">;</span>exit<span class="cp">;</span>
<span class="cp">}else{</span>
	$redirecturl = $pramPost["error_url"]<span class="cp">;</span>

	<span class="cp">if(strpos</span>($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query<span class="cp">;</span>
	<span class="cp">}else{</span>
		$redirecturl = $redirecturl."?".$sub_query<span class="cp">;</span>
	}
<span class="s1">header("Location:$redirecturl")</span><span class="cp">;</span>exit<span class="cp">;</span>
}
<span class="k1">
<span class="k">function</span> data_encode_sha256($string,$secret_key,$payout_token) {
	$output = <span class="s1">false;</span>
	$encrypt_method = "AES-256-CBC";
	$iv = substr(hash('sha256', $payout_token), 0, 16);
	$output=rtrim(strtr(base64_encode(openssl_encrypt($string,$encrypt_method,$secret_key,0,$iv)),'+/','-_'),'=');
	<span class="s1">return</span> $output;
}
</span>

</code></pre>

<blockquote>
              <p id="example-response">After posting the data you will get below response:</p>
            </blockquote>
			
<pre class="highlight plaintext"><code><span class="p">{</span><span class="w">
    </span><span class="nt">"status"</span><span class="p">:</span><span class="s2">"0000"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"amount"</span><span class="p">:</span><span class="s2">"11.00"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"reason"</span><span class="p">:</span><span class="s2">"Success"</span><span class="p">,</span><span class="w"></span><span class="p">}</span>
</code></pre>


          </div>
        </div>
      </div>
    </div>
    <!--============5===========-->
    <div class="row" id="Send_fund_via_curl">
      <div id="code_5_text" class="col-md-7 mt-4">
        <div class="card">
          <div class="card-body pt-4 p-3">
            <div >
              <div name="errors" data-unique="Send_fund_via_curl"></div>
              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3" >Send fund via curl
				<a class="blue_r fullscreen" onClick="toggle_fullscreen(this,'#code_5_text');"><i class="fas fa-desktop"></i> <span>Full Screen</span></a>
				</h6>
              </div>
              <p> Registered merchants can use the parameters by using POST method [
                <?=$data['SiteName'];?>
                Merchant] to make sure the values won’t be changed.</p>
              <p>Rules to generate an API Keys & Secret Keys:</p>
              <ol>
                <li><strong>Merchant Login -</strong>To login the dashboard, Merchant requires <strong><u>username &amp; password.</u></strong></li>
                <li><strong>Secret Key - </strong>
                  <strong class="text-info"><?=$Secret_Key;?></strong></li>
                <li><strong>Payout Token </strong>
                  <strong class="text-info"><?=$payout_token;?></strong></li>
                <li><strong>Payout Secret Key : </strong>

<strong class="text-info"><?=$payout_secret_key;?></strong></li>
                This code is required when you proceed for Payment Integration.</li>
              </ol>
              <div class="table-responsive p-0 ">
                <table class="table table-striped align-items-center mb-0">
                  <tbody>
                    <tr>
                      <td ><strong>Gateway URL</strong> </td>
                      <td><?=$data['domain_url']?>/payout/sendpayout<?=$data['ex']?></td>
                        
                        
                    </tr>
                    <tr>
                      <td><strong>Method</strong> </td>
                      <td>POST</td>
                    </tr>
                    <tr>
                      <td ><strong>Function</strong> </td>
                      <td>Send fund</td>
                    </tr>
                    <tr>
                      <td ><strong>Remark</strong> </td>
                      <td>mandatory parameters, the others are all optional</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="table-responsive p-0 ">
                <table class="table table-striped align-items-center mb-0">
                  <thead class="bg-info text-white ">
                    <tr>
                      <th>Parameter</th>
                      <th>Description</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td ><strong>secret_key</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Secret Key (e.g. QZfMTEyMF8yMDE4MDcyNzEyMjgyNMj) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$Secret_Key;?></td>
                    </tr>
                    <tr>
                      <td><strong>payout_token</strong>
                        <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="Payout Token ((e.g. QZfMTEyMF8yMDE4MDcyNzEyMjgyNMj) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$payout_token;?></td>
                    </tr>
                    <tr>
                      <td><strong>payout_secret_key</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Payout Secret Key (e.g. Test) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$payout_secret_key;?></td>
                    </tr>
                    <tr>
                      <td><strong>client_ip</strong>
                        <div class="method-details"><span class="blue_r">php</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><div class="word-wrap" style="white-space: normal!important; font-size:8px;">Client IP a php code dynamic get IP value <strong>($_SERVER['HTTP_X_FORWARDED_FOR']? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['SERVER_ADDR'])</strong>.</div></td>
                    </tr>
                    <tr>
                      <td><strong>action</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>action, a string for default (fixed) value <strong>product</strong>.</td>
                    </tr>
                    <tr>
                      <td><strong>source</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>source, a string for default (fixed) value <strong>Payout-Encode</strong>.</td>
                    </tr>
                    <tr>
                      <td><strong>source_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>source_url, Product or Service url of source_url as per your domain
                        -<div class="word-wrap" style="white-space: normal!important; font-size:8px;"> a string for default (fixed) value <strong>isset($_SERVER["HTTPS"]) ? 'https://':'http://' . $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI']</strong>.</div></td>
                    </tr>
                    <tr>
                      <td><strong>price</strong>
                        <div class="method-details"><span class="blue_r">dec(10.00)</span> <span class="blue_r"><abbr title="price (e.g. 1,500.00) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Amount format in decimal(10.00)</td>
                    </tr>
                    <tr>
                      <td><strong>curr</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Currency From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>INR</td>
                    </tr>
                    <tr>

                      <td><strong>remarks</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Remark From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Remarks</td>
                    </tr>
					
					<tr>

                      <td><strong>narration</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Narration From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Description</td>
                    </tr>
                    <tr>
                      <td><strong>request_id</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Request ID">C</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Request ID </td>
                    </tr>
                    <tr>
                      <td><strong>product_name</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Product Name - SEND FUND">C</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Product Name - 3</td>
                    </tr>
					
					<tr>
                      <td><strong>beneficiary_id</strong>
                        <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="Beneficiary ID">C</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Beneficiary ID</td>
                    </tr>
                    <tr>
                      <td><strong>notify_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant Notification URL">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Synchronous notification URL, you can find it in the response data.</td>
                    </tr>
                    <tr>
                      <td><strong>success_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant success URL">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Redirect url of success as per your domain</td>
                    </tr>
                    <tr>
                      <td><strong>error_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant error URL">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Redirect url of error as per your domain</td>
                    </tr>
					<tr>
                      <td ><strong>checkout_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Checkout url">M</abbr></span></div>
                        <div class="method-details">optional</div></td>
                      <td>Checkout url as per your domain</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="code_5" class="col-md-5 mt-4 bg-gradient-dark card">
        <div class="card h-100 mb-4 bg-gradient-dark">
          <div class="card-body pt-4 p-3">
		  
<blockquote> Example of Send fund via curl: 
			<a class="blue_r fullscreen" onClick="toggle_fullscreen(this,'#code_5');"><i class="fas fa-desktop"></i> <span>Full Screen</span></a>
				<a class="blue_r coppy" onClick="ctcf('#code_5_pre');"><i class="fas fa-copy"></i> Coppy</a>
			</blockquote>
			
<pre id="code_5_pre" class="highlight highlight1 php">
<code><span class="k">$baseurl="</span><span class="nf"><?=$data['domain_url']?></span><span class="k">"</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">Replace of 3 very important parameters </span><span class="nf">* your  Secret Key and  Payout Token</span> <span class="cp">--&gt;</span>
<span class="k">$secret_key="</span><span class="nf">42fe13d41b5870c23df05e9ed5f55e249340eb3412feac5446d29b4c436897c8</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$payout_token="</span><span class="nf">d1g1NVdrMkJDb0JyY05hTG4rZnRtY09ORnhnUkxFRFl5Z0ZkQWU0MmRkdjJGUTNKMkluWmhNcVpLejZid01qRw</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$payout_secret_key="</span><span class="nf">Test</span><span class="k">"</span><span class="cp">;</span>

<span class="k">$gateway_url="</span><span class="nf"><?=$data['domain_url']?>/payout/sendpayout<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>

<span class="k1">$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';</span>
<span class="k1">$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];</span>
<span class="k">$pramPost</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>

<span class="k">$pramPost["</span><span class="s1">payout_token</span><span class="k">"]=</span><span class="nf">$payout_token</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">payout_secret_key</span><span class="k">"]=</span><span class="nf">$payout_secret_key</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">default (fixed) value </span><span class="nf">* default</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">checkout</span><span class="k">"]</span><span class="k">="</span><span class="nf">CURL</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">client_ip</span><span class="k">"]</span><span class="k">=</span><span class="nf">($_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['SERVER_ADDR'])</span><span class="k"></span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">action</span><span class="k">"]</span><span class="k">="</span><span class="nf">payout</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source</span><span class="k">"]</span><span class="k">="</span><span class="nf">Payout-Encode</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source_url</span><span class="k">"]</span><span class="k">=</span><span class="nf">$referer</span><span class="k"></span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">Transaction detail </span><span class="nf">*</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">price</span><span class="k">"]</span><span class="k">="</span><span class="nf">11.00</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">curr</span><span class="k">"]</span><span class="k">="</span><span class="nf">INR</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">remarks</span><span class="k">"]</span><span class="k">="</span><span class="nf">Add fund</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">narration</span><span class="k">"]</span><span class="k">="</span><span class="nf">Description</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">request_id</span><span class="k">"]</span><span class="k">=</span><span class="nf">time()</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">product_name</span><span class="k">"]</span><span class="k">=</span><span class="nf">3</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">beneficiary_id</span><span class="k">"]</span><span class="k">="</span><span class="nf">10003</span><span class="k">"</span><span class="cp">;</span>


<span class="cp">//&lt;!--</span><span class="k">Return urls </span><span class="nf">.*</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">notify_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/notify<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">success_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/success<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">error_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/failed<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">checkout_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/checkout_url<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>

<span class="k">$get_string</span><span class="k">=</span><span class="nf"><span class="s1">http_build_query</span>($pramPost)</span><span class="cp">;</span>
<span class="k">$encrypted</span><span class="k">=</span><span class="nf"><span class="s1">data_encode_sha256</span>($get_string,$secret_key,$pramPost['payout_token'])</span><span class="cp">;</span>
<span class="k">$pram_encode</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>
<span class="k">$pram_encode['</span><span class="s1">pram_encode</span><span class="k">']</span><span class="k">=</span><span class="nf">$encrypted.$pramPost["payout_token"]</span><span class="cp">;</span>


 
<span class="k1">$curl_cookie="";</span>
<span class="k1">$curl = curl_init();</span> 
<span class="k1">curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_URL, <span class="k">$gateway_url</span>);</span>
<span class="k1">curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);</span>
<span class="k1">curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);</span>
<span class="k1">curl_setopt($curl, CURLOPT_REFERER, $referer);</span>
<span class="k1">curl_setopt($curl, CURLOPT_POST, 1);</span>
<span class="k1">curl_setopt($curl, CURLOPT_POSTFIELDS, <span class="k">$pram_encode</span>);</span>
<span class="k1">curl_setopt($curl, CURLOPT_HEADER, 0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);</span>
<span class="k1"><span class="k">$response</span> = curl_exec($curl);</span>
<span class="k1">curl_close(<span class="k">$curl</span>);</span>

<span class="k">$results </span><span class="nf">= json_decode</span><span class="nf">(<span class="k">$response</span>,<span class="nf">true</span>)</span><span class="cp">;</span>
<span class="k">$status </span><span class="nf">= strtolower</span><span class="nf">(<span class="k">$results["status"]</span>)</span><span class="cp">;</span>
<span class="k">$sub_query </span><span class="nf">= http_build_query</span><span class="nf">(<span class="k">$results</span>)</span><span class="cp">;</span>


<span class="nt">if(isset(</span><span class="k">$results["</span><span class="s1">authurl</span><span class="k">"]</span><span class="nt">)</span> && <span class="k">$results["</span><span class="s1">authurl</span><span class="k">"]</span><span class="cp">){</span>
<span class="k1">$redirecturl = $results["authurl"];</span>
<span class="k1">header("Location:$redirecturl");exit;</span>
<span class="nt">}elseif(</span><span class="nf">$status==<span class="k">"completed"</span> || </span><span class="nf">$status==<span class="k">"0000"</span> || </span><span class="nf">$status==<span class="k">"success"</span> || </span><span class="nf">$status==<span class="k">"test"</span> || </span><span class="nf">$status==<span class="k">"test transaction"</span></span><span class="cp">){</span>

	$redirecturl = <span class="k">$pramPost["</span><span class="s1">success_url</span><span class="k">"]</span><span class="cp">;</span>
	<span class="cp">if(strpos</span>($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query<span class="cp">;</span>
	<span class="cp">}else{</span>
		$redirecturl = $redirecturl."?".$sub_query<span class="cp">;</span> 
	}
<span class="s1">header("Location:$redirecturl")</span><span class="cp">;</span>exit<span class="cp">;</span>
<span class="cp">}elseif</span>($status==<span class="k">"pending"</span>){
	$redirecturl = <span class="s1">$referer</span><span class="cp">;</span>
	<span class="cp">if(strpos</span>($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query<span class="cp">;</span>
	<span class="cp">}else{</span>
		$redirecturl = $redirecturl."?".$sub_query<span class="cp">;</span>
	}
<span class="s1">header("Location:$redirecturl")</span><span class="cp">;</span>exit<span class="cp">;</span>
<span class="cp">}else{</span>
	$redirecturl = $pramPost["error_url"]<span class="cp">;</span>

	<span class="cp">if(strpos</span>($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query<span class="cp">;</span>
	<span class="cp">}else{</span>
		$redirecturl = $redirecturl."?".$sub_query<span class="cp">;</span>
	}
<span class="s1">header("Location:$redirecturl")</span><span class="cp">;</span>exit<span class="cp">;</span>
}
<span class="k1">
<span class="k">function</span> data_encode_sha256($string,$secret_key,$payout_token) {
	$output = <span class="s1">false;</span>
	$encrypt_method = "AES-256-CBC";
	$iv = substr(hash('sha256', $payout_token), 0, 16);
	$output=rtrim(strtr(base64_encode(openssl_encrypt($string,$encrypt_method,$secret_key,0,$iv)),'+/','-_'),'=');
	<span class="s1">return</span> $output;
}
</span>

</code></pre>

<blockquote>
              <p id="example-response">After posting the data you will get below response:</p>
            </blockquote>
			
<pre class="highlight plaintext">
<code>
<span class="p">{</span>
<span class="w"></span><span class="nt">"status"</span><span class="p">:</span><span class="s2">"0000"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"successId"</span><span class="p">:</span><span class="s2">"1212112"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"reason"</span><span class="p">:</span><span class="s2">"Success"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"transaction_id"</span><span class="p">:</span><span class="s2">"1233331233"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"status_nm"</span><span class="p">:</span><span class="s2">"1"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"payout_currency"</span><span class="p">:</span><span class="s2">"INR"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"payout_amount"</span><span class="p">:</span><span class="s2">"11.00"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"available_balance"</span><span class="p">:</span><span class="s2">"12345.00"</span><span class="p">,</span>
<span class="p">}</span>
</code></pre>
          </div>
        </div>
      </div>
    </div>
    <!--============6===========-->
    <div class="row" id="check_payment_status">
      <div id="code_6_text" class="col-md-7 mt-4">
        <div class="card">
          <div class="card-body pt-4 p-3">
            <div >
              <div name="errors" data-unique="check_payment_status"></div>
              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3" >Check payment status
				
				<a class="blue_r fullscreen" onClick="toggle_fullscreen(this,'#code_6_text');"><i class="fas fa-desktop"></i> <span>Full Screen</span></a>
				</h6>
              </div>
              <p> Registered merchants can use the parameters by using POST method [
                <?=$data['SiteName'];?>
                Merchant] to make sure the values won’t be changed.</p>
              <p>Rules to generate an API Keys & Secret Keys:</p>
              <ol>
                <li><strong>Merchant Login -</strong>To login the dashboard, Merchant requires <strong><u>username &amp; password.</u></strong></li>
                <li><strong>Secret Key - </strong>
                  <strong class="text-info"><?=$Secret_Key;?></strong></li>
                <li><strong>Payout Token </strong>
                  <strong class="text-info"><?=$payout_token;?></strong></li>
                <li><strong>Payout Secret Key : </strong>

<strong class="text-info"><?=$payout_secret_key;?></strong></li>
                This code is required when you proceed for Payment Integration.</li>
              </ol>
              <div class="table-responsive p-0 ">
                <table class="table table-striped align-items-center mb-0">
                  <tbody>
                    <tr>
                      <td ><strong>Gateway URL</strong> </td>
                      <td><?=$data['domain_url']?>/payout/payoutdetail<?=$data['ex']?></td>
                        
                        
                    </tr>
                    <tr>
                      <td><strong>Method</strong> </td>
                      <td>POST</td>
                    </tr>
                    <tr>
                      <td ><strong>Function</strong> </td>
                      <td>For Check payment status</td>
                    </tr>
                    <tr>
                      <td ><strong>Remark</strong> </td>
                      <td>mandatory parameters, the others are all optional</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="table-responsive p-0 ">
                <table class="table table-striped align-items-center mb-0">
                  <thead class="bg-info text-white ">
                    <tr>
                      <th>Parameter</th>
                      <th>Description</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td ><strong>secret_key</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Secret Key (e.g. QZfMTEyMF8yMDE4MDcyNzEyMjgyNMj) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$Secret_Key;?></td>
                    </tr>
                    <tr>
                      <td><strong>payout_token</strong>
                        <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="Payout Token ((e.g. QZfMTEyMF8yMDE4MDcyNzEyMjgyNMj) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$payout_token;?></td>
                    </tr>
                    <tr>
                      <td><strong>payout_secret_key</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Payout Secret Key (e.g. Test) From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><?=$payout_secret_key;?></td>
                    </tr>
                    <tr>
                      <td><strong>client_ip</strong>
                        <div class="method-details"><span class="blue_r">php</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td><div class="word-wrap" style="white-space: normal!important; font-size:8px;">Client IP a php code dynamic get IP value <strong>($_SERVER['HTTP_X_FORWARDED_FOR']? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['SERVER_ADDR'])</strong>.</div></td>
                    </tr>
                    <tr>
                      <td><strong>action</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>action, a string for default (fixed) value <strong>paymentdetail</strong>.</td>
                    </tr>
                    <tr>
                      <td><strong>source</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>source, a string for default (fixed) value <strong>Payout-Encode</strong>.</td>
                    </tr>
                    <tr>
                      <td><strong>source_url</strong>
                        <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>source_url, Product or Service url of source_url as per your domain
                        -<div class="word-wrap" style="white-space: normal!important; font-size:8px;"> a string for default (fixed) value <strong>isset($_SERVER["HTTPS"]) ? 'https://':'http://' . $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI']</strong>.</div></td>
                    </tr>
                    
                    <tr>
                      <td><strong>transaction_id</strong>
                        <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="Transaction ID From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Transaction ID</td>
                    </tr>
                    <tr>

                      <td><strong>order_number</strong>
                        <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="Order Number From Merchant ">M</abbr></span></div>
                        <div class="method-badge">required</div></td>
                      <td>Order Number</td>
                    </tr>
					
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="code_6" class="col-md-5 mt-4 bg-gradient-dark card">
        <div class="card h-100 mb-4 bg-gradient-dark">
          <div class="card-body pt-4 p-3">
            <blockquote> Example of Check Payment Status:
				<a class="blue_r fullscreen" onClick="toggle_fullscreen(this,'#code_6');"><i class="fas fa-desktop"></i> <span>Full Screen</span></a>
				<a class="blue_r coppy" onClick="ctcf('#code_6_pre');"><i class="fas fa-copy"></i> Coppy</a>
			</blockquote>
			
 <pre id="code_6_pre" class="highlight highlight1 php">
<code><span class="k">$baseurl="</span><span class="nf"><?=$data['domain_url']?></span><span class="k">"</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">Replace of 3 very important parameters </span><span class="nf">* your  Secret Key and  Payout Token</span> <span class="cp">--&gt;</span>
<span class="k">$secret_key="</span><span class="nf">42fe13d41b5870c23df05e9ed5f55e249340eb3412feac5446d29b4c436897c8</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$payout_token="</span><span class="nf">d1g1NVdrMkJDb0JyY05hTG4rZnRtY09ORnhnUkxFRFl5Z0ZkQWU0MmRkdjJGUTNKMkluWmhNcVpLejZid01qRw</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$payout_secret_key="</span><span class="nf">Test</span><span class="k">"</span><span class="cp">;</span>

<span class="k">$gateway_url="</span><span class="nf"><?=$data['domain_url']?>/payout/payoutdetail<?=$data['ex'];?></span><span class="k">"</span><span class="cp">;</span>

<span class="k1">$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';</span>
<span class="k1">$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];</span>
<span class="k">$pramPost</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>

<span class="k">$pramPost["</span><span class="s1">payout_token</span><span class="k">"]=</span><span class="nf">$payout_token</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">payout_secret_key</span><span class="k">"]=</span><span class="nf">$payout_secret_key</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">default (fixed) value </span><span class="nf">* default</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">checkout</span><span class="k">"]</span><span class="k">="</span><span class="nf">CURL</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">client_ip</span><span class="k">"]</span><span class="k">=</span><span class="nf">($_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['SERVER_ADDR'])</span><span class="k"></span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">action</span><span class="k">"]</span><span class="k">="</span><span class="nf">paymentdetail</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source</span><span class="k">"]</span><span class="k">="</span><span class="nf">Payout-Encode</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source_url</span><span class="k">"]</span><span class="k">=</span><span class="nf">$referer</span><span class="k"></span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">transaction_id</span><span class="k">"]</span><span class="k">=</span><span class="nf">1234567890</span><span class="k"></span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">order_number</span><span class="k">"]</span><span class="k">=</span><span class="nf">123456</span><span class="k"></span><span class="cp">;</span>

<span class="k">$get_string</span><span class="k">=</span><span class="nf"><span class="s1">http_build_query</span>($pramPost)</span><span class="cp">;</span>
<span class="k">$encrypted</span><span class="k">=</span><span class="nf"><span class="s1">data_encode_sha256</span>($get_string,$secret_key,$pramPost['payout_token'])</span><span class="cp">;</span>
<span class="k">$pram_encode</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>
<span class="k">$pram_encode['</span><span class="s1">pram_encode</span><span class="k">']</span><span class="k">=</span><span class="nf">$encrypted.$pramPost["payout_token"]</span><span class="cp">;</span>


 
<span class="k1">$curl_cookie="";</span>
<span class="k1">$curl = curl_init();</span> 
<span class="k1">curl_setopt($curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_URL, <span class="k">$gateway_url</span>);</span>
<span class="k1">curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);</span>
<span class="k1">curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);</span>
<span class="k1">curl_setopt($curl, CURLOPT_REFERER, $referer);</span>
<span class="k1">curl_setopt($curl, CURLOPT_POST, 1);</span>
<span class="k1">curl_setopt($curl, CURLOPT_POSTFIELDS, <span class="k">$pram_encode</span>);</span>
<span class="k1">curl_setopt($curl, CURLOPT_HEADER, 0);</span>
<span class="k1">curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);</span>
<span class="k1"><span class="k">$response</span> = curl_exec($curl);</span>
<span class="k1">curl_close(<span class="k">$curl</span>);</span>

<span class="k">$results </span><span class="nf">= json_decode</span><span class="nf">(<span class="k">$response</span>,<span class="nf">true</span>)</span><span class="cp">;</span>
<span class="k">$status </span><span class="nf">= strtolower</span><span class="nf">(<span class="k">$results["status"]</span>)</span><span class="cp">;</span>
<span class="k">$sub_query </span><span class="nf">= http_build_query</span><span class="nf">(<span class="k">$results</span>)</span><span class="cp">;</span>


<span class="nt">if(isset(</span><span class="k">$results["</span><span class="s1">authurl</span><span class="k">"]</span><span class="nt">)</span> && <span class="k">$results["</span><span class="s1">authurl</span><span class="k">"]</span><span class="cp">){</span>
<span class="k1">$redirecturl = $results["authurl"];</span>
<span class="k1">header("Location:$redirecturl");exit;</span>
<span class="nt">}elseif(</span><span class="nf">$status==<span class="k">"completed"</span> || </span><span class="nf">$status==<span class="k">"0000"</span> || </span><span class="nf">$status==<span class="k">"success"</span> || </span><span class="nf">$status==<span class="k">"test"</span> || </span><span class="nf">$status==<span class="k">"test transaction"</span></span><span class="cp">){</span>

	$redirecturl = <span class="k">$pramPost["</span><span class="s1">success_url</span><span class="k">"]</span><span class="cp">;</span>
	
	<span class="cp">if($results['status']</span>=='0000'){
	print_r($results);exit;
	<span class="cp">}else{</span>
	$_SESSION['Error'] = $results['status'].' - '.$results['reason'];
	}

<span class="k1">
<span class="k">function</span> data_encode_sha256($string,$secret_key,$payout_token) {
	$output = <span class="s1">false;</span>
	$encrypt_method = "AES-256-CBC";
	$iv = substr(hash('sha256', $payout_token), 0, 16);
	$output=rtrim(strtr(base64_encode(openssl_encrypt($string,$encrypt_method,$secret_key,0,$iv)),'+/','-_'),'=');
	<span class="s1">return</span> $output;
}
</span>

</code></pre>

<blockquote><p id="example-response">Response - Success</p></blockquote>
			
<pre class="highlight plaintext">
<code>
<span class="p">{</span>
<span class="w"></span><span class="nt">"status"</span><span class="p">:</span><span class="s2"> "0000"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"transaction_type"</span><span class="p">:</span><span class="s2">"2"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"transaction_for"</span><span class="p">:</span><span class="s2"> "Send Fund"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"transaction_date"</span><span class="p">:</span><span class="s2"> "2022-07-25 14:46:53"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"order_currency"</span><span class="p">:</span><span class="s2"> "THB"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"order_amount"</span><span class="p">:</span><span class="s2"> "91.00"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"transaction_currency"</span><span class="p">:</span><span class="s2"> "THB"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"transaction_amount"</span><span class="p">:</span><span class="s2"> "91.00"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"mdr_amt"</span><span class="p">:</span><span class="s2"> "4.55"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"mdr_percentage"</span><span class="p">:</span><span class="s2"> "5.00"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"payout_amount"</span><span class="p">:</span><span class="s2"> "86.450"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"available_balance"</span><span class="p">:</span><span class="s2"> "7746.88"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"sender_name"</span><span class="p">:</span><span class="s2"> null</span><span class="p">,</span>
<span class="w"></span><span class="nt">"beneficiary_id"</span><span class="p">:</span><span class="s2"> "27005720426"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"remarks"</span><span class="p">:</span><span class="s2"> "remarks "</span><span class="p">,</span>
<span class="w"></span><span class="nt">"narration"</span><span class="p">:</span><span class="s2"> "narration"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"transaction_status"</span><span class="p">:</span><span class="s2"> "1"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"notify_url"</span><span class="p">:</span><span class="s2"> "notify_url"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"success_url"</span><span class="p">:</span><span class="s2"> "success_url"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"failed_url"</span><span class="p">:</span><span class="s2"> "failed_url"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"host_name"</span><span class="p">:</span><span class="s2"> "host name"</span><span class="p">,</span>
<span class="p">}</span>
</code></pre>

<blockquote>
              <p id="example-response">Response - Fail</p>
            </blockquote>
			
<pre class="highlight plaintext">
<code>
<span class="p">{</span>
<span class="w"></span><span class="nt">"status"</span><span class="p">:</span><span class="s2"> "response code"</span><span class="p">,</span>
<span class="w"></span><span class="nt">"reason"</span><span class="p">:</span><span class="s2">"failure reason"</span><span class="p">,</span>



<span class="p">}</span>
</code></pre>

          </div>
        </div>
      </div>
    </div>
	
	
	<!--============00===========-->
    
    <!--============7===========-->
    
    <!--============8===========-->
    
    <!--============9===========-->
    
    <!--============10===========-->
    
    <!--============11===========-->
    
    <!--============12===========-->
    
    <!--============13===========-->
    
    <!--============14===========-->
    
    <!--============15===========-->
    
    <!--============response_status===========-->
    <div class="row">
      <div class="col-md-12 mt-4">
        <div class="card">
          <div class="card-body pt-4 p-3">
            <div >
              <div name="response_status" data-unique="response_status"></div>
              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3" id="response_status">Response Status</h6>
              </div>
              <dl class="col_2">
<dt><em>Code</em></dt><dd><em>Status</em></dd>
<dt>0000</dt><dd>Success</dd>
<dt>0001</dt><dd>Low Balance</dd>
<dt>0002</dt><dd>Duplicate Entry</dd>
<dt>0003</dt><dd>Beneficiary not exists.</dd>
<dt>0004</dt><dd>Unauthorized</dd>
<dt>0005</dt><dd>Invalid payout token or Invalid secret key</dd>
<dt>0006</dt><dd>Invalid value in action</dd>
<dt>0007</dt><dd>transaction_id required</dd>
<dt>0008</dt><dd>order_number required</dd>
<dt>0009</dt><dd>transaction_id not exists</dd>
<dt>0010</dt><dd>order_number not exists</dd>
              </dl>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--============payment_status===========-->
    <div class="row">
      <div class="col-md-12 mt-4">
        <div class="card">
          <div class="card-body pt-4 p-3">
            <div >
              <div name="payment_status" data-unique="payment_status"></div>
              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3" id="payment_status">Payment Status</h6>
              </div>
              <dl class="col_2">
<dt><em>Code</em></dt><dd><em>Status</em></dd>



<dt>0</dt><dd>Pending</dd>
<dt>1</dt><dd>Success</dd>
<dt>2</dt><dd>Failed</dd>
<dt>3</dt><dd>Processing</dd>
<dt>10</dt><dd>Scrubbed</dd>


              </dl>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--============beneficiary_status===========-->
    <div class="row">
      <div class="col-md-12 mt-4">
        <div class="card">
          <div class="card-body pt-4 p-3">
            <div >
              <div name="beneficiary_status" data-unique="beneficiary_status"></div>
              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3" id="beneficiary_status">Beneficiary Status</h6>
              </div>
              <dl class="col_2">
<dt><em>Code</em></dt><dd><em>Status</em></dd>



<dt>0</dt><dd>Pending</dd>
<dt>1</dt><dd>Permitted</dd>
<dt>2</dt><dd>Blocked</dd>
<dt>3</dt><dd>Under Process</dd>


              </dl>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--============Currency Support===========-->
    <div class="row">
      <div class="col-md-12 mt-4">
        <div class="card">
          <div class="card-body pt-4 p-3">
            <div >
              <div name="currency_support" data-unique="currency_support"></div>
              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3" id="currency_support">16. Currency Support</h6>
              </div>
              <dl class="col_2">
<dt><em>Currency Code</em></dt><dd><em>Currency Meaning</em></dd>

<?php /*?><? foreach ($data['AVAILABLE_CURRENCY_MEANING'] as $key=>$val){ ?>
<dt><?=$key;?></dt><dd><?=$val;?></dd>
<? } ?><?php */?>


<dt>INR</dt><dd>Indian Rupee</dd>


              </dl>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>
<script src="<?=$data['TEMPATH']?>/common/js/jquery-3.6.0.min.js"></script>
<script>
function toggle_fullscreen(e,theSelect=''){
	if (
		document.fullscreenElement ||
		document.webkitFullscreenElement ||
		document.mozFullScreenElement ||
		document.msFullscreenElement
	  ) {
		
			$(theSelect).css({
			   overflow: 'hidden'
		   });
		  
		   $('.coppy').show(1000);
		   
		if (document.exitFullscreen) {
		  document.exitFullscreen();
		} else if (document.mozCancelFullScreen) {
		  document.mozCancelFullScreen();
		} else if (document.webkitExitFullscreen) {
		  document.webkitExitFullscreen();
		} else if (document.msExitFullscreen) {
		  document.msExitFullscreen();
		}
		
		 $(e).find('span').text('Full Screen');
		 
	  } else {
		element = $(theSelect).get(0);
		$(theSelect).css({
		   overflow: 'auto'
		});
		$(e).find('span').text('Exit Full Screen');
		$('.coppy').hide(500);
		if (element.requestFullscreen) {
		  element.requestFullscreen();
		} else if (element.mozRequestFullScreen) {
		  element.mozRequestFullScreen();
		} else if (element.webkitRequestFullscreen) {
		  element.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
		} else if (element.msRequestFullscreen) {
		  element.msRequestFullscreen();
		}
	  }
	  
}
function ctcf(theText, theAttr = '') {
	if(theAttr){
		text=$(theText).attr(theAttr);
	}
	else{
		text=$(theText).text();
	}
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

$(document).ready(function () {
   // $(document).on("scroll", onScroll);
    
    //smoothscroll
    $('a1[href^="#"]').on('click', function (e) {
        e.preventDefault();
        //$(document).off("scroll");
        
        $('a').each(function () {
            $(this).removeClass('active');
        })
        $(this).addClass('active');
      
        var target = this.hash,
            menu = target;
        $target = $(target);
        $('html, body').stop().animate({
            'scrollTop': $target.offset().top+2
        }, 500, 'swing', function () {
            window.location.hash = target;
            $(document).on("scroll", onScroll);
        });
    });
});

function onScroll(event){
    var scrollPos = $(document).scrollTop();
    $('#menu-center a').each(function () {
	alert();
        var currLink = $(this);
        var refElement = $(currLink.attr("href"));
        if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
            $('#menu-center ul li a').removeClass("active");
            currLink.addClass("active");
        }
        else{
            currLink.removeClass("active");
        }
    });
}
</script>
<!--   Core JS Files   -->
<script src="developer/assets/js/core/popper.min.js"></script>
<script src="developer/assets/js/core/bootstrap.min.js"></script>
<script src="developer/assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="developer/assets/js/plugins/smooth-scrollbar.min.js"></script>
<!--<script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>-->
<!-- Github buttons -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="developer/assets/js/material-dashboard.min.js?v=3.0.0"></script>
</body>
</html>
<?
exit;
}
?>
