<?php


/*

curl -XPOST -H 'X-Server-API-Key: vSL2MFzFJFWTrHg7TkrkzDMU' -H "Content-type: application/json" -d '{
    "to": ["mithileshs@bigit.io", "dev@bigit.io", "vmayo.official@gmail.com", "kumar.hemant@vmayo.org"
],
    "from": "info@cardpaymentz.com",  
    "subject": "Email API Test",
    "html_body": "hello this email api checking"
}' 'https://sn4.migomta.one/api/v1/send/message'


*/

function email_sentf($to='dev@bigit.io',$from='info@cardpaymentz.com',$subject='Email API Test by DevTech',$html_body='Hello 22 DevTech this email testing for <b>api checking</b>'){
	
$html_body=stripslashes($html_body);
//$html_body=str_replace(utf8_encode("Â"),"",$html_body);
$html_body=addslashes($html_body);

$html_body=preg_replace('/\n+|\t+|\s+/',' ',$html_body);
$html_body=str_replace( array( "style='","'>" ), array( 'style="','">' ), $html_body);
$html_body=str_replace( array( "’","'","’","{","}" ), ' ', $html_body);

	
$url = "https://sn4.migomta.one/api/v1/send/message";

$curl = curl_init($url);
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

$headers = array(
   "X-Server-API-Key: vSL2MFzFJFWTrHg7TkrkzDMU",
   "Content-type: application/json",
);
curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);

$dataEmail = <<<DATA
{
    "to": ["$to"
],
    "from": "$from",  
    "subject": "$subject",
    "html_body": "$html_body"
}
DATA;

ob_end_flush();

echo "<br/><br/>dataEmail1=><br/>".($dataEmail);echo "<br/><br/>";
echo "<br/><br/>dataEmail=><br/>";var_dump($dataEmail);echo "<br/><br/>";

curl_setopt($curl, CURLOPT_POSTFIELDS, $dataEmail);

//for debug only!
curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

$resp = curl_exec($curl);
curl_close($curl);
var_dump($resp);

}




########################################################






