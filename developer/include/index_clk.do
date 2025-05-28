<!DOCTYPE html>
<html>
<head>
<?
$data['domain_url']=$data['Host'];

$store_url=($data['MYWEBSITEURL']?$data['MYWEBSITEURL']:'store');
$store_id_nm=$store_url;
$store_name=($data['MYWEBSITE']?$data['MYWEBSITE']:'Store');

if($data['MYWEBSITEURL']){
	$processall_url='charge';
}else{
	$processall_url='processall';
}

// 
$store_id="{$store_name} Id is very important parameter and you can find '{$store_name} Id' as a numeric value within the <strong><a href='{$data['domain_url']}/user/{$store_url}{$data['ex']}' target='_blank'><abbr title='Click for Go to My {$store_name}'>My {$store_name}</abbr></span></a></strong> area or you can find it easily by following <strong>My {$store_name} → <a href='{$data['domain_url']}/user/new_{$store_url}{$data['ex']}' target='_blank'><abbr title='Click for Go to Add New {$store_name}'>Add New {$store_name}</abbr></span></a> </strong>";
$api_token="{$store_name} API Token is a string value. You can find it by following <br/><strong><a href='{$data['domain_url']}/user/{$store_url}{$data['ex']}' target='_blank'><abbr title='Click for Go to My {$store_name}'>My {$store_name}</abbr></span></a> → {$store_name} API Token  (as created inside area of New {$store_name})</strong>";
$website_api_token_get="{$store_name} Secret Key is a string value. You can find it by following <br/><strong><a href='{$data['domain_url']}/user/{$store_url}{$data['ex']}' target='_blank'><abbr title='Click for Go to My {$store_name}'>My {$store_name}</abbr></span></a> → {$store_name} Secret Key  (as created inside area of {$store_name})</strong>";
?>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title><?=$data['SiteName'];?> API Documentation 1.0.3</title>
<style>
  .highlight table td {padding: 5px;}.highlight table pre {margin: 0;}.highlight, .highlight .w {color: #f8f8f2;background-color: #272822;}.highlight .err {color: #151515;background-color: #ac4142;}.highlight .c, .highlight .cd, .highlight .cm, .highlight .c1, .highlight .cs {color: #505050;}.highlight .cp {color: #f4bf75;}.highlight .nt {color: #f4bf75;}.highlight .o, .highlight .ow {color: #d0d0d0;}.highlight .p, .highlight .pi {color: #d0d0d0;}.highlight .gi {color: #90a959;}.highlight .gd {color: #ac4142;}.highlight .gh {color: #6a9fb5;background-color: #151515;font-weight: bold;}.highlight .k, .highlight .kn, .highlight .kp, .highlight .kr, .highlight .kv {color: #aa759f;}.highlight .kc {color: #d28445;}.highlight .kt {color: #d28445;}.highlight .kd {color: #d28445;}.highlight .s, .highlight .sb, .highlight .sc, .highlight .sd, .highlight .s2, .highlight .sh, .highlight .sx, .highlight .s1 {color: #90a959;}.highlight .sr {color: #75b5aa;}.highlight .si {color: #8f5536;}.highlight .se {color: #8f5536;}.highlight .nn {color: #f4bf75;}.highlight .nc {color: #f4bf75;}.highlight .no {color: #f4bf75;}.highlight .na {color: #6a9fb5;}.highlight .m, .highlight .mf, .highlight .mh, .highlight .mi, .highlight .il, .highlight .mo, .highlight .mb, .highlight .mx {color: #90a959;}.highlight .ss {color: #90a959;}
</style>
<link rel="shortcut icon" href="<?=$data['domain_url']?>/favicon.ico" type="image/ico">
<link href="images/screen.css" rel="stylesheet" media="screen">
<link href="images/print.css" rel="stylesheet" media="print">
<link href="images/custom.css" rel="stylesheet" media="screen">
<script src="images/all.js.download"></script>
</head>
<body class="index" data-languages="[&quot;curl&quot;]">
<a href="<?=$data['domain_url']?>/developer/#" id="nav-button"> <span> Home  </span> </a>
<div class="tocify-wrapper"> 
  <div class="lang-selector">  </div>
  <div class="search">
    <input type="text" class="search" id="input-search" placeholder="Search">
  </div>
  <ul class="search-results">
  </ul>
 <div id="toc" class="tocify" style="color:#fff"></div>
  <ul class="toc-footer">
    
  </ul>
</div>
<div class="page-wrapper">
  <div class="dark-box"></div>
  <div class="content">
	<div name="document_illustration" data-unique="document_illustration"></div>
    <h1 id="document_illustration">1. Document Illustration 1.0.3</h1>
    
    <pre class="highlight php"><code>
	
	</code></pre>
	<p>The documents provider is <?=$data['SiteName'];?>, we focus on providing our merchants a standard API integration rules. We have the right of final explanation on the document and have reserved right to update it any time.</p>
	<ol>
      <li>After using the document, you can achieve the following functions: 'Accept credit payment online', 'Query order information', 'Refund the order' and so on.</li>
	  <li>The documents reader is merchants' administrator, maintainer and developer.</li>
	  <li>Except defined, platform mentioned in this document means <?=$data['SiteName'];?>.</li>
    </ol>
    <div name="preparation" data-unique="preparation"></div>
    <h1 id="preparation">2. Preparation</h1>
    <blockquote>
      <p>Example of API code to user for Integration:</p>
    </blockquote>
    <pre class="highlight php"><code><span class="cp"><?=$data['SiteName'];?> MERCHANT:</span>

<span class="cp">&lt;!--</span><span class="k"><?=($store_name);?> API Token:</span> <span class="nf">MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ</span>
<span class="k"><?=($store_id_nm);?>_id:</span> <span class="nf">1120</span><span class="cp">--&gt;</span>

<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">api_token</span><span class="k">"</span> <span class="k">value="</span><span class="nf">MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1"><?=($store_id_nm);?>_id</span><span class="k">"</span> <span class="k">value="</span><span class="nf">1120</span><span class="k">"</span><span class="cp">/&gt;</span>


	</code></pre>
	<ol>
      <li>Read all the API document carefully.</li>
	  <li>Obtain 2 very important parameters, they are <strong>"api_token" , "<?=($store_id_nm);?>_id"</strong>.</li>
    </ol>
	<aside class="notice">Replace of 2 very important parameters. You may find it at <a href="<?=$data['domain_url']?>/user/<?=($store_url);?><?=$data['ex']?>" target="_blank"><abbr title="Click for Go to My <?=($store_name);?>">My <?=($store_name);?> </abbr></span></a> : <br/>
			<div style="margin:0 0 0 24px;">
			1. <code><?=($store_id_nm);?>_id</code> with your <?=($store_name);?> ID.<br/>
			2. <code>api_token</code> with your <?=($store_name);?> API Token. 
			
			</div>
	</aside>
	<table>
      <thead>
        <tr>
          <th style="text-align: right">Parameter</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
		<tr>
          <td style="text-align: right"><strong><?=($store_id_nm);?>_id</strong>
            <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="<?=($store_name);?> Id (e.g. 1120) From Merchant ">M</abbr></span></div>
		    <div class="method-badge">required</div>
		   </td>
          <td><?=$store_id;?>
			<aside class="warning" style="padding:2px 10px;color:#fff;border-radius:3px;"><?=($store_name);?> API Token and <?=($store_name);?> Id are required for all the web/curling based integration, no matter we do support or not the shopping cart you are using.<br />
In case, you are using a shopping cart for which we provide plugin or you may have your own shopping cart for which we do not provide plugin. For both of these cases, you need to pass one <?=($store_name);?> API Token and <?=($store_name);?> Id, that shall be used for all of your products. Our API has the proficiency to receive any price through the <?=($store_name);?> API Token and <?=($store_name);?> Id. You may pass the dynamic parameter of 'price' to us by using the same <?=($store_name);?> Id.
</aside>
		  </td>
        </tr>
		
        <tr>
          <td style="text-align: right"><strong>api_token</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="<?=($store_name);?> API Token (e.g. MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div>
		  </td>
          <td><?=$api_token;?></td>
        </tr>
        
      </tbody>
    </table>
	
	
	
	
	
	<div name="errors" data-unique="payment_gateway"></div>
    <h1 id="payment_gateway">3. Payment Gateway</h1>
	<blockquote>
      <p>Example of Payment Gateway :</p>
    </blockquote>
    <pre class="highlight php"><code><span class="cp">&lt;form</span> <span class="k">method="</span><span class="s1">post</span><span class="k">"</span> <span class="k">action="</span><span class="nf"><?=$data['domain_url']?>/payment<?=$data['ex']?></span><span class="k">"</span> <span class="k">name="</span><span class="s1">paymentform</span><span class="k">"</span><span class="cp">&gt;</span>

<span class="cp">&lt;!--</span><span class="k">Replace of 2 very important parameters </span><span class="nf">* your <?=($store_name);?> API Token and <?=($store_name);?> ID</span> <span class="cp">--&gt;</span>

<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">api_token</span><span class="k">"</span> <span class="k">value="</span><span class="nf">MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1"><?=($store_id_nm);?>_id</span><span class="k">"</span> <span class="k">value="</span><span class="nf">1120</span><span class="k">"</span><span class="cp">/&gt;</span>

<span class="cp">&lt;!--</span><span class="k">default (fixed) value </span><span class="nf">* default</span> <span class="cp">--&gt;</span>

<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">cardsend</span><span class="k">"</span> <span class="k">value="</span><span class="nf">CHECKOUT</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">action</span><span class="k">"</span> <span class="k">value="</span><span class="nf">product</span><span class="k">"</span><span class="cp">/&gt;</span>

<span class="cp">&lt;!--</span><span class="k">product price and product name </span><span class="nf">* by cart total amount</span> <span class="cp">--&gt;</span>

<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">price</span><span class="k">"</span> <span class="k">value="</span><span class="nf">50.00</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">curr</span><span class="k">"</span> <span class="k">value="</span><span class="nf">INR</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">product_name</span><span class="k">"</span> <span class="k">value="</span><span class="nf">Testing Product </span><span class="k">"</span><span class="cp">/&gt;</span>

<span class="cp">&lt;!--</span><span class="k">billing details of </span><span class="nf">.* customer</span> <span class="cp">--&gt;</span>

<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">ccholder</span><span class="k">"</span> <span class="k">value="</span><span class="nf">Test First Name</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">ccholder_lname</span><span class="k">"</span> <span class="k">value="</span><span class="nf">Test Last Name</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">email</span><span class="k">"</span> <span class="k">value="</span><span class="nf">test.<?=date('is')?>@test.com</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">bill_street_1</span><span class="k">"</span> <span class="k">value="</span><span class="nf">25A Alpha</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">bill_street_2</span><span class="k">"</span> <span class="k">value="</span><span class="nf">tagore lane</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">bill_city</span><span class="k">"</span> <span class="k">value="</span><span class="nf">Jurong</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">bill_state</span><span class="k">"</span> <span class="k">value="</span><span class="nf">New Delhi</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">bill_country</span><span class="k">"</span> <span class="k">value="</span><span class="nf">India</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">bill_zip</span><span class="k">"</span> <span class="k">value="</span><span class="nf">787602</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">bill_phone</span><span class="k">"</span> <span class="k">value="</span><span class="nf">+65 62200944</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">id_order</span><span class="k">"</span> <span class="k">value="</span><span class="nf">2017013120170131</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">notify_url</span><span class="k">"</span> <span class="k">value="</span><span class="nf">https://yourdomain.com/notify.php</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">success_url</span><span class="k">"</span> <span class="k">value="</span><span class="nf">https://yourdomain.com/success.php</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">error_url</span><span class="k">"</span> <span class="k">value="</span><span class="nf">https://yourdomain.com/failed.php</span><span class="k">"</span><span class="cp">/&gt;</span>
<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">hidden</span><span class="k">"</span> <span class="k">name="</span><span class="s1">source</span><span class="k">"</span> <span class="k">value="</span><span class="nf">Host-Redirect-Card-Payment (Core PHP)</span><span class="k">"</span><span class="cp">/&gt;</span>

<span class="cp">&lt;input</span> <span class="k">type="</span><span class="s1">submit</span><span class="k">"</span> <span class="k">name="</span><span class="s1">submit</span><span class="k">"</span> <span class="k">value="</span><span class="nf">SUBMIT</span><span class="k">"</span><span class="cp">/&gt;</span>
	
<span class="cp">&lt;script&gt;</span><span class="k">document.paymentform.submit();</span><span class="cp">&lt;/script&gt;</span>

<span class="cp">&lt;/form&gt;</span></code></pre>
    <p>To pass the parameters, we accept both POST method and GET method. You may use any of POST or GET.</p>
    <p>Steps to generate an API code:</p>
    <ol>
      <li><strong>Merchant  Login -</strong>To login the dashboard, <strong><u>username &amp; password</u></strong> is mandatory.</li>
	  <li><strong><?=($store_name);?> API Token - </strong><?=$api_token;?>.</li>
	  <li><strong><?=($store_name);?> ID- </strong><?=$store_id;?></li>
	  <li><strong>Generate <?=($store_name);?> API Token - </strong>After adding <?=($store_name);?> Details code of <?=($store_name);?> API Token will be generated automatically. This code is required when you proceed for Payment Integration.</li>
    </ol>
	<table>
      <tbody>
        <tr>
          <td style="text-align: right"><strong>Gateway URL</strong>
          </td>
          <td><?=$data['domain_url']?>/payment<?=$data['ex']?></td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Method</strong>
          </td>
          <td>POST or GET</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Function</strong>
          </td>
          <td>Accept Check or Credit card payment online from the customers</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Remark</strong>
          </td>
          <td>10 mandatory parameters, the others are all optional</td>
        </tr>
      </tbody>
    </table>
    <table>
      <thead>
        <tr>
          <th style="text-align:right;width:90px;">Parameter</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td style="text-align: right"><strong>api_token</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="<?=($store_name);?> API Token (e.g. MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div>
		  </td>
         <td><?=$api_token;?></td>
        </tr>
        <tr>
          <td style="text-align: right"><strong><?=($store_id_nm);?>_id</strong>
            <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="<?=($store_name);?> Id (e.g. 1120) From Merchant ">M</abbr></span></div>
		    <div class="method-badge">required</div>
		   </td>
          <td><?=$store_id;?>
			<aside class="warning" style="padding:2px 10px;color:#fff;border-radius:3px;"><?=($store_name);?> API Token and <?=($store_name);?> Id is required for all the web/curling  based integration, if you are using any shopping cart which we do support in plugins or you may have your own shopping cart which we do not support. In both the cases, you need to pass one <?=($store_name);?> API Token and <?=($store_name);?> Id that can be used for all your products. Our API has the capability to receive any price from the <?=($store_name);?> API Token and <?=($store_name);?> Id. You may pass the dynamic 'price' parameter (i.e. price) to us by using the same <?=($store_name);?> Id.</aside>
		  </td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>cardsend</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>cardsend, a string for default (fixed) value <strong>CHECKOUT</strong>.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>action</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>action, a string for default (fixed) value <strong>product</strong>.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>price</strong>
          <div class="method-details"><span class="blue_r">dec(10.0.0)</span> <span class="blue_r"><abbr title="price (e.g. 1,500.00) From Merchant ">M</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Order Amount, currency format in decimal(10.0.0)</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>product_name</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Product Name (e.g. Pen,Iphone7 etc) From Merchant ">M</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Product Name</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>ccholder</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer first name</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>ccholder_lname</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer last name</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>email</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer billing email</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_street_1</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-badge">required</div>
		  </td>
          <td>Customer's shipping street</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_street_2</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Customer's shipping street 2</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_city</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-badge">required</div>
		  </td>
          <td>Customer's shipping city</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_state</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Customer's shipping state</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_country</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer's shipping country</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_zip</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Customer's shipping zip code</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_phone</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer billing phone</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>id_order</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Merchant’s order ID that will be returned back in a callback.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>notify_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Synchronous notification URL, you can find it in the response data.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>success_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Redirect url of success as per your domain</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>error_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Redirect url of error as per your domain</td>
        </tr>
		
      </tbody>
    </table>
    
	
	<div name="errors" data-unique="encrypted_card_payment_gateway_redirect_host"></div>
    <h1 id="encrypted_card_payment_gateway_redirect_host">4. Encrypted Payment Gateway (Redirect-Host)</h1>
	<blockquote>
      <p>Example of Encrypted Payment Gateway (Redirect-Host):</p>
    </blockquote>
    <pre class="highlight highlight1 php"><span class="cp">&lt;?php</span>
<span class="cp">//&lt;!--</span><span class="k">Replace of 3 very important parameters </span><span class="nf">* your <?=($store_name);?> Secret Key, <?=($store_name);?> API Token and <?=($store_name);?> ID</span> <span class="cp">--&gt;</span>

<span class="cp">//&lt;!--</span><span class="nf"> <?=($store_name);?> Secret Key </span> <span class="cp">--&gt;</span>
<span class="k">$secret_key="</span><span class="nf">3d641ef2c0158346dc675800d583f17a263035dfc39ed2c56ff7551027177c4d</span><span class="k">"</span><span class="cp">;</span> 
<span class="k">$website_api_token="</span><span class="nf">MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ</span><span class="k">"</span><span class="cp">;</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="cp">//</span><span class="nf"> <?=($store_name);?> API Token</span> <span class="cp"></span>
<span class="k">$website_id="</span><span class="nf">1120</span><span class="k">"</span><span class="cp">;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cp">//</span><span class="nf"> <?=($store_name);?> Id</span> <span class="cp"></span>
	
<code><span class="k">$gateway_url="</span><span class="nf"><?=$data['domain_url']?>/charge<?=$data['ex']?></span><span class="k">"</span><span class="cp">;</span>
	
<span class="k1">$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';</span>
<span class="k1">$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];</span>

