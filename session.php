<?php
	if(isset($_REQUEST['i'])){
		phpinfo();
		exit;
	}
	else{
		//header('Content-Type: text/plain');
	}
    session_start();

    $publicIP = file_get_contents("http://ipecho.net/plain");

echo "<hr/><br/><b>IV4 Instance IP (Public IP):</b> ".$publicIP."<br/><br/>";

$localIp = gethostbyname(gethostname());

echo "<hr/><br/><b>Instance Private IP:</b> ".$localIp;

echo "<br/><br/><hr/><br/>";

    if(!isset($_SESSION['visit']))
    {
        echo "This is the first time you're visiting this server<br/><br/>";
        $_SESSION['visit'] = 0;
    }
    else
            echo "Your number of visits: ".@$_SESSION['visit'] . "<br/><br/>";

    @$_SESSION['visit']++;

    echo "Server IP: ".@$_SERVER['SERVER_ADDR'] . "<br/><br/>";
    echo "Client IP: ".@$_SERVER['REMOTE_ADDR'] . "<br/><br/><hr/><br/>";
    
	echo "HTTP_CLIENT_IP: ". @$_SERVER['HTTP_CLIENT_IP'] . "<br/>";
    echo "HTTP_X_FORWARDED_FOR: ". @$_SERVER['HTTP_X_FORWARDED_FOR'] . "<br/>";
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
   echo "<br/><br/>1 Remote Client IP: ".@$ip . "<br/>";

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
    echo "2 Remote Client IP: ".$ipaddress . "<br/>";

    echo "3 Remote Client IP: ".(@$_SERVER['HTTP_X_FORWARDED_FOR']?:@$_SERVER['HTTP_CLIENT_IP']). "<br/>";
    
	echo "4 Remote Client IP: ".(@$_SERVER['HTTP_X_FORWARDED_FOR']?@$_SERVER['HTTP_X_FORWARDED_FOR']:@$_SERVER['REMOTE_ADDR']). "<br/><br/>";
	echo "HTTPS: ".(@$_SERVER["HTTPS"]). "<br/>";
	echo "HTTP_HOST: ".(@$_SERVER["HTTP_HOST"]). "<br/>";
	echo "SERVER_NAME: ".(@$_SERVER["SERVER_NAME"]). "<br/>";
	
	
	
	if(isset($_GET['l']))
    {
		
		echo "<br/><hr/><br/>";		
		echo "<br/> gethostbyaddr=> ".  gethostbyaddr($_SERVER['REMOTE_ADDR'])."<br/>";
		echo "<br/><br/> COMPUTERNAME=> ". getenv('COMPUTERNAME')."<br/>";
		echo "<br/><br/>Device SERVER_SIGNATURE=> ".$_SERVER['SERVER_SIGNATURE']."<br/>";

		echo "<br/>Device gethostname=> ".gethostname()."<br/>";
		echo "<br/><br/>Device Name=> ".php_uname('n')."<br/>";
		//echo "php_uname=> ".php_uname('n')."<br/>";
		//echo PHP_OS;


		echo '<pre>';
		echo '(void): '.php_uname()."<br/>"; // output: "(void): Linux web989.uni5.net 4.4.180 #1 SMP Wed May 22 15:27:37 -03 2019 x86_64"
		echo 'a: '.php_uname('a')."<br/>"; // output: "a: Linux web989.uni5.net 4.4.180 #1 SMP Wed May 22 15:27:37 -03 2019 x86_64"
		echo 'm: '.php_uname('m')."<br/>"; // output: "m: x86_64"
		echo 'n: '.php_uname('n')."<br/>"; // output: "n: web989.uni5.net"
		echo 'r: '.php_uname('r')."<br/>"; // output: "r: 4.4.180"
		echo 's: '.php_uname('s')."<br/>"; // output: "s: Linux"
		echo 'v: '.php_uname('v')."<br/>"; // output: "v: #1 SMP Wed May 22 15:27:37 -03 2019"
		// echo file_get_contents('/etc/issue')."<br/>";

		echo '</pre>';
		
	}
	
	
	
?>