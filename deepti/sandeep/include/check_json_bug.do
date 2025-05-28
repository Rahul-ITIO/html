<?



include('../config.do');

if(!isset($_SESSION['adm_login'])){
       //header("Location:{$data['USER_FOLDER']}/login.do");
       echo('ACCESS DENIED.');
       exit;
}

// manual check json bug 

$slct=db_rows(
	"SELECT `id`, `receiver`, `sender`, `type`, `json_value`, `transaction_id`, `payable_amt_of_txn`,`available_balance`,`tdate`,`status` ".
	" FROM `{$data['DbPrefix']}transactions`".
	" WHERE ".
		" (receiver IN (11195) OR sender IN (11195)) ".
		" AND JSON_VALID(json_value) = 0 ". 
		//" AND JSON_VALID(json_value) = 0 ". 
		//" AND `id` IN (446588,447102,447189,447193) ". // cmn
		//" AND `type`=24 ". // cmn
		//" ORDER BY `id` DESC ".  // cmn
		//" LIMIT 1".  // cmn
	" ",1
);

echo "<hr/>size=>".sizeof($slct)."<br/><br/>";



	$i=0;
	foreach($slct as $key=>$value){
		$i++;
		
		
		echo $i.". transaction_id=>".$value['transaction_id'].", receiver=>".$value['receiver'].", sender=>".$value['sender'].", type=>".$value['type'].", id=>".$value['id']."<br/>";
		
		echo "<br/>json_value=> ".$value['json_value'];
		
		$json_value=str_replace(array('[lastName]','\n'),array('[lastName]"',''),$value['json_value']);
		
		$json_value = preg_replace('#(<html[^>]*>).*?(</html>)#', '$1$2', $json_value);

		if((strpos($json_value,"Apache Tomcat/7.0.26")!==false)||(strpos($json_value,"jsTranType")!==false)){
			$json_value='{}';
		}else{
			$json_value=replacepost(prntext($json_value));
		}
		
		echo "<br/>json_value_rep=> ".$json_value."<br/><br/>";
		
		
		//`json_value`',
		
		db_query("UPDATE `{$data['DbPrefix']}transactions`"." SET ".
			" `json_value`='{$json_value}' ".
			" WHERE `id`={$value['id']} ",1);
		echo "<hr/>";
		
				
	}




exit;


?>