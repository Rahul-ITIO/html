<?
$data['PageName']	= 'MESSAGE CENTER';
$data['PageFile']	= 'support-ticket'; 
$data['HideLeftSide']=true;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Message Center - '.$data['domain_name'];
###############################################################################
if((!isset($_SESSION['adm_login']))&&(!isset($_SESSION['support_messages']))){
		$_SESSION['adminRedirectUrl']=$data['urlpath'];
        header("Location:{$data['Admins']}/login".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}

if((isset($_SESSION['login_adm']))||(isset($_SESSION['ticket_link'])&&$_SESSION['ticket_link']==1)){
	
}

//$post=select_info($uid, $post);

if(!$post['action']){$post['action']='select'; $post['step']=1; }
if(!$post['step']){$post['step']=1; }

###############################################################################

//print_r($post); print_r($uid); echo "=h1=";

###############################################################################
if($post['send']){
        if($post['step']==1){
                $post['step']++;
        }elseif($post['step']==2){
          if(!$post['subject']){
			  $data['Error']='Please Select or Enter Subject.';
			}elseif(!$post['comments']){
				$data['Error']='Please enter message.';
			
			}else{
                if(!$post['gid']){
					$post['ticketid'] = (substr(number_format(time() * rand(111,999),0,'',''),0,12));
					$comments_date = date('Y-m-d H:i:s');
					//$messages=nl2br(stripslashes($post['comments']));
					$messages=addslashes($post['comments']);
					$comments = "<div class=rmk_row><div class=rmk_date>".$comments_date."</div><div class=rmk_msg>".$messages."</div></div>";
					
					db_query(
						"INSERT INTO `{$data['DbPrefix']}support_tickets`(".
						"`clientid`,".
						"`subject`,`date`,`comments`,`ticketid`".
						")VALUES(".
						"'{$uid}',".
						"'{$post['subject']}','{$comments_date}','{$comments}','{$post['ticketid']}'".
						")"
					);
				}
                else { 
				/*
					global $data;
					$reply_date = date('Y-m-d H:i:s');
					db_query(
							"UPDATE `{$data['DbPrefix']}support_tickets` SET ".
							"`subject`='{$post['subject']}',`reply_date`='{$reply_date}',`reply_comments`='{$post['reply_comments']}'".
							" WHERE `id`={$post['gid']}"
					);
					*/

				}
				
				$data['sucess']		="true";
				$post['subject']	=$post['subject'];
				$post['date']		=$post['date'];
				$post['step']--;
				$post['comments']= ""; $post['comments']--;
				//send_email('REQUEST-MONEY', $post);
				$data['PostSent']=true;
				
				
          }
        }
}elseif($post['action']=='addmessage'){
	$message_slct=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}support_tickets` WHERE `id`={$post['id']} LIMIT 1"
	);
	//$message_get 	= $message_slct[0]['reply_comments'];
	$message_get 	= $message_slct[0]['comments'];	
	$status_get 	= $message_slct[0]['status']; 
	$reply_date_get = $message_slct[0]['reply_date'];
	$ticketid 		= $message_slct[0]['ticketid'];
	$rmk_date		= date('d-m-Y h:i:s A');
	$uid			= $message_slct[0]['clientid'];
	
	if(empty($reply_date_get)){$redate = " ,`reply_date`='{$rmk_date}' "; }else {$redate = "";}
	//$messages=nl2br(stripslashes($post['comments']));
	$messages=addslashes($post['comments']);
	$message_upd = $message_get."<div class=admin_msg_row><div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$messages."</div></div></div>";
	$status = $post['status'];
	
	if($post['comments']){
		db_query(
			"UPDATE `{$data['DbPrefix']}support_tickets`".
			" SET `comments`='{$message_upd}',`status`='{$status}'".$redate.
			" WHERE `id`={$post['id']}"
		);
	}
	$post['comments']= ""; 
	$post['step']=1;
	$post['action']='select';
	
	//$email_status=$data['TicketStatus'][$status];
	
	if($status==2){//close
		$email_status="No Action Required";
	}elseif($status==1){//Process
		$email_status="Awaiting for merchant reply (Kindly login to your merchant portal and Add Remark)";
	}
	
	 $email_messages=$messages."<p style='border-bottom: 2px solid #969696;background: #ccc;padding: 5px;font-size: 14px;font-weight: bold;'>Ticket Details</p><p>Ticket ID: {$ticketid}</p><p>Status: {$email_status}</p><p>Date: {$rmk_date}</p>";
	 
	 
	$pst['tableid']=$post['id'];
	$pst['clientid']=$uid;
	$pst['mail_type']="7";
	
	send_attchment_message($post['email'],$post['email'],"Re: ".$post['subject'],$email_messages,$pst);
	//exit;
	$reurl=$post['aurl'];
	header("Location:$reurl");
	exit;
	
}elseif($post['action']=='newmessages'){
	
	//print_r($_POST);
	
	if(isset($_SESSION['login_adm'])&&$_SESSION['login_adm']){
		$filterid=-1413;
	}else{
		$filterid=$_SESSION['sub_admin_id'];
	}
	
	$messages=addslashes($_POST['comments']);
	
	$redate = "";
	$rmk_date		= date('d-m-Y h:i:s A');
		
	//$messages=nl2br(stripslashes($post['comments']));
	
	$message_upd = "<div class=admin_msg_row><div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$messages."</div></div></div>";
	$status = 3;
	
	
	foreach($post['multiple_merchant_ids'] as $key=>$value){
		
		$v_exp=explode('_;',$value);
		$uid=$v_exp[0];
		$user_id=$v_exp[1];
		$post['email']=$v_exp[2];
		
		
		 echo "<br>id=>".$uid;
		 echo "<br>user_id=>".$user_id;
		 echo "<br>email=>".$post['email'];
		 echo "<hr/>";
		 
		 
		
		$ticketid = (substr(number_format(time() * rand(111,999),0,'',''),0,12));
		
		
		db_query(
			"INSERT INTO `{$data['DbPrefix']}support_tickets`(".
			"`clientid`,".
			"`subject`,`date`,`comments`,`ticketid`,`status`,`filterid`".
			")VALUES(".
			"'{$uid}',".
			"'{$post['subject']}','{$rmk_date}','{$messages}','{$ticketid}',{$status},{$filterid}".
			")"
		);
		
		
		$new_id=newid();
		$post['step']=1;
		$post['action']='select';
		
		$email_status=$data['TicketStatus'][$status];
		
		
		
		 $email_messages=$messages."<hr/><p style='border-bottom: 2px solid #969696;background: #ccc;padding: 5px;font-size: 14px;font-weight: bold;'>Ticket Details</p><p>Ticket ID: {$ticketid}</p><p>Status: {$email_status}</p><p>Date: {$rmk_date}</p>";
		 
		 
		$pst['tableid']=$new_id;
		$pst['clientid']=$uid;
		$pst['mail_type']="7";
		
		send_attchment_message($post['email'],$post['email'],$post['subject'],$email_messages,$pst);
		
		
	}
	
	//exit;
	$reurl=$post['aurl'];
	header("Location:{$data['Admins']}/message{$data['ex']}?&action=select&type=0");
	exit;
	
}elseif($post['cancel']){
	$post['step']--;
}elseif($post['action']=='update'){
       
	   global $data;
	    $id = $post['gid'];
		//echo "<div style='margin-top:100px;'></div>"; print_r($id);
		$echecks=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}support_tickets`".
                " WHERE `clientid`={$uid}  AND `id`={$id} LIMIT 1"
        );
        $results=array();
		
		
		
        foreach($echecks as $key=>$value){
                foreach($value as $name=>$v) {
					$results[$key][$name]=$v;
					
					if(!$post[$key][$name]){
						$post[$key][$name]=$v;
					}
				}
        }
        
		
		//echo "<div style='margin-top:100px;'></div>"; print_r($post);
		
        $post['actn']='update';
        $post['step']++;
		
		
}elseif($post['action']=='delete'){
		global $data;
		$gid = $post['gid'];
		/*
        db_query(
                "DELETE FROM `{$data['DbPrefix']}support_tickets`".
                " WHERE `id`={$gid}"
        );
		*/
}



