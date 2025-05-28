<? if(isset($data['ScriptLoaded'])){?>
<?
if(!isset($_SESSION['summary_login_date'])|| empty($_SESSION['summary_login_date'])){ 
	$_SESSION['summary_login_date']=date("h:i A"); // for set default current time
}
?>
<style> 
/*class for boxes and mobile responsive*/
.card {border:1px solid rgba(0,0,0,.125) !important;background:none !important;}

.s_desc {
	color: rgb(107, 108, 123);
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
.m_height{ min-height: 180px;}
.m_width{max-width:350px;}

.blockquote {
    margin-bottom: 0px !important;
}


@media (max-width: 576px){
	.m_width{max-width:100% !important; }
	.m_height{ min-height: 80px !important; }
	.s_heading { font-size: 18px !important; font-weight:bold !important; }
}

.card-body { background-color: rgba(var(--bs-secondary-bg-rgb),var(--bs-bg-opacity))!important;}
    
	
	
</style>

<div id="zink_id">
<? if($post['step']==1){ ?>
	<div class="container my-2 py-2 border rounded" >
		<div class="row vkg">
			<div class="col-sm-12 ">
				<div><h4><i class="<?=$data['fwicon']['transaction'];?> fa-fw"></i> Summary</h4></div>
			</div>
		</div>

		<div class="card m_width">
			<div class="card-header bg-dark-subtle">Available Balance</div>
			<div class="card-body bg-body-secondary">
				<blockquote class="blockquote p-1">
					<?php /*?><!--<div class="float-start"><h2>Available Balance</h2></div><div class="float-end"><a href="<?=$data['USER_FOLDER']?>/trans_statement<?=$data['ex']?>" title="View Statement"><i class="fa-solid fa-square-arrow-up-right text-primary"></i></a></div>--><?php */?>
					<div class="clearfix my-2 fw-bolder fs-6 float-start"><span id="currbal"><i class="fa-solid fa-ellipsis fa-fade"></i></span></div><div class="float-end"><a href="<?=$data['USER_FOLDER']?>/statements<?=$data['ex']?>" title="View Statement"><i class="<?=$data['fwicon']['mystatement'];?> text-primary"></i></a></div>
					<h2 class="clearfix my-2"><div class="float-start fw-light">Last updated at <span id="currdate"><?=$_SESSION['summary_login_date'];?></span> </div><div class="float-end "><a class="text-primary pointer" id="ref_btn" title="Refresh"><i id="icon_blink" class="<?=$data['fwicon']['rotate'];?>"></i></a></div></h2>
				</blockquote>
			</div>
		</div>

		<div class="Container my-2">
			<div class="s_heading ps-1">How does Payout Gateway work?</div>
			<div class="row mx-0 summary">
				<div class="col-sm-4 mb-2 px-0">
					<div class="card card1 m_height rounded-tringle pull-up mx-1 bg-dark-subtle">
						<div class="card-body">
							<div class="text-card">
								<div class="title">Upload File with Beneficiary Details</div>
								<div class="s_desc">Upload a batch file with the beneficiaries account details, amount, and contact details to initiate the payment. Beneficiaries details are validated.</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-4 mb-2 px-0">
					<div class="card card1 m_height rounded-tringle pull-up mx-1 bg-white text-dark">
						<div class="card-body">
							<div class="text-card">
								<div class="title">Amount Deducted from your Payout Gateway Account </div>
								<div class="s_desc">Amount specified in the uploaded file gets deducted from your Payout Gateway.</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-4 mb-2 px-0">
					<div class="card card1 m_height rounded-tringle pull-up mx-1 bg-white text-dark">
						<div class="card-body">
							<div class="text-card">
								<div class="title">Beneficiary Account gets Credited</div>
								<div class="s_desc">Amount specified in the batch file gets credited to beneficiaries.</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<? } ?>
</div>
<input type="hidden" id="memidx" value="<?=$post['id'];?>">
<script>
// Function call for Merchant Payout Balance 
$(document).ready(function(){
	var memidx = $("#memidx").val();
	$.ajax({
		type: "POST",
		url: "../include/payout-balance-request<?=$data['ex'];?>",
		data: { memid : memidx } 
	}).done(function(data){
		//alert(data);
		$("#currbal").html(data);
		$("#currdate").html('<?=date('h:i A');?>');
	});
});

// Function call for Login time and after refresh display current time with blink refresh button
$('#ref_btn').click(function() {
	$('#icon_blink').fadeOut(500);
	$('#icon_blink').fadeIn(500);
	var memidx = $("#memidx").val();

	$.ajax({
		type: "POST",
		url: "../include/payout-balance-request<?=$data['ex'];?>",
		data: { memid : memidx } 
	}).done(function(data){
		//alert(data);
		$("#currbal").html(data);
	});

	$.ajax({
		type: "POST",
		url: "../include/update_date<?=$data['ex'];?>",
	}).done(function(data){
		//alert(data);
		$("#currdate").html(data);
	});
});

</script>
<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>