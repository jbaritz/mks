(function(){
	window.QuizPresenter = {}

	var $form = $('.questions')
	var questionTallies = [
		{id: 1, attempts: 0, correct: 0},
		{id: 2, attempts: 0, correct: 0}
			]
	if (! localStorage.questionTallies){
		localStorage.setItem("questionTallies", JSON.stringify(questionTallies))
	}

	QuizPresenter.renderQuizzes = function(){
		$form.empty();
		var questionDivs = Quiz.questions.map(function (q){
			return $('<div>').addClass("question").append($('<h4>').text(q.question)
			, q.options.map(function (option){
					return $('<div>').addClass('option').attr('data-id',q.id).append(
						$('<input>').attr({type: "radio", id:"option_"+option, name: "question_"+q.id}),
						$('<label>').text(option)
					)
				}) //options map
			)
		})//questionDivs

		$form.append(questionDivs)
		
	}//end renderQuizzes

	QuizPresenter.renderQuizzes();//print quiz

	$('.quizzy').on('submit', function (e) {
		e.preventDefault();
		$('.question-avgs').empty()
		var name = $("form input[name='student']").val();
		var sel = $("form input[type='radio']:checked")
		var qs = Quiz.questions.length;
		var selected = []
		for (var i =0; i < qs; i++) {
			// var ops = Quiz.questions[i].options.length;
		 //  for(var j = 0; j < ops; j++){
		  	console.log(sel)
		  	selected.push(sel[i]["id"])
		}
		var ans = []
		selected.forEach(function (sel){
			var bits = sel.split("_");
			ans.push(bits[1]);
		})	
		var answers = [
			{ id: 1, answer: 1 },
			{ id: 2, answer: 0 },
		]
		var score = 0;
		for (var i = 0; i < Quiz.questions.length; i++){
				var qdata = JSON.parse(localStorage.questionTallies)
				qdata[i].attempts++
				
				var correctpos = Quiz.questions[i].answer;
				if(Quiz.questions[i].options[correctpos] === ans[i]){
					score++;
					qdata[i].correct++
				}
			localStorage.clear();
			localStorage.setItem("questionTallies", JSON.stringify(qdata))

			putsAvg(i);
			}//end for-each-q
		var scoreDiv = $('<div>')
		scoreDiv.text(name+"'s Score: " + score)
		$('form').append(scoreDiv)
		}) //end on-submit

	function putsAvg(i){
		
		var qdata = JSON.parse(localStorage.questionTallies)[i]
		var percent = parseInt((qdata.correct / qdata.attempts ) * 100)
		var div = $('<div>').attr("id",i)
		div.text("Question "+(i+1)+" average: "+percent+"%")
		$('.question-avgs').append(div)

	}


})() //end all