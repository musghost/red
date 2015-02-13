carousel = do () ->
    container = $ '#carousel'
    slides = container.find '.slide'
    buttons = container.find '.carousel-buttons a'
    numSlides = slides.length
    active = 0
    speed = 800

    module = {}

    moveNext = (next) ->
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

    module.init = ->
        container.find('.right').click (e)->
            e.preventDefault()
            if active - 1 < 0
                next = numSlides - 1
            else
                next = active - 1;
            moveBack next

        container.find('.left').click (e)->
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
    module

infoFeature = do ->

    information = $('.info-features-list').find '.info-feature'
    {
        init: ->
            information.each ->
                feature = $ this
                button = feature.find '.feature-btn'
                info = feature.find '.information'
                button.click (e)->
                    e.preventDefault
                    information.find('.information').removeClass 'active'
                    info.addClass 'active'
    }


# features
features = do ->

    fSection = $('#features')
    elements = $ fSection.find '.feature'

    getStarted = ->
        elements.addClass 'f-hide'

    init: ->
        getStarted()
        fSection.scrollspy({
            min: fSection.offset().top - 300
            max: fSection.offset().top + fSection.height()
            onEnter: (element, position)->
                time = 100
                elements.each ->
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
        })


features.init()
carousel.init()
infoFeature.init()


# testimonial

testimonials = do ->
    testimonial = $ '#testimonials'
    elements = testimonial.find '.testimonial'
    buttons = testimonial.find('.testimonial-control').first().find 'a'
    active = 0
    speed = 600

    left = ->
        if active + 1 >= elements.length
            next = 0
        else
            next = active + 1
        elements.eq(active).animate({
            left: '-100%'
            opacity: 0
        }, speed, ->
            _this = $ this
            _this.removeAttr('style').removeClass 'active'
        )
        elements.eq(next).css({
            display: 'block'
            opacity: 0
            left: '100%'
            top: 0
            position: 'absolute'
            width: '100%'
        }).animate({
            left: 0
            opacity: 1
        }, speed, ->
            _this = $ this
            _this.addClass('active').removeAttr 'style'
        )
        buttons.removeClass 'active'
        buttons.eq(next).addClass 'active'
        active = next
    right = ->
        if active - 1 < 0
            elements.left -1
        else
            next = active - 1
        elements.eq(active).animate({
            left: '100%'
            opacity: 0
        }, speed, ->
            _this = $ this
            _this.removeAttr('style').removeClass 'active'
        )
        elements.eq(next).css({
            display: 'block'
            opacity: 0
            left: '-100%'
            top: 0
            position: 'absolute'
            width: '100%'
        }).animate({
            left: 0
            opacity: 1
        }, speed, ->
            _this = $ this
            _this.addClass('active').removeAttr 'style'
        )
        buttons.removeClass 'active'
        buttons.eq(next).addClass 'active'
        active = next

    init: ->
        buttons.each (i) ->
            button = $ this
            button.click (e) ->
                console.log 'clicked'
                e.preventDefault()
                if i > active
                    left()
                else if i < active
                    right()

testimonials.init()
