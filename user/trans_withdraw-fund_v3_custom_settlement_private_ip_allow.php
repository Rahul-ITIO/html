<?php
$instancePrivateIP = gethostbyname(gethostname());
$data['secureCron']=$instancePrivateIP;
//$_SERVER['HTTP_REFERER']='signins/merchant_settlement';


include ('trans_withdraw-fund_v3_custom_settlement.do');

//merchant_settlement_private_ip_allow
//To restrict the execution of trans_withdraw-fund_v3_custom_settlement_private_ip_allow.php to a specific private IP address using .htaccess, you can use the Allow from directive in combination with Require for better security
/*

        # whitelisting ip for v3
        <FilesMatch "trans_withdraw-fund_v3_custom_settlement_private_ip_allow">
            Require ip 172.31.40.21
            Order Deny,Allow
            Deny from all
            Allow from 172.31.40.21
        </FilesMatch>

        <FilesMatch "trans_withdraw-fund_v3_custom_settlement_private_ip_allow">
            Require ip 172.31.39.54
            Order Deny,Allow
            Deny from all
            Allow from 172.31.39.54
        </FilesMatch>

        <Files "trans_withdraw-fund_v3_custom_settlement_private_ip_allow">
            Require ip 172.31.39.54 192.168.1.7 172.31.47.6
            Order Deny,Allow
            Deny from all
            Allow from 172.31.39.54
            Allow from 192.168.1.7
            Allow from 172.31.47.6
        </Files>

*/

// sudo systemctl restart apache2


?>