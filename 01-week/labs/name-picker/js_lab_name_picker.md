#JS Lab ~ "Name Picker"

###SETUP: 

1. choose/mk dir
2. make three files 
3. js css html
4. Build the html basics (head, body)
5. link everything up
6. include normalize.css


###Before we get real- lets git going. 
1. initialize git
2. git add -A 
3. git commit -m "initial commit"
4. git remote add origin (SSH key)
5. git push -u origin master


###GETTING REAL IN JS:
	

* make an array of strings

```

var wdi_15_names = ['Abe Menashy', 'Alok  Somani', 'Austen  Weinhart', 'Austin  Kim', 'Austin  Langley', 'Carlos  Cruz', 'Conrad  Sze', 'Curtis  Ott', 'Daniel  Dowling', 'Fancy Moua', 'Gobind  Tandon', 'Jessica Grinberg', 'Joey  Volpe', 'Kathleen  Magnuson', 'Ksenia  Smith', 'Kyle  Conkright', 'Kyle  Hurst', 'Mathieu Fallows', 'Mikel Pacheco', 'Nancy Ma', 'Nick  Mitchell', 'Richard Luo', 'Rushi Sinha', 'Russ  Dollinger', 'Sarah Kruberg', 'Ted Burkow', 'Tiffany Lim', 'Zack  Gourley'];

```

* INDEX and CONSOLE.LOG // console log A string from that array
 
```
console.log(wdi_15_names[2]);
```

* console log a different string from that array

```
console.log(wdi_15_names[5]);
```

* FOR LOOP console log all strings from that array

```
console.log(wdi_15_names); //returns the whole object

var i;
for (i = 0; i < wdi_15_names.length; i++) { 
	console.log(wdi_15_names[i]);
}
// the loop logs each string in the array
//notice the difference in what is logged

```

* FUNCTION // console log each string consecutively from that array

```

    var i = 0;
    function eachName(){
      console.log(wdi_15_names[i]);
      i ++; 
    }
    eachName();

```

* design some logic that randomly logs a different string each time

```

//Math.floor and Math.random might be useful
var pick = Math.floor(Math.random() * wdi_15_names.length)
var namePicker = wdi_15_names[pick];
console.log(namePicker);


//REFACTORED
var namePicker = wdi_15_names[Math.floor(Math.random() * wdi_15_names.length)];
console.log(namePicker);

```


###Make that git commit message count! 


```

$ git add -A 
$ git commit -m "builds javascript logic"
$ git push

```

###Connecting the DOM to INPUT

1. Create a button in HTML
2. Research how you can use that button to call a function (namePicker)
3. Write a function that uses the JS logic for selecting a random name.
3. Hook everything up so that your button is now printing a random string to the console. 


###Make that git commit message count! 


```

$ git add -A 
$ git commit -m "button prints string to console"

```


###Homework / Challenge add ons - 

1.CONNECT the DOM to OUTPUT // We want the name to render in our DOM - not in the console!!

```
document.write(namePick);

document.getElementById("chosen_one").innerHTML = "Paragraph changed!";


```


2.Rework the JS logic so that a name will not be picked twice, until all other names have been picked

```

array.pop()

http://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_pop


```

3.Render a photo of the person who's name is picked
4.CSS Animations! 
5.Bling it out! 






###Working Solution


```

<!DOCTYPE html>
<html>
  <head> 
    <title>WDI 15 Name Picker</title>
    <script> 
    
    var wdi_15_names = ['Abe Menashy', 'Alok  Somani', 'Austen  Weinhart', 'Austin  Kim', 'Austin  Langley', 'Carlos  Cruz', 'Conrad  Sze', 'Curtis  Ott', 'Daniel  Dowling', 'Fancy Moua', 'Gobind  Tandon', 'Jessica Grinberg', 'Joey  Volpe', 'Kathleen  Magnuson', 'Ksenia  Smith', 'Kyle  Conkright', 'Kyle  Hurst', 'Mathieu Fallows', 'Mikel Pacheco','Nancy Ma', 'Nick  Mitchell', 'Richard Luo', 'Rushi Sinha', 'Russ  Dollinger', 'Sarah Kruberg', 'Ted Burkow', 'Tiffany Lim', 'Zack  Gourley'];
  	function namePicker(){
    	//pick random numbers for color
    	var red = Math.floor(Math.random() * 9);
    	var green = Math.floor(Math.random() * 9);
    	var blue = Math.floor(Math.random() * 9);
    	//Name Picker
    	//var namePick = wdi_15_names[Math.floor(Math.random() * wdi_15_names.length)];
    	var namePick = wdi_15_names.splice(Math.floor(Math.random() * wdi_15_names.length), 1);

    	//Print to DOM
    	if (wdi_15_names.length > 1) {
      		document.getElementById("chosen_one").innerHTML = (namePick);
      		document.getElementsByTagName("body")[0].style.backgroundColor = "#"+red+green+blue+red+green+blue;
    	} else if (wdi_15_names.length > 0) { 
      document.getElementById("chosen_one").innerHTML = ("last but not least: " + namePick);
    	} else {
      		document.getElementById("chosen_one").innerHTML = ("all done: #reload");
    };
    		//document.write(namePick);
    } 
    </script>
    <style> .container{width: 750px; margin: 0 auto; text-align:center;} body{background-color: blue; color:lightgrey;}
      </style>
  </head>
  <body>
    <div class="container">
    <h1>WE ARE WDI 15 !!!!!!</h1>
    <button onclick='namePicker()'>Random Name Generator</button> 
    <br><br><br><br><br><br><br><br>
    <div id="chosen_one" style="font-size:100px;"></div>
    <div>
  </body>
</html>


```




