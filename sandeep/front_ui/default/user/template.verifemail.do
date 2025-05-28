<?if(isset($data['ScriptLoaded'])){?>



<? if (isset($data['error'])) { ?>
<center><font color=red><?=$data['error']?></font></center>

<? } elseif (isset($_GET['c'])) { ?>

<center>You have successfully activated your newly added e-mail address.</center>

<? } ?>

<?}else{?>SECURITY ALERT: Access Denied<?}?>
