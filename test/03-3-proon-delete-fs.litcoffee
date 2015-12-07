03-3 Proon `delete()` fs
========================


    tudor.add [
      "03-3 Proon `delete()` fs"
      tudor.is


      "(Set up a Proon instance with fs)"
      ->
        fsMock = # for browsers
          paths: {}
          readFileSync: (path) ->
            if ! @paths[path]
              err = Error "ENOENT, no such file or directory '#{path}'"
              err.code = 'ENOENT'
              throw err
            if '/' == @paths[path]
              err = Error "EISDIR, illegal operation on a directory"
              err.code = 'EISDIR'
              throw err
            @paths[path]
          writeFileSync: (path, content) ->
            #@todo test whether path exists
            @paths[path] = '-'+content
          mkdirSync: (path) ->
            if @paths[path]
              err = Error "EEXIST, file already exists '#{path}'"
              err.code = 'EEXIST'
              throw err
            parent = path.replace(/\/[^\/]+$/, '')
            if parent and '.' != parent and ! @paths[parent]
              err = Error "ENOENT, no such file or directory '#{path}'"
              err.code = 'ENOENT' # `'#{parent}'` would make sense - but follow Node.js
              throw err
            @paths[path] = '/'
          unlinkSync: (path) ->
            if ! @paths[path]
              err = Error "ENOENT, no such file or directory '#{path}'"
              err.code = 'ENOENT'
              throw err
            if '/' == @paths[path]
              err = Error "EPERM, operation not permitted '#{path}'"
              err.code = 'EPERM'
              throw err
            delete @paths[path]
          rmdirSync: (path) ->
            if ! @paths[path]
              err = Error "ENOENT, no such file or directory '#{path}'"
              err.code = 'ENOENT'
              throw err
            if '/' != @paths[path]
              err = Error "ENOTDIR, not a directory '#{path}'"
              err.code = 'ENOTDIR'
              throw err
            l = path.length
            for p,content of @paths
              if p == path then continue
              if p.substr(0, l) == path
                err = Error "ENOTEMPTY, directory not empty '#{path}'"
                err.code = 'ENOTEMPTY'
                throw err
            delete @paths[path]
            undefined #@todo ensure all methods return same value as in node.js
          readdirSync: (path='') ->
            if path
              if ! @paths[path]
                err = Error "ENOENT, no such file or directory '#{path}'"
                err.code = 'ENOENT'
                throw err
              if '/' != @paths[path]
                err = Error "ENOTDIR, not a directory '#{path}'"
                err.code = 'ENOTDIR'
                throw err
            items = []
            l = path.length
            for p,content of @paths
              if p == path then continue
              if p.substr(0, l) == path
                if -1 == p.substr(l+1).indexOf '/'
                  items.push p.substr(l+1)
            items
          statSync: (path) ->
            if ! @paths[path]
              err = Error "ENOENT, no such file or directory '#{path}'"
              err.code = 'ENOENT'
              throw err
            that = @
            {
              isFile:      () -> that.paths[path] and '/' != that.paths[path]
              isDirectory: () -> that.paths[path] and '/' == that.paths[path]
            }

        if ªF != typeof require
          fs = fsMock
        else
          try
            fs = require 'fs'
          catch e
            fs = fsMock

        # Assumes Node.js is run from top of repo directory:
        try
          fs.mkdirSync './test' # browser (using `fsMock`) needs this, but Node.js will throw an 'EEXIST' error
        catch e
          if 'EEXIST' != e.code then throw e # propogate an unexpected error
        fs.mkdirSync './test/tmp' # the 'tmp' directory will be removed at the end of this section

        [new Proon { fs:fs, pwd:'./test/tmp' }]


      "`proon.delete()` works on filesytem without error"
      ªO
      (proon) ->
        proon._fsClear() #@todo test
        proon.add    { name:'a' }
        proon.delete { name:'a' }




      "`proon.delete()` fs usage"
      tudor.equal


      "`proon.fs` is empty after the previous test"
      '[EMPTY]'
      (proon) -> proon._fsSerializer()


      "Add a top-level leaf-node, `proon.add({ name:'a', content:'ok' })`"
      'a'
      (proon) ->
        proon.add { name:'a', content:'ok' }
        proon._fsSerializer()


      "Delete the top-level leaf-node, `proon.delete({ name:'a' })`"
      '[EMPTY]'
      (proon) ->
        proon.delete { name:'a' }
        proon._fsSerializer()


      "Add two second-level leaf-nodes"
      """
      a
      a/b
      a/c
      """
      (proon) ->
        proon
          .add({ path:['a'], name:'b', content:'one' })
          .add({ path:['a'], name:'c', content:'two' })
        proon._fsSerializer()


      "Delete the first second-level leaf-node"
      """
      a
      a/c
      """
      (proon) ->
        proon.delete { path:['a'], name:'b' }
        proon._fsSerializer()


      "Delete the second second-level leaf-node"
      '[EMPTY]'
      (proon) ->
        proon.delete { path:['a'], name:'c' }
        proon._fsSerializer()


      "Add a fifth-level leaf-node"
      """
      a
      a/b
      a/b/c
      a/b/c/d
      a/b/c/d/e
      a/b/c/d/e/f
      """
      (proon) ->
        proon.add({ path:['a','b','c','d','e'], name:'f', content:'deep!' })
        proon._fsSerializer()


      "Delete the fifth-level leaf-node"
      '[EMPTY]'
      (proon) ->
        proon.delete { path:['a','b','c','d','e'], name:'f' }
        proon._fsSerializer()


      "Add a fifth-level leaf-node, and then insert a third-level leaf-node"
      """
      a
      a/b
      a/b/c
      a/b/c/d
      a/b/c/d/e
      a/b/c/d/e/f
      a/b/c/g
      """
      (proon) ->
        proon
          .add({ path:['a','b','c','d','e'], name:'f', content:'deep!' })
          .add({ path:['a','b','c'], name:'g', content:'middle' })
        proon._fsSerializer()


      "Delete the fifth-level leaf-node, but not the third-level leaf-node"
      """
      a
      a/b
      a/b/c
      a/b/c/g
      """
      (proon) ->
        proon.delete { path:['a','b','c','d','e'], name:'f' }
        proon._fsSerializer()


      "Add a fifth-level leaf-node again"
      """
      a
      a/b
      a/b/c
      a/b/c/d
      a/b/c/d/e
      a/b/c/d/e/f
      a/b/c/g
      """
      (proon) ->
        proon
          .add({ path:['a','b','c','d','e'], name:'f', content:'returned!' })
        proon._fsSerializer()


      "Delete the third-level leaf-node, but not the fifth-level leaf-node"
      """
      a
      a/b
      a/b/c
      a/b/c/d
      a/b/c/d/e
      a/b/c/d/e/f
      """
      (proon) ->
        proon.delete { path:['a','b','c'], name:'g' }
        proon._fsSerializer()


      "Spike fs with an unexpected item"
      """
      a
      a/b
      a/b/c
      a/b/c/d
      a/b/c/d/e
      a/b/c/d/e/f
      oops
      """
      (proon) ->
        proon.fs.writeFileSync proon.pwd + '/oops', 'How unexpected'
        proon._fsSerializer()


      "Delete the second-level branch-node"
      'oops'
      (proon) ->
        proon.delete { path:['a','b'] }
        proon._fsSerializer()


      "Add fifth- and third-level leaf-nodes, and a sub-tree in the third-level"
      """
      a
      a/b
      a/b/c
      a/b/c/d
      a/b/c/d/e
      a/b/c/d/e/f
      a/b/c/g
      a/b/c/p
      a/b/c/p/q
      a/b/c/p/q/r
      oops
      """
      (proon) ->
        proon
          .add({ path:['a','b','c','d','e'], name:'f', content:'deep!' })
          .add({ path:['a','b','c'], name:'g', content:'middle' })
          .add({ path:['a','b','c','p','q'], name:'r', content:'side' })
        proon._fsSerializer()


      "Delete the fourth-level branch-node"
      """
      a
      a/b
      a/b/c
      a/b/c/g
      a/b/c/p
      a/b/c/p/q
      a/b/c/p/q/r
      oops
      """
      (proon) ->
        proon.delete { path:['a','b','c','d'] }
        proon._fsSerializer()


      "Delete the 'q' branch-node"
      """
      a
      a/b
      a/b/c
      a/b/c/g
      oops
      """
      (proon) ->
        proon.delete { path:['a','b','c','p','q'] }
        proon._fsSerializer()


      "Add a second top-level branch-node"
      """
      a
      a/b
      a/b/c
      a/b/c/g
      oops
      x
      x/y
      x/y/z
      """
      (proon) ->
        proon.add({ path:['x','y'], name:'z', content:'another' })
        proon._fsSerializer()


      "Delete everything, by specifying `path:[]`"
      '[EMPTY]'
      (proon) ->
        proon.delete { path:[] }
        proon._fsSerializer()


      "Delete everything when already empty"
      '[EMPTY]'
      (proon) ->
        proon.delete { path:[] }
        proon._fsSerializer()
      #@todo add this to object and storage tests



      "`proon.delete()` fs exceptions"
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
        `node.name` 'x' does not exist in filesystem"""
      (proon) ->
        proon.add    { name:'c', path:['a','b'] } # will be cleaned up, below
        proon.delete { name:'x', path:['a','b'] }


      "If set, `node.name` must not refer to a branch-node"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.name` 'a' is a directory, not a file"""
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
        `node.path[1]` 'x' does not exist in filesystem"""
      (proon) -> proon.delete { path:['a','x'], name:'c' }


      "If set, `node.path` must node refer to a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:delete()
        `node.path[2]` 'c' is a file, not a directory"""
      (proon) -> proon.delete { path:['a','b','c'] }




      "`proon.delete()` cleanup"
      tudor.equal


      "`proon.filesytem` as expected before cleanup"
      """
      a
      a/b
      a/b/c
      """
      (proon) ->
        proon._fsSerializer()




      "(Clean up filesystem)"
      undefined
      (proon) ->
        proon.fs.unlinkSync proon.pwd + '/a/b/c'
        proon.fs.rmdirSync  proon.pwd + '/a/b'
        proon.fs.rmdirSync  proon.pwd + '/a'
        proon.fs.rmdirSync './test/tmp'

    ];
