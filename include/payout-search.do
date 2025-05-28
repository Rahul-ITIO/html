<??>
<style>
@media (max-width: 999px) {
	.payout_search_css .col-md-8, .col-md-4 {
		flex-shrink: 0;
		width: 100%;
		max-width: 100%;
	}

	.payout_search_css .col-md-5 {
		flex-shrink: 0;
		width: 40%;
		max-width: 40%;
	}
	.payout_search_css .col-md-2 {
		flex-shrink: 0;
		width: 20%;
		max-width: 20%;
	}
}
@media (max-width: 576px) {
	.payout_search_css .col-md-2 {padding-top: 35px;}
	.input-group .btn { height: 31px;}
	.payout_search_css .col-md-5 { width: 100% !important;max-width: 100% !important;}
	.payout_search_css .col-md-2 { padding-top: 0px;width: 100% !important;max-width: 100% !important;}
	.payout_search_css .float-start{float: right !important;}
	.payout_search_css .col-sm-8 {width: 60% !important;max-width: 60% !important;}
	.payout_search_css .col-sm-4 {width: 40% !important;max-width: 40% !important;}
}
@media (max-width: 350px) {
	.payout_search_css .col-md-5 {
		width: 100%;
		max-width: 100%;
	}
	.payout_search_css .col-md-2 {
		padding-top: 0px;
		width: 100%;
		max-width: 100%;
	}

}
</style>
<div class="row border bg-vlight rounded clearfix payout_search_css">
	<div class="col-md-8">
		<form method="get">
			<div class="row">
				<div class="col-md-5 my-1 px-1">
					<div class="form-group row">
						<label for="inputEmail3" class="col-sm-4 col-form-label">Start Date</label>
						<div class="col-sm-8"><input type="date" class="form-control form-control-sm" name="start_date" required="" value="<? if(isset($data['start_date'])&&$data['start_date']) echo $data['start_date'];?>"></div>
					</div>
				</div>
				<div class="col-md-5  my-1 px-1">
					<div class="form-group row ">
						<label for="inputEmail3" class="col-sm-4 col-form-label">End Date</label>
						<div class="col-sm-8">
							<input type="date" class="form-control form-control-sm" name="end_date" value="<? if(isset($data['end_date'])&&$data['end_date']) echo $data['end_date'];?>" required="">
						</div>
					</div>
				</div>
				<div class="col-md-2 my-1 px-1">
					<button type="submit" class="btn btn-primary btn-sm float-start">Search</button>
				</div>
			</div>
		</form>
	</div>
	<div class="col-md-4  my-1">
		 <form method="get">
			<div class="input-group form-row">
				<input type="text" class="form-control form-control-sm" placeholder="<? if(isset($_GET['value'])) echo $_GET['value']; else echo'Search...';?>" required="" name="value" autocomplete="off" value="">
				<select class="form-control form-control-sm" name="type">
					<option value="transaction_id">Transaction Id</option>
					<option value="txn_id">UTR Number</option>
					<option value="mrid">M.OrderId</option>
				</select>

				<div class="input-group-append">
					<button class="btn btn-primary btn-sm" type="submit"><i class="fas fa-search"></i></button>
				</div>
			</div>
		</form>
	</div>
</div>