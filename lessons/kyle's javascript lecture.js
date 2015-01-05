//always open your html files with <meta charset="utf8">
//'rel' attribute stand for 'relationship', defining the relationship between the markup and your code
// separation of concerns, very important
//instead of 'rel' some people use class and id tags, but Kyle prefers to use them
//only for css purposes. 
// "nofollow" = do not follow the link, a well-established convention
// css vaues are usually 1-based, JS is 0-based-- might want to stick to these conventions
// using > in css means "direct descendent"
		evt.preventDefault();
		evt.stopPropagation();
		evt.stopImmediatePropagation();
//caching elements to variables in JS is very important for selectors. that way if you change your labels in the html later
//you only have to change a few places in the beginning of your code where you define those variables. e.g.
	var $content = $("[rel=js-carousel] > [rel=js-content]");
	var $items = $content.children("[rel=js-items]");
	var $left = $("[rel=js-carousel] > [rel=js-controls] > [rel=js-left]");
	var $right = $("[rel=js-carousel] > [rel=js-controls] > [rel=js-right]");
//and the rest of the file just references the variables, so that if rel=js-carousel is changed to something else, the 
//js file can be easily edited.

	$items.on("click","> [rel^=js-item-]",function(evt){

		//^ after rel means that it just has to start with js-item-, does not have to be exact

	//.target can be better than using .this because it points at the target of what was clicked on.