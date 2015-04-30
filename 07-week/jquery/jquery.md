Making Sure the Page Is Ready
---

```javascript
$(document).ready(function(){
  alert("Everything is ready, let's do this");
});
```

jQuery includes a shortcut version

```javascript
$(function(){
  alert("Everything is ready, let's do this");
});
```
Selecting. The core of JQuery
---
You may use `jQuery` or `$` which are equivalent.
`jQuery(<selector goes here>)` does the same as `$(<selector here>)`

jQuery uses css selectors, so you can do
`$('#my-element-with-id')` or `$('.my-element-with-a-class')`

If we have an html table like the following:
```html
<table class="data" id="turtles">
  <thead>
    <tr>
      <th>Name</th>
      <th>Color</th>
      <th>Weapon</th>
      <th>Trait</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Donatello</td>
      <td>Purple</td>
      <td>Bo Staff</td>
      <td>Brainiac</td>
    </tr>
    <tr>
      <td>Leonardo</td>
      <td>Blue</td>
      <td>Twin Katanas</td>
      <td>Leader</td>
    </tr>
  </tbody>
</table>
```
complete the table with the remaining turtles
[hint](http://www.answers.com/Q/What_are_the_ninja_turtles_names_colors_and_weapons)

Specifity in selections
---
You can select the table by id like so: `$('#turtles')` or `$('.data')`

We can narrow down our selection like so `$('%turtles tr')` or be more specific like`$('%turtles thead tr')`

Testing the selection
---

```javascript
$(function(){
  alert(%('#turtles tr').length + ' elements');
});
```

Set CSS property
---

```javascript
$(document).ready(function() {
  $('#turtles tbody tr:even').css('background-color','#dddddd');
});
```

```javascript
$(function() {
  $('#turtles tbody tr:even').css({
    'background-color','#dddddd',
    'color': '#666666'
  });
});
```

Adding and Removing Classes
---
It's better to add classes rather than inline styling.
JQuery allows us to add and remove classes dynamically.

```javascript
$('#turtles tbody tr:even').addClass('zebra');
$('#turtles tbody tr:even').removeClass('zebra');
```

Hiding and Revealing Elements
---
We can easily hide elements by using the hide method. So if for example
we have a disclaimer in our html page we could hide it like so.

```html
<input type="button" id="hideButton" value="hide" />
<p id="disclaimer">blah blah...</p>
```

```javascript
$('#hideButton').click(function() {
  $('#disclaimer').hide();
});
```
Or we can show it:

```html
<input type="button" id="showButton" value="show" />
```

```javascript
$('#showButton').click(function() {
  $('#disclaimer').show();
});
```

Since this action is so pervasive, jQuery comes with a toggle.
```javascript
$('#toggleButton').click(function() {
  $('#disclaimer').toggle();
});
```

Adding new elements
---
```javascript
$('<p>My new paragraph</p>')
```


We can add a class to our newly created dom element
```javascript
$('<p>My new paragraph</p>').addClass('new');
```
And then inserted into the live DOM
```javascript
$('<input type="button" value="toggle" id="toggleButton">')
  .insertAfter('#disclaimer');
$('#toggleButton').click(function() {
  $('#disclaimer').toggle();
});
```
