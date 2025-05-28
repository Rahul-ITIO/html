<?php
error_reporting(0);
function getMondaysInRange2($dateFromString, $dateToString, $is_account=''){
	
	
    $dateFrom = new \DateTime($dateFromString);
    $dateTo = new \DateTime($dateToString);
    $dates = array();

	//echo "is_account=".$is_account."<hr/>";
	
    if ($dateFrom > $dateTo) {
        return $dates;
    }

    if ((3 != $dateFrom->format('N'))) {
        //$dateFrom->modify('next Wednesday');
    }
	
    if (($is_account=="check")&&(3 != $dateFrom->format('N'))) {
        $dateFrom->modify('next Wednesday');
    }elseif(($is_account=="card")&&(1 != $dateFrom->format('N'))) {
        $dateFrom->modify('next Monday');
    }else{
		// $dateFrom->modify('next Wednesday');
	}

    while ($dateFrom <= $dateTo) {
        $dates[] = $dateFrom->format('Y-m-d');
        $dateFrom->modify('+1 week');
    }

    return $dates;
}
$fromDate = date('Y-m-d',strtotime($_REQUEST['fpdate']));
$toDate = date('Y-m-d',strtotime($_REQUEST['tpdate']));
if(isset($_REQUEST['is_account'])){$is_account=$_REQUEST['is_account'];}
if(isset($_REQUEST['ex'])){$data['ex']=$_REQUEST['ex'];}
if(isset($_REQUEST['report_file_name'])){$report_file_name=$_REQUEST['report_file_name'];}

//,$report_file_name="cardreport"

$alldate = getMondaysInRange2($fromDate,$toDate,$is_account);
//$alldate = getMondaysInRange2("2017-05-01","2017-06-31");

$common_get = "&type=".$_REQUEST['type']."&status=-1&page=".$_REQUEST['page']."&order=".$_REQUEST['order']."&is_account=".$_REQUEST['is_account'];



?>
 <ul class="Xnavbar-nav me-auto mb-2 mb-lg-0  justify-content-start bd-highlight mb-3" style="margin:0;text-align:left;float:left;width:100%;">
	<?php foreach($alldate as $key=>$value){ 
		$payDate=date("Ymd",strtotime($value));
		$currentDate=date("Ymd");
		if($payDate<=$currentDate){
			$paydLink=1;
		}else{
			$paydLink=0;
		}
	?>
		<li class="nav-item dropdown " style="max-width: 120px;float:left;" > <a data-toggle="dropdown" class="glyphicons hand_down payoutpdf0" onclick="filteraction0(this)"><?php echo date("D d-m-Y",strtotime($value)); ?> </a>
			<ul class="dropdown-menu pull-right">				
				<li><a onclick="filteraction(this)" target="selltedview" href="transactions<?=$data['ex']?>?bid=<?php echo $_REQUEST['bid'];?>&pdate=<?php echo date("Y-m-d",strtotime($value));?><?php echo $common_get; ?>&action=select&querytype=selltedview" class="payoutpdf viewedcl glyphicons eye_open"><i></i><span>VIEW </span></a></li>
				<?if($paydLink){?>
				<li><a onclick="filteraction(this)" target="selltedview" data-action="selltedall" data-label="Settled List" data-reason="Settled by SWIFT Reference" data-href="transactions<?=$data['ex']?>?bid=<?php echo $_REQUEST['bid'];?>&pdate=<?php echo date("Y-m-d",strtotime($value));?><?php echo $common_get; ?>&action=payoutsellted&querytype=sellted" class="payoutpdf settledcl glyphicons ok"><i></i><span>SETTLED</span></a></li>
				<?}?>
				<li><a onclick="filteraction(this)" target="pdfreport" href="../<?=$report_file_name?><?=$data['ex']?>?bid=<?php echo $_REQUEST['bid'];?>&pdate=<?php echo date("Y-m-d",strtotime($value));?>&type=<?php echo $_REQUEST['type'];?>" class="payoutpdf pdfreportcl glyphicons retweet"><i></i><span>PDF REPORT</span></a></li>
				
				<li><a onclick="filteraction(this)" target="pdfreport_1" href="../<?=$report_file_name?>_1<?=$data['ex']?>?bid=<?php echo $_REQUEST['bid'];?>&pdate=<?php echo date("Y-m-d",strtotime($value));?>&type=<?php echo $_REQUEST['type'];?>" class="payoutpdf pdfreportcl_1 glyphicons retweet"><i></i><span>PDF REPORT</span></a></li>
				
				<li><a onclick="filteraction(this);popuploadig();" target="hform" href="../transaction_fee_calculation<?=$data['ex']?>?bid=<?php echo $_REQUEST['bid'];?>&pdate=<?php echo date("Y-m-d",strtotime($value));?><?php echo $common_get; ?>&action=select&querytype=tfcupdate" class="payoutpdf tfcupdate glyphicons cogwheel"><i></i><span>UPDATE </span></a></li>
				
			</ul>
		</li>
	<?php } ?>
</ul>