<span class="k">$pramPost</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>

<span class="k">$pramPost["</span><span class="s1">api_token</span><span class="k">"]</span><span class="k">=</span><span class="k">$website_api_token</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1"><?=($store_id_nm);?>_id</span><span class="k">"]</span><span class="k">=</span><span class="k">$<?=($store_id_nm);?>_id</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">default (fixed) value </span><span class="nf">* default</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">cardsend</span><span class="k">"]</span><span class="k">="</span><span class="nf">CHECKOUT</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">client_ip</span><span class="k">"]</span><span class="k">=</span><span class="nf">($_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR'])</span><span class="k"></span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">action</span><span class="k">"]</span><span class="k">="</span><span class="nf">product</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source</span><span class="k">"]</span><span class="k">="</span><span class="nf">Encode-Checkout</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source_url</span><span class="k">"]</span><span class="k">=</span><span class="nf">$referer</span><span class="k"></span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">product price,curr and product name </span><span class="nf">* by cart total amount</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">price</span><span class="k">"]</span><span class="k">="</span><span class="nf">30.00</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">curr</span><span class="k">"]</span><span class="k">="</span><span class="nf">USD</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">product_name</span><span class="k">"]</span><span class="k">="</span><span class="nf">Testing Product</span><span class="k">"</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">billing details of </span><span class="nf">.* customer</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">fullname</span><span class="k">"]</span><span class="k">="</span><span class="nf">Test Full Name</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">email</span><span class="k">"]</span><span class="k">="</span><span class="nf">test.<?=date('is')?>@test.com</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_street_1</span><span class="k">"]</span><span class="k">="</span><span class="nf">25A Alpha</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_street_2</span><span class="k">"]</span><span class="k">="</span><span class="nf">tagore lane</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_city</span><span class="k">"]</span><span class="k">="</span><span class="nf">Jurong</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_state</span><span class="k">"]</span><span class="k">="</span><span class="nf">Singapore</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_country</span><span class="k">"]</span><span class="k">="</span><span class="nf">Singapore</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_zip</span><span class="k">"]</span><span class="k">="</span><span class="nf">787602</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_phone</span><span class="k">"]</span><span class="k">="</span><span class="nf">+65 62200944</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">id_order</span><span class="k">"]</span><span class="k">="</span><span class="nf">20170131</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">notify_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/notify.php</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">success_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/success.php</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">error_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/failed.php</span><span class="k">"</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">card details of </span><span class="nf">.* customer</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">ccno</span><span class="k">"]</span><span class="k">="</span><span class="nf">4242424242424242</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">ccvv</span><span class="k">"]</span><span class="k">="</span><span class="nf">123</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">month</span><span class="k">"]</span><span class="k">="</span><span class="nf">01</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">year</span><span class="k">"]</span><span class="k">="</span><span class="nf">30</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">notes</span><span class="k">"]</span><span class="k">="</span><span class="nf">Remark for transaction</span><span class="k">"</span><span class="cp">;</span>



<span class="k1">$get_string=http_build_query($pramPost)</span><span class="cp">;</span>

<span class="k1">function data_encode($string,$secret_key,$website_api_token) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $website_api_token ), 0, 16 );
    $output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $secret_key, 0, $iv ) ), '+/', '-_'), '=');
    return $output;
}</span>

