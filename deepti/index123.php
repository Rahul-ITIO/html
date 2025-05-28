<?php
echo "deepti";
$url="upi://pay?pa=Lestpe012@AuBank&tn=&am=&mam=&orgid=159765&pn=deepti&mode=02&purpose=00&mc=0000&tr=&url=&category=&ver=01&cu=&mid=&msid=&mtid=&enTips=&mg=online&qrMedium=06&invoiceNo=&invoiceDate=&QRts=&QRexpire=&Split=&PinCode=&Tier=&txntype=&Consent=&mn=&type=&validitystart=&validityend=&Amrule=&Recur=&Recurvalue=&RecureType=&Rev=&Share=&Block=&Umn=&Skip=";

//"upi://pay?ver=01&mode=15&am=500.00&mam=500.00&cu=INR&pa=skywalk.vertrauentech@timecosmos&pn=VERTRAUEN+TECHNOLOGY+PRIVATE+LIMITED&mc=5816&tr=SKYWA7821806257025&tn=7821806257025&mid=SKYWA0700&msid=VERTR-8587&mtid=SKYWA-0700";


?>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
    <input type="hidden" id="qr-text" value="<?=$url;?>">
    <div class="qr-code"></div>
                
            
       
<script> 

let qr_code_element = "<?=$url;?>";

window.addEventListener("load", (event) => {
    let user_input = document.querySelector('#qr-text')
    if (user_input.value != "") {
        if (qr_code_element.childElementCount == 0) {
            generate_qr(user_input)
        } else {
            qr_code_element.innerHTML = ''
            generate_qr(user_input)
        }
    } else {
        alert("not valid")
        qr_code_element.style = "display:none"
    }
})

function generate_qr(user_input) {
    qr_code_element.style = ''
    var qrcode = new QRCode(document.querySelector(".qr-code"), {
        text: `${user_input.value}`,
        width: 180, //default 128
        height: 180,
        colorDark: "black",
        colorLight: "#ffffff",
        correctLevel: QRCode.CorrectLevel.H
    });
	
	}
	</script>
    
