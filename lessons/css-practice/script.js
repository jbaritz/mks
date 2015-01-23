$(document).ready(function(){
	$('.container').on('click', function (e){
		var align = $(e.target).attr('data-align')
		$(e.currentTarget).attr('data-align',align)
	})



})