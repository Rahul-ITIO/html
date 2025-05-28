<?php
$server_key=1;$kms_salts=1;
# Server key from Other server call by curl this key update 90days wise

//core key if not to be get other server
        $data_key['serverKey']=array(
			1=>'wJzWyO01oWnCgr5q7kYRdqZFFw4vp5PyAnBj1N0mRm6MTesPFk5R5Laap6p1Z7J4Y5IwFvx2Q5DwB8LJ9rrGb9kCeBwtWI6flfJyTKa'
        );


		# Private key 
        # KEK (Key Encryption Key) by Curl
        $kekPost['kmsreq']=1;
        $kek_kms = curl_init();
        //curl_setopt($kek_kms,CURLOPT_URL,"http://3.108.217.50:98/kekkms_key_for_app.php"); // pub
        curl_setopt($kek_kms,CURLOPT_URL,"http://172.31.9.45:98/kekkms_key_for_app.php"); //pri
		curl_setopt($kek_kms,CURLOPT_HEADER,0); // Colate HTTP header
        curl_setopt($kek_kms,CURLOPT_RETURNTRANSFER,true);
		curl_setopt($kek_kms,CURLOPT_POST,1);
		curl_setopt($kek_kms,CURLOPT_POSTFIELDS,$kekPost);
		curl_setopt($kek_kms,CURLOPT_RETURNTRANSFER,1);
		curl_setopt($kek_kms,CURLOPT_SSL_VERIFYPEER, false); 
		curl_setopt($kek_kms,CURLOPT_SSL_VERIFYHOST, false);
        $kek_output=curl_exec($kek_kms);
        curl_close($kek_kms);
        $data_salts=json_decode($kek_output,true);

        // echo "<br/><br/>data_salts=>".$kek_output;echo "<br/><br/>data_salts=>"; print_r($data_salts);exit;
		

if ( isset($data_key['serverKey']) && $data_key['serverKey'] != "" && $data_key['serverKey'] != null ){
        $server_key_lastvalue = array_keys($data_key['serverKey']);
        $server_key = $server_key_lastvalue[sizeof($server_key_lastvalue)-1];
}

if ( isset($data_salts['saltsKey']) && $data_salts['saltsKey'] != "" && $data_salts['saltsKey'] !=null ){
        $kms_salts_lastvalue = array_keys($data_salts['saltsKey']);
        $kms_salts = $kms_salts_lastvalue[sizeof($kms_salts_lastvalue)-1];
}


//print_r($data_key); echo "<hr/>Key=> ".$data_key['serverKey'][$server_key]; echo "<hr/>server_key=> ".$server_key."<hr/>" ; print_r($data_salts); echo "<hr/>salts=> ".$data_salts['saltsKey'][$kms_salts]; echo "<hr/>kms_salts=> ".$kms_salts."<hr/>" ;


//$server_key=1;
function getKeys256($key='') {
        global $data_key; global $server_key;
        if(!empty($key)){
			$server_key=$key;
		}
        $key=$data_key['serverKey'][$server_key];
        return $key;
}
function getPrivateSaltsKeys($key='') {
        global $data_salts; global $kms_salts;
        if(!empty($key)){
                $kms_salts=$key;
        }
        $key=$data_salts['saltsKey'][$kms_salts];
        return $key;
}
function card_encryption_required($ccno) {
        global $data_key; global $server_key; global $kms_salts;
        $publicKey = getKeys256();
        $privateSaltsKey = getPrivateSaltsKeys();
        $ccno   = substr($ccno, -4);
        $encryptedData=encrypts256($ccno, $publicKey, $privateSaltsKey);
        $ccno='{"decrypt":"'.urlencode($encryptedData).'","key":"'.$server_key.'","saltsKey":"'.$kms_salts.'","encode":"1"}';
        return $ccno;
}
function card_decryption_required($ccno) {
        $not_encrypted=jsonvaluef($ccno,"not_encrypted");
        if($not_encrypted){
                $ccno=jsonvaluef($ccno,"decrypt");
        }else{


                $server_key=jsonvaluef($ccno,"key");
                $publicKey = getKeys256($server_key);

                $saltsKey=jsonvaluef($ccno,"saltsKey");
                if((isset($saltsKey))&&(!empty($saltsKey))){
                        $server_key=$saltsKey;
                }

                $privateSaltsKey = getPrivateSaltsKeys($server_key);

                $encode=$ccno;
                $ccno=jsonvaluef($ccno,"decrypt");
                if(($encode)&&(strpos($encode,"encode")!==false)){
                        $ccno=urldecode($ccno);
                }

                $ccno=decrypts256($ccno, $publicKey, $privateSaltsKey);
                //$ccno=ccnois($ccno);

                if(strlen($ccno)>4){
                        $ccno=ccnois($ccno);
                }else{
                        $ccno=ccnois('XXXXXXXXXXXX'.$ccno);
                }
                //echo "<br/>ccno=>".$ccno=($ccno);
        }


        return $ccno;
}
function checkKeys256($key, $method) {
        if (strlen($key) < 32) {
                echo "Invalid public key $key, key must be at least 256 bits (32 bytes) long.";
                //die();
        }
}

