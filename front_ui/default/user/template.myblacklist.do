<? if(isset($data['ScriptLoaded'])){ ?>

<style>

/*::placeholder { color: var(--color-1)!important;}*/
/*class for mobile responsible*/
    @media (max-width: 768px) {
    #trans_reson_css .col-sm-1 {
    flex-shrink: 0;
    width: 8.33333333% !important;
    max-width: 8.33333333 !important;
    }    
	#trans_reson_css .col-sm-2 {
    flex-shrink: 0;
    width: 16.66666667% !important;
    max-width: 16.66666667% !important;
    }
	@media (max-width: 600px){
    #trans_reson_css .col-sm-3 {
    flex-shrink: 0;
    width: 25%;
    max-width: 25%;
    }
	#trans_reson_css .col-sm-8 {
    flex-shrink: 0;
    width: 66.66666667% !important;
    max-width: 66.66666667% !important;
    }
	#trans_reson_css .col-sm-5 {
    flex-shrink: 0;
    width: 40% !important;
    max-width: 40% !important;
    }
	#trans_reson_css .col-sm-2 {
    flex-shrink: 0;
    width: 20% !important;
    max-width: 20% !important;
    }
	
	}
	@media (max-width: 400px){
	#trans_reson_css .col-sm-3 {
    flex-shrink: 0;
    width: 100%;
    max-width: 100%;
    }
	#trans_reson_css .col-sm-8 {
    flex-shrink: 0;
    width: 80% !important;
    max-width: 80% !important;
    }
	#trans_reson_css .col-sm-1 {
    flex-shrink: 0;
    width: 20% !important;
    max-width: 20% !important;
    }
	
	}
	
	
</style>

<div class="container mt-2 mb-2 border bg-primary rounded vkg" >
<div class="my-2">

