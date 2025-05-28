<?


if(!isset($_SESSION['login'])){
	//$_SESSION['redirectUrl']=$data['urlpath'];
	echo('ACCESS DENIED.'); exit;
}

$inbox_count=db_rows(
	"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}support_tickets`".
	" WHERE `clientid`={$uid} AND status NOT IN (90)".
	//" WHERE `clientid`={$uid} AND `filterid` NOT IN (0) AND `status` NOT IN (90)".
	" LIMIT 1",0
);
 $inbox_count=$inbox_count[0]['count'];

$draft_count=db_rows(
	"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}support_tickets`".
	" WHERE `clientid`={$uid} AND `status` IN (90)".
	" LIMIT 1",0
);
$draft_count=$draft_count[0]['count'];


$sent_count=db_rows(
	"SELECT COUNT(`id`) AS `count` FROM `{$data['DbPrefix']}support_tickets`".
	/*" WHERE `status` IN (90)".*/
	" WHERE `clientid`={$uid} AND `status` NOT IN (90,92)".
	" LIMIT 1",0
);
$sent_count=$sent_count[0]['count'];

$pra['inbox_count']=$inbox_count;
$pra['draft_count']=$draft_count;
$pra['sent_count']=$sent_count;


$data['inbox_count']=$inbox_count;
$data['draft_count']=$draft_count;
$data['sent_count']=$sent_count;



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