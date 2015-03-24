var myAwesomeDonutShop = angular.module("donutShop",[]);

myAwesomeDonutShop.controller("DonutController",DonutController);

function DonutController(){
	this.shop = {
		donuts: [
				{	
					type: "Chocolate Glazed", 
					image: "images/chocolate-glazed.png"
				},
				{	
					type: "Glazed", 
					image: "images/glazed.png"
				},
				{	
					type: "Lemon Sprinkles", 
					image: "images/lemon-sprinkles.png"
				},
				{	
					type: "Pink Chocolate Drizzled", 
					image: "images/pink-chocolate-drizzled.png"
				},
				{	
					type: "Vanilla Iced", 
					image: "images/vanilla-iced.png"
				},
				{	
					type: "Pink Sprinkles", 
					image: "images/pink-sprinkles.png"
				},
				{	
					type: "Blue", 
					image: "images/blue.png"
				},
				{	
					type: "Green", 
					image: "images/green.png"
				},
				{	
					type: "Chocolate Half-Sprinkles", 
					image: "images/chocolate-half-sprinkles.png"
				}
		]
	};

	this.my = {
		donuts: [],
		total: function(){
			var total = this.donuts.length * 0.89;
			return total.toFixed(2);
		}
	};
	

	this.addDonut = function(i){
		var original = this.shop.donuts[i];
		var donut = angular.copy(original);
		this.my.donuts.unshift(donut);
	};
	this.removeDonut = function(i){
		this.my.donuts.splice(i, 1);
	};
}