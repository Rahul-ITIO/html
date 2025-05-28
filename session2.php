<?php
//https://stackoverflow.com/questions/3219178/php-how-to-get-local-ip-of-system


$publicIP = file_get_contents("http://ipecho.net/plain");

echo "<hr/><br/>publicIP=>";
echo $publicIP;

$localIp = gethostbyname(gethostname());

echo "<hr/><br/>localIp=>";
echo $localIp;




function GetIPs(){
    $ipconfig=shell_exec('ipconfig');
    print_r($ipconfig);
    $sa = explode("\n",@$ipconfig);
    $ipa = [];
    foreach($sa as $i){
        if (strpos($i,'IPv4 Address')!==false){
            $ipa[] = trim(explode(':', $i)[1]);
        }
    }
    return($ipa);
}

$GetIPs=GetIPs();

echo "<hr/><br/>GetIPs=>";
print_r($GetIPs);



function get_local_ipv4() {
    $out = split(PHP_EOL,shell_exec("/sbin/ifconfig"));
    $local_addrs = array();
    $ifname = 'unknown';
    foreach($out as $str) {
      $matches = array();
      if(preg_match('/^([a-z0-9]+)(:\d{1,2})?(\s)+Link/',$str,$matches)) {
        $ifname = $matches[1];
        if(strlen($matches[2])>0) {
          $ifname .= $matches[2];
        }
      } elseif(preg_match('/inet addr:((?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:[.](?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3})\s/',$str,$matches)) {
        $local_addrs[$ifname] = $matches[1];
      }
    }
    return $local_addrs;
  }
  
  $addrs = get_local_ipv4();
  var_export($addrs);

?>
