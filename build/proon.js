// Generated by CoffeeScript 1.9.2
(function(ªG) {
/*! Proon 0.0.4 //// MIT Licence //// http://proon.richplastow.com/ */
var Proon, SomeClass, ª, ªA, ªB, ªC, ªE, ªF, ªN, ªO, ªR, ªS, ªU, ªV, ªX, ªex, ªhas, ªinsert, ªis, ªisU, ªredefine, ªtype, ªuid;

ªC = 'Proon';

ªV = '0.0.4';

SomeClass = (function() {
  SomeClass.prototype.C = 'SomeClass';

  SomeClass.prototype.toString = function() {
    return '[object SomeClass]';
  };

  function SomeClass(config) {
    var M;
    if (config == null) {
      config = {};
    }
    M = "/proon/src/SomeClass/SomeClass.litcoffee SomeClass()\n  ";
    this.x = null;
  }

  SomeClass.prototype.xx = function(yy) {
    var M;
    return M = "/proon/src/SomeClass/SomeClass.litcoffee SomeClass:xx()\n  ";
  };

  return SomeClass;

})();

SomeClass.xx = function(yy) {
  var M;
  return M = "/proon/src/SomeClass/SomeClass.litcoffee SomeClass.xx()\n  ";
};

Proon = (function() {
  Proon.prototype.C = 'Proon';

  Proon.prototype.toString = function() {
    return '[object Proon]';
  };

  function Proon(config) {
    var M, ts;
    if (config == null) {
      config = {};
    }
    M = "/proon/src/Proon.litcoffee Proon()\n  ";
    if (ªU === typeof config.object) {
      this.object = null;
    } else if (ªO !== ªtype(config.object)) {
      throw TypeError(M + "Optional `config.object` is " + (ªtype(config.object)) + " not object");
    } else {
      this.object = config.object;
    }
    ts = ªtype(config.storage);
    if (ªU === ts) {
      this.storage = null;
    } else if (ªO !== ts && 'storage' !== ts) {
      throw TypeError(M + "Optional `config.storage` is " + ts + " not object or storage");
    } else if (ªF !== typeof config.storage.setItem) {
      throw TypeError(M + "Optional `config.storage` has no `setItem()` method");
    } else {
      this.storage = config.storage;
    }
    if (ªU === typeof config.fs) {
      this.fs = null;
    } else if (ªO !== ªtype(config.fs)) {
      throw TypeError(M + "Optional `config.fs` is " + (ªtype(config.fs)) + " not object");
    } else if (ªF !== typeof config.fs.readFileSync) {
      throw TypeError(M + "Optional `config.fs` has no `readFileSync()` method");
    } else {
      this.fs = config.fs;
    }
    if (ªU === typeof config.db) {
      this.db = null;
    } else if (ªO !== ªtype(config.db)) {
      throw TypeError(M + "Optional `config.db` is " + (ªtype(config.db)) + " not object");
    } else {
      this.db = config.db;
    }
    if (ªU === typeof config.dom) {
      this.dom = null;
    } else if (ªO !== ªtype(config.dom)) {
      throw TypeError(M + "Optional `config.dom` is " + (ªtype(config.dom)) + " not object");
    } else {
      this.dom = config.dom;
    }
  }

  Proon.prototype.add = function(node) {
    var M, content, curr, i, j, k, key, l, len, len1, len2, len3, len4, m, maxLen, maxLevels, name, nameRx, o, path, pathRx, str, value;
    M = "/proon/src/Proon.litcoffee Proon:add()\n  ";
    if (ªO !== ªtype(node)) {
      throw TypeError(M + "`node` is " + (ªtype(node)) + " not object");
    }
    name = node.name;
    path = node.path;
    content = node.content;
    nameRx = /^[a-z][-a-z0-9]{0,23}$/;
    if (ªS !== typeof name) {
      throw TypeError(M + "`node.name` is " + (ªtype(name)) + " not string");
    }
    if (!nameRx.test(name)) {
      throw RangeError(M + "`node.name` fails " + nameRx);
    }
    pathRx = /^[a-z][-a-z0-9]{0,23}$/;
    maxLevels = 99;
    if (ªU === typeof path) {
      path = [];
    } else if (ªA !== ªtype(path)) {
      throw TypeError(M + "`node.path` is " + (ªtype(path)) + " not array");
    } else if (maxLevels < path.length) {
      throw RangeError(M + "`node.path.length` " + path.length + " > " + maxLevels);
    }
    for (i = j = 0, len = path.length; j < len; i = ++j) {
      str = path[i];
      if (ªS !== typeof str) {
        throw TypeError(M + "`node.path[" + i + "]` is " + (ªtype(path[i])) + " not string");
      }
      if (!pathRx.test(str)) {
        throw RangeError(M + "`node.path[" + i + "]` fails " + pathRx);
      }
    }
    maxLen = 1024 * 1024;
    if (ªU === typeof content) {
      content = '';
    } else if (ªS !== typeof content) {
      throw TypeError(M + "`node.content` is " + (ªtype(content)) + " not string");
    } else if (maxLen < content.length) {
      throw TypeError(M + "`node.content.length` " + content.length + " > " + maxLen);
    }
    if (this.object) {
      curr = this.object;
      for (i = k = 0, len1 = path.length; k < len1; i = ++k) {
        str = path[i];
        curr = curr[str];
        if (ªS === typeof curr) {
          throw RangeError(M + "`node.path[" + i + "]` '" + str + "' is already an object leaf-node");
        }
        if (ªU === typeof curr) {
          break;
        }
      }
      if (curr) {
        if (ªS === typeof curr[name]) {
          throw RangeError(M + "`node.name` '" + name + "' is already an object leaf-node");
        }
        if (ªU !== typeof curr[name]) {
          throw RangeError(M + "`node.name` '" + name + "' is already an object branch-node");
        }
      }
    }
    if (this.storage) {
      key = '/';
      value = true;
      for (i = l = 0, len2 = path.length; l < len2; i = ++l) {
        str = path[i];
        value = this.storage.getItem(key = "" + key + str);
        if (null !== value) {
          throw RangeError(M + "`node.path[" + i + "]` '" + str + "' is already a storage leaf-node");
        }
        value = this.storage.getItem(key = key + "/");
        if (null === value) {
          break;
        }
      }
      if (value) {
        value = this.storage.getItem(key = "" + key + name);
        if (null !== value) {
          throw RangeError(M + "`node.name` '" + name + "' is already a storage leaf-node");
        }
        value = this.storage.getItem(key + "/");
        if (null !== value) {
          throw RangeError(M + "`node.name` '" + name + "' is already a storage branch-node");
        }
      }
    }
    if (this.fs) {
      123;
    }
    if (this.db) {
      123;
    }
    if (this.dom) {
      123;
    }
    if (this.object) {
      curr = this.object;
      for (i = m = 0, len3 = path.length; m < len3; i = ++m) {
        str = path[i];
        if (ªU === typeof curr[str]) {
          curr[str] = {};
        }
        curr = curr[str];
      }
      curr[name] = content;
    }
    if (this.storage) {
      key = '/';
      for (i = o = 0, len4 = path.length; o < len4; i = ++o) {
        str = path[i];
        if (null === this.storage.getItem(key = "" + key + str + "/")) {
          this.storage.setItem(key, '/');
        }
      }
      key = "" + key + name;
      this.storage.setItem(key, '-' + content);
    }
    if (this.fs) {
      123;
    }
    if (this.db) {
      123;
    }
    if (this.dom) {
      123;
    }
    return this;
  };

  return Proon;

})();

Proon.xx = function(yy) {
  var M;
  return M = "/proon/src/Proon.litcoffee Proon.xx()\n  ";
};

ªA = 'array';

ªB = 'boolean';

ªE = 'error';

ªF = 'function';

ªN = 'number';

ªO = 'object';

ªR = 'regexp';

ªS = 'string';

ªU = 'undefined';

ªX = 'null';

ª = console.log.bind(console);

ªex = function(x, a, b) {
  var pos;
  if (-1 === (pos = a.indexOf(x))) {
    return x;
  } else {
    return b.charAt(pos);
  }
};

ªis = function(c, t, f) {
  if (t == null) {
    t = true;
  }
  if (f == null) {
    f = false;
  }
  if (c) {
    return t;
  } else {
    return f;
  }
};

ªhas = function(h, n, t, f) {
  if (t == null) {
    t = true;
  }
  if (f == null) {
    f = false;
  }
  if (-1 !== h.indexOf(n)) {
    return t;
  } else {
    return f;
  }
};

ªtype = function(x) {
  return {}.toString.call(x).match(/\s([a-z0-9]+)/i)[1].toLowerCase();
};

ªisU = function(x) {
  return ªU === typeof x;
};

ªuid = function(p) {
  return p + '_' + (Math.random() + '1111111111111111').slice(2, 18);
};

ªinsert = function(basis, overlay, offset) {
  return basis.slice(0, offset) + overlay + basis.slice(offset + overlay.length);
};

ªredefine = function(obj, name, value, kind) {
  switch (kind) {
    case 'constant':
      return Object.defineProperty(obj, name, {
        value: value,
        enumerable: true
      });
    case 'private':
      return Object.defineProperty(obj, name, {
        value: value,
        enumerable: false
      });
  }
};

if (ªF === typeof define && define.amd) {
  define(function() {
    return Proon;
  });
} else if (ªO === typeof module && module && module.exports) {
  module.exports = Proon;
} else {
  ªG.Proon = Proon;
}
}).call(this,this);
// Example vendor file. 
