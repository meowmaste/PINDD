$(".note-check").bind('change', function(){
  if (this.checked){
    $.ajax({
      url: '/notes/'+this.value+'/toggle',
      type: 'POST',
      data: {"check": this.checked}
    });
  }
  else {
     alert("no");
  }
});
