01 Proon Constructor
====================


    tudor.add [
      "01 Proon Constructor"
      tudor.is




      "The class and instance are expected types"


      "The Proon class is a function"
      ªF
      -> Proon

      "`new` returns an object"
      ªO
      -> new Proon




     "`config.object` exceptions"
      tudor.throw


      "If set, `config.object` must not be an array"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.object` is array not object"""
      -> new Proon { object:[] }


      "If set, `config.object` must not be null"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.object` is null not object"""
      -> new Proon { object:null }




     "`config.storage` exceptions"
      tudor.throw


      "If set, `config.storage` must not be a Date instance"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.storage` is date not object or storage"""
      -> new Proon { storage:new Date }


      "If set, `config.storage` must not be null"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.storage` is null not object or storage"""
      -> new Proon { storage:null }


      "If `config.storage` is set, `config.storage.setItem` must be defined"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.storage` has no `setItem()` method"""
      -> new Proon { storage:{} }


      "If set, `config.storage` must have a `setItem()` method"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.storage` has no `setItem()` method"""
      -> new Proon { storage:{ setItem:123 } }

      #@todo full API check




      "`config.fs` exceptions"


      "If set, `config.fs` must not be an array"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.fs` is array not object"""
      -> new Proon { fs:[] }


      "If set, `config.fs` must not be null"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.fs` is null not object"""
      -> new Proon { fs:null }


      "If `config.fs` is set, `config.fs.readFileSync` must be defined"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.fs` has no `readFileSync()` method"""
      -> new Proon { fs:{} }


      "If set, `config.fs` must have a `readFileSync()` method"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.fs` has no `readFileSync()` method"""
      -> new Proon { fs:{ readFileSync:123 } }

      #@todo full API check




      "`config.db` exceptions"


      "If set, `config.db` must not be the Math object"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.db` is math not object"""
      -> new Proon { db:Math }

      #@todo implement db




      "`config.dom` exceptions"


      "If set, `config.dom` must not be a regexp"
      """
      /proon/src/Proon.litcoffee Proon()
        Optional `config.dom` is regexp not object"""
      -> new Proon { dom:/abc/ }

      #@todo implement dom




    ];
