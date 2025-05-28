<?php ?>
<style>

/* google translate api - final - start */


#goog-gt-tt,.VIpgJd-ZVi9od-ORHb,.VIpgJd-ZVi9od-ORHb table,.goog-te-balloon-frame,.skiptranslate,.skiptranslate iframe{display:none!important;}
body{top:0!important;}
.goog-text-highlight{background:0 0!important;box-shadow:none!important;}
.goog-te-gadget-icon{display:none;}
.goog-te-gadget-simple{background-color:#ecebf0!important;border:0!important;font-size:10pt;font-weight:800;display:inline-block;padding:10px!important;cursor:pointer;zoom:1;}
.goog-te-gadget-simple span{color:#3e3065!important;}
#language-inputXX{width:100%;padding:10px;font-size:16px;margin-bottom:20px;}

.language_input {font-family:var(--font_family);content:'';background:#3c4350;height:51px;position:relative;top:2px;z-index:9;font-size:16px;text-transform:uppercase;-webkit-appearance:none;-moz-appearance:none;appearance:none;padding:0 2px;text-align:center;color:#d2d2d2;font-weight:300;width:86px !important;color:#d2d2d2 !important;}

html datalist{position:absolute;background-color:#fff;border:1px solid #00f;border-radius:0 0 5px 5px;border-top:none;font-family:sans-serif;width:350px;padding:5px;max-height:10rem;overflow-y:auto}
html datalist option{background-color:#fff;padding:4px;color:#00f;margin-bottom:1px;font-size:18px;cursor:pointer}

html datalist .active, html datalist option:hover{background-color:#add8e6}

/* google translate api - 2 - start */
.skiptranslate iframe {display:none !important;}

body {margin:0;padding:0;top:0!important}

.skiptranslate iframe{display:none!important}
.goog-te-gadget-icon {display:none}
.goog-te-gadget-simple {background-color:#ecebf0!important;border:0!important;font-size:10pt;font-weight:800;display:inline-block;padding:10px 10px!important;cursor:pointer;zoom:1}
.goog-te-gadget-simple span {color:#3e3065!important}

#google_translate_element_XXX {float:left;overflow:hidden;height:51px;border:0!important;width:90px;margin:6px 0 0 10px;border:1px solid #4e5664!important;background:#3c4350;border-radius:5px;color:#fff;line-height:51px;vertical-align:middle;padding:10px 2px 0 2px;display:flex;position:relative;z-index:1}
#google_translate_element_XXX select {font-family:var(--font_family);content:'';background:#3c4350;height:51px;position:relative;top:-16px;z-index:9;font-size:16px;text-transform:uppercase;-webkit-appearance:none;-moz-appearance:none;appearance:none;padding:0 2px;text-align:center;color:#d2d2d2;font-weight:300}
#google_translate_element1 select option:selected {text-transform:uppercase}
#google_translate_element_XXX select:focus {outline:unset!important}
html .skiptranslate iframe {display:none!important}
.skiptranslate iframe,.skiptranslate iframe * {display:none!important}
#google_translate_element_XXX a {display:none!important}

/* google translate api - end */


/* languages search ui like dropdown - start */
.custom-dropdown{position:relative;}
.dropdown-input{width:100%;padding:10px;font-size:16px;border:1px solid #ccc;border-radius:4px;box-shadow:0 2px 5px rgba(0,0,0,.1);cursor:pointer}
.dropdown-options{position:absolute;top:100%;left:0;right:0;width:240px;max-height:calc(100vh - 50px);overflow-y:auto;background:#fff;border:1px solid #ccc;border-radius:4px;z-index:1000;display:none}
.dropdown-options div{padding:10px;cursor:pointer}
.dropdown-options div img{width:20px;height:auto;margin-right:10px}
.dropdown-options div:hover{background:#f0f0f0}

/* languages search ui like dropdown - end */

</style>



<div class="custom-dropdown">
    <input type="text" id="language_input_ui_1" class="dropdown-input language_input" translate="no" placeholder="LANG" />
    <div class="dropdown-options" translate="no" id="dropdown-options">
        <div data-lang="en">Eng</div>
        <div data-lang="ab">Abkhaz</div>
        <div data-lang="ace">Acehnese</div>
        <div data-lang="ach">Acholi</div>
        <div data-lang="aa">Afar</div>
        <div data-lang="af">Afrikaans</div>
        <div data-lang="sq">Albanian</div>
        <div data-lang="alz">Alur</div>
        <div data-lang="am">Amharic</div>
        <div data-lang="ar">Arabic</div>
        <div data-lang="hy">Armenian</div>
        <div data-lang="as">Assamese</div>
        <div data-lang="av">Avar</div>
        <div data-lang="awa">Awadhi</div>
        <div data-lang="ay">Aymara</div>
        <div data-lang="az">Azerbaijani</div>
        <div data-lang="ban">Balinese</div>
        <div data-lang="bal">Baluchi</div>
        <div data-lang="bm">Bambara</div>
        <div data-lang="bci">Baoulé</div>
        <div data-lang="ba">Bashkir</div>
        <div data-lang="eu">Basque</div>
        <div data-lang="btx">Batak Karo</div>
        <div data-lang="bts">Batak Simalungun</div>
        <div data-lang="bbc">Batak Toba</div>
        <div data-lang="be">Belarusian</div>
        <div data-lang="bem">Bemba</div>
        <div data-lang="bn">Bengali</div>
        <div data-lang="bew">Betawi</div>
        <div data-lang="bho">Bhojpuri</div>
        <div data-lang="bik">Bikol</div>
        <div data-lang="bs">Bosnian</div>
        <div data-lang="br">Breton</div>
        <div data-lang="bg">Bulgarian</div>
        <div data-lang="bua">Buryat</div>
        <div data-lang="yue">Cantonese</div>
        <div data-lang="ca">Catalan</div>
        <div data-lang="ceb">Cebuano</div>
        <div data-lang="ch">Chamorro</div>
        <div data-lang="ce">Chechen</div>
        <div data-lang="ny">Chichewa</div>
        <div data-lang="zh-CN">Chinese (Simplified)</div>
        <div data-lang="zh-TW">Chinese (Traditional)</div>
        <div data-lang="chk">Chuukese</div>
        <div data-lang="cv">Chuvash</div>
        <div data-lang="co">Corsican</div>
        <div data-lang="crh">Crimean Tatar (Cyrillic)</div>
        <div data-lang="crh-Latn">Crimean Tatar (Latin)</div>
        <div data-lang="hr">Croatian</div>
        <div data-lang="cs">Czech</div>
        <div data-lang="da">Danish</div>
        <div data-lang="fa-AF">Dari</div>
        <div data-lang="dv">Dhivehi</div>
        <div data-lang="din">Dinka</div>
        <div data-lang="doi">Dogri</div>
        <div data-lang="dov">Dombe</div>
        <div data-lang="nl">Dutch</div>
        <div data-lang="dyu">Dyula</div>
        <div data-lang="dz">Dzongkha</div>
        <div data-lang="eo">Esperanto</div>
        <div data-lang="et">Estonian</div>
        <div data-lang="ee">Ewe</div>
        <div data-lang="fo">Faroese</div>
        <div data-lang="fj">Fijian</div>
        <div data-lang="tl">Filipino</div>
        <div data-lang="fi">Finnish</div>
        <div data-lang="fon">Fon</div>
        <div data-lang="fr">French</div>
        <div data-lang="fr-CA">French (Canada)</div>
        <div data-lang="fy">Frisian</div>
        <div data-lang="fur">Friulian</div>
        <div data-lang="ff">Fulani</div>
        <div data-lang="gaa">Ga</div>
        <div data-lang="gl">Galician</div>
        <div data-lang="ka">Georgian</div>
        <div data-lang="de">German</div>
        <div data-lang="el">Greek</div>
        <div data-lang="gn">Guarani</div>
        <div data-lang="gu">Gujarati</div>
        <div data-lang="ht">Haitian Creole</div>
        <div data-lang="cnh">Hakha Chin</div>
        <div data-lang="ha">Hausa</div>
        <div data-lang="haw">Hawaiian</div>
        <div data-lang="iw">Hebrew</div>
        <div data-lang="hil">Hiligaynon</div>
        <div data-lang="hi">Hindi</div>
        <div data-lang="hmn">Hmong</div>
        <div data-lang="hu">Hungarian</div>
        <div data-lang="hrx">Hunsrik</div>
        <div data-lang="iba">Iban</div>
        <div data-lang="is">Icelandic</div>
        <div data-lang="ig">Igbo</div>
        <div data-lang="ilo">Ilocano</div>
        <div data-lang="id">Indonesian</div>
        <div data-lang="iu-Latn">Inuktut (Latin)</div>
        <div data-lang="iu">Inuktut (Syllabics)</div>
        <div data-lang="ga">Irish Gaelic</div>
        <div data-lang="it">Italian</div>
        <div data-lang="jam">Jamaican Patois</div>
        <div data-lang="ja">Japanese</div>
        <div data-lang="jw">Javanese</div>
        <div data-lang="kac">Jingpo</div>
        <div data-lang="kl">Kalaallisut</div>
        <div data-lang="kn">Kannada</div>
        <div data-lang="kr">Kanuri</div>
        <div data-lang="pam">Kapampangan</div>
        <div data-lang="kk">Kazakh</div>
        <div data-lang="kha">Khasi</div>
        <div data-lang="km">Khmer</div>
        <div data-lang="cgg">Kiga</div>
        <div data-lang="kg">Kikongo</div>
        <div data-lang="rw">Kinyarwanda</div>
        <div data-lang="ktu">Kituba</div>
        <div data-lang="trp">Kokborok</div>
        <div data-lang="kv">Komi</div>
        <div data-lang="gom">Konkani</div>
        <div data-lang="ko">Korean</div>
        <div data-lang="kri">Krio</div>
        <div data-lang="ku">Kurdish (Kurmanji)</div>
        <div data-lang="ckb">Kurdish (Sorani)</div>
        <div data-lang="ky">Kyrgyz</div>
        <div data-lang="lo">Lao</div>
        <div data-lang="ltg">Latgalian</div>
        <div data-lang="la">Latin</div>
        <div data-lang="lv">Latvian</div>
        <div data-lang="lij">Ligurian</div>
        <div data-lang="li">Limburgish</div>
        <div data-lang="ln">Lingala</div>
        <div data-lang="lt">Lithuanian</div>
        <div data-lang="lmo">Lombard</div>
        <div data-lang="lg">Luganda</div>
        <div data-lang="luo">Luo</div>
        <div data-lang="lb">Luxembourgish</div>
        <div data-lang="mk">Macedonian</div>
        <div data-lang="mad">Madurese</div>
        <div data-lang="mai">Maithili</div>
        <div data-lang="mak">Makassar</div>
        <div data-lang="mg">Malagasy</div>
        <div data-lang="ms">Malay</div>
        <div data-lang="ms-Arab">Malay (Jawi)</div>
        <div data-lang="ml">Malayalam</div>
        <div data-lang="mt">Maltese</div>
        <div data-lang="mam">Mam</div>
        <div data-lang="gv">Manx</div>
        <div data-lang="mi">Maori</div>
        <div data-lang="mr">Marathi</div>
        <div data-lang="mh">Marshallese</div>
        <div data-lang="mwr">Marwadi</div>
        <div data-lang="mfe">Mauritian Creole</div>
        <div data-lang="chm">Meadow Mari</div>
        <div data-lang="mni-Mtei">Meiteilon (Manipuri)</div>
        <div data-lang="min">Minang</div>
        <div data-lang="lus">Mizo</div>
        <div data-lang="mn">Mongolian</div>
        <div data-lang="my">Myanmar (Burmese)</div>
        <div data-lang="bm-Nkoo">N'Ko</div>
        <div data-lang="nhe">Nahuatl (Eastern Huasteca)</div>
        <div data-lang="ndc-ZW">Ndau</div>
        <div data-lang="nr">Ndebele (South)</div>
        <div data-lang="new">Nepal Bhasa (Newari)</div>
        <div data-lang="ne">Nepali</div>
        <div data-lang="no">Norwegian</div>
        <div data-lang="nus">Nuer</div>
        <div data-lang="oc">Occitan</div>
        <div data-lang="or">Odia (Oriya)</div>
        <div data-lang="om">Oromo</div>
        <div data-lang="os">Ossetian</div>
        <div data-lang="pag">Pangasinan</div>
        <div data-lang="pap">Papiamento</div>
        <div data-lang="ps">Pashto</div>
        <div data-lang="fa">Persian</div>
        <div data-lang="pl">Polish</div>
        <div data-lang="pt">Portuguese (Brazil)</div>
        <div data-lang="pt-PT">Portuguese (Portugal)</div>
        <div data-lang="pa">Punjabi (Gurmukhi)</div>
        <div data-lang="pa-Arab">Punjabi (Shahmukhi)</div>
        <div data-lang="qu">Quechua</div>
        <div data-lang="kek">Qʼeqchiʼ</div>
        <div data-lang="rom">Romani</div>
        <div data-lang="ro">Romanian</div>
        <div data-lang="rn">Rundi</div>
        <div data-lang="ru">Russian</div>
        <div data-lang="se">Sami (North)</div>
        <div data-lang="sm">Samoan</div>
        <div data-lang="sg">Sango</div>
        <div data-lang="sa">Sanskrit</div>
        <div data-lang="sat-Latn">Santali (Latin)</div>
        <div data-lang="sat">Santali (Ol Chiki)</div>
        <div data-lang="gd">Scots Gaelic</div>
        <div data-lang="nso">Sepedi</div>
        <div data-lang="sr">Serbian</div>
        <div data-lang="st">Sesotho</div>
        <div data-lang="crs">Seychellois Creole</div>
        <div data-lang="shn">Shan</div>
        <div data-lang="sn">Shona</div>
        <div data-lang="scn">Sicilian</div>
        <div data-lang="szl">Silesian</div>
        <div data-lang="sd">Sindhi</div>
        <div data-lang="si">Sinhala</div>
        <div data-lang="sk">Slovak</div>
        <div data-lang="sl">Slovenian</div>
        <div data-lang="so">Somali</div>
        <div data-lang="es">Spanish</div>
        <div data-lang="su">Sundanese</div>
        <div data-lang="sus">Susu</div>
        <div data-lang="sw">Swahili</div>
        <div data-lang="ss">Swati</div>
        <div data-lang="sv">Swedish</div>
        <div data-lang="ty">Tahitian</div>
        <div data-lang="tg">Tajik</div>
        <div data-lang="ber-Latn">Tamazight</div>
        <div data-lang="ber">Tamazight (Tifinagh)</div>
        <div data-lang="ta">Tamil</div>
        <div data-lang="tt">Tatar</div>
        <div data-lang="te">Telugu</div>
        <div data-lang="tet">Tetum</div>
        <div data-lang="th">Thai</div>
        <div data-lang="bo">Tibetan</div>
        <div data-lang="ti">Tigrinya</div>
        <div data-lang="tiv">Tiv</div>
        <div data-lang="tpi">Tok Pisin</div>
        <div data-lang="to">Tongan</div>
        <div data-lang="lua">Tshiluba</div>
        <div data-lang="ts">Tsonga</div>
        <div data-lang="tn">Tswana</div>
        <div data-lang="tcy">Tulu</div>
        <div data-lang="tum">Tumbuka</div>
        <div data-lang="tr">Turkish</div>
        <div data-lang="tk">Turkmen</div>
        <div data-lang="tyv">Tuvan</div>
        <div data-lang="ak">Twi</div>
        <div data-lang="udm">Udmurt</div>
        <div data-lang="uk">Ukrainian</div>
        <div data-lang="ur">Urdu</div>
        <div data-lang="ug">Uyghur</div>
        <div data-lang="uz">Uzbek</div>
        <div data-lang="ve">Venda</div>
        <div data-lang="vec">Venetian</div>
        <div data-lang="vi">Vietnamese</div>
        <div data-lang="war">Waray</div>
        <div data-lang="cy">Welsh</div>
        <div data-lang="wo">Wolof</div>
        <div data-lang="xh">Xhosa</div>
        <div data-lang="sah">Yakut</div>
        <div data-lang="yi">Yiddish</div>
        <div data-lang="yo">Yoruba</div>
        <div data-lang="yua">Yucatec Maya</div>
        <div data-lang="zap">Zapotec</div>
        <div data-lang="zu">Zulu</div>
    </div>
</div>


<div id="google_translate_element"> </div>

            
<script>

//STEP:1 Function to set a cookie  ######################################
function setCookie_f2(name, value, days) {
var expires = "";
if (days) {
    var date = new Date();
    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
    expires = "; expires=" + date.toUTCString();
}
document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

// Function to get a cookie
function getCookie_f2(name) {
var nameEQ = name + "=";
var ca = document.cookie.split(';');
for (var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) === ' ') c = c.substring(1, c.length);
    if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
}
return null;
}

const languageDropdownUI = 'Y'; // Dropdown UI is available 
const languageDatalistUI = 'N'; // Datalist UI is available 
const languageSelectUI = 'N';   // Select UI is available 


var findLangVar=''; // input focus var

//STEP:2 trigger Event function for change if select language ######################################
const triggerEvent = (element, eventName) => {
const event = new Event(eventName);
element.dispatchEvent(event);
};

//function for google Translate for Cookie wise set
function googleTranslateCookie(langCode) {
if (langCode) {
    //alert(langCode);
    setCookie_f2('googtrans', langCode, 7);
    setCookie_f2('setGoogTrans', langCode, 7);
    
    //$('.goog-te-combo').val(langCode);
    document.querySelector('.goog-te-combo').value = langCode; ;
    triggerEvent(document.querySelector('.goog-te-combo'), 'change');

} else {
    alert('Language not found. Please select from the list.');
}
}

//Get Api google transalate function
function googleTranslateElementInit() {
new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
}

// Ensure the Google Translate element is initialized after the DOM is fully on loaded
document.addEventListener('DOMContentLoaded', function() {
// googleTranslateElementInit();
});

//END GOOGLE TRANSLATE PRIMARY FUNCTION ##################################################

//if Dropdown UI is available :: search ui like dropdown ######################################
var input_ui_1 = ''; var dropdownOptions = '';
if(languageDropdownUI=='Y')
{
input_ui_1 = document.getElementById('language_input_ui_1');
dropdownOptions = document.getElementById('dropdown-options');

// Show dropdown options when input is focused
input_ui_1.addEventListener('focus', function() {
    dropdownOptions.style.display = 'block';
    findLangVar = input_ui_1.value;
    if(input_ui_1.value !==''){
        input_ui_1.value='';
    }
});

//On focusout 
input_ui_1.addEventListener('focusout', function() {
    if(findLangVar !==''){
        input_ui_1.value=findLangVar;
    }
});

// Hide dropdown options when clicking outside
document.addEventListener('click', function(event) {
    if (!input_ui_1.contains(event.target) && !dropdownOptions.contains(event.target)) {
        dropdownOptions.style.display = 'none';
    }
    
});

// Filter options based on input
input_ui_1.addEventListener('input', function() {
    const value = this.value.toLowerCase();
    const options = dropdownOptions.querySelectorAll('div');

    options.forEach(option => {
        if (option.textContent.toLowerCase().includes(value)) {
            option.style.display = ''; // Show matching options
        } else {
            option.style.display = 'none'; // Hide non-matching options
        }
    });
});

// Select an option
dropdownOptions.addEventListener('click', function(event) {
    if (event.target && event.target.matches('div')) {
        input_ui_1.value = event.target.textContent; // Set input value
        dropdownOptions.style.display = 'none'; // Hide dropdown
    }
});

// Select an option
dropdownOptions.addEventListener('click', function(event) {
    // Check if the clicked target is a div
    if (event.target && event.target.matches('div')) {
        // Get the data-lang attribute
        const langCode = event.target.dataset.lang; // Access the data-lang attribute
        const langName = event.target.textContent; // Access the text content of the div
        input_ui_1.value = langName; // Set input value to the langName
        console.log("Selected language code:", langCode , "-", langName); // Log the language code
        dropdownOptions.style.display = 'none'; // Hide dropdown

        if(langCode !== 'en')
        {
            input_ui_1.setAttribute("title", "Current Translated in " + input_ui_1.value);
        }
        if(langCode === 'en')
        {
            input_ui_1.setAttribute("title", "ENG");
        }
        
        googleTranslateCookie(langCode); // apply Translate
    }
});


}




//if Datalist UI is available   ######################################
if(languageDatalistUI=='Y')
{
//On focus or click
document.getElementById('language-input').addEventListener('focus', function() {
    findLangVar = document.getElementById('language-input').value;
    if(document.getElementById('language-input').value !==''){
        document.getElementById('language-input').value='';
    }
    
});

//On focusout for select language
document.getElementById('language-input').addEventListener('focusout', function() {
    document.getElementById('language-input').value=findLangVar;
});

//On change if select language
document.getElementById('language-input').addEventListener('change', function() {
    const input = document.getElementById('language-input').value;
    if(input !==''){
        findLangVar = input;
    }

    //const langCode = $('#languages option[value="'+input+'"]').attr('data-lang');
    const langCode = document.getElementById('languages').querySelector(`option[value="${input}"]`).getAttribute('data-lang');
    //alert(langCode);

    googleTranslateCookie(langCode);
    
});
}

//if Select UI is available     ######################################
var findLangClickVar='';
if(languageSelectUI=='Y')
{
//On click if select language in language-select

document.getElementById('language-select').addEventListener('click', function() {
    findLangClickVar='Y';
    
});

//On change if select language in language-select
document.getElementById('language-select').addEventListener('change', function() {
    const langCode = document.getElementById('language-select').value;
    if(langCode !==''){
        findLangVar = langCode;
    }
    // alert(langCode);
    if(findLangClickVar == 'Y') {
        googleTranslateCookie(langCode);
    }
});
}






//STEP:3 Fetch current language from cookie and display when window load ######################################
function getGoogleLang(){
var getGoogTrans = getCookie_f2('googtrans');
// alert(getGoogTrans);

var getGoogleTrans = getCookie_f2('setGoogTrans');
// alert(getGoogleTrans);

if(getGoogleTrans != 'en')
{
    // alert(getGoogleTrans);

    if(languageDatalistUI=='Y')
    {
        //const getGoogleTransValue = $('#languages option[data-lang="'+getGoogleTrans+'"]').val();

        // Find the option with the specified data-lang attribute
        const getGoogleTransValue = document.getElementById('languages').querySelector(`option[data-lang="${getGoogleTrans}"]`).value;

        document.getElementById('language-input').value=getGoogleTransValue;
        document.getElementById('language-input').setAttribute("title", "Current Translated in " + getGoogleTransValue);

        
        //alert("getGoogleTrans=> "+getGoogleTrans+", getGoogleTransValue=> "+getGoogleTransValue);
    }

    if(languageSelectUI=='Y')
    {
        // Get the element by ID for select ui
        var languageSelect = document.getElementById('language-select');
        // Check if the element is not undefined and exists
        if (languageSelect !== undefined && languageSelect !== null && getGoogleTrans) 
        {
            languageSelect.value=getGoogleTrans;
            //$('#language-select option[value="'+getGoogleTrans+'"]').prop('selected','selected');
        } 
    }
    
    
    
}

// Check if the input_ui_1 element is not undefined and exists
if (languageDropdownUI=='Y' && input_ui_1 !== undefined && input_ui_1 !== null && getGoogleTrans && dropdownOptions && getGoogleTrans !== 'en' ) 
{
    input_ui_1.value = dropdownOptions.querySelector(`div[data-lang="${getGoogleTrans}"]`).textContent;
    
    
        input_ui_1.setAttribute("title", "Current Translated in " + input_ui_1.value);
   
    
    
} 
else if(languageDropdownUI=='Y' && getGoogleTrans === 'en' || getGoogleTrans === null )
{
    //alert(getGoogleTrans);
    input_ui_1.setAttribute("title", "ENG");
    input_ui_1.value="ENG";
}

}

window.addEventListener('load', function() {
// Your code here
// console.log("Window has fully loaded.");

getGoogleLang();
});

</script>


<script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

