/// <reference path="typings/jquery/jquery.d.ts"/>
$(function(){
	$('.dropdown')
	  .dropdown({
	    // you can use any ui transition
	    transition: 'drop'
	  });
	$('.accordion').accordion();
});