<?
//getBeneficiaryDetail
include('../config.do');

$bene_id=$_REQUEST['beneId'];


$select_bene=db_rows_2(
	"SELECT * FROM `{$data['DbPrefix']}payout_beneficiary`".
	" WHERE `bene_id`='{$bene_id}'",0
);
$bank_name = $select_bene[0]['bank_name'];
$beneficiary_name = $select_bene[0]['beneficiary_name'];
$account_number = $select_bene[0]['account_number'];
$bank_code1 = $select_bene[0]['bank_code1'];
$bank_code2 = $select_bene[0]['bank_code2'];
$bank_code3 = $select_bene[0]['bank_code3'];

$post['acq'] = array("bank_name"=>$bank_name,"beneficiary_name"=>$beneficiary_name,"account_number"=>$account_number,"bank_code1"=>$bank_code1,"bank_code2"=>$bank_code2,"bank_code3"=>$bank_code3);

$post['acq1']=jsonencode($post['acq'],1,1);

echo $post['acq1'];
exit;

?>
