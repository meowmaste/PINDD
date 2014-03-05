function updateCountdown() {
    // 140 is the max message length
    var remaining = 140 - jQuery('#note_content').val().length;
    jQuery('.countdown').text(remaining + ' characters remaining.');
}

jQuery(document).ready(function($) {  
    var $note = $('#note_content');
    if ($note.length > 0) {
      updateCountdown();
      $note.change(updateCountdown).keyup(updateCountdown);  
    }
});