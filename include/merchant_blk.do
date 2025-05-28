<?
$data['PageFile']='merchant_blk';
if(isset($_REQUEST['gid'])&&$_REQUEST['gid']>0){
	$data['G_MID']=$_REQUEST['gid'];
}

include('../config.do');

###############################################################################

if(!isset($_SESSION['login'])&&!isset($_SESSION['adm_login'])){
	header("Location:{$data['USER_FOLDER']}/login{$data['ex']}");
	echo('ACCESS DENIED.');
	exit;
}elseif((isset($_SESSION['sub_admin_id']))&&(!isset($_SESSION['edit_trans']))){
	//header("Location:{$data['USER_FOLDER']}/login{$data['ex']}"); echo('ACCESS DENIED.'); exit;
}

$is_admin=false;
if($_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
}

if(isset($is_admin)&&$is_admin&&isset($uid)&&$uid){
	$data['frontUiName']="";
}
if(isset($_REQUEST['tempui'])){
	$data['frontUiName']=$_REQUEST['tempui'];
}

$post['gid']=$_REQUEST['gid'];
$post['MemberInfo']['sponsor']=$_REQUEST['sponsor'];
$post['MemberInfo']['id']=$post['gid'];


$_GET['id']=$post['gid'];

$data['blacklist']	= get_blacklist_details($post['gid'], 'list_all');

$select_pt=db_rows(
	"SELECT * FROM {$data['DbPrefix']}acquirer_group_template".
	" ORDER BY id DESC ",0
);

db_disconnect();
		
$data['tmp2']=array();
foreach($select_pt as $key=>$value){
	$data['tmp2'][$value['id']]=$value['templates_name'];
}

$post['is_admin']=$is_admin;
$is_admin=$post['is_admin'];
?>

<table class="frame" width="100%" cellspacing="1" cellpadding="2" border="0">
	<tr><td id="black_lst" class=capl colspan=2>
		<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_blacklist_data'])&&$_SESSION['merchant_blacklist_data']==1)){/*?>
		<span style="float:right;display:inline-block"><a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?id=<?=$post['MemberInfo']['id']?>&action=insert_blkdata&type=<?=(isset($post['type'])?$post['type']:'')?>&page=<?=(isset($post['StartPage'])?$post['StartPage']:'')?>" style="color:#ffff00;" class="btn btn-icon btn-primary">Add New</a> </span>
		<? */}?>
		</td></tr>
	<tr><td colspan=2 style="overflow:hidden;">
		<? if(isset($data['blacklist'])&&$data['blacklist']){?>
		<table class="table table-bordered table-condensed" style="border:none !important;border-top-left-radius:15px !important;border-top-right-radius:15px !important;">
			<tr style="font-weight:bold;">
				<td style="text-align:center;background-color:#a4a4a4 !important;border-top-left-radius:10px !important;color:#fff;border-left: none !important;">S#</td>
				<td style="text-align:center;background-color:#a4a4a4 !important;color:#fff;">TYPE</td>
				<td style="text-align:center;background-color:#a4a4a4 !important;color:#fff;">BLACKLIST VALUE</td>
				<td style="text-align:center;background-color:#a4a4a4 !important;color:#fff;">REMARK</td>
				<td style="text-align:center;background-color:#a4a4a4 !important;border-top-right-radius:10px !important;color:#fff;">ACTION</td></tr>
			<? 
			$idx=0;$k=0;
			foreach($data['blacklist'] as $value){
				$k++;
				$bgcolor=$idx%2?'#EEEEEE':'#FFFFFF';
			?>
			<tr style="background:<?=$bgcolor?>;">
				<td style="border-bottom:1px solid #c0b9b9; border-left:1px solid #c0b9b9;"><b><?=$k;?></b></td>
				<td style="border-bottom:1px solid #c0b9b9; border-left:1px solid #c0b9b9;"><b><?=($value['blacklist_type']);?></b></td>
				<td style="border-bottom:1px solid #c0b9b9;" nowrap title="<?=($value['blacklist_value'])?>"><span class="dotdot"><?=($value['blacklist_value'])?></span></td>
				<td style="border-bottom:1px solid #c0b9b9;" nowrap><span class="dotdot"><?=($value['remarks']);?></span></td>
				<td style="border-bottom:1px solid #c0b9b9;border-right:1px solid #c0b9b9;text-align:center;vertical-align:middle;" nowrap>
				<? if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_blacklist_data'])&&$_SESSION['merchant_blacklist_data']==1)){
				
				if($value['status']==1)
				{
				?>
				&nbsp;<a href="<?=$data['Admins'];?>/merchant<?=$data['ex']?>?bid=<?=$value['id'];?>&id=<?=$post['MemberInfo']['id']?>&action=delete_blkdatas&type=<?=(isset($post['type'])?$post['type']:'');?>&page=<?=(isset($post['StartPage'])?$post['StartPage']:'')?>" onclick="return cfmform()"class="fas fa-trash-alt text-danger" title="Delete"><i></i></a>&nbsp;
				<?
				}
				else echo '<i class="fas fa-check"></i>'; }?></td></tr>
				<? 
				$idx++;
				}
				if((isset($_SESSION['login_adm']))||(isset($_SESSION['merchant_blacklist_data'])&&$_SESSION['merchant_blacklist_data']==1)){
				?>

				<tr id="add_new_link"><td class="capc" colspan="5">
					<a href="JavaScript:void(0)" onclick="JavaScript:showform()" class="btn btn-icon btn-primary glyphicons circle_plus" style="margin:0 0 -6px;"><i></i>Add New</a></td></tr>
				
				<tr id="add_newblk" style="display:none;background:<?=$bgcolor?>;"><td colspan="5"><form method="post" action="<?=$data['Admins'].'/merchant'.$data['ex'].'?id='.$post['gid'].'&action=insert_blkdata&tab_name=collapsible11#collapsible11';?>"><div class="tab-pane active" id="account-settings">
					<div class="widget widget-2">
						<div class="widget-body" style="padding-bottom: 0;">
							<div class="row-fluid">
								<div class="span12">
									<div class="span3">
									<label for="blacklist_type"><strong>Type:</strong></label>
									<select name="blacklist_type" style="width:100%" required>
										<option value="">Select Type</option>
										<option value="IP">IP</option>
										<option value="Country">Country</option>
										<option value="City">City</option>
										<option value="Email">Email</option>
										<option value="Card Number">Card Number</option>
										<option value="VPA">VPA</option>
										<option value="Mobile">Mobile</option>
									</select>
									</div>
									<div class="span3">
									<label for="value"><strong>Blacklist Value:</strong></label>
									<input type="text" name="blacklist_value" class="span10" value='' style="display:block;margin:10px auto;width:300px;" required />
									</div>
									<div class="span3">
									<label for="remark"><strong>Remark:</strong></label>
									<textarea name="remarks" class="span10" style="display:block;margin:10px auto;width:300px;"/></textarea>
									</div>
									<div class="form-actions" style="margin:0;padding-right:0;text-align:center;">
										<button type="submit" name="addnow" value="Add" class="btn btn-icon btn-primary glyphicons circle_ok" style="display:inline-block;margin:10px 0 0 -20px;float:none;width:300px;"><i></i>Add</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div></form>
			</td></tr>
			<? }?>
		</table>
		<? }?>
	</td></tr>
</table>
<script>
function showform()
{
	$("#add_new_link").hide(900);
	$("#add_newblk").show(900);
}
</script>
<?
exit;
?>