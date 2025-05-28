<? if(isset($data['ScriptLoaded'])){?>
<div class="container border my-2 bg-white vkg" >

        <style>
.menu-hidden .navbar.main .btn-navbar {left: 230px;}.menu-hidden .navbar.main .appbrand {display: inline;}
</style>

<div>
<h4 class="my-2"><i class="<?=$data['fwicon']['copy'];?>"></i> Copy This Code And Paste Into Your Page:</h4>
<p>CODE #1 - Using POST method:</p>
<textarea class="form-control"   readonly style="height:500px;"><?=$post['HtmlCode']?></textarea>
</div>

<div class="container">
<h5 class="my-2">Description for all fields which you can use:</h5>
<p>
		For successful payment process you should use next parameters:<br />

		
		<table class="table table-striped">
		<tr><td>username</td><td>-</td><td>your username</td></tr>
		<tr><td>product</td><td>-</td><td>product ID or name</td></tr>
		<tr><td>action</td><td>-</td><td>use "product" if this product is pre-defined<br />
					                     use "donation" if this is donation payment<br />
					                     use "subscription" if this product is subscription<br />
					                     use "payment" if this is simple payment transaction<br /></td></tr>
		<tr><td>price</td><td>-</td><td>price of product, $</td></tr>
		<tr><td>quantity</td><td>-</td><td>quantity</td></tr>
		
		<tr><td>period</td><td>-</td><td>subscription rebilling period, days</td></tr>
		<tr><td>trial</td><td>-</td><td>trial period, days</td></tr>
		<tr><td>setup</td><td>-</td><td>setup fee, $</td></tr>
		<tr><td>tax</td><td>-</td><td>tax fee, $</td></tr>
		<tr><td>shipping</td><td>-</td><td>shipping fee, $</td></tr>
		<tr><td>ureturn</td><td>-</td><td>return URL</td></tr>
		<tr><td>unotify</td><td>-</td><td>cancel URL</td></tr>
		<tr><td>quantity</td><td>-</td><td>quantity</td></tr>
		<tr><td>comments</td><td>-</td><td>product description</td></tr>
       
	   
	   
	    </table>

		</p>
</div>


<div class="container">
<h5 class="my-2">Additional information:</h5>
<p>
After successful payment process system will forward buyer to your site
		and some parameters will back to your script by the POST method:
<table class="table table-striped">
		<tr><td>action</td><td>-</td><td>type of transaction (product/donation/subscription/payment)</td></tr>
		<tr><td>pid</td><td>-</td><td>internal product ID</td></tr>
		
		<tr><td>pname</td><td>-</td><td>product name</td></tr>
		<tr><td>buyer</td><td>-</td><td>buyer username</td></tr>
		
		<tr><td>total</td><td>-</td><td>total amount</td></tr>
		<tr><td>quantity</td><td>-</td><td>quantity</td></tr>
		
		<tr><td>comments</td><td>-</td><td>buyer notes</td></tr>
		<tr><td>referer</td><td>-</td><td>system referer URL (<?=$data['Host']?>)</td></tr>
		</table>
	You can get this parameters by the global POST variable,
		e.g. $_POST[--VARIABLE-NAME--]...
		
			
	</p>	

</div>          
</div>      
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
