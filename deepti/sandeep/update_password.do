<?
//for update password of subadmin will use this file
include('config.do');

//this function will be used for for hasing password based on algorthym  algorithm like(sha256)and returns value is a string with hexits (hexadecimal values).
function update_hash_password_admin(){
	global $data;
	$post['password']=hash('sha256', $_POST['password']);
	
	$qry="SELECT `id`,`password` FROM `{$data['DbPrefix']}subadmin`";
	
	$cont_trans=db_rows($qry);
	
	foreach ($cont_trans as $key=>$value){
		$password=hash('sha256', $value['password']);
		$id=$value['id'];
		
		echo $id.":&nbsp;&nbsp;->".$value['password']."&nbsp;->".$password."---- Finished<br>";
		echo "<br>UPDATE `{$data['DbPrefix']}subadmin` SET  `password`='{$password}' WHERE `id`={$id}<br><br>-------------<br>";
		db_query("UPDATE `{$data['DbPrefix']}subadmin` SET  `password`='{$password}' WHERE `id`={$id}");
		}
	echo "Updated 'subadmin' Table - Finished..!";
	
}//end function

//update and hashing password from client_id table
function update_hash_password_user(){
	global $data;
	$post['password']=hash('sha256', $_POST['password']);
	
	$qry="SELECT `id`,`password` FROM `{$data['DbPrefix']}clientid_table` order by `id`";
	
	$cont_trans=db_rows($qry);
	
	foreach ($cont_trans as $key=>$value){
		$password=hash('sha256', $value['password']);
		$id=$value['id'];
		
		echo $id.":&nbsp;&nbsp;-> ".$value['password']."&nbsp;-> ".$password." ---- Finished<br>";
		echo "<br>UPDATE `{$data['DbPrefix']}clientid_table` SET  `password`='{$password}' WHERE `id`={$id}<br><br>-------------<br>";
		db_query("UPDATE `{$data['DbPrefix']}clientid_table` SET  `password`='{$password}' WHERE `id`={$id}");
		}
	echo "Updated 'merchant' Table - Finished..!";
	
}//end function

//update_hash_password_admin();	
echo "<br>#######################################################################<br>";
update_hash_password_user();

?>