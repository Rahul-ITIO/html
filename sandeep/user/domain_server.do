<?php
$domain_server=domain_serverf("","merchant");
//$domain_server=domain_serverf("checkdebit.net","merchant");
$_SESSION['domain_server']=$domain_server;
?>
<?php
if($domain_server['STATUS']==true){
	$ds_pt=$domain_server['PageTitle'];
	$du1=$domain_server['du1'];
	$du2=$domain_server['du2'];
	$data['PageTitle']=str_replace($du1,$du2,$data['PageTitle']);
	$data['SiteTitle']=str_replace($du1,$du2,$data['SiteTitle']);
	$data['SiteDescription']=str_replace($du1,$du2,$data['SiteDescription']);
	$data['SiteKeywords']=str_replace($du1,$du2,$data['SiteKeywords']);
	$data['SiteCopyrights']=str_replace($du1,$du2,$data['SiteCopyrights']);
	
	$proto_col = isset($_SERVER["HTTPS"])?'https://':'http://';
	$data['home_url']=$proto_col.$_SERVER['SERVER_NAME'];
	if(!empty($domain_server['sub_admin_css'])){$_SESSION['theme_color']=$domain_server['sub_admin_css'];}
}
?>