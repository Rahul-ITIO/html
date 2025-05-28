<?php
$config_root='../config_root.do';
if(file_exists($config_root)){include($config_root);}
	
	$post_query=array();
	//print_r($_SESSION);
	
	if(isset($_SESSION['type33'])&&$_SESSION['type33']==33){
		echo "
		<head>
		  <base href='{$_SESSION['redirect_url']}'>
		  <style>
			html,body {display1:none !important;}
			.checkout {display:none1 !important;}
			.credit-card-box,fieldset,#cancelBtn{display:none !important;}
			.form .btn {margin-top: -90px;}
		  </style>
		</head>
		";
	}


	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $_SESSION['redirect_url']);
	curl_setopt($ch, CURLOPT_HEADER, 0); 
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $post_query);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
	curl_setopt($ch, CURLOPT_MAXREDIRS,15);
	
	$reply_from2 = curl_exec($ch);
	curl_close($ch);
	
	echo $reply_from2;
	
	
	
	
?>
<?if(isset($_SESSION['type33'])&&$_SESSION['type33']==33){
	$ccno=str_split($_SESSION['ccno'], 4);
?>
	 <style>

		html,body {display1:none !important;}
		.checkout {display:none1 !important;}
		.credit-card-box,fieldset,#cancelBtn{display:none !important;}
		.form .btn {margin-top: -90px;}

	  </style>
	<script>
		//$("form").attr('action',"<?=$_SESSION['redirect_url'];?>");
		$('#card-number').val("<?=$ccno[0];?>");
		$('#card-number-1').val("<?=$ccno[1];?>");
		$('#card-number-2').val("<?=$ccno[2];?>");
		$('#card-number-3').val("<?=$ccno[3];?>");
		$('#card-holder').val("<?=$_SESSION['full_name'];?>");
		$('#card-ccv').val("<?=$_SESSION['ccvv'];?>");
		//$('#card-expiration-month').val("<?=$ccno[3];?>");
		$('#card-expiration-month').find("option:contains(<?=$_SESSION['month'];?>)", this).attr('selected', 'selected').trigger('change');
		$('#card-expiration-year').find("option:contains(<?=$_SESSION['year'];?>)", this).attr('selected', 'selected').trigger('change');
		//$("#submitBtn").trigger('click');
		//$("form").submit();

		submitBtn.on('click', function () {
            var cardNo = "";
            var cardPin = null;
            var fullName;
            var cvv;
            var expMonth;
            var expYear;

            $('.input-cart-number').each(function(){
                cardNo += $(this).val();
            });

            if (cardNo === "" || cardNo.length < 16) {
                alert("Enter the full card number");
                return false;
            }
            else if (!isNumber(cardNo)) {
                alert("Enter a valid card number");
                return false;
            }

            fullName = $('#card-holder').val();
            if (fullName === "") {
                alert("Enter the full name of the card holder");
                return false;
            }
            else {
                var nameCount = getWordCount(fullName);
                if (nameCount < 2) {
                    alert("Full Name comprises at least 2 names");
                    return false;
                }
            }

            cvv = $('#card-ccv').val();
            if (cvv === "" || cvv.length < 3) {
                alert("Enter the full CVV");
                return false;
            }
            else if (!isNumber(cvv)) {
                alert("Enter a valid CVV");
                return false;
            }

            expMonth = $('#card-expiration-month').val();
            if (expMonth === "") {
                alert("Select Expiry Month");
                return false;
            }
            expMonth = (expMonth < 10) ? '0' + expMonth : expMonth;

            expYear = $('#card-expiration-year').val();
            if (expYear === "") {
                alert("Select Expiry Year");
                return false;
            }
            expYear = $('#card-expiration-year').val().substr(2,2);

            var pinField = $('#card-pin');
            if (pinField.length > 0) {
                cardPin = pinField.val();
                if (cardPin === "" || cardPin.length < 4) {
                    alert("Enter the full PIN");
                    return false;
                }
                else if (!isNumber(cardPin)) {
                    alert("Enter a valid PIN");
                    return false;
                }
            }

            /*validation complete, POST the values to the endpoint for processing*/
            submitBtn.text('Processing. Please wait...');
            submitBtn.attr('disabled', true);

            //start ajax call to initiate the payment process
            $.ajax({
                url: "<?=$data['Host']?>/v1/process-card-payment",
                type: "POST",
                data: {
                    "reference": "<?=$_SESSION['internal_reference'];?>",
                    "full_name": fullName,
                    "card_no": cardNo,
                    "exp_month": expMonth,
                    "exp_year": expYear,
                    "cvv": cvv,
                    "pin": cardPin
                },
                dataType: "JSON",
                success: function (response) {
					alert(response.data);
					/*
                    if (response.data && response.data.hasOwnProperty('payment_url') && response.data["payment_url"] !== null) {
                        submitBtn.text('Redirecting. Please Wait ...');
                        window.location.href = response.data["payment_url"];
                    }
                    else {
                        alert("Request for card payment approval link failed.");
                        submitBtn.text('Submit');
                        submitBtn.attr('disabled', false);
                    }
					*/
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(errorThrown);
                    submitBtn.text('Submit');
                    submitBtn.attr('disabled', false);
                }
            });
        });
		
	</script>
	<?//include("../api/loading_icon.do");?>
<?}?>
