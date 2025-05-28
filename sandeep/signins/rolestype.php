
<?php 


  $id=$_GET['roles'];
if($id=='MEMBERS')
{	?>
        <select id="roleselect" name="subroles[]" multiple >
                       <option value="0">-Select-</option>
			
            		<option value="ACTIVE">ACTIVE</option>
                       <option value="SUSPENDED">SUSPENDED</option>
                       <option value="SEARCH">SEARCH</option>
                       <option value="ADD NEW">ADD NEW</option>
                       <option value="BLOCK">BLOCK</option>       
                              
		<?php }
		
elseif($id=='ACCOUNTING') 
{
		?>
        <select id="roleselect" name="subroles[]" >
                       <option value="0">-Select-</option>
			
            		<option value="SUMMARY">SUMMARY</option>
                       <option value="TRANSACTIONS">TRANSACTIONS</option>
                       <option value="DEPOSITS">DEPOSITS</option>
                       <option value="WITHDRAWALS">WITHDRAWALS</option>
                       <option value="ESCROWS">ESCROWS</option>
                       <option value="SIGNUPS">SIGNUPS</option>   
                       <option value="COMMISSIONS">COMMISSIONS</option>   
                       <option value="REFUNDS">REFUNDS</option>  
                       <option value="INVESTMENT">INVESTMENT</option>  
                       <option value="SINGLE PAYMEN">SINGLE PAYMENT</option>   
                       <option value="MASS PAYMENTS">MASS PAYMENTS</option>   
                       <option value="MASS MAILING">MASS MAILING</option>   
                              
                              
		<?php 	}			
		
		?>