<? 
if(isset($data['ScriptLoaded'])){
	$domain_server=$_SESSION['domain_server']; // for display merchant logo
	$default_full_currency=prntext($post['default_currency']); // For Default Currency
global $uid;
$post['gid']=isset($post['gid'])&&$post['gid']?$post['gid']:$post['id'];
?>

<div  class="container border my-2 rounded">



<style>
.upperinput {
	text-transform: uppercase;
}
.lowerinput {
	text-transform:lowercase;
}
/*class for mobile responsive*/

hr {
	margin: 0px 0 !important;
}
.card {
	display: inherit !important;
}

@media (max-width: 768px) {
	#s_box .col-md-1 {
		width: 8.33333333% !important;
		max-width: 8.33333333% !important;
	}
	#s_box .col-md-1 {
		width: 100% !important;
		max-width: 100% !important;
	}
}
</style>
<div class="row">
	
		<div class="float-start my-2 w-50"><h2><i class="<?=$data['fwicon']['qrcode'];?>"></i> QR Code</h2></div>
		<div class="float-start text-end my-2 w-50"><? if(($post['step']==1) && (!isset($_GET['qrid'])&&empty($_GET['qrid']))){ ?><form method="post"><button type="submit" name="send" value="Generate QR Code" class="btn btn-sm btn-primary my-1"><i class="fas fa-plus-circle" title="Generate QR Code"></i></button></form><? } ?></div>
	
</div>
<? include $data['Path']."/include/message".$data['iex'];?>

<?php /*?><form method="post" name="data" action="<?=$_SERVER['PHP_SELF'];?><? if(isset($post['gid'])&&$post['gid']&&isset($_GET['admin'])&&$_GET['admin']) echo '?id='.$post['gid'].'&admin=1';?>">
<?php */?>

