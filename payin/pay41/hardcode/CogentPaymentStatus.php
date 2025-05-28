<?php
echo "<br/>STATUS=><br/>";
//control will send from here for status this is same process like payment
$postreq['login'] = "CogentPayments_LP";
$postreq['client_orderid'] = "902B4FF56";
$postreq['orderid'] = "1969106";

$postreq['merchant_control']="1B962E87-86C5-4863-90B2-FB58D8721717";

$str = $postreq['login'].''.$postreq['client_orderid'].''.$postreq['orderid'].''.$postreq['merchant_control'];
   //echo $str;
   
  echo  $checksum = sha1($str);
  
  
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://sandbox.lonapay24.com/payment/api/v2/status/group/2545',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => 'login=CogentPayments_LP&client_orderid=902B4FF56&orderid='.$postreq['orderid'].'&control='.$checksum,
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded',
    'Authorization: Bearer bOpEE0OQAEjobPfVvyGGVfTICAx6'
  ),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;


/*

<br/>STATUS=><br/>c54407a47dd7c7a2f32825fe3c462fb534600608type=status-response
&serial-number=00000000-0000-0000-0000-0000043b64d7
&merchant-order-id=902B4FF56
&paynet-order-id=1969105
&status=processing
&amount=10.42
&currency=EUR
&original-gate-descriptor=Callkey+LP+TEST+EUR
&html=%3C%21DOCTYPE+html%3E%0A%3Chtml%3E%0A%3Chead%3E%0A++++%3Cmeta+http-equiv%3D%22content-type%22+content%3D%22text%2Fhtml%3B+charset%3DUTF-8%22%3E%0A++++%3Ctitle%3ERedirecting+...%3C%2Ftitle%3E%0A++++%3Cscript+type%3D%22text%2Fjavascript%22+language%3D%22javascript%22%3E%0A++++++++function+makeSubmit%28%29+%7B%0A++++++++++++document.returnform.submit%28%29%3B%0A++++++++%7D%0A++++%3C%2Fscript%3E%0A%3C%2Fhead%3E%0A%0A%3Cbody+onLoad%3D%22makeSubmit%28%29%22%3E%0A%3Cform+name%3D%22returnform%22+action%3D%22https%3A%2F%2Fsandbox.lonapay24.com%2Fpayment%2Ftest_ddd_done_sale.html%22+method%3D%22POST%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22cavv%22+value%3D%22caav%3D%3D%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22base64-test%22+value%3D%22eNrNmFmT4jjWhv9KRc8lU%2B0d7AoyI%2BTdgI33hZsJb3hfwMY2%2FvVjoLI6u6Lii%2B6%2B%2BYZIB%2FJJ6ehIevUcoa2ZXuOYNeLwdo3ft3LcdX4Sf8mit99M1viPCvT48m1DxhucgH2U%2FPY1JBAqCJFvCIZRCBxFZEh9%2B4pFcfzb%2B%2FZRu3u2fZb%2BvoMhvnZZU78jv8O%2Fo1vo43UJ6xqmft2%2Fb%2F3wQkvKO74mUHi9hb6%2Fbqv4KrHfrTCKksgahpEt9DJvoT%2Faq7dHqVuGOmXRO%2BBLEexoLbadKV4Z5%2FAQepIXm4wFv22hR41t5PfxOwojjw%2F6BUG%2FIfg3Yun5ad%2B2D3egam6Lb4KiiC302bJdJvUa1%2BH9ncThLfTjbRtPbVPHS41lkD%2FKW%2BiP4Fq%2Ffoc%2FfUgcJxffi3Vruu%2FbPqt%2BCmr9DVnG%2B7Rvu97vb927t4W%2Bl7ahPwzvAAAaWFqja0sJ7LIyS3kueZTBMthnlW0cZu%2FwMorH97MVKJPmmvVp9Qj1z4Yt9AgFei71%2B9bIknrp7Bp%2Fmaqy7t5%2BS%2Fu%2B%2FQZB4zj%2BPmK%2FN9cEQpeBQDAFLRWiLkv%2B9durVRxJ9bn5W80Yv27qLPTLbPb7RSFy3KdN9OVHbL9yY%2BoPTwikc8zXxdXXEMHrrw8LjCHE4hP6tdNPI%2Fsrvfwc7LXzv3apjzw6%2BMnR%2B1aPz%2FFDEfEXS5fefvvXP9w1bJbEXf9PovuI7LOHD3%2B2X97i95JPIEeouUOyolo3P4%2FX9Z29ee7lMr59tHvV3EI%2FhvN9rK%2BF%2FTSBr4qFGE3tHFQxOfut0hT4OWCxwquy%2FV60L8JaG2CIZYZkA1jROyfjHLj8cMdPRdAGanIQz1dANWt5DO54wFbTpjUEEK6ue%2B108UxFL4YaP%2FImo6SWeNCg6%2F7iwc3spU6i8fx4i%2FawIKjVqc%2BKeYefq8uOMHhU3nhS1DE61uVZSuozsGFt15Nvnxbt%2Byj38f01KpeAKdbv%2FVfJuAV5HPaKv2xARnmz42t2zuKIvttZ58fndvnDohZBNy0CD%2F%2F%2BcrTedAN8Ye5N7y9vb%2FH5VkfdF6a5ts31qb5%2Ff2HeLGML%2Fez82RsTX%2FvFf%2FhgkCxJbD0zDBizBIwSDRJJB0eTj%2FED5e0cr8wH2q3OXjpoI6t5u31zktIhVIDG8bQGRnfmDjIoBIBYHJ3KjG3LE2uCA50oNg0ak%2BZPOwvmJpkFt5etM3fIqQ1RLjEcAj65u0UPehugRBowtLm8o76jlBLHzyFK5b7Dw75D3cKZU2UAP%2FsBkyycDMTxXSWVadxlTW6UWWtUWA6TZ2uWy%2BZhu%2F%2FJhjTj6RexCjM4fcTKVXYVOUQR3mk2wHbj8qSRUA5BzhkyDZ7tmEneWaVCS5xCBJieykY47jSPtTWN5SbCWeJvT1VZnrgdYVfl7Dl2FQrLwypFyHJ3BVuiF70xOZE%2Fzye9zCebeDCQJWEHGoEGu9qC%2Br1fH6jDAY0aRBNdj5rStMTXdZuYc2cYwckc1fkqbfxs318JzbeueDzzcnVfyZnlxyMjaU2X1hzL6PORt7IUPspznAsoerMYLsf9ddz0bs5Be99muzAPmBree%2BfbJfHFHjnvwGWEo9iM7NVpthtYhpED0d%2BdBPKZxr22p%2BIUS%2BZJB8kyQ0DIk4TXF03RpgnUx7yKGkmDM8nRmszSOAAyTT7mMZJGzZNpH%2FBHq9Oqzt2LEWtZkFpcbelsmDUiTzcZjM%2B63MjR0KgxMgDj8THXOpzQrDS%2BNGXXibb0bYJSZmSBYToBaBZPL1rm06iJRH08ZuQQYRF2qJ%2B6u3ko1R8w%2BuqbDN2Bp78zLQnNMu%2BLj0uy34MqzfQfbXWHuAfo1L3a87lnEHmAwsPJfmibZ7XlPazGMVrTSCMehdCZCs8F68Od4oN6NwTCAo6nFpT0UClDYDbzkS0GD8WpDx0fBJKyi9LUjGmIzJdN4spbJNj3oHrtAc8ZEwu174uv%2FGTQdIgpi4%2Fyu0apfNHeUu%2FUeigPn%2BxdGVVU%2Fn1vyYs%2FWKaf%2BydiE82habNQV1ztlOuQHVKe9kkqikecd86iwQKFTopLWmQCNcL0Yz4BONKJBs42bTvOikzKHei0g9xTQRF0qkRZ1M6cClKJQHmAcG6vJFyD00p%2Br8s4UAKnPhcEtlqzlr5LZtxJXayCEzIr46wH2JTH7u3gM2YLu3Xg8Q1g3GG1Q0qsJQJCO11ZFsv4ieRhZ9DXlELP9GhtDodwVDdOU3O7OtCjfqXdKzGlpMJHN5MI3t5e%2BPtMu1%2Fhj0vNBX8o%2Bgf%2BVMaK3ZUAjoTK114rYAx1E6Rf4s%2F%2Fi%2Fg7zKD%2Fgb%2Fy7%2BNP1sdRSD4wo7zkIdhsgCL90uYhByNAKfiFQ4DIrDzKOUfIrDYd%2BScOXzbzh%2B3%2FH92ScH7YGeMiGFKAsQsCF6kBgAsKYBk60%2FaL5FjTs8UUkzzLRgd4I98cr7llxOVwxPsb08SqCJSjcm36CUlZhgoZZwdO602wYfrVqJIdMEtNIGyjFSF3qqgGrK5BlhfhflYGKy9twV75%2BbGDexI0SGHzRGjSEpEgZ170JYOIyQhjFKxGk7y6yKO7iPNCwIMAg25VmDmsskDaG8VEBXKvSSzQAN3gEt3li6Z8fBTHJ15ymk7GRdYWb2YsO5OdioFZ7BABSmJZOrLuuAlHLnnWNYEmQosQRzp5YE96oI14otQAnJyDUWZwgXZiGixYlBlrlEZP2o%2Fekj4sESScw6MpHIlP%2FCzQC1%2Fo%2BY6sUOjbB56Z8QN7i%2F%2BcoaEZoA1rJHLjjb6owyHbDAfYvoUV1QUMgT7Wy%2FtA51MDC%2FacT%2FqzF8xh2s3Ddp3M3pPjBeBpfvozfqsHzn5CoUE90Dk8U6Wl0CdrsTlIGVZKaVXUEDEvtCaenyTecXkY4Vz9dbw%2B%2FRp0qS1xB45991ArefmdBvWJb64LMOuj3i6o9aVv4oXUiu8kXinD%2BoFUK9FcZQ5QpX1pHoe8B4qFslo0v9S3jZN7Gh7ofWjeFMo5Yh%2FM%2FJQCgcwAzRvFVwo70rTH%2Fd%2Fp7897g37ujWW9NIZ39GOHXeAkPUTcktJrqrjYAq31F8uOxEwEI1bgbIUZR8oSaWaYz2xRazkWF0jQNIvtnEYub69XRbwkFGO13jWpYWLchggENCjanc4KfQ0rK6vsmGzWoplYq3kPBd1GgmhbPwir2tpXexfno2x%2FdPEVPnYMT1U3jvO8WFwh9B6SNqZcGNk1JjeR0rbnwp0h0N597K4JpWWsh6aU8DonAj3YQBeD7PtgRaRViRm0a%2FZj4wyTNd4RKGx1r2v4kaxOeZJCB8G%2BtsKmqtldiEWOuymy0%2BpAZhmrIT7GD%2BxkJViEW9M1EjZ3TptzX4SQlcHt76FwLnjCmLO1dYo5nGvZhIb4vlHs1ezCfy1dsM1jazeXj3ShcbiHmDoM0cOBXjkWj5xA6OW%2FyKAsfZW1bmRep0WBG3e2NXOKDLrXyTKVuecJwOQGmYE%2FTpvVP5DmJLLAfyF7Af53ZH%2FeWhL%2F3K6jmIaKvJyklFxCl%2B%2FpyMqo87DlTxu8oH9Scu7u5P97sScJl%2F06fUg0O4LH%2F%2FegeW6XwaYIR6zWKVoxU8mcDzzViSrO8CaZhX3PwgEMqVWUpyi5k1z20h1NVRTRy2GXw1flbEvdSaRBgXNly286Vh07XT9yzgrR9mSg%2B%2FZ%2Bg63Rq7pPRCSBuOKUqBKa4iKm2jM%2Bi0Mvkn5jl2Nkny4OcjA2XsJX93ZEMf02ph5EIpe1xcz3K2yqxIY66VHKoQ1ZMSo64qW6o%2BYwXFkYfL2gFHU%2FSvNcXrGJ38zGLe95p%2FNrqvPcbBQiiK6afSM7N7aVoAJfNftOEOLSJHFg0iu4H2Zyr%2FJWcjTGDgglXFoXUjrs2zi2vOwkNBg9KZtNv1LGPoLyqsz4vQyEuRPEiR7O%2FiFy47W3QzkCwvuPE7%2BWLysFyM8ndV5ezvkL8kb2ldLUV0rT2CU9CX8%2BhWr2UZJV9T5CISvHsxWsaHxMcOXM9vMvT6ELQjngQjx9dqeQORRXXHEMHWprd2%2BZ4yin1b1ffvkEqmNhO%2Bhig75SFczlmtIJ9ZkxOhjWu9DHlwN%2FxzYN6fX3Yn2OLcfjFVyVmYH3VCxHpHl3QIqCON8y6BwI%2B7QPAxU70GctYuyWgoirujNWptXTObfJQorNC2Y3ayQ2b1btPBfOvtufdhA8UbUrSJPoRQXfRZsBk6nVhvL2zhSnpwnWA23JwWQgVC66Js7HUzseRosULI%2BrDIDCAn3zNH%2FDF3s5VMNxtWKD02X5HRRg1UG56O6aFjIYudQsTGGaLUC1DzWgIQnAVrvNGUoZLL5lUl2m9LS%2BH3qMIudahvKrvz4i0qYyEWHg20Piqp7Ijr88MUN%2F3FRAP24v%2FrjXeF6PPm99Hzd6n2%2BD%2Fwue6z8E%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22mpi_status%22+value%3D%22A%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22eci%22+value%3D%2206%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22token%22+value%3D%221xntDsxIkbphQI-EXriKF0w%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22status%22+value%3D%22approved%22%3E%0A++++%0A++++%3Cnoscript%3E%0A++++++++%3Cinput+type%3D%22submit%22+name%3D%22submit%22+value%3D%22Press+this+button+to+continue%22%2F%3E%0A++++%3C%2Fnoscript%3E%0A%3C%2Fform%3E%0A%3C%2Fbody%3E%0A%3C%2Fhtml%3E
&redirect-to=https%3A%2F%2Fsandbox.lonapay24.com%2Fpayment%2Fform%2Fredirect%2F1969105%2F17IcOCFMVNjehLKnnGTvXMw
&transaction-type=sale
&receipt-id=158e97af-7ffe-3293-a3fe-ac523841a74f
&name=John+Doe
&cardholder-name=John+Doe
&card-exp-month=12
&card-exp-year=2099
&email=john.smith%40gmail.com
&order-stage=sale_3d_validating
&last-four-digits=6732
&bin=453897
&card-type=VISA
&phone=12063582043
&bank-name=UNKNOWN
&paynet-processing-date=2024-03-20+08%3A51%3A03+MSK
&card-hash-id=3902982
&card-country-alpha-three-code=JPN
&first-name=John
&last-name=Smith
&ips-src-payment-product-code=F
&ips-src-payment-product-name=Visa+Classic
&ips-src-payment-type-code=Credit
&ips-src-payment-type-name=VISA+Credit
&initial-amount=10.42

*/

