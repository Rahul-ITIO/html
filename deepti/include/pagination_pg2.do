<??><style>

/**********		pagination	******************************************************************/

ul.pagination{ margin:0px; padding:0px; overflow:hidden; list-style-type:none; font-family: Verdana,Tahoma,Trebuchet MS,Arial;font-size:11px; }
ul.pagination li.details{ padding:7px 10px 7px 10px; font-size:14px; }
ul.pagination li.dot{padding: 3px 0; }
ul.pagination li{ float:left; margin:0px; padding:0px; margin-left:5px; }
ul.pagination li:first-child{ margin-left:0px; }
ul.pagination li a{ color:black; display:block; text-decoration:none; padding:7px 10px 7px 10px; font-family: Verdana,Tahoma,Trebuchet MS,Arial;font-size:11px; }
ul.pagination li a img{ border:none; }
ul.pagination li.details{ color:#888888; }
ul.pagination li a { color:#FFFFFF; border-radius:3px; -moz-border-radius:3px; -webkit-border-radius:3px; }
ul.pagination li a { color:#474747; border:solid 1px #B6B6B6; padding:6px 9px 6px 9px; background:#E6E6E6; background:-moz-linear-gradient(top,#FFFFFF 1px,#F3F3F3 1px,#E6E6E6); background:-webkit-gradient(linear,0 0,0 100%,color-stop(0.02,#FFFFFF),color-stop(0.02,#F3F3F3),color-stop(1,#E6E6E6)); }
ul.pagination li a:hover, ul.pagination li a.current { background:#FFFFFF; }
ul.pagination li a:hover{border-color:#37a6cd !important;background:#37a6cd !important; }

div.pagination { padding: 3px; margin: 3px; }
div.pagination a { padding: 2px 5px 2px 5px; margin: 2px; border: 1px solid #AAAADD; text-decoration: none; color: #000099; }
div.pagination a:hover, div.pagination a:active { border: 1px solid #000099; color: #000; }
div.pagination span.current { padding: 2px 5px 2px 5px; margin: 2px; border: 1px solid #000099; font-weight: bold; background-color: #000099; color: #FFF; }
div.pagination span.disabled { padding: 2px 5px 2px 5px; margin: 2px; border: 1px solid #EEE; color: #DDD; }

</style>
<?php function pagination($per_page=100,$page=1,$url='',$totalcount=0){
		//$per_page=100;
    	$total = (int)$totalcount;
        $adjacents = "5"; 

    	$page = ($page == 0 ? 1 : $page);  
    	$start = ($page - 1) * $per_page;								
		
    	$prev = $page - 1;							
    	$next = $page + 1;
        $lastpage = ceil($total/$per_page);
    	$lpm1 = $lastpage - 1;
    	
    	$pagination = "";
    	if($lastpage > 1)
    	{	
    		$pagination .= "<ul class='pagination'>";
            $pagination .= "<li class='details'>Page $page of $lastpage</li>";
			$pagination.= "<li><a class='datahref' data-href='{$url}&page=$prev'>Previous</a></li>";	
			
    		if ($lastpage < 7 + ($adjacents * 2))
    		{	
    			for ($counter = 1; $counter <= $lastpage; $counter++)
    			{
    				if ($counter == $page)
    					$pagination.= "<li><a class='current'>$counter</a></li>";
    				else
    					$pagination.= "<li><a class='datahref' data-href='{$url}&page=$counter'>$counter</a></li>";					
    			}
    		}
    		elseif($lastpage > 5 + ($adjacents * 2))
    		{
    			if($page < 1 + ($adjacents * 2))		
    			{
    				for ($counter = 1; $counter < 4 + ($adjacents * 2); $counter++)
    				{
    					if ($counter == $page)
    						$pagination.= "<li><a class='current'>$counter</a></li>";
    					else
    						$pagination.= "<li><a class='datahref' data-href='{$url}&page=$counter'>$counter</a></li>";					
    				}
    				$pagination.= "<li class='dot'>...</li>";
    				$pagination.= "<li><a class='datahref' data-href='{$url}&page=$lpm1'>$lpm1</a></li>";
    				$pagination.= "<li><a class='datahref' data-href='{$url}&page=$lastpage'>$lastpage</a></li>";		
    			}
    			elseif($lastpage - ($adjacents * 2) > $page && $page > ($adjacents * 2))
    			{
    				$pagination.= "<li><a class='datahref' data-href='{$url}&page=1'>1</a></li>";
    				$pagination.= "<li><a class='datahref' data-href='{$url}&page=2'>2</a></li>";
    				$pagination.= "<li class='dot'>...</li>";
    				for ($counter = $page - $adjacents; $counter <= $page + $adjacents; $counter++)
    				{
    					if ($counter == $page)
    						$pagination.= "<li><a class='current'>$counter</a></li>";
    					else
    						$pagination.= "<li><a class='datahref' data-href='{$url}&page=$counter'>$counter</a></li>";					
    				}
    				$pagination.= "<li class='dot'>..</li>";
    				$pagination.= "<li><a class='datahref' data-href='{$url}&page=$lpm1'>$lpm1</a></li>";
    				$pagination.= "<li><a class='datahref' data-href='{$url}&page=$lastpage'>$lastpage</a></li>";		
    			}
    			else
    			{
    				$pagination.= "<li><a class='datahref' data-href='{$url}&page=1'>1</a></li>";
    				$pagination.= "<li><a class='datahref' data-href='{$url}&page=2'>2</a></li>";
    				$pagination.= "<li class='dot'>..</li>";
    				for ($counter = $lastpage - (2 + ($adjacents * 2)); $counter <= $lastpage; $counter++)
    				{
    					if ($counter == $page)
    						$pagination.= "<li><a class='current'>$counter</a></li>";
    					else
    						$pagination.= "<li><a class='datahref' data-href='{$url}&page=$counter'>$counter</a></li>";					
    				}
    			}
    		}
    		
    		if ($page < $counter - 1){ 
    			$pagination.= "<li><a class='datahref' data-href='{$url}&page=$next'>Next</a></li>";
                $pagination.= "<li><a class='datahref' data-href='{$url}&page=$lastpage'>Last</a></li>";
    		}else{
    			$pagination.= "<li><a class='current'>Next</a></li>";
                $pagination.= "<li><a class='current'>Last</a></li>";
            }
    		$pagination.= "</ul>\n";		
    	}
    
    
        echo $pagination;
    } 
?>	