<span class="k1">if($get_string){
 $encrypted = data_encode($get_string,$secret_key,$website_api_token);
 if($encrypted){
   header("Location:{$gateway_url}?pram_encode={$encrypted}{$website_api_token}");exit;
 }
}</span>

<span class="k1">exit;</span>

<span class="cp">?&gt;</span> 
</code></pre>
    <p>To pass the parameters, we accept GET method. You may use GET.</p>
    <p>Steps to generate an API code:</p>
    <ol>
      <li><strong>Merchant  Login -</strong>To login the dashboard, <strong><u>username &amp; password</u></strong> is mandatory.</li>
	  <li><strong><?=($store_name);?> API Token - </strong><?=$api_token;?>.</li>
	  <li><strong><?=($store_name);?> ID- </strong><?=$store_id;?></li>
	  <li><strong>Generate <?=($store_name);?> API Token - </strong>After adding <?=($store_name);?> Details code of <?=($store_name);?> API Token will be generated automatically. This code is required when you proceed for Payment Integration.</li>
    </ol>
	<table>
      <tbody>
        <tr>
          <td style="text-align: right"><strong>Gateway URL</strong>
          </td>
          <td><?=$data['domain_url']?>/<?=$processall_url;?><?=$data['ex']?></td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Method</strong>
          </td>
          <td>GET</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Function</strong>
          </td>
          <td>Accept Check or Credit card payment online from the customers</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Remark</strong>
          </td>
          <td>11 mandatory parameters, the others are all optional</td>
        </tr>
      </tbody>
    </table>
    <table>
      <thead>
        <tr>
          <th style="text-align:right;width:90px;">Parameter</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td style="text-align: right"><strong style="text-transform:capitalize;"><?=($store_id_nm);?> Secret Key</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="<?=($store_name);?> Secret Key (e.g. 3d641ef2c0158346dc675800d583f17a263035dfc39ed2c56ff7551027177c4d) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div>
		  </td>
         <td style=""><?=$website_api_token_get;?></td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>api_token</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="<?=($store_name);?> API Token (e.g. MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div>
		  </td>
         <td><?=$api_token;?></td>
        </tr>
        <tr>
          <td style="text-align: right"><strong><?=($store_id_nm);?>_id</strong>
            <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="<?=($store_name);?> Id (e.g. 1120) From Merchant ">M</abbr></span></div>
		    <div class="method-badge">required</div>
		   </td>
          <td><?=$store_id;?>
			<aside class="warning" style="padding:2px 10px;color:#fff;border-radius:3px;"><?=($store_name);?> API Token and <?=($store_name);?> Id is required for all the web/curling  based integration, if you are using any shopping cart which we do support in plugins or you may have your own shopping cart which we do not support. In both the cases, you need to pass one <?=($store_name);?> API Token and <?=($store_name);?> Id that can be used for all your products. Our API has the capability to receive any price from the <?=($store_name);?> API Token and <?=($store_name);?> Id. You may pass the dynamic 'price' parameter (i.e. price) to us by using the same <?=($store_name);?> Id.</aside>
		  </td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>cardsend</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>cardsend, a string for default (fixed) value <strong>CHECKOUT</strong>.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>client_ip</strong>
          <div class="method-details"><span class="blue_r">php</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Client IP a php code dynamic get IP value <strong>&lt;?php echo ($_SERVER['HTTP_X_FORWARDED_FOR']? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR']);?&gt;</strong>.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>action</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>action, a string for default (fixed) value <strong>product</strong>.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>source</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>source, a string for default (fixed) value <strong>Encode-Checkout (Encode Core PHP)</strong>.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>source_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>source_url, Product or Service url of source_url as per your domain
- a string for default (fixed) value <strong>isset($_SERVER["HTTPS"]) ? 'https://':'http://' . $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI']</strong>.</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>price</strong>
          <div class="method-details"><span class="blue_r">dec(10.0.0)</span> <span class="blue_r"><abbr title="price (e.g. 1,500.00) From Merchant ">M</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Order Amount, currency format in decimal(10.0.0)</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>product_name</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Product Name (e.g. Pen,Iphone7 etc) From Merchant ">M</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Product Name</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>fullname</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer full name</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>email</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer billing email</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_street_1</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-badge">required</div>
		  </td>
          <td>Customer's shipping street</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_street_2</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Customer's shipping street 2</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_city</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-badge">required</div>
		  </td>
          <td>Customer's shipping city</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_state</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Customer's shipping state</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_country</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer's shipping country</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_zip</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Customer's shipping zip code</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_phone</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer billing phone</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>id_order</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Merchant’s order ID that will be returned back in a callback.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>notify_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Synchronous notification URL, you can find it in the response data.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>success_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Redirect url of success as per your domain</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>error_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Redirect url of error as per your domain</td>
        </tr>
		
		
      </tbody>
    </table>
	
	
	<div name="errors" data-unique="encrypted_card_payment_curl_direct"></div>
    <h1 id="encrypted_card_payment_curl_direct">5. Encrypted Payment Gateway (Curl-Direct)</h1>
	<blockquote>
      <p>Example of Encrypted Payment Gateway (Curl-Direct):</p>
    </blockquote>
    <pre class="highlight highlight1 php"><span class="cp">&lt;?php</span>
<span class="cp">//&lt;!--</span><span class="k">Replace of 3 very important parameters </span><span class="nf">* your <?=($store_name);?> Secret Key, <?=($store_name);?> API Token and <?=($store_name);?> ID</span> <span class="cp">--&gt;</span>

<span class="cp">//&lt;!--</span><span class="nf"> <?=($store_name);?> Secret Key </span> <span class="cp">--&gt;</span>
<span class="k">$secret_key="</span><span class="nf">3d641ef2c0158346dc675800d583f17a263035dfc39ed2c56ff7551027177c4d</span><span class="k">"</span><span class="cp">;</span> 
<span class="k">$website_api_token="</span><span class="nf">MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ</span><span class="k">"</span><span class="cp">;</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="cp">//</span><span class="nf"> <?=($store_name);?> API Token</span> <span class="cp"></span>
<span class="k">$website_id="</span><span class="nf">1120</span><span class="k">"</span><span class="cp">;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cp">//</span><span class="nf"> <?=($store_name);?> Id</span> <span class="cp"></span>
	
<code><span class="k">$gateway_url="</span><span class="nf"><?=$data['domain_url']?>/api<?=$data['ex']?></span><span class="k">"</span><span class="cp">;</span>
	
<span class="k1">$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';</span>
<span class="k1">$referer=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];</span>

<span class="k">$pramPost</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>

