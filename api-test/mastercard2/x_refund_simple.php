<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

    <link rel="stylesheet" type="text/css" href="./assets/paymentstyle.css" />

    <head>
        <title>API Example Code</title>
        <meta http-equiv="Content-Type" content="text/html, charset=iso-8859-1">
    </head>

    <body>

        <h1>PHP Example - REST (JSON)</h1>
        <h3>Simple Refund Operation</h3>
        <p><a href="index.php">Return to the Home Page</a></p>

        <form action="./process.php" method="post">

        <table width="60%" align="center" cellpadding="5" border="0">

            <!-- Credit Card Fields -->
            <tr class="title">
                <td colspan="2" height="25"><P><strong>URL Fields</strong></P></td>
            </tr>

            <tr>
                <td colspan="2" height="25"><P class="desc">Order and Transaction IDs are required and used to calculate the URL along with the version and merchant ID. In your integration, you would calculate these fields within your code (process.php based on this example) and not expose these to the card holder on this page, or pass them as hidden fields.</P></td>
            </tr>

            <tr class="shade">
                <td align="right" width="50%"><strong>version </strong></td>
                <td width="50%"><input type="text" readonly="readonly" name="version" value="34" size="8" maxlength="80" /></td>
            </tr>

            <tr>
                <td align="right" width="50%"><strong>order.id</strong></td>
                <td><input type="text" name="orderId" value="<?=date('ymdHisu')?>" size="20" maxlength="60"/><br/>
                    <span style="font-size:8pt">ID of the existing Order to refund against</span></td>
            </tr>

            <tr class="shade">
                <td align="right" width="50%"><strong>transaction.id</strong></td>
                <td><input type="text" name="transactionId" value="<?=date('ymdHisu')?>" size="20" maxlength="60"/><br/>
                    <span style="font-size:8pt">ID of the transaction that will be created</span></td>
            </tr>

            <tr><td colspan="2"></td></tr>

            <tr class="title">
                <td colspan="2" height="25"><P><strong>&nbsp;Transaction Fields</strong></P></td>
            </tr>

            <tr>
                <td align="right" width="50%"><strong>method </strong></td>
                <td width="50%"><input type="text" readonly="readonly" name="method" value="PUT" size="20" maxlength="80"/> ** See Note 1 Below</td>
            </tr>

            <tr class="shade">
                <td align="right" width="50%"><strong>apiOperation </strong></td>
                <td width="50%"><input type="text" readonly="readonly" name="apiOperation" value="REFUND" size="20" maxlength="80"/></td>
            </tr>

            <tr>
                <td align="right"><strong>transaction.amount </strong></td>
                <td><input type="text" name="transaction[amount]" value="100" size="8" maxlength="13"/></td>
            </tr>

             <tr class="shade">
                <td align="right"><strong>transaction.currency </strong></td>
                <td><input type="text" name="transaction[currency]" value="KES" size="8" maxlength="3"/></td>
            </tr>

            <tr class="shade">
                <td colspan="2"><center><input type="submit" name="submit" value="Process Refund"/></center></td>
            </tr>

            <tr><td colspan="2"></td></tr>

            <tr>
                <td colspan="2" height="25"><P class="desc"><strong>Note 1:</strong> This field is used by this example to set the HTTP Method for sending the transaction. In your integration, you should determine the HTTP Method in your code (process.php based on this example) and never display it to the card holder or pass it as a hidden field.</P></td>
            </tr>

        </table>

        </form>
        <br/><br/>

    </body>
</html>
