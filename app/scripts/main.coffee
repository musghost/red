# Carousel
carousel = $ '#carousel'
slides = $('.slides').find('.slide')
buttons = carousel.find('.carousel-buttons a')
numSlides = slides.length
active = 0
speed = 800

moveNext = (next)->
    slides.eq(active).animate({
        left: '-100%'
    }, speed, ->
        slide = $ this
        slide.removeClass('active').removeAttr 'style'
    )
    slides.eq(next).css({
        display: 'block'
        left: '100%'
    }).animate({
        left: '0'
    }, speed, ->
        slide = $ this
        slide.removeAttr('style').addClass 'active'
        buttons.removeClass('active').eq(next).addClass 'active'
    )
    active = next
moveBack = (next)->
    slides.eq(active).animate({
        left: '100%'
    }, speed, ->
        slide = $ this
        slide.removeClass('active').removeAttr 'style'
    )
    slides.eq(next).css({
        display: 'block'
        left: '-100%'
    }).animate({
        left: '0'
    }, speed, ->
        slide = $ this
        slide.removeAttr('style').addClass 'active'
        buttons.removeClass('active').eq(next).addClass 'active'
    )
    active = next
fadeSlide = (slide) ->
    newSlide = slides.eq(slide)
    activeSlide = slides.filter('.active')

    if newSlide.hasClass 'active'
        return
    else
        activeSlide.fadeOut ->
            activeSlide.removeClass('active').removeAttr('style')
        newSlide.fadeIn ->
            newSlide.addClass('active').removeAttr('style')
        buttons.removeClass('active').eq(slide).addClass 'active'
        active = slide



carousel.find('.right').click (e)->
    e.preventDefault()
    if active - 1 < 0
        next = numSlides - 1
    else
        next = active - 1;
    moveBack next
carousel.find('.left').click (e)->
    e.preventDefault()
    if active + 1 >= numSlides
        next = 0
    else
        next = active + 1;
    moveNext next
buttons.each (i) ->
    button = $ this
    button.click (e)->
        e.preventDefault()
        fadeSlide i

features = $('.info-features-list').find '.info-feature'
features.each ->
    feature = $ this
    button = feature.find '.feature-btn'
    info = feature.find '.information'
    button.click (e)->
        e.preventDefault
        features.find('.information').removeClass 'active'
        info.addClass 'active'


# features
fSection = $('#features')
features = $ fSection.find '.feature'

getStarted = ->
    features.addClass 'f-hide'

getStarted()

fSection.scrollspy({
    min: fSection.offset().top - 300
    max: fSection.offset().top + fSection.height()
    onEnter: (element, position)->
        time = 100
        features.each ->
            feature = $ this
            setTimeout(->
                feature.animate({
                    opacity: 1
                    'margin-left': '20px'
                }, 800, ->
                    $(this).removeClass('f-hide').removeAttr 'style'
                )
            , time)
            time += 200
    onLeave: (element, position)->
        console.log 'leave'
})
