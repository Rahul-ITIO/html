
Client_id:- dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez

Client_secret:- I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7HBx 

Production URL:- https://apiprod.iserveu.tech/production/

EndPoints for Static UPI :-
https://apiprod.iserveu.tech/production/payin/upi/submerchant/check-vpa
https://apiprod.iserveu.tech/production/payin/upi/composer/selfonboarding
https://apiprod.iserveu.tech/production/payin/upi/composer/generate-qr-code

EndPoints for Dynamic UPI:-
https://apiprod.iserveu.tech/production/payin/upi/initiate-dynamic-transaction 


Skywalk
Rariotest
Requesting username
https://test.gatewayeast.com/payin/pay72/status_72.do?actionurl=notify

skywalk - vpa- skywalklp@indus
rariotest- vpa- rariolp@indus

<?
72
{"live":{"client_id":"dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez","client_secret":"I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7HBx", "payerAccount":"","payerIFSC":"","payerBank":"","dmo_url":"https://apiprod.iserveu.tech/production/payin/upi/composer/selfonboarding","requestingUserName": ""},"test":{"client_id":"EMI8PIj5Esi7T5Q4LVH5X5LHe5uNwqIp0BKdL3sCl8WHlAAb","client_secret":"Q4jAlwLuSUcNNE87D2W3b8PQHv25aKxiYrotlXcxcyX6AOx8BdcLprJCqFGHGVXG", "payerAccount":"650234737984399042","payerIFSC":"NMXB4284485","payerBank":"SBI","dmo_url":"https://apidev.iserveu.online/staging/payin/upi/composer/selfonboarding","requestingUserName": "TestMerchant"},"vpa":"iserveupvtltd@indus"}

721
{"live":{"client_id":"dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez","client_secret":"I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7HBx", "payerAccount":"","payerIFSC":"","payerBank":"","requestingUserName": ""},"test":{"client_id":"EMI8PIj5Esi7T5Q4LVH5X5LHe5uNwqIp0BKdL3sCl8WHlAAb","client_secret":"Q4jAlwLuSUcNNE87D2W3b8PQHv25aKxiYrotlXcxcyX6AOx8BdcLprJCqFGHGVXG", "payerAccount":"650234737984399042","payerIFSC":"NMXB4284485","payerBank":"SBI","requestingUserName": "TestMerchant"},"vpa":"iserveupvtltd@indus"}
	
?>

Project assign on 1st March

Please find the integration docs from the provider, this will be on NexGen3.0  with IND theme.

Developer Doc: Attached

Login Details: Will be shared post estimation

If required, We can schedule a meeting with Provider for assistance. 
Provider is Available on Call and Email for Assistance

Contact person number: 8328985683 Sujeet
Contact person Email :  sujit.panigrahi@iserveu.co.in

You need to perform the following task on this project to mark it as completed:
DMO via s2s method, where you will onboard the merchant same as we were doing in ICICI, Once the merchant will be onboarded, we will receive some key for each user like user name, this user name will be password on below UPI Collect, Dynamic QR/ Intent, I think this user will act as unique key for each merchant, which later we will be passing by website json in acquirer.
UPI Collect & Dynamic QR Scanner with intent by setting the credential by our bank gateway table in json which received in the above step 1. 
Status Check where the data credential will be taken from the transaction table of the respected transaction instead of bank table.
Refund Query implementation, if available from the provider.
SOFT POS Implantation of POS system by Fixed QR Code scan.
Final Testing on OPAL IND theme is require.
Setting up the Dynamic webhook for the transaction response to get such data auto updated.
Add maximum explanation comment on the code. For example, there is any additional parameter from the provider which is hard to guess, please explain by comments. if you are sending any value by hard code, please explain using comment. if you have confusion on the code, please explain by comment.
Setup the same dynamically on test.gatewayeast and perform the successful transaction.
Kindly review the integration carefully and share us the estimated time before initiation of the project. if you face any issue while understanding the docs, let me know, I will explain the same.

Please ensue to double check everything before marking everything completed.

---------
Hi Sir

I've created code for following APIs
1. Static QR
2. Dynamic QR
3. DMO
4. Collect
5. Status (Transaction Status Enquiry)

1. Static QR
Working fine and received QR string, but when I'm trying to create QR and scan with payment app and via google  - always returned invalid QR

2. Dynamic QR
Working fine and received QR string, but when I'm trying to create QR and scan with payment app and via google  - always returned invalid QR


3. DMO
Always returned same response - User already onboarded for upi transaction

Please can you provide PAN and other detail for Testing environment

My log is:

