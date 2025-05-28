<? if(isset($data['ScriptLoaded'])){ ?>
<? if(!$data['PostSent']){ 
$soon_title=ucwords(str_replace("-"," ",basename($_SERVER["PHP_SELF"])));
$soon_title=str_replace($data['ex'],"",$soon_title);
?>
<style>
g text *, g text {text-transform: lowercase; !important; }
.btn-danger {
    color: var(--color-1)!important;
    background-color: var(--color-4) !important;
    border-color: var(--color-4) !important;
}
.t-title{
font-size: 48px;
    font-weight: 800;
    background: -webkit-linear-gradient(45deg, #09009f, #00ff95 80%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
</style>
<div id="zink_id" class="container-sm mt-2 mb-2 rounded border bg-white vkg" style="min-height: 500px;">
  <h4 class="mt-2"><i class="<?=$data['fwicon']['coming-soon'];?>"></i> Coming Soon</h4>
  <div class="m-4 p-4 text-center t-title"><?=$soon_title;?></div>
</div>

<? } ?>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
