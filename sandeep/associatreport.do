<?
$data['PageName']	= 'PDF PAYOUT STATEMENTS';
$data['PageFile']	= '';
$data['PageTitle'] 	= 'PDF Payout Statements'; 

###############################################################################
include('config.do');
###############################################################################
//error_reporting(E_ALL);
###############################################################################

if(!isset($_SESSION['adm_login'])){
       header("Location:{$data['slogin']}/login".$data['ex']);
       echo('ACCESS DENIED.');
       exit;
}


$adm_login=false;

if(isset($_SESSION['adm_login']) && isset($_GET['pdate']) && isset($_GET['bid']) ){
	$adm_login=true;
}

if($adm_login==true){
	$uid 	= $_GET['bid'];
	//$pdates	= $_GET['pdate'];
}else{
	$uid 	= $_SESSION['sub_admin_id'];
	//$pdates = date("Y-m-d");
}
if(isset($_GET['pdate'])){
	$pdates	= date('Y-m-d',strtotime($_GET['pdate']));
}else{
	$pdates = date("Y-m-d");
}



//echo "<hr/>pdates=>".$pdates; echo "<hr/>associate uid=>".$uid."<hr/>";



$post1=get_edit_subadmin_list($uid, $post);
$post=$post1[0];
$post['step']=1;

//print_r($post);
$post['fname']=isset($post['fname'])&&$post['fname']?$post['fname']:'';
$post['lname']=isset($post['lname'])&&$post['lname']?$post['lname']:'';
if(isset($post['fullname'])&&$post['fullname'])	{ //if fullname exist then use fullname
	$fullname=$post['fullname'];
}else {	//if fullname not exists then concat fname and lname
	$fullname=$post['fname']." ".$post['lname'];
}


$post['company_name']=$fullname;
//exit;

###############################################################################

//print_r($post); print_r($uid); echo "=h1=";


$account_type_arr=array();
$nick_name_card="";
$account_type_value="";
$account_type_whr="";
//$post['AccountsInfo']=select_accounts($uid);
$post['AccountsInfo']=mer_settings($uid);
$nick_name="";
$account_type="";


//echo "<br/>==4==>".$account_type;exit;

###############################################################################


//$payoutdays="16";$payout_days_name="Wednesday";$settel="10"; // eCheck
$payoutdays="60";$payout_days_name="Monday";$settel="15";	//associate
$settelement_period="";



###############################################################################

$cdate1 = date('Y-m-d',strtotime($pdates)); //date("Y-m-d"); "2017-06-18"; //date("2017-06-06");

$dateset = date('Y-m-d',strtotime($cdate1)); 
$sunday = date('D', strtotime($dateset));
if($sunday=="Sun")$dateset=date("Y-m-d",strtotime("-1 day",strtotime($dateset)));
if($payout_days_name=="Wednesday"){
	if($sunday=="Mon")$dateset=date("Y-m-d",strtotime("-2 day",strtotime($dateset)));
	elseif($sunday=="Tue")$dateset=date("Y-m-d",strtotime("-3 day",strtotime($dateset)));
}
$newdata = array();
global $newdata;

$newdata['currentdate']=date("Y-m-d", strtotime("first day of this month $cdate1"));
		$newdata['paydate']=date("Y-m-d", strtotime("first day of this month $cdate1"));
		//$newdata['paydate']=date("Y-m-d", strtotime("first day of this month $cdate1",strtotime($dateset)));


		$cdl60 = date("Y-m-d",strtotime("-2 month",strtotime($cdate1)));
$newdata['from_date']=date("Y-m-d",strtotime("first day of this month $cdl60"));
$newdata['to_date']=date("Y-m-d",strtotime("last day of this month $cdl60"));

$newdata['from_date_db']=date("Y-m-d",strtotime($newdata['from_date']));
$newdata['to_date_db']=date("Y-m-d",strtotime("+1 day",strtotime($newdata['to_date'])));
		
$true=0;			
	
