<?
if(!isset($_SESSION)) {session_start();}
	
$data['iex']='.do';
$file_path=("../log/display_json".$data['iex']);
if(file_exists($file_path)){
	include($file_path);
	
	if($display_json){
		$display_json = $display_json;
		$_SESSION['display_json'] = json_decode($display_json,1);
		if(isset($_SESSION['display_json']['transaction_display'])){
			$_SESSION['transaction_display']=('"'.implode('","',($_SESSION['display_json']['transaction_display'])).'"');
		}
	}
	
}
			


echo "<br/>display_json=>".$display_json;
echo "<br/>transaction_display=>".$_SESSION['transaction_display'];
echo "<br/>display_json_de=>";print_r($_SESSION['display_json']);


?>