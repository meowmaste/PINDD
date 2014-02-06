$(document).ready(function() {
  $(".note-check").bind('change', function(){
    $.ajax({
      url: '/notes/'+this.value+'/toggle',
      type: 'POST',
      data: {"check": this.checked}
    });
  });
});
