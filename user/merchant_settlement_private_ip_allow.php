<?php
$instancePrivateIP = gethostbyname(gethostname());
$data['secureCron']=$instancePrivateIP;
//$_SERVER['HTTP_REFERER']='signins/merchant_settlement';


//To restrict the execution of merchant_settlement_private_ip_allow.php to a specific private IP address using .htaccess, you can use the Allow from directive in combination with Require for better security
/*

# whitelisting ip for v3
<Files "merchant_settlement_private_ip_allow.php">
    Require ip 192.168.1.7 172.31.47.6
    Order Deny,Allow
    Deny from all
    Allow from 192.168.1.7
    Allow from 172.31.47.6
</Files>

*/

// sudo systemctl restart apache2


?>