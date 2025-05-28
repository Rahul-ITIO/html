var theHead				=	top.window.document.getElementsByTagName("HEAD")[0]; 
var theSrcHead			=	top.window.document.getElementsByTagName("HEAD")[0];
var newScript 			= 	top.window.document.createElement('SCRIPT');
	newScript.type 		= 	"text/javascript";
			
var allInnerText;  var allSrcPath;
var allScript=document.getElementsByTagName("SCRIPT");
if(allScript!=null){
	for(var i=0; i<allScript.length; i++){
		if(allScript[i].type=="text/javascript"){
			allInnerText		=	allInnerText+allScript[i].innerHTML+"\r\n";
		}
	}
	newScript.text 	= allInnerText;
	theHead.appendChild(newScript);
}

var styleHead				=	top.window.document.getElementsByTagName("HEAD")[0];
var newStyle 				= 	top.window.document.createElement("style");
	newStyle.type 			= 	"text/css";
	newStyle.setAttribute("type", "text/css");

var allStyle=document.getElementsByTagName("style");
if(allStyle!=null){
	for(var i=0; i<allStyle.length; i++){
		if (newStyle.styleSheet) { // IE
			newStyle.styleSheet.cssText = allStyle[i].innerHTML;
			} else { // others
			var newStyleNode = document.createTextNode(allStyle[i].innerHTML);
			newStyle.appendChild(newStyleNode);
			}
		styleHead.appendChild(newStyle);
		//alert(allStyle[i].innerHTML+"\r\n");
	}
}

