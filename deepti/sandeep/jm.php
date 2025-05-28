<?php
$req='';
if(isset($_REQUEST)){
	$req=http_build_query($_REQUEST);
	$req=" | REQUEST : ".$req;
}
echo "Dev Tech: Jmeter Status Done.".$req;
?>