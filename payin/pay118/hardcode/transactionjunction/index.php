
<br />
<br />
<br />
<form method="post" action="pay.php">
<table width="50%" border="1" cellspacing="4" cellpadding="4" align="center">
  <tr>
    <td width="50%">Amount</td>
    <td width="50%">
      <input type="text" name="amount" id="amount" value="<?=rand(100,999);?>" required />    </td>
  </tr>
  <?php /*?><tr>
    <td width="50%">card Number</td>
    <td width="50%">
      <input type="text" name="pan" id="pan" value="4922130001618059" required />    </td>
  </tr>
  <tr>
    <td width="50%">expiry Date</td>
    <td width="50%">
      <input type="text" name="expiryDate" id="expiryDate" value="2708" required />    </td>
  </tr>
  <tr>
    <td width="50%">cvv</td>
    <td width="50%">
      <input type="text" name="cvv" id="cvv" value="793" required />    </td>
  </tr>
  <tr>
    <td width="50%">nameOnCard</td>
    <td width="50%">
      <input type="text" name="nameOnCard" id="nameOnCard" value="Vikash Gupta" required />    </td>
  </tr><?php */?>
  <tr>
    <td>&nbsp;</td>
    <td>
      <input type="submit" name="Submit" value="Pay Now" />    </td>
  </tr>
</table>
</form>
