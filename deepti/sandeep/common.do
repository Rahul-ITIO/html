<?php
###############################################################################

$data['PostSent']=false;
$data['ScriptLoaded']=true;
if(!isset($_COOKIE["ln"])){
	$data['lang_ch']=$data['DefaultLanguage'];
	setcookie("ln", $data['lang_ch']);	
}else{
	$data['lang_ch']=$_COOKIE["ln"];
}

//$default_language='eng'; $data['lang_ch']=$default_language; $data['DefaultLanguage']=$default_language;

//echo "lang_ch=>".$data['lang_ch']."<br/>";echo "DefaultLanguage=>".$data['DefaultLanguage']."<br/>";
###############################################################################

//define Templates path
if(isset($data['FrontUI'])&&$data['FrontUI']){
	$data['Templates']="{$data['Path']}/".$data['FrontUI'];
}else{
	$data['Templates']="{$data['Path']}/templates";
}

//define images and buttons path
$data['BannersPath']="{$data['Path']}/images/banners";
$data['SinBtnsPath']="{$data['Path']}/images/buttons/single";
$data['DonBtnsPath']="{$data['Path']}/images/buttons/donations";
$data['SubBtnsPath']="{$data['Path']}/images/buttons/subscriptions";
$data['ShopBtnsPath']="{$data['Path']}/images/buttons/shopcart";

$data['Images']		="{$data['Host']}/images";
$data['Banners']	="{$data['Images']}/banners";
$data['SinBtns']	="{$data['Images']}/buttons/single";
$data['DonBtns']	="{$data['Images']}/buttons/donations";
$data['SubBtns']	="{$data['Images']}/buttons/subscriptions";
$data['ShopBtns']	="{$data['Images']}/buttons/shopcart";

//define Admins and subAdmins path
if(isset($data['AdminFolder'])&&$data['AdminFolder']){
	$data['Admins']="{$data['Host']}/{$data['AdminFolder']}";
	$data['slogin']="{$data['Host']}/{$data['AdminFolder']}";
}else{
	$data['Admins']="{$data['Host']}/mlogin";
	$data['slogin']="{$data['Host']}/mlogin";
}

$data['USER_FOLDER']="{$data['Host']}/user"; //	user Users

$data['Home']="Location:{$data['Host']}/index".$data['ex'];	//home page path

//message fro not found and some error
$data['OppsAdmin']="Oops... Something went wrong <a href='{$data['Admins']}/index{$data['ex']}'> Click here to Go to Home.</a>";

##############################################################################
function includef($file_path){
	//include files if exists
	if(file_exists($file_path)){include($file_path);}else{echo "not exit file : ".$file_path;}
}


include('include/browser_os_function'.$data['iex']);	//include browser_os_function file 
##############################################################################


##############################################################################

//The function is_clients_block() is used to check user is block or not.
function is_clients_block($username){
	$user_id	=get_clients_id($username);		//fetch username
	$user_info	=get_clients_info($user_id);		//fetch info from clients table
	$block_ip	=$user_info['ip_block_client'];	//fetch block IPs

	return $block_ip; 	//return IP list
}

//The function getLocationInfoByIp() is used to get location via IP. - currently is not using
function getLocationInfoByIp($ipAddress,$region=''){
	$bill_ip = $ipAddress;
	$ip_data = @json_decode(file_get_contents("http://www.geoplugin.net/json.gp?bill_ip=".$bill_ip));	//fetch IP detail from geoplugin
	$ip_data->geoplugin_countryName;	//country name
	if($region){$ip_data->geoplugin_region;}	//region name
	return $ip_data->geoplugin_countryName;
}

//The function is_clients_login_same_country() is used to check clients last login with same IP/location or different location. - currently is not using
function is_clients_login_same_country($username,$password){
	$user_id=get_clients_id($username,$password);	//fetch userid
	$user_info=get_clients_info($user_id);			//fetch clients information
	$register_ip=$user_info['last_ip'];				//last login IP
	$register_country = getLocationInfoByIp($register_ip);	//fetch IP location
	return $register_country;	//return country name
}

//This function currently is not using
function protect($buffer){
	global $data, $_SERVER, $_SESSION;
	if(isset($data['ProtectHtml'])&&$data['ProtectHtml']&&isset($_SESSION['login'])&&$_SESSION['login']) return encrypt_pages($buffer);
	else return $buffer;
}

//This function currently is not using
function prepare($buffer){
	return protect($buffer);
}

//The function show() is used to display data as per defined template format.
function show($template,$path_nm=''){
	global $data, $post;
	$template_path=$template;
	
	//if DefaultTemplate is true, then set DefaultTemplate
	if(isset($data['DefaultTemplate'])&&$data['DefaultTemplate']){
		$default=$data['DefaultTemplate'];
		$data['frontUiName']=$default;
		$data['TEMPATH']=$data['Host']."/".$data['FrontUI']."/".$default;
		if(isset($_GET['h'])){
			echo "<br/><br/>DefaultTemplate=>".$data['DefaultTemplate'];
		}
	}else{
		$default='default';
	}
	
	//if the template name direct pass in url, then forcely change templates
	if(isset($_SESSION['a_tem'])&&(isset($_GET['t1'])&&$_GET['t1']=='d')){unset($_SESSION['a_tem']); }
	elseif((isset($_GET['t1'])&&trim($_GET['t1'])&&$_GET['t1']!='d')) { $_SESSION['a_tem']=$_GET['t1']; }
	
	//change template name
	if(isset($_SESSION['a_tem'])&&trim($_SESSION['a_tem'])) { 
		$default=$_SESSION['a_tem']; $data['frontUiName']=$default; 
		$data['TEMPATH']=$data['Host']."/".$data['FrontUI']."/".$default;

		if(isset($_GET['h'])){
			echo "<br/><br/>Test Assing Template=> ".@$default;
		}
	}
		
	if(isset($_GET['h'])){
		echo "<br/><br/>path_nm=>".@$path_nm;
		echo "<br/>template=>".@$template;
		echo "<br/>Templates=>".@$data['Templates'];
		echo "<br/>frontUiName=>".@$data['frontUiName'];
	}
	
	//check FrontUI defined or not
	if(isset($data['FrontUI'])&&$data['FrontUI']){
		
		//replace default Template with assign template
		if(isset($data['frontUiName'])) $template_subadmin=str_replace("/default/",'/'.$data['frontUiName'].'/',$template);
		else $template_subadmin = "";	
		
		
		/*if($path_nm=="user"||$path_nm==""){$template3=str_replace($data['FrontUI']."/default/",'templates/langs/English/',$template);}
		else*/
		
		/*
		if(isset($path_nm)&&($path_nm=="mlogin"||$path_nm=="admins")){$template3=str_replace($data['FrontUI']."/default/",'templates/',$template);}
		
		*/
		
		$template2=str_replace("/".$data['frontUiName']."/",'/default/',$template); // force default
		
		if(isset($_GET['h'])){
			echo "<br/>template_subadmin=>".$template_subadmin;
			echo "<br/>template2=>".((isset($template2)&&$template2)?$template2:"");
		}
		
		if(isset($_GET['t1'])&&$_GET['t1']=='d') {
			$template_path=$template; // get default by t1=d
			$data['TEMPATH']=$data['Host']."/".$data['FrontUI']."/".$default;
		}elseif(file_exists($template_subadmin)){
			$template_path=$template_subadmin; // subadmin clk 
			$file_exists_no="1 subadmin".$template_path;
		}elseif(file_exists($template2)){
			$template_path=$template2; // force default
			$default='default';
			$data['frontUiNameD']=$default;
			$data['TEMPATH']=$data['Host']."/".$data['FrontUI']."/".$default;
			$file_exists_no="2 default".$template_path;
		}elseif(file_exists($template)){
			$template_path=$template; 
			$data['frontUiNameD']=$default; // assign front ui
			$data['TEMPATH']=$data['Host']."/".$data['FrontUI']."/".$data['frontUiNameD'];
			$file_exists_no="2 assign front ui =>".$template_path;
		}
	}
		
	if(isset($_GET['h'])){
		echo "<br/>TEMPLATE_PATH=>".$template_path;
		echo "<br/>TEMPATH=>".$data['TEMPATH'];
		echo "<br/>file_exists_no=>".$file_exists_no;
		if(isset($data['frontUiNameD'])&&$data['frontUiNameD']) {
			echo "<br/>frontUiNameD=>".$data['frontUiNameD'];
		}
	}
	
	if(file_exists($template_path))include($template_path);			//include assign template
	else echo("<br/>TEMPLATE : \"{$template_path}\" not found!");
}

//The function display() is used to include assign template.
function display($path=''){
	global $data;
	ob_start();
	//if($path=="clientid_table"){$path="user";}
	$path_nm=$path;
	
	/*
	if(isset($_SESSION['uid'])){	
		$uid=(int)$_SESSION['uid'];
		$ip_block=db_rows("SELECT `ip_block_client` FROM `{$data['DbPrefix']}clientid_table`"." WHERE `id`='{$uid}'",0); 	//fetch block IPs from clientid_table table

		if(!empty($ip_block)){	//if IP block then re-direct to block page
			$ip_block_client=$ip_block[0]['ip_block_client'];

			if($_SESSION['uid']!=1){
				if ($ip_block_client==0){
					unset($_SESSION['login']);
					unset($_SESSION['uid']);
					header("Location:{$data['Host']}/user/block{$data['ex']}");
					exit;
				}
			}
		}
	}
	*/
	
	ob_start("prepare");		//opens a buffer in which prepare is stored.
	if($path){
		$path="/{$path}";
	}
	if (!$data['lang_ch']){
		$data['lang_ch']=$data['DefaultLanguage'];		//default language
	}
	
	if(isset($data['FrontUI'])&&$data['FrontUI']){
		$path="/default".$path;		//UI path
	}else{
		if($path=="/user"||$path==""){$path="/langs/{$data['lang_ch']}".$path;}	//path according langauge
	}
	
	show("{$data['Templates']}{$path}/template.header{$data['iex']}",$path_nm);		//display header
	if(isset($data['PageFiles'])&&$data['PageFiles']&&is_array($data['PageFiles'])){
		$PageFiles=[];
		if(isset($data['PageFiles'])&&$data['PageFiles']) $PageFiles=$data['PageFiles'];
		foreach($PageFiles as $ke=>$val){
			show("{$data['Templates']}{$path}/template.{$val}{$data['iex']}",$path_nm);	//display assign template
		}
	}else{
		show("{$data['Templates']}{$path}/template.{$data['PageFile']}{$data['iex']}",$path_nm);
	}
	show("{$data['Templates']}{$path}/template.footer{$data['iex']}",$path_nm);	//display footer
	
	db_disconnect();	//disconnect DB connection
	ob_end_flush();		//Deletes the topmost output buffer and outputs all of its contents.
}

//The function showpage() is used to include assign template.
function showpage($template){
	global $data;
	ob_start("prepare");		//opens a buffer in which prepare is stored.
	if(isset($data['FrontUI'])&&$data['FrontUI']){
		$template="default/".$template;
	}
	show("{$data['Templates']}/{$template}");	//display assign template.
	ob_end_flush();		//Deletes the topmost output buffer and outputs all of its contents.
}
//This function currently is not using
function showmenu($mode, $path=''){
	global $data;
	$data['mode']=$mode;
	if($path)$path="/{$path}";
	if (!$data['lang_ch']){
		$data['lang_ch']=$data['DefaultLanguage'];
	}
	//if ($path != "/admins"){$path="/langs/{$data['lang_ch']}".$path;}
	show("{$data['Templates']}{$path}/template.menu{$data['iex']}");
}

//This function currently is not using
function showbanner(){
	global $data;
	show("{$data['Templates']}/template.banners{$data['iex']}");
}

//This function currently is not using
function show_menu_langs(){
	global $data;
	$langs_dir_obj = dir($data['Templates']."/langs/");
	while($entry = $langs_dir_obj->read()){
		if ($entry != "." && $entry != ".." && $entry != "default") {
			if($_COOKIE["ln"]==$entry || (!$_COOKIE["ln"] && $data['DefaultLanguage']==$entry)){$select="selected";}
			else{$select="";}
			echo "<option value='".$entry."' ".$select.">".$entry."</option>";
		}
	}
}

//The function show_default_select_lang() is used to setup default Templates language. Currently is not using
function show_default_select_lang(){
	global $data;
	$langs_dir_obj = dir($data['Templates']."/langs/");
	while($entry = $langs_dir_obj->read()){
		if ($entry != "." && $entry != ".." && $entry != "default") {
			if($data['DefaultLanguage']==$entry){$select="selected";}else{$select="";}
			echo "<option value='".$entry."' ".$select.">".$entry."</option>";
		}
	}
}

//The function verify_email2() is used to check email-id is valid or not
function verify_email2($email){
	if(filter_var($email, FILTER_VALIDATE_EMAIL)) {
		return $email;
	}
	else{
		return $email=false;
	}
}

//The function verify_email() is used to check email-id is valid or not via email' fixed pattern
function verify_email($email){
	return !(bool)preg_match("/^.+@.+\\..+$/", $email);
}

//This function is used to verify username is correct or not on assign preg_match pattern.
function verify_username($username){
	return !(bool)preg_match("/^[a-zA-Z0-9]+$/", $username);
}

//to generate a unique code
function gencode(){
	global $data;
	list($usec, $sec)=explode(' ', microtime());
	$rand=(float)$sec+((float)$usec*100000);
	srand($rand);
	if(isset($data['TuringNumbers'])&&$data['TuringNumbers']){
		return (string)rand(pow(10, $data['TuringSize']-1), pow(10, $data['TuringSize'])-1);
	}else{
		return strtoupper(substr(md5(rand()), rand(1, 26), $data['TuringSize']));
	}
}
//To returns a string produced according to the formatting string format 
function around($amount){
	return sprintf("%6.2f", $amount);
}

//The encode() function is used to Encodes card number with mask.
function encode($number, $size, $mask=1){ //ccno
	$result='';
	$length=strlen($number);
	for($i=0;$i<$length-$size;$i++)if($mask)$result.='X';
	return $result.substr($number, $length-$size, $length);
}

//The function is_changed() is used to returns 1 if the pattern matches given subject, 0 if it does not, or false on failure on base of preg_match()
function is_changed($number){
	return (bool)preg_match("^[0-9]+$", $number);	//return in boolen format
}
//The function is_number() is used to value is number or a string
function is_number($text){
	if(!is_changed($text))return true;
	return (bool)is_changed($text);		//return in boolen format
}

