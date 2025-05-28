<?php
//  localhost:8080/gw/dev_smpt_gmail_email.php

// https://www.youtube.com/watch?v=QUWDC1ZjMHA
// https://github.com/PHPMailer/PHPMailer?tab=readme-ov-file



// Import PHPMailer classes into the global namespace.
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception as PHPMailerException;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';


// The subject line of the email
$subject = 'Dev tec - Gmail test (SMTP interface accessed using PHP)';

// The plain-text body of the email
$bodyText =  "Dev tec - Email Test This email was sent through the
Gmail SMTP interface using the PHPMailer class.";

// The HTML-formatted body of the email
$bodyHtml = '<h1>Gmail SMPT Email Test via Dev</h1>
    <p>This email was sent through the
    <a href="https://www.youtube.com/watch?v=QUWDC1ZjMHA">Gmail SMPT</a> SMTP
    interface using the <a href="https://github.com/PHPMailer/PHPMailer">
    PHPMailer</a> class.</p>';


//EMAIL
$mail = new PHPMailer;
$mail->isSMTP();
$mail->SMTPDebug = 2; //1 for production purpose, 2 for client and server message
$mail->Host = 'smtp.gmail.com'; //AWS SES SMTP
$mail->Port = 587; //TLS
$mail->SMTPSecure = 'tls';
$mail->SMTPAuth = true;
$mail->Username = 'mith1.itio@gmail.com';
$mail->Password = 'pgaqlnvzbwwmrzcf' ;


//Recipients

$mail->setFrom('mith1.itio@gmail.com', 'Info'); //This domain must be a verified identities in AWS SES 
//$mail->addAddress($email,$name);
$mail->addAddress('mithileshk@itio.in', 'Dev Tech'); 
$mail->addAddress('sandeeps@itio.in', 'Sandeep Tech'); 
$mail->addAddress('arun@itio.in', 'Arun Kumar'); 
/*
    $mail->addReplyTo('info@example.com', 'Information');
    $mail->addCC('cc@example.com');
    $mail->addBCC('bcc@example.com');

//Attachments
    $mail->addAttachment('/var/tmp/file.tar.gz');         //Add attachments
    $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    //Optional name
*/


//Content
$mail->Subject = $subject;
$mail->msgHTML ($bodyHtml);
$mail->AltBody = 'HTML does not support';
//$mail->addAttachment ('image.jpg'); //we can attachment file

if(!$mail->send()){
    echo "Error:".$mail->ErrorInfo;
}else {
    echo "Gmail Email is sent successfully!";
}

// snippet-end:[ses.php.send_email_SMTP.complete]


?>
