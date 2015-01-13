(function(){
	window.QuizPresenter = {}

	var $form = $('.questions')

	QuizPresenter.renderQuizzes = function(){
		// $form.empty();
		var questionDivs = Quiz.questions.map(function (q){
			return $('<div>').addClass("question").append($('<h4>').text(q.question)
			, q.options.map(function (option){
					return $('<div>').addClass('option').attr('data-id',q.id).append(
						$('<input>').attr({type: "radio", name: "question_"+q.id}),
						$('<label>').text(option)
					)
				}) //options map
			)
		})//questionDivs

		$form.append(questionDivs)
		
	}//end renderQuizzes

	QuizPresenter.renderQuizzes();

	$form.on('submit', function (e) {
		e.preventDefault()
		console.log("You submitted")
		
		$form.find('.option:is(selected)').map(function (idx, elem) {
			console.log(idx, $(elem).attr('data-id'))
		})
		var answers = [
			{ id: 1, answer: 2 },
			{ id: 2, answer: 0 },
		]
		Quiz.calculateScore(answers)
		// Show score to user
		return false
	})
 

})() //end all