//The function show_selected() is used to show /display selected values.
function show_selected($key, $current=null, $commaSeparated=0){
	$selected='';
	if($commaSeparated){
		$current=explode(',',$current.',');
	}
	if(is_array($current)){
		foreach($current as $value){
			if($value&&$value==$key){		//if key and value matched then return selected
				$selected='selected';
			}
		}
	}else{
		if($key==$current){		//if key and current matched then return selected
			$selected='selected';
		}
	}
	return $selected;	//return selected value
}

//The function showselect() is used to print/display values in the <option> </option> tags.
function showselect($values, $current=null, $commaSeparated=0){
	$result='';
	foreach($values as $key=>$value){
		if($key&&$value){
			$result.="<option value='{$key}' ".show_selected($key, $current, $commaSeparated)." >{$value}</option>";
		}
	}
	return $result;	//return full list
}

//The function read_csv() is used to open CSV file in read mode. Currently is not using
function read_csv($filename, $break) {
	if ( $file=fopen($filename,"r") ) {
		while ($content[]=fgetcsv($file,1024,$break));
		fclose($file);
		array_pop($content);
		return $content;
	}
}

//The function prndate() return the date in customized format with second if DATE is valid, return '---' if not a valid DATE.
function prndates($date){ // Dev Tech : 23-01-02
	if($date=='0000-00-00 00:00:00')return '---';
	else return date('m/d/y H:i:s', strtotime($date));
}

//The function prndate() return the date in customized format if DATE is valid, return '---' if not a valid DATE.
function prndate($date){
	global $data;
	//$date=str_replace("PM","",$date); $date=str_replace("AM","",$date);
	if($date=='0000-00-00 00:00:00')return '---';
	else return date($data['DateFormat'], strtotime($date));
}

//The function prndatelog() return the date in customized format if DATE is valid, return '---' if not a valid DATE.
function prndatelog($date){
	global $data;
	$date=str_replace("PM","",$date);	//remove AM from date
	$date=str_replace("AM","",$date);	//remove PM from date
	if($date=='0000-00-00 00:00:00')return '---';
	else return date($data['DateFormat'], strtotime($date));
}

//The function prnintg() is used to return numeric value with zero (0) decimal point.
function prnintg($number){
	return number_format($number, 0, '', ',');
}

//The function prnsum() is used to return numeric value without comma (,).
function prnsum($sum){
	return (float)str_replace(",", "", $sum);	//remove comma(s)
}

//The function prnsum2() is used to return numeric value with two (2) decimal point and without comma (,).
function prnsum2($amount=0){
	$amount = trim($amount);
	if(empty($amount) || $amount==NULL) $amount = 0;
	$amount=preg_replace("/[^0-9\.-]/", '', $amount);
	if (is_numeric($amount)) return number_format($amount, 2, '.', '');		//return amount
	return 0;	//return null
}

//The function prnsumm() is used to return numeric value with defined $data['CurrSize'] decimal point and with comma (,).
function prnsumm($summ,$type=0){
	global $data;
	$summ=(float)str_replace(",", "", $summ); 	//remove comma(s)
	return number_format(($summ>0?$summ:-$summ), $data['CurrSize'], '.', ',');
}

//The function prnsumm_two() is used to return numeric value without comma (,).
function prnsumm_two($summ){
	global $data;
	$summ=str_replace(",", "", $summ); 	//remove comma(s)
	$summn = $summ>0?$summ:-$summ;
	return $summn;	//return numeric value
}

//The function prnpays() return value in RED color if value is negative, return in GREEN, if the value zero or positive with Currency name.
function prnpays($summ, $splus=true){
	global $data;
	if($summ<0)$color='red';else $color='green';
	return
		"<font color='{$color}'>".
		($summ>=0?($splus?'+':''):'-').$data['Currency'].prnsumm($summ).
		'</font>'
	;
}

//The function trprnpays() return value in RED color if value is negative, return in GREEN, if the value zero or positive with +/- Symbol
function trprnpays($summ, $splus=true){
	global $data;
	if($summ<0)$color='red';else $color='green';
	return
		"<font color='{$color}'>".
		($summ>=0?($splus?'+':''):'-').prnsumm($summ).
		'</font>'
	;
}

function prnpays_crncy($summ, $account_type='', $uid='',$currname=''){
	global $data;
	$currency="";
	$pro_curre=$currname;
	if(!empty($pro_curre)){$pro_curres=explode(' ',$pro_curre);
		if(isset($pro_curre) && strpos($pro_curre," ")!==false){$currency=get_currency($pro_curres[1]);}
		else{$currency=get_currency($currname);}
	}
	if($summ<0)$color='red';else $color='green';
	return
		"<font color='{$color}'>".
		($summ>=0?(!empty($splus)?'+':''):'-').$currency.prnsumm($summ,$account_type).
		'</font>';
}

function prnpays_crncy2($summ, $currname=''){
	global $data;
	$currency="";
	$pro_curre=$currname;
	if(!empty($pro_curre)){$pro_curres=explode(' ',$pro_curre);
		if(isset($pro_curre) && isset($pro_curres[1]) && strpos($pro_curre," ")!==false){$currency=get_currency($pro_curres[1]);}
		else{$currency=get_currency($currname);}
	}
	if($summ<0)$color='red';else $color='green';
	return
		"<font color='{$color}'>".
		($summ>=0?'':'-').$currency.prnsumm($summ).
		'</font>';
}

//The function prnpays_fee() return value in RED color if value is not equal to ZERO with Currency and +/- Symbol. Return --- in MAROON color if value is ZERO (0).
function prnpays_fee($summ, $splus=true){
	global $data;
	if($summ!=0)
	{
		$color='red';
		return
			"<font color='{$color}'>".
			($summ>=0?($splus?'+':''):'-').$data['Currency'].prnsumm($summ).
			'</font>'
		;
	}
	else
	{
		$color='maroon';
		return "<font color='{$color}'>---</font>";
	}
}

//The function prnfees() return value in RED color if value is not equal to ZERO with Currency and +/- Symbol. Return --- in MAROON color if value is ZERO (0). 
function prnfees($summ){
	return $summ!=0?prnpays($summ):'<font color=maroon>---</font>';
}

//The function balance() return value in RED color if value is not equal to ZERO with Currency and +/- Symbol. Return --- in MAROON color if value is ZERO (0). 
function balance($summ){
	return prnpays($summ, false);
}

//The function prnuser() is used to return username if exists, else return system (callback case).
function prnuser($uid){
	if($uid>0)return get_clients_username($uid);
	else return 'system';
}

//The function get_files_list() is used to fetch the all image list from a folder/directory.
function get_files_list($path){
	$result=array();
	if(@file_exists($path)){
		$handle=@opendir($path);
		while(($file=@readdir($handle))!==false){
			if($file!='.'&&$file!='..'){
				$x=strtolower(substr($file, -4));	//retrive file extension
				if($x&&$x=='.jpg'||$x=='.gif'||$x=='.png')
					$result[]="{$file}";	//if file type is image then store in $result array
			}
		}
	}
	return $result;	//return image list
}

//The function get_html_templates() is used to return template name.
function get_html_templates(){
	global $data;
	$result=array('0'=>'--');
	if(@file_exists($data['Templates']."/langs/default")){
		$handle=@opendir($data['Templates']."/langs/default");
		while(($file=@readdir($handle))!==false){
			if($file!='.'&&$file!='..'){
				$x=strtolower(substr($file, -4));
				if($x&&$x==$data['iex']){$result[$file]="{$file}";}else{
					$handle_mem=@opendir($data['Templates']."/langs/default/".$file);
					while(($file_mem=@readdir($handle_mem))!==false){
						if($file_mem!='.'&&$file_mem!='..'){
							$x_mem=strtolower(substr($file_mem, -4));
							if($x_mem&&$x_mem==$data['iex'])$result[$file."/".$file_mem]="{$file}/{$file_mem}";
						}
					}
				}
			}
		}
	}
	return $result;		//return template
}

//The function1() is used to send request via curl and received response.
function function1($siteUrl,$formPath,$resultUrl,$name,$price_string,$btc,$description,$type,$style,$price_currency_iso,$custom) {
	$userAgent = 'Mozilla/5.0 (Windows NT 5.1; rv:22.0) Gecko/20100101 Firefox/22.0'; //fetch user agent
	$sessPath = ini_get('session.save_path'); 		//set session path
	$ckfile	= tempnam ($sessPath, "CURLCOOKIE");	//Creates a file with a unique filename, with access permission set to 0600, in the specified directory/path.

	$ch = curl_init();	//Initializes a new session and return a cURL handle.
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);	//Curl verifies whether the certificate is authentic. false to stop cURL from verifying the peer's certificate. 
	curl_setopt($ch, CURLOPT_URL, $siteUrl.$formPath);	//The string pointed to in the CURLOPT_URL argument is expected to be a sequence of characters using an ASCII compatible encoding.
	curl_setopt($ch, CURLOPT_POST, true);	//true to do a regular HTTP POST. CURLOPT_POST to 0, libcurl resets the request type to the default to disable the POST
	curl_setopt($ch, CURLOPT_POSTFIELDS,'button[name]='.$name.'&button[price_string]='.$price_string.'&button[btc]='.$btc.'&button[description]='.$description.'&button[type]='.$type.'&button[style]='.$style.'&button[price_currency_iso]='.$price_currency_iso.'&button[custom]='.$custom);	// Set the full data to post in a HTTP "POST" operation.
	curl_setopt($ch, CURLOPT_REFERER, $siteUrl.$resultUrl);	// The contents of the "Referer: " header to be used in a HTTP request. 
	curl_setopt($ch, CURLOPT_COOKIESESSION, TRUE);	//Session cookies are cookies without expiry date
	curl_setopt($ch, CURLOPT_COOKIEJAR, $ckfile);	//file name to store cookies to. Synopsis. #include <curl/curl.h> 
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);	// true to return the transfer as a string of the return value of curl_exec() instead of outputting it directly. 
	curl_setopt($ch, CURLOPT_HEADER, true);			// true to include the header in the output. 
	curl_setopt($ch, CURLOPT_USERAGENT, $userAgent);	//CURLOPT_USERAGENT, The contents of the "User-Agent: " header to be used in a HTTP request. CURLOPT_USERNAME, The user name to use in authentication.
	$output = curl_exec($ch);	//Execute the curl request. 
	curl_close($ch);	//close curl execution



	$ch = curl_init();	//Initializes a new session and return a cURL handle.
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);	//Curl verifies whether the certificate is authentic. false to stop cURL from verifying the peer's certificate.
	curl_setopt($ch, CURLOPT_URL, $siteUrl.$resultUrl);	//The string pointed to in the CURLOPT_URL argument is expected to be a sequence of characters using an ASCII compatible encoding.
	curl_setopt($ch, CURLOPT_POST, 1);	//true to do a regular HTTP POST. CURLOPT_POST to 0, libcurl resets the request type to the default to disable the POST
	curl_setopt($ch, CURLOPT_POSTFIELDS,'button[name]='.$name.'&button[price_string]='.$price_string.'&button[btc]='.$btc.'&button[description]='.$description.'&button[type]='.$type.'&button[style]='.$style.'&button[price_currency_iso]='.$price_currency_iso.'&button[custom]='.$custom);
	curl_setopt($ch, CURLOPT_REFERER, $siteUrl.$resultUrl);	// Set the full data to post in a HTTP "POST" operation.
	curl_setopt($ch, CURLOPT_COOKIEFILE, $ckfile);	//file name to store cookies to. Synopsis. #include <curl/curl.h> 
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);	// true to return the transfer as a string of the return value of curl_exec() instead of outputting it directly. 
	curl_setopt($ch, CURLOPT_HEADER, true);		// true to include the header in the output or false header not required.
	curl_setopt($ch, CURLOPT_USERAGENT, $userAgent);	//CURLOPT_USERAGENT, The contents of the "User-Agent: " header to be used in a HTTP request. CURLOPT_USERNAME, The user name to use in authentication.
	$output = curl_exec($ch);	//Execute the curl request. 
	/*echo "<pre>";
										print_r($output);
										echo "</pre>pre>";
										exit;*/
	//$id=substr($output,710,32);
	$r	= explode('button', $output);	//string to array
	$r1 = explode('"',$r[1]);			//string to array
	return $r1[4];						//return 4th element from the array $r1
	unset($ch);							//unset curl handle
	unlink($ckfile);					//unlink cookie file
}



//The function create_confirmation() is used to insert new user data in confirms table and send a confirmation e-mail. 
function create_confirmation($newuser,$newmail,$newfullname,$sponsor=0,$sub_sponsor=0,$newpass='')
{
	global $data;
	$confirm=gencode();	//to generate a unique code
	$sponsor=($sponsor?$sponsor:0);
	
	if($newpass) $newpass_hash=hash_f($newpass);	//encrypts password via hash
	
	$enc_newmail=encrypts_decrypts_emails($newmail,1);	//encrypt the email
	
	//	newuser   newmail   newfullname   sponsor   confirm  created_date     	
	//insert new user data in confirms table
	db_query(
		"INSERT INTO `{$data['DbPrefix']}unregistered_clientid`(".
		"`newuser`,`newmail`,`newfullname`, `sponsor`,`confirm`".
		")VALUES(".
			"'{$newuser}','{$enc_newmail}','{$newfullname}','{$sponsor}','{$confirm}'".
		")",0
	);
	$newid=newid();	//fetch newly added id
	
	//create post array 
	$post['tableid']=$newid;
	$post['mail_type']="13";
	$post['email_header']=1;
	$post['email_br']=1;
	
	//$post['ccode']=$confirm;
	$post['ccode']=encryptres($confirm); //encrypt_res
	$post['email']=$newmail;
	$post['fullname']=$newfullname;
	$post['email_he_on']=1;
	//$post['enc_mail']="{$data['USER_FOLDER']}/confirm{$data['ex']}?cid=".get_encrypted_value($enc_newmail);
	//$post['password']=$newpass;
	$post['username']=$newuser;
	//$post['chash']=strtoupper(md5($post['ccode'].'|'.$post['email']));
	$post['chash']=encryptres($confirm); //encrypt_res
	
	if($newid){
		send_email('CONFIRM-TO-MEMBER', $post);	//send email
	}
	return $newid; // return id of new added data
}

