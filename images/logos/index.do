<?php
$protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
$urlpath=$_SERVER['REQUEST_URI'];
$urlpath=str_replace(array("/ztswallet","index.do"),array("","oops.do"),$urlpath);
$urlpath = ltrim($urlpath, '/'); 
$urlpath_ex=explode("/",$urlpath);
$url_slash_count=count($urlpath_ex);
$url_slash_count=$url_slash_count-1;
$url_slash="../";
if($url_slash_count>0){
	while(--$url_slash_count){
		$url_slash.="../";
	}
}
$url_root_path=$url_slash."oops.do";
header("location:".$url_root_path);
include("$url_root_path");
?>