if($post['step']==1){
     // global $data;
	
	// 1 page:start
	$count=50;
	$start=$post['StartPage'];
	  
	if($start>0){$start=$count*($start-1);}
	$limit=($start?($count?" LIMIT {$start},{$count}":" LIMIT {$start}"):
		($count?" LIMIT {$count}":''));
	// 1 page:end	
		
	  
	if($post['status'] || $post['status']=="0"){
		$status = " s.status={$post['status']} AND ";
	}
	
	if((isset($_GET['searchkey']))&&$_GET['searchkey']){
		$searchkey=$_GET['searchkey'];
		
		//Check if date
		$ddate=date("Y-m-d", strtotime($searchkey));
		$rdate=date("d-m-Y",strtotime($searchkey));
		if ($ddate=='1970-01-01'){$ddate=$searchkey;$rdate=$searchkey;}
		
		
		/*$status .= " ( ( lower(subject) LIKE '%".$searchkey."%' ) OR ( lower(comments) LIKE '%".$searchkey."%' ) OR ( lower(reply_comments) LIKE '%".$searchkey."%' ) OR ( lower(date) LIKE '%".$searchkey."%' ) OR ( lower(reply_date) LIKE '%".$searchkey."%' ) OR ( lower(clientid) LIKE '%".$searchkey."%' ) ) AND "; */
		
		$status .= " ( ( lower(subject) LIKE '%".$searchkey."%' ) OR ";
		$status .=" ( lower(comments) LIKE '%".$searchkey."%' ) OR ";
		$status .=" ( lower(reply_comments) LIKE '%".$searchkey."%' ) OR ";
		$status .=" ( lower(date) LIKE '%".$ddate."%' ) OR ";
		$status .=" ( lower(reply_date) LIKE '%".$rdate."%' ) OR ";
		$status .="( lower(clientid) LIKE '%".$searchkey."%' ) ) AND "; 
		
	}
	
	$sponsor_qr="";
	
	
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];
		
		$sponsor_qr  =" AND  ( m.id IN ({$get_mid}) )   ";

	}
	
	// 2 page:start
	$qry ="SELECT COUNT(s.id) AS `count` FROM {$data['DbPrefix']}support_tickets ";
	$qry.="AS s, {$data['DbPrefix']}clientid_table AS m";
	$qry.=" WHERE ".$status." s.clientid=m.id AND s.filterid={$post['type']} ".$sponsor_qr;
	$qry.=" ORDER BY s.id DESC LIMIT 1";
	
	//echo $qry;	
	$result_total_count=db_rows($qry,0);
	$data['result_total_count']=$result_total_count[0]['count'];
	
	// 2 page:end		
	$qry ="SELECT s.*,m.company_name,m.fullname,m.fname,m.lname,m.phone,m.email,";
	$qry.="m.username,m.address,m.city,m.state,m.country,m.zip ";
	$qry.="FROM {$data['DbPrefix']}support_tickets AS s,  {$data['DbPrefix']}clientid_table AS m";
	$qry.=" WHERE ".$status."  s.clientid=m.id AND s.filterid={$post['type']} ".$sponsor_qr;
	$qry.=" ORDER BY s.id DESC {$limit}";
		
	$result_select=db_rows($qry,0);
	
	// 3 page:start
	$data['result_count']=($start+sizeof($result_select));
	//$data['db_counts']=$db_counts;
	// 3 page:end	
	
	$data['selectdatas'] = $result_select;
	
	$data['Sponsors']=get_sponsors('','');//15
	$data['clientsList']=get_sponsors_mem('',1);//15
	
	
}
//print_r($data['selectdatas']); print_r($uid); echo "=h2=";
###############################################################################
display('admins');
###############################################################################
?>
