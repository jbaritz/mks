//Presenter
(function () {
	Task.add('my task')
	Task.add('launch eva unit 01')
	Task.add('bring shinji the happiness he deserves')

	Task.forEach(function (task){
		var li = $('<li>').add(
			$('<input type="checkbox"').prop('checked', task.completed),
			$('<span>').addClass('name').text(task.name)
			)
		$('#task-list').append(li)
	})
})()