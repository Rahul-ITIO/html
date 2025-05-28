<?
	//error_reporting(-1);
	error_reporting(0);
	if(!isset($_SESSION)) {
		session_start();
	}

function post_cross_domain($url, array $data){
    ?>
    <!DOCTYPE html>
	<html xmlns="http://www.w3.org/1999/xhtml" style="display:none !important;">
    <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<?php if(isset($data['b_submit'])){?>
			<script type="text/javascript">
				function closethisasap() {
					
				}
			</script>
		<?php } else {?>
			<script type="text/javascript">
				function closethisasap() {
					document.forms["redirectpost"].submit();
				}
			</script>
		<?php } ?>
    </head>
    <body onload="closethisasap();" style="display:none !important;">
    <form name="redirectpost" method="post" action="<?php echo $url; ?>">
        <?php
        if ( !is_null($data) ) {
            foreach ($data as $k => $v) {
				if(isset($data['b_submit'])){
					echo $k.' : <input type="text" name="'.$k.'" value="'.$v.'" style="display:none1;width:90%;"><br/> ';
				}else{
					echo '<input type="hidden" name="'.$k.'" value="'.$v.'" style="display:none;">';
				}
            }
        }
        ?>
		<?php if(isset($data['b_submit'])){?>
			<input type="submit" name="sendfrm" id="sendfrm" value="SUBMIT" class='btn' />
		<?php }?>
		
    </form>
    </body>
    </html>
    <?php
    exit;
}

	
	$json_param=array();
	// https://my.e1pay.com/payin/reuse_param.do?type=22
	
	//echo "<hr/>curl=>".$_REQUEST['curl'];
	
	if(isset($_REQUEST['curl'])&&!empty($_REQUEST['curl'])){
		$data_u['reuse_param']=$_SESSION['reuse_param'];
		$data_u['type']=$_REQUEST['type'];
		if(strpos($_REQUEST['curl'],"reuse_param.do")!==false){
			$curl=$_REQUEST['curl'];
		}else{
			$curl=$_REQUEST['curl']."/payin/reuse_param.do";
		}
		post_cross_domain($curl, $data_u);
	}

	
	if(isset($_GET['s'])){
		unset($_SESSION['type']);
		unset($_SESSION['reuse_param']);
		unset($_SESSION['reuse_param_'.$_REQUEST['type']]);
	}
	
	if(isset($_SESSION['reuse_param'])){
		$json_param['reuse_param']=($_SESSION['reuse_param']);
	}
	
	if(isset($_REQUEST['type'])&&!empty($_REQUEST['type'])){
		$_SESSION['type']=$_REQUEST['type'];
		if(isset($_REQUEST['reuse_param'])&&!empty($_REQUEST['reuse_param'])){
			$_SESSION['reuse_param_'.$_REQUEST['type']]=$_REQUEST['reuse_param'];
			
			$_SESSION['reuse_param']=$_REQUEST['reuse_param'];
		}
		
		$json_param['type']=$_REQUEST['type'];
		if(isset($_SESSION['reuse_param_'.$_REQUEST['type']])){
			$json_param['reuse_param_'.$_REQUEST['type']]=$_SESSION['reuse_param_'.$_REQUEST['type']];
		}
		
	}
	
	
	
	
	$json_param=json_encode($json_param);
	if(isset($_GET['q'])){
		header("Content-Type: application/json", true); echo $json_param;
	}
	
	if(!isset($_GET['q'])){
?>
	<script>
	//window.close();
	</script>
<?
	}
?>
