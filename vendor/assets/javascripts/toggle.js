$(document).ready(function() {
  $(".note-check").bind('change', function(){
    $.ajax({
      url: '/notes/'+this.value+'/toggle',
      type: 'POST',
      data: {"check": this.checked}
    });
    if($(this).attr("checked")) {
      document.getElementById("note-label["+this.value+"]").style.textDecoration = "line-through";
    } else {
      document.getElementById("note-label["+this.value+"]").style.textDecoration = "none";
    }
  });
});
