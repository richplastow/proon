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


#### `storage <object|storage|null>`
Optional. Usually `window.local/sessionStorage` in a browser, but any object 
which provides [the Web Storage API](https://goo.gl/juQ8NI) can be used. 

        ts = ªtype config.storage
        if ªU == ts
          @storage = null
        else if ªO != ts and 'storage' != ts then throw TypeError "
          #{M}Optional `config.storage` is #{ts} not object or storage"
        else if ªF != typeof config.storage.setItem then throw TypeError "
          #{M}Optional `config.storage` has no `setItem()` method"
        #@todo full API check
        else
          @storage = config.storage


#### `fs <object|null>`
Optional. Usually the result of `require('fs')` in NodeJS, but any object which 
provides [the fs API](https://nodejs.org/api/fs.html) can be used. 

        if ªU == typeof config.fs
          @fs = null
        else if ªO != ªtype config.fs then throw TypeError "
          #{M}Optional `config.fs` is #{ªtype config.fs} not object"
        else if ªF != typeof config.fs.readFileSync then throw TypeError "
          #{M}Optional `config.fs` has no `readFileSync()` method"
        else if ªF != typeof config.fs.statSync then throw TypeError "
          #{M}Optional `config.fs` has no `statSync()` method"
        else if ªF != typeof config.fs.mkdirSync then throw TypeError "
          #{M}Optional `config.fs` has no `mkdirSync()` method"
        else if ªF != typeof config.fs.writeFileSync then throw TypeError "
          #{M}Optional `config.fs` has no `writeFileSync()` method"
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


#### `pwd <string>`
Optional. Defaults to '.' (the invoking process’s `$PWD`). @todo describe

        pwdRx = /^[-./a-zA-Z0-9]{0,64}$/
        if ªU == typeof config.pwd
          @pwd = '.'
        else if ªS != ªtype config.pwd then throw TypeError "
          #{M}Optional `config.pwd` is #{ªtype config.pwd} not string"
        else unless pwdRx.test config.pwd then throw RangeError "
          #{M}Optional `config.pwd` fails #{pwdRx}"
        else
          @pwd = config.pwd




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
        maxLevels = 99
        if ªU == typeof path
          path = []
        else if ªA != ªtype path then throw TypeError "
          #{M}`node.path` is #{ªtype path} not array"
        else if maxLevels < path.length then throw RangeError "
          #{M}`node.path.length` #{path.length} > #{maxLevels}"
        for str,i in path
          if ªS != typeof str then throw TypeError "
            #{M}`node.path[#{i}]` is #{ªtype path[i]} not string"
          unless pathRx.test str then throw RangeError "
            #{M}`node.path[#{i}]` fails #{pathRx}"

        maxLen = 1024 * 1024
        if ªU == typeof content
          content = ''
        else if ªS != typeof content then throw TypeError "
          #{M}`node.content` is #{ªtype content} not string"
        else if maxLen < content.length then throw TypeError "
          #{M}`node.content.length` #{content.length} > #{maxLen}"

Preflight adding an object key/value pair. 

        if @object
          curr = @object
          for str,i in path
            curr = curr[str]
            if ªS == typeof curr then throw RangeError "
              #{M}`node.path[#{i}]` '#{str}' is already an object leaf-node"
            if ªU == typeof curr then break
          if curr
            if ªS == typeof curr[name] then throw RangeError "
              #{M}`node.name` '#{name}' is already an object leaf-node"
            if ªU != typeof curr[name] then throw RangeError "
              #{M}`node.name` '#{name}' is already an object branch-node"

Preflight adding a storage item. 

        if @storage
          key = '/'
          value = true # if `path` is empty, `if value` below should be true
          for str,i in path
            value = @storage.getItem( key += str )
            if null == value then break #no node at this path
            if '/' != value then throw RangeError "
              #{M}`node.path[#{i}]` '#{str}' is already a storage leaf-node"
            key += '/'
          if value
            value = @storage.getItem( key += name )
            if '/' == value then throw RangeError "
              #{M}`node.name` '#{name}' is already a storage branch-node"
            if null != value then throw RangeError "
              #{M}`node.name` '#{name}' is already a storage leaf-node"

Preflight adding a filesystem file. 

        if @fs
          rel = @pwd
          real = [] # a handy record of directories which really do exist
          #fsE1 = { code:false }
          for str,i in path #@todo check `'./' + path.join '/'` before all this
            rel += '/' + str
            try
              stat = @fs.statSync rel
            catch fsE1
              if 'ENOENT' == fsE1.code then break # no node at this path
              throw Error "#{M}#{fsE1.code} checking `node.path[#{i}]` '#{str}'"
            if ! stat.isDirectory() then throw RangeError "
              #{M}`node.path[#{i}]` '#{str}' is already a file" # or FIFO, etc
            real.push str
          if real.length == path.length
            fsE2 = { code:false }
          #if ! fsE1.code # `statSync()` didn’t throw, so `path` IS a directory
            rel += '/' + name
            try
              stat = @fs.statSync rel
            catch fsE2
              if 'ENOENT' != fsE2.code then throw Error "
                #{M}#{fsE2.code} checking `node.name` '#{name}'"
            if ! fsE2.code # `statSync()` didn’t throw, so `name` already exists
              if stat.isFile() then throw RangeError "
                #{M}`node.name` '#{name}' is already a file"
              if stat.isDirectory() then throw RangeError "
                #{M}`node.name` '#{name}' is already a directory"

Preflight adding a database record. 

        if @db
          123 #@todo

Preflight adding a DOM element. 

        if @dom
          123 #@todo

Add an object key/value pair. 

        if @object
          curr = @object
          for str,i in path
            if ªU == typeof curr[str] then curr[str] = { __:curr }
            curr = curr[str]
          curr[name] = content

Add a storage item. 

        if @storage
          key = '/'
          for str,i in path
            if null == @storage.getItem( key = "#{key}#{str}" )
              @storage.setItem key, '/' #@todo list child nodes
            key += '/'
          key = "#{key}#{name}"
          @storage.setItem key, '-' + content # '-' to avoid empty strings

Add a filesystem file. 

        if @fs
          rel = rel.replace /\/[^\/]+$/, '' # up a level
          if real.length != path.length
            #ª real
            #ª 'from', real.length,'to',path.length-1
            for i in [real.length..path.length-1]
              rel += '/' + path[i]
              #ª i, 'Make dir ' + rel
              try
                @fs.mkdirSync rel
              catch e
                throw Error "#{M}#{e.code} making `node.path[#{i}]` '#{str}'"
          try
            @fs.writeFileSync rel + '/' + name, content
          catch e
            throw Error "#{M}#{e.code} making `node.name` '#{name}'"

Add a database record. 

        if @db
          123 #@todo

Add a DOM element. 

        if @dom
          123 #@todo

Allow chaining, eg `proon.add(myFirstNode).add(mySecondNode)`. 

        @




#### `delete()`
- `node <object>`              @todo describe
  - `name <string>`            Optional. @todo describe
  - `path <array of strings>`  Optional. @todo describe
- `<Proon>`                    returns this Proon instance, to allow chaining

@todo describe

      delete: (node) ->
        M = "/proon/src/Proon.litcoffee
          Proon:delete()\n  "

        if ªO != ªtype node then throw TypeError "
          #{M}`node` is #{ªtype node} not object"

        name = node.name
        path = node.path

        nameRx = /^[a-z][-a-z0-9]{0,23}$/
        if ªU == typeof name
          name = false
        else if ªS != typeof name then throw TypeError "
          #{M}`node.name` is #{ªtype name} not string"
        else unless nameRx.test name then throw RangeError "
          #{M}`node.name` fails #{nameRx}"

        pathRx = /^[a-z][-a-z0-9]{0,23}$/
        maxLevels = 99
        if ªU == typeof path
          path = []
        else if ªA != ªtype path then throw TypeError "
          #{M}`node.path` is #{ªtype path} not array"
        else if maxLevels < path.length then throw RangeError "
          #{M}`node.path.length` #{path.length} > #{maxLevels}"
        for str,i in path
          if ªS != typeof str then throw TypeError "
            #{M}`node.path[#{i}]` is #{ªtype path[i]} not string"
          unless pathRx.test str then throw RangeError "
            #{M}`node.path[#{i}]` fails #{pathRx}"

Preflight deleting an object key/value pair. 

        if @object
          curr = @object
          for str,i in path
            curr = curr[str]
            if ªU == typeof curr then throw RangeError "
              #{M}`node.path[#{i}]` '#{str}' is undefined in the object"
            if ªS == typeof curr then throw RangeError "
              #{M}`node.path[#{i}]` '#{str}' is an object leaf- not branch-node"
          if name
            if ªU == typeof curr[name] then throw RangeError "
              #{M}`node.name` '#{name}' is undefined in the object"
            if ªS != typeof curr[name] then throw RangeError "
              #{M}`node.name` '#{name}' is an object branch- not leaf-node"

Preflight deleting a storage item. 

        if @storage
          key = '/'
          for str,i in path
            value = @storage.getItem( key += str )
            if null == value then throw RangeError "
              #{M}`node.path[#{i}]` '#{str}' is undefined in storage"
            if '/' != value then throw RangeError "
              #{M}`node.path[#{i}]` '#{str}' is a storage leaf- not branch-node"
            key += '/'
          if name
            value = @storage.getItem key + name
            if null == value then throw RangeError "
              #{M}`node.name` '#{name}' is undefined in storage"
            if '/' == value then throw RangeError "
              #{M}`node.name` '#{name}' is a storage branch- not leaf-node"

Preflight deleting a filesystem file. 

        if @fs
          123 #@todo

Preflight deleting a database record. 

        if @db
          123 #@todo

Preflight deleting a DOM element. 

        if @dom
          123 #@todo

Delete an object key/value pair. 

        if @object
          curr = @object
          curr = curr[str] for str,i in path # like a current working directory
          if name
            delete curr[name] # delete a leaf-node
          else if 0 == path.length
            @object = {} # `proon.delete({ path:[] })`
          else if str = path[--i] #@todo is `if str = path[--i]` needed?
            curr = curr.__ # up a level
            delete curr[str] # delete a branch-node
          while str = path[--i] # traverse upwards, deleting empty branch-nodes
            curr = curr.__ # up a level
            if 1 == Object.keys(curr[str]).length then delete curr[str]

Delete a storage item. 

        if @storage
          key = if path.length then '/' + path.join '/' else ''
          if name
            @storage.removeItem key + '/' + name # delete a leaf-node
          else if 0 == path.length
            @storage.clear() # `proon.delete({ path:[] })`
          else
            @storage.removeItem key # delete a branch-node
            l = key.length
            subs = []
            for i in [0..@storage.length-1] # find sub-node keys
              if (k = @storage.key i) and k.substr(0, l) == key then subs.push k
            for k in subs # delete all sub-nodes
              @storage.removeItem k
          `outer: //` # http://stackoverflow.com/a/7658400
          while key # traverse upwards, deleting empty branch-nodes
            l = key.length
            for i in [0..@storage.length-1]
              if (k = @storage.key i) != key and k.substr(0, l) == key
                `break outer` # found a sub-node, so stop traversing upwards
            @storage.removeItem key # found an empty branch-node
            key = key.replace /\/[^\/]+$/, '' # up a level

Allow chaining, eg `proon.delete(myFirstNode).delete(mySecondNode)`. 

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
