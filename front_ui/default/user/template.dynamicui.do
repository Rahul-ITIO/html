<? 
//echo $_SESSION['dynamic_uicode'][$account_number]['bank_json'];
//print_r($post['AccountInfoByMerchant']);

//if(isset($_SESSION['dynamic_uicode'])){print_r($_SESSION['dynamic_uicode']);exit;}

foreach($post['AccountInfoByMerchant'] as $akey=> $aval)
{
	$account_number = $aval;
	if(isset($_SESSION['dynamic_uicode'][$account_number])&&$_SESSION['dynamic_uicode'][$account_number])
	{
		$bj[$account_number] = jsondecode($_SESSION['dynamic_uicode'][$account_number]['bank_json'],1);
	}
}

//print_r($bj);//exit;

//print_r($bj['631']['dyn_netbank']);exit;

//print_r($_SESSION['dynamic_uicode']);exit;

$dyn_netbank	= $dyn_ewallet = $dyn_upi = array();
$bank_account	= $upi_account = $ewallet_account = "";

if(isset($bj)) {
	foreach($bj as $d_key => $d_val)
	{
		if(isset($d_val['dyn_netbank'])&&$d_val['dyn_netbank']){
			$dyn_netbank	= $d_val['dyn_netbank'];
			$bank_account	= $d_key;
		}
		elseif(isset($d_val['dyn_ewallet'])&&$d_val['dyn_ewallet']){
			$dyn_ewallet	= $d_val['dyn_ewallet'];
			$upi_account	= $d_key;
		}
		elseif(isset($d_val['dyn_upi'])&&$d_val['dyn_upi']){
			$dyn_upi		= $d_val['dyn_upi'];
			$ewallet_account= $d_key;
		}
	}
}

if(count($dyn_netbank)>0)
{
	if(isset($post['t_name6'])&&strpos($post['t_name6'],'dynamic')!==false)
	{
	?>
	<div class="dynamic_div ewalist hide">
		<select class="w94 dropDwn hide required" name="bank_code_<?=$bank_account;?>" id="bank_code_<?=$bank_account;?>" style="margin:5px 0;">
			<option value="" disabled="">Choose Bank</option>
			<?
			foreach($dyn_netbank as $nb_key => $nb_val)
			{
				$b_code	= $nb_val['code'];
				$b_label= $nb_val['label'];

				$selected="";
				if(isset($post['nb_code'])&&strtoupper($post['nb_code'])==strtoupper($nb_key)) 
					$selected=" Selected";
				?>
				<option value="<?=$b_code;?>"<?=$selected;?>><?=$b_label;?></option>
				<?
			}
			?>
		</select>
	</div>
	<? 
	}
}
elseif(count($dyn_upi)>0)
{
	if(isset($post['nick_name_ewallets'])&&!empty($post['nick_name_ewallets']))
	{
		if(isset($post['t_name6'])&&strpos($post['t_name6'],'dynamic')!==false) echo 'dddddd';
	}
}
?>