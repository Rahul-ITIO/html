<?
error_reporting(0); // reports all errors
if(!isset($_SESSION)) {
	session_start(); 
	//session_regenerate_id(true); 
}
############################################################
if(!function_exists('explode_f')){
	function explode_f($str,$explode='.',$no=-1){
		if(strpos($str,$explode)!==false){
			$array=explode($explode, $str);
			if($no!=-1){
				return $array[$no];
			}else{
				return $array;
			}
		}else{
			return $str;
		}
	}
}
########################################################

$data['testEmail_1']='devops@itio.in';

########################################################

$data['ex']=''; $data['iex']='.do'; $data['css']='.css'; $data['js']='.js';
$data['Path']=dirname(__FILE__);
########################################################

if(isset($_SERVER["HTTPS"])&&$_SERVER["HTTPS"]=='on')$data['Prot']='https';else $data['Prot']='http';

$protocol =  isset($_SERVER["HTTPS"])?'https://':'http://';
if($_SERVER['SERVER_NAME']=='localhost'){
	$data['subfolder']='/'.explode_f($protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'],'/',3);
	//$data['Host']=$protocol.'localhost'.$data['subfolder'];
	//$_SERVER['SERVER_NAME']='localhost'.$data['subfolder'];
}else{
	//$data['Host']=$protocol.$_SERVER['SERVER_NAME'];
}
$urlpath=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
$data['urlpath']=$urlpath;
//echo "<br/>Host2=>".$data['Host']; echo "<br/>urlpath2=>".$urlpath;



$data['PORT'] = $_SERVER['SERVER_PORT'] ? ':'.$_SERVER['SERVER_PORT'] : '';
if($_SERVER['SERVER_PORT']==443||$_SERVER['SERVER_PORT']==80||$_SERVER['SERVER_PORT']==8080){$data['PORT']='';}
if($data['Folder'])$data['Folder']="/{$data['Folder']}";
$data['Addr']="{$_SERVER['REMOTE_ADDR']}";
$data['Host']="{$data['Prot']}://{$_SERVER['HTTP_HOST']}{$data['PORT']}{$data['subfolder']}{$data['Folder']}";

if(!function_exists('prntext')){
	function prntext($text,$repl=0){
		//global $data;
		if(is_string($text)){
			if($repl>0){
				 //$text = urldecode($text);
			}
			$text = str_ireplace(array('onmouseover','onclick','onmousedown','onmousemove','onmouseout','onmouseup','onmousewheel','onkeyup','onkeypress','onkeydown','oninvalid','oninput','onfocus','ondblclick','ondrag','ondragend','ondragenter','onchange','ondragleave','ondragover','ondragstart','ondrop','onscroll','onselect','onwheel','onblur','<','>',"'"), '', $text );
			return trim(strip_tags($text));
		}
	}
}
if(isset($_GET['dtest'])){
	error_reporting(E_ERROR | E_WARNING | E_PARSE);
} else{
	error_reporting(0);
}

if(!function_exists('find_css_color_bootstrap')){
	function find_css_color_bootstrap($csscolor,$default='#fff'){
		switch ($csscolor) {
		case "green":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#1ec000";
			$root_border_color="#198e03";
			break;
		case "clk":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#91ed92";
			$root_border_color="#3b77b6";
			break;
		case "sifi":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#91ed92";
			$root_border_color="#3b77b6";
			break;
		case "yellow":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#ffeb3b";
			$root_border_color="#ffeb3b";
			break;
		case "blue":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#0d6efd";
			$root_border_color="#3b77b6";
			break;
		case "bigo":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#0d6efd";
			$root_border_color="#3b77b6";
			break;
		case "blueLeftPanel":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#0d6efd";
			$root_border_color="#3b77b6";
			break;
		case "sys":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#0d6efd";
			$root_border_color="#3b77b6";
			break;
		case "darkgreen":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#8fa895";
			$root_border_color="#3b77b6";
			break;
		case "magenta":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#DAB2C1";
			$root_border_color="#DAB2C1";
			break;
		case "orange":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#ff9800";
			$root_border_color="#ff5722";
			break;
		case "darknavyblue":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#192b33";
			$root_border_color="#192b33";
			break;
		case "white":
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#fff";
			$root_border_color="#fff";
			break;
		default:
			$root_text_color="#fff";
			$root_bg_color="#fff";
			$root_background_color="#0d6efd";
			$root_border_color="#3b77b6";
		}
		return array($root_text_color,$root_bg_color,$root_background_color,$root_border_color);
	}// End function
}
if(!function_exists('adc')){
	function adc($hexCode, $adjustPercent) {
		$hexCode = ltrim($hexCode, '#');

		if (strlen($hexCode) == 3) {
			$hexCode = $hexCode[0] . $hexCode[0] . $hexCode[1] . $hexCode[1] . $hexCode[2] . $hexCode[2];
		}

		$hexCode = array_map('hexdec', str_split($hexCode, 2));

		foreach ($hexCode as & $color) {
			$adjustableLimit = $adjustPercent < 0 ? $color : 255 - $color;
			$adjustAmount = ceil($adjustableLimit * $adjustPercent);

			$color = str_pad(dechex($color + $adjustAmount), 2, '0', STR_PAD_LEFT);
		}

		return '#' . implode($hexCode);
	}
}
if(!function_exists('transIDf')){
	function transIDf($transID,$no=0){
		$result='';
		if(!empty($transID)){
			$id_orders = explode('_',$transID);	//explode transID via hyphen (_)
			if(isset($id_orders)&&$id_orders&&isset($id_orders[$no])){	//check specific array key exists or not
				$result=$id_orders[$no];	//store value specific array value into $result
			}
		}
		return $result;	//return order number
	}
}



//make sure for not encoded, need to encode with remove tab & new line
if(!function_exists('urlencodef')){
	function urlencodef($urlEncode){
		if(!preg_match("@^[a-zA-Z0-9%+-_]*$@", $urlEncode))
		{
			// not encoded, need to encode it
			$urlEncode = urlencode($urlEncode);
		}
		$urlEncode = preg_replace('~[\r\n\t]+~', '', $urlEncode);
		return $urlEncode;
	}
}

//make sure for decoded, need to multiple time decoded with remove tab & new line
if(!function_exists('urldecodef')){
	function urldecodef($urlDeCode){
		$urlDeCode = preg_replace('~[\r\n\t]+~', '', $urlDeCode);
		$urlDeCode = urldecode($urlDeCode);
		$urlDeCode = urldecode($urlDeCode);
		$urlDeCode = urldecode($urlDeCode);
		$urlDeCode = urldecode($urlDeCode);
		$urlDeCode = urldecode($urlDeCode);
		$urlDeCode = urldecode($urlDeCode);
		$urlDeCode = urldecode($urlDeCode);
		$urlDeCode = urldecode($urlDeCode);
		$urlDeCode = urldecode($urlDeCode);
		$urlDeCode = (html_entity_decode($urlDeCode));
		return $urlDeCode;
	}
}


//The post_redirect() used to send request direct via form submission.
if(!function_exists('post_redirect')){
	function post_redirect($url, array $data)
	{
		?>
		<!DOCTYPE html>
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
			<meta charset="UTF-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
			<?php
			if(isset($data['target_'])) { 
				$target=' target="'.$data['target_'].'" ';
				unset($data['target_']);
			}
			else $target='';

			if(isset($data['method_'])) { 
				$method=' method="'.$data['method_'].'" ';
				unset($data['method_']);
			}
			else $method=' method="post" ';

			//echo "<hr/>target=>".$target;

			if(isset($data['b_submit'])){?>
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
		<body onLoad="closethisasap();">
		<form name="redirectpost"  <?php echo $method; ?>  <?php echo $target; ?> action="<?php echo $url; ?>">
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
}

if(!function_exists('prefix_trans_lenght')){

	//Generate for Prefix Trans Lenght wise : Add Prefix & Suffix Values To Each String with Lenght wise via prefix_trans_lenght('10314927651',19,2,'SE','O');  10314927651OOOOOOSE || prefix_trans_lenght('10314927651',31,1,'TRANSESSION','O');   TRANSESSIONOOOOOOOOO10314927651
	function prefix_trans_lenght($transID,$length=31,$suffix=2,$addText='SESSION',$repeatText='9')
	{
		$lenth = 0; $qp=0; if(isset($_REQUEST['qp'])) $qp=$_REQUEST['qp'];
		if(@$qp){ echo "<br/>transID lenth=>".strlen($transID).'<br/><br/>'; echo "<br/>length=>".$length.'<br/><br/>';}

		if( $length > strlen($transID) )
			$lenth = $length - strlen($transID.$addText);

		if(@$qp){ echo "<br/>addText=>".strlen($addText).'<br/><br/>'; echo "<br/>lenth=>".$lenth.'<br/><br/>';}

		if($lenth<0) { 
			$lenth = $length - strlen($transID);
			$addText='';
		}
		if($length <= strlen($transID)) $addText='';
		
		//$lenth = (int)$lenth; 

		if(@$qp) echo "<br/>lenth=>".$lenth.'<br/><br/>';

		$txt=''; 
		if($lenth>0 && $length > strlen($transID) ) for($i=1; $i<=$lenth; $i++) $txt.=$repeatText; 
		
		if($suffix==2) $result=$transID.$txt.$addText;
		else $result=$addText.$txt.$transID;
		if(@$qp) echo "<br/>txt=>".$txt.'<br/><br/>';


		$result = substr(@$result, 0, $length);

		return @$result;

	}

}

if(!function_exists('hardCodePrint')){
	// hard code : display the code or print the hardcode 
	function hardCodePrint($fileName='') {
		if($fileName=='')$fileName=basename(@$_SERVER['SCRIPT_NAME']);
		$content = file_get_contents(@$fileName); if(is_string($content)) $content = htmlentities($content);echo "<pre style='color:#f8f8f2;background-color:#272822;width:97vw;padding:10px;word-wrap:break-word;border-radius:5px;'><code style='padding:10px;word-wrap:break-word;text-wrap:initial;margin:auto;'>{$content}</code></pre>";
	}
}
?>