var PreviewFile = function() {};

PreviewFile.prototype.init = function() {
  $('.gallery').each(function() {
    $(this).magnificPopup({
      delegate: 'a#gallery',
      type: 'image',
      gallery: {
        enabled:true
      }
    });
  });
}
$(document).on('pjax:complete', function() { new PreviewFile().init() });
