02-3 Proon `add()` fs
=====================


    tudor.add [
      "02-3 Proon `add()` fs"
      tudor.is


      "(Set up a Proon instance with fs)"
      ->
        fsMock = # for browsers
          paths: {}
          readFileSync: (path) ->
            if ! @paths[path]
              err = Error "Error: ENOENT, no such file or directory '#{path}'"
              err.code = 'ENOENT'
              throw err
            if '/' == @paths[path]
              err = Error "Error: EISDIR, illegal operation on a directory"
              err.code = 'EISDIR'
              throw err
            @paths[path]
          writeFileSync: (path, content) ->
            #@todo test whether path exists
            @paths[path] = '-'+content
          mkdirSync: (path) ->
            if @paths[path]
              err = Error "Error: EEXIST, file already exists '#{path}'"
              err.code = 'EEXIST'
              throw err
            parent = path.replace(/\/[^\/]+$/, '')
            if parent and '.' != parent and ! @paths[parent]
              err = Error "Error: ENOENT, no such file or directory '#{path}'"
              err.code = 'ENOENT' # `'#{parent}'` would make sense - but follow Node.js
              throw err
            @paths[path] = '/'
          unlinkSync: (path) ->
            if ! @paths[path]
              err = Error "Error: ENOENT, no such file or directory '#{path}'"
              err.code = 'ENOENT'
              throw err
            if '/' == @paths[path]
              err = Error "Error: EPERM, operation not permitted '#{path}'"
              err.code = 'EPERM'
              throw err
            delete @paths[path]
          rmdirSync: (path) ->
            if ! @paths[path]
              err = Error "Error: ENOENT, no such file or directory '#{path}'"
              err.code = 'ENOENT'
              throw err
            if '/' != @paths[path]
              err = Error "Error: ENOTDIR, not a directory '#{path}'"
              err.code = 'ENOTDIR'
              throw err
            l = path.length
            for p,content of @paths
              if p == path then continue
              if p.substr(0, l) == path
                err = Error "Error: ENOTEMPTY, directory not empty '#{path}'"
                err.code = 'ENOTEMPTY'
                throw err
            delete @paths[path]
            undefined #@todo ensure all methods return same value as in node.js
          readdirSync: (path='') ->
            if path
              if ! @paths[path]
                err = Error "Error: ENOENT, no such file or directory '#{path}'"
                err.code = 'ENOENT'
                throw err
              if '/' != @paths[path]
                err = Error "Error: ENOTDIR, not a directory '#{path}'"
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
              err = Error "Error: ENOENT, no such file or directory '#{path}'"
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
        fs.mkdirSync './test/tmp' # will be removed at the end of this section

        [new Proon { fs:fs, pwd:'./test/tmp' }]


      "`proon.add()` records to filesytem without error"
      ªO
      (proon) ->
        result = proon
          .add { name:'c', path:['a','b'] }
          .add { name:'d', content:'ok' }




      "`proon.add()` filesytem exceptions"
      tudor.throw


node.name

      "`node.name` must not already be a branch-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` 'a' is already a directory"""
      (proon) -> proon.add { name:'a' }


      "`node.name` must not already be a top-level leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` 'd' is already a file"""
      (proon) -> proon.add { name:'d' }


      "`node.name` must not already be a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.name` 'c' is already a file"""
      (proon) -> proon.add { name:'c', path:['a','b'] }


node.path

      "If set, `node.path` must not overwrite a leaf-node"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.path[2]` 'c' is already a file"""
      (proon) -> proon.add { name:'nope', path:['a','b','c'] }


node.content

      "If set, `node.content` must not be an array"
      """
      /proon/src/Proon.litcoffee Proon:add()
        `node.content` is array not string"""
      (proon) -> proon.add { name:'foo', content:['abc'] }




      "`proon.add()` filesytem usage"
      tudor.equal


      "`proon.filesytem` contains the expected key/value pairs"
      """
      a
      a/b
      a/b/c
      d
      """
      (proon) -> fsSerializer proon.fs, proon.pwd




      "(Clean up filesystem)"
      undefined
      (proon) ->
        proon.fs.unlinkSync proon.pwd + '/d'
        proon.fs.unlinkSync proon.pwd + '/a/b/c'
        proon.fs.rmdirSync  proon.pwd + '/a/b'
        proon.fs.rmdirSync  proon.pwd + '/a'
        proon.fs.rmdirSync './test/tmp'

    ];
