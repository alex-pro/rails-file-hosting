$(document).ready(function() {
  $('.item_destroy').on('click', function() {
    var id = $(this).data('item-id');
    $('#item_' + id).remove();
  });

  $('.folder_destroy').on('click', function() {
    var id = $(this).data('folder-id');
    $('#folder_' + id).remove();
  });

  $('.editable').editable();
});
