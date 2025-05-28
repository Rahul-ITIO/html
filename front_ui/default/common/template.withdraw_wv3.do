<?
$is_admin=isset($post['is_admin'])&&$post['is_admin']?$post['is_admin']:'';
$post['type']=isset($post['type'])&&$post['type']?$post['type']:'';
?>
<!DOCTYPE>
<html>

<head>
    <title><?=@$data['SiteTitle']?> [ADMINISTRATION AREA]</title>
    <meta http-equiv="pragma" content="no-cache" />
    <? if(isset($domain_server['STATUS'])&&$domain_server['STATUS']==true){ ?>
    <!-- Favicon -->
    <meta name="msapplication-TileImage" content="<?=@$domain_server['LOGO'];?>"> <!-- Windows 8 -->
    <meta name="msapplication-TileColor" content="#00CCFF" /> <!-- Windows 8 color -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!--[if IE]><link rel="shortcut icon" href="<?=@$domain_server['LOGO'];?>"><![endif]-->
    <link rel="icon" type="image/png" href="<?=@$domain_server['LOGO'];?>">

    <? } ?>
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <script src="<?=@$data['TEMPATH']?>/common/js/jquery-3.6.4.min.js"></script>
    <link href="<?=@$data['TEMPATH']?>/common/css/bootstrap.min.css" rel="stylesheet">
    <link href="<?=@$data['Host']?>/thirdpartyapp/fontawesome/css/all.min.css" rel="stylesheet">
    <script src="<?=@$data['TEMPATH']?>/common/js/bootstrap.bundle.min.js"></script>
    <link href="<?=@$data['TEMPATH']?>/common/css/template-custom.css" rel="stylesheet">
    <script src="<?=@$data['TEMPATH']?>/common/js/common_use.js" type="text/javascript"></script>

    <script type=text/javascript> function s() {
        window.status="<?=@$data['SiteTitle']?> ?????????? [ADMINISTRATION AREA]" ; return true }; if (document.layers)
        document.captureEvents(Event.MOUSEOVER | Event.MOUSEOUT | Event.CLICK | Event.DBLCLICK); document.onmouseover=s;
        document.onmouseout=s; </script> <style>
        body {
background: #ffffff !important;
}
</style>

<script>
var hostPath = "<?php echo $data['Host']?>";
var trans_class = "<?php echo $trans_class;?>";
</script>
    <?


///////////////////// Color Option ////////////////////
///////////////////// Default Color Option hardcoaded ////////////////////


$body_bg_color=@$data['bg_clrs'];
$body_text_color=@$data['bg_txtclrs'];

$heading_bg_color=@$data['bg_clrs'];
$heading_text_color=@$data['bg_txtclrs'];


// Fetch dynamic template colors
include($data['Path'].'/include/header_color_ux'.$data['iex']);
// Fetch fontawasome icon 
include($data['Path'].'/include/fontawasome_icon'.$data['iex']);

// include for Adjustment Template Color & size by merchant added by vikash on 05012023
include($data['Path'].'/include/color_font_adjustment_ux'.$data['iex']);
?>
    <style>
        :root {
            --color-1: <?=@$data['bg_txtclrs'];
            ?>;
            --background-1: <?=@$data['bg_clrs'];
            ?>;
        }
    </style>

    <link rel="stylesheet" type="text/css" href="<?=@$data['Host']?>/js/jquery-te-1.4.0.css" />
    <script src="<?=@$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>

    <style type="text/css">
        <? if(isset($domain_server['STYLE'])) echo $domain_server['STYLE']?>
    </style>
</head>

