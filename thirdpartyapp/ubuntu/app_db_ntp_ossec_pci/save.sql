
Postgres equivalent to MySQL s \G?
Postgres equivalent to MySQL s sql_mode?

select * from users \x\g\x

<<auto INCREMENT id -------------------------------


SELECT setval('zt_mer_setting_id_seq', (SELECT MAX(id) FROM zt_mer_setting)+1);

SELECT setval('zt_acquirer_group_template_seq', (SELECT MAX(id) FROM zt_acquirer_group_template)+1);

create sequence zt_mer_setting_id_seq
   owned by zt_mer_setting.id;

alter table zt_mer_setting
   alter column id set default nextval('zt_mer_setting_id_seq');

commit;



create sequence zt_acquirer_group_template_id_seq
   owned by zt_acquirer_group_template.id;

alter table zt_acquirer_group_template
   alter column id set default nextval('zt_acquirer_group_template_id_seq');

commit;



<<view all tables 
select tablename as table from pg_tables  where schemaname = 'public';


<<all tables with records in mysql 

SELECT TABLE_NAME, SUM(TABLE_ROWS) AS record_count
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'dbnamegwdo31'
GROUP BY TABLE_NAME
ORDER BY record_count DESC ;


<<view all tables with records  in psql 

---------------------------------

select n.nspname as table_schema,
       c.relname as table_name,
       c.reltuples as rows
from pg_class c
join pg_namespace n on n.oid = c.relnamespace
where c.relkind = 'r'
      and n.nspname not in ('information_schema','pg_catalog')
order by c.reltuples desc;


---------------------------------

or



SELECT relname, reltuples AS estimate 
FROM pg_class 
WHERE relname IN (
  SELECT TABLE_NAME
  FROM information_schema.tables
  WHERE TABLE_NAME not like 'pg_%' AND table_schema in ('public')
) 
ORDER BY estimate DESC
-----------------------------


or




or
-----------------------------

create or replace function 
count_rows(schema text, tablename text) returns integer
as
$body$
declare
  result integer;
  query varchar;
begin
  query := 'SELECT count(1) FROM ' || schema || '.' || tablename;
  execute query into result;
  return result;
end;
$body$
language plpgsql;


select 
  table_schema,
  table_name, 
  count_rows(table_schema, table_name)
from information_schema.tables
where 
  table_schema not in ('pg_catalog', 'information_schema') 
  and table_type='BASE TABLE'
order by 3 desc;

-----------------------------



<<double ##############################################################

ALTER TABLE IF EXISTS zt_master_trans_table_3
    RENAME payable_amt_of_txn TO payable_amt_of_txn1;
	
	
ALTER TABLE IF EXISTS zt_master_trans_table_3
    ADD COLUMN payable_amt_of_txn double precision;


select id,payable_amt_of_txn,payable_amt_of_txn1  from zt_master_trans_table_3 ORDER BY `id` ASC

http://localhost/gw/tinclude/transaction_update_master_table_3.do


ALTER TABLE zt_master_trans_table_3 DROP COLUMN payable_amt_of_txn1;




ALTER TABLE zt_master_trans_table_3 DROP COLUMN mdr_cbk1_amt;
ALTER TABLE zt_master_trans_table_3
    ADD COLUMN mdr_cbk1_amt double precision;

ALTER TABLE zt_master_trans_table_3 DROP COLUMN mdr_refundfee_amt;
ALTER TABLE zt_master_trans_table_3
    ADD COLUMN mdr_refundfee_amt double precision;

ALTER TABLE zt_master_trans_table_3 DROP COLUMN available_rolling;
ALTER TABLE zt_master_trans_table_3
    ADD COLUMN available_rolling double precision;


ALTER TABLE zt_master_trans_table_3 DROP COLUMN available_balance;
ALTER TABLE zt_master_trans_table_3
    ADD COLUMN available_balance double precision;




###########################################

ALTER TABLE "zt_master_trans_table_3" ALTER COLUMN "payable_amt_of_txn1" TYPE double precision USING payable_amt_of_txn1::double precision;

UPDATE zt_master_trans_table_3 SET payable_amt_of_txn = CAST(payable_amt_of_txn1 AS INTEGER) WHERE payable_amt_of_txn1 IS NOT NULL OR payable_amt_of_txn1 !='';




UPDATE zt_master_trans_table_3 SET payable_amt_of_txn = payable_amt_of_txn1 where payable_amt_of_txn1  !=''

SELECT
  REGEXP_REPLACE(payable_amt_of_txn, '[^0-9\.]+|\. +|\.0|\.{2,}', '', 'g')::DOUBLE PRECISION
FROM public.zt_master_trans_table_3;

UPDATE public.zt_master_trans_table_3 SET payable_amt_of_txn = CAST(payable_amt_of_txn1 :: DOUBLE PRECISION);
UPDATE zt_master_trans_table_3 SET payable_amt_of_txn = payable_amt_of_txn1 :: DOUBLE PRECISION;

UPDATE public.zt_master_trans_table_3 SET payable_amt_of_txn = REGEXP_REPLACE(payable_amt_of_txn1, '[^0-9\.]+|\. +|\.0|\.{2,}', '', 'g')::DOUBLE PRECISION;

ALTER TABLE public.zt_master_trans_table_3
ALTER COLUMN payable_amt_of_txn1 SET DATA TYPE INT
USING payable_amt_of_txn1::INTEGER;

	
alter table some_table 
   alter column some_column type decimal(10,2) using some_column::decimal;
	HINT:  You might need to specify "USING payable_amt_of_txn1::double precision".
##############################################################
<<create user and db with privileges --------------

su - postgres
psql

\l
\du
\l
\c pgdb31
\dt

\q

CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb' SUPERUSER;

CREATE DATABASE pgdb31 WITH OWNER = pgslquser ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE pgdb31 TO pgslquser;

http://13.233.162.247/signins/login
http://13.233.162.247/signins/password?id=21

https://pro.i15.me/signins/index
gwadmn
@aA123456789

$_SESSION['adm_login']=1; $_SESSION['login_adm']=1;$_SESSION['sub_admin_id']=21;

$_SESSION['adm_login']=$_SESSION['login_adm']=1;

##############################################################
<<import --------------
pgslquser

psql -h localhost -p 5432 -U pgslquser -d pgdb31 -f pgwdb_23_12_19.sql
yzKtkQnma%samtDzqG2JZML9TRpFb


##############################################################

select * from zt_subadmin;
select * from zt_access_roles;
select * from zt_acquirer_table;
select COUNT(id) from zt_acquirer_table;
select COUNT(id) from zt_banks;
COMMIT;

SELECT setval('zt_acquirer_table_id_seq', (SELECT MAX(id) FROM zt_acquirer_table));

SELECT setval('zt_acquirer_table_id_seq', (SELECT MAX(id) FROM zt_acquirer_table));


sql - Postgresql GROUP_CONCAT equivalent?

disable strict mode in postgresql

SQL Tutorial - How to check sql_safe_updates mode ? || How to turn off/on SQL SAFE UPDATES mode
select @@sql_safe_updates;

SELECT @@sql_mode;
SELECT @@pgsql_mode;
SHOW VARIABLES LIKE 'sql_mode';
NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION 



select tablename as table from pg_tables  where schemaname = 'public';

SELECT setval('zt_acquirer_table_id_seq', (SELECT MAX(id) FROM zt_acquirer_table));
SELECT setval('zt_master_trans_table_3_id_seq', (SELECT MAX(id) FROM zt_master_trans_table_3));
SELECT setval('zt_master_trans_additional_3_id_seq', (SELECT MAX(id) FROM zt_master_trans_additional_3));


	




"host=localhost port=3306 dbname=pgwdb us
er=postgres sslmode=prefer connect_timeout=10"

ALTER TABLE `zt_master_trans_table_3` CHANGE `trans_amt` `trans_amt` DOUBLE(10,2) NULL DEFAULT NULL;

ALTER TABLE "zt_mer_setting" ALTER "virtual_fee" TYPE double precision USING virtual_fee::double precision;

DELETE FROM "zt_maszt_master_trans_table_3" WHERE "id"='29';



SELECT * FROM "zt_support_tickets" WHERE "status" NOT IN (90) ORDER BY FIELD("status", 2,4,91,1,0), "id" DESC LIMIT 50;

SELECT * FROM "zt_support_tickets" WHERE "status" NOT IN (90) ORDER BY ARRAY_POSITION(ARRAY[2,4,91,1,0], "status"), "id" DESC LIMIT 50;


ORDER BY ARRAY_POSITION(ARRAY[2,4,91,1,0], "status")



2366
function payout_trans_newf

SELECT GROUP_CONCAT(DISTINCT ("terNO")) AS "terNO", GROUP_CONCAT(DISTINCT ("trans_type")) AS "trans_type", COUNT("id") AS "count", MIN("id") AS "min_id", MAX("id") AS "max_id", MIN("tdate") AS "min_tdate", MAX("tdate") AS "max_tdate", MIN("fee_update_timestamp") AS "min_feetime", MAX("fee_update_timestamp") AS "max_feetime" FROM "zt_master_trans_table_3" WHERE ( "merID"='272' ) AND ( (DATE_FORMAT("settelement_date", '%Y%m%d')) <= (DATE_FORMAT(now(), '%Y%m%d')) ) AND ("trans_status" NOT IN (9,10)) AND ( id between 0 AND 0 ) ORDER BY "id" ASC LIMIT 1;

SELECT array_to_string(array_agg(DISTINCT "terNO"), ',') AS "terNO", array_to_string(array_agg(DISTINCT "trans_type"), ',') AS "trans_type", COUNT("id") AS "count", MIN("id") AS "min_id", MAX("id") AS "max_id", MIN("tdate") AS "min_tdate", MAX("tdate") AS "max_tdate", MIN("fee_update_timestamp") AS "min_feetime", MAX("fee_update_timestamp") AS "max_feetime" FROM "zt_master_trans_table_3" WHERE ( "merID"='272' ) AND ( (to_char("settelement_date", 'YYYY-MM-DD')) <= (to_char(now(), 'YYYY-MM-DD')) ) AND ("trans_status" NOT IN (9,10))  LIMIT 1;

".group_concat_return('`id`',0)."
".group_concat_return('`terNO`',1)."

(".date_format_return('`settelement_date`',1).")


(".date_format_return('now()',1).")


(".date_type_return('`settelement_date`',2).")


if($data['connection_type']=='PSQL') 
		$use_index="";
	else
		$use_index="USE INDEX (merID)";


$account_type_whr=" AND (`settelement_date` BETWEEN (DATE_FORMAT('{$wd_created_date_prev}', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('{$wd_created_date}', '%Y%m%d%H%i%s')))";
	
	$account_type_whr=" AND ( `settelement_date` >= '{$wd_created_date_prev}' AND `settelement_date` <= '{$wd_created_date}' ) ";
	
	




INSERT INTO "zt_access_roles" VALUES (11,'Whitelabel Gateway Partner',0,1,0,0,1,0,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,0,1,0,1,1,0,1,1,1,1,0,1,0,1,0,0,0,0,0,1,1,1,0,1,1,0,1,1,0,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,0,0,1,1,1,1,1,1,1,0,0,1,0,1,1,1,1,1,1,'MarsPay whitelable Gateway Partner',NULL,NULL),(26,'Admin2',1,0,0,1,0,0,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,0,1,0,1,1,1,1,1,1,'This tttttttt',NULL,NULL),(32,'dev 34344343',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'zxzxz',NULL,NULL),(33,'dev 34344343 Copy',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'zxzxz',NULL,NULL);


INSERT INTO "zt_subadmin" VALUES (21,'gwadmn','2ca80b6ac7337520d2e4a5256166065071a4c87ee85150ccc895939186d45e61',',27,',',21,','{"decrypt":"dG9mNTJJazJDU0FzdzNqZXNwWk5RQT09","key":"1"}',1,'GW Admin 11','','','D-3','Kausambi','IN','UP3','112255','11226644559','',11,'','21_logo.png','21_chat_24.gif','cashfree','','localhost',1,'','7044554455','{"decrypt":"TEN6YXl0VVpmRkVJT1BTLzdNbjZoZz09","key":"1"}','',NULL,'','2KBC44E32HDQLH5E',1,'','2023-06-02 14:58:40','','','{"transaction_display":["transaction_id","mrid","names","amount","transaction_amt","available_balance","tdate","cardtype","reason","type","status","receiver","txn_value","json_value","currname","remark","reply_remark","ccno","source_url","notify_url","success_url","failed_url","orderset","system_note","mdr_amt","mdr_txtfee_amt","rolling_amt","mdr_cb_amt","mdr_cbk1_amt","mdr_refundfee_amt","payable_amt_of_txn","payout_date","risk_ratio","transaction_period","bank_processing_amount","bank_processing_curr","json_value","created_date","txn_id","trname","email_add","phone_no","store_id","product_name","address","city","state","country","zip","descriptor","ip"]}','IND','#3b8894','#ffffff','#f5f5f6','#000000','#a71f5f','#000000','Left_Panel','','',1,'#30ca1c','#41190b',NULL,'');


SELECT * FROM `zt_subadmin` WHERE `domain_name`='localhost' AND `domain_active`=1 LIMIT 1


SELECT * FROM "zt_subadmin" WHERE "domain_name"='localhost' AND "domain_active"=1 LIMIT 1;

SELECT * FROM zt_subadmin WHERE domain_name='localhost' AND domain_active=1 LIMIT 1




