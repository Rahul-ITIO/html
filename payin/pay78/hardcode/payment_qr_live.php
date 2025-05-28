<?php
// http://localhost/gw/payin/pay78/hardcode/payment_qr_live.php

//$url = "https://merchantprod.timepayonline.com/evok/qr/v1/dqr";
$url = "http://65.1.5.130/evok/qr/v1/dqr";
// {"source":"SKYWA0700","extTransactionId":"SKYWA","terminalId":"SKYWA-0700","sid":"SKYWA-0700","Encryption_key":"9f8fdc5be230f7130f44ae0869e97b5a","key":"48a431d06097db42696ba30043d15f41","Checksum_key":"19d81ced01ebad333381df5bdbb277a5"}
$req = [
        'source' => 'SKYWA0700',
        'channel' => 'api',
        'extTransactionId' => "SKYWA".'782'.date('ymdHis'),
		'sid' => 'DEKLI-6003',
        'terminalId' => 'SKYWA-0700',
       'amount' => '5.01',
	    'type' => 'D',
		'remark' => 'test',
		'requestTime' => date("Y-m-d H:i:s"),
		'minAmount' => '6.01',
    ];
	$checksum='';
    foreach ($req as $val){
        $checksum.=$val;
    }
	$checksum_string=$checksum.'19d81ced01ebad333381df5bdbb277a5';
    $req['checksum']=hash('sha256',$checksum_string);
	$key= '9f8fdc5be230f7130f44ae0869e97b5a';
    $key=substr((hash('sha256',$key,true)),0,16);
	 $cipher='AES-128-ECB';
	 $encrypted_string=openssl_encrypt(
        json_encode($req),
        $cipher,
        $key
    );
	$curl = curl_init();

   curl_setopt_array($curl, array(
  CURLOPT_URL => $url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>$encrypted_string,
  CURLOPT_HTTPHEADER => array(
    'cid: 48a431d06097db42696ba30043d15f41',
    'Content-Type: text/plain'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
//echo $response;
$decrypted_string = openssl_decrypt(
        $response,
        $cipher,
        $key
    );
	$res = json_decode($decrypted_string,true);
	//print_r($res);
	 $qrcode = $res['qrString'];
?>
 <img src="https://quickchart.io/chart?chs=200x200&cht=qr&chl=<?=$res['qrString'];?>&choe=UTF-8" title=""/>