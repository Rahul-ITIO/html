//alert('ok \r\n'+document.cookie);

$(document).ready(function(){
	

	/*
	
   $('a[href],a[data-url]').click(function(e){
	   var thisHref=$(this).attr('href');
		var heightVar="300px"; 
		if(con_name=='clk'){
			heightVar="500px";
			$('#modal_popup_popup_body2Id').removeClass('modal_popup_html2');
			$('#modal_popup_popup_body2Id').addClass('modal_popup_html3');
		}
		
		if($(this).hasClass('nopopup')){
			
		}else{
			
			var urls=hostName+"/include/session_check.php";
			//alert('UID : '+uid_var+'\r\nthisHref : '+thisHref+'\r\nurls : '+urls);
				$.ajax({
					url: urls,
					type: "POST",
					dataType: 'json', 
					data: "action=get&json=1&uid="+uid_var+"&redirect_url="+thisHref,
					success: function(results){
						if(results["uid"]>0){
							//alert('OK: '+results["uid"]);
							top.window.location.href=thisHref;
							
						}else{
							//alert('Not UID : '+uid_var+'\r\nthisHref : '+thisHref+'\r\nredirect_url : '+redirect_url);
							var redirect_url=hostName+'/index.do?redirect_url='+thisHref;
							var ulogin='<iframe src="'+redirect_url+'" name="modal_popup_iframe2" id="modal_popup_iframe2" frameborder="0" marginwidth="0" marginheight="0" class="modal_popup_iframe" width="100%" height='+heightVar+' allowtransparency="true" scrolling="no"></iframe>';
							$('#modal_popup_popup_body2Id').html(ulogin);
							$('#modal_popup_popup2').addClass('ulogin');
							$('#modal_popup_popup2').slideDown(900);
							//return false;
						}
					}
				});
			return false;
			
			
		}
	});
			
	*/

});

