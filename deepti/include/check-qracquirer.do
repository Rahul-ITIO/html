<?
include('../config.do');

if($_REQUEST["storeid"]){	
	$storeid = $_REQUEST["storeid"];

	$midCardList= select_tablef("`id`='{$storeid}'",'terminal',0,1,'acquirerIDs');
	$midCard	= $midCardList['acquirerIDs'];

	if(empty($midCard)) 
	{
		echo "No acquirer exists";
	}
	else
	{
		$midCard = ltrim($midCard,',');		//to remove trailing comma if exists
		$midCard = rtrim($midCard,',');		//to remove initiall comma if exists
		$midCard = trim($midCard);			//to remove blankspaces from left and right if exists
		
		$bank_g = select_tablef("`acquirer_id` IN ({$midCard}) AND `channel_type`='10'",'acquirer_table',0,1,'`id`');

		if(isset($bank_g)&&$bank_g)
		{
			echo true;
		}
		else echo "QR code not active";
	}
}
?>