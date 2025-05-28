<?
$data['PageName']	= 'EMAILS';
$data['PageFile']	= 'emails'; 
$data['HideLeftSide']=true;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Emails Report - '.$data['domain_name'];
###############################################################################
/*
echo "<br/>email_zoho_etc1=>".$_SESSION['email_zoho_etc'];
echo "<br/>login_adm=>".$_SESSION['login_adm'];
echo "<br/>adm_login=>".$_SESSION['adm_login']."<br/><br/>";
*/
if((!isset($_SESSION['login_adm']))&&((!isset($_SESSION['email_zoho_etc']))||(isset($_SESSION['email_zoho_etc'])&&$_SESSION['email_zoho_etc']==0))){
	$_SESSION['adminRedirectUrl']=$data['urlpath'];
	//header("Location:{$data['Admins']}/login".$data['iex']);
	echo('ACCESS DENIED.');
	exit;
}
//$post=select_info($uid, $post);

if(!isset($post['action'])||!$post['action']){$post['action']='select'; $post['step']=1; }

if(!isset($post['step'])||!$post['step']){$post['step']=1; }

###############################################################################

//print_r($post); print_r($uid); echo "=h1=";

###############################################################################
if(isset($post['send'])&&$post['send']){
        if($post['step']==1){
			$post['step']++;
        }elseif($post['step']==2){
			if(!isset($post['subject'])||!$post['subject']){
				$data['Error']='Please Select or Enter Subject.';
			}elseif(!isset($post['comments'])||!$post['comments']){
				$data['Error']='Please enter message.';
			
			}else{
                if(!isset($post['gid'])||!$post['gid']){
					$post['ticketid'] = (substr(number_format(time() * rand(111,999),0,'',''),0,12));
					$comments_date = date('Y-m-d H:i:s');
					//$messages=nl2br(stripslashes($post['comments']));
					$messages = addslashes($post['comments']);
					$comments = "<div class=rmk_row><div class=rmk_date>".$comments_date."</div><div class=rmk_msg>".$messages."</div></div>";
				
					db_query(
						"INSERT INTO `{$data['DbPrefix']}email_details`(".
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
							"UPDATE `{$data['DbPrefix']}email_details` SET ".
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
}elseif(isset($post['action'])&&$post['action']=='addmessage'){
	$email_details=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}email_details` WHERE `id`={$post['id']}",0
	);
	$email_to 		= encrypts_decrypts_emails($email_details[0]['email_to'],2); 
	$email_from 	= encrypts_decrypts_emails($email_details[0]['email_from'],2); 
	$subject 		= $email_details[0]['subject'];
	//$message 		= $email_details[0]['message'];
	$rmk_date		= date('d-m-Y h:i:s A');
	$uid			= $email_details[0]['clientid'];
	
	
	
		$pst['tableid']=$post['id'];
		$pst['clientid']=$uid;
		$pst['mail_type']="8"; 

	
	
		
	
	$email_to_1=emtagf($email_to,3);
	$email_to_name=$email_to_1['name'];
	$email_to_value=$email_to_1['email'];
	
	
	//$email_to_name=$email_to; $email_to_value=$email_to;
	
	
	$post['email']=$email_to_value;
	
	
	/*
	//$_GET['qp']=1;
	echo "<br/>email_to=>".prntext($email_to);
	echo "<br/>email_from=>".prntext($email_from);
	echo "<br/>email1=>".str_replace(array('<','>',' <','> ','< ',' >'),'',$post['email']);
	echo "<br/>email=>".$post['email'];
	echo "<br/>email_to_name=>".$email_to_name;
	echo "<br/>email_to_value=>".$email_to_value;
	echo "<br/>subject=>".$post['subject'];
	echo "<br/>pst=>";print_r($pst);
	echo "<br/>comments=>".$post['comments'];
	exit;
	*/
	
	send_attchment_message($email_to_value,$email_to_name,$post['subject'],$post['comments'],$pst);
	//exit;
	$reurl=$post['aurl'];
	header("Location:$reurl"); exit;
	
}elseif(isset($post['cancel'])&&$post['cancel']){
	$post['step']--;
}elseif(isset($post['action'])&&$post['action']=='update'){

	   global $data;
	   $id = $post['gid'];
		//echo "<div style='margin-top:100px;'></div>"; print_r($id);
		$echecks=db_rows(
                "SELECT * FROM `{$data['DbPrefix']}email_details`".
                " WHERE `clientid`='{$uid}' AND `id`='{$id}' LIMIT 1"
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
		
		
}elseif(isset($post['action'])&&$post['action']=='delete'){
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
	$start=(isset($post['StartPage'])?$post['StartPage']:0);
	  
	if($start>0){$start=$count*($start-1);}
	$limit=($start?($count?" LIMIT {$start},{$count}":" LIMIT {$start}"):
		($count?" LIMIT {$count}":''));
	// 1 page:end	
		
	$limit=query_limit_return(@$limit);
	
	if(isset($post['status'])&&($post['status'] || $post['status']>0)){
		$status = " AND s.status={$post['status']} ";
	}

	if((isset($_GET['searchkey']))&&$_GET['searchkey']){
		$searchkey=$_GET['searchkey'];
		
		$status .= " AND ( ( lower(email_to) LIKE '%".$searchkey."%' ) OR ( lower(email_from) LIKE '%".$searchkey."%' ) OR ( lower(subject) LIKE '%".$searchkey."%' ) OR ( lower(message) LIKE '%".$searchkey."%' ) OR ( lower(response_msg) LIKE '%".$searchkey."%' ) )  "; 
		
	}
	
	if((isset($_GET['mid']))&&$_GET['mid']){
		if(!isset($_GET['searchkey'])){
			$searchkey=$_GET['mid'];
		}else{
			$searchkey=$_GET['searchkey'];
		}
		
		$status = " AND ( clientid='{$searchkey}' )  "; 
		
	}
	
	$sponsor_qr="";$sponsor_tbl="";
	
	/*
	if(isset($_SESSION['sub_admin_id'])&&isset($_SESSION['sub_admin_rolesname'])&&$_SESSION['sub_admin_rolesname']=="Associate"){
		$sponsor_qr=" AND s.clientid=m.id AND  m.sponsor={$_SESSION['sub_admin_id']}   "; //GROUP BY m.id ORDER BY count
		
		$sponsor_tbl=", {$data['DbPrefix']}clientid_table AS m";
	}
	*/
	
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];
		
		$sponsor_qr  =" AND (clientid IN ({$get_mid})) ";
		
		//$sponsor_tbl =", {$data['DbPrefix']}clientid_table AS m";

	}
	
	if(!isset($status)) $status = "";
	// 2 page:start
	$result_total_count=db_rows(
		"SELECT COUNT(*) AS `count` FROM {$data['DbPrefix']}email_details AS s".$sponsor_tbl.
		" WHERE `id` IS NOT NULL ".$status." ".$sponsor_qr.
		" LIMIT 1",0
	);
	$data['result_total_count']=@$result_total_count[0]['count'];
	// 2 page:end
		
	$result_select=db_rows(
		"SELECT s.* FROM {$data['DbPrefix']}email_details AS s".$sponsor_tbl.
		" WHERE `id` IS NOT NULL ".$status." ".$sponsor_qr.
		" ORDER BY s.id DESC {$limit}"//,true
	);
	
	// 3 page:start
	$data['result_count']=($start+count(@$result_select));
	//$data['db_counts']=$db_counts;
	// 3 page:end	
	
	$data['selectdatas'] = @$result_select;
	
	
}

	
//print_r($data['selectdatas']); print_r($uid); echo "=h2=";




###############################################################################

display('admins');

###############################################################################

?>
