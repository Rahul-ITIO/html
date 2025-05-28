<? if(isset($data['ScriptLoaded'])){ ?>


	
	  <!-- Start Form -->
		   
		  <div id="content">
			<ul class="breadcrumb">
			  <li><a href="index.do" class="glyphicons home"><i></i>
			  <?=prntext($data['SiteName']);?>
			  </a></li>
			  <li class="divider"></li>
			  <li>Security Center</li>
			</ul>
			<div class="separator"></div>
			<div class="heading-buttons">
			  <h3 class=""><i></i> Security Settings</h3>
			  <div class="clearfix" style="clear: both;"></div>
			</div>
			<div class="separator"></div>
			  <div class="well">
				<?php if($data['Error']){?>
				<div class="alert alert-error">
				  <button type="button" class="close" data-dismiss="alert">&times;</button>
				  <strong>Error!</strong>
				  <?=prntext($data['Error']);?>
				</div>
			   <?}?>
				<div class="tab-pane active" id="account-settings">
				  <div class="widget widget-2">
					<div class="widget-head">
					  <h4 class="heading glyphicons settings"><i></i>Password Reset</h4>
					</div>
				  </div>
				</div>
				
  					<div class="alert alert-success">
   						 <strong>Success!</strong><br> New password has been sent to registered 
						 email ID: <?=$post['email'];?>
					</div>
	
  
<?}else{?>
  SECURITY ALERT: Access Denied
<?}?>