INSERT INTO "zt_acquirer_table" VALUES (1,'',0,2111,'ddddd',2444,'dfsdfsdfsdds111','','','Manual Processing','','','sdsdsdsds','4','3','1','','','','INR','This is evok ','INR','dsfdsfdsfds','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"2.8","gst_fee":"18.00","settelement_delay":"1","txn_fee_success":"0.00","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"0.00","reserve_delay":"90","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"200","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":"","bank_salt":"","notification_to_005":"005"}',200,0,0,'','','WD',NULL,'{"acquirer_name":"ddddd","skip_checkout_validation":"AddressFalse CardFalse","payment_option_web":"dfdfdsfds","payment_option_mobile":"","popup_msg_web":"","popup_msg_mobile":"","logo_web":"dsfsdsd","logo_mobile":"","checkout_label_web":"ddddd","checkout_label_mobile":""}','dev@bigit.io',NULL,NULL,NULL),(2,'6211,7995',1,781,'Evok QrCode',78,'https://merchantprod.timepayonline.com/evok/qr/v1','https://merchantuat.timepayonline.com/evok/qr/v1','','Full Refund only','https://merchantprod.timepayonline.com/evok/qr/v1/refund','','https://merchantprod.timepayonline.com/evok/qr/v1/qrStatus','10','3','1','','','','','','INR','{"live":{"source":"SPAYFIN001","extTransactionId":"spayfin","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"58d915f30f0e4421b90ca903c97859e6","key":"e76c6205bc4b46a0a4c3301c94587e9a","Checksum_key":"c0019ec9cb994345a8a180d377ba6f4a"},"test":{"source":"SPAYFIN001","extTransactionId":"SPAYFIN","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"2b273ac2cc334f05812b34a04310360a","key":"40103a8179f140d78867648587655baa","Checksum_key":"46efbba174d340d791ba66fa8f6606c1"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"700","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"2.8","gst_rate":"28","settelement_delay":"1","txn_fee_success":"0.00","txn_fee_failed":"0.00","acquirer_display_order":"1","reserve_rate":"0.00","reserve_delay":"120","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"15","monthly_fee":"","refund_fee":"10","return_wire_fee":"","acquirer_processing_json":{"source":"SPAYFIN001","extTransactionId":"spayfin","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"58d915f30f0e4421b90ca903c97859e6","key":"e76c6205bc4b46a0a4c3301c94587e9a","Checksum_key":"c0019ec9cb994345a8a180d377ba6f4a"},"bank_salt":"","notification_to_005":"005"}',200,3,0,'["AO5","BY","BW","BF","BI","CM","CF","CG","TD","CI","EG","GA","GM","GH","ID","IR","IQ","KE","KP","LS","LR","LY","MW","MY","ML","MR","MA","NE","NG","PS","RW","SL","SO","SD","SZ","SY","TG","UG","ZA","ZM","ZW"]','','qrcode','upi','{"acquirer_name":"Evok QrCode","skip_checkout_validation":"AddressFalse CardFalse","payment_option_web":"UPI","payment_option_mobile":"","popup_msg_web":"qrcodeadd qracq_781 upiWalletIndiaList","popup_msg_mobile":"upiAppListForCollect appWalletList upiaddress1 upiAddressIntent intent_submitMsg","logo_web":"qr_code","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"781 QR Code","checkout_label_mobile":"781 UPI Intent"}','dev@bigit.io,arun@bigit.io',NULL,NULL,NULL),(3,'',1,27,'BRIHK',27,'https://payment.gantenpay.com/payment/api/payment','https://payment.gantenpay.com/payment/api/payment','','Full Refund only','https://payment.gantenpay.com/payment/refund/requestForRefund','','https://payment.gantenpay.com/payment/external/query','2','1','1','','','','','','USD','{"visa":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"mastercard":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"jcb":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"amex":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.50","gst_rate":"18.00","settelement_delay":"18","txn_fee_success":"0.80","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"10","reserve_delay":"210","settled_amt":"","charge_back_fee_1":"55","charge_back_fee_2":"70","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"visa":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"mastercard":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"jcb":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"amex":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"}},"bank_salt":""}',0,1,0,'','','amex,mastercard,visa,jcb,discover,diners','','{"acquirer_name":"BRIHK","skip_checkout_validation":"","popup_msg_web":"","popup_msg_mobile":"","logo_web":"cardIcon","logo_mobile":"","checkout_label_web":"27 - 2D - Visa, MasterCard, JCB, AMEX","checkout_label_mobile":""}','',NULL,NULL,NULL),(4,'',1,84,'UPI-PyThru',84,'https://pgapi.pythru.com/api/MerchantAPI/collectpay','https://pgapi.pythru.com/api/MerchantAPI/collectpay','','No Refund supported','','','https://pgapi.pythru.com/api/MerchantAPI/transactionstatus','5','3','1','','','','','','INR','{"live":{"MerchantId":"5208680","subMerchantId":"5208680","terminalId":"5816"},"test":{"MerchantId":"5208680","subMerchantId":"5208680","terminalId":"5816"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"4.50","gst_rate":"18.00","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"3","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"MerchantId":"5208680","subMerchantId":"5208680","terminalId":"5816"},"bank_salt":""}',0,0,0,'','','','','{"acquirer_name":"UPI-PyThru","skip_checkout_validation":"AddressFalse CardFalse","payment_option_web":"UPI","payment_option_mobile":"","popup_msg_web":"upiAppListForCollect appWalletList upiaddress","popup_msg_mobile":"","logo_web":"vimPhonePeGpayPaytm","logo_mobile":"","checkout_label_web":"UPI Payment","checkout_label_mobile":""}','',NULL,NULL,NULL),(5,'',1,841,'QrCode-PyThru',84,'https://pgapi.pythru.com/api/MerchantAPI/qr','https://pgapi.pythru.com/api/MerchantAPI/qr','','No Refund supported','','','https://pgapi.PyThru.com/api/MerchantAPI/transactionstatus','10','3','1','','','','','','INR','{"live":{"MerchantId":"4583842","subMerchantId":"4583842","terminalId":"5816","MerchantName":"Virtual Block Innovations Private Limited","MerchantVPA":"virtual.py@icici"},"test":{"MerchantId":"4583842","subMerchantId":"4583842","terminalId":"5816","MerchantName":"Virtual Block Innovations Private Limited","MerchantVPA":"virtual.py@icici"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"3.80","gst_rate":"18.00","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"10","reserve_delay":"360","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"MerchantId":"4583842","subMerchantId":"4583842","terminalId":"5816","MerchantName":"Virtual Block Innovations Private Limited","MerchantVPA":"virtual.py@icici"},"bank_salt":""}',0,0,0,'','','upi,qrcode',NULL,'{"acquirer_name":"QrCode-PyThru","skip_checkout_validation":"AddressFalse CardFalse","payment_option_web":"UPI","payment_option_mobile":"","popup_msg_web":"qrcodeadd qracq_841","popup_msg_mobile":"upiAppListForIntent  appWalletList appIntent_submitMsg appIntent_841","logo_web":"qr_code","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"QrCode","checkout_label_mobile":"UPI"}','',NULL,NULL,NULL),(6,'',1,78,'Evok',78,'https://merchantprod.timepayonline.com/evok/cm/v2','https://merchantuat.timepayonline.com/evok/cm/v2','india123,reset123','Full Refund only','https://merchantprod.timepayonline.com/evok/cm/v2/refund','https://merchantprod.timepayonline.com/developers','https://merchantprod.timepayonline.com/evok/cm/v2/status','5','3','1','RBI','122.221.33.334','','INR','This is evok ','INR','{"live":{"source":"SPAYFIN001","extTransactionId":"spayfin","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"58d915f30f0e4421b90ca903c97859e6","key":"e76c6205bc4b46a0a4c3301c94587e9a","Checksum_key":"c0019ec9cb994345a8a180d377ba6f4a"},"test":{"source":"SPAYFIN001","extTransactionId":"SPAYFIN","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"2b273ac2cc334f05812b34a04310360a","key":"40103a8179f140d78867648587655baa","Checksum_key":"46efbba174d340d791ba66fa8f6606c1"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"2.8","gst_rate":"18.00","settelement_delay":"1","txn_fee_success":"0.00","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"0.00","reserve_delay":"90","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"200","monthly_fee":"","refund_fee":"10","return_wire_fee":"","acquirer_processing_json":{"source":"SPAYFIN001","extTransactionId":"spayfin","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"58d915f30f0e4421b90ca903c97859e6","key":"e76c6205bc4b46a0a4c3301c94587e9a","Checksum_key":"c0019ec9cb994345a8a180d377ba6f4a"},"bank_salt":"","notification_to_005":"005"}',200,2,5,'["AO5","BY","BW","BF","BI","CM","CF","CG","TD","CI","EG","GA","GM","GH","ID","IR","IQ","KE","KP","LS","LR","LY","MW","MY","ML","MR","MA","NE","NG","PS","RW","SL","SO","SD","SZ","SY","TG","UG","ZA","ZM","ZW"]','','upi',NULL,'{"acquirer_name":"Evok","skip_checkout_validation":"AddressFalse CardFalse","payment_option_web":"UPI vsdfdsfds","payment_option_mobile":"","popup_msg_web":"upiAppListForCollect appWalletList upiaddress upiAddressIntent sdfdsfds","popup_msg_mobile":"","logo_web":"vimPhonePeGpayPaytm","logo_mobile":"","checkout_label_web":"NPS UPI","checkout_label_mobile":""}','dev@bigit.io',NULL,NULL,NULL),(7,'',0,7119999,'IndusInd Collect',71,'https://indusapi.indusind.com/indusapi/prod/eph-upi/Collect/v2','https://indusapiuat.indusind.com/indusapi-np/uat/eph-upi/Collect/v2','','No Refund supported','','','https://indusapi.indusind.com/indusapi/prod/iec/etender/updateTenderId/v1','5','3','2','','','','','','INR','{"live":{"IBL-Client-Id":"764d7dd1ed959c7f5735f294aae9750f","IBL-Client-Secret":"c59862be0b625fc3a8a39b8194724451","CustomerTenderId":"AMPLE", "channelId":"IND", "Account-name":"AMPLE FINLEASE PRIVATE LIMITED", "Account-ifsc":"INDB0000588", "Account-number":"ZAMPLE", "pgMerchantId":"AR7311234313793549"},"test":{"IBL-Client-Id":"b1fd42e9f58618f3a93c059290f1a7b9","IBL-Client-Secret":"6795e1e3ed3546c801f9d857a113f4b9","CustomerTenderId":"LASI1", "channelId":"INT", "Account-name":"AMPLE FINLEASE PRIVATE LIMITED", "Account-ifsc":"INDB0000588", "Account-number":"ZAMPLE", "pgMerchantId":"IDSM306216001027"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"4.50","gst_rate":"18.00","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"3","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":"","bank_salt":""}',0,0,0,'','','','','{"acquirer_name":"IndusInd Collect","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"upiAppListForCollect upiaddress","popup_msg_mobile":"","logo_web":"vimPhonePeGpayPaytm","logo_mobile":"","checkout_label_web":"IndusInd Collect","checkout_label_mobile":""}','',NULL,NULL,NULL),(8,'',0,7199999,'IndusInd IEC',71,'https://indusapi.indusind.com/indusapi/prod/iec/etender/getTenderId/v1','https://indusapiuat.indusind.com/indusapi-np/uat/iec/etender/getTenderId/v1','','No Refund supported','','','https://indusapi.indusind.com/indusapi/prod/iec/etender/updateTenderId/v1','10','3','2','','','','','','INR','{"live":{"IBL-Client-Id":"764d7dd1ed959c7f5735f294aae9750f","IBL-Client-Secret":"c59862be0b625fc3a8a39b8194724451","CustomerTenderId":"AMPLE", "channelId":"IND", "Account-name":"AMPLE FINLEASE PRIVATE LIMITED", "Account-ifsc":"INDB0000588", "Account-number":"ZAMPLE"},"test":{"IBL-Client-Id":"b1fd42e9f58618f3a93c059290f1a7b9","IBL-Client-Secret":"6795e1e3ed3546c801f9d857a113f4b9","CustomerTenderId":"LASI1", "channelId":"INT", "Account-name":"AMPLE FINLEASE PRIVATE LIMITED", "Account-ifsc":"INDB0000588", "Account-number":"ZAMPLE"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"4.50","gst_rate":"18.00","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"3","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":"","bank_salt":""}',0,0,0,'','','','','{"acquirer_name":"IndusInd IEC","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"ift","popup_msg_mobile":"","logo_web":"netBanking","logo_mobile":"","checkout_label_web":"IndusInd IEC","checkout_label_mobile":""}','',NULL,NULL,NULL),(9,'',1,31,'QrCode-step2pay',31,'https://api.step2pay.online/partner/orders','https://api.step2pay.online/partner/orders','','No Refund supported','','','https://webhook.site/b80e0c1c-e244-4db4-a472-910541fdf2f1','10','3','1','','','','','','INR','{"live":{"email":"Carl@step2pay.com","password":"Carl@2023"},"test":{"email":"Carl@step2pay.com","password":"Carl@2023"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"100","max_limit":"500","scrubbed_period":"1","trans_count":"25","tr_scrub_success_count":"10","tr_scrub_failed_count":"15","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"3.80","gst_rate":"18.00","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"10","reserve_delay":"360","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"email":"Carl@step2pay.com","password":"Carl@2023"},"bank_salt":""}',0,1,0,'','','upi,qrcode','','{"acquirer_name":"QrCode-step2pay","skip_checkout_validation":"AddressFalse CardFalse","payment_option_web":"UPI","payment_option_mobile":"","popup_msg_web":"qrcodeadd","popup_msg_mobile":"upiAppListForIntent  appWalletList appIntent_submitMsg","logo_web":"qr_code","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"QrCode","checkout_label_mobile":"UPI"}','',NULL,NULL,NULL),(10,'1111',0,11999,'Binance pay',11,'https://bpay.binanceapi.com/binancepay/openapi/v2/order','https://bpay.binanceapi.com/binancepay/openapi/v2/order','','No Refund supported','','','https://bpay.binanceapi.com/binancepay/openapi/v2/order/query','4','3','1','','No need','','','','USD','{"live": {"merchantId": "372670166","apikey": "dishfccow4jfel4popzeus4osdw7jbozyszn6jlcyzbnja6z4js89dbwt1c1uwdt","secretkey": "9pglflvhhvphs3tdgjskzvxconmjlug5f1apro7tws9rbw8odrelsd3swjnvn376"},"test": {"merchantId": "","apikey": "","secretkey": ""}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.5","settelement_delay":"15","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"11","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"merchantId":"372670166","apikey":"dishfccow4jfel4popzeus4osdw7jbozyszn6jlcyzbnja6z4js89dbwt1c1uwdt","secretkey":"9pglflvhhvphs3tdgjskzvxconmjlug5f1apro7tws9rbw8odrelsd3swjnvn376"},"bank_salt":""}',0,0,0,'','','','','{"acquirer_name":"Binance pay","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"","popup_msg_mobile":"upiAppListForIntent  appWalletList appIntent_submitMsg appIntent_31","logo_web":"qr_code","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"Binance pay","checkout_label_mobile":"UPI"}','',NULL,NULL,NULL),(11,'',2,14,'QrCode-step2pay',14,'https://spectrocoin.com/api/merchant/1','https://spectrocoin.com/api/merchant/1','','No Refund supported','','','No status API','10','3','1','','No need','','','','BTC','{"live": {"merchantId": "b2407ed5-9fe6-4024-b0f6-e975e21a4ab8", "merchantApiId": "737a1064-0182-4ccc-af0f-4615cfca5f0f"},"test": {"merchantId": "b2407ed5-9fe6-4024-b0f6-e975e21a4ab8", "merchantApiId": "737a1064-0182-4ccc-af0f-4615cfca5f0f"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"4.80","gst_rate":"18.00","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"31","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"merchantId":"b2407ed5-9fe6-4024-b0f6-e975e21a4ab8","merchantApiId":"737a1064-0182-4ccc-af0f-4615cfca5f0f"},"bank_salt":""}',0,0,0,'','','upi,qrcode',NULL,'{"acquirer_name":"QrCode-step2pay","skip_checkout_validation":"AddressFalse CardFalse","payment_option_web":"UPI","payment_option_mobile":"","popup_msg_web":"","popup_msg_mobile":"upiAppListForIntent  appWalletList appIntent_submitMsg appIntent_31","logo_web":"qr_code","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"step2pay QR code","checkout_label_mobile":"UPI"}','',NULL,NULL,NULL),(12,'',1,69,'ICICI QR',69,'https://apibankingone.icicibank.com/api/MerchantAPI/UPI/v0/QR3','https://apibankingonesandbox.icicibank.com/api/MerchantAPI/UPI/v0/QR3','','Full Refund only','https://apibankingone.icicibank.com/api/MerchantAPI/UPI/v0/Refund','','https://apibankingone.icicibank.com/api/MerchantAPI/UPI/v0/TransactionStatus3','9','','1','','[host]/api/pay69/status_69.do','','','','INR','{"live":{"apiKey":"w7p24MDT0RjvGdwooQhj6BFArTAuKB78","merchantId":"1013121","terminalId":"5411","merchantAliasName":"Skywalk technologies private limited","merchantAddressLine":"1101-1102 spaze Itech park sector 48","merchantCity":"Gurugram","merchantState":"Haryana","merchantPinCode":"122018","mobileNumber":"8130582345","panNumber":"ABHCS0126Q","emailID":"info@letspe.com","settlementAcSameAsParent":"N","payerAccount":"256202138025","payerIFSC":"INDB0001567","dmo_url":"https://apibankingone.icicibank.com/api/v1/dmo/OnboardRegisterMerchant"},"test":{"apiKey":"HOxY8jy74toUiMe1siO2hl3XDIy7DwOV","merchantId":"409229","terminalId":"5411","payerAccount":"630601124239","payerIFSC":"ICIC0006308"},"vpa":"letspete@icici"}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"4.50","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"vpa":"letspete@icici","merchantId":"1013121"},"bank_salt":""}',0,22,0,'','','upi','upi','{"acquirer_name":"ICICI QR","skip_checkout_validation":"AddressFalse CardFalse LuhnValidationFalse","popup_msg_web":"qrcodeadd upiAppListForCollect","popup_msg_mobile":"upiAppListForIntent appIntent_submitMsg upiAppListForCollect","logo_web":"qr_code","logo_mobile":"","checkout_label_web":"UPI Payment","checkout_label_mobile":"UPI Intent"}','',NULL,NULL,NULL),(13,'',1,691,'ICICI QR',69,'https://apibankingone.icicibank.com/api/MerchantAPI/UPI/v0/CollectPay3','https://apibankingonesandbox.icicibank.com/api/MerchantAPI/UPI/v0/CollectPay3','','Full Refund only','https://apibankingone.icicibank.com/api/MerchantAPI/UPI/v0/Refund','','https://apibankingone.icicibank.com/api/MerchantAPI/UPI/v0/TransactionStatus3','9','','1','','','','','','INR','{"live":{"apiKey":"w7p24MDT0RjvGdwooQhj6BFArTAuKB78","merchantId":"1013121","terminalId":"5411","merchantAliasName":"Skywalk technologies private limited", "merchantAddressLine":"1101-1102 spaze Itech park sector 48", "merchantCity":"Gurugram", "merchantState":"Haryana", "merchantPinCode":"122018", "mobileNumber":"8130582345", "panNumber":"ABHCS0126Q", "emailID":"info@letspe.com", "settlementAcSameAsParent":"N", "payerAccount":"256202138025","payerIFSC":"INDB0001567","dmo_url":"https://apibankingone.icicibank.com/api/v1/dmo/OnboardRegisterMerchant"},"test":{"apiKey":"HOxY8jy74toUiMe1siO2hl3XDIy7DwOV","merchantId":"409229","terminalId":"5411","payerAccount":"630601124239","payerIFSC":"ICIC0006308"},"vpa":"letspete@icici"}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"4.50","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":"","bank_salt":""}',0,2,0,'','','','','{"acquirer_name":"ICICI QR","skip_checkout_validation":"AddressFalse CardFalse LuhnValidationFalse","popup_msg_web":"upiAppListForCollect","popup_msg_mobile":"upiAppListForIntent appIntent_submitMsg","logo_web":"vimPhonePeGpayPaytm","logo_mobile":"","checkout_label_web":"ICICI Collect","checkout_label_mobile":""}','',NULL,NULL,NULL),(14,'',1,35,'QrCode-cashnclick',35,'http://103.205.64.251:8080/clickncashapi/rest/auth','http://103.205.64.251:8080/clickncashapi/rest/auth','','No Refund supported','','gw.gatewayeast.com/payin/pay35/payin_docs_new_1.docx','http://103.205.64.251:8080/clickncashapi/rest/auth','10','3','1','','162.222.227.163 yes need to whitelist Ip address','162.222.227.163','','qrcodeadd qracq_781 for qr will use in Acquirer Redirect Popup Msg [web] field','INR','{"live":{"username":"Ashu","password":"12345678"},"test":{"username":"Ashu","password":"12345678"}}','{"hard_code_url":"API_TEST/NewIntegration.php","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"3.80","gst_rate":"18.00","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"32","reserve_rate":"0.00","reserve_delay":"0.00","settled_amt":"","charge_back_fee_1":"0.00","charge_back_fee_2":"0.00","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"username":"Ashu","password":"12345678"},"bank_salt":""}',0,4,0,'','','','','{"acquirer_name":"QrCode-cashnclick","skip_checkout_validation":"AddressFalse CardFalse","payment_option_web":"intent payment","payment_option_mobile":"","popup_msg_web":"qrcodeadd qracq_781","popup_msg_mobile":"upiAppListForIntent","logo_web":"qr_code","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"35 QrCode","checkout_label_mobile":"35 UPI Intent"}','',NULL,NULL,NULL),(15,'',1,371,'UPI Collect-Paytm',37,'https://indusapi.indusind.com/indusapi/prod/eph-upi/Collect/v2','https://indusapiuat.indusind.com/indusapi-np/uat/eph-upi/Collect/v2','','No Refund supported','','','https://indusapi.indusind.com/indusapi/prod/iec/etender/updateTenderId/v1','5','3','1','','No need','','','','INR','{"live":{"IBL-Client-Id":"764d7dd1ed959c7f5735f294aae9750f","IBL-Client-Secret":"c59862be0b625fc3a8a39b8194724451","CustomerTenderId":"AMPLE","channelId":"IND","Account-name":"AMPLE FINLEASE PRIVATE LIMITED","Account-ifsc":"INDB0000588","Account-number":"ZAMPLE","pgMerchantId":"AR7311234313793549"},"test":{"IBL-Client-Id":"b1fd42e9f58618f3a93c059290f1a7b9","IBL-Client-Secret":"6795e1e3ed3546c801f9d857a113f4b9","CustomerTenderId":"LASI1","channelId":"INT","Account-name":"AMPLE FINLEASE PRIVATE LIMITED","Account-ifsc":"INDB0000588","Account-number":"ZAMPLE","pgMerchantId":"IDSM306216001027"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"3.80","gst_rate":"18","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"32","reserve_rate":"0.00","reserve_delay":"0.00","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"IBL-Client-Id":"764d7dd1ed959c7f5735f294aae9750f","IBL-Client-Secret":"c59862be0b625fc3a8a39b8194724451","CustomerTenderId":"AMPLE","channelId":"IND","Account-name":"AMPLE FINLEASE PRIVATE LIMITED","Account-ifsc":"INDB0000588","Account-number":"ZAMPLE","pgMerchantId":"AR7311234313793549"},"bank_salt":""}',0,8,0,'','','qrcode','upi','{"acquirer_name":"UPI Collect-Paytm","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"upiAppListForCollect","popup_msg_mobile":"upiAppListForCollect","logo_web":"vimPhonePeGpayPaytm","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"UPI Collect","checkout_label_mobile":"UPI Intent"}','',NULL,NULL,NULL),(16,'',1,361,'QrCode-IserveU',36,'https://apiprod.iserveu.tech/production/api/upi/initiate-dynamic-transaction','https://apidev.iserveu.online/staging/api/upi/initiate-dynamic-transaction','','No Refund supported','','','https://apiprod.iserveu.tech/production//statuscheck/txnreport','10','3','1','','','','','qrcodeadd qracq_781 for qr will use in Acquirer Redirect Popup Msg [web] field','INR','{"live":{"client_id":"dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez","client_secret":"I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7hBX", "payerAccount":"","payerIFSC":"","payerBank":"","requestingUserName": ""},"test":{"client_id":"EMI8PIj5Esi7T5Q4LVH5X5LHe5uNwqIp0BKdL3sCl8WHlAAb","client_secret":"Q4jAlwLuSUcNNE87D2W3b8PQHv25aKxiYrotlXcxcyX6AOx8BdcLprJCqFGHGVXG", "payerAccount":"650234737984399042","payerIFSC":"NMXB4284485","payerBank":"SBI","requestingUserName": "TestMerchant"},"vpa":"iserveupvtltd@indus"}','{"hard_code_url":"API_TEST/NewIntegration.php","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"100000","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"3.80","gst_rate":"18","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"32","reserve_rate":"0.00","reserve_delay":"0.00","settled_amt":"","charge_back_fee_1":"0.00","charge_back_fee_2":"0.00","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"client_id":"dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez","client_secret":"I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7hBX","payerAccount":"","payerIFSC":"","payerBank":"","requestingUserName":""},"bank_salt":""}',0,3,0,'','','qrcode','','{"acquirer_name":"QrCode-IserveU","skip_checkout_validation":"AddressFalse CardFalse","payment_option_web":"intent payment","payment_option_mobile":"","popup_msg_web":"qrcodeadd","popup_msg_mobile":"upiAppListForIntent appWalletList appIntent_submitMsg","logo_web":"qr_code","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"QrCode","checkout_label_mobile":"UPI"}','',NULL,NULL,NULL),(17,'',1,36,'UPI-Iserve U',36,'https://apiprod.iserveu.tech/production/api/upi/initiate-dynamic-transaction','https://apidev.iserveu.online/staging/api/upi/initiate-dynamic-transaction','','Full Refund only','','','https://apiprod.iserveu.tech/production//statuscheck/txnreport','5','3','1','','','','','','INR','{"live":{"client_id":"dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez","client_secret":"I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7hBX", "payerAccount":"","payerIFSC":"","payerBank":"","requestingUserName": "rariotest"},"test":{"client_id":"EMI8PIj5Esi7T5Q4LVH5X5LHe5uNwqIp0BKdL3sCl8WHlAAb","client_secret":"Q4jAlwLuSUcNNE87D2W3b8PQHv25aKxiYrotlXcxcyX6AOx8BdcLprJCqFGHGVXG", "payerAccount":"650234737984399042","payerIFSC":"NMXB4284485","payerBank":"SBI","requestingUserName": "TestMerchant"},"vpa":"iserveupvtltd@indus"}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"4.50","gst_rate":"18","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"3","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"client_id":"dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez","client_secret":"I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7hBX","payerAccount":"","payerIFSC":"","payerBank":"","requestingUserName":"rariotest"},"bank_salt":""}',0,4,0,'','','','','{"acquirer_name":"UPI-Iserve U","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"upiAppListForCollect appWalletList upiaddress","popup_msg_mobile":"","logo_web":"vimPhonePeGpayPaytm","logo_mobile":"","checkout_label_web":"UPI Payment","checkout_label_mobile":""}','',NULL,NULL,NULL),(18,'',1,72,'UPI-Iserve U',72,'https://apiprod.iserveu.tech/production/api/upi/initiate-dynamic-transaction','https://apidev.iserveu.online/staging/api/upi/initiate-dynamic-transaction','','Full Refund only','','','https://apiprod.iserveu.tech/production//statuscheck/txnreport','9','3','1','','','','','','INR','{"live":{"client_id":"dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez","client_secret":"I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7hBX", "payerAccount":"","payerIFSC":"","payerBank":"","requestingUserName": "rariotest"},"test":{"client_id":"EMI8PIj5Esi7T5Q4LVH5X5LHe5uNwqIp0BKdL3sCl8WHlAAb","client_secret":"Q4jAlwLuSUcNNE87D2W3b8PQHv25aKxiYrotlXcxcyX6AOx8BdcLprJCqFGHGVXG", "payerAccount":"650234737984399042","payerIFSC":"NMXB4284485","payerBank":"SBI","requestingUserName": "TestMerchant"},"vpa":"iserveupvtltd@indus"}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"4.50","gst_rate":"18","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"3","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"client_id":"dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez","client_secret":"I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7hBX","payerAccount":"","payerIFSC":"","payerBank":"","requestingUserName":"rariotest"},"bank_salt":""}',0,1,0,'','','upi','upi','{"acquirer_name":"UPI-Iserve U","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"qrcodeadd upiAppListForCollect submitButtonHide","popup_msg_mobile":"upiAppListForIntentArray upiAppListForCollect appIntent_submitMsg submitButtonHide","logo_web":"vimPhonePeGpayPaytm qr_code","logo_mobile":"","checkout_label_web":"UPI Payment","checkout_label_mobile":"UPI Payment"}','',NULL,NULL,NULL),(19,'',1,382,'QrCode-payU',38,'https://secure.payu.in','https://test.payu.in','','No Refund supported','','','No status API','9','3','1','','','','','Acquirer Redirect Popup Msg [web] : qrcodeadd upiAppListForCollect , Acquirer Redirect Popup Msg [mobile] : upiAppListForIntent upiAppListForCollect appIntent_submitMsg, UPI Payment for QR, Intent & Collect','INR','{"live":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"test":{"merchantKey":"QyT13U","saltKey":"UnJ0FGO0kt3dUgnHo9Xgwi0lpipBV0hB"}}','{"hard_code_url":"API_TEST/NewIntegration.php","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"100000","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"3.80","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"32","reserve_rate":"0.00","reserve_delay":"0.00","settled_amt":"","charge_back_fee_1":"0.00","charge_back_fee_2":"0.00","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"bank_salt":""}',0,3,0,'','','upi','upi','{"acquirer_name":"QrCode-payU","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"qrcodeadd upiAppListForCollect upiAppListForIntentArray","popup_msg_mobile":"upiAppListForIntentArray upiAppListForCollect appIntent_submitMsg","logo_web":"vimPhonePeGpayPaytm qr_code","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"UPI Payment","checkout_label_mobile":""}','',NULL,NULL,NULL),(20,'',1,383,'payU-ewallets',38,'https://secure.payu.in','https://test.payu.in','','No Refund supported','','','https://info.payu.in/merchant/postservice.php?form=2','4','3','1','','No need','','','','INR','{"live":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"test":{"merchantKey":"QyT13U","saltKey":"UnJ0FGO0kt3dUgnHo9Xgwi0lpipBV0hB"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"3.80","gst_rate":"18","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"32","reserve_rate":"0.00","reserve_delay":"0.00","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"bank_salt":""}',0,0,0,'','','','','{"acquirer_name":"payU-ewallets","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"payUwalletLogoX payUwalletListX walletLogo","popup_msg_mobile":"","logo_web":"indiaWallets","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"ewallets","checkout_label_mobile":"UPI"}','',NULL,NULL,NULL),(22,'',1,381,'payU',38,'https://secure.payu.in','https://test.payu.in','','No Refund supported','','','No status API','6','3','1','','No need','','','','INR','{"live":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"test":{"merchantKey":"QyT13U","saltKey":"UnJ0FGO0kt3dUgnHo9Xgwi0lpipBV0hB"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"3.80","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"32","reserve_rate":"0.00","reserve_delay":"0.00","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"bank_salt":""}',0,0,0,'','','','','{"acquirer_name":"payU","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"PaytmBankLogo allPayPayuBankingList ajax","popup_msg_mobile":"","logo_web":"netBanking","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"PayU","checkout_label_mobile":"netbanking"}','',NULL,NULL,NULL),(23,'',1,38,'PayU Card Payment',38,'https://secure.payu.in','https://test.payu.in','','No Refund supported','','','No status API','3','3','1','','','','INR','This is evok ','INR','{"live":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"test":{"merchantKey":"QyT13U","saltKey":"UnJ0FGO0kt3dUgnHo9Xgwi0lpipBV0hB"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"2.8","settelement_delay":"1","txn_fee_success":"0.00","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"0.00","reserve_delay":"90","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"200","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"bank_salt":"","notification_to_005":"005"}',200,1,0,'','','amex,mastercard,visa','','{"acquirer_name":"PayU Card Payment","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"","popup_msg_mobile":"","logo_web":"CardIcon","logo_mobile":"","checkout_label_web":"Card Payment","checkout_label_mobile":""}','dev@bigit.io',NULL,NULL,NULL),(24,'',1,711,'ICE Indus Collect',71,'https://indusapi.indusind.com/indusapi/prod/eph-upi/Collect/v2','https://indusapiuat.indusind.com/indusapi-np/uat/eph-upi/Collect/v2','','No Refund supported','','','https://indusapi.indusind.com/indusapi/prod/iec/etender/updateTenderId/v1','5','3','2','','','','INR','Indusind bank for ICE (Indian Customs Electronic Gateway)','INR','{"live":{"IBL-Client-Id":"764d7dd1ed959c7f5735f294aae9750f","IBL-Client-Secret":"c59862be0b625fc3a8a39b8194724451","CustomerTenderId":"AMPLE", "channelId":"IND", "Account-name":"AMPLE FINLEASE PRIVATE LIMITED", "Account-ifsc":"INDB0000588", "Account-number":"ZAMPLE", "pgMerchantId":"AR7311234313793549"},"test":{"IBL-Client-Id":"b1fd42e9f58618f3a93c059290f1a7b9","IBL-Client-Secret":"6795e1e3ed3546c801f9d857a113f4b9","CustomerTenderId":"LASI1", "channelId":"INT", "Account-name":"AMPLE FINLEASE PRIVATE LIMITED", "Account-ifsc":"INDB0000588", "Account-number":"ZAMPLE", "pgMerchantId":"IDSM306216001027"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"2.8","gst_rate":"18","settelement_delay":"1","txn_fee_success":"0.00","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"0.00","reserve_delay":"90","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"200","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":"","bank_salt":"","notification_to_005":"005"}',200,5,0,'','','','','{"acquirer_name":"ICE Indus Collect","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"upiAppListForCollect appWalletList upiaddress","popup_msg_mobile":"","logo_web":"CardIcon","logo_mobile":"","checkout_label_web":"Indus Collect","checkout_label_mobile":""}','dev@bigit.io',NULL,NULL,NULL),(25,'',1,71,'BT Indus',71,'https://indusapi.indusind.com/indusapi/prod/iec/etender/getTenderId/v1','https://indusapiuat.indusind.com/indusapi-np/uat/iec/etender/getTenderId/v1','','No Refund supported','','','https://indusapi.indusind.com/indusapi/prod/iec/etender/updateTenderId/v1','11','3','2','','','','INR','Indusind Bank Transfer for ICE (Indian Customs Electronic Gateway)','INR','{"live":{"IBL-Client-Id":"764d7dd1ed959c7f5735f294aae9750f","IBL-Client-Secret":"c59862be0b625fc3a8a39b8194724451","CustomerTenderId":"AMPLE", "channelId":"IND", "Account-name":"AMPLE FINLEASE PRIVATE LIMITED", "Account-ifsc":"INDB0000588", "Account-number":"ZAMPLE"},"test":{"IBL-Client-Id":"b1fd42e9f58618f3a93c059290f1a7b9","IBL-Client-Secret":"6795e1e3ed3546c801f9d857a113f4b9","CustomerTenderId":"LASI1", "channelId":"INT", "Account-name":"AMPLE FINLEASE PRIVATE LIMITED", "Account-ifsc":"INDB0000588", "Account-number":"ZAMPLE"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"2.8","gst_rate":"18","settelement_delay":"1","txn_fee_success":"0.00","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"0.00","reserve_delay":"90","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"200","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":"","bank_salt":"","notification_to_005":"005"}',200,5,0,'','','amex,mastercard,visa,jcb,discover,diners','','{"acquirer_name":"BT Indus","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"IndiaBankTransfer submitButtonHideX","popup_msg_mobile":"","logo_web":"CardIcon","logo_mobile":"","checkout_label_web":"BT - Bank Transfer","checkout_label_mobile":""}','dev@bigit.io',NULL,NULL,NULL),(26,'1111',1,44,'WARAL',44,'https://api.flutterwave.com','https://api.flutterwave.com','','Full & Partial Both','','','https://api.flutterwave.com/v3/transactions','3','1','1','','','','','This is evok ','USD','{"live":{"PublicKey":"FLWPUBK-4d50c155849bbe91ac231579ce5c6bad-X","SecretKey":"FLWSECK-30f223280fb89be1761119f9fc7c283b-18a4f33efe5vt-X","EncryptionKey":"30f223280fb8f3c08579ca07"}, "test":{"PublicKey":"FLWPUBK_TEST-bd62ff4faa21b7335ba1f5f59958ed1e-X","SecretKey":"FLWSECK_TEST-d81863a6c7bef918e1e2ca3477552522-X","EncryptionKey":"FLWSECK_TESTf387ba254903"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"5.50","gst_rate":"0.00","settelement_delay":"15","txn_fee_success":"0.80","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"0.00","reserve_delay":"90","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"200","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"PublicKey":"FLWPUBK-4d50c155849bbe91ac231579ce5c6bad-X","SecretKey":"FLWSECK-30f223280fb89be1761119f9fc7c283b-18a4f33efe5vt-X","EncryptionKey":"30f223280fb8f3c08579ca07"},"bank_salt":"","notification_to_005":"005"}',200,5,2880,'','','amex,mastercard,visa,jcb,discover,diners','','{"acquirer_name":"WARAL","skip_checkout_validation":"","popup_msg_web":"CardIcon","popup_msg_mobile":"","logo_web":"CardIcon","logo_mobile":"","checkout_label_web":"Visa, MasterCard - 3D Secure","checkout_label_mobile":""}','dev@bigit.io',NULL,NULL,NULL),(27,'',1,46,'Finvert',46,'https://portal.finvert.io/api/transaction','https://portal.finvert.io/api/test/transaction','https://portal.finvert.io/wl/rp/login','Full & Partial Both','https://portal.finvert.io/api/refund',' https://portal.finvert.io/api-document','https://portal.finvert.io/api/get/transaction','3','1','1','','13.233.167.170,13.232.229.139','','USD','we need to configure IP in dashboard and webhook will pass in parameter','USD','{"live":{"apiKey":"254|JvQ42xbfGuAQ5wcCOKcHX24hHjpJ7w68nORgMhVG"}, "test":{"apiKey":"254|JvQ42xbfGuAQ5wcCOKcHX24hHjpJ7w68nORgMhVG"}}','{"hard_code_url":"api-test/deepti/46_finvert/finvert.php","hard_code_status_url":"api-test/deepti/46_finvert/finverStatus.php","hard_code_live_status_url":"payin/pay46/status_46.do","hard_code_refund_url":"api-test/deepti/46_finvert/finvertRefund.php","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"5.50","gst_rate":"18.00","settelement_delay":"15","txn_fee_success":"0.80","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"0.00","reserve_delay":"90","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"200","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"apiKey":"254|JvQ42xbfGuAQ5wcCOKcHX24hHjpJ7w68nORgMhVG"},"bank_salt":"","notification_to_005":"005"}',200,5,2880,'','','mastercard,visa','','{"acquirer_name":"Finvert","skip_checkout_validation":"","popup_msg_web":"redirect","popup_msg_mobile":"redirect","logo_web":"CardIcon","logo_mobile":"","checkout_label_web":"Visa, MasterCard - 3D Secure","checkout_label_mobile":""}','dev@bigit.io',NULL,NULL,NULL),(28,'',1,782,'Evok',78,'https://merchantprod.timepayonline.com/evok/cm/v2','https://merchantuat.timepayonline.com/evok/cm/v2','india123,reset123','Full Refund only','https://merchantprod.timepayonline.com/evok/cm/v2/refund','https://merchantprod.timepayonline.com/developers','https://merchantprod.timepayonline.com/evok/cm/v2/status','9','3','1','RBI','122.221.33.334','','INR','This is evok ','INR','{"live":{"source":"SKYWA0700","extTransactionId":"SKYWA","terminalId":"SKYWA-0700","sid":"SKYWA-0700","Encryption_key":"9f8fdc5be230f7130f44ae0869e97b5a","key":"48a431d06097db42696ba30043d15f41","Checksum_key":"19d81ced01ebad333381df5bdbb277a5"},"test":{"source":"SKYWA0700","extTransactionId":"SKYWA","terminalId":"SKYWA-0700","sid":"SKYWA-0700","Encryption_key":"9f8fdc5be230f7130f44ae0869e97b5a","key":"48a431d06097db42696ba30043d15f41","Checksum_key":"19d81ced01ebad333381df5bdbb277a5"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"2.8","gst_rate":"18.00","settelement_delay":"1","txn_fee_success":"0.00","txn_fee_failed":"0.00","acquirer_display_order":"4","reserve_rate":"0.00","reserve_delay":"90","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"200","monthly_fee":"","refund_fee":"10","return_wire_fee":"","acquirer_processing_json":{"sid":"SKYWA-0700"},"bank_salt":"","notification_to_005":"005"}',200,2,5,'["AO5","BY","BW","BF","BI","CM","CF","CG","TD","CI","EG","GA","GM","GH","ID","IR","IQ","KE","KP","LS","LR","LY","MW","MY","ML","MR","MA","NE","NG","PS","RW","SL","SO","SD","SZ","SY","TG","UG","ZA","ZM","ZW"]','','','','{"acquirer_name":"Evok","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"qrcodeadd upiAppListForCollect","popup_msg_mobile":"upiAppListForIntentArray appIntent_submitMsg upiAppListForCollect","logo_web":"vimPhonePeGpayPaytm qr_code","logo_mobile":"","checkout_label_web":"UPI Payment","checkout_label_mobile":"UPI Payment"}','dev@bigit.io',NULL,NULL,NULL),(29,'',1,42,'Kapopay CC',42,'https://infotrend.kapopay.com/process/payment/','https://sandbox.kapopay.com/process/payment/','https://portal.finvert.io/wl/rp/login','Full Refund only','https://infotrend.kapopay.com/process/refund/','https://sandbox.kapopay.com/documentation/','https://infotrend.kapopay.com/process/status/','3','1','1','','13.233.167.170,13.232.229.139','','USD','we need to configure IP in dashboard and webhook will pass in parameter','USD','{"live":{"AccountId":" 4017","ShopId":"50022","Key":"1adf1158f43a4e9cf56116176a02afe5","Pass":"64df892319fe7"},"test":{"AccountId":" 2022","ShopId":"30022","Key":"04b42a524af9cb19ca9bbae0a56f7db9","Pass":"64bbf2461a70a"}}','{"hard_code_url":"payin/pay42/kapopay/testCard.php","hard_code_status_url":"payin/pay42/kapopay/Getstatustest.php","hard_code_live_status_url":"payin/pay46/status_46.do","hard_code_refund_url":"api-test/deepti/46_finvert/finvertRefund.php","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.50","gst_rate":"0.00","settelement_delay":"18","txn_fee_success":"0.80","txn_fee_failed":"0.00","acquirer_display_order":"42","reserve_rate":"10","reserve_delay":"210","settled_amt":"","charge_back_fee_1":"55","charge_back_fee_2":"70","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"AccountId":" 4017","ShopId":"50022","Key":"1adf1158f43a4e9cf56116176a02afe5","Pass":"64df892319fe7"},"bank_salt":"","notification_to_005":"005"}',200,5,2880,'','','mastercard,visa','','{"acquirer_name":"Kapopay CC","skip_checkout_validation":"","popup_msg_web":"","popup_msg_mobile":"","logo_web":"cardIcon","logo_mobile":"","checkout_label_web":"Visa, MasterCard - 3D Secure","checkout_label_mobile":""}','dev@bigit.io',NULL,NULL,NULL),(30,'1111',1,11,'BNPay',11,'https://bpay.binanceapi.com/binancepay/openapi/v2/order','https://bpay.binanceapi.com/binancepay/openapi/v2/order','','Full Refund only','https://bpay.binanceapi.com/binancepay/openapi/order/refund','','https://bpay.binanceapi.com/binancepay/openapi/v2/order/query','4','3','1','','','','','','USD','{"live": {"merchantId": "372670166","apikey": "dishfccow4jfel4popzeus4osdw7jbozyszn6jlcyzbnja6z4js89dbwt1c1uwdt","secretkey": "9pglflvhhvphs3tdgjskzvxconmjlug5f1apro7tws9rbw8odrelsd3swjnvn376"},"test": {"merchantId": "","apikey": "","secretkey": ""}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.50","gst_rate":"0.00","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"11","reserve_rate":"0.00","reserve_delay":"0.00","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"merchantId":"372670166","apikey":"dishfccow4jfel4popzeus4osdw7jbozyszn6jlcyzbnja6z4js89dbwt1c1uwdt","secretkey":"9pglflvhhvphs3tdgjskzvxconmjlug5f1apro7tws9rbw8odrelsd3swjnvn376"},"bank_salt":""}',0,60,0,'','','Binance Pay','','{"acquirer_name":"BNPay","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"","popup_msg_mobile":"","logo_web":"binance","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"Pay Via Binance Wallet","checkout_label_mobile":""}','',NULL,NULL,NULL),(32,'1111',1,13,'Coinbase',13,'https://api.commerce.coinbase.com/charges ','https://api.commerce.coinbase.com/charges ','','No Refund supported','','','https://api.commerce.coinbase.com/charges ','4','1','1','','','','','','USD','{"live": {"apikey": "17a54646-a17c-4e2d-8333-ad542a71f7aa"},"test": {"apikey": ""}} ','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"5000","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.50","gst_rate":"0.00","settelement_delay":"7","txn_fee_success":"0.03","txn_fee_failed":"0.00","acquirer_display_order":"7","reserve_rate":"10%","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"0.00","charge_back_fee_2":"0.00","charge_back_fee_3":"0.00","cbk1":"0.00","monthly_fee":"","refund_fee":"0.00","return_wire_fee":"","acquirer_processing_json":{"apikey":"17a54646-a17c-4e2d-8333-ad542a71f7aa"},"bank_salt":""}',0,60,0,'','','Coinsbase','','{"acquirer_name":"Coinbase","skip_checkout_validation":"AddresFalse CardFalse","popup_msg_web":"","popup_msg_mobile":"","logo_web":"coinbase","logo_mobile":"","checkout_label_web":"Coinbase Wallet & Crypto Payments","checkout_label_mobile":""}','',NULL,NULL,NULL),(33,'1111',1,12,'Advcash',12,'https://wallet.advcash.com/sci/ ','https://wallet.advcash.com/sci/ ','','No Refund supported','','','NA','4','','1','','','','','','USD','{"live":{"sci_name":"SCI_i15gw_2023","sign_key":"2c8dc6bccd04b1ca81fd2ce69898d50d9a42a303bc53021a2466b6e6b51905cc","account_email":"vik.mno@gmail.com","api_name":"API_i15gw_2023","api_pass":"India@1230"},"test":{"sci_name":"","sign_key":"","account_email":"","api_name":"","api_pass":""}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"5000","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.50","settelement_delay":"7","txn_fee_success":"0.03","txn_fee_failed":"0.00","acquirer_display_order":"12","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"0.00","charge_back_fee_2":"0.00","charge_back_fee_3":"0.00","cbk1":"0.00","monthly_fee":"","refund_fee":"0.00","return_wire_fee":"","acquirer_processing_json":{"sci_name":"SCI_i15gw_2023","sign_key":"2c8dc6bccd04b1ca81fd2ce69898d50d9a42a303bc53021a2466b6e6b51905cc","account_email":"vik.mno@gmail.com"},"bank_salt":""}',0,0,0,'','','AdvCash','','{"acquirer_name":"Advcash","skip_checkout_validation":"AddresFalse CardFalse","popup_msg_web":"upiWalletIndiList","popup_msg_mobile":"","logo_web":"indiaWalletes","logo_mobile":"","checkout_label_web":"AdvCash eWallet (Choose this option if you already have AdvCash Wallet)","checkout_label_mobile":""}','',NULL,NULL,NULL),(34,'',1,122,'TetherCoin',12299,'NA','NA','','No Refund supported','','','NA','4','','1','','','','','','USD','{"coinName":"USDT","coinTitle":"TetherCoin","tetherTransportProtocol":"ETHEREUM","netWorkType":"TRON / TRC20 / TRX", "sci_name":"SCI_i15gw_2023","sign_key":"2c8dc6bccd04b1ca81fd2ce69898d50d9a42a303bc53021a2466b6e6b51905cc","account_email":"vik.mno@gmail.com","api_name":"API_i15gw_2023","api_pass":"India@1230"}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"5000","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.50","settelement_delay":"7","txn_fee_success":"0.03","txn_fee_failed":"0.00","acquirer_display_order":"12","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"0.00","charge_back_fee_2":"0.00","charge_back_fee_3":"0.00","cbk1":"0.00","monthly_fee":"","refund_fee":"0.00","return_wire_fee":"","acquirer_processing_json":"","bank_salt":""}',0,10,0,'','','TetherCoins','','{"acquirer_name":"TetherCoin","skip_checkout_validation":"AddresFalse CardFalse","popup_msg_web":"scanqr tetherCoins","popup_msg_mobile":"","logo_web":"indiaWalletes","logo_mobile":"","checkout_label_web":"TetherCoin (Min Payment 40 USD - SCAN QR Code)","checkout_label_mobile":""}','',NULL,NULL,NULL),(35,'',1,121,'BtcAdv',12199,'https://wallet.advcash.com/sci/','https://wallet.advcash.com/sci/','','No Refund supported','','','NA','4','','1','','','','','','USD','{"live":{"ac_account_email":"vik.mno@gmail.com","ac_sci_name": "SCI_i15gw_2023"},"test":{"ac_account_email":"vik.mno@gmail.com","ac_sci_name": "SCI_i15gw_2023"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"5000","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.50","settelement_delay":"7","txn_fee_success":"0.03","txn_fee_failed":"0.00","acquirer_display_order":"12","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"0.00","charge_back_fee_2":"0.00","charge_back_fee_3":"0.00","cbk1":"0.00","monthly_fee":"","refund_fee":"0.00","return_wire_fee":"","acquirer_processing_json":{"ac_account_email":"vik.mno@gmail.com","ac_sci_name":"SCI_i15gw_2023"},"bank_salt":""}',0,0,0,'','','AdvCash','','{"acquirer_name":"BtcAdv","skip_checkout_validation":"AddresFalse CardFalse","popup_msg_web":"upiWalletIndiList","popup_msg_mobile":"","logo_web":"advcash","logo_mobile":"","checkout_label_web":"BitCoin (Min Payment 40 USD - SCAN QR Code)","checkout_label_mobile":""}','',NULL,NULL,NULL),(36,'',1,47,'ZOOK',47,'https://zookwallet.com/en/purchase/link','https://zookwallet.com/en/purchase/link','','Full Refund only','https://zookwallet.com/api/money-transfer/send-money',' https://portal.finvert.io/api-document','https://zookwallet.com/en/request/status','4','1','1','','No need','','INR','','INR','{"live":{"merchant_key":"$2y$10$IUqBU18PFNw1xC4/jxzWmOVGkNrYlD62E.r2ZfeCVtnckZNUZp9ti"}, "test":{"merchant_key":"$2y$10$IUqBU18PFNw1xC4/jxzWmOVGkNrYlD62E.r2ZfeCVtnckZNUZp9ti"}}','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"5000","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.50","settelement_delay":"7","txn_fee_success":"0.03","txn_fee_failed":"0.00","acquirer_display_order":"12","reserve_rate":"10","reserve_delay":"180","settled_amt":"","charge_back_fee_1":"55","charge_back_fee_2":"70","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"16","return_wire_fee":"","acquirer_processing_json":{"merchant_key":"$2y$10$IUqBU18PFNw1xC4/jxzWmOVGkNrYlD62E.r2ZfeCVtnckZNUZp9ti"},"bank_salt":""}',0,5,2880,'','','qrcode','','{"acquirer_name":"ZOOK","skip_checkout_validation":"AddresFalse CardFalse","popup_msg_web":"redirect","popup_msg_mobile":"","logo_web":"indiaWallets","logo_mobile":"","checkout_label_web":"UPI Payments","checkout_label_mobile":""}','',NULL,NULL,NULL),(38,'',1,483,'Easebuzz CC',48,'https://pay.easebuzz.in/','https://pay.easebuzz.in/','https://portal.finvert.io/wl/rp/login','Full Refund only','https://dashboard.easebuzz.in/transaction/v2/refund','https://docs.easebuzz.in/docs/payment-gateway/8ec545c331e6f-initiate-payment-api','https://dashboard.easebuzz.in/transaction/v1/retrieve','3','1','1','','https://uat-git.web1.one/payin/pay48/webhookhandler_48','','USD','','USD','{"live":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"test":{"salt":"DAH88E3UWQ","key":"2PBP7IABZ2"}}','{"hard_code_url":"payin/pay48/credit.php","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.50","settelement_delay":"18","txn_fee_success":"0.80","txn_fee_failed":"0.00","acquirer_display_order":"48","reserve_rate":"10","reserve_delay":"210","settled_amt":"","charge_back_fee_1":"55","charge_back_fee_2":"70","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"bank_salt":"","notification_to_005":"005"}',200,5,2880,'','','amex,mastercard,visa,jcb,discover,diners','','{"acquirer_name":"Easebuzz CC","skip_checkout_validation":"","popup_msg_web":"","popup_msg_mobile":"","logo_web":"cardIcon","logo_mobile":"","checkout_label_web":"Pay with 3D Credit Card","checkout_label_mobile":""}','dev@bigit.io',NULL,NULL,NULL),(39,'',1,482,'Easebuzz',48,'https://pay.easebuzz.in/','https://pay.easebuzz.in/','','No Refund supported','','','https://dashboard.easebuzz.in/transaction/v1/retrieve','10','3','1','','webhook will be whitelisted','','','qrcodeadd qracq_35 for qr will use in Acquirer Redirect Popup Msg [web] field','INR','{"live":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"test":{"salt":"DAH88E3UWQ","key":"2PBP7IABZ2"}}','{"hard_code_url":"API_TEST/NewIntegration.php","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"50000","scrubbed_period":"1","trans_count":"25","tr_scrub_success_count":"10","tr_scrub_failed_count":"15","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"3.80","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"48","reserve_rate":"10","reserve_delay":"360","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"bank_salt":""}',0,5,0,'','','qrcode','','{"acquirer_name":"Easebuzz","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"qrcodeadd","popup_msg_mobile":"","logo_web":"qr_code","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":" Easebuzz QrCode","checkout_label_mobile":" Easebuzz QrCode"}','',NULL,NULL,NULL),(40,'1111',1,481,'Easebuzz',48,'https://pay.easebuzz.in/','https://pay.easebuzz.in/','','No Refund supported','','','https://dashboard.easebuzz.in/transaction/v1/retrieve','6','3','1','','No need','','','will send 50 rs for netbanking minimum','INR','{"live":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"test":{"salt":"DAH88E3UWQ","key":"2PBP7IABZ2"}}','{"hard_code_url":"payin/pay48/p.php","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"50","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"3.80","gst_rate":"18.00","settelement_delay":"1","txn_fee_success":"0.08","txn_fee_failed":"0.00","acquirer_display_order":"48","reserve_rate":"0.00","reserve_delay":"0.00","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"bank_salt":""}',0,0,0,'','','mastercard,visa','','{"acquirer_name":"Easebuzz","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"EasebuzzBankingList PaytmBankLogo ","popup_msg_mobile":"","logo_web":"netBanking","logo_mobile":"vimPhonePeGpayPaytm","checkout_label_web":"Easebuzz netbanking","checkout_label_mobile":"netbanking"}','',NULL,NULL,NULL),(41,'1111',1,48,'Easebuzz',48,'https://pay.easebuzz.in/','https://pay.easebuzz.in','india123,reset123','No Refund supported','','https://docs.easebuzz.in/docs/payment-gateway/m17o0creehcto-seamless-integration  https://docs.easebuzz.in/docs/payment-gateway/8ec545c331e6f-initiate-payment-api','https://dashboard.easebuzz.in/transaction/v1/retrieve','5','3','1','RBI','https://uat-git.web1.one/payin/pay48/webhookhandler_48','','INR','easebuzz upi collect payment method','INR','{"live":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"test":{"salt":"DAH88E3UWQ","key":"2PBP7IABZ2"}}','{"hard_code_url":"payin/pay48/c.php","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"INR","mdr_rate":"2.8","settelement_delay":"1","txn_fee_success":"0.00","txn_fee_failed":"0.00","acquirer_display_order":"48","reserve_rate":"0.00","reserve_delay":"90","settled_amt":"","charge_back_fee_1":"15","charge_back_fee_2":"45","charge_back_fee_3":"100","cbk1":"200","monthly_fee":"","refund_fee":"10","return_wire_fee":"","acquirer_processing_json":"","bank_salt":"","notification_to_005":"005"}',200,2,5,'["AO5","BY","BW","BF","BI","CM","CF","CG","TD","CI","EG","GA","GM","GH","ID","IR","IQ","KE","KP","LS","LR","LY","MW","MY","ML","MR","MA","NE","NG","PS","RW","SL","SO","SD","SZ","SY","TG","UG","ZA","ZM","ZW"]','','upi','','{"acquirer_name":"Easebuzz","skip_checkout_validation":"AddressFalse CardFalse","popup_msg_web":"upiAppListForCollect","popup_msg_mobile":"upiAppListForIntentArray appIntent_submitMsg upiAppListForCollect","logo_web":"vimPhonePeGpayPaytm ","logo_mobile":"","checkout_label_web":" UPI Payment","checkout_label_mobile":""}','',NULL,NULL,NULL),(42,'',1,484,'Easebuzz DD',48,'https://pay.easebuzz.in/','https://pay.easebuzz.in/','https://portal.finvert.io/wl/rp/login','Full Refund only','https://dashboard.easebuzz.in/transaction/v2/refund','https://docs.easebuzz.in/docs/payment-gateway/8ec545c331e6f-initiate-payment-api','https://dashboard.easebuzz.in/transaction/v1/retrieve','3','1','1','','https://uat-git.web1.one/payin/pay48/webhookhandler_48','','USD','','USD','{"live":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"test":{"salt":"DAH88E3UWQ","key":"2PBP7IABZ2"}}','{"hard_code_url":"payin/pay48/credit.php","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","br_success":"","br_failed":"","br_pending":"","br_status_path":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","trans_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","acquirer_processing_mode":"1","acquirer_processing_currency":"USD","mdr_rate":"5.50","settelement_delay":"18","txn_fee_success":"0.80","txn_fee_failed":"0.00","acquirer_display_order":"48","reserve_rate":"10","reserve_delay":"210","settled_amt":"","charge_back_fee_1":"55","charge_back_fee_2":"70","charge_back_fee_3":"100","cbk1":"45","monthly_fee":"","refund_fee":"15","return_wire_fee":"","acquirer_processing_json":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"bank_salt":"","notification_to_005":"005"}',200,5,2880,'','','','','{"acquirer_name":"Easebuzz DD","skip_checkout_validation":"","popup_msg_web":"","popup_msg_mobile":"","logo_web":"cardIcon","logo_mobile":"","checkout_label_web":"Pay with 3D Debit Card","checkout_label_mobile":""}','dev@bigit.io',NULL,NULL,NULL);



INSERT INTO "zt_api_card_table" VALUES (111,'CREDIT','553188','ZENITH BANK PLC','2022-03-07 08:48:25','{n    "bin": "553188",n    "bank": "ZENITH BANK PLC",n    "card": "MASTERCARD",n    "type": "CREDIT",n    "level": "CORPORATE",n    "country": "NIGERIA",n    "countrycode": "NG",n    "website": "HTTP://WWW.ZENITHBANK.COM/",n    "phone": "234 (1) 4647000",n    "valid": "true"n}n',NULL),(112,'CREDIT','424242','','2022-03-11 06:52:25','{n    "bin": "424242",n    "bank": "",n    "card": "VISA",n    "type": "CREDIT",n    "level": "",n    "country": "UNITED KINGDOM",n    "countrycode": "GB",n    "website": "",n    "phone": "",n    "valid": "true"n}n',NULL),(113,'DEBIT','539983','GUARANTY TRUST BANK PLC','2022-03-12 06:42:15','{n    "bin": "539983",n    "bank": "GUARANTY TRUST BANK PLC",n    "card": "MASTERCARD",n    "type": "DEBIT",n    "level": "STANDARD",n    "country": "NIGERIA",n    "countrycode": "NG",n    "website": "",n    "phone": "234-1-4480000 OR 080 29002900 OR 080 390039",n    "valid": "true"n}n',NULL),(114,'CREDIT','554637','CITIBANK, N.A.','2022-07-07 06:19:17','{n    "bin": "554637",n    "bank": "CITIBANK, N.A.",n    "card": "MASTERCARD",n    "type": "CREDIT",n    "level": "TITANIUM",n    "country": "INDIA",n    "countrycode": "IN",n    "website": "",n    "phone": "",n    "valid": "true"n}n',NULL),(115,'DEBIT','428102','AB CITADELE BANKAS','2022-07-07 06:45:31','{n    "bin": "428102",n    "bank": "AB CITADELE BANKAS",n    "card": "VISA",n    "type": "DEBIT",n    "level": "CLASSIC",n    "country": "LITHUANIA",n    "countrycode": "LT",n    "website": "HTTP://WWW.CITADELE.LT/EN/",n    "phone": "370 5 268 0029",n    "valid": "true"n}n',NULL),(116,'DEBIT','406597','ICICI BANK, LTD.','2022-08-01 07:34:16','{n    "bin": "406597",n    "bank": "ICICI BANK, LTD.",n    "card": "VISA",n    "type": "DEBIT",n    "level": "SIGNATURE",n    "country": "INDIA",n    "countrycode": "IN",n    "website": "HTTP://WWW.ICICIBANK.COM/",n    "phone": "+91 22 26531414",n    "valid": "true"n}n',NULL),(117,'CREDIT','420739','SBI CARDS AND PAYMENT SERVICES PTE, LTD.','2022-08-04 09:08:30','{n    "bin": "420739",n    "bank": "SBI CARDS AND PAYMENT SERVICES PTE, LTD.",n    "card": "VISA",n    "type": "CREDIT",n    "level": "PLATINUM",n    "country": "INDIA",n    "countrycode": "IN",n    "website": "HTTP://WWW.SBICARD.COM/",n    "phone": "18001801290",n    "valid": "true"n}n',NULL),(118,'DEBIT','558860','OVERSEA-CHINESE BANKING CORPORATION, LTD.','2022-09-02 12:36:36','{n    "bin": "558860",n    "bank": "OVERSEA-CHINESE BANKING CORPORATION, LTD.",n    "card": "MASTERCARD",n    "type": "DEBIT",n    "level": "BUSINESS",n    "country": "SINGAPORE",n    "countrycode": "SG",n    "website": "",n    "phone": "",n    "valid": "true"n}n',NULL),(119,'DEBIT','440523','AB CITADELE BANKAS','2022-09-22 12:28:16','{n    "bin": "440523",n    "bank": "AB CITADELE BANKAS",n    "card": "VISA",n    "type": "DEBIT",n    "level": "GOLD",n    "country": "LITHUANIA",n    "countrycode": "LT",n    "website": "HTTP://WWW.CITADELE.LT/EN/",n    "phone": "370 5 268 0029",n    "valid": "true"n}n',NULL),(120,'credit','437551','ICICI BANK','2022-09-29 04:30:57','{"scheme":"visa","type":"credit","bank":"ICICI BANK","countryCode":"IN","subType":"P"}',NULL),(121,'debit','546379','SOUTHSIDE BANK','2022-10-10 09:54:51','{"scheme":"mastercard","type":"debit","bank":"SOUTHSIDE BANK","countryCode":"US","subType":"R"}',NULL),(122,'credit','414767','KOTAK MAHINDRA BANK','2022-10-12 04:41:03','{"scheme":"visa","type":"credit","bank":"KOTAK MAHINDRA BANK","countryCode":"IN","subType":"P"}',NULL),(123,'credit','401561','IDFC FIRST BANK','2022-10-14 13:10:41','{"scheme":"visa","type":"credit","bank":"IDFC FIRST BANK","countryCode":"IN","subType":"P"}',NULL),(124,'DEBIT','511111','U.S. BANK, N.A.','2022-11-28 12:03:02','{"valid":true,"number":511111,"length":6,"scheme":"MASTERCARD","brand":"MASTERCARD","type":"DEBIT","level":"STANDARD","currency":"USD","issuer":{"name":"U.S. BANK, N.A.","website":"www.usbank.com","phone":"1-800-US BANKS"},"country":{"country":"UNITED STATES","numeric":"840","capital":"Washington, D.C.","idd":"1","alpha2":"US","alpha3":"USA","language":"English","language_code":"EN","latitude":34.05223000000000155296220327727496623992919921875,"longitude":-118.2436799999999976762410369701683521270751953125}}',NULL),(125,'CREDIT','555555','','2022-11-28 12:27:35','{"valid":true,"number":555555,"length":6,"scheme":"MASTERCARD","brand":"MASTERCARD","type":"CREDIT","level":"","currency":"BRL","issuer":{"name":"","website":"","phone":""},"country":{"country":"BRAZIL","numeric":"76","capital":"Brasilia","idd":"55","alpha2":"BR","alpha3":"BRA","language":"Portuguese","language_code":"PT","latitude":-11.1355599999999999027977537480182945728302001953125,"longitude":-42.1127800000000007685230229981243610382080078125}}',NULL),(126,'CREDIT','438775','JPMORGAN CHASE BANK, N.A.','2022-12-05 12:49:14','{"valid":true,"number":438775,"length":6,"scheme":"VISA","brand":"VISA","type":"CREDIT","level":"CLASSIC","currency":"USD","issuer":{"name":"JPMORGAN CHASE BANK, N.A.","website":"http://www.jpmorganchase.com","phone":"1-212-270-6000"},"country":{"country":"UNITED STATES","numeric":"840","capital":"Washington, D.C.","idd":"1","alpha2":"US","alpha3":"USA","language":"English","language_code":"EN","latitude":34.05223000000000155296220327727496623992919921875,"longitude":-118.2436799999999976762410369701683521270751953125}}',NULL),(127,'debit','438976','PAYTM PAYMENTS BANK','2022-12-17 08:41:34','{"scheme":"visa","type":"debit","bank":"PAYTM PAYMENTS BANK","countryCode":"IN","subType":"R"}',NULL),(128,'credit','x43889','MASHREQ BANK','2022-12-19 07:40:34','{"scheme":"mastercard","type":"credit","bank":"MASHREQ BANK","countryCode":"EG","subType":"R"}',NULL),(129,'credit','524181','HDFC BANK','2022-12-20 03:53:23','{"scheme":"mastercard","type":"credit","bank":"HDFC BANK","countryCode":"IN","subType":"P"}',NULL),(130,'debit','401138','IDFC FIRST BANK','2022-12-24 06:45:51','{"scheme":"visa","type":"debit","bank":"IDFC FIRST BANK","countryCode":"IN","subType":"R"}',NULL),(131,'credit','543889','MASHREQ BANK','2023-07-19 10:26:54','{"scheme":"mastercard","type":"credit","bank":"MASHREQ BANK","countryCode":"EG","subType":"R"}',NULL),(132,'credit','404745','STATE BANK OF INDIA','2023-08-30 10:21:03','{"scheme":"visa","type":"credit","bank":"STATE BANK OF INDIA","countryCode":"IN","subType":"P"}',NULL),(133,'credit','491620','CARIBBEAN CREDIT CARD CORPORATION','2023-09-28 10:20:08','{"scheme":"visa","type":"credit","bank":"CARIBBEAN CREDIT CARD CORPORATION","countryCode":"AG","subType":"R"}',NULL),(134,'debit','652294','STATE BANK OF INDIA','2023-10-09 12:34:26','{"scheme":"rupay","type":"debit","bank":"STATE BANK OF INDIA","countryCode":"IN","subType":"R"}',NULL),(135,'credit','414141','VERMONT NATIONAL BANK','2023-10-31 08:35:46','{"scheme":"visa","type":"credit","bank":"VERMONT NATIONAL BANK","countryCode":"US","subType":"R"}',NULL);