//The function create_confirmation_email_reg() is used to send a confirmation e-mail
function create_confirmation_email_reg($newmail,$newresult ){
	global $data;
	$post['ccode']=$newresult;
	$post['email']=$newmail;
	$post['chash']=strtoupper(md5($post['ccode'].'|'.$post['email']));
	send_email('CONFIRM-TO-MEMBER', $post);	//send email
}

//This function currently in not using. Note: Using twice in confirm.do page but commented.
function select_confirmation($ccode, $email, $chash=''){
	global $data;
	if(isset($chash)&&!empty($chash)){
		$query="WHERE(`confirm` = '".trim(decrypt_res($chash))."')";
		//$query="WHERE MD5(CONCAT(`confirm`,'|',`newmail`))='{$chash}'";
	}else{
		$query="WHERE(`confirm` = '".trim(decrypt_res($ccode))."' AND `newmail`='{$email}')";
		//$query="WHERE(`confirm`='{$ccode}' AND `newmail`='{$email}')";
	}
	$confirm=db_rows(
		"SELECT `id` FROM `{$data['DbPrefix']}unregistered_clientid` {$query} LIMIT 1"
	);
	return $confirm[0]['id'];	//return id if available
}

//The function select_confirmation_new() is used to fetch table id data from confirms table via ccode.
function select_confirmation_new($ccode){
	global $data;
	$query="WHERE (`confirm` = '".trim(decryptres($ccode))."')";

	//fetch id
	$confirm=db_rows(
		"SELECT `id` FROM `{$data['DbPrefix']}unregistered_clientid` {$query} LIMIT 1"
	);
	return @$confirm[0]['id'];	//return id if available
}

//This function currently is not using
function select_email_confirmation($ccode, $email, $chash=''){
	global $data;
	if(isset($chash)&&!empty($chash)){
		$query="WHERE MD5(CONCAT(`confirm`,'|',`email`))='{$chash}'";
	}else{
		$query="WHERE(`confirm`='{$ccode}' AND `email`='{$email}')";
	}
	$confirm=db_rows(
		"SELECT `id` FROM `{$data['DbPrefix']}clientid_emails` {$query} LIMIT 1"
	);
	return $confirm[0]['id'];
}


//The clients_page_permission() is used to check clients roll
function clients_page_permission($getkey,$sesrole,$sesmemtype){
$groles=explode(',',$sesrole);
	if(((in_array($getkey, $groles)) && (isset($_SESSION['m_clients_type'])&&$_SESSION['m_clients_type']=='Sub Member')) || (!isset($_SESSION['m_clients_type'])||$_SESSION['m_clients_type']=='')){
		return true;		//return true if roll define
	}else{
		return false;		//return false
	}
}

//The use of get_clients_id() to fetch clients id via username
function get_clients_id($username, $password='', $where='', $userId=false,$tbl='clientid_table'){
	global $data; $qp=0;
	$where_pred="";
	if($userId){
		$where_pred=" OR `id`='{$username}' ";
	}
	$turl= $_SERVER['REQUEST_URI'];
	
	//fetch id from the clients table
	$result=db_rows(
		"SELECT `id` FROM `{$data['DbPrefix']}{$tbl}`".
		" WHERE (`username`='{$username}')".$where_pred.
		//" WHERE (`username`='{$username}' OR `email`='{$username}')".$where_pred.
		($password?" AND `password`='{$password}'":'').
		($where?" AND $where":'')." LIMIT 1",$qp
	);
	

	if($result&&($password||$where)){
		//fetch id from table via password
		$result=db_rows(
			"SELECT `id` FROM `{$data['DbPrefix']}{$tbl}`".
			" WHERE `id`='".$result[0]['id']."'".
			 ($password?" AND `password`='{$password}'":'').
			 ($where?" AND $where":'')." LIMIT 1",$qp
		);
	}
	if(isset($result[0]['id']) && $result[0]['id'])
		return $result[0]['id'];	//return id
	else 
		return 0;	//return 0 or null if records not match/exist
}


//The get_clients_email() is used to fetch email id from clientid_emails table of a merchant.
function get_clients_email($uid, $primary=false, $confirmed=true){
	global $data;
	
	//fetch data from clientid_emails
	$result=db_rows(
		"SELECT `email` FROM `{$data['DbPrefix']}clientid_emails`".
		" WHERE `clientid`='{$uid}'".
		($primary?" AND `primary`='{$primary}'":'').
		($confirmed?" AND `active`='{$confirmed}'":'').
		" ORDER BY `primary` DESC"
	);
	//return $result[0]['email'];
	if(isset($result[0]['email'])&&$result[0]['email'])
		return encrypts_decrypts_emails($result[0]['email'],2);		//return decrypted email
	else return ;	//return null if not found
}

//This function currently is not using
function count_clients_emails($uid, $primary=false, $confirmed=true) {
	global $data;
	$result=db_rows(
		"SELECT COUNT(`email`) AS `count`".
		" FROM `{$data['DbPrefix']}clientid_emails`".
		" WHERE `clientid`='{$uid}'".
		($primary?" AND `primary`='{$primary}'":'').
		($confirmed?" AND `active`='{$confirmed}'":'').
		" LIMIT 1"
	);
	if(isset($result[0])) return $result[0]['count']; 
	else return 0;
}

//The get_email_details() used to fetch all details from clientid_emails table of a clients
function get_email_details($uid, $primary=false, $confirmed=true){
	global $data;
	
	//to fetch all details from clientid_emails table of a clients
	$result=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}clientid_emails`".
		" WHERE `clientid`='{$uid}'".
		($primary?" AND `primary`='{$primary}'":'').
		($confirmed?" AND `active`='{$confirmed}'":'')
	);
	return $result;	//return all detail in array
}

//The use of prnclientsemails() return email list with mailto link
function prnclientsemails($uid) {
	global $data;
	$str_add="";
	
	//fetch data from clientid_emails, order by primary
	$result=db_rows(
		"SELECT `email` FROM `{$data['DbPrefix']}clientid_emails`".
		" WHERE `clientid`='{$uid}' AND `active`='1'".
		" ORDER BY `primary` DESC",0
	);
	foreach($result as $key=>$value) {
		$mailto = encrypts_decrypts_emails($result[$key]['email'], 2);	//decrypts email
		
		$str_add .= "<a href=mailto:{$mailto}> {$mailto}</a>"."<br>";	//create link to email send
	}
	return $str_add;	//return email list
}

/* Users emails functions */
//This function used to add new email in clientid_emails table
function add_email($uid,$email,$admin=false){
	global $data;
	$max_email=$data['maxemails'];$active=0;
	$nb_emails=count_clients_emails($uid,false,false);	//fetch total number of emails

	if($admin){$active=1;}
	
	if($nb_emails >= $max_email) return 'TOO_MANY_EMAILS';
	elseif(verify_email($email)) return 'INVALID_EMAIL_ADDRESS';
//	elseif(email_exists($email)) return 'EMAIL_EXISTS';
	else {
		$verifcode=gencode($email);	//to generate a unique code

		//insert data into clientid_emails tbl
		$result=db_query(
			"INSERT INTO `{$data['DbPrefix']}clientid_emails`".
			"(`clientid`,`email`,`active`,`primary`,`verifcode`) VALUES ".
			"($uid,'".encrypts_decrypts_emails($email, 1)."',{$active},0,'{$verifcode}')",0
		);
		$lastid=newid();	//last inserted id
		json_log_upd($lastid,'clientid_emails','Update');		//update json log history
		
		$verifcode_arr=[];
		$verifcode_arr['c']	=$verifcode;				//verification code
		$verifcode_arr['u']	=$uid;						//clients id
		$verifcode_arr['id']=$lastid;					//last inserted id
		$verifcode_en		=jsonencode($verifcode_arr);//convert into json
		$verifcode_encode	=encode_f($verifcode_en,0);	//encode json string
	
		if ($lastid==0) return 'DB_ERROR';
		if ($result){
			$info=get_clients_info($uid);			//fetch clients's information
			
			//create array for email template
			$post['email']=$email;
			$post['fullname']=get_clients_name($uid);//clients full name
			//$post['ccode']=$verifcode;
			$post['ccode']	=$verifcode_encode;
			$post['uid']	=$uid;
			$post['clientid']	=$uid;
			$post['password']=$info['password'];	//password
			$post['username']=$info['username'];	//username
			$post['email_he_on']=1;					//email header on
			//$post['emailpage'];
			send_email('CONFIRM-NEW-EMAIL',$post);	//send new confirmation email
			$_SESSION['token_email'] = md5(uniqid(rand(), TRUE));
			$_SESSION['token_email_time'] = time();
			return 'SUCCESS';
		}
	}
}

//The activate_email() is used to activate email and send email after activate
function activate_email($uid, $verifcode, $where_cond=''){
	global $data;
	$post['clientid']= $uid;

	//fetch data from clientid_emails
	$confirm=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}clientid_emails` WHERE `clientid`='$uid' AND `verifcode`='$verifcode' AND `active`='0' {$where_cond} ");

	//if data not exists then return not found
	if (!isset($confirm[0])) return 'CONFIRMATION_NOT_FOUND';

	//activate email id
	db_query("UPDATE `{$data['DbPrefix']}clientid_emails` SET `active`=1 WHERE `clientid`='{$uid}' AND `verifcode`='{$verifcode}' {$where_cond} ");
//	$info=get_clients_info($uid);

	$post['registered_email']= encrypts_decrypts_emails($confirm[0]['registered_email'],2);	//decrypt email id
	$post['fullname']=get_clients_name($uid);	//clients's full name
	send_email('NEW-EMAIL-ACTIVATED',$post);	//send email after activatioin
	return 'SUCCESS';	//return success
}

//The get_email_detail() is used to fetch detail from clientid_emails
function get_email_detail($eid, $type='ALL'){
	global $data;
	if ($type=='CONFIRMED') {	//if type is CONFIRMED, then fetch only if email activated
		$result=db_rows("SELECT * FROM {$data['DbPrefix']}clientid_emails WHERE `id`='$eid' AND `active`=1");
	}
	else{ //fetch all emails
		$result=db_rows("SELECT * FROM {$data['DbPrefix']}clientid_emails WHERE `id`='$eid'");
	}
	if(isset($result[0])) return $result[0];	//return email detail

	return false;
}

//The delete_clients_email() is used to delete an email from clientid_emails. Delete only non-primary email
function delete_clients_email($uid, $eid){
	global $data;
	if($eid)
	{
		//fetch email data
		$result=db_rows("SELECT * FROM {$data['DbPrefix']}clientid_emails WHERE `id`='$eid'");

		if(!isset($result[0])) return 'EMAIL_NOT_FOUND';	//if no record found then return

		$email = encrypts_decrypts_emails($result[0]['email'],2);	//decrypted email

		if(verify_email($email)) return 'INVALID_EMAIL_ADDRESS';	//check email validation

		$todel=get_email_detail($eid);		//fetch email detai
	
		if(!$todel) return 'EMAIL_NOT_FOUND';	//if no record found then return
		elseif($todel['primary']) return 'CANNOT_DELETE_PRIMARY';	//if email is primary then can't del
		else{
			$data['JSON_INSERT']=1;
			json_log_upd($eid,'clientid_emails','Delete',$result,$uid);	//update log before delete
			
			$qrs=db_query("DELETE FROM {$data['DbPrefix']}clientid_emails WHERE `clientid`='{$uid}' AND `id`='{$eid}'");	//delete email id
	
	//		deleted_profile_email($uid,$email);
			deleted_profile_email($uid,$result[0]['registered_email']);	//delete email from clients profile
	
			if($qrs){
				$_SESSION['token_email'] = md5(uniqid(rand(), TRUE));
				$_SESSION['token_email_time'] = time();
				return 'SUCCESS';
			}
		}
	}
}

//This function currently is not using
function email_exists($email){
	global $data;
	$result=db_rows("SELECT clientid FROM {$data['DbPrefix']}clientid_emails WHERE email='{$email}'");
	return (bool)$result['0'];	
}

//The use of get_access_admin_role() to return merchant access roles/permission
function get_access_admin_role($admin_access_id){
	global $data; 
	
	//fetch data from access_roles table via id
	$subad_access_level=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}access_roles`".
		" WHERE `id`='{$admin_access_id}'"
	);
	$result=array();
	foreach($subad_access_level as $key=>$value){
		
		$result[$key]=$value;
		
		if($value['merchant_access_all']==1){
			$result[$key]['merchantAccess']='M. All';		//merchant all access
		}elseif($value['merchant_access_multiple']==1){
			$result[$key]['merchantAccess']='M. Multiple';	//merchant multiple access
		}elseif($value['merchant_access_individual']==1){
			$result[$key]['merchantAccess']='M. Individual';//merchant Individual access only
		}
		
		if($value['subadmin_access_all']==1){
			$result[$key]['subAdminAccess']='G. All';		//subAdmin all access
		}elseif($value['subadmin_access_multiple']==1){
			$result[$key]['subAdminAccess']='G. Multiple';	//subAdmin multiple access
		}elseif($value['subadmin_access_individual']==1){
			$result[$key]['subAdminAccess']='G. Individual';//subAdmin Individual access only
		}
		//$result[$key]['id']=$value['id'];
	}
	return $result;
}

//The uniqueValue() used to filter/fetch uniquie value ofrm an array or string
function uniqueValue($value,$delimiter=',',$retrunArray=0){
	$result=array();
	if($delimiter){
		$value = explode($delimiter,$value);	//string to array via delimiter
		$value = array_unique($value);			//returns a new array without duplicate values	
		$value = array_filter($value);			//Returns the filtered array
		//sort($value);
		rsort($value);							//sorts in descending order
		if($retrunArray){
			$result['v']=$value;
		}else{
			$result['v']=implodes($delimiter,$value);	//returns a string from the elements of an array.
		}
		$result['c']=count($value);	//returns the number of elements in an array ($value).
	}
	return $result;	//return array
}

//The get_ip_history() is used to get full login of a clients or subadmin
function get_ip_history($uid, $order='', $type="", $limit=''){
	global $data;
	$qrs="";
	if($type==1){ $qrs=" AND `subadmin_id` <= 0 "; }
	// Added for display history with limit added by vikash on 221022
	if(isset($limit)&&$limit){ 
		$limit=" LIMIT 0, $limit ";
		$limit=query_limit_return($limit);
	}
	
	//fetch data from visits table
	$result=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}login_ip_history`".
		" WHERE `clientid`='{$uid}' $qrs ".($order?" ORDER BY `{$order}`":'ORDER BY `date` DESC'.$limit),0
	);
	return $result;	//return full history
}
//This function is used to shows social icons
function get_ims_icon($icon){
	$result='';
	if($icon=='Skype'){ $result='<i class="fa-brands fa-skype text-info fa-fade" title="Skype"></i>'; 
	}elseif($icon=='Telegram'){ $result='<i class="fa-brands fa-telegram text-info fa-fade" title="Telegram"></i>';
	}elseif($icon=='WhatsApp'){ $result='<i class="fa-brands fa-whatsapp text-success fa-fade" title="WhatsApp"></i>';
	}else{}

	return $result;	//return
}
// user confirm registration	
function delete_unreg_clients_pay($id) {
	global $data;
	db_query(
                "DELETE FROM `{$data['DbPrefix']}unreg_clients_pays`".
                " WHERE `id`='{$id}'"
        );
}
// user confirm registration
function update_unreg_clients_pays($receiver) {
	global $data;
	// purge older than 10 days
	db_query(
		"DELETE FROM `{$data['DbPrefix']}temp_pays`".
		" WHERE(TO_DAYS(NOW())-TO_DAYS(`tdate`)>=10 AND `status`=0)"
	);
	$receiver_email=get_clients_email($receiver);
	$pending=db_rows("SELECT *". 
" FROM `{$data['DbPrefix']}temp_pays` WHERE(`receiver`='{$receiver_email}' AND `status`=0)"	
	);
	$pending=$pending[0];
	foreach($pending as $key=>$value){
		$pending[$key] = @addslashes($value);
	}
	$fees=($pending['amount']*$data['PaymentPercent']/100)+$data['PaymentFees'];
	transaction($pending['sender'], $receiver, $pending['amount'], $fees,0,1, $pending['comments']);
	db_query(
                "UPDATE `{$data['DbPrefix']}temp_pays`".
                " SET `status`=1".
                " WHERE `receiver`='{$receiver_email}'"
        );
	//TO DO: email confirmation to sender
	$post['fees']=$fees;
	$post['email']=get_clients_email($pending['receiver']);
	$post['amount']=$pending['amount'];
	$post['sender']=$pending['sender'];
	send_email('PAY-FROM-UNREGMEM-ACCEPTED', $post);	//done
	// delete old completed transactions in table temp_pays?? or not?
}

