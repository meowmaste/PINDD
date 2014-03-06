jQuery(document).ready(function() {  
  $("#group-form input").change(function() {
    var urlVars = $("#group-form").serialize();
    var url = window.location.origin + window.location.pathname + "?" + urlVars;
    window.location = url
  })
});
