

$(document).ready(function(){
	if (localStorage.getItem("currentUser")){
	  $('.loggedin').append('Welcome, ' + localStorage.getItem("currentUser"))
	}
 $('.signupform').hide();
 $('.newchat').hide();

 function getChats(){
   var url = "http://chat.api.mks.io/chats"
 	var chats = 
 	 $.ajax({
        type: "GET",
        url: url,
        async: false
	    }).success(function (chats){
	    	console.log(chats)
	    	var source   = $("#chats").html() //grabs the html
			var template = Handlebars.compile(source) //"template" acts as a function
			$('.chatbox').remove();

			chats.forEach(function (chat){
			var chatHtml = template(chat)
			$('.chatlist').append(chatHtml)
			})
        setTimeout(function(){getChats();}, 1000);
    })
   
	// return chats.responseJSON;
}

  $(".showchats").on('click', function(e){ //view chats
  	$('.chatlist').show();
  	$('.signinform').hide();
  	$('.signupform').hide();
	// var source   = $("#chats").html() //grabs the html
	// var template = Handlebars.compile(source) //"template" acts as a function
	// console.log(getChats())
	// getChats().forEach(function (chat) {
	// 		var chatHtml = template(chat)
	// 		$('.chatlist').append(chatHtml)
		
	// }) //close get req
  getChats();
	$('.newchat').show()
  }) //close chatview click



$('form.chatform').on('submit', function (e) { //new chat submit
  e.preventDefault()
  var requestBody = {}
  requestBody.message = $('[name=message]', this).val()
  requestBody.apiToken = localStorage.getItem("apiToken")
  var url = "http://chat.api.mks.io/chats"

  $.post(url, requestBody)
    .done(function(newUser) {
      // var $labeldiv = $('<div>')
      // $labeldiv.html("You have successfully submitted your message!")
      //  $('.newchat').append($labeldiv)

    })
    .fail(function(error) {
      console.log("Invalid POST request:", error.responseText)
      var errorObj = JSON.parse(error.responseText)
      for (var fieldName in errorObj) {
      console.log(fieldName, errorObj[fieldName])
      var errorText = errorObj[fieldName].join(';')
      var $errorDiv = $('<div>').addClass('error')
      $errorDiv.html(fieldName + " - " + errorText)
      $('.newchat').append($errorDiv)
      }
    })
	}) // end new chat post

 $('.signup').on('click', function(e){ //show sign up form
  	$('.chatlist').hide();
  	$('.newchat').hide();
  	$('.signinform').hide();
  	$('.signupform').show();
  }) //end signup click

  $('.signin').on('click', function(e){ //show sign up form
  	$('.chatlist').hide();
  	$('.newchat').hide();
  	$('.signupform').hide();
  	$('.signinform').show();

  }) //end signin click

$('form.signupform').on('submit', function (e) { //signupform
  e.preventDefault()
  var requestBody = {}
  requestBody.username = $('[name=username]', this).val()
  requestBody.password =  $('[name=password]', this).val()
  var url = "http://chat.api.mks.io/signup"

  $.post(url, requestBody)
    .done(function(newUser) {
      var $labeldiv = $('<div>')
      $labeldiv.html("You have successfully registered!")
       $('form.signupform').append($labeldiv)

    })
    .fail(function(error) {
      console.log("Invalid POST request:", error.responseText)
      var errorObj = JSON.parse(error.responseText)
      for (var fieldName in errorObj) {
      console.log(fieldName, errorObj[fieldName])
      var errorText = errorObj[fieldName].join(';')
      var $errorDiv = $('<div>').addClass('error')
      $errorDiv.html(fieldName + " - " + errorText)
      $('form.signupform .signuperror').append($errorDiv)
      }
    })
	}) // end signup post
$('form.signinform').on('submit', function (e) { //signinform
  e.preventDefault()
  var requestBody = {}
  requestBody.username = $('[name=username]', this).val()
  requestBody.password =  $('[name=password]', this).val()
  var url = "http://chat.api.mks.io/signin"

  $.post(url, requestBody)
    .done(function(response) {
      var $labeldiv = $('<div>')
      $labeldiv.html("You have successfully logged in!")
      $('form.signinform').append($labeldiv)
     
      localStorage.setItem('apiToken', response['apiToken'])
      localStorage.setItem('currentUser', requestBody['username'])
      console.log("localstorage:",localStorage)
      $('.loggedin').append('Welcome, ' + localStorage.getItem("currentUser"))
    })
    .fail(function(error) {
      console.log("Invalid POST request:", error.responseText)
      var errorObj = JSON.parse(error.responseText)
      for (var fieldName in errorObj) {
      console.log(fieldName, errorObj[fieldName])
      var errorText = errorObj[fieldName].join(';')
      var $errorDiv = $('<div>').addClass('error')
      $errorDiv.html(fieldName + " - " + errorText)
      $('form.signinform .signuperror').append($errorDiv)
      }
    })
	}) // end signin post
}) //end document
 //localStorage.setItem('myKey', 'myVal') //(must be a string)

