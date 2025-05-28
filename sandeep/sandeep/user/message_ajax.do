<?

$data['PageName']	= 'MESSAGE CENTER';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'Message Center - '.$data['domain_name']; 
###############################################################################
if(!isset($_SESSION['login'])||!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if(isset($post['action'])&&$post['action']=="editdraft"){
	
	$photograph_view='';
	
	$edit_drf=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}support_tickets`".
			" WHERE `clientid`={$uid}  AND `id`={$post['gid']}"
	);
	
	//$comments_ex=explode1("",$edit_drf[0]['comments']);
	
	$pra['post_id']=$edit_drf[0]['id'];
	$pra['message_type']=$edit_drf[0]['message_type'];
	$pra['subject']=$edit_drf[0]['subject'];
	$pra['comments']=$edit_drf[0]['comments'];
	$pra['ticketid']=$edit_drf[0]['ticketid'];
	
	$join_photograph_file=$edit_drf[0]['more_photograph_upload'];
	
	if($join_photograph_file){
			$photo=explode1('_;',$join_photograph_file);
			foreach($photo as $value_po){
				if($value_po){
					$photograph_view.="<div style=display:block;><div class='abcd'><span onclick=uploadfile_viewf(this)><img src=".encode_imgf($data['Path']."/user_doc/".$value_po)." class='img-thumbnail'></span><img onClick=ajax_remove_files(this) id=img src={$data['Host']}/images/x.png alt=delete data-file=".($value_po)." class='img-thumbnail'></div></div>";
				}
			}
		}
		
		
		if(isset($photograph_view)&&$photograph_view){
			$photograph_view="<div class=row style=margin:0;margin-top:25px><div id=formdiv style=float:left>".$photograph_view."</div></div>";
		}
		
	$pra['photograph_view']=$photograph_view;
	
	json_print($pra);	

	exit;
}


unset($data['TicketStatus'][5]);unset($data['TicketStatus'][92]);

function supports_f($uid,$filterid=0,$status=''){
	global $data;
	$qr_s=" WHERE `clientid`={$uid} "; $order=' ';
	
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
		$qr_s.=" AND `status`=90 ";
	}
	
	if($filterid==3){ //sent
		if($data['connection_type']=='PSQL')
			$order=' ARRAY_POSITION(ARRAY[2,4,1,91,0], "status") ,  ';
		else
			$order=" FIELD(`status`, 2,4,1,91,0) DESC, ";
		
		$qr_s.=" AND `filterid`=0 AND `status` NOT IN (90,92) ";
	}
	
	if($filterid==1){ // inbox
		//$order=" `status` ASC|DESC ";
		//$order=" FIELD(`status`, '91','0','2','4') ,";
		
		if($data['connection_type']=='PSQL')
			$order=' ARRAY_POSITION(ARRAY[2,4,0,1,91], "status") ,  ';
		else
			$order=" FIELD(`status`, 2,4,0,1,91) DESC, ";
		

		$qr_s.=" AND `status` NOT IN (90,92) ";
	}
	$order=rtrim($order,', ');
	
	$result_count=db_rows(
		"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}support_tickets`".
		$qr_s.
		" LIMIT 1",0 //`date` DESC
	);
	$data['result_total_count']=($result_count[0]['count']);
	
	$result=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}support_tickets`".
		$qr_s.
		($order?" ORDER BY {$order}, ":" ORDER BY ").
		" `date` DESC  {$limit}",0 //`date` DESC	ASC 
	);
	
	
		
	return $result;
}

if(isset($post['action'])&&$post['action']=="removedraft"){
	db_query(
		"DELETE FROM `{$data['DbPrefix']}support_tickets`".
		" WHERE (`clientid`={$uid}) AND (`id`={$post['gid']})"
	);
	$_GET['filter']=4;
}elseif(isset($post['action'])&&($post['action']=="readNewEmail"||$post['action']=="closeStatus")){
	
	$status='';
	if($post['action']=="readNewEmail"){
		$status=4;
	}
	if($post['action']=="closeStatus"){
		$status=2;
	}
	
	db_query(
			"UPDATE `{$data['DbPrefix']}support_tickets` SET ".
			"`status`={$status}".
			" WHERE `id`={$post['gid']} AND `clientid`={$uid} "
	);
	
	$pra['newid']=$post['gid'];
	$pra['status']=$data['TicketStatus'][$status];
	$pra['update']="1";
	
}

if(isset($_GET['filter'])){
	$filterid=$_GET['filter'];
	$s_no=$filterid;
	$data['ticketsList'] = supports_f($uid,$filterid);
}

if(isset($_GET['no'])&&isset($_GET['stf'])){
	$s_no=$_GET['no'];
	$status_wise=$_GET['stf'];
	$data['ticketsList'] = supports_f($uid,$s_no,$status_wise);
}




//echo $s_no;
if($s_no==1){
	unset($data['TicketStatus'][90]);
}
if($s_no==3){
	unset($data['TicketStatus'][90]);unset($data['TicketStatus'][91]);
}

	include('message_count'.$data['iex']);
	
	if(isset($post['action'])&&($post['action']=="readNewEmail"||$post['action']=="closeStatus")){
		json_print($pra);
	}

showpage("user/template.message_ajax".$data['iex']);exit;
?>

