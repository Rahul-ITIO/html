<? if(isset($data['ScriptLoaded'])){
?>
<style>
#sidebar .activmainmenu { margin: 0px 0px 0px 0px !important; }
</style>
<div class="text-center container border rounded my-1">
<img src="<?=$data['Host'];?>/images/welcome.png" class="img-fluid" />	
</div>
<?
 }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