/*
 
 269ec1102e96819aec2219675cae1a89779ff7b6type=status-response &serial-number=00000000-0000-0000-0000-0000043b6502 &merchant-order-id=902B4FF56 &paynet-order-id=1969106 &status=processing &amount=10.42 ¤cy=EUR &original-gate-descriptor=Callkey+LP+TEST+EUR &html=%3C%21DOCTYPE+html%3E%0A%3Chtml%3E%0A%3Chead%3E%0A++++%3Cmeta+http-equiv%3D%22content-type%22+content%3D%22text%2Fhtml%3B+charset%3DUTF-8%22%3E%0A++++%3Ctitle%3ERedirecting+...%3C%2Ftitle%3E%0A++++%3Cscript+type%3D%22text%2Fjavascript%22+language%3D%22javascript%22%3E%0A++++++++function+makeSubmit%28%29+%7B%0A++++++++++++document.returnform.submit%28%29%3B%0A++++++++%7D%0A++++%3C%2Fscript%3E%0A%3C%2Fhead%3E%0A%0A%3Cbody+onLoad%3D%22makeSubmit%28%29%22%3E%0A%3Cform+name%3D%22returnform%22+action%3D%22https%3A%2F%2Fsandbox.lonapay24.com%2Fpayment%2Ftest_ddd_done_sale.html%22+method%3D%22POST%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22cavv%22+value%3D%22caav%3D%3D%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22base64-test%22+value%3D%22eNrNmFmT4jjWhv9KRc8lU%2B0d7AoyI%2BTdgI33hZsJb3hfwMY2%2FvVjoLI6u6Lii%2B6%2B%2BYZIB%2FJJ6ehIevUcoa2ZXuOYNeLwdo3ft3LcdX4Sf8mit99M1viPCvT48m1DxhucgH2U%2FPY1JBAqCJFvCIZRCBxFZEh9%2B4pFcfzb%2B%2FZRu3u2fZb%2BvoMhvnZZU78jv8O%2Fo1vo43UJ6xqmft2%2Fb%2F3wQkvKO74mUHi9hb6%2Fbqv4KrHfrTCKksgahpEt9DJvoT%2Faq7dHqVuGOmXRO%2BBLEexoLbadKV4Z5%2FAQepIXm4wFv22hR41t5PfxOwojjw%2F6BUG%2FIfg3Yun5ad%2B2D3egam6Lb4KiiC302bJdJvUa1%2BH9ncThLfTjbRtPbVPHS41lkD%2FKW%2BiP4Fq%2Ffoc%2FfUgcJxffi3Vruu%2FbPqt%2BCmr9DVnG%2B7Rvu97vb927t4W%2Bl7ahPwzvAAAaWFqja0sJ7LIyS3kueZTBMthnlW0cZu%2FwMorH97MVKJPmmvVp9Qj1z4Yt9AgFei71%2B9bIknrp7Bp%2Fmaqy7t5%2BS%2Fu%2B%2FQZB4zj%2BPmK%2FN9cEQpeBQDAFLRWiLkv%2B9durVRxJ9bn5W80Yv27qLPTLbPb7RSFy3KdN9OVHbL9yY%2BoPTwikc8zXxdXXEMHrrw8LjCHE4hP6tdNPI%2Fsrvfwc7LXzv3apjzw6%2BMnR%2B1aPz%2FFDEfEXS5fefvvXP9w1bJbEXf9PovuI7LOHD3%2B2X97i95JPIEeouUOyolo3P4%2FX9Z29ee7lMr59tHvV3EI%2FhvN9rK%2BF%2FTSBr4qFGE3tHFQxOfut0hT4OWCxwquy%2FV60L8JaG2CIZYZkA1jROyfjHLj8cMdPRdAGanIQz1dANWt5DO54wFbTpjUEEK6ue%2B108UxFL4YaP%2FImo6SWeNCg6%2F7iwc3spU6i8fx4i%2FawIKjVqc%2BKeYefq8uOMHhU3nhS1DE61uVZSuozsGFt15Nvnxbt%2Byj38f01KpeAKdbv%2FVfJuAV5HPaKv2xARnmz42t2zuKIvttZ58fndvnDohZBNy0CD%2F%2F%2BcrTedAN8Ye5N7y9vb%2FH5VkfdF6a5ts31qb5%2Ff2HeLGML%2Fez82RsTX%2FvFf%2FhgkCxJbD0zDBizBIwSDRJJB0eTj%2FED5e0cr8wH2q3OXjpoI6t5u31zktIhVIDG8bQGRnfmDjIoBIBYHJ3KjG3LE2uCA50oNg0ak%2BZPOwvmJpkFt5etM3fIqQ1RLjEcAj65u0UPehugRBowtLm8o76jlBLHzyFK5b7Dw75D3cKZU2UAP%2FsBkyycDMTxXSWVadxlTW6UWWtUWA6TZ2uWy%2BZhu%2F%2FJhjTj6RexCjM4fcTKVXYVOUQR3mk2wHbj8qSRUA5BzhkyDZ7tmEneWaVCS5xCBJieykY47jSPtTWN5SbCWeJvT1VZnrgdYVfl7Dl2FQrLwypFyHJ3BVuiF70xOZE%2Fzye9zCebeDCQJWEHGoEGu9qC%2Br1fH6jDAY0aRBNdj5rStMTXdZuYc2cYwckc1fkqbfxs318JzbeueDzzcnVfyZnlxyMjaU2X1hzL6PORt7IUPspznAsoerMYLsf9ddz0bs5Be99muzAPmBree%2BfbJfHFHjnvwGWEo9iM7NVpthtYhpED0d%2BdBPKZxr22p%2BIUS%2BZJB8kyQ0DIk4TXF03RpgnUx7yKGkmDM8nRmszSOAAyTT7mMZJGzZNpH%2FBHq9Oqzt2LEWtZkFpcbelsmDUiTzcZjM%2B63MjR0KgxMgDj8THXOpzQrDS%2BNGXXibb0bYJSZmSBYToBaBZPL1rm06iJRH08ZuQQYRF2qJ%2B6u3ko1R8w%2BuqbDN2Bp78zLQnNMu%2BLj0uy34MqzfQfbXWHuAfo1L3a87lnEHmAwsPJfmibZ7XlPazGMVrTSCMehdCZCs8F68Od4oN6NwTCAo6nFpT0UClDYDbzkS0GD8WpDx0fBJKyi9LUjGmIzJdN4spbJNj3oHrtAc8ZEwu174uv%2FGTQdIgpi4%2Fyu0apfNHeUu%2FUeigPn%2BxdGVVU%2Fn1vyYs%2FWKaf%2BydiE82habNQV1ztlOuQHVKe9kkqikecd86iwQKFTopLWmQCNcL0Yz4BONKJBs42bTvOikzKHei0g9xTQRF0qkRZ1M6cClKJQHmAcG6vJFyD00p%2Br8s4UAKnPhcEtlqzlr5LZtxJXayCEzIr46wH2JTH7u3gM2YLu3Xg8Q1g3GG1Q0qsJQJCO11ZFsv4ieRhZ9DXlELP9GhtDodwVDdOU3O7OtCjfqXdKzGlpMJHN5MI3t5e%2BPtMu1%2Fhj0vNBX8o%2Bgf%2BVMaK3ZUAjoTK114rYAx1E6Rf4s%2F%2Fi%2Fg7zKD%2Fgb%2Fy7%2BNP1sdRSD4wo7zkIdhsgCL90uYhByNAKfiFQ4DIrDzKOUfIrDYd%2BScOXzbzh%2B3%2FH92ScH7YGeMiGFKAsQsCF6kBgAsKYBk60%2FaL5FjTs8UUkzzLRgd4I98cr7llxOVwxPsb08SqCJSjcm36CUlZhgoZZwdO602wYfrVqJIdMEtNIGyjFSF3qqgGrK5BlhfhflYGKy9twV75%2BbGDexI0SGHzRGjSEpEgZ170JYOIyQhjFKxGk7y6yKO7iPNCwIMAg25VmDmsskDaG8VEBXKvSSzQAN3gEt3li6Z8fBTHJ15ymk7GRdYWb2YsO5OdioFZ7BABSmJZOrLuuAlHLnnWNYEmQosQRzp5YE96oI14otQAnJyDUWZwgXZiGixYlBlrlEZP2o%2Fekj4sESScw6MpHIlP%2FCzQC1%2Fo%2BY6sUOjbB56Z8QN7i%2F%2BcoaEZoA1rJHLjjb6owyHbDAfYvoUV1QUMgT7Wy%2FtA51MDC%2FacT%2FqzF8xh2s3Ddp3M3pPjBeBpfvozfqsHzn5CoUE90Dk8U6Wl0CdrsTlIGVZKaVXUEDEvtCaenyTecXkY4Vz9dbw%2B%2FRp0qS1xB45991ArefmdBvWJb64LMOuj3i6o9aVv4oXUiu8kXinD%2BoFUK9FcZQ5QpX1pHoe8B4qFslo0v9S3jZN7Gh7ofWjeFMo5Yh%2FM%2FJQCgcwAzRvFVwo70rTH%2Fd%2Fp7897g37ujWW9NIZ39GOHXeAkPUTcktJrqrjYAq31F8uOxEwEI1bgbIUZR8oSaWaYz2xRazkWF0jQNIvtnEYub69XRbwkFGO13jWpYWLchggENCjanc4KfQ0rK6vsmGzWoplYq3kPBd1GgmhbPwir2tpXexfno2x%2FdPEVPnYMT1U3jvO8WFwh9B6SNqZcGNk1JjeR0rbnwp0h0N597K4JpWWsh6aU8DonAj3YQBeD7PtgRaRViRm0a%2FZj4wyTNd4RKGx1r2v4kaxOeZJCB8G%2BtsKmqtldiEWOuymy0%2BpAZhmrIT7GD%2BxkJViEW9M1EjZ3TptzX4SQlcHt76FwLnjCmLO1dYo5nGvZhIb4vlHs1ezCfy1dsM1jazeXj3ShcbiHmDoM0cOBXjkWj5xA6OW%2FyKAsfZW1bmRep0WBG3e2NXOKDLrXyTKVuecJwOQGmYE%2FTpvVP5DmJLLAfyF7Af53ZH%2FeWhL%2F3K6jmIaKvJyklFxCl%2B%2FpyMqo87DlTxu8oH9Scu7u5P97sScJl%2F06fUg0O4LH%2F%2FegeW6XwaYIR6zWKVoxU8mcDzzViSrO8CaZhX3PwgEMqVWUpyi5k1z20h1NVRTRy2GXw1flbEvdSaRBgXNly286Vh07XT9yzgrR9mSg%2B%2FZ%2Bg63Rq7pPRCSBuOKUqBKa4iKm2jM%2Bi0Mvkn5jl2Nkny4OcjA2XsJX93ZEMf02ph5EIpe1xcz3K2yqxIY66VHKoQ1ZMSo64qW6o%2BYwXFkYfL2gFHU%2FSvNcXrGJ38zGLe95p%2FNrqvPcbBQiiK6afSM7N7aVoAJfNftOEOLSJHFg0iu4H2Zyr%2FJWcjTGDgglXFoXUjrs2zi2vOwkNBg9KZtNv1LGPoLyqsz4vQyEuRPEiR7O%2FiFy47W3QzkCwvuPE7%2BWLysFyM8ndV5ezvkL8kb2ldLUV0rT2CU9CX8%2BhWr2UZJV9T5CISvHsxWsaHxMcOXM9vMvT6ELQjngQjx9dqeQORRXXHEMHWprd2%2BZ4yin1b1ffvkEqmNhO%2Bhig75SFczlmtIJ9ZkxOhjWu9DHlwN%2FxzYN6fX3Yn2OLcfjFVyVmYH3VCxHpHl3QIqCON8y6BwI%2B7QPAxU70GctYuyWgoirujNWptXTObfJQorNC2Y3ayQ2b1btPBfOvtufdhA8UbUrSJPoRQXfRZsBk6nVhvL2zhSnpwnWA23JwWQgVC66Js7HUzseRosULI%2BrDIDCAn3zNH%2FDF3s5VMNxtWKD02X5HRRg1UG56O6aFjIYudQsTGGaLUC1DzWgIQnAVrvNGUoZLL5lUl2m9LS%2BH3qMIudahvKrvz4i0qYyEWHg20Piqp7Ijr88MUN%2F3FRAP24v%2FrjXeF6PPm99Hzd6n2%2BD%2Fwue6z8E%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22mpi_status%22+value%3D%22A%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22eci%22+value%3D%2206%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22token%22+value%3D%221XKDCPQXAl68x_XElRoHraQ%22%3E%0A++++++++%3Cinput+type%3D%22hidden%22+name%3D%22status%22+value%3D%22approved%22%3E%0A++++%0A++++%3Cnoscript%3E%0A++++++++%3Cinput+type%3D%22submit%22+name%3D%22submit%22+value%3D%22Press+this+button+to+continue%22%2F%3E%0A++++%3C%2Fnoscript%3E%0A%3C%2Fform%3E%0A%3C%2Fbody%3E%0A%3C%2Fhtml%3E &redirect-to=https%3A%2F%2Fsandbox.lonapay24.com%2Fpayment%2Fform%2Fredirect%2F1969106%2F1062_j2yx3RsUU62ykDICpA &transaction-type=sale &receipt-id=58792aea-2238-3594-b5f7-dc9fe587c54b &name=John+Doe &cardholder-name=John+Doe &card-exp-month=12 &card-exp-year=2099 &email=john.smith%40gmail.com &order-stage=sale_3d_validating &last-four-digits=6732 &bin=453897 &card-type=VISA &phone=12063582043 &bank-name=UNKNOWN &paynet-processing-date=2024-03-20+08%3A59%3A02+MSK &card-hash-id=3902982 &card-country-alpha-three-code=JPN &first-name=John &last-name=Smith &ips-src-payment-product-code=F &ips-src-payment-product-name=Visa+Classic &ips-src-payment-type-code=Credit &ips-src-payment-type-name=VISA+Credit &initial-amount=10.42

*/

?>