# Decrypt a value using AES-256.
function decrypts256($cipher, $key, $salts='', $hmacSalt=''){
        //global $salts;
        checkKeys256($key, 'decrypts256()');
        if(empty($cipher)) {
                //echo 'The data to decrypt cannot be empty.';
                //die();
        }
        if(empty($hmacSalt)) {
                $hmacSalt = $salts;
        }
        //echo "<hr/>cipher= ".$cipher;echo "<hr/>key= ".$key;echo "<hr/>hmacSalt= ".$hmacSalt;
        $key = substr(hash('sha256', $key . $hmacSalt), 0, 32); # Generate the encryption and hmac key.

        # Split out hmac for comparison
        $macSize = 64;
        $hmac = substr($cipher, 0, $macSize);
        $cipher = substr($cipher, $macSize);

        $compareHmac = hash_hmac('sha256', $cipher, $key);
        if ($hmac !== $compareHmac) {
                return false;
        }

        $algorithm = MCRYPT_RIJNDAEL_128; # encryption algorithm
        $mode = MCRYPT_MODE_CBC; # encryption mode
        $ivSize = mcrypt_get_iv_size($algorithm, $mode); # Returns the size of the IV belonging to a specific cipher/mode combination

        $iv = substr($cipher, 0, $ivSize);
        $cipher = substr($cipher, $ivSize);

        //echo "<hr/>algorithm22= ".$algorithm;echo "<hr/>key= ".$key;echo "<hr/>cipher= ".$cipher;echo "<hr/>mode= ".$mode;echo "<hr/>iv= ".$iv;

        $plain = mcrypt_decrypt($algorithm, $key, $cipher, $mode, $iv);
        return rtrim($plain, "\0");
}

# Encrypt a value using AES-256.
function encrypts256($plain, $key, $salts='', $hmacSalt='') {
        //global $salts;
        checkKeys256($key, 'encrypts256()');
        if(empty($plain)) {
                //echo 'The data to encrypt cannot be empty.';
                //die();
        }
        if(empty($hmacSalt)) {
                $hmacSalt = $salts;
        }

        $key = substr(hash('sha256', $key . $hmacSalt), 0, 32); # Generate the encryption and hmac key

        $algorithm = MCRYPT_RIJNDAEL_128; # encryption algorithm
        $mode = MCRYPT_MODE_CBC; # encryption mode

        $ivSize = mcrypt_get_iv_size($algorithm, $mode); # Returns the size of the IV belonging to a specific cipher/mode combination
        $iv = mcrypt_create_iv($ivSize, MCRYPT_DEV_URANDOM); # Creates an initialization vector (IV) from a random source
        $ciphertext = $iv . mcrypt_encrypt($algorithm, $key, $plain, $mode, $iv); # Encrypts plaintext with given parameters
        $hmac = hash_hmac('sha256', $ciphertext, $key); # Generate a keyed hash value using the HMAC method
        return $hmac . $ciphertext;
}
#Get Random String - Usefull for public key
function genRandString($length = 0) { //genRandString(32);
        $charset = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ@$%^';
        $str = '';
        $count = strlen($charset);
        while ($length-- > 0) {
                $str .= $charset[mt_rand(0, $count-1)];
        }
        return $str;
}
//echo "<hr/>".genRandString(256);
//echo "<hr/>".genRandString(32);
?>
