var urlset ='';
 //		/api/3d29/processed_list.do?pq=1&type=27
 urlset =	top.window.location.href;
 
setInterval(function(){
	if(urlset){
		top.document.location.href=urlset;
	}
}, 120000);