<?
$data['PageName']	= 'Daily Statement';
$data['PageFile']	= 'daily_trans_statement'; 
$data['HideLeftSide']=true;
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Daily Statements - '.$data['domain_name'];
$data['FileName']='daily_trans_statement'.$data['ex'];
###############################################################################

function createDateRange($startDate, $endDate, $format = "Y-m-d")
{
    $begin = new DateTime($startDate);
    $end = new DateTime($endDate);

    $interval = new DateInterval('P1D'); // 1 Day
    $dateRange = new DatePeriod($begin, $interval, $end);

    $range = [];
    foreach ($dateRange as $date) {
        $range[] = $date->format($format);
    }

    return $range;
}
function merchant_date_wise_statement($uid)
{
	global $data; $qprint=0;
	$tdate=db_rows(
		"SELECT MIN(`tdate`) AS `min_tdate`, MAX(`tdate`) AS `max_tdate`".
		" FROM `{$data['DbPrefix']}transactions`".
		" WHERE `receiver`={$uid} OR `sender`={$uid}".
		" LIMIT 1",$qprint
	);
	
	$min_tdate=date("Y-m-d",strtotime($tdate[0]['min_tdate']));
	$max_tdate=date("Y-m-d",strtotime($tdate[0]['max_tdate']));
	$max_tdate2=date("Y-m-d",strtotime("+1 day",strtotime($tdate[0]['max_tdate'])));
	
	$cd=createDateRange($min_tdate, $max_tdate2);
	$i=1;
	
	$update=0;
	if(isset($_GET['update'])&&$_GET['update']){
		$delete=db_query("DELETE FROM `{$data['DbPrefix']}daily_tras_statement`"." WHERE `clientid`={$uid} ",0); 
		$update=1;
		//exit;
	}
	foreach($cd as $key=>$value){
		//echo $i.". date=>".date("d-m-Y",strtotime($value))."<br/>";
		//echo $i.". date=>".date("Y-m-d",strtotime($value))."<br/>";
		
		$ds=daily_trans_statement_amt($uid,date("Y-m-d",strtotime($value)),$update); // merchantid and singal date wise
		
		$i++;
	}
	
	echo "count=>".$i."<br/>";
	echo "min_tdate=>".$min_tdate."<br/>";
	echo "max_tdate=>".$max_tdate."<br/>";
}

