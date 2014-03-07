function toggleCheckbox() {
  $(document).on('click', '.note-check', function(){
    $.ajax({
      url: '/notes/'+this.value+'/toggle',
      type: 'PUT',
      data: {"check": this.checked},
      dataType: "script"
    });
  });
}

jQuery(document).ready(function($) {
  toggleCheckbox();
});
