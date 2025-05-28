<?if(isset($data['ScriptLoaded'])){?>

<form>
<table class=frame width=100% border=0 cellspacing=1 cellpadding=2><tr><td class=capl colspan=7>
LIST OF BLOCK MERCHANT</td></tr>
<tr><td class=capc colspan=3>IP ADDRESS</td><td class=capc colspan=2>ACTION</td></tr>
<?foreach($post['ipdata'] as $key=>$val){?>

<tr bgcolor=<?=$bgcolor?> 
onmouseover="setPointer(this,<?=$key?>,'over','<?=$bgcolor?>','#CCFFCC','#FFCC99')" onmouseout="setPointer(this,<?=$key?>,'out','<?=$bgcolor?>','#CCFFCC','#FFCC99')" onmousedown="setPointer(this,<?=$key?>,'click','<?=$bgcolor?>','#CCFFCC','#FFCC99')">


<td align=center valign=top colspan=3><?= $val['last_ip']?>

<td align=center valign=top nowrap colspan=2>
<a href="block_ip.do?id=<?= $val['id']?>">BLOCK</a></td></tr><?}?></table>
<?}elseif($post['action']=='select'){?>

<?if($data['Pages']){?>
<table class=frame width=100% border=0 cellspacing=1 cellpadding=4><tr><td class=capc>
<?$count=count($data['Pages']);for($i=0; $i<$count; $i++){?>
<?if($data['Pages'][$i]==$post['StartPage']){?>
<?=$i+1?>
<?}else{?>
<a href="block_ip.do">
</a><?}?><?if($i<$count-1)echo("|");}?></td></tr></table><br>
<?}?>


<?}else{?>SECURITY ALERT: Access Denied<?}?>



