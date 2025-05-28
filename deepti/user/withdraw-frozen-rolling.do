<?
$data['FROZEN_ACQUIRER']=1;
$data['FUND_STEP']=4;
	$data['type']=3;

	$data ['PageName'] = 'FROZEN ROLLING';
	$data ['PageTitle'] = 'Frozen Rolling';
		$data ['ThisPageLabel'] = 'Rolling'; // fixed value for rolling
	$data ['ThisTitle'] = 'Frozen Rolling';
	$data['ButtonLabel']='Rolling Frozen';
	$data ['ThisPageUrl'] = 'withdraw-frozen-rolling';
	
include('trans_withdraw.do');
?>
