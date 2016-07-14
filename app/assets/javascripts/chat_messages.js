document.addEventListener("DOMContentLoaded", function(event) {

  var element = document.getElementById("message_view");
  var messageForm = document.getElementById("new_chat_message");

  function updateScroll(element) {
    element.scrollTop = element.scrollHeight;
  }

  updateScroll(element);

  element.addEventListener("DOMSubtreeModified", function() {
    updateScroll(element)
  });

});