<form method="post" name="data">


	<input type="hidden" name="step" value="<?=((isset($post['step'])&&$post['step'])?$post['step']:'')?>">
	<input type="hidden" name="uid" value="<?=((isset($post['uid'])&&$post['uid'])?$post['uid']:'')?>">
	<? 
	if(isset($_GET['action'])&&$_GET['action']=='edit') $post['step']=2;
	elseif(isset($_GET['action'])&&$_GET['action']=='preview') $post['step']=3; 
	
	if(($post['step']==1) && (!isset($_GET['qrid'])&&empty($_GET['qrid']))){ 
	?>
	
	<div class="table-responsive my-1 p-list">
	
	<? if(count($data['selectdatas']) > 0) { ?>
	<table class="table table-striped">
		
			<thead>
				<tr class="bg-dark-subtle"><th scope="col">Title</th>
				<th scope="col">Name</th>
				<th scope="col">VPA</th>
				<th scope="col">Status</th>
				<th scope="col">Action</th></tr>
		</thead>
		<? $j=1; foreach($data['selectdatas'] as $ind=>$value) {  ?>
		<tr>
			<td data-label="Title"><?=$value['product_name'];?></td>
			<td data-label="Name"><?=$value['qr_fullname'];?></td>
			<td data-label="Email"><?=decode_f($value['vpa']);?></td>
			<td data-label="Status"><? if($value['softpos_status']==1){ echo "<i class='far fa-check-circle text-success' title='Active'></i>"; }else{ echo "<i class='fa-regular fa-circle-xmark text-danger' title='Not Active'></i>"; } ?></td>
			<td data-label="Action">
			<div class="btn-group dropstart"> <a data-bs-toggle="dropdown" aria-expanded="false"  title="Action"><i class="<?=$data['fwicon']['circle-down'];?> text-link"></i></a>
                <ul class="dropdown-menu dropdown-menu-icon pull-right" >
                  <li> <a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/qr-code<?=$data['ex']?>?bid=<?=$value['id']?>&action=update<? if(isset($post['gid'])&&$post['gid']&&isset($_GET['admin'])&&$_GET['admin']) echo '&id='.$post['gid'].'&admin=1';?>" title="Edit QR Code" ><i class="<?=$data['fwicon']['edit'];?> text-success"></i> Edit</a></li>
				  
           
                  <li> <a class="dropdown-item"  href="<?=$data['USER_FOLDER']?>/qr-code<?=$data['ex']?>?bid=<?=$value['id']?>&action=delete<? if(isset($post['gid'])&&$post['gid']&&isset($_GET['admin'])&&$_GET['admin']) echo '&id='.$post['gid'].'&admin=1';?>" title="Delete QR Code" onclick="return confirm('Are you Sure to Delete');"><i class="<?=$data['fwicon']['delete'];?> text-danger"></i> Delete</a> </li>
                  
                  <li> <a class="dropdown-item" href="<?=$data['USER_FOLDER']?>/qr-code<?=$data['ex']?>?qrid=<?=$value['id']?>&action=display<? if(isset($post['gid'])&&$post['gid']&&isset($_GET['admin'])&&$_GET['admin']) echo '&id='.$post['gid'].'&admin=1';?>"  title="View QR Code"><i class="<?=$data['fwicon']['eye-solid'];?>"></i> View</a></li>
                  
                </ul>
              </div>
			
			
			</td>
		</tr>
		<? } ?>
	</table>
	<? }else{ ?>
	
	 <div class="my-2 ms-2 fs-5 text-start">Generate your QR Code to receive payments </div>
                <div class="text-start my-2 ms-2" style="max-width:400px !important;"> you can create new QR Code, manage added QR Code</div>
              
                <div class="float-start remove-link-css"> 
				<form method="post"><button type="submit" name="send" value="Generate QR Code" class="btn btn-sm btn-primary my-1"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add A New <?=($data['PageName']);?></button></form>
                 </div>
				
	
	<? } ?>
	</div>
	<? }
	elseif($post['step']==2){ 
		if(isset($post['bid'])&&$post['bid']){ 
		?>
			<input type="hidden" name="bid" value="<?=$post['bid'];?>">
		<?
			$data['mem_det'] = '';
		}else{
			$clients_master_info = select_client_table($uid);
			$fullname			= $clients_master_info['fullname'];
			
			
			$company_name			= $clients_master_info['company_name'];
			$address			= $clients_master_info['registered_address'];
			$country			= $clients_master_info['country'];
			//$phone				= $clients_master_info['phone'];
			$email				= $clients_master_info['registered_email'];
			$default_currency	= $clients_master_info['default_currency'];
		}
	?>
	<script>
	function checkAcquirer(val)
	{
		document.getElementById("continue_but").disabled = false;
		if(val.length>0)
		{
			$.ajax({
				type: "POST",
				url: "../include/check-qracquirer<?=$data['ex'];?>",
				data: { storeid : val } 
			}).done(function(data){
				if(data==1)
				{
					var v1 = $('#product_name').val();
					var v2 = $('#panNumber').val();
					var v3 = $('#vpa').val();
	
					if(v1==''||v2==''||v3=='')
					{
						return false;
					}
					else
					{
						checkvpa();
						//$("#clients_detail").show(1000);
					}
				}
				else
				{
					alert(data);
					document.getElementById("continue_but").disabled = true;
				}
			});
		}
		else
		{
			$("#clients_detail").hide(1000);
		}
	}
	function checkvpa()
	{
		var valid = true;
		var v1 = $('#product_name').val();
		var v2 = $('#vpa').val();
		var v3 = $('#panNumber').val();
		var v4 = $('#storeType').val();
	
		$("#vpa").css("border", "1px solid #ced4da");
		$("#panNumber").css("border", "1px solid #ced4da");
	
		if (v2!=''&&(!(new RegExp(/^[a-zA-Z0-9._\-]*$/).test(v2)))) {
//			alert('Please enter valid VPA');
			$("#vpa").css("border", "1px solid red");
			document.getElementById("continue_but").disabled = true;
			//return false;
			valid = false;
		}
		if (v3!=''&&(!(new RegExp(/[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}/).test(v3)))) {
			//alert('Please enter valid PAN number');
			$("#panNumber").css("border", "1px solid red");

			document.getElementById("continue_but").disabled = true;
			
			//$('#panNumber').focus();
			valid = false;
		}
		
		if(v1==''||v2==''||v3==''||v4==''||valid == false)
		{
			$("#clients_detail").hide(1000);
			return false;
		}
		else
		{	
			$("#clients_detail").show(1000);
			document.getElementById("continue_but").disabled = false;
		}
	}

	</script>
	<input name="settlementAcSameAsParent" id="settlementAcSameAsParent" type="hidden" value="Y">

	<h4 class="heading glyphicons settings"><?=$post['add_titileName'];?> QR Code</h4>
	<div class="justify-content-center row p-2 my-2">
		<div class="col-md-5 card card1 m_height rounded-tringle py-3 row">
		<?php /*?>
		<div class="row bg-vlight p-1 rounded mb-2" style="max-width:600px; margin:0 auto;">
			<p align="center"><img src="<?php echo $data['Host'];?>/images/loader.gif" id="loaderIcon" style="display:none" /></p><?php */?>
		<div id="invoice-availability-status" class="col-sm-12 my-2 px-1"></div>
		<? $k=0; if($data['Store']&&$data['store_size']>0){ ?>
		<div class="col-sm-12 my-2 px-1">
			<div class="w-75 float-start">
			<select name="softpos_terNO" id="storeType" class="form-select" title="Business Name" onchange="return checkAcquirer(this.value)" <? if(isset($post['action'])&&$post['action']=='update'&&isset($post['bid'])&&$post['bid']) echo 'disabled';?> required>
				<option value="">Select Business</option>
				<? 
				foreach($data['Store'] as $key=>$value){ 
					?>
					<option data-burl="<?=$value['bussiness_url'];?>" data-dba="<?=$value['dba_brand_name'];?>" data-val="<?=$value['public_key'];?>" value="<?=$value['id'];?>"><?=$value['ter_name']?></option>
					<? 
					$k++; 
				} ?>
			</select>
			<? 
			if(isset($post['softpos_terNO'])&&$post['softpos_terNO']){ ?>
				<script>$('#storeType option[value="<?=$post['softpos_terNO']?>"]').prop('selected','selected');</script>
			<? } ?>
		</div>
		<div class="w-25 float-start ">
			<select name="currency" class="form-select " id="currency" title="Select Currency" required >
				<option value="" disabled>Currency</option>
				<option value="INR" selected>INR</option>

				<? /*foreach ($data['AVAILABLE_CURRENCY'] as $k11) { ?>
				<option value="<?=$k11?>"><?=$k11?></option>
				<? }*/ ?>
			</select>
			<? if(isset($post['currency'])){ ?>
				<script>$('#currency option[value="<?=$post['currency']?>"]').prop('selected','selected');</script>
			<? }else{ ?>
				<script>$('#currency option[value="<?=$default_currency;?>"]').prop('selected','selected');</script>
			<? } ?>
			</div>
		</div>
		<? } ?>
		
		<div class="col-sm-12 my-0 px-1">
			<input type="text" name="product_name" placeholder="Enter Your QR Code Title *" title="QR Code Title" class="form-control" id="product_name" value="<?=(isset($post['product_name'])?$post['product_name']:'')?>" autocomplete="off" onblur="checkvpa()" required />
		</div>
		<?
		if(isset($post['vpa'])&&$post['vpa'])
		{
			$post['vpa']=encrypts_decrypts_emails($post['vpa'],2);
			if(strpos($post['vpa'],'@icici') !== false)
			{
				$post['vpa'] = str_replace('.lp@icici','',$post['vpa']);
				$post['vpa'] = str_replace('@icici','',$post['vpa']);
			}
		}
		else $post['vpa']='';
		?>
		<div class="col-sm-12 my-2 px-1">
			<div class="w-75 float-start ">
			<input type="text" name="vpa" id="vpa" placeholder="Enter Your Desired VPA without @" title="Use only - Alphabets, Numbers, Dot (.), Underscore (_) and Hyphan (-)" class="form-control" value="<?=$post['vpa'];?>" autocomplete="off" pattern="^[a-zA-Z0-9._\-]*$" <? if(isset($post['action'])&&$post['action']=='update'&&isset($post['bid'])&&$post['bid']) echo 'readonly';?> onblur="checkvpa()" required data-bs-toggle="tooltip" data-bs-placement="top" />
			</div>
			<div class="w-25 float-start ">
				<select name="vpa_ext" class="form-select" id="vpa_ext" title="@icici" <? if(isset($post['action'])&&$post['action']=='update'&&isset($post['bid'])&&$post['bid']) echo 'disabled';?> required>
					<option value="" disabled>VPA</option>
					<option value=".lp@icici" selected>.lp@icici</option>
					<option value="@icici">@icici</option>
				</select>
			</div>
			<? if(isset($post['vpa_ext'])){ ?>
				<script>$('#vpa_ext option[value="<?=$post['vpa_ext']?>"]').prop('selected','selected');</script>
			<? }?>
		</div>
		<div class="col-sm-12 my-0 px-1">
			<input type="text" name="panNumber" id="panNumber" placeholder="PAN number" class=" form-control" maxlength="10" value="<?=(isset($post['panNumber'])?$post['panNumber']:'')?>" autocomplete="off" pattern="[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}" <? if(isset($post['action'])&&$post['action']=='update'&&isset($post['bid'])&&$post['bid']) echo 'readonly';?> onblur="checkvpa()" required data-bs-toggle="tooltip" title="Please enter valid PAN number. E.g. AAAAA9999A" data-bs-placement="top" />
		</div>

		<div id="clients_detail" class="px-0" <?=$data['mem_det'];?>>
		<?
		if(!(isset($post['bid'])&&$post['bid']))
		{
		?>
			<div class="col-sm-12 my-2 px-1">
				<input type="text" name="qr_fullname" placeholder="Enter Your Full Name *" title="Enter Your Full Name" class="form-control" value="<?=(isset($post['qr_fullname'])?$post['qr_fullname']:(isset($fullname)&&$fullname?$fullname:''))?>" data-bs-toggle="tooltip" data-bs-placement="top" required />
			</div>
			<div class="col-sm-12 my-2 px-1">
				<input type="email" name="qr_email" placeholder="Enter Your Email *" title="Enter Your Email" class="form-control" value="<?=(isset($post['qr_email'])?encrypts_decrypts_emails($post['qr_email'],2):(isset($email)&&$email?encrypts_decrypts_emails($email,2):''))?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="top" required />
			</div>
			<div class="col-sm-12 my-2 px-1">
				<input type="text" name="merchantAddressLine" placeholder="Enter Your Merchant Address" title="Enter Your Merchant Address" class="form-control" value="<?=(isset($post['merchantAddressLine'])?$post['merchantAddressLine']:(isset($address)&&$address?$address:''))?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="top" required />
			</div>
			<??>
			<div class="col-sm-12 my-2 px-1">
				<input type="text" name="merchantCity" placeholder="Merchant City" title="Enter Your Merchant City" class="form-control" value="<?=(isset($post['merchantCity'])?$post['merchantCity']:(isset($city)&&$city?$city:''))?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="top" required />
			</div>
			<div class="col-sm-12 my-2 px-1">
				<input type="text" name="merchantState" placeholder="Merchant State" title="Enter Your Merchant State" class="form-control" value="<?=(isset($post['merchantState'])?$post['merchantState']:(isset($state)&&$state?$state:''))?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="top" required />
			</div>
			<div class="col-sm-12 my-2 px-1">
				<input type="text" name="merchantPinCode" placeholder="PinCode" title="Enter Your PinCode" class="form-control" value="<?=(isset($post['merchantPinCode'])?$post['merchantPinCode']:(isset($zip)&&$zip?$zip:''))?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="top" required />
			</div>
			<? ?>
			<div class="col-sm-12 my-2 px-1">
				<input type="text" name="mobileNumber" placeholder="Mobile Number" title="Enter Your Mobile Number" class="form-control" value="<?=(isset($post['mobileNumber'])?$post['mobileNumber']:(isset($phone)&&$phone?$phone:''))?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="top" required />
			</div>
			<?
			}?>
			<div class="col-sm-12 my-2 px-1">
				<input type="text" name="profile_pic" placeholder="Enter Your Profile Pic Url" title="Profile Pic Url" class=" form-control" value="<?=(isset($post['profile_pic'])?$post['profile_pic']:'')?>" autocomplete="off" data-bs-toggle="tooltip" data-bs-placement="top" />
				<label class="form-text ms-2">e.g. https://www.abc.com/profile-pic.png</label>
			</div>
		</div>
		<div class="col-sm-12 p-1 remove-link-css mt-2 text-center">
		<?php 
		if(isset($post['action'])&&$post['action']=='update')
		{
			?>
			<button type="submit" name="send" value="Submit" class="btn btn-icon btn-primary me-2"><i class="far fa-check-circle"></i> Submit</button>
			<?php 
		}
		else
		{ 
			?>
			<button id="continue_but" type="submit" name="send" value="CONTINUE" class="btn btn-icon btn-primary me-2"><i class="far fa-check-circle"></i> Continue</button>
			<?
		}?>
		<a href="<?=$data['USER_FOLDER']?>/qr-code<?=$data['ex']?>?<? if(isset($post['gid'])&&$post['gid']&&isset($_GET['admin'])&&$_GET['admin']) echo 'id='.$post['gid'].'&admin=1';?>" id="remove_class" class="btn btn-icon btn-primary" ><i class="fas fa-backward"></i> Back</a> </div>
		</div>
	</div>
	<? } ?>
	</form>
	<?
	if(isset($_GET['action'])&&($_GET['action']=='preview')){
		//include_once $data['Path']."/front_ui/default/user/template.invoice_preview".$data['iex'];
	}
	elseif((isset($_GET['action'])&&$_GET['action']=='display') && (isset($_GET['qrid'])&&$_GET['qrid']!="")){ 
	$mt=0;
	?>
	<script> $("#linkid").removeAttr("href");</script>
	<style>
		/*.card { background:#fff !important;}*/
	</style>
<div class="container mb-2">
	<div class="text-info m-2 pt-2 text-end">
	<?php /*?><button class="btn btn-icon btn-primary btn-sm" type="submit" name="Qr Code" value="inv" title="Send Qr Code"><i class="fas fa-envelope"></i></button><?php */?>
	<a class="btn btn-primary btn-sm printbtn" title="Print QR Code"><i class="fa-solid fa-print"></i></a> 
	<?php /*?><a href="qr-code-pdf<?=$data['ex']?>?bid=<?=$_GET['qrid'];?><? if(isset($post['gid'])&&$post['gid']&&isset($_GET['admin'])&&$_GET['admin']) echo '&id='.$post['gid'].'&admin=1';?>" class="btn btn-primary btn-sm" title="Download QR Code" target="_blank"><i class="fas fa-file-download"></i></a><?php */?> <a class="btn btn-primary btn-sm" href="?bid=<?=$_GET['qrid'];?>&action=update<? if(isset($post['gid'])&&$post['gid']&&isset($_GET['admin'])&&$_GET['admin']) echo '&id='.$post['gid'].'&admin=1';?>" title="Edit QR Code"><i class="far fa-edit "></i></a> <a class="btn btn-primary btn-sm" href="?<? if(isset($post['gid'])&&$post['gid']&&isset($_GET['admin'])&&$_GET['admin']) echo 'id='.$post['gid'].'&admin=1';?>" title="Back"><i class="fas fa-backward"></i></a> </div>
	<div class="justify-content-center row">
		<div class="col-md-6 my-2 py-4 card card1 m_height rounded-tringle mx-1 ">
			<div class="row d-flex77 justify-content-center customizecss" id="printarea">
				<div class="col-md-8" style="max-width:350px !important;">
					<div class="card">
						<div class="d-flex bd-highlight row px-2">
							<? if(isset($post['profile_pic'])&&$post['profile_pic']){ $mt=4; ?>
							<div class="col p-2" style="max-width:75px !important;"><img src="<?=$post['profile_pic'];?>" class="rounded-circle shadow-4-strong" alt="<?=$post['qr_fullname']?>" style="height:70px !important;width:70px !important;"></div>
							<? } ?>
							<div class="col p-2 text-start fs-6 mt-<?=$mt;?>"><?=$post['qr_fullname']?></div>
							<div class="col p-2 text-end" style="max-width:80px !important;">
								<? if(($data['hdr_logo'])&&($domain_server['LOGO'])){ ?>
								<a href="javacript:void(0)" class="img-fluid"><img src="<?=encode_imgf($domain_server['LOGO']);?>" style="height:30px;"></a>
							<? } ?>
							</div>
						</div>
						<!--<hr>-->
						
						<?
						
						//echo $post['json_value'];
						$json_value= json_decode($post['json_value'],1);
						

						$merchantId		= $json_value['siteid_get']['merchantId'];
						//$merchantId	= isset($post['sub_merchantId'])&&$post['sub_merchantId']?$post['sub_merchantId']:$merchantId;
						$terminalId		= $json_value['siteid_get']['terminalId'];

						$vpa			= decode_f($post['vpa']);
						$sub_merchantId	= isset($post['sub_merchantId'])&&$post['sub_merchantId']?$post['sub_merchantId']:$merchantId;
						//$reference	= $merchantId.'_'.$post['id'];
						$curr			= $post['currency'];
						
						
						

						if(isset($post['softpos_terNO'])&&$post['softpos_terNO'])
						{
							$bank_g = select_tablef("`id` in ({$post['softpos_terNO']})",'terminal',0,1,'`select_mcc`');
							
							$website_mcc_code = @$bank_g['select_mcc'];

							if($website_mcc_code)
							{
								$mcc_code_list_arr = explode(',',$website_mcc_code);
								
								if(count($mcc_code_list_arr)>1)
								{
									$data['Error']= 'Multiple MCC code mapped';
									$validate=false;
								}
								else
								{
									$mcc_code=$mcc_code_list_arr[0];
									$validate=true;
								}
							}
							else
							{
								$mcc_code=$terminalId;
								$validate=true;
							}
							$qr_valid=0;
							if($validate)
							{
								$qr_valid=1;
								$url = "upi://pay?pa=".$vpa."&pn=".$merchantId."&tr=mno".$sub_merchantId."&cu=".$curr."&mc=".$mcc_code;
								$url = urlencode($url);
								?>
								<hr class="bg-danger border-2 border-top border-dark">
								<div class="text-center mt-2"><img src="<?=encode_imgf('../images/vim_upi.png');?>" class="img-fluid"></div>
								<div class="text-center"><img src="https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=<?=$url;?>&choe=UTF-8" class="img-fluid"></div>
								<div class="text-center"><img src="<?=encode_imgf('../images/upi-icons.png');?>" class="img-fluid"></div>
							<?
							}
							else
							{
								?>
								<div class="container my-2">
								<div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
									<?=$data['Error']?>
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
								</div>
							</div>

								<?
							}
						}?>
					</div>
				</div>
			</div>
			<? 
		
			if(@$qr_valid)
			{?>
			<div class="text-center my-2 clearfix customizecss" data-bs-toggle="collapse" href="#collapseShare" role="button" aria-expanded="false" aria-controls="collapseShare" > <a title="Click for Submit Email ID and Share QR Code">Share QR <i class="fa-solid fa-share-nodes"></i></a></div>
			<?
			}?>
			<!--==============================-->
			<div class="collapse justify-content-center" id="collapseShare" >
				<div class="bg-vlight rounded" style="max-width:350px; margin:0 auto;">
				<form method="post" name="data">
					<input type="hidden" name="qrid" value="<?=((isset($_GET['qrid']) &&$_GET['qrid'])?$_GET['qrid']:'')?>">
					<input type="hidden" name="qr_fullname" value="<?=((isset($post['qr_fullname']) &&$post['qr_fullname'])?$post['qr_fullname']:'')?>">
					<input type="hidden" name="merchant_logo_url" value="<?=((isset($domain_server['LOGO']) &&$domain_server['LOGO'])?$domain_server['LOGO']:'')?>">
					<input type="hidden" name="profile_pic" value="<?=((isset($post['profile_pic']) &&$post['profile_pic'])?$post['profile_pic']:'')?>">
					<div id="PaySend" class="px-4 row text-start show">
					<div class="float-start" style="width:calc(100% - 50px);">
					<input type="email" class="form-control form-control-sm mt-2" name="pay_email" id="pay_email" title="Payee Email" placeholder="Enter Email ID" required="" autocomplete="off">
					</div>
					<div class="float-start text-center" style="width:50px;">
						<button name="send_mail" value="send" class="btn btn-primary btn-sm text-primary my-2">Send</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<? 
		
	if(@$qr_valid)
	{?>
	<div class="col-sm-12 p-1 text-center customizecss"> <a class="btn btn-icon btn-primary my-2 Customize_btn" title="Customize Your Profile Pic">Customize</a> <a class="btn btn-icon btn-primary my-2 printbtn" title="Print QR Code">Print</a> </div>
	
	<? }?>
		<div class="Customize_frm text-center" style="display: none;">
			<div class="row justify-content-center">
				<div class="col-md-8 px-2" style="max-width:350px !important;">
					<!--========New Form===========-->
					<form method="post" name="data">
						<input type="hidden" name="qrid" value="<?=((isset($_GET['qrid']) &&$_GET['qrid'])?$_GET['qrid']:'')?>">
							<div class="col-sm-12 mb-1 text-start">
							<label for="Add_Image" class="form-label">Add Image (URL)</label>
							<input type="text" name="profile_pic" placeholder="Profile Pic Url" title="Profile Pic Url" class=" form-control" value="<?=(isset($post['profile_pic'])?$post['profile_pic']:'')?>" autocomplete="off" />
							</div>
							<div class="text-center"><a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" ><img src="https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=<?=$url;?>&choe=UTF-8" class="img-fluid"></a></div>
							<button type="submit" name="profile_update" value="create" class="btn btn-icon btn-primary me-2 w-100"></i> Create</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<? } ?>
</div>
<script>

$(".Customize_btn").click(function () {
	$(".customizecss").hide();
	$(".Customize_frm").show(500);
});

$(".printbtn").click(function () {
	var divContents = document.getElementById("printarea").innerHTML;
	var a = window.open('', '', 'height=1000, width=1000');
	a.document.write('<link rel="stylesheet" type="text/css" href="<?=$data['TEMPATH']?>/common/css/bootstrap.min.css">');
	a.document.write('<html>');
	a.document.write(divContents);
	a.document.write('</body></html>');
	a.document.close();
	a.print();
});

$('#vpa').keyup(function(){
	this.value = this.value.toLowerCase();
});
$('#panNumber').keyup(function(){
	this.value = this.value.toUpperCase();
});
</script>
<!--</div>-->
<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>
