<?
if(!isset($_SESSION['adm_login'])){
        echo('ACCESS DENIED.');
        exit;
}

$inbox_count=db_rows(
	"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}support_tickets`".
	//" WHERE `clientid`={$uid} AND status NOT IN (90)".
	//" WHERE `status` IN (0)".
	  " WHERE `status` NOT IN (90)".
	" LIMIT 1",0
);
$inbox_count=@$inbox_count[0]['count'];

$inbox_process=db_rows(
	"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}support_tickets`".
	" WHERE `status` IN (1)".
	" LIMIT 1",0
);
$inbox_process=@$inbox_process[0]['count'];

$draft_count=db_rows(
	"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}support_tickets`".
	" WHERE `status` IN (92)".
	" LIMIT 1",0
);
$draft_count=@$draft_count[0]['count'];


$sent_count=db_rows(
	"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}support_tickets`".
	/*" WHERE `status` IN (90)".*/
	" WHERE `filterid` NOT IN (0) AND `status` NOT IN (90,92)".
	" LIMIT 1",0
);
$sent_count=@$sent_count[0]['count'];

$pra['inbox_count']=$inbox_count;//$inbox_process;
$pra['inbox_process']=$inbox_process;
$pra['draft_count']=$draft_count;
$pra['sent_count']=$sent_count;
$post=array_merge($post,$pra);

/*		
echo"
<script>
alert('$inbox_count');
top.window.document.getElementById('inbox_count').innerHTML='$inbox_count';
top.window.document.getElementById('draft_count').innerHTML='$draft_count';
</script>
";
*/
?>