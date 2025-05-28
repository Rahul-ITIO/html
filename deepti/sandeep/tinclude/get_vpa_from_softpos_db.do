<?
// 		/tinclude/get_vpa_from_softpos_db.do


include('../config.do');

if(!isset($_SESSION['adm_login'])){
	//header("Location:{$data['Members']}/login.do");
	echo('ACCESS DENIED.');
	exit;
}


$upd_qr_4="UPDATE `zt_softpos_setting` AS `s`   SET `s`.`softpos_pn`='Rario Digital Private Limited' , `s`.`qr_fullname`='Rario Digital Private Limited' WHERE `s`.`id`='39' ";
	db_query($upd_qr_4,1);
	echo "<br/><br/>upd_qr_4=>".$upd_qr_4;
	
exit;

	$limit=' LIMIT 1 ';
	//$limit='  ';
	
	$key_query='';

	$slct=db_rows(
		"SELECT * ".
		" FROM `{$data['DbPrefix']}softpos_setting`".
			" ".$key_query.
			" ".$limit.
		" ",1
	);
		

	
	$clientid_start=($slct[0]['id']);
	
	echo "<hr/>count=>".count($slct)."<br/><br/>";
	echo '<hr/>Acquirer Key=> {"apiKey":"w7p24MDT0RjvGdwooQhj6BFArTAuKB78","merchantId":"1013121","terminalId":"5411","merchantAliasName":"Skywalk technologies private limited","merchantAddressLine":"1101-1102 spaze Itech park sector 48","merchantCity":"Gurugram","merchantState":"Haryana","merchantPinCode":"122018","mobileNumber":"8130582345","panNumber":"ABHCS0126Q","emailID":"info@letspe.com","settlementAcSameAsParent":"N","payerAccount":"256202138025","payerIFSC":"INDB0001567","dmo_url":"https://apibankingone.icicibank.com/api/v1/dmo/OnboardRegisterMerchant"}';
	
//exit;

	

		$i=0;
		foreach($slct as $key=>$value){
			$i++;
			
				if($value['vpa']&&$value['json_value'])
				{
					$sub_merchantId	= $value['sub_merchantId'];		//sub merchant id
					$vpa			= decode_f($value['vpa']);		//registered vpa after decode
					$json_value		= json_decode($value['json_value'],1);
					
					echo "<hr/>clientid=>".$value['clientid']." | softpos_terNO=>".$value['softpos_terNO']." | vpa=>".$vpa." | sub_merchantId=>".$sub_merchantId;
					
					
					if(isset($json_value['siteid_get'])&&is_array($json_value['siteid_get']))
					{
						echo "<br/><br/>siteid_get=>";
						print_r($json_value['siteid_get']);
					}
					
					
				
					
					$upd_qr="UPDATE `{$data['DbPrefix']}softpos_setting` SET `softpos_pa`='{$vpa}' , `softpos_pn`='{$value['qr_fullname']}' WHERE `id`='{$value['id']}' ";
					
					echo "<br/><br/>upd_qr=>".$upd_qr;
					
					
					db_query($upd_qr,1);
					
					
					/*
					$apc_get=array_merge($apc_get,$json_value['siteid_get']);		//json key values
					
					if(isset($vpa)&&trim($vpa))
					$apc_get['vpa']=$vpa;
				
					if(isset($json_value['dmo_request']['merchantAliasName'])&&trim($json_value['dmo_request']['merchantAliasName']))
					$apc_get['merchantAliasName']=$json_value['dmo_request']['merchantAliasName']; //sub merchant name
				
					*/
					
				}
			
		}
	
	
	$upd_qr_2="UPDATE `zt_terminal` AS `t`, `zt_softpos_setting` AS `s`   SET `s`.`softpos_public_key`=`t`.`public_key` WHERE `s`.`softpos_terNO`=`t`.`id`";
	db_query($upd_qr_2,1);
	echo "<br/><br/>upd_qr_2=>".$upd_qr_2;
	
	
	$upd_qr_3="UPDATE `zt_softpos_setting` AS `s`   SET `s`.`acquirer`='69' ";
	db_query($upd_qr_3,1);
	echo "<br/><br/>upd_qr_3=>".$upd_qr_3;
	
	//
	$upd_qr_4="UPDATE `zt_softpos_setting` AS `s`   SET `s`.`softpos_pn`='Rario Digital Private Limited' , `s`.`qr_fullname`='Rario Digital Private Limited' WHERE `s`.`id`='39' ";
	db_query($upd_qr_4,1);
	echo "<br/><br/>upd_qr_4=>".$upd_qr_4;
	
	//UPDATE `zt_terminal` AS `t`, `zt_softpos_setting` AS `s`   SET `s`.`softpos_public_key`=`t`.`public_key` WHERE `s`.`softpos_terNO`=`t`.`id`; 	
	
	exit;
	
	
?>