if(!$_SESSION['adm_login']){
        header("Location:{$data['Admins']}/login".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
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
						"INSERT INTO `{$data['DbPrefix']}support_tickets1`(".
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
elseif($post['action']=='insert_patch_date_wise'||$post['action']=='insert_all'){
	
//http://localhost/ztswallet/mlogin/daily_trans_statement.do?bid=40&ptdate=2018-10-30&action=insert_patch_date_wise 

		$bid="";$ptdate=date('Y-m-d');
			
		if(isset($_GET['bid'])&&$_GET['bid']){$bid=$_GET['bid'];}
		if(isset($_GET['ptdate'])&&$_GET['ptdate']){
			$ptdate=date('Y-m-d',strtotime($_GET['ptdate']));
		}
		
		if($post['action']=='insert_patch_date_wise'){
			$ds=daily_trans_statement_amt($bid,$ptdate); // merchantid and singal date wise
		}elseif($post['action']=='insert_all'){
			$ds=daily_trans_statement_amt(); // all
		}

//$ds=daily_trans_statement_amt(); // all
//$ds=daily_trans_statement_amt('',$ptdate); // all and singal date wise

	//echo "<hr/>daily_trans_statement_amt=>";print_r($ds);
		
}elseif($post['action']=='merchant_date_wise'){
	if(isset($_GET['mid'])&&$_GET['mid']){
		$mdws=merchant_date_wise_statement($_GET['mid']); // all
	}
	
	if(isset($_GET['update'])&&$_GET['update']){
		exit;
	}
}


if($post['step']==1){
     // global $data;
	 
	 if(!isset($post['status'])){
		$post['status']=1;
	 }
	 
	 $where_qry="";
	
	// 1 page:start
	$count=100;
	$start=$post['StartPage'];
	  
	if($start>0){$start=$count*($start-1);}
	$limit=($start?($count?" LIMIT {$start},{$count}":" LIMIT {$start}"):
		($count?" LIMIT {$count}":''));
	// 1 page:end	
		
	$status =""; 
	if($post['status'] || $post['status']=="0"){
		$status = " s.status={$post['status']} AND ";
	}
	
	if((isset($_GET['searchkey']))&&$_GET['searchkey']){
		$searchkey=$_GET['searchkey'];
		
		$status .= " ( ( lower(subject) LIKE '%".$searchkey."%' ) OR ( lower(comments) LIKE '%".$searchkey."%' ) OR ( lower(reply_comments) LIKE '%".$searchkey."%' ) OR ( lower(date) LIKE '%".$searchkey."%' ) OR ( lower(reply_date) LIKE '%".$searchkey."%' ) OR ( lower(clientid) LIKE '%".$searchkey."%' ) ) AND "; 
		
	}
	
	$sponsor_qr="";
	if(isset($_SESSION['sub_admin_id'])&&isset($_SESSION['sub_admin_rolesname'])&&$_SESSION['sub_admin_rolesname']=="Associate"){
		$sponsor_qr=" AND  m.sponsor={$_SESSION['sub_admin_id']}   "; //GROUP BY m.id ORDER BY count
	}
	
	//filter 
	if(isset($post['bid'])&&$post['bid']){
		$sponsor_qr.=" AND (s.clientid={$post['bid']}) ";
	}
	if(isset($_GET['bdate'])&&$_GET['bdate']){
		$bdate=$_GET['bdate']." 00:00:00";
		$sponsor_qr.=" AND (s.batch_date='{$bdate}') ";
	}
	
	// 2 page:start
	$result_total_count=db_rows(
		"SELECT COUNT(s.id) AS `count` FROM {$data['DbPrefix']}daily_tras_statement AS s, {$data['DbPrefix']}clientid_table AS m".
		" WHERE ".$status." s.clientid=m.id AND s.status={$post['status']} ".$sponsor_qr.
		" ORDER BY s.id DESC LIMIT 1"//,true
	);
	$data['result_total_count']=$result_total_count[0]['count'];
	// 2 page:end
		
	$result_select=db_rows(
		"SELECT s.*,m.company_name,m.fullname,m.fname,m.lname,m.phone,m.email,m.username,m.address,m.city,m.state,m.country,m.zip FROM {$data['DbPrefix']}daily_tras_statement AS s,  {$data['DbPrefix']}clientid_table AS m".
		" WHERE ".$status."  s.clientid=m.id AND s.status={$post['status']} ".$sponsor_qr.
		" ORDER BY s.id DESC {$limit}",0
	);
	
	// 3 page:start
	$data['result_count']=($start+sizeof($result_select));
	//$data['db_counts']=$db_counts;
	// 3 page:end	
	
	$data['selectdatas'] = $result_select;
	
	//print_r($data['selectdatas']);
	if($post['bid']>0){
		$post['ab']=account_balance($post['bid']);
		$post['mb']=merchant_balance($post['bid']);
		$post['mbt']=account_trans_balance_calc($post['bid']);
		$post['mbt_d']=account_trans_balance_calc_d($post['bid']);
	}
	
}

//http://localhost/ztswallet/mlogin/daily_trans_statement.do?bid=40&ptdate=2018-10-30 

$bid=40;
$ptdate=date('Y-m-d');
	
if(isset($_GET['bid'])&&$_GET['bid']){$bid=$_GET['bid'];}
if(isset($_GET['ptdate'])&&$_GET['ptdate']){
	$ptdate=date('Y-m-d',strtotime($_GET['ptdate']));
	
}
//echo "<hr/>ptdate2=>".$ptdate."<hr/>";
	
//print_r($data['selectdatas']); print_r($uid); echo "=h2=";


if(isset($_GET['ptdate'])&&isset($_GET['pfdate'])&&$_GET['pfdate']){
	$pfdate=date('Y-m-d',strtotime($_GET['pfdate']));
	$ptdate=date('Y-m-d',strtotime($_GET['ptdate']));
	$ptdate['date_1st']=$pfdate;
	$ptdate['date_2nd']=$ptdate;
}



//$ds=daily_trans_statement_amt($bid,$ptdate); // merchantid and singal date wise

//$ds=daily_trans_statement_amt(); // all
//$ds=daily_trans_statement_amt('',$ptdate); // all and singal date wise

//echo "<hr/>daily_trans_statement_amt=>";print_r($ds);

###############################################################################

display('admins');

###############################################################################

?>
