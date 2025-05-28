$(function(){// tooltips
	$('[data-toggle="tooltip"]').tooltip();
	if ($('.widget-activity').length)
	$('.widget-activity .filters .glyphicons').click(function(){
		$('.widget-activity .filters .active').toggleClass('active');
		$(this).toggleClass('active');
	});
});