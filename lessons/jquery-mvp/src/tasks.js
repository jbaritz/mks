//Model
(function (){
	var tasks = []
	window.Task = {} //creates JS equivalent of a module
	//the following code is known as Transaction Script, a function that returns either success or an error
	Task.add = function (task) {
		if (! name){
			return {error: "name_required" }
		}
		if (name.length < 3){
			return {error: 'name_too_short'}
		}
		var task = {
			name: name,
			completed: false
		}
		
		tasks.push(task)
		return {success: true}
	}

Task.forEach = function (callback) {
	for(var i=0; i<tasks.length; i++){
		callback(extend({}, tasks[i])) //this creates a copy of the task in a different hash so that we have a copy that is not accessible to outside parties
		}
	}

// Task.forEach(function (task){
// 	console.log("I have a task:" task.name)
// 	$('<div class="task">').text(task.name)
// })

})()