Export Module
==========

#### The module’s only entry-point is the `Proon` class

First, try defining an AMD module, eg for [RequireJS](http://requirejs.org/). 

    if ªF == typeof define and define.amd
      define -> Proon

Next, try exporting for CommonJS, eg for [Node.js](http://goo.gl/Lf84YI):  
`var Proon = require('proon');`

    else if ªO == typeof module and module and module.exports
      module.exports = Proon

Otherwise, add the `Proon` class to global scope.  
Browser usage: `var proon = new window.Proon();`

    else ªG.Proon = Proon
    ;



