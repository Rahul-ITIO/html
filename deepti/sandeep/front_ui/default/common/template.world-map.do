
<style>
#containers {
    height: 500px;
    min-width: 100%;
    margin: 0 auto;
}
.highcharts-credits {
fill: rgb(247 247 255) !important;
}
</style>

<div id="containers" class="me-2 my-2"></div>
<script>
(async () => {

  const topology = await fetch('<?=$data['Host']?>/include/world.topo.json').then(response => response.json());

  Highcharts.getJSON('<?=$data['Host']?>/include/world-map<?=$data['iex']?>', function(data) {

    Highcharts.mapChart('containers', {
      chart: {
        borderWidth: 0,
        map: topology
      },
	   colors: [
			"<?=$data['tc']['hd_b_d_0']?>",
			'#dc3545'
		],

      title: {
        text: '<?=$post['company_name']?>'
      },

      subtitle: {
        text: '' //Transaction map with bubbles
      },

      accessibility: {
        description: 'Display transaction by country with total success transaction and total amount.'
      },

      legend: {
        enabled: false
      },

      mapNavigation: {
        enabled: true,
        buttonOptions: {
          verticalAlign: 'bottom'
        }
      },

      series: [{
        name: 'Countries',
        color: '#E0E0E0',
        enableMouseTracking: false
      }, {
        type: '', //mapbubble
        name: 'Transaction',
        joinBy: ['iso-a3', 'code3'],
        data: data,
        minSize: 4,
        maxSize: '14%',
        tooltip: {
          pointFormat: '{point.properties.hc-a2}: {point.z}'
        }
      }]
    });
  });

})();

</script>

