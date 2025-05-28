<?
if(!isset($data['config_root']))
{
	$data['config_root']=1;
	$config_root='config_root.do';
	if(file_exists($config_root)){include($config_root);}
	//echo "<br/>Host1=>".$data['Host']; echo "<br/>urlpath1=>".$urlpath;
}
include("secure/auth_3ds2.do");

//print_r($data);

?>
<style>
	.loder_div{display:none !important;}
</style>