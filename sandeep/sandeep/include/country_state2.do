<?php
function get_state_code($state){
	$state=str_replace(array("\r", "\n", "\t","<br>","<br/>"), array("","","","",""), $state);
	$state=preg_replace('/\n+|\t+|\s+/',' ',$state);
	$state=trim($state);$state=strtolower($state);$state=ucwords($state);
	if(strlen($state)==2){$state=strtoupper($state);}
	$result_st=$state;
	switch($state){
		//For US
		case 'Alabama': $result_st='AL'; break;
		case 'Alaska': $result_st='AK'; break;
		case 'American Samoa': $result_st='AS'; break;
		case 'Arizona': $result_st='AZ'; break;
		case 'Arkansas': $result_st='AR'; break;
		case 'Armed Forces Africa': $result_st='AF'; break;
		case 'Armed Forces Americas': $result_st='AA'; break;
		case 'Armed Forces Canada': $result_st='AC'; break;
		case 'Armed Forces Europe': $result_st='AE'; break;
		case 'Armed Forces Middle East': $result_st='AM'; break;
		case 'Armed Forces Pacific': $result_st='AP'; break;
		case 'California': $result_st='CA'; break;
		case 'Colorado': $result_st='CO'; break;
		case 'Connecticut': $result_st='CT'; break;
		case 'Delaware': $result_st='DE'; break;
		case 'District Of Columbia': $result_st='DC'; break;
		case 'Federated States Of Micronesia': $result_st='FM'; break;
		case 'Florida': $result_st='FL'; break;
		case 'Georgia': $result_st='GA'; break;
		case 'Guam': $result_st='GU'; break;
		case 'Hawaii': $result_st='HI'; break;
		case 'Idaho': $result_st='ID'; break;
		case 'Illinois': $result_st='IL'; break;
		case 'Indiana': $result_st='IN'; break;
		case 'Iowa': $result_st='IA'; break;
		case 'Kansas': $result_st='KS'; break;
		case 'Kentucky': $result_st='KY'; break;
		case 'Louisiana': $result_st='LA'; break;
		case 'Maine': $result_st='ME'; break;
		case 'Marshall Islands': $result_st='MH'; break;
		case 'Maryland': $result_st='MD'; break;
		case 'Massachusetts': $result_st='MA'; break;
		case 'Michigan': $result_st='MI'; break;
		case 'Minnesota': $result_st='MN'; break;
		case 'Mississippi': $result_st='MS'; break;
		case 'Missouri': $result_st='MO'; break;
		case 'Montana': $result_st='MT'; break;
		case 'Nebraska': $result_st='NE'; break;
		case 'Nevada': $result_st='NV'; break;
		case 'New Hampshire': $result_st='NH'; break;
		case 'New Jersey': $result_st='NJ'; break;
		case 'New Mexico': $result_st='NM'; break;
		case 'New York': $result_st='NY'; break;
		case 'North Carolina': $result_st='NC'; break;
		case 'North Dakota': $result_st='ND'; break;
		case 'Northern Mariana Islands': $result_st='MP'; break;
		case 'Ohio': $result_st='OH'; break;
		case 'Oklahoma': $result_st='OK'; break;
		case 'Oregon': $result_st='OR'; break;
		case 'Pennsylvania': $result_st='PA'; break;
		case 'Puerto Rico': $result_st='PR'; break;
		case 'Rhode Island': $result_st='RI'; break;
		case 'South Carolina': $result_st='SC'; break;
		case 'South Dakota': $result_st='SD'; break;
		case 'Tennessee': $result_st='TN'; break;
		case 'Texas': $result_st='TX'; break;
		case 'Utah': $result_st='UT'; break;
		case 'Vermont': $result_st='VT'; break;
		case 'Virgin Islands': $result_st='VI'; break;
		case 'Virginia': $result_st='VA'; break;
		case 'Washington': $result_st='WA'; break;
		case 'West Virginia': $result_st='WV'; break;
		case 'Wisconsin': $result_st='WI'; break;
		case 'Wyoming': $result_st='WY'; break;
		//For Canada
		case 'Alberta': $result_st='AB'; break;
		case 'British Columbia': $result_st='BC'; break;
		case 'Manitoba': $result_st='MB'; break;
		case 'Newfoundland': $result_st='NL'; break;
		case 'New Brunswick': $result_st='NB'; break;
		case 'Nova Scotia': $result_st='NS'; break;
		case 'Northwest Territories': $result_st='NT'; break;
		case 'Nunavut': $result_st='NU'; break;
		case 'Ontario': $result_st='ON'; break;
		case 'Prince Edward Island': $result_st='PE'; break;
		case 'Quebec': $result_st='QC'; break;
		case 'Saskatchewan': $result_st='SK'; break;
		case 'Yukon Territory': $result_st='YT'; break;
		//For Australia
		case 'Australian Capital Territory': $result_st='ACT'; break;
		case 'New South Wales': $result_st='NSW'; break;
		case 'Northern Territory': $result_st='NT'; break;
		case 'Queensland': $result_st='QLD'; break;
		case 'South Australia': $result_st='SA'; break;
		case 'Tasmania': $result_st='TAS'; break;
		case 'Victoria': $result_st='VIC'; break;
		case 'Western Australia': $result_st='WA'; break;
		//For Japan
		case 'Hokkaido': $result_st='HK'; break;
		case 'Aomori': $result_st='AO'; break;
		case 'Iwate': $result_st='IW'; break;
		case 'Miyagi': $result_st='MY'; break;
		case 'Akita': $result_st='AK'; break;
		case 'Yamagata': $result_st='YM'; break;
		case 'Fukushima': $result_st='FK'; break;
		case 'Ibaragi': $result_st='IB'; break;
		case 'Tochigi': $result_st='TC'; break;
		case 'Gunma': $result_st='GU'; break;
		case 'Saitama': $result_st='SI'; break;
		case 'Chiba': $result_st='CB'; break;
		case 'Tokyo': $result_st='TK'; break;
		case 'Kanagawa': $result_st='KN'; break;
		case 'Niigata': $result_st='NI'; break;
		case 'Toyama': $result_st='TY'; break;
		case 'Ishikawa': $result_st='IS'; break;
		case 'Fukui': $result_st='FI'; break;
		case 'Yamanashi': $result_st='YN'; break;
		case 'Nagano': $result_st='NG'; break;
		case 'Gifu': $result_st='GF'; break;
		case 'Shizuoka': $result_st='SZ'; break;
		case 'Aichi': $result_st='AI'; break;
		case 'Mie': $result_st='ME'; break;
		case 'Shiga': $result_st='SG'; break;
		case 'Kyoto': $result_st='KT'; break;
		case 'Osaka': $result_st='OS'; break;
		case 'Hyogo': $result_st='HG'; break;
		case 'Nara': $result_st='NR'; break;
		case 'Wakayama': $result_st='WK'; break;
		case 'Tottori': $result_st='TT'; break;
		case 'Shimane': $result_st='SM'; break;
		case 'Okayama': $result_st='OK'; break;
		case 'Hiroshima': $result_st='HR'; break;
		case 'Yamaguchi': $result_st='YG'; break;
		case 'Tokushima': $result_st='TS'; break;
		case 'Kagawa': $result_st='KG'; break;
		case 'Ehime': $result_st='EH'; break;
		case 'Kouchi': $result_st='KC'; break;
		case 'Fukuoka': $result_st='FO'; break;
		case 'Saga': $result_st='SA'; break;
		case 'Nagasaki': $result_st='NS'; break;
		case 'Kumamoto': $result_st='KM'; break;
		case 'Ooita': $result_st='OI'; break;
		case 'Miyazaki': $result_st='MZ'; break;
		case 'Kagoshima': $result_st='KS'; break;
	}
	return $result_st;
}
			
