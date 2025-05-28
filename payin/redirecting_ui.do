<?
// Hanging the script for 2 seconds to allow the browser to load the page
// Redirecting UI for pending transactions or transactions in progress
// This page is used to show a loading spinner and a countdown timer
// while the user is redirected to the transaction status page.
// It is designed to be user-friendly and provide a smooth experience.
$fetch_trnsStatusUrl=$host_path."/fetch_trnsStatus".$data['ex']."?transID=".@$td['transID']."&actionurl=validate";
?>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">

<head>
    <title>Redirecting, please wait....</title>
    <meta charset="UTF-8" />
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
    <meta http-equiv="Content-Security-Policy"
        content="default-src 'self'; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *; object-src 'none'" />
    <style>
    body {
        margin: 0;
        padding: 0;
        overflow: auto;
        width: 100%;
        height: 100%;
        font-size: 14px;
        font-family: Arial, Helvetica, sans-serif;
        color: #5d5c5d;
        line-height: 24px;
        text-align: center;
        color: #468847;
        background1: #ccc;
        border-color: #d6e9c6;
    }

    @keyframes spin {
        0% {
            transform: rotate(0deg);
        }

        100% {
            transform: rotate(360deg);
        }
    }
    </style>
    <script type="text/javascript">
    function closePayinWindow() {
        window.close();
        if (window.opener && window.opener.document) {
            //parent.window.close();
            opener.closePayinWindow();
        }

    }
    </script>
    <script>
    document.addEventListener('DOMContentLoaded', () => {
        // Create a countdown timer
        let countdown = 21;
        document.getElementById('countdown').textContent = countdown;
        // Redirect after 21 seconds
        // Countdown logic
        const countdownInterval = setInterval(() => {
            countdown--;
            document.getElementById('countdown').textContent = countdown;
            if (countdown <= 0) {
                clearInterval(countdownInterval);
                //top.document.location.href = top.document.location.href;
                top.document.location.href = "<?=@$fetch_trnsStatusUrl?>";
            }
        }, 1000);
    });
    </script>
</head>

<body style="text-align:center;font-family:arial,sans-serif;font-size:14px;color:#4d4c4c;">
    <div
        style="margin:0 auto;display:block;width:100%;max-width:350px;border: 2px solid #ccc;border-radius:10px;position:absolute;left:50%;top:50%;margin-left:-175px;margin-top:-215px;height:422px;">
        <h1 style="font-size:24px;color:#4d4c4c;margin:30px 0;float:left;width:100%;clear:both;line-height:140%;">Thank you! <br/>Your transaction is being processed.</h1>
        <div style="width:100%;height:1px;background-color:#ccc;margin-bottom:20px;clear:both;float:left;width:100%;"></div>

        <div style="width:100%;height:90px;margin-bottom:20px;clear:both;float:left;width:100%;">
            <div
                style="position:relative;left:50%;font-size:20px;border: 4px solid #ccc; border-radius: 50%; width: 50px; height: 50px; border-top: 4px solid #000; animation: spin 1s linear infinite;text-align:center;margin-left:-33px;margin-top:8px;">
            </div>
        </div>

        <div style="margin:24px 0 10px 0;">You’ll be automatically redirected in  <span id="countdown">21</span> seconds.</div>
        <div style="color:#4d4c4c;margin:30px 0;float:left;width:100%;clear:both;">Please do not refresh or close this page.</div>
        <?if(isset($redirectButton)) {?>
            <br /><br />OR <br /><br />
            <a target="_top" href='<?=@$fetch_trnsStatusUrl?>' class="upd_status"
                style="float:none;display:block;clear:both;width:250px;text-align:center;margin:15px auto;line-height:40px;border-radius:3px;background-color:#dff0d8;font-size:16px;text-decoration: none;color:#011801;border:none;">Redirecting
                Button</a>
        <?}?>
        <br /><br />
    </div>
</body>

</html>