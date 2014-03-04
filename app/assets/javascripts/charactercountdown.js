function updateCountdown() {
    // 140 is the max message length
    var remaining = 8000 - jQuery('#note-content').val().length;
    jQuery('.countdown').text(remaining + ' characters remaining.');
}

jQuery(document).ready(function($) {
    updateCountdown();
    $('#note-content').change(updateCountdown);
    $('#note-content').keyup(updateCountdown);
  
});