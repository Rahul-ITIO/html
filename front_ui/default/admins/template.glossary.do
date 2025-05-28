<? if(isset($data['ScriptLoaded'])){?>
<style>
.table-responsive th, .table-responsive td {
    white-space: break-spaces !important;
}

</style>

<style>
* {
  box-sizing: border-box;
}


#myInput {
  background-image: url('../images/searchicon.png');
  background-position: 10px 10px;
  background-repeat: no-repeat;
  width: 98%;
  font-size: 16px;
  padding: 12px 20px 12px 40px;
  border: 1px solid #ddd;
  margin: 12px auto;
  display: block;
}

#myTable {
  border-collapse: collapse;
  width: 100%;
  border: 1px solid #ddd;
  font-size: 14px;
}

#myTable th, #myTable td {
  text-align: left;
  padding: 12px;
}

#myTable tr {
  border-bottom: 1px solid #ddd;
}

#myTable tbody tr:nth-child(odd) {
    background-color: #fff;
}

#myTable tbody tr:nth-child(even) {
    background-color: #E7E9EB;
}

#myTable tbody tr:hover {
  background-color: #f1f1f1;
}

#myTable tbody .hr * {
  background-color: #ddd;
  font-size:18px;
}
#myTable td {
  word-wrap: anywhere;
}




.highlight, mark {
  color:#000;
  background-color: yellow;
}

.active_a {position:relative;z-index:10;}
.tabIcon .active_a::after 
{
  content:'';
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 10px 10px 0 10px;
  border-color: var(--background-1) transparent transparent transparent;
  position: absolute;z-index:11;
  bottom: -10px;
  left: 50%;
  margin-left: -10px;
}

#btn-back-to-top {
  position: fixed;
  bottom: 20px;
  right: 20px;
  display: none;
}
</style>

<div class="container border vkg my-1 rounded">
<h4 class="my-2 col"><i class="<?=$data['fwicon']['book'];?>"></i> Glossary - A collection of textual glosses with their meanings or definition.</h4>

<?
// all php function get 

#########################################################################################################
/*
function foo(&$bar, $big, $small = 1) {}
function bar($foo) {}
function noparams() {}
function byrefandopt(&$the = 'one') {}

$functions1 = get_defined_functions();
$functions_list1 = array();
foreach ($functions1['user'] as $func) {
        $f = new ReflectionFunction($func);
        $args = array();
        foreach ($f->getParameters() as $param) {
                $tmparg = '';
                if ($param->isPassedByReference()) $tmparg = '&';
                if ($param->isOptional()) {
                        $tmparg = '[' . $tmparg . '$' . $param->getName() . ' = ' . $param->getDefaultValue() . ']';
                } else {
                        $tmparg.= '&' . $param->getName();
                }
                $args[] = $tmparg;
                unset ($tmparg);
        }
        $functions_list1[] = 'function ' . $func . ' ( ' . implode(', ', $args) . ' )' . PHP_EOL;
}
print_r($functions_list1);


*/



#########################################################################################################



#########################################################################################################

/*
function getMatches($pattern, $subject) {
  $matches = array();

  if (is_array($pattern)) {
      foreach ($pattern as $p) {
          $m = getMatches($p, $subject);

          foreach ($m as $key => $match) {
              if (isset($matches[$key])) {
                  $matches[$key] = array_merge($matches[$key], $m[$key]);    
              } else {
                  $matches[$key] = $m[$key];
              }
          }
      }
  } else {
      preg_match_all($pattern, $subject, $matches);
  }

  return $matches;
}

$patterns = array(
  '/<span>(.*?)<\/span>/',
  '/<a href=".*?">(.*?)<\/a>/',
  '/}\/\/(.*?) \\r\\nfunction /'
);

$html = '<span>some text</span>';
$html .= '<span>some text in another span</span>';
$html .= '<a href="path/">here is the link</a>';
$html .= '<address>address is here</address>';
$html .= '//This functions used to update complete ledger of a clients. \r\nfunction ddefff($uid=0,$currentDate=\'\',$tr_id=0,$trans_detail_array=[]) {}';
$html .= '//new def function ddefff($uid=0,$currentDate=0,$tr_id=0,$trans_detail_array=[]) {}';
$html .= '//dev create the function \r\nfunction ddefff($uid=0,$currentDate=\'\',$tr_id=0,$trans_detail_array=[]) {}';

echo stf($html);

$matches = getMatches($patterns, $html);

print_r($matches); // result is below

*/

//1. fetch the comment with function 
if(!isset($post['action'])||(isset($post['action'])&&($post['action']=='comment_with_function' || $post['action']=='all'))) 
{
    
  @$functionlist .= getCommentsFuntion('../config_db.do','config_db.do');

  @$functionlist .= getCommentsFuntion('../common.do','common.do'); @$functionlist .= getCommentsFuntion('../function_gw/function_gw_new.do','function_gw_new.do'); @$functionlist .= getCommentsFuntion('../function_gw/function_gw_wv2.do','function_gw_wv2.do'); @$functionlist .= getCommentsFuntion('../payin-processing-engine.do','payin-processing-engine.do');

  @$functionlist = str_replace(["MY_SECRET_ANQtkR7ak8RZ"],"",@$functionlist);

  @$functionlist .= codeDisplayPageWise('../payin-processing-engine.do','Business logic in Payin processing engine');

}


//2. Display the code for PHP FUNCTION  
if(isset($post['action'])&&($post['action']=='p' || $post['action']=='all')) 
{
  $lng = "es";
  $url = "http://www.php.net/manual/".$lng."/function.";

  // get defined functions in a variable (it will be a 2D array)
  $functions = get_defined_functions();
      
  // Run nested foreach to get the function names
  foreach($functions as $function){
      foreach ($function as $functionName){
          
          // Since php manual is using hyphens instead of underscores for functions, we will convert underscores to hyphen whereever there is one. 

          if(strpos($functionName,"_") !== false){
              $functionForURL = str_replace("_","-",$functionName);
          } else {
              $functionForURL = $functionName;
          }
          
          // echo the link /
         // echo "<a href='".@$url.$functionForURL.".php' target='_blank' >".$functionName."</a><br/>";

         $phpfunlink="<a href='".@$url.$functionForURL.".php' target='_blank' >".$functionName."</a>";

         $functionlistArr[] = '<tr><td class="fw-bold-11">' . @$phpfunlink  . '</td><td><b>' . ucname_f(@$functionName) . '</i> | <b>PHP FUNCTION</b></td></tr>';
      }
  }
  @$functionlist .= '<tr class="hr"><td colspan="2"><h4><strong>PHP FUNCTION </strong></h4></td></tr>'.implode('', @$functionlistArr);
}


//3. Display the code for define function  
if(isset($post['action'])&&($post['action']=='define_function_code' || $post['action']=='copyright_doc' || $post['action']=='all')) 
{

  @$functionlist .= codeDisplayPageWise('../config_db.do','Code Display for config_db.do',1);
  @$functionlist .= codeDisplayPageWise('../common.do','Code Display for common.do',1);
  @$functionlist .= codeDisplayPageWise('../function_gw/function_gw_new.do','Code Display for function_gw_new.do',1);
  @$functionlist .= codeDisplayPageWise('../function_gw/function_gw_wv2.do','Code Display for function_gw_wv2.do',1);
  @$functionlist .= codeDisplayPageWise('../function_gw/function_gw_wv3_custom.do','Code of Custom from settlement optimizer for function_gw_wv3.do',1);
  
}

//4. Display the code for Paying Proccess 
if(isset($post['action'])&&($post['action']=='paying_procces_code' || $post['action']=='copyright_doc' || $post['action']=='all')) 
{

  @$functionlist .= codeDisplayPageWise('../payin-processing-engine.do','Code Display for payin-processing-engine.do',1);
  @$functionlist .= codeDisplayPageWise('../api_trans_process.do','Code Display for api_trans_process.do',1);
  @$functionlist .= codeDisplayPageWise('../transCallbacks.do','Code Display for transCallbacks.do',1);
  @$functionlist .= codeDisplayPageWise('../success_curl.do','Code Display for success_curl.do',1);
  @$functionlist .= codeDisplayPageWise('../status.do','Code Display for status.do',1);
  @$functionlist .= codeDisplayPageWise('../payin/status_top.do','Code Display for status_top.do',1);
  @$functionlist .= codeDisplayPageWise('../payin/status_expired.do','Code Display for status_expired.do',1);
  @$functionlist .= codeDisplayPageWise('../payin/status_bottom.do','Code Display for status_bottom.do',1);
  @$functionlist .= codeDisplayPageWise('../payin/pay102/status_102.do','Code Display for status_102.do',1);
  @$functionlist .= codeDisplayPageWise('../payin/pay12299/status_12299.do','Code Display - Network Payment for status_12299.do',1);
  @$functionlist .= codeDisplayPageWise('../payin/pay12299/acquirer_12299.do','Code Display - (12,121-130 Acquirer) Network Payment for acquirer_12299.do',1);

}

//5. Display the code for Withdraw
if(isset($post['action'])&&($post['action']=='withdraw' || $post['action']=='copyright_doc' || $post['action']=='all')) 
{

  @$functionlist .= codeDisplayPageWise('../function_gw/function_gw_wv2.do','Code Display for function_gw_wv2.do',1);
  @$functionlist .= codeDisplayPageWise('../function_gw/function_gw_wv3_custom.do','Code of Custom from settlement optimizer for function_gw_wv3.do',1);

}


