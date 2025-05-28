<?
function browserOs($array=false,$uAgent=false) {
	if($uAgent){
		$ua = strtolower($uAgent);
	}else{
		$ua = strtolower($_SERVER['HTTP_USER_AGENT']);
	}
    // you can add different browsers with the same way ..
    if(preg_match('/(chromium)[ \/]([\w.]+)/', $ua))
            $browser = 'chromium';
    elseif(preg_match('/(chrome)[ \/]([\w.]+)/', $ua))
            $browser = 'chrome';
    elseif(preg_match('/(safari)[ \/]([\w.]+)/', $ua))
            $browser = 'safari';
    elseif(preg_match('/(opera)[ \/]([\w.]+)/', $ua))
            $browser = 'opera';
    elseif(preg_match('/(msie)[ \/]([\w.]+)/', $ua))
            $browser = 'msie';
    elseif(preg_match('/(mozilla)[ \/]([\w.]+)/', $ua))
            $browser = 'mozilla';

    preg_match('/('.@$browser.')[ \/]([\w]+)/', $ua, $version);
	
	
	
	//os
	$user_agent = $ua;

    $os_platform    =   "Unknown OS Platform";
	$os_version    =   "Unknown OS Version";

    $os_array       =   array(
            '/windows nt 10.0/i'    =>  'Windows 10',
			'/windows nt 6.2/i'     =>  'Windows 8',
            '/windows nt 6.1/i'     =>  'Windows 7',
            '/windows nt 6.0/i'     =>  'Windows Vista',
            '/windows nt 5.2/i'     =>  'Windows Server 2003/XP x64',
            '/windows nt 5.1/i'     =>  'Windows XP',
            '/windows xp/i'         =>  'Windows XP',
            '/windows nt 5.0/i'     =>  'Windows 2000',
            '/windows me/i'         =>  'Windows ME',
            '/win98/i'              =>  'Windows 98',
            '/win95/i'              =>  'Windows 95',
            '/win16/i'              =>  'Windows 3.11',
            '/macintosh|mac os x/i' =>  'Mac OS X',
            '/mac_powerpc/i'        =>  'Mac OS 9',
            '/linux/i'              =>  'Linux',
            '/ubuntu/i'             =>  'Ubuntu',
            '/iphone/i'             =>  'iPhone',
            '/ipod/i'               =>  'iPod',
            '/ipad/i'               =>  'iPad',
            '/android/i'            =>  'Android',
            '/blackberry/i'         =>  'BlackBerry',
            '/webos/i'              =>  'Mobile'
                        );

    foreach ($os_array as $regex => $value) { 
		
		
        if (preg_match($regex, $user_agent)) {
            $os_platform    =   $value;
			$ex=explode('; ',$user_agent);
			//echo "<hr/>ex2=".$ex[2];
			if(@$ex[2]){
				$ex2=explode(')',$ex[2]);
				if($ex2[0]){
					$os_version=$ex2[0];
				}
			}
        }

    }   
	
	
	if($array){
		return array('BrowserName'=>@$browser,'BrowserVersion'=>$version[2],'OSName'=>$os_platform,'OSBit'=>@$os_version);
	}else{
		return @$browser.",".@$version[2].",".@$os_platform.",".@$os_version;
	}
}



?>