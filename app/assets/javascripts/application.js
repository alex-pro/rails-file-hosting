//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery.collagePlus.min
//= require jquery.collageCaption.min
//= require jquery.removeWhitespace.min
//= require zeroclipboard
//= require nprogress
//= require nprogress-turbolinks
//= require dropzone
//= require_tree .

var Collage = {};
Collage.init = function() {
  function collage() {
    $('.Collage').removeWhitespace().collagePlus({
      'fadeSpeed'     : 2000,
      'targetHeight'  : 200
    });
  };

  collage();
  $('.Collage').collageCaption();

  var resizeTimer = null;
  $(window).bind('resize', function() {
    $('.Collage .Image_Wrapper').css("opacity", 0);
    if (resizeTimer) clearTimeout(resizeTimer);
    resizeTimer = setTimeout(collage, 200);
  });
};
$("#drop-zone").dropzone();

$(window).load(function() {
  $(document).ready(function(){
    $('#download_link').on('click', function() {
      setTimeout(function() {
        NProgress.done()
      }, 2000);
    });

    Collage.init();

    $('#myModal').on('hidden.bs.modal', function () {
      window.location = '/'
    });

    var client = new ZeroClipboard($('a.d_clip'));
    client.on('copy', function(event) {
      var url = $("#" + event.target.id).data('file-url');
      event.clipboardData.setData('text/plain', url);
    });
  });
});
