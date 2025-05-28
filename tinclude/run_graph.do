<?
//Dev Tech : 24-01-25 Transaction insert from master table in additional 

/* 

http://localhost:8080/gw/tinclude/run_graph.do


*/

$data['NO_SALT']=1;
$data['SponsorDomain']=1;
include('../config.do');

if(!isset($_SESSION['adm_login']))
{
	echo('ACCESS DENIED.');
	exit;
}

$pq=0;
	
if(isset($_GET['pq'])&&$_GET['pq']) $pq=@$_GET['pq'];
if(isset($_GET['qp'])&&$_GET['qp']) $pq=@$_GET['qp'];


// Fetch data
$query = "
    SELECT 
    duration_category,
    COUNT(*) as transaction_count
FROM (
    SELECT 
        CASE 
            WHEN runtime > 40 AND runtime <= 60 THEN '1m'
            WHEN runtime > 60 AND runtime <= 120 THEN '2m'
            WHEN runtime > 120 AND runtime <= 300 THEN '5m'
            WHEN runtime > 300 AND runtime <= 600 THEN '10m'
            WHEN runtime > 600 AND runtime <= 1800 THEN '30m'
            WHEN runtime > 1800 AND runtime <= 3600 THEN '1 hour'
            WHEN runtime > 0 AND runtime <= 20 THEN '20s'
            WHEN runtime > 20 AND runtime <= 40 THEN '40s'
            ELSE 'Custom'
        END as duration_category
    FROM 
        zt_master_trans_table_3 where runtime not in (0)
) AS subquery
GROUP BY 
    duration_category
ORDER BY 
    CASE 
        WHEN duration_category = '1m' THEN 1
        WHEN duration_category = '2m' THEN 2
        WHEN duration_category = '5m' THEN 3
        WHEN duration_category = '10m' THEN 4
        WHEN duration_category = '30m' THEN 5
        WHEN duration_category = '1 hour' THEN 6
        WHEN duration_category = '20s' THEN 7
        WHEN duration_category = '40s' THEN 8
        ELSE 9
    END;

";

$data_get = db_rows($query,0);


db_disconnect();



// Prepare data for graph
$labels = [];
$values = [];
foreach ($data_get as $row) {
    $labels[] = $row['duration_category'].' ('.$row['transaction_count'].')';
    $values[] = $row['transaction_count'];
    echo "<br/><hr/>".$row['duration_category'].": ".$row['transaction_count']."<br/>";
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Duration Graph</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <canvas id="durationChart" width="400" height="200"></canvas>
    <script>
        const ctx = document.getElementById('durationChart').getContext('2d');
        const durationChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: <?php echo json_encode($labels); ?>,
                datasets: [{
                    label: 'Transaction Count',
                    data: <?php echo json_encode($values); ?>,
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 159, 64, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
