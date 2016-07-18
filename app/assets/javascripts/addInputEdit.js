var counter = 1;
var limit = 20;
function addInputEdit(divName){
     if (counter == limit)  {
          alert("You have reached the limit of adding " + counter + " options");
     }
     else {
          var newdiv = document.createElement('div');
          newdiv.innerHTML = "Option " + (counter + 1) + " <br><input class='string optional form-control' type='text' name='options[]'' id='options' autocomplete='off'>";
          document.getElementById(divName).appendChild(newdiv);
          counter++;
     }
}