// Generated by CoffeeScript 1.6.2
(function() {
  'use strict';
  var buildElem, creditRoll;

  if (typeof creditRoll === "undefined" || creditRoll === null) {
    creditRoll = window.creditRoll = {};
  }

  buildElem = function(options) {
    var elem;

    elem = $('<div />').addClass('__creditroll__');
    $(options.staffs).each(function(i, staffPair) {
      var boxDiv, list, roll;

      roll = staffPair.roll;
      list = staffPair.list;
      boxDiv = $('<div class="box">\n  <div class="left">\n    <div class="inner rollText"></div>\n  </div>\n  <div class="right">\n    <div class="inner">\n      <ul class="list">\n      <ul>\n    </div>\n  </div>\n</div>');
      boxDiv.find('.rollText').text(roll);
      $(list).each(function(j, name) {
        var li;

        li = $('<li />');
        return li.text(name).appendTo(boxDiv.find('.list'));
      });
      return elem.append(boxDiv);
    });
    return elem;
  };

  creditRoll.start = function(options) {
    return $(function() {
      var creditElem, creditHeight, hoffset, woffset;

      creditElem = buildElem(options);
      hoffset = ($('body').outerHeight() - $('body').height()) / 2;
      woffset = ($('body').outerWidth() - $('body').width()) / 2;
      console.log($(window).height());
      creditElem.css({
        top: -hoffset,
        right: -woffset
      });
      $('body').prepend(creditElem);
      creditHeight = creditElem.outerHeight();
      return $(creditElem).animate({
        top: -hoffset - creditHeight + $(window).height()
      }, 30 * 1000, 'linear');
    });
  };

}).call(this);
