jQuery.fn.anchorAnimate = function(settings) {

  settings = jQuery.extend({
    speed : 500
  }, settings);

  return this.each(function(){
    var caller = this;
    $(caller).click(function (event) {
      event.preventDefault();
      var locationHref = window.location.href;
      var elementClick = $(caller).attr("href");

      // Note the deduction of 70 pixels on the end.
      // This allows the section in reference to be fully
      // visible underneath the top of the viewport.
      // This must be lower than the data-offset attribute
      // on the body tag, to allow both scrollspy and
      // anchor to work together.
      var destination = $(elementClick).offset().top - 70;

      $("html:not(:animated),body:not(:animated)").animate({ scrollTop: destination}, settings.speed, function() {
        window.location.hash = elementClick;
      });
        return false;
    });
  });
};
