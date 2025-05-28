<? if((isset($data['ACCOUNT_MANAGER_ENABLE'])&&@$data['ACCOUNT_MANAGER_ENABLE']=='Y'&&isset($_SESSION['m_acc_man']['manager_name'])))
    { ?>
		<div title="Account Manager : <?=@$_SESSION['m_acc_man']['manager_name'];?>" class="my-2 btn btn-primary btn-sm text-white  mx-1" id="acc_manag" data-bs-toggle="dropdown" aria-expanded="false" style="position: relative;"> 
					<img src="../images/account_manager_icon_1.png" style="height:20px;" />
          
            <div class="dropdown-menu" aria-labelledby="acc_manag" style="min-width: 210px !important;">
                <div class="visiting_container  ">
                    <div class="visiting_header">
                        <h3 style="font-size: 16px !important;">Account Manager</h3>
                    </div>
                    <div class="visiting_profile">
                        <img src="../images/account_manager_icon_1.png" style="height:44px;width:auto;" class="visiting_image">
                        <div class="visiting_info">
                            <h3><?=@$_SESSION['m_acc_man']['manager_name'];?></h3>
                        </div>
                    </div>
                    <div class="visiting_details"><?=@$_SESSION['m_acc_man']['am_icon'];?></div>
                </div>
            </div>

        </div>
<? }?>
