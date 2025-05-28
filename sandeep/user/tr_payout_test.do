<?

include('../config.do');

if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
        header("Location:{$data['Host']}/index".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}
if($uid>0){
	
	$post['type']=2;
	$payout_trans2 = payout_trans2($uid,'',$post['type']); echo "<br/><br/>payout_trans2=>";print_r($payout_trans2);
		
	$payout_trans_new = payout_trans_new($uid,$post['type']); echo "<br/><br/>payout_trans_new=>";print_r($payout_trans_new);

}
?>