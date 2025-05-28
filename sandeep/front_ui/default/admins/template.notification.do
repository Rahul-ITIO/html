<? if(isset($data['ScriptLoaded'])){ ?>

<div class="container border mt-1 vkg rounded">
  <div class="row" >
    <div class="col-sm-12 px-0" >
      <div class="container vkg px-0">
        <h4 class="my-2"><i class="<?=$data['fwicon']['bell'];?>"></i> Notification</h4>
        <div class="vkg-main-border"></div>
      </div>
      <div class="table-responsive-sm">
        <table class="table table-hover">
          <tbody>
            <tr>
              <td>Transactions </td>
              <td><a href="<?=$data['Admins']?>/transactions<?=$data['ex']?>?action=select&type=-1&status=-1&keyname=19&searchkey=1" target="_blank" class="btn btn-primary btn-sm my-1">Reply Transaction Query <span class="badge bg-vdark">
                <?=($data['replyTransactionQuery']);?>
                </span></a> </td>
            </tr>
            <? if(isset($data['PRO_VER'])&&$data['PRO_VER']<>3) { ?>
            <tr>
              <td>Message/Ticket </td>
              <td><a href="<?=$data['Admins']?>/messages<?=$data['ex']?>?filter=1&tab=0&stf=0" target="_blank" class="btn btn-primary btn-sm my-1">Open <span class="badge bg-vdark">
                <?=($data['openMessage']);?>
                </span></a> <a href="<?=$data['Admins']?>/messages<?=$data['ex']?>?filter=1&tab=0&stf=1" target="_blank" class="btn btn-primary btn-sm my-1">Process <span class="badge bg-vdark">
                <?=($data['processMessage']);?>
                </span></a> </td>
            </tr>
            <? } ?>
            <tr>
              <td>Merchant <?=$data['store_name'];?></td>
                
              
              <td><a href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?action=select&type=active&store_active=<?=($data['approvedStore']['merID']);?>" target="_blank" class="btn btn-primary btn-sm my-1">Approved
                <?=$data['store_name'];?>
                <span class="badge bg-vdark">
                <?=($data['approvedStore']['count']);?>
                </span></a> <a href="<?=$data['Admins']?>/merchant<?=$data['ex']?>?action=select&type=active&store_active=<?=($data['underReviewStore']['merID']);?>" target="_blank" class="btn btn-primary btn-sm my-1">Under review
                <?=$data['store_name'];?>
                <span class="badge bg-vdark">
                <?=($data['underReviewStore']['count']);?>
                </span></a> </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<? }else{ ?>
SECURITY ALERT: Access Denied
<? } ?>
