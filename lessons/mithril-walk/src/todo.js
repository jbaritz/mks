(function(){

	window.TodoApp = {}

	//View-Model
	TodoApp.vm = {
		todos: m.prop([]) //provides getter/setter, must be called as TodoApp.vm.todos()!!!
	}

	TodoApp.find = function (id) {
		var todos = TodoApp.vm.todos()
		for (var i =0; i < todos.length; i++){
			if (todos[i].id === id) return todos[i]
		}
	}

	TodoApp.controller = function (){
		var ctrl = {}

		ctrl.updateTodo = function(id, isComplete){
			var todo = TodoApp.find(id)
			todo.isComplete = isComplete
		}
		ctrl.flip = function (){
			var todos = TodoApp.vm.todos().forEach(function (todo){
				todo.isComplete = !todo.isComplete
			})
		}
		return ctrl
	}

	TodoApp.view = function(ctrl){ //this basically prints out the page
		return m('.todos', [ //add an array of stuff
			TodoApp.vm.todos().map(todoView),
			m('button',{onclick: ctrl.flip}, "Flip All")
		])
	
		function todoView (todo) {
			return m('.todo', [
				//checkbox
				m('input[type=checkbox]',{
					checked: todo.isComplete,
					//function(id, isComplete)
					onchange: ctrl.updateTodo.bind(null, todo.id, !todo.isComplete)//we have to bind the function here because if we don't, it will be called immediately and onchange won't work properly
				}),
				//label
				m('label', todo.name)
				//bind click action to ctrl
			])
		}
	}

})()