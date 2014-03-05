$(document).ready(function() {
  $(document).on('click', '.group-selector', function() {
    if (this.checked){
      $("div[id^="+this.id+"]").css("display","inline");
    }
    else {
      $("div[id^="+this.id+"]").css("display","none");
    }
  });
});
