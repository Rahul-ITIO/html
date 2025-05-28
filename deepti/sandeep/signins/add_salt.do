<?
include "../config.do";
$getgid=$_REQUEST['gid'];

/*///////////////////////////////Function///////////////////////////////*/
$data_key=[];
$data_key['parentKey']='';
function ucnamef($string) {
	$string =(preg_replace('/([^A-Z])([A-Z])/', "$1 $2", $string));
    $string =ucwords(strtolower($string));
    foreach (array('-','_',' ', '\'') as $delimiter) {
      if (strpos($string, $delimiter)!==false) {
        $string =implode(' ', array_map('ucfirst', explode($delimiter, $string)));
      }
    }
    return $string;
}
function check_array_keyf($ke){
	$ke=str_replace("[saltJson]","",$ke);
	$key=$ke;
	//echo "key=>".$key."<br/>";
	if(strpos($ke,"][")!==false){
		$ke=substr($ke, 0, -1); $ke=substr($ke, 1);
		$ke_ex=explode("][",$ke);
		//print_r($ke_ex);
		$ke_ex=(array_unique($ke_ex));
		//print_r($ke_ex);
		$key="[".implode("][",$ke_ex)."]";
	}
	return $key;
}
function is_multi_arrayf($array, $json_array_key=array(), $arrayName=''){
	global $data_key;$result="";
	$i=0;	
	foreach($array as $k => $v) {
		$i++;
		
		if(is_array($v)) {
			if(in_array($k,$json_array_key)){
				
				$data_key['parentKey']="[{$k}]";
				
			}
			
			if($arrayName){
				$key=$data_key['parentKey']."[{$arrayName}][{$k}]";
				$key=str_replace("[{$arrayName}][{$arrayName}]","[{$arrayName}]",$key);
				
			}else{
				$key=$data_key['parentKey'];
			}
			if(strpos($key,"saltJson")!==false){
				$key=str_replace("[saltJson]","",$key);
			}
			$key=check_array_keyf($key);
			$k_a1=ucnamef($k);
			
			$result.="<fieldset><legend>{$i}. {$k_a1}</legend><div class='co2' data-val=\"{$key}\">";
			$result.=is_multi_arrayf($v, $json_array_key, $k);
			
			
			
		} else { 
		
			if($arrayName){
				$key=$data_key['parentKey']."[{$arrayName}][{$k}]";
				$key=str_replace("[{$arrayName}][{$arrayName}]","[{$arrayName}]",$key);
			}else{
				
				$key="[{$k}]";
			}
			if(strpos($key,"saltJson")!==false){
				//$key=check_array_keyf($key);
			}
			
			if(strpos($k,"||")!==false){
				$pieces = explode("||", $k);
				$caption=$pieces[1];
				$kt=$pieces[0];
			}else{
				$caption=ucnamef($k);
				$kt=$k;
			}
			
/*			
$pieces = explode("||", $k);
$caption=$pieces[1]; 
if($caption==''){
$parts = preg_split('/(?=[A-Z])/', $k);
$kk=implode(' ', $parts); //Useful Functions
$caption=$kk;
}
$caption=ucwords(str_replace("_"," ",$caption));
$caption=ucwords(str_replace("-"," ",$caption));
$caption=str_ireplace(array('I D','A E S'),array('ID','AES'),$caption);

*/
			
			if(isset($_REQUEST['a'])&&$_REQUEST['a']=='p'){
				$k_typ='text';
			}else{
				$k_typ='hidden';
			}
			
			$result.="<div class='m_row'><div class='col_key'><spam title='{$kt}'>{$caption}</spam> <input type='{$k_typ}' title='Enter Paramter Name' placeholder='Enter Paramter Name' class='input_key key_focus form-control' value='{$k}'></div> <div class='col_val'><input type='text' name='val{$key}' placeholder='Enter Value' class='input_val form-control' value='{$v}'></div><a class='remove_row' title='Remove' onclick='remove_row_input(this)'>X</a></div>";
			
		}
		if(is_array($v)) {
			
			$result.="</div><div class='addMore_row'><a class='input_addMore' title='input Add More' data-val=\"{$key}\"  onclick=\"addMore_row_input(this,'{$key}')\">{$key} - Add More</a></div></fieldset>";
		}
	}
	
	return $result;
}
/*///////////////////////////////End Function///////////////////////////////*/


