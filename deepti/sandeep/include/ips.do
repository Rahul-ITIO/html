<?
include('ip2locationlite.class.php');
 
//Load the class
$ipLite = new ip2location_lite;
$ipLite->setKey('70086838bc895a777771af798f46975eb86c6a175e60412e6057ebba85b44823');
$remote_addr=$_SERVER['REMOTE_ADDR'];
if(isset($_GET['remote'])&&!empty($_GET['remote'])){
	$remote_addr=$_GET['remote'];
	//echo $remote_addr;
}
//Get errors and locations
$locations = $ipLite->getCity($remote_addr);
$errors = $ipLite->getError();
 

echo "<p>\n";
echo "<strong>$remote_addr result</strong><br />\n";
if (!empty($locations) && is_array($locations)) {
  foreach ($locations as $field => $val) {
    echo $field . ' : ' . $val . "<br />\n";
  }
}
echo "</p>\n";
 
 /*
//Show errors
echo "<p>\n";
echo "<strong>Dump of all errors</strong><br />\n";
if (!empty($errors) && is_array($errors)) {
  foreach ($errors as $error) {
    echo var_dump($error) . "<br /><br />\n";
  }
} else {
  echo "No errors" . "<br />\n";
}
echo "</p>\n";
*/