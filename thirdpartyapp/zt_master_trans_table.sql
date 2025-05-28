CREATE TABLE `zt_master_trans_table_2` (
  `id` INT(11) NOT NULL,
  `transID` bigint(20) DEFAULT NULL,
  `reference` varchar(100) DEFAULT NULL,
  `bearer_token` bigint(14) DEFAULT NULL,
  `tdate` datetime(4) DEFAULT NULL,
  `bill_amt` double(10,2) NOT NULL DEFAULT 0.00,
  `bill_currency` varchar(3) DEFAULT NULL,
  `trans_amt` varchar(100) DEFAULT NULL,
  `trans_currency` varchar(3) DEFAULT NULL,
  `acquirer` bigint(20) DEFAULT 0,
  `trans_status` tinyint(2) NOT NULL DEFAULT 0,
  `merID` bigint(20) UNSIGNED NOT NULL,
  `transaction_flag` varchar(20) DEFAULT NULL,
  `fullname` varchar(40) DEFAULT NULL,
  `bill_email` varchar(240) DEFAULT NULL,
  `bill_ip` varchar(100) DEFAULT NULL,
  `terNO` bigint(20) DEFAULT NULL,
  `mop` varchar(240) DEFAULT NULL,
  `channel_type` int(4) DEFAULT NULL,
  `buy_mdr_amt` varchar(10) DEFAULT NULL,
  `sell_mdr_amt` varchar(10) DEFAULT NULL,
  `buy_txnfee_amt` varchar(10) DEFAULT NULL,
  `sell_txnfee_amt` varchar(10) DEFAULT NULL,
  `gst_amt` varchar(20) DEFAULT NULL,
  `rolling_amt` varchar(10) DEFAULT NULL,
  `mdr_cb_amt` varchar(10) DEFAULT NULL,
  `mdr_cbk1_amt` varchar(10) DEFAULT NULL,
  `mdr_refundfee_amt` varchar(10) DEFAULT NULL,
  `available_rolling` varchar(10) DEFAULT NULL,
  `available_balance` varchar(10) DEFAULT NULL,
  `payable_amt_of_txn` varchar(10) DEFAULT NULL,
  `fee_update_timestamp` datetime(6) DEFAULT NULL,
  `remark_status` tinyint(1) NOT NULL DEFAULT 0,
  `trans_type` int(2) NOT NULL DEFAULT 11,
  `settelement_date` datetime DEFAULT NULL,
  `settelement_delay` int(2) DEFAULT NULL,
  `rolling_date` datetime DEFAULT NULL,
  `rolling_delay` int(3) DEFAULT NULL,
  `risk_ratio` varchar(150) DEFAULT NULL,
  `transaction_period` varchar(240) DEFAULT NULL,
  `bank_processing_amount` varchar(240) DEFAULT NULL,
  `bank_processing_curr` varchar(240) DEFAULT NULL,
  `created_date` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `related_transID` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transID` (`transID`) USING BTREE,
  KEY `bearer_token` (`bearer_token`) USING BTREE,
  KEY `tdate` (`tdate`) USING BTREE,
  KEY `created_date` (`created_date`) USING BTREE,
  KEY `reference` (`reference`) USING BTREE,
  KEY `acquirer` (`acquirer`) USING BTREE,
  KEY `trans_status` (`trans_status`) USING BTREE,
  KEY `merID` (`merID`) USING BTREE,
  KEY `mop` (`mop`) USING BTREE,
  KEY `trans_type` (`trans_type`) USING BTREE,
  KEY `bill_email` (`bill_email`) USING BTREE,
  KEY `channel_type` (`channel_type`) USING BTREE,
  KEY `reference_tdate` (`reference`,`tdate`) USING BTREE,
  KEY `tdate_desc` (`tdate` DESC) USING BTREE,
  KEY `reference_desc` (`reference` DESC) USING BTREE,
  KEY `transID_desc` (`transID` DESC) USING BTREE,
  KEY `bill_ip_desc` (`bill_ip` DESC) USING BTREE,
  KEY `validate_0` (`transID`,`merID`,`terNO` DESC) USING BTREE,
  KEY `callbacks_1` (`transID` DESC,`merID`,`id` DESC) USING BTREE,
  KEY `callbacks_2` (`transID` DESC,`merID`) USING BTREE,
  KEY `validate_1` (`merID`,`terNO`,`reference`) USING BTREE,
  KEY `validate_2` (`merID`,`terNO`,`reference`,`trans_status`) USING BTREE,
  KEY `acquirer_mop_tdate` (`acquirer`,`mop`,`tdate`) USING BTREE,
  KEY `stats_group_2` (`bill_amt`,`bill_email`,`merID`,`tdate`) USING BTREE,
  KEY `dashboard_1` (`merID`,`trans_status`,`trans_type`,`trans_amt`,`id`) USING BTREE,
  KEY `dashboard_2` (`merID`,`trans_status`,`acquirer`,`trans_amt`,`id`) USING BTREE,
  KEY `dashboard_5` (`merID`,`trans_status`) USING BTREE,
  KEY `grpah_2` (`merID`,`trans_status`,`tdate` DESC,`trans_amt`,`acquirer` DESC) USING BTREE,
  KEY `fullname` (`fullname`) USING BTREE,
  KEY `payin_1` (`trans_status`,`bill_amt`,`bill_email`,`merID`,`terNO`,`tdate`) USING BTREE,
  KEY `payin_2` (`merID`,`trans_status`,`trans_type`) USING BTREE,
  KEY `search_1` (`acquirer`,`trans_status`,`tdate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `zt_master_trans_table_2` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT;


###############################################################################


CREATE TABLE `zt_master_trans_additional_2` (
	`id_ad` INTEGER NOT NULL,
	`transID_ad` bigint(20) DEFAULT NULL,
	`authurl` varchar(250) DEFAULT NULL,
	`authdata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
	`source_url` varchar(240) DEFAULT NULL,
	`webhook_url` varchar(240) DEFAULT NULL,
	`return_url` varchar(240) DEFAULT NULL,
	`upa` varchar(240) DEFAULT NULL,
	`rrn` varchar(150) DEFAULT NULL,
	`acquirer_ref` varchar(175) DEFAULT NULL,
	`acquirer_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
	`descriptor` varchar(150) DEFAULT NULL,
	`mer_note` text DEFAULT NULL,
	`support_note` text DEFAULT NULL,
	`system_note` text DEFAULT NULL,
	`json_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
	`acquirer_json` text DEFAULT NULL,
	`json_log_history` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
	`payload_stage1` text DEFAULT NULL,
	`acquirer_creds_processing_final` text DEFAULT NULL,
	`acquirer_response_stage1` text DEFAULT NULL,
	`acquirer_response_stage2` text DEFAULT NULL,
	`bin_no` int(10) DEFAULT NULL,
	`ccno` varchar(240) DEFAULT NULL,
	`ex_month` varchar(240) DEFAULT NULL,
	`ex_year` varchar(240) DEFAULT NULL,
		`trans_response` varchar(240) DEFAULT NULL,
		`bill_phone` varchar(20) DEFAULT NULL,
		`bill_address` varchar(100) DEFAULT NULL,
		`bill_city` varchar(50) DEFAULT NULL,
		`bill_state` varchar(50) DEFAULT NULL,
		`bill_country` varchar(3) DEFAULT NULL,
		`bill_zip` varchar(50) DEFAULT NULL,
		`product_name` varchar(240) DEFAULT NULL,
	FOREIGN KEY (`id_ad`) REFERENCES zt_master_trans_table_2(`id`),
	UNIQUE KEY `transID_ad` (`transID_ad`) USING BTREE,
	KEY `rrn_desc` (`rrn` DESC) USING BTREE,
	KEY `upa_desc` (`upa` DESC) USING BTREE,
	KEY `descriptor` (`descriptor`) USING BTREE,
	KEY `trans_response` (`trans_response`) USING BTREE,
	KEY `bill_phone` (`bill_phone`) USING BTREE,
	KEY `bill_address` (`bill_address`) USING BTREE,
	KEY `bill_country` (`bill_country`) USING BTREE,
	KEY `bill_zip` (`bill_zip`) USING BTREE,
	KEY `product_name` (`product_name`) USING BTREE,
	KEY `authurl` (`authurl`) USING BTREE,
	KEY `authdata` (`authdata`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;



###############################################################################
###############################################################################

KEY `trans_response` (`trans_response`) USING BTREE,
	KEY `stats_3` (`id`,`merID`,`trans_type`,`trans_status`,`trans_response`) USING BTREE,
	KEY `stats_4` (`merID`,`trans_type`,`trans_status`,`trans_response`,`bill_amt`,`bill_email`,`tdate`) USING BTREE,

KEY `bill_country` (`bill_country`) USING BTREE,  
	KEY `grpah_3` (`merID`,`trans_status`,`bill_country`,`trans_amt`) USING BTREE,

###############################################################################

SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `zt_master_trans_table_2` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS = 1;

###############################################################################

SET FOREIGN_KEY_CHECKS = 0;
SET GLOBAL FOREIGN_KEY_CHECKS=0;

/* DO WHAT YOU NEED HERE */

SET FOREIGN_KEY_CHECKS = 1;
SET GLOBAL FOREIGN_KEY_CHECKS=1;

###############################################################################
	
###############################################################################

		`trans_response` varchar(240) DEFAULT NULL,
		`bill_phone` varchar(20) DEFAULT NULL,
		`bill_address` varchar(100) DEFAULT NULL,
		`bill_city` varchar(50) DEFAULT NULL,
		`bill_state` varchar(50) DEFAULT NULL,
		`bill_country` varchar(3) DEFAULT NULL,
		`bill_zip` varchar(50) DEFAULT NULL,
		`product_name` varchar(240) DEFAULT NULL,
		`source_url` varchar(240) DEFAULT NULL,
		`webhook_url` varchar(240) DEFAULT NULL,
		`return_url` varchar(240) DEFAULT NULL,
		`ccno` varchar(240) DEFAULT NULL,
		`ex_month` varchar(240) DEFAULT NULL,
		`ex_year` varchar(240) DEFAULT NULL,
		`bin_no` int(10) DEFAULT NULL,
		`upa` varchar(255) DEFAULT NULL,
		`rrn` varchar(150) DEFAULT NULL,
		`acquirer_ref` varchar(100) DEFAULT NULL,
		`acquirer_response` longtext DEFAULT NULL,
		`descriptor` varchar(150) DEFAULT NULL,
		`mer_note` text DEFAULT NULL,
		`support_note` text DEFAULT NULL,
		`system_note` text DEFAULT NULL,
		`json_value` longtext DEFAULT NULL,
		`acquirer_json` text DEFAULT NULL,
		`json_log_history` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
		`authurl` varchar(250) DEFAULT NULL,
		`authdata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
		`payload_stage1` text DEFAULT NULL,
		`acquirer_creds_processing_final` text DEFAULT NULL,
		`acquirer_response_stage1` text DEFAULT NULL,
		`acquirer_response_stage2` text DEFAULT NULL,

###############################################################################

id_ad, authurl, authdata, source_url, webhook_url, return_url, upa, rrn, acquirer_ref, acquirer_response, descriptor, mer_note, support_note, system_note, json_value, acquirer_json, json_log_history, payload_stage1, acquirer_creds_processing_final, acquirer_response_stage1, acquirer_response_stage2, bin_no, ccno, ex_month, ex_year, trans_response, bill_phone, bill_address, bill_city, bill_state, bill_country, bill_zip, product_name, 


###############################################################################

id_ad Index, authurl Index, authdata Index, source_url, webhook_url, return_url, upa Index, rrn Index, acquirer_ref, acquirer_response, descriptor Index, mer_note, support_note, system_note, json_value, acquirer_json, json_log_history, payload_stage1, acquirer_creds_processing_final, acquirer_response_stage1, acquirer_response_stage2, bin_no, ccno, ex_month, ex_year, trans_response Index, bill_phone Index, bill_address Index, bill_city, bill_state, bill_country Index, bill_zip Index, product_name Index, 

###############################################################################
