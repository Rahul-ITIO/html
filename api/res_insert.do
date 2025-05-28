<?
  if(isset($data['Path'])&&trim($data['Path'])) 
	$path_root=$data['Path'];
else $path_root='..';
  include($path_root.'/payin/res_insert.do');
?>
