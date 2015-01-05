

$(document).ready(function(){
  console.log(localStorage)
	if (localStorage.getItem("currentUser")){
	  $('.loggedin').append('Welcome, ' + localStorage.getItem("currentUser"))
    $('.loggedin').append(' | <a href="#" class="signout">Sign Out</a>')
	}
 $('.signupform').hide();
 $('.newchat').hide();

 $('.signout').on('click', function (e){
    console.log("signout clicked");
    localStorage.clear();
    location.reload();
 })

 function getChats(){
   var url = "/chats"
 	 $.get(url)
   .done(function (chats){
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
    getChats();
  	$('.newchat').show()
  }) //close chatview click



$('form.chatform').on('submit', function (e) { //new chat submit
  e.preventDefault()
  var requestBody = {}
  requestBody.message = $('[name=message]', this).val()
  requestBody.apiKey = localStorage.getItem("apiKey")
  var url = "/chats"
  $.post(url, requestBody)
  this.reset()
    // .fail(function(error) {
    //   console.log("Invalid POST request:", error.responseText)
    //   var errorObj = JSON.parse(error.responseText)
    //   for (var fieldName in errorObj) {
    //   console.log(fieldName, errorObj[fieldName])
    //   var errorText = errorObj[fieldName].join(';')
    //   var $errorDiv = $('<div>').addClass('error')
    //   $errorDiv.html(fieldName + " - " + errorText)
    //   $('.newchat').append($errorDiv)
    //   }
    // })
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
  e.preventDefault();
  var requestBody = {}
  requestBody.username = $('[name=username]', this).val()
  requestBody.password =  $('[name=password]', this).val()
  var url = "/signup"
  $.post(url, requestBody)
    .done(function(newUser) {
      console.log(newUser)
      var $labeldiv = $('<div>')
      $labeldiv.html("You have successfully registered!")
       $('form.signupform').append($labeldiv)
       localStorage.setItem("currentUser", newUser["username"])
       localStorage.setItem("apiKey", newUser["api_key"])
       location.reload();
     })
    
  })


//     })
//     .fail(function(error) {
//       console.log("Invalid POST request:", error.responseText)
//       var errorObj = JSON.parse(error.responseText)
//       for (var fieldName in errorObj) {
//       console.log(fieldName, errorObj[fieldName])
//       var errorText = errorObj[fieldName].join(';')
//       var $errorDiv = $('<div>').addClass('error')
//       $errorDiv.html(fieldName + " - " + errorText)
//       $('form.signupform .signuperror').append($errorDiv)
//       }
//     })
// 	}) // end signup post
$('form.signinform').on('submit', function (e) { //signinform
  e.preventDefault()
  var requestBody = {}
  requestBody.username = $('[name=username]', this).val()
  requestBody.password =  $('[name=password]', this).val()
  var url = "/signin"
  $.post(url, requestBody)
    .done(function(response) {
      console.log("log:",response)
      localStorage.clear();
      localStorage.setItem("currentUser", response["username"])
      localStorage.setItem("apiKey", response["api_key"])
      location.reload();
    })

  })
//       var $labeldiv = $('<div>')
//       $labeldiv.html("You have successfully logged in!")
//       $('form.signinform').append($labeldiv)
     
//       localStorage.setItem('apiToken', response['apiToken'])
//       localStorage.setItem('currentUser', requestBody['username'])
//       console.log("localstorage:",localStorage)
      // $('.loggedin').append('Welcome, ' + localStorage.getItem("currentUser"))
    // })
    // .fail(function(error) {
    //   console.log("Invalid POST request:", error.responseText)
    //   var errorObj = JSON.parse(error.responseText)
    //   for (var fieldName in errorObj) {
    //   console.log(fieldName, errorObj[fieldName])
    //   var errorText = errorObj[fieldName].join(';')
    //   var $errorDiv = $('<div>').addClass('error')
    //   $errorDiv.html(fieldName + " - " + errorText)
    //   $('form.signinform .signuperror').append($errorDiv)
    //   }
    // })
	// }) // end signin post
}) //end document
 //localStorage.setItem('myKey', 'myVal') //(must be a string)