INSERT INTO "zt_api_data_table" VALUES (1,'banks','HLBBMYKL','2020-10-14 04:33:35','{ "swift": "HLBBMYKL", "bank": "HONG LEONG BANK BERHAD", "city": "KUALA LUMPUR", "branch": "WISMA HONG LEONG (MAIN BRANCH)", "address": "WISMA HONG LEONG FLOOR 3 18 JALAN PERAK", "postcode": "50450", "country": "MALAYSIA", "countrycode": "MY", "valid": "true" }',NULL),(6,'banks','BOMLAEAD','2020-10-14 05:30:51','{"swift":"BOMLAEAD","bank":"MASHREQBANK PSC.","city":"DUBAI","branch":"","address":"AL RIQQA STREET AL GHURAIR CITY","postcode":"","country":"UNITED ARAB EMIRATES","countrycode":"AE","valid":"true"}',NULL),(7,'banks','VTCBVNVX','2020-10-14 05:38:21','{"swift":"VTCBVNVX","bank":"VIETNAM TECHNOLOGICAL AND COMMERCIAL JOINT STOCK BANK","city":"HANOI","branch":"Vietnam Technological and Commercial JSB","address":"TECHCOMBANK TOWER 191 BA TRIEU HAI BA TRUNG","postcode":"10000","country":"VIET NAM","countrycode":"VN","valid":"true"}',NULL),(8,'banks','CMFGUS33','2020-10-16 13:02:59','{"swift":"CMFGUS33","bank":"COMMUNITY FEDERAL SAVINGS BANK","city":"NEW YORK","branch":"MAIN","address":"89-16 JAMAICA AVENUE","postcode":"11421","country":"UNITED STATES OF AMERICA","countrycode":"US","valid":"true"}',NULL),(9,'banks','INTFBGSF','2020-11-03 10:25:43','{"swift":"INTFBGSF","bank":"ICARD AD","city":"VARNA","branch":"","address":"BUSINESS PARK VARNA B1 B1","postcode":"1407","country":"BULGARIA","countrycode":"BG","valid":"true"}',NULL),(10,'banks','MEBLAEADXXX','2021-06-04 00:55:19','{"swift":"MEBLAEAD","bank":"EMIRATES ISLAMIC BANK","city":"DUBAI","branch":"","address":"DEIRA AL YOUSUF TOWER","postcode":"6564","country":"UNITED ARAB EMIRATES","countrycode":"AE","valid":"true"}',NULL),(11,'banks','MEBLAEAD','2021-06-04 22:51:35','{"swift":"MEBLAEAD","bank":"EMIRATES ISLAMIC BANK","city":"DUBAI","branch":"","address":"DEIRA AL YOUSUF TOWER","postcode":"6564","country":"UNITED ARAB EMIRATES","countrycode":"AE","valid":"true"}',NULL),(12,'banks','CIBCCATT','2021-08-05 05:25:10',NULL,NULL),(13,'banks','werwe','2021-12-02 08:34:23','{"valid":"false","error":"1012","message":"Invalid SWIFT Code"}',NULL),(14,'banks','12345','2021-12-02 08:34:30',NULL,NULL);



INSERT INTO "zt_bank_payout_table" VALUES (1,1,1111,'https://api.binance.com','','','https://accounts.binance.com/en/login','','','','','','90','4','2','https://testnet.binance.vision','','','','','','','{"hard_code_url":"","hard_code_status_url":"","hard_code_live_status_url":"","hard_code_refund_url":"","min_limit":"1","max_limit":"500","scrubbed_period":"1","transaction_count":"7","tr_scrub_success_count":"2","tr_scrub_failed_count":"5","setup_fee":"","checkout_level_name":"Binance"}','{"decrypt":"MTZvN2I3MXVTT2I1YlR2TlprOWlUczhiVmdpdFRRbUNVWHFEb0M0ZEJQSEo3UXphemdEeGdlbCtxbXp3Y2VXZGFEa2QrREZVN3oyK3NNTmFYcklUSzlhS2hWQUNTQUlKaG4za01UTHdyeEpVWlVRNDJDWTc0QzFITVMrbWxtQnpSMVROZkVVQTBJU0tYQzNTbCtkclpncjdNVG1ybFkydUdKODJrODBWSDF2WTJQOGNkZ3htL3lSS3hFWE9JWmduNjhiYVdqaFJ2Ym9XT1hsTHBXYkV3YVIvblRVczB3OGhzQUJkWkhia3lRNVV2OU0xYTViQmFkbElLN2NTQlZESnBqamZmeHh5N0xGbnlHZVdJWGZTcU9kcDFVcXNTdWhMK0pLNGtvWlM0V1lvdzhramNpYUlqbkdHSzhJL2VQWmFKMkhYbTIzajJpcUYzbnYrOXlUNEVyVjB0ZmNaS3ljNkN2Ym5kWTNsY1dObGRSS3dkcFNkWElMakxJZlNjYWJNL2lrZVRJa1J3ajRMQ3ljTWI4NmIyVVZRR1dkalhZSUkrd1FST1MzZVBWRlplaTB4by95N0dUbnpyWE0vYnFyM281UGJQTk5nYmpwUWoxelRJM0FmSnZ1L1J2KzJuVExQWW15b2JsRFZJREdkTWpYSFV5SGhmMWhmZFh3Um9SRFlJcXZMSHlIdjE5Y1JkTHFKakNvMjZQWVhSdWRETS9rQlRYclZnTXA4K0dxZWZybHVYVWFLWEo0Z0RQYi8xUFRLWTAvWFNXT2tkZC9lL0g4c21wTjNEb1FvczRhL3dTa0tBNGl5OEtzR1dINjh5Y2d6dDNNWU10aFlyVHhCQlZ0SW5uNFhMZjZUSk9ucEFSR0o0blcwSXUrdmhralArVVF2Wk55R0xncGRiWkVuSklDSWs5RjVtRW5XME5xTGgrd1hScjdBSllzWm50Tnl4YTBrMFo2cXIxRzJTci9WeldlVldORVlQbDU5Z3pVUWh5cTE5UEt0RmtQUVZvTkt2Z1NqMGlsWHJxTUlwYVBPRmpOeGNId3RrSXU5dlJYVjVhb0xqOVhaZzUwNCtvY3FIZ25JdnEzeUlXR2hzcTZhdVhQa0VjRjNKOHZWS0srOEo1WCtQVzNFQUYzRVNyR0R1ZHVGVmF5U1JhR21yWFBwV2hrcXZYa0F4OVNHcUd6ZHNPMmNQUUc2NFZwQWtrMDk5ZUQxd2Zvd25BPT0","key":"1"}',NULL,NULL),(2,1,1112,'https://payout-api.cashfree.com','','','https://accounts.binance.com/en/login','','','','','','6','4','2','https://payout-gamma.cashfree.com','','','','','','',NULL,NULL,NULL,NULL);




INSERT INTO "zt_banks" VALUES (6666,4444,'Test Bank Name','Test Bank Address','','','IN','','','Test Account Holder Name','1122334455667788','PC','','TEST IFSC Code',0,0,'Test Additional Info','INR','2','','','','Test Full Address','4444_Test Account Holder Name_TEST IFSC Code_16085524522179109_1365446214_clock_64.png',1,NULL,'0.00',0.00,0,NULL,'112','34334343');


INSERT INTO zt_clientid_table (id, sponsor, username, password, registered_email, active, status, edit_permission, created_date, last_login_date, last_login_ip, fullname, company_name, country, description, ip_block_client, encoded_contact_person_info, registered_address, deleted_email, private_key, daily_password_count, password_updated_date, previous_passwords, default_currency, google_auth_code, google_auth_access, sub_client_id, sub_client_role, json_log_history, json_value, request_funds, moto_status, payout_request, qrcode_gateway_request, assign_trans_display_json, sort_trans_display_json) VALUES
(272, 21, 'dev', '72325064a8cf76fae0f9613e7004a8268d12466af4420258272bcb5e1c11f227', '{"decrypt":"dGxaQmtuZXR2RDBUdkdrQ1dDQlBYUT09","key":"1"}', 1, 2, '1', '2022-02-04 12:08:59', '2023-09-29 15:07:39', '::1', 'Test', 'MERCHANT LLC', 'IN', '', '', '', 'ggg555', '', 'MjcyXzIwMjMwOTI2MTIxMzUx', '{"date":"2023-12-08 16:34:50","count":"2"}', '2023-12-08 14:41:44', '{"prev_pass1":"2ca80b6ac7337520d2e4a5256166065071a4c87ee85150ccc895939186d45e61","prev_pass2":"2ca80b6ac7337520d2e4a5256166065071a4c87ee85150ccc895939186d45e61","prev_pass3":"bef65d33ed36728a34d323147533a3deec58eb986a9b66c327cf3dcc91c38ff5","prev_pass4":"2ca80b6ac7337520d2e4a5256166065071a4c87ee85150ccc895939186d45e61","prev_pass5":"3104a06c426fc775a4342e973af0b94df02365dcfbbb43af88878f72da901320","prev_pass6":"6acf1be4b5bbe8645951f48c97e3d421e96652d29ef717b25bc287d915785b34","prev_pass7":"72325064a8cf76fae0f9613e7004a8268d12466af4420258272bcb5e1c11f227","prev_pass8":null,"prev_pass9":null,"prev_pass10":null}', 'USD', 'TKAMNEKKPWJFLT7N', 1, NULL, '', '{}', '{"vt":"0","zip":"201010","city":"Test","email":"in*o@le***e.com","lname":"","state":"Test","change":"CHANGE NOW!","regnum":"","address":"Test","company":"MERCHANT LLC","country":"IND","gst_fee":"0","wire_fee":"1","StartPage":"0","max_limit":"","min_limit":"","payoutFee":"0.00","user_type":"2","birth_date":"","document_no":"","monthly_fee":"1","nationality":"","settled_amt":"0","upload_logo":"","business_ims":"4455445544","legal_entity":"","merchant_ims":"@mith","request_funds":"0","frozen_balance":"100","payout_account":"","state_full_name":"Test","user_permission":"1","whitelisted_ips":"","withdraw_option":"1","withdraw_period":"180","business_address":"Test Address","withdraw_max_amt":"20000","withdraw_min_amt":"1","bill_country_name":"IN_IND_368_India","business_ims_type":"WhatsApp","merchant_ims_type":"Skype","establishment_date":"","tr_scrub_failed_count":"5","tr_scrub_success_count":"2","qrcode_gateway_request":"1","payout_request":"1","business_contact":"undefined","designation":"undefined","phone":"undefined","fname":"","tab_name":"collapsible1","action":"update","gid":"272","type":"active","username_old":"admin","username":"dev","registered_email":"de***s@it*o.in","edit_permission":"1","default_currency":"USD","fullname":"Test","company_name":"MERCHANT LLC","registered_address":"ggg555","send":"Save Changes"}', NULL, NULL, '1', '1', NULL, '{"payin_transaction_display":["transID","reference","bill_amt","trans_amt","fullname","bill_email","upa","mop","trans_status","trans_response","tdate","rrn"]}');


INSERT INTO zt_payin_setting (id, clientid, payin_status, monthly_fee, payin_theme, settlement_optimizer, settlement_fixed_fee, settlement_min_amt, frozen_balance, manual_adjust_balance, manual_adjust_balance_json, available_refresh_tranid, available_balance, available_rolling, chargeback_ratio_card) VALUES
(1, 272, 2, '1', 'OPAL_NS', 'manually', '0.00', '1', '0.00', NULL, NULL, '382148342', '106625.20', '0', '37.50');



