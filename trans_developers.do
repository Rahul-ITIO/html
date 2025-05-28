<?
$data['PageName']='DEVELOPER';
$data['PageFile']='trans_developer';
$data['HideMenu']=true;
$data['HideAllMenu']=true;
error_reporting(0);
include('config.do');

if(isset($_REQUEST['download_curl'])&&$_REQUEST['download_curl']){
    $file_title=@$_REQUEST['file_title'];
    $download_curl=$_REQUEST['download_curl'];   
    $download_curl=str_replace(['&lt;','&gt;','&nbsp;','&amp;'],['<','>','','&'],$download_curl); 
    $now_date=date('ymdHis');
	$fileName_download = $data['SiteName']."_code_{$file_title}_{$now_date}.php";
	//echo '<br/>fileName=>'.$fileName_download;exit;
	header('Content-Encoding: UTF-8');
	header('Content-Disposition: attachment; filename='.$fileName_download);
	echo $download_curl;exit;
}
elseif(isset($_REQUEST['downloadHtml'])&&$_REQUEST['downloadHtml']){
   
	$now_date=date('ymdHis');
    if(isset($_REQUEST['file_ex'])&&$_REQUEST['file_ex'])
    $file_ex=$_REQUEST['file_ex'];
    else $file_ex='.html';

    $file_title=@$_REQUEST['file_title'];
	$downloadHtml=$_REQUEST['downloadHtml'];   
    //if($file_ex=='.java') $downloadHtml=str_replace(['&lt;','&gt;','&nbsp;','&amp;'],['<','>','','&'],$downloadHtml); else 
    $downloadHtml=str_replace(['&lt;','&gt;','&nbsp;','&amp;'],['<','>','','&'],$downloadHtml); 


    $fileName_download = $data['SiteName']."_generate_code_{$file_title}_{$now_date}".@$file_ex;
	//echo '<br/>fileName=>'.$fileName_download;exit;

	header('Content-Encoding: UTF-8');
	header('Content-Disposition: attachment; filename='.$fileName_download);
	echo $downloadHtml;exit;

}

$data['PageTitle']='Developer page for Post and Get Method by Curl/S2S/Direct/Redirect/Host in Encrypted and Without Encrypted)'; 
display('user');
//showpage("user/template.developer".$data['iex']);exit;

?>