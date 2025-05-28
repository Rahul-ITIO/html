<?php
//https://github.com/dompdf/dompdf/releases

include('../config.do');
//include('../config_db.do');
$uid=$_SESSION['uid'];

//////////////////// Merchant Detail Get From Stored Data////////////////////
$username = $domain_server['clients']['username'];
$inv_m_company=$domain_server['clients']['company_name'];

if(isset($domain_server['clients']['fullname'])&&$domain_server['clients']['fullname'])
	$inv_m_name=$domain_server['clients']['fullname'];


$inv_m_address1=@$domain_server['clients']['registered_address'];
//$inv_m_address2=$domain_server['clients']['city'].", ".$domain_server['clients']['state'].", ".$domain_server['clients']['country']." - ".$domain_server['clients']['zip'];




$bid = $_REQUEST["bid"];
$tbl="request_trans_table";
$field="  `clientid`='$uid' AND  `id`='$bid' AND `category` IN (1) ";

$qry = "SELECT * FROM {$data['DbPrefix']}{$tbl} WHERE ".$field;
$arr=db_rows($qry);
$arr=$arr[0];



$jsr=jsondecode($arr['json_value']); 
$receiver_email=($arr['receiver_email']); 
$bill_phone=($jsr['bill_phone']); 

$baddress=$jsr['bill_address']; 
//$baddress=$jsr['bill_address']; 
$baddress2=$jsr['bill_city']." ".$jsr['bill_state']." ".$jsr['bill_country']." ".$jsr['bill_zip'];





$payurl=$data['Host']."/payme".$data['ex']."/".$arr['transactioncode']."/";
$termcondation="";
$notes="";
$taxx="";

if($jsr["term_condation"]){
$termcondation='<div  style="padding-left: 5px;font-weight: bold;margin-bottom: 5px"><strong>Terms &amp; Condations :</strong></div>
                <div style="padding-left: 5px;margin-bottom: 5px;margin-top: 5px">'.$jsr["term_condation"].'</div>';
}

if($jsr["notes"]){
$notes='<div  style="padding-left: 5px;font-weight: bold;margin-bottom: 5px;margin-top: 5px"><strong>Notes :</strong></div>
        <div style="padding-left: 5px;margin-bottom: 5px;margin-top: 5px">'.$jsr["notes"].'</div>';
}



if($jsr['tax_type']<>""){ 
				
				$taxtitle="";
				$taxamt="";
				$totalamt="";
				
				    if($jsr['tax_type']==1){
					$taxamt=$jsr['tax_amount'];
					$taxamt=number_format((float)$taxamt, 2, '.', '');
					$taxtitle="";
					$totalamt=$jsr['product_amount'] + $taxamt;
					}elseif($jsr['tax_type']==2){
					$taxamt=($jsr['product_amount'] *  ($jsr['tax_amount'] / 100));
					$taxamt=number_format((float)$taxamt, 2, '.', '');
					$taxtitle=$jsr['tax_amount']." %";
					$totalamt=$jsr['product_amount'] + $taxamt;
					}else{
					
					}
					
				   }else{
				   $totalamt=$arr['amount'];
				   } 
				        $totalamt=number_format((float)$totalamt, 2, '.', '');
				        $product_amount=number_format((float)$jsr['product_amount'], 2, '.', '');
				   
				  

if($jsr["tax_amount"]){
$taxx=' <tr  style=" border-color: #dee2e6; border-style: solid; border-width: 0px;">
        <td  style=" border-color: #dee2e6; border-style: solid; border-width: 0px 0px 1px; padding: 8px;"><strong style=" font-weight: bolder;">Tax '.$taxtitle.' :  </strong></td> <td  style=" border-color: inherit; border-style: solid; border-width: 0px 0px 1px; padding: 8px;">'.$taxamt.' '.$arr["currency"].'</td></tr>';
}


$inv_m_ph_eml='';
if($receiver_email)
	$inv_m_ph_eml.='Email: '.$receiver_email.'<br style="">';
if($bill_phone)
	$inv_m_ph_eml.='Mobile: '.$bill_phone.'<br style="">';

$email_msg='
           