URL:https://apidev.iserveu.online/staging/payin/upi/composer/selfonboarding
Request:
{ "merchantBusinessName": "Test Merchant", "firstName": "", "lastName": "Sharma", "pan": "ZLWJS4929E", "accountNumber": "650234737984399042", "ifsc": "NMXB4284485", "legalStoreName": "Test Store", "merchantVirtualAddress": "@indus", "merchantEmailId": "s@bigit.io", "merchantMobileNumber": "7931736500", "bankName": "SBI", "clientRefId": "KHX0099601678353569", "paramB": "", "paramC": "", "clientCallbackUrl": "" }

Response: 
( [statusDesc] => User already onboarded for upi transaction. [error] => User already onboarded for upi transaction. [status] => FAILED [statusCode] => -1 ) 

-----------
4. Collect 
Working fine and Collect request initiated successfully. And complete log given below:

Request: 
{ "virtualAddress": "9853162924@ybl", "amount": "11.00", "merchantType": "DIRECT", "paymentMode": "VPA", "channelId": "WEBUSER", "clientRefId": "KHX0099601678349933", "isWalletTopUp": true, "remarks": "test", "requestingUserName": "isutest" }

Response: Array ( [txnId] => 1083303025050648576 [merchantId] => INDB000000384512 [amount] => 11.0 [status] => 1 [statusDesc] => Collect request initiated successfully. [paymentState] => INITIATED [payerVPA] => 9853162924@ybl [payeeVPA] => iserveupvtltd@indus [qrData] => [intentData] => [statusCode] => 0 [clientRefId] => KHX0099601678349933 ) 

5. Status
I'm fetching transaction detail with above clientRefId (KHX0099601678349933) and txnId (1083303025050648576) but returned no data

My log is:
URL:https://apidev.iserveu.online/staging/statuscheck/txnreport
Request:
{ "$1": "Upi_txn_status_api", "$4": "2023-03-09", "$5": "2023-03-09", "$6": "KHX0099601678349933", "$10": 1083303025050648576 }

Response: 
{"status":1,"message":"Transaction response has no data for required parameters","length":0,"results":[]}Array ( [status] => 1 [message] => Transaction response has no data for required parameters [length] => 0 [results] => Array ( ) ) 


=========

DMO success
URL:https://apidev.iserveu.online/staging/payin/upi/composer/selfonboarding
Request:
{ "merchantBusinessName": "Test Merchant", "firstName": "", "lastName": "Sharma", "pan": "ZLWJS4929E", "accountNumber": "650234737984399042", "ifsc": "NMXB4284485", "legalStoreName": "Test Store", "merchantVirtualAddress": "@indus", "merchantEmailId": "s@bigit.io", "merchantMobileNumber": "7931736500", "bankName": "SBI", "clientRefId": "KHX0099601678421618", "paramB": "", "paramC": "", "clientCallbackUrl": "", "requestingUserName": "TestMerchant" }

Array ( [status] => SUCCESS [statusCode] => 0 [statusDesc] => User Onboarded Successfully ) 

----
Error if already hit
Array ( [statusDesc] => Mobile Number Already Taken [error] => Mobile Number Already Taken [status] => FAILED [statusCode] => -1 ) 


========

Hi ,

Please find the integration docs from the provider, this will be on NexGen3.0  with IND theme.

Developer Doc: Attached

Login Details: Will be shared post estimation

If required, We can schedule a meeting with Provider for assistance. 
Provider is Available on Call and Email for Assistance

Contact person number: 8328985683 Sujeet
Contact person Email :  sujit.panigrahi@iserveu.co.in



You need to perform the following task on this project to mark it as completed:
1.	DMO via s2s method, where you will onboard the merchant same as we were doing in ICICI, Once the merchant will be onboarded, we will receive some key for each user like user name, this user name will be password on below UPI Collect, Dynamic QR/ Intent, I think this user will act as unique key for each merchant, which later we will be passing by website json in acquirer.

2.	UPI Collect & Dynamic QR Scanner with intent by setting the credential by our bank gateway table in json which received in the above step 1. 
3.	Status Check where the data credential will be taken from the transaction table of the respected transaction instead of bank table.
4.	Refund Query implementation, if available from the provider.
5.	SOFT POS Implantation of POS system by Fixed QR Code scan.
6.	Final Testing on OPAL IND theme is require.
7.	Setting up the Dynamic webhook for the transaction response to get such data auto updated.
8.	Add maximum explanation comment on the code. For example, there is any additional parameter from the provider which is hard to guess, please explain by comments. if you are sending any value by hard code, please explain using comment. if you have confusion on the code, please explain by comment.
8.	Setup the same dynamically on test.gatewayeast and perform the successful transaction.
9.	Kindly review the integration carefully and share us the estimated time before initiation of the project. if you face any issue while understanding the docs, let me know, I will explain the same.

Please ensue to double check everything before marking everything completed.