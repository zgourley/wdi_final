console.log("we're in business");

var song = {
	one: "you're like a dream come true",
	two: "just wanna be with you",
	theChorus: function () {
		var nick = "Nick Mitchel";
		console.log(this);
		console.log(this.one + " " + this.two);
	}
}

song.theChorus();

function myOutsideFunc(){
	console.log(this);
}

myOutsideFunc();