<?php
include('../config1.do');
include('riskratio.do');


if(isset($_GET['uid'])){
$uid=$_GET['uid'];

$ratio=riskratio($uid);
print_r($ratio);

echo "<br/><br/>";
$riksratio=riskratio($uid,"9,10,11");
print_r($riksratio);
//echo "<br/><br/>".$riksratio['total_ratio'];


echo "<br/><br/>";
$chargeback_ratio=riskratio($uid,"12,15");
print_r($chargeback_ratio);


echo "<br/><br/><br/><br/>==11==>";
$riksratio=riskratio($uid,"11");
print_r($riksratio);


echo "<br/><br/>==12==>";
$chargeback_ratio=riskratio($uid,"12");
print_r($chargeback_ratio);


echo "<br/><br/>==15==>";
$chargeback_ratio=riskratio($uid,"12");
print_r($chargeback_ratio);

}


