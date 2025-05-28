<?

include('../config.do');

if(!isset($_SESSION['login'])){
	$_SESSION['redirectUrl']=$data['urlpath'];
	header("Location:{$data['Host']}/index".$data['ex']);
	echo('ACCESS DENIED.');
	exit;
}

?>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script src="<?=$data['Host']?>/theme/scripts/jquery-1.8.2.min.js"></script>
</head>
<body>
<div class="row-fluid pad20">
  <div class="span12">
    <div class="separator"></div>
    <input type=text name=subject placeholder="Enter The Full Subject" class="span10" value="<?=prntext($post[0]['subject'])?>" style="width:100%!important; height:30px;" />
    <div class="separator"></div>
    <textarea id="mustHaveId" class="span12 jqte-test" name=comments rows="5" placeholder="Enter a Message" style="width:100%; height:80px;"><?=prntext($post[0]['comments'])?>
</textarea>
    <div class="separator"></div>
    <button type=submit name=send value="CONTINUE"  class="btn btn-icon btn-primary glyphicons circle_ok "><i></i>Submit</button>
  </div>
</div>
<link rel="stylesheet" type="text/css" href="<?=$data['Host']?>/js/jquery-te-1.4.0.css"/>
<script src="<?=$data['Host']?>/js/jquery-te-1.4.0.min.js"></script>
<script>
	$('.jqte-test').jqte();
</script>
</body>
</html>
