---
---

(($) ->
    distanceInYearsAndMonths = (date1, date2) ->
        numMonths = (date1.getFullYear() - date2.getFullYear()) * 12
        numMonths -= date2.getMonth() - 1 # count from beginning of the month of date2
        numMonths += date1.getMonth() # count until the end of the month of date1
        numYears = Math.floor(numMonths / 12)
        numMonths %= 12
        years = if(numYears > 0) then numYears + " year" + ( if(numYears > 1) then "s" else "") else ""
        months = if(numMonths > 0) then numMonths + " month" + (if(numMonths > 1) then "s" else "") else ""
        if years then years + (if months then " and " + months else "") else (if months then months else "")

    $ ->
        $('span.timespan').html ->
            from = new Date($(@).data('from'))
            fromStr = from.toLocaleString('en-US', {year: 'numeric', month: 'short'})
            to = new Date()
            toStr = 'Present'
            if $(@).data('to')
                to = new Date($(@).data('to'))
                toStr = to.toLocaleString('en-US', {year: 'numeric', month: 'short'})
            fromStr + ' - ' + toStr + ' (' + distanceInYearsAndMonths(to, from) + ')'

        # initialize bootstrap's affix plugin for the nav element
        $('.nav-col .nav').affix
            offset:
                top: $('.nav-col .nav').offset().top - 100

        # smooth scroll for the nav
        $(".nav-col .nav li a[href^='#']").on 'click', (e) ->
            e.preventDefault() # prevent default anchor click behaviour
            hash = @.hash
            $('html, body').animate {scrollTop: $(@.hash).offset().top}, 200, ->
                window.location.hash = hash #add hash to url (default click behaviour)

        # set enough margin on the last resume block for the scrollspy to work correcly for it (desktop screen only)
        $('.content-block:last-child').css 'margin-bottom', window.innerHeight if window.innerWidth > 900
        $(window).on 'resize', ->
            if window.innerWidth > 900 then margin = window.innerHeight else margin = 0
            $('.content-block:last-child').css 'margin-bottom',  margin

) jQuery