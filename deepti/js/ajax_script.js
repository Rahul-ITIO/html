//function allScriptCheck(){
	if(window.name!="index"){ // window.name!="index" parent.window.name=="index"
		//alert("getIframeUnique: "+parent.window.getIframeUnique+"\r\n parentWindowName: "+parent.window.name+"\r\n currentWindowName: "+window.name);
	   
		//  for get current javascript src path, define all function and set to parent window by iopajax
		
		var theHead				=	parent.window.document.getElementsByTagName("HEAD")[0]; // HEAD  BODY
		var theSrcHead			=	parent.window.document.getElementsByTagName("HEAD")[0];
		var newScript 			= 	parent.window.document.createElement('script');
	    	newScript.type 		= 	"text/javascript";
	    	    	
	    var allInnerText;  var allSrcPath;
		var allScript=document.getElementsByTagName("script");
		if(allScript!=null){
			for(var i=0; i<allScript.length; i++){
				if(allScript[i].type=="text/javascript"){
					allInnerText		=	allInnerText+allScript[i].innerHTML+"\r\n";
				}
			}
			newScript.text 	= allInnerText;
			theHead.appendChild(newScript);
		}
		// end
		//  for get current style styleSheet and set to parent window by iopajax
		
		var styleHead				=	parent.window.document.getElementsByTagName("HEAD")[0];
		var newStyle 				= 	parent.window.document.createElement("style");
			newStyle.type 			= 	"text/css";
			newStyle.setAttribute("type", "text/css");
			//newStyle.rel 			= 	"stylesheet";
			//ss.href 			= 	"style.css";
		
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
		
	 //  end of get current style styleSheet and set to parent window by iopajax
	}
//};window.onload=allScriptCheck();