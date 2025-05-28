<?
$mop_list_option='manual';
//$mop_list_option='dynamic';

if(isset($mop_list_option)&&@$mop_list_option=='dynamic'&&isset($typenum)&&$typenum>0)
{ 
    //Get Icon from mop of acquirer id wise 
    $mop_get=$_SESSION['actDb_mop'][$typenum];
    if(@$mop_get)$mop_icon=mop_option_list_f(2,$mop_get).' ';
    else $mop_icon='';
    echo '<font class="mop_icon_dynamic">'.$mop_icon.'</font>';
}
elseif(isset($mop_list_option)&&@$mop_list_option=='manual'&&isset($get_mop)&&trim($get_mop))
{ 
    //echo @$get_mop;
    if($get_mop=='NP'){ 
        $mop_get=$_SESSION['actDb_mop'][$typenum];
        if(@$mop_get)$mop_icon=mop_option_list_f(2,$mop_get).' ';
        else $mop_icon='';
        echo '<font class="mop_icon_dynamic">'.$mop_icon.'</font>';
    }
    elseif($get_mop=='visa'){ 
    $fwimg=1; $fwicon=$data['fwicon']['visa'];
    $img="visacard.png";$txt='Visa Card';
    $sort="&ccard_type=Visa";
    }
    elseif ($get_mop=='jcb'){
    $fwimg=1; $fwicon=$data['fwicon']['jcb'];
    $img="jcb.png";$txt='JCB Card';
    $sort="&ccard_type=JCB";
    }
    elseif ($get_mop=='mastercard'){
    $fwimg=1; $fwicon=$data['fwicon']['mastercard'];
    $img="master.png";$txt='Master Card';
    $sort="&ccard_type=MasterCard";
    }
    elseif ($get_mop=='discover'){
    $fwimg=1; $fwicon=$data['fwicon']['discover'];
    $img="discover.png";$txt='Discover';
    $sort="&ccard_type=Discover";
    }
    elseif ($get_mop=='rupay'){
    $img="rupay.jpg";$txt='Rupay';
    $sort="&ccard_type=rupay";
    }
    elseif ($get_mop=='amex'){
    $fwimg=1; $fwicon=$data['fwicon']['amex'];
    $img="amex.png";$txt='Amex';
    $sort="&ccard_type=amex";
    }
    elseif ($get_mop=='QR'){
    $fwimg=1; $fwicon=$data['fwicon']['qr-code']; 
    $sort="&ccard_type=QR";
    }
    elseif ($get_mop=='NB'){
    $fwimg=1; $fwicon=$data['fwicon']['netbanking'];
    $sort="&ccard_type=NB";
    }
    elseif ($get_mop=='WA'){
    $fwimg=1; $fwicon=$data['fwicon']['wallet'];
    $sort="&ccard_type=WA";
    }
    elseif ($get_mop=='BT'){
    $fwimg=1; $fwicon=$data['fwicon']['bt'];
    $sort="&ccard_type=BT";
    }
    elseif ($get_mop=='3D'){
    $fwimg=1; $fwicon=$data['fwicon']['creditcard'];
    $sort="&ccard_type=3D";
    }
    elseif ($get_mop=='2D'){
        $fwimg=1; $fwicon=$data['fwicon']['creditcard'];
    $sort="&ccard_type=2D";
    }
    elseif ($get_mop=='UPIQR'){
    $fwimg=1; $fwicon='<img src="'.$data['bankicon']['bhim-svg'].'" class="img-fluid img-hover" style="max-height:18px;">';
    $sort="&ccard_type=UPIQR";
    }elseif ($get_mop=='UPI'){
    $fwimg=1; $fwicon='<img src="'.$data['bankicon']['upi-icon'].'" class="img-fluid img-hover" style="max-height:18px;">';
    $sort="&ccard_type=UPI";
    }
    elseif ($get_mop=='NP'){
    $fwimg=1; $fwicon='<img src="'.$data['bankicon']['cryptocurrency'].'" class="img-fluid img-hover" style="max-height:18px;">';
    $sort="&ccard_type=np";
    }

    elseif (isset($data['channel'][@$value['channel_type']]['name1'])&&$data['channel'][@$value['channel_type']]['name1']=="wa"){
        $fwimg=1; $fwicon=$data['fwicon']['wallet'];
        $sort="&ccard_type=WA";
    }
    elseif (isset($data['channel'][@$value['channel_type']]['name1'])&&$data['channel'][@$value['channel_type']]['name1']=="AdvCash"){
        $fwimg=1; $fwicon=$data['fwicon']['AdvCash'];
        $sort="&ccard_type=AdvCash";
    }
    elseif ($get_mop=='applepay'){
        $fwimg=1; $fwicon=$data['fwicon']['applepay'];
    $sort="&ccard_type=applepay";
    } 
    elseif ($get_mop=='googlepay'){
        $fwimg=1; $fwicon=$data['fwicon']['googlepay'];
    $sort="&ccard_type=googlepay";
    }
    elseif (empty($get_mop)){
    $fwimg=1; $fwicon=$data['fwicon']['nocc'];
    $img="nocc.png";$txt='No Card Available';$sort="&ccard_type=-1";
    }else{
        $fwimg=0;
        $img="nocc.png";$txt='No Card Available';$sort="&ccard_type=-1";$style1="width:30px;height:auto;";
    }


    if(isset($img)&&trim($img)&&$img=="nocc.png"&&empty($fwicon)){ $fwimg=1; $fwicon=$data['fwicon']['nocc']; }



    if($get_mop=='WD'){
    $img="wd.png";$txt='Withdraw';$sort="&payment_type=wd";
    }
    elseif($value['t']=="Deposit"){
    $img="deposit.png";$txt='Deposit';$sort="&payment_type=dp";
    }
    elseif($value['t']=="Withdraw Rolling"){
    $img="wr.png";$txt='Withdraw Rolling';$sort="&payment_type=wr";
    }

    //$sort=$data['Admins']."/{$data['trnslist']}".$data['ex']."?action=select".$data['cmn_action'].(isset($sort)&&trim($sort)?$sort:'');
    $sort="{$data['trnslist']}".$data['ex']."?action=select".@$data['cmn_action'].(isset($sort)&&trim($sort)?$sort:'');

    if(!in_array($get_mop,["NP"]))
    {
    ?>
    <a href="<?=$sort;?>" title="<?=$get_mop?> <?=(isset($txt)&&trim($txt)?' - '.$txt:'')?>"  class="transaction-list-h1">
    <? if($fwimg==0){ ?>
        <img src="<?=$data['Host']?>/images/<?=$img?>" class="img-fluid img-hover" alt="<?=(isset($txt)&&trim($txt)?$txt:'')?>" style="max-height:18px;">
    <? }else{ echo $fwicon; ?>
    <? }
    } ?>
    </a>
<? } ?>