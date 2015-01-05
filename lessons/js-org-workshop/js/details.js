$(document).ready(function(){

	var $items = $("[rel=js-carousel] > [rel=js-content] > [rel=js-items]");
	var $content = $("[rel=js-details]");

	$items.on("click","> [rel^=js-item-]",function(evt){
		evt.preventDefault();
		evt.stopPropagation();
		evt.stopImmediatePropagation();

		var $item = $(evt.target);
		var id = $item.attr("rel").replace(/.*(\d+)$/,"$1");

		$.ajax("details/" + (Number(id) || 0) + ".html",{ dataType: "text" })
		.then(function(content){
			$content.html(content);
		});

	});

});
