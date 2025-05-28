<? if(isset($data['ScriptLoaded'])){ ?>

<?
	if(isset($post['Profile']['fullname'])&&$post['Profile']['fullname'])
		$fullname = $post['Profile']['fullname'];
	else 
		$fullname = $post['Profile']['fname']." ".$post['Profile']['lname'];

?>
<div class="container border mt-2 mb-2 bg-white" >
  <h4 class="my-2"> Profile</h4>
  <table class="table table-striped">
    <tr>
      <td class="w-50">Username:</td>
      <td class="w-50"><?=prntext($post['Profile']['username'])?></td>
    </tr>
    <tr>
      <td>E-Mail Address:</td>
      <td><?=$post['useremails']?></td>
    </tr>
    <tr>
      <td>Name:</td>
      <td><?=prntext($fullname);?></td>
    </tr>
    <tr>
      <td>Company:</td>
      <td><?=prntext($post['Profile']['company_name'])?></td>
    </tr>
    <tr>
      <td>Description:</td>
      <td><?=prntext($post['Profile']['description'])?></td>
    </tr>
    <tr>
      <td  colspan="8" class="text-center"><? if(isset($post['StartPage'])){ ?>
        <a href="<?=$post['bp']?>.htm?page=<?=$post['StartPage']?>" class="btn btn-primary">Back</a>
        <? }?>
        <a href="<?=$data['USER_FOLDER']?>/index<?=$data['ex']?>" class="btn btn-primary">Account Overview</a></td>
    </tr>
  </table>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
