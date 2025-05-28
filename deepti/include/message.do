<?
if(isset($data['Error'])&&$data['Error'])
{?>
	<div class="container my-2">
		<div class="alert alert-danger alert-dismissible text-break fade show" role="alert"> <strong>Error!</strong>
			<?=nl2br(prntext($data['Error']))?>
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</div>
<? 
}

if(isset($_SESSION['action_success'])&&$_SESSION['action_success'])
{?>
    <div class="container my-2">
	<div class="alert alert-success alert-dismissible text-break fade show" role="alert"><strong>Success!</strong> 
		<?=prntext($_SESSION['action_success']);?>
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</div>
	</div>
	<? 
	unset($_SESSION['action_success']);
}

if(isset($_SESSION['Error'])&&$_SESSION['Error']){ 
?>
	<div class="container my-2">
		<div class="alert alert-danger alert-dismissible text-break fade show" role="alert"> <strong>Error!</strong>
			<?=nl2br(prntext($_SESSION['Error']))?>
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</div>
	<? 
	unset($_SESSION['Error']);
}?>