01-1 DOM for non-browsers
=========================


Node
====

#### Simplified combination of the DOM’s `EventTarget` and `Node` classes

@todo EventTarget methods  
@todo describe


    class Node
      C: 'Node'
      toString: -> '[object Node]'

      constructor: (config={}) ->
        M = "/domlet/src/Node/Node-base.litcoffee
          Node()\n  "




Properties
----------


#### `childNodes <array>`
Xx. 

        @childNodes = []


#### `firstChild and lastChild <Node|null>`
Xx. 

        @firstChild = null
        @lastChild  = null


#### `parentNode <Node|null>`
Xx. 

        @parentNode = null


#### `previousSibling and nextSibling <Node|null>`
Xx. 

        @previousSibling = null
        @nextSibling     = null




Methods
-------


#### `appendChild()`
- `aChild <Node>`  the Node to append
- `<Node>`         the appended Node

Read the [MDN Article](https://goo.gl/e4S15a) for details. 

      appendChild: (aChild) ->
        M = "/domlet/src/Node/Node-base.litcoffee
          Node.appendChild()\n  "
        if ! (aChild instanceof Node) then throw TypeError "
          #{M}`achild` does not inherit from `Node`"

Move `aChild` from its previous parent. 

        aChild.parentNode?.removeChild aChild
        aChild.parentNode = @

Add `aChild` to the end of `childNodes`, and update all cross-references. 

        length = @childNodes.push aChild
        @firstChild = @childNodes[0]
        @lastChild  = aChild
        aChild.nextSibling = null
        if 1 == length
          aChild.previousSibling = null
        else
          aChild.previousSibling = @childNodes[length-2]
          aChild.previousSibling.nextSibling = aChild

`appendChild()` returns the appended Node. 

        return aChild




#### `insertBefore()`
- `newNode <Node>`        the Node to insert
- `referenceNode <Node>`  he node before which `newNode` is inserted
- `<Node>`                the inserted Node

Read the [MDN Article](https://goo.gl/LlMIQN) for details. 

      insertBefore: (newNode, referenceNode) ->
        M = "/domlet/src/Node/Node-base.litcoffee
          Node.insertBefore()\n  "
        if ! (newNode instanceof Node) then throw TypeError "
          #{M}`newNode` does not inherit from `Node`"
        if ! (referenceNode instanceof Node) then throw TypeError "
          #{M}`referenceNode` does not inherit from `Node`"

Get the index of `referenceNode`. 

        i = @childNodes.indexOf referenceNode
        if -1 == i then throw RangeError "
          #{M}`referenceNode` not found in `childNodes`"

Insert `newNode` before `referenceNode`, and update all cross-references. 

        @childNodes.splice i, 0, newNode
        @firstChild = @childNodes[0]
        @lastChild  = @childNodes[@childNodes.length-1]
        newNode.nextSibling = referenceNode
        if 0 == i
          newNode.previousSibling = null
        else
          newNode.previousSibling = referenceNode.previousSibling
          referenceNode.previousSibling.nextSibling = newNode
        referenceNode.previousSibling = newNode

Move `newNode` from its previous parent. We have finished using `i`, so it’s 
now ok if `insertBefore()` is being used to move a Node’s sibling-position.  
@todo test `insertBefore()` itself, eg `insertBefore(myNode, myNode)`

        newNode.parentNode?.removeChild newNode
        newNode.parentNode = @

`insertBefore()` returns the inserted Node. 

        return newNode




#### `removeChild()`
- `child <Node>`  the Node to remove
- `<Node>`        the removed Node

Read the [MDN Article](https://goo.gl/bsDM9b) for details. 

      removeChild: (child) ->
        M = "/domlet/src/Node/Node-base.litcoffee
          Node.removeChild()\n  "
        if ! (child instanceof Node) then throw TypeError "
          #{M}`child` does not inherit from `Node`"

Get the index of `child`. 

        i = @childNodes.indexOf child
        if -1 == i then throw RangeError "
          #{M}`child` not found in `childNodes`"

Remove `child`, and update all cross-references. 

        @childNodes.splice i, 1
        @firstChild = @childNodes[0]
        @lastChild  = @childNodes[@childNodes.length-1]
        child.previousSibling?.nextSibling = child.nextSibling
        child.nextSibling?.previousSibling = child.previousSibling

        #@todo update idLut

`child` may still be referenced elsewhere in the app, so update its properties. 

        child.parentNode      = null
        child.previousSibling = null
        child.nextSibling     = null
        return child




Node.HTMLDocument
=================

#### Simplified implementation of the DOM’s `HTMLDocument` class

@todo describe


    class Node.HTMLDocument extends Node
      C: 'Node.HTMLDocument'
      toString: -> '[object Node.HTMLDocument]'

      constructor: (tagName) ->
        M = "/domlet/src/Node/Node.HTMLDocument.litcoffee
          Node.HTMLDocument()\n  "




Properties
----------


#### `childNodes <array>`                     - always `[DocumentType, <HTML>]`
#### `firstChild <Node>`                      - always `DocumentType`
#### `lastChild <Node>`                       - always `<HTML>`
#### `parentNode <null>`                      - always `null`
#### `previousSibling and nextSibling <null>` - always `null`

@todo `DocumentType` and `<HTML>`

        super()


#### `body <HTMLElement>`
Polyfill the `document.body` element. 

        @body = new Node.HTMLElement @, 'body'


#### `idLut <object>`
Handy lookup table for element ids. 

        @idLut = {}




Inherited Methods
-----------------


#### `appendChild()`
#### `insertBefore()`
#### `removeChild()`




Methods
-------


#### `createElement()`
- `tagName <string>`  the type of element to be made, eg 'blockquote' or 'h2'
- `<HTMLElement>`     reference to the newly created element

Read the [MDN Article](https://goo.gl/nGjkTI) for details. 

      createElement: (tagName) ->
        new Node.HTMLElement @, tagName




#### `createTextNode()`
- `data <string>`  the text of the new element
- `<HTMLElement>`  reference to the newly created element

Read the [MDN Article](https://goo.gl/KxNuqf) for details. 

      createTextNode: (data) ->
        new Node.Text data




#### `querySelector()`
- `selectors <string>`  a group of selectors to match on
- `<HTMLElement|null>`  reference to the first match, or `null` if not found

Read the [MDN Article](https://goo.gl/kCl3d7) for details. 

      querySelector: (selectors) ->
        if 'body' == selectors then return @body
        #@todo implement basic selector logic
        null




#### `getElementById()`
- `id <string>`         case-sensitive, represents the element’s unique ID
- `<HTMLElement|null>`  reference to the found element, or `null` if not found

Read the [MDN Article](https://goo.gl/Bc1cGu) for details. 

      getElementById: (id) ->
        el = @idLut[id]
        if ! el or ! el.parentNode then return null #@todo remove id from `idLut` when el is deleted
        el




#### `querySelectorAll()`
- `selectors <string>`       a group of selectors to match on
- `<array of HTMLElements>`  a non-live list of element references

Read the [MDN Article](https://goo.gl/BH6U72) for details. 

      querySelectorAll: (selectors) ->
        if 'body' == selectors then return [@body]
        #@todo implement basic selector logic
        []




Node.HTMLElement
================

#### Simplified implementation of the DOM’s `HTMLElement` class

@todo describe


    class Node.HTMLElement extends Node
      C: 'Node.HTMLElement'
      toString: -> '[object Node.HTMLElement]'

      constructor: (doc, tagName) ->
        M = "/domlet/src/Node/Node.HTMLElement.litcoffee
          Node.HTMLElement()\n  "




Properties
----------


#### `childNodes <array>`
#### `firstChild and lastChild <Node|null>`
#### `parentNode <Node|null>`
#### `previousSibling and nextSibling <Node|null>`

        super()


#### `document <Node.HTMLDocument>`
@todo describe  
@todo validate  

        @document = doc


#### `attributes <object>`
@todo describe  

        @attributes = {}


#### `tagName <string>`
@todo describe  
@todo validate  

        @tagName = tagName.toUpperCase()




Methods
-------


#### `appendChild()`
#### `insertBefore()`
#### `removeChild()`


#### `insertAdjacentHTML()`
- `position <enum>`  one of: beforebegin afterbegin beforeend afterend
- `text <object>`    the HTML to insert
- `<?>`              @todo what should it return?

Xx. 

      insertAdjacentHTML: (position, text) ->
        #@todo



#### `getAttribute()`
- `attributeName <string>`   the name of the attribute, eg 'id'
- `<string|null>`            the attribute value, or null if non-existant

Read the [MDN Article](https://goo.gl/imvRSq) for details. 

      getAttribute: (attributeName) ->
        value = @attributes[attributeName]
        if ªU == typeof value then null else value




#### `setAttribute()`
- `name <string>`   the name of the attribute, eg 'id'
- `value <string>`  the value of the attribute, eg 'my-element-53'
- `<undefined>`     does not return anything

Read the [MDN Article](https://goo.gl/k0DDqQ) for details. 

      setAttribute: (name, value) ->
        @attributes[name] = ''+value # coerce to string
        if 'id' == name then @document.idLut[value] = @

        undefined




    ;

