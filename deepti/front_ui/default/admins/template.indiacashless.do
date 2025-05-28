<? if(isset($data['ScriptLoaded'])){?>

<?
if((!isset($_SESSION['login_adm']))&&(!$_SESSION['useful_link'])){
	echo $data['OppsAdmin'];
	exit;
}
?>

<style>
.navbar-brand { font-size:14px !important; }

</style>
<div class="container border bg-white vkg mb-3">
	<h1 class="my-2"><i class="fas fa-link"></i> Useful Links</h1>

	<div class="vkg-main-border"></div>

	<? if(!$data['PostSent']){?>
	<? if ((isset($data['Error'])&& $data['Error']) && (!$post['change2way'])){?>
		<div class="alert alert-danger alert-dismissible">
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			<strong>Error!</strong><?=prntext($data['Error'])?>
		</div>
		<? }?>

		<? if($data['MYWEBSITE']||$_REQUEST['a']){?>	
			<h3 >India Cashless Plugins</h3> 
			<h4>WP Wordpress (wooCommerce) Plugins (<?=($data['SiteName']);?>) Download </h4> 
	
			<a href="<?=$data['Host']?>/plugins/indiacashless-woocommerce-plugin.zip" target="_blank" title="WP Plugins Download">indiacashless-woocommerce-plugin.zip</a> 
			<hr />
			<h4>WHMCS Plugins (<?=($data['SiteName']);?>) Download </h4> 
			<a href="<?=$data['Host']?>/plugins/indiacashless-whmcs.zip" target="_blank" title="WHMCS Download">indiacashless-whmcs.zip</a> 
			<hr />

			<h4>PrestaShop 1.7 Plugins (<?=($data['SiteName']);?>) Download </h4> 
			<a href="<?=$data['Host']?>/plugins/IndiacashlessPrestaShop.zip" target="_blank" title="PrestaShop 1.7 Download">IndiacashlessPrestaShop.zip</a>
	
		<? }?>
	<hr/>
	<h3>Pay via @user with Amount:</h3> 
	<a class="nopopup  mt-2 mb-3 cursor-pointer" onclick="ctcf('#paymeId','href','1')" style="cursor:pointer;"><i class="fa-solid fa-copy "></i></a>
	<a id="paymeId" href="<?=$data['Host']?>/@<?=$data['test_merchant_user'];?>/150/" target="_blank" title="Direct Checkout (@UserId and Amount):"><?=$data['Host']?>/@<?=$data['test_merchant_user'];?>/150/</a> 
	
	
	<hr/>
	<h3 class="m201" style="margin:20px 0 0 0;">Encode-Checkout  </h3> 
		<a href="<?=$data['Host']?>/enc/pram_encode.zip" target="_blank" title="Encode-Checkout"><?=$data['Host']?>/enc/pram_encode.zip</a>
		
		
	<hr/>
	<h3>New Merchant Sign-up by Referral User ID of SubAmin</h3> 
		<a href="<?=$data['Host']?>/signup.do?rid=userid" target="_blank" title="New Merchant Sign-up by Referral User ID of SubAmin "><?=$data['Host']?>/signup.do?rid=userid</a>
	<hr/>

	<?
	if(isset($_SESSION['login_adm']))
	{
		$subadmin=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}subadmin` WHERE `domain_name`!='' ",0
		);
		if($subadmin){
		?>
		<hr/>
		<div class=" ">
		<h4>Domain List</h4>
			<ul class="list-group">
			<?
			$i=0;
			foreach($subadmin as $key=>$value){ $i++;
			?>
				<li class="list-group-item" style="list-style:none;"><a class="nopopup text-primary mt-2 mb-3 cursor-pointer" onclick="ctcf('#domainId_<?=$i?>','href')" style="cursor:pointer;"><i class="fas fa-copy"></i></a> <a id="domainId_<?=$i?>" href="<?=$data['Prot']?>://<?=$value['domain_name']?>/signins/login<?=$data['ex'];?>" target="_blank"><?=$value['domain_name']?></a> | 
				<? 
				if($value['domain_active']=='1') echo 'Live'; else 'Not Live';?> 
				<? if($value['front_ui']) echo "| ".$value['front_ui']?>
				<? if($value['upload_css']) echo "| ".$value['upload_css'];?>
				</li>
			<?
			}
			?>
			</ul>
		</div>
		
		<?
		}
	}?>
	
	<hr/>
	<h3>Calculation Function</h3>
	<h4>Transaction Calculation </h4> 
	<a href="<?=$data['Host']?>/include/all_merchant_calc_check<?=$data['ex']?>?sq=1&link=1" target="_blank" title="Calculation Mismatch Link for Merchant Wise ">Calculation Mismatch Link for Merchant Wise</a> |
	<a href="<?=$data['Host']?>/include/all_merchant_calc_check<?=$data['ex']?>?sq=1" target="_blank" title="Calculation Mismatch for All Merchant Wise">Calculation Mismatch for All Merchant Wise</a> |
	<hr/>

	<h3>Currency Convert</h3> 
	<a href="<?=$data['Host'];?>/include/currency_convert<?=$data['ex']?>?a=10&fr=USD&to=INR&g=1" target="_blank" title="Free Currency Convert">Currency Convert</a> |
	<a href="<?=$data['Host'];?>/include/email_validate3<?=$data['ex']?>?email=info@<?=$data['SiteName']?>" target="_blank" title="Free Trumail Validation">Trumail</a> |
	<a href="<?=$data['Host'];?>/include/email_validate3<?=$data['ex']?>?ftype=xverify&email=info@<?=$data['SiteName']?>" target="_blank" title="Paid Xverify Validation">Xverify</a> |
	<a href="<?=$data['Host'];?>/include/email_validate3<?=$data['ex']?>?ftype=zerobounce&email=info@<?=$data['SiteName']?>" target="_blank" title="Paid Zerobounce Validation">Zerobounce</a>


		<h3>Bootstrap 5</h3> 
		<div class="container mt-3">
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
				<a class="navbar-brand" href="javascript:void(0)">Navbar</a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active" aria-current="page" href="javascript:void(0)">Home</a></li>
						<li class="nav-item"><a class="nav-link" href="javascript:void(0)">Link</a></li>
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Dropdown</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item" href="javascript:void(0)">Action</a></li>
								<li><a class="dropdown-item" href="javascript:void(0)">Another action</a></li>
								<li><hr class="dropdown-divider"></li>
								<li><a class="dropdown-item" href="javascript:void(0)">Something else here</a></li>
							</ul>
						</li>
						<li class="nav-item">
							<a class="nav-link disabled" href="javascript:void(0)" tabindex="-1" aria-disabled="true">Disabled</a></li>
					</ul>
					<form class="d-flex">
						<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
						<button class="btn btn-outline-success" type="submit">Search</button>
					</form>
					</div>
				</div>
			</nav>
		</div>

		<br />
		<br />
		<br />
		<br />

<?php /*?> Dev Tech : 23-02-10 getting dynamic value for use dynamic color code & variable <?php */?>
	
	<div class="container my-8">
		<h4 class="my-2">Font Awesome Icons</h4>
		<table class="table">
			<thead><tr><th class="" scope="col">Icon</th><th class="" scope="col">Code</th><th class="" scope="col">Name</th></tr></thead>
			<?foreach($data['fwicon'] as $ic9k => $ic9){if(stf($ic9)){?><tr><td><i class="<?=stf($ic9)?>" style="font-size:24px;"></i></td><td class="click_icon" title="click to copy" style="vertical-align:middle;"><code><pre style="margin:inherit;font-size:14px;">$data['<?=$ic9k?>']['<?=stf($ic9)?>']</pre></code></td><td class="click_icon" title="click to copy" style="vertical-align:middle;"><?=stf($ic9)?></td></tr><?}}?>
		</table>
		
		
		<div class="my-3">
			<a href="https://fontawesome.com/v6/search?o=r&m=free" title="For More Icon Click Here" target="_blank"><strong><i class="<?=$data['fwicon']['hand'];?> text-danger"></i> For More Icon Click Here </strong></a>
		</div>
		<h4 class="my-2">Image Icons</h4>
		<table class="table table-striped">
			<thead><tr><th class="" scope="col">Icon</th><th class="" scope="col">Code</th><th class="" scope="col">Full Path</th></tr></thead>
			<? foreach($data['bankicon'] as $ic9k => $ic9){if(stf($ic9)){ ?><tr><td>
			
			<a href="<?=$ic9?>" class="img-fluid" target="_blank"><img src="<?=$ic9?>" style="height:30px;padding-right: 10px;"></a>
			</td><td class="click_icon" title="click to copy" style="vertical-align:middle;"><code><pre style="margin:inherit;font-size:14px;">$data['bankicon']['<?=$ic9k?>']</pre></code></td><td class="click_icon" title="click to copy" style="vertical-align:middle;"><?=$ic9?></td></tr><? }} ?>
		</table>
		
		<h4 class="my-2">URL Image</h4>
		<table class="table table-striped">
			<thead><tr><th class="" scope="col">Icon</th><th class="" scope="col">Code</th><th class="" scope="col">Full Path</th></tr></thead>
			<? foreach($data['url-image'] as $ic9k => $ic9){if(stf($ic9)){ ?><tr><td>
			
			<a href="<?=$ic9?>" class="img-fluid" target="_blank"><img src="<?=$ic9?>" style="height:30px;padding-right: 10px;"></a>
			</td><td class="click_icon" title="click to copy" style="vertical-align:middle;"><code><pre style="margin:inherit;font-size:14px;">$data['bankicon']['<?=$ic9k?>']</pre></code></td><td class="click_icon" title="click to copy" style="vertical-align:middle;"><?=$ic9?></td></tr><? }} ?>
		</table>
	</div>
	
	<script>
  $(".click_icon").click(function(){
   text=$(this).text();
   
			var $txt = $('<textarea />');
            $txt.val(text)
                .css({ width: "1px", height: "1px" })
                .appendTo('body');

            $txt.select();

            if (document.execCommand('copy')) {
                $txt.remove();
				//alert("Copied");
				alert(text+"\n\nCopied.");
            }
			
   });
</script>


	<div class="container mt-3">
		<h2>Horizontal gutters</h2>
		<div class="container px-4">
			<div class="row gx-5">
				<div class="col">
					<div class="p-3 border bg-light">Custom column</div>
				</div>
				<div class="col">
					<div class="p-3 border bg-light">Custom column</div>
				</div>
				<div class="col">
					<div class="p-3 border bg-light">Custom column</div>
				</div>
				<div class="col">
					<div class="p-3 border bg-light">Custom column</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container mt-3">
		<p>
			<a class="btn btn-primary my-2" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">Link with href</a>
			<button class="btn btn-primary my-2" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">Button with data-bs-target</button>
		</p>
		<div class="collapse" id="collapseExample">
			<div class="card card-body">
				Some placeholder content for the collapse component. This panel is hidden by default but revealed when the user activates the relevant trigger.
			</div>
		</div>
	</div>

	<div class="container mt-3">
		<button type="button" class="btn btn-primary my-2" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">Open modal for @mdo</button>
		<button type="button" class="btn btn-primary my-2" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@fat">Open modal for @fat</button>
		<button type="button" class="btn btn-primary my-2" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">Open modal for @getbootstrap</button>
	
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">New message</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
					<form>
						<div class="mb-3">
							<label for="recipient-name" class="col-form-label">Recipient:</label>
							<input type="text" class="form-control" id="recipient-name">
						</div>
						<div class="mb-3">
							<label for="message-text" class="col-form-label">Message:</label>
							<textarea class="form-control" id="message-text"></textarea>
						</div>
					</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Send message</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container mt-3">
		<h2>Bordered Table</h2>
		<p>The .table-bordered class adds borders on all sides of the table and the cells:</p>
		<table class="table table-striped m-1">
			<thead>
				<tr><th>Firstname</th>
					<th>Lastname</th>
					<th>Email</th></tr>
			</thead>
			<tbody>
				<tr><td>John</td>
					<td>Doe</td>
					<td>john@ex.com</td></tr>
				<tr><td>Mary</td>
					<td>Moe</td>
					<td>mary@ex.com</td></tr>
				<tr><td>July</td>
					<td>Dooley</td>
					<td>july@ex.com</td></tr>
			</tbody>
		</table>
	</div>


	<div class="container mt-3">
		<h2>Button Styles</h2>
		<button type="button" class="btn my-2">Basic</button>
		<button type="button" class="btn btn-primary my-2">Primary</button>
		<button type="button" class="btn btn-secondary my-2">Secondary</button>
		<button type="button" class="btn btn-success my-2">Success</button>
		<button type="button" class="btn btn-info my-2">Info</button>
		<button type="button" class="btn btn-warning my-2">Warning</button>
		<button type="button" class="btn btn-danger my-2">Danger</button>
		<button type="button" class="btn btn-dark my-2">Dark</button>
		<button type="button" class="btn btn-light my-2">Light</button>
		<button type="button" class="btn btn-link my-2">Link</button>
	</div>

	<div class="container mt-3">
		<h2>Button Group</h2>
		<p>The .btn-group class creates a button group:</p>
		<div class="btn-group">
			<button type="button" class="btn btn-primary">Apple</button>
			<button type="button" class="btn btn-primary">Samsung</button>
			<button type="button" class="btn btn-primary">Sony</button>
		</div>
	</div>


	<div class="container mt-3">
		<h2>Pagination - Active State</h2>
		<p>Add class .active to let the user know which page he/she is on:</p>
		<ul class="pagination">
			<li class="page-item"><a class="page-link" href="javascript:void(0)">Previous</a></li>
			<li class="page-item"><a class="page-link" href="javascript:void(0)">1</a></li>
			<li class="page-item  active"><a class="page-link bg-primary" href="javascript:void(0)">2</a></li>
			<li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li>
			<li class="page-item"><a class="page-link" href="javascript:void(0)">Next</a></li>
		</ul>
	</div>

	<div class="container mt-3">
		<h2>Active Item in a List Group</h2>
		<ul class="list-group">
			<li class="list-group-item bg-primary active">Active item</li>
			<li class="list-group-item">Second item</li>
			<li class="list-group-item">Third item</li>
		</ul>
	</div>

	<div class="container mt-3">
		<h2>Dropdown button</h2>
		<div class="dropdown">
			<button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">
				Dropdown button
			</button>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="javascript:void(0)">Link 1</a></li>
				<li><a class="dropdown-item" href="javascript:void(0)">Link 2</a></li>
				<li><a class="dropdown-item" href="javascript:void(0)">Link 3</a></li>
			</ul>
		</div>
	</div>

	<div class="container mt-3">
		<div class="accordion" id="accordionExample">
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingOne">
					<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
					Accordion Item #1
					</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
					<div class="accordion-body">
					<strong>This is the first item's accordion body.</strong> It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingTwo">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
					Accordion Item #2
					</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
					<div class="accordion-body">
					<strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingThree">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
					Accordion Item #3
					</button>
				</h2>
				<div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container mt-3">
		<h2>Alerts</h2>
		<p>The button with class="btn-close" and data-bs-dismiss="alert" is used to close the alert box.</p>
		<p>The alert-dismissible class aligns the button to the right.</p>
		<div class="alert alert-success alert-dismissible">
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			<strong>Success!</strong> This alert box could indicate a successful or positive action.
		</div>
		<div class="alert alert-info alert-dismissible">
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			<strong>Info!</strong> This alert box could indicate a neutral informative change or action.
		</div>
		<div class="alert alert-warning alert-dismissible">
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			<strong>Warning!</strong> This alert box could indicate a warning that might need attention.
		</div>
		<div class="alert alert-danger alert-dismissible">
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			<strong>Danger!</strong> This alert box could indicate a dangerous or potentially negative action.
		</div>
		<div class="alert alert-primary alert-dismissible">
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			<strong>Primary!</strong> Indicates an important action.
		</div>
		<div class="alert alert-secondary alert-dismissible">
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			<strong>Secondary!</strong> Indicates a slightly less important action.
		</div>
		<div class="alert alert-dark alert-dismissible">
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			<strong>Dark!</strong> Dark grey alert.
		</div>
		<div class="alert alert-light alert-dismissible">
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			<strong>Light!</strong> Light grey alert.
		</div>
	</div>


	<div class="container">
		<h2>Simple Collapsible</h2>
		<p>Click on the button to toggle between showing and hiding content.</p>
		<button type="button" class="btn btn-primary" data-toggle="collapse" data-target="#demo">Simple collapsible</button>
		<div id="demo" class="collapse">
			Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
		</div>
	</div>
		
	<div class="container">
		<h2>Pills with Dropdown</h2>
		<ul class="nav nav-pills">
			<li class="nav-item"><a class="nav-link active bg-primary" href="javascript:void(0)">Active</a></li>
			<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)">Dropdown</a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="javascript:void(0)">Link 1</a>
					<a class="dropdown-item" href="javascript:void(0)">Link 2</a>
					<a class="dropdown-item" href="javascript:void(0)">Link 3</a></div>
			</li>
			<li class="nav-item"><a class="nav-link" href="javascript:void(0)">Link</a></li>
			<li class="nav-item"><a class="nav-link disabled" href="javascript:void(0)">Disabled</a></li>
		</ul>
	</div>
  <? /* ?>
	<div class="container">
		<h2>Stacked form</h2>
		<form action="/action_page.php">
			<div class="form-group">
				<label for="email">Email:</label>
				<input type="email" class="form-control" id="email" placeholder="Enter email" name="email">
			</div>
			<div class="form-group">
				<label for="pwd">Password:</label>
				<input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pswd">
			</div>
			<div class="form-group form-check">
				<label class="form-check-label">
				<input class="form-check-input" type="checkbox" name="remember"> Remember me
			</label>
			</div>
			<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>
  <? */ ?>
	<div class="container mt-3">
		<h3>Input Groups</h3>
		<p>The .input-group class is a container to enhance an input by adding an icon, text or a button in front (.input-group-prepend) or behind (.input-group-append) the input field as a "help text".</p>
		<p>Use the .input-group-text class to style the specified help text.</p>
		
		<form action="/action_page.php">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">@</span>
				</div>
				<input type="text" class="form-control" placeholder="Username" id="usr" name="username">
			</div>
	
			<div class="input-group mb-3">
				<input type="text" class="form-control" placeholder="Your Email" id="mail" name="email">
				<div class="input-group-append">
					<span class="input-group-text">@example.com</span>
				</div>
			</div>
			<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>

	<div class="container">
		<h2>Borders</h2>
		<p>Use a contextual border color to add a color to the border:</p> 
		<span class="border border-primary"></span>
		<span class="border border-secondary"></span>
		<span class="border border-success"></span>
		<span class="border border-danger"></span>
		<span class="border border-warning"></span>
		<span class="border border-info"></span>
		<span class="border border-light"></span>
		<span class="border border-dark"></span>
		<span class="border border-white"></span>
	</div>

	<div class="container">
		<h1>My Icons <i class="fas fa-heart"></i></h1>
		<p>An icon along with some text: <i class="fas fa-thumbs-up"></i></p> 
	</div>

	<div class="container">
		<p>Others:</p>
		<i class="fas fa-cloud text-info"></i>
		<i class="fas fa-car text-success"></i>
		<i class="fas fa-file text-warning"></i>
		<i class="fas fa-bars text-dark"></i>
		<i class="fas fa-dollar-sign text-danger"></i>
		<i class="fas fa-check text-primary"></i>
		<i class="fas fa-times text-secondary"></i>
		<i class="fas fa-retweet text-light"></i>
		<i class="fas fa-plus-circle"></i>
		<i class="far fa-plus-square"></i>
		<i class="far fa-minus-square"></i>
		<i class="fas fa-lock"></i>
		<i class="fas fa-eye"></i>
		<i class="far fa-hand-point-down"></i>
		<i class="fas fa-ban"></i>
		<i class="fas fa-book-reader"></i>
		<i class="fas fa-share-square"></i>
		<i class="far fa-edit text-success"></i>
		<i class="far fa-question-circle"></i>
		<i class="fas fa-university"></i>
		<i class="fas fa-arrow-circle-right"></i>
		<i class="fas fa-arrow-circle-left"></i>
		<i class="fas fa-arrow-left"></i>
		<i class="fas fa-arrow-right"></i>
		<i class="fas fa-check-double"></i>
		<i class="fas fa-check-square"></i>
		<i class="far fa-check-square"></i>
		<i class="fas fa-chevron-circle-left"></i>
		<i class="fas fa-chevron-circle-right"></i>
		<i class="fas fa-external-link-alt"></i>
		<i class="far fa-hand-point-right"></i>
		<i class="far fa-hand-point-down"></i>
		<i class="fas fa-list"></i>
		<i class="fas fa-list-alt"></i>
		<i class="far fa-list-alt"></i>
		<i class="fas fa-power-off"></i>
		<i class="fas fa-redo"></i>
		<i class="fas fa-rupee-sign"></i>
		<i class="fas fa-search"></i>
		<i class="fas fa-user-plus"></i>
		<i class="fas fa-user-minus"></i>
		<i class="fas fa-user-check"></i>
		<i class="fas fa-user-friends"></i>
		<i class="fas fa-user-cog"></i>
		
		<div class="my-3">
			<a href="https://fontawesome.com/v5.15/icons?d=gallery&p=2&m=free" title="For More Icon Click Here" target="_blank"><strong><i class="far fa-hand-point-right text-danger"></i> For More Icon Click Here </strong></a>
		</div>
	</div>
</div>

<? }?>

<? }else{?>
	SECURITY ALERT: Access Denied
<? }?>