
<script>
     const ctx = document.getElementById('durationChart').getContext('2d');
     /*
   if(document.getElementById('durationChart')){
    
    const ctx = document.getElementById('durationChart').getContext('2d');
   }
   else {
    const ctx = parent.window.$('#durationChart').getContext('2d');
   }
   */
    
    const durationChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: <?php echo json_encode(@$post['labels']); ?>,
            datasets: [{
                label: 'Transaction Count',
                data: <?php echo json_encode(@$post['values']); ?>,
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

