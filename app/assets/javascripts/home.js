$("#drop-zone").dropzone();

$(document).ready(function() {
  $('#download_link').on('click', function() {
    setTimeout(function() {
      NProgress.done()
    }, 2000);
  });

  new Collage().init();

  $('.edit-folder-name').on('click', function() {
    var name = $(this).data('folder-name');
    var id = $(this).data('folder-id');
    var url = "/folders/" + id;

    $('#edit_folder_form').attr('action', url);
    $('#name').val(name);
  });

  $('#myModal').on('hidden.bs.modal', function () {
    window.location.reload()
  });

  var client = new ZeroClipboard($('a.d_clip'));
  client.on('copy', function(event) {
    var url = $("#" + event.target.id).data('file-url');
    event.clipboardData.setData('text/plain', url);
  });
});
