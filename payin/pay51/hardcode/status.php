<?php

$str=file_get_contents("php://input");

// Decode the JSON response to an array
$ecn_array = json_decode($str,1);

echo $ecn_array['data']['status'];
//echo '<pre>';print_r($ecn_array);echo '<pre>';
?>