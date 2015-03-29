angular
    .module('guacamoleApp')
    .controller('GuacamoleController', GuacamoleController);

    function GuacamoleController(){
        var self = this;

        self.holes = [
            {moleIsHere: false},
            {moleIsHere: false},
            {moleIsHere: false},
            {moleIsHere: false},
            {moleIsHere: false},
            {moleIsHere: false},
            {moleIsHere: false},
            {moleIsHere: false},
            {moleIsHere: false}
        ];

        self.score; //keeps track of score; gets incremented in whackMole()
        self.currentMolePosition; //keeps track of mole's position - its value is a number
        self.whackMole = whackMole; //sets whackMole() function as a property of the controller

        //called using ng-click directive in the view
        function whackMole($index){
            //only execute the following code if the hole
            //that was clicked has a mole in it
            if($index === self.currentMolePosition){

                //generate a random number to move the mole to a new hole
                var randomIndex = Math.floor(Math.random() * self.holes.length);
               
                // this while loop ensures that the next hole the mole 
                // moves to will not be the same as the current hole
                while(randomIndex === self.currentMolePosition){
                    randomIndex = Math.floor(Math.random() * self.holes.length);
                }

                self.holes[$index].moleIsHere = false;
                self.holes[randomIndex].moleIsHere = true;
                self.currentMolePosition = randomIndex;
                self.score++;
            }
        }

        //this function is wrapped in an IIFE (immediately-invoked function expression)
        //it runs as soon as this file loads to initialize the game
        (function init(){
            self.currentMolePosition = 0;
            whackMole(0);
            self.score = 0;
        })();

    }