INSERT INTO "zt_emails_templates" VALUES (1,'CONFIRM-TO-MEMBER',' Verify Email Address','<p style="text-align:center;">Welcome to <b>[sitename]</b>, <b>[fullname]</b>! Before we get started, please confirm your email address.</p><a style="float:unset;width:250px;display:block;color:rgb(255, 255, 255)!important; font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:22px;font-style: normal;font-weight:400;margin:20px auto 10px auto;padding:10px 30px;border:0px; vertical-align:baseline;background:none left top repeat rgb(0, 148, 143);clear:both;text-decoration:none !important;border-radius:7px;text-align:center;" target="_blank" href="[confpage]?cid=[confcode]">Verify Email </a><p>Or copy this link and paste it in your web browser</p><p>E-mail verification link: <b>[confpage]?cid=[confcode]</b></p><p style="text-align:left;padding-top:20px;">Thank you!,</p><p><b>[sitename]</b> Team</p>'),(2,'SIGNUP-TO-MEMBER',' Merchant credentials for login to [sitename]','<p style="text-align:left;">Hello <b>[username]</b></p><p style="text-align:left;">Thank you for completing your registration with [sitename].</p><p style="text-align:left;">This email serves as confirmation that your account has been activated and includes your account details, so please keep it safe!</p><p style="text-align:left;font-weight:bold;margin-top:40px;font-size:18px;margin-bottom:6px;"><b>Login details:</b></p><p style="text-align:left;border-bottom:2px solid #00948f;padding:0px;margin:0px;height:2px;"> </p><p style="text-align:left;margin:20px 0 0 0;"><b>Username:</b> [username]</p><p style="text-align:left;">To generate your password, click on the button below:</p><a style="float:unset;width:310px;display:block;color:rgb(255, 255, 255)!important; font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:22px;font-style: normal;font-weight:400;margin:20px auto 10px auto;padding:10px 30px;border:0px; vertical-align:baseline;background:none left top repeat rgb(0, 148, 143);clear:both;text-decoration:none !important;border-radius:7px;text-align:center;" target="_blank" href="[resetpasswordurl]?c=[confcode]">Generate Password</a><p>Or copy and paste the URL into your browser:</p><p><b>[resetpasswordurl]?c=[confcode]</b></p><p style="text-align:left;border-bottom:2px solid #00948f;padding:0px;margin:20px 0 0 0px;height:2px;"> </p><p style="text-align:left;margin:30px 0 0 0;">We request you to login to your account and complete the <b style="font-style:italic">Profile</b>, <b style="font-style:italic">Business Profile</b> and <b style="font-style:italic">Bank Profile</b>. Once it�s completed from your end then please drop an e-mail to us to review updated information.</p><p style="text-align:left;padding-top:30px;">Thank you,</p><p><b>[sitename]</b> Team</p>'),(5,'UPDATE-BANK-INFORMATION',' [username] - Bank information changed!','<p>Dear [username],<br></p><p>This is to inform you that your "Bank information" has been updated as per your request.</p><p>We request you to please check your account details and verify them.</p><br><p>Sincerely,</p><p>[sitename] Team</p>'),(7,'SEND-MONEY','Money Waiting','Dear [username], This is an e-mail from [sitename] containing a notification of money paid to your account...A [sitename] Merchant has just successfully sent you money! Please look at the details below for information on this transaction. Sender: [username]Sender''s E-Mail: [emailadr]Amount Received: [amount]Sender''s Comments: [comments]You can access your account anytime at: Access<a href="[hostname]/#duspay_login">&nbsp;your </a>account Thank&nbsp;you! for your time, [sitename] Services Team <a href="[hostname]">[hostname]</a>Disclaimer: This is an auto generated mail, please do not reply to this mail. If you have any query, feel free to write to us at [adminemail] 77'),(8,'REQUEST-MONEY','You have got a payment request','<h1>Dear [fullname],</h1><p>This is an e-mail from [sitename].</p><p>A Merchant of [sitename] has requested money!</p><p>From Email: [emailadr]</p><p>Amount: [currency_amount]</p><p>Sender’s Comments: [comments]</p><p>To complete this transaction, you need to click the link below (or if there is no link, copy the address to your web browser) and direct pay now by process link. Instructions on approving or denying the transaction can be found on our website.</p>[payrequest]<p>Thank you for your time,[sitename] Services Team</p>&nbsp;<a href="[hostname]">[hostname]</a><p>Disclaimer: This is an auto generated mail, please do not reply to this mail. If you have any query, feel free to write to us at [adminemail]</p>'),(9,'SEND-ESCROW','Money Waiting','Hello [username],This is an e-mail from [sitename] containing a notification of money paid by escrow to your account...A [sitename] Merchant has just successfully sent you money! Please look at the below details for information on this transaction.Sender: [username]Sender''s E-Mail: [emailadr]Amount Received: [amount]Sender''s Comments: [comments]You can access your account anytime at:<a href="[hostname]/#duspay_login">click here</a>Thank you for your time,[sitename] Services Team<a href="[hostname]">[hostname]</a>Disclaimer : This is an auto generated mail, please do not reply to this mail. If you have any query feel free to write us at [adminemail]'),(18,'RESTORE-PASSWORD','Reset password request received','<p>Dear [full name],&nbsp;<br></p><p>We got a request to reset your [sitename] password.<br></p><p>Your [sitename] account ([username]) password is: [password]<br></p><p>If you didn''t request this, please let us know immediately and we will look into this.</p><br><p></p><p>Sincerely,</p><p>[sitename] Team</p><p></p>'),(19,'CONFIRM-NEW-EMAIL','Verification link for new Email address','<p style="text-align:left;">Dear [fullname],</p><p style="text-align:left;">Please click on below link to verify your new email address.<br></p><a style="float:unset;width:310px;display:block;color:rgb(255, 255, 255)!important; font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:22px;font-style: normal;font-weight:400;margin:20px auto 10px auto !important;padding:10px 30px;border:0px; vertical-align:baseline;background:none left top repeat rgb(0, 148, 143);clear:both;text-decoration:none !important;border-radius:7px;text-align:center;" target="_blank" href="[confpage]?c=[confcode]">Verify Email </a><p>Or copy this link and paste in your web browser</p><p><b>[confpage]?c=[confcode]</b></p><p style="text-align:left;padding-top:20px;">Sincerely,</p><p><b>[sitename]</b> Team</p>'),(20,'NEW-EMAIL-ACTIVATED','New email id added to [sitename] account','<p style="text-align:left;">Dear [fullname],</p><p style="text-align:left;">We are writing in reply to your request for adding new email id to your [sitename] account.</p><p>We have added new email id to your [sitename] acount successfully.</p><p style="text-align:left;padding-top:20px;">Sincerely,</p><p><b>[sitename]</b> Team</p>'),(21,'PAYMENT-TO-UNREGMEMBER','Money Waiting','Hello,rnrnThis is not SPAM, this is an e-mail from [sitename] containing a notification of money paid to you.rnrnA [sitename] current_user has just successfully sent you money! Please look at the below details for information on this transaction.rnrnSender: [username]rnSender''s E-Mail: [emailadr]rnAmount Received: [amount]rnSender''s Comments: [comments]rnrnrnTo get the money you have first to register to [sitename] using the same email address this email is sent to.rnUse that link to coninue registration process: [usersite]rnThis email is valid during 10 days. If you don''t signup within this period, money invoice will be cancelled.rnrnThank you!rnrn[sitename] Services Teamrn[hostname]rn"THE NEW ONLINE UNIVERSAL PAYMENT SYSTEM"'),(22,'SIGNUP-TO-SUB-ADMIN','Internal - New [sitename] account','<p style="text-align:left;">Hello <b>[username]</b></p><p style="text-align:left;">Welcome to [sitename]!</p><p style="text-align:left;">New account has been created for you on [sitename] to keep eyes on merchant''s data.</p><p style="text-align:left;font-weight:bold;margin-top:40px;font-size:18px;margin-bottom:6px;"><b>Login details:</b></p><p style="text-align:left;border-bottom:2px solid #00948f;padding:0px;margin:0px;height:2px;"> </p><p style="text-align:left;"><b>Username:</b> [username]</p><p style="text-align:left;">To generate your password, click on the button below:</p><a style="width:fit-content;display:block;color:rgb(255, 255, 255)!important; font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:22px;font-style: normal;font-weight:400;float:unset;margin:20px auto 10px auto;padding:15px 60px;border:0px; vertical-align:baseline;background:none left top repeat rgb(0, 148, 143);clear:both;text-decoration:none !important;border-radius:7px;" target="_blank" href="[generate_password_adm]?c=[confcode]">Generate Password</a><p>Or copy and paste the URL into your browser:</p><p><b>[generate_password_adm]?c=[confcode]</b></p><p style="text-align:left;border-bottom:2px solid #00948f;padding:0px;margin:20px 0 0 0px;height:2px;"> </p><p style="text-align:left;padding-top:30px;">Thank you,</p><p><b>[sitename]</b> Team</p>'),(24,'MERCHANT-EMAIL-TRANSACTIONS-CHARGEBACK-RECEIVED','Chargeback Reported - [amount_currency] - [transID]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;background:#fff;"><tbody><tr><td colspan="2" style="padding:0px;background:#fff;margin:0;"><p style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;margin:0;">Dear Merchant,<br>The following transaction has been chargedback in full and accordingly your account -- SQLINES LICENSE FOR EVALUATION USE ONLY
 with us has been reduced by the amount of the chargeback plus any additional charges, if appropriate.<br></p><table align="center" style="color:#666;width:100%;padding:10px 2.5%;line-height:150%;"><tbody><tr><td width="70%" colspan="2"><p style="color:#999;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;">Transaction Details</p>[ctable1]</td></tr></tbody></table><table><tbody><tr><td><p style="padding-left:35px"> We understand that you may not have been expecting this chargeback.</p></td></tr></tbody></table><hr><table style="width:100%;"><tbody><tr><td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;"><p style="width:100%;padding:10px 0 0 0;line-height:150%;">Thank you for your cooperation.</p>          -- SQLINES DEMO *** __________________________          <p style="width:100%;padding:0px 0 10px 0;line-height:150%;"><b>Sincerely,<br>            [sitename], Risk Team.</b></p></td></tr></tbody></table></td></tr></tbody></table>'),(25,'MERCHANT-EMAIL-TRANSACTIONS-RETURN','Check Returned - [amount_currency] from [customer_name]  [transID]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;background:#fff;"><tr><td colspan="2" style="padding:0px;background:#fff;margin:0;"><div style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;margin:0;">rn  <p>Dear Merchant,<br/>rn    Our banking partners has notified us about the below check transaction which has been returned.</p>rn</div><table align="center" style="color:#666;width:100%;padding:10px 2.5%;line-height:150%;" ><td width="70%" colspan="2"><div style="color:#999;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;">Transaction Details</div>[ctable1]</td></tr></table>rn      <hr/><table style="width:100%;"><tr><td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;" ><p style="width:100%;padding:10px 0 0 0;line-height:150%;">Kindly contact the customer if you would like to get paid for this order again from the customer. If the check return is due to UTLA - Unable to Locate Account. You can resubmit the transaction with correct information as printed in the real check.</p>rn  --<br/>rn  ________________________________________rn  <p style="width:100%;padding:0px 0 10px 0;line-height:150%;"><strong>Regards,<br/>rn    Team [sitename].</strong></p></td></tr></table></td></tr></table>'),(26,'MERCHANT-EMAIL-TRANSACTIONS-ECHECK-ACTION-REQUIRE','Action Require for eCheck Transaction: - [amount_currency] from [customer_name] - [transID]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;"><tr><td colspan="2" style="padding:0px;"><div style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;"><strong>Dear [merchant_name],<br/></strong><br/>nWe would like to bring your attention about the above transaction Id which has been flagged by the system for support review. In order to complete our review please provide us the below check list of the supporting documents.<br/></div><table align="center" style="color:#666;width:100%;padding:10px 2.5%;line-height:150%;" ><td colspan="2"><div style="color:#999;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;">Documents need to be maintained for every check transaction processed by our gateway:</div></td></tr><tr><td width="30%">1. Docusign agreement signed by the customer;</td></tr><tr><td>2. Snapshot of Customer satisfaction email sent to your email;</td></tr><tr><td>3. Voice log confirming that customer has authorized to you debit their bank account and they are satisfied with the services offered by you;</td></tr><tr><td>4. Id proof of the customer which has the complete name of the customer. (Mandatory for transaction over 700 USD)</td></tr><tr>n  <td>5. Copy of Cancel Check or bank statement, which has the account information. (Mandatory for transaction over 700 USD)</td>n</tr><tr><td>6. Any document showing the availability of the fund in the bank account.(Mandatory for transaction over 1500 USD)</td></tr><tr><td>7. Any other supporting documents or email to help your answer about above points (optional)</td></tr><tr><td><br/>If you were failed to collect the supporting documents from the customer as stated above at the time of transaction. You may get in touch with them to gather the required documents. Which has been agreed by the merchant already.<br/><ul><li>To debit the bank account of US customers, merchant need to secure the written debit authorization from the account holder. The customer must be permitting the merchant to debit their checking accounts against the payment for the services. We prefer this authorization by real sign/ DocuSign/ email/ voice log etc</li><li>Do not charge a customer, unless you have secured at-least two form of authorization from the customer to debit their bank account for your product or services.</li><li>Debiting a bank account of any consumer in United States without  the authorization of the Account Holder is a punishable offence, Merchant involve in such illegal activities will be punished by the Law of United States. We will fully co-operate with the legal authorities by providing your respected documents to them.</li><li>Merchant can use their own authorization format, or the same can be requested from us for reference.</li><li>Sale must be processed only after the service fulfillment and the same needs to be confirm by the customer.</li><li>MSP may request a proof of transaction anytime to ensure that merchant is not involve in fraudulent activity.<br/><br/><strong>For any reason if you failed to reply this notice within 48 hours. The transaction can be cancelled. </strong></li></ul></td></tr></table><hr/><table style="width:100%;"><tr><td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;" >--<br/>________________________________________n        <p style="width:100%;padding:0px 0 10px 0;line-height:150%;"><strong>Regards,<br/>n          Team [sitename].</strong></p></td></tr></table><p style="color:#999;width:95%;padding:10px 2.5%;font-size:11px;line-height:150%;">This message (including any attachments) contains confidential information intended for a specific individual and purpose. nIf you are not the intended recipient, please delete this message immediately and if possible inform the sender of the error.</p></td></tr></table>'),(27,'MERCHANT-EMAIL-TRANSACTIONS-REFUND','Refund Requested - [amount_currency] - [transID]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;background:#fff;"><tbody><tr><td colspan="2" style="padding:0px;background:#fff;margin:0;"><p style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;margin:0;">Dear Merchant, <br>One of your customer has requested for the refund and here is the details of the transaction:<br></p><p style="color:#999;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;clear:both;">Transaction Details</p>[ctable1]<br><p></p><hr><table style="width:100%;"><tbody><tr><td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;"><p style="width:100%;padding:10px 0 0 0;line-height:150%;">We have processed this refund request successfully. </p><p style="width:100%;padding:10px 0 0 0;line-height:150%;">Your customer''s bank might take up to 14 - 21 business days to credit the refund amount to their bank account.</p>--<br>________________________________________<p style="width:100%;padding:0px 0 10px 0;line-height:150%;"><b>Sincerely,<br>[sitename] Team</b></p></td></tr></tbody></table></td></tr></tbody></table>'),(28,'MERCHANT-EMAIL-TRANSACTIONS-REMINDER','Payment made to [descriptor] for [currency_amount] at [dba]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;"><tbody><tr><td colspan="2" style="padding:0px;background:#fff;margin:0;"><p style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;"><b>Dear [customer_name],</b><br><br>We would like to inform you that recently you have purchased [product_name] from [business_url] by your [cardtype] Card [card_no].<br><b>The transaction will appear as <b>"[descriptor]"</b> in your card statement.</b><br></p><table align="center" style="color:#666;width:100%;padding:10px 2.5%;line-height:150%;"><tbody><tr><td>[ctable1]</td></tr><tr><td style="padding:20px 0px;"><b>[sitename] Support:</b> For payment related issues or refund request, please contact [sitename] by [adminemail].</td></tr><tr><td style="padding:20px 0px;"><b>[dba] Support:</b> For product subscription and other technical support issues, please contact merchant at [merchant_service_no] or [emailadr].</td></tr></tbody></table><hr><table style="width:100%;"><tbody><tr><td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;">_______________________________________      <p style="width:100%;padding:0px 0 10px 0;line-height:150%;"><b>Sincerely,<br> [sitename] Operations Team</b></p></td></tr></tbody></table></td></tr></tbody></table>'),(29,'MERCHANT-EMAIL-TRANSACTIONS-CBK1','Pre-Dispute Alert Received - [amount_currency] - [transID]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;"><tbody><tr><td colspan="2" style="padding:0px;background:#fff;margin:0;"><p style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;margin:0;">Dear Merchant,<br></p><p>We would like to inform you that our pre-dispute alert service provider informs us that following transaction has been raised as chargeback by your customer to their issuing bank.</p><p></p><table align="center" style="color:#666;width:100%;padding:10px 2.5%;line-height:150%;"><tbody><tr><td width="70%" colspan="2"><p style="color:#999;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;">Transaction Details</p>[ctable1]</td></tr></tbody></table><hr><table style="width:100%;"><tbody><tr><td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;"><p style="width:100%;padding:10px 0 0 0;line-height:150%;">We have refunded this transaction to customer�s [cardtype] Card to prevent the chargeback.</p><p style="width:100%;padding:10px 0 0 0;line-height:150%;">You may check refunded transaction in the portal as <b>Predispute</b>.</p>  --<br>________________________________________  <p style="width:100%;padding:0px 0 10px 0;line-height:150%;"><b>Sincerely,<br>    [sitename] Team</b></p></td></tr></tbody></table><p style="color:#999;width:95%;padding:10px 2.5%;font-size:11px;line-height:150%;">This message (including any attachments) contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, please delete this message immediately and if possible inform the sender of the error.</p></td></tr></tbody></table>'),(30,'CUSTOMER-EMAIL-TRANSACTIONS-REFUNDED','[bill_amt_currency] - [dba]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;background:#fff;"><tbody><tr><td colspan="2" style="padding:0px;background:#fff;margin:0;"><p style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;margin:0;text-align:center;font-size:20px;"><b>Refund has been initiated</b></p><p style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;margin:0;text-align:center;"><br>Your bank might take up to 14 - 21 business days to credit the refund amount to your bank account.</p><p style="clear:both;float:left;background-color:#fff;width:95%;padding:2px 2.5%;"></p><p style="color:#999;font-size:20px;display:block;width:100%;padding:5px 0 15px 0;clear:both;">Transaction Details</p>[ctable2]<br><p></p><hr style="width:100%;clear:both;"><table style="width:100%;clear:both;"><tbody><tr><td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;"><p style="width:100%;padding:10px 0 0 0;line-height:150%;"><b>For any refund related queries, please reach out to merchant directly at <b>[emailadr]</b>.</b></p></td></tr></tbody></table></td></tr></tbody></table>'),(31,'MERCHANT-EMAIL-TRANSACTIONS-CARD-ACTION-REQUIRE','Action�Require�for�Card�Transaction: [amount_currency]�from�[customer_name]�-�[transID]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;"> <tbody><tr> <td colspan="2" style="padding:0px;"><p style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;"> <b>Dear [merchant_name]</b><br><br>We would like to inform you that while reviewing your account the acquirer has found some suspicious transactions processed by the customer. The acquirer requires below mentioned documents to validate the authenticity of customer and transactions processed.<br>         </p> <table align="center" style="color:#666;width:100%;padding:10px 2.5%;line-height:150%;"><tbody><tr> <td>1. Id proof of the customer which has the complete name of the customer.</td> </tr> <tr> <td>2. Front copy of card (The card by which customer bought product/services from your website).</td> </tr>      </tbody></table>         <hr> <table style="width:100%;"> <tbody><tr> <td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;"><p style="width:100%;padding:0px 0 10px 0;line-height:150%;">We request you to please provide the documents as proposed by the acquirer.--</p><p style="width:100%;padding:0px 0 10px 0;line-height:150%;">Sincerely,?<br><b>[sitename]</b> Team </p> </td> </tr> </tbody></table></td> </tr> </tbody></table>'),(32,'MERCHANT-EMAIL-ECHECK-TRANSACTIONS-REMINDER','Remember the Check transaction paid by [descriptor] for [currency_amount] on [bussiness_url]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;"><tr><td colspan="2" style="padding:0px;background:#fff;margin:0;"><div style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;margin:0;"><p><strong>Dear [customer_name],</strong><br/><br/>We would like to inform you about the recent purchase made by your checking account [cardtype] [card_no] on [bussiness_url]<br/><strong>This transaction will appears on your bank statement as [descriptor]</strong> with check number 161. <br/></p>rn</div><table align="center" style="color:#666;width:100%;padding:10px 2.5%;line-height:150%;" ><td>[ctable1]</td></tr></table><hr/><table style="width:100%;"><tr><td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;" ><p style="width:100%;padding:10px 0 0 0;line-height:150%;"><strong>To expedite the resolution of any dispute/complain or requests for refund with merchant, please contact [sitename] directly by [adminemail]</strong><br/>rn  We strive to give you the best solution as soon as possible.</p><p style="width:100%;padding:10px 0 0 0;line-height:150%;">As you have already performed the payment, there is nothing else you need to do. However, we recommend you keep this email for future reference.<br/>rn        The purchased products and services will be delivered in accordance with the terms and conditions<strong> published on merchant website and agreed by you during the order.</strong></p>rn      --<br/>________________________________________rn      <p style="width:100%;padding:0px 0 10px 0;line-height:150%;"><strong>Regards,<br/>rn        Team [sitename]</strong></p></td></tr></table><p style="color:#999;width:95%;padding:10px 2.5%;font-size:11px;line-height:150%;">This message (including any attachments) contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, please delete this message immediately and if possible inform the sender of the error.</p></td></tr></table>'),(33,'MERCHANT-EMAIL-ECHECK-TRANSACTIONS-PROCESS','Check Transaction - [amount_currency] from [customer_name]  -  [transID]','<p style="float:left;width:90%;padding:2% 5%;line-height:150%;background-color:#fff;color:#000;font-family:arial,sans-serif;border:4px solid #e2e2e2;">rn		 A transaction of eCheck has been received by [sitename] for [dba] - <a href="[bussiness_url]" target="_blank">[bussiness_url]</a><br/>rn		 <b>Transaction Details:</b><br/>rn		 Customer Name: <b>[customer_name]</b><br/>rn		 Customer’s E-Mail: <b>[customer_email]</b><br/>rn		 Customer’s Phone No.: <b>[customer_phone]</b><br/>rn		 Transaction Amount: <b>[amount_currency]</b><br/>rn		 Customer’s Comments: [comments]<br/><br/>rn		 This check will be processed soon, Please ask the customer to maintain the sufficient balance in the account.<br/>rn		 Thank you,<br/>rn		 [sitename] Operation Team<br/>rn		</p>'),(35,'PAYMENT-COMPLETED-EMAIL-TO-MERCHANT','Payment completed - [amount_currency] from [customer_name] - [transID]','<p style="float:left;width:90%;padding:2% 5%;line-height:150%;background-color:#fff;color:#000;font-family:arial,sans-serif;border:4px solid #e2e2e2;"> A Transaction has been  completed successfully for [dba] - [bussiness_url]<br><br> <b>Please look at the below transaction details:</b><br><br> [ctable2] <br><br><br> You can access your account anytime at: <br><br> <a href="[hostname]">[hostname]</a><br><br><br> Thank you,<br><br> [sitename] Services Team<br><br></p>'),(36,'PAYMENT-COMPLETED-EMAIL-TO-CUSTOMER','Payment Receipt - [dba]','<table class="st-Background" bgcolor="#f6f9fc" border="0" cellpadding="0" cellspacing="0" width="100%" style="color: rgb(0, 0, 0); font-family: ''Times New Roman''; font-size: medium; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(246, 249, 252); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; border: 0px; margin: 0px; padding: 0px;">n  <tbody>n    <tr>n      <td style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px;background:rgb(211 231 255) !important;"><table class="st-Wrapper" align="center" bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" width="600" style="border-bottom-left-radius: 5px; border-bottom-right-radius: 5px; margin: 0px auto; min-width: 600px;">n          <tbody>n            <tr>n              <td style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px;"><table class="st-Preheader st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">n                  <tbody>n                    <tr></tr>n                  </tbody>n                </table>n                <div style="background-color: rgb(255, 255, 255); padding-top: 20px;height:40px;"> </div>n                <table class="st-Copy st-Copy--caption st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">n                  <tbody>n                    <tr>n                      <td class="Content Title-copy Font Font--title" align="center" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; width: 472px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(50, 50, 93); font-size: 24px; line-height: 32px;">Receipt from [dba]</td>n                    </tr>n                    <tr>n                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                  </tbody>n                </table>n                <table class="st-Copy st-Copy--caption st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">n                  <tbody>n                    <tr>n                      <td class="Content Title-copy Font Font--title" align="center" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; width: 472px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(136, 152, 170); font-size: 15px; line-height: 18px;">Transaction Id: [transID]</td>n                    </tr>n                    <tr>n                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                  </tbody>n                </table>n                <table class="st-Spacer st-Spacer--standalone st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="100%">n                  <tbody>n                    <tr>n                      <td height="20" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                  </tbody>n                </table>n                <table class="st-Copy st-Copy--standalone st-Copy--caption" border="0" cellpadding="0" cellspacing="0" width="100%">n                  <tbody>n                    <tr>n                      <td width="64" class="st-Font st-Font--caption" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; color: rgb(136, 152, 170); font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; font-size: 12px; font-weight: bold; line-height: 16px; text-transform: uppercase;"></td>n                      <td width="121" valign="top" class="DataBlocks-item" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px;"><table style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px;">n                          <tbody>n                            <tr>n                              <td class="Font Font--caption Font--uppercase Font--mute Font--noWrap" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(136, 152, 170); font-size: 12px; line-height: 16px; white-space: nowrap; font-weight: bold; text-transform: uppercase;">DATE PAID</td>n                            </tr>n                            <tr>n                              <td class="Font Font--body Font--noWrap" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px; white-space: nowrap;">[tdate]</td>n                            </tr>n                          </tbody>n                        </table></td>n                      <td width="20" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                      <td width="384" align="right" valign="top" class="DataBlocks-item" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px;"><table width="182" style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px;">n                          <tbody>n                            <tr>n                              <td class="Font Font--caption Font--uppercase Font--mute Font--noWrap" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(136, 152, 170); font-size: 12px; line-height: 16px; white-space: nowrap; font-weight: bold; text-transform: uppercase;text-align:right">PAYMENT METHOD</td>n                            </tr>n                            <tr>n                              <td class="Font Font--body Font--noWrap" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px; white-space: nowrap;text-align:right;"><span style="border:0px !important; margin:0px !important; outline:0px !important; padding:0px !important; -webkit-font-smoothing:antialiased !important; text-decoration:none !important;text-align:right; ">[card_img]�</span><span style="text-decoration:none !important; "></span></td>n                            </tr>n                          </tbody>n                        </table></td>n                      <td width="64" class="st-Font st-Font--caption" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; color: rgb(136, 152, 170); font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; font-size: 12px; font-weight: bold; line-height: 16px; text-transform: uppercase;"></td>n                    </tr>n                  </tbody>n                </table>n                <table class="st-Spacer st-Spacer--standalone st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="100%">n                  <tbody>n                    <tr>n                      <td height="32" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                  </tbody>n                </table>n                <table class="st-Copy st-Copy--caption st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">n                  <tbody>n                    <tr>n                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                      <td class="st-Font st-Font--caption" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; color: rgb(136, 152, 170); font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; font-size: 12px; line-height: 16px; text-transform: uppercase;"><span class="st-Delink" style="border: 0px; margin: 0px; outline: 0px !important; padding: 0px; text-decoration: none !important; -webkit-font-smoothing: antialiased !important; font-weight: bold;">SUMMARY</span></td>n                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                    <tr>n                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                  </tbody>n                </table>n                <table class="st-Blocks st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">n                  <tbody>n                    <tr>n                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="4" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                    <tr>n                      <td class="st-Spacer st-Spacer--kill" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                      <td style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px;"><table class="st-Blocks-inner" bgcolor="#f6f9fc" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-radius: 5px;">n                          <tbody>n                            <tr>n                              <td style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px;"><table class="st-Blocks-item" border="0" cellpadding="0" cellspacing="0" width="100%">n                                  <tbody>n                                    <tr>n                                      <td class="st-Spacer st-Spacer--blocksItemEnds" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                                    </tr>n                                    <tr>n                                      <td class="st-Spacer st-Spacer--gutter" width="16" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                                      <td class="st-Blocks-item-cell st-Font st-Font--body" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; color: rgb(82, 95, 127); font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; font-size: 16px; line-height: 24px;"><table width="100%" style="padding-left: 5px; padding-right: 5px;">n                                          <tbody>n                                            <tr>n                                              <td style="-webkit-font-smoothing: antialiased !important;"></td>n                                            </tr>n                                            <tr>n                                              <td class="Table-description Font Font--body" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px; width: 30%;">Product Name </td>n                                              <td class="Spacer Table-gap" width="8" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                                              <td class="Table-amount Font Font--body" align="right" valign="top" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px;">[product_name]</td>n                                            </tr>n                                            <tr>n                                              <td class="Table-divider Spacer" colspan="3" height="6" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                                            </tr>n                                            <tr>n                                              <td class="Table-divider Spacer" colspan="3" height="6" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                                            </tr>n                                            <tr>n                                              <td class="Table-description Font Font--body" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px; ">[descriptor_text] </td>n                                              <td class="Spacer Table-gap" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                                              <td class="Table-amount Font Font--body" align="right" valign="top" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px;">[descriptor3]</td>n                                            </tr>n                                            <tr>n                                              <td class="Table-divider Spacer" colspan="3" height="8" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                                            </tr>n                                            <tr>n                                              <td class="Table-description Font Font--body" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px;"><strong>Amount charged</strong></td>n                                              <td class="Spacer Table-gap" width="8" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                                              <td class="Table-amount Font Font--body" align="right" valign="top" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(82, 95, 127); font-size: 15px; line-height: 24px;"><strong>[amount_currency]</strong></td>n                                            </tr>n                                            <tr>n                                              <td class="Table-divider Spacer" colspan="3" height="6" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                                            </tr>n                                          </tbody>n                                        </table></td>n                                      <td class="st-Spacer st-Spacer--gutter" width="16" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                                    </tr>n                                    <tr>n                                      <td class="st-Spacer st-Spacer--blocksItemEnds" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                                    </tr>n                                  </tbody>n                                </table></td>n                            </tr>n                          </tbody>n                        </table></td>n                      <td class="st-Spacer st-Spacer--kill" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                    <tr>n                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="16" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                  </tbody>n                </table>n                <table class="st-Divider st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">n                  <tbody>n                    <tr>n                      <td class="st-Spacer st-Spacer--divider" colspan="3" height="20" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                    <tr>n                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                      <td bgcolor="#e6ebf1" height="1" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                    <tr>n                      <td class="st-Spacer st-Spacer--divider" colspan="3" height="31" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                  </tbody>n                </table>n                <table class="st-Copy st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">n                  <tbody>n                    <tr>n                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                      <td style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; font-size: 16px; line-height: 24px; color: rgb(82, 95, 127) !important;">If you have any questions, contact us at�<a href="mailto: [customer_service_email]" style="border: 0px; margin: 0px; outline: 0px !important; padding: 0px; text-decoration: none; -webkit-font-smoothing: antialiased !important; color: rgb(85, 108, 214) !important;"> [customer_service_email]</a>�[merchant_service_no_text] <a href="tel:[merchant_service_no]" style="border: 0px; margin: 0px; outline: 0px !important; padding: 0px; text-decoration: none; -webkit-font-smoothing: antialiased !important; color: rgb(85, 108, 214) !important;">[merchant_service_no]</a>.</td>n                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                    <tr>n                      <td class="st-Spacer st-Spacer--stacked" colspan="3" height="12" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                  </tbody>n                </table>n                <table class="st-Divider st-Width st-Width--mobile" border="0" cellpadding="0" cellspacing="0" width="600" style="min-width: 600px;">n                  <tbody>n                    <tr>n                      <td class="st-Spacer st-Spacer--divider" colspan="3" height="20" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                    <tr>n                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                      <td bgcolor="#e6ebf1" height="1" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                      <td class="st-Spacer st-Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                    <tr>n                      <td class="st-Spacer st-Spacer--divider" colspan="3" height="31" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px; max-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n                    </tr>n                  </tbody>n                </table>n                <table class="Section Divider Divider--small" width="100%" style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; background-color: rgb(255, 255, 255);">n                  <tbody>n                    <tr>n                      <td class="Spacer Spacer--divider" height="20" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                    </tr>n                  </tbody>n                </table>n                <table class="Section Copy" style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; background-color: rgb(255, 255, 255);">n                  <tbody>n                    <tr>n                      <td class="Spacer Spacer--gutter" width="64" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                      <td class="Content Footer-legal Font Font--caption Font--mute" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; width: 472px; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif; vertical-align: middle; color: rgb(136, 152, 170); font-size: 12px; line-height: 16px;">You are receiving this email because you made a purchase at [dba], which partners with�<a target="_blank" rel="noreferrer" href="[hostname]" style="border: 0px; margin: 0px; outline: 0px !important; padding: 0px; text-decoration: none; -webkit-font-smoothing: antialiased !important; color: rgb(85, 108, 214); font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Ubuntu, sans-serif;">[sitename]</a>�to provide invoicing and payment processing.</td>n                    </tr>n                  </tbody>n                </table>n                <table class="Section Divider Divider--small" width="100%" style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; background-color: rgb(255, 255, 255);">n                  <tbody>n                    <tr>n                      <td class="Spacer Spacer--divider" height="20" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                    </tr>n                  </tbody>n                </table>n                <table class="Section Section--last Divider Divider--large" width="100%" style="border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; background-color: rgb(255, 255, 255); border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">n                  <tbody>n                    <tr>n                      <td class="Spacer Spacer--divider" height="64" style="-webkit-font-smoothing: antialiased; border: 0px; border-collapse: collapse; margin: 0px; padding: 0px; color: rgb(255, 255, 255); font-size: 1px; line-height: 1px;">�</td>n                    </tr>n                  </tbody>n                </table></td>n            </tr>n          </tbody>n        </table></td>n    </tr>n    <tr>n      <td class="st-Spacer st-Spacer--emailEnd" height="64" style="-webkit-font-smoothing: antialiased !important; border: 0px; margin: 0px; padding: 0px; font-size: 1px; line-height: 1px;"><div class="st-Spacer st-Spacer--filler">�</div></td>n    </tr>n  </tbody>n</table>n'),(39,'MERCHANT-EMAIL-AUTHORIZATION-REQUIRED','Authorize [product_name] purchased of [amount_currency] from [dba]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;"><tbody><tr><td colspan="2" style="padding:0px;background:#fff;margin:0;"><p style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;"><b>Dear [customer_name],</b><br><br>We have received your order of <b>"[product_name]"</b> on <b>"[business_url]"</b>.<br><br>We are the payment service provider for [dba] and would like to confirm that the "[product_name]" has been purchased by you from [business_url]. Please let us know if the purchase was not made from [business-url].</p><table align="center" style="color:#666;width:100%;padding:10px 2.5%;line-height:150%;"><tbody><tr><td>[ctable1]</td></tr></tbody></table><table style="width:100%;"><tbody><tr><td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;"><p style="width:100%;padding:0px 0 10px 0;line-height:150%;">Your response will help us improve our services.</p><p style="width:100%;padding:0px 0 10px 0;line-height:150%;"><b>Sincerely,<br> [sitename]  Team</b></p></td></tr></tbody></table></td></tr></tbody></table>'),(40,'SEND-KYC(IDENTITY-VERIFICATION-REQUEST)','[sitename] - Identity Verification Request','<p style="margin: 20px 0px 0px; padding: 0px; border: 0px; vertical-align: baseline; float: left; width: 100%; background: rgb(255, 255, 255) !important;"> </p><p style="color: rgb(15, 95, 92); font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-style: normal; font-weight: 400; margin: 0px; padding: 0px 0px 15px; border: 0px; vertical-align: baseline; text-transform: uppercase; line-height: 1; font-size: 35.3333px;"><span style="color: rgb(0, 0, 0); font-size: 16px;">Date of Request: [current_date]</span></p><p style="color:rgb(0,0,0);font-size: 16px;"><br style="color:rgb(0,0,0);font-size: 16px;">Dear [fullname],<br style="color:rgb(0,0,0);font-size: 16px;"><font color="#000000" face="Helvetica Neue" style="color:rgb(0,0,0);font-size: 16px;"><span style="color:rgb(0,0,0);font-size: 16px;">Youre receiving this email from [sitename] because you have been listed as a director of the company applied for merchant account with us. </span></font></p><p></p><p class="p1" style="color: rgb(0, 0, 0); font-size: 16px;" helvetica="" neue";="" font-size:="" 12px;="" margin-bottom:="" 0px;="" font-variant-numeric:="" normal;="" font-variant-east-asian:="" font-stretch:="" normal;"="">As part of our KYC/AML compliance process, identity verification is required to protect against potential financial crime and keep the <span style="color: rgb(0, 0, 0); font-size: 16px;" helvetica="" neue";="" font-size:="" 12px;"="">[sitename] </span>network safe.</p><p class="p1" style="color: rgb(0, 0, 0); font-size: 14px;" helvetica="" neue";="" font-size:="" 12px;="" margin-bottom:="" 0px;="" font-variant-numeric:="" normal;="" font-variant-east-asian:="" font-stretch:="" normal;"=""></p><p></p> <a href="[hostname]/kyc[ex]" target="_blank" style="color: rgb(255, 255, 255) !important; font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-size: 22px; font-style: normal; font-weight: 400; float: left; margin: 30px 0px 0px; padding: 15px 60px; border: 0px; vertical-align: baseline; background: none left top repeat rgb(0, 148, 143); clear: both; text-decoration: none !important;">VERIFY IDENTITY</a> <br> <p style="color: rgb(34, 34, 34); font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-size: 14px; font-style: normal; font-weight: 400; clear: both;"><br></p><p style="color: rgb(34, 34, 34); font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-style: normal; clear: both; margin-top: 5px; font-size: 14px;"><span style="font-size:16px;color: rgb(34, 34, 34); font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-style: normal; clear: both; margin-top: 5px;">We appreciate your co-operation!</span></p> <p></p>'),(41,'2FA-ACTIVATION-RESET-REQUEST','[username] Requested 2FA Activation/Reset','<div style="float:left;background-color:#f8f5f5;width:80%;padding:10px 10%;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;"> <p style="float:left;width:100%;padding:7px 0%;margin:0;font-weight:bold;">Hello [fullname],</p><p style="float:left;width:100%;padding:7px 0%;margin:0;">We have received a request to activate/reset 2FA code for your account ([username]) with [sitename].</p><p style="float:left;width:100%;padding:7px 0%;margin:0;">Please download and configure 2FA application like Google Authenticator (iPhone/Android) as suggested below:</p><p style="float:left;width:100%;padding:7px 0%;margin:0;"><b>Download Google Authenticator</b></p><p style="float:left;width:100%;padding:7px 0%;margin:0;"><a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en" target="_blank"><img width=150 src=[hostname]/images/android.png /></a> �� <a href="https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8" target="_blank"><img src=[hostname]/images/iphone.png width=150 /></a></p><p style="float:left;width:100%;padding:7px 0%;margin:0;"><b>Configure the App</b></p><p style="float:left;width:100%;padding:7px 0%;margin:0;">Open 2FA application and add your account by scanning the QR code.</p><p style="float:left;width:100%;padding:7px 0%;margin:0;"><img src=[text5] /></p><p style="float:left;width:100%;padding:7px 0%;margin:0;">If QR code not scanned please enter this text code:</p><p style="float:left;width:100%;padding:7px 0%;margin:0;">[text6]</p><p style="float:left;width:100%;padding:7px 0%;margin:0;">Now, 2FA activated to use.</p><p style="float:left;width:100%;padding:7px 0%;margin:0;">Please note enter a 2FA code every time to access your account.</p><p style="float:left;width:100%;padding:7px 0%;margin:0;margin:0;">Thank you for your patience!</p><p style="float:left;width:100%;padding:7px 0%;margin:0;">Sincerely,<br>[sitename] Team</p></div>'),(42,'BANK-GATEWAY-INACTIVATED','Internal - Inactive acquirer [bank_name] from [hostname]','<p>Acquirer [bank_name] inactive from [hostname] due to <b style="font-style:italic">Maximum Continuously Failed Transactions</b>.</p>'),(43,'CONFIRM-RESET-PASSWORD','Reset Password','<p style="text-align:left;">Dear <b>[username]</b></p><p style="text-align:left;">A request has been received to change your [sitename] account.</p><p style="text-align:left;border-bottom:2px solid #00948f;padding:0px;margin:0px;height:2px;"> </p><p style="text-align:left;padding:20px 0 0 0;">To reset your password, click on the button below:</p><a style="float:unset;width:310px;display:block;color:rgb(255, 255, 255)!important; font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:22px;font-style: normal;font-weight:400;margin:20px auto 10px auto;padding:10px 30px;border:0px; vertical-align:baseline;background:none left top repeat rgb(0, 148, 143);clear:both;text-decoration:none !important;border-radius:7px;text-align:center;" target="_blank" href="[resetpasswordurl]?c=[confcode]">Reset Password</a><p>Or copy and paste the URL into your browser:</p><p><b>[resetpasswordurl]?c=[confcode]</b></p><p style="text-align:left;border-bottom:2px solid #00948f;padding:0px;margin:20px 0 0 0px;height:2px;"> </p><p style="text-align:left;margin:30px 0 0 0;">Please note that the link will be valid for next 1 hour.</p><p style="text-align:left;padding-top:30px;">Sincerely,</p><p><b>[sitename]</b> Team</p>'),(44,'PAYMENT-FAILED-EMAIL-TO-CUSTOMER','Payment Rejected - [dba]','<table width="100%" align="center" style="width:100%;margin:0;padding:0;color:#000;font-size:14px;font-family:arial,sans-serif;line-height:150%;"><tbody><tr><td colspan="2" style="padding:0px;background:#fff;margin:0;"><p style="float:left;background-color:#fff0b3;width:95%;padding:10px 2.5%;"><b>Dear [customer_name],</b><br><br>rn          We regret to inform you that your payment has been failed for below mentioned order placed on [dba] - [business_url].<br></p>rn<table align="center" style="color:#666;width:100%;padding:10px 2.5%;line-height:150%;"><tbody><tr><td>[ctable1]</td></tr></tbody></table>rn<table style="width:100%;"><tbody><tr><td style="color:#000;width:100%;padding:10px 2.5%;background-color: #fff0b3;"><p style="width:100%;padding:0px 0 10px 0;line-height:150%;">Please update your credit card or contact your bank/card issuer for further information.</p><p style="width:100%;padding:0px 0 10px 0;line-height:150%;"><b>Sincerely,<br/> [sitename]  Team</b></p></td></tr></tbody></table></td></tr></tbody></table>'),(45,'PAYMENT-FAILED-EMAIL-TO-MERCHANT','Payment Rejected for [dba] - [bussiness_url] - [descriptor2]','<div style="float:left;width:90%;padding:2% 5%;line-height:150%;background-color:#f5d8d8;color:#000;font-family:arial,sans-serif;border:4px solid #e2e2e2;"><p>We regret to inform you that your transaction has been rejected for below mentioned order placed on [dba] - [business_url].</p><p><b>Please look at the below transaction details:</b></p>[ctable2]<p><br>[text6] You can access your account anytime at: [hostname]</p><p><br>Sincerely,</p><p>[sitename] Team</p><p></div>'),(46,'SEND-QR-CODE','Generated QR Code','<p>Dear [fullname], <br></p><p>� QR Code Generated<br></p><p>Sincerely,<br></p><p>[sitename] Team</p><p><br></p><p></p><p></p><p></p><p></p><a href="[bussiness_url]" target="_blank"><b>Download QR Code</b></a><br><p><br></p>'),(47,'NOTIFY_SUBADMIN_MISSIGN_CALCULATION','calculation',''),(48,'SEND-PAYMENT-LINK','Payment Link for [customer_email] Amount: [currency_amount] by [company_name] Generated on [current_date]','<div  style="border: 3px solid; border-radius: 15px; padding:10px; border-color:#CCCCCC;">rn  <div  style="display:flex;margin-top:1rem;margin-bottom:1rem;">rn    <div style="margin-right:auto;padding:0.5rem;"><strong style=" font-weight: bolder;">[company_name]</strong><br style="">rn      [registered_address]</div>rn    <div style="padding:0.5rem;font-size:31px;">Payment Link</div>rn  </div>rn  <div  style="display:flex;margin-bottom:1rem;">rn    <div style="margin-right:auto;padding:0.5rem;"></div>rn    <div  style="padding:0.5rem;"><strong style="font-weight:bolder;">Amount: </strong>&nbsp;&nbsp;[currency_amount]<br style="">rn      <strong style="font-weight:bolder;">Date: </strong>&nbsp;[current_date]</div>rn  </div>rn  <hr style="margin:1rem 0px;color:inherit;background-color:currentcolor;border:0px;opacity:0.25;height:1px;">rn  rn  <div  style="margin-top:30px;margin-bottom:25px;text-align:center;"><a href="[payUrl]" target="_blank" style="display:inline-block;padding:10px;border-radius:20px;width:345px;background-color:[background_gd4];color:[root_text_color]; text-decoration:none;">Pay Now</a></div>rn  <hr style="margin:1rem 0px;color:inherit;background-color:currentcolor;border: 0px;opacity:0.25;height:1px;">rn  <div  style="margin:5px;text-align:right;"><strong style="font-weight:bolder;">Powered by</strong>&nbsp;- [sitename]</div>rn  <div style="margin-top:0.5rem;margin-bottom:5px;text-align:center;color:rgb(108, 117, 125);font-size:10px;">this is computer generated invoice no signature required</div>rn</div>'),(49,'SEND-QR-CODE-PAYMENT','QR Code Payment for [customer_email] by [company_name] Generated on [current_date]','<div style="border: 3px solid; border-radius: 15px; padding:10px; border-color:#CCCCCC;"> <div  style="display:flex;margin-top:1rem;margin-bottom:1rem;"> <div style="margin-right:auto;padding:0.5rem;"> <strong style=" font-weight: bolder;">Hi, [customer_email]</strong> </div> </div> <hr style="margin:1rem 0px;color:inherit;background-color:currentcolor;border:0px;opacity:0.25;height:1px;"> <div  style="margin-top:0px;margin-bottom:5px;text-align:center;"> <img src="[payUrl]" title="Scan QR Code" /> </div> <hr style="margin:1rem 0px;color:inherit;background-color:currentcolor;border: 0px;opacity:0.25;height:1px;"> <div style="text-align: left; line-height:170%"> From : <br /> <strong style="font-weight:bolder;">[fullname]</strong> <br /> [company_name]  <br /> [registered_address] </div> <div style="margin:5px;text-align:right;float:right;position:relative;top:-36px;"> <strong style="font-weight:bolder;">Powered by</strong>&nbsp;- [sitename]</div> </div>'),(50,'SEND-INVOICE-PAYMENT-LINK','Invoice [create_number] for [product_name] by [company_name] Generated on [current_date]','<div  style="border: 3px solid; border-radius: 15px; padding:10px; border-color:#CCCCCC;"> <div  style=" display: flex ; margin-top: 1rem ; margin-bottom: 1rem ;"> <div style=" margin-right: auto ; padding: 0.5rem ;"> <strong style=" font-weight: bolder;">[company_name]</strong> <br style=""> [ctable1]</div> <div style=" padding: 0.5rem ; font-size: 1.75rem ;">Invoice</div> </div> <div  style=" display: flex ; margin-bottom: 1rem ;"> <div style=" margin-right: auto ; padding: 0.5rem ;"> <strong style=" font-weight: bolder;">Bill To</strong> <br style=""> [ctable2]</div> <div  style=" padding: 0.5rem ;"> <strong style=" font-weight: bolder;">Invoice No&nbsp;&nbsp;&nbsp;&nbsp;#</strong>&nbsp;&nbsp;[create_number]<br style=""> <strong style=" font-weight: bolder;">Invoice Date #</strong>&nbsp;[current_date]</div> </div> <hr style="margin: 1rem 0px; color: inherit; background-color: currentcolor; border: 0px; opacity: 0.25; height: 1px;" > <div style=" margin-top: 0.5rem ; margin-bottom: 0.5rem ; padding: 0.5rem ;"> <table width="100%" style=" border-collapse: collapse;"> <tbody style=" border-color: inherit; border-style: solid; border-width: 0px; vertical-align: inherit;"> <tr  style="background-color: #e4e5e7;"> <td width="75%" style=" border-color: #dee2e6; border-style: solid; border-width: 0px 0px 1px; padding: 0.5rem;"> <strong style=" font-weight: bolder;">Description</strong> </td> <td width="25%" style=" border-color: #dee2e6; border-style: solid; border-width: 0px 0px 1px; padding: 0.5rem;"> <strong style=" font-weight: bolder;">Amount</strong> </td> </tr> <tr style=" border-color: inherit; border-style: solid; border-width: 0px;"> <td style=" border-color: rgb(222,226,230);border-style: solid;border-width: 0px 0px 1px;padding: 0.5rem;">[product_name]</td> <td style="border-color: rgb(222,226,230);border-style: solid;border-width: 0px 0px 1px;padding: 0.5rem;">[currency_amount]</td> </tr> </tbody> </table> <table width="50%" align="right"  style=" border-collapse: collapse;"> <tbody style=" border-color: inherit; border-style: solid; border-width: 0px; vertical-align: inherit;"> [ctable3] <tr  style=" border-color: inherit; border-style: solid; border-width: 0px;"> <td width="50%" style=" border-color: #dee2e6; border-style: solid; border-width: 0px 0px 1px; padding: 0.5rem;"> <strong style=" font-weight: bolder;">Total :</strong> </td> <td width="50%" style=" border-color: #dee2e6; border-style: solid; border-width: 0px 0px 1px; padding: 0.5rem;">[currency_total_amount]</td> </tr> </tbody> </table> </div> <div  style=" margin-top: 80px; margin-bottom: 10px ; text-align: center ; "> <a href="[payUrl]" target="_blank" style="display: inline-block;padding: 10px;border-radius: 20px;width: 345px;background-color:[background_gd4];color:[root_text_color]; text-decoration:none;">Pay Now</a> </div> <hr style=" margin: 1rem 0px; color: inherit; background-color: currentcolor; border: 0px; opacity: 0.25; height: 1px;"> [ctable4] [ctable5]  <div  style="margin: 5px ; text-align: right ;"> <strong style=" font-weight: bolder;">Powered by</strong>&nbsp;- [sitename]</div> <div style=" margin-top: 0.5rem ; margin-bottom: 5px ; text-align: center ; color: rgb(108, 117, 125) ; font-size: 10px;">this is computer generated invoice no signature required</div> </div>rnrn');
 
 
 INSERT INTO zt_terminal (id, "merID", public_key, "acquirerIDs", bussiness_url, ter_name, terminal_type, business_description, business_nature, active, tarns_alert_email, mer_trans_alert_email, dba_brand_name, customer_service_no, customer_service_email, merchant_term_condition_url, merchant_refund_policy_url, merchant_privacy_policy_url, merchant_contact_us_url, merchant_logo_url, curling_access_key, "terNO_json_value", select_templates, select_templates_log, json_log_history, deleted_bussiness_url, checkout_theme, select_mcc, webhook_url, return_url) VALUES
(475, '272', 'MjcyXzQ3NV8yMDIyMDIwNDEyMzk1NA', '53,534,531,532,533,535', 'MERCHANT WEBSITE', 'MERCHANT WEBSITE', '', '', 'MERCHANT WEBSITE', 1, '007,001,004,002', '', 'MERCHANT WEBSITE', '', '', '', '', '', '', '', '', '{"store_json":{"53":"","534":"","531":"","532":"","533":"","535":""}}', 20, '[{"tm_user":"Admin","tm_date":"2022-02-04 12:42:25 PM","tm_log":{"pre_created":"","pre_created_nm":"","new_created":"534,535,533,532,531,53","new_created_nm":"EMICF,WLTCF,DCCF,UPICF,NBCF,CCCF","un_created":"","un_created_nm":"","add_template":"20"}}]', NULL, '["MERCHANT WEBSITE"]', '', NULL, '', ''),
(476, '272', 'MjcyXzQ3Nl8yMDIyMDIxMTE1MzQyMg', '63,631,632', 'RazorPay', 'RazorPay', '', '', 'RazorPay', 1, '007,001,004,002', '{"decrypt":"ODJLMUJSVVl5NURqOWRjQ0tuSnRKcnVXTmdJT2kwbE5Nb0VhSE5KU3c5dz0","key":"1"}', 'RazorPay', '', '{"decrypt":"dmU5Nkl0cXlvWW81VE5HOGNZTFdCVkZFTEZlUVJZNHVzaWlIWFRXdHBmOD0","key":"1"}', '', '', '', '', '', '', '{"store_json":{"63":"","631":"","632":""},"store_json_curl":"[]"}', 24, '[{"tm_user":"Admin","tm_date":"2022-02-11 15:24:37 PM","tm_log":{"pre_created":"","pre_created_nm":"","new_created":"632,631,63","new_created_nm":"Razorpay UPI,Razorpay Net Banking,Razorpay Credit/Debit Card","un_created":"","un_created_nm":"","add_template":"24"}}]', NULL, '["RazorPay"]', '', '', '', ''),
(492, '272', 'MjcyXzQ5Ml8yMDIyMDQyMDE3MjExNA', '642,643,645,647,641,64,65', 'payu', '64-65 Test', '', '', 'Payu', 1, '', '', '', '', '', '', '', '', '', '', '', '{"store_json":{"642":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"643":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"645":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"647":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"641":"","64":"","65":{"merchant_id":"202204090003","merchant_key":"uMdQSdqujtIHsnq7gWFiKOciNWp+bDV+ebFMz6AQXu8="}}}', 25, '[{"tm_user":"Admin","tm_date":"2022-04-20 17:21:36 PM","tm_log":{"pre_created":"","pre_created_nm":"","new_created":"64,641,642,65","new_created_nm":",,,","un_created":"","un_created_nm":"","add_template":"25"}}]', NULL, '["payu"]', '', '', '', ''),
(493, '272', 'MjcyXzQ5M18yMDIyMDUwNTE3NDg0NA', '67,671,672,673,66,661,662,663', '66 - 663 Grez', '66 - 67', '', '', '66 - 663 Grez', 1, '001,004,002', '', '66 - 663 Grez', '', '', '', '', '', '', '', '', '{"store_json":{"67":{"app_id":"2204251500113672","salt_key":"8b81f094b123493d"},"671":{"app_id":"2204251500113672","salt_key":"8b81f094b123493d"},"672":{"app_id":"2204251500113672","salt_key":"8b81f094b123493d"},"673":{"app_id":"2204251500113672","salt_key":"8b81f094b123493d"},"66":{"app_id":"2460220422130454","salt_key":"f53445fbdb26416f"},"661":{"app_id":"2460220422130454","salt_key":"f53445fbdb26416f"},"662":{"app_id":"2460220422130454","salt_key":"f53445fbdb26416f"},"663":{"app_id":"2460220422130454","salt_key":"f53445fbdb26416f"}}}', 26, '[{"tm_user":"Admin","tm_date":"2022-05-05 17:48:55 PM","tm_log":{"pre_created":"","pre_created_nm":"","new_created":"66,661,662,663","new_created_nm":"Grezpay Credit Card,Grezpay Net Banking,Grezpay UPI,Grezpay eWallets","un_created":"","un_created_nm":"","add_template":"26"}}]', NULL, '["66 - 663 Grez"]', 'clk', NULL, '', ''),
(494, '272', 'MjcyXzQ5NF8yMDIyMDUxMzE3MTkyOQ', '671,673', 'Dasspe.com', 'Dasspe', '', '', 'Dasspe', 1, '', '', '', '', '', '', '', '', '', '', NULL, '{"store_json":{"671":{"app_id":"2204251500113672","salt_key":"8b81f094b123493d"},"673":{"app_id":"2204251500113672","salt_key":"8b81f094b123493d"}}}', NULL, NULL, NULL, NULL, '', NULL, '', ''),
(506, '272', 'MjcyXzUwNl8yMDIyMDgxOTEwMjY0NQ', '642,643,644,645,647,641,64', 'PayU', 'PayU', '', '', 'PayU', 1, '', '', 'PayU', '', '', '', '', '', '', '', '', '{"store_json":{"642":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"643":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"644":"","645":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"647":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"641":"","64":""}}', NULL, NULL, NULL, '["PayU"]', '', '', '', ''),
(537, '272', 'MjcyXzUzN18yMDIyMTIwMTEzMDQyNA', '69', 'icici.com', '69 ICICI UPI Payment', '', '', '', 1, '001', '', '', '', '', '', '', '', '', '', '69', '{"terNO_json":{"69":{"vpa":"skywalkletspe.lp@icici","merchantId":"2218627"}}}', NULL, NULL, NULL, '["icici.com"]', 'OPAL_NS', '1111', '', ''),
(547, '272', 'MjcyXzU0N18yMDIzMDIxMzE0NTE1OQ', '', '84 PayThru - UP & QrCode', '84 PayThru - UP & QrCode', '', '', '84 PayThru - UP & QrCode', 0, '', '', '84 PayThru - UP & QrCode', '', '', '', '', '', '', '', NULL, '[]', NULL, NULL, NULL, NULL, '', '', '', ''),
(609, '272', 'MjcyXzYwOV8yMDIzMDYyNDExMDc0Ng', '72', '72 Iserve  UPI Payment', '72 Iserve UPI', '', '', '', 1, '001', '', '', '', '', '', '', '', '', '', '', '{"terNO_json":{"72":{"client_id":"dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez","client_secret":"I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7hBX","payerAccount":"","payerIFSC":"","payerBank":"","requestingUserName":"rariotest"}},"terNO_json_curl":{"IBL-Client-Id":"764d7dd1ed959c7f5735f294aae9750f","IBL-Client-Secret":"c59862be0b625fc3a8a39b8194724451","CustomerTenderId":"AMPLE","channelId":"IND","Account-name":"AMPLE FINLEASE PRIVATE LIMITED","Account-ifsc":"INDB0000588","Account-number":"ZAMPLE","pgMerchantId":"AR7311234313793549"}}', NULL, NULL, NULL, '["72 Iserve  UPI Payment"]', 'OPAL_IND_UX', '', '', ''),
(610, '272', 'MjcyXzYxMF8yMDIzMDYyNDE0MjY0OQ', '38,381,382,383', '38 PayU Card & UPI ', '38 PayU Card & UPI ', '', '', '', 1, '001', '', '', '', '', '', '', '', '', '', '', '{"terNO_json":{"38":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"381":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"382":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"},"383":{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"}},"terNO_json_curl":"[]"}', 4, '[{"tm_user":"Admin","tm_date":"2023-06-24 14:27:05 PM","tm_log":{"pre_created":"","pre_created_nm":"","new_created":"38,381,382,383","new_created_nm":"PayU Card Payment,payU,QrCode-payU,payU-ewallets","un_created":"","un_created_nm":"","add_template":"4"}}]', NULL, '["38 PayU Card & UPI "]', 'IND', '', '', ''),
(611, '272', 'MjcyXzYxMV8yMDIzMDcxMjE4NDQxMw', '71,711', '71, 711 - Collect & BT', '71, 711 - Collect & BT', '', '', '', 1, '', '{"decrypt":"a213ck1aclYrTVM2M0ZjRktpeXFhUT09","key":"1"}', '', '', '{"decrypt":"ZEVtOEdIN2FqNTU1R1locTFUbmhudz09","key":"1"}', '', '', '', '', '', '', '{"terNO_json":{"71":"","711":""}}', NULL, NULL, NULL, '["71, 711 - Collect & ICE","71, 711 - Collect & BT"]', 'OPAL_IND_UX', '', '', ''),
(612, '272', 'MjcyXzYxMl8yMDIzMDgxNDE3NTY0Ng', '27', '27 - 2D Card Payment', '27 - 2D Card Payment', '', '', '', 1, '001', '', '', '', '', '', '', '', '', '', '', '{"terNO_json":{"27":{"visa":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"mastercard":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"jcb":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"amex":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"}}},"terNO_json_curl":{"visa":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"mastercard":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"jcb":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"amex":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"}}}', NULL, NULL, NULL, '["27 - 2D Card Payment"]', 'OPAL_NS', '', '', ''),
(613, '272', 'MjcyXzYxM18yMDIzMDgzMDE1NDExNA', '44', '44 - 2D Card Payment for flutter wave', '44 - 2D Card Payment for flutter wave', 'Website,Mobile App,Display QR', '', '', 1, '001', '', '44 - 2D Card Payment for flutter wave', '', '', '', '', '', '', '', NULL, '{"terNO_json":{"44":{"PublicKey":"FLWPUBK-532a72a10035679d168b4d32d753915a-X","SecretKey":"FLWSECK-9bf324b2aa99a3ca022b4ac10a330abb-X","EncryptionKey":"9bf324b2aa99160843818870"}},"terNO_json_curl":{"PublicKey":"FLWPUBK-532a72a10035679d168b4d32d753915a-X","SecretKey":"FLWSECK-9bf324b2aa99a3ca022b4ac10a330abb-X","EncryptionKey":"9bf324b2aa99160843818870"}}', NULL, NULL, NULL, NULL, '', '', '', ''),
(614, '272', 'MjcyXzYxNF8yMDIzMDkxMTEwMjAxNg', '46', '46 Card Payment - Finvert ', '46 Card Payment - Finvert ', 'Website,Mobile App', '', '46 Card Payment - Finvert ', 1, '001', '', '46 Card Payment - Finvert ', '', '', '', '', '', '', '', NULL, '{"terNO_json":{"46":{"apiKey":"254|JvQ42xbfGuAQ5wcCOKcHX24hHjpJ7w68nORgMhVG"}},"terNO_json_curl":{"apiKey":"254|JvQ42xbfGuAQ5wcCOKcHX24hHjpJ7w68nORgMhVG"}}', NULL, NULL, NULL, NULL, '', '', '', ''),
(615, '272', 'MjcyXzYxNV8yMDIzMDkxMjE2MzQyNg', '781,78', 'Evok QrCode ', '78 Evok QrCode - Intent & collect ', '', '', '', 1, '001', '', '', '', '', '', '', '', '', '', '', '{"terNO_json":{"781":{"source":"SPAYFIN001","extTransactionId":"spayfin","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"58d915f30f0e4421b90ca903c97859e6","key":"e76c6205bc4b46a0a4c3301c94587e9a","Checksum_key":"c0019ec9cb994345a8a180d377ba6f4a"},"78":{"source":"SPAYFIN001","extTransactionId":"spayfin","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"58d915f30f0e4421b90ca903c97859e6","key":"e76c6205bc4b46a0a4c3301c94587e9a","Checksum_key":"c0019ec9cb994345a8a180d377ba6f4a"}},"terNO_json_curl":{"source":"SPAYFIN001","extTransactionId":"spayfin","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"58d915f30f0e4421b90ca903c97859e6","key":"e76c6205bc4b46a0a4c3301c94587e9a","Checksum_key":"c0019ec9cb994345a8a180d377ba6f4a"}}', NULL, NULL, NULL, '["Evok QrCode "]', '', '', '', ''),
(616, '272', 'MjcyXzYxNl8yMDIzMDkxMzExMzMwMA', '782', '782 All UPI Payment', '782 All UPI Payment', '', '', '', 1, '001', '', '782 All UPI Payment', '', '', '', '', '', '', '', NULL, '{"terNO_json":{"782":{"sid":"SKYWA-0700"}},"terNO_json_curl":{"sid":"SKYWA-0700"}}', NULL, NULL, NULL, NULL, '', '', '', ''),
(617, '272', 'MjcyXzYxN18yMDIzMDkxMzE2MDM0Mw', '42', '42 Kapopay - Visa & Master Card ', '42 Kapopay - Visa & Master Card ', '', '', '', 1, '001', '', '42 Kapopay - Visa & Master Card ', '', '', '', '', '', '', '', NULL, '{"terNO_json":{"42":{"AccountId":" 4017","ShopId":"50022","Key":"1adf1158f43a4e9cf56116176a02afe5","Pass":"64df892319fe7"}},"terNO_json_curl":{"AccountId":" 4017","ShopId":"50022","Key":"1adf1158f43a4e9cf56116176a02afe5","Pass":"64df892319fe7"}}', NULL, NULL, NULL, NULL, '', '', '', ''),
(618, '272', 'MjcyXzYxOF8yMDIzMDkyMzE2NDMyNA', '12', '12 AdvCash', '12 AdvCash', '', '', '', 1, '001', '', '12 AdvCash', '', '', '', '', '', '', '', '', '{"terNO_json":{"12":{"sci_name":"website scI adv","api_token":"2c8dc6bccd04b1ca81fd2ce69898d50d9a42a303bc53021a2466b6e6b51905cc"}},"terNO_json_curl":{"sci_name":"website scI adv","api_token":"2c8dc6bccd04b1ca81fd2ce69898d50d9a42a303bc53021a2466b6e6b51905cc"}}', NULL, NULL, NULL, '["12 AdvCash"]', '', '', '', ''),
(619, '272', 'MjcyXzYxOV8yMDIzMDkyMzE2NDM1Mg', '13', '13 Coinbase ', '13 Coinbase ', '', '', '', 1, '001', '', '13 Coinbase ', '', '', '', '', '', '', '', NULL, '{"terNO_json":{"13":{"apikey":"17a54646-a17c-4e2d-8333-ad542a71f7aa"}},"terNO_json_curl":{"apikey":"17a54646-a17c-4e2d-8333-ad542a71f7aa"}}', NULL, NULL, NULL, NULL, '', '', '', ''),
(620, '272', 'MjcyXzYyMF8yMDIzMDkyMzE2NDQ0Mg', '11', '11 Binance pay-ewallets', '11 Binance pay-ewallets', '', '', '', 1, '001', '', '11 Binance pay-ewallets', '', '', '', '', '', '', '', NULL, '{"terNO_json":{"11":{"merchantId":"372670166","apikey":"dishfccow4jfel4popzeus4osdw7jbozyszn6jlcyzbnja6z4js89dbwt1c1uwdt","secretkey":"9pglflvhhvphs3tdgjskzvxconmjlug5f1apro7tws9rbw8odrelsd3swjnvn376"}},"terNO_json_curl":{"merchantId":"372670166","apikey":"dishfccow4jfel4popzeus4osdw7jbozyszn6jlcyzbnja6z4js89dbwt1c1uwdt","secretkey":"9pglflvhhvphs3tdgjskzvxconmjlug5f1apro7tws9rbw8odrelsd3swjnvn376"}}', NULL, NULL, NULL, NULL, '', '', '', ''),
(621, '272', 'MjcyXzYyMV8yMDIzMDkzMDEyNTI1MA', '122', '122 - TetherCoin - WA', '122 - TetherCoin - WA', '', '', '', 1, '001', '', '122 - TetherCoin - WA', '', '', '', '', '', '', '', NULL, '{"terNO_json":{"122":""}}', NULL, NULL, NULL, NULL, '', '', '', ''),
(622, '272', 'MjcyXzYyMl8yMDIzMTAxNDE1NDMxMw', '47', '47- ZOOK - WA', '47- ZOOK - WA', '', '', '', 1, '001', '', '47- ZOOK - WA', '', '', '', '', '', '', '', NULL, '{"terNO_json":{"47":{"merchant_key":"$2y$10$IUqBU18PFNw1xC4/jxzWmOVGkNrYlD62E.r2ZfeCVtnckZNUZp9ti"}},"terNO_json_curl":{"merchant_key":"$2y$10$IUqBU18PFNw1xC4/jxzWmOVGkNrYlD62E.r2ZfeCVtnckZNUZp9ti"}}', NULL, NULL, NULL, NULL, '', '', '', ''),
(623, '272', 'MjcyXzYyM18yMDIzMTEwMzEzMDM1NA', '48,481,482,483', '48 EaseBuzz', '48 EaseBuzz', '', '', '', 1, '001', '', '', '', '', '', '', '', '', '', '', '{"terNO_json":{"48":"","481":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"482":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"},"483":{"salt":"DGOWXA1QBO","key":"QOD594EXO8"}}}', 8, '[{"tm_user":"Admin","tm_date":"2023-11-03 13:04:17 PM","tm_log":{"pre_created":"","pre_created_nm":"","new_created":"48,481,482,483","new_created_nm":"Easebuzz,Easebuzz,Easebuzz,Easebuzz CC","un_created":"","un_created_nm":"","add_template":"8"}},{"tm_user":"Admin","tm_date":"2023-11-03 13:04:21 PM","tm_log":{"pre_created":"48,481,482,483","pre_created_nm":"Easebuzz,Easebuzz,Easebuzz,Easebuzz CC","new_created":"","new_created_nm":"","un_created":"","un_created_nm":"","add_template":"8"}},{"tm_user":"Admin","tm_date":"2023-11-03 13:04:28 PM","tm_log":{"pre_created":"48,481,482,483","pre_created_nm":"Easebuzz,Easebuzz,Easebuzz,Easebuzz CC","new_created":"","new_created_nm":"","un_created":"","un_created_nm":"","add_template":"8"}}]', NULL, '["48 EaseBuzz"]', '', '', '', '');




INSERT INTO "zt_mer_setting" ("id", "sponsor", "merID", "acquirer_id", "acquirer_processing_mode", "mdr_rate", "txn_fee_success", "reserve_rate", "min_limit", "max_limit", "scrubbed_period", "trans_count", "monthly_fee", "virtual_fee", "acquirer_processing_currency", "acquirer_processing_json", "charge_back_fee_1", "charge_back_fee_2", "charge_back_fee_3", "moto_status", "cbk1", "settelement_delay", "encrypt_email", "checkout_label_web", "checkout_label_mobile", "refund_fee", "mdr_visa_rate", "mdr_mc_rate", "mdr_jcb_rate", "mdr_amex_rate", "mdr_range_rate", "mdr_range_type", "mdr_range_amount", "reserve_delay", "txn_fee_failed", "tr_scrub_success_count", "tr_scrub_failed_count", "acquirer_display_order", "json_log_history", "salt_id", "scrubbed_json", "gst_rate", "assignee_type") VALUES
(10, 21, 272, '841', 3, '3.80', '0.08', '10', '1', '500', '1', '7', '', '', 'INR', '{"MerchantId":"4583842","subMerchantId":"4583842","terminalId":"5816","MerchantName":"Virtual Block Innovations Private Limited","MerchantVPA":"virtual.py@icici"}', '15', '45', '100', '', '45', '1', '', 'QrCode', 'UPI', '15', '', '', '', '', '', '', '', '360', '0.00', '2', '5', 13, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '', 1),
(48, 21, 272, '78', 1, '4.35', '0.05', '0.00', '1', '500', '1', '7', '', '0.00', 'INR', '{"source":"SPAYFIN001","extTransactionId":"spayfin","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"58d915f30f0e4421b90ca903c97859e6","key":"e76c6205bc4b46a0a4c3301c94587e9a","Checksum_key":"c0019ec9cb994345a8a180d377ba6f4a"}', '15', '45', '100', '', '200', '1', '', 'NPS UPI', '', '10', '', '', '', '', '', '', '', '90', '0.00', '2', '5', 4, NULL, '', 'null', '18.00', 1),
(51, 21, 272, '27', 1, '5.50', '0.80', '10', '1', '500', '1', '7', '', '', 'USD', '{"visa":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"mastercard":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"jcb":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"},"amex":{"merNO":"431888","terNO":"88866","hash":"61b4235855cf41cc938def7ff1bb8a77","merMgrURL":"www.briskmarkets.com"}}', '55', '70', '100', '', '45', '0.00', '', '27 - 2D - Visa, MasterCard, JCB, AMEX', '', '15', '', '', '', '', '', '', '', '210', '0.00', '2', '5', 5, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18.00', 1),
(52, 21, 272, '781', 1, '2.8', '0.00', '0.00', '1', '700', '1', '7', '', '', 'INR', '{"source":"SPAYFIN001","extTransactionId":"spayfin","terminalId":"SPAYFIN001-001","sid":"SPAYFIN001-001","Encryption_key":"58d915f30f0e4421b90ca903c97859e6","key":"e76c6205bc4b46a0a4c3301c94587e9a","Checksum_key":"c0019ec9cb994345a8a180d377ba6f4a"}', '15', '45', '100', '', '15', '1', '', '781 QR Code', '781 UPI Intent', '10', '', '', '', '', '', '', '', '120', '0.00', '2', '5', 1, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"700","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18.00', 1),
(53, 21, 272, '84', 1, '4.50', '0.08', '10', '1', '500', '1', '7', '', '', 'INR', '{"MerchantId":"5208680","subMerchantId":"5208680","terminalId":"5816"}', '15', '45', '100', '', '45', '1', '', 'UPI Payment', '', '15', '', '', '', '', '', '', '', '180', '0.00', '2', '5', 3, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18.00', 1),
(54, 21, 272, '31', 1, '3.80', '0.08', '10', '100', '500', '1', '25', '', '', 'INR', '{"email":"Carl@step2pay.com","password":"Carl@2023"}', '15', '45', '100', '', '45', '1', '', '31 QrCode', 'UPI', '15', '', '', '', '', '', '', '', '360', '0.00', '10', '15', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"100","max_limit":"500","tr_scrub_success_count":"10","tr_scrub_failed_count":"15"}}', '18.00', 1),
(56, 21, 272, '69', 1, '4.50', '0.08', '10', '1', '500', '1', '7', '', '', 'INR', 'ICICI QR', '15', '45', '100', '', '45', '1', '', '69 Qr-Code Scan', 'vimPhonePeGpayPaytm', '15', '', '', '', '', '', '', '', '180', '0.00', '2', '5', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18.00', 1),
(57, 21, 272, '691', 1, '4.50', '0.08', '10', '1', '500', '1', '7', '', '', 'INR', 'ICICI Collect', '15', '45', '100', '', '45', '1', '', '691 ICICI Collect', '', '15', '', '', '', '', '', '', '', '180', '0.00', '2', '5', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18.00', 1),
(58, 21, 272, '35', 1, '3.80', '0.08', '0.00', '1', '500', '1', '7', '', '', 'INR', '{"username":"Ashu","password":"12345678"}', '0.00', '0.00', '100', '', '45', '1', '', '35 QrCode', '35 UPI Intent', '15', '', '', '', '', '', '', '', '0.00', '0.00', '2', '5', 32, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18.00', 1),
(59, 21, 272, '371', 1, '3.80', '0.08', '0.00', '1', '500', '1', '7', '', '', 'INR', '{"IBL-Client-Id":"764d7dd1ed959c7f5735f294aae9750f","IBL-Client-Secret":"c59862be0b625fc3a8a39b8194724451","CustomerTenderId":"AMPLE","channelId":"IND","Account-name":"AMPLE FINLEASE PRIVATE LIMITED","Account-ifsc":"INDB0000588","Account-number":"ZAMPLE","pgMerchantId":"AR7311234313793549"}', '15', '45', '100', '', '45', '1', '', '371 UPI Collect', '371 UPI', '15', '', '', '', '', '', '', '', '0.00', '0.00', '2', '5', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18.00', 1),
(60, 341, 272, '72', 1, '4.50', '0.08', '10', '1', '500', '1', '7', '', '', 'INR', '{"client_id":"dS513JP9AXxUJ3sxmmy3QSnvcjtHBtDHlmJnngb5TmarwLez","client_secret":"I9N5FtOZGc20AW0cZNtYPkGUpDZOOE5HUky8qXcclUNEUU9WkApYSXacVABB7hBX","payerAccount":"","payerIFSC":"","payerBank":"","requestingUserName":"rariotest"}', '15', '45', '100', '', '45', '1', '', '72 UPI Payment', '72 UPI Payment', '15', '', '', '', '', '', '', '', '180', '0.00', '2', '5', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18', 1),
(61, 341, 272, '38', 1, '2.8', '0', '0.00', '1', '500', '1', '7', '', '0.00', 'INR', '{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"}', '15', '45', '100', '', '200', '1', '', 'Card Payment', '', '15', '', '', '', '', '', '', '', '90', '0.00', '2', '5', 4, NULL, '', 'null', '18.00', 1),
(62, 341, 272, '381', 1, '3.8', '0.08', '0.00', '1', '500', '1', '7', '', '0.00', 'INR', '{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"}', '15', '45', '100', '', '45', '1', '', 'PayU', 'netbanking', '15', '', '', '', '', '', '', '', '0.00', '0.00', '2', '5', 32, NULL, '', 'null', '18.00', 1),
(63, 341, 272, '382', 1, '3.8', '0.08', '0.00', '1', '100000', '1', '7', '', '0.00', 'INR', '{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"}', '0.00', '0.00', '100', '', '45', '1', '', '382 - UPI Payment - Make a payment to 38 PayU Card & UPI ', '', '15', '', '', '', '', '', '', '', '0.00', '0.00', '2', '5', 32, NULL, '', 'null', '18.00', 1),
(64, 341, 272, '383', 1, '3.8', '0.08', '0.00', '1', '500', '1', '7', '', '0.00', 'INR', '{"merchantKey":"LBmorJ","saltKey":"CZDFWpQfePOkXbaLuXfRZWbRllOuIlbA"}', '15', '45', '100', '', '45', '1', '', 'ewallets', 'UPI', '15', '', '', '', '', '', '', '', '0.00', '0.00', '2', '5', 32, NULL, '', 'null', '18.00', 1),
(67, 341, 272, '71', 1, '2.8', '0.00', '0.00', '1', '500', '1', '7', '', '', 'INR', '', '15', '45', '100', '', '200', '1', '', 'BT - Bank Transfer', '', '15', '', '', '', '', '', '', '', '90', '0.00', '2', '5', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18', 1),
(68, 341, 272, '711', 1, '2.8', '0.00', '0.00', '1', '500', '1', '7', '', '', 'INR', '', '15', '45', '100', '', '200', '1', '', '711 Indus Collect', '', '15', '', '', '', '', '', '', '', '90', '0.00', '2', '5', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18', 1),
(69, 341, 272, '44', 1, '5.50', '0.80', '0.00', '1', '500', '1', '7', '', '', 'INR', '{"PublicKey":"FLWPUBK-532a72a10035679d168b4d32d753915a-X","SecretKey":"FLWSECK-9bf324b2aa99a3ca022b4ac10a330abb-X","EncryptionKey":"9bf324b2aa99160843818870"}', '15', '45', '100', '', '200', '15', '', '44 Visa, MasterCard - 3D Secure', '', '15', '', '', '', '', '', '', '', '90', '0.00', '2', '5', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18', 1),
(70, 341, 272, '46', 1, '5.50', '0.80', '0.00', '1', '500', '1', '7', '', '', 'INR', '{"apiKey":"254|JvQ42xbfGuAQ5wcCOKcHX24hHjpJ7w68nORgMhVG"}', '15', '45', '100', '', '200', '15', '', '46 Visa, MasterCard - 3D Secure', '', '15', '', '', '', '', '', '', '', '90', '0.00', '2', '5', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18', 1),
(71, 341, 272, '782', 1, '2.8', '0.00', '0.00', '1', '500', '1', '7', '', '', 'INR', '{"sid":"SKYWA-0700"}', '15', '45', '100', '', '200', '1', '', '782 All UPI Payment', '782 All UPI Payment', '10', '', '', '', '', '', '', '', '90', '0.00', '2', '5', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18', 1),
(72, 341, 272, '42', 1, '5.50', '0.80', '10', '1', '500', '1', '7', '', '', 'USD', '{"AccountId":" 4017","ShopId":"50022","Key":"1adf1158f43a4e9cf56116176a02afe5","Pass":"64df892319fe7"}', '55', '70', '100', '', '45', '18', '', '42 Visa, MasterCard - 3D Secure', '', '15', '', '', '', '', '', '', '', '210', '0.00', '2', '5', 42, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', NULL, 1),
(73, 341, 272, '11', 1, '5.5', '0.08', '10', '1', '500', '1', '7', '', '', 'USD', '{"merchantId":"372670166","apikey":"dishfccow4jfel4popzeus4osdw7jbozyszn6jlcyzbnja6z4js89dbwt1c1uwdt","secretkey":"9pglflvhhvphs3tdgjskzvxconmjlug5f1apro7tws9rbw8odrelsd3swjnvn376"}', '15', '45', '100', '', '45', '15', '', '11 Binance pay', 'UPI', '15', '', '', '', '', '', '', '', '180', '0.00', '2', '5', 11, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"500","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', NULL, 1),
(74, 341, 272, '13', 1, '5.50', '0.03', '10%', '1', '5000', '1', '7', '', '', 'USD', '{"apikey":"17a54646-a17c-4e2d-8333-ad542a71f7aa"}', '0.00', '0.00', '0.00', '', '0.00', '7', '', 'C13 oinbase Wallet & Crypto Payments', '', '0.00', '', '', '', '', '', '', '', '180', '0.00', '2', '5', 7, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"5000","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', NULL, 1),
(75, 341, 272, '12', 1, '5.50', '0.03', '10%', '1', '5000', '1', '7', '', '', 'USD', '{"sci_name":"website scI adv","api_token":"2c8dc6bccd04b1ca81fd2ce69898d50d9a42a303bc53021a2466b6e6b51905cc"}', '0.00', '0.00', '0.00', '', '0.00', '7', '', '12 AdvCash eWallet (Choose this option if you already have AdvCash Wallet)', '', '0.00', '', '', '', '', '', '', '', '180', '0.00', '2', '5', 12, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"5000","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', NULL, 1),
(76, 341, 272, '122', 1, '5.50', '0.03', '10%', '1', '5000', '1', '7', '', '', 'USD', '', '0.00', '0.00', '0.00', '', '0.00', '7', '', '122 - TetherCoin (Min Payment 40 USD - SCAN QR Code)', '', '0.00', '', '', '', '', '', '', '', '180', '0.00', '2', '5', 0, NULL, '', '{"sp_1":{"scrubbed_period":"1","min_limit":"1","max_limit":"5000","tr_scrub_success_count":"2","tr_scrub_failed_count":"5"}}', '18', 1);




INSERT INTO "zt_mcc_code" ("id", "mcc_code", "category_name", "category_key", "comments", "udate", "cdate", "category_status", "json_log_history") VALUES
(122, '7995,5967', 'Casino Testing', '628211b9969c9', 'Casino Testing', '2022-05-16 11:26:35', '2022-09-02 06:32:18', 2, '{}'),
(123, '15874,45789 ', 'IPTV Testing ', '628211e3c9fae', 'IPTV Testing', '2022-05-16 11:27:07', '2022-09-02 06:32:18', 2, '{}'),
(124, '4899', 'Evok', '62848458eb0b5', 'Evok', '2023-09-30 16:32:44', '2022-09-02 06:32:18', 1, '{}'),
(125, '6211', 'FOREX/TRADING', '628484a78e2b4', 'Security Brokers/Dealers', '2022-05-18 08:01:19', '2022-09-02 06:32:18', 1, '{}'),
(126, '7995', 'CASINO GAMING', '628485ff7dd9a', 'Betting (including Lottery Tickets, Casino Gaming Chips, Off - track Betting and Wagers)', '2022-05-18 08:07:03', '2022-09-02 06:32:18', 1, '{}'),
(127, '1111', 'Global', '6284a30e3b18b', 'Global Processing', '2022-05-18 10:11:02', '2022-09-02 06:32:18', 1, '{}'),
(128, '7399', 'HOSTING', '6284e53a1cf86', 'Business Services, Not Elsewhere Classified', '2022-05-18 14:53:22', '2022-09-02 06:32:18', 1, '{}'),
(129, '5967', 'Adult', '62875fb6550d5', 'adult, escort services, dating', '2022-05-20 12:00:30', '2022-09-02 06:32:18', 1, '{}'),
(130, '5993', 'smoke accessories', '62bc36c6e723d', 'Tobacco, cigarettes, cigar stores, vape e-cigs, e-cigarettes', '2022-09-30 17:42:50', '2022-09-02 06:32:18', 1, '{}'),
(140, '6792', 'Evok 782', '6518019129676', 'Evok 782', '2023-09-30 16:38:01', '2023-09-30 11:08:01', 2, '[{"log_user":"Admin...","log_date":"2023-09-30 16:41:22 PM","log_action":"delete","log_url":"http://localhost/gw/signins/merchant_category.do?id=140&action=delete","log_count":0,"log_log":{"ip_address":"::1","devinm":"NVI5bTI1RksxTEsvdi9ZZXNpQ1EvUT09","miscellaneous":"VmZReGZKdm9BSUxoMUlWM2FHcmUrQ3ZNazd0d0lKdVNrS1lDRGVLTTE3NVBjOVowS2FvcDVMMDFmNHlVMXVHKzFiUlJKalVOc1JjNFhuZEFjY3ZBTVd3UW9jRktHdHkxbXFvdk93WFNYSGM9","HTTP_REFERER":"http://localhost/gw/signins/merchant_category.do","id":"140","mcc_code":"6792","category_name":"Evok 782","category_key":"6518019129676","comments":"Evok 782","udate":"2023-09-30 16:38:01","cdate":"2023-09-30 16:38:01","category_status":"2","json_log_history":null,"url_get":"http://localhost/gw/signins/merchant_category.do?id=140&action=delete"}}]'),
(141, '6792', 'Evok 782', '651801ca8c8fe', 'Evok 782', '2023-09-30 16:38:58', '2023-09-30 11:08:58', 1, '[{"log_user":"Admin...","log_date":"2023-09-30 16:38:58 PM","log_action":"Insert","log_url":"http://localhost/gw/signins/merchant_category.do","log_count":0,"log_log":{"ip_address":"::1","devinm":"NVI5bTI1RksxTEsvdi9ZZXNpQ1EvUT09","miscellaneous":"VmZReGZKdm9BSUxoMUlWM2FHcmUrQ3ZNazd0d0lKdVNrS1lDRGVLTTE3NVBjOVowS2FvcDVMMDFmNHlVMXVHKzFiUlJKalVOc1JjNFhuZEFjY3ZBTVd3UW9jRktHdHkxbXFvdk93WFNYSGM9","HTTP_REFERER":"http://localhost/gw/signins/merchant_category.do","id":"141","mcc_code":"6792","category_name":"Evok 782","category_key":"651801ca8c8fe","comments":"Evok 782","udate":"2023-09-30 16:38:58","cdate":"2023-09-30 16:38:58","category_status":"1","json_log_history":null,"url_get":"http://localhost/gw/signins/merchant_category.do"}}]);



<<table create ------------------------------------------

CREATE TABLE "db_test" (
  "id" int NOT NULL,
  "date" timestamp(6) DEFAULT NULL,
  "msg" text DEFAULT NULL,
  PRIMARY KEY ("id")
);



CREATE TABLE "zt_access_level" (
  "id" int NOT NULL,
  "access__level_name" varchar(50) NOT NULL DEFAULT '',
  "admin_id" int NOT NULL DEFAULT 0,
  "role_add_user" int NOT NULL DEFAULT 0,
  "role_configuration" int NOT NULL DEFAULT 0,
  "role_faq" int NOT NULL DEFAULT 0,
  "role_dispute" int NOT NULL DEFAULT 0,
  "role_statistics" int NOT NULL DEFAULT 0,
  "role_members" int NOT NULL DEFAULT 0,
  "role_accountin" int NOT NULL DEFAULT 0,
  "role_shop" int NOT NULL DEFAULT 0,
  "roles_type_name" varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY ("id"),
  CONSTRAINT "id" UNIQUE  ("id")
);

CREATE INDEX "access__level_name" ON "zt_access_level" ("access__level_name");
CREATE INDEX "role_add_user" ON "zt_access_level" ("role_add_user");
CREATE INDEX "role_members" ON "zt_access_level" ("role_members");
CREATE INDEX "role_shop" ON "zt_access_level" ("role_shop");
CREATE INDEX "roles_type_name" ON "zt_access_level" ("roles_type_name");



CREATE TABLE "zt_access_roles" (
  "id" int NOT NULL,
  "rolesname" varchar(255) NOT NULL DEFAULT '',
  "merchant_access_all" int DEFAULT 0,
  "merchant_access_multiple" int DEFAULT 0,
  "merchant_access_individual" int DEFAULT 0,
  "subadmin_access_all" int DEFAULT 0,
  "subadmin_access_multiple" int DEFAULT 0,
  "subadmin_access_individual" int DEFAULT 0,
  "search_header" int DEFAULT 0,
  "ticket_link" int DEFAULT 0,
  "email_zoho_etc" int DEFAULT 0,
  "merchant_action_view" int DEFAULT 0,
  "merchant_action_edit" int DEFAULT 0,
  "merchant_action_login" int DEFAULT 0,
  "merchant_action_password_reset" int DEFAULT 0,
  "merchant_action_m_edit" int DEFAULT 0,
  "merchant_action_add_principal_profile" int DEFAULT 0,
  "merchant_action_add_stores" int DEFAULT 0,
  "merchant_action_add_micro_transactions" int DEFAULT 0,
  "merchant_action_add_account" int DEFAULT 0,
  "merchant_action_add_associate_account" int DEFAULT 0,
  "merchant_action_status_action" int DEFAULT 0,
  "merchant_action_bank_account" int DEFAULT 0,
  "active" int DEFAULT 0,
  "suspended" int DEFAULT 0,
  "closed" int DEFAULT 0,
  "online" int DEFAULT 0,
  "search" int DEFAULT 0,
  "addnew" int DEFAULT 0,
  "block" int DEFAULT 0,
  "add_sub_admin" int DEFAULT 0,
  "list_sub_admin" int DEFAULT 0,
  "create_roles" int DEFAULT 0,
  "list_of_roles" int DEFAULT 0,
  "e_mail_templates" int DEFAULT 0,
  "graphical_staticstics" int DEFAULT 0,
  "bank_gateway_table" int DEFAULT 0,
  "change_password" int DEFAULT 0,
  "general_option" int DEFAULT 0,
  "mass_mailing" int DEFAULT 0,
  "test_mass_mailing" int DEFAULT 0,
  "transaction_action_checkbox_completed" int DEFAULT 0,
  "transaction_action_checkbox_settled" int DEFAULT 0,
  "transaction_action_checkbox_reminder" int DEFAULT 0,
  "transaction_action_checkbox_surprise" int DEFAULT 0,
  "transaction_action_checkbox_csv" int DEFAULT 0,
  "update_clients_balance" int DEFAULT 0,
  "transaction_action_all" int DEFAULT 0,
  "edit_trans" int DEFAULT 0,
  "t_bal_upd" int DEFAULT 0,
  "note_system" int DEFAULT 0,
  "txn_detail" int DEFAULT 0,
  "json_post_view" int DEFAULT 0,
  "balance_adjust" int DEFAULT 0,
  "transaction_payout" int DEFAULT 0,
  "transaction_all_link" int DEFAULT 0,
  "merchant_access_group" int DEFAULT 0,
  "sub_admin_access_group" int DEFAULT 0,
  "search_header_group" int DEFAULT 0,
  "ticket_menu_group" int DEFAULT 0,
  "email_menu_group" int DEFAULT 0,
  "clients_action_group" int DEFAULT 0,
  "clients_menu_group" int DEFAULT 0,
  "sub_admin_menu_group" int DEFAULT 0,
  "templates_menu_group" int DEFAULT 0,
  "admin_menu_group" int DEFAULT 0,
  "transaction_action_group" int DEFAULT 0,
  "acquirer_group" int DEFAULT 0,
  "gateway_assign_in_subadmin" int DEFAULT 0,
  "merchant_assign_in_subadmin" int DEFAULT 0,
  "update_sub_admin_self_profile" int DEFAULT 0,
  "update_sub_admin_other_profile" int DEFAULT 0,
  "subadmin_list_role_view" int DEFAULT 0,
  "search_transaction_list" int DEFAULT 0,
  "transaction_status_update" int DEFAULT 0,
  "transaction_view_all" int DEFAULT 0,
  "t_resub_echeck" int DEFAULT 0,
  "t_refund_accept" int DEFAULT 0,
  "t_refund_reject" int DEFAULT 0,
  "t_withdraw_accept" int DEFAULT 0,
  "t_withdraw_reject" int DEFAULT 0,
  "t_fund_reject" int DEFAULT 0,
  "t_status_confirm" int DEFAULT 0,
  "t_status_cancel" int DEFAULT 0,
  "t_status_return" int DEFAULT 0,
  "t_status_chargeback" int DEFAULT 0,
  "t_a_require" int DEFAULT 0,
  "t_add_remark" int DEFAULT 0,
  "t_cs_trans" int DEFAULT 0,
  "t_status_test" int DEFAULT 0,
  "t_status_refunded" int DEFAULT 0,
  "t_status_flag" int DEFAULT 0,
  "t_status_unflag" int DEFAULT 0,
  "t_status_pre_dispute" int DEFAULT 0,
  "t_calculation_details" int DEFAULT 0,
  "t_calculation_row" int DEFAULT 0,
  "t_multiple_check_box" int DEFAULT 0,
  "t_acquirer_view" int DEFAULT 0,
  "t_bank_account_in_check" int DEFAULT 0,
  "subadmin_pdf_report_link" int DEFAULT 0,
  "subadmin_profile_link" int DEFAULT 0,
  "clients_store_view" int DEFAULT 0,
  "clients_gp_view_id" int DEFAULT 0,
  "clients_risk_ratio_bar" int DEFAULT 0,
  "clients_total_transaction" int DEFAULT 0,
  "clients_current_balance" int DEFAULT 0,
  "clients_two_way_authentication" int DEFAULT 0,
  "clients_add_money" int DEFAULT 0,
  "clients_deduct_money" int DEFAULT 0,
  "clients_add_email" int DEFAULT 0,
  "clients_app_store_approve" int DEFAULT 0,
  "clients_profile_status_approve" int DEFAULT 0,
  "clients_uploaded_document_view" int DEFAULT 0,
  "clients_ip_history" int DEFAULT 0,
  "clients_bank_edit_permission" int DEFAULT 0,
  "clients_bank_add_edit" int DEFAULT 0,
  "clients_acquirer_add_edit" int DEFAULT 0,
  "role_description" text DEFAULT NULL,
  "json_value" jsonb DEFAULT NULL,
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "rolesname" ON "zt_access_roles" ("rolesname");



CREATE TABLE "zt_acquirer_group_template" (
  "id" int NOT NULL,
  "tid" varchar(240) DEFAULT NULL,
  "templates_name" varchar(400) DEFAULT NULL,
  "comments" varchar(2000) DEFAULT NULL,
  "udate" varchar(90) DEFAULT NULL,
  "cdate" timestamp(6) NULL DEFAULT current_timestamp(6),
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id")
);



CREATE TABLE "zt_acquirer_table" (
  "id" int NOT NULL,
  "select_mcc" varchar(240) DEFAULT NULL,
  "acquirer_status" int DEFAULT 0,
  "acquirer_id" int DEFAULT 0,
  "acquirer_name" varchar(100) DEFAULT NULL,
  "default_acquirer" int DEFAULT NULL,
  "acquirer_prod_url" varchar(240) DEFAULT NULL,
  "acquirer_uat_url" varchar(240) DEFAULT NULL,
  "acquirer_login_creds" varchar(240) DEFAULT NULL,
  "acquirer_refund_policy" varchar(100) DEFAULT NULL,
  "acquirer_refund_url" varchar(240) DEFAULT NULL,
  "acquirer_dev_url" varchar(240) DEFAULT NULL,
  "acquirer_status_url" varchar(240) DEFAULT NULL,
  "channel_type" varchar(240) DEFAULT NULL,
  "connection_method" varchar(240) DEFAULT NULL,
  "acquirer_prod_mode" varchar(240) DEFAULT NULL,
  "acquirer_descriptor" varchar(240) DEFAULT NULL,
  "acquirer_wl_ip" varchar(240) DEFAULT NULL,
  "acquirer_wl_domain" varchar(240) DEFAULT NULL,
  "processing_currency_markup" varchar(90) DEFAULT NULL,
  "tech_comments" text DEFAULT NULL,
  "acquirer_processing_currency" varchar(90) DEFAULT NULL,
  "acquirer_processing_creds" text DEFAULT NULL,
  "mer_setting_json" text DEFAULT NULL,
  "inactive_failed_count" int DEFAULT NULL,
  "trans_auto_expired" int DEFAULT NULL,
  "trans_auto_refund" int DEFAULT NULL,
  "block_countries" varchar(240) DEFAULT NULL,
  "processing_countries" varchar(240) DEFAULT NULL,
  "mop" varchar(240) DEFAULT NULL,
  "mop_mobile" varchar(240) DEFAULT NULL,
  "acquirer_label_json" text DEFAULT NULL,
  "notification_email" text DEFAULT NULL,
  "inactive_start_time" timestamp(6) DEFAULT NULL,
  "inactive_end_time" timestamp(6) DEFAULT NULL,
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "id" ON "zt_acquirer_table" ("id");
CREATE INDEX "acquirer_id" ON "zt_acquirer_table" ("acquirer_id");
CREATE INDEX "select_mcc" ON "zt_acquirer_table" ("select_mcc");
CREATE INDEX "acquirer_status" ON "zt_acquirer_table" ("acquirer_status");
CREATE INDEX "acquirer_name" ON "zt_acquirer_table" ("acquirer_name");
CREATE INDEX "default_acquirer" ON "zt_acquirer_table" ("default_acquirer");
CREATE INDEX "acquirer_prod_url" ON "zt_acquirer_table" ("acquirer_prod_url");
CREATE INDEX "acquirer_uat_url" ON "zt_acquirer_table" ("acquirer_uat_url");
CREATE INDEX "acquirer_login_creds" ON "zt_acquirer_table" ("acquirer_login_creds");
CREATE INDEX "acquirer_refund_policy" ON "zt_acquirer_table" ("acquirer_refund_policy");
CREATE INDEX "acquirer_refund_url" ON "zt_acquirer_table" ("acquirer_refund_url");
CREATE INDEX "acquirer_dev_url" ON "zt_acquirer_table" ("acquirer_dev_url");
CREATE INDEX "acquirer_status_url" ON "zt_acquirer_table" ("acquirer_status_url");
CREATE INDEX "channel_type" ON "zt_acquirer_table" ("channel_type");
CREATE INDEX "connection_method" ON "zt_acquirer_table" ("connection_method");
CREATE INDEX "acquirer_prod_mode" ON "zt_acquirer_table" ("acquirer_prod_mode");
CREATE INDEX "acquirer_descriptor" ON "zt_acquirer_table" ("acquirer_descriptor");
CREATE INDEX "acquirer_wl_ip" ON "zt_acquirer_table" ("acquirer_wl_ip");
CREATE INDEX "acquirer_wl_domain" ON "zt_acquirer_table" ("acquirer_wl_domain");
CREATE INDEX "processing_currency_markup" ON "zt_acquirer_table" ("processing_currency_markup");
CREATE INDEX "acquirer_processing_currency" ON "zt_acquirer_table" ("acquirer_processing_currency");
CREATE INDEX "inactive_failed_count" ON "zt_acquirer_table" ("inactive_failed_count");
CREATE INDEX "trans_auto_expired" ON "zt_acquirer_table" ("trans_auto_expired");
CREATE INDEX "trans_auto_refund" ON "zt_acquirer_table" ("trans_auto_refund");
CREATE INDEX "block_countries" ON "zt_acquirer_table" ("block_countries");
CREATE INDEX "processing_countries" ON "zt_acquirer_table" ("processing_countries");
CREATE INDEX "mop" ON "zt_acquirer_table" ("mop");
CREATE INDEX "mop_mobile" ON "zt_acquirer_table" ("mop_mobile");
CREATE INDEX "inactive_start_time" ON "zt_acquirer_table" ("inactive_start_time");
CREATE INDEX "inactive_end_time" ON "zt_acquirer_table" ("inactive_end_time");


CREATE TABLE "zt_api_card_table" (
  "id" int NOT NULL,
  "card_type" varchar(20) DEFAULT NULL,
  "bin_number" varchar(6) DEFAULT NULL,
  "bank_name" varchar(100) NOT NULL,
  "timestamp" timestamp(6) NULL DEFAULT current_timestamp(6),
  "josn" text DEFAULT NULL,
  "comments" text DEFAULT NULL,
  PRIMARY KEY ("id")
);



CREATE TABLE "zt_api_data_table" (
  "id" int NOT NULL,
  "use_for" varchar(255) DEFAULT NULL,
  "pram_value" varchar(255) DEFAULT NULL,
  "timestamp" timestamp(6) NULL DEFAULT current_timestamp(6),
  "josn" text DEFAULT NULL,
  "comments" text DEFAULT NULL,
  PRIMARY KEY ("id")
);



CREATE TABLE "zt_auto_settlement_request" (
  "id" int NOT NULL,
  "csv_json" text DEFAULT NULL,
  "csv_log" text DEFAULT NULL,
  "all_log" text DEFAULT NULL,
  "comments" varchar(2000) DEFAULT NULL,
  "udate" varchar(90) DEFAULT NULL,
  "cdate" timestamp(6) NULL DEFAULT current_timestamp(6),
  PRIMARY KEY ("id")
);



CREATE TABLE "zt_bank_payout_table" (
  "id" int NOT NULL,
  "payout_status" int DEFAULT 0,
  "payout_id" int DEFAULT 0,
  "bank_payment_url" varchar(240) DEFAULT NULL,
  "bank_merchant_id" varchar(240) DEFAULT NULL,
  "bank_api_token" varchar(240) DEFAULT NULL,
  "bank_login_url" varchar(240) DEFAULT NULL,
  "bank_user_id" varchar(240) DEFAULT NULL,
  "bank_login_password" varchar(240) DEFAULT NULL,
  "developer_url" varchar(240) DEFAULT NULL,
  "bank_status_url" varchar(240) DEFAULT NULL,
  "bank_process_url" varchar(240) DEFAULT NULL,
  "payout_type" varchar(240) DEFAULT NULL,
  "connection_method" varchar(240) DEFAULT NULL,
  "payout_prod_mode" varchar(240) DEFAULT NULL,
  "payout_uat_url" varchar(240) DEFAULT NULL,
  "hash_code_method" varchar(240) DEFAULT NULL,
  "payout_wl_ip" varchar(240) DEFAULT NULL,
  "payout_mop" varchar(240) DEFAULT NULL,
  "processing_currency" varchar(90) DEFAULT NULL,
  "tech_comments" text DEFAULT NULL,
  "payout_processing_currency" varchar(90) DEFAULT NULL,
  "payout_json" text DEFAULT NULL,
  "encode_processing_creds" text DEFAULT NULL,
  "json_log_history" text DEFAULT NULL,
  "history_json" jsonb DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "payout_id" ON "zt_bank_payout_table" ("payout_id");
CREATE INDEX "processing_currency" ON "zt_bank_payout_table" ("processing_currency");



CREATE TABLE "zt_banks" (
  "id" int NOT NULL,
  "clientid" int DEFAULT 0,
  "bname" varchar(240) DEFAULT '',
  "baddress" varchar(240) DEFAULT '',
  "bcity" varchar(240) DEFAULT '',
  "bzip" varchar(16) DEFAULT '',
  "bcountry" varchar(140) DEFAULT '',
  "bstate" varchar(140) DEFAULT '',
  "bphone" varchar(32) DEFAULT '',
  "bnameacc" varchar(128) DEFAULT '',
  "baccount" varchar(240) DEFAULT '',
  "btype" varchar(240) DEFAULT '',
  "brtgnum" varchar(240) DEFAULT '',
  "bswift" varchar(240) DEFAULT '',
  "status" smallint DEFAULT 0,
  "default" smallint DEFAULT 0,
  "adiinfo" varchar(255) DEFAULT NULL,
  "required_currency" varchar(150) DEFAULT NULL,
  "primary" varchar(10) DEFAULT NULL,
  "intermediary" varchar(244) DEFAULT NULL,
  "intermediary_bank_name" varchar(244) DEFAULT NULL,
  "intermediary_bank_address" varchar(244) DEFAULT NULL,
  "full_address" varchar(500) DEFAULT NULL,
  "bank_doc" varchar(250) DEFAULT NULL,
  "bank_account_primary" int DEFAULT 0,
  "json_log_history" jsonb DEFAULT NULL,
  "withdrawFee" varchar(50) DEFAULT '0.00',
  "verify_amount" double precision NOT NULL,
  "verify_status" smallint NOT NULL,
  "verify_date" date DEFAULT NULL,
  "verify_tid" int check ("verify_tid" > 0) NOT NULL,
  "bank_bene_id" varchar(20) NOT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "status" ON "zt_banks" ("status");
CREATE INDEX "bname" ON "zt_banks" ("bname");
CREATE INDEX "clientid" ON "zt_banks" ("clientid");
CREATE INDEX "baddress" ON "zt_banks" ("baddress");
CREATE INDEX "bcity" ON "zt_banks" ("bcity");
CREATE INDEX "bzip" ON "zt_banks" ("bzip");
CREATE INDEX "bcountry" ON "zt_banks" ("bcountry");
CREATE INDEX "bstate" ON "zt_banks" ("bstate");
CREATE INDEX "bphone" ON "zt_banks" ("bphone");
CREATE INDEX "bnameacc" ON "zt_banks" ("bnameacc");
CREATE INDEX "baccount" ON "zt_banks" ("baccount");
CREATE INDEX "btype" ON "zt_banks" ("btype");
CREATE INDEX "brtgnum" ON "zt_banks" ("brtgnum");
CREATE INDEX "bswift" ON "zt_banks" ("bswift");
CREATE INDEX "default" ON "zt_banks" ("default");
CREATE INDEX "adiinfo" ON "zt_banks" ("adiinfo");
CREATE INDEX "required_currency" ON "zt_banks" ("required_currency");
CREATE INDEX "intermediary" ON "zt_banks" ("intermediary");
CREATE INDEX "intermediary_bank_name" ON "zt_banks" ("intermediary_bank_name");
CREATE INDEX "intermediary_bank_address" ON "zt_banks" ("intermediary_bank_address");
CREATE INDEX "full_address" ON "zt_banks" ("full_address");
CREATE INDEX "bank_doc" ON "zt_banks" ("bank_doc");
CREATE INDEX "bank_account_primary" ON "zt_banks" ("bank_account_primary");
CREATE INDEX "withdrawFee" ON "zt_banks" ("withdrawFee");
CREATE INDEX "verify_amount" ON "zt_banks" ("verify_amount");
CREATE INDEX "verify_status" ON "zt_banks" ("verify_status");
CREATE INDEX "verify_date" ON "zt_banks" ("verify_date");
CREATE INDEX "verify_tid" ON "zt_banks" ("verify_tid");
CREATE INDEX "bank_bene_id" ON "zt_banks" ("bank_bene_id");



CREATE TABLE "zt_blacklist_data" (
  "id" int check ("id" > 0) NOT NULL,
  "clientid" int check ("clientid" > 0) NOT NULL,
  "blacklist_type" varchar(30) check ("blacklist_type" in ('IP','Country','City','Email','Card Number','VPA','Mobile')) NOT NULL,
  "blacklist_value" varchar(100) NOT NULL,
  "remarks" varchar(500) NOT NULL,
  "status" smallint check ("status" > 0) NOT NULL DEFAULT 1,
  "created_date" timestamp(6) NOT NULL,
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "owner" UNIQUE  ("clientid","blacklist_type","blacklist_value")
);


CREATE TABLE "zt_clientid_emails" (
  "id" int check ("id" > 0) NOT NULL,
  "clientid" int NOT NULL DEFAULT 0,
  "email" varchar(500) NOT NULL DEFAULT '',
  "active" smallint NOT NULL DEFAULT 0,
  "primary" smallint NOT NULL DEFAULT 0,
  "verifcode" varchar(40) NOT NULL DEFAULT '',
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "clientid" ON "zt_clientid_emails" ("clientid");
CREATE INDEX "email" ON "zt_clientid_emails" ("email");
CREATE INDEX "active" ON "zt_clientid_emails" ("active");
CREATE INDEX "verifcode" ON "zt_clientid_emails" ("verifcode");
CREATE INDEX "primary_2" ON "zt_clientid_emails" ("primary");



CREATE TABLE "zt_clientid_table" (
  "id" int NOT NULL,
  "sponsor" int DEFAULT 0,
  "username" varchar(32) NOT NULL DEFAULT '',
  "password" varchar(255) DEFAULT '',
  "registered_email" varchar(255) DEFAULT '',
  "active" smallint DEFAULT 0,
  "status" smallint DEFAULT 0,
  "edit_permission" varchar(244) DEFAULT NULL,
  "created_date" timestamp(6) DEFAULT current_timestamp(6),
  "last_login_date" timestamp(6) DEFAULT NULL,
  "last_login_ip" varchar(255) DEFAULT NULL,
  "fullname" varchar(100) DEFAULT NULL,
  "company_name" varchar(150) DEFAULT '',
  "country" varchar(120) DEFAULT '',
  "description" text DEFAULT NULL,
  "ip_block_client" varchar(240) DEFAULT '',
  "encoded_contact_person_info" text DEFAULT NULL,
  "registered_address" varchar(500) DEFAULT NULL,
  "deleted_email" text DEFAULT NULL,
  "private_key" varchar(240) DEFAULT '',
  "daily_password_count" text DEFAULT NULL,
  "password_updated_date" timestamp(6) DEFAULT NULL,
  "previous_passwords" text DEFAULT NULL,
  "default_currency" varchar(100) DEFAULT NULL,
  "google_auth_code" varchar(255) DEFAULT NULL,
  "google_auth_access" smallint DEFAULT 0,
  "sub_client_id" int DEFAULT NULL,
  "sub_client_role" varchar(240) DEFAULT NULL,
  "json_log_history" jsonb DEFAULT NULL,
  "json_value" jsonb DEFAULT NULL,
  "request_funds" varchar(20) DEFAULT NULL,
  "moto_status" varchar(20) DEFAULT NULL,
  "payout_request" varchar(20) DEFAULT NULL,
  "qrcode_gateway_request" varchar(20) DEFAULT NULL,
  "assign_trans_display_json" text DEFAULT NULL,
  "sort_trans_display_json" text DEFAULT NULL,
  PRIMARY KEY ("username")
);

CREATE INDEX "username" ON "zt_clientid_table" ("username");
CREATE INDEX "password" ON "zt_clientid_table" ("password");
CREATE INDEX "registered_email" ON "zt_clientid_table" ("registered_email");
CREATE INDEX "active" ON "zt_clientid_table" ("active");
CREATE INDEX "status" ON "zt_clientid_table" ("status");
CREATE INDEX "private_key" ON "zt_clientid_table" ("private_key");
CREATE INDEX "google_auth_code" ON "zt_clientid_table" ("google_auth_code");
CREATE INDEX "google_auth_access" ON "zt_clientid_table" ("google_auth_access");
CREATE INDEX "registered_address" ON "zt_clientid_table" ("registered_address");
CREATE INDEX "ip_block_client" ON "zt_clientid_table" ("ip_block_client");
CREATE INDEX "sponsor" ON "zt_clientid_table" ("sponsor");
CREATE INDEX "edit_permission" ON "zt_clientid_table" ("edit_permission");
CREATE INDEX "created_date" ON "zt_clientid_table" ("created_date");
CREATE INDEX "last_login_date" ON "zt_clientid_table" ("last_login_date");
CREATE INDEX "last_login_ip" ON "zt_clientid_table" ("last_login_ip");
CREATE INDEX "fullname" ON "zt_clientid_table" ("fullname");
CREATE INDEX "company_name" ON "zt_clientid_table" ("company_name");
CREATE INDEX "country" ON "zt_clientid_table" ("country");
CREATE INDEX "password_updated_date" ON "zt_clientid_table" ("password_updated_date");
CREATE INDEX "default_currency" ON "zt_clientid_table" ("default_currency");
CREATE INDEX "sub_client_id" ON "zt_clientid_table" ("sub_client_id");
CREATE INDEX "sub_client_role" ON "zt_clientid_table" ("sub_client_role");
CREATE INDEX "request_funds" ON "zt_clientid_table" ("request_funds");
CREATE INDEX "moto_status" ON "zt_clientid_table" ("moto_status");
CREATE INDEX "payout_request" ON "zt_clientid_table" ("payout_request");
CREATE INDEX "qrcode_gateway_request" ON "zt_clientid_table" ("qrcode_gateway_request");


CREATE TABLE "zt_coin_wallet" (
  "id" int NOT NULL,
  "clientid" int DEFAULT 0,
  "coins_wallet_provider" varchar(240) DEFAULT '',
  "coins_address" varchar(240) DEFAULT '',
  "coins_network" varchar(240) DEFAULT '',
  "coins_name" varchar(240) DEFAULT '',
  "status" smallint DEFAULT 0,
  "required_currency" varchar(150) DEFAULT NULL,
  "primary" varchar(10) DEFAULT NULL,
  "bank_doc" varchar(250) DEFAULT NULL,
  "json_log_history" jsonb DEFAULT NULL,
  "withdrawFee" varchar(50) DEFAULT NULL,
  "verify_amount" double precision DEFAULT NULL,
  "verify_status" smallint DEFAULT NULL,
  "verify_date" date DEFAULT NULL,
  "verify_tid" int check ("verify_tid" > 0) DEFAULT NULL,
  "bank_account_primary" smallint DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "owner" ON "zt_coin_wallet" ("clientid");
CREATE INDEX "status" ON "zt_coin_wallet" ("status");
CREATE INDEX "coins_address" ON "zt_coin_wallet" ("coins_address");
CREATE INDEX "coins_wallet_provider" ON "zt_coin_wallet" ("coins_wallet_provider");
CREATE INDEX "coins_network" ON "zt_coin_wallet" ("coins_network");
CREATE INDEX "coins_name" ON "zt_coin_wallet" ("coins_name");



CREATE TABLE "zt_currency_exchange_table" (
  "id" int NOT NULL,
  "currency_from" varchar(255) DEFAULT NULL,
  "currency_to" varchar(10) DEFAULT NULL,
  "timestamp" timestamp(6) NULL DEFAULT current_timestamp(6),
  "currency_josn" text DEFAULT NULL,
  "comments" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "currency_from" ON "zt_currency_exchange_table" ("currency_from");
CREATE INDEX "currency_to" ON "zt_currency_exchange_table" ("currency_to");
CREATE INDEX "timestamp" ON "zt_currency_exchange_table" ("timestamp");


CREATE TABLE "zt_email_details" (
  "id" int NOT NULL,
  "clientid" int DEFAULT NULL,
  "tableid" varchar(240) DEFAULT NULL,
  "mail_type" varchar(240) DEFAULT NULL,
  "email_to" varchar(240) DEFAULT NULL,
  "email_from" varchar(240) DEFAULT NULL,
  "subject" varchar(2000) DEFAULT NULL,
  "message" text DEFAULT NULL,
  "date" varchar(200) DEFAULT NULL,
  "response_status" varchar(1000) DEFAULT NULL,
  "response_msg" varchar(4000) DEFAULT NULL,
  "json_value" text DEFAULT NULL,
  "status" int DEFAULT 0,
  PRIMARY KEY ("id")
);


CREATE INDEX "owner" ON "zt_email_details" ("clientid");
CREATE INDEX "tableid" ON "zt_email_details" ("tableid");
CREATE INDEX "mail_type" ON "zt_email_details" ("mail_type");
CREATE INDEX "subject" ON "zt_email_details" ("subject"(255));
CREATE INDEX "status" ON "zt_email_details" ("status");
CREATE INDEX "date" ON "zt_email_details" ("date");


  

CREATE TABLE "zt_emails_templates" (
  "id" int NOT NULL,
  "key" varchar(64) NOT NULL DEFAULT '',
  "name" varchar(1500) NOT NULL DEFAULT '',
  "value" text DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "keyword" UNIQUE ("key")  
);

CREATE INDEX "name" ON "zt_emails_templates" ("name"(333));


CREATE TABLE "zt_emails_templates_deleted" (
  "id" int NOT NULL,
  "key" varchar(64) NOT NULL DEFAULT '',
  "name" varchar(1500) NOT NULL DEFAULT '',
  "value" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "name" ON "zt_emails_templates_deleted" ("name"(333));



CREATE TABLE "zt_json_log" (
  "id" int NOT NULL,
  "action_name" varchar(240) DEFAULT NULL,
  "json_log_history" jsonb DEFAULT NULL,
  "clientid" int DEFAULT NULL,
  "tableName" varchar(100) DEFAULT NULL,
  "created_date" timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  "transID" bigint DEFAULT NULL,
  "reference" varchar(240) DEFAULT NULL,
  "bill_amt" double precision DEFAULT NULL,
  "bill_email" varchar(240) DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "action_name" ON "zt_json_log" ("action_name","clientid","tableName");
CREATE INDEX "created_date" ON "zt_json_log" ("created_date");



CREATE TABLE "zt_login_ip_history" (
  "id" int NOT NULL,
  "clientid" int NOT NULL DEFAULT 0,
  "date" timestamp(6) DEFAULT NULL,
  "address" varchar(32) NOT NULL DEFAULT '',
  "subadmin_id" int DEFAULT NULL,
  "source_url" varchar(200) DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "clientid" ON "zt_login_ip_history" ("clientid");
CREATE INDEX "subadmin_id" ON "zt_login_ip_history" ("subadmin_id");


/*
ALTER TABLE zt_master_trans_table_3 ALTER COLUMN trans_amt TYPE numeric(10, 2) USING (trans_amt::numeric(10, 2));

	
alter table zt_master_trans_table_3 alter column trans_amt type decimal(10,2) using trans_amt::decimal;
alter table zt_master_trans_table_3 alter column trans_amt type numeric(10 , 2) USING trans_amt::numeric(10,2);

Alter table yourtable
Alter Column yourtable_column Decimal(10,2)
*/

TRUNCATE TABLE zt_master_trans_additional_3  CASCADE;
TRUNCATE TABLE zt_master_trans_table_3  CASCADE;

DROP TABLE zt_master_trans_table_3 CASCADE;
DROP TABLE zt_master_trans_additional_3 CASCADE;


   
CREATE TABLE "zt_master_trans_table_3" (
  "id" int NOT NULL,
  "transID" bigint DEFAULT NULL,
  "reference" varchar(100) DEFAULT NULL,
  "bearer_token" bigint DEFAULT NULL,
  "tdate" timestamp(6) DEFAULT NULL,
  "bill_amt" double precision NOT NULL DEFAULT 0.00,
  "bill_currency" varchar(3) DEFAULT NULL,
  "trans_amt" double precision NOT NULL DEFAULT 0.00,
  "trans_currency" varchar(3) DEFAULT NULL,
  "acquirer" bigint DEFAULT 0,
  "trans_status" smallint NOT NULL DEFAULT 0,
  "merID" bigint check ("merID" > 0) NOT NULL,
  "transaction_flag" varchar(20) DEFAULT NULL,
  "fullname" varchar(40) DEFAULT NULL,
  "bill_email" varchar(240) DEFAULT NULL,
  "bill_ip" varchar(100) DEFAULT NULL,
  "terNO" bigint DEFAULT NULL,
  "mop" varchar(240) DEFAULT NULL,
  "channel_type" int DEFAULT NULL,
  "buy_mdr_amt" double precision NOT NULL DEFAULT 0.00,
  "sell_mdr_amt" double precision NOT NULL DEFAULT 0.00,
  "buy_txnfee_amt" double precision NOT NULL DEFAULT 0.00,
  "sell_txnfee_amt" double precision NOT NULL DEFAULT 0.00,
  "gst_amt" double precision NOT NULL DEFAULT 0.00,
  "rolling_amt" double precision NOT NULL DEFAULT 0.00,
  "mdr_cb_amt" double precision NOT NULL DEFAULT 0.00,
  "mdr_cbk1_amt" varchar(10) DEFAULT NULL,
  "mdr_refundfee_amt" varchar(10) DEFAULT NULL,
  "available_rolling" varchar(10) DEFAULT NULL,
  "available_balance" varchar(10) DEFAULT NULL,
  "payable_amt_of_txn" varchar(10) DEFAULT NULL,
  "fee_update_timestamp" timestamp(6) DEFAULT NULL,
  "remark_status" smallint NOT NULL DEFAULT 0,
  "trans_type" int NOT NULL DEFAULT 11,
  "settelement_date" timestamp(6) DEFAULT NULL,
  "settelement_delay" int DEFAULT NULL,
  "rolling_date" timestamp(6) DEFAULT NULL,
  "rolling_delay" int DEFAULT NULL,
  "risk_ratio" varchar(150) DEFAULT NULL,
  "transaction_period" varchar(240) DEFAULT NULL,
  "bank_processing_amount" double precision NOT NULL DEFAULT 0.00,
  "bank_processing_curr" varchar(240) DEFAULT NULL,
  "created_date" timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  "related_transID" varchar(240) DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "transID" UNIQUE  ("transID")
);

create sequence zt_master_trans_table_3_id_seq owned by zt_master_trans_table_3.id; alter table zt_master_trans_table_3 alter column id set default nextval('zt_master_trans_table_3_id_seq');

CREATE INDEX "bill_amt" ON "zt_master_trans_table_3" ("bill_amt");
CREATE INDEX "trans_amt" ON "zt_master_trans_table_3" ("trans_amt");
CREATE INDEX "bearer_token" ON "zt_master_trans_table_3" ("bearer_token");
CREATE INDEX "tdate" ON "zt_master_trans_table_3" ("tdate");
CREATE INDEX "created_date" ON "zt_master_trans_table_3" ("created_date");
CREATE INDEX "reference" ON "zt_master_trans_table_3" ("reference");
CREATE INDEX "acquirer" ON "zt_master_trans_table_3" ("acquirer");
CREATE INDEX "trans_status" ON "zt_master_trans_table_3" ("trans_status");
CREATE INDEX "merID" ON "zt_master_trans_table_3" ("merID");
CREATE INDEX "mop" ON "zt_master_trans_table_3" ("mop");
CREATE INDEX "trans_type" ON "zt_master_trans_table_3" ("trans_type");
CREATE INDEX "bill_email" ON "zt_master_trans_table_3" ("bill_email");
CREATE INDEX "channel_type" ON "zt_master_trans_table_3" ("channel_type");
CREATE INDEX "reference_tdate" ON "zt_master_trans_table_3" ("reference","tdate");
CREATE INDEX "tdate_desc" ON "zt_master_trans_table_3" ("tdate");
CREATE INDEX "reference_desc" ON "zt_master_trans_table_3" ("reference");
CREATE INDEX "transID_desc" ON "zt_master_trans_table_3" ("transID");
CREATE INDEX "bill_ip_desc" ON "zt_master_trans_table_3" ("bill_ip");
CREATE INDEX "validate_0" ON "zt_master_trans_table_3" ("transID","merID","terNO");
CREATE INDEX "callbacks_1" ON "zt_master_trans_table_3" ("transID","merID","id");
CREATE INDEX "callbacks_2" ON "zt_master_trans_table_3" ("transID","merID");
CREATE INDEX "validate_1" ON "zt_master_trans_table_3" ("merID","terNO","reference");
CREATE INDEX "validate_2" ON "zt_master_trans_table_3" ("merID","terNO","reference","trans_status");
CREATE INDEX "acquirer_mop_tdate" ON "zt_master_trans_table_3" ("acquirer","mop","tdate");
CREATE INDEX "stats_group_2" ON "zt_master_trans_table_3" ("bill_amt","bill_email","merID","tdate");
CREATE INDEX "dashboard_1" ON "zt_master_trans_table_3" ("merID","trans_status","trans_type","trans_amt","id");
CREATE INDEX "dashboard_2" ON "zt_master_trans_table_3" ("merID","trans_status","acquirer","trans_amt","id");
CREATE INDEX "dashboard_5" ON "zt_master_trans_table_3" ("merID","trans_status");
CREATE INDEX "grpah_2" ON "zt_master_trans_table_3" ("merID","trans_status","tdate","trans_amt","acquirer");
CREATE INDEX "fullname" ON "zt_master_trans_table_3" ("fullname");
CREATE INDEX "payin_1" ON "zt_master_trans_table_3" ("trans_status","bill_amt","bill_email","merID","terNO","tdate");
CREATE INDEX "payin_2" ON "zt_master_trans_table_3" ("merID","trans_status","trans_type");
CREATE INDEX "search_1" ON "zt_master_trans_table_3" ("acquirer","trans_status","tdate");





CREATE TABLE "zt_master_trans_additional_3" (
  "id_ad" int NOT NULL,
  "transID_ad" bigint DEFAULT NULL,
  "authurl" varchar(250) DEFAULT NULL,
  "authdata" text DEFAULT NULL,
  "source_url" varchar(240) DEFAULT NULL,
  "webhook_url" varchar(240) DEFAULT NULL,
  "return_url" varchar(240) DEFAULT NULL,
  "upa" varchar(240) DEFAULT NULL,
  "rrn" varchar(150) DEFAULT NULL,
  "acquirer_ref" varchar(175) DEFAULT NULL,
  "acquirer_response" text DEFAULT NULL,
  "descriptor" varchar(150) DEFAULT NULL,
  "mer_note" text DEFAULT NULL,
  "support_note" text DEFAULT NULL,
  "system_note" text DEFAULT NULL,
  "json_value" text DEFAULT NULL,
  "acquirer_json" text DEFAULT NULL,
  "json_log_history" text DEFAULT NULL,
  "payload_stage1" text DEFAULT NULL,
  "acquirer_creds_processing_final" text DEFAULT NULL,
  "acquirer_response_stage1" text DEFAULT NULL,
  "acquirer_response_stage2" text DEFAULT NULL,
  "bin_no" int DEFAULT NULL,
  "ccno" varchar(240) DEFAULT NULL,
  "ex_month" varchar(240) DEFAULT NULL,
  "ex_year" varchar(240) DEFAULT NULL,
  "trans_response" varchar(240) DEFAULT NULL,
  "bill_phone" varchar(20) DEFAULT NULL,
  "bill_address" varchar(100) DEFAULT NULL,
  "bill_city" varchar(50) DEFAULT NULL,
  "bill_state" varchar(50) DEFAULT NULL,
  "bill_country" varchar(3) DEFAULT NULL,
  "bill_zip" varchar(50) DEFAULT NULL,
  "product_name" varchar(240) DEFAULT NULL,
  CONSTRAINT "transID_ad" UNIQUE  ("transID_ad")
);

CREATE INDEX "id_ad" ON "zt_master_trans_additional_3" ("id_ad");
CREATE INDEX "rrn_desc" ON "zt_master_trans_additional_3" ("rrn");
CREATE INDEX "upa_desc" ON "zt_master_trans_additional_3" ("upa");
CREATE INDEX "descriptor" ON "zt_master_trans_additional_3" ("descriptor");
CREATE INDEX "trans_response" ON "zt_master_trans_additional_3" ("trans_response");
CREATE INDEX "bill_phone" ON "zt_master_trans_additional_3" ("bill_phone");
CREATE INDEX "bill_address" ON "zt_master_trans_additional_3" ("bill_address");
CREATE INDEX "bill_country" ON "zt_master_trans_additional_3" ("bill_country");
CREATE INDEX "bill_zip" ON "zt_master_trans_additional_3" ("bill_zip");
CREATE INDEX "product_name" ON "zt_master_trans_additional_3" ("product_name");
CREATE INDEX "authurl" ON "zt_master_trans_additional_3" ("authurl");
	CREATE INDEX "authdata" ON "zt_master_trans_additional_3" ("authdata"(768));

ALTER TABLE zt_master_trans_additional_3
    ADD CONSTRAINT FK_Zt_master_trans_additional_3_Zt_master_trans_table_3 FOREIGN KEY(id_ad)
    REFERENCES zt_master_trans_table_3(id)
    ON DELETE CASCADE;
	





CREATE TABLE "zt_mcc_code" (
  "id" int NOT NULL,
  "mcc_code" varchar(240) DEFAULT NULL,
  "category_name" varchar(400) DEFAULT NULL,
  "category_key" varchar(100) NOT NULL,
  "comments" varchar(2000) DEFAULT NULL,
  "udate" varchar(90) DEFAULT NULL,
  "cdate" timestamp(6) NULL DEFAULT current_timestamp(6),
  "category_status" int NOT NULL DEFAULT 1,
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "mcc_code" ON "zt_mcc_code" ("mcc_code");
CREATE INDEX "category_name" ON "zt_mcc_code" ("category_name");
CREATE INDEX "category_key" ON "zt_mcc_code" ("category_key");
CREATE INDEX "category_status" ON "zt_mcc_code" ("category_status");





CREATE TABLE "zt_mer_setting" (
  "id" int NOT NULL,
  "sponsor" int DEFAULT NULL,
  "merID" int NOT NULL DEFAULT 0,
  "acquirer_id" varchar(240) DEFAULT '',
  "acquirer_processing_mode" int DEFAULT NULL,
  "mdr_rate" varchar(64) DEFAULT '',
  "txn_fee_success" varchar(128) DEFAULT '',
  "reserve_rate" varchar(20) DEFAULT '',
  "min_limit" varchar(100) DEFAULT NULL,
  "max_limit" varchar(100) DEFAULT NULL,
  "scrubbed_period" varchar(100) DEFAULT NULL,
  "trans_count" varchar(12) DEFAULT NULL,
  "monthly_fee" varchar(100) DEFAULT NULL,
  "virtual_fee" varchar(100) DEFAULT NULL,
  "acquirer_processing_currency" varchar(100) DEFAULT NULL,
  "acquirer_processing_json" text DEFAULT NULL,
  "charge_back_fee_1" varchar(240) DEFAULT NULL,
  "charge_back_fee_2" varchar(240) DEFAULT NULL,
  "charge_back_fee_3" varchar(240) DEFAULT NULL,
  "moto_status" varchar(240) DEFAULT NULL,
  "cbk1" varchar(240) DEFAULT NULL,
  "settelement_delay" varchar(90) DEFAULT NULL,
  "encrypt_email" varchar(240) DEFAULT '001,002',
  "checkout_label_web" varchar(240) DEFAULT NULL,
  "checkout_label_mobile" varchar(240) DEFAULT NULL,
  "refund_fee" varchar(100) DEFAULT NULL,
  "mdr_visa_rate" varchar(100) DEFAULT NULL,
  "mdr_mc_rate" varchar(100) DEFAULT NULL,
  "mdr_jcb_rate" varchar(100) DEFAULT NULL,
  "mdr_amex_rate" varchar(100) DEFAULT NULL,
  "mdr_range_rate" varchar(12) DEFAULT NULL,
  "mdr_range_type" varchar(5) DEFAULT NULL,
  "mdr_range_amount" varchar(20) DEFAULT NULL,
  "reserve_delay" varchar(100) DEFAULT NULL,
  "txn_fee_failed" varchar(128) DEFAULT NULL,
  "tr_scrub_success_count" varchar(10) DEFAULT NULL,
  "tr_scrub_failed_count" varchar(10) DEFAULT NULL,
  "acquirer_display_order" int DEFAULT NULL,
  "json_log_history" jsonb DEFAULT NULL,
  "salt_id" varchar(240) DEFAULT NULL,
  "scrubbed_json" text DEFAULT NULL,
  "gst_rate" varchar(20) DEFAULT NULL,
  "assignee_type" int DEFAULT 1,
  PRIMARY KEY ("id")
);



CREATE INDEX "id" ON "zt_mer_setting" ("id");
CREATE INDEX "merID" ON "zt_mer_setting" ("merID");
CREATE INDEX "acquirer_id" ON "zt_mer_setting" ("acquirer_id");
CREATE INDEX "payin_1" ON "zt_mer_setting" ("merID","acquirer_processing_mode");
CREATE INDEX "acquirer_processing_mode" ON "zt_mer_setting" ("acquirer_processing_mode");
CREATE INDEX "mdr_rate" ON "zt_mer_setting" ("mdr_rate");
CREATE INDEX "txn_fee_success" ON "zt_mer_setting" ("txn_fee_success");
CREATE INDEX "reserve_rate" ON "zt_mer_setting" ("reserve_rate");
CREATE INDEX "min_limit" ON "zt_mer_setting" ("min_limit");
CREATE INDEX "max_limit" ON "zt_mer_setting" ("max_limit");
CREATE INDEX "scrubbed_period" ON "zt_mer_setting" ("scrubbed_period");
CREATE INDEX "trans_count" ON "zt_mer_setting" ("trans_count");
CREATE INDEX "monthly_fee" ON "zt_mer_setting" ("monthly_fee");
CREATE INDEX "virtual_fee" ON "zt_mer_setting" ("virtual_fee");
CREATE INDEX "acquirer_processing_currency" ON "zt_mer_setting" ("acquirer_processing_currency");
CREATE INDEX "charge_back_fee_1" ON "zt_mer_setting" ("charge_back_fee_1");
CREATE INDEX "charge_back_fee_2" ON "zt_mer_setting" ("charge_back_fee_2");
CREATE INDEX "charge_back_fee_3" ON "zt_mer_setting" ("charge_back_fee_3");
CREATE INDEX "moto_status" ON "zt_mer_setting" ("moto_status");
CREATE INDEX "cbk1" ON "zt_mer_setting" ("cbk1");
CREATE INDEX "settelement_delay" ON "zt_mer_setting" ("settelement_delay");
CREATE INDEX "encrypt_email" ON "zt_mer_setting" ("encrypt_email");
CREATE INDEX "checkout_label_web" ON "zt_mer_setting" ("checkout_label_web");
CREATE INDEX "checkout_label_mobile" ON "zt_mer_setting" ("checkout_label_mobile");
CREATE INDEX "refund_fee" ON "zt_mer_setting" ("refund_fee");
CREATE INDEX "mdr_visa_rate" ON "zt_mer_setting" ("mdr_visa_rate");
CREATE INDEX "mdr_mc_rate" ON "zt_mer_setting" ("mdr_mc_rate");
CREATE INDEX "mdr_jcb_rate" ON "zt_mer_setting" ("mdr_jcb_rate");
CREATE INDEX "mdr_amex_rate" ON "zt_mer_setting" ("mdr_amex_rate");
CREATE INDEX "mdr_range_rate" ON "zt_mer_setting" ("mdr_range_rate");
CREATE INDEX "mdr_range_type" ON "zt_mer_setting" ("mdr_range_type");
CREATE INDEX "mdr_range_amount" ON "zt_mer_setting" ("mdr_range_amount");
CREATE INDEX "reserve_delay" ON "zt_mer_setting" ("reserve_delay");
CREATE INDEX "txn_fee_failed" ON "zt_mer_setting" ("txn_fee_failed");
CREATE INDEX "tr_scrub_success_count" ON "zt_mer_setting" ("tr_scrub_success_count");
CREATE INDEX "tr_scrub_failed_count" ON "zt_mer_setting" ("tr_scrub_failed_count");
CREATE INDEX "acquirer_display_order" ON "zt_mer_setting" ("acquirer_display_order");
CREATE INDEX "salt_id" ON "zt_mer_setting" ("salt_id");
CREATE INDEX "gst_rate" ON "zt_mer_setting" ("gst_rate");
CREATE INDEX "assignee_type" ON "zt_mer_setting" ("assignee_type");




CREATE TABLE "zt_mop_table" (
  "id" int NOT NULL,
  "mop_code" varchar(240) DEFAULT NULL,
  "mop_name" varchar(400) DEFAULT NULL,
  "mop_type" int NOT NULL DEFAULT 1,
  "comments" varchar(2000) DEFAULT NULL,
  "udate" varchar(90) DEFAULT NULL,
  "cdate" timestamp(6) NULL DEFAULT current_timestamp(6),
  "mop_status" int NOT NULL DEFAULT 1,
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "mop_code" ON "zt_mop_table" ("mop_code");
CREATE INDEX "mop_name" ON "zt_mop_table" ("mop_name");
CREATE INDEX "mop_type" ON "zt_mop_table" ("mop_type");
CREATE INDEX "mop_status" ON "zt_mop_table" ("mop_status");
CREATE INDEX "udate" ON "zt_mop_table" ("udate");
CREATE INDEX "cdate" ON "zt_mop_table" ("cdate");


CREATE TABLE "zt_payin_setting" (
  "id" int NOT NULL,
  "clientid" int NOT NULL,
  "payin_status" smallint DEFAULT 2,
  "monthly_fee" varchar(100) DEFAULT '0',
  "payin_theme" varchar(150) DEFAULT NULL,
  "settlement_optimizer" varchar(100) DEFAULT NULL,
  "settlement_fixed_fee" varchar(100) DEFAULT NULL,
  "settlement_min_amt" varchar(100) DEFAULT NULL,
  "frozen_balance" varchar(99) DEFAULT '0',
  "manual_adjust_balance" varchar(200) DEFAULT NULL,
  "manual_adjust_balance_json" text DEFAULT NULL,
  "available_refresh_tranid" varchar(110) DEFAULT NULL,
  "available_balance" varchar(240) DEFAULT NULL,
  "available_rolling" varchar(240) DEFAULT NULL,
  "chargeback_ratio_card" varchar(240) DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "clientid_ps" UNIQUE  ("clientid")
);

ALTER TABLE zt_payin_setting DROP COLUMN available_refresh_tranid;
ALTER TABLE zt_payin_setting
    ADD COLUMN available_refresh_tranid character varying(150);
	
	
CREATE INDEX "payin_status" ON "zt_payin_setting" ("payin_status");
CREATE INDEX "monthly_fee" ON "zt_payin_setting" ("monthly_fee");
CREATE INDEX "settlement_fixed_fee" ON "zt_payin_setting" ("settlement_fixed_fee");
CREATE INDEX "settlement_min_amt" ON "zt_payin_setting" ("settlement_min_amt");
CREATE INDEX "frozen_balance" ON "zt_payin_setting" ("frozen_balance");
CREATE INDEX "manual_adjust_balance" ON "zt_payin_setting" ("manual_adjust_balance");
CREATE INDEX "available_balance" ON "zt_payin_setting" ("available_balance");
CREATE INDEX "available_rolling" ON "zt_payin_setting" ("available_rolling");
CREATE INDEX "chargeback_ratio_card" ON "zt_payin_setting" ("chargeback_ratio_card");




CREATE TABLE "zt_payout_request" (
  "id" int NOT NULL,
  "csv_json" text DEFAULT NULL,
  "csv_log" text DEFAULT NULL,
  "all_log" text DEFAULT NULL,
  "comments" varchar(2000) DEFAULT NULL,
  "udate" varchar(90) DEFAULT NULL,
  "cdate" timestamp(6) NULL DEFAULT current_timestamp(6),
  PRIMARY KEY ("id")
);




CREATE TABLE "zt_payout_setting" (
  "id" int NOT NULL,
  "clientid" int NOT NULL,
  "payout_status" smallint DEFAULT 0,
  "payout_rate" double precision DEFAULT NULL,
  "payout_fixed_fee" double precision DEFAULT NULL,
  "payout_secret_key" varchar(250) DEFAULT NULL,
  "payout_token" varchar(250) DEFAULT NULL,
  "payout_account" int check ("payout_account" > 0) DEFAULT NULL,
  "scrubbed_period" int DEFAULT NULL,
  "min_limit" varchar(40) DEFAULT NULL,
  "max_limit" varchar(40) DEFAULT NULL,
  "tr_scrub_success_count" varchar(20) DEFAULT NULL,
  "tr_scrub_failed_count" varchar(20) DEFAULT NULL,
  "whitelisted_ips" varchar(240) DEFAULT NULL,
  PRIMARY KEY ("id")
);


CREATE INDEX "clientid" ON "zt_payout_setting" ("clientid");
CREATE INDEX "payout_status" ON "zt_payout_setting" ("payout_status");
CREATE INDEX "whitelisted_ips" ON "zt_payout_setting" ("whitelisted_ips");
CREATE INDEX "payout_rate" ON "zt_payout_setting" ("payout_rate");
CREATE INDEX "min_limit_ps" ON "zt_payout_setting" ("min_limit");
CREATE INDEX "max_limit_ps" ON "zt_payout_setting" ("max_limit");
CREATE INDEX "payout_rate_2" ON "zt_payout_setting" ("payout_rate");
CREATE INDEX "payout_account" ON "zt_payout_setting" ("payout_account");
CREATE INDEX "scrubbed_period_ps" ON "zt_payout_setting" ("scrubbed_period");
CREATE INDEX "payout_token" ON "zt_payout_setting" ("payout_token");
CREATE INDEX "payout_secret_key" ON "zt_payout_setting" ("payout_secret_key");
CREATE INDEX "payout_fixed_fee" ON "zt_payout_setting" ("payout_fixed_fee");
CREATE INDEX "tr_scrub_success_count_ps" ON "zt_payout_setting" ("tr_scrub_success_count");
CREATE INDEX "tr_scrub_failed_count_ps" ON "zt_payout_setting" ("tr_scrub_failed_count");



CREATE TABLE "zt_qr_code" (
  "id" int NOT NULL,
  "clientid" int DEFAULT NULL,
  "sub_merchantId" varchar(20) NOT NULL,
  "softpos_terNO" varchar(100) DEFAULT NULL,
  "acquirer" varchar(20) DEFAULT NULL,
  "softpos_pa" varchar(240) DEFAULT NULL,
  "softpos_pn" varchar(240) DEFAULT NULL,
  "softpos_public_key" varchar(240) DEFAULT NULL,
  "vpa" varchar(250) NOT NULL,
  "qr_fullname" varchar(50) DEFAULT NULL,
  "qr_email" varchar(250) DEFAULT NULL,
  "product_name" varchar(100) DEFAULT NULL,
  "merchantAddressLine" varchar(400) DEFAULT NULL,
  "merchantCity" varchar(100) DEFAULT NULL,
  "merchantState" varchar(100) DEFAULT NULL,
  "merchantPinCode" varchar(20) DEFAULT NULL,
  "mobileNumber" varchar(50) DEFAULT NULL,
  "panNumber" varchar(12) DEFAULT NULL,
  "profile_pic" varchar(255) DEFAULT NULL,
  "currency" varchar(10) DEFAULT NULL,
  "settlementAcSameAsParent" varchar(30) NOT NULL DEFAULT 'Y',
  "softpos_status" int NOT NULL DEFAULT 0,
  "created_date" timestamp(6) NULL DEFAULT current_timestamp(6),
  "json_value" text DEFAULT NULL,
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "vpa" ON "zt_qr_code" ("vpa");
CREATE INDEX "acquirer_qrc" ON "zt_qr_code" ("acquirer");
CREATE INDEX "softpos_terNO" ON "zt_qr_code" ("softpos_terNO");
CREATE INDEX "sub_merchantId" ON "zt_qr_code" ("sub_merchantId");
CREATE INDEX "clientid_qrc" ON "zt_qr_code" ("clientid");




CREATE TABLE "zt_reason_table" (
  "id" int NOT NULL,
  "category" varchar(255) DEFAULT NULL,
  "status_nm" varchar(3) DEFAULT NULL,
  "status" varchar(150) DEFAULT NULL,
  "new_reasons" varchar(255) DEFAULT NULL,
  "reason" varchar(255) DEFAULT NULL,
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "reason_rt" ON "zt_reason_table" ("reason");



CREATE TABLE "zt_request_trans_table" (
  "id" int NOT NULL,
  "clientid" int DEFAULT NULL,
  "fullname" varchar(200) DEFAULT NULL,
  "receiver_email" varchar(90) DEFAULT NULL,
  "amount" varchar(50) DEFAULT NULL,
  "comments" text DEFAULT NULL,
  "transactioncode" varchar(240) DEFAULT NULL,
  "address" varchar(255) DEFAULT NULL,
  "phone" varchar(11) DEFAULT '',
  "active" int NOT NULL DEFAULT 0,
  "status" varchar(100) NOT NULL DEFAULT 'Pending',
  "transID" varchar(240) DEFAULT NULL,
  "json_value" text DEFAULT NULL,
  "category" int DEFAULT 0,
  "product_name" varchar(175) DEFAULT NULL,
  "currency" varchar(10) DEFAULT NULL,
  "created_date" timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  "invoice_no" varchar(50) DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "clientid_rtt" ON "zt_request_trans_table" ("clientid");
CREATE INDEX "receiver_email_rtt" ON "zt_request_trans_table" ("receiver_email");
CREATE INDEX "transactioncode_rtt" ON "zt_request_trans_table" ("transactioncode"(240));
CREATE INDEX "transID_rtt" ON "zt_request_trans_table" ("transID");
CREATE INDEX "invoice_rtt" ON "zt_request_trans_table" ("invoice_no");
CREATE INDEX "status_rtt" ON "zt_request_trans_table" ("status");
CREATE INDEX "active_rtt" ON "zt_request_trans_table" ("active");
CREATE INDEX "fullname_rtt" ON "zt_request_trans_table" ("fullname");
CREATE INDEX "amount_rtt" ON "zt_request_trans_table" ("amount");
  
  
  




CREATE TABLE "zt_salt_management" (
  "id" int NOT NULL,
  "salt_key" varchar(100) DEFAULT NULL,
  "tid" varchar(240) DEFAULT NULL,
  "salt_name" varchar(400) DEFAULT NULL,
  "comments" varchar(2000) DEFAULT NULL,
  "udate" varchar(90) DEFAULT NULL,
  "cdate" timestamp(6) NULL DEFAULT current_timestamp(6),
  "bank_json" text DEFAULT NULL,
  "bank_salt" text DEFAULT NULL,
  "salt_status" int NOT NULL DEFAULT 1,
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id")
);



CREATE TABLE "zt_softpos_setting" (
  "id" int NOT NULL,
  "clientid" int DEFAULT NULL,
  "sub_merchantId" varchar(20) NOT NULL,
  "softpos_terNO" varchar(100) DEFAULT NULL,
  "acquirer" varchar(20) DEFAULT NULL,
  "softpos_pa" varchar(240) DEFAULT NULL,
  "softpos_pn" varchar(240) DEFAULT NULL,
  "softpos_public_key" varchar(240) DEFAULT NULL,
  "vpa" varchar(250) NOT NULL,
  "qr_fullname" varchar(50) DEFAULT NULL,
  "qr_email" varchar(250) DEFAULT NULL,
  "product_name" varchar(100) DEFAULT NULL,
  "merchantAddressLine" varchar(400) DEFAULT NULL,
  "merchantCity" varchar(100) DEFAULT NULL,
  "merchantState" varchar(100) DEFAULT NULL,
  "merchantPinCode" varchar(20) DEFAULT NULL,
  "mobileNumber" varchar(50) DEFAULT NULL,
  "panNumber" varchar(12) DEFAULT NULL,
  "profile_pic" varchar(255) DEFAULT NULL,
  "currency" varchar(10) DEFAULT NULL,
  "settlementAcSameAsParent" varchar(30) NOT NULL DEFAULT 'Y',
  "softpos_status" int NOT NULL DEFAULT 0,
  "created_date" timestamp(6) NULL DEFAULT current_timestamp(6),
  "json_value" text DEFAULT NULL,
  "json_log_history" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "vpa_ss" ON "zt_softpos_setting" ("vpa");
CREATE INDEX "acquirer_ss" ON "zt_softpos_setting" ("acquirer");
CREATE INDEX "softpos_terNO_ss" ON "zt_softpos_setting" ("softpos_terNO");
CREATE INDEX "sub_merchantId_ss" ON "zt_softpos_setting" ("sub_merchantId");
CREATE INDEX "clientid_ss" ON "zt_softpos_setting" ("clientid");



CREATE TABLE "zt_subadmin" (
  "id" int NOT NULL,
  "username" varchar(250) DEFAULT '',
  "password" varchar(255) DEFAULT '',
  "multiple_merchant_ids" varchar(500) DEFAULT NULL,
  "multiple_subadmin_ids" varchar(500) DEFAULT NULL,
  "email" varchar(250) DEFAULT '',
  "active" int DEFAULT 0,
  "fullname" varchar(250) DEFAULT NULL,
  "fname" varchar(250) DEFAULT '',
  "lname" varchar(250) DEFAULT '',
  "address" varchar(255) DEFAULT '',
  "city" varchar(250) DEFAULT '',
  "country" varchar(250) DEFAULT '',
  "state" varchar(250) DEFAULT '',
  "zip" varchar(50) DEFAULT '',
  "phone" varchar(11) DEFAULT '',
  "fax" varchar(25) DEFAULT '',
  "access_id" int DEFAULT 0,
  "description" text DEFAULT NULL,
  "upload_logo" varchar(250) DEFAULT NULL,
  "logo_path" varchar(250) DEFAULT NULL,
  "upload_css" varchar(250) DEFAULT NULL,
  "custom_css" text DEFAULT NULL,
  "domain_name" varchar(250) DEFAULT NULL,
  "domain_active" smallint DEFAULT 0,
  "bussiness_url" varchar(250) DEFAULT NULL,
  "customer_service_no" varchar(250) DEFAULT NULL,
  "customer_service_email" varchar(250) DEFAULT NULL,
  "associate_contact_us_url" varchar(250) DEFAULT NULL,
  "filter_date" timestamp(6) DEFAULT NULL,
  "more_details" text DEFAULT NULL,
  "google_auth_code" varchar(255) DEFAULT NULL,
  "google_auth_access" smallint DEFAULT 0,
  "daily_password_count" text DEFAULT NULL,
  "password_updated_date" timestamp(6) DEFAULT NULL,
  "previous_passwords" text DEFAULT NULL,
  "ip_block_admin_time" varchar(100) DEFAULT NULL,
  "display_json" text DEFAULT NULL,
  "front_ui" varchar(240) DEFAULT NULL,
  "header_bg_color" varchar(255) DEFAULT NULL,
  "header_text_color" varchar(20) DEFAULT NULL,
  "body_bg_color" varchar(255) NOT NULL,
  "body_text_color" varchar(20) NOT NULL,
  "heading_bg_color" varchar(255) NOT NULL,
  "heading_text_color" varchar(20) NOT NULL,
  "front_ui_panel" varchar(50) NOT NULL,
  "json_log_history" text DEFAULT NULL,
  "dashboard_notice" text DEFAULT NULL,
  "notice_type" int NOT NULL DEFAULT 1,
  "stats_success_color" varchar(10) DEFAULT NULL,
  "stats_failed_color" varchar(10) DEFAULT NULL,
  "display_json_subadmin" text DEFAULT NULL,
  "ip_block_client" varchar(125) DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "username_sa" ON "zt_subadmin" ("username");
CREATE INDEX "password_sa" ON "zt_subadmin" ("password");
CREATE INDEX "email_sa" ON "zt_subadmin" ("email");
CREATE INDEX "active_sa" ON "zt_subadmin" ("active");
CREATE INDEX "access_id_sa" ON "zt_subadmin" ("access_id");
CREATE INDEX "fullname_sa" ON "zt_subadmin" ("fullname");
CREATE INDEX "multiple_merchant_ids" ON "zt_subadmin" ("multiple_merchant_ids");
CREATE INDEX "multiple_subadmin_ids" ON "zt_subadmin" ("multiple_subadmin_ids");
CREATE INDEX "fname_sa" ON "zt_subadmin" ("fname");
CREATE INDEX "lname_sa" ON "zt_subadmin" ("lname");
CREATE INDEX "address_sa" ON "zt_subadmin" ("address");
CREATE INDEX "city_sa" ON "zt_subadmin" ("city");
CREATE INDEX "country_sa" ON "zt_subadmin" ("country");
CREATE INDEX "state_sa" ON "zt_subadmin" ("state");
CREATE INDEX "zip_sa" ON "zt_subadmin" ("zip");
CREATE INDEX "phone_sa" ON "zt_subadmin" ("phone");
CREATE INDEX "fax_sa" ON "zt_subadmin" ("fax");
CREATE INDEX "upload_logo" ON "zt_subadmin" ("upload_logo");
CREATE INDEX "logo_path" ON "zt_subadmin" ("logo_path");
CREATE INDEX "upload_css" ON "zt_subadmin" ("upload_css");
CREATE INDEX "domain_name" ON "zt_subadmin" ("domain_name");
CREATE INDEX "domain_active" ON "zt_subadmin" ("domain_active");
CREATE INDEX "bussiness_url" ON "zt_subadmin" ("bussiness_url");
CREATE INDEX "customer_service_no" ON "zt_subadmin" ("customer_service_no");
CREATE INDEX "customer_service_email" ON "zt_subadmin" ("customer_service_email");
CREATE INDEX "associate_contact_us_url" ON "zt_subadmin" ("associate_contact_us_url");
CREATE INDEX "filter_date" ON "zt_subadmin" ("filter_date");
CREATE INDEX "google_auth_code_sa" ON "zt_subadmin" ("google_auth_code");
CREATE INDEX "google_auth_access_sa" ON "zt_subadmin" ("google_auth_access");
CREATE INDEX "password_updated_date_sa" ON "zt_subadmin" ("password_updated_date");
CREATE INDEX "ip_block_admin_time_sa" ON "zt_subadmin" ("ip_block_admin_time");
CREATE INDEX "front_ui" ON "zt_subadmin" ("front_ui");
CREATE INDEX "header_bg_color" ON "zt_subadmin" ("header_bg_color");
CREATE INDEX "header_text_color" ON "zt_subadmin" ("header_text_color");
CREATE INDEX "body_bg_color" ON "zt_subadmin" ("body_bg_color");
CREATE INDEX "body_text_color" ON "zt_subadmin" ("body_text_color");
CREATE INDEX "heading_bg_color" ON "zt_subadmin" ("heading_bg_color");
CREATE INDEX "heading_text_color" ON "zt_subadmin" ("heading_text_color");
CREATE INDEX "front_ui_panel" ON "zt_subadmin" ("front_ui_panel");
CREATE INDEX "notice_type" ON "zt_subadmin" ("notice_type");
CREATE INDEX "stats_success_color" ON "zt_subadmin" ("stats_success_color");
CREATE INDEX "stats_failed_color" ON "zt_subadmin" ("stats_failed_color");
CREATE INDEX "ip_block_client_sa" ON "zt_subadmin" ("ip_block_client");




CREATE TABLE "zt_support_tickets" (
  "id" int NOT NULL,
  "clientid" int DEFAULT NULL,
  "subject" varchar(255) DEFAULT NULL,
  "date" varchar(90) DEFAULT NULL,
  "comments" text DEFAULT NULL,
  "reply_date" varchar(90) DEFAULT NULL,
  "reply_comments" text DEFAULT NULL,
  "ticketid" varchar(200) DEFAULT NULL,
  "bankaccount" varchar(90) DEFAULT '',
  "filterid" int NOT NULL DEFAULT 0,
  "active" int NOT NULL DEFAULT 1,
  "status" int NOT NULL DEFAULT 0,
  "message_type" varchar(1000) DEFAULT NULL,
  "more_photograph_upload" text DEFAULT NULL,
  "admin_doc" text DEFAULT NULL,
  "read_remark" int DEFAULT NULL,
  "json_value" text DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "owner_st" ON "zt_support_tickets" ("clientid");
CREATE INDEX "status_st" ON "zt_support_tickets" ("status");
CREATE INDEX "ticketid_st" ON "zt_support_tickets" ("ticketid");



CREATE TABLE "zt_swift_code" (
  "id" int NOT NULL,
  "bank" varchar(255) DEFAULT NULL,
  "city" varchar(100) DEFAULT NULL,
  "branch" varchar(255) DEFAULT NULL,
  "swift_code" varchar(20) DEFAULT NULL,
  "country" varchar(100) DEFAULT NULL,
  "country_code" varchar(20) DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "swift_code" ON "zt_swift_code" ("swift_code");






CREATE TABLE "zt_terminal" (
  "id" serial PRIMARY KEY,
  "merID" int DEFAULT 0,
  "public_key" varchar(255) DEFAULT NULL,
  "acquirerIDs" varchar(240) DEFAULT NULL,
  "bussiness_url" varchar(240) NOT NULL,
  "ter_name" varchar(255) DEFAULT NULL,
  "terminal_type" varchar(240) NOT NULL,
  "business_description" text DEFAULT NULL,
  "business_nature" varchar(255) DEFAULT NULL,
  "active" smallint DEFAULT 0,
  "tarns_alert_email" varchar(240) DEFAULT NULL,
  "mer_trans_alert_email" varchar(240) DEFAULT NULL,
  "dba_brand_name" varchar(240) DEFAULT NULL,
  "customer_service_no" varchar(240) DEFAULT NULL,
  "customer_service_email" varchar(240) DEFAULT NULL,
  "merchant_term_condition_url" varchar(240) DEFAULT NULL,
  "merchant_refund_policy_url" varchar(240) DEFAULT NULL,
  "merchant_privacy_policy_url" varchar(240) DEFAULT NULL,
  "merchant_contact_us_url" varchar(240) DEFAULT NULL,
  "merchant_logo_url" varchar(240) DEFAULT NULL,
  "curling_access_key" varchar(100) DEFAULT NULL,
  "terNO_json_value" text DEFAULT NULL,
  "select_templates" int DEFAULT NULL,
  "select_templates_log" text DEFAULT NULL,
  "json_log_history" jsonb DEFAULT NULL,
  "deleted_bussiness_url" text DEFAULT NULL,
  "checkout_theme" varchar(240) DEFAULT NULL,
  "select_mcc" varchar(240) DEFAULT NULL,
  "webhook_url" text DEFAULT NULL,
  "return_url" text DEFAULT NULL
);

\d zt_terminal;
--nextval('zt_terminal_id_seq'::regclass)

create sequence zt_terminal_id_seq
   owned by zt_terminal.id;

alter table zt_terminal
   alter column id set default nextval('zt_terminal_id_seq');
   
ALTER SEQUENCE zt_terminal_id_seq RESTART 474;

commit;


-- DROP TABLE zt_terminal;

--ALTER SEQUENCE zt_terminal RESTART 474;
ALTER TABLE zt_terminal MODIFY COLUMN id INT AUTO_INCREMENT=474;



CREATE INDEX "merID" ON "zt_terminal" ("merID");

CREATE INDEX "merID_ter" ON "zt_terminal" ("merID");
CREATE INDEX "public_key" ON "zt_terminal" ("public_key");
CREATE INDEX "acquirerIDs" ON "zt_terminal" ("acquirerIDs");
CREATE INDEX "active_ter" ON "zt_terminal" ("active");
CREATE INDEX "ter_name" ON "zt_terminal" ("ter_name");
CREATE INDEX "select_mcc_ter" ON "zt_terminal" ("select_mcc");
CREATE INDEX "payin_1_ter" ON "zt_terminal" ("id","public_key","merID");
CREATE INDEX "payin_2_ter" ON "zt_terminal" ("public_key");
CREATE INDEX "bussiness_url_ter" ON "zt_terminal" ("bussiness_url");
CREATE INDEX "terminal_type" ON "zt_terminal" ("terminal_type");
CREATE INDEX "business_nature" ON "zt_terminal" ("business_nature");
CREATE INDEX "tarns_alert_email" ON "zt_terminal" ("tarns_alert_email");
CREATE INDEX "mer_trans_alert_email" ON "zt_terminal" ("mer_trans_alert_email");
CREATE INDEX "dba_brand_name" ON "zt_terminal" ("dba_brand_name");
CREATE INDEX "customer_service_no_ter" ON "zt_terminal" ("customer_service_no");
CREATE INDEX "customer_service_email_ter" ON "zt_terminal" ("customer_service_email");
CREATE INDEX "merchant_term_condition_url" ON "zt_terminal" ("merchant_term_condition_url");
CREATE INDEX "merchant_refund_policy_url" ON "zt_terminal" ("merchant_refund_policy_url");
CREATE INDEX "merchant_privacy_policy_url" ON "zt_terminal" ("merchant_privacy_policy_url");
CREATE INDEX "merchant_contact_us_url" ON "zt_terminal" ("merchant_contact_us_url");
CREATE INDEX "merchant_logo_url" ON "zt_terminal" ("merchant_logo_url");
CREATE INDEX "curling_access_key" ON "zt_terminal" ("curling_access_key");
CREATE INDEX "select_templates" ON "zt_terminal" ("select_templates");
CREATE INDEX "checkout_theme" ON "zt_terminal" ("checkout_theme");





CREATE TABLE "zt_timestamp_table" (
  "id" int NOT NULL,
  "name" varchar(240) NOT NULL,
  "title" varchar(240) DEFAULT NULL,
  "comments" varchar(2000) DEFAULT NULL,
  "udate" timestamp(6) NULL DEFAULT NULL,
  "cdate" timestamp(6) NULL DEFAULT current_timestamp(6),
  PRIMARY KEY ("id")
);

CREATE INDEX "name_time" ON "zt_timestamp_table" ("name");




CREATE TABLE "zt_unregistered_clientid" (
  "id" int NOT NULL,
  "newuser" varchar(240) DEFAULT '',
  "newmail" varchar(500) DEFAULT '',
  "newfullname" varchar(100) DEFAULT NULL,
  "sponsor" int DEFAULT 0,
  "confirm" varchar(255) DEFAULT '',
  "created_date" timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  PRIMARY KEY ("id")
);

CREATE INDEX "newuser_unc" ON "zt_unregistered_clientid" ("newuser");
CREATE INDEX "newmail_unc" ON "zt_unregistered_clientid" ("newmail");
CREATE INDEX "confirm_unc" ON "zt_unregistered_clientid" ("confirm");
CREATE INDEX "sponsor_unc" ON "zt_unregistered_clientid" ("sponsor");
CREATE INDEX "newfullname_unc" ON "zt_unregistered_clientid" ("newfullname");





<<auto INCREMENT id -------------------------------

	create sequence zt_access_level_id_seq owned by zt_access_level.id; alter table zt_access_level alter column id set default nextval('zt_access_level_id_seq');
create sequence zt_access_roles_id_seq owned by zt_access_roles.id; alter table zt_access_roles alter column id set default nextval('zt_access_roles_id_seq');
create sequence zt_acquirer_group_template_id_seq owned by zt_acquirer_group_template.id; alter table zt_acquirer_group_template alter column id set default nextval('zt_acquirer_group_template_id_seq');
create sequence zt_acquirer_table_id_seq owned by zt_acquirer_table.id; alter table zt_acquirer_table alter column id set default nextval('zt_acquirer_table_id_seq');
create sequence zt_api_card_table_id_seq owned by zt_api_card_table.id; alter table zt_api_card_table alter column id set default nextval('zt_api_card_table_id_seq');
create sequence zt_api_data_table_id_seq owned by zt_api_data_table.id; alter table zt_api_data_table alter column id set default nextval('zt_api_data_table_id_seq');
create sequence zt_auto_settlement_request_id_seq owned by zt_auto_settlement_request.id; alter table zt_auto_settlement_request alter column id set default nextval('zt_auto_settlement_request_id_seq');
create sequence zt_bank_payout_table_id_seq owned by zt_bank_payout_table.id; alter table zt_bank_payout_table alter column id set default nextval('zt_bank_payout_table_id_seq');
create sequence zt_banks_id_seq owned by zt_banks.id; alter table zt_banks alter column id set default nextval('zt_banks_id_seq');
create sequence zt_blacklist_data_id_seq owned by zt_blacklist_data.id; alter table zt_blacklist_data alter column id set default nextval('zt_blacklist_data_id_seq');
create sequence zt_clientid_emails_id_seq owned by zt_clientid_emails.id; alter table zt_clientid_emails alter column id set default nextval('zt_clientid_emails_id_seq');
create sequence zt_coin_wallet_id_seq owned by zt_coin_wallet.id; alter table zt_coin_wallet alter column id set default nextval('zt_coin_wallet_id_seq');
create sequence zt_currency_exchange_table_id_seq owned by zt_currency_exchange_table.id; alter table zt_currency_exchange_table alter column id set default nextval('zt_currency_exchange_table_id_seq');
create sequence zt_email_details_id_seq owned by zt_email_details.id; alter table zt_email_details alter column id set default nextval('zt_email_details_id_seq');
create sequence zt_emails_templates_id_seq owned by zt_emails_templates.id; alter table zt_emails_templates alter column id set default nextval('zt_emails_templates_id_seq');
create sequence zt_json_log_id_seq owned by zt_json_log.id; alter table zt_json_log alter column id set default nextval('zt_json_log_id_seq');
create sequence zt_emails_templates_deleted_id_seq owned by zt_emails_templates_deleted.id; alter table zt_emails_templates_deleted alter column id set default nextval('zt_emails_templates_deleted_id_seq');
create sequence zt_login_ip_history_id_seq owned by zt_login_ip_history.id; alter table zt_login_ip_history alter column id set default nextval('zt_login_ip_history_id_seq');
create sequence zt_mcc_code_id_seq owned by zt_mcc_code.id; alter table zt_mcc_code alter column id set default nextval('zt_mcc_code_id_seq');
create sequence zt_mop_table_id_seq owned by zt_mop_table.id; alter table zt_mop_table alter column id set default nextval('zt_mop_table_id_seq');
create sequence zt_payout_request_id_seq owned by zt_payout_request.id; alter table zt_payout_request alter column id set default nextval('zt_payout_request_id_seq');
create sequence zt_payout_setting_id_seq owned by zt_payout_setting.id; alter table zt_payout_setting alter column id set default nextval('zt_payout_setting_id_seq');
create sequence zt_qr_code_id_seq owned by zt_qr_code.id; alter table zt_qr_code alter column id set default nextval('zt_qr_code_id_seq');
create sequence zt_reason_table_id_seq owned by zt_reason_table.id; alter table zt_reason_table alter column id set default nextval('zt_reason_table_id_seq');
create sequence zt_request_trans_table_id_seq owned by zt_request_trans_table.id; alter table zt_request_trans_table alter column id set default nextval('zt_request_trans_table_id_seq');
create sequence zt_salt_management_id_seq owned by zt_salt_management.id; alter table zt_salt_management alter column id set default nextval('zt_salt_management_id_seq');
create sequence zt_softpos_setting_id_seq owned by zt_softpos_setting.id; alter table zt_softpos_setting alter column id set default nextval('zt_softpos_setting_id_seq');
create sequence zt_subadmin_id_seq owned by zt_subadmin.id; alter table zt_subadmin alter column id set default nextval('zt_subadmin_id_seq');
create sequence zt_support_tickets_id_seq owned by zt_support_tickets.id; alter table zt_support_tickets alter column id set default nextval('zt_support_tickets_id_seq');
create sequence zt_swift_code_id_seq owned by zt_swift_code.id; alter table zt_swift_code alter column id set default nextval('zt_swift_code_id_seq');
create sequence zt_timestamp_table_id_seq owned by zt_timestamp_table.id; alter table zt_timestamp_table alter column id set default nextval('zt_timestamp_table_id_seq');
create sequence zt_unregistered_clientid_id_seq owned by zt_unregistered_clientid.id; alter table zt_unregistered_clientid alter column id set default nextval('zt_unregistered_clientid_id_seq');


create sequence zt_mer_setting_id_seq owned by zt_mer_setting.id; 
alter table zt_mer_setting alter column id set default nextval('zt_mer_setting_id_seq');

	create sequence zt_master_trans_table_3_id_seq owned by zt_master_trans_table_3.id; alter table zt_master_trans_table_3 alter column id set default nextval('zt_master_trans_table_3_id_seq');
create sequence zt_clientid_table_id_seq owned by zt_clientid_table.id; alter table zt_clientid_table alter column id set default nextval('zt_clientid_table_id_seq');
create sequence zt_payin_setting_id_seq owned by zt_payin_setting.id; alter table zt_payin_setting alter column id set default nextval('zt_payin_setting_id_seq');
create sequence zt_terminal_id_seq owned by zt_terminal.id; alter table zt_terminal alter column id set default nextval('zt_terminal_id_seq');





<<auto INCREMENT id -------------------------------


SELECT setval('zt_mer_setting_id_seq', (SELECT MAX(id) FROM zt_mer_setting)+1);

create sequence zt_mer_setting_id_seq
   owned by zt_mer_setting.id;

alter table zt_mer_setting
   alter column id set default nextval('zt_mer_setting_id_seq');

commit;


create sequence zt_master_trans_table_3_id_seq
   owned by zt_master_trans_table_3.id;

alter table zt_master_trans_table_3
   alter column id set default nextval('zt_master_trans_table_3_id_seq');

commit;


 
 create sequence zt_clientid_table_id_seq
   owned by zt_clientid_table.id;

alter table zt_clientid_table
   alter column id set default nextval('zt_clientid_table_id_seq');
   
ALTER SEQUENCE zt_clientid_table_id_seq RESTART 271;

commit;



create sequence payin_setting_id_seq
   owned by payin_setting.id;

alter table payin_setting
   alter column id set default nextval('payin_setting_id_seq');

commit;

-- {"Error":"5010","Message":"Email SIGNUP-TO-MEMBER template does not exist."}



create sequence zt_terminal_id_seq
   owned by zt_terminal.id;

alter table zt_terminal
   alter column id set default nextval('zt_terminal_id_seq');
   
ALTER SEQUENCE zt_terminal_id_seq RESTART 50;

commit;



create sequence db_test_id_seq
   owned by db_test.id;

alter table db_test
   alter column id set default nextval('db_test_id_seq');
   
ALTER SEQUENCE db_test_id_seq RESTART 50;


CREATE SEQUENCE db_test_id_seq
  start 50
  increment 1;


commit;


select COUNT(id) from zt_terminal;
COMMIT;


SELECT "t".* ,"ad".* FROM "zt_master_trans_table_3" AS "t" LEFT JOIN "zt_master_trans_additional_3" AS "ad" ON "t"."id" = "ad"."id_ad" ORDER BY "t"."tdate" DESC  LIMIT 51 OFFSET 0;






<<psql instance - start ######################################################


https://13.233.162.247/phpinfo.php

apt update
php -v

https://ubuntu.com/server/docs/databases-postgresql
https://vegibit.com/how-to-use-postgresql-with-php/


apt install php8.2-pgsql -y

apt remove --auto-remove php8.2-pgsql
apt remove php8.2-pgsql
apt remove purge php8.2-pgsql
sudo apt autoclean && sudo apt autoremove


https://www.postgresql.org/download/linux/ubuntu/

apt install postgresql
apt install php8.1-pgsql -y

psql --version

service postgresql status
netstat -tulpn

cd /etc/postgresql/14/main
cp postgresql.conf postgresql.conf_origial
vi postgresql.conf
	listen_addresses = '*'          # what IP address(es) to listen on;
	
cp pg_hba.conf pg_hba.conf_origial
vi pg_hba.conf
	host    all             all             0.0.0.0/0           md5
	
/etc/init.d/postgresql restart
/etc/init.d/postgresql status

systemctl enable postgresql

netstat -lntp | grep postgres
nmap server -p 5432


##############################################################

su - postgres
psql


CREATE DATABASE pgslqdb31 WITH OWNER = postgres ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE pgslqdb31 TO postgres;



<<final psql export & <<import db data from instance  ########################################

pg_dump -h localhost -p 5432 -U pgslquser pgdb31 > pgdb31_24_01_20.sql
yzKtkQnma%samtDzqG2JZML9TRpFb

/home/devtech/upload/pgdb31_24_01_20.zip

scp -3 -P 210 -r -i /root/sshPemkey devtech@172.31.39.54:/home/devtech/upload/pgdb31_24_01_20.zip  /home/devtech/db_psql

psql -h localhost -p 5432 -U pgslquser -d pgdb31 -f pgwdb_23_12_19.sql
yzKtkQnma%samtDzqG2JZML9TRpFb

CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb' SUPERUSER;
CREATE DATABASE ipglivepgdb31 WITH OWNER = pgslquser ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE ipglivepgdb31 TO pgslquser;

\i E:/db/psql/pgdb31_24_01_20/pgdb31_24_01_20.sql

pgAdmin 4 in window loacalhot 
\q
or cd from cmd
C:\Program Files\PostgreSQL\16\bin
psql -h localhost -p 3306 -U pgslquser -d ipglivepgdb31 -f E:\db\psql\pgdb31_24_01_20\pgdb31_24_01_20.sql


CREATE USER pgslquser WITH PASSWORD 'amtDzqG2JZMLyzKta%s9TRpFbkQnm' SUPERUSER;
CREATE DATABASE livepsqldb30 WITH OWNER = pgslquser ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE livepsqldb30 TO pgslquser;
\q
C:\Program Files\PostgreSQL\16\pgAdmin 4\runtime>
psql -h localhost -p 3306 -U pgslquser -d livepsqldb30 -f E:\db\psql\pgdb31_24_01_20\pgdb31_24_01_20.sql

select count(*) as count from zt_api_card_table limit 1
select * from zt_api_card_table 

cmd
cd C:\Program Files\PostgreSQL\16\bin
pg_dump -h localhost -p 3306 -U pgslquser livepsqldb30 > E:\db\dump_psql_24_01_20.sql

pg_dump -h localhost -p 3306 -U pgslquser livepsqldb30 > E:\db\livepsqldb30_psql_data_24_01_23.sql
yzKtkQnma%samtDzqG2JZML9TRpFb

pg_dump -h localhost -p 3306 -U postgres ipgdb > E:\db\ipgdb_psql_data_24_01_23.sql

pg_dump -h localhost -p 3306 -U pgslquser ipglivepgdb31 > E:\db\ipglivepgdb31_psql_data_24_01_23.sql



ssh -p 210 -i /root/sshPemkey sandeep@172.31.41.189

mysqldump -u root -p --compatible=postgresql --no-create-db --no-create-info --extended-insert --complete-insert --add-drop-table --add-locks --allow-keywords --lock-tables --quote-names --skip-opt --single-transaction --max_allowed_packet=1G dbnamegwdo31 zt_access_level zt_access_roles zt_acquirer_group_template zt_acquirer_table zt_api_card_table zt_api_data_table zt_auto_settlement_request zt_bank_payout_table zt_banks zt_blacklist_data zt_clientid_emails zt_clientid_table zt_coin_wallet zt_currency_exchange_table zt_emails_templates zt_mcc_code zt_mer_setting zt_mop_table zt_payin_setting zt_payout_request zt_payout_setting zt_qr_code zt_reason_table zt_request_trans_table zt_salt_management zt_softpos_setting zt_subadmin zt_support_tickets zt_swift_code zt_terminal zt_timestamp_table > dbnamegwdo31_data_2024_01_20.sql


--compatible=postgresql --no-create-db --no-create-info --extended-insert --complete-insert --add-drop-table --add-locks --allow-keywords --lock-tables --quote-names --skip-opt --single-transaction --max_allowed_packet=1G

sed -i 's/\\//g' dbnamegwdo31_data_2024_01_20.sql
sed -i 's/`/"/g' dbnamegwdo31_data_2024_01_20.sql
sed -i 's/`/"/g' dbnamegwdo31_data_24_01_20.sql
sed -i 's/UNLOCK TABLES/--UNLOCK TABLES/g' dbnamegwdo31_data_2024_01_20.sql
sed -i 's/LOCK TABLES/--LOCK TABLES/g' dbnamegwdo31_data_2024_01_20.sql

r’s

sed -e 's/\\//g' dbnamegwdo31_data_2024_01_20.sql


/home/sandeep/upload/dbnamegwdo31_data_2024_01_20.zip


scp -3 -P 210 -r -i /root/sshPemkey sandeep@172.31.41.189:/home/sandeep/upload/dbnamegwdo31_data_2024_01_20.zip /home/mithileshk/upload

\i E:/db/lets/dbnamegwdo31_data_2024_01_20/dbnamegwdo31_data_2024_01_20.sql


--skip-add-drop-table --skip-add-locks --skip-disable-keys --skip-set-charset


mysqldump -u root -P 3307 --compatible=postgresql --skip-comments  --no-create-db --no-create-info --extended-insert --complete-insert --add-drop-table --add-locks --allow-keywords --lock-tables --quote-names --skip-opt --single-transaction --max_allowed_packet=1G  dbnamegwdo31 zt_softpos_setting > E:\db\lets\zt_softpos_setting.sql

mysqldump -u root -P 3307 --compatible=postgresql --skip-comments  --no-create-db --no-create-info --extended-insert --complete-insert --skip-add-drop-table --skip-add-locks --skip-disable-keys --skip-set-charset --allow-keywords --lock-tables --quote-names --skip-opt --single-transaction --max_allowed_packet=1G  dbnamegwdo31 zt_softpos_setting > E:\db\lets\zt_softpos_setting.sql

\i E:/db/lets/dbnamegwdo31_data_24_01_20.sql
\i E:/db/lets/client_data_24_01_20.sql
\i E:/db/lets/zt_softpos_setting.sql

UPDATE zt_acquirer_group_template SET json_log_history=NULL

UPDATE zt_softpos_setting SET json_log_history=NULL
UPDATE zt_softpos_setting SET created_date=NULL WHERE created_date='0000-00-00 00:00:00' OR  created_date='';

UPDATE zt_bank_payout_table SET json_log_history=NULL
UPDATE zt_bank_payout_table SET history_json=NULL

UPDATE zt_clientid_table SET json_value=NULL


UPDATE zt_clientid_table SET password_updated_date=NULL WHERE password_updated_date='0000-00-00 00:00:00' OR  password_updated_date='';
UPDATE zt_clientid_table SET last_login_date=NULL WHERE last_login_date='0000-00-00 00:00:00' OR  last_login_date='';
UPDATE zt_clientid_table SET created_date=NULL WHERE created_date='0000-00-00 00:00:00' OR  created_date='';

UPDATE zt_acquirer_table SET inactive_start_time=NULL WHERE inactive_start_time='0000-00-00 00:00:00' OR  inactive_start_time='';
UPDATE zt_acquirer_table SET inactive_end_time=NULL WHERE inactive_end_time='0000-00-00 00:00:00' OR  inactive_end_time='';


<<final psql export data from <<export localhost ########################################

/Library/PostgreSQL/16
/Library/PostgreSQL/16/bin
/Library/PostgreSQL/16/data
Password : 2024
Port : 5432



########################################################################


cmd
cd C:\Program Files\PostgreSQL\16\bin

pg_dump -h localhost -p 5432 -U postgres payoutdbgw > E:\db\payoutdbgw_psql_data_24_03_22.sql
pg_dump -h localhost -p 5432 -U postgres webhookdb > E:\db\webhookdb_psql_data_24_03_22.sql

Only data 
pg_dump -h localhost -p 5432 -U postgres --column-inserts --data-only -t zt_master_trans_table_3 -t zt_master_trans_additional_3 pgwdb  > E:\db\pgwdb_ad_24_03_30.sql

pg_dump -h localhost -p 5432 -U postgres -s -t zt_master_trans_table_3 -t zt_master_trans_additional_3 -d pgwdb  > E:\db\pgwdb_s_ad_24_03_30.sql

<<All data with all table but not zt_master_trans_table_3 & zt_master_trans_additional_3
pg_dump -h localhost -p 5432 -U postgres -T zt_master_trans_table_3 -T zt_master_trans_additional_3 -d pgwdb  > E:\db\pgwdb_da_ad_24_03_30.sql

pg_dump -h localhost -p 5432 -U pgslquser ipglivepgdb31 > E:\db\ipglivepgdb31_psql_data_24_03_15.sql

pg_dump -h localhost -p 5432 -U pgslquser --column-inserts --data-only  --table "zt_acquirer_table" ipglivepgdb31 > E:\db\lets\zt_acquirer_table_2024_03_15.sql


pg_dump -h localhost -p 3306 -U pgslquser livepsqldb30 > E:\db\dump_psql_24_01_20.sql

pg_dump -h localhost -p 3306 -U pgslquser livepsqldb30 > E:\db\livepsqldb30_psql_data_24_01_23.sql
yzKtkQnma%samtDzqG2JZML9TRpFb

pg_dump -h localhost -p 3306 -U postgres ipgdb > E:\db\ipgdb_psql_data_24_01_23.sql






########################################################################


cmd
cd C:\Program Files\PostgreSQL\16\bin
pg_dump -h localhost -p 3306 -U pgslquser --column-inserts --data-only  --table "zt_clientid_table" --table "zt_payin_setting" --table "zt_mer_setting"  --table "zt_terminal" livepsqldb30 > E:\db\lets\livepsqldb30_2024_02_16.sql


cmd
cd C:\Program Files\PostgreSQL\16\bin

pg_dump -h localhost -p 3306 -U postgres pgwdb > E:\db\pgwdb_24_01_20.sql
pg_dump -h localhost -p 3306 -U postgres ipgdb > E:\db\ipgdb_24_02_07.sql
pg_dump -h localhost -p 3306 -U postgres pgwdb > E:\db\pgwdb_24_02_07.sql

//For STRUCTURE only 
pg_dump -h localhost -p 3306 -U postgres -s pgwdb  > E:\db\pgwdb_dump_24_01_20.sql

//For DATA only 
pg_dump -h localhost -p 3306 -U postgres --column-inserts --data-only pgwdb  > E:\db\pgwdb_dump_24_01_20.sql


//For specify table only 
pg_dump -h localhost -p 3306 -U postgres --column-inserts --data-only -t zt_master_trans_table_3 -t zt_master_trans_additional_3 pgwdb  > E:\db\pgwdb_ad_24_01_20.sql

//For specific tables only 
pg_dump -h localhost -p 3306 -U postgres -t "^zt_master_trans*" pgwdb  > E:\db\pgwdb_ma_ad_24_01_20.sql


<<mac os
//For DATA except zt_master_trans_table_3,zt_master_trans_additional_3     

$PATH='/Library/PostgreSQL/16/bin'
export PATH="/usr/local/bin:$PATH"

cd /Library/PostgreSQL/16/bin
sudo su - postgres
2024

pg_dump -U your_username -d your_database_name -t your_table_name > your_table_data.sql

cd /Volumes/M3/db

pg_dump -U postgres -d ipgdb -t "zt_mer_setting" > /Users/MacPro/ipgdb_24_03_30.sql



pg_dump -h localhost -p 5432 -U postgres --exclude-table-data=zt_master_trans_table_3 --exclude-table-data=zt_master_trans_additional_3 ipgdb  > /Volumes/M3/db/ipgdb_24_03_30.sql

pg_dump -h localhost -p 5432 -U postgres --exclude-table-data=zt_master_trans_table_3 --exclude-table-data=zt_master_trans_additional_3 ipgdb  > /Users/MacPro/ipgdb_24_03_30.sql



pg_dump -h localhost -p 5432 -U postgres --exclude-table-data=zt_master_trans_table_3 --exclude-table-data=zt_master_trans_additional_3 pgwdb  > E:\db\pgwdb_24_01_20.sql



scp -3 -P 210 -r -i /root/sshPemkey * devtech@172.31.39.54:/home/devtech/upload
scp -3 -P 210 -r -i /root/sshPemkey pgwdb_23_12_19.sql devtech@172.31.39.54:/home/devtech/upload


##############################################################
<<create user and db with privileges --------------

su - postgres
psql
\l
\c pgdb31

\du
\l
\c pgdb31
\dt

\q

CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb' SUPERUSER;

CREATE DATABASE pgdb31 WITH OWNER = pgslquser ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE pgdb31 TO pgslquser;


CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb' SUPERUSER;
CREATE DATABASE ipglivepgdb31 WITH OWNER = pgslquser ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE ipglivepgdb31 TO pgslquser;



http://13.233.162.247/signins/login
http://13.233.162.247/signins/password?id=21

https://pro.i15.me/signins/login
gwadmn
@aA123456789

$_SESSION['adm_login']=1; $_SESSION['login_adm']=1;$_SESSION['sub_admin_id']=21;

$_SESSION['adm_login']=$_SESSION['login_adm']=1;

##############################################################
<<import --------------
pgslquser

psql -h localhost -p 5432 -U pgslquser -d pgdb31 -f pgwdb_23_12_19.sql
yzKtkQnma%samtDzqG2JZML9TRpFb


		psql -h localhost -p 3306 -U postgres -d ipgdb -f E:\db\pgwdb_23_12_19.sql
		psql -h postgres -p 3306 -U postgres -d pgslqdb31 -f /home/devtech/upload/pgwdb_23_12_19.sql
		psql -h localhost -p 3306 -U postgres -d pgslqdb31 -f /home/devtech/upload/pgwdb_23_12_19.sql

##############################################################


psqldump -u postgres -P 3306 pgwdb > E:\db\localhost\pgwdb_23_12_19.sql

pg_dump pgwdb > E:\db\pgwdb_23_12_19.sql
pg_dump pgwdb > E:/db/pgwdb_23_12_19.sql
pg_dump pgwdb > pgwdb_23_12_19.sql;

PostgreSQLdump -u postgres -p pgwdb >E:\db\pgwdb_23_12_19.sql
PostgreSQLdump -u postgres -p pgwdb >E:\db\pgwdb_23_12_19.sql

pg_dump -h localhost -p 3306 -U postgres pgwdb > E:\db\pgwdb_23_12_19.sql

pg_dump –u postgres pgwdb > pgwdb11.pgsql

pg_dump -U postgres pgwdb | psql -U postgres livepgwdb

pg_dump "pgwdb" > C:\pgwdb.pgsql

\q

pg_dump -U postgres pgwdb > pgwdb66.sql

pg_dump -U postgres -d pgwdb -t {sourceTable} > {dump}.sql
pg_dump -U postgres -d pgwdb > pgwdb_23_12_19.sql


cmd
cd C:\Program Files\PostgreSQL\16\pgAdmin 4\runtime

cd C:\Program Files\PostgreSQL\16\bin

	pg_dump -U postgres -p 3306 -d postgres -W -f E:\db\psql\pgwdb_dump_24_01_02.sql
	
	pg_dump -U postgres -p 3306 -d postgres -W -f E:\db\pgwdb_dump_23_12_19.sql
	yzKtkQnma%samtDzqG2JZML9TRpFb

	pg_dump -U postgres -p 5432 -d postgres -W -f c:\vm\dump.sql

##############################################################



psql -h localhost
psql -U Username postgres
yzKtkQnma%samtDzqG2JZML9TRpFb

create database pgslqdb31;


$db_hostname='172.31.10.183'; //         3306   localhost
$db_username='nextdbuser32';
$db_password='zqG2JZML9TRQnma%samtDpFbyzKtk';//
$db_database='nextgendb32';
$db_tbprefix='zt';



$db_hostname='localhost'; //         3306   localhost
$db_username='pgslquser'; // postgres pgslquser
$db_password='yzKtkQnma%samtDzqG2JZML9TRpFb';//
$db_database='pgslqdb31';
$db_tbprefix='zt';


psql -h localhost



psql -h localhost -p 5432 -U postgress
psql -h 127.0.0.1 -p 5432 -U postgress

yzKtkQnma%samtDzqG2JZML9TRpFb


CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb';

##############################################################

CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb' SUPERUSER;

DROP USER pgslquser;

CREATE USER gwuser SUPERUSER;


##############################################################

su - postgres
psql

CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb' SUPERUSER;

CREATE DATABASE pgdb31 WITH OWNER = pgslquser ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE pgdb31 TO pgslquser;

CREATE DATABASE pgslqdb31 WITH OWNER = postgres ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE pgslqdb31 TO postgres;


<<psql instance - end ######################################################


<<pro 
https://gist.github.com/igniteflow/5670193

--compatible=postgresql  

mysqldump -u root -p nextgendb32 zt_access_level zt_access_roles zt_acquirer_group_template zt_acquirer_table zt_api_card_table zt_api_data_table zt_auto_settlement_request zt_bank_payout_table zt_banks zt_blacklist_data zt_clientid_emails zt_clientid_table zt_coin_wallet zt_currency_exchange_table zt_emails_templates zt_mcc_code zt_mer_setting zt_mop_table zt_payin_setting zt_payout_request zt_payout_setting zt_qr_code zt_reason_table zt_request_trans_table zt_salt_management zt_softpos_setting zt_subadmin zt_support_tickets zt_swift_code zt_terminal zt_timestamp_table > nextgendb32_data_2024_01_19.sql

scp -3 -P 210 -r -i /root/sshPemkey devtech@172.31.10.183:/home/devtech/upload/nextgendb32_data_2024_01_19.zip  /home/devtech/db_psql

mysql -u root -P 3307 nextgendb32ipg < E:\live_nextGenApp20\i15_psql_24_01_15_db\19\nextgendb32_data_2024_01_19\nextgendb32_data_2024_01_19.sql

mysqldump -u root -p nextgendb32 zt_clientid_table zt_coin_wallet zt_banks zt_payin_setting zt_payout_request zt_payout_setting zt_mer_setting zt_terminal > nextgendb32_data_mer_2024_01_15.sql

mysqldump -u root -p nextgendb32 zt_master_trans_table_3 > nextgendb32_data_master_trans_2024_01_15.sql
mysqldump -u root -p nextgendb32 zt_master_trans_additional_3   > nextgendb32_data_trans_additional_2024_01_15.sql
mysqldump -u root -p nextgendb32 zt_access_roles zt_subadmin zt_mcc_code zt_acquirer_table > nextgendb32_data_subadmin_acq_2024_01_15.sql
mysql -u root -P 3307 uploaddbpsql3 < E:\live_nextGenApp20\i15_psql_24_01_15_db\nextgendb32_data_trans_additional_2024_01_15\nextgendb32_data_trans_additional_2024_01_15.sql
mysql -u root -P 3307 dbnamegwdo31 < E:\db\lets\nextgendb32_data_2024_01_19\nextgendb32_data_2024_01_19.sql

source E:\live_nextGenApp20\i15_psql_24_01_15_db\nextgendb32_data_trans_additional_2024_01_15\nextgendb32_data_trans_additional_2024_01_15.sql

/home/devtech/upload/nextgendb32_data_mer_2024_01_15.zip
/home/devtech/upload/nextgendb32_data_master_trans_2024_01_15.zip
/home/devtech/upload/nextgendb32_data_trans_additional_2024_01_15.zip



scp -3 -P 210 -r -i /root/sshPemkey devtech@172.31.10.183:/home/devtech/upload/nextgendb32_data_mer_2024_01_15.zip  /home/devtech/db_psql
scp -3 -P 210 -r -i /root/sshPemkey devtech@172.31.10.183:/home/devtech/upload/nextgendb32_data_master_trans_2024_01_15.zip  /home/devtech/db_psql
scp -3 -P 210 -r -i /root/sshPemkey devtech@172.31.10.183:/home/devtech/upload/nextgendb32_data_trans_additional_2024_01_15.zip  /home/devtech/db_psql
scp -3 -P 210 -r -i /root/sshPemkey devtech@172.31.10.183:/home/devtech/upload/nextgendb32_data_subadmin_acq_2024_01_15.zip  /home/devtech/db_psql


UPDATE `zt_clientid_table` SET `json_log_history`=NULL;
UPDATE `zt_terminal` SET `json_log_history`=NULL;
UPDATE `zt_banks` SET `json_log_history`=NULL;
UPDATE `zt_coin_wallet` SET `json_log_history`=NULL;
UPDATE `zt_payout_request` SET `json_log_history`=NULL;

UPDATE `zt_access_roles` SET `json_log_history`=NULL;
UPDATE `zt_subadmin` SET `json_log_history`=NULL;
UPDATE `zt_mcc_code` SET `json_log_history`=NULL;
UPDATE `zt_acquirer_table` SET `json_log_history`=NULL;


UPDATE `zt_master_trans_additional_3` SET `json_log_history`=NULL;

UPDATE zt_subadmin SET id=20 WHERE id=21;
UPDATE zt_subadmin SET more_details='{"mailgun_from":"Online-Epayment<cs@online-epayment.com>","SiteName":"ePay","mail_gun_api":"api:bc73b879c7d3a32621334c4913981fb5-0e6e8cad-6a6fec66","mail_api_host":"mg.gatewayurl.com","reply_to":"CustomerService<cs@online-epayment.com>"}' WHERE id in (31,32,33,34);

DELETE FROM zt_access_roles;
DELETE FROM zt_acquirer_table;

DELETE FROM zt_master_trans_table_3 WHERE id>26;
DELETE FROM zt_master_trans_additional_3;
DELETE FROM zt_master_trans_table_3;

DELETE FROM zt_clientid_table WHERE id in (272,273,274);

SELECT setval('zt_master_trans_table_3_id_seq', (SELECT MAX(id) FROM zt_master_trans_table_3));


SELECT * FROM `zt_master_trans_table_3` WHERE `trans_amt` IS NULL;



UPDATE zt_master_trans_table_3 SET fee_update_timestamp=NULL WHERE fee_update_timestamp='0000-00-00 00:00:00.000000' or fee_update_timestamp='0000-00-00 00:00:00';
UPDATE zt_master_trans_table_3 SET tdate=NULL WHERE tdate='0000-00-00 00:00:00.000000' or tdate='0000-00-00 00:00:00';
UPDATE zt_master_trans_table_3 SET settelement_date=NULL WHERE settelement_date='0000-00-00 00:00:00.000000' or settelement_date='0000-00-00 00:00:00';
UPDATE zt_master_trans_table_3 SET rolling_date=NULL WHERE rolling_date='0000-00-00 00:00:00.000000' or rolling_date='0000-00-00 00:00:00';
UPDATE zt_master_trans_table_3 SET created_date=NULL WHERE created_date='0000-00-00 00:00:00.000000' or created_date='0000-00-00 00:00:00';
UPDATE zt_master_trans_table_3 SET trans_amt='0.00' WHERE trans_amt IS NULL ;
UPDATE zt_master_trans_table_3 SET buy_mdr_amt='0.00' WHERE buy_mdr_amt IS NULL ;

UPDATE zt_master_trans_table_3 SET sell_mdr_amt='0.00' WHERE sell_mdr_amt IS NULL ;
UPDATE zt_master_trans_table_3 SET buy_txnfee_amt='0.00' WHERE buy_txnfee_amt IS NULL ;
UPDATE zt_master_trans_table_3 SET sell_txnfee_amt='0.00' WHERE sell_txnfee_amt IS NULL ;
UPDATE zt_master_trans_table_3 SET gst_amt='0.00' WHERE gst_amt IS NULL ;
UPDATE zt_master_trans_table_3 SET rolling_amt='0.00' WHERE rolling_amt IS NULL ;

UPDATE zt_master_trans_table_3 SET mdr_cb_amt='0.00' WHERE mdr_cb_amt IS NULL ;
UPDATE zt_master_trans_table_3 SET mdr_cbk1_amt='0.00' WHERE mdr_cbk1_amt IS NULL ;
UPDATE zt_master_trans_table_3 SET mdr_refundfee_amt='0.00' WHERE mdr_refundfee_amt IS NULL ;
UPDATE zt_master_trans_table_3 SET available_rolling='0.00' WHERE available_rolling IS NULL ;
UPDATE zt_master_trans_table_3 SET available_balance='0.00' WHERE available_balance IS NULL ;
UPDATE zt_master_trans_table_3 SET payable_amt_of_txn='0.00' WHERE payable_amt_of_txn IS NULL ;
UPDATE zt_master_trans_table_3 SET bank_processing_amount='0.00' WHERE bank_processing_amount IS NULL ;





\i E:/db/psql/zt_master_trans_table_3_2.sql

mysqldump -u root -P 3307 --compatible=postgresql  --skip-lock-tables --single-transaction uploaddbpsql3 > E:\db\psql\zt_master_trans_additional_3_24_01_16_s.sql
mysqldump -u root -P 3307 --compatible=postgresql  uploaddbpsql3 > E:\db\psql\zt_master_trans_additional_3_24_01_16.sql
mysqldump -u root -P 3307 --compatible=postgresql  uploaddbpsql3  zt_master_trans_additional_3 --where=" id_ad in (201)  " > E:\db\psql\st_3_24_01_16.sql

mysqldump -u root -P 3307 --compatible=postgresql  uploaddbpsql3 | sed -e "s/\\\'/''/g" zt_master_trans_additional_3 --where=" id_ad in (201)  " > E:\db\psql\st_3_24_01_16.sql

sed -i 's/\\//g' sed_nextgendb32_data_2024_01_19.sql
sed -i 's/`/"/g' rsed_nextgendb32_data_2024_01_19.sql
sed -e 's/\\//g' sed_nextgendb32_data_2024_01_19.sql

-- on window


scp -3 -P 210 -r -i /root/sshPemkey * devtech@172.31.39.54:/home/devtech/upload


-- on localhost pgAdmin 4 or psql 
\i E:/db/psql/zt_master_trans_additional_3_24_01_16_1.sql
\i E:/db/psql/st_3_24_01_16.sql
\i E:/db/psql/zt_master_trans_3_24_01_17.sql


-- on instance 
scp -3 -P 210 -r -i /root/sshPemkey * devtech@172.31.39.54:/home/devtech/upload

DROP TABLE zt_master_trans_additional_4;
DROP TABLE zt_master_trans_additional_3;

https://stackoverflow.com/questions/13682739/postgresql-permission-denied-when-reading-from-file-with-i-command

cd /
chmod og+rX /home /home/devtech
chmod og+rX /home /home/mithileshk

\i /home/devtech/upload/zt_master_trans_additional_3_24_01_16_1.sql
\i /home/mithileshk/db_psql/livepsqldb30_psql_data_24_01_23.sql

scp -3 -P 210 -r -i /root/sshPemkey * devtech@172.31.39.54:/home/devtech/upload


\i /home/devtech/upload/zt_master_trans_3_24_01_17.sql

SELECT setval('zt_master_trans_table_3_id_seq', (SELECT MAX(id) FROM zt_master_trans_table_3));

select * from zt_master_trans_table_3 order by id desc limit 2
17647  	871764726  	1705314130-735391  	0  	2024-01-15 15:53:26.4278  	109.15  	USD
17646  	871764653  	82996  	0  	2024-01-15 15:50:53.4744  	12  	EUR  


select * from zt_master_trans_table_3 order by id desc limit 2
18810  	461881037  	clrh9x3d406squkvnbpqxf0lv  	0  	2024-01-17 09:49:37.1381  	22.5  	USD  
18809  	871880943  	ec3b0248-0b93-4e3e-a6fb-e885b3478339  	0  	2024-01-17 09:48:01.6281  	21.8  	USD   


select count(*) as count from zt_master_trans_table_3 where id > 18810 limit 1



select count(*) as count from zt_master_trans_table_3 where id > 17647 limit 1
1163  
mysqldump -u root -p nextgendb32 zt_master_trans_table_3 --where=" id > 17647  " > nextgendb32_data_master_trans_2024_01_17.sql

select count(*) as count from zt_master_trans_additional_3 where id_ad > 17647 limit 1
1163  
mysqldump -u root -p nextgendb32 zt_master_trans_additional_3 --where=" id_ad > 17647  " > nextgendb32_data_trans_additional_2024_01_17.sql


cd /home/devtech/upload
ls -l zt_master_trans_additional_3_24_01_16_1.sql
chmod +r zt_master_trans_additional_3_24_01_16_1.sql
ls -ld /path/to/parent_directory
pwd
ls -ld /home/devtech/upload

chmod 777 zt_master_trans_additional_3_24_01_16_1.sql
chown postgres zt_master_trans_additional_3_24_01_16_1.sql

chmod og+rX /home /home/devtech


\i /home/devtech/upload/zt_master_trans_additional_3_24_01_16_1.sql



UPDATE zt_master_trans_additional_3 SET acquirer_json=NULL WHERE acquirer_json='{}' ;
UPDATE zt_master_trans_additional_3 SET acquirer_response=NULL WHERE acquirer_response='{}' or acquirer_response='' ;
UPDATE zt_master_trans_additional_3 SET json_value=NULL WHERE json_value='{}' or json_value='' ;
UPDATE zt_master_trans_additional_3 SET json_log_history=NULL WHERE json_log_history='{}' or json_log_history='' ;
UPDATE `zt_master_trans_additional_3` SET `json_log_history`=NULL;
UPDATE zt_acquirer_group_template SET json_log_history=NULL;



--DELETE FROM zt_master_trans_additional_3;

mysqldump -u root -P 3307 --compatible=postgresql  uploaddbpsql4 > E:\db\psql\zt_master_trans_3_24_01_17.sql



UPDATE zt_mer_setting SET monthly_fee='0.00' WHERE monthly_fee IS NULL or monthly_fee='' ;
UPDATE zt_mer_setting SET virtual_fee='0.00' WHERE virtual_fee IS NULL or virtual_fee='' ;
UPDATE zt_mer_setting SET refund_fee='0.00' WHERE refund_fee IS NULL or refund_fee='' ;
UPDATE zt_mer_setting SET mdr_visa_rate='0.00' WHERE mdr_visa_rate IS NULL or mdr_visa_rate='' ;
UPDATE zt_mer_setting SET mdr_mc_rate='0.00' WHERE mdr_mc_rate IS NULL or mdr_mc_rate='' ;
UPDATE zt_mer_setting SET mdr_jcb_rate='0.00' WHERE mdr_jcb_rate IS NULL or mdr_jcb_rate='' ;
UPDATE zt_mer_setting SET mdr_amex_rate='0.00' WHERE mdr_amex_rate IS NULL or mdr_amex_rate='' ;
UPDATE zt_mer_setting SET mdr_range_rate='0.00' WHERE mdr_range_rate IS NULL or mdr_range_rate='' ;
UPDATE zt_mer_setting SET mdr_range_amount='0.00' WHERE mdr_range_amount IS NULL or mdr_range_amount='' ;
UPDATE zt_mer_setting SET txn_fee_failed='0.00' WHERE txn_fee_failed IS NULL or txn_fee_failed='' ;

UPDATE zt_mer_setting SET charge_back_fee_1='0.00' WHERE charge_back_fee_1 IS NULL or charge_back_fee_1='' ;
UPDATE zt_mer_setting SET charge_back_fee_2='0.00' WHERE charge_back_fee_2 IS NULL or charge_back_fee_2='' ;
UPDATE zt_mer_setting SET charge_back_fee_3='0.00' WHERE charge_back_fee_3 IS NULL or charge_back_fee_3='' ;


UPDATE zt_mer_setting SET json_log_history=NULL WHERE json_log_history IS NULL OR json_log_history='{}';

mysqldump -u root -P 3307 --compatible=postgresql  uploaddbpsql1 zt_mer_setting > E:\db\psql\zt_mer_setting_24_01_16.sql


SELECT setval('zt_clientid_table_id_seq', (SELECT MAX(id) FROM zt_clientid_table));
SELECT setval('zt_terminal_id_seq', (SELECT MAX(id) FROM zt_terminal));
SELECT setval('zt_banks_id_seq', (SELECT MAX(id) FROM zt_banks));
SELECT setval('zt_coin_wallet_id_seq', (SELECT MAX(id) FROM zt_coin_wallet));

create sequence zt_payin_setting_id_seq owned by zt_payin_setting.id; alter table zt_payin_setting alter column id set default nextval('zt_payin_setting_id_seq');
SELECT setval('zt_payin_setting_id_seq', (SELECT MAX(id) FROM zt_payin_setting));


ALTER TABLE zt_payin_setting DROP COLUMN available_refresh_tranid;
ALTER TABLE zt_payin_setting
    ADD COLUMN available_refresh_tranid character varying(150);
	
SELECT setval('zt_payin_setting_id_seq', (SELECT MAX(id) FROM zt_payin_setting));

SELECT setval('zt_payout_setting_id_seq', (SELECT MAX(id) FROM zt_payout_setting));
SELECT setval('zt_payout_request_id_seq', (SELECT MAX(id) FROM zt_payout_request));

SELECT setval('zt_acquirer_table_id_seq', (SELECT MAX(id) FROM zt_acquirer_table));
SELECT setval('zt_access_roles_id_seq', (SELECT MAX(id) FROM zt_access_roles));
SELECT setval('zt_subadmin_id_seq', (SELECT MAX(id) FROM zt_subadmin));





scp -3 -P 210 -r -i /root/sshPemkey devtech@172.31.39.54:/home/devtech/upload/nextgendb32_data_mer_2024_01_15.zip  /home/devtech/db_psql



When I am trying to execute a query from some large table it turns out that connection to DB is lost: ERROR 2013 (HY000): Lost connection to MySQL server during query I am running a query directly on the DB server:

I have allready issued some configuration in my.cnf but the problem persist:

net_read_timeout=600 
net_write_timeout=180 
wait_timeout=86400 
interactive_timeout=86400

max_allowed_packet=128M 
key_buffer_size = 2560M 
max_allowed_packet = 7500M 
thread_stack = 1M 
thread_cache_size = 16 
innodb_buffer_pool_size = 20G 
read_buffer_size = 128M 
read_rnd_buffer_size = 256M 
sort_buffer_size = 3G 
query_cache_size = 1024M 
innodb_force_recovery = 4

###############################################################
<<PSQL DB Connect to App 
https://blog.devart.com/configure-postgresql-to-allow-remote-connection.html


<<sonar


https://medium.com/@humzaarshadkhan/sonarqube-installation-on-ubuntu-20-04-9c4f8e293870
https://www.howtoforge.com/tutorial/how-to-install-sonarqube-on-ubuntu-1604/


https://developerinsider.co/install-sonarqube-on-ubuntu/
https://www.sonarsource.com/products/sonarqube/downloads/




https://www.howtoforge.com/how-to-install-sonarqube-on-ubuntu-22-04/


apt update
apt install default-jdk
java -version
apt update
php -v



apt install postgresql
Ver Cluster Port Status Owner    Data directory              Log file
12  main    5432 down   postgres /var/lib/postgresql/12/main /var/log/postgresql/postgresql-12-main.log

apt install php8.1-pgsql -y

psql --version

systemctl is-enabled postgresql
systemctl status postgresql

service postgresql status
service apache2 restart

netstat -tulpn

cd /etc/postgresql/12/main
cp postgresql.conf postgresql.conf_origial
vi postgresql.conf
	listen_addresses = '*'          # what IP address(es) to listen on;
	
cp pg_hba.conf pg_hba.conf_origial
vi pg_hba.conf
	host    all             all             0.0.0.0/0           md5
	
/etc/init.d/postgresql restart
/etc/init.d/postgresql status

systemctl enable postgresql

netstat -lntp | grep postgres
nmap server -p 5432


sudo -u postgres psql

CREATE USER sonarqube WITH PASSWORD 'sonarqube@112';
CREATE DATABASE sonarqube OWNER sonarqube;
GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonarqube;

\l
\du
if sonarqube careated database and user than quite via \q
\q


sudo useradd -b /opt/sonarqube -s /bin/bash sonarqube
vi /etc/sysctl.conf

	##Add the following configuration to the bottom of the line. The SonarQube required the kernel parameter vm.max_map_count to be greater than '524288' and the fx.file-max to be greater than '131072'.

	vm.max_map_count=524288
	fs.file-max=131072

sysctl --system

ulimit -n 131072
ulimit -u 8192

vi /etc/security/limits.d/99-sonarqube.conf

	sonarqube   -   nofile   131072
	sonarqube   -   nproc    8192
	
apt install unzip software-properties-common wget

wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.6.1.59531.zip


unzip sonarqube-9.6.1.59531.zip

mv sonarqube-9.6.1.59531 /opt/sonarqube

sudo chown -R sonarqube:sonarqube /opt/sonarqube

ls /opt/sonarqube

vi /opt/sonarqube/conf/sonar.properties

sonar.jdbc.username=sonarqube
sonar.jdbc.password=sonarqube@112

sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube

sonar.search.javaOpts=-Xmx512m -Xms512m -XX:MaxDirectMemorySize=256m -XX:+HeapDumpOnOutOfMemoryError

sonar.web.host=127.0.0.1
sonar.web.port=9000
sonar.web.javaAdditionalOpts=-server

sonar.log.level=INFO
sonar.path.logs=logs

vi /etc/systemd/system/sonarqube.service

[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonarqube
Group=sonarqube
Restart=always
LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload
sudo systemctl start sonarqube.service
sudo systemctl enable sonarqube.service


sudo systemctl status sonarqube.service


https://www.howtoforge.com/tutorial/how-to-install-sonarqube-on-ubuntu-1604/

sudo a2enmod proxy
sudo a2enmod proxy_http
systemctl restart apache2

vi /etc/apache2/sites-available/sonarqube.conf

<VirtualHost *:80>
    ServerName 52.66.153.180
    #ServerAdmin admin@letspe.com
    ProxyPreserveHost On
    ProxyPass / http://localhost:9000/
    ProxyPassReverse / http://localhost:9000/
    #TransferLog /var/log/apache2/sonarqube_access.log
    #ErrorLog /var/log/apache2/sonarqube_error.log
</VirtualHost>


sudo a2ensite sonarqube
systemctl restart apache2

vi /etc/apache2/sites-available/sonarqube.conf

80 add tcp in security group
8080 add tcp in security group
9000 add tcp in security group


http://52.66.153.180/sessions/new?return_to=%2Fsession.php
admin
admin
lets@112

http://52.66.153.180/sessions/new?return_to=%2Fnew%3Freturn_to%3D%252Fprojects%252Fcreate
http://52.66.153.180/projects/create
admin
lets@112




<<python

oci Oracle  

python numpy
python numpy install

pyscript 
react js => https://www.youtube.com/watch?v=Jx39roFmTNg
npm install -g create-react-app
npx create-react-app --version
mkdir front
cd front
npx create-react-app reactfirst pyapi

npx create-react-app my-react-app
cd my-react-app
npm start



https://documenter.getpostman.com/view/8804149/2s7YfGFJKU#intro

https://www.youtube.com/watch?v=ZaKzw9tULeM&list=PLjVLYmrlmjGfgBKkIFBkMNGG7qyRfo00W

https://www.youtube.com/watch?v=zk5qOQBvuK4

https://www.w3schools.com/python/numpy/default.asp

https://www.python.org/downloads/

python --version
	Python 3.12.1
pip --version
	pip 23.2.1 from D:\Python312\Lib\site-packages\pip (python 3.12)
	
for FastAPI
pip install fastapi

To install Uvicorn, open the command prompt or terminal and do

https://www.youtube.com/watch?v=RhEjmHeDNoA

pip install "uvicorn[standard]"

pip install pandas
	python.exe -m pip install --upgrade pip
pip install --upgrade pandas
pip install jupyter
jupyter notebook
http://localhost:8888/tree
http://localhost:8888/notebooks/Untitled.ipynb

	file:///C:/Users/Mith/AppData/Roaming/jupyter/runtime/jpserver-30404-open.html
    Or copy and paste one of these URLs:
        http://localhost:8888/tree?token=87d1936ae6dd213e09245648735630abfc356dc9d533b3db
        http://127.0.0.1:8888/tree?token=87d1936ae6dd213e09245648735630abfc356dc9d533b3db
		
	

https://docs.python.org/3.12/tutorial/index.html



https://www.freecodecamp.org/news/postgresql-in-python/

#installation

pip install psycopg2
pip3 install psycopg2
pip install psycopg2-binary 
pip install psycopg-binary
pip3 install psycopg2-binary

pip show psycopg2-binary
Location: D:\Python312\Lib\site-packages


virtualenv env && source env/bin/activate
pip install psycopg2-binary




import psycopg2

---------------------------------------
-- https://www.youtube.com/watch?v=M2NzvnfS-hI

import psycopg2 
import psycopg2.extras

hostname = 'localhost'
database = 'db3'
username = 'postgres'
pwd = ''
port_id = 3306

conn = None
cur = None


try:
    with psycopg2.connect(
                host = hostname,
                dbname = database,
                user = username,
                password = pwd,
                port = port_id) as conn:
        
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:

            cur.execute( 'DROP TABLE IF EXISTS employee')
            conn.commit()
            create_script = ''' CREATE TABLE IF NOT EXISTS employee (
                                id      int PRIMARY KEY,
                                name    varchar(40) NOT NULL,
                                salary  int,
                                dept_id varchar(30)) ''' 
            cur.execute(create_script)

            insert_script = 'INSERT INTO employee (id, name, salary, dept_id) VALUES (%s, %s, %s, %s)'
            insert_values = [(1, 'James', 12000, 'D1'), (2, 'Robin', 15000, 'D1'), (3, 'Xavier', 20000, 'D1')]

            for record in insert_values:
                cur.execute(insert_script, record)

                update_script = 'UPDATE employee SET salary = salary + (salary * 0.5)'
                cur.execute(update_script)


                delete_script = 'DELETE FROM employee WHERE name = %s'
                delete_record = ('James',)
                cur.execute(delete_script, delete_record)

                cur.execute('SELECT * FROM EMPLOYEE')
                for record in cur.fetchall():
                    print (record['name'], record['salary'])

except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()



---------------------------------------

#!/usr/bin/python

import psycopg2

conn = psycopg2.connect(database = "testdb", user = "postgres", password = "pass123", host = "127.0.0.1", port = "5432")
print "Opened database successfully"

cur = conn.cursor()

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (1, 'Paul', 32, 'California', 20000.00 )");

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (2, 'Allen', 25, 'Texas', 15000.00 )");

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (3, 'Teddy', 23, 'Norway', 20000.00 )");

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (4, 'Mark', 25, 'Rich-Mond ', 65000.00 )");

conn.commit()
print "Records created successfully";
conn.close()

---------------------------------------

#!/usr/bin/python

import psycopg2

conn = psycopg2.connect(database = "testdb", user = "postgres", password = "pass123", host = "127.0.0.1", port = "5432")
print "Opened database successfully"

cur = conn.cursor()

cur.execute("SELECT id, name, address, salary  from COMPANY")
rows = cur.fetchall()
for row in rows:
   print "ID = ", row[0]
   print "NAME = ", row[1]
   print "ADDRESS = ", row[2]
   print "SALARY = ", row[3], "\n"

print "Operation done successfully";
conn.close()


---------------------------------------

#!/usr/bin/python

import psycopg2

conn = psycopg2.connect(database = "testdb", user = "postgres", password = "pass123", host = "127.0.0.1", port = "5432")
print "Opened database successfully"

cur = conn.cursor()

cur.execute("DELETE from COMPANY where ID=2;")
conn.commit()
print "Total number of rows deleted :", cur.rowcount

cur.execute("SELECT id, name, address, salary  from COMPANY")
rows = cur.fetchall()
for row in rows:
   print "ID = ", row[0]
   print "NAME = ", row[1]
   print "ADDRESS = ", row[2]
   print "SALARY = ", row[3], "\n"

print "Operation done successfully";
conn.close()


---------------------------------------

https://www.tutorialspoint.com/postgresql/postgresql_python.htm


--company_db.py------------------------
#!/usr/bin/python

import psycopg2

conn = psycopg2.connect(database = "db3", user = "postgres", password = "", host = "localhost", port = "3306")
print('Opened database successfully')

cur = conn.cursor()
cur.execute('''CREATE TABLE COMPANY
      (ID INT PRIMARY KEY     NOT NULL,
      NAME           TEXT    NOT NULL,
      AGE            INT     NOT NULL,
      ADDRESS        CHAR(50),
      SALARY         REAL)''')
print("Table created successfully") 

conn.commit()
conn.close()

--company_insert.py------------------------

#!/usr/bin/python

import psycopg2

conn = psycopg2.connect(database = "db3", user = "postgres", password = "", host = "localhost", port = "3306")
print('Opened database successfully')

cur = conn.cursor()

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (1, 'Paul', 32, 'California', 20000.00 )");

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (2, 'Allen', 25, 'Texas', 15000.00 )");

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (3, 'Teddy', 23, 'Norway', 20000.00 )");

cur.execute("INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) \
      VALUES (4, 'Mark', 25, 'Rich-Mond ', 65000.00 )");

conn.commit()
print('Records created successfully')
conn.close()


--company_select.py------------------------

#!/usr/bin/python

import psycopg2

conn = psycopg2.connect(database = "db3", user = "postgres", password = "", host = "localhost", port = "3306")
print('Opened database successfully\n')

cur = conn.cursor()

cur = conn.cursor()

cur.execute("SELECT id, name, address, salary  from COMPANY")
rows = cur.fetchall()
for row in rows:
   print('ID        = ',row[0]) 
   print('NAME      = ',row[1]) 
   print('ADDRESS   = ',row[2]) 
   print('SALARY    = ',row[3]) 
   print('\n')

print('Operation done successfully\n')
conn.close()




--company_update.py------------------------

#!/usr/bin/python

import psycopg2

conn = psycopg2.connect(database = "db3", user = "postgres", password = "", host = "localhost", port = "3306")
print('Opened database successfully\n')

cur = conn.cursor()

cur.execute("UPDATE COMPANY set SALARY = 25000.00 where ID = 1")
conn.commit()

cur.execute("SELECT id, name, address, salary  from COMPANY")
rows = cur.fetchall()
for row in rows:
   print('ID        = ',row[0]) 
   print('NAME      = ',row[1]) 
   print('ADDRESS   = ',row[2]) 
   print('SALARY    = ',row[3]) 
   print('\n')

print('Operation done successfully\n')
conn.close()





--company_delete.py------------------------

#!/usr/bin/python

import psycopg2

conn = psycopg2.connect(database = "db3", user = "postgres", password = "", host = "localhost", port = "3306")
print('Opened database successfully\n')

cur = conn.cursor()

cur.execute("DELETE from COMPANY where ID=2;")
conn.commit()

cur.execute("SELECT id, name, address, salary  from COMPANY")
rows = cur.fetchall()
for row in rows:
   print('ID        = ',row[0]) 
   print('NAME      = ',row[1]) 
   print('ADDRESS   = ',row[2]) 
   print('SALARY    = ',row[3]) 
   print('\n')

print('Operation done successfully\n')
conn.close()


<<
cmd
systempropertiesadvanced 
%UserProfile%\AppData\Local\Microsoft\WindowsApps


--------------------------
<<python react js and web application example

https://www.datacamp.com/tutorial/tutorial-postgresql-python

Flask => Frontend => https://www.youtube.com/watch?v=Qr4QMBUPxWo

react js => Frontend => https://www.youtube.com/watch?v=Jx39roFmTNg

https://pyscript.com/@examples/matplotlib/latest

How to Create a Front End for a PostgreSQL Database in 4 Steps



--------------------------
https://www.codeconvert.ai/free-converter

pip install php2py

from php2py import trans_php

# Example PHP code
php_code = '''
<?php
function add($a, $b) {
    return $a + $b;
}

$sum = add(3, 5);
echo $sum;
?>
'''

# Convert PHP code to Python
python_code = trans_php(php_code)
print(python_code)


https://pandas.pydata.org/docs/getting_started/install.html

pip install pandas
pip install "pandas[excel]"
pip install "pandas[html]"
pip install --pre --extra-index https://pypi.anaconda.org/scientific-python-nightly-wheels/simple pandas

pip install "pandas[postgresql, mysql, sql-other]"
pip install "pandas[postgresql]"
pip uninstall pandas -y

pip install --allow-external mysql-connector-python mysql-connector-python
pip3 install MySQLdb
pip3 install PyMySQL
pip3 install mysql-connector-python



python3 --version

python -m http.server


<<pyscript --

https://blog.logrocket.com/pyscript-run-python-browser/

python -m http.server

http://localhost:8000/index.html

https://realpython.com/pyscript-python-in-browser/

foreach ($ext in "css", "js", "py") {
wget "https://pyscript.net/alpha/pyscript.$ext" -o "pyscript.$ext"
}



pyodide.html

$VERSION='0.20.0'
$TARBALL="pyodide-build-$VERSION.tar.bz2"
$GITHUB_URL='https://github.com/pyodide/pyodide/releases/download'
wget "$GITHUB_URL/$VERSION/$TARBALL"
tar -xf "$TARBALL" --strip-components=1 pyodide

sqlite_db_fetch.html

https://realpython.com/pyscript-python-in-browser/

$ git clone git@github.com:pyscript/pyscript.git
$ cd pyscript/pyscriptjs/
$ npm install --global rollup
$ npm install

--------------------------

https://dev.to/andrewbaisden/creating-react-flask-apps-that-connect-to-postgresql-and-harperdb-1op0

https://www.javaguides.net/2021/08/react-spring-boot-postgresql-crud.html


https://kinsta.com/knowledgebase/install-react/#step-2-install-create-react-app
d:
cd .\ReactProjects\
cd pyapi
node -v npm -v
npm install -g create-react-app
mkdir rapp
create-react-app rapp
create-react-app pyapi

npm init -y
npm install -g -typescript
npm install
npx http-server
npm install --global http-server
npm start

npm install react


cd /path/to/folder
npm install
npm init -y
npx http-server

http://localhost:8080/



cd /path/to/folder
npm install
> npm set init-author-email "example-user@example.com"
> npm set init-author-name "example_user"
> npm set init-license "MIT"

--------------------------
<<react 

https://kinsta.com/knowledgebase/install-react/#step-2-install-create-react-app

https://create-react-app.dev/docs/getting-started/

Window PowerShell
d:
npx create-react-app reactapp
cd reactapp
npm start
npm run build

npx create-remix@latest

cd .\my-remix-app\app\
npm run dev
npm install --save-dev ts-node tsconfig-paths


http://localhost:3000/

https://remix.run/docs/en/1.19.3/tutorials/jokes



http://localhost:8080/

python python_to_postgres.py runserver

http://localhost:3000/

https://www.youtube.com/watch?v=SqcY0GlETPk

https://react.dev/

https://www.javaguides.net/2021/08/react-spring-boot-postgresql-crud.html

https://medium.com/codex/developing-a-web-app-with-postgres-database-using-flask-react-9c297606aed9


d:
cd web_app
npm init react-app ./front_end
npm start
npm install react-youtube
npm install react-bootstrap
pip install -r requirements.txt
 cd .\back_end\
py -3 -m venv .venv
pip install -U flask-cors

pip install Flask
D:\Python312\python.exe -m pip install virtualenv


npm audit
npm audit fix --force




8 vulnerabilities (2 moderate, 6 high)
https://stackoverflow.com/questions/50243901/found-4-vulnerabilities-on-npm-install
cmd  running the Command Prompt as Administrator.
npm install ngx-bootstrap --save
npm install react-navigation
npm install example-package-name --no-audit











Run `npm audit` for details.

Success! Created reactapp at D:\reactapp
Inside that directory, you can run several commands:

  npm start
    Starts the development server.

  npm run build
    Bundles the app into static files for production.

  npm test
    Starts the test runner.

  npm run eject
    Removes this tool and copies build dependencies, configuration files
    and scripts into the app directory. If you do this, you can’t go back!

We suggest that you begin by typing:

  cd reactapp
  npm start

Happy hacking!

--------------------------

D:/Python312/python.exe

--------------------------

