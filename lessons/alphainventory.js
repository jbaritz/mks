var text = "aabbccdd";
var alphabet = "aBc"

// function alphaCount (alphabet, text) {
//   var chars = text.toLowerCase();
//   var alpha = alphabet.toLowerCase();
//   var tallies = {};
//   chars.forEach(function(i){
//     if (alpha.contains(i)){
//       (tallies.i) || (tallies.i = 0);
//       tallies.i++;
//        }
//     })
  
//     if (tallies[0] === 0){
//       console.log("no matches");
//     }
//     else{
//     console.log(tallies);
//     }
//   }
//   

function alphaCount (alphabet, text) {
  var counts = {}
  text.toLowerCase().split("").forEach(function(c){
      counts[c] || (counts[c]) = 0) 
  counts[c] += 1
  })
  
  var output = []
  alphabet.toLowerCase().split("").forEach(function(c){
      if (counts[c] == undefined)  return;
      output.push(c +":" + counts[c])
    })

  if (output.length > 0){
    return output.join(",")
  }
  else {
    return "no matches"
  }
      })  
