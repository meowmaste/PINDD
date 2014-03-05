$(document).ready(function() {
  $(document).on('change', '.note-check', function(){
    $.ajax({
      url: '/notes/'+this.value+'/toggle',
      type: 'POST',
      data: {"check": this.checked}
    });
    label=document.getElementById("note-label["+this.value+"]");
    if(label.style.textDecoration=="none") {
      label.style.textDecoration = "line-through";
    } else {
      label.style.textDecoration = "none";
    }
  });
});
