<?php
// https://www.youtube.com/watch?v=333bST-_ro8
// https://github.com/PHPMailer/PHPMailer?tab=readme-ov-file

// snippet-start:[ses.php.send_email_SMTP.complete]

//  localhost:8080/gw/dev_smpt_aws_email.php

// Import PHPMailer classes into the global namespace.
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception as PHPMailerException;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

// If necessary, modify the path in the require statement below to refer to the
// location of your Composer autoload.php file.
//require 'vendor/autoload.php';

// Replace sender@example.com with your "From" address.
// This address must be verified with Amazon SES.
$sender = 'awmail@web1.one';
$senderName = 'awmail';

// Replace recipient@example.com with a "To" address. If your account
// is still in the sandbox, this address must be verified.
$recipient = 'mithileshk@itio.in';

// Replace smtp_username with your Amazon SES SMTP username.
$usernameSmtp = 'AKIA5PKGJQOYN3CR5HGF';

// Replace smtp_password with your Amazon SES SMTP password.
$passwordSmtp = 'BMxWqiVGaSRWjGuPj64IcZd+v0dysDhytFiR2lstEEwv';

// Specify a configuration set. If you do not want to use a configuration
// set, comment or remove the next line.
$configurationSet = 'ConfigSet';

// If you're using Amazon SES in a region other than US West (Oregon),
// replace email-smtp.us-west-2.amazonaws.com with the Amazon SES SMTP
// endpoint in the appropriate region.
$host = 'email-smtp.ap-south-1.amazonaws.com';
$port = 587;

// The subject line of the email
$subject = 'Amazon SES test (SMTP interface accessed using PHP)';

// The plain-text body of the email
$bodyText =  "Email Test This email was sent through the
    Amazon SES SMTP interface using the PHPMailer class.";

// The HTML-formatted body of the email
$bodyHtml = '<h1>AWS SES SMPT Email Test via Dev</h1>
    <p>This email was sent through the
    <a href="https://aws.amazon.com/ses">Amazon SES</a> SMTP
    interface using the <a href="https://github.com/PHPMailer/PHPMailer">
    PHPMailer</a> class.</p>';


//EMAIL
$mail = new PHPMailer;
$mail->isSMTP();
$mail->SMTPDebug = 0; //1 for production purpose, 2 for client and server message
$mail->Host = 'email-smtp.ap-south-1.amazonaws.com'; //AWS SES SMTP
$mail->Port = 587; //TLS
$mail->SMTPSecure = 'tls';
$mail->SMTPAuth = true;
$mail->Username = 'AKIA5PKGJQOYN3CR5HGF';
$mail->Password = 'BMxWqiVGaSRWjGuPj64IcZd+v0dysDhytFiR2lstEEwv' ;

//Recipients

$mail->setFrom('awmail@web1.one', 'Info'); //This domain must be a verified identities in AWS SES 
//$mail->addAddress($email,$name);
$mail->addAddress('mithileshk@itio.in', 'Dev Tech'); 
//$mail->addAddress('sandeeps@itio.in', 'Sandeep Tech'); 
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
    echo "Email is sent successfully!";
}

// snippet-end:[ses.php.send_email_SMTP.complete]


?>
