02 Proon `add()`
================


    tudor.add [
      "02 Proon `add()`"
      tudor.is



      "The method is the expected type"
      -> [new Proon]


      "`proon.add()` is a function"
      ªF
      (proon) -> proon.add

      "`proon.add()` returns an object"
      ªO
      (proon) -> proon.add '', {}




      "`proon.add()` exceptions"
      tudor.throw


      "The `path` argument must not be passed an array"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `path` is array not string"""
      (proon) -> proon.add [], {}


      "The `node` argument must not be passed a number"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node` is number not object"""
      (proon) -> proon.add '', 123






    ];
