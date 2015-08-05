var Collage = function() {
};

Collage.prototype.init = function() {
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

$(document).on('pjax:complete', function() { new Collage().init() });
