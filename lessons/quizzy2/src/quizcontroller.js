(function(){

	window.QuizApp = {}

	QuizApp.vm = {
		questions: m.prop([]),
		selectedAnswers: m.prop({}),
		name: m.prop([]),
		correctAnswers: m.prop([
			 {id: 1, answer: 1},
			 {id: 2, answer: 0}
			]),
		score: m.prop(),
		questionTallies: m.prop([
		{id: 1, attempts: 0, correct: 0},
		{id: 2, attempts: 0, correct: 0}
			]),
		questionAvgs: m.prop({})
	}

	QuizApp.controller = function (){
		var ctrl = {};		
		if (! localStorage.questionTallies){
		localStorage.setItem("questionTallies", JSON.stringify(QuizApp.vm.questionTallies()))
		}
		ctrl.calcScoreAndAvg = function(){
			return calcScore(), calcAvg();
			function calcScore(){
				var score = 0;
				var qs = QuizApp.vm.questions().length
				for(var i = 0; i < qs; i++){
					if (QuizApp.vm.correctAnswers()[i]['answer'] === QuizApp.vm.selectedAnswers()[i+1]){
							score++;
					}
				}
				}			

			function calcAvg (){
				for (var i = 0; i < QuizApp.vm.questions().length; i++){
					var qdata = JSON.parse(localStorage.questionTallies)
					qdata[i].attempts++				
					var correctpos = QuizApp.vm.questions()[i].answer;
					if(correctpos === QuizApp.vm.selectedAnswers()[i+1]){
						qdata[i].correct++
						// QuizApp.vm.questionTallies()[0]["id"]
					}
				localStorage.clear();
				return localStorage.setItem("questionTallies", JSON.stringify(qdata))			
				}
			}
		}	
		return ctrl
	}

	QuizApp.view = function(ctrl){
		return [m('quiz', 
				[m('label', "Enter your name: "), m('input[type="text"]',{class: "name"}),
			QuizApp.vm.questions().map(quizView)
			]),
			m('button[type="submit"]', {onclick: ctrl.calcScoreAndAvg}
				, "Submit"),
			answerStatus()]

		function quizView (qs) {
			return m('.question', [
				m('h4', qs.question),
				qs.options.map(radioButtons)
			])

		function radioButtons (ops, idx) {
			return m('.option', [
				m('input[type=radio]', {
					id: ops,
					name: "question"+qs.id,
					onchange: function () {
						QuizApp.vm.selectedAnswers()[qs.id] = idx
					}
				}),
				m('label', ops)
				])
			}//end radioButtons		
		}//end quizView

		function answerStatus(){
			if (QuizApp.vm.score() === undefined) {return}
			else {
				return m('.quiz', [m('.score', "Your Score: "+ QuizApp.vm.score())]);
			}
		}//end answerStatus
		function qAverages(){
			var qdata = JSON.parse(localStorage.questionTallies)[i]
			var percent = parseInt((qdata.correct / qdata.attempts ) * 100)
			
		}

	}

	Function.prototype.chill = function() {
	  var fn = this
	  return function(e) {
	    e.preventDefault()
	    return fn()
	  };
	};
})()
