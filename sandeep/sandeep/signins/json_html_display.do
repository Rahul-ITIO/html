<? 
include('../config_db.do');
?>
<style>
textarea {height: 100px;}
.border-primary {border-color: var(--background-1)!important;}
.btn .fa-solid.fa-copy { color:unset !important;}
</style>

<?
if(isset($_REQUEST['strip'])){
	$array = htmlentitiesf($_REQUEST['json']);
}else{
	if(isset($_REQUEST['json'])&&$_REQUEST['json']) $array = htmlentitiesf($_REQUEST['json']);
	else $array ='';
}



// Call Function for multi / inner lavel Data
function get_multi_array_json_data($array){
$result="";

                  
			        foreach ($array as $data=>$value) {
						if(is_array($value)){
						$result.=$data." data :: \r\n";
						$result.=get_multi_array_json_data($value);
						}else{
						$result.=$data." : ".$value."\r\n";
						}
					} 
				  
				  return $result;

}

// Call Function for single / first lavel Data
function get_single_array_json_data($array){
$result="";
global $cnt;

                  if(count($array)>0){
				  
			      foreach ($array as $data=>$value) {
				  
					  if(is_array($value)){
					  //$result.=$data." : ".$value."\r\n";
					  $result=$data." data :: \r\n";
					  $result.=get_multi_array_json_data($value);
					  }else{
					  $result.=$data." : ".$value."\r\n";
					  }  
					  
					 
				  }
				  return "<textarea class='form-control' id='php".$cnt."'>".$result."</textarea>";
				  
				  }else{
				  
				  //$result.=" : No Value \r\n";
				  return $result;
				  
				  }
				  
}

// function/////////////

$json = decryptres($array);


$data = json_decode($json,1);
//print_r($data);

$tstamp=$data['post']['TIMESTAMP'];
$reference=$data['post']['reference'];
$gdata="";
$cnt=1;


if (count($data)) {
            
            foreach ($data as $fdata=>$fvalue) {
			
			     if(is_array($fvalue)){
				 
			     echo "<h6 class='btn btn-outline-primary w-100 text-start mt-2'>".$fdata."<span class='float-end pe-5'>#".$cnt++."&nbsp;&nbsp;<i class='fa-solid fa-copy text-primary myclick' tdata='php".$cnt."'></i></a></span></h4>";
			     echo get_single_array_json_data($fvalue);
			
			     }else{
				 
                 $gdata.=$fdata." : ".$fvalue."\r\n";
				 
				 }
            }
			
		    echo "<h6 class='btn btn-outline-primary w-100 text-start mt-2'> Other Data <span class='float-end pe-5'>#".$cnt++."&nbsp;&nbsp;<i class='fa-solid fa-copy text-primary myclick' tdata='php".$cnt."'></i></a></span></h4>";
            echo "<textarea class='form-control' id='php".$cnt."'>".$gdata."</textarea>";
            
            
        }




?>
<script>
var titles="<?=$reference.' :: '.$tstamp;?>";
$('#myModal9 .modal-title').html(titles);

$(".myclick").on('click', function() {
  var tdata =  "#" + $(this).attr('tdata');
    $(tdata).select();
    document.execCommand('copy');
	alert("Copied");
 });
</script>


