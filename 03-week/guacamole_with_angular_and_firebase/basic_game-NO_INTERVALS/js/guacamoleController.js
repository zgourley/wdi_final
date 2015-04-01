angular
    .module('guacamoleApp')
    .controller('GuacamoleController', GuacamoleController);

    GuacamoleController.$inject = ['$firebaseObject'];

    function GuacamoleController($firebaseObject){
        var self = this;

        self.game = syncGameWithFirebase();
        self.whackMole = whackMole; //sets whackMole() function as a property of the controller

        function syncGameWithFirebase(){
            var ref = new Firebase('your Firebase URL here');
            var gameObject = $firebaseObject(ref);

            //initialize values in the gameObject once it's loaded
            gameObject.$loaded(function(){
                gameObject.currentMolePosition = 0;
                gameObject.score = -1;
                gameObject.holes = [];

                for(var i = 0; i < 9; i++){
                    gameObject.holes.push({moleIsHere: false});
                }

                gameObject.$save();
                whackMole(0); 
            });

            return gameObject;
        }

        //called using ng-click directive in the view
        function whackMole($index){
            //only execute the code if the hole
            //that was clicked has a mole in it
            if($index === self.game.currentMolePosition){

                //generate a random number to move the mole to a new hole
                var randomIndex = Math.floor(Math.random() * self.game.holes.length);
               
                // this while loop ensures that the next hole the mole 
                // moves to will not be the same as the current hole
                while(randomIndex === self.game.currentMolePosition){
                    randomIndex = Math.floor(Math.random() * self.game.holes.length);
                }

                self.game.holes[$index].moleIsHere = false;
                self.game.holes[randomIndex].moleIsHere = true;
                self.game.currentMolePosition = randomIndex;
                self.game.score++;
                self.game.$save();
            }
        }
    }