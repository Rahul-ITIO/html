<link href="<?=@$data['TEMPATH']?>/common/css/table-responsive_999.css" rel="stylesheet">
<style>
.betaVersion{height:54px;position:absolute;margin:4px 0;z-index:9;left:48%;}
.title2{font-size:14px!important;padding:10px 1.5%;margin:0;float:left;border-bottom:2px solid #ccc;width:97%;text-align:left;color:#ae6200!important}

.tbl_exl_2 {width:100%!important;overflow:scroll;max-height: 500px;margin: 0 auto;float: left;}
.tbl_exl_2 table {position:relative;border:0px solid #ddd;border-collapse:collapse;max-width: inherit;}
td .tbl_exl_2{width:100%!important}

@media screen and (min-width: 761px) 
{
  .tbl_exl_2 td,.tbl_exl_2 tr td:first-of-type,.tbl_exl_2 tr:hover td:first-of-type{padding:4px 10px!important;width:max-content!important}
  .dtd,.tbl_exl_2 td,.tbl_exl_2 th{white-space:nowrap;border:1px solid #ddd;padding:4px 10px!important;text-align:center;width:max-content!important}
  
  .tbl_exl_2.csv_log_v td {
    white-space: nowrap !important;
  }
  .tbl_exl_2.csv_log_v th {
    padding:2px 10px !important;
  }
}
@media only screen and (max-width: 760px) 
{ 
  /*
  td.padding0::before {
    content: attr(data-label);
    display: inline-block;
    line-height: 1.5;
    margin-left: 0%;
    width: 100%;
    white-space: nowrap;
    font-weight: 500;
    color: #000;
  }

  td td::before {
    content: attr(data-label);
    display: inline-block;
    line-height: inherit;
    width: 45%;
    white-space: nowrap;
    font-weight: 500;
    color: #000;
    text-align: left !important;
    margin-left: -45% !important;
    padding: 0 !important;
  }
  */
}

</style>
<div class="container border bg-white">
  <div class=" container px-0 " style="position:relative;">
    <div><img src="<?=$data['Host']?>/images/betaVersion.png" class="betaVersion" /></div>
    <h4 class="my-2"><i class="<?=@$data['fwicon']['money-check-dollar'];?>"></i> <?=@$data['PageName'];?></h4>
     
    
    <div class="vkg-main-border"></div>
  </div>
  <form method="post" name="data">
    <input type="hidden" name="step" value="<?=@$post['step']?>">
    <script>
function viewdetails(e){
	if($(e).hasClass('active')){
		$('.viewdetaillink').removeClass('active');
		$('.viewdetaildiv').removeClass('active');
		
		$(e).parent().parent().parent().find('.viewdetaildiv').slideUp(200);
	} else {
	  $('.viewdetaillink').removeClass('active');
	  $('.viewdetaildiv').removeClass('active');
	  
	  $(e).parent().parent().parent().find('.viewdetaildiv').addClass('active');
	  $(e).addClass('active');
	  
	  $('.viewdetaildiv').slideUp(100);
	  $(e).parent().parent().parent().find('.viewdetaildiv').slideDown(700);
	}
}
function addmessages(e){
	if($(e).hasClass('active')){
		$('.addmessagelink').removeClass('active');
		$('.addmessageform').removeClass('active');
		
		$(e).parent().parent().parent().find('.addmessageform').slideUp(200);
	} else {
	  $('.addmessagelink').removeClass('active');
	  $('.addmessageform').removeClass('active');
	  
	  $(e).parent().parent().parent().find('.addmessageform').addClass('active');
	  $(e).addClass('active');
	  
	  $('.addmessageform').slideUp(100);
	  $(e).parent().parent().parent().find('.addmessageform').slideDown(700);
	}
}
$(document).ready(function(){
    $('.table-responsive .collapsea').click(function(){
	   var ids = $(this).attr('data-href');
		if($(this).hasClass('active')){
			$('.collapseitem').removeClass('active');
			$('.collapsea').removeClass('active');
			
			$('#'+ids).slideUp(200);
		} else {
		  $('.collapseitem').removeClass('active');
		  $('.collapsea').removeClass('active');
		  //$('#'+ids).addClass('active');
		  $(this).addClass('active');
		  
		  $('.collapseitem').slideUp(100);
		  $('#'+ids).slideDown(700);
		}
        
    });
    
});

function popup_openv1(url,json1=''){
	if(json1){
		$('#myModal9').modal('show').find('.modal-body').load(url,{"json":json1});
	}else{
		$('#myModal9').modal('show').find('.modal-body').load(url);
	}
	$('#myModal9 .modal-dialog').css({"max-width":"80%"});
}
</script>

    <? if(isset($data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
      <?=prntext(@$data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? }?>
    <? if(isset($_SESSION['action_success'])){ ?>
    <div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>Success!</strong> <?=@$_SESSION['action_success'];?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? $_SESSION['action_success']=null; }?>
    <? if(@$post['step']==1){ ?>
    <div class="row text-center my-2 float-end me-2">
	  <a href="<?=@$data['Admins'];?>/<?=@$data['PageFile'];?><?=@$data['ex']?>?action=merchant_settlement&actionType=web"  class="nopopup btn btn-primary" onclick="return confirm('Are you Sure to Payout Request!')" target="_blank" title="Payout Request"><i class="<?=@$data['fwicon']['circle-plus'];?>"></i> </a>
	  </div>
    <div class="container table-responsive my-2 px-0" >
        

      <table >
	  <thead>
        <tr>
          <th width="80px;">ID</th>
          <th>CSV Data</th>
          <th>Witdhraw TransIDs</th>
          <th>Updated Date</th>
          <th>Created Date</th>
          <th width="80px;">Action</th>
        </tr>
		</thead>
        <? 
        //print_r(@$post['result_list']);
        $j=1; foreach($post['result_list'] as $key=>$value) { 
          
          //print_r($value['csv_json']);
					$csv_json=jsondecode("[".$value['csv_json']."]");

          $transID_arr=[];
          foreach($csv_json as $key2_0=>$value2_0){
            if(isset($value2_0['transID'])&&$value2_0['transID']>0) $transID_arr[]=@$value2_0['transID'];
          }
          $transIDs=implode(",",$transID_arr);
          $transIDs_all=$transIDs.',{"ids":"'.$transIDs.'"}';
        ?>
        <tr>
          <td data-label="ID : "><a class="collapsea" data-href="<?=@$j;?>_toggle"><?=@$value['id'];?>&nbsp; </a></td>

          <td data-label="CSV Data : " >
            <?/*?> <a href='<?=@$data['Admins'];?>/json_pretty_print<?=@$data['ex']?>?json=<?=encryptres("[".@$value['csv_json']."]");?>' class="modal_from_url" title="
            view" >View</a> | <?*/?>
            <a onclick="popup_openv1('<?=@$data['Admins'];?>/json_pretty_print<?=@$data['ex']?>','<?=encryptres('['.@$value['csv_json'].']');?>','','','');" title="Withdraw Response" ><i class="fa-solid fa-eye"></i> <?=count(@$csv_json);?></a>
          </td>
		
                
          <td title='Witdhraw TransIDsRetrieve withdrawal transaction IDs date-wise from CRUN' data-label="TransIDs : ">
              <a class='dotdot1' onclick="popup_openv1('<?=@$data['Admins'];?>/json_pretty_print<?=@$data['ex']?>','<?=encryptres('['.@$transIDs_all.']');?>','','','');" title="Retrieve withdrawal transaction IDs date-wise from CRUN" ><i class="fa-solid fa-eye"></i> <?=count(@$csv_json);?><?=lf(@$transIDs,40,1);?></a>
          </td>

          <td title='<?=prndate($value['udate'])?>' data-label="Updaed Date : "><span class='dotdot1' >
          <?=prndate($value['udate'])?></span></td>
          <td title='<?=prndate($value['cdate'])?>' data-label="Created Date : "><span class='dotdot1' ><?=prndate($value['cdate'])?></span></td>
          <td data-label="Action">

          <a class="hide" href="<?=@$data['Admins'];?>/<?=@$data['PageFile']?><?=@$data['ex']?>?id=<?=@$value['id']?>&action=update" title="Edit"><i class="<?=@$data['fwicon']['edit'];?>"></i></a> <a href="<?=@$data['Host']?>/include/csv_data_clk<?=@$data['ex']?>?id=<?=@$value['id']?>&action=csv" target="_blank" class="downloadcvs_click" style="display:inline-block;" title="Download"><i class="<?=@$data['fwicon']['download'];?>"></i></a>

          </td>
        </tr>
        <tr class="padding0" >
          <td class="padding0" colspan="6" style="background:rgb(255,255,255);background:radial-gradient(circle, rgba(255,255,255,1) 44%, rgba(250,248,227,1) 100%);" >
          <div class="collapseitem row" id="<?=@$j;?>_toggle" style="border-bottom:10px #ccc solid;">
          <div class="row_col3 hide" >
                <div class="col1">ID :
                  <?=@$value['id']?>
                </div>
                <div class="col2">Date :
                  <?=prndate(@$value['udate']);?>
                </div>
                <div class="col_3">Status :
                  <?=@$data['TicketStatus'][@$value['status']];?>
                </div>
                <div class="col4">
                  <? if(@$value['status'] !="2") { ?>
                  <a class="addmessagelink" onclick="addmessages(this)"> Add Comments</a>
                  <? }?>
                </div>
              </div>
              <div class="row hide">
                <div class="col-sm-6"><b>Currency</b> :
                  <?=@$value['currency']?>
                </div>
                <div class="row">
                  <div class="col-sm-6">Bank User Id :</div>
                  <div class="col-sm-6">
                    <?=@$value['bank_user_id']?>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-6">Bank User Id :</div>
                  <div class="col-sm-6">
                    <?=@$value['bank_user_id']?>
                  </div>
                </div>
              </div>
              <div class="title2"><b>Excel Data</b></div>
              <div class="row">
                <div class="col_2" style="width:100%;padding:0;">
                  <div class="tbl_exl_2 csv_log_v">
                    <table style="table-layout:auto;">
                      <thead>
                        <tr>
                          <th wrap>Sl.</th>
                          <th wrap>ClientId</th>
                          <th wrap>Transaction ID</th>
                          <th wrap title="Bank Reference No.">Bank Ref.No.</th>
                          <th wrap title="Bank Status">Bank Status</th>
                          <th wrap>MDR AMT.</th>
                          <th wrap>Tra.FEE</th>
                          <th wrap>WIRE FEE</th>
                          <th wrap>MONTHLY FEE</th>
                          <th>GST FEE</th>
                          <th>TOTAL FEE</th>
                          <th>ClientId</th>
                          <th>User Name</th>
                          <th>Company Name</th>
                          <th>Payout Amount</th>
                          <th>P.Currency</th>
                          <th>Bank ID.</th>
                          <th>Bank Name</th>
                          <th>IFSC Code</th>
                          <th>Account Number</th>
                          <th>Nodal Bank Status</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?
                        
                        $n=1;
                        foreach($csv_json as $key2=>$value2){
                        ?>
                        <tr>
                          <td title="Sl." data-label="Sl."><?=@$n;?></td>
                          <td title="ClientId" data-label="ClientId"><a data-ihref="<?=@$data['Admins'];?>/<?=@$data['my_project']?><?=@$data['ex']?>?id=<?=@$value2['bid'];?>&action=detail&type=active<?=((isset($data['is_admin_link'])&&$data['is_admin_link'])?$data['is_admin_link']:'');?>&admin=1&hideAllMenu=1&bid=<?=@$value2['bid'];?>" class="badge text-bg-dark pointer" style="color:<?=@$themecolor?>;" onclick="iframe_open_modal(this)" title="View Merchant Details - <?=@$value2['bid'];?>" data-bs-toggle="tooltip" data-bs-placement="bottom"><?=@$value2['bid'];?></a></td>

                          <td title="Transaction ID" data-label="Transaction ID"><a onclick="iframe_open_modal(this);" class="nomid" data-ihref="<?=@$data['Admins'];?>/<?=@$data['trnslist']?><?=@$data['ex']?>?admin=1&hideAllMenu=1&action=select&acquirer=2&key_name=transID&search_key=<?=@$value2['transID'];?>&bid=<?=@$value2['bid'];?>" title="Withdraw Details " data-bs-toggle="tooltip" data-bs-placement="bottom" style="cursor:pointer" ><?=@$value2['transID'];?></a></td>
                          <td title="Bank Reference No." data-label="Bank Reference No."><?=@$value2['MessageId'];?></td>
                          <td title="Bank Status" data-label="Bank Status"><?=(@$value2['StatusCd']=='000'?"Success":@$value2['StatusCd']);?></td>
                          <td title="MDR AMT." data-label="MDR AMT."><?=@$value2['total_mdr_amt'];?></td>
                          <td title="Transaction Fee" data-label="Transaction Fee"><?=@$value2['total_mdr_txtfee_amt'];?></td>
                          <td title="Wire Fee" data-label="Wire Fee"><?=@$value2['settlement_fixed_fee'];?></td>
                          <td title="Monthly Fee" data-label="Monthly Fee"><?=@$value2['monthly_fee'];?></td>
                          <td title="GST FEE" data-label="GST FEE"><?=@$value2['total_gst_fee'];?></td>
                          <td title="Total Fee" data-label="Total Fee"><?=@$value2['cal_total_fee'];?></td>
                          <td title="MID" data-label="MID"><?=@$value2['bid'];?></td>
                          <? if(!empty($value2['Error'])){ ?>
                          <td title="<?=@$value2['Error'];?>"  data-label="<?=@$value2['Error'];?>" style="background:red;color:#fff">Error</td>
                          <? }else{ ?>
                          <td title="User Name" data-label="User Name"><?=@$value2['username'];?></td>
                          <? }?>
                          <td title="Company Name" data-label="Company Name"><?=@$value2['company_name'];?>
                            <?=@$value2['Error'];?></td>
                          <td title="Payout Amount" data-label="Payout Amount"><?=@$value2['settlementAmt'];?></td>
                          <td title="Payout Currency" data-label="Payout Currency"><?=@$value2['settlementCurrency'];?></td>
                          <td title="Bank ID." data-label="Bank ID."><?=@$value2['bank_id'];?></td>
                          <td wrap title="Bank Name" data-label="Bank Name"><?=@$value2['bname'];?></td>
                          <td title="IFSC Code" data-label="IFSC Code"><?=@$value2['bswift'];?></td>
                          <td title="Account Number" data-label="Account Number"><?=@$value2['baccount'];?></td>
                          <td title="Nodal Bank Status" data-label="Nodal Bank Status"><?=@$value2['StatusRem'];?></td>
                        </tr>
                        <? $n++;}?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <div class="title2"><b>Full Data</b></div>
              <div class="row">
                <div class="col_2" style="width:100%;padding:0;">
                  <? //=$value['csv_log']?>
                  <div class="tbl_exl_2 full_data_v">
                    <table style="table-layout:auto;">
                      <tbody>
                        <?
                        $csv_log=jsondecode("[".$value['csv_log']."]");
                        $nk=1;
                        foreach($csv_log as $key3=>$value3){
                      $value3_j=jsondecode($value3);
                        ?>
                       <tr>
                       <?
					   foreach($value3_j as $key3_j_k=>$value3_j_v){
					   ?>
                          <td title="<?=@$key3_j_k;?>"><? print_r(jsondecode($value3_j_v));?></td>
                          <? }?>
                        </tr>
                        <? }?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <div class="title2"><b>All Logs</b></div>
              <div class="row">
              <div>
                  <?
			      $all_log=jsondecode("[".$value['all_log']."]");
			      ?>
                  <div class="tbl_exl_2">
                    <table style="table-layout:auto;">
                      <tbody>
                        <? if(is_array($all_log)){foreach($all_log as $key5=>$value5){ ?>
                        <tr>
                          <td  title="<?=@$key5;?>" >
                            <div>
                              <?=@$value5['tm_user'];?>
                            </div>
                            <div>
                              <?=@$value5['tm_date'];?>
                            </div>
                          </td>
                          <td  title="<?=@$key5;?>" ><?
						 if(is_array($value5)){
						 //$value5_0=jsondecode("[".$value5['tm_log']."]");
						 $value5_0=jsondecode(@$value5['tm_log']);
						 foreach($value5_0 as $key5_1=>$value5_1){
						 ?>
                            <div class="drw" title="<?=@$key5_1;?>" >
                              <?
								 if(is_array($value5_1)){
								 $value5_2=jsondecode($value5_1);
								 foreach($value5_2 as $key5_3=>$value5_3){
								 ?>
                              <div class="dtd" title="<?=@$key5_3?>" > <?print_r(jsondecode($value5_3));?> </div>
                              <? }}?>
                            </div>
                            <? }}?>
                          </td>
                        </tr>
                        <? }}?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <div class="row hide"><b>Comments</b></div>
              <div class="row hide">
                <div>
                  <?=@$value['comments']?>
                </div>
              </div>
              <? if(@$value['reply_comments']){ ?>
              <div class="title2"><b>REPLY <? if(!empty($value['currency_rate'])){ ?>
                [Date : <?=prndate($value['currency_rate'])?>]
                <? }?>
                </b></div>
              <div class="row">
                <div>
                  <?=@$value['reply_comments']?>
                </div>
              </div>
              <? } ?>
            </div></td>
        </tr>
        <? $j++; }?>
        <tr>
          
        </tr>
      </table>
	  </div>
	  
	  
	  
    
    <? }elseif(@$post['step']==2){ ?>
    <? if(@$post['gid']){ ?>
    <input type="hidden" name="gid" value="<?=@$post['gid']?>">
    <input type="hidden" name="id" value="<?=@$post['id']?>">
    <input type="hidden" name="action" value="update_db">
    <? }else{ ?>
    <input type="hidden" name="action" value="insert">
    <? }?>
    <script>document.write('<input type="hidden" name="aurl" value="'+top.window.document.location.href+'">');</script>
    <h4 class="my-2"><i class="<?=@$data['fwicon']['setting'];?>"></i> <?=@$data['PageName']?></h4>
      
    
    <div class="row-fluid input_col_2">
      <div class="col-sm-12">
      
          
          <label for="comments">Note/Comments: </label>
<textarea id="mustHaveId" class="form-control" name="comments" placeholder="Enter Note"><?=@$post['comments'];?></textarea>
        </div>
     
<!--<label for="send"></label>-->
<div class="my-2">
<button formnovalidate type="submit" name=s"end" value="CONTINUE"  class="btn btn-icon btn-primary"><i class="<?=@$data['fwicon']['check-circle'];?>"></i> Submit</button>
<a href="<?=@$data['Admins']?>/<?=@$data['PageFile']?><?=@$data['ex']?>" class="btn btn-icon btn-primary"><i class="<?=@$data['fwicon']['back'];?>"></i> Back</a> 
</div>
</div>
		
		 

    <? }?>
  </form>
</div>

