<?
//include('../config_db.do');

//http://localhost/ztswallet/include/all_merchant_balance.do


include('../config.do');	
?>
<script src="<?=$data['Host']?>/js/common_use.js"></script>


<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/css/style.css">

<link rel="stylesheet" href="<?=$data['Host']?>/theme/css/custom.css" />


<link rel="stylesheet" href="<?=$data['Host']?>/theme/css/collabsible.css" />

<link rel="stylesheet" href="<?=$data['Host']?>/theme/css/custom_<?=$theme_color;?>_theme.css" />


<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/js/jquery-te-1.4.0.css"/>
<script src="<?=$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>


<style type="text/css">
.separator {display:none;}
.jqte {width:34% !important;float:left;margin:7px 0;}
.no_input{border:0!important;background:transparent!important;box-shadow: inset 0 0px 0px rgba(0,0,0,0.075) !important;}
</style> 


<style>
.row100.funda{height:inherit !important;}
</style>

<?php


if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
       //header("Location:{$data['USER_FOLDER']}/login.do");
       echo('ACCESS DENIED.');
       exit;
}

/*
	
	14 => Done
	15 => 4.92 | 90
	24 => 9 | 42.95
	40 => Done
	47 => Done
	40 => Done
	53 => Done
	54 => Done
	56 => Done
	
	
	
	
	
*/

//last balance auto update

$rid=db_rows(
		"SELECT DISTINCT merID ".
		" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
		" WHERE `merID`>0 AND `merID`!=1 AND `merID`!=26 AND `merID`!=27  AND `merID`!=28  AND `merID`!=41   AND `merID`!=59  AND `merID`!=62 AND `merID`!=63 AND `merID`!=38  ".
		//" WHERE `trname`='wd' AND `sender`=-2 ".
		" ",$qprint
	);
echo "<hr/>size=>".count($rid)."<br/>";
	
	$i=1;
	foreach($rid as $key=>$value){
		echo $i.". merID=>".$value['merID']."<br/>";
		
		
		$post['bid']=$value['merID'];
		$post['ab']=account_balance($post['bid']);
		$post['mb']=merchant_balance($post['bid']);
		$post['mbt']=account_trans_balance_calc($post['bid']);
		$post['mbt_d']=account_trans_balance_calc_d($post['bid']);
		include("mb_page.do");
		
	echo "<hr/>";	
		/*
		$post['ab']=account_balance($value['merID']);
		echo "Account Balance =>".$post['ab']['summ_total_amt']."<br/>";
		
		$post['ab']=account_balance($value['merID']);
		echo "Account Balance =>".$post['ab']['summ_total_amt']."<br/>";
		*/
		//db_query("UPDATE `{$data['DbPrefix']}clientid_table`"." SET `available_balance`={$post['ab']['summ_total_amt']} WHERE `id`={$value['merID']}");
		
		
		
		$i++;
	}
//print_r($rid);

exit;


?>

<meta http-equiv="pragma" content="no-cache"/>
<? if($domain_server['STATUS']==true){?>
<!-- Favicon -->
<meta name="msapplication-TileImage" content="<?=$domain_server['LOGO'];?>"> <!-- Windows 8 -->
<meta name="msapplication-TileColor" content="#00CCFF"/> <!-- Windows 8 color -->
<!--[if IE]><link rel="shortcut icon" href="<?=$domain_server['LOGO'];?>"><![endif]-->
<link rel="icon" type="image/png" href="<?=$domain_server['LOGO'];?>">
<?}?>

<script src="<?=$data['Host']?>/theme/scripts/jquery-1.8.2.min.js"></script>
<script src="<?=$data['Host']?>/js/common_use.js"></script>


<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/css/style.css">
<script type="text/javascript" language="JavaScript" src="<?=$data['Host']?>/js/script.js"></script>
<!-- Meta -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<!-- Bootstrap -->
<link href="<?=$data['Host']?>/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="<?=$data['Host']?>/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" />
<!-- Glyphicons -->
<link rel="stylesheet" href="<?=$data['Host']?>/theme/css/glyphicons.css" />
<link rel="stylesheet/less" href="<?=$data['Host']?>/theme/less/style.less" />
<script src="<?=$data['Host']?>/bootstrap/js/bootstrap.min.js"></script>

<script src="<?=$data['Host']?>/js/less.min.js"></script>
<!--[if IE]><script type="text/javascript" src="<?=$data['Host']?>/theme/scripts/excanvas/excanvas.js"></script><![endif]-->
<!--[if lt IE 8]><script type="text/javascript" src="<?=$data['Host']?>/theme/scripts/json2.js"></script><![endif]-->

<!-- Custom Onload Script -->
<script src="<?=$data['Host']?>/js/load.js"></script>



<? /*?>
<script text/javascript language=JavaScript>document.oncontextmenu=new Function("return false")</script>
<? */?>
<script type=text/javascript>function s(){window.status="<?=$data['SiteTitle']?> ?????????? [ADMINISTRATION AREA]";return true};if(document.layers)document.captureEvents(Event.MOUSEOVER|Event.MOUSEOUT|Event.CLICK|Event.DBLCLICK);document.onmouseover=s;document.onmouseout=s;</script>

<?

	if(isset($_GET['ajaxf'])){
		$trans_href="{$data['slogin']}/transactions2.do";
		$ajaxtrans="data-href=\"".$trans_href;
		$trans_target='target="modal_popup3_frame"';
		$trans_datah="data-";
		$trans_class="datahref";
		$_SESSION['trans_href']=$trans_href;
		$_SESSION['trans_datah']=$trans_datah;
		$_SESSION['trans_target']=$trans_target;
		$_SESSION['trans_class']=$trans_class;	
	}else{		
		$trans_href="{$data['slogin']}/transactions.do";$ajaxtrans="href=\"".$trans_href;$trans_target='';$trans_datah="";$trans_class="";$_SESSION['trans_href']=$trans_href;$_SESSION['trans_datah']=$trans_datah;$_SESSION['trans_target']=$trans_target;$_SESSION['trans_class']=$trans_class;
	}
	
	
	//$trans_href="{$data['slogin']}/transactions2.do"; 	$ajaxtrans="target=\"modal_popup3_frame\" href=\"".$trans_href; 
	

?>
