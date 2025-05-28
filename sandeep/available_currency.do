<?
$data['AVAILABLE_CURRENCY']=array("AUD","BTC","CAD","CNY","CZK","EUR","GBP","HKD","IDR","INR","JPY","KHR","MXN","MYR","PHP","PLN","SGD","THB","USD","VND");

$data['AVAILABLE_CURRENCY_MEANING']=array("AUD"=>"Australia Dollar","BTC"=>"Bitcoin","CAD"=>"Canadian Dollar","CNY"=>"Chinese Yuan","CZK"=>"Czech koruna","EUR"=>"Euro","GBP"=>"United Kingdom Pound","HKD"=>"Hong Kong Dollar","IDR"=>"Indonesian Rupiah","INR"=>"Indian Rupee","JPY"=>"Japanese Yen","KHR"=>"Cambodian riel","MXN"=>"Mexican Peso","MYR"=>"Malaysian Ringgit","PHP"=>"Philippine peso","PLN"=>"Polish złoty","SGD"=>"SG Dollar","THB"=>"Thai baht","USD"=>"United States Dollar","VND"=>"Vietnamese dong");

function get_currency($currency,$names=0){
	$currency_name="";  $currency_symble="";
	if($currency){
		if(strpos($currency," ")!==false){
			$curr_ex=explode(" ",$currency); 
			$currency_name=$curr_ex[1];
		}else{
			$currency_name=$currency;
		}
	}
	if($currency=="USD"|| $currency=="$"){
		$currency_name="USD";  $currency_symble="$"; 
	}elseif($currency=="EUR"|| $currency=="€"){
		$currency_name="EUR";  $currency_symble="€"; 
	}elseif($currency=="INR"|| $currency=="₹"){
		$currency_name="INR";  $currency_symble="₹"; 
	}elseif($currency=="AUD"|| $currency=="A$"){
		$currency_name="AUD";  $currency_symble="A$"; 
	}elseif($currency=="CAD"|| $currency=="C$"){
		$currency_name="CAD";  $currency_symble="C$"; 
	}elseif($currency=="CNY"|| $currency=="¥"){
		$currency_name="CNY";  $currency_symble="¥"; 
	}elseif($currency=="GBP"|| $currency=="£"){
		$currency_name="GBP";  $currency_symble="£"; 
	}elseif($currency=="HKD"|| $currency=="HK$"){
		$currency_name="HKD";  $currency_symble="HK$"; 
	}elseif($currency=="IDR"|| $currency=="Rp"){
		$currency_name="IDR";  $currency_symble="Rp"; 
	}elseif($currency=="JPY"|| $currency=="¥"){
		$currency_name="JPY";  $currency_symble="¥"; 
	}elseif($currency=="MYR"|| $currency=="RM"){
		$currency_name="MYR";  $currency_symble="RM"; 
	}elseif($currency=="MXN"|| $currency=="M$"){
		$currency_name="MXN";  $currency_symble="M$"; 
	}elseif($currency=="SGD"|| $currency=="S$"){
		$currency_name="SGD";  $currency_symble="S$"; 
	}elseif($currency=="BTC"|| $currency=="₿"|| $currency=="u20bf"){
		$currency_name="BTC";  $currency_symble="₿"; 
	}
	elseif($currency=="CZK"|| $currency=="Kč"){
		$currency_name="CZK";  $currency_symble="Kč"; 
	}
	elseif($currency=="PLN"|| $currency=="zł"){
		$currency_name="PLN";  $currency_symble="zł"; 
	}
	elseif($currency=="RUB"|| $currency=="₽"){
		$currency_name="RUB";  $currency_symble="₽"; 
	}
	elseif($currency=="AED"|| $currency=="د.إ"){
		$currency_name="AED";  $currency_symble="د.إ"; 
	}
	elseif($currency=="AFN"|| $currency=="؋"){
		$currency_name="AFN";  $currency_symble="؋"; 
	}
	elseif($currency=="AMD"|| $currency=="դր."){
		$currency_name="AMD";  $currency_symble="դր."; 
	}
	elseif($currency=="ANG"|| $currency=="ƒ"){
		$currency_name="ANG";  $currency_symble="ƒ"; 
	}
	elseif($currency=="AOA"|| $currency=="Kz"){
		$currency_name="AOA";  $currency_symble="Kz"; 
	}
	elseif($currency=="BDT"|| $currency=="৳"){
		$currency_name="BDT";  $currency_symble="৳"; 
	}
	elseif($currency=="BGN"|| $currency=="лв"){
		$currency_name="BGN";  $currency_symble="лв"; 
	}
	elseif($currency=="BHD"|| $currency==".د.ب"){
		$currency_name="BHD";  $currency_symble=".د.ب"; 
	}
	elseif($currency=="BRL"|| $currency=="R$"){
		$currency_name="BRL";  $currency_symble="R$"; 
	}
	elseif($currency=="BTN"|| $currency=="Nu."){
		$currency_name="BTN";  $currency_symble="Nu."; 
	}
	elseif($currency=="IDR"|| $currency=="Rp"){
		$currency_name="IDR";  $currency_symble="Rp"; 
	}
	elseif($currency=="ILS"|| $currency=="₪"){
		$currency_name="ILS";  $currency_symble="₪"; 
	}
	elseif($currency=="IQD"|| $currency=="ع.د"){
		$currency_name="IQD";  $currency_symble="ع.د"; 
	}
	elseif($currency=="IRR"|| $currency=="﷼"){
		$currency_name="IRR";  $currency_symble="﷼"; 
	}
	elseif($currency=="ISK"|| $currency=="kr"){
		$currency_name="ISK";  $currency_symble="kr"; 
	}
	elseif($currency=="KPW"|| $currency=="₩"){
		$currency_name="KPW";  $currency_symble="₩"; 
	}
	elseif($currency=="KWD"|| $currency=="د.ك"){
		$currency_name="KWD";  $currency_symble="د.ك"; 
	}
	elseif($currency=="LTL"|| $currency=="Lt"){
		$currency_name="LTL";  $currency_symble="Lt"; 
	}
	elseif($currency=="MMK"|| $currency=="Ks"){
		$currency_name="MMK";  $currency_symble="Ks"; 
	}
	elseif($currency=="NGN"|| $currency=="₦"){
		$currency_name="NGN";  $currency_symble="₦"; 
	}
	/*elseif($currency=="NZD"|| $currency=="$"){
		$currency_name="NZD";  $currency_symble="$"; 
	}*/
	elseif($currency=="OMR"|| $currency=="ر.ع."){
		$currency_name="OMR";  $currency_symble="ر.ع."; 
	}
	elseif($currency=="QAR"|| $currency=="ر.ق"){
		$currency_name="QAR";  $currency_symble="ر.ق"; 
	}
	elseif($currency=="THB"|| $currency=="฿"){
		$currency_name="THB";  $currency_symble="฿"; 
	}
	elseif($currency=="UAH"|| $currency=="₴"){
		$currency_name="UAH";  $currency_symble="₴"; 
	}
	elseif($currency=="ZAR"|| $currency=="R"){
		$currency_name="ZAR";  $currency_symble="R"; 
	}
	elseif($currency=="ZMW"|| $currency=="ZK"){
		$currency_name="ZMW";  $currency_symble="ZK"; 
	}
	elseif($currency=="KHR"|| $currency=="៛"){
		$currency_name="KHR";  $currency_symble="៛"; 
	}
	elseif($currency=="VND"|| $currency=="₫"){
		$currency_name="VND";  $currency_symble="₫"; 
	}
	elseif($currency=="PHP"|| $currency=="₱"){
		$currency_name="PHP";  $currency_symbol="₱"; 
	}
	
	/*elseif($currency=="XCD"|| $currency=="$"){
		$currency_name="XCD";  $currency_symble="$"; 
	}
	elseif($currency=="FJD"|| $currency=="$"){
		$currency_name="FJD";  $currency_symble="$"; 
	}
	elseif($currency=="BSD"|| $currency=="$"){
		$currency_name="BSD";  $currency_symble="$"; 
	}*/
	  
	$result_st=$currency_symble; // 0
	if($names==1){
		$result_st=$currency_name;
	}
	
	return $result_st;
}

?>