(function(){

	window.QuizApp = {}

	QuizApp.vm = {
		questions: m.prop([])
	}

	QuizApp.controller = function (){
		var ctrl = {};
		return ctrl
	}

	QuizApp.view = function(ctrl){
		return [m('quiz', 
				[m('label', "Enter your name: "), m('input[type="text"]',{class: "name"}),
			QuizApp.vm.questions().map(quizView)
			]),
			m('button[type="submit"]', "Submit")]

		function quizView (qs) {
			return m('.question', [
				m('h4', qs.question),
				qs.options.map(radioButtons)
			])

			function radioButtons (ops) {
				return [m('.option', [m('input[type=radio]', {id: ops, name: "question"+qs.id}), m('label', ops)])]
			}
		}

	}

})()