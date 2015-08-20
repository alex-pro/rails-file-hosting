$(document).ready(function() {
  $('.item_destroy').on('click', function() {
    var id = $(this).data('item-id');
    $('#item_' + id).remove();
  });
});
