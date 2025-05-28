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
			 
			 if(dcode=="Night"){
			 $("body").get(0).style.setProperty("--background-1", "<?=$_SESSION['background_gd5'];?>");
			 $("body").get(0).style.setProperty("--color-1", "#ffffff");
			 $("body").get(0).style.setProperty("--color-4", "<?=$data['tc']['hd_b_d_5'];?>");
			 $("#change_color2").addClass("icon_active");
			 $("#change_color1").removeClass("icon_active");
			 sessionStorage.setItem("jqr_background", "<?=$_SESSION['background_gd5'];?>");
			 sessionStorage.setItem("jqr_colorfirst", "#ffffff");
			 sessionStorage.setItem("jqr_colorforth", "<?=$data['tc']['hd_b_d_5'];?>");
			 sessionStorage.setItem("jqr_icon_active", "yes");
			 }else{
			 $("body").get(0).style.setProperty("--background-1", "<?=$root_background_color;?>");
			 $("body").get(0).style.setProperty("--color-1", "<?=$root_text_color;?>");
			 $("body").get(0).style.setProperty("--color-4", "<?=$data['tc']['hd_b_d_5'];?>");
			 $("#change_color1").addClass("icon_active");
			 $("#change_color2").removeClass("icon_active");
			 sessionStorage.setItem("jqr_background", "<?=$root_background_color;?>");
			 sessionStorage.setItem("jqr_colorfirst", "<?=$root_text_color;?>");
			 sessionStorage.setItem("jqr_colorforth", "<?=$data['tc']['hd_b_d_5'];?>");
			 sessionStorage.setItem("jqr_icon_active", "");
			 }
            
            });
			
			let backGroundColor = sessionStorage.getItem("jqr_background");
			let colorFirst = sessionStorage.getItem("jqr_colorfirst");
			let colorForth = sessionStorage.getItem("jqr_colorforth");
			let iconActive = sessionStorage.getItem("jqr_icon_active");
			

			
			if(backGroundColor){
			$("body").get(0).style.setProperty("--background-1", backGroundColor);
			$("body").get(0).style.setProperty("--color-1", colorFirst);
			$("body").get(0).style.setProperty("--color-4", colorForth);
			}
			if(iconActive){
			 $("#change_color1").removeClass("icon_active");
			 $("#change_color2").addClass("icon_active");
			}else{
			 $("#change_color1").addClass("icon_active");
			 $("#change_color2").removeClass("icon_active")
			}

        });
		
		
    </script>
	