if(isset($_GET['dtest'])){
	$true=1;	
	echo "<br>Current Date=>". date('D', strtotime($dateset))." = ". date("Y-m-d", strtotime($dateset));
	
	echo "<br><br>Payout Date=>". date('D', strtotime($newdata['paydate']))." = ". date("Y-m-d", strtotime($newdata['paydate']));
	
	echo "<br><br> -2 month=>". date('D', strtotime($cdl60))." = ". date("Y-m-d", strtotime($cdl60));
	
	echo "<br><br> Date Range=>". date('D', strtotime($newdata['from_date']))." = ". date("Y-m-d", strtotime($newdata['from_date']))." to ". date("d  / m", strtotime($newdata['to_date']));
	
	echo "<br><br>Completed Data Range=>". date('D', strtotime($newdata['from_date_db']))." = ". date("Y-m-d", strtotime($newdata['from_date_db']))." to ". date("d  / m", strtotime($newdata['to_date_db']));
	

	
	echo "<br><br>";
	foreach($newdata as $key=>$value){
		echo "<br> ".$key." : ".$value;
	}
	//exit;
}

if($post['step']==1){
			
			
			
						
			$pdf_download=true;
			
		
		
		
		if($adm_login==true){
			require('pdf/fpdfa.php');
		}else{
			require('pdf/fpdf.php');
		}


		
//start : class	

	
		class PDF extends FPDF {

			// Load data
			function LoadData($file){
				// Read file lines
				$lines = $file;
				$data = array();
				foreach($lines as $line)
					$data[] = explode(';',trim($line));
				return $data;
			}
			
			// Page header
			
			public function Header(){
			
				global $title;
				global $newdata;
				// Logo
				$this->Image('logo.png',10,8,30,0,'','');
				// Courier bold 15
				
				
				
				$this->SetFont('Helvetica','',10);
				$this->SetTextColor(0,0,0);
				$this->Cell(141);
				$this->Cell(200,-2,'Date     :  '.date("F d,Y",strtotime($newdata['paydate'])),0,0,'L');
				$this->Ln(0);
				$this->Cell(141);
				$this->Cell(200,18,'From    :  '.date("F d,Y",strtotime($newdata['from_date'])),0,0,'L');
				$this->Ln(0);
				$this->Cell(141);
				$this->Cell(200,28,'To        :  '.date("F d,Y",strtotime($newdata['to_date'])),0,0,'L');
				$this->Ln(0);
				
				
				
				$this->SetFont('Courier','B',18);
				// Move to the right
				$this->Cell(80);
				// Title
				$this->Cell(30,0,'Associate Statement',0,0,'C');
				$this->Ln(5);
				
				

				$this->Cell(45);	
					// Courier bold 15
				$this->SetFont('Courier','',10);
				
				// Calculate width of title and position
				$w = $this->GetStringWidth($title)+6;
				$this->SetX((210-$w)/2);
				// Title
				
				$this->Cell($w,9,$title,0,0,'C');
				//$this->SetTopMargin(100);
					
					
				// Line break
				$this->Ln(17);
			}

			// Page footer
			function Footer(){
				date_default_timezone_set("Canada/Saskatchewan");
				$current_date_time = date("d-m-Y h:i A"); 
				// Position at 1.5 cm from bottom
				$this->SetY(-15);
				// Courier italic 8
				$this->SetFont('Courier','I',9);
				$this->SetTextColor(0,0,0);
				// Page number
				$this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');
				$this->SetX(-83);
				$this->Cell(0,10,'Downloaded on '.$current_date_time.'(CST)',0,0,'C');
				
				
			}


			

			// 7 Col table
			function ImprovedTable($header, $data, $titlename, $titleln=0, $fill=false, $border='T'){
				$this->Ln($titleln);
				if(!empty($titlename)) {
					 // Courier 12
					
					
					
					$this->SetFont('Courier','',15);
					// Background color
					$this->SetFillColor(220,220,220);
					$this->SetTextColor(0,102,204);
					// Title
					//$this->Cell(0,8,$titlename,0,1,'L',true);
					$this->Cell(73,8,$titlename,"",1,'L');
					// Line break
					$this->Ln(4);
				}
				
				// Column widths
				$w = array(37, 80, 22, 15, 15, 25);
				// Header
				
				if($fill){
						$this->SetFont('Helvetica','B',11);
				}else {
					$this->SetFont('Helvetica','B',7);
				}
				$this->SetFillColor(240,240,240);
				$this->SetTextColor(0,0,0);
				for($i=0;$i<count($header);$i++){
					if($i===1 || $i===0){
						$this->Cell($w[$i],9,$header[$i],"B",0,'L',true);
					}else {
						$this->Cell($w[$i],9,$header[$i],"B",0,'C',true);
					}
				}
				$this->Ln();
				
				// Data
				$this->SetFont('Courier','',9);
				$this->SetTextColor(0,0,0);
				if(!empty($data[0])){
					foreach($data as $row){
						$this->Cell($w[0],6,@$row[0],0,0,'L',true);
						$this->Cell($w[1],6,@$row[1],0);
						$this->Cell($w[2],6,@$row[2],0,0,'R',true);
						$this->Cell($w[3],6,@$row[3],0,0,'R',true);
						$this->Cell($w[4],6,@$row[4],0,0,'R',true);
						$this->Cell($w[5],6,@$row[5],0,0,'C');
						if(@$row[6]) $this->Cell($w[6],6,@$row[6],0,0,'C',true);
						$this->Ln();
					}
				}
				// Closing line
				$this->Cell(array_sum($w),0,'',$border);
			}
			
			
			// 3 col table
			function ImprovedThreeColTable($data, $titlename, $titleln=0, $fontname=false, $fontcolor=0){
				$this->Ln($titleln);
				if(!empty($titlename)) {
					 // Courier 12
					
					$this->SetFont('Courier','',15);
					$this->SetTextColor(0,102,204);
					// Background color
					$this->SetFillColor(220,220,220);
					
					// Title
					$this->Cell(30,8,$titlename,"",1,'L');
					// Line break
					$this->Ln(4);
				}
				
				// Column widths
				$w = array(142, 30, 17);
				
				
				
				// Data
				if($fontname){
					$this->SetFont('Helvetica','B',10);
				}else {
					$this->SetFont('Courier','',12);
				}
				
				if($fontcolor==1){
					$this->SetTextColor(225,0,0);
				} else{
					$this->SetTextColor(0,0,0);
				}
				
				if(!empty($data[0])){
					foreach($data as $row){
						$this->Cell($w[0],7,$row[0],0,0);
						$this->Cell($w[1],7,$row[1],0,0,'R');
						$this->Cell($w[2],7,$row[2],0,0,'C');

						$this->Ln();
					}
				}
				// Closing line
				$this->Cell(array_sum($w),0,'','T');
			}
			
			
			
			// 4 col table
			function ImprovedFourColTable($data, $titlename, $titleln=0, $fill=false){
				$this->Ln($titleln);
				if(!empty($titlename)) {
					 // Courier 12
					
					$this->SetFont('Courier','',15);
					// Background color
					$this->SetFillColor(220,220,220);

					// Title
					$this->Cell(30,8,$titlename,"",1,'L');
					// Line break
					$this->Ln(4);
				}
				
				// Column widths
				$w = array(30, 74, 32, 53);
				
				
				
				// Data
				if($fill){
					$this->SetFont('Helvetica','B',10);
				}else {
					$this->SetFont('Helvetica','',9);
				}
				$this->Cell(array_sum($w),0,'','T');
				$this->Ln(2);
				if(!empty($data[0])){
					foreach($data as $row){
						$this->Cell($w[0],7,$row[0],0,0);
						$this->Cell($w[1],7,$row[1],0,0);
						$this->Cell($w[2],7,$row[2],0,0);
						$this->Cell($w[3],7,$row[3],0,0);

						$this->Ln();
					}
				}
				// Closing line
				$this->Ln(2);
				$this->Cell(array_sum($w),0,'','T');
				
			}
			
		// simple html desing 

			protected $B = 0;
			protected $I = 0;
			protected $U = 0;
			protected $HREF = '';

			function WriteHTML($html){
				// HTML parser
				
				$html = str_replace("\n",' ',$html);
				$a = preg_split('/<(.*)>/U',$html,-1,PREG_SPLIT_DELIM_CAPTURE);
				foreach($a as $i=>$e){
					if($i%2==0)
					{
						// Text
						if($this->HREF)
							$this->PutLink($this->HREF,$e);
						else
							$this->Write(5,$e);
					}
					else
					{
						// Tag
						if($e[0]=='/')
							$this->CloseTag(strtoupper(substr($e,1)));
						else
						{
							// Extract attributes
							$a2 = explode(' ',$e);
							$tag = strtoupper(array_shift($a2));
							$attr = array();
							foreach($a2 as $v)
							{
								if(preg_match('/([^=]*)=["\']?([^"\']*)/',$v,$a3))
									$attr[strtoupper($a3[1])] = $a3[2];
							}
							$this->OpenTag($tag,$attr);
						}
					}
				}
			}

			function OpenTag($tag, $attr){
				
				// Opening tag
				if($tag=='B' || $tag=='I' || $tag=='U')
					$this->SetStyle($tag,true);
				if($tag=='A')
					$this->HREF = $attr['HREF'];
				if($tag=='BR')
					$this->Ln(5);
			}

			function CloseTag($tag){
				// Closing tag
				if($tag=='B' || $tag=='I' || $tag=='U')
					$this->SetStyle($tag,false);
				if($tag=='A')
					$this->HREF = '';
			}

			function SetStyle($tag, $enable){
				// Modify style and select corresponding font
				$this->$tag += ($enable ? 1 : -1);
				$style = '';
				foreach(array('B', 'I', 'U') as $s)
				{
					if($this->$s>0)
						$style .= $s;
				}
				$this->SetFont('',$style);
			}

			function PutLink($URL, $txt){
				// Put a hyperlink
				$this->SetTextColor(0,0,255);
				$this->SetStyle('U',true);
				$this->Write(5,$txt,$URL);
				$this->SetStyle('U',false);
				$this->SetTextColor(0);
			}
			
			
		}


//end: class	
		

		// Instanciation of inherited class
		$pdf = new PDF();
		$title = $post['company_name']." ".$post['lname'];
		$pdf->SetTitle($title);

		$pdf->AliasNbPages();
		$pdf->AddPage();
		$pdf->SetFont('Arial','',10);
		
		

		$header 		= array('Transaction #', 'Name', 'Tr. Amount', 'Commission', 'Per I. Fee', 'MID');
		$completed_data = array();
		$pdf_result 	= array();
		$pdf_result['data']= array();
		
		$tr_amount		= 0;
		$total_txn_fee 	= 0;
		$total_dis_rate = 0;
		$total_rol_fee	= 0;
	
	
		$i=1;
		
		
		$pdftr=db_rows(
				"SELECT t.*,t.id AS trid,a.mdr_rate,a.txn_fee_success,a.reserve_rate, m.id AS m_id,m.company_name AS m_company".
				" FROM `{$data['DbPrefix']}{$data['MASTER_TRANS_TABLE']}` AS `t`, {$data['DbPrefix']}mer_setting AS a, {$data['DbPrefix']}clientid_table AS m".
				" WHERE (t.acquirer=a.acquirer_id) AND (a.merID={$uid}) AND (t.merID=a.sponsor) AND ( t.merID=m.id ) ".
				" AND (t.trans_status=1) ".
				" AND ( t.tdate between '".$newdata['from_date_db']."' AND '".$newdata['to_date_db']."' ) ".
				"AND  (m.active=1) AND (m.sponsor={$uid}) ".
				" GROUP BY t.id ORDER BY t.merID DESC",$true
			);
				
			if($pdftr&&$db_counts){
				foreach($pdftr as $key1=>$value2){
				  if($value2){
						if($value2['trans_status']==1){ // completed
							$tr_amount	= prnsum2($tr_amount+prnsum2($value2['trans_amt']));
							$dis_rate 	= prnsum2(prnsum2($value2['trans_amt'])/100)*prnsum2($value2['mdr_rate']);
							$rol_fee	= 0;
							$this_total	= prnsum2(prnsum2($value2['trans_amt']))-prnsum2($dis_rate+prnsum2($value2['txn_fee_success'])+prnsum2($rol_fee));
							
							$total_txn_fee = $total_txn_fee+prnsum2($value2['txn_fee_success']);
							
							$total_dis_rate = $total_dis_rate + $dis_rate;
							$total_rol_fee	= $total_rol_fee + $rol_fee;
							
							
							//$this_account_ids=$data['t'][$value2['type']]['name1'];
							
							$currname2="".get_currency($value2['bank_processing_curr'])."";
							/*
							$currname1=get_currency($value2['bank_processing_curr']);
							if(strpos($currname1,"â‚¬")!==false){
								$currname="€";
							}elseif(strpos($currname1,"€")!==false){
								$currname="€";
							}elseif(strpos($currname1,"â")!==false){
								$currname="&#8364;";
							}else{
								$currname=$currname1;
							}
							*/
							$completed_data[] .= $value2['transID'].";".$value2['fullname'].";".$currname2.bcadd(0,$value2['trans_amt'],2).";".bcadd(0,$dis_rate,2).";".bcadd(0,$value2['txn_fee_success'],2).";".$value2['merID'];
								
							/*if($i==$db_counts){
								$data_profie 	= array();
								$data_profie[] 	.= "  MID;:  ".$value2['m_id']."; Account Currency;:  ".$value2['m_id'];
								
								$data_profie[] 	.= "  Account ID;:  ".$value2['m_id']."; Settlement Currency;:  ".$value2['m_id']."";
								
								$data_pro = $pdf->LoadData($data_profie);
								$pdf->ImprovedFourColTable($data_pro,'');
							}*/
				
						
							$i++;
						}
					}
					
				}
				
				
				
				
				
				if($completed_data){
					
					$totalEarning=bcadd(0,$total_dis_rate+$total_txn_fee,2);
					$netAmount=$totalEarning;
				
					$data_profie 	= array();
					$data_profie[] 	.= "  Total Earning;:  ".$totalEarning."; ; Net Payable Amount : ".$netAmount;
					
					
					
					$data_pro = $pdf->LoadData($data_profie);
					$pdf->ImprovedFourColTable($data_pro,'');
					
								
					$header_total 	= array(' ', 'Total', bcadd(0,$tr_amount,2), bcadd(0,$total_dis_rate,2), bcadd(0,$total_txn_fee,2), $db_counts);
					
					$data_pdf = $pdf->LoadData($completed_data);
					if(!empty($data_pdf)){
						$pdf->ImprovedTable($header,$data_pdf,"",10);
						$pdf->ImprovedTable($header_total,$data_total = array(''),'',0,true);
					}
				}
			}
			
		
		$newdata['filename']=$post['company_name']."_payout_".$newdata['from_date']."_to_".$newdata['to_date'].".pdf";
		$filename=$newdata['filename']; 
		
		/*
		if($pdf_download==true){
			if($adm_login==true){
				$pdf->Output();
			}else{
				$pdf->Output('D',$filename,true);
			}
		}else{ echo"<script>alert('Fail to download the report please for assistance. Account Currency: ".$account_cur.", Settlement Currency: ".$req_currency." , Exchange Rate: false .');</script>";}
		
		*/
		
		if(isset($_GET['dtest'])||isset($_GET['atest'])){
			exit;
		}
		$pdf->Output();
	
	
}


?>