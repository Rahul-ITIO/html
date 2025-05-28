<??><style>
/*from inc/pagi_new.d*/
.pagination {margin: 10px 0 5px 0;}
ul.pagination2 li a.current, ul.pagination li a.current {font-weight:bold;background:#192b33 !important;color:#fff !important;border-radius:3px;}
ul.pagination li.details {color: #888888;display:block;white-space:nowrap;}
</style>
<?php 
if(!isset($_SESSION['fwicon-caret-right'])){$_SESSION['fwicon-caret-right']="fas fa-caret-square-right";  }
if(!isset($_SESSION['fwicon-caret-left'])) {$_SESSION['fwicon-caret-left']="fas fa-caret-square-left";    }
if(!isset($_SESSION['fwicon-backward']))   {$_SESSION['fwicon-backward']="fas fa-fast-backward";          }
if(!isset($_SESSION['fwicon-forward']))    {$_SESSION['fwicon-forward']="fas fa-fast-forward";            }
if(!isset($_SESSION['fwicon-spinner']))    {$_SESSION['fwicon-spinner']="fas fa-spinner";                 }   


function short_pagination($per_page=100,$page=1,$url='',$totalcount=0, $show_last=0){

	global $data;
	$totalcount = (int)$totalcount;
	$page = (int)$page;

	$page = ($page == 0 ? 1 : $page);
	$start = ($page - 1) * $per_page;

	$prev = $page - 1;
	$next = $page + 1;

	$pagination = "";
	if($page > 1 || $totalcount>$per_page)
	{
		$pagination .= "<ul class='pagination2 pagination'>";

		if($page==1)
		{
			//$pagination .= "<li><a href='javascript:void(0);' class='disable'>Previous</a></li>";
		}
		else
		{
			if($show_last)
			{
				//$pagination.= '<li><a href="'.$url.'&page=1"><i class="" style="font-size:20px;"></i></a></li>';
			}
			$pagination.= '<li><a href="'.$url.'&page='.$prev.'"><i class="'.$_SESSION['fwicon-caret-left'].'" ></i></a></li>
			';
		}
		$pagination.= "<li><a class='current new' style='float1:right;'>$page</a>".(isset($_SESSION['DB_DURATION_NAME'])?"<div style='font-size:10px;font-style: italic;font-weight:bold;float:left;'>".$_SESSION['DB_DURATION_NAME']."</div>":'')."</li>";

		if ($per_page < $totalcount){ 
			$pagination.= '<li><a href="'.$url.'&page='.$next.'"><i class="'.$_SESSION['fwicon-caret-right'].'" 44></i></a></li>';

			{
				
				$ct_query = encryptres($data['ct_query']);

				if(isset($_SESSION['total_record_result']))
				{
					$pagination.= "<li><span id='total_record_result'><b>".$_SESSION['total_record_result']."</b></span></li>";
				}
				else
				{
					
					$_SESSION['main_url']=$url;

					if(isset($_REQUEST['date_1st'])&&trim($_REQUEST['date_1st']))
						$onclick='onclick';
					else $onclick='onclick="javascript:alert(\'Please filter the Timestamp - Date range!\');" data-onclick';

					$pagination.= "<li><a class='restartfa '  {$onclick}=\"ajaxf1(this,'{$data['Host']}/include/total_record_result{$data['ex']}?admin=1&page={$page}&sub_quer={$ct_query}','#total_record_result','1','2')\"><i></i><i class='".$_SESSION['fwicon-spinner']." ' style=''></i></a></li>";
				}
			}
		}
		$pagination.= "</ul>\n";
	}

	echo $pagination;
}
function pagination_new($per_page=100,$page=1,$url='',$totalcount=0){

	global $data;
	$totalcount = (int)$totalcount;
	$page = (int)$page;

	$page = ($page == 0 ? 1 : $page);
	$start = ($page - 1) * $per_page;

	$prev = $page - 1;
	$next = $page + 1;

	$last = ceil($totalcount/$per_page);

	$pagination = "";

	if(strpos($url,'?') !== false){$url .= '&';}else $url .= '?';

	if($page > 1 || $totalcount>$per_page)
	{
		$pagination .= "<ul class='pagination2 pagination'>";

		if($page==1)
		{
			//$pagination .= "<li><a href='javascript:void(0);' class='disable'>Previous</a></li>";
		}
		else
		{
			$pagination.= '<li><a href="'.$url.'"><i class="'.$_SESSION['fwicon-backward'].'" ></i></a></li>
			';
			$pagination.= '<li><a href="'.$url.'page='.$prev.'"><i class="'.$_SESSION['fwicon-caret-left'].'" ></i></a></li>
			';
		}
		$pagination.= "<li><a class='current'>$page</a></li>";

		if (($per_page*$page)< $totalcount){ 
			$pagination.= '<li><a href="'.$url.'page='.$next.'"><i class="'.$_SESSION['fwicon-caret-right'].'" ></i></a></li>';

			$pagination.= '<li><a href="'.$url.'page='.$last.'"><i class="'.$_SESSION['fwicon-forward'].'" ></i></a></li>';
		}
		$pagination.= "</ul>\n";
	}

	if($pagination)
	{
	?>		
		<div class="pagination" style="float:left; width:100%; text-align:center;"><?=$pagination;?></div>
	<?
	}
}
?>