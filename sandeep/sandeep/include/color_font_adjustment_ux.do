<script>
        $(document).ready(function () {
			
			// for change color & font size by click on box
			
			$('.hiddenbox').on('click', function () { 
            $(".colorbox-container").toggle('slide');
            });
			
			$(".change_font_size").on('click', function() {
			var dcode = $(this).attr('data-code');
			if(dcode=="plus"){
			 $("body").get(0).style.setProperty("--font-size-template","16px");
			 sessionStorage.setItem("--font-size-template", "16px");
			 
			 $("#font-plus2").removeClass("font_active");
			 $("#font-minus").removeClass("font_active");
			 $("#font-plus").addClass("font_active");
			 sessionStorage.setItem("jqr_font_active", "font-plus");
			
			}else if(dcode=="plus2"){
			$("body").get(0).style.setProperty("--font-size-template", "18px");
			sessionStorage.setItem("--font-size-template", "18px");
			
			 $("#font-plus").removeClass("font_active");
			 $("#font-minus").removeClass("font_active");
			 $("#font-plus2").addClass("font_active");
			 sessionStorage.setItem("jqr_font_active", "font-plus2");
			}else{
			$("body").get(0).style.setProperty("--font-size-template", "14px");
			sessionStorage.setItem("--font-size-template", "14px");
			
			 $("#font-plus").removeClass("font_active");
			 $("#font-plus2").removeClass("font_active");
			 $("#font-minus").addClass("font_active");
			 sessionStorage.setItem("jqr_font_active", "");
			}
			
			});
			
			let fontSizeTemplate = sessionStorage.getItem("--font-size-template");
			
			if(fontSizeTemplate){
			$("body").get(0).style.setProperty("--font-size-template", fontSizeTemplate);
			}else{
			$("#font-minus").addClass("font_active");
			}
			
			let fontActive = sessionStorage.getItem("jqr_font_active");
			
			if(fontActive=="font-plus"){
			 $("#font-plus2").removeClass("font_active");
			 $("#font-minus").removeClass("font_active");
			 $("#font-plus").addClass("font_active");
			}else if(fontActive=="font-plus2"){
			 $("#font-plus").removeClass("font_active");
			 $("#font-minus").removeClass("font_active");
			 $("#font-plus2").addClass("font_active");
			}else{
			 $("#font-plus").removeClass("font_active");
			 $("#font-plus2").removeClass("font_active");
			 $("#font-minus").addClass("font_active");
			}
			
			
			$(".change_color").on('click', function() {
			 var dcode = $(this).attr('data-code');
			 
			 //alert(dcode);
			 
			 if(dcode=="Night"){
			 $("#change_color2").addClass("icon_active");
			 $("#change_color1").removeClass("icon_active");
			 sessionStorage.setItem("jqr_icon_active", "yes");
			 sessionStorage.setItem("jqr_mode", "Night");
			 $('.h-100').addClass('night');
			 //document.documentElement.style.setProperty('--background-1', 'black');
			 }else{
			 $("#change_color1").addClass("icon_active");
			 $("#change_color2").removeClass("icon_active");
			 sessionStorage.setItem("jqr_icon_active", "");
			 sessionStorage.setItem("jqr_mode", "");
			 $('.h-100').removeClass('night');
			 }
            
            });
			
			/*let iconActive = sessionStorage.getItem("jqr_icon_active");
			let setMode = sessionStorage.getItem("jqr_mode");
			
			
			
			if(iconActive){
			 $("#change_color1").removeClass("icon_active");
			 $("#change_color2").addClass("icon_active");
			}else{
			 $("#change_color1").addClass("icon_active");
			 $("#change_color2").removeClass("icon_active")
			}
			
			if(setMode){
			 $('.h-100').addClass('night');
			}else{
			$('.h-100').removeClass('night');
			}*/

        });
		
		
    </script>
	