$to='mithileshs@bigit.io';
$from='info@cardpaymentz.com';
$subject='Email API Test by DevTech for transaction_id - 30'.date('YmdHis');
//$html_body='Hello 22 DevTech this email testing for <b>api checking</b>';
$html_body='<table class="st-Background" bgcolor="#f6f9fc" border="0" cellpadding="0" cellspacing="0" width="100%" style="color: rgb(0, 0, 0); font-family: Times New Roman; font-size: medium; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(246, 249, 252); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; border: 0px; margin: 0px; padding: 0px;">
  <tbody>
    <tr>
      <td style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px;background:rgb(211 231 255) !important;"><table class="st-Wrapper" align="center" bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" width="600" style="border-bottom-left-radius: 5px; border-bottom-right-radius: 5px; margin: 0px auto; min-width: 600px;">
          <tbody>
            <tr>
              <td style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px;"><table class="st-Preheader st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">
                  <tbody>
                    <tr></tr>
                  </tbody>
                </table>
                <div style="background-color: rgb(255, 255, 255); padding-top: 20px;height:40px;"> </div>
                <table class="st-Copy st-Copy--caption st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">
                  <tbody>
                    <tr>
                      <td class="Content Title-copy Font Font--title" align="center" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; width: 472px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(50, 50, 93); font-size: 24px; line-height: 32px;">Receipt from 105 BaerCrest  </td>
                    </tr>
                    <tr>
                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                  </tbody>
                </table>
                <table class="st-Copy st-Copy--caption st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">
                  <tbody>
                    <tr>
                      <td class="Content Title-copy Font Font--title" align="center" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; width: 472px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(136, 152, 170); font-size: 15px; line-height: 18px;">Transaction Id: 10511660106</td>
                    </tr>
                    <tr>
                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                  </tbody>
                </table>
                <table class="st-Spacer st-Spacer--standalone st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="100%">
                  <tbody>
                    <tr>
                      <td height="20" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                  </tbody>
                </table>
                <table class="st-Copy st-Copy--standalone st-Copy--caption" border="0" cellpadding="0" cellspacing="0" width="100%">
                  <tbody>
                    <tr>
                      <td width="64" class="st-Font st-Font--caption" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; color: rgb(136, 152, 170); font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; font-size: 12px; font-weight: bold; line-height: 16px; text-transform: uppercase;"></td>
                      <td width="121" valign="top" class="DataBlocks-item" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px;"><table style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px;">
                          <tbody>
                            <tr>
                              <td class="Font Font--caption Font--uppercase Font--mute Font--noWrap" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(136, 152, 170); font-size: 12px; line-height: 16px; white-space: nowrap; font-weight: bold; text-transform: uppercase;">DATE PAID</td>
                            </tr>
                            <tr>
                              <td class="Font Font--body Font--noWrap" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px; white-space: nowrap;">01-03-2023 06:03</td>
                            </tr>
                          </tbody>
                        </table></td>
                      <td width="20" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                      <td width="384" align="right" valign="top" class="DataBlocks-item" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px;"><table width="182" style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px;">
                          <tbody>
                            <tr>
                              <td class="Font Font--caption Font--uppercase Font--mute Font--noWrap" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(136, 152, 170); font-size: 12px; line-height: 16px; white-space: nowrap; font-weight: bold; text-transform: uppercase;text-align:right">PAYMENT METHOD</td>
                            </tr>
                            <tr>
                              <td class="Font Font--body Font--noWrap" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px; white-space: nowrap;text-align:right;"><span style="border:0px !important; margin:0px !important; outline:0px !important; padding:0px !important; -webkit-font-smoothing:antialiased !important; text-decoration:none !important;text-align:right; "><img src=https://merchant.cardpaymentz.com/images/visa.png  style=max-height:18px;height:18px; /> - 4242�</span><span style="text-decoration:none !important; "></span></td>
                            </tr>
                          </tbody>
                        </table></td>
                      <td width="64" class="st-Font st-Font--caption" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; color: rgb(136, 152, 170); font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; font-size: 12px; font-weight: bold; line-height: 16px; text-transform: uppercase;"></td>
                    </tr>
                  </tbody>
                </table>
                <table class="st-Spacer st-Spacer--standalone st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="100%">
                  <tbody>
                    <tr>
                      <td height="32" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                  </tbody>
                </table>
                <table class="st-Copy st-Copy--caption st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">
                  <tbody>
                    <tr>
                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                      <td class="st-Font st-Font--caption" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; color: rgb(136, 152, 170); font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; font-size: 12px; line-height: 16px; text-transform: uppercase;"><span class="st-Delink" style="border: 0px; margin: 0px; outline: 0px !important; padding: 0px; text-decoration: none !important; -webkit-font-smoothing: antialiased !important; font-weight: bold;">SUMMARY</span></td>
                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                    <tr>
                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                  </tbody>
                </table>
                <table class="st-Blocks st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">
                  <tbody>
                    <tr>
                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="4" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                    <tr>
                      <td class="st-Spacer st-Spacer--kill" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                      <td style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px;"><table class="st-Blocks-inner" bgcolor="#f6f9fc" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-radius: 5px;">
                          <tbody>
                            <tr>
                              <td style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px;"><table class="st-Blocks-item" border="0" cellpadding="0" cellspacing="0" width="100%">
                                  <tbody>
                                    <tr>
                                      <td class="st-Spacer st-Spacer--blocksItemEnds" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                                    </tr>
                                    <tr>
                                      <td class="st-Spacer st-Spacer--gutter" width="16" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                                      <td class="st-Blocks-item-cell st-Font st-Font--body" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; color: rgb(82, 95, 127); font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; font-size: 16px; line-height: 24px;"><table width="100%" style="padding-left: 5px; padding-right: 5px;">
                                          <tbody>
                                            <tr>
                                              <td style="-webkit-font-smoothing: antialiased !important;"></td>
                                            </tr>
                                            <tr>
                                              <td class="Table-description Font Font--body" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px; width: 30%;">Product Name </td>
                                              <td class="Spacer Table-gap" width="8" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                                              <td class="Table-amount Font Font--body" align="right" valign="top" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px;">Test Product</td>
                                            </tr>
                                            <tr>
                                              <td class="Table-divider Spacer" colspan="3" height="6" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                                            </tr>
                                            <tr>
                                              <td class="Table-divider Spacer" colspan="3" height="6" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                                            </tr>
                                            <tr>
                                              <td class="Table-description Font Font--body" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px; ">Descriptor </td>
                                              <td class="Spacer Table-gap" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                                              <td class="Table-amount Font Font--body" align="right" valign="top" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px;">Test*merchant.cardpaymentz.com</td>
                                            </tr>
                                            <tr>
                                              <td class="Table-divider Spacer" colspan="3" height="8" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                                            </tr>
                                            <tr>
                                              <td class="Table-description Font Font--body" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px;"><strong>Amount charged</strong></td>
                                              <td class="Spacer Table-gap" width="8" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                                              <td class="Table-amount Font Font--body" align="right" valign="top" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px;"><strong>2.00 USD</strong></td>
                                            </tr>
                                            <tr>
                                              <td class="Table-divider Spacer" colspan="3" height="6" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                                            </tr>
                                          </tbody>
                                        </table></td>
                                      <td class="st-Spacer st-Spacer--gutter" width="16" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                                    </tr>
                                    <tr>
                                      <td class="st-Spacer st-Spacer--blocksItemEnds" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                                    </tr>
                                  </tbody>
                                </table></td>
                            </tr>
                          </tbody>
                        </table></td>
                      <td class="st-Spacer st-Spacer--kill" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                    <tr>
                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="16" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                  </tbody>
                </table>
                <table class="st-Divider st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">
                  <tbody>
                    <tr>
                      <td class="st-Spacer st-Spacer--divider" colspan="3" height="20" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                    <tr>
                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                      <td bgcolor="#e6ebf1" height="1" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                    <tr>
                      <td class="st-Spacer st-Spacer--divider" colspan="3" height="31" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                  </tbody>
                </table>
                <table class="st-Copy st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">
                  <tbody>
                    <tr>
                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                      <td style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; font-size: 16px; line-height: 24px; color: rgb(82, 95, 127) !important;">If you have any questions, contact us at�<a href="mailto: dev@bigit.io " style="border: 0px; margin: 0px; outline: 0px !important; padding: 0px; text-decoration: none; -webkit-font-smoothing: antialiased !important; color: rgb(85, 108, 214) !important;"> dev@bigit.io </a>�or call at  <a href="tel:5555555555 " style="border: 0px; margin: 0px; outline: 0px !important; padding: 0px; text-decoration: none; -webkit-font-smoothing: antialiased !important; color: rgb(85, 108, 214) !important;">5555555555 </a>.</td>
                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                    <tr>
                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                  </tbody>
                </table>
                <table class="st-Divider st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">
                  <tbody>
                    <tr>
                      <td class="st-Spacer st-Spacer--divider" colspan="3" height="20" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                    <tr>
                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                      <td bgcolor="#e6ebf1" height="1" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                    <tr>
                      <td class="st-Spacer st-Spacer--divider" colspan="3" height="31" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
                    </tr>
                  </tbody>
                </table>
                <table class="Section Divider Divider--small" width="100%" style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; background-color: rgb(255, 255, 255);">
                  <tbody>
                    <tr>
                      <td class="Spacer Spacer--divider" height="20" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                    </tr>
                  </tbody>
                </table>
                <table class="Section Copy" style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; background-color: rgb(255, 255, 255);">
                  <tbody>
                    <tr>
                      <td class="Spacer Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                      <td class="Content Footer-legal Font Font--caption Font--mute" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; width: 472px; font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif; vertical-align: middle; color: rgb(136, 152, 170); font-size: 12px; line-height: 16px;">You are receiving this email because you made a purchase at 105 BaerCrest  , which partners with�<a target="_blank" rel="noreferrer" href="https://merchant.cardpaymentz.com" style="border: 0px; margin: 0px; outline: 0px !important; padding: 0px; text-decoration: none; -webkit-font-smoothing: antialiased !important; color: rgb(85, 108, 214); font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Ubuntu, sans-serif;">CardPaymentz</a>�to provide invoicing and payment processing.</td>
                    </tr>
                  </tbody>
                </table>
                <table class="Section Divider Divider--small" width="100%" style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; background-color: rgb(255, 255, 255);">
                  <tbody>
                    <tr>
                      <td class="Spacer Spacer--divider" height="20" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                    </tr>
                  </tbody>
                </table>
                <table class="Section Section--last Divider Divider--large" width="100%" style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; background-color: rgb(255, 255, 255); border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
                  <tbody>
                    <tr>
                      <td class="Spacer Spacer--divider" height="64" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td class="st-Spacer st-Spacer--emailEnd" height="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>
    </tr>
  </tbody>