//6. Display the code for all acquirers  
if(isset($post['action'])&&($post['action']=='acquirers' || $post['action']=='a')) 
{
    
    $uiList = glob('../payin/*/*');
    $files = [];
  

    // Collect files and their corresponding folder numbers
    foreach ($uiList as $uiName) {
      if (!in_array($uiName, [1 => "index.html"]) && (preg_match('/.do$/', $uiName)) && (!preg_match('/Copy|copy|.pdf|.docx/', $uiName))) {
          $uiName1_ex = explode("/", $uiName);
          $uiName1 = end($uiName1_ex);
          $uiName1 = str_replace(".do", "", $uiName1);
          
          // Extract folder number
          $folderName = $uiName1_ex[count($uiName1_ex) - 2]; // Get the folder name
          preg_match('/(\d+)/', $folderName, $matches); // Extract the number
          $folderNumber = isset($matches[1]) ? (int)$matches[1] : 0; // Convert to integer

          // Get the last modified time
          $lastModifiedTime = filemtime($uiName);

          // Store the file information
          $files[] = [
              'path' => $uiName,
              'name' => $uiName1,
              'folderNumber' => $folderNumber,
              'lastModified' => $lastModifiedTime // Store last modified time
          ];
      }
    }

    // Filter and sort files based on the sorting parameter
    if (isset($_REQUEST['sorting'])) {
      if ($_REQUEST['sorting'] != 'ld') {

        /*
        if(preg_match('/^-(\d+) day$/', $_REQUEST['sorting'], $matches)){
          // Filter files modified within the last X days
          $days = (int)$matches[1];
          
        }
        */
        
        $days = (int)$_REQUEST['sorting'];

        $cutoffTime = strtotime("-$days days");

        // Filter files based on last modified time
        $files = array_filter($files, function($file) use ($cutoffTime) {
            return $file['lastModified'] >= $cutoffTime;
        });

        // Sort the filtered files by last modified date in descending order
        usort($files, function($a, $b) {
            return $b['lastModified'] <=> $a['lastModified'];
        });

         
      } elseif ($_REQUEST['sorting'] == 'ld') {
           // Sort by last modified date in descending order
           usort($files, function($a, $b) {
              return $b['lastModified'] <=> $a['lastModified'];
          });
      } else {
          // Default sorting: by folder number in descending order
          usort($files, function($a, $b) {
              return $b['folderNumber'] <=> $a['folderNumber'];
          });
      }
    } else {
      // Default sorting: by folder number in descending order
      usort($files, function($a, $b) {
          return $b['folderNumber'] <=> $a['folderNumber'];
      });
    }

    // Display the results
    foreach ($files as $file) {
      if (isset($_REQUEST['qp'])) {
          echo "<div>{$file['path']} = {$file['name']}</div>";
      } else {
          // Assuming codeDisplayPageWise is a function that handles the display
          @$functionlist .= codeDisplayPageWise($file['path'], $file['name'], 1);
      }
    }


}



/*
$functionlist_1 = getCommentsFuntion('../config_db.do','config_db.do');

$functionlist_2 = @$functionlist_1. getCommentsFuntion('../common.do','common.do');

@$functionlist= @$functionlist_2 .getCommentsFuntion('../function_gw/function_gw_new.do','function_gw_new.do');

@$functionlist = str_replace(["MY_SECRET_ANQtkR7ak8RZ"],"",@$functionlist);

   */ 

/*

echo "<br/><hr/><br/><h1>Example: In this example, we will print all the get defined functions.</h1><br/>";

$arr = get_defined_functions();

print_r($arr);





echo "<br/><hr/><br/><h1>Example: In this example, we will print all the functions present in DOM module.</h1><br/>";

$func_names = get_extension_funcs("JSON"); 
$length = count($func_names); 
echo "<br/>length=> ".$length; 
 
for($i = 0; $i < $length; $i++) { 
	echo("<br>"); 
    echo($func_names[$i]); 
    
} 



echo "<br/><hr/><br/><h1>Example: In this example we will print all the functions present in XML module.</h1><br/>";


$func_names = get_extension_funcs("XML"); 
$length = count($func_names); 
  
for($i = 0; $i < $length; $i++) { 
    echo($func_names[$i]); 
    echo("<br>"); 
} 



echo "<br/><hr/><br/><h1>Example: In this example, we will print all the functions present in JSON module.</h1><br/>";


$func_names = get_extension_funcs("DOM"); 
$length = count($func_names); 
  
for($i = 0; $i < $length; $i++) { 
    echo($func_names[$i]); 
    echo("<br>"); 
} 






*/

if(isset($data['pageUrl'])&&$data['pageUrl']) $pageUrl=$data['Admins'].'/'.$data['pageUrl'].$data['ex'];
else $pageUrl=$data['Admins'].'/glossary'.$data['ex'];

$tab_nav='data-bs-toggle="tab" data-bs-target="#tab_nav_home" type="button" role="tab" aria-controls="tab_nav_home" aria-selected="true"';
?>

<button type="button" class="btn btn-danger btn-floating btn-lg" id="btn-back-to-top">
  <i class="fas fa-arrow-up"></i>
</button>


<div class="container mt-3 tabIcon">
		<h4 class="my-2 hide">Sorting Via Link</h4>
    <a href="<?=$pageUrl?>?action=comment_with_function#comment_with_function" id="comment_with_function" class="btn btn-info my-2">Comment with Function</a>
    <a href="<?=$pageUrl?>?action=define_function_code#define_function_code" id="define_function_code" class="btn btn-secondary my-2">Define Function Code</a>
		<a href="<?=$pageUrl?>?action=paying_procces_code#paying_procces_code" id="paying_procces_code" class="btn btn-primary my-2">Paying Procces Code</a>
		<a href="<?=$pageUrl?>?action=copyright_doc#copyright_doc" id="copyright_doc" class="btn btn-success my-2">Copyright Doc.</a>
		<a href="<?=$pageUrl?>?action=withdraw#withdraw" id="withdraw" class="btn btn-success my-2">Withdraw</a>
    

		

    <?if(isset($_REQUEST['action'])&&($_REQUEST['action']=='acquirers'||$_REQUEST['action']=='a' || @$data['localhosts']==true)) {?>
      <a href="<?=$pageUrl?>?action=acquirers&sorting=10#acquirers" id="acquirers" title="Day wise filter for modify of acquirer code" class="btn btn-success my-2">Acquirers</a>

      <a href="<?=$pageUrl?>?action=acquirers&sorting=ld#acquirers" title="Display for all acquirers modify code as per latest date wise" class="btn btn-secondary my-2">All Acquirers modify latest date wise</a>
      <a href="<?=$pageUrl?>?action=acquirers#acquirers"  title="Display code for descending order of all acquirers" class="btn btn-secondary my-2">All Acquirers Folder wise</a>
    <?}?>

		<a href="<?=$pageUrl?>?action=p#p" id="p" class="btn btn-warning my-2">PHP Reference Function</a>
		<a href="<?=$pageUrl?>?action=all#all" id="all" class="btn btn-dark my-2">All</a>
		
    <div class="tab-content" id="nav-tabContent">
        <div class="tab-pane fade show active mt-2" id="tab_nav_home" role="tabpanel" aria-labelledby="tab_nav_home-tab">
          <?=@$data['subLink'];?>
        </div>
    </div>

</div>


<input type="text" id="myInput" onkeyup_X="myFunction_s()" placeholder="Search .." >


