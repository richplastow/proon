Akaybe Helpers
===========

#### Define the core Akaybe helper functions

Akaybe’s helper functions are visible to all code defined in ‘src/’ and ‘test/’ 
but are hidden from code defined elsewhere in the runtime environment. 

- Helpers are ‘pure’ (they return the same output for a given set of arguments)
- They have no side-effects, other than throwing exceptions
- They run identically in all modern environments (browser, server, desktop, …)
- Each Akaybe helper function minifies to 1024 bytes or less




#### `ª()`
A handy shortcut for `console.log()`. Note [`bind()`](http://goo.gl/66ffgl). 

    ª = console.log.bind console




#### `ªex()`
Exchanges a character from one set for its equivalent in another. To decompose 
an accent, use `ªex(c, 'àáäâèéëêìíïîòóöôùúüûñç', 'aaaaeeeeiiiioooouuuunc')`

    ªex = (x, a, b) ->
      if -1 == pos = a.indexOf x then x else b.charAt pos




#### `ªis()`
Useful for reducing CoffeeScript’s verbose conditional syntax, eg:  
`if condition then 123 else 456` becomes `ªis condition, 123, 456`. 

    ªis = (c, t=true, f=false) ->
      if c then t else f




#### `ªhas()`
Determines whether haystack contains a given needle. @todo arrays and objects

    ªhas = (h, n, t=true, f=false) ->
      if -1 != h.indexOf n then t else f




#### `ªtype()`
To detect the difference between 'null', 'array', 'regexp' and 'object' types, 
we use [Angus Croll’s one-liner](http://goo.gl/WlpBEx). This can be used in 
place of JavaScript’s familiar `typeof` operator, with one important exception: 
when the variable being tested does not exist, `typeof foobar` will return 
`undefined`, whereas `ªtype(foobar)` will throw an error. 

    ªtype = (x) ->
      ({}).toString.call(x).match(/\s([a-z0-9]+)/i)[1].toLowerCase()




#### `ªisU()`
@todo description

    ªisU = (x) ->
      ªU == typeof x




#### `ªuid()`
Xx optional prefix. @todo description

    ªuid = (p) ->
      p + '_' + (Math.random()+'1111111111111111').slice 2, 18




#### `ªinsert()`
Xx. @todo description

    ªinsert = (basis, overlay, offset) ->
      basis.slice(0, offset) + overlay + basis.slice(offset+overlay.length)




#### `ªredefine()`
- `'constant'` Enumerable but immutable

Convert a property to one of XX kinds:

    ªredefine = (obj, name, value, kind) ->
      switch kind
        when 'constant'
          Object.defineProperty obj, name, { value:value, enumerable:true }
        when 'private'
          Object.defineProperty obj, name, { value:value, enumerable:false }


    ;