<? if(!$data['PostSent']){ ?>


<div id="zink_id" class="container border my-2 pb-2 bg-primary rounded">


<? if(isset($_SESSION['success'])&&$_SESSION['success']<>''){ ?>
<div class="row">
	<div class=row alert alert-success alert-dismissible fade show mt-2">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong>Success:</strong> <?=$_SESSION['success'];?>
	</div>
</div>
 <? 
 unset($_SESSION['success']);
 } 
 ?>
 <? if(isset($_SESSION['error'])&&$_SESSION['error']<>''){ ?>
<div class="row">
	<div class="alert alert-danger alert-dismissible fade show">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong>Error:</strong> <?=$_SESSION['error'];?>
	</div>
  </div>
 <? 
 unset($_SESSION['error']);
 } 
 ?>

<? if(isset($post['addnow'])||isset($post['add'])) { ?>
<form method="post" name="blk_form">
<input type="hidden" name="token" value='<? if(isset($_SESSION['token_email'])) echo prntext($_SESSION['token_email'],0);?>'/>
<div class="vkg clearfix_ice" >
	<div class="my-2 vkg ">
		<h4><i class="<?=$data['fwicon']['ban'];?>"></i> Add A New Black List</h4>
		<div class="row bg-primary text-white py-1 rounded was-validated">
			<div class="col-sm-4 px-2">
			
				<div class="col-sm-12 input-field select mt-4">
				<select id="blacklist_type" name="blacklist_type" class="form-select form-select-sm is-invalid" title="Select blacklist type like ip, country, city, email, phone, vpa, card no." data-bs-toggle="tooltip" data-bs-placement="top" required >
					<option value="">&nbsp;</option>
					<option value="IP">IP</option>
					<option value="Country">Country</option>
					<option value="City">City</option>
					<option value="Email">Email</option>
					<option value="Card Number">Card No.</option>
					<option value="VPA">VPA</option>
					<option value="Mobile">Phone</option>
				</select>
				<label for="blacklist_type" >Select Black List Type</label>
				</div>
			</div>
			<?
			if(isset($post['blacklist_type'])&&$post['blacklist_type'])
			{?>
			<script>
				$('#blacklist_type option[value="<?=prntext($post['blacklist_type']);?>"]').prop('selected','selected');
			</script>
			<?
			}?>
			<div class="col-sm-4 px-2">
				
				<div class="col-sm-12 input-field mt-4">
					<input type="text" id='blacklist_value' name="blacklist_value" value='<?=(isset($post['blacklist_value'])?prntext($post['blacklist_value']):'');?>' class="form-control form-control-sm is-invalid"   title="Enter value for black list" data-bs-toggle="tooltip" data-bs-placement="top" required />
				<label for="blacklist_value" >Black List Value</label>
				</div>
			</div>
	
			<div class="col-sm-4 px-2 ">
				
				<div class="col-sm-12 input-field mt-4">
					<input type="text" id="remarks" name="remarks" class="form-control form-control-sm is-invalid"   value='<?=(isset($post['remarks'])?prntext($post['remarks']):'');?>' title="Enter remark for blacklist" data-bs-toggle="tooltip" data-bs-placement="top" required />
					<label for="remarks">Black List Remark</label>
				</div>
			</div>
			
			<div class="col-sm-12 ps-2 mt-4 m_role">
			<button class="btn btn-primary btn-sm" type="submit" name="addnow" value="Add" ><i class="<?=$data['fwicon']['check-circle'];?>" aria-hidden="true"></i> Submit</button> <a href="<?=$data['USER_FOLDER']?>/myblacklist<?=$data['ex']?>" class="btn btn-primary btn-sm "><i class="<?=$data['fwicon']['back'];?>"></i> Back</a>
		</div>
		</div> 
	</div>


</div>
</form>
<? }else{ ?>

<div class="vkg clearfix-ice">
<h4 class="my-2"><i class="<?=$data['fwicon']['ban'];?>"></i> Black List</h4>
<div class="row text-white p-1 rounded my-2" id="trans_reson_css">

<div class=" col-sm-12">	
	<form method="get" name="search_form1" action="<?=$_SERVER['PHP_SELF'];?>" >

<div class="row">

			<div class="col-sm-6 px-1">
				<input type="text" name="key" class="search_textbx form-control form-control-sm w-100 my-2" placeholder="Search.."  value="<?=(isset($data['key'])?prntext($data['key']):'');?>" onclick="return false;" autocomplete="off">
			</div>
			<div class="col-sm-6 px-1">
			<div class="float-start" style="width:calc(100% - 100px);">
			
				<select name="key_name" id="searchkeyname" title="Select key name" class="filter_option form-select form-select-sm w-100 my-2" autocomplete="off">
					<option value="">Select Type</option>
					<option value="IP">IP</option>
					<option value="Country">Country</option>
					<option value="City">City</option>
					<option value="Email">Email</option>
					<option value="Card Number">Card</option>
					<option value="VPA">VPA</option>
					<option value="Mobile">Phone</option>
				</select>
		<?
		if(isset($data['key_name'])&&$data['key_name'])
		{?>
		<script> 
		$('#searchkeyname option[value="<?=prntext($data['key_name']);?>"]').prop('selected','selected'); 
		</script>
		<?
		}?>
			
			</div>
			
			<div class="float-start text-center" style="width:50px;">
			
			<button type="submit" name="simple_search" value="filter" class="simple_search btn btn-primary btn-sm my-2"><i class="<?=$data['fwicon']['search'];?>"></i></button>
			
			</div>
			
			</form>
			<div class="float-start text-end" style="width:50px;">
			<form method="post" name="blk_form">
<input type="hidden" name="token" value='<? if(isset($_SESSION['token_email'])) echo prntext($_SESSION['token_email'],0);?>'/>
			<button type="submit" name="add" value="Add New" class="btn btn-primary btn-sm my-2" title="Add New"><i class="<?=$data['fwicon']['circle-plus'];?>"></i></button>
		</form>	
			</div>
			</div>

	
		
	</div>
	
</div>


	
</div>
<div class="table-responsive-sm">

<table class="table table-hover bg-primary text-white">
 <? if(count($data['myblacklist'])!=0){ ?>
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Type</th>
      <th scope="col"><span class="text-hide-mobile">Blacklist</span> <span>Value</span></th>
      <th scope="col">Remark</th>
	  <th scope="col">&nbsp;</th>
    </tr>
  </thead>
 <? }else{ ?>
  <thead>
    <tr>
      <th scope="col">
	  
	  	<div class="my-2 ms-2 fs-5 text-start">Create an black list</div>
		
		<div class="text-start my-2 ms-2" style="max-width:450px !important;">Create your black list by ip, country, city, email, phone, vpa, card no. </div>
		
		<form method="post" name="blk_form">
<input type="hidden" name="token" value='<? if(isset($_SESSION['token_email'])) echo prntext($_SESSION['token_email'],0);?>'/>
			<button type="submit" name="add" value="Add New" class="btn btn-primary my-2 ms-2 float-start" title="Add New Black List"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> Add New Black List </button>
		</form>	
	  
	  </th>
      
    </tr>
  </thead>
 <? } ?>
	 <tbody>
	 <? $i=(($data['startPage']-1)*$data['MaxRowsByPage']);
		foreach($data['myblacklist'] as $ind=>$blk) { 
		// for display short screen
	 $data_div="<div class='row table border rounded p-2'>";
	 $data_div.="<div class='col-sm-8 fw-bold'>Black List Details</div><div class='col-sm-4 text-end px-2 fw-bold' onclick='dataclose()'>X</div>";
	 $data_div.="<div class='divider bg-dark' style='padding-bottom: 0.1rem!important;'></div>";
	 $data_div.="<div class='col-sm-4'>Type</div><div class='col-sm-8'>: ".$blk['blacklist_type']."</div>";
	 $data_div.="<div class='col-sm-4'>Value</div><div class='col-sm-8'>: ".$blk['blacklist_value']."</div>";
	 $data_div.="<div class='col-sm-4'>Remark</div><div class='col-sm-8'>: ".$blk['remarks']."</div>";
	 $data_div.="</div>";
		?>
		<tr>
		  <th scope="row"><?php /*?><div class="content"><i class="<?=$data['fwicon']['display'];?> data_display text-link" title="View details"></i><input type="hidden" id="data_div" name="data_div" value="<?=$data_div;?>"/></div><?php */?><a data-bs-toggle="modal" data-count="<?=prntext($blk['id'])?>" class="tr_open_on_modal text-decoration-none" data-bs-target="#myModal"><i class="<?=$data['fwicon']['display'];?> text-link" title="View details"></i></a></th>
		  <td><?=$blk['blacklist_type']?></td>
		  <td><?=$blk['blacklist_value']?></td>
		  <td><div title="<?=$blk['remarks'];?>" data-bs-toggle="tooltip" data-bs-placement="bottom"  class="short_display_on_mobile"><?=$blk['remarks'];?></div></td>
		  <td><a href="?choice=<?=($blk['id'])?>&deletebtn=1&token=<?=prntext($_SESSION['token_email'],0);?>" onclick="return confirm('Do you want to delete this Record?');" title="Delete Record" ><i class="<?=$data['fwicon']['delete'];?> text-danger" aria-hidden="true"></i></a></td>
		</tr>
	    <tr class="hide">
     <td colspan="8">
	<div class="next_tr_<?=prntext($blk['id']);?> hide row">
	<div class="mboxtitle hide"><?=($data['PageName']);?> Detail : <?=$value['id'];?> - <?=prntext($value['name']);?></div>
	<div class="col-sm-12 border rounded mb-2 mboxcss">
	     
			    <div class="row m-2">
				<div class="col-sm-3">Type </div>
				<div class="col-sm-9">: <?=$blk['blacklist_type'];?></div>
			    </div>

                <div class="row m-2">
				<div class="col-sm-3">Value </div>
				<div class="col-sm-9">: <?=$blk['blacklist_value'];?></div>
                </div>
		
                <div class="row m-2">
				<div class="col-sm-3">Remark</div>
				<div class="col-sm-9 ">: <?=$blk['remarks'];?></div>
				</div>
		

     </div>
    </div>
			 
    
		  </td>
        </tr>
	 
	 <? } ?>
	</tbody>
</table>


</div>
	<!-- Button Display -->
	
<style>

.chosen-container-single .chosen-single {
	background: #fff !important;
	height: 38px;
	line-height: 38px;
	border: 1px solid #dadfe3;
	box-shadow: 0 0 0px #fff inset, 0 0px 0px rgb(0 0 0 / 10%);
	font-size: 17px;
}

</style>
<?
		
			
		if(isset($_REQUEST['page']))unset($_REQUEST['page']);

		$get=http_build_query($_REQUEST);

		if(isset($data['total_record'])&&$data['total_record']) $total = $data['total_record'];
		else $total = 0;

		$url=$data['USER_FOLDER']."/myblacklist".$data['iex'];
	
		if($get) $url.='?'.$get;

		include("../include/pagination_new".$data['iex']);
		pagination_new($data['MaxRowsByPage'],$data['startPage'],$url,$total);?>
	</div>
	<!-- Button Display END-->
	<? } ?>
	<? } ?>

</div>


<script>

/*for search validation*/
$(".simple_search").click(function() {
   var staxtval=$(".search_textbx").val();
   var skeyname=$("#searchkeyname").val();
   if((staxtval=="") && (skeyname=="")){
   alert("Please Enter Black List Search Keyword / Type ");
   return false;
   }
  
});

</script>
</div>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
