$(document).ready(function{
	var $register = $("[rel~=js-header] > [rel~=js-controls] > [rel~=js-register]");
	var $login = $("[rel~=js-header] > [rel~=js-controls] > [rel~=js-login]");
	var $modal = $("[rel~=js-modal]");

$([$register, $login]).click(function(evt){
		evt.preventDefault();
		evt.stopPropagation();
		evt.stopImmediatePropagation();

		var url = $(evt.target).attr("href");
		$ajax(url,{dataType: "text"})
			.then(function(content){
			$modal.html(content).show();
			});

		});

});