<span class="k">$pramPost["</span><span class="s1">api_token</span><span class="k">"]</span><span class="k">=</span><span class="k">$website_api_token</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1"><?=($store_id_nm);?>_id</span><span class="k">"]</span><span class="k">=</span><span class="k">$<?=($store_id_nm);?>_id</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">default (fixed) value </span><span class="nf">* default</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">cardsend</span><span class="k">"]</span><span class="k">="</span><span class="nf">curl</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">client_ip</span><span class="k">"]</span><span class="k">=</span><span class="nf">($_SERVER['HTTP_X_FORWARDED_FOR']?$_SERVER['HTTP_X_FORWARDED_FOR']:$_SERVER['REMOTE_ADDR'])</span><span class="k"></span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">action</span><span class="k">"]</span><span class="k">="</span><span class="nf">product</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source</span><span class="k">"]</span><span class="k">="</span><span class="nf">Encode-Curl-API</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">source_url</span><span class="k">"]</span><span class="k">=</span><span class="nf">$referer</span><span class="k"></span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">product price,curr and product name </span><span class="nf">* by cart total amount</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">price</span><span class="k">"]</span><span class="k">="</span><span class="nf">30.00</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">curr</span><span class="k">"]</span><span class="k">="</span><span class="nf">USD</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">product_name</span><span class="k">"]</span><span class="k">="</span><span class="nf">Testing Product</span><span class="k">"</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">billing details of </span><span class="nf">.* customer</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">fullname</span><span class="k">"]</span><span class="k">="</span><span class="nf">Test Full Name</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">email</span><span class="k">"]</span><span class="k">="</span><span class="nf">test.<?=date('is')?>@test.com</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_street_1</span><span class="k">"]</span><span class="k">="</span><span class="nf">25A Alpha</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_street_2</span><span class="k">"]</span><span class="k">="</span><span class="nf">tagore lane</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_city</span><span class="k">"]</span><span class="k">="</span><span class="nf">Jurong</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_state</span><span class="k">"]</span><span class="k">="</span><span class="nf">Singapore</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_country</span><span class="k">"]</span><span class="k">="</span><span class="nf">Singapore</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_zip</span><span class="k">"]</span><span class="k">="</span><span class="nf">787602</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">bill_phone</span><span class="k">"]</span><span class="k">="</span><span class="nf">+65 62200944</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">id_order</span><span class="k">"]</span><span class="k">="</span><span class="nf">20170131</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">notify_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/notify.php</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">success_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/success.php</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">error_url</span><span class="k">"]</span><span class="k">="</span><span class="nf">https://yourdomain.com/failed.php</span><span class="k">"</span><span class="cp">;</span>

<span class="cp">//&lt;!--</span><span class="k">card details of </span><span class="nf">.* customer</span> <span class="cp">--&gt;</span>

<span class="k">$pramPost["</span><span class="s1">ccno</span><span class="k">"]</span><span class="k">="</span><span class="nf">4242424242424242</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">ccvv</span><span class="k">"]</span><span class="k">="</span><span class="nf">123</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">month</span><span class="k">"]</span><span class="k">="</span><span class="nf">01</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">year</span><span class="k">"]</span><span class="k">="</span><span class="nf">30</span><span class="k">"</span><span class="cp">;</span>
<span class="k">$pramPost["</span><span class="s1">notes</span><span class="k">"]</span><span class="k">="</span><span class="nf">Remark for transaction</span><span class="k">"</span><span class="cp">;</span>



<span class="k1">$get_string=http_build_query($pramPost)</span><span class="cp">;</span>

<span class="k1">function data_encode($string,$secret_key,$website_api_token) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $iv = substr( hash( 'sha256', $website_api_token ), 0, 16 );
    $output = rtrim( strtr( base64_encode( openssl_encrypt( $string, $encrypt_method, $secret_key, 0, $iv ) ), '+/', '-_'), '=');
    return $output;
}</span>

<span class="k1">$encrypted = data_encode($get_string,$secret_key,$website_api_token);</span>

<span class="k">$pram_encode</span><span class="k">=</span><span class="nf">array()</span><span class="cp">;</span>
<span class="k">$pram_encode['pram_encode']</span><span class="k">=</span><span class="nf">$encrypted.$website_api_token</span><span class="cp">;</span>

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

