<?
	$data['FUND_STEP']=4;
	$data['type']=3;

	$data ['PageName'] = 'WITHDRAW ROLLING';
	$data ['PageTitle'] = 'Withdraw Rolling';
		$data ['ThisPageLabel'] = 'Rolling'; // fixed value
	$data ['ThisTitle'] = 'Withdraw Rolling';
	$data ['ThisPageUrl'] = 'withdraw_rolling_wv3_custom';

    $data['ROLLING_V3_CUSTOM_ENABLE']='Y';
    $_REQUEST['ro']=1;

    include('trans_withdraw-fund_v3_custom_settlement.do'); 
?>
