<?
$config_root='config_root.do';
if(file_exists($config_root)){include($config_root);}
//echo "<br/>Host2=>".$data['Host']; echo "<br/>urlpath2=>".$urlpath;


//echo "<br/>urlpath=>".$data['urlpath']; echo "<br/>HTTP_REFERER=>".$_SERVER['HTTP_REFERER'];

//if(strpos($data['urlpath'],"payme/")!==false){ header("Location:".$data['urlpath']."/"); }

?>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- Favicon -->
<meta name="msapplication-TileImage" content="<?=$data['Host'];?>/favicon_oops.png"> <!-- Windows 8 -->
<meta name="msapplication-TileColor" content="#00CCFF"/> <!-- Windows 8 color -->
<!--[if IE]><link rel="shortcut icon" href="<?=$urlpath;?>/favicon_oops.ico"><![endif]-->
<link rel="icon" type="image/png" href="<?=$data['Host'];?>/favicon_oops.png">

<div class="text-center"><img src="<?=$data['Host'];?>/images/oops.png" class="img-fluid"/></div>