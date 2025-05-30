<?
###############################################################################
$data['PageName']='SEND MASS PAYMENTS WITH .CSV FILE UPLOAD';
$data['PageFile']='masscsv';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Mass Pay - '.$data['domain_name'];
###############################################################################
if(!isset($_SESSION['login'])){
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
if(is_info_empty($uid)){
	header("Location:{$data['Host']}/user/profile.do");
	echo('ACCESS DENIED.');
	exit;
}
###############################################################################
if($post['sendbtn'])$post['step']++;

###############################################################################
$post=select_info($uid, $post);
$data['Balance']=select_balance($uid);
$data['PostFile']=false;
if(!$post['step']){		
		$file1 = $HTTP_POST_FILES['filename']['tmp_name'][0];
		$file1_name = $HTTP_POST_FILES['filename']['name'][0];
		$file1_error = $HTTP_POST_FILES['filename']['error'][0];
		$file1_size = $HTTP_POST_FILES['filename']['size'][0];
		if ($file1_error > 0)  {
			switch ($file1_error) {
				case 1: $data['Error']='File exceeded upload_max_filesize';
				case 2: $data['Error']='File exceeded maximum file size';
				case 3: $data['Error']='File only partially uploaded';
				case 4: $data['Error']='No File Uploaded';
			}
		}else {
		$upfile1 = '/tmp/'.$file1_name;
		$post['upfile1']=$upfile1;
		if (is_uploaded_file($file1))  {
			if (!move_uploaded_file($file1, $upfile1))  {
				$data['Error']= 'Problem: could not move File 1 to destination directory';
			}
		}
		$row = 1;
		$content="";
		$sum = 0;
		$datafile  = read_csv($upfile1,",");
		$num = sizeof($datafile);
		for ($c=0; $c < $num; $c++) {
			$sum+= (double)$datafile[$c][0];
		}
		if(sizeof($datafile[0]) != 3) {$data['Error'] = 'Wrong file type'; }
		$post['sum']=$sum;
		$post['num']=$num;
		$real_sum=0;
		$post['user_count']=0;
		$post['user_names']="";
		if ($post['sum'] > $data['Balance'])  {
			$data['Error']='You do not have enough money in your account.';
			} else {
				for ($c=0; $c<$num; $c++) {
					$fees=((double)$datafile[$c][0]*$data['PaymentPercent']/100)+$data['PaymentFees'];
					$sender=$_SESSION['uid'];
					$post['amount']=$datafile[$c][0];
					$post['s_email']=get_clients_email($sender);
					$post['s_status']=get_clients_status($sender);
					$post['s_status_ex']=get_clients_status_ex($sender);
					$post['fees']=$fees;
					$receiverid=get_user_id($datafile[$c][1]);
					if($receiverid != ""){
						$real_sum+=$datafile[$c][0];
						$post['user_count']++;
						$post['user_names']= $post['user_names']." ".$datafile[$c][1];
						$post['fees']=$fees;
						$post['emailadr']=get_clients_email($uid);
						$post['fullname']=get_clients_name($uid);
						$post['username']=get_clients_name($receiverid);
						$post['product']="Internal Transfer";
						$post['comments']=$datafile[$c][2];
						$post['email']=get_clients_email($receiverid);

					}
					$post['real_sum']=prnpays($real_sum,false);
					$post['sendername']=get_clients_name($uid);
					$post['fullname']=get_clients_name($receiverid);
					$post['emailadr']=get_clients_email($receiverid);
					$post['product']="Internal Transfer";
					$post['email']=get_clients_email($uid);
					$message_ins = $message_ins . "Amount: $".$datafile[$c][0]." - To: ".$post['fullname']." - ".$post['emailadr']."\n";
					$post['message_ins']=$message_ins;
				}
			$data['PostFile']=true;
			$post['step']=1;
			}	
		}
}

if($post['step']==2){
	$datafile  = read_csv($upfile1,",");
	$num = sizeof($datafile);
	for ($c=0; $c < $num; $c++) {
		$sum+= (double)$datafile[$c][0];
	}
	if(sizeof($datafile[0]) != 3) {$data['Error'] = 'Wrong file type'; exit;}
	$post['sum']=$sum;
	$post['num']=$num;
	$real_sum=0;
	$post['user_count']=0;
	$post['user_names']="";
	if ($post['sum'] > $data['Balance'])  {
		$data['Error']='You do not have enough money in your account.';
	} else {
		for ($c=0; $c<$num; $c++) {
			$fees=((double)$datafile[$c][0]*$data['PaymentPercent']/100)+$data['PaymentFees'];
			$sender=$_SESSION['uid'];
			$post['amount']=$datafile[$c][0];
			$post['s_email']=get_clients_email($sender);
			$post['s_status']=get_clients_status($sender);
			$post['s_status_ex']=get_clients_status_ex($sender);
			$post['fees']=$fees;
			$receiverid=get_user_id($datafile[$c][1]);
			if($receiverid != ""){
				$real_sum+=$datafile[$c][0];
				$post['user_count']++;
				$post['user_names']= $post['user_names']." ".$datafile[$c][1];
				transaction(
					$_SESSION['uid'],
					$receiverid,
					$datafile[$c][0],
					$fees,
					0,
					1,
					$datafile[$c][2]
					);
					$post['clientid']= $uid;
					$post['fees']=$fees;
					$post['emailadr']=get_clients_email($uid);
					$post['fullname']=get_clients_name($uid);
					$post['username']=get_clients_name($receiverid);
					$post['product']="Internal Transfer";
					$post['comments']=$datafile[$c][2];
					$post['email']=get_clients_email($receiverid);
					send_email('SEND-MONEY', $post);
			}
			$post['real_sum']=prnpays($real_sum,false);
			$data['PostFile']=true;
			$post['sendername']=get_clients_name($uid);
			$post['fullname']=get_clients_name($receiverid);
			$post['emailadr']=get_clients_email($receiverid);
			$post['product']="Internal Transfer";
			$post['email']=get_clients_email($uid);
			$message_ins = $message_ins . "Amount: $".$datafile[$c][0]." - Paid To: ".$post['fullname']." - ".$post['emailadr']."\n";
			$post['message_ins']=$message_ins;
		}
		$post['clientid']= $uid;
		send_email('MASSPAY-RECEIPT', $post);
		$data['PostFile']=true;
		
	}
}
elseif($post['step']==3){
	header("Location:{$data['Host']}/user/index.do");
	exit;
}
###############################################################################
display('user');
###############################################################################
?>
