<?
if(!isset($_SESSION)) {session_start();}
if(!isset($_SESSION['login_adm'])){
	echo "ACCESS NOT ALLOW";
	exit;
}
$folder_json='log/'; 
//$folder='log/';
$folder='';

	$file_path_htaccess_json=($folder_json."htaccess.json");
	if(file_exists($file_path_htaccess_json)){		
		$str_data = file_get_contents($file_path_htaccess_json);
		$arr = json_decode($str_data,true);
		if($arr){
			$a_size=sizeof($arr);
			if($a_size){$k=$a_size; }
			
			echo "<br/><br/>htaccess_json=><br/>";
			print_r($arr);
		}
	}
	
	$file_path_htaccess=($folder.".htaccess");
	if(file_exists($file_path_htaccess)){		
		$str_data_ht = @file($file_path_htaccess);
		echo "<br/><br/><br/>.htaccess=><br/>";
		//print_r($str_data_ht);
		
		foreach($str_data_ht  as $line ){
			echo $line."<br/>";
		}
		
	}
?> 