<div class="container table-responsive">
  <?php /*?>Function Defined from /config_db.do <?php */?>
  <table id="myTable" class="table table-hover display dataTable">
    <thead>
      <tr>
        <th scope="col" style="width:40%">Function Name</th>
        <th scope="col" style="width:60%">Description</th>
      </tr>
    </thead>
    <tbody>
    <?
  {
      /*?>
     
     
      <tr>
        <td>mask($str, $first, $last)</td>
        <td>&nbsp;</td>
        <td>An automatically generated string that can be used in place of your real string/text.</td>
      </tr>
      <tr>
        <td>mask_email($email)</td>
        <td>&nbsp;</td>
        <td>A Masked Email address is a unique, automatically generated email address that can be used in place of your real email address.</td>
      </tr>
      <tr>
        <td>error_reportingf($type=0)</td>
        <td>$type=0</td>
        <td>Turn on/off PHP errors / warnings. Default error_reporting is off.</td>
      </tr>
      <tr>
        <td>exp_encrypts256($str)</td>
        <td>&nbsp;</td>
        <td>Encrypts a string in base of 256-bit encryption technique</td>
      </tr>
      <tr>
        <td>exp_decrypts256($str)</td>
        <td>&nbsp;</td>
        <td>Decrypts a string which Encrypts in base of 256-bit technique</td>
      </tr>
      <tr>
        <td>prntext($text, $repl=0)</td>
        <td>$repl=0</td>
        <td>To removes some special keywords and tags.</td>
      </tr>
      <tr>
        <td>stf($str)</td>
        <td>&nbsp;</td>
        <td>To removes all <span class="text-info">&lt;HTML&gt;</span> tags.</td>
      </tr>
      <tr>
        <td>replacepost($str, $key='')</td>
        <td>$key=''</td>
        <td>To removes single (') quotes, double (") quotes and blank spaces from emails and string. And also removes <span class="blue_var">&lt;HTML&gt;</span> tags.</td>
      </tr>
      <tr>
        <td>get_post()</td>
        <td>&nbsp;</td>
        <td>To converts and merge all the <span class="text-info">$_POST</span> values in an array and reset <span class="text-info">$_POST</span> values.</td>
      </tr>
      <tr>
        <td>get_request1()</td>
        <td>&nbsp;</td>
        <td>To converts and merge all the <span class="text-info">$_GET</span> values in an array.</td>
      </tr>
      <tr>
        <td>get_post1($pst)</td>
        <td>&nbsp;</td>
        <td>To define array after remove single (') quotes, double (") quotes.</td>
      </tr>
      <tr>
        <td>keym_f($post, $json)</td>
        <td>&nbsp;</td>
        <td>To sets all the <span class="text-info">$post</span> keys in json format.</td>
      </tr>
      <tr>
        <td>array_val_f($post, $val=0)</td>
        <td>$val=0</td>
        <td>To defined <span class="text-info">array</span> keys if the values are <span class="text-info">empty</span> or <span class="text-info">NULL</span>.</td>
      </tr>
      <tr>
        <td>ccnois($num)</td>
        <td>&nbsp;</td>
        <td>Mask the credit numbers with 'X', display only last four digits. Eg. XXXXXXXXXXXX2323</td>
      </tr>
      <tr>
        <td>domain_serverf($servername='', $layoutName='')</td>
        <td>$servername=''<br />
          $layoutName=''</td>
        <td>Map for color theme, logo and mailgun API for Merchant of SubAdmin</td>
      </tr>
      <tr>
        <td>insert_email_details($post)</td>
        <td>&nbsp;</td>
        <td>Inserted e-mail details into DB.</td>
      </tr>
      <tr>
        <td>is_sponsor_clients($userId, $refeneceId=0)</td>
        <td>$refeneceId=0</td>
        <td>To check clients is sponsor or not.</td>
      </tr>
      <tr>
        <td>get_sponsor_id($uid, $userId='')</td>
        <td>$userId=''</td>
        <td>To retrive / fetch sponser id of a clients.</td>
      </tr>
      <tr>
        <td>sponsor_details($uid=0, $adminId='')</td>
        <td>$uid=0<br />
          $adminId=''</td>
        <td>To retrive / fetch all the details of a sub-admin.</td>
      </tr>
      <tr>
        <td>sponsor_json($uid)</td>
        <td>&nbsp;</td>
        <td>To retrive / fetch all the details of a sub-admin from json.</td>
      </tr>
      <tr>
        <td>sponsor_id_details($id)</td>
        <td>&nbsp;</td>
        <td>To retrive / fetch all the details of a sub-admin.</td>
      </tr>
      <tr>
        <td>find_css_color($csscolor, $default='#fff')</td>
        <td>$default='#fff'</td>
        <td>To set css color, bgcolor and theme. Default color is WHITE.</td>
      </tr>
      <tr>
        <td>find_css_color_bootstrap($csscolor, $default='#fff')</td>
        <td>$default='#fff'</td>
        <td>To set css color, bgcolor and bootstrap theme. Default color is WHITE.</td>
      </tr>
      <tr>
        <td>clients_css_color($csscolor, $default='#fff')</td>
        <td>$default='#fff'</td>
        <td>To set css color, bgcolor and theme for clients section. Default color is WHITE.</td>
      </tr>
      <tr>
        <td>sponsor_themef($sid=0, $mid=0, $dataVar=0)</td>
        <td>$sid=0<br />
          $mid=0<br />
          $dataVar=0</td>
        <td>To set sponser theme layout. Including frontUi, css style etc.</td>
      </tr>
      <tr>
        <td>send_attchment_message($email_to, $email_to_name, $email_subject, $email_message,array $post=NULL, $email_from='', $email_reply='')</td>
        <td>$post=NULL<br />
          $email_from=''<br />
          $email_reply=''</td>
        <td>Send an email with attachement</td>
      </tr>
      <tr>
        <td>send_email($key, $post, $sponsorJsn=0)</td>
        <td>$sponsorJsn=0</td>
        <td>Use of this function for send an email with complete detail.</td>
      </tr>
      <tr>
        <td>jsonvaluef($theArray, $keyName, $array2='')</td>
        <td>$array2=''</td>
        <td>Complete the pairs in json values. (Correct json values if any type of error in json.)</td>
      </tr>
      <tr>
        <td>json_print($json_array, $json=true)</td>
        <td>$json=true</td>
        <td>Return the output in json format when use curl.</td>
      </tr>
      <tr>
        <td>micro_trans($uid=0, $all=false, $tableid=0)</td>
        <td>$uid=0<br />
          $all=false<br />
          $tableid=0</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>mer_settings($uid, $id=0, $single=false, $account_type='')</td>
        <td>$id=0<br />
          $single=false<br />
          $account_type=''</td>
        <td>Fetch the all accounts detail on a merchant.</td>
      </tr>
      <tr>
        <td>riskratio_mer($total_ratio, $charge_back_fee=0, $card=true)</td>
        <td>$charge_back_fee=0<br />
          $card=true</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>get_riskratio_trans($uid, $account_type=0, $card=true, $dateRange='')</td>
        <td>$account_type=0<br />
          $card=true<br />
          $dateRange=''</td>
        <td>Calculate chargeback fee of a merchant. And define riskratio range as per chargeback percentage.</td>
      </tr>
      <tr>
        <td>riskratio_trans($uid, $type=0, $risk_ratio=0)</td>
        <td>$type=0<br />
          $risk_ratio=0</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>number_formatf($amount)</td>
        <td>&nbsp;</td>
        <td>Convert numeric value in standard format without comma(,) with two decimal places.</td>
      </tr>
      <tr>
        <td>number_formatf2($amount)</td>
        <td>&nbsp;</td>
        <td>Convert numeric value in standard format without comma(,) with two decimal places.</td>
      </tr>
      <tr>
        <td>number_formatf_2($amount)</td>
        <td>&nbsp;</td>
        <td>Convert numeric value in standard format without comma(,) with two decimal places.</td>
      </tr>
      <tr>
        <td>calculation_trans_fee($trange, $uids=0, $all=false, $pdate='', $cpost='')</td>
        <td>$uids=0<br />
          $all=false<br />
          $pdate=''<br />
          $cpost=''</td>
        <td>Calculate all types transaction fee.</td>
      </tr>
      <tr>
        <td>ms_max_settelement_period($uid=0, $cdate='')</td>
        <td>$uid=0<br />
          $cdate=''</td>
        <td>Fetch maximum settlement days</td>
      </tr>
      <tr>
        <td>withdraw_max_prevf($uid=0, $tid=0, $clk_status=0)</td>
        <td>$uid=0<br />
          $tid=0<br />
          $clk_status=0</td>
        <td>Fetch the transaction detail of previous withdrawal of a merchant.</td>
      </tr>
      <tr>
        <td>m_bal_update_trans_1($uid=0, $tid=0, $tdate=0)</td>
        <td>$uid=0<br />
          $tid=0<br />
          $tdate=0</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>m_bal_update_trans_all()</td>
        <td>&nbsp;</td>
        <td>Update balance upto date.</td>
      </tr>
      <tr>
        <td>m_bal_update_trans($uid=0, $tid=0, $tdate=0)</td>
        <td>$uid=0<br />
          $tid=0<br />
          $tdate=0</td>
        <td>Update balance upto date of a merchant.</td>
      </tr>
      <tr>
        <td>currencyConverter($from_Currency='USD', $to_Currency='CAD', $amount=1, $getway=false, $results=false)</td>
        <td>$from_Currency='USD'<br />
          $to_Currency='CAD' <br />
          $amount=1 <br />
          $getway=false <br />
          $results=false</td>
        <td>Convert amount from one currency to other currency. Live currency rates fetch from exchangerate-api.com.</td>
      </tr>
      <tr>
        <td>get_currency($currency, $names=0)</td>
        <td>$names=0</td>
        <td>Get the currency name from currency symbol and fetch currnecy symbol from currency name.</td>
      </tr>
      <tr>
        <td>select_sold($uid, $store_id)</td>
        <td>&nbsp;</td>
        <td>Fetch number of transaction and total amount of a merchant. (Only success and refund)</td>
      </tr>
      <tr>
        <td>select_terminals($uid, $type=0, $id=0, $single=false, $active=0, $where_pred='')</td>
        <td>$type=0 <br />
          $id=0 <br />
          $single=false <br />
          $active=0 <br />
          $where_pred=''</td>
        <td>Fetch all detail of stores with acquirer list of a merchant.</td>
      </tr>
      <tr>
        <td>select_product_details($id, $uid=0, $apiToken='')</td>
        <td>$uid=0 <br />
          $apiToken=''</td>
        <td>Fetch all detail of stores with acquirer list via store id.</td>
      </tr>
      <tr>
        <td>json_value_trf($postArray='', $getArray='', $skip=0)</td>
        <td>$postArray='' <br />
          $getArray='' <br />
          $skip=0</td>
        <td>Merge two arrays and return into json format.</td>
      </tr>
      <tr>
        <td>trans_updatesf($id, $post='', $skip=0)</td>
        <td>$post='' <br />
          $skip=0</td>
        <td>Update transaction detail including request and response in Json format. Also update payment reference number (txn_id) and descriptor.</td>
      </tr>
      <tr>
        <td>tran_type_updf($id, $type='')</td>
        <td>$type=''</td>
        <td>Update transaction type.</td>
      </tr>
      <tr>
        <td>select_client_table($uid, $tbl='clientid_table', $prnt=0)</td>
        <td>$tbl='clientid_table' <br />
          $prnt=0</td>
        <td>Fetch all the details of a clients via id. Use of this function we can also fetch details from any table via using primary key (id)</td>
      </tr>
      <tr>
        <td>select_table_details($uid, $tbl='', $prnt=0)</td>
        <td>$tbl='' <br />
          $prnt=0</td>
        <td>Use of this function we can fetch details from any table via using primary key (id)</td>
      </tr>
      <tr>
        <td>select_tablef($where_pred='', $tbl='', $prnt=0, $limit=1, $select='*')</td>
        <td>$where_pred='' <br />
          $tbl='' <br />
          $prnt=0 <br />
          $limit=1 <br />
          $select='*'</td>
        <td>Use of this function we can fetch all details or one or more fields from any table via using different type conditions</td>
      </tr>
      <tr>
        <td>str_replace_minus($str)</td>
        <td>&nbsp;</td>
        <td>Replace minus (-) symbol with blankspace.</td>
      </tr>
      <tr>
        <td>transIDf($transID, $no=0)</td>
        <td>$no=0</td>
        <td>Fetch only order number from transID.</td>
      </tr>
      <tr>
        <td>wh_log($logs, $filename='apilog', $append=0)</td>
        <td>$filename='apilog' <br />
          $append=0</td>
        <td>To update/re-write log file</td>
      </tr>
      <tr>
        <td>delete_file_linewise($files='apilog')</td>
        <td>$files='apilog'</td>
        <td>Delete lines from log file and re-write again</td>
      </tr>
      <tr>
        <td>Search_Logs()</td>
        <td>&nbsp;</td>
        <td>Search contents from a log file.</td>
      </tr>
      <tr>
        <td>parseStringf($string)</td>
        <td>&nbsp;</td>
        <td>The parseStringf() function is used to remove unpair symbols from a string. eg. \, ", ', {, } etc.</td>
      </tr>
      <tr>
        <td>jsonencode1($str, $str2='', $formCount=0)</td>
        <td>$str2='' <br />
          $formCount=0</td>
        <td>The jsonencode1() function is used to encode a value to JSON format.</td>
      </tr>
      <tr>
        <td>jsonencode($str, $theTrue='', $skip=0)</td>
        <td>$theTrue='' <br />
          $skip=0</td>
        <td>The jsonencode() function is used to encode a value to JSON format.</td>
      </tr>
      <tr>
        <td>jsondecode($str, $theTrue='', $skip=0)</td>
        <td>$theTrue='' <br />
          $skip=0</td>
        <td>The jsondecode() function is used to decode or convert a JSON object to a PHP object or array.</td>
      </tr>
      <tr>
        <td>jsonreplace($str)</td>
        <td>&nbsp;</td>
        <td>The jsonreplace() function is used to remove some unwanted words and unpair symbols from a JSON.</td>
      </tr>
      <tr>
        <td>json_log($pLog='', $cLog='', $compare=0)</td>
        <td>$pLog='' <br />
          $cLog='' <br />
          $compare=0</td>
        <td>The json_log() function is used to merge two JSON object.</td>
      </tr>
      <tr>
        <td>json_log_upd($tableId=0, $tableName='json_log', $action_name='Update',array $log=null, $clientid='')</td>
        <td>$tableId=0 <br />
          $tableName='json_log' <br />
          $action_name='Update' <br />
          array $log=null <br />
          $clientid=''</td>
        <td>The json_log_upd() used to update logs in JSON format.</td>
      </tr>
      <tr>
        <td>json_log_view1($log='', $action_name='View Json Log', $tableId=0, $tableName='json_log', $clientid='')</td>
        <td>$log='' <br />
          $action_name='View Json Log' <br />
          $tableId=0 <br />
          $tableName='json_log' <br />
          $clientid=''</td>
        <td>The use of this function to view json log history.</td>
      </tr>
      <tr>
        <td>json_log_view($log='', $action_name='View Json Log', $tableId=0, $tableName='json_log', $clientid='', $width='90vw')</td>
        <td>$log='' <br />
          $action_name='View Json Log' <br />
          $tableId=0 <br />
          $tableName='json_log' <br />
          $clientid='' <br />
          $width='90vw'</td>
        <td>The json_log_view() used to view/check logs in JSON format.</td>
      </tr>
      <tr>
        <td>use_curl($url, $post=null)</td>
        <td>$post=null</td>
        <td>The use_curl() used to send request and access any page/url via curl.</td>
      </tr>
      <tr>
        <td>post_redirect($url, array $data)</td>
        <td>&nbsp;</td>
        <td>The post_redirect() used to send request via form submission.</td>
      </tr>
      <tr>
        <td>post_redirectf($url, array $data)</td>
        <td>&nbsp;</td>
        <td>The post_redirectf() used to send request via form submission. Submit information through popup.</td>
      </tr>
      <tr>
        <td>post_iframe_script($url)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>encryptres($sData, $sKey='ztcBase64Encode')</td>
        <td>$sKey='ztcBase64Encode'</td>
        <td>The encryptres() used to encode the string with KEY (ztcBase64Encode) in encode_base64.</td>
      </tr>
      <tr>
        <td>decryptres($sData, $sKey='ztcBase64Encode')</td>
        <td>$sKey='ztcBase64Encode'</td>
        <td>The decryptres() used to decode the string with KEY (ztcBase64Encode) in encode_base64.</td>
      </tr>
      <tr>
        <td>encrypt_res($sData, $sKey='pctAsia')</td>
        <td>$sKey='pctAsia'</td>
        <td>The encrypt_res() used to encode the string with KEY (pctAsia) in encode_base64.</td>
      </tr>
      <tr>
        <td>decrypt_res($sData, $sKey='pctAsia')</td>
        <td>$sKey='pctAsia'</td>
        <td>The decrypt_res() used to decode the string with KEY (pctAsia) in encode_base64.</td>
      </tr>
      <tr>
        <td>encode64f($sData, $sKey='MY_SECRET')</td>
        <td>$sKey='MY_SECRET'</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>decode64f($sData, $sKey='MY_SECRET')</td>
        <td>$sKey='MY_SECRET'</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>encode_f($string, $json=1)</td>
        <td>$json=1</td>
        <td>The encode_f() used to encode the string / email with KEY via using "AES-256-CBC" has sha256 method base on openssl_decrypt and base64_decode.</td>
      </tr>
      <tr>
        <td>decode_f($string, $json=1))</td>
        <td>$json=1</td>
        <td>The decode_f() used to decode the string / email with KEY via using "AES-256-CBC" has sha256 method base on openssl_decrypt and base64_decode.</td>
      </tr>
      <tr>
        <td>reuse_param_set($post, $type=0, $cross_domain='')</td>
        <td>$type=0 <br />
          $cross_domain=''</td>
        <td>The reuse_param_set() used to set <span class="text-info">$_SESSION</span> and <span class="text-info">$post</span> values into a new array and use on api/secure/process for cross domain.</td>
      </tr>
      <tr>
        <td>reuse_param_get2($value, $type=0, $id=0)</td>
        <td>$type=0 <br />
          $id=0</td>
        <td>The reuse_param_get2() used to decrypt and decode the values from json and set into <span class="text-info">$_SESSION</span> and <span class="text-info">$post</span> variable</td>
      </tr>
      <tr>
        <td>reuse_param_get($trans, $type, $id=0)</td>
        <td>$id=0</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>approved_url($http_referer='', $approved_url='')</td>
        <td>$http_referer='' <br />
          $approved_url=''</td>
        <td>The approved_url() used to check URL is approved or not.</td>
      </tr>
      <tr>
        <td>squrlf($url,array $post)</td>
        <td>&nbsp;</td>
        <td>The squrlf() used to convert $post array into a subquery string and concated with url.</td>
      </tr>
      <tr>
        <td>approved_referer($http_referer='', $approved_url='')</td>
        <td>$http_referer='' <br />
          $approved_url=''</td>
        <td>The approved_referer() used to check referer URL is valid and approved or not.</td>
      </tr>
      <tr>
        <td>adc($hexCode, $adjustPercent)</td>
        <td>&nbsp;</td>
        <td>The adc() used to increases or decreases the brightness of a color by a percentage of the current brightness.</td>
      </tr>
      <tr>
        <td>time_zonelist()</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>sel_verifi($uid, $limit=0, $table_name='')</td>
        <td>$limit=0 <br />
          $table_name=''</td>
        <td>This function is used to check kyc document uploaded or not - self verification</td>
      </tr>
      <tr>
        <td>insert_verifi($post='', $uid=0, $table_name='', $reference='', $post_status='', $response_status='')</td>
        <td>$post=' <br />
          $uid=0 <br />
          $table_name='' <br />
          $reference='' <br />
          $post_status='' <br />
          $response_status=''</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>encode_img($file)</td>
        <td>&nbsp;</td>
        <td>The use of encode_img() is to encrypt image name.</td>
      </tr>
      <tr>
        <td>countryCodeMatch2($country_two, $countries='', $countryCode='', $donotmachcountries='')</td>
        <td>$countries='' <br />
          $countryCode='' <br />
          $donotmachcountries=''</td>
        <td>The use of countryCodeMatch2() is - fetch the country list base on two universal country codes.</td>
      </tr>
      <tr>
        <td>remove_keyf($array, $key)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>remove_key_arf($array, $keyArray)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>unsetf($unsetPram)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>unset_f1($unsetPram)</td>
        <td>&nbsp;</td>
        <td>The unset_f1() used to unset <span class="text-info">$_POST</span>, <span class="text-info">$_GET</span> and <span class="text-info">$_SESSION</span> values</td>
      </tr>
      <tr>
        <td>unset_sessionf($unsetPram)</td>
        <td></td>
        <td>The unset_sessionf() used to unset <span class="text-info">$_SESSION</span> values</td>
      </tr>
      <tr>
        <td>insert_api_data_table($use_for='', $pram_value='', $josn='')</td>
        <td>$use_for='' <br />
          $pram_value='' <br />
          $josn=''</td>
        <td>The insert_api_data_table() used to insert bank information in <strong>JSON</strong> format.</td>
      </tr>
      <tr>
        <td>select_api_data_table($use_for='banks', $pram_value='', $id=0, $single=true)</td>
        <td>$use_for='banks' <br />
          $pram_value='' <br />
          $id=0 <br />
          $single=true</td>
        <td>The select_api_data_table() used to fetch bank information from the table and convert from <strong>JSON</strong> format to array.</td>
      </tr>
      <tr>
        <td>c_table($array, $width='', $t_style='width="700px" align="center" border="0" cellpadding="4" cellspacing="0" bordercolor="#999999" style="width:700px;background-color:#fff;border-collapse:collapse;font:12px/14px Verdana,Tahoma,Trebuchet MS,Arial;color: #555555;"', $colStyle='style="background-color:#fff;font-size:16px;line-height:20px;"')</td>
        <td>$width='' <br />
          $t_style='width="700px" align="center" border="0" cellpadding="4" cellspacing="0" bordercolor="#999999" style="width:700px;background-color:#fff;border-collapse:collapse;font:12px/14px Verdana,Tahoma,Trebuchet MS,Arial;color: #555555;"' <br />
          $colStyle='style="background-color:#fff;font-size:16px;line-height:20px;"'</td>
        <td>The c_table() used to create table css dynamically.</td>
      </tr>
      <tr>
        <td>isJsonDe($string)</td>
        <td>&nbsp;</td>
        <td>The isJsonDe() used to returns the value encoded in json in appropriate PHP type. Values true , false and null are returned as true, false and null respectively. null is returned if the json cannot be decoded or if the encoded data is deeper than the nesting limit.</td>
      </tr>
      <tr>
        <td>isJsonEn($string)</td>
        <td>&nbsp;</td>
        <td>The isJsonEn() used to returns a string containing the JSON representation of the supplied array.</td>
      </tr>
      <tr>
        <td>createJsonf($jParam, $jData)</td>
        <td>&nbsp;</td>
        <td>The createJsonf() used to returns a string containing the JSON representation of the supplied value.</td>
      </tr>
      <tr>
        <td>formatPeriodf($endtime=0, $starttime=0)</td>
        <td>$endtime=0 <br />
          $starttime=0</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>format_periodf($seconds_input)</td>
        <td>&nbsp;</td>
        <td>The format_periodf() used to returns the duration in micro seconds.</td>
      </tr>
      <tr>
        <td>upgrade_tr_countf($uid=0)</td>
        <td>$uid=0</td>
        <td>The upgrade_tr_countf() used to update number of transaction of a merchant.</td>
      </tr>
      <tr>
        <td>upgrade_tr_count_all_clients()</td>
        <td>&nbsp;</td>
        <td>The upgrade_tr_countf() used to update number of transaction at once.</td>
      </tr>
      <tr>
        <td>passwordCheck($uid, $passParam, $tbl='clientid_table')</td>
        <td>$tbl='clientid_table'</td>
        <td>The passwordCheck() used for check login password is correct or not.</td>
      </tr>
      <tr>
        <td>getCharf($str, $len=0)</td>
        <td>$len=0</td>
        <td>The getCharf() used to returns a character from a string at specified position.</td>
      </tr>
      <tr>
        <td>implodef($array, $implode=",")</td>
        <td>$implode=","</td>
        <td>The implodef() function returns a string from the elements of an array. Default implode via comma (,).</td>
      </tr>
      <tr>
        <td>implodes($implod, $array)</td>
        <td>&nbsp;</td>
        <td>The implodes() function returns a string from the elements of an array</td>
      </tr>
      <tr>
        <td>explode1($explode=',', $str='', $no=-1)</td>
        <td>$explode=',' <br />
          $str='' <br />
          $no=-1</td>
        <td>The explode1() function breaks a string into an array.. Default explode via comma (,).</td>
      </tr>
      <tr>
        <td>explodef($str, $explode='.', $no=-1)</td>
        <td>$explode='.' <br />
          $no=-1</td>
        <td>The explodef() function breaks a string into an array. Default explode via dot (.).</td>
      </tr>
      <tr>
        <td>explodes($str, $explode='.')</td>
        <td>$explode='.'</td>
        <td>The explodes() function breaks a string into two parts of an array from dot (.). If dot not exists in string then return one array.</td>
      </tr>
      <tr>
        <td>queryArrayf($bucketsearch, $bucketname, $operator='LIKE', $implode='OR', $explode=';', $exactmatch=1)</td>
        <td>$operator='LIKE' <br />
          $implode='OR' <br />
          $explode=';' <br />
          $exactmatch=1</td>
        <td>The queryArrayf() function used for create an exact query from mulitiple conditions and operator.</td>
      </tr>
      <tr>
        <td>lf($str, $ch=10, $dot=0)</td>
        <td>$ch=10 <br />
          $dot=0</td>
        <td>The use of lf() function is - terminate the long string in fixed number of characters. Default value is 10.</td>
      </tr>
      <tr>
        <td>scrubbed_sql($dbqr, $status, $method, $field)</td>
        <td>&nbsp;</td>
        <td>The scrubbed_sql() function is used to fetch number of scrubbed transaction group by method.</td>
      </tr>
      <tr>
        <td>scrubbed_status_details($scrubbed_data)</td>
        <td>&nbsp;</td>
        <td>The scrubbed_status_details() used to fetch details of scrubbed types</td>
      </tr>
      <tr>
        <td>scrubbed_status($transid)</td>
        <td>&nbsp;</td>
        <td>The scrubbed_status() used to fetch details of a scrubbed transaction.</td>
      </tr>
      <tr>
        <td>salt_managementf()</td>
        <td>&nbsp;</td>
        <td>The salt_managementf() function is used to fetch salt management json.</td>
      </tr>
      <tr>
        <td>acquirer_tablef()</td>
        <td>&nbsp;</td>
        <td>The use of bank_gateway_tablef() function is fetch account number from a zt_acquirer_table</td>
      </tr>
      <tr>
        <td>merchant_categoryf($id=0)</td>
        <td>&nbsp;</td>
        <td>The merchant_categoryf() use for fetch the data from zt_merchant_category table</td>
      </tr>
      <tr>
        <td>mcc_code_listf($account_no=0)</td>
        <td>&nbsp;</td>
        <td>The mcc_code_listf() used for fetch account_no and acquirer_json detail of an account.</td>
      </tr>
      <tr>
        <td>option_smf($post, $theId=null, $keyName='', $currentId='')</td>
        <td>$theId=null <br />
          $keyName='' <br />
          $currentId=''</td>
        <td>The option_smf() used to fetch the list of salt as option.</td>
      </tr>
      <tr>
        <td>findStrf($str, $arr)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td>metaSecurityPolicy()</td>
        <td>&nbsp;</td>
        <td>The use of metaSecurityPolicy() funtion is set SecurityP meta tags in header.</td>
      </tr>
      <tr>
        <td>checkIPAddressf($ipAddress)</td>
        <td>&nbsp;</td>
        <td>The checkIPAddressf() is used to check the IP address is valid or not.</td>
      </tr>
      <tr>
        <td>tr_reasonf($reason)</td>
        <td>&nbsp;</td>
        <td>The tr_reasonf() function is used for fetch the reason zt_reason_table via id.</td>
      </tr>
      <tr>
        <td>bclf($ccno, $bin='')</td>
        <td></td>
        <td>The bclf() used to replace first six characters win bin of a card.</td>
      </tr>
      <tr>
        <td>emtagf($email, $opt=1)</td>
        <td>$g_sid=0 <br />
          $g_mid=0 <br />
          $checkout_theme=''</td>
        <td>The emtagf() function is used to print the name and/or email on the image or PDF.</td>
      </tr>
      <tr>
        <td>sponsor_themefc($g_sid=0, $g_mid=0, $checkout_theme='')</td>
        <td>$g_sid=0 <br />
          $g_mid=0 <br />
          $checkout_theme=''</td>
        <td>The use of sponsor_themefc() function is select the sponsor theme.</td>
        </td>
      </tr>
   
      <tr>
        <td class="fw-bold-11">isMobileValid($mob)</td>
        <td>&nbsp;</td>
        <td>The isMobileValid() function is used to check mobile is valid or not. Return last 10 digit.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">isMobileBrowser()</td>
        <td>&nbsp;</td>
        <td>The isMobileBrowser() function is used to check mobile browser. If mobile' browser then return true else return false.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">date_comparison($main_date, $date1, $date2='', $comp_type="mature")</td>
        <td>&nbsp;</td>
        <td>No any use.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">card_binf($ccno)</td>
        <td>&nbsp;</td>
        <td>The card_binf() is used to fetch card' bank detail fetch from bincodes' API insert to DB.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_all_clients_new($Id=0)</td>
        <td>&nbsp;</td>
        <td>The get_all_clients_new() function is used to fetch all the details of a clients or all clients.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">fetch_ms_info($memId)</td>
        <td>&nbsp;</td>
        <td>The fetch_ms_info() function is used to fetch all the account details of a clients or all clients.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">getTotalRecords($tbl, $where_clause=1, $field="*")</td>
        <td>&nbsp;</td>
        <td>The getTotalRecords() function return total number of records of a table with specified condition.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">getNumericValue($value)</td>
        <td>&nbsp;</td>
        <td>The getNumericValue() function is used for return only numeric value from a string.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">fetchFormattedDate($date, $format="Y-m-d")</td>
        <td>&nbsp;</td>
        <td>The fetchFormattedDate() function returned date in specific / defined format.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">fetch_trans_balance($memId="", $json_frozen=0)</td>
        <td>&nbsp;</td>
        <td>The fetch_trans_balance() is used for fetch all transaction details of a clients or all transactions.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">trans_balance_newac($uid=0, $tr_id=0, $currentDate='', $trans_detail_array=[])</td>
        <td>&nbsp;</td>
        <td>The trans_balance_newac() used to calculate all type of balance and total records.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">payout_trans_newf($uid=0, $type=2)</td>
        <td>&nbsp;</td>
        <td>The payout_trans_newf() used to calculate payout settlement balance and period</td>
      </tr>
      <tr>
        <td class="fw-bold-11">ms_trans_balance_calc_new($uid=0, $trans_detail_array=[], $currentDate='', $tr_id=0)</td>
        <td>&nbsp;</td>
        <td>The function ms_trans_balance_calc_new() used to manage the complete ledger of a clients.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">ms_trans_balance_calc_d_new($uid=0, $currentDate='', $tr_id=0, $trans_detail_array=[])</td>
        <td>&nbsp;</td>
        <td>The function ms_trans_balance_calc_d_new() used to manage the complete ledger of a clients.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">create_header($token)</td>
        <td>&nbsp;</td>
        <td>The create_header() used for create Authorization header for curl request for CASHFREE.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">post_helper($action, $data, $token)</td>
        <td>&nbsp;</td>
        <td>The post_helper() function used for check Beneficiary for CASHFREE.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">process_request($finalUrl, $token)</td>
        <td>&nbsp;</td>
        <td>The process_request() function used for send payment request for CASHFREE.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">getBeneficiary($token)</td>
        <td>&nbsp;</td>
        <td>The getBeneficiary() function used for fetch the detail of a Beneficiary in CASHFREE.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">addBeneficiary($token)</td>
        <td>&nbsp;</td>
        <td>The post_helper() function used for add a new Beneficiary in CASHFREE.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">mer_trans_list($uid, $dir='both', $type=-1, $status=-1, $start=0, $count=0, $order='', $suser='', $sdate='')</td>
        <td>&nbsp;</td>
        <td>The mer_trans_list() used to fetch list of transactions for merchant section.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">adm_trans_list($uid, $dir='both', $type=-1, $status=-1, $start=0, $count=0, $order='', $sort = 'DESC', $suser='', $sdate='')</td>
        <td>&nbsp;</td>
        <td>The adm_trans_list() used to fetch list of transactions for admin section.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">affected_rows($rows, $msg="")</td>
        <td>&nbsp;</td>
        <td>The affected_rows() used to count number of records affected. (How many rows deleted, updated and inserted)</td>
      </tr>
      <tr>
        <td class="fw-bold-11">stringToNumber($value)</td>
        <td>&nbsp;</td>
        <td>The stringToNumber() function is used to fetch only numeric value from a string.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">display_nested_array($results)</td>
        <td>&nbsp;</td>
        <td>The display_nested_array() is used to display array recursively.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">encrypts_decrypts_emails($emailId, $type, $mass=false, $email_det=array())</td>
        <td>&nbsp;</td>
        <td>The encrypts_decrypts_emails() function is used to encrypt or decrypt email ids.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">getclientsEmailId($id)</td>
        <td>&nbsp;</td>
        <td>The getclientsEmailId() function is used to fetch all email Ids of a clients.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_encrypted_value($value)</td>
        <td>&nbsp;</td>
        <td>The get_encrypted_value() function is used to encrypt a value.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">remove_extra_comma($str)</td>
        <td>&nbsp;</td>
        <td>The remove_extra_comma() is used to remove extra comma (two consecutive) in string.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_blacklist_details($uid, $action='list', $post=array())</td>
        <td>&nbsp;</td>
        <td>The funtion get_blacklist_details() is used to add, remove and update data in blacklist.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">blacklist_scrubbed($uid)</td>
        <td>&nbsp;</td>
        <td>The blacklist_scrubbed() is used to create scrubbed in base of blacklist data.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">createiplist_file()</td>
        <td>&nbsp;</td>
        <td>The createiplist_file() is use to update blacklist IPs in .htaccess file.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">print_note_system($string)</td>
        <td>&nbsp;</td>
        <td>The print_note_system() function is used to print system note as per new date format.</td>
      </tr>
   

      <tr class="hr">
        <td><h4><strong>Common </strong>| Filename: <b>common.do</b> </h4></td>
        <td>&nbsp;</td>
        <td></td>
      </tr>

      
      <tr>
        <td class="fw-bold-11">includef($file_path)</td>
        <td>&nbsp;</td>
        <td>The function includef() is used to include a file if exists.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_trans_graph($post, $param=0)</td>
        <td>&nbsp;</td>
        <td>The function get_trans_graph() is used to display all the transaction details in graphic format of a merchant.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">create_graph($transaction_type, $date1, $date2)</td>
        <td>&nbsp;</td>
        <td>The function create_graph() is used to display all the transaction details between a period in graphic format.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">Column_Graph($trans_details)</td>
        <td>&nbsp;</td>
        <td>The function Column_Graph() is used to define a column of a graph. This function for admin level.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">YearlyGraph($trans_details, $date1, $date2)</td>
        <td>&nbsp;</td>
        <td>The function YearlyGraph() is used to show year-wise transaction details in graphic format. This function for admin level.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">MonthlyGraph($td, $date1, $date2)</td>
        <td>&nbsp;</td>
        <td>The function MonthlyGraph() is used to show month-wise transaction details in graphic format. This function for admin level.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">DailyGraph($td, $date1, $date2)</td>
        <td>&nbsp;</td>
        <td>The function DailyGraph() is used to show day-by-day transaction details in graphic format. This function for admin level.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">convert_month($month)</td>
        <td>&nbsp;</td>
        <td>The function convert_month() return short name of a month.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">Block_User()</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">set_ip_block_clients($uid, $ip_block_clients)</td>
        <td>&nbsp;</td>
        <td>The function set_ip_block_clients() is used to block a clients for 30 minutes after continuously fail to login with wrong username/password.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">is_clients_block($username)</td>
        <td>&nbsp;</td>
        <td>The function is_clients_block() is used to check user is block or not.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">getLocationInfoByIp($ipAddress, $region='')</td>
        <td>&nbsp;</td>
        <td>The function getLocationInfoByIp() is used to get location via IP.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">is_clients_login_same_country($username, $password)</td>
        <td>&nbsp;</td>
        <td>The function is_clients_login_same_country() is used to check clients last login with same IP/location or different location.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">protect($buffer)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prepare($buffer)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">show($template, $path_nm='')</td>
        <td>&nbsp;</td>
        <td>The function show() is used to display data as per defined template format.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">display($path='')</td>
        <td>&nbsp;</td>
        <td>The function display() is used to include template.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">showpage($template)</td>
        <td>&nbsp;</td>
        <td>The function showpage() is used to include template.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">showmenu($mode, $path='')</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">showbanner()</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">show_menu_langs()</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">show_default_select_lang()</td>
        <td>&nbsp;</td>
        <td>The function show_default_select_lang() is used to setup default Templates language.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">verify_email2($email)</td>
        <td>&nbsp;</td>
        <td>The function verify_email2() is used to check email-id is valid or not</td>
      </tr>
      <tr>
        <td class="fw-bold-11">verify_email($email)</td>
        <td>&nbsp;</td>
        <td>The function verify_email() is used to check email-id is valid or not on preg_match pattern.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">verify_username($username)</td>
        <td>&nbsp;</td>
        <td>The function verify_username() is used to verify username is correct or not on preg_match pattern.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">gencode()</td>
        <td>&nbsp;</td>
        <td>The function gencode() is used to generate a unique code.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">around($amount)</td>
        <td>&nbsp;</td>
        <td>The function around() is used to replace the percent (%) sign by a variable passed as an amount</td>
      </tr>
      <tr>
        <td class="fw-bold-11">encode($number, $size, $mask=1)</td>
        <td>&nbsp;</td>
        <td>The encode() function is used to Encodes data.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">is_changed($number)</td>
        <td>&nbsp;</td>
        <td>The function is_changed() is used to returns 1 if the pattern matches given subject, 0 if it does not, or false on failure on base of preg_match()</td>
      </tr>
      <tr>
        <td class="fw-bold-11">is_number($text)</td>
        <td>&nbsp;</td>
        <td>The function is_number() is used to returns 1 if the pattern matches given subject, 0 if it does not, or false on failure on base of preg_match()</td>
      </tr>
      <tr>
        <td class="fw-bold-11">show_selected($key, $current=null, $commaSeparated=0)</td>
        <td>&nbsp;</td>
        <td>The function show_selected() is used to show /display selected values.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">showselect($values, $current=null, $commaSeparated=0)</td>
        <td>&nbsp;</td>
        <td>The function showselect() is used to select values in the <span class="text-info">&lt;option&gt; &lt;/option&gt;</span> tags.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">read_csv($filename, $break)</td>
        <td>&nbsp;</td>
        <td>The function read_csv() is used to open <span class="text-info">CSV</span> file in read mode.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prndate($date)</td>
        <td>&nbsp;</td>
        <td>The function prndate() return the date in customized format if DATE is valid, return '---' if not a valid DATE.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prndatelog($date)</td>
        <td>&nbsp;</td>
        <td>The function prndatelog() return the date in customized format if DATE is valid, return '---' if not a valid DATE.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnintg($number)</td>
        <td>&nbsp;</td>
        <td>The function prnintg() is used to return numeric value with zero (0) decimal point.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnsum($sum)</td>
        <td>&nbsp;</td>
        <td>The function prnsum() is used to return numeric value without comma (,).</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnsum2($amount=0)</td>
        <td>&nbsp;</td>
        <td>The function prnsum2() is used to return numeric value with two (2) decimal point and without comma (,).</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnsumm($summ, $type=0)</td>
        <td>&nbsp;</td>
        <td>The function prnsumm() is used to return numeric value with defined <span class="text-info">$data['CurrSize']</span> decimal point and with comma (,).</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnsumm_two($summ)</td>
        <td>&nbsp;</td>
        <td>The function prnsumm_two() is used to return numeric value without comma (,).</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnpays($summ, $splus=true)</td>
        <td>&nbsp;</td>
        <td>The function prnpays() return value in <span class="text-danger">RED</span> color if value is negative, return in <span class="text-success">GREEN</span>, if the value zero or positive with Currency name.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">trprnpays($summ, $splus=true)</td>
        <td>&nbsp;</td>
        <td>The function trprnpays() return value in <span class="text-danger">RED</span> color if value is negative, return in <span class="text-success">GREEN</span>, if the value zero or positive with <span class="text-info">+/-</span> Symbol</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnpays_fee($summ, $splus=true)</td>
        <td>&nbsp;</td>
        <td>The function prnpays_fee() return value in <span class="text-danger">RED</span> color if value is not equal to ZERO with Currency and <span class="text-info">+/-</span> Symbol. Return --- in <span style="color:maroon">MAROON</span> color if value is <span class="text-info">ZERO (0)</span>.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnfees($summ)</td>
        <td>&nbsp;</td>
        <td>The function prnfees() return value in <span class="text-danger">RED</span> color if value is not equal to ZERO with Currency and <span class="text-info">+/-</span> Symbol. Return --- in <span style="color:maroon">MAROON</span> color if value is <span class="text-info">ZERO (0)</span>. </td>
      </tr>
      <tr>
        <td class="fw-bold-11">balance($summ)</td>
        <td>&nbsp;</td>
        <td>The function balance() return value in <span class="text-danger">RED</span> color if value is not equal to ZERO with Currency and <span class="text-info">+/-</span> Symbol. Return --- in <span style="color:maroon">MAROON</span> color if value is <span class="text-info">ZERO (0)</span>. </td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnuser($uid)</td>
        <td>&nbsp;</td>
        <td>The function prnuser() is used to print username if exists, else print <span class="text-info">system</span>.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_files_list($path)</td>
        <td>&nbsp;</td>
        <td>The function get_files_list() is used to fetch the all image list from a folder/directory.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_html_templates()</td>
        <td>&nbsp;</td>
        <td>The function get_html_templates() is used to html template.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">function1($siteUrl, $formPath, $resultUrl, $name, $price_string, $btc, $description, $type, $style, $price_currency_iso, $custom)</td>
        <td>&nbsp;</td>
        <td>The function1() is used to send request via curl and received response.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">autorize($uid, $post)</td>
        <td>&nbsp;</td>
        <td>The function autorize() is used to check Authentication of user.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">is_user_available($username)</td>
        <td>&nbsp;</td>
        <td>The function is_user_available() is used to check username is available OR not.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">is_mail_available($email)</td>
        <td>&nbsp;</td>
        <td>The function is_mail_available() is used to check email available OR not.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">create_confirmation($newuser,$newmail,$newfullname,$sponsor=0,$sub_sponsor=0,$newpass='')</td>
        <td>&nbsp;</td>
        <td>The function create_confirmation() is used to insert new user data in confirms table and send a confirmation e-mail. </td>
      </tr>
      <tr>
        <td class="fw-bold-11">create_confirmation_email_reg($newmail, $newresult)</td>
        <td>&nbsp;</td>
        <td>The function create_confirmation_email_reg() is used to send a confirmation e-mail.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_confirmation($ccode, $email, $chash='')</td>
        <td>&nbsp;</td>
        <td>No any use. Using twice in confirm.do but commented.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_confirmation_new($ccode)</td>
        <td>&nbsp;</td>
        <td>The function select_confirmation_new() is used to fetch the data from confirms table.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_email_confirmation($ccode, $email, $chash='')</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_confirmation($cid)</td>
        <td>&nbsp;</td>
        <td>The function update_confirmation() is used to update all transaction fee and limits of new confirm user. Remove more than five days old records from confirms table. Move the data of a user from confirms table to clients table. Also insert email detail into clients_emails table. Send a SIGNUP email to MEMBER.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_email_confirmation($eid)</td>
        <td>&nbsp;</td>
        <td>The function update_email_confirmation() is used to update email status.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">payout_status_class($gstatus)</td>
        <td>&nbsp;</td>
        <td>In the function payout_status_class(), you can set status <span class="text-info">CSS</span> as per status. </td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_count_where_pred($where_pred, $join='') </td>
        <td>&nbsp;</td>
        <td>No any use. Use 9-10 places in merchant.do, but all commented</td>
      </tr>
      <tr>
        <td class="fw-bold-11">clients_page_permission($getkey, $sesrole, $sesmemtype)</td>
        <td>&nbsp;</td>
        <td>The clients_page_permission() is used to check clients roll</td>
      </tr>
      <tr>
        <td class="fw-bold-11">trans_count_where_pred($where_pred)</td>
        <td>&nbsp;</td>
        <td>The trans_count_where_pred() used to retrive total transactions via defined condition</td>
      </tr>
	  <tr>
        <td class="fw-bold-11">get_transaction_stats($uid,$act=1)</td>
        <td>&nbsp;</td>
        <td>The get_transaction_stats() is used to transactions statistics by type and period</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_list_where_pred($start=0, $count=0, $where_pred='', $join='')</td>
        <td>&nbsp;</td>
        <td>The get_clients_list_where_pred() is used to fetch clients list via defined with total transaction and stores.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_id($username, $password='', $where='', $userId=false, $tbl='clientid_table')</td>
        <td>&nbsp;</td>
        <td>The use of get_clients_id() to fetch clients id via username</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_email($uid, $primary=false, $confirmed=true)</td>
        <td>&nbsp;</td>
        <td>The get_clients_email() is used to fetch email id from clients_emails table of a merchant.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">count_clients_emails($uid, $primary=false, $confirmed=true)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_email_details($uid, $primary=false, $confirmed=true)</td>
        <td>&nbsp;</td>
        <td>The get_email_details() used to fetch all details from clients_emails table of a clients</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnclientsemails($uid)</td>
        <td>&nbsp;</td>
        <td>The use of prnclientsemails() return email list with mailto link</td>
      </tr>
      <tr>
        <td class="fw-bold-11">add_email($uid, $email, $admin=false)</td>
        <td>&nbsp;</td>
        <td>This function used to add new email in clients_emails table</td>
      </tr>
      <tr>
        <td class="fw-bold-11">activate_email($uid, $verifcode)</td>
        <td>&nbsp;</td>
        <td>The activate_email() is used to activate email and send email after activate.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">make_email_prim($uid, $email, $eid=0)</td>
        <td>&nbsp;</td>
        <td>The make_email_prim() is used to set email as primary email</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_email_detail($eid, $type='ALL')</td>
        <td>&nbsp;</td>
        <td>The get_email_detail() is used to fetch detail from clients_emails</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_clients_email($uid, $eid)</td>
        <td>&nbsp;</td>
        <td>The delete_clients_email() is used to delete an email from clients_emails. Delete only non-primary email</td>
      </tr>
      <tr>
        <td class="fw-bold-11">email_exists ($email)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_user_id($unoremail)</td>
        <td>&nbsp;</td>
        <td>The get_user_id() is used to fetch id / clientid id of a clients by username or email</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_sponsors_mem($uid, $json=0, $sponsorList=0)</td>
        <td>&nbsp;</td>
        <td>The get_sponsors_mem() is used to fetch sponsors clients</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_access_admin_role($admin_access_id)</td>
        <td>&nbsp;</td>
        <td>The use of get_access_admin_role() to return merchant access roles/permission</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_sponsors($uid, $associateid, $allMid=0)</td>
        <td>&nbsp;</td>
        <td>The get_sponsors() is used to fetch sponsors</td>
      </tr>
      <tr>
        <td class="fw-bold-11">uniqueValue($value, $delimiter=',', $retrunArray=0)</td>
        <td>&nbsp;</td>
        <td>The uniqueValue() used to filter/fetch uniquie value ofrm an array or string</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_username($uid)</td>
        <td>&nbsp;</td>
        <td>This function is used to get username of a clients </td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_id_byusername($uid)</td>
        <td>&nbsp;</td>
        <td>This function is used to get clients table id via username.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">save_remote_ipadd($ip, $attempts, $today)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">save_remote_ipaddress($ip)</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_name($uid)</td>
        <td>&nbsp;</td>
        <td>This function is used to get clients name via id</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_dispute_info($dispute_id)</td>
        <td>&nbsp;</td>
        <td>The get_dispute_info() is used to return dispute transaction detail</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_info($uid)</td>
        <td>&nbsp;</td>
        <td>The get_clients_info() is used to fetch full information of a clients</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_status($uid)</td>
        <td>&nbsp;</td>
        <td>The get_clients_status() is used to fetch status of a clients</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_ip_history($uid, $order='')</td>
        <td>&nbsp;</td>
        <td>The get_ip_history() is used to get full login of a clients or subadmin.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">is_clients_found($username, $password)</td>
        <td>&nbsp;</td>
        <td>The is_clients_found() is used to check clients exists with specific username and password</td>
      </tr>
      <tr>
        <td class="fw-bold-11">is_clients_active($username, $tbl='clientid_table')</td>
        <td>&nbsp;</td>
        <td>The is_clients_active() is used to check specific clients is active or not</td>
      </tr>
      <tr>
        <td class="fw-bold-11">set_clients_status($uid, $active)</td>
        <td>&nbsp;</td>
        <td>The set_clients_status() is used to update clients status</td>
      </tr>
      <tr>
        <td class="fw-bold-11">set_clients_approve($uid, $edit_permission)</td>
        <td>&nbsp;</td>
        <td>The set_clients_approve() is used to update clients permission</td>
      </tr>
      <tr>
        <td class="fw-bold-11">principal_update($uid, $post, $update='', $action='')</td>
        <td>&nbsp;</td>
        <td>The principal_update() is used to update encoded_contact_person_info of a clients.</td>
      </tr>
      <tr>
        <td class="fw-bold-11">principal_view_sil($uid=0, $admin=false, $class='dta1')</td>
        <td>&nbsp;</td>
        <td>No any use</td>
      </tr>
	  
	  <tr>
        <td class="fw-bold-11">get_ims_icon($icon)</td>
        <td>&nbsp;</td>
        <td>The get_ims_icon() is used to shows social icons</td>
      </tr>
	  
	  <tr>
        <td class="fw-bold-11">spoc_view($uid=0,$admin=false,$class='dta1')</td>
        <td>&nbsp;</td>
        <td>Display Spoc Information</td>
      </tr>
      <tr>
        <td class="fw-bold-11">principal_view($uid=0, $admin=false, $class='dta1')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">principal_count($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_principal($uid=0, $match='', $admin=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">verify_email_phone($uid=0, $post=[], $action='', $otp='', $admin=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">set_clients_status_ex($uid, $status)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_status_ex($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">set_clients_inactive($username)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_clients($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">block_clients($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_ipaddress_list()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_roles_list($sid=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_subadmin_list($where_pred='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_edit_roles_list($id, $insert=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_edit_subadmin_list($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_balance($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">set_last_access($username)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">set_last_access_date($uid, $reset=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">save_remote_ip($uid, $address)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">is_valid_mail($email)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_by_email($email)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">is_info_empty($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_info($uid, $post)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">create_client_info($post, $admin=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_epn_info($post, $sid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">deleted_profile_email($uid, $email)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_client_info($post, $uid, $notify=false, $admin=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_private_info($post, $uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">twoGmfa($sid=0, $mid=0, $code=0, $post=NULL)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">Google_Code_Generate($uid, $tbl='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_clients_password($uid, $password, $previous_passwords='', $notify=true, $google_auth_access='', $tbl='clientid_table')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_clients_question($uid, $question, $answer, $notify=true)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_email_info($email, $uid, $notify=true)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_email_info($gid, $tid='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">send_email_request($gid, $email='', $eid=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">set_default_email($gid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_card_info($post, $uid, $notify=true)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_card_info($post, $gid, $uid, $notify=true)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_card($gid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_cards($uid, $hiden=true, $id=0, $single=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_bank($gid, $primary=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_crpto($gid, $primary = 0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_access_roles($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_subadmin_roles($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_banks($uid, $id='', $single=false, $primary=false, $status=0, $tbl='banks')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_coin_wallet($uid, $id=0, $single=false, $primary=false, $status=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">banks_primary($uid, $tbl='banks')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">set_tr_acquirer($uid, $dir, $as='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_trans_count($where='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_transactions_summ($where)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_transactions_summary($dateA, $dateB)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_transactions_year()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_transactions_period()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">can_refund($id, $uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_status_color($status)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_transactions($uid, $dir='both', $type=-1, $status=-1, $start=0, $count=0, $order='', $suser='', $sdate='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      
      <tr>
        <td class="fw-bold-11">update_dispute_table($dispute_id, $note)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_dispute_status($dispute_id, $status)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_transaction_between($uid, $date1, $date2)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_transaction_between_unreg($uid, $date1, $date2)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_dispute_detail()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_user_dispute($u_id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_dispute($t_id, $uid, $dispute_name)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_receiver($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_commissions($uid, $amount)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">unreg_clients_pay($sender, $receiver, $amount, $comments) </td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_unreg_clients_pay($uid, $which='SENDER', $status=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_unreg_clients_pay($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_unreg_clients_pays($receiver)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_transaction_status($uid, $id, $status)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_terminal($uid, $type, $post, $admin=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_terminal($id, $post, $admin=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_status_terminal($id, $where_pred)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_status_terminal_bank($id, $where_pred, $tab="banks")</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_sold_terminal($id, $quantity)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">api_public_key($uid, $id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">generate_secret_key($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_terminal($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_card_details($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_clients_card($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_button($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_type($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_subscription($clientid, $clients, $product)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_subscriptions($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">cancel_subscription($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_referrals_count($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">optimize($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">calculate_downline($uid, $clevel, $result=null)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_referrals($uid, $start=0, $count=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_news($where)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_latest_news()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_banners($clientid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">fetch_banner($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_banner($clientid, $burl, $lurl, $pkg, $per)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_banners($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_banner_id()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">inc_banner_views($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">inc_banner_clicks($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_banners_packages()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">fetch_banners_packages($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_mail_templates()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_mail_template($key)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_mail_template($key, $name, $value)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_categories_tree($categoryid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_first_root_category_id()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_category_parent($categoryid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shop_categories_count($categoryid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shop_categories_list($categoryid, $start=0, $count=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shop_categories_count_where_pred($where_pred)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shop_categories_list_where_pred($where_pred)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_category($parentid, $post)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_category($categoryid, $parentid, $post)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_category($categoryid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_category($categoryid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shop_items_count($categoryid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shop_items_list($categoryid, $start=0, $count=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shop_items_count_where_pred($where_pred)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shop_items_list_where_pred($where_pred)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shop_item($itemid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_shop_item($categoryid, $name, $url, $description)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_shop_item($itemid, $name, $url, $description)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_shop_item($itemid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_shopcart_item($productid, $quantity)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shopcart_items_list($id=-1)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">delete_shopcart_item($itemstodel)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_shopcart_items_price()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_one_item_price($id)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_shopcart_item_quantity($id, $quantity)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">set_shopitems_paid()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">unhtmlentities($text)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">encrypt_pages($content)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">encrypt($content)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">create_auto_account($autopost)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">generate_pin_code()</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">select_mer_setting($uid, $id=0, $single=false, $account_type='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">create_mer_setting($post, $uid, $notify=true)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_mer_setting($post, $gid, $uid, $notify=true)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      
      <tr>
        <td class="fw-bold-11">delete_mer_setting($gid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_micro_trans_info($post, $uid, $notify=true)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">scrubbed_trans($uid, $account_type, $trans_id='', $email='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_trans_ranges($uid, $status, $trange='', $paydate='',  $update_tr=true,  $adm_login=true, $json_value='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">unique_id_tr_trans($trid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      
      <tr>
        <td class="fw-bold-11">gen_transID_f($transID)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      
      <tr>
        <td class="fw-bold-11">transaction($sender, $receiver, $amount, $fees, $type, $status, $comments='', $ecomments='', $name='', $address='', $city='', $state='', $zip='', $email='', $ccno='', $billphone='', $product_name='', $source_url='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">create_new_trans($merID, $bill_amt, $acquirer, $trans_status,$fullname='', $bill_address='', $bill_city='', $bill_state='', $bill_zip='', $bill_email='', $ccno='', $bill_phone='', $product_name='', $source_url='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">send_mass_email($subject, $message, $active=-1, $account_type='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_subadmin_info($post)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_subadmin_info($post, $sid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_bank_info($post, $uid, $notify=true, $admin=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_bank_info($post, $gid, $uid, $notify=true, $admin=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">insert_coin_wallet_info($post, $uid, $notify = true, $admin = false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">update_coin_wallet_info($post, $gid, $uid, $notify = true, $admin = false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">trans_countsf($where='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_transactions_1($uid, $dir='both', $type=-1, $status=-1, $start=0, $count=0, $order='', $suser='', $sdate='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">prnpays_crncy($summ, $account_type='', $uid='', $currname='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">clients_review_counts($uid=0, $where_pred='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_trans_reply_counts($uid=0, $reply_status=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_support_tickets_count($status=0, $filterid=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_count($active=0, $order=0, $join='', $where='', $in_id='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_clients_list($active=0, $start=0, $count=0, $online=false, $order=0, $join='', $where='', $in_id='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_counts_transf($uid, $dir='both', $extra='1')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">common_trans_detail($id, $uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">upgrade_limit($uid, $post)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">upgrade_limit_amt($uid, $admin=false)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">unsetf_t($t)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_email_details_count($status=0, $filterid=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">createDateRanges($startDate, $endDate, $format = "Y-m-d")</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">monthly_fee_f($uid=0, $array=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">daily_trans_statement_amt($uid=0, $currentDate='', $checkBatchDate='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">daily_trans_statement_insert($uid=0, $post='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">daily_trans_statement_update($pid, $post='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">account_trans_balance($uid=0, $currentDate='', $tr_id=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">merchant_balance($uid=0, $currentDate='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">account_trans_balance_calc($uid=0, $currentDate='', $tr_id=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">account_trans_balance_calc_d($uid=0, $currentDate='', $tr_id=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">account_balance($uid=0, $tr_id=0, $currentDate='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">ms_virtual_fee($uid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">daily_statement_insert($uid=0, $post='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">daily_statement_amt($uid=0, $currentDate='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">payout_trans($uid=0, $currentDate='', $type=2)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">payout_trans2($uid=0, $currentDate='', $type=2)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">generate_password( $length = 8 )</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">csa($string, $separator = ',')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">hash_f($password)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">user_block_time($uid, $tbl='clientid_table')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">check_user_block_time($uid, $tbl='clientid_table')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">user_un_block_time($uid, $tbl='clientid_table')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">codereset($mid, $tbl, $ajax)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">codedisable($mid, $tbl)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">merchant_details($ajax=0)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">getTerminalidf($mid, $ajax)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">getacquireridsf($wid, $ajax)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">rand_string( $length = 8 )</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">email_first_letter_remove($email)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">rand_email($email)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">json_encode_str($json_str, $key, $value)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">get_file_extention($filename)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">bankdoc_img($gid, $ajax)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">encode_imgf($imgData, $path='')</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">display_docfile($path, $fileName="")</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">getuserimage($user, $ajax)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">opps_midf($mid)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">decriptimg($img, $ajax)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
      <tr>
        <td class="fw-bold-11">encrypt_decrypt($action, $string)</td>
        <td>&nbsp;</td>
        <td>xxxxx</td>
      </tr>
    <?*/
  }
    ?> 

      <?=@$functionlist;?>


    </tbody>
  </table>
