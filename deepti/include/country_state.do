<?
function get_state_code2($state,$country=''){
	$state=str_replace(array("\r", "\n", "\t","<br>","<br/>"), array("","","","",""), $state);
	$state=preg_replace('/\n+|\t+|\s+/',' ',$state);
	$state=trim($state);$state=strtolower($state);$state=ucwords($state);
	if(strlen($state)==2){$state=strtoupper($state);}
	$result_st=$state;
	$country_three=get_country_code($country,3);
	
	if($country=='Afghanistan' || $country==$country_three){
	  switch($state){
		case 'Badakhshan': $result_st='BDS'; break;
		case 'Badakhshan': $result_st='BDS'; break;
		case 'Badghis': $result_st='BDG'; break;
		case 'Baghlan': $result_st='BGL'; break;
		case 'Balkh': $result_st='BAL'; break;
		case 'Bamian': $result_st='BAM'; break;
		case 'Daykondi': $result_st='DAY'; break;
		case 'Farah': $result_st='FRA'; break;
		case 'Faryab': $result_st='FYB'; break;
		case 'Ghazni': $result_st='GHA'; break;
		case 'Ghowr': $result_st='GHO'; break;
		case 'Helmand': $result_st='HEL'; break;
		case 'Herat': $result_st='HER'; break;
		case 'Jowzjan': $result_st='JOW'; break;
		case 'Kabol': $result_st='KAB'; break;
		case 'Kandahar': $result_st='KAN'; break;
		case 'Kapisa': $result_st='KAP'; break;
		case 'Khowst': $result_st='KHO'; break;
		case 'Konar': $result_st='KNR'; break;
		case 'Kondoz': $result_st='KDZ'; break;
		case 'Laghman': $result_st='LAG'; break;
		case 'Lowgar': $result_st='LOG'; break;
		case 'Nangarhar': $result_st='NAN'; break;
		case 'Nimruz': $result_st='NTM'; break;
		case 'Nurestan': $result_st='NUR'; break;
		case 'Oruzgan': $result_st='URU'; break;
		case 'Paktia': $result_st='PIA'; break;
		case 'Paktika': $result_st='PKA'; break;
		case 'Panjshir': $result_st='PAN'; break;
		case 'Parvan': $result_st='PAR'; break;
		case 'Samangan': $result_st='SAM'; break;
		case 'Sar-e Pol': $result_st='SAR'; break;
		case 'Takhar': $result_st='TAK'; break;
		case 'Vardak': $result_st='WAR'; break;
		case 'Zabol': $result_st='ZAB'; break;
	  }
	}
	if($country=='Åland' || $country==$country_three){
	  switch($state){
		case 'Aland Islands': $result_st='AX'; break;
	  }
	}
	if($country=='Albania' || $country==$country_three){
	  switch($state){
		case 'Berat': $result_st='1'; break;
		case 'Diber': $result_st='9'; break;
		case 'Durres': $result_st='2'; break;
		case 'Elbasan': $result_st='3'; break;
		case 'Fier': $result_st='4'; break;
		case 'Gjirokaster': $result_st='5'; break;
		case 'Korce': $result_st='6'; break;
		case 'Kukes': $result_st='7'; break;
		case 'Lezhe': $result_st='8'; break;
		case 'Shkoder': $result_st='10'; break;
		case 'Tirane': $result_st='11'; break;
		case 'Vlore': $result_st='12'; break;
	  }
	}
	if($country=='Algeria' || $country==$country_three){
	  switch($state){
		case 'Adrar': $result_st='1'; break;
		case 'Ain Defla': $result_st='44'; break;
		case 'Ain Temouchent': $result_st='46'; break;
		case 'Alger': $result_st='16'; break;
		case 'Annaba': $result_st='23'; break;
		case 'Batna': $result_st='5'; break;
		case 'Bechar': $result_st='8'; break;
		case 'Bejaia': $result_st='6'; break;
		case 'Biskra': $result_st='7'; break;
		case 'Blida': $result_st='9'; break;
		case 'Bordj Bou Arreridj': $result_st='34'; break;
		case 'Bouira': $result_st='10'; break;
		case 'Boumerdes': $result_st='35'; break;
		case 'Chlef': $result_st='2'; break;
		case 'Constantine': $result_st='25'; break;
		case 'Djelfa': $result_st='17'; break;
		case 'El Bayadh': $result_st='32'; break;
		case 'El Oued': $result_st='39'; break;
		case 'El Tarf': $result_st='36'; break;
		case 'Ghardaia': $result_st='47'; break;
		case 'Guelma': $result_st='24'; break;
		case 'Illizi': $result_st='33'; break;
		case 'Khenchela': $result_st='40'; break;
		case 'Laghouat': $result_st='3'; break;
		case 'Msila': $result_st='28'; break;
		case 'Mascara': $result_st='29'; break;
		case 'Medea': $result_st='26'; break;
		case 'Mila': $result_st='43'; break;
		case 'Mostaganem': $result_st='27'; break;
		case 'Naama': $result_st='45'; break;
		case 'Oran': $result_st='31'; break;
		case 'Ouargla': $result_st='30'; break;
		case 'Oum el Bouaghi': $result_st='4'; break;
		case 'Relizane': $result_st='48'; break;
		case 'Saida': $result_st='20'; break;
		case 'Setif': $result_st='19'; break;
		case 'Sidi Bel Abbes': $result_st='22'; break;
		case 'Skikda': $result_st='21'; break;
		case 'Souk Ahras': $result_st='41'; break;
		case 'Tamanghasset': $result_st='11'; break;
		case 'Tebessa': $result_st='12'; break;
		case 'Tiaret': $result_st='14'; break;
		case 'Tindouf': $result_st='37'; break;
		case 'Tipaza': $result_st='42'; break;
		case 'Tissemsilt': $result_st='38'; break;
		case 'Tizi Ouzou': $result_st='15'; break;
		case 'Tlemcen': $result_st='13'; break;
	  }
	}
	if($country=='American Samoa' || $country==$country_three){
	  switch($state){
		case 'American Samoa': $result_st='AS'; break;
	  }
	}
	if($country=='Andorra' || $country==$country_three){
	  switch($state){
		case 'Andorra la Vella': $result_st='7'; break;
		case 'Canillo': $result_st='2'; break;
		case 'Encamp': $result_st='3'; break;
		case 'Escaldes-Engordany': $result_st='8'; break;
		case 'La Massana': $result_st='4'; break;
		case 'Ordino': $result_st='5'; break;
		case 'Sant Julia de Loria': $result_st='6'; break;
	  }
	}
	if($country=='Angola' || $country==$country_three){
	  switch($state){
		case 'Bengo': $result_st='BGO'; break;
		case 'Benguela': $result_st='BGU'; break;
		case 'Bie': $result_st='BIE'; break;
		case 'Cabinda': $result_st='CAB'; break;
		case 'Cuando Cubango': $result_st='CCU'; break;
		case 'Cuanza Norte': $result_st='CNO'; break;
		case 'Cuanza Sul': $result_st='CUS'; break;
		case 'Cunene': $result_st='CNN'; break;
		case 'Huambo': $result_st='HUA'; break;
		case 'Huila': $result_st='HUI'; break;
		case 'Luanda': $result_st='LUA'; break;
		case 'Lunda Norte': $result_st='LNO'; break;
		case 'Lunda Sul': $result_st='LSU'; break;
		case 'Malanje': $result_st='MAL'; break;
		case 'Moxico': $result_st='MOX'; break;
		case 'Namibe': $result_st='NAM'; break;
		case 'Uige': $result_st='UIG'; break;
		case 'Zaire': $result_st='ZAI'; break;
	  }
	}
	if($country=='Anguilla' || $country==$country_three){
	  switch($state){
		case 'Anguilla': $result_st='AI'; break;
	  }
	}
	if($country=='Antarctica' || $country==$country_three){
	  switch($state){
		case 'Antarctica': $result_st='AQ'; break;
	  }
	}
	if($country=='Antigua and Barbuda' || $country==$country_three){
	  switch($state){
		case 'Antigua and Barbuda': $result_st='10'; break;
		case 'Saint John': $result_st='4'; break;
		case 'Saint Mary': $result_st='5'; break;
		case 'Saint Paul': $result_st='6'; break;
	  }
	}
	if($country=='Argentina' || $country==$country_three){
	  switch($state){
		case 'Buenos Aires': $result_st='B'; break;
		case 'Catamarca': $result_st='K'; break;
		case 'Chaco': $result_st='H'; break;
		case 'Chubut': $result_st='U'; break;
		case 'Ciudad Autonoma de Buenos Aires': $result_st='C'; break;
		case 'Cordoba': $result_st='X'; break;
		case 'Corrientes': $result_st='W'; break;
		case 'Entre Rios': $result_st='E'; break;
		case 'Formosa': $result_st='P'; break;
		case 'Jujuy': $result_st='Y'; break;
		case 'La Pampa': $result_st='L'; break;
		case 'La Rioja': $result_st='F'; break;
		case 'Mendoza': $result_st='M'; break;
		case 'Misiones': $result_st='N'; break;
		case 'Neuquen': $result_st='Q'; break;
		case 'Rio Negro': $result_st='R'; break;
		case 'Salta': $result_st='A'; break;
		case 'San Juan': $result_st='J'; break;
		case 'San Luis': $result_st='D'; break;
		case 'Santa Cruz': $result_st='Z'; break;
		case 'Santa Fe': $result_st='S'; break;
		case 'Santiago del Estero': $result_st='G'; break;
		case 'Tierra del Fuego': $result_st='V'; break;
		case 'Tucuman': $result_st='T'; break;
	  }
	}
	if($country=='Armenia' || $country==$country_three){
	  switch($state){
		case 'Aragatsotn': $result_st='AG'; break;
		case 'Ararat': $result_st='AR'; break;
		case 'Armavir': $result_st='AV'; break;
		case 'Geghark unik': $result_st='GR'; break;
		case 'Kotayk': $result_st='KT'; break;
		case 'Lorri': $result_st='LO'; break;
		case 'Shirak': $result_st='SH'; break;
		case 'Syunik': $result_st='SU'; break;
		case 'Tavush': $result_st='TV'; break;
		case 'Vayots Dzor': $result_st='VD'; break;
		case 'Yerevan': $result_st='ER'; break;
	  }
	}
	if($country=='Aruba' || $country==$country_three){
	  switch($state){
		case 'Aruba': $result_st='AW'; break;
	  }
	}
	if($country=='Australia' || $country==$country_three){
	  switch($state){
		case 'Australian Capital Territory': $result_st='ACT'; break;
		case 'New South Wales': $result_st='NSW'; break;
		case 'Northern Territory': $result_st='NT'; break;
		case 'Queensland': $result_st='QLD'; break;
		case 'South Australia': $result_st='SA'; break;
		case 'Tasmania': $result_st='TAS'; break;
		case 'Victoria': $result_st='VIC'; break;
		case 'Western Australia': $result_st='WA'; break;
	  }
	}
	if($country=='Austria' || $country==$country_three){
	  switch($state){
		case 'Burgenland': $result_st='1'; break;
		case 'Karnten': $result_st='2'; break;
		case 'Niederosterreich': $result_st='3'; break;
		case 'Oberosterreich': $result_st='4'; break;
		case 'Salzburg': $result_st='5'; break;
		case 'Steiermark': $result_st='6'; break;
		case 'Tirol': $result_st='7'; break;
		case 'Vorarlberg': $result_st='8'; break;
		case 'Wien': $result_st='9'; break;
	  }
	}
	if($country=='Azerbaijan' || $country==$country_three){
	  switch($state){
		case 'Abseron': $result_st='ABS'; break;
		case 'Agcabadi': $result_st='AGC'; break;
		case 'Agdam': $result_st='AGM'; break;
		case 'Agdas': $result_st='AGS'; break;
		case 'Agstafa': $result_st='AGA'; break;
		case 'Agsu': $result_st='AGU'; break;
		case 'Ali Bayramli': $result_st='AB '; break;
		case 'Astara': $result_st='AST'; break;
		case 'Baki': $result_st='BA'; break;
		case 'Balakan': $result_st='BAL'; break;
		case 'Barda': $result_st='BAR'; break;
		case 'Beylaqan': $result_st='BEY'; break;
		case 'Bilasuvar': $result_st='BIL'; break;
		case 'Cabrayil': $result_st='CAB'; break;
		case 'Calilabad': $result_st='CAL'; break;
		case 'Daskasan': $result_st='DAS'; break;
		case 'Fuzuli': $result_st='FUZ'; break;
		case 'Gadabay': $result_st='GAD'; break;
		case 'Ganca': $result_st='GA'; break;
		case 'Goranboy': $result_st='GOR'; break;
		case 'Goycay': $result_st='GOY'; break;
		case 'Haciqabul': $result_st='HAC'; break;
		case 'Imisli': $result_st='IMI'; break;
		case 'Ismayilli': $result_st='ISM'; break;
		case 'Kalbacar': $result_st='KAL'; break;
		case 'Lacin': $result_st='LAC'; break;
		case 'Lankaran': $result_st='LAN'; break;
		case 'Lerik': $result_st='LER'; break;
		case 'Masalli': $result_st='MAS'; break;
		case 'Mingacevir': $result_st='MI'; break;
		case 'Naftalan': $result_st='NA'; break;
		case 'Naxcivan': $result_st='NV'; break;
		case 'Neftcala': $result_st='NEF'; break;
		case 'Oguz': $result_st='OGU'; break;
		case 'Qabala': $result_st='QAB'; break;
		case 'Qax': $result_st='QAX'; break;
		case 'Qazax': $result_st='QAZ'; break;
		case 'Qobustan': $result_st='QOB'; break;
		case 'Quba': $result_st='QBA'; break;
		case 'Qubadli': $result_st='QBI'; break;
		case 'Qusar': $result_st='QUS'; break;
		case 'Saatli': $result_st='SAT'; break;
		case 'Sabirabad': $result_st='SAB'; break;
		case 'Saki': $result_st='SAK'; break;
		case 'Salyan': $result_st='SAL'; break;
		case 'Samaxi': $result_st='SMI'; break;
		case 'Samkir': $result_st='SKR'; break;
		case 'Samux': $result_st='SMX'; break;
		case 'Sumqayit': $result_st='SM'; break;
		case 'Susa': $result_st='SUS'; break;
		case 'Tartar': $result_st='TAR'; break;
		case 'Tovuz': $result_st='TOV'; break;
		case 'Ucar': $result_st='UCA'; break;
		case 'Xacmaz': $result_st='XAC'; break;
		case 'Xankandi': $result_st='XA'; break;
		case 'Xanlar': $result_st='XAN'; break;
		case 'Xizi': $result_st='XTZ'; break;
		case 'Xocali': $result_st='XCI'; break;
		case 'Xocavand': $result_st='XVD'; break;
		case 'Yardimli': $result_st='YAR'; break;
		case 'Yevlax': $result_st='YEV'; break;
		case 'Zangilan': $result_st='ZAN'; break;
		case 'Zaqatala': $result_st='ZAQ'; break;
		case 'Zardab': $result_st='ZAR'; break;
	  }
	}
	if($country=='Bahamas' || $country==$country_three){
	  switch($state){
		case 'Freeport': $result_st='FP'; break;
		case 'Fresh Creek': $result_st='FC'; break;
		case 'Harbour Island': $result_st='HI'; break;
		case 'High Rock': $result_st='HR'; break;
		case 'Long Island': $result_st='LI'; break;
		case 'Marsh Harbour': $result_st='MH'; break;
		case 'New Providence': $result_st='NP'; break;
		case 'Rock Sound': $result_st='RS'; break;
	  }
	}
	if($country=='Bahrain' || $country==$country_three){
	  switch($state){
		case 'Al Asimah': $result_st='13'; break;
		case 'Al Muharraq': $result_st='15'; break;
		case 'Al Wusta': $result_st='16'; break;
		case 'Ash Shamaliyah': $result_st='17'; break;
	  }
	}
	if($country=='Bangladesh' || $country==$country_three){
	  switch($state){
		case 'Barisal': $result_st='A'; break;
		case 'Chittagong': $result_st='B'; break;
		case 'Dhaka': $result_st='C'; break;
		case 'Khulna': $result_st='D'; break;
		case 'Rajshahi': $result_st='E'; break;
		case 'Rangpur': $result_st='F'; break;
		case 'Sylhet': $result_st='G'; break;
	  }
	}
	if($country=='Barbados' || $country==$country_three){
	  switch($state){
		case 'Christ Church': $result_st='1'; break;
		case 'Saint James': $result_st='4'; break;
		case 'Saint Joseph': $result_st='6'; break;
		case 'Saint Michael': $result_st='8'; break;
		case 'Saint Peter': $result_st='9'; break;
	  }
	}
	if($country=='Belarus' || $country==$country_three){
	  switch($state){
		case 'Brestskaya Voblasts': $result_st='BR'; break;
		case 'Homyelskaya Voblasts': $result_st='HO'; break;
		case 'Hrodzyenskaya Voblasts': $result_st='HR'; break;
		case 'Mahilyowskaya Voblasts': $result_st='MA'; break;
		case 'Minskaya Voblasts': $result_st='MI'; break;
		case 'Vitsyebskaya Voblasts': $result_st='VI'; break;
		case 'Antwerpen': $result_st='VAN'; break;
		case 'Brabant Wallon': $result_st='WBR'; break;
		case 'Brussels Hoofdstedelijk Gewest': $result_st='BRU'; break;
		case 'Hainaut': $result_st='WHT'; break;
		case 'Liege': $result_st='WLG'; break;
		case 'Limburg': $result_st='VLI'; break;
		case 'Luxembourg': $result_st='WLX'; break;
		case 'Namur': $result_st='WNA'; break;
		case 'Oost-Vlaanderen': $result_st='VOV'; break;
		case 'Vlaams-Brabant': $result_st='VBR'; break;
		case 'West-Vlaanderen': $result_st='VWV'; break;
	  }
	}
	if($country=='Belize' || $country==$country_three){
	  switch($state){
		case 'Belize': $result_st='BZ'; break;
		case 'Cayo': $result_st='CY'; break;
		case 'Corozal': $result_st='CZL'; break;
		case 'Orange Walk': $result_st='OW'; break;
		case 'Stann Creek': $result_st='SC'; break;
		case 'Toledo': $result_st='TOL'; break;
		case 'Alibori': $result_st='AL'; break;
		case 'Atakora': $result_st='AK'; break;
		case 'Atlantique': $result_st='AQ'; break;
		case 'Borgou': $result_st='BO'; break;
		case 'Collines': $result_st='CO'; break;
		case 'Donga': $result_st='DO'; break;
		case 'Kouffo': $result_st='KO'; break;
		case 'Littoral': $result_st='LI'; break;
		case 'Mono': $result_st='MO'; break;
		case 'Oueme': $result_st='OU'; break;
		case 'Plateau': $result_st='PL'; break;
		case 'Zou': $result_st='ZO'; break;
	  }
	}
	if($country=='Bermuda' || $country==$country_three){
	  switch($state){
		case 'Bermuda': $result_st='BM'; break;
	  }
	}
	if($country=='Bhutan' || $country==$country_three){
	  switch($state){
		case 'Chhukha': $result_st='12'; break;
		case 'Daga': $result_st='22'; break;
		case 'Gasa': $result_st='GA'; break;
		case 'Ha': $result_st='13'; break;
		case 'Mongar': $result_st='42'; break;
		case 'Paro': $result_st='11'; break;
		case 'Punakha': $result_st='23'; break;
		case 'Shemgang': $result_st='34'; break;
		case 'Thimphu': $result_st='15'; break;
		case 'Tongsa': $result_st='32'; break;
		case 'Trashi Yangste': $result_st='TY'; break;
		case 'Chuquisaca': $result_st='H'; break;
		case 'Cochabamba': $result_st='C'; break;
		case 'El Beni': $result_st='B'; break;
		case 'La Paz': $result_st='L'; break;
		case 'Oruro': $result_st='O'; break;
		case 'Pando': $result_st='N'; break;
		case 'Potosi': $result_st='P'; break;
		case 'Santa Cruz': $result_st='S'; break;
		case 'Tarija': $result_st='T'; break;
	  }
	}
	if($country=='Bonaire, Sint Eustatius, and Saba' || $country==$country_three){
	  switch($state){
		case 'Bonaire': $result_st='BO'; break;
		case 'Saba': $result_st='SA'; break;
		case 'Sint Eustatius': $result_st='SE'; break;
	  }
	}
	if($country=='Bosnia and Herzegovina' || $country==$country_three){
	  switch($state){
		case 'Federation of Bosnia and Herzegovina': $result_st='BIH'; break;
		case 'Republika Srpska': $result_st='SRP'; break;
	  }
	}
	if($country=='Botswana' || $country==$country_three){
	  switch($state){
		case 'Central': $result_st='CE'; break;
		case 'Ghanzi': $result_st='GH'; break;
		case 'Kgalagadi': $result_st='KG'; break;
		case 'Kgatleng': $result_st='KL'; break;
		case 'Kweneng': $result_st='KW'; break;
		case 'North-East': $result_st='NE'; break;
		case 'North-West': $result_st='NW'; break;
		case 'South-East': $result_st='SE'; break;
		case 'Southern': $result_st='SO'; break;
	  }
	}
	if($country=='Brazil' || $country==$country_three){
	  switch($state){
		case 'Acre': $result_st='AC'; break;
		case 'Alagoas': $result_st='AL'; break;
		case 'Amapa': $result_st='AP'; break;
		case 'Amazonas': $result_st='AM'; break;
		case 'Bahia': $result_st='BA'; break;
		case 'Ceara': $result_st='CE'; break;
		case 'Distrito Federal': $result_st='DF'; break;
		case 'Espirito Santo': $result_st='ES'; break;
		case 'Goias': $result_st='GO'; break;
		case 'Maranhao': $result_st='MA'; break;
		case 'Mato Grosso do Sul': $result_st='MS'; break;
		case 'Mato Grosso': $result_st='MT'; break;
		case 'Minas Gerais': $result_st='MG'; break;
		case 'Para': $result_st='PA'; break;
		case 'Paraiba': $result_st='PB'; break;
		case 'Parana': $result_st='PR'; break;
		case 'Pernambuco': $result_st='PE'; break;
		case 'Piaui': $result_st='PI'; break;
		case 'Rio Grande do Norte': $result_st='RN'; break;
		case 'Rio Grande do Sul': $result_st='RS'; break;
		case 'Rio de Janeiro': $result_st='RJ'; break;
		case 'Rondonia': $result_st='RO'; break;
		case 'Roraima': $result_st='RR'; break;
		case 'Santa Catarina': $result_st='SC'; break;
		case 'Sao Paulo': $result_st='SP'; break;
		case 'Sergipe': $result_st='SE'; break;
		case 'Tocantins': $result_st='TO'; break;
	  }
	}
	if($country=='British Indian Ocean Territory' || $country==$country_three){
	  switch($state){
		case 'British Indian Ocean Territory': $result_st='IO'; break;
	  }
	}
	if($country=='British Virgin Islands' || $country==$country_three){
	  switch($state){
		case 'Virgin Islands, British': $result_st='VG'; break;
	  }
	}
	if($country=='Brunei' || $country==$country_three){
	  switch($state){
		case 'Belait': $result_st='BE'; break;
		case 'Brunei and Muara': $result_st='BM'; break;
		case 'Temburong': $result_st='TE'; break;
		case 'Tutong': $result_st='TU'; break;
	  }
	}
	if($country=='Bulgaria' || $country==$country_three){
	  switch($state){
		case 'Blagoevgrad': $result_st='1'; break;
		case 'Burgas': $result_st='2'; break;
		case 'Dobrich': $result_st='8'; break;
		case 'Gabrovo': $result_st='7'; break;
		case 'Grad Sofiya': $result_st='22'; break;
		case 'Khaskovo': $result_st='26'; break;
		case 'Kurdzhali': $result_st='9'; break;
		case 'Kyustendil': $result_st='10'; break;
		case 'Lovech': $result_st='11'; break;
		case 'Montana': $result_st='12'; break;
		case 'Pazardzhik': $result_st='13'; break;
		case 'Pernik': $result_st='14'; break;
		case 'Pleven': $result_st='15'; break;
		case 'Plovdiv': $result_st='16'; break;
		case 'Razgrad': $result_st='17'; break;
		case 'Ruse': $result_st='18'; break;
		case 'Shumen': $result_st='27'; break;
		case 'Silistra': $result_st='19'; break;
		case 'Sliven': $result_st='20'; break;
		case 'Smolyan': $result_st='21'; break;
		case 'Sofiya': $result_st='23'; break;
		case 'Stara Zagora': $result_st='24'; break;
		case 'Turgovishte': $result_st='25'; break;
		case 'Varna': $result_st='3'; break;
		case 'Veliko Turnovo': $result_st='4'; break;
		case 'Vidin': $result_st='5'; break;
		case 'Vratsa': $result_st='6'; break;
		case 'Yambol': $result_st='28'; break;
	  }
	}
	if($country=='Burkina Faso' || $country==$country_three){
	  switch($state){
		case 'Bale': $result_st='BAL'; break;
		case 'Bam': $result_st='BAM'; break;
		case 'Banwa': $result_st='ABN'; break;
		case 'Bazega': $result_st='BAZ'; break;
		case 'Bougouriba': $result_st='BGR'; break;
		case 'Boulgou': $result_st='BLG'; break;
		case 'Boulkiemde': $result_st='BLK'; break;
		case 'Ganzourgou': $result_st='GAN'; break;
		case 'Gnagna': $result_st='GNA'; break;
		case 'Gourma': $result_st='GOU'; break;
		case 'Houet': $result_st='HOU'; break;
		case 'Ioba': $result_st='IOB'; break;
		case 'Kadiogo': $result_st='KAD'; break;
		case 'Kenedougou': $result_st='KEN'; break;
		case 'Komoe': $result_st='COM'; break;
		case 'Komondjari': $result_st='KMD'; break;
		case 'Kompienga': $result_st='KMP'; break;
		case 'Kossi': $result_st='KOS'; break;
		case 'Koulpelogo': $result_st='KOP'; break;
		case 'Kouritenga': $result_st='KOT'; break;
		case 'Kourweogo': $result_st='KOW'; break;
		case 'Leraba': $result_st='LER'; break;
		case 'Loroum': $result_st='LOR'; break;
		case 'Mouhoun': $result_st='MOU'; break;
		case 'Namentenga': $result_st='NAM'; break;
		case 'Naouri': $result_st='NAO'; break;
		case 'Nayala': $result_st='NAY'; break;
		case 'Noumbiel': $result_st='NOU'; break;
		case 'Oubritenga': $result_st='OUB'; break;
		case 'Oudalan': $result_st='OUD'; break;
		case 'Passore': $result_st='PAS'; break;
		case 'Poni': $result_st='PON'; break;
		case 'Sanguie': $result_st='SNG'; break;
		case 'Sanmatenga': $result_st='SMT'; break;
		case 'Seno': $result_st='SEN'; break;
		case 'Sissili': $result_st='SIS'; break;
		case 'Soum': $result_st='SOM'; break;
		case 'Sourou': $result_st='SOR'; break;
		case 'Tapoa': $result_st='TAP'; break;
		case 'Tuy': $result_st='TUI'; break;
		case 'Yagha': $result_st='YAG'; break;
		case 'Yatenga': $result_st='YAT'; break;
		case 'Ziro': $result_st='ZIR'; break;
		case 'Zondoma': $result_st='ZON'; break;
		case 'Zoundweogo': $result_st='ZOU'; break;
	  }
	}
	if($country=='Burundi' || $country==$country_three){
	  switch($state){
		case 'Bubanza': $result_st='BB'; break;
		case 'Bujumbura Mairie': $result_st='BM'; break;
		case 'Bururi': $result_st='BR'; break;
		case 'Cankuzo': $result_st='CA'; break;
		case 'Cibitoke': $result_st='CI'; break;
		case 'Gitega': $result_st='GI'; break;
		case 'Karuzi': $result_st='KR'; break;
		case 'Kayanza': $result_st='KY'; break;
		case 'Kirundo': $result_st='KI'; break;
		case 'Makamba': $result_st='MA'; break;
		case 'Muramvya': $result_st='MU'; break;
		case 'Muyinga': $result_st='MY'; break;
		case 'Mwaro': $result_st='MW'; break;
		case 'Ngozi': $result_st='NG'; break;
		case 'Rutana': $result_st='RT'; break;
		case 'Ruyigi': $result_st='RY'; break;
	  }
	}
	if($country=='Cambodia' || $country==$country_three){
	  switch($state){
		case 'Banteay Meanchey': $result_st='1'; break;
		case 'Battambang': $result_st='2'; break;
		case 'Kampong Cham': $result_st='3'; break;
		case 'Kampong Chhnang': $result_st='4'; break;
		case 'Kampong Speu': $result_st='5'; break;
		case 'Kampong Thom': $result_st='6'; break;
		case 'Kampot': $result_st='7'; break;
		case 'Kandal': $result_st='8'; break;
		case 'Kep': $result_st='23'; break;
		case 'Koh Kong': $result_st='9'; break;
		case 'Kratie': $result_st='10'; break;
		case 'Mondulkiri': $result_st='11'; break;
		case 'Oddar Meanchey': $result_st='22'; break;
		case 'Pailin': $result_st='24'; break;
		case 'Phnom Penh': $result_st='12'; break;
		case 'Preah Sihanouk': $result_st='18'; break;
		case 'Preah Vihear': $result_st='13'; break;
		case 'Prey Veng': $result_st='14'; break;
		case 'Pursat': $result_st='15'; break;
		case 'Ratanakiri': $result_st='16'; break;
		case 'Siem Reap': $result_st='17'; break;
		case 'Stung Treng': $result_st='19'; break;
		case 'Svay Rieng': $result_st='20'; break;
		case 'Takeo': $result_st='21'; break;
	  }
	}
	if($country=='Cameroon' || $country==$country_three){
	  switch($state){
		case 'Adamaoua': $result_st='AD'; break;
		case 'Centre': $result_st='CE'; break;
		case 'Est': $result_st='ES'; break;
		case 'Extreme-Nord': $result_st='EN'; break;
		case 'Littoral': $result_st='LT'; break;
		case 'Nord': $result_st='NO'; break;
		case 'Nord-Ouest': $result_st='NW'; break;
		case 'Ouest': $result_st='OU'; break;
		case 'Sud': $result_st='SU'; break;
		case 'Sud-Ouest': $result_st='SW'; break;
	  }
	}
	if($country=='Canada' || $country==$country_three){
	  switch($state){
		case 'Alberta': $result_st='AB'; break;
		case 'British Columbia': $result_st='BC'; break;
		case 'Manitoba': $result_st='MB'; break;
		case 'New Brunswick': $result_st='NB'; break;
		case 'Newfoundland and Labrador': $result_st='NL'; break;
		case 'Northwest Territories': $result_st='NT'; break;
		case 'Nova Scotia': $result_st='NS'; break;
		case 'Nunavut': $result_st='NU'; break;
		case 'Ontario': $result_st='ON'; break;
		case 'Prince Edward Island': $result_st='PE'; break;
		case 'Quebec': $result_st='QC'; break;
		case 'Saskatchewan': $result_st='SK'; break;
		case 'Yukon': $result_st='YT'; break;
	  }
	}
	if($country=='Cape Verde' || $country==$country_three){
	  switch($state){
		case 'Boa Vista': $result_st='BV'; break;
		case 'Brava': $result_st='BR'; break;
		case 'Maio': $result_st='MA'; break;
		case 'Mosteiros': $result_st='MO'; break;
		case 'Paul': $result_st='PA'; break;
		case 'Porto Novo': $result_st='PN'; break;
		case 'Praia': $result_st='PR'; break;
		case 'Ribeira Brava': $result_st='RB'; break;
		case 'Ribeira Grande de Santiago': $result_st='RS'; break;
		case 'Ribeira Grande': $result_st='RG'; break;
		case 'Sal': $result_st='SL'; break;
		case 'Santa Catarina do Fogo': $result_st='CF'; break;
		case 'Santa Catarina': $result_st='CA'; break;
		case 'Santa Cruz': $result_st='CR'; break;
		case 'Sao Domingos': $result_st='SD'; break;
		case 'Sao Filipe': $result_st='SF'; break;
		case 'Sao Miguel': $result_st='SM'; break;
		case 'Sao Salvador do Mundo': $result_st='SS'; break;
		case 'Sao Vicente': $result_st='SV'; break;
		case 'Tarrafal de Sao Nicolau': $result_st='TS'; break;
		case 'Tarrafal': $result_st='TA'; break;
	  }
	}
	if($country=='Cayman Islands' || $country==$country_three){
	  switch($state){
		case 'Cayman Islands': $result_st='KY'; break;
	  }
	}
	if($country=='Central African Republic' || $country==$country_three){
	  switch($state){
		case 'Bamingui-Bangoran': $result_st='BB'; break;
		case 'Bangui': $result_st='BGF'; break;
		case 'Basse-Kotto': $result_st='BK'; break;
		case 'Haut-Mbomou': $result_st='HM'; break;
		case 'Haute-Kotto': $result_st='HK'; break;
		case 'Kemo': $result_st='KG'; break;
		case 'Lobaye': $result_st='LB'; break;
		case 'Mambere-Kadei': $result_st='HS'; break;
		case 'Mbomou': $result_st='MB'; break;
		case 'Nana-Grebizi': $result_st='KB'; break;
		case 'Nana-Mambere': $result_st='NM'; break;
		case 'Ombella-Mpoko': $result_st='MP'; break;
		case 'Ouaka': $result_st='UK'; break;
		case 'Ouham': $result_st='AC'; break;
		case 'Ouham-Pende': $result_st='OP'; break;
		case 'Sangha-Mbaere': $result_st='SE'; break;
	  }
	}
	if($country=='Chad' || $country==$country_three){
	  switch($state){
		case 'Barh el Ghazel': $result_st='BG'; break;
		case 'Batha': $result_st='BA'; break;
		case 'Borkou': $result_st='BO'; break;
		case 'Chari-Baguirmi': $result_st='CB'; break;
		case 'Guera': $result_st='GR'; break;
		case 'Hadjer-Lamis': $result_st='HL'; break;
		case 'Kanem': $result_st='KA'; break;
		case 'Lac': $result_st='LC'; break;
		case 'Logone Occidental': $result_st='LO'; break;
		case 'Logone Oriental': $result_st='LR'; break;
		case 'Mandoul': $result_st='MA'; break;
		case 'Mayo-Kebbi Est': $result_st='ME'; break;
		case 'Mayo-Kebbi Ouest': $result_st='MO'; break;
		case 'Moyen-Chari': $result_st='MC'; break;
		case 'Ouaddai': $result_st='OD'; break;
		case 'Salamat': $result_st='SA'; break;
		case 'Tandjile': $result_st='TA'; break;
		case 'Tibesti': $result_st='TI'; break;
		case 'Wadi Fira': $result_st='WF'; break;
	  }
	}
	if($country=='Chile' || $country==$country_three){
	  switch($state){
		case 'Aisen del General Carlos Ibanez del Campo': $result_st='AI'; break;
		case 'Antofagasta': $result_st='AN'; break;
		case 'Araucania': $result_st='AR'; break;
		case 'Arica y Parinacota': $result_st='AP'; break;
		case 'Atacama': $result_st='AT'; break;
		case 'Bio-Bio': $result_st='BI'; break;
		case 'Coquimbo': $result_st='CO'; break;
		case 'Libertador General Bernardo O\'Higgins': $result_st='LI'; break;
		case 'Los Lagos': $result_st='LL'; break;
		case 'Los Rios': $result_st='LR'; break;
		case 'Magallanes y de la Antartica Chilena': $result_st='MA'; break;
		case 'Maule': $result_st='ML'; break;
		case 'Region Metropolitana': $result_st='RM'; break;
		case 'Tarapaca': $result_st='TA'; break;
		case 'Valparaiso': $result_st='VS'; break;
	  }
	}
	if($country=='China' || $country==$country_three){
	  switch($state){
		case 'Anhui': $result_st='34'; break;
		case 'Beijing': $result_st='11'; break;
		case 'Chongqing': $result_st='50'; break;
		case 'Fujian': $result_st='35'; break;
		case 'Gansu': $result_st='62'; break;
		case 'Guangdong': $result_st='44'; break;
		case 'Guangxi': $result_st='45'; break;
		case 'Guizhou': $result_st='52'; break;
		case 'Hainan': $result_st='46'; break;
		case 'Hebei': $result_st='13'; break;
		case 'Heilongjiang': $result_st='23'; break;
		case 'Henan': $result_st='41'; break;
		case 'Hubei': $result_st='42'; break;
		case 'Hunan': $result_st='43'; break;
		case 'Jiangsu': $result_st='32'; break;
		case 'Jiangxi': $result_st='36'; break;
		case 'Jilin': $result_st='22'; break;
		case 'Liaoning': $result_st='21'; break;
		case 'Nei Mongol': $result_st='15'; break;
		case 'Ningxia': $result_st='64'; break;
		case 'Qinghai': $result_st='63'; break;
		case 'Shaanxi': $result_st='61'; break;
		case 'Shandong': $result_st='37'; break;
		case 'Shanghai': $result_st='31'; break;
		case 'Shanxi': $result_st='14'; break;
		case 'Sichuan': $result_st='51'; break;
		case 'Tianjin': $result_st='12'; break;
		case 'Xinjiang': $result_st='65'; break;
		case 'Xizang': $result_st='54'; break;
		case 'Yunnan': $result_st='53'; break;
		case 'Zhejiang': $result_st='33'; break;
	  }
	}
	if($country=='Christmas Island' || $country==$country_three){
	  switch($state){
		case 'Christmas Island': $result_st='CX'; break;
	  }
	}
	if($country=='Cocos [Keeling] Islands' || $country==$country_three){
	  switch($state){
		case 'Cocos (Keeling) Islands': $result_st='CC'; break;
	  }
	}
	if($country=='Colombia' || $country==$country_three){
	  switch($state){
		case 'Amazonas': $result_st='AMA'; break;
		case 'Antioquia': $result_st='ANT'; break;
		case 'Arauca': $result_st='ARA'; break;
		case 'Atlantico': $result_st='ATL'; break;
		case 'Bolivar': $result_st='BOL'; break;
		case 'Boyaca': $result_st='BOY'; break;
		case 'Caldas': $result_st='CAL'; break;
		case 'Caqueta': $result_st='CAQ'; break;
		case 'Casanare': $result_st='CAS'; break;
		case 'Cauca': $result_st='CAU'; break;
		case 'Cesar': $result_st='CES'; break;
		case 'Choco': $result_st='CHO'; break;
		case 'Cordoba': $result_st='COR'; break;
		case 'Cundinamarca': $result_st='CUN'; break;
		case 'Distrito Capital de Bogota': $result_st='DC'; break;
		case 'Guainia': $result_st='GUA'; break;
		case 'Guaviare': $result_st='GUV'; break;
		case 'Huila': $result_st='HUI'; break;
		case 'La Guajira': $result_st='LAG'; break;
		case 'Magdalena': $result_st='MAG'; break;
		case 'Meta': $result_st='MET'; break;
		case 'Narino': $result_st='NAR'; break;
		case 'Norte de Santander': $result_st='NSA'; break;
		case 'Putumayo': $result_st='PUT'; break;
		case 'Quindio': $result_st='QUI'; break;
		case 'Risaralda': $result_st='RIS'; break;
		case 'San Andres y Providencia': $result_st='SAP'; break;
		case 'Santander': $result_st='SAN'; break;
		case 'Sucre': $result_st='SUC'; break;
		case 'Tolima': $result_st='TOL'; break;
		case 'Valle del Cauca': $result_st='VAC'; break;
		case 'Vaupes': $result_st='VAU'; break;
		case 'Vichada': $result_st='VID'; break;
	  }
	}
	if($country=='Comoros' || $country==$country_three){
	  switch($state){
		case 'Anjouan': $result_st='A'; break;
		case 'Grande Comore': $result_st='G'; break;
		case 'Moheli': $result_st='M'; break;
	  }
	}
	if($country=='Congo' || $country==$country_three){
	  switch($state){
		case 'Bandundu': $result_st='BN'; break;
		case 'Bas-Congo': $result_st='BC'; break;
		case 'Equateur': $result_st='EQ'; break;
		case 'Kasai-Occidental': $result_st='KW'; break;
		case 'Kasai-Oriental': $result_st='KE'; break;
		case 'Katanga': $result_st='KA'; break;
		case 'Kinshasa': $result_st='KN'; break;
		case 'Maniema': $result_st='MA'; break;
		case 'Nord-Kivu': $result_st='NK'; break;
		case 'Orientale': $result_st='OR'; break;
		case 'Sud-Kivu': $result_st='SK'; break;
	  }
	}
	if($country=='Cook Islands' || $country==$country_three){
	  switch($state){
		case 'Cook Islands': $result_st='CK'; break;
	  }
	}
	if($country=='Costa Rica' || $country==$country_three){
	  switch($state){
		case 'Alajuela': $result_st='A'; break;
		case 'Cartago': $result_st='C'; break;
		case 'Guanacaste': $result_st='G'; break;
		case 'Heredia': $result_st='H'; break;
		case 'Limon': $result_st='L'; break;
		case 'Puntarenas': $result_st='P'; break;
		case 'San Jose': $result_st='SJ'; break;
	  }
	}
	if($country=='Croatia' || $country==$country_three){
	  switch($state){
		case 'Bjelovarsko-Bilogorska': $result_st='7'; break;
		case 'Brodsko-Posavska': $result_st='12'; break;
		case 'Dubrovacko-Neretvanska': $result_st='19'; break;
		case 'Grad Zagreb': $result_st='21'; break;
		case 'Istarska': $result_st='18'; break;
		case 'Karlovacka': $result_st='4'; break;
		case 'Koprivnicko-Krizevacka': $result_st='6'; break;
		case 'Krapinsko-Zagorska': $result_st='2'; break;
		case 'Licko-Senjska': $result_st='9'; break;
		case 'Medimurska': $result_st='20'; break;
		case 'Osjecko-Baranjska': $result_st='14'; break;
		case 'Pozesko-Slavonska': $result_st='11'; break;
		case 'Primorsko-Goranska': $result_st='8'; break;
		case 'Sibensko-Kninska': $result_st='15'; break;
		case 'Sisacko-Moslavacka': $result_st='3'; break;
		case 'Splitsko-Dalmatinska': $result_st='17'; break;
		case 'Varazdinska': $result_st='5'; break;
		case 'Viroviticko-Podravska': $result_st='10'; break;
		case 'Vukovarsko-Srijemska': $result_st='16'; break;
		case 'Zadarska': $result_st='13'; break;
		case 'Zagrebacka': $result_st='1'; break;
	  }
	}
	if($country=='Cuba' || $country==$country_three){
	  switch($state){
		case 'Artemisa': $result_st='15'; break;
		case 'Camaguey': $result_st='9'; break;
		case 'Ciego de Avila': $result_st='8'; break;
		case 'Cienfuegos': $result_st='6'; break;
		case 'Ciudad de la Habana': $result_st='3'; break;
		case 'Granma': $result_st='12'; break;
		case 'Guantanamo': $result_st='14'; break;
		case 'Holguin': $result_st='11'; break;
		case 'Isla de la Juventud': $result_st='99'; break;
		case 'La Habana': $result_st='2'; break;
		case 'Las Tunas': $result_st='10'; break;
		case 'Matanzas': $result_st='4'; break;
		case 'Mayabeque': $result_st='16'; break;
		case 'Pinar del Rio': $result_st='1'; break;
		case 'Sancti Spiritus': $result_st='7'; break;
		case 'Santiago de Cuba': $result_st='13'; break;
		case 'Villa Clara': $result_st='5'; break;
	  }
	}
	if($country=='Curaçao' || $country==$country_three){
	  switch($state){
		case 'Curacao': $result_st='CW'; break;
	  }
	}
	if($country=='Cyprus' || $country==$country_three){
	  switch($state){
		case 'Famagusta': $result_st='4'; break;
		case 'Kyrenia': $result_st='6'; break;
		case 'Larnaca': $result_st='3'; break;
		case 'Limassol': $result_st='2'; break;
		case 'Nicosia': $result_st='1'; break;
		case 'Paphos': $result_st='5'; break;
	  }
	}
	if($country=='Czech Republic' || $country==$country_three){
	  switch($state){
		case 'Hlavni mesto Praha': $result_st='PR'; break;
		case 'Jihocesky kraj': $result_st='JC'; break;
		case 'Jihomoravsky kraj': $result_st='JM'; break;
		case 'Karlovarsky kraj': $result_st='KA'; break;
		case 'Kralovehradecky kraj': $result_st='KR'; break;
		case 'Liberecky kraj': $result_st='LI'; break;
		case 'Moravskoslezsky kraj': $result_st='MO'; break;
		case 'Olomoucky kraj': $result_st='OL'; break;
		case 'Pardubicky kraj': $result_st='PA'; break;
		case 'Plzensky kraj': $result_st='PL'; break;
		case 'Stredocesky kraj': $result_st='ST'; break;
		case 'Ustecky kraj': $result_st='US'; break;
		case 'Vysocina kraj': $result_st='VY'; break;
		case 'Zlinsky kraj': $result_st='ZL'; break;
	  }
	}
	if($country=='Denmark' || $country==$country_three){
	  switch($state){
		case 'Hovedstaden': $result_st='84'; break;
		case 'Midtjylland': $result_st='82'; break;
		case 'Nordjylland': $result_st='81'; break;
		case 'Sjelland': $result_st='85'; break;
		case 'Syddanmark': $result_st='83'; break;
	  }
	}
	if($country=='Djibouti' || $country==$country_three){
	  switch($state){
		case 'Ali Sabieh': $result_st='AS'; break;
		case 'Arta': $result_st='AR'; break;
		case 'Dikhil': $result_st='DI'; break;
		case 'Djibouti': $result_st='DJ'; break;
		case 'Obock': $result_st='OB'; break;
		case 'Tadjoura': $result_st='TA'; break;
	  }
	}
	if($country=='Dominica' || $country==$country_three){
	  switch($state){
		case 'Saint Andrew': $result_st='2'; break;
		case 'Saint David': $result_st='3'; break;
		case 'Saint George': $result_st='4'; break;
		case 'Saint John': $result_st='5'; break;
		case 'Saint Joseph': $result_st='6'; break;
		case 'Saint Luke': $result_st='7'; break;
		case 'Saint Mark': $result_st='8'; break;
		case 'Saint Patrick': $result_st='9'; break;
		case 'Saint Paul': $result_st='10'; break;
	  }
	}
	if($country=='Dominican Republic' || $country==$country_three){
	  switch($state){
		case 'Azua': $result_st='2'; break;
		case 'Baoruco': $result_st='3'; break;
		case 'Barahona': $result_st='4'; break;
		case 'Dajabon': $result_st='5'; break;
		case 'Distrito Nacional': $result_st='1'; break;
		case 'Duarte': $result_st='6'; break;
		case 'El Seibo': $result_st='8'; break;
		case 'Elias Pina': $result_st='7'; break;
		case 'Espaillat': $result_st='9'; break;
		case 'Hato Mayor': $result_st='30'; break;
		case 'Independencia': $result_st='10'; break;
		case 'La Altagracia': $result_st='11'; break;
		case 'La Romana': $result_st='12'; break;
		case 'La Vega': $result_st='13'; break;
		case 'Maria Trinidad Sanchez': $result_st='14'; break;
		case 'Monsenor Nouel': $result_st='28'; break;
		case 'Monte Cristi': $result_st='15'; break;
		case 'Monte Plata': $result_st='29'; break;
		case 'Pedernales': $result_st='16'; break;
		case 'Peravia': $result_st='17'; break;
		case 'Puerto Plata': $result_st='18'; break;
		case 'Salcedo': $result_st='19'; break;
		case 'Samana': $result_st='20'; break;
		case 'San Cristobal': $result_st='21'; break;
		case 'San Juan': $result_st='22'; break;
		case 'San Pedro De Macoris': $result_st='23'; break;
		case 'Sanchez Ramirez': $result_st='24'; break;
		case 'Santiago Rodriguez': $result_st='26'; break;
		case 'Santiago': $result_st='25'; break;
		case 'Valverde': $result_st='27'; break;
	  }
	}
	if($country=='East Timor' || $country==$country_three){
	  switch($state){
		case 'Timor-Leste': $result_st='TL'; break;
	  }
	}
	if($country=='Ecuador' || $country==$country_three){
	  switch($state){
		case 'Azuay': $result_st='A'; break;
		case 'Bolivar': $result_st='B'; break;
		case 'Canar': $result_st='F'; break;
		case 'Carchi': $result_st='C'; break;
		case 'Chimborazo': $result_st='H'; break;
		case 'Cotopaxi': $result_st='X'; break;
		case 'El Oro': $result_st='O'; break;
		case 'Esmeraldas': $result_st='E'; break;
		case 'Galapagos': $result_st='W'; break;
		case 'Guayas': $result_st='G'; break;
		case 'Imbabura': $result_st='I'; break;
		case 'Loja': $result_st='L'; break;
		case 'Los Rios': $result_st='R'; break;
		case 'Manabi': $result_st='M'; break;
		case 'Morona-Santiago': $result_st='S'; break;
		case 'Napo': $result_st='N'; break;
		case 'Orellana': $result_st='D'; break;
		case 'Pastaza': $result_st='Y'; break;
		case 'Pichincha': $result_st='P'; break;
		case 'Santa Elena': $result_st='SE'; break;
		case 'Sucumbios': $result_st='U'; break;
		case 'Tungurahua': $result_st='T'; break;
		case 'Zamora-Chinchipe': $result_st='Z'; break;
	  }
	}
	if($country=='Egypt' || $country==$country_three){
	  switch($state){
		case 'Ad Daqahliyah': $result_st='DK'; break;
		case 'Al Bahr al Ahmar': $result_st='BA'; break;
		case 'Al Buhayrah': $result_st='BH'; break;
		case 'Al Fayyum': $result_st='FYM'; break;
		case 'Al Gharbiyah': $result_st='GH'; break;
		case 'Al Iskandariyah': $result_st='ALX'; break;
		case 'Al Ismailiyah': $result_st='IS'; break;
		case 'Al Jizah': $result_st='GZ'; break;
		case 'Al Minufiyah': $result_st='MNF'; break;
		case 'Al Minya': $result_st='MN'; break;
		case 'Al Qahirah': $result_st='C'; break;
		case 'Al Qalyubiyah': $result_st='KB'; break;
		case 'Al Wadi al Jadid': $result_st='WAD'; break;
		case 'As Suways': $result_st='SUZ'; break;
		case 'Ash Sharqiyah': $result_st='SHR'; break;
		case 'Aswan': $result_st='ASN'; break;
		case 'Asyut': $result_st='AST'; break;
		case 'Bani Suwayf': $result_st='BNS'; break;
		case 'Bur Said': $result_st='PTS'; break;
		case 'Dumyat': $result_st='DT'; break;
		case 'Janub Sina': $result_st='JS'; break;
		case 'Kafr ash Shaykh': $result_st='KFS'; break;
		case 'Matruh': $result_st='MT'; break;
		case 'Muhafazat al Uqsur': $result_st='LX'; break;
		case 'Qina': $result_st='KN'; break;
		case 'Shamal Sina': $result_st='SIN'; break;
		case 'Suhaj': $result_st='SHG'; break;
	  }
	}
	if($country=='El Salvador' || $country==$country_three){
	  switch($state){
		case 'Ahuachapan': $result_st='AH'; break;
		case 'Cabanas': $result_st='CA'; break;
		case 'Chalatenango': $result_st='CH'; break;
		case 'Cuscatlan': $result_st='CU'; break;
		case 'La Libertad': $result_st='LI'; break;
		case 'La Paz': $result_st='PA'; break;
		case 'La Union': $result_st='UN'; break;
		case 'Morazan': $result_st='MO'; break;
		case 'San Miguel': $result_st='SM'; break;
		case 'San Salvador': $result_st='SS'; break;
		case 'San Vicente': $result_st='SV'; break;
		case 'Santa Ana': $result_st='SA'; break;
		case 'Sonsonate': $result_st='SO'; break;
		case 'Usulutan': $result_st='US'; break;
	  }
	}
	if($country=='Equatorial Guinea' || $country==$country_three){
	  switch($state){
		case 'Annobon': $result_st='AN'; break;
		case 'Bioko Norte': $result_st='BN'; break;
		case 'Bioko Sur': $result_st='BS'; break;
		case 'Centro Sur': $result_st='CS'; break;
		case 'Kie-Ntem': $result_st='KN'; break;
		case 'Litoral': $result_st='LI'; break;
		case 'Wele-Nzas': $result_st='WN'; break;
	  }
	}
	if($country=='Eritrea' || $country==$country_three){
	  switch($state){
		case 'Anseba': $result_st='AN'; break;
		case 'Debub': $result_st='DU'; break;
		case 'Debubawi Keyih Bahri': $result_st='DK'; break;
		case 'Gash Barka': $result_st='GB'; break;
		case 'Maakel': $result_st='MA'; break;
		case 'Semenawi Keyih Bahri': $result_st='SK'; break;
		case 'Harjumaa': $result_st='37'; break;
		case 'Hiiumaa': $result_st='39'; break;
		case 'Ida-Virumaa': $result_st='44'; break;
		case 'Jarvamaa': $result_st='51'; break;
		case 'Jogevamaa': $result_st='49'; break;
		case 'Laane-Virumaa': $result_st='59'; break;
		case 'Laanemaa': $result_st='57'; break;
		case 'Parnumaa': $result_st='67'; break;
		case 'Polvamaa': $result_st='65'; break;
		case 'Raplamaa': $result_st='70'; break;
		case 'Saaremaa': $result_st='74'; break;
		case 'Tartumaa': $result_st='78'; break;
		case 'Valgamaa': $result_st='82'; break;
		case 'Viljandimaa': $result_st='84'; break;
		case 'Vorumaa': $result_st='86'; break;
		case 'Adis Abeba': $result_st='AA'; break;
		case 'Afar': $result_st='AF'; break;
		case 'Amara': $result_st='AM'; break;
		case 'Binshangul Gumuz': $result_st='BE'; break;
		case 'Dire Dawa': $result_st='DD'; break;
		case 'Gambela Hizboch': $result_st='GA'; break;
		case 'Hareri Hizb': $result_st='HA'; break;
		case 'Oromiya': $result_st='OR'; break;
		case 'Sumale': $result_st='SO'; break;
		case 'Tigray': $result_st='TI'; break;
		case 'YeDebub Biheroch Bihereseboch na Hizboch': $result_st='SN'; break;
	  }
	}
	if($country=='Falkland Islands' || $country==$country_three){
	  switch($state){
		case 'Falkland Islands (Malvinas)': $result_st='FK'; break;
	  }
	}
	if($country=='Faroe Islands' || $country==$country_three){
	  switch($state){
		case 'Faroe Islands': $result_st='FO'; break;
	  }
	}
	if($country=='Federated States of Micronesia' || $country==$country_three){
	  switch($state){
		case 'Chuuk': $result_st='TRK'; break;
		case 'Kosrae': $result_st='KSA'; break;
		case 'Pohnpei': $result_st='PNI'; break;
		case 'Yap': $result_st='YAP'; break;
	  }
	}
	if($country=='Fiji' || $country==$country_three){
	  switch($state){
		case 'Central': $result_st='C'; break;
		case 'Northern': $result_st='N'; break;
		case 'Western': $result_st='W'; break;
	  }
	}
	if($country=='Finland' || $country==$country_three){
	  switch($state){
		case 'Ahvenanmaan maakunta': $result_st='1'; break;
		case 'Etela-Karjala': $result_st='2'; break;
		case 'Etela-Pohjanmaa': $result_st='3'; break;
		case 'Etela-Savo': $result_st='4'; break;
		case 'Kainuu': $result_st='5'; break;
		case 'Kanta-Hame': $result_st='6'; break;
		case 'Keski-Pohjanmaa': $result_st='7'; break;
		case 'Keski-Suomi': $result_st='8'; break;
		case 'Kymenlaakso': $result_st='9'; break;
		case 'Lappi': $result_st='10'; break;
		case 'Paijat-Hame': $result_st='16'; break;
		case 'Pirkanmaa': $result_st='11'; break;
		case 'Pohjanmaa': $result_st='12'; break;
		case 'Pohjois-Karjala': $result_st='13'; break;
		case 'Pohjois-Pohjanmaa': $result_st='14'; break;
		case 'Pohjois-Savo': $result_st='15'; break;
		case 'Satakunta': $result_st='17'; break;
		case 'Uusimaa': $result_st='18'; break;
		case 'Varsinais-Suomi': $result_st='19'; break;
	  }
	}
	if($country=='France' || $country==$country_three){
	  switch($state){
		case 'Alsace': $result_st='A'; break;
		case 'Aquitaine': $result_st='B'; break;
		case 'Auvergne': $result_st='C'; break;
		case 'Basse-Normandie': $result_st='P'; break;
		case 'Bourgogne': $result_st='D'; break;
		case 'Bretagne': $result_st='E'; break;
		case 'Centre': $result_st='F'; break;
		case 'Champagne-Ardenne': $result_st='G'; break;
		case 'Corse': $result_st='H'; break;
		case 'Franche-Comte': $result_st='I'; break;
		case 'Haute-Normandie': $result_st='Q'; break;
		case 'Ile-de-France': $result_st='J'; break;
		case 'Languedoc-Roussillon': $result_st='K'; break;
		case 'Limousin': $result_st='L'; break;
		case 'Lorraine': $result_st='M'; break;
		case 'Midi-Pyrenees': $result_st='N'; break;
		case 'Nord-Pas-de-Calais': $result_st='O'; break;
		case 'Pays de la Loire': $result_st='R'; break;
		case 'Picardie': $result_st='S'; break;
		case 'Poitou-Charentes': $result_st='T'; break;
		case 'Provence-Alpes-Cote dAzur': $result_st='U'; break;
		case 'Rhone-Alpes': $result_st='V'; break;
	  }
	}
	if($country=='French Guiana' || $country==$country_three){
	  switch($state){
		case 'French Guiana': $result_st='GF'; break;
	  }
	}
	if($country=='French Polynesia' || $country==$country_three){
	  switch($state){
		case 'French Polynesia': $result_st='PF'; break;
	  }
	}
	if($country=='French Southern Territories' || $country==$country_three){
	  switch($state){
		case 'French Southern Territories': $result_st='TF'; break;
	  }
	}
	if($country=='Gabon' || $country==$country_three){
	  switch($state){
		case 'Estuaire': $result_st='1'; break;
		case 'Haut-Ogooue': $result_st='2'; break;
		case 'Moyen-Ogooue': $result_st='3'; break;
		case 'Ngounie': $result_st='4'; break;
		case 'Nyanga': $result_st='5'; break;
		case 'Ogooue-Ivindo': $result_st='6'; break;
		case 'Ogooue-Lolo': $result_st='7'; break;
		case 'Ogooue-Maritime': $result_st='8'; break;
		case 'Woleu-Ntem': $result_st='9'; break;
	  }
	}
	if($country=='Gambia' || $country==$country_three){
	  switch($state){
		case 'Banjul': $result_st='B'; break;
		case 'Central River': $result_st='M'; break;
		case 'Lower River': $result_st='L'; break;
		case 'North Bank': $result_st='N'; break;
		case 'Upper River': $result_st='U'; break;
		case 'Western': $result_st='W'; break;
	  }
	}
	if($country=='Georgia' || $country==$country_three){
	  switch($state){
		case 'Abkhazia': $result_st='AB'; break;
		case 'Ajaria': $result_st='AJ'; break;
		case 'Akhalkalakis Raioni': $result_st='4'; break;
		case 'Baghdatis Raioni': $result_st='9'; break;
		case 'Borjomis Raioni': $result_st='11'; break;
		case 'Goris Raioni': $result_st='19'; break;
		case 'Guria': $result_st='GU'; break;
		case 'Imereti': $result_st='IM'; break;
		case 'Javis Raioni': $result_st='23'; break;
		case 'Karelis Raioni': $result_st='24'; break;
		case 'Kakheti': $result_st='KA'; break;
		case 'Khashuris Raioni': $result_st='28'; break;
		case 'Kvemo Kartli': $result_st='KK'; break;
		case 'Mtskheta-Mtianeti': $result_st='MM'; break;
		case 'Racha-Lechkhumi and Kvemo Svaneti': $result_st='RL'; break;
		case 'Samegrelo and Zemo Svaneti': $result_st='SZ'; break;
		case 'Samtskhe-Javakheti': $result_st='SJ'; break;
		case 'Shida Kartli': $result_st='SK'; break;
		case 'Tbilisi': $result_st='TBS'; break;
		case 'Vanis Raioni': $result_st='61'; break;
	  }
	}
	if($country=='Germany' || $country==$country_three){
	  switch($state){
		case 'Baden-Wurttemberg': $result_st='BW'; break;
		case 'Bayern': $result_st='BY'; break;
		case 'Berlin': $result_st='BE'; break;
		case 'Brandenburg': $result_st='BB'; break;
		case 'Bremen': $result_st='HB'; break;
		case 'Hamburg': $result_st='HH'; break;
		case 'Hessen': $result_st='HE'; break;
		case 'Mecklenburg-Vorpommern': $result_st='MV'; break;
		case 'Niedersachsen': $result_st='NI'; break;
		case 'Nordrhein-Westfalen': $result_st='NW'; break;
		case 'Rheinland-Pfalz': $result_st='RP'; break;
		case 'Saarland': $result_st='SL'; break;
		case 'Sachsen': $result_st='SN'; break;
		case 'Sachsen-Anhalt': $result_st='ST'; break;
		case 'Schleswig-Holstein': $result_st='SH'; break;
		case 'Thuringen': $result_st='TH'; break;
	  }
	}
	if($country=='Ghana' || $country==$country_three){
	  switch($state){
		case 'Ashanti': $result_st='AH'; break;
		case 'Brong-Ahafo': $result_st='BA'; break;
		case 'Central': $result_st='CP'; break;
		case 'Eastern': $result_st='EP'; break;
		case 'Greater Accra': $result_st='AA'; break;
		case 'Northern': $result_st='NP'; break;
		case 'Upper East': $result_st='UE'; break;
		case 'Upper West': $result_st='UW'; break;
		case 'Volta': $result_st='TV'; break;
		case 'Western': $result_st='WP'; break;
	  }
	}
	if($country=='Gibraltar' || $country==$country_three){
	  switch($state){
		case 'Gibraltar': $result_st='GI'; break;
	  }
	}
	if($country=='Greece' || $country==$country_three){
	  switch($state){
		case 'Aitolia kai Akarnania': $result_st='1'; break;
		case 'Akhaia': $result_st='13'; break;
		case 'Argolis': $result_st='11'; break;
		case 'Arkadhia': $result_st='12'; break;
		case 'Arta': $result_st='31'; break;
		case 'Attiki': $result_st='A1'; break;
		case 'Dhodhekanisos': $result_st='81'; break;
		case 'Drama': $result_st='52'; break;
		case 'Evritania': $result_st='5'; break;
		case 'Evros': $result_st='71'; break;
		case 'Evvoia': $result_st='4'; break;
		case 'Florina': $result_st='63'; break;
		case 'Fokis': $result_st='7'; break;
		case 'Fthiotis': $result_st='6'; break;
		case 'Grevena': $result_st='51'; break;
		case 'Ilia': $result_st='14'; break;
		case 'Imathia': $result_st='53'; break;
		case 'Ioannina': $result_st='33'; break;
		case 'Iraklion': $result_st='91'; break;
		case 'Kardhitsa': $result_st='41'; break;
		case 'Kastoria': $result_st='56'; break;
		case 'Kavala': $result_st='55'; break;
		case 'Kefallinia': $result_st='23'; break;
		case 'Kerkira': $result_st='22'; break;
		case 'Khalkidhiki': $result_st='64'; break;
		case 'Khania': $result_st='94'; break;
		case 'Khios': $result_st='85'; break;
		case 'Kikladhes': $result_st='82'; break;
		case 'Kilkis': $result_st='57'; break;
		case 'Korinthia': $result_st='15'; break;
		case 'Kozani': $result_st='58'; break;
		case 'Lakonia': $result_st='16'; break;
		case 'Larisa': $result_st='42'; break;
		case 'Lasithi': $result_st='92'; break;
		case 'Lesvos': $result_st='83'; break;
		case 'Levkas': $result_st='24'; break;
		case 'Magnisia': $result_st='43'; break;
		case 'Messinia': $result_st='17'; break;
		case 'Pella': $result_st='59'; break;
		case 'Pieria': $result_st='61'; break;
		case 'Preveza': $result_st='34'; break;
		case 'Rethimni': $result_st='93'; break;
		case 'Rodhopi': $result_st='73'; break;
		case 'Samos': $result_st='84'; break;
		case 'Serrai': $result_st='62'; break;
		case 'Thesprotia': $result_st='32'; break;
		case 'Thessaloniki': $result_st='54'; break;
		case 'Trikala': $result_st='44'; break;
		case 'Voiotia': $result_st='3'; break;
		case 'Xanthi': $result_st='72'; break;
		case 'Zakinthos': $result_st='21'; break;
	  }
	}
	if($country=='Greenland' || $country==$country_three){
	  switch($state){
		case 'Kujalleq': $result_st='KU'; break;
		case 'Qaasuitsup': $result_st='QA'; break;
		case 'Qeqqata': $result_st='QE'; break;
		case 'Sermersooq': $result_st='SM'; break;
	  }
	}
	if($country=='Grenada' || $country==$country_three){
	  switch($state){
		case 'Saint Andrew': $result_st='1'; break;
		case 'Saint David': $result_st='2'; break;
		case 'Saint George': $result_st='3'; break;
		case 'Saint John': $result_st='4'; break;
		case 'Saint Mark': $result_st='5'; break;
		case 'Saint Patrick': $result_st='6'; break;
	  }
	}
	if($country=='Guadeloupe' || $country==$country_three){
	  switch($state){
		case 'Guadeloupe': $result_st='GP'; break;
	  }
	}
	if($country=='Guam' || $country==$country_three){
	  switch($state){
		case 'Guam': $result_st='GU'; break;
	  }
	}
	if($country=='Guatemala' || $country==$country_three){
	  switch($state){
		case 'Alta Verapaz': $result_st='AV'; break;
		case 'Baja Verapaz': $result_st='BV'; break;
		case 'Chimaltenango': $result_st='CM'; break;
		case 'Chiquimula': $result_st='CQ'; break;
		case 'El Progreso': $result_st='PR'; break;
		case 'Escuintla': $result_st='ES'; break;
		case 'Guatemala': $result_st='GU'; break;
		case 'Huehuetenango': $result_st='HU'; break;
		case 'Izabal': $result_st='IZ'; break;
		case 'Jalapa': $result_st='JA'; break;
		case 'Jutiapa': $result_st='JU'; break;
		case 'Peten': $result_st='PE'; break;
		case 'Quetzaltenango': $result_st='QZ'; break;
		case 'Quiche': $result_st='QC'; break;
		case 'Retalhuleu': $result_st='RE'; break;
		case 'Sacatepequez': $result_st='SA'; break;
		case 'San Marcos': $result_st='SM'; break;
		case 'Santa Rosa': $result_st='SR'; break;
		case 'Solola': $result_st='SO'; break;
		case 'Suchitepequez': $result_st='SU'; break;
		case 'Totonicapan': $result_st='TO'; break;
		case 'Zacapa': $result_st='ZA'; break;
	  }
	}
	if($country=='Guernsey' || $country==$country_three){
	  switch($state){
		case 'Guernsey': $result_st='GG'; break;
	  }
	}
	if($country=='Guinea' || $country==$country_three){
	  switch($state){
		case 'Beyla': $result_st='BE'; break;
		case 'Boffa': $result_st='BF'; break;
		case 'Boke': $result_st='BK'; break;
		case 'Conakry': $result_st='C'; break;
		case 'Coyah': $result_st='CO'; break;
		case 'Dabola': $result_st='DB'; break;
		case 'Dalaba': $result_st='DL'; break;
		case 'Dinguiraye': $result_st='DI'; break;
		case 'Dubreka': $result_st='DU'; break;
		case 'Faranah': $result_st='FA'; break;
		case 'Forecariah': $result_st='FO'; break;
		case 'Fria': $result_st='FR'; break;
		case 'Gaoual': $result_st='GA'; break;
		case 'Gueckedou': $result_st='GU'; break;
		case 'Kankan': $result_st='KA'; break;
		case 'Kerouane': $result_st='KE'; break;
		case 'Kindia': $result_st='KD'; break;
		case 'Kissidougou': $result_st='KS'; break;
		case 'Koubia': $result_st='KB'; break;
		case 'Koundara': $result_st='KN'; break;
		case 'Kouroussa': $result_st='KO'; break;
		case 'Labe': $result_st='LA'; break;
		case 'Lelouma': $result_st='LE'; break;
		case 'Lola': $result_st='LO'; break;
		case 'Macenta': $result_st='MC'; break;
		case 'Mali': $result_st='ML'; break;
		case 'Mamou': $result_st='MM'; break;
		case 'Mandiana': $result_st='MD'; break;
		case 'Nzerekore': $result_st='NZ'; break;
		case 'Pita': $result_st='PI'; break;
		case 'Siguiri': $result_st='SI'; break;
		case 'Telimele': $result_st='TE'; break;
		case 'Tougue': $result_st='TO'; break;
		case 'Yomou': $result_st='YO'; break;
	  }
	}
	if($country=='Guinea-Bissau' || $country==$country_three){
	  switch($state){
		case 'Bafata': $result_st='BA'; break;
		case 'Biombo': $result_st='BM'; break;
		case 'Bissau': $result_st='BS'; break;
		case 'Bolama': $result_st='BL'; break;
		case 'Cacheu': $result_st='CA'; break;
		case 'Gabu': $result_st='GA'; break;
		case 'Oio': $result_st='OI'; break;
		case 'Quinara': $result_st='QU'; break;
		case 'Tombali': $result_st='TO'; break;
	  }
	}
	if($country=='Guyana' || $country==$country_three){
	  switch($state){
		case 'Cuyuni-Mazaruni': $result_st='CU'; break;
		case 'Demerara-Mahaica': $result_st='DE'; break;
		case 'East Berbice-Corentyne': $result_st='EB'; break;
		case 'Essequibo Islands-West Demerara': $result_st='ES'; break;
		case 'Mahaica-Berbice': $result_st='MA'; break;
		case 'Pomeroon-Supenaam': $result_st='PM'; break;
		case 'Upper Demerara-Berbice': $result_st='UD'; break;
	  }
	}
	if($country=='Haiti' || $country==$country_three){
	  switch($state){
		case 'Artibonite': $result_st='AR'; break;
		case 'Centre': $result_st='CE'; break;
		case 'Grand Anse': $result_st='GA'; break;
		case 'Nippes': $result_st='NI'; break;
		case 'Nord': $result_st='ND'; break;
		case 'Nord-Est': $result_st='NE'; break;
		case 'Nord-Ouest': $result_st='NO'; break;
		case 'Ouest': $result_st='OU'; break;
		case 'Sud': $result_st='SD'; break;
		case 'Sud-Est': $result_st='SE'; break;
	  }
	}
	if($country=='Hashemite Kingdom of Jordan' || $country==$country_three){
	  switch($state){
		case 'Amman': $result_st='AM'; break;
		case 'Al Aqabah': $result_st='AQ'; break;
		case 'Al Balqa': $result_st='BA'; break;
		case 'Al Karak': $result_st='KA'; break;
		case 'Al Mafraq': $result_st='MA'; break;
		case 'At Tafilah': $result_st='AT'; break;
		case 'Az Zarqa': $result_st='AZ'; break;
		case 'Irbid': $result_st='IR'; break;
		case 'Maan': $result_st='MN'; break;
		case 'Madaba': $result_st='MD'; break;
	  }
	}
	if($country=='Honduras' || $country==$country_three){
	  switch($state){
		case 'Atlantida': $result_st='AT'; break;
		case 'Choluteca': $result_st='CH'; break;
		case 'Colon': $result_st='CL'; break;
		case 'Comayagua': $result_st='CM'; break;
		case 'Copan': $result_st='CP'; break;
		case 'Cortes': $result_st='CR'; break;
		case 'El Paraiso': $result_st='EP'; break;
		case 'Francisco Morazan': $result_st='FM'; break;
		case 'Gracias a Dios': $result_st='GD'; break;
		case 'Intibuca': $result_st='IN'; break;
		case 'Islas de la Bahia': $result_st='IB'; break;
		case 'La Paz': $result_st='LP'; break;
		case 'Lempira': $result_st='LE'; break;
		case 'Ocotepeque': $result_st='OC'; break;
		case 'Olancho': $result_st='OL'; break;
		case 'Santa Barbara': $result_st='SB'; break;
		case 'Valle': $result_st='VA'; break;
		case 'Yoro': $result_st='YO'; break;
	  }
	}
	if($country=='Hong Kong' || $country==$country_three){
	  switch($state){
		case 'Hong Kong': $result_st='HK'; break;
	  }
	}
	if($country=='Hungary' || $country==$country_three){
	  switch($state){
		case 'Bacs-Kiskun': $result_st='BK'; break;
		case 'Baranya': $result_st='BA'; break;
		case 'Bekes': $result_st='BE'; break;
		case 'Borsod-Abauj-Zemplen': $result_st='BZ'; break;
		case 'Budapest': $result_st='BU'; break;
		case 'Csongrad': $result_st='CS'; break;
		case 'Fejer': $result_st='FE'; break;
		case 'Gyor-Moson-Sopron': $result_st='GS'; break;
		case 'Hajdu-Bihar': $result_st='HB'; break;
		case 'Heves': $result_st='HE'; break;
		case 'Jasz-Nagykun-Szolnok': $result_st='JN'; break;
		case 'Komarom-Esztergom': $result_st='KE'; break;
		case 'Nograd': $result_st='NO'; break;
		case 'Pest': $result_st='PE'; break;
		case 'Somogy': $result_st='SO'; break;
		case 'Szabolcs-Szatmar-Bereg': $result_st='SZ'; break;
		case 'Tolna': $result_st='TO'; break;
		case 'Vas': $result_st='VA'; break;
		case 'Veszprem': $result_st='VE'; break;
		case 'Zala': $result_st='ZA'; break;
	  }
	}
	if($country=='Iceland' || $country==$country_three){
	  switch($state){
		case 'Austurland': $result_st='7'; break;
		case 'Hofuoborgarsvaoio': $result_st='1'; break;
		case 'Norourland Eystra': $result_st='6'; break;
		case 'Norourland Vestra': $result_st='5'; break;
		case 'Suourland': $result_st='8'; break;
		case 'Suournes': $result_st='2'; break;
		case 'Vestfiroir': $result_st='4'; break;
		case 'Vesturland': $result_st='3'; break;
	  }
	}
	if($country=='India' || $country==$country_three){
	  switch($state){
		case 'Andaman and Nicobar Islands': $result_st='AN'; break;
		case 'Andhra Pradesh': $result_st='AP'; break;
		case 'Arunachal Pradesh': $result_st='AR'; break;
		case 'Assam': $result_st='AS'; break;
		case 'Bihar': $result_st='BR'; break;
		case 'Chandigarh': $result_st='CH'; break;
		case 'Chhattisgarh': $result_st='CT'; break;
		case 'Dadra and Nagar Haveli': $result_st='DN'; break;
		case 'Daman and Diu': $result_st='DD'; break;
		case 'Delhi': $result_st='DL'; break;
		case 'Goa': $result_st='GA'; break;
		case 'Gujarat': $result_st='GJ'; break;
		case 'Haryana': $result_st='HR'; break;
		case 'Himachal Pradesh': $result_st='HP'; break;
		case 'Jammu and Kashmir': $result_st='JK'; break;
		case 'Jharkhand': $result_st='JH'; break;
		case 'Karnataka': $result_st='KA'; break;
		case 'Kerala': $result_st='KL'; break;
		case 'Lakshadweep': $result_st='LD'; break;
		case 'Madhya Pradesh': $result_st='MP'; break;
		case 'Maharashtra': $result_st='MH'; break;
		case 'Manipur': $result_st='MN'; break;
		case 'Meghalaya': $result_st='ML'; break;
		case 'Mizoram': $result_st='MZ'; break;
		case 'Nagaland': $result_st='NL'; break;
		case 'Orissa': $result_st='OR'; break;
		case 'Puducherry': $result_st='PY'; break;
		case 'Punjab': $result_st='PB'; break;
		case 'Rajasthan': $result_st='RJ'; break;
		case 'Sikkim': $result_st='SK'; break;
		case 'Tamil Nadu': $result_st='TN'; break;
		case 'Telangana': $result_st='TG'; break;
		case 'Tripura': $result_st='TR'; break;
		case 'Uttar Pradesh': $result_st='UP'; break;
		case 'Uttarakhand': $result_st='UT'; break;
		case 'West Bengal': $result_st='WB'; break;
	  }
	}
	if($country=='Indonesia' || $country==$country_three){
	  switch($state){
		case 'Aceh': $result_st='AC'; break;
		case 'Bali': $result_st='BA'; break;
		case 'Banten': $result_st='BT'; break;
		case 'Bengkulu': $result_st='BE'; break;
		case 'Gorontalo': $result_st='GO'; break;
		case 'Jakarta Raya': $result_st='JK'; break;
		case 'Jambi': $result_st='JA'; break;
		case 'Jawa Barat': $result_st='JB'; break;
		case 'Jawa Tengah': $result_st='JT'; break;
		case 'Jawa Timur': $result_st='JI'; break;
		case 'Kalimantan Barat': $result_st='KB'; break;
		case 'Kalimantan Selatan': $result_st='KS'; break;
		case 'Kalimantan Tengah': $result_st='KT'; break;
		case 'Kalimantan Timur': $result_st='KI'; break;
		case 'Kepulauan Bangka Belitung': $result_st='BB'; break;
		case 'Kepulauan Riau': $result_st='KR'; break;
		case 'Lampung': $result_st='LA'; break;
		case 'Maluku Utara': $result_st='MU'; break;
		case 'Maluku': $result_st='MA'; break;
		case 'Nusa Tenggara Barat': $result_st='NB'; break;
		case 'Nusa Tenggara Timur': $result_st='NT'; break;
		case 'Papua': $result_st='PA'; break;
		case 'Papua Barat': $result_st='PB'; break;
		case 'Riau': $result_st='RI'; break;
		case 'Sulawesi Barat': $result_st='SR'; break;
		case 'Sulawesi Selatan': $result_st='SN'; break;
		case 'Sulawesi Tengah': $result_st='ST'; break;
		case 'Sulawesi Tenggara': $result_st='SG'; break;
		case 'Sulawesi Utara': $result_st='SA'; break;
		case 'Sumatera Barat': $result_st='SB'; break;
		case 'Sumatera Selatan': $result_st='SS'; break;
		case 'Sumatera Utara': $result_st='SU'; break;
		case 'Yogyakarta': $result_st='YO'; break;
	  }
	}
	if($country=='Iran' || $country==$country_three){
	  switch($state){
		case 'Alborz': $result_st='32'; break;
		case 'Ardabil': $result_st='3'; break;
		case 'Azarbayjan-e Sharqi': $result_st='1'; break;
		case 'Bushehr': $result_st='6'; break;
		case 'Chahar Mahall va Bakhtiari': $result_st='8'; break;
		case 'Esfahan': $result_st='4'; break;
		case 'Fars': $result_st='14'; break;
		case 'Gilan': $result_st='19'; break;
		case 'Golestan': $result_st='27'; break;
		case 'Hamadan': $result_st='24'; break;
		case 'Hormozgan': $result_st='23'; break;
		case 'Ilam': $result_st='5'; break;
		case 'Kerman': $result_st='15'; break;
		case 'Kermanshah': $result_st='17'; break;
		case 'Khorasan-e Janubi': $result_st='29'; break;
		case 'Khorasan-e Razavi': $result_st='30'; break;
		case 'Khorasan-e Shemali': $result_st='31'; break;
		case 'Khuzestan': $result_st='10'; break;
		case 'Kohkiluyeh va Buyer Ahmadi': $result_st='18'; break;
		case 'Kordestan': $result_st='16'; break;
		case 'Lorestan': $result_st='20'; break;
		case 'Markazi': $result_st='22'; break;
		case 'Mazandaran': $result_st='21'; break;
		case 'Ostan-e Azarbayjan-e Gharbi': $result_st='2'; break;
		case 'Qazvin': $result_st='28'; break;
		case 'Qom': $result_st='26'; break;
		case 'Semnan': $result_st='12'; break;
		case 'Sistan va Baluchestan': $result_st='13'; break;
		case 'Tehran': $result_st='7'; break;
		case 'Yazd': $result_st='25'; break;
		case 'Zanjan': $result_st='11'; break;
		case 'Al Anbar': $result_st='AN'; break;
		case 'Al Basrah': $result_st='BA'; break;
		case 'Al Muthanna': $result_st='MU'; break;
		case 'Al Qadisiyah': $result_st='QA'; break;
		case 'An Najaf': $result_st='NA'; break;
		case 'Arbil': $result_st='AR'; break;
		case 'As Sulaymaniyah': $result_st='SU'; break;
		case 'At Tamim': $result_st='TS'; break;
		case 'Babil': $result_st='BB'; break;
		case 'Baghdad': $result_st='BG'; break;
		case 'Dahuk': $result_st='DA'; break;
		case 'Dhi Qar': $result_st='DQ'; break;
		case 'Diyala': $result_st='DI'; break;
		case 'Karbala': $result_st='KA'; break;
		case 'Maysan': $result_st='MA'; break;
		case 'Ninawa': $result_st='NI'; break;
		case 'Salah ad Din': $result_st='SD'; break;
		case 'Wasit': $result_st='WA'; break;
	  }
	}
	if($country=='Ireland' || $country==$country_three){
	  switch($state){
		case 'Carlow': $result_st='CW'; break;
		case 'Cavan': $result_st='CN'; break;
		case 'Clare': $result_st='CE'; break;
		case 'Cork': $result_st='CO'; break;
		case 'Donegal': $result_st='DL'; break;
		case 'Dublin': $result_st='D'; break;
		case 'Galway': $result_st='G'; break;
		case 'Kerry': $result_st='KY'; break;
		case 'Kildare': $result_st='KE'; break;
		case 'Kilkenny': $result_st='KK'; break;
		case 'Laois': $result_st='LS'; break;
		case 'Leitrim': $result_st='LM'; break;
		case 'Limerick': $result_st='LK'; break;
		case 'Longford': $result_st='LD'; break;
		case 'Louth': $result_st='LH'; break;
		case 'Mayo': $result_st='MO'; break;
		case 'Meath': $result_st='MH'; break;
		case 'Monaghan': $result_st='MN'; break;
		case 'Offaly': $result_st='OY'; break;
		case 'Roscommon': $result_st='RN'; break;
		case 'Sligo': $result_st='SO'; break;
		case 'Tipperary': $result_st='TA'; break;
		case 'Waterford': $result_st='WD'; break;
		case 'Westmeath': $result_st='WH'; break;
		case 'Wexford': $result_st='WX'; break;
		case 'Wicklow': $result_st='WW'; break;
	  }
	}
	if($country=='Isle of Man' || $country==$country_three){
	  switch($state){
		case 'Isle of Man': $result_st='IM'; break;
	  }
	}
	if($country=='Israel' || $country==$country_three){
	  switch($state){
		case 'HaDarom': $result_st='D'; break;
		case 'HaMerkaz': $result_st='M'; break;
		case 'HaZafon': $result_st='Z'; break;
		case 'Hefa': $result_st='HA'; break;
		case 'Tel Aviv': $result_st='TA'; break;
		case 'Yerushalayim': $result_st='JM'; break;
	  }
	}
	if($country=='Italy' || $country==$country_three){
	  switch($state){
		case 'Abruzzi': $result_st='65'; break;
		case 'Basilicata': $result_st='77'; break;
		case 'Calabria': $result_st='78'; break;
		case 'Campania': $result_st='72'; break;
		case 'Emilia-Romagna': $result_st='45'; break;
		case 'Friuli-Venezia Giulia': $result_st='36'; break;
		case 'Lazio': $result_st='62'; break;
		case 'Liguria': $result_st='42'; break;
		case 'Lombardia': $result_st='25'; break;
		case 'Marche': $result_st='57'; break;
		case 'Molise': $result_st='67'; break;
		case 'Piemonte': $result_st='21'; break;
		case 'Puglia': $result_st='75'; break;
		case 'Sardegna': $result_st='88'; break;
		case 'Sicilia': $result_st='82'; break;
		case 'Toscana': $result_st='52'; break;
		case 'Trentino-Alto Adige': $result_st='32'; break;
		case 'Umbria': $result_st='55'; break;
		case 'Valle dAosta': $result_st='23'; break;
		case 'Veneto': $result_st='34'; break;
	  }
	}
	if($country=='Ivory Coast' || $country==$country_three){
	  switch($state){
		case 'Agneby': $result_st='16'; break;
		case 'Bafing': $result_st='17'; break;
		case 'Bas-Sassandra': $result_st='9'; break;
		case 'Denguele': $result_st='10'; break;
		case 'Dix-Huit Montagnes': $result_st='6'; break;
		case 'Fromager': $result_st='18'; break;
		case 'Haut-Sassandra': $result_st='2'; break;
		case 'Lacs': $result_st='7'; break;
		case 'Lagunes': $result_st='1'; break;
		case 'Marahoue': $result_st='12'; break;
		case 'Moyen-Cavally': $result_st='19'; break;
		case 'Moyen-Comoe': $result_st='5'; break;
		case 'Nzi-Comoe': $result_st='11'; break;
		case 'Savanes': $result_st='3'; break;
		case 'Sud-Bandama': $result_st='15'; break;
		case 'Sud-Comoe': $result_st='13'; break;
		case 'Vallee du Bandama': $result_st='4'; break;
		case 'Worodougou': $result_st='14'; break;
		case 'Zanzan': $result_st='8'; break;
	  }
	}
	if($country=='Jamaica' || $country==$country_three){
	  switch($state){
		case 'Clarendon': $result_st='13'; break;
		case 'Hanover': $result_st='9'; break;
		case 'Kingston': $result_st='1'; break;
		case 'Manchester': $result_st='12'; break;
		case 'Portland': $result_st='4'; break;
		case 'Saint Andrew': $result_st='2'; break;
		case 'Saint Ann': $result_st='6'; break;
		case 'Saint Catherine': $result_st='14'; break;
		case 'Saint Elizabeth': $result_st='11'; break;
		case 'Saint James': $result_st='8'; break;
		case 'Saint Mary': $result_st='5'; break;
		case 'Saint Thomas': $result_st='3'; break;
		case 'Trelawny': $result_st='7'; break;
		case 'Westmoreland': $result_st='10'; break;
	  }
	}
	if($country=='Japan' || $country==$country_three){
	  switch($state){
		case 'Aichi': $result_st='23'; break;
		case 'Akita': $result_st='5'; break;
		case 'Aomori': $result_st='2'; break;
		case 'Chiba': $result_st='12'; break;
		case 'Ehime': $result_st='38'; break;
		case 'Fukui': $result_st='18'; break;
		case 'Fukuoka': $result_st='40'; break;
		case 'Fukushima': $result_st='7'; break;
		case 'Gifu': $result_st='21'; break;
		case 'Gumma': $result_st='10'; break;
		case 'Hiroshima': $result_st='34'; break;
		case 'Hokkaido': $result_st='1'; break;
		case 'Hyogo': $result_st='28'; break;
		case 'Ibaraki': $result_st='8'; break;
		case 'Ishikawa': $result_st='17'; break;
		case 'Iwate': $result_st='3'; break;
		case 'Kagawa': $result_st='37'; break;
		case 'Kagoshima': $result_st='46'; break;
		case 'Kanagawa': $result_st='14'; break;
		case 'Kochi': $result_st='39'; break;
		case 'Kumamoto': $result_st='43'; break;
		case 'Kyoto': $result_st='26'; break;
		case 'Mie': $result_st='24'; break;
		case 'Miyagi': $result_st='4'; break;
		case 'Miyazaki': $result_st='45'; break;
		case 'Nagano': $result_st='20'; break;
		case 'Nagasaki': $result_st='42'; break;
		case 'Nara': $result_st='29'; break;
		case 'Niigata': $result_st='15'; break;
		case 'Oita': $result_st='44'; break;
		case 'Okayama': $result_st='33'; break;
		case 'Okinawa': $result_st='47'; break;
		case 'Osaka': $result_st='27'; break;
		case 'Saga': $result_st='41'; break;
		case 'Saitama': $result_st='11'; break;
		case 'Shiga': $result_st='25'; break;
		case 'Shimane': $result_st='32'; break;
		case 'Shizuoka': $result_st='22'; break;
		case 'Tochigi': $result_st='9'; break;
		case 'Tokushima': $result_st='36'; break;
		case 'Tokyo': $result_st='13'; break;
		case 'Tottori': $result_st='31'; break;
		case 'Toyama': $result_st='16'; break;
		case 'Wakayama': $result_st='30'; break;
		case 'Yamagata': $result_st='6'; break;
		case 'Yamaguchi': $result_st='35'; break;
		case 'Yamanashi': $result_st='19'; break;
	  }
	}
	if($country=='Jersey' || $country==$country_three){
	  switch($state){
		case 'Jersey': $result_st='JE'; break;
	  }
	}
	if($country=='Kazakhstan' || $country==$country_three){
	  switch($state){
		case 'Almaty': $result_st='ALA'; break;
		case 'Astana': $result_st='AST'; break;
		case 'Almaty oblysy': $result_st='ALM'; break;
		case 'Aqmola oblysy': $result_st='AKM'; break;
		case 'Aqtobe oblysy': $result_st='AKT'; break;
		case 'Atyrau oblysy': $result_st='ATY'; break;
		case 'Bayqonyr': $result_st='ZAP'; break;
		case 'Batys Qazaqstan oblysy': $result_st='ZAP'; break;
		case 'Mangghystau oblysy': $result_st='MAN'; break;
		case 'Ongtustik Qazaqstan oblysy': $result_st='YUZ'; break;
		case 'Pavlodar oblysy': $result_st='PAV'; break;
		case 'Qaraghandy oblysy': $result_st='KAR'; break;
		case 'Qostanay oblysy': $result_st='KUS'; break;
		case 'Qyzylorda oblysy': $result_st='KZY'; break;
		case 'Shyghys Qazaqstan oblysy': $result_st='VOS'; break;
		case 'Soltustik Qazaqstan oblysy': $result_st='SEV'; break;
		case 'Zhambyl oblysy': $result_st='ZHA'; break;
	  }
	}
	if($country=='Kenya' || $country==$country_three){
	  switch($state){
		case 'Central': $result_st='200'; break;
		case 'Coast': $result_st='300'; break;
		case 'Eastern': $result_st='400'; break;
		case 'Nairobi Area': $result_st='110'; break;
		case 'North-Eastern': $result_st='500'; break;
		case 'Nyanza': $result_st='600'; break;
		case 'Rift Valley': $result_st='700'; break;
		case 'Western': $result_st='800'; break;
	  }
	}
	if($country=='Kiribati' || $country==$country_three){
	  switch($state){
		case 'Gilbert Islands': $result_st='G'; break;
		case 'Line Islands': $result_st='L'; break;
	  }
	}
	if($country=='Kuwait' || $country==$country_three){
	  switch($state){
		case 'Al Ahmadi': $result_st='AH'; break;
		case 'Al Asimah': $result_st='KU'; break;
		case 'Al Farwaniyah': $result_st='FA'; break;
		case 'Al Jahra': $result_st='JA'; break;
		case 'Hawalli': $result_st='HA'; break;
		case 'Mubarak al Kabir': $result_st='MU'; break;
	  }
	}
	if($country=='Kyrgyzstan' || $country==$country_three){
	  switch($state){
		case 'Batken': $result_st='B'; break;
		case 'Bishkek': $result_st='GB'; break;
		case 'Chuy': $result_st='C'; break;
		case 'Jalal-Abad': $result_st='J'; break;
		case 'Naryn': $result_st='N'; break;
		case 'Osh': $result_st='O'; break;
		case 'Talas': $result_st='T'; break;
		case 'Ysyk-Kol': $result_st='Y'; break;
	  }
	}
	if($country=='Laos' || $country==$country_three){
	  switch($state){
		case 'Attapu': $result_st='AT'; break;
		case 'Bokeo': $result_st='BK'; break;
		case 'Bolikhamxai': $result_st='BL'; break;
		case 'Champasak': $result_st='CH'; break;
		case 'Houaphan': $result_st='HO'; break;
		case 'Khammouan': $result_st='KH'; break;
		case 'Louang Namtha': $result_st='LM'; break;
		case 'Louangphabang': $result_st='LP'; break;
		case 'Oudomxai': $result_st='OU'; break;
		case 'Phongsali': $result_st='PH'; break;
		case 'Salavan': $result_st='SL'; break;
		case 'Savannakhet': $result_st='SV'; break;
		case 'Vientiane': $result_st='VI'; break;
		case 'Vientiane': $result_st='VT'; break;
		case 'Xaignabouli': $result_st='XA'; break;
		case 'Xaisomboun': $result_st='XS'; break;
		case 'Xekong': $result_st='XE'; break;
		case 'Xiangkhouang': $result_st='XI'; break;
	  }
	}
	if($country=='Latvia' || $country==$country_three){
	  switch($state){
		case 'Adazu': $result_st='11'; break;
		case 'Aglonas': $result_st='1'; break;
		case 'Aizkraukles': $result_st='2'; break;
		case 'Aizputes': $result_st='3'; break;
		case 'Alojas': $result_st='5'; break;
		case 'Aluksnes': $result_st='7'; break;
		case 'Babites': $result_st='12'; break;
		case 'Baltinavas': $result_st='14'; break;
		case 'Balvu': $result_st='15'; break;
		case 'Bauskas': $result_st='16'; break;
		case 'Beverinas': $result_st='17'; break;
		case 'Brocenu': $result_st='18'; break;
		case 'Carnikavas': $result_st='20'; break;
		case 'Cesu': $result_st='22'; break;
		case 'Cesvaines': $result_st='21'; break;
		case 'Ciblas': $result_st='23'; break;
		case 'Daugavpils': $result_st='25'; break;
		case 'Dobeles': $result_st='26'; break;
		case 'Dundagas': $result_st='27'; break;
		case 'Gulbenes': $result_st='33'; break;
		case 'Iecavas': $result_st='34'; break;
		case 'Incukalna': $result_st='37'; break;
		case 'Jaunjelgavas': $result_st='38'; break;
		case 'Jaunpiebalgas': $result_st='39'; break;
		case 'Jaunpils': $result_st='40'; break;
		case 'Jekabpils': $result_st='42'; break;
		case 'Jelgava': $result_st='JEL'; break;
		case 'Jelgavas': $result_st='41'; break;
		case 'Jurmala': $result_st='JUR'; break;
		case 'Kekavas': $result_st='52'; break;
		case 'Kokneses': $result_st='46'; break;
		case 'Kraslavas': $result_st='47'; break;
		case 'Kuldigas': $result_st='50'; break;
		case 'Liepaja': $result_st='LPX'; break;
		case 'Liepajas': $result_st='LE'; break;
		case 'Limbazu': $result_st='LM'; break;
		case 'Lubanas': $result_st='57'; break;
		case 'Ludzas': $result_st='58'; break;
		case 'Madonas': $result_st='59'; break;
		case 'Malpils': $result_st='61'; break;
		case 'Ogres': $result_st='67'; break;
		case 'Olaines': $result_st='68'; break;
		case 'Ozolnieku': $result_st='69'; break;
		case 'Preilu': $result_st='73'; break;
		case 'Rezeknes': $result_st='77'; break;
		case 'Riga': $result_st='RIX'; break;
		case 'Rigas': $result_st='RI'; break;
		case 'Rojas': $result_st='79'; break;
		case 'Ropazu': $result_st='80'; break;
		case 'Rugaju': $result_st='82'; break;
		case 'Rundales': $result_st='83'; break;
		case 'Salacgrivas': $result_st='86'; break;
		case 'Saldus': $result_st='88'; break;
		case 'Sejas': $result_st='90'; break;
		case 'Siguldas': $result_st='91'; break;
		case 'Skrundas': $result_st='93'; break;
		case 'Stopinu': $result_st='95'; break;
		case 'Strencu': $result_st='96'; break;
		case 'Talsu': $result_st='97'; break;
		case 'Tukuma': $result_st='99'; break;
		case 'Vainodes': $result_st='100'; break;
		case 'Valkas': $result_st='101'; break;
		case 'Valmieras': $result_st='VM'; break;
		case 'Varkavas': $result_st='103'; break;
		case 'Vecumnieku': $result_st='105'; break;
		case 'Ventspils': $result_st='106'; break;
	  }
	}
	if($country=='Lebanon' || $country==$country_three){
	  switch($state){
		case 'Aakk': $result_st='AK'; break;
		case 'Baalbek-Hermel': $result_st='BH'; break;
		case 'Beqaa': $result_st='BI'; break;
		case 'Beyrouth': $result_st='BA'; break;
		case 'Liban-Nord': $result_st='AS'; break;
		case 'Liban-Sud': $result_st='JA'; break;
		case 'Mont-Liban': $result_st='JL'; break;
		case 'Nabatiye': $result_st='NA'; break;
		case 'Berea': $result_st='D'; break;
		case 'Butha-Buthe': $result_st='B'; break;
		case 'Leribe': $result_st='C'; break;
		case 'Mafeteng': $result_st='E'; break;
		case 'Maseru': $result_st='A'; break;
		case 'Mohales Hoek': $result_st='F'; break;
		case 'Mokhotlong': $result_st='J'; break;
		case 'Qachas Nek': $result_st='H'; break;
		case 'Quthing': $result_st='G'; break;
		case 'Thaba-Tseka': $result_st='K'; break;
	  }
	}
	if($country=='Liberia' || $country==$country_three){
	  switch($state){
		case 'Bomi': $result_st='BM'; break;
		case 'Bong': $result_st='BG'; break;
		case 'Gbarpolu': $result_st='GP'; break;
		case 'Grand Bassa': $result_st='GB'; break;
		case 'Grand Cape Mount': $result_st='CM'; break;
		case 'Grand Gedeh': $result_st='GG'; break;
		case 'Grand Kru': $result_st='GK'; break;
		case 'Lofa': $result_st='LO'; break;
		case 'Margibi': $result_st='MG'; break;
		case 'Maryland': $result_st='MY'; break;
		case 'Montserrado': $result_st='MO'; break;
		case 'Nimba': $result_st='NI'; break;
		case 'River Cess': $result_st='RI'; break;
		case 'River Gee': $result_st='RG'; break;
		case 'Sino': $result_st='SI'; break;
	  }
	}
	if($country=='Libya' || $country==$country_three){
	  switch($state){
		case 'Al Butnan': $result_st='BU'; break;
		case 'Al Jabal al Akhdar': $result_st='JA'; break;
		case 'Al Jabal al Gharbi': $result_st='JG'; break;
		case 'Al Jifarah': $result_st='JI'; break;
		case 'Al Jufrah': $result_st='JU'; break;
		case 'Al Kufrah': $result_st='KF'; break;
		case 'Al Marj': $result_st='MJ'; break;
		case 'Al Marqab': $result_st='MB'; break;
		case 'Al Wahat': $result_st='WA'; break;
		case 'An Nuqat al Khams': $result_st='NQ'; break;
		case 'Az Zawiyah': $result_st='ZA'; break;
		case 'Benghazi': $result_st='BA'; break;
		case 'Darnah': $result_st='DR'; break;
		case 'Ghat': $result_st='GT'; break;
		case 'Misratah': $result_st='MI'; break;
		case 'Murzuq': $result_st='MQ'; break;
		case 'Nalut': $result_st='NL'; break;
		case 'Sabha': $result_st='SB'; break;
		case 'Surt': $result_st='SR'; break;
		case 'Tripoli': $result_st='TB'; break;
		case 'Wadi al Hayat': $result_st='WD'; break;
	  }
	}
	if($country=='Libya' || $country==$country_three){
	  switch($state){
		case 'Wadi ash Shati': $result_st='WS'; break;
	  }
	}
	if($country=='Liechtenstein' || $country==$country_three){
	  switch($state){
		case 'Balzers': $result_st='1'; break;
		case 'Eschen': $result_st='2'; break;
		case 'Gamprin': $result_st='3'; break;
		case 'Mauren': $result_st='4'; break;
		case 'Planken': $result_st='5'; break;
		case 'Ruggell': $result_st='6'; break;
		case 'Schaan': $result_st='7'; break;
		case 'Schellenberg': $result_st='8'; break;
		case 'Triesen': $result_st='9'; break;
		case 'Triesenberg': $result_st='10'; break;
		case 'Vaduz': $result_st='11'; break;
	  }
	}
	if($country=='Luxembourg' || $country==$country_three){
	  switch($state){
		case 'Diekirch': $result_st='D'; break;
		case 'Grevenmacher': $result_st='G'; break;
		case 'Luxembourg': $result_st='L'; break;
	  }
	}
	if($country=='Macao' || $country==$country_three){
	  switch($state){
		case 'Macao': $result_st='MO'; break;
	  }
	}
	if($country=='Macedonia' || $country==$country_three){
	  switch($state){
		case 'Aracinovo': $result_st='2'; break;
		case 'Berovo': $result_st='3'; break;
		case 'Bitola': $result_st='4'; break;
		case 'Bogdanci': $result_st='5'; break;
		case 'Bogovinje': $result_st='6'; break;
		case 'Bosilovo': $result_st='7'; break;
		case 'Brvenica': $result_st='8'; break;
		case 'Caska': $result_st='80'; break;
		case 'Centar Zupa': $result_st='78'; break;
		case 'Cesinovo-Oblesevo': $result_st='81'; break;
		case 'Cucer Sandevo': $result_st='82'; break;
		case 'Debar': $result_st='21'; break;
		case 'Debarca': $result_st='22'; break;
		case 'Delcevo': $result_st='23'; break;
		case 'Demir Hisar': $result_st='25'; break;
		case 'Demir Kapija': $result_st='24'; break;
		case 'Dojran': $result_st='26'; break;
		case 'Dolneni': $result_st='27'; break;
		case 'Gevgelija': $result_st='18'; break;
		case 'Gostivar': $result_st='19'; break;
		case 'Gradsko': $result_st='20'; break;
		case 'Ilinden': $result_st='34'; break;
		case 'Jegunovce': $result_st='35'; break;
		case 'Karbinci': $result_st='37'; break;
		case 'Kavadarci': $result_st='36'; break;
		case 'Kicevo': $result_st='40'; break;
		case 'Kocani': $result_st='42'; break;
		case 'Konce': $result_st='41'; break;
		case 'Kratovo': $result_st='43'; break;
		case 'Kriva Palanka': $result_st='44'; break;
		case 'Krivogastani': $result_st='45'; break;
		case 'Krusevo': $result_st='46'; break;
		case 'Kumanovo': $result_st='47'; break;
		case 'Lipkovo': $result_st='48'; break;
		case 'Lozovo': $result_st='49'; break;
		case 'Makedonska Kamenica': $result_st='51'; break;
		case 'Makedonski Brod': $result_st='52'; break;
		case 'Mavrovo i Rostusa': $result_st='50'; break;
		case 'Mogila': $result_st='53'; break;
		case 'Negotino': $result_st='54'; break;
		case 'Novaci': $result_st='55'; break;
		case 'Novo Selo': $result_st='56'; break;
		case 'Ohrid': $result_st='58'; break;
		case 'Pehcevo': $result_st='60'; break;
		case 'Petrovec': $result_st='59'; break;
		case 'Plasnica': $result_st='61'; break;
		case 'Prilep': $result_st='62'; break;
		case 'Probistip': $result_st='63'; break;
		case 'Radovis': $result_st='64'; break;
		case 'Rankovce': $result_st='65'; break;
		case 'Resen': $result_st='66'; break;
		case 'Rosoman': $result_st='67'; break;
		case 'Skopje': $result_st='85'; break;
		case 'Sopiste': $result_st='70'; break;
		case 'Staro Nagoricane': $result_st='71'; break;
		case 'Stip': $result_st='83'; break;
		case 'Struga': $result_st='72'; break;
		case 'Strumica': $result_st='73'; break;
		case 'Studenicani': $result_st='74'; break;
		case 'Sveti Nikole': $result_st='69'; break;
		case 'Tearce': $result_st='75'; break;
		case 'Tetovo': $result_st='76'; break;
		case 'Valandovo': $result_st='10'; break;
		case 'Vasilevo': $result_st='11'; break;
		case 'Veles': $result_st='13'; break;
		case 'Vevcani': $result_st='12'; break;
		case 'Vinica': $result_st='14'; break;
		case 'Vrapciste': $result_st='16'; break;
		case 'Zelenikovo': $result_st='32'; break;
		case 'Zelino': $result_st='30'; break;
		case 'Zrnovci': $result_st='33'; break;
	  }
	}
	if($country=='Madagascar' || $country==$country_three){
	  switch($state){
		case 'Antananarivo': $result_st='T'; break;
		case 'Antsiranana': $result_st='D'; break;
		case 'Fianarantsoa': $result_st='F'; break;
		case 'Mahajanga': $result_st='M'; break;
		case 'Toamasina': $result_st='A'; break;
		case 'Toliara': $result_st='U'; break;
	  }
	}
	if($country=='Malawi' || $country==$country_three){
	  switch($state){
		case 'Balaka': $result_st='BA'; break;
		case 'Blantyre': $result_st='BL'; break;
		case 'Chikwawa': $result_st='CK'; break;
		case 'Chiradzulu': $result_st='CR'; break;
		case 'Chitipa': $result_st='CT'; break;
		case 'Dedza': $result_st='DE'; break;
		case 'Dowa': $result_st='DO'; break;
		case 'Karonga': $result_st='KR'; break;
		case 'Kasungu': $result_st='KS'; break;
		case 'Likoma': $result_st='LK'; break;
		case 'Lilongwe': $result_st='LI'; break;
		case 'Machinga': $result_st='MH'; break;
		case 'Mangochi': $result_st='MG'; break;
		case 'Mchinji': $result_st='MC'; break;
		case 'Mulanje': $result_st='MU'; break;
		case 'Mwanza': $result_st='MW'; break;
		case 'Mzimba': $result_st='MZ'; break;
		case 'Neno': $result_st='NE'; break;
		case 'Nkhata Bay': $result_st='NB'; break;
		case 'Nkhotakota': $result_st='NK'; break;
		case 'Nsanje': $result_st='NS'; break;
		case 'Ntcheu': $result_st='NU'; break;
		case 'Ntchisi': $result_st='NI'; break;
		case 'Phalombe': $result_st='PH'; break;
		case 'Rumphi': $result_st='RU'; break;
		case 'Salima': $result_st='SA'; break;
		case 'Thyolo': $result_st='TH'; break;
		case 'Zomba': $result_st='ZO'; break;
	  }
	}
	if($country=='Malaysia' || $country==$country_three){
	  switch($state){
		case 'Johor': $result_st='1'; break;
		case 'Kedah': $result_st='2'; break;
		case 'Kelantan': $result_st='3'; break;
		case 'Kuala Lumpur': $result_st='14'; break;
		case 'Labuan': $result_st='15'; break;
		case 'Melaka': $result_st='4'; break;
		case 'Negeri Sembilan': $result_st='5'; break;
		case 'Pahang': $result_st='6'; break;
		case 'Perak': $result_st='8'; break;
		case 'Perlis': $result_st='9'; break;
		case 'Pulau Pinang': $result_st='7'; break;
		case 'Putrajaya': $result_st='16'; break;
		case 'Sabah': $result_st='12'; break;
		case 'Sarawak': $result_st='13'; break;
		case 'Selangor': $result_st='10'; break;
		case 'Terengganu': $result_st='11'; break;
	  }
	}
	if($country=='Maldives' || $country==$country_three){
	  switch($state){
		case 'Alifu': $result_st='2'; break;
		case 'Baa': $result_st='20'; break;
		case 'Dhaalu': $result_st='17'; break;
		case 'Gaafu Dhaalu': $result_st='28'; break;
		case 'Haa Alifu': $result_st='7'; break;
		case 'Haa Dhaalu': $result_st='23'; break;
		case 'Kaafu': $result_st='26'; break;
		case 'Laamu': $result_st='5'; break;
		case 'Maale': $result_st='MLE'; break;
		case 'Meemu': $result_st='12'; break;
		case 'Noonu': $result_st='25'; break;
		case 'Raa': $result_st='13'; break;
		case 'Seenu': $result_st='1'; break;
		case 'Shaviyani': $result_st='24'; break;
		case 'Thaa': $result_st='8'; break;
	  }
	}
	if($country=='Mali' || $country==$country_three){
	  switch($state){
		case 'Bamako': $result_st='BKO'; break;
		case 'Gao': $result_st='7'; break;
		case 'Kayes': $result_st='1'; break;
		case 'Kidal': $result_st='8'; break;
		case 'Koulikoro': $result_st='2'; break;
		case 'Mopti': $result_st='5'; break;
		case 'Segou': $result_st='4'; break;
		case 'Sikasso': $result_st='3'; break;
		case 'Tombouctou': $result_st='6'; break;
	  }
	}
	if($country=='Malta' || $country==$country_three){
	  switch($state){
		case 'Malta': $result_st='MT'; break;
	  }
	}
	if($country=='Marshall Islands' || $country==$country_three){
	  switch($state){
		case 'Ailinglaplap Atoll': $result_st='ALL'; break;
		case 'Ailuk Atoll': $result_st='ALK'; break;
		case 'Arno Atoll': $result_st='ARN'; break;
		case 'Aur Atoll': $result_st='AUR'; break;
		case 'Ebon Atoll': $result_st='EBO'; break;
		case 'Enewetak Atoll': $result_st='ENI'; break;
		case 'Jabat Island': $result_st='JAB'; break;
		case 'Jaluit Atoll': $result_st='JAL'; break;
		case 'Kili Island': $result_st='KIL'; break;
		case 'Kwajalein Atoll': $result_st='KWA'; break;
		case 'Lae Atoll': $result_st='LAE'; break;
		case 'Lib Island': $result_st='LIB'; break;
		case 'Likiep Atoll': $result_st='LIK'; break;
		case 'Majuro Atoll': $result_st='MAJ'; break;
		case 'Maloelap Atoll': $result_st='MAL'; break;
		case 'Mejit Island': $result_st='MEJ'; break;
		case 'Mili Atoll': $result_st='MIL'; break;
		case 'Namdrik Atoll': $result_st='NMK'; break;
		case 'Namu Atoll': $result_st='NMU'; break;
		case 'Rongelap Atoll': $result_st='RON'; break;
		case 'Ujae Atoll': $result_st='UJA'; break;
		case 'Utrik Atoll': $result_st='UTI'; break;
		case 'Wotho Atoll': $result_st='WTH'; break;
		case 'Wotje Atoll': $result_st='WTJ'; break;
	  }
	}
	if($country=='Martinique' || $country==$country_three){
	  switch($state){
		case 'Martinique': $result_st='MQ'; break;
	  }
	}
	if($country=='Mauritania' || $country==$country_three){
	  switch($state){
		case 'Adrar': $result_st='7'; break;
		case 'Assaba': $result_st='3'; break;
		case 'Brakna': $result_st='5'; break;
		case 'Dakhlet Nouadhibou': $result_st='8'; break;
		case 'Gorgol': $result_st='4'; break;
		case 'Guidimaka': $result_st='10'; break;
		case 'Hodh Ech Chargui': $result_st='1'; break;
		case 'Hodh El Gharbi': $result_st='2'; break;
		case 'Inchiri': $result_st='12'; break;
		case 'Nouakchott': $result_st='NKC'; break;
		case 'Tagant': $result_st='9'; break;
		case 'Tiris Zemmour': $result_st='11'; break;
		case 'Trarza': $result_st='6'; break;
	  }
	}
	if($country=='Mauritius' || $country==$country_three){
	  switch($state){
		case 'Black River': $result_st='BL'; break;
		case 'Flacq': $result_st='FL'; break;
		case 'Grand Port': $result_st='GP'; break;
		case 'Moka': $result_st='MO'; break;
		case 'Pamplemousses': $result_st='PA'; break;
		case 'Plaines Wilhems': $result_st='PW'; break;
		case 'Port Louis': $result_st='PL'; break;
		case 'Riviere du Rempart': $result_st='RR'; break;
		case 'Savanne': $result_st='SA'; break;
	  }
	}
	if($country=='Mayotte' || $country==$country_three){
	  switch($state){
		case 'Mayotte': $result_st='YT'; break;
	  }
	}
	if($country=='Mexico' || $country==$country_three){
	  switch($state){
		case 'Aguascalientes': $result_st='AGU'; break;
		case 'Baja California Sur': $result_st='BCS'; break;
		case 'Baja California': $result_st='BCN'; break;
		case 'Campeche': $result_st='CAM'; break;
		case 'Chiapas': $result_st='CHP'; break;
		case 'Chihuahua': $result_st='CHH'; break;
		case 'Coahuila de Zaragoza': $result_st='COA'; break;
		case 'Colima': $result_st='COL'; break;
		case 'Distrito Federal': $result_st='DIF'; break;
		case 'Durango': $result_st='DUR'; break;
		case 'Guanajuato': $result_st='GUA'; break;
		case 'Guerrero': $result_st='GRO'; break;
		case 'Hidalgo': $result_st='HID'; break;
		case 'Jalisco': $result_st='JAL'; break;
		case 'Mexico': $result_st='MEX'; break;
		case 'Michoacan de Ocampo': $result_st='MIC'; break;
		case 'Morelos': $result_st='MOR'; break;
		case 'Nayarit': $result_st='NAY'; break;
		case 'Nuevo Leon': $result_st='NLE'; break;
		case 'Oaxaca': $result_st='OAX'; break;
		case 'Puebla': $result_st='PUE'; break;
		case 'Queretaro de Arteaga': $result_st='QUE'; break;
		case 'Quintana Roo': $result_st='ROO'; break;
		case 'San Luis Potosi': $result_st='SLP'; break;
		case 'Sinaloa': $result_st='SIN'; break;
		case 'Sonora': $result_st='SON'; break;
		case 'Tabasco': $result_st='TAB'; break;
		case 'Tamaulipas': $result_st='TAM'; break;
		case 'Tlaxcala': $result_st='TLA'; break;
		case 'Veracruz-Llave': $result_st='VER'; break;
		case 'Yucatan': $result_st='YUC'; break;
		case 'Zacatecas': $result_st='ZAC'; break;
	  }
	}
	if($country=='Monaco' || $country==$country_three){
	  switch($state){
		case 'Monaco': $result_st='MO'; break;
	  }
	}
	if($country=='Mongolia' || $country==$country_three){
	  switch($state){
		case 'Arhangay': $result_st='73'; break;
		case 'Bayan-Olgiy': $result_st='71'; break;
		case 'Bayanhongor': $result_st='69'; break;
		case 'Bulgan': $result_st='67'; break;
		case 'Darhan-Uul': $result_st='37'; break;
		case 'Dornod': $result_st='61'; break;
		case 'Dornogovi': $result_st='63'; break;
		case 'Dundgovi': $result_st='59'; break;
		case 'Dzavhan': $result_st='57'; break;
		case 'Govi-Altay': $result_st='65'; break;
		case 'Govisumber': $result_st='64'; break;
		case 'Hentiy': $result_st='39'; break;
		case 'Hovd': $result_st='43'; break;
		case 'Hovsgol': $result_st='41'; break;
		case 'Omnogovi': $result_st='53'; break;
		case 'Orhon': $result_st='35'; break;
		case 'Ovorhangay': $result_st='55'; break;
		case 'Selenge': $result_st='49'; break;
		case 'Suhbaatar': $result_st='51'; break;
		case 'Tov': $result_st='47'; break;
		case 'Ulaanbaatar': $result_st='1'; break;
		case 'Uvs': $result_st='46'; break;
	  }
	}
	if($country=='Montenegro' || $country==$country_three){
	  switch($state){
		case 'Opstina Bar': $result_st='2'; break;
		case 'Opstina Budva': $result_st='5'; break;
		case 'Opstina Cetinje': $result_st='6'; break;
		case 'Opstina Danilovgrad': $result_st='7'; break;
		case 'Opstina Herceg Novi': $result_st='8'; break;
		case 'Opstina Kolasin': $result_st='9'; break;
		case 'Opstina Kotor': $result_st='10'; break;
		case 'Opstina Mojkovac': $result_st='11'; break;
		case 'Opstina Niksic': $result_st='12'; break;
		case 'Opstina Podgorica': $result_st='16'; break;
		case 'Opstina Tivat': $result_st='19'; break;
		case 'Opstina Ulcinj': $result_st='20'; break;
		case 'Opstina Zabljak': $result_st='21'; break;
	  }
	}
	if($country=='Montserrat' || $country==$country_three){
	  switch($state){
		case 'Montserrat': $result_st='MS'; break;
	  }
	}
	if($country=='Morocco' || $country==$country_three){
	  switch($state){
		case 'Oued Ed-Dahab-Lagouira': $result_st='16'; break;
		case 'Western Sahara': $result_st='14'; break;
		case 'Chaouia-Ouardigha': $result_st='9'; break;
		case 'Doukkala-Abda': $result_st='10'; break;
		case 'Fes-Boulemane': $result_st='5'; break;
		case 'Gharb-Chrarda-Beni Hssen': $result_st='2'; break;
		case 'Grand Casablanca': $result_st='8'; break;
		case 'Guelmim-Es Smara': $result_st='14'; break;
		case 'Marrakech-Tensift-Al Haouz': $result_st='11'; break;
		case 'Meknes-Tafilalet': $result_st='6'; break;
		case 'Oriental': $result_st='4'; break;
		case 'Rabat-Sale-Zemmour-Zaer': $result_st='7'; break;
		case 'Souss-Massa-Dr': $result_st='13'; break;
		case 'Tadla-Azilal': $result_st='12'; break;
		case 'Tanger-Tetouan': $result_st='1'; break;
		case 'Taza-Al Hoceima-Taounate': $result_st='3'; break;
	  }
	}
	if($country=='Mozambique' || $country==$country_three){
	  switch($state){
		case 'Cabo Delgado': $result_st='P'; break;
		case 'Gaza': $result_st='G'; break;
		case 'Inhambane': $result_st='I'; break;
		case 'Manica': $result_st='B'; break;
		case 'Maputo': $result_st='L'; break;
		case 'Nampula': $result_st='N'; break;
		case 'Niassa': $result_st='A'; break;
		case 'Sofala': $result_st='S'; break;
		case 'Tete': $result_st='T'; break;
		case 'Zambezia': $result_st='Q'; break;
	  }
	}
	if($country=='Myanmar [Burma]' || $country==$country_three){
	  switch($state){
		case 'Ayeyawady': $result_st='7'; break;
		case 'Bago': $result_st='2'; break;
		case 'Magway': $result_st='3'; break;
		case 'Mandalay': $result_st='4'; break;
		case 'Sagaing': $result_st='1'; break;
		case 'Taninthayi': $result_st='5'; break;
		case 'Yangon': $result_st='6'; break;
		case 'Chin': $result_st='14'; break;
		case 'Kachin': $result_st='11'; break;
		case 'Kayah': $result_st='12'; break;
		case 'Kayin': $result_st='13'; break;
		case 'Mon': $result_st='15'; break;
		case 'Rakhine': $result_st='16'; break;
		case 'Shan': $result_st='17'; break;
		case 'Nay Pyi Taw': $result_st='18'; break;
	  }
	}
	if($country=='Namibia' || $country==$country_three){
	  switch($state){
		case 'Erongo': $result_st='ER'; break;
		case 'Hardap': $result_st='HA'; break;
		case 'Karas': $result_st='KA'; break;
		case 'Kavango East': $result_st='KE'; break;
		case 'Kavango West': $result_st='KW'; break;
		case 'Khomas': $result_st='KH'; break;
		case 'Kunene': $result_st='KU'; break;
		case 'Ohangwena': $result_st='OW'; break;
		case 'Omaheke': $result_st='OH'; break;
		case 'Omusati': $result_st='OS'; break;
		case 'Oshana': $result_st='ON'; break;
		case 'Oshikoto': $result_st='OT'; break;
		case 'Otjozondjupa': $result_st='OD'; break;
		case 'Zambezi': $result_st='CA'; break;
	  }
	}
	if($country=='Nauru' || $country==$country_three){
	  switch($state){
		case 'Yaren': $result_st='14'; break;
	  }
	}
	if($country=='Nepal' || $country==$country_three){
	  switch($state){
		case 'Bagmati': $result_st='BA'; break;
		case 'Bheri': $result_st='BH'; break;
		case 'Dhawalagiri': $result_st='DH'; break;
		case 'Gandaki': $result_st='GA'; break;
		case 'Janakpur': $result_st='JA'; break;
		case 'Karnali': $result_st='KA'; break;
		case 'Kosi': $result_st='KO'; break;
		case 'Lumbini': $result_st='LU'; break;
		case 'Mahakali': $result_st='MA'; break;
		case 'Mechi': $result_st='ME'; break;
		case 'Narayani': $result_st='NA'; break;
		case 'Rapti': $result_st='RA'; break;
		case 'Sagarmatha': $result_st='SA'; break;
		case 'Seti': $result_st='SE'; break;
	  }
	}
	if($country=='Netherlands' || $country==$country_three){
	  switch($state){
		case 'Drenthe': $result_st='DR'; break;
		case 'Flevoland': $result_st='FL'; break;
		case 'Friesland': $result_st='FR'; break;
		case 'Gelderland': $result_st='GE'; break;
		case 'Groningen': $result_st='GR'; break;
		case 'Limburg': $result_st='LI'; break;
		case 'Noord-Brabant': $result_st='NB'; break;
		case 'Noord-Holland': $result_st='NH'; break;
		case 'Overijssel': $result_st='OV'; break;
		case 'Utrecht': $result_st='UT'; break;
		case 'Zeeland': $result_st='ZE'; break;
		case 'Zuid-Holland': $result_st='ZH'; break;
	  }
	}
	if($country=='New Caledonia' || $country==$country_three){
	  switch($state){
		case 'New Caledonia': $result_st='NC'; break;
	  }
	}
	if($country=='New Zealand' || $country==$country_three){
	  switch($state){
		case 'Auckland': $result_st='AUK'; break;
		case 'Bay of Plenty': $result_st='BOP'; break;
		case 'Canterbury': $result_st='CAN'; break;
		case 'Chatham Islands': $result_st='CIT'; break;
		case 'Gisborne': $result_st='GIS'; break;
		case 'Hawkes Bay': $result_st='HKB'; break;
		case 'Manawatu-Wanganui': $result_st='MWT'; break;
		case 'Marlborough': $result_st='MBH'; break;
		case 'Nelson': $result_st='NSN'; break;
		case 'Northland': $result_st='NTL'; break;
		case 'Otago': $result_st='OTA'; break;
		case 'Southland': $result_st='STL'; break;
		case 'Taranaki': $result_st='TKI'; break;
		case 'Tasman': $result_st='TAS'; break;
		case 'Waikato': $result_st='WKO'; break;
		case 'Wellington': $result_st='WGN'; break;
		case 'West Coast': $result_st='WTC'; break;
	  }
	}
	if($country=='Nicaragua' || $country==$country_three){
	  switch($state){
		case 'Autonoma Atlantico Norte': $result_st='AN'; break;
		case 'Boaco': $result_st='BO'; break;
		case 'Carazo': $result_st='CA'; break;
		case 'Chinandega': $result_st='CI'; break;
		case 'Chontales': $result_st='CO'; break;
		case 'Esteli': $result_st='ES'; break;
		case 'Granada': $result_st='GR'; break;
		case 'Jinotega': $result_st='JI'; break;
		case 'Leon': $result_st='LE'; break;
		case 'Madriz': $result_st='MD'; break;
		case 'Managua': $result_st='MN'; break;
		case 'Masaya': $result_st='MS'; break;
		case 'Matagalpa': $result_st='MT'; break;
		case 'Nueva Segovia': $result_st='NS'; break;
		case 'Region Autonoma Atlantico Sur': $result_st='AS'; break;
		case 'Rio San Juan': $result_st='SJ'; break;
		case 'Rivas': $result_st='RI'; break;
	  }
	}
	if($country=='Niger' || $country==$country_three){
	  switch($state){
		case 'Agadez': $result_st='1'; break;
		case 'Diffa': $result_st='2'; break;
		case 'Dosso': $result_st='3'; break;
		case 'Maradi': $result_st='4'; break;
		case 'Niamey': $result_st='8'; break;
		case 'Tahoua': $result_st='5'; break;
		case 'Tillaberi': $result_st='6'; break;
		case 'Zinder': $result_st='7'; break;
	  }
	}
	if($country=='Nigeria' || $country==$country_three){
	  switch($state){
		case 'Abia': $result_st='AB'; break;
		case 'Adamawa': $result_st='AD'; break;
		case 'Akwa Ibom': $result_st='AK'; break;
		case 'Anambra': $result_st='AN'; break;
		case 'Bauchi': $result_st='BA'; break;
		case 'Bayelsa': $result_st='BY'; break;
		case 'Benue': $result_st='BE'; break;
		case 'Borno': $result_st='BO'; break;
		case 'Cross River': $result_st='CR'; break;
		case 'Delta': $result_st='DE'; break;
		case 'Ebonyi': $result_st='EB'; break;
		case 'Edo': $result_st='ED'; break;
		case 'Ekiti': $result_st='EK'; break;
		case 'Enugu': $result_st='EN'; break;
		case 'Federal Capital Territory': $result_st='FC'; break;
		case 'Gombe': $result_st='GO'; break;
		case 'Imo': $result_st='IM'; break;
		case 'Jigawa': $result_st='JI'; break;
		case 'Kaduna': $result_st='KD'; break;
		case 'Kano': $result_st='KN'; break;
		case 'Katsina': $result_st='KT'; break;
		case 'Kebbi': $result_st='KE'; break;
		case 'Kogi': $result_st='KO'; break;
		case 'Kwara': $result_st='KW'; break;
		case 'Lagos': $result_st='LA'; break;
		case 'Nassarawa': $result_st='NA'; break;
		case 'Niger': $result_st='NI'; break;
		case 'Ogun': $result_st='OG'; break;
		case 'Ondo': $result_st='ON'; break;
		case 'Osun': $result_st='OS'; break;
		case 'Oyo': $result_st='OY'; break;
		case 'Plateau': $result_st='PL'; break;
		case 'Rivers': $result_st='RI'; break;
		case 'Sokoto': $result_st='SO'; break;
		case 'Taraba': $result_st='TA'; break;
		case 'Yobe': $result_st='YO'; break;
		case 'Zamfara': $result_st='ZA'; break;
	  }
	}
	if($country=='Niue' || $country==$country_three){
	  switch($state){
		case 'Niue': $result_st='NU'; break;
	  }
	}
	if($country=='Norfolk Island' || $country==$country_three){
	  switch($state){
		case 'Norfolk Island': $result_st='NF'; break;
	  }
	}
	if($country=='North Korea' || $country==$country_three){
	  switch($state){
		case 'Chagang-do': $result_st='4'; break;
		case 'Hamgyong-bukto': $result_st='9'; break;
		case 'Hamgyong-namdo': $result_st='8'; break;
		case 'Hwanghae-bukto': $result_st='6'; break;
		case 'Hwanghae-namdo': $result_st='5'; break;
		case 'Kangwon-do': $result_st='7'; break;
		case 'Najin Sonbong-si': $result_st='13'; break;
		case 'Pyongan-bukto': $result_st='3'; break;
		case 'Pyongan-namdo': $result_st='2'; break;
		case 'Pyongyang-si': $result_st='1'; break;
		case 'Yanggang-do': $result_st='10'; break;
	  }
	}
	if($country=='Northern Mariana Islands' || $country==$country_three){
	  switch($state){
		case 'Northern Mariana Islands': $result_st='MP'; break;
	  }
	}
	if($country=='Norway' || $country==$country_three){
	  switch($state){
		case 'Akershus': $result_st='2'; break;
		case 'Aust-Agder': $result_st='9'; break;
		case 'Buskerud': $result_st='6'; break;
		case 'Finnmark': $result_st='20'; break;
		case 'Hedmark': $result_st='4'; break;
		case 'Hordaland': $result_st='12'; break;
		case 'More og Romsdal': $result_st='15'; break;
		case 'Nord-Trondelag': $result_st='17'; break;
		case 'Nordland': $result_st='18'; break;
		case 'Oppland': $result_st='5'; break;
		case 'Oslo': $result_st='3'; break;
		case 'Ostfold': $result_st='1'; break;
		case 'Rogaland': $result_st='11'; break;
		case 'Sogn og Fjordane': $result_st='14'; break;
		case 'Sor-Trondelag': $result_st='16'; break;
		case 'Telemark': $result_st='8'; break;
		case 'Troms': $result_st='19'; break;
		case 'Vest-Agder': $result_st='10'; break;
		case 'Vestfold': $result_st='7'; break;
	  }
	}
	if($country=='Oman' || $country==$country_three){
	  switch($state){
		case 'Ad Dakhiliyah': $result_st='DA'; break;
		case 'Shamal al Batinah': $result_st='BJ'; break;
		case 'Janub al Batinah': $result_st='BS'; break;
		case 'Al Wusta': $result_st='WU'; break;
		case 'Shamal ash Sharqiyah': $result_st='SJ'; break;
		case 'Janub ash Sharqiyah': $result_st='SS'; break;
		case 'Az Zahirah': $result_st='ZA'; break;
		case 'Al Buraymi': $result_st='BU'; break;
		case 'Masqat': $result_st='MA'; break;
		case 'Musandam': $result_st='MU'; break;
		case 'Zufar': $result_st='ZU'; break;
	  }
	}
	if($country=='Pakistan' || $country==$country_three){
	  switch($state){
		case 'Azad Kashmir': $result_st='JK'; break;
		case 'Balochistan': $result_st='BA'; break;
		case 'Federally Administered Tribal Areas': $result_st='TA'; break;
		case 'Islamabad': $result_st='IS'; break;
		case 'North-West Frontier': $result_st='NW'; break;
		case 'Northern Areas': $result_st='NA'; break;
		case 'Punjab': $result_st='PB'; break;
		case 'Sindh': $result_st='SD'; break;
	  }
	}
	if($country=='Palau' || $country==$country_three){
	  switch($state){
		case 'Aimeliik': $result_st='2'; break;
		case 'Airai': $result_st='4'; break;
		case 'Angaur': $result_st='10'; break;
		case 'Kayangel': $result_st='100'; break;
		case 'Koror': $result_st='150'; break;
		case 'Melekeok': $result_st='212'; break;
		case 'Ngaraard': $result_st='214'; break;
		case 'Ngarchelong': $result_st='218'; break;
		case 'Ngardmau': $result_st='222'; break;
		case 'Ngatpang': $result_st='224'; break;
		case 'Ngiwal': $result_st='228'; break;
		case 'Peleliu': $result_st='350'; break;
	  }
	}
	if($country=='Palestine' || $country==$country_three){
	  switch($state){
		case 'Bethlehem': $result_st='BTH'; break;
		case 'Deir El Balah': $result_st='DEB'; break;
		case 'Gaza': $result_st='GZA'; break;
		case 'Hebron': $result_st='HBN'; break;
		case 'Jenin': $result_st='JEN'; break;
		case 'Jericho – Al Aghwar': $result_st='JRH'; break;
		case 'Jerusalem': $result_st='JEM'; break;
		case 'Khan Yunis': $result_st='KYS'; break;
		case 'Nablus': $result_st='NBS'; break;
		case 'North Gaza': $result_st='NGZ'; break;
		case 'Qalqilya': $result_st='QQA'; break;
		case 'Rafah': $result_st='RFH'; break;
		case 'Ramallah': $result_st='RBH'; break;
		case 'Salfit': $result_st='SLT'; break;
		case 'Tubas': $result_st='TBS'; break;
		case 'Tulkarm': $result_st='TKM'; break;
	  }
	}
	if($country=='Panama' || $country==$country_three){
	  switch($state){
		case 'Bocas del Toro': $result_st='1'; break;
		case 'Chiriqui': $result_st='4'; break;
		case 'Cocle': $result_st='2'; break;
		case 'Colon': $result_st='3'; break;
		case 'Darien': $result_st='5'; break;
		case 'Herrera': $result_st='6'; break;
		case 'Los Santos': $result_st='7'; break;
		case 'Panama': $result_st='8'; break;
		case 'San Blas': $result_st='0'; break;
		case 'Veraguas': $result_st='9'; break;
	  }
	}
	if($country=='Papua New Guinea' || $country==$country_three){
	  switch($state){
		case 'Chimbu': $result_st='CPK'; break;
		case 'East New Britain': $result_st='EBR'; break;
		case 'East Sepik': $result_st='ESW'; break;
		case 'Eastern Highlands': $result_st='EHG'; break;
		case 'Enga': $result_st='EPW'; break;
		case 'Gulf': $result_st='GPK'; break;
		case 'Madang': $result_st='MPM'; break;
		case 'Manus': $result_st='MRL'; break;
		case 'Milne Bay': $result_st='MBA'; break;
		case 'Morobe': $result_st='MPL'; break;
		case 'National Capital': $result_st='NCD'; break;
		case 'New Ireland': $result_st='NIK'; break;
		case 'North Solomons': $result_st='NSA'; break;
		case 'Northern': $result_st='NPP'; break;
		case 'Sandaun': $result_st='SAN'; break;
		case 'Southern Highlands': $result_st='SHM'; break;
		case 'West New Britain': $result_st='WBK'; break;
		case 'Western Highlands': $result_st='WHM'; break;
		case 'Western': $result_st='WPD'; break;
	  }
	}
	if($country=='Paraguay' || $country==$country_three){
	  switch($state){
		case 'Alto Paraguay': $result_st='16'; break;
		case 'Alto Parana': $result_st='10'; break;
		case 'Amambay': $result_st='13'; break;
		case 'Asuncion': $result_st='ASU'; break;
		case 'Boqueron': $result_st='19'; break;
		case 'Caaguazu': $result_st='5'; break;
		case 'Caazapa': $result_st='6'; break;
		case 'Canindeyu': $result_st='14'; break;
		case 'Central': $result_st='11'; break;
		case 'Concepcion': $result_st='1'; break;
		case 'Cordillera': $result_st='3'; break;
		case 'Guaira': $result_st='4'; break;
		case 'Itapua': $result_st='7'; break;
		case 'Misiones': $result_st='8'; break;
		case 'Neembucu': $result_st='12'; break;
		case 'Paraguari': $result_st='9'; break;
		case 'Presidente Hayes': $result_st='15'; break;
		case 'San Pedro': $result_st='2'; break;
	  }
	}
	if($country=='Peru' || $country==$country_three){
	  switch($state){
		case 'Amazonas': $result_st='AMA'; break;
		case 'Ancash': $result_st='ANC'; break;
		case 'Apurimac': $result_st='APU'; break;
		case 'Arequipa': $result_st='ARE'; break;
		case 'Ayacucho': $result_st='AYA'; break;
		case 'Cajamarca': $result_st='CAJ'; break;
		case 'Callao': $result_st='CAL'; break;
		case 'Cusco': $result_st='CUS'; break;
		case 'Huancavelica': $result_st='HUV'; break;
		case 'Huanuco': $result_st='HUC'; break;
		case 'Ica': $result_st='ICA'; break;
		case 'Junin': $result_st='JUN'; break;
		case 'La Libertad': $result_st='LAL'; break;
		case 'Lambayeque': $result_st='LAM'; break;
		case 'Lima': $result_st='LIM'; break;
		case 'Loreto': $result_st='LOR'; break;
		case 'Madre de Dios': $result_st='MDD'; break;
		case 'Moquegua': $result_st='MOQ'; break;
		case 'Pasco': $result_st='PAS'; break;
		case 'Piura': $result_st='PIU'; break;
		case 'Puno': $result_st='PUN'; break;
		case 'San Martin': $result_st='SAM'; break;
		case 'Tacna': $result_st='TAC'; break;
		case 'Tumbes': $result_st='TUM'; break;
		case 'Ucayali': $result_st='UCA'; break;
	  }
	}
	if($country=='Philippines' || $country==$country_three){
	  switch($state){
		case 'Abra': $result_st='ABR'; break;
		case 'Agusan del Norte': $result_st='AGN'; break;
		case 'Agusan del Sur': $result_st='AGS'; break;
		case 'Aklan': $result_st='AKL'; break;
		case 'Albay': $result_st='ALB'; break;
		case 'Antique': $result_st='ANT'; break;
		case 'Apayao': $result_st='APA'; break;
		case 'Aurora': $result_st='AUR'; break;
		case 'Basilan': $result_st='BAS'; break;
		case 'Bataan': $result_st='BAN'; break;
		case 'Batanes': $result_st='BTN'; break;
		case 'Batangas': $result_st='BTG'; break;
		case 'Benguet': $result_st='BEN'; break;
		case 'Biliran': $result_st='BIL'; break;
		case 'Bohol': $result_st='BOH'; break;
		case 'Bukidnon': $result_st='BUK'; break;
		case 'Bulacan': $result_st='BUL'; break;
		case 'Cagayan': $result_st='CAG'; break;
		case 'Camarines Norte': $result_st='CAN'; break;
		case 'Camarines Sur': $result_st='CAS'; break;
		case 'Camiguin': $result_st='CAM'; break;
		case 'Capiz': $result_st='CAP'; break;
		case 'Catanduanes': $result_st='CAT'; break;
		case 'Cavite': $result_st='CAV'; break;
		case 'Cebu': $result_st='CEB'; break;
		case 'Compostela Valley': $result_st='COM'; break;
		case 'Cotabato': $result_st='NCO'; break;
		case 'Davao Occidental': $result_st='DVO'; break;
		case 'Davao Oriental': $result_st='DAO'; break;
		case 'Davao del Norte': $result_st='DAV'; break;
		case 'Davao del Sur': $result_st='DAS'; break;
		case 'Dinagat Islands': $result_st='DIN'; break;
		case 'Eastern Samar': $result_st='EAS'; break;
		case 'Guimaras': $result_st='GUI'; break;
		case 'Ifugao': $result_st='IFU'; break;
		case 'Ilocos Norte': $result_st='ILN'; break;
		case 'Ilocos Sur': $result_st='ILS'; break;
		case 'Iloilo': $result_st='ILI'; break;
		case 'Isabela': $result_st='ISA'; break;
		case 'Kalinga': $result_st='KAL'; break;
		case 'La Union': $result_st='LUN'; break;
		case 'Laguna': $result_st='LAG'; break;
		case 'Lanao del Norte': $result_st='LAN'; break;
		case 'Lanao del Sur': $result_st='LAS'; break;
		case 'Leyte': $result_st='LEY'; break;
		case 'Maguindanao': $result_st='MAG'; break;
		case 'Marinduque': $result_st='MAD'; break;
		case 'Masbate': $result_st='MAS'; break;
		case 'Mindoro Occidental': $result_st='MDC'; break;
		case 'Mindoro Oriental': $result_st='MDR'; break;
		case 'Misamis Occidental': $result_st='MSC'; break;
		case 'Misamis Oriental': $result_st='MSR'; break;
		case 'Mountain Province': $result_st='MOU'; break;
		case 'National Capital Region': $result_st='0'; break;
		case 'Negros Occidental': $result_st='NEC'; break;
		case 'Negros Oriental': $result_st='NER'; break;
		case 'Northern Samar': $result_st='NSA'; break;
		case 'Nueva Ecija': $result_st='NUE'; break;
		case 'Nueva Vizcaya': $result_st='NUV'; break;
		case 'Palawan': $result_st='PLW'; break;
		case 'Pampanga': $result_st='PAM'; break;
		case 'Pangasinan': $result_st='PAN'; break;
		case 'Quezon': $result_st='QUE'; break;
		case 'Quirino': $result_st='QUI'; break;
		case 'Rizal': $result_st='RIZ'; break;
		case 'Romblon': $result_st='ROM'; break;
		case 'Samar (Western Samar)': $result_st='WSA'; break;
		case 'Sarangani': $result_st='SAR'; break;
		case 'Siquijor': $result_st='SIG'; break;
		case 'Sorsogon': $result_st='SOR'; break;
		case 'South Cotabato': $result_st='SCO'; break;
		case 'Southern Leyte': $result_st='SLE'; break;
		case 'Sultan Kudarat': $result_st='SUK'; break;
		case 'Sulu': $result_st='SLU'; break;
		case 'Surigao del Norte': $result_st='SUN'; break;
		case 'Surigao del Sur': $result_st='SUR'; break;
		case 'Tarlac': $result_st='TAR'; break;
		case 'Tawi-Tawi': $result_st='TAW'; break;
		case 'Zambales': $result_st='ZMB'; break;
		case 'Zamboanga Sibugay': $result_st='ZSI'; break;
		case 'Zamboanga del Norte': $result_st='ZAN'; break;
		case 'Zamboanga del Sur': $result_st='ZAS'; break;
	  }
	}
	if($country=='Pitcairn Islands' || $country==$country_three){
	  switch($state){
		case 'Pitcairn': $result_st='PN'; break;
	  }
	}
	if($country=='Poland' || $country==$country_three){
	  switch($state){
		case 'Dolnoslaskie': $result_st='DS'; break;
		case 'Kujawsko-Pomorskie': $result_st='KP'; break;
		case 'Lodzkie': $result_st='LD'; break;
		case 'Lubelskie': $result_st='LU'; break;
		case 'Lubuskie': $result_st='LB'; break;
		case 'Malopolskie': $result_st='MA'; break;
		case 'Mazowieckie': $result_st='MZ'; break;
		case 'Opolskie': $result_st='OP'; break;
		case 'Podkarpackie': $result_st='PK'; break;
		case 'Podlaskie': $result_st='PD'; break;
		case 'Pomorskie': $result_st='PM'; break;
		case 'Slaskie': $result_st='SL'; break;
		case 'Swietokrzyskie': $result_st='SK'; break;
		case 'Warminsko-Mazurskie': $result_st='WN'; break;
		case 'Wielkopolskie': $result_st='WP'; break;
		case 'Zachodniopomorskie': $result_st='ZP'; break;
	  }
	}
	if($country=='Portugal' || $country==$country_three){
	  switch($state){
		case 'Aveiro': $result_st='1'; break;
		case 'Azores': $result_st='20'; break;
		case 'Beja': $result_st='2'; break;
		case 'Braga': $result_st='3'; break;
		case 'Braganca': $result_st='4'; break;
		case 'Castelo Branco': $result_st='5'; break;
		case 'Coimbra': $result_st='6'; break;
		case 'Evora': $result_st='7'; break;
		case 'Faro': $result_st='8'; break;
		case 'Guarda': $result_st='9'; break;
		case 'Leiria': $result_st='10'; break;
		case 'Lisboa': $result_st='11'; break;
		case 'Madeira': $result_st='30'; break;
		case 'Portalegre': $result_st='12'; break;
		case 'Porto': $result_st='13'; break;
		case 'Santarem': $result_st='14'; break;
		case 'Setubal': $result_st='15'; break;
		case 'Viana do Castelo': $result_st='16'; break;
		case 'Vila Real': $result_st='17'; break;
		case 'Viseu': $result_st='18'; break;
	  }
	}
	if($country=='Puerto Rico' || $country==$country_three){
	  switch($state){
		case 'Puerto Rico': $result_st='PR'; break;
	  }
	}
	if($country=='Qatar' || $country==$country_three){
	  switch($state){
		case 'Ad Dawhah': $result_st='DA'; break;
		case 'Al Khawr': $result_st='KH'; break;
		case 'Al Wakrah': $result_st='WA'; break;
		case 'Ar Rayyan': $result_st='RA'; break;
		case 'Az Zaayin': $result_st='ZA'; break;
		case 'Madinat ach Shamal': $result_st='MS'; break;
		case 'Umm Salal': $result_st='US'; break;
	  }
	}
	if($country=='Republic of Korea' || $country==$country_three){
	  switch($state){
		case 'Chungchong-bukto': $result_st='43'; break;
		case 'Chungchong-namdo': $result_st='44'; break;
		case 'Cheju-do': $result_st='49'; break;
		case 'Cholla-bukto': $result_st='45'; break;
		case 'Cholla-namdo': $result_st='46'; break;
		case 'Inchon-jikhalsi': $result_st='28'; break;
		case 'Kangwon-do': $result_st='42'; break;
		case 'Kwangju-jikhalsi': $result_st='29'; break;
		case 'Kyonggi-do': $result_st='41'; break;
		case 'Kyongsang-bukto': $result_st='47'; break;
		case 'Kyongsang-namdo': $result_st='48'; break;
		case 'Pusan-jikhalsi': $result_st='26'; break;
		case 'Seoul-tukpyolsi': $result_st='11'; break;
		case 'Taegu-jikhalsi': $result_st='27'; break;
		case 'Taejon-jikhalsi': $result_st='30'; break;
		case 'Ulsan-gwangyoksi': $result_st='31'; break;
	  }
	}
	if($country=='Republic of Lithuania' || $country==$country_three){
	  switch($state){
		case 'Alytaus Apskritis': $result_st='AL'; break;
		case 'Kauno Apskritis': $result_st='KU'; break;
		case 'Klaipedos Apskritis': $result_st='KL'; break;
		case 'Marijampoles Apskritis': $result_st='MR'; break;
		case 'Panevezio Apskritis': $result_st='PN'; break;
		case 'Siauliu Apskritis': $result_st='SA'; break;
		case 'Taurages Apskritis': $result_st='TA'; break;
		case 'Telsiu Apskritis': $result_st='TE'; break;
		case 'Utenos Apskritis': $result_st='UT'; break;
		case 'Vilniaus Apskritis': $result_st='VL'; break;
	  }
	}
	if($country=='Republic of Moldova' || $country==$country_three){
	  switch($state){
		case 'Anenii Noi': $result_st='AN'; break;
		case 'Balti': $result_st='BA'; break;
		case 'Basarabeasca': $result_st='BS'; break;
		case 'Bender': $result_st='TI'; break;
		case 'Briceni': $result_st='BR'; break;
		case 'Cahul': $result_st='CA'; break;
		case 'Calarasi': $result_st='CL'; break;
		case 'Cantemir': $result_st='CT'; break;
		case 'Causeni': $result_st='CS'; break;
		case 'Chisinau': $result_st='CU'; break;
		case 'Cimislia': $result_st='CM'; break;
		case 'Criuleni': $result_st='CR'; break;
		case 'Donduseni': $result_st='DO'; break;
		case 'Drochia': $result_st='DR'; break;
		case 'Dubasari': $result_st='DU'; break;
		case 'Edinet': $result_st='ED'; break;
		case 'Falesti': $result_st='FA'; break;
		case 'Floresti': $result_st='FL'; break;
		case 'Gagauzia': $result_st='GA'; break;
		case 'Glodeni': $result_st='GL'; break;
		case 'Hincesti': $result_st='HI'; break;
		case 'Ialoveni': $result_st='IA'; break;
		case 'Leova': $result_st='LE'; break;
		case 'Nisporeni': $result_st='NI'; break;
		case 'Ocnita': $result_st='OC'; break;
		case 'Orhei': $result_st='OR'; break;
		case 'Rezina': $result_st='RE'; break;
		case 'Riscani': $result_st='RI'; break;
		case 'Singerei': $result_st='SI'; break;
		case 'Soldanesti': $result_st='SD'; break;
		case 'Soroca': $result_st='SO'; break;
		case 'Stefan-Voda': $result_st='SV'; break;
		case 'Stinga Nistrului': $result_st='SN'; break;
		case 'Straseni': $result_st='ST'; break;
		case 'Taraclia': $result_st='TA'; break;
		case 'Telenesti': $result_st='TE'; break;
		case 'Ungheni': $result_st='UN'; break;
	  }
	}
	if($country=='Republic of the Congo' || $country==$country_three){
	  switch($state){
		case 'Bouenza': $result_st='11'; break;
		case 'Brazzaville': $result_st='BZV'; break;
		case 'Cuvette': $result_st='8'; break;
		case 'Cuvette-Ouest': $result_st='15'; break;
		case 'Kouilou': $result_st='5'; break;
		case 'Lekoumou': $result_st='2'; break;
		case 'Likouala': $result_st='7'; break;
		case 'Niari': $result_st='9'; break;
		case 'Plateaux': $result_st='14'; break;
		case 'Pointe-Noire': $result_st='16'; break;
		case 'Pool': $result_st='12'; break;
		case 'Sangha': $result_st='13'; break;
	  }
	}
	if($country=='Réunion' || $country==$country_three){
	  switch($state){
		case 'Reunion': $result_st='RE'; break;
	  }
	}
	if($country=='Romania' || $country==$country_three){
	  switch($state){
		case 'Alba': $result_st='AB'; break;
		case 'Arad': $result_st='AR'; break;
		case 'Arges': $result_st='AG'; break;
		case 'Bacau': $result_st='BC'; break;
		case 'Bihor': $result_st='BH'; break;
		case 'Bistrita-Nasaud': $result_st='BN'; break;
		case 'Botosani': $result_st='BT'; break;
		case 'Braila': $result_st='BR'; break;
		case 'Brasov': $result_st='BV'; break;
		case 'Bucuresti': $result_st='B'; break;
		case 'Buzau': $result_st='BZ'; break;
		case 'Calarasi': $result_st='CL'; break;
		case 'Caras-Severin': $result_st='CS'; break;
		case 'Cluj': $result_st='CJ'; break;
		case 'Constanta': $result_st='CT'; break;
		case 'Covasna': $result_st='CV'; break;
		case 'Dambovita': $result_st='DB'; break;
		case 'Dolj': $result_st='DJ'; break;
		case 'Galati': $result_st='GL'; break;
		case 'Giurgiu': $result_st='GR'; break;
		case 'Gorj': $result_st='GJ'; break;
		case 'Harghita': $result_st='HR'; break;
		case 'Hunedoara': $result_st='HD'; break;
		case 'Ialomita': $result_st='IL'; break;
		case 'Iasi': $result_st='IS'; break;
		case 'Ilfov': $result_st='IF'; break;
		case 'Maramures': $result_st='MM'; break;
		case 'Mehedinti': $result_st='MH'; break;
		case 'Mures': $result_st='MS'; break;
		case 'Neamt': $result_st='NT'; break;
		case 'Olt': $result_st='OT'; break;
		case 'Prahova': $result_st='PH'; break;
		case 'Salaj': $result_st='SJ'; break;
		case 'Satu Mare': $result_st='SM'; break;
		case 'Sibiu': $result_st='SB'; break;
		case 'Suceava': $result_st='SV'; break;
		case 'Teleorman': $result_st='TR'; break;
		case 'Timis': $result_st='TM'; break;
		case 'Tulcea': $result_st='TL'; break;
		case 'Valcea': $result_st='VL'; break;
		case 'Vaslui': $result_st='VS'; break;
		case 'Vrancea': $result_st='VN'; break;
	  }
	}
	if($country=='Russia' || $country==$country_three){
	  switch($state){
		case 'Adygeya': $result_st='AD'; break;
		case 'Altaisky krai': $result_st='ALT'; break;
		case 'Amur': $result_st='AMU'; break;
		case 'Arkhangelsk': $result_st='ARK'; break;
		case 'Astrakhan': $result_st='AST'; break;
		case 'Bashkortostan': $result_st='BA'; break;
		case 'Belgorod': $result_st='BEL'; break;
		case 'Bryansk': $result_st='BRY'; break;
		case 'Buryat': $result_st='BU'; break;
		case 'Chukot': $result_st='CHU'; break;
		case 'Chuvashia': $result_st='CU'; break;
		case 'Dagestan': $result_st='DA'; break;
		case 'Gorno-Altay': $result_st='AL'; break;
		case 'Ingush': $result_st='IN'; break;
		case 'Irkutsk': $result_st='IRK'; break;
		case 'Ivanovo': $result_st='IVA'; break;
		case 'Kabardin-Balkar': $result_st='KB'; break;
		case 'Kaliningrad': $result_st='KGD'; break;
		case 'Kalmyk': $result_st='KL'; break;
		case 'Kaluga': $result_st='KLU'; break;
		case 'Kamchatka': $result_st='DVD'; break;
		case 'Karachay-Cherkess': $result_st='KC'; break;
		case 'Karelia': $result_st='KR'; break;
		case 'Kemerovo': $result_st='KEM'; break;
		case 'Khabarovsk': $result_st='KHA'; break;
		case 'Khakass': $result_st='KK'; break;
		case 'Khanty-Mansiy': $result_st='KHM'; break;
		case 'Kirov': $result_st='KIR'; break;
		case 'Komi': $result_st='KO'; break;
		case 'Kostroma': $result_st='KOS'; break;
		case 'Krasnoyarskiy Kray': $result_st='KDA'; break;
		case 'Kurgan': $result_st='KGN'; break;
		case 'Kursk': $result_st='KRS'; break;
		case 'Leningrad': $result_st='LEN'; break;
		case 'Lipetsk': $result_st='LIP'; break;
		case 'Magadan': $result_st='MAG'; break;
		case 'Mariy-El': $result_st='ME'; break;
		case 'Mordovia': $result_st='MO'; break;
		case 'Moskva': $result_st='MOW'; break;
		case 'Murmansk': $result_st='MUR'; break;
		case 'Nenets': $result_st='NEN'; break;
		case 'Nizhegorod': $result_st='NIZ'; break;
		case 'Novgorod': $result_st='NGR'; break;
		case 'Novosibirsk': $result_st='NVS'; break;
		case 'Omsk': $result_st='OMS'; break;
		case 'Orel': $result_st='ORL'; break;
		case 'Orenburg': $result_st='ORE'; break;
		case 'Penza': $result_st='PNZ'; break;
		case 'Permskiy Kray': $result_st='PER'; break;
		case 'Primorye': $result_st='PRI'; break;
		case 'Pskov': $result_st='PSK'; break;
		case 'Rostov': $result_st='ROS'; break;
		case 'Ryazan': $result_st='RYA'; break;
		case 'Saint Petersburg City': $result_st='SPE'; break;
		case 'Sakha': $result_st='SA'; break;
		case 'Sakhalin': $result_st='SAK'; break;
		case 'Samara': $result_st='SAM'; break;
		case 'Saratov': $result_st='SAR'; break;
		case 'Smolensk': $result_st='SMO'; break;
		case 'Stavropol': $result_st='STA'; break;
		case 'Sverdlovsk': $result_st='SVE'; break;
		case 'Tambovskaya oblast': $result_st='TAM'; break;
		case 'Tatarstan': $result_st='TA'; break;
		case 'Tomsk': $result_st='TOM'; break;
		case 'Tula': $result_st='TUL'; break;
		case 'Tuva': $result_st='TY'; break;
		case 'Tver': $result_st='TVE'; break;
		case 'Tyumen': $result_st='TYU'; break;
		case 'Udmurt': $result_st='UD'; break;
		case 'Ulyanovsk': $result_st='ULY'; break;
		case 'Vladimir': $result_st='VLA'; break;
		case 'Volgograd': $result_st='VGG'; break;
		case 'Vologda': $result_st='VLG'; break;
		case 'Voronezh': $result_st='VOR'; break;
		case 'Yamal-Nenets': $result_st='YAN'; break;
		case 'Yaroslavl': $result_st='YAR'; break;
		case 'Yevrey': $result_st='YEV'; break;
		case 'Zabaykalsky': $result_st='ZAB'; break;
	  }
	}
	if($country=='Rwanda' || $country==$country_three){
	  switch($state){
		case 'Est': $result_st='2'; break;
		case 'Kigali': $result_st='1'; break;
		case 'Nord': $result_st='3'; break;
		case 'Ouest': $result_st='4'; break;
		case 'Sud': $result_st='5'; break;
	  }
	}
	if($country=='Saint Helena' || $country==$country_three){
	  switch($state){
		case 'Ascension': $result_st='AC'; break;
		case 'Saint Helena': $result_st='HL'; break;
		case 'Tristan da Cunha': $result_st='TA'; break;
	  }
	}
	if($country=='Saint Kitts and Nevis' || $country==$country_three){
	  switch($state){
		case 'Saint George Basseterre': $result_st='3'; break;
		case 'Saint Paul Charlestown': $result_st='9'; break;
	  }
	}
	if($country=='Saint Lucia' || $country==$country_three){
	  switch($state){
		case 'Anse-la-Raye': $result_st='1'; break;
		case 'Castries': $result_st='2'; break;
		case 'Dennery': $result_st='5'; break;
		case 'Gros-Islet': $result_st='6'; break;
		case 'Laborie': $result_st='7'; break;
		case 'Micoud': $result_st='8'; break;
		case 'Soufriere': $result_st='10'; break;
		case 'Vieux-Fort': $result_st='11'; break;
	  }
	}
	if($country=='Saint Martin' || $country==$country_three){
	  switch($state){
		case 'Saint Martin (French Part)': $result_st='MF'; break;
	  }
	}
	if($country=='Saint Pierre and Miquelon' || $country==$country_three){
	  switch($state){
		case 'Saint Pierre and Miquelon': $result_st='PM'; break;
	  }
	}
	if($country=='Saint Vincent and the Grenadines' || $country==$country_three){
	  switch($state){
		case 'Charlotte': $result_st='1'; break;
		case 'Saint George': $result_st='4'; break;
	  }
	}
	if($country=='Saint-Barthélemy' || $country==$country_three){
	  switch($state){
		case 'Saint Barthelemy': $result_st='BL'; break;
	  }
	}
	if($country=='Samoa' || $country==$country_three){
	  switch($state){
		case 'Aana': $result_st='AA'; break;
		case 'Atua': $result_st='AT'; break;
		case 'Gagaifomauga': $result_st='GI'; break;
		case 'Palauli': $result_st='PA'; break;
		case 'Tuamasaga': $result_st='TU'; break;
	  }
	}
	if($country=='San Marino' || $country==$country_three){
	  switch($state){
		case 'Acquaviva': $result_st='1'; break;
		case 'Chiesanuova': $result_st='2'; break;
		case 'San Marino': $result_st='7'; break;
		case 'Serravalle': $result_st='9'; break;
	  }
	}
	if($country=='São Tomé and Príncipe' || $country==$country_three){
	  switch($state){
		case 'Principe': $result_st='P'; break;
		case 'Sao Tome': $result_st='S'; break;
	  }
	}
	if($country=='Saudi Arabia' || $country==$country_three){
	  switch($state){
		case 'Al Bahah': $result_st='11'; break;
		case 'Al Hudud ash Shamaliyah': $result_st='8'; break;
		case 'Al Jawf': $result_st='12'; break;
		case 'Al Madinah': $result_st='3'; break;
		case 'Al Qasim': $result_st='5'; break;
		case 'Ar Riyad': $result_st='1'; break;
		case 'Ash Sharqiyah': $result_st='4'; break;
		case 'Asir': $result_st='14'; break;
		case 'Hail': $result_st='6'; break;
		case 'Jizan': $result_st='9'; break;
		case 'Makkah': $result_st='2'; break;
		case 'Najran': $result_st='10'; break;
		case 'Tabuk': $result_st='7'; break;
	  }
	}
	if($country=='Senegal' || $country==$country_three){
	  switch($state){
		case 'Dakar': $result_st='DK'; break;
		case 'Diourbel': $result_st='DB'; break;
		case 'Fatick': $result_st='FK'; break;
		case 'Kaffrine': $result_st='KA'; break;
		case 'Kaolack': $result_st='KL'; break;
		case 'Kedougou': $result_st='KE'; break;
		case 'Kolda': $result_st='KD'; break;
		case 'Louga': $result_st='LG'; break;
		case 'Matam': $result_st='MT'; break;
		case 'Saint-Louis': $result_st='SL'; break;
		case 'Sedhiou': $result_st='SE'; break;
		case 'Tambacounda': $result_st='TC'; break;
		case 'Thies': $result_st='TH'; break;
		case 'Ziguinchor': $result_st='ZG'; break;
	  }
	}
	if($country=='Serbia' || $country==$country_three){
	  switch($state){
		case 'Kosovo': $result_st='KM'; break;
		case 'Vojvodina': $result_st='VO'; break;
	  }
	}
	if($country=='Seychelles' || $country==$country_three){
	  switch($state){
		case 'English River': $result_st='16'; break;
	  }
	}
	if($country=='Sierra Leone' || $country==$country_three){
	  switch($state){
		case 'Eastern': $result_st='E'; break;
		case 'Northern': $result_st='N'; break;
		case 'Southern': $result_st='S'; break;
		case 'Western Area': $result_st='W'; break;
	  }
	}
	if($country=='Singapore' || $country==$country_three){
	  switch($state){
		case 'Central Singapore': $result_st='1'; break;
		case 'North East': $result_st='2'; break;
		case 'North West': $result_st='3'; break;
		case 'South East': $result_st='4'; break;
		case 'South West': $result_st='5'; break;
	  }
	}
	if($country=='Sint Maarten' || $country==$country_three){
	  switch($state){
		case 'Sint Maarten (Dutch Part)': $result_st='SX'; break;
	  }
	}
	if($country=='Slovak Republic' || $country==$country_three){
	  switch($state){
		case 'Banska Bystrica': $result_st='BC'; break;
		case 'Bratislava': $result_st='BL'; break;
		case 'Kosice': $result_st='KI'; break;
		case 'Nitra': $result_st='NI'; break;
		case 'Presov': $result_st='PV'; break;
		case 'Trencin': $result_st='TC'; break;
		case 'Trnava': $result_st='TA'; break;
		case 'Zilina': $result_st='ZI'; break;
	  }
	}
	if($country=='Slovenia' || $country==$country_three){
	  switch($state){
		case 'Ajdovscina': $result_st='1'; break;
		case 'Bled': $result_st='3'; break;
		case 'Bohinj': $result_st='4'; break;
		case 'Borovnica': $result_st='5'; break;
		case 'Bovec': $result_st='6'; break;
		case 'Brezice': $result_st='9'; break;
		case 'Brezovica': $result_st='8'; break;
		case 'Celje': $result_st='11'; break;
		case 'Cerknica': $result_st='13'; break;
		case 'Cerkno': $result_st='14'; break;
		case 'Crensovci': $result_st='15'; break;
		case 'Crnomelj': $result_st='17'; break;
		case 'Destrnik': $result_st='18'; break;
		case 'Divaca': $result_st='19'; break;
		case 'Domzale': $result_st='23'; break;
		case 'Dravograd': $result_st='25'; break;
		case 'Gornja Radgona': $result_st='29'; break;
		case 'Grosuplje': $result_st='32'; break;
		case 'Hoce-Slivnica': $result_st='160'; break;
		case 'Horjul': $result_st='162'; break;
		case 'Hrastnik': $result_st='34'; break;
		case 'Idrija': $result_st='36'; break;
		case 'Ig': $result_st='37'; break;
		case 'Ilirska Bistrica': $result_st='38'; break;
		case 'Ivancna Gorica': $result_st='39'; break;
		case 'Izola-Isola': $result_st='40'; break;
		case 'Jesenice': $result_st='41'; break;
		case 'Kamnik': $result_st='43'; break;
		case 'Kanal': $result_st='44'; break;
		case 'Kidricevo': $result_st='45'; break;
		case 'Kobarid': $result_st='46'; break;
		case 'Kocevje': $result_st='48'; break;
		case 'Koper-Capodistria': $result_st='50'; break;
		case 'Kranj': $result_st='52'; break;
		case 'Kranjska Gora': $result_st='53'; break;
		case 'Krsko': $result_st='54'; break;
		case 'Lasko': $result_st='57'; break;
		case 'Lenart': $result_st='58'; break;
		case 'Lendava': $result_st='59'; break;
		case 'Litija': $result_st='60'; break;
		case 'Ljubljana': $result_st='61'; break;
		case 'Ljutomer': $result_st='63'; break;
		case 'Log-Dragomer': $result_st='208'; break;
		case 'Logatec': $result_st='64'; break;
		case 'Lovrenc na Pohorju': $result_st='167'; break;
		case 'Maribor': $result_st='70'; break;
		case 'Medvode': $result_st='71'; break;
		case 'Menges': $result_st='72'; break;
		case 'Metlika': $result_st='73'; break;
		case 'Mezica': $result_st='74'; break;
		case 'Miklavz na Dravskem Polju': $result_st='169'; break;
		case 'Miren-Kostanjevica': $result_st='75'; break;
		case 'Mislinja': $result_st='76'; break;
		case 'Mozirje': $result_st='79'; break;
		case 'Murska Sobota': $result_st='80'; break;
		case 'Muta': $result_st='81'; break;
		case 'Nova Gorica': $result_st='84'; break;
		case 'Novo Mesto': $result_st='85'; break;
		case 'Odranci': $result_st='86'; break;
		case 'Oplotnica': $result_st='171'; break;
		case 'Ormoz': $result_st='87'; break;
		case 'Piran': $result_st='90'; break;
		case 'Pivka': $result_st='91'; break;
		case 'Poljcane': $result_st='200'; break;
		case 'Polzela': $result_st='173'; break;
		case 'Postojna': $result_st='94'; break;
		case 'Prebold': $result_st='174'; break;
		case 'Prevalje': $result_st='175'; break;
		case 'Ptuj': $result_st='96'; break;
		case 'Racam': $result_st='98'; break;
		case 'Radece': $result_st='99'; break;
		case 'Radenci': $result_st='100'; break;
		case 'Radlje ob Dravi': $result_st='101'; break;
		case 'Radovljica': $result_st='102'; break;
		case 'Ravne na Koroskem': $result_st='103'; break;
		case 'Ribnica': $result_st='104'; break;
		case 'Rogaska Slatina': $result_st='106'; break;
		case 'Ruse': $result_st='108'; break;
		case 'Sempeter-Vrtojba': $result_st='183'; break;
		case 'Sencur': $result_st='117'; break;
		case 'Sentilj': $result_st='118'; break;
		case 'Sentjur pri Celju': $result_st='120'; break;
		case 'Sevnica': $result_st='110'; break;
		case 'Sezana': $result_st='111'; break;
		case 'Skofja Loka': $result_st='122'; break;
		case 'Skofljica': $result_st='123'; break;
		case 'Slovenj Gradec': $result_st='112'; break;
		case 'Slovenska Bistrica': $result_st='113'; break;
		case 'Slovenske Konjice': $result_st='114'; break;
		case 'Sostanj': $result_st='126'; break;
		case 'Store': $result_st='127'; break;
		case 'Straza': $result_st='203'; break;
		case 'Tolmin': $result_st='128'; break;
		case 'Trbovlje': $result_st='129'; break;
		case 'Trebnje': $result_st='130'; break;
		case 'Trzic': $result_st='131'; break;
		case 'Trzin': $result_st='186'; break;
		case 'Turnisce': $result_st='132'; break;
		case 'Velenje': $result_st='133'; break;
		case 'Vipava': $result_st='136'; break;
		case 'Vodice': $result_st='138'; break;
		case 'Vojnik': $result_st='139'; break;
		case 'Vrhnika': $result_st='140'; break;
		case 'Vuzenica': $result_st='141'; break;
		case 'Zagorje ob Savi': $result_st='142'; break;
		case 'Zalec': $result_st='190'; break;
		case 'Zelezniki': $result_st='146'; break;
		case 'Ziri': $result_st='147'; break;
		case 'Zrece': $result_st='144'; break;
		case 'Zuzemberk': $result_st='193'; break;
	  }
	}
	if($country=='Solomon Islands' || $country==$country_three){
	  switch($state){
		case 'Central': $result_st='CE'; break;
		case 'Guadalcanal': $result_st='GU'; break;
		case 'Isabel': $result_st='IS'; break;
		case 'Makira': $result_st='MK'; break;
		case 'Malaita': $result_st='ML'; break;
		case 'Western': $result_st='WE'; break;
	  }
	}
	if($country=='Somalia' || $country==$country_three){
	  switch($state){
		case 'Awdal': $result_st='AW'; break;
		case 'Bakool': $result_st='BK'; break;
		case 'Banaadir': $result_st='BN'; break;
		case 'Bari': $result_st='BR'; break;
		case 'Bay': $result_st='BY'; break;
		case 'Galguduud': $result_st='GA'; break;
		case 'Gedo': $result_st='GE'; break;
		case 'Hiiraan': $result_st='HI'; break;
		case 'Jubbada Dhexe': $result_st='JD'; break;
		case 'Jubbada Hoose': $result_st='JH'; break;
		case 'Mudug': $result_st='MU'; break;
		case 'Nugaal': $result_st='NU'; break;
		case 'Sanaag': $result_st='SA'; break;
		case 'Shabeellaha Dhexe': $result_st='SD'; break;
		case 'Shabeellaha Hoose': $result_st='SH'; break;
		case 'Sool': $result_st='SO'; break;
		case 'Togdheer': $result_st='TO'; break;
		case 'Woqooyi Galbeed': $result_st='WO'; break;
	  }
	}
	if($country=='South Africa' || $country==$country_three){
	  switch($state){
		case 'Eastern Cape': $result_st='EC'; break;
		case 'Free State': $result_st='FS'; break;
		case 'Gauteng': $result_st='GT'; break;
		case 'KwaZulu-Natal': $result_st='NL'; break;
		case 'Limpopo': $result_st='LP'; break;
		case 'Mpumalanga': $result_st='MP'; break;
		case 'North-West': $result_st='NW'; break;
		case 'Northern Cape': $result_st='NC'; break;
		case 'Western Cape': $result_st='WC'; break;
	  }
	}
	if($country=='South Georgia and the South Sandwich Islands' || $country==$country_three){
	  switch($state){
		case 'South Georgia and The South Sandwich Islands': $result_st='GS'; break;
	  }
	}
	if($country=='South Sudan' || $country==$country_three){
	  switch($state){
		case 'Central Equatoria': $result_st='EC'; break;
		case 'Eastern Equatoria': $result_st='EE'; break;
		case 'Jonglei': $result_st='JG'; break;
		case 'Lakes': $result_st='LK'; break;
		case 'Northern Bahr el Ghazal': $result_st='BN'; break;
		case 'Unity': $result_st='UY'; break;
		case 'Upper Nile': $result_st='NU'; break;
		case 'Warrap': $result_st='WR'; break;
		case 'Western Bahr el Ghazal': $result_st='BW'; break;
		case 'Western Equatoria': $result_st='EW'; break;
	  }
	}
	if($country=='Spain' || $country==$country_three){
	  switch($state){
		case 'Andalucia': $result_st='AN'; break;
		case 'Aragon': $result_st='AR'; break;
		case 'Asturias': $result_st='AS'; break;
		case 'Canarias': $result_st='CN'; break;
		case 'Cantabria': $result_st='CB'; break;
		case 'Castilla y Leon': $result_st='CL'; break;
		case 'Castilla-La Mancha': $result_st='CM'; break;
		case 'Catalonia': $result_st='CT'; break;
		case 'Ceuta': $result_st='CE'; break;
		case 'Comunidad Valenciana': $result_st='VC'; break;
		case 'Extremadura': $result_st='EX'; break;
		case 'Galicia': $result_st='GA'; break;
		case 'Islas Baleares': $result_st='IB'; break;
		case 'La Rioja': $result_st='RI'; break;
		case 'Madrid': $result_st='MD'; break;
		case 'Melilla': $result_st='ML'; break;
		case 'Murcia': $result_st='MC'; break;
		case 'Navarra': $result_st='NC'; break;
		case 'Pais Vasco': $result_st='PV'; break;
	  }
	}
	if($country=='Sri Lanka' || $country==$country_three){
	  switch($state){
		case 'Central Province': $result_st='2'; break;
		case 'Eastern Province': $result_st='5'; break;
		case 'North Central Province': $result_st='7'; break;
		case 'North Western Province': $result_st='6'; break;
		case 'Northern Province': $result_st='4'; break;
		case 'Sabaragamuwa Province': $result_st='9'; break;
		case 'Southern Province': $result_st='3'; break;
		case 'Uva Province': $result_st='8'; break;
		case 'Western Province': $result_st='1'; break;
	  }
	}
	if($country=='Sudan' || $country==$country_three){
	  switch($state){
		case 'Blue Nile': $result_st='NB'; break;
		case 'Gedarif': $result_st='GD'; break;
		case 'Gezira': $result_st='GZ'; break;
		case 'Kassala': $result_st='KA'; break;
		case 'Khartoum': $result_st='KH'; break;
		case 'North Darfur': $result_st='DN'; break;
		case 'North Kordufan': $result_st='KN'; break;
		case 'Northern': $result_st='NO'; break;
		case 'Red Sea': $result_st='RS'; break;
		case 'River Nile': $result_st='NR'; break;
		case 'Sennar': $result_st='SI'; break;
		case 'South Darfur': $result_st='DS'; break;
		case 'South Kordufan': $result_st='KS'; break;
		case 'West Darfur': $result_st='DW'; break;
		case 'White Nile': $result_st='NW'; break;
	  }
	}
	if($country=='Suriname' || $country==$country_three){
	  switch($state){
		case 'Brokopondo': $result_st='BR'; break;
		case 'Commewijne': $result_st='CM'; break;
		case 'Coronie': $result_st='CR'; break;
		case 'Marowijne': $result_st='MA'; break;
		case 'Nickerie': $result_st='NI'; break;
		case 'Para': $result_st='PR'; break;
		case 'Paramaribo': $result_st='PM'; break;
		case 'Saramacca': $result_st='SA'; break;
		case 'Wanica': $result_st='WA'; break;
	  }
	}
	if($country=='Svalbard and Jan Mayen' || $country==$country_three){
	  switch($state){
		case 'Svalbard and Jan Mayen': $result_st='SJ'; break;
	  }
	}
	if($country=='Swaziland' || $country==$country_three){
	  switch($state){
		case 'Hhohho': $result_st='HH'; break;
		case 'Lubombo': $result_st='LU'; break;
		case 'Manzini': $result_st='MA'; break;
		case 'Shiselweni': $result_st='SH'; break;
	  }
	}
	if($country=='Sweden' || $country==$country_three){
	  switch($state){
		case 'Blekinge Lan': $result_st='K'; break;
		case 'Dalarnas Lan': $result_st='W'; break;
		case 'Gavleborgs Lan': $result_st='X'; break;
		case 'Gotlands Lan': $result_st='I'; break;
		case 'Hallands Lan': $result_st='N'; break;
		case 'Jamtlands Lan': $result_st='Z'; break;
		case 'Jonkopings Lan': $result_st='F'; break;
		case 'Kalmar Lan': $result_st='H'; break;
		case 'Kronobergs Lan': $result_st='G'; break;
		case 'Norrbottens Lan': $result_st='BD'; break;
		case 'Orebro Lan': $result_st='T'; break;
		case 'Ostergotlands Lan': $result_st='E'; break;
		case 'Skane Lan': $result_st='M'; break;
		case 'Sodermanlands Lan': $result_st='D'; break;
		case 'Stockholms Lan': $result_st='AB'; break;
		case 'Uppsala Lan': $result_st='C'; break;
		case 'Varmlands Lan': $result_st='S'; break;
		case 'Vasterbottens Lan': $result_st='AC'; break;
		case 'Vasternorrlands Lan': $result_st='Y'; break;
		case 'Vastmanlands Lan': $result_st='U'; break;
		case 'Vastra Gotaland': $result_st='O'; break;
	  }
	}
	if($country=='Switzerland' || $country==$country_three){
	  switch($state){
		case 'Aargau': $result_st='AG'; break;
		case 'Ausser-Rhoden': $result_st='AR'; break;
		case 'Basel-Landschaft': $result_st='BL'; break;
		case 'Basel-Stadt': $result_st='BS'; break;
		case 'Bern': $result_st='BE'; break;
		case 'Fribourg': $result_st='FR'; break;
		case 'Geneve': $result_st='GE'; break;
		case 'Glarus': $result_st='GL'; break;
		case 'Graubunden': $result_st='GR'; break;
		case 'Inner-Rhoden': $result_st='AI'; break;
		case 'Jura': $result_st='JU'; break;
		case 'Luzern': $result_st='LU'; break;
		case 'Neuchatel': $result_st='NE'; break;
		case 'Nidwalden': $result_st='NW'; break;
		case 'Obwalden': $result_st='OW'; break;
		case 'Sankt Gallen': $result_st='SG'; break;
		case 'Schaffhausen': $result_st='SH'; break;
		case 'Schwyz': $result_st='SZ'; break;
		case 'Solothurn': $result_st='SO'; break;
		case 'Thurgau': $result_st='TG'; break;
		case 'Ticino': $result_st='TI'; break;
		case 'Uri': $result_st='UR'; break;
		case 'Valais': $result_st='VS'; break;
		case 'Vaud': $result_st='VD'; break;
		case 'Zug': $result_st='ZG'; break;
		case 'Zurich': $result_st='ZH'; break;
	  }
	}
	if($country=='Syria' || $country==$country_three){
	  switch($state){
		case 'Al Hasakah': $result_st='HA'; break;
		case 'Al Ladhiqiyah': $result_st='LA'; break;
		case 'Al Qunaytirah': $result_st='QU'; break;
		case 'Ar Raqqah': $result_st='RA'; break;
		case 'As Suwayda': $result_st='SU'; break;
		case 'Dar': $result_st='DR'; break;
		case 'Dayr az Zawr': $result_st='DY'; break;
		case 'Dimashq': $result_st='DI'; break;
		case 'Halab': $result_st='HL'; break;
		case 'Hamah': $result_st='HM'; break;
		case 'Hims': $result_st='HI'; break;
		case 'Idlib': $result_st='ID'; break;
		case 'Rif Dimashq': $result_st='RD'; break;
		case 'Tartus': $result_st='TA'; break;
	  }
	}
	if($country=='Taiwan' || $country==$country_three){
	  switch($state){
		case 'Changhua': $result_st='CHA'; break;
		case 'Chiayi': $result_st='CYI'; break;
		case 'Chiayi': $result_st='CYQ'; break;
		case 'Hsinchu': $result_st='HSQ'; break;
		case 'Hsinchu': $result_st='HSZ'; break;
		case 'Hualien': $result_st='HUA'; break;
		case 'Kaohsiung': $result_st='KHH'; break;
		case 'Keelung': $result_st='KEE'; break;
		case 'Kinmen': $result_st='KIN'; break;
		case 'Lienchiang': $result_st='LIE'; break;
		case 'Miaoli': $result_st='MIA'; break;
		case 'Nantou': $result_st='NAN'; break;
		case 'New Taipei': $result_st='NWT'; break;
		case 'Penghu': $result_st='PEN'; break;
		case 'Pingtung': $result_st='PIF'; break;
		case 'Taichung': $result_st='TXG'; break;
		case 'Tainan': $result_st='TNN'; break;
		case 'Taipei': $result_st='TPE'; break;
		case 'Taitung': $result_st='TTT'; break;
		case 'Taoyuan': $result_st='TAO'; break;
		case 'Yilan': $result_st='ILA'; break;
		case 'Yunlin': $result_st='YUN'; break;
	  }
	}
	if($country=='Tajikistan' || $country==$country_three){
	  switch($state){
		case 'Dushanbe': $result_st='DU'; break;
		case 'Khatlon': $result_st='KT'; break;
		case 'Kuhistoni Badakhshon': $result_st='GB'; break;
		case 'Sughd': $result_st='SU'; break;
	  }
	}
	if($country=='Tanzania' || $country==$country_three){
	  switch($state){
		case 'Arusha': $result_st='1'; break;
		case 'Dar es Salaam': $result_st='2'; break;
		case 'Dodoma': $result_st='3'; break;
		case 'Geita': $result_st='27'; break;
		case 'Iringa': $result_st='4'; break;
		case 'Kagera': $result_st='5'; break;
		case 'Kaskazini Pemba': $result_st='6'; break;
		case 'Kaskazini Unguja': $result_st='7'; break;
		case 'Katavi': $result_st='28'; break;
		case 'Kigoma': $result_st='8'; break;
		case 'Kilimanjaro': $result_st='9'; break;
		case 'Kusini Pemba': $result_st='10'; break;
		case 'Kusini Unguja': $result_st='11'; break;
		case 'Lindi': $result_st='12'; break;
		case 'Manyara': $result_st='26'; break;
		case 'Mara': $result_st='13'; break;
		case 'Mbeya': $result_st='14'; break;
		case 'Mjini Magharibi': $result_st='15'; break;
		case 'Morogoro': $result_st='16'; break;
		case 'Mtwara': $result_st='17'; break;
		case 'Mwanza': $result_st='18'; break;
		case 'Njombe': $result_st='29'; break;
		case 'Pwani': $result_st='19'; break;
		case 'Rukwa': $result_st='20'; break;
		case 'Ruvuma': $result_st='21'; break;
		case 'Shinyanga': $result_st='22'; break;
		case 'Simiyu': $result_st='30'; break;
		case 'Singida': $result_st='23'; break;
		case 'Tabora': $result_st='24'; break;
		case 'Tanga': $result_st='25'; break;
	  }
	}
	if($country=='Thailand' || $country==$country_three){
	  switch($state){
		case 'Amnat Charoen': $result_st='37'; break;
		case 'Ang Thong': $result_st='15'; break;
		case 'Buriram': $result_st='31'; break;
		case 'Chachoengsao': $result_st='24'; break;
		case 'Chai Nat': $result_st='18'; break;
		case 'Chaiyaphum': $result_st='36'; break;
		case 'Chanthaburi': $result_st='22'; break;
		case 'Chiang Mai': $result_st='50'; break;
		case 'Chiang Rai': $result_st='57'; break;
		case 'Chon Buri': $result_st='20'; break;
		case 'Chumphon': $result_st='86'; break;
		case 'Kalasin': $result_st='46'; break;
		case 'Kamphaeng Phet': $result_st='62'; break;
		case 'Kanchanaburi': $result_st='71'; break;
		case 'Khon Kaen': $result_st='40'; break;
		case 'Krabi': $result_st='81'; break;
		case 'Krung Thep': $result_st='10'; break;
		case 'Lampang': $result_st='52'; break;
		case 'Lamphun': $result_st='51'; break;
		case 'Loei': $result_st='42'; break;
		case 'Lop Buri': $result_st='16'; break;
		case 'Mae Hong Son': $result_st='58'; break;
		case 'Maha Sarakham': $result_st='44'; break;
		case 'Mukdahan': $result_st='49'; break;
		case 'Nakhon Nayok': $result_st='26'; break;
		case 'Nakhon Pathom': $result_st='73'; break;
		case 'Nakhon Phanom': $result_st='48'; break;
		case 'Nakhon Ratchasima': $result_st='30'; break;
		case 'Nakhon Sawan': $result_st='60'; break;
		case 'Nakhon Si Thammarat': $result_st='80'; break;
		case 'Nan': $result_st='55'; break;
		case 'Narathiwat': $result_st='96'; break;
		case 'Nong Bua Lamphu': $result_st='39'; break;
		case 'Nong Khai': $result_st='43'; break;
		case 'Nonthaburi': $result_st='12'; break;
		case 'Pathum Thani': $result_st='13'; break;
		case 'Pattani': $result_st='94'; break;
		case 'Phangnga': $result_st='82'; break;
		case 'Phatthalung': $result_st='93'; break;
		case 'Phayao': $result_st='56'; break;
		case 'Phetchabun': $result_st='67'; break;
		case 'Phetchaburi': $result_st='76'; break;
		case 'Phichit': $result_st='66'; break;
		case 'Phitsanulok': $result_st='65'; break;
		case 'Phra Nakhon Si Ayutthaya': $result_st='14'; break;
		case 'Phrae': $result_st='54'; break;
		case 'Phuket': $result_st='83'; break;
		case 'Prachin Buri': $result_st='25'; break;
		case 'Prachuap Khiri Khan': $result_st='77'; break;
		case 'Ranong': $result_st='85'; break;
		case 'Ratchaburi': $result_st='70'; break;
		case 'Rayong': $result_st='21'; break;
		case 'Roi Et': $result_st='45'; break;
		case 'Sa Kaeo': $result_st='27'; break;
		case 'Sakon Nakhon': $result_st='47'; break;
		case 'Samut Prakan': $result_st='11'; break;
		case 'Samut Sakhon': $result_st='74'; break;
		case 'Samut Songkhram': $result_st='75'; break;
		case 'Saraburi': $result_st='19'; break;
		case 'Satun': $result_st='91'; break;
		case 'Sing Buri': $result_st='17'; break;
		case 'Sisaket': $result_st='33'; break;
		case 'Songkhla': $result_st='90'; break;
		case 'Sukhothai': $result_st='64'; break;
		case 'Suphan Buri': $result_st='72'; break;
		case 'Surat Thani': $result_st='84'; break;
		case 'Surin': $result_st='32'; break;
		case 'Tak': $result_st='63'; break;
		case 'Trang': $result_st='92'; break;
		case 'Trat': $result_st='23'; break;
		case 'Ubon Ratchathani': $result_st='34'; break;
		case 'Udon Thani': $result_st='41'; break;
		case 'Uthai Thani': $result_st='61'; break;
		case 'Uttaradit': $result_st='53'; break;
		case 'Yala': $result_st='95'; break;
		case 'Yasothon': $result_st='35'; break;
	  }
	}
	if($country=='Togo' || $country==$country_three){
	  switch($state){
		case 'Centrale': $result_st='C'; break;
		case 'Kara': $result_st='K'; break;
		case 'Maritime': $result_st='M'; break;
		case 'Plateaux': $result_st='P'; break;
		case 'Savanes': $result_st='S'; break;
	  }
	}
	if($country=='Tokelau' || $country==$country_three){
	  switch($state){
		case 'Tokelau': $result_st='TK'; break;
	  }
	}
	if($country=='Tonga' || $country==$country_three){
	  switch($state){
		case 'Ha': $result_st='2'; break;
		case 'Tongatapu': $result_st='4'; break;
		case 'Vava': $result_st='5'; break;
	  }
	}
	if($country=='Trinidad and Tobago' || $country==$country_three){
	  switch($state){
		case 'Arima': $result_st='ARI'; break;
		case 'Chaguanas': $result_st='CHA'; break;
		case 'Couva-Tabaquite-Talparo': $result_st='CTT'; break;
		case 'Diego Martin': $result_st='DMN'; break;
		case 'Mayaro-Rio Claro': $result_st='MRC'; break;
		case 'Penal-Debe': $result_st='PED'; break;
		case 'Point Fortin': $result_st='PTF'; break;
		case 'Port of Spain': $result_st='POS'; break;
		case 'Princes Town': $result_st='PRT'; break;
		case 'San Fernando': $result_st='SFO'; break;
		case 'San Juan-Laventille': $result_st='SJL'; break;
		case 'Sangre Grande': $result_st='SGE'; break;
		case 'Siparia': $result_st='SIP'; break;
		case 'Tobago': $result_st='TOB'; break;
		case 'Tunapuna-Piarco': $result_st='TUP'; break;
	  }
	}
	if($country=='Tunisia' || $country==$country_three){
	  switch($state){
		case 'Aiana': $result_st='12'; break;
		case 'Al Mahdia': $result_st='53'; break;
		case 'Al Munastir': $result_st='52'; break;
		case 'Bajah': $result_st='31'; break;
		case 'Ben Arous': $result_st='13'; break;
		case 'Bizerte': $result_st='23'; break;
		case 'El Kef': $result_st='33'; break;
		case 'Gabes': $result_st='81'; break;
		case 'Gafsa': $result_st='71'; break;
		case 'Jendouba': $result_st='32'; break;
		case 'Kairouan': $result_st='41'; break;
		case 'Kasserine': $result_st='42'; break;
		case 'Kebili': $result_st='73'; break;
		case 'Madanin': $result_st='82'; break;
		case 'Manouba': $result_st='14'; break;
		case 'Nabeul': $result_st='21'; break;
		case 'Sfax': $result_st='61'; break;
		case 'Sidi Bou Zid': $result_st='43'; break;
		case 'Siliana': $result_st='34'; break;
		case 'Sousse': $result_st='51'; break;
		case 'Tataouine': $result_st='83'; break;
		case 'Tozeur': $result_st='72'; break;
		case 'Tunis': $result_st='11'; break;
		case 'Zaghouan': $result_st='22'; break;
	  }
	}
	if($country=='Turkey' || $country==$country_three){
	  switch($state){
		case 'Adana': $result_st='1'; break;
		case 'Adiyaman': $result_st='2'; break;
		case 'Afyonkarahisar': $result_st='3'; break;
		case 'Agri': $result_st='4'; break;
		case 'Aksaray': $result_st='68'; break;
		case 'Amasya': $result_st='5'; break;
		case 'Ankara': $result_st='6'; break;
		case 'Antalya': $result_st='7'; break;
		case 'Ardahan': $result_st='75'; break;
		case 'Artvin': $result_st='8'; break;
		case 'Aydin': $result_st='9'; break;
		case 'Balikesir': $result_st='10'; break;
		case 'Bartin': $result_st='74'; break;
		case 'Batman': $result_st='72'; break;
		case 'Bayburt': $result_st='69'; break;
		case 'Bilecik': $result_st='11'; break;
		case 'Bingol': $result_st='12'; break;
		case 'Bitlis': $result_st='13'; break;
		case 'Bolu': $result_st='14'; break;
		case 'Burdur': $result_st='15'; break;
		case 'Bursa': $result_st='16'; break;
		case 'Canakkale': $result_st='17'; break;
		case 'Cankiri': $result_st='18'; break;
		case 'Corum': $result_st='19'; break;
		case 'Denizli': $result_st='20'; break;
		case 'Diyarbakir': $result_st='21'; break;
		case 'Duzce': $result_st='81'; break;
		case 'Edirne': $result_st='22'; break;
		case 'Elazig': $result_st='23'; break;
		case 'Erzincan': $result_st='24'; break;
		case 'Erzurum': $result_st='25'; break;
		case 'Eskisehir': $result_st='26'; break;
		case 'Gaziantep': $result_st='27'; break;
		case 'Giresun': $result_st='28'; break;
		case 'Gumushane': $result_st='29'; break;
		case 'Hakkari': $result_st='30'; break;
		case 'Hatay': $result_st='31'; break;
		case 'Igdir': $result_st='76'; break;
		case 'Isparta': $result_st='32'; break;
		case 'Istanbul': $result_st='34'; break;
		case 'Izmir': $result_st='35'; break;
		case 'Kahramanmaras': $result_st='46'; break;
		case 'Karabuk': $result_st='78'; break;
		case 'Karaman': $result_st='70'; break;
		case 'Kars': $result_st='36'; break;
		case 'Kastamonu': $result_st='37'; break;
		case 'Kayseri': $result_st='38'; break;
		case 'Kilis': $result_st='79'; break;
		case 'Kirikkale': $result_st='71'; break;
		case 'Kirklareli': $result_st='39'; break;
		case 'Kirsehir': $result_st='40'; break;
		case 'Kocaeli': $result_st='41'; break;
		case 'Konya': $result_st='42'; break;
		case 'Kutahya': $result_st='43'; break;
		case 'Malatya': $result_st='44'; break;
		case 'Manisa': $result_st='45'; break;
		case 'Mardin': $result_st='47'; break;
		case 'Mersin': $result_st='33'; break;
		case 'Mugla': $result_st='48'; break;
		case 'Mus': $result_st='49'; break;
		case 'Nevsehir': $result_st='50'; break;
		case 'Nigde': $result_st='51'; break;
		case 'Ordu': $result_st='52'; break;
		case 'Osmaniye': $result_st='80'; break;
		case 'Rize': $result_st='53'; break;
		case 'Sakarya': $result_st='54'; break;
		case 'Samsun': $result_st='55'; break;
		case 'Sanliurfa': $result_st='63'; break;
		case 'Siirt': $result_st='56'; break;
		case 'Sinop': $result_st='57'; break;
		case 'Sirnak': $result_st='73'; break;
		case 'Sivas': $result_st='58'; break;
		case 'Tekirdag': $result_st='59'; break;
		case 'Tokat': $result_st='60'; break;
		case 'Trabzon': $result_st='61'; break;
		case 'Tunceli': $result_st='62'; break;
		case 'Usak': $result_st='64'; break;
		case 'Van': $result_st='65'; break;
		case 'Yalova': $result_st='77'; break;
		case 'Yozgat': $result_st='66'; break;
		case 'Zonguldak': $result_st='67'; break;
	  }
	}
	if($country=='Turkmenistan' || $country==$country_three){
	  switch($state){
		case 'Ahal': $result_st='A'; break;
		case 'Balkan': $result_st='B'; break;
		case 'Dashoguz': $result_st='D'; break;
		case 'Lebap': $result_st='L'; break;
		case 'Mary': $result_st='M'; break;
	  }
	}
	if($country=='Turks and Caicos Islands' || $country==$country_three){
	  switch($state){
		case 'Turks and Caicos Islands': $result_st='TC'; break;
	  }
	}
	if($country=='Tuvalu' || $country==$country_three){
	  switch($state){
		case 'Tuvalu': $result_st='TV'; break;
	  }
	}
	if($country=='U.S. Minor Outlying Islands' || $country==$country_three){
	  switch($state){
		case 'Palmyra Atoll': $result_st='95'; break;
	  }
	}
	if($country=='U.S. Virgin Islands' || $country==$country_three){
	  switch($state){
		case 'Virgin Islands, U.S.': $result_st='VI'; break;
	  }
	}
	if($country=='Uganda' || $country==$country_three){
	  switch($state){
		case 'Abim': $result_st='317'; break;
		case 'Adjumani': $result_st='301'; break;
		case 'Agago': $result_st='322'; break;
		case 'Alebtong': $result_st='323'; break;
		case 'Amolatar': $result_st='314'; break;
		case 'Amudat': $result_st='324'; break;
		case 'Amuria': $result_st='216'; break;
		case 'Amuru': $result_st='319'; break;
		case 'Apac': $result_st='302'; break;
		case 'Arua': $result_st='303'; break;
		case 'Budaka': $result_st='217'; break;
		case 'Bududa': $result_st='223'; break;
		case 'Bugiri': $result_st='201'; break;
		case 'Buhweju': $result_st='325'; break;
		case 'Buikwe': $result_st='117'; break;
		case 'Bukedea': $result_st='224'; break;
		case 'Bukomansibi': $result_st='118'; break;
		case 'Bukwa': $result_st='218'; break;
		case 'Bulambuli': $result_st='225'; break;
		case 'Buliisa': $result_st='419'; break;
		case 'Bundibugyo': $result_st='401'; break;
		case 'Bushenyi': $result_st='402'; break;
		case 'Busia': $result_st='202'; break;
		case 'Butaleja': $result_st='219'; break;
		case 'Butambala': $result_st='119'; break;
		case 'Buvuma': $result_st='120'; break;
		case 'Buyende': $result_st='226'; break;
		case 'Dokolo': $result_st='318'; break;
		case 'Gomba': $result_st='121'; break;
		case 'Gulu': $result_st='304'; break;
		case 'Hoima': $result_st='403'; break;
		case 'Ibanda': $result_st='416'; break;
		case 'Iganga': $result_st='203'; break;
		case 'Isingiro': $result_st='417'; break;
		case 'Jinja': $result_st='204'; break;
		case 'Kaabong': $result_st='315'; break;
		case 'Kabale': $result_st='404'; break;
		case 'Kabarole': $result_st='405'; break;
		case 'Kaberamaido': $result_st='213'; break;
		case 'Kalangala': $result_st='101'; break;
		case 'Kaliro': $result_st='220'; break;
		case 'Kalungu': $result_st='122'; break;
		case 'Kampala': $result_st='102'; break;
		case 'Kamuli': $result_st='205'; break;
		case 'Kamwenge': $result_st='413'; break;
		case 'Kanungu': $result_st='414'; break;
		case 'Kapchorwa': $result_st='206'; break;
		case 'Kasese': $result_st='406'; break;
		case 'Katakwi': $result_st='207'; break;
		case 'Kayunga': $result_st='112'; break;
		case 'Kibaale': $result_st='407'; break;
		case 'Kiboga': $result_st='103'; break;
		case 'Kibuku': $result_st='227'; break;
		case 'Kiruhura': $result_st='418'; break;
		case 'Kiryandongo': $result_st='420'; break;
		case 'Kisoro': $result_st='408'; break;
		case 'Kitgum': $result_st='305'; break;
		case 'Koboko': $result_st='316'; break;
		case 'Kole': $result_st='326'; break;
		case 'Kotido': $result_st='306'; break;
		case 'Kumi': $result_st='208'; break;
		case 'Kween': $result_st='228'; break;
		case 'Kyankwanzi': $result_st='123'; break;
		case 'Kyegegwa': $result_st='421'; break;
		case 'Kyenjojo': $result_st='415'; break;
		case 'Lamwo': $result_st='327'; break;
		case 'Lira': $result_st='307'; break;
		case 'Luuka': $result_st='229'; break;
		case 'Luwero': $result_st='104'; break;
		case 'Lwengo': $result_st='124'; break;
		case 'Lyantonde': $result_st='116'; break;
		case 'Manafwa': $result_st='221'; break;
		case 'Maracha': $result_st='320'; break;
		case 'Masaka': $result_st='105'; break;
		case 'Masindi': $result_st='409'; break;
		case 'Mayuge': $result_st='214'; break;
		case 'Mbale': $result_st='209'; break;
		case 'Mbarara': $result_st='410'; break;
		case 'Mitooma': $result_st='422'; break;
		case 'Mityana': $result_st='114'; break;
		case 'Moroto': $result_st='308'; break;
		case 'Moyo': $result_st='309'; break;
		case 'Mpigi': $result_st='106'; break;
		case 'Mubende': $result_st='107'; break;
		case 'Mukono': $result_st='108'; break;
		case 'Nakapiripirit': $result_st='311'; break;
		case 'Nakaseke': $result_st='115'; break;
		case 'Nakasongola': $result_st='109'; break;
		case 'Namayingo': $result_st='230'; break;
		case 'Namutumba': $result_st='222'; break;
		case 'Napak': $result_st='328'; break;
		case 'Nebbi': $result_st='310'; break;
		case 'Ngora': $result_st='231'; break;
		case 'Ntoroko': $result_st='423'; break;
		case 'Ntungamo': $result_st='411'; break;
		case 'Nwoya': $result_st='329'; break;
		case 'Otuke': $result_st='330'; break;
		case 'Oyam': $result_st='321'; break;
		case 'Pader': $result_st='312'; break;
		case 'Pallisa': $result_st='210'; break;
		case 'Rakai': $result_st='110'; break;
		case 'Rubirizi': $result_st='424'; break;
		case 'Rukungiri': $result_st='412'; break;
		case 'Sembabule': $result_st='111'; break;
		case 'Serere': $result_st='232'; break;
		case 'Sheema': $result_st='425'; break;
		case 'Sironko': $result_st='215'; break;
		case 'Soroti': $result_st='211'; break;
		case 'Tororo': $result_st='212'; break;
		case 'Wakiso': $result_st='113'; break;
		case 'Yumbe': $result_st='313'; break;
		case 'Zombo': $result_st='331'; break;
	  }
	}
	if($country=='Ukraine' || $country==$country_three){
	  switch($state){
		case 'Cherkaska Oblast': $result_st='71'; break;
		case 'Chernihivska Oblast': $result_st='74'; break;
		case 'Chernivetska Oblast': $result_st='77'; break;
		case 'Dnipropetrovska Oblast': $result_st='12'; break;
		case 'Donetska Oblast': $result_st='14'; break;
		case 'Ivano-Frankivska Oblast': $result_st='26'; break;
		case 'Kharkivska Oblast': $result_st='63'; break;
		case 'Khersonska Oblast': $result_st='65'; break;
		case 'Khmelnytska Oblast': $result_st='68'; break;
		case 'Kirovohradska Oblast': $result_st='35'; break;
		case 'Krym': $result_st='43'; break;
		case 'Kyyiv': $result_st='30'; break;
		case 'Kyyivska Oblast': $result_st='32'; break;
		case 'Lvivska Oblast': $result_st='46'; break;
		case 'Luhanska Oblast': $result_st='9'; break;
		case 'Mykolayivska Oblast': $result_st='48'; break;
		case 'Odeska Oblast': $result_st='51'; break;
		case 'Poltavska Oblast': $result_st='53'; break;
		case 'Rivnenska Oblast': $result_st='56'; break;
		case 'Sevastopol': $result_st='40'; break;
		case 'Sumska Oblast': $result_st='59'; break;
		case 'Ternopilska Oblast': $result_st='61'; break;
		case 'Vinnytska Oblast': $result_st='5'; break;
		case 'Volynska Oblast': $result_st='7'; break;
		case 'Zakarpatska Oblast': $result_st='21'; break;
		case 'Zaporizka Oblast': $result_st='23'; break;
		case 'Zhytomyrska Oblast': $result_st='18'; break;
	  }
	}
	if($country=='United Arab Emirates' || $country==$country_three){
	  switch($state){
		case 'Abu Dhabi': $result_st='AZ'; break;
		case 'Ajman': $result_st='AJ'; break;
		case 'Dubai': $result_st='DU'; break;
		case 'Fujairah': $result_st='FU'; break;
		case 'Ras Al Khaimah': $result_st='RK'; break;
		case 'Sharjah': $result_st='SH'; break;
		case 'Umm Al Quwain': $result_st='UQ'; break;
	  }
	}
	if($country=='United Kingdom' || $country==$country_three){
	  switch($state){
		case 'England': $result_st='ENG'; break;
		case 'Northern Ireland': $result_st='NIR'; break;
		case 'Scotland': $result_st='SCT'; break;
		case 'Wales': $result_st='WLS'; break;
		case 'Aberdeen City': $result_st='ABE'; break;
		case 'Aberdeenshire': $result_st='ABD'; break;
		case 'Angus': $result_st='ANS'; break;
		case 'Antrim': $result_st='ANT'; break;
		case 'Ards': $result_st='ARD'; break;
		case 'Argyll and Bute': $result_st='AGB'; break;
		case 'Armagh': $result_st='ARM'; break;
		case 'Ballymena': $result_st='BLA'; break;
		case 'Ballymoney': $result_st='BLY'; break;
		case 'Banbridge': $result_st='BNB'; break;
		case 'Barking and Dagenham': $result_st='BDG'; break;
		case 'Barnet': $result_st='BNE'; break;
		case 'Barnsley': $result_st='BNS'; break;
		case 'Bath and North East Somerset': $result_st='BAS'; break;
		case 'Bedfordshire': $result_st='BDF'; break;
		case 'Belfast': $result_st='BFS'; break;
		case 'Bexley': $result_st='BEX'; break;
		case 'Birmingham': $result_st='BIR'; break;
		case 'Blackburn with Darwen': $result_st='BBD'; break;
		case 'Blackpool': $result_st='BPL'; break;
		case 'Blaenau Gwent': $result_st='BGW'; break;
		case 'Bolton': $result_st='BOL'; break;
		case 'Bournemouth': $result_st='BMH'; break;
		case 'Bracknell Forest': $result_st='BRC'; break;
		case 'Bradford': $result_st='BRD'; break;
		case 'Brent': $result_st='BEN'; break;
		case 'Bridgend [Pen-y-bont ar Ogwr GB-POG]': $result_st='BGE'; break;
		case 'Brighton and Hove': $result_st='BNH'; break;
		case 'City of Bristol': $result_st='BST'; break;
		case 'Bromley': $result_st='BRY'; break;
		case 'Buckinghamshire': $result_st='BKM'; break;
		case 'Bury': $result_st='BUR'; break;
		case 'Caerphilly [Caerffili GB-CAF]': $result_st='CAY'; break;
		case 'Calderdale': $result_st='CLD'; break;
		case 'Cambridgeshire': $result_st='CAM'; break;
		case 'Camden': $result_st='CMD'; break;
		case 'Cardiff [Caerdydd GB-CRD]': $result_st='CRF'; break;
		case 'Carmarthenshire [Sir Gaerfyrddin GB-GFY]': $result_st='CMN'; break;
		case 'Carrickfergus': $result_st='CKF'; break;
		case 'Castlereagh': $result_st='CSR'; break;
		case 'Ceredigion [Sir Ceredigion]': $result_st='CGN'; break;
		case 'Cheshire': $result_st='CHS'; break;
		case 'Clackmannanshire': $result_st='CLK'; break;
		case 'Coleraine': $result_st='CLR'; break;
		case 'Conwy': $result_st='CWY'; break;
		case 'Cookstown': $result_st='CKT'; break;
		case 'Cornwall': $result_st='CON'; break;
		case 'Coventry': $result_st='COV'; break;
		case 'Craigavon': $result_st='CGV'; break;
		case 'Croydon': $result_st='CRY'; break;
		case 'Cumbria': $result_st='CMA'; break;
		case 'Darlington': $result_st='DAL'; break;
		case 'Denbighshire [Sir Ddinbych GB-DDB]': $result_st='DEN'; break;
		case 'Derby': $result_st='DER'; break;
		case 'Derbyshire': $result_st='DBY'; break;
		case 'Derry': $result_st='DRY'; break;
		case 'Devon': $result_st='DEV'; break;
		case 'Doncaster': $result_st='DNC'; break;
		case 'Dorset': $result_st='DOR'; break;
		case 'Down': $result_st='DOW'; break;
		case 'Dudley': $result_st='DUD'; break;
		case 'Dumfries and Galloway': $result_st='DGY'; break;
		case 'Dundee City': $result_st='DND'; break;
		case 'Dungannon and South Tyrone': $result_st='DGN'; break;
		case 'Durham': $result_st='DUR'; break;
		case 'Ealing': $result_st='EAL'; break;
		case 'East Ayrshire': $result_st='EAY'; break;
		case 'East Dunbartonshire': $result_st='EDU'; break;
		case 'East Lothian': $result_st='ELN'; break;
		case 'East Renfrewshire': $result_st='ERW'; break;
		case 'East Riding of Yorkshire': $result_st='ERY'; break;
		case 'East Sussex': $result_st='ESX'; break;
		case 'City of Edinburgh': $result_st='EDH'; break;
		case 'Eilean Siar': $result_st='ELS'; break;
		case 'Enfield': $result_st='ENF'; break;
		case 'Essex': $result_st='ESS'; break;
		case 'Falkirk': $result_st='FAL'; break;
		case 'Fermanagh': $result_st='FER'; break;
		case 'Fife': $result_st='FIF'; break;
		case 'Flintshire [Sir y Fflint GB-FFL]': $result_st='FLN'; break;
		case 'Gateshead': $result_st='GAT'; break;
		case 'Glasgow City': $result_st='GLG'; break;
		case 'Gloucestershire': $result_st='GLS'; break;
		case 'Greenwich': $result_st='GRE'; break;
		case 'Gwynedd': $result_st='GWN'; break;
		case 'Hackney': $result_st='HCK'; break;
		case 'Halton': $result_st='HAL'; break;
		case 'Hammersmith and Fulham': $result_st='HMF'; break;
		case 'Hampshire': $result_st='HAM'; break;
		case 'Haringey': $result_st='HRY'; break;
		case 'Harrow': $result_st='HRW'; break;
		case 'Hartlepool': $result_st='HPL'; break;
		case 'Havering': $result_st='HAV'; break;
		case 'County of Herefordshire': $result_st='HEF'; break;
		case 'Hertfordshire': $result_st='HRT'; break;
		case 'Highland': $result_st='HLD'; break;
		case 'Hillingdon': $result_st='HIL'; break;
		case 'Hounslow': $result_st='HNS'; break;
		case 'Inverclyde': $result_st='IVC'; break;
		case 'Isle of Anglesey [Sir Ynys Môn GB-YNM]': $result_st='AGY'; break;
		case 'Isle of Wight': $result_st='IOW'; break;
		case 'Isles of Scilly': $result_st='IOS'; break;
		case 'Islington': $result_st='ISL'; break;
		case 'Kensington and Chelsea': $result_st='KEC'; break;
		case 'Kent': $result_st='KEN'; break;
		case 'City of Kingston upon Hull': $result_st='KHL'; break;
		case 'Kingston upon Thames': $result_st='KTT'; break;
		case 'Kirklees': $result_st='KIR'; break;
		case 'Knowsley': $result_st='KWL'; break;
		case 'Lambeth': $result_st='LBH'; break;
		case 'Lancashire': $result_st='LAN'; break;
		case 'Larne': $result_st='LRN'; break;
		case 'Leeds': $result_st='LDS'; break;
		case 'Leicester': $result_st='LCE'; break;
		case 'Leicestershire': $result_st='LEC'; break;
		case 'Lewisham': $result_st='LEW'; break;
		case 'Limavady': $result_st='LMV'; break;
		case 'Lincolnshire': $result_st='LIN'; break;
		case 'Lisburn': $result_st='LSB'; break;
		case 'Liverpool': $result_st='LIV'; break;
		case 'City of London': $result_st='LND'; break;
		case 'Luton': $result_st='LUT'; break;
		case 'Magherafelt': $result_st='MFT'; break;
		case 'Manchester': $result_st='MAN'; break;
		case 'Medway': $result_st='MDW'; break;
		case 'Merthyr Tydfil [Merthyr Tudful GB-MTU]': $result_st='MTY'; break;
		case 'Merton': $result_st='MRT'; break;
		case 'Middlesbrough': $result_st='MDB'; break;
		case 'Midlothian': $result_st='MLN'; break;
		case 'Milton Keynes': $result_st='MIK'; break;
		case 'Monmouthshire [Sir Fynwy GB-FYN]': $result_st='MON'; break;
		case 'Moray': $result_st='MRY'; break;
		case 'Moyle': $result_st='MYL'; break;
		case 'Neath Port Talbot [Castell-nedd Port Talbot GB-CTL]': $result_st='NTL'; break;
		case 'Newcastle upon Tyne': $result_st='NET'; break;
		case 'Newham': $result_st='NWM'; break;
		case 'Newport [Casnewydd GB-CNW]': $result_st='NWP'; break;
		case 'Newry and Mourne': $result_st='NYM'; break;
		case 'Newtownabbey': $result_st='NTA'; break;
		case 'Norfolk': $result_st='NFK'; break;
		case 'North Ayrshire': $result_st='NAY'; break;
		case 'North Down': $result_st='NDN'; break;
		case 'North East Lincolnshire': $result_st='NEL'; break;
		case 'North Lanarkshire': $result_st='NLK'; break;
		case 'North Lincolnshire': $result_st='NLN'; break;
		case 'North Somerset': $result_st='NSM'; break;
		case 'North Tyneside': $result_st='NTY'; break;
		case 'North Yorkshire': $result_st='NYK'; break;
		case 'Northamptonshire': $result_st='NTH'; break;
		case 'Northumberland': $result_st='NBL'; break;
		case 'Nottingham': $result_st='NGM'; break;
		case 'Nottinghamshire': $result_st='NTT'; break;
		case 'Oldham': $result_st='OLD'; break;
		case 'Omagh': $result_st='OMH'; break;
		case 'Orkney Islands': $result_st='ORK'; break;
		case 'Oxfordshire': $result_st='OXF'; break;
		case 'Pembrokeshire [Sir Benfro GB-BNF]': $result_st='PEM'; break;
		case 'Perth and Kinross': $result_st='PKN'; break;
		case 'Peterborough': $result_st='PTE'; break;
		case 'Plymouth': $result_st='PLY'; break;
		case 'Poole': $result_st='POL'; break;
		case 'Portsmouth': $result_st='POR'; break;
		case 'Powys': $result_st='POW'; break;
		case 'Reading': $result_st='RDG'; break;
		case 'Redbridge': $result_st='RDB'; break;
		case 'Redcar and Cleveland': $result_st='RCC'; break;
		case 'Renfrewshire': $result_st='RFW'; break;
		case 'Cynon Rhondda': $result_st='RCT'; break;
		case 'Richmond upon Thames': $result_st='RIC'; break;
		case 'Rochdale': $result_st='RCH'; break;
		case 'Rotherham': $result_st='ROT'; break;
		case 'Rutland': $result_st='RUT'; break;
		case 'Salford': $result_st='SLF'; break;
		case 'Sandwell': $result_st='SAW'; break;
		case 'The Scottish Borders': $result_st='SCB'; break;
		case 'Sefton': $result_st='SFT'; break;
		case 'Sheffield': $result_st='SHF'; break;
		case 'Shetland Islands': $result_st='ZET'; break;
		case 'Shropshire': $result_st='SHR'; break;
		case 'Slough': $result_st='SLG'; break;
		case 'Solihull': $result_st='SOL'; break;
		case 'Somerset': $result_st='SOM'; break;
		case 'South Ayrshire': $result_st='SAY'; break;
		case 'South Gloucestershire': $result_st='SGC'; break;
		case 'South Lanarkshire': $result_st='SLK'; break;
		case 'South Tyneside': $result_st='STY'; break;
		case 'Southampton': $result_st='STH'; break;
		case 'Southend-on-Sea': $result_st='SOS'; break;
		case 'Southwark': $result_st='SWK'; break;
		case 'St. Helens': $result_st='SHN'; break;
		case 'Staffordshire': $result_st='STS'; break;
		case 'Stirling': $result_st='STG'; break;
		case 'Stockport': $result_st='SKP'; break;
		case 'Stockton-on-Tees': $result_st='STT'; break;
		case 'Stoke-on-Trent': $result_st='STE'; break;
		case 'Strabane': $result_st='STB'; break;
		case 'Suffolk': $result_st='SFK'; break;
		case 'Sunderland': $result_st='SND'; break;
		case 'Surrey': $result_st='SRY'; break;
		case 'Sutton': $result_st='STN'; break;
		case 'Swansea [Abertawe GB-ATA]': $result_st='SWA'; break;
		case 'Swindon': $result_st='SWD'; break;
		case 'Tameside': $result_st='TAM'; break;
		case 'Telford and Wrekin': $result_st='TFW'; break;
		case 'Thurrock': $result_st='THR'; break;
		case 'Torbay': $result_st='TOB'; break;
		case 'Torfaen [Tor-faen]': $result_st='TOF'; break;
		case 'Tower Hamlets': $result_st='TWH'; break;
		case 'Trafford': $result_st='TRF'; break;
		case 'The [Bro Morgannwg GB-BMG] Vale of Glamorgan': $result_st='VGL'; break;
		case 'Wakefield': $result_st='WKF'; break;
		case 'Walsall': $result_st='WLL'; break;
		case 'Waltham Forest': $result_st='WFT'; break;
		case 'Wandsworth': $result_st='WND'; break;
		case 'Warrington': $result_st='WRT'; break;
		case 'Warwickshire': $result_st='WAR'; break;
		case 'West Berkshire': $result_st='WBK'; break;
		case 'West Dunbartonshire': $result_st='WDU'; break;
		case 'West Lothian': $result_st='WLN'; break;
		case 'West Sussex': $result_st='WSX'; break;
		case 'Westminster': $result_st='WSM'; break;
		case 'Wigan': $result_st='WGN'; break;
		case 'Wiltshire': $result_st='WIL'; break;
		case 'Windsor and Maidenhead': $result_st='WNM'; break;
		case 'Wirral': $result_st='WRL'; break;
		case 'Wokingham': $result_st='WOK'; break;
		case 'Wolverhampton': $result_st='WLV'; break;
		case 'Worcestershire': $result_st='WOR'; break;
		case 'Wrexham [Wrecsam GB-WRC]': $result_st='WRX'; break;
		case 'York': $result_st='YOR'; break;
	  }
	}
	if($country=='United States' || $country==$country_three){
	  switch($state){
		case 'Alabama': $result_st='AL'; break;
		case 'Alaska': $result_st='AK'; break;
		case 'Arizona': $result_st='AZ'; break;
		case 'Arkansas': $result_st='AR'; break;
		case 'California': $result_st='CA'; break;
		case 'Colorado': $result_st='CO'; break;
		case 'Connecticut': $result_st='CT'; break;
		case 'Delaware': $result_st='DE'; break;
		case 'District Of Columbia': $result_st='DC'; break;
		case 'Florida': $result_st='FL'; break;
		case 'Georgia': $result_st='GA'; break;
		case 'Hawaii': $result_st='HI'; break;
		case 'Idaho': $result_st='ID'; break;
		case 'Illinois': $result_st='IL'; break;
		case 'Indiana': $result_st='IN'; break;
		case 'Iowa': $result_st='IA'; break;
		case 'Kansas': $result_st='KS'; break;
		case 'Kentucky': $result_st='KY'; break;
		case 'Louisiana': $result_st='LA'; break;
		case 'Maine': $result_st='ME'; break;
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
		case 'Ohio': $result_st='OH'; break;
		case 'Oklahoma': $result_st='OK'; break;
		case 'Oregon': $result_st='OR'; break;
		case 'Pennsylvania': $result_st='PA'; break;
		case 'Rhode Island': $result_st='RI'; break;
		case 'South Carolina': $result_st='SC'; break;
		case 'South Dakota': $result_st='SD'; break;
		case 'Tennessee': $result_st='TN'; break;
		case 'Texas': $result_st='TX'; break;
		case 'Utah': $result_st='UT'; break;
		case 'Vermont': $result_st='VT'; break;
		case 'Virginia': $result_st='VA'; break;
		case 'Washington': $result_st='WA'; break;
		case 'West Virginia': $result_st='WV'; break;
		case 'Wisconsin': $result_st='WI'; break;
		case 'Wyoming': $result_st='WY'; break;
		case 'Armed Forces - Americas': $result_st='AA'; break;
		case 'Armed Forces - Europe': $result_st='AE'; break;
		case 'Armed Forces - Pacific': $result_st='AP'; break;
	  }
	}
	if($country=='Uruguay' || $country==$country_three){
	  switch($state){
		case 'Artigas': $result_st='AR'; break;
		case 'Canelones': $result_st='CA'; break;
		case 'Cerro Largo': $result_st='CL'; break;
		case 'Colonia': $result_st='CO'; break;
		case 'Durazno': $result_st='DU'; break;
		case 'Flores': $result_st='FS'; break;
		case 'Florida': $result_st='FD'; break;
		case 'Lavalleja': $result_st='LA'; break;
		case 'Maldonado': $result_st='MA'; break;
		case 'Montevideo': $result_st='MO'; break;
		case 'Paysandu': $result_st='PA'; break;
		case 'Rio Negro': $result_st='RN'; break;
		case 'Rivera': $result_st='RV'; break;
		case 'Rocha': $result_st='RO'; break;
		case 'Salto': $result_st='SA'; break;
		case 'San Jose': $result_st='SJ'; break;
		case 'Soriano': $result_st='SO'; break;
		case 'Tacuarembo': $result_st='TA'; break;
		case 'Treinta y Tres': $result_st='TT'; break;
	  }
	}
	if($country=='Uzbekistan' || $country==$country_three){
	  switch($state){
		case 'Andijon': $result_st='AN'; break;
		case 'Bukhoro': $result_st='BU'; break;
		case 'Farghona': $result_st='FA'; break;
		case 'Jizzax': $result_st='JI'; break;
		case 'Khorazm': $result_st='KH'; break;
		case 'Namangan': $result_st='NG'; break;
		case 'Nawoiy': $result_st='NW'; break;
		case 'Qashqadaryo': $result_st='QA'; break;
		case 'Qoraqalpoghiston': $result_st='QR'; break;
		case 'Samarqand': $result_st='SA'; break;
		case 'Sirdaryo': $result_st='SI'; break;
		case 'Surkhondaryo': $result_st='SU'; break;
		case 'Toshkent Shahri': $result_st='TK'; break;
		case 'Toshkent': $result_st='TO'; break;
		case 'Malampa': $result_st='MAP'; break;
		case 'Sanma': $result_st='SAM'; break;
		case 'Shefa': $result_st='SEE'; break;
		case 'Tafea': $result_st='TAE'; break;
		case 'Torba': $result_st='TOB'; break;
		case 'Holy See': $result_st='VA'; break;
		case 'Amazonas': $result_st='Z'; break;
		case 'Anzoategui': $result_st='B'; break;
		case 'Apure': $result_st='C'; break;
		case 'Aragua': $result_st='D'; break;
		case 'Barinas': $result_st='E'; break;
		case 'Bolivar': $result_st='F'; break;
		case 'Carabobo': $result_st='G'; break;
		case 'Cojedes': $result_st='H'; break;
		case 'Delta Amacuro': $result_st='Y'; break;
		case 'Distrito Federal': $result_st='A'; break;
		case 'Falcon': $result_st='I'; break;
		case 'Guarico': $result_st='J'; break;
		case 'Lara': $result_st='K'; break;
		case 'Merida': $result_st='L'; break;
		case 'Miranda': $result_st='M'; break;
		case 'Monagas': $result_st='N'; break;
		case 'Nueva Esparta': $result_st='O'; break;
		case 'Portuguesa': $result_st='P'; break;
		case 'Sucre': $result_st='R'; break;
		case 'Tachira': $result_st='S'; break;
		case 'Trujillo': $result_st='T'; break;
		case 'Vargas': $result_st='X'; break;
		case 'Yaracuy': $result_st='U'; break;
		case 'Zulia': $result_st='V'; break;
	  }
	}
	if($country=='Vietnam' || $country==$country_three){
	  switch($state){
		case 'An Giang': $result_st='44'; break;
		case 'Ba Ria-Vung Tau': $result_st='43'; break;
		case 'Bac Giang': $result_st='54'; break;
		case 'Bac Kan': $result_st='53'; break;
		case 'Bac Lieu': $result_st='55'; break;
		case 'Bac Ninh': $result_st='56'; break;
		case 'Ben Tre': $result_st='50'; break;
		case 'Binh Dinh': $result_st='31'; break;
		case 'Binh Duong': $result_st='57'; break;
		case 'Binh Phuoc': $result_st='58'; break;
		case 'Binh Thuan': $result_st='40'; break;
		case 'Ca Mau': $result_st='59'; break;
		case 'Can Tho': $result_st='CT'; break;
		case 'Cao Bang': $result_st='4'; break;
		case 'Da Nang': $result_st='DN'; break;
		case 'Dak Lak': $result_st='33'; break;
		case 'Dak Nong': $result_st='72'; break;
		case 'Dien Bien': $result_st='71'; break;
		case 'Dong Nai': $result_st='39'; break;
		case 'Dong Thap': $result_st='45'; break;
		case 'Gia Lai': $result_st='30'; break;
		case 'Ha Giang': $result_st='3'; break;
		case 'Ha Nam': $result_st='63'; break;
		case 'Ha Noi': $result_st='HN'; break;
		case 'Ha Tinh': $result_st='23'; break;
		case 'Hai Duong': $result_st='61'; break;
		case 'Hai Phong': $result_st='HP'; break;
		case 'Hau Giang': $result_st='73'; break;
		case 'Ho Chi Minh': $result_st='SG'; break;
		case 'Hoa Binh': $result_st='14'; break;
		case 'Hung Yen': $result_st='66'; break;
		case 'Khanh Hoa': $result_st='34'; break;
		case 'Kien Giang': $result_st='47'; break;
		case 'Kon Tum': $result_st='28'; break;
		case 'Lai Chau': $result_st='1'; break;
		case 'Lam Dong': $result_st='35'; break;
		case 'Lang Son': $result_st='9'; break;
		case 'Lao Cai': $result_st='2'; break;
		case 'Long An': $result_st='41'; break;
		case 'Nam Dinh': $result_st='67'; break;
		case 'Nghe An': $result_st='22'; break;
		case 'Ninh Binh': $result_st='18'; break;
		case 'Ninh Thuan': $result_st='36'; break;
		case 'Phu Tho': $result_st='68'; break;
		case 'Phu Yen': $result_st='32'; break;
		case 'Quang Binh': $result_st='24'; break;
		case 'Quang Nam': $result_st='27'; break;
		case 'Quang Ngai': $result_st='29'; break;
		case 'Quang Ninh': $result_st='13'; break;
		case 'Quang Tri': $result_st='25'; break;
		case 'Soc Trang': $result_st='52'; break;
		case 'Son La': $result_st='5'; break;
		case 'Tay Ninh': $result_st='37'; break;
		case 'Thai Binh': $result_st='20'; break;
		case 'Thai Nguyen': $result_st='69'; break;
		case 'Thanh Hoa': $result_st='21'; break;
		case 'Thua Thien-Hue': $result_st='26'; break;
		case 'Tien Giang': $result_st='46'; break;
		case 'Tra Vinh': $result_st='51'; break;
		case 'Tuyen Quang': $result_st='7'; break;
		case 'Vinh Long': $result_st='49'; break;
		case 'Vinh Phuc': $result_st='70'; break;
		case 'Yen Bai': $result_st='6'; break;
	  }
	}
	if($country=='Wallis and Futuna' || $country==$country_three){
	  switch($state){
		case 'Wallis and Futuna': $result_st='WF'; break;
	  }
	}
	if($country=='Yemen' || $country==$country_three){
	  switch($state){
		case 'Amanat al Asimah': $result_st='SA'; break;
		case 'Abyan': $result_st='AB'; break;
		case 'Adan': $result_st='AD'; break;
		case 'Ad Dali': $result_st='DA'; break;
		case 'Al Bayda': $result_st='BA'; break;
		case 'Al Hudaydah': $result_st='HU'; break;
		case 'Al Jawf': $result_st='JA'; break;
		case 'Al Mahrah': $result_st='MR'; break;
		case 'Al Mahwit': $result_st='MW'; break;
		case 'Amran': $result_st='AM'; break;
		case 'Arkhabil Suqutra': $result_st='SU'; break;
		case 'Dhamar': $result_st='DH'; break;
		case 'Hadramawt': $result_st='HD'; break;
		case 'Hajjah': $result_st='HJ'; break;
		case 'Ibb': $result_st='IB'; break;
		case 'Lahij': $result_st='LA'; break;
		case 'Marib': $result_st='MA'; break;
		case 'Raymah': $result_st='RA'; break;
		case 'Sadah': $result_st='SD'; break;
		case 'Sana': $result_st='SN'; break;
		case 'Shabwah': $result_st='SH'; break;
		case 'Taizz': $result_st='TA'; break;
	  }
	}
	if($country=='Zambia' || $country==$country_three){
	  switch($state){
		case 'Central': $result_st='2'; break;
		case 'Copperbelt': $result_st='8'; break;
		case 'Eastern': $result_st='3'; break;
		case 'Luapula': $result_st='4'; break;
		case 'Lusaka': $result_st='9'; break;
		case 'North-Western': $result_st='6'; break;
		case 'Northern': $result_st='5'; break;
		case 'Southern': $result_st='7'; break;
		case 'Western': $result_st='1'; break;
	  }
	}
	if($country=='Zimbabwe' || $country==$country_three){
	  switch($state){
		case 'Bulawayo': $result_st='BU'; break;
		case 'Harare': $result_st='HA'; break;
		case 'Manicaland': $result_st='MA'; break;
		case 'Mashonaland Central': $result_st='MC'; break;
		case 'Mashonaland East': $result_st='ME'; break;
		case 'Mashonaland West': $result_st='MW'; break;
		case 'Masvingo': $result_st='MV'; break;
		case 'Matabeleland North': $result_st='MN'; break;
		case 'Matabeleland South': $result_st='MS'; break;
		case 'Midlands': $result_st='MI'; break;
	  }
	}

	
	return $result_st;
}
			