$json_de=array();

if($getgid==0){

if(!empty($post["tid"])) {
  $rs = db_rows("SELECT * FROM `{$data['DbPrefix']}acquirer_table`  WHERE `acquirer_id`='{$post["tid"]}' ORDER BY id DESC LIMIT 1",0);
  //echo $id=$rs[0]['id'];
  $rs = $rs[0];
  
  $acquirer_json=$rs['mer_setting_json'];
  //$jssiteidon=$rs['siteid'];
 
  //$json_value=json_decode($bank_json,true);
  
  $ac=jsondecode($rs['mer_setting_json'],true);
  $bank_salt=$ac['bank_salt']; // 1
  $acquirer_processing_json=@$ac['acquirer_processing_json']; // 2
  $bank_json=$rs['acquirer_processing_creds']; // 3
  
  //$bank_merchant_id=$rs['bank_merchant_id']; // 4.1
  //$siteid=$rs['siteid']; // 4.2
  //$bank_api_token=$rs['bank_api_token']; // 4.3
  //$hash_code=$rs['hash_code']; // 4.4
	
	//echo "<br/>bank_salt=>";print_r($bank_salt); echo "<br/>createJsonf=>";createJsonf('bank_salt',$bank_salt); exit;
	
	$json_value='';
	if($bank_salt<>''){
		$json_value=createJsonf('bank_salt',$bank_salt);
	}elseif($acquirer_processing_json<>''){
		$json_value=createJsonf('acquirer_processing_json',$acquirer_processing_json);
	}elseif($bank_json<>''){
		$json_value=createJsonf('acquirer_processing_creds',$bank_json);
	}else{
		
		/*
		if($bank_merchant_id<>''){
			$json_value=createJsonf('bank_merchant_id',$bank_merchant_id);
		}
		if($siteid<>''){
			$json_value=createJsonf('siteid',$siteid);
		}
		if($bank_api_token<>''){
			$json_value=createJsonf('bank_api_token',$bank_api_token);
		}
		if($hash_code<>''){
			$json_value=createJsonf('hash_code',$hash_code);
		}
		*/
	} 
	//echo $json_value;exit;
	if($json_value){ $json_value=isJsonEn($json_value);}
  

	if($json_value==''){echo "<div style='clear:both;'><h2><center>No Json / Data Found</h2></center></div>"; exit;} 
	$json_array_key=array();$json_arr=array();
	$json_de=$json_value;
	
	$json_arr['saltJson']=$json_de;
	//echo "<br/>saltJson=>";print_r($json_arr['saltJson']);
	//echo "<br/>array_keys=>";print_r(array_keys($json_arr['saltJson']));
	$json_array_key=array_merge(['saltJson'],(array_keys($json_arr['saltJson'])));
	//print_r($json_array_key);
	$de_josn=is_multi_arrayf($json_arr, $json_array_key);
	echo "<div class='inputJsonDiv'>".$de_josn."</div>";

}
}else{

	function isJson($string) {
	 return (json_last_error() == JSON_ERROR_NONE);
	}
	 // echo $getgid;

	  $row = db_rows("SELECT * FROM `{$data['DbPrefix']}salt_management`  WHERE id='" . $getgid . "'");
	  $bank_salt=$row[0]['bank_salt'];
		
		if(isset($_REQUEST['qp'])){
			echo $bank_salt;
		}
	 // $json_value=json_decode($bank_salt,true); 
	  $json_value=isJsonEn($bank_salt,true); 
	   
	$vald=(isJson($json_value) ? "Valid" : "NotValid");
	if($vald=='NotValid'){ echo "Check Your JSON Data";exit;}
	$json_array_key=array();$json_arr=array();
	$json_de=$json_value;
	$json_arr['saltJson']=$json_de;
	if(isset($json_arr['saltJson'])&&is_array($json_arr['saltJson']))
	$json_array_key=array_merge(['saltJson'],(array_keys($json_arr['saltJson'])),['saltJson']);
	$de_josn=is_multi_arrayf($json_arr, $json_array_key);

	echo "<div class='inputJsonDiv'>".$de_josn."</div>";

}
?>
<style>
fieldset {
  background: #fff;
}

