#=include ./lib/MyClass.coffee


$('*[data-mask]').each () ->
    $this = $ this
    maskStr = String $this.attr 'data-mask'
    $this.inputmask mask: maskStr


dpickerLocale =
    format: "DD.MM.YYYY"
    separator: " - "
    applyLabel: '<i class="icon-check"></i>'
    cancelLabel: '<i class="icon-times"></i>'
#     "fromLabel": "From",
#     "toLabel": "To",
#     "customRangeLabel": "Custom",
#     "weekLabel": "W",
    daysOfWeek: ["Вс","Пн","Вт","Ср","Чт","Пт","Сб"]
    monthNames: [
        'Январь',    'Февраль',  'Март',    'Апрель'
        'Май',       'Июнь',     'Июль',    'Август'
        'Сентябрь',  'Октябрь',  'Ноябрь',  'Декабрь'
    ]
    "firstDay": 1


$('.js-dpicker').each () ->
    $this = $ this
    $this.daterangepicker
        autoUpdateInput: off
        singleDatePicker: on
        timePicker: on
        timePicker24Hour: on
        locale: dpickerLocale
        # minDate: Date.now()
    $this.on 'apply.daterangepicker', (e, picker) ->
        # console.log picker.startDate
        $(this).val picker.startDate.format 'DD.MM.YYYY - hh:mm'
        on
    $this.on 'cancel.daterangepicker', (ev, picker) ->
        $(this).val ''
        on
    on


$('.js-form').on 'submit', (e) ->
    e.preventDefault()
    off



$('.js-scroll').on 'click', (e) ->
    e.preventDefault()
    id = $(this).attr 'href'
    $block = $ id
    if $block.length then offsetTop = $block.offset().top else offsetTop = 0
    $('html:not(:animated),body:not(:animated)').animate scrollTop: offsetTop, 800
    off


class YtPlayer
    constructor: (@frame) ->
        $frame = $ @frame
        @$parent = $frame.closest '.js-video'
        @$btn = @$parent.find '.js-video-btn'
        @$overlay = @$parent.find '.js-video-overlay'
        videoId = $frame.attr 'data-video'
        @ytPlayer = new YT.Player @frame,
            height: '100%'
            width: '100%'
            videoId: videoId
            playerVars:
                controls: 0
                showinfo: 0
                modestbranding: 1
                wmode: "transparent"
                origin: window.location.hostname
            events:
                'onReady': @ready
                'onStateChange': @stateChange
        # c.seekTo(0), c.setVolume(100)
    ready: (e) =>
        @$overlay.on 'click', @stopVideo
        @$btn.on 'click', @playVideo
    stateChange: (e) =>
        if e.data is 0
            @$parent.removeClass 'playing'
            # @ytPlayer.seekTo(0)
            # @ytPlayer.pauseVideo()
    playVideo: (e) =>
        e.preventDefault()
        e.stopPropagation()
        @$parent.addClass 'playing'
        # @ytPlayer.seekTo(90)
        @ytPlayer.playVideo()
        off
    stopVideo: (e) =>
        @ytPlayer.pauseVideo()
        @$parent.removeClass 'playing'



window.onYouTubeIframeAPIReady = () ->
    $('*[data-video]').each () -> new YtPlayer this


class ImgLoader
    constructor: (@$el, @imgUrl) ->
        img = new Image
        $img = $ img
        $img.one 'load', @imgOnLoad
        $img.attr 'src', @imgUrl
    imgOnLoad: () =>
        @$el.addClass 'loaded'
        @$el.css 'background-image': "url(#{@imgUrl})"




$('*[data-img]').each () ->
    $this = $ this
    imgUrl = $this.attr 'data-img'
    new ImgLoader $this, imgUrl




$('.js-nav-toggle').on 'click', (e) ->
    e.preventDefault()
    $this = $ this
    $block = $ "#{$this.attr 'href'}"
    if $block.length
        $block.stop()
        $block.slideToggle()
        # console.log $block.is ':visible'
    off


