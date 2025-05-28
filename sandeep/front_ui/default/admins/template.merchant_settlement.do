<? if(isset($data['ScriptLoaded'])){ ?>
<link href="<?=$data['TEMPATH']?>/common/css/table-responsive.css" rel="stylesheet">
<div class="container border bg-white">
  <div class=" container px-0 vkg">
    <h4 class="my-2"><i class="<?=$data['fwicon']['money-check-dollar'];?>"></i> <?=$data['PageName'];?></h4>
      
    
    <div class="vkg-main-border"></div>
  </div>
  <form method="post" name="data">
    <input type="hidden" name="step" value="<?=$post['step']?>">
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
    $('.tableBody .collapsea').click(function(){
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
    <? if($post['step']==1){ ?>
    <div class="row text-center my-2 float-end me-2">
	  <a href="<?=$data['Admins'];?>/<?=$data['PageFile'];?><?=$data['ex']?>?action=merchant_settlement"  class="nopopup btn btn-primary" onclick="return confirm('Are you Sure to Payout Request!')" target="_blank" title="Payout Request"><i class="<?=$data['fwicon']['circle-plus'];?>"></i> </a>
	  </div>
    <div class="container table-responsive my-2 px-0">
      <table >
	  <thead>
        <tr>
          <th width="80px;">ID</th>
          <th>CSV Data</th>
          <th>Comments</th>
          <th>Updaed Date</th>
          <th>Created Date</th>
          <th width="80px;">Action</th>
        </tr>
		</thead>
        <? $j=1; foreach($post['result_list'] as $key=>$value) { ?>
        <tr>
          <td data-label="ID - "><a class="collapsea" data-href="<?=$j;?>_toggle"><?=$value['id'];?>&nbsp; </a></td>
          <td data-label="CSV Data - " ></td>
		
            
			
			
<td title='<?=$value['comments']?>' data-label="Comments - "><span class='dotdot1'><?=$value['comments']?></span></td>
<td title='<?=prndate($value['udate'])?>' data-label="Updaed Date - "><span class='dotdot1' >
<?=prndate($value['udate'])?></span></td>
<td title='<?=prndate($value['cdate'])?>' data-label="Created Date - "><span class='dotdot1' ><?=prndate($value['cdate'])?></span></td>
<td data-label="Action">

<a href="<?=$data['Admins'];?>/<?=$data['PageFile']?><?=$data['ex']?>?id=<?=$value['id']?>&action=update" title="Edit"><i class="<?=$data['fwicon']['edit'];?>"></i></a> <a href="<?=$data['Host']?>/include/csv_data_clk<?=$data['ex']?>?id=<?=$value['id']?>&action=csv" target="_blank" class="downloadcvs_click" style="display:inline-block;" title="Download"><i class="<?=$data['fwicon']['download'];?>"></i></a>

          </td>
        </tr>
        <tr class="padding0" >
          <td class="padding0" colspan="6" style="background:#faf8e3;" ><div class="collapseitem" id="<?=$j;?>_toggle">
          <div class="row_col3" style="display:none;">
                <div class="col1">ID :
                  <?=$value['id']?>
                </div>
                <div class="col2">Date :
                  <?=prndate($value['date']);?>
                </div>
                <div class="col_3">Status :
                  <?=$data['TicketStatus'][$value['status']];?>
                </div>
                <div class="col4">
                  <? if($value['status'] !="2") { ?>
                  <a class="addmessagelink" onclick="addmessages(this)"> Add Comments</a>
                  <? }?>
                </div>
              </div>
              <div class="row hide">
                <div class="col-sm-6"><b>Currency</b> :
                  <?=$value['currency']?>
                </div>
                <div class="row">
                  <div class="col-sm-6">Bank User Id :</div>
                  <div class="col-sm-6">
                    <?=$value['bank_user_id']?>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-6">Bank User Id :</div>
                  <div class="col-sm-6">
                    <?=$value['bank_user_id']?>
                  </div>
                </div>
              </div>
              <div class="title2"><b>Excel Data</b></div>
              <div class="row">
                <div class="col_2" style="width:100%;padding:0;">
                  <div class="tbl_exl">
                    <table>
                      <thead>
                        <tr>
                          <th>Sl./MID</th>
                          <th>Transaction ID</th>
                          <th title="Bank Reference No.">Bank Ref.No.</th>
                          <th title="Bank Status">Bank Status</th>
                          <th>MDR AMT.</th>
                          <th>Tra.FEE</th>
                          <th>WIRE FEE</th>
                          <th>MONTHLY FEE</th>
                          <th>VIRTUAL FEE</th>
                          <th>GST FEE</th>
                          <th>MID</th>
                          <th>User Name</th>
                          <th>Company Name</th>
                          <th>Payout Amount</th>
                          <th>Bank ID.</th>
                          <th>Bank Name</th>
                          <th>IFSC Code</th>
                          <th>Account Number</th>
                          <th>Nodal Bank Status</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?
					$csv_json=jsondecode($value['csv_json']);
					$n=1;
					foreach($csv_json as $key2=>$value2){
					?>
                        <tr>
                          <td title="Sl. & MID"><?=$n;?>
                            .
                            <?=$value2['bid'];?></td>
                          <td title="Transaction ID"><a onclick="iframe_open_modal(this);" class="nomid" data-ihref="<?=$data['Admins'];?>/<?=$data['trnslist']?><?=$data['ex']?>?admin=1&hideAllMenu=1&action=select&type=-1&status=-1&keyname=1&searchkey=<?=$value2['transID'];?>" >
                            <?=$value2['transID'];?>
                            </a></td>
                          <td title="Bank Reference No."><?=$value2['MessageId'];?></td>
                          <td title="Bank Status"><?=($value2['StatusCd']=='000'?"Success":$value2['StatusCd']);?></td>
                          <td title="MDR AMT."><?=$value2['total_mdr_amt'];?></td>
                          <td title="Transaction Fee"><?=$value2['total_mdr_txtfee_amt'];?></td>
                          <td title="Wire Fee"><?=$value2['settlement_fixed_fee'];?></td>
                          <td title="Monthly Fee"><?=$value2['monthly_fee'];?></td>
                          <td title="Virtual Fee"><?=$value2['virtual_fee'];?></td>
                          <td title="GST FEE"><?=$value2['total_gst_fee'];?></td>
                          <td title="MID"><?=$value2['bid'];?></td>
                          <? if(!empty($value2['Error'])){ ?>
                          <td title="<?=$value2['Error'];?>" style="background:red;color:#fff">Error</td>
                          <? }else{ ?>
                          <td title="User Name"><?=$value2['username'];?></td>
                          <? }?>
                          <td title="Company Name"><?=$value2['company_name'];?>
                            <?=$value2['Error'];?></td>
                          <td title="Payout Amount"><?=$value2['payout_amount'];?></td>
                          <td title="Bank ID."><?=$value2['bank_id'];?></td>
                          <td title="Bank Name"><?=$value2['bname'];?></td>
                          <td title="IFSC Code"><?=$value2['bswift'];?></td>
                          <td title="Account Number"><?=$value2['baccount'];?></td>
                          <td title="Nodal Bank Status"><?=$value2['StatusRem'];?></td>
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
                  <div class="tbl_exl">
                    <table>
                      <tbody>
                        <?
					     $csv_log=jsondecode($value['csv_log']);
					     $nk=1;
					     foreach($csv_log as $key3=>$value3){
						 $value3_j=jsondecode($value3);
					    ?>
                       <tr>
                       <?
					   foreach($value3_j as $key3_j_k=>$value3_j_v){
					   ?>
                          <td title="<?=$key3_j_k;?>"><? print_r(jsondecode($value3_j_v));?></td>
                          <? }?>
                        </tr>
                        <? }?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <div><b>All Logs</b></div>
              <div class="row">
              <div>
                  <?
			      $all_log=jsondecode($value['all_log']);
			      ?>
                  <div class="tbl_exl">
                    <table >
                      <tbody>
                        <? if(is_array($all_log)){foreach($all_log as $key5=>$value5){ ?>
                        <tr>
                          <td title="<?=$key5;?>" ><div>
                              <?=$value5['tm_user'];?>
                            </div>
                            <div>
                              <?=$value5['tm_date'];?>
                            </div></td>
                          <td  title="<?=$key5;?>" ><?
						 if(is_array($value5)){
						 $value5_0=jsondecode($value5['tm_log']);
						 foreach($value5_0 as $key5_1=>$value5_1){
						 ?>
                            <div class="drw" title="<?=$key5_1;?>" >
                              <?
								 if(is_array($value5_1)){
								 $value5_2=jsondecode($value5_1);
								 foreach($value5_2 as $key5_3=>$value5_3){
								 ?>
                              <div class="dtd" title="<?=$key5_3?>" > <?print_r(jsondecode($value5_3));?> </div>
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
              <div><b>Comments</b></div>
              <div class="row">
                <div>
                  <?=$value['comments']?>
                </div>
              </div>
              <? if($value['reply_comments']){ ?>
              <div class="title2"><b>REPLY <? if(!empty($value['currency_rate'])){ ?>
                [Date : <?=prndate($value['currency_rate'])?>]
                <? }?>
                </b></div>
              <div class="row">
                <div>
                  <?=$value['reply_comments']?>
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
	  
	  
	  
    
    <? }elseif($post['step']==2){ ?>
    <? if($post['gid']){ ?>
    <input type="hidden" name="gid" value="<?=$post['gid']?>">
    <input type="hidden" name="id" value="<?=$post['id']?>">
    <input type="hidden" name="action" value="update_db">
    <? }else{ ?>
    <input type="hidden" name="action" value="insert">
    <? }?>
    <script>document.write('<input type="hidden" name="aurl" value="'+top.window.document.location.href+'">');</script>
    <h4 class="my-2"><i class="<?=$data['fwicon']['setting'];?>"></i> <?=$data['PageName']?></h4>
      
    
    <div class="row-fluid input_col_2">
      <div class="col-sm-12">
      
          
          <label for="comments">Note/Comments: </label>
<textarea id="mustHaveId" class="form-control" name="comments" placeholder="Enter Note"><?=$post['comments'];?></textarea>
        </div>
     
<!--<label for="send"></label>-->
<div class="my-2">
<button formnovalidate type="submit" name=s"end" value="CONTINUE"  class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['check-circle'];?>"></i> Submit</button>
<a href="<?=$data['Admins']?>/<?=$data['PageFile']?><?=$data['ex']?>" class="btn btn-icon btn-primary"><i class="<?=$data['fwicon']['back'];?>"></i> Back</a> 
</div>
</div>
		
		 

    <? }?>
  </form>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
