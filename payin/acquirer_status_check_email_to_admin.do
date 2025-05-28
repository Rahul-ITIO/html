<?php

//Dev Tech : 2024-03-09 for check the status url is working or not than email for admin - start and if found value from Bank Status Path via br_status_path ------------------

//$br_status_path = @$bank_acquirer_json_arr['br_status_path'];
if((isset($br_status_path)&&!empty(trim($br_status_path))&&strtoupper($br_status_path)!='NA')||(isset($current_headers_status)&&!empty(trim($current_headers_status))))
{

	//if($data['cqp']) echo "<br/><br/>br_status_path=>".@$br_status_path;
	if(!isset($current_headers_status))
	{
		$br_status_path_headers = @get_headers($br_status_path);
		if ($br_status_path_headers&&isset($br_status_path_headers[0])&&((strpos(@$br_status_path_headers[0],'200') !== false)||(strpos(@$br_status_path_headers[0],'403') !== false))) 
		{ 
			// for true - start
			$current_headers_status=200;
		} else { 
			// for false - stop
			$current_headers_status=404;
		}
	}
	
	if($current_headers_status==200) 
		$exists_br_status = 'Back UP ';
	else  $exists_br_status = 'Down ';
	
	$cron_bank_status_response=(int)@$acquirer_table['cron_bank_status_response'];
	
	$data['email_subject']=date('Y-m-d H:i:s').' - '.@$acquirer_table['acquirer_id'].' - '.strtoupper(@$acquirer_table['acquirer_name']).' Status URL is '.$exists_br_status.' | '.((isset($td))?@$td['transID']." - Mail from ".@$_SERVER["HTTP_HOST"]:'');
	
	//send email if start or failed  response via header for bank status url 
	if(@$cron_bank_status_response!=@$current_headers_status)
	{
		$real_time_acquirer_status_log="Real Time Acquirer Status Log : ".$current_headers_status;
		
		/*
		
		db_query("UPDATE `{$data['DbPrefix']}acquirer_table`"." SET `cron_bank_status_response`='{$current_headers_status}'  WHERE `id`={$acquirer_table['id']}  ",$qp);
		
		
		
		$data['status_in_email']=1;
		$data['devEmail']='arun@itio.in';
		if(trim($acquirer_table['notification_email']))
			$data['devEmail']=$data['devEmail'].','.$acquirer_table['notification_email'];
		
		$send_attchment_message5=1;
		include('status_in_email'.$data['iex']);

		*/
	}

	if($data['cqp']==11)
	{
		
		echo "<br/><br/>cron_bank_status_response=>".@$cron_bank_status_response;		
		echo "<br/><br/><b>real_time_acquirer_status_log</b>=>".@$real_time_acquirer_status_log;		
		echo "<br/><br/>br_status_path=>".@$br_status_path;
		echo "<br/>exists_br_status=>".@$exists_br_status;
		echo "<br/>current_headers_status=>".@$current_headers_status;
		echo "<br/><br/>br_status_path_headers=><br/>";
		print_r($br_status_path_headers);

		echo "<br/><br/>";
		//exit;
	}
	
	if(isset($current_headers_status)&&$current_headers_status!=200) 
	{
		echo $data['email_subject'];
		if(!isset($_SESSION['adm_login'])) exit;
	}
}
//Dev Tech : 2024-03-09 for check the status url is working or not than email for admin - end  ------------------

?>