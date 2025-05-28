<?php

// Dev Tech : 25-01-04 Withdraw function wv3 for Custom in Settlement Optimizer


//$data['SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM']='Y'; // Y is switch sum_f from psql AS double precision. 
if(isset($_REQUEST['su'])&&$_REQUEST['su']=='y') $data['SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM']='Y';
elseif(isset($_REQUEST['su'])&&$_REQUEST['su']=='n') $data['SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM']='N';



//Showing only Fee : SUM(`gst_amt`) 'total_gst_fee', SUM(`buy_mdr_amt`) AS `buy_mdr_amt`, SUM(`buy_txnfee_amt`) AS `buy_txnfee_amt`
//Display fees such as GST and transaction buy fees for informational purposes only, without performing calculations in a function. This feature can be enabled conditionally via SHOW_FEE_ONLY_ENABLE_IN_WV3_CUSTOM.
if(isset($_REQUEST['fe'])&&$_REQUEST['fe']=='y') $data['SHOW_FEE_ONLY_ENABLE_IN_WV3_CUSTOM']='Y';





//Dev Tech : 25-01-18 Withdraw function wv3 :: If SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM is set to 'Y' via sum_f, use SUM() without a query. Otherwise, use PostgreSQL's SUM(CAST(payable_amt_of_txn AS double precision)) for accurate aggregation.
function trans_balance_wv3_custom($merID=0,$type=2, $show_fee_only=0)
{
    global $data;
    
	$qp=0;$qp2=0;$qp3=0;
	//$qp=2;$qp2=1;$qp3=1;
	if(isset($_REQUEST['qp'])&&$_REQUEST['qp']) $qp=@$_REQUEST['qp'];
	elseif(isset($data['cqp'])&&$data['cqp']) $qp=@$data['cqp'];
	if(isset($_REQUEST['qp3'])&&$_REQUEST['qp3']) $qp3=@$_REQUEST['qp3'];


	if(@$qp==2)$qp2=$qp;
	if(@$qp>0)$qp3=$qp;

	$post=fetch_last_withdraw_monthly_fee_wv3_custom($merID,$type);
	
	$post['ab']['settlement_fixed_fee']=@$post['settlement_fixed_fee'];
	$post['ab']['settlement_min_amt']=@$post['settlement_min_amt'];
	$default_db_connect=@$post['default_db_connect'];
	$so_weekly=(isset($post['settlement_optimizer'])&&(@$post['settlement_optimizer']=='weekly')?1:0);

	if(@$qp) echo '<br/><b style="color:#366a19;"> default_db_connect==> '.@$default_db_connect.'</b><br/>';

	$client_get=select_tablef(" `id`={$merID} ",'clientid_table',$qp,1,"`id`,`default_currency`",@$default_db_connect);

	$default_currency=@$client_get['default_currency'];
	$dc_sys=get_currency(@$default_currency);
	$post['ab']['account_curr']=@$default_currency;
	$post['ab']['account_curr_sys']=@$dc_sys;
	

	if(@$qp)
		echo "<br/><hr/><br/><h1><==trans_balance_wv3_custom==>{$merID}</h1><br/>";
	

    
    if(!isset($data['CUSTOM_SETTLEMENT_OPTIMIZER_V3'])) $data['CUSTOM_SETTLEMENT_OPTIMIZER_V3']='custom_settlement_optimizer_v3';


    //Display fees such as GST and transaction buy fees for informational purposes only, without performing calculations in a function. This feature can be enabled conditionally via SHOW_FEE_ONLY_ENABLE_IN_WV3_CUSTOM.
    if(isset($data['SHOW_FEE_ONLY_ENABLE_IN_WV3_CUSTOM'])&&$data['SHOW_FEE_ONLY_ENABLE_IN_WV3_CUSTOM']=='Y')
    {
        $show_fee_only=1;
    }

    //IF Enable for via SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM without query SUM()
    if(isset($data['SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM'])&&$data['SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM']=='Y')
    {
        //via sum_f
		$sum_f_enable=1;
		$payable_amt_of_txn="`payable_amt_of_txn`";
		$rolling_amt="`rolling_amt`";
		$limit_1="  ";
    }
    else {
        //via SUM psql
		$sum_f_enable=0;
		$payable_amt_of_txn="SUM(CAST(`payable_amt_of_txn` AS double precision))";
		$rolling_amt="SUM(CAST(`rolling_amt` AS double precision))";
		$limit_1=" LIMIT 1 ";
    }

	

	


	$settelement_im="`settelement_date`";
    //IF Enable fetch immature fund 
    if(isset($data['IMMATURE_FUND_V3_CUSTOM_ENABLE'])&&$data['IMMATURE_FUND_V3_CUSTOM_ENABLE']=='Y')
    {
        $immature_fund_v3_custom_enable=1;
        $settelement_date_or_tdate="`settelement_date`";
        $mature_name="";
    }
    else {
        $immature_fund_v3_custom_enable=0;
        $settelement_date_or_tdate="`tdate`";
		$mature_name=" AS A ACCOUNT BALANCE ";
    }

    //total withdraw

    if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>TOTAL WITHDRAW!</h4>";

    //SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS total_withdraw FROM "zt_custom_settlement_optimizer_v3" WHERE ( "merID" IN (11479)) AND   ("trans_status" IN (1,13) ) AND ( "acquirer" IN (2) ) LIMIT 1;

    $total_withdraw_qr=db_rows_df(
        " SELECT {$payable_amt_of_txn} AS `sum`  FROM `{$data['DbPrefix']}{$data['CUSTOM_SETTLEMENT_OPTIMIZER_V3']}`".
        " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` IN (1,13) )  AND ( `acquirer` IN (2) ) ".
        $limit_1,@$qp2,$default_db_connect
    );
	if($sum_f_enable==1) $total_withdraw=sum_f(@$total_withdraw_qr);
	else  $total_withdraw=@$total_withdraw_qr[0]['sum'];

    $total_withdraw=number_formatf2(@$total_withdraw);
        $post['ab']['summ_withdraw_amt']=@$total_withdraw;
        $post['ab']['summ_withdraw']=number_formatf_4(@$total_withdraw,@$dc_sys);

    if(@$qp3) echo "<br/><b style='color:#e60000;'>&#10149; TOTAL WITHDRAW : ".@$total_withdraw."</b><br/>";



    //mature fund :: payable_amt_of_txn, tdate, merID, trans_status
    // now date is below or equal from tdate and deduct withdraw amount 

    if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>MATURE FUND {$mature_name}</h4>";

    //SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS mature_fund FROM `zt_master_trans_table_3` WHERE ( `merID` IN (11479)) AND (`trans_status` NOT IN (0,9,10,22,24) ) AND ( `acquirer` NOT IN (2,3) ) AND ( `tdate` <= NOW() ) LIMIT 1;

    if(isset($_REQUEST['withdraw_from_date'])&&trim($_REQUEST['withdraw_from_date'])&&isset($_REQUEST['withdraw_from_date'])&&trim($_REQUEST['withdraw_to_date'])) 
    {
        $withdraw_from_date=$_REQUEST['withdraw_from_date'];
        $withdraw_to_date=$_REQUEST['withdraw_to_date'];
        $mature_tdate=" AND ( {$settelement_date_or_tdate} BETWEEN '{$withdraw_from_date}' AND '{$withdraw_to_date}' ) ";
    }
    elseif(isset($post['withdraw_from_date'])&&trim($post['withdraw_from_date'])&&isset($post['withdraw_from_date'])&&trim($post['withdraw_to_date'])) 
    {
        $withdraw_from_date=$post['withdraw_from_date'];
        $withdraw_to_date=$post['withdraw_to_date'];
        $mature_tdate=" AND ( {$settelement_date_or_tdate} BETWEEN '{$withdraw_from_date}' AND '{$withdraw_to_date}' ) ";
    }
    else $mature_tdate=" AND ( {$settelement_date_or_tdate} <= NOW() ) ";


	//Weekly query date  as per previous 7 or 14 or 21 or 28 days from withdraw_to_date for tdate
	if($so_weekly==1)
	{
		if(@$qp) echo '<br/><b style="color:#40443e;">SO_WEEKLY</b>=><b style="color:#c005c6;">'.@$post['settlement_optimizer'].'</b><br/>';

		$day_name=@$post['day_name'];
		$week_delay=@$post['week_delay'];
		
		$mature_day=weekly_mature_date_f($day_name,$week_delay,$withdraw_to_date);
		$withdraw_from_date=date('Y-m-d 00:00:00',strtotime($withdraw_from_date));
		$withdraw_to_date=@$mature_day['mature_day'].' 24:00:00';
		

		if(@$qp) echo '<br/><b style="color:#40443e;">mature_day=>'.$withdraw_to_date.'</b><br/>';

		$settelement_date_or_tdate=$settelement_im="`tdate`";

		$mature_tdate=" AND ( {$settelement_date_or_tdate} BETWEEN '{$withdraw_from_date}' AND '{$withdraw_to_date}' ) ";

		if(@$qp) echo '<br/><b style="color:#40443e;">mature_tdate=>'.$mature_tdate.'</b><br/>';

	}



    $mature_fund_qr=db_rows(
        " SELECT {$payable_amt_of_txn} AS `sum`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
        " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )  AND ( `acquirer` NOT IN (2,3) )  ".
        $mature_tdate .
        $limit_1,@$qp2
    );

	if($sum_f_enable==1) $mature_fund=sum_f(@$mature_fund_qr);
	else $mature_fund=@$mature_fund_qr[0]['sum'];

    //if(isset($_REQUEST['withdraw_from_date'])&&trim($_REQUEST['withdraw_from_date'])&&isset($withdraw_to_date)&&trim($withdraw_to_date)) // skip deduct withdraw amount if date duration 
    if(isset($withdraw_from_date)&&trim($withdraw_from_date)&&isset($withdraw_to_date)&&trim($withdraw_to_date)) // skip deduct withdraw amount if date duration 
    	$total_mature_fund=number_formatf2(@$mature_fund); // deduct withdraw amount from mature fund 
    else $total_mature_fund=number_formatf2(@$mature_fund + @$total_withdraw); // deduct withdraw amount from mature fund 
    
	

		if(!isset($_REQUEST['withdraw_from_date'])&&isset($post['last_withdraw_remaining_balance'])&&trim($post['last_withdraw_remaining_balance'])) 
		{
			

		 	$total_mature_fund=number_formatf2(@$post['last_withdraw_remaining_balance']+@$total_mature_fund); // + if remaining balance
		}
		
		$post['ab']['summ_mature_amt']=@$total_mature_fund; // deduct withdraw amount from mature fund 
        $total_mature_fund_amt=$post['ab']['summ_mature']=number_formatf_4(@$total_mature_fund,@$dc_sys); // deduct withdraw amount from mature fund 

    if(@$qp){
        echo "<br/><b style='color:#0933b0;' title='{$mature_fund}'>Mature Fund=>".number_formatf2(@$mature_fund)."</b><br/>";

		if(!isset($_REQUEST['withdraw_from_date'])&&isset($post['last_withdraw_remaining_balance'])&&trim($post['last_withdraw_remaining_balance']))  echo '<br/><b style="color:#40443e;"> + last_withdraw_remaining_balance=>'.@$post['last_withdraw_remaining_balance'].'</b><br/>';

        //if(!isset($_REQUEST['withdraw_from_date'])) echo '<br/><b style="color:#e60000;"> - Withdraw=> '.@$total_withdraw.'</b><br/>';
        

    }
    if(@$qp3) echo '<br/><b style="color:#366a19;">&#10149; TOTAL MATURE FUND AMT : '.@$total_mature_fund_amt.'</b><br/>';
   






     //if Enable fetch immature fund 
     if(@$immature_fund_v3_custom_enable)
     {

        //immature fund :: payable_amt_of_txn, settelement_date, merID, trans_status
        // now date is greater than from settelement_date 

        if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>IMMATURE FUND</h4>";

        //SELECT SUM(CAST(payable_amt_of_txn AS double precision)) AS immature_fund FROM `zt_master_trans_table_3` WHERE ( `merID` IN (11479)) AND (`trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) ) AND ( `acquirer` NOT IN (2,3) ) AND ( `settelement_date` > NOW() ) LIMIT 1;



        if(isset($withdraw_to_date)&&trim($withdraw_to_date)) 
        {
            //$imimmature_settelement_date=$mature_settelement_date;
			$imimmature_settelement_date=" AND ( {$settelement_im} > '{$withdraw_to_date}' ) ";
        }
        else $imimmature_settelement_date=" AND ( {$settelement_im} > NOW() ) ";


		
        $immature_fund_qr=db_rows(
            " SELECT {$payable_amt_of_txn} AS `sum`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
            " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )  AND ( `acquirer` NOT IN (2,3) )  ".
            $imimmature_settelement_date .
            $limit_1,@$qp2
        );

        if($sum_f_enable==1)$immature_fund=sum_f(@$immature_fund_qr);
		else $immature_fund=number_formatf2(@$immature_fund_qr[0]['sum']);

		
        $immature_fund=number_formatf2(@$immature_fund);
        $post['ab']['summ_immature_amt']=@$immature_fund;
        $post['ab']['summ_immature']=number_formatf_4(@$immature_fund,@$dc_sys);
        $accountBalance=number_formatf2(@$immature_fund + @$total_mature_fund); // deduct withdraw amount from immature fund 
        

     }
     else $accountBalance=@$total_mature_fund;

        $post['ab']['summ_total_amt']=@$accountBalance; // deduct withdraw amount from immature fund 
        $accountBalance_amt=$post['ab']['summ_total']=number_formatf_4(@$accountBalance,@$dc_sys); // deduct withdraw amount from immature fund 

    if(@$qp&&@$immature_fund_v3_custom_enable){
        
        echo '<br/><b style="color:#40443e;">Immature Fund + Total Mature Fund=>'.@$accountBalance.'</b><br/>';

    }

    if(@$qp3) echo '<br/><b style="color:#b36200;">&#10149; ACCOUNT BALANCE AMT : '.@$accountBalance_amt.'</b><br/>';



    ############  FUND end   ###########################################



    //---------------------------------


    ############    ROLLING start   ###########################################

    //Enable fetch rolling 
    if(isset($data['ROLLING_V3_CUSTOM_ENABLE'])&&$data['ROLLING_V3_CUSTOM_ENABLE']=='Y')
    {

        //total withdraw rolling

        if(@$qp) echo "<br/><br/><br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>TOTAL WITHDRAW ROLLING</h4>";

        //SELECT SUM(CAST(rolling_amt AS double precision)) AS total_withdraw_rolling FROM "zt_custom_settlement_optimizer_v3" WHERE ( "merID" IN (11479)) AND   ("trans_status" IN (1,13) ) AND ( "acquirer" IN (2) ) LIMIT 1;

        $total_withdraw_rolling_qr=db_rows_df(
            " SELECT {$rolling_amt} AS `sum`  FROM `{$data['DbPrefix']}{$data['CUSTOM_SETTLEMENT_OPTIMIZER_V3']}`".
            " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` IN (1,13,14) )  AND ( `acquirer` IN (3) ) ".
            $limit_1,@$qp2,$default_db_connect
        );
		if($sum_f_enable==1) $total_withdraw_rolling=sum_f(@$total_withdraw_rolling_qr);
		else $total_withdraw_rolling=@$total_withdraw_rolling_qr[0]['sum'];

		$total_withdraw_rolling=number_formatf2(@$total_withdraw_rolling);

        $post['ab']['summ_withdraw_roll']=@$total_withdraw_rolling;
        $post['ab']['summ_withdraw_roll_sys']=number_formatf_4($total_withdraw_rolling,@$dc_sys);
        //$post['ab']['summ_withdraw']=$total_withdraw_rolling;

        if(@$qp3) echo "<br/><hr/><br/><b style='color:#e60000;'>&#10149; TOTAL WITHDRAW ROLLING : ".@$total_withdraw_rolling."</b><br/>";



        //mature rolling :: rolling_amt, rolling_date, merID, trans_status
        // now date is below or equal from rolling_date and deduct withdraw amount 

        if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>MATURE rolling</h4>";

        //SELECT SUM(CAST(rolling_amt AS double precision)) AS mature_rolling FROM `zt_master_trans_table_3` WHERE ( `merID` IN (11479)) AND (`trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) ) AND ( `acquirer` NOT IN (2,3) ) AND ( `rolling_date` <= NOW() ) LIMIT 1;

        if(isset($withdraw_from_date)&&trim($withdraw_from_date)&&isset($withdraw_to_date)&&trim($withdraw_to_date)) 
        {
            //$mature_rolling_date=" AND ( `rolling_date` BETWEEN '{$withdraw_from_date}' AND '{$withdraw_to_date}' ) ";
            $mature_rolling_date=" AND ( `rolling_date` <= '{$withdraw_to_date}' ) ";
        }
        else $mature_rolling_date=" AND ( `rolling_date` <= NOW() ) ";



        $mature_rolling_qr=db_rows(
            " SELECT {$rolling_amt} AS `sum`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
            " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )  AND ( `acquirer` NOT IN (2,3) )  ".
            $mature_rolling_date .
            $limit_1,@$qp2
        );

		if($sum_f_enable==1) $mature_rolling=sum_f(@$mature_rolling_qr);
		else $mature_rolling=@$mature_rolling_qr[0]['sum'];

        if(isset($_REQUEST['withdraw_from_date'])&&trim($_REQUEST['withdraw_from_date'])&&isset($withdraw_to_date)&&trim($withdraw_to_date)) // skip deduct withdraw amount if date duration 
        	$total_mature_rolling=number_formatf2(@$mature_rolling);  
        else $total_mature_rolling=number_formatf2(@$mature_rolling + @$total_withdraw_rolling); // deduct withdraw amount from mature rolling 
            $post['ab']['summ_mature_roll']=@$total_mature_rolling; // deduct withdraw amount from mature rolling 
            $post['ab']['summ_mature_roll_sys']=number_formatf_4(@$total_mature_rolling,@$dc_sys); 
            $total_mature_rolling_amt=$post['ab']['summ_total_roll']=@$total_mature_rolling; // deduct withdraw amount from mature rolling 
			$post['ab']['summ_total_roll_sys']=number_formatf_4(@$total_mature_rolling,@$dc_sys); //

        if(@$qp){
            echo "<br/><b style='color:#0933b0;' title='{$mature_rolling}'>Mature Rolling=>".number_formatf2(@$mature_rolling)."</b><br/>";
            echo '<br/><b style="color:#e60000;"> - Withdraw Rolling=> '.@$total_withdraw_rolling.'</b><br/>';
            

        }
        if(@$qp3) echo '<br/><b style="color:#366a19;">&#10149; TOTAL MATURE ROLLING AMT : '.@$total_mature_rolling_amt.'</b><br/>';





        //immature rolling :: rolling_amt, rolling_date, merID, trans_status
        // now date is greater than from rolling_date 

        if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>IMMATURE rolling</h4>";

        //SELECT SUM(CAST(rolling_amt AS double precision)) AS immature_rolling FROM `zt_master_trans_table_3` WHERE ( `merID` IN (11479)) AND (`trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) ) AND ( `acquirer` NOT IN (2,3) ) AND ( `rolling_date` > NOW() ) LIMIT 1;

        if(isset($withdraw_from_date)&&trim($withdraw_from_date)&&isset($withdraw_to_date)&&trim($withdraw_to_date)) 
        {
            //$imimmature_rolling_date=@$mature_rolling_date;
            $imimmature_rolling_date=" AND ( `rolling_date` > '{$withdraw_to_date}' ) ";
        }
        else $imimmature_rolling_date=" AND ( `rolling_date` > NOW() ) ";

        $immature_rolling_qr=db_rows(
            " SELECT {$rolling_amt} AS `sum`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
            " WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` NOT IN ({$data['TRANS_STATUS_NOT_IN']}) )  AND ( `acquirer` NOT IN (2,3) )  ".
            $imimmature_rolling_date .
            $limit_1,@$qp2
        );

        if($sum_f_enable==1) $immature_rolling=sum_f(@$immature_rolling_qr);
		else $immature_rolling=@$immature_rolling_qr[0]['sum'];
        

        $immature_rolling=number_formatf_2(@$immature_rolling);


            $post['ab']['summ_immature_roll']=@$immature_rolling;
            $post['ab']['summ_immature_roll_sys']=number_formatf_4(@$immature_rolling,@$dc_sys);
        $rollingBalance=(@$immature_rolling + @$total_mature_rolling); // deduct withdraw amount from immature rolling 
            $rollingBalance_amt=$post['ab']['summ_total_roll']=@$rollingBalance; // deduct withdraw amount from immature rolling 
            $post['ab']['summ_total_roll_sys']=number_formatf_4(@$rollingBalance,@$dc_sys); 

        if(@$qp3) echo "<br/><b style='color:#0933b0;' title='{$immature_rolling}'>&#10149; IMMATURE ROLLING=>".number_formatf_4(@$immature_rolling,@$dc_sys)."</b><br/>";

        if(@$qp){
            echo '<br/><b style="color:#40443e;"> + Total Mature Rolling=> '.@$total_mature_rolling.'</b><br/>';
        }

        if(@$qp3) echo '<br/><b style="color:#b36200;">&#10149; ROLLING BALANCE AMT : '.@$rollingBalance_amt.'</b><br/>';


    }



    ############    ROLLING end   ###########################################

    ############    GST,txn,MDR start  ######################################
    
    //Fee Showing: GST,txn,MDR
    if($show_fee_only==1){

        if(@$qp) echo "<br/><hr/><h4 style='font-size:22px!important;font-weight:bold;color:#3a8411;'>FEE SHOWING :: GST,txn,MDR</h4>";


        //IF Enable for via SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM without query SUM()
        if(isset($data['SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM'])&&$data['SUM_FUNCTION_ENABLE_IN_WV3_CUSTOM']=='Y')
        {
            //via sum_f
            $gst_amt="`gst_amt`";
            $buy_txnfee_amt="`buy_txnfee_amt`";
            $buy_mdr_amt="`buy_mdr_amt`";
            
        }
        else {
            //via SUM psql
            $gst_amt="SUM(CAST(`gst_amt` AS double precision))";
            $buy_txnfee_amt="SUM(CAST(`buy_txnfee_amt` AS double precision))";
            $buy_mdr_amt="SUM(CAST(`buy_mdr_amt` AS double precision))";
            
        }

        $se_fee_qr=db_rows(
                " SELECT {$gst_amt} AS `gst_amt`, {$buy_txnfee_amt} AS `buy_txnfee_amt`, {$buy_mdr_amt} AS `buy_mdr_amt`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
                " WHERE ( `merID` IN ({$merID}) ) AND (`trans_status` IN (1,4,7,8)) AND ( `trans_type` IN (11) )  ".
                $mature_tdate .
                $limit_1,@$qp2
            );

        if($sum_f_enable==1){
            $total_gst_fee=sum_f(@$se_fee_qr,'gst_amt');
            $total_buy_txnfee_amt=sum_f(@$se_fee_qr,'buy_txnfee_amt');
            $total_buy_mdr_amt=sum_f(@$se_fee_qr,'buy_mdr_amt');
        }
        else {
            $total_gst_fee=@$se_fee_qr[0]['gst_amt'];
            $total_buy_txnfee_amt=@$se_fee_qr[0]['buy_txnfee_amt'];
            $total_buy_mdr_amt=@$se_fee_qr[0]['buy_mdr_amt'];
        }

        $post['ab']['show_fee_only']='wv3';

        $total_gst_fee=number_formatf2(@$total_gst_fee);
        $post['ab']['total_gst_fee']=@$total_gst_fee; // GST FEE || Total GST FEE
        $post['ab']['total_gst_fee_sys']=number_formatf_4(@$total_gst_fee,@$dc_sys);

        $total_mdr_txtfee_amt=number_formatf2(@$total_buy_txnfee_amt);
        $post['ab']['total_mdr_txtfee_amt']=@$total_mdr_txtfee_amt; // Transaction Fee || Tra.FEE
        $post['ab']['total_mdr_txtfee_amt_sys']=number_formatf_4(@$total_mdr_txtfee_amt,@$dc_sys);

        $total_mdr_amt=number_formatf2(@$total_buy_mdr_amt);
        $post['ab']['total_mdr_amt']=@$total_mdr_amt; // MDR AMT. || Discount Rate 
        $post['ab']['total_mdr_amt_sys']=number_formatf_4(@$total_mdr_amt,@$dc_sys);

        if(@$qp3)
        {
             echo '<br/><b style="color:#b36200;">&#10149; total_gst_fee : '.@$total_gst_fee.'</b><br/>';
             echo '<br/><b style="color:#b36200;">&#10149; total_mdr_txtfee_amt : '.@$total_mdr_txtfee_amt.'</b><br/>';
             echo '<br/><b style="color:#b36200;">&#10149; total_mdr_amt : '.@$total_mdr_amt.'</b><br/>';
        }

    }

    ############    GST,txn,MDR end  ########################################

    return $post;
}







