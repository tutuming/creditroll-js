'use strict'

if not creditRoll?
  creditRoll = window.creditRoll = {}

buildElem = (options) ->
  elem = $('''
  <div class="__creditroll__">
    <div class="scroller">
    </div>
  </div>
  ''')

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

    elem.find('.scroller').append(boxDiv)

  if options.credit?
    creditDiv = $('''
      <div class="credit">
        <p></p>
      </div>
    ''')

    bh = $('body').outerHeight()
    creditDiv.css
      height : bh
      marginTop : bh

    creditDiv.find('p').text(options.credit).css
      lineHeight : bh + 'px'

    elem.find('.scroller').append(creditDiv)

  elem

loadYoutubeAPI = (videoId, elem, complete) ->
  window.onYouTubeIframeAPIReady = ->
    console.log 'ytreadey'
    bw = $('body').outerWidth()
    bh = $('body').outerHeight()
    w = bw / 2 - 50
    h = w * 390 / 640.0

    $('#__creditrollVideo__').css
      top : (bh - h) / 2

    player = new YT.Player('__creditrollVideo__', {
      height: h,
      width: w,
      videoId: videoId,
      playerVars : {
        autoplay : 1
        rel : 0
        controls : 0
        showinfo : 0
        disablekb : 1
        iv_load_policy : 3
        modestbranding : 1
      },
      events: {
        'onReady' : ->
          dur = player.getDuration()
          setTimeout( ->
            $('#__creditrollVideo__').animate {
              opacity : 0
            }, 1000
          , (dur - 1) * 1000)

          complete(dur)
      }
    })

  tag = document.createElement('script')

  tag.src = "https://www.youtube.com/iframe_api"
  firstScriptTag = document.getElementsByTagName('script')[0]
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)

  elem.prepend('<div id="__creditrollVideo__"></div>')

creditRoll.start = (options) -> $ ->
  creditElem = buildElem(options)
  scroller = $(creditElem).find('.scroller')
  bh = $('body').outerHeight()

  scroller.css
    paddingTop : bh

  $('body').prepend creditElem

  hoffset = ( $('body').outerHeight() - $('body').height() ) / 2
  woffset = ( $('body').outerWidth() - $('body').width() ) / 2
  creditElem.css
    top : -hoffset
    right : -woffset

  doStart = (duration) ->
    console.log 'doStart'

    creditHeight =  scroller.outerHeight()

    scroller.animate({
      top : -hoffset - creditHeight + $(window).height()
    }, duration * 1000, 'linear')

  if options.youtubeVideoId?
    loadYoutubeAPI(options.youtubeVideoId, creditElem, doStart)
  else
    doStart(60)
