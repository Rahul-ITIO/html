<!DOCTYPE>
<html>
<head>
<style>
	body table th { color:#000000 !important;}
	.modal-body { padding: 5px; } 
	.modal-dialog { width:1000px !important;}
</style>
</head>
<body>

<div class="container border" id="cssfortrpop">
	<div class="row my-2">
		<h6 class="vkg-underline-red">Payout Beneficiary List</h6>
		<table class="table table-striped text-dark">
			<thead>
				<tr><th scope="col">Beneficiary Id</th>
					<th scope="col">Nickname</th>
					<th scope="col">Beneficiary Name</th>
					<th scope="col">Bank Name</th>
					<th scope="col">Account Number</th>
					<th scope="col">Bank Code</th>
					<th scope="col">Bank Code 1</th>
					<th scope="col">Bank Code 2</th></tr>
			</thead>
			<tbody>
				<? foreach($post['bene_list'] as $key=>$val){ ?> 
				<tr><td><?=$val['id'];?></td>
					<td><?=$val['beneficiary_nickname'];?></td>
					<td><?=$val['beneficiary_name'];?></td>
					<td><?=$val['bank_name'];?></td>
					<td><?=$val['account_number'];?></td>
					<td><?=$val['bank_code1'];?></td>
					<td><?=$val['bank_code2'];?></td>
					<td><?=$val['bank_code3'];?></td></tr>
				<? } ?>  
			</tbody>
		</table>
	</div> 
</div>
</body>

<script>
$(document).ready(function(){
	$('#myModal .modal-dialog').css({"max-width":"90%"});
});
</script>
</html>
<? db_disconnect();?>