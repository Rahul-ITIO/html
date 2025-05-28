<?
#########################################################################
$data['PageName']='scrubbed';
$data['PageFile']='scrubbed'; 
//$data['rootNoAssing']=1; 
##########################################################################
include('../config.do');
$data['PageTitle'] = 'scrubbed - '.$data['domain_name']; 



###############################################################################
if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['salt_management']))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	header("Location:{$data['Admins']}/login".$data['iex']); echo('ACCESS DENIED.'); exit;
}

#########################################################################
if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }
if(!isset($post['step'])||!$post['step']){$post['step']=1; }
#########################################################################

if(($post['action']=='insert') && isset($_GET['bid'])&&($_GET['bid'])){

	$bid = $_GET['bid'];
	$scrubbed_json_de = array();
	//$bid=$_GET['bid'];

	if ($bid) {
		$select_account_table = db_rows(
			"SELECT scrubbed_json FROM {$data['DbPrefix']}account" .
				" WHERE `id`='$bid'" .
				" ORDER BY id DESC ",
			0
		);

		$getdat = $select_account_table[0]['scrubbed_json'];
	}

	$scrubbed_json = array();
	$scrubbed_array = array();
	$scrubbed_array['scrubbed_period'] = $post['scrubbed_period'];
	$scrubbed_array['min_limit'] = $post['min_limit'];
	$scrubbed_array['max_limit'] = $post['max_limit'];
	//$scrubbed_array['transaction_count']=$post['transaction_count'];
	$scrubbed_array['tr_scrub_success_count'] = $post['tr_scrub_success_count'];
	$scrubbed_array['tr_scrub_failed_count'] = $post['tr_scrub_failed_count'];
	//$scrubbed_array['setup_fee']=$post['setup_fee'];
	//$scrubbed_array['setup_fee_status']=$post['setup_fee_status'];

	$scrubbed_json['sp_' . $post['scrubbed_period']] = $scrubbed_array;



	if ($getdat) {
		$scrubbed_json_de = json_decode($getdat, 1);
		if ($scrubbed_json_de) {
			$scrubbed_json = array_merge($scrubbed_json, $scrubbed_json_de);
		}
	}



	$scrubbed_json_en = json_encode($scrubbed_json);

	db_query(
		"UPDATE `{$data['DbPrefix']}account` SET " .
			"`scrubbed_json`='{$scrubbed_json_en}'" .
			" WHERE `id`={$bid}",
		0
	);

	$_SESSION['action_success'] = '<strong>Success!</strong> Scrubbed successfully Updated for Period : ' . $post['scrubbed_period'] . ' Day/Days and ID : ' . $bid;
?>
	<script>
		parent.location.reload();
	</script>

<?
		
}

/////////for Fetch scrubbed_json for disable dropdown scrubbed periob///////////
$bbid=$_GET['bid'];
	$select_scrubbed_json=db_rows(
		"SELECT scrubbed_json FROM {$data['DbPrefix']}account".
		" WHERE `id`={$bbid}",0
	);
	
	$js_dec=$select_scrubbed_json[0]['scrubbed_json'];

	$dcscrubbed =  json_decode($js_dec,1);
	//print_r($dcscrubbed);

	//exit;
	$keyval_1='';
	$keyval=array();
	if(is_array($dcscrubbed))
	{
		foreach($dcscrubbed as $kv => $vv){
			$keyval_1.=str_replace('sp_','',$kv).',';
		}
	}
	//$keyval=array(substr($keyval,0,-1));

	//print_r($_SESSION[keyvalsess])."=============";
	if(isset($keyval_1)&&$keyval_1) $keyval = explode(',', substr($keyval_1,0,-1));
	$_SESSION['keyvalsess']=$keyval;
			//print_r($_SESSION['keyvalsess']);
	//echo "scrubbed.do";exit;
	
display('admins');
#########################################################################
?>