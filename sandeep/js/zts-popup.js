function ztspaypopupf(){
	$("#popup_button").click(function(){
        $(".popup").show();
    });
	$(".popup_close").click(function(){
        $(".popup").hide();
   });
}
function ztspaypopupapend(){
 $("body").append("<div class=popup id=popup><div class=popup_layer> </div><div class=popup_body><a class=popup_close>&times;</a><iframe src=about:blank name=iframe id=iframe frameborder=0 marginwidth=0 marginheight=0 class=iframe width=100% height=400></iframe></div></div><style>.popup {display:none; position:fixed;z-index:999999; top: 0; left: 0;}.popup_layer {display:block; position:fixed; z-index:999999; width:100%; height:100%; background:#000; opacity:0.5; top:0; left:0; }.popup_body {display:block; position:fixed; z-index:9999999; width:70%; height:400px; background:#fff; opacity:1; border-radius:5px; left:15%; top:50%; margin:-200px 0 0 0; }.popup_close {position: absolute; z-index: 99; float: right; right: -20px; top: -20px; width:40px; height:40px; font: 800 40px/40px 'Open Sans'; color: #fff; background: #f30606; text-align:center; border-radius:110%; overflow:hidden; cursor: pointer;}</style>");
 ztspaypopupf();
 }
setTimeout(function(){ ztspaypopupapend(); }, 500);

 $(document).ready(function(){
    //ztspaypopupf();
});