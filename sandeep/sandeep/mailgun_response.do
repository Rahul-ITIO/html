<?php

include('config.do');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	$event=$_POST['event'];
	$msg_id=$_POST['message-id'];
	
	// Call function to update DB
	mailgun_response($msg_id,$event);
}// End If


// function to update DB
function mailgun_response($msg_id,$event)
{
	global $data;
	$qry  = "UPDATE `{$data['DbPrefix']}email_details` ";
	$qry .= " SET `response_status`='{$event}'  ";
	$qry .= " WHERE (lower(response_msg) LIKE '%".$msg_id."%')";
	
	//update in the DB
	//db_query($qry);
}// end function
?>