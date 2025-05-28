<?php
//$host = $_SERVER['REMOTE_ADDR'];
error_reporting(0);
final class ip2location_lite{
	protected $errors = array();
	protected $service = 'api.ipinfodb.com';
	protected $version = 'v3';
	protected $apiKey = '70086838bc895a777771af798f46975eb86c6a175e60412e6057ebba85b44823';

	public function __construct(){}

	public function __destruct(){}

	public function setKey($key){
		if(!empty($key)) $this->apiKey = $key;
	}

	public function getError(){
		return implode("\n", $this->errors);
	}

	public function getCountry($host){
		return $this->getResult($host, 'ip-country');
	}

	public function getCity($host){
		return $this->getResult($host, 'ip-city');
	}

	private function getResult($host, $name){
		$ip = @gethostbyname($host);

		// if(filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV6)){
		if(filter_var($ip, FILTER_VALIDATE_IP)){
			$xml = @file_get_contents('http://' . $this->service . '/' . $this->version . '/' . $name . '/?key=' . $this->apiKey . '&ip=' . $ip . '&format=xml');
			
			//echo "<br/>PHP VER=>".(int)phpversion();
			
			if((int)phpversion()>8){
				if (get_magic_quotes_runtime()){
					$xml = stripslashes($xml);
				}
			}

			try{
				$response = @new SimpleXMLElement($xml);

				foreach($response as $field=>$value){
					$result[(string)$field] = (string)$value;
				}

				return $result;
			}
			catch(Exception $e){
				$this->errors[] = $e->getMessage();
				return;
			}
		}

		$this->errors[] = '"' . $host . '" is not a valid IP address or hostname.';
		return;
	}
}

?>