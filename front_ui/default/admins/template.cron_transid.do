<? if(isset($data['ScriptLoaded'])){?>

<?
if((!isset($_SESSION['login_adm']))&&(!$_SESSION['useful_link'])){
	echo $data['OppsAdmin'];
	exit;
}
?>


<style type="text/css">
.separator {display:none;}
.jqte {width:100% !important;float:left;margin:7px 0;}
.no_input{border:0!important;background:transparent!important;box-shadow: inset 0 0px 0px rgba(0,0,0,0.075) !important;}
</style> 



<style>
	.tb1 {border:1px solid #ccc;}
	.tb1 th td{font-size: 14px;}
	.tb1 td {border-top: 1px solid #ccc;border-right: 1px solid #ccc;font-size:12px;}
	
.copyLink{float:left;width:96%;text-align:left;height:40px;margin:10px 0;background:#eee;line-height:40px;padding:0 2%;text-transform:uppercase;font-weight:bold;}
body{font-family: 'PT Sans', sans-serif;font-size: 14px;}


/* start: tabel excel  */
.tbl_exl {width: 93vw;overflow:scroll;max-height: 500px;margin: 0 auto;float: left;}
.tbl_exl table {position:relative;border:1px solid #ddd;border-collapse:collapse;max-width: inherit;}
.tbl_exl td, .tbl_exl th, .dtd {white-space:nowrap;border:1px solid #ddd;padding: 0px 10px;text-align:left;}
.tbl_exl th {background-color:#eee !important;position:sticky;top:-1px;z-index:2; &:first-of-type {left:0;z-index:3;} }
.tbl_exl tbody tr td:first-of-type{background-color:#eee;position:sticky;left:-1px;text-align:left;}
.dtd {display:table-cell;}
/* end: tabel excel  */
</style>
<script>
	var wn='';
	<? if(isset($_REQUEST['wn'])) { ?>
		wn='<?=@$_REQUEST['wn']?>';
	<?}?>
</script>



<div class="container border my-1 vkg rounded">
	<h2 class="my-2"><i class="<?=$data['fwicon']['link'];?>"></i> Status Update one by one via TransID with comma separated values.  :: <?=@$post['print_mem']?></h2>


<?if(isset($post['csv_file_on'])&&trim($post['csv_file_on'])){?>
<hr/>

<form method="post" target="_blank" style="padding: 0;margin: 0;display: inline-block;">
    <input type="hidden" name="download" value="1" />
   
    <textarea class="hide" style="display:none" name="downloadHtml_1" id="downloadHtml_1" ><?=@$post['downloadHtml_1'];?></textarea>
	
    <textarea class="hide" style="display:none" name="downloadHtml" id="downloadHtml" ></textarea>
    <br/>
   
	
    
   
	
   
    <button type="submit" name="send" value="send" class="btn btn-sm btn-primary showbutton ms-2 mb-2 float-endX" title="Download to Log" data-bs-toggle="tooltip" data-bs-placement="top" /><i class="<?=$data['fwicon']['download'];?> fa-fw"></i>Download Logs</button>

    <a class="btn btn-sm btn-primary showbutton ms-2 mb-2" data-bs-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="true" aria-controls="multiCollapseExample1">View Logs</a>


    <a class="btn btn-sm btn-primary ms-2 mb-2" href="<?=@$data['urlpath']?>" >Upload CSV File</a>


    <br/><br/>
    <div class="row">
        <div class="col-sm-12">
            <div class="collapse multi-collapse show" id="multiCollapseExample1">
                <div class="card card-body" style="word-break: break-all;">
                    <?=@$post['downloadHtml_1']?><hr/><br/>
					<div id="res_div_id"> </div>
                </div>
            </div>
        </div>
    </div>
   
</form>
<hr/>
<?}
else {
?>

<form method="post" id="myPostForm" name="data" enctype="multipart/form-data" style="text-align:center;padding:20px 0px; ">
<?if(isset($_GET['qr'])){
  $input_name='qr';
}else{
	$input_name='s';
}	
?>

<? if((isset($data['Error'])&& $data['Error'])){ ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Error!</strong>
      <?=prntext($data['Error'])?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <? } ?>

<div class="sm-col-12" style="text-align:left;">Upload the file in csv format with first column TransID :</div> 
<input type="file" class="form-control px-2  my-2 fileUpload" style="height:35px;"  name="file" title="Upload CSV File" placeHolder="Upload CSV File" >
<br/>



<textarea name='trans_ids' placeHolder='Enter TransID with comma separated values' style='width:100%;height:96px;clear:both;
'><?=@$post['trans_ids'];?></textarea>
 
 <br/><br/>
<input class="btn btn-sm btn-primary showbutton ms-2 mb-2" type='submit' name='submit' value='Submit' style="font-weight:bold;" />
</form>
<br/>
<hr/>


<?
}
?>
<?=print_mem();?>

</div>

<div id="trans_url_load_content"> </div>
<div id="trans_url_status"> </div>

<div id="trans_url_load_content_2"> </div>
<div id="trans_url_status_2"> </div>

<script>

function isValidJSON(str) {
    try {
        JSON.parse(str);
        return true;
    } catch (e) {
        return false;
    }
}

function stringifyf(theValue){
	var theVal='';
	if (typeof theValue == 'object') { 
		theVal=JSON.stringify(theValue);
		//console.log(theVal); 
	}
	else{
		theVal=(theValue);
	}
	
	return theVal;
}

$(document).ready(function() {
	
 var valuesArray = "<?=implode(",",@$_SESSION['t_id_all'])?>";
 var subQuery_javascript = "<?=$post['subQuery_javascript']?>";
 var subQuery_jsonEncode=<?=@$post['subQuery_jsonEncode']?>;

 var downloadHtml3_APPROVED = '';
 var downloadHtml3_DECLINED = '';
 var downloadHtml3_EXPIRED = '';
 var downloadHtml3_PENDING = '';
 var downloadHtml3_NOTFOUND = '';

 if(wn){ alert("valuesArray=> "+valuesArray+"\r\n subQuery_javascript=> "+subQuery_javascript); }
/*
// 411769858,411769313,411769205,401767626,401766845,401765827
//411769858,411769313,411769205,  
//401767626,401766845,401765827
*/

	function status_one_by_one(){

		/*
		var valuesArray = $('.echeckid:checked').map(function () {  
			return this.value;
		}).get().join(",");
		

		
		var sub_qr_2 =  "<?=http_build_query(@$_GET)?>";

		if (sub_qr_2 == null || sub_qr_2 == "") {
			sub_qr_2 = "&"+sub_qr_2;
		}

		*/

		
		//Creating Array to execute one by one
		var ary=new Array();
		ary = valuesArray.split(",");
		var count=ary.length;
		my_value="<center>Total Length: "+count+"</center>";
		my_value="<br><br><center> Total TransID. Length: "+count+"</center>";
		$('#modal_popup_iframe_div').html(my_value);
		
		

			if (valuesArray == null || valuesArray == "") {
				alert("Can not process due to transID is empty");
				return false;
			} else {
				
				$('#modal_popup_popup').slideDown(900);
				popuploadig();
				var i=0;
				
				

				if(count>0)
				{
									
					function load_f() {
						c=i+1;
						if(wn){ alert("ary=>"+ary[i]+", i=>"+i+", c=>"+c); }

						console.log("===================TransID=> "+ary[i]+" | count=> "+count+" | i=> "+i+" | c=> "+c+"=====================================");

						var subparameter2 = "<?=$data['Host'];?>/status<?=$data['ex']?>?transID="+ary[i];
						
						var thisurls=subparameter2+subQuery_javascript;
						 
						thisurls=thisurls.replace(/\s+/g, '+');
						console.log(thisurls);


						var thisData=subQuery_javascript;

						logs_thisData=thisurls;
						
						if(wn){
 							alert("count=> "+count+"\r\n thisurls=> "+thisurls);
						}

						
						
						response="<center><br>In Process... "+c+" - "+ary[i]+"<br><br><b>Do not close the window. Please wait...</b></center><br>";
						if (c==count){response="<center><br>All Process completed.<BR><BR>You may close the Window.</center>";}
						
						if(wn==3){
							popupclose();window.open(thisurls, '_blank');return false;
						}
						
						//return false;

						//popupclose();window.open(thisurls, '_blank');return false;

						
						// start - check status via transID

						if (thisurls.indexOf("http://") == 0 || thisurls.indexOf("https://") == 0) 
						{

						$("#trans_url_load_content").load(thisurls, subQuery_jsonEncode, function(responseText, statusTxt, jqXHR)
						{
							 acquirer_status='';

							if(statusTxt == "success"){

								if(responseText){
									responseText = ($.trim(responseText.replace(/[\t\n]+/g, '')));

									// Convert JSON string to JavaScript object
									if (isValidJSON(responseText)) {
										var data = JSON.parse(responseText);
										if(wn==2){
											console.log(data);
										}
									}
									else {
										var data = '';
									}
									
								}
								console.log(responseText);
								console.log(statusTxt);
								if(wn==2){
									console.log(jqXHR);
								}

								

								if(stringifyf(data['acquirer_status_code'])) { 
									var acquirer_status_code = stringifyf(data['acquirer_status_code']);

									/*
									if(acquirer_status_code==2){
										acquirer_status='Approved';
										if(downloadHtml3_APPROVED) {
											downloadHtml3_APPROVED = downloadHtml3_APPROVED+","+ary[i];
										}
										else {
											downloadHtml3_APPROVED = ary[i];
										}
										
									}
									else if(acquirer_status_code==1){
										acquirer_status='Pending';

										if(downloadHtml3_PENDING) {
											downloadHtml3_PENDING = downloadHtml3_PENDING+","+ary[i];
										}
										else {
											downloadHtml3_PENDING = ary[i];
										}
										
									}
									else if(acquirer_status_code==22){
										acquirer_status='Pending';

										if(downloadHtml3_EXPIRED) {
											downloadHtml3_EXPIRED = downloadHtml3_EXPIRED+","+ary[i];
										}
										else {
											downloadHtml3_EXPIRED = ary[i];
										}
										
									}
									else if(acquirer_status_code==-1){
										acquirer_status='Failed';
										if(downloadHtml3_DECLINED) {
											downloadHtml3_DECLINED = downloadHtml3_DECLINED+","+ary[i];
										}
										else {
											downloadHtml3_DECLINED = ary[i];
										}
									}else {
										acquirer_status='Expired';

										if(downloadHtml3_EXPIRED) {
											downloadHtml3_EXPIRED = downloadHtml3_EXPIRED+","+ary[i];
										}
										else {
											downloadHtml3_EXPIRED = ary[i];
										}
									}

									*/

									if(acquirer_status){ console.log(acquirer_status); }
									console.log(acquirer_status_code); 
									
								}

								if(stringifyf(data['acquirer_response'])) { 
									acquirer_response = stringifyf(data['acquirer_response']); 
									if(wn==2){
										console.log(acquirer_response);
									}
								}
								
								if(stringifyf(data['transID'])) { 
									transID = stringifyf(data['transID']); 
									console.log(transID);
								}
								else {
									transID = ary[i];
								}


								// start - return_url load after getting the response of status via transID
								if(stringifyf(data['return_url'])) { 
									return_url = stringifyf(data['return_url']); 
									console.log(return_url);
									if(data && (statusTxt == "success")){
										$("#trans_url_load_content_2").load(return_url, data, function(responseText_2, statusTxt_2, jqXHR_2){

											if(responseText_2 && (statusTxt_2 == "success"))
											//if(responseText_2 )
											{

												console.log('responseText_2');
												console.log(responseText_2);

												// response of return url as a  Convert JSON string to JavaScript object
												if (isValidJSON(responseText_2)) {
													var data_2 = JSON.parse(responseText_2);
													console.log(data_2);
												}
												else {
													var data_2 = '';
												}


												if( data_2 && stringifyf(data_2['order_status'])) 
												{ 
													var	order_status = stringifyf(data_2['order_status']);
													if(order_status==1){
														acquirer_status='Approved';
														if(downloadHtml3_APPROVED) {
															downloadHtml3_APPROVED = downloadHtml3_APPROVED+","+transID;
														}
														else {
															downloadHtml3_APPROVED = transID;
														}
														
													}
													
													else if(order_status==22){
														acquirer_status='Expired';

														if(downloadHtml3_EXPIRED) {
															downloadHtml3_EXPIRED = downloadHtml3_EXPIRED+","+transID;
														}
														else {
															downloadHtml3_EXPIRED = transID;
														}
														
													}
													else if(order_status==2 || order_status==23 || order_status==24){
														acquirer_status='Failed';
														if(downloadHtml3_DECLINED) {
															downloadHtml3_DECLINED = downloadHtml3_DECLINED+","+transID;
														}
														else {
															downloadHtml3_DECLINED = transID;
														}
													}
													else if(order_status==0){
														acquirer_status='Pending';

														if(downloadHtml3_PENDING) {
															downloadHtml3_PENDING = downloadHtml3_PENDING+","+transID;
														}
														else {
															downloadHtml3_PENDING = transID;
														}
														
													}
													else {
														acquirer_status='Expired';

														if(downloadHtml3_EXPIRED) {
															downloadHtml3_EXPIRED = downloadHtml3_EXPIRED+","+transID;
														}
														else {
															downloadHtml3_EXPIRED = transID;
														}
													}

													if(acquirer_status){ console.log(acquirer_status); }
													console.log(order_status); 

													$("#trans_url_status_2").html("<h2>Notify Pushed Successfully --\> Via Webhook......</h2>");
														
												}
											}
											else if(statusTxt_2 == "error")
											{

												acquirer_status='NOT FOUND';

												if(downloadHtml3_NOTFOUND) {
													downloadHtml3_NOTFOUND = downloadHtml3_NOTFOUND+","+transID;
												}
												else {
													downloadHtml3_NOTFOUND = transID;
												}

											}


											// timer start every 2 second ----------------
											
											results="<center><br>Result=> <b>"+transID+" - "+acquirer_status+"</b><br></center><br>";
											$('#modal_popup_iframe_div').html(my_value+response+results);
											if( i < count ){setTimeout( load_f, 2000 );}


											if (c==count){
												//$("#downloadHtml").after('<textarea class="hide" style="display:none" name="downloadHtml3" id="downloadHtml3">'+downloadHtml3_APPROVED+'</textarea>');
												var html ='';
												html +=  "<==APPROVED==>\r\n"+downloadHtml3_APPROVED+"\r\n\r\n";
												html +=  "<==DECLINED==>\r\n"+downloadHtml3_DECLINED+"\r\n\r\n";
												html +=  "<==EXPIRED==>\r\n"+downloadHtml3_EXPIRED+"\r\n\r\n";
												html +=  "<==PENDING==>\r\n"+downloadHtml3_PENDING+"\r\n\r\n";
												if(downloadHtml3_NOTFOUND){
													html +=  "<==NOTFOUND==>\r\n"+downloadHtml3_NOTFOUND+"\r\n\r\n";
												}

												html = html.replace(/undefined/g, "");

												$("#downloadHtml").val(html);
												html = html.replace(/\r\n/g, "<br />");
												
												$("#res_div_id").html(html);

												setTimeout(function(){
													$('#modal_popup_popup').slideUp(70);
													popupclose();
												}, 3000 );
											}
											
											// timer end every 2 second ----------------

											
										});
									}
								}
								// end - return_url load after getting the response of status via transID
			
								
								$("#trans_url_status").html("<h2>Successfully --\> Fetch Status......</h2>");
							}
							if(statusTxt == "error"){
								$("#trans_url_status").html("<h2>Error in fetch the status ......</h2>");
							}

							/*

							results="<center><br>Result=> <b>"+transID+" - "+acquirer_status+"</b><br></center><br>";
							$('#modal_popup_iframe_div').html(my_value+response+results);
							if( i < count ){setTimeout( load_f, 2000 );}

							
							
							if (c==count){
								//$("#downloadHtml").after('<textarea class="hide" style="display:none" name="downloadHtml3" id="downloadHtml3">'+downloadHtml3_APPROVED+'</textarea>');
								var html ='';
								html +=  "<==APPROVED==>\r\n"+downloadHtml3_APPROVED+"\r\n\r\n";
								html +=  "<==DECLINED==>\r\n"+downloadHtml3_DECLINED+"\r\n\r\n";
								html +=  "<==EXPIRED==>\r\n"+downloadHtml3_EXPIRED+"\r\n\r\n";
								html +=  "<==PENDING==>\r\n"+downloadHtml3_PENDING+"\r\n\r\n";
								html = html.replace(/undefined/g, "");

								$("#downloadHtml").val(html);
								html = html.replace(/\r\n/g, "<br />");
								
								$("#res_div_id").html(html);

								setTimeout(function(){
									$('#modal_popup_popup').slideUp(70);
									popupclose();
								}, 3000 );
							}
							*/
						});
					}	
					// end - check status via transID
					

						/*
							$.ajax({
								//type: "POST",
								url: thisurls,
								//data: thisData,
								//dataType: 'json', // text
								success: function(data) {
								if(wn){ alert("thisurls=> "+thisurls); }

								logs=data;
								

								if(stringifyf(data['transID'])) { transID = stringifyf(data['transID']); }

								results="<center><br>Result=> <b>"+transID+"</b><br></center><br>";
								$('#modal_popup_iframe_div').html(my_value+response+results);
								if( i < count ){setTimeout( load_f, 2000 );}
								
								if (c==count){
									setTimeout(function(){
										$('#modal_popup_popup').slideUp(70);
										popupclose();
									}, 3000 );
								}
								
							},
							error: function(data) {
								//data = ($.trim(data.replace(/[\t\n]+/g, '')));
								// Some error in ajax call
								//alert("ajaxFormf request");
								logs=data;
								//alert(stringifyf(data)); alert(stringifyf(data['responseText']));
								
								var responseText = stringifyf(data['responseText']);
								
								if( typeof(responseText) != 'undefined' && responseText != null && responseText !="" && responseText.match('error|Error|Scrubbed') ) {
									ErrorVar=responseText;
									alert(responseText);
								}
								else {
									alert("some Error via request");
								}
								spinner_hide_f();
							}
						
							});
							
						*/	

						i++;
						
					}// End Fnction load_f

					
					load_f();
				
				}
			}
	}
<?if(isset($_POST['submit']))
{?>	
	status_one_by_one();
<?}?>	

});
</script>

<? }else{?>
	SECURITY ALERT: Access Denied
<? }?>