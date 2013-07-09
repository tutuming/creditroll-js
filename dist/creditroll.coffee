'use strict'

if not creditRoll?
  creditRoll = window.creditRoll = {}

buildElem = (options) ->
  elem = $('<div />').addClass('__creditroll__')

  $(options.staffs).each (i, staffPair) ->
    roll = staffPair.roll
    list = staffPair.list

    boxDiv = $('''
      <div class="box">
        <div class="left">
          <div class="inner rollText"></div>
        </div>
        <div class="right">
          <div class="inner">
            <ul class="list">
            <ul>
          </div>
        </div>
      </div>
    ''')

    boxDiv.find('.rollText').text(roll)
    $(list).each (j, name) ->
      li = $('<li />')
      li.text(name).appendTo boxDiv.find('.list')

    elem.append(boxDiv)

  elem

creditRoll.start = (options) -> $ ->
  creditElem = buildElem(options)

  hoffset = ( $('body').outerHeight() - $('body').height() ) / 2
  woffset = ( $('body').outerWidth() - $('body').width() ) / 2

  console.log $(window).height()

  creditElem.css
    top : -hoffset
    right : -woffset

  $('body').prepend creditElem

  creditHeight =  creditElem.outerHeight()

  $(creditElem).animate({
    top : -hoffset - creditHeight + $(window).height()
  }, 30 * 1000, 'linear')
