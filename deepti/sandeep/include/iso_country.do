<?php
include('../config.do');
include('country_state.do');

if(!isset($_SESSION['login_adm'])){
       //header("Location:{$data['USER_FOLDER']}/login.do");
      // echo('ACCESS DENIED.'); exit;
}	

$t=$_REQUEST['t'];

$store_id_de=decryptres($t); echo "<br/>store_id_de=>".$store_id_de;
$store_id_de=decode_base64($t); echo "<br/>store_id_de=>".$store_id_de;

exit;
##############################################

function encryptres5($sData, $sKey='ztcBase64Encode'){ 
    $sResult = ''; 
    for($i=0;$i<32;$i++){ 
        echo "<br/>sChar=>".$sChar    = substr($sData, $i, 1); 
        echo "<br/>sKeyChar=>".$sKeyChar = substr($sKey, ($i % strlen($sKey)) - 1, 1); 
        echo "<br/>sChar=>".$sChar    = chr(ord($sChar) + ord($sKeyChar)); 
        echo "<br/>sResult=>".$sResult .= $sChar; 
    } 
    return encode_base64($sResult); 
}
function decryptres5($sData, $sKey='ztcBase64Encode'){ 
    $sResult = ''; 
     
    for($i=0;$i<32;$i++){ 
         echo "<br/>sChar=>".$sChar    = substr($sData, $i, 1); 
         echo "<br/>sKeyChar=>".$sKeyChar = substr($sKey, ($i % strlen($sKey)) - 1, 1); 
         echo "<br/>sChar=>".$sChar    = chr(ord($sChar) - ord($sKeyChar)); 
         echo "<br/>sResult=>".$sResult .= $sChar; 
    } 
	$sResult   = decode_base64($sResult);
    return $sResult; 
}



//echo "<br/><br/>store_id=>".$store_id='27_1207_'.date('YmdHis');
echo "<br/><br/>store_id=>".$store_id=$store_id_de;


$encryptres5=encryptres5($store_id); echo "<br/>encryptres5=>".$encryptres5;
$decryptres5=encryptres5($encryptres5); echo "<br/>decryptres5=>".$decryptres5;






exit;


$cou_list="Afghanistan,Algeria,Angola,Australia,Benin,Botswana,Brazil,Burkina faso,Burundi,Cameroon,Canada,Chad,China,Colombia,Comoros,Congo,Congo, the democratic republic of the,Cote d'ivoire,Egypt,Equatorial guinea,Ethiopia,Gabon,Gambia,Ghana,Guinea,Guinea-bissau,Iran, islamic republic of,Iraq,Japan,Kenya,Lesotho,Madagascar,Malawi,Mali,Mauritania,Mauritius,Mexico,Morocco,Mozambique,Myanmar,Namibia,New zealand,Niger,Nigeria,Palestinian territory, occupied,Papua new guinea,Rwanda,Senegal,Sierra leone,Tanzania, united republic of,Togo,Tunisia,Uganda,United kingdom,United states,Venezuela, bolivarian republic of,Yemen,Zambia,Zimbabwe,Bhutan,Bonaire, sint eustatius and saba,Cape verde,Cuba,Djibouti,Dominican republic,Eritrea,Guam,Guyana,Haiti,Jamaica,Kiribati,Lebanon,Liberia,Libyan arab jamahiriya,Niue,Sudan,Suriname,Swaziland,Syrian arab republic,Vanuatu,Western sahara,";

$cou_list=explode(',',$cou_list);
echo "Size=>".sizeof($cou_list);

$c_iso2="";
foreach($cou_list as $key=>$value){
	$c1=get_country_code($value);
	if(strlen($c1)==2){
		$c_iso2.='"'.$c1.'",';
	}
	echo "<br/>".$c1."=>".$value;
	
}

echo "<br/>c_iso2=>".$c_iso2;


?>