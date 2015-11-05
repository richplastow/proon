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


#### `object <object|null>`
Optional. Must be a plain JavaScript object instance, eg `{}`, which provies 
[the object instance API](https://goo.gl/HDpXQe). 

        if ªU == typeof config.object
          @object = null
        else if ªO != ªtype config.object then throw TypeError "
          #{M}Optional `config.object` is #{ªtype config.object} not object"
        else
          @object = config.object


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
- `node <object>`              @todo describe
  - `name <string>`            @todo describe
  - `path <array of strings>`  Optional. @todo describe
  - `content <string>`         Optional. @todo describe
- `<Proon>`                    returns this Proon instance, to allow chaining

@todo describe

      add: (node) ->
        M = "/proon/src/Proon.litcoffee
          Proon:add()\n  "

        if ªO != ªtype node then throw TypeError "
          #{M}`node` is #{ªtype node} not object"

        name    = node.name
        path    = node.path
        content = node.content

        nameRx = /^[a-z][-a-z0-9]{0,23}$/
        if ªS != typeof name then throw TypeError "
          #{M}`node.name` is #{ªtype name} not string"
        unless nameRx.test name then throw RangeError "
          #{M}`node.name` fails #{nameRx}"

        pathRx = /^[a-z][-a-z0-9]{0,23}$/
        if ªU == typeof path
          path = []
        else if ªA != ªtype path then throw TypeError "
          #{M}`node.path` is #{ªtype path} not array"
        for str,i in path
          if ªS != typeof str then throw TypeError "
            #{M}`node.path[#{i}]` is #{ªtype path[i]} not string"
          unless pathRx.test str then throw RangeError "
            #{M}`node.path[#{i}]` fails #{pathRx}"

        maxLen = 1024 * 1024
        if ªU == typeof content
          content = '' #@todo avoid altering `node`
        else if ªS != typeof content then throw TypeError "
          #{M}`node.content` is #{ªtype content} not string"
        else if maxLen < content.length then throw TypeError "
          #{M}`node.content.length` #{content.length} > #{maxLen}"

Preflight adding an object key-value pair. 

        if @object
          curr = @object
          for str,i in path
            curr = curr[str]
            if ªS == typeof curr then throw RangeError "
              #{M}`node.path[#{i}]` '#{str}' is already a leaf-node"
            if ªU == typeof curr then break
          if curr
            if ªS == typeof curr[name] then throw RangeError "
              #{M}`node.name` '#{name}' is already a leaf-node"
            if ªU != typeof curr[name] then throw RangeError "
              #{M}`node.name` '#{name}' is already a branch-node"

Preflight adding a localStorage item. 

        if @localStorage
          123 #@todo

Preflight adding a filesystem file or directory. 

        if @fs
          123 #@todo

Preflight adding a database record. 

        if @db
          123 #@todo

Preflight adding a DOM element. 

        if @dom
          123 #@todo

Add an object key-value pair. 

        if @object
          curr = @object
          for str,i in path
            if ªU == typeof curr[str] then curr[str] = {}
            curr = curr[str]
          curr[name] = content

Add a localStorage item. 

        if @localStorage
          123 #@todo

Add a filesystem file or directory. 

        if @fs
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
