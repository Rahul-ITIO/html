<?php
$config_root='config_root.do';
if(file_exists($config_root)){include($config_root);}
//echo "<br/>Host1=>".$data['Host']; echo "<br/>urlpath1=>".$urlpath;
	
	
function redirect_post_use($url, array $data)
{
	$url=urldecode($url);
    ?>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <script type="text/javascript">
            function closethisasap() {
                document.forms["redirectpost"].submit();
            }
        </script>
    </head>
    <body onLoad="closethisasap();">
    <form name="redirectpost" method="post" action="<?php echo $url; ?>">
        <?php
        if ( !is_null($data) ) {
            foreach ($data as $k => $v) {
                echo '<input type="hidden" name="' . $k . '" value="' . $v . '"> ';
            }
        }
        ?>
    </form>
    </body>
    </html>
    <?php
    exit;
}
	
	if(isset($_REQUEST['public_key'])&&$_REQUEST['public_key']){
		$_SESSION['re_post']['public_key']=strip_tags($_REQUEST['public_key']);
	}
	
	//echo "<br/><br/>re_post=><br/>"; print_r($_SESSION['re_post']);exit;

	if(isset($_SESSION['re_post']) && isset($_GET['merchantWebSite'])){
		$_SESSION['merchantWebSite']=$_GET['merchantWebSite'];
//$_SESSION['hkip_info']=$_GET['merchantWebSite'];//"merchantReturnWebSiteOK";
		echo $_SESSION['merchantWebSite'];
		exit;
	}
	elseif(isset($_SESSION['re_post']) && isset($_GET['paymetAt'])){
		if(isset($_SESSION['re_post']['process_file'])){
			$thisUrl=$_SESSION['re_post']['process_file'];
		}
		elseif(isset($data['API_VER'])&&$data['API_VER']==2){
			$thisUrl='checkout'.$data['ex'];
		}else{
			//$thisUrl='payment'.$data['ex'];
			$thisUrl='payme'.$data['ex'];
		}
		
		if(isset($_SESSION['re_post']['price'])&&$_SESSION['re_post']['price']){
			//$suqb=$_SESSION['re_post']['price'].'/';
			$suqb='';
		}else{
			$suqb='';
		}
		
		//echo "<br/><br/>re_post=><br/>"; print_r($_SESSION['re_post']);exit;
		if(isset($_SESSION['re_post']['payattherate'])&&$_SESSION['re_post']['payattherate']){
			
			$paymetAtUrl=$_SESSION['re_post']['payattherate'];
			//$paymetAtUrl=$data['Host']."/{$thisUrl}";
			
		}elseif(isset($_SESSION['re_post']['paylinkurl'])&&$_SESSION['re_post']['paylinkurl']){
			//$paymetAtUrl=$data['Host']."/{$thisUrl}/".strip_tags($_GET['api_token'])."/".$suqb;
			
			$paymetAtUrl=$data['Host']."/{$thisUrl}";
		}else{
			//$paymetAtUrl=$data['Host']."/{$thisUrl}?api_token=".strip_tags($_GET['api_token']);
			
			$paymetAtUrl=$data['Host']."/{$thisUrl}";
		}
		
		//echo $paymetAtUrl; print_r($_SESSION['re_post']);exit;
		
		
		redirect_post_use($paymetAtUrl, $_SESSION['re_post']);
		exit;
	}
	
?>