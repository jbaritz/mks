var DEBUG
var thebot
(function () {

 var botName = "Occam's Chainsaw"

 var BotClass = function () {
   // <<Initialize bot state here>>
   deck = {}
   oppdeck = {}
   oppstash = {}
   stash = {}

   gambleindex = 1.22 //1.22611464968
   for(var i=2; i<=14; i++)
   {
       deck[i] = 2
       oppdeck[i] = 2
       oppstash[i] = 0
       stash[i] = 0
   } 
   deck.sum = function(x){
     tot = 0
     for(var i=x; i<=14; i++)
     {
       tot += this[i]
     }
     return tot
   }
   oppdeck.sum = function(x){
     tot = 0
     for(var i=x; i<=14; i++)
     {
       tot += this[i]
     }
     return tot
   }
   return {
     name: botName,
     deck:deck,
     stash:stash,
     played:{},
     rounds:0,
     oppstash:oppstash,
     oppdeck:oppdeck,
     gambleindex:gambleindex,
     play: function (drawnCard, remainingDeckSize, moveType) {
       this.rounds++
       thebot = this
       console.log(this.deck.sum(2))
       //
       // moveType will be either 'normal', 'war', 'normal-gamble', or 'war-gamble'
       //
       // Return 'accept' to play the drawn card, or 'gamble' to draw a different card.
       //
       DEBUG = this.rounds
       val = drawnCard.value
       if (moveType === 'normal' || moveType === 'war') {
         above = this.deck.sum(val)
         oppAbove = this.oppdeck.sum(val)
         if(oppAbove < 2 || above <2)
           return 'accept'
         below = this.cardsBelow(val)
         //console.log('value:'+val+' above:'+above+' below:'+below)
         console.log("opp:"+oppAbove)
         if( val < 6)
         {
           console.log('gamble')
           return 'gamble'
         }
         else
         { 
           return 'accept'
         }

       }
       else {
         return 'accept'
       }
     },
     handleRoundResult: function (didIWin, loot) {
       loot.forEach(function(x){
       if(!x.isMine)
           thebot.oppdeck[x.value]-- 
       if(x.isMine)
           thebot.deck[x.value]--
       })

       if(thebot.deck.sum(2) <= 0)
       {
         console.log('flipping')
         for(var i = 2; i<=14; i++)
         {
           thebot.deck[i] = thebot.stash[i]
           thebot.stash[i] = 0
         }
       }

       if(thebot.oppdeck.sum(2) <= 0)
       {
         for(var i = 2; i<=14; i++)
         {
           thebot.oppdeck[i] = thebot.oppstash[i]
           thebot.oppstash[i] = 0
         }
       }

       if(didIWin)
       {
       //console.log(loot.length)
         loot.forEach(function(x){
             thebot.stash[x.value]++
         })
       }
       else
       {
         loot.forEach(function(x){
           thebot.oppstash[x.value]++ 
         })
       }        
     },
     cardsAbove: function(value){
       count = 0
       if(value==14)
         return 0
       for(i = value+1; i<=14; i++)
       {
         count += this.deck[i]
       }
       return count
       
     },
     cardsBelow: function(value){
       count = 0
       if(value==2)
         return 0
       for(i = value-1; i>=2; i--)
       {
         count += this.deck[i]
       }
       return count
       
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