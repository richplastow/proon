02-2 Proon `add()` storage
==========================


    tudor.add [
      "02-2 Proon `add()` storage"
      tudor.is



      "(Set up a Proon instance with sessionStorage)"
      ->
        if window?.sessionStorage
          s = window.sessionStorage
          s.clear()
        else
          s =
            setItem: (key, value) ->
              @[key] = value
              @length++
              @keys.push key
            getItem: (key) ->
              @[key] || null
            key: (i) ->
              @keys[i]
            length: 0
            keys: []

        [new Proon { storage:s }]

      "`proon.add()` records to storage without error"
      ªO
      (proon) ->
        result = proon.add { name:'c', path:['a','b'] }
        #s = window.sessionStorage
        #for i in [0..s.length-1]
        #  ª s.key(i), s.getItem [s.key(i)]
        #result




      "`proon.add()` storage exceptions"
      tudor.throw


node.name

      "`node.name` must not already be a branch-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` 'a' is already a storage branch-node"""
      (proon) -> proon.add { name:'a' }


      "`node.name` must not already be a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` 'c' is already a storage leaf-node"""
      (proon) -> proon.add { name:'c', path:['a','b'] }


node.path

      "If set, `node.path` must not overwrite a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.path[2]` 'c' is already a storage leaf-node"""
      (proon) -> proon.add { name:'d', path:['a','b','c'] }


node.content

      "If set, `node.content` must not be an array"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.content` is array not string"""
      (proon) -> proon.add { name:'foo', content:['abc'] }




      "`proon.add()` storage usage"
      tudor.equal


      "`proon.storage` contains the expected key/value pairs"
      """
      /a/ /
      /a/b/ /
      /a/b/c -
      """
      (proon) ->
        out = []
        s = proon.storage
        for i in [0..s.length-1]
          out.push s.key(i) + ' ' + s.getItem [s.key(i)]
        out.sort().join '\n'



    ];