<div  style="border: 3px solid; border-radius: 15px; padding:10px; border-color:#CCCCCC;">
  <div  style=" display: flex ; margin-top: 16px ; margin-bottom: 16px ;">
    <div style=" margin-right: auto ; padding: 8px ;float:left;"><strong style=" font-weight: bolder;">'.$inv_m_company.'</strong><br style="">
      '.$inv_m_name.'<br style="">
      '.$inv_m_address1.'</div>
    <div style=" padding: 8px ; font-size: 28px ;float:right;">Invoice</div>
  </div>
  <div  style=" display: flex ; margin-bottom: 16px ;clear:both;">
    <div style=" margin-right: auto ; padding: 8px ;float:left;"><strong style=" font-weight: bolder;">Bill To</strong><br style="">
      '.$arr["fullname"].'<br style="">
	  '.$inv_m_ph_eml.'
      '.$baddress.'<br style="">
      '.$baddress2.'</div>
    <div  style=" padding: 8px ;float:right;"><strong style=" font-weight: bolder;">Invoice No. #</strong>&nbsp;'.$arr["invoice_no"].'<br style="">
      <strong style=" font-weight: bolder;">Invoice Date #</strong>&nbsp;'.date("d/m/Y",strtotime($arr['created_date'])).'</div>
  </div>
  <hr style=" margin: 16px 0px; color: inherit; background-color: currentcolor; border: 0px; opacity: 0.25; height: 1px;clear:both;">
  <div style=" margin-top: 8px ; margin-bottom: 8px ; padding: 8px ;">
    <table width="100%" style=" border-collapse: collapse;">
      <tbody style=" border-color: inherit; border-style: solid; border-width: 0px; vertical-align: inherit;">
        <tr  style="background-color: #e4e5e7;">
          <td width="75%" style=" border-color: #dee2e6; border-style: solid; border-width: 0px 0px 1px; padding: 8px;"><strong style=" font-weight: bolder;">Description</strong></td>
          <td width="25%" style=" border-color: #dee2e6; border-style: solid; border-width: 0px 0px 1px; padding: 8px;"><strong style=" font-weight: bolder;">Amount</strong></td>
        </tr>
        <tr style=" border-color: inherit; border-style: solid; border-width: 0px;">
          <td style=" border-color: rgb(222,226,230);border-style: solid;border-width: 0px 0px 1px;padding: 8px;">'.$arr["product_name"].'</td>
          <td style="border-color: rgb(222,226,230);border-style: solid;border-width: 0px 0px 1px;padding: 8px;">'.$product_amount.' '.$arr["currency"].'</td>
        </tr>
      </tbody>
    </table>
    <table width="50%" align="right"  style=" border-collapse: collapse;">
      <tbody style=" border-color: inherit; border-style: solid; border-width: 0px; vertical-align: inherit;">
      '.$taxx.'
      <tr  style=" border-color: inherit; border-style: solid; border-width: 0px;">
        <td width="50%" style=" border-color: #dee2e6; border-style: solid; border-width: 0px 0px 1px; padding: 8px;"><strong style=" font-weight: bolder;">Total :</strong></td>
        <td width="50%" style=" border-color: #dee2e6; border-style: solid; border-width: 0px 0px 1px; padding: 8px;">'.$totalamt.' '.$arr["currency"].'</td>
      </tr>
      </tbody>
      
    </table>
  </div>
  <div  style="margin-top:80px;margin-bottom:10px;text-align:center;font-weight:bolder; "><a href="'.$payurl.'" target="_blank" style="display: inline-block;padding: 10px;border-radius: 20px;width: 345px;background-color: '.$_SESSION['background_gd4'].';color: '.$_SESSION['root_text_color'].' ; text-decoration: none;">Pay Now</a></div>
  <hr style=" margin: 16px 0px; color: inherit; background-color: currentcolor; border: 0px; opacity: 0.25; height: 1px;">
  '.$termcondation.''.$notes.'
  <div  style="margin: 5px ; text-align: right ;"><strong style=" font-weight: bolder;">Powered by</strong>&nbsp;- '.$data['SiteName'].'</div>
  <div style=" margin-top: 8px ; margin-bottom: 5px ; text-align: center ; color: rgb(108, 117, 125) ; font-size: 10px;">this is computer generated invoice no signature required</div>
</div>


 ';






$html='<html lang="en">';
$html.='<head></head>';
$html.='<body style=\'font-family:Verdana,Tahoma,Trebuchet MS,Arial,sans-serif!important;line-height:150%;font-weight:normal;margin:0;padding:0;\'><div>'.$email_msg;
$html.='</div></body></html>';

//echo $html;exit;




// include autoloader
//require_once '../mypdf/dompdf/autoload.inc.php';
//include('../mypdf/dompdf/autoload.inc.php');
include('../dompdf/autoload.inc.php');

// reference the Dompdf namespace
use Dompdf\Dompdf;
//echo "==============>";exit;
// instantiate and use the dompdf class
ob_end_clean();
$dompdf = new Dompdf();

$dompdf->loadHtml($html);

//$dompdf->set_option('isRemoteEnabled', TRUE);
//$dompdf->set_option('isHtml5ParserEnabled', true);

// (Optional) Setup the paper size and orientation
$dompdf->setPaper('A4', 'orientation'); // orientation landscape

// Render the HTML as PDF
$dompdf->render();

//$filename = "invoice_".$_REQUEST['bid']."_".date("dmyHis");
$filename = "invoice_".$_REQUEST['bid']."_".date("dmyHis");

// Output the generated PDF to Browser
//$dompdf->stream($filename); // Download
//$dompdf->stream($filename,array("Attachment"=>1));

$dompdf->stream($filename,array("Attachment"=>1));

?>