function get_state_code($state,$names=0){
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
			
function get_country_code($country,$names=0,$valid=0){
	$country=str_replace(array("\r", "\n", "\t","<br>","<br/>"), array("","","","",""), $country);
	$country=preg_replace('/\n+|\t+|\s+/',' ',$country);
	$country=trim($country);$country=strtolower($country);$country=ucwords($country);
	if(strlen($country)==3){$country=strtoupper($country);}
	//if(strlen($country)==3){$country=strtoupper(substr($country, 0, 2));}
	if(strlen($country)==2){$country=strtoupper($country);}
	$result_st=$country;  
	$country_1=$country;$country_2=$country;$country_3=$country;$currency=''; $isd_code='';
	if($valid){ $country_1=$country_2=$country_3=''; }
	//echo $country; return false;
	if($country=="Afghanistan"  || $country=="AF" || $country=="AFG"){
	 $country_1="Afghanistan";  $country_2="AF"; $country_3="AFG"; $currency='AFN'; $isd_code='93';
	}elseif($country=="Ala Aland Islands" || $country=="AX" || $country=="ALA" || $country=="Åland Islands" || $country=="ÅX" ){
	 $country_1="ALA Aland Islands";  $country_2="AX"; $country_3="ALA"; $currency=''; $isd_code='';
	}elseif($country=="Albania" || $country=="AL" || $country=="ALB"){
	 $country_1="Albania";  $country_2="AL"; $country_3="ALB"; $currency='ALL'; $isd_code='355';
	}elseif($country=="Algeria" || $country=="DZ" || $country=="DZA"){
	 $country_1="Algeria";  $country_2="DZ"; $country_3="DZA"; $currency='DZD'; $isd_code='213';
	}elseif($country=="American Samoa" || $country=="AS" || $country=="ASM"){
	 $country_1="American Samoa";  $country_2="AS"; $country_3="ASM"; $currency='USD'; $isd_code='1684';
	}elseif($country=="Andorra" || $country=="AD" || $country=="AND"){
	 $country_1="Andorra";  $country_2="AD"; $country_3="AND"; $currency='EUR'; $isd_code='376';
	}elseif($country=="Angola" || $country=="AO" || $country=="AGO"){
	 $country_1="Angola";  $country_2="AO"; $country_3="AGO"; $currency='AOA'; $isd_code='244';
	}elseif($country=="Anguilla" || $country=="AI" || $country=="AIA"){
	 $country_1="Anguilla";  $country_2="AI"; $country_3="AIA"; $currency='XCD'; $isd_code='1264';
	}elseif($country=="Antarctica" || $country=="AQ" || $country=="ATA"){
	 $country_1="Antarctica";  $country_2="AQ"; $country_3="ATA"; $currency=''; $isd_code='672';
	}elseif($country=="Antigua And Barbuda" || $country=="AG" || $country=="ATG"){
	 $country_1="Antigua And Barbuda";  $country_2="AG"; $country_3="ATG"; $currency='XCD'; $isd_code='1268';
	}elseif($country=="Argentina" || $country=="AR" || $country=="ARG"){
	 $country_1="Argentina";  $country_2="AR"; $country_3="ARG"; $currency='ARS'; $isd_code='54';
	}elseif($country=="Armenia" || $country=="AM" || $country=="ARM"){
	 $country_1="Armenia";  $country_2="AM"; $country_3="ARM"; $currency='AMD'; $isd_code='374';
	}elseif($country=="Aruba" || $country=="AW" || $country=="ABW"){
	 $country_1="Aruba";  $country_2="AW"; $country_3="ABW"; $currency='AWG'; $isd_code='297';
	}elseif($country=="Australia" || $country=="AU" || $country=="AUS"){
	 $country_1="Australia";  $country_2="AU"; $country_3="AUS"; $currency='AUD'; $isd_code='61';
	}elseif($country=="Austria" || $country=="AT" || $country=="AUT"){
	 $country_1="Austria";  $country_2="AT"; $country_3="AUT"; $currency='EUR'; $isd_code='43';
	}elseif($country=="Azerbaijan" || $country=="AZ" || $country=="AZE"){
	 $country_1="Azerbaijan";  $country_2="AZ"; $country_3="AZE"; $currency='AZN'; $isd_code='994';
	}elseif($country=="Bahamas" || $country=="BS" || $country=="BHS"){
	 $country_1="Bahamas";  $country_2="BS"; $country_3="BHS"; $currency='BSD'; $isd_code='1242';
	}elseif($country=="Bahrain" || $country=="BH" || $country=="BHR"){
	 $country_1="Bahrain";  $country_2="BH"; $country_3="BHR"; $currency='BHD'; $isd_code='973';
	}elseif($country=="Bangladesh" || $country=="BD" || $country=="BGD"){
	 $country_1="Bangladesh";  $country_2="BD"; $country_3="BGD"; $currency='BDT'; $isd_code='880';
	}elseif($country=="Barbados" || $country=="BB" || $country=="BRB"){
	 $country_1="Barbados";  $country_2="BB"; $country_3="BRB"; $currency='BBD'; $isd_code='1246';
	}elseif($country=="Belarus" || $country=="BY" || $country=="BLR"){
	 $country_1="Belarus";  $country_2="BY"; $country_3="BLR"; $currency='BYN'; $isd_code='375';
	}elseif($country=="Belgium" || $country=="BE" || $country=="BEL"){
	 $country_1="Belgium";  $country_2="BE"; $country_3="BEL"; $currency='EUR'; $isd_code='32';
	}elseif($country=="Belize" || $country=="BZ" || $country=="BLZ"){
	 $country_1="Belize";  $country_2="BZ"; $country_3="BLZ"; $currency='BZD'; $isd_code='501';
	}elseif($country=="Benin" || $country=="BJ" || $country=="BEN"){
	 $country_1="Benin";  $country_2="BJ"; $country_3="BEN"; $currency='XOF'; $isd_code='229';
	}elseif($country=="Bermuda" || $country=="BM" || $country=="BMU"){
	 $country_1="Bermuda";  $country_2="BM"; $country_3="BMU"; $currency='BMD'; $isd_code='1441';
	}elseif($country=="Bhutan" || $country=="BT" || $country=="BTN"){
	 $country_1="Bhutan";  $country_2="BT"; $country_3="BTN"; $currency='BTN'; $isd_code='975';
	}elseif($country=="Bolivia" || $country=="BO" || $country=="BOL"){
	 $country_1="Bolivia";  $country_2="BO"; $country_3="BOL"; $currency='BOB'; $isd_code='591';
	}elseif($country=="Bosnia And Herzegovina" || $country=="BA" || $country=="BIH"){
	 $country_1="Bosnia And Herzegovina";  $country_2="BA"; $country_3="BIH"; $currency='BAM'; $isd_code='387';
	}elseif($country=="Botswana" || $country=="BW" || $country=="BWA"){
	 $country_1="Botswana";  $country_2="BW"; $country_3="BWA"; $currency='BWP'; $isd_code='267';
	}elseif($country=="Bouvet Island" || $country=="BV" || $country=="BVT"){
	 $country_1="Bouvet Island";  $country_2="BV"; $country_3="BVT"; $currency='NOK'; $isd_code='';
	}elseif($country=="Brazil" || $country=="BR" || $country=="BRA"){
	 $country_1="Brazil";  $country_2="BR"; $country_3="BRA"; $currency='BRL'; $isd_code='55';
	}elseif($country=="British Indian Ocean Territory" || $country=="IO" || $country=="IOT"){
	 $country_1="British Indian Ocean Territory";  $country_2="IO"; $country_3="IOT"; $currency='USD'; $isd_code='246';
	}elseif($country=="British Virgin Islands" || $country=="VG" || $country=="VGB"){
	 $country_1="British Virgin Islands";  $country_2="VG"; $country_3="VGB"; $currency='USD'; $isd_code='1284';
	}elseif($country=="Brunei Darussalam" || $country=="Brunei" || $country=="BN" || $country=="BRN"){
	 $country_1="Brunei Darussalam";  $country_2="BN"; $country_3="BRN"; $currency='BND'; $isd_code='673';
	}elseif($country=="Bulgaria" || $country=="BG" || $country=="BGR"){
	 $country_1="Bulgaria";  $country_2="BG"; $country_3="BGR"; $currency='BGN'; $isd_code='359';
	}elseif($country=="Burkina Faso" || $country=="BF" || $country=="BFA"){
	 $country_1="Burkina Faso";  $country_2="BF"; $country_3="BFA"; $currency='XOF'; $isd_code='226';
	}elseif($country=="Burundi" || $country=="BI" || $country=="BDI"){
	 $country_1="Burundi";  $country_2="BI"; $country_3="BDI"; $currency='BIF'; $isd_code='257';
	}elseif($country=="Cambodia" || $country=="KH" || $country=="KHM"){
	 $country_1="Cambodia";  $country_2="KH"; $country_3="KHM"; $currency='KHR'; $isd_code='855';
	}elseif($country=="Cameroon" || $country=="CM" || $country=="CMR"){
	 $country_1="Cameroon";  $country_2="CM"; $country_3="CMR"; $currency='XAF'; $isd_code='237';
	}elseif($country=="Canada" || $country=="CA" || $country=="CAN"){
	 $country_1="Canada";  $country_2="CA"; $country_3="CAN"; $currency='CAD'; $isd_code='';
	}elseif($country=="Cape Verde" || $country=="CV" || $country=="CPV"){
	 $country_1="Cape Verde";  $country_2="CV"; $country_3="CPV"; $currency='CVE'; $isd_code='1';
	}elseif($country=="Cayman Islands" || $country=="KY" || $country=="CYM"){
	 $country_1="Cayman Islands";  $country_2="KY"; $country_3="CYM"; $currency='KYD'; $isd_code='1345';
	}elseif($country=="Central African Republic" || $country=="CF" || $country=="CAF"){
	 $country_1="Central African Republic";  $country_2="CF"; $country_3="CAF"; $currency='XAF'; $isd_code='236';
	}elseif($country=="Chad" || $country=="TD" || $country=="TCD"){
	 $country_1="Chad";  $country_2="TD"; $country_3="TCD"; $currency='XAF'; $isd_code='235';
	}elseif($country=="Chile" || $country=="CL" || $country=="CHL"){
	 $country_1="Chile";  $country_2="CL"; $country_3="CHL"; $currency='CLP'; $isd_code='56';
	}elseif($country=="China" || $country=="CN" || $country=="CHN"){
	 $country_1="China";  $country_2="CN"; $country_3="CHN"; $currency='CNY'; $isd_code='86';
	}elseif($country=="Christmas Island" || $country=="CX" || $country=="CXR"){
	 $country_1="Christmas Island";  $country_2="CX"; $country_3="CXR"; $currency='AUD'; $isd_code='61';
	}elseif($country=="Cocos (keeling) Islands" || $country=="Cocos Islands" || $country=="CC" || $country=="CCK"){
	 $country_1="Cocos (Keeling) Islands";  $country_2="CC"; $country_3="CCK"; $currency='USD'; $isd_code='61';
	}elseif($country=="Colombia" || $country=="CO" || $country=="COL"){
	 $country_1="Colombia";  $country_2="CO"; $country_3="COL"; $currency='COP'; $isd_code='57';
	}elseif($country=="Comoros" || $country=="KM" || $country=="COM"){
	 $country_1="Comoros";  $country_2="KM"; $country_3="COM"; $currency='KMF'; $isd_code='269';
	}elseif($country=="Congo (brazzaville)" || $country=="CG" || $country=="COG"){
	 $country_1="Congo (Brazzaville)";  $country_2="CG"; $country_3="COG"; $currency='CDF'; $isd_code='';
	}elseif($country=="Congo, (kinshasa)" || $country=="CD" || $country=="COD" || $country=="Congo (kinshasa)" ){
	 $country_1="Congo, (Kinshasa)";  $country_2="CD"; $country_3="COD"; $currency='CDF'; $isd_code='';
	}elseif($country=="Cook Islands" || $country=="CK" || $country=="COK"){
	 $country_1="Cook Islands";  $country_2="CK"; $country_3="COK"; $currency='NZD'; $isd_code='682';
	}elseif($country=="Costa Rica" || $country=="CR" || $country=="CRI"){
	 $country_1="Costa Rica";  $country_2="CR"; $country_3="CRI"; $currency='CRC'; $isd_code='506';
	}elseif($country=="Cote D'ivoire" || $country=="Côte D'ivoire" || $country=="CI" || $country=="CIV"){
	 $country_1="Cote d'Ivoire";  $country_2="CI"; $country_3="CIV"; $currency='XOF'; $isd_code='';
	}elseif($country=="Croatia" || $country=="HR" || $country=="HRV"){
	 $country_1="Croatia";  $country_2="HR"; $country_3="HRV"; $currency='HRK'; $isd_code='385';
	}elseif($country=="Cuba" || $country=="CU" || $country=="CUB"){
	 $country_1="Cuba";  $country_2="CU"; $country_3="CUB"; $currency='CUP'; $isd_code='53';
	}elseif($country=="Cyprus" || $country=="CY" || $country=="CYP"){
	 $country_1="Cyprus";  $country_2="CY"; $country_3="CYP"; $currency='EUR'; $isd_code='357';
	}elseif($country=="Czech Republic" || $country=="CZ" || $country=="CZE"){
	 $country_1="Czech Republic";  $country_2="CZ"; $country_3="CZE"; $currency='CZK'; $isd_code='420';
	}elseif($country=="Denmark" || $country=="DK" || $country=="DNK"){
	 $country_1="Denmark";  $country_2="DK"; $country_3="DNK"; $currency='DKK'; $isd_code='45';
	}elseif($country=="Djibouti" || $country=="DJ" || $country=="DJI"){
	 $country_1="Djibouti";  $country_2="DJ"; $country_3="DJI"; $currency='DJF'; $isd_code='253';
	}elseif($country=="Dominica" || $country=="DM" || $country=="DMA"){
	 $country_1="Dominica";  $country_2="DM"; $country_3="DMA"; $currency='XCD'; $isd_code='1767';
	}elseif($country=="Dominican Republic" || $country=="DO" || $country=="DOM"){
	 $country_1="Dominican Republic";  $country_2="DO"; $country_3="DOM"; $currency='DOP'; $isd_code='1809'; // 1-809, 1-829, 1-849
	}elseif($country=="Ecuador" || $country=="EC" || $country=="ECU"){
	 $country_1="Ecuador";  $country_2="EC"; $country_3="ECU"; $currency='USD'; $isd_code='593';
	}elseif($country=="Egypt" || $country=="EG" || $country=="EGY"){
	 $country_1="Egypt";  $country_2="EG"; $country_3="EGY"; $currency='EGP'; $isd_code='20';
	}elseif($country=="El Salvador" || $country=="SV" || $country=="SLV"){
	 $country_1="El Salvador";  $country_2="SV"; $country_3="SLV"; $currency='USD'; $isd_code='503';
	}elseif($country=="Equatorial Guinea" || $country=="GQ" || $country=="GNQ"){
	 $country_1="Equatorial Guinea";  $country_2="GQ"; $country_3="GNQ"; $currency='XAF'; $isd_code='240';
	}elseif($country=="Eritrea" || $country=="ER" || $country=="ERI"){
	 $country_1="Eritrea";  $country_2="ER"; $country_3="ERI"; $currency='ERN'; $isd_code='291';
	}elseif($country=="Estonia" || $country=="EE" || $country=="EST"){
	 $country_1="Estonia";  $country_2="EE"; $country_3="EST"; $currency='EUR'; $isd_code='372';
	}elseif($country=="Ethiopia" || $country=="ET" || $country=="ETH"){
	 $country_1="Ethiopia";  $country_2="ET"; $country_3="ETH"; $currency='ETB'; $isd_code='251';
	}elseif($country=="Falkland Islands (malvinas)" || $country=="FK" || $country=="FLK"){
	 $country_1="Falkland Islands (Malvinas)";  $country_2="FK"; $country_3="FLK"; $currency='FKP'; $isd_code='500';
	}elseif($country=="Faroe Islands" || $country=="FO" || $country=="FRO"){
	 $country_1="Faroe Islands";  $country_2="FO"; $country_3="FRO"; $currency='DKK'; $isd_code='298';
	}elseif($country=="Fiji" || $country=="FJ" || $country=="FJI"){
	 $country_1="Fiji";  $country_2="FJ"; $country_3="FJI"; $currency='FJD'; $isd_code='679';
	}elseif($country=="Finland" || $country=="FI" || $country=="FIN"){
	 $country_1="Finland";  $country_2="FI"; $country_3="FIN"; $currency='EUR'; $isd_code='358';
	}elseif($country=="France" || $country=="FR" || $country=="FRA"){
	 $country_1="France";  $country_2="FR"; $country_3="FRA"; $currency='EUR'; $isd_code='33';
	}elseif($country=="French Guiana" || $country=="GF" || $country=="GUF"){
	 $country_1="French Guiana";  $country_2="GF"; $country_3="GUF"; $currency='EUR'; $isd_code='';
	}elseif($country=="French Polynesia" || $country=="PF" || $country=="PYF"){
	 $country_1="French Polynesia";  $country_2="PF"; $country_3="PYF"; $currency='XPF'; $isd_code='689';
	}elseif($country=="French Southern Territories" || $country=="TF" || $country=="ATF"){
	 $country_1="French Southern Territories";  $country_2="TF"; $country_3="ATF"; $currency='EUR'; $isd_code='';
	}elseif($country=="Gabon" || $country=="GA" || $country=="GAB"){
	 $country_1="Gabon";  $country_2="GA"; $country_3="GAB"; $currency='XAF'; $isd_code='241';
	}elseif($country=="Gambia" || $country=="GM" || $country=="GMB"){
	 $country_1="Gambia";  $country_2="GM"; $country_3="GMB"; $currency='GMD'; $isd_code='220';
	}elseif($country=="Georgia" || $country=="GE" || $country=="GEO"){
	 $country_1="Georgia";  $country_2="GE"; $country_3="GEO"; $currency='GEL'; $isd_code='995';
	}elseif($country=="Germany" || $country=="DE" || $country=="DEU"){
	 $country_1="Germany";  $country_2="DE"; $country_3="DEU"; $currency='EUR'; $isd_code='49';
	}elseif($country=="Ghana" || $country=="GH" || $country=="GHA"){
	 $country_1="Ghana";  $country_2="GH"; $country_3="GHA"; $currency='GHS'; $isd_code='233';
	}elseif($country=="Gibraltar" || $country=="GI" || $country=="GIB"){
	 $country_1="Gibraltar";  $country_2="GI"; $country_3="GIB"; $currency='GIP'; $isd_code='350';
	}elseif($country=="Greece" || $country=="GR" || $country=="GRC"){
	 $country_1="Greece";  $country_2="GR"; $country_3="GRC"; $currency='EUR'; $isd_code='30';
	}elseif($country=="Greenland" || $country=="GL" || $country=="GRL"){
	 $country_1="Greenland";  $country_2="GL"; $country_3="GRL"; $currency='DKK'; $isd_code='299';
	}elseif($country=="Grenada" || $country=="GD" || $country=="GRD"){
	 $country_1="Grenada";  $country_2="GD"; $country_3="GRD"; $currency='XCD'; $isd_code='1473';
	}elseif($country=="Guadeloupe" || $country=="GP" || $country=="GLP"){
	 $country_1="Guadeloupe";  $country_2="GP"; $country_3="GLP"; $currency='EUR'; $isd_code='';
	}elseif($country=="Guam" || $country=="GU" || $country=="GUM"){
	 $country_1="Guam";  $country_2="GU"; $country_3="GUM"; $currency='USD'; $isd_code='1671';
	}elseif($country=="Guatemala" || $country=="GT" || $country=="GTM"){
	 $country_1="Guatemala";  $country_2="GT"; $country_3="GTM"; $currency='GTQ'; $isd_code='502';
	}elseif($country=="Guernsey" || $country=="GG" || $country=="GGY"){
	 $country_1="Guernsey";  $country_2="GG"; $country_3="GGY"; $currency='GBP'; $isd_code='441481';
	}elseif($country=="Guinea" || $country=="GN" || $country=="GIN"){
	 $country_1="Guinea";  $country_2="GN"; $country_3="GIN"; $currency='GNF'; $isd_code='224';
	}elseif($country=="Guinea-Bissau" || $country=="GW" || $country=="GNB"){
	 $country_1="Guinea-Bissau";  $country_2="GW"; $country_3="GNB"; $currency='XOF'; $isd_code='245';
	}elseif($country=="Guyana" || $country=="GY" || $country=="GUY"){
	 $country_1="Guyana";  $country_2="GY"; $country_3="GUY"; $currency='GYD'; $isd_code='592';
	}elseif($country=="Haiti" || $country=="HT" || $country=="HTI"){
	 $country_1="Haiti";  $country_2="HT"; $country_3="HTI"; $currency='HTG'; $isd_code='509';
	}elseif($country=="Heard And Mcdonald Islands" || $country=="HM" || $country=="HMD"){
	 $country_1="Heard And Mcdonald Islands";  $country_2="HM"; $country_3="HMD"; $currency='AUD'; $isd_code='';
	}elseif($country=="Holy See (vatican City State)" || $country=="VA" || $country=="VAT"){
	 $country_1="Holy See (vatican City State)";  $country_2="VA"; $country_3="VAT"; $currency='EUR'; $isd_code='';
	}elseif($country=="Honduras" || $country=="HN" || $country=="HND"){
	 $country_1="Honduras";  $country_2="HN"; $country_3="HND"; $currency='HNL'; $isd_code='504';
	}elseif($country=="Hong Kong, Sar China"  || $country=="Hong Kong Sar China"  || $country=="Hong Kong Sar" || $country=="Hong Kong" || $country=="HK" || $country=="HKG"){
	 $country_1="Hong Kong, SAR China";  $country_2="HK"; $country_3="HKG"; $currency='HKD'; $isd_code='852';
	}elseif($country=="Hungary" || $country=="HU" || $country=="HUN"){
	 $country_1="Hungary";  $country_2="HU"; $country_3="HUN"; $currency='HUF'; $isd_code='36';
	}elseif($country=="Iceland" || $country=="IS" || $country=="ISL"){
	 $country_1="Iceland";  $country_2="IS"; $country_3="ISL"; $currency='ISK'; $isd_code='354';
	}elseif($country=="India" || $country=="IN" || $country=="IND"){
	 $country_1="India";  $country_2="IN"; $country_3="IND"; $currency='INR'; $isd_code='91';
	}elseif($country=="Indonesia" || $country=="ID" || $country=="IDN"){
	 $country_1="Indonesia";  $country_2="ID"; $country_3="IDN"; $currency='IDR'; $isd_code='62';
	}elseif($country=="Iran, Islamic Republic Of" || $country=="Iran" || $country=="IR" || $country=="IRN"){
	 $country_1="Iran, Islamic Republic of";  $country_2="IR"; $country_3="IRN"; $currency='IRR'; $isd_code='98';
	}elseif($country=="Iraq" || $country=="IQ" || $country=="IRQ"){
	 $country_1="Iraq";  $country_2="IQ"; $country_3="IRQ"; $currency='IQD'; $isd_code='964';
	}elseif($country=="Ireland" || $country=="IE" || $country=="IRL"){
	 $country_1="Ireland";  $country_2="IE"; $country_3="IRL"; $currency='EUR'; $isd_code='353';
	}elseif($country=="Isle Of Man" || $country=="IM" || $country=="IMN"){
	 $country_1="Isle Of Man";  $country_2="IM"; $country_3="IMN"; $currency='GBP'; $isd_code='441624';
	}elseif($country=="Israel" || $country=="IL" || $country=="ISR"){
	 $country_1="Israel";  $country_2="IL"; $country_3="ISR"; $currency='ILS'; $isd_code='972';
	}elseif($country=="Italy" || $country=="IT" || $country=="ITA"){
	 $country_1="Italy";  $country_2="IT"; $country_3="ITA"; $currency='EUR'; $isd_code='39';
	}elseif($country=="Jamaica" || $country=="JM" || $country=="JAM"){
	 $country_1="Jamaica";  $country_2="JM"; $country_3="JAM"; $currency='JMD'; $isd_code='1876';
	}elseif($country=="Japan" || $country=="JP" || $country=="JPN"){
	 $country_1="Japan";  $country_2="JP"; $country_3="JPN"; $currency='JPY'; $isd_code='81';
	}elseif($country=="Jersey" || $country=="JE" || $country=="JEY"){
	 $country_1="Jersey";  $country_2="JE"; $country_3="JEY"; $currency='Jersey'; $isd_code='441534';
	}elseif($country=="Jordan" || $country=="JO" || $country=="JOR"){
	 $country_1="Jordan";  $country_2="JO"; $country_3="JOR"; $currency='JOD'; $isd_code='962';
	}
	
	elseif($country=="Kazakhstan" || $country=="KZ" || $country=="KAZ"){
	  $country_1="Kazakhstan";  $country_2="KZ"; $country_3="KAZ"; $currency='KZT'; $isd_code='7';
	}elseif($country=="Kenya" || $country=="KE" || $country=="KEN"){
	  $country_1="Kenya";  $country_2="KE"; $country_3="KEN"; $currency='KES'; $isd_code='254';
	}elseif($country=="Kiribati" || $country=="KI" || $country=="KIR"){
	  $country_1="Kiribati";  $country_2="KI"; $country_3="KIR"; $currency='AUD'; $isd_code='686';
	}elseif($country=="Kosovo" || $country=="XK" || $country=="XKX"){
	  $country_1="Kosovo";  $country_2="XK"; $country_3="XKX"; $currency='EUR'; $isd_code='383';
	}elseif($country=="Kuwait" || $country=="KW" || $country=="KWT"){
	  $country_1="Kuwait";  $country_2="KW"; $country_3="KWT"; $currency='KWD'; $isd_code='965';
	}elseif($country=="Kyrgyzstan" || $country=="KG" || $country=="KGZ"){
	  $country_1="Kyrgyzstan";  $country_2="KG"; $country_3="KGZ"; $currency='KGS'; $isd_code='996';
	}elseif($country=="Laos" || $country=="LA" || $country=="LAO"){
	  $country_1="Laos";  $country_2="LA"; $country_3="LAO"; $currency='LAK'; $isd_code='856';
	}elseif($country=="Latvia" || $country=="LV" || $country=="LVA"){
	  $country_1="Latvia";  $country_2="LV"; $country_3="LVA"; $currency='EUR'; $isd_code='371';
	}elseif($country=="Lebanon" || $country=="LB" || $country=="LBN"){
	  $country_1="Lebanon";  $country_2="LB"; $country_3="LBN"; $currency='LBP'; $isd_code='961';
	}elseif($country=="Lesotho" || $country=="LS" || $country=="LSO"){
	  $country_1="Lesotho";  $country_2="LS"; $country_3="LSO"; $currency='LSL'; $isd_code='266';
	}elseif($country=="Liberia" || $country=="LR" || $country=="LBR"){
	  $country_1="Liberia";  $country_2="LR"; $country_3="LBR"; $currency='LRD'; $isd_code='231';
	}elseif($country=="Libya" || $country=="LY" || $country=="LBY"){
	  $country_1="Libya";  $country_2="LY"; $country_3="LBY"; $currency='LYD'; $isd_code='218';
	}elseif($country=="Liechtenstein" || $country=="LI" || $country=="LIE"){
	  $country_1="Liechtenstein";  $country_2="LI"; $country_3="LIE"; $currency='CHF'; $isd_code='423';
	}elseif($country=="Lithuania" || $country=="LT" || $country=="LTU"){
	  $country_1="Lithuania";  $country_2="LT"; $country_3="LTU"; $currency='EUR'; $isd_code='370';
	}elseif($country=="Luxembourg" || $country=="LU" || $country=="LUX"){
	  $country_1="Luxembourg";  $country_2="LU"; $country_3="LUX"; $currency='EUR'; $isd_code='352';
	}elseif($country=="Macau" || $country=="MO" || $country=="MAC"  || $country=="Macao S.A.R., China"){
	  $country_1="Macau";  $country_2="MO"; $country_3="MAC"; $currency=''; $isd_code='853';
	}elseif($country=="Macedonia" || $country=="MK" || $country=="MKD"){
	  $country_1="Macedonia";  $country_2="MK"; $country_3="MKD"; $currency='MKD'; $isd_code='389';
	}elseif($country=="Madagascar" || $country=="MG" || $country=="MDG"){
	  $country_1="Madagascar";  $country_2="MG"; $country_3="MDG"; $currency='MGA'; $isd_code='261';
	}elseif($country=="Malawi" || $country=="MW" || $country=="MWI"){
	  $country_1="Malawi";  $country_2="MW"; $country_3="MWI"; $currency='MWK'; $isd_code='265';
	}elseif($country=="Malaysia" || $country=="MY" || $country=="MYS"){
	  $country_1="Malaysia";  $country_2="MY"; $country_3="MYS"; $currency='MYR'; $isd_code='60';
	}elseif($country=="Maldives" || $country=="MV" || $country=="MDV"){
	  $country_1="Maldives";  $country_2="MV"; $country_3="MDV"; $currency='MVR'; $isd_code='960';
	}elseif($country=="Mali" || $country=="ML" || $country=="MLI"){
	  $country_1="Mali";  $country_2="ML"; $country_3="MLI"; $currency='XOF'; $isd_code='223';
	}elseif($country=="Malta" || $country=="MT" || $country=="MLT"){
	  $country_1="Malta";  $country_2="MT"; $country_3="MLT"; $currency='EUR'; $isd_code='356';
	}elseif($country=="Marshall Islands" || $country=="MH" || $country=="MHL"){
	  $country_1="Marshall Islands";  $country_2="MH"; $country_3="MHL"; $currency='USD'; $isd_code='692';
	}elseif($country=="Mauritania" || $country=="MR" || $country=="MRT"){
	  $country_1="Mauritania";  $country_2="MR"; $country_3="MRT"; $currency='MRO'; $isd_code='222';
	}elseif($country=="Mauritius" || $country=="MU" || $country=="MUS"){
	  $country_1="Mauritius";  $country_2="MU"; $country_3="MUS"; $currency='MUR'; $isd_code='230';
	}elseif($country=="Mayotte" || $country=="YT" || $country=="MYT"){
	  $country_1="Mayotte";  $country_2="YT"; $country_3="MYT"; $currency='EUR'; $isd_code='262';
	}elseif($country=="Mexico" || $country=="MX" || $country=="MEX"){
	  $country_1="Mexico";  $country_2="MX"; $country_3="MEX"; $currency='MXN'; $isd_code='52';
	}elseif($country=="Micronesia" || $country=="FM" || $country=="FSM"){
	  $country_1="Micronesia";  $country_2="FM"; $country_3="FSM"; $currency='USD'; $isd_code='691';
	}elseif($country=="Moldova" || $country=="MD" || $country=="MDA"){
	  $country_1="Moldova";  $country_2="MD"; $country_3="MDA"; $currency='MDL'; $isd_code='373';
	}elseif($country=="Monaco" || $country=="MC" || $country=="MCO"){
	  $country_1="Monaco";  $country_2="MC"; $country_3="MCO"; $currency='EUR'; $isd_code='377';
	}elseif($country=="Mongolia" || $country=="MN" || $country=="MNG"){
	  $country_1="Mongolia";  $country_2="MN"; $country_3="MNG"; $currency='MNT'; $isd_code='976';
	}elseif($country=="Montenegro" || $country=="ME" || $country=="MNE"){
	  $country_1="Montenegro";  $country_2="ME"; $country_3="MNE"; $currency='EUR'; $isd_code='382';
	}elseif($country=="Montserrat" || $country=="MS" || $country=="MSR"){
	  $country_1="Montserrat";  $country_2="MS"; $country_3="MSR"; $currency='XCD'; $isd_code='1664';
	}elseif($country=="Morocco" || $country=="MA" || $country=="MAR"){
	  $country_1="Morocco";  $country_2="MA"; $country_3="MAR"; $currency='MAD'; $isd_code='212';
	}elseif($country=="Mozambique" || $country=="MZ" || $country=="MOZ"){
	  $country_1="Mozambique";  $country_2="MZ"; $country_3="MOZ"; $currency='MZN'; $isd_code='258';
	}elseif($country=="Namibia" || $country=="NA" || $country=="NAM"){
	  $country_1="Namibia";  $country_2="NA"; $country_3="NAM"; $currency='NAD'; $isd_code='264';
	}elseif($country=="Nauru" || $country=="NR" || $country=="NRU"){
	  $country_1="Nauru";  $country_2="NR"; $country_3="NRU"; $currency='AUD'; $isd_code='674';
	}elseif($country=="Nepal" || $country=="NP" || $country=="NPL"){
	  $country_1="Nepal";  $country_2="NP"; $country_3="NPL"; $currency='NPR'; $isd_code='977';
	}elseif($country=="Netherlands" || $country=="NL" || $country=="NLD"){
	  $country_1="Netherlands";  $country_2="NL"; $country_3="NLD"; $currency='EUR'; $isd_code='31';
	}elseif($country=="Netherlands Antilles" || $country=="AN" || $country=="ANT"){
	  $country_1="Netherlands Antilles";  $country_2="AN"; $country_3="ANT"; $currency=''; $isd_code='599';
	}elseif($country=="New Caledonia" || $country=="NC" || $country=="NCL"){
	  $country_1="New Caledonia";  $country_2="NC"; $country_3="NCL"; $currency='XPF'; $isd_code='687';
	}elseif($country=="New Zealand" || $country=="NZ" || $country=="NZL"){
	  $country_1="New Zealand";  $country_2="NZ"; $country_3="NZL"; $currency='NZD'; $isd_code='64';
	}elseif($country=="Nicaragua" || $country=="NI" || $country=="NIC"){
	  $country_1="Nicaragua";  $country_2="NI"; $country_3="NIC"; $currency='NIO'; $isd_code='505';
	}elseif($country=="Niger" || $country=="NE" || $country=="NER"){
	  $country_1="Niger";  $country_2="NE"; $country_3="NER"; $currency='XOF'; $isd_code='227';
	}elseif($country=="Nigeria" || $country=="NG" || $country=="NGA"){
	  $country_1="Nigeria";  $country_2="NG"; $country_3="NGA"; $currency='NGN'; $isd_code='234';
	}elseif($country=="Niue" || $country=="NU" || $country=="NIU"){
	  $country_1="Niue";  $country_2="NU"; $country_3="NIU"; $currency='NZD'; $isd_code='683';
	}elseif($country=="Northern Mariana Islands" || $country=="MP" || $country=="MNP"){
	  $country_1="Northern Mariana Islands";  $country_2="MP"; $country_3="MNP"; $currency='USD'; $isd_code='1670';
	}elseif($country=="North Korea" || $country=="KP" || $country=="PRK"){
	  $country_1="North Korea";  $country_2="KP"; $country_3="PRK"; $currency='KPW'; $isd_code='850';
	}elseif($country=="South Korea" || $country=="KR" || $country=="KOR"){
	  $country_1="South Korea";  $country_2="KR"; $country_3="KOR"; $currency='KRW'; $isd_code='82';
	}elseif($country=="Norway" || $country=="NO" || $country=="NOR"){
	  $country_1="Norway";  $country_2="NO"; $country_3="NOR"; $currency='NOK'; $isd_code='47';
	}elseif($country=="Oman" || $country=="OM" || $country=="OMN"){
	  $country_1="Oman";  $country_2="OM"; $country_3="OMN"; $currency='OMR'; $isd_code='968';
	}elseif($country=="Pakistan" || $country=="PK" || $country=="PAK"){
	  $country_1="Pakistan";  $country_2="PK"; $country_3="PAK"; $currency='PKR'; $isd_code='92';
	}elseif($country=="Palau" || $country=="PW" || $country=="PLW"){
	  $country_1="Palau";  $country_2="PW"; $country_3="PLW"; $currency='USD'; $isd_code='680';
	}elseif($country=="Palestine" || $country=="PS" || $country=="PSE"){
	  $country_1="Palestine";  $country_2="PS"; $country_3="PSE"; $currency='ILS'; $isd_code='970';
	}elseif($country=="Panama" || $country=="PA" || $country=="PAN"){
	  $country_1="Panama";  $country_2="PA"; $country_3="PAN"; $currency='PAB'; $isd_code='507';
	}elseif($country=="Papua New Guinea" || $country=="PG" || $country=="PNG"){
	  $country_1="Papua New Guinea";  $country_2="PG"; $country_3="PNG"; $currency='PGK'; $isd_code='675';
	}elseif($country=="Paraguay" || $country=="PY" || $country=="PRY"){
	  $country_1="Paraguay";  $country_2="PY"; $country_3="PRY"; $currency='PYG'; $isd_code='595';
	}elseif($country=="Peru" || $country=="PE" || $country=="PER"){
	  $country_1="Peru";  $country_2="PE"; $country_3="PER"; $currency='PEN'; $isd_code='51';
	}elseif($country=="Philippines" || $country=="PH" || $country=="PHL"){
	  $country_1="Philippines";  $country_2="PH"; $country_3="PHL"; $currency='PHP'; $isd_code='63';
	}elseif($country=="Pitcairn" || $country=="PN" || $country=="PCN"){
	  $country_1="Pitcairn";  $country_2="PN"; $country_3="PCN"; $currency='NZD'; $isd_code='64';
	}elseif($country=="Poland" || $country=="PL" || $country=="POL"){
	  $country_1="Poland";  $country_2="PL"; $country_3="POL"; $currency='PLN'; $isd_code='48';
	}elseif($country=="Portugal" || $country=="PT" || $country=="PRT"){
	  $country_1="Portugal";  $country_2="PT"; $country_3="PRT"; $currency='EUR'; $isd_code='351';
	}elseif($country=="Puerto Rico" || $country=="PR" || $country=="PRI"){
	  $country_1="Puerto Rico";  $country_2="PR"; $country_3="PRI"; $currency='USD'; $isd_code='1787';
	}
	
	
	
	elseif($country=="Qatar" || $country=="QA" || $country=="QAT"){
	 $country_1="Qatar";  $country_2="QA"; $country_3="QAT"; $currency='QAR'; $isd_code='974';
	}elseif($country=="Réunion" || $country=="Reunion" || $country=="RE" || $country=="REU"){
	 $country_1="Réunion";  $country_2="RE"; $country_3="REU"; $currency='EUR'; $isd_code='262';
	}elseif($country=="Romania" || $country=="RO" || $country=="ROU"){
	 $country_1="Romania";  $country_2="RO"; $country_3="ROU"; $currency='RON'; $isd_code='40';
	}elseif($country=="Russian Federation" || $country=="Russia" || $country=="RUS"){
	 $country_1="Russian Federation";  $country_2="RU"; $country_3="RUS"; $currency='RUB'; $isd_code='7';
	}elseif($country=="Rwanda" || $country=="RW" || $country=="RWA"){
	 $country_1="Rwanda";  $country_2="RW"; $country_3="RWA"; $currency='RWF'; $isd_code='250';
	}elseif($country=="Saint Helena" || $country=="SH" || $country=="SHN"){
	 $country_1="Saint Helena";  $country_2="SH"; $country_3="SHN"; $currency='SHP'; $isd_code='290';
	}elseif($country=="Saint Kitts And Nevis" || $country=="KN" || $country=="KNA"){
	 $country_1="Saint Kitts And Nevis";  $country_2="KN"; $country_3="KNA"; $currency='XCD'; $isd_code='1869';
	}elseif($country=="Saint Lucia" || $country=="LC" || $country=="LCA"){
	 $country_1="Saint Lucia";  $country_2="LC"; $country_3="LCA"; $currency='XCD'; $isd_code='1758';
	}elseif($country=="Saint Pierre And Miquelon" || $country=="PM" || $country=="SPM"){
	 $country_1="Saint Pierre And Miquelon";  $country_2="PM"; $country_3="SPM"; $currency='EUR'; $isd_code='508';
	}elseif($country=="Saint Vincent And Grenadines" || $country=="VC" || $country=="VCT"){
	 $country_1="Saint Vincent And Grenadines";  $country_2="VC"; $country_3="VCT"; $currency='XCD'; $isd_code='';
	 }elseif($country=="Saint-Barthélemy" || $country=="BL" || $country=="BLM"){
	 $country_1="Saint-Barthélemy";  $country_2="BL"; $country_3="BLM"; $currency='EUR'; $isd_code='';
	}elseif($country=="Saint-Martin (French Part)" || $country=="MF" || $country=="MAF"|| $country=="Saint Martin (French Part)"){
	 $country_1="Saint-Martin (French part)";  $country_2="MF"; $country_3="MAF"; $currency='EUR'; $isd_code='1784';
	}elseif($country=="Samoa" || $country=="WS" || $country=="WSM"){
	 $country_1="Samoa";  $country_2="WS"; $country_3="WSM"; $currency='WST'; $isd_code='685';
	}elseif($country=="San Marino" || $country=="SM" || $country=="SMR"){
	 $country_1="San Marino";  $country_2="SM"; $country_3="SMR"; $currency='EUR'; $isd_code='378';
	}elseif($country=="Sao Tome And Principe" || $country=="ST" || $country=="STP" || $country=="São Tomé And Príncipe"){
	 $country_1="Sao Tome And Principe";  $country_2="ST"; $country_3="STP"; $currency='STD'; $isd_code='239';
	}elseif($country=="Saudi Arabia" || $country=="SA" || $country=="SAU"){
	 $country_1="Saudi Arabia";  $country_2="SA"; $country_3="SAU"; $currency='SAR'; $isd_code='966';
	}elseif($country=="Senegal" || $country=="SN" || $country=="SEN"){
	 $country_1="Senegal";  $country_2="SN"; $country_3="SEN"; $currency='XOF'; $isd_code='221';
	}elseif($country=="Serbia" || $country=="RS" || $country=="SRB"){
	 $country_1="Serbia";  $country_2="RS"; $country_3="SRB"; $currency='RSD'; $isd_code='381';
	}elseif($country=="Seychelles" || $country=="SC" || $country=="SYC"){
	 $country_1="Seychelles";  $country_2="SC"; $country_3="SYC"; $currency='SCR'; $isd_code='248';
	}elseif($country=="Sierra Leone" || $country=="SL" || $country=="SLE"){
	 $country_1="Sierra Leone";  $country_2="SL"; $country_3="SLE"; $currency='SLL'; $isd_code='232';
	}elseif($country=="Singapore" || $country=="SG" || $country=="SGP"){
	 $country_1="Singapore";  $country_2="SG"; $country_3="SGP"; $currency='SGD'; $isd_code='65';
	}elseif($country=="Slovakia" || $country=="SK" || $country=="SVK"){
	 $country_1="Slovakia";  $country_2="SK"; $country_3="SVK"; $currency='EUR'; $isd_code='421';
	}elseif($country=="Slovenia" || $country=="SI" || $country=="SVN"){
	 $country_1="Slovenia";  $country_2="SI"; $country_3="SVN"; $currency='EUR'; $isd_code='386';
	}elseif($country=="Solomon Islands" || $country=="SB" || $country=="SLB"){
	 $country_1="Solomon Islands";  $country_2="SB"; $country_3="SLB"; $currency='SBD'; $isd_code='677';
	}elseif($country=="Somalia" || $country=="SO" || $country=="SOM"){
	 $country_1="Somalia";  $country_2="SO"; $country_3="SOM"; $currency='SOS'; $isd_code='252';
	}elseif($country=="South Africa" || $country=="ZA" || $country=="ZAF"){
	 $country_1="South Africa";  $country_2="ZA"; $country_3="ZAF"; $currency='ZAR'; $isd_code='27';
	}elseif($country=="South Georgia And the South Sandwich Islands" || $country=="GS" || $country=="SGS"|| $country=="South Georgia/sandwich Islands"){
	 $country_1="South Georgia And the South Sandwich Islands";  $country_2="GS"; $country_3="SGS"; $currency=''; $isd_code='';
	}elseif($country=="South Sudan" || $country=="SS" || $country=="SSD"){
	 $country_1="South Sudan";  $country_2="SS"; $country_3="SSD"; $currency='SSP'; $isd_code='211';
	}elseif($country=="Spain" || $country=="ES" || $country=="ESP"){
	 $country_1="Spain";  $country_2="ES"; $country_3="ESP"; $currency='EUR'; $isd_code='34';
	}elseif($country=="Sri Lanka" || $country=="LK" || $country=="LKA"){
	 $country_1="Sri Lanka";  $country_2="LK"; $country_3="LKA"; $currency='LKR'; $isd_code='94';
	}elseif($country=="Sudan" || $country=="SD" || $country=="SDN"){
	 $country_1="Sudan";  $country_2="SD"; $country_3="SDN"; $currency='SDG'; $isd_code='249';
	}elseif($country=="Suriname" || $country=="SR" || $country=="SUR"){
	 $country_1="Suriname";  $country_2="SR"; $country_3="SUR"; $currency='SRD'; $isd_code='597';
	}elseif($country=="Svalbard And Jan Mayen Islands" || $country=="Svalbard And Jan Mayen" || $country=="SJ" || $country=="SJM"){
	 $country_1="Svalbard And Jan Mayen Islands";  $country_2="SJ"; $country_3="SJM"; $currency='NOK'; $isd_code='47';
	}elseif($country=="Swaziland" || $country=="SZ" || $country=="SWZ"){
	 $country_1="Swaziland";  $country_2="SZ"; $country_3="SWZ"; $currency='SZL'; $isd_code='268';
	}elseif($country=="Sweden" || $country=="SE" || $country=="SWE"){
	 $country_1="Sweden";  $country_2="SE"; $country_3="SWE"; $currency='SEK'; $isd_code='46';
	}elseif($country=="Switzerland" || $country=="CH" || $country=="CHE"){
	 $country_1="Switzerland";  $country_2="CH"; $country_3="CHE"; $currency='CHF'; $isd_code='41';
	}elseif($country=="Syrian Arab Republic (syria)" || $country=="Syria" || $country=="SY" || $country=="SYR"){
	 $country_1="Syrian Arab Republic (Syria)";  $country_2="SY"; $country_3="SYR"; $currency='SYP'; $isd_code='963';
	}elseif($country=="Taiwan, Republic Of China" || $country=="Taiwan" || $country=="TW" || $country=="TWN"){
	 $country_1="Taiwan, Republic Of China";  $country_2="TW"; $country_3="TWN"; $currency='TWD'; $isd_code='886';
	}elseif($country=="Tajikistan" || $country=="TJ" || $country=="TJK"){
	 $country_1="Tajikistan";  $country_2="TJ"; $country_3="TJK"; $currency='TJS'; $isd_code='992';
	}elseif($country=="Tanzania, United Republic Of" || $country=="Tanzania"  || $country=="TZ" || $country=="TZA"){
	 $country_1="Tanzania, United Republic Of";  $country_2="TZ"; $country_3="TZA"; $currency='TZS'; $isd_code='255';
	}elseif($country=="Thailand" || $country=="TH" || $country=="THA"){
	 $country_1="Thailand";  $country_2="TH"; $country_3="THA"; $currency='THB'; $isd_code='66';
	}elseif($country=="Timor-Leste" || $country=="TL" || $country=="TLS"){
	 $country_1="Timor-Leste";  $country_2="TL"; $country_3="TLS"; $currency='USD'; $isd_code='';
	}elseif($country=="Togo" || $country=="TG" || $country=="TGO"){
	 $country_1="Togo";  $country_2="TG"; $country_3="TGO"; $currency='XOF'; $isd_code='228';
	}elseif($country=="Tokelau" || $country=="TK" || $country=="TKL"){
	 $country_1="Tokelau";  $country_2="TK"; $country_3="TKL"; $currency='NZD'; $isd_code='690';
	}elseif($country=="Tonga" || $country=="TO" || $country=="TON"){
	 $country_1="Tonga";  $country_2="TO"; $country_3="TON"; $currency='TOP'; $isd_code='676';
	}elseif($country=="Trinidad And Tobago" || $country=="TT" || $country=="TTO"){
	 $country_1="Trinidad And Tobago";  $country_2="TT"; $country_3="TTO"; $currency='TTD'; $isd_code='1868';
	}elseif($country=="Tunisia" || $country=="TN" || $country=="TUN"){
	 $country_1="Tunisia";  $country_2="TN"; $country_3="TUN"; $currency='TND'; $isd_code='216';
	}elseif($country=="Turkey" || $country=="TR" || $country=="TUR"){
	 $country_1="Turkey";  $country_2="TR"; $country_3="TUR"; $currency='TRY'; $isd_code='90';
	}elseif($country=="Turkmenistan" || $country=="TM" || $country=="TKM"){
	 $country_1="Turkmenistan";  $country_2="TM"; $country_3="TKM"; $currency='TMT'; $isd_code='993';
	}elseif($country=="Turks And Caicos Islands" || $country=="TC" || $country=="TCA"){
	 $country_1="Turks And Caicos Islands";  $country_2="TC"; $country_3="TCA"; $currency='USD'; $isd_code='1649';
	}elseif($country=="Tuvalu" || $country=="TV" || $country=="TUV"){
	 $country_1="Tuvalu";  $country_2="TV"; $country_3="TUV"; $currency='AUD'; $isd_code='688';
	}elseif($country=="Uganda" || $country=="UG" || $country=="UGA"){
	 $country_1="Uganda";  $country_2="UG"; $country_3="UGA"; $currency='UGX'; $isd_code='256';
	}elseif($country=="Ukraine" || $country=="UA" || $country=="UKR"){
	 $country_1="Ukraine";  $country_2="UA"; $country_3="UKR"; $currency='UAH'; $isd_code='380';
	}elseif($country=="United Arab Emirates" || $country=="AE" || $country=="ARE"){
	 $country_1="United Arab Emirates";  $country_2="AE"; $country_3="ARE"; $currency='AED'; $isd_code='971';
	}elseif($country=="United Kingdom" || $country=="GB" || $country=="GBR" || $country=="United Kingdom (uk)"){
	 $country_1="United Kingdom";  $country_2="GB"; $country_3="GBR"; $currency='GBP'; $isd_code='44';
	}elseif($country=="United States" || $country=="United States Of America" || $country=="US" || $country=="USA" || $country=="United States(us)" || $country=="United State (us) Virgin Islands" ){
	 $country_1="United States Of America";  $country_2="US"; $country_3="USA"; $currency='USD'; $isd_code='1';
	}elseif($country=="Uruguay" || $country=="UY" || $country=="URY"){
	 $country_1="Uruguay";  $country_2="UY"; $country_3="URY"; $currency='UYU'; $isd_code='';
	}elseif($country=="US Minor Outlying Islands" || $country=="UM" || $country=="UMI"  || $country=="United States(us) Minor Outlying Islands"){
	 $country_1="US Minor Outlying Islands";  $country_2="UM"; $country_3="UMI"; $currency='USD'; $isd_code='';
	}elseif($country=="Uzbekistan" || $country=="UZ" || $country=="UZB"){
	 $country_1="Uzbekistan";  $country_2="UZ"; $country_3="UZB"; $currency='UZS'; $isd_code='998';
	}elseif($country=="Vanuatu" || $country=="VU" || $country=="VUT"){
	 $country_1="Vanuatu";  $country_2="VU"; $country_3="VUT"; $currency='VUV'; $isd_code='678';
	}elseif($country=="Venezuela (bolivarian Republic)" || $country=="Venezuela" || $country=="VE" || $country=="VEN"){
	 $country_1="Venezuela (Bolivarian Republic)";  $country_2="VE"; $country_3="VEN"; $currency='VEF'; $isd_code='58';
	}elseif($country=="Viet Nam" || $country=="Vietnam" || $country=="VN" || $country=="VNM"){
	 $country_1="Viet Nam";  $country_2="VN"; $country_3="VNM"; $currency='VND'; $isd_code='84';
	}elseif($country=="Virgin Islands, US" || $country=="VI" || $country=="VIR"){
	 $country_1="Virgin Islands, US";  $country_2="VI"; $country_3="VIR"; $currency='USD'; $isd_code='';
	}elseif($country=="Wallis And Futuna Islands" || $country=="Wallis And Futuna" || $country=="WLF"){
	 $country_1="Wallis And Futuna Islands";  $country_2="WF"; $country_3="WLF"; $currency='XPF'; $isd_code='681';
	}elseif($country=="Western Sahara" || $country=="EH" || $country=="ESH"){
	 $country_1="Western Sahara";  $country_2="EH"; $country_3="ESH"; $currency='MAD'; $isd_code='212';
	}elseif($country=="Yemen" || $country=="YE" || $country=="YEM"){
	 $country_1="Yemen";  $country_2="YE"; $country_3="YEM"; $currency='YER'; $isd_code='967';
	}elseif($country=="Zambia" || $country=="ZM" || $country=="ZMB"){
	 $country_1="Zambia";  $country_2="ZM"; $country_3="ZMB"; $currency='ZMW'; $isd_code='260';
	}elseif($country=="Zimbabwe" || $country=="ZW" || $country=="ZWE"){
	 $country_1="Zimbabwe";  $country_2="ZW"; $country_3="ZWE"; $currency='ZMW'; $isd_code='263';
	}
	$result_st=$country_2;
	if($names==2){
		$result_st=$country_2;
	}elseif($names==1){
		$result_st=$country_1;
	}elseif($names==3){
		$result_st=$country_3;
	}elseif($names==4){
		$result_st=$isd_code;
	}elseif($names==5){
		$result_st=$currency;
	}
	//return $result_st." = ".$country;
	if(!$country_1&&!$country_2&&!$country_3) return false;
	else
	{
		return $result_st;
	}

}

/*
echo "<br/>".get_country_code("United States (US)");
echo "<br/>".get_country_code("United States of America");
echo "<br/>".get_country_code("Andorra");
echo "<br/>".get_country_code("Hong Kong, SAR China");
echo "<br/>".get_country_code("Holy See (Vatican City State)");
echo "<br/>".get_country_code("Falkland Islands (Malvinas)");
echo "<br/>".get_country_code("cote d'ivoire");
echo "<br/>".get_country_code("Guinea-Bissau");
echo "<br/>".get_country_code("Congo, (Kinshasa)");
echo "<br/>".get_country_code("Micronesia, Federated States Of");
*/


/*
echo "1--".get_country_code("aaaaIndia",1,1);
echo "<br />2--".get_country_code("India",1,1);
echo "<br />3--".get_country_code("India5",2,1);
echo "<br />4--".get_country_code("India",3,1);
*/

function two_code($val,$cntyNm=''){
	$result='';
	$stn=strtoupper(trim($val));
	if(($stn=='ACT'||$stn=='AUSTRALIAN CAPITAL TERRITORY')||($cntyNm=='AU'&&$stn=='CT')){$result='ACT';}
	elseif(($stn=='NSW'||$stn=='NEW SOUTH WALES')||($cntyNm=='AU'&&$stn=='NS')){$result='NSW';}
	elseif(($stn=='QLD'||$stn=='QUEENSLAND')||($cntyNm=='AU'&&$stn=='QL')){$result='QLD';}
	elseif(($stn=='TAS'||$stn=='TASMANIA')||($cntyNm=='AU'&&$stn=='TS')){$result='TAS';}
	elseif(($stn=='VIC'||$stn=='VICTORIA')||($cntyNm=='AU'&&$stn=='VI')){$result='VIC';}
	elseif(strlen($val)==2){$result=strtoupper($val);}
	else{$val=(substr($val, 0, 2));$result=strtoupper($val);}
	return $result;
}

?>