<? if(isset($data['ScriptLoaded'])){ ?>

<div id="zink_id" class="bg-white">

	<? include $data['Path']."/include/message".$data['iex'];?>

	<? if($post['step']==1){ ?>
	
	<div class="container my-2 py-2 border rounded bg-white" >
		<div class="row vkg">
			<div class="col-sm-12 ">
				<h4 class="float-start"><i class="fas fa-plus-square"></i> Payout Detail</h4>
			</div>
		</div>
		<form method="post" name="data">
			<input type="hidden" name="step" value="<?=$post['step']?>">
			<input type="hidden" name="uid" value="<?=(isset($post['uid'])&&$post['uid']?$post['uid']:'');?>">
			<div class="mb-3 row">
				<div class="col-sm-2 p-1">
					<label for="Transaction Id" class="form-label">Transaction Id* :</label>
					<input class="form-control" name="transaction_id" type="text" title="Transaction Id" value="" placeholder="Transaction Id" autocomplete="off" required/>
				</div>
				<div class="col-sm-3 p-1">
					<label for="Order Number" class="form-label">Order Number* :</label>
					<input class="form-control" name="order_number" type="text" value="" placeholder="Order Number" title="Order Number" required>
				</div>
				<div class="col-sm-2 p-1">
					<label for="Remarks" class="form-label">Secret Word*:</label>
					<input type="password" class="form-control" name="secret_word" title="Secret Word" placeholder="Secret Word" autocomplete="off" required>
				</div>
				<div class="row">
					<button class="btn btn-primary my-2 w-25" type="submit" name="send" value="submit_data"><i class="far fa-check-circle"></i> Submit</button>
				</div>
			</div>
		</form>
	</div>
<? } ?>
</div>
<? }else{ ?>
	SECURITY ALERT: Access Denied
<? } ?>