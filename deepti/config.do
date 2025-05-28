<?php
################################################################################

$site_name='';
if(isset($_SERVER["HTTP_HOST"])){
	$site_name=$_SERVER["HTTP_HOST"];
}

$site_title='Back Office';
$site_charset='utf-8';
$site_copyrights=date('Y').' '.$site_name;
$site_keywords='';
$site_description='';



$admin_check_ip=false;
$admin_ip_address='';
$use_smspin=false;
include('config_db.do');


$protect_html='';
$default_language='English';


$mail_address='Your physical address should be here. id $_POST[--VARIABLE-NAME--]....';

$passlen=10;
$passatt=10;
$currency='S$';
$currsize='2';
$dateformat='m/d/y H:i';

$use_turing=false;
$use_numbers=true;
$turing_size=5;
$turing_quality=100;
$turing_bgfile='images/turing_bg.jpg';
$use_extreg=false;

$signup_use=false;
$signup_bonus=0.00;
$maxemails=5;

$minimal_transfer=10;
$maximal_transfer=50000000;
$transfer_percent=1;
$transfer_fee=1;
$refund_period=30;

$affiliate_program=true;
$affiliate_levels=9;
$affiliate_percent=10;

$dep_minimal=5;
$dep_maximal=500;
$dep_pp_use=true;
$dep_pp_fee=0.5;
$dep_pp_percent=2.5;
$dep_pp_username='KMitchell@MoorLivesMatter.com';
$dep_pp_password='';
$dep_cb_use=true;
$dep_cb_fee=5;
$dep_cb_percent=5;
$dep_cb_username='d383988d667719bbec4b28b4230c6ad50914e47384a1b7bf99365ff744e33c8b';
$dep_cb_password='';
$dep_sp_use=false;
$dep_sp_fee=0.5;
$dep_sp_percent=2.5;
$dep_sp_username='demo@gmail.com';
$dep_sp_password='';
$dep_np_use=false;
$dep_np_fee=1;
$dep_np_percent=5.5;
$dep_np_username='';
$dep_np_password='';
$dep_eg_use=false;
$dep_eg_fee=1;
$dep_eg_percent=15;
$dep_eg_username='test';
$dep_eg_password='';
$dep_mb_use=true;
$dep_mb_fee=1;
$dep_mb_percent=3;
$dep_mb_username='test';
$dep_mb_password='';
$dep_ig_use=false;
$dep_ig_fee=0.5;
$dep_ig_percent=2.5;
$dep_ig_username='test';
$dep_ig_password='';
$dep_eb_use=false;
$dep_eb_fee=0.5;
$dep_eb_percent=1.5;
$dep_eb_username='test';
$dep_eb_password='';
$dep_px_use=false;
$dep_px_fee=1;
$dep_px_percent=1;
$dep_px_username='';
$dep_px_password='';
$dep_pd_use=false;
$dep_pd_fee=1;
$dep_pd_percent=1;
$dep_pd_username='';
$dep_pd_password='';
$dep_ev_use=false;
$dep_ev_fee=1;
$dep_ev_percent=5.5;
$dep_ev_username='';
$dep_ev_password='';
$dep_qc_use=false;
$dep_qc_fee=10;
$dep_qc_percent=2.5;
$dep_qc_username='1';
$dep_qc_password='';
$dep_gm_use=false;
$dep_gm_fee=1;
$dep_gm_percent=2.54;
$dep_gm_username='test';
$dep_gm_password='';
$dep_vg_use=false;
$dep_vg_fee=1;
$dep_vg_percent=1.5;
$dep_vg_username='test';
$dep_vg_password='';
$dep_pe_use=false;
$dep_pe_fee=1;
$dep_pe_percent=2.53;
$dep_pe_username='';
$dep_pe_password='';
$dep_an_use=true;
$dep_an_fee=2.5;
$dep_an_percent=3.5;
$dep_an_username='sajibroy2015';
$dep_an_password='9732517729sS';
$dep_cc_use=false;
$dep_cc_fee=0.5;
$dep_cc_percent=5.5;
$dep_cc_username='0990';
$dep_cc_password='';
$dep_ec_use=false;
$dep_ec_fee=0.5;
$dep_ec_percent=5.5;
$dep_ec_username='';
$dep_ec_password='';
$dep_mc_use=true;
$dep_mc_fee=0.5;
$dep_mc_percent=5.5;
$dep_mc_username='';
$dep_mc_password='';

$wdr_minimal=1;
$wdr_maximal=1000;
$wdr_pp_use=true;
$wdr_pp_fee=1;
$wdr_cb_use=true;
$wdr_cb_fee=1;
$wdr_sp_use=false;
$wdr_sp_fee=0.00;
$wdr_np_use=false;
$wdr_np_fee=0.00;
$wdr_eg_use=false;
$wdr_eg_fee=0.00;
$wdr_mb_use=true;
$wdr_mb_fee=5;
$wdr_ig_use=false;
$wdr_ig_fee=0.00;
$wdr_eb_use=false;
$wdr_eb_fee=0.00;
$wdr_px_use=false;
$wdr_px_fee=0.00;
$wdr_pd_use=false;
$wdr_pd_fee=5;
$wdr_ev_use=false;
$wdr_ev_fee=0.00;
$wdr_gm_use=false;
$wdr_gm_fee=0.00;
$wdr_vg_use=false;
$wdr_vg_fee=0.00;
$wdr_pe_use=false;
$wdr_pe_fee=0.00;
$wdr_bw_use=true;
$wdr_bw_fee=25;
$wdr_mc_use=true;
$wdr_mc_fee=0.00;
$wdr_wu_use=true;
$wdr_wu_fee=15;
$wdr_mg_use=true;
$wdr_mg_fee=0.00;


################################################################################
// Rename the PHPSESSID cookie for convenience and set the maximum lifetime
/*
$lifetime = 1 * 60 * 60; // seconds
ini_set('session.name', 'session_id');
ini_set('session.gc_maxlifetime', $lifetime);
session_set_cookie_params($lifetime);
*/

################################################################################
	
	
	
include('consts.do');
include('common.do');
if(isset($data['t_clk'])&&isset($data['t'])){
	//$data['t']=keym_f($data['t_clk'],$data['t']);
}

$data['frontUiName']=(isset($data['frontUiName'])&&$data['frontUiName']?$data['frontUiName']:'default');
if($data['frontUiName']=="") { $data['frontUiName']="default"; }
if(isset($data['frontUiNameD'])&&$data['frontUiNameD']) { $data['frontUiName']=$data['frontUiNameD']; }

if(isset($_GET['h'])){
	if(isset($data['frontUiNameD'])&&$data['frontUiNameD']) {
		echo "<br/>frontUiNameD=>".$data['frontUiNameD'];
	}
}

$data['HostL']=$data['Host'];
$data['TEMPATH']=$data['Host']."/".$data['FrontUI']."/".$data['frontUiName'];
$data['CONFIGFILE']=1;
################################################################################
?>