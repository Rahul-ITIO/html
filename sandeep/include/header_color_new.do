<? 
   
	$getclr=((isset($data['theme_color']) && $data['theme_color'])?$data['theme_color']:'');
	$color_fx=find_css_color_bootstrap($getclr); // function defined on conf**_db
	
	$root_text_color=$color_fx[0];
	$root_bg_color=$color_fx[1];
	$root_background_color=$color_fx[2];
	$root_border_color=$color_fx[3];

        // for User Login page Color without Login
		if(isset($domain_server['header_bg_color'])&&$domain_server['header_bg_color'] && empty($domain_server['subadmin']['header_bg_color'])){
		$domain_server['subadmin']['header_bg_color']=$domain_server['header_bg_color'];
		$domain_server['subadmin']['header_text_color']=$domain_server['header_text_color'];
		}
		
		// for checkout success / Failed / Processing Page Button Color
		if(isset($post['clientid'])&&$post['clientid'] && empty($domain_server['subadmin']['header_bg_color']) && empty($domain_server['header_bg_color'])){
			$ds=$domain_server=sponsor_themefc(0,$post['clientid']); // function defined on conf**_db
			
			$domain_server['subadmin']['header_bg_color']=$ds['subadmin']['header_bg_color'];
			$domain_server['subadmin']['header_text_color']=$ds['subadmin']['header_text_color'];
			
		}
		
		
	if(isset($domain_server['subadmin']['header_bg_color'])&&$domain_server['subadmin']['header_bg_color']){
		$root_background_color=$domain_server['subadmin']['header_bg_color'];
		$header_bg_color_1=$root_background_color;
		$root_text_color=$domain_server['subadmin']['header_text_color'];
		
		///////////////////Dynamic Code ////////////////////////
		 
			if(strpos($root_background_color,",")!==false){
			$header_bg_color_1=explode(",",$root_background_color)[1];
			}
			 $header_bg_color_1=str_replace(" 0%","",$header_bg_color_1);
			if(strstr($header_bg_color_1,'rgba')&&!isset($header_bg_color_by_header)){
			$header_bg_color_1="#1375b1";
			}
			
			
			if(isset($header_bg_color_by_header)&&$header_bg_color_by_header&&strstr($header_bg_color_1,'rgba')){
			$header_bg_color_1=$header_bg_color_by_header;
			}
			if(!isset($header_bg_color_1)&&empty($header_bg_color_1)){
			
				if($data['frontUiName']=="ice1") { $header_bg_color_1=$domain_server['subadmin']['header_bg_color'];
				}elseif($data['frontUiName']=="ice2") { $header_bg_color_1=$domain_server['subadmin']['header_bg_color'];
				}else{ $header_bg_color_1="#0071bc"; 
				}
				
			}
		
		     ///////////////////End Dynamic Code ////////////////////////
	}

	if(isset($domain_server['subadmin']['heading_bg_color'])&&$domain_server['subadmin']['heading_bg_color']){
		$heading_bg_color=$domain_server['subadmin']['heading_bg_color'];
		$heading_text_color=$domain_server['subadmin']['heading_text_color'];
	}

	if(isset($domain_server['subadmin']['body_bg_color'])&&$domain_server['subadmin']['body_bg_color']){
		$body_bg_color=$domain_server['subadmin']['body_bg_color'];
		$body_text_color=$domain_server['subadmin']['body_text_color'];
	}


	$data['subdomain_root_background_color']=$root_background_color;
    $_SESSION['root_text_color']=$data['subdomain_root_text_color']=$root_text_color;
	$_SESSION['root_background_color']=$root_background_color;

	
	$data['tc']['hd_b_d_0']=$header_bg_color_1;
	$data['tc']['hd_b_l_9']=$hd_b_l_9=adc($header_bg_color_1, 0.9);
	$data['tc']['hd_b_d_5']=$hd_b_l_9=adc($header_bg_color_1, -0.5);
	$data['background_g']=$header_bg_color_1;
	$_SESSION['background_g']=$header_bg_color_1;
	$_SESSION['background_gd3']=adc($data['background_g'], -0.3);
	$_SESSION['background_gd4']=adc($data['background_g'], -0.4);
	$_SESSION['background_gd5']=adc($data['background_g'], -0.5);
	$_SESSION['background_gd7']=adc($data['background_g'], -0.7);
	$_SESSION['background_gd8']=adc($data['background_g'], -0.8);
	$_SESSION['background_gd9']=adc($data['background_g'], -0.9);
	$_SESSION['background_gl5']=adc($data['background_g'], 0.5);
	$_SESSION['background_gl6']=adc($data['background_g'], 0.6);
	$_SESSION['background_gl7']=adc($data['background_g'], 0.7);
	
	
	/*if(($root_background_color=="#ffffff") && ($data['PageFile']=="processall")){
	$root_background_color="#808080";
	$data['tc']['hd_b_l_9']="#eee";
	$data['tc']['hd_b_d_5']="#eee";
	}*/
	?>
	
	
	<? /*?>Set Template color Dynamic from subadmin data by vikash<? */?>
	
	
