02-4 Proon `add()` dom
======================


    tudor.add [
      "02-4 Proon `add()` dom"
      tudor.is


      "(Set up a Proon instance with dom)"
      ->
        domMock = new Node.HTMLDocument # for Node.js, Espruino, etc

        if ªU == typeof window || ªO != typeof window.document || ªO != typeof window.document.body
          dom = domMock
        else
          dom = window.document

        root = dom.createElement 'div' # will be removed at the end of this section
        root.setAttribute 'id', '_tmp'
        dom.body.appendChild root

        [new Proon { dom:dom, root:'_tmp' }]


      "`proon.add()` records to dom without error"
      ªO
      (proon) ->
        proon
          .add { name:'c', path:['a','b'] }
          .add { name:'d', content:'ok' }




      "`proon.add()` dom exceptions"
      tudor.throw


node.name

      "`node.name` must not already be a branch-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` 'a' is already a dom branch-element"""
      (proon) -> proon.add { name:'a' }


      "`node.name` must not already be a top-level leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` 'd' is already a dom leaf-element"""
      (proon) -> proon.add { name:'d' }


      "`node.name` must not already be a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` 'c' is already a dom leaf-element"""
      (proon) -> proon.add { name:'c', path:['a','b'] }


node.path

      "If set, `node.path` must not overwrite a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.path[2]` 'c' is already a dom leaf-element"""
      (proon) -> proon.add { name:'nope', path:['a','b','c'] }


node.content

      "If set, `node.content` must not be a number"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.content` is number not string"""
      (proon) -> proon.add { name:'foo', content:123 }




      "`proon.add()` cleanup"
      tudor.equal


      "`proon.dom` as expected before cleanup"
      """
      a
      a_b
      a_b_c
      d ok
      """
      (proon) ->
        proon._domSerializer()




      "(Clean up dom)"
      undefined
      (proon) ->
        root = proon.dom.getElementById '_tmp'
        proon.dom.body.removeChild root
        undefined

    ];