</div>


<script>
  //Get the button
let mybutton = document.getElementById("btn-back-to-top");

// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function () {
  scrollFunction();
};

function scrollFunction() {
  if (
    document.body.scrollTop > 20 ||
    document.documentElement.scrollTop > 20
  ) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}
// When the user clicks on the button, scroll to the top of the document
mybutton.addEventListener("click", backToTop);

function backToTop() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}
</script>



<script type="text/javascript">

const hilite = (match) => `<span class="highlight">${match}</span>`;
const changeText = (str,filterRe) => {
  const fragment = document.createElement('div');
  fragment.innerHTML = str;
  // handle ONE level
  [...fragment.childNodes].forEach(node => {
    if (node.nodeType === 1) node.innerHTML = node.textContent.replace(filterRe, hilite);
    else {
      let text = node.textContent;
      const newNode = document.createElement('span');
      newNode.innerHTML = text.replace(filterRe, hilite);
      node.parentNode.replaceChild(newNode,node)
    }
  });
  return fragment.innerHTML;
};
window.addEventListener('DOMContentLoaded', () => {
  const trs = document.querySelectorAll('#myTable tbody tr');
  [...document.querySelectorAll('#myTable tbody tr td')].forEach(td => td.dataset.savecontent = td.innerHTML);
  document.getElementById('myInput').addEventListener('input', (e) => {
    const filter = e.target.value;
    const filterRe = filter.length === 0 ? "" : new RegExp(filter, "gi"); // create a regex from input
    trs.forEach(tr => {
      let tds = tr.querySelectorAll('td');
      tds.forEach(td => {
        let content = td.dataset.savecontent;
        td.innerHTML =  filterRe ? changeText(content,filterRe) : content;
      });
      tr.hidden = filter && !tr.querySelector('.highlight'); // show if there is a filter and the row has a match
    });
  });
});