/// user confirm registration
function get_unreg_clients_pay($uid, $which='SENDER', $status=0) {
	global $data;
	if($which=='RECEIVER') $receiver=get_clients_email($uid);
	
	$trans=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}temp_pays`".
		($which=='RECEIVER'?" WHERE `receiver`='{$receiver}' AND `status`='{$status}' ":
		" WHERE `sender`='{$uid}' AND `status`='{$status}' ")
	);
	$result=array();
	foreach($trans as $key=>$value){
		$result[$key]['id']=$value['id'];
		$result[$key]['receiver']=$value['receiver'];
		$result[$key]['sender']=$value['sender'];
		$result[$key]['recvuser']=prnuser($value['receiver']);
		$result[$key]['amount']=prnpays($value['amount']);
		$result[$key]['tdate']=prndate($value['tdate']);
		$result[$key]['comments']=prntext($value['comments']);
	}
	return $result;
}
//This function is used to delete block clients data from login_attempts table
function block_clients($uid){
	global $data;
	db_query(
		"DELETE FROM `{$data['DbPrefix']}login_attempts` WHERE `id`='{$uid}'"
	);
}
//This function is used to fetch all block clients list
function get_ipaddress_list(){
	global $data;
	//select data from login_attempts table (block clients due to invalid password attempt)
	$login_attempts=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}login_attempts`"
	);
	return $login_attempts;	//return clients' list
}
//This function is used to fetch roles list 
function get_roles_list($sid=0){
	global $data;
	//fetch access roles of a subadmin or all
	$roles=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}access_roles`".
		($sid?" WHERE `id`='{$sid}' LIMIT 1":""),0
	);
	return $roles;	//return roles list
}
//This function is used to fetch subadmin list
function get_subadmin_list($where_pred=''){
	global $data;
	//fetch data from subadmin table
	$subadmin=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}subadmin` ".$where_pred
	);
	return $subadmin;	//return subadmin list
}
//This function is used to fetch detail of assgin access roles
function get_edit_roles_list($id,$insert=0){
	global $data;
	//fetch detail of assgin access roles
	$accessroles=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}access_roles` ".
		($insert?" LIMIT 1 ":" WHERE `id`='$id' "),0
	);
	return $accessroles;
}

//This function is used to fetch detail of a subadmin
function get_edit_subadmin_list($id){
	global $data;
	$subadmin=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}subadmin` where `id`='$id'"
	);
	return $subadmin;
}

// function work because query is not correct 
function save_remote_ip($uid, $address, $mid="", $ref=""){
	global $data;
	if($ref=="")$ref=$_SERVER['HTTP_REFERER'];
	db_query(
		"INSERT `{$data['DbPrefix']}login_ip_history`(`clientid`,`date`,`address`,`subadmin_id`,`source_url`".
		")VALUES({$uid},'".date('Y-m-d H:i:s')."','{$address}','{$mid}','{$ref}')"
	);
}
function insert_email_info($email, $uid, $notify=true){
	global $data;
	db_query(
		"INSERT INTO `{$data['DbPrefix']}clientid_emails`(".
		"`clientid`,`email`,`status`".
		")VALUES(".
		"{$uid},'".encrypts_decrypts_emails($email,1)."',0)"
	);
	if($notify)send_email_request(newid());
	return newid();
}
function delete_email_info($gid,$tid=''){
	global $data;
	$delemail = "";

	if(!empty($tid)){
		$delemail=" AND `id`='{$tid}'";

		$emails=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}clientid_emails`".
			" WHERE `clientid`='{$gid}' ".$delemail." LIMIT 1",0
		);
		if(isset($emails[0])&&$emails[0]) $emailnew=encrypts_decrypts_emails($emails[0]['email'],2);
	}

	$data['JSON_INSERT']=1;
	json_log_upd($tid,'clientid_emails','Delete',$emails,$gid);	//update json log history

	$sqlStmt =	"DELETE FROM `{$data['DbPrefix']}clientid_emails`".
				" WHERE `clientid`='{$gid}' ".$delemail."";
		
	db_query($sqlStmt);
	if($data['affected_rows'])
	{
		deleted_profile_email($gid,$emailnew); 
	}
}
function send_email_request($gid,$email='', $eid=0){
	global $data;
	
	if(!empty($eid)){$email=" AND `id`='{$eid}'";}
	elseif(!empty($email)){$email=" AND `email`='{$email}'";}
	$emails=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}clientid_emails`".
		" WHERE `clientid`='{$gid}' ".$email." LIMIT 1",0
	);
	if(isset($emails[0])&&$emails[0]){
		$post['ccode']=gencode();
		db_query(
			 "UPDATE `{$data['DbPrefix']}clientid_emails`".
			 " SET `verifcode`='{$post['ccode']}', `active`=1".
			 " WHERE `clientid`='{$gid}' ".$email." ",0
		);
		$post['email']=$emails[0]['email'];
		//send_email('CONFIRM-EMAIL', $post);
	}
	//exit;
}

function insert_card_info($post, $uid, $notify=true){
	global $data;
	$cnumber=card_encrypts256($post['cnumber']);
	$post['clientid']= $uid;
	db_query(
			"INSERT INTO `{$data['DbPrefix']}cards`(".
			"`clientid`,`ctype`,`cname`,`cnumber`,`cmonth`,`cyear`,".
			"`status`,`default`".
			")VALUES(".
			"{$uid},'{$post['ctype']}','{$post['cname']}',".
			"'{$cnumber}',".
			"{$post['cmonth']},{$post['cyear']},".
			"0,0)"
	);
	if($notify){
			$post['clientid']=($uid);
			$post['email']=get_clients_email($uid);
			send_email('UPDATE-CARD-INFORMATION', $post);	//done
	}
	return newid();
}
function update_card_info($post, $gid, $uid, $notify=true){
	global $data;
	//$cnumber=(is_changed($post['cnumber']))?"`cnumber`='{$post['cnumber']}',":'';
	$cnumber=(card_decrypts256($post['cnumber']))?"`cnumber`='{$post['cnumber']}',":'';
	$post['clientid']= $uid;
	db_query(
			"UPDATE `{$data['DbPrefix']}cards` SET ".
			"`ctype`='{$post['ctype']}',`cname`='{$post['cname']}',".
			"{$cnumber}".
			"`cmonth`='{$post['cmonth']}',`cyear`='{$post['cyear']}'".
			" WHERE `id`='{$gid}'"
	);
	if($notify){
			$post['clientid']=($uid);
			$post['email']=get_clients_email($uid);
			send_email('UPDATE-CARD-INFORMATION', $post);	//done
	}
}
function delete_card($gid){
	global $data;
	db_query(
		"DELETE FROM `{$data['DbPrefix']}cards`".
		" WHERE `id`='{$gid}'"
	);
}
function select_cards($uid, $hiden=true, $id=0, $single=false){
	global $data;
	$cards=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}cards`".
		" WHERE `clientid`='{$uid}'".
		($id?" AND `id`='{$id}'":'').($single?" LIMIT 1":'')
	);
	$result=array();
	foreach($cards as $key=>$value){
		foreach($value as $name=>$v){
			$result[$key][$name]=$v;
			if($hiden){
				if($name=='cnumber') $result[$key][$name]=encode(card_decrypts256($v), 4);
				elseif($name=='ccvv') $result[$key][$name]=encode($v, 1);
			}
		}
	}
	return $result;
}

function delete_bank($gid, $primary=0){
	global $data; $result=[];

	//fetch data from banks tbl via $gid (table id)
	$select=db_rows(
			"SELECT `bank_doc`,`bank_account_primary`,`primary`,`status`,`baccount` FROM `{$data['DbPrefix']}banks`".
			" WHERE `id`='{$gid}' LIMIT 1",0);
	$select=$select[0];
	
	//update status (2 for delete), and set ZERO value in primary and bank_account_primary fields
	db_query(
		"UPDATE `{$data['DbPrefix']}banks` SET ".
		"`status`=2,`primary`=0,`bank_account_primary`=0 ".
		" WHERE `id`='{$gid}'",0
	);
	$result['success']='Your bank account ('.encode($select['baccount'],6).') has been successfully deleted!!!';
	affected_rows($data['affected_rows'], $result['success']); //show above message if record delete successfully, else show default message 

	json_log_upd($gid,'banks','Delete'); // For Manage Json Log File

	return $result;	
}
function delete_crpto($gid, $primary = 0)
{
	global $data;
	$result = [];
	
	//fetch data from coin_wallet tbl via $gid (table id)
	$select = db_rows(
		"SELECT * FROM `{$data['DbPrefix']}coin_wallet` WHERE `id`='{$gid}' LIMIT 1", 0
	);
	$select = $select[0];

	//update status (2 for delete), and set ZERO value in primary and bank_account_primary fields
	db_query(
		"UPDATE `{$data['DbPrefix']}coin_wallet` SET " .
			"`status`=2,`primary`=0,`bank_account_primary`=0 ".
			" WHERE `id`='{$gid}'",
		0
	);
	$result['success'] = 'Your crypto wallet (' . encode($select['coins_address'], 6) . ') has been successfully deleted!!!';
	
	affected_rows($data['affected_rows'], $result['success']); //show above message if record delete successfully, else show default message 
	json_log_upd($gid,'coin_wallet','Delete');// For Manage Json Log File

	return $result;
}
function delete_access_roles($id){
	global $data;
	$dresult=db_rows("SELECT * FROM `{$data['DbPrefix']}access_roles` WHERE `id`='{$id}'");
	$data['JSON_INSERT']=1;
	json_log_upd($id,'access_roles','Delete',$dresult,'');	//update json log history
	db_query(
		"DELETE FROM `{$data['DbPrefix']}access_roles`".
		" WHERE `id`='{$id}'"
	);
}
function delete_subadmin_roles($id){
	global $data;
	$dresult=db_rows("SELECT * FROM `{$data['DbPrefix']}subadmin` WHERE `id`='{$id}'");
	$data['JSON_INSERT']=1;
	json_log_upd($id,'subadmin','Delete',$dresult,'');	//update json log history
	db_query(
		"DELETE FROM `{$data['DbPrefix']}subadmin`".
		" WHERE `id`='{$id}'"
	);
}
function select_banks($uid, $id='', $single=false, $primary=false, $status=0, $tbl='banks'){
	global $data;
	
	if($id&&strpos($id,'c_')!==false){
		$tbl='coin_wallet';
		$id=str_replace('c_','',$id);
	}
	$banks=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}{$tbl}`".
			" WHERE `clientid`='{$uid}' AND `status` IN ({$status})".
			($id?" AND `id`='{$id}'":'').($single?" LIMIT 1":''),0
	);
	$result=array();
	foreach($banks as $key=>$value){
			foreach($value as $name=>$v)$result[$key][$name]=$v;
	}
	
	if($primary){
		return $banks[0]['primary'];
	}else{
		return $result;
	}
}
function select_coin_wallet($uid, $id=0, $single=false, $primary=false, $status=0)
{
	global $data;
	$banks = db_rows(
		"SELECT * FROM `{$data['DbPrefix']}coin_wallet`" .
			" WHERE `clientid`='{$uid}' AND `status` IN ({$status})" .
			($id ? " AND `id`='{$id}'" : '') . ($single ? " LIMIT 1" : '')
	);
	$result = array();
	foreach ($banks as $key => $value) {
		foreach ($value as $name => $v) $result[$key][$name] = $v;
	}

	if ($primary) {
		return $banks[0]['primary'];
	} else {
		return $result;
	}
}
function banks_primary($uid,$tbl='banks'){
	global $data;
	$banks=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}{$tbl}`".
		" WHERE `clientid`='{$uid}' AND `bank_account_primary`=1 AND `status` NOT IN (2)".
		" LIMIT 1",0
	);
	$result=array();
	if($banks&&isset($banks[0])){$result=$banks[0];}
	else{
		$banks=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}{$tbl}`".
			" WHERE `clientid`='{$uid}' AND `status` NOT IN (2) ".
			" ORDER BY `id` DESC LIMIT 1",0
		);
		if($banks&&isset($banks[0])){$result=$banks[0];}
		}
	return $result;
}

