<?
$is_admin=$post['is_admin'];
//echo "<br/>qp3=>".$data['qp'];
if(isset($data['qp'])&&!empty($data['qp'])){
	$target_frm='';
	echo "<hr/>cso3=>".$post['cso3'];
}else{
	$target_frm=' target="hform" ';
}


?>

<!DOCTYPE>
<html>
<head>
<title><?=@$data['SiteTitle']?> [ADMINISTRATION AREA]</title>
<meta http-equiv="pragma" content="no-cache"/>
<? if(isset($domain_server['STATUS'])&&$domain_server['STATUS']==true){ ?>
<!-- Favicon -->
<meta name="msapplication-TileImage" content="<?=@$domain_server['LOGO'];?>"> <!-- Windows 8 -->
<meta name="msapplication-TileColor" content="#00CCFF"/> <!-- Windows 8 color -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--[if IE]><link rel="shortcut icon" href="<?=@$domain_server['LOGO'];?>"><![endif]-->
<link rel="icon" type="image/png" href="<?=@$domain_server['LOGO'];?>">

<? } ?>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<script src="<?=@$data['TEMPATH']?>/common/js/jquery-3.6.4.min.js"></script>
<link href="<?=@$data['TEMPATH']?>/common/css/bootstrap.min.css" rel="stylesheet">
<link href="<?=@$data['Host']?>/thirdpartyapp/fontawesome/css/all.min.css" rel="stylesheet">
<script src="<?=@$data['TEMPATH']?>/common/js/bootstrap.bundle.min.js"></script>
<link href="<?=@$data['TEMPATH']?>/common/css/template-custom.css" rel="stylesheet">
<script src="<?=@$data['TEMPATH']?>/common/js/common_use.js" type="text/javascript"></script>
<script src="<?=@$data['TEMPATH']?>/common/js/common_use_merchant.js" type="text/javascript"></script>


