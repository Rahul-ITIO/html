<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- INCLUDE SESSION.JS JAVASCRIPT LIBRARY -->
<script src="https://eu-gateway.mastercard.com/form/version/78/merchant/GLADCORIGKEN/session.js"></script>

<!-- APPLY CLICK-JACKING STYLING AND HIDE CONTENTS OF THE PAGE -->
<style id="antiClickjack">body{display:none !important;}</style>
</head>
<body>

<!-- CREATE THE HTML FOR THE PAYMENT PAGE -->

<div>Please enter your payment details:</div>
<div>Card Number: <input type="text" id="card-number" class="input-field" value="345678901234564" readonly></div>
<div>Expiry Month:<input type="text" id="expiry-month" class="input-field" value="01"></div>
<div>Expiry Year:<input type="text" id="expiry-year" class="input-field" value="39"></div>
<div>Security Code:<input type="text" id="security-code" class="input-field" value="0000" readonly></div>
<div><button id="payButton" onclick="pay();">Pay Now</button></div>

<!-- DISPLAY VISA CHECKOUT AS A PAYMENT OPTION ON YOUR PAYMENT PAGE -->

<!-- REPLACE THE action URL with the payment URL on your webserver -->
<!-- Other fields can be added to enable you to collect additional data on the payment page -->
Email: <input type="text" value="devops@itio.in" name="email"><br/>
<!-- The hidden values below can be set in the callback function as they are returned when creating the session -->
sessionId: <input type="text" name="sessionId" id="sessionId"><br/>
<img id="visaCheckoutButton" alt="Visa Checkout" role="button" class="v-button" style="display: none;" src="https://sandbox.www.v.me/wallet-services-web/xo/button.png"/>
</form>

<!-- JAVASCRIPT FRAME-BREAKER CODE TO PROVIDE PROTECTION AGAINST IFRAME CLICK-JACKING -->
<script type="text/javascript">
if (self === top) {
    var antiClickjack = document.getElementById("antiClickjack");
    antiClickjack.parentNode.removeChild(antiClickjack);
} else {
    top.location = self.location;
}

PaymentSession.configure({
    fields: {
        // ATTACH HOSTED FIELDS TO YOUR PAYMENT PAGE
        cardNumber: "#card-number",
        securityCode: "#security-code",
        expiryMonth: "#expiry-month",
        expiryYear: "#expiry-year"
    },
    frameEmbeddingMitigation: ["javascript"],
    callbacks: {
        initialized: function(response) {
            // HANDLE INITIALIZATION RESPONSE
            if (response.status === "ok") {
                document.getElementById("visaCheckoutButton").style.display = 'block';
            }
        },
        formSessionUpdate: function(response) {
            // HANDLE RESPONSE FOR UPDATE SESSION
        if (response.status) {
            if ("ok" == response.status) {
                console.log("Session updated with data: " + response.session.id);

                //check if the security code was provided by the user
                if (response.sourceOfFunds.provided.card.securityCode) {
                    console.log("Security code was provided.");
                }

                //check if the user entered a MasterCard credit card
                if (response.sourceOfFunds.provided.card.scheme == 'MASTERCARD') {
                    console.log("The user entered a MasterCard credit card.")
                }
            } else if ("fields_in_error" == response.status)  {

                console.log("Session update failed with field errors.");
                if (response.errors.cardNumber) {
                    console.log("Card number invalid or missing.");
                }
                if (response.errors.expiryYear) {
                    console.log("Expiry year invalid or missing.");
                }
                if (response.errors.expiryMonth) {
                    console.log("Expiry month invalid or missing.");
                }
                if (response.errors.securityCode) {
                    console.log("Security code invalid.");
                }
            } else if ("request_timeout" == response.status)  {
                console.log("Session update failed with request timeout: " + response.errors.message);
            } else if ("system_error" == response.status)  {
                console.log("Session update failed with system error: " + response.errors.message);
            }
        } else {
            console.log("Session update failed: " + response);
        }
        },
        visaCheckout: function(response) {
            // HANDLE VISA CHECKOUT RESPONSE
        }
    },
    order: {
        amount: 10.00,
        currency: "AUD"
    },
    wallets: {
        visaCheckout: {
            enabled: true,
            // Add Visa Checkout API specific attributes here
            countryCode: "KE",
            displayName: "KE ITIO ",
            locale: "en_au",
            logoUrl: "http://logo.logo",
            payment: {
                cardBrands: [
                    "VISA"
                ]
            },
            review: {
                buttonAction: "Pay",
                message: "Message"
            },
            shipping: {
                acceptedRegions: [
                    "AU"
                ],
                collectShipping: true
            }
        }
    }
});

function pay() {
    // UPDATE THE SESSION WITH THE INPUT FROM HOSTED FIELDS
    PaymentSession.updateSessionFromForm();
}

</script>
</body>
<html>