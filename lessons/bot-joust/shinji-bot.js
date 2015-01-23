(function () {
  var count = 0;
  var botName = 'Shinji';
  var myDeck = [2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13,14,14];
  var enemyDeck = [2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13,14,14];
  var BotClass = function () {
    // <<Initialize bot state here>>

    return {
      name: botName,
      play: function (drawnCard, remainingDeckSize, moveType) {
        
        //
        // moveType will be either 'normal', 'war', 'normal-gamble', or 'war-gamble'
        //
        // Return 'accept' to play the drawn card, or 'gamble' to draw a different card.
        //
       if ((moveType === 'normal' || moveType === 'war') && drawnCard.value < 6) {    
       // console.log("Card",drawnCard)      
          return 'gamble'
        }
        else {
          
          return 'accept'

        }
      },
      handleRoundResult: function (didIWin, loot) {
        count++;
        if(count===1)
          // {console.log("BEGIN GAME")}
        if(didIWin === true){
          loot.forEach(function (card){
            if (!("isMine" in card)){
            var index = myDeck.indexOf(card.value)
            myDeck.push(card.value)
          }
          })
        }
        else{ //if I lose
          loot.forEach(function (card){
            if ("isMine" in card){
            var index = myDeck.indexOf(card.value)
            myDeck.splice(index, 1)
          }
        })
        }
        // console.log(myDeck.sort())

      }
    }
  }

  BotClass.botName = botName

  var isNodeJs = typeof module != "undefined" && module !== null && module.exports
  if (isNodeJs) {
    module.exports = BotClass
  }
  else {
    BotRegistry.register(botName, BotClass)
  }
})()
