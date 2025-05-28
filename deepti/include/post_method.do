<?
########################## CREATE NEW PAGE FOR SHOW ALL AVAILABLE METHODS ############################
include('../config.do');

if(!isset($_SESSION['adm_login'])){
	echo('ACCESS DENIED.'); 
	exit;
}

if(isset($_REQUEST['qp'])&&trim($_REQUEST['qp'])){
	$qp=$_REQUEST['qp'];
}
if(isset($_REQUEST['pq'])&&trim($_REQUEST['pq'])){
	$qp=$_REQUEST['pq'];
}
//print_r($_REQUEST);


$order_amt = getNumericValue($_REQUEST['order_amt']);	//fetch order amount

// Dev tech : 23-07-10 encode_processing_creds fetch from bank_payout_table 
if(isset($_REQUEST['payout_id'])&&trim($_REQUEST['payout_id'])&&$_REQUEST['payout_id']>0){
	$json_epc=payout_idf($_REQUEST['payout_id']);
	$epc=$json_epc[$_REQUEST['payout_id']];
}

if($epc['payout_status']==0){
	echo "Bank Payout is Inactive";exit;
}

if(isset($qp)&&$qp){
	//print_r($epc);
	echo "<br/><br/>order_amt=>";print_r($order_amt);

	echo "<br/><br/>payment_method_limit_setup=>";print_r($epc['json']['payment_method_limit_setup']);echo "<br/><br/>";
}



if(isset($epc['json']['payment_method_limit_setup'])&&is_array($epc['json']['payment_method_limit_setup'])){
	
	foreach($epc['json']['payment_method_limit_setup'] as $key=>$val){
		$val_ex=explode("-",$val);
		//echo "<br/>kkkeeee=>"; print_r($key);
	
		if($order_amt>=(double)$val_ex[0] && $order_amt<=(double)$val_ex[1]) {
			$pay_option=true;
		} 
		else{ 
			if(isset($key['IMPS'])&&$order_amt>(double)$val_ex[0] && $order_amt<=(double)$val_ex[1])
				$pay_option=true;
			else $pay_option=false;
		}
		
		if($pay_option)
		{
			//display a list of pay_option methods
		?>
			<a data-transid="<?=$_REQUEST['transID'];?>" data-payout_id="<?=$_REQUEST['payout_id'];?>" onclick="post_Withdrawf(this, '<?=$key;?>');" class="status_id dropdown-item <?=$key;?>_<?=$val;?>" title="<?=$_REQUEST['checkout_level_name'];?> Post" style="cursor:pointer;"><i class="fas fa-retweet"></i> <?=$_REQUEST['checkout_level_name'];?> <?=$key?></a><br />
	<?
		}
		
	}
	
	
}
?>
<script>
/////////////// post_Withdrawf - start (Function for send request as per merId - clientID

function post_Withdrawf(e,theValue='') {
	//alert("post_method.do post_Withdrawf : theValue=>"+theValue);
	
	var transID=$(e).attr('data-transid');
	var payout_id=$(e).attr('data-payout_id');
	var dataaction=$(e).attr('data-action');
	
	var actionurl = "by_admin";
	if(dataaction !== undefined){
		actionurl = dataaction;
	}

	var subqry="?transID="+transID+"&admin=1&actionurl="+actionurl+"&payout_id="+payout_id;

	var urls="";

	//subqry="?actionurl="+actionurl+"&payout_id="+payout_id+"&admin=1";

	if(theValue.length>0) subqry=subqry+'&method='+theValue;

	urls="<?=$data['Host'];?>/nodal/n"+payout_id+"/payment_"+payout_id+"<?=$data['ex']?>"+subqry;

//alert(urls);return false;

	if(wn==1){
		window.open(urls, '_blank');popupclose();exit;
	}
	
	$.ajax({url: urls, success: function(result){
		$('#myModal .modal-body').html(result);
		$('#myModal .modal-body').addClass("text-break");
		$('#myModal .modal-dialog').css({"max-width":"90%"});
		$('#myModal .modal-title').html("");
		$('#myModal').modal('show');
	}});
}</script>