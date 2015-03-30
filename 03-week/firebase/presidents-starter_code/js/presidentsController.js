angular
	.module("presidentsApp")
	.controller("PresidentsController", PresidentsController);

function PresidentsController(){
	var self = this;

	self.presidentsList = getPresidentsList();
	self.newPresidentName; //bound to input in view
	self.addPresident = addPresident;
	self.deletePresident = deletePresident;

	function getPresidentsList(){
		var presidents = [
			{name: 'George Washington'},
			{name: 'John Adams'},
			{name: 'Thomas Jefferson'},
			{name: 'James Madison'},
			{name: 'James Monroe'},
			{name: 'John Quincy Adams'},
			{name: 'Andrew Jackson'},
			{name: 'Martin Van Buren'}
		];
		
		return presidents;
	}

	function addPresident(){
		var newPrez = {name: self.newPresidentName};
		self.presidentsList.push(newPrez);
		self.newPresidentName = null;
	}

	function deletePresident(prez){
		var index = self.presidentsList.indexOf(prez);
		self.presidentsList.splice(index, 1);
	}

}
