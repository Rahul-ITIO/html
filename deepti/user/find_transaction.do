<?
###############################################################################
$data['PageName']='ACCOUNT OVERVIEW';
$data['PageFile']='find_transaction';
###############################################################################
include('../config.do');
$data['PageTitle'] = 'My Transaction - '.$data['domain_name'];
###############################################################################
if(!isset($_SESSION['login'])){
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}
if(is_info_empty($uid)){
	header("Location:{$data['Host']}/user/profile.do");
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
$post=select_info($uid, $post);

if(!$post['step'])$post['step']=1;

if($post['send'])
   {
    $post['step']++;
                
   }
     
 if($post['step']==2)
 {
  $post['transBetween']=  get_transaction_between($uid,$post['date1'],$post['date2']);
  $post['transBetweenUnreg']=  get_transaction_between_unreg($uid,$post['date1'],$post['date2']);
  
  }   
  
  
 if($post['back'])
   {
    $post['step']--;
                
   } 
           
###############################################################################
//$post['DisputDate']= get_user_dispute();

###############################################################################
$post=select_info($uid, $post);
$post['Emails']=get_clients_email($uid, false, false);
$data['Balance']=select_balance($uid);

$post['Trans_detail']=get_transaction_detail_table($post['trans_id'],$uid);
if($post['confirm']){
           if($post['step']==4){
             $t_id=$post['t_id'] ;
             $dispute_name= $_SESSION['dispute_name'];
         
              insert_dispute($t_id,$uid,$dispute_name);
           }

    $post['step']++;

 }


$post['LastTransaction']=$post['Transactions'][0];
$post['PaysToUnregUSER_FOLDER']=get_unreg_clients_pay($uid);
###############################################################################
display('user');
###############################################################################
?>
