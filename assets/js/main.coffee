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

) jQuery