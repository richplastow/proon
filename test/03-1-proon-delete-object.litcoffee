w03-1 Proon `delete()` object
============================


    tudor.add [
      "03-1 Proon `delete()` object"
      tudor.is



      "The method is the expected type"
      -> [new Proon { object:{} }]


      "`proon.delete()` is a function"
      ªF
      (proon) -> proon.delete

      "`proon.delete()` returns an object"
      ªO
      (proon) ->
        proon.add    { name:'a' }
        proon.delete { name:'a' }




      "`proon.delete()` object usage"
      tudor.equal


      "`proon.object` is empty after the previous test"
      '{}'
      (proon) -> objectSerializer proon.object


      "Add a top-level leaf-node, `proon.add({ name:'a', content:'ok' })`"
      '{"a":"ok"}'
      (proon) ->
        proon.add { name:'a', content:'ok' }
        objectSerializer proon.object


      "Delete the top-level leaf-node, `proon.delete({ name:'a' })`"
      '{}'
      (proon) ->
        proon.delete { name:'a' }
        objectSerializer proon.object


      "Add two second-level leaf-nodes"
      '{"a":{"b":"one","c":"two"}}'
      (proon) ->
        proon
          .add({ path:['a'], name:'b', content:'one' })
          .add({ path:['a'], name:'c', content:'two' })
        objectSerializer proon.object


      "Delete the first second-level leaf-node"
      '{"a":{"c":"two"}}'
      (proon) ->
        proon.delete { path:['a'], name:'b' }
        objectSerializer proon.object


      "Delete the second second-level leaf-node"
      '{}'
      (proon) ->
        proon.delete { path:['a'], name:'c' }
        objectSerializer proon.object


      "Add a fifth-level leaf-node"
      '{"a":{"b":{"c":{"d":{"e":{"f":"deep!"}}}}}}'
      (proon) ->
        proon.add({ path:['a','b','c','d','e'], name:'f', content:'deep!' })
        objectSerializer proon.object


      "Delete the fifth-level leaf-node"
      '{}'
      (proon) ->
        proon.delete { path:['a','b','c','d','e'], name:'f' }
        objectSerializer proon.object


      "Add a fifth-level leaf-node, and then insert a third-level leaf-node"
      '{"a":{"b":{"c":{"d":{"e":{"f":"deep!"}},"g":"middle"}}}}'
      (proon) ->
        proon
          .add({ path:['a','b','c','d','e'], name:'f', content:'deep!' })
          .add({ path:['a','b','c'], name:'g', content:'middle' })
        objectSerializer proon.object


      "Delete the fifth-level leaf-node, but not the third-level leaf-node"
      '{"a":{"b":{"c":{"g":"middle"}}}}'
      (proon) ->
        proon.delete { path:['a','b','c','d','e'], name:'f' }
        objectSerializer proon.object


      "Add a fifth-level leaf-node again"
      '{"a":{"b":{"c":{"g":"middle","d":{"e":{"f":"returned!"}}}}}}'
      (proon) ->
        proon
          .add({ path:['a','b','c','d','e'], name:'f', content:'returned!' })
        objectSerializer proon.object


      "Delete the third-level leaf-node, but not the fifth-level leaf-node"
      '{"a":{"b":{"c":{"d":{"e":{"f":"returned!"}}}}}}'
      (proon) ->
        proon.delete { path:['a','b','c'], name:'g' }
        objectSerializer proon.object


      "Delete the second-level branch-node"
      '{}'
      (proon) ->
        proon.delete { path:['a','b'] }
        objectSerializer proon.object


      "Add fifth- and third-level leaf-nodes, and a sub-tree in the third-level"
      '{"a":{"b":{"c":{"d":{"e":{"f":"deep!"}},"g":"middle","p":{"q":{"r":"side"}}}}}}'
      (proon) ->
        proon
          .add({ path:['a','b','c','d','e'], name:'f', content:'deep!' })
          .add({ path:['a','b','c'], name:'g', content:'middle' })
          .add({ path:['a','b','c','p','q'], name:'r', content:'side' })
        objectSerializer proon.object


      "Delete the fourth-level branch-node"
      '{"a":{"b":{"c":{"g":"middle","p":{"q":{"r":"side"}}}}}}'
      (proon) ->
        proon.delete { path:['a','b','c','d'] }
        objectSerializer proon.object


      "Delete the 'q' branch-node"
      '{"a":{"b":{"c":{"g":"middle"}}}}'
      (proon) ->
        proon.delete { path:['a','b','c','p','q'] }
        objectSerializer proon.object


      "Add a second top-level branch-node"
      '{"a":{"b":{"c":{"g":"middle"}}},"x":{"y":{"z":"another"}}}'
      (proon) ->
        proon.add({ path:['x','y'], name:'z', content:'another' })
        objectSerializer proon.object


      "Delete everything, by specifying `path:[]`"
      '{}'
      (proon) ->
        proon.delete { path:[] }
        objectSerializer proon.object




      "`proon.delete()` object exceptions"
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
        `node.name` 'x' is undefined in the object"""
      (proon) ->
        proon.add    { name:'c', path:['a','b'] }
        proon.delete { name:'x', path:['a','b'] }


      "If set, `node.name` must not refer to a branch-node"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.name` 'a' is an object branch- not leaf-node"""
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
        `node.path[1]` 'x' is undefined in the object"""
      (proon) -> proon.delete { path:['a','x'], name:'c' }


      "If set, `node.path` must node refer to a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.path[2]` 'c' is an object leaf- not branch-node"""
      (proon) -> proon.delete { path:['a','b','c'] }



    ];
