<?php
session_start();
echo $_SESSION['summary_login_date']=date("h:i A");	
//Return the current server time and store into session
?>