.fieldsetFocus {
  background: #e2f8db;
}
.solast {
  background: yellow;
}

.co2 > fieldset:focus-within {
    background: #e2f8db;
}

fieldset {border-radius:3px;border:1px solid #898989;margin:5px 0;-webkit-column-break-inside: avoid;page-break-inside:avoid;break-inside:avoid;padding: 0 5px;}
fieldset fieldset {margin:1px 0;}
legend{background:#eaeaea;padding:2px 10px;font-size:16px;font-family:sans-serif;font-weight:700;border-radius:3px;margin:3px 0 10px 10px;width:auto;}
.m_row {display:block;width:100%;clear:both;}
.m_row input{width:92%;padding:3px 10px;border-radius:3px;border:1px solid #898989;height: 25px !important;}
.col_key {float:left;padding:3px 0;display:table-cell;width:calc(40% - 18px) !important;margin:3px;border:0px solid #ccc;border-radius:3px;}
.col_val{float:left;padding:3px 0;display:table-cell;margin:3px;border:0 solid #ccc;border-radius:3px}
.col_val {width: calc(58% - 18px)!important;}
fieldset .col_val {width:calc(60% - 18px)!important;}

.remove_row{float:left;padding:1px 0;display:block;width:calc(4% - 18px)!important;margin:8px 0;border:0 solid #ccc;border-radius:3px;height:20px;line-height:20px;overflow:hidden;min-width:20px;background:#ddd;text-align:center;font-size:16px;font-family:sans-serif;color:#333 !important;cursor:pointer; text-decoration:none;}

.co2{padding:0;-webkit-column-count:2;-moz-column-count:2;column-count:2;-webkit-column-gap:20px;-moz-column-gap:20px;column-gap:20px;-webkit-column-rule:1px solid #d3d3d3;-moz-column-rule:1px solid #d3d3d3;column-rule:1px solid #d3d3d3;clear:both}

fieldset fieldset  .co2 {-webkit-column-count:1;-moz-column-count:1;column-count:1;}

.addMore_row {display:block;width:100%;clear:both;text-align:right; text-decoration:none;}
.input_addMore{float:right;display:block;width:auto;margin:3px 0;border:0 solid #ccc;border-radius:3px;/*height:20px;*/line-height:20px;overflow:hidden;min-width:100px;background:#959595;text-align:center;font-size:16px;font-family:sans-serif;padding:5px 10px;color:#fff!important;cursor:pointer;/*position:relative;*/z-index:99;bottom:-14px;right:-14px;-webkit-column-break-inside: avoid;page-break-inside:avoid;break-inside:avoid; text-decoration:none;}
.input_addMore:hover,.remove_row:hover{background:#f28500;}
</style>

<script>
	function remove_row_input(e) {
		var thisVal = $(e).parent().find('.input_key').val();
		var result = confirm('Want to remove '+thisVal+'?');
		if (result) {
			$(e).parent().remove();
		}
	}
	function key_name_onfocusoutf(e) {
		var thisVal=$(e).val();
		var thisDatakey=$(e).attr('data-key');
		thisDatakey=thisDatakey.replace('[saltJson]', ''); 
		
		var count = 1; 
		var matchKey="flase";
		$($(e).parent().parent().parent().find('.key_focus:not(fieldset)')).each(function(){
			var thisCo2key=$(this).parent().parent().parent().attr('data-val');
			thisCo2key=thisCo2key.replace('[saltJson]', ''); 
			
			if(thisCo2key===thisDatakey || thisCo2key==thisDatakey){
				var getNnameVal=$(this).val();
				if(getNnameVal===thisVal || getNnameVal==thisVal){
					count = (count + 1); 
					matchKey = "OK";
					//alert("1=>"+thisVal+", loopVal=>"+getNnameVal);
					$(this).css("background", "#ffffb8");
					$(e).css("background", "#ffc47b");
					//$(e).addClass('key_focus');
				}else{
					//alert("2=>"+thisVal+", loopVal=>"+getNnameVal);
					$(e).addClass('key_focus');
					$(e).css("background", "#fff");
					$(this).css("background", "#fff");
				}
			}
		});
		if(matchKey=="OK"){
			alert(thisVal+" is match "+(count)+" times. Kindly change this key name.");
			$(e).css("background", "#ffc47b");
			
		}else{
			matchKey="flase";
			$(e).css("background", "#fff");
		}
	}
	function key_name_onclickf(e) {
		$(e).removeClass('key_focus');
	}	
	function key_name_changef(e) {
		$(e).removeClass('key_focus');
		var $input_val = $(e).parent().parent().find('.input_val');
		var $getNnameVal=$(e).val();
		if ($.isNumeric($getNnameVal)) {
		  var $addNameVal='';
		}else{
		  var $addNameVal=$getNnameVal;
		}
		var thisDatakey=$(e).attr('data-key'); 
		thisDatakey=thisDatakey.replace('[saltJson]', ''); 
		var thisVal=thisDatakey+"["+$addNameVal+"]";
		$input_val.attr('name','val'+thisVal); 
		
		
	}
	function addMore_row_input(e,thekey) {
		var thisRow="<div class='m_row'><div class='col_key'><input type='text' data-key='"+thekey+"' onkeyup='key_name_changef(this)' onfocusout='key_name_onfocusoutf(this)' onclick='key_name_onclickf(this)' title='Enter Paramter Name' placeholder='Enter Paramter Name' class='input_key key_focus' value=''></div> <div class='col_val'><input type='text' name='val"+thekey+"' placeholder='Enter Value' class='input_val' value=''></div><a class='remove_row' title='Remove' onclick='remove_row_input(this)'>X</a></div>";
		$(e).parent().prev('.co2').append(thisRow);
	}
	function add_key_name_changef(e,thisData='') {
		$($(e).parent().prev('.co2').find('.m_row')).each(function(){
			var thisDatakey=$(this).parent().attr('data-val');
			thisDatakey=thisDatakey.replace('[saltJson]', ''); 
			//console.log(thisDatakey);
			var $thisInputKey=$(this).find('.input_key');
			var $thisInputVal=$(this).find('.input_val');
			var $getNnameVal=$thisInputKey.val();
			if ($.isNumeric($getNnameVal)) {
			  var $addNameVal='';
			}else{
			  var $addNameVal=$getNnameVal;
			}
			
			$thisInputKey.attr('data-key',thisDatakey);
			$thisInputKey.attr('onkeyup','key_name_changef(this)');
			$thisInputKey.attr('onfocusout','key_name_onfocusoutf(this)');
			$thisInputKey.attr('onclick','key_name_onclickf(this)');
			//$thisInputKey.attr('name',"val"+thisDatakey+"["+$addNameVal+"]");
			
			
			$thisInputVal.attr('name',"val"+thisDatakey+"["+$addNameVal+"]");
		});
	}
	
	$( document ).ready(function() {
		$(".inputJsonDiv .input_addMore").each(function(e){
			add_key_name_changef(this,$(this).attr('data-val'));
		});
		<?if(@$data['acquirer_name'][$post["tid"]]){?>
		 $('fieldset').find('legend:contains("1. saltJson")', this).html("<?=$post['tid']?> <?=$data['acquirer_name'][$post["tid"]]?>");
		 $('fieldset').find('legend:contains("1. Salt Json")', this).html("<?=$post['tid']?> <?=$data['acquirer_name'][$post["tid"]]?>");
		//$('fieldset > legend:first-child').html("<?=$data['acquirer_name'][$post["tid"]]?>");
		<?}?>
		
		$('input, label, select, option, button', 'fieldset').each(function (index, item) {
		 // $(this).focus(function () { $(this).closest('fieldset').addClass('fieldsetFocus'); });
		 // $(this).blur(function () { $(this).closest('fieldset').removeClass('fieldsetFocus'); });
	   });
	   
	   /*
		$( "div fieldset:last-child" )
		  .css({ color:"red", fontSize:"80%" })
		  .hover(function() {
			$( this ).addClass( "solast" );
		  }, function() {
			$( this ).removeClass( "solast" );
		 });
		*/ 
	   
	});

	
</script>


<?

//exit;

?> 