function get_status_color($status){
	$result='000000';
	switch($status){
		case 0:
			$result='blue';
		break;
		case 1:
			$result='green';
		break;
		case 2:
			$result='red';
		break;
		case 3:
			$result='maroon';
		break;
		case 4:
			$result='#800000';
		break;
		case 5:
			$result='#bb0808';
		break;
		case 6:
			$result='#b301b3';
		break;
		case 7:
			$result='#b301b3';
		break;
		case 8:
			$result='#0aa977';
		break;
		case 9:
			$result='#869a67';
		break;
		case 10:
			$result='blue';
		break;
		case 11:
			$result='#dc0000';
		break;
		case 12:
			$result='#773cbd';
		break;
		case 13:
			$result='#008000';
		break;
		case 14:
			$result='#008000';
		break;
		case 15:
			$result='#ff0000';
		break;
		case 16:
			$result='green';
		break;
		case 17:
			$result='red';
		break;
		case 18:
			$result='red';
		break;
		case 19:
			$result='red';
		break;
		case 20:
			$result='#da4f49';
		break;
		case 21:
			$result='#da4f49';
		break;
		case 22:
			$result='red';
		break;
		case 23:
			$result='red';
		break;
		case 24:
			$result='red';
		break;
	}
	return $result;
}

function update_status_bank($id, $where_pred, $tab="banks"){
	global $data;
	db_query(
		"UPDATE `{$data['DbPrefix']}{$tab}` SET {$where_pred}".
		" WHERE `id`='{$id}'"
	);

	affected_rows($data['affected_rows'], 'Updated successfully!!!');

	json_log_upd($id,$tab,'action');	//update json log history
}


