<? if(isset($data['ScriptLoaded'])){?>
<style> 
/*class for boxes and mobile responsive*/
.card {border:1px solid rgba(0,0,0,.125) !important;}
.s_desc {
	font-size: 14px;
	line-height: 20px;
	font-weight: 500;
	font-family: proxima-nova;
}
.summary .title {
	position: relative;
	padding-bottom: 18px;
	font-size: 20px;
	line-height: 24px;
	font-weight: 600;
	margin-bottom: 22px;
}
.summary .title::after {
	/* background-color: rgb(105, 48, 202);*/
	background:var(--background-1)!important;
	left: 0px;
	bottom: 0px;
	content: "";
	display: block;
	height: 2px;
	position: absolute;
	width: 49px;
}
.s_heading {
	line-height: 28px;
	margin-top: 2rem;
	margin-bottom: 2rem;
	font-size: 1.5rem;
}

.text-card{margin-top:10px;}
.text-card h3{padding-top:5px;}

@media (max-width: 576px){
	.m_width{max-width:100% !important; }
	.m_height{ min-height: 80px !important; }
	.s_heading { font-size: 18px !important; font-weight:bold !important; }
}

/* for top Box */
.infographic-box.colored {
    color: #fff;
    border: 0 !important;
}
.infographic-box {
    padding: 20px;
}
.emerald-bg {
    color: var(--color-1) !important;
    background: var(--background-1) !important;
}
.main-box {
    background: #FFFFFF;
    box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.1);
    margin-bottom: 16px;
    /* overflow: hidden; */
    border-radius: 3px;
}
.infographic-box.colored i {
    font-size: 4.6em;
    margin-left: 7px;
    color: #fff;
}
.vicon i {
    font-size: 14px !important;
    margin-left: unset !important;
    color: #fff;
	margin-right: unset !important;
    width: unset !important;
    height: unset !important;
    line-height: unset !important;
}

.infographic-box i {
    font-size: 2.4em;
    display: block;
    float: left;
    margin-right: 15px;
    width: 60px;
    height: 60px;
    line-height: 60px;
    text-align: center;
    border-radius: 50%;
    color: #fff;
}
.infographic-box.colored .headline {
    font-size: 1em;
    font-weight: 600;
    margin-bottom: 4px;
}
.infographic-box .headline {
    display: block;
    font-size: 1.2em;
    font-weight: 300;
    text-align: right;
}
*, ::after, ::before {
    box-sizing: border-box;
}
.infographic-box.colored {
    color: #fff;
    border: 0 !important;
}
.infographic-box.colored .headline {
    font-size: 1em;
    font-weight: 600;
    margin-bottom: 4px;
}
.infographic-box .headline {
    display: block;
    font-size: 1.2em;
    font-weight: 300;
    text-align: right;
}
*, ::after, ::before {
    box-sizing: border-box;
}
.infographic-box.colored {
    color: #fff;
    border: 0 !important;
}

.infographic-box .value {
    font-size: 2.1em;
    font-weight: 600;
    margin-top: -5px;
    display: block;
    text-align: right;
}
.btn.h-clr.show{background-color: unset !important;}
</style>
<? 
$default_currency=prntext(get_currency($post['default_currency']));
$default_full_currency=prntext($post['default_currency']);
?>

<div id="zink_id">

	<div class="container my-2 py-2 border rounded" >
		<div class="row vkg">
			<div class="col-sm-12 ">
				<div><h4><i class="<?=$data['fwicon']['home'];?>"></i> Dashboard QR Code</h4></div>
			</div>
		</div>
		


<!--======================================-->

<div class="row my-2">
<div class="col-sm-4">
<a href="<?=$data['USER_FOLDER']?>/qr-transactions<?=$data['ex']?>" title="View all transactions">
<div class="main-box infographic-box colored bg-primary-subtle text-white">
<i class="<?=$data['fwicon']['transaction'];?>"></i>
<span class="headline">Total Transactions</span>
<span class="value"><?=$data['total_record'];?></span>
</div>
</a>
</div>
<div class="col-sm-4">
<a href="<?=$data['USER_FOLDER']?>/qr-transactions<?=$data['ex']?>" title="View success transactions">
<div class="main-box infographic-box colored bg-success-subtle text-white">
<i class="<?=$data['fwicon']['fa-solid fa-check-to-slot'];?>"></i>
<span class="headline">Success Transactions</span>
<span class="value"><?=$data['total_success'];?></span>
</div>
</a>
</div>
<div class="col-sm-4">
<div class="main-box infographic-box colored bg-danger-subtle text-white">
<i class="<?=$data['fwicon']['website'];?>"></i>
<span class="headline">Business</span>
<div class="dropdown text-end"> <a data-bs-toggle="dropdown" class="btn btn-primary btn-sm dropdown-toggle bg-danger-subtle h-clr float-end" title="<?=prntext($post['company_name']);?>" >
<h3 class="badge p-1 text-muted">
                <? if($post['company_name']){  echo prntext(substr($post['company_name'],0,15)); }else{ echo "&nbsp;&nbsp;";};?>
              </h3>
</a> <div class="dropdown-menu" id="webmenu" aria-labelledby="dropdownMenuButton" style="width:100%;max-width: 200px;">
                <? if($post['products1']){
					foreach($post['products1'] as $key=>$value){?>
						<a class="dropdown-item text-link vicon" href="<?=$data['USER_FOLDER'];?>/qr-dashboard<?=$data['ex'];?>?wid=<?=$value['id'];?>"> <i class="fa-solid fa-hand-point-right text-white"></i> &nbsp;
						<?=$value['name'];?>
						</a>
						<? }
					} ?>
              </div>
</div>
<div class="clearfix"></div>

</div>
</div>



<!--======================================-->
		<div class="container">
			<div class="s_heading">How does QR Code Gateway work?</div>
			<div class="row summary px-2">
				<div class="col-sm-4 mb-2 px-0">
					<div class="card m_height rounded-tringle pull-up mx-1 ">
						<div class="card-body">
							<div class="text-card">
								<div class="title">Benefits of using QR codes</div>
								<div class="s_desc">QR code comes with several benefits that help you to reach out to all your potential customers. Let's have a look at a few of them.<br />
<span class="text-primary"> <i class="<?=$data['fwicon']['fa-solid fa-arrow-right'];?>"></i> Instant payments</span> <span class="text-primary"> <i class="<?=$data['fwicon']['fa-solid fa-arrow-right'];?>"></i> Top-grade security</span> <span class="text-primary"> <i class="<?=$data['fwicon']['fa-solid fa-arrow-right'];?>"></i> Easy to set up</span> </div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-4 mb-2 px-0">
					<div class="card m_height rounded-tringle pull-up mx-1 ">
						<div class="card-body">
							<div class="text-card">
								<div class="title">What's UPI QR code payments</div>
								<div class="s_desc">The UPI QR code is a digital payment acceptance channel accessible at the establishment of business to facilitate customers paying with their UPI-connected mobile app by scanning a QR code.</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-4 mb-2 px-0">
					<div class="card m_height rounded-tringle pull-up mx-1 ">
						<div class="card-body">
							<div class="text-card">
								<div class="title">How to create a UPI QR Code?</div>
								<div class="s_desc">Enter the basic information like website, currency, title, name, email and profile pic and generate QR Code. Save and Print / Download QR Code for transaction use. </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>




<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>