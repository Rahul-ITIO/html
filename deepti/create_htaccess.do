<?
//echo "<h1>Server can not handle your request : IP - ".strip_tags(trim($_SERVER['REMOTE_ADDR']))." </h1>"; exit;

if(!isset($_SESSION)) {session_start();}

if(isset($_SERVER['SERVER_SIGNATURE'])){
	unset($_SERVER['SERVER_SIGNATURE']);
}


//$dataDb['db_ip_count']=0;

#############################################################################


function strip_tagsf($str,$key=''){
        if($key=='email'){
                $str = str_replace(array("'","’",'+',' '),'',$str);
        }else{
                $str = str_replace( array( "'", "’" ), '', $str);
        }
        if($str && is_string($str)){
                                $str = urldecode($text);

                                $str = str_ireplace(array('onmouseover','onclick','onmousedown','onmousemove','onmouseout','onmouseup','onmousewheel','onkeyup','onkeypress','onkeydown','oninvalid','oninput','onfocus','ondblclick','ondrag','ondragend','ondragenter','onchange','ondragleave','ondragover','ondragstart','ondrop','onscroll','onselect','onwheel','onblur','<','>',"'"), '', $str );

                $str=strip_tags(trim($str));
        }
        return $str;
}
function get_request(){
        global $_REQUEST;
        $result=array();
        foreach($_REQUEST as $key=>$value)$result[$key]=strip_tagsf($value,$key);
        reset($_REQUEST);
        return $result;
}

#############################################################################