#########################################################################
function get_mail_templates(){
	global $data;
	return db_rows("SELECT * FROM `{$data['DbPrefix']}emails_templates`");
}
function select_mail_template($key){
	global $data;
	$result=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}emails_templates`".
		" WHERE `key`='{$key}' LIMIT 1"
	);
	return $result[0];
}
function update_mail_template($key, $name, $value,$json_log=0){
	global $data;
	db_query(
		"UPDATE `{$data['DbPrefix']}emails_templates`".
		" SET `name`='".addslashes($name)."',`value`='".addslashes($value)."'".
		" WHERE `key`='{$key}'"
	);
	if($json_log==0){
		json_log_upd(0,'emails','update'); // for json log history
	}
}

#### DEL2 get_categories_tree ######################################

function unhtmlentities($text){
	$table=get_html_translation_table(HTML_ENTITIES);
	$table=array_flip($table);
	return strtr($text, $table);
}
###############################################################################
function encrypt_pages($content){
	$r="<NOSOURCE>";
	for($i=0;$i<255;$i++)$r.="\n";
	return $r.encrypt($content);
}
function encrypt($content){
	$xor=255;
	$table="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!0123456789-=@#$^&*()_+[]{};:,.<>|/";
	$table=array_keys(count_chars($table, 1));
	$i_min=min($table);
	$i_max=max($table);
	for($i=count($table);$i>0;$r=mt_rand(0, $i--)){
		array_splice($table, $r, $i-$r, array_reverse(array_slice($table, $r, $i-$r)));
	}
	$len=strlen($content);
	$word=$shift=$enc=0;
	for($i=0;$i<$len;$i++){
		$ch=$xor^ord($content[$i]);
		$word|=($ch<<$shift);
		$shift=($shift+2)%6;
		$enc.=chr($table[$word&0x3F]);
		$word>>=6;
		if(!$shift){
			$enc.=chr($table[$word]);
			$word>>=6;
		}
	}
	if($shift)$enc.=chr($table[$word]);
	for($i=$i_min;$i<$i_max-$i_min+1+$i_min;$i++)$tbl[$i]=0;
	//while(list($k,$v) = each($table))$tbl[$v]=$k;
	$tbl=urlencode(implodes(",", $tbl));
	$enc=urlencode($enc);
	return "<script type=text/javascript language=JavaScript>$enc</script>"; 
}
###############################################################################

function generate_pin_code(){
	$code=str_split(strrev(md5(microtime())));
	$index=0;$key='';
	foreach($code as $value){
		if((int)$value>0){
			$key.=$value;
			if($index==3){
				$key.='-';
				$index=0;
			}
			$index++;
		}
	}
	$key=substr($key, 0, 14);
	if(strlen($key)<14)$key.=strrev(substr($key, 0, 14-strlen($key)));
	return $key;
}

function insert_subadmin_info($post){
	global $data;$account_curr="";
	$qprint=0;
	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==insert_subadmin_info==><hr/>";
	}
	$password=hash_f($post['password']);
	if ($post['google_auth_access']==''){$post['google_auth_access']=2;}
	
	$qry_1="";$qry_2="";
	
	if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm'])||(isset($_SESSION['gateway_assign_in_subadmin'])&&$_SESSION['gateway_assign_in_subadmin'])){
		
		$post['multiple_subadmin_ids']=','.implodes(',',$post['multiple_subadmin_ids']).',';	
		$post['multiple_subadmin_ids'] = remove_extra_comma($post['multiple_subadmin_ids']);
		
		$qry_1.=",`multiple_subadmin_ids`";
		$qry_2.=",'{$post['multiple_subadmin_ids']}'";
	}
	
	if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm'])||(isset($_SESSION['merchant_assign_in_subadmin'])&&$_SESSION['merchant_assign_in_subadmin'])){
		
		$post['multiple_merchant_ids']=','.implodes(',',$post['multiple_merchant_ids']).',';	
		
		$post['multiple_merchant_ids'] = remove_extra_comma($post['multiple_merchant_ids']);
		$qry_1.=",`multiple_merchant_ids`";
		$qry_2.=",'{$post['multiple_merchant_ids']}'";
	}
	
	if(isset($post['fullname'])&&$post['fullname'])
	{
		$post['fname']=$post['lname']='';	//if we using fullname then fname and lname null
	}
	$qry= "INSERT INTO `{$data['DbPrefix']}subadmin`(".
		"`username`,`password`,`email`,".
		"`fullname`,`fname`,`lname`,".
		"`address`,`city`,`country`,`state`,`zip`,`phone`,".		
		"`upload_logo`,`logo_path`,`upload_css`,`custom_css`,`domain_name`,`domain_active`,".		
		"`bussiness_url`,`customer_service_no`,`customer_service_email`,`associate_contact_us_url`,".
		"`fax`,`access_id`,`more_details`,`google_auth_access`,`front_ui`,`header_bg_color`,".
		"`header_text_color`,`body_bg_color`,`body_text_color`,`heading_bg_color`,`heading_text_color`,`front_ui_panel`,`dashboard_notice`,`notice_type`".$qry_1.
		")VALUES(".
		"'{$post['username']}','{$password}','".encrypts_decrypts_emails($post['email'],1)."',".
		"'{$post['fullname']}','{$post['fname']}','{$post['lname']}',".
		"'{$post['address']}','{$post['city']}','{$post['country']}',".
		"'{$post['state']}','{$post['zip']}','{$post['phone']}',".
		"'{$post['upload_logo']}','{$post['logo_path']}','{$post['upload_css']}',".
		"'{$post['custom_css']}','{$post['domain_name']}','{$post['domain_active']}',".
		"'{$post['bussiness_url']}','{$post['customer_service_no']}',".
		"'".encrypts_decrypts_emails($post['customer_service_email'],1)."','{$post['associate_contact_us_url']}',".
		"'{$post['fax']}','{$post['roles']}','{$post['more_details']}',".
		"'{$post['google_auth_access']}','{$post['front_ui']}','{$post['header_bg_color']}',".
		"'{$post['header_text_color']}','{$post['body_bg_color']}','{$post['body_text_color']}',".
		"'{$post['heading_bg_color']}','{$post['heading_text_color']}','{$post['front_ui_panel']}','{$_POST['dashboard_notice']}','{$_POST['notice_type']}'".$qry_2.
		")";
		
		$check=db_query($qry,$qprint);
		$data['sinsid']=newid();
	
	
	
	if(isset($_GET['qp'])){
		exit;
	}
	
	if ($check==false){
		$data['Error']='Not Saved';
		//echo $qry;
		return false;
	}else {
		//$post['email']=$post['email'];	no any use this line
		$post['ccode']=encode_f($data['sinsid'],0);
		send_email('SIGNUP-TO-SUB-ADMIN', $post);	//done
		return true;
	}
}


function update_subadmin_info($post, $sid){
	global $data;

	if (!empty($_POST['password'])){
		$post['password']=hash_f($post['password']);
		$password=",`password`='{$post['password']}'";}
	else {$password="";}

	
	$multiple_assign="";
	
	if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm'])||(isset($_SESSION['gateway_assign_in_subadmin'])&&$_SESSION['gateway_assign_in_subadmin'])){
		
		$post['multiple_subadmin_ids']=','.implodes(',',$post['multiple_subadmin_ids']).',';	
		$post['multiple_subadmin_ids'] = remove_extra_comma($post['multiple_subadmin_ids']);
		
		$multiple_assign.=",`multiple_subadmin_ids`='{$post['multiple_subadmin_ids']}'";
	}
	
	if((isset($_SESSION['login_adm'])&&$_SESSION['login_adm'])||(isset($_SESSION['merchant_assign_in_subadmin'])&&$_SESSION['merchant_assign_in_subadmin'])){
		
		$post['multiple_merchant_ids']=','.implodes(',',$post['multiple_merchant_ids']).',';	
		
		$post['multiple_merchant_ids'] = remove_extra_comma($post['multiple_merchant_ids']);
		$multiple_assign.=",`multiple_merchant_ids`='{$post['multiple_merchant_ids']}'";
	}
		
	if(isset($post['fullname'])&&$post['fullname'])
	{
		$post['fname']=$post['lname']='';	//if we using fullname then fname and lname null
	}

	db_query(
		"UPDATE `{$data['DbPrefix']}subadmin` SET ".
		"`username`='{$post['username']}',".
		"`email`='".encrypts_decrypts_emails($post['email'],1)."',".
		"`fullname`='{$post['fullname']}',".
		"`fname`='{$post['fname']}',`lname`='{$post['lname']}',`access_id`='{$post['roles']}',".
		"`address`='{$post['address']}',`city`='{$post['city']}',".
		"`country`='{$post['country']}',`state`='{$post['state']}',".
		"`zip`='{$post['zip']}',`phone`='{$post['phone']}',".
		"`upload_logo`='{$post['upload_logo']}',`logo_path`='{$post['logo_path']}',".
		"`upload_css`='{$post['upload_css']}',`custom_css`='{$post['custom_css']}',".
		"`domain_name`='{$post['domain_name']}',`domain_active`='{$post['domain_active']}',".
		"`bussiness_url`='{$post['bussiness_url']}',`customer_service_no`='{$post['customer_service_no']}',".
		"`customer_service_email`='".encrypts_decrypts_emails($post['customer_service_email'],1)."',`associate_contact_us_url`='{$post['associate_contact_us_url']}',".
		"`fax`='{$post['fax']}',`description`='{$post['description']}',`more_details`='{$post['more_details']}'".
		",`header_bg_color`='{$post['header_bg_color']}',`header_text_color`='{$post['header_text_color']}'".
		",`body_bg_color`='{$post['body_bg_color']}',`body_text_color`='{$post['body_text_color']}'".
		",`heading_bg_color`='{$post['heading_bg_color']}',`heading_text_color`='{$post['heading_text_color']}'".
		
		",`front_ui`='{$post['front_ui']}',`front_ui_panel`='{$post['front_ui_panel']}',`dashboard_notice`='{$post['dashboard_notice']}',`notice_type`='{$post['notice_type']}'".$password.$multiple_assign.

		" WHERE `id`='{$sid}'",0
	);
	//exit;
}
function insert_bank_info($post, $uid, $notify=true, $admin=false){
	global $data;
	$qp=0; if(isset($_GET['cqp'])&&$_GET['cqp']==5) $qp=$_GET['cqp'];

	if($post['withdrawFee']==0){ $post['withdrawFee']="0.00"; }	//if withdrawFee is 0 then convert into float

	if (!isset($post['withdrawFee'])||empty($post['withdrawFee'])) { //check withdrawfee not set or null
		$post['withdrawFee']='2';	//	if withdrawFee is empty or not set then set default value is 2
		}
	if($admin){	// if login with admin then can set value into primary field 
		$adm_fld="`primary`,";	//field name primary
		$adm_pst="'{$post['primary']}',";	//value for primary field
		} else {
		$adm_fld="";	//if login with user/merchant then primary field not be insert
			$adm_pst="";
		}
		db_query(
			"INSERT INTO `{$data['DbPrefix']}banks`(".
			"`clientid`,`bname`,`baddress`,`bcity`,`bzip`,`bcountry`,`bstate`,`withdrawFee`,".$adm_fld.
			"`bphone`,`bnameacc`,`baccount`,`btype`,`brtgnum`,`bswift`,`adiinfo`,`required_currency`,".
			"`intermediary`,`intermediary_bank_name`,`intermediary_bank_address`,".
			"`status`,`default`,`full_address`,`bank_doc`".
			")VALUES(".
			"{$uid},'{$post['bname']}','{$post['baddress']}','{$post['bcity']}',".
			"'{$post['bzip']}','{$post['bcountry']}','{$post['bstate']}','{$post['withdrawFee']}',".$adm_pst.
			"'{$post['bphone']}','{$post['bnameacc']}','".encrypts_string($post['baccount'])."',".
			"'{$post['btype']}','{$post['brtgnum']}','{$post['bswift']}','{$post['adiinfo']}','{$post['required_currency']}',".
			"'{$post['intermediary']}','{$post['intermediary_bank_name']}','{$post['intermediary_bank_address']}',".
			"0,0,'{$post['full_address']}','{$post['upload_logo']}')",$qp
		);

		$newid=newid();	//fetch latest inserted id from function newid() and store into $newid
		$data['bnknewid']=$newid;	//store same value into bnkknewid in data array for use of anywhere
		
		if($qp==5) exit;
		
		json_log_upd($newid,'banks','Insert');	//update log history

		if($newid)
		{
			//$_SESSION['action_success']="Bank account added successfully";
		}
		//exit;
		if($notify&&$newid){
			$post['clientid']=$uid;
		$post['email']=get_clients_email($uid);	//fetch clients email id via get_clients_email()
		send_email('UPDATE-BANK-INFORMATION', $post); //send email after insert bank information
	}
	return $newid;	//return id of new inserted bank info
}
function update_bank_info($post, $gid, $uid, $notify=true, $admin=false){
	global $data;
	if($post['withdrawFee']==0){ $post['withdrawFee']="0.00"; }	//if withdrawFee is 0 then convert into float
	if($admin){		//if login with admin then can set value into primary and withdrawFee fields 
		$adm_updt="`primary`='{$post['primary']}',`withdrawFee`='{$post['withdrawFee']}',";
	} else {
		$adm_updt="";
	}
      
	$img_updt = '';
	if(isset($post['remove_logo'])&&$post['remove_logo'])	//remove logo from DB not in folder
	{
		$img_updt = "`bank_doc`='',";
	}else
	{
		$img_updt = "`bank_doc`='{$post['upload_logo']}',";	//update bank document name
	}
				
		db_query(
			"UPDATE `{$data['DbPrefix']}banks` SET ".
			"`bname`='{$post['bname']}',`baddress`='{$post['baddress']}',".$adm_updt.
			"`bcity`='{$post['bcity']}',`bzip`='{$post['bzip']}',".
			"`bcountry`='{$post['bcountry']}',`bstate`='{$post['bstate']}',".
			"`bphone`='{$post['bphone']}',`bnameacc`='{$post['bnameacc']}',".
	"`baccount`='".encrypts_string($post['baccount'])."',`btype`='{$post['btype']}',`adiinfo`='{$post['adiinfo']}',`required_currency`='{$post['required_currency']}',".$img_updt.
		"`brtgnum`='{$post['brtgnum']}',`intermediary`='{$post['intermediary']}',`intermediary_bank_name`='{$post['intermediary_bank_name']}',`intermediary_bank_address`='{$post['intermediary_bank_address']}',`bswift`='{$post['bswift']}',`full_address`='{$post['full_address']}'".
	" WHERE `id`='{$gid}'",0
		);
	affected_rows($data['affected_rows'], 'Bank Account Updated successfully');	//show this message if any changes in information
	json_log_upd($gid,'banks','Update');	//update log history

	if($notify){
		$post['clientid']=$uid;
		$post['email']=get_clients_email($uid);	//fetch clients email id via get_clients_email()
		//send_email('UPDATE-BANK-INFORMATION', $post);		//done
	}
}
function insert_coin_wallet_info($post, $uid, $notify = true, $admin = false)
{
	global $data;

	if (!isset($post['withdrawFee'])||empty($post['withdrawFee'])) { //check withdrawfee not set or null
		$post['withdrawFee'] = '5';	//if withdrawFee is empty or not set then set default value is 5
	}
	if ($admin) {	// if login with admin then can set value into primary field 
		$adm_fld = "`primary`,";			//field name primary
		$adm_pst = "'{$post['primary']}',";	//value for primary field
	} else {
		$adm_fld = "";	//if login with user/merchant then primary field not be insert
		$adm_pst = "";
	}
	//CHECK RECORDS ALREADY EXISTS IN coin_wallet OR NOT - added  on 2810
	$duplicate=0;
	$sqlStmt= "SELECT id,coins_address FROM `{$data['DbPrefix']}coin_wallet` WHERE clientid='{$uid}' AND coins_name='{$post['coins_name']}' AND coins_network='{$post['coins_network']}'";
	$c_rows = db_rows($sqlStmt);

	if(isset($c_rows[0]['coins_address'])&&$c_rows[0]['coins_address'])	//check value in coins_address field after execute above query
	{
		$add = decrypts_string($c_rows[0]['coins_address'],false);
		if($add==$post['coins_address']) $duplicate=1;	//if coins_address value exists in DB then set duplicate is true or 1
	}
	
	if($duplicate)	// if duplicate is true then return an error and store into $_SESSION['Error']
	{
		$_SESSION['Error']="Wallet Address: <b>".$post['coins_address']."</b> already exists!!!";
	}
	else
	{
	db_query(
		"INSERT INTO `{$data['DbPrefix']}coin_wallet`(" .
			"`clientid`, `coins_wallet_provider`, `coins_address`, `coins_network`, `coins_name`, ".$adm_fld.
			"`status`, `required_currency`, `bank_doc`, ".
			"`withdrawFee`, `verify_amount`, `verify_status`" .
			")VALUES(" .
			"{$uid},'{$post['coins_wallet_provider']}','".encrypts_string($post['coins_address'])."', '{$post['coins_network']}', '{$post['coins_name']}'," .$adm_pst.
			"0, '{$post['required_currency']}','{$post['upload_logo']}',".
			"'{$post['withdrawFee']}', 0.00, 0)",
		0
	);
		$newid = newid();	//fetch latest inserted id from function newid() and store into $newid
		$data['cwnewid']=$newid;	//store same value into cwnewid in data array for use of anywhere
		json_log_upd($newid,'coin_wallet','Insert');	//update log history
	if($newid)
	{
		//$_SESSION['action_success']="Wallet added successfully";
	}
	if ($notify && $newid) {
		$post['clientid'] = $uid;
			$post['email'] = get_clients_email($uid);	//fetch clients email id via get_clients_email()
			send_email('UPDATE-BANK-INFORMATION', $post); //send email after insert wallet information
		}
	}
	return $newid;
}
function update_coin_wallet_info($post, $gid, $uid, $notify = true, $admin = false)
{
	global $data;
	
	if ($admin) {	// Only admin can update withdraw fee and primary status
		$adm_updt = "`primary`='{$post['primary']}',`withdrawFee`='{$post['withdrawFee']}',";
	} else {
		$adm_updt = "";
	}

	$img_updt = '';
	if(isset($post['remove_logo'])&&$post['remove_logo'])	// remove logo from DB not in folder
	{
		$img_updt = "`bank_doc`='',";
	}else
	{
		$img_updt = "`bank_doc`='{$post['upload_logo']}',";	// update document name in bank_doc field
	}
	db_query(
		"UPDATE `{$data['DbPrefix']}coin_wallet` SET " .
		"`coins_name`='{$post['coins_name']}',`coins_address`='".encrypts_string($post['coins_address'])."'," . $adm_updt .$img_updt.
			"`coins_wallet_provider`='{$post['coins_wallet_provider']}',`coins_network`='{$post['coins_network']}'" .
//		", `required_currency`='{$post['required_currency']}'" .
		" WHERE `id`='{$gid}'",0
	);
	affected_rows($data['affected_rows'], 'Crypto Wallet Updated Successfully');	//show msg wallet updated successfully after if any changes made
	json_log_upd($gid, 'coin_wallet','Update');	//update log history
	if ($notify) {
		$post['clientid'] = $uid;
		$post['email'] = get_clients_email($uid);	//fetch clients email id via get_clients_email()
		//send_email('UPDATE-BANK-INFORMATION', $post);	 //send email after update wallet information
	}
}

function get_support_tickets_count($status=0,$filterid=0){
	global $data;
	
	$sponsor_qr="";
	

	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];
		$sponsor_qr.=" AND s.clientid IN ({$get_mid})  ";
	}

	$result=db_rows(
		"SELECT COUNT(s.id) AS count".
		" FROM {$data['DbPrefix']}support_tickets AS s ".
		" WHERE s.active='1' AND s.status='{$status}' AND s.filterid='{$filterid}' ".$sponsor_qr.
		" LIMIT 1"//,true
	);
	if(isset($result[0])) return $result[0]['count']; 
	else return 0;
}
function support_tickets_count_by_status($merchant_id,$status){
	global $data;
	
	
	//exit;
	$qr="";
	if($status=="open"){
	$qr=" AND `status`=0 ";
	}elseif($status=="unread"){
	$qr=" AND `status`=91 ";
	}elseif($status=="process"){
	$qr=" AND `status`=1 ";
	}elseif($status=="close"){
	$qr=" AND `status`=2 ";
	}elseif($status=="read"){
	$qr=" AND `status`=4 ";
	}else{
	$qr=" AND `status`=4 ";
	}


	$result=db_rows(
		"SELECT COUNT(`id`) AS count".
		" FROM {$data['DbPrefix']}support_tickets ".
		" WHERE `clientid`='{$merchant_id}' ".$qr." AND `status` NOT IN (90,92) ORDER BY FIELD(`status`, 2,4,0,1,91) DESC ".
		" LIMIT 1",0
	);
	

	if(isset($result[0])) return $result[0]['count']; 
	else return 0;
}
function unsetf_t($t){
	unset($t[0]);unset($t[1]);unset($t[5]);unset($t[7]);unset($t[8]);unset($t[9]);unset($t[10]);unset($t[11]);
	reset($t);
	return $t;
}

function createDateRanges($startDate, $endDate, $format = "Y-m-d")
{
    $begin = new DateTime($startDate);
    $end = new DateTime($endDate);

    $interval = new DateInterval('P1D'); // 1 Day
    $dateRange = new DatePeriod($begin, $interval, $end);

    $range = [];
    foreach ($dateRange as $date) {
        $range[] = $date->format($format);
    }

    return $range;
}


function daily_trans_statement_insert($uid=0,$post=''){
	global $data; $result=array();
	$batch_date=date("Y-m-d",strtotime($post['batch_date']));
	//$batch_date=$post['batch_date'];
	db_query(
		"INSERT INTO `{$data['DbPrefix']}daily_tras_statement`(".
		"`clientid`,".
		"`total_success_of_batch`,`total_mdr_of_batch`,`total_rolling_of_batch`,`total_failed_of_batch`,`total_txn_fee_of_batch`,`total_amt_chargeback_of_batch`,`total_chargeback_fee_of_batch`,`total_amt_returned_of_batch`,`total_returned_fee_of_batch`,`total_amt_refunded_of_batch`,`total_refunded_fee_of_batch`,`total_amt_cbk1_of_batch`,`total_cbk1_fee_of_batch`,`total_withdraw_of_batch`,`total_send_fund_of_batch`,`total_received_fund_of_batch`,`monthly_vt_fee`,`monthly_maintenance_fee`,`mature_fund_date_of_day`,`total_payable_to_merchant`,`total_withdraw_rolling_of_batch`,`total_payable_rolling_to_merchant`,`mature_rolling_date_of_day`,`batch_date`,`cdate`".
		")VALUES(".
		"'{$uid}',".
		"'{$post['total_success_of_batch']}','{$post['total_mdr_of_batch']}','{$post['total_rolling_of_batch']}','{$post['total_failed_of_batch']}','{$post['total_txn_fee_of_batch']}','{$post['total_amt_chargeback_of_batch']}','{$post['total_chargeback_fee_of_batch']}','{$post['total_amt_returned_of_batch']}','{$post['total_returned_fee_of_batch']}','{$post['total_amt_refunded_of_batch']}','{$post['total_refunded_fee_of_batch']}','{$post['total_amt_cbk1_of_batch']}','{$post['total_cbk1_fee_of_batch']}','{$post['total_withdraw_of_batch']}','{$post['total_send_fund_of_batch']}','{$post['total_received_fund_of_batch']}','{$post['monthly_vt_fee']}','{$post['monthly_maintenance_fee']}','{$post['mature_fund_date_of_day']}','{$post['total_payable_to_merchant']}','{$post['total_withdraw_rolling_of_batch']}','{$post['total_payable_rolling_to_merchant']}','{$post['mature_rolling_date_of_day']}','{$batch_date}',now()".
		")"
	);
				
}
function daily_trans_statement_update($pid,$post=''){

//echo "<=daily_trans_statement_update=>";print_r($post);exit;

	global $data; $result=array();
	$batch_date=date("Y-m-d",strtotime($post['batch_date']));
	//$batch_date=$post['batch_date'];
	
	db_query("UPDATE `{$data['DbPrefix']}daily_tras_statement`"." SET `total_success_of_batch`='{$post['total_success_of_batch']}', `total_mdr_of_batch`='{$post['total_mdr_of_batch']}', `total_rolling_of_batch`='{$post['total_rolling_of_batch']}', `total_failed_of_batch`='{$post['total_failed_of_batch']}', `total_txn_fee_of_batch`='{$post['total_txn_fee_of_batch']}', `total_amt_chargeback_of_batch`='{$post['total_amt_chargeback_of_batch']}', `total_chargeback_fee_of_batch`='{$post['total_chargeback_fee_of_batch']}', `total_amt_returned_of_batch`='{$post['total_amt_returned_of_batch']}', `total_returned_fee_of_batch`='{$post['total_returned_fee_of_batch']}', `total_amt_refunded_of_batch`='{$post['total_amt_refunded_of_batch']}', `total_refunded_fee_of_batch`='{$post['total_refunded_fee_of_batch']}', `total_amt_cbk1_of_batch`='{$post['total_amt_cbk1_of_batch']}', `total_cbk1_fee_of_batch`='{$post['total_cbk1_fee_of_batch']}', `total_withdraw_of_batch`='{$post['total_withdraw_of_batch']}', `total_send_fund_of_batch`='{$post['total_send_fund_of_batch']}', `total_received_fund_of_batch`='{$post['total_received_fund_of_batch']}', `monthly_vt_fee`='{$post['monthly_vt_fee']}', `monthly_maintenance_fee`='{$post['monthly_maintenance_fee']}', `mature_fund_date_of_day`='{$post['mature_fund_date_of_day']}', `total_payable_to_merchant`='{$post['total_payable_to_merchant']}', `total_withdraw_rolling_of_batch`='{$post['total_withdraw_rolling_of_batch']}', `total_payable_rolling_to_merchant`='{$post['total_payable_rolling_to_merchant']}', `mature_rolling_date_of_day`='{$post['mature_rolling_date_of_day']}', `udate`=now()  WHERE `id`='{$pid}'",0);
	
	
				
}

function merchant_balance($uid=0,$currentDate=''){
	global $data; $now="now()";$order=" ORDER BY `id` ASC ";
	$result=array();$where_owner="";
	$current_date=date('Y-m-d H:i:s');
	$qprint=0;$account_curr="";
	if(isset($_GET['qp'])){
		$qprint=1;
		echo "<hr/><==merchant_balance==><hr/>";
	}
	
	$date_1st=date('Y-m-d');
	
	//$date_2nd=date("Y-m-d",strtotime("+1 day",strtotime($date_1st)));
	
	$mature_pd=" AND ( (DATE_FORMAT(`mature_fund_date_of_day`, '%Y%m%d')) <= (DATE_FORMAT({$now}, '%Y%m%d')) ) ";
	
	$immature_pd=" AND ( (DATE_FORMAT(`mature_fund_date_of_day`, '%Y%m%d')) > (DATE_FORMAT({$now}, '%Y%m%d')) ) ";
	
	// rolling
	$mature_rolling_pd=" AND ( (DATE_FORMAT(`mature_rolling_date_of_day`, '%Y%m%d')) <= (DATE_FORMAT({$now}, '%Y%m%d')) ) ";
	
	$immature_rolling_pd=" AND ( (DATE_FORMAT(`mature_rolling_date_of_day`, '%Y%m%d')) > (DATE_FORMAT({$now}, '%Y%m%d')) ) ";
	
	$tdate_pd="";$mature_pd_range="";
	//	mature_fund_date_of_day		mature_rolling_date_of_day
	if($currentDate){
		//print_r($currentDate);
		
		if(is_array($currentDate)){
			$date_1st=date("Ymd",strtotime($currentDate['date_1st']));
			$date_2nd=date("Ymd",strtotime($currentDate['date_2nd']));
			$date_2nd_3=date("Ymd",strtotime("+1 day",strtotime($currentDate['date_2nd'])));
		}else {
			$date_1st=date("Ymd",strtotime($currentDate));
			$date_2nd=$date_1st;
			$date_2nd_3=date("Ymd",strtotime("+1 day",strtotime($date_1st)));
		}
		
		$now="'".$date_1st."'";
		
		//$tdate_pd=" AND ( (DATE_FORMAT(`batch_date`, '%Y%m%d')) >= (DATE_FORMAT(".$date_1st.", '%Y%m%d')) AND (DATE_FORMAT(`batch_date`, '%Y%m%d')) <= (DATE_FORMAT(".$date_2nd.", '%Y%m%d')) )   ";
		
		$mature_pd=" AND ( (DATE_FORMAT(`mature_fund_date_of_day`, '%Y%m%d')) >= (DATE_FORMAT(".$date_1st.", '%Y%m%d'))  AND  (DATE_FORMAT(`mature_fund_date_of_day`, '%Y%m%d')) <= (DATE_FORMAT(".$date_2nd.", '%Y%m%d')) )  ";
		
		//$mature_pd=" AND ( `mature_fund_date_of_day` BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd_3}', '%Y%m%d')) )  ";
		
		$mature_pd_range=$mature_pd;
		//AND (`status `=0)
		$immature_pd=" AND ( `mature_fund_date_of_day` NOT BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd_3}', '%Y%m%d')) )  ";
		
		
		//$immature_pd=$tdate_pd;
		
		
		//rolling
		$mature_rolling_pd=" AND ( (DATE_FORMAT(`mature_rolling_date_of_day`, '%Y%m%d')) >= (DATE_FORMAT(".$date_1st.", '%Y%m%d'))  AND  (DATE_FORMAT(`mature_rolling_date_of_day`, '%Y%m%d')) <= (DATE_FORMAT(".$date_2nd.", '%Y%m%d')) )  ";
		
		$immature_rolling_pd=" AND ( `mature_rolling_date_of_day` NOT BETWEEN (DATE_FORMAT('{$date_1st}', '%Y%m%d')) AND (DATE_FORMAT('{$date_2nd_3}', '%Y%m%d')) )  ";
		
		//$immature_rolling_pd=$tdate_pd;;
		
	}
	
	
	
	// ----------------------
	
	if($uid>0){
		$where_owner=" AND ( `clientid`='{$uid}' ) ";
		
		$clients=select_client_table($uid);
		$account_curr=$clients['default_currency'];
	}
	
	
	
	
	//immature Volume --------------------------	
	$immature=db_rows("SELECT SUM(`total_payable_to_merchant`) AS `summ_immature`, COUNT(`id`) AS `count_immature` ".
			" FROM `{$data['DbPrefix']}daily_tras_statement`".
			" WHERE  (`status`=1) AND (`total_payable_to_merchant` IS NOT NULL AND `total_payable_to_merchant` != '') ".$immature_pd.$where_owner.$order." LIMIT 1",$qprint);
	
	$summ_immature=(double)$immature[0]['summ_immature'];
	$result['summ_immature_amt']=$summ_immature;
	$result['summ_immature']=prnpays_crncy($summ_immature,'','',$account_curr);
	$result['count_immature']=$immature[0]['count_immature'];
	
	
	//mature Volume --------------------------	
	$mature=db_rows("SELECT SUM(`total_payable_to_merchant`) AS `summ_mature`, COUNT(`id`) AS `count_mature` ".
			" FROM `{$data['DbPrefix']}daily_tras_statement`".
			" WHERE  (`status`=1) AND (`total_payable_to_merchant` IS NOT NULL AND `total_payable_to_merchant` != '') ".$mature_pd.$where_owner.$order." LIMIT 1",$qprint);
	
	
	
	//received fund  --------------------------	
	$received_fund=db_rows("SELECT SUM(`total_received_fund_of_batch`) AS `summ_received_fund`, COUNT(`id`) AS `count_received_fund` ".
			" FROM `{$data['DbPrefix']}daily_tras_statement`".
			" WHERE  (`status`=1) AND (`total_received_fund_of_batch` IS NOT NULL AND `total_received_fund_of_batch` != '') ".$where_owner.$mature_pd_range.$order." LIMIT 1",$qprint);
			
	//received_fund calc
	$summ_received_fund=(double)$received_fund[0]['summ_received_fund'];
	$result['summ_received_fund_amt']=str_replace("-","",$summ_received_fund);
	
	$result['summ_received_fund']=prnpays_crncy($summ_received_fund,'','',$account_curr);
	$result['count_received_fund']=$received_fund[0]['count_received_fund'];
	
	
	//send fund  --------------------------	
	$send_fund=db_rows("SELECT SUM(`total_send_fund_of_batch`) AS `summ_send_fund`, COUNT(`id`) AS `count_send_fund` ".
			" FROM `{$data['DbPrefix']}daily_tras_statement`".
			" WHERE  (`status`=1) AND (`total_send_fund_of_batch` IS NOT NULL AND `total_send_fund_of_batch` != '') ".$where_owner.$mature_pd_range.$order." LIMIT 1",$qprint);
			
	//send_fund calc
	$summ_send_fund=(double)$send_fund[0]['summ_send_fund'];
	$result['summ_send_fund_amt']=str_replace("-","",$summ_send_fund);
	$result['summ_send_fund']=prnpays_crncy($summ_send_fund,'','',$account_curr);
	$result['count_send_fund']=$send_fund[0]['count_send_fund'];
	
	
	
	
	//withdraw  --------------------------	
	$withdraw=db_rows("SELECT SUM(`total_withdraw_of_batch`) AS `summ_withdraw`, COUNT(`id`) AS `count_withdraw` ".
			" FROM `{$data['DbPrefix']}daily_tras_statement`".
			" WHERE  (`status`=1) AND (`total_withdraw_of_batch` IS NOT NULL AND `total_withdraw_of_batch` != '') ".$where_owner.$mature_pd_range.$order." LIMIT 1",$qprint);
			
	//withdraw calc
	$summ_withdraw=(double)$withdraw[0]['summ_withdraw'];
	
	// withdraw only
	//$result['summ_withdraw_amt']=$summ_withdraw;
	
	$result['summ_withdraw_amt_1']=str_replace("-","",$summ_withdraw);
	// withdraw + send fund
	$result['summ_withdraw_amt']=$summ_withdraw;
	$result['summ_withdraw']=prnpays_crncy($summ_withdraw,'','',$account_curr);
	$result['count_withdraw']=$withdraw[0]['count_withdraw'];
	
	
	
	
	
	
	
	
	$monthly_fee=payout_trans($uid);
	$result['monthly_vt_fee']=$monthly_fee['total_monthly_fee'];
	$result['monthly_vt_fee_max']=$monthly_fee['per_monthly_fee'];
	$result['count_monthly_vt_fee']=$monthly_fee['total_month_no'];
	$result['manual_adjust_balance']=$monthly_fee['manual_adjust_balance'];
	
	/*
	//monthly fee  monthly_vt_fee --------------------------	
	$sum_monthly_vt_fee=db_rows("SELECT SUM(`monthly_vt_fee`) AS `monthly_vt_fee`, MAX(`monthly_vt_fee`) AS `monthly_vt_fee_max`, COUNT(`id`) AS `count_monthly_vt_fee` ".
			" FROM `{$data['DbPrefix']}daily_tras_statement`".
			" WHERE  (`status`=1) AND (`monthly_vt_fee` IS NOT NULL AND `monthly_vt_fee` != '') ".$where_owner.$order." LIMIT 1",0);
			
	//get monthly fee only 
	$result['monthly_vt_fee']=$sum_monthly_vt_fee[0]['monthly_vt_fee'];
	$result['monthly_vt_fee_max']=$sum_monthly_vt_fee[0]['monthly_vt_fee_max'];
	$result['count_monthly_vt_fee']=(double)$sum_monthly_vt_fee[0]['count_monthly_vt_fee'];
	
	*/
	
	
	//calc mature 
	$result['summ_mature_1']=number_formatf2((double)$mature[0]['summ_mature']);
	
	
	
	
	
	$total_summ_mature_amt=(double)$mature[0]['summ_mature'];
	
	$total_summ_mature_amt=$total_summ_mature_amt+$result['summ_refunded_amt'];
	
	
	$total_summ_mature_amt=$total_summ_mature_amt+$summ_withdraw;
	$total_summ_mature_amt=$total_summ_mature_amt+$summ_send_fund;
	
	$total_summ_mature_amt=$total_summ_mature_amt+$summ_received_fund;
	
	if($result['manual_adjust_balance']){
	$total_summ_mature_amt=$total_summ_mature_amt+$result['manual_adjust_balance'];
	}
	//$total_summ_mature_amt=$total_summ_mature_amt-$result['monthly_vt_fee'];
	
	
	

	
	
	
	$result['summ_mature_amt']=$total_summ_mature_amt;
	
	$result['summ_mature']=prnpays_crncy($result['summ_mature_amt'],'','',$account_curr);
	$result['count_mature']=$mature[0]['count_mature']-$result['count_withdraw'];
	
	
	
	// total balance 
	$summ_total=$summ_immature+$result['summ_mature_amt'];
	$result['summ_total_amt']=$summ_total;
	$result['summ_total']=prnpays_crncy($summ_total,'','',$account_curr);
	$result['count_total']=$result['count_immature']+$result['count_mature'];
	
	
	
	//rolling
	//mature rolling Volume --------------------------	
	$mature_roll=db_rows("SELECT SUM(`total_payable_rolling_to_merchant`) AS `summ_mature`, COUNT(`id`) AS `count_mature` ".
			" FROM `{$data['DbPrefix']}daily_tras_statement`".
			" WHERE  (`status`=1) AND (`total_payable_rolling_to_merchant` IS NOT NULL AND `total_payable_rolling_to_merchant` != '') ".$mature_rolling_pd.$where_owner.$order." LIMIT 1",$qprint);
	
	//mature rolling calc
	$result['summ_mature_roll']=number_formatf2((double)$mature_roll[0]['summ_mature']);
	$result['count_mature_roll']=$mature_roll[0]['count_mature'];
	
	//immature rolling Volume --------------------------	
	$immature_roll=db_rows("SELECT SUM(`total_payable_rolling_to_merchant`) AS `summ_immature`, COUNT(`id`) AS `count_immature_roll` ".
			" FROM `{$data['DbPrefix']}daily_tras_statement`".
			" WHERE  (`status`=1) AND (`total_payable_rolling_to_merchant` IS NOT NULL AND `total_payable_rolling_to_merchant` != '') ".$immature_rolling_pd.$where_owner.$order." LIMIT 1",$qprint);
			
	
	
	
	//immature rolling calc
	$result['summ_immature_roll']=number_formatf2((double)$immature_roll[0]['summ_immature']);
	$result['count_immature_roll']=$immature_roll[0]['count_immature_roll'];
	
	
	//Rolling withdraw  --------------------------	
	$withdraw_roll=db_rows("SELECT SUM(`total_withdraw_rolling_of_batch`) AS `summ_withdraw_roll`, COUNT(`total_withdraw_rolling_of_batch`) AS `count_withdraw_roll` ".
			" FROM `{$data['DbPrefix']}daily_tras_statement`".
			" WHERE  (`status`=1) AND (`total_withdraw_rolling_of_batch` IS NOT NULL AND `total_withdraw_rolling_of_batch` != '') ".$where_owner.$order." LIMIT 1",$qprint);
			
	//received_fund calc
	$summ_withdraw_roll=(double)$withdraw_roll[0]['summ_withdraw_roll'];
	$result['summ_received_fund_amt_roll']=$summ_withdraw_roll;
	$result['summ_withdraw_roll']=prnpays_crncy($summ_withdraw_roll,'','',$account_curr);
	$result['count_withdraw_roll']=$withdraw_roll[0]['count_withdraw_roll'];
	
	
	
	//total rolling calc
	$result['summ_total_roll']=number_formatf2($result['summ_immature_roll']+$result['summ_mature_roll']);
	$result['count_total_roll']=$result['count_immature_roll']+$result['count_mature_roll'];
	$result['account_curr']=$account_curr;
	$result['account_curr_sys']=get_currency($account_curr);
	
	
	
	
	
	
	
	
	
	//print_r($result);
	if(isset($_GET['qp'])){
		print_r($result);
	}
	
	return $result;
}

function daily_statement_insert($uid=0,$post=''){
	global $data; $result=array();
	$batch_date=date("Y-m-d",strtotime($post['batch_date']));
	//$batch_date=$post['batch_date'];
	db_query(
		"INSERT INTO `{$data['DbPrefix']}daily_statement`(".
		"`clientid`,".
		"`mature_amt`,`immature_amt`,`balance_amt`,`withdraw_amt`,`mature_roll_amt`,`balance_roll_amt`,`immature_roll_amt`,`withdraw_roll_amt`,`send_fund_amt`,`received_fund_amt`,`cdate`,`batch_date`".
		")VALUES(".
		"'{$uid}',".
		"'{$post['summ_mature_amt']}','{$post['summ_immature_amt']}','{$post['summ_total_amt']}','{$post['summ_withdraw_amt']}','{$post['summ_mature_roll']}','{$post['summ_total_roll']}','{$post['summ_immature_roll']}','{$post['summ_withdraw_roll']}','{$post['summ_sended_fund_amt']}','{$post['summ_received_fund_amt']}',now(),'{$batch_date}'".
		")"
	);
				
}



function generate_password( $length = 8 ) {
	$chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&()";
	//$password = substr( str_shuffle( $chars ), 0, $length );
	$password = substr ( str_shuffle ( str_repeat ( $chars,$length ) ), 0, $length );
	return $password;
}
function csa($string, $separator = ','){
  $vals = explode($separator, $string);
  foreach($vals as $key => $val) {
    $vals[$key] = trim($val);
  }
  return array_diff($vals, array(""));
}
function hash_f($password){
	$result=$password;
	if($password){
		$result=hash('sha256', $password);	
	}
	return $result;
}
function get_pulling_status($ptime,$currtime=''){
	if(empty($currtime)) $currtime=date('Y-m-d H:i:s');	
	$date1 = new DateTime($ptime);
	$date2 = $date1->diff(new DateTime($currtime));
	
	$h = $date2->h;
	$m = $date2->i;
	
	return $min = $h*60+$m;
		
}// end function
function user_block_time($uid,$tbl='clientid_table'){	
	global $data;
	$ip_block_client=time();
	db_query("UPDATE `{$data['DbPrefix']}{$tbl}`"." SET `ip_block_client`='{$ip_block_client}' WHERE `id`='{$uid}'",0);
}// end function
function check_user_block_time($uid,$tbl='clientid_table'){
	global $data;	
	$qry="select `ip_block_client` from `{$data['DbPrefix']}{$tbl}` WHERE `id`='{$uid}'";
	$result=db_rows($qry);
	$blocktime=(int)$result[0]['ip_block_client'];
	if (!empty($blocktime)){
		$diff = round((time() - $blocktime) / 60);
	}else {$diff=31;}
	return $diff;

}// enc function
function user_un_block_time($uid,$tbl='clientid_table'){	
	global $data;
	db_query("UPDATE `{$data['DbPrefix']}{$tbl}`"." SET `ip_block_client`='' WHERE `id`='{$uid}'");
}// end function
function codereset($mid,$tbl,$ajax){
	global $data;
	
	if($tbl=='subadmin'){
		$twoGmfa=twoGmfa($mid,0,'1'); // subadmin
		$close="Closereset({$mid});";
	}else{
		$twoGmfa=twoGmfa(0,$mid,'1'); // clients
		$close='Closereset();';
	}
	
	$revert="Code Reset is done.<span class='glyphicons remove_2 reset'><a href='#' onClick='{$close}'><i></i></a></span>";
	
	if ($ajax==true){echo $revert;}
}// end function

function rand_string( $length = 8 ) {
	$chars = "abcdefghijklmnopqrstuvwxyz0123456789";//!#$%^&*()_-=+
	//$password = substr( str_shuffle( $chars ), 0, $length );
	$string_sub = substr ( str_shuffle ( str_repeat ( $chars,$length ) ), 0, $length );
	return $string_sub;
}
function email_first_letter_remove($email) {
	$eml_exp=explode("@",$email);
	$em_name=$eml_exp[0];
	$length=strlen($em_name);
	//$enc_email= substr($em_name, 0, -1); $enc_email=$enc_email.rand_string(2)."@".$eml_exp[1];
	
	$enc_email= substr($em_name, 1); $enc_email=$enc_email."@".$eml_exp[1];
	return $enc_email;
}
function rand_email($email) {
	$eml_exp=explode("@",$email);
	$em_name=$eml_exp[0];
	$length=strlen($em_name);
	$enc_email= substr($em_name, 0, -1); $enc_email=$enc_email.rand_string(2)."@".$eml_exp[1];
	
	//$enc_email= substr($em_name, 1); $enc_email=$enc_email."@".$eml_exp[1];
	return $enc_email;
}
function api_masking($key) {
	
	$key_masking=substr($key,0,8)."********".substr($key,-8,8);
	return $key_masking;
}
function json_encode_str($json_str,$key,$value) {
	$json_str=substr($json_str, 0, -1);
	if(is_array($value)){ 
		$value=json_encode($value);
		$json_str=$json_str.',"'.$key.'":'.$value.'}';
	}else{
		$json_str=$json_str.',"'.$key.'":"'.$value.'"}';
	}
	return $json_str;
}

function get_file_extention($filename){
	$pos=strrpos($filename,".");
	$ext=substr($filename,$pos+1,3);
	$ext=strtolower($ext);
	return $ext;
}//end fucntion
function bankdoc_img($gid,$ajax){
	global $data;
	$sql= "SELECT bank_doc FROM `{$data['DbPrefix']}banks` WHERE `id`='".$gid."' LIMIT 1";
	$result=db_rows($sql);
	if ((isset($result['0']['bank_doc'])&&$result['0']['bank_doc']!="")&&(file_exists("../user_doc/".$result['0']['bank_doc']))){
	$id=$result['0']['id'];
	$logo=$result['0']['bank_doc'];
	$ext=get_file_extention($logo);
	$logo=$data['Host']."/user_doc/".$logo;
	$encrypted_logo = encrypt_decrypt('encrypt', $logo);
	

		
		
	if (($ext=="jpe")||($ext=="jpg")||($ext=="png")||($ext=="jpeg")||($ext=="gif")){
		?><a onclick="uploadfile_viewf(this)" style="display:inline-block;margin:0 10px 0 0;width:100px;overflow:hidden;"><img src="<?=$logo?>" style="height:40px;" /></a>
    <? }
	else if ($ext=="pdf"){
		?><a href="<?=$logo;?>" title="Download PDF" alt="Download PDF" target="_blank" style="display:inline-block;margin:0 10px 0 0;width:100px;overflow:hidden;"><img src="<?=$data['Host']?>/images/pdf.png" style="height:40px;" /></a>
    <? }else{
		?><a href="<?=$logo;?>" title="Download the Document" alt="Download the Document" target="_blank" style="display:inline-block;margin:0 10px 0 0;width:100px;overflow:hidden;"><img src="<?=$data['Host']?>/images/download.png" style="height:40px;" /></a>
		<?
		}// End if file extention	
	}
	else {
	?>
	<a onclick="uploadfile_viewf(this)" style="display:inline-block;margin:0 10px 0 0;width:100px;overflow:hidden;">
	<img src="<?=$data['Host']?>/images/No_image_available.svg" style="height:40px;" /></a>
	<?
	}
	
}// End Function
function encode_imgf($imgData,$path=''){
	if($imgData){$imgData=$path.$imgData;}
	$pro_img=encode_img($imgData);
	//print_r($pro_img);

	if(isset($pro_img)&&isset($pro_img['ext'])&&in_array(strtolower($pro_img['ext']), array("jpg","jpeg","bmp","gif","png"))){
		return "data:image/".$pro_img['ext'].";base64,".$pro_img['img'];
	}
}
function display_docfile($path, $fileName=""){
	global $data;
	if(!empty($path) && !empty($fileName) && file_exists($path.$fileName))
	{
		$path=$path.$fileName;
		$pro_img=encode_img($path);

		if(in_array(strtolower($pro_img['ext']), array("jpg","jpeg","bmp","gif","png"))){
		?>	
			<a onclick="uploadfile_viewf(this)" style="height:40px;display:inline-block;margin:0 10px 0 0;overflow:hidden;"><img class="img-thumbnail" src="data:image/<?=$pro_img['ext'];?>;base64,<?=$pro_img['img'];?>" style="height:40px;" /></a>
		<?
		}
		elseif(in_array(strtolower($pro_img['ext']), array("php","do","htm"))){ }
		elseif(in_array(strtolower($pro_img['ext']), array("doc","docx","xls","xlsx"))){
		?>
			<a href="<?=$path?>" target="_blank" style="height:40px;display:inline-block;margin:0 10px 0 0;width: 60px;overflow:hidden;"><img class="img-thumbnail" src="<?=$data['Host'];?>/images/<?=$pro_img['ext'];?>.png" style="height:40px;" /></a>
		<?
		}else{
			
		?>
			<a onclick="uploadfile_viewf(this,'<?=$path?>')" style="height:40px;display:inline-block;margin:0 10px 0 0;overflow:hidden;"><img class="img-thumbnail" src="<?=$data['Host'];?>/images/<?=$pro_img['ext'];?>.png" style="height:40px;" /></a>
		<?
			
		}
	}
	else{
		if((isset($data['PRO_VER']))&&($data['PRO_VER']==3)){
	
		}else{
	?>
	<a onclick="uploadfile_viewf(this)" style="height:40px;display:inline-block;margin:0 10px 0 0; overflow:hidden;"><img src="<?=$data['Host']?>/images/No_image_available.svg" style="height:40px;" class="img-thumbnail mx-1" /></a>
	<? }
	}

}// End display_docfile

function opps_midf($mid){
	global $data;
	if(((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All'))&&($_SESSION['get_mid'])){
		$get_mid=",".$_SESSION['get_mid'].",";
		
		if(strpos($get_mid,$mid.",")!==false){
		
		}else{
			echo $data['OppsAdmin'];
			exit;
		}

	}
	
}
function decriptimg($img,$ajax){
	$logo = encrypt_decrypt('decrypt', $img);
	?>
    <center>
    <img src="<?=$logo;?>" style="width:50%;borer:0" title="" />
    </center>
    <?
	
}//End Function
function encrypt_decrypt($action, $string) {
    $output = false;
    $encrypt_method = "AES-256-CBC";
    $secret_key_1 = ',';
	$secret_key_2 = ',';
    $secret_iv = 'This is my secret iv';
    // hash
    $key_1 = hash('sha256', $secret_key_1);
	$key_2 = hash('sha256', $secret_key_2);
    
    // iv - encrypt method AES-256-CBC expects 16 bytes - else you will get a warning
    $iv = substr(hash('sha256', $secret_iv), 0, 16);
    if ( $action == 'encrypt' ) {
        $output = openssl_encrypt($string, $encrypt_method, $key_1, 0, $iv);
        $output = base64_encode($output);
    } else if( $action == 'decrypt' ) {
        $output = openssl_decrypt(base64_decode($string), $encrypt_method, $key_2, 0, $iv);
    }
    return $output;
}// End Function	


###############################################################################

if(isset($_SESSION['sub_admin_id'])&&$_SESSION['sub_admin_id']&&((strpos($data['urlpath'],'signins/clients')!==false)||(strpos($data['urlpath'],'signins/merchant')!==false)||(strpos($data['urlpath'],'signins/merlist')!==false))){
	$slist=get_sponsors('',$_SESSION['sub_admin_id'],1);
	
	//echo " | get_mid=>".$_SESSION['get_mid']; 
	
	$_SESSION['merchantAccess']=$slist['merchantAccess'];
	$_SESSION['get_mid']=$slist['get_mid'];
	$_SESSION['get_mid_count']=$slist['get_mid_count'];
	$_SESSION['subAdminAccess']=$slist['subAdminAccess'];
	$_SESSION['get_gid']=$slist['get_gid']; 
	
}


##end#############################################################################
if(isset($_GET['sid']))$post['sid']=$_GET['sid'];
if(isset($_GET['bid']))$post['bid']=$_GET['bid'];
if(isset($_GET['id']))$post['gid']=$_GET['id'];
if(isset($_GET['bp']))$post['bp']=$_GET['bp'];
if(isset($_GET['cid']))$post['cid']=$_GET['cid'];
if(isset($_GET['updateid']))$post['updateid']=$_GET['updateid'];
if(isset($_GET['itemid']))$post['itemid']=$_GET['itemid'];
if(isset($_GET['type']))$post['type']=$_GET['type'];
if(isset($_GET['email']))$post['email']=$_GET['email'];
if(isset($_GET['status']))$post['status']=$_GET['status'];
if(isset($_GET['page']))$post['StartPage']=$_GET['page'];
if(isset($_GET['order']))$post['order']=$_GET['order'];
if(isset($_GET['action']))$post['action']=$_GET['action'];
if(isset($_GET['clients']))$post['clients']=$_GET['clients'];
if(isset($_GET['product']))$post['product']=$_GET['product'];
if(isset($_GET['keyword']))$post['keyword']=$_GET['keyword'];
if(isset($_GET['searchkey']))$post['searchkey']=$_GET['searchkey'];
//if(isset($_GET['api_token']))$post['api_token']=$_GET['api_token'];
if(isset($_GET['public_key']))$post['public_key']=$_GET['public_key'];
if(isset($_GET['aurl']))$post['aurl']=$_GET['aurl'];
if(isset($_GET['id_order']))$post['id_order']=$_GET['id_order'];
if(isset($_GET['reference']))$post['reference']=$_GET['reference'];
if(isset($_GET['bill_amt']))$post['bill_amt']=$_GET['bill_amt'];
//if(isset($_GET['cardsend']))$post['cardsend']=$_GET['cardsend'];
if(isset($_GET['integration-type']))$post['integration-type']=$_GET['integration-type'];
if(isset($_GET['acquirer_id']))$post['acquirer_id']=$_GET['acquirer_id'];
if(isset($_GET['actionajax']))$post['actionajax']=$_GET['actionajax'];
if(isset($_GET['retrycount']))$post['retrycount']=$_GET['retrycount'];
if(isset($_GET['mop']))$post['mop']=$_GET['mop'];
if(isset($_GET['integration-type']))$post['integration-type']=$_GET['integration-type'];
if(isset($_GET['amount']))$post['amount']=$_GET['amount'];
if(isset($_GET['tname']))$post['tname']=$_GET['tname'];
if(isset($_GET['fullname']))$post['fullname']=$_GET['fullname'];
if(isset($_GET['unique_reference']))$post['unique_reference']=$_GET['unique_reference'];
###############################################################################
if(isset($_GET['rid']))$post['sponsor']=$_GET['rid'];
elseif(isset($_COOKIE['rid']))$post['sponsor']=$_COOKIE['rid'];
reset($_GET);
###############################################################################
header("Cache-control: private");
###############################################################################
if(!isset($post['StartPage']))$post['StartPage']=0;
###############################################################################
if(isset($_SESSION['uid'])){
	if(empty($uid))$uid=$_SESSION['uid'];
}
/*
if(!empty($uid)){
	$balance=select_balance($uid);
	$post['Balance']=$balance;
	$post['Address']=$data['Addr'];
	$post['MailAddr']=get_clients_email($uid);
	$post['Username']=get_clients_username($uid);
	set_last_access_date($uid);
}
*/
###############################################################################
if($data['ReferralPays']&&isset($post['sponsor'])){
	$sponsor=sponsor_details(0,$post['sponsor']); 
	//if(get_clients_id($post['sponsor'], '', "`active`=1")){
	if(isset($sponsor[0])&&$sponsor[0]['id']>0){
		$rid=$sponsor[0]['id']; 
		//$_SESSION['sponsor']=$rid;
		$_SESSION['sponsor_id']=$rid;
		$_SESSION['sponsor_username']=$sponsor[0]['username'];
		setcookie('rid', $rid);
	}elseif(!$_POST['sponsor'])unset($post['sponsor']);
}unset($_POST['sponsor']);
###############################################################################
//clearstatcache();
?>