<script type=text/javascript>function s(){window.status="<?=@$data['SiteTitle']?> ?????????? [ADMINISTRATION AREA]";return true};if(document.layers)document.captureEvents(Event.MOUSEOVER|Event.MOUSEOUT|Event.CLICK|Event.DBLCLICK);document.onmouseover=s;document.onmouseout=s;</script>
<style> 
	body { background:#ffffff !important;}
</style> 
<?

	if(isset($_GET['ajaxf'])){
		$trans_href="{$data['slogin']}/transactions2".$data['ex'];
		$ajaxtrans="data-href=\"".$trans_href;
		$trans_target='target="modal_popup3_frame"';
		$trans_datah="data-";
		$trans_class="datahref";
		$_SESSION['trans_href']=$trans_href;
		$_SESSION['trans_datah']=$trans_datah;
		$_SESSION['trans_target']=$trans_target;
		$_SESSION['trans_class']=$trans_class;	
	}else{		
		$trans_href="{$data['slogin']}/transactions".$data['ex'];$ajaxtrans="href=\"".$trans_href;$trans_target='';$trans_datah="";$trans_class="";$_SESSION['trans_href']=$trans_href;$_SESSION['trans_datah']=$trans_datah;$_SESSION['trans_target']=$trans_target;$_SESSION['trans_class']=$trans_class;
	}
	
	//$trans_href="{$data['slogin']}/transactions2".$data['ex']; 	$ajaxtrans="target=\"modal_popup3_frame\" href=\"".$trans_href; 
	

?>
<script>var hostPath="<?php echo $data['Host']?>"; var trans_class="<?php echo $trans_class;?>";</script>
<?

//if($domain_server['STATUS']==true){$_SESSION['admin_theme_color']=$domain_server['sub_admin_css'];}




///////////////////// Color Option ////////////////////
///////////////////// Default Color Option hardcoaded ////////////////////

	
$body_bg_color=$data['bg_clrs'];
$body_text_color=$data['bg_txtclrs'];
	
$heading_bg_color=$data['bg_clrs'];
$heading_text_color=$data['bg_txtclrs'];


// Fetch dynamic template colors
include($data['Path'].'/include/header_color_ux'.$data['iex']);
// Fetch fontawasome icon 
include($data['Path'].'/include/fontawasome_icon'.$data['iex']);

// include for Adjustment Template Color & size by merchant added by vikash on 05012023
include($data['Path'].'/include/color_font_adjustment_ux'.$data['iex']);
?>
<style>
:root { 
  --color-1: <?=@$data['bg_txtclrs'];?>;
  --background-1: <?=@$data['bg_clrs'];?>;
  }

</style> 

<link rel="stylesheet" type="text/css" href="<?=@$data['Host']?>/js/jquery-te-1.4.0.css"/>
<script src="<?=@$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>



<style type="text/css">
<? if(isset($domain_server['STYLE'])) echo $domain_server['STYLE']?>

</style> 
</head>
<body class='admins <?=@$data['PageFile']?> bnav' >

<div class="border rounded m-2 p-2" >
<div class="row" style="overflow:auto;">	<? if(isset($post['json_log_history']) && $post['json_log_history']&&$is_admin==true&&isset($_SESSION['login_adm']) && $_SESSION['login_adm']){?>		
		<div style="width:100%;float:left;clear:both;display:none;">
			<? //echo ($post['json_log_history']);?>
		</div>
		<div style="my-2">
			<? echo json_log_view($post['json_log_history']);?>
		</div>
	<? } ?></div>

<form method="post" name="data" <?=@$target_frm;?> >
<?=@$data['is_admin_input_hide'];?>
<? if((isset($data['Error'])&& $data['Error'])){ ?>
	<div class="alert alert-danger alert-dismissible fade show" role="alert">
	<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	<strong>Error!</strong> <?=prntext(@$data['Error'])?>
	</div>
<? }?>


<? if($post['gid']){
	if($data['ThisPageLabel'] == 'Edit Transaction'){
		$no_input="";
	}else{
		$no_input="no_input";
	}
?>
<input type="hidden" name="gid" value="<?=@$post['gid']?>">
<? }?>
<input type="hidden" name="unique_id" value="<? if(isset($post['unique_id'])) echo $post['unique_id']?>">

		
	
	
				<div class="row ">
					<h4 class="heading glyphicons list col"><i></i>Please enter transaction information/details </h4>

					<div class="col text-end">
						<button type="submit" name="edit" value="CONTINUE"  class="btn btn-primary col p=0 mt-0 me-4 " onClick="parent.$('#myModal12').modal('hide');" style="width:125px !important;" ><i class="far fa-check-circle"></i> Update</button>
					</div>
				</div>
				
				
	
<div class="row px-2">

<div class="col-sm-6 p-1">
<label for="transID">TransID <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
<input type="text" name="transID" id="transID" placeholder="" class="form-control <?=@$no_input;?>" value="<?=prntext(@$post['transID'])?>"  />
</div>

<? if($is_admin==true)
{ ?>


<div class="col-sm-6 p-1">
<label for="merID">merID <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
<input type="text" name="merID" id="merID" placeholder="MerID" class="form-control" value="<?=prntext(@$post['merID'])?>"  />
</div>


<div class="col-sm-6 p-1" style="display:none">
<label for="receiver">Date Time <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
<input type="text" name="tdate_time" class="hide" value="<?=@$post['tdate'];?>"  />
</div>

<div class="col-sm-6 p-1">	
<label for="tdate">Date <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
<input type="datetime-local" name="tdate" placeholder="" class="form-control" value="<?=date('Y-m-d\TH:i',strtotime($post['tdate']));?>"  required />
</div>
<div class="col-sm-6 p-1">
					
<label for="acquirerId">Acquirer<i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
<select name="acquirer" id="acquirerId" class="feed_input1 form-select"  required>
<option value=0>--Acquirer-- </option>
	<? if($post['acquirer']){ ?>
		<option selected="selected" value="<?=@$post['acquirer']?>"><?=@$post['acquirer']?> <?=@$data['acquirer_list'][$post['acquirer']];?></option>
	<? }?>
<? if(isset($data['acquirer_list'])&&$data['acquirer_list']){ foreach($data['acquirer_list'] as $key=>$value){if($value>6){ ?>
<option value="<?=@$key?>"><?=@$value?> </option>	
<? }}}?>
</select>
<script>
$('#acquirerId option[value="<?=(@$post['acquirer'])?>"]').prop('selected','selected');
</script>

</div>
<div class="col-sm-6 p-1">					
<label for="accountStatus">Trans Status <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
<select name="trans_status" id="accountStatus" class="feed_input1 form-select"  required>
<option value=0>--Trans Status-- </option>
<? if($data['TransactionStatus']){ foreach($data['TransactionStatus'] as $key=>$value){ ?>
<option value="<?=@$key;?>"><?=@$key?> <?=@$value;?></option>	
<? }}?>
</select>
<script>
$('#accountStatus option[value="<?=prntext(@$post['trans_status'])?>"]').prop('selected','selected');
</script>
</div>
<? }?>


	<div class="col-sm-6 p-1">
	<label for="bill_amt">Bill Amt<i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<input type="text" name="bill_amt" id="bill_amt" placeholder="$19.99" class="form-control" value="<?=(@$post['bill_amt'])?>"  />
	</div>
	
	<div class="col-sm-6 p-1">					
	<label for="bill_currency">Bill Currency <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<select name="bill_currency" id="bill_currency" class="feed_input1 form-select"  required>
	<option value="" disabled="" selected="">Bill Currency</option>
            <option value="AUD">A$ AUD</option>
            <option value="CAD">C$ CAD</option>
            <option value="CNY">¥ CNY</option>
            <option value="EUR">€ EUR</option>
            <option value="GBP">£ GBP</option>
            <option value="HKD">HK$ HKD</option>
            <option value="IDR">Rp IDR</option>
            <option value="INR">₹ INR</option>
            <option value="JPY">¥ JPY</option>
            <option value="MYR">RM MYR</option>
            <option value="MXN">$ MXN</option>
            <option value="SGD">S$ SGD</option>
            <option value="USD">$ USD</option>
	</select>
	<script>
	$('#bill_currency option[value="<?=prntext(@$post['bill_currency'])?>"]').prop('selected','selected');
	</script>
    </div>
	<div class="col-sm-6 p-1">
	<label for="fullname">Full Name <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<input type="text" name="fullname" id="fullname" placeholder="Full Name" class="form-control" value="<?=prntext(@$post['fullname'])?>"  />
	</div>
	<div class="col-sm-6 p-1">
		<label for="mop">MOP <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="mop" id="mop" placeholder="Enter MOP (Mode of Payment)" class="form-control" value="<?=prntext(@$post['mop'])?>"  />
	</div>
	
<?if(@$post['cso3']==0)
{?>
		<div class="col-sm-6 p-1">
			<label for="terNO">TerNO <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
			<input type="text" name="terNO" id="terNO" placeholder="Enter TerNO" class="form-control" value="<?=prntext(@$post['terNO'])?>"  />
		</div>
	


		<div class="col-sm-6 p-1">

			<? $cardno=card_decrypts256(@$post['ccno']); ?>
			<div style="display:none">
				<input type="text" name="ccno" class="hide" value="<?=@$post['ccno'];?>"  />
				<input type="text" name="cvvno" class="hide" value="<?=@$post['cvvno'];?>"  />
				<input type="text" name="Expm_mm" class="hide" value="<?=@$post['Expm_mm'];?>"  />
				<input type="text" name="Expm_yy" class="hide" value="<?=@$post['Expm_yy'];?>"  />
			</div>
		
			<label for="ccno">Card No. <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
			<input type="text" name="ccno1" id="ccno" placeholder="Enter Card No." class="form-control no_input" value="<?php echo ($cardno);?>"  />
		</div>
		
		<div style="display:none">
		
			<label for="cvvno">CVV No. <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
			<input type="text" name="cvvno1" id="cvvno" placeholder="Enter CVV No." class="form-control" value="<?=prntext(@$post['cvvno'])?>"  />
			<div class="separator"></div>

			<label for="Expm_mm">Exp. Month <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
			<input type="text" name="Expm_mm1" id="Expm_mm" placeholder="Enter Exp. Month" class="form-control" value="<?=prntext(@$post['Expm_mm'])?>"  />
			<div class="separator"></div>
			
			<label for="Expm_yy">Exp. Year <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
			<input type="text" name="Expm_yy1" id="Expm_yy" placeholder="Enter Exp. Year" class="form-control" value="<?=prntext(@$post['Expm_yy'])?>"  />
			<div class="separator"></div>
			
			
		</div>
	

							

								
		<div class="col-sm-6 p-1">
		<label for="Address">Bill Address <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="bill_address" placeholder="john joi 3225 NW 23th street Rd  " class="form-control" value="<?=prntext(@$post['bill_address'])?>"   />
		</div>
		<div style="display:none;">
		<div class="col-sm-6 p-1">
		<label for="Address">Address 2:</label>
		<input type="text" name="address2" placeholder="Maimi Florida" class="form-control" value="<?=prntext(@$post['address2'])?>"  />
		</div>		
		</div>		
	<? { ?>	
		<div class="col-sm-6 p-1">
			<label for="country_list">Bill Country <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
			<div class="ecol2 country_listdiv">
				<select name="bill_country" id="country_list"  class="form-select" autocomplete="false" > 
				<option value="" disabled="disabled" selected="selected">Select Country</option>
				<option value="AND" data-val="AD_AND_020_Andorra">Andorra</option><option value="ARE" data-val="AE_ARE_008_United Arab Emirates">United Arab Emirates</option><option value="AFG" data-val="AF_AFG_010_Afghanistan">Afghanistan</option><option value="ATG" data-val="AG_ATG_012_Antigua and Barbuda">Antigua and Barbuda</option><option value="AIA" data-val="AI_AIA_016_Anguilla">Anguilla</option><option value="ALB" data-val="AL_ALB_024_Albania">Albania</option><option value="ARM" data-val="AM_ARM_031_Armenia">Armenia</option><option value="ANT" data-val="AN_ANT_032_Netherlands Antilles">Netherlands Antilles</option><option value="AGO" data-val="AO_AGO_036_Angola">Angola</option><option value="ATA" data-val="AQ_ATA_040_Antarctica">Antarctica</option><option value="ARG" data-val="AR_ARG_044_Argentina">Argentina</option><option value="ASM" data-val="AS_ASM_048_American Samoa">American Samoa</option><option value="AUT" data-val="AT_AUT_050_Austria">Austria</option><option value="AUS" data-val="AU_AUS_051_Australia">Australia</option><option value="ABW" data-val="AW_ABW_052_Aruba">Aruba</option><option value="ALA" data-val="AX_ALA_056_ALA Aland Islands">ALA Aland Islands</option><option value="AZE" data-val="AZ_AZE_060_Azerbaijan">Azerbaijan</option><option value="BIH" data-val="BA_BIH_064_Bosnia and Herzegovina">Bosnia and Herzegovina</option><option value="BRB" data-val="BB_BRB_068_Barbados">Barbados</option><option value="BGD" data-val="BD_BGD_070_Bangladesh">Bangladesh</option><option value="BEL" data-val="BE_BEL_072_Belgium">Belgium</option><option value="BFA" data-val="BF_BFA_074_Burkina Faso">Burkina Faso</option><option value="BGR" data-val="BG_BGR_076_Bulgaria">Bulgaria</option><option value="BHR" data-val="BH_BHR_084_Bahrain">Bahrain</option><option value="BDI" data-val="BI_BDI_086_Burundi">Burundi</option><option value="BEN" data-val="BJ_BEN_090_Benin">Benin</option><option value="BLM" data-val="BL_BLM_092_Saint-Barth�lemy">Saint-Barth�lemy</option><option value="BMU" data-val="BM_BMU_096_Bermuda">Bermuda</option><option value="BRN" data-val="BN_BRN_100_Brunei Darussalam">Brunei Darussalam</option><option value="BOL" data-val="BO_BOL_104_Bolivia">Bolivia</option><option value="BRA" data-val="BR_BRA_108_Brazil">Brazil</option><option value="BHS" data-val="BS_BHS_112_Bahamas">Bahamas</option><option value="BTN" data-val="BT_BTN_116_Bhutan">Bhutan</option><option value="BVT" data-val="BV_BVT_120_Bouvet Island">Bouvet Island</option><option value="BWA" data-val="BW_BWA_124_Botswana">Botswana</option><option value="BLR" data-val="BY_BLR_132_Belarus">Belarus</option><option value="BLZ" data-val="BZ_BLZ_136_Belize">Belize</option><option value="CAN" data-val="CA_CAN_140_Canada">Canada</option><option value="CCK" data-val="CC_CCK_144_Cocos (Keeling) Islands">Cocos (Keeling) Islands</option><option value="COD" data-val="CD_COD_148_Congo, (Kinshasa)">Congo, (Kinshasa)</option><option value="CAF" data-val="CF_CAF_152_Central African Republic">Central African Republic</option><option value="COG" data-val="CG_COG_156_Congo (Brazzaville)">Congo (Brazzaville)</option><option value="CHE" data-val="CH_CHE_158_Switzerland">Switzerland</option><option value="CIV" data-val="CI_CIV_162_C�te d'Ivoire">C�te d'Ivoire</option><option value="COK" data-val="CK_COK_166_Cook Islands">Cook Islands</option><option value="CHL" data-val="CL_CHL_170_Chile">Chile</option><option value="CMR" data-val="CM_CMR_174_Cameroon">Cameroon</option><option value="CHN" data-val="CN_CHN_175_China">China</option><option value="COL" data-val="CO_COL_178_Colombia">Colombia</option><option value="CRI" data-val="CR_CRI_180_Costa Rica">Costa Rica</option><option value="CUB" data-val="CU_CUB_184_Cuba">Cuba</option><option value="CPV" data-val="CV_CPV_188_Cape Verde">Cape Verde</option><option value="CXR" data-val="CX_CXR_191_Christmas Island">Christmas Island</option><option value="CYP" data-val="CY_CYP_192_Cyprus">Cyprus</option><option value="CZE" data-val="CZ_CZE_196_Czech Republic">Czech Republic</option><option value="DEU" data-val="DE_DEU_203_Germany">Germany</option><option value="DJI" data-val="DJ_DJI_204_Djibouti">Djibouti</option><option value="DNK" data-val="DK_DNK_208_Denmark">Denmark</option><option value="DMA" data-val="DM_DMA_212_Dominica">Dominica</option><option value="DOM" data-val="DO_DOM_214_Dominican Republic">Dominican Republic</option><option value="DZA" data-val="DZ_DZA_218_Algeria">Algeria</option><option value="ECU" data-val="EC_ECU_222_Ecuador">Ecuador</option><option value="EST" data-val="EE_EST_226_Estonia">Estonia</option><option value="EGY" data-val="EG_EGY_231_Egypt">Egypt</option><option value="ESH" data-val="EH_ESH_232_Western Sahara">Western Sahara</option><option value="ERI" data-val="ER_ERI_233_Eritrea">Eritrea</option><option value="ESP" data-val="ES_ESP_234_Spain">Spain</option><option value="ETH" data-val="ET_ETH_238_Ethiopia">Ethiopia</option><option value="FIN" data-val="FI_FIN_239_Finland">Finland</option><option value="FJI" data-val="FJ_FJI_242_Fiji">Fiji</option><option value="FLK" data-val="FK_FLK_246_Falkland Islands (Malvinas)">Falkland Islands (Malvinas)</option><option value="FSM" data-val="FM_FSM_248_Micronesia, Federated States of">Micronesia, Federated States of</option><option value="FRO" data-val="FO_FRO_250_Faroe Islands">Faroe Islands</option><option value="FRA" data-val="FR_FRA_254_France">France</option><option value="GAB" data-val="GA_GAB_258_Gabon">Gabon</option><option value="GBR" data-val="GB_GBR_260_United Kingdom">United Kingdom</option><option value="GRD" data-val="GD_GRD_262_Grenada">Grenada</option><option value="GEO" data-val="GE_GEO_266_Georgia">Georgia</option><option value="GUF" data-val="GF_GUF_268_French Guiana">French Guiana</option><option value="GGY" data-val="GG_GGY_270_Guernsey">Guernsey</option><option value="GHA" data-val="GH_GHA_275_Ghana">Ghana</option><option value="GIB" data-val="GI_GIB_276_Gibraltar">Gibraltar</option><option value="GRL" data-val="GL_GRL_288_Greenland">Greenland</option><option value="GMB" data-val="GM_GMB_292_Gambia">Gambia</option><option value="GIN" data-val="GN_GIN_296_Guinea">Guinea</option><option value="GLP" data-val="GP_GLP_300_Guadeloupe">Guadeloupe</option><option value="GNQ" data-val="GQ_GNQ_304_Equatorial Guinea">Equatorial Guinea</option><option value="GRC" data-val="GR_GRC_308_Greece">Greece</option><option value="SGS" data-val="GS_SGS_312_South Georgia and the South Sandwich Islands">South Georgia and the South Sandwich Islands</option><option value="GTM" data-val="GT_GTM_316_Guatemala">Guatemala</option><option value="GUM" data-val="GU_GUM_320_Guam">Guam</option><option value="GNB" data-val="GW_GNB_324_Guinea-Bissau">Guinea-Bissau</option><option value="GUY" data-val="GY_GUY_328_Guyana">Guyana</option><option value="HKG" data-val="HK_HKG_332_Hong Kong, SAR China">Hong Kong, SAR China</option><option value="HMD" data-val="HM_HMD_334_Heard and Mcdonald Islands">Heard and Mcdonald Islands</option><option value="HND" data-val="HN_HND_336_Honduras">Honduras</option><option value="HRV" data-val="HR_HRV_340_Croatia">Croatia</option><option value="HTI" data-val="HT_HTI_344_Haiti">Haiti</option><option value="HUN" data-val="HU_HUN_348_Hungary">Hungary</option><option value="IDN" data-val="ID_IDN_352_Indonesia">Indonesia</option><option value="IRL" data-val="IE_IRL_356_Ireland">Ireland</option><option value="ISR" data-val="IL_ISR_360_Israel">Israel</option><option value="IMN" data-val="IM_IMN_364_Isle of Man">Isle of Man</option><option value="IND" data-val="IN_IND_368_India">India</option><option value="IOT" data-val="IO_IOT_372_British Indian Ocean Territory">British Indian Ocean Territory</option><option value="IRQ" data-val="IQ_IRQ_376_Iraq">Iraq</option><option value="IRN" data-val="IR_IRN_380_Iran, Islamic Republic of">Iran, Islamic Republic of</option><option value="ISL" data-val="IS_ISL_384_Iceland">Iceland</option><option value="ITA" data-val="IT_ITA_388_Italy">Italy</option><option value="JEY" data-val="JE_JEY_392_Jersey">Jersey</option><option value="JAM" data-val="JM_JAM_398_Jamaica">Jamaica</option><option value="JOR" data-val="JO_JOR_400_Jordan">Jordan</option><option value="JPN" data-val="JP_JPN_404_Japan">Japan</option><option value="KEN" data-val="KE_KEN_408_Kenya">Kenya</option><option value="KGZ" data-val="KG_KGZ_410_Kyrgyzstan">Kyrgyzstan</option><option value="KHM" data-val="KH_KHM_414_Cambodia">Cambodia</option><option value="KIR" data-val="KI_KIR_417_Kiribati">Kiribati</option><option value="COM" data-val="KM_COM_418_Comoros">Comoros</option><option value="KNA" data-val="KN_KNA_422_Saint Kitts and Nevis">Saint Kitts and Nevis</option><option value="PRK" data-val="KP_PRK_426_Korea (North)">Korea (North)</option><option value="KOR" data-val="KR_KOR_428_Korea (South)">Korea (South)</option><option value="KWT" data-val="KW_KWT_430_Kuwait">Kuwait</option><option value="CYM" data-val="KY_CYM_434_Cayman Islands">Cayman Islands</option><option value="KAZ" data-val="KZ_KAZ_438_Kazakhstan">Kazakhstan</option><option value="LAO" data-val="LA_LAO_440_Lao PDR">Lao PDR</option><option value="LBN" data-val="LB_LBN_442_Lebanon">Lebanon</option><option value="LCA" data-val="LC_LCA_446_Saint Lucia">Saint Lucia</option><option value="LIE" data-val="LI_LIE_450_Liechtenstein">Liechtenstein</option><option value="LKA" data-val="LK_LKA_454_Sri Lanka">Sri Lanka</option><option value="LBR" data-val="LR_LBR_458_Liberia">Liberia</option><option value="LSO" data-val="LS_LSO_462_Lesotho">Lesotho</option><option value="LTU" data-val="LT_LTU_466_Lithuania">Lithuania</option><option value="LUX" data-val="LU_LUX_470_Luxembourg">Luxembourg</option><option value="LVA" data-val="LV_LVA_474_Latvia">Latvia</option><option value="LBY" data-val="LY_LBY_478_Libya">Libya</option><option value="MAR" data-val="MA_MAR_480_Morocco">Morocco</option><option value="MCO" data-val="MC_MCO_484_Monaco">Monaco</option><option value="MDA" data-val="MD_MDA_492_Moldova">Moldova</option><option value="MNE" data-val="ME_MNE_496_Montenegro">Montenegro</option><option value="MAF" data-val="MF_MAF_498_Saint-Martin (French part)">Saint-Martin (French part)</option><option value="MDG" data-val="MG_MDG_499_Madagascar">Madagascar</option><option value="MHL" data-val="MH_MHL_500_Marshall Islands">Marshall Islands</option><option value="MKD" data-val="MK_MKD_504_Macedonia, Republic of">Macedonia, Republic of</option><option value="MLI" data-val="ML_MLI_508_Mali">Mali</option><option value="MMR" data-val="MM_MMR_512_Myanmar">Myanmar</option><option value="MNG" data-val="MN_MNG_516_Mongolia">Mongolia</option><option value="MAC" data-val="MO_MAC_520_Macao, SAR China">Macao, SAR China</option><option value="MNP" data-val="MP_MNP_524_Northern Mariana Islands">Northern Mariana Islands</option><option value="MTQ" data-val="MQ_MTQ_528_Martinique">Martinique</option><option value="MRT" data-val="MR_MRT_530_Mauritania">Mauritania</option><option value="MSR" data-val="MS_MSR_533_Montserrat">Montserrat</option><option value="MLT" data-val="MT_MLT_540_Malta">Malta</option><option value="MUS" data-val="MU_MUS_548_Mauritius">Mauritius</option><option value="MDV" data-val="MV_MDV_554_Maldives">Maldives</option><option value="MWI" data-val="MW_MWI_558_Malawi">Malawi</option><option value="MEX" data-val="MX_MEX_562_Mexico">Mexico</option><option value="MYS" data-val="MY_MYS_566_Malaysia">Malaysia</option><option value="MOZ" data-val="MZ_MOZ_570_Mozambique">Mozambique</option><option value="NAM" data-val="NA_NAM_574_Namibia">Namibia</option><option value="NCL" data-val="NC_NCL_578_New Caledonia">New Caledonia</option><option value="NER" data-val="NE_NER_580_Niger">Niger</option><option value="NFK" data-val="NF_NFK_581_Norfolk Island">Norfolk Island</option><option value="NGA" data-val="NG_NGA_583_Nigeria">Nigeria</option><option value="NIC" data-val="NI_NIC_584_Nicaragua">Nicaragua</option><option value="NLD" data-val="NL_NLD_585_Netherlands">Netherlands</option><option value="NOR" data-val="NO_NOR_586_Norway">Norway</option><option value="NPL" data-val="NP_NPL_591_Nepal">Nepal</option><option value="NRU" data-val="NR_NRU_598_Nauru">Nauru</option><option value="NIU" data-val="NU_NIU_600_Niue">Niue</option><option value="NZL" data-val="NZ_NZL_604_New Zealand">New Zealand</option><option value="OMN" data-val="OM_OMN_608_Oman">Oman</option><option value="PAN" data-val="PA_PAN_612_Panama">Panama</option><option value="PER" data-val="PE_PER_616_Peru">Peru</option><option value="PYF" data-val="PF_PYF_620_French Polynesia">French Polynesia</option><option value="PNG" data-val="PG_PNG_624_Papua New Guinea">Papua New Guinea</option><option value="PHL" data-val="PH_PHL_626_Philippines">Philippines</option><option value="PAK" data-val="PK_PAK_630_Pakistan">Pakistan</option><option value="POL" data-val="PL_POL_634_Poland">Poland</option><option value="SPM" data-val="PM_SPM_638_Saint Pierre and Miquelon">Saint Pierre and Miquelon</option><option value="PCN" data-val="PN_PCN_642_Pitcairn">Pitcairn</option><option value="PRI" data-val="PR_PRI_643_Puerto Rico">Puerto Rico</option><option value="PSE" data-val="PS_PSE_646_Palestinian Territory">Palestinian Territory</option><option value="PRT" data-val="PT_PRT_652_Portugal">Portugal</option><option value="PLW" data-val="PW_PLW_654_Palau">Palau</option><option value="PRY" data-val="PY_PRY_659_Paraguay">Paraguay</option><option value="QAT" data-val="QA_QAT_660_Qatar">Qatar</option><option value="REU" data-val="RE_REU_662_R�union">R�union</option><option value="ROU" data-val="RO_ROU_663_Romania">Romania</option><option value="SRB" data-val="RS_SRB_666_Serbia">Serbia</option><option value="RUS" data-val="RU_RUS_670_Russian Federation">Russian Federation</option><option value="RWA" data-val="RW_RWA_674_Rwanda">Rwanda</option><option value="SAU" data-val="SA_SAU_678_Saudi Arabia">Saudi Arabia</option><option value="SLB" data-val="SB_SLB_682_Solomon Islands">Solomon Islands</option><option value="SYC" data-val="SC_SYC_686_Seychelles">Seychelles</option><option value="SDN" data-val="SD_SDN_688_Sudan">Sudan</option><option value="SWE" data-val="SE_SWE_690_Sweden">Sweden</option><option value="SGP" data-val="SG_SGP_694_Singapore">Singapore</option><option value="SHN" data-val="SH_SHN_702_Saint Helena">Saint Helena</option><option value="SVN" data-val="SI_SVN_703_Slovenia">Slovenia</option><option value="SJM" data-val="SJ_SJM_704_Svalbard and Jan Mayen Islands">Svalbard and Jan Mayen Islands</option><option value="SVK" data-val="SK_SVK_705_Slovakia">Slovakia</option><option value="SLE" data-val="SL_SLE_706_Sierra Leone">Sierra Leone</option><option value="SMR" data-val="SM_SMR_710_San Marino">San Marino</option><option value="SEN" data-val="SN_SEN_716_Senegal">Senegal</option><option value="SOM" data-val="SO_SOM_724_Somalia">Somalia</option><option value="SUR" data-val="SR_SUR_728_Suriname">Suriname</option><option value="SSD" data-val="SS_SSD_732_South Sudan">South Sudan</option><option value="STP" data-val="ST_STP_736_Sao Tome and Principe">Sao Tome and Principe</option><option value="SLV" data-val="SV_SLV_740_El Salvador">El Salvador</option><option value="SYR" data-val="SY_SYR_744_Syrian Arab Republic (Syria)">Syrian Arab Republic (Syria)</option><option value="SWZ" data-val="SZ_SWZ_748_Swaziland">Swaziland</option><option value="TCA" data-val="TC_TCA_752_Turks and Caicos Islands">Turks and Caicos Islands</option><option value="TCD" data-val="TD_TCD_756_Chad">Chad</option><option value="ATF" data-val="TF_ATF_760_French Southern Territories">French Southern Territories</option><option value="TGO" data-val="TG_TGO_762_Togo">Togo</option><option value="THA" data-val="TH_THA_764_Thailand">Thailand</option><option value="TJK" data-val="TJ_TJK_768_Tajikistan">Tajikistan</option><option value="TKL" data-val="TK_TKL_772_Tokelau">Tokelau</option><option value="TLS" data-val="TL_TLS_776_Timor-Leste">Timor-Leste</option><option value="TKM" data-val="TM_TKM_780_Turkmenistan">Turkmenistan</option><option value="TUN" data-val="TN_TUN_784_Tunisia">Tunisia</option><option value="TON" data-val="TO_TON_788_Tonga">Tonga</option><option value="TUR" data-val="TR_TUR_792_Turkey">Turkey</option><option value="TTO" data-val="TT_TTO_795_Trinidad and Tobago">Trinidad and Tobago</option><option value="TUV" data-val="TV_TUV_796_Tuvalu">Tuvalu</option><option value="TWN" data-val="TW_TWN_798_Taiwan, Republic of China">Taiwan, Republic of China</option><option value="TZA" data-val="TZ_TZA_800_Tanzania, United Republic of">Tanzania, United Republic of</option><option value="UKR" data-val="UA_UKR_804_Ukraine">Ukraine</option><option value="UGA" data-val="UG_UGA_807_Uganda">Uganda</option><option value="UMI" data-val="UM_UMI_818_US Minor Outlying Islands">US Minor Outlying Islands</option><option value="USA" data-val="US_USA_826_United States of America">United States of America</option><option value="URY" data-val="UY_URY_831_Uruguay">Uruguay</option><option value="UZB" data-val="UZ_UZB_832_Uzbekistan">Uzbekistan</option><option value="VAT" data-val="VA_VAT_833_Holy See (Vatican City State)">Holy See (Vatican City State)</option><option value="VCT" data-val="VC_VCT_834_Saint Vincent and Grenadines">Saint Vincent and Grenadines</option><option value="VEN" data-val="VE_VEN_840_Venezuela (Bolivarian Republic)">Venezuela (Bolivarian Republic)</option><option value="VGB" data-val="VG_VGB_850_British Virgin Islands">British Virgin Islands</option><option value="VIR" data-val="VI_VIR_854_Virgin Islands, US">Virgin Islands, US</option><option value="VNM" data-val="VN_VNM_858_Viet Nam">Viet Nam</option><option value="VUT" data-val="VU_VUT_860_Vanuatu">Vanuatu</option><option value="WLF" data-val="WF_WLF_862_Wallis and Futuna Islands">Wallis and Futuna Islands</option><option value="WSM" data-val="WS_WSM_876_Samoa">Samoa</option><option value="YEM" data-val="YE_YEM_882_Yemen">Yemen</option><option value="MYT" data-val="YT_MYT_887_Mayotte">Mayotte</option><option value="ZAF" data-val="ZA_ZAF_894_South Africa">South Africa</option><option value="ZMB" data-val="ZM_ZMB_004_Zambia">Zambia</option><option value="ZWE" data-val="ZW_ZWE_028_Zimbabwe">Zimbabwe</option>
				</select> 
			</div>
		</div>
		<div class="col-sm-6 p-1">
		<label for="state_list">Bill State <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>	
		<div id="state_input_divid" class="ecol2">
			<select name="bill_state" id="state_list" class="form-select"  > 
			<option value="" disabled="disabled" selected="selected">Select State</option><option value="AF">Afghanistan</option><option value="AL">Albania</option><option value="DZ">Algeria</option><option value="AS">American Samoa</option><option value="AD">Andorra</option><option value="AO">Angola</option><option value="AI">Anguilla</option><option value="AQ">Antarctica</option><option value="AG">Antigua And Barbuda</option><option value="AR">Argentina</option><option value="AM">Armenia</option><option value="AW">Aruba</option><option value="AU">Australia</option><option value="AT">Austria</option><option value="AZ">Azerbaijan</option><option value="BS">Bahamas</option><option value="BH">Bahrain</option><option value="BD">Bangladesh</option><option value="BB">Barbados</option><option value="BY">Belarus</option><option value="BE">Belgium</option><option value="BZ">Belize</option><option value="BJ">Benin</option><option value="BM">Bermuda</option><option value="BT">Bhutan</option><option value="BO">Bolivia</option><option value="BA">Bosnia And Herzegowina</option><option value="BW">Botswana</option><option value="BV">Bouvet Island</option><option value="BR">Brazil</option><option value="IO">British Indian Ocean Territory</option><option value="BN">Brunei Darussalam</option><option value="BG">Bulgaria</option><option value="BF">Burkina Faso</option><option value="BI">Burundi</option><option value="KH">Cambodia</option><option value="CM">Cameroon</option><option value="CA">Canada</option><option value="CV">Cape Verde</option><option value="KY">Cayman Islands</option><option value="CF">Central African Republic</option><option value="TD">Chad</option><option value="CL">Chile</option><option value="CN">China</option><option value="CX">Christmas Island</option><option value="CC">Cocos (Keeling) Islands</option><option value="CO">Colombia</option><option value="KM">Comoros</option><option value="CG">Congo</option><option value="CK">Cook Islands</option><option value="CR">Costa Rica</option><option value="HR">Croatia</option><option value="CU">Cuba</option><option value="CY">Cyprus</option><option value="CZ">Czech Republic</option><option value="DK">Denmark</option><option value="DJ">Djibouti</option><option value="DM">Dominica</option><option value="DO">Dominican Republic</option><option value="TL">Timor-Leste</option><option value="EC">Ecuador</option><option value="EG">Egypt</option><option value="SV">El Salvador</option><option value="GQ">Equatorial Guinea</option><option value="ER">Eritrea</option><option value="EE">Estonia</option><option value="ET">Ethiopia</option><option value="FK">Falkland Islands (Malvinas)</option><option value="FO">Faroe Islands</option><option value="FJ">Fiji</option><option value="FI">Finland</option><option value="FR">France</option><option value="GF">French Guiana</option><option value="PF">French Polynesia</option><option value="TF">French Southern Territories</option><option value="GA">Gabon</option><option value="GM">Gambia</option><option value="GE">Georgia</option><option value="DE">Germany</option><option value="GH">Ghana</option><option value="GI">Gibraltar</option><option value="GR">Greece</option><option value="GL">Greenland</option><option value="GD">Grenada</option><option value="GP">Guadeloupe</option><option value="GU">Guam</option><option value="GT">Guatemala</option><option value="GN">Guinea</option><option value="GW">Guinea-bissau</option><option value="GY">Guyana</option><option value="HT">Haiti</option><option value="HM">Heard And Mc Donald Islands</option><option value="HN">Honduras</option><option value="HK">Hong Kong</option><option value="HU">Hungary</option><option value="IS">Iceland</option><option value="IN">India</option><option value="ID">Indonesia</option><option value="IR">Iran</option><option value="IQ">Iraq</option><option value="IE">Ireland</option><option value="IL">Israel</option><option value="IT">Italy</option><option value="JM">Jamaica</option><option value="JP">Japan</option><option value="JO">Jordan</option><option value="KZ">Kazakhstan</option><option value="KE">Kenya</option><option value="KI">Kiribati</option><option value="KP">Korea</option><option value="KR">Republic Of Korea</option><option value="KW">Kuwait</option><option value="KG">Kyrgyzstan</option><option value="LA">Lao</option><option value="LV">Latvia</option><option value="LB">Lebanon</option><option value="LS">Lesotho</option><option value="LR">Liberia</option><option value="LY">Libyan Arab Jamahiriya</option><option value="LI">Liechtenstein</option><option value="LT">Lithuania</option><option value="LU">Luxembourg</option><option value="MO">Macao</option><option value="MK">Macedonia</option><option value="MG">Madagascar</option><option value="MW">Malawi</option><option value="MY">Malaysia</option><option value="MV">Maldives</option><option value="ML">Mali</option><option value="MT">Malta</option><option value="MH">Marshall Islands</option><option value="MQ">Martinique</option><option value="MR">Mauritania</option><option value="MU">Mauritius</option><option value="YT">Mayotte</option><option value="MX">Mexico</option><option value="FM">Micronesia</option><option value="MD">Moldova</option><option value="MC">Monaco</option><option value="MN">Mongolia</option><option value="MS">Montserrat</option><option value="MA">Morocco</option><option value="MZ">Mozambique</option><option value="MM">Myanmar</option><option value="NA">Namibia</option><option value="NR">Nauru</option><option value="NP">Nepal</option><option value="NL">Netherlands</option><option value="AN">Netherlands Antilles</option><option value="NC">New Caledonia</option><option value="NZ">New Zealand</option><option value="NI">Nicaragua</option><option value="NE">Niger</option><option value="NG">Nigeria</option><option value="NU">Niue</option><option value="NF">Norfolk Island</option><option value="MP">Northern Mariana Islands</option><option value="NO">Norway</option><option value="OM">Oman</option><option value="PK">Pakistan</option><option value="PW">Palau</option><option value="PA">Panama</option><option value="PG">Papua New Guinea</option><option value="PY">Paraguay</option><option value="PE">Peru</option><option value="PH">Philippines</option><option value="PN">Pitcairn</option><option value="PL">Poland</option><option value="PT">Portugal</option><option value="PR">Puerto Rico</option><option value="QA">Qatar</option><option value="RE">Reunion</option><option value="RO">Romania</option><option value="RU">Russian Federation</option><option value="RW">Rwanda</option><option value="KN">Saint Kitts And Nevis</option><option value="LC">Saint Lucia</option><option value="VC">Saint Vincent And The Grenadines</option><option value="WS">Samoa</option><option value="SM">San Marino</option><option value="ST">Sao Tome And Principe</option><option value="SA">Saudi Arabia</option><option value="SN">Senegal</option><option value="SC">Seychelles</option><option value="SL">Sierra Leone</option><option value="SG">Singapore</option><option value="SK">Slovakia </option><option value="SI">Slovenia</option><option value="SB">Solomon Islands</option><option value="SO">Somalia</option><option value="ZA">South Africa</option><option value="GS">South Georgia And The South Sandwich Islands</option><option value="ES">Spain</option><option value="LK">Sri Lanka</option><option value="SH">St. Helena</option><option value="PM">St. Pierre And Miquelon</option><option value="SD">Sudan</option><option value="SR">Suriname</option><option value="SJ">Svalbard And Jan Mayen Islands</option><option value="SZ">Swaziland</option><option value="SE">Sweden</option><option value="CH">Switzerland</option><option value="SY">Syrian Arab Republic</option><option value="TW">Taiwan</option><option value="TJ">Tajikistan</option><option value="TZ">Tanzania</option><option value="TH">Thailand</option><option value="TG">Togo</option><option value="TK">Tokelau</option><option value="TO">Tonga</option><option value="TT">Trinidad And Tobago</option><option value="TN">Tunisia</option><option value="TR">Turkey</option><option value="TM">Turkmenistan</option><option value="TC">Turks And Caicos Islands</option><option value="TV">Tuvalu</option><option value="UG">Uganda</option><option value="UA">Ukraine</option><option value="AE">United Arab Emirates</option><option value="GB">United Kingdom</option><option value="US">United States</option><option value="UM">United States Minor Outlying Islands</option><option value="UY">Uruguay</option><option value="UZ">Uzbekistan</option><option value="VU">Vanuatu</option><option value="VA">Vatican City State </option><option value="VE">Venezuela</option><option value="VN">Viet Nam</option><option value="VG">Virgin Islands (British)</option><option value="VI">Virgin Islands (U.S.)</option><option value="WF">Wallis And Futuna Islands</option><option value="EH">Western Sahara</option><option value="YE">Yemen</option><option value="RS">Serbia</option><option value="ZM">Zambia</option><option value="ZW">Zimbabwe</option><option value="AX">Aaland Islands</option>
			</select> 
		</div>
			

		<script>
			$("#country_list").change(function(e){
			
				/*var coun_opt_data = $('#country_list option[value="'+$(this).val()+'"]').attr('data-val');
				if(($(this).val().length===3) && (coun_opt_data!==undefined)){
					//alert("\r\ndata1="+coun_opt_data);
					$('#country_name').val(coun_opt_data);
				}*/
			//alert($(this).val()+"\r\n"+$(this).find('option:selected').text()+"\r\n"+$(this).find('option:selected').attr('data-val'));
			$('#country_name').val($(this).find('option:selected').attr('data-val'));
			
			$('#state_input_divid').html('<input type="text" class="form-control" placeholder="State" type="text" id="state_list" name=bill_state size=100 maxlength=128 value="<?=@$post['bill_state']?>" >');
			var state_selected='<select name="bill_state" id="state_list" style="font-size:14px" ><option value="" disabled="disabled" selected="selected">Select State</option>';
			var state_selected2='</select>';
			if($(this).val()==="USA"){
				$('#state_input_divid').html(state_selected+'<option value="AL">Alabama</option><option value="AK">Alaska</option><option value="AS">American Samoa</option><option value="AZ">Arizona</option><option value="AR">Arkansas</option><option value="AF">Armed Forces Africa</option><option value="AA">Armed Forces Americas</option><option value="AC">Armed Forces Canada</option><option value="AE">Armed Forces Europe</option><option value="AM">Armed Forces Middle East</option><option value="AP">Armed Forces Pacific</option><option value="CA">California</option><option value="CO">Colorado</option><option value="CT">Connecticut</option><option value="DE">Delaware</option><option value="DC">District Of Columbia</option><option value="FM">Federated States Of Micronesia</option><option value="FL">Florida</option><option value="GA">Georgia</option><option value="GU">Guam</option><option value="HI">Hawaii</option><option value="ID">Idaho</option><option value="IL">Illinois</option><option value="IN">Indiana</option><option value="IA">Iowa</option><option value="KS">Kansas</option><option value="KY">Kentucky</option><option value="LA">Louisiana</option><option value="ME">Maine</option><option value="MH">Marshall Islands</option><option value="MD">Maryland</option><option value="MA">Massachusetts</option><option value="MI">Michigan</option><option value="MN">Minnesota</option><option value="MS">Mississippi</option><option value="MO">Missouri</option><option value="MT">Montana</option><option value="NE">Nebraska</option><option value="NV">Nevada</option><option value="NH">New Hampshire</option><option value="NJ">New Jersey</option><option value="NM">New Mexico</option><option value="NY">New York</option><option value="NC">North Carolina</option><option value="ND">North Dakota</option><option value="MP">Northern Mariana Islands</option><option value="OH">Ohio</option><option value="OK">Oklahoma</option><option value="OR">Oregon</option><option value="PA">Pennsylvania</option><option value="PR">Puerto Rico</option><option value="RI">Rhode Island</option><option value="SC">South Carolina</option><option value="SD">South Dakota</option><option value="TN">Tennessee</option><option value="TX">Texas</option><option value="UT">Utah</option><option value="VT">Vermont</option><option value="VI">Virgin Islands</option><option value="VA">Virginia</option><option value="WA">Washington</option><option value="WV">West Virginia</option><option value="WI">Wisconsin</option><option value="WY">Wyoming</option>'+state_selected2);
			}else if($(this).val()==="CAN"){
				$('#state_input_divid').html(state_selected+'<option value="AB">Alberta</option><option value="BC">British Columbia</option><option value="MB">Manitoba</option><option value="NL">Newfoundland</option><option value="NB">New Brunswick</option><option value="NS">Nova Scotia</option><option value="NT">Northwest Territories</option><option value="NU">Nunavut</option><option value="ON">Ontario</option><option value="PE">Prince Edward Island</option><option value="QC">Quebec</option><option value="SK">Saskatchewan</option><option value="YT">Yukon Territory</option>'+state_selected2);
			}else if($(this).val()==="AUS"){
				$('#state_input_divid').html(state_selected+'<option value="ACT">Australian Capital Territory</option><option value="NSW">New South Wales</option><option value="NT">Northern Territory</option><option value="QLD">Queensland</option><option value="SA">South Australia</option><option value="TAS">Tasmania</option><option value="VIC">Victoria</option><option value="WA">Western Australia</option>'+state_selected2);
			}else if($(this).val()==="JPN"){
				$('#state_input_divid').html(state_selected+'<option value="HK">Hokkaido</option><option value="AO">Aomori</option><option value="IW">Iwate</option><option value="MY">Miyagi</option><option value="AK">Akita</option><option value="YM">Yamagata</option><option value="FK">Fukushima</option><option value="IB">Ibaragi</option><option value="TC">Tochigi</option><option value="GU">Gunma</option><option value="SI">Saitama</option><option value="CB">Chiba</option><option value="TK">Tokyo</option><option value="KN">Kanagawa</option><option value="NI">Niigata</option><option value="TY">Toyama</option><option value="IS">Ishikawa</option><option value="FI">Fukui</option><option value="YN">Yamanashi</option><option value="NG">Nagano</option><option value="GF">Gifu</option><option value="SZ">Shizuoka</option><option value="AI">Aichi</option><option value="ME">Mie</option><option value="SG">Shiga</option><option value="KT">Kyoto</option><option value="OS">Osaka</option><option value="HG">Hyogo</option><option value="NR">Nara</option><option value="WK">Wakayama</option><option value="TT">Tottori</option><option value="SM">Shimane</option><option value="OK">Okayama</option><option value="HR">Hiroshima</option><option value="YG">Yamaguchi</option><option value="TS">Tokushima</option><option value="KG">Kagawa</option><option value="EH">Ehime</option><option value="KC">Kouchi</option><option value="FO">Fukuoka</option><option value="SA">Saga</option><option value="NS">Nagasaki</option><option value="KM">Kumamoto</option><option value="OI">Ooita</option><option value="MZ">Miyazaki</option><option value="KS">Kagoshima</option>'+state_selected2);
			}
			});
			
			$('#country_list option[data-val*="<?=@$post['bill_country']?>_"]').prop('selected','selected');
			$("#country_list").trigger("change");
			
			setTimeout(function(){
				$('#state_list option[value*="<?=@$post['state_iso2']?>"]').prop('selected','selected');
			}, 1000);
			
			</script>
			</div>
	<? }?>
			
		<div class="col-sm-6 p-1">
		<label for="City">Bill City <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="bill_city" placeholder="Maimi Florida" class="form-control" value="<?=prntext(@$post['bill_city'])?>"  />
		</div>

		<div class="col-sm-6 p-1">
		<label for="PostalCode">Bill Zip <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="bill_zip"  placeholder="33124" class="form-control" value="<?=prntext(@$post['bill_zip'])?>"   />
		</div>	
		<div class="col-sm-6 p-1">
		<label for="Phone">Bill Phone <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="bill_phone" placeholder="425-666-2222"class="form-control" value="<?=prntext(@$post['bill_phone'])?>"   />	
		</div>
		<div class="col-sm-6 p-1">
		<label for="email">Bill Email <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="email" name="bill_email" placeholder="johnjio@gmail.com" class="form-control" value="<?=@$post['bill_email']?>"   />	
		</div>
<?}?>	

<? if($is_admin==true){ ?>
    <div class="col-sm-6 p-1">
	<label for="source_url">Source URL <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<input type="text" name="source_url" id="source_url" placeholder="Enter Source URL" class="form-control" value="<?=prntext(@$post['source_url'])?>"  />
	</div>
	<div class="col-sm-6 p-1">
	<label for="webhook_url">Webhook URL <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<input type="text" name="webhook_url" id="webhook_url" placeholder="Enter Notify URL" class="form-control" value="<?=prntext(@$post['webhook_url'])?>"  />
	</div>
	
	<div class="col-sm-6 p-1">	
	<label for="return_url">Return URL <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<input type="text" name="return_url" id="return_url" placeholder="Enter Success URL" class="form-control" value="<?=prntext(@$post['return_url'])?>"  />
	</div>
	



	<div class="col-sm-6 p-1">	
	<label for="rrn">RRN <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
<input type="text" name="rrn" id="rrn" placeholder="Enter RRN" class="form-control" value="<?=prntext(@$post['rrn'])?>"/>
	</div>
	
	<?if(@$post['cso3']==0){?>
		<div class="col-sm-6 p-1">
			<label for="descriptor" style="clear: both;">Descriptor <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
			<input type="text" name="descriptor" id="descriptor" placeholder="Enter Descriptor" class="form-control" value="<?=prntext(@$post['descriptor'])?>"  />
		</div>
	<?}?>
	
	<div class="col-sm-6 p-1">			
	<label for="acquirer_ref">Acquirer Ref<i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<input type="text" name="acquirer_ref" id="acquirer_ref" placeholder="Enter Trxn Id" class="form-control" value="<?=prntext(@$post['acquirer_ref'])?>"  />
	</div>
	
	<div class="col-sm-6 p-1">		
	<label for="acquirer_response">Acquirer Response <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<input type="text" name="acquirer_response" id="acquirer_response" placeholder="Enter Value" class="form-control" value='<?=(@$post['acquirer_response'])?>'  />
	</div>
	
	<div class="col-sm-6 p-1">	
	<label for="product_name">Product Name <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<input type="text" name="product_name" id="product_name" placeholder="Enter Value" class="form-control" value="<?=prntext(@$post['product_name'])?>"  />
	</div>
	
	    <div class="col-sm-6 p-1">	
		<label for="buy_mdr_amt">Buy MDR Amt <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="buy_mdr_amt" id="buy_mdr_amt" placeholder="" class="form-control" value="<?=prntext(@$post['buy_mdr_amt'])?>"  />
		</div>
		
	<? if(isset($data['con_name'])&&$data['con_name']=='clk'){ ?>
		<div class="col-sm-6 p-1">	
		<label for="gst_amt">GST Amt <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="gst_amt" id="gst_amt" placeholder="" class="form-control" value="<?=prntext(@$post['gst_amt'])?>"  />
		</div>
	<? } ?>	
	
		<div class="col-sm-6 p-1">
		<label for="buy_txnfee_amt">Buy Txnfee Amt <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="buy_txnfee_amt" id="buy_txnfee_amt" placeholder="" class="form-control" value="<?=prntext(@$post['buy_txnfee_amt'])?>"  />
		</div>
		
		<div class="col-sm-6 p-1">
		<label for="rolling_amt">Rolling Amt <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="rolling_amt" id="rolling_amt" placeholder="" class="form-control" value="<?=prntext(@$post['rolling_amt'])?>"  />    </div>
		
		<div class="col-sm-6 p-1">
		<label for="mdr_cb_amt">MDR CB Amt <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="mdr_cb_amt" id="mdr_cb_amt" placeholder="" class="form-control" value="<?=prntext(@$post['mdr_cb_amt'])?>"  /> </div>
		<div class="col-sm-6 p-1">
		<label for="mdr_cbk1_amt">MDR CBK1 Amt <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="mdr_cbk1_amt" id="mdr_cbk1_amt" placeholder="" class="form-control" value="<?=prntext(@$post['mdr_cbk1_amt'])?>"  />
		</div>
		
		<div class="col-sm-6 p-1">
		<label for="mdr_refundfee_amt">MDR Refund Fee Amt <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="mdr_refundfee_amt" id="mdr_refundfee_amt" placeholder="" class="form-control" value="<?=prntext(@$post['mdr_refundfee_amt'])?>"  />
		</div>
		
		<div class="col-sm-6 p-1">	
		<label for="available_rolling">Available Rolling <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="available_rolling" id="available_rolling" placeholder="" class="form-control" value="<?=prntext(@$post['available_rolling'])?>"  />
		</div>
		
		<div class="col-sm-6 p-1">
		<label for="available_balance">Available Balance <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="available_balance" id="available_balance" placeholder="" class="form-control" value="<?=prntext(@$post['available_balance'])?>"  />
		</div>
		
		<div class="col-sm-6 p-1">
		<label for="payable_amt_of_txn">Payable Amt of Trxn <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="payable_amt_of_txn" id="payable_amt_of_txn" placeholder="" class="form-control" value="<?=prntext(@$post['payable_amt_of_txn'])?>"  />
		</div>
		
		<div class="col-sm-6 p-1">
		<label for="settelement_date">Payout Date <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="date" name="settelement_date" id="settelement_date" placeholder="" class="form-control" value="<?=date('Y-m-d',strtotime($post['settelement_date']));?>"   />
		</div>
		
		<div class="col-sm-6 p-1">
		<label for="fee_update_timestamp"> Fee Update Date<i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="date" name="fee_update_timestamp" id="fee_update_timestamp" placeholder="" class="form-control" value="<?=date('Y-m-d',strtotime($post['fee_update_timestamp']));?>"   />
		</div>
		
		<div class="col-sm-6 p-1">
		<label for="trans_amt">Trans Amt <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="trans_amt" id="trans_amt" placeholder="" class="form-control" value="<?=prntext(@$post['trans_amt'])?>"  />
		</div>
		
		<div class="col-sm-6 p-1">
		<label for="remark_status">Remark Status <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="remark_status" id="remark_status" placeholder="" class="form-control" value="<?=prntext(@$post['remark_status'])?>"  />
		</div>
		
		
		
		<div class="col-sm-6 p-1">
		<label for="bill_ip">Bill IP <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="bill_ip" id="bill_ip" placeholder="" class="form-control" value="<?=prntext(@$post['bill_ip'])?>"  />
		</div>
		
		<div class="col-sm-6 p-1">
		<label for="bill_ip">Bank Processing Amount <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="bank_processing_amount" id="bank_processing_amount" placeholder="" class="form-control" value="<?=prntext(@$post['bank_processing_amount'])?>"  />
		</div>
		
		<div class="col-sm-6 p-1">
		<label for="bill_ip">Bank Processing Currency <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="bank_processing_curr" id="bank_processing_curr" placeholder="" class="form-control" value="<?=prntext(@$post['bank_processing_curr'])?>"  />
		</div>
		
		
		
		
<? }?>



<div class="col-sm-6 p-1">
<label for="bill_ip">Json Value <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="json_value" id="json_value" placeholder="" class="form-control" value='<?=(@$post['json_value'])?>'  />
</div>

<div class="col-sm-6 p-1">	
<label for="bill_ip">Trans Response <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
		<input type="text" name="trans_response" id="trans_response" placeholder="" class="form-control" value='<?=(@$post['trans_response'])?>'  />
</div>
		
<div class="col-sm-12 p-1">
<label for="mer_note" style="clear:left;">Merchant Note <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<textarea name="mer_note" id="mer_note" class="jqte-test form-control" placeholder="Enter Merchant Note"><?=stripslashes(@$post['mer_note']);?></textarea>
</div>
<div class="col-sm-12 p-1">
	<label for="system_note">System (Private) Note <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<textarea name="system_note" id="system_note" class="jqte-test form-control"  placeholder="Enter System Note"><?=stripslashes(@$post['system_note']);?></textarea>
</div>	
<div class="col-sm-12 p-1">
<label for="support_note">Support Note <i class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
	<textarea name="support_note" id="support_note" class="jqte-test form-control" rows="5" placeholder="Enter Support Note" ><?=stripslashes(@$post['support_note']);?></textarea>
</div>
					

<div class="my-2">
<? if($data['ThisPageLabel'] == 'Similar Transaction'){ ?>
<label for="send"> </label>
<button type="submit" name="send" value="CONTINUE"  class="btn btn-primary my-2" onClick="javascript:window.parent.$('#myModal12').modal('hide');" ><i class="far fa-check-circle"></i> Add New Transaction.</button>
<? }elseif($data['ThisPageLabel'] == 'Edit Transaction'){ ?>
<label for="edit">Transaction: </label>

<button type="submit" name="edit" value="CONTINUE"  class="btn btn-primary my-2" onClick="parent.$('#myModal12').modal('hide');" ><i class="far fa-check-circle"></i> Update</button>

<button type="submit" name="delete" value="CONTINUE"  class="btn btn-primary my-2"  onClick="return confirm('Are you Sure to DELETE this Transaction id is <?=@$post['transID'];?>');" ><i class="fa fa-times"></i> Delete</button>

<div name="cancelled" value="CONTINUE"  class="btn btn-primary my-2" onClick="parent.$('#myModal12').modal('hide');"  ><i></i>Cancelled</div>

<? }?>
</div>
</div>
</form>

</div>

 <link rel="stylesheet" type="text/css" href="<?=@$data['Host']?>/js/jquery-te-1.4.0.css"/>
<script src="<?=@$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>

<script>
	$('.jqte-test').jqte();
	
	// settings of status
	var jqteStatus = true;
	$(".status").click(function()
	{
		jqteStatus = jqteStatus ? false : true;
		$('.jqte-test').jqte({"status" : jqteStatus})
	});
</script>
</body>
</html>
