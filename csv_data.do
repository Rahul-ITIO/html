<?


$filename = "ZTC_Download_".date("Ymd").".csv";

// output headers so that the file is downloaded rather than displayed
header("Pragma: public");
header('Pragma: no-cache');
header("Expires: 0"); 
header("Cache-Control: must-revalidate, post-check=0, pre-check=0");

header('Content-Type: text/csv; charset=utf-8');
header("Content-Disposition: attachment; filename=".$filename."");



 
// force download  
header("Content-Type: application/force-download");
header("Content-Type: application/octet-stream");
header("Content-Type: application/download");


// create a file pointer connected to the output stream
$output = fopen('php://output', 'w');

// output the column headings
fputcsv($output, array('unique_id', 'sequence_number', 'date_to_print', 'fullname', 'middle_initial', 'company_name', 'address', 'city', 'state', 'zipcode', 'phone_number', 'other_phone_number', 'employee_number', 'client_location', 'email_address', 'aba_number', 'bank_name', 'bank_address', 'bank_city', 'bank_state', 'bank_zipcode', 'bank_phone', 'bank_fax', 'account_number', 'check_number', 'nsf', 'payable_to', 'amount', 'memo', 'tax_id', 'date_of_birth', 'id_type', 'id_number', 'id_state', 'future_field1', 'future_field2', 'future_field3', 'future_field4', 'future_field5', 'future_field6', 'future_field7', 'future_field8', 'future_field9'));
//fputcsv($output, $dataset);

function replacesph($fileds){
	$filed = str_replace(array(",","-","."),array(" ","",""),$fileds);
	return $filed;
}
function replaces($fileds){
	$fileds = str_replace(array(",","-",".","'","’","<",">"),array(" "," ","","","","",""),$fileds);
	$fileds = preg_replace( '@^(<br\\b[^>]*/?>)+@i', '', $fileds );
	return $fileds;
}
function replaces2($fileds){
	$filed = str_replace(',',' ',$fileds);
	return $filed;
}
function replaces3($fileds){
	$filed = str_replace(',',' ',$fileds);
	return $filed;
}
function datef($date){
	if($date){
		$dates = date('m/d/Y');
		$dates = str_replace('-','/',$dates);
	}else {
		$dates = " ";
	}
	return $dates;
}
function decode_base642($sData){ 
    $sBase64 = strtr($sData, '-_', '+/'); 
    return base64_decode($sBase64); 
} 
function decryptres2($sData, $sKey='pctDusPay'){ 
    $sResult = ''; 
    $sData   = decode_base642($sData); 
    for($i=0;$i<32;$i++){ 
        $sChar    = substr($sData, $i, 1); 
        $sKeyChar = substr($sKey, ($i % strlen($sKey)) - 1, 1); 
        $sChar    = chr(ord($sChar) - ord($sKeyChar)); 
        $sResult .= $sChar; 
    } 
    return $sData; 
}

include('config_db.do');

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
       //header("Location:{$data['USER_FOLDER']}/login.do");
       echo('ACCESS DENIED.');
       exit;
}

$id = "";

if(isset($_GET['id'])&&$_GET['id']){
	$id_ex = explode(',', $_GET['id']);
	foreach($id_ex as $value){
		//$id .= " `id`='".$value."' OR ";
		$id .= " `unique_id`='".$value."' OR ";
	}
	
	$id = substr_replace($id,'', strrpos($id, 'OR'), 3);
}elseif(isset($_GET['bid'])&&$_GET['bid']){
	//$id=" `receiver`={$_GET['bid']} OR `sender`={$_GET['bid']} ";
}else {
	$id = " `id`='1' OR `id`='2' ";
}




		$rows = db_rows("SELECT * FROM `{$data['DbPrefix']}echeck` WHERE ".$id."  ",0); 

		$i=1;
		// loop over the rows, outputting them
		foreach($rows as $key=>$row){
			//fputcsv($output, $row);
			
			
			$state 			= explode('-',$row['state']);	
			$bank_state 	= explode('-',$row['bank_state']);
			$amount			= str_replace('$','',$row['tamount']);
			
			
			

			$dataset = array();
			$dataset[] .= $row['unique_id'];
			$dataset[] .= $row['unique_id'];
			$dataset[] .= datef($row['tdate']);
			$dataset[] .= replaces($row['fullname']);
//			$dataset[] .= replaces($row['lname']);
//			$dataset[] .= replaces($row['fname']);
			$dataset[] .= replaces($row['middle_initial']);
			$dataset[] .= replaces($row['company_name']);
			$dataset[] .= replaces($row['address']." ".$row['address2']);
			$dataset[] .= replaces($row['city']);
			$dataset[] .= $state[0];
			$dataset[] .= replaces($row['zip']);
			$dataset[] .= replacesph($row['phone']);
			$dataset[] .= replacesph($row['other_phone_number']);
			$dataset[] .= replaces($row['employee_number']);
			$dataset[] .= replaces($row['client_location']);
			$dataset[] .= replaces2($row['email']);
			$dataset[] .= replaces($row['routing']);
			$dataset[] .= replaces($row['bank_name']);
			$dataset[] .= replaces($row['bank_address']);
			$dataset[] .= replaces($row['bank_city']);
			$dataset[] .= $bank_state[0];
			$dataset[] .= replaces($row['bank_zipcode']);
			$dataset[] .= replacesph($row['bank_phone']);
			$dataset[] .= replaces($row['bank_fax']);
			$dataset[] .= decryptres2($row['bankaccount']); 
			$dataset[] .= replaces($row['echecknumber']);
			$dataset[] .= replaces($row['nsf']);
			$dataset[] .= "ztswallet.com";
			$dataset[] .= $amount;
			$dataset[] .= replaces3($row['memo']);
			$dataset[] .= replaces($row['tax_id']);
			$dataset[] .= datef($row['date_of_birth']); 
			$dataset[] .= " ";
			$dataset[] .= replaces($row['id_number']);
			$dataset[] .= $row['id_state'];
			$dataset[] .= " ";
			$dataset[] .= " ";
			$dataset[] .= " ";
			$dataset[] .= " ";
			$dataset[] .= " ";
			$dataset[] .= " ";
			$dataset[] .= " ";
			$dataset[] .= " ";
			$dataset[] .= " ";
			
			
			$i++;
			fputcsv($output, $dataset);
			
		}





mysql_close($con);


?>