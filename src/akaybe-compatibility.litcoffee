Akaybe Compatibility
====================

#### A collection of polyfills to allow Akaybe to run on legacy browsers

You can safely remove this source file if you do not intend your app to run on: 

- Internet Explorer 9 (Internet Explorer 10+ does not need it)
- Firefox 3.6 and earlier (Firefox 4+ does not need it)
- Chrome 6 and earlier (Chrome 7+ does not need it)
- Safari 5 and earlier (Safari 5.1+ does not need it)
- Opera 11.5 and earlier (Opera 11.6+ does not need it)
- Konqueror 4.9 and earlier (Konqueror 4.13+ does not need it)
- iOS 5.1 Safari and earlier (iOS 6 Safari does not need it)
- Android 2.3 Browser and earlier (Android 4 Browser does not need it)




#### Polyfill `bind()`
Based on [the MDN `bind()` reference page](https://goo.gl/Xuu3Es). 

    if ! Function::bind
      Function::bind = (oThis) ->
        if 'function' != typeof @
          throw new TypeError "Function.prototype.bind -
            what is trying to be bound is not callable"

        aArgs   = Array::slice.call arguments, 1
        fToBind = @
        fNOP    = ->
        fBound  = ->
          fToBind.apply(
            (if @ instanceof fNOP then @ else oThis),
            aArgs.concat Array::slice.call arguments
          )

        if @prototype
          fNOP.prototype = @prototype # native functions have no prototype
        fBound.prototype = new fNOP
        fBound



    ;


