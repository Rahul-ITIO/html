<?php 
include('../config.do');

if((!isset($_SESSION['login']))&&(!isset($_SESSION['adm_login']))){
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if (isset($_REQUEST['txt'])){$txt=$_REQUEST['txt'];}
if (isset($_REQUEST['action'])){$action=$_REQUEST['action'];}
if (isset($_REQUEST['mid'])){$mid=$_REQUEST['mid'];}
if (isset($_REQUEST['type'])){$type=$_REQUEST['type'];}
if (isset($_REQUEST['img'])){$img=$_REQUEST['img'];}
if (isset($_REQUEST['gid'])){$gid=$_REQUEST['gid'];}


// Reset the authentication code into the DB for clients
if ((!empty($action))&& ($action=='reset')){$ajax=true;codereset($mid,'clientid_table',$ajax);exit;}
if ((!empty($action))&& ($action=='resets')){$ajax=true;codereset($mid,'subadmin',$ajax);exit;}
if ((!empty($action))&& ($action=='storeid')){$ajax=true;getstoreid($mid,$ajax);exit;}
if ((!empty($type))&& ($type=='userimage')){$ajax=true;getuserimage($img,$ajax);exit;}
if ((!empty($type))&& ($type=='decriptimg')){$ajax=true;decriptimg($img,$ajax);exit;}
if ((!empty($type))&& ($type=='bankdoc')){$ajax=true;bankdoc_img($gid,$ajax);exit;}

// Other functionality -  **Bank code verification**
$myvalue=$bank=$city=$branch=$address=$postcode=$country=$countrycode=$valid=$error=$message='';
/*if (!file_exists("https://api.bank.codes/swift/xml/9f8995ee79d5749097d0f482aae02a8e/".$txt."/")){	
	echo "Unable to retrive the information.<br>Problem with Internet Connection.";
	exit;
	}*/
//check date to use correct API URL
$dt=date("d-m-Y",$t);
/*
if ($dt<'10-01-2019'){
	// Call API
	$data = file_get_contents("https://api.bank.codes/swift/xml/9f8995ee79d5749097d0f482aae02a8e/".$txt."/");
}
else {
	// Call API
	$data = file_get_contents("https://bankcodesapi.com/swift/json/9fc53b3db09ca830488d19546a4fc2a1/".$txt."/");
	}
*/
if(isset($txt)&&$txt){
	$txt=trim($txt);
	$adt=[];
	$qb=0; if(isset($_GET['qp'])){$qb=1;}
	$adt=select_api_data_table('banks',$txt);
	if($adt&&$adt['j']){
		if($qb){
			echo "<br/><br/>address=>".$adt['j']['address']."<br/><br/>";
		}
	}else{
		
		$data_url9_url="https://bankcodesapi.com/swift/json/711c36208845247e709fa0832e209e4d/".$txt."/";
		$data_url9 = file_get_contents($data_url9_url); 
		
		$data_url9_decode=json_decode($data_url9,true);
	
		if($qb){
			echo "<br/><br/>error=>".$data_url9_decode['error'];
			echo "<br/><br/>valid=>".$data_url9_decode['valid'];
			echo "<br/><br/>address get=>".$data_url9_decode['address'];
			
			echo "<br/><br/><br/>data_url9_decode=>";print_r($data_url9_decode);echo "<br/><br/>";
			echo "<br/>data_url9_url=>".$data_url9_url; echo "<br/><br/>data_url9=>".$data_url9; 
		}
		
		if($data_url9_decode&&$data_url9_decode['valid']&&!isset($data_url9_decode['error'])){
			$adt=insert_api_data_table('banks',$txt,$data_url9_decode);
		}else{
			$adt['j']['valid']='false';
			$adt['j']['error']='';
			$adt['j']['message']='We are unable to verify this SWIFT number via our Bank Directory. Click Okay and proceed if your SWIFT details is correct';
		}
	} 
	//echo "<br/><br/>addressf=>".$adt['j']['address']."<br/><br/>";
	header("Content-Type: application/json", true); echo $arrayEncoded2 = json_encode($adt['j'],true);
	//print_r($adt['j']); 
	exit;
}
// function to process received data
function XML2Array(SimpleXMLElement $parent){
    $array = array();
    foreach ($parent as $name => $element) {
        ($node = & $array[$name])
            && (1 === count($node) ? $node = array($node) : 1)
            && $node = & $node[];
        $node = $element->count() ? XML2Array($element) : trim($element);
    }
    return $array;
}// End function

?>