</script>

<script>

function replaceText(table,searchword) {

  $(table).find(".highlight").removeClass("highlight");

  //var searchword = $("#searchtxt").val();

  var custfilter = new RegExp(searchword, "ig");
  var repstr = "<span class='highlight'>" + searchword + "</span>";

  if (searchword != "") {
      $(table).each(function() {
          $(this).html($(this).html().replace(custfilter, repstr));
      })
  }
}

$(document).ready(function(){
  $("#myInput_XXX").on("keyup", function() {
    var value = $(this).val().toLowerCase();

    //replaceText("#myTable",$(this).val());
    //console.log(value);

     


    $("#myTable tr").filter(function() {
      //$('.highlight').removeClass('highlight');
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);

        //$('.highlight').removeClass('highlight');
        // console.log(value);
        //$("#myTable tr").find(value).addClass('highlight');

        
    });

    
       
      
  });
  
  
});
</script>

<script>
function HighlightText(elements, txt) {
    $.each(elements, function () {
        var node = $(this);
        var src_str = node.text();
        txt = txt.replace(/(\s+)/, "(<[^>]+>)*$1(<[^>]+>)*");
        var pattern = new RegExp("(" + txt + ")", "gi");
        if (txt != "") {
            src_str = src_str.replace(pattern, "<mark>$1</mark>");
            src_str = src_str.replace(/(<mark>[^<>]*)((<[^>]+>)+)([^<>]*<\/mark>)/, "$1</mark>$2<mark>$4");
            node.html(src_str);
        } else {
            src_str = src_str.replace("<mark>$1</mark>", pattern);
            node.html(src_str);
        }
    });
}
function myFunction_s() 
{
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    //td = tr[i].getElementsByTagName("td")[0];
    td = tr[i];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
       // (txtValue.toUpperCase()).addClass('highlight');
        tr[i].style.display = "";
       // $(this).html().replace(new RegExp(term + "(?=[^>]*<)","ig"), "<mark>$&</mark>");
      } else {
        tr[i].style.display = "none";

      }
    }       
  }

  HighlightText("#myTable", input.value);
 // replaceText("#myTable",filter);

}
</script>

<?/*?>
<link href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.css" rel="stylesheet">
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js" type="text/javascript"></script>
<script type="text/javascript">
  new DataTable('#myTable');
</script>
<?*/?>
<? }else{?>
SECURITY ALERT: Access Denied
<? }?>