//fetch last Withdraw, remaining_balance_amt & monthly fee of a clients :: fetch_trans_balance_wv3_custom . 
function fetch_last_withdraw_monthly_fee_wv3_custom($merID="", $acquirer=2, $json_frozen=0)
{
	global $data; $last_withdraw_date_between_till_timestamp=''; $tr_det_q_immature_query=1;

	$result=array();

	
	$qprint=0;
	if(isset($_REQUEST['qp'])){
		$qprint=1;
		echo "<br/><hr/><br/><h1><==fetch_last_withdraw_monthly_fee_wv3_custom==>{$merID}</h1><br/>";
	}
	
	$acquirer=(int)$acquirer;

	
	//if(isset($data['WITHDRAW_INITIATE_TO_DATE_WISE'])&&@$data['WITHDRAW_INITIATE_TO_DATE_WISE']=='Y')
	{

		if(@$qprint) 
		{ 
			echo "<br/>_POST=>";
			print_r($_POST);
			echo "<br/>resultLastWithdraw=><br/><br/><br/>";
			

		}

		$withdraw_append='';
		$withdraw_tdate_append='';

		
		$tr_det_q_immature_query=0;
		$resultLastWithdraw['FORM_POST_METHOD']=@$_POST;

		if(isset($_POST['withdraw_from_date'])&&trim($_POST['withdraw_from_date'])) 
			$withdraw_from_date=@$_POST['withdraw_from_date'];
		

		//withdraw to date for fetch less then or equal tdate for withdraw query 
		if(isset($_POST['withdraw_to_date'])&&trim($_POST['withdraw_to_date'])) 
		{
			$withdraw_to_date=@$_POST['withdraw_to_date'];
		
		} 
		else{ 
			$withdraw_to_date=micro_current_date(); // via 6 digit micro time after second 
		}
		
		$resultLastWithdraw["last_withdraw_micro_current_date"]=@$withdraw_to_date;

		//$qprint=1;
		if(@$qprint) echo "<br/>GET WITHDRAW_TO_DATE=><br/><br/><br/>";

		if(isset($withdraw_transID)&&trim($withdraw_transID)){
			// $withdraw_append=" ( `transID`={$withdraw_transID} ) "; 
		}
		
		

		// via system 
		$withdraw_append=" ( `merID`='{$merID}' ) AND ( `acquirer` IN ({$acquirer}) ) AND ( `trans_status` NOT IN (2) )   "; 


		//More connection db
		$default_db_connect=0;
		if(isset($_REQUEST['CO'])&&$_REQUEST['CO']=='n') {

		}
		elseif(isset($data['DB_CON'])&&isset($_SESSION['DB_CON']))
		{

			//check find the default connection if more db connection 
			$default_db_connect=default_db_connect_f($qprint); //Is default db connect ok
			
			$db_from=db_from_f($qprint); // more db detail in json
			$resultLastWithdraw["db_from"]=@$db_from;
			
			$withdraw_append.=" AND (`db_from` IN ('{$db_from}') ) ";

		}
		$resultLastWithdraw["default_db_connect"]=$default_db_connect;


		//fetch last withdraw / settlement

		if(trim($withdraw_append)) 
		{


			$last_withdraw_field="";

			 //Enable fetch rolling 
			 if(isset($data['ROLLING_V3_CUSTOM_ENABLE'])&&$data['ROLLING_V3_CUSTOM_ENABLE']=='Y')
			 $last_withdraw_field=", (`mature_rolling_fund_amt`) AS `mature_rolling_fund_amt` , (`immature_rolling_fund_amt`) AS `immature_rolling_fund_amt` ";
			

			$fetch_last_withdraw_qry="SELECT (`id`) AS `id`, (`transID`) AS `transID`, (`acquirer`) AS `acquirer`, (`tdate`) AS `tdate`, (`remaining_balance_amt`) AS `remaining_balance_amt` {$last_withdraw_field} ".
                " FROM `{$data['DbPrefix']}{$data['CUSTOM_SETTLEMENT_OPTIMIZER_V3']}`".
                " WHERE ".$withdraw_append." ".
                " ORDER BY `id` DESC LIMIT 1";

			/*
			if(@$default_db_connect==1&&isset($data['CONNECTION_TYPE_DEFAULT'])&&@$data['CONNECTION_TYPE_DEFAULT']=='PSQL')
			 		$fetch_last_withdraw=db_rows_psql_default($fetch_last_withdraw_qry,$qprint);
			elseif(@$default_db_connect==1&&isset($data['CONNECTION_TYPE_DEFAULT'])&&@$data['CONNECTION_TYPE_DEFAULT']=='MYSQLI') 
					$fetch_last_withdraw=db_rows_mysqli_default($fetch_last_withdraw_qry,$qprint);
			else 	$fetch_last_withdraw=db_rows($fetch_last_withdraw_qry,$qprint);
			
			*/

			$fetch_last_withdraw=db_rows_df($fetch_last_withdraw_qry,$qprint,$default_db_connect);

			
			
			if(isset($fetch_last_withdraw)&&isset($fetch_last_withdraw[0]['transID'])&&is_array($fetch_last_withdraw))
			{


				$resultLastWithdraw["last_withdraw_remaining_balance"]=@$fetch_last_withdraw[0]['remaining_balance_amt'];

				$resultLastWithdraw["last_withdraw_mature_rolling_fund_amt"]=@$fetch_last_withdraw[0]['mature_rolling_fund_amt'];
				$resultLastWithdraw["last_withdraw_immature_rolling_fund_amt"]=@$fetch_last_withdraw[0]['immature_rolling_fund_amt'];

				
				$resultLastWithdraw["last_withdraw_id"]=@$fetch_last_withdraw[0]['id'];
				$resultLastWithdraw["last_withdraw_acquirer"]=@$fetch_last_withdraw[0]['acquirer'];
				$resultLastWithdraw["last_withdraw_transID"]=$resultLastWithdraw["previous_transID"]=@$fetch_last_withdraw[0]['transID'];	//transaction id
				$resultLastWithdraw["last_withdraw_tdate"]=$tdateLastWithdraw=@$fetch_last_withdraw[0]['tdate'];

				
					

				if(@$qprint)
				{
					//echo "<br/><b style='color:#0933b0;'>REMAINING_BALANCE_WV2=>".@$data['REMAINING_BALANCE_WV2']."</b>";
					echo "<br/><b style='color:#026402;'>last_withdraw_remaining_balance=>".@$resultLastWithdraw["last_withdraw_remaining_balance"]."</b><br/>";
					echo "<br/><b style='color:#0933b0;'>last_withdraw_transID=>".@$resultLastWithdraw["last_withdraw_transID"]."</b>";
					echo "<br/><b style='color:#026402;'>last_withdraw_acquirer=>".@$resultLastWithdraw["last_withdraw_acquirer"]."</b><br/>";
					
					echo "<br/><br/>";
				}
				

				//$tdateLastWithdraw=date('Y-m-d H:i:s.u',strtotime(@$fetch_last_withdraw[0]['tdate']));
				//$tdateLastWithdraw=fetchFormattedDate(@$fetch_last_withdraw[0]['tdate'],'Y-m-d H:i:s.u');
				//$tdateLastWithdraw=@$fetch_last_withdraw[0]['tdate'];
				
				// settelement_date	tdate

				
			}
			else
			{
				if(!isset($_POST['withdraw_from_date']))
				{

					$first_successfull_tra=db_rows(
						" SELECT (`id`) AS `id`, (`transID`) AS `transID`, (`acquirer`) AS `acquirer`, (`tdate`) AS `tdate`  FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
						" WHERE ( `merID` IN ({$merID}) ) AND ( `trans_status` IN (1) )  AND ( `acquirer` NOT IN (2,3) )  ".
						" ORDER BY `id` ASC LIMIT 1 ",@$qprint
					);

					if(isset($first_successfull_tra)&&isset($first_successfull_tra[0]['tdate'])&&is_array($first_successfull_tra))
					{
						//This is From Date for Payout 
						$resultLastWithdraw["first_success_tdate"]=@$first_successfull_tra[0]['tdate'];
						$resultLastWithdraw["first_success_transID"]=@$first_successfull_tra[0]['transID'];
					}

				}
	
				$resultLastWithdraw["last_withdraw_micro_current_date"]=micro_current_date();

			}

		}
		


		//withdraw condition 
		if(isset($resultLastWithdraw)&&@$resultLastWithdraw)
		{
			
			$result=array_merge(@$result,$resultLastWithdraw);

			$data['last_withdraw']=$resultLastWithdraw;

			if(@$qprint){
				echo "<br/>resultLastWithdraw Res.=><br/>";
				print_r($resultLastWithdraw);
				
				echo "<br/><br/><hr/><br/><br/>";
			}

		}


	}


	
	//Monthly FEE #####################

	$payin_setting_get=select_tablef(" `clientid`={$merID} ",'payin_setting',0,1,"`clientid`,`monthly_fee`,`settlement_fixed_fee`,`settlement_min_amt`,`frozen_balance`,`settlement_optimizer`,`day_name`,`week_delay`,`pdf_report`",@$default_db_connect);
	$result['per_monthly_fee']=number_formatf2(@$payin_setting_get['monthly_fee']);
	$result['settlement_fixed_fee']=number_formatf2(@$payin_setting_get['settlement_fixed_fee']);
	$result['settlement_min_amt']=number_formatf2(@$payin_setting_get['settlement_min_amt']);

	//Skip week_delay for cross checking 
	if(isset($_REQUEST['we'])&&$_REQUEST['we']=='n'){

	}
	else {
		// else get week_delay
		$result['settlement_optimizer']=@$payin_setting_get['settlement_optimizer'];
		$result['day_name']=@$payin_setting_get['day_name'];
		$result['week_delay']=@$payin_setting_get['week_delay'];
		$result['pdf_report']=@$payin_setting_get['pdf_report'];

		if($result['settlement_optimizer']=='weekly') $data['IMMATURE_FUND_V3_CUSTOM_ENABLE']='Y';
	}
	
	if(@$qprint)
	{
		echo "<b style='color:#0933b0;'>MONTHLY_FEE=>".@$result['per_monthly_fee']."</b>";
		echo "<br/><br/><b style='color:#e60000;'>settlement_optimizer=>".@$result['settlement_optimizer']."</b>";
		if($result['settlement_optimizer']=='weekly')
		{
			echo "<br/><b style='color:#062377;'>day_name=> ".@$result['day_name']."</b>";
			echo "<br/><b style='color:#9d7c05;'>week_delay=> ".@trim($result['week_delay'])."</b>";
			echo "<br/><b style='color:#9d7c05;'>pdf_report=> ".@trim($result['pdf_report'])."</b>";
		}
	}
	


	$w_start_date='';
	//from date as a w_start_date getting last_withdraw_tdate or first_success_tdate
	
	if(isset($resultLastWithdraw['last_withdraw_tdate'])&&trim($resultLastWithdraw['last_withdraw_tdate']))
	{
		$w_start_date=trim($resultLastWithdraw['last_withdraw_tdate']);
	}
	elseif(isset($resultLastWithdraw["first_success_tdate"])&&trim($resultLastWithdraw['first_success_tdate']))
	{
		$w_start_date=trim($resultLastWithdraw['first_success_tdate']);
	}
	
	
	@$w_end_date=@$resultLastWithdraw['last_withdraw_micro_current_date'];
	//to date as a w_end_date getting current micro date or withdraw_to_date from admin select 
	

	$result['withdraw_from_date']=@$w_start_date; 
	$result['withdraw_to_date']=$_SESSION['last_withdraw_micro_current_date_'.$merID]=@$w_end_date; 
	

	if($qprint)
	{
		echo "<br/><hr/><b style='color:#026402;'>last_withdraw_transID=> ".@$resultLastWithdraw['last_withdraw_transID']."</b>";
		echo "<br/><b style='color:#062377;'>last_withdraw_tdate=> ".@$resultLastWithdraw['last_withdraw_tdate']."</b>";
		echo "<hr/><b style='color:#9d7c05;'>first_success_tdate=> ".@trim($resultLastWithdraw['first_success_tdate'])."</b>";
		echo "<br/><b style='color:#9d7c05;'>first_success_transID=> ".@trim($resultLastWithdraw['first_success_transID'])."</b>";
		
		echo "<hr/><b style='color:#026402;'>w_start_date=> ".date('Y-m-d',strtotime($w_start_date))."</b>";
		echo "<br/><b style='color:#0933b0;'>w_end_date=> ".date('Y-m-d',strtotime($w_end_date))."</b>";

		
		echo "<hr/><b style='color:#026402;'>withdraw_from_date=> ".@$result['withdraw_from_date']."</b>";
		echo "<br/><b style='color:#0933b0;'>withdraw_to_date=> ".@$result['withdraw_to_date']."</b>";
		echo "<br/><b style='color:#e60000;'>last_withdraw_micro_current_date_=> ".$_SESSION['last_withdraw_micro_current_date_'.$merID]."</b>";
		echo "<br/><b style='color:#026402;'>last_withdraw_remaining_balance=> ".@$result['last_withdraw_remaining_balance']."</b>";
		echo "<hr/><br/>";

		
	}

	$a = date('Y-m-d',strtotime($w_start_date));	//initilized date from
	$b = date('Y-m-d',strtotime($w_end_date));		//initilized date to	

	$result['date_from']=$a;		// date from
	$result['date_to']=$b;			// date to
	//$result['date_to_payout']=$w_end_payout_date;	//payout end date


	//initilized first date of next month from last_withdraw_tdate and first date of the month if found first_success_tdate otherwise 
	if(isset($resultLastWithdraw['last_withdraw_tdate'])&&trim($resultLastWithdraw['last_withdraw_tdate']))
	$a = date('Y-m-d',strtotime("first day of next month",strtotime($w_start_date)));
	else $a = date('Y-m-d',strtotime("first day of this month",strtotime($w_start_date)));
	
	

	$result['wd']['wd_monthly_date_from']=$a;
	$result['wd']['wd_monthly_date_to']=$b; //initilized current micro date as to (till) as a date to
	
	//Start count total months loop 
	$i = date("Ym", strtotime($a));
	$j=0;
	while($i <= date("Ym", strtotime($b))){
		$i."<br/>";
		if(substr($i, 4, 2) == "12"){
			$i = (date("Y", strtotime($i."01")) + 1)."01";
		}else{
			$i++;
		}
		$j++;
	}

	$result['total_month_no']=$j;
	$result['total_monthly_fee']=number_formatf2($result['per_monthly_fee']*$result['total_month_no']);
	if($qprint){

		echo "<br/><b style='color:#0933b0;'>total_month_no=>".@$result['total_month_no']."</b>";
		echo "<br/><b style='color:#0933b0;'>per_monthly_fee=>".@$result['per_monthly_fee']."</b>";
		echo "<br/><b style='color:#0933b0;'>total_monthly_fee=>".@$result['total_monthly_fee']."</b>";
		echo "<br/><br/>";

		echo "<hr/><b>RESULT==></b>";
		print_r($result);
		echo "<br/><hr/><br/><br/>";
	}


	return $result;
}








?>