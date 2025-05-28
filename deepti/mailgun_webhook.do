<?php
include('config.do');
$mydata = file_get_contents("php://input");

// function to update DB
function mailgun_response($msgID,$event)
{
	global $data;
	$qry  = "UPDATE `{$data['DbPrefix']}email_details` ";
	$qry .= " SET `response_status`='".$event."'  ";
	$qry .= " WHERE (lower(response_msg) LIKE '%".$msgID."%')";
	echo $qry;
    db_query($qry);
}

//Converting received data into readable array format
  function  create_array($data)
  {
	$length= strlen($data);
	$data=substr ($data,2,$length-4);
	$data=(explode(",",$data));
	$check=false;
	$i=0;
	$c=0;
	foreach ($data as $value)
	{
		$length= strlen($value);
		$f1=strpos ($value,'":');
		$key=substr ($value,1,$f1-1);
		$key=str_replace('"','',$key);
		$value=substr ($value,$f1+3,$length-1);	
		$value=str_replace('"','',$value);
		$ck=array($key=>$value);
		if ($check==true)
		{
			$myary=array_merge($myary,$ck);
		}
		else {
			$myary=$ck;
		}// end if
		$check=true;	
		
	}// End forloop
	
	return $myary;
  }// End function
  
  
  
$myary=create_array($mydata);// This is array of all received values, can be used to store data in DB.


// Array data print, just for our understanding
foreach ($myary as $key=>$value)
{	
	if ($key=='event'){$event=$value;}
	if ($key=='message-id'){$msgID=$value;}
}// End Loop

if (empty($msgID)){	
	  $msgID=$myary['message'];
	  $length= strlen($msgID);
	  $f1=strpos ($msgID,'message-id:');
	  $msgID=substr ($msgID,$f1+11,$length);	
	  $msgID=str_replace('}}','',$msgID);
}
// CALL to function to update DB
if (!empty($msgID)){mailgun_response($msgID,$event);}

?>