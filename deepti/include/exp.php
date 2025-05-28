<?php
include('../config.do');

//  gw/include/exp.php   
   
   $backup_file = $data['Database'] . date("Y-m-d-H-i-s") . '.gz';
   
   //$command = "mysqldump --opt -h {$data['Hostname']} -u {$data['Username']} -p {$data['Password']} ". "{$data['Database']} zt_acquirer_table | gzip > {$backup_file}";
   
   $command = "mysqldump -h {$data['Hostname']} -u {$data['Username']} -p {$data['Password']} {$data['Database']} zt_acquirer_table | gzip > {$backup_file}";
   
   system($command);
?>