function create_htaccessf(){

        global $_REQUEST; global $dataDb; $folder_json='log/';

        //$data_ex['ex']='.do';
        $data_ex['ex']='';

        $folder='';

        #########################################

                //for unblock time: 10 minutes
                $current_ten_minutes=date('YmdHis', strtotime("-10 minutes"));

                //for block within time: 10 seconds
                $current_ten_seconds=date('YmdHis', strtotime("-10 seconds"));

                $ip_match_count=0; // get daynamic

                $ip_match_count_set=5;  // none db

        ########################################

            $data['skipInstanceIp']=array(
				'app1_pub'=>'13.233.167.170', 
				'app1_pri'=>'172.31.38.7',
				'app2_pub'=>'13.232.229.139', 
				'app2_pri'=>'172.31.14.188'
			);

        ########################################

                $deny_from_ip='';$deny_from_ips=[];
                $qp=0;$k=0;$arr=[];$requestArr=[];$exceptions_prnt=0;$deny_from_ip_loop_position=0;$counts_save=0;
                $ip_match_count_set=5;

        if(isset($_REQUEST['qp'])){ $qp=1; }

        if($_REQUEST){$requestArr=get_request();}

        if(isset($requestArr['ccno']))unset($requestArr['ccno']);
        if(isset($requestArr['ccvv']))unset($requestArr['ccvv']);
        if(isset($requestArr['month']))unset($requestArr['month']);
        if(isset($requestArr['year']))unset($requestArr['year']);

        ########################################

        $file_path=($folder_json."htaccess.json");
        if(file_exists($file_path)){
                $str_data = file_get_contents($file_path);
                $arr = json_decode($str_data,true);
                if($arr){
                        $a_size=sizeof($arr);
                        if($a_size){$k=$a_size; }
                }
        }

        $k=$k+1;
        $protocol = isset($_SERVER["HTTPS"])?'https://':'http://';
        $urlpath=$protocol.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

        if(isset($_SESSION['client_ip'])&&$_SESSION['client_ip']){
                $remote_addr=$_SESSION['client_ip'];
        }else{
                $remote_addr=strip_tags(trim($_SERVER['REMOTE_ADDR']));
        }

        // client_ip manual add
        if(isset($requestArr['cip'])&&isset($_SESSION['login_adm'])){
                $remote_addr=strip_tags(trim($requestArr['cip']));
                $deny_from_ips[]=$remote_addr;
                $deny_from_ip_loop_position=1;
                $exceptions_prnt=1;
                $counts_save=1;
                $k=$k+1;
        }else {


        }



        if(isset($requestArr['sip'])&&isset($_SESSION['login_adm'])){
                $remote_addr=strip_tags(trim($requestArr['sip']));
        }
        if(!isset($_SESSION['visit_ip'][$remote_addr])){
                echo "This is the first time you're visiting this server\n";
                $_SESSION['visit_ip'][$remote_addr]['ip']=$remote_addr;
                $_SESSION['visit_ip'][$remote_addr]['date']=date('Y-m-d H:i:s');
                $_SESSION['visit_ip'][$remote_addr]['counts']=1;
        }
        else{
                echo "Your number of visits: ".$_SESSION['visit_ip'][$remote_addr]['counts'] . "\n";
                $_SESSION['visit_ip'][$remote_addr]['counts']++;

                if(($_SESSION['visit_ip'][$remote_addr]['counts']==$ip_match_count_set)&&(!in_array($_SESSION['visit_ip'][$remote_addr]['ip'], $data['skipInstanceIp']))){
                        $remote_addr=$_SESSION['visit_ip'][$remote_addr]['ip'];
                        $deny_from_ips[]=$remote_addr;
                        $deny_from_ip_loop_position.=2;
                        $exceptions_prnt=1;
                        $counts_save=1;
                        $k=$k+1;
                }

        }



        // client_ip get : count min count 5 from same transactions ip
        if((isset($dataDb['db_ip_count']))&&(!in_array($remote_addr, $data['skipInstanceIp']))){
                $deny_from_ips[]=$remote_addr;
                $deny_from_ip_loop_position=3;
                $exceptions_prnt=1;
                $counts_save=1;
                $ip_match_count_set=1;
                $k=$k+1;
        }




        $arr[$k]['ip']=$remote_addr;
        $arr[$k]['date']=date('Y-m-d H:i:s');
        if($counts_save==1){
                $arr[$k]['counts']=''.($ip_match_count_set+1).'';
        }
        $arr[$k]['urlpath']=$urlpath;
        $arr[$k]['request']=($requestArr);

        if($qp){
                echo "<br/><<=arr==><br/>";
                print_r($arr);

        }

        #########################################



        ########################################


                if($qp){
                        echo "<br/>remote_addr=>".$remote_addr."<br/>";
                        echo "<br/>Current Date=>".date('Y-m-d H:i:s')."<br/>";
                        echo "10 Min. Date=>".date('Y-m-d H:i:s',strtotime($current_ten_minutes))."<br/><br/><br/>";
                }

                ########################################

                $arr_en=json_encode($arr,1);


                ########################################

                $j=0;
                foreach($arr as $key=>$val){
                        $j++;

                        $data_date=date('YmdHis', strtotime($val['date']));

                        if(isset($val['counts'])&&$val['counts']){
                                //$ip_match_count=(int)($val['counts']);

                                $deny_from_ips[]=$val['ip'];
                                $deny_from_ip_loop_position=4;
                                $exceptions_prnt=1;

                        }else{

                        }

                        $ip_match_count=((count(explode('"ip":"'.$val['ip'].'"',$arr_en)))-1);

                        if($qp){
                                echo "<br/><<=ip {$val['ip']} counts=>>".$ip_match_count."<br/>";
                        }


                        // ip block within time: 10 seconds and count min. 5 OR 1 db_ip_count
                        if(($data_date<=$current_ten_seconds)&&($ip_match_count>=$ip_match_count_set)&&(!in_array($val['ip'], $data['skipInstanceIp']))){

                                $deny_from_ips[]=$val['ip'];
                                $deny_from_ip_loop_position=5;
                                $exceptions_prnt=1;

                                //echo "<br/> 3 deny_from_ip ip =>".$deny_from_ip."<br/>";

                        }

                        //unblock ip after 10 minutes
                        if($data_date<$current_ten_minutes){  // less than 10 minutes
                                if(in_array($val['ip'], $deny_from_ips)){
                                        unset($deny_from_ips[$val['ip']]);
                                        $deny_from_ips = array_diff($deny_from_ips, array($val['ip']));
                                }
                                unset($arr[$key]); // remove array value

                                if(isset($_SESSION['visit_ip'][$val['ip']])){
                                        unset($_SESSION['visit_ip'][$val['ip']]);
                                }

                                if($qp){
                                        echo $j .". remove ip =>".$val['ip']." | Date=>".date('Y-m-d H:i:s',strtotime($val['date']))."<br/>";
                                }
                        }else{ // above to 10 minutes

                                if((isset($dataDb['db_ip_count']))){
                                        $deny_from_ips[]=$val['ip'];
                                        $deny_from_ip_loop_position=6;
                                }

                                if($qp){
                                        echo $j .". | ip=>".$val['ip'].", Date=>".date('Y-m-d H:i:s',strtotime($val['date'])).", urlpath=>".$val['urlpath']."<br/>";
                                }


                        }


                }

                $deny_from_ips=array_unique($deny_from_ips);

                if($deny_from_ips){
                        foreach($deny_from_ips as $val){
                                $deny_from_ip.="                Deny from ".$val."\n";
                        }
                }



                if($qp){
                        echo "<br/><br/>ip_match_count=>".$ip_match_count."<br/>";
                        echo "<br/><br/>ip_match_count_set=>".$ip_match_count_set."<br/>";
                        echo "<br/><br/>deny_from_ip_loop_position=>".$deny_from_ip_loop_position."<br/>";

                        print_r($deny_from_ips);
                }

                if(isset($_SESSION['visit_ip'])&&$qp){
                        echo "<br/>SESSION=>";
                        print_r($_SESSION['visit_ip']);
                }

                //echo "deny_from_ip=>".$deny_from_ip; exit;

                #########################################

if($_SERVER["HTTP_HOST"]=='localhost'){
$str="<IfModule mod_rewrite.c>
        <FilesMatch \"vht|api|charge|paymentflow|processall\">
                ErrorDocument 403 requesthandle
                #ErrorDocument 403 /fujitsuwin10/test1/requesthandle{$data_ex['ex']}
                Order Allow,Deny
                Allow from all\n".$deny_from_ip."       </FilesMatch>
</IfModule>\n".

        ""
        ;
}else {
$str="<IfModule mod_rewrite.c>\n".
"       Options +FollowSymlinks\n".
"       Options -Indexes\n".
"       RewriteEngine On\n".
"       RewriteBase /\n".
"       RewriteRule ^@(.*) payattherate{$data_ex['ex']}  [L]\n".
"       RewriteRule ^payme/(.*)/ /payme/index{$data_ex['ex']}?user=$1 [L]\n".
"       RewriteRule ^quay/(.*)/ /quay/index{$data_ex['ex']}?user=$1 [L]\n".
"       RewriteCond %{HTTP_HOST} ^lbpgi-592033313.ap-south-1.elb.amazonaws.com$\n".
"       RewriteRule .* - [F,L]\n".
"       RewriteCond %{REQUEST_METHOD} ^(delete|head|trace|track) [NC]\n".
"       RewriteRule .* - [F,L]\n".
//"       RewriteCond %{THE_REQUEST} ^(GET|HEAD)\ /([^/]+)\.do(\?|\ |$)\n".
//"       RewriteRule ^ /%2/ [L,R=301]\n".
"       RewriteCond %{HTTP_HOST} ^www\.ipg.i15\.tech$ [OR]\n".
"       RewriteCond %{HTTP_HOST} ^ec2-13-232-229-139.ap-south-1.compute.amazonaws.com$ [OR]\n".
"       RewriteCond %{HTTP_HOST} ^ec2-13-233-167-170.ap-south-1.compute.amazonaws.com$ [OR]\n".
"       RewriteCond %{HTTP_HOST} ^13.233.167.170$ [OR]\n".
"       RewriteCond %{HTTP_HOST} ^13.232.229.139$\n".
"       RewriteRule ^(.*)$ \"https\:\/\/ipg.i15\.tech\/$1\" [R=301,L]\n".

//"       RewriteRule ^([^\.]+)$ $1.do [NC,L]\n".

"       RewriteRule ^(.+)\.do$ /$1 [R,L]\n".
"       RewriteCond %{REQUEST_FILENAME}.do -f\n".
"       RewriteRule ^(.*?)/?$ /$1.do [NC,END]\n".
"       RewriteRule ^([^\.]+)$ /$1.php [NC,L]\n".

"       ErrorDocument 504 /error-code.do\n".
"       RewriteCond %{REQUEST_FILENAME} !-f\n".
"       RewriteCond %{REQUEST_FILENAME} !-d\n".
"       DirectoryIndex /index.do\n".
"       RewriteRule ^ /oops.do [L]\n".
//"               Order Allow,Deny\n".
//"               Allow from all\n".
"       <FilesMatch \"create_htaccess\">\n".
"               ErrorDocument 404 create_htaccess{$data_ex['ex']}\n".
"               ErrorDocument 403 create_htaccess{$data_ex['ex']}\n".
"       </FilesMatch>\n".
"       <FilesMatch \"vht|api|charge|payment|paymentflow|processall|payattherate|payme|directapi|checkout|paycheckout\">\n".
"               ErrorDocument 403 <h1>Server&nbsp;can&nbsp;not&nbsp;handle&nbsp;your&nbsp;request</h1>\n".
"               Order Allow,Deny\n".
"               Allow from all\n".$deny_from_ip.
//"                                ".$deny_from_ip.
"       </FilesMatch>\n".
"       LimitRequestBody 10240000\n".
"</IfModule>\n".
"<IfModule mod_headers.c>\n".
//"       Header always unset X-Frame-Options\n".
"   Header set Cache-Control \"no-cache, no-store, must-revalidate\"\n".
"   Header set Pragma \"no-cache\"\n".
"   Header set Expires 0\n".
"       Header always append X-Frame-Options SAMEORIGIN\n".
"       Header add Strict-Transport-Security \"max-age=31536000; includeSubDomains; preload\"\n".
"       Header set X-Content-Type-Options nosniff\n".
"       Header set X-Permitted-Cross-Domain-Policies \"master-only\"\n".
"       Header set X-XSS-Protection \"1; mode=block\"\n".
"       Header edit Set-Cookie ^(.*)$ $1;HttpOnly;Secure\n".
"       Header set Content-Security-Policy \"default-src 'self'; font-src * 'unsafe-inline'; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; img-src * data: 'unsafe-inline'; connect-src * 'unsafe-inline'; frame-src *; iframe-src *; plugin-types application/pdf;\"\n".
"</IfModule>";
}

$str=str_replace(array("^M"),"",$str);

                $file=@fopen($folder.".htaccess", "w");
                if($file){
                        @fwrite($file, ($str));
                        @fclose($file);
                }



        $fh = fopen($folder_json."htaccess.json", 'w')
                  or die("Error opening output file");
        fwrite($fh, json_encode($arr,JSON_UNESCAPED_UNICODE));
        fclose($fh);

        if($exceptions_prnt){
                echo "<h1>Server can not handle your request : IP - {$remote_addr} </h1>"; exit;
        }

}
create_htaccessf();
?>

