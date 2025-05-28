$(document).ready(function(){
						   
	/*for Display details box*/
	$(".data_display").click(function() {
	var v = $(this).closest("div.content").find("input[name='data_div']").val();
	$("#display-small-screen").show();
	$("#display-small-screen").html(v);
	$("#display-large-screen").hide();
	});
	
	// for detail display on modal
	
	 $('.tr_open_on_modal').click(function(){
										   
		var countNo=$(this).attr('data-count');
		var detailHtml=$('.next_tr_'+countNo).html();
		var Modtitle=$('.next_tr_'+countNo).find('.mboxtitle').html();
		
		$('#myModal .modal-dialog').css({"max-width":"600px"});
		$('#myModal .modal-content').addClass("bg-primary text-white");
		$('#myModal .modal-title').html(Modtitle);
		$('#myModal .modal-body').html(detailHtml);
		
		$('#myModal').modal('show');
	});
	 
	 
	
	       /* // For Action Menu short and large
			$(window).bind("load resize scroll",function(){
			if ($(window).width() < 768) {
			alert('Less than 768');
			//changeactionbyjs
			}else{
			alert('Less Grather 768');
			}
			});*/
	 
       // for Active main Menu when inner menu click
     $('.active_ap').parent().prev().addClass('activmainmenu');
	 
 
	 
});

		// js for copy data
		function CopyVal(text,theLabel) {
		   text=$(text).html();
		   //alert(text);
			var $txt = $('<textarea />');

            $txt.val(text)
                .css({ width: "1px", height: "1px" })
                .appendTo('body');

            $txt.select();

            if (document.execCommand('copy')) {
                $txt.remove();
				alert("Copied : " + theLabel);
            }
		
		}
		
		


	/*for close details box*/
	function dataclose(){
	$("#display-small-screen").hide();
	$("#display-large-screen").show();
	}
	
	//for close toast box
	function toastclose(boxcss){
	$(boxcss).hide();
	}
	


/*!
 * Color mode toggler for Bootstrap's docs (https://getbootstrap.com/)
 * Copyright 2011-2022 The Bootstrap Authors
 * Licensed under the Creative Commons Attribution 3.0 Unported License.
 */

(() => {
  'use strict'

  const storedTheme = localStorage.getItem('theme')

  const getPreferredTheme = () => {
    if (storedTheme) {
      return storedTheme
    }

    return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
  }

  const setTheme = function (theme) {
    if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      document.documentElement.setAttribute('data-bs-theme', 'dark')
    } else {
      document.documentElement.setAttribute('data-bs-theme', theme)
    }
  }

  setTheme(getPreferredTheme())

  const showActiveTheme = theme => {
    const activeThemeIcon = document.querySelector('.theme-icon-active use')
    const btnToActive = document.querySelector(`[data-bs-theme-value="${theme}"]`)
    const svgOfActiveBtn = btnToActive.querySelector('vgg use').getAttribute('href')

    document.querySelectorAll('[data-bs-theme-value]').forEach(element => {
      element.classList.remove('active')
    })

    btnToActive.classList.add('active')
    activeThemeIcon.setAttribute('class', svgOfActiveBtn)
  }

  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
    if (storedTheme !== 'light' || storedTheme !== 'dark') {
      setTheme(getPreferredTheme())
    }
  })

  window.addEventListener('DOMContentLoaded', () => {
    showActiveTheme(getPreferredTheme())

    document.querySelectorAll('[data-bs-theme-value]')
      .forEach(toggle => {
        toggle.addEventListener('click', () => {
          const theme = toggle.getAttribute('data-bs-theme-value')
          localStorage.setItem('theme', theme)
          setTheme(theme)
          showActiveTheme(theme)
        })
      })
  })
})()



