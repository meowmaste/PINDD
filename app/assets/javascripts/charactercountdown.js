function updateCountdown() {
    // 140 is the max message length
    var remaining = 8000 - jQuery('#note_content').val().length;
    jQuery('.countdown').text(remaining + ' characters remaining.');
}

jQuery(document).ready(function($) {
    updateCountdown();
    $('#note_content').change(updateCountdown);
    $('#note_content').keyup(updateCountdown);  
});