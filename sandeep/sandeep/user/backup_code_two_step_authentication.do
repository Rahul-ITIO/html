<?
ob_start();
session_start();
if($_SESSION['m_username']){ $username=$_SESSION['m_username'];
}elseif($_SESSION['username']){ $username=$_SESSION['username']; }

$_SESSION['SiteName'];
$text="Download the free Google Authenticator app :: https://support.google.com/accounts/answer/1066447?hl=en";
$key=$_REQUEST['key'];
$fileName = $_SESSION['SiteName']."_".$username."_backup_code_2FA.txt";
header('Content-Encoding: UTF-8');
//header("Content-type: application/x-ms-download"); //#-- build header to download the word file 
header('Content-Disposition: attachment; filename='.$fileName);
echo $text."\r\n\r\n".$key;
exit;
?>