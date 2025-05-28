<?
include('../config.do');

function check_availability(){
	global $data;
		
	$field='';
	// Check Registered Email exists or not
	if(!empty($_POST["registered_email"])) {
		$field="registered_email='" . $_POST["registered_email"] . "' ";
		$v='Registered Email Address';
		$result=is_mail_available($_POST["registered_email"]);
		if ($result==false) echo "<span class='status-available'> Registered Email Address already exist</span>";
	}// End if Registered Email
	
	// Check Invoice already exists or not - 
	if(!empty($_POST["invoice_no"]))
	{
		$field="invoice_no='" . $_POST["invoice_no"] . "' ";

		$tbl= $_POST["tbl"];

		$qry = "SELECT id FROM {$data['DbPrefix']}{$tbl} WHERE ".$field." LIMIT 1";
		$result=db_rows($qry);
	 
		if (empty($result)) {
		}else{
			echo "<div class='status-not-available alert alert-danger'> Invoice no <b>".$_POST["invoice_no"]."</b> already exists</div>";
		}
	}
	//end invoice section
	
	// Check username exists or not - vikash
	if(!empty($_POST["username"])) {
		$field="username='" . $_POST["username"] . "' ";
		$v='Username';
		$tbl= $_POST["tbl"];
		
	  $qry = "SELECT id FROM {$data['DbPrefix']}{$tbl} WHERE ".$field." limit 1";
	  
	  $result=db_rows($qry);
	  
	 
	  if (empty($result)) {
		 echo "<div class='status-available alert alert-success'> ".$v." Available</div>";
	  }else{
		   echo "<div class='status-not-available alert alert-danger'> ".$v." Not Available</div>";
	  }// End if DB condition
	}// End if POST username
	
	//end username section
	
	// Check Swift Code exists or not - vikash
	if(!empty($_POST["bswift"])) {
		$field="swift_code='" . $_POST["bswift"] . "' ";
		$v='Swift Code';
	$tbl= $_POST["tbl"];
		
	  $qry = "SELECT bank,city,branch,country FROM {$data['DbPrefix']}{$tbl} WHERE ".$field." limit 1";
	  
	  $result=db_rows($qry);
	  
	 
	  if (empty($result)) {
		 echo '{"valid":"0","message":"We are unable to verify this SWIFT number via our Bank Directory. Proceed if your SWIFT details is correct"}';
	  }else{
	  
	   echo '{"valid":"1","bank":"'.$result[0]['bank'].'","city":"'.$result[0]['city'].'","branch":"'.$result[0]['branch'].'","country":"'.$result[0]['country'].'"}';
	   
	
	  }// End if DB condition
	}// End if POST username
}// End Function

check_availability();
?>