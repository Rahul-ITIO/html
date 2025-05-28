<? if(isset($data['ScriptLoaded'])){ ?>


<div class="container border bg-white vkg">
  <h1 class="my-2"><i class="<?=$data['fwicon']['email-template'];?>"></i> Search By Criterion</h1>

  
  <div class="vkg-main-border"></div>
  
  <? if($post['action']=='search'){ ?>
  <? if (!isset($post['keyword']) || empty($post['keyword'])) {?>


    <form method="get">
      <br/>
      <input type="hidden" name="action" value="select">
	  <div class="row my-2" id="merchantsearchforcss">
      <div class="col-sm-5 ps-0">
        <div class="input-group mb-2"> <span class="input-group-text col-sm-4" id="basic-addon4">Keyword : </span>
          <input type="text" class="form-control" name="keyword" id="keyword" placeholder="" ></textarea>
          </div></div>
	   
	   <div class="col-sm-5 ps-0">
        <div class="input-group mb-3"> <span class="input-group-text col-sm-4" id="basic-addon4">Search By :</span>
          <select name="sfield" id="sfield" class="form-select" required="">
              <option value="cn">Company Name</option>
			  <option value="em">E-mail</option>
              <option value="fn">First name</option>
			  <option value="vid">ID</option>
              <option value="ln">Last name</option>
			  <option value="un">User name</option>
          </select>
        </div>
       </div>
      

      <div class="col-sm-2 ps-0">
        
          <button formnovalidate="" type="submit" name="srchbtn" value="SEARCH" class="btn btn-primary w-100">Search</button>
       
        
      </div>
    </div>
	
	
      <!--<table border="0" cellspacing="1" cellpadding="2" width="480" class="frame">
        <tr>
          <td class=capl colspan="2">PLEASE ENTER SEARCH CRITERION</td>
        </tr>
        <tr>
          <td  nowrap>Keyword:</td>
          <td  nowrap style="text-align:left"><input type="text" name="keyword" value="" style="width:250px" /></td>
        </tr>
        <tr>
          <td  nowrap>Select field:</td>
          <td  nowrap style="text-align:left"><select name="sfield" style="width:250px">
              <option value="un">User name</option>
              <option value="fn">First name</option>
              <option value="ln">Last name</option>
              <option value="em">E-mail</option>
            </select></td>
        </tr>
        <tr>
          <td align="center" colspan="2" class=capl><input type="submit" class=submit name="srchbtn" value="SEARCH" /></td>
        </tr>
      </table>-->
    </form>


  <? } ?>
  <? } ?>

  </div>

<? }else{ ?>
SECURITY ALERT: Access Denied
<? }?>
