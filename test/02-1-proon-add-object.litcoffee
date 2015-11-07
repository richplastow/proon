02-1 Proon `add()` object
=========================


    tudor.add [
      "02-1 Proon `add()` object"
      tudor.is



      "The method is the expected type"
      -> [new Proon { object:{} }]


      "`proon.add()` is a function"
      ªF
      (proon) -> proon.add

      "`proon.add()` returns an object"
      ªO
      (proon) -> proon.add { name:'c', path:['a','b'] }




      "`proon.add()` object exceptions"
      tudor.throw


      "The `node` argument is not optional"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node` is undefined not object"""
      (proon) -> proon.add()


      "The `node` argument must not be an array"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node` is array not object"""
      (proon) -> proon.add []


node.name

      "`node.name` is not optional"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` is undefined not string"""
      (proon) -> proon.add {}


      "`node.name` must not be an array"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` is array not string"""
      (proon) -> proon.add { name:[] }


      "`node.name` must not begin with a hyphen"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.add { name:'-foo' }


      "`node.name` must not begin with a digit"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.add { name:'3foo' }


      "`node.name` must not contain capital letters"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.add { name:'fOo' }


      "`node.name` must not contain a dot"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.add { name:'fo.o' }

      #@todo more `nameRx` fails


      "`node.name` must not already be a branch-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` 'a' is already an object branch-node"""
      (proon) -> proon.add { name:'a' }


      "`node.name` must not already be a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` 'c' is already an object leaf-node"""
      (proon) -> proon.add { name:'c', path:['a','b'] }


node.path

      "If set, `node.path` must not be a string"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.path` is string not array"""
      (proon) -> proon.add { path:'abc', name:'foo' }


      "If set, `node.path` must not contain 100 or more levels"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.path.length` 100 > 99"""
      (proon) -> proon.add { path:(Array(101).join('/a').split('/').slice(1)), name:'foo' }


      "If set, `node.path` must not contain numbers"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.path[1]` is number not string"""
      (proon) -> proon.add { path:['abc',123,'ghi'], name:'foo' }


      "If set, `node.path` branch-nodes must not contain '*'"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.path[1]` fails /^[a-z][-a-z0-9]{0,23}$/"""
      (proon) -> proon.add { path:['abc','d*ef','ghi'], name:'foo' }

      #@todo more `pathRx` fails


      "If set, `node.path` must not overwrite a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.path[2]` 'c' is already an object leaf-node"""
      (proon) -> proon.add { name:'d', path:['a','b','c'] }


node.content

      "If set, `node.content` must not be a number"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.content` is number not string"""
      (proon) -> proon.add { name:'foo', content:123 }


      "If set, `node.content.length` must 1024 * 1024 or less"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.content.length` 1049599 > 1048576"""
      (proon) -> proon.add { name:'foo', content:(Array(1024*1025).join('x')) }




      "`proon.add()` object usage"
      tudor.equal


      "`proon.object` stringifies as expected"
      '{"a":{"b":{"c":""}}}'
      (proon) -> objectSerializer proon.object



    ];
