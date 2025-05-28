<?
// arr consists of sample payload

$params['client_code']='LASI1';
$params['client_id']='b1fd42e9f58618f3a93c059290f1a7b9';
$params['client_secret']='6795e1e3ed3546c801f9d857a113f4b9';

$arr = [
            'request' => [
                'header' => [
                    'requestUUID' => time(),
                    'channelId' => 'IND',
                ],
                'body' => [
                    'fetchIECDataReq' => [
                        'customerTenderId' => $params['client_code']
                    ]
                ]
            ]
        ];

        $data = json_encode($arr);

        $keyEncryptionAlgorithmManager = new AlgorithmManager([
            new A256KW(),
        ]);

        // The content encryption algorithm manager with the A256CBC-HS256 algorithm.
        $contentEncryptionAlgorithmManager = new AlgorithmManager([
            new A256GCM(),
        ]);

        // The signatrue encryption algorithm manager with the RS256 algorithm.
        $signatureEncryptionAlgorithmManager = new AlgorithmManager([
            new RS256(),
        ]);

        // // The compression method manager with the DEF (Deflate) method.
        $compressionMethodManager = new CompressionMethodManager([
            new Deflate(),
        ]);

        // // We instantiate our JWE Builder.
        $jweBuilder = new JWEBuilder(
            $keyEncryptionAlgorithmManager,
            $contentEncryptionAlgorithmManager,
            $compressionMethodManager
        );

        $key = JWKFactory::createFromSecret(
            '4t7w!fghjx/A?D(',       // The shared secret
        );

        $jwe = $jweBuilder
            ->create()              // We want to create a new JWE
            ->withPayload($data) // We set the payload
            ->withSharedProtectedHeader([
                'alg' => 'A256KW',        // Key Encryption Algorithm
                'enc' => 'A256GCM', // Content Encryption Algorithm
                'zip' => 'DEF'            // We enable the compression (irrelevant as the payload is small, just for the example).
            ])
            ->addRecipient($key)    // We add a recipient (a shared key or public key).
            ->build();              // We build it


        $serializer = new CompactSerializer(); // The serializer
        $encData = $serializer->serialize($jwe, 0); // We serialize the recipient at index 0 (we only have one recipient).

        $keyEncryptionAlgorithmManager = new AlgorithmManager([
            new RSAOAEP256(),
        ]);

        // // We instantiate our JWE Builder.
        $jweBuilder = new JWEBuilder(
            $keyEncryptionAlgorithmManager,
            $contentEncryptionAlgorithmManager,
            $compressionMethodManager
        );
        // 4t7w!z%C*F-JaNdRfUjXn2r5u8x/A?D(
        $key = JWKFactory::createFromKeyFile(
            storage_path('keys/Indus/XXX.txt'), // The filename
            '',                   // Secret if the key is encrypted, otherwise null
            [
                'use' => 'enc',         // Additional parameters
            ]
        );

        $jwe = $jweBuilder
            ->create()              // We want to create a new JWE
            ->withPayload('34743777212347538782f413f4428') // We set the payload
            ->withSharedProtectedHeader([
                'alg' => 'RSA-OAEP-256',        // Key Encryption Algorithm
                'enc' => 'A256GCM', // Content Encryption Algorithm
                'zip' => 'DEF'            // We enable the compression (irrelevant as the payload is small, just for the example).
            ])
            ->addRecipient($key)    // We add a recipient (a shared key or public key).
            ->build();              // We build it


        $serializer = new CompactSerializer(); // The serializer
        $encKey = $serializer->serialize($jwe, 0); // We serialize the recipient at index 0 (we only have one recipient).

        $request = json_encode([
            'data' => $encData,
            'key' => $encKey,
            'bit' => 0
        ]);

        $httpUrl = 'API URL';

        $headers = array(
            'IBL-Client-Id: '.$params['client_id'],
            'IBL-Client-Secret: '.$params['client_secret'],
            'Content-Type: application/json',
        );

       
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => $httpUrl,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 1,
            CURLOPT_TIMEOUT => 60,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => $request,
            CURLOPT_HTTPHEADER => $headers,
        ));

        $response = curl_exec($curl);
        $httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        curl_close($curl);
        // $httpcode = 200;
        // $response = 'eyJlbmMiOiJBMjU2R0NNIiwiYWxnIjoiQTI1NktXIn0.Y_QfrwhoLIItqfnY98cBCPoVVfvp2kdBuVzkTa5fdY-hI7C9AFgzJw.zS9oj-2HpsxJyGbq.GDfoIXoBv4QyetjO-9wbm_axZfsRnVrjC2fYINj1-pv2BkT43iYWc9DhWF-zHiPqf9JCtbqFgrgfJGRBUlDyKl1AGent6i7Z6dR8y_icH70DYH1vGz5pqJyYWDmMUFK_By6-_KSVG52_5eH2Pf7bmHW-gq-i64XPVNL1bs1xLUUrt7cFrF6X7BZp7tG8f17eq-QaKteDO4RtRlQ5uKV14-1jqKFWTRzfsGUHF8-KKmnSATA8Yz1ljoj3Utw137hjMxr8xmbT15lWamU-VJEROsX8RkO9Aoc2KtnJ32ISiwzu45aen0rWFKuKzebfmzsSsI3U1b7_vcuxE3Rp1LH0DUJBjrZ9x10Yy9Z9GZpvI9_ZcOWNl1ngKjoxxqfAv5f313zoYsTV2NJagIOCWmaFkXUVyox7cnJsjAl4KpTUuradPOtlMcNwMypzpbMU5_zqrIkG_YBhehK-x-sGm_pIVa_-uChnPARIuJ-7NHoj7p64_w33hDs6gXX9STj-W0sMlbTXJIhv4PFZ1m7_GKjFhxqrZ3eaOeKxOnNIKcql8b00n9qVIK0ngJb9XmfD-Jy-fL45S_esNQ_5OWEK7bBV5lBh9zT_zbGdtahxNXZAB5PclQX7IlJNZy15lwUQtIw1bjflNd1GIgZklhuWSJ3QruZQLnDaeqb5xocMJoOFjuP5O703BrU.nU84mG-kev9oPrUo229vwg';
      
        $response = json_decode($response)->data;

        $keyEncryptionAlgorithmManager = new AlgorithmManager([
            new A256KW(),
        ]);

        // The content encryption algorithm manager with the A256CBC-HS256 algorithm.
        $contentEncryptionAlgorithmManager = new AlgorithmManager([
            new A256GCM(),
        ]);

        // // The compression method manager with the DEF (Deflate) method.
        $compressionMethodManager = new CompressionMethodManager([
            new Deflate(),
        ]);

        // $encToken = base64_decode(explode('.', $raw_response)[1]);

        // The serializer manager. We only use the JWE Compact Serialization Mode.
        $serializerManager = new JWESerializerManager([
            new CompactSerializer(),
        ]);

        // We try to load the token.
        $jwe = $serializerManager->unserialize($response);

        $jwkAlgkey = JWKFactory::createFromSecret(
            '4t7w!z%C456x/A?D(',       // The shared secret
        );

        $jweDecrypter = new JWEDecrypter(
            $keyEncryptionAlgorithmManager,
            $contentEncryptionAlgorithmManager,
            $compressionMethodManager
        );
?>