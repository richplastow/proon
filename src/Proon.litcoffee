Proon
=====

@todo describe


#### The main class for Proon

    class Proon
      C: 'Proon'
      toString: -> '[object Proon]'

      constructor: (config={}) ->
        M = "/proon/src/Proon.litcoffee
          Proon()\n  "




Properties
----------


#### `fs <object|null>`
Optional. Usually the result of `require('fs')` in NodeJS, but any object which 
provides [the fs API](https://nodejs.org/api/fs.html) can be used. 

        if ªU == typeof config.fs
          @fs = null
        else if ªO != ªtype config.fs then throw TypeError "
          #{M}Optional `config.fs` is #{ªtype config.fs} not object"
        else if ªF != typeof config.fs.readFileSync then throw TypeError "
          #{M}Optional `config.fs` has no `readFileSync()` method"
        #@todo full API check
        else
          @fs = config.fs


#### `localStorage <object|null>`
Optional. Usually `window.localStorage` in a browser, but any object which 
provides [the localStorage API](https://goo.gl/LpAhsF) can be used. 

        if ªU == typeof config.localStorage
          @localStorage = null
        else if ªO != ªtype config.localStorage then throw TypeError "
          #{M}Optional `config.localStorage` is #{ªtype config.localStorage} not object"
        else if ªF != typeof config.localStorage.setItem then throw TypeError "
          #{M}Optional `config.localStorage` has no `setItem()` method"
        #@todo full API check
        else
          @localStorage = config.localStorage


#### `db <object|null>`
Optional. @todo

        if ªU == typeof config.db
          @db = null
        else if ªO != ªtype config.db then throw TypeError "
          #{M}Optional `config.db` is #{ªtype config.db} not object"
        #@todo implement database
        else
          @db = config.db


#### `dom <object|null>`
Optional. @todo

        if ªU == typeof config.dom
          @dom = null
        else if ªO != ªtype config.dom then throw TypeError "
          #{M}Optional `config.dom` is #{ªtype config.dom} not object"
        #@todo implement DOM
        else
          @dom = config.dom




Methods
-------


#### `add()`
- `path <string>`  @todo describe
- `node <object>`  @todo describe
- `<Proon>`        returns this Proon instance, to allow chaining

@todo describe

      add: (path, node) ->
        M = "/proon/src/Proon.litcoffee
          Proon:add()\n  "

        if ªS != typeof path then throw TypeError "
          #{M}`path` is #{ªtype path} not string"
        if ªO != ªtype node then throw TypeError "
          #{M}`node` is #{ªtype node} not object"

Add a filesystem file or directory. 

        if @fs
          123 #@todo

Add a localStorage item. 

        if @localStorage
          123 #@todo

Add a database record. 

        if @db
          123 #@todo

Add a DOM element. 

        if @dom
          123 #@todo

Allow chaining, eg `proon.add(myFirstNode).add(mySecondNode)`. 

        @




Namespaced Functions
--------------------


#### `xx()`
- `yy <zz>`      @todo describe
- `<undefined>`  does not return anything

@todo describe

    Proon.xx = (yy) ->
      M = "/proon/src/Proon.litcoffee
        Proon.xx()\n  "




    ;