<style>
:root { 
  --color-1: <?=$root_text_color;?>;
  --bg-1: <?=$root_bg_color;?>;
  --background-1: <?=$root_background_color;?>;
  --border-color-1: <?=$root_border_color;?>;
  --body_bg_color-1:<?=$body_bg_color;?>;
  --body_text_color-1:<?=$body_text_color;?>;
  --heading_bg_color-1:<?=$heading_bg_color;?>;
  --heading_text_color-1:<?=$heading_text_color;?>;
  --color-2: <?=$data['tc']['hd_b_d_0'];?>;
  --color-3: <?=$data['tc']['hd_b_l_9'];?>;
  --color-4: <?=$data['tc']['hd_b_d_5'];?>;
  <? if($_SESSION['root_background_color']=="#FFFFFF"){ ?>
	--menu-list-hover-color: #808080; 
  <? }else{ ?>
    --menu-list-hover-color: <?=$root_background_color;?>;
  <? } ?>
}

.border-template { border-color: <?=$header_bg_color_1;?> !important;}
.text-template { color: <?=$header_bg_color_1;?> !important; }

<? if(strtolower($_SESSION['root_background_color'])=="#ffffff"){ ?>
body .btn-primary  { background-color: var(--bs-body-bg) !important;color: var(--bs-body-color) !important;}
<? } ?>
	
</style>
	<? /*?>Display Color code on template page when pass subquery c1 on url by vikash<? */?>
	<? if(isset($_GET['c1'])){ 
	
	echo "<h3>Template / Main Color:=>".$data['frontUiName']." = > ".$getclr." = > ".$header_bg_color_1."</h3>";
	?>
	<table class="table">
			<thead>
				<tr  style="background:<?=$getclr;?> !important;"><th>Color Code</th><th>Color</th></tr>
			</thead>
			<tbody>
				<tr><td title="Text Color" style="background:<?=$_SESSION['background_gd8'];?>;color:<?=$_SESSION['root_text_color'];?>;" >$_SESSION['root_text_color'];</td><td><?=$_SESSION['root_text_color'];?></td></tr>
			    <tr><td style="background:<?=$data['tc']['hd_b_l_9'];?>" >$data['tc']['hd_b_l_9'];</td><td><?=$data['tc']['hd_b_l_9'];?></td></tr>
				<tr><td style="background:<?=$data['tc']['hd_b_d_0'];?>" >$data['tc']['hd_b_d_0'];</td><td><?=$data['tc']['hd_b_d_0'];?></td></tr>
				<tr><td style="background:<?=$data['tc']['hd_b_d_5'];?>" >$data['tc']['hd_b_d_5']</td><td><?=$data['tc']['hd_b_d_5'];?></td></tr>
				<tr><td style="background:<?=$_SESSION['background_gl7'];?>" >$_SESSION['background_gl7'];</td><td><?=$_SESSION['background_gl7'];?></td></tr>
				<tr><td style="background:<?=$_SESSION['background_gl6'];?>" >$_SESSION['background_gl6'];</td><td><?=$_SESSION['background_gl6'];?></td></tr>
				<tr><td style="background:<?=$_SESSION['background_gl5'];?>" >$_SESSION['background_gl5'];</td><td><?=$_SESSION['background_gl5'];?></td></tr>
				<tr><td style="background:<?=$_SESSION['background_gd3'];?>" >$_SESSION['background_gd3'];</td><td><?=$_SESSION['background_gd3'];?></td></tr>
				<tr><td style="background:<?=$_SESSION['background_gd4'];?>" >$_SESSION['background_gd4'];</td><td><?=$_SESSION['background_gd4'];?></td></tr>
				<tr><td style="background:<?=$_SESSION['background_gd5'];?>" >$_SESSION['background_gd5'];</td><td><?=$_SESSION['background_gd5'];?></td></tr>
				<tr><td style="background:<?=$_SESSION['background_gd7'];?>" >$_SESSION['background_gd7'];</td><td><?=$_SESSION['background_gd7'];?></td></tr>
				<tr><td style="background:<?=$_SESSION['background_gd8'];?>" >$_SESSION['background_gd8'];</td><td><?=$_SESSION['background_gd8'];?></td></tr>
				<tr><td style="background:<?=$_SESSION['background_gd9'];?>" >$_SESSION['background_gd9'];</td><td><?=$_SESSION['background_gd9'];?></td></tr>
			</tbody>
		</table>
	<? } ?>
	