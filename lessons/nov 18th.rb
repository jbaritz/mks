HTTP is how basically all computers interact with the internet and communicate. 

JSON interfaces easily with Javascript

can use Ruby library to use JSON and translate to Ruby data structures.

client on browser uses HTTP to access server, using a GET request. server matches route, decides which code to run for specific endpoint and generate some kind of response -- html, json. server sends response back to browser 

Javascript and AJAX 
browser may make many GET requests per page, not just one. any time there is a script tag ("script src=" etc), that is a server location the broswer needs to make another GET request to retrieve. every image is also another GET request. 

If one request takes a long time the subsequent requests on a page will not run until that request has finished. This is why javascript is often put at the bottom of the html doc, so that if it takes a long time to load the rest of the page will already have loaded and will not be stalled as the javascript loads. 

HTTP is fairly slow, so if you want a fast website, you need to try to make as few HTTP requests as possible. 

AJAX can make arbitrary HTTP requests and do what we want with the response in Javascript.  However you normally cannot make an AJAX request to another domain. AJAX can make HTTP request withut refereshing page.

INTERFACES AND APIS

When designing and interface, always consider your audience! Talk to them in a language that they and many people can understand 

API = Application Programming Interface

Web APIs-- the browswer is the most common type. basically just allows communication between server and client. REST - representational state transfer - is a convention of making web APIs, so that other developers can make assumptions about how your API works

an "endpoint" is on the server side and it's what gets referenced, utilized, and sent back to the client

Documentation is super important!! read the docs if ur confused, although docs can be confusing too

PROJECT IDEA = playlisterizer: allow people to tag music with different categories of tags-- tags for the song's mood, content, instruments, etc. and creates a playlist or suggestions of songs that best fit that listo f tags so you can find more specific song recommendations