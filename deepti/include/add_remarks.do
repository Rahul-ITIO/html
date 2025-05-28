<?
include('../config.do');

if($_REQUEST["gdata"]){
$gdata=$_REQUEST["gdata"];
$gid=$_REQUEST["gid"];
$mtype=$_REQUEST["mtype"];
//isset($mtype)&&$mtype?$mtype:'system';


	
	$remark_slct=db_rows(
			"SELECT `support_note`,`acquirer`,`system_note` FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` WHERE `id`={$gid}",
	);
	
	$remark_get = $remark_slct[0]['support_note']; 
	$type_get 	= $remark_slct[0]['acquirer']; 
	$system_note_get = $remark_slct[0]['system_note'];
	
	
	$rmk_date=date('d-m-Y h:i:s A');
	
	$byusername=" - Admin";
	if(isset($_SESSION['sub_admin_id'])){
		$byusername=" - ".$_SESSION['username'];
	}
	
	$remark_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$gdata.$byusername."</div></div>".$remark_get;
	$system_upd = "<div class=rmk_row><div class=rmk_date>".$rmk_date."</div><div class=rmk_msg>".$gdata.$byusername."</div></div>".$system_note_get;
		
	$db_upd1=" `support_note`='{$remark_upd}',`remark_status`=2 ";
	if($mtype=="system"){
		$db_upd1=" `system_note`='{$system_upd}', `remark_status`=2  ";
	}
	
	if($gdata){
		db_query(
			"UPDATE `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}`".
			" SET ".$db_upd1.
			" WHERE `id`='{$gid}'",0
		);
	}

echo "done";

//echo $remark_upd;


}
?>