<body class='admins <?=@$data['PageFile']?> bnav'>

    <div class="container border rounded my-1 ">

    <? 
     //if(isset($data['NameOfFile']) && (isset($post['settlement_optimizer'])&&trim($post['settlement_optimizer'])&&$post['settlement_optimizer']=='manually'))
     { 
        ?>
  <div class="breadcrumb" id="withdraw_fund_for_css" style="height:inherit;<?=((isset($data ['HideAllMenu'])&&$data ['HideAllMenu'])?"display:block !important;":"")?>">
    <? include("../include/trans_balance_ui".$data['iex']);?>
    <div class="row w-100">
      <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a class="fund_3 text-decoration-none">Wire Fee : <b>
        <?=$post['ab']['account_curr_sys'];?>
        <?=$post['settlement_fixed_fee'];?>
        </b></a> </div>
      <? if(isset($data['ThisPageLabel'])&&$data['ThisPageLabel'] != 'Rolling'){ ?>
      <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a class="fund_3 text-decoration-none">
        <?=((isset($data['ThisPageLabel'])&&$data['ThisPageLabel'])?$data['ThisPageLabel']:'');?>
        Minimum: <b>
        <?=$post['ab']['account_curr_sys'];?>
        <?=$post['settlement_min_amt'];?>
        </b> </a></div>
      <? } ?>
      <? if($data['con_name']=='clk'&&isset($_SESSION['adm_login'])&&isset($_REQUEST['admin'])){ ?>
      <? if($post['total_mdr_amt']){ ?>
      <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a class="fund_3 text-decoration-none">Total MDR Amt. : <b>
        <?=$post['ab']['account_curr_sys'];?>
        <?=$post['total_mdr_amt'];?>
        </b></a></div>
      <? } ?>
      <? if($post['total_mdr_txtfee_amt']){ ?>
      <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a  class="fund_3">Transaction Fee : <b>
        <?=$post['ab']['account_curr_sys'];?>
        <?=$post['total_mdr_txtfee_amt'];?>
        </b></a></div>
      <? } ?>
      <? if($post['total_gst_fee']){ ?>
      <div class="col-sm-3"> <i class="<?=$data['fwicon']['hand'];?>"></i> <a  class="fund_3"></i> Total GST Fee @
        <?=$post['gst_fee'];?>
        : <b>
        <?=$post['ab']['account_curr_sys'];?>
        <?=$post['total_gst_fee'];?>
        </b></a></div>
      <? } ?>
      <? } ?>
    </div>
  </div>
  <? } ?>

      <!-- withdraw_wv3 -->
      <!-- trans_withdraw-fund_v3_custom_settlement -->
       <?
       if(isset($_REQUEST['url'])&&$_REQUEST['url']==1){
            $url_withd=@$data['Host'].'/include/withdraw_wv3';
       }
       else {
            $url_withd=@$data['USER_FOLDER'].'/trans_withdraw-fund_system_v2';
       }
       ?>


        <form id="myFormReq" class="myFormReq hide1" method="post"
            action="<?=@$url_withd;?><?=@$data['ex'];?>?admin=1&bid=<?=@$_GET['bid'];?>">

            <?=((isset($data['is_admin_input_hide'])&&$data['is_admin_input_hide'])?$data['is_admin_input_hide']:'');?>

            <?=(isset($_REQUEST['qp'])?'<input type="hidden" name="qp" value="'.@$_REQUEST['qp'].'">':'')?>

            
            <input type="hidden" name="admin" value="1">
            <input type="hidden" name="bid" value="<?=(isset($post['bid'])?$post['bid']:'')?>">

            <div class="row p-4  text-center">

                <div class="bg_div1 row pt-4">
                    <? 
                    if((isset($data['withdraw_transID'])&&count($data['withdraw_transID'])>0)) 
                    {
                    ?>
                        <div class="col">
                            <label for="withdraw_previous_transID">Previous Withdraw  <i
                                    class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
                            <input type="text" class="form-control w-100" id="withdraw_previous_transID" list="withdraw_previous_transID_list" name="withdraw_previous_transID"
                                value="<?php if(isset($post['withdraw_previous_transID'])){ echo $post['withdraw_previous_transID'];}?>"  <?=((isset($data['withdraw_prev_transID'])&&count($data['withdraw_prev_transID'])>0)?"required":"")?> >

                            <datalist id="withdraw_previous_transID_list">
                                <?=showselect($data['withdraw_prev_transID'], (isset($post['withdraw_previous_transID'])?$post['withdraw_previous_transID']:0))?>
                            </datalist>

                        </div>

                        <div class="col">
                            <label for="withdraw_from_date" class="w-100">Withdraw from Date: <i
                                    class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
                            <input type="text" name="withdraw_from_date" id="withdraw_from_date" class="form-control w-100"
                                value="<? if(isset($post['withdraw_from_date'])) echo prntext($post['withdraw_from_date'])?>"
                                required />
                        </div>


                        <div class="col">
                            
                            <label for="withdraw_transID">Payout Withdraw  </label>
                            <input type="text" class="form-control w-100" id="withdraw_transID" list="withdraw_transID_list" name="withdraw_transID"
                                value="<?php if(isset($post['withdraw_transID'])){ echo $post['withdraw_transID'];}?>" <?=((isset($data['withdraw_transID'])&&count($data['withdraw_transID'])>0)?"":"")?> >

                            <datalist id="withdraw_transID_list">
                                <?=showselect($data['withdraw_transID'], (isset($post['withdraw_transID'])?$post['withdraw_transID']:0))?>
                            </datalist>

                        </div>


                        
                        <div class="col">
                            <label for="withdraw_to_date" class="w-100">Withdraw to Date: <i
                                    class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
                            <input type="text" name="withdraw_to_date" id="withdraw_to_date" class="form-control w-100"
                                value="<? if(isset($post['withdraw_to_date'])) echo prntext($post['withdraw_to_date'])?>"
                                required />
                        </div>
                        
                    <? 
                     }
                     else
                     {
                    ?>
                        <div class="col">
                            <label for="withdraw_to_date" class="w-100">Withdraw to Date: <i
                                    class="<?=@$data['fwicon']['star'];?>  text-danger"></i></label>
                            <input type="text" name="withdraw_to_date" id="withdraw_to_date" class="form-control w-100"
                                value="<? if(isset($post['withdraw_to_date'])) echo prntext($post['withdraw_to_date'])?>"
                                required />
                        </div>
                    
                    <? 
                     }
                    ?>

                </div>

                <div class="col-sm-12 mx-auto my-2 py-4 text-center">
                    <button class="submit submitButton btn btn-primary" type="submit" name="continue" value="Continue"><i
                            class="<?=@$data['fwicon']['check-circle'];?>"></i> 
                        Submit</button>

                    &nbsp; <a
                        href="<?=@$data['Admins']?>/<?=@$data['my_project']?><?=@$data['ex']?>?<? if(isset($_GET['bid'])) echo 'id='.$_GET['bid'].'&';?>&action=detail&tab_name=collapsible1" target="_top"
                        class="btn btn-primary"> <i class="<?=@$data['fwicon']['back'];?>"></i> Back</a>
                </div>

            </div>
        </form>

    </div>

