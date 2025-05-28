<? 
// Dev Tech : 23-05-05 fetch_trnsStatus for auto check 
if(!isset($_SESSION))  session_start(); 

$transID='';
if(isset($_REQUEST['transID'])&&$_REQUEST['transID']) $transID=$_REQUEST['transID'];
elseif(isset($_SESSION['transID'])) $transID=$_SESSION['transID'];
elseif(isset($_SESSION['SA']['transID'])) $transID=$_SESSION['SA']['transID'];

$transID=transIDf($transID,0);

$data['fetch_trnsStatus']=$fetch_trnsStatus=$data['Host']."/fetch_trnsStatus".$data['ex']."?transID=".$transID;
$data['curl_status']=$curl_status=$data['Host']."/status".$data['ex']."?action=webhook&transID=".$transID;
//print_r($_SESSION['3ds2_auth']);


if(isset($transID)&&$transID&&!isset($data['transID'])){
	$data['transID']="?transID={$transID}";
}


if(isset($_SESSION['3ds2_auth']['processed'])&&$_SESSION['3ds2_auth']['processed']) {
	$processed=$_SESSION['3ds2_auth']['processed'];
}	
else
{
	$processed=$data['Host']."/status".$data['ex']."?transID=".@$transID;
}

if(isset($_SESSION['3ds2_auth']['startSetInterval'])&&$_SESSION['3ds2_auth']['startSetInterval']=='Y'){
    $startSetInterval='Y';
}
elseif(isset($data['startSetInterval'])&&$data['startSetInterval']=='Y'){
    $startSetInterval='Y';
}
?>
<script type="text/javascript">
if (typeof jQuery == 'undefined') {
  document.write('<script type="text/javascript" src="<?=$data['Host']?>/js/jquery-3.6.0.min.js"><\/script>');        
  } 
</script>

<?php 
if(isset($_SESSION['opener_script'])){
	echo $_SESSION['opener_script'];
} 
?>

<script>
/* Dev Tech : 23-04-25 fetch_trnsStatus for auto fetch_trnsStatus start after 30 second than every 10 second check for bank webhook updated than go to success or failed failed */

var bank_status ="<?=$data['Host']?>/bank_status<?=$data['ex']?>";
var fetch_trnsStatus ="<?=$data['fetch_trnsStatus']?>";
var transID ="<?=$transID?>";
var curl_status ="<?=$curl_status?>";

//alert(transID);
var order_status = 0;
function curl_statusf(){
	//alert(curl_status);
	$.ajax({url: curl_status, type: "GET", dataType: 'json', success: function(result){
		//alert(result);
		//alert(result["order_status"]);
	}});
}

function fetch_trans_statusf(){
	//alert(fetch_trnsStatus);
	$.ajax({url: fetch_trnsStatus+'&actionurl=viasystem', type: "GET", dataType: 'json', success: function(result){
		//alert(result);
		//alert(result["order_status"]);
		order_status = result["order_status"];
		if(result["order_status"] && result["order_status"] == 1 ){
			if (parent.window && parent.window.document) {
				//parent.window.close();
			}
			if (window.opener && window.opener.document) {
				//parent.window.close();
			}
			top.window.location.href=fetch_trnsStatus+'&actionurl=validate';
		}
		else if(result["order_status"] && result["order_status"] > 0 ){
			top.window.location.href=fetch_trnsStatus+'&actionurl=validate';
		}
	}});
}


var clear_fetch_trans_statusf = '';
var clear_curl_statusf = '';
function clearIntervalf() {
  clearInterval(clear_fetch_trans_statusf);
  clearInterval(clear_curl_statusf);
}
<?if(isset($startSetInterval)&&$startSetInterval=='Y')
{?>
    if(transID){
        /*	for fetch_trnsStatus and status check	*/
        setTimeout(function(){ 
            clear_fetch_trans_statusf = setInterval(fetch_trans_statusf, 10000); // every 10000 = 1000 * 10 second 
        }, 30000); // after 30000 = 1000 * 30 second 
        
        /*	for acquirer status check	*/
        setTimeout(function(){ 
            clear_curl_statusf = setInterval(curl_statusf, 15000); // every 15000 = 1000 * 15 second 
        }, 20000); // after 20000 = 1000 * 20 second 
        
        
        /*	clear Interval	*/
        setTimeout(function(){ 
            clearIntervalf();
        }, 419849); // after 419849 = 59978.53333333333 * 7 minutes ; 
        
       // alert('======OK====='+transID);
    }

<?
}?>

//fetch_trans_statusf();
//curl_statusf();

</script>




<script>

function intentf(){
	setTimeout(timerMessage, 10000); //10000
	//setTimeout(timerMessage, 100); //10000
    //alert('===intentf===');
}
function timerMessage() {
  $('.authenticated_div').show(1000);
  $('#redirected').hide(500);
}   



 //time count down    
function CopyToClipboard2(text) {
	text=$(text).html();
	var $txt = $('<textarea />');

	$txt.val(text)
	.css({ width: "1px", height: "1px" })
	.appendTo('body');

	$txt.select();

	if (document.execCommand('copy')) {
		$txt.remove();
	}
}
function updateTimer() {
	timeLeft -= 1000;
	if (timeLeft > 0) {
		timer.text(msToTime(timeLeft));
		timer1.text(msToTime(timeLeft));
	} else {
		//window.location.reload(true);		
	}
}
function msToTime(s) {
	var ms = s % 1000;
	s = (s - ms) / 1000;
	var secs = s % 60;
	s = (s - secs) / 60;
	var mins = s % 60;
	var zero = secs <= 9 ? '0' : '';
	return mins + ':' + zero + secs;
}
var timeLeft = 0;
var timer, timer1;

var processed = "<?php echo $processed;?>";

var redirectLinkAtive='';

$(document).ready(function() {

    <?if(isset($startSetInterval)&&$startSetInterval=='Y')
    {?>
        if(typeof(trans_auto_expired) != 'undefined' && trans_auto_expired != null && trans_auto_expired !='')
        {

            timeLeft = trans_auto_expired; // 15 min = 59978.53333333333 * 15 ;
        }
        else {
            timeLeft = 899678; // 15 min = 59978.53333333333 * 15 ;
        }
        //timeLeft = 9000;
        setTimeout(function(){ 
            top.window.location.href=processed;
        }, timeLeft);
        
        timer = $('#timer');
        timer1 = $('#timer1');
        setInterval(updateTimer, 1000);
    <?
    }
    ?>
    
    /* Dev Tech : 23-05-27 for I have paid show after 35 when load the page	*/
    /*
    setTimeout(function(){ 
        $('.iHavPaid1').show(1000);
    }, 35000); // after 35000 = 1000 * 35 second 
    */

    $(".iHavPaidLink").click(function(){
        //alert('lll');
        if (parent.window && parent.window.document) {
            //parent.window.close();
        }
        if (window.opener && window.opener.document) {
            window.opener.close();
        }
    });
    
    $(".redirectLink").click(function(){
        $(this).addClass('active');
        redirectLinkAtive='active';
    });
    
 
   // alert("===OK===");
    
});


</script>