<? 
//this file will we used for showing image
include('config.do');//include config.do
###############################################################################
//if(!$_SESSION['adm_login']&&!$_SESSION['login']){

//if authentication is not set then use will redirect to index page and denying for further access
if((!isset($_SESSION['login']))&&(!isset($_SESSION['adm_login']))){
	header("Location:{$data['Host']}/index{$data['ex']}");
	echo('ACCESS DENIED.');
	exit;
}
$is_admin=false;
// if login condition will met then code will be executed
if($_SESSION['adm_login']&&isset($_GET['admin'])&&$_GET['admin']){
	$is_admin=true;
	$data['HideAllMenu']=true;//This could be used to control the visibility of menus or navigation elements in the user interface.
	$uid=$_GET['id'];
}
###############################################################################
//this code block is used to handle the case where an image parameter is provided in the request. If a valid image parameter is found, it assigns the value to the $logo variable. If no valid image parameter is found, it displays a message and terminates the script execution.
if ((isset($_REQUEST['img']))&&(!empty($_REQUEST['img']))){
	$logo=$_REQUEST['img'];}
	else {echo "<center>No Imgage Found!</center>";
	exit;}
?>
<div id="show_img"></div>

<script>
/*The given JavaScript function, getXMLHttp(), is used to create and return an XMLHttpRequest object, which is essential for making asynchronous HTTP requests from the browser to a server. This function is used to handle different browser environments and create the appropriate XMLHttpRequest object based on the browser's capabilities*/
function getXMLHttp()
{
  var xmlHttp

  try
  {
    //Firefox, Opera 8.0+, Safari
    xmlHttp = new XMLHttpRequest();
  }
  catch(e)
  {
    //Internet Explorer
    try
    {
      xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch(e)
    {
      try
      {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      catch(e)
      {
        alert("Your browser does not support AJAX!")
        return false;
      }
    }
  }
  return xmlHttp;
}

//this function will be used for showing image
function show_image(imgname){  

 var xmlHttp = getXMLHttp();  
  xmlHttp.onreadystatechange = function()
  {
    if(xmlHttp.readyState == 4)
    {
      HandleResponse(xmlHttp.responseText);
    }
  }
  xmlHttp.open("GET", "<?=$data['Host']?>/include/ajax<?=$data['ex']?>?img="+imgname+"&type=decriptimg", true); 
  xmlHttp.send(null);
}// End Function



//this function will be used for handle the response
function HandleResponse(response){
	document.getElementById('show_img').innerHTML = response;
}// End Function


show_image('<?=$_REQUEST['img']?>');
</script>