<link rel="stylesheet" type="text/css" media="all" href="<?=$data['Host']?>/thirdpartyapp/date_ranges/daterangepicker.css" />

<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_ranges/jquery.js"></script>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_ranges/moment.min.js"></script>
<script type="text/javascript" src="<?=$data['Host']?>/thirdpartyapp/date_ranges/daterangepicker.js"></script>

<style>
    .daterangepicker.ltr.single.opensright.show-calendar { padding-right: 28px;}
</style>

<script>
var withdraw_to_date2 = "<?=@$_REQUEST['withdraw_to_date2']?>";
var date_label = "<?=@$_REQUEST['date_label']?>";
var change_label = date_label;

//$(function() {
$(document).ready(function() {
	

    //Form Validation 
    $('#myFormReq').submit(function(e){ 
	  try {

        // Clear previous error messages
        $('#error-message').text('');

         // Regular expression for date validation
         var datePattern = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{6}$/;



		 // alert(e.result);
         var withdraw_from_date = $('.myFormReq input[name="withdraw_from_date"]').val();
         var withdraw_to_date = $('.myFormReq input[name="withdraw_to_date"]').val();

        if(withdraw_from_date == '') {
            alert("Withdraw from Date can not Blank! Please enter the Withdraw from Date.");
            $('.myFormReq input[name="withdraw_from_date"]').focus();
            return false;
        }else if(withdraw_to_date == '') {
            alert("Withdraw to Date can not Blank! Please enter the Withdraw to Date.");
            $('.myFormReq input[name="withdraw_to_date"]').focus();
            return false;
        }
        // Validate from date
        else if (!datePattern.test(withdraw_from_date)) {
            $('#error-message').append('Invalid From Date format. Expected format: YYYY-MM-DD HH:MM:SS.ssssss<br>');
            $('.myFormReq input[name="withdraw_from_date"]').focus();
            return false; // Return false to stop further processing
        }

        // Validate to date
        else  if (!datePattern.test(withdraw_to_date)) {
            $('#error-message').append('Invalid To Date format. Expected format: YYYY-MM-DD HH:MM:SS.ssssss<br>');
            $('.myFormReq input[name="withdraw_to_date"]').focus();
            return false; // Return false to stop further processing
        }
        // If both dates are valid, check if withdraw_from_date is less than withdraw_to_date
        else  if (datePattern.test(withdraw_from_date) && datePattern.test(withdraw_to_date) && ( new Date(withdraw_from_date) >= new Date(withdraw_to_date) ) ) {
            // Convert the date strings to Date objects for comparison
            $('#error-message').append('From Date must be less than To Date.<br>');
            $('.myFormReq input[name="withdraw_to_date"]').focus();
            return false; // Return false to stop further processing
        }
        else {
            
            $('.myFormReq .submitButton').html("<i class='<?=$data['fwicon']['spinner']?> fa-spin-pulse'></i> Processing ...");
            $('.myFormReq .submitButton').prop('disabled', true);
            //$('.myFormReq .submitButton').hide();
            return true;
            //return false;
        }
		e.preventDefault(); 
	   }
	   catch(err) {
		  alert('MESSAGE=>'+err.message);
	   }
	});
	

    //Date Compare and greater selected date
    $('#withdraw_previous_transID').on('input', function() {
        // Get the selected date from the input
        var selectedDate = $(this).val();
        
        // Clear the existing options in the withdraw_transID_list
        $('#withdraw_transID_list').empty();

        // Get options from the withdraw_previous_transID_list datalist
        $('#withdraw_previous_transID_list option').each(function() {
            var optionValue = $(this).val();
            var optionText = $(this).text();

            // Check if the option value is greater than the selected date
            if (optionValue > selectedDate) {
                $('#withdraw_transID_list').append(
                    $('<option></option>').val(optionValue).text(optionText)
                );
            }
        });
    });


    //Date picker 
		
	$('input[id="withdraw_to_date"]').daterangepicker({
		"opens": 'right', // left right
		"showDropdowns": true,

        "timePickerSeconds": true,

        
        "singleDatePicker": true,
        "showWeekNumbers": true,

		"timePicker": true,
			//"timePickerIncrement": true,
		"timePicker24Hour": true,
		"autoApply": true,
			//"autoUpdateInput": true,
		"autoUpdateInput": false,

        locale: {
			cancelLabel: 'Clear',
			//format: 'M/DD/YY HH:mm'
			format: 'YYYY-MM-DD HH:mm:ss'
			//format: 'M/DD/YY 00:00'
		},

        "alwaysShowCalendars": false,
		"linkedCalendars": false,

        startDate: moment().startOf('now'),
        endDate: moment().endOf('now')

		
	});
	
	

	$('input[id="withdraw_to_date"]').on('apply.daterangepicker', function(ev, picker) {

        $(this).val(picker.startDate.format('YYYY-MM-DD HH:mm:00'));
        //$(this).val(picker.startDate.format('MM/DD/YY HH:mm:00'));
		
	});
	
	$('input[id="withdraw_to_date"]').on('cancel.daterangepicker', function(ev, picker) {
		$(this).val('');
	});
	
	$('input[id="withdraw_previous_transID"]').on('change', function(ev, picker) {
        $('input[id="withdraw_from_date"]').val($(this).val());
	});
	
	$('input[id="withdraw_transID"]').on('change', function(ev, picker) {
        $('input[id="withdraw_to_date"]').val($(this).val());
	});
	
		
	

	
});




</script>

</body>

</html>