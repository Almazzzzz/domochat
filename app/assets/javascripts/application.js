//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

var counter = 1;
var limit = 20;
function addInput(divName){
     if (counter == limit)  {
          alert("You have reached the limit of adding " + counter + " options");
     }
     else {
          var newdiv = document.createElement('div');
          newdiv.innerHTML = "Option " + (counter + 1) + " <br><input class='string optional form-control' type='text' name='options[][poll_option]'' id='options__poll_option' autocomplete='off'>";
          document.getElementById(divName).appendChild(newdiv);
          counter++;
     }
}