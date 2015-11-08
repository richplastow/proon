03-2 Proon `delete()` storage
=============================


    tudor.add [
      "03-2 Proon `delete()` storage"
      tudor.is



      "(Set up a Proon instance with sessionStorage)"
      ->
        if window?.sessionStorage
          s = window.sessionStorage
          s.clear()
        else
          s =
            setItem: (key, value) -> #@todo key already exists
              @[key] = value
              @length++
              @keys.push key
            getItem: (key) ->
              @[key] || null
            removeItem: (key) ->
              i = @keys.indexOf key
              if -1 == i then return # key not recognized
              @keys.splice i, 1
              @length--
              delete @[key]
            clear: ->
              delete @[key] for key in @keys
              @length = 0
              @keys = []
            key: (i) ->
              @keys[i]
            length: 0
            keys: []

        [new Proon { storage:s }]


      "`proon.delete()` works on storage without error"
      ªO
      (proon) ->
        proon.storage.clear()
        proon.add    { name:'a' }
        proon.delete { name:'a' }




      "`proon.delete()` storage usage"
      tudor.equal


      "`proon.storage` is empty after the previous test"
      '[EMPTY]'
      (proon) -> storageSerializer proon.storage


      "Add a top-level leaf-node, `proon.add({ name:'a', content:'ok' })`"
      '/a -ok'
      (proon) ->
        proon.add { name:'a', content:'ok' }
        storageSerializer proon.storage


      "Delete the top-level leaf-node, `proon.delete({ name:'a' })`"
      '[EMPTY]'
      (proon) ->
        proon.delete { name:'a' }
        storageSerializer proon.storage


      "Add two second-level leaf-nodes"
      """
      /a /
      /a/b -one
      /a/c -two
      """
      (proon) ->
        proon
          .add({ path:['a'], name:'b', content:'one' })
          .add({ path:['a'], name:'c', content:'two' })
        storageSerializer proon.storage


      "Delete the first second-level leaf-node"
      """
      /a /
      /a/c -two
      """
      (proon) ->
        proon.delete { path:['a'], name:'b' }
        storageSerializer proon.storage


      "Delete the second second-level leaf-node"
      '[EMPTY]'
      (proon) ->
        proon.delete { path:['a'], name:'c' }
        storageSerializer proon.storage


      "Add a fifth-level leaf-node"
      """
      /a /
      /a/b /
      /a/b/c /
      /a/b/c/d /
      /a/b/c/d/e /
      /a/b/c/d/e/f -deep!
      """
      (proon) ->
        proon.add({ path:['a','b','c','d','e'], name:'f', content:'deep!' })
        storageSerializer proon.storage


      "Delete the fifth-level leaf-node"
      '[EMPTY]'
      (proon) ->
        proon.delete { path:['a','b','c','d','e'], name:'f' }
        storageSerializer proon.storage


      "Add a fifth-level leaf-node, and then insert a third-level leaf-node"
      """
      /a /
      /a/b /
      /a/b/c /
      /a/b/c/d /
      /a/b/c/d/e /
      /a/b/c/d/e/f -deep!
      /a/b/c/g -middle
      """
      (proon) ->
        proon
          .add({ path:['a','b','c','d','e'], name:'f', content:'deep!' })
          .add({ path:['a','b','c'], name:'g', content:'middle' })
        storageSerializer proon.storage


      "Delete the fifth-level leaf-node, but not the third-level leaf-node"
      """
      /a /
      /a/b /
      /a/b/c /
      /a/b/c/g -middle
      """
      (proon) ->
        proon.delete { path:['a','b','c','d','e'], name:'f' }
        storageSerializer proon.storage


      "Add a fifth-level leaf-node again"
      """
      /a /
      /a/b /
      /a/b/c /
      /a/b/c/d /
      /a/b/c/d/e /
      /a/b/c/d/e/f -returned!
      /a/b/c/g -middle
      """
      (proon) ->
        proon
          .add({ path:['a','b','c','d','e'], name:'f', content:'returned!' })
        storageSerializer proon.storage


      "Delete the third-level leaf-node, but not the fifth-level leaf-node"
      """
      /a /
      /a/b /
      /a/b/c /
      /a/b/c/d /
      /a/b/c/d/e /
      /a/b/c/d/e/f -returned!
      """
      (proon) ->
        proon.delete { path:['a','b','c'], name:'g' }
        storageSerializer proon.storage


      "Spike storage with an unexpected item"
      """
      /a /
      /a/b /
      /a/b/c /
      /a/b/c/d /
      /a/b/c/d/e /
      /a/b/c/d/e/f -returned!
      oops How unexpected
      """
      (proon) ->
        proon.storage.setItem 'oops', 'How unexpected'
        storageSerializer proon.storage


      "Delete the second-level branch-node"
      'oops How unexpected'
      (proon) ->
        proon.delete { path:['a','b'] }
        storageSerializer proon.storage


      "Add fifth- and third-level leaf-nodes, and a sub-tree in the third-level"
      """
      /a /
      /a/b /
      /a/b/c /
      /a/b/c/d /
      /a/b/c/d/e /
      /a/b/c/d/e/f -deep!
      /a/b/c/g -middle
      /a/b/c/p /
      /a/b/c/p/q /
      /a/b/c/p/q/r -side
      oops How unexpected
      """
      (proon) ->
        proon
          .add({ path:['a','b','c','d','e'], name:'f', content:'deep!' })
          .add({ path:['a','b','c'], name:'g', content:'middle' })
          .add({ path:['a','b','c','p','q'], name:'r', content:'side' })
        storageSerializer proon.storage


      "Delete the fourth-level branch-node"
      """
      /a /
      /a/b /
      /a/b/c /
      /a/b/c/g -middle
      /a/b/c/p /
      /a/b/c/p/q /
      /a/b/c/p/q/r -side
      oops How unexpected
      """
      (proon) ->
        proon.delete { path:['a','b','c','d'] }
        storageSerializer proon.storage


      "Delete the 'q' branch-node"
      """
      /a /
      /a/b /
      /a/b/c /
      /a/b/c/g -middle
      oops How unexpected
      """
      (proon) ->
        proon.delete { path:['a','b','c','p','q'] }
        storageSerializer proon.storage


      "Add a second top-level branch-node"
      """
      /a /
      /a/b /
      /a/b/c /
      /a/b/c/g -middle
      /x /
      /x/y /
      /x/y/z -another
      oops How unexpected
      """
      (proon) ->
        proon.add({ path:['x','y'], name:'z', content:'another' })
        storageSerializer proon.storage


      "Delete everything, by specifying `path:[]`"
      '[EMPTY]'
      (proon) ->
        proon.delete { path:[] }
        storageSerializer proon.storage




      "`proon.delete()` storage exceptions"
      tudor.throw


      "The `node` argument is not optional"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node` is undefined not object"""
      (proon) -> proon.delete()


      "The `node` argument must not be an array"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node` is array not object"""
      (proon) -> proon.delete []


node.name

      "If set, `node.name` must not be an array"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.name` is array not string"""
      (proon) -> proon.delete { name:[] }


      "`node.name` must not be just a hyphen"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.name` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.delete { name:'-' }


      "`node.name` must not be just a digit"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.name` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.delete { name:'0' }


      "`node.name` must not be just a capital letter"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.name` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.delete { name:'A' }


      "`node.name` must not contain an underscore"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.name` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.delete { name:'fo_o' }

      #@todo more `nameRx` fails


      "If set, `node.name` must exist"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.name` 'x' is undefined in storage"""
      (proon) ->
        proon.add    { name:'c', path:['a','b'] }
        proon.delete { name:'x', path:['a','b'] }


      "If set, `node.name` must not refer to a branch-node"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.name` 'a' is a storage branch- not leaf-node"""
      (proon) ->
        proon.delete { name:'a' }


      "If set, `node.name` must not be '__'"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.name` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) ->
        proon.delete { name:'__', path:['a','b'] }


node.path

      "If set, `node.path` must not be a string"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.path` is string not array"""
      (proon) -> proon.delete { path:'abc', name:'foo' }


      "If set, `node.path` must not contain 100 or more levels"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.path.length` 100 > 99"""
      (proon) -> proon.delete { path:(Array(101).join('/a').split('/').slice(1)), name:'foo' }


      "If set, `node.path` must not contain arrays"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.path[1]` is array not string"""
      (proon) -> proon.add { path:['abc',['def'],'ghi'], name:'foo' }


      "If set, `node.path`  must not contain '/'"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.path[1]` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.add { path:['abc','d/ef','ghi'], name:'foo' }


      "If set, `node.path` must not contain '__'"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.path[1]` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.delete { path:['a','__'] }

      #@todo more `pathRx` fails


      "If set, `node.path` must exist"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.path[1]` 'x' is undefined in storage"""
      (proon) -> proon.delete { path:['a','x'], name:'c' }


      "If set, `node.path` must node refer to a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.path[2]` 'c' is a storage leaf- not branch-node"""
      (proon) -> proon.delete { path:['a','b','c'] }



    ];
