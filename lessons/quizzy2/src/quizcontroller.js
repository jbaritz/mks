(function(){

	window.QuizApp = {}

	QuizApp.vm = {
		questions: m.prop([]),
		selectedAnswers: m.prop({}),
		name: m.prop([]),
		correctAnswers: m.prop([
			 {id: 1, answer: 1},
			 {id: 2, answer: 0}
			])
	}

	QuizApp.controller = function (){
		var ctrl = {};		
		ctrl.calcScore = function(){
			var score = 0;
			// console.log("dsfsf",QuizApp.vm.correctAnswers())			
			var qs = QuizApp.vm.questions().length
			for(var i = 0; i < qs; i++){
				if (QuizApp.vm.correctAnswers()[i]['answer'] === QuizApp.vm.selectedAnswers()[i+1]){
						score++
				}
			}
			return QuizApp.renderScore(score);
		}//end calcScore
		return ctrl
	}

	QuizApp.view = function(ctrl){
		return [m('quiz', 
				[m('label', "Enter your name: "), m('input[type="text"]',{class: "name"}),
			QuizApp.vm.questions().map(quizView)
			]),
			m('button[type="submit"]',{onclick: ctrl.calcScore}, "Submit")]

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
			}
		}

	}

	QuizApp.renderScore = function(score){
		console.log(score);
		return m('.quiz', [m('.score', "Your Score: "+ score)])
	}

})()