</table>';
email_sentf($to,$from,$subject,$html_body);






########################################################



$to='dev@bigit.io';
$from='info@cardpaymentz.com';
$subject='Email API Test by DevTech for transaction_id - 20'.date('YmdHis');
//$html_body='Hello 22 DevTech this email testing for <b>api checking</b>';
$html_body='<p style="float:left;width:90%;padding:2% 5%;line-height:150%;background-color:#fff;color:#000;font-family:arial,sans-serif;border:4px solid #e2e2e2;"> A Transaction has been completed successfully for 105 BaerCrest - 105 BaerCrest <br><br> <b>Please look at the below transaction details:</b><br><br> <table width="100%" align="center" border="0" cellpadding="4" cellspacing="0" bordercolor="#999999" style="width:100%;background-color:#fff;border-collapse:collapse;font:12px/14px Verdana,Tahoma,Trebuchet MS,Arial;color: #555555;"><tr style="background-color:#fff;"><td width="28%">Customer Name</td><td width="2%"> : </td><td width="70%">Test Full Name</td></tr><tr style="background-color:#fff;"><td width="28%">Customer s E-Mail</td><td width="2%"> : </td><td width="70%">test0047@test.com</td></tr><tr style="background-color:#fff;"><td width="28%">Customer s Phone No.</td><td width="2%"> : </td><td width="70%">919803060047</td></tr><tr style="background-color:#fff;"><td width="28%">Payment Status</td><td width="2%"> : </td><td width="70%">Test</td></tr><tr style="background-color:#fff;"><td width="28%">Descriptor</td><td width="2%"> : </td><td width="70%">Test*merchant.cardpaymentz.com</td></tr><tr style="background-color:#fff;"><td width="28%">Amount Received</td><td width="2%"> : </td><td width="70%">2.00 USD</td></tr></table> <br><br><br> You can access your account anytime at: <br><br> <a href="https://merchant.cardpaymentz.com">https://merchant.cardpaymentz.com</a><br><br><br> Thank you,<br><br> CardPaymentz Services Team<br><br></p>';
email_sentf($to,$from,$subject,$html_body);



###########################################


?>