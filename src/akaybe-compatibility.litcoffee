Akaybe Compatibility
====================

#### A collection of polyfills to allow Akaybe to run on legacy browsers




#### Polyfill `bind()`
Based on [the MDN `bind()` reference page](https://goo.gl/Xuu3Es).  
You can safely remove this polyfill if you do not intend your app to run on: 

- Internet Explorer 9 and earlier (Internet Explorer 10+ does not need it)
- Firefox 3.6 and earlier (Firefox 4+ does not need it)
- Chrome 6 and earlier (Chrome 7+ does not need it)
- Safari 5 and earlier (Safari 5.1+ does not need it)
- Opera 11.5 and earlier (Opera 11.6+ does not need it)
- Konqueror 4.9 and earlier (Konqueror 4.13+ does not need it)
- iOS 5.1 Safari and earlier (iOS 6 Safari does not need it)
- Android 2.3 Browser and earlier (Android 4 Browser does not need it)

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
        fBound.prototype = new fNOP()
        fBound




#### Polyfill `Object.keys()`
Based on [the MDN `Object.keys()` reference page](https://goo.gl/Dj7ph4).  
You can safely remove this polyfill if you do not intend your app to run on: 

- Internet Explorer 8 and earlier (Internet Explorer 9+ does not need it)
- Firefox 3.6 and earlier (Firefox 4+ does not need it)
- Chrome 5 and earlier (Chrome 6+ does not need it)
- Safari 4 and earlier (Safari 5+ does not need it)
- Opera 11.5 and earlier (Opera 11.6+ does not need it)
- Konqueror 4.3 and earlier (Konqueror 4.9+ does not need it)

    if !Object.keys
      Object.keys = do ->
        hasOwnProperty = Object::hasOwnProperty
        hasDontEnumBug = !{ toString: null }.propertyIsEnumerable 'toString'
        dontEnums = [
          'toString'
          'toLocaleString'
          'valueOf'
          'hasOwnProperty'
          'isPrototypeOf'
          'propertyIsEnumerable'
          'constructor'
        ]
        dontEnumsLength = dontEnums.length
        (o) ->
          if typeof o != 'object' and (typeof o != 'function' or o == null)
            throw new TypeError 'Object.keys called on non-object'
          result = []
          for p of o
            if hasOwnProperty.call o, p
              result.push p
          if hasDontEnumBug
            for i in [0..dontEnumsLength]
              if hasOwnProperty.call o, dontEnums[i]
                result.push dontEnums[i]
          result




#### Polyfill `Array::indexOf()`
Based on [the MDN Array `indexOf()` reference page](https://goo.gl/XrzO01).  
You can safely remove this polyfill if you do not intend your app to run on: 

- Internet Explorer 8 and earlier (Internet Explorer 9+ does not need it)
- Firefox 1.0 and earlier (Firefox 1.5+ does not need it)

    if !Array::indexOf

      Array::indexOf = (searchElement, fromIndex) ->

        if @ == null then throw new TypeError '"this" is null or not defined'
        O = Object @

        len = O.length >>> 0 # convert to integer
        if 0 == len then return -1

        n = +fromIndex or 0
        if Math.abs(n) == Infinity then n = 0
        if n >= len then return -1

        k = Math.max (if n >= 0 then n else len - Math.abs(n)), 0

        while k < len
          if k of O and O[k] == searchElement
            return k
          k++

        -1 # not found


    ;


