<?php
	if(isset($_REQUEST['i'])){
		phpinfo();
		exit;
	}
	else{
		header('Content-Type: text/plain');
	}
    session_start();
    if(!isset($_SESSION['visit']))
    {
        echo "This is the first time you're visiting this server\n";
        $_SESSION['visit'] = 0;
    }
    else
            echo "Your number of visits: ".@$_SESSION['visit'] . "\n";

    @$_SESSION['visit']++;

    echo "Server IP: ".@$_SERVER['SERVER_ADDR'] . "\n";
    echo "Client IP: ".@$_SERVER['REMOTE_ADDR'] . "\n";
    
	echo "HTTP_CLIENT_IP: ". @$_SERVER['HTTP_CLIENT_IP'] . "\n";
    echo "HTTP_X_FORWARDED_FOR: ". @$_SERVER['HTTP_X_FORWARDED_FOR'] . "\n";
    print_r($_COOKIE);

    $remote  = @$_SERVER['REMOTE_ADDR'];
	
	$client = isset($_SERVER['HTTP_CLIENT_IP']) 
    ? $_SERVER['HTTP_CLIENT_IP'] 
    : (isset($_SERVER['HTTP_X_FORWARDED_FOR']) 
      ? $_SERVER['HTTP_X_FORWARDED_FOR'] 
      : $_SERVER['REMOTE_ADDR']);

    if(filter_var($client, FILTER_VALIDATE_IP))
    {
        $ip = $client;
    }
    else
    {
        $ip = $remote;
    }
   echo "Remote Client IP: ".@$ip . "\n";

    $ipaddress = '';
      if (getenv('HTTP_CLIENT_IP'))
          $ipaddress = getenv('HTTP_CLIENT_IP');
      else if(getenv('HTTP_X_FORWARDED_FOR'))
          $ipaddress = getenv('HTTP_X_FORWARDED_FOR');
      else if(getenv('HTTP_X_FORWARDED'))
          $ipaddress = getenv('HTTP_X_FORWARDED');
      else if(getenv('HTTP_FORWARDED_FOR'))
          $ipaddress = getenv('HTTP_FORWARDED_FOR');
      else if(getenv('HTTP_FORWARDED'))
          $ipaddress = getenv('HTTP_FORWARDED');
      else if(getenv('REMOTE_ADDR'))
          $ipaddress = getenv('REMOTE_ADDR');
      else
              $ipaddress = 'UNKNOWN';
    echo "2 Remote Client IP: ".$ipaddress . "\n";

    echo "3 Remote Client IP: ".(@$_SERVER['HTTP_X_FORWARDED_FOR']?:@$_SERVER['HTTP_CLIENT_IP']). "\n";
    
	echo "4 Remote Client IP: ".(@$_SERVER['HTTP_X_FORWARDED_FOR']?@$_SERVER['HTTP_X_FORWARDED_FOR']:@$_SERVER['REMOTE_ADDR']). "\n\n";
	echo "HTTPS: ".(@$_SERVER["HTTPS"]). "\n";
	echo "HTTP_HOST: ".(@$_SERVER["HTTP_HOST"]). "\n";
	echo "SERVER_NAME: ".(@$_SERVER["SERVER_NAME"]). "\n";
	
	
	
	if(isset($_GET['l'])){
		
				
		echo "<br/> <br/> gethostbyaddr=> ".  gethostbyaddr($_SERVER['REMOTE_ADDR'])."\n";
		echo "<br/><br/> COMPUTERNAME=> ". getenv('COMPUTERNAME')."\n";
		echo "<br/><br/>Device SERVER_SIGNATURE=> ".$_SERVER['SERVER_SIGNATURE']."\n";

		echo "<br/>Device gethostname=> ".gethostname()."\n";
		echo "<br/><br/>Device Name=> ".php_uname('n')."\n";
		//echo "php_uname=> ".php_uname('n')."\n";
		//echo PHP_OS;


		echo '<pre>';
		echo '(void): '.php_uname()."\n"; // output: "(void): Linux web989.uni5.net 4.4.180 #1 SMP Wed May 22 15:27:37 -03 2019 x86_64"
		echo 'a: '.php_uname('a')."\n"; // output: "a: Linux web989.uni5.net 4.4.180 #1 SMP Wed May 22 15:27:37 -03 2019 x86_64"
		echo 'm: '.php_uname('m')."\n"; // output: "m: x86_64"
		echo 'n: '.php_uname('n')."\n"; // output: "n: web989.uni5.net"
		echo 'r: '.php_uname('r')."\n"; // output: "r: 4.4.180"
		echo 's: '.php_uname('s')."\n"; // output: "s: Linux"
		echo 'v: '.php_uname('v')."\n"; // output: "v: #1 SMP Wed May 22 15:27:37 -03 2019"
		// echo file_get_contents('/etc/issue')."\n";

		echo '</pre>';
		
	}
	
	
	
?>