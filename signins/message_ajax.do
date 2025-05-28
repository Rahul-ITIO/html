<?
$data['PageName']	= 'MESSAGE CENTER';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Message Center - '.$data['domain_name']; 
###############################################################################
if(!$_SESSION['adm_login']){
		$_SESSION['adminRedirectUrl']=$data['urlpath'];
        header("Location:{$data['slogin']}/login".$data['ex']);
        echo('ACCESS DENIED.');
        exit;
}
$pra=[];
if(isset($post['action']) && $post['action']=="editdraft"){
	
	$photograph_view='';
	
	$edit_drf=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}support_tickets`".
			" WHERE `id`={$post['gid']} "
	);
	
	//$comments_ex=explode("",$edit_drf[0]['comments']);
	
	$pra['post_id']=$edit_drf[0]['id'];
	$pra['message_type']=$edit_drf[0]['message_type'];
	$pra['subject']=$edit_drf[0]['subject'];
	$pra['comments']=$edit_drf[0]['comments'];
	$pra['ticketid']=$edit_drf[0]['ticketid'];
	
	$pra['message_type_other']="";
	if(!is_numeric($pra['message_type'])) {
		$pra['message_type_other']=$pra['message_type'];
	}
	
	
	$json_value=$edit_drf[0]['json_value'];
	$json_value=jsondecode($json_value);
	$pra['multiple_merchant_ids']=$json_value['multiple_merchant_ids'];
	
	$join_photograph_file=$edit_drf[0]['admin_doc'];
	
	if(isset($join_photograph_file) && $join_photograph_file){
			$photo=explode('_;',$join_photograph_file);
			foreach($photo as $value_po){
				if(isset($value_po) && $value_po){
					$photograph_view.="<div style=display:block;><div class=abcd><span onclick=uploadfile_viewf(this)><img src=".encode_imgf($data['Path']."/user_doc/".$value_po)."></span><img onClick=ajax_remove_files(this) id=img src={$data['Host']}/images/x.png alt=delete data-file=".($value_po)."></div></div>";
				}
			}
		}
		
		
		if(isset($photograph_view) && $photograph_view){
			$photograph_view="<div class=row style=margin:0;margin-top:25px><div id=formdiv style=float:left>".$photograph_view."</div></div>";
		}
		
	$pra['photograph_view']=$photograph_view;
	
	json_print($pra);	

	exit;
}


unset($data['TicketStatus'][5]);

function supports_f($uid,$filterid=0,$status=''){
	global $data;
	$qr_s=""; $order='';
	
	// 1 page:start
	$count=50;
	$start=(isset($_GET['page'])?$_GET['page']:0);
	  
	if($start>0){$start=$count*($start-1);}
	$limit=($start?($count?" LIMIT {$start},{$count}":" LIMIT {$start}"):
		($count?" LIMIT {$count}":''));
	// 1 page:end	
	
	if(!empty($limit))
	$limit=query_limit_return($limit);
	
	if(isset($_GET['stf'])&&$_GET['stf']!=''){
		$qr_s.=" AND `status`={$status} ";
	}elseif($status){
		$qr_s.=" AND `status`={$status} ";
	}
	
	
	
	if($filterid==4){ // draft
		$qr_s.=" AND `status`=92 ";
	}
	
	if($filterid==3){ //sent
		$qr_s.=" AND `filterid` NOT IN (0) AND `status` NOT IN (90,92) ";
		//$order=" FIELD(`status`, '91') DESC ,";
		if($data['connection_type']=='PSQL')
			$order=' ARRAY_POSITION(ARRAY[2,4,0,1,91], "status") ,  ';
		else
			$order=" FIELD(`status`, 2,4,0,1,91) DESC, ";
		
	}
	
	if($filterid==1){ // inbox
		//$order=" `status` DESC ";
		if($data['connection_type']=='PSQL')
			$order=' ARRAY_POSITION(ARRAY[2,4,91,1,0], "status") ,  ';
		else
			$order=" FIELD(`status`, 2,4,91,1,0) DESC, ";

		$qr_s.=" AND `status` NOT IN (90) ";
	}
	
	
	
	
	if((isset($_GET['searchkey']))&&$_GET['searchkey']){
		$searchkey=$_GET['searchkey'];
		
		//Check if date
		$ddate=date("Y-m-d", strtotime($searchkey));
		$rdate=date("d-m-Y",strtotime($searchkey));
		if ($ddate=='1970-01-01'){$ddate=$searchkey;$rdate=$searchkey;}
		
		$qr_s=" WHERE `id` NOT IN (0)  AND  ";
		
		$qr_s .=" ( lower(ticketid) LIKE '%".$searchkey."%' ) OR ";
		$qr_s .= " ( ( lower(subject) LIKE '%".$searchkey."%' ) OR ";
		$qr_s .=" ( lower(comments) LIKE '%".$searchkey."%' ) OR ";
		$qr_s .=" ( lower(reply_comments) LIKE '%".$searchkey."%' ) OR ";
		$qr_s .=" ( lower(date) LIKE '%".$ddate."%' ) OR ";
		$qr_s .=" ( lower(reply_date) LIKE '%".$rdate."%' ) OR ";
		$qr_s .="( lower(clientid) LIKE '%".$searchkey."%' ) )  "; 
		
	}
	
	
	if((isset($_SESSION['sub_admin_id']))&&($_SESSION['get_mid']!='M. All')){
		$get_mid=$_SESSION['get_mid'];
		
		$qr_s  .=" AND  ( `clientid` IN ({$get_mid}) )   ";

	}
	
	if(!empty($qr_s))
	{
		$qr_s=trim($qr_s); 
		$qr_s=" WHERE  ".ltrim($qr_s,"AND");
	}
	
	
	
	$result_count=db_rows(
		"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}support_tickets`".
		$qr_s.
		" LIMIT 1",0 //`date` DESC
	);
	$data['result_total_count']=(@$result_count[0]['count']);
	
	$result=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}support_tickets`".
		$qr_s.
		" ORDER BY {$order} `id` DESC {$limit}",0 //`date` DESC
	);
	
	foreach($result as $key=>$value){
		$result[$key]=$value;
		$mem=db_rows(
			"SELECT * ".
			" FROM `{$data['DbPrefix']}clientid_table`".
			" WHERE `id`={$result[$key]['clientid']}".
			" ",0
		);
		
		if(isset($mem[0]))
		{
			$sponsor=$mem[0]['sponsor'];
			$result[$key]['sponsor']=$sponsor;
			$result[$key]['m']=$mem[0];
		}
		
		if(isset($sponsor) && $sponsor>0){
		
			$query="SELECT `upload_css`,`domain_name`,`header_bg_color`,`header_text_color`,`body_bg_color`,`body_text_color`,`heading_bg_color`,`heading_text_color` FROM `{$data['DbPrefix']}subadmin` WHERE `id`='".$sponsor."' LIMIT 1";
				
			$asco=db_rows($query);
			$csscolor=$asco[0]['upload_css'];
				
			// For theme color option Added
			$header_bg_color=$asco[0]['header_bg_color'];
			$header_text_color=$asco[0]['header_text_color'];
			$body_bg_color=$asco[0]['body_bg_color'];
			$body_text_color=$asco[0]['body_text_color'];
			$heading_bg_color=$asco[0]['heading_bg_color'];
			$heading_text_color=$asco[0]['heading_text_color'];

			$colors=clients_css_color($csscolor,'#fff');
			$bgcolor=$colors[1];
			$color=$colors[0];
			
			if(isset($data['localhosts']) && $data['localhosts']){
				$domain_name=$data['HostG'];
			}else{
				if(isset($asco[0]['domain_name']) && $asco[0]['domain_name']){
					$domain_name='https://'.$asco[0]['domain_name'];
				}else{
					$domain_name=$data['HostG'];
				}
			}
			
		}
		else {
			$color='#726767 !important;color:#fff !important;border:1px solid #726767  !important;';
			$domain_name=$data['HostG'];
		}
		
		$result[$key]['color']=$color;
		$result[$key]['domainName']=$domain_name;
		// For theme color option 
		$result[$key]['header_bg_color']=(isset($header_bg_color)?$header_bg_color:'');
		$result[$key]['header_text_color']=(isset($header_text_color)?$header_text_color:'');
		$result[$key]['body_bg_color']=(isset($body_bg_color)?$body_bg_color:'');
		$result[$key]['body_text_color']=(isset($body_text_color)?$body_text_color:'');
		$result[$key]['heading_bg_color']=(isset($heading_bg_color)?$heading_bg_color:'');
		$result[$key]['heading_text_color']=(isset($heading_text_color)?$heading_text_color:'');	
	}
	
	return $result;
}

if(isset($post['action']) && $post['action']=="removedraft"){
	db_query(
		"DELETE FROM `{$data['DbPrefix']}support_tickets`".
		" WHERE (`id`={$post['gid']})"
	);
	if($data['connection_type']=='PSQL'){
		db_query(
			"SELECT setval('{$data['DbPrefix']}support_tickets_id_seq', (SELECT MAX(`id`) FROM `{$data['DbPrefix']}support_tickets`)+1);",0
		);
	}
	$_GET['filter']=4;
}elseif(isset($post['action']) && ($post['action']=="readNewEmail"||$post['action']=="closeStatus")){
	
	$status='';
	if(isset($post['action']) && $post['action']=="readNewEmail"){
		$status=4;
	}
	if(isset($post['action']) && $post['action']=="closeStatus"){
		$status=2;
	}
	
	db_query(
			"UPDATE `{$data['DbPrefix']}support_tickets` SET ".
			"`status`={$status}".
			" WHERE `id`={$post['gid']}  "
	);
	
	
	$pra['newid']=$post['gid'];
	$pra['status']=$data['TicketStatus'][$status];
	$pra['update']="1";
	
}

if(isset($_GET['filter'])){
	$filterid=$_GET['filter'];
	$s_no=$filterid;
	$data['ticketsList'] = supports_f((isset($uid)?$uid:0),$filterid);
}

if(isset($_GET['no'])&&isset($_GET['stf'])){
	$s_no=$_GET['no'];
	$status_wise=$_GET['stf'];
	$data['ticketsList'] = supports_f(@$uid,@$s_no,$status_wise);
}




//echo $s_no;
if(isset($s_no) && $s_no==1){ //inbox
	unset($data['TicketStatus'][90]); unset($data['TicketStatus'][91]);
}
if(isset($s_no) && $s_no==3){ // sent
	unset($data['TicketStatus'][90]);
}

	include('message_count'.$data['iex']);
	
	if(isset($post['action']) && ($post['action']=="readNewEmail"||$post['action']=="closeStatus")){
		json_print($pra);
	} 
	
showpage('admins/template.message_ajax.do');exit;
	
?>

