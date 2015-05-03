CONSUMING RAILS API WITH jQUERY

------

### OBJECTIVES

- Be able to consume your API using jQuery
- Be able to use jQuery to turn JSON into DOM elements


------

***Begin by making a ’static_pages’ controller***

- rails g controller static_pages home`



- Change root to “static_pages#home” in `routes.rb`


***Download this pic***

- `curl http://www.thetiebar.com/database/products/B856.png -o bowtie.png`


***Install Bootstrap***

- Install `bootstrap-sass` gem
  
- Build the CSS file in application.css.scss
  
  ``` css
  *= require_tree .
  *= require_self
  */
  
  @import "bootstrap-sprockets";
  @import "bootstrap"; 
  
  #bowties{
    text-align: center;
  }
  
  #bowties-list{
    list-style-type: none
  }
  
  li:hover{
    background-color: gray;
    font-size: x-large;
    border-radius: 45px;
    p{
      color:white;
    }
    .price{
      color:yellow;
      -webkit-text-stroke:1px red;
    };
  }
  ```
  


***Build the JS file. See below***

- Rename ```static_pages.coffee``` to ```static_pages.js```


``` javascript
var API_BASE = '/api/bowties/';

$(document).ready(function(){
  var json = $.ajax({
    datatype: 'json',
    type: 'GET',
    url: API_BASE,
    data: {}
    });

  console.log(json);

  json.done(function(data){
    var i;

    for(i=0;i<data.length;i+=1){
      console.log(data[i]);
    }//end for
  });//end json.done
});//end document.ready
```

- Add the `addBowtie` function


``` javascript

...
...
	for(i=0;i<data.length;i+=1){
      // console.log(data[i]);
      addBowtie($('#bowties-list'), data[i]);
    }//end for
...
...
```

- Don’t forget the `json.fail` function


``` javascript
  json.fail(function(data){
    $('#bowties').html("<h2>FAILED TO LOAD</h2>");
    // $('#bowties').text("FAILED TO LOAD");
    // console.log("failed!");
  });
```



- Write jQuery to populate the list. First start with rendering the images


``` javascript
function addBowtie(jqElem, data){
  console.log(jqElem);
  console.log(data);

  var imageUrl = data.image_url;
  var description = data.description;
  var retailPrice = data.retail_price;

  var listItem = "<div class='bowtie-indiv'>";
  listItem += "<img src='" + imageUrl + "' width='150px' height='150px'>";

  jqElem.append('<li>' + listItem + '</li>');
  console.log(listItem);
}
```

- The finished addBowtie function


``` javascript
function addBowtie(jqElem, data){
  console.log(jqElem);
  console.log(data);

  var imageUrl = data.image_url;
  var description = data.description;
  var retailPrice = data.retail_price;

  var listItem = "<div class='bowtie-indiv'>";
  listItem += "<img src='" + imageUrl + "' width='150px' height='150px'>";
  listItem += "<p width='100px'>" + description + "</p>";
  listItem += "<strong>" + retailPrice.toString() + "</strong>";

  jqElem.append('<li>' + listItem);
}
```

- The completed script ```static_pages.js```


``` javascript
var API_BASE = '/api/bowtie/';

function addBowtie(jqElem, data){
  // console.log(jqElem);
  // console.log(data);

  var imageUrl = data.image_url;
  var description = data.description;
  var retailPrice = data.retail_price;

  var listItem = "<div class='bowtie-indiv'>";
  listItem += "<img src='" + imageUrl + "' width='150px' height='150px'>";
  listItem += "<p width='100px'>" + description + "</p>";
  listItem += "<strong class='price'>" + retailPrice.toString() + "</strong>";

  jqElem.append('<li>' + listItem + '</li>');
  console.log(listItem);
}

$(document).ready(function(){
  var json = $.ajax({
    datatype: 'json',
    type: 'GET',
    url: API_BASE,
    data: {}
    });

  console.log(json);

  json.done(function(data){
    var i;

    for(i=0;i<data.length;i+=1){
      // console.log(data[i]);
      addBowtie($('#bowties-list'), data[i]);
    }//end for    
  });//end json.done

  json.fail(function(data){
    $('#bowties').html("<h2>FAILED TO LOAD</h2>");
    // $('#bowties').text("FAILED TO LOAD");
    // console.log("failed!");
  });
});//end document.ready
```

- The completed HTML ```home.html.erb```


``` html
<main class="container-fluid">
  <div class="row">
    <div style="text-align:center;" class="jumbotron">
      <%= image_tag 'bowtie.png', id:"logo" %>
      <h1>GLENN'S BIG BAD TIE STORE</h1>
      <p>Experience the experience...</p>
    </div>

    <section class="col-md-12" id="bowties">
      <ul id="bowties-list"></ul>
    </section>
  </div>
</main>
```



------