<span class="nt">if(isset(</span><span class="k">$results["</span><span class="s1">pay_url</span><span class="k">"]</span><span class="nt">)</span> && <span class="k">$results["</span><span class="s1">pay_url</span><span class="k">"]</span><span class="cp">){</span>
	<span class="k1">$redirecturl = $results["pay_url"];</span>
	<span class="k1">header("Location:$redirecturl");exit;</span>
<span class="nt">}elseif(</span><span class="nf">$status=="<span class="k">completed</span>" || </span><span class="nf">$status=="<span class="k">success</span>" || </span><span class="nf">$status=="<span class="k">test</span>" || </span><span class="nf">$status=="<span class="k">test transaction</span>"</span><span class="cp">){</span>
	<span class="k1">$redirecturl = <span class="k">$curlPost["</span><span class="s1">success_url</span><span class="k">"]</span>;</span>
	<span class="k1">if(strpos($redirecturl,'?')!==false){</span>
		<span class="k1">$redirecturl = $redirecturl."&".$sub_query;</span>
	<span class="k1">}else{</span>
		<span class="k1">$redirecturl = $redirecturl."?".$sub_query;</span>
	<span class="k1">}</span>
	<span class="k1">header("Location:$redirecturl");exit;</span>
<span class="nt">}elseif(</span><span class="nf">$status=="<span class="k">pending</span>"<span class="cp">){</span>
	<span class="k1">$redirecturl = <span class="k">$referer</span>;
	if(strpos($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query;
	}else{
		$redirecturl = $redirecturl."?".$sub_query;
	}
	header("Location:$redirecturl");exit;</span>
<span class="cp">}else{</span>
	$redirecturl = <span class="k">$curlPost["</span><span class="s1">error_url</span><span class="k">"]</span>;
	if(strpos($redirecturl,'?')!==false){
		$redirecturl = $redirecturl."&".$sub_query;
	}else{
		$redirecturl = $redirecturl."?".$sub_query;
	}
	header("Location:$redirecturl");exit;
<span class="cp">}</span>
</code></pre>
	<blockquote>
      <h3 id="example-response">After posting the data you will get below response:</h3>
    </blockquote>
	<pre class="highlight json"><code><span class="p">{</span><span class="w">
    </span><span class="nt">"transaction_id"</span><span class="p">:</span><span class="w"> </span><span class="s2">"20171010122934"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"status_nm"</span><span class="p">:</span><span class="w"> </span><span class="s2">"1"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"status"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Success"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"price"</span><span class="p">:</span><span class="w"> </span><span class="s2">"30.00"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"curr"</span><span class="p">:</span><span class="w"> </span><span class="s2">"USD"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"id_order"</span><span class="p">:</span><span class="w"> </span><span class="s2">"20170131"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"cardtype"</span><span class="p">:</span><span class="w"> </span><span class="s2">"visa"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"ccno"</span><span class="p">:</span><span class="w"> </span><span class="s2">"XXXXXXXXXXXX4242"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"reason"</span><span class="p">:</span><span class="w"> </span><span class="s2">"success"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"fullname"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Test Full Name"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"email"</span><span class="p">:</span><span class="w"> </span><span class="s2">"test.<?=date('is')?>@test.com"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"address"</span><span class="p">:</span><span class="w"> </span><span class="s2">"25A Alpha,tagore lane "</span><span class="p">,</span><span class="w">
    </span><span class="nt">"city"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Jurong"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"state"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Singapore"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"country"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Singapore"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"phone"</span><span class="p">:</span><span class="w"> </span><span class="s2">"+65 62200944"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"product_name"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Testing Product"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"amt"</span><span class="p">:</span><span class="w"> </span><span class="s2">"30.00"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"memail"</span><span class="p">:</span><span class="w"> </span><span class="s2">"billing@<?=$data['SiteName'];?>"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"company_name"</span><span class="p">:</span><span class="w"> </span><span class="s2">"<?=$data['SiteName'];?>"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"bussinessurl"</span><span class="p">:</span><span class="w"> </span><span class="s2">"<?=$data['domain_url']?>"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"contact_us_url"</span><span class="p">:</span><span class="w"> </span><span class="s2">"<?=$data['domain_url']?>/contact-us"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"customer_service_no"</span><span class="p">:</span><span class="w"> </span><span class="s2">"912233445566"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"tdate"</span><span class="p">:</span><span class="w"> </span><span class="s2">"2017-10-11 10:30:09"</span><span class="p">,</span><span class="w">
   <!-- </span><span class="nt">"amount"</span><span class="p">:</span><span class="w"> </span><span class="s2">"20171010122934"</span><span class="p">,</span><span class="w">-->
    </span><span class="nt">"callbacks"</span><span class="p">:</span><span class="w"> </span><span class="s2">"OK"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"info"</span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
        </span><span class="nt">"fullname"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Test Full Name"</span><span class="p">,</span><span class="w">
        </span><span class="nt">"email"</span><span class="p">:</span><span class="w"> </span><span class="mi">"test.<?=date('is')?>@test.com"</span><span class="w">
        </span><span class="nt">"etc..."</span><span class="p">:</span><span class="w"> </span><span class="mi">.....</span><span class="w">
    </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w">
</span>

<span class="k1">exit;</span>

<span class="cp">?&gt;</span> 
</code></pre>
    <p>To pass the parameters, we accept GET method. You may use GET.</p>
    <p>Steps to generate an API code:</p>
    <ol>
      <li><strong>Merchant  Login -</strong>To login the dashboard, <strong><u>username &amp; password</u></strong> is mandatory.</li>
	  <li><strong><?=($store_name);?> API Token - </strong><?=$api_token;?>.</li>
	  <li><strong><?=($store_name);?> ID- </strong><?=$store_id;?></li>
	  <li><strong>Generate <?=($store_name);?> API Token - </strong>After adding <?=($store_name);?> Details code of <?=($store_name);?> API Token will be generated automatically. This code is required when you proceed for Payment Integration.</li>
    </ol>
	<table>
      <tbody>
        <tr>
          <td style="text-align: right"><strong>Gateway URL</strong>
          </td>
          <td><?=$data['domain_url']?>/<?=$processall_url;?><?=$data['ex']?></td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Method</strong>
          </td>
          <td>GET</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Function</strong>
          </td>
          <td>Accept Check or Credit card payment online from the customers</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Remark</strong>
          </td>
          <td>11 mandatory parameters, the others are all optional</td>
        </tr>
      </tbody>
    </table>
    <table>
      <thead>
        <tr>
          <th style="text-align:right;width:90px;">Parameter</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td style="text-align: right"><strong style="text-transform:capitalize;"><?=($store_id_nm);?> Secret Key</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="<?=($store_name);?> Secret Key (e.g. 3d641ef2c0158346dc675800d583f17a263035dfc39ed2c56ff7551027177c4d) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div>
		  </td>
         <td style=""><?=$website_api_token_get;?></td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>api_token</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="<?=($store_name);?> API Token (e.g. MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div>
		  </td>
         <td><?=$api_token;?></td>
        </tr>
        <tr>
          <td style="text-align: right"><strong><?=($store_id_nm);?>_id</strong>
            <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="<?=($store_name);?> Id (e.g. 1120) From Merchant ">M</abbr></span></div>
		    <div class="method-badge">required</div>
		   </td>
          <td><?=$store_id;?>
			<aside class="warning" style="padding:2px 10px;color:#fff;border-radius:3px;"><?=($store_name);?> API Token and <?=($store_name);?> Id is required for all the web/curling  based integration, if you are using any shopping cart which we do support in plugins or you may have your own shopping cart which we do not support. In both the cases, you need to pass one <?=($store_name);?> API Token and <?=($store_name);?> Id that can be used for all your products. Our API has the capability to receive any price from the <?=($store_name);?> API Token and <?=($store_name);?> Id. You may pass the dynamic 'price' parameter (i.e. price) to us by using the same <?=($store_name);?> Id.</aside>
		  </td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>cardsend</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>cardsend, a string for default (fixed) value <strong>CHECKOUT</strong>.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>client_ip</strong>
          <div class="method-details"><span class="blue_r">php</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Client IP a php code dynamic get IP value <strong>&lt;?php echo ($_SERVER['HTTP_X_FORWARDED_FOR']? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR']);?&gt;</strong>.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>action</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>action, a string for default (fixed) value <strong>product</strong>.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>source</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>source, a string for default (fixed) value <strong>Encode-Curl-API (Encode Core PHP)</strong>.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>source_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="default (fixed) value ">D</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>source_url, Product or Service url of source_url as per your domain
- a string for default (fixed) value <strong>isset($_SERVER["HTTPS"]) ? 'https://':'http://' . $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI']</strong>.</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>price</strong>
          <div class="method-details"><span class="blue_r">dec(10.0.0)</span> <span class="blue_r"><abbr title="price (e.g. 1,500.00) From Merchant ">M</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Order Amount, currency format in decimal(10.0.0)</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>product_name</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Product Name (e.g. Pen,Iphone7 etc) From Merchant ">M</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Product Name</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>fullname</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer full name</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>email</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer billing email</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_street_1</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-badge">required</div>
		  </td>
          <td>Customer's shipping street</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_street_2</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Customer's shipping street 2</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_city</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-badge">required</div>
		  </td>
          <td>Customer's shipping city</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_state</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Customer's shipping state</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_country</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer's shipping country</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_zip</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Customer's shipping zip code</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>bill_phone</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Customer">C</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>Customer billing phone</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>id_order</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Merchant’s order ID that will be returned back in a callback.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>notify_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Synchronous notification URL, you can find it in the response data.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>success_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Redirect url of success as per your domain</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>error_url</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="Merchant">M</abbr></span></div> 
		  <div class="method-details">optional</div>
		  </td>
          <td>Redirect url of error as per your domain</td>
        </tr>
		
		
      </tbody>
    </table>
	
	
	
    <div name="notify_callbacks" data-unique="callbacks"></div>
    <h1 id="notify_callbacks">6. Notify / Callbacks</h1>
    <blockquote>
      <h3 id="example-request">Example Request of curl notify_url</h3>
    </blockquote>
    <pre class="highlight plaintext"><code><span class="p">{</span><span class="w">
    </span><span class="nt">"status_nm"</span><span class="p">:</span><span class="s2">"1"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"status"</span><span class="p">:</span><span class="s2">"Success"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"amount"</span><span class="p">:</span><span class="s2">"20"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"transaction_id"</span><span class="p">:</span><span class="s2">"20170928115044"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"descriptor"</span><span class="p">:</span><span class="kc">"<?=$data['SiteName'];?>"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"tdate"</span><span class="p">:</span><span class="w"> </span><span class="mi">"2017-09-28 11:50:44"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"curr"</span><span class="p">:</span><span class="w"> </span><span class="mi">"INR"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"reason"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Success"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"id_order"</span><span class="p">:</span><span class="s2">"20170131"</span><span class="p">,</span><span class="w">
</span><span class="p">}</span><span class="w">
</span>
</code></pre>
    <p>You can find Notify URL in the area of <?=($store_name);?> Settings to set the value of the parameter. Notify URL parameter’s name is 'notify_url'. However, it is optional because it has to be added dynamically during the payment processing. You will receive the Notify parameters via HTTP POST method. The value of all parameters must be treated as strings.</p>
    
    <aside class="notice"> Merchants may receive the status code by using the CURL or GET method from <a href='#transaction_status' style='color:#e8420d;'>Transaction Status</a>. 
	</aside> 
    <table>
      <thead>
        <tr>
          <th style="text-align: right">Parameter</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
	  <tr>
          <td style="text-align: right"><strong>status_nm</strong>
            <div class="method-details">int</div></td>
          <td>Numeric ID of status.
		  <aside class="warning" style="padding:2px 10px;color:#fff;border-radius:3px;">Status code and their meaning are defined in 
          <a href='#order_status_illustration' style='color:yellow;'>Order status illustration</a>.</aside> 
		  
		  </td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>status</strong>
            <div class="method-details">string</div></td>
          <td>Status of a transaction. See the <a href="#order_status_illustration">Transaction Status</a> section.</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>amount</strong>
            <div class="method-details">decimal(10,2)</div></td>
          <td>Amount of virtual currency to give it to a user.</td>
        </tr>
		
		
        <tr>
          <td style="text-align: right"><strong>transaction_id</strong>
            <div class="method-details">bigint(20)</div></td>
          <td>ID of transaction.</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>descriptor</strong>
            <div class="method-details">string</div></td>
          <td>Memo of Payment Receiver.</td>
        </tr>
		
		<tr>
          <td style="text-align: right"><strong>tdate</strong>
            <div class="method-details">timestamp</div></td>
          <td>Current Date and time when created the transaction</td>
        </tr>
		
		 <tr>
          <td style="text-align: right"><strong>curr</strong>
            <div class="method-details">string(3)</div></td>
          <td>Currency of transaction. Price, deposit and earned parameters are in this curr.</td>
        </tr>
        
		<tr>
          <td style="text-align: right"><strong>reason</strong>
            <div class="method-details">string</div></td>
          <td>May contain a reason for transaction.</td>
        </tr>
		
        <tr>
          <td style="text-align: right"><strong>order_id</strong>
            <div class="method-details">string</div></td>
          <td>Your order ID, if it was provided.</td>
        </tr>
        
        
      </tbody>
    </table>
	
	
   <!--	Transaction Status	--> 
	<div name="status" data-unique="transaction_status"></div>
    <h1 id="transaction_status">7. Transaction Status</h1>
	<blockquote>
      <p>Example of Transaction Status:</p>
    </blockquote>
     <pre class="highlight php">
<span class="cp">//&lt;!--</span><span class="k">Transaction Status </span><span class="nf">by get method</span> <span class="cp">--&gt;</span>
	
<code><span class="k">$url</span><span class="k">="</span><span class="nf"><?=$data['domain_url']?>/validate<?=$data['ex']?>?</span><span class="cp">transaction_id</span><span class="k">=</span><span class="s2">20170928115044</span><span class="nf">&</span><span class="cp">api_token</span><span class="k">=</span><span class="s2">MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ</span><span class="k">";</span>
</code>
	$ch = curl_init();
	curl_setopt($ch,CURLOPT_URL, <span class="k">$url</span>);
	curl_setopt($ch,CURLOPT_POST,0);
	curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch,CURLOPT_SSL_VERIFYPEER, false); 
	curl_setopt($ch,CURLOPT_SSL_VERIFYHOST, false);
	$response = curl_exec($ch);
	curl_close($ch);

	<span class="k">$json_response</span> = json_decode($response,true);
	
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">status_nm</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">status</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">amount</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">transaction_id</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">descriptor</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">tdate</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">curr</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">reason</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">id_order</span>']</span><span class="cp">;</span>
<h3 id="transaction-example-response">Transaction Status for data you will get below response:</h3>
<span class="p">{</span><span class="w">
    </span><span class="nt">"status_nm"</span><span class="p">:</span><span class="s2">"1"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"status"</span><span class="p">:</span><span class="s2">"Success"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"amount"</span><span class="p">:</span><span class="w"> </span><span class="mi">20</span><span class="p">,</span><span class="w">
    </span><span class="nt">"transaction_id"</span><span class="p">:</span><span class="s2">"20170928115044"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"descriptor"</span><span class="p">:</span><span class="w"> </span><span class="s2">"<?=$data['SiteName'];?>"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"tdate"</span><span class="p">:</span><span class="w"> </span><span class="s2">"2017-09-28 11:50:44"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"curr"</span><span class="p">:</span><span class="w"> </span><span class="s2">"INR"</span><span class="p">,</span>
    <span class="w"></span><span class="nt">"reason"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Success"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"id_order"</span><span class="p">:</span><span class="w"> </span><span class="s2">""</span><span class="p"></span><span class="w">
 </span><span class="p">}</span><span class="w">
</span>


</pre>
    <blockquote>
      <h3 id="error-example">Example of Transaction Status</h3>
    </blockquote>
    <pre class="highlight json"><code><span class="p">{</span><span class="w">
    <span class="nt">"status"</span><span class="p">:</span><span class="w"> </span><span class="mi">Success <span class="nf">|</span> Failed <span class="nf">|</span> Pending <span class="nf">|</span> Test</span>
<span class="p">}</span><span class="w">
</span></code></pre>
<table>
      <tbody>
        <tr>
          <td style="text-align: right"><strong>Gateway URL</strong>
          </td>
          <td><?=$data['domain_url']?>/validate<?=$data['ex']?></td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Method</strong>
          </td>
          <td>GET</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Function</strong>
          </td>
          <td>Requests data from a resource by get method</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Remark</strong>
          </td>
          <td>2 mandatory parameter only (<?=($store_name);?> API Token + (Transaction ID or Order ID))</td>
        </tr>
      </tbody>
    </table>
    <table>
      <thead>
        <tr>
          <th style="text-align:right;width:90px;">Parameter</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
	    <tr>
          <td style="text-align: right"><strong>api_token</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="<?=($store_name);?> API Token (e.g. MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div>
		  </td>
          <td><?=($store_name);?> API Token is a string value. You can find it by following <strong><u>My <?=($store_name);?> → <?=($store_name);?> API Token</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>transaction_id</strong>
          <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="Transaction Id (e.g. 521) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div>
		  </td>
          <td>Transaction ID，an integer and you will use it to login to the merchant dashboard. You will find it at the <strong>"Transactions List"</strong> page. You may find merchant login by following <strong><u>View All Transaction → Transaction Id</u>.</strong>
			<aside class="warning" style="padding:2px 10px;color:#fff;border-radius:3px;">Mandatory any one from <font style="color:yellow;">Transaction ID</font> or <font style="color:yellow;">Order ID</font>.</aside>
		  </td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>id_order</strong>
             <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="Order Id (e.g. 1257) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div></td>
          <td>Your order ID, if it was provided.
			<aside class="warning" style="padding:2px 10px;color:#fff;border-radius:3px;">Mandatory any one from <font style="color:yellow;">Transaction ID</font> or <font style="color:yellow;">Order ID</font>.</aside>
		  </td>
        </tr>
		
      </tbody>
    </table>
	
	
	<!-- Refund Request-->
	
	<div name="status" data-unique="refund_order_request"></div>
    <h1 id="refund_order_request">8. Refund Order Request</h1>
	<blockquote>
      <p>Example of Refund Order Request:</p>
    </blockquote>
     <pre class="highlight php">
<span class="cp">//&lt;!--</span><span class="k">Refund Request </span><span class="nf">by get method</span> <span class="cp">--&gt;</span>
	
<code><span class="k">$url</span><span class="k">="</span><span class="nf"><?=$data['domain_url']?>/refund<?=$data['ex']?>?</span><span class="cp">api_token</span><span class="k">=</span><span class="s2">MjdfMTEyMl8yMDE4MDcyNTE0NDc1OA==</span><span class="nf">&</span><span class="cp">transaction_id</span><span class="k">=</span><span class="s2">20170928115044</span><span class="nf">&</span><span class="cp">amount</span><span class="k">=</span><span class="s2">95.50</span><span class="k">";</span>
</code>
	$ch = curl_init();
	curl_setopt($ch,CURLOPT_URL, <span class="k">$url</span>);
	curl_setopt($ch,CURLOPT_POST,0);
	curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch,CURLOPT_SSL_VERIFYPEER, false); 
	curl_setopt($ch,CURLOPT_SSL_VERIFYHOST, false);
	$response = curl_exec($ch);
	curl_close($ch);

	<span class="k">$json_response</span> = json_decode($response,true);
	
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">status_nm</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">message</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">status</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">amount</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">transaction_id</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">descriptor</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">tdate</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">curr</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">reason</span>']</span><span class="cp">;</span>
<span class="cp">echo </span><span class="k">$json_response</span><span class="nf">['<span class="nt">id_order</span>']</span><span class="cp">;</span>
<h3 id="transaction-example-response">Transaction Status after refund for data you will get below response:</h3>
<span class="p">{</span><span class="w">
    </span><span class="nt">"status_nm"</span><span class="p">:</span><span class="s2">"8"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"message"</span><span class="p">:</span><span class="s2">"Request Processed"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"status"</span><span class="p">:</span><span class="s2">"Request Processed"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"amount"</span><span class="p">:</span><span class="w"> </span><span class="mi">20</span><span class="p">,</span><span class="w">
    </span><span class="nt">"transaction_id"</span><span class="p">:</span><span class="s2">"20170928115044"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"descriptor"</span><span class="p">:</span><span class="w"> </span><span class="s2">"<?=$data['SiteName'];?>"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"tdate"</span><span class="p">:</span><span class="w"> </span><span class="s2">"2017-09-28 11:50:44"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"curr"</span><span class="p">:</span><span class="w"> </span><span class="s2">"INR"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"reason"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Success"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"id_order"</span><span class="p">:</span><span class="w"> </span><span class="s2">""</span><span class="p"></span><span class="w">
 </span><span class="p">}</span><span class="w">
</span>


</pre>
    <blockquote>
      <h3 id="error-example">Example of Transaction Status</h3>
    </blockquote>
    <pre class="highlight json"><code><span class="p">{</span><span class="w">
    <span class="nt">"status"</span><span class="p">:</span><span class="w"> </span><span class="mi">Success <span class="nf">|</span> Failed <span class="nf">|</span> Pending</span>
<span class="p">}</span><span class="w">
</span></code></pre>
<table>
      <tbody>
        <tr>
          <td style="text-align: right"><strong>Gateway URL</strong>
          </td>
          <td><?=$data['domain_url']?>/refund<?=$data['ex']?>?api_token=MjdfMTEyMl8yMDE4MDcyNTE0NDc1OA==
		  &transaction_id=20170928115044&amount=95.50</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Method</strong>
          </td>
          <td>GET</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Function</strong>
          </td>
          <td>Requests data from a resource by get method</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>Remark</strong>
          </td>
          <td>3 mandatory parameters only</td>
        </tr>
      </tbody>
    </table>
    <table>
      <thead>
        <tr>
          <th style="text-align:right;width:90px;">Parameter</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td style="text-align: right"><strong>transaction_id</strong>
          <div class="method-details"><span class="blue_r">int</span> <span class="blue_r"><abbr title="Transaction Id (e.g. 521) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div>
		  </td>
          <td>Transaction ID，an integer and you will use it to login to the merchant dashboard. You will find it at the <strong>"Transactions List"</strong> page. You may find merchant login by following <strong><u>View All Transaction → Transaction Id</u>.</strong></td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>api_token</strong>
          <div class="method-details"><span class="blue_r">str</span> <span class="blue_r"><abbr title="<?=($store_name);?> API Token (e.g. MjZfMTEyMF8yMDE4MDcyNzEyMjgyNQ) From Merchant ">M</abbr></span></div>
		  <div class="method-badge">required</div>
		  </td>
          <td><?=($store_name);?> API Token is a string value. You can find it by following <strong><u>My <?=($store_name);?> → <?=($store_name);?> API Token</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>amount</strong>
          <div class="method-details"><span class="blue_r">dec(10,2)</span> <span class="blue_r"><abbr title="price (e.g. 1,500.00) From Merchant ">M</abbr></span></div> <div class="method-badge">required</div>
		  </td>
          <td>This is Order Amount and currency format is set to be in decimal (10,2)</td>
        </tr>
      </tbody>
    </table>
    
    
	<!-- Test Card Number -->
    
    <div name="test_card_number" data-unique="test_card_number"></div>
    <h1 id="test_card_number">9. Test Card Number</h1>	
    <table >
<tbody>
  <tr>
    <th><p><strong>Credit Card Type</strong></p></th>
    <th><p><strong>Credit Card Number</strong></p></th>
    <th><p align="center"><strong>Expiry Month</strong></p></th>
    <th><p align="center"><strong>Expiry Year</strong></p></th>
    <th><p align="center"><strong>CVV</strong></p></th>
  </tr>
  <tr>
    <td><p>Visa</p></td>
    <td><p>4242424242424242</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>MasterCard</p></td>
    <td><p>5555555555554444</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>Rupay India </p></td>
    <td><p>6521111111111117</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>Discover</p></td>
    <td><p>6011000990139424</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>JCB</p></td>
    <td><p>3530111333300000</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>Diners Club</p></td>
    <td><p>30569309025904</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>American Express</p></td>
    <td><p>378282246310005</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>American Express Corporate</p></td>
    <td><p>378734493671000</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>Australian BankCard</p></td>
    <td><p>5610591081018250</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>Dankort (PBS)</p></td>
    <td><p>5019717010103742</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>Maestro</p></td>
    <td><p>6759649826438453</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  <tr>
    <td><p>Cartebleue</p></td>
    <td><p>5555555555554444</p></td>
    <td><p align="center">01</p></td>
    <td><p align="center">30</p></td>
    <td><p align="center">123</p></td>
  </tr>
  </tbody>
</table>
	


    <!-- Error Code -->
    
    <div name="errors" data-unique="error_code"></div>
    <h1 id="error_code">10. Error Code</h1>	
    <table>
      <tbody>
         <tr>
          <th style="text-align:right;width:90px;">Error Code</th>
          <th>Description</th>
        </tr>
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>101 </strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Merchant Side">M</abbr></span> Wrong <?=($store_name);?> API Token </td>
        </tr>
        
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>102</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Merchant Side">M</abbr></span> Inactive <?=($store_name);?> Id</td>
        </tr>
        
        
        
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>104</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Merchant Side">M</abbr></span> Your account have not been approved yet</td>
        </tr>
        
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>105</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Merchant Side">M</abbr></span> Account Currency missing under Merchant User Profile</td>
        </tr>
		<tr>
          <td style="text-align: right;padding:5px !important;"><strong>106</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="Acquirer Missing under <?=($store_name);?> for Contact to Support Team">A</abbr></span> Contact to Support Team</td>
        </tr>
        
         <tr>
          <td style="text-align: right;padding:5px !important;"><strong>150</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Client Side">C</abbr></span> Card Name missing from Bank Gateway</td>
        </tr>
        
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>151</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Client Side">C</abbr></span> Card number can not be empty</td>
        </tr>
        
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>152</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Client Side">C</abbr></span> Wrong card number</td>
        </tr>
        
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>153</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Client Side">C</abbr></span> No Payment Channel Available to process this card</td>
        </tr>
        
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>154</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Client Side">C</abbr></span> Card CCVV number can not be empty.</td>
        </tr>
        
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>155</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Client Side">C</abbr></span> Expiry date month of card can not be empty.</td>
        </tr>
        
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>156</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Client Side">C</abbr></span> Expiry date year of card can not be empty.</td>
        </tr>
        
        <!--<tr>
          <td style="text-align: right;padding:5px !important;"><strong>157</strong>
          </td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Merchant Side">M</abbr></span> Account ID. can not be empty.</td>
        </tr>-->
       
   
      </tbody>
    </table>
    
     <table>
      <tbody>
       <tr>
       	<th colspan="2"><strong>Support by Gateway</strong></th>
       </tr>
        <tr>
          <td style="text-align: right;padding:5px !important;"><strong>Error</strong></td>
          <td style="padding:5px !important;"><span class="blue_r"><abbr title="From Bank Database Side">BD</abbr></span> No payment channel available to process this card</td>
        </tr>
      
   
      </tbody>
    </table>
    
     <table>
      <tbody>
       <tr>
       	<th colspan="2"><strong>Response After Transaction</strong></th>
       </tr>
        <tr>
           <td style="padding:5px !important;"><strong>Q1.</strong></td>
           <td style="padding:5px !important;"><strong>High Risk / Bad Card Request</strong></td>
           </tr>
        <tr>
        	<td style="padding:5px !important;"><strong>Ans.</strong></td>
           <td style="padding:5px !important;">The card has been reported as a highly risky card from the bank side. There could be several reasons. For example: there could be multiple try with this card with wrong information, or there may be bad credit history of the card. </td>
        </tr>
        <tr>
           <td style="padding:5px !important;"><strong>Q2.</strong></td>
           <td style="padding:5px !important;"><strong>Transaction in process</strong></td>
         
        </tr>
        <tr>
          <td style="padding:5px !important;"><strong>Ans.</strong></td>
            <td style="padding:5px !important;">The transaction is in process and status is not confirmed yet. The delay can be due to slow internet speed or server response time. You will be notified soon through email, after the transaction status confirmation.</td> 
         
        </tr>
        <tr>
           <td style="padding:5px !important;"><strong>Q3.</strong></td>
           <td style="padding:5px !important;"><strong>Declined, please contact your issuer or try another card Payment Failed.</strong></td>         
        </tr>
         <tr>
          <td style="padding:5px !important;"><strong>Ans.</strong></td>
            <td style="padding:5px !important;">The transaction is declined from your card issuer side. You may contact to your issuer to get more details about it. For the payment, you may try with another card.</td> 
         </tr>
         

		<tr>
           <td style="padding:5px !important;"><strong>Q4.</strong></td>
           <td style="padding:5px !important;"><strong>User payment count daily limited Payment Failed.  </strong></td>          
        </tr>
         <tr>
          <td style="padding:5px !important;"><strong>Ans.</strong></td>
            <td style="padding:5px !important;">There is a limit for any of the card to be used for every 24 hrs. If the limit exceeds, the card shall be blocked for next 24 hrs, for further use. The limit shall be refreshed by it self after every 24 hrs.<br />To know more about daily card uses limit, you may visit the <u>'Scrubbed - as par customer email Id/ as per amount'</u> area, mentioned as below.</td> 
         </tr>
         
         <tr>
           <td style="padding:5px !important;"><strong>Q5.</strong></td>
           <td style="padding:5px !important;"><strong>VISA/ Master card type unsupported Payment Failed.</strong></td>          
        </tr>
         <tr>
          <td style="padding:5px !important;"><strong>Ans.</strong></td>
            <td style="padding:5px !important;">Acquiring bank failed to locate the issuer of this card. You may please contact to your issuer.</td> 
         </tr>
         
         <tr>
           <td style="padding:5px !important;"><strong>Q6.</strong></td>
           <td style="padding:5px !important;"><strong>Stolen or lost card. Payment Failed.</strong></td>          
        </tr>
         <tr>
          <td style="padding:5px !important;"><strong>Ans.</strong></td>
            <td style="padding:5px !important;">The card has been reported Stolen or Lost. </td> 
         </tr>
         <tr>
           <td style="padding:5px !important;"><strong>Q7.</strong></td>
           <td style="padding:5px !important;"><strong>Insufficient funds Payment Failed.</strong></td>          
        </tr>
         <tr>
          <td style="padding:5px !important;"><strong>Ans.</strong></td>
            <td style="padding:5px !important;">The card limit exceeds and remaining credit limit has insufficient funds to be used.</td> 
         </tr>
         
         <tr>
           <td style="padding:5px !important;"><strong>Q8.</strong></td>
           <td style="padding:5px !important;"><strong>Invalid Card Verification Value (CVV) Payment Failed.</strong></td>          
        </tr>
         <tr>
          <td style="padding:5px !important;"><strong>Ans.</strong></td>
            <td style="padding:5px !important;">The CVV (card verification code) is wrong.</td> 
         </tr> 
         <tr>
           <td style="padding:5px !important;"><strong>Q9.</strong></td>
           <td style="padding:5px !important;"><strong>Expired card Payment Failed. </strong></td>          
        </tr>
         <tr>
          <td style="padding:5px !important;"><strong>Ans.</strong></td>
            <td style="padding:5px !important;">The card is already expired.</td> 
         </tr>        
         
         
   
      </tbody>
    </table>
    
     <table>
      <tbody>
       <tr>
       	<th colspan="2"><strong>Scrubbed - as par customer email Id/ as per amount</strong></th>
       </tr>
        <tr>
           <td style="padding:5px !important;"><strong>Q1.</strong></td>
           <td style="padding:5px !important;"><strong>What is minimum transaction limit?</strong></td>
           </tr>
        <tr>

			<td style="padding:5px !important;"><strong>Ans.</strong></td>
           <td style="padding:5px !important;">The minimum transaction limit is $1 (INR).</td>           
        </tr>
        
        <tr>
           <td style="padding:5px !important;"><strong>Q1.</strong></td>
           <td style="padding:5px !important;"><strong>What is maximum transaction limit?</strong></td>
           </tr>
        <tr>

			<td style="padding:5px !important;"><strong>Ans.</strong></td>
           <td style="padding:5px !important;">The maximum transaction limit is 500 (INR).</td>           
        </tr>
        
        <tr>
           <td style="padding:5px !important;"><strong>Q1.</strong></td>
           <td style="padding:5px !important;"><strong>Per day limit for successful transactions?</strong></td>
           </tr>
        <tr>

			<td style="padding:5px !important;"><strong>Ans.</strong></td>
           <td style="padding:5px !important;">2 (two) successful transactions can be done within a time frame of 24 hrs, from the same card and for the same merchant. After 24 hrs, the limit shall be refreshed and you shall be able to do next two successful transactions. This is how the limit refreshes by it self after every 24 hrs.</td>           
        </tr>
        
        <tr>
           <td style="padding:5px !important;"><strong>Q1.</strong></td>
           <td style="padding:5px !important;"><strong>Per day limit for un-successful transactions?</strong></td>
           </tr>
        <tr>

			<td style="padding:5px !important;"><strong>Ans.</strong></td>
           <td style="padding:5px !important;">5 (five) un-successful transactions can be done within a time frame of 24 hrs, from the same card and for the same merchant. After 24 hrs, the limit shall be refreshed and you shall be able to do next five un-successful transactions. This is how the limit refreshes by it self after every 24 hrs.</td>           
        </tr>
        <tr>
        <td><strong>Note:</strong></td>
        <td>Kindly contact customer service team to get more information about scrub setting on your account.</td>
        </tr>
        
             
         
       
   
      </tbody>
    </table>
    
    <!-- End Error Code -->
    
	<!--<dl class="col_2">
        <dt><em>Status Code</em></dt>
        <dd><em>Meaning</em></dd>
        <dt>0</dt>
        <dd>Pending</dd>
        <dt>1</dt>
        <dd>Success</dd>
        <dt>2</dt>
        <dd>Failed</dd>
        <dt>3</dt>
        <dd>Refunded</dd>
        <dt>4</dt>
        <dd>Settled</dd>
        <dt>5</dt>
        <dd>Chargeback</dd>
        <dt>6</dt>
        <dd>Returned</dd>
        <dt>7</dt>
        <dd>Success (Transaction Refunded or Returned)</dd>
        <dt>8</dt>
        <dd>Refund Requested</dd>
		<dt>9</dt>
        <dd>Test Transaction</dd>
		<dt>10</dt>
        <dd>Scrubbed</dd>
		<dt>11</dt>
        <dd>CBK1</dd>
		
    </dl>-->
	

    <div name="integration_faq" data-unique="integration_faq"></div>
    <h1 id="integration_faq">11. Integration FAQ</h1>
    <table>
      <tbody>
        <tr>
          <td><strong>Q1.</strong></td>
          <td>I am getting an error <strong>"Your account have not been approved yet. Please contact support@<?=$data['SiteName'];?> for assistance."</strong></td>
        </tr>
        <tr>
          <td><strong>Ans.</strong></td>
          <td>
			  <ol style="padding:0;margin:0 10px;">
				<li><strong>Merchant  Login - </strong> <strong><u> <a type="Click Here" href="<?=$data['domain_url']?>/user/<?=($store_url);?><?=$data['ex']?>" target="_blank"><abbr title="Click for Go to My <?=($store_name);?>">My <?=($store_name);?> </abbr></span></a> → <?=($store_name);?> API Token</u></strong></li>
				<li>You should make sure that, the mandatory parameter must be passed by the <strong>approved URL</strong> or test on localhost also. </li>
				<li>Ensure the <strong>Select "<?=($store_name);?> ID"</strong> and <strong>Select <?=($store_name);?> API Token</strong> has been selected while creating the "Add A New <?=($store_name);?>".  </li>
			  </ol>
		  </td>
        </tr>
		
		<tr>
          <td><strong>Q2.</strong></td>
          <td>Should I need to use the <strong><?=($store_name);?> API Token</strong> for my all products?</td>
        </tr>
        <tr>
          <td><strong>Ans.</strong></td>
          <td>
			  <ol style="padding:0;margin:0 10px;">
				<li><strong>No</strong></li>
				<li>You need to select only <strong>one <?=($store_name);?> API Token</strong> and <strong><?=($store_name);?> ID</strong> as per your <strong><?=($store_name);?> ID</strong>.</li>
				<li>Pass the <strong>amount</strong> parameters and <strong>product name</strong> dynamically by using the same <?=($store_name);?> API Token and <?=($store_name);?> ID.  </li>
			  </ol>
		  </td>
        </tr>
		
		<tr>
          <td><strong>Q3.</strong></td>
          <td>My <strong>woo-Commerce plugins</strong>  is not working?</td>
        </tr>
        <tr>
          <td><strong>Ans.</strong></td>
          <td>
			  <ol style="padding:0;margin:0 10px;">
				<li>You must create <strong>one <a href="<?=$data['domain_url']?>/user/new_<?=($store_url);?><?=$data['ex']?>" target="_blank"><abbr title="Click for Go to Add New <?=($store_name);?>">Add New <?=($store_name);?> </abbr></span></a></strong> inside  the merchant portal and pass the <strong><?=($store_name);?> API Token, <?=($store_name);?> ID and Transaction URL </strong> and woo-Commerce parameter from the 
                administrator area of your website.	</li>
			  </ol>
		  </td>
        </tr>
		
		<tr>
          <td><strong>Q4.</strong></td>
          <td>What is <strong>test card number</strong>?</td>
        </tr>
        <tr>
          <td><strong>Ans.</strong></td>
          <td>
			  <ol style="padding:0;margin:0 10px;">
				<li><strong>4444 4444 4444 4444 </strong> &nbsp;&nbsp;&nbsp; 01/2020 &nbsp;&nbsp;&nbsp;123 &nbsp;&nbsp;&nbsp;(4 sixteen times)	</li>
				<li><strong>4242 4242 4242 4242 </strong> &nbsp;&nbsp;&nbsp; 01/2020 &nbsp;&nbsp;&nbsp;123 &nbsp;&nbsp;&nbsp;(42 eight times)</li>
			  </ol>
		  </td>
        </tr>
		<tr>
          <td><strong>Q5.</strong></td>
          <td>Can I run this Payment Gateway On Local Host?</td>
        </tr>
        <tr>
          <td><strong>Ans.</strong></td>
          <td>
			  <ol style="padding:0;margin:0 10px;">
				<li><strong>Yes</strong></li>
				<li>You can test on Local Host.</li>
				<li>Also, on <strong>Approved Business URL</strong>.</li>
			  </ol>
		  </td>
        </tr>
		
		
		
      </tbody>
    </table>
	
	<div name="shopping_cart_plugins" data-unique="Shopping Cart Plugins"></div>
    <h1 id="shopping_cart_plugins">12. Shopping Cart Plugins</h1>
	 <table>
      <tbody>
        <tr>
         <!-- <td><strong>1.</strong></td>-->
          <td><strong><b style="font-size:25px;">Wordpress Plugin</b></strong></td>
        </tr>
        <tr>
          <!--<td><strong>Req.</strong></td>-->
          <td>
			  <ol style="padding:0;margin:0 10px;">
				<strong><b style="font-size:22px;">Requirements</b></strong></br>
				<strong><b style="font-size:18px;">WooCommerce Version 3.3.5 </b></strong></br>
				<strong><b style="font-size:14px; color:green">Installation</b></strong>
				<li>Login to your admin dashboard and navigate to Admin Menu -> Plugins -> Add New -> Search -> <?=$data['SiteName'];?>. </li>
				<li>Activate the plugin </li>
				<li>Navigate to plugin settings page following by Admin Menu -> WooCommerce -> Settings -> Checkout -> <?=$data['SiteName'];?>.</li>
				<li><a href="#preparation">Click here</a> to get your keys.</li>
			  </ol>
		  </td>
        </tr>
	
        
      </tbody>
    </table>

    
    <div name="card" data-unique="cards"></div>
    <h1 id="cards">13. Card</h1>
	
	
    <div name="create-a-token" data-unique="create-a-token"></div>
    <p>Continue for card details on <?=$data['SiteName'];?></p>
		
		<blockquote>
      <h3 id="example-object">Example Card</h3>
    </blockquote>
    <pre class="highlight json"><code><span class="p">{</span><span class="w">
    </span><span class="nt">"ccno"</span><span class="p">:</span><span class="w"> </span><span class="s2">"4242424242424242"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"ccvv"</span><span class="p">:</span><span class="w"> </span><span class="s2">"123"</span><span class="p">,</span><span class="w">
    </span><span class="nt">"month"</span><span class="p">:</span><span class="w"> </span><span class="mi">01</span><span class="p">,</span><span class="w">
    </span><span class="nt">"year"</span><span class="p">:</span><span class="w"> </span><span class="mi">30</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>


    <table>
      <thead>
        <tr>
          <th style="text-align: right">Parameter</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td style="text-align: right"><strong>ccno</strong>
            <div class="method-badge">required</div></td>
          <td>Card number without any separators.</td>
        </tr>
		<tr>
          <td style="text-align: right"><strong>ccvv</strong>
            <div class="method-badge">required</div></td>
          <td>Card security code (CVC, CVV2).</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>month</strong>
            <div class="method-badge">required</div></td>
          <td>Two digit integer (numric) value representing the card’s expiration month.</td>
        </tr>
        <tr>
          <td style="text-align: right"><strong>year</strong>
            <div class="method-badge">required</div></td>
          <td>Two digit integer (numric) value representing card’s expiration year.</td>
        </tr>       
      </tbody>
    </table>
	
	
        
	</div>
  <div class="dark-box" style="position:relative;">
    <div class="lang-selector"> <a href="<?=$data['domain_url']?>/developer/#" data-language-name="curl" class="active">PARAMETERS</a> </div>
  </div>
</div>
</body>
</html>