function get_country_code($country,$names=0){
	$country=str_replace(array("\r", "\n", "\t","<br>","<br/>"), array("","","","",""), $country);
	$country=preg_replace('/\n+|\t+|\s+/',' ',$country);
	$country=trim($country);$country=strtolower($country);$country=ucwords($country);
	if(strlen($country)==3){$country=strtoupper($country);}
	//if(strlen($country)==3){$country=strtoupper(substr($country, 0, 2));}
	if(strlen($country)==2){$country=strtoupper($country);}
	$result_st=$country;  
	$country_1=$country;$country_2=$country;$country_3=$country;
	//echo $country; return false;
	if($country=="Afghanistan" || $country=="AF" || $country=="AFG"){
	 $country_1="Afghanistan";  $country_2="AF"; $country_3="AFG";
	}elseif($country=="ALA Aland Islands" || $country=="AX" || $country=="ALA"){
	 $country_1="ALA Aland Islands";  $country_2="AX"; $country_3="ALA";
	}elseif($country=="Albania" || $country=="AL" || $country=="ALB"){
	 $country_1="Albania";  $country_2="AL"; $country_3="ALB";
	}elseif($country=="Algeria" || $country=="DZ" || $country=="DZA"){
	 $country_1="Algeria";  $country_2="DZ"; $country_3="DZA";
	}elseif($country=="American Samoa" || $country=="AS" || $country=="ASM"){
	 $country_1="American Samoa";  $country_2="AS"; $country_3="ASM";
	}elseif($country=="Andorra" || $country=="AD" || $country=="AND"){
	 $country_1="Andorra";  $country_2="AD"; $country_3="AND";
	}elseif($country=="Angola" || $country=="AO" || $country=="AGO"){
	 $country_1="Angola";  $country_2="AO"; $country_3="AGO";
	}elseif($country=="Anguilla" || $country=="AI" || $country=="AIA"){
	 $country_1="Anguilla";  $country_2="AI"; $country_3="AIA";
	}elseif($country=="Antarctica" || $country=="AQ" || $country=="ATA"){
	 $country_1="Antarctica";  $country_2="AQ"; $country_3="ATA";
	}elseif($country=="Antigua And Barbuda" || $country=="AG" || $country=="ATG"){
	 $country_1="Antigua And Barbuda";  $country_2="AG"; $country_3="ATG";
	}elseif($country=="Argentina" || $country=="AR" || $country=="ARG"){
	 $country_1="Argentina";  $country_2="AR"; $country_3="ARG";
	}elseif($country=="Armenia" || $country=="AM" || $country=="ARM"){
	 $country_1="Armenia";  $country_2="AM"; $country_3="ARM";
	}elseif($country=="Aruba" || $country=="AW" || $country=="ABW"){
	 $country_1="Aruba";  $country_2="AW"; $country_3="ABW";
	}elseif($country=="Australia" || $country=="AU" || $country=="AUS"){
	 $country_1="Australia";  $country_2="AU"; $country_3="AUS";
	}elseif($country=="Austria" || $country=="AT" || $country=="AUT"){
	 $country_1="Austria";  $country_2="AT"; $country_3="AUT";
	}elseif($country=="Azerbaijan" || $country=="AZ" || $country=="AZE"){
	 $country_1="Azerbaijan";  $country_2="AZ"; $country_3="AZE";
	}elseif($country=="Bahamas" || $country=="BS" || $country=="BHS"){
	 $country_1="Bahamas";  $country_2="BS"; $country_3="BHS";
	}elseif($country=="Bahrain" || $country=="BH" || $country=="BHR"){
	 $country_1="Bahrain";  $country_2="BH"; $country_3="BHR";
	}elseif($country=="Bangladesh" || $country=="BD" || $country=="BGD"){
	 $country_1="Bangladesh";  $country_2="BD"; $country_3="BGD";
	}elseif($country=="Barbados" || $country=="BB" || $country=="BRB"){
	 $country_1="Barbados";  $country_2="BB"; $country_3="BRB";
	}elseif($country=="Belarus" || $country=="BY" || $country=="BLR"){
	 $country_1="Belarus";  $country_2="BY"; $country_3="BLR";
	}elseif($country=="Belgium" || $country=="BE" || $country=="BEL"){
	 $country_1="Belgium";  $country_2="BE"; $country_3="BEL";
	}elseif($country=="Belize" || $country=="BZ" || $country=="BLZ"){
	 $country_1="Belize";  $country_2="BZ"; $country_3="BLZ";
	}elseif($country=="Benin" || $country=="BJ" || $country=="BEN"){
	 $country_1="Benin";  $country_2="BJ"; $country_3="BEN";
	}elseif($country=="Bermuda" || $country=="BM" || $country=="BMU"){
	 $country_1="Bermuda";  $country_2="BM"; $country_3="BMU";
	}elseif($country=="Bhutan" || $country=="BT" || $country=="BTN"){
	 $country_1="Bhutan";  $country_2="BT"; $country_3="BTN";
	}elseif($country=="Bolivia" || $country=="BO" || $country=="BOL"){
	 $country_1="Bolivia";  $country_2="BO"; $country_3="BOL";
	}elseif($country=="Bosnia And Herzegovina" || $country=="BA" || $country=="BIH"){
	 $country_1="Bosnia And Herzegovina";  $country_2="BA"; $country_3="BIH";
	}elseif($country=="Botswana" || $country=="BW" || $country=="BWA"){
	 $country_1="Botswana";  $country_2="BW"; $country_3="BWA";
	}elseif($country=="Bouvet Island" || $country=="BV" || $country=="BVT"){
	 $country_1="Bouvet Island";  $country_2="BV"; $country_3="BVT";
	}elseif($country=="Brazil" || $country=="BR" || $country=="BRA"){
	 $country_1="Brazil";  $country_2="BR"; $country_3="BRA";
	}elseif($country=="British Indian Ocean Territory" || $country=="IO" || $country=="IOT"){
	 $country_1="British Indian Ocean Territory";  $country_2="IO"; $country_3="IOT";
	}elseif($country=="British Virgin Islands" || $country=="VG" || $country=="VGB"){
	 $country_1="British Virgin Islands";  $country_2="VG"; $country_3="VGB";
	}elseif($country=="Brunei Darussalam" || $country=="BN" || $country=="BRN"){
	 $country_1="Brunei Darussalam";  $country_2="BN"; $country_3="BRN";
	}elseif($country=="Bulgaria" || $country=="BG" || $country=="BGR"){
	 $country_1="Bulgaria";  $country_2="BG"; $country_3="BGR";
	}elseif($country=="Burkina Faso" || $country=="BF" || $country=="BFA"){
	 $country_1="Burkina Faso";  $country_2="BF"; $country_3="BFA";
	}elseif($country=="Burundi" || $country=="BI" || $country=="BDI"){
	 $country_1="Burundi";  $country_2="BI"; $country_3="BDI";
	}elseif($country=="Cambodia" || $country=="KH" || $country=="KHM"){
	 $country_1="Cambodia";  $country_2="KH"; $country_3="KHM";
	}elseif($country=="Cameroon" || $country=="CM" || $country=="CMR"){
	 $country_1="Cameroon";  $country_2="CM"; $country_3="CMR";
	}elseif($country=="Canada" || $country=="CA" || $country=="CAN"){
	 $country_1="Canada";  $country_2="CA"; $country_3="CAN";
	}elseif($country=="Cape Verde" || $country=="CV" || $country=="CPV"){
	 $country_1="Cape Verde";  $country_2="CV"; $country_3="CPV";
	}elseif($country=="Cayman Islands" || $country=="KY" || $country=="CYM"){
	 $country_1="Cayman Islands";  $country_2="KY"; $country_3="CYM";
	}elseif($country=="Central African Republic" || $country=="CF" || $country=="CAF"){
	 $country_1="Central African Republic";  $country_2="CF"; $country_3="CAF";
	}elseif($country=="Chad" || $country=="TD" || $country=="TCD"){
	 $country_1="Chad";  $country_2="TD"; $country_3="TCD";
	}elseif($country=="Chile" || $country=="CL" || $country=="CHL"){
	 $country_1="Chile";  $country_2="CL"; $country_3="CHL";
	}elseif($country=="China" || $country=="CN" || $country=="CHN"){
	 $country_1="China";  $country_2="CN"; $country_3="CHN";
	}elseif($country=="Christmas Island" || $country=="CX" || $country=="CXR"){
	 $country_1="Christmas Island";  $country_2="CX"; $country_3="CXR";
	}elseif($country=="Cocos (keeling) Islands" || $country=="CC" || $country=="CCK"){
	 $country_1="Cocos (Keeling) Islands";  $country_2="CC"; $country_3="CCK";
	}elseif($country=="Colombia" || $country=="CO" || $country=="COL"){
	 $country_1="Colombia";  $country_2="CO"; $country_3="COL";
	}elseif($country=="Comoros" || $country=="KM" || $country=="COM"){
	 $country_1="Comoros";  $country_2="KM"; $country_3="COM";
	}elseif($country=="Congo (brazzaville)" || $country=="CG" || $country=="COG"){
	 $country_1="Congo (Brazzaville)";  $country_2="CG"; $country_3="COG";
	}elseif($country=="Congo, (kinshasa)" || $country=="CD" || $country=="COD"){
	 $country_1="Congo, (Kinshasa)";  $country_2="CD"; $country_3="COD";
	}elseif($country=="Cook Islands" || $country=="CK" || $country=="COK"){
	 $country_1="Cook Islands";  $country_2="CK"; $country_3="COK";
	}elseif($country=="Costa Rica" || $country=="CR" || $country=="CRI"){
	 $country_1="Costa Rica";  $country_2="CR"; $country_3="CRI";
	}elseif($country=="Cote D'ivoire" || $country=="Côte D'ivoire" || $country=="CI" || $country=="CIV"){
	 $country_1="Cote d'Ivoire";  $country_2="CI"; $country_3="CIV";
	}elseif($country=="Croatia" || $country=="HR" || $country=="HRV"){
	 $country_1="Croatia";  $country_2="HR"; $country_3="HRV";
	}elseif($country=="Cuba" || $country=="CU" || $country=="CUB"){
	 $country_1="Cuba";  $country_2="CU"; $country_3="CUB";
	}elseif($country=="Cyprus" || $country=="CY" || $country=="CYP"){
	 $country_1="Cyprus";  $country_2="CY"; $country_3="CYP";
	}elseif($country=="Czech Republic" || $country=="CZ" || $country=="CZE"){
	 $country_1="Czech Republic";  $country_2="CZ"; $country_3="CZE";
	}elseif($country=="Denmark" || $country=="DK" || $country=="DNK"){
	 $country_1="Denmark";  $country_2="DK"; $country_3="DNK";
	}elseif($country=="Djibouti" || $country=="DJ" || $country=="DJI"){
	 $country_1="Djibouti";  $country_2="DJ"; $country_3="DJI";
	}elseif($country=="Dominica" || $country=="DM" || $country=="DMA"){
	 $country_1="Dominica";  $country_2="DM"; $country_3="DMA";
	}elseif($country=="Dominican Republic" || $country=="DO" || $country=="DOM"){
	 $country_1="Dominican Republic";  $country_2="DO"; $country_3="DOM";
	}elseif($country=="Ecuador" || $country=="EC" || $country=="ECU"){
	 $country_1="Ecuador";  $country_2="EC"; $country_3="ECU";
	}elseif($country=="Egypt" || $country=="EG" || $country=="EGY"){
	 $country_1="Egypt";  $country_2="EG"; $country_3="EGY";
	}elseif($country=="El Salvador" || $country=="SV" || $country=="SLV"){
	 $country_1="El Salvador";  $country_2="SV"; $country_3="SLV";
	}elseif($country=="Equatorial Guinea" || $country=="GQ" || $country=="GNQ"){
	 $country_1="Equatorial Guinea";  $country_2="GQ"; $country_3="GNQ";
	}elseif($country=="Eritrea" || $country=="ER" || $country=="ERI"){
	 $country_1="Eritrea";  $country_2="ER"; $country_3="ERI";
	}elseif($country=="Estonia" || $country=="EE" || $country=="EST"){
	 $country_1="Estonia";  $country_2="EE"; $country_3="EST";
	}elseif($country=="Ethiopia" || $country=="ET" || $country=="ETH"){
	 $country_1="Ethiopia";  $country_2="ET"; $country_3="ETH";
	}elseif($country=="Falkland Islands (malvinas)" || $country=="FK" || $country=="FLK"){
	 $country_1="Falkland Islands (Malvinas)";  $country_2="FK"; $country_3="FLK";
	}elseif($country=="Faroe Islands" || $country=="FO" || $country=="FRO"){
	 $country_1="Faroe Islands";  $country_2="FO"; $country_3="FRO";
	}elseif($country=="Fiji" || $country=="FJ" || $country=="FJI"){
	 $country_1="Fiji";  $country_2="FJ"; $country_3="FJI";
	}elseif($country=="Finland" || $country=="FI" || $country=="FIN"){
	 $country_1="Finland";  $country_2="FI"; $country_3="FIN";
	}elseif($country=="France" || $country=="FR" || $country=="FRA"){
	 $country_1="France";  $country_2="FR"; $country_3="FRA";
	}elseif($country=="French Guiana" || $country=="GF" || $country=="GUF"){
	 $country_1="French Guiana";  $country_2="GF"; $country_3="GUF";
	}elseif($country=="French Polynesia" || $country=="PF" || $country=="PYF"){
	 $country_1="French Polynesia";  $country_2="PF"; $country_3="PYF";
	}elseif($country=="French Southern Territories" || $country=="TF" || $country=="ATF"){
	 $country_1="French Southern Territories";  $country_2="TF"; $country_3="ATF";
	}elseif($country=="Gabon" || $country=="GA" || $country=="GAB"){
	 $country_1="Gabon";  $country_2="GA"; $country_3="GAB";
	}elseif($country=="Gambia" || $country=="GM" || $country=="GMB"){
	 $country_1="Gambia";  $country_2="GM"; $country_3="GMB";
	}elseif($country=="Georgia" || $country=="GE" || $country=="GEO"){
	 $country_1="Georgia";  $country_2="GE"; $country_3="GEO";
	}elseif($country=="Germany" || $country=="DE" || $country=="DEU"){
	 $country_1="Germany";  $country_2="DE"; $country_3="DEU";
	}elseif($country=="Ghana" || $country=="GH" || $country=="GHA"){
	 $country_1="Ghana";  $country_2="GH"; $country_3="GHA";
	}elseif($country=="Gibraltar" || $country=="GI" || $country=="GIB"){
	 $country_1="Gibraltar";  $country_2="GI"; $country_3="GIB";
	}elseif($country=="Greece" || $country=="GR" || $country=="GRC"){
	 $country_1="Greece";  $country_2="GR"; $country_3="GRC";
	}elseif($country=="Greenland" || $country=="GL" || $country=="GRL"){
	 $country_1="Greenland";  $country_2="GL"; $country_3="GRL";
	}elseif($country=="Grenada" || $country=="GD" || $country=="GRD"){
	 $country_1="Grenada";  $country_2="GD"; $country_3="GRD";
	}elseif($country=="Guadeloupe" || $country=="GP" || $country=="GLP"){
	 $country_1="Guadeloupe";  $country_2="GP"; $country_3="GLP";
	}elseif($country=="Guam" || $country=="GU" || $country=="GUM"){
	 $country_1="Guam";  $country_2="GU"; $country_3="GUM";
	}elseif($country=="Guatemala" || $country=="GT" || $country=="GTM"){
	 $country_1="Guatemala";  $country_2="GT"; $country_3="GTM";
	}elseif($country=="Guernsey" || $country=="GG" || $country=="GGY"){
	 $country_1="Guernsey";  $country_2="GG"; $country_3="GGY";
	}elseif($country=="Guinea" || $country=="GN" || $country=="GIN"){
	 $country_1="Guinea";  $country_2="GN"; $country_3="GIN";
	}elseif($country=="Guinea-bissau" || $country=="GW" || $country=="GNB"){
	 $country_1="Guinea-Bissau";  $country_2="GW"; $country_3="GNB";
	}elseif($country=="Guyana" || $country=="GY" || $country=="GUY"){
	 $country_1="Guyana";  $country_2="GY"; $country_3="GUY";
	}elseif($country=="Haiti" || $country=="HT" || $country=="HTI"){
	 $country_1="Haiti";  $country_2="HT"; $country_3="HTI";
	}elseif($country=="Heard And Mcdonald Islands" || $country=="HM" || $country=="HMD"){
	 $country_1="Heard And Mcdonald Islands";  $country_2="HM"; $country_3="HMD";
	}elseif($country=="Holy See (vatican City State)" || $country=="VA" || $country=="VAT"){
	 $country_1="Holy See (vatican City State)";  $country_2="VA"; $country_3="VAT";
	}elseif($country=="Honduras" || $country=="HN" || $country=="HND"){
	 $country_1="Honduras";  $country_2="HN"; $country_3="HND";
	}elseif($country=="Hong Kong, Sar China" || $country=="HK" || $country=="HKG"){
	 $country_1="Hong Kong, SAR China";  $country_2="HK"; $country_3="HKG";
	}elseif($country=="Hungary" || $country=="HU" || $country=="HUN"){
	 $country_1="Hungary";  $country_2="HU"; $country_3="HUN";
	}elseif($country=="Iceland" || $country=="IS" || $country=="ISL"){
	 $country_1="Iceland";  $country_2="IS"; $country_3="ISL";
	}elseif($country=="India" || $country=="IN" || $country=="IND"){
	 $country_1="India";  $country_2="IN"; $country_3="IND";
	}elseif($country=="Indonesia" || $country=="ID" || $country=="IDN"){
	 $country_1="Indonesia";  $country_2="ID"; $country_3="IDN";
	}elseif($country=="Iran, Islamic Republic Of" || $country=="IR" || $country=="IRN"){
	 $country_1="Iran, Islamic Republic of";  $country_2="IR"; $country_3="IRN";
	}elseif($country=="Iraq" || $country=="IQ" || $country=="IRQ"){
	 $country_1="Iraq";  $country_2="IQ"; $country_3="IRQ";
	}elseif($country=="Ireland" || $country=="IE" || $country=="IRL"){
	 $country_1="Ireland";  $country_2="IE"; $country_3="IRL";
	}elseif($country=="Isle Of Man" || $country=="IM" || $country=="IMN"){
	 $country_1="Isle Of Man";  $country_2="IM"; $country_3="IMN";
	}elseif($country=="Israel" || $country=="IL" || $country=="ISR"){
	 $country_1="Israel";  $country_2="IL"; $country_3="ISR";
	}elseif($country=="Italy" || $country=="IT" || $country=="ITA"){
	 $country_1="Italy";  $country_2="IT"; $country_3="ITA";
	}elseif($country=="Jamaica" || $country=="JM" || $country=="JAM"){
	 $country_1="Jamaica";  $country_2="JM"; $country_3="JAM";
	}elseif($country=="Japan" || $country=="JP" || $country=="JPN"){
	 $country_1="Japan";  $country_2="JP"; $country_3="JPN";
	}elseif($country=="Jersey" || $country=="JE" || $country=="JEY"){
	 $country_1="Jersey";  $country_2="JE"; $country_3="JEY";
	}elseif($country=="Jordan" || $country=="JO" || $country=="JOR"){
	 $country_1="Jordan";  $country_2="JO"; $country_3="JOR";
	}elseif($country=="Kazakhstan" || $country=="KZ" || $country=="KAZ"){
	 $country_1="Kazakhstan";  $country_2="KZ"; $country_3="KAZ";
	}elseif($country=="Kenya" || $country=="KE" || $country=="KEN"){
	 $country_1="Kenya";  $country_2="KE"; $country_3="KEN";
	}elseif($country=="Kiribati" || $country=="KI" || $country=="KIR"){
	 $country_1="Kiribati";  $country_2="KI"; $country_3="KIR";
	}elseif($country=="Korea (north)" || $country=="KP" || $country=="PRK"){
	 $country_1="Korea (North)";  $country_2="KP"; $country_3="PRK";
	}elseif($country=="Korea (south)" || $country=="KR" || $country=="KOR"){
	 $country_1="Korea (South)";  $country_2="KR"; $country_3="KOR";
	}elseif($country=="Kuwait" || $country=="KW" || $country=="KWT"){
	 $country_1="Kuwait";  $country_2="KW"; $country_3="KWT";
	}elseif($country=="Kyrgyzstan" || $country=="KG" || $country=="KGZ"){
	 $country_1="Kyrgyzstan";  $country_2="KG"; $country_3="KGZ";
	}elseif($country=="Lao PDR" || $country=="LA" || $country=="LAO"){
	 $country_1="Lao PDR";  $country_2="LA"; $country_3="LAO";
	}elseif($country=="Latvia" || $country=="LV" || $country=="LVA"){
	 $country_1="Latvia";  $country_2="LV"; $country_3="LVA";
	}elseif($country=="Lebanon" || $country=="LB" || $country=="LBN"){
	 $country_1="Lebanon";  $country_2="LB"; $country_3="LBN";
	}elseif($country=="Lesotho" || $country=="LS" || $country=="LSO"){
	 $country_1="Lesotho";  $country_2="LS"; $country_3="LSO";
	}elseif($country=="Liberia" || $country=="LR" || $country=="LBR"){
	 $country_1="Liberia";  $country_2="LR"; $country_3="LBR";
	}elseif($country=="Libya" || $country=="LY" || $country=="LBY"){
	 $country_1="Libya";  $country_2="LY"; $country_3="LBY";
	}elseif($country=="Liechtenstein" || $country=="LI" || $country=="LIE"){
	 $country_1="Liechtenstein";  $country_2="LI"; $country_3="LIE";
	}elseif($country=="Lithuania" || $country=="LT" || $country=="LTU"){
	 $country_1="Lithuania";  $country_2="LT"; $country_3="LTU";
	}elseif($country=="Luxembourg" || $country=="LU" || $country=="LUX"){
	 $country_1="Luxembourg";  $country_2="LU"; $country_3="LUX";
	}elseif($country=="Macao, SAR China" || $country=="MO" || $country=="MAC"){
	 $country_1="Macao, SAR China";  $country_2="MO"; $country_3="MAC";
	}elseif($country=="Macedonia, Republic Of" || $country=="MK" || $country=="MKD"){
	 $country_1="Macedonia, Republic of";  $country_2="MK"; $country_3="MKD";
	}elseif($country=="Madagascar" || $country=="MG" || $country=="MDG"){
	 $country_1="Madagascar";  $country_2="MG"; $country_3="MDG";
	}elseif($country=="Malawi" || $country=="MW" || $country=="MWI"){
	 $country_1="Malawi";  $country_2="MW"; $country_3="MWI";
	}elseif($country=="Malaysia" || $country=="MY" || $country=="MYS"){
	 $country_1="Malaysia";  $country_2="MY"; $country_3="MYS";
	}elseif($country=="Maldives" || $country=="MV" || $country=="MDV"){
	 $country_1="Maldives";  $country_2="MV"; $country_3="MDV";
	}elseif($country=="Mali" || $country=="ML" || $country=="MLI"){
	 $country_1="Mali";  $country_2="ML"; $country_3="MLI";
	}elseif($country=="Malta" || $country=="MT" || $country=="MLT"){
	 $country_1="Malta";  $country_2="MT"; $country_3="MLT";
	}elseif($country=="Marshall Islands" || $country=="MH" || $country=="MHL"){
	 $country_1="Marshall Islands";  $country_2="MH"; $country_3="MHL";
	}elseif($country=="Martinique" || $country=="MQ" || $country=="MTQ"){
	 $country_1="Martinique";  $country_2="MQ"; $country_3="MTQ";
	}elseif($country=="Mauritania" || $country=="MR" || $country=="MRT"){
	 $country_1="Mauritania";  $country_2="MR"; $country_3="MRT";
	}elseif($country=="Mauritius" || $country=="MU" || $country=="MUS"){
	 $country_1="Mauritius";  $country_2="MU"; $country_3="MUS";
	}elseif($country=="Mayotte" || $country=="YT" || $country=="MYT"){
	 $country_1="Mayotte";  $country_2="YT"; $country_3="MYT";
	}elseif($country=="Mexico" || $country=="MX" || $country=="MEX"){
	 $country_1="Mexico";  $country_2="MX"; $country_3="MEX";
	}elseif($country=="Micronesia, Federated States Of" || $country=="FM" || $country=="FSM"){
	 $country_1="Micronesia, Federated States of";  $country_2="FM"; $country_3="FSM";
	}elseif($country=="Moldova" || $country=="MD" || $country=="MDA"){
	 $country_1="Moldova";  $country_2="MD"; $country_3="MDA";
	}elseif($country=="Monaco" || $country=="MC" || $country=="MCO"){
	 $country_1="Monaco";  $country_2="MC"; $country_3="MCO";
	}elseif($country=="Mongolia" || $country=="MN" || $country=="MNG"){
	 $country_1="Mongolia";  $country_2="MN"; $country_3="MNG";
	}elseif($country=="Montenegro" || $country=="ME" || $country=="MNE"){
	 $country_1="Montenegro";  $country_2="ME"; $country_3="MNE";
	}elseif($country=="Montserrat" || $country=="MS" || $country=="MSR"){
	 $country_1="Montserrat";  $country_2="MS"; $country_3="MSR";
	}elseif($country=="Morocco" || $country=="MA" || $country=="MAR"){
	 $country_1="Morocco";  $country_2="MA"; $country_3="MAR";
	}elseif($country=="Mozambique" || $country=="MZ" || $country=="MOZ"){
	 $country_1="Mozambique";  $country_2="MZ"; $country_3="MOZ";
	}elseif($country=="Myanmar" || $country=="MM" || $country=="MMR"){
	 $country_1="Myanmar";  $country_2="MM"; $country_3="MMR";
	}elseif($country=="Namibia" || $country=="NA" || $country=="NAM"){
	 $country_1="Namibia";  $country_2="NA"; $country_3="NAM";
	}elseif($country=="Nauru" || $country=="NR" || $country=="NRU"){
	 $country_1="Nauru";  $country_2="NR"; $country_3="NRU";
	}elseif($country=="Nepal" || $country=="NP" || $country=="NPL"){
	 $country_1="Nepal";  $country_2="NP"; $country_3="NPL";
	}elseif($country=="Netherlands" || $country=="NL" || $country=="NLD"){
	 $country_1="Netherlands";  $country_2="NL"; $country_3="NLD";
	}elseif($country=="Netherlands Antilles" || $country=="AN" || $country=="ANT"){
	 $country_1="Netherlands Antilles";  $country_2="AN"; $country_3="ANT";
	}elseif($country=="New Caledonia" || $country=="NC" || $country=="NCL"){
	 $country_1="New Caledonia";  $country_2="NC"; $country_3="NCL";
	}elseif($country=="New Zealand" || $country=="NZ" || $country=="NZL"){
	 $country_1="New Zealand";  $country_2="NZ"; $country_3="NZL";
	}elseif($country=="Nicaragua" || $country=="NI" || $country=="NIC"){
	 $country_1="Nicaragua";  $country_2="NI"; $country_3="NIC";
	}elseif($country=="Niger" || $country=="NE" || $country=="NER"){
	 $country_1="Niger";  $country_2="NE"; $country_3="NER";
	}elseif($country=="Nigeria" || $country=="NG" || $country=="NGA"){
	 $country_1="Nigeria";  $country_2="NG"; $country_3="NGA";
	}elseif($country=="Niue" || $country=="NU" || $country=="NIU"){
	 $country_1="Niue";  $country_2="NU"; $country_3="NIU";
	}elseif($country=="Norfolk Island" || $country=="NF" || $country=="NFK"){
	 $country_1="Norfolk Island";  $country_2="NF"; $country_3="NFK";
	}elseif($country=="Northern Mariana Islands" || $country=="MP" || $country=="MNP"){
	 $country_1="Northern Mariana Islands";  $country_2="MP"; $country_3="MNP";
	}elseif($country=="Norway" || $country=="NO" || $country=="NOR"){
	 $country_1="Norway";  $country_2="NO"; $country_3="NOR";
	}elseif($country=="Oman" || $country=="OM" || $country=="OMN"){
	 $country_1="Oman";  $country_2="OM"; $country_3="OMN";
	}elseif($country=="Pakistan" || $country=="PK" || $country=="PAK"){
	 $country_1="Pakistan";  $country_2="PK"; $country_3="PAK";
	}elseif($country=="Palau" || $country=="PW" || $country=="PLW"){
	 $country_1="Palau";  $country_2="PW"; $country_3="PLW";
	}elseif($country=="Palestinian Territory" || $country=="PS" || $country=="PSE"){
	 $country_1="Palestinian Territory";  $country_2="PS"; $country_3="PSE";
	}elseif($country=="Panama" || $country=="PA" || $country=="PAN"){
	 $country_1="Panama";  $country_2="PA"; $country_3="PAN";
	}elseif($country=="Papua New Guinea" || $country=="PG" || $country=="PNG"){
	 $country_1="Papua New Guinea";  $country_2="PG"; $country_3="PNG";
	}elseif($country=="Paraguay" || $country=="PY" || $country=="PRY"){
	 $country_1="Paraguay";  $country_2="PY"; $country_3="PRY";
	}elseif($country=="Peru" || $country=="PE" || $country=="PER"){
	 $country_1="Peru";  $country_2="PE"; $country_3="PER";
	}elseif($country=="Philippines" || $country=="PH" || $country=="PHL"){
	 $country_1="Philippines";  $country_2="PH"; $country_3="PHL";
	}elseif($country=="Pitcairn" || $country=="PN" || $country=="PCN"){
	 $country_1="Pitcairn";  $country_2="PN"; $country_3="PCN";
	}elseif($country=="Poland" || $country=="PL" || $country=="POL"){
	 $country_1="Poland";  $country_2="PL"; $country_3="POL";
	}elseif($country=="Portugal" || $country=="PT" || $country=="PRT"){
	 $country_1="Portugal";  $country_2="PT"; $country_3="PRT";
	}elseif($country=="Puerto Rico" || $country=="PR" || $country=="PRI"){
	 $country_1="Puerto Rico";  $country_2="PR"; $country_3="PRI";
	}elseif($country=="Qatar" || $country=="QA" || $country=="QAT"){
	 $country_1="Qatar";  $country_2="QA"; $country_3="QAT";
	}elseif($country=="Réunion" || $country=="RE" || $country=="REU"){
	 $country_1="Réunion";  $country_2="RE"; $country_3="REU";
	}elseif($country=="Romania" || $country=="RO" || $country=="ROU"){
	 $country_1="Romania";  $country_2="RO"; $country_3="ROU";
	}elseif($country=="Russian Federation" || $country=="RU" || $country=="RUS"){
	 $country_1="Russian Federation";  $country_2="RU"; $country_3="RUS";
	}elseif($country=="Rwanda" || $country=="RW" || $country=="RWA"){
	 $country_1="Rwanda";  $country_2="RW"; $country_3="RWA";
	}elseif($country=="Saint Helena" || $country=="SH" || $country=="SHN"){
	 $country_1="Saint Helena";  $country_2="SH"; $country_3="SHN";
	}elseif($country=="Saint Kitts And Nevis" || $country=="KN" || $country=="KNA"){
	 $country_1="Saint Kitts And Nevis";  $country_2="KN"; $country_3="KNA";
	}elseif($country=="Saint Lucia" || $country=="LC" || $country=="LCA"){
	 $country_1="Saint Lucia";  $country_2="LC"; $country_3="LCA";
	}elseif($country=="Saint Pierre And Miquelon" || $country=="PM" || $country=="SPM"){
	 $country_1="Saint Pierre And Miquelon";  $country_2="PM"; $country_3="SPM";
	}elseif($country=="Saint Vincent And Grenadines" || $country=="VC" || $country=="VCT"){
	 $country_1="Saint Vincent And Grenadines";  $country_2="VC"; $country_3="VCT";
	}elseif($country=="Saint-Barthélemy" || $country=="BL" || $country=="BLM"){
	 $country_1="Saint-Barthélemy";  $country_2="BL"; $country_3="BLM";
	}elseif($country=="Saint-Martin (french part)" || $country=="MF" || $country=="MAF"){
	 $country_1="Saint-Martin (French part)";  $country_2="MF"; $country_3="MAF";
	}elseif($country=="Samoa" || $country=="WS" || $country=="WSM"){
	 $country_1="Samoa";  $country_2="WS"; $country_3="WSM";
	}elseif($country=="San Marino" || $country=="SM" || $country=="SMR"){
	 $country_1="San Marino";  $country_2="SM"; $country_3="SMR";
	}elseif($country=="Sao Tome And Principe" || $country=="ST" || $country=="STP"){
	 $country_1="Sao Tome And Principe";  $country_2="ST"; $country_3="STP";
	}elseif($country=="Saudi Arabia" || $country=="SA" || $country=="SAU"){
	 $country_1="Saudi Arabia";  $country_2="SA"; $country_3="SAU";
	}elseif($country=="Senegal" || $country=="SN" || $country=="SEN"){
	 $country_1="Senegal";  $country_2="SN"; $country_3="SEN";
	}elseif($country=="Serbia" || $country=="RS" || $country=="SRB"){
	 $country_1="Serbia";  $country_2="RS"; $country_3="SRB";
	}elseif($country=="Seychelles" || $country=="SC" || $country=="SYC"){
	 $country_1="Seychelles";  $country_2="SC"; $country_3="SYC";
	}elseif($country=="Sierra Leone" || $country=="SL" || $country=="SLE"){
	 $country_1="Sierra Leone";  $country_2="SL"; $country_3="SLE";
	}elseif($country=="Singapore" || $country=="SG" || $country=="SGP"){
	 $country_1="Singapore";  $country_2="SG"; $country_3="SGP";
	}elseif($country=="Slovakia" || $country=="SK" || $country=="SVK"){
	 $country_1="Slovakia";  $country_2="SK"; $country_3="SVK";
	}elseif($country=="Slovenia" || $country=="SI" || $country=="SVN"){
	 $country_1="Slovenia";  $country_2="SI"; $country_3="SVN";
	}elseif($country=="Solomon Islands" || $country=="SB" || $country=="SLB"){
	 $country_1="Solomon Islands";  $country_2="SB"; $country_3="SLB";
	}elseif($country=="Somalia" || $country=="SO" || $country=="SOM"){
	 $country_1="Somalia";  $country_2="SO"; $country_3="SOM";
	}elseif($country=="South Africa" || $country=="ZA" || $country=="ZAF"){
	 $country_1="South Africa";  $country_2="ZA"; $country_3="ZAF";
	}elseif($country=="South Georgia And the South Sandwich Islands" || $country=="GS" || $country=="SGS"){
	 $country_1="South Georgia And the South Sandwich Islands";  $country_2="GS"; $country_3="SGS";
	}elseif($country=="South Sudan" || $country=="SS" || $country=="SSD"){
	 $country_1="South Sudan";  $country_2="SS"; $country_3="SSD";
	}elseif($country=="Spain" || $country=="ES" || $country=="ESP"){
	 $country_1="Spain";  $country_2="ES"; $country_3="ESP";
	}elseif($country=="Sri Lanka" || $country=="LK" || $country=="LKA"){
	 $country_1="Sri Lanka";  $country_2="LK"; $country_3="LKA";
	}elseif($country=="Sudan" || $country=="SD" || $country=="SDN"){
	 $country_1="Sudan";  $country_2="SD"; $country_3="SDN";
	}elseif($country=="Suriname" || $country=="SR" || $country=="SUR"){
	 $country_1="Suriname";  $country_2="SR"; $country_3="SUR";
	}elseif($country=="Svalbard And Jan Mayen Islands" || $country=="SJ" || $country=="SJM"){
	 $country_1="Svalbard And Jan Mayen Islands";  $country_2="SJ"; $country_3="SJM";
	}elseif($country=="Swaziland" || $country=="SZ" || $country=="SWZ"){
	 $country_1="Swaziland";  $country_2="SZ"; $country_3="SWZ";
	}elseif($country=="Sweden" || $country=="SE" || $country=="SWE"){
	 $country_1="Sweden";  $country_2="SE"; $country_3="SWE";
	}elseif($country=="Switzerland" || $country=="CH" || $country=="CHE"){
	 $country_1="Switzerland";  $country_2="CH"; $country_3="CHE";
	}elseif($country=="Syrian Arab Republic (syria)" || $country=="SY" || $country=="SYR"){
	 $country_1="Syrian Arab Republic (Syria)";  $country_2="SY"; $country_3="SYR";
	}elseif($country=="Taiwan, Republic Of China" || $country=="TW" || $country=="TWN"){
	 $country_1="Taiwan, Republic Of China";  $country_2="TW"; $country_3="TWN";
	}elseif($country=="Tajikistan" || $country=="TJ" || $country=="TJK"){
	 $country_1="Tajikistan";  $country_2="TJ"; $country_3="TJK";
	}elseif($country=="Tanzania, United Republic Of" || $country=="TZ" || $country=="TZA"){
	 $country_1="Tanzania, United Republic Of";  $country_2="TZ"; $country_3="TZA";
	}elseif($country=="Thailand" || $country=="TH" || $country=="THA"){
	 $country_1="Thailand";  $country_2="TH"; $country_3="THA";
	}elseif($country=="Timor-Leste" || $country=="TL" || $country=="TLS"){
	 $country_1="Timor-Leste";  $country_2="TL"; $country_3="TLS";
	}elseif($country=="Togo" || $country=="TG" || $country=="TGO"){
	 $country_1="Togo";  $country_2="TG"; $country_3="TGO";
	}elseif($country=="Tokelau" || $country=="TK" || $country=="TKL"){
	 $country_1="Tokelau";  $country_2="TK"; $country_3="TKL";
	}elseif($country=="Tonga" || $country=="TO" || $country=="TON"){
	 $country_1="Tonga";  $country_2="TO"; $country_3="TON";
	}elseif($country=="Trinidad And Tobago" || $country=="TT" || $country=="TTO"){
	 $country_1="Trinidad And Tobago";  $country_2="TT"; $country_3="TTO";
	}elseif($country=="Tunisia" || $country=="TN" || $country=="TUN"){
	 $country_1="Tunisia";  $country_2="TN"; $country_3="TUN";
	}elseif($country=="Turkey" || $country=="TR" || $country=="TUR"){
	 $country_1="Turkey";  $country_2="TR"; $country_3="TUR";
	}elseif($country=="Turkmenistan" || $country=="TM" || $country=="TKM"){
	 $country_1="Turkmenistan";  $country_2="TM"; $country_3="TKM";
	}elseif($country=="Turks And Caicos Islands" || $country=="TC" || $country=="TCA"){
	 $country_1="Turks And Caicos Islands";  $country_2="TC"; $country_3="TCA";
	}elseif($country=="Tuvalu" || $country=="TV" || $country=="TUV"){
	 $country_1="Tuvalu";  $country_2="TV"; $country_3="TUV";
	}elseif($country=="Uganda" || $country=="UG" || $country=="UGA"){
	 $country_1="Uganda";  $country_2="UG"; $country_3="UGA";
	}elseif($country=="Ukraine" || $country=="UA" || $country=="UKR"){
	 $country_1="Ukraine";  $country_2="UA"; $country_3="UKR";
	}elseif($country=="United Arab Emirates" || $country=="AE" || $country=="ARE"){
	 $country_1="United Arab Emirates";  $country_2="AE"; $country_3="ARE";
	}elseif($country=="United Kingdom" || $country=="GB" || $country=="GBR"){
	 $country_1="United Kingdom";  $country_2="GB"; $country_3="GBR";
	}elseif($country=="United States Of America" || $country=="US" || $country=="USA"){
	 $country_1="United States Of America";  $country_2="US"; $country_3="USA";
	}elseif($country=="Uruguay" || $country=="UY" || $country=="URY"){
	 $country_1="Uruguay";  $country_2="UY"; $country_3="URY";
	}elseif($country=="US Minor Outlying Islands" || $country=="UM" || $country=="UMI"){
	 $country_1="US Minor Outlying Islands";  $country_2="UM"; $country_3="UMI";
	}elseif($country=="Uzbekistan" || $country=="UZ" || $country=="UZB"){
	 $country_1="Uzbekistan";  $country_2="UZ"; $country_3="UZB";
	}elseif($country=="Vanuatu" || $country=="VU" || $country=="VUT"){
	 $country_1="Vanuatu";  $country_2="VU"; $country_3="VUT";
	}elseif($country=="Venezuela (bolivarian Republic)" || $country=="VE" || $country=="VEN"){
	 $country_1="Venezuela (Bolivarian Republic)";  $country_2="VE"; $country_3="VEN";
	}elseif($country=="Viet Nam" || $country=="VN" || $country=="VNM"){
	 $country_1="Viet Nam";  $country_2="VN"; $country_3="VNM";
	}elseif($country=="Virgin Islands, US" || $country=="VI" || $country=="VIR"){
	 $country_1="Virgin Islands, US";  $country_2="VI"; $country_3="VIR";
	}elseif($country=="Wallis And Futuna Islands" || $country=="WF" || $country=="WLF"){
	 $country_1="Wallis And Futuna Islands";  $country_2="WF"; $country_3="WLF";
	}elseif($country=="Western Sahara" || $country=="EH" || $country=="ESH"){
	 $country_1="Western Sahara";  $country_2="EH"; $country_3="ESH";
	}elseif($country=="Yemen" || $country=="YE" || $country=="YEM"){
	 $country_1="Yemen";  $country_2="YE"; $country_3="YEM";
	}elseif($country=="Zambia" || $country=="ZM" || $country=="ZMB"){
	 $country_1="Zambia";  $country_2="ZM"; $country_3="ZMB";
	}elseif($country=="Zimbabwe" || $country=="ZW" || $country=="ZWE"){
	 $country_1="Zimbabwe";  $country_2="ZW"; $country_3="ZWE";
	}
	$result_st=$country_2;
	if($names==2){
		$result_st=$country_2;
	}elseif($names==1){
		$result_st=$country_1;
	}elseif($names==3){
		$result_st=$country_3;
	}
	//return $result_st." = ".$country;
	return $result_st;
}
/*
echo "<br/>".get_country_code("Andorra");
echo "<br/>".get_country_code("Hong Kong, SAR China");
echo "<br/>".get_country_code("Holy See (Vatican City State)");
echo "<br/>".get_country_code("Falkland Islands (Malvinas)");
echo "<br/>".get_country_code("cote d'ivoire");
echo "<br/>".get_country_code("Guinea-Bissau");
echo "<br/>".get_country_code("Congo, (Kinshasa)");
echo "<br/>".get_country_code("Micronesia, Federated States Of");
*/