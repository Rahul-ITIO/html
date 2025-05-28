<?
$data['PageName']	= 'REQUEST FUNDS TRANSACTIONS';
include('../config.do');

$data['PageTitle'] = 'Request Funds Transactions - '.$data['domain_name'];
$data['invoice_condation']=0;
if(isset($data['PageFileCon'])&&$data['PageFileCon']){
	$data['PageFile']	= $data['PageFileCon'];
	$data['invoice_condation']=1;
	$data['PageName']	= 'INVOICE';
	$data['PageTitle']	= 'Invoice - '.$data['domain_name'];
}else{
	$data['PageFile']	= 'request_fund';
}
###############################################################################
//include('../config.do');
##########################Check Permission#####################################

if(!isset($_SESSION['m_clients_role'])) $_SESSION['m_clients_role'] = '';
if(!isset($_SESSION['m_clients_type'])) $_SESSION['m_clients_type'] = '';

if(!clients_page_permission('11',$_SESSION['m_clients_role'],$_SESSION['m_clients_type'])){ header("Location:{$data['Host']}/index".$data['ex']);exit; }
###############################################################################
if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

###############################################################################
if(is_info_empty($uid)){
	header("Location:{$data['Host']}/clients/profile".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

if($data['invoice_condation']){ $where_pred=""; }
else {
	$where_pred=" AND (`notification_to` LIKE '%007%') ";
}
	
$where_pred=" AND (`active` IN (1) ) ";
$data['Store']=select_terminals($uid,0, false, 0,$where_pred);

$data['store_size']=(count($data['Store']));

//echo $data['store_size'];
//$post['json_value']=[];	

$post=select_info($uid, $post);


$post['default_currency_sym']=get_currency($post['default_currency']);
$post['background_gd4']=$_SESSION['background_gd4'];
$post['root_text_color']=$_SESSION['root_text_color'];	

if(!isset($post['step']) || !$post['step']) $post['step']=1;

/*
echo "<hr/>dmn=>".$post['dmn'];
echo "<hr/>fax=>".$post['fax'];
echo "<hr/>service_email=>".$post['service_email'];
echo "<hr/>contact_us_url=>".$post['contact_us_url'];
*/

$post['AccountInfo']=mer_settings($uid);		//fetch data from acquirer

//Initialized variables with null or empty value
$primary_cursymbol="";$primary_currency="";
$primary_min_limit="";$primary_max_limit="";

foreach($post['AccountInfo'] as $key=>$value){
	
		if(isset($value['processing_currency']) && $value['processing_currency']){
			$curr_ex=explode(' ',$value['processing_currency']);
			$primary_cursymbol=$curr_ex[0];
			$primary_currency=$curr_ex[1];
		}
		$primary_min_limit=$value['min_limit'];		//minimum transaction amount limit
		$primary_max_limit=$value['max_limit'];		//maximum transaction amount allowed
	
}
$post['primary_cursymbol']=$primary_cursymbol;	//primary currency symbol
$post['primary_currency']=$primary_currency;	//primary currency name

		
###############################################################################

//print_r($post); print_r($uid); echo "=h1=";

###############################################################################
//if($post['send']||$post['action']=='addrequests'){

//print_r($_POST);

if(isset($_GET['send'])&&$_GET['send'])
	$post['send']=$_GET['send'];	// if send pass in URL then transfer to $post for further use - 

if((isset($post['send']) && $post['send'])||(isset($post['action']) && $post['action']=='addrequests')){

//print_r($_SESSION['invoice_data']);
//echo 'aaaaaa'.$post['send'];

	if($post['send']=='CONTINUE')
	{
		$post['step']=2;
		unset($_SESSION['invoice_data']);
		$insert=1;
	}
	elseif($post['send']=='Submit')
	{
		$post['step']=2;
		$insert=1;		//set insert 1, means insert into Database
	}
	else {$insert=0;}	
	
	if(isset($_SESSION['invoice_data'])&&$_SESSION['invoice_data']){
		unset($_SESSION['invoice_data']['step']);
		$post = array_merge($post,$_SESSION['invoice_data']); // Store invoice detail in $post for final submission
		$post['json_value_new']=$post['json_value']; //set json value created at step 2, insert into post_value_new
	}
	//set insert 0, means not insert into Database, display a preview before insert

	$parameters=array();
	if(isset($_POST['json_value'])){
		$post['json_value']=$_POST['json_value'];	//json value
	}

	if(!isset($post['gid']) || !$post['gid']){
		if(!isset($_POST['json_value'])){
			$post['json_value']=[];
		}
		$post['add_titileName']='Add A New ';
		
		//fetch data from requestmoney table
		$last_requestmoney=db_rows(
			"SELECT * FROM `{$data['DbPrefix']}request_trans_table`".
			" WHERE `clientid`={$uid} ORDER BY id DESC LIMIT 1"
		);

	
		$json_value_get=@$last_requestmoney[0]['json_value'];	//json value
		$json_value_get=jsondecode($json_value_get);			//json to array
		$post['json_value']['email_subject']=@$json_value_get['email_subject'];	//fetch subject from json
		
		//print_r($post['json_value']['email_subject']);
		//print_r($json_value_get);
		
	}
	if(isset($post['step']) && $post['step']==1){	//if step 1 then increase
		$post['step']++;
	}elseif(isset($post['step']) && $post['step']==2){	//if step 2 then execute following section
		if(isset($data['store_size']) && $data['store_size']==1){
			$parameters['bid']=$data['Store'][0]['public_key'];
			$sl_num=0;
		}else{
			$type=explode('_;',$post['type']);	//explode type string into two parts
			
			$sl_num=$type[1];	//table id

			$parameters['bid']=$type[0];	//api token 
			
		}
		
		$post['json_value']['public_key']=$parameters['bid'];	//store public_key in 
		
		//fetch data from website store (products table)
		$terminal_info= select_tablef(" `public_key`='{$parameters['bid']}' ",'terminal',0,1,'`ter_name`,`bussiness_url`,`dba_brand_name`');	//terminal_info list
		
		//check dba name exists or not, if yes then use brand name otherwise use storename
		if(isset($terminal_info['ter_name'])&&$terminal_info['ter_name'])
			$post['dba']=$terminal_info['ter_name'];
		elseif(isset($terminal_info['bussiness_url'])&&$terminal_info['bussiness_url'])
			$post['dba']=$terminal_info['bussiness_url'];
		elseif(isset($terminal_info['dba_brand_name'])&&$terminal_info['dba_brand_name'])
			$post['dba']=$terminal_info['dba_brand_name'];
		
		if(@$post['json_value']['product_amount'])
		{
			$post['amount']=@$post['json_value']['product_amount'];	//request amount
		}
		
		//check required validation 
		if(!isset($post['fullname']) || !$post['fullname']){
			$data['Error']='Please enter receiver full name.';
		}elseif(!isset($post['receiver_email']) || !$post['receiver_email']){
			$data['Error']='Please enter valid e-mail address.';
		}elseif(isset($data['store_size']) && $data['store_size']<1){
			$data['Error']='Request Funds missing in Acquirer. Please contact to support.';
		}elseif(isset($data['store_size']) && $data['store_size']<1&&!$post['type']){
			$data['Error']='Please select to Store Type';
		}elseif(!isset($post['amount']) || !$post['amount'] ){
			$data['Error']='Please enter valid amount for transffering.';
		}/*elseif($post['amount']<$data['Store'][$sl_num]['min_limit']){
			$data['Error']="Amount can not be less than of ".$primary_cursymbol." ".$primary_min_limit." ".$primary_currency;
		}elseif($post['amount']>$data['Store'][$sl_num]['max_limit']){
			$data['Error']="You cannot request more than of ".$primary_cursymbol." ".$primary_max_limit." ".$primary_currency.
				" per transaction";
		}*/elseif(get_clients_status($uid)<0){
			$data['Error']="because you are UNVERIFIED merchant.";
		}else{
			//$post['fullname']=$post['rname']." ".$post['rlname'];
			
			if(@$post['json_value']['tax_type']==1){
				$post['amount']=@$post['amount'] + @$post['json_value']['tax_amount'];
			}elseif(@$post['json_value']['tax_type']==2){
				$post['amount']=@$post['amount']+(@$post['amount']*(@$post['json_value']['tax_amount']/100));
			}else{
				unset($post['json_value']['tax_amount']);
				//exit;
			}

			$post['fax']=$data['Store'][$sl_num]['customer_service_no'];
			$post['service_email']=encrypts_decrypts_emails($data['Store'][$sl_num]['customer_service_email'],2);

				$parameters['action ']="requestmoney";		//set action is request moneny
				$parameters['clients']=$uid;					//clients id
				
				$parameters['amount']=$post['amount'];		//request amount
				
				$parameters['fullname']=@$post['fullname'];	//fullname
				//$parameters['fname']=$post['rname'];
				//$parameters['lname']='';
				$parameters['receiver_email']=@$post['receiver_email'];		//request email
				$parameters['curr']=@$post['currency'];		//currency
				$parameters['cdate']=date('YmdHis');		//current date and time
				$parameterstr=implode(';',$parameters);		//create string from array
				
				$encryptres = encryptres($parameterstr);	//encrypt string
				$post['transactioncode']=$encryptres;
				$transaction_code=$encryptres; 

				//create editable linkk
				$editableUrl="/".($post['json_value']['public_key']?$post['json_value']['public_key']:$post['username'])."/{$post['amount']}/{$post['receiver_email']}/{$post['json_value']['bill_phone']}/{$post['fullname']}".(($data['clkStore']==0)?"/{$post['json_value']['bill_country']}/{$post['json_value']['bill_state']}/{$post['json_value']['bill_city']}/{$post['json_value']['bill_address']}/{$post['json_value']['bill_zip']}/":"");
				$post['json_value']['editableUrl']=$editableUrl;
				
				$noneEditableUrl="/".$transaction_code."/";
				$post['json_value']['noneEditableUrl']=$noneEditableUrl;	//none editable link
				
				
				if(isset($post['json_value_new'])&&$post['json_value_new'])
					$post['json_value']= $post['json_value_new'];

				$json_value=jsonencode($post['json_value']);
				
				//print_r($post['json_value']); 
				//print_r($_POST['json_value']); 
				//exit;
				
				if(isset($post['json_value']['encryption_types']) && $post['json_value']['encryption_types']==2){
					$email_payUrl=$editableUrl;
				}else{
					$email_payUrl=$noneEditableUrl;
				}
				
				//create query for invoice
				if($data['invoice_condation']==1){ 
				   $prewhere_inst1=" ,`category`, `product_name`, `currency`, `invoice_no` ";
				   $prewhere_inst2=" ,'1','{$post['product_name']}','{$post['currency']}','{$post['invoice_no']}'";
				   $prewhere_updt=" ,`category`='1' ,`product_name`='{$post['product_name']}' ,`currency`='{$post['currency']}' ,`invoice_no`='{$post['invoice_no']}' ";
				   
				}else{
					$prewhere_inst1='';
					$prewhere_inst2='';
					$prewhere_updt='';
				}

				//===============Tax Add in Amount================
				
					
					
				if(!isset($post['gid']) || !$post['gid']){
					//$post['transactioncode'] = (substr(number_format(time() * rand(111,999),0,'',''),0,12));
					
					if($insert)	//insert the data into DATABASE if $insert=1
					{
						$sqlStmt = "INSERT INTO `{$data['DbPrefix']}request_trans_table`(".
						"`clientid`,".
						"`fullname`,`receiver_email`,`amount`,`comments`,`transactioncode`,`json_value`".$prewhere_inst1.
						")VALUES(".
						"'{$uid}',".
						"'{$post['fullname']}','{$post['receiver_email']}','{$post['amount']}','{$post['comments']}','{$transaction_code}','{$json_value}'".$prewhere_inst2.
						")";
					//	exit;
						db_query($sqlStmt,"0");
						
						$related_id=newid();
						$pst['tableid']=$related_id;
						unset($_SESSION['invoice_data']);	//clear all session value of Inovice Data
					}
					else
					{
						$_SESSION['invoice_data']=$post;	//Store all invoice form data in session for preview and other steps, and redirect with action = preview for display a preview before final submission
						header("location:{$data['USER_FOLDER']}/{$data['PageFile']}".$data['ex']."?action=preview");exit;
					}
				}
				else { 
					$pst['tableid']=$post['gid'];

					//qiery for update data
					db_query(
						"UPDATE `{$data['DbPrefix']}request_trans_table` SET ".
						"`fullname`='{$post['fullname']}',`receiver_email`='{$post['receiver_email']}',`amount`='{$post['amount']}',`transactioncode`='{$transaction_code}',`comments`='{$post['comments']}',`json_value`='{$json_value}'".$prewhere_updt. " WHERE `id`={$post['gid']}"
				);
			}
			
			$data['sucess']	="true";
			$post['step']--;
			
			
		
			
			//I think no any requirement this query -  (3-feb-23)
			$products_id=db_rows(
				"SELECT `id`,`terminal_type` FROM `{$data['DbPrefix']}terminal` WHERE `merID`={$uid} LIMIT 1"
			);
			$post['productstype'] 	= $products_id[0]['terminal_type'];
			$post['productsid'] 	= $products_id[0]['id'];
			
			
			
			//make email subject
			$subject_msg=$post['json_value']['email_subject'].". ".$post['comments'];

			//fetch default currency of a clients
			$default_currency =  get_currency($_SESSION['domain_server']['clients']['default_currency']);
			$post['currency_amount'] = $default_currency." ".$post['amount'];	//amount with currency

			$amounts=$primary_cursymbol." ".$post['amount']." ".$primary_currency;

			$post['amountacct']=$amounts;
			
			$post['customer_service_email'] = encrypts_decrypts_emails($_SESSION['domain_server']['subadmin']['customer_service_email'],2);	//decrypted service email
			$post['merchant_service_no']	= $_SESSION['domain_server']['subadmin']['customer_service_no'];	//merchant service phone number
			
			$post['fullname']		=$post['fullname'];		//fullname
			$post['email']			=$post['receiver_email'];		//email id
			$post['emailadr']		=isset($post['service_email'])&&$post['service_email']?$post['service_email']:$post['customer_service_email'];	//service email
			$post['emailfrom']		=isset($post['service_email'])&&$post['service_email']?$post['service_email']:$post['customer_service_email'];	//from email
			$post['current_date']	=date("l jS F, Y");	//current date
			//$post['emailadr']=get_clients_email($uid);
			$post['emailheader']="self";
			$post['clientid']= $uid;

			$post['payUrl']=$email_payUrl;			//payurl
			$post['payrequest']=$subject_msg;		//pay subject

			send_email('REQUEST-MONEY', $post);		//send email for request money
				//send_email('11REQUEST-MONEY', $post);
			//	exit;
				
			
			if(isset($_GET['test'])){
				echo "<hr/>transaction_code=>".$transaction_code;
				echo "<hr/>receiver_email=>".$receiver_email.
				"<hr/>service_email=>".$service_email.
				"<hr/>headers=>".stripslashes($headers);
				echo "<hr/>subject_msg=>".stripslashes($subject_msg).
				"<hr/>email_msg=>".stripslashes($email_msg);
				exit;
			}
			
			if($data['invoice_condation']==0){ 
				$data['PostSent']=true;
				$_SESSION['action_success']='<strong>Success!</strong> Your request Funds with the Invoice URL was sent to '.$post['fullname'].' '.$post['receiver_email'].'<br>You will be notified via e-mail once the payment is completed.';
				header("location:{$data['USER_FOLDER']}/{$data['PageFile']}".$data['ex']);exit;
			}else{
				if($post['action']=="update"){
					$_SESSION['action_success']='<strong>Success!</strong> Your Invoice Updated successfully';
					header("location:{$data['USER_FOLDER']}/{$data['PageFile']}".$data['ex']);exit;
				}else{
				
					$_SESSION['action_success']='<strong>Success!</strong> Your Invoice Created successfully';
					header("location:{$data['USER_FOLDER']}/{$data['PageFile']}".$data['ex']."?invid=".$related_id."&action=display");exit;

					//include_once $data['Path']."/front_ui/default/user/template.invoice_preview".$data['iex'];
					//exit;
				}
			}
		}
	}
}
//elseif($post['cancel'])$post['step']--;

//print_r($post['action']);

//update section for request money
if(isset($post['action']) && ($post['action']=='update' || $post['action']=='display')){
	
	$id = @$post['gid'];
	if($post['action']=='display'){ $id =$_GET['invid']; }
	
	$post['add_titileName']='Update ';
	
	//fetch data from request money
	$requestmoney=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}request_trans_table`".
		" WHERE `clientid`={$uid}  AND `id`='{$id}' LIMIT 1",0
	);
	//	print_r($requestmoney);
	$results=array();
	foreach($requestmoney as $key=>$value){
		foreach($value as $name=>$v)$results[$key][$name]=$v;
	}
	
	//assign all data in $post array
	if($results)foreach($results[0] as $key=>$value)if(!isset($post[$key]) || !$post[$key]) $post[$key]=$value;
	
	$post['json_value']=jsondecode($results[0]['json_value']);
	
	$post['fullname']=$results[0]['fullname'];
	
	if((isset($post['json_value']['public_key'])&&$post['json_value']['public_key'])&&(!isset($post['type']) || !$post['type'])){$post['type']=$post['json_value']['public_key'];}
	
	//print_r($post['json_value']);
	if($post['action']!='display'){	
		$post['actn']='update';
		$post['step']++;
	}	
}elseif(isset($post['action']) && $post['action']=='delete'){
	$gid = $post['gid'];
	db_query(
		"DELETE FROM `{$data['DbPrefix']}request_trans_table`".
		" WHERE `id`={$gid}"
	);
}


if(isset($post['step']) && $post['step']==1){

	if(isset($_REQUEST['key_name']) && isset($_REQUEST['key_type'])){
		$enq=" `".$_REQUEST['key_type']."` = '".$_REQUEST['key_name']."'";
	}

	$result_select=db_rows(
		"SELECT * FROM `{$data['DbPrefix']}request_trans_table`".
		" WHERE `clientid`='{$uid}'".
		(isset($enq)?" AND {$enq}":'').
		(isset($primary)?" AND `primary`='{$primary}'":'').
		(isset($confirmed)?" AND `active`='{$confirmed}'":'').
		(($data['invoice_condation']==1)?" AND `category` IN (1)":"  AND  `category` IN (0)").
		" ORDER BY `id` DESC",0
	);
	
	$data['selectdatas'] = $post['selectdatas'] = $result_select;
}


//Dev Tech : 23-08-05 generate for invoice payment link  SEND-INVOICE-PAYMENT-LINK via dynamic
if(isset($_POST['invoice'])&&$_POST['invoice']=="inv"){

	$arr = json_decode($_POST['inv_data'], true);

	/*$arr["inv_m_company"];
	$arr["inv_m_name"];
	$arr["inv_m_address"];
	$arr["inv_m_address2"];
	$arr["inv_email"];
	$arr["inv_b_name"];
	$arr["inv_b_address"];
	$arr["inv_b_address2"];
	$arr["inv_created_date"];
	$arr["inv_invoice_no"];
	$arr["inv_product_name"];
	$arr["inv_amount"];
	$arr["inv_totalamt"];
	$arr["inv_currency"];
	$arr["inv_taxtitle"];
	$arr["inv_taxamt"];
	$arr["inv_transactioncode"];
	$arr["inv_term_condation"];
	$arr["inv_notes"];*/

	$payurl=$data['Host']."/payme".$data['ex']."/".$post['transactioncode']."/";
	$post['ctable3']="";
	$post['ctable4']="";
	$post['ctable5']="";
	$notes="";


	if($arr["inv_term_condation"]){
	$post['ctable4']='<div  style="padding-left: 5px;font-weight: bold;margin-bottom: 5px"><strong>Terms &amp; Condations :</strong></div>
					<div style="padding-left: 5px;margin-bottom: 5px;margin-top: 5px">'.$arr["inv_term_condation"].'</div>';
	}

	if($arr["inv_notes"]){
	$notes=$post['ctable5']='<div  style="padding-left: 5px;font-weight: bold;margin-bottom: 5px;margin-top: 5px"><strong">Notes :</strong></div>
			<div style="padding-left: 5px;margin-bottom: 5px;margin-top: 5px">'.$arr["inv_notes"].'</div>';
	}

	if($arr["inv_taxamt"]){
		$post['ctable3']=' <tr  style=" border-color: #dee2e6; border-style: solid; border-width: 0px;">
			<td  style=" border-color: #dee2e6; border-style: solid; border-width: 0px 0px 1px; padding: 0.5rem;"><strong style=" font-weight: bolder;">Tax '.$arr["inv_taxtitle"].' :  </strong></td> <td  style=" border-color: inherit; border-style: solid; border-width: 0px 0px 1px; padding: 0.5rem;">'.$arr["inv_taxamt"].' '.$arr["inv_currency"].'</td></tr>';
	}


	$receiver_email=($arr['inv_email']); 
	$bill_phone=($arr['inv_phone']); 

	$inv_m_ph_eml='';
	if($receiver_email)
		$inv_m_ph_eml.='Email: '.$receiver_email.'<br style="">';
	if($bill_phone)
		$inv_m_ph_eml.='Mobile: '.$bill_phone.'<br style="">';
	
	$post['ctable1']=$arr["inv_b_name"].'<br style="">
		  '.$inv_m_ph_eml.'
		  '.$arr["inv_b_address"].'<br style="">
		  '.$arr["inv_b_address2"];
		  
	$post['ctable2']=$arr["inv_b_name"].'<br style="">
		  '.$inv_m_ph_eml.'
		  '.$arr["inv_b_address"].'<br style="">
		  '.$arr["inv_b_address2"];

	
	
	$post['currency_amount']=get_currency($arr["inv_currency"]).$arr["inv_amount"];
	$post['currency_total_amount']=get_currency($arr["inv_currency"]).$arr["inv_totalamt"];
	//$post['current_date']=date("d/m/Y h:i A");
	$post['current_date']=date("d/m/Y h:i A",strtotime($arr["inv_created_date"]));
	$post['company_name']=$arr["inv_m_company"];
	$post['product_name']=$arr["inv_product_name"];
	$post['create_number']=$arr["inv_invoice_no"];
	$post['payUrl']=$payurl;
	$post['fullname']=$arr["inv_b_name"];
	
	$post['clientid']=$uid;
	$post['mail_type']="6";
	$post['email']=$arr["inv_email"];
	
	send_email('SEND-INVOICE-PAYMENT-LINK', $post);	
	
	
	$msg_prnt='Invoice '.$post['create_number'].' for '.$post['product_name'].' by '.$post['company_name'].' Generated on '.$post['current_date'];
	
	$_SESSION['action_success']='Success! Invoice Send successfully :: '.$msg_prnt;
	header("Location:{$data['USER_FOLDER']}/{$data['PageFile']}".$data['ex']);exit;
}

//Dev Tech : 23-08-05 generate for quick payment link - SEND-PAYMENT-LINK via dynamic
elseif(isset($_POST['send_link'])&&$_POST['send_link']=="send"){

	$payurl=$_POST['pay_link'];

	//$post['emailheader']="self";
	$post['customer_email']=$_POST['pay_email'];
	$post['currency_amount']=$post['default_currency_sym'].$_POST["pay_amount"];
	$post['current_date']=date("d/m/Y h:i A");
	$post['payUrl']=$payurl;
		
	$post['clientid']=$uid;
	$post['mail_type']="6";
	$post['email']=$_POST['pay_email'];
	
	send_email('SEND-PAYMENT-LINK', $post);	

	
	$msg_prnt='Payment Link for '.$post['customer_email'].' Amount: '.$post['currency_amount'].' by '.$post["company_name"].' Generated on '.$post['current_date'];
	$_SESSION['action_success']='Payment Link Send successfully :: '.$msg_prnt;
	
	header("Location:{$data['USER_FOLDER']}/dashboard".$data['ex']);exit;
	
}

//Dev Tech : 23-08-05 generate for QR code payment - SEND-QR-CODE-PAYMENT via dynamic
elseif(isset($_POST['share_qr_code'])&&$_POST['share_qr_code']=="share"){

	$qrid=$_POST['qrid'];
	$mailer_sitename=$data['SiteName'];
	$mailer_company=$post['company_name'];

	if(isset($_SESSION['domain_server']['clients']['fullname'])&&$_SESSION['domain_server']['clients']['fullname'])
		$mailer_name=$_SESSION['domain_server']['clients']['fullname'];
	
	$payurl=$qr_link=($_POST['qr_link']);

	//$post['emailheader']="self";
	$email=$post['customer_email']=$post['email']=$_POST['email'];
	$post['currency_amount']=$post['default_currency_sym'].$_POST["pay_amount"];
	$post['current_date']=date("d/m/Y h:i A");
	$post['payUrl']=$payurl;
		
	$post['clientid']=$uid;
	$post['mail_type']="6";
	
	send_email('SEND-QR-CODE-PAYMENT', $post);	
	
	$msg_prnt='QR Code Payment for '.$post['customer_email'].' Amount: '.$post['currency_amount'].' by '.$post["company_name"].' Generated on '.$post['current_date'];
	$_SESSION['action_success']='QR code payment mailed successfully :: '.$msg_prnt;
	header("Location:{$data['USER_FOLDER']}/request_fund".$data['ex']);exit;

}



//print_r($data['selectdatas']); print_r($uid); echo "=h2=";


###############################################################################

display('user');

###############################################################################

?>